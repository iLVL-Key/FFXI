-------------------------------------------
--Keys Gearswap lua file for Rune Fencer --
-------------------------------------------
--[[

Updates to this file and other GearSwap files and addons can be found at
https://github.com/iLVL-Key/FFXI

Place both this file and the sounds folder inside the GearSwap data folder
	/addons/GearSwap/data/sounds/
	/addons/GearSwap/data/RUN.lua

--------------------

To switch between gear modes, use any of these three options:
1. A macro
	/console mode
2. An alias command
	//mode
3. A keybind shortcut
	CTRL+G
	(Can be changed in the Advanced Options section)

--------------------

To activate the Weapon Cycle, use any of these three options:
1. A macro with the following
	/console wc
2. An alias command
	//wc
3. A keybind shortcut
	CTRL+H
	(Can be changed in the Advanced Options section)

--------------------

To use /BLU AOE spells, use a macro for Sheep Song and it will cycle through Sheep Song, Geist Wall,
Stinking Gas, Soporific, and Feather Barrier, in that order, if they are set, and as recast timers allow.

To use /BLU Single target spells, use a macro for Flash and it will cycle through Flash, Jettatura,
and Blank Gaze, in that order, as recast timers and distance allow (or if you are /WAR it will also Provoke).

--------------------

To use the Rune Activator function, use any of these options to first select an element:
1. A macro
	/console runecycle
	(this will cycle through the different elements)
	or
	/console runeearth
	/console runewater
	etc.
2. An alias command
	//runecycle
	(this will cycle through the different elements)
	or
	//runeearth
	//runewater
	etc.
	(these can also be shortened to //rcycle, //rearth, etc., as well as using earth or stone, wind or aero, etc.)
After an element is selected, use any of these options to activate a Rune of that element:
1. A macro
	/console rune
2. A alias command
	//rune

--------------------

Hide or show the HUD at any time by typing
	//hud

--------------------

IMPORTANT:
When you load this file for the first time, your HUD may not be in a good position, or may be too large.
If the HUD is not in a good position, go to the Heads Up Display options below and adjust the HUDposX and HUDposY
options, then save and reload the file. Adjust and repeat until positioned as desired.
If the HUD is too large (or small), adjust the FontSize, LineSpacer, and ColumnSpacer options as needed.
Suggested placement is center screen, just above your chat log.

-------------------------------------------
--               PRO TIPS                --
-------------------------------------------

There are 4 Modes available in this file:
Auto*-		Will decide gear based on whether or not the game thinks you are in combat. Spells will
			use their specific gear sets by themselves when you are not in combat (so you can get full
			gear bonuses), and will override them with the SIRD set if you are in combat. Will use
			idle/tank set if disengaged but in combat (ie kiting), or idle/refresh set if disengaged
			and not in combat.
Combat*-	Gear set choices will always behave as if you are in combat.
Neutral-	Gear set choices will always behave as if you are not in combat.
DPS-		Uses the DPS gear set when in combat.
*Auto and Combat have 2 submodes, Parry and DT, that are for situations when you can and cannot parry
(such as NMs that all moves are considered TP moves)

NOTE: Auto should work fine in most cases, but be aware that the game isn't always correct about when you
are in combat. For example, if you run by a mob and aggro it, you'll notice the battle music does not start.
If you are kiting a mob, and it goes yellow, the game will think you are out of combat. You can either keep
up actions on the mob to keep it claimed (voke, flash, etc) or switch into Combat mode manually.

See the very bottom of this file for /BLU spell suggestions

--]]

-------------------------------------------
--                OPTIONS                --
-------------------------------------------

Book			=	'6'		--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
SubBLUPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing BLU.
SubDRKPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing DRK.
SubWHMPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing WHM.
SubPLDPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing PLD.
SubSAMPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing SAM.
SubWARPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing WAR.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
SfoTimer		=	true	--[true/false]	Displays a timer for Elemental Sforzo in echo.
OdyTimer		=	true	--[true/false]	Displays a timer for Odyllic Subterfuge in echo.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions
							--				(Town limits this to town gear only).
AlertSounds		=	true	--[true/false]	Plays a sound on alerts.
UseEcho			=	'R'		--[E/R/Off]		Automatically uses an (E)cho Drop or (R)emedy instead of spell when you are silenced.
AutoStance		=	true	--[true/false]	Automatically activates and keeps Hasso/Seigan Stances active.

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

ShowHUD			=	true		--[true/false]  Initial state of the HUD. Use `//hud` to show/hide the HUD in game.
StartMode		=	'Auto-Parry'--[Auto-Parry/Auto-DT/Combat/Neutral/DPS]
								--	Determines the Mode you will start in. Current Mode can be changed at any time by using any
								--	of the three options listed above in the Notes section (a macro, alias, or keyboard shortcut).
DefaultRune		=	'Ignis'		--Starting Rune element for the Rune Activator function.
ModeBind		=	'^g'		--Sets the keyboard shortcut you would like to cycle between Modes. CTRL+G (^g) is default.
WCBind			=	'^h'		--Sets the keyboard shortcut you would like to activate the Weapon Cycle. CTRL+H (^h) is default.
								--    ^ = CTRL    ! = ALT    @ = WIN    # = APPS    ~ = SHIFT
AutoStanceWindow=	60			--Time in seconds left before a Stance wears off that AutoStance will activate after another ability.
LowHPThreshold	=	1000		--Below this number is considered Low HP.
DangerRepeat	=	5			--Maximum number of times the Danger Sound will repeat, once per second.
RRReminderTimer	=	1800		--Delay in seconds between checks to see if Reraise is up (300 is 5 minutes).
NotiDelay		=	6			--Delay in seconds before certain notifications will automatically clear.
PollingRate		=	5			--Times per second to check for various conditions (debuffs, ammo, etc). Higher rates use more CPU.
AddCommas		=	true		--[true/false]  Adds commas to damage numbers.

-------------------------------------------
--              HUD RECAST               --
-------------------------------------------

-- Controls what is displayed in the HUD Recast section.
-- The first column tells the file which ability/spell to place in that slot, the following are valid for use:
--		Elemental Sforzo, Odyllic Subterfuge, Aggressor, Arcane Circle, Battuta, Berserk, Cocoon, Consume Mana, Cover, Crusade, Defender, Divine Seal, Embolden, Gambit, Hasso, Holy Circle, Last Resort, Liement, Lunge, Meditate, One for All, Pflug, Phalanx, Rayke, Refueling, Seigan, Sekkanoki, Sentinel, Souleater, Stoneskin, Swipe, Swordplay, Third Eye, Valiance, Vallation, Vivacious Pulse, Warcry, Warding Circle, Weapon Bash
-- The "_sh" column allows you to change the name displayed if you would like, leave blank otherwise.
-- NOTE: Names will automatically be truncated to 10 characters to fit correctly.

sub = {
	--RUN/BLU
	BLU = {
		Abil01 = "Crusade",			Abil01_sh = "",
		Abil02 = "Phalanx",			Abil02_sh = "",
		Abil03 = "Cocoon",			Abil03_sh = "",
		Abil04 = "Battuta",			Abil04_sh = "",
		Abil05 = "Swordplay",		Abil05_sh = "",
		Abil06 = "Vivacious Pulse",	Abil06_sh = "Viv Pulse",
	},
	--RUN/DRK
	DRK = {
		Abil01 = "Crusade",			Abil01_sh = "",
		Abil02 = "Phalanx",			Abil02_sh = "",
		Abil03 = "Last Resort",		Abil03_sh = "",
		Abil04 = "Battuta",			Abil04_sh = "",
		Abil05 = "Swordplay",		Abil05_sh = "",
		Abil06 = "Vivacious Pulse",	Abil06_sh = "Viv Pulse",
	},
	--RUN/WHM
	WHM = {
		Abil01 = "Crusade",			Abil01_sh = "",
		Abil02 = "Phalanx",			Abil02_sh = "",
		Abil03 = "Embolden",		Abil03_sh = "",
		Abil04 = "Battuta",			Abil04_sh = "",
		Abil05 = "Swordplay",		Abil05_sh = "",
		Abil06 = "Vivacious Pulse",	Abil06_sh = "Viv Pulse",
	},
	--RUN/PLD
	PLD = {
		Abil01 = "Crusade",			Abil01_sh = "",
		Abil02 = "Phalanx",			Abil02_sh = "",
		Abil03 = "Sentinel",		Abil03_sh = "",
		Abil04 = "Battuta",			Abil04_sh = "",
		Abil05 = "Swordplay",		Abil05_sh = "",
		Abil06 = "Vivacious Pulse",	Abil06_sh = "Viv Pulse",
	},
	--RUN/SAM
	SAM = {
		Abil01 = "Crusade",			Abil01_sh = "",
		Abil02 = "Phalanx",			Abil02_sh = "",
		Abil03 = "Meditate",		Abil03_sh = "",
		Abil04 = "Battuta",			Abil04_sh = "",
		Abil05 = "Swordplay",		Abil05_sh = "",
		Abil06 = "Vivacious Pulse",	Abil06_sh = "Viv Pulse",
	},
	--RUN/WAR
	WAR = {
		Abil01 = "Crusade",			Abil01_sh = "",
		Abil02 = "Phalanx",			Abil02_sh = "",
		Abil03 = "Defender",		Abil03_sh = "",
		Abil04 = "Battuta",			Abil04_sh = "",
		Abil05 = "Swordplay",		Abil05_sh = "",
		Abil06 = "Vivacious Pulse",	Abil06_sh = "Viv Pulse",
	},
	--RUN/OTH
	OTH = {
		Abil01 = "Crusade",			Abil01_sh = "",
		Abil02 = "Phalanx",			Abil02_sh = "",
		Abil03 = "Embolden",		Abil03_sh = "",
		Abil04 = "Battuta",			Abil04_sh = "",
		Abil05 = "Swordplay",		Abil05_sh = "",
		Abil06 = "Vivacious Pulse",	Abil06_sh = "Viv Pulse",
	},
}

-------------------------------------------
--             COLOR VALUES              --
-------------------------------------------

color = {
	-- MODES --
	AutoParry	= {r = 125, g = 200, b = 255},
	AutoDT		= {r = 25, g = 150, b = 255},
	CombatParry	= {r = 255, g = 125, b = 125},
	CombatDT	= {r = 255, g = 125, b = 50},
	Neutral		= {r = 150, g = 255, b = 150},
	DPS			= {r = 255, g = 255, b = 125},

	-- AFTERMATH --
	AM1	= {r = 75, g = 255, b = 75},
	AM2	= {r = 0, g = 200, b = 255},
	AM3	= {r = 255, g = 255, b = 50},

	-- ELEMENTS --
	Light	= {r = 255, g = 248, b = 220},
	Fire	= {r = 255, g = 0, b = 0},
	Ice		= {r = 135, g = 206, b = 250},
	Air		= {r = 50, g = 205, b = 50},
	Earth	= {r = 250, g = 130, b = 40},
	Thunder	= {r = 186, g = 85, b = 211},
	Water	= {r = 30, g = 144, b = 255},
	Dark	= {r = 200, g = 30, b = 80},

	-- HUD RECAST --
	abil = {
		ready		= {r = 255, g = 50, b = 50},	-- Ready to use
		active		= {r = 75, g = 255, b = 75},	-- Currently active
		cooldown	= {r = 255, g = 165, b = 0},	-- On cooldown
		flash		= {r = 255, g = 255, b = 125},	-- Flash (now ready)
		notfound	= {r = 125, g = 125, b = 125}	-- Not Found
	},
}

-------------------------------------------
--                WEAPONS                --
-------------------------------------------

-- These are the Main/Sub combos that the Weapon Cycle goes through. Add more pairs on new lines as needed
-- NOTE: if a slot should be empty, use `empty` with no quotation marks. ie: {"Fruit Punches", empty},
WeaponCycle = {
	{"Epeolatry", "Balarama Grip"},
	{"Lionheart", "Utu Grip"},
	{"Lycurgos", "Utu Grip"},
	--{"Main Slot", "Sub Slot"},
}

-- These are the Main/Sub combos that get added to the Weapon Cycle while in Abyssea for Procs. Add more pairs on new lines as needed
-- NOTE: if a slot should be empty, use `empty` with no quotation marks. ie: {"Fruit Punches", empty},
AbysseaProcCycle = {
	{"Excalipoor II", "Chanter's Shield"},
	{"Chocobo Wand", "Chanter's Shield"},
	{"Hapy Staff", "Flanged Grip"},
	--{"Main Slot", "Sub Slot"},
}

-------------------------------------------
--               GEAR SETS               --
-------------------------------------------

function get_sets()

-- Tank Parry (Parry, Damage Taken-, Magic Evasion, Multi-Attack, Accuracy, DEX)
-- This is the main Tank set for most things. Focus on parry first (for the Turms Gloves you have, right?) then DT- and others.
sets.tank_parry = {
	ammo="Staunch Tathlum +1",
	head="Nyame Helm",
	body="Erilaz Surcoat +3",
	hands="Turms Mittens +1",
	legs="Eri. Leg Guards +3",
	feet="Erilaz Greaves +3",
	neck="Unmoving Collar +1",
	waist="Plat. Mog. Belt",
	left_ear="Eabani Earring",
	right_ear="Erilaz Earring +2",
	left_ring="Moonlight Ring",
	right_ring="Vengeful Ring",
	back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Parrying rate+5%',}},
}

-- Tank DT (Damage Taken-, Magic Evasion, Multi-Attack, Accuracy, DEX)
-- This is for certain mobs or times that you cannot parry. Focus on DT- first, then fill in DPS gear around that.
sets.tank_dt = {
	ammo="Staunch Tathlum +1",
	head="Erilaz Galea +3",
	body="Erilaz Surcoat +3",
	hands="Erilaz Gauntlets +3",
	legs="Eri. Leg Guards +3",
	feet="Erilaz Greaves +3",
	neck="Unmoving Collar +1",
	waist="Plat. Mog. Belt",
	left_ear="Eabani Earring",
	right_ear="Erilaz Earring +2",
	left_ring="Moonlight Ring",
	right_ring="Vengeful Ring",
	back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Parrying rate+5%',}},
}

--DPS 
sets.dps = {
	ammo="Coiste Bodhar",
	head="Nyame Helm",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Null Loop",
	waist="Ioskeha Belt +1",
	left_ear="Cessance Earring",
	right_ear="Sherida Earring",
	left_ring="Epona's Ring",
	right_ring="Niqmaddu Ring",
	back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Parrying rate+5%',}},
}

-- Oh Shit
-- Full DT- and everything you've got with Absorbs or Annuls Damage
sets.oh_shit = {
	head="Erilaz Galea +3",
	body="Erilaz Surcoat +3",
	hands="Turms Mittens +1",
	legs="Eri. Leg Guards +3",
	feet="Erilaz Greaves +3",
	neck="Warder's Charm +1",
	left_ear="Alabaster Earring",
	left_ring="Shadow Ring",
	right_ring="Defending Ring",
	back="Shadow Mantle",
}

-- Idle (only need Refresh gear in here, combines with other sets based on situation)
sets.idle = {
	ammo="Homiliary",
	head="Null Masque",
	body="Agwu's Robe",
	hands="Regal Gauntlets",
	feet={ name="Herculean Boots", augments={'Pet: "Regen"+2','VIT+1','"Refresh"+2','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
	neck="Loricate Torque +1",
	waist="Plat. Mog. Belt",
	left_ear="Alabaster Earring",
	right_ear="Erilaz Earring +2",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back="Moonlight Cape",
}

-- Movement speed
-- Combines with other sets based on current mode
sets.movementspeed = {
	legs="Carmine Cuisses +1",
}

-- Enmity (full Enmity+ for spells/abilities)
sets.enmity = {
	ammo="Sapience Orb",
	legs="Eri. Leg Guards +3",
	feet="Erilaz Greaves +3",
	neck="Moonlight Necklace",
	left_ear="Cryptic Earring",
	right_ear="Friomisi Earring",
	left_ring="Petrov Ring",
	right_ring="Vengeful Ring",
	back="Moonlight Cape",
}

-- Rest
sets.rest = {
	waist="Austerity Belt",
}

-- Fast Cast (cap is 80%)
sets.fast_cast = {
	ammo="Sapience Orb", --2
	head="Runeist Bandeau +4", --14
	body="Erilaz Surcoat +3", --13
	hands="Agwu's Gages", --6
	legs="Agwu's Slops", --7
	feet="Carmine Greaves +1", --8
	neck="Baetyl Pendant", --4
	waist="Plat. Mog. Belt",
	left_ear="Loquac. Earring", --2
	right_ear="Odnowa Earring +1",
	left_ring="Gelatinous Ring +1",
	right_ring="Kishar Ring", --4
	back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Spell interruption rate down-10%',}}, --10
}

-- Snapshot
-- For ranged attacks when you need to pull without aggroing via magic
sets.snapshot = {

}

-- Spell Interruption Rate Down (Need 102% for actual 100% cap, don't forget about 10% from merits)
-- NOTE: This set gets combined with (and overwrites) the next 5 sets (Healing through Enhancing) based on Mode and whether or not you are in combat
sets.sird = {
	ammo="Staunch Tathlum +1",		--11
	head="Erilaz Galea +3",			--20
	hands="Rawhide Gloves",			--15
	legs="Carmine Cuisses +1",		--20
	neck="Moonlight Necklace",		--15
	left_ring="Evanescence Ring",	--5
	back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Spell interruption rate down-10%',}}, --10
}

-- Healing (Cure Potency (50% cap), Potency of Cure effect received (30% cap))
sets.healing = {
	body="Nyame Mail",
	hands="Agwu's Gages",			--		10CR
	neck="Phalaina Locket",			--4CP	4CR
	waist="Sroda Belt",				--35CP
	right_ear="Mendi. Earring",		--5CP
	back="Moonlight Cape",
}

-- Enmity Spells (Fast Cast, will not be used to cast faster but instead to help reduce recast)
-- Combines with Enmity set
-- Flash, Foil, BLU spells use this.
sets.enmityspells = set_combine(sets.enmity, {
	head="Carmine Mask +1",
	feet="Carmine Greaves +1",
})


-- Regen (Regen+, Enhancing Magic Duration)
sets.regen = {
	head="Runeist Bandeau +4",
	hands="Regal Gauntlets",
	right_ear="Erilaz Earring +2",
}

-- Enhancing Magic (Enhancing Magic Duration, Enhancing Magic Skill)
-- Crusade, Aquaveil, Temper, Protect, Shell, and Spikes uses this.
sets.enhancing = {
	head="Erilaz Galea +3",
	hands="Regal Gauntlets",
	legs="Carmine Cuisses +1",
	feet="Futhark Trousers +3",
	neck="Incanter's Torque",
	left_ear="Mimir Earring",
	right_ear="Andoaa Earring",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
}

-- Phalanx (Phalanx, Enhancing Magic Duration)
sets.phalanx = set_combine(sets.enhancing, {
	head="Fu. Bandeau +4",
	body="Herculean Vest",
	hands={ name="Herculean Gloves", augments={'INT+3','Crit.hit rate+2','Phalanx +3','Accuracy+12 Attack+12',}},
	legs="Herculean Trousers",
	feet={ name="Herculean Boots", augments={'Pet: STR+9','Accuracy+18','Phalanx +3','Accuracy+19 Attack+19',}},
})

-- Refresh Spell (Refresh potency, Enhancing Magic Duration)
sets.refresh = {
	head="Erilaz Galea +3",
	hands="Regal Gauntlets",
	feet="Futhark Trousers +3",
	waist="Gishdubar Sash",
}

-- Holy Water (Holy Water+)
sets.holy_water = {
	neck="Nicander's Necklace",
	ring1="Blenmot's Ring +1",
	ring2="Blenmot's Ring +1",
}

-- Weapon Skill - Basic (STR, Weapon Skill Damage, Attack, Double/Triple Attack)
sets.weapon_skill = {
	ammo="Knobkierrie",
	head="Nyame Helm",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Rep. Plat. Medal",
	waist="Sailfi Belt +1",
	left_ear="Ishvara Earring",
	right_ear="Moonshade Earring",
	left_ring="Cornelia's Ring",
	right_ring="Karieyh Ring +1",
	back={ name="Ogma's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Mag. Evasion+15',}},
}

-- Weapon Skill Accuracy - (Weapon Skill Accuracy, Accuracy)
-- Combines with other Weapon Skill sets, only necessary to set the slots with specific desired stats
sets.weapons_skill_accuracy = {
	ammo="Amar Cluster",
	head="Erilaz Galea +3",
	body="Erilaz Surcoat +3",
	hands="Erilaz Gauntlets +3",
	legs="Eri. Leg Guards +3",
	feet="Erilaz Greaves +3",
	neck="Null Loop",
	waist="Null Belt",
	left_ear="Odr Earring",
	right_ear={ name="Erilaz Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+20','Mag. Acc.+20','Damage taken-8%','STR+15 MND+15',}},
	back="Null Shawl",
}

-- Dimidiation (80% DEX mod, 2-hit)
-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
sets["Dimidiation"] = set_combine(sets.weapon_skill, {
	ammo="Coiste Bodhar",
	neck="Fotia Gorget",
	waist="Sailfi Belt +1",
	left_ear="Sherida Earring",
	right_ear="Moonshade Earring",
	left_ring="Regal Ring",
	right_ring="Niqmaddu Ring",
})

-- Resolution (73~85% STR mod, 5-hit)
-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
sets["Resolution"] = set_combine(sets.weapon_skill, {
	ammo="Coiste Bodhar",
	neck="Fotia Gorget",
	waist="Fotia Belt",
	left_ear="Sherida Earring",
	right_ear="Moonshade Earring",
	left_ring="Epona's Ring",
	right_ring="Niqmaddu Ring",
})

-- Fimbulvetr (60% STR, 60% VIT mod)
-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
sets["Fimbulvetr"] = set_combine(sets.weapon_skill, {

})

-- Elemental Sforzo
sets.elemental_sforzo = {
	body="Futhark Coat +3",
}

-- Valiance and Vallation (Enhances Valiance and Vallation gear)
sets.valiance = set_combine(sets.enmity, {
	body="Runeist Coat +3",
})

-- Swordplay (Enhances Swordplay gear)
sets.swordplay = set_combine(sets.enmity, {
	hands="Futhark Mitons +3",
})

-- Swipe and Lunge (Magic Attack Bonus)
sets.swipe = set_combine(sets.enmity, {
	ammo="Pemphredo Tathlum",
	head="Agwu's Cap",
	body="Agwu's Robe",
	hands="Agwu's Gages",
	legs="Agwu's Slops",
	feet="Agwu's Pigaches",
	neck="Baetyl Pendant",
	waist="Orpheus's Sash",
	left_ear="Friomisi Earring",
	right_ear="Halasz Earring",
	left_ring="Moonlight Ring",
	right_ring="Shiva Ring +1",
	back={ name="Ogma's Cape", augments={'HP+60','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
})

-- Embolden (Enhances Embolden gear)
sets.embolden = set_combine(sets.enmity, {
	back="Evasionist's Cape",
})

-- Vivacious Pulse (Enhances Vivacious Pulse gear, Divine skill)
sets.pulse = set_combine(sets.enmity, {
	head="Erilaz Galea +3",
})

-- Gambit (Enhances Gambit gear)
sets.gambit = set_combine(sets.enmity, {
	hands="Runeist Mitons +4",
})

-- Battuta (Enhances Battuta gear)
sets.battuta = set_combine(sets.enmity, {
	head="Fu. Bandeau +4",
})

-- Rayke (Enhances Rayke gear)
sets.rayke = set_combine(sets.enmity, {
	feet="Futhark Boots",
})

-- Liement (Enhances Liement gear)
sets.liement = set_combine(sets.enmity, {
	body="Futhark Coat +3",
})

-- One For All (HP+)
sets.one_for_all = set_combine(sets.enmity, {

})

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
	body="Sylvie Unity Shirt",
}

end




	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX          DO NOT EDIT BELOW THIS LINE          XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--




FileVersion = '10.0'

-------------------------------------------
--             AREA MAPPING              --
-------------------------------------------

AdoulinZones = S{
	'Western Adoulin','Eastern Adoulin','Celennia Memorial Library','Silver Knife'
	}

BastokZones = S{
	'Bastok Markets','Bastok Mines','Metalworks','Port Bastok'
	}

SandyZones = S{
	'Chateau d\'Oraguille','Northern San d\'Oria','Port San d\'Oria','Southern San d\'Oria'
	}

WindyZones = S{
	'Heavens Tower','Port Windurst','Windurst Walls','Windurst Waters','Windurst Woods'
	}

TownZones = S{
	'Western Adoulin','Eastern Adoulin','Celennia Memorial Library','Silver Knife','Bastok Markets','Bastok Mines','Metalworks','Port Bastok','Chateau d\'Oraguille','Northern San d\'Oria','Port San d\'Oria','Southern San d\'Oria','Heavens Tower','Port Windurst','Windurst Walls','Windurst Waters','Windurst Woods','Lower Jeuno','Port Jeuno','Ru\'Lude Gardens','Upper Jeuno','Aht Urhgan Whitegate','The Colosseum','Tavnazian Safehold','Southern San d\'Oria [S]','Bastok Markets [S]','Windurst Waters [S]','Mhaura','Selbina','Rabao','Kazham','Norg','Nashmau','Mog Garden','Leafallia','Chocobo Circuit'
	}

-------------------------------------------
--              FILE LOAD                --
-------------------------------------------

sc = {} sc[1] = 'Lght' sc[2] = 'Drkn' sc[3] = 'Grvt' sc[4] = 'Frgm' sc[5] = 'Dstn' sc[6] = 'Fusn' sc[7] = 'Cmpr' sc[8] = 'Lqfn' sc[9] = 'Indr' sc[10] = 'Rvrb' sc[11] = 'Trns' sc[12] = 'Scsn' sc[13] = 'Detn' sc[14] = 'Impc' sc[15] = 'Rdnc' sc[16] = 'Umbr'
fMode = {} fMode['Auto-Parry'] = 'AutoParry' fMode['Auto-DT'] = 'AutoDT' fMode['Combat-Parry'] = 'CombatParry' fMode['Combat-DT'] = 'CombatDT' fMode['Neutral'] = 'Neutral' fMode['DPS'] = 'DPS'
--debuffs table used so we're not spamming the Debuff Notifications with text updates (when they get flipped to true it stops updating)
debuffs = {Amnesia = false, Animated = false, Charm = false, Curse = false, Doom = false, Encumbrance = false, Haunt = false, Mute = false, None = false, Paralysis = false, Petrification = false, Plague = false, Silence = false, Sleep = false, Stun = false, Taint = false, Terror = false, Zombie = false}
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
items = res.items
RuneElement = DefaultRune
RuneCycleDisplay = false
Rune1 = 'No Rune'
Rune2 = 'No Rune'
Rune3 = 'No Rune'
Rune1Timer = 0
Rune2Timer = 0
Rune3Timer = 0
Rune1BGColor = '0 0 0'
Rune2BGColor = '0 0 0'
Rune3BGColor = '0 0 0'
Mode = StartMode --sets the starting mode (selected in the Options)
NotiLowMPToggle = false --start with the toggle off for the Low MP Notification so that it can trigger
Stance = 'None' --Start off without Hasso/Seigan up, this will update when either is activated
RRRCountdown = RRReminderTimer
HUDposYLine1 = HUDposY
last_poll = 0 --keeps the timing for things that happen at the polling rate
last_second = 0 --keeps the timing for things that happen every second
GreetingDelay = 6 --delay to display greeting and file version info
Zoning = false --flips automatically to hide the HUD while zoning
InCS = false --flips automatically to hide the HUD while in a cs
StanceTimer = 0
LowHP = false
Alive = true --makes it easier to Do Things or Not Do Things based on if we die.
announceAlive = false --simple flip when we raise to make sure the AliveDelay command and notification text is only done once
DangerCountdown = 0
NotiCountdown = -1 --we set the countdown below 0 to stop the countdown from hitting 0 and triggering the ClearNotifications command
WeaponCycleIndex = 1 --used to cycle through the WeaponCycle sets
EquipMain = 'Weapons loading...'
EquipSub = ''
SwitchingWeapons = 0 --used to delay the Aftermath checks so the Weapon Cycler cycling can be displayed faster in the HUD
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
active_buffs = {}

local play_sound = windower.play_sound
local addon_path = windower.addon_path
local Notification_Good = addon_path..'data/sounds/NotiGood.wav'
local Notification_Bad = addon_path..'data/sounds/NotiBad.wav'
local Notification_Danger = addon_path..'data/sounds/Danger.wav'
local Notification_Cancel = addon_path..'data/sounds/Cancel.wav'
local Notification_Aftermath_On = addon_path..'data/sounds/AftermathOn.wav'
local Notification_Aftermath_Off = addon_path..'data/sounds/AftermathOff.wav'
local Notification_3000TP = addon_path..'data/sounds/3000TP.wav'

--create a new table that combines both the WeaponCycle and AbysseaProcCycle weapons into one table to be used while inside Abyssea
local WeaponCyclePlusAbyssea = {}
for _, v in ipairs(WeaponCycle) do
    table.insert(WeaponCyclePlusAbyssea, {v[1], v[2]})
end
for _, v in ipairs(AbysseaProcCycle) do
    table.insert(WeaponCyclePlusAbyssea, {v[1], v[2]})
end

--sets the intial combat state
if windower.ffxi.get_player() and windower.ffxi.get_player().in_combat then
	player_in_combat = true
else
	player_in_combat = false
end

-- Sets the inital subjob
local subjob = 'OTH'
if player.sub_job == 'BLU' then
	subjob = 'BLU'
elseif player.sub_job == 'DRK' then
	subjob = 'DRK'
elseif player.sub_job == 'WHM' then
	subjob = 'WHM'
elseif player.sub_job == 'PLD' then
	subjob = 'PLD'
elseif player.sub_job == 'SAM' then
	subjob = 'SAM'
elseif player.sub_job == 'WAR' then
	subjob = 'WAR'
end

-- Sets the Chat Mode
if Chat ~= "Off" then
	send_command('input /cm '..Chat)
end

-- Sets the Macro Book and Page
if Book ~= "Off" then
	send_command('input /macro book '..Book)
end
if SubBLUPage ~= "Off" and player.sub_job == 'BLU' then
	send_command('wait 2;input /macro set '..SubBLUPage)
elseif SubDRKPage ~= "Off" and player.sub_job == 'DRK' then
	send_command('wait 2;input /macro set '..SubDRKPage)
elseif SubWHMPage ~= "Off" and player.sub_job == 'WHM' then
	send_command('wait 2;input /macro set '..SubWHMPage)
elseif SubPLDPage ~= "Off" and player.sub_job == 'PLD' then
	send_command('wait 2;input /macro set '..SubPLDPage)
elseif SubSAMPage ~= "Off" and player.sub_job == 'SAM' then
	send_command('wait 2;input /macro set '..SubSAMPage)
elseif SubWARPage ~= "Off" and player.sub_job == 'WAR' then
	send_command('wait 2;input /macro set '..SubWARPage)
else
	send_command('wait 2;input /macro set 1')
end

if ZoneGear ~= 'Off' then
	send_command('wait 2;gs c Zone Gear')
end

ElementalSforzo = {} OdyllicSubterfuge = {} Aggressor = {} ArcaneCircle = {} Battuta = {} Berserk = {} Cocoon = {} ConsumeMana = {} Cover = {} Crusade = {} Defender = {} DivineSeal = {} Embolden = {} Gambit = {} Hasso = {} HolyCircle = {} LastResort = {} Liement = {} Lunge = {} Meditate = {} OneforAll = {} Pflug = {} Phalanx = {} Rayke = {} Refueling = {} Seigan = {} Sekkanoki = {} Sentinel = {} Souleater = {} Stoneskin = {} Swipe = {} Swordplay = {} ThirdEye = {} Valiance = {} Vallation = {} VivaciousPulse = {} Warcry = {} WardingCircle = {} WeaponBash = {}

--Start true so the HUD recasts don't flash on load
ElementalSforzo.flashed = true
OdyllicSubterfuge.flashed = true
Aggressor.flashed = true
ArcaneCircle.flashed = true
Battuta.flashed = true
Berserk.flashed = true
Cocoon.flashed = true
ConsumeMana.flashed = true
Cover.flashed = true
Crusade.flashed = true
Defender.flashed = true
DivineSeal.flashed = true
Embolden.flashed = true
Gambit.flashed = true
Hasso.flashed = true
HolyCircle.flashed = true
LastResort.flashed = true
Liement.flashed = true
Lunge.flashed = true
Meditate.flashed = true
OneforAll.flashed = true
Pflug.flashed = true
Phalanx.flashed = true
Rayke.flashed = true
Seigan.flashed = true
Sekkanoki.flashed = true
Sentinel.flashed = true
Souleater.flashed = true
Stoneskin.flashed = true
Swipe.flashed = true
Swordplay.flashed = true
ThirdEye.flashed = true
Valiance.flashed = true
Vallation.flashed = true
VivaciousPulse.flashed = true
Warcry.flashed = true
WardingCircle.flashed = true
WeaponBash.flashed = true

--Space out each line and column properly
HUDposYLine2 = HUDposYLine1 + LineSpacer --Note that Line 1 is the bottom line, additional line numbers move upward on the screen
HUDposYLine3 = HUDposYLine2 + LineSpacer
HUDposYLine4 = HUDposYLine3 + LineSpacer
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

-- Create the HUD BG Color text object
local hud_bg_color = texts.new(hud_bg_str..'\n'..hud_bg_str..'\n'..hud_bg_str..'\n'..hud_bg_str)
hud_bg_color:font('Consolas')
hud_bg_color:size(FontSize)
hud_bg_color:bg_alpha(100)
hud_bg_color:pos(HUDposXColumn1,HUDposYLine1)
hud_bg_color:draggable(false)

-- Create the HUD Background text object
local hud_bg = texts.new(hud_bg_str..'\n'..hud_bg_str..'\n'..hud_bg_str..'\n'..hud_bg_str)
hud_bg:font("Consolas")
hud_bg:size(FontSize)
hud_bg:bg_alpha(170)
hud_bg:pos(HUDposXColumn1,HUDposYLine1)
hud_bg:draggable(false)

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

-- Create the HUD Rune01 BG text object
local hud_rune01_bg = texts.new('                        ')
hud_rune01_bg:font("Consolas")
hud_rune01_bg:size(FontSize)
hud_rune01_bg:pad(-1)
hud_rune01_bg:bg_alpha(0)
hud_rune01_bg:pos(HUDposXColumn1+.5,HUDposYLine3)
hud_rune01_bg:draggable(false)
hud_rune01_bg:bold(true)

-- Create the HUD Rune02 BG text object
local hud_rune02_bg = texts.new('                        ')
hud_rune02_bg:font("Consolas")
hud_rune02_bg:size(FontSize)
hud_rune02_bg:pad(-1)
hud_rune02_bg:bg_alpha(0)
hud_rune02_bg:pos(HUDposXColumn3+1,HUDposYLine3)
hud_rune02_bg:draggable(false)
hud_rune02_bg:bold(true)

-- Create the HUD Rune03 BG text object
local hud_rune03_bg = texts.new('                        ')
hud_rune03_bg:font("Consolas")
hud_rune03_bg:size(FontSize)
hud_rune03_bg:pad(-1)
hud_rune03_bg:bg_alpha(0)
hud_rune03_bg:pos(HUDposXColumn5+1,HUDposYLine3)
hud_rune03_bg:draggable(false)
hud_rune03_bg:bold(true)

-- Create the HUD Abil01 BG text object
local hud_abil01_bg = texts.new('            ')
hud_abil01_bg:font("Consolas")
hud_abil01_bg:size(FontSize)
hud_abil01_bg:bg_alpha(0)
hud_abil01_bg:pos(HUDposXColumn1,HUDposYLine4)
hud_abil01_bg:draggable(false)
hud_abil01_bg:bold(true)

-- Create the HUD Abil02 BG text object
local hud_abil02_bg = texts.new('            ')
hud_abil02_bg:font("Consolas")
hud_abil02_bg:size(FontSize)
hud_abil02_bg:bg_alpha(0)
hud_abil02_bg:pos(HUDposXColumn2,HUDposYLine4)
hud_abil02_bg:draggable(false)
hud_abil02_bg:bold(true)

-- Create the HUD Abil03 BG text object
local hud_abil03_bg = texts.new('            ')
hud_abil03_bg:font("Consolas")
hud_abil03_bg:size(FontSize)
hud_abil03_bg:bg_alpha(0)
hud_abil03_bg:pos(HUDposXColumn3,HUDposYLine4)
hud_abil03_bg:draggable(false)
hud_abil03_bg:bold(true)

-- Create the HUD Abil04 BG text object
local hud_abil04_bg = texts.new('            ')
hud_abil04_bg:font("Consolas")
hud_abil04_bg:size(FontSize)
hud_abil04_bg:bg_alpha(0)
hud_abil04_bg:pos(HUDposXColumn4,HUDposYLine4)
hud_abil04_bg:draggable(false)
hud_abil04_bg:bold(true)

-- Create the HUD Abil05 BG text object
local hud_abil05_bg = texts.new('            ')
hud_abil05_bg:font("Consolas")
hud_abil05_bg:size(FontSize)
hud_abil05_bg:bg_alpha(0)
hud_abil05_bg:pos(HUDposXColumn5,HUDposYLine4)
hud_abil05_bg:draggable(false)
hud_abil05_bg:bold(true)

-- Create the HUD Abil06 BG text object
local hud_abil06_bg = texts.new('            ')
hud_abil06_bg:font("Consolas")
hud_abil06_bg:size(FontSize)
hud_abil06_bg:bg_alpha(0)
hud_abil06_bg:pos(HUDposXColumn6,HUDposYLine4)
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

-- Create the HUD Mode Text Shadow text object
local hud_mode_shdw = texts.new('Mode: '..Mode)
hud_mode_shdw:color(0,0,0)
hud_mode_shdw:font("Consolas")
hud_mode_shdw:size(FontSize)
hud_mode_shdw:bg_alpha(0)
hud_mode_shdw:pos(HUDposXColumn1+2.5,HUDposYLine2+0.5)
hud_mode_shdw:draggable(false)
hud_mode_shdw:bold(true)

-- Create the HUD Notifications Text Shadow text object
local hud_noti_shdw = texts.new('Keys RUN Gearswap file v'..FileVersion)
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

-- Create the HUD Rune01 Text Shadow text object
local hud_rune01_shdw = texts.new()
hud_rune01_shdw:color(0,0,0)
hud_rune01_shdw:font("Consolas")
hud_rune01_shdw:size(FontSize)
hud_rune01_shdw:pad(-0.5)
hud_rune01_shdw:bg_alpha(0)
hud_rune01_shdw:pos(HUDposXColumn1+1.5,HUDposYLine3+0.5)
hud_rune01_shdw:draggable(false)
hud_rune01_shdw:bold(true)

-- Create the HUD Rune02 Text Shadow text object
local hud_rune02_shdw = texts.new()
hud_rune02_shdw:color(0,0,0)
hud_rune02_shdw:font("Consolas")
hud_rune02_shdw:size(FontSize)
hud_rune02_shdw:pad(-0.5)
hud_rune02_shdw:bg_alpha(0)
hud_rune02_shdw:pos(HUDposXColumn3+1.5,HUDposYLine3+0.5)
hud_rune02_shdw:draggable(false)
hud_rune02_shdw:bold(true)

-- Create the HUD Rune03 Text Shadow text object
local hud_rune03_shdw = texts.new()
hud_rune03_shdw:color(0,0,0)
hud_rune03_shdw:font("Consolas")
hud_rune03_shdw:size(FontSize)
hud_rune03_shdw:pad(-0.5)
hud_rune03_shdw:bg_alpha(0)
hud_rune03_shdw:pos(HUDposXColumn5+1.5,HUDposYLine3+0.5)
hud_rune03_shdw:draggable(false)
hud_rune03_shdw:bold(true)

-- Create the HUD Abil01 Text Shadow text object
local hud_abil01_shdw = texts.new()
hud_abil01_shdw:color(0,0,0)
hud_abil01_shdw:font("Consolas")
hud_abil01_shdw:size(FontSize)
hud_abil01_shdw:bg_alpha(0)
hud_abil01_shdw:pos(HUDposXColumn1+1.5,HUDposYLine4+0.5)
hud_abil01_shdw:draggable(false)
hud_abil01_shdw:bold(true)

-- Create the HUD Abil02 Text Shadow text object
local hud_abil02_shdw = texts.new()
hud_abil02_shdw:color(0,0,0)
hud_abil02_shdw:font("Consolas")
hud_abil02_shdw:size(FontSize)
hud_abil02_shdw:bg_alpha(0)
hud_abil02_shdw:pos(HUDposXColumn2+1.5,HUDposYLine4+0.5)
hud_abil02_shdw:draggable(false)
hud_abil02_shdw:bold(true)

-- Create the HUD Abil03 Text Shadow text object
local hud_abil03_shdw = texts.new()
hud_abil03_shdw:color(0,0,0)
hud_abil03_shdw:font("Consolas")
hud_abil03_shdw:size(FontSize)
hud_abil03_shdw:bg_alpha(0)
hud_abil03_shdw:pos(HUDposXColumn3+1.5,HUDposYLine4+0.5)
hud_abil03_shdw:draggable(false)
hud_abil03_shdw:bold(true)

-- Create the HUD Abil04 Text Shadow text object
local hud_abil04_shdw = texts.new()
hud_abil04_shdw:color(0,0,0)
hud_abil04_shdw:font("Consolas")
hud_abil04_shdw:size(FontSize)
hud_abil04_shdw:bg_alpha(0)
hud_abil04_shdw:pos(HUDposXColumn4+1.5,HUDposYLine4+0.5)
hud_abil04_shdw:draggable(false)
hud_abil04_shdw:bold(true)

-- Create the HUD Abil05 Text Shadow text object
local hud_abil05_shdw = texts.new()
hud_abil05_shdw:color(0,0,0)
hud_abil05_shdw:font("Consolas")
hud_abil05_shdw:size(FontSize)
hud_abil05_shdw:bg_alpha(0)
hud_abil05_shdw:pos(HUDposXColumn5+1.5,HUDposYLine4+0.5)
hud_abil05_shdw:draggable(false)
hud_abil05_shdw:bold(true)

-- Create the HUD Abil06 Text Shadow text object
local hud_abil06_shdw = texts.new()
hud_abil06_shdw:color(0,0,0)
hud_abil06_shdw:font("Consolas")
hud_abil06_shdw:size(FontSize)
hud_abil06_shdw:bg_alpha(0)
hud_abil06_shdw:pos(HUDposXColumn6+1.5,HUDposYLine4+0.5)
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

-- Create the HUD Mode text object
local hud_mode = texts.new('Mode: '..Mode)
hud_mode:font("Consolas")
hud_mode:size(FontSize)
hud_mode:bg_alpha(0)
hud_mode:pos(HUDposXColumn1+1,HUDposYLine2-1)
hud_mode:draggable(false)
hud_mode:bold(true)

local c = color[fMode[Mode]]
hud_mode:color(c.r,c.g,c.b)
hud_bg_color:bg_color(c.r,c.g,c.b)

-- Create the HUD Notifications text object
local hud_noti = texts.new('Keys RUN Gearswap file v'..FileVersion)
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

-- Create the HUD Rune01 text object
local hud_rune01 = texts.new()
hud_rune01:font("Consolas")
hud_rune01:size(FontSize)
hud_rune01:pad(-0.5)
hud_rune01:bg_alpha(0)
hud_rune01:pos(HUDposXColumn1,HUDposYLine3-1)
hud_rune01:draggable(false)
hud_rune01:bold(true)

-- Create the HUD Rune02 text object
local hud_rune02 = texts.new()
hud_rune02:font("Consolas")
hud_rune02:size(FontSize)
hud_rune02:pad(-0.5)
hud_rune02:bg_alpha(0)
hud_rune02:pos(HUDposXColumn3,HUDposYLine3-1)
hud_rune02:draggable(false)
hud_rune02:bold(true)

-- Create the HUD Rune03 text object
local hud_rune03 = texts.new()
hud_rune03:font("Consolas")
hud_rune03:size(FontSize)
hud_rune03:pad(-0.5)
hud_rune03:bg_alpha(0)
hud_rune03:pos(HUDposXColumn5,HUDposYLine3-1)
hud_rune03:draggable(false)
hud_rune03:bold(true)

-- Create the HUD Abil01 text object
local hud_abil01 = texts.new()
hud_abil01:font("Consolas")
hud_abil01:size(FontSize)
hud_abil01:bg_alpha(0)
hud_abil01:pos(HUDposXColumn1,HUDposYLine4-1)
hud_abil01:draggable(false)
hud_abil01:bold(true)

-- Create the HUD Abil02 text object
local hud_abil02 = texts.new()
hud_abil02:font("Consolas")
hud_abil02:size(FontSize)
hud_abil02:bg_alpha(0)
hud_abil02:pos(HUDposXColumn2,HUDposYLine4-1)
hud_abil02:draggable(false)
hud_abil02:bold(true)

-- Create the HUD Abil03 text object
local hud_abil03 = texts.new()
hud_abil03:font("Consolas")
hud_abil03:size(FontSize)
hud_abil03:bg_alpha(0)
hud_abil03:pos(HUDposXColumn3,HUDposYLine4-1)
hud_abil03:draggable(false)
hud_abil03:bold(true)

-- Create the HUD Abil04 text object
local hud_abil04 = texts.new()
hud_abil04:font("Consolas")
hud_abil04:size(FontSize)
hud_abil04:bg_alpha(0)
hud_abil04:pos(HUDposXColumn4,HUDposYLine4-1)
hud_abil04:draggable(false)
hud_abil04:bold(true)

-- Create the HUD Abil05 text object
local hud_abil05 = texts.new()
hud_abil05:font("Consolas")
hud_abil05:size(FontSize)
hud_abil05:bg_alpha(0)
hud_abil05:pos(HUDposXColumn5,HUDposYLine4-1)
hud_abil05:draggable(false)
hud_abil05:bold(true)

-- Create the HUD Abil06 text object
local hud_abil06 = texts.new()
hud_abil06:font("Consolas")
hud_abil06:size(FontSize)
hud_abil06:bg_alpha(0)
hud_abil06:pos(HUDposXColumn6,HUDposYLine4-1)
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
	hud_rune01_bg:show()
	hud_rune02_bg:show()
	hud_rune03_bg:show()
	hud_abil01_bg:show()
	hud_abil02_bg:show()
	hud_abil03_bg:show()
	hud_abil04_bg:show()
	hud_abil05_bg:show()
	hud_abil06_bg:show()
	hud_weapons_shdw:show()
	hud_mode_shdw:show()
	hud_noti_shdw:show()
	hud_debuffs_shdw:show()
	hud_rune01_shdw:show()
	hud_rune02_shdw:show()
	hud_rune03_shdw:show()
	hud_abil01_shdw:show()
	hud_abil02_shdw:show()
	hud_abil03_shdw:show()
	hud_abil04_shdw:show()
	hud_abil05_shdw:show()
	hud_abil06_shdw:show()
	hud_weapons:show()
	hud_mode:show()
	hud_noti:show()
	hud_debuffs:show()
	hud_rune01_bg:show()
	hud_rune02_bg:show()
	hud_rune03_bg:show()
	hud_rune01:show()
	hud_rune02:show()
	hud_rune03:show()
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

send_command('alias runecycle gs c RuneCycle')
send_command('alias runestone gs c RuneStone')
send_command('alias runeearth gs c RuneStone')
send_command('alias runewater gs c RuneWater')
send_command('alias runeaero gs c RuneAero')
send_command('alias runewind gs c RuneAero')
send_command('alias runefire gs c RuneFire')
send_command('alias runeblizzard gs c RuneBlizzard')
send_command('alias runeice gs c RuneBlizzard')
send_command('alias runethunder gs c RuneThunder')
send_command('alias runelightning gs c RuneThunder')
send_command('alias runedark gs c RuneDark')
send_command('alias runelight gs c RuneLight')
send_command('alias rune gs c Rune')
send_command('alias mode gs c Mode') --creates the Mode alias
send_command('alias wc gs c WC') --creates the Weapon Cycle alias
send_command('alias hud gs c HUD') --creates the HUD alias
send_command('bind '..ModeBind..' gs c Mode') --creates the gear mode keyboard shortcut
send_command('bind '..WCBind..' gs c WC') --creates the Weapon Cycle keyboard shortcut

-------------------------------------------
--           CUSTOM FUNCTIONS            --
-------------------------------------------

--Add commas to numbers to make them easier to read
function addCommas(number)
	--Convert the number to a string
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

	--Return the number (albeit as a string, we're not doing any math on it at this point)
    return formattedNumber
end

--Check if the equipped Main/Sub pair are in our defined AbysseaProcCycle weapons table
function checkProcWeapons(mainSlot, subSlot)

	for _, equipmentPair in pairs(AbysseaProcCycle) do

		if equipmentPair[1] == mainSlot and equipmentPair[2] == subSlot then
			return true

		end
	end

	return false

end

--Are we using a two handed weapon?
function twoHanded()

	local weapon = player.equipment.main and items:with('name', player.equipment.main)

	return weapon and (weapon.skill == 4 or weapon.skill == 6 or weapon.skill == 7 or weapon.skill == 8 or weapon.skill == 10 or weapon.skill == 12) or false

end

--Color the appropriate Ability/spell recast
function textColor(abil,state)

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
function flash(area)

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

function getRecasts()

	local ability_recast = windower.ffxi.get_ability_recasts()
	local spell_recast = windower.ffxi.get_spell_recasts()
	local spell_data = windower.ffxi.get_sjob_data().spells

	ElementalSforzo.recast = ability_recast[0] and math.ceil(ability_recast[0])
	OdyllicSubterfuge.recast = ability_recast[254] and math.ceil(ability_recast[254]) or 0
	Aggressor.recast = ability_recast[4] and math.ceil(ability_recast[4])
	ArcaneCircle.recast = ability_recast[86] and math.ceil(ability_recast[86])
	Battuta.recast = ability_recast[120] and math.ceil(ability_recast[120])
	Berserk.recast = ability_recast[1] and math.ceil(ability_recast[1])
	Cocoon.recast = (type(spell_data) == 'table' and table.contains(spell_data,547)) and math.ceil(spell_recast[547] / 60)
	ConsumeMana.recast = ability_recast[95] and math.ceil(ability_recast[95])
	Cover.recast = ability_recast[76] and math.ceil(ability_recast[76])
	Crusade.recast = spell_recast[476] and math.ceil(spell_recast[476] / 60)
	Defender.recast = ability_recast[3] and math.ceil(ability_recast[3])
	DivineSeal.recast = ability_recast[26] and math.ceil(ability_recast[26])
	Embolden.recast = ability_recast[72] and math.ceil(ability_recast[72])
	Gambit.recast = ability_recast[116] and math.ceil(ability_recast[116])
	Hasso.recast = ability_recast[138] and math.ceil(ability_recast[138])
	HolyCircle.recast = ability_recast[74] and math.ceil(ability_recast[74])
	LastResort.recast = ability_recast[64] and math.ceil(ability_recast[64])
	Liement.recast = ability_recast[117] and math.ceil(ability_recast[117])
	Lunge.recast = ability_recast[25] and math.ceil(ability_recast[25])
	Meditate.recast = ability_recast[134] and math.ceil(ability_recast[134])
	OneforAll.recast = ability_recast[118] and math.ceil(ability_recast[118])
	Pflug.recast = ability_recast[59] and math.ceil(ability_recast[59])
	Phalanx.recast = spell_recast[106] and math.ceil(spell_recast[106] / 60)
	Refueling.recast = (type(spell_data) == 'table' and table.contains(spell_data,530)) and math.ceil(spell_recast[530] / 60)
	Rayke.recast = ability_recast[119] and math.ceil(ability_recast[119])
	Seigan.recast = ability_recast[139] and math.ceil(ability_recast[139])
	Sekkanoki.recast = ability_recast[140] and math.ceil(ability_recast[140])
	Sentinel.recast = ability_recast[75] and math.ceil(ability_recast[75])
	Souleater.recast = ability_recast[85] and math.ceil(ability_recast[85])
	Stoneskin.recast = spell_recast[54] and math.ceil(spell_recast[54] / 60)
	Swipe.recast = ability_recast[241] and math.ceil(ability_recast[241])
	Swordplay.recast = ability_recast[24] and math.ceil(ability_recast[24])
	ThirdEye.recast = ability_recast[133] and math.ceil(ability_recast[133])
	Valiance.recast = ability_recast[113] and math.ceil(ability_recast[113])
	Vallation.recast = ability_recast[23] and math.ceil(ability_recast[23])
	VivaciousPulse.recast = ability_recast[242] and math.ceil(ability_recast[242])
	Warcry.recast = ability_recast[2] and math.ceil(ability_recast[2])
	WardingCircle.recast = ability_recast[135] and math.ceil(ability_recast[135])
	WeaponBash.recast = ability_recast[88] and math.ceil(ability_recast[88])

end

getRecasts()

-- Format abilities/spells to fit into their allotted 12 spaces
function formatAbils(input,input_sh)

	-- Valid abilities/spells
	local validAbilities = {
		"Elemental Sforzo", "Odyllic Subterfuge", "Aggressor", "Arcane Circle", "Battuta", "Berserk", "Cocoon", "Consume Mana", "Cover", "Crusade", "Defender", "Divine Seal", "Embolden", "Gambit", "Hasso", "Holy Circle", "Last Resort", "Liement", "Lunge", "Meditate", "One for All", "Pflug", "Phalanx", "Rayke", "Refueling", "Seigan", "Sekkanoki", "Sentinel", "Souleater", "Stoneskin", "Swipe", "Swordplay", "Third Eye", "Valiance", "Vallation", "Vivacious Pulse", "Warcry", "Warding Circle", "Weapon Bash"

	}

	local ab = {} ab['Elemental Sforzo'] = ElementalSforzo ab['Odyllic Subterfuge'] = OdyllicSubterfuge ab['Aggressor'] = Aggressor ab['Arcane Circle'] = ArcaneCircle ab['Battuta'] = Battuta ab['Berserk'] = Berserk ab['Cocoon'] = Cocoon ab['Consume Mana'] = ConsumeMana ab['Cover'] = Cover ab['Crusade'] = Crusade ab['Defender'] = Defender ab['Divine Seal'] = DivineSeal ab['Embolden'] = Embolden ab['Gambit'] = Gambit ab['Hasso'] = Hasso ab['Holy Circle'] = HolyCircle ab['Last Resort'] = LastResort ab['Liement'] = Liement ab['Lunge'] = Lunge ab['Meditate'] = Meditate ab['One for All'] = OneforAll ab['Pflug'] = Pflug ab['Phalanx'] = Phalanx ab['Rayke'] = Rayke ab['Refueling'] = Refueling ab['Seigan'] = Seigan ab['Sekkanoki'] = Sekkanoki ab['Sentinel'] = Sentinel ab['Souleater'] = Souleater ab['Stoneskin'] = Stoneskin ab['Swipe'] = Swipe ab['Swordplay'] = Swordplay ab['Third Eye'] = ThirdEye ab['Valiance'] = Valiance ab['Vallation'] = Vallation ab['Vivacious Pulse'] = VivaciousPulse ab['Warcry'] = Warcry ab['Warding Circle'] = WardingCircle ab['Weapon Bash'] = WeaponBash
	
	-- Check if the input matches any of the valid abilities/spells
	for _, ability in ipairs(validAbilities) do

		if input == ability then

			local recast = ab[ability].recast or 0

			-- Are we using the ability/spell name itself, or a shorthand supplied in the Options?
			local startingString = input_sh == '' and input or input_sh

			-- Maximum length of output without brackets
			local maxLength = 10

			-- Function to format the output string
			local function formatOutputString(baseString, truncateLength)
				local truncatedString = string.sub(baseString, 1, truncateLength)
				return truncatedString
			end

			-- Get our output before we apply the brackets below
			local formattedString = ''
			if recast > 3600 then
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

			-- Apply brackets with recast coloring
			formattedString = leftPadding..'\\cs('..c.r..','..c.g..','..c.b..')[\\cr'..formattedString..'\\cs('..c.r..','..c.g..','..c.b..')]\\cr'..rightPadding

			return formattedString

		end
	end

	-- If input doesn't match any valid ability/spell, return "UNKNOWN"
	return " [UNKNOWN]  "

end

-- Format Notifications/Debuffs to be centered in their allotted 36 spaces
function formatRunes(input)

	local maxLength = 24
	local paddingTotalLength = maxLength - #input

	-- Determine the position to insert the truncatedString
	local leftPaddingLength = math.floor(paddingTotalLength / 2)
	local leftPadding = string.rep(" ", leftPaddingLength)
	local rightPaddingLength = paddingTotalLength - leftPaddingLength
	local rightPadding = string.rep(" ", rightPaddingLength)

	-- Construct the centered formatted string
	local centeredString = leftPadding..input..rightPadding

	return centeredString

end

-- Format Notifications/Debuffs to be centered in their allotted 36 spaces
function format36(input)

	local maxLength = 40 --add 4 since the 4 « characters count as 2 each
	local paddingTotalLength = maxLength - #input

	-- Determine the position to insert the truncatedString
	local leftPaddingLength = math.floor(paddingTotalLength / 2)
	local leftPadding = string.rep(" ", leftPaddingLength)
	local rightPaddingLength = paddingTotalLength - leftPaddingLength
	local rightPadding = string.rep(" ", rightPaddingLength)

	-- Construct the centered formatted string
	local centeredString = leftPadding..input..rightPadding

	return centeredString

end

-- Format Weapons to be centered and allotted in their 36 spaces
function formatWeapons(input)

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

function getHUDAbils()

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

function formatAMTime(input)

	local am_time_minute = math.floor(input/60)
	local am_time_second = input - (math.floor(input/60)*60)
	am_time_second = string.format("%02d", am_time_second)
	return am_time_minute..':'..am_time_second

end

local function itemMatch(item_num)
	local locations = {"inventory", "wardrobe", "wardrobe2", "wardrobe3", "wardrobe4", "wardrobe5", "wardrobe6", "wardrobe7", "wardrobe8"}
	for _, location in ipairs(locations) do
		local weapon_id = windower.ffxi.get_items()[location][windower.ffxi.get_items().equipment.main].id
		if weapon_id == item_num then
			return true --match found
		end
	end
	return false --no match found
end

function mythicAMUpdate(tp)
	if tp >= 1000 and tp < 2000 then
		pre_mythicNum = math.floor((tp / 50) + 10)
		pre_AMTimer = 90
	elseif tp >= 2000 and tp < 3000 then
		pre_mythicNum = math.floor((tp * 0.06) - 80)
		pre_AMTimer = 120
	elseif tp == 3000 then
		pre_AMTimer = 180
	end
end

function primeAMUpdate(tp)

	if itemMatch(21652) then --stage 3 Prime
		if tp >= 1000 and tp < 1334 then
			pre_primeNum = '2'
			pre_AMTimer = 60
		elseif tp >= 1334 and tp < 1667 then
			pre_primeNum = '3'
			pre_AMTimer = 60
		elseif tp >= 1667 and tp < 2000 then
			pre_primeNum = '4'
			pre_AMTimer = 60
		elseif tp >= 2000 and tp < 2334 then
			pre_primeNum = '5'
			pre_AMTimer = 120
		elseif tp >= 2334 and tp < 2667 then
			pre_primeNum = '6'
			pre_AMTimer = 120
		elseif tp >= 2667 and tp < 3000 then
			pre_primeNum = '7'
			pre_AMTimer = 120
		elseif tp == 3000 then
			pre_primeNum = '8'
			pre_AMTimer = 180
		end
	elseif itemMatch(21653) then --stage 4 Prime
		if tp >= 1000 and tp < 1334 then
			pre_primeNum = '4'
			pre_AMTimer = 60
		elseif tp >= 1334 and tp < 1667 then
			pre_primeNum = '5'
			pre_AMTimer = 60
		elseif tp >= 1667 and tp < 2000 then
			pre_primeNum = '6'
			pre_AMTimer = 60
		elseif tp >= 2000 and tp < 2334 then
			pre_primeNum = '7'
			pre_AMTimer = 120
		elseif tp >= 2334 and tp < 2667 then
			pre_primeNum = '8'
			pre_AMTimer = 120
		elseif tp >= 2667 and tp < 3000 then
			pre_primeNum = '9'
			pre_AMTimer = 120
		elseif tp == 3000 then
			pre_primeNum = '10'
			pre_AMTimer = 180
		end
	elseif itemMatch(21649) then --stage 5 Prime
		if tp >= 1000 and tp < 1334 then
			pre_primeNum = '6'
			pre_AMTimer = 60
		elseif tp >= 1334 and tp < 1667 then
			pre_primeNum = '7'
			pre_AMTimer = 60
		elseif tp >= 1667 and tp < 2000 then
			pre_primeNum = '8'
			pre_AMTimer = 60
		elseif tp >= 2000 and tp < 2334 then
			pre_primeNum = '9'
			pre_AMTimer = 120
		elseif tp >= 2334 and tp < 2667 then
			pre_primeNum = '10'
			pre_AMTimer = 120
		elseif tp >= 2667 and tp < 3000 then
			pre_primeNum = '11'
			pre_AMTimer = 120
		elseif tp == 3000 then
			pre_primeNum = '12'
			pre_AMTimer = 180
		end
	end

end

function checkRunes()
	local runes_found = false
	local runes = {"Ignis", "Gelus", "Flabra", "Tellus", "Sulpor", "Unda", "Lux", "Tenebrae"}
	for _, rune in ipairs(runes) do
		if buffactive[rune] then
			runes_found = true -- Switch to true if any rune is found
		end
	end
	if not runes_found then
		send_command('gs c ClearRunes')
	end
end

function updateBuffs()
    active_buffs = {}  --Reset the table
    for _, buffId in ipairs(windower.ffxi.get_player().buffs) do
        active_buffs[res.buffs[buffId].en] = true  --Store buff names as keys for O(1) lookup
    end
end

function buffActive(buff_id)
	local buffs = windower.ffxi.get_player().buffs

	for _, buff in ipairs(buffs) do
		if buff == buff_id then
			return true
		end
	end
	return false
end

-------------------------------------------
--            SELF COMMANDS              --
-------------------------------------------

function self_command(command)
	if command == 'Mode' then
		if Mode == 'Auto-Parry' then
			Mode = 'Auto-DT'
		elseif Mode == 'Auto-DT' then
			Mode = 'Combat-Parry'
		elseif Mode == 'Combat-Parry' then
			Mode = 'Combat-DT'
		elseif Mode == 'Combat-DT' then
			Mode = 'Neutral'
		elseif Mode == 'Neutral' then
			Mode = 'DPS'
		elseif Mode == 'DPS' then
			Mode = 'Auto-Parry'
		end
		hud_mode_shdw:text('Mode: '..Mode)
		hud_mode:text('Mode: '..Mode)
		local c = color[fMode[Mode]]
		hud_mode:color(c.r,c.g,c.b)
		hud_bg_color:bg_color(c.r,c.g,c.b)
		choose_set()
	elseif command == 'ClearNotifications' then --these reset the Notifications display back to a basic state
		if TownZones:contains(world.area) or windower.ffxi.get_info().mog_house then
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
		elseif player.status == "Resting" then
			hud_noti_shdw:text('Status: Resting')
			hud_noti:text('Status: Resting')
			hud_noti:color(255,255,255)
		elseif player.status == "Engaged" then
			hud_noti_shdw:text('Status: Engaged')
			hud_noti:text('Status: Engaged')
			hud_noti:color(255,255,255)
		elseif player.status == "Idle" and (Mode == 'Combat-Parry' or Mode == 'Combat-DT' or ((Mode == 'Auto-Parry' or Mode == 'Auto-DT') and player_in_combat)) then
			hud_noti_shdw:text('Status: Kiting')
			hud_noti:text('Status: Kiting')
			hud_noti:color(255,255,255)
		elseif player.status == "Idle" then
			hud_noti_shdw:text('Status: Idle')
			hud_noti:text('Status: Idle')
			hud_noti:color(255,255,255)
		elseif player.status == "Mount" then
			hud_noti_shdw:text('Status: Mounted')
			hud_noti:text('Status: Mounted')
			hud_noti:color(255,255,255)
		end
		hud_noti_bg:bg_alpha(0)
		RuneCycleDisplay = false --just cleared the notifications, therefore not displaying the RuneCycle notification
	elseif command == 'ClearDebuffs' then --these reset the Debuffs display back to a basic state
		hud_debuffs_shdw:text('')
		hud_debuffs:text('')
		hud_debuffs:color(255,255,255)
	elseif command == 'Zone Gear' then
		if ZoneGear == 'Town' then
			if TownZones:contains(world.area) or windower.ffxi.get_info().mog_house then
				send_command('wait 5;gs c Choose Set')
			end
		elseif ZoneGear ~= "Off" then
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
		hud_noti_bg:bg_alpha(0)
		NotiCountdown = NotiDelay
	elseif command == 'NotiLowMPToggle' then
		NotiLowMPToggle = false
	elseif command == 'RuneCycle' then
		local c
		if not RuneCycleDisplay then --if we are not already displaying the RuneCycle notification (picking an element) then we display what element is already selected first
			RuneCycleDisplay = true --we are now displaying the RuneCycle notification to select an element
			if RuneElement == 'Tenebrae' then --Dark
				hud_noti_shdw:text(format36('«« Tenebrae: Dark > Light »»'))
				hud_noti:text(format36('«« Tenebrae: Dark > Light »»'))
				c= color.Dark
			elseif RuneElement == 'Ignis' then --Fire
				hud_noti_shdw:text(format36('«« Ignis: Fire > Ice »»'))
				hud_noti:text(format36('«« Ignis: Fire > Ice »»'))
				c= color.Fire
			elseif RuneElement == 'Gelus' then --Ice
				hud_noti_shdw:text(format36('«« Gelus: Ice > Wind »»'))
				hud_noti:text(format36('«« Gelus: Ice > Wind »»'))
				c= color.Ice
			elseif RuneElement == 'Flabra' then --Wind
				hud_noti_shdw:text(format36('«« Flabra: Wind > Earth »»'))
				hud_noti:text(format36('«« Flabra: Wind > Earth »»'))
				c= color.Air
			elseif RuneElement == 'Tellus' then --Earth
				hud_noti_shdw:text(format36('«« Tellus: Earth > Lghtn. »»'))
				hud_noti:text(format36('«« Tellus: Earth > Lghtn. »»'))
				c= color.Earth
			elseif RuneElement == 'Sulpor' then --Lightning
				hud_noti_shdw:text(format36('«« Sulpor: Lghtn. > Water »»'))
				hud_noti:text(format36('«« Sulpor: Lghtn. > Water »»'))
				c= color.Thunder
			elseif RuneElement == 'Unda' then --Water
				hud_noti_shdw:text(format36('«« Unda: Water > Fire »»'))
				hud_noti:text(format36('«« Unda: Water > Fire »»'))
				c= color.Water
			elseif RuneElement == 'Lux' then --Light
				hud_noti_shdw:text(format36('«« Lux: Light > Dark »»'))
				hud_noti:text(format36('«« Lux: Light > Dark »»'))
				c= color.Light
			end
		else --now we are already displaying the RuneCycle notification so we cycle through the different elements
			if RuneElement == 'Tenebrae' then --Dark
				RuneElement = 'Ignis' --cycle to Fire
				hud_noti_shdw:text(format36('«« Ignis: Fire > Ice »»'))
				hud_noti:text(format36('«« Ignis: Fire > Ice »»'))
				c= color.Fire
			elseif RuneElement == 'Ignis' then --Fire
				RuneElement = 'Gelus' --cycle to Ice
				hud_noti_shdw:text(format36('«« Gelus: Ice > Wind »»'))
				hud_noti:text(format36('«« Gelus: Ice > Wind »»'))
				c= color.Ice
			elseif RuneElement == 'Gelus' then --Ice
				RuneElement = 'Flabra' --cycle to Wind
				hud_noti_shdw:text(format36('«« Flabra: Wind > Earth »»'))
				hud_noti:text(format36('«« Flabra: Wind > Earth »»'))
				c= color.Air
			elseif RuneElement == 'Flabra' then --Wind
				RuneElement = 'Tellus' --cycle to Earth
				hud_noti_shdw:text(format36('«« Tellus: Earth > Lghtn. »»'))
				hud_noti:text(format36('«« Tellus: Earth > Lghtn. »»'))
				c= color.Earth
			elseif RuneElement == 'Tellus' then --Earth
				RuneElement = 'Sulpor' --cycle to Lightning
				hud_noti_shdw:text(format36('«« Sulpor: Lghtn. > Water »»'))
				hud_noti:text(format36('«« Sulpor: Lghtn. > Water »»'))
				c= color.Thunder
			elseif RuneElement == 'Sulpor' then --Lightning
				RuneElement = 'Unda' --cycle to Water
				hud_noti_shdw:text(format36('«« Unda: Water > Fire »»'))
				hud_noti:text(format36('«« Unda: Water > Fire »»'))
				c= color.Water
			elseif RuneElement == 'Unda' then --Water
				RuneElement = 'Lux' --cycle to Light
				hud_noti_shdw:text(format36('«« Lux: Light > Dark »»'))
				hud_noti:text(format36('«« Lux: Light > Dark »»'))
				c= color.Light
			elseif RuneElement == 'Lux' then --Light
				RuneElement = 'Tenebrae' --cycle to Dark
				hud_noti_shdw:text(format36('«« Tenebrae: Dark > Light »»'))
				hud_noti:text(format36('«« Tenebrae: Dark > Light »»'))
				c= color.Dark
			end
		end
		hud_noti:color(255,255,255)
		hud_noti_bg:bg_color(c.r,c.g,c.b)
		hud_noti_bg:bg_alpha(150)
		NotiCountdown = NotiDelay
	elseif command == 'RuneFire' then
		RuneElement = 'Ignis' --Fire
		hud_noti_shdw:text(format36('«« Ignis: Fire > Ice »»'))
		hud_noti:color(255,255,255)
		hud_noti:text(format36('«« Ignis: Fire > Ice »»'))
		c= color.Fire
		hud_noti_bg:bg_color(c.r,c.g,c.b)
		hud_noti_bg:bg_alpha(150)
		NotiCountdown = NotiDelay
	elseif command == 'RuneBlizzard' or command =='RuneIce' then
		RuneElement = 'Gelus' --Ice
		hud_noti_shdw:text(format36('«« Gelus: Ice > Wind »»'))
		hud_noti:color(255,255,255)
		hud_noti:text(format36('«« Gelus: Ice > Wind »»'))
		c= color.Ice
		hud_noti_bg:bg_color(c.r,c.g,c.b)
		hud_noti_bg:bg_alpha(150)
		NotiCountdown = NotiDelay
	elseif command == 'RuneAero' or command =='RuneWind' then
		RuneElement = 'Flabra' --Wind
		hud_noti_shdw:text(format36('«« Flabra: Wind > Earth »»'))
		hud_noti:color(255,255,255)
		hud_noti:text(format36('«« Flabra: Wind > Earth »»'))
		c= color.Air
		hud_noti_bg:bg_color(c.r,c.g,c.b)
		hud_noti_bg:bg_alpha(150)
		NotiCountdown = NotiDelay
	elseif command == 'RuneStone' or command =='RuneEarth' then
		RuneElement = 'Tellus' --Earth
		hud_noti_shdw:text(format36('«« Tellus: Earth > Lghtn. »»'))
		hud_noti:color(255,255,255)
		hud_noti:text(format36('«« Tellus: Earth > Lghtn. »»'))
		c= color.Earth
		hud_noti_bg:bg_color(c.r,c.g,c.b)
		hud_noti_bg:bg_alpha(150)
		NotiCountdown = NotiDelay
	elseif command == 'RuneThunder' or command =='RuneLightning' then
		RuneElement = 'Sulpor' --Lightning
		hud_noti_shdw:text(format36('«« Sulpor: Lghtn. > Water »»'))
		hud_noti:color(255,255,255)
		hud_noti:text(format36('«« Sulpor: Lghtn. > Water »»'))
		c= color.Thunder
		hud_noti_bg:bg_color(c.r,c.g,c.b)
		hud_noti_bg:bg_alpha(150)
		NotiCountdown = NotiDelay
	elseif command == 'RuneWater' then
		RuneElement = 'Unda' --Water
		hud_noti_shdw:text(format36('«« Unda: Water > Fire »»'))
		hud_noti:color(255,255,255)
		hud_noti:text(format36('«« Unda: Water > Fire »»'))
		c= color.Water
		hud_noti_bg:bg_color(c.r,c.g,c.b)
		hud_noti_bg:bg_alpha(150)
		NotiCountdown = NotiDelay
	elseif command == 'RuneLight' then
		RuneElement = 'Lux' --Light
		hud_noti_shdw:text(format36('«« Lux: Light > Dark »»'))
		hud_noti:color(255,255,255)
		hud_noti:text(format36('«« Lux: Light > Dark »»'))
		c= color.Light
		hud_noti_bg:bg_color(c.r,c.g,c.b)
		hud_noti_bg:bg_alpha(150)
		NotiCountdown = NotiDelay
	elseif command == 'RuneDark' then
		RuneElement = 'Tenebrae' --Dark
		hud_noti_shdw:text(format36('«« Tenebrae: Dark > Light »»'))
		hud_noti:color(255,255,255)
		hud_noti:text(format36('«« Tenebrae: Dark > Light »»'))
		c= color.Dark
		hud_noti_bg:bg_color(c.r,c.g,c.b)
		hud_noti_bg:bg_alpha(150)
		NotiCountdown = NotiDelay
	elseif command == 'Rune' then
		send_command('input /ja '..RuneElement..' <me>')
	elseif command == 'ClearRunes' then
		Rune1Timer = 0
		Rune2Timer = 0
		Rune3Timer = 0
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
		hud_rune01_bg:show()
		hud_rune02_bg:show()
		hud_rune03_bg:show()
		hud_abil01_bg:show()
		hud_abil02_bg:show()
		hud_abil03_bg:show()
		hud_abil04_bg:show()
		hud_abil05_bg:show()
		hud_abil06_bg:show()
		hud_weapons_shdw:show()
		hud_mode_shdw:show()
		hud_noti_shdw:show()
		hud_debuffs_shdw:show()
		hud_rune01_shdw:show()
		hud_rune02_shdw:show()
		hud_rune03_shdw:show()
		hud_abil01_shdw:show()
		hud_abil02_shdw:show()
		hud_abil03_shdw:show()
		hud_abil04_shdw:show()
		hud_abil05_shdw:show()
		hud_abil06_shdw:show()
		hud_weapons:show()
		hud_mode:show()
		hud_noti:show()
		hud_debuffs:show()
		hud_rune01:show()
		hud_rune02:show()
		hud_rune03:show()
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
		hud_rune01_bg:hide()
		hud_rune02_bg:hide()
		hud_rune03_bg:hide()
		hud_abil01_bg:hide()
		hud_abil02_bg:hide()
		hud_abil03_bg:hide()
		hud_abil04_bg:hide()
		hud_abil05_bg:hide()
		hud_abil06_bg:hide()
		hud_weapons_shdw:hide()
		hud_mode_shdw:hide()
		hud_noti_shdw:hide()
		hud_debuffs_shdw:hide()
		hud_rune01_shdw:hide()
		hud_rune02_shdw:hide()
		hud_rune03_shdw:hide()
		hud_abil01_shdw:hide()
		hud_abil02_shdw:hide()
		hud_abil03_shdw:hide()
		hud_abil04_shdw:hide()
		hud_abil05_shdw:hide()
		hud_abil06_shdw:hide()
		hud_weapons:hide()
		hud_mode:hide()
		hud_noti:hide()
		hud_debuffs:hide()
		hud_rune01:hide()
		hud_rune02:hide()
		hud_rune03:hide()
		hud_abil01:hide()
		hud_abil02:hide()
		hud_abil03:hide()
		hud_abil04:hide()
		hud_abil05:hide()
		hud_abil06:hide()
	elseif command == 'WC' then
		CurrentEquip = ''
		if string.find(world.area,'Abyssea') then --if inside Abyssea use the combined table
			pair = WeaponCyclePlusAbyssea[WeaponCycleIndex]
			if pair == nil then
				WeaponCycleIndex = 1
				pair = WeaponCyclePlusAbyssea[WeaponCycleIndex]
			end
		else --otherwise, use just the basic WeaponCycle table
			pair = WeaponCycle[WeaponCycleIndex]
			if pair == nil then
				WeaponCycleIndex = 1
				pair = WeaponCycle[WeaponCycleIndex]
			end
		end
		equip({main=pair[1],sub=pair[2]})
		-- Display the intended weapon(s) in the HUD immediately
		SwitchingWeapons = 2
		if pair[2] == empty then
			hud_weapons_shdw:text(formatWeapons(pair[1]))
			hud_weapons:text(formatWeapons(pair[1]))
		else
			hud_weapons_shdw:text(formatWeapons(pair[1]..' & '..pair[2]))
			hud_weapons:text(formatWeapons(pair[1]..' & '..pair[2]))
		end
		WeaponCycleIndex = WeaponCycleIndex + 1
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
		hud_noti:bg_alpha(50)
		local c = color.abil.flash
		hud_noti:bg_color(c.r,c.g,c.b)
	elseif command == 'Flash_Noti_B' then
		hud_noti:bg_alpha(0)
	elseif command == 'Flash_Debuffs_A' then
		hud_debuffs_bg:bg_alpha(50)
		local c = color.abil.flash
		hud_debuffs_bg:bg_color(c.r,c.g,c.b)
	elseif command == 'Flash_Debuffs_B' then
		hud_debuffs_bg:bg_alpha(0)
	end
end

-------------------------------------------
--              CHOOSE SET               --
-------------------------------------------

function choose_set()
	if player.status == "Resting" then
		if GreetingDelay == -1 then
			if LowHP then
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
				hud_noti_shdw:text('Status: Resting')
				hud_noti:text('Status: Resting')
				hud_noti:color(255,255,255)
			end
		end
		equip(set_combine(sets.idle, sets.rest)) --No matter what Mode we're in, if we're resting its because we need MP so we equip the Refresh set along with the Rest set
	elseif player.status == "Engaged" then
		if GreetingDelay == -1 then
			if LowHP then
				hud_noti_shdw:text('«« Low HP »»')
				hud_noti:text('«« Low HP »»')
				hud_noti:color(255,50,50)
			elseif buffactive['Weakness'] then
				hud_noti_shdw:text('Status: Weakness')
				hud_noti:text('Status: Weakness')
				hud_noti:color(205,133,63)
			elseif player.mpp <= 20 then
				hud_noti_shdw:text('«« Low MP »»')
				hud_noti:text('«« Low MP »»')
				hud_noti:color(255,50,50)
			else
				hud_noti_shdw:text('Status: Engaged')
				hud_noti:text('Status: Engaged')
				hud_noti:color(255,255,255)
			end
		end
		if LowHP then --no matter what Mode we're in, if we have low HP we equip the Oh Shit gear set
			equip(sets.oh_shit)
		elseif Mode == 'Auto-Parry' or Mode == 'Combat-Parry' then
			equip(sets.tank_parry)
		elseif Mode == 'Auto-DT' or  Mode == 'Combat-DT' then
			equip(sets.tank_dt)
		elseif Mode == 'Neutral' then
			equip(sets.idle)
		elseif Mode == 'DPS' then
			equip(sets.dps)
		end
	elseif player.status == "Idle" then
		if GreetingDelay == -1 then
			if TownZones:contains(world.area) or windower.ffxi.get_info().mog_house then
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
			elseif buffactive['Weakness'] then
				hud_noti_shdw:text('Status: Weakness')
				hud_noti:text('Status: Weakness')
				hud_noti:color(205,133,63)
			elseif player.mpp <= 20 then
				hud_noti_shdw:text('«« Low MP »»')
				hud_noti:text('«« Low MP »»')
				hud_noti:color(205,133,63)
			elseif Mode == 'Combat-Parry' or Mode == 'Combat-DT' or ((Mode == 'Auto-Parry' or Mode == 'Auto-DT') and player_in_combat) then
				hud_noti_shdw:text('Status: Kiting')
				hud_noti:text('Status: Kiting')
				hud_noti:color(255,255,255)
			else
				hud_noti_shdw:text('Status: Idle')
				hud_noti:text('Status: Idle')
				hud_noti:color(255,255,255)
			end
		end
		if AdoulinZones:contains(world.area) then
			equip(set_combine(sets.adoulin, sets.movementspeed))
		elseif BastokZones:contains(world.area) then
			equip(set_combine(sets.bastok, sets.movementspeed))
		elseif SandyZones:contains(world.area) then
			equip(set_combine(sets.sandoria, sets.movementspeed))
		elseif WindyZones:contains(world.area) then
			equip(set_combine(sets.windurst, sets.movementspeed))
		elseif TownZones:contains(world.area) or windower.ffxi.get_info().mog_house then
			equip(set_combine(sets.town, sets.movementspeed))
		else
			if LowHP then --no matter what Mode we're in, if we have low HP we equip the Oh Shit gear set (plus movement speed to <{Run away!}>)
				equip(set_combine(sets.oh_shit, sets.movementspeed))
			elseif ((Mode == 'Auto-Parry' or Mode == 'Auto-DT') and player_in_combat) or Mode == 'Combat-Parry' or Mode == 'Combat-DT' then -- if we're idle but ARE in combat (ex: kiting, mob is aggressive) we equip the tank/idle sets
				equip(set_combine(sets.tank_dt, sets.movementspeed))
			elseif ((Mode == 'Auto-Parry' or Mode == 'Auto-DT') and not player_in_combat) or Mode == 'Neutral' or Mode == 'DPS' then --if we're idle and NOT in combat (ex: buffing up before a fight, mob is not aggressive yet) we equip the refresh and movement speed sets
				equip(set_combine(sets.idle, sets.movementspeed))
			end
		end
	end
	hud_noti_bg:bg_alpha(0)
end

-------------------------------------------
--               PRECAST                 --
-------------------------------------------

function precast(spell)
	if buffactive['terror'] then
		if AlertSounds then
			play_sound(Notification_Cancel)
		end
		flash('Debuffs')
	elseif buffactive['petrification'] then
		if AlertSounds then
			play_sound(Notification_Cancel)
		end
		flash('Debuffs')
	elseif buffactive['sleep'] then
		if AlertSounds then
			play_sound(Notification_Cancel)
		end
		flash('Debuffs')
	elseif buffactive['stun'] then
		if AlertSounds then
			play_sound(Notification_Cancel)
		end
		flash('Debuffs')
	elseif buffactive['amnesia'] and (spell.type == 'WeaponSkill' or spell.type == 'JobAbility') then
		if AlertSounds then
			play_sound(Notification_Cancel)
		end
		flash('Debuffs')
	elseif buffactive['silence'] and (spell.prefix == '/magic' or spell.prefix == '/ninjutsu' or spell.prefix == '/song') then
		if AlertSounds then
			play_sound(Notification_Cancel)
		end
		if UseEcho == 'E' then
			send_command('input /item "Echo Drops" <me>')
		elseif UseEcho == 'R' then
			send_command('input /item "Remedy" <me>')
		end
		flash('Debuffs')
	elseif buffactive['mute'] and (spell.prefix == '/magic' or spell.prefix == '/ninjutsu' or spell.prefix == '/song') then
		if AlertSounds then
			play_sound(Notification_Cancel)
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
			hud_noti_bg:bg_alpha(0)
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
			hud_noti_bg:bg_alpha(0)
			NotiCountdown = NotiDelay
			cancel_spell()
			return
		-- If an Abyssea Proc weapon pair is equipped inside Abyssea, we don't want to use a WS set
		elseif checkProcWeapons(player.equipment.main, player.equipment.sub) and string.find(world.area,'Abyssea') then
			return
		end
		local base_set = sets[spell.english] or sets.weapon_skill
		local ws_acc_set = Mode ~= 'DPS' and sets.weapons_skill_accuracy or nil
		equip(set_combine(base_set, ws_acc_set))
		if player.equipment.main == "Lionheart" and spell.english == "Resolution" then
			pre_AMTimer = 181
		elseif player.equipment.main == "Epeolatry" and spell.english == "Dimidiation" then
			player_tp = player.tp
			TP_Window_Open = true
			mythicAMUpdate(player_tp)
		elseif player.equipment.main == 'Helheim' and spell.english == "Fimbulvetr" then
			player_tp = player.tp
			TP_Window_Open = true
			primeAMUpdate(player_tp)
		end
	elseif spell.english == 'Elemental Sforzo' and ElementalSforzo.recast < 2 then
		equip(sets.elemental_sforzo)
	elseif spell.english == 'Valiance' and Valiance.recast < 2 then
		equip(sets.valiance)
	elseif spell.english == 'Vallation' and Vallation.recast < 2 then
		equip(sets.valiance)
	elseif spell.type == 'Rune' then
		equip(sets.enmity)
	elseif spell.english == 'Swordplay' and Swordplay.recast < 2 then
		equip(sets.swordplay)
	elseif spell.english == 'Swipe' and Swipe.recast < 2 then
		equip(sets.swipe)
	elseif spell.english == 'Lunge' and Lunge.recast < 2 then
		equip(sets.swipe)
	elseif spell.english == 'Embolden' and Embolden.recast < 2 then
		equip(sets.embolden)
	elseif spell.english == 'Vivacious Pulse' and VivaciousPulse.recast < 2 then
		equip(sets.pulse)
	elseif spell.english == 'Gambit' and Gambit.recast < 2 then
		equip(sets.gambit)
	elseif spell.english == 'Battuta' and Battuta.recast < 2 then
		equip(sets.battuta)
	elseif spell.english == 'Rayke' and Rayke.recast < 2 then
		equip(sets.rayke)
	elseif spell.english == 'Liement' and Liement.recast < 2 then
		equip(sets.liement)
	elseif spell.english == 'One For All' and OneforAll.recast < 2 then
		equip(sets.one_for_all)
	elseif spell.english == 'Holy Water' then
		equip(sets.holy_water)
	elseif (spell.english == 'Spectral Jig' or spell.english == 'Sneak' or spell.english == 'Monomi: Ichi' or spell.english == 'Monomi: Ni') and buffactive['Sneak'] and spell.target.type == 'SELF' then
		send_command('cancel 71')
		if spell.english ~= 'Spectral Jig' then
			equip(sets.fast_cast)
		end
	elseif spell.english == 'Stoneskin' and buffactive['Stoneskin'] then
		send_command('cancel 37')
		equip(sets.fast_cast)
	elseif spell.english == "Flash" then
		if windower.ffxi.get_spell_recasts()[112] < 120 then
			equip(sets.fast_cast)
		elseif player.sub_job == 'BLU' and player.sub_job_level ~= 0 then
			if windower.ffxi.get_spell_recasts()[575] < 120 and table.contains(windower.ffxi.get_sjob_data().spells,575) and spell.target.distance <= 9 then
				send_command('input /ma "Jettatura" '..spell.target.raw)
				cancel_spell()
				return
			elseif windower.ffxi.get_spell_recasts()[592] < 120 and table.contains(windower.ffxi.get_sjob_data().spells,592) and spell.target.distance <= 14 then
				send_command('input /ma "Blank Gaze" '..spell.target.raw)
				cancel_spell()
				return
			end
		elseif player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
			if windower.ffxi.get_ability_recasts()[5] < 2 and spell.target.distance <= 17.8 then
				send_command('input /ja "Provoke" '..spell.target.raw)
				cancel_spell()
				return
			end
		elseif player.sub_job == 'DRK' and player.sub_job_level ~= 0 then
			if windower.ffxi.get_spell_recasts()[252] < 120 then
				send_command('input /ma "Stun" '..spell.target.raw)
				cancel_spell()
				return
			end
		end
	elseif spell.english == "Sheep Song" then
		if windower.ffxi.get_spell_recasts()[584] < 120 and table.contains(windower.ffxi.get_sjob_data().spells,584) then
			equip(sets.fast_cast)
		elseif windower.ffxi.get_spell_recasts()[605] < 120 and table.contains(windower.ffxi.get_sjob_data().spells,605) then
			send_command('input /ma "Geist Wall" '..spell.target.raw)
			cancel_spell()
			return
		elseif windower.ffxi.get_spell_recasts()[537] < 120 and table.contains(windower.ffxi.get_sjob_data().spells,537) then
			send_command('input /ma "Stinking Gas" '..spell.target.raw)
			cancel_spell()
			return
		elseif windower.ffxi.get_spell_recasts()[598] < 120 and table.contains(windower.ffxi.get_sjob_data().spells,598) then
			send_command('input /ma "Soporific" '..spell.target.raw)
			cancel_spell()
			return
		elseif windower.ffxi.get_spell_recasts()[574] < 120 and table.contains(windower.ffxi.get_sjob_data().spells,574) then
			send_command('input /ma "Feather Barrier" <me>')
			cancel_spell()
			return
		end
	elseif spell.action_type == 'Ranged Attack' then
		equip(sets.snapshot)
	elseif not (spell.action_type == 'Item' or spell.action_type == 'Ability') then
		equip(sets.fast_cast)
	end
end

-------------------------------------------
--               MIDCAST                 --
-------------------------------------------

function midcast(spell)
	if (string.find(spell.english,'Cur') and spell.type == "WhiteMagic") or spell.english == 'Magic Fruit' or spell.english == 'Healing Breeze' or spell.english == 'Wild Carrot' then
		local enmity = player_in_combat and Mode ~= "DPS" and sets.enmity or nil
		local sird = player_in_combat and not buffactive['Aquaveil'] and sets.sird or nil
		equip(set_combine(enmity, sets.healing, sird))
	elseif string.find(spell.english,'Regen') then
		local sird = player_in_combat and not buffactive['Aquaveil'] and sets.sird or nil
		equip(set_combine(sets.regen, sird))
	elseif spell.english == 'Refresh' then
		local sird = player_in_combat and not buffactive['Aquaveil'] and sets.sird or nil
		equip(set_combine(sets.refresh, sird))
	elseif spell.english == 'Phalanx' then
		local sird = (player_in_combat and not buffactive['Aquaveil']) and sets.sird or nil
		equip(set_combine(sets.phalanx, sird))
	elseif spell.skill == "Enhancing Magic" then
		local sird = (player_in_combat and not buffactive['Aquaveil']) and sets.sird or nil
		equip(set_combine(sets.enhancing, sird))
	elseif spell.type == 'Trust' then
		equip(sets.unity)
	elseif spell.action_type == 'Magic' then
		local sird = player_in_combat and not buffactive['Aquaveil'] and sets.sird or nil
		equip(set_combine(sets.enmityspells, sird))
	end
end

-------------------------------------------
--              AFTERCAST                --
-------------------------------------------

function aftercast(spell)
	if (spell.english == 'Ignis' or spell.english == 'Gelus' or spell.english == 'Flabra' or spell.english == 'Tellus' or spell.english == 'Sulpor' or spell.english == 'Unda' or spell.english == 'Lux' or spell.english == 'Tenebrae') and not spell.interrupted then
		Rune3 = Rune2
		Rune2 = Rune1
		Rune3Timer = Rune2Timer
		Rune2Timer = Rune1Timer
		Rune1Timer = 300
		Rune3BGColor = Rune2BGColor
		Rune2BGColor = Rune1BGColor
		if spell.english == 'Ignis'	then
			Rune1 = 'Ignis: Fire > Ice'
			Rune1BGColor = 'Fire'
		elseif spell.english == 'Gelus' then
			Rune1 = 'Gelus: Ice > Wind'
			Rune1BGColor = 'Ice'
		elseif spell.english == 'Flabra' then
			Rune1 = 'Flabra: Wind > Earth'
			Rune1BGColor = 'Air'
		elseif spell.english == 'Tellus' then
			Rune1 = 'Tellus: Earth > Lghtn.'
			Rune1BGColor = 'Earth'
		elseif spell.english == 'Sulpor' then
			Rune1 = 'Sulpor: Lghtn. > Water'
			Rune1BGColor = 'Thunder'
		elseif  spell.english == 'Unda' then
			Rune1 = 'Unda: Water > Fire'
			Rune1BGColor = 'Water'
		elseif spell.english == 'Lux' then
			Rune1 = 'Lux: Light > Dark'
			Rune1BGColor = 'Light'
		elseif spell.english == 'Tenebrae' then
			Rune1 = 'Tenebrae: Dark > Light'
			Rune1BGColor = 'Dark'
		end
	elseif spell.english == 'Swipe' and player.status == "Engaged" and not spell.interrupted then
		Rune1 = Rune2
		Rune2 = Rune3
		Rune3 = 'No Rune'
		Rune1Timer = Rune2Timer
		Rune2Timer = Rune3Timer
		Rune3Timer = 0
		Rune1BGColor = Rune2BGColor
		Rune2BGColor = Rune3BGColor
	elseif (spell.english == 'Rayke' or spell.english == 'Gambit' or spell.english == 'Lunge') and player.status == "Engaged" and not spell.interrupted then
		send_command('gs c ClearRunes')
	elseif spell.english == 'Elemental Sforzo' and SfoTimer and not spell.interrupted then
		if player.equipment.body == 'Futhark Coat' or player.equipment.body == 'Futhark Coat +1' or player.equipment.body == 'Futhark Coat +2' or player.equipment.hands == 'Futhark Coat +3' or player.equipment.hands == 'Futhark Coat +4' then --these pieces extend Elemental Sforzo by 10 seconds so we adjust accordingly
			send_command('input /echo [Elemental Sforzo] 40 seconds;wait 10;input /echo [Elemental Sforzo] 30 seconds;wait 10;input /echo [Elemental Sforzo] 20 seconds;wait 10;input /echo [Elemental Sforzo] 10 seconds')
		else
			send_command('input /echo [Elemental Sforzo] 30 seconds;wait 10;input /echo [Elemental Sforzo] 20 seconds;wait 10;input /echo [Elemental Sforzo] 10 seconds')
		end
	elseif spell.english == 'Odyllic Subterfuge' and OdyTimer and not spell.interrupted then
		send_command('input /echo [Odyllic Subterfuge] 30 seconds;wait 10;input /echo [Odyllic Subterfuge] 20 seconds;wait 10;input /echo [Odyllic Subterfuge] 10 seconds')
	elseif spell.english == 'Hasso' and not spell.interrupted then
		Stance = 'Hasso' --Set Stance to Hasso when we use it
		StanceTimer = 300
	elseif spell.english == 'Seigan' and not spell.interrupted then
		Stance = 'Seigan' --Set Stance to Seigan when we use it
		StanceTimer = 300
	end
	choose_set()
	if AutoStance and twoHanded() and StanceTimer < AutoStanceWindow and player.sub_job == 'SAM' and not buffactive['amnesia'] and not spell.interrupted and not (TownZones:contains(world.area) or windower.ffxi.get_info().mog_house) then
		if Stance == 'Seigan' and Seigan.recast and Seigan.recast == 0 then
			if spell.type == 'WeaponSkill' then
				send_command('wait 3;input /ja Seigan <me>')
			elseif spell.type == 'JobAbility' then
				send_command('wait .5;input /ja Seigan <me>')
			end
		elseif Hasso.recast and Hasso.recast == 0 then
			if spell.type == 'WeaponSkill' then
				send_command('wait 3;input /ja Hasso <me>')
			elseif spell.type == 'JobAbility' then
				send_command('wait .5;input /ja Hasso <me>')
			end
		end
	end
	RuneCycleDisplay = false --since we've done another action, we can assume we're done using the RuneCycle notification
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
	choose_set() --run this any time your status changes (engage, disengage, rest)
	if AutoStance and twoHanded() and StanceTimer < AutoStanceWindow and player.sub_job == 'SAM' and (status == 1 or status == 0) and not buffactive['amnesia'] and not (TownZones:contains(world.area) or windower.ffxi.get_info().mog_house) then
		if Stance == 'Seigan' and Seigan.recast and Seigan.recast == 0 then
			send_command('input /ja Seigan <me>')
		elseif Hasso.recast and Hasso.recast == 0 then
			send_command('input /ja Hasso <me>')
		end
	end
end)

-------------------------------------------
--       Buff/Debuff Notifications       --
-------------------------------------------

windower.register_event('gain buff', function(buff)

	updateBuffs()

	if (buff == 270 or buff == 271 or buff == 272 or buff == 273) and AlertSounds then --Aftermath
		play_sound(Notification_Aftermath_On)
		AMTimer = pre_AMTimer
		mythicNum = pre_mythicNum
		primeNum = pre_primeNum
	elseif (buff == 2 or buff == 19) and not buffactive['charm'] then --If we get slept,
		if buffactive['Stoneskin'] and not buffactive['charm'] then --first remove stoneskin if its up,
			send_command('cancel 37')
			equip(sets.oh_shit)
		elseif not (buffactive['Poison'] or buffactive['Dia'] or buffactive['bio'] or buffactive['Shock'] or buffactive['Rasp'] or buffactive['Choke'] or buffactive['Frost'] or buffactive['Burn'] or buffactive['Drown'] or buffactive['Requiem'] or buffactive['Kaustra'] or buffactive['Helix']) and player.hp > 100 and player.status == "Engaged" then --then as long as we're not already DOT'd, have more than 100 HP, and are engaged,
			equip(set_combine({head="Frenzy Sallet"}, sets.oh_shit)) --equip the Frenzy Sallet to wake us up
		else
			equip(sets.oh_shit)
		end
	elseif buff == 7 or buff == 10 or buff == 28 then --If we get petrified, stunned, or terrored, then equip the Oh Shit set
		equip(sets.oh_shit)
	elseif buff == 15 then --Doom
		DangerCountdown = DangerRepeat --Start the Danger Sound going
	elseif buff == 17 then --Charm
		if AlertSounds then
			play_sound(Notification_Cancel)
		end
	elseif buff == 71 or buff == 69 then --Sneak or Invisible
		send_command('gs c ClearNotifications')
	elseif buff == 252 then --Mounted
		send_command('wait .5;gs c ClearNotifications')
	elseif buff == 157 then --SJ Restricted
		send_command('gs c ClearRunes')
	end
end)

windower.register_event('lose buff', function(buff)

	updateBuffs()

	if buff == 270 or buff == 271 or buff == 272 or buff == 273 and AlertSounds then --lose any aftermath
		play_sound(Notification_Aftermath_Off)
	elseif buff == 251 and Alive and notifications.Food then --food wears off
		if AlertSounds then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Food Has Worn Off »»')
		hud_noti:text('«« Food Has Worn Off »»')
		hud_noti:color(255,50,50)
		hud_noti_bg:bg_alpha(0)
		NotiCountdown = NotiDelay
	elseif buff == 113 and notifications.Reraise and Alive then --reraise wears off
		if AlertSounds then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Reraise Has Worn Off »»')
		hud_noti:text('«« Reraise Has Worn Off »»')
		hud_noti:color(255,50,50)
		hud_noti_bg:bg_alpha(0)
		NotiCountdown = NotiDelay
	elseif buff == 602 and string.find(world.area,'Escha') and notifications.Vorseal then --Vorseal
		if AlertSounds then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Vorseal Has Worn Off »»')
		hud_noti:text('«« Vorseal Has Worn Off »»')
		hud_noti:color(255,50,50)
		hud_noti_bg:bg_alpha(0)
		NotiCountdown = NotiDelay
	elseif buff == 253 and notifications.Signet then --Signet
		if AlertSounds then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Signet Has Worn Off »»')
		hud_noti:text('«« Signet Has Worn Off »»')
		hud_noti:color(255,50,50)
		hud_noti_bg:bg_alpha(0)
		NotiCountdown = NotiDelay
	elseif buff == 256 and notifications.Signet then --Sanction
		if AlertSounds then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Sanction Has Worn Off »»')
		hud_noti:text('«« Sanction Has Worn Off »»')
		hud_noti:color(255,50,50)
		hud_noti_bg:bg_alpha(0)
		NotiCountdown = NotiDelay
	elseif buff == 268 and notifications.Signet then --Sigil
		if AlertSounds then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Sigil Has Worn Off »»')
		hud_noti:text('«« Sigil Has Worn Off »»')
		hud_noti:color(255,50,50)
		hud_noti_bg:bg_alpha(0)
		NotiCountdown = NotiDelay
	elseif buff == 512 and notifications.Signet then --Ionis
		if AlertSounds then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Ionis Has Worn Off »»')
		hud_noti:text('«« Ionis Has Worn Off »»')
		hud_noti:color(255,50,50)
		hud_noti_bg:bg_alpha(0)
		NotiCountdown = NotiDelay
	elseif buff == 1 and Alive then --Weakness
		if AlertSounds then
			play_sound(Notification_Good)
		end
		hud_noti_shdw:text('«« Weakness Has Worn Off »»')
		hud_noti:text('«« Weakness Has Worn Off »»')
		hud_noti:color(75,255,75)
		hud_noti_bg:bg_alpha(0)
		NotiCountdown = NotiDelay
	elseif buff == 2 or buff == 19 or buff == 7 or buff == 10 or buff == 28 then --lose sleep, petrify, stun, or terror run choose_set since we changed gear for those
		choose_set()
	elseif buff == 15 then --Doom
		DangerCountdown = 0 --Set to 0 to turn the sound off when we are no longer Doomed
	elseif buff == 71 or buff == 69 then --Sneak or Invisible
		send_command('gs c ClearNotifications')
	elseif buff == 252 then --Mounted
		send_command('wait .5;gs c ClearNotifications')
	elseif buff == 523 or buff == 524 or buff == 525 or buff == 526 or buff == 527 or buff == 528 or buff == 529 or buff == 530 then
		checkRunes() --any runes wear off, check if they all wore off
	end
end)

function buff_refresh(name)
	if name == "Aftermath" or name == "Aftermath: Lv.1" then
		AMTimer = pre_AMTimer
		mythicNum = pre_mythicNum
		primeNum = pre_primeNum
	end
end

windower.register_event('tp change',function()
	if player.tp == 3000 and notifications.TP3000 then
		if AlertSounds then
			play_sound(Notification_3000TP)
		end
		local c = color.AM3
		hud_noti_shdw:text('«« 3000 TP »»')
		hud_noti:text('«« 3000 TP »»')
		hud_noti:color(c.r,c.g,c.b)
		hud_noti_bg:bg_alpha(0)
		NotiCountdown = NotiDelay
	end

	--HUD TP Meter
	if not (TownZones:contains(world.area) or windower.ffxi.get_info().mog_house) then
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
		if player.equipment.main == "Epeolatry" then
			mythicAMUpdate(player_tp)
		elseif player.equipment.main == 'Helheim' then
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

	--Polling rate
	local current_time = os.clock()

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

		--Aftermath checks
		if SwitchingWeapons == 0 then
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
			if player.equipment.main == 'Helheim' then
				if buffactive['Aftermath: Lv.1'] then
					if currentAfterMath ~= 'PrimeAM1' or primeNum ~= currentPrimeNum or currentAMTimer ~= AMTimer then
						currentAfterMath = 'PrimeAM1'
						currentPrimeNum = primeNum
						currentAMTimer = AMTimer
						local am_time = formatAMTime(currentAMTimer)
						hud_weapons_shdw:text(formatWeapons('AM1: (Phys Dmg Lmt +'..primeNum..'%) '..am_time))
						hud_weapons:text(formatWeapons('AM1: (Phys Dmg Lmt +'..primeNum..'%) '..am_time))
						colorWeaponsText(1)
					end
				elseif buffactive['Aftermath: Lv.2'] then
					if currentAfterMath ~= 'PrimeAM2' or currentAMTimer ~= AMTimer then
						currentAfterMath = 'PrimeAM2'
						currentAMTimer = AMTimer
						local am_time = formatAMTime(currentAMTimer)
						hud_weapons_shdw:text(formatWeapons('AM2: (Phys Dmg Lmt +'..primeNum..'%) '..am_time))
						hud_weapons:text(formatWeapons('AM2: (Phys Dmg Lmt +'..primeNum..'%) '..am_time))
						colorWeaponsText(2)
					end
				elseif buffactive['Aftermath: Lv.3'] then
					if currentAfterMath ~= 'PrimeAM3' or currentAMTimer ~= AMTimer then
						currentAfterMath = 'PrimeAM3'
						currentAMTimer = AMTimer
						local am_time = formatAMTime(currentAMTimer)
						hud_weapons_shdw:text(formatWeapons('AM3: (Phys Dmg Lmt +'..primeNum..'%) '..am_time))
						hud_weapons:text(formatWeapons('AM3: (Phys Dmg Lmt +'..primeNum..'%) '..am_time))
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
			elseif player.equipment.main == 'Epeolatry' then
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
			elseif player.equipment.main == 'Lionheart' then
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
						hud_weapons_shdw:text(formatWeapons('AM2:(3-Step Ultimate SC) '..am_time))
						hud_weapons:text(formatWeapons('AM2:(3-Step Ultimate SC) '..am_time))
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
		elseif active_buffs['stun'] and notifications.Stun and Alive then
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

		--Auto Mode Combat check
		if Mode == 'Auto-Parry' or Mode == 'Auto-DT' then
			if windower.ffxi.get_player() and windower.ffxi.get_player().in_combat then
				if not player_in_combat then
					player_in_combat = true
					choose_set()
					hud_mode_shdw:text('Mode: Auto (Combat)')
					hud_mode:text('Mode: Auto (Combat)')
					local c = Mode == 'Auto-Parry' and color.CombatParry or color.CombatDT
					hud_bg_color:bg_color(c.r,c.g,c.b)
				end
			else
				if player_in_combat then
					player_in_combat = false
					choose_set()
					hud_mode_shdw:text('Mode: Auto (Neutral)')
					hud_mode:text('Mode: Auto (Neutral)')
					local c = color.Neutral
					hud_bg_color:bg_color(c.r,c.g,c.b)
				end
			end
		end

		--MP checks
		if notifications.LowMP and player and player.mpp <= 20 and not NotiLowMPToggle then
			NotiLowMPToggle = true --turn the toggle on so this can't be triggered again until its toggled off (done below)
			if AlertSounds then
				play_sound(Notification_Bad)
			end
			hud_noti_shdw:text('«« Low MP »»')
			hud_noti:text('«« Low MP »»')
			hud_noti:color(255,50,50)
			hud_noti_bg:bg_alpha(0)
			NotiCountdown = NotiDelay
			send_command('wait 30;gs c NotiLowMPToggle') --wait 30 sec then turns the toggle back off
		end

		--HP checks
		if player.hp == 0 then --are we dead?
			if Alive then
				hud_noti_shdw:text('Status: Dead X_x')
				hud_noti:text('Status: Dead X_x')
				hud_noti:color(255,50,50)
				hud_noti_bg:bg_alpha(0)
				NotiCountdown = -1
				Alive = false
				announceAlive = true
				DangerCountdown = 0
				if LowHP then
					LowHP = false
				end
				send_command('gs c ClearRunes')
			end
		else
			if not Alive and announceAlive then
				hud_noti_shdw:text('Status: Alive ^_^')
				hud_noti:text('Status: Alive ^_^')
				hud_noti:color(75,255,75)
				hud_noti_bg:bg_alpha(0)
				NotiCountdown = -1
				announceAlive = false
				send_command('wait 1;gs c AliveDelay') --we use a command to set this to true so that we can set a short delay to prevent things from triggering right when we raise
			end
			if player.hp <= LowHPThreshold and player.max_hp > LowHPThreshold and not (buffactive['weakness'] or TownZones:contains(world.area) or windower.ffxi.get_info().mog_house) then --when HP goes below a certain amount, turn on the LowHP flag and equip the appropriate gear set
				if not LowHP then
					LowHP = true
					DangerCountdown = DangerRepeat
					choose_set()
				end
			elseif player.hp > LowHPThreshold and LowHP then --when HP goes back above a certain amount, turn off the LowHP flag and equip the appropriate gear set
				send_command('gs c ClearNotifications')
				LowHP = false
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

		if buffactive['Enmity Boost'] and buffactive['Phalanx'] and (buffactive['Battuta'] or buffactive['Swordplay']) and (buffactive['Ignis'] or buffactive['Gelus'] or buffactive['Flabra'] or buffactive['Tellus'] or buffactive['Sulpor'] or buffactive['Unda'] or buffactive['Lux'] or buffactive['Tenebrae']) and player_in_combat then
			hud_mode_shdw:text('Mode: '..Mode..' (Beast)')
			hud_mode:text('Mode: '..Mode..' (Beast)')
		else
			if Mode == 'Auto-Parry' or Mode == 'Auto-DT' then
				if player_in_combat then
					hud_mode_shdw:text('Mode: '..Mode..' (Combat)')
					hud_mode:text('Mode: '..Mode..' (Combat)')
					local c = Mode == 'Auto-Parry' and color.CombatParry or color.CombatDT
					hud_bg_color:bg_color(c.r,c.g,c.b)
				else
					if TownZones:contains(world.area) or windower.ffxi.get_info().mog_house then
						hud_mode_shdw:text('Mode: '..Mode)
						hud_mode:text('Mode: '..Mode)
						local c = color[fMode[Mode]]
						hud_bg_color:bg_color(c.r,c.g,c.b)
					else
						hud_mode_shdw:text('Mode: '..Mode..' (Neutral)')
						hud_mode:text('Mode: '..Mode..' (Neutral)')
						local c = color.Neutral
						hud_bg_color:bg_color(c.r,c.g,c.b)
					end
				end
			else
				hud_mode_shdw:text('Mode: '..Mode)
				hud_mode:text('Mode: '..Mode)
				local c = color[fMode[Mode]]
				hud_bg_color:bg_color(c.r,c.g,c.b)
			end
		end

		--Recast color updates
		if ElementalSforzo.recast then
			if buffactive['Elemental Sforzo'] then
				textColor('Elemental Sforzo','active')
				ElementalSforzo.flashed = false
			elseif ElementalSforzo.recast > 0 then
				textColor('Elemental Sforzo','cooldown')
				ElementalSforzo.flashed = false
			else
				textColor('Elemental Sforzo','ready')
				if not ElementalSforzo.flashed then
					flash('Elemental Sforzo')
				end
				ElementalSforzo.flashed = true
			end
		else
			textColor('Elemental Sforzo','notfound')
		end

		if OdyllicSubterfuge.recast then
			if OdyllicSubterfuge.recast > 0 then
				textColor('Odyllic Subterfuge','cooldown')
				OdyllicSubterfuge.flashed = false
			else
				textColor('Odyllic Subterfuge','ready')
				if not OdyllicSubterfuge.flashed then
					flash('Odyllic Subterfuge')
				end
				OdyllicSubterfuge.flashed = true
			end
		else
			textColor('Odyllic Subterfuge','notfound')
		end

		if Aggressor.recast then
			if buffactive['Aggressor'] then
				textColor('Aggressor','active')
				Aggressor.flashed = false
			elseif Aggressor.recast > 0 then
				textColor('Aggressor','cooldown')
				Aggressor.flashed = false
			else
				textColor('Aggressor','ready')
				if not Aggressor.flashed then
					flash('Aggressor')
				end
				Aggressor.flashed = true
			end
		else
			textColor('Aggressor','notfound')
		end

		if ArcaneCircle.recast then
			if buffactive['Arcane Circle'] then
				textColor('Arcane Circle','active')
				ArcaneCircle.flashed = false
			elseif ArcaneCircle.recast > 0 then
				textColor('Arcane Circle','cooldown')
				ArcaneCircle.flashed = false
			else
				textColor('Arcane Circle','ready')
				if not ArcaneCircle.flashed then
					flash('Arcane Circle')
				end
				ArcaneCircle.flashed = true
			end
		else
			textColor('Arcane Circle','notfound')
		end

		if Battuta.recast then
			if buffactive['Battuta'] then
				textColor('Battuta','active')
				Battuta.flashed = false
			elseif Battuta.recast > 0 then
				textColor('Battuta','cooldown')
				Battuta.flashed = false
			else
				textColor('Battuta','ready')
				if not Battuta.flashed then
					flash('Battuta')
				end
				Battuta.flashed = true
			end
		else
			textColor('Battuta','notfound')
		end

		if Berserk.recast then
			if buffactive['Berserk'] then
				textColor('Berserk','active')
				Berserk.flashed = false
			elseif Berserk.recast > 0 then
				textColor('Berserk','cooldown')
				Berserk.flashed = false
			else
				textColor('Berserk','ready')
				if not Berserk.flashed then
					flash('Berserk')
				end
				Berserk.flashed = true
			end
		else
			textColor('Berserk','notfound')
		end

		if Cocoon.recast then
			if buffActive(93) then
				textColor('Cocoon','active')
				Cocoon.flashed = false
			elseif Cocoon.recast > 0 then
				textColor('Cocoon','cooldown')
				Cocoon.flashed = false
			else
				textColor('Cocoon','ready')
				if not Cocoon.flashed then
					flash('Cocoon')
				end
				Cocoon.flashed = true
			end
		else
			textColor('Cocoon','notfound')
		end

		if ConsumeMana.recast then
			if buffactive['Consume Mana'] then
				textColor('Consume Mana','active')
				ConsumeMana.flashed = false
			elseif ConsumeMana.recast > 0 then
				textColor('Consume Mana','cooldown')
				ConsumeMana.flashed = false
			else
				textColor('Consume Mana','ready')
				if not ConsumeMana.flashed then
					flash('Consume Mana')
				end
				ConsumeMana.flashed = true
			end
		else
			textColor('Consume Mana','notfound')
		end

		if Cover.recast then
			if buffactive['Cover'] then
				textColor('Cover','active')
				Cover.flashed = false
			elseif Cover.recast > 0 then
				textColor('Cover','cooldown')
				Cover.flashed = false
			else
				textColor('Cover','ready')
				if not Cover.flashed then
					flash('Cover')
				end
				Cover.flashed = true
			end
		else
			textColor('Cover','notfound')
		end

		if Crusade.recast then
			if buffactive['Enmity Boost'] then
				textColor('Crusade','active')
				Crusade.flashed = false
			elseif Crusade.recast > 0 then
				textColor('Crusade','cooldown')
				Crusade.flashed = false
			else
				textColor('Crusade','ready')
				if not Crusade.flashed then
					flash('Crusade')
				end
				Crusade.flashed = true
			end
		else
			textColor('Crusade','notfound')
		end

		if Defender.recast then
			if buffactive['Defender'] then
				textColor('Defender','active')
				Defender.flashed = false
			elseif Defender.recast > 0 then
				textColor('Defender','cooldown')
				Defender.flashed = false
			else
				textColor('Defender','ready')
				if not Defender.flashed then
					flash('Defender')
				end
				Defender.flashed = true
			end
		else
			textColor('Defender','notfound')
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

		if Embolden.recast then
			if buffactive['Embolden'] then
				textColor('Embolden','active')
				Embolden.flashed = false
			elseif Embolden.recast > 0 then
				textColor('Embolden','cooldown')
				Embolden.flashed = false
			else
				textColor('Embolden','ready')
				if not Embolden.flashed then
					flash('Embolden')
				end
				Embolden.flashed = true
			end
		else
			textColor('Embolden','notfound')
		end

		if Gambit.recast then
			if Gambit.recast > 0 then
				textColor('Gambit','cooldown')
				Gambit.flashed = false
			else
				textColor('Gambit','ready')
				if not Gambit.flashed then
					flash('Gambit')
				end
				Gambit.flashed = true
			end
		else
			textColor('Gambit','notfound')
		end

		if Hasso.recast then
			if buffactive['Hasso'] then
				textColor('Hasso','active')
				Hasso.flashed = false
			elseif Hasso.recast > 0 then
				textColor('Hasso','cooldown')
				Hasso.flashed = false
			else
				textColor('Hasso','ready')
				if not Hasso.flashed then
					flash('Hasso')
				end
				Hasso.flashed = true
			end
		else
			textColor('Hasso','notfound')
		end

		if HolyCircle.recast then
			if buffactive['Holy Circle'] then
				textColor('Holy Circle','active')
				HolyCircle.flashed = false
			elseif HolyCircle.recast > 0 then
				textColor('Holy Circle','cooldown')
				HolyCircle.flashed = false
			else
				textColor('Holy Circle','ready')
				if not HolyCircle.flashed then
					flash('Holy Circle')
				end
				HolyCircle.flashed = true
			end
		else
			textColor('Holy Circle','notfound')
		end

		if LastResort.recast then
			if buffactive['Last Resort'] then
				textColor('Last Resort','active')
				LastResort.flashed = false
			elseif LastResort.recast > 0 then
				textColor('Last Resort','cooldown')
				LastResort.flashed = false
			else
				textColor('Last Resort','ready')
				if not LastResort.flashed then
					flash('Last Resort')
				end
				LastResort.flashed = true
			end
		else
			textColor('Last Resort','notfound')
		end

		if Liement.recast then
			if buffactive['Liement'] then
				textColor('Liement','active')
				Liement.flashed = false
			elseif Liement.recast > 0 then
				textColor('Liement','cooldown')
				Liement.flashed = false
			else
				textColor('Liement','ready')
				if not Liement.flashed then
					flash('Liement')
				end
				Liement.flashed = true
			end
		else
			textColor('Liement','notfound')
		end

		if Lunge.recast then
			if Lunge.recast > 0 then
				textColor('Lunge','cooldown')
				Lunge.flashed = false
			else
				textColor('Lunge','ready')
				if not Lunge.flashed then
					flash('Lunge')
				end
				Lunge.flashed = true
			end
		else
			textColor('Lunge','notfound')
		end

		if Meditate.recast then
			if Meditate.recast > 0 then
				textColor('Meditate','cooldown')
				Meditate.flashed = false
			else
				textColor('Meditate','ready')
				if not Meditate.flashed then
					flash('Meditate')
				end
				Meditate.flashed = true
			end
		else
			textColor('Meditate','notfound')
		end

		if OneforAll.recast then
			if buffactive['One for All'] then
				textColor('One for All','active')
				OneforAll.flashed = false
			elseif OneforAll.recast > 0 then
				textColor('One for All','cooldown')
				OneforAll.flashed = false
			else
				textColor('One for All','ready')
				if not OneforAll.flashed then
					flash('One for All')
				end
				OneforAll.flashed = true
			end
		else
			textColor('One for All','notfound')
		end

		if Pflug.recast then
			if buffactive['Pflug'] then
				textColor('Pflug','active')
				Pflug.flashed = false
			elseif Pflug.recast > 0 then
				textColor('Pflug','cooldown')
				Pflug.flashed = false
			else
				textColor('Pflug','ready')
				if not Pflug.flashed then
					flash('Pflug')
				end
				Pflug.flashed = true
			end
		else
			textColor('Pflug','notfound')
		end

		if Phalanx.recast then
			if buffactive['Phalanx'] then
				textColor('Phalanx','active')
				Phalanx.flashed = false
			elseif Phalanx.recast > 0 then
				textColor('Phalanx','cooldown')
				Phalanx.flashed = false
			else
				textColor('Phalanx','ready')
				if not Phalanx.flashed then
					flash('Phalanx')
				end
				Phalanx.flashed = true
			end
		else
			textColor('Phalanx','notfound')
		end

		if Rayke.recast then
			if Rayke.recast > 0 then
				textColor('Rayke','cooldown')
				Rayke.flashed = false
			else
				textColor('Rayke','ready')
				if not Rayke.flashed then
					flash('Rayke')
				end
				Rayke.flashed = true
			end
		else
			textColor('Rayke','notfound')
		end

		--Refueling
		if Refueling.recast then
			if buffActive(33) then
				textColor('Refueling','active')
				Refueling.flashed = false
			elseif Refueling.recast > 0 then
				textColor('Refueling','cooldown')
				Refueling.flashed = false
			else
				textColor('Refueling','ready')
				if not Refueling.flashed then
					flash('Refueling')
				end
				Refueling.flashed = true
			end
		else
			textColor('Refueling','notfound')
		end

		if Seigan.recast then
			if buffactive['Seigan'] then
				textColor('Seigan','active')
				Seigan.flashed = false
			elseif Seigan.recast > 0 then
				textColor('Seigan','cooldown')
				Seigan.flashed = false
			else
				textColor('Seigan','ready')
				if not Seigan.flashed then
					flash('Seigan')
				end
				Seigan.flashed = true
			end
		else
			textColor('Seigan','notfound')
		end

		if Sekkanoki.recast then
			if buffactive['Sekkanoki'] then
				textColor('Sekkanoki','active')
				Sekkanoki.flashed = false
			elseif Sekkanoki.recast > 0 then
				textColor('Sekkanoki','cooldown')
				Sekkanoki.flashed = false
			else
				textColor('Sekkanoki','ready')
				if not Sekkanoki.flashed then
					flash('Sekkanoki')
				end
				Sekkanoki.flashed = true
			end
		else
			textColor('Sekkanoki','notfound')
		end

		if Sentinel.recast then
			if buffactive['Sentinel'] then
				textColor('Sentinel','active')
				Sentinel.flashed = false
			elseif Sentinel.recast > 0 then
				textColor('Sentinel','cooldown')
				Sentinel.flashed = false
			else
				textColor('Sentinel','ready')
				if not Sentinel.flashed then
					flash('Sentinel')
				end
				Sentinel.flashed = true
			end
		else
			textColor('Sentinel','notfound')
		end

		if Souleater.recast then
			if buffactive['Souleater'] then
				textColor('Souleater','active')
				Souleater.flashed = false
			elseif Souleater.recast > 0 then
				textColor('Souleater','cooldown')
				Souleater.flashed = false
			else
				textColor('Souleater','ready')
				if not Souleater.flashed then
					flash('Souleater')
				end
				Souleater.flashed = true
			end
		else
			textColor('Souleater','notfound')
		end

		if Stoneskin.recast then
			if buffactive['Stoneskin'] then
				textColor('Stoneskin','active')
				Stoneskin.flashed = false
			elseif Stoneskin.recast > 0 then
				textColor('Stoneskin','cooldown')
				Stoneskin.flashed = false
			else
				textColor('Stoneskin','ready')
				if not Stoneskin.flashed then
					flash('Stoneskin')
				end
				Stoneskin.flashed = true
			end
		else
			textColor('Stoneskin','notfound')
		end

		if Swipe.recast then
			if Swipe.recast > 0 then
				textColor('Swipe','cooldown')
				Swipe.flashed = false
			else
				textColor('Swipe','ready')
				if not Swipe.flashed then
					flash('Swipe')
				end
				Swipe.flashed = true
			end
		else
			textColor('Swipe','notfound')
		end

		if Swordplay.recast then
			if buffactive['Swordplay'] then
				textColor('Swordplay','active')
				Swordplay.flashed = false
			elseif Swordplay.recast > 0 then
				textColor('Swordplay','cooldown')
				Swordplay.flashed = false
			else
				textColor('Swordplay','ready')
				if not Swordplay.flashed then
					flash('Swordplay')
				end
				Swordplay.flashed = true
			end
		else
			textColor('Swordplay','notfound')
		end

		if ThirdEye.recast then
			if buffactive['Third Eye'] then
				textColor('Third Eye','active')
				ThirdEye.flashed = false
			elseif ThirdEye.recast > 0 then
				textColor('Third Eye','cooldown')
				ThirdEye.flashed = false
			else
				textColor('Third Eye','ready')
				if not ThirdEye.flashed then
					flash('Third Eye')
				end
				ThirdEye.flashed = true
			end
		else
			textColor('Third Eye','notfound')
		end

		if Valiance.recast then
			if buffactive['Valiance'] then
				textColor('Valiance','active')
				Valiance.flashed = false
			elseif Valiance.recast > 0 then
				textColor('Valiance','cooldown')
				Valiance.flashed = false
			else
				textColor('Valiance','ready')
				if not Valiance.flashed then
					flash('Valiance')
				end
				Valiance.flashed = true
			end
		else
			textColor('Valiance','notfound')
		end

		if Vallation.recast then
			if buffactive['Vallation'] then
				textColor('Vallation','active')
				Vallation.flashed = false
			elseif Vallation.recast > 0 then
				textColor('Vallation','cooldown')
				Vallation.flashed = false
			else
				textColor('Vallation','ready')
				if not Vallation.flashed then
					flash('Vallation')
				end
				Vallation.flashed = true
			end
		else
			textColor('Vallation','notfound')
		end

		if VivaciousPulse.recast then
			if VivaciousPulse.recast > 0 then
				textColor('Vivacious Pulse','cooldown')
				VivaciousPulse.flashed = false
			else
				textColor('Vivacious Pulse','ready')
				if not VivaciousPulse.flashed then
					flash('Vivacious Pulse')
				end
				VivaciousPulse.flashed = true
			end
		else
			textColor('Vivacious Pulse','notfound')
		end

		if Warcry.recast then
			if buffactive['Warcry'] then
				textColor('Warcry','active')
				Warcry.flashed = false
			elseif Warcry.recast > 0 then
				textColor('Warcry','cooldown')
				Warcry.flashed = false
			else
				textColor('Warcry','ready')
				if not Warcry.flashed then
					flash('Warcry')
				end
				Warcry.flashed = true
			end
		else
			textColor('Warcry','notfound')
		end

		if WardingCircle.recast then
			if buffactive['Warding Circle'] then
				textColor('Warding Circle','active')
				WardingCircle.flashed = false
			elseif WardingCircle.recast > 0 then
				textColor('Warding Circle','cooldown')
				WardingCircle.flashed = false
			else
				textColor('Warding Circle','ready')
				if not WardingCircle.flashed then
					flash('Warding Circle')
				end
				WardingCircle.flashed = true
			end
		else
			textColor('Warding Circle','notfound')
		end

		if WeaponBash.recast then
			if WeaponBash.recast > 0 then
				textColor('Weapon Bash','cooldown')
				WeaponBash.flashed = false
			else
				textColor('Weapon Bash','ready')
				if not WeaponBash.flashed then
					flash('Weapon Bash')
				end
				WeaponBash.flashed = true
			end
		else
			textColor('Weapon Bash','notfound')
		end

	end

	--1 second heartbeat
	if current_time - last_second >= 1 then

		last_second = current_time

		if Rune1Timer > 151 then
			Rune1Timer = Rune1Timer - 1
			hud_rune01_shdw:text(formatRunes(Rune1))
			hud_rune01:text(formatRunes(Rune1))
			local c = color[Rune1BGColor]
			hud_rune01_bg:bg_color(c.r,c.g,c.b)
			hud_rune01_bg:bg_alpha(150)
		elseif Rune1Timer > 21 then
			Rune1Timer = Rune1Timer - 1
			hud_rune01_shdw:text(formatRunes(Rune1))
			hud_rune01:text(formatRunes(Rune1))
			local c = color[Rune1BGColor]
			hud_rune01_bg:bg_color(c.r,c.g,c.b)
			hud_rune01_bg:bg_alpha(Rune1Timer)
		elseif Rune1Timer > 0 then
			Rune1Timer = Rune1Timer - 1
			hud_rune01_shdw:text(formatRunes('Wearing off in '..Rune1Timer))
			hud_rune01:text(formatRunes('Wearing off in '..Rune1Timer))
			local c = color[Rune1BGColor]
			hud_rune01_bg:bg_color(c.r,c.g,c.b)
			hud_rune01_bg:bg_alpha(150)
		else
			Rune1 = 'No Rune'
			hud_rune01_shdw:text(formatRunes(Rune1))
			hud_rune01:text(formatRunes(Rune1))
			hud_rune01_bg:bg_alpha(0)
		end
		if Rune2Timer > 151 then
			Rune2Timer = Rune2Timer - 1
			hud_rune02_shdw:text(formatRunes(Rune2))
			hud_rune02:text(formatRunes(Rune2))
			local c = color[Rune2BGColor]
			hud_rune02_bg:bg_color(c.r,c.g,c.b)
			hud_rune02_bg:bg_alpha(150)
		elseif Rune2Timer > 21 then
			Rune2Timer = Rune2Timer - 1
			hud_rune02_shdw:text(formatRunes(Rune2))
			hud_rune02:text(formatRunes(Rune2))
			local c = color[Rune2BGColor]
			hud_rune02_bg:bg_color(c.r,c.g,c.b)
			hud_rune02_bg:bg_alpha(Rune2Timer)
		elseif Rune2Timer > 0 then
			Rune2Timer = Rune2Timer - 1
			hud_rune02_shdw:text(formatRunes('Wearing off in '..Rune2Timer))
			hud_rune02:text(formatRunes('Wearing off in '..Rune2Timer))
			local c = color[Rune2BGColor]
			hud_rune02_bg:bg_color(c.r,c.g,c.b)
			hud_rune02_bg:bg_alpha(150)
		else
			Rune2 = 'No Rune'
			hud_rune02_shdw:text(formatRunes(Rune2))
			hud_rune02:text(formatRunes(Rune2))
			hud_rune02_bg:bg_alpha(0)
		end
		if Rune3Timer > 151 then
			Rune3Timer = Rune3Timer - 1
			hud_rune03_shdw:text(formatRunes(Rune3))
			hud_rune03:text(formatRunes(Rune3))
			local c = color[Rune3BGColor]
			hud_rune03_bg:bg_color(c.r,c.g,c.b)
			hud_rune03_bg:bg_alpha(150)
		elseif Rune3Timer > 21 then
			Rune3Timer = Rune3Timer - 1
			hud_rune03_shdw:text(formatRunes(Rune3))
			hud_rune03:text(formatRunes(Rune3))
			local c = color[Rune3BGColor]
			hud_rune03_bg:bg_color(c.r,c.g,c.b)
			hud_rune03_bg:bg_alpha(Rune3Timer)
		elseif Rune3Timer > 0 then
			Rune3Timer = Rune3Timer - 1
			hud_rune03_shdw:text(formatRunes('Wearing off in '..Rune3Timer))
			hud_rune03:text(formatRunes('Wearing off in '..Rune3Timer))
			local c = color[Rune3BGColor]
			hud_rune03_bg:bg_color(c.r,c.g,c.b)
			hud_rune03_bg:bg_alpha(150)
		else
			Rune3 = 'No Rune'
			hud_rune03_shdw:text(formatRunes(Rune3))
			hud_rune03:text(formatRunes(Rune3))
			hud_rune03_bg:bg_alpha(0)
		end

		if (buffactive['Hasso'] or buffactive['Seigan']) then
			StanceTimer = StanceTimer - 1
		end

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
					hud_noti_bg:bg_alpha(0)
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
			hud_noti_bg:bg_alpha(0)
			flash('Noti')	
			NotiCountdown = -1
		end

		if notifications.Doom and buffactive['doom'] then
			flash('Debuffs')
		end
		if (notifications.Doom and buffactive['doom']) or (notifications.LowHP and LowHP and Alive and not (buffactive['weakness'] or TownZones:contains(world.area) or windower.ffxi.get_info().mog_house)) and AlertSounds and DangerCountdown > 0 then
			DangerCountdown = DangerCountdown - 1
			play_sound(Notification_Danger)
		end

		if NotiCountdown > 0 then
			NotiCountdown = NotiCountdown - 1
		elseif NotiCountdown == 0 then
			send_command('gs c ClearNotifications')
			NotiCountdown = -1
		end

		if SwitchingWeapons > 0 then
			SwitchingWeapons = SwitchingWeapons - 1
		end

		if GreetingDelay > 0 then
			GreetingDelay = GreetingDelay - 1
		elseif GreetingDelay == 0 then
			send_command('gs c ClearNotifications')
			GreetingDelay = -1
		end

		if party and party_count == 1 and party_count ~= party.count then
			party_count = party.count
			send_command('gs c ClearNotifications')
		elseif party and party_count ~= 1 and party.count == 1 then
			party_count = 1
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
	send_command('gs c ClearNotifications')

	--Clear any debuffs
	send_command('gs c ClearDebuffs')

	--Clear any runes
	send_command('gs c ClearRunes')

end)

-------------------------------------------
--           SUB JOB CHANGE              --
-------------------------------------------

function sub_job_change(newSubjob, oldSubjob)

	if GreetingDelay == -1 then
		send_command('gs c ClearNotifications')
	end

	-- Reset HUD Abilities/Spells and Macro Page
	if newSubjob == 'BLU' then
		subjob = 'BLU'
		if SubBLUPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubBLUPage)
		end
	elseif newSubjob == 'DRK' then
		subjob = 'DRK'
		if SubDRKPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubDRKPage)
		end
	elseif newSubjob == 'WHM' then
		subjob = 'WHM'
		if SubWHMPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubWHMPage)
		end
	elseif newSubjob == 'PLD' then
		subjob = 'PLD'
		if SubPLDPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubPLDPage)
		end
	elseif newSubjob == 'SAM' then
		subjob = 'SAM'
		if SubSAMPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubSAMPage)
		end
	elseif newSubjob == 'WAR' then
		subjob = 'WAR'
		if SubWARPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubWARPage)
		end
	else
		subjob = 'OTH'
	end
	getHUDAbils()

	if ZoneGear ~= 'Off' then
		send_command('wait 2;gs c Zone Gear')
	end

end

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
			hud_noti_bg:bg_alpha(0)
		end
	elseif org:find('The effect of') and org:find('is about to wear off.') then
		if AlertSounds then
			play_sound(Notification_Bad)
		end
		if notifications.Sneak and org:find('Sneak') then
			hud_noti_shdw:text('«« Sneak Wearing »»')
			hud_noti:text('«« Sneak Wearing »»')
			hud_noti:color(255,100,100)
			hud_noti_bg:bg_alpha(0)
		elseif notifications.Invis and org:find('Invisible') then
			hud_noti_shdw:text('«« Invisible Wearing »»')
			hud_noti:text('«« Invisible Wearing »»')
			hud_noti:color(255,100,100)
			hud_noti_bg:bg_alpha(0)
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
			hud_noti_bg:bg_alpha(0)
		elseif notifications.Invite and org:find('alliance') then
			hud_noti_shdw:text('«« Alliance Invite »»')
			hud_noti:text('«« Alliance Invite »»')
			hud_noti:color(255,255,50)
			hud_noti_bg:bg_alpha(0)
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
				hud_noti_bg:bg_alpha(0)
			end
		elseif org:find(' 10 ') then
			if AlertSounds then
				play_sound(Notification_Bad)
			end
			if notifications.Time then
				hud_noti_shdw:text('«« 10 Minutes Remaining »»')
				hud_noti:text('«« 10 Minutes Remaining »»')
				hud_noti:color(255,255,50)
				hud_noti_bg:bg_alpha(0)
			end
		elseif org:find(' 5 ') then
			if AlertSounds then
				play_sound(Notification_Bad)
			end
			if notifications.Time then
				hud_noti_shdw:text('«« 5 Minutes Remaining »»')
				hud_noti:text('«« 5 Minutes Remaining »»')
				hud_noti:color(255,255,50)
				hud_noti_bg:bg_alpha(0)
			end
		end
		NotiCountdown = NotiDelay
	elseif org:find('Trade complete') then
		send_command('gs c ClearNotifications')
	end
end)

