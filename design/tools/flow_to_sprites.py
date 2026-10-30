"""Turns Google Flow clips (character on bright green) into game sprite sheets.

For each character: cuts the listed part of each clip, removes the green,
crops each animation to its own box, and packs the frames into one WebP
sheet per animation, plus a JSON file the game reads. The JSON says where
each animation's box sits relative to the idle body, so switching animations
doesn't make the character jump.

Usage: python3 design/tools/flow_to_sprites.py [character ...]
       (no arguments = every character in CHARACTERS)
Needs ffmpeg and cwebp (brew install webp) on the PATH.
"""
import json
import math
import os
import re
import subprocess
import sys
import tempfile

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
CLIPS = os.path.join(ROOT, 'design', 'flow_clips')
OUT = os.path.join(ROOT, 'frontend', 'assets', 'images', 'anim')

# How tall the idle body is in the sheets, in pixels. A fighter is about
# this tall on a phone screen, and smaller keeps two fighters' animations
# comfortably in memory on budget phones.
BODY_HEIGHT = 256

# Clip size, the biggest texture every phone can load, and the empty space
# kept around each crop
VIDEO_W, VIDEO_H = 1280, 720
MAX_TEXTURE = 4096
PAD = 6

# For each character, the animations to cut from its clips:
#   name: (clip, start seconds, end seconds, frames per second, loops[, speed])
# Times are picked by looking at the clip (see design/flow_clips/NOTES.md).
# speed plays the frames faster than they were filmed: Flow moves slowly,
# and a hit or a flinch has to be over quickly in a fight.
# Opponents: idle, windup, strike, hurt, stunned, ko.
# Pets: idle, attack, block, dodge, hurt, victory, ko.
# A missing one falls back to an effect done in code (see arena_game.dart).
CHARACTERS = {
    'opp_wild_pup': {
        'idle': ('opp_wild_pup_idle.mp4', 0.0, 7.9, 6, True),
        'windup': ('opp_wild_pup_attack.mp4', 0.7, 2.5, 8, False),
        'strike': ('opp_wild_pup_attack.mp4', 2.5, 3.7, 10, False),
        'hurt': ('opp_wild_pup_hurt.mp4', 0.75, 2.0, 8, False, 1.5),
        'stunned': ('opp_wild_pup_stunned.mp4', 2.0, 4.75, 8, True),
        'ko': ('opp_wild_pup_ko.mp4', 2.25, 3.75, 8, False),
    },
    'opp_ancient_golem': {
        'idle': ('opp_ancient_golem_idle.mp4', 0.0, 7.9, 6, True),
        'windup': ('opp_ancient_golem_attack.mp4', 0.4, 1.4, 8, False),
        'strike': ('opp_ancient_golem_attack.mp4', 1.4, 3.0, 10, False),
        'hurt': ('opp_ancient_golem_hurt.mp4', 0.75, 2.75, 8, False, 2),
        'stunned': ('opp_ancient_golem_stunned.mp4', 1.25, 4.75, 8, True),
        'ko': ('opp_ancient_golem_ko.mp4', 0.75, 4.0, 8, False, 1.5),
    },
    # No stunned or ko clip: Flow refused to make them
    'opp_shadow_beast': {
        'idle': ('opp_shadow_beast_idle.mp4', 0.0, 7.9, 6, True),
        'windup': ('opp_shadow_beast_attack.mp4', 0.25, 1.0, 8, False),
        'strike': ('opp_shadow_beast_attack.mp4', 1.0, 2.9, 10, False, 1.5),
        'hurt': ('opp_shadow_beast_hurt.mp4', 0.5, 3.0, 8, False, 2),
    },
    # No dodge: the clip hops toward the opponent, so the code's step back
    # (on the idle animation) reads better
    'pet_thunder': {
        'idle': ('pet_thunder_idle.mp4', 0.0, 7.9, 6, True),
        'attack': ('pet_thunder_attack.mp4', 1.5, 2.75, 8, False, 2),
        'block': ('pet_thunder_block.mp4', 0.75, 1.75, 8, False, 1.5),
        'hurt': ('pet_thunder_hurt.mp4', 0.5, 1.75, 8, False, 1.5),
        'victory': ('pet_thunder_victory.mp4', 1.0, 2.5, 8, True),
        'ko': ('pet_thunder_ko.mp4', 2.0, 4.75, 8, False, 1.5),
    },
}

# WebP quality (0-100). Video frames are noisy, so lossless PNG sheets come out
# around 10x bigger for no visible gain.
WEBP_QUALITY = 82

# Remove the green, then pull green tint off the edges ("despill")
KEY = 'colorkey=0x00FF00:0.30:0.08,despill=type=green,format=rgba'
# Characters that are green themselves: despill would turn the golem's moss
# and the guardian's leaves orange, so only the background is removed
KEY_GREEN_CHARACTER = 'colorkey=0x00FF00:0.30:0.08,format=rgba'
GREEN_CHARACTERS = {'opp_ancient_golem', 'opp_forest_guardian'}


