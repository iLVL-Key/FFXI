# Bars
Displays bars for Target, Sub Target, Focus Target, Self Actions, and Player Stats (HP, MP, TP, Pet).  
<br><br>
![Bars_ui_positions](https://github.com/user-attachments/assets/6f85f5c8-4298-442f-a302-2771380d9bf6)  
↑ The `//bars ui` command triggers the Screen Test where you can drag any of the highlighted bars.
<br><br><br>
![Bars_drain](https://github.com/user-attachments/assets/01955128-6341-4823-9211-8a225417f13e)  
↑ New animations Bar Drain, Bar Pulse, and Floating TP shown.
<br><br><br>
![Bars_BLU](https://github.com/user-attachments/assets/c3c99ca5-4ec6-48e8-aceb-bee383615e0b)  
↑ The Target and Self Action bars visible and in action showing how many targets were hit and the total of all damage done.
<br><br><br>
![Bars_SAM](https://github.com/user-attachments/assets/1bdcd6af-90fc-434b-a101-08491735a7f0)  
↑ The Target, Self Action, and TP visible in action showing WS and SC damage done (old v2.0 look).
<br><br><br>
![Bars_SP_Abilities](https://github.com/user-attachments/assets/fe34144a-5e7f-42b5-a3f4-5ae48fbe3ca6)  
↑ Bumba with Yaegasumi active before it wears off (update now includes a timer countdown).
<br><br><br>
![Bars_Party_Actions](https://github.com/user-attachments/assets/093af1f8-2ad8-40cb-8660-b25f7d11c527)  
↑ The Party Actions displayed next to each of your party members.
<br><br>
## Features
- Player Stats (HP/MP/TP/Pet) can be turned on/off individually per job (ie SAM could show only TP, while PLD shows HP, MP, and TP)
- Names and bars colored based on type (NPC, Party member, mob claimed by someone else, etc.).
- Target Actions.
  - Displays results of completed actions (damage, buffs, resists, etc.).
  - Displays number of targets hit and totals for AoE cures/damage.
  - Displays casting, completed, and interrupted icons.
  - Tracks every player/mob within range as they perform actions, so you can tab around to different targets and see what they are doing.
  - Spells colored based on their element.
- Self Actions.
  - Dedicated to displaying your own actions.
  - Displays a casting bar based on casting time for spells and items.
- Party Actions.
  - A simplified display of the actions performed by each party/alliance member.
- Focus Target.
  - A customizable list of targets to automatically track in a dedicated bar.
  - Update this list by name, id, or your current cursor target.
- Focus Target Override.
  - Designate the current cursor target as a Focus Target taking priority over the Auto Focus Target list.
  - Focus will persist until subject moves out of range, dies, or is disabled manually.
- Display the Index or Hex number for targets.
  - Useful for NM placeholder camping, or designating a specific mob for others to target.
- Display distance to target.
  - Colorize the distance text based on the distance to the target and other factors.
- Displays SP abilities and time remaining.
  - Accounts for an SP ability being stolen with Larceny.
  - NOTE: Timing for players who have gear adding additional time cannot be accounted for.
- Display Dynamis-Divergence mob jobs.
- Target Lock display for when your camera is locked to your current target.
- Animations!
  - Bar Fade - fades away after a set time of inactivity.
  - Bar Pulse - pulses the bar under certain circumstance (SP ability active, TP is reaady, critical HP, etc.).
  - Bar Drain - bar meter updates immediately, while the newly "missing" part of the bar smoothly drains away.
- Nearly every feature can be turned on/off or adjusted via settings file or in-game commands.

## How To Setup
1. Load the addon with `//lua load bars`.
2. Type `//bars ui` and follow the guide from there.
3. Once you have the bar positions settled, you can add or remove any of the Player Stats bars using `//bars hp` (where 'hp' can be replaced with 'mp', 'tp', or 'pet' to add/remove those bars instead). Remember that the "player stat" bars displayed are specific to the job you are currently on.

#### Extra
4. You can type `//bars help` at any time to display the list of in game commands the addon supports. See **Commands** below.
5. If you have a different number of the Player Stats bars shown for different jobs and would like them aligned to the bottom (for example, sitting on top of your chat log), you can adjust the vertical offset for each bar for each job as needed in the `data/settings.xml` file.
6. Explore the `data/settings.xml` file to see the full list of options that are available to tweak. See **Options** below.

## Commands
All commands must be preceded with `//bars` (ex: `//bars focus`)  
`[optional]`

| Command | Description |
|---------|-------------|
| `hp/mp/tp/pet` | Toggle HP/MP/TP/Pet bar display setting for current job. |
| `width/w` | Display bar widths and how to update them. |
| `size/s` | Display bar sizes and how to update them. |
| `text/t` | Display text sizes and how to update them. |
| `subtext/st` | Display sub text sizes and how to update them. |
| `distance/d` | Toggle the target Distance option. |
| `marker/m` | Toggle the HP/TP Marker option. |
| `hex/h` | Toggle the target Hex option (overrides Index). |
| `index/i` | Toggle the target Index option (overrides Hex). |
| `add/a [target]` | Add a target to the Auto Focus Target list.<br> - Valid targets: Names, IDs,  or current highlighted target.<br> - Use quotes to surround names with spaces. |
| `remove/r [target]` | Remove a target from the Auto Focus Target list.<br> - Valid targets: Names, IDs,  or current highlighted target.<br> - Use quotes to surround names with spaces. |
| `focus/f` | Temporarily override the Auto Focus Target with the current cursor target.<br> - Type again to remove the override.<br> - Automatically removed when target moves out of range. |
| `list/l` | Show the Auto Focus Target list. |
| `ui/lock/unlock` | Toggle Screen Test to drag sections of the UI around. |
| `help` | Display a list of commands and addon info. |

## Settings
Open the `/bars/data/settings.xml` file to adjust these settings.  

### Icons
| **Setting** | **Description** |
|------------|----------------|
| `casting` | Icon displayed while the target is casting. |
| `cancelled` | Icon displayed if the target's casting is cancelled or interrupted. |
| `completed` | Icon displayed when the target's casting is completed. |
| `number_of_targets_hit` | Icon separating the number of target's hit from the results of the cast. |
| `target_lock_left` | Icon displayed on the left of the target when the camera is locked-on. |
| `target_lock_right` | Icon displayed on the right of the target when the camera is locked-on. |
| `targeting` | Icon separating the action from the target of the action. |

### Job Specific
| **Setting** | **Description** |
|------------|----------------|
| `hp` | Display the HP bar while on this job. |
| `mp` | Display the MP bar while on this job. |
| `pet` | Display the Pet bar while on this job. |
| `tp` | Display the TP bar while on this job. |
| `vertical_offsets`<br> → `focus_target`<br> → `player_stats`<br> → `self_action`<br> → `sub_target`<br> → `target` | Adjust vertical positions of these bars specifically for this job. Useful for having different player stat bars visible on different jobs and you want them to be bottom-aligned. Positive numbers will move Bars lower, negative numbers will move Bars higher. |

### Options
| **Setting** | **Description** |
|------------|----------------|
| `abbreviate_common_mob_names` | Common mob names will be abbreviated to save space (ex. Sweetwater Rabbit → Swt. Rabbit). Does not apply to the main name on the Target bar. |
| `animations` | Controls various aspects of the different types of animations. |
| → `drain_brightness` | Brightness (alpha) of the Bar Drain effect.<br># 1-10<br>1 = 10% of the meters alpha<br> 10 = 100% of the meters alpha |
| → `drain_hp_bar` | Display the Bar Drain effect for the Player Stats **HP** bar. |
| → `drain_mp_bar` | Display the Bar Drain effect for the Player Stats **MP** bar. |
| → `drain_pet_bar` | Display the Bar Drain effect for the Player Stats **PET** bar. |
| → `drain_speed` | Speed of the Bar Drain effect.<br># >= 1<br>Higher = faster |
| → `drain_target_bars` | Display the Bar Drain effect on the Focus Target, Sub Target, and Target bars. |
| → `drain_tp_bar` | Display the Bar Drain effect for the Player Stats **TP** bar. |
| → `fade_after_a_delay` | Fades all bars out of view after a set time delay of inaction. |
| → `fade_delay` | Time in seconds to delay fade. |
| → `fade_down_to_alpha` | Number the alpha will stop at after fading.<br>0 = completely invisible<br>255 = completely visible |
| → `fade_speed` | Speed of the Bar Fade effect.<br># >= 1<br>Higher = faster |
| → `floating_tp_number` | The TP number for the TP bar floats along with the end of the TP meter. |
| → `pulse_bar_when_target_sp_active` | Pulses a target’s bar when they use an SP Ability. |
| → `pulse_brightness` | Maximum brightness (alpha) the Bar Pulse effect reaches. |
| → `pulse_name_when_target_sp_active` | Pulses a target’s name when they use an SP Ability. |
| → `pulse_speed` | Speed of the Bar Pulse effect.<br># >= 1<br>Higher = faster |
| → `pulse_when_hp_low` | Pulses the HP bar when critically low. |
| → `pulse_when_mp_low` | Pulses the MP bar when critically low. |
| → `pulse_when_pet_low` | Pulses the Pet bar when pet HP is critically low. |
| → `pulse_when_tp_ready` | Pulses the TP bar when TP is ready to use. |
| → `pulse_tp_meter_only` | The pulse effect from the `pulse_tp_ready` option only applies to the TP meter, not the whole bar. |
| `clear_action_delay` | The delay in seconds after an action completes before it will be cleared from the target (supports decimals, e.g., 5.5). |
| `color_spells` | Colorize the names of spells to match their element. |
| `condense_target_and_subtarget_bars` | Display sub-targets in the Target bar instead of their own separate Sub-Target bar. |
| `condense_target_name_and_sp_name`<br>`focus_target`<br>`sub_target`<br>`target` | The name of the target and the SP ability it is using will rotate, displaying one at a time. False will display the SP ability name after the target name. |
| `focus_target_max_distance` | The maximum distance from the player that a target on the Auto Focus Target list must be before the bar is displayed. |
| `max_action_length` | The maximum number of characters of an action displayed. Actions longer than this number will be truncated to help save space. |
| `max_name_length` | The maximum number of characters of a target’s name displayed (target action line only). Target names longer than this number will be truncated to help save space. |
| `remove_tachi_blade_from_ws_name` | Removes "Tachi: " and "Blade: " from weapon skill names to help save space (ex. *Tachi: Yukikaze* → *Yukikaze*). |
| `short_skillchain_names` | Uses shortened names for skillchains (4 characters long) to help save space. |
| `show_action_status_indicators` | Shows icons depicting when a spell/ability is casting, completed, or interrupted. |
| `show_commas_on_numbers` | Adds commas to numbers for easier readability. |
| `show_dyna_jobs` | Show the job of Dynamis Divergence mobs. |
| `show_fancy_rolls` | Show a fancified version of COR rolls (if `show_lucky_roll_info` is turned on). |
| `show_focus_target_when_targeted` | Show the Auto Focus Target bar when the subject of it has been targeted. False prevents a target being on both at the same time. |
| `show_hp_tp_markers` | Shows marker dots on the TP bar indicating 1k and 2k TP, as well as a marker dot on the HP bar indicating yellow HP. |
| `show_max_hp_mp_on_bars` | Shows the current maximum HP and MP on their respective bars. |
| `show_pet_distance` | Show the distance between you and your pet. |
| `show_pet_status` | Show the current status of your pet (Idle, Engaged, etc.). |
| `show_pet_tp` | Show the current TP of your pet. |
| `show_result_totals` | Show number of targets hit and totals from AoE cures/damage. |
| `show_roll_lucky_info` | Shows the lucky and unlucky numbers for COR rolls. |
| `show_self_action_result` | Show the results of the action done byu the player (if Self Actions are enabled). |
| `show_self_when_sub_targeted` | Shows the Sub Target bar when you target yourself. |
| `show_self_when_targeted` | Shows the Target bar when you target yourself. |
| `show_sub_target_when_targeted` | Shows the Sub Target bar when the Sub Target is already the Target. |
| `show_target_action` | Shows the actions of the current target. |
| `show_target_action_result` | Shows the results of the action done by the current target (damage, buffs, resists, etc.). |
| `show_target_distance` | Shows the distance to the current target. |
| `show_target_distance_colors` | Colorizes the distance text based on the distance to the target and other factors. |
| `show_target_hex` | Shows the hex number of the current target. |
| `show_target_index` | Shows the index number of the current target. |
| `show_target_lock` | Shows the Target Lock icons when your camera is locked on your current target. |

### Sections
| **Setting** | **Description** |
|------------|----------------|
| `focus_target`<br>`player_stats`<br>`self_action`<br>`sub_target`<br>`target` | These sections are for the 5 bars.<br>Player Stats and Self Actions do not have sub text. |
| → `bar_size` | Font size of the bar. |
| → `bar_width` | Width in characters of the bar. |
| → `bold` | Text within this section is bold. |
| → `font` | Font of the text within this section. |
| → `italic` | Text within this section is italic. |
| → `pos` | X and Y position of the bar. |
| `show` | (Self Action only) Show the Self Action section. |
| → `spaces_between_text_parts` | Number of spaces between the different components that make up the text line in this section. |
| → `sub_text_offset` | Horizontal offset for the sub/action text (centered on the bar, positive moves downward, negative moves upward). |
| → `sub_text_shadow_offset` | Diagonal offset for the shadow of the sub/action text (positive moves down-right, negative moves up-left). |
| → `sub_text_size` | Font size of the sub/action text. |
| → `text_offset` | Horizontal offset for the text (centered on the bar, positive moves downward, negative moves upward). |
| → `text_shadow_offset` | Diagonal offset for the shadow of the text (positive moves down-right, negative moves up-left). |
| → `text_size` | Font size of the text within this section. |
| `party_1_actions`<br>`party_2_actions`<br>`party_3_actions` | These sections do not have bars, but are a simplified display of the actions of each party member. |
| → `bold` | Text within this section is bold. |
| → `font` | Font of the text within this section. |
| → `italic` | Text within this section is italic. |
| → `pos` | X and Y position of the text within this section. |
| → `right_alight` | Text within this section is right-aligned. Note that changing this option will require adjusting the position of this section as well. |
| → `show` | Show the Party Actions for this party. |
| → `stroke_color` | RGB value for the color of the text outline within this section. |
| → `text_color` | RGB value for the color of the text within this section. |
| → `text_size` | Font size of the text within this section. |
| → `vertical_spacing_between_players` | Number of pixels between each party member in the party. |

## Changelog

Version 4.0
- Overhauled how Auto Focus target data is saved. Now saves as a lua table in separate `data/auto_focus_targets.lua` file instead of saving as xml data inside the settings file. This approach allows for much easier handling of target names. No need to convert names with spaces and apostrophes to a format that xml can parse, instead saved as a direct string key exactly how it should be spelled.
- Overhauled many of the options in the settings file. Many names adjusted for clarity. New settings added for things that used to be hard-coded. Some settings have had their structure/layout adjusted.
- Added Bar Pulse animation options. Will pulse the bar when HP, MP, or your Pets HP are critically low (<=25%), when TP is ready to use (>=1000TP), or when a Target, Focus Target, or Sub Target has an SP ability active.
- Added Bar Drain animation options. Bar meter updates immediately as normal, while the newly "missing" part of the bar smoothly drains away.
- Added `show_target_lock` option. Indicates when you have your camera locked to your current target.
- Added `floating_tp_number` option. The TP number for the TP bar floats along with the end of the TP meter.
- Added `condense_target_name_and_sp_name` options. Rotates the name of the target and the SP ability name when a Target has an SP ability active, showing one at a time. Setting this to false will display the SP ability name after the target name.
- Added a real right-align for the Party Actions instead of the fake one that relied on a monospace font. Any font is able to be used now, with the minor tradeoff being if you turn it off it throws the positioning numbers way outta wack and will need to be readjusted.
- Added `ui` command. This will toggle the Screen Test that allows you to drag the different sections around the screen for placement.
- Added `icons` settings to change the different status icons.
- Added `italic` option for each section.
- Added `bar_bg` options under `colors`. Can now adjust the color of the background bar (`normal`). Also added colorizing the background bar when the target is dead (`dead`).
- Added a slight stroke/outline to all text to improve readability.
- Removed a number of commands that are either no longer needed (ie pos) or have been split into multiple sections (ie bold). Positions for the different bars have been split out into their own sections and can now be modified via drag and drop with the `ui` command. Bold and other settings are also split into each section now and can be modified in the settings file.
- Adjusted the meter bar resolution/granularity. Number of steps increased by 10 times, much more accurate meter bar lengths now.
- Adjusted the Self Action bar update polling from 10 to 50 times per second. Combined with the 10x meter bar steps adjustment this results in a noticeably smoother bar animation.
- Adjusted Target, Focus Target, and Sub Targets to no longer show active SP abilities once the target dies.
- Adjusted display of active SP ability on a mob to cancel if it is removed via Larceny.
- Adjusted the Fade option to not activate when player is dead.
- Fixed the `show_target_action_result` so that it actually does what it's supposed to do (literally created the option then never used it anywhere <_<;;).
- Fixed the SP Ability "Widened Compass" from not showing as activated.
- Fixed the name of a "player" weapon skill used by an enemy (ex. a Dyna Volte mob using Tachi: Fudo) being blinked/anticipated by a player being incorrectly labeled as a job ability.
- Known Issue: The name of a weapon skill used by a player being blinked by an enemy will be displayed incorrectly as a job ability.
- Known Issue: Bar dragging does not work properly if Window Mode is set to "Window" in Windower. It seems the window's title bar is included when Windower returns the position of the mouse, but is not included when placing a text object on screen, resulting in the numbers not quite matching up and needing to grab slightly below where the actual bar is on the screen in order to grab and drag it.
- Known Issue: The Target Lock icons/line very rarely will display incorrectly. A simple reload of the addon (`//lua r bars`) should fix the issue. I have done what I can to prevent this from happening, but `:extents()` occasionally just doesn't cooperate ¯\_(ツ)_/¯.

Version 3.6.1
- Fixed spacing in Pet Bar.

Version 3.6
- Added `party_actions` option. Displays basic information about what your party/alliance members are doing.

Version 3.5.3
- Fixed an error with the Screen Test introduced with the Distance Colorizing option.

Version 3.5.2
- Fixed `show_target_distance_colors` option throwing errors when on a character with no subjob. (Thanks KNIFEandLANTERN!)

Version 3.5.1
- Fixed Self Action meter showing when `show_self_action` option is disabled. (Thanks blucorp!)

Version 3.5
- Added `show_target_distance_colors` option. This will colorize the distance text based on the distance to the target and other factors. Accounts for Ranged Attacks (automatically detects and adjusts "hits squarely" and "strikes true" for shortbow, longbow, crossbow, gun, and throwing), Magic, Blue Magic (there are many many ranges for Blue so this has been distilled down to an inner and outer range covering most spells), Ninjutsu, Songs, and NPCs/objects. Distance calculations from the DistancePlus addon were used as the starting point and expanded from there.
- Added `switch_focus_and_sub_positions` option. Switches the horizontal positions of the focus target and sub-target bars. False = Sub-Target on left, Focus Target on right. True = Focus Target on left, Sub-Target on right.
- Adjusted the Pet Bar to be formatted like the Target Bar for consistancy.
- Fixed missing Bounty Shot no effect result. (Thanks Xerus!)
- Fixed a couple more Job Abilities showing incorrectly as Weapon Skills. (Thanks Xerus!)

Version 3.4.1
- Fixed missing Dream Shroud (Diabolos BP: Ward) results.

Version 3.4
- Added time remaining on the active SP Ability displayed on the target's name to the highlight_when_sp_active option.
- Adjusted positioning of Target, Focus Target, and Sub Target text just slightly upward.
- Fixed Volte Dark Knight being labeled as PLD|DRG. For reals.
- Fixed SP ability highlight not fading when Bars fades out from inactivity.
- Fixed a couple more Job Abilities showing incorrectly as Weapon Skills.

Version 3.3.1
- Fixed Volte Dark Knight being labeled as PLD|DRG.
- Fixed missing Bounty Shot success result. (Thanks Xerus!)

Version 3.3
- Added show_pet_tp option. Shows the current TP of your pet.
- Added option for show_pet_status. Functionality was already present but missing the option.
- Fixed missing Mug + HP drain and Despoil + TP Drain results.

Version 3.2.1
- Fixed missing check for "Auto Attack" from NMs to ignore.

Version 3.2
- Added highlight_when_sp_active option. Highlights a target's name and displays which SP effect they have active.
- Adjusted nearly all coroutine.sleep() calls to be coroutine.schedule() calls instead.
- Fixed words with apostrophes having the letters after an apostrophe being capitalized.

Version 3.1.1
- Fixed missing Steal, Despoil, and Mug results. (Thanks Xerus!)

Version 3.1
- Added show_target_hex option. Shows the hex number of the current target. The Hex and Index options will override each other (only one or the other displayed at one time).

Version 3.0.3
- Fixed Enspell II's capitalizing incorrectly as "Enspell Ii" when showing the result of casting the spell.

Version 3.0.2
- Fixed an issue where setting show_self_action to false would give an error on load (thanks Github user asilva54!).
- Fixed an issue where setting show_self_action to false would still show the self action bar completing when the player action completes.

Version 3.0.1
- Fixed an issue where if the target of an AoE damage spell/ability resisted the spell, but the reast of the targets took damage, action results would show all as having resisted.
- Fixed missing "fails to take effect" message.

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
