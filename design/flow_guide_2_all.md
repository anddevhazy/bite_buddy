# Flow Guide 2: all the remaining animations

51 clips: the rest of the opponents, then all four pets. Every clip has its
own complete section below, so you never need to combine anything: go
down the list, follow the steps, copy the prompt, generate, check, save.

## What changed since the test

Flow always fills the full 8 seconds, so in the test Wild Pup did extra
moves after the one we asked for. The prompts below now ask for the move
**once, in the first three seconds**, then for the character to stand
still. That makes the useful part easy to cut out. If a clip still has
extra movement later on, that's fine: only the part that's needed is used.

## Before you start (once)

1. In Finder, open `bite_buddy/design/flow_inputs/`. Every character's
   picture is there on a green background, named like
   `opp_forest_guardian_green.png`. These are the only pictures you upload.
2. Open **https://labs.google/flow** in Chrome, sign in, and open the
   project you used for the test (or create a new one).
3. Every clip you finish goes into `bite_buddy/design/flow_clips/`.

**Send them in batches.** When you finish a character, tell Claude. It
puts that character's animations in the game straight away, and if
anything needs fixing you'll know before making the next character.

## Progress checklist


**Wild Pup**

- [ ] 1. Wild Pup: Hurt (`opp_wild_pup_hurt.mp4`)
- [ ] 2. Wild Pup: Stunned (`opp_wild_pup_stunned.mp4`)
- [ ] 3. Wild Pup: Knocked out (`opp_wild_pup_ko.mp4`)

**Forest Guardian**

- [ ] 4. Forest Guardian: Idle (`opp_forest_guardian_idle.mp4`)
- [ ] 5. Forest Guardian: Attack (`opp_forest_guardian_attack.mp4`)
- [ ] 6. Forest Guardian: Hurt (`opp_forest_guardian_hurt.mp4`)
- [ ] 7. Forest Guardian: Stunned (`opp_forest_guardian_stunned.mp4`)
- [ ] 8. Forest Guardian: Knocked out (`opp_forest_guardian_ko.mp4`)

**Shadow Beast**

- [ ] 9. Shadow Beast: Idle (`opp_shadow_beast_idle.mp4`)
- [ ] 10. Shadow Beast: Attack (`opp_shadow_beast_attack.mp4`)
- [ ] 11. Shadow Beast: Hurt (`opp_shadow_beast_hurt.mp4`)
- [ ] 12. Shadow Beast: Stunned (`opp_shadow_beast_stunned.mp4`)
- [ ] 13. Shadow Beast: Knocked out (`opp_shadow_beast_ko.mp4`)

**Storm Drake**

- [ ] 14. Storm Drake: Idle (`opp_storm_drake_idle.mp4`)
- [ ] 15. Storm Drake: Attack (`opp_storm_drake_attack.mp4`)
- [ ] 16. Storm Drake: Hurt (`opp_storm_drake_hurt.mp4`)
- [ ] 17. Storm Drake: Stunned (`opp_storm_drake_stunned.mp4`)
- [ ] 18. Storm Drake: Knocked out (`opp_storm_drake_ko.mp4`)

**Ancient Golem**

- [ ] 19. Ancient Golem: Idle (`opp_ancient_golem_idle.mp4`)
- [ ] 20. Ancient Golem: Attack (`opp_ancient_golem_attack.mp4`)
- [ ] 21. Ancient Golem: Hurt (`opp_ancient_golem_hurt.mp4`)
- [ ] 22. Ancient Golem: Stunned (`opp_ancient_golem_stunned.mp4`)
- [ ] 23. Ancient Golem: Knocked out (`opp_ancient_golem_ko.mp4`)

**Fluffy**

- [ ] 24. Fluffy: Idle (`pet_fluffy_idle.mp4`)
- [ ] 25. Fluffy: Attack (`pet_fluffy_attack.mp4`)
- [ ] 26. Fluffy: Block (`pet_fluffy_block.mp4`)
- [ ] 27. Fluffy: Dodge (`pet_fluffy_dodge.mp4`)
- [ ] 28. Fluffy: Hurt (`pet_fluffy_hurt.mp4`)
- [ ] 29. Fluffy: Victory (`pet_fluffy_victory.mp4`)
- [ ] 30. Fluffy: Knocked out (`pet_fluffy_ko.mp4`)

