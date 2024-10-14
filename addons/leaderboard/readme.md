# Leaderboard
Tracks battle information and groups it together in different "boards".  

![lb_high_ws_onscreen2](https://github.com/iLVL-Key/FFXI/assets/101156258/878a3198-0089-4318-8317-c5134fee8002)  
↑ The on-screen display showing the High WS Board.

![Leaderboard addon picture of high ws party chat callout](https://github.com/iLVL-Key/FFXI/assets/101156258/4890ef71-08cd-49dd-9819-feccde31e760)  
↑ Party chat callout for the High WS.

![Leaderboard addon picture of cure board printed to party chat](https://github.com/iLVL-Key/FFXI/assets/101156258/41ff276e-57b0-4899-a302-71abd85ae64f)  
↑ The Cure Board being printed to party chat.

![lb_rival](https://github.com/iLVL-Key/FFXI/assets/101156258/c1e496cb-6d55-4f34-8402-d0d69cc700c3)  
↑ A Rival Skillchain notification.

### Features
- 4 different tracking modes:
  - **Silent:** Default mode. Tracks in the background, no party chat call outs.
  - **Lite:** Limited party chat call outs. Great for alliance events.
  - **Party:** Full party chat call outs. Great for small party events.
  - **Mog Kart:** Inspired by Mario Kart, this mode includes "items" that players (trusts too!) can receive and use to affect other players points.
    - All items can have their attributes changed in the settings file.
    - Trusts will also play Mario Kart along with you and your party members (IT'S AI! ...not really)!
    - Note: Uses tells to send players their items as well as receive the command to use them.
- Tracks 11 different boards.
- On-Screen Display for tracking boards in realtime.
- Rival system. Set another player as your Rival and get notifications when either of you beat the others scores (visible only to you).
- Optout list. Characters on this list will not be tracked and all current data for them will be deleted.
- Chat Buffer system. Holds new outgoing messages in a buffer table before sending out to chat to prevent errors with multiple chat messages at the same time.
- Party commands. Party members can use party chat and/or tells to issue certain commands while in Party or Lite Modes.
  - Flood delay per player so that individuals can't spam commands and lock others out.
- Automatic data recovery. If you crash or disconnect, all scores are saved and it picks back up right where it left off.
- Tracks every players scores individually. Allows any player in the group to get a report with only their own scores for each board.
- Tracks the number of "nines" a player has hit.
- Duplicate scores are ordered by who hit the number first.
- All major settings can be changed via commands in-game, no need to modify the settings file (although you still can of course).

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
- `v/victim` - Running total of victims.
- `w/whiffs` - Running total of whiffs.

(Cure and Nuke Leaderboards account for aoe's)

### Addon Commands
All commands must be prefixed with either `//leaderboard` or `//lb` (ex: `//lb show mb`)

#### Basic Commands `[optional] <required>`
- `pause/p` - Pause/unpause tracking.
- `c/d/hs/k/ls/m/mb/n/p/sc/v/w` - Print board to party chat.
- `mode/kart/silent/lite/party` - Display/change the current Mode.
- `reset <all/i/c/d/hs/k/ls/m/mb/n/p/sc/v/w>` - Reset specified data.
- `show/hide [#/c/d/hs/k/ls/m/mb/n/p/sc/v/w]` - Display board on screen (# = how many lines).
- `boards` - List the different boards that are tracked.
- `rival [name]` - Display/Set the specified player as your Rival. Repeat with name to remove.
- `taunt [text]` - Send your rival a tell with which boards you have them beat on.  
  - Including `[text]` updates the taunt text. Must include a `%s` where the boards will go.

#### Advanced Commands `[optional] <required>`
- `call [c/d/hs/k/ls/m/mb/n/sc/w]` - Display/change the Party/Lite mode party call settings.
- `lock/unlock` - Drag the On-Screen Display.
- `optout [add/remove <name>]` - Display/update the Optout list.
- `report <name>` - Send the specified player their score report via tell.
- `reminder` - Change the Reminder setting.
- `alpha [#]` - Update the bg alpha for the on-screen display.
- `bold` - Enable/disable the bold setting for the on-screen display.
- `comma` - Change the Comma setting.
- `size [#]` - Update the font size for the on-screen display.
- `partycommand/partycmd` - Change the Party Command setting.
- `flood [#]` - Display/change the current Flood Delay setting.

#### Kart Mode Commands  `[optional] <required>`
- `itemtimer` - Update the interval timer between Item Boxes.
- `boardtimer` - Update the timer between Points Board chat callout (0 = off).
- `randomitem` - Give a random player a random item.

(call, reset, and show can be used with their arguments in either order. For example, `//lb show mb` and `//lb mb show` will both work)

### Party Commands
Intended to be used by the party. The host must have Party or Lite Mode running and have Party Commands enabled.  
- `lb c/d/hs/k/ls/m/mb/n/sc/v/w` - Print board to party chat. (receive command via party chat or tell)
- `optout` - Add your name to the Optout list. (receive command via tell only)
- `report` - Receive a score report via tell. (receive command via tell only)

### Current Known Issues
- In high lag situations (seen in Dynamis-Jeuno Divergance), very rarely a tell sent out to a player via Mog Kart Mode gets a "tell not received" error as if they are offline, when they are online, resulting in the player receiving an item without the tell to inform them of it. I have only seen this myself a total of twice ever, but something to be aware of.

### Version History

**4.0.2**
- Added more "Utility" WSs to be excluded from WS boards.
- Fixed separating Lunge/Swipe Magic Bursts and non Magic Bursts.
- Fixed SMN BP "WSs" not being labeled correctly.

**4.0.1**
- Fixed the Points Board callout not pausing when Mog Kart mode is paused.
- Fixed an issue when in Mog Kart mode and a banana item is used but has no target by the time it "lands".
- Fixed an issue where a SMN Blood Pact: Rage landing for zero was not counted as a whiff.

**4.0**
- Added Mog Kart Mode. Inspired by Mario Kart, this mode includes "items" that players can receive and use to affect other players points. Chat callouts are limited to item usage and point movement (deaths, whiffs, and murders are called out and now include points lost/transferred while in Mog Kart Mode) and a timed Point Board chat callout (up to 18 places while in Mog Kart Mode). Settings able to be modified include: item names, accuracy, point modifiers, availability, and place range able to receive them, as well as the interval frequency that items are given out and the frequency of calling the Point Board to chat.
- Added settings to turn gaining points for each individual board on or off.
- Added setting to specify the maximum number of places displayed in the on-screen display.
- Adjusted boards to now fully track up to 18 places.
- Adjusted the Report command to show which place the player is in for each board.
- Adjusted the Optout command text to include how to add/remove a player from the list.
- Adjusted the Flood Delay to now track individual players instead of a global delay.
- Adjusted the message sent to players, shortened [Leaderboard] to [LB].
- Adjusted Party Commands. Removed the `!lb` required in front of `report` and `optout`. Removed the `!` previously required in front of the commands (ie just `lb c` now)
- Fixed an issue when adding a player to the Optout list where they would still accrue points for a few moments until the boards updated and removed their name, leaving them a small amount of points data afterwards. Boards now get updated at the same time as their individual data being deleted.
- Fixed an issue when adding a player to the Optout list via a tell command from a player where it would not save the name in the correct format, preventing it from working as intended.
- Fixed an issue with the Reminder not displaying correctly while paused.
- Fixed an issue when loading the addon while not logged in (autoloading via init) that would produce an error and not keep track of your own characters name correctly.

**3.6.1**
- Adjusted Chat Buffer system. New messages will go straight to chat if no other message had immediately preceded it, otherwise they will get added into the buffer table to wait their turn to be sent to chat. Delay between multiple chat messages sent to chat reduced from 2 seconds to 1.5.

**3.6**
- Added a new Chat Buffer system that prevents when multiple things try to trigger chat at the same time, causing one of them to receive an error and not actually display in chat. In short, any chat messages are temporarily held in a table, then every 2 seconds the table is checked and the message at the top of the list is put to chat and removed from the table.
- Adjusted the default % loss of points for a death (or transfer of said points in the case of a murder) from 5 to 10, and for whiffs from 1 to 5.
- Adjusted unknown spells/abilities/etc to be named `[REDACTED]` instead of simply `unknown`. This mosly only happens on SMN Blood Pacts for [REDACTED] reasons.

**3.5**
- Added Point Board. Points are accrued continually over time. The rate that points are accrued changes based on which boards and in which place a player is in at each interval. The interval is dependant on party/alliance actions, no points are gained while nothing is happening. The more boards a player is on, and the higher place they are in, the faster their points will accrue. Death and Whiff Boards do not accrue points. Instead, a percentage of your current point total is lost each time. When a murder happens, the murderer loses a percentage of their current point total, and the victim is awarded that number of points. Point weights per board and per place, as well as percentages lost, are adjustable in the settings file.
- Added Victim Board. A Murder (player killing another player) now produces both a Murder Board and a Victim Board. Callout settings for the Victim Board are linked to the Murder Board (since they are called out in the same line).
- Added Bold command to adjust the bold setting of the on-screen display.
- Added Size command to adjust the font size of the on-screen display.
- Added Alpha command to adjust the alpha setting of the on-screen display.
- Added the ability to print the boards to linkshell/linkshell2 (ie `//lb c l2` will print the Cure Board to linkshell2)
- Adjusted on-screen display to show which mode Leaderboard is currently running in.
- Adjusted Mode (Silent, Lite, or Party) to save to the settings file. This will now persist the mode through a crash/disconnect.
- Adjusted Cure and Nuke callout intervals for Party Mode. Cures are now called out every 25k up to 100k, then every 50k thereafter. Nukes are called out every 250k up to 1m, then every 500k thereafter. Lite Mode will still call out every 50k/500k.
- Adjusted the help text.
- Adjusted Rival command text to include how to remove the currently set rival.
- Adjusted callouts for High WS, Skillchain, and Magic Burst. For each 9's in these boards, Party Mode callouts will now be each up to 10, then every 5 thereafter. Lite Mode callouts will be the first 9's hit then every 5th.
- Fixed an issue with Pause not working correctly for some boards.
- Fixed an issue with a Rival notification triggering when you hit 9's on HS, SC, or MB but your rival has not performed these yet (score of 0).

**3.4.1**
- Adjusted the Party command syntax to instead be Partycommand/Partycmd. This fixes a conflict with the Mode command update in version 3.4.

**3.4**
- Added the ability to change the taunt commands text via addon command.
- Added the Reminder command back in. The new behavior will only remind you that Leaderboard is running when in Party or Lite mode.
- Adjusted the Report command to show 'none' when no data for select boards.
- Adjusted the Report command to group the highest/lowest individual scores and running total scores together.
- Adjusted the Mode command to no longer require `mode`. You can can now simply use `party`, `lite` or `silent` on their own. (ex. `//lb party` now does the same thing as `//lb mode party`)
- Fixed the Report command issue where Low WS was not showing up correctly when one player had not used a weaponskill yet.
- Removed the Charm callout. This has been moved to the Callouts addon where it makes more sense.

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
