-------------------------------------------
--  Keys Gearswap lua file for Warrior   --
-------------------------------------------
--[[

Updates to this file and other GearSwap files and addons can be found at
https://github.com/iLVL-Key/FFXI

Place both this file and the sounds folder inside the GearSwap data folder
	/addons/GearSwap/data/sounds/
	/addons/GearSwap/data/WAR.lua

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

Hide or show the HUD at any time by typing
	//hud

--------------------

To create a new set for a Weapon Skill that is not already listed, simply copy any other named
Weapon Skill set and change the name to the desired Weapon Skill. For example, you can create
a Flat Blade set by copying the entire Savage Blade set and changing the set name as such:

from
	sets["Savage Blade"]
to
	sets["Flat Blade"]

Additionally, you can create a new "High Buff" Weapon Skill set (for when you are over the
AttackCapThreshold set in the Advanced Options) by adding ".high_buff" to the end of the set name as such:

from
	sets["Flat Blade"]
to
	sets["Flat Blade"].high_buff

NOTE: A High Buff set will only work if there is already a normal set for that specific Weapon Skill.

--------------------

IMPORTANT:
When you load this file for the first time, your HUD may not be in a good position, or may be too large.
If the HUD is not in a good position, go to the Heads Up Display options below and adjust the HUDposX and HUDposY
options, then save and reload the file. Adjust and repeat until positioned as desired.
If the HUD is too large (or small), adjust the FontSize, LineSpacer, and ColumnSpacer options as needed.
Suggested placement is center screen, just above your chat log.

--]]

-------------------------------------------
--                OPTIONS                --
-------------------------------------------

Book			=	'8'		--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
SubDRGPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing DRG.
SubDNCPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing DNC.
SubSAMPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing SAM.
SubNINPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing NIN.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
MSTimer			=	true	--[true/false]	Displays a timer for Mighty Strikes in echo.
BRTimer			=	true	--[true/false]	Displays a timer for Brazen Rush in echo.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions
							--				(Town limits this to town gear only).
AlertSounds		=	true	--[true/false]	Plays a sound on alerts.
UseEcho			=	'R'		--[E/R/Off]		Automatically uses an (E)cho Drop or (R)emedy instead of spell when you are silenced.
AutoStance		=	true	--[true/false]	Automatically activates and keeps Hasso/Seigan Stances active.
AutoSave		=	true	--[true/false]	Attempts to use High Jump when your HP gets critically low.
							--				NOTE: Will not activate while in Seigan Stance.

-- Heads Up Display --
HUDposX			=	100	--	X position for the HUD. 0 is left of the window, increasing this number will move it to the right.
HUDposY			=	100		--	Y position for the HUD. 0 is top of the window, increasing this number will move it downward.
FontSize		=	10.5	--	Adjust the font size. Changing this may require you to adjust the Spacers below as well.
LineSpacer		=	17		--	Space in pixels between each Line of the HUD.
ColumnSpacer	=	95		--	Space in pixels between each Column of the HUD.
ShowTPMeter		=	true	--[true/false]	Show the mini TP Meter inside the Weapons area of the HUD.

modeName = {
--HUD Mode Names
	Mode1 = 'Multi-Attack',			--Standard set.
	Mode2 = 'Multi-Attack W/ DT',	--Standard set.
	Mode3 = 'High Accuracy',			--Special set. NOTE: WSs will use the Weapon Skill - Accuracy set.
	Mode4 = 'Tank',					--Standard set.
}

