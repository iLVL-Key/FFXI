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

## How To Setup
- Load the addon with `//lua load bars`. The addon will be displayed with the default bars shown for your current job.
- Type `//bars pos` and it will tell you the current position of the addon. You can then use `//bars pos # #` (where # represents an x and y position of your choosing) to move the base position of the addon around to where you would like it. Note that the position is where the Target bar is located, the other bars are then adjusted based on that.
- Once you have the base position settled, you can add or remove any of the "player stat" bars using `//bars hp` (where 'hp' can be replaced with 'mp', 'tp', or 'pet' to remove those bars instead). Remember that the "player stat" bars displayed are specific to the job you are on.
  - If you want to entirely turn off all of the "player stat" bars for all jobs, it will be faster and easier to do that inside the settings file under `options > show_bars` and set all bars to false (you can ignore the offsets). Be sure to save the settings file then reload the addon.
- If you have a different number of bars shown for different jobs and would like them aligned to the bottom (for example, sitting on top of your chat log), you can adjust the offset for each job using `//bars offset #` (where # represents how many pixels the addon will be adjusted up or down for that specific job).
#### Extra
- You can type `//bars help` at any time to display the list of in game commands the addon supports. See **Commands** below.
- Explore the settings file to see the full list of options that are available to tweak. See **Options** below.

## Commands
All commands must be preceded with `//bars`
`[optional] <required>`
 - **help** - Display this list in game.
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

## Options
Open the `/bars/data/settings.xml` file to adjust these settings.
 - **bar_width** - Adjust the width of the bars (the Auto Focus Target bar will always be half of this number).
 - **bars_vertical_spacing** - The vertical spacing between each bars section.
 - **clear_action_delay** - The delay in seconds after an action completes that it will be cleared from the screen (supports decimals ie 4.5).
 - **focus_target_max_distance** - The maximum distance from the player that a target on the Auto Focus Target list must be before the bar is displayed.
 - **hide_focus_target_when_target** - Hides the Auto Focus Target bar when the subject of it has been targeted (prevents a target being on both at the same time).
 - **max_action_length** - The maximum number of characters of an action displayed. Actions longer than this number will be truncated to help save space.
 - **max_name_length** - The maximum number of characters of a targets name displayed (target action line only). Target names longer than this number will be truncated to help save space.
 - **remove_tachi_blade_from_ws_name** - Removes "Tachi: " and "Blade: " from weapon skill names to help save (ex. Tachi: Yukikaze --> Yukikaze).
 - **self_action_text_size_difference** - The difference between the base text size of the addon (the bars themselves as well as the "player stats" text use the base addon size) and the text size for the Self Actions.
 - **short_skillchain_names** - Uses shortened names for skillchains (4 characters long) to help save space.
 - **show_fancy_rolls** - Show a fancified version of COR rolls (if show_lucky_roll_info is turned on).
 - **show_action_status_indicators** - Shows icons depicting when a spell/ability is casting, completed, or interrupted.
 - **show_bar_markers** - Shows marker dots on the TP bar indicating 1k and 2k TP, as well as a marker dot on the HP bar indicating yellow HP.
 - **show_bars** - Select which "player stats" bars are displayed for each job.
 - **show_commas_on_numbers** - Adds commas to numbers for easier readability.
 - **show_max_hp_mp_on_bars** - Shows the current maximum HP and MP on their respective bars.
 - **show_roll_lucky_info** - Shows the lucky and lucky numbers for COR rolls.
 - **show_self_action** - Shows the Self Action bar.
 - **show_self_when_target** - Shows the Target bar when you target yourself.
 - **show_target_action** - Shows the actions of the current Target.
 - **show_target_action_result** - Shows the results of the action done by the current Target (damage, buffs, resists, etc.).
 - **show_target_distance** - Shows the distance to the current Target.
 - **show_target_index** - Shows the index number of the current Target.
 - **target_action_text_size_difference** - The difference between the base text size of the addon (the bars themselves as well as the "player stats" text use the base addon size) and the text size for the Target actions.
 - **target_text_size_difference** - The difference between the base text size of the addon (the bars themselves as well as the "player stats" text use the base addon size) and the text size for the Target.
 - **text_vertical_offset** - The vertical offset in pixels between a bar and its text (this is what sets the text above a bar by default).

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
