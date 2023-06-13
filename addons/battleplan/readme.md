# Battle Plan
<(What's the battle plan?)>

A collaborative "whiteboard" for you and your party.

Up to 5 lines are available to use. The BP box is not visible when all lines are empty. It is controlled by special commands detected through the chat log. Anyone running Battle Plan that sees these commands will be updated. This means that you can keep a group of players all on the same page!  

For example, you can use it in Odyssey to list out the 3 NMs you're planning on doing and keep track of who is what job on each so that there's no overlap. Or in Sortie to have the path your group is taking laid out ahead of time.

### Commands
There are two types of commands: `Addon` and `Party`  

#### Addon
These commands are used to update *YOUR* BP box. Other people's BP boxes will remain the same. All Addon commands must be prefixed with either `//battleplan` or `//bp` (ex: `//bp clear`)
- **show** - Shows the BP box if there is content to diplay. (saved to settings file)
- **hide** - Hides the BP box regardless of content to display. (saved to settings file)
- **visible** - Toggle the BP box visibility (alternative to show/hide). (saved to settings file)
- **clear** - Clear *YOUR* BP box. Other people's BP boxes will remain the same.
- **line#/l#/#** - Update *YOUR* BP box. Other people's BP boxes will remain the same.
  - `#` must be a number 1-5. Ex. `//bp 3 Hello from iLVL of Valefor!`
- **pos/move x y** - Update the position of the BP box. (saved to settings file)
- **size #** - Update the font size of the BP box Default. (saved to settings file)
- **tutorial** - Run a short tutorial to give you the basics.

#### PARTY
These commands are used directly in your party chat so that they are seen by the other members in your party/alliance. This is so that Battle Plan running on their own screens will be updated.
- **!bp#** - Update *EVERYONE'S* BP box with the text that follows it.
  - `#` must be a number 1-5. Ex. `!bp3 Pickle Surprise!`
- **!bpclear** - Clear *EVERYONE'S* BP box

Everything after the !bp# will be captured and displayed on that line. It is also smart enough to recognize different !bp# on the same line and act accordingly. This means that typing  
`!bp2 This is line 2 !bp1 This is line 1 !bp3 This is line 3`  
into a single party chat line will result in Battle Plan displaying
```
This is line 1
This is line 2
This is line 3
```
### Version History
**2.3**
- Added send command. When paired with the line command. this allows you to fill out the BP box on your side, then send it to other users once you are finished.
- Added auto-hide upon zoning or logging out of your character.
- Added error handling on the font size command.
- Additional formatting fixes.

**2.2**
- Added a tutorial.
- Added message on first load reminding about `//bp help` and `//bp tutorial`. This message only runs the first time the BP is loaded.
- Adjusted Addon commands so that they only affect your BP box. This makes more sense as Addon commands are for you and Party commands are for the party.
  - Clear command now only clears your own BP box.
    - Everone's BP box can still be cleared using the `!bpclear` party command.
  - Line# commands now only updates your own BP box.
    - Everyon's BP box can still be updated using the `!bp#` party command.
- Adjusted formatting for the help command (colors!).
- Adjusted the default BP box color scheme.
  - While there is no Addon command to adjust these, they can still be adjusted in the settings file.
- Adjusted help text for clarity.

**2.1.2**
- Display Visibility status on update.

**2.1.1**
- Help command now also shows the current Visibility setting (show or hide).
- Minor formatting update to the help command.

**2.1**
- Now saves Visibility setting to file.
- Added "move" alias to position command.

**2.0**
- Total number of available lines increased from 3 to 5.
- BP Box now auto-hides when all lines are empty.
- Empty trailing lines are now hidden (ie if only lines 1 and 3 are used then 4 and 5 will be hidden).
- Added commands to show/hide the BP box: show, hide, and visible (toggles between the two).
  - Hide will never show the BP box regardless if it is empty.
  - Show will return the BP box visibility to normal behavior (will not display the BP box on command if it is empty).
- Added commands to clear the BP box: clear and clearmine.
  - Clear will clear EVERYONE'S BP box.
  - Clearmine will ONLY clear YOUR BP box.
- Added commands to create the party text to update the BP box for all members running BP: line#, l#, and just #.
  - This is merely an alternative option to typing out "!bp#".
  - Ex: `//bp 1 Hello` will add `!bp1 Hello` to party chat.
- Added command to update the position of the BP box: pos, position.
  - Saved to settings file.
- Added command to update the font size of the BP box: size, fontsize.
  - Saved to settings file.
- Added command to display help: help.
  - Displays a list of commands available.
  - Displays the current position and font size.
- Added commands to reload/unload the BP addon: reload, unload.
  - These are mainly just aliases for the windower reload and unload commands.

**1.0**
- Initial build.
- Basic funtionality.