**Sparkle**

- [ ] 31. Sparkle: Idle (`pet_sparkle_idle.mp4`)
- [ ] 32. Sparkle: Attack (`pet_sparkle_attack.mp4`)
- [ ] 33. Sparkle: Block (`pet_sparkle_block.mp4`)
- [ ] 34. Sparkle: Dodge (`pet_sparkle_dodge.mp4`)
- [ ] 35. Sparkle: Hurt (`pet_sparkle_hurt.mp4`)
- [ ] 36. Sparkle: Victory (`pet_sparkle_victory.mp4`)
- [ ] 37. Sparkle: Knocked out (`pet_sparkle_ko.mp4`)

**Thunder**

- [ ] 38. Thunder: Idle (`pet_thunder_idle.mp4`)
- [ ] 39. Thunder: Attack (`pet_thunder_attack.mp4`)
- [ ] 40. Thunder: Block (`pet_thunder_block.mp4`)
- [ ] 41. Thunder: Dodge (`pet_thunder_dodge.mp4`)
- [ ] 42. Thunder: Hurt (`pet_thunder_hurt.mp4`)
- [ ] 43. Thunder: Victory (`pet_thunder_victory.mp4`)
- [ ] 44. Thunder: Knocked out (`pet_thunder_ko.mp4`)

**Mystic**

- [ ] 45. Mystic: Idle (`pet_mystic_idle.mp4`)
- [ ] 46. Mystic: Attack (`pet_mystic_attack.mp4`)
- [ ] 47. Mystic: Block (`pet_mystic_block.mp4`)
- [ ] 48. Mystic: Dodge (`pet_mystic_dodge.mp4`)
- [ ] 49. Mystic: Hurt (`pet_mystic_hurt.mp4`)
- [ ] 50. Mystic: Victory (`pet_mystic_victory.mp4`)
- [ ] 51. Mystic: Knocked out (`pet_mystic_ko.mp4`)

---

# Wild Pup (opponent)

Wild Pup is a scrappy little dog in an orange bandana. Picture to upload for every Wild Pup clip:
**`opp_wild_pup_green.png`**

(Idle and attack are already done from the test.)

## Clip 1 of 51: Wild Pup, hurt

**What it should show:** Wild Pup flinching backwards as if it has just been hit, then recovering.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `opp_wild_pup_green.png`.
   - **Second +** (end frame): **Upload** `opp_wild_pup_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character flinches backwards sharply as if hit, squeezing its eyes shut, then recovers. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Wild Pup: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the hurt happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the hurt is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_wild_pup_hurt.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 1 in the checklist at the top.

---

## Clip 2 of 51: Wild Pup, stunned

**What it should show:** Wild Pup swaying dizzily from side to side, as if seeing stars.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `opp_wild_pup_green.png`.
   - **Second +** (end frame): **Upload** `opp_wild_pup_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character sways dizzily from side to side with swirling eyes and wobbly legs, as if seeing stars. Looping. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Wild Pup: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ The movement is small and calm.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_wild_pup_stunned.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 2 in the checklist at the top.

---

## Clip 3 of 51: Wild Pup, knocked out

**What it should show:** Wild Pup toppling over and lying still, knocked out.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set the start frame only:
   - **First +** (start frame): **Upload** `opp_wild_pup_green.png`.
   - **Second +** (end frame): **leave it empty.** If an old picture is
     still there, remove it. This move ends lying down, not back at the
     start.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character topples over onto its side and lies still with swirly eyes. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Wild Pup: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ It clearly falls over and stays down.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ It gets back up again.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_wild_pup_ko.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 3 in the checklist at the top.

### Wild Pup is done

Tell Claude "Wild Pup is ready". It will turn the clips into game
animations and check them before you start the next character.

---

# Forest Guardian (opponent)

Forest Guardian is a noble golden hound in leafy armour. Picture to upload for every Forest Guardian clip:
**`opp_forest_guardian_green.png`**

## Clip 4 of 51: Forest Guardian, idle