def run(cmd):
    return subprocess.run(cmd, check=True, capture_output=True, text=True)


def extract(clip, start, end, fps, folder, key=KEY):
    """Cuts [start, end) of the clip into keyed RGBA PNG frames."""
    run(['ffmpeg', '-v', 'error', '-y', '-ss', str(start), '-to', str(end),
         '-i', os.path.join(CLIPS, clip),
         '-vf', f'fps={fps},{key}', os.path.join(folder, 'f%04d.png')])
    return sorted(f for f in os.listdir(folder) if f.endswith('.png'))


def alpha_bbox(folder):
    """The box (x1, y1, x2, y2) around every non-transparent pixel."""
    out = run(['ffmpeg', '-v', 'info', '-i', os.path.join(folder, 'f%04d.png'),
               '-vf', 'alphaextract,bbox=min_val=40', '-f', 'null', '-'])
    boxes = re.findall(r'x1:(\d+) x2:(\d+) y1:(\d+) y2:(\d+)', out.stderr)
    xs1, xs2, ys1, ys2 = zip(*[tuple(map(int, b)) for b in boxes])
    return min(xs1), min(ys1), max(xs2), max(ys2)


def build(character, animations):
    os.makedirs(OUT, exist_ok=True)
    with tempfile.TemporaryDirectory() as tmp:
        frames = {}
        for name, (clip, start, end, fps, *_) in animations.items():
            folder = os.path.join(tmp, name)
            os.makedirs(folder)
            key = KEY_GREEN_CHARACTER if character in GREEN_CHARACTERS else KEY
            files = extract(clip, start, end, fps, folder, key)
            frames[name] = (folder, files, alpha_bbox(folder))

        # Every animation is scaled the same, so the idle body is BODY_HEIGHT
        # pixels tall in every sheet
        ix1, iy1, ix2, iy2 = frames['idle'][2]
        scale = BODY_HEIGHT / (iy2 - iy1 + 1)
        body_x, body_y = (ix1 + ix2) / 2, (iy1 + iy2) / 2

        meta = {'bodyWidth': round((ix2 - ix1 + 1) * scale),
                'bodyHeight': BODY_HEIGHT, 'animations': {}}
        for name, (folder, files, box) in frames.items():
            _, _, _, fps, loops, *rest = animations[name]
            # Each animation is cropped to its own box (a punch or a fall
            # needs far more room than standing still), and remembers where
            # that box sits relative to the middle of the idle body
            x1, y1 = max(0, box[0] - PAD), max(0, box[1] - PAD)
            x2, y2 = min(VIDEO_W - 1, box[2] + PAD), min(VIDEO_H - 1, box[3] + PAD)
            w, h = x2 - x1 + 1, y2 - y1 + 1
            fw, fh = round(w * scale), round(h * scale)
            count = len(files)
            cols = min(count, MAX_TEXTURE // fw)
            rows = math.ceil(count / cols)
            assert rows * fh <= MAX_TEXTURE, f'{name}: too many frames'
            png = os.path.join(tmp, f'{name}_sheet.png')
            sheet = os.path.join(OUT, f'{character}_{name}.webp')
            run(['ffmpeg', '-v', 'error', '-y', '-framerate', '1',
                 '-i', os.path.join(folder, 'f%04d.png'),
                 '-vf', (f'crop={w}:{h}:{x1}:{y1},'
                         f'scale={fw}:{fh}:flags=lanczos,'
                         f'tile={cols}x{rows}:color=0x00000000'),
                 '-frames:v', '1', '-pix_fmt', 'rgba', png])
            run(['cwebp', '-quiet', '-q', str(WEBP_QUALITY), '-alpha_q', '90',
                 '-exact', png, '-o', sheet])
            meta['animations'][name] = {
                'file': f'{character}_{name}.webp', 'frames': count,
                'columns': cols, 'fps': round(fps * (rest[0] if rest else 1), 2),
                'loops': loops, 'frameWidth': fw, 'frameHeight': fh,
                'offsetX': round((x1 - body_x) * scale, 1),
                'offsetY': round((y1 - body_y) * scale, 1)}
            print(f'{character}_{name}.webp: {count} frames of {fw}x{fh}, '
                  f'{os.path.getsize(sheet) // 1024} KB, '
                  f'{count * fw * fh * 4 // 1048576} MB in memory')

        with open(os.path.join(OUT, f'{character}.json'), 'w') as f:
            json.dump(meta, f, indent=2)


if __name__ == '__main__':
    for character in sys.argv[1:] or CHARACTERS:
        build(character, CHARACTERS[character])
