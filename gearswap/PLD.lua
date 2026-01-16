-------------------------------------------
--  Keys Gearswap lua file for Paladin   --
-------------------------------------------
--[[

Updates to this file and other GearSwap files and addons can be found at
https://github.com/iLVL-Key/FFXI

Place both this file and the sounds folder inside the GearSwap data folder
	/addons/GearSwap/data/sounds/
	/addons/GearSwap/data/PLD.lua

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
1. A macro
	/console wc
2. An alias command
	//wc
3. A keybind shortcut
	CTRL+H
	(Can be changed in the Advanced Options section)

--------------------

To use /BLU AOE spells, use a macro for Sheep Song and it will cycle through Sheep Song, Geist Wall,
Stinking Gas, Soporific, and Sound Blast, in that order, if they are set, and as recast timers allow.

To use /BLU Single target spells, use a macro for Flash and it will cycle through Flash, Jettatura,
and Blank Gaze, in that order, as recast timers and distance allow (or if you are /WAR it will also Provoke).

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

There are 5 Modes available in this file:
Auto-		Will decide gear based on whether or not the game thinks you are in combat. Spells will
			use their specific gear sets by themselves when you are not in combat (so you can get full
			gear bonuses), and will override them with the SIRD set if you are in combat. Will use
			idle/tank set if disengaged but in combat (ie kiting), or idle/refresh set if disengaged
			and not in combat.
Tank-		Gear set choices will always behave as if you are engaged tanking a monster.
Kite-		Gear set choices will always behave as if you are disengaged kiting a monster.
Neutral-	Gear set choices will always behave as if you are idle and NOT in combat.
DPS-		Uses the DPS gear set when in combat.

NOTE: Auto should work fine in most cases, but be aware that the game isn't always correct about when you
are in combat. For example, if you run by a mob and aggro it, you'll notice the battle music does not start.
If you are kiting a mob, and it goes yellow, the game will think you are out of combat. You can either keep
up actions on the mob to keep it claimed (voke, flash, etc) or switch into Kite mode manually.

See the very bottom of this file for /BLU spell suggestions

--]]

-------------------------------------------
--                OPTIONS                --
-------------------------------------------

Book			=	'3'		--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
SubBLUPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing BLU.
SubWARPage		=	'3'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing WAR.
SubSCHPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing SCH.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
InvTimer		=	true	--[true/false]	Displays a timer for Invincible in echo.
IntTimer		=	true	--[true/false]	Displays a timer for Intervene in echo.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions
							--				(Town limits this to town gear only).
AlertSounds		=	true	--[true/false]	Plays a sound on alerts.
UseEcho			=	'R'		--[E/R/Off]		Automatically uses an (E)cho Drop or (R)emedy instead of spell when you are silenced.
AutoMajesty		=	true	--[true/false]	Automatically activates and keeps Majesty active.
AutoDefender	=	true	--[true/false]	Automatically activates and keeps Defender active.
AutoDEmblem		=	true	--[true/false]	Automatically activates Divine Emblem before a Flash when Divine Emblem is up.
UseMaxHP		=	true	--[true/false]	Equips your Max HP gear set when you cure yourself at or near full HP%.
AutoSentinel	=	true	--[true/false]	Attempts to activate Sentinel when your HP gets critically low.
AutoSubCharge	=	true	--[true/false]	Automatically attempts to keep Sublimation charging.

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

ShowHUD			=	true	--[true/false]  Initial state of the HUD. Use `//hud` to show/hide the HUD in game.
StartMode		=	'Auto'	--[Auto/Tank/Kite/Neutral/DPS]
							--	Determines the Mode you will start in. Current Mode can be changed at any time by using any
							--	of the three options listed above in the Notes section (a macro, alias, or keyboard shortcut).
ModeBind		=	'^g'	--Sets the keyboard shortcut you would like to cycle between Modes. CTRL+G (^g) is default.
WCBind			=	'^h'	--Sets the keyboard shortcut you would like to activate the Weapon Cycle. CTRL+H (^h) is default.
							--    ^ = CTRL    ! = ALT    @ = WIN    # = APPS    ~ = SHIFT
AutoMajWindow	=	60		--Time in seconds left before Majesty wears off that AutoMajesty will activate after a cure/protect.
KeepTPThreshold	=	250		--Main/Sub slots in specific sets will not equip when TP is above this number (set to 3000 to always switch).
MaxHPThreshold	=	75		--If your HP% is above this number when you cure yourself, your Max HP gear set will activate.
							--Once it is activated, going below this will deactivate it.
LowHPThreshold	=	1000	--Below this number is considered Low HP.
DangerRepeat	=	5		--Maximum number of times the Danger Sound will repeat, once per second.
AutSntThreshold	=	500		--If your HP goes below this number, Sentinel will activate.
RRReminderTimer	=	1800	--Delay in seconds between checks to see if Reraise is up (300 is 5 minutes).
NotiDelay		=	6		--Delay in seconds before certain notifications will automatically clear.
PollingRate		=	5		--Times per second to check for various conditions (debuffs, ammo, etc). Higher rates use more CPU.
AddCommas		=	true	--[true/false]  Adds commas to damage numbers.

-------------------------------------------
--              HUD RECAST               --
-------------------------------------------

-- Controls what is displayed in the HUD Recast section.
-- The first column tells the file which ability/spell to place in that slot, the following are valid for use:
--		Invincible, Intervene, Aggressor, Berserk, Chivalry, Cocoon, Cover, Crusade, Defender, Divine Emblem, Enlight II, Fealty, Holy Circle, Majesty, Palisade, Phalanx, Rampart, Refueling, Reprisal, Sentinel, Sepulcher, Shield Bash, Stoneskin, Warcry
-- The "_sh" column allows you to change the name displayed if you would like, leave blank otherwise.
-- NOTE: Names will automatically be truncated to 10 characters to fit correctly.

sub = {
	--PLD/BLU
	BLU = {
		Abil01 = "Crusade",		Abil01_sh = "",
		Abil02 = "Phalanx",		Abil02_sh = "",
		Abil03 = "Cocoon",		Abil03_sh = "",
		Abil04 = "Palisade",	Abil04_sh = "",
		Abil05 = "Rampart",		Abil05_sh = "",
		Abil06 = "Sentinel",	Abil06_sh = "",
	},
	--PLD/WAR
	WAR = {
		Abil01 = "Crusade",		Abil01_sh = "",
		Abil02 = "Phalanx",		Abil02_sh = "",
		Abil03 = "Defender",	Abil03_sh = "",
		Abil04 = "Palisade",	Abil04_sh = "",
		Abil05 = "Rampart",		Abil05_sh = "",
		Abil06 = "Sentinel",	Abil06_sh = "",
	},
	--PLD/SCH
	SCH = {
		Abil01 = "Crusade",		Abil01_sh = "",
		Abil02 = "Phalanx",		Abil02_sh = "",
		Abil03 = "Stoneskin",	Abil03_sh = "",
		Abil04 = "Palisade",	Abil04_sh = "",
		Abil05 = "Rampart",		Abil05_sh = "",
		Abil06 = "Sentinel",	Abil06_sh = "",
	},
	--PLD/other
	OTH = {
		Abil01 = "Crusade",		Abil01_sh = "",
		Abil02 = "Phalanx",		Abil02_sh = "",
		Abil03 = "Enlight",		Abil03_sh = "",
		Abil04 = "Palisade",	Abil04_sh = "",
		Abil05 = "Rampart",		Abil05_sh = "",
		Abil06 = "Sentinel",	Abil06_sh = "",
	},
}

-------------------------------------------
--             COLOR VALUES              --
-------------------------------------------

color = {
	-- MODES --
	Auto	= {r = 125, g = 200, b = 255},
	Tank	= {r = 255, g = 125, b = 125},
	Kite	= {r = 255, g = 125, b = 255},
	Neutral	= {r = 150, g = 255, b = 150},
	DPS		= {r = 255, g = 255, b = 125},

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
	{"Burtgang", "Duban"},
	{"Malignance Sword", "Aegis"},
	--{"Main Slot", "Sub Slot"},
}

-- These are the Main/Sub combos that get added to the Weapon Cycle while in Abyssea for Procs. Add more pairs on new lines as needed
-- NOTE: if a slot should be empty, use `empty` with no quotation marks. ie: {"Fruit Punches", empty},
AbysseaProcCycle = {
	{"Excalipoor II", "Blurred Shield +1"},
	{"Chocobo Wand", "Blurred Shield +1"},
	{"Hapy Staff", "Flanged Grip"},
	--{"Main Slot", "Sub Slot"},
}

-- These are pieces of gear that if found in EITHER the MAIN or SUB slot will trigger the use of the Tank - Magic Damage set in place of the normal Tank set.
TankMDTTrigger = {
	["Malignance Sword"] = true,
	["Aegis"] = true,
}

-------------------------------------------
--               GEAR SETS               --
-------------------------------------------

function get_sets()

-- Tank (Damage Taken-, Magic Evasion, Enmity+, VIT, Defense)
sets.tank = {
	ammo="Staunch Tathlum +1",		--3 DT
	head="Chev. Armet +3",			--11 DT
	body="Sakpata's Plate",			--10 DT
	hands="Chev. Gauntlets +3",		--11 DT
	legs="Chev. Cuisses +3",		--13 DT
	feet="Chev. Sabatons +3",
	neck="Unmoving Collar +1",
	waist="Plat. Mog. Belt",		--3 DT
	left_ear="Tuisto Earring",
	right_ear="Ethereal Earring",
	left_ring="Moonlight Ring",		--5 DT
	right_ring="Gelatinous Ring +1",
	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Mag. Evasion+15',}},

}

