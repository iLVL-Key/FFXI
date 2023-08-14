# Leaderboard
Tracks battle information and groups it together in different "boards".  

![lb_high_ws](https://github.com/iLVL-Key/FFXI/assets/101156258/9153f70c-4bd4-4884-bea6-1d90faa60b75)

### Features
- 3 different tracking modes:
  - Silent: Tracks in the background, no party chat call outs. Default.
  - Lite: Limited party chat call outs.
  - Party: Full party chat call outs. Great for linkshell events.
- Tracks 10 different boards.
- On-Screen Display for tracking boards in realtime.
- Rival system - Set another player as your Rival and get notifications when either of you beat the others scores (visible only to you).
- Optout list. Characters on this list will not be tracked and all current data for them will be deleted.
- Party commands. Party members can use party chat (or a tell) to issue certain commands.
- Automatic data recovery. If you crash or disconnect, all scores are saved and it picks back up right where it left off.
- Tracks every players scores individually, allowing any player in the group to get a report with only their own scores for each board.
- Tracks the number of "9's" a player has hit.
- Duplicate scores are ordered by who hit the number first.
- All settings can be changed via commands in-game, no need to modify the settings file (although you still can of course).

### Currently Tracked Boards
- `c/cure` - Running total of cures.
- `d/death` - Running total of deaths.
- `hs/highscore` - Highest individual WS damage.
- `k/kill` - Running total of kills.
- `ls/lowscore` - Lowest individual WS damage.
- `m/murder` - Running total of murders.
- `mb/magicburst` - Highest individual MB damage.
- `n/nuke` - Running total of nukes.
- `sc/skillchain` - Highest individual SC damage.
- `w/whiffs` - Running total of whiffs.

(Cure and Nuke Leaderboards account for aoe's)

### Addon Commands
All commands must be prefixed with either `//leaderboard` or `//lb` (ex: `//lb show mb`)

#### Basic Commands `[optional] <required>`
- `pause/p` - Pause/unpause tracking.
- `boards` - List the different boards that are tracked.
- `show/hide [c/d/hs/k/ls/m/mb/n/sc/w]` - Display boards on screen.
- `reset <all/c/d/hs/k/ls/m/mb/n/sc/w>` - Reset specified data.
- `rival [name]` - Display/Set the specified player as your Rival. Repeat to remove.
- `taunt` - Send your rival a tell letting them know which boards you have them beat on.

(show and reset can be used with their arguments in either order. For example, `//lb show mb` and `//lb mb show` will both work)

#### Advanced Commands `[optional] <required>`
- `mode [lite/l/party/p/silent/s` - Display/change the current Mode.
- `c/d/hs/k/ls/m/mb/n/sc/w` - Print board to party chat.
- `lock/unlock` - Drag the On-Screen Display.
- `optout [add/remove <name>]` - Display/update the Optout list.
- `report <name>` - Send the specified player their score report via tell.
- `comma` - Change the Comma setting.
- `party` - Change the Party Command setting.
- `flood [#]` - Display/change the current Flood Delay setting.

### Party Commands
Intended to be used by the party. The host must have Party or Lite Mode running and not have Party Commands disabled.  
All commands must be prefixed with `!lb` (ex: `!lb report`).
- `c/d/hs/k/ls/m/mb/n/sc/w` - Print board to party chat.
- `optout` - Add your name to the Optout list.
- `report` - Receive a score report via tell.

### To-do
- Allow the taunt text to be changed via command.
- Add Drains and Dread Spikes/Drain Samba to cures?
- Lunge/Swipe are currently added to both Nukes and Magic Burst as-is. The message # given by using Lunge/Swipe is identical between it causing a Magic Burst or not. Need to figure out how to differentiate between the two.

### Version History

**3.3**
- Added option to turn specific board party calls on or off.
- Added Taunt command. Will send your rival a tell letting them know which boards you're beating them on (currently limited to High WS, Low WS, Skillchain, and Magic Burst). The message is available to edit in the settings file.
- Adjusted Party Commands to be tied directly to Party/Lite Mode. Previously, Party Commands were turned on and off independantly, regardless of which mode was active, meaning they could be used while in Silent or Lite mode, or forgotten to be turned on when in Party Mode. Instead, Party Command option is now set to on by default, but only usable when specifically in Party or Lite Mode, unless the Party Commands get turned off.
- Adjusted Commas and Party Commands settings to be a toggle, removing the need to supply on or off to the command.
- Adjusted Rival notifications to account for 99999's in the scores.
- Removed Visible addon command. With show already being needed to change the boards being displayed, removing visible simplifies commands leaving just show and hide which do the same thing.

**3.2**
- Added Charm callout.
- Added SMN Blood Pacts. Physical and Hybrid Rages count as a WS in regards to HIGH WS, LOW WS, Whiff, and SC. Magical Rages count as a nuke in regards to Nuke and MB. Healing Wards count towards Cure.
- Added commas to the death and kill numbers.
- Adjusted HIGH WS and LOW WS callouts so that it will not call out for LOW WS if it has already called the same WS for HIGH WS.
- Adjusted the board commands so you can now use `show` afterwards to activate the On-Screen Display for that board. For example, previously only `//lb show mb` would work, now you can also use `//lb mb show`, similar to the reset command.
- Adjusted the report command and how it handles being called via addon or party command.
- Adjusted the live score updates to be in their own "live.xml" file.
- Removed Reminder option. This made more sense when Leaderboard wasn't running automatically and you had to manually turn it on and off.
- Removed check in the party command if the name provided is currently in the party.
- Fixed the nines reporting in the report command.

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
