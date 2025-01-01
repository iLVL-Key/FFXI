# Bars
Displays bars for player HP, MP, TP, Target, and Focus Target, as well as Actions for Targets, Focus Targets, and Player.  
Can display anwhere from all bars at once, to all the way down to just the target bar.

![Bars_all_bars_shown](https://github.com/user-attachments/assets/814bd9bc-55bd-4330-bf86-8ae463878f78)  
↑All* bars visible at the same time. (*Sub-Target bar not displayed but is to the right of the Focus bar)

![Bars_SAM-ezgif com-resize](https://github.com/user-attachments/assets/1bdcd6af-90fc-434b-a101-08491735a7f0)  
↑The Target, Self Action, and TP visible in action.

![Bars_PLD](https://github.com/user-attachments/assets/30a01c7e-fcff-48fd-a1d5-fe528452f682)  
↑The Target and Self Action bars visible and in action.

## Features
- Player Stats (HP/MP/TP/Pet) can be turned on/off individually per job (ie SAM could show only TP, while PLD shows HP, MP, and TP)
  - Bars automatically align to the top, but vertical offset can be adjusted per job if you prefer them aligned to the bottom.
- Target bars colored based on type (NPC, Party member, mob claimed by someone else, etc.).
- Target Actions.
  - Displays results of completed actions (damage, buffs, resists, etc.).
  - Displays number of targets hit and totals for AoE cures/damage.
  - Displays casting, completed, and interrupted icons.
  - Tracks every player/mob around as they perform actions, so you can tab around and target and see what they are doing.
  - Spells are colored based on their element.
  - The target of the action is colored based on type (NPC, Party member, etc.).
- Self Actions.
  - Dedicated to displaying your own actions.
  - Displays a casting bar based on casting time for spells and items.
- Focus Target.
  - Add/remove targets to a list to automatically display a focus target for.
    - Can track by name or ID.
  - Displays the Focus Targets actions as well.
  - Automatically hides the Focus Target when it is targeted.
- Focus Target Override.
  - Designate the current target as a Focus Target taking priority over the Auto Focus Target list.
  - Focus will persist until subject moves out of range, dies, or is disabled manually.
- Display the Index number for targets.
  - Useful for NM placeholder camping, or designating a specific mob for others to target.
- Display distance to target.
- Display Dynamis-Divergence mob jobs.
- Markers on the TP bar for 1k/2k, and on the HP bar for yellow HP.
- Fades away after a set time of inactivity.
- Features can be turned on/off or adjusted via settings file or in-game commands.

## How To Setup
- Load the addon with `//lua load bars`.
- Type `//bars pos` and it will tell you the current position of the addon. You can then use `//bars pos # #` (where # represents an x and y position of your choosing) to move the base position of the addon around to where you would like it. Note that the position is where the Target bar is located, the other bars are then adjusted based on that.
- Once you have the base position settled, you can add or remove any of the "player stat" bars using `//bars hp` (where 'hp' can be replaced with 'mp', 'tp', or 'pet' to add/remove those bars instead). Remember that the "player stat" bars displayed are specific to the job you are on.
- If you have a different number of bars shown for different jobs and would like them aligned to the bottom (for example, sitting on top of your chat log), you can adjust the offset for each job using `//bars offset #` (where # represents how many pixels the addon will be adjusted up or down for that specific job).
#### Extra
- You can type `//bars help` at any time to display the list of in game commands the addon supports. See **Commands** below.
- Explore the `data/settings.xml` file to see the full list of options that are available to tweak. See **Options** below.

## Commands
All commands must be preceded with `//bars` (ex: `//bars pos`)  
`[optional] <required>`
 - `pos/p [x y]` - Update overall Position.
 - `hp/mp/tp/pet` - Toggle HP/MP/TP/Pet bar display setting for current job.
 - `width/w` - Update the bar Width.
 - `distance/d`  - Toggle the Distance option.
 - `marker/m` - Toggle the HP/TP Marker option.
 - `index/i` - Toggle the Index option.
 - `offset/o` - Update the vertical Offset for the current job.
 - `add/a <target>` - Add a target to the Auto Focus Target list.
   - Valid targets: Names, IDs, <t>, or current highlighted target.
   - Use quotes to surround names with spaces.
 - `remove/r <target>` - Remove a target from the Auto Focus Target list.
 - `focus/f` - Temporarily override the Auto Focus Target with the current cursor target.
   - Type again to remove the override.
   - Automatically removed when target moves out of range.
 - `list/l` - Show the Auto Focus Target list.
 - `size/s [#]` - Update the font Size.
 - `bold/b` - Toggle the Bold setting.
 - `help` - Display a list of commands and addon info.

## Options
Open the `/bars/data/settings.xml` file to adjust these settings.
 - `abbreviate_common_mob_names` - Common mob names will be abbreviated to save space (ex. Sweetwater --> Swt.). Does not apply to the main name on the Target bar.
 - `bar_width` - Adjust the width of the bars. The Focus Target and Sub-Target bars will always be half of this number.
 - `bars_vertical_spacing` - The vertical spacing between each bars section.
 - `char_width_multiplier` - Font size is multiplied by this number to calculate character width in pixels. Affects only the horizontal position of the Sub-Target bar.
 - `clear_action_delay` - The delay in seconds after an action completes that it will be cleared from the screen (supports decimals ie 4.5).
 - `color_spells` - Colorize the names of spells to match their element.
 - `condense_target_and_subtarget_bars` - Display sub-targets in the Target bar instead of their own separate Sub-Target bar.
 - `fade_after_delay` - Fades all bars out of view after a set time delay of inaction.
 - `fade_delay` - Time in seconds to delay fade.
 - `fade_multiplier` - Number the alpha is reduced per frame during fade. Higher number fades faster.
 - `fade_to_alpha` - Number the alpha will stop at after fading. 0 = completely invisible, 255 = completely visible.
 - `focus_target_max_distance` - The maximum distance from the player that a target on the Auto Focus Target list must be before the bar is displayed.
 - `hide_focus_target_when_target` - Hides the Auto Focus Target bar when the subject of it has been targeted (prevents a target being on both at the same time).
 - `max_action_length` - The maximum number of characters of an action displayed. Actions longer than this number will be truncated to help save space.
 - `max_name_length` - The maximum number of characters of a targets name displayed (target action line only). Target names longer than this number will be truncated to help save space.
 - `remove_tachi_blade_from_ws_name` - Removes "Tachi: " and "Blade: " from weapon skill names to help save (ex. Tachi: Yukikaze --> Yukikaze).
 - `self_action_text_size_difference` - The difference between the base text size of the addon (the bars themselves as well as the "player stats" text use the base addon size) and the text size for the Self Actions.
 - `short_skillchain_names` - Uses shortened names for skillchains (4 characters long) to help save space.
 - `show_action_status_indicators` - Shows icons depicting when a spell/ability is casting, completed, or interrupted.
 - `show_bar_markers` - Shows marker dots on the TP bar indicating 1k and 2k TP, as well as a marker dot on the HP bar indicating yellow HP.
 - `show_commas_on_numbers` - Adds commas to numbers for easier readability.
 - `show_dyna_jobs` - Show the job of Dynamis Divergence mobs.
 - `show_fancy_rolls` - Show a fancified version of COR rolls (if show_lucky_roll_info is turned on).
 - `show_max_hp_mp_on_bars` - Shows the current maximum HP and MP on their respective bars.
 - `show_pet_distance` - Show the distance between you and your pet.
 - `show_result_totals` - Show number of targets hit and totals from AoE cures/damage.
 - `show_roll_lucky_info` - Shows the lucky and lucky numbers for COR rolls.
 - `show_self_action` - Shows the Self Action bar.
 - `show_self_when_target` - Shows the Target bar when you target yourself.
 - `show_target_action` - Shows the actions of the current Target.
 - `show_target_action_result` - Shows the results of the action done by the current Target (damage, buffs, resists, etc.).
 - `show_target_distance` - Shows the distance to the current Target.
 - `show_target_index` - Shows the index number of the current Target.
 - `target_action_text_size_difference` - The difference between the base text size of the addon (the bars themselves as well as the "player stats" text use the base addon size) and the text size for the Target actions.
 - `target_text_size_difference` - The difference between the base text size of the addon (the bars themselves as well as the "player stats" text use the base addon size) and the text size for the Target.
 - `text_vertical_offset` - The vertical offset in pixels between a bar and its text (this is what sets the text above a bar by default).
 - `z_show_player_stat_bars` - Select which "player stats" bars are displayed for each job.
   - `hp` - Display the HP bar while on this job.
   - `mp` - Display the MP bar while on this job.
   - `tp` - Display the TP bar while on this job.
   - `pet` - Display the Pet bar while on this job.
   - `vertical_offset ` - Adjust the overall Bar vertical position specifically for this job. Useful for having different player stat bars visible on different jobs and you want them to be bottom-aligned. Positive numbers will move Bars lower, negative numbers will move Bars higher.

## Changelog

Version 3.0
- Added action results for many, many things.
- Added "Screen Test" for updating position, width, offset, size, and bold commands.
- Added abbreviate_common_mob_names option, abbreviates common mob names (Focus Target bar, Sub-Target bar, and Action Targets only, main Target bar will not abbreviate).
- Added color_spells option, colors spell names based on their element (previously colored them without having the option).
- Added fade_after_delay option. Fades out the bars after a set time delay of inaction.
- Added show_dyna_jobs option, shows jobs of Dynamis-D mobs on main Target bar.
- Added show_pet_distance option, displays distance between you and your pet on the Pet Bar.
- Added show_result_totals option, displays a count of targets hit by AoE's and cumulative result numbers for hitting multiple targets. Main target absorbing will take priority and show its single target absorb number.
- Added show_st_when_target option, displays the Sub-Target bar if it is the same as the Target.
- Added colors for damage and healing for action results. You can now tell when an action damages or heals a target by the color of the number. Removal type results (ie Dispel and Erase) also use the healing color.
- Added default entries for the auto focus target list (Aurix and NMs from Odyssey, Omen, Sortie, Vagary, and Domain Invasion).
- Adjusted the way the auto focus target add and remove commands work. You can now add or remove targets to the list by simply targeting them and using the add or remove cammands with no arguments (ex. target a mob and type `//bars a` will now add that target).
- Adjusted "finish" actions to update the table of all current actions happening at any given time the same way the "begin" actions do. This fixes an issue where the action results would not show correctly when the "begin" action packet was lost due to lag (Mireu, for example), even when the "finish" packet was still received.
- Adjusted the names of the Target, Sub Target, and Focus Target to be colored based on the subject, matching the bar coloring.
- Adjusted max_name_length option to apply to Focus Target and Sub-Target names.
- Adjusted the alpha setting for the meters to be tied to the text_alpha (meter background elements are still tied to bg_alpha, and text shadows are still tied to text_alpha).
- Adjusted a number of default values.
- Removed a few color settings that weren't used.
- Removed pet status from pet bar when on GEO.
- Fixed mobs claimed by an alliance member not coloring correctly.
- Fixed some monster instant TP moves not displaying (moves without a "readying" message first).
- Fixed pet meter not hiding as intended.
- Fixed pet meter occasionally extending off the screen for a second when pet is called.
- Fixed paralyzed and intimidated melee attacks causing the Self Action bar to flash for 1 frame.
- Fixed padding issue with Self Action Bar at start of cast.
- Fixed TP bar not changing to correct color at exactly 1000 and 2000 TP.
- Fixed an issue where a target on the Auto Focus Target list flashes on the Focus Target Bar for a frame when it enters memory but before its actually within the focus_target_max_distance range (if set to below 50). This fix will make it disappear if you manage to stand exactly on top of it, but gl doing that.

Version 2.2.2
- Fixed Focus Target bar not updating when Override is used (`//bars f` command).
- Fixed Sub-Target x offset not updating when bar width is updated via in-game command.

Version 2.2.1
- Added missing 'No effect' message for monster abilities.

Version 2.2
- Added Focus Target Override. You can now use `//bars focus` (or `f` for short) to override the Auto Focus Target with whatever you have targeted. Override will be removed when subject moves out of range, dies (if its a mob), or is removed via `//bars focus` again.
- Added Sub-Target bar. Displayed as a half-length bar to the right of the Focus Target bar. New options to accompany this are `condense_target_and_subtarget_bars` and `char_width_multiplier` (to adjust horizontal spacing if needed).
- Adjusted COR total default color for Fancy Rolls.
- Adjusted player character (other) target default color.
- Fixed COR roll total of 1 not being colored correctly for Fancy Rolls.

Version 2.1.1
- Added a few more instances of error handling.
- Cleaned up some redundant text coloring.

Version 2.1
- Added highlighting of a COR rolls current total roll in the action result for "fancy rolls".
- Added action results for item usage.

Version 2.0.1
- Fixed the show_roll_lucky_info option not working.

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
