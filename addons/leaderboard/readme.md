# Leaderboard
Tracks battle information and groups it together in different "boards".

### Features
- 3 different tracking modes:
  - Silent: Tracks in the background, no party chat call outs. Default.
  - Lite: Limited party chat call outs.
  - Party: Full party chat call outs. Great for linkshell events.
- Tracks 10 different boards.
- On-Screen Display for the various boards.
- Rival system - Set another player as your Rival and get notifications when either of you beat the others scores.
- Optout list. Characters on this list will not be tracked.
- Party commands. Party members can use party chat (or a tell) to issue certain commands. This ability is disabled by default and is intended to be enabled by a player using Party Mode.
- Automatic data recovery. If you crash or disconnect, your data is saved and picks up right back where it left off.

### Currently Tracked Leaderboards
- c/cure - Running total of cures.
- d/death - Running total of deaths.
- hs/highscore - Highest individual WS damage.
- k/kill - Running total of kills.
- ls/lowscore - Lowest individual WS damage.
- m/murder - Running total of murders.
- mb/magicburst - Highest individual MB damage.
- n/nuke - Running total of nukes.
- sc/skillchain - Highest individual SC damage.
- w/whiffs - Running total of whiffs.

(Cure and Nuke Leaderboards account for aoe's)

### Addon Commands
All commands must be prefixed with either `//leaderboard` or `//lb` (ex: `//lb show mb`)

Basic Commands [optional] <required>
- pause/p - Pause/unpause tracking.
- boards - List the different boards that are tracked.
- visible/show/hide [c/d/hs/k/ls/m/mb/n/sc/w] - Display boards on screen.
- reset <all/c/d/hs/k/ls/m/mb/n/sc/w> - Reset specified data.
- rival - Set the specified player as your Rival. Repeat to remove.

Advanced Commands [optional] <required>
- mode/m [lite/l/party/p/silent/s] - Display/change the current Mode.
- c/d/hs/k/ls/m/mb/n/sc/w - Print board to party chat.
- lock/unlock - Drag the On-Screen Display.
- optout [add/remove <name>] - Display/update the Optout list.
- report <name> - Send the specified player their score report via tell.
- comma [on/off] - Display/change the Comma setting.
- party [on/off] - Display/change the Party Command setting.
- reminder [on/off] - Display/change the Reminder setting.
- flood [#] - Display/change the current Flood Delay setting.

### Party Commands
All commands must be prefixed with `!lb` (ex: `!lb report`). Only work if another player has them enabled.
- c/d/hs/k/ls/m/mb/n/sc/w - Print board to party chat.
- optout - Add your name to the Optout list.
- report - Receive a score report via tell.

### To-do
- Lunge/Swipe are currently added to both Nukes and Magic Burst as-is. The message give by using Lunge/Swipe is identical between it causing a Magic Burst or not. Need to figure out how to differentiate between the two.
- Base when the LOW WS score gets called out on the number of party members?
- Add pet BPs. Need to look into how to determine who owns the Avatar and add it to their scores. Physical/Hybrid Rages should be counted as Weapon skills since they can create Skillchains, and Magical Rages counted as Nukes/MBs.

### Version History

**3.1**
- On-Screen Display now shows up to 10 places.
- Fixed error when using `optout add/remove` command with no name attached.
- Added missing optout and reset commands from the help command list.

**3.0**
- Major update. A lot of streamlining.
- Removed Start/Recover commands. Addon will now automatically start tracking data in the background when it is loaded.
- Added Rival System. Your Rival will be highlighted in the On-Screen Disply and scores will be called out when one beats the other (visible only to you).
- Added on screen display box. Displays the top 5 places. You and your Rivals names are highlighted. 
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
