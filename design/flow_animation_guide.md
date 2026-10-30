# Animating the characters with Google Flow

How to turn each character's picture into short animation clips for the
battle arena. You make the clips in Flow; Claude turns them into game
animations (removes the green, trims, and packs the frames).

**Start with the Wild Pup test (step 0) before making everything.**

## What you need

- Google Flow: https://labs.google/flow (needs a Google AI plan or Flow's free
  credits; check the model menu for the Veo versions your account has).
- The start images in `design/flow_inputs/`: every character centred on a
  plain green background, already prepared. Upload these, not the transparent
  originals.
- Save each finished clip to `design/flow_clips/`, named exactly as in the
  tables below (for example `opp_wild_pup_attack.mp4`).

## Step 0: the test (Wild Pup, 2 clips)

Make `opp_wild_pup_idle.mp4` and `opp_wild_pup_attack.mp4` (prompts below),
drop them in `design/flow_clips/`, and tell Claude. You'll see them in the
game before committing to the other ~55 clips.

## How to make one clip

1. Open Flow and create a project (one project for all the clips is fine).
2. In the prompt box, open the mode menu (the arrow next to "Text to Video")
   and choose **Frames to Video**.
3. **Start frame:** click the first **+**, choose **Upload**, and pick the
   character's image from `design/flow_inputs/`.
4. **End frame** (the tables say which moves need one):
   - **Same image again** for moves that should come back to the starting
     pose (idle, attack, hurt, and so on). The clip then starts and ends on
     the same frame, so it loops or blends back into idle smoothly.
   - **None** for knocked out (it ends lying down).
5. **Camera:** leave the camera controls off. The camera must not move.
6. Paste the prompt: the **base prompt** below, with the move's action in
   place of `[ACTION]`.
7. Generate. Flow usually gives two versions; pick the one where the
   character looks most like the original and the background stays solid
   green. If neither does, generate again.
8. Download the clip at the highest quality offered and rename it as in the
   table.

Clips come out around 8 seconds long. That's fine: Claude cuts out just the
move. Flow adds audio too; it isn't used.

## The base prompt

> Animate this exact character on a solid flat bright green (#00FF00)
> background. [ACTION] The character stays in the centre of the frame at the
> same size, with exactly the same design, colours and art style as the
> picture. Static, locked-off camera: no zoom, no pan, no camera movement.
> Keep the background plain green the whole time: no other objects, no
> shadows, no text, no effects that cover the background. Smooth, bouncy
> cartoon game animation.

For moves with an end frame, add: *The character finishes back in exactly its
starting pose.*

## Opponents: 6 moves each (30 clips)

Use each character's own action line where one is given; it makes the
attacks look different.

| Move | File ends with | End frame | [ACTION] |
|---|---|---|---|
| Idle | `_idle.mp4` | Same image | The character breathes gently and bobs up and down a little, ready to fight, blinking once. Calm and looping. |
| Wind-up | `_windup.mp4` | Same image | The character rears back and crouches, gathering power, eyes narrowing, about to strike, then relaxes again. |
| Attack | `_attack.mp4` | Same image | (see below) |
| Hurt | `_hurt.mp4` | Same image | The character flinches backwards sharply as if hit, squeezing its eyes shut, then recovers. |
| Stunned | `_stunned.mp4` | Same image | The character sways dizzily from side to side with swirling eyes and wobbly legs. Looping. |
| Knocked out | `_ko.mp4` | None | The character topples over onto its side and lies still with swirly eyes. |

Attack actions:

| Opponent | Files start with | Attack [ACTION] |
|---|---|---|
| Wild Pup | `opp_wild_pup` | The pup lunges forward towards the viewer and snaps its jaws, then hops back. |
| Forest Guardian | `opp_forest_guardian` | The hound charges forward towards the viewer with a headbutt, leaves swirling off its armour, then steps back. |
| Shadow Beast | `opp_shadow_beast` | The panther leaps forward towards the viewer and slashes its claws, leaving a trail of dark smoke, then lands back in place. |
| Storm Drake | `opp_storm_drake` | The dragon rears up and breathes a short burst of blue lightning towards the viewer, then settles back. |
| Ancient Golem | `opp_ancient_golem` | The golem swings a huge stone fist forward towards the viewer, its runes flaring bright, then pulls back. |

## Pets: 7 moves each (28 clips)

Your buddy is shown facing the viewer in the arena, like in its picture.

| Move | File ends with | End frame | [ACTION] |
|---|---|---|---|
| Idle | `_idle.mp4` | Same image | The character breathes gently and bobs a little, looking brave and ready. Looping. |
| Attack | `_attack.mp4` | Same image | (see below) |
| Block | `_block.mp4` | Same image | The character braces and raises its front paws in front of its face to guard, holds it, then lowers them. |
| Dodge | `_dodge.mp4` | Same image | The character hops quickly to the side, then hops back to the centre. |
| Hurt | `_hurt.mp4` | Same image | The character flinches backwards as if hit, then shakes it off. |
| Victory | `_victory.mp4` | Same image | The character jumps up happily and cheers, then lands. |
| Knocked out | `_ko.mp4` | None | The character topples over and lies still with swirly eyes. |

Attack actions:

| Pet | Files start with | Attack [ACTION] |
|---|---|---|
| Fluffy (Dragon Pup) | `pet_fluffy` | The little dragon leaps forward and puffs a small burst of flame, then hops back. |
| Sparkle (Crystal Fox) | `pet_sparkle` | The fox spins and whips its glowing crystal tail forward, scattering sparkles, then lands back. |
| Thunder (Storm Wolf) | `pet_thunder` | The wolf pounces forward with crackling lightning on its paws, then springs back. |
| Mystic (Shadow Cat) | `pet_mystic` | The cat swipes a paw forward, leaving a streak of glowing violet magic, then settles back. |

## Tips

- **One move per clip.** Don't ask for several moves in one prompt.
- **If the character changes** (different colours, extra limbs, a new art
  style), regenerate. Starting from the same image keeps this rare.
- **If the background stops being plain green** (shadows, a floor, sparkles
  across it), regenerate or remove effects words from the action.
- **Effects** like lightning or smoke are fine if they stay close to the
  character. Effects that fill the whole frame can't be cut out cleanly.
- You don't need every clip at once. Any move without a clip falls back to
  the current animated picture, so they can arrive gradually.
