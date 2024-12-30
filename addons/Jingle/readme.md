# Jingle #

Plays a sound and displays a chat notification when a target (player, mob, or NPC) is nearby.  

![Jingle_Oseem](https://github.com/iLVL-Key/FFXI/assets/101156258/5ed6b45b-e798-4e1e-92dc-27d7490fcca1)

## Features ##
 - Plays only once until the target moves out of range again.
 - Will work using names, IDs, or Hex IDs (great for NM placeholders).
 - Can specify a sound to play for each target.
   - Not including a specific sound to play will set to the default.wav sound.
 - Will play any .wav file you save to the /data/sounds folder.
  
## Commands ##
All commands must be preceded with `//jingle`  
`[optional] <required>`
 - **add/a** \<target> \[sound_file_name] - Add a target with an optional sound file.
   - Valid targets: Names (ex: Oseem), IDs (ex: 17809550), Hex IDs (ex: 08E).
   - Use quotes to surround an NPC/mob name that contains spaces.
   - Do not include the extension in the sound file name.
 - **remove/r** \<target> - Remove a target.
 - **list/l** - Show the list of targets and sounds associated.
 - **distance/d** <#1-50> - Set the detection distance.
 - **test/t** \<sound_file_name> - Test a sound file. Do not include the extension.
   - New sounds added to the /data/sounds folder must be .wav format.
 - **help** - Display a list of commands and addon info.

## Sortie targets ##
Copy the following into your settings file (inside the targets) for all the Sortie targets. The top 8 sets of numbers are the IDs for the 4 exit bitzers in the basement, for some reason using the name for the as a target does not work correctly, and there are multiple sets.
<details>
<summary>Sortie Targets</summary>
 
```
            <21005124>
                <soundfile>default</soundfile>
            </21005124>
            <21005125>
                <soundfile>default</soundfile>
            </21005125>
            <21005126>
                <soundfile>default</soundfile>
            </21005126>
            <21005127>
                <soundfile>default</soundfile>
            </21005127>
            <21001028>
                <soundfile>default</soundfile>
            </21001028>
            <21001029>
                <soundfile>default</soundfile>
            </21001029>
            <21001030>
                <soundfile>default</soundfile>
            </21001030>
            <21001031>
                <soundfile>default</soundfile>
            </21001031>
            <abject_obdella>
                <soundfile>default</soundfile>
            </abject_obdella>
            <biune_porxie>
                <soundfile>default</soundfile>
            </biune_porxie>
            <cachaemic_bhoot>
                <soundfile>default</soundfile>
            </cachaemic_bhoot>
            <demisang_deleterious>
                <soundfile>default</soundfile>
            </demisang_deleterious>
            <esurient_botulus>
                <soundfile>default</soundfile>
            </esurient_botulus>
            <fetid_ixion>
                <soundfile>default</soundfile>
            </fetid_ixion>
            <gyvewrapped_naraka>
                <soundfile>default</soundfile>
            </gyvewrapped_naraka>
            <haughty_tulittia>
                <soundfile>default</soundfile>
            </haughty_tulittia>
```
</details>

## Version History ##

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
