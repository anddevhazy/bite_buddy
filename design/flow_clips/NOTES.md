# Flow clip notes

Which part of each clip the game uses is set in `design/tools/flow_to_sprites.py`
(start and end seconds, plus how much faster it plays). Rebuild the sheets
after changing anything: `python3 design/tools/flow_to_sprites.py`

Flow fills all 8 seconds, so most clips do the move once and then stand
around, or add extra moves. Only the right part is cut out.

## Wild Pup

- idle: whole clip, loops
- attack: 0.7–2.5s crouch → **windup** (stretched to the real windup time);
  2.5–3.7s lunge → **strike**
- hurt: 0.75–2.0s, the flinch (it recovers slowly after that)
- stunned: 2.0–4.75s, dizzy with stars, loops
- ko: 2.25–3.75s. It's thrown up and off the top of the frame before that,
  so the cut starts mid-fall and ends lying down with swirly eyes (later it
  lifts its head and smiles)

## Ancient Golem

Green itself, so the builder skips despill (it turned the moss orange).

- idle: whole clip, loops
- attack: 0.4–1.4s fist pulled back → **windup**; 1.4–3.0s blast punch → **strike**
- hurt: 0.75–2.75s, arms flung up, played at 2× speed
- stunned: 1.25–4.75s, wobbling with a glowing head, loops
- ko: 0.75–4.0s, topples back and lies still (it gets up again at 6s)

## Shadow Beast

Flow refused stunned and ko ("third-party content providers"), probably
because a black panther looks too close to a famous one. The game does those
in code: wobble plus 💫, and tipping over.

- idle: whole clip, loops
- attack: 0.25–1.0s crouch → **windup**; 1.0–2.9s rears up, slashes,
  pounces → **strike**. Its chest turns yellow during the slash (Flow drift)
- hurt: 0.5–3.0s, recoils in a burst of smoke, played at 2× speed

## Thunder (pet)

- idle: whole clip, loops
- attack: 1.5–2.75s, the lightning lunge forward, played at 2× speed
- block: 0.75–1.75s, raises its paws with lightning; holds the last frame
  while blocking
- dodge: not used. The clip hops toward the opponent and off the edge; the
  code's step back looks better
- hurt: 0.5–1.75s, the flinch (it then spins and blurs)
- victory: 1.0–2.5s, jumping with paws up, loops
- ko: 2.0–4.75s, tumbles over and lies with stars over its head