-- Tank - Magic Damage (Damage Taken-, Magic Defense, Magic Evasion, Enmity+, VIT, Defense)
sets.tank_mdt = {
	ammo="Staunch Tathlum +1",
	head="Sakpata's Helm",
	body="Sakpata's Plate",
	hands="Sakpata's Gauntlets",
	legs="Sakpata's Cuisses",
	feet="Sakpata's Leggings",
	neck="Moonlight Necklace",
	waist="Asklepian Belt",
	left_ear="Eabani Earring",
	right_ear="Chev. Earring +2",
	left_ring="Shadow Ring",
	right_ring="Apeile Ring +1",
	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Mag. Evasion+15',}},
}

-- MAX HP (HP-focused tank gear, inherits any leftover slots from the Tank set above)
-- NOTE: This set is only used when the "UseMaxHP" option is set to true.
sets.max_hp = {
	ammo="Egoist's Tathlum",
	head="Souv. Schaller +1",
	body="Rev. Surcoat +4",
	hands="Souv. Handsch. +1",
	legs="Rev. Breeches +4",
	feet="Souveran Schuhs +1",
	neck="Unmoving Collar +1",
	waist="Plat. Mog. Belt",
	left_ear="Tuisto Earring",
	right_ear="Odnowa Earring +1",
	left_ring="Moonlight Ring",
	right_ring="Gelatinous Ring +1",
	back="Moonlight Cape",
}

-- MAX HP with SIRD (102%+ SIRD (92% + 10% from merits), HP-focused tank gear, inherits any leftover slots from the Tank set above)
-- NOTE: This set is only used when the "UseMaxHP" option is set to true.
sets.max_hp_sird = {
	ammo="Staunch Tathlum +1",		--11 SIRD
	head="Souv. Schaller +1",		--20 SIRD
	body="Chev. Cuirass +3",		--20 SIRD
	hands="Souv. Handsch. +1",
	legs="Founder's Hose",			--30 SIRD
	feet="Souveran Schuhs +1",
	neck="Unmoving Collar +1",
	waist="Plat. Mog. Belt",
	left_ear="Tuisto Earring",
	right_ear="Knightly Earring",	--9 SIRD
	left_ring="Moonlight Ring",
	right_ring="Evanescence Ring",	--5 SIRD
	back="Moonlight Cape",
}

-- DPS (DPS-focused gear, inherits any leftover slots from the Tank set above)
sets.dps = set_combine(sets.tank, {
	ammo="Coiste Bodhar",
	head="Sakpata's Helm",
	body="Sakpata's Plate",
	hands="Sakpata's Gauntlets",
	legs="Sakpata's Cuisses",
	feet="Sakpata's Leggings",
	neck="Null Loop",
	waist="Sailfi Belt +1",
	left_ear="Brutal Earring",
	right_ear="Cessance Earring",
	left_ring="Hetairoi Ring",
	right_ring="Petrov Ring",
	back="Null Shawl",
})

-- Oh Shit
-- Full DT- and everything you've got with Absorbs or Annuls Damage
sets.oh_shit = {
	head="Chev. Armet +3",
	body="Chev. Cuirass +3",
	hands="Chev. Gauntlets +3",
	legs="Chev. Cuisses +3",
	feet="Chev. Sabatons +3",
	neck="Warder's Charm +1",
	left_ring="Shadow Ring",
	back="Shadow Mantle"
}

