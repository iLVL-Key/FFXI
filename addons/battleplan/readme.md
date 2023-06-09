# Battle Plan
<(What's the battle plan?)>  
A collaborative "whiteboard" that your party members and you can use to keep everyone on the same page.  
For example, you can use it in Odyssey to list out the 3 NMs you're planning on doing and keep track of who is what job on each so that there's no overlap. Or in Sortie to have the path your group is taking laid out ahead of time.

### Commands
There are two types of commands: `Self` and `Party`  

#### SELF
All Self commands must be prefixed with either `//battleplan` or `//bp` (ex: `//bp clear`)
- clear - clears YOUR Battle Plan (not yet implemented)
- show - Shows the Battle Plan on YOUR screen (not yet implemented)
- hide - Hides the Battle Plan from YOUR screen (not yet implemented)
- help - Displays the different commands able to be used (not yet implemented)

#### PARTY
These commands are used directly in your party chat so that they are seen by the other members in your party/alliance. This is so that Battle Plan running on their own screens will be updated.
- !bp1 This text will be displayed on line 1
- !bp2 This text will be displayed on line 2
- !bp3 This text will be displayed on line 3

Everything after the !bp# will be captured and displayed on that line. It is also smart enough to recognize different !bp# on the same line and act accordingly. This means that typing  
`!bp2 This is line 2 !bp1 This is line 1 !bp3 This is line 3`  
into a single party chat line will result in Battle Plan displaying
```
This is line 1
This is line 2
This is line 3
```
