# Callouts

Various callouts for endgame things.

## Current Callouts:
- **Abyssea:** Red and Blue Procs
- **Ambuscade:** Bozzetto Autarch Mijin Gakure countdown, Bozzetto Crusader hate reset
- **Charm:** Party/Alliance members who get charmed
- **Dynamis:** Halphas hate reset, Aurix pop/run/warp
- **HTMB:** Lilith Dread Spikes
- **Odyssey:** Certain 1-HRs, segment total after run, others
- **Omen:** Scale drops/jobs, certain abilities, boss info
- **Sortie:** Elements, gallimaufry total after run, rage timers
- **Vagary:** Perfidien/Plouton pop, weaknesses

## Commands
All commands must be preceded with `//callouts` or `//co` (ex: `//co mode`)  
`[optional] <required>`
- `chatmode/chat/mode` - Switch between Echo and Party chat modes (addon default is echo)
- `abyssea/ambuscade/charm/dynamis/htmb/odyssey/omen/sortie/vagary` - Turn individual callouts on or off
- `callnum/call/num` - Update the call number used for Party chat mode.
- `list` - List the current callouts and their ON/OFF state
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

Version 2.0
- Overhauled a lot of code for efficiency. Checking for Omen and Sortie bosses nearby now scans memory for them and stops when one is found (one call/loop per scan) instead of checking for each one individually (9 calls per scan for Omen, 4 for Sortie).
- Added callouts for all Omen bosses and mid-bosses similar to Ou callouts.
- Added 3 minute "rage" timer callouts for Aita, Degei, Triboullex, and Skomora (Sortie).
- Added callouts for Sortie Gallimaufry and Odyssey Segments total after run ends.
- Added callouts for Aurix popping and running (in addition to the previous warping callout), includes HP at time of running (Dynamis).
- Added callouts for Perfect Dodge, Invincible, Elemental Sforzo, Yaegasumi for all Odyssey NMs (expanding from just Bumba previously). Brazen Rush callout is still only for Bumba.
- Added `call_num` option and related addon command. Allows you to set the call number (0-21) for the party chat callout.
- Adjusted Ou callouts setting back into the Omen callouts setting.

------

<p align="center">
<h2 align="center">AI Usage</h2>
</p>

<p align="center">
I use AI more for assistance, rather than letting it do it for me and straight-up vibe coding things. When I started learning how to code I did it because I thought it woud be cool to make useful things, and I wanted to learn for myself. Shortly after I started ChatGPT was released and since then I've purposely and specifically used it as a teaching tool. At first I would explain ideas that I wanted to do, not really know how to do them myself, then read through what it provided to be sure I understood what it was doing, asking it to expain specific sections I didn't understand. Then I would type in all the code myself rather than copy and paste, so that the learning would better stick with me. For the most part now, I find I mostly use it to create and access data within tables for me, just doing the tedious loop creating stuff.
</p>

------
