# Helper
The Helper addon acts as a customizable in-game assistant that provides alerts, notifications, and flavor text to enhance the player's experience. The addon features a system of "Helpers"—virtual companions that deliver messages in chat, track important gameplay events, and provide reminders. The default Helper, Vana, offers encouragement, alerts players about key game mechanics (such as abilities becoming ready or capped job/merit points), and notifies them of party-related events like members joining or leaving.

Players can load different Helpers, each with its own personality and dialogue, and cycle between them. The addon also supports sound effects for key notifications and reminders for gameplay mechanics like Sublimation being fully charged or Vorseal effects nearing expiration. With its blend of functionality and personality, Helper adds both utility and charm to the FFXI experience.

![Helpers_list](https://github.com/user-attachments/assets/791deba5-f990-4766-a5c8-e6dcac9555d3)

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
  - Easily switch between Helpers
  - Create your own!
- <ins>**GitHub-Powered Updates**</ins>
  - **Checks for new Helpers** → Detects new available Helpers.
  - **Checks for Helper updates** → Notifies you if an update is available to current Helpers.
  - **Updates the addon itself** → Updates the addon (Helper.lua) when a new version is released.
  - **Optional automatic updates** → Updates addon and Helpers automatically (if enabled in settings).
- <ins>**Customization & User Control**</ins>
  - Choose between automatic or manual updates
  - Enable/disable individual Helpers
  - Modify Helper settings & messages in XML files

## How To Setup
1. Be sure to save the addon to `addons/Helper/Helper.lua`.
2. Load the addon with `//lua load helper`.
3. Vana is the default Helper and will automatically be created and loaded into the addon.
4. Update the addon by typing `//helper update`.
   - This will download and install the latest version of the addon, including all sound files, as well as download and load all current Helpers into the addon.
6. Type `//helper` (with no additional command) to cycle between Helpers you have loaded, or type `//helper load moogle` to select a specific Helper.
   - The name "moogle" in this example represents the name of the file, is case insensitive, and does not require the `.xml` attached.

## Commands
All commands must be preceded with `//helper` (ex: `//helper list`)  
`<required>` `[optional]`
- `(blank, no command)` - Cycle to the next loaded Helper.
- `load/l <file_name>` - Load a Helper file into the addon and select for use.
  - Helper files must be in the `/data/helpers` folder.
  - Loaded Helpers are saved and do not need to be loaded again unless unloaded.
- `unload/u <file_name>` - Unload a Helper file from the addon.
  - Unloaded Helper files are not deleted but are set to disabled.
- `list` - List currently loaded Helpers.
- `random/r` - Selects a random Helper to use.
- `voices/v` - Selects a random Helper to use for EACH alert/notification.
- `check [new|current|addon]` - Check for new updates. Does not update.
- `update [new|current|addon]` - Download new updates.
- `help` - Display a list of commands and addon info.

## Options
Open the `/Helper/data/settings.xml` file to adjust these settings.
- `ability_ready` - Alerts you when specific Job Abilites are ready to use again. Includes all SP abilities and abilities with recasts 10 minutes or longer.
- `after_zone_party_check_delay_seconds` - Amount of time to pause watching for party structure changes after zoning. Adjust this higher if you get a notification about leaving then immediately joining a party after you zone.
- `auto_check_for_updates` - Automatically check for updates once per week.
- `auto_update` - Automatically update all files once per week. This will be run instead of auto_check_for_updates if set to true.
- `check_party_for_low_mp` - If you are on BRD or RDM, will keep an eye on your party members MP levels.
  - Only watches party members with Max MP over 1,000.
- `check_party_for_low_mp_delay_minutes` - Amount of time after alerting you to a party member with low MP to start watching again.
- `current_helper` - The currently loaded and active Helper.
  - It is better to change this in-game with `//helper` to cycle Helpers or `//helper load name_of_helper` to load a specific Helper directly.
- `flavor_text` - Display the occasional Flavor Text from the currently loaded Helper.
- `flavor_text_window_max_hours` - The maximum amount of time before the next Flavor Text is displayed.
- `flavor_text_window_min_hours` - The minimum amount of time before the next Flavor Text is displayed.
- `helpers_loaded` - The list and enabled status of all Helpers currently loaded Helpers.
  - It is better to change the enabled status of loaded Helpers in-game with `//helper unload name_of_helper` or `//helper load name_of_helper`.
- `introduce_on_load` - Plays the current Helpers introduction text when the addon is loaded.
- `key_item_reminders` - Alerts you when specific Key Items are ready to be picked up again from their respective NPCs.
  - Tracks Mystical Canteen, Moglophone, and Shiny Ra'Kaznarian Plate.
  - Sub-settings for turning tracking off for each individually.
  - Sub-settings for adjusting the amount of time between additional repeat reminder after the first for each individually.
- `notifications` - Alerts you about certain events happening.
  - Alerts for Capped Job Points, Capped Merit Points, Mireu popping, Mog Locker lease expiring, Reraise wearing off, Signet (includes all "region" buffs) wearing off, Sublimation fully charged, and Vorseal wearing.
  - Sub-settings for turning alerts off for each individually.
- `party_announcements` - Alerts for any party structure updates.
  - Alerts for party/alliance members joining or leaving, parties joining or leaving alliance, and you becoming party or alliance leader.
  - Sub-settings for turning alerts off for each individually.
- `random_helper_on_load` - Selects a random Helper to use each time addon loads.
- `reraise_check` - Alert letting you know that you are missing Reraise.
- `reraise_check_delay_minutes` - Amount of time between each Reraise check.
- `reraise_check_not_in_town` - Will not alert you of Reraise missing if in a town zone.
- `sound_effects` - Play sound effects for alerts and notifications.
- `sparkolade_reminder` - A weekly reminder to use your Sparks and Accolades. Will play at login if day/time passes while logged out.
- `sparkolade_reminder_day` - Day of the week the Sparkolade reminder will run.
  - Is not case-sensitive and accepts full day name and common abbreviations such as tu, tue, and tues.
  - Defaults to Saturday if unable to determine day.
- `sparkolade_reminder_time` - Time the Sparkolade reminder will run.
  - Time must be a number in military time, ie 1730 instead of 530pm.
  - Defaults to 1200 if unable to determine time.
  - `voices` - Randomly selects an active Helper to use for each alert.

## Changelog

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
