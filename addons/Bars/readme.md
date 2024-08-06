# Bars
Displays bars for player HP, MP, TP, Target, and Focus Target, as well as Actions for Targets.  

![Bars_target_actions](https://github.com/user-attachments/assets/c6d239db-4483-4272-8cbb-068706223b6a)  
(The blue bar in this gif is the current target, which also shows the action the target is currently performing)
## Features
- Player Stats (HP/MP/TP/Pet) can be turned on/off individually per job (ie SAM shows only TP, while PLD shows HP, MP, and TP)
  - Bars automatically align to the top, but vertical offset can be adjusted per job if you prefer them aligned to the bottom.
- Target bars colored based on type (NPC, Party member, mob claimed by someone else, etc.)
- Target Actions
  - Displays casting, completed, and interrupted icons.
  - Tracks every player/mob around as they perform actions, so you can tab around and target mid-action and still see what they are doing.
  - Spells are colored based on their element.
  - The target of the action is colored based on type.
- Auto Focus Target
  - Add/remove targets to a list to automatically display a focus target for.
    - Can track by name or ID.
  - Displays the Focus Targets actions as well.
  - Automatically hides the Focus Target when it is targeted.
  - [COMING SOON] Can temporarily override the Focus Target.
- Display the Index number for targets.
  - Useful for NM placeholder camping, or designating a specific mob for others to target.
- Markers on the TP bar for 1k/2k, and on the HP bar for yellow HP.
- Features can be turned on/off or adjusted via settings file or in-game commands

## Commands
All commands must be preceded with `//bars`
`[optional] <required>`
 - **pos [x y]** - Update position
 - **hp/mp/tp/pet** - Toggle HP/MP/TP/Pet bar display setting for current job.
 - **width/w** - Update the bar width.
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
