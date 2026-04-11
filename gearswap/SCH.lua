------------------------------------------
-- Keys Gearswap lua file for Scholar   --
------------------------------------------

--[[
------------------------------------------
--                NOTES                 --
------------------------------------------

IMPORTANT:
When you load this file for the first time, your HUD may not be in a good position, or may be too large.
If the HUD is not in a good position, go to the Heads Up Display options below and adjust the HUDposX and HUDposY
options, then save and reload the file. Adjust and repeat until positioned as desired.
If the HUD is too large (or small), adjust the FontSize, LineSpacer, and ColumnSpacer options as needed.
Suggested placement is center screen, just above your chat log.

------------------------------------------

Updates to this file and other GearSwap files and addons can be found at
https://github.com/iLVL-Key/FFXI

Place both this file and the sounds folder inside the GearSwap data folder
	/addons/GearSwap/data/sounds/
	/addons/GearSwap/data/SCH.lua

------------------------------------------
--         HOW TO USE THIS FILE         --
------------------------------------------

NUKE MODES

Adjusts the set used when casting nukes.

Damage			-	Automatically uses the Nuke or Magic Burst gear set as appropriate.
Occult Acumen	-	Uses the Occult Acumen gear set. Intended for nuking to gain TP quickly.

To switch between Nuke Modes, use any of these three options:
1. A macro
	/console mode
2. An alias command
	//mode
3. A keybind shortcut
	CTRL+G
	(Can be changed in the Advanced Options section)

------------------------------------------

DANGER MODE

Auto -	Automatically layers the Danger set on top of other sets if it detects you are taking damage from a monster
		your party is fighting. Disabled after a configurable amount of time has passed. Does not activate when engaged.
On   - 	Always layers the Danger gear set on top of other gear sets.
Off  -	Disables this functionality.

To switch between Danger Modes, use any of these three options:
1. A macro
	/console dt
2. An alias command
	//dt
3. A keybind shortcut
	CTRL+D
	(Can be changed in the Advanced Options section)

------------------------------------------

ELEMENT SELECTOR

Reduce the number of macros or keybinds used to cast different element spells.

There are two ways to use the Element Selector Macros.

1) One side of a page for selecting an element, the other side with all the spells

	Designate one side (CTRL, for example) as having a macro for each element, changing the 'Light' in the example below to each of the different elements (Light/Dark/Fire/Stone/Water/Aero/Blizzard/Thunder):
		/console gs c Light

	Designate the other side (ALT, for example) to having a macro for each of the types of spells, these macros will cast the spell corresponding to the current Element in the SPELL MAPPING section below:
		Tier 1:		/console gs c Tier1
		Tier 2:		/console gs c Tier2
		Tier 3:		/console gs c Tier3
		Tier 4:		/console gs c Tier4
		Tier 5:		/console gs c Tier5
		Storm II:	/console gs c StormII
		Helix I:	/console gs c HelixI
		Helix II:	/console gs c HelixII

2) One side of a page (CTRL or ALT) for all spells plus Cycle Forward and Cycle Backward macros.

	Create the 8 macros listed above for the types of spells (Tier 1-5, Storm II, Helix I-II) as well as macros to cycle through the elements:
		Cycle Forward:	/console gs c CycleF
		Cycle Backward:	/console gs c CycleB

	This contains everything to a single 10-slot set of macros.

Alternatively to using macros for casting these spells, you can also bind them to your keyboard. See the ADVANCED OPTIONS section below to view/change the keybinding for each spell type.

------------------------------------------

JOB HUD

Displays real-time information including various notifications, debilitating debuffs preventing you from taking
actions, Job Ability and spell recasts, as well as specific information catered to how the job functions.

Hide or show the HUD at any time by typing
	//hud

--]]

-------------------------------------------
--                OPTIONS                --
-------------------------------------------

Book			=	'4'		--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
Page			=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
TRTimer			=	true	--[true/false]	Displays a timer for Tabula Rasa in echo.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions
							--				(Town limits this to town gear only).
AlertSounds		=	true	--[true/false]	Plays a sound on alerts. 
UseEcho			=	'R'		--[E/R/Off]		Automatically uses an (E)cho Drop or (R)emedy instead of spell when you are silenced.
AutoTRStrats	=	true	--[true/false]	Automatically uses certain strats based on the spell used when Tabula Rasa is active.
							--				(See AUTOSTRAT MAPPING section below)
AutoGearCheck	=	true	--[true/false]	Automatically checks and equips appropriate gear set on player movement.
AutoMvmntSpeed	=	true	--[true/false]	Automatically equips Movement Speed set on player movement when idle.
AutoSubCharge	=	true	--[true/false]	Automatically attempts to keep Sublimation charging.
TransportLock	=	true	--[true/false]	Cancels your first Transport spell and unlocks for 3 min or until zone.
LockWeaponOnAM	=	true	--[true/false]	Locks your Main/Sub slots when you have Aftermath so you don't lose it.

-- Heads Up Display --
HUDposX			=	100	--	X position for the HUD. 0 is left of the window, increasing this number will move it to the right.
HUDposY			=	100		--	Y position for the HUD. 0 is top of the window, increasing this number will move it downward.
FontSize		=	10.5	--	Adjust the font size. Changing this may require you to adjust the Spacers below as well.
LineSpacer		=	17		--	Space in pixels between each Line of the HUD.
ColumnSpacer	=	95		--	Space in pixels between each Column of the HUD.
ShowTPMeter		=	true	--[true/false]	Show the mini TP Meter inside the Weapons area of the HUD.

notifications = {
-- General Notifications --
	ReraiseReminder	=	true,	--[true/false]	Displays an occasional reminder if Reraise is not up.
	TP3000			=	true,	--[true/false]	Displays a notification when you have 3000 TP.
	Damage			=	true,	--[true/false]	Displays your Weapon Skill, Skillchain, and Magic Burst damage.
	Food			=	true,	--[true/false]	Displays a notification when food wears off.
	Invis			=	true,	--[true/false]	Displays a notification when Invisible is about to wear off.
	Invite			=	true,	--[true/false]	Displays a notification when someone invites to a party/alliance.
	LowHP			=	true,	--[true/false]	Displays a notification when HP is low.
	LowMP			=	true,	--[true/false]	Displays a notification when MP is under 20% when you have a subjob that uses MP.
	Reraise			=	true,	--[true/false]	Displays a notification when reraise wears off.
	Signet			=	true,	--[true/false]	Displays a notification when Signet/Sanction/Sigil/Ionis wears off.
	Sneak			=	true,	--[true/false]	Displays a notification when Sneak is about to wear off.
	Time			=	true,	--[true/false]	Displays a notification for time remaining notices.
	Trade			=	true,	--[true/false]	Displays a notification when someone trades you.
	Vorseal			=	true,	--[true/false]	Displays a notification when Vorseal wears off.

-- Debuff Notifications --
	Amnesia			=	true,	--[true/false]	Displays a notification when you have amnesia.
	Charm			=	true,	--[true/false]	Displays a notification when you are charmed/animated.
	Curse			=	true,	--[true/false]	Displays a notification when you are cursed/haunted/zombied.
	Doom			=	true,	--[true/false]	Displays a notification when you are doomed.
	Encumbrance		=	true,	--[true/false]	Displays a notification when you are encumbered.
	Paralysis		=	true,	--[true/false]	Displays a notification when you are paralyzed.
	Petrification	=	true,	--[true/false]	Displays a notification when you are petrified.
	Plague			=	true,	--[true/false]	Displays a notification when you are plagued.
	Silence			=	true,	--[true/false]	Displays a notification when you are silenced/muted.
	Sleep			=	true,	--[true/false]	Displays a notification when you are slept.
	Stun			=	true,	--[true/false]	Displays a notification when you are stunned.
	Taint			=	true,	--[true/false]	Displays a notification when you are tainted.
	Terror			=	true,	--[true/false]	Displays a notification when you are terrorized.
}

-------------------------------------------
--           ADVANCED OPTIONS            --
-------------------------------------------

ShowHUD				=	true	--[true/false]	Initial state of the HUD. Use `//hud` to show/hide the HUD in game.
StartingNukeMode	=	'Damage'--[Damage/Occult]
								--	Determines the Nuke Mode you will start in. Nuke Mode can be changed at any time by using any
								--	of the three options listed above in the Notes section (a macro, alias, or keyboard shortcut).
StartingDangerMode	=	'Auto'	--[Auto/On/Off]
								--	Determines the Danger Mode you start in. Danger Mode can be changed at any time by using any
								--	of the three options listed above in the Notes section (a macro, alias, or keyboard shortcut).
DefaultElement		= 	'Off'	--[Off/Light/Dark/Fire/Stone/Water/Aero/Blizzard/Thunder]
								--	Starting Element for the Macro Condenser.
AutoStratDelay		=	1		--	Delay in seconds between each strat used and the spell that triggered it when using the AutoTRStrats option.
NMBind				=	'^g'	--Sets the keyboard shortcut you would like to cycle between Nuke Modes. CTRL+G (^g) is default.
DMBind				=	'^d'	--Sets the keyboard shortcut you would like to switch between Danger Modes. CTRL+D (^d) is default.
								--    ^ = CTRL    ! = ALT    @ = WIN    # = APPS    ~ = SHIFT
Tier1Bind			=	'^numpad1'	--Sets the keyboard shortcut for Tier 1 spells (Fire 1, Cure 1, etc).
Tier2Bind			=	'^numpad2'	--Sets the keyboard shortcut for Tier 2 spells (Fire 2, Cure 2, etc).
Tier3Bind			=	'^numpad3'	--Sets the keyboard shortcut for Tier 3 spells (Fire 3, Cure 3, etc).
Tier4Bind			=	'^numpad4'	--Sets the keyboard shortcut for Tier 4 spells (Fire 4, Cure 4, etc).
Tier5Bind			=	'^numpad5'	--Sets the keyboard shortcut for Tier 5 spells (Fire 5, Regen 5, etc).
StormIIBind			=	'^numpad6'	--Sets the keyboard shortcut for Storm II spells.
HelixIBind			=	'^numpad7'	--Sets the keyboard shortcut for Helix I spells.
HelixIIBind			=	'^numpad8'	--Sets the keyboard shortcut for Helix II spells.
									--(See SPELL MAPPING section below)