**What it should show:** Forest Guardian standing in place, breathing and bobbing a little, ready to fight.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `opp_forest_guardian_green.png`.
   - **Second +** (end frame): **Upload** `opp_forest_guardian_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character breathes gently and bobs up and down a little, ready to fight, blinking once. Calm and looping. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Forest Guardian: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ The movement is small and calm.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_forest_guardian_idle.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 4 in the checklist at the top.

---

## Clip 5 of 51: Forest Guardian, attack

**What it should show:** Forest Guardian crouching to gather power, then attacking towards you, then returning to where it started.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `opp_forest_guardian_green.png`.
   - **Second +** (end frame): **Upload** `opp_forest_guardian_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The hound lowers its head to gather power, then charges forward towards the viewer with a headbutt, leaves swirling off its armour, then steps back. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Forest Guardian: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the attack happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the attack is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_forest_guardian_attack.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 5 in the checklist at the top.

---

## Clip 6 of 51: Forest Guardian, hurt

**What it should show:** Forest Guardian flinching backwards as if it has just been hit, then recovering.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `opp_forest_guardian_green.png`.
   - **Second +** (end frame): **Upload** `opp_forest_guardian_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character flinches backwards sharply as if hit, squeezing its eyes shut, then recovers. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Forest Guardian: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the hurt happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the hurt is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_forest_guardian_hurt.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 6 in the checklist at the top.

---

## Clip 7 of 51: Forest Guardian, stunned

**What it should show:** Forest Guardian swaying dizzily from side to side, as if seeing stars.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `opp_forest_guardian_green.png`.
   - **Second +** (end frame): **Upload** `opp_forest_guardian_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character sways dizzily from side to side with swirling eyes and wobbly legs, as if seeing stars. Looping. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Forest Guardian: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ The movement is small and calm.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_forest_guardian_stunned.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 7 in the checklist at the top.

---

## Clip 8 of 51: Forest Guardian, knocked out

**What it should show:** Forest Guardian toppling over and lying still, knocked out.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set the start frame only:
   - **First +** (start frame): **Upload** `opp_forest_guardian_green.png`.
   - **Second +** (end frame): **leave it empty.** If an old picture is
     still there, remove it. This move ends lying down, not back at the
     start.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character topples over onto its side and lies still with swirly eyes. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Forest Guardian: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ It clearly falls over and stays down.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ It gets back up again.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_forest_guardian_ko.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 8 in the checklist at the top.

### Forest Guardian is done

Tell Claude "Forest Guardian is ready". It will turn the clips into game
animations and check them before you start the next character.

---

# Shadow Beast (opponent)

Shadow Beast is a menacing black panther with smoky shadows. Picture to upload for every Shadow Beast clip:
**`opp_shadow_beast_green.png`**

## Clip 9 of 51: Shadow Beast, idle

**What it should show:** Shadow Beast standing in place, breathing and bobbing a little, ready to fight.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `opp_shadow_beast_green.png`.
   - **Second +** (end frame): **Upload** `opp_shadow_beast_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character breathes gently and bobs up and down a little, ready to fight, blinking once. Calm and looping. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Shadow Beast: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ The movement is small and calm.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_shadow_beast_idle.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 9 in the checklist at the top.

---

## Clip 10 of 51: Shadow Beast, attack

**What it should show:** Shadow Beast crouching to gather power, then attacking towards you, then returning to where it started.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `opp_shadow_beast_green.png`.
   - **Second +** (end frame): **Upload** `opp_shadow_beast_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The panther crouches low to gather power, then leaps forward towards the viewer and slashes its claws, leaving a trail of dark smoke, then lands back in place. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Shadow Beast: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the attack happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the attack is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_shadow_beast_attack.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 10 in the checklist at the top.

---

## Clip 11 of 51: Shadow Beast, hurt

**What it should show:** Shadow Beast flinching backwards as if it has just been hit, then recovering.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `opp_shadow_beast_green.png`.
   - **Second +** (end frame): **Upload** `opp_shadow_beast_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character flinches backwards sharply as if hit, squeezing its eyes shut, then recovers. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Shadow Beast: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the hurt happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the hurt is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_shadow_beast_hurt.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 11 in the checklist at the top.

---

## Clip 12 of 51: Shadow Beast, stunned

**What it should show:** Shadow Beast swaying dizzily from side to side, as if seeing stars.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `opp_shadow_beast_green.png`.
   - **Second +** (end frame): **Upload** `opp_shadow_beast_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character sways dizzily from side to side with swirling eyes and wobbly legs, as if seeing stars. Looping. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Shadow Beast: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ The movement is small and calm.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_shadow_beast_stunned.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 12 in the checklist at the top.

