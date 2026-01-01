# VanaFacts

Display one of over 800 "facts" about Vana'diel and FFXI in general during zoning screens.

![VanaFacts](https://github.com/user-attachments/assets/b85aaecf-a4cd-425b-8962-ba832752633d)


## Commands
All commands must be preceded with either `//vanafacts` or `//vf` (ex: `//vf repeat`)  
 - `repeat/r` - Repeat the last Fact displayed.
 - `help` - Display a list of commands and addon info.

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
Version 1.4.1
- Added math.randomseed(os.time()) to ensure better randomization.

Version 1.4
- Adjusted how the text is centered on screen. Is now accurately centered.
- Removed the char_width_multiplier option as it is no longer needed.

Version 1.3
- Added repeat/r command - Repeats the last Fact displayed.
- Adjusted Help text.

Version 1.2
- Added addon command section to let the user know there are no addon commands.

Version 1.1
- Added random_number_buffer option. Keeps track of the last x number of facts picked to reduce possibility of duplicates.
- Adjusted the after_zone_fade_delay default value from 3 to 4 seconds.

Version 1.0
- First version
