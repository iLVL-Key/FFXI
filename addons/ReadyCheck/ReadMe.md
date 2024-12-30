# READY CHECK #
<[Ready]> <[Please check it.]>  
Initiate a basic automated Ready Check

![Keylesta 2023-12-10 05 54 49](https://github.com/iLVL-Key/FFXI/assets/101156258/d9771a65-906c-4794-adb0-fcce9d1c900a)

![Keylesta 2023-12-10 10 17 44](https://github.com/iLVL-Key/FFXI/assets/101156258/c9f0b4a6-ec23-4a52-948b-06474023c1d3)

## Features ##
 - Members can indicate they are `ready` or `not ready` as well as change their status
 - Automatically ends when all members are marked as `ready`
 - Automatically ends after a 2 minute timer if not all members are marked as `ready`
 - Does not require each member to have the addon installed in order to participate in the Ready Check
 - Does not include trusts
 - Displays in party chat an "all ready" message or a list of members that were not ready when the check ends
 - Allows only one Ready Check at a time to run, even if started by another member
 - On screen display
   - Displays all members in party/alliance and their `ready`/`not ready` status
   - Displays the timer countdown
   - Activates even if started by another member
  
## Commands ##
All commands must be preceded with either `//vanafacts` or `//vf` (ex: `//rc cancel`)  
- `//readycheck` or `//rc` (with no command) - Start/Stop a Ready Check.
- `cancel` - Cancel a Ready Check you started.
- `hide` - Hide the current Ready Check window.

## Version History
**1.3**
- Adjusted the "ready" messages that are looked for (added `o/`, `O/`, and `0/`).
- Adjusted Help text

**1.2**
- Adjusted the "ready" messages that are looked for (added `o`, `O`, and `0`).

**1.1**
- Adjusted the "ready" messages that are looked for (added `ready` and `o/`).
- Adjusted the chat modes that are checked for "ready" message. Now will accept message from any chat mode not just party.