---

## Clip 13 of 51: Shadow Beast, knocked out

**What it should show:** Shadow Beast toppling over and lying still, knocked out.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set the start frame only:
   - **First +** (start frame): **Upload** `opp_shadow_beast_green.png`.
   - **Second +** (end frame): **leave it empty.** If an old picture is
     still there, remove it. This move ends lying down, not back at the
     start.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character topples over onto its side and lies still with swirly eyes. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Shadow Beast: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ It clearly falls over and stays down.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ It gets back up again.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_shadow_beast_ko.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 13 in the checklist at the top.

### Shadow Beast is done

Tell Claude "Shadow Beast is ready". It will turn the clips into game
animations and check them before you start the next character.

---

# Storm Drake (opponent)

Storm Drake is a fierce blue dragon crackling with lightning. Picture to upload for every Storm Drake clip:
**`opp_storm_drake_green.png`**

## Clip 14 of 51: Storm Drake, idle

**What it should show:** Storm Drake standing in place, breathing and bobbing a little, ready to fight.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `opp_storm_drake_green.png`.
   - **Second +** (end frame): **Upload** `opp_storm_drake_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character breathes gently and bobs up and down a little, ready to fight, blinking once. Calm and looping. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Storm Drake: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ The movement is small and calm.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_storm_drake_idle.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 14 in the checklist at the top.

---

## Clip 15 of 51: Storm Drake, attack

**What it should show:** Storm Drake crouching to gather power, then attacking towards you, then returning to where it started.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `opp_storm_drake_green.png`.
   - **Second +** (end frame): **Upload** `opp_storm_drake_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The dragon rears up to gather power, then breathes a short burst of blue lightning towards the viewer, then settles back. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Storm Drake: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the attack happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the attack is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_storm_drake_attack.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 15 in the checklist at the top.

---

## Clip 16 of 51: Storm Drake, hurt

**What it should show:** Storm Drake flinching backwards as if it has just been hit, then recovering.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `opp_storm_drake_green.png`.
   - **Second +** (end frame): **Upload** `opp_storm_drake_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character flinches backwards sharply as if hit, squeezing its eyes shut, then recovers. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Storm Drake: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the hurt happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the hurt is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_storm_drake_hurt.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 16 in the checklist at the top.

---

## Clip 17 of 51: Storm Drake, stunned

**What it should show:** Storm Drake swaying dizzily from side to side, as if seeing stars.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `opp_storm_drake_green.png`.
   - **Second +** (end frame): **Upload** `opp_storm_drake_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character sways dizzily from side to side with swirling eyes and wobbly legs, as if seeing stars. Looping. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Storm Drake: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ The movement is small and calm.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_storm_drake_stunned.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 17 in the checklist at the top.

---

## Clip 18 of 51: Storm Drake, knocked out

**What it should show:** Storm Drake toppling over and lying still, knocked out.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set the start frame only:
   - **First +** (start frame): **Upload** `opp_storm_drake_green.png`.
   - **Second +** (end frame): **leave it empty.** If an old picture is
     still there, remove it. This move ends lying down, not back at the
     start.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character topples over onto its side and lies still with swirly eyes. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Storm Drake: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ It clearly falls over and stays down.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ It gets back up again.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_storm_drake_ko.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 18 in the checklist at the top.

### Storm Drake is done

Tell Claude "Storm Drake is ready". It will turn the clips into game
animations and check them before you start the next character.

---

# Ancient Golem (opponent)

Ancient Golem is a huge mossy stone golem with glowing runes. Picture to upload for every Ancient Golem clip:
**`opp_ancient_golem_green.png`**

## Clip 19 of 51: Ancient Golem, idle