-------------------------------------------
--         DAMAGE NOTIFICATIONS          --
-------------------------------------------

windower.register_event('action',function(act)

	if notifications.Damage then
		--Weapon Skills and Skillchains:
		if act.category == 3 and act.actor_id == player.id then
			--Weapon Skill misses:
			if act.targets[1].actions[1].message == 188 then
				hud_noti_shdw:text('«« '..weaponskills[act.param].english..' Missed »»')
				hud_noti:text('«« '..weaponskills[act.param].english..' Missed »»')
				hud_noti:color(0,255,255)
				hud_noti_bg:bg_alpha(0)
			--Weapon Skill gets blinked:
			elseif act.targets[1].actions[1].message == 31 then
				hud_noti_shdw:text('«« '..weaponskills[act.param].english..' Blinked »»')
				hud_noti:text('«« '..weaponskills[act.param].english..' Blinked »»')
				hud_noti:color(0,255,255)
				hud_noti_bg:bg_alpha(0)
			--Weapon Skill lands and creates a Skillchain:
			elseif act.targets[1].actions[1].message == 185 and act.targets[1].actions[1].has_add_effect then
				hud_noti_shdw:text(weaponskills[act.param].english..': '..addCommas(act.targets[1].actions[1].param)..' ('..sc[act.targets[1].actions[1].add_effect_animation]..': '..addCommas(act.targets[1].actions[1].add_effect_param)..')')
				hud_noti:text(weaponskills[act.param].english..': '..addCommas(act.targets[1].actions[1].param)..' ('..sc[act.targets[1].actions[1].add_effect_animation]..': '..addCommas(act.targets[1].actions[1].add_effect_param)..')')
				hud_noti:color(0,255,255)
				hud_noti_bg:bg_alpha(0)
			--Weapon Skill lands but no Skillchain:
			elseif act.targets[1].actions[1].message == 185 then
				hud_noti_shdw:text(weaponskills[act.param].english..': '..addCommas(act.targets[1].actions[1].param))
				hud_noti:text(weaponskills[act.param].english..': '..addCommas(act.targets[1].actions[1].param))
				hud_noti:color(0,255,255)
				hud_noti_bg:bg_alpha(0)
			end
			NotiCountdown = -1
		--Lunge/Swipe Magic Bursts:
		elseif (act.category == 15 and act.targets[1].actions[1].message == 110 and act.targets[1].actions[1].unknown == 4) and act.actor_id == player.id then
			hud_noti_shdw:text('Magic Burst! '..jobabilities[act.param].english..': '..addCommas(act.targets[1].actions[1].param))
			hud_noti:text('Magic Burst! '..jobabilities[act.param].english..': '..addCommas(act.targets[1].actions[1].param))
			hud_noti:color(0,255,255)
			hud_noti_bg:bg_alpha(0)
			NotiCountdown = -1
		end
	end
end)

