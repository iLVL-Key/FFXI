# Keys Gearswap files

## Features
### QOL Improvements
Lots of little things to improve your experience. Each file has an Options and Advanced Options section at the top. Nearly everything that the files do can be adjusted or turned off.
- UseEcho - Automatically uses an Echo Drop or Remedy instead of spell when you are silenced.
- AutoMajesty - Automatically activates and keeps Majesty active.
- AutoStance - Automatically activates and keeps Stances (Hasso/Seigan) active.
- Book/Page - set your specific macro book and page for that job (and common subjobs) when the file loads.
- DD jobs will attempt to use a "save" when you are at low HP (High Jump, Chakra, etc depending on main/sub job).
- Reminder to put Reraise up if it's down.
- "Oh Shit" gear set for when you are in critical health, or are stunned, petrified, or terrorized.
- Removes Stoneskin if you are asleep and equips "HP drain" type gear pieces (for jobs that have them).
- And many more...
- NOTE: AutoHWater/DoomAlert and AutoLockstyle options have been removed and now have their own standalone addons: [Exorcist](https://github.com/iLVL-Key/FFXI/tree/main/addons/Exorcist) and [Vanity](https://github.com/iLVL-Key/FFXI/tree/main/addons/Vanity)

### Gear Modes
Certain files have multiple modes you can switch between at any time. Standard DPS, Accuracy, Subtle Blow, etc. PLD and RUN have an Auto mode that will switch between Combat and Neutral modes on its own depending on when the game thinks you are in combat (ie idle but not in combat will equip refresh set, whereas idle but in combat will equip a kite set).

### Weapon Cycler
Certain files have the ability to cycle between pairs of Main slot weapons and Sub slot weapons/grips/shields. Use this to cycle between your commonly used weapons. Has a second, separate list for Abyssea Proc Weapons that gets added into the cycle list when inside Abyssea. Will not equip a Weaponskill gear set when inside Abyssea and an Abyssea Proc Weapon pair is equipped. Activated with a macro, an alias, or a keyboard shortcut (default is CTRL+H for Hweapon). Can be adjusted or new pairs added in the Weapons section.

### Sound Effects
All files utilize subtle sound effects found in the sounds folder. While not required, it is recommended to download the sounds folder and add it under the Gearswap/data folder to make full use of what the files offer. Don't worry, I've made sure they are not loud or annoying.

The file structure should look like this:

`/addons/Gearswap/data/sounds/varioussoundfiles.wav`

`/addons/Gearswap/data/JOB.lua`

### HUDs
Each file has a unique HUD, some are a little more unique than the others.  
In general, each HUD has..  

- Status Notifications. Things like Sneak & Invis, WS & SC damage, party invites, and others general things to be notified of.
- Debuff Notifications. A number of the more common/important debuffs (ie Paralyze, Amnesia, Silence) are displayed in their own slots side-by-side, whereas the debuffs that fully debilitate you (ie Charm, Terror, Sleep) take priority and are displayed on top of those others.
- Gear Mode. Files that have this feature will also change background color of the HUD based on which mode is currently active.
- AftermathWeapon Notifications. Displays your currently equipped weapon(s) and Aftermath info (including potency and timers!) when appropriate, as well as a TP meter behind it.
- Recasts. Display 6 CUSTOMIZABLE ability/spell recasts (GREEN is currently active, ORANGE is not active but not ready to use, RED is not active but ready to use). The brackets indicate if the ability/spell is ready to use currently (GREEN is ready, RED is not ready). Gives a short flash when it is available to use again.  
- Some files show more specialized information such as SMN Avatars,  bubbles (with realtime potency numbers!), and RUN runes.  

#### BLU
![BLU_HUD](https://github.com/user-attachments/assets/c9a7a9f2-5035-4927-826d-ef149ba3cd08)  
(Setting spells with AzureSets addon integration)

#### GEO
![ HUD](https://github.com/iLVL-Key/FFXI/assets/101156258/d556c734-0361-4bd2-8aed-5a22f2c23a42)  
(The green in the background is an HP bar for your luopan)  
(OLD HUD, new image Coming Soon™)

#### MNK
![MNK HUD](https://github.com/iLVL-Key/FFXI/assets/101156258/4b6cab79-f7e5-4f8c-96f6-0102899dca2c)  
(OLD HUD, new image Coming Soon™)

#### PLD
![PLD HUD](https://github.com/iLVL-Key/FFXI/assets/101156258/daf386e1-3335-4410-aae7-29db223e7d8b)  
(OLD HUD, new image Coming Soon™)

#### RUN
![RUN HUD](https://github.com/iLVL-Key/FFXI/assets/101156258/8943d3cc-23a8-4af2-bfc5-e53379e6c05f)  
(OLD HUD, new image Coming Soon™)

#### SAM
![SAM HUD](https://github.com/iLVL-Key/FFXI/assets/101156258/4ab4954b-3896-48c4-856d-156afd2f13b2)  
(OLD HUD, new image Coming Soon™)

#### SMN
![SMN HUD](https://github.com/iLVL-Key/FFXI/assets/101156258/4d1cb7dd-98e9-411f-9532-7b156befb5b6)  
(The green in the background is an HP bar for your summon)  
(OLD HUD, new image Coming Soon™)

#### WAR
![WAR HUD](https://github.com/iLVL-Key/FFXI/assets/101156258/0e6b013f-67d5-4f7e-8e1a-5632af235247)  
(OLD HUD, new image Coming Soon™)

## IMPORTANT
- When you load this file for the first time, your HUD may not be in a good position, or may be too large. If the HUD is not in a good position, go to the Heads Up Display options and adjust the HUDposX and HUDposY options, then save and reload the file. Adjust and repeat until positioned as desired. If the HUD is too large (or small), adjust the FontSize, LineSpacer, and ColumnSpacer options as needed. Suggested placement is center screen, just above your chat log.

## FAQ

**Q:** Can I use these without the HUD?  
**A:** Yes, you can turn off the HUD by going into the Advanced Options in the file and changing ShowHUD to false, this will make it so it is not shown by default when you change job and load the file. You can also turn it on and off in the game by typing //hud.  

**Q:** Can I request a feature or change, or report an issue?  
**A:** Abso-freakin-lutely.  Message me @ Valefor.Keylesta on ffxiah.com

**Q:** Can you make one for X job?  
**A:** These take a lot of time to make and customize. I've only made them for the jobs I use, sorry.

## Issues
- Loading one of these files after having certain lua files made by some other folks loaded may cause some things to not function correctly (for example, you have your normal WAR lua file loaded, then type `//gs load whateveryounamedoneofthesefiles` to test it out). These issues seem to be mostly with using keyboard shortcuts (for example, Weapon Cycler not working correctly when hitting the kb shortcut to cycle). Renaming the file so that gearswap will load directly into it /without/ first loading into the other file (simply `WAR.lua`, for example) then typing `lua r gearswap` should fix the issue. I'm not sure exactly what the other files are doing or not doing that causes issues, but my guess is they are not removing keybinds once their files are unloaded.

## Changelog

<details>
<summary>BLU</summary>

Version 18.9.1
- Adjusted the default Aftermath colors. Flipped AM1 and AM2 for consitancy with Bars distance coloring (green --> blue --> yellow).
- Fixed Sambas not colorizing correctly in the HUD when active.

Version 18.9
- Added TransportLock Option. Cancels the first cast of a transport spell and unlocks additional spells for 3 minutes or until you zone.
- Fixed Mog House in Al Zahbi not being recognized as a "town" zone.
- Fixed missing "catch-all" for any spells not specified for a midcast set.

Version 18.8.2
- Fixed missing Notification Option for Vorseal and Signet/Sanction/Sigil/Ionis wearing off.

Verison 18.8.1
- Fixed "the random q" issue. In short, they broke a workaround for an issue with coloring text by finally fixing the issue.

Version 18.8
- Added Chocobo Circuit to the list of Town Zones.
- Adjusted a lot of set names to be easier to read using snake_case.
- Adjusted Notifications to clear after joining a party.
- Fixed an issue where no gear set would equip while idle or engaged with no Mode set yet (defaults to Mode1 when None).
- Various code cleanup.

Version 18.7
- Adjusted Notifications to clear after joining a party.
- Fixed an issue with SP2 recast

Version 18.6
- Added rule for Enfeebling Magic to use the Magic Accuracy set.

Version 18.5
- Adjusted HUD Weapons text to color based on the current Aftermath level when the HUD TP Meter is turned off.

Version 18.4
- Added support for sub SCH.

Version 18.3.2
- Fixed an error in the Fast Cast update.

Version 18.3.1
- Adjusted how the Fast Cast set gets called.

Verison 18.3
- Added Snapshot set for ranged attacks.
- Fixed Stoneskin and Sneak not using the Fast Cast set under specific conditions.

Version 18.2
- Adjusted the HUD Recast to now display recast timers above 60 seconds, mimicking the games built-in timers under the buff icons.

Version 18.1.2
- Fixed an issue with Weapon Cycle not equipping initial Main/Sub pairs correctly when switching from another job.

Version 18.1.1
- Adjusted the Weapon Cycle to load the first Main/Sub pair on file load.
- Fixed a few issues with the aliases.

Version 18.1
- Added the option to turn the mini TP Meter inside the HUD on or off.

Version 18.0.1
- Fixed an issue with turning Debuff Notifications off causing an error

Version 18.0
- Overhauled the HUD, REMOVING NEED FOR THE TEXT PLUGIN! Now uses the Windower text library. About time!
- Overhauled the Debuffs Notifications. Prioritizes displaying completely debilitating debuffs on top of all others (previous style), with the rest being a displayed in their own position within the Debuff Notification area, allowing multiple debuffs to be displayed at once (Silence/Mute and Curse/Haunt share a spot).
- Added the Advanced Option to specifiy which abilities/spells are displayed in the HUD Recast section. A list of valid abilities/spells is provided.
- Added the Advanced Option to create a custom name for the ability/spell displayed in the HUD Recast section.
- Added equipping the Oh Shit set when petrified, stunned, or terrored.
- Added the Prime Weapon Caliburnus to Aftermath Notifications.
- Added an additional Mode for use, bringing the total available up to 5.
- Added Idle and DPS gear sets for each Mode. They are not required and will all default to using the set for Mode 1 unless you specifically want to add gear to them (ex: a Tank Mode).
- Added Debuff Notification for Animated, Haunt, and Taint.
- Added Mounted status Notification.
- Added proper cleanup of custom text objects, aliases, and binds.
- Adjusted Aftermath notifications to display their time remaining.
- Adjusted Aftermath notification area in the HUD to display as a meter for your TP.
- Adjusted Mythic Aftermath level 1 and 2 to now display their accuracy and magic accuracy values.
- Adjusted the formatting of a few areas of the HUD, including the centering of some objects, flashing, automatic truncating of certain sections to keep text within the HUD boundary (equipping a main and sub item with really long names no longer breaks out of the HUD), and some coloring.
- Adjusted HUD Recasts to now display a countdown timer under 60 seconds remaining on recast.
- Adjusted how the Debuff Notifications, Aftermath Notifications, and Alive Notification all work. More efficient now with a huge reduction in calls to update their respective text objects.
- Adjusted equipping the DT Override set when petrified, stunned, or terrored. This now equips the Oh Shit set instead.
- Adjusted AutoLockstyle. Lockstyling after subjob changes should be more smooth overall.
- Fixed an issue where your maximum HP going under the LowHPThreshold (ex. level-syncing low enough) would trigger the Low HP warning.
- Fixed two different things both doing status checks in two different ways, combining the two into one.
- Fixed spelling of the Luhlaza Bazubands to Luh. Bazubands for Azure Lore Timer gear check.
- Fixed an error with handling an 'empty' equipment slot in the Weapon Cycler.
- Fixed ZoneGear still running when set to Off.
- Removed ability/spell cancelling while a debuff is present that would prevent that ability/spell from activating. This fixes an issue where there is a split second of server lag between the debuff coming off and the client recognizing it, now allowing for hitting the ability/spell right when the debuff comes off and it activating as it should.
- Removed reliance on code edits to the AzureSets addon in order for the Spell cooldown notification to work. Only AzureSets edits are now to remove the redundant cooldown timer put on screen.
- Removed AutoLockstyle. This has been moved to its own separate addon called Vanity.
- Removed AutoHWater. This has been moved to its own separate addon called Excorcist.
- Removed the //fileinfo command.
- Removed the NotiWeapons option.
- Removed debug option. I feel this is no longer necessary at this point.

Version 17.0.1
- Fixed some errors that would display under certain circumstances immediately after switching characters.

Version 17.0
- Added Weapon Cycle feature. Cycles between pairs of Main slot weapons and Sub slot weapons/grips/shields. Use this to cycle between your commonly used weapons. Has a second, separate list for Abyssea Proc Weapons that gets added into the cycle list when inside Abyssea. Will not equip a Weaponskill gear set when inside Abyssea and an Abyssea Proc Weapon pair is equipped. Activated with a macro, an alias, or a keyboard shortcut (default is CTRL+H for Hweapon). Can be adjusted or new pairs added in the Weapons section.
- Adjusted how the Weapon Skill sets are coded. You can now add a new set for a WS that is not already defined by simply copying another WS set and changing the set name to match the desired WS name. This change also tidies up the backend code a bit as well which was totally not the main reason for doing it.
- Adjusted HUD positioning options and text for clarity.
- Adjusted ability recast timings for equipping gear from `<= 1` to `< 2`. Should give a touch more room to fire off properly if you're camping that recast timer.
- Adjusted Gear Mode keybind Advanced Option to remove the hardcoded "CTRL+" requirement. Can now be fully customized (WIN+G, ALT+5, F9, etc.)
- Adjusted the //hidehud and //showhud aliases to condense to just //hud. It also now actually works.

Version 16.0
- No gear set changes.
- Added Advanced Option to add commas to the damage numbers.
- Adjusted Weaponskill Missed notification to also display when a Weaponskill gets blinked.
- Removed notifications for Blood Pacts because I don't know why I added it in there.

Version 15.0
- No gear set changes.
- Renamed WS Damage Notification to Damage Notification.
- Updated Damage Notification to include Weapon Skills, Skillchains, Magic Bursts, and Blood Pacts.
- Fixed Damage Notification option displaying regardless of being on or off.
- Updated to semantic versioning. This removes the need for the Version Compatibility Codenames.

04.15.23 (Version Compatibility Codename: Cocoon)
- Fixed missing options listings in the File Info (//fileinfo)

02.22.23 (Version Compatibility Codename: Cocoon)
- Adjusted WS Damage Notification to display WSs for zero like normal. This reverses a previous change, but now with Skillchain damage being displayed alongside WS damage it made sense to show the zero damage instead of displaying as a miss.

02.07.23 (Version Compatibility Codename: Cocoon)
- Adjusted WS Damage Notification to filter out some Job Abilities that get listed in the same action category as Weapon Skills.

01.24.23 (Version Compatibility Codename: Cocoon)
- Adjusted WS Damage Notification to display Skillchain damage.

01.21.23 (Version Compatibility Codename: Cocoon)
- Adjusted Macro Page timing. Should fix occasional issue with macros deleting themselves.
- Adjusted WS Damage Notification to count blinked WSs and WSs for zero as a miss. Blinks would previously display the number of shadows as the damage number.
- Fixed issue with WS Damage Notification where some abilities and weapon skills would occasionally gets mixed up.

01.10.23 (Version Compatibility Codename: Cocoon)
- Adjusted HUD to automatically hide during zoning.
- Removed Omen and Vagary notifications. Those have been spun out into their own windower addon called Callouts.
- Updated Version Compatibility Codename to Cocoon.

12.27.22 (Version Compatibility Codename: Power Attack)
- Overhauled the Aftermath notification. Renamed to Weapons. Will now always show your equipped weapon as a default state when no aftermath is up. Will change colors based on what your current TP will give you for an Aftermath effect.
- Removed the option to turn off the HUD. While I generally think the more options the better, the HUD is a main part of this lua.
- Fixed occasional error messages from the Text addon when loading/reloading the file.
- Updated Version Compatibility Codename to Power Attack.
- Code cleanup.

12.06.22 (Version Compatibility Codename: Wild Oats)
- Overhauled Low HP notification. Notification and sound no longer activates in towns. Changed the Advanced Option from selecting "Once" or "Constant" to instead selecting the number of times the sound will repeat while your HP is low. Removed the 30 second window before triggering again.
- Adjusted certain notification to now automatically clear after a short delay.
- Removed the option for using the OhShit gear set. The gear set itself still remains and funtionality has not changed. Having the option was redundant as you can simply leave the set empty.
- Fixed Aftermath notification displaying when the NotiAftermath option is turned off.
- Updated Version Compatibility Codename to Wild Oats.
- Code cleanup.

11.30.22 (Version Compatibility Codename: Sprout Smack)
- Overhauled how death is handled. More cleanly prevents unnecessary notifications from activating immediately upon raising (ie Reraise wearing off and Low HP).
- Added Danger sound file. Used by Doom and Low HP.
- Added Advanced Option for the Danger sound to play constantly while in danger or only once (with a 30 second delay to be able to play again).
- Added WSDamage option. Displays your damage (or miss) after a Weapon Skill.
- Added Sanguine Blade set.
- Added the //hidehud and //showhud alias commands.
- Added debug lines for redefining variables.
- Adjusted Low HP Notification to not trigger while weakened.
- Adjusted Low HP Notification Sound to have a 30 second window after triggering where it will not trigger again.
- Adjusted Low MP Notification to trigger in real-time rather than being tied to the Aftercast funtion.
- Adjusted HUD text object loading timing to avoid them occasionally not loading correctly.
- Adjusted AutoHWater option to stop and notify you once you are out of useable Holy Waters.
- Adjusted the Trade notification to clear once the trade is complete.
- Removed the option to turn off the HUDRecast. While I generally think the more options the better, the recasts are a main part of the HUD.
- Removed the CharmNaked option. Apparently you can't Do Stuff while charmed ¯\_(ツ)_/¯
- Fixed incorrect SP Ability timers when wearing gear that augments (adds additional time to) the ability.
- Fixed ordering of Status Notifications.
- Renamed OhShitThreshold to LowHPThreshold since it controls more than just the OhShit option.
- Updated Version Compatibility Codename to Sprout Smack.
- Code cleanup.

10.15.22 (Version Compatibility Codename: Foot Kick)
- Added an Oh Shit gear set and accompanying option to use it. HP threshold required to activate is adjustable in the Advanced Options.
- Added Low HP Notification.
- Added AutoHWater option. Automatically attempts to use Holy Waters when you get Doomed until it wears off. Currently will keep trying even if you run out of Holy Waters.
- Added DoomAlert option. Will alert your party when you are doomed. You can also customize the text that displays in party chat.
- Added Sneak and Invisible status notification.
- Added missing listings in the /fileinfo printout for a few Notifications.
- Added Silver Knife to list of Adoulin/Town areas.
- Adjusted CharmNaked option to have three options: all gear, all gear except weapons, or off.
- Adjusted the code that tries to wake you when you are asleep to not trigger if you are charmed.
- Adjusted resting to equip Refresh + Rest gear sets.
- Moved RRReminderTimer from Options to Advanced Options.
- Fixed an issue where the spell cooldown timer would continue during the brief period between setting your spells right after setting them a first time, showing the new spell set name with the old timer attached to it.
- Removed Gearswaps built-in showswaps function from the files debug mode.
- Updated Version Compatibility Codename to Foot Kick.
- Code cleanup.

09.04.22 (Version Compatibility Codename: Sandspin)
- Added all DOTs to the rule that removes Stoneskin if asleep.

08.28.22 (Version Compatibility Codename: Sandspin)
- Adjusted what the fastcast set ignores to include all "Ring" items (previously would ignore only Warp and Dimensional Rings specifically, will now also ignore XP/CP rings)
- Fixed the Earth set name so it equips properly.

08.13.22 (Version Compatibility Codename: Sandspin)
- Added Leafallia to list of towns.
- Added cancelling Stoneskin if its preventing poison from removing sleep, otherwise equip the Opo-opo Necklace per usual.
- Added equipping the DT Override set when petrified, stunned, or terrored.
- Added option to remove all gear (except weapons) when you are charmed.
- Adjusted abilities to not equip their gear sets if they are still on cooldown.
- Split the Cursna set into Cursna and Holy Water.
- Renamed LockstyleField to LockstyleCombat. Just makes more sense.
- Fixed an issue where the debuff background color change from Doom (flashing white and yellow) would get stuck on yellow after Doom wears off and you have another debuff on that takes over in the debuff spot.
- Fixed an issue where resting would combine the Rest set with the DT Override set regardless of DT Override being on or off.
- Removed the leftover Enmity gear set. The functionality for this set was removed in a previous version, I simply forgot to remove the gear set.
- Updated Version Compatibility Codename to Sandspin.

07.18.22 (Version Compatibility Codename: Pollen)
- Overhauled how area checks are handled. Uses tables now for groups of areas.
- Fixed the DTOverride set not equipping correctly when idle.
- Fixed some errors that would show up on job change. These were caused by the Heartbeat function constantly checking for any debuffs present; when you unload the file (change job) it will delete the debuff text objects used for the HUD which will cause a split second where the debuff check freaks out. The fix was to simply disable the debuff checks in town zones.
- Fixed an issue with the Sleep debuff not showing properly in the HUD.
- Code cleanup.

06.14.22 (Version Compatibility Codename: Pollen)
- Adjusted HUD timings on load. Should fix the occasional errors about text objects not existing as well as objects loading underneath the background layer.
- Removed Gearswaps built-in debugmode from the files Debug mode.
- Moved the Updates section towards the top of the file.
- Code cleanup.

03.11.22 (Version Compatibility Codename: Pollen)
- Overhauled Debuff Notifications. Will now check which debuffs are up in real time with a list of priority for which is displayed instead of clearing the notifications entirely when any of them are removed (leaving it blank even if a different debuff was still up).
- Added missing On/Off option/rules to Time Remaining (currently only for Abyssea), Omen, and Vagary
- Added Encumbrance to the Debuffs.
- Fixed Alliance invite incorrectly triggering Party invite notification.
- Fixed some subjob conditions throwing errors when you have no subjob (ie Odyssey NMs)

02.02.22 (Version Compatibility Codename: Pollen)
- Added Weak status notification.
- Fixed gear not fully equipping in towns.
- Fixed Abyssea Visitant status triggering on incorrect time remaining (ie 110 minutes would trigger the 10 minute)
- Fixed Fast Cast gear to not equip when using a Forbidden Key, Pickaxe, Sickle, or Hatchet.

02.01.22 (Version Compatibility Codename: Pollen)
- Overhauled how Blue Magic spells are handled. Uses tables now for groups of spells that use certain gearsets.
- Overhauled Notifications. Removed reliance on variables and spun out Debuffs into their own thing.
- Renamed the OnScreen Display to HUD.
- Added Paralysis to the Debuffs.
- Added option to automatically use an Echo Drop (or Remedy) instead of spell when you are silenced.
- Added a Savage Blade Weapon Skill set.
- Added missing Luhlaza Bazubands +2 and +3 variants for extending Azure Lore timer.
- Added rule for White Magic Cure spells to the Healing set.
- Added rule for Elemental spells to use the Magical set.
- Added option for setting macro book page (set).
- Added Trade, Invite, Sneak, Invisible, Vorseal, Signet, Sanction, Sigil, and Ionis to the Notifications.
- Added the 3000 TP notification to the Notification options.
- Added 2 new sounds (NotiGood and NotiBad) and adjusted sound usage accordingly.
- Added a Heartbeat function. This creates a one second "heartbeat" that we can use to do various things that may not otherwise have an automatic trigger.
- Added a background to the HUD creating a box that everything is displayed inside, instead of separate floating pieces of info.
- Added Spell/Ability recasts to the HUD. Green when active, Orange when not active but on cooldown, red when not active and ready to use.
- Added equipping of Opo-opo Necklace when asleep (and un-equip after).
- Added HUD now hiding when in a cutscene. (The code to hide while zoning is adding a lot of lag, will look further into this)
- Adjusted the solid colors to be a little less solid (red was just so... ~*RED*~)
- Adjusted the Doom Notification to have a more noticeable presence.
- Fixed an issue with AutoLockstyle where it would not run correctly if you change your sub job immediately after changing to BLU.
- Fixed the Reraise Reminder.
- Fixed the Dead Notification.
- Changed «« and »» to << and >> for chatlog notifications since «« and »» don't actually display in the chatlog.
- Changed compatibility naming scheme to Blue Mage spells.
- Code cleanup.

11.10.21 (Version Compatibility Codename: Maxprime-u1)
- Fixed Aftermath Notification colors displaying incorrectly.

10.27.21 (Version Compatibility Codename: Maxprime)
- Overhauled how lockstyle is handled. This now uses the in-game lockstyle set system instead of a gear set defined in this file.
- Added ability to use a Town lockstyle set separate from the set used while out in the field.
- Removed the Lockstyle gear set since it is no longer needed.
- Updated the Aftermath status to include Almace and Sequence (in addition to Tizona).
- Updated the Aftermath status in the OnScreen display to automatically display, or not, based on the equipped weapon.
- Layout of the OnScreen display will now self-adjust based on whether the Aftermath display is on or off.
- Removed the option to turn the Aftermath status in the OnScreen display on or off as this is now automatic as long as the OnScreen display is turned on.
- Added an Azure Lore and Unbridled Wisdom timer. These will show a countdown in echo until they wear off.
- Added a Cruel Joke chat log timer. Can choose between party chat or echo (or off).
- Added a "Food Has Worn Off" notification.
- Added Mute and Plague to the notifications.
- Added ability to turn on or off individual notifications.
- Added a sound notification to the Doom notification (if you have AlertSounds turned on of course).
- Overhauled AlertSounds. There is now a sounds folder with sound files included with this gearswap file. Simply drop the sounds folder inside your data folder (It should look like \addons\GearSwap\data\sounds).
- Fixed the spell Fantod using the magicaccuracy set while not in Tank mode, now uses the buff set instead.
- Adjusted the "Low MP" Notification to wait 30 seconds before being able to display the same notification again, instead of the above 40% threshold previously used.
- Removed the Experimental feature GearCheck.
- Removed the Experimental feature AutoDefender.
- Removed reliance on Autoexec. Everything Autoexec did is now done completely through GearSwap functions.
- Code cleanup (lots of code cleanup...).
- Code comments added.
- Updated Top and Bottom version names.
- Updated //fileinfo.

07.17.21 (Version Compatibility Codename: Jackup)
- Added an Expiacion Weapon Skill set.
- Added a White Wind set.
- Added a Kite set. This set will equip when in any Tank mode and not engaged (turning "Status: Idle" into "Status: Kiting")
- Added a Cursna/Holy Water set, replacing the Purity Ring code previously added.
- Added a "Reraise Has Worn Off" Notification.
- Added a Reraise Reminder Notification.
- Added a "Low MP" Notification. Triggers when MP is under 20%. This will not trigger again until the player’s HP reaches 40%.
- OnScreen Notifications will now reset after zoning.
- Fixed sneak cancelling on yourself if you cast sneak on another player.
- Fixed Learning submodes to correctly use the Blue Magic Skill set.
- Updated Top and Bottom version names.
- Updated //fileinfo.

03.30.21 (Version Compatibility Codename: Fidant)
- Added a slight wait into the On-Screen display. This should prevent the occasional Text addon error on file load.
- Added SoundAlerts function. This will play a sound for various things (cancelled spell due to silence, not enough TP for a WS, 3000 TP, etc)
- Updated which gear sets are equipped for a few of the Unbridled Learning spells where we care more about the additional effect landing than we do about the damage.
- Fixed Unity Trust set to actually equip as intended.
- Updated Top and Bottom version names.
- Minor formatting adjustments.

02.09.21 (Version Compatibility Codename: Neonstar)
- Added Purity Ring on casting Cursna on yourself or using a Holy Water.
- Added Enmity set. Will only equip for Fantod, Jettatura, and Blank Gaze when in any of the tank modes.
- Updated Top and Bottom version names.

01.10.21 (Version Compatibility Codename: Kedar)
- Added Aftermath status into the OnScreen display. This is a separate line and can be turned on or off in the options.
- Changed the Gear Mode logic. You can now independently turn on or off the Treasure Hunter and Learning sub-modes.
 This will skip the modes that are turned off when you cycle through modes. So for example if you do not need
 or use either of the Treasure Hunter or Learning modes it will simply cycle between DPS and Tank.
- Added options to use an alias command or a kb shortcut for cycling between gear modes.
- Simplified the command needed to use a macro to cycle between gear modes.
- Added town sets. Unless you don't use a lockstyle, this is mostly intended just for the movement speed gear for specific towns.
- Added Unity Trust set. Put your Unity Shirt in this set to get the bonus when calling your Unity Trust.
- Added a second shorthand alias (lstyle) for the Auto-Lockstyle function.
- Adjusted Auto-Lockstyle function to choose the correct set to change back into after locking the lockstyle set (tank, idle, town, etc)
- Added option to adjust the transparency level of the OnScreen display.
- Added option to automatically re-equip your gear after you zone. 'All' will either equip whichever Gear Mode you are in, or equip the
 set for the town you are in. 'Town' will only do this when you zone into a town.
- Added ability to turn off the Chat and Book options in case you either do not want to use them or another addon does it already.
- Moved the GearCheck and AutoDefender functions into a new Experimental Options section.
- Added a new Top and Bottom version identifier. This will help narrow down issues when updating this file to a new version in the future.
 The idea is that whenever I make changes that require edits to the top half of the file, I will change the Top and Bottom version names.
 This is so that when you update the file and replace everything below the "Do Not Edit Below This Line" line and have issues,
 we can see if it stems from the Top and Bottom versions not matching.
- Minor adjustments to which gear sets are used in different gear modes while engaged/idle.
- Code cleanup.
- Changed //filehelp to //fileinfo. Don't @ me.
- Updated //fileinfo to reflect updates.

10.20.20
- Added a Rest set. You will need to add this set even if you don't intend to use it.
- Changed //help to //filehelp to avoid any possible overlap with plugins/addons
- Adjusted gear sets during idle and engaged. (ex. if you're in tank mode and engaged, it will now equip tank set first, then pull from
 dps set for any slots not assigned in your tank set)
- Adjusted BlueMagicSkill, Healing, and Battery gear rules to combine with Buff set.
- Adjusted Precast to cancel spell when unable to actually cast due to debuff(s) and to add a notification when that happens.

09.15.20
- Fixed spell subtarget on WS
- Fixed distance for ranged WS
- Fixed TH gear equipping at the appropriate time
- Fixed a lot of the chat log notifications not displaying properly
- Fixed Diffusion so that it has the set equipped for spell cast completion and not just at ability activation
- Will now warn you when you have certain items equipped (Warp Ring, Reraise Hairpin, etc.)
- Added a //help command that will print out the Notes/Options
- Lots of code cleanup.
</details>
<details>

<summary>BRD</summary>

Version 1.2
- Added support for sub DNC abilities into the HUD recast.
- Adjusted the default Aftermath colors. Flipped AM1 and AM2 for consitancy with Bars distance coloring (green --> blue --> yellow).

Version 1.1
- Added TransportLock Option. Cancels the first cast of a transport spell and unlocks additional spells for 3 minutes or until you zone.
- Fixed Mog House in Al Zahbi not being recognized as a "town" zone.

Version 1.0.4
- Fixed missing Notification Option for Vorseal and Signet/Sanction/Sigil/Ionis wearing off.

Verison 1.0.3
- Fixed "the random q" issue. In short, they broke a workaround for an issue with coloring text by finally fixing the issue.

Version 1.0.2
- Fixed the buff_other set not being used in midcast.

Version 1.0.1
- Fixed an issue with the max number of songs not calculating correctly under certain circumstances.

Version 1.0
- Added Chocobo Circuit to the list of Town Zones.
- Adjusted the Song List display. Bullet in front of each song is now larger and colored to indicate which type of song (default colors match the XIView color scheme for song icons). Party Member names are now centered, and colored based on their lowest current song duration. Song durations are now right-aligned.
- Adjusted HUD to now show party members even if they are in a different zone.
- Adjusted formatting of a number of things in the Options section.
- Adjusted Notifications to clear after joining a party.
- Fixed precast so that if Nightingale is up it will equip the proper specific song buff gear instead of the base buff_song set.
- Fixed an issue with SP Ability 2 recast.
- Various code cleanup.

Version 1.0 BETA-5
- Adjusted Song List to display a musical notee as the bullet to indicate a dummy song.

Version 1.0 BETA-4
- Adjusted AutoSubCharge to also activate after a status change back to idle.

Version 1.0 BETA-3
- Fix AutoSubCharge trying to activate on any subjob.

Version 1.0 BETA-2
- Adjusted the on-screen Song List display.
- Fixed an error in the Fast Cast update.

Version 1.0 BETA-1
- First Version.

</details>
<details>
 
<summary>GEO</summary>

Version 14.8
- Added TransportLock Option. Cancels the first cast of a transport spell and unlocks additional spells for 3 minutes or until you zone.
- Fixed Mog House in Al Zahbi not being recognized as a "town" zone.
- Fixed Impact and Dispelga not equipping Fast Cast as intended.
- Fixed missing "catch-all" for any spells not specified for a midcast set.

Version 14.7.1
- Fixed missing Notification Option for Vorseal and Signet/Sanction/Sigil/Ionis wearing off.

Version 14.7
- Added Phalanx and Aquaveil sets
- Added Stun and Dispel using Magic Accuracy set.
- Added Dispelga support.

Verison 14.6.2
- Fixed "the random q" issue. In short, they broke a workaround for an issue with coloring text by finally fixing the issue.

Version 14.6.1
- Adjusted Impact set to combine with Magic Accuracy set

Version 14.6
- Added Indicolure, Geocolure, and Entrust sets. These replace the Geomancy set, allowing more fine-tuned control over the stats for each.
- Renamed luopan_out to idle_luopan to be a little more consitent.\
- Removed the Geomancy set.

Version 14.5
- Added Chocobo Circuit to the list of Town Zones.
- Adjusted a lot of set names to be easier to read using snake_case.
- Adjusted Notifications to clear after joining a party.
- Various code cleanup.

Version 14.4
- Adjusted Notifications to clear after joining a party.
- Fixed an issue with SP2 recast

Version 14.3.6
- Fixed missing call to equip fastcast set for Indi- and Geo- spells.

Version 14.3.5
- Fixed an issue where being sub SCH when sub jobs are restricted will produce an error.

Version 14.3.3
- Fix AutoSubCharge trying to activate on any subjob.

Version 14.3.2
- Fixed an error in the Fast Cast update.

Version 14.3.1
- Adjusted how the Fast Cast set gets called.

Version 14.3
- Added AutoSubCharge option. Automatically attempts to keep Sublimation charging.

Version 14.2.4
- Adjusted how the AutoEntrust and AutoFullCircle work, making them much more consistant now.

Version 14.2.3
- Fixed an issue where AutoEntrust and AutoFullCircle would give an error under specific conditions.
- Fixed Stoneskin and Sneak not using the Fast Cast set under specific conditions.

Version 14.2.2
- Fixed a minor error that occasionally displays when dismissing your Luopan.

Version 14.2.1
- Fixed an issue where Gearswaps builtin pet.hpp is too slow to refresh. Switched to bypassing it and calling windower.ffxi.get_mob_by_target('pet').hpp directly.

Version 14.2
- Adjusted the HUD Recast to now display recast timers above 60 seconds, mimicking the games built-in timers under the buff icons.

Version 14.1
- Added support for the Impact spell via Twilight/Crepuscular Cloak.

Version 14.0.3
- Fixed equipping the Refresh (spell) set instead of Idle when resting.

Version 14.0.2
- Adjusted Entrust HUD display to track Entrust based on when the Colure Active buff wears off the Entrusted player instead of an adjustable timer option. There is still a timer a little longer than the max Entrust duration possible running as a backup.
- Removed the EntrustDuration Option.
- Fixed an issue where the Luopan HP bar would occasionally extend across the screen for a brief moment when first cast.
- Fixed a double activation of Entrust when activated through the AutoEntrust option.

Version 14.0.1
- Fixed an issue with turning Debuff Notifications off causing an error.

Version 14.0
- Overhauled the HUD, REMOVING NEED FOR THE TEXT PLUGIN! Now uses the Windower text library. About time!
- Overhauled the Debuffs Notifications. Prioritizes displaying completely debilitating debuffs on top of all others (previous style), with the rest being a displayed in their own position within the Debuff Notification area, allowing multiple debuffs to be displayed at once (Silence/Mute and Curse/Haunt share a spot).
- Added the Advanced Option to specifiy which abilities/spells are displayed in the HUD Recast section. A list of valid abilities/spells is provided.
- Added the Advanced Option to create a custom name for the ability/spell displayed in the HUD Recast section.
- Added equipping the Oh Shit set when petrified, stunned, or terrored.
- Added Debuff Notification for Animated, Haunt, and Taint.
- Added Mounted status Notification.
- Added proper cleanup of custom text objects, aliases, and binds.
- Adjusted the formatting of a few areas of the HUD, including the centering of some objects, flashing, automatic truncating of certain sections to keep text within the HUD boundary (equipping a main and sub item with really long names no longer breaks out of the HUD), and some coloring.
- Adjusted HUD Recasts to now display a countdown timer under 60 seconds remaining on recast.
- Adjusted how the Debuff Notifications, Aftermath Notifications, and Alive Notification all work. More efficient now with a huge reduction in calls to update their respective text objects.
- Adjusted Luopan HP meter to update faster.
- Adjusted AutoLockstyle. Lockstyling after subjob changes should be more smooth overall.
- Fixed an issue where your maximum HP going under the LowHPThreshold (ex. level-syncing low enough) would trigger the Low HP warning.
- Fixed two different things both doing status checks in two different ways, combining the two into one.
- Fixed the DPS set not equipping.
- Fixed ZoneGear still running when set to Off.
- Removed ability/spell cancelling while a debuff is present that would prevent that ability/spell from activating. This fixes an issue where there is a split second of server lag between the debuff coming off and the client recognizing it, now allowing for hitting the ability/spell right when the debuff comes off and it activating as it should.
- Removed AutoLockstyle. This has been moved to its own separate addon called Vanity.
- Removed AutoHWater. This has been moved to its own separate addon called Excorcist.
- Removed the //fileinfo command.
- Removed debug option. I feel this is no longer necessary at this point.

Version 13.1
- Adjusted HUD background to display the Luopan HP as a % meter.
- Fixed some errors that would display under certain circumstances immediately after switching characters.

Version 13.0.3
- Fixed a timing issue with the Luopan gear set equipping after casting a Geo- spell.

Version 13.0.2
- Fixed an issue with Aspir II/III and Drain not equipping the correct set.

Version 13.0.1
- Fixed an issue where the Entrust target is not captured correctly when the Indi- spell and target is typed manually into the chat.

Version 13.0
- Added Black halo and Exudation gear sets.
- Adjusted how the Weapon Skill sets are coded. You can now add a new set for a WS that is not already defined by simply copying another WS set and changing the set name to match the desired WS name. This change also tidies up the backend code a bit as well which was totally not the main reason for doing it.
- Adjusted Page Option. Now defined for subbing WHM, RDM, BLM, or SCH with a default of 1 for other subjobs.
- Adjusted HUD positioning options and text for clarity.
- Adjusted HUD Ability recast colors. Will now give a short blink when an ability is becoming ready to use again.
- Adjusted ability recast timings for equipping gear from `<= 1` to `< 2`. Should give a touch more room to fire off properly if you're camping that recast timer.
- Adjusted Gear Mode keybind Advanced Option to remove the hardcoded "CTRL+" requirement. Can now be fully customized (WIN+G, ALT+5, F9, etc.)
- Adjusted the //hidehud and //showhud aliases to condense to just //hud. It also now actually works.
- Reversed AutoFullCircle change from Version 12.1.

Version 12.1
- Adjusted AutoFullCircle to no longer cast the Geocolure spell after using Full Circle. This allows for using any Gecolure spell to dismiss the previous bubble, without also casting another one immediately after usage, removing the need for a separate Full Circle macro if you only want to dismiss your current bubble.

Version 12.0
- No gear set changes.
- Added Advanced Option to add commas to the damage numbers.
- Adjusted Weaponskill Missed notification to also display when a Weaponskill gets blinked.
- Removed notifications for Blood Pacts because I don't know why I added it in there.

Version 11.0.0
- No gear set changes.
- Renamed WS Damage Notification to Damage Notification.
- Updated Damage Notification to include Weapon Skills, Skillchains, Magic Bursts, and Blood Pacts.
- Adjusted AutoEntrust behavior. Using a macro to cast an Indi- spell will now instead of directly using Entrust then casting that spell, it will instead activate the AutoEntrust system for use. Simply repeat the cast to use AutoEntrust. AutoEntrust will deactivate after 10 seconds, or after casting on yourself instead. This change was made to prevent misfires in situations where you intend to cast an Indi- spell on yourself, but someone casts on you right before, therefore making you target them, and thus the target of the Indi- spell.
- Fixed Luopan gear set not equipping immediately after casting a Geo- spell.
- Fixed WS Damage Notification option displaying regardless of being on or off.
- Updated to semantic versioning. This removes the need for the Version Compatibility Codenames.

04.15.23 (Version Compatibility Codename: Indi-CHR)
- Fixed missing options listings in the File Info (//fileinfo)

02.22.23 (Version Compatibility Codename: Indi-CHR)
- Adjusted WS Damage Notification to display WSs for zero like normal. This reverses a previous change, but now with Skillchain damage being displayed alongside WS damage it made sense to show the zero damage instead of displaying as a miss.

02.07.23 (Version Compatibility Codename: Indi-CHR)
- Adjusted WS Damage Notification to filter out some Job Abilities that get listed in the same action category as Weapon Skills.

01.24.23 (Version Compatibility Codename: Indi-CHR)
- Adjusted WS Damage Notification to display Skillchain damage.

01.21.23 (Version Compatibility Codename: Indi-CHR)
- Adjusted Macro Page timing. Should fix occasional issue with macros deleting themselves.
- Adjusted WS Damage Notification to count blinked WSs and WSs for zero as a miss. Blinks would previously display the number of shadows as the damage number.
- Fixed issue with WS Damage Notification where some abilities and weapon skills would occasionally gets mixed up.

01.10.23 (Version Compatibility Codename: Indi-CHR)
- Adjusted HUD to automatically hide during zoning.
- Removed Omen and Vagary notifications. Those have been spun out into their own windower addon called Callouts.
- Updated Version Compatibility Codename to Indi-CHR.

12.27.22 (Version Compatibility Codename: Indi-Refresh)
- Removed the option to turn off the HUD. While I generally think the more options the better, the HUD is a main part of this lua.
- Fixed occasional error messages from the Text addon when loading/reloading the file.
- Updated Version Compatibility Codename to Indi-Refresh.
- Code cleanup.

12.06.22 (Version Compatibility Codename: Indi-Barrier)
- Overhauled Low HP notification. Notification and sound no longer activates in towns. Changed the Advanced Option from selecting "Once" or "Constant" to instead selecting the number of times the sound will repeat while your HP is low. Removed the 30 second window before triggering again.
- Adjusted certain notification to now automatically clear after a short delay.
- Removed the option for using the OhShit gear set. The gear set itself still remains and funtionality has not changed. Having the option was redundant as you can simply leave the set empty.
- Updated Version Compatibility Codename to Indi-Barrier.
- Code cleanup.

11.30.22 (Version Compatibility Codename: Indi-Focus)
- Overhauled how death is handled. More cleanly prevents unnecessary notifications from activating immediately upon raising (ie Reraise wearing off and Low HP).
- Added Mending Halation to the HUD.
- Added Danger sound file. Used by Doom and Low HP.
- Added Advanced Option for the Danger sound to play constantly while in danger or only once (with a 30 second delay to be able to play again).
- Added WS Damage option. Displays your damage (or miss) after a Weapon Skill.
- Added the //hidehud and //showhud alias commands.
- Added debug lines for redefining variables.
- Adjusted Low HP Notification to not trigger while weakened.
- Adjusted Low HP Notification Sound to have a 30 second window after triggering where it will not trigger again.
- Adjusted Low MP Notification to trigger in real-time rather than being tied to the Aftercast funtion.
- Adjusted HUD text object loading timing to avoid them occasionally not loading correctly.
- Adjusted AutoHWater option to stop and notify you once you are out of useable Holy Waters.
- Adjusted the Trade notification to clear once the trade is complete.
- Renamed OhShitThreshold to LowHPThreshold since it controls more than just the OhShit option.
- Removed the option to turn off the HUDRecast. While I generally think the more options the better, the recasts are a main part of the HUD.
- Removed the CharmNaked option. Apparently you can't Do Stuff while charmed ¯\_(ツ)_/¯
- Fixed incorrect SP Ability timers when wearing gear that augments (adds additional time to) the ability.
- Fixed ordering of Status Notifications.
- Fixed Lasting Emanation/Ecliptic Attrition not displaying their status correctly in the HUD.
- Fixed a few redundant checks for Amnesia.
- Updated Version Compatibility Codename to Indi-Focus.
- Code cleanup.

10.15.22 (Version Compatibility Codename: Indi-Attunement)
- Added an Oh Shit gear set and accompanying option to use it. HP threshold required to activate is adjustable in the Advanced Options.
- Added Low HP Notification.
- Added AutoHWater option. Automatically attempts to use Holy Waters when you get Doomed until it wears off. Currently will keep trying even if you run out of Holy Waters.
- Added DoomAlert option. Will alert your party when you are doomed. You can also customize the text that displays in party chat.
- Added CharmNaked option. Removes all gear, or all gear except weapons, when you are charmed.
- Added Sneak and Invisible status notification.
- Added missing listings in the /fileinfo printout for a few Notifications.
- Added Silver Knife to list of Adoulin/Town areas.
- Adjusted the code that tries to wake you when you are asleep to not trigger if you are charmed.
- Adjusted resting to equip Refresh + Rest gear sets.
- Moved RRReminderTimer from Options to Advanced Options.
- Fixed resting not equipping the DT Override set properly.
- Removed Gearswaps built-in showswaps function from the files debug mode.
- Updated Version Compatibility Codename to Indi-Attunement.
- Code cleanup.

09.07.22 (Version Compatibility Codename: Indi-Regen)
- Added Enfeebling set.
- Adjusted the Aspir/Drain set to combine with the Magic Accuracy set instead of the Buff set.
- Adjusted what the fastcast set ignores to include all "Ring" items (previously would ignore only Warp and Dimensional Rings specifically, will now also ignore XP/CP rings)
- Updated Version Compatibility Codename to Indi-Regen.

08.14.22 (Version Compatibility Codename: Indi-Precision)
- Added AutoEntrust option. Automatically uses Entrust when you cast an Indi- spell on a party member.
- Added Leafallia to list of towns.
- Added cancelling Stoneskin if its preventing poison from removing sleep.
- Added a Cataclysm set.
- Split the Cursna set into Cursna and Holy Water.
- Adjusted abilities to not equip their gear sets if they are still on cooldown.
- Renamed LockstyleField to LockstyleCombat. Just makes more sense.
- Fixed an issue where the debuff background color change from Doom (flashing white and yellow) would get stuck on yellow after Doom wears off and you have another debuff on that takes over in the debuff spot.
- Updated Version Compatibility Codename to Indi-Precision.
- Code cleanup.

07.18.22 (Version Compatibility Codename: Indi-Voidance)
- Adjusted some gear sets and logic in their usage. (removed the Luopan set and renamed Combinedskill to Geomancy)
- Overhauled how area checks are handled. Uses tables now for groups of areas.
- Fixed some errors that would show up on job change. These were caused by the Heartbeat function constantly checking for any debuffs present; when you unload the file (change job) it will delete the debuff text objects used for the HUD which will cause a split second where the debuff check freaks out. The fix was to simply disable the debuff checks in town zones.
- Fixed an issue with the Sleep debuff not showing properly in the HUD.
- Added a Hexa Strike set since it is multi-hit in case you have Fotia Belt/Gorget.
- Updated Version Compatibility Codename to Indi-Voidance.
- Code cleanup.

06.14.22 (Version Compatibility Codename: Indi-Poison)
- Adjusted HUD timings on load. Should fix the occasional errors about text objects not existing as well as objects loading underneath the background layer.
- Removed Gearswaps built-in debugmode from the files Debug mode.
- Moved the Updates section towards the top of the file.
- Code cleanup.

03.11.22 (Version Compatibility Codename: Indi-Poison)
- Overhauled Debuff Notifications. Will now check which debuffs are up in real time with a list of priority for which is displayed instead of clearing the notifications entirely when any of them are removed (leaving it blank even if a different debuff was still up).
- Added missing On/Off option/rules to Time Remaining (currently only for Abyssea), Omen, and Vagary
- Fixed Alliance invite incorrectly triggering Party invite notification.

02.02.22 (Version Compatibility Codename: Indi-Poison)
- Added Weak status notification.
- Fixed gear not fully equipping in towns.
- Fixed Abyssea Visitant status triggering on incorrect time remaining (ie 110 minutes would trigger the 10 minute)
- Fixed Fast Cast gear to not equip when using a Forbidden Key, Pickaxe, Sickle, or Hatchet.

02.01.22 (Version Compatibility Codename: Ind-Poison)
- Overhauled Notifications. Removed reliance on variables and spun out Debuffs into their own thing.
- Renamed the OnScreen Display to HUD.
- Added Paralysis to the Debuffs.
- Added option to automatically use an Echo Drop (or Remedy) instead of spell when you are silenced.
- Added AutoFullCircle function. Automatically uses Full Circle when you cast a Geo- spell with a Luopan already out.
- Added rule for White Magic Cure spells to the Healing set.
- Added option for setting macro book page (set).
- Added Trade, Invite, Sneak, Invisible, Vorseal, Signet, Sanction, Sigil, and Ionis to the Notifications.
- Added the 3000 TP notification to the Notification options.
- Added 2 new sounds (NotiGood and NotiBad) and adjusted sound usage accordingly.
- Added a Heartbeat function. This creates a one second "heartbeat" that we can use to do various things that may not otherwise have an automatic trigger.
- Added a background to the HUD creating a box that everything is displayed inside, instead of separate floating pieces of info.
- Moved the KO Notification into the Heartbeat function.
- Moved Luopan check into the Heartbeat function.
- Added HUD now hiding when in a cutscene. (The code to hide while zoning is adding a lot of lag, will look further into this)
- Adjusted the solid colors to be a little less solid (red was just so... ~*RED*~)
- Adjusted the Doom Notification to have a more noticeable presence.
- Fixed an issue with AutoLockstyle where it would not run correctly if you change your sub job immediately after changing to BLU.
- Fixed the Reraise Reminder.
- Fixed the Dead Notification.
- Changed «« and »» to << and >> for chatlog notifications since «« and »» don't actually display in the chatlog.
- Fixed displaying DT Override status while in towns.
- Fixed a lot calls to the Text addon when not using the Text addon (HUD turned off)
- Fixed the Reraise Reminder.
- Code cleanup.

12.02.21 (Version Compatibility Codename: Indi-Regen)
- First version
- Started from Blue Mage file version 11.30.21
</details>
<details>
 
<summary>MNK</summary>

Version 7.7.4
- Adjusted the default Aftermath colors. Flipped AM1 and AM2 for consitancy with Bars distance coloring (green --> blue --> yellow).
- Fixed Sambas not colorizing correctly in the HUD when active.

Version 7.7.3
- Fixed Mog House in Al Zahbi not being recognized as a "town" zone.

Version 7.7.2
- Fixed missing Notification Option for Vorseal and Signet/Sanction/Sigil/Ionis wearing off.

Verison 7.7.1
- Fixed "the random q" issue. In short, they broke a workaround for an issue with coloring text by finally fixing the issue.

Version 7.7
- Added Chocobo Circuit to the list of Town Zones.
- Adjusted a lot of set names to be easier to read using snake_case.
- Adjusted Notifications to clear after joining a party.
- Various code cleanup.

Version 7.6
- Adjusted Notifications to clear after joining a party.
- Fixed an issue with SP2 recast

Version 7.5
- Adjusted HUD Weapons text to color based on the current Aftermath level when the HUD TP Meter is turned off.

Version 7.4.2
- Fixed equip priority of the "town" type sets. They now correctly take priority while in town zones.

Version 7.4.1
- Fixed an error in the Fast Cast update.

Version 7.4
- Added a long overdue set for Fast Cast.

Version 7.3
- Added sets for sub DNC Steps, Waltzes, Animated Flourish, and Violent Flourish

Version 7.2.2
- Fixed DPS modes 2-4 not equipping Footwork and Impetus sets appropriately.

Version 7.2.1
- Fixed the Boost/Ask Sash "MNK Meditate".

Version 7.2
- Adjusted the HUD Recast to now display recast timers above 60 seconds, mimicking the games built-in timers under the buff icons.

Version 7.1.2
- Fixed an issue with Weapon Cycle not equipping initial Main/Sub pairs correctly when switching from another job.

Version 7.1.1
- Adjusted the Weapon Cycle to load the first Main/Sub pair on file load.
- Fixed a few issues with the aliases.

Version 7.1
- Added the option to turn the mini TP Meter inside the HUD on or off.

Version 7.0.3
- Fixed an issue that prevented switching back to the correct gear set in the aftercast stage.

Version 7.0.2
- Removed Super Jump from AutoSave. This was causing too many issues with receiving cures while in the air. Will still activate Chakra, High Jump, and Perfect Counter.

Version 7.0.1
- Fixed an issue with turning Debuff Notifications off causing an error

Version 7.0
- Overhauled the HUD, REMOVING NEED FOR THE TEXT PLUGIN! Now uses the Windower text library. About time!
- Overhauled the Debuffs Notifications. Prioritizes displaying completely debilitating debuffs on top of all others (previous style), with the rest being a displayed in their own position within the Debuff Notification area, allowing multiple debuffs to be displayed at once (Silence/Mute and Curse/Haunt share a spot).
- Added the Advanced Option to specifiy which abilities/spells are displayed in the HUD Recast section. A list of valid abilities/spells is provided.
- Added the Advanced Option to create a custom name for the ability/spell displayed in the HUD Recast section.
- Added the Prime Weapon Varga Purnikawa to Aftermath Notifications, including displaying the amount of PDL received (accounting for both amount of TP used and the current stage of the weapon).
- Added subbing DNC to the Page Option.
- Added Debuff Notification for Animated, Haunt, and Taint.
- Added Mounted status Notification.
- Added proper cleanup of custom text objects, aliases, and binds.
- Adjusted Aftermath notifications to display their time remaining.
- Adjusted Aftermath notification area in the HUD to display as a meter for your TP.
- Adjusted Mythic Aftermath level 1 and 2 to now display their accuracy and attack values.
- Adjusted the formatting of a few areas of the HUD, including the centering of some objects, flashing, automatic truncating of certain sections to keep text within the HUD boundary (equipping a main and sub item with really long names no longer breaks out of the HUD), and some coloring.
- Adjusted HUD Recasts to now display a countdown timer under 60 seconds remaining on recast.
- Adjusted how the Debuff Notifications, Aftermath Notifications, and Alive Notification all work. More efficient now with a huge reduction in calls to update their respective text objects.
- Adjusted Modes. Mode 2 is now a standard set for Multi-Attack w/ DT. Mode 3 is now the Accuracy set.
- Adjusted Boost to work with the Ask Sash to create a "MNK Meditate" using it.
- Adjusted equipping the DT Override set when petrified, stunned, or terrored. This now equips the Oh Shit set instead.
- Adjusted AutoLockstyle. Lockstyling after subjob changes should be more smooth overall.
- Fixed an issue where your maximum HP going under the LowHPThreshold (ex. level-syncing low enough) would trigger the Low HP warning.
- Fixed an error with handling an 'empty' equipment slot in the Weapon Cycler.
- Fixed an error with Super Jump recast when level synced below Master Level 5.
- Fixed two different things both doing status checks in two different ways, combining the two into one.
- Fixed ZoneGear still running when set to Off.
- Removed the DT Override option. This is now a Mode instead.
- Removed ability/spell cancelling while a debuff is present that would prevent that ability/spell from activating. This fixes an issue where there is a split second of server lag between the debuff coming off and the client recognizing it, now allowing for hitting the ability/spell right when the debuff comes off and it activating as it should.
- Removed AutoLockstyle. This has been moved to its own separate addon called Vanity.
- Removed AutoHWater. This has been moved to its own separate addon called Excorcist.
- Removed the //fileinfo command.
- Removed the NotiWeapons option.
- Removed debug option. I feel this is no longer necessary at this point.

Version 6.2.3
- Fixed some errors that would display under certain circumstances immediately after switching characters.

Version 6.2.2
- Fixed AutoSave using multiple "saves" in a row.

Version 6.2.1
- Fixed Footwork and Impetus keeping their respective sets equipped while they are active.

Version 6.2
- Adjusted Weaponskills to not equip a Weaponskill gear set when inside Abyssea and an Abyssea Proc Weapon pair is equipped.

Version 6.1
- Adjusted the Weapon Cycle have a second, separate list for Abyssea Proc Weapons that gets added into the cycle list when inside Abyssea.

Version 6.0.1
- Adjusted HUD Ability recast colors. The short blink is now yellow, only using red when the ability is ready to use.
- Fixed minor issue with WS code not including code for Reive status in a few situations.

Version 6.0
- Added Ascetic's Fury, Victory Smite, and Shijin Spiral gear sets.
- Adjusted how the Weapon Skill sets are coded. You can now add a new set for a WS that is not already defined by simply copying another WS set and changing the set name to match the desired WS name. This change also tidies up the backend code a bit as well which was totally not the main reason for doing it.
- Adjusted AutoSuperJump. Name changed to AutoSave. Will now try Chakra, Super Jump, High Jump, then Perfect Counter, in that order, based on cooldowns. Jumps will not activate while in Mode 4 (Tank).
- Adjusted Page Option. Now defined for subbing WAR or DRG with a default of 1 for other subjobs.
- Adjusted HUD positioning options and text for clarity.
- Adjusted HUD Ability recasts. Removed Counterstance from Mode 4 and added Aggressor in its place. Added High Jump and Super Jump for sub DRG.
- Adjusted HUD Ability recast colors. Will now give a short blink when an ability is becoming ready to use again.
- Adjusted ability recast timings for equipping gear from `<= 1` to `< 2`. Should give a touch more room to fire off properly if you're camping that recast timer.
- Adjusted Gear Mode keybind Advanced Option to remove the hardcoded "CTRL+" requirement. Can now be fully customized (WIN+G, ALT+5, F9, etc.)
- Adjusted the //hidehud and //showhud aliases to condense to just //hud. It also now actually works.

Version 5.0
- No gear set changes.
- Added Advanced Option to add commas to the damage numbers.
- Adjusted Weaponskill Missed notification to also display when a Weaponskill gets blinked.
- Removed notifications for Magic Bursts and Blood Pacts because I don't know why I added it in there.

Version 4.0
- No gear set changes.
- Added AutoSuperJump option. Automatically attempts to use Super Jump when your HP gets critically low. HP threshold required to activate is adjustable in the Advanced Options.

Version 3.0
- No gear set changes.
- Renamed WS Damage Notification to Damage Notification.
- Updated Damage Notification to include Weapon Skills, Skillchains, Magic Bursts, and Blood Pacts.
- Fixed Damage Notification option displaying regardless of being on or off.
- Updated to semantic versioning. This removes the need for the Version Compatibility Codenames.

04.28.22 (Version Compatibility Codename: Shoulder Tackle)
- Added Cataclysm set.

04.15.22 (Version Compatibility Codename: Combo)
- First version
- Started from Samurai file version 02.22.22 (Version Compatibility Codename: Tachi: Yukikaze)
</details>
<details>
 
<summary>PLD</summary>

Version 14.8.5
- Adjusted the default Aftermath colors. Flipped AM1 and AM2 for consitancy with Bars distance coloring (green --> blue --> yellow).

Version 14.8.4
- Fixed Mog House in Al Zahbi not being recognized as a "town" zone.
- Fixed Enlight SIRD set not equipping correctly.
- Fixed missing "catch-all" for any spells not specified for a midcast set.

Version 14.8.3
- Fixed missing Notification Option for Vorseal and Signet/Sanction/Sigil/Ionis wearing off.

Version 14.8.2
- Adjusted code for checking if we are using a 2-handed weapon. More efficient.

Verison 14.8.1
- Fixed "the random q" issue. In short, they broke a workaround for an issue with coloring text by finally fixing the issue.

Version 14.8
- Added Cursna set.

Version 14.7
- Added Chocobo Circuit to the list of Town Zones.
- Adjusted a lot of set names to be easier to read using snake_case.
- Adjusted Notifications to clear after joining a party.
- Various code cleanup.

Version 14.6
- Adjusted Notifications to clear after joining a party.
- Fixed an issue with SP2 recast

Version 14.5
- Adjusted HUD Weapons text to color based on the current Aftermath level when the HUD TP Meter is turned off.

Version 14.4.6
- Fixed an issue where being sub SCH when sub jobs are restricted will produce an error.

Version 14.4.5
- Adjusted the Main/Sub Fast Cast sets to not be equipped when any Aftermath is active.

Version 14.4.4
- Adjusted AutoSubCharge to also activate after a status change back to idle.

Version 14.4.3
- Fix AutoSubCharge trying to activate on any subjob.

Version 14.4.2
- Fixed an error in the Fast Cast update.

Version 14.4.1
- Adjusted how the Fast Cast set gets called.

Version 14.4
- Added SubSCHPage option.
- Added AutoSubCharge option. Automatically attempts to keep Sublimation charging.
- Added support for sub SCH abilities into the HUD recast.

Version 14.3.1
- Adjusted how the AutoDivineEmblem and AutoMajesty work, making them much more consistant now.

Version 14.3
- Added "Main/Sub" sets for Fast Cast, Protect, and Phalanx. These are sets specifically for the main and sub slots and will only equip when TP is under a user-defined TP threshold.
- Added Snapshot set for ranged attacks.
- Added TPThreshold Option for the "Main/Sub" sets.
- Fixed Stoneskin and Sneak not using the Fast Cast set under specific conditions.
- Fixed an issue where AutoMajesty would give an error under specific conditions.
- Fixed Lunge/Swipe Magic Burst Notifications.

Version 14.2.1
- Fixed a double activation of Majesty when activated through the AutoMajesty option.

Version 14.2
- Adjusted the HUD Recast to now display recast timers above 60 seconds, mimicking the games built-in timers under the buff icons.

Version 14.1.2
- Fixed an issue with Weapon Cycle not equipping initial Main/Sub pairs correctly when switching from another job.

Version 14.1.1
- Adjusted the Weapon Cycle to load the first Main/Sub pair on file load.
- Fixed a few issues with the aliases.

Version 14.1
- Added the option to turn the mini TP Meter inside the HUD on or off.

Version 14.0.2

- Fixed a double activation of Divine Emblem when activated through the AutoDEmblem option.

Version 14.0.1
- Fixed an issue with turning Debuff Notifications off causing an error

Version 14.0
- Overhauled the HUD, REMOVING NEED FOR THE TEXT PLUGIN! Now uses the Windower text library. About time!
- Overhauled the Debuffs Notifications. Prioritizes displaying completely debilitating debuffs on top of all others (previous style), with the rest being a displayed in their own position within the Debuff Notification area, allowing multiple debuffs to be displayed at once (Silence/Mute and Curse/Haunt share a spot).
- Added the Advanced Option to specifiy which abilities/spells are displayed in the HUD Recast section. A list of valid abilities/spells is provided.
- Added the Advanced Option to create a custom name for the ability/spell displayed in the HUD Recast section.
- Added the Prime Weapons Caliburnus and Helheim to Aftermath Notifications, including displaying the amount of PDL received (accounting for both amount of TP used and the current stage of the weapon).
- Added Stoneskin cancel when casting Stoneskin and it is already up, preventing "No effect".
- Added equipping the Oh Shit set when petrified, stunned, or terrored.
- Added Debuff Notification for Animated, Haunt, and Taint.
- Added Mounted status Notification.
- Added proper cleanup of custom text objects, aliases, and binds.
- Adjusted Aftermath notifications to display their time remaining.
- Adjusted Aftermath notification area in the HUD to display as a meter for your TP.
- Adjusted the Weapon Cycler to display the next set of intended weapons in the HUD immediately before switching back to the normal display of what is currently equipped. In most cases this switch is invisible and results in a much faster HUD update when switching weapons via the Weapon Cycler. Only when you do not have the intended weapons available to be equipped will the switch be noticeable, as it will display the intended weapons then display what is still actually equipped.
- Adjusted Mythic Aftermath level 1 and 2 to now display their accuracy and attack values.
- Adjusted the formatting of a few areas of the HUD, including the centering of some objects, flashing, automatic truncating of certain sections to keep text within the HUD boundary (equipping a main and sub item with really long names no longer breaks out of the HUD), and some coloring.
- Adjusted HUD Recasts to now display a countdown timer under 60 seconds remaining on recast.
- Adjusted how the Debuff Notifications, Aftermath Notifications, and Alive Notification all work. More efficient now with a huge reduction in calls to update their respective text objects.
- Adjusted sub BLU AOE spells to sdwap out Feather Barrier for Sound Blast. This reverts a previous change in 13.0.
- Adjusted AutoLockstyle. Lockstyling after subjob changes should be more smooth overall.
- Fixed an issue where your maximum HP going under the LowHPThreshold (ex. level-syncing low enough) would trigger the Low HP warning.
- Fixed spelling of the Caballarius Breeches to Cab. Breeches for Invincible Timer gear check.
- Fixed an error with handling an 'empty' equipment slot in the Weapon Cycler.
- Fixed ZoneGear still running when set to Off.
- Removed ability/spell cancelling while a debuff is present that would prevent that ability/spell from activating. This fixes an issue where there is a split second of server lag between the debuff coming off and the client recognizing it, now allowing for hitting the ability/spell right when the debuff comes off and it activating as it should.
- Removed AutoLockstyle. This has been moved to its own separate addon called Vanity.
- Removed AutoHWater. This has been moved to its own separate addon called Excorcist.
- Removed the //fileinfo command.
- Removed the NotiWeapons option.
- Removed debug option. I feel this is no longer necessary at this point.

Version 13.1.2
- Fixed issue with SIRD sets still equipping with Aquaveil active.

Version 13.1.1
- Fixed some errors that would display under certain circumstances immediately after switching characters.

Version 13.1
- Adjusted Weaponskills to not equip a Weaponskill gear set when inside Abyssea and an Abyssea Proc Weapon pair is equipped.

Version 13.0
- Added Weapon Cycle feature. Cycles between pairs of Main slot weapons and Sub slot weapons/grips/shields. Use this to cycle between your commonly used weapons. Has a second, separate list for Abyssea Proc Weapons that gets added into the cycle list when inside Abyssea. Activated with a macro, an alias, or a keyboard shortcut (default is CTRL+H for Hweapon). Can be adjusted or new pairs added in the Weapons section.
- Adjusted how the Weapon Skill sets are coded. You can now add a new set for a WS that is not already defined by simply copying another WS set and changing the set name to match the desired WS name. This change also tidies up the backend code a bit as well which was totally not the main reason for doing it.
- Adjusted Page Option. Now defined for subbing BLU or WAR with a default of 1 for other subjobs.
- Adjusted HUD positioning options and text for clarity.
- Adjusted HUD Ability recasts. Removed Enlight and added Sentinel in its place.
- Adjusted HUD Ability recast colors. Will now give a short blink when an ability is becoming ready to use again.
- Adjusted ability recast and sub BLU AOE/single spell timings for equipping gear from `<= 1` to `< 2`. Should give a touch more room to fire off properly if you're camping that recast timer.
- Adjusted sub BLU AOE/single spells to now check if a spell is set before attempting to cast.
- Adjusted sub BLU AOE spells to include Feather Barrier in the list of spells to cycle through.
- Adjusted Gear Mode keybind Advanced Option to remove the hardcoded "CTRL+" requirement. Can now be fully customized (WIN+G, ALT+5, F9, etc.)
- Adjusted the //hidehud and //showhud aliases to condense to just //hud. It also now actually works.
- Fixed issue introduced with previous version where /BLU AOE spells would skip Sheep Song entirely.

Version 12.0
- No gear set changes.
- Added Advanced Option to add commas to the damage numbers.
- Adjusted Weaponskill Missed notification to also display when a Weaponskill gets blinked.
- Removed notifications for Blood Pacts because I don't know why I added it in there.

Version 11.0
- No gear set changes.
- Renamed WS Damage Notification to Damage Notification.
- Updated Damage Notification to include Weapon Skills, Skillchains, Magic Bursts, and Blood Pacts.
- Fixed Damage Notification option displaying regardless of being on or off.
- Fixed some issues with SIRD sets not equipping correctly while in combat in DPS mode.
- Fixed AutoDefender checking for the old "Tank" mode as opposed to its current name "Combat".
- Updated to semantic versioning. This removes the need for the Version Compatibility Codenames.

04.15.23 (Version Compatibility Codename: Rampart)
- Added a DPS Gear Mode. There was a previous mode that was changed from DPS to Refresh (then later renamed to the current Neutral mode), this change keeps everything as is just adds a separate DPS mode in addition to the way the tanking modes are handled.
- Adjusted /BLU AOE spells to use Banishga if the target is outside of the 6' range that the /BLU spells have.
- Removed the ability to remove the Auto Gear Mode from the Gear Mode rotation. Added unnecessary complexity.
- Fixed missing options listings in the File Info (//fileinfo)
- Updated Version Compatibility Codename to Rampart.

02.22.23 (Version Compatibility Codename: Cover)
- Adjusted WS Damage Notification to display WSs for zero like normal. This reverses a previous change, but now with Skillchain damage being displayed alongside WS damage it made sense to show the zero damage instead of displaying as a miss.
- Fixed Invincible set not equipping when the Invincible Timer option is turned off.

02.07.23 (Version Compatibility Codename: Cover)
- Adjusted WS Damage Notification to filter out some Job Abilities that get listed in the same action category as Weapon Skills.

01.24.23 (Version Compatibility Codename: Cover)
- Adjusted WS Damage Notification to display Skillchain damage.

01.21.23 (Version Compatibility Codename: Cover)
- Adjusted Macro Page timing. Should fix occasional issue with macros deleting themselves.
- Adjusted WS Damage Notification to count blinked WSs and WSs for zero as a miss. Blinks would previously display the number of shadows as the damage number.
- Fixed issue with WS Damage Notification where some abilities and weapon skills would occasionally gets mixed up.

01.10.23 (Version Compatibility Codename: Cover)
- Adjusted HUD to automatically hide during zoning.
- Removed Omen and Vagary notifications. Those have been spun out into their own windower addon called Callouts.
- Fixed Intervene being counted as a Weapon Skill for the damage notification.
- Updated Version Compatibility Codename to Cover.

12.27.22 (Version Compatibility Codename: Sentinel)
- Overhauled the Aftermath notification. Renamed to Weapons. Will now always show your equipped weapon as a default state when no aftermath is up. Will change colors based on what your current TP will give you for an Aftermath effect.
- Adjusted AutoMajesty to not trigger in town.
- Removed the option to turn off the HUD. While I generally think the more options the better, the HUD is a main part of this lua.
- Fixed an error with AutoMajesty not triggering correctly during AfterCast.
- Fixed an error with recast timers and the /BLU spells.
- Fixed occasional error messages from the Text addon when loading/reloading the file.
- Updated Version Compatibility Codename to Sentinel.
- Code cleanup.

12.27.22 (Version Compatibility Codename: Shield Bash)
- Overhauled Low HP notification. Notification and sound no longer activates in towns. Changed the Advanced Option from selecting "Once" or "Constant" to instead selecting the number of times the sound will repeat while your HP is low. Removed the 30 second window before triggering again.
- Adjusted certain notification to now automatically clear after a short delay.
- Removed the option for using the OhShit gear set. The gear set itself still remains and funtionality has not changed. Having the option was redundant as you can simply leave the set empty.
- Fixed Aftermath notification displaying when the NotiAftermath option is turned off.
- Updated Version Compatibility Codename to Shield Bash.
- Code cleanup.

11.30.22 (Version Compatibility Codename: Holy Circle)
- Overhauled how death is handled. More cleanly prevents unnecessary notifications from activating immediately upon raising (ie Reraise wearing off and Low HP).
- Added Danger sound file. Used by Doom and Low HP.
- Added Advanced Option for the Danger sound to play constantly while in danger or only once (with a 30 second delay to be able to play again).
- Added WSDamage option. Displays your damage (or miss) after a Weapon Skill.
- Added Sanguine Blade set.
- Added the //hidehud and //showhud alias commands.
- Added debug lines for redefining variables.
- Adjusted the SIRD sets to not be needed when Aquaveil is up.
- Adjusted Low HP Notification to not trigger while weakened.
- Adjusted Low HP Notification Sound to have a 30 second window after triggering where it will not trigger again.
- Adjusted Low MP Notification to trigger in real-time rather than being tied to the Aftercast funtion.
- Adjusted HUD text object loading timing to avoid them occasionally not loading correctly.
- Adjusted AutoHWater option to stop and notify you once you are out of useable Holy Waters.
- Adjusted the Trade notification to clear once the trade is complete.
- Renamed OhShitThreshold to LowHPThreshold since it controls more than just the OhShit option.
- Removed the option to turn off the HUDRecast. While I generally think the more options the better, the recasts are a main part of the HUD.
- Removed the NotiTPReturn option. This was replaced by the WSDamage option
- Removed the CharmNaked option. Apparently you can't Do Stuff while charmed ¯\_(ツ)_/¯
- Fixed logic preventing Provoke from activating correctly when using Flash when Flash recast is down.
- Fixed incorrect SP Ability timers when wearing gear that augments (adds additional time to) the ability.
- Fixed missing AutoSentinel flag within the rule. Without this it would just trigger regardless of whether the option was set to on or off.
- Updated Version Compatibility Codename to Holy Circle.
- Code cleanup.

10.15.22 (Version Compatibility Codename: Invincible)
- Overhauled how enmity spells are handled. No more macro with a custom command in it. If you are /BLU, just use a macro for Sheep Song and it will cast Sheep Song, Geist Wall, Stinking Gas, or Soporific, in that order, as recasts timers allow. Additionally, now you can use a macro for Flash and it will also use Jettatura or Blank Gaze if you are /BLU, or Provoke if you are /WAR, depending on recast timers and distance to target.
- Added an Oh Shit gear set and accompanying option to use it. HP threshold required to activate is adjustable in the Advanced Options.
- Added AutoSentinel option. Automatically attempts to activate Sentinel when your HP gets critically low. HP threshold required to activate is adjustable in the Advanced Options.
- Added Low HP Notification.
- Added AutoHWater option. Automatically attempts to use Holy Waters when you get Doomed until it wears off. Currently will keep trying even if you run out of Holy Waters.
- Added DoomAlert option. Will alert your party when you are doomed. You can also customize the text that displays in party chat.
- Added CharmNaked option. Removes all gear, or all gear except weapons, when you are charmed.
- Added Crusade, Phalanx, Cocoon, Defender, Reprisal, Palisade, and Enlight to the list of things that will trigger AutoMajesty after use.
- Added Sneak and Invisible status notification.
- Added missing listings in the /fileinfo printout for a few Notifications.
- Added Silver Knife to list of Adoulin/Town areas.
- Adjusted the code that tries to wake you when you are asleep to not trigger if you are charmed.
- Adjusted resting to equip Refresh + Rest gear sets regardless of Mode.
- Moved AutoMajWindow, ModeCtrlPlus, and RRReminderTimer from Options to Advanced Options.
- Removed Gearswaps built-in showswaps function from the files debug mode.
- Fixed looking in the hands slot for the leg pieces to augment Invincible. (Thanks to Mailani for the catch)
- Updated Version Compatibility Codename to Invincible.
- Code cleanup.

09.10.22 (Version Compatibility Codename: Shield Mastery)
- Added AutoDEmblem option. Automatically activates Divine Emblem before a Flash when Divine Emblem is up.
- Added Max HP set and accompanying option to use it. Activates if you cure yourself while at or near capped HP% and will attempt to stay in it until your HP% falls too low, then switches back to your normal Tank set.
- Added all DOTs to the rule that removes Stoneskin if asleep.
- Split a number of sets into "X set" and "X set with SIRD" to have finer control over specific benefits per set (thanks Mailani for the idea).
- Renamed Idle set to Movement Speed since it's more accurate.
- Updated Version Compatibility Codename to Shield Mastery.

08.23.22 (Version Compatibility Codename: Resist Sleep)
- Adjusted what the fastcast set ignores to include all "Ring" items (previously would ignore only Warp and Dimensional Rings specifically, will now also ignore XP/CP rings)
- Fixed the macro needed for BLU Aoe spells in the Notes section

08.13.22 (Version Compatibility Codename: Resist Sleep)
- Overhauled the Mode functionality. There are now 3 modes: Auto, Combat, and Neutral. Combat and Neutral are the basic modes that can be selected individually or Auto will switch between the two in a (mostly) intelligent manner. Combat has a focus on tank sets and SIRD, while Neutral is for refresh and maximizing gear bonuses for buffs. What auto decides is based off when the game thinks you are in combat. This works just fine in most cases, but is not always exactly correct, so you can manually rotate between modes as needed.
- Added Leafallia to list of towns.
- Changed the Cursna set to Holy Water.
- Adjusted the Vim Torque code to first remove Stoneskin if its up, then check that we're not already poisoned and HP is above 50.
- Adjusted abilities to not equip their gear sets if they are still on cooldown.
- Curing while in combat will now fill in any undefined slots from the Healing set with the Enmity set.
- Removed the Buffs set. Protect and Shell were using this, they now use the Enhancing set instead. (Thanks to Mailani for the catch)
- Renamed LockstyleField to LockstyleCombat. Just makes more sense.
- Fixed an issue where the debuff background color change from Doom (flashing white and yellow) would get stuck on yellow after Doom wears off and you have another debuff on that takes over in the debuff spot.
- Updated Version Compatibility Codename to Resist Sleep.
- Code cleanup.

07.18.22 (Version Compatibility Codename: Defense Bonus)
- Updated AutoMajesty to now re-up Majesty before it wears off, exact timing window can be adjusted in the Options.
- Overhauled how area checks are handled. Uses tables now for groups of areas.
- Fixed some errors that would show up on job change. These were caused by the Heartbeat function constantly checking for any debuffs present; when you unload the file (change job) it will delete the debuff text objects used for the HUD which will cause a split second where the debuff check freaks out. The fix was to simply disable the debuff checks in town zones.
- Fixed an issue with the Sleep debuff not showing properly in the HUD.
- Updated Version Compatibility Codename to Defense Bonus.
- Code cleanup.

06.14.22 (Version Compatibility Codename: Undead Killer)
- Adjusted HUD timings on load. Should fix the occasional errors about text objects not existing as well as objects loading underneath the background layer.
- Adjusted Ability recast order in the HUD.
- Changed DPS mode to Refresh mode and adjusted gear equipping and HUD behavior accordingly.
- Removed Gearswaps built-in debugmode from the files Debug mode.
- Fixed Relic Aftermath not displaying in the HUD.
- Moved the Updates section towards the top of the file.
- Code cleanup.

03.11.22 (Version Compatibility Codename: Undead Killer)
- Overhauled Debuff Notifications. Will now check which debuffs are up in real time with a list of priority for which is displayed instead of clearing the notifications entirely when any of them are removed (leaving it blank even if a different debuff was still up).
- Added missing On/Off option/rules to Time Remaining (currently only for Abyssea), Omen, and Vagary
- Fixed Alliance invite incorrectly triggering Party invite notification.
- Fixed some subjob conditions throwing errors when you have no subjob (ie Odyssey NMs)
- Fixed AutoMajesty and AutoDefender to not attempt to activate when you have Amnesia.

02.02.22 (Version Compatibility Codename: Undead Killer)
- Added Weak status notification.
- Updated "Codename" to "Version Compatibility Codename" to be more clear in its purpose. Whenever changes are made to the top portion of the file, the Version Compatibility Codename is changed and the TopVersion and BottomVersion updated to reflect the new codename. The idea is that the Top and Bottom Versions should always match. If you update your file after the VCC changes and only update the bottom without also doing the top, they will then no longer match making it easier to help find a problem later.
- Updated how the HUD loading is handled. The loading is now smoother and objects don't overlap eachother while loading.
- Fixed gear not fully equipping in towns.
- Fixed Abyssea Visitant status triggering on incorrect time remaining (ie 110 minutes would trigger the 10 minute)
- Fixed Fast Cast gear to not equip when using a Forbidden Key, Pickaxe, Sickle, or Hatchet.

02.01.22 (Version Compatibility Codename: Undead Killer)
- First version
- Started from Blue Mage file version 02.01.22
</details>
<details>
 
<summary>RUN</summary>

Version 9.9
- Added Weapon Skill Accuracy set. This set will be used first then inherit from the base Weapon Skill set when in any mode except DPS (DPS mode will go straight for the Weapon Skill set).
- Adjusted the default Aftermath colors. Flipped AM1 and AM2 for consitancy with Bars distance coloring (green --> blue --> yellow).

Version 9.8.5
- Fixed Mog House in Al Zahbi not being recognized as a "town" zone.
- Fixed missing "catch-all" for any spells not specified for a midcast set.

Version 9.8.4
- Fixed missing Notification Option for Vorseal and Signet/Sanction/Sigil/Ionis wearing off.

Version 9.8.3
- Adjusted code for checking if we are using a 2-handed weapon. More efficient.

Verison 9.8.2
- Fixed "the random q" issue. In short, they broke a workaround for an issue with coloring text by finally fixing the issue.

Version 9.8.1
- Fixed Runes not clearing when put under level sync.

Version 9.8
- Added Chocobo Circuit to the list of Town Zones.
- Adjusted a lot of set names to be easier to read using snake_case.
- Adjusted Notifications to clear after joining a party.
- Various code cleanup.

Version 9.7
- Adjusted Notifications to clear after joining a party.
- Fixed an issue with SP2 recast

Verison 9.6.1
- Adjusted Runes to clear when gaining "SJ Restricted" buff.
- Fixed movementspeed/refresh sets not equipping when idle in DPS Mode.

Version 9.6
- Adjusted HUD Weapons text to color based on the current Aftermath level when the HUD TP Meter is turned off.

Version 9.5.1
- Remembered why I didn't add a Pflug set.

Version 9.5
- Added missing Pflug set and rules. No idea how I missed it.

Version 9.4.2
- Fixed an error in the Fast Cast update.

Version 9.4.1
- Adjusted how the Fast Cast set gets called.

Version 9.4
- Added Snapshot set for ranged attacks.
- Fixed Lunge/Swipe Magic Burst Notifications.
- Fixed Stoneskin and Sneak not using the Fast Cast set under specific conditions.

Version 9.3
- Adjusted the HUD Recast to now display recast timers above 60 seconds, mimicking the games built-in timers under the buff icons.

Version 9.2.3
- Fixed an issue where the background color of the Notifications area of the HUD would get stuck under certain conditions.
- Fixed an issue where the Rune area of the HUD would reset the Runes to None even if an ability that would consume all Runes was interrupted.
- Fixed the background color object for the Rune area of the HUD not lining up correctly.

Version 9.2.2
- Fixed an issue with Weapon Cycle not equipping initial Main/Sub pairs correctly when switching from another job.

Version 9.2.1
- Adjusted the Weapon Cycle to load the first Main/Sub pair on file load.
- Fixed a few issues with the aliases.

Version 9.2
- Added AutoStance option for sub SAM.

Version 9.1.1
- Fixed Aftermath not displaying timer or stat bonus numbers correctly.

Version 9.1
- Added the option to turn the mini TP Meter inside the HUD on or off.
- Fixed an issue with Notification text color for Rune selection while sneak and/or invisible is up.

Version 9.0.1
- Fixed an issue with turning Debuff Notifications off causing an error

Version 9.0
- Overhauled the HUD, REMOVING NEED FOR THE TEXT PLUGIN! Now uses the Windower text library. About time!
- Overhauled the Debuffs Notifications. Prioritizes displaying completely debilitating debuffs on top of all others (previous style), with the rest being a displayed in their own position within the Debuff Notification area, allowing multiple debuffs to be displayed at once (Silence/Mute and Curse/Haunt share a spot).
- Added the Advanced Option to specifiy which abilities/spells are displayed in the HUD Recast section. A list of valid abilities/spells is provided.
- Added the Advanced Option to create a custom name for the ability/spell displayed in the HUD Recast section.
- Added the Prime Weapon Helheim to Aftermath Notifications.
- Added Debuff Notification for Animated, Haunt, and Taint.
- Added Mounted status Notification.
- Added proper cleanup of custom text objects, aliases, and binds.
- Adjusted Aftermath notifications to display their time remaining.
- Adjusted Aftermath notification area in the HUD to display as a meter for your TP.
- Adjusted Mythic Aftermath level 1 and 2 to now display their accuracy and attack values.
- Adjusted the formatting of a few areas of the HUD, including the centering of some objects, flashing, automatic truncating of certain sections to keep text within the HUD boundary (equipping a main and sub item with really long names no longer breaks out of the HUD), and some coloring.
- Adjusted HUD Recasts to now display a countdown timer under 60 seconds remaining on recast.
- Adjusted how the Debuff Notifications, Aftermath Notifications, and Alive Notification all work. More efficient now with a huge reduction in calls to update their respective text objects.
- Adjusted equipping the Tank DT set when petrified, stunned, or terrored. This now equips the Oh Shit set instead.
- Adjusted AutoLockstyle. Lockstyling after subjob changes should be more smooth overall.
- Fixed an issue where your maximum HP going under the LowHPThreshold (ex. level-syncing low enough) would trigger the Low HP warning.
- Fixed two different things both doing status checks in two different ways, combining the two into one.
- Fixed an error with handling an 'empty' equipment slot in the Weapon Cycler.
- Fixed ZoneGear still running when set to Off.
- Removed ability/spell cancelling while a debuff is present that would prevent that ability/spell from activating. This fixes an issue where there is a split second of server lag between the debuff coming off and the client recognizing it, now allowing for hitting the ability/spell right when the debuff comes off and it activating as it should.
- Removed AutoLockstyle. This has been moved to its own separate addon called Vanity.
- Removed AutoHWater. This has been moved to its own separate addon called Excorcist.
- Removed the //fileinfo command.
- Removed the NotiWeapons option.
- Removed debug option. I feel this is no longer necessary at this point.

Version 8.2.1
- Fixed some errors that would display under certain circumstances immediately after switching characters.

Verison 8.2
- Adjusted Wild Carrot, Healing Breeze, and Magic Fruit to use the Healing set.

Version 8.1.1
- Fixed an issue with the HUD Mode occasionally displaying in the wrong color.

Version 8.1
- Adjusted Weaponskills to not equip a Weaponskill gear set when inside Abyssea and an Abyssea Proc Weapon pair is equipped.

Version 8.0
- Added Weapon Cycle feature. Cycles between pairs of Main slot weapons and Sub slot weapons/grips/shields. Use this to cycle between your commonly used weapons. Has a second, separate list for Abyssea Proc Weapons that gets added into the cycle list when inside Abyssea. Activated with a macro, an alias, or a keyboard shortcut (default is CTRL+H for Hweapon). Can be adjusted or new pairs added in the Weapons section.
- Adjusted how the Weapon Skill sets are coded. You can now add a new set for a WS that is not already defined by simply copying another WS set and changing the set name to match the desired WS name. This change also tidies up the backend code a bit as well which was totally not the main reason for doing it.
- Adjusted Page Option. Now defined for subbing BLU, DRK, WHM, PLD, SAM, or WAR with a default of 1 for other subjobs.
- Adjusted HUD positioning options and text for clarity.
- Adjusted HUD Ability recast colors. Will now give a short blink when an ability is becoming ready to use again.
- Adjusted ability recast and sub BLU AOE/single spell timings for equipping gear from `<= 1` to `< 2`. Should give a touch more room to fire off properly if you're camping that recast timer.
- Adjusted sub BLU AOE/single spells to now check if a spell is set before attempting to cast.
- Adjusted sub BLU AOE spells to include Feather Barrier in the list of spells to cycle through.
- Adjusted Gear Mode keybind Advanced Option to remove the hardcoded "CTRL+" requirement. Can now be fully customized (WIN+G, ALT+5, F9, etc.)
- Adjusted the //hidehud and //showhud aliases to condense to just //hud. It also now actually works.

Version 7.0
- No gear set changes.
- Added Advanced Option to add commas to the damage numbers.
- Adjusted Weaponskill Missed notification to also display when a Weaponskill gets blinked.
- Fixed Swipe not equipping Swipe gear set correctly under certain circumstances.
- Removed notifications for Blood Pacts because I don't know why I added it in there.

Version 6.0.2
- Fixed Refresh set combining with nonexistent Kite set.

Version 6.0.1
- Fixed missing DPS set.

Version 6.0.0
- No gear set changes.
- Renamed WS Damage Notification to Damage Notification.
- Updated Damage Notification to include Weapon Skills, Skillchains, Magic Bursts, and Blood Pacts.
- Fixed Damage Notification option displaying regardless of being on or off.
- Updated to semantic versioning. This removes the need for the Version Compatibility Codenames.

04.15.23 (Version Compatibility Codename: Ignis)
- Added new Gear Modes. Added DPS, split Tank into Tank-Parry and Tank-DT, and split Auto into Auto-Parry and Auto-DT. Splitting the Tank/Auto was done because sometimes you're fighting a mob that you cannot parry (ie Sortie boss melees are considered TP moves and therefore not able to be parried).
- Removed the ability to remove the Auto Gear Mode from the Gear Mode rotation. Added unnecessary complexity.
- Fixed missing options listings in the File Info (//fileinfo)

02.22.23 (Version Compatibility Codename: Max HP Boost)
- Adjusted WS Damage Notification to display WSs for zero like normal. This reverses a previous change, but now with Skillchain damage being displayed alongside WS damage it made sense to show the zero damage instead of displaying as a miss.

02.07.23 (Version Compatibility Codename: Max HP Boost)
- Adjusted WS Damage Notification to filter out some Job Abilities that get listed in the same action category as Weapon Skills.

01.24.23 (Version Compatibility Codename: Max HP Boost)
- Adjusted WS Damage Notification to display Skillchain damage.

01.21.23 (Version Compatibility Codename: Max HP Boost)
- Adjusted Macro Page timing. Should fix occasional issue with macros deleting themselves.
- Adjusted WS Damage Notification to count blinked WSs and WSs for zero as a miss. Blinks would previously display the number of shadows as the damage number.
- Fixed issue with WS Damage Notification where some abilities and weapon skills would occasionally gets mixed up.

01.10.23 (Version Compatibility Codename: Max HP Boost)
- Adjusted HUD to automatically hide during zoning.
- Removed Omen and Vagary notifications. Those have been spun out into their own windower addon called Callouts.
- Updated Version Compatibility Codename to Max HP Boost.

12.27.22 (Version Compatibility Codename: Inquartata)
- Overhauled the Aftermath notification. Renamed to Weapons. Will now always show your equipped weapon as a default state when no aftermath is up. Will change colors based on what your current TP will give you for an Aftermath effect.
- Removed the option to turn off the HUD. While I generally think the more options the better, the HUD is a main part of this lua.
- Fixed an error with recast timers and the /BLU spells.
- Fixed occasional error messages from the Text addon when loading/reloading the file.
- Updated Version Compatibility Codename to Inquartata.
- Code cleanup.

12.06.22 (Version Compatibility Codename: Magic Defense Bonus)
- Overhauled Low HP notification. Notification and sound no longer activates in towns. Changed the Advanced Option from selecting "Once" or "Constant" to instead selecting the number of times the sound will repeat while your HP is low. Removed the 30 second window before triggering again.
- Adjusted certain notification to now automatically clear after a short delay.
- Adjusted the Rune Cycling notification to first show your currently selected Rune element before cycling.
- Removed the option for using the OhShit gear set. The gear set itself still remains and funtionality has not changed. Having the option was redundant as you can simply leave the set empty.
- Updated Version Compatibility Codename to Magic Defense Bonus.
- Code cleanup.

11.30.22 (Version Compatibility Codename: Tenacity)
- First version
- Started from Paladin file version 07.18.22
- Overhauled how enmity spells are handled. No more macro with a custom command in it. If you are /BLU, just use a macro for Sheep Song and it will cast Sheep Song, Geist Wall, Stinking Gas, or Soporific, in that order, as recasts timers allow. Additionally, now you can use a macro for Flash and it will also use Jettatura or Blank Gaze if you are /BLU, or Provoke if you are /WAR, depending on recast timers and distance to target.
- Overhauled the Mode functionality. There are now 3 modes: Auto, Combat, and Neutral. Combat and Neutral are the basic modes that can be selected individually or Auto will switch between the two in a (mostly) intelligent manner. Combat has a focus on tank sets and SIRD, while Neutral is for refresh and maximizing gear bonuses for buffs. What auto decides is based off when the game thinks you are in combat. This works just fine in most cases, but is not always exactly correct, so you can manually rotate between modes as needed.
- Overhauled how death is handled. More cleanly prevents unnecessary notifications from activating immediately upon raising (ie Reraise wearing off and Low HP).
- Added Danger sound file. Used by Doom and Low HP.
- Added Advanced Option for the Danger sound to play constantly while in danger or only once (with a 30 second delay to be able to play again).
- Added WSDamage option. Displays your damage (or miss) after a Weapon Skill.
- Added an Oh Shit gear set and accompanying option to use it. HP threshold required to activate is adjustable in the Advanced Options.
- Added Low HP Notification.
- Added AutoHWater option. Automatically attempts to use Holy Waters when you get Doomed until it wears off. Currently will keep trying even if you run out of Holy Waters.
- Added DoomAlert option. Will alert your party when you are doomed. You can also customize the text that displays in party chat.
- Added a Refresh Spell set
- Added Sneak and Invisible status notification.
- Added missing listings in the /fileinfo printout for a few Notifications.
- Added Leafallia to list of towns.
- Added Silver Knife to list of Adoulin/Town areas.
- Added equipping the Kite set when petrified, stunned, or terrored.
- Added the //hidehud and //showhud alias commands.
- Added debug lines for redefining variables.
- Adjusted the SIRD sets to not be needed when Aquaveil is up.
- Adjusted Low MP Notification to trigger in real-time rather than being tied to the Aftercast funtion.
- Adjusted HUD text object loading timing to avoid them occasionally not loading correctly.
- Adjusted the code that tries to wake you when you are asleep to not trigger if you are charmed.
- Adjusted resting to equip Refresh + Rest gear sets regardless of Mode.
- Adjusted the Trade notification to clear once the trade is complete.
- Changed the Cursna set to Holy Water.
- Adjusted the Frenzy Sallet code to first remove Stoneskin if its up, then check that we're not already DOT'd and HP is above 100.
- Adjusted abilities to not equip their gear sets if they are still on cooldown.
- Adjusted what the fastcast set ignores to include all "Ring" items (previously would ignore only Warp and Dimensional Rings specifically, will now also ignore XP/CP rings)
- Moved ModeCtrlPlus and RRReminderTimer from Options to Advanced Options.
- Curing while in combat will now fill in any undefined slots from the Healing set with the Enmity set.
- Renamed Idle set to Movement Speed since it's more accurate.
- Renamed LockstyleField to LockstyleCombat. Just makes more sense.
- Removed the option to turn off the HUDRecast. While I generally think the more options the better, the recasts are a main part of the HUD.
- Removed the Buffs set. Protect and Shell were using this, they now use the Enhancing set instead. (Thanks to Mailani for the catch)
- Removed Gearswaps built-in showswaps function from the files debug mode.
- Fixed incorrect SP Ability timers when wearing gear that augments (adds additional time to) the ability.
- Fixed an issue where the debuff background color change from Doom (flashing white and yellow) would get stuck on yellow after Doom wears off and you have another debuff on that takes over in the debuff spot.
- Code cleanup.
</details>
<details>
 
<summary>SAM</summary>

Version 15.0.4
- Adjusted the default Aftermath colors. Flipped AM1 and AM2 for consitancy with Bars distance coloring (green --> blue --> yellow).
- Fixed Sambas not colorizing correctly in the HUD when active.

Version 15.0.3
- Fixed Mog House in Al Zahbi not being recognized as a "town" zone.

Version 15.0.2
- Fixed missing Notification Option for Vorseal and Signet/Sanction/Sigil/Ionis wearing off.

Verison 15.0.1
- Fixed "the random q" issue. In short, they broke a workaround for an issue with coloring text by finally fixing the issue.

Version 15.0
- Overhauled the way Weapon Skills are handled. Dramatically simplified WS code. Removed the Capped TP and Attack Cap WS sets. Will now use, in order:  `sets["Weapon Skill Name"].high_buff` if above the Attack Cap Threshold and the set exists > `sets["Weapon Skill Name"]` if the set exists > basic `weapons_skill` set. The `.high_buff` sets allow for setting specific gear per WS instead of a single Capped Attack set that overlays on top of any given WS set. Will layer `hachirin_no_obi`, `ygnass_resolve_1`, `ws_accuracy`, `sekkaniki`, and `meikyo_shisui` sets on top of the base set used as necessary.
- Added Chocobo Circuit to the list of Town Zones.
- Adjusted a lot of set names to be easier to read using snake_case.
- Adjusted Notifications to clear after joining a party.
- Various code cleanup.

Version 14.8
- Adjusted Notifications to clear after joining a party.
- Fixed an issue with SP2 recast

Version 14.7
- Adjusted precast so that using a Soboro Sukehiro will not equip a WS set.

Version 14.6
- Adjusted HUD Weapons text to color based on the current Aftermath level when the HUD TP Meter is turned off.

Version 14.5.2
- Fixed equip priority of the "town" type sets. They now correctly take priority while in town zones.

Version 14.5.1
- Fixed an error in the Fast Cast update.

Version 14.5
- Added a long overdue set for Fast Cast.

Version 14.4
- Added sets for sub DNC Steps, Waltzes, Animated Flourish, and Violent Flourish

Version 14.3
- Added Snapshot and Ranged Attack sets for ranged attacks.

Version 14.2
- Adjusted the HUD Recast to now display recast timers above 60 seconds, mimicking the games built-in timers under the buff icons.

Version 14.1.2
- Fixed an issue with Weapon Cycle not equipping initial Main/Sub pairs correctly when switching from another job.

Version 14.1.1
- Adjusted the Weapon Cycle to load the first Main/Sub pair on file load.
- Fixed a few issues with the aliases.

Version 14.1
- Added the option to turn the mini TP Meter inside the HUD on or off.

Version 14.0.2
- Removed Super Jump from AutoSave. This was causing too many issues with receiving cures while in the air. Will still activate High Jump.

Version 14.0.1
- Fixed an issue with turning Debuff Notifications off causing an error

Version 14.0
- Overhauled the HUD, REMOVING NEED FOR THE TEXT PLUGIN! Now uses the Windower text library. About time!
- Overhauled the Debuffs Notifications. Prioritizes displaying completely debilitating debuffs on top of all others (previous style), with the rest being a displayed in their own position within the Debuff Notification area, allowing multiple debuffs to be displayed at once (Silence/Mute and Curse/Haunt share a spot).
- Added the Advanced Option to specifiy which abilities/spells are displayed in the HUD Recast section. A list of valid abilities/spells is provided.
- Added the Advanced Option to create a custom name for the ability/spell displayed in the HUD Recast section.
- Added the Prime Weapon Kusanagi to Aftermath Notifications, including displaying the amount of PDL received (accounting for both amount of TP used and the current stage of the weapon).
- Added subbing DNC to the Page Option.
- Added Debuff Notification for Animated, Haunt, and Taint.
- Added Mounted status Notification.
- Added proper cleanup of custom text objects, aliases, and binds.
- Adjusted Aftermath notifications to display their time remaining.
- Adjusted Aftermath notification area in the HUD to display as a meter for your TP.
- Adjusted Mythic Aftermath level 1 and 2 to now display their accuracy and attack values.
- Adjusted the formatting of a few areas of the HUD, including the centering of some objects, flashing, automatic truncating of certain sections to keep text within the HUD boundary (equipping a main and sub item with really long names no longer breaks out of the HUD), and some coloring.
- Adjusted HUD Recasts to now display a countdown timer under 60 seconds remaining on recast.
- Adjusted how the Debuff Notifications, Aftermath Notifications, and Alive Notification all work. More efficient now with a huge reduction in calls to update their respective text objects.
- Adjusted Hasso Modes. Mode 2 is now a standard set for Multi-Attack w/ DT. Mode 3 is now the Accuracy set.
- Adjusted equipping the DT Override set when petrified, stunned, or terrored. This now equips the Oh Shit set instead.
- Adjusted AutoLockstyle. Lockstyling after subjob changes should be more smooth overall.
- Fixed an issue where your maximum HP going under the LowHPThreshold (ex. level-syncing low enough) would trigger the Low HP warning.
- Fixed an error with handling an 'empty' equipment slot in the Weapon Cycler.
- Fixed AutoStance attempting to activate Hasso when level-synced under level 25.
- Fixed an error with Super Jump recast when level synced below Master Level 5.
- Fixed two different things both doing status checks in two different ways, combining the two into one.
- Fixed ZoneGear still running when set to Off.
- Removed the DT Override option. This is now a Mode instead.
- Removed ability/spell cancelling while a debuff is present that would prevent that ability/spell from activating. This fixes an issue where there is a split second of server lag between the debuff coming off and the client recognizing it, now allowing for hitting the ability/spell right when the debuff comes off and it activating as it should.
- Removed AutoLockstyle. This has been moved to its own separate addon called Vanity.
- Removed AutoHWater. This has been moved to its own separate addon called Excorcist.
- Removed the //fileinfo command.
- Removed the NotiWeapons option.
- Removed debug option. I feel this is no longer necessary at this point.

Version 13.2.2
- Fixed some errors that would display under certain circumstances immediately after switching characters.

Version 13.2.1
- Fixed AutoSave using multiple "saves" in a row.

Version 13.2
- Adjusted Weaponskills to not equip a Weaponskill gear set when inside Abyssea and an Abyssea Proc Weapon pair is equipped.

Version 13.1
- Adjusted the Weapon Cycle have a second, separate list for Abyssea Proc Weapons that gets added into the cycle list when inside Abyssea.

Version 13.0
- Added Weapon Cycle feature. Cycles between pairs of Main slot weapons and Sub slot weapons/grips/shields. Use this to cycle between your commonly used weapons or add Abyssea proc weapons. Activated with a macro, an alias, or a keyboard shortcut (default is CTRL+H for Hweapon). Can be adjusted or new pairs added in the Weapons section.
- Adjusted how the Weapon Skill sets are coded. You can now add a new set for a WS that is not already defined by simply copying another WS set and changing the set name to match the desired WS name. This change also tidies up the backend code a bit as well which was totally not the main reason for doing it.
- Adjusted AutoSuperJump. Name changed to AutoSave. Will now try Super Jump then High Jump, in that order, based on cooldowns. Will not activate while in Seigan Stance.
- Adjusted Page Option. Now defined for subbing DRG or WAR with a default of 1 for other subjobs.
- Adjusted HUD positioning options and text for clarity.
- Adjusted HUD Ability recast colors. Will now give a short blink when an ability is becoming ready to use again.
- Adjusted ability recast timings for equipping gear from `<= 1` to `< 2`. Should give a touch more room to fire off properly if you're camping that recast timer.
- Adjusted Gear Mode keybind Advanced Option to remove the hardcoded "CTRL+" requirement. Can now be fully customized (WIN+G, ALT+5, F9, etc.)
- Adjusted the //hidehud and //showhud aliases to condense to just //hud. It also now actually works.

Version 12.0
- No gear set changes.
- Added Advanced Option to add commas to the damage numbers.
- Adjusted Weaponskill Missed notification to also display when a Weaponskill gets blinked.
- Removed notifications for Magic Bursts and Blood Pacts because I don't know why I added it in there.

Version 11.0
- No gear set changes.
- Added AutoSuperJump option. Automatically attempts to use Super Jump when your HP gets critically low. HP threshold required to activate is adjustable in the Advanced Options.

Version 10.0
- Added Attack Capped WS set. Attack threshold required to activate is adjustable in the Advanced Options.

Version 9.0
- No gear set changes.
- Renamed WS Damage Notification to Damage Notification.
- Updated Damage Notification to include Weapon Skills, Skillchains, Magic Bursts, and Blood Pacts.
- Fixed Damage Notification option displaying regardless of being on or off.
- Updated to semantic versioning. This removes the need for the Version Compatibility Codenames.

04.15.23 (Version Compatibility Codename: Tachi: Gekko)
- Added StartMode Advanced Option. Brings this file in line with other files that already have this.
- Adjusted Weapon Skill Accuracy set to inherit undefined slots from the Weapon Skill set.
- Fixed missing options listings in the File Info (//fileinfo)
- Fixed an error within the Hybrid WS rule regarding Tachi: Jinpu and opposing weather element.

02.22.23 (Version Compatibility Codename: Tachi: Yukikaze)
- Adjusted Yaegasumi timer.
- Adjusted WS Damage Notification to display WSs for zero like normal. This reverses a previous change, but now with Skillchain damage being displayed alongside WS damage it made sense to show the zero damage instead of displaying as a miss.

02.07.23 (Version Compatibility Codename: Tachi: Yukikaze)
- Adjusted WS Damage Notification to filter out some Job Abilities that get listed in the same action category as Weapon Skills.

01.24.23 (Version Compatibility Codename: Tachi: Yukikaze)
- Adjusted WS Damage Notification to display Skillchain damage.

01.21.23 (Version Compatibility Codename: Tachi: Yukikaze)
- Added Tachi: Ageha, Tachi: Shoha, and Stardiver sets.
- Added High Accuracy Weapon Skill set. This set is linked to Hasso Mode 2, which is a special set for when you need high accuracy.
- Added Hachirin-no-obi set. Will use the Hachirin-no-obi based on day/weather/scholar weather conditions.
- Added Ygnas's Resolve +1 set. Will use the Ygnas's Resolve +1 when you are in a Reive battle.
- Adjusted precast for when both Meikyo Shisui and Sekkanoki is up to combine those two sets with the appropriate Weapon Skill set.
- Adjusted HUD to automatically hide during zoning.
- Adjusted Macro Page timing. Should fix occasional issue with macros deleting themselves.
- Adjusted WS Damage Notification to count blinked WSs and WSs for zero as a miss. Blinks would previously display the number of shadows as the damage number.
- Fixed issue with WS Damage Notification where some abilities and weapon skills would occasionally gets mixed up.
- Removed Omen and Vagary notifications. Those have been spun out into their own windower addon called Callouts.
- Updated Version Compatibility Codename to Tachi: Yukikaze.

12.29.22 (Version Compatibility Codename: Tachi: Koki)
- Overhauled the Aftermath notification. Renamed to Weapons. Will now always show your equipped weapon as a default state when no aftermath is up. Will change colors based on what your current TP will give you for an Aftermath effect.
- Added AutoStance option. Automatically activates and keeps Stances active.
- Added Advanced Option to adjust the TP threshold for using the Capped TP WS set.
- Removed the option to turn off the HUD. While I generally think the more options the better, the HUD is a main part of this lua.
- Removed the NotiAftermath option in line with the Aftermath notification overhaul.
- Removed the StartMode Advanced Option. Unnecessary since you can label and make the Modes anything you want.
- Fixed occasional error messages from the Text addon when loading/reloading the file.
- Updated Version Compatibility Codename to Tachi: Koki.
- Code cleanup.

12.06.22 (Version Compatibility Codename: Tachi: Jinpu)
- Overhauled Low HP notification. Notification and sound no longer activates in towns. Changed the Advanced Option from selecting "Once" or "Constant" to instead selecting the number of times the sound will repeat while your HP is low. Removed the 30 second window before triggering again.
- Added a fourth Hasso mode.
- Adjusted certain notification to now automatically clear after a short delay.
- Removed the option for using the OhShit gear set. The gear set itself still remains and funtionality has not changed. Having the option was redundant as you can simply leave the set empty.
- Updated Version Compatibility Codename to Tachi: Jinpu.
- Code cleanup.

11.30.22 (Version Compatibility Codename: Tachi: Kagero)
- Overhauled how death is handled. More cleanly prevents unnecessary notifications from activating immediately upon raising (ie Reraise wearing off and Low HP).
- Added Danger sound file. Used by Doom and Low HP.
- Added Advanced Option for the Danger sound to play constantly while in danger or only once (with a 30 second delay to be able to play again).
- Added WSDamage option. Displays your damage (or miss) after a Weapon Skill.
- Added the //hidehud and //showhud alias commands.
- Added debug lines for redefining variables.
- Adjusted Low HP Notification to not trigger while weakened.
- Adjusted Low HP Notification Sound to have a 30 second window after triggering where it will not trigger again.
- Adjusted HUD text object loading timing to avoid them occasionally not loading correctly.
- Adjusted AutoHWater option to stop and notify you once you are out of useable Holy Waters.
- Adjusted the Trade notification to clear once the trade is complete.
- Removed the option to turn off the HUDRecast. While I generally think the more options the better, the recasts are a main part of the HUD.
- Removed the CharmNaked option. Apparently you can't Do Stuff while charmed ¯\_(ツ)_/¯
- Fixed incorrect SP Ability timers when wearing gear that augments (adds additional time to) the ability.
- Fixed ordering of Status Notifications.
- Renamed OhShitThreshold to LowHPThreshold since it controls more than just the OhShit option.
- Updated Version Compatibility Codename to Tachi: Kagero.
- Code cleanup.

10.15.22 (Version Compatibility Codename: Tachi: Goten)
- Renamed Mode to Stance.
- Added new Hasso Modes. Seigan still uses one set while Hasso is split into 3. These modes can be used (and named) however you'd like. You can switch between the 3 modes on the fly with a macro, alias, or keyboard shortcut.
- Added Capped TP Weapon Skill set.
- Added Hybrid Weaponskill set.
- Added an Oh Shit gear set and accompanying option to use it. HP threshold required to activate is adjustable in the Advanced Options.
- Added Low HP Notification.
- Added AutoHWater option. Automatically attempts to use Holy Waters when you get Doomed until it wears off. Currently will keep trying even if you run out of Holy Waters.
- Added DoomAlert option. Will alert your party when you are doomed. You can also customize the text that displays in party chat.
- Added Sneak and Invisible status notification.
- Added missing listings in the /fileinfo printout for a few Notifications.
- Added Silver Knife to list of Adoulin/Town areas.
- Adjusted CharmNaked option to have three options: all gear, all gear except weapons, or off.
- Adjusted the code that tries to wake you when you are asleep to not trigger if you are charmed.
- Moved RRReminderTimer from Options to Advanced Options.
- Removed Gearswaps built-in showswaps function from the files debug mode.
- Updated Version Compatibility Codename to Tachi: Goten.
- Code cleanup.

09.04.22 (Version Compatibility Codename: Tachi: Hobaku)
- Added all DOTs to the rule that removes Stoneskin if asleep.

08.13.22 (Version Compatibility Codename: Tachi: Hobaku)
- Added Leafallia to list of towns.
- Added equipping the DT Override set when petrified, stunned, or terrored.
- Added option to remove all gear (except weapons) when you are charmed.
- Added a Holy Water set.
- Adjusted the Vim Torque code to first remove Stoneskin if its up, then check that we're not already poisoned and HP is above 50.
- Adjusted abilities to not equip their gear sets if they are still on cooldown.
- Renamed LockstyleField to LockstyleCombat. Just makes more sense.
- Fixed an issue where the debuff background color change from Doom (flashing white and yellow) would get stuck on yellow after Doom wears off and you have another debuff on that takes over in the debuff spot.
- Fixed a duplicate line in the sleep debuff code.
- Updated Version Compatibility Codename to Tachi: Hobaku.
- Code cleanup.

07.18.22 (Version Compatibility Codename: Tachi: Enpi)
- Overhauled how area checks are handled. Uses tables now for groups of areas.
- Fixed some errors that would show up on job change. These were caused by the Heartbeat function constantly checking for any debuffs present; when you unload the file (change job) it will delete the debuff text objects used for the HUD which will cause a split second where the debuff check freaks out. The fix was to simply disable the debuff checks in town zones.
- Fixed the DTOverride set not equipping correctly when idle.
- Fixed an issue with the Sleep debuff not showing properly in the HUD.
- Code cleanup.

06.14.22 (Version Compatibility Codename: Tachi: Enpi)
- Adjusted HUD timings on load. Should fix the occasional errors about text objects not existing as well as objects loading underneath the background layer.
- Fixed Relic Aftermath not displaying in the HUD.
- Removed Gearswaps built-in debugmode from the files Debug mode.
- Moved the Updates section towards the top of the file.
- Code cleanup.

03.10.22 (Version Compatibility Codename: Tachi: Enpi)
- Added missing On/Off option/rules to Time Remaining (currently only for Abyssea), Omen, and Vagary
- Fixed Alliance invite incorrectly triggering Party invite notification.
- Fixed some subjob conditions throwing errors when you have no subjob (ie Odyssey NMs)

02.02.22 (Version Compatibility Codename: Tachi: Enpi)
- Added Weak status notification.
- Fixed gear not fully equipping in towns.
- Fixed Abyssea Visitant status triggering on incorrect time remaining (ie 110 minutes would trigger the 10 minute)

02.01.22 (Version Compatibility Codename: Tachi: Enpi)
- First version
- Started from Blue Mage file version 02.01.22 (Version Compatibility Codename: Pollen)
</details>
<details>
 
<summary>SMN</summary>

Version 12.7.1
- Adjusted the default Aftermath colors. Flipped AM1 and AM2 for consitancy with Bars distance coloring (green --> blue --> yellow).

Version 12.7
- Added TransportLock Option. Cancels the first cast of a transport spell and unlocks additional spells for 3 minutes or until you zone.
- Fixed Mog House in Al Zahbi not being recognized as a "town" zone.
- Fixed missing "catch-all" for any spells not specified for a midcast set.

Version 12.6.2
- Fixed missing Notification Option for Vorseal and Signet/Sanction/Sigil/Ionis wearing off.

Verison 12.6.1
- Fixed "the random q" issue. In short, they broke a workaround for an issue with coloring text by finally fixing the issue.

Version 12.6
- Added Chocobo Circuit to the list of Town Zones.
- Adjusted a lot of set names to be easier to read using snake_case.
- Adjusted Notifications to clear after joining a party.
- Various code cleanup.

Version 12.5
- Adjusted Notifications to clear after joining a party.
- Fixed an issue with SP2 recast

Version 12.4
- Adjusted HUD Weapons text to color based on the current Aftermath level when the HUD TP Meter is turned off.

Version 12.3.4
- Fixed an issue where being sub SCH when sub jobs are restricted will produce an error.

Version 12.3.3
- Adjusted AutoSubCharge to also activate after a status change back to idle.

Version 12.3.2
- Fix AutoSubCharge trying to activate on any subjob.

Version 12.3.1
- Adjusted how the Fast Cast set gets called.

Version 12.3
- Added AutoSubCharge option. Automatically attempts to keep Sublimation charging.
- Fixed HUD recast not updating on subjob change.

Version 12.2.5
- Adjusted how the AutoFavor and AutoRelease work, making them much more consistant now.

Version 12.2.4
- Fixed an issue where AutoRelease and AutoFavor would give an error under specific conditions.
- Fixed Stoneskin and Sneak not using the Fast Cast set under specific conditions.

Version 12.2.3
- Fixed an issue with the Avatar Status not displaying correctly in the HUD.
- Fixed an issue with the Avatar Status not updating correctly in the HUD.

Version 12.2.2
- Fixed a minor error that occasionally displays when dismissing your Avatar.

Version 12.2.1
- Fixed an issue where Gearswaps builtin pet.hpp is too slow to refresh. Switched to bypassing it and calling windower.ffxi.get_mob_by_target('pet').hpp directly.

Version 12.2
- Adjusted the HUD Recast to now display recast timers above 60 seconds, mimicking the games built-in timers under the buff icons.

Version 12.1
- Added the option to turn the mini TP Meter inside the HUD on or off.

Version 12.0.2
- Fixed an issue where the Avatar HP bar would occasionally extend across the screen for a brief moment when first cast.
- Fixed a double activation of Avatar's Favor when activated through the AutoFavor option.

Version 12.0.1
- Fixed an issue with turning Debuff Notifications off causing an error

Version 12.0
- Overhauled the HUD, REMOVING NEED FOR THE TEXT PLUGIN! Now uses the Windower text library. About time!
- Overhauled the Debuffs Notifications. Prioritizes displaying completely debilitating debuffs on top of all others (previous style), with the rest being a displayed in their own position within the Debuff Notification area, allowing multiple debuffs to be displayed at once (Silence/Mute and Curse/Haunt share a spot).
- Added the Advanced Option to specifiy which abilities/spells are displayed in the HUD Recast section. A list of valid abilities/spells is provided.
- Added the Advanced Option to create a custom name for the ability/spell displayed in the HUD Recast section.
- Added the Prime Weapon Opashoro to Aftermath Notifications.
- Added equipping the Oh Shit set when petrified, stunned, or terrored.
- Added Debuff Notification for Animated, Haunt, and Taint.
- Added Mounted status Notification.
- Added proper cleanup of custom text objects, aliases, and binds.
- Adjusted Aftermath notifications to display their time remaining.
- Adjusted Aftermath notification area in the HUD to display as a meter for your TP.
- Adjusted Mythic Aftermath level 1 and 2 to now display their accuracy and attack values.
- Adjusted the formatting of a few areas of the HUD, including the centering of some objects, flashing, automatic truncating of certain sections to keep text within the HUD boundary (equipping a main and sub item with really long names no longer breaks out of the HUD), and some coloring.
- Adjusted HUD Recasts to now display a countdown timer under 60 seconds remaining on recast.
- Adjusted how the Debuff Notifications, Aftermath Notifications, and Alive Notification all work. More efficient now with a huge reduction in calls to update their respective text objects.
- Adjusted Avatar HP meter to update faster.
- Adjusted AutoLockstyle. Lockstyling after subjob changes should be more smooth overall.
- Fixed an issue where your maximum HP going under the LowHPThreshold (ex. level-syncing low enough) would trigger the Low HP warning.
- Fixed looking in the body slot for the Glyphic head for Astral Flow Timer gear check.
- Fixed two different things both doing status checks in two different ways, combining the two into one.
- Fixed ZoneGear still running when set to Off.
- Removed ability/spell cancelling while a debuff is present that would prevent that ability/spell from activating. This fixes an issue where there is a split second of server lag between the debuff coming off and the client recognizing it, now allowing for hitting the ability/spell right when the debuff comes off and it activating as it should.
- Removed AutoLockstyle. This has been moved to its own separate addon called Vanity.
- Removed AutoHWater. This has been moved to its own separate addon called Excorcist.
- Removed the //fileinfo command.
- Removed the NotiWeapons option.
- Removed debug option. I feel this is no longer necessary at this point.

Version 11.0
- No gear set changes.
- Added Auto Elemental Siphon function. This is a command, triggered by either an alias (//siphon), or a macro (/console siphon) that will automatically choose and summon the appropriate Elemental Spirit based on day and weather, use Elemental Siphon, then dismiss the Spirit.
- Adjusted HUD background to display the Avatar HP as a % meter.
- Fixed some errors that would display under certain circumstances immediately after switching characters.

Version 10.0
- Added Summoning and Garland of Bliss gear set.
- Added Advanced Option for Avatar colors.
- Adjusted how the Weapon Skill sets are coded. You can now add a new set for a WS that is not already defined by simply copying another WS set and changing the set name to match the desired WS name. This change also tidies up the backend code a bit as well which was totally not the main reason for doing it.
- Adjusted HUD positioning options and text for clarity.
- Adjusted HUD Ability recast colors. Will now give a short blink when an ability is becoming ready to use again.
- Adjusted ability recast timings for equipping gear from `<= 1` to `< 2`. Should give a touch more room to fire off properly if you're camping that recast timer.
- Adjusted Gear Mode keybind Advanced Option to remove the hardcoded "CTRL+" requirement. Can now be fully customized (WIN+G, ALT+5, F9, etc.)
- Adjusted the //hidehud and //showhud aliases to condense to just //hud. It also now actually works.

Version 9.0
- No gear set changes.
- Added AutoFavor option.
- Added Advanced Option to add commas to the damage numbers.
- Adjusted Blood Pact Notification to exclude Blood Pact: Ward abilities.
- Adjusted Blood Pact notification to include Skillchains created by the Blood Pact.
- Adjusted Weaponskill/Blood Pact Missed notification to also display when a Weaponskill/Blood Pact gets blinked.

Version 8.0
- No gear set changes.
- Renamed WS Damage Notification to Damage Notification.
- Updated Damage Notification to include Weapon Skills, Skillchains, Magic Bursts, and Blood Pacts.
- Fixed Damage Notification option displaying regardless of being on or off.
- Updated to semantic versioning. This removes the need for the Version Compatibility Codenames.

04.15.23 (Version Compatibility Codename: Judgment Bolt)
- Fixed missing options listings in the File Info (//fileinfo)

02.22.23 (Version Compatibility Codename: Judgment Bolt)
- Adjusted WS Damage Notification to display WSs for zero like normal. This reverses a previous change, but now with Skillchain damage being displayed alongside WS damage it made sense to show the zero damage instead of displaying as a miss.

02.07.23 (Version Compatibility Codename: Judgment Bolt)
- Added missing Aftermath colors.
- Adjusted WS Damage Notification to filter out some Job Abilities that get listed in the same action category as Weapon Skills.

01.24.23 (Version Compatibility Codename: Judgment Bolt)
- Adjusted WS Damage Notification to display Skillchain damage.

01.21.23 (Version Compatibility Codename: Judgment Bolt)
- Adjusted Macro Page timing. Should fix occasional issue with macros deleting themselves.
- Adjusted WS Damage Notification to count blinked WSs and WSs for zero as a miss. Blinks would previously display the number of shadows as the damage number.
- Fixed issue with WS Damage Notification where some abilities and weapon skills would occasionally gets mixed up.

01.10.23 (Version Compatibility Codename: Judgment Bolt)
- Adjusted HUD to automatically hide during zoning.
- Removed Omen and Vagary notifications. Those have been spun out into their own windower addon called Callouts.
- Updated Version Compatibility Codename to Judgment Bolt.

12.27.22 (Version Compatibility Codename: Diamond Dust)
- Overhauled the Aftermath notification. Renamed to Weapons. Will now always show your equipped weapon as a default state when no aftermath is up. Will change colors based on what your current TP will give you for an Aftermath effect.
- Removed the option to turn off the HUD. While I generally think the more options the better, the HUD is a main part of this lua.
- Fixed occasional error messages from the Text addon when loading/reloading the file.
- Updated Version Compatibility Codename to Diamond Dust.
- Code cleanup.

12.06.22 (Version Compatibility Codename: Clarsach Call)
- Overhauled Low HP notification. Notification and sound no longer activates in towns. Changed the Advanced Option from selecting "Once" or "Constant" to instead selecting the number of times the sound will repeat while your HP is low. Removed the 30 second window before triggering again.
- Adjusted certain notification to now automatically clear after a short delay.
- Removed the option for using the OhShit gear set. The gear set itself still remains and funtionality has not changed. Having the option was redundant as you can simply leave the set empty.
- Fixed Aftermath notification displaying when the NotiAftermath option is turned off.
- Updated Version Compatibility Codename to Clarsach Call.
- Code cleanup.

11.30.22 (Version Compatibility Codename: Aerial Blast)
- Overhauled how death is handled. More cleanly prevents unnecessary notifications from activating immediately upon raising (ie Reraise wearing off and Low HP).
- Added Danger sound file. Used by Doom and Low HP.
- Added Advanced Option for the Danger sound to play constantly while in danger or only once (with a 30 second delay to be able to play again).
- Added WSDamage option. Displays your damage (or miss) after a Weapon Skill.
- Added the //hidehud and //showhud alias commands.
- Added debug lines for redefining variables.
- Adjusted Low HP Notification Sound to have a 30 second window after triggering where it will not trigger again.
- Adjusted Low MP Notification to trigger in real-time rather than being tied to the Aftercast funtion.
- Adjusted HUD text object loading timing to avoid them occasionally not loading correctly.
- Adjusted AutoHWater option to stop and notify you once you are out of useable Holy Waters.
- Adjusted the Trade notification to clear once the trade is complete.
- Removed the option to turn off the HUDRecast. While I generally think the more options the better, the recasts are a main part of the HUD.
- Removed the CharmNaked option. Apparently you can't Do Stuff while charmed ¯\_(ツ)_/¯
- Fixed incorrect SP Ability timers when wearing gear that augments (adds additional time to) the ability.
- Fixed gear sets not equipping correctly when using Astral Conduit ot Apogee.
- Fixed ordering of Status Notifications.
- Renamed OhShitThreshold to LowHPThreshold since it controls more than just the OhShit option.
- Updated Version Compatibility Codename to Aerial Blast.
- Code cleanup.

10.15.22 (Version Compatibility Codename: Tidal Wave)
- Added an Oh Shit gear set and accompanying option to use it. HP threshold required to activate is adjustable in the Advanced Options.
- Added Low HP Notification.
- Added AutoHWater option. Automatically attempts to use Holy Waters when you get Doomed until it wears off. Currently will keep trying even if you run out of Holy Waters.
- Added DoomAlert option. Will alert your party when you are doomed. You can also customize the text that displays in party chat.
- Added CharmNaked option. Removes all gear, or all gear except weapons, when you are charmed.
- Added Sneak and Invisible status notification.
- Added missing listings in the /fileinfo printout for a few Notifications.
- Added missing Healing gear set.
- Added Silver Knife to list of Adoulin/Town areas.
- Adjusted the code that tries to wake you when you are asleep to not trigger if you are charmed.
- Adjusted resting to equip Refresh + Rest gear sets.
- Moved RRReminderTimer from Options to Advanced Options.
- Fixed resting not equipping the DT Override set properly.
- Removed the Elemental gear set.
- Removed Gearswaps built-in showswaps function from the files debug mode.
- Updated Version Compatibility Codename to Tidal Wave.
- Code cleanup.

08.24.22 (Version Compatibility Codename: Earthen Fury)
- Added Avatar Macro Pages. These will automatically swap to the correct pages for each avatar when you summon them, or go back to your "home page" when they are released or die.
- Adjusted what the fastcast set ignores to include all "Ring" items (previously would ignore only Warp and Dimensional Rings specifically, will now also ignore XP/CP rings)
- Fixed gear sets not equipping properly after bloodpacts or summoning an avatar.
- Code cleanup.

08.13.22 (Version Compatibility Codename: Earthen Fury)
- Added Leafallia to list of towns.
- Added cancelling Stoneskin if its preventing poison from removing sleep.
- Split the Cursna set into Cursna and Holy Water.
- Adjusted abilities to not equip their gear sets if they are still on cooldown.
- Renamed LockstyleField to LockstyleCombat. Just makes more sense.
- Fixed an issue where the debuff background color change from Doom (flashing white and yellow) would get stuck on yellow after Doom wears off and you have another debuff on that takes over in the debuff spot.
- Updated Version Compatibility Codename to Earthen Fury.

07.18.22 (Version Compatibility Codename: Inferno)
- Overhauled how area checks are handled. Uses tables now for groups of areas.
- Fixed some errors that would show up on job change. These were caused by the Heartbeat function constantly checking for any debuffs present; when you unload the file (change job) it will delete the debuff text objects used for the HUD which will cause a split second where the debuff check freaks out. The fix was to simply disable the debuff checks in town zones.
- Fixed an issue with the Sleep debuff not showing properly in the HUD.
- Removed a rule for losing Indicolure leftover from converting from the GEO file.
- Code cleanup.

06.14.22 (Version Compatibility Codename: Inferno)
- First version
- Started from Geomancer file version 06.14.21
</details>
<details>
 
<summary>WAR</summary>

Version 9.0.5
- Adjusted the default Aftermath colors. Flipped AM1 and AM2 for consitancy with Bars distance coloring (green --> blue --> yellow).
- Fixed Sambas not colorizing correctly in the HUD when active.

Version 9.0.4
- Fixed Mog House in Al Zahbi not being recognized as a "town" zone.

Version 9.0.3
- Fixed missing Notification Option for Vorseal and Signet/Sanction/Sigil/Ionis wearing off.

Version 9.0.2
- Adjusted code for checking if we are using a 2-handed weapon and if we are dual wielding. More efficient.
- Fixed a leftover print call from 9.0.1

Verison 9.0.1
- Fixed Mode 3 and 4 not equipping correctly.
- Fixed "the random q" issue. In short, they broke a workaround for an issue with coloring text by finally fixing the issue.

Version 9.0
- Overhauled the way Weapon Skills are handled. Dramatically simplified WS code. Removed the Capped TP and Attack Cap WS sets. Will now use, in order: `ws_accuracy` if in High Accuracy Mode (Mode3) > `sets["Weapon Skill Name"].high_buff` if above the Attack Cap Threshold and the set exists > `sets["Weapon Skill Name"]` if the set exists > `weapons_skill`. The `.high_buff` sets allow for setting specific gear per WS instead of a single Capped Attack set that overlays on top of any given WS set. Will layer `hachirin_no_obi` and `ygnass_resolve_1` sets on top of the base set used as necessary.
- Added Chocobo Circuit to the list of Town Zones.
- Adjusted a lot of set names to be easier to read using snake_case.
- Adjusted Notifications to clear after joining a party.
- Various code cleanup.

Version 8.7
- Adjusted Notifications to clear after joining a party.
- Fixed an issue with SP2 recast

Version 8.6
- Adjusted HUD Weapons text to color based on the current Aftermath level when the HUD TP Meter is turned off.

Version 8.5.2
- Fixed equip priority of the "town" type sets. They now correctly take priority while in town zones.

Version 8.5.1
- Fixed an error in the Fast Cast update.

Version 8.5
- Added a long overdue set for Fast Cast.

Version 8.4
- Added sets for sub DNC Steps, Waltzes, Animated Flourish, and Violent Flourish

Version 8.3
- Added Snapshot set for ranged attacks.

Version 8.2
- Adjusted the HUD Recast to now display recast timers above 60 seconds, mimicking the games built-in timers under the buff icons.

Version 8.1.2
- Fixed an issue with Weapon Cycle not equipping initial Main/Sub pairs correctly when switching from another job.

Version 8.1.1
- Adjusted the Weapon Cycle to load the first Main/Sub pair on file load.
- Fixed a few issues with the aliases.

Version 8.1
- Added the option to turn the mini TP Meter inside the HUD on or off.

Version 8.0.2
- Removed Super Jump from AutoSave. This was causing too many issues with receiving cures while in the air. Will still activate High Jump.

Version 8.0.1
- Fixed an issue with turning Debuff Notifications off causing an error
- Fixed an issue with the main (singlewield) sets for Mode1 and Mode2 not equipping correctly

Version 8.0
- Overhauled the HUD, REMOVING NEED FOR THE TEXT PLUGIN! Now uses the Windower text library. About time!
- Overhauled the Debuffs Notifications. Prioritizes displaying completely debilitating debuffs on top of all others (previous style), with the rest being a displayed in their own position within the Debuff Notification area, allowing multiple debuffs to be displayed at once (Silence/Mute and Curse/Haunt share a spot).
- Added the Advanced Option to specifiy which abilities/spells are displayed in the HUD Recast section. A list of valid abilities/spells is provided.
- Added the Advanced Option to create a custom name for the ability/spell displayed in the HUD Recast section.
- Added the Prime Weapons Helheim and Laphria to Aftermath Notifications.
- Added subbing NIN to the Page Option.
- Added Debuff Notification for Animated, Haunt, and Taint.
- Added Mounted status Notification.
- Added a Defender gear set.
- Added proper cleanup of custom text objects, aliases, and binds.
- Adjusted Aftermath notifications to display their time remaining.
- Adjusted Aftermath notification area in the HUD to display as a meter for your TP.
- Adjusted Mythic Aftermath level 1 and 2 to now display their accuracy and attack values.
- Adjusted the formatting of a few areas of the HUD, including the centering of some objects, flashing, automatic truncating of certain sections to keep text within the HUD boundary (equipping a main and sub item with really long names no longer breaks out of the HUD), and some coloring.
- Adjusted HUD Recasts to now display a countdown timer under 60 seconds remaining on recast.
- Adjusted how the Debuff Notifications, Aftermath Notifications, and Alive Notification all work. More efficient now with a huge reduction in calls to update their respective text objects.
- Adjusted Modes. Mode 2 is now a standard set for Multi-Attack w/ DT. Mode 3 is now the Accuracy set.
- Adjusted how Two-handed and dualwield detection works. No longer requires defining which weapons will trigger each (works automagically now).
- Adjusted AutoStance to only attempt to activate if using a two-handed weapon.
- Adjusted equipping the DT Override set when petrified, stunned, or terrored. This now equips the Oh Shit set instead.
- Adjusted Modes. Mode 2 is now a standard set for Multi-Attack w/ DT. Mode 3 is now the Accuracy set.
- Adjusted AutoLockstyle. Lockstyling after subjob changes should be more smooth overall.
- Fixed an issue where your maximum HP going under the LowHPThreshold (ex. level-syncing low enough) would trigger the Low HP warning.
- Fixed looking in the legs slot for the Agoge hands for Mighty Strikes Timer gear check.
- Fixed AutoStance attempting to activate Hasso when level-synced under level 50 (SAM subjob level 25).
- Fixed two different things both doing status checks in two different ways, combining the two into one.
- Fixed ZoneGear still running when set to Off.
- Removed the DT Override option. This is now a Mode instead.
- Removed ability/spell cancelling while a debuff is present that would prevent that ability/spell from activating. This fixes an issue where there is a split second of server lag between the debuff coming off and the client recognizing it, now allowing for hitting the ability/spell right when the debuff comes off and it activating as it should.
- Removed AutoLockstyle. This has been moved to its own separate addon called Vanity.
- Removed AutoHWater. This has been moved to its own separate addon called Excorcist.
- Removed the //fileinfo command.
- Removed the NotiWeapons option.
- Removed debug option. I feel this is no longer necessary at this point.

Version 7.2.3
- Fixed some errors that would display under certain circumstances immediately after switching characters.

Version 7.2.2
- Fixed AutoSave using multiple "saves" in a row.

Version 7.2.1
- Fixed AutoSave trying to use High/Super Jump while not in combat.

Version 7.2
- Adjusted Weaponskills to not equip a Weaponskill gear set when inside Abyssea and an Abyssea Proc Weapon pair is equipped.

Version 7.1.1
- Fixed AutoStance calling for a text object that does not exist.

Version 7.1
- Adjusted the Weapon Cycle have a second, separate list for Abyssea Proc Weapons that gets added into the cycle list when inside Abyssea.
- Updated the apostrophes used to define the TwoHandedWeapons and the DualWieldWeapons to quotation marks to avoid needing to escape any apostrophes in a weapons name.

Version 7.0
- Added Mode 1 Dual Wield gear set. This set will be used if you have one of the dual wield weapons equipped in the offhand that are listed in the Weapons sections directly above the gear sets.
- Adjusted how the Weapon Skill sets are coded. You can now add a new set for a WS that is not already defined by simply copying another WS set and changing the set name to match the desired WS name. This change also tidies up the backend code a bit as well which was totally not the main reason for doing it.
- Added Weapon Cycle feature. Cycles between pairs of Main slot weapons and Sub slot weapons/grips/shields. Use this to cycle between your commonly used weapons or add Abyssea proc weapons. Activated with a macro, an alias, or a keyboard shortcut (default is CTRL+H for Hweapon). Can be adjusted or new pairs added in the Weapons section.
- Added AutoStance option. Automatically activates and keeps sub SAM Stances active.
- Adjusted AutoSuperJump. Name changed to AutoSave. Will now try Super Jump then High Jump, in that order, based on cooldowns. Will not activate while in Seigan Stance. Will only attempt to activate one "save" each time you are below the HP threshold.
- Adjusted Page Option. Now defined for subbing DRG, SAM, or NIN with a default of 1 for other subjobs.
- Adjusted HUD positioning options and text for clarity.
- Adjusted HUD Ability recast colors. Will now give a short blink when an ability is becoming ready to use again.
- Adjusted ability recast timings for equipping gear from `<= 1` to `< 2`. Should give a touch more room to fire off properly if you're camping that recast timer.
- Adjusted Gear Mode keybind Advanced Option to remove the hardcoded "CTRL+" requirement. Can now be fully customized (WIN+G, ALT+5, F9, etc.)
- Adjusted the //hidehud and //showhud aliases to condense to just //hud. It also now actually works.

Version 6.0
- Added Warrior's Charge gear set.
- Added Mode 1 Two-Handed gear set. This set will be used if you have one of the two-handed weapons equipped that are listed in the Two-Handed Weapons sections directly above the gear sets.
- Adjusted the Weapons Notification to display what weapon/shield is equipped in your sub slot. Will not display if you have one of the weapons listed in the Two-Handed Weapons list equipped.

Version 5.0
- Added Tomahawk gear set.
- Added Advanced Option to add commas to the damage numbers.
- Adjusted Weaponskill Missed notification to also display when a Weaponskill gets blinked.
- Removed notifications for Magic Bursts and Blood Pacts because I don't know why I added it in there.

Version 4.0
- No gear set changes.
- Added AutoSuperJump option. Automatically attempts to use Super Jump when your HP gets critically low. HP threshold required to activate is adjustable in the Advanced Options.

Version 3.0
- Updated Attack Capped WS set. Attack threshold required to activate is adjustable in the Advanced Options.
- Removed the Attack Cap Mode. This is now handled automatically.

Version 2.0
- No gear set changes.
- Renamed WS Damage Notification to Damage Notification.
- Updated Damage Notification to include Weapon Skills, Skillchains, Magic Bursts, and Blood Pacts.
- Fixed Damage Notification option displaying regardless of being on or off.
- Updated to semantic versioning. This removes the need for the Version Compatibility Codenames.

04.15.22 (Version Compatibility Codename: Fast Blade)
- First version
- Started from Samurai file version 02.22.22 (Version Compatibility Codename: Tachi: Yukikaze)
</details>
