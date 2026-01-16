-----------------------------------------
-- Keys Gearswap lua file for Corsair  --
-----------------------------------------
--[[

Updates to this file and other GearSwap files and addons can be found at
https://github.com/iLVL-Key/FFXI

Place both this file and the sounds folder inside the GearSwap data folder
	/addons/GearSwap/data/sounds/
	/addons/GearSwap/data/COR.lua

--------------------

To toggle using the Luzaf's Ring, use any of these three options:
1. A macro
	/console luzaf
2. An alias command
	//luzaf
3. A keybind shortcut
	ALT+G
	(Can be changed in the Advanced Options section)

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

To activate Damage Taken Override, use any of these three options:
1. A macro
	/console DT
2. An alias command
	//dt
3. A keybind shortcut
	CTRL+D
	(Can be changed in the Advanced Options section)

--------------------

To activate the Ranged Cycle, use any of these three options:
1. A macro
	/console RC
2. An alias command
	//rc
3. A keybind shortcut
	ALT+H
	(Can be changed in the Advanced Options section)

--------------------

To activate the Weapon Cycle, use any of these three options:
1. A macro
	/console WC
2. An alias command
	//wc
3. A keybind shortcut
	CTRL+H
	(Can be changed in the Advanced Options section)

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

--]]

-------------------------------------------
--                OPTIONS                --
-------------------------------------------

Book			=	'10'	--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
SubDNCPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing DNC.
SubDRGPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing DRG.
SubDRKPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing DRG.
SubNINPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing NIN.
SubRNGPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing RNG.
SubWARPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing WAR.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions
							--				(Town limits this to town gear only).
AlertSounds		=	true	--[true/false]	Plays a sound on alerts. 
UseEcho			=	'R'		--[E/R/Off]		Automatically uses an (E)cho Drop or (R)emedy instead of spell when you are silenced.
AutoDoubleUp	=	true	--[true/false]	Automatically converts a repeat of the SAME Phantom Roll into a Double-Up.
AutoSave		=	true	--[true/false]	Attempts to use High Jump when your HP gets critically low.

-- Heads Up Display --
HUDposX				=	100	--	X position for the HUD. 0 is left of the window, increasing this number will move it to the right.
HUDposY				=	100		--	Y position for the HUD. 0 is top of the window, increasing this number will move it downward.
FontSize			=	10.5	--	Adjust the font size. Changing this may require you to adjust the Spacers below as well.
LineSpacer			=	17		--	Space in pixels between each Line of the HUD.
ColumnSpacer		=	95		--	Space in pixels between each Column of the HUD.
ShowTPMeter			=	true	--[true/false]	Show the mini TP Meter inside the Weapons area of the HUD.

