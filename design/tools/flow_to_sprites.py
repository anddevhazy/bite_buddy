"""Turns Google Flow clips (character on bright green) into game sprite sheets.

For each character: cuts the listed part of each clip, removes the green,
crops every animation to the same box (so switching animations doesn't make
the character jump), and packs the frames into one PNG per animation, plus a
JSON file the game reads.

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

# Frame height in the sheets. Tall enough to look sharp on a phone, small
# enough that two fighters' animations fit comfortably in memory.
FRAME_HEIGHT = 320

# For each character, the animations to cut from its clips:
#   name: (clip, start seconds, end seconds, frames per second, loops)
# Times are picked by looking at the clip (see design/flow_clips/NOTES.md).
CHARACTERS = {
    'opp_wild_pup': {
        'idle': ('opp_wild_pup_idle.mp4', 0.0, 7.9, 8, True),
        'windup': ('opp_wild_pup_attack.mp4', 0.7, 2.5, 10, False),
        'strike': ('opp_wild_pup_attack.mp4', 2.5, 3.7, 12, False),
    },
}

# WebP quality (0-100). Video frames are noisy, so lossless PNG sheets come out
# around 10x bigger for no visible gain.
WEBP_QUALITY = 82

# Remove the green, then pull green tint off the edges ("despill")
KEY = 'colorkey=0x00FF00:0.30:0.08,despill=type=green,format=rgba'


def run(cmd):
    return subprocess.run(cmd, check=True, capture_output=True, text=True)


def extract(clip, start, end, fps, folder):
    """Cuts [start, end) of the clip into keyed RGBA PNG frames."""
    run(['ffmpeg', '-v', 'error', '-y', '-ss', str(start), '-to', str(end),
         '-i', os.path.join(CLIPS, clip),
         '-vf', f'fps={fps},{KEY}', os.path.join(folder, 'f%04d.png')])
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
        for name, (clip, start, end, fps, _) in animations.items():
            folder = os.path.join(tmp, name)
            os.makedirs(folder)
            frames[name] = (folder, extract(clip, start, end, fps, folder))

        # One box for all animations, with a little padding
        boxes = [alpha_bbox(folder) for folder, _ in frames.values()]
        x1 = min(b[0] for b in boxes)
        y1 = min(b[1] for b in boxes)
        x2 = max(b[2] for b in boxes)
        y2 = max(b[3] for b in boxes)
        pad = 8
        x1, y1 = max(0, x1 - pad), max(0, y1 - pad)
        w, h = x2 - x1 + 1 + pad, y2 - y1 + 1 + pad
        frame_w = round(w * FRAME_HEIGHT / h)

        meta = {'frameWidth': frame_w, 'frameHeight': FRAME_HEIGHT,
                'animations': {}}
        for name, (folder, files) in frames.items():
            _, _, _, fps, loops = animations[name]
            count = len(files)
            cols = min(count, 8)
            rows = math.ceil(count / cols)
            png = os.path.join(tmp, f'{name}_sheet.png')
            sheet = os.path.join(OUT, f'{character}_{name}.webp')
            run(['ffmpeg', '-v', 'error', '-y', '-framerate', '1',
                 '-i', os.path.join(folder, 'f%04d.png'),
                 '-vf', (f'crop={w}:{h}:{x1}:{y1},'
                         f'scale={frame_w}:{FRAME_HEIGHT}:flags=lanczos,'
                         f'tile={cols}x{rows}:color=0x00000000'),
                 '-frames:v', '1', '-pix_fmt', 'rgba', png])
            run(['cwebp', '-quiet', '-q', str(WEBP_QUALITY), '-alpha_q', '90',
                 '-exact', png, '-o', sheet])
            meta['animations'][name] = {
                'file': f'{character}_{name}.webp', 'frames': count,
                'columns': cols, 'fps': fps, 'loops': loops}
            print(f'{character}_{name}.webp: {count} frames, {cols}x{rows}, '
                  f'{os.path.getsize(sheet) // 1024} KB')

        with open(os.path.join(OUT, f'{character}.json'), 'w') as f:
            json.dump(meta, f, indent=2)


if __name__ == '__main__':
    for character in sys.argv[1:] or CHARACTERS:
        build(character, CHARACTERS[character])
