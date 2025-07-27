# Jingle #

Plays a sound and displays a chat notification when a target (player, mob, or NPC) is nearby.  

![Jingle_Oseem](https://github.com/iLVL-Key/FFXI/assets/101156258/5ed6b45b-e798-4e1e-92dc-27d7490fcca1)

## Features ##
 - Tells you distance and direction to target when found.
 - 3 types of targets:
   - **Permanent** - Found in all zones.
   - **Zone** - Only found within a specified zone.
   - **Temporary** - Only found until removed or you change zones.
 - Plays only once until the target moves out of range again.
 - Works using names, IDs, or Hex IDs (great for NM placeholders).
 - Specify an optional specific sound to play for each target.
   - Plays the default.wav sound if no sound specified.
 - Will play any .wav file you save to the /data/sounds folder.
  
## Commands ##
All commands must be preceded with `//jingle`   (ex: `//jingle list`)  
`[optional] <required>`
 - `add/a` \[target] \[sound_file_name] - Add a target with an optional sound file.
 - `zone/z` \[target] \[sound_file_name] - Add a target with an optional sound file for the current zone only.
 - `temp/t` \[target] \[sound_file_name] - Add a temporary target with an optional sound file.
   - Valid targets: Names (ex: Oseem), IDs (ex: 17809550), Hex IDs (ex: 08E).
   - Use quotes to surround an NPC/mob name that contains spaces.
   - If no target supplied, the current cursor target name will be used with the default sound.
   - Temporary targets will be removed after zoning.
 - `remove/r` \[target] - Remove a target.
 - `list/l` - Show the list of targets and sounds associated.
 - `distance/d` <#1-50> - Set the detection distance.
 - `test` \<sound_file_name> - Test a sound file. Do not include the extension.
   - New sounds added to the /data/sounds folder must be .wav format.
 - `help` - Display a list of commands and addon info.

## Version History ##

2.3.1
- Adjusted the distance to only show the full number, no decimal places.

2.3
- Adjusted target callout to include target distance and direction (thanks Genoxd!)

2.2
- Added `zone` command. Adds a target that will only be found as "nearby" while in the zone you are currently in. You can also manually add zone targets directly to the data/targets.lua file using the format "Target Name|Zone name" for the target name.
- Adjusted all addon notifications to be sent to the say channel by default. This should make sure all "nearby" notifications should be sent to whichever log window you have your chat sent to.
- Adjusted the temp command to save to the data/targets.lua file like other targets. Temporary targets get "|temporary" appended to the end of the target name and are still cleared on zoning as before.

2.1
- Added `temp/t` command. Will add a new temporary target to be tracked. Automatically removed when the player zones. Can also be removed like normal with the `remove` command.
- Adjusted the `add` and `test` commands to remove any extension in the name of the sound file provided by the user. Files must still be in the .wav format in order to work, but now the commands no longer care if an extension is included in the command or not.
- Removed the `t` shorthand alias from the `test` command, it has been repurposed for the `temp` command.
- Removed leftover targets list that is no longer used but was still being created in the settings file.

2.0
- Overhauled how target data is saved. Now saves as a lua table in separate targets.lua file instead of saving as xml data inside the settings file. This approach allows for much easier handling of target names. No need to convert names with spaces and apostrophes to a format that xml can parse, instead saved as a direct string key exactly how it should be spelled.
- Added `//jin` as a command prefix.
- Added the ability to add and remove a target using the current cursor target. Simply target something and type `//jin a` to add the current targets name to the Target list, `//jin r` to remove it.
- Added `flood_delay` option. Determines how much time after a target goes out of range before it can be considered "nearby" again.
- Adjusted code for checking for nearby targets to be much more efficient, reducing a bunch of redundancies.

1.2
- Added ability to search by id and hex id as well as by name.
- Adjusted the list command to now display alphanumerically.
- Adjusted the term "name" to "target" since we're able to search by more than just names now.

1.1
- Added setting for detection distance range.
- Fixed a name save formatting issue.

1.0.1
- Updated help

1.0
- Initial release.
