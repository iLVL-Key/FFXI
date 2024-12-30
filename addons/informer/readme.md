# Informer
Displays a bar with information (much like InfoBar!)


![Keylesta 2024-02-22 04 39 14](https://github.com/iLVL-Key/FFXI/assets/101156258/cf77b9fe-f046-471a-a37d-c5ccb4e79fe2)


## Features
- Uses a layout (per job) that you can customize however you'd like using placeholders:
  - **${day}** - Current Vana'diel day
  - **${direction}** - Current direction your character is facing
  - **${earth_time_12}** - Current Earth time (12HR format)
  - **${earth_time_24}** - Current Earth time (24HR format)
  - **${food}** - Current food you have (tracked per character)
  - **${gil}** - Current gil amount
  - **${inventory}** - Current number of items in your main inventory / total main inventory slots
  - **${job}** - Current job/sub you are on
  - **${mlvl}** - Current jobs master level (NOTE: mlvl is updated when the packet for it is called, so will not be correct immediately upon loading)
  - **${pos}** - Current map position
  - **${reraise}** - Current reraise status
  - **${speed}** - Current movement speed
  - **${target}** - Current target/subtarget
  - **${target_w_hpp}** - Current target/subtarget including its HP%
  - **${time}** - Current Vana'diel time
  - **${tp}** - Current TP
  - **${track:Item Name}** - Current number of X item in your main inventory / current total number of X item between your inventory, satchel, case, and sack
    - Informer is able to track any item in the game.
    - The item name must be spelled exactly as it appears in the items list (not the longer descriptive name) and is case sensitive.
  - **${weather}** - Current Vana'diel weather
  - **${zone}** - Current zone you are in
- Minimum widths for most sections.
  - Controls how wide these sections are, creating a more static overall width for the bar, and preventing other sections after them from moving around.
  - Set to 0 to turn off
- Colors! (which can be turned off)
  - Day, weather, and food, etc
  - Warning when your main inventory is near to or full
  - Warning when tracked items are low

## Commands
All commands must be preceded with `//informer` or `//info`  
`[optional] <required>`
- **pos [x y]** - Update position.
- **lock/unlock** - Update position via drag.
- **size [#]** - Update font size.
- **bold** - Update bold setting.
- **color** - Update color setting.
 - **help** - Display a list of commands and addon info.