LowHPThreshold		=	1000	--Below this number is considered Low HP.
FullMpPercent		=	85		--Above this percent is considered full mp.
DangerSafeDelay		=	5		--Delay in seconds after Danger Mode (Auto) activates before it is considered safe again.
DangerPTOnly		=	true	--[true/false]  Danger Mode (Auto) will only activate when in a party with other players (Trusts do not count).
WarningRepeat		=	5		--Maximum number of times the Warning Sound will repeat, once per second.
RRReminderTimer		=	3600	--Delay in seconds between checks to see if Reraise is up (300 is 5 minutes).
NotiDelay			=	6		--Delay in seconds before certain notifications will automatically clear.
PollingRate			=	5		--Times per second to check for various conditions (debuffs, recasts, etc). Higher rates use more CPU.
MoveCastWindow		=	1		--[#]  Window in seconds to wait to come a stop from moving before cassting a spell to help prevent interruption. Set to 0 to disable.
MoveCastDelay		=	0.25	--[#]  Delay in seconds to wait AFTER coming to a stop before casting the pending spell to help prevent interruption.
AddCommas			=	true	--[true/false]	Adds commas to damage numbers.

-------------------------------------------
--              HUD RECAST               --
-------------------------------------------

-- Controls what is displayed in the HUD Recast section.
-- The first column tells the file which ability/spell to place in that slot, the following are valid for use:
--		Tabula Rasa, Caper Emissarius, Convert, Dark Arts, Divine Seal, Enlightenment, Libra, Light Arts, Modus Veritas, Stratagems, Sublimation
-- The "_sh" column allows you to change the name displayed if you would like, leave blank otherwise.
-- NOTE: Names will automatically be truncated to 10 characters to fit correctly.

sub = {
	--SCH/WHM
	WHM = {
		Abil01 = "Stratagems",			Abil01_sh = "Strats",
		Abil02 = "Light Arts",			Abil02_sh = "",
		Abil03 = "Dark Arts",			Abil03_sh = "",
		Abil04 = "Enlightenment",		Abil04_sh = "Enlghtnmnt",
		Abil05 = "Sublimation",			Abil05_sh = "Sublmation",
		Abil06 = "Divine Seal",			Abil06_sh = "Divn Seal",
	},
	--SCH/RDM
	RDM = {
		Abil01 = "Stratagems",			Abil01_sh = "Strats",
		Abil02 = "Light Arts",			Abil02_sh = "",
		Abil03 = "Dark Arts",			Abil03_sh = "",
		Abil04 = "Enlightenment",		Abil04_sh = "Enlghtnmnt",
		Abil05 = "Sublimation",			Abil05_sh = "Sublmation",
		Abil06 = "Convert",				Abil06_sh = "",
	},
	--SCH/other
	OTH = {
		Abil01 = "Stratagems",			Abil01_sh = "Strats",
		Abil02 = "Light Arts",			Abil02_sh = "",
		Abil03 = "Dark Arts",			Abil03_sh = "",
		Abil04 = "Enlightenment",		Abil04_sh = "Enlghtnmnt",
		Abil05 = "Sublimation",			Abil05_sh = "Sublmation",
		Abil06 = "Modus Veritas",		Abil06_sh = "Modus Vrts",
	},
}

-------------------------------------------
--             COLOR VALUES              --
-------------------------------------------

color = {
	-- ELEMENTS --
	Light	= {r = 255, g = 248, b = 220},
	Fire	= {r = 255, g = 0, b = 0},
	Ice		= {r = 135, g = 206, b = 250},
	Air		= {r = 50, g = 205, b = 50},
	Earth	= {r = 250, g = 130, b = 40},
	Thunder	= {r = 186, g = 85, b = 211},
	Water	= {r = 30, g = 144, b = 255},
	Dark	= {r = 200, g = 30, b = 80},
	None	= {r = 255, g = 50, b = 50},

	-- AFTERMATH --
	AM1	= {r = 75, g = 255, b = 75},
	AM2	= {r = 0, g = 200, b = 255},
	AM3	= {r = 255, g = 255, b = 50},

	-- NUKE MODES --
	mode = {
		damage	= {r = 150, g = 255, b = 150},
		occult	= {r = 100, g = 200, b = 255},
	},

	-- ARTS --
	art = {
		light	= {r = 255, g = 248, b = 220},
		white	= {r = 255, g = 248, b = 220},
		dark	= {r = 200, g = 30, b = 80},
		black	= {r = 200, g = 30, b = 80},
	},

	-- HUD RECAST --
	abil = {
		ready		= {r = 255, g = 50, b = 50},	-- Ready to use
		active		= {r = 75, g = 255, b = 75},	-- Currently active
		cooldown	= {r = 255, g = 165, b = 0},	-- On cooldown
		flash		= {r = 255, g = 255, b = 125},	-- Flash (now ready)
		notfound	= {r = 125, g = 125, b = 125}	-- Not Found
	},

	-- DANGER MODE --
	danger_mode = {
		["Auto"] = {r = 255, g = 255, b = 255},
		["On"] = {r = 250, g = 160, b = 0},
		["Off"] = {r = 175, g = 175, b = 175},
	},

}

----------------------------------------------
--            AUTOSTRAT MAPPING             --
----------------------------------------------

-- NOTE: These activate ONLY under Tabula Rasa.

AutoStrat = {

	-- Reduces the MP cost of your next White Magic spell by 50%
	Penury = S{
		"Raise", "Raise II", "Raise III", "Reraise", "Reraise II", "Reraise III",
	},

	-- Reduces the casting time of your next White Magic spell by 50%
	Celerity = S{
		"Raise", "Raise II", "Raise III", "Reraise", "Reraise II", "Reraise III",
	},

	-- Extends the effect of the next Healing or Enhancing White Magic spell to party members within range. MP cost is doubled and casting time is doubled.
	Accession = S{
		"Sneak", "Invisible", "Deodorize", "Protect V", "Shell V",
		"Poisona", "Paralyna", "Blindna", "Silena", "Cursna", "Erase", "Viruna", "Stona",
		"Aquaveil", "Stoneskin", "Blink", "Phalanx", "Adloquium",
		"Enthunder", "Enstone", "Enaero", "Enblizzard", "Enfire", "Enwater", 
		"Barstone", "Barwater", "Baraero", "Barfire", "Barblizzard", "Barthunder",
		"Barsleep", "Barpoison", "Barparalyze", "Barblind", "Barsilence", "Barvirus", "Barpetrify",
		"Regen", "Regen II", "Regen III", "Regen IV", "Regen V", "Embrava",
		"Sandstorm II", "Rainstorm II", "Windstorm II", "Firestorm II", "Hailstorm II", 
		"Thunderstorm II", "Voidstorm II", "Aurorastorm II",
	},

	-- Enhances the potency of the next White Magic spell.
	Rapture = S{
		"Cure", "Cure II", "Cure III", "Cure IV",
		"Cura", "Curaga", "Curaga II", "Curaga III",
		
	},

	-- Increases the accuracy of your next White Magic spell.
	Altruism = S{
		"Slow", "Paralyze", "Silence",
		
	},

	-- Your next white magic spell will generate less enmity.
	Tranquility = S{
		
	},

	-- Increases the enhancement effect duration of your next white magic spell.
	Perpetuance = S{
		"Haste", "Flurry", "Refresh", "Animus Augeo", "Animus Minuo", "Phalanx", "Adloquium", 
		"Enthunder", "Enstone", "Enaero", "Enblizzard", "Enfire", "Enwater", 
		"Regen", "Regen II", "Regen III", "Regen IV", "Regen V", "Embrava",
		"Sandstorm II", "Rainstorm II", "Windstorm II", "Firestorm II", "Hailstorm II", 
		"Thunderstorm II", "Voidstorm II", "Aurorastorm II",
	},

	-- Reduces the MP cost of your next Black Magic spell by 50%
	Parsimony = S{
		"Kaustra",
	},

	-- Reduces the casting time of your next Black Magic spell by 50%
	Alacrity = S{
		"Stun", "Freeze", "Tornado", "Quake", "Burst", "Flood",
		
	},

	-- Extends the effect of the next Enfeebling Black Magic spell to targets within range. MP cost is tripled and casting time is doubled.
	Manifestation = S{
		"Klimaform", "Blaze Spikes", "Ice Spikes", "Shock Spikes",
	},

	-- Enhances the potency of the next Black Magic spell.
	Ebullience = S{
		"Aero III", "Aero IV", "Aero V", "Aeroga", "Aeroga II", "Tornado", "Anemohelix II",
		"Blizzard III", "Blizzard IV", "Blizzard V", "Blizzaga", "Blizzaga II", "Freeze", "Cryohelix II",
		"Fire III", "Fire IV", "Fire V", "Firaga", "Firaga II", "Pyrohelix II",
		"Stone III", "Stone IV", "Stone V", "Stonega", "Stonega II", "Quake", "Geohelix II",
		"Thunder III", "Thunder IV", "Thunder V", "Thundaga", "Burst", "Ionohelix II",
		"Water III", "Water IV", "Water V", "Waterga", "Waterga II", "Flood", "Hydrohelix II",
		"Luminohelix II",
		"Drain", "Aspir", "Aspir II", "Noctohelix II", "Kaustra",
	},

	-- Increases the accuracy of your next black magic spell.
	Focalization = S{
		"Bind", "Blind", "Gravity", "Sleep", "Sleep II", "Dispel", "Distract", "Frazzle",
		"Break", "Sleepga", "Poison II", 
		"Shock", "Rasp", "Choke", "Frost", "Burn", "Drown",
	},

	-- Your next black magic spell will generate less enmity.
	Equanimity = S{
		
	},

	-- Makes it possible for your next elemental magic spell to be used in a skillchain, but not a magic burst.
	Immanence = S{
		
	},
}

----------------------------------------------
--              SPELL MAPPING               --
----------------------------------------------

-- NOTE: These settings are only used when using the Element Selector function

spell_map = {
	--These are the spells associated with each element for each spell type. Add or edit this list as you see fit.
	Tier1	= {
		["Light"] = "Cure", ["Dark"] = "Aspir", ["Fire"] = "Fire", ["Stone"] = "Stone",
		["Water"] = "Water", ["Aero"] = "Aero", ["Blizzard"] = "Blizzard", ["Thunder"] = "Thunder",
	},
	Tier2	= {
		["Light"] = "Cure II", ["Dark"] = "Aspir II", ["Fire"] = "Fire II", ["Stone"] = "Stone II",
		["Water"] = "Water II", ["Aero"] = "Aero II", ["Blizzard"] = "Blizzard II", ["Thunder"] = "Thunder II",
	},
	Tier3	= {
		["Light"] = "Cure III", ["Dark"] = "Drain", ["Fire"] = "Fire III", ["Stone"] = "Stone III",
		["Water"] = "Water III", ["Aero"] = "Aero III", ["Blizzard"] = "Blizzard III", ["Thunder"] = "Thunder III",
	},
	Tier4	= {
		["Light"] = "Cure IV", ["Dark"] = "Dispel", ["Fire"] = "Fire IV", ["Stone"] = "Stone IV",
		["Water"] = "Water IV", ["Aero"] = "Aero IV", ["Blizzard"] = "Blizzard IV", ["Thunder"] = "Thunder IV",
	},
	Tier5	= {
		["Light"] = "Regen V", ["Dark"] = "Sleep II", ["Fire"] = "Fire V", ["Stone"] = "Stone V",
		["Water"] = "Water V", ["Aero"] = "Aero V", ["Blizzard"] = "Blizzard V", ["Thunder"] = "Thunder V",
	},
	StormII = {
		["Light"] = "Aurorastorm II", ["Dark"] = "Voidstorm II", ["Fire"] = "Firestorm II", ["Stone"] = "Sandstorm II",
		["Water"] = "Rainstorm II", ["Aero"] = "Windstorm II", ["Blizzard"] = "Hailstorm II", ["Thunder"] = "Thunderstorm II",
	},
	HelixI = {
		["Light"] = "Luminohelix", ["Dark"] = "Noctohelix", ["Fire"] = "Pyrohelix", ["Stone"] = "Geohelix",
		["Water"] = "Hydrohelix", ["Aero"] = "Anemohelix", ["Blizzard"] = "Cryohelix", ["Thunder"] = "Ionohelix",
	},
	HelixII = {
		["Light"] = "Luminohelix II", ["Dark"] = "Noctohelix II", ["Fire"] = "Pyrohelix II", ["Stone"] = "Geohelix II",
		["Water"] = "Hydrohelix II", ["Aero"] = "Anemohelix II", ["Blizzard"] = "Cryohelix II", ["Thunder"] = "Ionohelix II",
	},
	--Spells will default to the "Default" below if not specified. Add or edit this list as you see fit.
	targets = {
		["Default"] = "<st>",
		["Aspir"] = "<stnpc>", ["Aspir II"] = "<stnpc>", ["Drain"] = "<stnpc>", ["Dispel"] = "<stnpc>", ["Sleep II"] = "<stnpc>",
		["Aurorastorm II"] = "<stpt>", ["Voidstorm II"] = "<stpt>", ["Firestorm II"] = "<stpt>", ["Sandstorm II"] = "<stpt>", ["Rainstorm II"] = "<stpt>", ["Windstorm II"] = "<stpt>", ["Hailstorm II"] = "<stpt>", ["Thunderstorm II"] = "<stpt>",
		["Cure"] = "<stal>", ["Cure II"] = "<stal>", ["Cure III"] = "<stal>", ["Cure IV"] = "<stal>", ["Regen V"] = "<stpt>",
		["Fire"] = "<stnpc>", ["Fire II"] = "<stnpc>", ["Fire III"] = "<stnpc>", ["Fire IV"] = "<stnpc>", ["Fire V"] = "<stpt>",
		["Stone"] = "<stnpc>", ["Stone II"] = "<stnpc>", ["Stone III"] = "<stnpc>", ["Stone IV"] = "<stnpc>", ["Stone V"] = "<stpt>",
		["Water"] = "<stnpc>", ["Water II"] = "<stnpc>", ["Water III"] = "<stnpc>", ["Water IV"] = "<stnpc>", ["Water V"] = "<stpt>",
		["Aero"] = "<stnpc>", ["Aero II"] = "<stnpc>", ["Aero III"] = "<stnpc>", ["Aero IV"] = "<stnpc>", ["Aero V"] = "<stpt>",
		["Blizzard"] = "<stnpc>", ["Blizzard II"] = "<stnpc>", ["Blizzard III"] = "<stnpc>", ["Blizzard IV"] = "<stnpc>", ["Blizzard V"] = "<stpt>",
		["Thunder"] = "<stnpc>", ["Thunder II"] = "<stnpc>", ["Thunder III"] = "<stnpc>", ["Thunder IV"] = "<stnpc>", ["Thunder V"] = "<stpt>",
		["Luminohelix"] = "<stnpc>", ["Noctohelix"] = "<stnpc>", ["Pyrohelix"] = "<stnpc>", ["Geohelix"] = "<stnpc>", ["Hydrohelix"] = "<stnpc>", ["Anemohelix"] = "<stnpc>", ["Cryohelix"] = "<stnpc>", ["Ionohelix"] = "<stnpc>",
		["Luminohelix II"] = "<stnpc>", ["Noctohelix II"] = "<stnpc>", ["Pyrohelix II"] = "<stnpc>", ["Geohelix II"] = "<stnpc>", ["Hydrohelix II"] = "<stnpc>", ["Anemohelix II"] = "<stnpc>", ["Cryohelix II"] = "<stnpc>", ["Ionohelix II"] = "<stnpc>",
	}
}

-------------------------------------------
--    LOW DAMAGE HELIX IMMANENCE MOBS    --
-------------------------------------------

-- These targets automatically use the Low Damage Helix Immanence gear set when casting a Helix spell with Immanence active.

HelixLowDamageImmanence = {
	["Gartell"] = true,
	["Leshonn"] = true,
}

-------------------------------------------
--               GEAR SETS               --
-------------------------------------------

function get_sets()

sets.idle = {
	main="Malignance Pole",
	sub="Khonsu",
	ammo="Homiliary",
	head="Befouled Crown",
	body="Arbatel Gown +3",
	hands="Volte Gloves",
	legs="Arbatel Pants +3",
	feet="Volte Gaiters",
	neck="Loricate Torque +1",
	waist="Null Belt",
	left_ear="Arete del Luna +1",
	right_ear="Alabaster Earring",
	left_ring="Shneddick Ring +1",
	right_ring="Stikini Ring +1",
	back="Solemnity Cape",
}

sets.idle.light_arts = {
	main="Musa",
	sub="Khonsu",
}

sets.idle.dark_arts = {
	main="Tupsimati",
	sub="Enki Strap",
}

sets.idle.full_mp = {
	ammo="Staunch Tathlum +1",
	head="Arbatel Bonnet +3",
	hands="Nyame Gauntlets",
	feet="Mallquis Clogs +2",
	neck="Warder's Charm +1",
	left_ring="Shneddick Ring +1",
	right_ring="Murky Ring",
	back="Null Shawl",
}

sets.idle.sublimation = {
	head="Acad. Mortar. +3",
	body="Peda. Gown +3",
	waist="Embla Sash",
}

-- Movement Speed
-- Equipped while in town, and automatically while moving outside of town if the AutoMvmntSpeed option is enabled.
-- NOTE: If AutoMvmntSpeed is disabled, be sure to include your movement speed gear in the Idle set above.
sets.movement_speed = {
	-- feet="Herald's Gaiters",
}

-- Danger
-- Full DT- and everything you've got with Absorbs or Annuls Damage
sets.danger = {
	head="Nyame Helm",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Warder's Charm +1",
	left_ring="Shadow Ring",
	right_ring="Defending Ring",
	back="Shadow Mantle",
}

-- DPS (Accuracy, Double/Triple Attack, DEX, Store TP, Attack)
sets.melee = {
	ammo="Oshasha's Treatise",
	head="Blistering Sallet +1",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Null Loop",
	waist="Null Belt",
	left_ear="Telos Earring",
	right_ear="Digni. Earring",
	left_ring="Chirich Ring +1",
	right_ring="Chirich Ring +1",
	back="Null Shawl",
}

-- Rest
sets.rest = {
	waist="Austerity Belt +1",
}

-- Weapon Skill - Basic (STR, Weapon Skill Damage, Attack, Double/Triple Attack)
sets.weapon_skill = {
	ammo="Oshasha's Treatise",
	head="Jhakri Coronal +2",
	body="Nyame Mail",
	hands="Jhakri Cuffs +2",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Fotia Gorget",
	waist="Fotia Belt",
	left_ear="Hoxne Earring",
	right_ear="Moonshade Earring",
	left_ring="Chirich Ring +1",
	right_ring="Cornelia's Ring",
	back="Lugh's Cape",
}

-- Myrkr (combines with Weapon Skill set above)
sets["Myrkr"] = set_combine(sets.weapon_skill, {
	ammo="Ghastly Tathlum +1",
	head="Arbatel Bonnet +3",
	body="Acad. Gown +3",
	hands="Nyame Gauntlets",
	legs="Arbatel Pants +3",
	feet="Arbatel Loafers +3",
	neck="Fotia Gorget",
	waist="Fotia Belt",
	left_ear="Loquac. Earring",
	right_ear="Moonshade Earring",
	left_ring="Zodiac Ring",
	right_ring="Metamor. Ring +1",
	back="Aurist's Cape +1",
})

-- Omniscience (combines with Weapon Skill set above)
sets["Omniscience"] = set_combine(sets.weapon_skill, {
	ammo="Sroda Tathlum",
	head="Pixie Hairpin +1",
	body="Arbatel Gown +3",
	hands="Arbatel Bracers +3",
	legs="Arbatel Pants +3",
	feet="Arbatel Loafers +3",
	neck="Argute Stole +2",
	waist="Sacro Cord",
	left_ear="Hoxne Earring",
	right_ear="Arbatel Earring +2",
	left_ring="Archon Ring",
	right_ring="Cornelia's Ring",
	back="Bookworm's Cape",
})

-- Cataclysm (combines with Weapon Skill set above)
sets["Cataclysm"] = set_combine(sets.weapon_skill, {
	ammo="Sroda Tathlum",
	head="Pixie Hairpin +1",
	body="Arbatel Gown +3",
	hands="Jhakri Cuffs +2",
	legs="Arbatel Pants +3",
	feet="Arbatel Loafers +3",
	neck="Argute Stole +2",
	waist="Fotia Belt",
	left_ear="Hoxne Earring",
	right_ear="Moonshade Earring",
	left_ring="Archon Ring",
	right_ring="Cornelia's Ring",
	back="Lugh's Cape",
})

-- Fast Cast (Precast)
-- NOTE: Cap is 80%
-- NOTE: All of the "fast_cast" sets below will combine with this set
sets.fast_cast = {
	ammo="Sapience Orb",
	head="Vanya Hood",
	body="Agwu's Robe",
	hands="Acad. Bracers +3",
	legs="Agwu's Slops",
	feet="Regal Pumps +1",
	neck="Orunmila's Torque",
	waist="Embla Sash",
	left_ear="Malignance Earring",
	right_ear="Enchntr. Earring +1",
	left_ring="Kishar Ring",
	right_ring="Lebeche Ring",
	back="Fi Follet Cape +1",
}

-- Fast Cast When Sub RDM
sets.fast_cast.sub_rdm = {
	ammo="Impatiens",
	back="Perimede Cape",
	waist="Witful Belt",
}

-- Fast Cast With Any Grimoire Active (Light/Dark Arts, Addendum: White/Black)
sets.fast_cast.grimoire = {
	head="Peda. M.Board +3",
	feet="Acad. Loafers +3",
}

-- Fast Cast For Elemental Magic
sets.fast_cast.elemental = {
	left_ear="Malignance Earring",
	body="Mallquis Saio +2",
}

-- Fast Cast for Cures
sets.fast_cast.cure = {
	right_ear="Mendi. Earring",
	feet="Vanya Clogs",
}

-- Dispelga Precast (Daybreak only)
sets.fast_cast.dispelga = {
	main="Daybreak",
}

-- Impact Precast (Twilight/Crepuscular Cloak only)
sets.fast_cast.impact = {
	head=empty,
	body="Twilight Cloak",
}

-- Stoneskin Precast (Stoneskin casting time -)
sets.fast_cast.stoneskin = {
	waist="Siegel Sash",
}

-- Nukes
sets.nuke = {
	main="Tupsimati",
	sub="Enki Strap",
	ammo="Ghastly Tathlum +1",
	head="Arbatel Bonnet +3",
	body="Arbatel Gown +3",
	hands="Arbatel Bracers +3",
	legs="Arbatel Pants +3",
	feet="Arbatel Loafers +3",
	neck="Argute Stole +2",
	waist="Acuity Belt +1",
	left_ear="Malignance Earring",
	right_ear="Arbatel Earring +2",
	left_ring="Freke Ring",
	right_ring="Metamor. Ring +1",
	back="Lugh's Cape",
}

-- Magic Burst Nukes
-- NOTE: Combines with the Nuke set above
sets.nuke.magic_burst = {
	head="Peda. M.Board +3",
	body="Agwu's Robe",
	hands="Agwu's Gages",
	legs="Agwu's Slops",
	left_ring="Mujin Band",
}

-- Magic Occult Acumen
-- NOTE: Combines with the Nuke set above
sets.nuke.occult_acumen = {

}

-- Impact (Twilight/Crepuscular Cloak, Magic Accuracy)
sets.impact = {
	head=empty,
	body="Twilight Cloak",
	neck="Incanter's Torque",
	left_ring="Kishar Ring",
	right_ring="Stikini Ring +1",
}

-- Kaustra
sets.kaustra = {
	head="Pixie Hairpin +1",
	right_ring="Archon Ring",
}

-- Helices
-- NOTE: All of the "helix" sets below will combine with this set
sets.helix = {
	main="Tupsimati",
	sub="Enki Strap",
	ammo="Ghastly Tathlum +1",
	head="Agwu's Cap",
	body="Agwu's Robe",
	hands="Agwu's Gages",
	legs="Agwu's Slops",
	feet="Agwu's Pigaches",
	neck="Argute Stole +2",
	waist="Acuity Belt +1",
	left_ear="Malignance Earring",
	right_ear="Arbatel Earring +2",
	left_ring="Freke Ring",
	right_ring="Metamor. Ring +1",
	back="Lugh's Cape",
}

-- Low Damage Immanence Helices
sets.helix.low_damage_immanence = {

}

-- Magic Burst Helices
sets.helix.magic_burst = {
	head="Peda. M.Board +3",
} 

-- Noctohelix
sets.helix.noctohelix = {
	head="Pixie Hairpin +1",
	right_ring="Archon Ring",
}

-- Luminohelix
sets.helix.luminohelix = {
	-- main="Daybreak"
}

-- Dispelga (Daybreak, Magic Accuracy)
sets.dispelga = {
	main="Daybreak",
}

-- Stun (Magic Accuracy)
sets.stun = {
	ammo="Pemphredo Tathlum",
	head=empty,
	body="Cohort Cloak +1",
	hands="Arbatel Bracers +3",
	legs="Arbatel Pants +3",
	feet="Arbatel Loafers +3",
	neck="Null Loop",
	waist="Null Belt",
	left_ear="Malignance Earring",
	right_ear="Arbatel Earring +2",
	left_ring="Kishar Ring",
	right_ring="Stikini Ring +1",
	back="Null Shawl",
}

-- Aspir & Drain (Magic Accuracy)
sets.aspir_drain = {
	--main="Rubicundity",
	ammo="Pemphredo Tathlum",
	head=empty, --head="Pixie Hairpin +1",
	body="Cohort Cloak +1",
	hands="Nyame Gauntlets",
	legs="Peda. Pants +3",
	feet="Agwu's Pigaches",
	neck="Null Loop", --neck="Erra Pendant",
	waist="Sacro Cord",
	left_ear="Malignance Earring",
	right_ear="Arbatel Earring +2",
	left_ring="Kishar Ring",
	right_ring="Archon Ring", --right_ring="Excelsis Ring",
	back="Null Shawl",
}

-- Max MND
sets.max_mnd = {
	ammo="Pemphredo Tathlum",
	head="Arbatel Bonnet +3",
	body="Arbatel Gown +3",
	hands="Arbatel Bracers +3",
	legs="Arbatel Pants +3",
	feet="Arbatel Loafers +3",
	neck="Incanter's Torque",
	waist="Null Belt",
	left_ear="Malignance Earring",
	right_ear="Arbatel Earring +2",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back="Aurist's Cape +1",
}

-- Enfeebling (Enfeebling Duration, Enfeebling skill)
sets.enfeebling = {
	ammo="Pemphredo Tathlum",
	head=empty,
	body="Cohort Cloak +1",
	hands="Peda. Bracers +3",
	legs="Chironic Hose",
	feet="Arbatel Loafers +3",
	neck="Incanter's Torque",
	waist="Null Belt",
	lear="Malignance Earring",
	rear="Arbatel Earring +2",
	lring="Kishar Ring",
	rring="Stikini Ring +1",
	back="Aurist's Cape +1",
}

-- Hachirin-no-obi
sets.hachirin_no_obi = {
	waist="Hachirin-no-obi",
}

-- Healing (Cure Potency, Healing Magic Skill)
-- NOTE: Cure Potency cap is 50%
-- NOTE: All of the "healing" sets below will combine with this set
sets.healing = {
	main="Musa",
	sub="Khonsu",
	ammo="Pemphredo Tathlum",
	head="Vanya Hood",
	body="Vrikodara Jupon",
	hands={ name="Telchine Gloves", augments={'Rng.Acc.+4 Rng.Atk.+4','"Cure" potency +8%','Enh. Mag. eff. dur. +10',}},
	legs="Acad. Pants +3",
	feet="Vanya Clogs",
	neck="Incanter's Torque",
	waist="Austerity Belt +1",
	left_ear="Meili Earring",
	right_ear="Mendi. Earring",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back="Solemnity Cape",
}

-- Healing Yourself
sets.healing.self = {
	waist="Gishdubar Sash",
}

-- Healing With Addendum: White Active
sets.healing.addendum_white = {
	body="Arbatel Gown +3",
}

-- Regen
sets.regen = {
	main="Musa",
	ammo="Savant's Treatise",
	head="Arbatel Bonnet +3",
	body={ name="Telchine Chas.", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
	hands={ name="Telchine Gloves", augments={'Rng.Acc.+4 Rng.Atk.+4','"Cure" potency +8%','Enh. Mag. eff. dur. +10',}},
	legs={ name="Telchine Braconi", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
	feet={ name="Telchine Pigaches", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
	neck="Incanter's Torque",
	waist="Embla Sash",
	left_ear="Mimir Earring",
	right_ear="Andoaa Earring",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back="Lugh's Cape",
}

-- Stoneskin (Enhances Stoneskin effect)
sets.stoneskin = {
	waist="Siegel Sash",
}

-- Enspells
sets.enspells = {
	head="Arbatel Bonnet +3",
	feet="Regal Pumps +1",
}

-- Enhancing
sets.enhancing = {
	main="Musa",
	ammo="Savant's Treatise",
	head={ name="Telchine Cap", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
	body="Peda. Gown +3",
	hands={ name="Telchine Gloves", augments={'Rng.Acc.+4 Rng.Atk.+4','"Cure" potency +8%','Enh. Mag. eff. dur. +10',}},
	legs={ name="Telchine Braconi", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
	feet={ name="Telchine Pigaches", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
	neck="Incanter's Torque",
	waist="Embla Sash",
	left_ear="Mimir Earring",
	right_ear="Andoaa Earring",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back="Fi Follet Cape +1",
}

-- Storms
sets.storm = {
	feet="Peda. Loafers +3",
}

-- Refresh Spell (Refresh potency, Enhancing Magic Duration)
sets.refresh = {
	waist="Gishdubar Sash",
}

-- Aquaveil
sets.aquaveil = {

}

-- Protect Spells
sets.protect = {
	-- left_ring="Sheltered Ring",
}

-- Shell Spells
sets.shell = {
	-- left_ring="Sheltered Ring",
}

-- Conserve MP
sets.conserve_mp = {
	ammo="Pemphredo Tathlum",
	head="Vanya Hood",
	body="Telchine Chas.",
	hands="Acad. Bracers +3",
	legs="Vanya Slops",
	feet="Vanya Clogs",
	neck="Incanter's Torque",
	waist="Austerity Belt +1",
	left_ear="Magnetic Earring",
	right_ear="Mendi. Earring",
	back="Solemnity Cape",
}

-- Cursna (Cursna, Healing Magic)
sets.cursna = {
	main="Musa",
	ammo="Pemphredo Tathlum",
	head="Vanya Hood",
	body="Peda. Gown +3",
	hands="Peda. Bracers +3",
	legs="Vanya Slops",
	feet="Vanya Clogs",
	neck="Incanter's Torque",
	waist="Austerity Belt +1",
	left_ear="Meili Earring",
	right_ear="Mendi. Earring",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back="Fi Follet Cape +1",
}

-- Cursna Yourself
sets.cursna.self = {
	lring="Purity Ring",
	waist="Gishdubar Sash",
}

-- Holy Water (Holy Water+)
sets.holy_water = {
	lring="Purity Ring"
}

-- Ninjutsu
sets.ninjutsu = {

}

-- Penury Or Parsimony Active
sets.penury_parsimony = {
	legs="Arbatel Pants +3",
}

-- Immanence Active
sets.immanence = {
	hands="Arbatel Bracers +3",
}

-- Perpetuance Active
sets.perpetuance = {
	hands="Arbatel Bracers +3",
}

-- Ebullience Active
sets.ebullience = {
	head="Arbatel Bonnet +3",
}

-- Rapture Active
sets.rapture = {
	head="Arbatel Bonnet +3",
}

-- Light Arts Or Addendum: White Active
sets.light_arts = {
	legs="Acad. Pants +3",
}

-- Dark Arts Or Addendum: Black Active
sets.dark_arts = {
	-- body="Acad. Gown +3",
}

-- Tabula Rasa (Enhances Tabula Rasa gear)
sets.tabula_rasa = {
	legs="Peda. Pants +3",
}

-- Default Town Gear (Put all your fancy-pants gear in here you want to showboat around town in. Does not lockstyle this gear, only equips)
sets.town = set_combine(sets.idle, {

})

-- Adoulin Town Gear
sets.adoulin = set_combine(sets.town, {
	body="Councilor's Garb",
})

-- Bastok Town Gear
sets.bastok = set_combine(sets.town, {
	--body="Republic Aketon", --Note: only increases your speed if you are a citizen of Bastok
})

-- San d'Oria Town Gear
sets.sandoria = set_combine(sets.town, {
	--body="Kingdom Aketon", --Note: only increases your speed if you are a citizen of San d'Oria
})

-- Windurst Town Gear
sets.windurst = set_combine(sets.town, {
	--body="Federation Aketon", --Note: only increases your speed if you are a citizen of Windurst
})

-- Unity Trust Gear
sets.unity = {
	-- body="Sylvie Unity Shirt",
}

end




	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX          DO NOT EDIT BELOW THIS LINE          XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--




FileVersion = '1.3'

-------------------------------------------
--             AREA MAPPING              --
-------------------------------------------

AdoulinZones = {
	["Western Adoulin"] = true, ["Eastern Adoulin"] = true, ["Celennia Memorial Library"] = true, ["Silver Knife"] = true
}

BastokZones = {
	["Bastok Markets"] = true, ["Bastok Mines"] = true, ["Metalworks"] = true, ["Port Bastok"] = true
}

SandyZones = {
	["Chateau d'Oraguille"] = true, ["Northern San d'Oria"] = true, ["Port San d'Oria"] = true, ["Southern San d'Oria"] = true
}

WindyZones = {
	["Heavens Tower"] = true, ["Port Windurst"] = true, ["Windurst Walls"] = true, ["Windurst Waters"] = true, ["Windurst Woods"] = true
}

TownZones = {
	["Western Adoulin"] = true, ["Eastern Adoulin"] = true, ["Celennia Memorial Library"] = true, ["Silver Knife"] = true, ["Bastok Markets"] = true, ["Bastok Mines"] = true, ["Metalworks"] = true, ["Port Bastok"] = true, ["Chateau d'Oraguille"] = true, ["Northern San d'Oria"] = true, ["Port San d'Oria"] = true, ["Southern San d'Oria"] = true, ["Heavens Tower"] = true, ["Port Windurst"] = true, ["Windurst Walls"] = true, ["Windurst Waters"] = true, ["Windurst Woods"] = true, ["Lower Jeuno"] = true, ["Port Jeuno"] = true, ["Ru'Lude Gardens"] = true, ["Upper Jeuno"] = true, ["Aht Urhgan Whitegate"] = true, ["The Colosseum"] = true, ["Tavnazian Safehold"] = true, ["Southern San d'Oria [S]"] = true, ["Bastok Markets [S]"] = true, ["Windurst Waters [S]"] = true, ["Mhaura"] = true, ["Selbina"] = true, ["Rabao"] = true, ["Kazham"] = true, ["Norg"] = true, ["Nashmau"] = true, ["Mog Garden"] = true, ["Leafallia"] = true, ["Chocobo Circuit"] = true
}

-------------------------------------------
--              FILE LOAD                --
-------------------------------------------

sc = {} sc[1] = 'Lght' sc[2] = 'Drkn' sc[3] = 'Grvt' sc[4] = 'Frgm' sc[5] = 'Dstn' sc[6] = 'Fusn' sc[7] = 'Cmpr' sc[8] = 'Lqfn' sc[9] = 'Indr' sc[10] = 'Rvrb' sc[11] = 'Trns' sc[12] = 'Scsn' sc[13] = 'Detn' sc[14] = 'Impc' sc[15] = 'Rdnc' sc[16] = 'Umbr'
--debuffs table used so we're not spamming the Debuff Notifications with text updates (when they get flipped to true it stops updating)
debuffs = {Amnesia = false, Animated = false, Charm = false, Curse = false, Doom = false, Encumbrance = false, Haunt = false, Impairment = false, Mute = false, None = false, Paralysis = false, Petrification = false, Plague = false, Silence = false, Sleep = false, Stun = false, Taint = false, Terror = false, Zombie = false}
SIL = '    '
PAR = '     '
PLG = '     '
CUR = '     '
AMN = '     '
TNT = '     '
ENC = '     '
res = require('resources')
texts = require('texts')
weaponskills = res.weapon_skills
spells = res.spells
jobabilities = res.job_abilities
starting_mode = {["Damage"] = 1, ["Occult"] = 2}
Mode = starting_mode[StartingNukeMode] and starting_mode[StartingNukeMode] or 1
mode_names = {"Damage", "Occult A."}
DangerMode = StartingDangerMode
Element = "Off"
valid_elements = {"Light","Dark","Fire","Stone","Water","Aero","Blizzard","Thunder"}
for _, elem in ipairs(valid_elements) do
	if elem == DefaultElement then
		Element = DefaultElement
		break
	end
end
NotiLowMPToggle = false --start with the toggle off for the Low MP Notification so that it can trigger
RRRCountdown = RRReminderTimer
HUDposYLine1 = HUDposY
last_poll = 0 --keeps the timing for things that happen at the polling rate
last_captured_poll = 0 --keeps the timing for the MoveCastWindow polling rate (0.1 seconds)
last_second = 0 --keeps the timing for things that happen every second
GreetingDelay = 6 --delay to display greeting and file version info
Zoning = false --flips automatically to hide the HUD while zoning
InCS = false --flips automatically to hide the HUD while in a cs
LowHP = false
Alive = true --makes it easier to Do Things or Not Do Things based on if we die.
announceAlive = false --simple flip when we raise to make sure the AliveDelay command and notification text is only done once
WarningCountdown = 0
NotiCountdown = -1 --we set the countdown below 0 to stop the countdown from hitting 0 and triggering the setNotification() command
SafeTimer = -1
TakingDamage = false
EquipMain = ''
currentAfterMath = ''
currentMythicNum = 0
currentPrimeNum = 0
CurrentEquip = ''
pre_mythicNum = 0 --pre_ are used to capture data in precast before it gets confirmed and passed to their regular versions
pre_primeNum = 0
pre_AMTimer = 0
mythicNum = 0
primeNum = 0
AMTimer = 0
currentAMTimer = 0
TP_Window_Open = false
strat_charge_timer = 0 --used to calculate number of Stratagem charges available (based on SCH level)
-- strat_recast = 240 --maximum recast time to go from 0 strat charges to full (reduced with 550 JP to 165)
strat_charges = 0 --number of Stratagem charges available
transport_locked = true
transport_lock_timestamp = 0
player_x = nil
player_y = nil
moving = false
captured = {}
captured_spell_toggle = false
auto_valve_open = true --prevents the auto strats from looping infinitely
active_skillchain_targets = {}
active_chain_affinity = {}
active_immanence = {}

local play_sound = windower.play_sound
local addon_path = windower.addon_path
local Notification_Good = addon_path..'data/sounds/NotiGood.wav'
local Notification_Bad = addon_path..'data/sounds/NotiBad.wav'
local Notification_Danger = addon_path..'data/sounds/Danger.wav'
local Notification_Cancel = addon_path..'data/sounds/Cancel.wav'
local Notification_Aftermath_On = addon_path..'data/sounds/AftermathOn.wav'
local Notification_Aftermath_Off = addon_path..'data/sounds/AftermathOff.wav'
local Notification_3000TP = addon_path..'data/sounds/3000TP.wav'

-- Sets the inital subjob
local subjob = 'OTH'
if player.sub_job == 'WHM' then
	subjob = 'WHM'
elseif player.sub_job == 'RDM' then
	subjob = 'RDM'
end

-- Sets the Chat Mode
if Chat ~= "Off" then
	send_command('input /cm '..Chat)
end

-- Sets the Macro Book and Page
if Book ~= "Off" then
	send_command('input /macro book '..Book)
end
if Page ~= "Off" and not pet.isvalid then
	send_command('wait 2;input /macro set '..Page)
else
	send_command('wait 2;input /macro set 1')
end

if ZoneGear ~= 'Off' then
	send_command('wait 2;gs c Zone Gear')
end

TabulaRasa = {} CaperEmissarius = {} Convert = {} DarkArts = {} DivineSeal = {} Enlightenment = {} Libra = {} LightArts = {} ModusVeritas = {} Stratagems = {} Sublimation = {} 

TabulaRasa.flashed = true
CaperEmissarius.flashed = true
Convert.flashed = true
DarkArts.flashed = true
DivineSeal.flashed = true
Enlightenment.flashed = true
Libra.flashed = true
LightArts.flashed = true
ModusVeritas.flashed = true
Sublimation.flashed = true

max_charges = 5
strat_flash_counter = 5

--Space out each line and column properly
HUDposYLine2 = HUDposYLine1 + LineSpacer
HUDposYLine3 = HUDposYLine2 + LineSpacer
HUDposXColumn1 = HUDposX
HUDposXColumn2 = HUDposXColumn1 + ColumnSpacer
HUDposXColumn3 = HUDposXColumn2 + ColumnSpacer
HUDposXColumn4 = HUDposXColumn3 + ColumnSpacer
HUDposXColumn5 = HUDposXColumn4 + ColumnSpacer
HUDposXColumn6 = HUDposXColumn5 + ColumnSpacer

-------------------------------------------
--             TEXT OBJECTS              --
-------------------------------------------

-- Sets the width of the bg elements
local hud_bg_str = '                                                                        '

-- Create the HUD Background text object
local hud_bg = texts.new(hud_bg_str..'\n'..hud_bg_str..'\n'..hud_bg_str)
hud_bg:font("Consolas")
hud_bg:size(FontSize)
hud_bg:bg_alpha(150)
hud_bg:pos(HUDposXColumn1,HUDposYLine1)
hud_bg:draggable(false)

-- Create the HUD BG Color text object (Nuke Mode)
local hud_bg_color = texts.new(hud_bg_str..'\n'..hud_bg_str..'\n'..hud_bg_str)
hud_bg_color:font('Consolas')
hud_bg_color:size(FontSize)
hud_bg_color:bg_alpha(50)
hud_bg_color:pos(HUDposXColumn1,HUDposYLine1)
hud_bg_color:draggable(false)

-- Create the HUD TP Meter BG1 text object
local hud_tp_meter_bg1 = texts.new('                                    ')
local c = color.AM1
hud_tp_meter_bg1:bg_color(c.r,c.g,c.b)
hud_tp_meter_bg1:font("Consolas")
hud_tp_meter_bg1:size(FontSize)
hud_tp_meter_bg1:bg_alpha(0)
hud_tp_meter_bg1:pos(HUDposXColumn4,HUDposYLine2)
hud_tp_meter_bg1:draggable(false)

-- Create the HUD TP Meter BG2 text object
local hud_tp_meter_bg2 = texts.new('                                    ')
local c = color.AM2
hud_tp_meter_bg2:bg_color(c.r,c.g,c.b)
hud_tp_meter_bg2:font("Consolas")
hud_tp_meter_bg2:size(FontSize)
hud_tp_meter_bg2:bg_alpha(0)
hud_tp_meter_bg2:pos(HUDposXColumn4,HUDposYLine2)
hud_tp_meter_bg2:draggable(false)

-- Create the HUD TP Meter text object
local hud_tp_meter = texts.new()
hud_tp_meter:font("Consolas")
hud_tp_meter:size(FontSize)
hud_tp_meter:bg_alpha(0)
hud_tp_meter:pos(HUDposXColumn4,HUDposYLine2)
hud_tp_meter:draggable(false)

-- Create the HUD Notifications BG text object
local hud_noti_bg = texts.new('                                    ')
hud_noti_bg:font("Consolas")
hud_noti_bg:size(FontSize)
hud_noti_bg:bg_alpha(0)
hud_noti_bg:pos(HUDposXColumn1,HUDposYLine1)
hud_noti_bg:draggable(false)
hud_noti_bg:bold(true)

-- Create the HUD Debuffs BG text object
local hud_debuffs_bg = texts.new('                                    ')
hud_debuffs_bg:font("Consolas")
hud_debuffs_bg:size(FontSize)
hud_debuffs_bg:bg_alpha(0)
hud_debuffs_bg:pos(HUDposXColumn4,HUDposYLine1)
hud_debuffs_bg:draggable(false)
hud_debuffs_bg:bold(true)

-- Create the HUD Abil01 BG text object
local hud_abil01_bg = texts.new('            ')
hud_abil01_bg:font("Consolas")
hud_abil01_bg:size(FontSize)
hud_abil01_bg:pad(-0.5)
hud_abil01_bg:bg_alpha(0)
hud_abil01_bg:pos(HUDposXColumn1+1,HUDposYLine3)
hud_abil01_bg:draggable(false)
hud_abil01_bg:bold(true)

-- Create the HUD Abil02 BG text object
local hud_abil02_bg = texts.new('            ')
hud_abil02_bg:font("Consolas")
hud_abil02_bg:size(FontSize)
hud_abil02_bg:pad(-0.5)
hud_abil02_bg:bg_alpha(0)
hud_abil02_bg:pos(HUDposXColumn2+1,HUDposYLine3)
hud_abil02_bg:draggable(false)
hud_abil02_bg:bold(true)

-- Create the HUD Abil03 BG text object
local hud_abil03_bg = texts.new('            ')
hud_abil03_bg:font("Consolas")
hud_abil03_bg:size(FontSize)
hud_abil03_bg:pad(-0.5)
hud_abil03_bg:bg_alpha(0)
hud_abil03_bg:pos(HUDposXColumn3+1,HUDposYLine3)
hud_abil03_bg:draggable(false)
hud_abil03_bg:bold(true)

-- Create the HUD Abil04 BG text object
local hud_abil04_bg = texts.new('            ')
hud_abil04_bg:font("Consolas")
hud_abil04_bg:size(FontSize)
hud_abil04_bg:pad(-0.5)
hud_abil04_bg:bg_alpha(0)
hud_abil04_bg:pos(HUDposXColumn4+1,HUDposYLine3)
hud_abil04_bg:draggable(false)
hud_abil04_bg:bold(true)

-- Create the HUD Abil05 BG text object
local hud_abil05_bg = texts.new('            ')
hud_abil05_bg:font("Consolas")
hud_abil05_bg:size(FontSize)
hud_abil05_bg:pad(-0.5)
hud_abil05_bg:bg_alpha(0)
hud_abil05_bg:pos(HUDposXColumn5+1,HUDposYLine3)
hud_abil05_bg:draggable(false)
hud_abil05_bg:bold(true)

-- Create the HUD Abil06 BG text object
local hud_abil06_bg = texts.new('            ')
hud_abil06_bg:font("Consolas")
hud_abil06_bg:size(FontSize)
hud_abil06_bg:pad(-0.5)
hud_abil06_bg:bg_alpha(0)
hud_abil06_bg:pos(HUDposXColumn6+1,HUDposYLine3)
hud_abil06_bg:draggable(false)
hud_abil06_bg:bold(true)

-- Create the HUD Weapons Text Shadow text object
local hud_weapons_shdw = texts.new('« Weapons loading... »')
hud_weapons_shdw:color(0,0,0)
hud_weapons_shdw:font("Consolas")
hud_weapons_shdw:size(FontSize)
hud_weapons_shdw:bg_alpha(0)
hud_weapons_shdw:pos(HUDposXColumn4+1.5,HUDposYLine2+0.5)
hud_weapons_shdw:draggable(false)
hud_weapons_shdw:bold(true)

-- Create the HUD Arts Text Shadow text object
local hud_arts_shdw = texts.new()
hud_arts_shdw:color(0,0,0)
hud_arts_shdw:font("Consolas")
hud_arts_shdw:size(FontSize)
hud_arts_shdw:bg_alpha(0)
hud_arts_shdw:pos(HUDposXColumn1+2.5,HUDposYLine2+0.5)
hud_arts_shdw:draggable(false)
hud_arts_shdw:bold(true)

-- Create the HUD Mode Text Shadow text object
local hud_mode_shdw = texts.new()
hud_mode_shdw:color(0,0,0)
hud_mode_shdw:font("Consolas")
hud_mode_shdw:size(FontSize)
hud_mode_shdw:bg_alpha(0)
hud_mode_shdw:pos(HUDposXColumn2+2.5,HUDposYLine2+0.5)
hud_mode_shdw:draggable(false)
hud_mode_shdw:bold(true)

-- Create the HUD Element Text Shadow text object
local hud_element_shdw = texts.new()
hud_element_shdw:color(0,0,0)
hud_element_shdw:font("Consolas")
hud_element_shdw:size(FontSize)
hud_element_shdw:bg_alpha(0)
hud_element_shdw:pos(HUDposXColumn3+2.5,HUDposYLine2+0.5)
hud_element_shdw:draggable(false)
hud_element_shdw:bold(true)

-- Create the HUD Notifications Text Shadow text object
local hud_noti_shdw = texts.new('Keys SCH Gearswap file v'..FileVersion)
hud_noti_shdw:color(0,0,0)
hud_noti_shdw:font("Consolas")
hud_noti_shdw:size(FontSize)
hud_noti_shdw:bg_alpha(0)
hud_noti_shdw:pos(HUDposXColumn1+2.5,HUDposYLine1+0.5)
hud_noti_shdw:draggable(false)
hud_noti_shdw:bold(true)

-- Create the HUD Debuffs Text Shadow text object
local hud_debuffs_shdw = texts.new()
hud_debuffs_shdw:color(0,0,0)
hud_debuffs_shdw:font("Consolas")
hud_debuffs_shdw:size(FontSize)
hud_debuffs_shdw:bg_alpha(0)
hud_debuffs_shdw:pos(HUDposXColumn4+1.5,HUDposYLine1+0.5)
hud_debuffs_shdw:draggable(false)
hud_debuffs_shdw:bold(true)

-- Create the HUD Abil01 Text Shadow text object
local hud_abil01_shdw = texts.new()
hud_abil01_shdw:color(0,0,0)
hud_abil01_shdw:font("Consolas")
hud_abil01_shdw:size(FontSize)
hud_abil01_shdw:bg_alpha(0)
hud_abil01_shdw:pos(HUDposXColumn1+1.5,HUDposYLine3+0.5)
hud_abil01_shdw:draggable(false)
hud_abil01_shdw:bold(true)

-- Create the HUD Abil02 Text Shadow text object
local hud_abil02_shdw = texts.new()
hud_abil02_shdw:color(0,0,0)
hud_abil02_shdw:font("Consolas")
hud_abil02_shdw:size(FontSize)
hud_abil02_shdw:bg_alpha(0)
hud_abil02_shdw:pos(HUDposXColumn2+1.5,HUDposYLine3+0.5)
hud_abil02_shdw:draggable(false)
hud_abil02_shdw:bold(true)

-- Create the HUD Abil03 Text Shadow text object
local hud_abil03_shdw = texts.new()
hud_abil03_shdw:color(0,0,0)
hud_abil03_shdw:font("Consolas")
hud_abil03_shdw:size(FontSize)
hud_abil03_shdw:bg_alpha(0)
hud_abil03_shdw:pos(HUDposXColumn3+1.5,HUDposYLine3+0.5)
hud_abil03_shdw:draggable(false)
hud_abil03_shdw:bold(true)

-- Create the HUD Abil04 Text Shadow text object
local hud_abil04_shdw = texts.new()
hud_abil04_shdw:color(0,0,0)
hud_abil04_shdw:font("Consolas")
hud_abil04_shdw:size(FontSize)
hud_abil04_shdw:bg_alpha(0)
hud_abil04_shdw:pos(HUDposXColumn4+1.5,HUDposYLine3+0.5)
hud_abil04_shdw:draggable(false)
hud_abil04_shdw:bold(true)

-- Create the HUD Abil05 Text Shadow text object
local hud_abil05_shdw = texts.new()
hud_abil05_shdw:color(0,0,0)
hud_abil05_shdw:font("Consolas")
hud_abil05_shdw:size(FontSize)
hud_abil05_shdw:bg_alpha(0)
hud_abil05_shdw:pos(HUDposXColumn5+1.5,HUDposYLine3+0.5)
hud_abil05_shdw:draggable(false)
hud_abil05_shdw:bold(true)

-- Create the HUD Abil06 Text Shadow text object
local hud_abil06_shdw = texts.new()
hud_abil06_shdw:color(0,0,0)
hud_abil06_shdw:font("Consolas")
hud_abil06_shdw:size(FontSize)
hud_abil06_shdw:bg_alpha(0)
hud_abil06_shdw:pos(HUDposXColumn6+1.5,HUDposYLine3+0.5)
hud_abil06_shdw:draggable(false)
hud_abil06_shdw:bold(true)

-- Create the HUD Weapons text object
local hud_weapons = texts.new('« Weapons loading... »')
hud_weapons:font("Consolas")
hud_weapons:size(FontSize)
hud_weapons:bg_alpha(0)
hud_weapons:pos(HUDposXColumn4,HUDposYLine2-1)
hud_weapons:draggable(false)
hud_weapons:bold(true)

-- Create the HUD Arts text object
local hud_arts = texts.new()
hud_arts:font("Consolas")
hud_arts:size(FontSize)
hud_arts:bg_alpha(0)
hud_arts:pos(HUDposXColumn1+1,HUDposYLine2-1)
hud_arts:draggable(false)
hud_arts:bold(true)

-- Create the HUD Mode text object
local hud_mode = texts.new()
hud_mode:font("Consolas")
hud_mode:size(FontSize)
hud_mode:bg_alpha(0)
hud_mode:pos(HUDposXColumn2+1,HUDposYLine2-1)
hud_mode:draggable(false)
hud_mode:bold(true)

-- Create the HUD Element text object
local hud_element = texts.new()
hud_element:font("Consolas")
hud_element:size(FontSize)
hud_element:bg_alpha(0)
hud_element:pos(HUDposXColumn3+1,HUDposYLine2-1)
hud_element:draggable(false)
hud_element:bold(true)

-- Create the HUD Notifications text object
local hud_noti = texts.new('Keys SCH Gearswap file v'..FileVersion)
hud_noti:font("Consolas")
hud_noti:size(FontSize)
hud_noti:bg_alpha(0)
hud_noti:pos(HUDposXColumn1+1,HUDposYLine1-1)
hud_noti:draggable(false)
hud_noti:bold(true)

-- Create the HUD Debuffs text object
local hud_debuffs = texts.new()
hud_debuffs:color(255,50,50)
hud_debuffs:font("Consolas")
hud_debuffs:size(FontSize)
hud_debuffs:bg_alpha(0)
hud_debuffs:pos(HUDposXColumn4,HUDposYLine1-1)
hud_debuffs:draggable(false)
hud_debuffs:bold(true)

-- Create the HUD Abil01 text object
local hud_abil01 = texts.new()
hud_abil01:font("Consolas")
hud_abil01:size(FontSize)
hud_abil01:bg_alpha(0)
hud_abil01:pos(HUDposXColumn1,HUDposYLine3-1)
hud_abil01:draggable(false)
hud_abil01:bold(true)

-- Create the HUD Abil02 text object
local hud_abil02 = texts.new()
hud_abil02:font("Consolas")
hud_abil02:size(FontSize)
hud_abil02:bg_alpha(0)
hud_abil02:pos(HUDposXColumn2,HUDposYLine3-1)
hud_abil02:draggable(false)
hud_abil02:bold(true)

-- Create the HUD Abil03 text object
local hud_abil03 = texts.new()
hud_abil03:font("Consolas")
hud_abil03:size(FontSize)
hud_abil03:bg_alpha(0)
hud_abil03:pos(HUDposXColumn3,HUDposYLine3-1)
hud_abil03:draggable(false)
hud_abil03:bold(true)

-- Create the HUD Abil04 text object
local hud_abil04 = texts.new()
hud_abil04:font("Consolas")
hud_abil04:size(FontSize)
hud_abil04:bg_alpha(0)
hud_abil04:pos(HUDposXColumn4,HUDposYLine3-1)
hud_abil04:draggable(false)
hud_abil04:bold(true)

-- Create the HUD Abil05 text object
local hud_abil05 = texts.new()
hud_abil05:font("Consolas")
hud_abil05:size(FontSize)
hud_abil05:bg_alpha(0)
hud_abil05:pos(HUDposXColumn5,HUDposYLine3-1)
hud_abil05:draggable(false)
hud_abil05:bold(true)

-- Create the HUD Abil06 text object
local hud_abil06 = texts.new()
hud_abil06:font("Consolas")
hud_abil06:size(FontSize)
hud_abil06:bg_alpha(0)
hud_abil06:pos(HUDposXColumn6,HUDposYLine3-1)
hud_abil06:draggable(false)
hud_abil06:bold(true)

if ShowHUD then
	hud_bg_color:show()
	hud_bg:show()
	if ShowTPMeter then
		hud_tp_meter_bg1:show()
		hud_tp_meter_bg2:show()
		hud_tp_meter:show()
	end
	hud_noti_bg:show()
	hud_debuffs_bg:show()
	hud_abil01_bg:show()
	hud_abil02_bg:show()
	hud_abil03_bg:show()
	hud_abil04_bg:show()
	hud_abil05_bg:show()
	hud_abil06_bg:show()
	hud_weapons_shdw:show()
	hud_arts_shdw:show()
	hud_mode_shdw:show()
	hud_element_shdw:show()
	hud_noti_shdw:show()
	hud_debuffs_shdw:show()
	hud_abil01_shdw:show()
	hud_abil02_shdw:show()
	hud_abil03_shdw:show()
	hud_abil04_shdw:show()
	hud_abil05_shdw:show()
	hud_abil06_shdw:show()
	hud_weapons:show()
	hud_arts:show()
	hud_mode:show()
	hud_element:show()
	hud_noti:show()
	hud_debuffs:show()
	hud_abil01:show()
	hud_abil02:show()
	hud_abil03:show()
	hud_abil04:show()
	hud_abil05:show()
	hud_abil06:show()
end

-------------------------------------------
--            CUSTOM ALIASES             --
-------------------------------------------

send_command('alias mode gs c Mode') --creates the Nuke Mode alias
send_command('alias dt gs c DT') --creates the Danger Mode and alias
send_command('alias hud gs c HUD') --creates the HUD alias
send_command('bind '..NMBind..' gs c Mode') --creates the Nuke Mode keyboard shortcut
send_command('bind '..DMBind..' gs c DT') --creates the Danger Mode keyboard shortcut
send_command('bind '..Tier1Bind..' gs c Tier1')
send_command('bind '..Tier2Bind..' gs c Tier2')
send_command('bind '..Tier3Bind..' gs c Tier3')
send_command('bind '..Tier4Bind..' gs c Tier4')
send_command('bind '..Tier5Bind..' gs c Tier5')
send_command('bind '..StormIIBind..' gs c StormII')
send_command('bind '..HelixIBind..' gs c HelixI')
send_command('bind '..HelixIIBind..' gs c HelixII')

-------------------------------------------
--           CUSTOM FUNCTIONS            --
-------------------------------------------

-- Add commas to numbers to make them easier to read
local function addCommas(number)
	-- Convert the number to a string
	local formattedNumber = tostring(number)

	if AddCommas then
		local length = #formattedNumber

		if length > 3 then
			local insertIndex = length % 3
			if insertIndex == 0 then
				insertIndex = 3
			end

			while insertIndex < length do
				formattedNumber = formattedNumber:sub(1, insertIndex)..","..formattedNumber:sub(insertIndex + 1)
				insertIndex = insertIndex + 4
				length = length + 1
			end
		end
	end

	-- Return the number (albeit as a string, we're not doing any math on it at this point)
	return formattedNumber
end
--Color the appropriate Ability/spell recast
local function textColor(abil,state)

	local c = color.abil[state]

	if sub[subjob].Abil01 == abil then
		hud_abil01:color(c.r,c.g,c.b)

	elseif sub[subjob].Abil02 == abil then
		hud_abil02:color(c.r,c.g,c.b)

	elseif sub[subjob].Abil03 == abil then
		hud_abil03:color(c.r,c.g,c.b)

	elseif sub[subjob].Abil04 == abil then
		hud_abil04:color(c.r,c.g,c.b)

	elseif sub[subjob].Abil05 == abil then
		hud_abil05:color(c.r,c.g,c.b)

	elseif sub[subjob].Abil06 == abil then
		hud_abil06:color(c.r,c.g,c.b)

	end
end

--Flash a specific text area
local function flash(area)

	if sub[subjob].Abil01 == area then
		send_command('gs c Flash_Abil01_A;wait .25;gs c Flash_Abil01_B;wait .25;gs c Flash_Abil01_A;wait .25;gs c Flash_Abil01_B;wait .25;gs c Flash_Abil01_A;wait .25;gs c Flash_Abil01_B;wait .25;gs c Flash_Abil01_A;wait .25;gs c Flash_Abil01_B')

	elseif sub[subjob].Abil02 == area then
		send_command('gs c Flash_Abil02_A;wait .25;gs c Flash_Abil02_B;wait .25;gs c Flash_Abil02_A;wait .25;gs c Flash_Abil02_B;wait .25;gs c Flash_Abil02_A;wait .25;gs c Flash_Abil02_B;wait .25;gs c Flash_Abil02_A;wait .25;gs c Flash_Abil02_B')

	elseif sub[subjob].Abil03 == area then
		send_command('gs c Flash_Abil03_A;wait .25;gs c Flash_Abil03_B;wait .25;gs c Flash_Abil03_A;wait .25;gs c Flash_Abil03_B;wait .25;gs c Flash_Abil03_A;wait .25;gs c Flash_Abil03_B;wait .25;gs c Flash_Abil03_A;wait .25;gs c Flash_Abil03_B')

	elseif sub[subjob].Abil04 == area then
		send_command('gs c Flash_Abil04_A;wait .25;gs c Flash_Abil04_B;wait .25;gs c Flash_Abil04_A;wait .25;gs c Flash_Abil04_B;wait .25;gs c Flash_Abil04_A;wait .25;gs c Flash_Abil04_B;wait .25;gs c Flash_Abil04_A;wait .25;gs c Flash_Abil04_B')

	elseif sub[subjob].Abil05 == area then
		send_command('gs c Flash_Abil05_A;wait .25;gs c Flash_Abil05_B;wait .25;gs c Flash_Abil05_A;wait .25;gs c Flash_Abil05_B;wait .25;gs c Flash_Abil05_A;wait .25;gs c Flash_Abil05_B;wait .25;gs c Flash_Abil05_A;wait .25;gs c Flash_Abil05_B')

	elseif sub[subjob].Abil06 == area then
		send_command('gs c Flash_Abil06_A;wait .25;gs c Flash_Abil06_B;wait .25;gs c Flash_Abil06_A;wait .25;gs c Flash_Abil06_B;wait .25;gs c Flash_Abil06_A;wait .25;gs c Flash_Abil06_B;wait .25;gs c Flash_Abil06_A;wait .25;gs c Flash_Abil06_B')

	elseif area == 'Noti' then
		send_command('gs c Flash_Noti_A;wait .25;gs c Flash_Noti_B;wait .25;gs c Flash_Noti_A;wait .25;gs c Flash_Noti_B')

	elseif area == 'Debuffs' then
		send_command('gs c Flash_Debuffs_A;wait .25;gs c Flash_Debuffs_B;wait .25;gs c Flash_Debuffs_A;wait .25;gs c Flash_Debuffs_B')

	end
end

local function getRecasts()

	local ability_recast = windower.ffxi.get_ability_recasts()

	TabulaRasa.recast = ability_recast[0] and math.ceil(ability_recast[0])
	CaperEmissarius.recast = ability_recast[254] and math.ceil(ability_recast[254]) or 0
	Convert.recast = ability_recast[49] and math.ceil(ability_recast[49])
	DarkArts.recast = ability_recast[232] and math.ceil(ability_recast[232])
	DivineSeal.recast = ability_recast[26] and math.ceil(ability_recast[26])
	Enlightenment.recast = ability_recast[235] and math.ceil(ability_recast[235])
	Libra.recast = ability_recast[237] and math.ceil(ability_recast[237])
	LightArts.recast = ability_recast[228] and math.ceil(ability_recast[228])
	ModusVeritas.recast = ability_recast[230] and math.ceil(ability_recast[230])
	Stratagems.recast = ability_recast[231] and math.ceil(ability_recast[231])
	Sublimation.recast = ability_recast[234] and math.ceil(ability_recast[234])

end

getRecasts()

-- Format abilities/spells to fit into their allotted 12 spaces
local function formatAbils(input,input_sh)

	-- Valid abilities/spells
	local validAbilities = {
		"Tabula Rasa", "Caper Emissarius", "Convert", "Dark Arts", "Divine Seal", "Enlightenment", "Libra", "Light Arts", "Modus Veritas", "Stratagems", "Sublimation"
	}

	local ab = {} ab['Tabula Rasa'] = TabulaRasa ab['Caper Emissarius'] = CaperEmissarius ab['Convert'] = Convert ab['Dark Arts'] = DarkArts ab['Divine Seal'] = DivineSeal ab['Enlightenment'] = Enlightenment ab['Libra'] = Libra ab['Light Arts'] = LightArts ab['Modus Veritas'] = ModusVeritas ab['Stratagems'] = Stratagems ab['Sublimation'] = Sublimation
	
	-- Check if the input matches any of the valid abilities/spells
	for _, ability in ipairs(validAbilities) do

		if input == ability then

			local recast = ab[ability].recast or 0

			-- Are we using the ability/spell name itself, or a shorthand supplied in the Options?
			local startingString = input_sh == '' and input or input_sh

			-- Adjust for Sublimation
			if input == 'Sublimation' and buffactive['Sublimation: Activated'] then
				startingString = 'Charging'
			elseif input == 'Sublimation' and buffactive['Sublimation: Complete'] then
				startingString = 'Filled'
			end

			-- Maximum length of output without brackets
			local maxLength = 10

			-- Function to format the output string
			local function formatOutputString(baseString, truncateLength)
				local truncatedString = string.sub(baseString, 1, truncateLength)
				return truncatedString
			end

			-- Get our output before we apply the brackets below
			local formattedString = ''
			if input == 'Stratagems' then

				local charges_lost = math.ceil(recast / strat_charge_timer)
				strat_charges = math.max(0, max_charges - charges_lost)

				-- To Next Charge
				local tnc = recast > strat_charge_timer and recast % strat_charge_timer or recast

				if strat_charges == max_charges then
					formattedString = formatOutputString(startingString, maxLength - 2)..'|'..max_charges
				else
					local padding = (tnc > 9) and 5 or 4
					formattedString = formatOutputString(startingString, maxLength - padding)..':'..tnc..'|'..strat_charges
				end

			elseif recast > 3600 then
				local hr = math.floor(recast / 3600)
				formattedString = formatOutputString(startingString, maxLength - 3)..':'..hr..'h'
			elseif recast > 600 then
				local min = math.floor(recast / 60)
				formattedString = formatOutputString(startingString, maxLength - 4)..':'..min..'m'
			elseif recast > 60 then
				local min = math.floor(recast / 60)
				formattedString = formatOutputString(startingString, maxLength - 3)..':'..min..'m'
			elseif recast > 9 then
				formattedString = formatOutputString(startingString, maxLength - 3)..':'..recast
			elseif recast > 0 then
				formattedString = formatOutputString(startingString, maxLength - 2)..':'..recast
			else
				formattedString = string.sub(startingString, 1, maxLength)
			end

			-- Determine padding needed to center the output
			local paddingTotalLength = maxLength - #formattedString
			local leftPaddingLength = math.floor(paddingTotalLength / 2)
			local leftPadding = string.rep(" ", leftPaddingLength)
			local rightPaddingLength = paddingTotalLength - leftPaddingLength
			local rightPadding = string.rep(" ", rightPaddingLength)				

			-- Determine recast coloring for brackets
			local c = recast == 0 and color.abil.active or color.abil.ready
			if input == "Stratagems" then
				if strat_charges > 0 then
					c = color.abil.active
				else
					c = color.abil.ready
				end
			end

			-- Apply brackets with recast coloring
			formattedString = leftPadding..'\\cs('..c.r..','..c.g..','..c.b..')[\\cr'..formattedString..'\\cs('..c.r..','..c.g..','..c.b..')]\\cr'..rightPadding

			return formattedString

		end
	end

	-- If input doesn't match any valid ability/spell, return "UNKNOWN"
	return " [UNKNOWN]  "

end

-- Format Notifications/Debuffs to be centered in their allotted 36 spaces
local function format36(input)

	local maxLength = 40 --add 4 since the 4 « characters count as 2 each
	local paddingTotalLength = maxLength - #input

	-- Determine the number of left and right spaces in order to center the formatted string
	local leftPaddingLength = math.floor(paddingTotalLength / 2)
	local leftPadding = string.rep(" ", leftPaddingLength)
	local rightPaddingLength = paddingTotalLength - leftPaddingLength
	local rightPadding = string.rep(" ", rightPaddingLength)

	-- Construct the centered formatted string
	local centeredString = leftPadding..input..rightPadding

	return centeredString

end

-- Format Arts/Mode/Element to be centered in their allotted 12 spaces
local function format12(input)

	local maxLength = 12
	local paddingTotalLength = maxLength - #input

	-- Determine the number of left and right spaces in order to center the formatted string
	local leftPaddingLength = math.floor(paddingTotalLength / 2)
	local leftPadding = string.rep(" ", leftPaddingLength)
	local rightPaddingLength = paddingTotalLength - leftPaddingLength
	local rightPadding = string.rep(" ", rightPaddingLength)

	-- Construct the centered formatted string
	local centeredString = leftPadding..input..rightPadding

	return centeredString

end

-- Format Weapons to be centered and allotted in their 36 spaces
local function formatWeapons(input)

	local maxLength = 38
	local truncatedLength = maxLength - 4 --subtracting 4 to account for the « » (that each count as 2)
	local truncatedString = string.sub(input, 1, truncatedLength) -- Truncate input if too long
	local formattedString = '«'..truncatedString..'»'
	local formattedLength = #formattedString
	local paddingTotalLength = maxLength - formattedLength

	-- Determine the number of left and right spaces in order to center the formatted string
	local leftPaddingLength = math.floor(paddingTotalLength / 2)
	local leftPadding = string.rep(" ", leftPaddingLength)
	local rightPaddingLength = paddingTotalLength - leftPaddingLength
	local rightPadding = string.rep(" ", rightPaddingLength)

	-- Construct the centered formatted string
	local centeredString = leftPadding..formattedString..rightPadding

	return centeredString

end

local function getHUDAbils()

	local abil01 = formatAbils(sub[subjob].Abil01,sub[subjob].Abil01_sh)
	local abil02 = formatAbils(sub[subjob].Abil02,sub[subjob].Abil02_sh)
	local abil03 = formatAbils(sub[subjob].Abil03,sub[subjob].Abil03_sh)
	local abil04 = formatAbils(sub[subjob].Abil04,sub[subjob].Abil04_sh)
	local abil05 = formatAbils(sub[subjob].Abil05,sub[subjob].Abil05_sh)
	local abil06 = formatAbils(sub[subjob].Abil06,sub[subjob].Abil06_sh)

	hud_abil01_shdw:text(abil01:text_strip_format())
	hud_abil02_shdw:text(abil02:text_strip_format())
	hud_abil03_shdw:text(abil03:text_strip_format())
	hud_abil04_shdw:text(abil04:text_strip_format())
	hud_abil05_shdw:text(abil05:text_strip_format())
	hud_abil06_shdw:text(abil06:text_strip_format())

	hud_abil01:text(abil01)
	hud_abil02:text(abil02)
	hud_abil03:text(abil03)
	hud_abil04:text(abil04)
	hud_abil05:text(abil05)
	hud_abil06:text(abil06)

end

getHUDAbils()

local function formatAMTime(input)

	local am_time_minute = math.floor(input/60)
	local am_time_second = input - (math.floor(input/60)*60)
	am_time_second = string.format("%02d", am_time_second)
	return am_time_minute..':'..am_time_second

end

local function getStratChargeTimer()
	local player = windower.ffxi.get_player()
	local level = player.main_job_level
	local JP = player.job_points.sch.jp_spent
	if level >= 90 then
		strat_charge_timer = JP >= 550 and 33 or 48
	elseif level >= 70 then
		strat_charge_timer = 60
	elseif level >= 50 then
		strat_charge_timer = 80
	elseif level >= 30 then
		strat_charge_timer = 120
	elseif level >= 10 then
		strat_charge_timer = 240
	end

	max_charges = strat_charge_timer == 33 and 5 or (240 / strat_charge_timer)
	strat_flash_counter = max_charges

end
getStratChargeTimer()

local function itemMatch(item_num)
	local items = windower.ffxi.get_items()
	local locations = {"inventory", "wardrobe", "wardrobe2", "wardrobe3", "wardrobe4", "wardrobe5", "wardrobe6", "wardrobe7", "wardrobe8"}
	for _, location in ipairs(locations) do
		local weapon_id = items[location][items.equipment.main].id
		if weapon_id == item_num then
			return true --match found
		end
	end
	return false --no match found
end

local function getMainWeaponID()

	local get_items = windower.ffxi.get_items()
	local bag = get_items.equipment.main_bag
	local index = get_items.equipment.main
	local item_id = windower.ffxi.get_items(bag, index).id

	return item_id

end

local function empyreanAMUpdate(tp)

	local weapon_id = getMainWeaponID()
	local afterglow = weapon_id == 22064

	if tp >= 3000 then
		pre_AMTimer = afterglow and 180 or 90
		return
	end

	local tier = math.floor(tp / 1000)
	local timers = afterglow and {60,120} or {30,60}

	pre_AMTimer = timers[tier]

end

local function empyreanAMUpdate(tp)

	local weapon_id = getMainWeaponID()
	local afterglow = weapon_id == 22064

	if tp >= 3000 then
		pre_AMTimer = afterglow and 180 or 90
		return
	end

	local tier = math.floor(tp / 1000)
	local timers = afterglow and {60,120} or {30,60}

	pre_AMTimer = timers[tier]

end

local function mythicAMUpdate(tp)

	local weapon_id = getMainWeaponID()
	local lvl75 = weapon_id == 18970 or weapon_id == 18990
	local lvl80_90 = weapon_id == 19079 or weapon_id == 19099 or weapon_id == 19631

	if tp >= 1000 and tp < 2000 then
		if lvl75 then
			pre_mythicNum = math.floor(tp / 100) -- 10-19
		elseif lvl80_90 then
			pre_mythicNum = math.floor((tp * 3) / 200) --15-29
		else
			pre_mythicNum = math.floor((tp / 50) + 10) --30-49
		end
		pre_AMTimer = lvl75 and 180 or 270

	elseif tp >= 2000 and tp < 3000 then
		if lvl75 then
			pre_mythicNum = math.floor((tp / 100) - 10) --10-19
		elseif lvl80_90 then
			pre_mythicNum = math.floor((tp / 50) - 20) --20-39
		else
			pre_mythicNum = math.floor((tp / 50) - 10) --30-49
		end
		pre_AMTimer = lvl75 and 180 or 270

	elseif tp == 3000 then
		pre_AMTimer = lvl75 and 120 or 180

	end

end

local function primeAMUpdate(tp)

	local weapon_id = getMainWeaponID()

	local base_numbers = {
		[22104] = 5,  -- Stage 3
		[22105] = 10, -- Stage 4
		[22106] = 15, -- Stage 5
	}

	local base = base_numbers[weapon_id]
	if not base or tp < 1000 then return end

	local tp_steps = {

		--Aftermath 1
		{tp=1000, offset=0,  timer=60},
		{tp=1100, offset=1,  timer=60},
		{tp=1200, offset=2,  timer=60},
		{tp=1300, offset=3,  timer=60},
		{tp=1400, offset=4,  timer=60},
		{tp=1500, offset=5,  timer=60},
		{tp=1600, offset=6,  timer=60},
		{tp=1700, offset=7,  timer=60},
		{tp=1800, offset=8,  timer=60},
		{tp=1900, offset=9,  timer=60},

		--Aftermath 2
		{tp=2000, offset=10, timer=120},
		{tp=2067, offset=11, timer=120},
		{tp=2133, offset=12, timer=120},
		{tp=2200, offset=13, timer=120},
		{tp=2267, offset=14, timer=120},
		{tp=2333, offset=15, timer=120},
		{tp=2400, offset=16, timer=120},
		{tp=2467, offset=17, timer=120},
		{tp=2533, offset=18, timer=120},
		{tp=2600, offset=19, timer=120},
		{tp=2667, offset=20, timer=120},
		{tp=2733, offset=21, timer=120},
		{tp=2800, offset=22, timer=120},
		{tp=2867, offset=23, timer=120},
		{tp=2933, offset=24, timer=120},
	}

	--Aftermath 3
	if tp == 3000 then
		pre_primeNum = base + 25
		pre_AMTimer = 180
		return
	end

	--Find highest matching TP (goes bottom-up)
	for i = #tp_steps, 1, -1 do
		local step = tp_steps[i]
		if tp >= step.tp then
			pre_primeNum = base + step.offset
			pre_AMTimer = step.timer
			return
		end
	end

end

local function useHachirinNoObi(nuke_element)
	local opposites = {
		Fire = "Water",
		Water = "Lightning",
		Lightning = "Earth",
		Earth = "Wind",
		Wind = "Ice",
		Ice = "Fire",
		Light = "Dark",
		Dark = "Light",
	}

	local day = world.day_element
	local weather = world.weather_element
	local weather_intensity = world.weather_intensity

	local bonus = 0
	local penalty = 0

	--Positive bonuses
	if day == nuke_element then
		bonus = bonus + 10
	end
	if weather == nuke_element then
		bonus = bonus + (weather_intensity == 2 and 25 or 10)
	end

	--Negative penalties from opposing element
	local oppose = opposites[nuke_element]
	if day == oppose then
		penalty = penalty + 10
	end
	if weather == oppose then
		penalty = penalty + (weather_intensity == 2 and 25 or 10)
	end

	--Use Obi only if the total bonus outweighs the penalty
	return bonus > penalty
end

local function setNotification()

	if GreetingDelay ~= -1 then return end

	if TownZones[world.area] or windower.ffxi.get_info().mog_house then
		hud_noti_shdw:text(player.name..': '..player.main_job..player.main_job_level..'/'..(player.sub_job_level and player.sub_job..player.sub_job_level or "---"))
		hud_noti:text(player.name..': '..player.main_job..player.main_job_level..'/'..(player.sub_job_level and player.sub_job..player.sub_job_level or "---"))
		hud_noti:color(255,255,255)
	elseif buffactive['Sneak'] and buffactive['Invisible'] then
		hud_noti_shdw:text('Status: Sneak & Invisible')
		hud_noti:text('Status: Sneak & Invisible')
		hud_noti:color(50,205,50)
	elseif buffactive['Sneak'] then
		hud_noti_shdw:text('Status: Sneak')
		hud_noti:text('Status: Sneak')
		hud_noti:color(50,205,50)
	elseif buffactive['Invisible'] then
		hud_noti_shdw:text('Status: Invisible')
		hud_noti:text('Status: Invisible')
		hud_noti:color(50,205,50)
	elseif LowHP then
		hud_noti_shdw:text('«« Low HP »»')
		hud_noti:text('«« Low HP »»')
		hud_noti:color(255,50,50)
	elseif buffactive['weakness'] then
		hud_noti_shdw:text('Status: Weakness')
		hud_noti:text('Status: Weakness')
		hud_noti:color(205,133,63)
	elseif player.mpp <= 20 then
		hud_noti_shdw:text('«« Low MP »»')
		hud_noti:text('«« Low MP »»')
		hud_noti:color(255,50,50)
	else
		local status = player.status
		hud_noti_shdw:text('Status: '..status)
		hud_noti:text('Status: '..status)
		local c = color.danger_mode[DangerMode]
		hud_noti:color(c.r,c.g,c.b)
	end

end

--Are we in a party or alliance with other players (trusts do not count)
local function playerIsInAPartyOrAlliance()
	local get_party = windower.ffxi.get_party()
	if get_party.party2_count > 0 or get_party.party3_count > 0 then return true end
	if get_party.party1_count == 1 then return false end
	for i = 0, get_party.party1_count-1 do
		local member = windower.ffxi.get_mob_by_target('p'..i)
		if member and not member.is_npc then
			return true
		end
	end
	return false
end

--Is the actor a monster?
local function isMonster(id)
	local actor = windower.ffxi.get_mob_by_id(id)
	return actor and actor.spawn_type == 16 and not actor.in_party
end

--Is this player in our party or alliance?
local function isInOurPartyOrAlliance(id)
	local actor = windower.ffxi.get_mob_by_id(id)
	local positions = {
		'p0', 'p1', 'p2', 'p3', 'p4', 'p5',
		'a10', 'a11', 'a12', 'a13', 'a14', 'a15',
		'a20', 'a21', 'a22', 'a23', 'a24', 'a25'
	}
	for _, position in ipairs(positions) do
		local member = windower.ffxi.get_mob_by_target(position)
		if member and member.id == id or (member and actor and member.pet_index == actor.index) then
			return true --In our party or alliance
		end
	end
	return false --Not in our party or alliance
end

local function artsCheck()
	local text = format12("No Arts")
	local c = color.None
	local bg_c = {r = 0, g = 0, b = 0}
	if buffactive['Light Arts'] then
		text = format12("Light Arts")
		c = color.art.light
		bg_c = color.art.light
	elseif buffactive['Addendum: White'] then
		text = format12("Add: White")
		c =color.art.white
		bg_c =color.art.white
	elseif buffactive['Dark Arts'] then
		text = format12("Dark Arts")
		c = color.art.dark
		bg_c = color.art.dark
	elseif buffactive['Addendum: Black'] then
		text = format12("Add: Black")
		c = color.art.black
		bg_c = color.art.black
	end
	hud_arts:text(text)
	hud_arts_shdw:text(text)
	hud_arts:color(c.r,c.g,c.b)
	hud_bg_color:bg_color(bg_c.r,bg_c.g,bg_c.b)
end

local function modeCheck()
	local text = format12(mode_names[Mode])
	local c = Mode == 1 and color.mode.damage or color.mode.occult
	hud_mode:text(text)
	hud_mode_shdw:text(text)
	hud_mode:color(c.r,c.g,c.b)
end

-------------------------------------------
--            SELF COMMANDS              --
-------------------------------------------

function self_command(command)
	if command == 'Mode' then
		Mode = Mode == 1 and 2 or 1
		modeCheck()
	elseif command == 'DT' then
		if DangerMode == 'Auto' then
			DangerMode = 'On'
		elseif DangerMode == 'On' then
			DangerMode = 'Off'
		elseif DangerMode == 'Off' then
			DangerMode = 'Auto'
		end
		hud_noti_shdw:text('Danger Mode set to '..DangerMode)
		hud_noti:text('Danger Mode set to '..DangerMode)
		NotiCountdown = NotiDelay
		choose_set()
	elseif command == 'Off' or command == 'Light' or command == 'Dark' or command == 'Fire' or command == 'Stone' or command == 'Water' or command == 'Aero' or command == 'Blizzard' or command == 'Thunder' then
		Element = command
	elseif command == "Cycle" or command == "CycleF" or command == "CycleB" then
		local elements = {"Light", "Dark", "Fire", "Stone", "Water", "Aero", "Blizzard", "Thunder"}
		local num
		--Get our current Element
		for i = 1, #elements do
			if elements[i] == Element then
				num = i
				break
			end
		end
		--Cycle it backward or forward (and loop around)
		if command == "CycleB" then
			num = (num - 2) % #elements + 1
		else
			num = num % #elements + 1
		end
		Element = elements[num]
	elseif command == "Tier1" or command == "Tier2" or command == "Tier3" or command == "Tier4" or command == "Tier5" or command == "StormII" or command == "HelixI" or command == "HelixII" then
		local spell = spell_map[command][Element]
		if spell then
			local target = spell_map.targets[spell] and spell_map.targets[spell] or (spell_map.targets["Default"] and spell_map.targets["Default"] or "<st>")
			send_command('input /ma "'..spell..'" '..target)
		end
	elseif command == 'ClearNotifications' then --these reset the Notifications display back to a basic state
		setNotification()
	elseif command == 'ClearDebuffs' then --these reset the Debuffs display back to a basic state
		hud_debuffs_shdw:text('')
		hud_debuffs:text('')
		hud_debuffs:color(255,255,255)
	elseif command == 'Zone Gear' then
		if ZoneGear == 'Town' then
			if TownZones[world.area] or windower.ffxi.get_info().mog_house then
				send_command('wait 5;gs c Choose Set')
			end
		else
			send_command('wait 5;gs c Choose Set')
		end
	elseif command == 'Choose Set' then
		choose_set()
	elseif command == 'Radialens' then
		--we put this wait in to check what zone we're in when the Radialens wears so that it doesn't trigger when we're simply zoning out of an Escha zone
		send_command('wait 4;gs c RadialensCheck')
	elseif command == 'RadialensCheck' and string.find(world.area,'Escha') then
		if AlertSounds then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Radialens Has Worn Off »»')
		hud_noti:text('«« Radialens Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif command == 'NotiLowMPToggle' then
		NotiLowMPToggle = false
	elseif command == 'AliveDelay' then
		Alive = true --putting this in a command lets us set a small delay to prevent things from triggering right when we raise up
	elseif command == 'HUD' and not ShowHUD then
		ShowHUD = true
		windower.send_command('gs c ShowHUD')
	elseif command == 'HUD' and ShowHUD then
		ShowHUD = false
		windower.send_command('gs c HideHUD')
	elseif command == 'ShowHUD' then
		hud_bg_color:show()
		hud_bg:show()
		if ShowTPMeter then
			hud_tp_meter_bg1:show()
			hud_tp_meter_bg2:show()
			hud_tp_meter:show()
		end
		hud_noti_bg:show()
		hud_debuffs_bg:show()
		hud_abil01_bg:show()
		hud_abil02_bg:show()
		hud_abil03_bg:show()
		hud_abil04_bg:show()
		hud_abil05_bg:show()
		hud_abil06_bg:show()
		hud_weapons_shdw:show()
		hud_arts_shdw:show()
		hud_mode_shdw:show()
		hud_element_shdw:show()
		hud_noti_shdw:show()
		hud_debuffs_shdw:show()
		hud_abil01_shdw:show()
		hud_abil02_shdw:show()
		hud_abil03_shdw:show()
		hud_abil04_shdw:show()
		hud_abil05_shdw:show()
		hud_abil06_shdw:show()
		hud_weapons:show()
		hud_arts:show()
		hud_mode:show()
		hud_element:show()
		hud_noti:show()
		hud_debuffs:show()
		hud_abil01:show()
		hud_abil02:show()
		hud_abil03:show()
		hud_abil04:show()
		hud_abil05:show()
		hud_abil06:show()
	elseif command == 'HideHUD' then
		hud_bg_color:hide()
		hud_bg:hide()
		hud_tp_meter_bg1:hide()
		hud_tp_meter_bg2:hide()
		hud_tp_meter:hide()
		hud_noti_bg:hide()
		hud_debuffs_bg:hide()
		hud_abil01_bg:hide()
		hud_abil02_bg:hide()
		hud_abil03_bg:hide()
		hud_abil04_bg:hide()
		hud_abil05_bg:hide()
		hud_abil06_bg:hide()
		hud_weapons_shdw:hide()
		hud_arts_shdw:hide()
		hud_mode_shdw:hide()
		hud_element_shdw:hide()
		hud_noti_shdw:hide()
		hud_debuffs_shdw:hide()
		hud_abil01_shdw:hide()
		hud_abil02_shdw:hide()
		hud_abil03_shdw:hide()
		hud_abil04_shdw:hide()
		hud_abil05_shdw:hide()
		hud_abil06_shdw:hide()
		hud_weapons:hide()
		hud_arts:hide()
		hud_mode:hide()
		hud_element:hide()
		hud_noti:hide()
		hud_debuffs:hide()
		hud_abil01:hide()
		hud_abil02:hide()
		hud_abil03:hide()
		hud_abil04:hide()
		hud_abil05:hide()
		hud_abil06:hide()
	elseif command == 'Flash_Abil01_A' then
		hud_abil01_bg:bg_alpha(50)
		local c = color.abil.flash
		hud_abil01_bg:bg_color(c.r,c.g,c.b)
	elseif command == 'Flash_Abil01_B' then
		hud_abil01_bg:bg_alpha(0)
	elseif command == 'Flash_Abil02_A' then
		hud_abil02_bg:bg_alpha(50)
		local c = color.abil.flash
		hud_abil02_bg:bg_color(c.r,c.g,c.b)
	elseif command == 'Flash_Abil02_B' then
		hud_abil02_bg:bg_alpha(0)
	elseif command == 'Flash_Abil03_A' then
		hud_abil03_bg:bg_alpha(50)
		local c = color.abil.flash
		hud_abil03_bg:bg_color(c.r,c.g,c.b)
	elseif command == 'Flash_Abil03_B' then
		hud_abil03_bg:bg_alpha(0)
	elseif command == 'Flash_Abil04_A' then
		hud_abil04_bg:bg_alpha(50)
		local c = color.abil.flash
		hud_abil04_bg:bg_color(c.r,c.g,c.b)
	elseif command == 'Flash_Abil04_B' then
		hud_abil04_bg:bg_alpha(0)
	elseif command == 'Flash_Abil05_A' then
		hud_abil05_bg:bg_alpha(50)
		local c = color.abil.flash
		hud_abil05_bg:bg_color(c.r,c.g,c.b)
	elseif command == 'Flash_Abil05_B' then
		hud_abil05_bg:bg_alpha(0)
	elseif command == 'Flash_Abil06_A' then
		hud_abil06_bg:bg_alpha(50)
		local c = color.abil.flash
		hud_abil06_bg:bg_color(c.r,c.g,c.b)
	elseif command == 'Flash_Abil06_B' then
		hud_abil06_bg:bg_alpha(0)
	elseif command == 'Flash_Noti_A' then
		hud_noti_bg:bg_alpha(50)
		local c = color.abil.flash
		hud_noti_bg:bg_color(c.r,c.g,c.b)
	elseif command == 'Flash_Noti_B' then
		hud_noti_bg:bg_alpha(0)
	elseif command == 'Flash_Debuffs_A' then
		hud_debuffs_bg:bg_alpha(50)
		local c = color.abil.flash
		hud_debuffs_bg:bg_color(c.r,c.g,c.b)
	elseif command == 'Flash_Debuffs_B' then
		hud_debuffs_bg:bg_alpha(0)
	elseif command == "double_sublimation_fix" then
		double_sublimation_fix = false
	elseif command == 'light' then
		if buffactive['Light Arts'] then
			send_command('input /ja "Addendum: White" <me>')
		elseif not buffactive['Addendum: White'] then
			send_command('input /ja "Light Arts" <me>')
		end
	elseif command == 'dark' then
		if buffactive['Dark Arts'] then
			send_command('input /ja "Addendum: Black" <me>')
		elseif not buffactive['Addendum: Black'] then
			send_command('input /ja "Dark Arts" <me>')
		end
	elseif "open_auto_valve" then
		auto_valve_open = true
	elseif command == "resetCapturedToggle" then
		captured_spell_toggle = false
	end
end

-------------------------------------------
--              CHOOSE SET               --
-------------------------------------------

function choose_set(sublimation_activation)

	local light_arts = (buffactive['Light Arts'] or buffactive['Addendum: White']) and sets.idle.light_arts or nil
	local dark_arts = (buffactive['Dark Arts'] or buffactive['Addendum: Black']) and sets.idle.dark_arts or nil
	local sublimation = (buffactive['Sublimation: Activated'] or sublimation_activation) and sets.idle.sublimation or nil
	local rest = player.status == "Resting" and sets.rest or nil
	local full_mp = player.mpp > FullMpPercent and sets.idle.full_mp or nil
	local melee = player.status == 'Engaged' and sets.melee or nil
	local danger = (LowHP or DangerMode == 'On' or (DangerMode == "Auto" and TakingDamage aand not melee)) and sets.danger or nil

	if player.status == "Idle" then
		if AdoulinZones[world.area] then
			equip(set_combine(sets.adoulin, sublimation, sets.movement_speed))
		elseif BastokZones[world.area] then
			equip(set_combine(sets.bastok, sublimation, sets.movement_speed))
		elseif SandyZones[world.area] then
			equip(set_combine(sets.sandoria, sublimation, sets.movement_speed))
		elseif WindyZones[world.area] then
			equip(set_combine(sets.windurst, sublimation, sets.movement_speed))
		elseif TownZones[world.area] or windower.ffxi.get_info().mog_house then
			equip(set_combine(sets.town, sublimation, sets.movement_speed))
		else
			equip(set_combine(sets.idle, light_arts, dark_arts, sublimation, full_mp, danger))
		end
	else
		local get_player = windower.ffxi.get_player()
		local autorun = get_player and get_player.autorun
		local auto_movement_speed = AutoMvmntSpeed and moving
		local movement_speed = (auto_movement_speed or autorun) and sets.movement_speed or nil
		equip(set_combine(sets.idle, light_arts, dark_arts, sublimation, rest, full_mp, melee, danger, movement_speed))
	end

end

-------------------------------------------
--               PRECAST                 --
-------------------------------------------

function precast(spell)

	local prefixes = {
		["/magic"] = true,
		["/song"] = true,
		["/ninjutsu"] = true,
		['/trust'] = true,
		['/item'] = true,
		['/range'] = true,
	}
	if MoveCastWindow ~= 0 and not captured_spell_toggle and prefixes[spell.prefix] and moving then
		captured_spell_toggle = true
		if spell.prefix == "/range" then
			captured.spell = "/range "..spell.target.raw
			captured.timestamp = os.clock() + MoveCastWindow
		else
			captured.spell = spell.prefix.." \""..spell.name.."\" "..spell.target.raw
			captured.timestamp = os.clock() + MoveCastWindow
		end
		cancel_spell()
		return
	end

	local transport_spells = {
		['Teleport-Holla'] = true, ['Teleport-Dem'] = true, ['Teleport-Mea'] = true, ['Teleport-Altep'] = true, ['Teleport-Yhoat'] = true, ['Teleport-Vahzl'] = true, ['Recall-Jugner'] = true, ['Recall-Meriph'] = true, ['Recall-Pashh'] = true, ['Warp'] = true, ['Warp II'] = true, ['Retrace'] = true, ['Escape'] = true
	}
	if TransportLock and transport_spells[spell.en] and transport_locked then
		cancel_spell()
		transport_locked = false
		windower.add_to_chat(8,('[Notice] '):color(39)..(spell.name):color(1)..(' cancelled. Unlocked for 3 min or until zone.'):color(8))
		if AlertSounds then
			play_sound(Notification_Cancel)
		end
		transport_lock_timestamp = os.time() + 180
		return
	end
	local is_magic = spell.prefix == '/magic' or spell.prefix == '/ninjutsu' or spell.prefix == '/song'
	local is_ws_or_ja = spell.type == 'WeaponSkill' or spell.type == 'JobAbility'
	local blocked =
		buffactive['terror'] or
		buffactive['petrification'] or
		buffactive['sleep'] or
		buffactive['stun'] or
		(buffactive['amnesia'] or buffactive['impairment'] and is_ws_or_ja) or
		(buffactive['mute'] and is_magic)
	local silenced = buffactive['silence'] and is_magic
	if blocked or silenced then
		if AlertSounds then
			play_sound(Notification_Cancel)
		end
		if silenced then
			if UseEcho == 'E' then
				send_command('input /item "Echo Drops" <me>')
			elseif UseEcho == 'R' then
				send_command('input /item "Remedy" <me>')
			end
		end
		flash('Debuffs')
	elseif spell.type == 'WeaponSkill' then
		if player.tp < 1000 then
			if AlertSounds then
				play_sound(Notification_Cancel)
			end
			hud_noti_shdw:text('«« Not Enough TP »»')
			hud_noti:text('«« Not Enough TP »»')
			hud_noti:color(255,50,50)
			NotiCountdown = NotiDelay
		elseif (
			(spell.skill == 'Marksmanship' or spell.skill == 'Archery')
			and spell.target.distance >= (spell.target.model_size + 23)
		)
		or (
			(spell.skill ~= 'Marksmanship' and spell.skill ~= 'Archery')
			and spell.target.distance >= (spell.target.model_size + 3)
			and not (spell.english == 'Starlight' or spell.english == 'Moonlight')
		) then
			if AlertSounds then
				play_sound(Notification_Cancel)
			end
			hud_noti_shdw:text('«« Too Far »»')
			hud_noti:text('«« Too Far »»')
			hud_noti:color(255,50,50)
			NotiCountdown = NotiDelay
			cancel_spell()
			return
		end
		equip(sets[spell.english] and sets[spell.english] or sets.weapon_skill)
		if player.equipment.main == "Khatvanga" and spell.english == "Shattersoul" then
			pre_AMTimer = 181
		elseif player.equipment.main == 'Hvergelmir' and spell.english == "Myrkr" then
			player_tp = player.tp
			TP_Window_Open = true
			empyreanAMUpdate(player_tp)
		elseif player.equipment.main == "Tupsimati" and spell.english == "Omniscience" then
			player_tp = player.tp
			TP_Window_Open = true
			mythicAMUpdate(player_tp)
		elseif player.equipment.main == 'Opashoro' and spell.english == "Oshala" then
			player_tp = player.tp
			TP_Window_Open = true
			primeAMUpdate(player_tp)
		end
	elseif spell.english == 'Tabula Rasa' then
		equip(set_combine(sets.tabula_rasa))
		if AutoTRStrats then
			hud_noti_shdw:text('Tabula Rasa Auto-Strats now active')
			hud_noti:text('Tabula Rasa Auto-Strats now active')
			NotiCountdown = NotiDelay
		end
	elseif spell.english == 'Holy Water' then
		equip(set_combine(sets.holy_water))
	elseif (spell.english == 'Spectral Jig' or spell.english == 'Sneak' or spell.english == 'Monomi: Ichi' or spell.english == 'Monomi: Ni') and buffactive['Sneak'] and spell.target.type == 'SELF' then
		send_command('cancel 71')
		local fast_cast = spell.english ~= 'Spectral Jig' and sets.fast_cast or nil
		equip(set_combine(fast_cast))
	elseif spell.english == 'Stoneskin' and buffactive['Stoneskin'] then
		send_command('cancel 37')
		equip(set_combine(sets.fast_cast))
	elseif not (spell.action_type == 'Item' or spell.action_type == 'Ability') then
		-- if AutoTRStrats and auto_valve_open and not (buffactive['amnesia'] or buffactive['impairment']) then
		if AutoTRStrats and buffactive['Tabula Rasa'] and auto_valve_open and not (buffactive['amnesia'] or buffactive['impairment']) then
			auto_valve_open = false
			local spell_name = spell.english
			--Collect all abilities that this spell is associated with
			local abilities_to_cast = {}
			for ability_name, spell_list in pairs(AutoStrat) do
				if spell_list:contains(spell_name) and not buffactive[ability_name] then
					table.insert(abilities_to_cast, ability_name)
				end
			end
			--If we find matches, create a command with all matches in front of the original spell
			if #abilities_to_cast > 0 then
				cancel_spell() --Cancel original spell
				local wait = AutoStratDelay
				local text = ''
				--Loop to add each into the command
				for i, ability_name in ipairs(abilities_to_cast) do
					if not buffactive[ability_name] then
						text = text..'input /ja "'..ability_name..'" <me>;wait '..wait..';'
					end
				end
				--Add the original spell at the end
				text = text..'input /ma "'..spell_name..'" '..spell.target.raw..";wait "..(#abilities_to_cast * wait + 0.5)..";gs c open_auto_valve"
				send_command(text) --Run that command with all abilities and the spell.
				return
			else
				auto_valve_open = true --Reopen the valve for the next go 'round since no matches found
			end
		end
		local rdm = player.sub_job == 'RDM' and sets.fast_cast.sub_rdm or nil
		local grimoire = (buffactive['Light Arts'] or buffactive['Dark Arts'] or buffactive['Addendum: White'] or buffactive['Addendum: Black']) and sets.fast_cast.grimoire or nil
		local elemental = spell.skill=="Elemental Magic" and sets.fast_cast.elemental or nil
		local dispelga = spell.name == "Dispelga" and sets.fast_cast.dispelga or nil
		local impact = spell.name == "Impact" and sets.fast_cast.impact or nil
		local stoneskin = spell.name == "Stoneskin" and sets.fast_cast.stoneskin or nil
		local white_magic = (spell.type == "WhiteMagic" and (string.find(spell.name,'Cure') or string.find(spell.name,'Curaga'))) and sets.fast_cast.cure or nil
		equip(set_combine(sets.fast_cast, rdm, grimoire, elemental, impact, stoneskin, white_magic))
	end
end

-------------------------------------------
--               MIDCAST                 --
-------------------------------------------

function midcast(spell)

	local base_set = sets.conserve_mp
	local light_arts = (buffactive['Light Arts'] or buffactive['Addendum: White']) and sets.light_arts or nil
	local dark_arts = (buffactive['Dark Arts'] or buffactive['Addendum: Black']) and sets.dark_arts or nil
	local penury_parsimony = (buffactive['Penury'] or buffactive['Parsimony']) and sets.penury_parsimony or nil
	local rapture = buffactive.Rapture and sets.rapture or nil
	local weather = useHachirinNoObi(spell.element) and sets.hachirin_no_obi or nil

	if spell.type == "BlackMagic" then
		if spell.skill == "Elemental Magic" then
			local nuke = sets.nuke
			local immanence = (buffactive.Immanence and active_skillchain_targets[spell.target.id]) and sets.immanence or nil
			local magic_burst = (not immanence and Mode == 1 and active_skillchain_targets[spell.target.id]) and sets.nuke.magic_burst or nil
			local occult_acumen = (not immanence and Mode == 2) and sets.nuke.occult_acumen or nil
			local ebullience = buffactive.Ebullience and sets.ebullience or nil
			local helix = string.find(spell.name,"helix") and (HelixLowDamageImmanence[player.target.name] and sets.helix.low_damage_immanence or sets.helix) or nil
			local lumino = spell.english:startswith('Lumino') and sets.helix.luminohelix or nil
			local nocto = spell.english:startswith('Nocto') and sets.helix.noctohelix or nil
			local helix_mb = (not immanence and string.find(spell.name,"helix") and Mode == 1) and sets.helix.magic_burst or nil
			local impact = spell.name == "Impact" and sets.impact or nil
			equip(set_combine(base_set, nuke, magic_burst, occult_acumen, helix, lumino, nocto, helix_mb, penury_parsimony, ebullience, immanence, impact, weather))
		elseif spell.skill == "Enfeebling Magic" then
			local max_mnd = sets.max_mnd
			local dispelga = spell.name == "Dispelga" and sets.dispelga or nil
			local enfeebling = (string.find(spell.name,"Poison") or string.find(spell.name,'Sleep') or spell.name == "Gravity" or spell.name == "Bind") and sets.enfeebling or nil
			equip(set_combine(base_set, max_mnd, dispelga, enfeebling, penury_parsimony, dark_arts))
		elseif spell.skill == "Dark Magic" then
			local aspir_drain = (spell.name == "Drain" or string.find(spell.name,"Aspir"))
			and (dark_arts and set_combine(sets.aspir_drain, dark_arts) or sets.aspir_drain) or nil
			local stun = spell.name == "Stun" and sets.stun or nil
			local kaustra = spell.english == "Kaustra" and set_combine(sets.nuke, sets.kaustra) or nil
			local weather = weather and (aspir_drain or kaustra) and sets.hachirin_no_obi or nil
			equip(set_combine(base_set, aspir_drain, stun, dark_arts, penury_parsimony, kaustra, weather))
		elseif spell.skill == "Enhancing Magic" then
			equip(set_combine(base_set, sets.enhancing, penury_parsimony))
		end
	elseif spell.type == "WhiteMagic" then
		if spell.skill == "Healing Magic" then
			if spell.name == "Cursna" then
				local cursna = spell.target.type == "SELF" and set_combine(sets.cursna, sets.cursna.self) or sets.cursna
				equip(set_combine(base_set, cursna, penury_parsimony, light_arts))
			elseif string.find(spell.name,'Cur') or string.find(spell.name,'Curaga') then
				local cure_target = spell.target.type == "SELF" and sets.healing.self or sets.healing
				local addendum_white = buffactive['Addendum: White'] and sets.healing.addendum_white or nil
				equip(set_combine(base_set, cure_target, penury_parsimony, rapture, weather, addendum_white))
			end
		elseif spell.skill == "Enhancing Magic" then
			local aquaveil = spell.english == "Aquaveil" and sets.aquaveil or nil
			local regen = string.find(spell.name,'Regen') and sets.regen or nil
			local refresh = spell.english == "Refresh" and sets.refresh or nil
			local stoneskin = spell.english == "Stoneskin" and sets.stoneskin or nil
			local storm = string.find(spell.name,'storm') and sets.storm or nil
			local enspells = string.find(spell.name,'En') and sets.enspells or nil
			local protect = string.find(spell.name,'Protect') and sets.protect or nil
			local shell = string.find(spell.name,'Shell') and sets.shell or nil
			local perpetuance = buffactive.Perpetuance and sets.perpetuance or nil
			equip(set_combine(base_set, sets.enhancing, aquaveil, regen, refresh, stoneskin, storm, enspells, protect, shell, penury_parsimony, perpetuance, light_arts))
		elseif spell.skill == "Enfeebling Magic" then
			local max_mnd = (spell.name == "Slow" or spell.name == "Paralyze" or spell.name == "Silence") and sets.max_mnd or nil
			local silence = spell.name == "Silence" and sets.enfeebling or nil
			equip(set_combine(base_set, max_mnd, silence, penury_parsimony, dark_arts))
		elseif spell.skill == "Divine Magic" then
			equip(set_combine(base_set, sets.max_mnd, penury_parsimony, rapture))
		else
			equip(set_combine(base_set))
		end
	elseif spell.type == "Ninjutsu" then
		equip(set_combine(sets.ninjutsu))
	elseif spell.type == 'Trust' then
		equip(set_combine(sets.unity))
	end

end

-------------------------------------------
--              AFTERCAST                --
-------------------------------------------

function aftercast(spell)

	choose_set(spell.english == "Sublimation")

	if spell.english == 'Tabula Rasa' and TRTimer and not spell.interrupted then
		if player.equipment.legs == 'Pedagogy Pants' or player.equipment.legs == 'Peda. Pants +1' or player.equipment.legs == 'Peda. Pants +2' or player.equipment.legs == 'Peda. Pants +3' or player.equipment.legs == 'Peda. Pants +4' then --these pieces extend Tabula Rasa by 30 seconds so we adjust accordingly
			send_command('input /echo [Tabula Rasa] 3:30;wait 30;input /echo [Tabula Rasa] 3:00;wait 30;input /echo [Tabula Rasa] 2:30;wait 30;input /echo [Tabula Rasa] 2:00;wait 30;input /echo [Tabula Rasa] 1:30;wait 30;input /echo [Tabula Rasa] 1:00;wait 30;input /echo [Tabula Rasa] 0:30;wait 10;input /echo [Tabula Rasa] 0:20;wait 10;input /echo [Tabula Rasa] 0:10')
		else
			send_command('input /echo [Tabula Rasa] 3:00;wait 30;input /echo [Tabula Rasa] 2:30;wait 30;input /echo [Tabula Rasa] 2:00;wait 30;input /echo [Tabula Rasa] 1:30;wait 30;input /echo [Tabula Rasa] 1:00;wait 30;input /echo [Tabula Rasa] 0:30;wait 10;input /echo [Tabula Rasa] 0:20;wait 10;input /echo [Tabula Rasa] 0:10')
		end
	end

	if AutoSubCharge and Sublimation.recast and Sublimation.recast < 2 and not (buffactive['amnesia'] or buffactive['impairment'] or buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete'] or buffactive['Refresh'] or buffactive['Invisible'] or windower.ffxi.get_info().mog_house or world.area == 'Mog Garden') then
		if not double_sublimation_fix then
			double_sublimation_fix = true --prevents this from running through here a second time after being cast again below
			local wait = (spell.prefix == '/pet' or spell.type == '/jobability') and 0.5 or 3
			send_command('wait '..wait..';input /ja Sublimation <me>;wait 1;gs c double_sublimation_fix')
		end
	end

end

-------------------------------------------
--             STATUS CHANGE             --
-------------------------------------------

windower.register_event('status change', function(status)

	if status == 4 and not InCS and ShowHUD then --In a cutscene: Hide the HUD
		InCS = true
		windower.send_command('gs c HideHUD')
	elseif status ~= 4 and InCS and ShowHUD then --Out of cutscene: Show the HUD
		InCS = false
		windower.send_command('gs c ShowHUD')
	end

	choose_set()
	setNotification()

	if AutoSubCharge and status == 0 and Sublimation.recast and Sublimation.recast < 2 and not (buffactive['amnesia'] or buffactive['impairment'] or buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete'] or buffactive['Refresh'] or buffactive['Invisible'] or windower.ffxi.get_info().mog_house or world.area == 'Mog Garden') then
		if not double_sublimation_fix then
			double_sublimation_fix = true --prevents this from running a second time (as an aftercast above) after being run here
			send_command('input /ja Sublimation <me>;wait 1;gs c double_sublimation_fix')
		end
	end

end)

-------------------------------------------
--       Buff/Debuff Notifications       --
-------------------------------------------

windower.register_event('gain buff', function(buff)

	if (buff == 270 or buff == 271 or buff == 272 or buff == 273) and AlertSounds then --Aftermath
		play_sound(Notification_Aftermath_On)
		AMTimer = pre_AMTimer
		mythicNum = pre_mythicNum
		primeNum = pre_primeNum
		if LockWeaponOnAM then
			disable('main','sub')
		end
	elseif (buff == 2 or buff == 19) then
		if buffactive['Stoneskin'] and not buffactive['charm'] then --If we get slept, remove stoneskin if its up
			send_command('cancel 37')
		end
		equip(sets.danger)
	elseif buff == 7 or buff == 10 or buff == 28 then --If we get petrified, stunned, or terrored, then equip the Danger set
		equip(sets.danger)
	elseif buff == 15 then --Doom
		WarningCountdown = WarningRepeat --Start the Warning Sound going
	elseif buff == 17 then --Charm
		if AlertSounds then
			play_sound(Notification_Cancel)
		end
	elseif buff == 71 or buff == 69 then --Sneak or Invisible
		setNotification()
	elseif buff == 252 then --Mounted
		send_command('wait .5;gs c ClearNotifications')
	elseif buff == 358 or buff == 359 or buff == 401 or buff == 402 then -- Arts/Addendums
		artsCheck()
	end

end)

windower.register_event('lose buff', function(buff)

	if buff == 270 or buff == 271 or buff == 272 or buff == 273 and AlertSounds then --lose any aftermath
		play_sound(Notification_Aftermath_Off)
		if LockWeaponOnAM then
			enable('main','sub')
		end
	elseif buff == 251 and Alive and notifications.Food then --food wears off
		if AlertSounds then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Food Has Worn Off »»')
		hud_noti:text('«« Food Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 113 and notifications.Reraise and Alive then --reraise wears off
		if AlertSounds then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Reraise Has Worn Off »»')
		hud_noti:text('«« Reraise Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 602 and string.find(world.area,'Escha') and notifications.Vorseal then --Vorseal
		if AlertSounds then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Vorseal Has Worn Off »»')
		hud_noti:text('«« Vorseal Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 253 and notifications.Signet then --Signet
		if AlertSounds then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Signet Has Worn Off »»')
		hud_noti:text('«« Signet Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 256 and notifications.Signet then --Sanction
		if AlertSounds then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Sanction Has Worn Off »»')
		hud_noti:text('«« Sanction Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 268 and notifications.Signet then --Sigil
		if AlertSounds then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Sigil Has Worn Off »»')
		hud_noti:text('«« Sigil Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 512 and notifications.Signet then --Ionis
		if AlertSounds then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Ionis Has Worn Off »»')
		hud_noti:text('«« Ionis Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 1 and Alive then --Weakness
		if AlertSounds then
			play_sound(Notification_Good)
		end
		hud_noti_shdw:text('«« Weakness Has Worn Off »»')
		hud_noti:text('«« Weakness Has Worn Off »»')
		hud_noti:color(75,255,75)
		NotiCountdown = NotiDelay
	elseif buff == 2 or buff == 19 or buff == 7 or buff == 10 or buff == 28 then --lose sleep, petrify, stun, or terror run choose_set since we changed gear for those
		choose_set()
	elseif buff == 15 then --Doom
		WarningCountdown = 0 --Set to 0 to turn the sound off when we are no longer Doomed
	elseif buff == 71 or buff == 69 then --Sneak or Invisible
		setNotification()
	elseif buff == 252 then --Mounted
		send_command('wait .5;gs c ClearNotifications')
	elseif buff == 358 or buff == 359 or buff == 401 or buff == 402 then -- Arts/Addendums
		artsCheck()
	end

end)

--GearSwap caalls this function when a status is overwritten (Aftermath in our case)
function buff_refresh(name)
	if name == "Aftermath" or name == "Aftermath: Lv.1" then
		AMTimer = pre_AMTimer
		mythicNum = pre_mythicNum
		primeNum = pre_primeNum
	end
end

windower.register_event('tp change',function()

	if player.tp == 3000 and notifications.TP3000 then
		Notifications = '«« 3000 TP »»'
		if AlertSounds then
			play_sound(Notification_3000TP)
		end
		hud_noti_shdw:text('«« 3000 TP »»')
		hud_noti:text('«« 3000 TP »»')
		hud_noti:color(255,255,50)
		NotiCountdown = NotiDelay
	end

	--HUD TP Meter
	if not (TownZones[world.area] or windower.ffxi.get_info().mog_house) then
		local TPMeter = ''
		local spaces = 0
		local c = color.AM3
		if player.tp < 1000 then
			c = color.AM1
			spaces = math.floor(36 * ((player.tp / 1000) * 100 / 100))
			hud_tp_meter_bg1:bg_alpha(0)
			hud_tp_meter_bg2:bg_alpha(0)
			hud_tp_meter:bg_alpha(100)
		elseif player.tp < 2000 then
			c = color.AM2
			spaces = math.floor(36 * (((player.tp - 1000) / 1000) * 100 / 100))
			hud_tp_meter_bg1:bg_alpha(100)
			hud_tp_meter_bg2:bg_alpha(0)
			hud_tp_meter:bg_alpha(100)
		elseif player.tp < 3000 then
			spaces = math.floor(36 * (((player.tp - 2000) / 1000) * 100 / 100))
			hud_tp_meter_bg1:bg_alpha(100)
			hud_tp_meter_bg2:bg_alpha(100)
			hud_tp_meter:bg_alpha(125)
		else
			spaces = 36
			hud_tp_meter_bg1:bg_alpha(0)
			hud_tp_meter_bg2:bg_alpha(0)
			hud_tp_meter:bg_alpha(150)
		end
		while string.len(TPMeter) < spaces do
			TPMeter = TPMeter..' '
		end
		hud_tp_meter:text(TPMeter)
		hud_tp_meter:bg_color(c.r,c.g,c.b)
		if TPMeter == '' then
			hud_tp_meter:bg_alpha(0)
		end
	else
		hud_tp_meter_bg1:bg_alpha(0)
		hud_tp_meter_bg2:bg_alpha(0)
		hud_tp_meter:bg_alpha(0)
	end

	--Update AM TP calculations if we gain more TP between initiating the WS and the WS activating (Aeonic has no TP calculations, just based on which AM# is gained)
	if TP_Window_Open and player.tp > player_tp then
		player_tp = player.tp
		if player.equipment.main == 'Hvergelmir' then
			empyreanAMUpdate(player_tp)
		elseif player.equipment.main == "Tupsimati" then
			mythicAMUpdate(player_tp)
		elseif player.equipment.main == 'Opashoro' then
			primeAMUpdate(player_tp)
		end
	end

end)

-------------------------------------------
--              HEARTBEAT                --
-------------------------------------------

--Miscellaneous things we check for to keep them updated
windower.register_event('prerender', function()

	--Using the teleports in Sortie pauses timers
	if world.area == "Outer Ra'Kaznar [U]" and player.status == "Event" then
		return
	end

	local current_time = os.clock()

	--Check for captured spells (to delay them while coming to a stop from moving)
	if captured.timestamp and current_time > last_captured_poll + 0.1 then
		last_captured_poll = current_time
		if captured.timestamp > current_time then
			if not moving then
				send_command('wait '..MoveCastDelay..';input '..captured.spell)
				captured = {}
				send_command('wait '..(MoveCastDelay + 1)..';gs c resetCapturedToggle')
			end
		else
			send_command('wait '..MoveCastDelay..';input '..captured.spell)
				captured = {}
			send_command('wait '..(MoveCastDelay + 1)..';gs c resetCapturedToggle')
		end
	end

	--Polling rate
	if current_time - last_poll >= 1 / PollingRate then

		last_poll = current_time

		--Zoning: hide HUD
		local pos = windower.ffxi.get_position()
		if pos == "(?-?)" and not Zoning and ShowHUD then
			send_command('gs c HideHUD')
			Zoning = true
		elseif pos ~= "(?-?)" and Zoning and ShowHUD then
			send_command('gs c ShowHUD')
			Zoning = false
		end

		--Checking gear on movement
		if AutoGearCheck or AutoMvmntSpeed then
			local get_player = windower.ffxi.get_mob_by_target('me')
			if get_player then
				--Player has started moving
				if player_x ~= get_player.x or player_y ~= get_player.y then
					if not moving and player.status == "Idle" then
						moving = true
						choose_set()
					end
				--Player has stopped moving
				elseif moving then
					moving = false
					choose_set()
				end
				player_x = get_player.x
				player_y = get_player.y
			end
		end

		--Clear expired Skillchain timers
		for id, timestamp in pairs(active_skillchain_targets) do
			if timestamp <= current_time then
				active_skillchain_targets[id] = nil
			end
		end

		--Aftermath checks
		local function colorWeaponsText(AM)
			if not ShowTPMeter then
				local c = {r = 255, g = 255, b = 255}
				if AM == 1 then
					c = color.AM1
				elseif AM == 2 then
					c = color.AM2
				elseif AM == 3 then
					c = color.AM3
				end
				hud_weapons:color(c.r,c.g,c.b)
			end
		end
		if player.equipment.main == 'Opashoro' then
			if buffactive['Aftermath: Lv.1'] then
				if currentAfterMath ~= 'PrimeAM1' or primeNum ~= currentPrimeNum or currentAMTimer ~= AMTimer then
					currentAfterMath = 'PrimeAM1'
					currentPrimeNum = primeNum
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM1: (MAB +'..primeNum..', MDAM +'..(primeNum * 2)..') '..am_time))
					hud_weapons:text(formatWeapons('AM1: (MAB +'..primeNum..', MDAM +'..(primeNum * 2)..') '..am_time))
					colorWeaponsText(1)
				end
			elseif buffactive['Aftermath: Lv.2'] then
				if currentAfterMath ~= 'PrimeAM2' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'PrimeAM2'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM2: (MAB +'..primeNum..', MDAM +'..(primeNum * 2)..') '..am_time))
					hud_weapons:text(formatWeapons('AM2: (MAB +'..primeNum..', MDAM +'..(primeNum * 2)..') '..am_time))
					colorWeaponsText(2)
				end
			elseif buffactive['Aftermath: Lv.3'] then
				if currentAfterMath ~= 'PrimeAM3' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'PrimeAM3'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM3: (MAB +'..primeNum..', MDAM +'..(primeNum * 2)..') '..am_time))
					hud_weapons:text(formatWeapons('AM3: (MAB +'..primeNum..', MDAM +'..(primeNum * 2)..') '..am_time))
					colorWeaponsText(3)
				end
			else
				if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain then
					CurrentEquip = EquipMain
					currentAfterMath = 'None'
					hud_weapons_shdw:text(formatWeapons(EquipMain))
					hud_weapons:text(formatWeapons(EquipMain))
					colorWeaponsText()
				end
			end
		elseif player.equipment.main == 'Hvergelmir' then
			if buffactive['Aftermath: Lv.1'] then
				if currentAfterMath ~= 'EmpyreanAM1' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'EmpyreanAM1'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM1: (30% Triple Dmg) '..am_time))
					hud_weapons:text(formatWeapons('AM1: (30% Triple Dmg) '..am_time))
					colorWeaponsText(1)
				end
			elseif buffactive['Aftermath: Lv.2'] then
				if currentAfterMath ~= 'EmpyreanAM2' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'EmpyreanAM2'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM2: (40% Triple Dmg) '..am_time))
					hud_weapons:text(formatWeapons('AM2: (40% Triple Dmg) '..am_time))
					colorWeaponsText(2)
				end
			elseif buffactive['Aftermath: Lv.3'] then
				if currentAfterMath ~= 'EmpyreanAM3' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'EmpyreanAM3'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM3: (50% Triple Dmg) '..am_time))
					hud_weapons:text(formatWeapons('AM3: (50% Triple Dmg) '..am_time))
					colorWeaponsText(3)
				end
			else
				if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain then
					CurrentEquip = EquipMain
					currentAfterMath = 'None'
					hud_weapons_shdw:text(formatWeapons(EquipMain))
					hud_weapons:text(formatWeapons(EquipMain))
					colorWeaponsText()
				end
			end
		elseif player.equipment.main == 'Tupsimati' then
			if buffactive['Aftermath: Lv.1'] then
				if currentAfterMath ~= 'MythicAM1' or mythicNum ~= currentMythicNum or currentAMTimer ~= AMTimer then
					currentAfterMath = 'MythicAM1'
					currentMythicNum = mythicNum
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM1: (Accuracy +'..mythicNum..') '..am_time))
					hud_weapons:text(formatWeapons('AM1: (Accuracy +'..mythicNum..') '..am_time))
					colorWeaponsText(1)
				end
			elseif buffactive['Aftermath: Lv.2'] then
				if currentAfterMath ~= 'MythicAM2' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'MythicAM2'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM2: (Attack +'..mythicNum..') '..am_time))
					hud_weapons:text(formatWeapons('AM2: (Attack +'..mythicNum..') '..am_time))
					colorWeaponsText(2)
				end
			elseif buffactive['Aftermath: Lv.3'] then
				if currentAfterMath ~= 'MythicAM3' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'MythicAM3'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM3: (Occ. Att. 2-3x) '..am_time))
					hud_weapons:text(formatWeapons('AM3: (Occ. Att. 2-3x) '..am_time))
					colorWeaponsText(3)
				end
			else
				if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain then
					CurrentEquip = EquipMain
					currentAfterMath = 'None'
					hud_weapons_shdw:text(formatWeapons(EquipMain))
					hud_weapons:text(formatWeapons(EquipMain))
					colorWeaponsText()
				end
			end
		elseif player.equipment.main == 'Khatvanga' then
			if buffactive['Aftermath: Lv.1'] then
				if currentAfterMath ~= 'AeonicAM1' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'AeonicAM1'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM1: (4-Step Ultimate SC) '..am_time))
					hud_weapons:text(formatWeapons('AM1: (4-Step Ultimate SC) '..am_time))
					colorWeaponsText(1)
				end
			elseif buffactive['Aftermath: Lv.2'] then
				if currentAfterMath ~= 'AeonicAM2' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'AeonicAM2'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM2: (3-Step Ultimate SC) '..am_time))
					hud_weapons:text(formatWeapons('AM2: (3-Step Ultimate SC) '..am_time))
					colorWeaponsText(2)
				end
			elseif buffactive['Aftermath: Lv.3'] then
				if currentAfterMath ~= 'AeonicAM3' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'AeonicAM3'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM3: (2-Step Ultimate SC) '..am_time))
					hud_weapons:text(formatWeapons('AM3: (2-Step Ultimate SC) '..am_time))
					colorWeaponsText(3)
				end
			else
				if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain then
					CurrentEquip = EquipMain
					currentAfterMath = 'None'
					hud_weapons_shdw:text(formatWeapons(EquipMain))
					hud_weapons:text(formatWeapons(EquipMain))
					colorWeaponsText()
				end
			end
		elseif currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain then
			CurrentEquip = EquipMain
			currentAfterMath = 'None'
			hud_weapons_shdw:text(formatWeapons(EquipMain))
			hud_weapons:text(formatWeapons(EquipMain))
			colorWeaponsText()
		end

		--Debuff checks
		if buffactive['doom'] and notifications.Doom and Alive then
			if not debuffs.Charm then
				debuffs.Charm = true
				hud_debuffs_shdw:text('            «« DOOMED »»')
				local c = color.Dark
				hud_debuffs:text('            «« \\cs('..c.r..','..c.g..','..c.b..')DOOMED\\cr »»')
			end
		elseif buffactive['animated'] and notifications.Charm and Alive then
			if not debuffs.Animated then
				debuffs.Animated = true
				hud_debuffs_shdw:text('           «« ANIMATED »»')
				local c = color.Light
				hud_debuffs:text('           «« \\cs('..c.r..','..c.g..','..c.b..')ANIMATED\\cr »»')
			end
		elseif buffactive['charm'] and notifications.Charm and Alive then
			if not debuffs.Charm then
				debuffs.Charm = true
				hud_debuffs_shdw:text('           «« CHARMED »»')
				local c = color.Light
				hud_debuffs:text('           «« \\cs('..c.r..','..c.g..','..c.b..')CHARMED\\cr »»')
			end
		elseif buffactive['terror'] and notifications.Terror and Alive then
			if not debuffs.Terror then
				debuffs.Terror = true
				hud_debuffs_shdw:text('          «« TERRORIZED »»')
				local c = color.Dark
				hud_debuffs:text('          «« \\cs('..c.r..','..c.g..','..c.b..')TERRORIZED\\cr »»')
			end
		elseif buffactive['petrification'] and notifications.Petrification and Alive then
			if not debuffs.Petrification then
				debuffs.Petrification = true
				hud_debuffs_shdw:text('          «« PETRIFIED »»')
				local c = color.Earth
				hud_debuffs:text('          «« \\cs('..c.r..','..c.g..','..c.b..')PETRIFIED\\cr »»')
			end
		elseif buffactive['sleep'] and notifications.Sleep and Alive then
			if not debuffs.Sleep then
				debuffs.Sleep = true
				hud_debuffs_shdw:text('            «« ASLEEP »»')
				local c = color.Dark
				hud_debuffs:text('            «« \\cs('..c.r..','..c.g..','..c.b..')ASLEEP\\cr »»')
			end
		elseif buffactive['stun'] and notifications.Stun and Alive then
			if not debuffs.Stun then
				debuffs.Stun = true
				hud_debuffs_shdw:text('           «« STUNNED »»')
				local c = color.Thunder
				hud_debuffs:text('           «« \\cs('..c.r..','..c.g..','..c.b..')STUNNED\\cr »»')
			end
		else
			--Set any of the above to false once they are gone
			if debuffs.Doom then debuffs.Doom = false end
			if debuffs.Animated then debuffs.Animated = false end
			if debuffs.Charm then debuffs.Charm = false end
			if debuffs.Terror then debuffs.Terror = false end
			if debuffs.Petrification then debuffs.Petrification = false end
			if debuffs.Sleep then debuffs.Sleep = false end
			if debuffs.Stun then debuffs.Stun = false end
			if notifications.Silence and Alive then
				if buffactive['mute'] then
					if not debuffs.Mute then
						debuffs.Mute = true
						local c = color.Air
						SIL = '\\cs('..c.r..','..c.g..','..c.b..')MUTE\\cr'
					end
				elseif buffactive['silence'] then
					if not debuffs.Silence then
						debuffs.Silence = true
						local c = color.Air
						SIL = '\\cs('..c.r..','..c.g..','..c.b..')SLNC\\cr'
					end
				else
					if debuffs.Mute then debuffs.Mute = false end
					if debuffs.Silence then debuffs.Silence = false end
					if SIL ~= '    ' then SIL = '    ' end
				end
			end
			if notifications.Paralysis and Alive then
				if buffactive['paralysis'] then
					if not debuffs.Paralysis then
						debuffs.Paralysis = true
						local c = color.Ice
						PAR = '\\cs('..c.r..','..c.g..','..c.b..')PARLZ\\cr'
					end
				else
					if debuffs.Paralysis then debuffs.Paralysis = false end
					if PAR ~= '     ' then PAR = '     ' end
				end
			end
			if notifications.Plague and Alive then
				if buffactive['plague'] then
					if not debuffs.Plague then
						debuffs.Plague = true
						local c = color.Fire
						PLG = '\\cs('..c.r..','..c.g..','..c.b..')PLGUE\\cr'
					end
				else
					if debuffs.Plague then debuffs.Plague = false end
					if PLG ~= '     ' then PLG = '     ' end
				end
			end
			if notifications.Curse and Alive then
				if buffactive[20] then
					if not debuffs.Zombie then
						debuffs.Zombie = true
						local c = color.Dark
						CUR = '\\cs('..c.r..','..c.g..','..c.b..')ZOMBI\\cr'
					end
				elseif buffactive['haunt'] then
					if not debuffs.Haunt then
						debuffs.Haunt = true
						local c = color.Dark
						CUR = '\\cs('..c.r..','..c.g..','..c.b..')HAUNT\\cr'
					end
				elseif buffactive['curse'] then
					if not debuffs.Curse then
						debuffs.Curse = true
						local c = color.Dark
						CUR = '\\cs('..c.r..','..c.g..','..c.b..')CURSE\\cr'
					end
				else
					if debuffs.Zombie then debuffs.Zombie = false end
					if debuffs.Haunt then debuffs.Haunt = false end
					if debuffs.Curse then debuffs.Curse = false end
					if CUR ~= '     ' then CUR = '     ' end
				end
			end
			if notifications.Amnesia and Alive then
				if buffactive['amnesia'] then
					if not debuffs.Amnesia then
						debuffs.Amnesia = true
						local c = color.Fire
						AMN = '\\cs('..c.r..','..c.g..','..c.b..')AMNES\\cr'
					end
				elseif buffactive['impairment'] then
					if not debuffs.Impairment then
						debuffs.Impairment = true
						local c = color.Fire
						AMN = '\\cs('..c.r..','..c.g..','..c.b..')IMPAR\\cr'
					end
				else
					if debuffs.Amnesia then debuffs.Amnesia = false end
					if AMN ~= '     ' then AMN = '     ' end
				end
			end
			if notifications.Taint and Alive then
				if buffactive['taint'] then
					if not debuffs.Taint then
						debuffs.Taint = true
						local c = color.Water
						TNT = '\\cs('..c.r..','..c.g..','..c.b..')TAINT\\cr'
					end
				else
					if debuffs.Taint then debuffs.Taint = false end
					if TNT ~= '     ' then TNT = '     ' end
				end
			end
			if notifications.Encumbrance and Alive then
				if buffactive['encumbrance'] then
					if not debuffs.Encumbrance then
						debuffs.Encumbrance = true
						local c = color.Water
						ENC = '\\cs('..c.r..','..c.g..','..c.b..')ENCMB\\cr'
					end
				else
					if debuffs.Encumbrance then debuffs.Encumbrance = false end
					if ENC ~= '     ' then ENC = '     ' end
				end
			end
			if SIL == '    ' and PAR == '     ' and PLG == '     ' and CUR == '     ' and AMN == '     ' and TNT == '     ' and ENC == '     ' then
				hud_debuffs_shdw:text('')
				hud_debuffs:text('')
			else
				hud_debuffs:text(' '..AMN..CUR..ENC..PAR..PLG..SIL..TNT)
				hud_debuffs_shdw:text(' '..AMN:text_strip_format()..CUR:text_strip_format()..ENC:text_strip_format()..PAR:text_strip_format()..PLG:text_strip_format()..SIL:text_strip_format()..TNT:text_strip_format())
			end
		end

		-- Arts/Addendums checks
		artsCheck()

		-- Mode checks
		modeCheck()

		-- Element checks
		local function elementCheck()
			local text = format12(Element == "Off" and "" or Element)
			local element_colors = {
				Light		= color.Light,
				Dark		= color.Dark,
				Fire		= color.Fire,
				Stone		= color.Earth,
				Water		= color.Water,
				Aero		= color.Air,
				Blizzard	= color.Ice,
				Thunder		= color.Thunder,
			}
			local c = element_colors[Element] or color.None
			hud_element:text(text)
			hud_element_shdw:text(text)
			hud_element:color(c.r,c.g,c.b)
		end
		elementCheck()

		--MP checks
		if notifications.LowMP and player and player.mpp <= 20 and not NotiLowMPToggle then
			NotiLowMPToggle = true --turn the toggle on so this can't be triggered again until its toggled off
			lowMP = true
			if AlertSounds then
				play_sound(Notification_Bad)
			end
			hud_noti_shdw:text('«« Low MP »»')
			hud_noti:text('«« Low MP »»')
			hud_noti:color(255,50,50)
			NotiCountdown = NotiDelay	
			send_command('wait 30;gs c NotiLowMPToggle') --wait 30 sec then turns the toggle back off
		elseif notifications.LowMP and player and player.mpp > 20 and lowMP then
			lowMP = false
			setNotification()
		end

		--HP checks
		if player.hp == 0 then --are we dead?
			if Alive then
				hud_noti_shdw:text('Status: Dead X_x')
				hud_noti:text('Status: Dead X_x')
				hud_noti:color(255,50,50)
				NotiCountdown = -1
				Alive = false
				announceAlive = true
				WarningCountdown = 0
				if LowHP then
					LowHP = false
				end
			end
		else
			if not Alive and announceAlive then
				hud_noti_shdw:text('Status: Alive ^_^')
				hud_noti:text('Status: Alive ^_^')
				hud_noti:color(75,255,75)
				NotiCountdown = -1
				announceAlive = false
				send_command('wait 1;gs c AliveDelay') --we use a command to set this to true so that we can set a short delay to prevent things from triggering right when we raise
			end
			if player.hp <= LowHPThreshold and player.max_hp > LowHPThreshold and not (buffactive['weakness'] or TownZones[world.area] or windower.ffxi.get_info().mog_house) then --when HP goes below a certain amount, turn on the LowHP flag and equip the appropriate gear set
				if not LowHP then
					LowHP = true
					WarningCountdown = WarningRepeat
					choose_set()
				end
			elseif (player.hp > LowHPThreshold or player.max_hp > LowHPThreshold) and LowHP then --when HP goes back above a certain amount, turn off the LowHP flag and equip the appropriate gear set
				LowHP = false
				setNotification()
				choose_set()
			end
		end

		--Recast updates
		getRecasts()
		getHUDAbils()

		if player.equipment.main == nil or player.equipment.sub == nil then
			EquipMain = 'Weapons loading...'
		else
			EquipMain = player.equipment.main
		end

		--Recast color updates
		if TabulaRasa.recast then
			if buffactive['Tabula Rasa'] then
				textColor('Tabula Rasa','active')
				TabulaRasa.flashed = false
			elseif TabulaRasa.recast > 0 then
				textColor('Tabula Rasa','cooldown')
				TabulaRasa.flashed = false
			else
				textColor('Tabula Rasa','ready')
				if not TabulaRasa.flashed then
					flash('Tabula Rasa')
				end
				TabulaRasa.flashed = true
			end
		else
			textColor('Tabula Rasa','notfound')
		end

		if CaperEmissarius.recast then
			if buffactive['Caper Emissarius'] then
				textColor('Caper Emissarius','active')
				CaperEmissarius.flashed = false
			elseif CaperEmissarius.recast > 0 then
				textColor('Caper Emissarius','cooldown')
				CaperEmissarius.flashed = false
			else
				textColor('Caper Emissarius','ready')
				if not CaperEmissarius.flashed then
					flash('Caper Emissarius')
				end
				CaperEmissarius.flashed = true
			end
		else
			textColor('Caper Emissarius','notfound')
		end

		if Convert.recast then
			if Convert.recast > 0 then
				textColor('Convert','cooldown')
				Convert.flashed = false
			else
				textColor('Convert','ready')
				if not Convert.flashed then
					flash('Convert')
				end
				Convert.flashed = true
			end
		else
			textColor('Convert','notfound')
		end

		if DarkArts.recast then
			if buffactive['Dark Arts'] then
				textColor('Dark Arts','active')
				DarkArts.flashed = false
			elseif DarkArts.recast > 0 then
				textColor('Dark Arts','cooldown')
				DarkArts.flashed = false
			else
				textColor('Dark Arts','ready')
				if not DarkArts.flashed then
					flash('Dark Arts')
				end
				DarkArts.flashed = true
			end
		else
			textColor('Dark Arts','notfound')
		end

		if DivineSeal.recast then
			if buffactive['Divine Seal'] then
				textColor('Divine Seal','active')
				DivineSeal.flashed = false
			elseif DivineSeal.recast > 0 then
				textColor('Divine Seal','cooldown')
				DivineSeal.flashed = false
			else
				textColor('Divine Seal','ready')
				if not DivineSeal.flashed then
					flash('Divine Seal')
				end
				DivineSeal.flashed = true
			end
		else
			textColor('Divine Seal','notfound')
		end

		if Enlightenment.recast then
			if Enlightenment.recast > 0 then
				textColor('Enlightenment','cooldown')
				Enlightenment.flashed = false
			else
				textColor('Enlightenment','ready')
				if not Enlightenment.flashed then
					flash('Enlightenment')
				end
				Enlightenment.flashed = true
			end
		else
			textColor('Enlightenment','notfound')
		end

		if Libra.recast then
			if Libra.recast > 0 then
				textColor('Libra','cooldown')
				Libra.flashed = false
			else
				textColor('Libra','ready')
				if not Libra.flashed then
					flash('Libra')
				end
				Libra.flashed = true
			end
		else
			textColor('Libra','notfound')
		end

		if LightArts.recast then
			if buffactive['Light Arts'] then
				textColor('Light Arts','active')
				LightArts.flashed = false
			elseif LightArts.recast > 0 then
				textColor('Light Arts','cooldown')
				LightArts.flashed = false
			else
				textColor('Light Arts','ready')
				if not LightArts.flashed then
					flash('Light Arts')
				end
				LightArts.flashed = true
			end
		else
			textColor('Light Arts','notfound')
		end

		if ModusVeritas.recast then
			if ModusVeritas.recast > 0 then
				textColor('Modus Veritas','cooldown')
				ModusVeritas.flashed = false
			else
				textColor('Modus Veritas','ready')
				if not ModusVeritas.flashed then
					flash('Modus Veritas')
				end
				ModusVeritas.flashed = true
			end
		else
			textColor('Modus Veritas','notfound')
		end

		if Stratagems.recast then
			if strat_charges > strat_flash_counter then
				flash('Stratagems')
			end
			strat_flash_counter = strat_charges
			textColor('Stratagems', strat_charges == 0 and 'cooldown' or 'ready')
		else
			textColor('Stratagems','notfound')
		end

		if Sublimation.recast then
			if buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete'] then
				textColor('Sublimation','active')
				Sublimation.flashed = false
			elseif Sublimation.recast > 0 then
				textColor('Sublimation','cooldown')
				Sublimation.flashed = false
			else
				textColor('Sublimation','ready')
				if not Sublimation.flashed then
					flash('Sublimation')
				end
				Sublimation.flashed = true
			end
		else
			textColor('Sublimation','notfound')
		end

	end

	--1 second heartbeat
	if current_time - last_second >= 1 then

		last_second = current_time

		if notifications.ReraiseReminder then
			if RRRCountdown > 0 then
				RRRCountdown = RRRCountdown - 1
			else
				if not buffactive['Reraise'] and Alive then --if we are dead no need to remind us about reraise
					if AlertSounds then
						play_sound(Notification_Bad)
					end
					hud_noti_shdw:text('«« No Reraise »»')
					hud_noti:text('«« No Reraise »»')
					hud_noti:color(255,50,50)
					NotiCountdown = NotiDelay
				end
				RRRCountdown = RRReminderTimer --start the timer back up
			end
		end

		if AMTimer > 0 then
			AMTimer = AMTimer - 1
		end

		if notifications.LowHP and LowHP and Alive then
			hud_noti_shdw:text('«« Low HP »»')
			hud_noti:text('«« Low HP »»')
			hud_noti:color(255,50,50)
			flash('Noti')
			NotiCountdown = -1
		end

		if notifications.Doom and buffactive['doom'] then 
			flash('Debuffs')
		end
		if (notifications.Doom and buffactive['doom']) or (notifications.LowHP and LowHP and Alive and not (buffactive['weakness'] or TownZones[world.area] or windower.ffxi.get_info().mog_house)) and AlertSounds and WarningCountdown > 0 then
			WarningCountdown = WarningCountdown - 1
			play_sound(Notification_Danger)
		end

		if NotiCountdown > 0 then
			NotiCountdown = NotiCountdown - 1
		elseif NotiCountdown == 0 then
			NotiCountdown = -1
			setNotification()
		end

		if SafeTimer > 0 then
			SafeTimer = SafeTimer - 1
		elseif SafeTimer == 0 then
			TakingDamage = false
			SafeTimer = -1
			choose_set()
		end

		if GreetingDelay > 0 then
			GreetingDelay = GreetingDelay - 1
		elseif GreetingDelay == 0 then
			GreetingDelay = -1
			setNotification()
		end

		if party and party_count == 1 and party_count ~= party.count then
			party_count = party.count
			setNotification()
		elseif party and party_count ~= 1 and party.count == 1 then
			party_count = 1
		end

		if transport_lock_timestamp ~= 0 and os.time() > transport_lock_timestamp then
			transport_locked = true
			transport_lock_timestamp = 0
			windower.add_to_chat(8,('[Notice] '):color(39)..('Transport locked.'):color(8))
		end

	end
end)

-------------------------------------------
--             ZONE CHANGE               --
-------------------------------------------

windower.register_event('zone change',function()

	--Equip appropriate gear
	if ZoneGear ~= 'Off' then
		send_command('gs c Zone Gear')
	end

	--Clear any notifications
	setNotification()

	--Clear any debuffs
	send_command('gs c ClearDebuffs')

	--Update in case we just recently spent more JPs
	getStratChargeTimer()

	--Unlock Transport spells
	transport_locked = true
	transport_lock_timestamp = 0

	--Clear any Skillchain timers just in case
	active_skillchain_targets = {}

end)

-------------------------------------------
--           SUB JOB CHANGE              --
-------------------------------------------

function sub_job_change(newSubjob, oldSubjob)

	if GreetingDelay == -1 then
		setNotification()
	end

	-- Reset HUD Abilities/Spells and Macro Page
	if newSubjob == 'WHM' then
		subjob = 'WHM'
	elseif newSubjob == 'RDM' then
		subjob = 'RDM'
	else
		subjob = 'OTH'
	end
	getHUDAbils()

	if ZoneGear ~= 'Off' then
		send_command('wait 2;gs c Zone Gear')
	end

end

-----------------------------------------
--           LEVEL CHANGE              --
-----------------------------------------

--Stratagem recharge time is based on SCH level, so check every time our level changes
windower.register_event('level up',function()
	getStratChargeTimer()
end)

windower.register_event('level down',function()
	getStratChargeTimer()
end)

-------------------------------------------
--        INCOMING TEXT CHECKS           --
-------------------------------------------

windower.register_event('incoming text',function(org)
	if org:find('wishes to trade with you') then
		if AlertSounds then
			play_sound(Notification_Good)
		end
		if notifications.Trade then
			hud_noti_shdw:text('«« Trade Request »»')
			hud_noti:text('«« Trade Request »»')
			hud_noti:color(255,255,50)
		end
	elseif org:find('The effect of') and org:find('is about to wear off.') then
		if AlertSounds then
			play_sound(Notification_Bad)
		end
		if notifications.Sneak and org:find('Sneak') then
			hud_noti_shdw:text('«« Sneak Wearing »»')
			hud_noti:text('«« Sneak Wearing »»')
			hud_noti:color(255,100,100)
		elseif notifications.Invis and org:find('Invisible') then
			hud_noti_shdw:text('«« Invisible Wearing »»')
			hud_noti:text('«« Invisible Wearing »»')
			hud_noti:color(255,100,100)
		end
	elseif org:find('Lost key item') and org:find('Radialens') then
		send_command('gs c Radialens')
	elseif org:find('invites you to') then
		if AlertSounds then
			play_sound(Notification_Good)
		end
		if notifications.Invite and org:find('party') and not org:find('alliance') then
			hud_noti_shdw:text('«« Party Invite »»')
			hud_noti:text('«« Party Invite »»')
			hud_noti:color(255,255,50)
		elseif notifications.Invite and org:find('alliance') then
			hud_noti_shdw:text('«« Alliance Invite »»')
			hud_noti:text('«« Alliance Invite »»')
			hud_noti:color(255,255,50)
		end
		NotiCountdown = 180
	elseif org:find('Your visitant status will wear off in') then
		if org:find(' 15 ') then
			if AlertSounds then
				play_sound(Notification_Bad)
			end
			if notifications.Time then
				hud_noti_shdw:text('«« 15 Minutes Remaining »»')
				hud_noti:text('«« 15 Minutes Remaining »»')
				hud_noti:color(255,255,50)
			end
		elseif org:find(' 10 ') then
			if AlertSounds then
				play_sound(Notification_Bad)
			end
			if notifications.Time then
				hud_noti_shdw:text('«« 10 Minutes Remaining »»')
				hud_noti:text('«« 10 Minutes Remaining »»')
				hud_noti:color(255,255,50)
			end
		elseif org:find(' 5 ') then
			if AlertSounds then
				play_sound(Notification_Bad)
			end
			if notifications.Time then
				hud_noti_shdw:text('«« 5 Minutes Remaining »»')
				hud_noti:text('«« 5 Minutes Remaining »»')
				hud_noti:color(255,255,50)
			end
		end
		NotiCountdown = NotiDelay
	elseif org:find('Trade complete') then
		setNotification()
	end
end)

-------------------------------------------
--         DAMAGE NOTIFICATIONS          --
-------------------------------------------

windower.register_event('action',function(act)

	local ata = act.targets[1].actions[1]
	local msg = ata.message
	local target_id = act.targets[1].id
	local clock = os.clock()

	--Check if a monsters attack hits the player
	if DangerMode == "Auto" and (not DangerPTOnly or playerIsInAPartyOrAlliance()) and isMonster(act.actor_id) then
		for i = 1, act.target_count do
			if act.targets[i].id == player.id then
				SafeTimer = DangerSafeDelay
				TakingDamage = true
				choose_set()
				break
			end
		end
	end

	--Track Skillchain things our party/alliance is doing
	--NOTE: Since we need to know slightly ahead of the actual Magic Burst window to make sure to be casting in MB gear, we're
	--      just going to assume if we're nuking on a monster someone is WS'ing (or related things) on that we're trying to MB.
	if isInOurPartyOrAlliance(act.actor_id) then

		local function addToActiveSkillchain(id)
			active_skillchain_targets = {
				[id] = clock + 10,
			}
		end

		--Weapon Skills
		if act.category == 3 and msg == 185 then
			addToActiveSkillchain(target_id)
		end

		--Konzen-ittai (and maybe Wild Flourish?)
		if act.category == 14 and msg == 529 then
			addToActiveSkillchain(target_id)
		end

		--Immanence and Chain Affinity usage so we can know if their next spell then opens a skillchain window
		if act.category == 6 and msg == 100 then
			if ata.param == 470 then --Chain Affinity
				local duration = 30
				active_chain_affinity = {
					[act.actor_id] = clock + duration,
				}
			elseif ata.param == 164 then --Immanence
				local duration = 60
				active_immanence = {
					[act.actor_id] = clock + duration,
				}
			end
		end

		--Spell with Immanence or Chain Affinity active
		if act.category == 4 then
			if spells[act.param] and spells[act.param].skill == 43 and active_chain_affinity[act.actor_id] then --Blue Magic
				addToActiveSkillchain(target_id)
				active_chain_affinity[act.actor_id] = nil
			elseif spells[act.param] and spells[act.param].skill == 36 and active_immanence[act.actor_id] then --Elemental Magic
				addToActiveSkillchain(target_id)
				active_immanence[act.actor_id] = nil
			end
		end

	end

	if not notifications.Damage then return end

	--Weapon Skills and Skillchains:
	if act.category == 3 and act.actor_id == player.id then
		local weapon_skill = weaponskills[act.param].english
		--Weapon Skill misses:
		if msg == 188 then
			hud_noti_shdw:text('«« '..weapon_skill..' Missed »»')
			hud_noti:text('«« '..weapon_skill..' Missed »»')
			hud_noti:color(0,255,255)
		--Weapon Skill gets blinked:
		elseif msg == 31 then
			hud_noti_shdw:text('«« '..weapon_skill..' Blinked »»')
			hud_noti:text('«« '..weapon_skill..' Blinked »»')
			hud_noti:color(0,255,255)
		--Weapon Skill lands and creates a Skillchain:
		elseif msg == 185 and ata.has_add_effect then
			hud_noti_shdw:text(weapon_skill..': '..addCommas(ata.param)..' ('..sc[ata.add_effect_animation]..': '..addCommas(ata.add_effect_param)..')')
			hud_noti:text(weapon_skill..': '..addCommas(ata.param)..' ('..sc[ata.add_effect_animation]..': '..addCommas(ata.add_effect_param)..')')
			hud_noti:color(0,255,255)
		--Weapon Skill lands but no Skillchain:
		elseif msg == 185 then
			hud_noti_shdw:text(weapon_skill..': '..addCommas(ata.param))
			hud_noti:text(weapon_skill..': '..addCommas(ata.param))
			hud_noti:color(0,255,255)
		end
		NotiCountdown = -1
	--Magic Bursts:
	elseif (act.category == 4 and msg == 252) and act.actor_id == player.id then
		local spell = spells[act.param].english
		hud_noti_shdw:text('Magic Burst! '..spell..': '..addCommas(ata.param))
		hud_noti:text('Magic Burst! '..spell..': '..addCommas(ata.param))
		hud_noti:color(0,255,255)
		NotiCountdown = -1
	end

end)

-------------------------------------------
--             FILE UNLOAD               --
-------------------------------------------

function file_unload()

	--Delete our aliases and binds, thank you for your service
	send_command('unalias mode')
	send_command('unalias hud')
	send_command('unalias dt')
	send_command('unbind '..NMBind)
	send_command('unbind '..DMBind)
	send_command('unbind '..Tier1Bind)
	send_command('unbind '..Tier2Bind)
	send_command('unbind '..Tier3Bind)
	send_command('unbind '..Tier4Bind)
	send_command('unbind '..Tier5Bind)
	send_command('unbind '..StormIIBind)
	send_command('unbind '..HelixIBind)
	send_command('unbind '..HelixIIBind)

end


--[[

Test if the enable() when losing Aftermath also works when you zone

]]