modeName = {
--HUD Mode Names
	Mode1 = 'Multi-Att',	--Standard set.
	Mode2 = 'M-Att W/ DT',	--Standard set.
	Mode3 = 'High Acc',		--Special set. NOTE: WSs will use the Weapon Skill - Accuracy set.
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
	LowMP			=	true,	--[true/false]	Displays a notification when MP is under 20% when you have a subjob that uses MP.
	NoAmmo			=	true,	--[true/false]	Displays a notification when you attempt to shoot but are out of ammo.
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
ShowRollOdds		=	true	--[true/false]  Show your current roll odds in the HUD instead of a basic roll meter.
StartMode			=	'Mode1'	--[Mode1/Mode2/Mode3]
									--	Determines the Mode you will start in. Current Mode can be changed at any time by using any
									--	of the three options listed above in the Notes section (a macro, alias, or keyboard shortcut).
LuzafsRing			=	true	--[true/false]
									--	Determines if Luzaf's Ring will be used when performing rolls. Can be toggled at any time by using
									--	any of the three options listed above in the Notes section (a macro, alias, or keyboard shortcut).
DTBind				=	'^d'	--Sets the keyboard shortcut you would like to activate the Damage Taken Override. CTRL+D (^d) is default.
LuzafBind			=	'!g'	--Sets the keyboard shortcut you would like to toggle using the Luzaf's Ring. ALT+G (!g) is default.
ModeBind			=	'^g'	--Sets the keyboard shortcut you would like to cycle between Modes. CTRL+G (^g) is default.
RCBind				=	'!h'	--Sets the keyboard shortcut you would like to activate the Ranged Cycle. ALT+H (!h) is default.
WCBind				=	'^h'	--Sets the keyboard shortcut you would like to activate the Weapon Cycle. CTRL+H (^h) is default.
								--    ^ = CTRL    ! = ALT    @ = WIN    # = APPS    ~ = SHIFT
KeepTPThreshold		=	500		--Main/Sub slots in the Phantom Roll set will not equip when TP is above this number (set to 3000 to always switch).
LowHPThreshold		=	1000	--Below this number is considered Low HP.
AutoSaveThreshold	=	1000	--If your HP goes below this number, a "save" will be used.
AttackCapThreshold	=	4000	--Using a WS while your attack is above this number will use a high_buff WS set if available.
								--NOTE: This number is checked before WS gear is switched, base this on attack while in your TP set(s).
DangerRepeat		=	5		--Maximum number of times the Danger Sound will repeat, once per second.
RRReminderTimer		=	1800	--Delay in seconds between checks to see if Reraise is up (300 is 5 minutes).
NotiDelay			=	6		--Delay in seconds before certain notifications will automatically clear.
PollingRate			=	5		--Times per second to check for various conditions (debuffs, ammo, etc). Higher rates use more CPU.
AddCommas			=	true	--[true/false]  Adds commas to damage numbers.
LowAmmoNum			=	25		--Amount for ammo to be considered "Low Ammo" for HUD color changes.

-------------------------------------------
--              HUD RECAST               --
-------------------------------------------

-- Controls what is displayed in the HUD Recast section.
-- The first column tells the file which ability/spell to place in that slot, the following are valid for use:
--		Wild Card, Cutting Cards, Aggressor, Arcane Circle, Berserk, Consume Mana, Contradance, Crooked Cards, Defender, Flourishes I, Flourishes II, Fold, High Jump, Jigs, Jump, Last Resort, Phantom Roll, Quick Draw, Random Deal, Sambas, Snake Eye, Souleater, Steps, Super Jump, Triple Shot, Warcry
-- The "_sh" column allows you to change the name displayed if you would like, leave blank otherwise.
-- NOTE: Names will automatically be truncated to 10 characters to fit correctly.

sub = {
	--COR/DNC
	DNC = {
		Abil01 = "Phantom Roll",	Abil01_sh = "Phntm Roll",
		Abil02 = "Snake Eye",		Abil02_sh = "",
		Abil03 = "Crooked Cards",	Abil03_sh = "Crooked",
		Abil04 = "Random Deal",		Abil04_sh = "Random",
		Abil05 = "Triple Shot",		Abil05_sh = "Tr. Shot",
		Abil06 = "Quick Draw",		Abil06_sh = "Qck Draw"
	},
	--COR/DRG
	DRG = {
		Abil01 = "Phantom Roll",	Abil01_sh = "Phntm Roll",
		Abil02 = "Snake Eye",		Abil02_sh = "",
		Abil03 = "Crooked Cards",	Abil03_sh = "Crooked",
		Abil04 = "Random Deal",		Abil04_sh = "Random",
		Abil05 = "Triple Shot",		Abil05_sh = "Tr. Shot",
		Abil06 = "Quick Draw",		Abil06_sh = "Qck Draw"
	},
	--COR/DRK
	DRK = {
		Abil01 = "Phantom Roll",	Abil01_sh = "Phntm Roll",
		Abil02 = "Snake Eye",		Abil02_sh = "",
		Abil03 = "Crooked Cards",	Abil03_sh = "Crooked",
		Abil04 = "Random Deal",		Abil04_sh = "Random",
		Abil05 = "Triple Shot",		Abil05_sh = "Tr. Shot",
		Abil06 = "Quick Draw",		Abil06_sh = "Qck Draw"
	},
	--COR/NIN
	NIN = {
		Abil01 = "Phantom Roll",	Abil01_sh = "Phntm Roll",
		Abil02 = "Snake Eye",		Abil02_sh = "",
		Abil03 = "Crooked Cards",	Abil03_sh = "Crooked",
		Abil04 = "Random Deal",		Abil04_sh = "Random",
		Abil05 = "Triple Shot",		Abil05_sh = "Tr. Shot",
		Abil06 = "Quick Draw",		Abil06_sh = "Qck Draw"
	},
	--COR/RNG
	RNG = {
		Abil01 = "Phantom Roll",	Abil01_sh = "Phntm Roll",
		Abil02 = "Snake Eye",		Abil02_sh = "",
		Abil03 = "Crooked Cards",	Abil03_sh = "Crooked",
		Abil04 = "Random Deal",		Abil04_sh = "Random",
		Abil05 = "Triple Shot",		Abil05_sh = "Tr. Shot",
		Abil06 = "Quick Draw",		Abil06_sh = "Qck Draw"
	},
	--COR/WAR
	WAR = {
		Abil01 = "Phantom Roll",	Abil01_sh = "Phntm Roll",
		Abil02 = "Snake Eye",		Abil02_sh = "",
		Abil03 = "Crooked Cards",	Abil03_sh = "Crooked",
		Abil04 = "Random Deal",		Abil04_sh = "Random",
		Abil05 = "Triple Shot",		Abil05_sh = "Tr. Shot",
		Abil06 = "Quick Draw",		Abil06_sh = "Qck Draw"
	},
	--COR/other
	OTH = {
		Abil01 = "Phantom Roll",	Abil01_sh = "Phntm Roll",
		Abil02 = "Snake Eye",		Abil02_sh = "",
		Abil03 = "Crooked Cards",	Abil03_sh = "Crooked",
		Abil04 = "Random Deal",		Abil04_sh = "Random",
		Abil05 = "Triple Shot",		Abil05_sh = "Tr. Shot",
		Abil06 = "Quick Draw",		Abil06_sh = "Qck Draw"
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

	-- ROLLS INFO --
	roll = {
		no_roll	= {r = 175, g = 175, b = 175},	-- No Roll
		current	= {r = 30, g = 144, b = 255},	-- Current Total
		lucky	= {r = 50, g = 255, b = 50},	-- Lucky Number
		unlucky	= {r = 255, g = 165, b = 0},	-- Unlucky Number
		eleven	= {r = 255, g = 255, b = 50},	-- Total of 11
		bust	= {r = 255, g = 50, b = 50}		-- Bust
	},

	-- AMMO INFO --
	ammo = {
		good	= {r = 250, g = 250, b = 250},	-- Sufficient Ammo
		low		= {r = 255, g = 165, b = 0},	-- Low Ammo
		empty	= {r = 255, g = 50, b = 50},	-- No Ammo
	},
}

-------------------------------------------
--            RARE EX BULLETS            --
-------------------------------------------

-- These are rare/ex that you never want to shoot with a normal ranged attack.
-- These will be checked before every ranged attack and Weapon Skill to make sure they are not fired.
-- NOTE: Define bullets used in specific sets in the Gear Sets section below.

rare_ex_bullets = {
	["Animikii Bullet"] = true,
	["Hauksbok Bullet"] = true,
}

-------------------------------------------
--                WEAPONS                --
-------------------------------------------

-- These are the Main/Sub combos that the Weapon Cycle goes through. Add more pairs on new lines as needed
-- NOTE: if a slot should specifically be empty, use `empty` with no quotation marks. ie: sub=empty
WeaponCycle = {
	{
		main="Naegling",
		sub="Nusku Shield"
	},
	{
		main="Tauret",
		sub="Nusku Shield"
	},
	{
		main={ name="Rostam", augments={'Path: A',}},
		sub="Gleti's Knife"
	},
}

-- These are the Main/Sub combos that the Weapon Cycle goes through. Add more pairs on new lines as needed
-- NOTE: if a slot should specifically be empty, use `empty` with no quotation marks. ie: sub=empty
DualWieldCycle = {
	{
		main="Naegling",
		sub="Gleti's Knife"
	},
	{
		main="Naegling",
		sub="Tauret"
	},
	{
		main={ name="Rostam", augments={'Path: C',}},
		sub="Gleti's Knife"
	},
}

-- These are the Main/Sub combos that get added to the Weapon Cycle while in Abyssea for Procs. Add more pairs on new lines as needed
-- NOTE: if a slot should specifically be empty, use `empty` with no quotation marks. ie: sub=empty
AbysseaProcCycle = {
	{
		main="Qutrib Knife",
		sub="Nusku Shield"
	},
}

-- These are the Range weapons that the Range Cycle goes through. Add more on new lines as needed
RangedCycle = {
	"Death Penalty",
	"Fomalhaut",
	"Armageddon",
	"Anarchy +2",
}

-------------------------------------------
--               GEAR SETS               --
-------------------------------------------

function get_sets()

-- Idle (Movement Speed, Refresh, Regen, Damage Taken-, Enmity-)
-- NOTE: Do not use weapons in this set or it will override your Weapon Cycle choice every time you disengage.
sets.idle = {
	head="Nyame Helm",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Comm. Charm +2",
	-- neck="Null Loop",
	waist="Null Belt",
	left_ear="Alabaster Earring",
	right_ear="Eabani Earring",
	left_ring="Shadow Ring",
	right_ring="Defending Ring",
}

-- Movement Speed
-- Automatically equips while in town, and while moving outside of town.
-- NOTE: To disable, leave this set empty and instead include your movement speed gear in the Idle set above.
sets.movement_speed = {
	legs="Carmine Cuisses +1",
}

-- DT Override (Damage Taken-, Magic Evasion)
-- Will override all other gear sets but still inherit unused slots from them
sets.dt_override = {

}

-- Oh Shit
-- Full DT- and everything you've got with Absorbs or Annuls Damage
sets.oh_shit = {
	head="Nyame Helm",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Warder's Charm +1",
	waist="Null Belt",
	left_ear="Eabani Earring",
	left_ring="Shadow Ring",
	right_ring="Defending Ring",
	back="Shadow Mantle"
}

-- Rest
sets.rest = {

}

-- Mode 1 (Multi-Attack) (Example: A focus on Multi-Attack and Store TP, then filling in the rest with DEX, Accuracy, and Attack)
-- NOTE: Think "Glass Cannon", lower-end content, pure stats, don't care about DT
sets.Mode1 = {
	head="Malignance Chapeau",
	body="Malignance Tabard",
	hands="Adhemar Wrist. +1",
	legs="Chas. Culottes +3",
	feet="Nyame Sollerets",
	neck="Null Loop",
	waist="Sailfi Belt +1",
	left_ear="Cessance Earring",
	right_ear="Brutal Earring",
	left_ring="Hetairoi Ring",
	right_ring="Epona's Ring",
	back="Null Shawl",
	back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
}

-- Mode 1 Dual Wield (Dual Wield, Accuracy, Multi Attack, DEX, Store TP, Attack)
-- Combines with Mode 1 set, only necessary to set the slots with specific desired stats
sets.Mode1.dual_wield = set_combine(sets.Mode1, {
	waist="Reiki Yotai",
	left_ear="Eabani Earring",
	right_ear="Suppanomimi",
})

-- Mode 2 (Multi-Attack W/ DT) (Example: A focus on Multi-Attack and Store TP, with enough DT to survive higher end content)
sets.Mode2 = set_combine(sets.Mode1, {
	head="Nyame Helm",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	-- neck="Null Loop",
	neck="Comm. Charm +2",
	waist="Sailfi Belt +1",
	left_ear="Cessance Earring",
	right_ear="Brutal Earring",
	left_ring="Hetairoi Ring",
	right_ring="Epona's Ring",
	back="Null Shawl",
})

-- Mode 2 Dual Wield (Dual Wield, Accuracy, Multi Attack, DEX, Store TP, Attack)
-- Combines with Mode 2 set, only necessary to set the slots with specific desired stats
sets.Mode2.dual_wield = set_combine(sets.Mode2, {
	waist="Reiki Yotai",
	left_ear="Eabani Earring",
	right_ear="Suppanomimi",
})

-- Mode 3 (Accuracy) (Example: A focus on DEX and Accuracy, then filling in the rest with a mix of Multi-Attack, Store TP, and Attack)
-- NOTE: This is a special mode for accuracy. When in this mode, weapon skills will default to the Accuracy Weapon Skill set.
sets.Mode3 = set_combine(sets.Mode1, {

})

-- Mode 3 Dual Wield (Dual Wield, Accuracy, Multi Attack, DEX, Store TP, Attack)
-- Combines with Mode 3 set, only necessary to set the slots with specific desired stats
sets.Mode3.dual_wield = set_combine(sets.Mode3, {
	waist="Reiki Yotai",
	left_ear="Eabani Earring",
	right_ear="Suppanomimi",
})

-- Weapon Skill - Basic (STR, Weapon Skill Damage, Attack, Multi Attack)
sets.weapon_skill = {
	ammo="Chrono Bullet",
	head="Nyame Helm",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Rep. Plat. Medal",
	waist="Sailfi Belt +1",
	left_ear="Moonshade Earring",
	right_ear="Ishvara Earring",
	left_ring="Karieyh Ring +1",
	right_ring="Cornelia's Ring",
	back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}

-- Weapon Skill - Accuracy (WS Accuracy, Accuracy)
-- NOTE: This is a special set for weapon skill accuracy. When in the Accuracy mode (mode 3), weapon skills will layer this set on top of the appropriate weapon skill set.
sets.ws_accuracy = {
	head="Chass. Tricorne +3",
	body="Chasseur's Frac +3",
	hands="Chasseur's Gants +3",
	legs="Chas. Culottes +3",
	feet="Chass. Bottes +3",
	neck="Fotia Gorget",
	waist="Fotia Belt",
	left_ring="Karieyh Ring +1",
	right_ring="Cornelia's Ring",
}

-- Terminus (70% DEX, 70% AGI)
sets["Terminus"] = set_combine(sets.weapon_skill, {

})

-- Terminus - High Buff (70% DEX, 70% AGI)
sets["Terminus"].high_buff = set_combine(sets["Terminus"], {

})

-- Last Stand (73~85% AGI)
sets["Last Stand"] = set_combine(sets.weapon_skill, {
	hands="Chasseur's Gants +3",
	neck="Fotia Gorget",
	waist="Fotia Belt",
	left_ring="Dingir Ring",
	back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},

})

-- Last Stand - High Buff (73~85% AGI)
sets["Last Stand"].high_buff = set_combine(sets["Last Stand"], {
	left_ring="Sroda Ring",
	right_ring="Epaminondas's Ring",
})

-- Hot Shot (70% AGI)
sets["Hot Shot"] = set_combine(sets.weapon_skill, {
	ammo="Living Bullet",
	neck="Fotia Gorget",
	waist="Fotia Belt",
	right_ear="Friomisi Earring",
	right_ring="Epaminondas's Ring",
	back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
})

-- Hot Shot - High Buff (70% AGI)
sets["Hot Shot"].high_buff = set_combine(sets["Hot Shot"], {
	left_ring="Sroda Ring",
	right_ring="Epaminondas's Ring",
})

-- Leaden Salute (100% AGI)
sets["Leaden Salute"] = set_combine(sets.weapon_skill, {
	ammo="Living Bullet",
	head="Pixie Hairpin +1",
	body="Lanun Frac +4",
	neck="Comm. Charm +2",
	waist="Skrymir Cord +1",
	left_ring="Dingir Ring",
	back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
})

-- Wildfire (60% AGI)
sets["Wildfire"] = set_combine(sets.weapon_skill, {
	ammo="Living Bullet",
	body="Lanun Frac +4",
	neck="Comm. Charm +2",
	waist="Skrymir Cord +1",
	right_ear="Friomisi Earring",
	left_ring="Dingir Ring",
	back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
})

-- Savage Blade (50% STR, 50% MND mod)
sets["Savage Blade"] = set_combine(sets.weapon_skill, {
	left_ring="Regal Ring",
	right_ring="Epaminondas's Ring",
})

-- Savage Blade - High Buff (50% STR, 50% MND mod)
sets["Savage Blade"].high_buff = set_combine(sets["Savage Blade"], {

})

-- Evisceration (combines with Weapon Skill set above)
sets["Evisceration"] = set_combine(sets.weapon_skill, {
	neck="Fotia Gorget",
	waist="Fotia Belt",
	left_ear="Odr Earring",
	right_ear="Mache Earring +1",
	left_ring="Regal Ring",
	right_ring="Epona's Ring",
})

-- Aeolian Edge (combines with Weapon Skill set above)
sets["Aeolian Edge"] = set_combine(sets.weapon_skill, {
	body="Lanun Frac +4",
	neck="Baetyl Pendant",
	waist="Orpheus's Sash",
	right_ear="Friomisi Earring",
	left_ring="Dingir Ring",
	right_ring="Epaminondas's Ring",
})

-- Exenterator (combines with Weapon Skill set above)
sets["Exenterator"] = set_combine(sets.weapon_skill, {
	neck="Null Loop",
	waist="Null Belt",
	left_ring="Karieyh Ring +1",
	right_ring="Cornelia's Ring",
	back="Null Shawl",
})

-- Hachirin-no-obi
sets.hachirin_no_obi = {
	--waist="Hachirin-no-obi",
}

-- Snapshot (No Flurry buff active)
-- NOTE: Snapshot cap is 70%. COR Job Gifts give 10%
sets.snapshot = {
	head="Chass. Tricorne +3",
	body="Oshosi Vest +1",
	hands="Carmine Fin. Ga. +1",
	legs="Chas. Culottes +3",
	feet="Meg. Jam. +2",
	neck="Comm. Charm +2",
	waist="Yemaya Belt",
	left_ring="Crepuscular Ring",
	back={ name="Camulus's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Snapshot"+10','Phys. dmg. taken-10%',}},
}

-- Rapid Shot (Flurry buff active)
sets.rapid_shot = set_combine(sets.snapshot, {

})

-- Ranged Attack Bullet
-- NOTE: This bullet gets equipped in precast for /ra as well as aftercast for every action.
sets.ranged_attack_bullet = {
	ammo="Chrono Bullet",
}

-- Ranged Attack Accuracy Bullet
-- NOTE: This bullet gets equipped in precast for /ra as well as aftercast for every action when in Mode 3 (Accuracy).
sets.ranged_accuracy_bullet = set_combine(sets.ranged_attack_bullet, {
	-- ammo="Devastating Bullet",
})

-- Ranged Attack (AGI, STR, Ranged Accuracy, Ranged Attack)
-- NOTE: Triple Shot + gear DOES NOT have any affect unless Triple Shot ability is active
-- NOTE: Set the bullet in the set below (the bullet is equipped separately in the precast phase so Rare/EX bullets can be checked for)
sets.ranged_attack = {
	head="Malignance Chapeau", --Ikenga
	body="Malignance Tabard", --Ikenga
	hands="Chasseur's Gants +3", --Ikenga
	legs="Chas. Culottes +3",
	feet="Meg. Jam. +2", --Ikenga
	neck="Null Loop", --Iskur Gorget
	waist="Yemaya Belt",
	left_ear="Crep. Earring",
	right_ear="Telos Earring",
	left_ring="Crepuscular Ring",
	right_ring="Ilabrat Ring",
	back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Phys. dmg. taken-10%',}},
}

-- Ranged Attack Accuracy (Ranged Accuracy, AGI, STR)
-- NOTE: Set the bullet in the set below (the bullet is equipped separately in the precast phase so Rare/EX bullets can be checked for)
sets.ranged_accuracy = set_combine(sets.ranged_attack, {
	head="Chass. Tricorne +3",
	body="Chasseur's Frac +3",
	hands="Chasseur's Gants +3",
	legs="Chas. Culottes +3",
	feet="Chass. Bottes +3",
	neck="Null Loop",
	waist="Null Belt",
})

-- Ranged Attack W/ Triple Shot Active (Triple Shot+ gear)
sets.triple_shot = {
	head="Oshosi Mask +1",
	body="Chasseur's Frac +3",
	hands="Lanun Gants +4",
}

-- Ranged Attack W/ Armageddon Aftermath Active (Critical Hit, Critical Damage, Dead Aim)
sets.armageddon_am = set_combine(sets.ranged_attack, {
	head="Meghanada Visor +2",
	body="Meg. Jam. +2",
	legs="Darraigner's Braise",
	waist="K. Kachina Belt +1",
	left_ear="Odr Earring",
	right_ear="Chas. Earring +2",
	left_ring="Dingir Ring",
	back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Crit.hit rate+10','Phys. dmg. taken-10%',}}, --add R.Acc next month from Dye
})

-- Fast Cast (cap is 80%)
sets.fast_cast = {
	head="Carmine Mask +1",
	hands="Leyline Gloves",
	feet="Carmine Greaves +1",
	neck="Baetyl Pendant",
	left_ear="Etiolation Earring",
	right_ear="Loquac. Earring",
	left_ring="Kishar Ring",
	right_ring="Prolix Ring",
}

-- Magic (Magic Accuracy, haste)
-- NOTE: This is mostly for the occasional /DRK and you need Absorb-TP to land
sets.magic = {
	ammo="Living Bullet",
	head="Chass. Tricorne +3",
	body="Chasseur's Frac +3",
	hands="Chasseur's Gants +3",
	legs="Chas. Culottes +3",
	feet="Chass. Bottes +3",
	neck="Null Loop",
	waist="Null Belt",
	left_ear="Crep. Earring",
	right_ear={ name="Chas. Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+16','Mag. Acc.+16','Crit.hit rate+6','STR+7 AGI+7',}},
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back="Null Shawl",
}

-- Wild Card (Enhances Wild Card gear)
sets.wild_card = {
	feet="Lanun Bottes +2"
}

-- Phantom Roll (Phantom Roll+, Phantom Roll duration)
-- NOTE: Only the highest individual PR+ effect will be taken into account, PR+ gear DOES NOT stack
-- NOTE: Main and Sub slots (ie Rostam) will only equip if your TP is under the number set as the KeepTPThreshold in the Advanced Options section.
sets.phantom_roll = {
	main="Rostam",
	head="Lanun Tricorne +4",
	body="Chasseur's Frac +3",
	hands="Chasseur's Gants +3",
	legs="Desultor Tassets",
	feet="Nyame Sollerets",
	neck="Regal Necklace",
	waist="Null Belt",
	left_ear="Alabaster Earring",
	right_ear="Chas. Earring +2",
	right_ring="Defending Ring",
	back={ name="Camulus's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Snapshot"+10','Phys. dmg. taken-10%',}},
}

-- Double-Up (Enmity-)
-- NOTE: Do not need any Phantom Roll+ gear for Double-Up, it only applies during the initial roll
sets.double_up = {

}

-- Luzaf's Ring (only used when toggled on)
sets.luzafs_ring = {
	left_ring="Luzaf's Ring",
}

-- Quick Draw (Quick Draw+, AGI, Magic Accuracy, Store TP)
-- NOTE: Ranged Accuracy and Marksmanship skill DOES NOT affect QD accuracy.
-- NOTE: There is an overall cap of -25 seconds which includes merits (-2~10s) and Job Point gifts (-10s @550JP).
sets.quick_draw = {
	ammo="Living Bullet",
	head="Laksa. Tricorne +4",
	body="Malignance Tabard",
	hands="Carmine Fin. Ga. +1",
	legs="Malignance Tights",
	feet="Chass. Bottes +3",
	neck="Comm. Charm +2",
	waist="Skrymir Cord +1",
	left_ear="Friomisi Earring",
	right_ear="Chas. Earring +2",
	left_ring="Crepuscular Ring",
	right_ring="Ilabrat Ring",
	back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Phys. dmg. taken-10%',}},
}

-- Light/Dark Shot (Full Magic Accuracy)
sets.light_dark_shot = set_combine(sets.quick_draw, {
	ammo="Living Bullet",
	head="Chass. Tricorne +3",
	body="Chasseur's Frac +3",
	legs="Chas. Culottes +3",
	neck="Null Loop",
	waist="Null Belt",
	left_ear="Crep. Earring",
	right_ear="Chas. Earring +2",
	left_ring="Crepuscular Ring",
	right_ring="Stikini Ring +1",
})

-- Random Deal (Enhances Random Deal gear)
sets.random_deal = {
	body="Lanun Frac +4",
}

-- Snake Eye (Enhances Snake Eye gear)
sets.snake_eye = {
	legs="Lanun Trews +2",
}

-- Fold (Enhances Fold gear)
sets.fold = {

}

-- Steps (physical accuracy)
sets.steps = {
	head="Chass. Tricorne +3",
	body="Chasseur's Frac +3",
	hands="Chasseur's Gants +3",
	legs="Chas. Culottes +3",
	feet="Chass. Bottes +3",
	neck="Null Loop",
	waist="Null Belt",
	left_ear="Digni. Earring",
	right_ear="Chas. Earring +2",
	left_ring="Chirich Ring +1",
	right_ring="Chirich Ring +1",
	back="Null Shawl",
}

-- Waltzes
sets.waltzes = {
	legs="Dashing Subligar",
	left_ring="Valseur's Ring",
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
	left_ring="Blenmot's Ring +1",
	right_ring="Blenmot's Ring +1",
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




FileVersion = '1.0'

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
items = res.items
job_abilities = res.job_abilities
buffs = res.buffs
Mode = StartMode --sets the starting mode (selected in the Advanced Options)
NotiLowMPToggle = false --start with the toggle off for the Low MP Notification so that it can trigger
DTOverride = false --Start with the Damage Taken Override off
RRRCountdown = RRReminderTimer
HUDposYLine1 = HUDposY
last_poll = 0 --keeps the timing for things that happen at the polling rate
last_second = 0 --keeps the timing for things that happen every second
GreetingDelay = 6 --delay to display greeting and file version info
Zoning = false --flips automatically to hide the HUD while zoning
InCS = false --flips automatically to hide the HUD while in a cs
LowHP = false
Alive = true --makes it easier to Do Things or Not Do Things based on if we die.
announceAlive = false --simple flip when we raise to make sure the AliveDelay command and notification text is only done once
DangerCountdown = 0
NotiCountdown = -1 --we set the countdown below 0 to stop the countdown from hitting 0 and triggering the ClearNotifications command
EquipMain = ''
EquipSub = ''
EquipRange = ''
current_ranged = ''
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
get_qd_timer = false --used to wait until QD timer is confirmed at zero before storing the QD recast (qd_recast_timer) the first time it's used
qd_charge_timer = 0 --used to calculate number of QD charges available
qd_charges = 0 --number of QD charges available
set_weapon_timestamp = 0
current_roll_id = 0
current_roll_total = 0
current_roll = nil --Used to track which roll is currently active to help decide to Double-Up or start a new roll instead
current_roll_timer = nil
roll_1_id = nil
roll_2_id = nil
roll_1_total = nil
roll_2_total = nil
roll_1_timer = nil
roll_2_timer = nil
roll_1_crooked = false
roll_2_crooked = false
next_roll_is_crooked = false
winning_streak_merits = 0
jp_duration_upgrades = 0
bust_pause = false
player_x = nil
player_y = nil
moving = false

--Lucky/Unlucky numbers for each roll
local rolls = {
	[98] = {lucky = '5', unlucky = '9'},	-- Fighter's Roll
	[99] = {lucky = '3', unlucky = '7'},	-- Monk's Roll
	[100] = {lucky = '3', unlucky = '7'},	-- Healer's Roll
	[101] = {lucky = '5', unlucky = '9'},	-- Wizard's Roll
	[102] = {lucky = '4', unlucky = '8'},	-- Warlock's Roll
	[103] = {lucky = '5', unlucky = '9'},	-- Rogue's Roll
	[104] = {lucky = '3', unlucky = '7'},	-- Gallant's Roll
	[105] = {lucky = '4', unlucky = '8'},	-- Chaos Roll
	[106] = {lucky = '4', unlucky = '8'},	-- Beast Roll
	[107] = {lucky = '2', unlucky = '6'},	-- Choral Roll
	[108] = {lucky = '4', unlucky = '8'},	-- Hunter's Roll
	[109] = {lucky = '2', unlucky = '6'},	-- Samurai Roll
	[110] = {lucky = '4', unlucky = '8'},	-- Ninja Roll
	[111] = {lucky = '4', unlucky = '8'},	-- Drachen Roll
	[112] = {lucky = '5', unlucky = '9'},	-- Evoker's Roll
	[113] = {lucky = '2', unlucky = '6'},	-- Magus's Roll
	[114] = {lucky = '5', unlucky = '9'},	-- Corsair's Roll
	[115] = {lucky = '3', unlucky = '7'},	-- Puppet Roll
	[116] = {lucky = '3', unlucky = '7'},	-- Dancer's Roll
	[117] = {lucky = '2', unlucky = '6'},	-- Scholar's Roll
	[118] = {lucky = '3', unlucky = '9'},	-- Bolter's Roll
	[119] = {lucky = '2', unlucky = '7'},	-- Caster's Roll
	[120] = {lucky = '3', unlucky = '9'},	-- Courser's Roll
	[121] = {lucky = '4', unlucky = '9'},	-- Blitzer's Roll
	[122] = {lucky = '5', unlucky = '8'},	-- Tactician's Roll
	[302] = {lucky = '3', unlucky = '10'},	-- Allies' Roll
	[303] = {lucky = '5', unlucky = '7'},	-- Miser's Roll
	[304] = {lucky = '2', unlucky = '10'},	-- Companion's Roll
	[305] = {lucky = '4', unlucky = '8'},	-- Avenger's Roll
	[390] = {lucky = '3', unlucky = '7'},	-- Naturalit's Roll
	[391] = {lucky = '4', unlucky = '8'},	-- Runeist's Roll
}

local play_sound = windower.play_sound
local addon_path = windower.addon_path
local Notification_Good = addon_path..'data/sounds/NotiGood.wav'
local Notification_Bad = addon_path..'data/sounds/NotiBad.wav'
local Notification_Danger = addon_path..'data/sounds/Danger.wav'
local Notification_Cancel = addon_path..'data/sounds/Cancel.wav'
local Notification_Aftermath_On = addon_path..'data/sounds/AftermathOn.wav'
local Notification_Aftermath_Off = addon_path..'data/sounds/AftermathOff.wav'
local Notification_3000TP = addon_path..'data/sounds/3000TP.wav'

local function copy_table(t)
	local new = {}
	for k, v in pairs(t) do
		new[k] = v
	end
	return new
end

--create a new table that combines both the WeaponCycle/DualWieldCycle and AbysseaProcCycle weapons into one table to be used while inside Abyssea
local WeaponCyclePlusAbyssea = {}
for _, v in ipairs(WeaponCycle) do
	table.insert(WeaponCyclePlusAbyssea, copy_table(v))
end
for _, v in ipairs(AbysseaProcCycle) do
	table.insert(WeaponCyclePlusAbyssea, copy_table(v))
end
local DualWieldCyclePlusAbyssea = {}
for _, v in ipairs(DualWieldCycle) do
	table.insert(DualWieldCyclePlusAbyssea, copy_table(v))
end
for _, v in ipairs(AbysseaProcCycle) do
	table.insert(DualWieldCyclePlusAbyssea, copy_table(v))
end

-- Sets the inital subjob
local subjob = 'OTH'
if player.sub_job == 'DNC' then
	subjob = 'DNC'
elseif player.sub_job == 'DRG' then
	subjob = 'DRG'
elseif player.sub_job == 'DRK' then
	subjob = 'DRK'
elseif player.sub_job == 'NIN' then
	subjob = 'NIN'
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
if SubDNCPage ~= "Off" and player.sub_job == 'DNC' then
	send_command('wait 2;input /macro set '..SubDNCPage)
elseif SubDRGPage ~= "Off" and player.sub_job == 'DRG' then
	send_command('wait 2;input /macro set '..SubDRGPage)
elseif SubDRKPage ~= "Off" and player.sub_job == 'DRK' then
	send_command('wait 2;input /macro set '..SubDRKPage)
elseif SubNINPage ~= "Off" and player.sub_job == 'NIN' then
	send_command('wait 2;input /macro set '..SubNINPage)
elseif SubRNGPage ~= "Off" and player.sub_job == 'RNG' then
	send_command('wait 2;input /macro set '..SubRNGPage)
elseif SubWARPage ~= "Off" and player.sub_job == 'WAR' then
	send_command('wait 2;input /macro set '..SubWARPage)
else
	send_command('wait 2;input /macro set 1')
end

if ZoneGear ~= 'Off' then
	send_command('wait 2;gs c Zone Gear')
end

WildCard = {} CuttingCards = {} Aggressor = {} ArcaneCircle = {} Berserk = {} ConsumeMana = {} Contradance = {} CrookedCards = {} Defender = {} DoubleUp = {} FlourishesI = {} FlourishesII = {} Fold = {} HighJump = {} Jigs = {} Jump = {} LastResort = {} PhantomRoll = {} QuickDraw = {} RandomDeal = {} Sambas = {} SnakeEye = {} Souleater = {} Steps = {} SuperJump = {} TripleShot = {} Warcry = {}

--Start true so the HUD recasts don't flash on load
WildCard.flashed = true
CuttingCards.flashed = true
Aggressor.flashed = true
ArcaneCircle.flashed = true
Berserk.flashed = true
ConsumeMana.flashed = true
Contradance.flashed = true
CrookedCards.flashed = true
Defender.flashed = true
DoubleUp.flashed = true
FlourishesI.flashed = true
FlourishesII.flashed = true
Fold.flashed = true
HighJump.flashed = true
Jigs.flashed = true
Jump.flashed = true
LastResort.flashed = true
PhantomRoll.flashed = true
QuickDraw.flashed_charge_1 = true
QuickDraw.flashed_charge_2 = true
RandomDeal.flashed = true
Sambas.flashed = true
SnakeEye.flashed = true
Souleater.flashed = true
Steps.flashed = true
SuperJump.flashed = true
TripleShot.flashed = true
Warcry.flashed = true

DoubleUp.timer = 0 --timer for time left to use Double-Up, the Phantom Roll HUD Recast uses this once it's active

--Space out each line and column properly
HUDposYLine2 = HUDposYLine1 + LineSpacer
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

-- Create the HUD Roll BG text object
local hud_roll_bg = texts.new('                                                                        ')
hud_roll_bg:font("Consolas")
hud_roll_bg:size(FontSize)
hud_roll_bg:pad(-1)
hud_roll_bg:bg_color(250,250,250)
hud_roll_bg:bg_alpha(50)
hud_roll_bg:pos(HUDposXColumn1+1,HUDposYLine3)
hud_roll_bg:draggable(false)
hud_roll_bg:bold(true)

-- Create the HUD Roll 1 BG text object
local hud_roll_1_bg = texts.new('                        ')
hud_roll_1_bg:font("Consolas")
hud_roll_1_bg:size(FontSize)
hud_roll_1_bg:pad(-1)
hud_roll_1_bg:bg_color(250,250,250)
hud_roll_1_bg:bg_alpha(125)
hud_roll_1_bg:pos(HUDposXColumn1+1,HUDposYLine3)
hud_roll_1_bg:draggable(false)
hud_roll_1_bg:bold(true)

-- Create the HUD Roll 2 BG text object
local hud_roll_2_bg = texts.new('                        ')
hud_roll_2_bg:font("Consolas")
hud_roll_2_bg:size(FontSize)
hud_roll_2_bg:pad(-1)
hud_roll_2_bg:bg_color(250,250,250)
hud_roll_2_bg:bg_alpha(125)
hud_roll_2_bg:pos(HUDposXColumn3+1,HUDposYLine3)
hud_roll_2_bg:draggable(false)
hud_roll_2_bg:bold(true)

-- Create the HUD Ammo BG text object
local hud_ammo_bg = texts.new('                        ')
hud_ammo_bg:font("Consolas")
hud_ammo_bg:size(FontSize)
hud_ammo_bg:pad(-1)
hud_ammo_bg:bg_color(250,250,250)
hud_ammo_bg:bg_alpha(125)
hud_ammo_bg:pos(HUDposXColumn5+1,HUDposYLine3)
hud_ammo_bg:draggable(false)
hud_ammo_bg:bold(true)

-- Create the HUD Abil01 BG text object
local hud_abil01_bg = texts.new('            ')
hud_abil01_bg:font("Consolas")
hud_abil01_bg:size(FontSize)
hud_abil01_bg:pad(-0.5)
hud_abil01_bg:bg_alpha(0)
hud_abil01_bg:pos(HUDposXColumn1+1,HUDposYLine4)
hud_abil01_bg:draggable(false)
hud_abil01_bg:bold(true)

-- Create the HUD Abil02 BG text object
local hud_abil02_bg = texts.new('            ')
hud_abil02_bg:font("Consolas")
hud_abil02_bg:size(FontSize)
hud_abil02_bg:pad(-0.5)
hud_abil02_bg:bg_alpha(0)
hud_abil02_bg:pos(HUDposXColumn2+1,HUDposYLine4)
hud_abil02_bg:draggable(false)
hud_abil02_bg:bold(true)

-- Create the HUD Abil03 BG text object
local hud_abil03_bg = texts.new('            ')
hud_abil03_bg:font("Consolas")
hud_abil03_bg:size(FontSize)
hud_abil03_bg:pad(-0.5)
hud_abil03_bg:bg_alpha(0)
hud_abil03_bg:pos(HUDposXColumn3+1,HUDposYLine4)
hud_abil03_bg:draggable(false)
hud_abil03_bg:bold(true)

-- Create the HUD Abil04 BG text object
local hud_abil04_bg = texts.new('            ')
hud_abil04_bg:font("Consolas")
hud_abil04_bg:size(FontSize)
hud_abil04_bg:pad(-0.5)
hud_abil04_bg:bg_alpha(0)
hud_abil04_bg:pos(HUDposXColumn4+1,HUDposYLine4)
hud_abil04_bg:draggable(false)
hud_abil04_bg:bold(true)

-- Create the HUD Abil05 BG text object
local hud_abil05_bg = texts.new('            ')
hud_abil05_bg:font("Consolas")
hud_abil05_bg:size(FontSize)
hud_abil05_bg:pad(-0.5)
hud_abil05_bg:bg_alpha(0)
hud_abil05_bg:pos(HUDposXColumn5+1,HUDposYLine4)
hud_abil05_bg:draggable(false)
hud_abil05_bg:bold(true)

-- Create the HUD Abil06 BG text object
local hud_abil06_bg = texts.new('            ')
hud_abil06_bg:font("Consolas")
hud_abil06_bg:size(FontSize)
hud_abil06_bg:pad(-0.5)
hud_abil06_bg:bg_alpha(0)
hud_abil06_bg:pos(HUDposXColumn6+1,HUDposYLine4)
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
local hud_mode_shdw = texts.new('Mode: '..modeName[Mode]..' ('..EquipRange..')')
hud_mode_shdw:color(0,0,0)
hud_mode_shdw:font("Consolas")
hud_mode_shdw:size(FontSize)
hud_mode_shdw:bg_alpha(0)
hud_mode_shdw:pos(HUDposXColumn1+2.5,HUDposYLine2+0.5)
hud_mode_shdw:draggable(false)
hud_mode_shdw:bold(true)

-- Create the HUD Notifications Text Shadow text object
local hud_noti_shdw = texts.new('Keys COR Gearswap file v'..FileVersion)
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

-- Create the HUD Roll Text Shadow text object
local hud_roll_shdw = texts.new()
hud_roll_shdw:color(0,0,0)
hud_roll_shdw:font("Consolas")
hud_roll_shdw:size(FontSize)
hud_roll_shdw:bg_alpha(0)
hud_roll_shdw:pos(HUDposXColumn1+2.5,HUDposYLine3-0.5)
hud_roll_shdw:draggable(false)
hud_roll_shdw:bold(true)

-- Create the HUD Roll 1 Text Shadow text object
local hud_roll_1_shdw = texts.new()
hud_roll_1_shdw:color(0,0,0)
hud_roll_1_shdw:font("Consolas")
hud_roll_1_shdw:size(FontSize)
hud_roll_1_shdw:bg_alpha(0)
hud_roll_1_shdw:pos(HUDposXColumn1+2.5,HUDposYLine3+0.5)
hud_roll_1_shdw:draggable(false)
hud_roll_1_shdw:bold(true)

-- Create the HUD Roll 2 Text Shadow text object
local hud_roll_2_shdw = texts.new()
hud_roll_2_shdw:color(0,0,0)
hud_roll_2_shdw:font("Consolas")
hud_roll_2_shdw:size(FontSize)
hud_roll_2_shdw:bg_alpha(0)
hud_roll_2_shdw:pos(HUDposXColumn3+1.5,HUDposYLine3+0.5)
hud_roll_2_shdw:draggable(false)
hud_roll_2_shdw:bold(true)

-- Create the HUD Ammo Text Shadow text object
local hud_ammo_shdw = texts.new()
hud_ammo_shdw:color(0,0,0)
hud_ammo_shdw:font("Consolas")
hud_ammo_shdw:size(FontSize)
hud_ammo_shdw:bg_alpha(0)
hud_ammo_shdw:pos(HUDposXColumn5+1.5,HUDposYLine3+0.5)
hud_ammo_shdw:draggable(false)
hud_ammo_shdw:bold(true)

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
hud_weapons:color(255,255,255)
hud_weapons:font("Consolas")
hud_weapons:size(FontSize)
hud_weapons:bg_alpha(0)
hud_weapons:pos(HUDposXColumn4,HUDposYLine2-1)
hud_weapons:draggable(false)
hud_weapons:bold(true)

-- Create the HUD Mode text object
local hud_mode = texts.new('Mode: '..modeName[Mode]..' ('..EquipRange..')')
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
local hud_noti = texts.new('Keys COR Gearswap file v'..FileVersion)
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

-- Create the HUD Roll text object
local hud_roll = texts.new('')
hud_roll:font("Consolas")
hud_roll:size(FontSize)
hud_roll:bg_alpha(0)
hud_roll:pos(HUDposXColumn1+1,HUDposYLine3-1)
hud_roll:draggable(false)
hud_roll:bold(true)

-- Create the HUD Roll 1 text object
local hud_roll_1 = texts.new('')
hud_roll_1:font("Consolas")
hud_roll_1:size(FontSize)
hud_roll_1:bg_alpha(0)
hud_roll_1:pos(HUDposXColumn1+1,HUDposYLine3-1)
hud_roll_1:draggable(false)
hud_roll_1:bold(true)
hud_roll_1:italic(false)

-- Create the HUD Roll 2 text object
local hud_roll_2 = texts.new('')
hud_roll_2:font("Consolas")
hud_roll_2:size(FontSize)
hud_roll_2:bg_alpha(0)
hud_roll_2:pos(HUDposXColumn3+1,HUDposYLine3-1)
hud_roll_2:draggable(false)
hud_roll_2:bold(true)
hud_roll_2:italic(false)

-- Create the HUD Ammo text object
local hud_ammo = texts.new('')
hud_ammo:font("Consolas")
hud_ammo:size(FontSize)
hud_ammo:bg_alpha(0)
hud_ammo:pos(HUDposXColumn5+1,HUDposYLine3-1)
hud_ammo:draggable(false)
hud_ammo:bold(true)

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
	hud_roll_bg:show()
	hud_roll_1_bg:show()
	hud_roll_2_bg:show()
	hud_ammo_bg:show()
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
	hud_roll_shdw:show()
	hud_roll_1_shdw:show()
	hud_roll_2_shdw:show()
	hud_ammo_shdw:show()
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
	hud_roll:show()
	hud_roll_1:show()
	hud_roll_2:show()
	hud_ammo:show()
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

send_command('alias dt gs c DT') --creates the DT Override alias
send_command('alias mode gs c Mode') --creates the Mode alias
send_command('alias rc gs c RC') --creates the Ranged Cycle alias
send_command('alias wc gs c WC') --creates the Weapon Cycle alias
send_command('alias hud gs c HUD') --creates the HUD alias
send_command('bind '..DTBind..' gs c DT') --creates the DT Override keyboard shortcut
send_command('bind '..LuzafBind..' gs c Luzaf') --creates the Luzaf's Ring keyboard shortcut
send_command('bind '..ModeBind..' gs c Mode') --creates the gear mode keyboard shortcut
send_command('bind '..RCBind..' gs c RC') --creates the Ranged Cycle keyboard shortcut
send_command('bind '..WCBind..' gs c WC') --creates the Weapon Cycle keyboard shortcut

-------------------------------------------
--           CUSTOM FUNCTIONS            --
-------------------------------------------

--Format RGB values with leading zeros (helps prevent an issue with the shadow text not lining up correctly)
local function formatRGB(value)

	return string.format("%03d", value)

end

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

--Check if we have access to dual wield
local function hasDualWield()
	if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
		return true
	else
		return false
	end
end

--Check if our subjob has MP
local function subJobWithMP()
	if player.sub_job == 'WHM' or player.sub_job == 'BLM' or player.sub_job == 'RDM' or player.sub_job == 'PLD' or player.sub_job == 'DRK' or player.sub_job == 'SMN' or player.sub_job == 'BLU' or player.sub_job == 'SCH' or player.sub_job == 'GEO' or player.sub_job == 'RUN' then
		return true
	else
		return false
	end
end

--Set the initial main/sub weapon pair
local function getWeaponCycle()
	local in_abyssea = string.find(world.area, 'Abyssea')
	local dw = hasDualWield()

	if in_abyssea then
		return dw and DualWieldCyclePlusAbyssea or WeaponCyclePlusAbyssea
	else
		return dw and DualWieldCycle or WeaponCycle
	end
end
local function setWeaponPair()
	WeaponCycleIndex = 1
	local cycle = getWeaponCycle()
	pair = cycle[WeaponCycleIndex]
end
setWeaponPair()

--Set the initial Ranged Weapon
local function setRangedWeapon()
	RangedCycleIndex = 1 --used to cycle through the RangedCycle sets
	ranged_weapon = RangedCycle[RangedCycleIndex]
end
setRangedWeapon()

--Check if the equipped Main/Sub pair are in our defined AbysseaProcCycle weapons table
local function checkProcWeapons(mainSlot, subSlot)

	for _, equipmentPair in pairs(AbysseaProcCycle) do

		if equipmentPair[1] == mainSlot and equipmentPair[2] == subSlot then
			return true

		end
	end

	return false

end

--Are we dual wielding weapons?
local function dualWield()

	local weapon_id = player.equipment.sub and items:with('name', player.equipment.sub) and items:with('name', player.equipment.sub).id

	if weapon_id then
		local skill = items[weapon_id].skill
		return skill == 2 or skill == 3 or skill == 5 or skill == 9 or skill == 11
	else
		return false
	end

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

	elseif area == 'Ammo' then
		send_command('gs c Flash_Ammo_A;wait .25;gs c Flash_Ammo_B;wait .25;gs c Flash_Ammo_A;wait .25;gs c Flash_Ammo_B')

	end
end

local function getRecasts()

	local ability_recast = windower.ffxi.get_ability_recasts()

	WildCard.recast = ability_recast[0] and math.ceil(ability_recast[0])
	CuttingCards.recast = ability_recast[254] and math.ceil(ability_recast[254]) or 0
	Aggressor.recast = ability_recast[4] and math.ceil(ability_recast[4])
	ArcaneCircle.recast = ability_recast[50] and math.ceil(ability_recast[50])
	Berserk.recast = ability_recast[1] and math.ceil(ability_recast[1])
	ConsumeMana.recast = ability_recast[389] and math.ceil(ability_recast[389])
	Contradance.recast = ability_recast[229] and math.ceil(ability_recast[229])
	CrookedCards.recast = ability_recast[96] and math.ceil(ability_recast[96])
	Defender.recast = ability_recast[3] and math.ceil(ability_recast[3])
	DoubleUp.recast = ability_recast[194] and math.ceil(ability_recast[194])
	FlourishesI.recast = ability_recast[221] and math.ceil(ability_recast[221])
	FlourishesII.recast = ability_recast[222] and math.ceil(ability_recast[222])
	Fold.recast = ability_recast[198] and math.ceil(ability_recast[198])
	HighJump.recast = ability_recast[159] and math.ceil(ability_recast[159])
	Jigs.recast = ability_recast[218] and math.ceil(ability_recast[218])
	Jump.recast = ability_recast[158] and math.ceil(ability_recast[158])
	LastResort.recast = ability_recast[51] and math.ceil(ability_recast[51])
	PhantomRoll.recast = ability_recast[193] and math.ceil(ability_recast[193])
	QuickDraw.recast = ability_recast[195] and math.ceil(ability_recast[195])
	RandomDeal.recast = ability_recast[196] and math.ceil(ability_recast[196])
	Sambas.recast = ability_recast[216] and math.ceil(ability_recast[216])
	SnakeEye.recast = ability_recast[197] and math.ceil(ability_recast[197])
	Souleater.recast = ability_recast[49] and math.ceil(ability_recast[49])
	Steps.recast = ability_recast[220] and math.ceil(ability_recast[220])
	SuperJump.recast = ability_recast[160] and math.ceil(ability_recast[160])
	TripleShot.recast = ability_recast[84] and math.ceil(ability_recast[84])
	Warcry.recast = ability_recast[2] and math.ceil(ability_recast[2])

end
getRecasts()

-- Format abilities/spells to fit into their allotted 12 spaces
local function formatAbils(input,input_sh)

	-- Valid abilities/spells
	local validAbilities = {
		"Wild Card", "Cutting Cards", "Aggressor", "Arcane Circle", "Berserk", "Consume Mana", "Contradance", "Crooked Cards", "Defender", "Flourishes I", "Flourishes II", "Fold", "High Jump", "Jigs", "Jump", "Last Resort", "Phantom Roll", "Quick Draw", "Random Deal", "Sambas", "Snake Eye", "Souleater", "Steps", "Super Jump", "Triple Shot", "Warcry"
	}

	local ab = {} ab['Wild Card'] = WildCard ab['Cutting Cards'] = CuttingCards ab['Aggressor'] = Aggressor ab['Arcane Circle'] = ArcaneCircle ab['Berserk'] = Berserk ab['Consume Mana'] = ConsumeMana ab['Contradance'] = Contradance ab['Crooked Cards'] = CrookedCards ab['Defender'] = Defender ab['Flourishes I'] = FlourishesI ab['Flourishes II'] = FlourishesII ab['Fold'] = Fold ab['High Jump'] = HighJump ab['Jigs'] = Jigs ab['Jump'] = Jump ab['Last Resort'] = LastResort ab['Phantom Roll'] = PhantomRoll ab['Quick Draw'] = QuickDraw ab['Random Deal'] = RandomDeal ab['Sambas'] = Sambas ab['Snake Eye'] = SnakeEye ab['Souleater'] = Souleater ab['Steps'] = Steps ab['Super Jump'] = SuperJump ab['Triple Shot'] = TripleShot ab['Warcry'] = Warcry


	-- Check if the input matches any of the valid abilities/spells
	for _, ability in ipairs(validAbilities) do

		if input == ability then

			local recast = ab[ability].recast or 0

			-- Are we using the ability/spell name itself, or a shorthand supplied in the Options?
			local startingString = input_sh == '' and input or input_sh

			-- Adjust for Phantom Roll/Double-Up
			if input == 'Phantom Roll' and buffactive['Double-Up Chance'] then
				startingString = 'Dbl-Up'
				recast = DoubleUp.timer
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
			if input == 'Quick Draw' then --variable maximum recast time based on merits/JP/equipment, 70s to 120s (35s to 60s per charge)
				--0 charges
				local tnc = recast > qd_charge_timer and recast - qd_charge_timer or recast --To Next Charge
				if recast > qd_charge_timer then
					qd_charges = 0
					if tnc > 9 then
						formattedString = formatOutputString(startingString, maxLength - 5)..':'..tnc..'|0'
					else
						formattedString = formatOutputString(startingString, maxLength - 4)..':'..tnc..'|0'
					end
				--1 charge
				elseif recast > 0 then
					qd_charges = 1
					if tnc > 9 then
						formattedString = formatOutputString(startingString, maxLength - 5)..':'..recast..'|1'
					else
						formattedString = formatOutputString(startingString, maxLength - 4)..':'..recast..'|1'
					end
				--2 charges
				else
					qd_charges = 2
					formattedString = formatOutputString(startingString, maxLength - 2)..'|2'
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
			if input == "Quick Draw" then
				if qd_charges > 0 then
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

	abil01 = formatAbils(sub[subjob].Abil01,sub[subjob].Abil01_sh)
	abil02 = formatAbils(sub[subjob].Abil02,sub[subjob].Abil02_sh)
	abil03 = formatAbils(sub[subjob].Abil03,sub[subjob].Abil03_sh)
	abil04 = formatAbils(sub[subjob].Abil04,sub[subjob].Abil04_sh)
	abil05 = formatAbils(sub[subjob].Abil05,sub[subjob].Abil05_sh)
	abil06 = formatAbils(sub[subjob].Abil06,sub[subjob].Abil06_sh)

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

	if itemMatch(22161) then --stage 3 Prime
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
	elseif itemMatch(22162) then --stage 4 Prime
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
	elseif itemMatch(22164) then --stage 5 Prime
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

local function getJPsAndMerits()

	local player = windower.ffxi.get_player()
	
	winning_streak_merits = player and player.merits.winning_streak

	jp_duration_upgrades = player and player.job_points.cor.phantom_roll_duration

end
getJPsAndMerits()

local function getRollDuration()

	--Rolls start with a base duration of 5 minutes (minus 2 seconds to get it to line up with in-game timer)
	local roll_duration = 298

	--Job Point roll duration increase
	roll_duration = roll_duration + (jp_duration_upgrades * 2) --2 seconds per upgrade

	--Winning Streak Merits increase
	roll_duration = roll_duration + (winning_streak_merits * 20) --20 seconds per merit

	--Weapons (we're going to have to assume the augment ranks are capped)
	if player.equipment.main == "Rostam" then
		roll_duration = roll_duration + 60
	end
	if player.equipment.main == "Lanun Knife" then
		roll_duration = roll_duration + 45
	end
	if player.equipment.main == "Commodore's Knife" then
		roll_duration = roll_duration + 30
	end
	if player.equipment.range == 'Compensator' then
		roll_duration = roll_duration + 20
	end

	--Head (additional 6 seconds per Winning Streak merit)
	if player.equipment.head == 'Comm. Tricorne +2' or player.equipment.head == 'Lanun Tricorne' or player.equipment.head == 'Lanun Tricorne +1' or player.equipment.head == 'Lanun Tricorne +2' or player.equipment.head == 'Lanun Tricorne +3' or player.equipment.head == 'Lanun Tricorne +4' then
		roll_duration = roll_duration + (winning_streak_merits * 6)
	end

	--Hands
	if player.equipment.hands == "Nvrch. Gants +1" then
		roll_duration = roll_duration + 20
	elseif player.equipment.hands == "Nvrch. Gants +2" then
		roll_duration = roll_duration + 40
	elseif player.equipment.hands == "Chasseur's Gants" then
		roll_duration = roll_duration + 45
	elseif player.equipment.hands == "Chasseur's Gants +1" then
		roll_duration = roll_duration + 50
	elseif player.equipment.hands == "Chasseur's Gants +2" then
		roll_duration = roll_duration + 55
	elseif player.equipment.hands == "Chasseur's Gants +3" then
		roll_duration = roll_duration + 60
	end

	--Neck
	if player.equipment.neck == "Regal Necklace" then
		roll_duration = roll_duration + 20
	end

	--Back
	if player.equipment.back == "Camulus's Mantle" then
		roll_duration = roll_duration + 30
	end

	return roll_duration

end

local function formatTimer(num)
	local minutes = math.floor(num / 60)
	local seconds = num % 60
	local time = string.format("%d:%02d", minutes, seconds).." "
	return time
end

local function updateCurrentRolls()

	local r1_name = roll_1_id and job_abilities[roll_1_id].english:gsub(" Roll$", "")
	local r2_name = roll_2_id and job_abilities[roll_2_id].english:gsub(" Roll$", "")
	local r1_timer = roll_1_timer and formatTimer(roll_1_timer) or ""
	local r2_timer = roll_2_timer and formatTimer(roll_2_timer) or ""
	local text_1 = r1_name and r1_timer..r1_name..(roll_1_total and " - "..roll_1_total or "") or "No Roll"
	local text_2 = r2_name and r2_timer..r2_name..(roll_2_total and " - "..roll_2_total or "") or "No Roll"
	local pad_1 = string.rep(" ", 12 - math.floor(#text_1 / 2))
	local pad_2 = string.rep(" ", 12 - math.floor(#text_2 / 2))
	local r1_info = rolls[roll_1_id]
	local r2_info = rolls[roll_2_id]
	local r1_lucky = r1_info and tonumber(r1_info.lucky)
	local r2_lucky = r2_info and tonumber(r2_info.lucky)
	local r1_unlucky = r1_info and tonumber(r1_info.unlucky)
	local r2_unlucky = r2_info and tonumber(r2_info.unlucky)
	local r1_color = color.roll.no_roll
	if roll_1_total then
		if roll_1_total == r1_lucky then
			r1_color = color.roll.lucky
		elseif roll_1_total == r1_unlucky then
			r1_color = color.roll.unlucky
		elseif roll_1_total == 11 then
			r1_color = color.roll.eleven
		else
			r1_color = color.roll.current
		end
	end
	local r2_color = color.roll.no_roll
	if roll_2_total then
		if roll_2_total == r2_lucky then
			r2_color = color.roll.lucky
		elseif roll_2_total == r2_unlucky then
			r2_color = color.roll.unlucky
		elseif roll_2_total == 11 then
			r2_color = color.roll.eleven
		else
			r2_color = color.roll.current
		end
	end

	text_1 = pad_1..text_1
	text_2 = pad_2..text_2

	hud_roll_1:text(text_1)
	hud_roll_2:text(text_2)
	hud_roll_1_shdw:text(text_1)
	hud_roll_2_shdw:text(text_2)
	hud_roll_1_bg:bg_color(r1_color.r,r1_color.g,r1_color.b)
	hud_roll_2_bg:bg_color(r2_color.r,r2_color.g,r2_color.b)
	hud_roll_1:italic(roll_1_crooked)
	hud_roll_2:italic(roll_2_crooked)

end

local function displayCurrentRolls()


	updateCurrentRolls()

	hud_roll:hide()
	hud_roll_shdw:hide()
	hud_roll_bg:hide()

	if not (InCS or Zoning) then
		hud_roll_1:show()
		hud_roll_2:show()
		hud_roll_1_shdw:show()
		hud_roll_2_shdw:show()
		hud_roll_1_bg:show()
		hud_roll_2_bg:show()
	end

end
displayCurrentRolls()

local function displayRollInfo(act, double_up, snake_eye)

	--Hide the current roll info
	hud_roll_1:hide()
	hud_roll_2:hide()
	hud_ammo:hide()
	hud_roll_1_shdw:hide()
	hud_roll_2_shdw:hide()
	hud_ammo_shdw:hide()
	hud_roll_1_bg:hide()
	hud_roll_2_bg:hide()
	hud_ammo_bg:hide()

	if act then
		current_roll_id = act.param
		current_roll_total = act.targets[1].actions[1].param
	end

	--Handle roll slots
	if current_roll_total == 12 then
		-- Bust: discard new roll, restore previous
		roll_1_id = roll_2_id
		roll_1_total = roll_2_total
		roll_1_timer = roll_2_timer
		roll_1_crooked = roll_2_crooked
		roll_2_id = nil
		roll_2_total = nil
		roll_2_timer = nil
		roll_2_crooked = false

	elseif not (double_up or snake_eye) then

		-- New roll: shift roll 1 -> roll 2
		roll_2_id = roll_1_id
		roll_2_total = roll_1_total
		roll_2_timer = roll_1_timer
		roll_2_crooked = roll_1_crooked
		
		roll_1_id = current_roll_id
		roll_1_total = current_roll_total
		roll_1_timer = current_roll_timer
		roll_1_crooked = next_roll_is_crooked
		next_roll_is_crooked = false
		
	else
		-- Double Up / Snake Eye: update roll 1 only
		roll_1_id = current_roll_id
		roll_1_total = current_roll_total
	end

	local roll_name = job_abilities[current_roll_id].english

	if current_roll_total == 11 then

		local color = color.roll.eleven
		local text = roll_name:upper()..": ELEVEN"
		local pad = string.rep(" ", 36 - math.floor(#text / 2))

		hud_roll:text("\\cs("..color.r..","..color.g..","..color.b..")"..pad..text.."\\cr")
		hud_roll_shdw:text("\\cs(000,000,000)"..pad..text.."\\cr")

		coroutine.schedule(function()
			displayCurrentRolls()
		end, 2)

		return

	elseif current_roll_total == 12 then

		bust_pause = true

		local color = color.roll.bust
		local text = "BUST BUST BUST BUST BUST BUST BUST BUST BUST BUST BUST BUST BUST BUST"
		local sass = {
			"DAMIT OBI",
			"AW FUCK, I CANT BELIEVE YOU'VE DONE THIS",
			"SIGUE WOULD BE PROUD",
			"RIGHT IN FRONT OF MY SALAD?",
			"WOW",
			"IT WAS AT THIS MOMENT THAT HE KNEW, HE FUCKED UP",
			"GET BUSTED",
			"STOP IT, GET SOME HELP",
			"*KEFKA LAUGH*",
			"EMOTIONAL DAMAGE",
			"*KOLO SWEARING*",
			"YOU DID THIS TO ME",
		}

		--20% chance to throw in some sass
		if math.random() >= 0.8 then
			text = sass[math.random(#sass)]
		end

		local pad = string.rep(" ", 36 - math.floor(#text / 2)) 

		hud_roll:text("\\cs("..color.r..","..color.g..","..color.b..")"..pad..text.."\\cr")
		hud_roll_shdw:text("\\cs(000,000,000)"..pad..text.."\\cr")

		coroutine.schedule(function()
			bust_pause = false
			displayCurrentRolls()
		end, 2)

		return

	end

	local roll_info = rolls[current_roll_id]
	local lucky = tonumber(roll_info.lucky)
	local unlucky = tonumber(roll_info.unlucky)

	local bg_color = color.roll.current
	if current_roll_total == lucky then
		bg_color = color.roll.lucky
	elseif current_roll_total == unlucky then
		bg_color = color.roll.unlucky
	elseif current_roll_total == 11 then
		bg_color = color.roll.eleven
	elseif current_roll_total == 12 then
		bg_color = color.roll.bust
	end

	if ShowRollOdds then

		-- Determine possible die results
		local possible_rolls
		if snake_eye then
			possible_rolls = {1}
		else
			possible_rolls = {1,2,3,4,5,6}
		end

		local total_outcomes = #possible_rolls

		local lucky_count = 0
		local unlucky_count = 0
		local eleven_count = 0
		local bust_count = 0

		for _, roll in ipairs(possible_rolls) do
			local new_total = current_roll_total + roll

			if new_total >= 12 then
				bust_count = bust_count + 1
			elseif new_total == 11 then
				eleven_count = eleven_count + 1
			elseif new_total == lucky then
				lucky_count = lucky_count + 1
			elseif new_total == unlucky then
				unlucky_count = unlucky_count + 1
			end
		end

		-- Convert counts to rounded percentages and formats spacing
		local function pct_fmt(count, total)
			local pct = math.floor((count / total) * 100 + 0.5)
			return string.format("%-4s", pct.."%")
		end

		local roll_total = string.format("%-2s", current_roll_total)
		local lucky_pct	 = pct_fmt(lucky_count, total_outcomes)
		local unlucky_pct = pct_fmt(unlucky_count, total_outcomes)
		local eleven_pct = pct_fmt(eleven_count, total_outcomes)
		local bust_pct = pct_fmt(bust_count, total_outcomes)

		local c_color = color.roll.current
		if current_roll_total == lucky then
			c_color = color.roll.lucky
		elseif current_roll_total == unlucky then
			c_color = color.roll.unlucky
		elseif current_roll_total == 11 then
			c_color = color.roll.eleven
		elseif current_roll_total == 12 then
			c_color = color.roll.bust
		end
		local l_color = color.roll.lucky
		local u_color = color.roll.unlucky
		local e_color = color.roll.eleven
		local b_color = color.roll.bust

		local c_r = formatRGB(c_color.r)
		local c_g = formatRGB(c_color.g)
		local c_b = formatRGB(c_color.b)
		local l_r = formatRGB(l_color.r)
		local l_g = formatRGB(l_color.g)
		local l_b = formatRGB(l_color.b)
		local u_r = formatRGB(u_color.r)
		local u_g = formatRGB(u_color.g)
		local u_b = formatRGB(u_color.b)
		local e_r = formatRGB(e_color.r)
		local e_g = formatRGB(e_color.g)
		local e_b = formatRGB(e_color.b)
		local b_r = formatRGB(b_color.r)
		local b_g = formatRGB(b_color.g)
		local b_b = formatRGB(b_color.b)

		--Remove the " Roll" from the Roll name
		roll_name = roll_name:gsub(" Roll$", "")

		local text_length = #roll_name + 2 + #roll_total + 7 + #tostring(lucky) + 3 + #lucky_pct + 9 + #tostring(unlucky) + 3 + #unlucky_pct + 5 + #eleven_pct + 7 + #bust_pct
		local pad = string.rep(" ", 36 - math.floor(text_length / 2)) 

		--Display the new roll info
		hud_roll:text(
			pad..
			"\\cs("..c_r..","..c_g..","..c_b..")"..roll_name.."\\cr"..": \\cs("..c_r..","..c_g..","..c_b..")"..roll_total.."\\cr"..
			" Lucky(\\cs("..l_r..","..l_g..","..l_b..")"..lucky.."\\cr): \\cs("..l_r..","..l_g..","..l_b..")"..lucky_pct.."\\cr"..
			" Unlucky(\\cs("..u_r..","..u_g..","..u_b..")"..unlucky.."\\cr): \\cs("..u_r..","..u_g..","..u_b..")"..unlucky_pct.."\\cr"..
			" 11: \\cs("..e_r..","..e_g..","..e_b..")"..eleven_pct.."\\cr"..
			" Bust: \\cs("..b_r..","..b_g..","..b_b..")"..bust_pct.."\\cr"
		)
		hud_roll_shdw:text(
			pad..
			"\\cs(000,000,000)"..roll_name.."\\cr"..": \\cs(000,000,000)"..roll_total.."\\cr"..
			" Lucky(\\cs(000,000,000)"..lucky.."\\cr): \\cs(000,000,000)"..lucky_pct.."\\cr"..
			" Unlucky(\\cs(000,000,000)"..unlucky.."\\cr): \\cs(000,000,000)"..unlucky_pct.."\\cr"..
			" 11: \\cs(000,000,000)"..eleven_pct.."\\cr"..
			" Bust: \\cs(000,000,000)"..bust_pct.."\\cr"
		)

		hud_roll_bg:bg_color(bg_color.r,bg_color.g,bg_color.b)

	else

		local r_id = current_roll_id
		local r_tot = current_roll_total
		local text_color = {r=255,g=255,b=255}

		local r_1 = (r_tot == 1 and '[' or ' ')..'1'..(r_tot == 1 and ']' or (r_tot == 2 and '' or ' '))
		local r_2 = (r_tot == 2 and '[' or '')..'2'..(r_tot == 2 and ']' or (r_tot == 3 and '' or ' '))
		local r_3 = (r_tot == 3 and '[' or '')..'3'..(r_tot == 3 and ']' or (r_tot == 4 and '' or ' '))
		local r_4 = (r_tot == 4 and '[' or '')..'4'..(r_tot == 4 and ']' or (r_tot == 5 and '' or ' '))
		local r_5 = (r_tot == 5 and '[' or '')..'5'..(r_tot == 5 and ']' or (r_tot == 6 and '' or ' '))
		local r_6 = (r_tot == 6 and '[' or '')..'6'..(r_tot == 6 and ']' or (r_tot == 7 and '' or ' '))
		local r_7 = (r_tot == 7 and '[' or '')..'7'..(r_tot == 7 and ']' or (r_tot == 8 and '' or ' '))
		local r_8 = (r_tot == 8 and '[' or '')..'8'..(r_tot == 8 and ']' or (r_tot == 9 and '' or ' '))
		local r_9 = (r_tot == 9 and '[' or '')..'9'..(r_tot == 9 and ']' or (r_tot == 10 and '' or ' '))
		local r_10 = (r_tot == 10 and '[' or '')..'10'..(r_tot == 10 and ']' or (r_tot == 11 and '' or ' '))
		local r_11 = (r_tot == 11 and '[' or '')..'11'..(r_tot == 11 and ']' or ' ')

		local r_c1 = r_tot == 1 and color.roll.current or text_color
		local r_c2 = (rolls[r_id].lucky == '2' and color.roll.lucky or (rolls[r_id].unlucky == '2' and color.roll.unlucky or (r_tot == 2 and color.roll.current or text_color)))
		local r_c3 = (rolls[r_id].lucky == '3' and color.roll.lucky or (rolls[r_id].unlucky == '3' and color.roll.unlucky or (r_tot == 3 and color.roll.current or text_color)))
		local r_c4 = (rolls[r_id].lucky == '4' and color.roll.lucky or (rolls[r_id].unlucky == '4' and color.roll.unlucky or (r_tot == 4 and color.roll.current or text_color)))
		local r_c5 = (rolls[r_id].lucky == '5' and color.roll.lucky or (rolls[r_id].unlucky == '5' and color.roll.unlucky or (r_tot == 5 and color.roll.current or text_color)))
		local r_c6 = (rolls[r_id].lucky == '6' and color.roll.lucky or (rolls[r_id].unlucky == '6' and color.roll.unlucky or (r_tot == 6 and color.roll.current or text_color)))
		local r_c7 = (rolls[r_id].lucky == '7' and color.roll.lucky or (rolls[r_id].unlucky == '7' and color.roll.unlucky or (r_tot == 7 and color.roll.current or text_color)))
		local r_c8 = (rolls[r_id].lucky == '8' and color.roll.lucky or (rolls[r_id].unlucky == '8' and color.roll.unlucky or (r_tot == 8 and color.roll.current or text_color)))
		local r_c9 = (rolls[r_id].lucky == '9' and color.roll.lucky or (rolls[r_id].unlucky == '9' and color.roll.unlucky or (r_tot == 9 and color.roll.current or text_color)))
		local r_c10 = (rolls[r_id].lucky == '10' and color.roll.lucky or (rolls[r_id].unlucky == '10' and color.roll.unlucky or (r_tot == 10 and color.roll.current or text_color)))
		local r_c11 = color.roll.eleven

		local r_1_t = '\\cs('..formatRGB(r_c1.r)..','..formatRGB(r_c1.g)..','..formatRGB(r_c1.b)..')'..r_1..'\\cr'
		local r_1_t_shdw = '\\cs(000,000,000)'..r_1..'\\cr'
		local r_2_t = '\\cs('..formatRGB(r_c2.r)..','..formatRGB(r_c2.g)..','..formatRGB(r_c2.b)..')'..r_2..'\\cr'
		local r_2_t_shdw = '\\cs(000,000,000)'..r_2..'\\cr'
		local r_3_t = '\\cs('..formatRGB(r_c3.r)..','..formatRGB(r_c3.g)..','..formatRGB(r_c3.b)..')'..r_3..'\\cr'
		local r_3_t_shdw = '\\cs(000,000,000)'..r_3..'\\cr'
		local r_4_t = '\\cs('..formatRGB(r_c4.r)..','..formatRGB(r_c4.g)..','..formatRGB(r_c4.b)..')'..r_4..'\\cr'
		local r_4_t_shdw = '\\cs(000,000,000)'..r_4..'\\cr'
		local r_5_t = '\\cs('..formatRGB(r_c5.r)..','..formatRGB(r_c5.g)..','..formatRGB(r_c5.b)..')'..r_5..'\\cr'
		local r_5_t_shdw = '\\cs(000,000,000)'..r_5..'\\cr'
		local r_6_t = '\\cs('..formatRGB(r_c6.r)..','..formatRGB(r_c6.g)..','..formatRGB(r_c6.b)..')'..r_6..'\\cr'
		local r_6_t_shdw = '\\cs(000,000,000)'..r_6..'\\cr'
		local r_7_t = '\\cs('..formatRGB(r_c7.r)..','..formatRGB(r_c7.g)..','..formatRGB(r_c7.b)..')'..r_7..'\\cr'
		local r_7_t_shdw = '\\cs(000,000,000)'..r_7..'\\cr'
		local r_8_t = '\\cs('..formatRGB(r_c8.r)..','..formatRGB(r_c8.g)..','..formatRGB(r_c8.b)..')'..r_8..'\\cr'
		local r_8_t_shdw = '\\cs(000,000,000)'..r_8..'\\cr'
		local r_9_t = '\\cs('..formatRGB(r_c9.r)..','..formatRGB(r_c9.g)..','..formatRGB(r_c9.b)..')'..r_9..'\\cr'
		local r_9_t_shdw = '\\cs(000,000,000)'..r_9..'\\cr'
		local r_10_t = '\\cs('..formatRGB(r_c10.r)..','..formatRGB(r_c10.g)..','..formatRGB(r_c10.b)..')'..r_10..'\\cr'
		local r_10_t_shdw = '\\cs(000,000,000)'..r_10..'\\cr'
		local r_11_t = '\\cs('..formatRGB(r_c11.r)..','..formatRGB(r_c11.g)..','..formatRGB(r_c11.b)..')'..r_11..'\\cr'
		local r_11_t_shdw = '\\cs(000,000,000)'..r_11..'\\cr'

		local pad = string.rep(" ", 36 - math.floor((#roll_name + 27) / 2)) 

		--Display the new roll info
		hud_roll:text(pad..roll_name..' ('..r_1_t..r_2_t..r_3_t..r_4_t..r_5_t..r_6_t..r_7_t..r_8_t..r_9_t..r_10_t..r_11_t..')')
		hud_roll_shdw:text(pad..roll_name..' ('..r_1_t_shdw..r_2_t_shdw..r_3_t_shdw..r_4_t_shdw..r_5_t_shdw..r_6_t_shdw..r_7_t_shdw..r_8_t_shdw..r_9_t_shdw..r_10_t_shdw..r_11_t_shdw..')')

		hud_roll_bg:bg_color(bg_color.r,bg_color.g,bg_color.b)

	end

	hud_roll:show()
	hud_roll_shdw:show()
	hud_roll_bg:show()

end

function updateAmmo()

	-- Determine if we should show the ammo count
	local show = not (hud_roll:visible() or InCS or Zoning)

	if show and not hud_ammo:visible() then
		hud_ammo:show()
		hud_ammo_shdw:show()
		hud_ammo_bg:show()
	elseif not show and hud_ammo:visible() then
		hud_ammo:hide()
		hud_ammo_shdw:hide()
		hud_ammo_bg:hide()
		return
	elseif not show then
		return
	end

	-- Count the number of given item and return the number and the color
	local function countItem(item_id)

		if not item_id then
			return nil, color.ammo.empty
		end

		local items = windower.ffxi.get_items()
		local locations = {items.inventory, items.wardrobe, items.wardrobe2, items.wardrobe3, items.wardrobe4, items.wardrobe5, items.wardrobe6, items.wardrobe7, items.wardrobe8}
		local num = 0
		local c = color.ammo.empty

		-- Iterate through each location
		for _, location in ipairs(locations) do
			-- Find the item and add to the count if found
			for _, item in ipairs(location) do
				if item.id == item_id then
					num = num + item.count
				end
			end
		end

		-- Determine the color based on the count / stack
		if num <= LowAmmoNum then
			low_ammo = true
			c = color.ammo.low
		elseif num ~= 0 then
			low_ammo = false
			c = color.ammo.good
		end
		num = string.format("%2s", num)

		return num, c

	end

	-- Find the id of an item based on its name
	local function getIdFromName(item_name)
		for _, item in pairs(res.items) do
			if item.name == item_name then
				return item.id --match found
			end
		end
		return false --no match found
	end

	local ammo_name = player.equipment.ammo
	local ammo_id = ammo_name and getIdFromName(ammo_name)
	local ammo_count, ammo_color = countItem(ammo_id)
	local text_ammo = ammo_name and ammo_name..(ammo_count and " - "..ammo_count or "") or "No Ammo Loaded"
	local pad_ammo = string.rep(" ", 12 - math.floor(#text_ammo / 2))

	text_ammo = pad_ammo..text_ammo

	hud_ammo:text(text_ammo)
	hud_ammo_shdw:text(text_ammo)
	hud_ammo_bg:bg_color(ammo_color.r,ammo_color.g,ammo_color.b)

end
updateAmmo()

local function checkAmmo()

	local ammo = player.equipment.ammo
	if not buffactive["Unlimited Shot"] and rare_ex_bullets[ammo] then
		cancel_spell()
		if notifications.NoAmmo then
			hud_noti_shdw:text('«« Rare/EX Ammo Loaded »»')
			hud_noti:text('«« Rare/EX Ammo Loaded »»')
			hud_noti:color(255,50,50)
			flash('Noti')
			NotiCountdown = -1
		end
		local bullet = Mode == 'Mode3' and sets.ranged_accuracy_bullet.ammo or sets.ranged_attack_bullet.ammo
		equip({ammo=bullet})
		return
	end

end

local function useHachirinNoObi(ws)
	local ws_elements = {
		["Gust Slash"] = "Wind",
		["Cyclone"] = "Wind",
		["Aeolian Edge"] = "Wind",
		["Hot Shot"] = "Fire",
		["Leaden Salute"] = "Dark",
		["Wildfire"] = "Fire",
		["Burning Blade"] = "Fire",
		["Shining Blade"] = "Light",
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
	local weather_intensity = world.weather_intensity

	local bonus = 0
	local penalty = 0

	if day == element then
		bonus = bonus + 10
	end
	if weather == element then
		bonus = bonus + (weather_intensity == 2 and 25 or 10)
	end

	local oppose = opposites[element]
	if day == oppose then
		penalty = penalty + 10
	end
	if weather == oppose then
		penalty = penalty + (weather_intensity == 2 and 25 or 10)
	end

	return bonus > penalty
end

-------------------------------------------
--            SELF COMMANDS              --
-------------------------------------------

function self_command(command)
	if command == 'DT' then
		DTOverride = not DTOverride
		choose_set()
	elseif command == 'Luzaf' then
		LuzafsRing = not LuzafsRing
		local status = LuzafsRing and 'Active' or 'Deactivated'
		hud_noti_shdw:text("Luzaf's Ring "..status)
		hud_noti:text("Luzaf's Ring "..status)
		NotiCountdown = NotiDelay
	elseif command == 'Mode' then
		if Mode == 'Mode1' then
			Mode = 'Mode2'
		elseif Mode == 'Mode2' then
			Mode = 'Mode3'
		elseif Mode == 'Mode3' then
			Mode = 'Mode1'
		end
		hud_mode_shdw:text('Mode: '..modeName[Mode]..' ('..EquipRange..')')
		hud_mode:text('Mode: '..modeName[Mode]..' ('..EquipRange..')')
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
		elseif buffactive['weakness'] and DTOverride then
			hud_noti_shdw:text('Status: Weakness (DT Override)')
			hud_noti:text('Status: Weakness (DT Override)')
			hud_noti:color(205,133,63)
		elseif buffactive['weakness'] then
			hud_noti_shdw:text('Status: Weakness')
			hud_noti:text('Status: Weakness')
			hud_noti:color(205,133,63)
		elseif subJobWithMP() and player.mpp <= 20 then
			hud_noti_shdw:text('«« Low MP »»')
			hud_noti:text('«« Low MP »»')
			hud_noti:color(255,50,50)
		elseif player.status == "Resting" and DTOverride then
			hud_noti_shdw:text('Status: Resting (DT Override)')
			hud_noti:text('Status: Resting (DT Override)')
			hud_noti:color(255,255,255)
		elseif player.status == "Resting" then
			hud_noti_shdw:text('Status: Resting')
			hud_noti:text('Status: Resting')
			hud_noti:color(255,255,255)
		elseif player.status == "Engaged" and DTOverride then
			hud_noti_shdw:text('Status: Engaged (DT Override)')
			hud_noti:text('Status: Engaged (DT Override)')
			hud_noti:color(255,255,255)
		elseif player.status == "Engaged" then
			hud_noti_shdw:text('Status: Engaged')
			hud_noti:text('Status: Engaged')
			hud_noti:color(255,255,255)
		elseif player.status == "Idle" and DTOverride then
			hud_noti_shdw:text('Status: Idle (DT Override)')
			hud_noti:text('Status: Idle (DT Override)')
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
		if buffactive['Double-Up Chance'] then
			hud_roll_bg:show()
			hud_roll_shdw:show()
			hud_roll:show()
		else
			hud_roll_1_bg:show()
			hud_roll_2_bg:show()
			hud_ammo_bg:show()
			hud_roll_1_shdw:show()
			hud_roll_2_shdw:show()
			hud_ammo_shdw:show()
			hud_roll_1:show()
			hud_roll_2:show()
			hud_ammo:show()
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
		hud_roll_bg:hide()
		hud_roll_1_bg:hide()
		hud_roll_2_bg:hide()
		hud_ammo_bg:hide()
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
		hud_roll_shdw:hide()
		hud_roll_1_shdw:hide()
		hud_roll_2_shdw:hide()
		hud_ammo_shdw:hide()
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
		hud_roll:hide()
		hud_roll_1:hide()
		hud_roll_2:hide()
		hud_ammo:hide()
		hud_abil01:hide()
		hud_abil02:hide()
		hud_abil03:hide()
		hud_abil04:hide()
		hud_abil05:hide()
		hud_abil06:hide()
	elseif command == 'WC' then
		CurrentEquip = ''
		local cycle = getWeaponCycle()
		pair = cycle[WeaponCycleIndex]
		if not pair then
			WeaponCycleIndex = 1
			pair = cycle[WeaponCycleIndex]
		end
		equip(pair)
		-- HUD display
		SwitchingWeapons = 2
		local main_name = type(pair.main) == 'table' and pair.main.name or pair.main
		local sub_name  = type(pair.sub)  == 'table' and pair.sub.name  or pair.sub
		if not pair.sub or pair.sub == empty then
			hud_weapons_shdw:text(formatWeapons(main_name))
			hud_weapons:text(formatWeapons(main_name))
		else
			hud_weapons_shdw:text(formatWeapons(main_name .. ' & ' .. sub_name))
			hud_weapons:text(formatWeapons(main_name .. ' & ' .. sub_name))
		end
		WeaponCycleIndex = WeaponCycleIndex + 1
	elseif command == "RC" then
		ranged_weapon = RangedCycle[RangedCycleIndex]
		if ranged_weapon == nil then
			RangedCycleIndex = 1
			ranged_weapon = RangedCycle[RangedCycleIndex]
		end
		SwitchingWeapons = 2
		hud_mode_shdw:text('Mode: '..modeName[Mode]..' ('..ranged_weapon..')')
		hud_mode:text('Mode: '..modeName[Mode]..' ('..ranged_weapon..')')
		equip({range=ranged_weapon})
		RangedCycleIndex = RangedCycleIndex + 1
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
	elseif command == 'Flash_Ammo_A' then
		hud_ammo_bg:bg_alpha(0)
		-- local c = color.abil.flash
		-- hud_ammo_bg:bg_color(c.r,c.g,c.b)
	elseif command == 'Flash_Ammo_B' then
		hud_ammo_bg:bg_alpha(125)
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
			elseif buffactive['weakness'] and DTOverride then
				hud_noti_shdw:text('Status: Weakness (DT Override)')
				hud_noti:text('Status: Weakness (DT Override)')
				hud_noti:color(205,133,63)
			elseif buffactive['weakness'] then
				hud_noti_shdw:text('Status: Weakness')
				hud_noti:text('Status: Weakness')
				hud_noti:color(205,133,63)
			elseif subJobWithMP() and player.mpp <= 20 then
				hud_noti_shdw:text('«« Low MP »»')
				hud_noti:text('«« Low MP »»')
				hud_noti:color(255,50,50)
			elseif DTOverride then
				hud_noti_shdw:text('Status: Resting (DT Override)')
				hud_noti:text('Status: Resting (DT Override)')
				hud_noti:color(255,255,255)
			else
				hud_noti_shdw:text('Status: Resting')
				hud_noti:text('Status: Resting')
				hud_noti:color(255,255,255)
			end
		end
		local dt_override = DTOverride and sets.dt_override or nil
		equip(set_combine(sets.idle, sets.rest, dt_override))
	elseif player.status == "Engaged" then
		if GreetingDelay == -1 then
			if LowHP then
				hud_noti_shdw:text('«« Low HP »»')
				hud_noti:text('«« Low HP »»')
				hud_noti:color(255,50,50)
			elseif buffactive['weakness'] and DTOverride then
				hud_noti_shdw:text('Status: Weak (DT Override)')
				hud_noti:text('Status: Weak (DT Override)')
				hud_noti:color(205,133,63)
			elseif buffactive['weakness'] then
				hud_noti_shdw:text('Status: Weakness')
				hud_noti:text('Status: Weakness')
				hud_noti:color(205,133,63)
			elseif subJobWithMP() and player.mpp <= 20 then
				hud_noti_shdw:text('«« Low MP »»')
				hud_noti:text('«« Low MP »»')
				hud_noti:color(255,50,50)
			elseif DTOverride then
				hud_noti_shdw:text('Status: Engaged (DT Override)')
				hud_noti:text('Status: Engaged (DT Override)')
				hud_noti:color(255,255,255)
			else
				hud_noti_shdw:text('Status: Engaged')
				hud_noti:text('Status: Engaged')
				hud_noti:color(255,255,255)
			end
		end
		local base_set = dualWield() and sets[Mode].dual_wield or sets[Mode]
		local dt_override = DTOverride and sets.dt_override or nil
		local low_hp = LowHP and sets.oh_shit or nil
		equip(set_combine(base_set, dt_override, {main = pair.main, sub = pair.sub}))
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
			elseif buffactive['weakness'] and DTOverride then
				hud_noti_shdw:text('Status: Weakness (DT Override)')
				hud_noti:text('Status: Weakness (DT Override)')
				hud_noti:color(205,133,63)
			elseif buffactive['weakness'] then
				hud_noti_shdw:text('Status: Weakness')
				hud_noti:text('Status: Weakness')
				hud_noti:color(205,133,63)
			elseif subJobWithMP() and player.mpp <= 20 then
				hud_noti_shdw:text('«« Low MP »»')
				hud_noti:text('«« Low MP »»')
				hud_noti:color(205,133,63)
			elseif DTOverride then
				hud_noti_shdw:text('Status: Idle (DT Override)')
				hud_noti:text('Status: Idle (DT Override)')
				hud_noti:color(255,255,255)
			else
				hud_noti_shdw:text('Status: Idle')
				hud_noti:text('Status: Idle')
				hud_noti:color(255,255,255)
			end
		end
		if AdoulinZones:contains(world.area) then
			equip(set_combine(sets.adoulin, sets.movement_speed))
		elseif BastokZones:contains(world.area) then
			equip(set_combine(sets.bastok, sets.movement_speed))
		elseif SandyZones:contains(world.area) then
			equip(set_combine(sets.sandoria, sets.movement_speed))
		elseif WindyZones:contains(world.area) then
			equip(set_combine(sets.windurst, sets.movement_speed))
		elseif TownZones:contains(world.area) or windower.ffxi.get_info().mog_house then
			equip(set_combine(sets.town, sets.movement_speed))
		else
			local dt_override = DTOverride and sets.dt_override or nil
			local low_hp = LowHP and sets.oh_shit or nil
			equip(set_combine(sets.idle, dt_override, low_hp))
		end
	end
	local bullet = Mode == 'Mode3' and sets.ranged_accuracy_bullet.ammo or sets.ranged_attack_bullet.ammo
	equip({ammo=bullet})
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
		end
		local ws_set = sets[spell.english]
		local base_set = ws_set and (player.attack >= AttackCapThreshold and ws_set.high_buff or ws_set) or sets.weapon_skill
		local hachirin_no_obi = useHachirinNoObi(spell.english) and sets.hachirin_no_obi or nil
		local accuracy_set = Mode == Mode3 and sets.ws_accuracy or nil
		equip(set_combine(base_set, hachirin_no_obi, accuracy_set))
		if spell.skill == 'Marksmanship' then
			checkAmmo()
		end
		if player.equipment.range == "Fomalhaut" and spell.english == "Last Stand" then
			pre_AMTimer = 181
		elseif player.equipment.range == 'Armageddon' and spell.english == "Wildfire" then
			player_tp = player.tp
			TP_Window_Open = true
			empyreanAMUpdate(player_tp)
		elseif player.equipment.range == "Death Penalty" and spell.english == "Leaden Salute" then
			player_tp = player.tp
			TP_Window_Open = true
			mythicAMUpdate(player_tp)
		elseif player.equipment.range == 'Earp' and spell.english == "Terminus" then
			player_tp = player.tp
			TP_Window_Open = true
			primeAMUpdate(player_tp)
		end
	elseif spell.english == 'Wild Card' and WildCard.recast < 2 then
		equip(sets.wild_card)
	elseif spell.type == 'CorsairRoll' then
		if AutoDoubleUp and buffactive['Double-Up Chance'] and current_roll == spell.english then
			send_command('input /ja "Double-Up" <me>')
			cancel_spell()
		elseif PhantomRoll.recast < 2 then
			local use_mainsub = player.tp <= KeepTPThreshold
			local luzafs_ring = LuzafsRing and sets.luzafs_ring or nil
			local main_sub = use_mainsub and {main=nil, sub=nil} or {main="", sub=""}
			equip(set_combine(sets.phantom_roll, luzafs_ring, main_sub))
		end
	elseif spell.english == 'Double-Up' and DoubleUp.recast < 2 then
		local luzafs_ring = LuzafsRing and sets.luzafs_ring or nil
		equip(set_combine(sets.double_up, luzafs_ring))
	elseif spell.type == 'CorsairShot' then
		local base_set = (spell.english == 'Light Shot' or spell.english == 'Dark Shot') and sets.light_dark_shot or sets.quick_draw
		equip(base_set)
	elseif spell.english == 'Random Deal' then
		equip(sets.random_deal)
	elseif spell.english == 'Snake Eye' then
		equip(sets.snake_eye)
	elseif spell.english == 'Fold' then
		equip(sets.fold)
	elseif spell.english == 'Quickstep' or string.find(spell.english,'Step') then
		equip(sets.steps)
	elseif string.find(spell.english,'Waltz') then
		equip(sets.waltzes)
	elseif spell.english == 'Animated Flourish' then
		equip(sets.animated_flourish)
	elseif spell.english == 'Violent Flourish' then
		equip(sets.violent_flourish)
	elseif spell.english == 'Holy Water' then
		equip(sets.holy_water)
	elseif (spell.english == 'Spectral Jig' or spell.english == 'Sneak' or spell.english == 'Monomi: Ichi' or spell.english == 'Monomi: Ni') and buffactive['Sneak'] and spell.target.type == 'SELF' then
		send_command('cancel 71')
		if spell.english ~= 'Spectral Jig' then
			equip(sets.fast_cast_other)
		end
	elseif spell.english == 'Stoneskin' and buffactive['Stoneskin'] then
		send_command('cancel 37')
		equip(sets.fast_cast_other)
	elseif spell.action_type == 'Ranged Attack' then
		local base_set = buffactive["Flurry"] and sets.rapid_shot or sets.snapshot
		local bullet = Mode == 'Mode3' and sets.ranged_accuracy_bullet or sets.ranged_attack_bullet
		equip(set_combine(base_set, bullet))
		checkAmmo()
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
	elseif spell.action_type == 'Magic' then
		equip(sets.magic)
	elseif spell.action_type == 'Ranged Attack' then
		local base_set = Mode == 'Mode3' and sets.ranged_accuracy or sets.ranged_attack
		local triple_shot = buffactive['Triple Shot'] and sets.triple_shot or nil
		local armageddon_am = player.equipment.range == 'Armageddon'
		and (buffactive['Aftermath: Lv.1'] or buffactive['Aftermath: Lv.2'] or buffactive['Aftermath: Lv.3']) and sets.armageddon_am or nil
		equip(set_combine(base_set, triple_shot, armageddon_am))
	end

end

-------------------------------------------
--              AFTERCAST                --
-------------------------------------------

function aftercast(spell)

	if (spell.english == 'Super Jump' or spell.english == 'High Jump') and not spell.interrupted and player.hp <= AutoSaveThreshold then
		AutoSaveUsed = true
	elseif spell.english == 'Snake Eye' then
		local act = nil
		local double_up = false
		local snake_eye = true
		displayRollInfo(act, double_up, snake_eye)
	elseif spell.type == 'CorsairRoll' and current_roll ~= spell.english and not spell.interrupted then
		DoubleUp.timer = 45
		current_roll = spell.english
		current_roll_timer = getRollDuration()
	elseif spell.english == 'Crooked Cards' then
		next_roll_is_crooked = true
	end

	choose_set()

	local bullet = Mode == 'Mode3' and sets.ranged_accuracy_bullet.ammo or sets.ranged_attack_bullet.ammo
	equip({ammo=bullet})

end

-------------------------------------------
--             STATUS CHANGE             --
-------------------------------------------

windower.register_event('status change', function(status)
	if status == 4 and not InCS then
		InCS = true
		if ShowHUD then --In a cutscene: Hide the HUD
			windower.send_command('gs c HideHUD')
		end
	elseif status ~= 4 and InCS then
		InCS = false
		if ShowHUD then --Out of cutscene: Show the HUD
			windower.send_command('gs c ShowHUD')
		end
	end
	choose_set() --run this any time your status changes (engage, disengage, rest)
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
	elseif (buff == 2 or buff == 19) then
		if buffactive['Stoneskin'] and not buffactive['charm'] then --If we get slept, remove stoneskin if its up
			send_command('cancel 37')
		end
		equip(sets.oh_shit)
	elseif buff == 7 or buff == 10 or buff == 28 then --If we get petrified, stunned, or terrored, then equip the Oh Shit set
		equip(sets.oh_shit)
	elseif buff == 15 then --Doom
		DangerCountdown = DangerRepeat --Start the Danger Sound going
	elseif buff == 17 and AlertSounds then --Charm
		play_sound(Notification_Cancel)
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
	elseif buff == 308 and not bust_pause then --Double-Up Chance
		DoubleUp.timer = 0 --Set to 0 to turn the Double-Up timer off when we lose Double-Up Chance
		current_roll = nil
		displayCurrentRolls()
	elseif roll_1_id and buffs[buff].english == job_abilities[roll_1_id].english and not bust_pause then
		roll_1_id = roll_2_id
		roll_1_total = roll_2_total
		roll_1_crooked = roll_2_crooked
		roll_2_id = nil
		roll_2_total = nil
		roll_2_crooked = false
		updateCurrentRolls()
	elseif roll_2_id and buffs[buff].english == job_abilities[roll_2_id].english and not bust_pause then
		roll_2_id = nil
		roll_2_total = nil
		roll_2_crooked = false
		updateCurrentRolls()
	end
end)

windower.register_event('tp change',function()
	if player.tp == 3000 and notifications.TP3000 then
		if AlertSounds then
			play_sound(Notification_3000TP)
		end
		hud_noti_shdw:text('«« 3000 TP »»')
		hud_noti:text('«« 3000 TP »»')
		hud_noti:color(255,255,50)
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
		if player.equipment.range == 'Armageddon' then
			empyreanAMUpdate(player_tp)
		elseif player.equipment.range == "Death Penalty" then
			mythicAMUpdate(player_tp)
		elseif player.equipment.range == 'Earp' then
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
			if HighJump.recast and HighJump.recast == 0 then
				send_command('input /ja "High Jump" <t>')
			end
		end

		updateAmmo()
		updateCurrentRolls()

		--Zoning: hide HUD
		local pos = windower.ffxi.get_position()
		if pos == "(?-?)" and not Zoning then
			Zoning = true
			if ShowHUD then
				send_command('gs c HideHUD')
			end
		elseif pos ~= "(?-?)" and Zoning then
			Zoning = false
			if ShowHUD then
				send_command('gs c ShowHUD')
			end
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
			if player.equipment.range == 'Earp' then
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
			elseif player.equipment.range == 'Armageddon' then
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
			elseif player.equipment.range == 'Death Penalty' then
				if buffactive['Aftermath: Lv.1'] then
					if currentAfterMath ~= 'MythicAM1' or mythicNum ~= currentMythicNum or currentAMTimer ~= AMTimer then
						currentAfterMath = 'MythicAM1'
						currentMythicNum = mythicNum
						currentAMTimer = AMTimer
						local am_time = formatAMTime(currentAMTimer)
						hud_weapons_shdw:text(formatWeapons('AM1: (Ranged Acc. +'..mythicNum..') '..am_time))
						hud_weapons:text(formatWeapons('AM1: (Ranged Acc. +'..mythicNum..') '..am_time))
						colorWeaponsText(1)
					end
				elseif buffactive['Aftermath: Lv.2'] then
					if currentAfterMath ~= 'MythicAM2' or currentAMTimer ~= AMTimer then
						currentAfterMath = 'MythicAM2'
						currentAMTimer = AMTimer
						local am_time = formatAMTime(currentAMTimer)
						hud_weapons_shdw:text(formatWeapons('AM2: (Ranged Att. +'..mythicNum..') '..am_time))
						hud_weapons:text(formatWeapons('AM2: (Ranged Att. +'..mythicNum..') '..am_time))
						colorWeaponsText(2)
					end
				elseif buffactive['Aftermath: Lv.3'] then
					if currentAfterMath ~= 'MythicAM3' or currentAMTimer ~= AMTimer then
						currentAfterMath = 'MythicAM3'
						currentAMTimer = AMTimer
						local am_time = formatAMTime(currentAMTimer)
						hud_weapons_shdw:text(formatWeapons('AM3: (Occ. 2-3x Damage) '..am_time))
						hud_weapons:text(formatWeapons('AM3: (Occ. 2-3x Damage) '..am_time))
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
			elseif player.equipment.range == 'Fomalhaut' then
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
				hud_weapons_shdw:text(formatWeapons(EquipMain..EquipSub))
				hud_weapons:text(formatWeapons(EquipMain..EquipSub))
				colorWeaponsText()
			end
			if current_ranged ~= EquipRange and SwitchingWeapons == 0 then
				current_ranged = EquipRange
				hud_mode_shdw:text('Mode: '..modeName[Mode]..' ('..EquipRange..')')
				hud_mode:text('Mode: '..modeName[Mode]..' ('..EquipRange..')')
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
				if buffactive['amneisa'] then
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

		--MP checks
		if notifications.LowMP and subJobWithMP() and player and player.mpp <= 20 and not NotiLowMPToggle then
			NotiLowMPToggle = true --turn the toggle on so this can't be triggered again until its toggled off (done below)
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

		-- First time QD is used it sets the recast timer for a single QD charge
		if not get_qd_timer and qd_charge_timer == 0 and QuickDraw.recast and QuickDraw.recast == 0 then
			get_qd_timer = true
		elseif get_qd_timer and qd_charge_timer == 0 and QuickDraw.recast and QuickDraw.recast > 0 then
			qd_charge_timer = QuickDraw.recast + 1 --add 1 second because the recast timer updates the first second after it starts
		end

		-- Recast updates
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
		if player.equipment.range == nil then
			EquipRange = 'Ranged loading...'
		else
			EquipRange = player.equipment.range
		end

		--Recast color updates
		if WildCard.recast then
			if buffactive['Wild Card'] then
				textColor('Wild Card','active')
				WildCard.flashed = false
			elseif WildCard.recast > 0 then
				textColor('Wild Card','cooldown')
				WildCard.flashed = false
			else
				textColor('Wild Card','ready')
				if not WildCard.flashed then
					flash('Wild Card')
				end
				WildCard.flashed = true
			end
		else
			textColor('Wild Card','notfound')
		end

		if CuttingCards.recast then
			if buffactive['Cutting Cards'] then
				textColor('Cutting Cards','active')
				CuttingCards.flashed = false
			elseif CuttingCards.recast > 0 then
				textColor('Cutting Cards','cooldown')
				CuttingCards.flashed = false
			else
				textColor('Cutting Cards','ready')
				if not CuttingCards.flashed then
					flash('Cutting Cards')
				end
				CuttingCards.flashed = true
			end
		else
			textColor('Cutting Cards','notfound')
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

		if CrookedCards.recast then
			if buffactive['Crooked Cards'] then
				textColor('Crooked Cards','active')
				CrookedCards.flashed = false
			elseif CrookedCards.recast > 0 then
				textColor('Crooked Cards','cooldown')
				CrookedCards.flashed = false
			else
				textColor('Crooked Cards','ready')
				if not CrookedCards.flashed then
					flash('Crooked Cards')
				end
				CrookedCards.flashed = true
			end
		else
			textColor('Crooked Cards','notfound')
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

		if Fold.recast then
			if Fold.recast > 0 then
				textColor('Fold','cooldown')
				Fold.flashed = false
			else
				textColor('Fold','ready')
				if not Fold.flashed then
					flash('Fold')
				end
				Fold.flashed = true
			end
		else
			textColor('Fold','notfound')
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

		if PhantomRoll.recast then
			if DoubleUp.recast > 0 then
				textColor('Phantom Roll','cooldown')
				PhantomRoll.flashed = false
			elseif buffactive['Double-Up Chance'] then
				textColor('Phantom Roll','active')
				PhantomRoll.flashed = false
			elseif PhantomRoll.recast > 0 then
				textColor('Phantom Roll','cooldown')
				PhantomRoll.flashed = false
			elseif PhantomRoll.recast == 0 then
				textColor('Phantom Roll','ready')
				if not PhantomRoll.flashed then
					flash('Phantom Roll')
				end
				PhantomRoll.flashed = true
			end
		else
			textColor('Phantom Roll','notfound')
		end

		if QuickDraw.recast then
			if qd_charges == 0 then
				textColor('Quick Draw','cooldown')
				QuickDraw.flashed_charge_1 = false
				QuickDraw.flashed_charge_2 = false
			elseif qd_charges == 1 then
				textColor('Quick Draw','ready')
				if not QuickDraw.flashed_charge_1 then
					flash('Quick Draw')
				end
				QuickDraw.flashed_charge_1 = true
			elseif qd_charges == 2 then
				textColor('Quick Draw','ready')
				if not QuickDraw.flashed_charge_2 then
					flash('Quick Draw')
				end
				QuickDraw.flashed_charge_2 = true
			end
		else
			textColor('Quick Draw','notfound')
		end

		if RandomDeal.recast then
			if RandomDeal.recast > 0 then
				textColor('Random Deal','cooldown')
				RandomDeal.flashed = false
			else
				textColor('Random Deal','ready')
				if not RandomDeal.flashed then
					flash('Random Deal')
				end
				RandomDeal.flashed = true
			end
		else
			textColor('Random Deal','notfound')
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

		if SnakeEye.recast then
			if buffactive['Snake Eye'] then
				textColor('Snake Eye','active')
				SnakeEye.flashed = false
			elseif SnakeEye.recast > 0 then
				textColor('Snake Eye','cooldown')
				SnakeEye.flashed = false
			else
				textColor('Snake Eye','ready')
				if not SnakeEye.flashed then
					flash('Snake Eye')
				end
				SnakeEye.flashed = true
			end
		else
			textColor('Snake Eye','notfound')
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

		if TripleShot.recast then
			if buffactive['Triple Shot'] then
				textColor('Triple Shot','active')
				TripleShot.flashed = false
			elseif TripleShot.recast > 0 then
				textColor('Triple Shot','cooldown')
				TripleShot.flashed = false
			else
				textColor('Triple Shot','ready')
				if not TripleShot.flashed then
					flash('Triple Shot')
				end
				TripleShot.flashed = true
			end
		else
			textColor('Triple Shot','notfound')
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

		if DoubleUp.timer > 0 then
			DoubleUp.timer = DoubleUp.timer - 1
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

		if set_weapon_timestamp > 0 and os.time() >= set_weapon_timestamp then
			set_weapon_timestamp = 0
			setWeaponPair()
		end

		if roll_1_timer and roll_1_timer >= 1 then
			roll_1_timer = roll_1_timer - 1
		end
		if roll_2_timer and roll_2_timer >= 1 then
			roll_2_timer = roll_2_timer - 1
		end

		if low_ammo then
			flash('Ammo')
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

	--Clear any rolls
	roll_1_id = nil
	roll_2_id = nil
	roll_1_total = nil
	roll_2_total = nil
	roll_1_timer = nil
	roll_2_timer = nil
	displayCurrentRolls()

	--Update in case we just recently spent more JPs
	getJPsAndMerits()

end)

-------------------------------------------
--           SUB JOB CHANGE              --
-------------------------------------------

function sub_job_change(newSubjob, oldSubjob)

	if GreetingDelay == -1 then
		send_command('gs c ClearNotifications')
	end

	-- Reset HUD Abilities/Spells and Macro Page
	if newSubjob == 'DNC' then
		subjob = 'DNC'
		if SubDNCPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubDNCPage)
		end
	elseif newSubjob == 'DRG' then
		subjob = 'DRG'
		if SubDRGPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubDRGPage)
		end
	elseif newSubjob == 'DRK' then
		subjob = 'DRK'
		if SubDRKPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubDRKPage)
		end
	elseif newSubjob == 'NIN' then
		subjob = 'NIN'
		if SubNINPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubNINPage)
		end
	elseif newSubjob == 'RNG' then
		subjob = 'RNG'
		if SubRNGPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubRNGPage)
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

	--Set/reset a timer to set the weapons again
	set_weapon_timestamp = os.time() + 6

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

	local msg = act.targets[1].actions[1].message

	if notifications.Damage then
		--Weapon Skills and Skillchains:
		if act.category == 3 and act.actor_id == player.id then
			local ws_name = weaponskills[act.param].english
			local ws_dmg = act.targets[1].actions[1].param
			--Weapon Skill misses:
			if msg == 188 then
				hud_noti_shdw:text('«« '..ws_name..' Missed »»')
				hud_noti:text('«« '..ws_name..' Missed »»')
				hud_noti:color(0,255,255)
			--Weapon Skill gets blinked:
			elseif msg == 31 then
				hud_noti_shdw:text('«« '..ws_name..' Blinked »»')
				hud_noti:text('«« '..ws_name..' Blinked »»')
				hud_noti:color(0,255,255)
			--Weapon Skill lands and creates a Skillchain:
			elseif msg == 185 and act.targets[1].actions[1].has_add_effect then
				local sc_name = sc[act.targets[1].actions[1].add_effect_animation]
				local sc_dmg = act.targets[1].actions[1].add_effect_param
				hud_noti_shdw:text(ws_name..': '..addCommas(ws_dmg)..' ('..sc_name..': '..addCommas(sc_dmg)..')')
				hud_noti:text(ws_name..': '..addCommas(ws_dmg)..' ('..sc_name..': '..addCommas(sc_dmg)..')')
				hud_noti:color(0,255,255)
			--Weapon Skill lands but no Skillchain:
			elseif msg == 185 then
				hud_noti_shdw:text(ws_name..': '..addCommas(ws_dmg))
				hud_noti:text(ws_name..': '..addCommas(ws_dmg))
				hud_noti:color(0,255,255)
			end
			NotiCountdown = -1
		--Magic Bursts:
		elseif (act.category == 4 and msg == 252) and act.actor_id == player.id then
			local spell_name = spells[act.param].english
			local spell_dmg = act.targets[1].actions[1].param
			hud_noti_shdw:text('Magic Burst! '..spell_name..': '..addCommas(spell_dmg))
			hud_noti:text('Magic Burst! '..spell_name..': '..addCommas(spell_dmg))
			hud_noti:color(0,255,255)
			NotiCountdown = -1
		end
	end

	--Phantom Roll/Double Up/Bust:
	if act.category == 6 and (msg == 420 or msg == 424 or msg == 426) and act.actor_id == player.id then
		local double_up = msg == 424
		displayRollInfo(act, double_up)
	end

end)

-------------------------------------------
--             FILE UNLOAD               --
-------------------------------------------

function file_unload()

	--Delete our aliases and binds, thank you for your service
	send_command('unalias dt')
	send_command('unalias mode')
	send_command('unalias rc')
	send_command('unalias wc')
	send_command('unalias hud')
	send_command('unbind '..DTBind)
	send_command('unbind '..LuzafBind)
	send_command('unbind '..ModeBind)
	send_command('unbind '..RCBind)
	send_command('unbind '..WCBind)

end

--Handle mouse events
windower.register_event('mouse',function(mouse_type, mouse_x, mouse_y)

end)