-- Idle (Refresh, not Kiting)
-- NOTE: Combines with the Tank set above
sets.idle = set_combine(sets.tank, {
	ammo="Homiliary",
	head={ name="Odyssean Helm", augments={'Pet: Mag. Acc.+20 Pet: "Mag.Atk.Bns."+20','Magic dmg. taken -2%','"Refresh"+2','Accuracy+15 Attack+15','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
	body="Crepuscular Mail",
	hands="Regal Gauntlets",
	feet="Odyssean Greaves",
	neck="Coatl Gorget +1",
	waist="Plat. Mog. Belt",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back="Moonlight Cape",
})

-- Movement Speed
-- NOTE: Combines with Tank/Max HP/Refresh set based on current mode
sets.movement_speed = {
	legs="Carmine Cuisses +1",
}

-- Rest
sets.rest = {

}

-- Fast Cast (cap is 80%)
-- NOTE: Main and Sub slots will only equip if your TP is under the number set as the KeepTPThreshold in the Advanced Options section.
sets.fast_cast = {
	ammo="Sapience Orb", --2
	head="Carmine Mask +1", --14
	body="Rev. Surcoat +4", --10
	hands="Leyline Gloves", --5+1
	legs="Rev. Breeches +4",
	feet="Chev. Sabatons +3", --8
	neck="Unmoving Collar +1",
	waist="Plat. Mog. Belt",
	left_ear="Tuisto Earring",
	right_ear="Alabaster Earring",
	left_ring="Moonlight Ring",
	right_ring="Defending Ring",
	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --10
}

-- Snapshot
-- For ranged attacks when you need to pull without aggroing via magic
sets.snapshot = {

}

-- Enmity (full Enmity+ for spells/abilities)
sets.enmity = {
	ammo="Sapience Orb",
	head="Loess Barbuta +1",
	body="Souv. Cuirass +1",
	hands="Souv. Handsch. +1",
	legs="Cab. Breeches +4",
	feet="Chev. Sabatons +3",
	neck="Moonlight Necklace",
	waist="Plat. Mog. Belt",
	left_ear="Tuisto Earring",
	right_ear="Odnowa Earring +1",
	left_ring="Apeile Ring +1",
	right_ring="Defending Ring",
	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Mag. Evasion+15',}},
}

-- Enmity Spells (Fast Cast, will not be used to cast faster but instead to help reduce recast)
-- Combines with Enmity set
-- Flash, Holy, Banish, BLU spells use this.
sets.enmity_spells = set_combine(sets.enmity, {
	head="Chev. Armet +3",
})

-- Enmity Spells with SIRD (102%+ SIRD (92% + 10% from merits), Fast Cast, will not be used to cast faster but instead to help reduce recast)
-- Combines with Enmity set
-- Flash, Holy, Banish, BLU spells use this.
sets.enmity_spells_sird = set_combine(sets.enmity, {
	ammo="Staunch Tathlum +1",		--11 SIRD
	head="Souv. Schaller +1",		--20 SIRD
	body="Sakpata's Plate",
	hands="Sakpata's Gauntlets",
	legs="Founder's Hose",			--30 SIRD
	feet="Souveran Schuhs +1",
	neck="Moonlight Necklace",		--15 SIRD
	waist="Plat. Mog. Belt",
	left_ear="Knightly Earring",	--9 SIRD
	right_ear="Odnowa Earring +1",
	left_ring="Moonlight Ring",
	right_ring="Defending Ring",
	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Spell interruption rate down-10%',}},	--10 SIRD
})

-- Healing (Cure Potency, HP+, Enmity)
-- NOTE: Cure Potency cap is 50%, Cure Potency Received cap is 30%
sets.healing = {
	ammo="Sapience Orb",
	head="Loess Barbuta +1",
	body="Souv. Cuirass +1",	--11 CP		15 CPR
	hands="Souv. Handsch. +1",	--			15 CPR (over cap, but still used for the HP)
	legs="Souv. Diechlings +1",	--8 CP		23 CPR
	feet="Chev. Sabatons +3",
	neck="Phalaina Locket",		--4 CP		 4 CPR
	waist="Plat. Mog. Belt",
	left_ear="Tuisto Earring",
	right_ear="Chev. Earring +2",	--10 CP
	left_ring="Moonlight Ring",
	right_ring="Defending Ring",
	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Cure" potency +10%','Spell interruption rate down-10%',}},	--10 CP
}

-- Healing with SIRD (102%+ SIRD (92% + 10% from merits), Cure Potency, HP+, Enmity)
-- NOTE: Cure Potency cap is 50%, Cure Potency Received cap is 30%
sets.healing_sird = {
	ammo="Staunch Tathlum +1",	--11 SIRD
	head="Souv. Schaller +1",	--20 SIRD				15 CPR
	body="Souv. Cuirass +1",	--			11 CP		15 CPR
	hands="Regal Gauntlets",	--10 SIRD
	legs="Founder's Hose",		--30 SIRD
	feet="Odyssean Greaves",	--20 SIRD	7 CP
	neck="Unmoving Collar +1",
	waist="Plat. Mog. Belt",
	left_ear="Mendi. Earring",	--			5 CP
	right_ear="Chev. Earring +2",--			10 CP
	left_ring="Moonlight Ring",
	right_ring="Defending Ring",
	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Cure" potency +10%','Spell interruption rate down-10%',}},	--10 SIRD, 10 CP
}

-- Enlight (Divine Magic Skill)
sets.enlight = {
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
}

-- Enlight with SIRD (102%+ SIRD (92% + 10% from merits), Divine Magic Skill)
sets.enlight_sird = {
	ammo="Staunch Tathlum +1",	--11 SIRD
	head="Souv. Schaller +1",	--20 SIRD
	body="Chev. Cuirass +3",	--20 SIRD
	legs="Founder's Hose",		--30 SIRD
	feet="Souveran Schuhs +1",
	neck="Moonlight Necklace",	--15 SIRD
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
}

-- Phalanx (Phalanx+, Enhancing Magic+, Enhancing Magic Duration)
sets.phalanx = {
	main="Sakpata's Sword",
	head={ name="Odyssean Helm", augments={'AGI+15','Accuracy+8','Phalanx +4','Accuracy+10 Attack+10','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
	body="Odyssean Chestplate",
	hands="Souv. Handsch. +1",
	legs="Sakpata's Cuisses",
	feet="Souveran Schuhs +1",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back="Weard Mantle",
}

-- Phalanx with SIRD (102%+ SIRD (92% + 10% from merits), Phalanx+, Enhancing Magic+, Enhancing Magic Duration)
-- NOTE: Main and Sub slots will only equip if your TP is under the number set as the KeepTPThreshold in the Advanced Options section.
sets.phalanx_sird = {
	main="Sakpata's Sword",
	ammo="Staunch Tathlum +1",		--11 SIRD
	head="Souv. Schaller +1",		--20 SIRD
	body="Odyssean Chestplate",
	hands="Regal Gauntlets",		--10 SIRD
	legs="Founder's Hose",			--30 SIRD
	feet="Souveran Schuhs +1",
	neck="Moonlight Necklace",		--15 SIRD
	waist="Plat. Mog. Belt",
	right_ear="Knightly Earring",	--9 SIRD
	left_ring="Defending Ring",
	right_ring="Stikini Ring +1",
	back="Weard Mantle",
}

-- Enhancing Magic (Enhancing Magic Duration, Enhancing Magic Skill)
-- Crusade, Reprisal, Protect, and Shell use this.
-- NOTE: Main and Sub slots will only equip if your TP is under the number set as the KeepTPThreshold in the Advanced Option section.
sets.enhancing = {
	body="Shab. Cuirass +1",
	hands="Regal Gauntlets",
	legs="Rev. Breeches +4",
	legs="Carmine Cuisses +1",
	neck="Incanter's Torque",
	left_ear="Mimir Earring",
	right_ear="Andoaa Earring",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
}

-- Enhancing Magic with SIRD (102%+ SIRD (92% + 10% from merits), Enhancing Magic Duration, Enhancing Magic Skill)
-- Crusade, Reprisal, Protect, and Shell use this.
-- NOTE: Main and Sub slots will only equip if your TP is under the number set as the KeepTPThreshold in the Advanced Option section.
sets.enhancing_sird = {
	ammo="Staunch Tathlum +1",		--11 SIRD
	head="Loess Barbuta +1",
	body="Shab. Cuirass +1",
	hands="Regal Gauntlets",		--10 SIRD
	legs="Founder's Hose",			--30 SIRD
	feet="Odyssean Greaves",		--20 SIRD
	neck="Moonlight Necklace",		--15 SIRD
	left_ear="Tuisto Earring",
	right_ear="Knightly Earring",	--9 SIRD
	left_ring="Moonlight Ring",
	right_ring="Defending Ring",
	back="Moonlight Cape",
}

-- Raise (102%+ SIRD (92% + 10% from merits), Conserve MP)
sets.raise = {
	ammo="Staunch Tathlum +1",	--11 SIRD
	head="Souv. Schaller +1",	--20 SIRD
	legs="Founder's Hose",		--30 SIRD
	feet="Odyssean Greaves",	--20 SIRD
	neck="Moonlight Necklace",	--15 SIRD
}

-- Cursna (Cursna+, Healing Magic)
sets.cursna = {
	neck="Nicander's Necklace",
	ring1="Haoma's Ring",
	ring2="Haoma's Ring",
}

-- Holy Water (Holy Water+)
sets.holy_water = {
	neck="Nicander's Necklace",
	ring1="Blenmot's Ring +1",
	ring2="Blenmot's Ring +1",
}

-- Weapon Skill - Basic (STR, Weapon Skill Damage, Attack, Double/Triple Attack)
sets.weapon_skill = {
	ammo="Coiste Bodhar",
	head="Nyame Helm",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Unmoving Collar +1",
	waist="Plat. Mog. Belt",
	left_ear="Moonshade Earring",
	right_ear="Thrud Earring",
	left_ring="Moonlight Ring",
	right_ring="Karieyh Ring +1",
	back="Moonlight Cape",
}

-- Savage Blade (50% STR, 50% MND mod)
-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
sets["Savage Blade"] = set_combine(sets.weapon_skill, {
	
})

-- Sanguine Blade (Dark Magical, 50% STR, 50% MND mod)
-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
sets["Sanguine Blade"] = set_combine(sets.weapon_skill, {
	ammo="Coiste Bodhar",
	head="Pixie Hairpin +1",
	waist="Eschan Stone",
	right_ear="Friomisi Earring",
	left_ring="Archon Ring",
})

-- Requiescat (~80% MND mod)
-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
sets["Requiescat"] = set_combine(sets.weapon_skill, {
	waist="Fotia Belt",
})

-- Chant du Cygne (80% DEX mod)
-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
sets["Chant du Cyne"] = set_combine(sets.weapon_skill, {
	waist="Fotia Belt",
	right_ear="Mache Earring +1",
	left_ring="Hetairoi Ring",
})

-- Atonement (Fotia Neck/Belt)
-- Combines with Enmity set, only necessary to set the slots with specific desired stats
sets["Atonement"] = set_combine(sets.enmity, {
	
})

-- Imperator (70% DEX, 70% MND, mod)
-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
sets["Imperator"] = set_combine(sets.weapon_skill, {

})

-- Fimbulvetr (60% STR, 60% VIT mod)
-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
sets["Fimbulvetr"] = set_combine(sets.weapon_skill, {

})

-- Invincible
sets.invincible = {
	legs="Cab. Breeches +4",
}

-- Holy Circle (Enhances Holy Circle gear)
sets.holy_circle = set_combine(sets.enmity, {
	feet="Rev. Leggings +3",
})

-- Shield Bash (Enhances Shield Bash gear)
sets.shield_bash = set_combine(sets.enmity, {
	hands="Cab. Gauntlets +4",
})

-- Sentinel (Enhances Sentinel gear)
sets.sentinel = set_combine(sets.enmity, {
	feet="Cab. Leggings +4",
})

-- Cover (Enhances Cover gear)
sets.cover = {
	body="Cab. Surcoat",
}

-- Rampart (Enhances Rampart gear)
sets.rampart = set_combine(sets.enmity, {
	head="Cab. Coronet",
})

-- Fealty (Enhances Fealty gear)
sets.fealty = {
	body="Cab. Surcoat",
}

-- Chivalry (Enhances Chivalry gear)
sets.chivalry = {
	hands="Cab. Gauntlets +4",
}

-- Divine Emblem (Enhances Divine Emblem gear)
sets.divine_emblem = {
	feet="Chev. Sabatons +3",
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
	body="Sylvie Unity Shirt",
}

end




	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX          DO NOT EDIT BELOW THIS LINE          XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--




FileVersion = '15.0'

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
Mode = StartMode --sets the starting mode (selected in the Advanced Options)
NotiLowMPToggle = false --start with the toggle off for the Low MP Notification so that it can trigger
RRRCountdown = RRReminderTimer
HUDposYLine1 = HUDposY
last_poll = 0 --keeps the timing for things that happen at the polling rate
last_second = 0 --keeps the timing for things that happen every second
GreetingDelay = 6 --delay to display greeting and file version info
Zoning = false --flips automatically to hide the HUD while zoning
InCS = false --flips automatically to hide the HUD while in a cs
MajestyTimer = 0
MaxHP = false
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

local play_sound = windower.play_sound
local addon_path = windower.addon_path
local Notification_Good = addon_path..'data/sounds/NotiGood.wav'
local Notification_Bad = addon_path..'data/sounds/NotiBad.wav'
local Notification_Danger = addon_path..'data/sounds/Danger.wav'
local Notification_Cancel = addon_path..'data/sounds/Cancel.wav'
local Notification_Aftermath_On = addon_path..'data/sounds/AftermathOn.wav'
local Notification_Aftermath_Off = addon_path..'data/sounds/AftermathOff.wav'
local Notification_3000TP = addon_path..'data/sounds/3000TP.wav'

-- Create a new table that combines both the WeaponCycle and AbysseaProcCycle weapons into one table to be used while inside Abyssea
local WeaponCyclePlusAbyssea = {}
for _, v in ipairs(WeaponCycle) do
    table.insert(WeaponCyclePlusAbyssea, {v[1], v[2]})
end
for _, v in ipairs(AbysseaProcCycle) do
    table.insert(WeaponCyclePlusAbyssea, {v[1], v[2]})
end

-- Sets the initial combat state
if windower.ffxi.get_player() and windower.ffxi.get_player().in_combat then
	player_in_combat = true
else
	player_in_combat = false
end

-- Sets the inital subjob
local subjob = 'OTH'
if player.sub_job == 'BLU' then
	subjob = 'BLU'
elseif player.sub_job == 'WAR' then
	subjob = 'WAR'
elseif player.sub_job == 'SCH' then
	subjob = 'SCH'
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
elseif SubWARPage ~= "Off" and player.sub_job == 'WAR' then
	send_command('wait 2;input /macro set '..SubWARPage)
elseif SubSCHPage ~= "Off" and player.sub_job == 'SCH' then
	send_command('wait 2;input /macro set '..SubSCHPage)
else
	send_command('wait 2;input /macro set 1')
end

if ZoneGear ~= 'Off' then
	send_command('wait 2;gs c Zone Gear')
end

Invincible = {} Intervene = {} Aggressor = {} Berserk = {} Chivalry = {} Cocoon = {} Cover = {} Crusade = {} DarkArts = {} Defender = {} DivineEmblem = {} Enlight = {} Fealty = {} HolyCircle = {} LightArts = {} Majesty = {} Palisade = {} Phalanx = {} Rampart = {} Refueling = {} Reprisal = {} Sentinel = {} Sepulcher = {} ShieldBash = {} Stoneskin = {} Sublimation = {} Warcry = {}

--Start true so the HUD recasts don't flash on load
Invincible.flashed = true
Intervene.flashed = true
Aggressor.flashed = true
Berserk.flashed = true
Chivalry.flashed = true
Cocoon.flashed = true
Cover.flashed = true
Crusade.flashed = true
DarkArts.flashed = true
Defender.flashed = true
DivineEmblem.flashed = true
Enlight.flashed = true
Fealty.flashed = true
HolyCircle.flashed = true
LightArts.flashed = true
Majesty.flashed = true
Palisade.flashed = true
Phalanx.flashed = true
Rampart.flashed = true
Reprisal.flashed = true
Sentinel.flashed = true
Sepulcher.flashed = true
ShieldBash.flashed = true
Stoneskin.flashed = true
Sublimation.flashed = true
Warcry.flashed = true

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

-- Create the HUD BG Color text object
local hud_bg_color = texts.new(hud_bg_str..'\n'..hud_bg_str..'\n'..hud_bg_str)
hud_bg_color:font('Consolas')
hud_bg_color:size(FontSize)
hud_bg_color:bg_alpha(100)
hud_bg_color:pos(HUDposXColumn1,HUDposYLine1)
hud_bg_color:draggable(false)

-- Create the HUD Background text object
local hud_bg = texts.new(hud_bg_str..'\n'..hud_bg_str..'\n'..hud_bg_str)
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
local hud_noti_shdw = texts.new('Keys PLD Gearswap file v'..FileVersion)
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
hud_weapons:color(255,255,255)
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

local c = color[Mode]
hud_mode:color(c.r,c.g,c.b)
hud_bg_color:bg_color(c.r,c.g,c.b)

-- Create the HUD Notifications text object
local hud_noti = texts.new('Keys PLD Gearswap file v'..FileVersion)
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
	hud_mode_shdw:show()
	hud_noti_shdw:show()
	hud_debuffs_shdw:show()
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

send_command('alias mode gs c Mode') --creates the Mode alias
send_command('alias wc gs c WC') --creates the Weapon Cycle alias
send_command('alias hud gs c HUD') --creates the HUD alias
send_command('bind '..ModeBind..' gs c Mode') --creates the gear mode keyboard shortcut
send_command('bind '..WCBind..' gs c WC') --creates the Weapon Cycle keyboard shortcut

-------------------------------------------
--           CUSTOM FUNCTIONS            --
-------------------------------------------

--Add commas to numbers to make them easier to read
local function addCommas(number)
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

--Set the initial main/sub weapon pair
local function setWeaponPair()
	if string.find(world.area,'Abyssea') then --if inside Abyssea use the combined table
		pair = WeaponCyclePlusAbyssea[WeaponCycleIndex]
	else --otherwise, use just the basic WeaponCycle table
		pair = WeaponCycle[WeaponCycleIndex]
	end
end
setWeaponPair()

--Check if the equipped Main/Sub pair are in our defined AbysseaProcCycle weapons table
local function checkProcWeapons(mainSlot, subSlot)

	for _, equipmentPair in pairs(AbysseaProcCycle) do

		if equipmentPair[1] == mainSlot and equipmentPair[2] == subSlot then
			return true

		end
	end

	return false

end

--Are we using a two handed weapon?
local function twoHanded()

	local weapon = player.equipment.main and items:with('name', player.equipment.main)

	return weapon and (weapon.skill == 4 or weapon.skill == 6 or weapon.skill == 7 or weapon.skill == 8 or weapon.skill == 10 or weapon.skill == 12) or false

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
	local spell_recast = windower.ffxi.get_spell_recasts()
	local spell_data = windower.ffxi.get_sjob_data().spells
	local function stoneskin()
		if (player.sub_job == 'WHM' and player.sub_job_level >= 28) or (player.sub_job == 'RDM' and player.sub_job_level >= 34) or (player.sub_job == 'SCH' and player.sub_job_level >= 44) or (player.sub_job == 'RUN' and player.sub_job_level >= 55) then
			return true
		else return false end
	end

	Invincible.recast = ability_recast[0] and math.ceil(ability_recast[0])
	Intervene.recast = ability_recast[254] and math.ceil(ability_recast[254]) or 0
	Aggressor.recast = ability_recast[4] and math.ceil(ability_recast[4])
	Berserk.recast = ability_recast[1] and math.ceil(ability_recast[1])
	Chivalry.recast = ability_recast[79] and math.ceil(ability_recast[79])
	Cocoon.recast = (type(spell_data) == 'table' and table.contains(spell_data,547)) and math.ceil(spell_recast[547] / 60)
	Cover.recast = ability_recast[76] and math.ceil(ability_recast[76])
	Crusade.recast = spell_recast[476] and math.ceil(spell_recast[476] / 60)
	DarkArts.recast = ability_recast[232] and math.ceil(ability_recast[232])
	Defender.recast = ability_recast[3] and math.ceil(ability_recast[3])
	DivineEmblem.recast = ability_recast[80] and math.ceil(ability_recast[80])
	Enlight.recast = spell_recast[855] and math.ceil(spell_recast[855] / 60)
	Fealty.recast = ability_recast[78] and math.ceil(ability_recast[78])
	HolyCircle.recast = ability_recast[74] and math.ceil(ability_recast[74])
	LightArts.recast = ability_recast[228] and math.ceil(ability_recast[228])
	Majesty.recast = ability_recast[150] and math.ceil(ability_recast[150])
	Palisade.recast = ability_recast[42] and math.ceil(ability_recast[42])
	Phalanx.recast = spell_recast[106] and math.ceil(spell_recast[106] / 60)
	Rampart.recast = ability_recast[77] and math.ceil(ability_recast[77])
	Refueling.recast = (type(spell_data) == 'table' and table.contains(spell_data,530)) and math.ceil(spell_recast[530] / 60)
	Reprisal.recast = spell_recast[97] and math.ceil(spell_recast[97] / 60)
	Sentinel.recast = ability_recast[75] and math.ceil(ability_recast[75])
	Sepulcher.recast = ability_recast[41] and math.ceil(ability_recast[41])
	ShieldBash.recast = ability_recast[73] and math.ceil(ability_recast[73])
	Stoneskin.recast = stoneskin() and math.ceil(spell_recast[54] / 60)
	Sublimation.recast = ability_recast[234] and math.ceil(ability_recast[234])
	Warcry.recast = ability_recast[2] and math.ceil(ability_recast[2])

end

getRecasts()

-- Format abilities/spells to fit into their allotted 12 spaces
local function formatAbils(input,input_sh)

	-- Valid abilities/spells
	local validAbilities = {
		"Invincible", "Intervene", "Aggressor", "Berserk", "Chivalry", "Cocoon", "Cover", "Crusade", "Dark Arts", "Defender", "Divine Emblem", "Enlight", "Enlight II", "Fealty", "Holy Circle", "Light Arts", "Majesty", "Palisade", "Phalanx", "Rampart", "Refueling", "Reprisal", "Sentinel", "Sepulcher", "Shield Bash", "Stoneskin", "Sublimation", "Warcry"
	}

	local ab = {} ab['Invincible'] = Invincible ab['Intervene'] = Intervene ab['Aggressor'] = Aggressor ab['Berserk'] = Berserk ab['Chivalry'] = Chivalry ab['Cocoon'] = Cocoon ab['Cover'] = Cover ab['Crusade'] = Crusade ab['Dark Arts'] = DarkArts ab['Defender'] = Defender ab['Divine Emblem'] = DivineEmblem ab['Enlight'] = Enlight ab['Enlight II'] = Enlight ab['Fealty'] = Fealty ab['Holy Circle'] = HolyCircle ab['Light Arts'] = LightArts ab['Majesty'] = Majesty ab['Palisade'] = Palisade ab['Phalanx'] = Phalanx ab['Rampart'] = Rampart ab['Refueling'] = Refueling ab['Reprisal'] = Reprisal ab['Sentinel'] = Sentinel ab['Sepulcher'] = Sepulcher ab['Shield Bash'] = ShieldBash ab['Stoneskin'] = Stoneskin ab['Sublimation'] = Sublimation ab['Warcry'] = Warcry

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
local function format36(input)

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

local function relicAMUpdate(tp)
	if itemMatch(20685) then
		pre_AMTimer = math.floor(tp * 0.06)
	else
		pre_AMTimer = math.floor(tp * 0.02)
	end
end

local function empyreanAMUpdate(tp)
	if tp >= 1000 and tp < 2000 then
		pre_AMTimer = 60
	elseif tp >= 2000 and tp < 3000 then
		pre_AMTimer = 120
	elseif tp == 3000 then
		pre_AMTimer = 180
	end
end

local function mythicAMUpdate(tp)
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

local function primeAMUpdate(tp)

	if itemMatch(21644) or itemMatch(21652) then --stage 3 Prime
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
	elseif itemMatch(21645) or itemMatch(21653) then --stage 4 Prime
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
	elseif itemMatch(21646) or itemMatch(21649) then --stage 5 Prime
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

local function buffActive(buff_id)
	local buffs = windower.ffxi.get_player().buffs

	for _, buff in ipairs(buffs) do
		if buff == buff_id then
			return true
		end
	end
	return false
end

local function TankMDTTriggerFound()

	local main = player.equipment.main
	local sub = player.equipment.sub
	local use_mdt = false

	if TankMDTTrigger[main] or TankMDTTrigger[sub] then
		use_mdt = true
	end

	return use_mdt

end
-------------------------------------------
--            SELF COMMANDS              --
-------------------------------------------

function self_command(command)
	if command == 'Mode' then
		if Mode == 'Auto' then
			Mode = 'Tank'
		elseif Mode == 'Tank' then
			Mode = 'Kite'
		elseif Mode == 'Kite' then
			Mode = 'Neutral'
		elseif Mode == 'Neutral' then
			Mode = 'DPS'
		elseif Mode == 'DPS' then
			Mode = 'Auto'
		end
		hud_mode_shdw:text('Mode: '..Mode)
		hud_mode:text('Mode: '..Mode)
		local c = color[Mode]
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
		elseif player.status == "Idle" then
			hud_noti_shdw:text('Status: Idle')
			hud_noti:text('Status: Idle')
			hud_noti:color(255,255,255)
		elseif player.status == "Mount" then
			hud_noti_shdw:text('Status: Mounted')
			hud_noti:text('Status: Mounted')
			hud_noti:color(255,255,255)
		end
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
		hud_mode_shdw:show()
		hud_noti_shdw:show()
		hud_debuffs_shdw:show()
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
		hud_mode_shdw:hide()
		hud_noti_shdw:hide()
		hud_debuffs_shdw:hide()
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
		send_command('wait .5;gs c Choose Set')
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
	elseif command == 'double_divine_emblem_fix' then
		double_divine_emblem_fix = false
	elseif command == 'double_majesty_fix' then
		double_majesty_fix = false
	elseif command == "double_sublimation_fix" then
		double_sublimation_fix = false
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
			elseif buffactive['Weakness'] then
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
		local max_hp = ((Mode == 'Auto' or Mode == 'Tank' or Mode == 'Kite') and MaxHP) and sets.max_hp or nil
		local low_hp = LowHP and sets.oh_shit or nil
		equip(set_combine(sets.idle, sets.rest, max_hp, low_hp, {main=pair[1],sub=pair[2]}))
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
		local base_set = nil
		local max_hp = nil
		local low_hp = LowHP and sets.oh_shit or nil
		local movement_speed = Mode == 'Kite' and sets.movement_speed or nil
		if Mode == 'Auto' or Mode == 'Tank' or Mode == 'Kite' then
			base_set = TankMDTTriggerFound() and sets.tank_mdt or sets.tank
			max_hp = MaxHP and sets.max_hp or nil
		elseif Mode == 'Neutral' then
			base_set = sets.idle
		elseif Mode == 'DPS' then
			base_set = sets.dps
		end
		equip(set_combine(base_set, max_hp, low_hp, movement_speed, {main=pair[1],sub=pair[2]}))
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
			else
				hud_noti_shdw:text('Status: Idle')
				hud_noti:text('Status: Idle')
				hud_noti:color(255,255,255)
			end
		end
		local base_set = sets.idle
		local max_hp = nil
		local low_hp = LowHP and sets.oh_shit or nil
		local movement_speed = nil
		if AdoulinZones:contains(world.area) then
			base_set = sets.adoulin
		elseif BastokZones:contains(world.area) then
			base_set = sets.bastok
		elseif SandyZones:contains(world.area) then
			base_set = sets.sandoria
		elseif WindyZones:contains(world.area) then
			base_set = sets.windurst
		elseif TownZones:contains(world.area) or windower.ffxi.get_info().mog_house then
			base_set = sets.town
		end
		if TownZones:contains(world.area) or windower.ffxi.get_info().mog_house or Mode ~= "Tank" then
			movement_speed = sets.movement_speed
		end
		if (Mode == 'Auto' and player_in_combat) or Mode == "Kite" or Mode == "Tank" then
			base_set = TankMDTTriggerFound() and sets.tank_mdt or sets.tank
			max_hp = MaxHP and sets.max_hp or nil
		elseif (Mode == 'Auto' and not player_in_combat) then
			max_hp = MaxHP and sets.max_hp or nil
		end
		equip(set_combine(base_set, max_hp, low_hp, movement_speed, {main=pair[1],sub=pair[2]}))
	end
end

-------------------------------------------
--               PRECAST                 --
-------------------------------------------

function precast(spell)

	local use_mainsub = player.tp <= KeepTPThreshold and not (buffactive['Aftermath: Lv.1'] or buffactive['Aftermath: Lv.2'] or buffactive['Aftermath: Lv.3'] or buffactive['Aftermath'])

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
		-- If an Abyssea Proc weapon pair is equipped inside Abyssea, we don't want to use a WS set
		elseif checkProcWeapons(player.equipment.main, player.equipment.sub) and string.find(world.area,'Abyssea') then
			return
		end
		equip(sets[spell.english] and sets[spell.english] or sets.weapon_skill)
		if player.equipment.main == "Sequence" and spell.english == "Requiescat" then
			pre_AMTimer = 181
		elseif (player.equipment.main == 'Excalibur' and spell.english == "Knights of Round") or (player.equipment.main == 'Ragnarok' and spell.english == "Scourge") then
			player_tp = player.tp
			TP_Window_Open = true
			relicAMUpdate(player_tp)
		elseif (player.equipment.main == 'Almace' and spell.english == "Chant du Cygne") or (player.equipment.main == 'Caladbolg' and spell.english == "Torcleaver") then
			player_tp = player.tp
			TP_Window_Open = true
			empyreanAMUpdate(player_tp)
		elseif player.equipment.main == "Burtgang" and spell.english == "Atonement" then
			player_tp = player.tp
			TP_Window_Open = true
			mythicAMUpdate(player_tp)
		elseif (player.equipment.main == 'Caliburnus' and spell.english == "Imperator") or (player.equipment.main == 'Helheim' and spell.english == "Fimbulvetr") then
			player_tp = player.tp
			TP_Window_Open = true
			primeAMUpdate(player_tp)
		end
	elseif spell.english == 'Invincible' and Invincible.recast < 2 then
		equip(sets.invincible)
	elseif spell.english == 'Holy Circle' and HolyCircle.recast < 2 then
		equip(sets.holy_circle)
	elseif spell.english == 'Shield Bash' and ShieldBash.recast < 2 then
		equip(sets.shield_bash)
	elseif spell.english == 'Sentinel' and Sentinel.recast < 2 then
		equip(sets.sentinel)
	elseif spell.english == 'Cover' and Cover.recast < 2 then
		equip(sets.cover)
	elseif spell.english == 'Rampart' and Rampart.recast < 2 then
		equip(sets.rampart)
	elseif spell.english == 'Fealty' and Fealty.recast < 2 then
		equip(sets.fealty)
	elseif spell.english == 'Chivalry' and Chivalry.recast < 2 then
		equip(sets.chivalry)
	elseif spell.english == 'Divine Emblem' and DivineEmblem.recast < 2 then
		equip(sets.divine_emblem)
	elseif spell.english == 'Provoke' and windower.ffxi.get_ability_recasts()[5] < 2 then
		equip(sets.enmity)
	elseif spell.english == 'Holy Water' then
		equip(sets.holy_water)
	elseif spell.english == 'Majesty' and Majesty.recast < 2 then
		MajestyTimer = 180
	elseif (spell.english == 'Spectral Jig' or spell.english == 'Sneak' or spell.english == 'Monomi: Ichi' or spell.english == 'Monomi: Ni') and buffactive['Sneak'] and spell.target.type == 'SELF' then
		send_command('cancel 71')
		if spell.english ~= 'Spectral Jig' then
			local main_sub = use_mainsub and {main=nil, sub=nil} or {main="", sub=""}
			equip(set_combine(sets.fast_cast, main_sub))
		end
	elseif spell.english == 'Stoneskin' and buffactive['Stoneskin'] then
		send_command('cancel 37')
		local main_sub = use_mainsub and {main=nil, sub=nil} or {main="", sub=""}
		equip(set_combine(sets.fast_cast, main_sub))
	--if we're casting a cure or protect without Majesty up, we'll put it up before casting:
	elseif AutoMajesty and ((string.find(spell.english,'Cur') and spell.type == 'WhiteMagic') or string.find(spell.english,'Protect')) and not buffactive['Majesty'] and not buffactive['amnesia'] and Majesty.recast == 0 then
		if not double_majesty_fix then
			double_majesty_fix = true --prevents this from running through here a second time after being cast again below
			cancel_spell()
			send_command('input /ja Majesty <me>;wait 1;input /ma \"'..spell.english..'\" '..spell.target.raw..';wait 1;gs c double_majesty_fix')
			return
		end
	elseif spell.english == "Flash" then
		if windower.ffxi.get_spell_recasts()[112] and windower.ffxi.get_spell_recasts()[112] < 120 then
			if AutoDEmblem and not buffactive['amnesia'] and DivineEmblem.recast == 0 then
				if not double_divine_emblem_fix then
					double_divine_emblem_fix = true --prevents this from running through here a second time after being cast again below
					cancel_spell()
					send_command('input /ja "Divine Emblem" <me>;wait 1;input /ma Flash '..spell.target.raw..';wait 1;gs c double_divine_emblem_fix')
					return
				end
			end
			local main_sub = use_mainsub and {main=nil, sub=nil} or {main="", sub=""}
			equip(set_combine(sets.fast_cast, main_sub))
		elseif player.sub_job == 'BLU' and player.sub_job_level ~= 0 then
			if windower.ffxi.get_spell_recasts()[575] and windower.ffxi.get_spell_recasts()[575] < 120 and table.contains(windower.ffxi.get_sjob_data().spells,575) and spell.target.distance <= 9 then
				send_command('input /ma "Jettatura" '..spell.target.raw)
				cancel_spell()
				return
			elseif windower.ffxi.get_spell_recasts()[592] and windower.ffxi.get_spell_recasts()[592] < 120 and table.contains(windower.ffxi.get_sjob_data().spells,592) and spell.target.distance <= 14 then
				send_command('input /ma "Blank Gaze" '..spell.target.raw)
				cancel_spell()
				return
			end
		elseif player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
			if windower.ffxi.get_ability_recasts()[5] and windower.ffxi.get_ability_recasts()[5] < 2 and spell.target.distance <= 17.8 and not buffactive['amnesia'] then
				send_command('input /ja "Provoke" '..spell.target.raw)
				cancel_spell()
				return
			end
		end
	elseif spell.english == "Sheep Song" then
		if player.sub_job == 'BLU' then
			if windower.ffxi.get_spell_recasts()[584] and windower.ffxi.get_spell_recasts()[584] < 120 and table.contains(windower.ffxi.get_sjob_data().spells,584) then
				local main_sub = use_mainsub and {main=nil, sub=nil} or {main="", sub=""}
				equip(set_combine(sets.fast_cast, main_sub))
			elseif windower.ffxi.get_spell_recasts()[605] and windower.ffxi.get_spell_recasts()[605] < 120 and table.contains(windower.ffxi.get_sjob_data().spells,605) then
				send_command('input /ma "Geist Wall" '..spell.target.raw)
				cancel_spell()
				return
			elseif windower.ffxi.get_spell_recasts()[537] and windower.ffxi.get_spell_recasts()[537] < 120 and table.contains(windower.ffxi.get_sjob_data().spells,537) then
				send_command('input /ma "Stinking Gas" '..spell.target.raw)
				cancel_spell()
				return
			elseif windower.ffxi.get_spell_recasts()[598] and windower.ffxi.get_spell_recasts()[598] < 120 and table.contains(windower.ffxi.get_sjob_data().spells,598) then
				send_command('input /ma "Soporific" '..spell.target.raw)
				cancel_spell()
				return
			elseif windower.ffxi.get_spell_recasts()[572] and windower.ffxi.get_spell_recasts()[572] < 120 and table.contains(windower.ffxi.get_sjob_data().spells,572) then
				send_command('input /ma "Sound Blast" <me>')
				cancel_spell()
				return
			end
		elseif player.sub_job == 'RUN' and windower.ffxi.get_spell_recasts()[840] and windower.ffxi.get_spell_recasts()[840] < 120 then
			print('test')
			send_command('input /ma "Foil" <me>')
			cancel_spell()
			return
		end
	elseif spell.action_type == 'Ranged Attack' then
		equip(sets.snapshot)
	elseif not (spell.action_type == 'Item' or spell.action_type == 'Ability') then
		local main_sub = use_mainsub and {main=nil, sub=nil} or {main="", sub=""}
		equip(set_combine(sets.fast_cast, main_sub))
	end
end

-------------------------------------------
--               MIDCAST                 --
-------------------------------------------

function midcast(spell)
 
	--In combat with no Aquaveil, so we need SIRD
	local use_sird = (Mode == 'Tank' or Mode == 'Kite' or ((Mode == 'Auto' or Mode == 'DPS') and player_in_combat)) and not buffactive['Aquaveil']
	local use_mainsub = player.tp <= KeepTPThreshold and not (buffactive['Aftermath: Lv.1'] or buffactive['Aftermath: Lv.2'] or buffactive['Aftermath: Lv.3'] or buffactive['Aftermath'])

	if string.find(spell.english,'Cur') and spell.type == "WhiteMagic" then
		if use_sird then
			if player.hpp >= MaxHPThreshold and spell.target.type == 'SELF' and UseMaxHP then
				equip(sets.max_hp_sird)
			else
				equip(set_combine(sets.enmity, sets.healing_sird))
			end
		else
			if spell.target.type == 'SELF' then
				equip(sets.max_hp)
			else
				equip(sets.healing)
			end
		end
	elseif spell.english =='Raise' then
		equip(sets.raise)
	elseif spell.english == 'Flash' or string.find(spell.english,'Holy') or string.find(spell.english,'Banish') or spell.type == "BlueMagic" then
		local base_set = use_sird and sets.enmity_spells_sird or sets.enmity_spells
		equip(base_set)
	elseif string.find(spell.english,'Enlight') then
		local base_set = use_sird and sets.enlight_sird or sets.enlight
		equip(base_set)
	elseif spell.english == 'Phalanx' then
		local base_set = use_sird and sets.phalanx_sird or sets.phalanx
		local main_sub = use_mainsub and {main=nil, sub=nil} or {main="", sub=""}
		equip(set_combine(base_set, main_sub))
	elseif spell.skill == "Enhancing Magic" then
		local base_set = use_sird and sets.enhancing_sird or sets.enhancing
		local main_sub = string.find(spell.english,'Protect') and use_mainsub and {main=nil, sub=nil} or {main="", sub=""}
		equip(set_combine(base_set, main_sub))
	elseif spell.english == 'Cursna' then
		equip(sets.cursna)
	elseif spell.type == 'Trust' then
		equip(sets.unity)
	elseif spell.action_type == 'Magic' then
		if use_sird then
			equip(sets.enmity_spells_sird)
		else
			equip(sets.enmity_spells)
		end
	end
end

-------------------------------------------
--              AFTERCAST                --
-------------------------------------------

function aftercast(spell)
	if spell.type == 'WeaponSkill' and TP_Window_Open then
		TP_Window_Open = false
	end
	if spell.english == 'Invincible' and InvTimer and not spell.interrupted then
		if player.equipment.legs == 'Cab. Breeches' or player.equipment.legs == 'Cab. Breeches +1' or player.equipment.legs == 'Cab. Breeches +2' or player.equipment.legs == 'Cab. Breeches +3' or player.equipment.legs == 'Cab. Breeches +4' then --these pieces extend Invincible by 10 seconds so we adjust accordingly
			send_command('input /echo [Invincible] 40 seconds;wait 10;input /echo [Invincible] 30 seconds;wait 10;input /echo [Invincible] 20 seconds;wait 10;input /echo [Invincible] 10 seconds')
		else
			send_command('input /echo [Invincible] 30 seconds;wait 10;input /echo [Invincible] 20 seconds;wait 10;input /echo [Invincible] 10 seconds')
		end
	elseif spell.english == 'Intervene' and IntTimer and not spell.interrupted then
		send_command('input /echo [Intervene] 30 seconds;wait 10;input /echo [Intervene] 20 seconds;wait 10;input /echo [Intervene] 10 seconds')
	elseif (string.find(spell.english,'Cur') and spell.type == "WhiteMagic" and spell.target.type == 'SELF') and UseMaxHP then
		MaxHP = true
	end
	--Put Defender up afterwards if we're doing active tank things:
	if AutoDefender and (spell.english == 'Provoke' or spell.english == 'Holy Circle' or spell.english == 'Shield Bash' or spell.english == 'Sentinel' or spell.english == 'Rampart') and not buffactive['Defender'] and not buffactive['amnesia'] and (Mode == 'Tank' or Mode == 'Kite' or Mode == 'Auto') and player.sub_job == 'WAR' and player.sub_job_level ~= 0 and DefenderRecast == 0 then
		send_command('wait .5;input /ja Defender <me>')
	elseif (spell.english == 'Flash' or spell.english == 'Phalanx' or spell.english == 'Reprisal' or spell.english == 'Crusade') and not buffactive['Defender'] and AutoDefender and not buffactive['amnesia'] and (Mode == 'Tank' or Mode == 'Kite' or Mode == 'Auto') and player.sub_job == 'WAR' and player.sub_job_level ~= 0 and DefenderRecast == 0 then
		send_command('wait 3;input /ja Defender <me>')
	end
	if AutoMajesty and ((string.find(spell.english,'Cur') and spell.type == 'WhiteMagic') or string.find(spell.english,'Protect') or spell.english == 'Crusade' or spell.english == 'Phalanx' or spell.english == 'Cocoon' or spell.english == 'Defender' or spell.english == 'Reprisal' or spell.english == 'Palisade' or spell.english == 'Enlight') and MajestyTimer <= AutoMajWindow and not buffactive['amnesia'] then
		send_command('wait 3; input /ja Majesty <me>')
	end
	choose_set()
	if AutoSubCharge and player.sub_job == 'SCH' and Sublimation.recast and Sublimation.recast < 2 and not (buffactive['amnesia'] or buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete'] or buffactive['Refresh'] or buffactive['Invisible'] or windower.ffxi.get_info().mog_house or world.area == 'Mog Garden') then
		if not double_sublimation_fix then
			double_sublimation_fix = true --prevents this from running through here a second time after being cast again below
			if spell.type == 'WeaponSkill' or spell.action_type == 'Magic' then
				send_command('wait 3;input /ja Sublimation <me>;wait 1;gs c double_sublimation_fix')
			elseif spell.type == 'JobAbility' then
				send_command('wait .5;input /ja Sublimation <me>;wait 1;gs c double_sublimation_fix')
			end
			return
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
	if AutoSubCharge and player.sub_job == 'SCH' and status == 0 and Sublimation.recast and Sublimation.recast < 2 and not (buffactive['amnesia'] or buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete'] or buffactive['Refresh'] or buffactive['Invisible'] or windower.ffxi.get_info().mog_house or world.area == 'Mog Garden') then
		if not double_sublimation_fix then
			double_sublimation_fix = true --prevents this from running a second time (as an aftercast above) after being run here
			send_command('input /ja Sublimation <me>;wait 1;gs c double_sublimation_fix')
			return
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
	elseif (buff == 2 or buff == 19) then --If we get slept,
		if buffactive['Stoneskin'] and not buffactive['charm'] then --first remove stoneskin if its up,
			send_command('cancel 37')
			equip(sets.oh_shit)
		elseif not (buffactive['Poison'] or buffactive['Dia'] or buffactive['bio'] or buffactive['Shock'] or buffactive['Rasp'] or buffactive['Choke'] or buffactive['Frost'] or buffactive['Burn'] or buffactive['Drown'] or buffactive['Requiem'] or buffactive['Kaustra'] or buffactive['Helix']) and player.hp > 50 and player.status == "Engaged" then --then as long as we're not already DOT'd, have more than 50 HP, and are engaged,
			equip(set_combine({neck="Vim Torque"}, sets.oh_shit)) --equip the Vim Torque to wake us up
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
	end
end)

windower.register_event('lose buff', function(buff)
	if buff == 270 or buff == 271 or buff == 272 or buff == 273 and AlertSounds then --lose any aftermath
		play_sound(Notification_Aftermath_Off)
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
		DangerCountdown = 0 --Set to 0 to turn the sound off when we are no longer Doomed
	elseif buff == 71 or buff == 69 then --Sneak or Invisible
		send_command('gs c ClearNotifications')
	elseif buff == 252 then --Mounted
		send_command('wait .5;gs c ClearNotifications')
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
		if player.equipment.main == 'Excalibur' or player.equipment.main == 'Ragnarok' then
			relicAMUpdate(player_tp)
		elseif player.equipment.main == 'Almace' or player.equipment.main == 'Caladbolg' then
			empyreanAMUpdate(player_tp)
		elseif player.equipment.main == "Burtgang" then
			mythicAMUpdate(player_tp)
		elseif player.equipment.main == 'Caliburnus' or player.equipment.main == 'Helheim' then
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

		if AutoSentinel and player.hp <= AutSntThreshold and Alive and not (buffactive['Weakness'] or buffactive['amnesia'] or buffactive['terror'] or buffactive['petrification'] or buffactive['sleep']) and Sentinel.recast and Sentinel.recast == 0 and not (TownZones:contains(world.area) or windower.ffxi.get_info().mog_house) then
			send_command('input /ja Sentinel <me>')
		end

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
			if player.equipment.main == 'Caliburnus' or player.equipment.main == 'Helheim' then
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
					if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain..EquipSub then
						CurrentEquip = EquipMain..EquipSub
						currentAfterMath = 'None'
						hud_weapons_shdw:text(formatWeapons(EquipMain..EquipSub))
						hud_weapons:text(formatWeapons(EquipMain..EquipSub))
						colorWeaponsText()
					end
				end
			elseif player.equipment.main == 'Excalibur' or player.equipment.main == 'Ragnarok' then
				if buffactive['Aftermath'] then
					if currentAfterMath ~= 'RelicAM' or currentAMTimer ~= AMTimer then
						currentAfterMath = 'RelicAM'
						currentAMTimer = AMTimer
						local am_time = formatAMTime(currentAMTimer)
						if player.equipment.main == 'Excalibur' then
							hud_weapons_shdw:text(formatWeapons('AM: (Regen +30/Refresh +3) '..am_time))
							hud_weapons:text(formatWeapons('AM: (Regen +30/Refresh +3) '..am_time))
						elseif player.equipment.main == 'Ragnarok' then
							hud_weapons_shdw:text(formatWeapons('AM: (Acc. +15/Crit Rate +10%) '..am_time))
							hud_weapons:text(formatWeapons('AM: (Acc. +15/Crit Rate +10%) '..am_time))
						end
						colorWeaponsText(3)
					end
				else
					if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain..EquipSub then
						CurrentEquip = EquipMain..EquipSub
						currentAfterMath = 'None'
						hud_weapons_shdw:text(formatWeapons(EquipMain..EquipSub))
						hud_weapons:text(formatWeapons(EquipMain..EquipSub))
						colorWeaponsText()
					end
				end
			elseif player.equipment.main == 'Almace' or player.equipment.main == 'Caladbolg' then
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
					if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain..EquipSub then
						CurrentEquip = EquipMain..EquipSub
						currentAfterMath = 'None'
						hud_weapons_shdw:text(formatWeapons(EquipMain..EquipSub))
						hud_weapons:text(formatWeapons(EquipMain..EquipSub))
						colorWeaponsText()
					end
				end
			elseif player.equipment.main == 'Burtgang' then
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
					if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain..EquipSub then
						CurrentEquip = EquipMain..EquipSub
						currentAfterMath = 'None'
						hud_weapons_shdw:text(formatWeapons(EquipMain..EquipSub))
						hud_weapons:text(formatWeapons(EquipMain..EquipSub))
						colorWeaponsText()
					end
				end
			elseif player.equipment.main == 'Sequence' then
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
					if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain..EquipSub then
						CurrentEquip = EquipMain..EquipSub
						currentAfterMath = 'None'
						hud_weapons_shdw:text(formatWeapons(EquipMain..EquipSub))
						hud_weapons:text(formatWeapons(EquipMain..EquipSub))
						colorWeaponsText()
					end
				end
			elseif currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain..EquipSub then
				CurrentEquip = EquipMain..EquipSub
				currentAfterMath = 'None'
				if twoHanded() then
					hud_weapons_shdw:text(formatWeapons(EquipMain))
					hud_weapons:text(formatWeapons(EquipMain))
				else
					hud_weapons_shdw:text(formatWeapons(EquipMain..EquipSub))
					hud_weapons:text(formatWeapons(EquipMain..EquipSub))
				end
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

		--Auto Mode combat check
		if Mode == 'Auto' then
			if windower.ffxi.get_player() and windower.ffxi.get_player().in_combat then
				if not player_in_combat then
					player_in_combat = true
					choose_set()
					if player.status == "Idle" then
						hud_mode_shdw:text('Mode: Auto (Kite)')
						hud_mode:text('Mode: Auto (Kite)')
						local c = color.Kite
						hud_bg_color:bg_color(c.r,c.g,c.b)
					else
						hud_mode_shdw:text('Mode: Auto (Tank)')
						hud_mode:text('Mode: Auto (Tank)')
						local c = color.Tank
						hud_bg_color:bg_color(c.r,c.g,c.b)
					end
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
			NotiLowMPToggle = true --turn the toggle on so this can't be triggered again until its toggled off
			if AlertSounds then
				play_sound(Notification_Bad)
			end
			hud_noti_shdw:text('«« Low MP »»')
			hud_noti:text('«« Low MP »»')
			hud_noti:color(255,50,50)
			NotiCountdown = NotiDelay
			send_command('wait 30;gs c NotiLowMPToggle') --wait 30 sec then turns the toggle back off
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
				DangerCountdown = 0
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
			if player.hpp <= MaxHPThreshold and MaxHP and UseMaxHP then --when HP% goes below a certain amount, turn off the MaxHP flag and equip the appropriate gear set
				MaxHP = false
				choose_set()
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

		--Recast updates:
		getRecasts()
		getHUDAbils()

		if player.equipment.main == nil or player.equipment.sub == nil then
			EquipMain = 'Weapons loading...'
			EquipSub = ''
		else
			EquipMain = player.equipment.main
			if player.equipment.sub == 'empty' then
				EquipSub = ''
			else
				EquipSub = ' & '..player.equipment.sub
			end
		end

		if buffactive['Enmity Boost'] and buffactive['Phalanx'] and (buffactive['Sentinel'] or buffactive['Palisade'] or buffactive['Rampart']) and player_in_combat then
			hud_mode_shdw:text('Mode: '..Mode..' (Turtle)')
			hud_mode:text('Mode: '..Mode..' (Turtle)')
		else
			if Mode == 'Auto' then
				if player_in_combat then
					if player.status == "Idle" then
						hud_mode_shdw:text('Mode: '..Mode..' (Kite)')
						hud_mode:text('Mode: '..Mode..' (Kite)')
						local c = color.Kite
						hud_bg_color:bg_color(c.r,c.g,c.b)
					else
						hud_mode_shdw:text('Mode: '..Mode..' (Tank)')
						hud_mode:text('Mode: '..Mode..' (Tank)')
						local c = color.Tank
						hud_bg_color:bg_color(c.r,c.g,c.b)
					end
				else
					if TownZones:contains(world.area) or windower.ffxi.get_info().mog_house then
						hud_mode_shdw:text('Mode: '..Mode)
						hud_mode:text('Mode: '..Mode)
						local c = color.Auto
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
				local c = color[Mode]
				hud_bg_color:bg_color(c.r,c.g,c.b)
			end
		end

		--Recast color updates
		if Invincible.recast then
			if buffactive['Invincible'] then
				textColor('Invincible','active')
				Invincible.flashed = false
			elseif Invincible.recast > 0 then
				textColor('Invincible','cooldown')
				Invincible.flashed = false
			else
				textColor('Invincible','ready')
				if not Invincible.flashed then
					flash('Invincible')
				end
				Invincible.flashed = true
			end
		else
			textColor('Invincible','notfound')
		end

		if Intervene.recast then
			if Intervene.recast > 0 then
				textColor('Intervene','cooldown')
				Intervene.flashed = false
			else
				textColor('Intervene','ready')
				if not Intervene.flashed then
					flash('Intervene')
				end
				Intervene.flashed = true
			end
		else
			textColor('Intervene','notfound')
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

		if Chivalry.recast then
			if Chivalry.recast > 0 then
				textColor('Chivalry','cooldown')
				Chivalry.flashed = false
			else
				textColor('Chivalry','ready')
				if not Chivalry.flashed then
					flash('Chivalry')
				end
				Chivalry.flashed = true
			end
		else
			textColor('Chivalry','notfound')
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
			elseif  Crusade.recast > 0 then
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

		if DivineEmblem.recast then
			if buffactive['Divine Emblem'] then
				textColor('Divine Emblem','active')
				DivineEmblem.flashed = false
			elseif DivineEmblem.recast > 0 then
				textColor('Divine Emblem','cooldown')
				DivineEmblem.flashed = false
			else
				textColor('Divine Emblem','ready')
				if not DivineEmblem.flashed then
					flash('Divine Emblem')
				end
				DivineEmblem.flashed = true
			end
		else
			textColor('Divine Emble','notfound')
		end

		if Enlight.recast then
			if buffactive['Enlight'] then
				textColor('Enlight','active')
				Enlight.flashed = false
			elseif Enlight.recast > 0 then
				textColor('Enlight','cooldown')
				Enlight.flashed = false
			else
				textColor('Enlight','ready')
				if not Enlight.flashed then
					flash('Enlight')
				end
				Enlight.flashed = true
			end
		else
			textColor('Enlight','notfound')
		end

		if Fealty.recast then
			if buffactive['Fealty'] then
				textColor('Fealty','active')
				Fealty.flashed = false
			elseif Fealty.recast > 0 then
				textColor('Fealty','cooldown')
				Fealty.flashed = false
			else
				textColor('Fealty','ready')
				if not Fealty.flashed then
					flash('Fealty')
				end
				Fealty.flashed = true
			end
		else
			textColor('Fealty','notfound')
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

		if Majesty.recast then
			if buffactive['Majesty'] then
				textColor('Majesty','active')
				Majesty.flashed = false
			elseif Majesty.recast > 0 then
				textColor('Majesty','cooldown')
				Majesty.flashed = false
			else
				textColor('Majesty','ready')
				if not Majesty.flashed then
					flash('Majesty')
				end
				Majesty.flashed = true
			end
		else
			textColor('Majesty','notfound')
		end

		if Palisade.recast then
			if buffactive['Palisade'] then
				textColor('Palisade','active')
				Palisade.flashed = false
			elseif Palisade.recast > 0 then
				textColor('Palisade','cooldown')
				Palisade.flashed = false
			else
				textColor('Palisade','ready')
				if not Palisade.flashed then
					flash('Palisade')
				end
				Palisade.flashed = true
			end
		else
			textColor('Palisade','notfound')
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

		if Rampart.recast then
			if buffactive['Rampart'] then
				textColor('Rampart','active')
				Rampart.flashed = false
			elseif Rampart.recast > 0 then
				textColor('Rampart','cooldown')
				Rampart.flashed = false
			else
				textColor('Rampart','ready')
				if not Rampart.flashed then
					flash('Rampart')
				end
				Rampart.flashed = true
			end
		else
			textColor('Rampart','notfound')
		end

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

		if Reprisal.recast then
			if buffactive['Reprisal'] then
				textColor('Reprisal','active')
				Reprisal.flashed = false
			elseif Reprisal.recast > 0 then
				textColor('Reprisal','cooldown')
				Reprisal.flashed = false
			else
				textColor('Reprisal','ready')
				if not Reprisal.flashed then
					flash('Reprisal')
				end
				Reprisal.flashed = true
			end
		else
			textColor('Reprisal','notfound')
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

		if Sepulcher.recast then
			if Sepulcher.recast > 0 then
				textColor('Sepulcher','cooldown')
				Sepulcher.flashed = false
			else
				textColor('Sepulcher','ready')
				if not Sepulcher.flashed then
					flash('Sepulcher')
				end
				Sepulcher.flashed = true
			end
		else
			textColor('Sepulcher','notfound')
		end

		if ShieldBash.recast then
			if ShieldBash.recast > 0 then
				textColor('Shield Bash','cooldown')
				ShieldBash.flashed = false
			else
				textColor('Shield Bash','ready')
				if not ShieldBash.flashed then
					flash('Shield Bash')
				end
				ShieldBash.flashed = true
			end
		else
			textColor('Shield Bash','notfound')
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

	end

	--1 second heartbeat
	if current_time - last_second >= 1 then

		last_second = current_time

		if AutoMajesty and buffactive['Majesty'] then
			MajestyTimer = MajestyTimer - 1
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
	elseif newSubjob == 'WAR' then
		subjob = 'WAR'
		if SubWARPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubWARPage)
		end
	elseif newSubjob == 'SCH' then
		subjob = 'SCH'
		if SubSCHPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubSCHPage)
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
			--Weapon Skill gets blinked:
			elseif act.targets[1].actions[1].message == 31 then
				hud_noti_shdw:text('«« '..weaponskills[act.param].english..' Blinked »»')
				hud_noti:text('«« '..weaponskills[act.param].english..' Blinked »»')
				hud_noti:color(0,255,255)
			--Weapon Skill lands and creates a Skillchain:
			elseif act.targets[1].actions[1].message == 185 and act.targets[1].actions[1].has_add_effect then
				hud_noti_shdw:text(weaponskills[act.param].english..': '..addCommas(act.targets[1].actions[1].param)..' ('..sc[act.targets[1].actions[1].add_effect_animation]..': '..addCommas(act.targets[1].actions[1].add_effect_param)..')')
				hud_noti:text(weaponskills[act.param].english..': '..addCommas(act.targets[1].actions[1].param)..' ('..sc[act.targets[1].actions[1].add_effect_animation]..': '..addCommas(act.targets[1].actions[1].add_effect_param)..')')
				hud_noti:color(0,255,255)
			--Weapon Skill lands but no Skillchain:
			elseif act.targets[1].actions[1].message == 185 then
				hud_noti_shdw:text(weaponskills[act.param].english..': '..addCommas(act.targets[1].actions[1].param))
				hud_noti:text(weaponskills[act.param].english..': '..addCommas(act.targets[1].actions[1].param))
				hud_noti:color(0,255,255)
			end
			NotiCountdown = -1
		--Magic Bursts (magic):
		elseif (act.category == 4 and act.targets[1].actions[1].message == 252) and act.actor_id == player.id then
			hud_noti_shdw:text('Magic Burst! '..spells[act.param].english..': '..addCommas(act.targets[1].actions[1].param))
			hud_noti:text('Magic Burst! '..spells[act.param].english..': '..addCommas(act.targets[1].actions[1].param))
			hud_noti:color(0,255,255)
			NotiCountdown = -1
		--Magic Busts (lunge/swipe):
		elseif (act.category == 15 and act.targets[1].actions[1].message == 110 and act.targets[1].actions[1].unknown == 4) and act.actor_id == player.id then
			hud_noti_shdw:text('Magic Burst! '..jobabilities[act.param].english..': '..addCommas(act.targets[1].actions[1].param))
			hud_noti:text('Magic Burst! '..jobabilities[act.param].english..': '..addCommas(act.targets[1].actions[1].param))
			hud_noti:color(0,255,255)
			NotiCountdown = -1
		end
	end
end)

-------------------------------------------
--             FILE UNLOAD               --
-------------------------------------------

function file_unload()

	--Delete our aliases and binds, thank you for your service
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

28 points: (sub job 50, ML19 or under)
Cocoon(1)			-Cast for defense
Blank Gaze(2)		-Cast for single target hate
Jettatura(4)		-Cast for single target/narrow frontal cone hate
Sheep Song(2) 		-Cast for AOE hate
Geist Wall(3)		-Cast for AOE hate
Stinking Gas(2)		-Cast for AOE hate
Sound Blast(1)		-Cast for AOE hate
Ice Break(3)		-Magic Def. Bonus trait
Magnetite Cloud(3)	-Magic Def. Bonus trait
Foot Kick(2)		-Lizard Killer trait (includes Gabbrath)
Claw Cyclone(2)		-Lizard Killer trait
Power Attack(1)		-Plantoid Killer trait (includes Yggdreant)
Mandibular Bite(2)	-Plantoid Killer trait

33 points: (sub job 51, ML20 or higher)
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
