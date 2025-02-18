# Vanity
Allows players to automatically set and manage lockstyles based on their current job and location (combat zones or towns). Players can configure specific lockstyle sets for different jobs and zones, enabling automatic lockstyle updates upon zoning, job changes, or after lockstyle mode gets disabled.

## Features
 - Designate lockstyles per job, per combat/town, per character.
 - Designating multiple lockstyles will allow for a random one to be selected.
 - Set lockstyle after job change, zoning, and getting disabled by an enemy.
   - Options to disable functionality for each of these individually
   - Options to adjust timing for each.
 - Change all options and lockstyles via in-game commands.

## Commands
All commands must be preceded with either `//vanity` or `//van` (ex: `//van set`)  
`[optional] <required>`
 - `combat/c` - Display Equip. Set #\'s for your current job in combat zones.
 - `town/t` - Display Equip. Set #\'s for your current job in town zones.
   - `add/a` - Add an Equip. Set # to the combat/town list.
     - Number must be 1-200, 0 will clear list and disable.
   - `remove/r` - Remove an Equip. Set # from the combat/town list.
 - `set/s` - Set current lockstyle based on job and zone.
 - `list/l` - List all lockstyles for the current character.
 - `disable/d [#]` - Display/update After Disable Delay (1-20, 0 to disable).
 - `job/j [#]` - Display/update After Job Change Delay (1-20, 0 to disable).
 - `zone/z [#]` - Display/update After Zone Delay (1-20, 0 to disable).
 - `help` - Display a list of commands and addon info.