notifications = {
-- General Notifications --
	ReraiseReminder	=	true,	--[true/false]	Displays an occasional reminder if Reraise is not up.
	TP3000			=	true,	--[true/false]	Displays a notification when you have 3000 TP.
	Damage			=	true,	--[true/false]	Displays your Weapon Skill, Skillchain, and Magic Burst damage.
	Food			=	true,	--[true/false]	Displays a notification when food wears off.
	Invis			=	true,	--[true/false]	Displays a notification when Invisible is about to wear off.
	Invite			=	true,	--[true/false]	Displays a notification when someone invites to a party/alliance.
	LowHP			=	true,	--[true/false]	Displays a notification when HP is low.
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

ShowHUD				=	true	--[true/false]  Initial state of the HUD. Use `//hud` to show/hide the HUD in game.
StartMode			=	'Mode1'	--[Mode1/Mode2/Mode3/Mode4]
								--	Determines the Mode you will start in. Current Mode can be changed at any time by using any
								--	of the three options listed above in the Notes section (a macro, alias, or keyboard shortcut).
ModeBind			=	'^g'	--Sets the keyboard shortcut you would like to cycle between Modes. CTRL+G (^g) is default.
WCBind				=	'^h'	--Sets the keyboard shortcut you would like to activate the Weapon Cycle. CTRL+H (^h) is default.
								--    ^ = CTRL    ! = ALT    @ = WIN    # = APPS    ~ = SHIFT
AutoStanceWindow	=	60		--Time in seconds left before a Stance wears off that AutoStance will activate after another ability.
LowHPThreshold		=	1000	--Below this number is considered Low HP.
AutoSaveThreshold	=	1000	--If your HP goes below this number, a "save" will be used.
AttackCapThreshold	=	4000	--Using a WS while your attack is above this number will use a high_buff WS set if available.
								--NOTE: This number is checked before WS gear is switched, base this on attack while in your TP set(s).
DangerRepeat		=	5		--Maximum number of times the Danger Sound will repeat, once per second.
RRReminderTimer		=	1800	--Delay in seconds between checks to see if Reraise is up (300 is 5 minutes).
NotiDelay			=	6		--Delay in seconds before certain notifications will automatically clear.
PollingRate			=	5		--Times per second to check for various conditions (debuffs, ammo, etc). Higher rates use more CPU.
AddCommas			=	true	--[true/false]  Adds commas to damage numbers.

-------------------------------------------
--              HUD RECAST               --
-------------------------------------------

-- Controls what is displayed in the HUD Recast section.
-- The first column tells the file which ability/spell to place in that slot, the following are valid for use:
--		Mighty Strikes, Brazen Rush, Aggressor, Berserk, Blood Rage, Contradance, Defender, Flourishes I, Flourishes II, Hasso, High Jump, Jigs, Jump, Meditate, Restraint, Retaliation, Sambas, Seigan, Sekkanoki, Steps, Super Jump, Third Eye, Tomahawk, Warcry, Warding Circle, Warrior's Charge
-- The "_sh" column allows you to change the name displayed if you would like, leave blank otherwise.
-- NOTE: Names will automatically be truncated to 10 characters to fit correctly.

sub = {
	--DPS MODES (Modes 1, 2, and 3)
	dps = {
		--WAR/DRG
		DRG = {
			Abil01 = "Aggressor",	Abil01_sh = "",
			Abil02 = "Berserk",		Abil02_sh = "",
			Abil03 = "Warcry",		Abil03_sh = "",
			Abil04 = "Restraint",	Abil04_sh = "",
			Abil05 = "Blood Rage",	Abil05_sh = "",
			Abil06 = "Super Jump",	Abil06_sh = "",
		},
		--WAR/DNC
		DNC = {
			Abil01 = "Aggressor",		Abil01_sh = "",
			Abil02 = "Berserk",			Abil02_sh = "",
			Abil03 = "Warcry",			Abil03_sh = "",
			Abil04 = "Restraint",		Abil04_sh = "",
			Abil05 = "Blood Rage",		Abil05_sh = "",
			Abil06 = "Flourishes II",	Abil06_sh = "Rvrs Flrsh",
		},
		--WAR/SAM
		SAM = {
			Abil01 = "Aggressor",	Abil01_sh = "",
			Abil02 = "Berserk",		Abil02_sh = "",
			Abil03 = "Warcry",		Abil03_sh = "",
			Abil04 = "Restraint",	Abil04_sh = "",
			Abil05 = "Blood Rage",	Abil05_sh = "",
			Abil06 = "Meditate",	Abil06_sh = "",
		},
		--WAR/NIN
		NIN = {
			Abil01 = "Aggressor",	Abil01_sh = "",
			Abil02 = "Berserk",		Abil02_sh = "",
			Abil03 = "Warcry",		Abil03_sh = "",
			Abil04 = "Restraint",	Abil04_sh = "",
			Abil05 = "Retaliation",	Abil05_sh = "Retaliatn",
			Abil06 = "Blood Rage",	Abil06_sh = "",
		},
		--WAR/other
		OTH = {
			Abil01 = "Aggressor",	Abil01_sh = "",
			Abil02 = "Berserk",		Abil02_sh = "",
			Abil03 = "Warcry",		Abil03_sh = "",
			Abil04 = "Restraint",	Abil04_sh = "",
			Abil05 = "Retaliation",	Abil05_sh = "Retaliatn",
			Abil06 = "Blood Rage",	Abil06_sh = "",
		},
	},
	--TANK MODE (Mode 4)
	tank = {
		--WAR/DRG
		DRG = {
			Abil01 = "Aggressor",	Abil01_sh = "",
			Abil02 = "Berserk",		Abil02_sh = "",
			Abil03 = "Warcry",		Abil03_sh = "",
			Abil04 = "Restraint",	Abil04_sh = "",
			Abil05 = "Blood Rage",	Abil05_sh = "",
			Abil06 = "Super Jump",	Abil06_sh = "",
		},
		--WAR/DNC
		DNC = {
			Abil01 = "Aggressor",		Abil01_sh = "",
			Abil02 = "Berserk",			Abil02_sh = "",
			Abil03 = "Warcry",			Abil03_sh = "",
			Abil04 = "Restraint",		Abil04_sh = "",
			Abil05 = "Blood Rage",		Abil05_sh = "",
			Abil06 = "Flourishes II",	Abil06_sh = "Rvrs Flrsh",
		},
		--WAR/SAM
		SAM = {
			Abil01 = "Aggressor",	Abil01_sh = "",
			Abil02 = "Berserk",		Abil02_sh = "",
			Abil03 = "Warcry",		Abil03_sh = "",
			Abil04 = "Restraint",	Abil04_sh = "",
			Abil05 = "Blood Rage",	Abil05_sh = "",
			Abil06 = "Meditate",	Abil06_sh = "",
		},
		--WAR/NIN
		NIN = {
			Abil01 = "Aggressor",	Abil01_sh = "",
			Abil02 = "Defender",	Abil02_sh = "",
			Abil03 = "Warcry",		Abil03_sh = "",
			Abil04 = "Restraint",	Abil04_sh = "",
			Abil05 = "Retaliation",	Abil05_sh = "Retaliatn",
			Abil06 = "Blood Rage",	Abil06_sh = "",
		},
		--WAR/other
		OTH = {
			Abil01 = "Aggressor",	Abil01_sh = "",
			Abil02 = "Defender",	Abil02_sh = "",
			Abil03 = "Warcry",		Abil03_sh = "",
			Abil04 = "Restraint",	Abil04_sh = "",
			Abil05 = "Retaliation",	Abil05_sh = "Retaliatn",
			Abil06 = "Blood Rage",	Abil06_sh = "",
		},
	}
}

-------------------------------------------
--             COLOR VALUES              --
-------------------------------------------

color = {
	-- MODES --
	Mode1	= {r = 125, g = 125, b = 255},	-- Default: Multi-Attack
	Mode2	= {r = 255, g = 125, b = 50},	-- Default: Multi-Attack W/ DT
	Mode3	= {r = 125, g = 255, b = 125},	-- Default: High Accuracy
	Mode4	= {r = 255, g = 255, b = 125},	-- Default: Tank

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
	{"Naegling", "Blurred Shield +1"},
	{"Loxotic Mace +1", "Blurred Shield +1"},
	{"Ukonvasara", "Utu Grip"},
	{"Chango", "Utu Grip"},
	{"Shining One", "Utu Grip"},
	--{"Main Slot", "Sub Slot"},
}

-- These are the Main/Sub combos that get added to the Weapon Cycle while in Abyssea for Procs. Add more pairs on new lines as needed
-- NOTE: if a slot should be empty, use `empty` with no quotation marks. ie: {"Fruit Punches", empty},
AbysseaProcCycle = {
	{"Qutrub Knife", "Blurred Shield +1"},
	{"Excalipoor II", "Blurred Shield +1"},
	{"Heartstopper +1", "Blurred Shield +1"},
	{"Yagyu Shortblade", "Blurred Shield +1"},
	{"Hapy Staff", "Flanged Grip"},
	{"Goujian", "Flanged Grip"},
	{"Melon Slicer", "Flanged Grip"},
	{"Maven's Scythe", "Flanged Grip"},
	{"Sha Wujing's Lance", "Flanged Grip"},
	--{"Main Slot", "Sub Slot"},
}

-------------------------------------------
--               GEAR SETS               --
-------------------------------------------

sets.Mode1 = {} sets.Mode2 = {} sets.Mode3 = {} sets.Mode4 = {}

function get_sets()

-- Mode 1 Single Wield (Multi-Attack) (Example: A focus on Multi-Attack and Store TP, then filling in the rest with DEX, Accuracy, and Attack)
-- NOTE: Think "Glass Cannon", lower-end content, pure stats, don't care about DT
sets.Mode1.single_wield = {
	ammo="Coiste Bodhar",
	head="Sakpata's Helm",
	--head="Boii Mask +3",
	body="Dagon Breast.",
	--body="Boii Lorica +3",
	hands="Sakpata's Gauntlets",
	legs="Sakpata's Cuisses",
	--legs="Pumm. Cuisses +3",
	feet="Pumm. Calligae +4",
	neck="War. Beads +2",
	waist="Sailfi Belt +1",
	left_ear="Schere Earring",
	right_ear="Boii Earring +2",
	left_ring="Hetairoi Ring",
	right_ring="Niqmaddu Ring",
	back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

-- Mode 1 Two-Handed (Multi-Attack) (Example: A focus on Multi-Attack and Store TP, then filling in the rest with DEX, Accuracy, and Attack)
-- NOTE: Think "Glass Cannon", lower-end content, pure stats, don't care about DT
sets.Mode1.two_handed = set_combine(sets.Mode1.single_wield, {
	ammo="Yetshila +1",
	head="Sakpata's Helm",
	body="Sakpata's Plate",
	hands="Sakpata's Gauntlets",
	legs="Boii Cuisses +3",
	feet="Boii Calligae +3",
	neck="War. Beads +2",
	waist="Ioskeha Belt +1",
	left_ear="Schere Earring",
	right_ear="Boii Earring +2",
	left_ring="Hetairoi Ring",
	right_ring="Niqmaddu Ring",
	back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
})

-- Mode 1 Dual Wield (Multi-Attack) (Example: A focus on Dual Wield, Multi-Attack and Store TP, then filling in the rest with DEX, Accuracy, and Attack)
-- NOTE: Think "Glass Cannon", lower-end content, pure stats, don't care about DT
sets.Mode1.dual_wield = set_combine(sets.Mode1.single_wield, {

})

-- Mode 2 Single Wield (Multi-Attack W/ DT) (Example: A focus on Multi-Attack and Store TP, with enough DT to survive higher end content)
sets.Mode2.single_wield = set_combine(sets.Mode1.single_wield, {

})

-- Mode 2 Two-Handed (Multi-Attack W/ DT) (Example: A focus on Multi-Attack and Store TP, with enough DT to survive higher end content)
sets.Mode2.two_handed = set_combine(sets.Mode1.two_handed, {

})

-- Mode 2 Dual Wield (Multi-Attack W/ DT) (Example: A focus on Dual Wield, Multi-Attack and Store TP, with enough DT to survive higher end content)
sets.Mode2.dual_wield = set_combine(sets.Mode1.dual_wield, {

})

-- Mode 3 Single Wield (Accuracy) (Example: A focus on DEX and Accuracy, then filling in the rest with a mix of Multi-Attack, Store TP, and Attack)
-- NOTE: This is a special set. Weapon skills will default to the Weapon Skill - Accuracy set.
sets.Mode3.single_wield = set_combine(sets.Mode1.single_wield, {

})

-- Mode 3 Two-Handed (Accuracy) (Example: A focus on DEX and Accuracy, then filling in the rest with a mix of Multi-Attack, Store TP, and Attack)
-- NOTE: This is a special set. Weapon skills will default to the Weapon Skill - Accuracy set.
sets.Mode3.two_handed = set_combine(sets.Mode1.two_handed, {

})

-- Mode 3 Dual Wield (Accuracy) (Example: A focus on DEX and Accuracy, then filling in the rest with a mix of Multi-Attack, Store TP, and Attack)
-- NOTE: This is a special set. Weapon skills will default to the Weapon Skill - Accuracy set.
sets.Mode3.dual_wield = set_combine(sets.Mode1.dual_wield, {

})

-- Mode 4 Single Wield (Tank) (Example: A focus on DT, HP, Killer effects, then filling in the rest with Multi-Attack, Store TP, and Attack)
sets.Mode4.single_wield = set_combine(sets.Mode1.single_wield, {

})

-- Mode 4 Two-Handed (Tank) (Example: A focus on DT, HP, Killer effects, then filling in the rest with Multi-Attack, Store TP, and Attack)
sets.Mode4.two_handed = set_combine(sets.Mode1.two_handed, {

})

-- Mode 4 Dual Wield (Tank) (Example: A focus on DT, HP, Killer effects, then filling in the rest with Multi-Attack, Store TP, and Attack)
sets.Mode4.dual_wield = set_combine(sets.Mode1.dual_wield, {

})

-- Idle (Movement Speed, Regain, Regen)
sets.idle = {
	ammo="Staunch Tathlum +1",
	head="Null Masque",
	body="Sakpata's Plate",
	hands="Sakpata's Gauntlets",
	legs="Sakpata's Cuisses",
	feet="Sakpata's Leggings",
	neck="Rep. Plat. Medal",
	waist="Null Belt",
	left_ear="Alabaster Earring",
	right_ear="Boii Earring +2",
	left_ring="Defending Ring",
	right_ring="Karieyh Ring +1",
	back="Null Shawl",
}

-- Movement Speed
-- Automatically equips while in town, and while moving outside of town.
-- NOTE: To disable, leave this set empty and instead include your movement speed gear in the Idle set above.
sets.movement_speed = {
	feet="Hermes' Sandals",
}

-- Oh Shit
-- Full DT- and everything you've got with Absorbs or Annuls Damage
sets.oh_shit = {
	head="Null Masque",
	body="Sakpata's Plate",
	hands="Sakpata's Gauntlets",
	legs="Sakpata's Cuisses",
	neck="Warder's Charm +1",
	waist="Carrier's Sash",
	left_ear="Alabaster Earring",
	left_ring="Defending Ring",
	right_ring="Shadow Ring",
	back="Shadow Mantle",
}

-- Weapon Skill - Basic (STR, TP Bonus, Multi-hit, Crit, Attack)
sets.weapon_skill = {
	ammo="Knobkierrie",
	head="Agoge Mask +4",
	body="Nyame Mail",
	hands="Boii Mufflers +3",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="War. Beads +2",
	waist="Sailfi Belt +1",
	left_ear="Moonshade Earring",
	right_ear="Thrud Earring",
	left_ring="Cornelia's Ring",
	right_ring="Karieyh Ring +1",
	back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}

-- Weapon Skill - Accuracy (WS Accuracy, Accuracy)
-- NOTE: This is a special set for weapon skill accuracy. When in Accuracy mode (mode 3), weapon skills will use this set.
sets.ws_accuracy = {
	neck="Fotia Gorget",
	waist="Fotia Belt",
	left_ring="Cornelia's Ring",
	right_ring="Karieyh Ring +1",
}

-- Armor Break (Magic Accuracy)
sets["Armor Break"] = set_combine(sets.weapon_skill, {
	head="Boii Mask +3",
	body="Boii Lorica +3",
	hands="Boii Mufflers +3",
	legs="Boii Cuisses +3",
	feet="Boii Calligae +3",
	neck="Null Loop",
	waist="Null Belt",
	back="Null Shawl",
})

-- Disaster (STR, VIT)
sets["Disaster"] = set_combine(sets.weapon_skill, {

})

-- Disaster - High Buff (STR, VIT, PDL)
sets["Disaster"].high_buff = set_combine(sets["Disaster"], {

})

-- Fimbulvetr (STR, VIT)
sets["Fimbulvetr"] = set_combine(sets.weapon_skill, {

})

-- Fimbulvetr - High Buff (STR, VIT, PDL)
sets["Fimbulvetr"].high_buff = set_combine(sets["Fimbulvetr"], {

})

-- Impulse Drive (STR, Crit (w/ Shining One))
sets["Impulse Drive"] = set_combine(sets.weapon_skill, {
	ammo="Yetshila +1",
	body="Sakpata's Plate",
	hands="Boii Mufflers +3",
	legs="Boii Cuisses +3",
	feet="Boii Calligae +3",
	right_ear="Boii Earring +2",
	left_ring="Regal Ring",
	right_ring="Niqmaddu Ring",
})

-- Impulse Drive - High Buff (STR, Crit (w/ Shining One), PDL)
sets["Impulse Drive"].high_buff = set_combine(sets["Impulse Drive"], {
	ammo="Yetshila +1",
	body="Sakpata's Plate",
	hands="Boii Mufflers +3",
	legs="Boii Cuisses +3",
	feet="Boii Calligae +3",
	right_ear="Boii Earring +2",
	left_ring="Sroda Ring",
	right_ring="Niqmaddu Ring",
})

-- Judgment (STR, MND, Fencer, TP Bonus)
sets["Judgment"] = set_combine(sets.weapon_skill, {
	body="Nyame Mail",
	right_ring="Regal Ring",
})

-- Judgment - High Buff (STR, MND, Fencer, TP Bonus, PDL)
sets["Judgment"].high_buff = set_combine(sets["Judgment"], {
	body="Sakpata's Plate",
	hands="Boii Mufflers +3",
	legs="Boii Cuisses +3",
	right_ring="Sroda Ring",
})

-- Resolution (STR, TP Bonus)
sets["Resolution"] = set_combine(sets.weapon_skill, {
	hands="Sakpata's Gauntlets",
	legs="Boii Cuisses +3",
	feet="Sakpata's Leggings",
	neck="Fotia Gorget",
	waist="Fotia Belt",
	left_ear="Schere Earring",
	right_ear="Moonshade Earring",
	left_ring="Regal Ring",
	right_ring="Niqmaddu Ring",
})

-- Resolution - High Buff (STR, TP Bonus, PDL)
sets["Resolution"].high_buff = set_combine(sets["Resolution"], {
	head="Sakpata's Helm",
	body="Sakpata's Plate",
	hands="Sakpata's Gauntlets",
	legs="Boii Cuisses +3",
	feet="Sakpata's Leggings",
	neck="Fotia Gorget",
	waist="Fotia Belt",
	left_ear="Schere Earring",
	right_ear="Moonshade Earring",
	left_ring="Sroda Ring",
	right_ring="Niqmaddu Ring",
})

-- Sanguine Blade (Dark Elemental Magic Attack Bonus)
sets["Sanguine Blade"] = set_combine(sets.weapon_skill, {
	ammo="Coiste Bodhar",
	head="Pixie Hairpin +1",
	waist="Eschan Stone",
	right_ear="Friomisi Earring",
	left_ring="Archon Ring",
})

-- Savage Blade (STR, MND, Fencer, TP Bonus)
sets["Savage Blade"] = set_combine(sets.weapon_skill, {
	left_ring="Regal Ring",
})

-- Savage Blade - High Buff (STR, MND, Fencer, TP Bonus, PDL)
sets["Savage Blade"].high_buff = set_combine(sets["Savage Blade"], {
	body="Sakpata's Plate",
	legs="Boii Cuisses +3",
	left_ring="Sroda Ring",
})

-- Stardiver (STR, MND, Fencer, TP Bonus)
sets["Stardiver"] = set_combine(sets.weapon_skill, {
	ammo="Yetshila +1",
	head="Boii Mask +3",
	body="Sakpata's Plate",
	hands="Sakpata's Gauntlets",
	legs="Boii Cuisses +3",
	feet="Boii Calligae +3",
	neck="Fotia Gorget",
	waist="Fotia Belt",
	left_ear="Moonshade Earring",
	right_ear="Boii Earring +3",
	left_ring="Regal Ring",
	right_ring="Niqmaddu Ring",
})

-- Stardiver - High Buff (STR, MND, Fencer, TP Bonus, PDL)
sets["Stardiver"].high_buff = set_combine(sets["Stardiver"], {
	ammo="Yetshila +1",
	head="Boii Mask +3",
	body="Sakpata's Plate",
	hands="Sakpata's Gauntlets",
	legs="Boii Cuisses +3",
	feet="Boii Calligae +3",
	neck="Fotia Gorget",
	waist="Fotia Belt",
	left_ear="Moonshade Earring",
	right_ear="Boii Earring +3",
	left_ring="Sroda Ring",
	right_ring="Niqmaddu Ring",
})

-- Ukko's Fury (STR, TP Bonus, Multi-hit, Crit, Attack)
sets["Ukko's Fury"] = set_combine(sets.weapon_skill, {
	ammo="Yetshila +1",
	head="Boii Mask +3",
	body="Sakpata's Plate",
	feet="Boii Calligae +3",
	left_ear="Schere Earring",
	right_ear="Boii Earring +2",
	left_ring="Regal Ring",
	right_ring="Niqmaddu Ring",
})

-- Ukko's Fury - High Buff (STR, TP Bonus, Multi-hit, Crit, Attack, PDL)
sets["Ukko's Fury"].high_buff = set_combine(sets["Ukko's Fury"], {
	ammo="Yetshila +1",
	head="Boii Mask +3",
	body="Sakpata's Plate",
	hands="Sakpata's Gauntlets",
	legs="Boii Cuisses +3",
	feet="Boii Calligae +3",
	left_ear="Schere Earring",
	right_ear="Boii Earring +2",
	left_ring="Sroda Ring",
	right_ring="Niqmaddu Ring",
})

-- Upheaval (VIT, TP Bonus, Multi-hit, Crit, Attack)
sets["Upheaval"] = set_combine(sets.weapon_skill, {
	legs="Boii Cuisses +3",
	left_ring="Regal Ring",
	right_ring="Niqmaddu Ring",
})

-- Upheaval - High Buff (VIT, TP Bonus, Multi-hit, Crit, Attack, PDL)
sets["Upheaval"].high_buff = set_combine(sets["Upheaval"], {
	body="Sakpata's Plate",
	hands="Sakpata's Gauntlets",
	legs="Boii Cuisses +3",
	left_ring="Sroda Ring",
	right_ring="Niqmaddu Ring",
})

-- Hachirin-no-obi
sets.hachirin_no_obi = {
	--waist="Hachirin-no-obi",
}

-- Fast Cast (cap is 80%)
sets.fast_cast = {
	ammo="Sapience Orb",
	head="Sakpata's Helm",
	body="Odyss. Chestplate",
	hands="Leyline Gloves",
	legs="Nyame Flanchard",
	feet="Odyssean Greaves",
	neck="Baetyl Pendant",
	left_ear="Loquac. Earring",
	right_ear="Etiolation Earring",
	left_ring="Defending Ring",
	right_ring="Prolix Ring",
}

-- Snapshot
sets.snapshot = {

}

-- Ygnas's Resolve +1
-- NOTE: Will combine with the appropriate Weapon Skill set while participating in a Reive
sets.ygnass_resolve_1 = {
	--neck="Ygnas's Resolve +1",
}

-- Provoke
sets.provoke = {

}

-- Tomahawk
sets.tomahawk = {
	ammo="Thr. Tomahawk",
	feet="Agoge Calligae +3",
}

-- Aggressor
sets.aggressor = {
	head="Pummeler's Mask +3",
	body="Agoge Lorica +3",
}

-- Berserk
sets.berserk = {
	body="Pumm. Lorica +3",
	feet="Agoge Calligae +3",
}

-- Defender
sets.defender = {

}

-- Warcry
sets.warcry = {
	head="Agoge Mask +4",
}

-- Restraint
sets.restraint = {
	hands="Boii Mufflers +3",
}

-- Retaliation
sets.retaliation = {
	hands="Pumm. Mufflers +2",
}

-- Blood Rage
sets.blood_rage = {
	body="Boii Lorica +3",
}

-- Warrior's Charge
sets.warriors_charge = {
	legs="Agoge Cuisses +1",
}

-- Mighty Strikes
sets.mighty_strikes = {
	hands="Agoge Mufflers +1"
}

-- Steps
sets.steps = {

}

-- Waltzes
sets.waltzes = {
	legs="Dashing Subligar",
}

-- Animated Flourish
sets.animated_flourish = {

}

-- Violent Flourish
sets.violent_flourish = {

}

-- Holy Water (Holy Water+)
sets.holy_water = {
	neck="Nicander's Necklace",
	ring1="Blenmot's Ring +1",
	ring2="Blenmot's Ring +1",
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
--           MAGIC WS MAPPING           --
-------------------------------------------

MagicWS = S{
	'Burning Blade','Red Lotus Blade','Shining Blade','Seraph Blade','Frostbite','Freezebite'
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
items = res.items
Mode = StartMode --sets the starting mode (selected in the Advanced Options)
Stance = 'None' --Start off without Hasso/Seigan up, this will update when either is activated
RRRCountdown = RRReminderTimer
HUDposYLine1 = HUDposY
last_poll = 0 --keeps the timing for things that happen at the polling rate
last_second = 0 --keeps the timing for things that happen every second
GreetingDelay = 6 --delay to display greeting and file version info
Zoning = false --flips automatically to hide the HUD while zoning
InCS = false --flips automatically to hide the HUD while in a cs
StanceTimer = 0
AutoSaveUsed = false --this is used so we don't trigger multiple "saves" together
LowHP = false
Alive = true --makes it easier to Do Things or Not Do Things based on if we die.
announceAlive = false --simple flip when we raise to make sure the AliveDelay command and notification text is only done once
DangerCountdown = 0
NotiCountdown = -1 --we set the countdown below 0 to stop the countdown from hitting 0 and triggering the ClearNotifications command
WeaponCycleIndex = 1 --used to cycle through the WeaponCycle sets
EquipMain = ''
EquipSub = ''
SwitchingWeapons = 0 --used to delay the Aftermath checks so the Weapon Cycler cycling can be displayed faster in the HUD
currentAfterMath = ''
currentTPrange = 1
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
player_x = nil
player_y = nil
moving = false

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

-- Sets the inital subjob
local subjob = 'OTH'
if player.sub_job == 'DRG' then
	subjob = 'DRG'
elseif player.sub_job == 'DNC' then
	subjob = 'DNC'
elseif player.sub_job == 'SAM' then
	subjob = 'SAM'
elseif player.sub_job == 'NIN' then
	subjob = 'NIN'
end

-- Sets the Chat Mode
if Chat ~= "Off" then
	send_command('input /cm '..Chat)
end

-- Sets the Macro Book and Page
if Book ~= "Off" then
	send_command('input /macro book '..Book)
end
if SubDRGPage ~= "Off" and player.sub_job == 'DRG' then
	send_command('wait 2;input /macro set '..SubDRGPage)
elseif SubDNCPage ~= "Off" and player.sub_job == 'DNC' then
	send_command('wait 2;input /macro set '..SubDNCPage)
elseif SubSAMPage ~= "Off" and player.sub_job == 'SAM' then
	send_command('wait 2;input /macro set '..SubSAMPage)
elseif SubNINPage ~= "Off" and player.sub_job == 'NIN' then
	send_command('wait 2;input /macro set '..SubNINPage)
else
	send_command('wait 2;input /macro set 1')
end

if ZoneGear ~= 'Off' then
	send_command('wait 2;gs c Zone Gear')
end

MightyStrikes = {} BrazenRush = {} Aggressor = {} Berserk = {} BloodRage = {} Contradance = {} Defender = {} FlourishesI = {} FlourishesII = {} Hasso = {} HighJump = {} Jigs = {} Jump = {} Meditate = {} Restraint = {} Retaliation = {} Sambas = {} Seigan = {} Sekkanoki = {} Steps = {} SuperJump = {} ThirdEye = {} Tomahawk = {} Warcry = {} WardingCircle = {} WarriorsCharge = {}

--Start true so the HUD recasts don't flash on load
MightyStrikes.flashed = true
BrazenRush.flashed = true
Aggressor.flashed = true
Berserk.flashed = true
BloodRage.flashed = true
Contradance.flashed = true
Defender.flashed = true
FlourishesI.flashed = true
FlourishesII.flashed = true
Hasso.flashed = true
HighJump.flashed = true
Jigs.flashed = true
Jump.flashed = true
Meditate.flashed = true
Restraint.flashed = true
Retaliation.flashed = true
Sambas.flashed = true
Seigan.flashed = true
Sekkanoki.flashed = true
Steps.flashed = true
SuperJump.flashed = true
ThirdEye.flashed = true
Tomahawk.flashed = true
Warcry.flashed = true
WardingCircle.flashed = true
WarriorsCharge.flashed = true

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
local hud_mode_shdw = texts.new('Mode: '..modeName[Mode])
hud_mode_shdw:color(0,0,0)
hud_mode_shdw:font("Consolas")
hud_mode_shdw:size(FontSize)
hud_mode_shdw:bg_alpha(0)
hud_mode_shdw:pos(HUDposXColumn1+2.5,HUDposYLine2+0.5)
hud_mode_shdw:draggable(false)
hud_mode_shdw:bold(true)

-- Create the HUD Notifications Text Shadow text object
local hud_noti_shdw = texts.new('Keys WAR Gearswap file v'..FileVersion)
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
local hud_mode = texts.new('Mode: '..modeName[Mode])
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
local hud_noti = texts.new('Keys WAR Gearswap file v'..FileVersion)
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

-- Check if the equipped Main/Sub pair are in our defined AbysseaProcCycle weapons table
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

--Are we dual wielding weapons?
local function dualWield()

	local weapon_id = player.equipment.sub and items:with('name', player.equipment.sub) and items:with('name', player.equipment.sub).id or nil

	if weapon_id then
		local skill = items[weapon_id].skill
		return skill == 2 or skill == 3 or skill == 5 or skill == 9 or skill == 11
	else
		return false
	end

end

--Color the appropriate Ability/spell recast
local function textColor(abil,state)

	local formattedMode = Mode == "Mode4" and "tank" or "dps"
	local c = color.abil[state]

	if sub[formattedMode][subjob].Abil01 == abil then
		hud_abil01:color(c.r,c.g,c.b)

	elseif sub[formattedMode][subjob].Abil02 == abil then
		hud_abil02:color(c.r,c.g,c.b)

	elseif sub[formattedMode][subjob].Abil03 == abil then
		hud_abil03:color(c.r,c.g,c.b)

	elseif sub[formattedMode][subjob].Abil04 == abil then
		hud_abil04:color(c.r,c.g,c.b)

	elseif sub[formattedMode][subjob].Abil05 == abil then
		hud_abil05:color(c.r,c.g,c.b)

	elseif sub[formattedMode][subjob].Abil06 == abil then
		hud_abil06:color(c.r,c.g,c.b)

	end
end

--Flash a specific text area
local function flash(area)

	local formattedMode = Mode == "Mode4" and "tank" or "dps"

	if sub[formattedMode][subjob].Abil01 == area then
		send_command('gs c Flash_Abil01_A;wait .25;gs c Flash_Abil01_B;wait .25;gs c Flash_Abil01_A;wait .25;gs c Flash_Abil01_B;wait .25;gs c Flash_Abil01_A;wait .25;gs c Flash_Abil01_B;wait .25;gs c Flash_Abil01_A;wait .25;gs c Flash_Abil01_B')

	elseif sub[formattedMode][subjob].Abil02 == area then
		send_command('gs c Flash_Abil02_A;wait .25;gs c Flash_Abil02_B;wait .25;gs c Flash_Abil02_A;wait .25;gs c Flash_Abil02_B;wait .25;gs c Flash_Abil02_A;wait .25;gs c Flash_Abil02_B;wait .25;gs c Flash_Abil02_A;wait .25;gs c Flash_Abil02_B')

	elseif sub[formattedMode][subjob].Abil03 == area then
		send_command('gs c Flash_Abil03_A;wait .25;gs c Flash_Abil03_B;wait .25;gs c Flash_Abil03_A;wait .25;gs c Flash_Abil03_B;wait .25;gs c Flash_Abil03_A;wait .25;gs c Flash_Abil03_B;wait .25;gs c Flash_Abil03_A;wait .25;gs c Flash_Abil03_B')

	elseif sub[formattedMode][subjob].Abil04 == area then
		send_command('gs c Flash_Abil04_A;wait .25;gs c Flash_Abil04_B;wait .25;gs c Flash_Abil04_A;wait .25;gs c Flash_Abil04_B;wait .25;gs c Flash_Abil04_A;wait .25;gs c Flash_Abil04_B;wait .25;gs c Flash_Abil04_A;wait .25;gs c Flash_Abil04_B')

	elseif sub[formattedMode][subjob].Abil05 == area then
		send_command('gs c Flash_Abil05_A;wait .25;gs c Flash_Abil05_B;wait .25;gs c Flash_Abil05_A;wait .25;gs c Flash_Abil05_B;wait .25;gs c Flash_Abil05_A;wait .25;gs c Flash_Abil05_B;wait .25;gs c Flash_Abil05_A;wait .25;gs c Flash_Abil05_B')

	elseif sub[formattedMode][subjob].Abil06 == area then
		send_command('gs c Flash_Abil06_A;wait .25;gs c Flash_Abil06_B;wait .25;gs c Flash_Abil06_A;wait .25;gs c Flash_Abil06_B;wait .25;gs c Flash_Abil06_A;wait .25;gs c Flash_Abil06_B;wait .25;gs c Flash_Abil06_A;wait .25;gs c Flash_Abil06_B')

	elseif area == 'Noti' then
		send_command('gs c Flash_Noti_A;wait .25;gs c Flash_Noti_B;wait .25;gs c Flash_Noti_A;wait .25;gs c Flash_Noti_B')

	elseif area == 'Debuffs' then
		send_command('gs c Flash_Debuffs_A;wait .25;gs c Flash_Debuffs_B;wait .25;gs c Flash_Debuffs_A;wait .25;gs c Flash_Debuffs_B')

	end
end

local function getRecasts()

	local ability_recast = windower.ffxi.get_ability_recasts()

	MightyStrikes.recast = ability_recast[0] and math.ceil(ability_recast[0]) or nil
	BrazenRush.recast = ability_recast[254] and math.ceil(ability_recast[254]) or 0
	Aggressor.recast = ability_recast[4] and math.ceil(ability_recast[4]) or nil
	Berserk.recast = ability_recast[1] and math.ceil(ability_recast[1]) or nil
	BloodRage.recast = ability_recast[11] and math.ceil(ability_recast[11]) or nil
	Contradance.recast = ability_recast[229] and math.ceil(ability_recast[229]) or nil
	Defender.recast = ability_recast[3] and math.ceil(ability_recast[3]) or nil
	FlourishesI.recast = ability_recast[221] and math.ceil(ability_recast[221]) or nil
	FlourishesII.recast = ability_recast[222] and math.ceil(ability_recast[222]) or nil
	Hasso.recast = ability_recast[138] and math.ceil(ability_recast[138]) or nil
	HighJump.recast = ability_recast[159] and math.ceil(ability_recast[159]) or nil
	Jigs.recast = ability_recast[218] and math.ceil(ability_recast[218]) or nil
	Jump.recast = ability_recast[158] and math.ceil(ability_recast[158]) or nil
	Meditate.recast = ability_recast[134] and math.ceil(ability_recast[134]) or nil
	Restraint.recast = ability_recast[9] and math.ceil(ability_recast[9]) or nil
	Retaliation.recast = ability_recast[8] and math.ceil(ability_recast[8]) or nil
	Sambas.recast = ability_recast[216] and math.ceil(ability_recast[216]) or nil
	Seigan.recast = ability_recast[139] and math.ceil(ability_recast[139]) or nil
	Sekkanoki.recast = ability_recast[140] and math.ceil(ability_recast[140]) or nil
	Steps.recast = ability_recast[220] and math.ceil(ability_recast[220]) or nil
	SuperJump.recast = ability_recast[160] and math.ceil(ability_recast[160]) or nil
	ThirdEye.recast = ability_recast[133] and math.ceil(ability_recast[133]) or nil
	Tomahawk.recast = ability_recast[7] and math.ceil(ability_recast[7]) or nil
	Warcry.recast = ability_recast[2] and math.ceil(ability_recast[2]) or nil
	WardingCircle.recast = ability_recast[135] and math.ceil(ability_recast[135]) or nil
	WarriorsCharge.recast = ability_recast[6] and math.ceil(ability_recast[6]) or nil

end

getRecasts()

-- Format abilities/spells to fit into their allotted 12 spaces
local function formatAbils(input,input_sh)

	-- Valid abilities/spells
	local validAbilities = {
		"Mighty Strikes", "Brazen Rush", "Aggressor", "Berserk", "Blood Rage", "Contradance", "Defender", "Flourishes I", "Flourishes II", "Hasso", "High Jump", "Jigs", "Jump", "Meditate", "Restraint", "Retaliation", "Sambas", "Seigan", "Sekkanoki", "Steps", "Super Jump", "Third Eye", "Tomahawk", "Warcry", "Warding Circle", "Warrior's Charge"
	}

	local ab = {} ab['Mighty Strikes'] = MightyStrikes ab['Brazen Rush'] = BrazenRush ab['Aggressor'] = Aggressor ab['Berserk'] = Berserk ab['Blood Rage'] = BloodRage ab['Contradance'] = Contradance ab['Defender'] = Defender ab['Flourishes I'] = FlourishesI ab['Flourishes II'] = FlourishesII ab['Hasso'] = Hasso ab['High Jump'] = HighJump ab['Jigs'] = Jigs ab['Jump'] = Jump ab['Meditate'] = Meditate ab['Restraint'] = Restraint ab['Retaliation'] = Retaliation ab['Sambas'] = Sambas ab['Seigan'] = Seigan ab['Sekkanoki'] = Sekkanoki ab['Steps'] = Steps ab['Super Jump'] = SuperJump ab['Third Eye'] = ThirdEye ab['Tomahawk'] = Tomahawk ab['Warcry'] = Warcry ab['Warding Circle'] = WardingCircle ab['Warrior\'s Charge'] = WarriorsCharge

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

	local formattedMode = Mode == "Mode4" and "tank" or "dps"

	local abil01 = formatAbils(sub[formattedMode][subjob].Abil01,sub[formattedMode][subjob].Abil01_sh)
	local abil02 = formatAbils(sub[formattedMode][subjob].Abil02,sub[formattedMode][subjob].Abil02_sh)
	local abil03 = formatAbils(sub[formattedMode][subjob].Abil03,sub[formattedMode][subjob].Abil03_sh)
	local abil04 = formatAbils(sub[formattedMode][subjob].Abil04,sub[formattedMode][subjob].Abil04_sh)
	local abil05 = formatAbils(sub[formattedMode][subjob].Abil05,sub[formattedMode][subjob].Abil05_sh)
	local abil06 = formatAbils(sub[formattedMode][subjob].Abil06,sub[formattedMode][subjob].Abil06_sh)

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
	if itemMatch(21683) or itemMatch(21756) then
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

	if itemMatch(21652) or itemMatch(21783) then --stage 3 Prime
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
	elseif itemMatch(21653) or itemMatch(21784) then --stage 4 Prime
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
	elseif itemMatch(21646) or itemMatch(21785) then --stage 5 Prime
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
		
local function useHachirinNoObi(ws)
	local ws_elements = {
		["Burning Blade"] = "Fire",
		["Red Lotus Blade"] = "Fire",
		["Frostbite"] = "Ice",
		["Freezebite"] = "Ice",
		["Shining Blade"] = "Light",
		["Seraph Blade"] = "Light",
	}

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

	local element = ws_elements[ws]
	if not element then return false end

	local day = world.day_element
	local weather = world.weather_element
	local intensity = world.weather_intensity

	local bonus = 0
	local penalty = 0

	if day == element then
		bonus = bonus + 10
	end
	if weather == element then
		bonus = bonus + (intensity == 2 and 25 or 10)
	end

	local oppose = opposites[element]
	if day == oppose then
		penalty = penalty + 10
	end
	if weather == oppose then
		penalty = penalty + (intensity == 2 and 25 or 10)
	end

	return bonus > penalty
end

-------------------------------------------
--            SELF COMMANDS              --
-------------------------------------------

function self_command(command)
	if command == 'Mode' then
		if Mode == 'Mode1' then
			Mode = 'Mode2'
		elseif Mode == 'Mode2' then
			Mode = 'Mode3'
		elseif Mode == 'Mode3' then
			Mode = 'Mode4'
		elseif Mode == 'Mode4' then
			Mode = 'Mode1'
		end
		hud_mode_shdw:text('Mode: '..modeName[Mode])
		hud_mode:text('Mode: '..modeName[Mode])
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
	end
end

-------------------------------------------
--              CHOOSE SET               --
-------------------------------------------

function choose_set()
	if player.status == "Resting" and GreetingDelay == -1 then
		if LowHP then
			hud_noti_shdw:text('«« Low HP »»')
			hud_noti:text('«« Low HP »»')
			hud_noti:color(255,50,50)
		elseif buffactive['weakness'] then
			hud_noti_shdw:text('Status: Weakness')
			hud_noti:text('Status: Weakness')
			hud_noti:color(205,133,63)
		else
			hud_noti_shdw:text('Status: Resting')
			hud_noti:text('Status: Resting')
			hud_noti:color(255,255,255)
		end
	elseif player.status == "Engaged" then
		if GreetingDelay == -1 then
			if LowHP then
				hud_noti_shdw:text('«« Low HP »»')
				hud_noti:text('«« Low HP »»')
				hud_noti:color(255,50,50)
			elseif buffactive['weakness'] then
				hud_noti_shdw:text('Status: Weakness')
				hud_noti:text('Status: Weakness')
				hud_noti:color(205,133,63)
			else
				hud_noti_shdw:text('Status: Engaged')
				hud_noti:text('Status: Engaged')
				hud_noti:color(255,255,255)
			end
		end
		local base_set = twoHanded() and sets[Mode].two_handed or (dualWield() and sets[Mode].dual_wield or sets[Mode].single_wield)
		local low_hp = LowHP and sets.oh_shit or nil
		equip(set_combine(base_set, low_hp))
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
			elseif buffactive['weakness'] then
				hud_noti_shdw:text('Status: Weakness')
				hud_noti:text('Status: Weakness')
				hud_noti:color(205,133,63)
			else
				hud_noti_shdw:text('Status: Idle')
				hud_noti:text('Status: Idle')
				hud_noti:color(255,255,255)
			end
		end
		if TownZones:contains(world.area) or windower.ffxi.get_info().mog_house then
			local town_set = sets.town
			if AdoulinZones:contains(world.area) then
				town_set = sets.adoulin
			elseif BastokZones:contains(world.area) then
				town_set = sets.bastok
			elseif SandyZones:contains(world.area) then
				town_set = sets.sandoria
			elseif WindyZones:contains(world.area) then
				town_set = sets.windurst
			end
			local base_set = twoHanded() and sets[Mode].two_handed or (dualWield() and sets[Mode].dual_wield or sets[Mode].single_wield)
			equip(set_combine(base_set, sets.idle, sets.town, sets.movement_speed))
		else
			local base_set = twoHanded() and sets[Mode].two_handed or (dualWield() and sets[Mode].dual_wield or sets[Mode].single_wield)
			local low_hp = LowHP and sets.oh_shit or nil
			equip(set_combine(base_set, sets.idle, low_hp))
		end
	end
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
		local ws_set = sets[spell.english]
		local base_set = ws_set and (player.attack >= AttackCapThreshold and ws_set.high_buff or ws_set) or sets.weapon_skill
		local hachirin_no_obi = useHachirinNoObi(spell.english) and sets.hachirin_no_obi or nil
		local ygnass_resolve_1 = buffactive['Reive Mark'] and sets.ygnass_resolve_1 or nil
		local ws_accuracy = Mode == 'Mode3' and sets.ws_accuracy or nil
		equip(set_combine(base_set, hachirin_no_obi, ygnass_resolve_1, ws_accuracy))
		if player.equipment.main == "Chango" and spell.english == "Upheaval" then
			pre_AMTimer = 181
		elseif (player.equipment.main == 'Ragnarok' and spell.english == "Scourge") or (player.equipment.main == 'Bravura' and spell.english == "Metatron Torment") then
			player_tp = player.tp
			TP_Window_Open = true
			relicAMUpdate(player_tp)
		elseif (player.equipment.main == 'Farsha' and spell.english == "Cloud Splitter") or (player.equipment.main == 'Ukonvasara' and spell.english == "Ukko's Fury") then
			player_tp = player.tp
			TP_Window_Open = true
			empyreanAMUpdate(player_tp)
		elseif player.equipment.main == 'Conqueror' and spell.english == "King's Justice" then
			player_tp = player.tp
			TP_Window_Open = true
			mythicAMUpdate(player_tp)
		elseif (player.equipment.main == 'Helheim' and spell.english == "Fimbulvetr") or (player.equipment.main == 'Laphria' and spell.english == "Disaster") then
			player_tp = player.tp
			TP_Window_Open = true
			primeAMUpdate(player_tp)
		end
	elseif spell.english == 'Mighty Strikes' and MightyStrikes.recast < 2 then
		equip(sets.mighty_strikes)
	elseif spell.english == 'Provoke' and windower.ffxi.get_ability_recasts()[5] < 2 then
		equip(sets.provoke)
	elseif spell.english == 'Tomahawk' and Tomahawk.recast < 2 then
		equip(sets.tomahawk)
	elseif spell.english == 'Aggressor' and Aggressor.recast < 2 then
		equip(sets.aggressor)
	elseif spell.english == 'Berserk' and Berserk.recast < 2 then
		equip(sets.berserk)
	elseif spell.english == 'Defender' and Defender.recast < 2 then
		equip(sets.defender)
	elseif spell.english == 'Warcry' and Warcry.recast < 2 then
		equip(sets.warcry)
	elseif spell.english == 'Restraint' and Restraint.recast < 2 then
		equip(sets.restraint)
	elseif spell.english == 'Retaliation' and Retaliation.recast < 2 then
		equip(sets.retaliation)
	elseif spell.english == 'Blood Rage' and BloodRage.recast < 2 then
		equip(sets.blood_rage)
	elseif spell.english == 'Warrior\'s Charge' and WarriorsCharge.recast < 2 then
		equip(sets.warriors_charge)
	elseif spell.type == 'Step' then
		equip(sets.steps)
	elseif spell.type == 'Waltz' then
		equip(sets.waltzes)
	elseif spell.english == 'Animated Flourish' then
		equip(sets.animated_flourish)
	elseif spell.english == 'Violent Flourish' then
		equip(sets.violent_flourish)
	elseif (spell.english == 'Spectral Jig' or spell.english == 'Sneak' or spell.english == 'Monomi: Ichi' or spell.english == 'Monomi: Ni') and buffactive['Sneak'] and spell.target.type == 'SELF' then
		send_command('cancel 71')
	elseif spell.english == 'Holy Water' then
		equip(sets.holy_water)
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
	if spell.type == 'Trust' then
		equip(sets.unity)
	end
end

-------------------------------------------
--              AFTERCAST                --
-------------------------------------------

function aftercast(spell)
	if spell.english == 'Mighty Strikes' and MSTimer and not spell.interrupted then
		if player.equipment.hands == 'Agoge Mufflers' or player.equipment.hands == 'Agoge Mufflers +1' or player.equipment.hands == 'Agoge Mufflers +2' or player.equipment.hands == 'Agoge Mufflers +3' or player.equipment.hands == 'Agoge Mufflers +4' then --these pieces extend Mighty Strikes by 15 seconds so we adjust accordingly
			send_command('input /echo [Mighty Strikes] 60 seconds;wait 15;input /echo [Mighty Strikes] 45 seconds;wait 15;input /echo [Mighty Strikes] 30 seconds;wait 10;input /echo [Mighty Strikes] 20 seconds;wait 10;input /echo [Mighty Strikes] 10 seconds')
		else
			send_command('input /echo [Mighty Strikes] 45 seconds;wait 15;input /echo [Mighty Strikes] 30 seconds;wait 10;input /echo [Mighty Strikes] 20 seconds;wait 10;input /echo [Mighty Strikes] 10 seconds')
		end
	elseif spell.english == 'Brazen Rush' and BRTimer and not spell.interrupted then
		send_command('input /echo [Brazen Rush] 30 seconds;wait 10;input /echo [Brazen Rush] 20 seconds;wait 10;input /echo [Brazen Rush] 10 seconds')
	elseif spell.english == 'Hasso' and not spell.interrupted then
		Stance = 'Hasso' --Set Stance to Hasso when we use it
		StanceTimer = 300
	elseif spell.english == 'Seigan' and not spell.interrupted then
		Stance = 'Seigan' --Set Stance to Seigan when we use it
		StanceTimer = 300
	elseif (spell.english == 'Super Jump' or spell.english == 'High Jump') and not spell.interrupted and player.hp <= AutoSaveThreshold then
		AutoSaveUsed = true
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
	choose_set() --run this any time your status changes (engaged (1), idle (0), resting (33))
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
	if (buff == 270 or buff == 271 or buff == 272 or buff == 273) and AlertSounds then --Aftermath
		play_sound(Notification_Aftermath_On)
		AMTimer = pre_AMTimer
		mythicNum = pre_mythicNum
		primeNum = pre_primeNum
	elseif (buff == 2 or buff == 19) then --If we get slept,
		if buffactive['Stoneskin'] and not buffactive['charm'] then --first remove stoneskin if its up,
			send_command('cancel 37')
			equip(sets.oh_shit)
		elseif not (buffactive['Poison'] or buffactive['Dia'] or buffactive['bio'] or buffactive['Shock'] or buffactive['Rasp'] or buffactive['Choke'] or buffactive['Frost'] or buffactive['Burn'] or buffactive['Drown'] or buffactive['Requiem'] or buffactive['Kaustra'] or buffactive['Helix']) and player.hp > 100 and player.status == "Engaged" then --then as long as we're not already DOT'd, have more than 100 HP, and are engaged,
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
		if player.equipment.main == 'Ragnarok' or player.equipment.main == 'Bravura' then
			relicAMUpdate(player_tp)
		elseif player.equipment.main == 'Farsha' or player.equipment.main == 'Ukonvasara' then
			empyreanAMUpdate(player_tp)
		elseif player.equipment.main == "Conqueror" then
			mythicAMUpdate(player_tp)
		elseif player.equipment.main == 'Helheim' or player.equipment.main == 'Laphria' then
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

		--Attempt an AutoSave
		if AutoSave and player.sub_job == 'DRG' and player.hp <= AutoSaveThreshold and Alive and not (buffactive['Weakness'] or buffactive['amnesia'] or buffactive['terror'] or buffactive['petrification'] or buffactive['sleep'] or Stance == 'Seigan') and player.status == "Engaged" and not (TownZones:contains(world.area) or windower.ffxi.get_info().mog_house) and not AutoSaveUsed then
			if player.sub_job_level >= 35 and windower.ffxi.get_ability_recasts()[159] == 0 then
				send_command('input /ja "High Jump" <t>')
			end
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

		--Movement Speed set equipping
		local get_player = windower.ffxi.get_mob_by_target('me')
		local new_player_x = get_player and get_player.x or new_player_x
		local new_player_y = get_player and get_player.y or new_player_y
		if (player_x ~= new_player_x or player_y ~= new_player_y) and get_player and get_player.status ~= 1 then
			player_x = new_player_x
			player_y = new_player_y
			moving = true
			equip(sets.movement_speed)
		elseif moving then
			moving = false
			choose_set()
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
			if player.equipment.main == 'Helheim' or player.equipment.main == 'Laphria' then
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
			elseif player.equipment.main == 'Ragnarok' or player.equipment.main == 'Bravura' then
				if buffactive['Aftermath'] then
					if currentAfterMath ~= 'RelicAM' or currentAMTimer ~= AMTimer then
						currentAfterMath = 'RelicAM'
						currentAMTimer = AMTimer
						local am_time = formatAMTime(currentAMTimer)
						if player.equipment.main == 'Ragnarok' then
							hud_weapons_shdw:text(formatWeapons('AM: (Acc. +15/Crit Rate +10%) '..am_time))
							hud_weapons:text(formatWeapons('AM: (Acc. +15/Crit Rate +10%) '..am_time))
						elseif player.equipment.main == 'Bravura' then
							hud_weapons_shdw:text(formatWeapons('AM: (DT -20%/Regen +15) '..am_time))
							hud_weapons:text(formatWeapons('AM: (DT -20%/Regen +15) '..am_time))
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
			elseif player.equipment.main == 'Farsha' or player.equipment.main == 'Ukonvasara' then
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
			elseif player.equipment.main == 'Conqueror' then
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
			elseif player.equipment.main == 'Chango' then
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
			if player.hp > AutoSaveThreshold and AutoSaveUsed then --when HP goes back above a certain amountafter we use a "save", turn off the AutoSave flag so we can use another "save"
				AutoSaveUsed = false
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
			if player.equipment.sub == 'empty' or twoHanded() then
				EquipSub = ''
			else
				EquipSub = ' & '..player.equipment.sub
			end
		end

		--Recast color updates
		if MightyStrikes.recast then
			if buffactive['Mighty Strikes'] then
				textColor('Mighty Strikes','active')
				MightyStrikes.flashed = false
			elseif MightyStrikes.recast > 0 then
				textColor('Mighty Strikes','cooldown')
				MightyStrikes.flashed = false
			else
				textColor('Mighty Strikes','ready')
				if not MightyStrikes.flashed then
					flash('Mighty Strikes')
				end
				MightyStrikes.flashed = true
			end
		else
			textColor('Mighty Strikes','notfound')
		end

		if BrazenRush.recast then
			if buffactive['Brazen Rush'] then
				textColor('Brazen Rush','active')
				BrazenRush.flashed = false
			elseif BrazenRush.recast > 0 then
				textColor('Brazen Rush','cooldown')
				BrazenRush.flashed = false
			else
				textColor('Brazen Rush','ready')
				if not BrazenRush.flashed then
					flash('Brazen Rush')
				end
				BrazenRush.flashed = true
			end
		else
			textColor('Brazen Rush','notfound')
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

		if BloodRage.recast then
			if buffactive['Blood Rage'] then
				textColor('Blood Rage','active')
				BloodRage.flashed = false
			elseif BloodRage.recast > 0 then
				textColor('Blood Rage','cooldown')
				BloodRage.flashed = false
			else
				textColor('Blood Rage','ready')
				if not BloodRage.flashed then
					flash('Blood Rage')
				end
				BloodRage.flashed = true
			end
		else
			textColor('Blood Rage','notfound')
		end

		if Contradance.recast then
			if buffactive['Contradance'] then
				textColor('Contradance','active')
				Contradance.flashed = false
			elseif Contradance.recast > 0 then
				textColor('Contradance','cooldown')
				Contradance.flashed = false
			else
				textColor('Contradance','ready')
				if not Contradance.flashed then
					flash('Contradance')
				end
				Contradance.flashed = true
			end
		else
			textColor('Contradance','notfound')
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

		if FlourishesI.recast then
			if FlourishesI.recast > 0 then
				textColor('Flourishes I','cooldown')
				FlourishesI.flashed = false
			else
				textColor('Flourishes I','ready')
				if not FlourishesI.flashed then
					flash('Flourishes I')
				end
				FlourishesI.flashed = true
			end
		else
			textColor('Flourishes I','notfound')
		end

		if FlourishesII.recast then
			if FlourishesII.recast > 0 then
				textColor('Flourishes II','cooldown')
				FlourishesII.flashed = false
			else
				textColor('Flourishes II','ready')
				if not FlourishesII.flashed then
					flash('Flourishes II')
				end
				FlourishesII.flashed = true
			end
		else
			textColor('Flourishes II','notfound')
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

		if HighJump.recast then
			if HighJump.recast > 0 then
				textColor('High Jump','cooldown')
				HighJump.flashed = false
			else
				textColor('High Jump','ready')
				if not HighJump.flashed then
					flash('High Jump')
				end
				HighJump.flashed = true
			end
		else
			textColor('High Jump','notfound')
		end

		if Jigs.recast then
			if Jigs.recast > 0 then
				textColor('Jigs','cooldown')
				Jigs.flashed = false
			else
				textColor('Jigs','ready')
				if not Jigs.flashed then
					flash('Jigs')
				end
				Jigs.flashed = true
			end
		else
			textColor('Jigs','notfound')
		end

		if Jump.recast then
			if Jump.recast > 0 then
				textColor('Jump','cooldown')
				Jump.flashed = false
			else
				textColor('Jump','ready')
				if not Jump.flashed then
					flash('Jump')
				end
				Jump.flashed = true
			end
		else
			textColor('Jump','notfound')
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

		if Restraint.recast then
			if buffactive['Restraint'] then
				textColor('Restraint','active')
				Restraint.flashed = false
			elseif Restraint.recast > 0 then
				textColor('Restraint','cooldown')
				Restraint.flashed = false
			else
				textColor('Restraint','ready')
				if not Restraint.flashed then
					flash('Restraint')
				end
				Restraint.flashed = true
			end
		else
			textColor('Restraint','notfound')
		end

		if Retaliation.recast then
			if buffactive['Retaliation'] then
				textColor('Retaliation','active')
				Retaliation.flashed = false
			elseif Retaliation.recast > 0 then
				textColor('Retaliation','cooldown')
				Retaliation.flashed = false
			else
				textColor('Retaliation','ready')
				if not Retaliation.flashed then
					flash('Retaliation')
				end
				Retaliation.flashed = true
			end
		else
			textColor('Retaliation','notfound')
		end

		if Sambas.recast then
			if buffactive['Haste Samba'] then
				textColor('Sambas','active')
				Sambas.flashed = false
			elseif Sambas.recast > 0 then
				textColor('Sambas','cooldown')
				Sambas.flashed = false
			else
				textColor('Sambas','ready')
				if not Sambas.flashed then
					flash('Sambas')
				end
				Sambas.flashed = true
			end
		else
			textColor('Sambas','notfound')
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

		if Steps.recast then
			if Steps.recast > 0 then
				textColor('Steps','cooldown')
				Steps.flashed = false
			else
				textColor('Steps','ready')
				if not Steps.flashed then
					flash('Steps')
				end
				Steps.flashed = true
			end
		else
			textColor('Steps','notfound')
		end

		if SuperJump.recast then
			if SuperJump.recast > 0 then
				textColor('Super Jump','cooldown')
				SuperJump.flashed = false
			else
				textColor('Super Jump','ready')
				if not SuperJump.flashed then
					flash('Super Jump')
				end
				SuperJump.flashed = true
			end
		else
			textColor('Super Jump','notfound')
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

		if Tomahawk.recast then
			if Tomahawk.recast > 0 then
				textColor('Tomahawk','cooldown')
				Tomahawk.flashed = false
			else
				textColor('Tomahawk','ready')
				if not Tomahawk.flashed then
					flash('Tomahawk')
				end
				Tomahawk.flashed = true
			end
		else
			textColor('Tomahawk','notfound')
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

		if WarriorsCharge.recast then
			if buffactive['Warrior\'s Charge'] then
				textColor('Warrior\'s Charge','active')
				WarriorsCharge.flashed = false
			elseif WarriorsCharge.recast > 0 then
				textColor('Warrior\'s Charge','cooldown')
				WarriorsCharge.flashed = false
			else
				textColor('Warrior\'s Charge','ready')
				if not WarriorsCharge.flashed then
					flash('Warrior\'s Charge')
				end
				WarriorsCharge.flashed = true
			end
		else
			textColor('Warrior\'s Charge','notfound')
		end

	end

	--1 second heartbeat
	if current_time - last_second >= 1 then

		last_second = current_time

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
	if newSubjob == 'DRG' then
		subjob = 'DRG'
		if SubDRGPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubDRGPage)
		end
	elseif newSubjob == 'DNC' then
		subjob = 'DNC'
		if SubDNCPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubDNCPage)
		end
	elseif newSubjob == 'SAM' then
		subjob = 'SAM'
		if SubSAMPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubSAMPage)
		end
	elseif newSubjob == 'NIN' then
		subjob = 'NIN'
		if SubNINPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubNINPage)
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

	--Weapon Skills and Skillchains:
	if notifications.Damage and act.category == 3 and act.actor_id == player.id then
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
