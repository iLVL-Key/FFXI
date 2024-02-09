# Jingle #

Plays a sound when a player/mob/NPC is nearby.

## Features ##
 - Plays only once until they move out of range again.
 - Can specify a sound to play for each entry.
   - Not including a specific sound to play will set to the default.wav sound.
 - Will play any .wav file you save to the /data/sounds folder.
  
## Commands ##
`[optional] <required>`
 - add/a \<name> [sound file name] - Add a name with an optional sound file.
   - Do not include the extension in the sound file name.
   - Use quotes to surround an NPC/mob name that contains spaces.
 - remove/r \<name> - Remove a name.
 - test/t \<sound file name> - Test a sound file. Do not include the file extension.
   - New sounds added to the /data/sounds folder must be .wav format.
 - list/l - Show the list of names and sounds associated.

## Version History ##

1.1
- Added setting for detection distance range.
- Fixed a name save formatting issue.

1.0.1
- Updated help

1.0
- Initial release.
