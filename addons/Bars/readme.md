# Bars
Displays bars for player HP, MP, TP, Target, and Focus Target, as well as Actions for Targets, Focus Targets, and Player.  
Can display anwhere from all bars at once, to all the way down to just the target bar.

![Bars_all_bars_shown](https://github.com/user-attachments/assets/814bd9bc-55bd-4330-bf86-8ae463878f78)  
↑All bars visible at the same time.

![Bars_SAM-ezgif com-resize](https://github.com/user-attachments/assets/1bdcd6af-90fc-434b-a101-08491735a7f0)  
↑The Target, Self Action, and TP visible in action.
## Features
- Player Stats (HP/MP/TP/Pet) can be turned on/off individually per job (ie SAM could show only TP, while PLD shows HP, MP, and TP)
  - Bars automatically align to the top, but vertical offset can be adjusted per job if you prefer them aligned to the bottom.
- Target bars colored based on type (NPC, Party member, mob claimed by someone else, etc.).
- Target Actions.
  - Displays results of completed actions (damage, buffs, resists, etc.).
  - Displays casting, completed, and interrupted icons.
  - Tracks every player/mob around as they perform actions, so you can tab around and target and see what they are doing.
  - Spells are colored based on their element.
  - The target of the action is colored based on type.
- Self Actions.
  - Dedicated to displaying your own actions.
  - Displays a casting bar based on casting time for spells and items.
- Auto Focus Target.
  - Add/remove targets to a list to automatically display a focus target for.
    - Can track by name or ID.
  - Displays the Focus Targets actions as well.
  - Automatically hides the Focus Target when it is targeted.
- Display the Index number for targets.
  - Useful for NM placeholder camping, or designating a specific mob for others to target.
- Display distance to target.
- Markers on the TP bar for 1k/2k, and on the HP bar for yellow HP.
- Features can be turned on/off or adjusted via settings file or in-game commands.

## Commands
All commands must be preceded with `//bars`
`[optional] <required>`
 - **pos [x y]** - Update position.
 - **hp/mp/tp/pet** - Toggle HP/MP/TP/Pet bar display setting for current job.
 - **width/w** - Update the bar width.
 - **distance/d**  - Toggle the Distance option.
 - **marker/m** - Toggle the Marker option.
 - **index/i** - Toggle the Index option.
 - **offset/o** - Update the vertical offset for the current job.
 - **add/a <target>** - Add a target to the Auto Focus Target list.
   - Valid targets: Names (ex: Oseem), IDs (ex: 17809550).
   - Use quotes to surround names with spaces.
 - **remove/r <target>** - Remove a target from the Auto Focus Target list.
 - **list/l** - Show the Auto Focus Target list.
 - **size/s [#]** - Update the size.
 - **bold/b** - Toggle the bold setting.

## Changelog

Version 2.0
- Overhauled the action tracking system. Now gives each action happening a tracking index number so that actions can overlap/replace eachother and reset the display timing for each player/mob when a new action starts. This allows actions to be displayed on-screen longer without worrying about a new action being removed early from the previous action.
- Overhauled the text shadows. They now line up correctly when parts of the action line are colored.
- Added optional Self Actions bar.
- Added optional Target Action Results (damage, buffs, resists, etc.).
- Added option to change the delay before clearing the action.
- Added option to show target distance.
- Added option to truncate target and action names (separately) to help with keeping the action line from getting too long.
- Added option to remove "Tachi: " and "Blade: " from weapon skill names to help with keeping the action line from getting too long.
- Added option to use full or shortened skillchain names.
- Added option to display COR lucky/unlucky roll info.
- Added option to use fancy or basic COR roll info.
- Adjusted the Pet bar to change color based on the element of the summon called (SMN only).

Version 1.1.1
- Fixed an issue where the text shadow occasionally does not line up correctly with its parent text.
- Fixed an error with the Pet bar that displays when logging.

Version 1.1
- Added Pet bar showing the name of the pet and their HPP. Defaults to displayed only for pet jobs, but can be turn on or off individually per job the same as HP/MP/TP.
- Added option to show your own action and action status. Default position puts this near the top of the screen, under the buff bar, but it has it's own pos in the settings file.
- Added option to show a targets index number.
- Fixed an issue where saving a name that included an apostrophe to the Auto Focus Target list would break the addon.

Version 1.0
- First version
