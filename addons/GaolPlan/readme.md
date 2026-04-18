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

## Mouse Position
If you find the mouse is not lining up vertically with the menu, go into the `data/settings.xml` file and adjust the `mouse_vertical_offset` by the number of pixels you think it is off. Save and reload the addon. You may need to try a few times to get it right.

# Limitations

- Save data does not save specific players, only the party member positions. If you load a save, take care to either use the party menu option to rearrange party members or adjust the jobs in the list to match the players.

------
<p align="center">
  <em>Support development in Vana'diel</em>
</p>

<p align="center">
  <a href="https://www.paypal.com/donate/?hosted_button_id=7NELJEHF84YRQ">
    <img src="https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif" alt="Donate with PayPal">
  </a>
</p>

<p align="center">
  I have put hundreds of hours into creating these addons and GearSwap files.<br>
  All of my work is <em>Donate What You Want</em> - contribute whatever you feel it’s worth.
</p>

------

# Changelog

Version 1.4.1
- Adjusted a number of instances of the formatRGB function as well as the spacing calculations for centering boss names to be pre-calculated instead of run multiple times per update.
- Removed 0.05 second polling rate. Determined it was causing issues when a mouse click down was caught and correctly prevented from going through to the game, but the mouse click up was not and would go through to the game and cause the game to thin you weree click and dragging your mouse.

Version 1.4
- Added `mouse_vertical_offset` setting. This should help the people who have issues with the mouse not lining up correctly with the buttons.
- Added 0.05 second polling rate to help improve frame rate.
- Fixed Clear button on Bosses screen not working correctly.

Version 1.3.1
- Fixed an occasional error when clearing jobs.

Version 1.3
- Added the name of the Save Slot (boss names summary) to the Delete Save Slot confirmation window.
- Added confirmation screens to the Load and Save buttons as well as the Clear button on the Boss selection screen, since all of those actions could overwrite/delete other data/selections.
- Fixed mouse clicks inside the window from passing through to the game when window is pinned in place (ie non-draggable).

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

------

<p align="center">
<h2 align="center">AI Usage</h2>
</p>

<p align="center">
I use AI more for assistance, rather than letting it do it for me and straight-up vibe coding things. When I started learning how to code I did it because I thought it woud be cool to make useful things, and I wanted to learn for myself. Shortly after I started ChatGPT was released and since then I've purposely and specifically used it as a teaching tool. At first I would explain ideas that I wanted to do, not really know how to do them myself, then read through what it provided to be sure I understood what it was doing, asking it to expain specific sections I didn't understand. Then I would type in all the code myself rather than copy and paste, so that the learning would better stick with me. For the most part now, I find I mostly use it to create and access data within tables for me, just doing the tedious loop creating stuff.
</p>

------
