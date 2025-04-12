# GaolPlan
(pronounced "*jail plan*")  

Helps players plan and optimize their approach to *Odyssey Gaol* runs. It provides a clean, mouse-driven interface for selecting bosses and assigning jobs across up to three Phones, ensuring no job is duplicated. With built-in save functionality, your most recent plans can be saved for easy reuse or adjustments, making it an ideal tool for statics or pick up groups.  

![GaolPlan_bosses](https://github.com/user-attachments/assets/277cccd3-6c83-4c02-b42a-10e18b1a855a)  
![GaolPlan_jobs](https://github.com/user-attachments/assets/0a6b260b-3489-48b2-aa38-16e20157d26e)  


# Features

- Select up to **three Gaol bosses** per run.
- Assign jobs to each boss attempt.
- Built-in **job duplication prevention**.
- Fully **mouse-driven interface** for easy interaction.
- Copy plans to clipboard or send to party chat.
- **5 save slots** to remember your setups.
- Designed to reduce planning time and improve group coordination.
- Compatible with the [BattlePlan](https://github.com/iLVL-Key/FFXI/tree/main/addons/BattlePlan) addon.

# Commands
`//gaolplan` or `//gp` will bring up the GaolPlan window. That's it! The addon is otherwise entirely GUI-based.

# Limitations

- Save data does not save specific players, only the party member positions. If you load a save, take care to either use the party menu option to rearrange party members or adjust the jobs in the list to match the players.

# Changelog

Version 1.2.1
- Fixed Save data not behaving as intended.
- Fixed the Back button in the options screen from incorrectly going back to the Boss select screen instead of the Job select screen under certain circumstances.

Version 1.2
- Adjusted job label on the job select screen to be highlighted on mouse hover matching how the names are highlighted.
- Fixed Copy buttons copying when disabled (no jobs selected within their respective phone/boss.
- Fixed Clear button on the job select screen not being disabled when no jobs for any phones are selected.

Version 1.1
- Added confirmation window for certain buttons.
- Fixed BG Alpha not being restored to default correctly.

Version 1.0
- Initial release.
