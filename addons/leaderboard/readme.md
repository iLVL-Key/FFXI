# Leaderboard
Tracks battle information and groups it together in different "leaderboards" for the party.

**NOT COMPLETE - Under current development**

### Features
- 3 different modes
  - Normal: Party chat call outs for new high/low scores, any movement up a leaderboard, and WS whiffs
  - Lite: Party chat call outs for new high/low scores, and whiffs at 5 and 10 (the "whiff spam wall")
  - Silent: No call outs
- Partial recovery after crashes or disconnects
  - Only High/Low scores are recovered. Cure, Nuke, and Whiff counts are not
- Reminder that Leaderboard is running (only displayed after you zone)

### Currently Tracked Leaderboards
- Cure - Running total of cures (up to 3 places)
- Highscore - Highest individual WS damage (up to 5 places)
- Lowscore - Lowest individual WS damage (up to 3 places)
- Magic Burst - Highest individual MB damage (up to 5 places)
- Nuke - Running total of nukes (up to 5 places)
- Skillchain - Highest individual SC damage (up to 5 places)
- Whiff - Running total of whiffs (up to 3 places)

(Cure and Nuke Leaderboards account for aoe's)

### Commands
All commands must be prefixed with either `//leaderboard` or `//lb` (ex: `//lb start s`)
- help- displays the list of commands in-game.
- start [normal/n/lite/l/silent/s]- start tracking in Normal/Lite/Silent Mode
- recover [normal/n/lite/l/silent/s]- recover from a crash/disconnect in Normal/Lite/Silent Mode
- pause/p - pause/unpause tracking
- mode/m [normal/n/lite/l/silent/s] - displays/changes current Mode
- c, hs, ls, mb, n, sc, w - print current leaderboards to party chat
- boards - list the different leaderboards that are tracked
- reminder/r [on/off] - displays/changes current reminder setting
- flood [#] - displays/changes the flood delay
- reset - reset the data
