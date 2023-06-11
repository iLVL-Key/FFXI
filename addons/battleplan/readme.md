# Battle Plan
<(What's the battle plan?)>  
A collaborative "whiteboard" to keep you and your party members on the same page.  
Up to 5 lines are available to use. BP box is not visible when all lines are empty.  
For example, you can use it in Odyssey to list out the 3 NMs you're planning on doing and keep track of who is what job on each so that there's no overlap. Or in Sortie to have the path your group is taking laid out ahead of time.

### Commands
There are two types of commands: `Addon` and `Party`  

#### Addon
All Addon commands must be prefixed with either `//battleplan` or `//bp` (ex: `//bp clear`)
- **show** - Show the BP box.
- **hide** - Hide the BP box.
- **visible** - Toggle the BP box visibility (alternative to show/hide).
- **clear** - Clear *EVERYONE'S* BP box.
- **clearmine** - Clear *YOUR* BP box. Other people\'s BP boxes remain the same.
- **line#/l#/#** - Create party text to update the BP box for all members running BP.
  - `#` must be a number 1-5. Ex. `//bp 3 Hello from iLVL of Valefor!`
- pos x y - Update the position of the BP box. (saved to settings file)
- size # - Update the font size of the BP box Default. (saved to settings file)

#### PARTY
These commands are used directly in your party chat so that they are seen by the other members in your party/alliance. This is so that Battle Plan running on their own screens will be updated.
- !bp1 This text will be displayed on line 1
- !bp2 This text will be displayed on line 2
- !bp3 This text will be displayed on line 3
- !bp4 This text will be displayed on line 4
- !bp5 This text will be displayed on line 5
- !bpclear - Clears *EVERYONE'S* BP box

Everything after the !bp# will be captured and displayed on that line. It is also smart enough to recognize different !bp# on the same line and act accordingly. This means that typing  
`!bp2 This is line 2 !bp1 This is line 1 !bp3 This is line 3`  
into a single party chat line will result in Battle Plan displaying
```
This is line 1
This is line 2
This is line 3
```