**What it should show:** Ancient Golem standing in place, breathing and bobbing a little, ready to fight.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `opp_ancient_golem_green.png`.
   - **Second +** (end frame): **Upload** `opp_ancient_golem_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character breathes gently and bobs up and down a little, ready to fight, blinking once. Calm and looping. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Ancient Golem: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ The movement is small and calm.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_ancient_golem_idle.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 19 in the checklist at the top.

---

## Clip 20 of 51: Ancient Golem, attack

**What it should show:** Ancient Golem crouching to gather power, then attacking towards you, then returning to where it started.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `opp_ancient_golem_green.png`.
   - **Second +** (end frame): **Upload** `opp_ancient_golem_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The golem pulls back its huge stone fist to gather power, then swings it forward towards the viewer, its runes flaring bright, then pulls back. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Ancient Golem: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the attack happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the attack is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_ancient_golem_attack.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 20 in the checklist at the top.

---

## Clip 21 of 51: Ancient Golem, hurt

**What it should show:** Ancient Golem flinching backwards as if it has just been hit, then recovering.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `opp_ancient_golem_green.png`.
   - **Second +** (end frame): **Upload** `opp_ancient_golem_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character flinches backwards sharply as if hit, squeezing its eyes shut, then recovers. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Ancient Golem: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the hurt happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the hurt is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_ancient_golem_hurt.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 21 in the checklist at the top.

---

## Clip 22 of 51: Ancient Golem, stunned

**What it should show:** Ancient Golem swaying dizzily from side to side, as if seeing stars.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `opp_ancient_golem_green.png`.
   - **Second +** (end frame): **Upload** `opp_ancient_golem_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character sways dizzily from side to side with swirling eyes and wobbly legs, as if seeing stars. Looping. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Ancient Golem: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ The movement is small and calm.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_ancient_golem_stunned.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 22 in the checklist at the top.

---

## Clip 23 of 51: Ancient Golem, knocked out

