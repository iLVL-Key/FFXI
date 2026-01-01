# Helper
The Helper addon acts as a customizable in-game assistant that provides alerts, notifications, and flavor text to enhance the player's experience. The addon features a system of "Helpers"—virtual companions that deliver messages in chat, track important gameplay events, and provide reminders. The default Helper, Vana, offers encouragement, alerts players about key game mechanics (such as abilities becoming ready or capped job/merit points), and notifies them of party-related events like members joining or leaving.

Players can load different Helpers, each with its own personality and dialogue, and cycle between them. The addon also supports sound effects for key notifications and reminders for gameplay mechanics like Sublimation being fully charged or Vorseal effects nearing expiration. With its blend of functionality and personality, Helper adds both utility and charm to the FFXI experience.
## Helpers
Choose your companion! Each has their own unique personality!  
### Default
**Vana** - Friendly, encouraging, and always positive.  
The default Helper. Has no Faceplate, and uses the default sounds.

### NPCs
| ![Shantotto](https://github.com/user-attachments/assets/18178a4d-ab89-4b3e-a99c-2b66a2394243) | ![Moogle](https://github.com/user-attachments/assets/72b7bb44-c0e9-41a1-8af6-0faa6852aab3) | ![Mayakov](https://github.com/user-attachments/assets/11961710-5f2d-4af9-8f55-ebf54d041a45) |
|---|---|---|
| **Shantotto**  | **Moogle**  | **Mayakov**  |
| Witty, rhyming, and slightly menacing. | Cheerful, helpful, and full of "kupo!" | Flamboyant, theatrical, and obthethed with perfecthion. |

| ![Altana](https://github.com/user-attachments/assets/c7c91a06-5dcf-4b0e-9792-09af916987a3) | ![Promathia](https://github.com/user-attachments/assets/1c71e534-d2df-43c1-a78a-967a0dfd0294) |
|---|---|
| **Altana**  | **Promathia**  |
| Warm, comforting, and protective. | Dark, foreboding, and indifferent to your struggles. |

| ![faceplate_small](https://github.com/user-attachments/assets/4751a585-8cf5-41f9-bafc-9a169941c8a4) | ![faceplate_small](https://github.com/user-attachments/assets/82bd8074-1fa0-405b-a27b-42c3bae6c07c) |
|---|---|
| **Brygid**  | **Gilgamesh**  |
| Fabulously judgmental and fashion-obsessed.  | Gruff, tough, and plenty of hidden heart. |

### Players
| ![Azhur](https://github.com/user-attachments/assets/38a6c564-3245-4b6b-8dea-8eb491674cf2) | ![Galin](https://github.com/user-attachments/assets/a5db9576-3123-476d-91c6-f8d97c676e4d) |
|---|---|
| **Azhur**  | **Galin**  |
| Super sweet, full of charm, and a little quirky. | Flirty, fun, and fueled by tequila. |

| ![Kolo](https://github.com/user-attachments/assets/51483097-44c8-4093-ab94-42c4c15c42a8) | ![Sigue](https://github.com/user-attachments/assets/d1f5d3b4-a78b-4ffd-a8b7-0f620f57ddb4) |
|---|---|
| **Kolo**  | **Sigue**  |
| Loud, chaotic, and full of love (and expletives). | Super nice guy, loves San d'Oria maybe a little too much. |

### Special Guests
| ![faceplate_small](https://github.com/user-attachments/assets/35520a01-d7a8-438d-ba21-3ac397928889) |
|---|
| **Lefty** |
| Always willing to give a helping hand. |

## Features
- <ins>**Automated Notifications & Alerts**</ins>
  - **Ability Ready Alerts** → Notifies you when an ability is ready to use.
  - **Job Points & Merit Points Capped** → Alerts you when you reach the max.
  - **Party & Alliance Updates** → Get messages when members join or leave.
  - **Key Item Reminders** → Never forget to pickup a Mystical Canteen, Moglophone, or Shiny Ra'Kaznarian Plate again.
  - **Sublimation Charged** → Tells you when Sublimation is fully charged.
  - **Vorseal Wearing** → Notifies you when your Vorseal buff is about to expire.
  - **Mireu Pop Alerts** → Notifies you when the NM Mireu is mentioned.
  - **Mog Locker Expiring** → Don't let your Mog Locker lease expire.
  - **Reraise Check** → Don't forget... again.
- <ins>**Enhanced Party Awareness**</ins>
  - **Low MP Warnings** → Alerts you if a party member needs Refresh.
  - **Party & Alliance Updates** → Get messages when members join or leave.
  - **You Became Party/Alliance Leader** → Tells you when you’re promoted to leader.
- <ins>**Interchangeable Helper System (Custom NPC-Like Assistants)**</ins>
  - Choose from multiple Helper personalities.
  - Easily switch between Helpers.
  - Create your own!
- <ins>**GitHub-Powered Updates**</ins>
  - **Checks for new Helpers** → New available Helpers added to the GitHub repo.
  - **Checks for Helper updates** → Updates available for current Helpers you have.
  - **Checks for addon updates** → Update available for the addon itself (Helper.lua).
  - **Optional automatic updates** → Updates addon and Helpers automatically (if enabled).
- <ins>**Customization & User Control**</ins>
  - Choose between automatic or manual updates.
  - Enable/disable individual Helpers.
  - Modify Helper settings & messages in XML files.

## How To Setup
1. Save the addon to `/addons/Helper/Helper.lua`.
   - All you need to start is the `Helper.lua` file itself. Everything else will be downloaded in step 3.
2. Load the addon with `//lua load helper`.
   - Vana is the default Helper and will automatically be created and loaded into the addon.
3. Update the addon by typing `//helper update`.
   - This will download and install the latest version of the addon, including all sound files, as well as download and load all current Helpers into the addon.

## Commands
All commands must be preceded with `//helper` (ex: `//helper list`)  
`<required>` `[optional]`

| Command | Description |
|---------|-------------|
| *(blank, no command)* | Cycle to the next loaded Helper. |
| `load/l <file_name>` | Load a Helper file into the addon and select for use.<br> - Helper files must be in the `/data/helpers` folder.<br> - Loaded Helpers are saved and do not need to be loaded again unless unloaded. |
| `unload/u <file_name>` | Unload a Helper file from the addon.<br> - Unloaded Helper files are not deleted but are set to disabled. |
| `list` | List currently loaded Helpers. |
| `random/r` | Selects a random Helper to use. |
| `voices/v` | Selects a random Helper to use for EACH alert/notification. |
| `sound/s` | Switch sounds between Custom Helper, Default, or off. |
| `face/f` | Switch Helper Faceplates between Large, Small, or off. |
| `check [new\|current\|addon]` | Check for new updates. Does not update. |
| `update [new\|current\|addon\|full]` | Download new updates.<br> - `new` - Download new Helpers only.<br> - `current` - Update current Helpers only.<br> - `addon` - Update the Helper addon itself only.<br> - `full` - Force a full redownload of everything. |
| `help` | Display a list of commands and addon info. |


## Options
Open the `/Helper/data/settings.xml` file to adjust these settings.

| Option | Description |
|--------|-------------|
| `ability_ready` | Alerts you when specific Job Abilities are ready to use again. Includes all SP abilities and abilities with recasts 10 minutes or longer. |
| `after_zone_party_check_delay_seconds` | Amount of time to pause watching for party structure changes after zoning. Adjust this higher if you get a notification about leaving then immediately joining a party after you zone. |
| `auto_check_for_updates` | Automatically check for updates. |
| `auto_check_for_updates_delay_days` | Days between automatically checking for updates. |
| `auto_update` | Automatically update all files once per week. This will be run instead of `auto_check_for_updates` if set to true. |
| `check_party_for_low_mp` | If you are on BRD or RDM, will keep an eye on your party members' MP levels.<br> - Only watches party members with Max MP over 1,000. |
| `check_party_for_low_mp_delay_minutes` | Amount of time after alerting you to a party member with low MP to start watching again. |
| `current_helper` | The currently loaded and active Helper.<br> - It is better to change this in-game with `//helper` to cycle Helpers or `//helper load name_of_helper` to load a specific Helper directly. |
| `flavor_text` | Display the occasional Flavor Text from the currently loaded Helper. |
| `flavor_text_in_combat` | Controls flavor text displaying while in combat. |
| `flavor_text_window_max_hours` | The maximum amount of time before the next Flavor Text is displayed. |
| `flavor_text_window_min_hours` | The minimum amount of time before the next Flavor Text is displayed. |
| `helpers_loaded` | The list and enabled status of all currently loaded Helpers.<br> - It is better to change the enabled status of loaded Helpers in-game with `//helper unload name_of_helper` or `//helper load name_of_helper`. |
| `introduce_on_load` | Plays the current Helper’s introduction text when the addon is loaded. |
| `key_item_reminders` | Alerts you when specific Key Items are ready to be picked up again from their respective NPCs.<br> - Tracks Mystical Canteen, Moglophone, and Shiny Ra'Kaznarian Plate.<br> - Sub-settings for turning tracking off for each individually.<br> - Sub-settings for adjusting the amount of time between additional repeat reminders after the first for each individually. |
| `notifications` | Alerts you about certain events happening.<br> - Alerts for Capped Job Points, Capped Merit Points, Mireu popping, Mog Locker lease expiring, Reraise wearing off, Signet (includes all "region" buffs) wearing off, Sublimation fully charged, and Vorseal wearing off.<br> - Sub-settings for turning alerts off for each individually. |
| `party_announcements` | Alerts for any party structure updates.<br> - Alerts for party/alliance members joining or leaving, parties joining or leaving alliance, and you becoming party or alliance leader.<br> - Sub-settings for turning alerts off for each individually. |
| `random_helper_on_load` | Selects a random Helper to use each time the addon loads. |
| `reraise_check` | Alert letting you know that you are missing Reraise. |
| `reraise_check_delay_minutes` | Amount of time between each Reraise check. |
| `reraise_check_not_in_town` | Will not alert you of Reraise missing if in a town zone. |
| `sound_effects` | Play sound effects for alerts and notifications. |
| `sparkolade_reminder` | A weekly reminder to use your Sparks and Accolades. Will play at login if the day/time passes while logged out. |
| `sparkolade_reminder_day` | Day of the week the Sparkolade reminder will run.<br> - Is not case-sensitive and accepts full day names and common abbreviations such as `tu`, `tue`, and `tues`.<br> - Defaults to Saturday if unable to determine the day. |
| `sparkolade_reminder_time` | Time the Sparkolade reminder will run.<br> - Time must be a number in military time, i.e., `1730` instead of `5:30 PM`.<br> - Defaults to `1200` if unable to determine time. |
| `voices` | Randomly selects an active Helper to use for each alert. |

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
Version 2.3.2
- Adjusted the zoning check so it's watching packets instead of running every prerender.

Version 2.3.1
- Fixed Mystical Canteen, Moglophone, and Ra'Kaznarian Plate KI ready status not resetting correctly after obtaining the KI again.

Version 2.3
- Added Mystical Canteen, Moglophone, and Ra'Kaznarian Plate KI ready status to Help command.
- Removed Next Sparkolade Reminder from Help command.

Version 2.2.2
- Fixed Faceplate getting left on screen if triggered right before logging out.

Version 2.2.1
- Adjusted list of New Helpers (`//helper check new`) to be sorted alphabetically.
- Adjusted list of Helpers (`//helper list`) to show both loaded and unloaded Helpers.

Version 2.2
- Adjusted timestamps for canteen, moglophone, and plate reminders, as well as mog locker expiration being saved based on character name. This allows different characters to have their own timestamps.

Version 2.1.1
- Fixed an issue with faceplate options not saving correctly.
- Fixed an issue with sound options not saving correctly.

Version 2.1
- Added the ability to have sound files for `sparkolade_reminder`, `reminder_canteen`, `reminder_moglophone`, and `reminder_plate`, `mog_locker_expiring`, `capped_merit_points`, `capped_job_points`, `party_low_mp`, `sublimation_charged`, `food_wears_off`, `reraise_wears_off`, `signet_wears_off`, `mireu_popped`, `vorseal_wearing`, `reraise_check`. This now allows for all notifications to have custom sound files.
- Adjusted the zoning and paused flags to condense into just the paused flag. This also fixes a few notifications that would trigger unintentionally.
- Fixed help text for the face command.

Version 2.0.1
- Fixed Alliance join/left custom sounds not playing.

Version 2.0
- Overhauled folder structure. The `sounds` folder has been renamed to `media` and moved inside the `/data/helpers` folder. If you are upgrading from a previous version, you may safely delete the `/data/sounds` folder.
- Added support for Custom Helper sounds. Will use sounds in a `/data/media/helper_name` folder for the current Helper if present, otherwise uses the default sounds in the `data/media/` folder.
- Added support for Helper Faceplates. Will briefly display an image of the current Helper when a notification/alert plays. Stored in a `/data/media/helper_name` folder.
- Added `sounds/s` in-game command to cycle sounds: Custom Helper > Default > Off
- Added `face/f` in-game command to toggle Helper Faceplates on or off.
- Added `update full` subcommand. Forces a full redownload of everything.
- Added `flavor_text_in_combat` option to control flavor text displaying while in combat.
- Added `auto_check_for_updates_delay_days` option to set how many days between the auto check for updates. Default has been updated from the hard-coded 7 days to 30 days.
- Added a 5 second wait after logging in before auto check/update runs.
- Added additional options for party announcement sounds, and will follow a hierarchy to decide which sound to use if not available.
  - member_joined_party now has you_joined_party, you_joined_alliance, member_joined_party, and member_joined_alliance.
  - member_left_party now has you_left_party, you_left_alliance, member_left_party, and member_left_alliance.
  - party_joined_alliance now has your_party_joined_alliance, and other_party_joined_alliance.
  - party_left_alliance now has your_party_left_alliance, and other_party_left_alliance.
  - Added small (0.1 second) pauses inside download functions to prevent complete freezing of the game while they run. This was especially noticeable when updating the first time or when running the new `update full` subcommand for a complete redownload of everything.
- Adjusted calls to download from GitHub to wait up to 5 seconds to make sure the download completes before moving on or giving up.
- Adjusted Reraise Reminder to pause while dead.
- Adjusted delay after login to let game values load from 2 to 5 seconds. This gives a little more leeway for slow loading and prevents the Sublimation notification from going off if you login with the buff already on you.
- Adjusted delay for running the automatic check for updates from 5 to 6 seconds to account for the above delay change (let's Helper introduction run first).
- Fixed Signet wearing off notification going off when switching from a character with to a character without.

Version 1.8.5
- Fixed Mog House in Al Zahbi not being recognized as a "town" zone.

Version 1.8.4
- Fixed Signet/Sanction/Sigil/Ionis wearing off notification playing when switching from one to another.

Version 1.8.3
- Fixed error displaying help command.

Version 1.8.2
- Fixed Auto Check and Auto Update from not actually doing either of those things.
- Fixed number of overall local variables. Condensed a lot of individual variables into tables.

Version 1.8.1
- Fixed Reraise wearing off message displaying incorrectly.
- Fixed error message when logging out to character select.

Version 1.8
- Added `random_helper_on_load` option to select a random Helper to use each time addon loads.
- Added `random` command. Select a random Helper to use.
- Fixed Reraise wearing off notification set to wrong buff (Drown).

Version 1.7
- Added `reraise_wears_off` notification.
- Added `signet_wears_off` notification. Applies to Signet, Sanction, Sigil, and Ionis.
- Fixed Food wearing off notification from playing when you die.

Version 1.6
- Added Food wearing off notification.

Version 1.5.1
- Fixed the `sparkolade_reminder` option not actually turning the option on or off.
- Fixed an issue with time of the next Sparkolade reminder drifting.

Version 1.5
- Added Voices Mode. Will randomly select an active Helper to use for each alert.
- Adjusted Sound effects to only play if the accompanying text is present.

Version 1.4
- Added Sparkolade reminder. A weekly reminder with the day and time able to be set by the user. Will play at login if day/time passes while logged out.
- Adjusted the Mog Locker expiration to only check at the top of every hour.
- Adjust the list command to display Helpers alphabetically.
- Fixed an issue where first logging into a character without capped Job Points would then trigger the Capped Job Points notification upon logging into a character with capped Job Points.
- Removed unused key_item_reminder_repeat_hours option.

Version 1.3
- Added Reraise reminder.
- Fixed Vorseal Wearing reminder not triggering under certain circumstances.

Version 1.2
- Added KI Reminders category.
- Added Mystical Canteen, Moglophone, and Shiny Ra'Kaznarian Plate KI Reminders.
- Added Notification category.
- Added Mog Locker expiring Notification.
- Added new Notification Sound Effect.
- Added after_zone_party_check_delay option. Amount of time to pause watching for party structure changes after zoning. Adjust this higher if you get a notification about leaving then immediately joining a party after you zone.
- Added Helper Type (NPC, Player, etc.)
- Added missing sound effect to Capped Job Points and Capped Merit Points
- Adjusted Capped Job Points, Capped Merit Points, Mireu Popped, Sublimation Charged, and Vorseal Wearing to fall under the Notifications category.
- Adjusted all Sound Effect options to fall under a single Sound Effect option.


Version 1.1
- Added check and download of sound files into the addon update commands. This now makes the Helper addon fully self-sufficient starting with just Helper.lua and no additional files.
- Added descriptions into the Helper files.
- Added "first run" messages displayed when loading the addon for the first time.
- Added chat log messages when running checks/updates.
- Adjusted the `list` command to now display the description of each Helper and in the appropriate colors for each.
- Adjusted the `help` command to show the description of the current Helper.
- Adjusted the `help` command to show the last update check date.

Version 1.0.2
- Adjusted auto_udate option to be false by default.
- Fixed issue where Dematerialize recast was not being tracked correctly.

Version 1.0.1
- Adjusted unloaded Helpers to stay in the settings table of loaded_helpers but to be set to false instead of completely removed. This prevents the Helper being listed as "new" when we check for new Helpers. I may circle back to this to add in additional enable/disable commands to handle this and revert unload to completely remove, but not sure if that's necessary.
- Adjusted a log of error messages relating to connecting to GitHub.
- Fixed an issue with unloading a Helper that is the currently active Helper not switching to the default Vana correctly.

Version 1.0
- Initial version
