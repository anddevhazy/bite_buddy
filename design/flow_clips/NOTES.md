# Flow clip notes

Which part of each clip the game uses (set in design/tools/flow_to_sprites.py).
Rebuild the sheets after changing anything: `python3 design/tools/flow_to_sprites.py`

## Wild Pup (test, generated first try)

- `opp_wild_pup_idle.mp4`: the whole clip (0–7.9s), loops. Livelier than
  asked (it rises onto its hind legs and shuts its eyes once), which suits a
  fighter.
- `opp_wild_pup_attack.mp4`:
  - 0.0–0.7s: stands still (unused)
  - 0.7–2.5s: crouches and tenses → **windup** (stretched in game to match
    the real windup time)
  - 2.5–3.7s: lunges, snarls, swipes → **strike**
  - 4.0–6.0s: leaps away sideways and partly off screen (unused)

Lesson for the other prompts: Flow fills all 8 seconds, so it adds extra
moves after the one asked for. That's fine: only the right part is used.