-------------------------------------------
--             FILE UNLOAD               --
-------------------------------------------

function file_unload()

	--Delete our aliases and binds, thank you for your service
	send_command('unalias runecycle')
	send_command('unalias runestone')
	send_command('unalias runeearth')
	send_command('unalias runewater')
	send_command('unalias runeaero')
	send_command('unalias runewind')
	send_command('unalias runefire')
	send_command('unalias runeblizzard')
	send_command('unalias runeice')
	send_command('unalias runethunder')
	send_command('unalias runelightning')
	send_command('unalias runedark')
	send_command('unalias runelight')
	send_command('unalias rune')
	send_command('unalias mode')
	send_command('unalias wc')
	send_command('unalias hud')
	send_command('unbind '..ModeBind)
	send_command('unbind '..WCBind)

end

--[[

-------------------------------------------
--            KEYS NOTEPAD               --
-------------------------------------------

/BLU spells:

Option 1
--------

30 points: (sub job 50, ML19 or under)
Cocoon(1)			-Cast for defense
Blank Gaze(2)		-Cast for single target hate
Jettatura(4)		-Cast for single target/narrow frontal cone hate
Sheep Song(2) 		-Cast for AOE hate
Geist Wall(3)		-Cast for AOE hate
Stinking Gas(2)		-Cast for AOE hate
Wild Carrot(3)		-Cast for cures, Resist Sleep trait (can change this to Magic Fruit at ML45)
Pollen(1)			-Resist Sleep trait
Terror Touch(3)		-Defense Bonus trait
Grand Slam(2)		-Defense Bonus trait
Foot Kick(2)		-Lizard Killer trait (includes Gabbrath)
Claw Cyclone(2)		-Lizard Killer trait
Power Attack(1)		-Plantoid Killer trait (includes Yggdreant)
Mandibular Bite(2)	-Plantoid Killer trait

35 points: (sub job 51, ML20 or higher)
Wild Oats(3)		-Beast Killed trait (includes Behemoth, Cehuetzi, Cerberus)
Sprout Smack(2)		-Beast Killer trait

Option 2
--------
(works well for both PLD and RUN main)

30 points: (sub job 50, ML19 or under)
Cocoon(1)			-Cast for defense
Blank Gaze(2)		-Cast for single target hate
Jettatura(4)		-Cast for single target/narrow frontal cone hate
Sheep Song(2) 		-Cast for AOE hate, Auto Regen trait
Geist Wall(3)		-Cast for AOE hate
Stinking Gas(2)		-Cast for AOE hate
Healing Breeze(4)	-Auto Regen trait, cast for AOE cure on RUN (PLD has Majesty)
Foot Kick(2)		-Lizard Killer trait (includes Gabbrath)
Claw Cyclone(2)		-Lizard Killer trait
Power Attack(1)		-Plantoid Killer trait (includes Yggdreant)
Mandibular Bite(2)	-Plantoid Killer trait
Wild Oats(3)		-Beast Killer trait (includes Behemoth, Cehuetzi, Cerberus)
Sprout Smack(2)		-Beast Killer trait

35 points: (sub job 51, ML20 or higher)
Screwdriver(3)		-HP+10, VIT+1 trait
Helldive(2)			-HP+5 trait

 --]]
