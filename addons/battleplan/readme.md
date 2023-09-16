# Battle Plan
<(What's the battle plan?)>

A collaborative "whiteboard" for you and your party.

![bp_box](https://github.com/iLVL-Key/FFXI/assets/101156258/7d7a5a02-d4c6-4a7f-94c8-5d429641961b)

Up to 5 lines are available to use. It is controlled by special commands detected through the chat log, and is not visible when all lines are empty. Anyone running Battle Plan that sees these commands in their chat log will be updated. This means that you can keep a group of players all on the same page!  

For example, you can use it in Odyssey to list out the 3 NMs you're planning on doing and keep track of who is what job on each so that there's no overlap. Or in Sortie to have the path your group is taking laid out ahead of time.

This can also be used as a simple notepad for just yourself, without putting anything into party chat.

Additionally, you can prep what you send out to everyone ahead of time by using the `//bp <#>` addon commands to first build the box on your own screen, then use `//bp send` to send each line out through the chat log for other players once you are satisfied with it.

### Commands
There are two types of commands: `Addon` and `Party`  

#### Addon `[optional] <required>`
These commands are used to update *YOUR* BP box. Other people's BP boxes will remain the same. All Addon commands must be prefixed with either `//battleplan` or `//bp` (ex: `//bp clear`)
- **<#> [text here]** - Update line # of *YOUR* BP box (blank to clear).
  - <#> must be a number 1-5. Ex. `//bp 3 Hello from iLVL of Valefor!`
- **send** - Send your current BP box to the chat log to update other players.
- **show/hide** - Displays the BP box if there is content to diplay. (saved to settings file)
- **clear** - Clear *YOUR* BP box.
- **pos [\<x> \<y>]** - Update the position of the BP box. (saved to settings file)
- **lock/unlock** - Drag the BP box. (saved to settings file)
- **size [#]** - Update the font size of the BP box Default. (saved to settings file)
- **bold** - Update the bold setting. (saved to settings file)
- **tutorial** - Run a short tutorial to give you the basics.

#### PARTY `[optional] <required>`
These commands are used to update *EVERYONE'S* BP box. They are used directly in your party chat so that they are seen by the other members in your party/alliance. This is so that Battle Plan running on their own screens will be updated.
- **!bp<#>** - Update line # of *EVERYONE'S* BP box (blank to clear).
  - <#> must be a number 1-5. Ex. `!bp3 Pickle Surprise!`
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

**3.1**
- Fixed error introduced in patch 3.0.1 with party commands not working correctly.
- Adjusted the Tutorial to now save your previous BP box content and restore it after running.
- Adjusted the Help command text.
- Removed Visible command. Simplifies commands as show/hide already do this.
- Removed the requirement to use `pos` to lock or unlock the BP Box. It will still work as before, but now you can also use just `lock` or `unlock` as their own commands to do the same thing.

**3.0.2**
- Fix BP header showing after logging out then back in.

**3.0.1**
- Fixed a few things with the Visible settings not working 100% correctly.
- Optimized a bunch of repetitive code.

**3.0**
- Added the ability to drag the BP box. This required redoing how the box text is created, hence the major version update.
- Added the pos lock/unlock command. This allows you to drag the BP box, or lock it so you don't drag it by mistake.
- Updated a lot of command formatting

**2.5**
- Set the text to bold by default and added a command to change this setting.

**2.4**
- Added a temporary display for the BP box when using the position and font size commands when the BP box is not on screen.

**2.3**
- Added send command. When paired with the line command this allows you to fill out the BP box on your side then send it to other users once you are finished.
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
