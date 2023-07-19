# Leaderboard
Tracks battle information and groups it together in different "Boards" for the party.

### Features
- 3 different tracking modes
  - Silent: Tracks in the background, no party chat call outs.
  - Lite: Limited party chat call outs.
  - Party: Full party chat call outs.
- On-Scren Display for the various Boards.
- Rival system - Set another player as your Rival and get notifications when either of you beat the others scores.

### Currently Tracked Leaderboards
- c/cure - Running total of cures
- d/death - Running total of deaths
- hs/highscore - Highest individual WS damage
- k/kill - Running total of kills
- ls/lowscore - Lowest individual WS damage
- m/murder - Running total of murders
- mb/magicburst - Highest individual MB damage
- n/nuke - Running total of nukes
- sc/skillchain - Highest individual SC damage
- w/whiffs - Running total of whiffs

(Cure and Nuke Leaderboards account for aoe's)

### Commands
All commands must be prefixed with either `//leaderboard` or `//lb` (ex: `//lb start s`)

Basic Commands [optional] <required>
- pause/p - Pause/unpause tracking.
- boards - List the different boards that are tracked.
- visible/show/hide [c/d/hs/k/ls/m/mb/n/sc/w] - Display boards on screen.
- rival - Set the specified player as your Rival. Repeat to remove.

Advanced Commands [optional] <required>
- mode/m [lite/l/party/p/silent/s] - Display/change the current Mode.
- c/d/hs/k/ls/m/mb/n/sc/w - Print board to party chat.
- lock/unlock - Drag the On-Screen Display.
- report <name> - Send the specified player their score report via tell.
- comma [on/off] - Display/change the Comma setting.
- party [on/off] - Display/change the Party Command setting.
- reminder [on/off] - Display/change the Reminder setting.
- flood [#] - Display/change the current Flood Delay setting.


- help- displays the list of commands in-game.
- pause/p - pause/unpause tracking
- mode/m [normal/n/lite/l/silent/s] - displays/changes current Mode
- c, hs, ls, mb, n, sc, w - print current leaderboards to party chat
- boards - list the different leaderboards that are tracked
- reminder/r [on/off] - displays/changes current reminder setting
- flood [#] - displays/changes the flood delay
- reset - reset the data

### Version History

**3.0**
- Major update. A lot of streamlining.
- Removed Start/Recover commands. Addon will now automatically start tracking data in the background when it is loaded.
- Added Rival System. Your Rival will be highlighted in the On-Screen Disply and scores will be called out when one beats the other (visible only to you).
- Added on screen display box.Displays the top 10 places. Your and your Rivals names are highlighted. 
- Silent Mode is now the default mode.
- Normal Mode has been renamed to Party Mode.
- Added resetting of specific boards ie `//lb reset mb` (`//lb mb reset` also works).
- All data is now recovered on disconnect/crash.
- Tie scores (ie multiple 99999's or multiple whiffs at 1) now order by the first person to hit that number.
- Added a 9's counter for players who hit multiple 9's. Place order now takes this into account.
- Added commas to numbers (can be turned off in settings).
- SCH Skillchains are now captured.
- Added Death board back (now tracked via packets).
- Added Kill board back (now tracked via packets).
- Added Murder board (player kills another player).
- Cures are now called out every 50,000 HP cured.
- Nukes are now called out every 500,000 damage nuked.
- Added Optout list. Players on the list will not be tracked, and all current related data will be deleted when added.
- Added report party/addon command. Will return a specific persons scores via tell.
- Magic Bursts are now included in Nuke damage.

**2.0**
- Most board functionality added.
- At this point, most everything is hard-coded and I'm still toying with making things work.

**1.0**
- First basic version.
