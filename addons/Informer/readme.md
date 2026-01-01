# Informer
Displays a bar with information (much like InfoBar!)


![Keylesta 2024-02-22 04 39 14](https://github.com/iLVL-Key/FFXI/assets/101156258/cf77b9fe-f046-471a-a37d-c5ccb4e79fe2)

![Informer_Sub_Bars_1](https://github.com/user-attachments/assets/fcb1d3a9-9603-4a26-af51-53baf502557c)

![Informer_Sub_Bars_2](https://github.com/user-attachments/assets/d400b9a2-8386-4ac5-a7b4-7af88d8bfd0f)


## Features
- Main bar
  - Can use a different layout per job that can be customized however you'd like using placeholders.
- Sub1 and Sub2 bars
  - Not tied to job like the Main bar is.
  - Can each be individually turned on or off.
  - Can be customized using placeholders.
  - Can be centered and stays centered as the data in them changes.
  - Can be turned off if the area has no map (to match how the FFXIDB minimap doesn't show when there is no map).
- Minimum widths for most sections.
  - Controls how wide these sections are, creating a more static overall width for the bar, and preventing other sections after them from moving around.
  - Set to 0 to turn off
- Colors!
  - Day, weather, and food, etc
  - Warning when your main inventory is near to or full
  - Warning when tracked items are low
  - Can be disabled

## Placeholders
- **${day}** - Current Vana'diel day
- **${direction}** - Current direction your character is facing
- **${distance}** - Distance to current target/sub-target
- **${earth_date}** - Current Earth Date
- **${earth_day}** - Current Earth Day
- **${earth_time}** - Current Earth time
- **${food}** - Current food you have (tracked per character)
- **${gil}** - Current gil amount
- **${inventory}** - Current number of items in your main inventory / total main inventory slots
- **${job}** - Current job/sub you are on
- **${mlvl}** - Current jobs master level (NOTE: mlvl is updated when the packet for it is called, so will not be correct immediately upon loading)
- **${moon_percent}** - Current moon phase by percent
- **${moon_phase}** - Current moon phase by name
- **${name}** - Current characters name
- **${pos}** - Current map position
- **${region}** - Current region
- **${reraise}** - Current reraise status
- **${speed}** - Current movement speed
- **${target}** - Current target/subtarget
- **${target_w_hpp}** - Current target/subtarget including its HP%
- **${time}** - Current Vana'diel time
- **${tp}** - Current TP
- **${track:Item Name}** - Current number of X item in your main inventory / current total number of X item between your inventory, satchel, case, and sack
  - Able to track any item in the game.
  - The item name must be spelled exactly as it appears in the items list (not the longer descriptive name) and is case sensitive.
- **${weather}** - Current Vana'diel weather
- **${zone}** - Current zone

## Commands
All commands must be preceded with `//informer` or `//info` (ex: `//info color`)  
`[optional] <required>`
- `pos [x y]` - Update position.
- `lock/unlock` - Update position via drag.
- `size [#]` - Update font size.
- `bold` - Update bold setting.
- `color` - Update color setting.
- `help` - Display a list of commands and addon info.

## Earth Data Formatting
Earth Date, Day, and Time placeholders are able to be modified in `data/settings.xml` file  
- `%Y` - Year in full (e.g., 2025)
- `%y` - Last two digits of the year (e.g., 25 for 2025)
- `%m` - Month as a two-digit number (01 to 12)
- `%d` - Day of the month as a two-digit number (01 to 31)
- `%H` - Hour in 24-hour format (00 to 23)
- `%I` - Hour in 12-hour format (01 to 12)
- `%M` - Minute as a two-digit number (00 to 59)
- `%S` - Second as a two-digit number (00 to 59)
- `%p` - AM or PM (uppercase)
- `%a` - Abbreviated weekday name (e.g., Mon)
- `%A` - Full weekday name (e.g., Monday)
- `%b` - Abbreviated month name (e.g., Jan)
- `%B` - Full month name (e.g., January)
- `%j` - Day of the year number (001 to 366)
- `%w` - Day of the week number (0 for Sunday, 6 for Saturday)
- `%x` - Locale’s date representation (e.g., 01/16/25)
- `%X` - Locale’s time representation (e.g., 14:55:02)

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

## Changelog

Version 5.1.1
- Temporary fix for Windower get_info().moon_phase bug. Determines moon phase based on moon percent, waiting for the percent to update after addon load to determine which direction the moon phase is going (waxing or waning).

Version 5.1
- Added right_align options for Sub1 and Sub2 Bars. (Main Bar can still be right aligned using the flags/right option)

Version 5.0.1
- Fixed Sub1 and Sub2 bars displaying when the addon is loaded inside of your mog house and the hide_when_no_map setting is on.
- Minor code cleanup.

Version 5.0
- Added two new sub bars. These bars use the same placeholder system, have their own settings for visibility and position, are able to be centered, and can be hidden when there is no map for the current area (matching how the FFXIDB minimap functions). They are not tied to jobs like the Main bar is. (thanks github user Zorlac!)
- Added sub1pos and sub2pos commands to set the position of the sub bars.
- Added Region (thanks github user Zorlac!), Earth Day, and Earth Date placeholders.
- Added settings to edit the earth data formatting.
- Adjusted the layout structure in the settings file to accomodate the two new sub bars in addition to the main bar.
- Adjusted Earth Time 12 and Earth Time 24 placeholders down to just Earth Time.
- Renamed the pos command to mainpos to accomodate the two new sub bars.
- Renamed the "display" table in the settings file to "options" to be consistant with my other addons.
- Removed the default layout from the settings file as it wasn't actually used after the file is first created.
- Removed the lock/unlock commands.

Version 4.2
- Added Moon Phase Name and Moon Phase Percent placeholders (thanks Asura.Jhoo!)

Version 4.1
- Added Distance placeholder (thanks Asura.Toralin!)

Version 4.0
- Overhauled overall addon efficiency, *especially* Item Tracking.
- Fix update job on SJ Restriction.

Version 3.2
- Added Earth Time placeholders (12HR and 24HR formats).
- Added Movement Speed placeholder.

Version 3.1
- Added Reraise placeholder.

Version 3.0
- Added the ability to customize the layouts (and per job now) via placeholders.
- Added the ability to track literally any item in the game without needing the items id number.

Version 2.0
- Added ability to turn specific sections on or off.
- Removed reliance on the Text plugin.

Version 1.0
- Original version
