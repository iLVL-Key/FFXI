**PLEASE NOTE: These files require the Text plugin to be loaded in order to work.**

# Features #
## Options ##
Each file has an Options and Advanced Options section at the top. Nearly everything that the files do can be adjusted or turned off.

## Gear Modes ##
Certain files have multiple modes you can switch between at any time. Standard DPS, Accuracy, Subtle Blow, etc. PLD and RUN have an Auto mode that will switch between Combat and Neutral modes on its own depending on when the game thinks you are in combat (ie idle but not in combat will equip refresh set, whereas idle but in combat will equip a kite set).

## Weapon Cycler ##
Certain files have the ability to cycle between pairs of Main slot weapons and Sub slot weapons/grips/shields. Use this to cycle between your commonly used weapons. Has a second, separate list for Abyssea Proc Weapons that gets added into the cycle list when inside Abyssea. Will not equip a Weaponskill gear set when inside Abyssea and an Abyssea Proc Weapon pair is equipped. Activated with a macro, an alias, or a keyboard shortcut (default is CTRL+H for Hweapon). Can be adjusted or new pairs added in the Weapons section.

## Sound Effects ##
All files utilize subtle sound effects found in the sounds folder. While not required, it is recommended to download the sounds folder and add it under the Gearswap/data folder to make full use of what the files offer. Don't worry, I've made sure they are not loud or annoying.

The file structure should look like this:

`/addons/Gearswap/data/sounds/varioussoundfiles.wav`

`/addons/Gearswap/data/JOB.lua`

## HUDs ##
Each file has a unique HUD, some are a little more unique than the others.  
In general, each HUD has..  

**Top row:** Status Notifications (things like Sneak/Invis, WS/SC damage, party invites, etc.) and Debuff Notifications (displayed one at a time, most important ones take priority).  

**Middle row(s):** Gear Mode and Weapon Notifications. Will display your currently equipped weapons(s) by default, this changes color based on your TP level and REMA equipped. Relics turn yellow when over 1k TP. Empyreans/Mythics/Aeonics turn blue when over 1k TP, green over 2k TP, and yellow at 3K TP. Displays current Aftermath and effect when appropriate. Some files have more specialized things in here such as SMN Avatars, GEO bubbles, and RUN runes.  

**Bottom row:** Up to 6 of the most commonly used ability/spell recasts. RED means it is ready to use. GREEN means it is currently active. ORANGE means it is not active and not yet ready to use. Gives a short flash of YELLOW/ORANGE just before it is available to use again.  


### BLU ###
![main_full](https://github.com/iLVL-Key/FFXI/assets/101156258/dc72907f-bdb6-468e-8520-821dba589211)

### GEO ###
![main_full](https://github.com/iLVL-Key/FFXI/assets/101156258/01b1ad30-6f03-4047-8ba2-4304574b2691)

### MNK: ###
![HUD_MNK](https://github.com/iLVL-Key/FFXI/assets/101156258/4b6cab79-f7e5-4f8c-96f6-0102899dca2c)

### PLD ###
Image coming soon.

### RUN ###
![main_full](https://github.com/iLVL-Key/FFXI/assets/101156258/8943d3cc-23a8-4af2-bfc5-e53379e6c05f)

### SAM ###
![main_full](https://github.com/iLVL-Key/FFXI/assets/101156258/4ab4954b-3896-48c4-856d-156afd2f13b2)

### SMN ###
![main_full](https://github.com/iLVL-Key/FFXI/assets/101156258/68e4b257-1e66-42e1-b3b3-ab864dd47d10)

### WAR ###
Image coming soon.

# IMPORTANT #
- You must have the _**Text**_ addon loaded in order to use these Gearswap lua files. It can be found in the Windower launcher under the addons tab.  
- When you load this file for the first time, your HUD may not be in a good position, or may be too large. If the HUD is not in a good position, go to the Heads Up Display options and adjust the HUDposX and HUDposY options, then save and reload the file. Adjust and repeat until positioned as desired. If the HUD is too large (or small), adjust the FontSize, LineSpacer, and ColumnSpacer options as needed. Suggested placement is center screen, just above your chat log.

# FAQ #
**Q:** Why am I crashing when I load one of your luas?  
**A:** You're missing the Text plugin.  

**Q:** Can I use these without the HUD?  
**A:** Yes, you can turn off the HUD by going into the Advanced Options in the file and changing ShowHUD to false, this will make it so it is not shown by default when you change job and load the file. You can also turn it on and off in the game by typing //hud. You MUST still have the Text plugin regardless.  

**Q:** Can I request a feature or change, or report a bug?  
**A:** Abso-freakin-lutely.  Message me @ Valefor.Keylesta on ffxiah.com

# Changelog #

<details>
<summary>BLU</summary>

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
- Added a slight wait into the On-Screen display. This should prevent the occasional Text plugin error on file load.
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
- Added ability to turn off the Chat and Book options in case you either do not want to use them or another plugin does it already.
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
 
<summary>GEO</summary>

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
- Fixed a lot calls to the Text plugin when not using the Text plugin (HUD turned off)
- Fixed the Reraise Reminder.
- Code cleanup.

12.02.21 (Version Compatibility Codename: Indi-Regen)
- First version
- Started from Blue Mage file version 11.30.21
</details>
<details>
 
<summary>MNK</summary>

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