**What it should show:** Ancient Golem toppling over and lying still, knocked out.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set the start frame only:
   - **First +** (start frame): **Upload** `opp_ancient_golem_green.png`.
   - **Second +** (end frame): **leave it empty.** If an old picture is
     still there, remove it. This move ends lying down, not back at the
     start.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character topples over onto its side and lies still with swirly eyes. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Ancient Golem: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ It clearly falls over and stays down.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ It gets back up again.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`opp_ancient_golem_ko.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 23 in the checklist at the top.

### Ancient Golem is done

Tell Claude "Ancient Golem is ready". It will turn the clips into game
animations and check them before you start the next character.

---

# Fluffy (your buddy)

Fluffy is a little green baby dragon. Picture to upload for every Fluffy clip:
**`pet_fluffy_green.png`**

## Clip 24 of 51: Fluffy, idle

**What it should show:** Fluffy standing in place, breathing and bobbing a little, looking brave and ready.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_fluffy_green.png`.
   - **Second +** (end frame): **Upload** `pet_fluffy_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character breathes gently and bobs a little, looking brave and ready, blinking once. Calm and looping. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Fluffy: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ The movement is small and calm.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_fluffy_idle.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 24 in the checklist at the top.

---

## Clip 25 of 51: Fluffy, attack

**What it should show:** Fluffy leaping forward with its special attack, then returning to where it started.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_fluffy_green.png`.
   - **Second +** (end frame): **Upload** `pet_fluffy_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The little dragon crouches to gather power, then leaps forward and puffs a small burst of flame, then hops back. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Fluffy: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the attack happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the attack is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_fluffy_attack.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 25 in the checklist at the top.

---

## Clip 26 of 51: Fluffy, block

**What it should show:** Fluffy bracing and raising its front paws in front of its face to guard, then lowering them.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_fluffy_green.png`.
   - **Second +** (end frame): **Upload** `pet_fluffy_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character braces and raises its front paws in front of its face to guard, holds it for a moment, then lowers them. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Fluffy: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the block happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the block is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_fluffy_block.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 26 in the checklist at the top.

---

## Clip 27 of 51: Fluffy, dodge

**What it should show:** Fluffy hopping quickly to one side, then hopping back to the centre.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_fluffy_green.png`.
   - **Second +** (end frame): **Upload** `pet_fluffy_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character hops quickly to the side, then hops back to the centre. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Fluffy: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the dodge happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the dodge is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_fluffy_dodge.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 27 in the checklist at the top.

---

## Clip 28 of 51: Fluffy, hurt

**What it should show:** Fluffy flinching backwards as if it has just been hit, then shaking it off.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_fluffy_green.png`.
   - **Second +** (end frame): **Upload** `pet_fluffy_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character flinches backwards as if hit, then shakes it off. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Fluffy: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the hurt happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the hurt is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_fluffy_hurt.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 28 in the checklist at the top.

---

## Clip 29 of 51: Fluffy, victory

**What it should show:** Fluffy jumping up happily and cheering, then landing.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_fluffy_green.png`.
   - **Second +** (end frame): **Upload** `pet_fluffy_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character jumps up happily and cheers, then lands. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Fluffy: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the victory happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the victory is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_fluffy_victory.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 29 in the checklist at the top.

---

## Clip 30 of 51: Fluffy, knocked out

**What it should show:** Fluffy toppling over and lying still, knocked out.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set the start frame only:
   - **First +** (start frame): **Upload** `pet_fluffy_green.png`.
   - **Second +** (end frame): **leave it empty.** If an old picture is
     still there, remove it. This move ends lying down, not back at the
     start.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character topples over and lies still with swirly eyes. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Fluffy: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ It clearly falls over and stays down.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ It gets back up again.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_fluffy_ko.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 30 in the checklist at the top.

### Fluffy is done

Tell Claude "Fluffy is ready". It will turn the clips into game
animations and check them before you start the next character.

---

# Sparkle (your buddy)

Sparkle is a fluffy fox with glowing crystal shards on its tail. Picture to upload for every Sparkle clip:
**`pet_sparkle_green.png`**

## Clip 31 of 51: Sparkle, idle

**What it should show:** Sparkle standing in place, breathing and bobbing a little, looking brave and ready.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_sparkle_green.png`.
   - **Second +** (end frame): **Upload** `pet_sparkle_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character breathes gently and bobs a little, looking brave and ready, blinking once. Calm and looping. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Sparkle: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ The movement is small and calm.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_sparkle_idle.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 31 in the checklist at the top.

---

## Clip 32 of 51: Sparkle, attack

**What it should show:** Sparkle leaping forward with its special attack, then returning to where it started.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_sparkle_green.png`.
   - **Second +** (end frame): **Upload** `pet_sparkle_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The fox crouches to gather power, then spins and whips its glowing crystal tail forward, scattering sparkles, then lands back. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Sparkle: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the attack happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the attack is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_sparkle_attack.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 32 in the checklist at the top.

---

## Clip 33 of 51: Sparkle, block

**What it should show:** Sparkle bracing and raising its front paws in front of its face to guard, then lowering them.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_sparkle_green.png`.
   - **Second +** (end frame): **Upload** `pet_sparkle_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character braces and raises its front paws in front of its face to guard, holds it for a moment, then lowers them. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Sparkle: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the block happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the block is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_sparkle_block.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 33 in the checklist at the top.

---

## Clip 34 of 51: Sparkle, dodge

**What it should show:** Sparkle hopping quickly to one side, then hopping back to the centre.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_sparkle_green.png`.
   - **Second +** (end frame): **Upload** `pet_sparkle_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character hops quickly to the side, then hops back to the centre. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Sparkle: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the dodge happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the dodge is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_sparkle_dodge.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 34 in the checklist at the top.

---

## Clip 35 of 51: Sparkle, hurt

**What it should show:** Sparkle flinching backwards as if it has just been hit, then shaking it off.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_sparkle_green.png`.
   - **Second +** (end frame): **Upload** `pet_sparkle_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character flinches backwards as if hit, then shakes it off. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Sparkle: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the hurt happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the hurt is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_sparkle_hurt.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 35 in the checklist at the top.

---

## Clip 36 of 51: Sparkle, victory

**What it should show:** Sparkle jumping up happily and cheering, then landing.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_sparkle_green.png`.
   - **Second +** (end frame): **Upload** `pet_sparkle_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character jumps up happily and cheers, then lands. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Sparkle: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the victory happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the victory is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_sparkle_victory.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 36 in the checklist at the top.

---

## Clip 37 of 51: Sparkle, knocked out

**What it should show:** Sparkle toppling over and lying still, knocked out.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set the start frame only:
   - **First +** (start frame): **Upload** `pet_sparkle_green.png`.
   - **Second +** (end frame): **leave it empty.** If an old picture is
     still there, remove it. This move ends lying down, not back at the
     start.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character topples over and lies still with swirly eyes. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Sparkle: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ It clearly falls over and stays down.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ It gets back up again.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_sparkle_ko.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 37 in the checklist at the top.

### Sparkle is done

Tell Claude "Sparkle is ready". It will turn the clips into game
animations and check them before you start the next character.

---

# Thunder (your buddy)

Thunder is a young storm-blue wolf with lightning markings. Picture to upload for every Thunder clip:
**`pet_thunder_green.png`**

## Clip 38 of 51: Thunder, idle

**What it should show:** Thunder standing in place, breathing and bobbing a little, looking brave and ready.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_thunder_green.png`.
   - **Second +** (end frame): **Upload** `pet_thunder_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character breathes gently and bobs a little, looking brave and ready, blinking once. Calm and looping. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Thunder: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ The movement is small and calm.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_thunder_idle.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 38 in the checklist at the top.

---

## Clip 39 of 51: Thunder, attack

**What it should show:** Thunder leaping forward with its special attack, then returning to where it started.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_thunder_green.png`.
   - **Second +** (end frame): **Upload** `pet_thunder_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The wolf crouches to gather power, then pounces forward with crackling lightning on its paws, then springs back. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Thunder: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the attack happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the attack is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_thunder_attack.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 39 in the checklist at the top.

---

## Clip 40 of 51: Thunder, block

**What it should show:** Thunder bracing and raising its front paws in front of its face to guard, then lowering them.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_thunder_green.png`.
   - **Second +** (end frame): **Upload** `pet_thunder_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character braces and raises its front paws in front of its face to guard, holds it for a moment, then lowers them. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Thunder: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the block happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the block is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_thunder_block.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 40 in the checklist at the top.

---

## Clip 41 of 51: Thunder, dodge

**What it should show:** Thunder hopping quickly to one side, then hopping back to the centre.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_thunder_green.png`.
   - **Second +** (end frame): **Upload** `pet_thunder_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character hops quickly to the side, then hops back to the centre. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Thunder: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the dodge happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the dodge is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_thunder_dodge.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 41 in the checklist at the top.

---

## Clip 42 of 51: Thunder, hurt

**What it should show:** Thunder flinching backwards as if it has just been hit, then shaking it off.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_thunder_green.png`.
   - **Second +** (end frame): **Upload** `pet_thunder_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character flinches backwards as if hit, then shakes it off. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Thunder: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the hurt happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the hurt is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_thunder_hurt.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 42 in the checklist at the top.

---

## Clip 43 of 51: Thunder, victory

**What it should show:** Thunder jumping up happily and cheering, then landing.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_thunder_green.png`.
   - **Second +** (end frame): **Upload** `pet_thunder_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character jumps up happily and cheers, then lands. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Thunder: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the victory happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the victory is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_thunder_victory.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 43 in the checklist at the top.

---

## Clip 44 of 51: Thunder, knocked out

**What it should show:** Thunder toppling over and lying still, knocked out.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set the start frame only:
   - **First +** (start frame): **Upload** `pet_thunder_green.png`.
   - **Second +** (end frame): **leave it empty.** If an old picture is
     still there, remove it. This move ends lying down, not back at the
     start.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character topples over and lies still with swirly eyes. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Thunder: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ It clearly falls over and stays down.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ It gets back up again.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_thunder_ko.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 44 in the checklist at the top.

### Thunder is done

Tell Claude "Thunder is ready". It will turn the clips into game
animations and check them before you start the next character.

---

# Mystic (your buddy)

Mystic is a dark purple cat with starry fur and glowing eyes. Picture to upload for every Mystic clip:
**`pet_mystic_green.png`**

## Clip 45 of 51: Mystic, idle

**What it should show:** Mystic standing in place, breathing and bobbing a little, looking brave and ready.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_mystic_green.png`.
   - **Second +** (end frame): **Upload** `pet_mystic_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character breathes gently and bobs a little, looking brave and ready, blinking once. Calm and looping. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Mystic: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ The movement is small and calm.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_mystic_idle.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 45 in the checklist at the top.

---

## Clip 46 of 51: Mystic, attack

**What it should show:** Mystic leaping forward with its special attack, then returning to where it started.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_mystic_green.png`.
   - **Second +** (end frame): **Upload** `pet_mystic_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The cat crouches to gather power, then swipes a paw forward, leaving a streak of glowing violet magic, then settles back. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Mystic: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the attack happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the attack is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_mystic_attack.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 46 in the checklist at the top.

---

## Clip 47 of 51: Mystic, block

**What it should show:** Mystic bracing and raising its front paws in front of its face to guard, then lowering them.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_mystic_green.png`.
   - **Second +** (end frame): **Upload** `pet_mystic_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character braces and raises its front paws in front of its face to guard, holds it for a moment, then lowers them. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Mystic: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the block happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the block is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_mystic_block.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 47 in the checklist at the top.

---

## Clip 48 of 51: Mystic, dodge

**What it should show:** Mystic hopping quickly to one side, then hopping back to the centre.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_mystic_green.png`.
   - **Second +** (end frame): **Upload** `pet_mystic_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character hops quickly to the side, then hops back to the centre. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Mystic: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the dodge happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the dodge is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_mystic_dodge.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 48 in the checklist at the top.

---

## Clip 49 of 51: Mystic, hurt

**What it should show:** Mystic flinching backwards as if it has just been hit, then shaking it off.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_mystic_green.png`.
   - **Second +** (end frame): **Upload** `pet_mystic_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character flinches backwards as if hit, then shakes it off. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Mystic: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the hurt happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the hurt is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_mystic_hurt.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 49 in the checklist at the top.

---

## Clip 50 of 51: Mystic, victory

**What it should show:** Mystic jumping up happily and cheering, then landing.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set both frames, even if old ones are still showing:
   - **First +** (start frame): **Upload** `pet_mystic_green.png`.
   - **Second +** (end frame): **Upload** `pet_mystic_green.png` again.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character jumps up happily and cheers, then lands. The move happens only once, within the first three seconds. After that the character returns to its starting pose and stays there calmly, breathing gently, until the end of the video. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Mystic: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ You can clearly see the victory happen, early in the video.
- ✅ It comes back to roughly where and how it started.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ You can't tell what the victory is, or it only happens near the very end.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_mystic_victory.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 50 in the checklist at the top.

---

## Clip 51 of 51: Mystic, knocked out

**What it should show:** Mystic toppling over and lying still, knocked out.

### Steps

1. In the prompt box, open the mode menu (the arrow next to the mode
   name) and make sure **Frames to Video** is selected.
2. Set the start frame only:
   - **First +** (start frame): **Upload** `pet_mystic_green.png`.
   - **Second +** (end frame): **leave it empty.** If an old picture is
     still there, remove it. This move ends lying down, not back at the
     start.
3. Leave the **camera** button alone.
4. Delete any old prompt, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character topples over and lies still with swirly eyes. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation.
   ```

