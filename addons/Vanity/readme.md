# Vanity
Allows players to automatically set and manage lockstyles based on their current job and location (combat or town zones), plus other advanced conditions. Automatic lockstyle updates upon zoning, job changes, or after lockstyle mode gets disabled. Supports multiple lockstyle sets for the same conditions resulting in a random set chosen from the list.

## Features
 - Designate lockstyles per job, per character.
 - Basic conditions can be modified via in-game commands.
   - Combat
   - Town
 - Advanced conditions can be modified via the settings.xml file.
   - Custom Zones
   - Common endgame activities (Dynamis, Odyssey, Omen, Sortie, Vagary)
   - Specific Weapons (Tizona, Armageddon, Duban ,etc.)
   - Weapon Types (Sword, Marksmanship, Shield, etc.)
 - Designating multiple lockstyles will allow for a random one to be selected.
 - Set lockstyle after job change, zoning, and getting disabled by an enemy.
   - Options to disable functionality for each of these individually
   - Options to adjust timing for each.

## Commands
All commands must be preceded with either `//vanity` or `//van` (ex: `//van set`)  
`[optional] <required>`
 - `combat/c` - Display lockstyles for your current job in combat zones.
 - `town/t` - Display lockstyles for your current job in town zones.
   - `[add/a] <#>` - Add a lockstyle to the combat/town list.
     - Number must be 1-200, 0 will clear list and disable.
   - `[remove/r] <#>` - Remove a lockstyle from the combat/town list.
 - `set/s` - Set (apply) lockstyle based on current conditions.
 - `list/l` - List ALL lockstyles for the current character.
 - `disable/d [#]` - Display/update After Disable Delay (1-20, 0 to disable).
 - `job/j [#]` - Display/update After Job Change Delay (1-20, 0 to disable).
 - `zone/z [#]` - Display/update After Zone Delay (1-20, 0 to disable).
 - `help` - Display a list of commands and addon info.

## Options
Open the `/Vanity/data/settings.xml` file to adjust these settings.
- `after_disable_delay` - Delay in seconds after having your lockstyle disabled by a mob in a combat zone until your lockstyle will be re-applied.
- `after_job_change_delay` - Delay in seconds aftter changing your job that your lockstyle will be applied.
  - Note that this timer will be reset if you change jobs again before it is up.
- `after_zone_delay` - Delay in seconds after zoning that your lockstyle will be applied.

