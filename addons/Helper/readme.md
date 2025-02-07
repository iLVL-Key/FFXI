# Helper
The Helper addon acts as a customizable in-game assistant that provides alerts, notifications, and flavor text to enhance the player's experience. The addon features a system of "Helpers"—virtual companions that deliver messages in chat, track important gameplay events, and provide reminders. The default Helper, Vana, offers encouragement, alerts players about key game mechanics (such as abilities becoming ready or capped job/merit points), and notifies them of party-related events like members joining or leaving.

Players can load different Helpers, each with its own personality and dialogue, and cycle between them. The addon also supports sound effects for key notifications and reminders for gameplay mechanics like Sublimation being fully charged or Vorseal effects nearing expiration. With its blend of functionality and personality, Helper adds both utility and charm to the FFXI experience.

![Helpers_list](https://github.com/user-attachments/assets/c8de2f56-7f54-4345-983a-0de60c3cac35)

## Features
- <ins>**Automated Notifications & Alerts**</ins>
  - **Ability Ready Alerts** → Notifies you when an ability is ready to use.
  - **Job Points & Merit Points Capped** → Alerts you when you reach the max.
  - **Party & Alliance Updates** → Get messages when members join or leave.
  - **Sublimation Charged** → Tells you when Sublimation is fully charged.
  - **Vorseal Reminder** → Notifies you when your Vorseal buff is about to expire.
  - **Mireu Pop Alerts** → Notifies you when the NM Mireu is mentioned.
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
1. Be sure to download the `data/sounds` folder, as well as the `data/helpers` folder for additional Helpers to choose from.
2. Load the addon with `//lua load helper`.
3. Vana is the default Helper and will automatically be created (`data/helpers/Vana.xml`) and loaded into the addon.
4. Load additional Helpers into the addon with, for example, `//helper load moogle`. The name "moogle" in this example represents the name of the file, is case insensitive, and does not require the `.xml` attached.
5. Type `//helper` (with no additional command) to cycle between Helpers you have loaded.

- ## Commands
All commands must be preceded with `//helper` (ex: `//helper list`)  
`<required>` `[optional]`
- `(blank, no command)` - Cycle to the next loaded Helper.
- `load/l <file_name>` - Load a Helper file into the addon.
  - Helper files must be in the `/data/helpers` folder.
  - Loaded Helpers are saved and do not need to be loaded again unless unloaded.
- `unload/u <file_name>` - Unload a Helper file from the addon.
  - Unloaded Helper files are not deleted but are removed from use by the addon.
- `list` - List currently loaded Helpers.
- `check [new|current|addon]` - Check for new updates. Does not update.
- `update [new|current|addon]` - Download new updates.
- `help` - Display a list of commands and addon info.