5. Click **Generate** and wait (a minute or two).
6. Play both versions Flow gives you.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Mystic: same colours, same design.
- ✅ It stays in the middle of the frame (coming closer during an attack is fine).
- ✅ The background stays plain green from start to end.
- ✅ It clearly falls over and stays down.

Generate again (step 5) if you see any of these:

- ❌ The character changes: different colours, extra legs, a new art style.
- ❌ The whole picture zooms or the camera moves.
- ❌ Anything appears on the green: shadows, a floor, grass, dust clouds, sparkles spreading across the background.
- ❌ The character leaves the frame or gets cut off at the edge.
- ❌ It gets back up again.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly: **`pet_mystic_ko.mp4`**
3. Move it into `bite_buddy/design/flow_clips/`.
4. Tick clip 51 in the checklist at the top.

### Mystic is done

Tell Claude "Mystic is ready". It will turn the clips into game
animations and check them before you start the next character.

---

# If Flow looks different from this guide

Flow's screens change from time to time. If you can't find something:

- **No "Frames to Video":** look for "Image to Video" or a picture icon in
  the prompt box; anything that lets you upload a start image works.
- **No second + for the end frame:** just use the start frame. Claude can
  still make the clip loop.
- **Can't choose a mode at all:** check the model menu in the prompt box;
  some Veo versions don't support frames. Pick another one.

Or take a screenshot and send it to Claude.