## Notes
- At the simplest, Vanity can use just one lockstyle for all conditions by setting either the town or combat lockstyle for each job.
- You can use separate lockstyles for town and combat zones by setting different lockstyles for both town and combat for each job.
- If you wish to have Vanity choose a random lockstyle, you can set multiple lockstyles by separating numbers with a comma.
- Designate lockstyles for specific zones by using the zone option. For example, {zone=Western Adoulin:1,2,3} will set lockstyles 1, 2, and 3 for Western Adoulin.
- Designate lockstyles for the common endgame activities Dynamis, Odyssey, Omen, Vagary, and Sortie by using the dynamis, odyssey, omen, vagary, and sortie conditions. For example, {dynamis:1,2,3} will set lockstyles 1, 2, and 3 for all Dynamis zones.
- Designate lockstyles for specific weapons or weapon types by using the weapon name or skill conditions: main_name, main_skill, sub_name, sub_skill, range_name, and range_skill. For example, {main_name=Excalibur:1,2,3} will set lockstyles 1, 2, and 3 for Excalibur in the main slot. {sub_skill=Sword:1,2,3} will set lockstyles 1, 2, and 3 for any Sword in the sub slot.
- Priority is as follows: zone, (dynamis, odyssey, omen, vagary, sortie), main_weapon, main_skill, sub_weapon, sub_skill, range_weapon, range_skill, combat, town. Will equip based on current condition and which conditions have lockstyles designated, going from highest to lowest priority (zone being the highest and town the lowest). The only exception is while in town: zone will still be prioritized first, then town immediately after.
- To disable a lockstyle, set the lockstyles to 0. For example, {town:0} will disable the town lockstyle for that job. Removing the condition entirely will also disable it.
- All zone, weapon, and weapon skill names are case-insensitive but will still need to be spelled exactly including spaces and apostrophes, for example {main_name=bunzi's rod:10}.
- Lockstyle numbers must be between 1 and 200, numbers outside this (aside from 0) will simply be ignored.
- If no valid lockstyles are found for a condition, Vanity will do nothing. To manually set your lockstyle inside of a macro, use `/console vanity set` on its own line.
- Order does not matter, for example {town:1,2}{combat:3,4} is the same as {combat:4,3}{town:2,1}.

## Changelog

Version 4.0
- Overhauled how lockstyle data is saved. No longer saved inside the settings file but instead in it's own data/lockstyles.lua file.
- Added ability to specify main/sub and main/range combos by name or skill (ex. sword + sword, sword + shield, sword + gun, dagger + gun)

Version 3.1.2
- Fixed an issue with Sortie and Vagary zones not being identified correctly.

Version 3.1.1
- Fixed a saving issue with multiple characters. (Thanks again Mekaider!)

Version 3.1
- Adjusted calls to save and a few other functions to be multi-box friendly. (Thanks Mekaider!)
- Adjusted Job Change Delay to use a timestamp instead of a countdown timer. Mostly just because it's cleaner and more reliable.
- Fixed After Zone Delay not showing "Off" correctly in the help command if set to 0
- Fixed Mog House in Al Zahbi not being recognized as a "town" zone.
- Removed a bunch of basically duplicate variables.

Version 3.0.1
- Fixed an issue with using the in-game commands to change disable/job change/zone timing settings which would then delete all per-character lockstyles. This change now makes it so changing those settings with the in-game commands will be saved per-character instead.

Version 3.0
- Overhauled lockstyle conditions. No longer just Combat and Town.
- Added new Zone condition. Will allow you to specify the name of a zone to designate lockstyles for.
- Added common endgame activities Dynamis, Odyssey, Omen, Vagary, and Sortie as conditions to make them easier to setup. You can still technically use the Zone condition, but these are easier.
- Added new Weapon conditions: main_name, main_skill, sub_name, sub_skill, range_name, and range_skill. Will allow you to designate lockstyles for specific weapons (Tizona, Armageddon, Duban ,etc.) or weapon types (Sword, Marksmanship, Shield, etc.).
- Added a priority for which condition lockstyles to equip: Zone > (Dynamis, Odyssey, Omen, Sortie, Vagary) > Main Name > Main Skill > Sub Name > Sub Skill > Range Name > Range Skill > Combat > Town. Will equip based on current condition and which conditions have lockstyles designated, going from highest to lowest priority (Zone being the highest and Town the lowest). The only exception is while in town: Zone will still be prioritized first, then Town immediately after. This allows you to set a single lockstyle (Town) that will then be used for all conditions. This also fixes the "After Disable" lockstyle option from seeming to not work if you have Town lockstyles designated but no Combat lockstyles designated.
- Added math.randomseed(os.time()) to ensure better randomization.
- Fixed showing "(Chosen at random)" when only one lockstyle but the number is two digits.

Version 2.0
- Overhauled how lockstyles are saved. Instead of a single variable for each job+combat/town combination, now saved as a single string per job that contains both combat and town lockstyles.
- Added the ability to designate multiple lockstyles per combat/town. Will choose a lockstyle at random when more than one lockstyle is designated.
- Adjusted in-game commands to accomodate being able to save more than one lockstyle for combat/town. This removed the ability to specify which job to adjust combat/town for, commands will now only work on your current job. This was needed to keep the commands relatively simply with the addition of the `add` and `remove` sub-commands. You can still adjust all at once inside the `Vanity/data/settings.xml` file.

Version 1.3
- Added Chocobo Circuit to Town list
- Adjusted Help text

Version 1.2
- Adjusted the After Disable, After Job Change, and After Zone settings to use 0 to turn them off instead of a separate true/falsee setting. This moves it in line with how locsktyles are disabled using a 0.

Version 1.1.1
- Fixed attempting to set locklstyle while not logged in.

Version 1.1
- Added After Disable option. Will attempt to reapply your lockstyle if it gets disabled by an enemy in a combat zone.
- Added list command to list all lockstyles for all jobs.

Version 1.0
- First version.
