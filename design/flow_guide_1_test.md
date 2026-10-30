# Flow Guide 1: the Wild Pup test (2 clips)

You'll make two short videos of Wild Pup in Google Flow: one of it idling,
one of it attacking. Claude then turns them into game animations so you can
see them on your phone before making the rest.

You'll need about 15–20 minutes.

---

## Before you start

1. On your Mac, open Finder and go to:
   `bite_buddy/design/flow_inputs/`
2. Find the file **`opp_wild_pup_green.png`**. It's Wild Pup on a plain
   bright green background. This is the only picture you'll upload.
3. Open **https://labs.google/flow** in Chrome and sign in with your Google
   account.
4. Click **New project**. Name it anything, e.g. "Bite Buddy animations".

---

## Clip 1 of 2: Wild Pup idle

**What it should show:** Wild Pup standing still, breathing and bobbing a
little, like it's waiting to fight.

### Steps

1. In the box at the bottom of the project, find the mode menu. It's the
   small **arrow next to "Text to Video"**. Click it and choose
   **Frames to Video**.
2. Two **+** boxes appear next to the prompt box.
   - Click the **first +** (the start frame), choose **Upload**, and pick
     `opp_wild_pup_green.png`.
   - Click the **second +** (the end frame), choose **Upload**, and pick
     **the same file again**, `opp_wild_pup_green.png`.

   Using the same picture for both makes the clip start and end in the same
   pose, so it can loop smoothly in the game.
3. If you see a **camera** button, leave it alone. The camera must not move.
4. Click in the prompt box and paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The character breathes gently and bobs up and down a little, ready to fight, blinking once. Calm and looping. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click the **Generate** button (the arrow at the right of the prompt
   box). Wait. It can take a minute or two.
6. Flow usually gives you **two versions**. Play both.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Wild Pup: same colours, same orange bandana.
- ✅ The pup stays in the middle, about the same size the whole time.
- ✅ The background stays plain green from start to end.
- ✅ The movement is small and calm.

Generate again (step 5) if you see any of these:

- ❌ The pup changes: different colours, extra legs, a new art style.
- ❌ The camera zooms in or moves.
- ❌ Shadows, a floor, grass or sparkles appear on the green.
- ❌ The pup walks out of the middle or off the screen.

Don't worry about the clip being longer than the movement, or about the
sound Flow adds. Claude trims the video and doesn't use the sound.

### Save it

1. Open the version you're keeping and click **Download**. Choose the
   highest quality offered.
2. Rename the downloaded file to exactly:
   **`opp_wild_pup_idle.mp4`**
3. Move it into:
   `bite_buddy/design/flow_clips/`

---

## Clip 2 of 2: Wild Pup attack

**What it should show:** Wild Pup lunging at you, snapping its jaws, then
hopping back to where it started.

### Steps

1. Make sure the mode is still **Frames to Video** (the arrow next to the
   mode name). If it switched back, choose **Frames to Video** again.
2. Set both frames again, even if the old ones are still showing:
   - **First +** (start frame): upload `opp_wild_pup_green.png`.
   - **Second +** (end frame): upload `opp_wild_pup_green.png` again.
3. Leave the **camera** button alone.
4. **Delete the old prompt** from the box, then paste this, exactly:

   ```
   Animate this exact character on a solid flat bright green (#00FF00) background. The pup lunges forward towards the viewer and snaps its jaws, then hops back. The character stays in the centre of the frame at the same size, with exactly the same design, colours and art style as the picture. Static, locked-off camera: no zoom, no pan, no camera movement. Keep the background plain green the whole time: no other objects, no shadows, no text, no effects that cover the background. Smooth, bouncy cartoon game animation. The character finishes back in exactly its starting pose.
   ```

5. Click **Generate** and wait.
6. Play both versions.

### Is it good?

Keep a version if **all** of these are true:

- ✅ It's clearly the same Wild Pup.
- ✅ You can clearly see it lunge forward and snap. (It's fine, even good,
  if it gets bigger as it comes towards you.)
- ✅ It ends back roughly where and how it started.
- ✅ The background stays plain green.

Generate again if you see any of these:

- ❌ The pup changes design or colours.
- ❌ The camera moves or zooms (the pup coming closer is fine; the whole
  picture moving is not).
- ❌ Anything appears on the green: shadows, dust clouds, a floor.
- ❌ It doesn't come back, or it runs off the screen.

### Save it

1. Download the version you're keeping, at the highest quality.
2. Rename it to exactly:
   **`opp_wild_pup_attack.mp4`**
3. Move it into:
   `bite_buddy/design/flow_clips/`

---

## You're done with the test

Check that `bite_buddy/design/flow_clips/` now has:

- `opp_wild_pup_idle.mp4`
- `opp_wild_pup_attack.mp4`

Then tell Claude. Also mention anything that went wrong or felt confusing,
e.g. "I had to generate the attack 4 times because shadows kept appearing".
That goes straight into improving the prompts for Guide 2.

## If Flow looks different from this guide

Flow's screens change from time to time. If you can't find something:

- **No "Frames to Video":** look for "Image to Video" or a picture icon in
  the prompt box; anything that lets you upload a start image works.
- **No second + for the end frame:** just use the start frame. Claude can
  still make it loop.
- **Can't choose a model or mode at all:** check the model menu in the
  prompt box; some Veo versions don't support frames. Pick another one.

Or take a screenshot and send it to Claude.
