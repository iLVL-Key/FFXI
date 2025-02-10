# Helper
The Helper addon acts as a customizable in-game assistant that provides alerts, notifications, and flavor text to enhance the player's experience. The addon features a system of "Helpers"—virtual companions that deliver messages in chat, track important gameplay events, and provide reminders. The default Helper, Vana, offers encouragement, alerts players about key game mechanics (such as abilities becoming ready or capped job/merit points), and notifies them of party-related events like members joining or leaving.

Players can load different Helpers, each with its own personality and dialogue, and cycle between them. The addon also supports sound effects for key notifications and reminders for gameplay mechanics like Sublimation being fully charged or Vorseal effects nearing expiration. With its blend of functionality and personality, Helper adds both utility and charm to the FFXI experience.

![Helpers_list](https://github.com/user-attachments/assets/c8de2f56-7f54-4345-983a-0de60c3cac35)

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
  - Unloaded Helper files are not deleted but are removed from use by the addon.
- `list` - List currently loaded Helpers.
- `check [new|current|addon]` - Check for new updates. Does not update.
- `update [new|current|addon]` - Download new updates.
- `help` - Display a list of commands and addon info.

## Changelog

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
