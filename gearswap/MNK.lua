-------------------------------------------
--    Keys Gearswap lua file for Monk    --
-------------------------------------------
--[[

REQUIRED Windower Addons: Text

Updates to this file and other GearSwap files and addons can be found at
https://github.com/iLVL-Key/FFXI

Place both this file and the sounds folder inside the GearSwap data folder
	/addons/GearSwap/data/sounds/
	/addons/GearSwap/data/MNK.lua

To switch between gear modes, use any of these three options:
1. A macro with the following in it
	/console mode
2. An alias command
	//mode
3. A keybind shortcut
	CTRL+G
	(Can be changed in the Advanced Options section)

To activate Damage Taken Override, use any of these three options:
1. A macro with the following
	/console DT
2. An alias command
	//dt
3. A keybind shortcut
	CTRL+D
	(Can be changed in the Advanced Options section)

To activate the Weapon Cycle, use any of these three options:
1. A macro with the following
	/console WC
2. An alias command
	//wc
3. A keybind shortcut
	CTRL+H
	(Can be changed in the Advanced Options section)

Run the Lockstyle function yourself at any time by typing
	//lockstyle or //lstyle

Hide or show the HUD at any time by typing
	//hud

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

AutoLockstyle	=	'On'	--[On/Off]		Automatically sets your lockstyle. Uses the Field and Town sets below.
LockstyleCombat	=	'8'		--[1-200]		Your Lockstyle set when in a field zone.
LockstyleTown	=	'1'		--[1-200]		Your Lockstyle set when in a town zone.
							--				If you do not want a separate town lockstyle, set this to the same as LockstyleCombat.
Book			=	'7'		--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
SubWARPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing WAR.
SubDRGPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing DRG.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
HFTimer			=	'On'	--[On/Off]		Displays a timer for Hundred Fists in echo.
ISTimer			=	'On'	--[On/Off]		Displays a timer for Inner Strength in echo.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions
							--				(Town limits this to town gear only)
AlertSounds		=	'On'	--[On/Off]		Plays a sound on alerts.
AutoHWater		=	'On'	--[On/Off]		Automatically attempts to use Holy Waters when you get Doomed until it wears off.
AutoSave		=	'On'	--[On/Off]		Attempts to use Chakra, Super Jump, High Jump, then Perfect Counter, in that order, when your HP gets critically low.
							--				Jumps will not activate while in Mode 4 (Tank).
DoomAlert		=	'On'	--[On/Off]		Alerts your party when you are doomed.
DoomOnText		=	'doom'			--		Text that displays in party chat when you are doomed. 
DoomOffText		=	'doom off'		--		That that displays in party chat when you are no longer doomed.

-- Heads Up Display --
HUDposX			=	100		--	X position for the HUD. 0 is left of the window, increasing this number will move it to the right.
HUDposY			=	100		--	Y position for the HUD. 0 is top of the window, increasing this number will move it downward.
FontSize		=	12		--	Adjust the font size. Changing this will require you to adjust the Spacers below as well.
LineSpacer		=	20		--	Space in pixels between each Line of the HUD
ColumnSpacer	=	93		--	Space in pixels between each Column of the HUD

--HUD Mode Names
Mode1Name = 'Multi-Attack'		--Names displayed in the HUD for Hasso Mode 1, 2, 3, and 4.
Mode2Name = 'High Accuracy'		--Change these as you see fit if you want to use them for different types of gear.
Mode3Name = 'Subtle Blow'		--NOTE: Mode 2 is the High Accuracy set which is linked to the Accuracy Weapon Skill set.
Mode4Name = 'Tank'				--(Using a weapon skill while in mode 2 will default to the Accuracy WS set instead of the standard WS set)

--  General Notifications  --
Noti3000TP			=	'On'	--[On/Off]	Displays a notification when you have 3000 TP.
NotiWeapons			=	'On'	--[On/Off]	Displays weapon information.
NotiTrade			=	'On'	--[On/Off]	Displays a notification when someone trades you.
NotiInvite			=	'On'	--[On/Off]	Displays a notification when someone invites to a party/alliance.
NotiSneak			=	'On'	--[On/Off]	Displays a notification when Sneak is about to wear off.
NotiInvis			=	'On'	--[On/Off]	Displays a notification when Invisible is about to wear off.
NotiReraise			=	'On'	--[On/Off]	Displays a notification when reraise wears off.
NotiFood			=	'On'	--[On/Off]	Displays a notification when food wears off.
NotiLowHP			=	'On'	--[On/Off]	Displays a notification when HP is low.
NotiDamage			=	'On'	--[On/Off]	Displays your Weapon Skill, Skillchain, Magic Burst, and Blood Pact damage.
ReraiseReminder		=	'On'	--[On/Off]	Displays an occasional reminder if Reraise is not up.
NotiTime			=	'On'	--[On/Off]	Displays a notification for time remaining notices.

-- Debuff Notifications --
NotiSleep			=	'On'	--[On/Off]	Displays a notification when you are slept.
NotiSilence			=	'Off'	--[On/Off]	Displays a notification when you are silenced.
NotiPetrification	=	'On'	--[On/Off]	Displays a notification when you are petrified.
NotiCurse			=	'On'	--[On/Off]	Displays a notification when you are cursed.
NotiStun			=	'On'	--[On/Off]	Displays a notification when you are stunned.
NotiCharm			=	'On'	--[On/Off]	Displays a notification when you are charmed.
NotiDoom			=	'On'	--[On/Off]	Displays a notification when you are doomed.
NotiAmnesia			=	'On'	--[On/Off]	Displays a notification when you have amnesia.
NotiTerror			=	'On'	--[On/Off]	Displays a notification when you are terrorized.
NotiMute			=	'Off'	--[On/Off]	Displays a notification when you are muted.
NotiPlague			=	'On'	--[On/Off]	Displays a notification when you are plagued.
NotiPara			=	'On'	--[On/Off]	Displays a notification when you are paralyzed.

-------------------------------------------
--           ADVANCED OPTIONS            --
-------------------------------------------

ShowHUD				=	true	--Initial state of the HUD. Use `//hud` to show/hide the HUD in game.
StartMode			=	'Mode1'	--[Mode1/Mode2/Mode3/Mode4]
								--	Determines the Mode you will start in. Current Mode can be changed at any time by using any
								--	of the three options listed above in the Notes section (a macro, alias, or keyboard shortcut).
ModeBind			=	'^g'	--Sets the keyboard shortcut you would like to cycle between Modes. CTRL+G (^g) is default.
DTBind				=	'^d'	--Sets the keyboard shortcut you would like to activate the Damage Taken Override. CTRL+D (^d) is default.
WCBind				=	'^h'	--Sets the keyboard shortcut you would like to activate the Weapon Cycle. CTRL+H (^h) is default.
								--    ^ = CTRL    ! = ALT    @ = WIN    # = APPS    ~ = SHIFT
LowHPThreshold		=	1000	--Below this number is considered Low HP.
AutoSaveThreshold	=	1000	--If your HP goes below this number, a "save" will be used.
CappedTPThreshold	=	2550	--Using a WS with this much TP or higher will use the Capped TP WS set instead.
DangerRepeat		=	10		--Maximum number of times the Danger Sound will repeat, once per second.
RRReminderTimer		=	1800	--Delay in seconds between checks to see if Reraise is up (300 is 5 minutes)
NotiDelay			=	6		--Delay in seconds before certain notifications will automatically clear.
HUDBGTrans			= 	'175'	--Background transparency for the HUD. (0 = fully clear, 255 = fully opaque)
AddCommas			=	'On'	--[On/Off]  Adds commas to damage numbers.
Debug				=	'Off'	--[On/Off]

--Color Values
Mode1color		=	'255 125 125'	--Mode 1
Mode2color		=	'125 125 255'	--Mode 2
Mode3color		=	'125 255 125'	--Mode 3
Mode4color		=	'255 255 125'	--Mode 4
Aftermath1color	=	'0 127 255'		--Aftermath Level 1
Aftermath2color	=	'75 255 75'		--Aftermath Level 2
Aftermath3color	=	'255 255 50'	--Aftermath Level 3

-------------------------------------------
--                WEAPONS                --
-------------------------------------------

-- These are the Main/Sub combos that the Weapon Cycle goes through. Add more pairs on new lines as needed
-- NOTE: if a slot should be empty, use `empty` with no quotation marks. ie: {"Fruit Punches", empty},
WeaponCycle = {
	{"Verethragna", empty},
	{"Spharai", empty},
	{"Godhands", empty},
	{"Xoanon", "Flanged Grip"},
	--{"Main Slot", "Sub Slot"},
}

-- These are the Main/Sub combos that get added to the Weapon Cycle while in Abyssea for Procs. Add more pairs on new lines as needed
-- NOTE: if a slot should be empty, use `empty` with no quotation marks. ie: {"Fruit Punches", empty},
AbysseaProcCycle = {
	--{"Hapy Staff", "Flanged Grip"},
	--{"Main Slot", "Sub Slot"},
}

-------------------------------------------
--               GEAR SETS               --
-------------------------------------------

function get_sets()

	-- Mode 1 (Multi-Attack) (Example: A focus on Multi-Attack and Store TP, then filling in the rest with DEX, Accuracy, and Attack)
	-- NOTE: This is your standard melee set.
	sets.modeone = {
		ammo="Coiste Bodhar",
		head="Adhemar Bonnet +1",
		body="Mpaca's Doublet",
		hands="Adhemar Wrist. +1",
		legs="Bhikku Hose +3",
		feet="Mpaca's Boots",
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Schere Earring",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
	}

	-- Mode 2 (Accuracy) (Example: A focus on DEX and Accuracy, then filling in the rest with a mix of Multi-Attack, Store TP, and Attack)
	-- NOTE: This is a special mode for accuracy. When in this mode, weapon skills will default to the Accuracy Weapon Skill set.
	sets.modetwo = set_combine(sets.modeone, {
		ammo="Coiste Bodhar",
		head="Bhikku Crown +3",
		body="Tatena. Harama. +1",
		hands="Bhikku Gloves +2",
		legs="Bhikku Hose +2",
		feet="Tatena. Sune. +1",
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		left_ear="Odr Earring",
		right_ear="Bhikku Earring +1",
		left_ring="Ilabrat Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
	})

	-- Mode 3 (Subtle Blow) (Example: A focus on Subtle blow, with a mix of Multi-Attack, Store TP, DEX, Accuracy, and Attack)
	-- NOTE: SB and SBII both cap at +50% each, with an overall cap of 75%. MNK gets Subtle Blow +35 from Job Traits. Thus, SB +15 and SBII +25 in gear will cap total Subtle Blow.
	sets.modethree = set_combine(sets.modeone, {
		head="Bhikku Crown +3",		--SB +14
		waist="Moonbow Belt +1",	--SBII +15
		left_ear="Sherida Earring",	--SBII +5
		right_ear="Schere Earring",	--SB +3
		right_ring="Niqmaddu Ring",	--SBII +5
	})

	-- Mode 4 (Tank) (Example: A focus on DT-, Counter, Killer effects, HP+, then filling in the rest with Multi-Attack, Store TP, and Attack)
	-- NOTE: Counter caps at 80%. Job Trait: 22, Merit: 5 (27 total base + Spharai: 14 = 41)
	sets.modefour = {
		ammo="Amar Cluster",			--Counter +2
		head="Bhikku Crown +3",
		body="Mpaca's Doublet",			--Counter +10
		hands="Bhikku Gloves +2",
		legs="Anch. Hose +3",			--Counter +6
		feet="Mpaca's Boots",
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		left_ear="Cryptic Earring",		--Counter +3
		right_ear="Bhikku Earring +1",	--Counter +8
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}}, --Counter +10

	}

	-- Idle (Movement Speed, Regain, Regen)
	sets.idle = {
		feet="Herald's Gaiters",
		neck="Rep. Plat. Medal",
		left_ring="Karieyh Ring +1",
	}

	-- DT Override (Damage Taken-, Magic Evasion)
	-- NOTE: Will override all other gear sets and inherit unused slots from them
	sets.dtoverride = {
		right_ring="Defending Ring",
	}

	-- Oh Shit
	-- Full DT- and everything you've got with Absorbs or Annuls Damage
	sets.ohshit = {
		neck="Warder's Charm +1",
		left_ring="Defending Ring",
		right_ring="Shadow Ring",
		back="Shadow Mantle"
	}

	-- Weapon Skill - Basic (STR, DEX, Multi-hit, Crit, Attack)
	sets.ws = {
		ammo="Coiste Bodhar",
		head="Anch. Crown +3",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Odr Earring",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
	}

	-- Weapon Skill - Accuracy (WS Accuracy, Accuracy)
	-- NOTE: This is a special set for weapon skill accuracy. When in the Accuracy mode (mode 2), weapon skills will use this set.
	sets.accws = set_combine(sets.ws, {
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ring="Karieyh Ring +1",
		right_ring="Cornelia's Ring",
	})

	-- Weapon Skill - Capped TP (STR, Weapon Skill Damage, Attack, Double/Triple Attack)
	-- NOTE: Intended to override any TP Bonus pieces in your Weapon Skill set if you're already at capped TP
	sets.cappedtpws = set_combine(sets.ws, {
		head="Nyame Helm",
		right_ear="Sherida Earring",
	})

	-- Tornado Kick (Kick Attacks, TP Bonus, STR, VIT )
	sets["Tornado Kick"] = set_combine(sets.ws, {
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Anch. Gaiters +3",
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		left_ear="Schere Earring",
		right_ear="Moonshade Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	})

	-- Final Heaven (VIT, STR, WSD)
	sets["Final Heaven"] = set_combine(sets.ws, {
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Schere Earring",
		right_ear="Bhikku Earring +1",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	})

	-- Ascetic's Fury (VIT, STR, crit+)
	sets["Ascetic's Fury"] = set_combine(sets.ws, {
		ammo="Crepuscular Pebble",
		head="Adhemar Bonnet +1",
		body="Bhikku Cyclas +3",
		hands="Bhikku Gloves +3",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Schere Earring",
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	})

	-- Victory Smite (STR, crit+)
	sets["Victory Smite"] = set_combine(sets.ws, {
		ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		body="Bhikku Cyclas +3",
		hands="Ryuo Tekko +1",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Schere Earring",
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	})

	-- Shijin Spiral (DEX, STR)
	sets["Shijin Spiral"] = set_combine(sets.ws, {
		ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		body="Bhikku Cyclas +3",
		hands="Bhikku Gloves +3",
		legs="Nyame Flanchard",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Schere Earring",
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
	})

	-- Cataclysm (Dark Elem. MAB, INT, Magic Damage, WSD)
	sets["Cataclysm"] = set_combine(sets.ws, {
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Moonshade Earring",
		left_ring="Archon Ring",
		right_ring="Metamor. Ring +1",
	})

	-- Ygnas's Resolve +1
	-- NOTE: Will combine with the appropriate Weapon Skill set while participating in a Reive
	sets.ygnas = {
		--neck="Ygnas's Resolve +1",
	}

	-- Boost
	sets.boost = {
		head="Anch. Gloves +2",
	}

	-- Focus
	sets.focus = {
		head="Anch. Crown +3",
	}

	-- Dodge
	sets.dodge = {
		feet="Anch. Gaiters +3",
	}

	-- Chakra
	sets.chakra = {
		body="Anch. Cyclas +2",
		hands="Hes. Gloves",
	}

	-- Chi Blast
	sets.chiblast = {
		head="Hes. Crown",
	}
 
	-- Counterstance
	sets.counterstance = {

	}

	-- Footwork (Equipped during the duration of Footwork)
	sets.footwork = {
		feet="Bhikku Gaiters +3",
	}

	-- Mantra
	sets.mantra = {
		feet="Hes. Gaitors",
	}

	-- Formless Strikes
	sets.formlessstrikes = {
		body="Hes. Cyclas",
	}

	-- Perfect Counter
	sets.perfectcounter = {
		head="Bhikku Crown +3",
	}

	-- Impetus (Equipped during duration of Impetus)
	sets.impetus = {
		body="bhikku Cyclas +3"
	}

	-- Hundred Fists
	sets.hundredfists = {
		legs="Hes. Hose",
	}

	-- Holy Water (Holy Water+)
	sets.hwater = {
		neck="Nicander's Necklace",
		ring1="Blenmot's Ring +1",
		ring2="Blenmot's Ring +1",
	}

	-- Default Town Gear (Put all your fancy-pants gear in here you want to showboat around town. Does not lockstyle this gear, only equips)
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




FileVersion = '6.2.2'

-------------------------------------------
--               UPDATES                 --
-------------------------------------------

--[[
MAJOR version updates add new feature(s). Usually require changes in the top portion of the file. Changes to gear sets will be noted.
MINOR version updates change how existing feature(s) function. Usually only require changes under the "Do Not Edit Below This Line".
PATCH version updates fix feature(s) that may not be functioning correctly or are otherwise broken. Usually only require changes under the "Do Not Edit Below This Line".
Ex: 1.2.3 (1 is the Major version, 2 is the Minor version, 3 is the patch version)

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
- Added Weapon Cycle feature. Cycles between pairs of Main slot weapons and Sub slot weapons/grips/shields. Use this to cycle between your commonly used weapons or add Abyssea proc weapons. Activated with a macro, an alias, or a keyboard shortcut (default is CTRL+H for Hweapon). Can be adjusted or new pairs added in the Weapons section.
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
--]]

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
	'Western Adoulin','Eastern Adoulin','Celennia Memorial Library','Silver Knife','Bastok Markets','Bastok Mines','Metalworks','Port Bastok','Chateau d\'Oraguille','Northern San d\'Oria','Port San d\'Oria','Southern San d\'Oria','Heavens Tower','Port Windurst','Windurst Walls','Windurst Waters','Windurst Woods','Lower Jeuno','Port Jeuno','Ru\'Lude Gardens','Upper Jeuno','Aht Urhgan Whitegate','The Colosseum','Tavnazian Safehold','Southern San d\'Oria [S]','Bastok Markets [S]','Windurst Waters [S]','Mhaura','Selbina','Rabao','Kazham','Norg','Nashmau','Mog Garden','Leafallia'
    }

-------------------------------------------
--              FILE LOAD                --
-------------------------------------------

Mode = StartMode --sets the starting mode (selected in the Advanced Options)
DTOverride = "Off" --Start with the Damage Taken Override off
RRRCountdown = RRReminderTimer
HUDposYLine1 = HUDposY
HWaterRecast = 0
HWater = true --this is used as a simple on/off for when we run out of Holy Waters
Heartbeat = 0 --set to 0 just to start the Heartbeat running
LoadDelay = 4 --delays loading the HUD, this makes sure all the variables get set correctly before being used, displays file version info, and waits to use lockstyle
LoadHUD = false --starts false then switched to true after the LoadDelay
Zoning = false --flips automatically to hide the HUD while zoning
InCS = false --flips automatically to hide the HUD while in a cs
LockstyleDelay = 5
AutoLockstyleRun = true
AutoSaveUsed = false --this is used so we don't trigger multiple "saves" together
LowHP = false
Doom = false
Alive = true --makes it easier to Do Things or Not Do Things based on if we die.
DangerCountdown = 0
NotiCountdown = -1 --we set the countdown below 0 to stop the countdown from hitting 0 and triggering the ClearNotifications command
WeaponCycleIndex = 1 --used to cycle through the WeaponCycle sets

--create a new table that combines both the WeaponCycle and AbysseaProcCycle weapons into one table to be used while inside Abyssea
local WeaponCyclePlusAbyssea = {}
for _, v in ipairs(WeaponCycle) do
    table.insert(WeaponCyclePlusAbyssea, {v[1], v[2]})
end
for _, v in ipairs(AbysseaProcCycle) do
    table.insert(WeaponCyclePlusAbyssea, {v[1], v[2]})
end

--set the initial recasts to 0, they will get updated in the Heartbeat function:
FocusRecast = 0
DodgeRecast = 0
ImpetusRecast = 0
FootworkRecast = 0
AggressorRecast = 0
BerserkRecast = 0
HighJumpRecast = 0
SuperJumpRecast = 0
PerfectCounterRecast = 0
ChakraRecast = 0

--Space out each line and column properly
HUDposYLine2 = HUDposYLine1 - LineSpacer --Note that Line 1 is the bottom line, additional line numbers move upward on the screen
HUDposYLine3 = HUDposYLine2 - LineSpacer
HUDposXColumn1 = HUDposX
HUDposXColumn2 = HUDposXColumn1 + ColumnSpacer
HUDposXColumn3 = HUDposXColumn2 + ColumnSpacer
HUDposXColumn4 = HUDposXColumn3 + ColumnSpacer
HUDposXColumn5 = HUDposXColumn4 + ColumnSpacer
HUDposXColumn6 = HUDposXColumn5 + ColumnSpacer
send_command('wait '..LoadDelay..';gs c LoadHUD')
--Create all the HUD Background text objects and put them above the screen for now, we'll move them to the correct place next
send_command('wait 1.5;text bg1 create "                                                                                                                          ";wait .3;text bg1 size '..FontSize..';text bg1 pos '..HUDposXColumn1..' '..HUDposYLine1..';text bg1 bg_transparency '..HUDBGTrans..'')--Background Line 1
send_command('wait 1.6;text bg2 create "                                                                                                                          ";wait .3;text bg2 size '..FontSize..';text bg2 pos '..HUDposXColumn1..' -100;text bg2 bg_transparency '..HUDBGTrans..'')--Background Line 2
send_command('wait 1.7;text bg3 create "                                                                                                                          ";wait .3;text bg3 size '..FontSize..';text bg3 pos '..HUDposXColumn1..' -100;text bg3 bg_transparency '..HUDBGTrans..'')--Background Line 3
send_command('wait 1.8;text loading create "Loading Keys MONK file ver: '..FileVersion..' ...";wait .3;text loading size '..FontSize..';text loading pos '..HUDposXColumn1..' '..HUDposYLine1..';text loading bg_transparency 1') --Loading
--Create the Aftermath, Mode, Notifications, and Debuffs text objects and put them above the screen for now, we'll move them to the correct place next
send_command('wait 1.9;text weapons create "« Weapons loading... »";wait .3;text weapons size '..FontSize..';text weapons pos '..HUDposXColumn4..' -100;text weapons color 255 50 50;text weapons bg_transparency 1') --Aftermath
if Mode == 'Mode1' then
	send_command('wait 2.1;text mode create "Mode: '..Mode1Name..'";wait .3;text mode size '..FontSize..';text mode pos '..HUDposXColumn1..' -100;text mode color '..Mode1color..';text mode bg_transparency 1')
elseif Mode == 'Mode2' then
	send_command('wait 2.1;text mode create "Mode: '..Mode2Name..'";wait .3;text mode size '..FontSize..';text mode pos '..HUDposXColumn1..' -100;text mode color '..Mode2color..';text mode bg_transparency 1')
elseif Mode == 'Mode3' then
	send_command('wait 2.1;text mode create "Mode: '..Mode3Name..'";wait .3;text mode size '..FontSize..';text mode pos '..HUDposXColumn1..' -100;text mode color '..Mode3color..';text mode bg_transparency 1')
elseif Mode == 'Mode4' then
	send_command('wait 2.1;text mode create "Mode: '..Mode4Name..'";wait .3;text mode size '..FontSize..';text mode pos '..HUDposXColumn1..' -100;text mode color '..Mode4color..';text mode bg_transparency 1')
end
send_command('wait 2.1;text notifications create "Hello, '..player.name..'! (type //fileinfo for more information)";wait .3;text notifications size '..FontSize..';text notifications pos '..HUDposXColumn1..' -100;text notifications bg_transparency 1') --Notifications
send_command('wait 2.2;text debuffs create " ";wait .3;text debuffs size '..FontSize..';text debuffs pos '..HUDposXColumn4..' -100;text debuffs bg_transparency 1') --Debuffs
--Create all the HUD Recast text objects and put them above the screen for now, we'll move them to the correct place next
send_command('wait 2.3;text focus create "[ Focus ]";wait .3;text focus size '..FontSize..';text focus pos '..HUDposXColumn1..' -100;text focus bg_transparency 1')
send_command('wait 2.4;text dodge create "[ Dodge ]";wait .3;text dodge size '..FontSize..';text dodge pos '..HUDposXColumn1..' -100;text dodge bg_transparency 1')
send_command('wait 2.5;text impetus create "[ Impetus ]";wait .3;text impetus size '..FontSize..';text impetus pos '..HUDposXColumn1..' -100;text impetus bg_transparency 1')
send_command('wait 2.6;text footwork create "[ Footwork ]";wait .3;text footwork size '..FontSize..';text footwork pos '..HUDposXColumn1..' -100;text footwork bg_transparency 1')
send_command('wait 2.7;text perfectcounter create "[ Perf. C. ]";wait .3;text perfectcounter size '..FontSize..';text perfectcounter pos '..HUDposXColumn1..' -100;text perfectcounter bg_transparency 1')
send_command('wait 2.8;text highjump create "[ High J. ]";wait .3;text highjump size '..FontSize..';text highjump pos '..HUDposXColumn1..' -100;text highjump bg_transparency 1')
send_command('wait 2.9;text superjump create "[ Super J. ]";wait .3;text superjump size '..FontSize..';text superjump pos '..HUDposXColumn1..' -100;text superjump bg_transparency 1')
send_command('wait 3.0;text aggressor create "[ Aggres. ]";wait .3;text aggressor size '..FontSize..';text aggressor pos '..HUDposXColumn1..' -100;text aggressor bg_transparency 1')
send_command('wait 3.1;text berserk create "[ Berserk ]";wait .3;text berserk size '..FontSize..';text berserk pos '..HUDposXColumn1..' -100;text berserk bg_transparency 1')
send_command('wait 3.2;text chakra create "[ Chakra ]";wait .3;text chakra size '..FontSize..';text chakra pos '..HUDposXColumn1..' -100;text chakra bg_transparency 1')

send_command('alias lockstyle gs c Lockstyle') --creates the first lockstyle aliases
send_command('alias lstyle gs c Lockstyle') --creates the second lockstyle aliases
if Chat ~= "Off" then
	send_command('input /cm '..Chat..'')
end
if Book ~= "Off" then
	send_command('input /macro book '..Book..'')
end
if SubWARPage ~= "Off" and player.sub_job == 'WAR' then
	send_command('wait 2;input /macro set '..SubWARPage..'')
elseif SubDRGPage ~= "Off" and player.sub_job == 'DRG' then
	send_command('wait 2;input /macro set '..SubDRGPage..'')
else
	send_command('wait 2;input /macro set 1')
end
send_command('alias fileinfo gs c Fileinfo') --creates the fileinfo alias
send_command('alias mode gs c Mode') --creates the Mode alias
send_command('alias hud gs c HUD') --creates the HUD alias
send_command('bind '..ModeBind..' gs c Mode') --creates the gear mode keyboard shortcut
send_command('bind '..DTBind..' gs c DT') --creates the DT Override keyboard shortcut
send_command('bind '..WCBind..' gs c WC') --creates the Weapon Cycle keyboard shortcut
send_command('alias dt gs c DT') --creates the DT Override and alias
if Debug == 'On' then
	add_to_chat(8,'[Debug Mode: On]')
end

-- Add commas to numbers to make them easier to read
function addCommas(number)
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
				formattedNumber = formattedNumber:sub(1, insertIndex) .. "," .. formattedNumber:sub(insertIndex + 1)
				insertIndex = insertIndex + 4
				length = length + 1
			end
		end
	end

	-- Return the number (albeit as a string, we're not doing any math on it at this point)
    return formattedNumber
end

-- Check if the equipped Main/Sub pair are in our defined AbysseaProcCycle weapons table
function checkProcWeapons(mainSlot, subSlot)
    for _, equipmentPair in pairs(AbysseaProcCycle) do
        if equipmentPair[1] == mainSlot and equipmentPair[2] == subSlot then
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
		if Mode == 'Mode1' then
			Mode = 'Mode2'
			if LoadHUD == true then
				send_command('text mode text "Mode: '..Mode2Name..'";text mode color '..Mode2color..'')
			end
		elseif Mode == 'Mode2' then
			Mode = 'Mode3'
			if LoadHUD == true then
				send_command('text mode text "Mode: '..Mode3Name..'";text mode color '..Mode3color..'')
			end
		elseif Mode == 'Mode3' then
			Mode = 'Mode4'
			if LoadHUD == true then
				send_command('text mode text "Mode: '..Mode4Name..'";text mode color '..Mode4color..'')
			end
		elseif Mode == 'Mode4' then
			Mode = 'Mode1'
			if LoadHUD == true then
				send_command('text mode text "Mode: '..Mode1Name..'";text mode color '..Mode1color..'')
			end
		end
		if Debug == 'On' then
			add_to_chat(8,'[Mode set to '..Mode..']')
		end
		choose_set()
	elseif command == 'DT' then
		if DTOverride == 'Off' then
			DTOverride = 'On'
			if Debug == 'On' then
				add_to_chat(8,'[DTOverride set to On]')
			end
		elseif DTOverride == 'On' then
			DTOverride = 'Off'
			if Debug == 'On' then
				add_to_chat(8,'[DTOverride set to Off]')
			end
		end
		choose_set()
	elseif command == 'ClearNotifications' and LoadHUD == true then --these reset the Notifications display back to a basic state
		if buffactive['Sneak'] and buffactive['Invisible'] then
			send_command('text notifications text "Status: Sneak & Invisible";text notifications color 50 205 50;text notifications bg_transparency 1')
		elseif buffactive['Sneak'] then
			send_command('text notifications text "Status: Sneak";text notifications color 50 205 50;text notifications bg_transparency 1')
		elseif buffactive['Invisible'] then
			send_command('text notifications text "Status: Invisible";text notifications color 50 205 50;text notifications bg_transparency 1')
		elseif buffactive['weakness'] and DTOverride == 'On' then
			send_command('text notifications text "Status: Weak (DT Override)";text notifications color 205 133 63;text notifications bg_transparency 1')
		elseif buffactive['weakness'] then
			send_command('text notifications text "Status: Weak";text notifications color 205 133 63;text notifications bg_transparency 1')
		elseif player.status == "Resting" and DTOverride == 'On' then
			send_command('text notifications text "Status: Resting (DT Override)";text notifications color 255 255 255;text notifications bg_transparency 1')
		elseif player.status == "Resting" then
			send_command('text notifications text "Status: Resting";text notifications color 255 255 255;text notifications bg_transparency 1')
		elseif player.status == "Engaged" and DTOverride == 'On' then
			send_command('text notifications text "Status: Engaged (DT Override)";text notifications color 255 255 255;text notifications bg_transparency 1')
		elseif player.status == "Engaged" then
			send_command('text notifications text "Status: Engaged";text notifications color 255 255 255;text notifications bg_transparency 1')
		elseif player.status == "Idle" and DTOverride == "On" then
			send_command('text notifications text "Status: Idle (DT Override)";text notifications color 255 255 255;text notifications bg_transparency 1')
		elseif player.status == "Idle" then
			send_command('text notifications text "Status: Idle";text notifications color 255 255 255;text notifications bg_transparency 1')
		end
	elseif command == 'ClearDebuffs' and LoadHUD == true then --these reset the Debuffs display back to a basic state
		send_command('text debuffs text "";text debuffs color 255 255 255;text debuffs bg_transparency 1')
	elseif command == 'LoadHUD' then
		LoadHUD = true
		if Debug == 'On' then
			add_to_chat(8,'[LoadHUD set to True]')
		end
		send_command('text loading hide')
		send_command('wait .1;text bg2 pos '..HUDposXColumn1..' '..HUDposYLine2..'')
		send_command('wait .2;text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')
		send_command('wait .7;text mode pos '..HUDposXColumn1..' '..HUDposYLine2..';text mode color '..Mode1color..'')
		if NotiWeapons == 'On' then
			send_command('wait .7;text weapons pos '..HUDposXColumn4..' '..HUDposYLine2..'')
		end
		send_command('wait .8;text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')
		send_command('wait .8;text debuffs pos '..HUDposXColumn4..' '..HUDposYLine3..'')
	elseif command == 'Fileinfo' then
		add_to_chat(3,'-------------------------------------------')
		add_to_chat(3,'--    Keys Gearswap lua file for Monk    --')
		add_to_chat(3,'-------------------------------------------')
		add_to_chat(8,' ')
		add_to_chat(200,'File Version: '..(''..FileVersion..''):color(8)..'')
		add_to_chat(8,' ')
		add_to_chat(8,'REQUIRED Windower Addons: Text')
		add_to_chat(8,' ')
		add_to_chat(8,'Place both this file and the sounds folder')
		add_to_chat(8,'inside the GearSwap data folder')
		add_to_chat(200,'ex:     /addons/GearSwap/data/sounds/')
		add_to_chat(200,'        /addons/GearSwap/data/MNK.lua')
		add_to_chat(8,' ')
		add_to_chat(8,'To switch between gear modes, use any of these three options:')
		add_to_chat(8,'1. A macro with the following in it')
		add_to_chat(200,'        /console mode')
		add_to_chat(8,'2. An alias command')
		add_to_chat(200,'        //mode')
		add_to_chat(8,'3. A keybind shortcut')
		add_to_chat(200,'        CTRL+G')
		add_to_chat(8,'        (Can be changed in the Advanced Options section)')
		add_to_chat(8,' ')
		add_to_chat(8,'To activate Damage Taken Override, use any of these three options:')
		add_to_chat(8,'1. A macro with the following in it')
		add_to_chat(200,'        /console DT')
		add_to_chat(8,'2. An alias command')
		add_to_chat(200,'        //dt')
		add_to_chat(8,'3. A keybind shortcut')
		add_to_chat(200,'        CTRL+D')
		add_to_chat(8,'        (Can be changed in the Advanced Options section)')
		add_to_chat(8,' ')
		add_to_chat(8,'To activate the Weapon Cycle, use any of these three options:')
		add_to_chat(8,'1. A macro with the following in it')
		add_to_chat(200,'        /console WC')
		add_to_chat(8,'2. An alias command')
		add_to_chat(200,'        //wc')
		add_to_chat(8,'3. A keybind shortcut')
		add_to_chat(200,'        CTRL+H')
		add_to_chat(8,'        (Can be changed in the Advanced Options section)')
		add_to_chat(8,' ')
		add_to_chat(8,'Run the Lockstyle function yourself at any time by typing')
		add_to_chat(200,'        //lockstyle or //lstyle')
		add_to_chat(8,' ')
		add_to_chat(8,'Hide or show the HUD at any time by typing')
		add_to_chat(200,'        //hud')
		add_to_chat(8,' ')
		add_to_chat(8,'IMPORTANT:')
		add_to_chat(8,'When you load this file for the first time, your HUD may not be')
		add_to_chat(8,'in a good position, or may be too large.')
		add_to_chat(8,'If the HUD is not in a good position, go to the Heads Up Display')
		add_to_chat(8,'options below and adjust the HUDposX and HUDposY options, then save')
		add_to_chat(8,'and reload the file. Adjust and repeat until positioned as desired.')
		add_to_chat(8,'If the HUD is too large (or small), adjust the FontSize,')
		add_to_chat(8,'LineSpacer, and ColumnSpacer options as needed.')
		add_to_chat(8,'Suggested placement is center screen, just above your chat log.')
		add_to_chat(8,' ')
		add_to_chat(3,'-------------------------------------------')
		add_to_chat(3,'--                  Options                  --')
		add_to_chat(3,'-------------------------------------------')
		add_to_chat(200,'AutoLockstyle: '..(''..AutoLockstyle..''):color(8)..'')
		add_to_chat(200,'LockstyleCombat: '..(''..LockstyleCombat..''):color(8)..'')
		add_to_chat(200,'LockstyleTown: '..(''..LockstyleTown..''):color(8)..'')
		add_to_chat(200,'Book: '..(''..Book..''):color(8)..'')
		add_to_chat(200,'SubWARPage: '..(''..SubWARPage..''):color(8)..'')
		add_to_chat(200,'SubDRGPage: '..(''..SubDRGPage..''):color(8)..'')
		add_to_chat(200,'Chat: '..(''..Chat..''):color(8)..'')
		add_to_chat(200,'HFTimer: '..(''..HFTimer..''):color(8)..'')
		add_to_chat(200,'ISTimer: '..(''..ISTimer..''):color(8)..'')
		add_to_chat(200,'ZoneGear: '..(''..ZoneGear..''):color(8)..'')
		add_to_chat(200,'AlertSounds: '..(''..AlertSounds..''):color(8)..'')
		add_to_chat(200,'AutoHWater: '..(''..AutoHWater..''):color(8)..'')
		add_to_chat(200,'AutoSave: '..(''..AutoSave..''):color(8)..'')
		add_to_chat(200,'DoomAlert: '..(''..DoomAlert..''):color(8)..'')
		add_to_chat(200,'DoomOnText: '..(''..DoomOnText..''):color(8)..'')
		add_to_chat(200,'DoomOffText: '..(''..DoomOffText..''):color(8)..'')
		add_to_chat(200,' ')
		add_to_chat(3,'-- Heads Up Display --')
		add_to_chat(200,'HUDposX: '..(''..HUDposX..''):color(8)..'')
		add_to_chat(200,'HUDposYLine1: '..(''..HUDposYLine1..''):color(8)..'')
		add_to_chat(200,'FontSize: '..(''..FontSize..''):color(8)..'')
		add_to_chat(200,'LineSpacer: '..(''..LineSpacer..''):color(8)..'')
		add_to_chat(200,'ColumnSpacer: '..(''..ColumnSpacer..''):color(8)..'')
		add_to_chat(200,' ')
		add_to_chat(3,'-- HUD Mode Names --')
		add_to_chat(200,'Mode1Name: '..(''..Mode1Name..''):color(8)..'')
		add_to_chat(200,'Mode2Name: '..(''..Mode2Name..''):color(8)..'')
		add_to_chat(200,'Mode3Name: '..(''..Mode3Name..''):color(8)..'')
		add_to_chat(200,'Mode4Name: '..(''..Mode4Name..''):color(8)..'')
		add_to_chat(200,' ')
		add_to_chat(3,'-- General Notifications --')
		add_to_chat(200,'Noti3000TP: '..(''..Noti3000TP..''):color(8)..'')
		add_to_chat(200,'NotiWeapons: '..(''..NotiWeapons..''):color(8)..'')
		add_to_chat(200,'NotiTrade: '..(''..NotiTrade..''):color(8)..'')
		add_to_chat(200,'NotiInvite: '..(''..NotiInvite..''):color(8)..'')
		add_to_chat(200,'NotiSneak: '..(''..NotiSneak..''):color(8)..'')
		add_to_chat(200,'NotiInvis: '..(''..NotiInvis..''):color(8)..'')
		add_to_chat(200,'NotiReraise: '..(''..NotiReraise..''):color(8)..'')
		add_to_chat(200,'NotiFood: '..(''..NotiFood..''):color(8)..'')
		add_to_chat(200,'NotiLowHP: '..(''..NotiLowHP..''):color(8)..'')
		add_to_chat(200,'NotiDamage: '..(''..NotiDamage..''):color(8)..'')
		add_to_chat(200,'ReraiseReminder: '..(''..ReraiseReminder..''):color(8)..'')
		add_to_chat(200,'NotiTime: '..(''..NotiTime..''):color(8)..'')
		add_to_chat(200,' ')
		add_to_chat(3,'-- Debuff Notifications --')
		add_to_chat(200,'NotiSleep: '..(''..NotiSleep..''):color(8)..'')
		add_to_chat(200,'NotiSilence: '..(''..NotiSilence..''):color(8)..'')
		add_to_chat(200,'NotiPetrification: '..(''..NotiPetrification..''):color(8)..'')
		add_to_chat(200,'NotiCurse: '..(''..NotiCurse..''):color(8)..'')
		add_to_chat(200,'NotiStun: '..(''..NotiStun..''):color(8)..'')
		add_to_chat(200,'NotiCharm: '..(''..NotiCharm..''):color(8)..'')
		add_to_chat(200,'NotiDoom: '..(''..NotiDoom..''):color(8)..'')
		add_to_chat(200,'NotiAmnesia: '..(''..NotiAmnesia..''):color(8)..'')
		add_to_chat(200,'NotiTerror: '..(''..NotiTerror..''):color(8)..'')
		add_to_chat(200,'NotiMute: '..(''..NotiMute..''):color(8)..'')
		add_to_chat(200,'NotiPlague: '..(''..NotiPlague..''):color(8)..'')
		add_to_chat(200,'NotiPara: '..(''..NotiPara..''):color(8)..'')
		add_to_chat(200,' ')
		add_to_chat(3,'-------------------------------------------')
		add_to_chat(3,'--           Advanced Options              --')
		add_to_chat(3,'-------------------------------------------')
		add_to_chat(200,'ShowHUD: '..(''..ShowHUD..''):color(8)..'')
		add_to_chat(200,'StartMode: '..(''..StartMode..''):color(8)..'')
		add_to_chat(200,'ModeBind: '..(''..ModeBind..''):color(8)..'')
		add_to_chat(200,'DTBind: '..(''..DTBind..''):color(8)..'')
		add_to_chat(200,'WCBind: '..(''..WCBind..''):color(8)..'')
		add_to_chat(200,'LowHPThreshold: '..(''..LowHPThreshold..''):color(8)..'')
		add_to_chat(200,'AutoSaveThreshold: '..(''..AutoSaveThreshold..''):color(8)..'')
		add_to_chat(200,'CappedTPThreshold: '..(''..CappedTPThreshold..''):color(8)..'')
		add_to_chat(200,'DangerRepeat: '..(''..DangerRepeat..''):color(8)..'')
		add_to_chat(200,'RRReminderTimer: '..(''..RRReminderTimer..''):color(8)..'')
		add_to_chat(200,'NotiDelay: '..(''..NotiDelay..''):color(8)..'')
		add_to_chat(200,'HUDBGTrans: '..(''..HUDBGTrans..''):color(8)..'')
		add_to_chat(200,'AddCommas: '..(''..AddCommas..''):color(8)..'')
		add_to_chat(200,'Debug: '..(''..Debug..''):color(8)..'')
		add_to_chat(200,' ')
		add_to_chat(3,'-- Color Values --')
		add_to_chat(200,'Mode1color: '..(''..Mode1color..''):color(8)..'')
		add_to_chat(200,'Mode2color: '..(''..Mode2color..''):color(8)..'')
		add_to_chat(200,'Mode3color: '..(''..Mode3color..''):color(8)..'')
		add_to_chat(200,'Mode4color: '..(''..Mode4color..''):color(8)..'')
		add_to_chat(200,'Aftermath1color: '..(''..Aftermath1color..''):color(8)..'')
		add_to_chat(200,'Aftermath2color: '..(''..Aftermath2color..''):color(8)..'')
		add_to_chat(200,'Aftermath3color: '..(''..Aftermath3color..''):color(8)..'')
		add_to_chat(200,' ')
		add_to_chat(3,'Options can be changed in the file itself.')
	elseif command == 'Zone Gear' then
		if ZoneGear == 'Town' then
			if TownZones:contains(world.area) then
				send_command('wait 5;gs c Choose Set')
			end
		else
			send_command('wait 5;gs c Choose Set')
		end
	elseif command == 'Choose Set' then
		choose_set()
	elseif command == 'Zone Lockstyle' then
		send_command('wait 5;gs c Lockstyle')
	elseif command == 'Lockstyle' then
		if TownZones:contains(world.area) then
			send_command('input /lockstyleset '..LockstyleTown..'')
		else
			send_command('input /lockstyleset '..LockstyleCombat..'')
		end
	elseif command == 'Radialens' then
		--we put this wait in to check what zone we're in when the Radialens wears so that it doesn't trigger when we're simply zoning out of an Escha zone
		send_command('wait 4;gs c RadialensCheck')
	elseif command == 'RadialensCheck' and string.find(world.area,'Escha') then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if LoadHUD == true then
			send_command('text notifications text "«« Radialens Has Worn Off »»";text notifications color 255 50 50;text notifications bg_transparency 1')
			NotiCountdown = NotiDelay
			if Debug == 'On' then
				add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
			end
		end
	elseif command == 'AliveDelay' then
		Alive = true --putting this in a command lets us set a small delay to prevent things from triggering right when we raise up
		if Debug == 'On' then
			add_to_chat(8,'[Alive set to True]')
		end
	elseif command == 'HUD' and ShowHUD == false then
		ShowHUD = true
		if Debug == 'On' then
			add_to_chat(8,'[ShowHUD set to True]')
		end
		windower.send_command('gs c ShowHUD')
	elseif command == 'HUD' and ShowHUD == true then
		ShowHUD = false
		if Debug == 'On' then
			add_to_chat(8,'[ShowHUD set to False]')
		end
		windower.send_command('gs c HideHUD')
	elseif command == 'ShowHUD' then
		send_command('text bg1 show;text bg2 show;text bg3 show;text focus show;text dodge show;text impetus show;text footwork show;text aggressor show;text berserk show;text highjump show;text superjump show;text perfectcounter show;text chakra show;text mode show;text notifications show;text debuffs show;text weapons show')
	elseif command == 'HideHUD' then
		send_command('text bg1 hide;text bg2 hide;text bg3 hide;text focus hide;text dodge hide;text impetus hide;text footwork hide;text aggressor hide;text berserk hide;text highjump hide;text superjump hide;text perfectcounter hide;text chakra hide;text loading hide;text mode hide;text notifications hide;text debuffs hide;text weapons hide')
	elseif command == 'WC' then
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
		WeaponCycleIndex = WeaponCycleIndex + 1
	end
end

-------------------------------------------
--              CHOOSE SET               --
-------------------------------------------

function choose_set()
	if player.status == "Resting" then
		if LoadHUD == true then
			if buffactive['weakness'] and DTOverride == 'On' then
				send_command('text notifications text "Status: Weak (DT Override)";text notifications color 205 133 63;text notifications bg_transparency 1')
			elseif buffactive['weakness'] then
				send_command('text notifications text "Status: Weak";text notifications color 205 133 63;text notifications bg_transparency 1')
			elseif DTOverride == 'On' then
				send_command('text notifications text "Status: Resting (DT Override)";text notifications color 255 255 255;text notifications bg_transparency 1')
			else
				send_command('text notifications text "Status: Resting";text notifications color 255 255 255;text notifications bg_transparency 1')
			end
		end
	elseif player.status == "Engaged" then
		if LoadHUD == true then 
			if buffactive['weakness'] and DTOverride == 'On' then
				send_command('text notifications text "Status: Weak (DT Override)";text notifications color 205 133 63;text notifications bg_transparency 1')
			elseif buffactive['weakness'] then
				send_command('text notifications text "Status: Weak";text notifications color 205 133 63;text notifications bg_transparency 1')
			elseif DTOverride == 'On' then
				send_command('text notifications text "Status: Engaged (DT Override)";text notifications color 255 255 255;text notifications bg_transparency 1')
			else
				send_command('text notifications text "Status: Engaged";text notifications color 255 255 255;text notifications bg_transparency 1')
			end
		end
		if LowHP == true then --if we have low HP we equip the Oh Shit gear set
			equip(sets.ohshit)
			if Debug == 'On' then
				add_to_chat(8,'[Equipped Set: Oh Shit]')
			end
		else
			if DTOverride == 'On' then
				if Mode == 'Mode1' then
					equip(set_combine(sets.modeone, sets.dtoverride))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Mode 1 ('..Mode1Name..') + DT Override]')
					end
				elseif Mode == 'Mode2' then
					equip(set_combine(sets.modetwo, sets.dtoverride))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Mode 2 ('..Mode2Name..') + DT Override]')
					end
				elseif Mode == 'Mode3' then
					equip(set_combine(sets.modethree, sets.dtoverride))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Mode 3 ('..Mode3Name..') + DT Override]')
					end
				elseif Mode == 'Mode4' then
					equip(set_combine(sets.modefour, sets.dtoverride))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Mode 4 ('..Mode4Name..') + DT Override]')
					end
				end
			else
				if Mode == 'Mode1' then
					if buffactive['Footwork'] and buffactive['Impetus'] then
						equip(set_combine(sets.modeone, sets.footwork, sets.impetus))
						if Debug == 'On' then
							add_to_chat(8,'[Equipped Set: Mode 1 ('..Mode1Name..') + Footwork + Impetus]')
						end
					elseif buffactive['Footwork'] then
						equip(set_combine(sets.modeone, sets.footwork))
						if Debug == 'On' then
							add_to_chat(8,'[Equipped Set: Mode 1 ('..Mode1Name..') + Footwork]')
						end
					elseif buffactive['Impetus'] then
						equip(set_combine(sets.modeone, sets.impetus))
						if Debug == 'On' then
							add_to_chat(8,'[Equipped Set: Mode 1 ('..Mode1Name..') + Impetus]')
						end
					else
						equip(sets.modeone)
						if Debug == 'On' then
							add_to_chat(8,'[Equipped Set: Mode 1 ('..Mode1Name..')]')
						end
					end
				elseif Mode == 'Mode2' then
					equip(sets.modetwo)
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Mode 2 ('..Mode2Name..')]')
					end
				elseif Mode == 'Mode3' then
					equip(sets.modethree)
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Mode 3 ('..Mode3Name..')]')
					end
				elseif Mode == 'Mode4' then
					equip(sets.modefour)
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Mode 4 ('..Mode4Name..')]')
					end
				end
			end
		end
	elseif player.status == "Idle" then 
		if LoadHUD == true then 
			if buffactive['Sneak'] and buffactive['Invisible'] then
				send_command('text notifications text "Status: Sneak & Invisible";text notifications color 50 205 50;text notifications bg_transparency 1')
			elseif buffactive['Sneak'] then
				send_command('text notifications text "Status: Sneak";text notifications color 50 205 50;text notifications bg_transparency 1')
			elseif buffactive['Invisible'] then
				send_command('text notifications text "Status: Invisible";text notifications color 50 205 50;text notifications bg_transparency 1')
			elseif buffactive['weakness'] and DTOverride == 'On' then
				send_command('text notifications text "Status: Weak (DT Override)";text notifications color 205 133 63;text notifications bg_transparency 1')
			elseif buffactive['weakness'] then
				send_command('text notifications text "Status: Weak";text notifications color 205 133 63;text notifications bg_transparency 1')
			elseif DTOverride == 'On' then
				send_command('text notifications text "Status: Idle (DT Override)";text notifications color 255 255 255;text notifications bg_transparency 1')
			else
				send_command('text notifications text "Status: Idle";text notifications color 255 255 255;text notifications bg_transparency 1')
			end
		end
		if AdoulinZones:contains(world.area) then
			if Mode == 'Mode1' then
				equip(set_combine(sets.modeone, sets.adoulin, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 1 ('..Mode1Name..') + Adoulin + Idle]')
				end
			elseif Mode == 'Mode2' then
				equip(set_combine(sets.modetwo, sets.adoulin, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 2 ('..Mode2Name..') + Adoulin + Idle]')
				end
			elseif Mode == 'Mode3' then
				equip(set_combine(sets.modethree, sets.adoulin, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 3 ('..Mode3Name..') + Adoulin + Idle]')
				end
			elseif Mode == 'Mode4' then
				equip(set_combine(sets.modefour, sets.adoulin, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 4 ('..Mode4Name..') + Adoulin + Idle]')
				end
			end
		elseif BastokZones:contains(world.area) then
			if Mode == 'Mode1' then
				equip(set_combine(sets.modeone, sets.bastok, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 1 ('..Mode1Name..') + Bastok + Idle]')
				end
			elseif Mode == 'Mode2' then
				equip(set_combine(sets.modetwo, sets.bastok, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 2 ('..Mode2Name..') + Bastok + Idle]')
				end
			elseif Mode == 'Mode3' then
				equip(set_combine(sets.modethree, sets.bastok, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 3 ('..Mode3Name..') + Bastok + Idle]')
				end
			elseif Mode == 'Mode4' then
				equip(set_combine(sets.modefour, sets.bastok, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 4 ('..Mode4Name..') + Bastok + Idle]')
				end
			end
		elseif SandyZones:contains(world.area) then
			if Mode == 'Mode1' then
				equip(set_combine(sets.modeone, sets.sandoria, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 1 ('..Mode1Name..') + San d\'Oria + Idle]')
				end
			elseif Mode == 'Mode2' then
				equip(set_combine(sets.modetwo, sets.sandoria, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 2 ('..Mode2Name..') + San d\'Oria + Idle]')
				end
			elseif Mode == 'Mode3' then
				equip(set_combine(sets.modethree, sets.sandoria, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 3 ('..Mode3Name..') + San d\'Oria + Idle]')
				end
			elseif Mode == 'Mode4' then
				equip(set_combine(sets.modefour, sets.sandoria, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 4 ('..Mode4Name..') + San d\'Oria + Idle]')
				end
			end
		elseif WindyZones:contains(world.area) then
			if Mode == 'Mode1' then
				equip(set_combine(sets.modeone, sets.windurst, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 1 ('..Mode1Name..') + Windurst + Idle]')
				end
			elseif Mode == 'Mode2' then
				equip(set_combine(sets.modetwo, sets.windurst, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 2 ('..Mode2Name..') + Windurst + Idle]')
				end
			elseif Mode == 'Mode3' then
				equip(set_combine(sets.modethree, sets.windurst, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 3 ('..Mode3Name..') + Windurst + Idle]')
				end
			elseif Mode == 'Mode4' then
				equip(set_combine(sets.modefour, sets.windurst, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 4 ('..Mode4Name..') + Windurst + Idle]')
				end
			end
		elseif TownZones:contains(world.area) then
			if Mode == 'Mode1' then
				equip(set_combine(sets.modeone, sets.town, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 1 ('..Mode1Name..') + Town + Idle]')
				end
			elseif Mode == 'Mode2' then
				equip(set_combine(sets.modetwo, sets.town, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 2 ('..Mode2Name..') + Town + Idle]')
				end
			elseif Mode == 'Mode3' then
				equip(set_combine(sets.modethree, sets.town, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 3 ('..Mode3Name..') + Town + Idle]')
				end
			elseif Mode == 'Mode4' then
				equip(set_combine(sets.modefour, sets.town, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 4 ('..Mode4Name..') + Town + Idle]')
				end
			end
		elseif LowHP == true then --if we have low HP we equip the Oh Shit gear set
			equip(set_combine(sets.idle, sets.ohshit))
			if Debug == 'On' then
				add_to_chat(8,'[Equipped Set: Idle + Oh Shit]')
			end
		elseif DTOverride == 'On' then
			if Mode == 'Mode1' then
				equip(set_combine(sets.modeone, sets.idle, sets.dtoverride))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 1 ('..Mode1Name..') + Idle + DT Override]')
				end
			elseif Mode == 'Mode2' then
				equip(set_combine(sets.modetwo, sets.idle, sets.dtoverride))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 2 ('..Mode2Name..') + Idle + DT Override]')
				end
			elseif Mode == 'Mode3' then
				equip(set_combine(sets.modethree, sets.idle, sets.dtoverride))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 3 ('..Mode3Name..') + Idle + DT Override]')
				end
			elseif Mode == 'Mode4' then
				equip(set_combine(sets.modefour, sets.idle, sets.dtoverride))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 4 ('..Mode4Name..') + Idle + DT Override]')
				end
			end
		else
			if Mode == 'Mode1' then
				equip(set_combine(sets.modeone, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 1 ('..Mode1Name..') + Idle]')
				end
			elseif Mode == 'Mode2' then
				equip(set_combine(sets.modetwo, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 2 ('..Mode2Name..') + Idle]')
				end
			elseif Mode == 'Mode3' then
				equip(set_combine(sets.modethree, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 3 ('..Mode3Name..') + Idle]')
				end
			elseif Mode == 'Mode4' then
				equip(set_combine(sets.modefour, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Mode 4 ('..Mode4Name..') + Idle]')
				end
			end
		end
	end
end

-------------------------------------------
--               PRECAST                 --
-------------------------------------------

function precast(spell)
	if buffactive['Terror'] then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		if LoadHUD == true then
			send_command('text debuffs text "«« TERROR »»";text debuffs color 255 50 50')
		end
		cancel_spell()
		return
	elseif buffactive['Petrification'] then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		if LoadHUD == true then
			send_command('text debuffs text "«« PETRIFICATION »»";text debuffs color 255 50 50')
		end
		cancel_spell()
		return
	elseif buffactive['Sleep'] then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		if LoadHUD == true then
			send_command('text debuffs text "«« SLEEP »»";text debuffs color 255 50 50')
		end
		cancel_spell()
		return
	elseif buffactive['Stun'] then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		if LoadHUD == true then
			send_command('text debuffs text "«« STUN »»";text debuffs color 255 50 50')
		end
		cancel_spell()
		return
	elseif buffactive['Amnesia'] and (spell.type == 'WeaponSkill' or spell.type == 'JobAbility') then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		if LoadHUD == true then
			send_command('text debuffs text "«« AMNESIA »»";text debuffs color 255 50 50')
		end
		cancel_spell()
		return
	elseif buffactive['Silence'] and (spell.prefix == '/magic' or spell.prefix == '/ninjutsu' or spell.prefix == '/song') then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		if LoadHUD == true then
			send_command('text debuffs text "«« SILENCE »»";text debuffs color 255 50 50')
		end
		cancel_spell()
		return
	elseif buffactive['Mute'] and (spell.prefix == '/magic' or spell.prefix == '/ninjutsu' or spell.prefix == '/song') then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		if LoadHUD == true then
			send_command('text debuffs text "«« MUTE »»";text debuffs color 255 50 50')
		end
		cancel_spell()
		return
	elseif spell.type == 'WeaponSkill' then
		if player.tp < 1000 then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
			end
			if LoadHUD == true then
				send_command('text notifications text "«« Not Enough TP »»";text notifications color 255 50 50;text notifications bg_transparency 1')
				NotiCountdown = NotiDelay
				if Debug == 'On' then
					add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
				end
			end
			cancel_spell()
			return
		end
		if ((spell.skill == 'Marksmanship' or spell.skill == 'Archery') and spell.target.distance >= (spell.target.model_size + 23)) or ((spell.target.distance >= (spell.target.model_size + 3)) and not (spell.english == 'Starlight' or spell.english == 'Moonlight')) then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
			end
			if LoadHUD == true then
				send_command('text notifications text "«« Too Far »»";text notifications color 255 50 50;text notifications bg_transparency 1')
				NotiCountdown = NotiDelay
				if Debug == 'On' then
					add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
				end
			end
			cancel_spell()
			return
		end
		-- If an Abyssea Proc weapon pair is equipped inside Abyssea, we don't want to use a WS set
		if checkProcWeapons(player.equipment.main, player.equipment.sub) and string.find(world.area,'Abyssea') then
			return
		end
		if Mode == 'Mode2' then
			if buffactive['Reive Mark'] then
				equip(set_combine(sets.accws, sets.ygnas))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Accuracy Weapon Skill + Ygnas\'s Resolve]')
				end
			else
				equip(sets.accws)
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Accuracy Weapon Skill]')
				end
			end
		elseif player.tp >= CappedTPThreshold then
			if buffactive['Reive Mark'] then
				equip(set_combine(sets.cappedtpws, sets.ygnas))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Capped TP Weapon Skill + Ygnas\'s Resolve]')
				end
			else
				equip(sets.cappedtpws)
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Capped TP Weapon Skill]')
				end
			end
		else
			if sets[spell.english] then
				if buffactive['Reive Mark'] then
					equip(set_combine(sets[spell.english], sets.ygnas))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: '..spell.english..' + Ygnas\'s Resolve]')
					end
				else
					equip(sets[spell.english])
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: '..spell.english..']')
					end
				end
			elseif buffactive['Reive Mark'] then
				equip(set_combine(sets.ws, sets.ygnas))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Weapon Skill - Basic + Ygnas\'s Resolve]')
				end
			else
				equip(sets.ws)
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Weapon Skill - Basic]')
				end
			end
		end
	elseif spell.english == 'Hundred Fists' and windower.ffxi.get_ability_recasts()[0] < 2 then
		equip(sets.hundredfists)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Hundred Fists]')
		end
	elseif spell.english == 'Boost' and windower.ffxi.get_ability_recasts()[16] < 2 then
		equip(sets.boost)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Boost]')
		end
	elseif spell.english == 'Focus' and windower.ffxi.get_ability_recasts()[13] < 2 then
		equip(sets.focus)
		
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Focus]')
		end
	elseif spell.english == 'Dodge' and windower.ffxi.get_ability_recasts()[14] < 2 then
		equip(sets.dodge)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Dodge]')
		end
	elseif spell.english == 'Chakra' and windower.ffxi.get_ability_recasts()[15] < 2 then
		equip(sets.chakra)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Chakra]')
		end
	elseif spell.english == 'Chi Blast' and windower.ffxi.get_ability_recasts()[18] < 2 then
		equip(sets.chiblast)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Chi Blast]')
		end
	elseif spell.english == 'Counterstance' and windower.ffxi.get_ability_recasts()[17] < 2 then
		equip(sets.counterstance)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Counterstance]')
		end
	elseif spell.english == 'Mantra' and windower.ffxi.get_ability_recasts()[19] < 2 then
		equip(sets.mantra)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Mantra]')
		end
	elseif spell.english == 'Formless Strikes' and windower.ffxi.get_ability_recasts()[20] < 2 then
		equip(sets.formlessstrikes)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Formless Strikes]')
		end
	elseif spell.english == 'Perfect Counter' and windower.ffxi.get_ability_recasts()[22] < 2 then
		equip(sets.perfectcounter)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Perfect Counter]')
		end
	elseif (spell.english == 'Spectral Jig' or spell.english == 'Sneak' or spell.english == 'Monomi: Ichi' or spell.english == 'Monomi: Ni') and buffactive['Sneak'] and spell.target.type == 'SELF' then
		send_command('cancel 71')
	elseif spell.english == 'Holy Water' then
		equip(sets.hwater)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Holy Water]')
		end
	end
end

-------------------------------------------
--               MIDCAST                 --
-------------------------------------------

function midcast(spell)
	if spell.type == 'Trust' then
		equip(sets.unity)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Unity]')
		end
	end
end

-------------------------------------------
--              AFTERCAST                --
-------------------------------------------

function aftercast(spell)
	if spell.english == 'Hundred Fists' and HFTimer == 'On' and not spell.interrupted then
		if player.equipment.legs == 'Melee Hose +2' or player.equipment.legs == 'Hes. Hose' or player.equipment.legs == 'Hes. Hose +1' or player.equipment.legs == 'Hes. Hose +2' or player.equipment.legs == 'Hes. Hose +3' then --these pieces extend Hundred Fists by 15 seconds so we adjust accordingly
			send_command('input /echo [Hundred Fists] 60 seconds;wait 15;input /echo [Hundred Fists] 45 seconds;wait 15;input /echo [Hundred Fists] 30 seconds;wait 10;input /echo [Hundred Fists] 20 seconds;wait 10;input /echo [Hundred Fists] 10 seconds')
		else
			send_command('input /echo [Hundred Fists] 45 seconds;wait 15;input /echo [Hundred Fists] 30 seconds;wait 10;input /echo [Hundred Fists] 20 seconds;wait 10;input /echo [Hundred Fists] 10 seconds')
		end
	elseif spell.english == 'Inner Strength' and ISTimer == 'On' and not spell.interrupted then
		send_command('input /echo [Inner Strength] 30 seconds;wait 10;input /echo [Inner Strength] 20 seconds;wait 10;input /echo [Inner Strength] 10 seconds')
	elseif (spell.english == 'Chakra' or spell.english == 'Super Jump' or spell.english == 'High Jump') and not spell.interrupted and player.hp <= AutoSaveThreshold then
		AutoSaveUsed = true
		if Debug == 'On' then
			add_to_chat(8,'[AutoSaveUsed set to True]')
		end
	end
	choose_set()
end

-------------------------------------------
--             STATUS CHANGE             --
-------------------------------------------

function status_change(new,old)
	choose_set() --run this any time your status changes (engage, disengage, rest)
end

-------------------------------------------
--          CUTSCENE: HIDE HUD           --
-------------------------------------------

windower.register_event('status change', function(status)
    if status == 4 and InCS == false and ShowHUD == true then --In a cutscene: Hide the HUD
		InCS = true
		if Debug == 'On' then
			add_to_chat(8,'[InCS set to True]')
		end
		windower.send_command('gs c HideHUD')
    elseif status ~= 4 and InCS == true and ShowHUD == true then --Out of cutscene: Show the HUD
		InCS = false
		if Debug == 'On' then
			add_to_chat(8,'[InrCS set to False]')
		end
		windower.send_command('gs c ShowHUD')
    end
end)

-------------------------------------------
--       Buff/Debuff Notifications       --
-------------------------------------------

windower.register_event('gain buff', function(buff)
	if (buff == 270 or buff == 271 or buff == 272 or buff == 273) and AlertSounds == 'On' and NotiWeapons == 'On' then --Aftermath
		windower.play_sound(windower.addon_path..'data/sounds/AftermathOn.wav')
	elseif (buff == 2 or buff == 19) and not buffactive['Charm'] then --If we get slept,
		if buffactive['Stoneskin'] then --first remove stoneskin if its up,
			send_command('cancel 37')
		end
		if not (buffactive['Poison'] or buffactive['Dia'] or buffactive['bio'] or buffactive['Shock'] or buffactive['Rasp'] or buffactive['Choke'] or buffactive['Frost'] or buffactive['Burn'] or buffactive['Drown'] or buffactive['Requiem'] or buffactive['Kaustra'] or buffactive['Helix']) and player.hp > 100 and player.status == "Engaged" then --then as long as we're not already DOT'd, have more than 100 HP, and are engaged,
			equip({head="Frenzy Sallet"}) --equip the Frenzy Sallet to wake us up
			if Debug == 'On' then
				add_to_chat(8,'[Equipped Item: Frenzy Sallet]')
			end
		end
	elseif buff == 7 or Buff == 10 or buff == 28 then --If we get petrified, stunned, or terrored, then equip the DT Override set
		equip(sets.dtoverride)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: DT Override]')
		end
	elseif buff == 15 then --Doom
		DangerCountdown = DangerRepeat --Start the Danger Sound going
		if Debug == 'On' then
			add_to_chat(8,'[DangerCountdown set to '..DangerRepeat..']')
		end
		if DoomAlert == 'On' then
			Doom = true --Setting "Doom" to true now, so that it can get set to false if we die, that way we don't announce that doom is off when we raise from the dead
			if Debug == 'On' then
				add_to_chat(8,'[Doom set to True]')
			end
			send_command('input /p '..DoomOnText..'')
		end
		if AutoHWater == 'On' then
			HWaterRecast = 3 --Set the recast timer so we can start using the Holy Waters
			HWater = true
			if Debug == 'On' then
				add_to_chat(8,'[HWaterRecast set to 3 | HWater set to True]')
			end
		end
	elseif buff == 17 then --Charm
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
	elseif buff == 71 or buff == 69 then --Sneak or Invisible
		send_command('gs c ClearNotifications')
	elseif buff == 461 and player.status == "Engaged" then
		equip(sets.impetus)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Impetus]')
		end
	elseif buff == 406 and player.status == "Engaged" then
		equip(sets.footwork)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Footwork]')
		end
	end
end)

windower.register_event('lose buff', function(buff)
	if buff == 270 or buff == 271 or buff == 272 or buff == 273 and AlertSounds == 'On' and NotiWeapons == 'On' then --lose any aftermath
		windower.play_sound(windower.addon_path..'data/sounds/AftermathOff.wav')
	elseif buff == 251 and Alive == true and NotiFood == 'On' then --food wears off
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if LoadHUD == true then
			send_command('text notifications text "«« Food Has Worn Off »»";text notifications color 255 50 50;text notifications bg_transparency 1')
			NotiCountdown = NotiDelay
			if Debug == 'On' then
				add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
			end
		end
	elseif buff == 113 and NotiReraise == 'On' and Alive == true then --reraise wears off
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if LoadHUD == true then
			send_command('text notifications text "«« Reraise Has Worn Off »»";text notifications color 255 50 50;text notifications bg_transparency 1')
			NotiCountdown = NotiDelay
			if Debug == 'On' then
				add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
			end
		end
	elseif buff == 602 and string.find(world.area,'Escha') then --Vorseal
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if LoadHUD == true then
			send_command('text notifications text "«« Vorseal Has Worn Off »»";text notifications color 255 50 50;text notifications bg_transparency 1')
			NotiCountdown = NotiDelay
			if Debug == 'On' then
				add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
			end
		end
	elseif buff == 253 then --Signet
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if LoadHUD == true then
			send_command('text notifications text "«« Signet Has Worn Off »»";text notifications color 255 50 50;text notifications bg_transparency 1')
			NotiCountdown = NotiDelay
			if Debug == 'On' then
				add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
			end
		end
	elseif buff == 256 then --Sanction
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if LoadHUD == true then
			send_command('text notifications text "«« Sanction Has Worn Off »»";text notifications color 255 50 50;text notifications bg_transparency 1')
			NotiCountdown = NotiDelay
			if Debug == 'On' then
				add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
			end
		end
	elseif buff == 268 then --Sigil
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if LoadHUD == true then
			send_command('text notifications text "«« Sigil Has Worn Off »»";text notifications color 255 50 50;text notifications bg_transparency 1')
			NotiCountdown = NotiDelay
			if Debug == 'On' then
				add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
			end
		end
	elseif buff == 512 then --Ionis
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if LoadHUD == true then
			send_command('text notifications text "«« Ionis Has Worn Off »»";text notifications color 255 50 50;text notifications bg_transparency 1')
			NotiCountdown = NotiDelay
			if Debug == 'On' then
				add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
			end
		end
	elseif buff == 1 and Alive == true then --Weakness
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav')
		end
		if LoadHUD == true then
			send_command('text notifications text "«« Weakness Has Worn Off »»";text notifications color 75 255 75;text notifications bg_transparency 1')
			NotiCountdown = NotiDelay
			if Debug == 'On' then
				add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
			end
		end
	elseif buff == 2 or buff == 19 or buff == 7 or buff == 17 then --lose sleep, petrify, or charm run choose_set since we changed gear for those
		choose_set()
	elseif buff == 15 then --Doom
		DangerCountdown = 0 --Set to 0 to turn the sound off when we are no longer Doomed
		if Debug == 'On' then
			add_to_chat(8,'[DangerCountdown set to 0]')
		end
		if DoomAlert == 'On' and Doom == true then
			Doom = false --"Doom" gets set to false so that we don't announce that doom is off when we raise from the dead after dying to it.
			if Debug == 'On' then
				add_to_chat(8,'[Doom set to False]')
			end
			send_command('input /p '..DoomOffText..'')
		end
	elseif buff == 71 or buff == 69 then --Sneak or Invisible
		send_command('gs c ClearNotifications')
	end
end)

windower.register_event('tp change',function()
	if player.tp == 3000 and Noti3000TP == 'On' then
		Notifications = '«« 3000 TP »»'
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/3000TP.wav')
		end
		if LoadHUD == true then
			send_command('text notifications text "«« 3000 TP »»";text notifications color '..Aftermath3color..';text notifications bg_transparency 1')
			NotiCountdown = NotiDelay
			if Debug == 'On' then
				add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
			end
		end
	end
end)

-------------------------------------------
--              HEARTBEAT                --
-------------------------------------------

--Miscellaneous things we check for to keep them updated
windower.register_event('prerender', function()

	--Zoning: hide HUD
	local pos = windower.ffxi.get_position()
	if pos == "(?-?)" and Zoning == false and ShowHUD == true then
		send_command('gs c HideHUD')
		Zoning = true
		if Debug == 'On' then
			add_to_chat(8,'[Zoning set to True]')
		end
	elseif pos ~= "(?-?)" and Zoning == true and ShowHUD == true then
		send_command('gs c ShowHUD')
		Zoning = false
		if Debug == 'On' then
			add_to_chat(8,'[Zoning set to False]')
		end
	end

	--Aftermath checks
	if LoadHUD == true then
		if player.equipment.main == 'Spharai' then
			if buffactive['Aftermath'] then
				send_command('text weapons text "Aftermath (Subtle Blow/Kicks)";text weapons color '..Aftermath3color..'')
			elseif player.tp > 1000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath3color..'')
			else
				send_command('text weapons text "« '..EquipMain..' »";text weapons color 255 50 50')
			end
		elseif player.equipment.main == 'Verethragna' then
			if buffactive['Aftermath: Lv.1'] then
				if player.tp == 3000 then
					send_command('text weapons text "Aftermath: Lv.1 (30% Triple Dmg)";text weapons color '..Aftermath3color..'')
				elseif player.tp < 3000 and player.tp >= 2000 then
					send_command('text weapons text "Aftermath: Lv.1 (30% Triple Dmg)";text weapons color '..Aftermath2color..'')
				else
					send_command('text weapons text "Aftermath: Lv.1 (30% Triple Dmg)";text weapons color '..Aftermath1color..'')
				end
			elseif buffactive['Aftermath: Lv.2'] then
				if player.tp == 3000 then
					send_command('text weapons text "Aftermath: Lv.2 (40% Triple Dmg)";text weapons color '..Aftermath3color..'')
				else
					send_command('text weapons text "Aftermath: Lv.2 (40% Triple Dmg)";text weapons color '..Aftermath2color..'')
				end
			elseif buffactive['Aftermath: Lv.3'] then
				send_command('text weapons text "Aftermath: Lv.3 (50% Triple Dmg)";text weapons color '..Aftermath3color..'')
			elseif player.tp == 3000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath3color..'')
			elseif player.tp < 3000 and player.tp >= 2000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath2color..'')
			elseif player.tp < 2000 and player.tp >= 1000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath1color..'')
			else
				send_command('text weapons text "« '..EquipMain..' »";text weapons color 255 50 50')
			end
		elseif player.equipment.main == 'Glanzfaust' then
			if buffactive['Aftermath: Lv.1'] then
				if player.tp == 3000 then
					send_command('text weapons text "Aftermath: Lv.1 (Accuracy)";text weapons color '..Aftermath3color..'')
				elseif player.tp < 3000 and player.tp >= 2000 then
					send_command('text weapons text "Aftermath: Lv.1 (Accuracy)";text weapons color '..Aftermath2color..'')
				else
					send_command('text weapons text "Aftermath: Lv.1 (Accuracy)";text weapons color '..Aftermath1color..'')
				end
			elseif buffactive['Aftermath: Lv.2'] then
				if player.tp == 3000 then
					send_command('text weapons text "Aftermath: Lv.2 (Attack)";text weapons color '..Aftermath3color..'')
				else
					send_command('text weapons text "Aftermath: Lv.2 (Attack)";text weapons color '..Aftermath2color..'')
				end
			elseif buffactive['Aftermath: Lv.3'] then
				send_command('text weapons text "Aftermath: Lv.3 (Occ. Att. 2-3x)";text weapons color '..Aftermath3color..'')
			elseif player.tp == 3000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath3color..'')
			elseif player.tp < 3000 and player.tp >= 2000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath2color..'')
			elseif player.tp < 2000 and player.tp >= 1000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath1color..'')
			else
				send_command('text weapons text "« '..EquipMain..' »";text weapons color 255 50 50')
			end
		elseif player.equipment.main == 'Godhands' then
			if buffactive['Aftermath: Lv.1'] then
				if player.tp == 3000 then
					send_command('text weapons text "Aftermath: Lv.1 (4-Step Ultimate)";text weapons color '..Aftermath3color..'')
				elseif player.tp < 3000 and player.tp >= 2000 then
					send_command('text weapons text "Aftermath: Lv.1 (4-Step Ultimate)";text weapons color '..Aftermath2color..'')
				else
					send_command('text weapons text "Aftermath: Lv.1 (4-Step Ultimate)";text weapons color '..Aftermath1color..'')
				end
			elseif buffactive['Aftermath: Lv.2'] then
				if player.tp == 3000 then
					send_command('text weapons text "Aftermath: Lv.2 (3-Step Ultimate)";text weapons color '..Aftermath3color..'')
				else
					send_command('text weapons text "Aftermath: Lv.2 (3-Step Ultimate)";text weapons color '..Aftermath2color..'')
				end
			elseif buffactive['Aftermath: Lv.3'] then
				send_command('text weapons text "Aftermath: Lv.3 (2-Step Ultimate)";text weapons color '..Aftermath3color..'')
			elseif player.tp == 3000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath3color..'')
			elseif player.tp < 3000 and player.tp >= 2000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath2color..'')
			elseif player.tp < 2000 and player.tp >= 1000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath1color..'')
			else
				send_command('text weapons text "« '..EquipMain..' »";text weapons color 255 50 50')
			end
		else
			send_command('text weapons text "« '..EquipMain..' »";text weapons color 255 50 50')
		end
	end

	--Debuff checks
	if LoadHUD == true and not (TownZones:contains(world.area) or player.target.name == 'Pilgrim Moogle') then
		if buffactive['Charm'] and NotiCharm == 'On' then
			send_command('text debuffs text "«« CHARM »»";text debuffs color 255 50 50;text debuffs bg_transparency 1')
		elseif buffactive['Terror'] and NotiTerror == 'On' then
			send_command('text debuffs text "«« TERROR »»";text debuffs color 255 50 50;text debuffs bg_transparency 1')
		elseif buffactive['Petrification'] and NotiPetrification == 'On' then
			send_command('text debuffs text "«« PETRIFICATION »»";text debuffs color 255 50 50;text debuffs bg_transparency 1')
		elseif buffactive['Sleep'] and NotiSleep == 'On' then
			send_command('text debuffs text "«« SLEEP »»";text debuffs color 255 50 50;text debuffs bg_transparency 1')
		elseif buffactive['Stun'] and NotiStun == 'On' then
			send_command('text debuffs text "«« STUN »»";text debuffs color 255 50 50;text debuffs bg_transparency 1')
		elseif buffactive['Amnesia'] and NotiAmnesia == 'On' then
			send_command('text debuffs text "«« AMNESIA »»";text debuffs color 255 50 50;text debuffs bg_transparency 1')
		elseif buffactive['Silence'] and NotiSilence == 'On' then
			send_command('text debuffs text "«« SILENCE »»";text debuffs color 255 50 50;text debuffs bg_transparency 1')
		elseif buffactive['Mute'] and NotiMute == 'On' then
			send_command('text debuffs text "«« MUTE »»";text debuffs color 255 50 50;text debuffs bg_transparency 1')
		elseif buffactive['Plague'] and NotiPlague == 'On' then
			send_command('text debuffs text "«« PLAGUE »»";text debuffs color 255 50 50;text debuffs bg_transparency 1')
		elseif buffactive['Paralysis'] and NotiPara == 'On' then
			send_command('text debuffs text "«« PARALYSIS »»";text debuffs color 255 50 50;text debuffs bg_transparency 1')
		elseif buffactive['Encumbrance'] and NotiEncumbrance == 'On' then
			send_command('text debuffs text "«« ENCUMBRANCE »»";text debuffs color 255 50 50;text debuffs bg_transparency 1')
		elseif buffactive['Curse'] and NotiCurse == 'On' then
			send_command('text debuffs text "«« CURSE »»";text debuffs color 255 50 50;text debuffs bg_transparency 1')
		elseif not buffactive['Doom'] then
			send_command('gs c ClearDebuffs') --clear debuffs if no other debuffs aside from Doom are present
		end
	end

	--HP checks
	if player.hp == 0 then --are we dead?
		if Alive == true then
			if LoadHUD == true then
				send_command('text notifications text "Status: Dead X_x";text notifications color 255 50 50;text notifications bg_transparency 1')
			end
			NotiCountdown = -1
			if Debug == 'On' then
				add_to_chat(8,'[NotiCountdown set to -1]')
			end
			Alive = false
			if Debug == 'On' then
				add_to_chat(8,'[Alive set to False]')
			end
			Doom = false --turn this off so it doesn't trigger the "doom is off" notification once we raise
			if Debug == 'On' then
				add_to_chat(8,'Doom set to False]')
			end
			if LowHP == true then
				LowHP = false
				if Debug == 'On' then
					add_to_chat(8,'[LowHP set to False]')
				end
			end
		end
	else
		if Alive == false then
			if LoadHUD == true then
				send_command('text notifications text "Status: Alive ^_^";text notifications color 75 255 75;text notifications bg_transparency 1')
			end
			NotiCountdown = -1
			if Debug == 'On' then
				add_to_chat(8,'[NotiCountdown set to -1]')
			end
			send_command('wait 1;gs c AliveDelay') --we use a command to set this to true so that we can set a short delay to prevent things from triggering right when we raise
		end
		if player.hp <= LowHPThreshold then --when HP goes below a certain amount, turn on the LowHP flag and equip the appropriate gear set
			if LowHP == false then
				LowHP = true
				if Debug == 'On' then
					add_to_chat(8,'[LowHP set to True]')
				end
				DangerCountdown = DangerRepeat
				if Debug == 'On' then
					add_to_chat(8,'[DangerCountdown set to '..DangerRepeat..']')
				end
				choose_set()
			end
		elseif player.hp > LowHPThreshold and LowHP == true then --when HP goes back above a certain amount, turn off the LowHP flag and equip the appropriate gear set
			send_command('gs c ClearNotifications')
			LowHP = false
			if Debug == 'On' then
				add_to_chat(8,'[LowHP set to False]')
			end
			choose_set()
		end
		if player.hp > AutoSaveThreshold and AutoSaveUsed == true then --when HP goes back above a certain amount after we used a "save", turn off the AutoSave flag so we can use another "save"
			AutoSaveUsed = false
			if Debug == 'On' then
				add_to_chat(8,'[AutoSaveUsed set to False]')
			end
		end
	end

	--1 second heartbeat
	if os.time() > Heartbeat then
		Heartbeat = os.time() --this gets updated once per second, then we do the things below
		if AutoLockstyle == 'On' and AutoLockstyleRun == true and LockstyleDelay > 0 then
			LockstyleDelay = LockstyleDelay - 1
		elseif AutoLockstyle == 'On' and AutoLockstyleRun == true and LockstyleDelay == 0 then
			send_command('gs c Lockstyle')
			AutoLockstyleRun = false
			if Debug == 'On' then
				add_to_chat(8,'[AutoLockstyleRun set to False]')
			end
		end
		if HWaterRecast == 3 then
			send_command('input /item "Holy Water" <me>')
			HWaterRecast = HWaterRecast - 1
		elseif HWaterRecast == 0 and HWater == true and buffactive['Doom'] then
			HWaterRecast = 3
			if Debug == 'On' then
				add_to_chat(8,'[HWaterRecast set to 3]')
			end
		elseif HWater == true then
			HWaterRecast = HWaterRecast - 1
		end
		if AutoSave == 'On' and player.hp <= AutoSaveThreshold and Alive == true and not (buffactive['Weakness'] or buffactive['Amnesia'] or buffactive['Terror'] or buffactive['Petrification'] or buffactive['Sleep']) and not TownZones:contains(world.area) and not AutoSaveUsed then
			if windower.ffxi.get_ability_recasts()[15] == 0 then
				send_command('input /ja "Chakra" <me>;wait .5;input /ja "Chakra <me>')
			elseif player.status == "Engaged" and Mode ~= 'Mode4' and player.sub_job == 'DRG' and player.sub_job_level >= 50 and windower.ffxi.get_ability_recasts()[160] == 0 then
				send_command('input /ja "Super Jump" <t>;wait .5;input /ja "Super Jump <t>')
			elseif player.status == "Engaged" and Mode ~= 'Mode4' and player.sub_job == 'DRG' and player.sub_job_level >= 35 and windower.ffxi.get_ability_recasts()[159] == 0 then
				send_command('input /ja "High Jump" <t>;wait .5;input /ja "High Jump <t>')
			elseif player.status == "Engaged" and windower.ffxi.get_ability_recasts()[22] == 0 then
				send_command('input /ja "Perfect Counter" <me>;wait .5;input /ja "Perfect Counter <me>')
			end
		end
		if player.equipment.main == nil or player.equipment.sub == nil then
			EquipMain = 'Weapons loading...'
		else
			EquipMain = player.equipment.main
		end
		if LoadHUD == true then

			if ReraiseReminder == 'On' then
				if RRRCountdown > 0 then
					RRRCountdown = RRRCountdown - 1
				else
					if not buffactive['Reraise'] and Alive == true then --if we are dead no need to remind us about reraise
						if AlertSounds == 'On' then
							windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
						end
						send_command('text notifications text "«« No Reraise »»";text notifications color 255 50 50;text notifications bg_transparency 1')
						NotiCountdown = NotiDelay
						if Debug == 'On' then
							add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
						end
					end
					RRRCountdown = RRReminderTimer --start the timer back up
					if Debug == 'On' then
						add_to_chat(8,'[RRRCountdown set to '..RRReminderTimer..']')
					end
				end
			end
			if NotiDoom == 'On' and buffactive['Doom'] then 
				send_command('text debuffs text "«« DOOM »»";text debuffs bg_transparency 200;text debuffs color 0 0 0;text debuffs bg_color 255 255 255;wait .5;text debuffs bg_color 255 204 51')
			end
			if NotiLowHP == 'On' and LowHP == true and Alive == true and not (buffactive['weakness'] or TownZones:contains(world.area)) then
				send_command('text notifications text "Status: LOW HP";text notifications bg_transparency 200;text notifications color 0 0 0;text notifications bg_color 255 255 255;wait .5;text notifications bg_color 255 204 51')
				NotiCountdown = -1
				if Debug == 'On' then
					add_to_chat(8,'[NotiCountdown set to -1]')
				end
			end
			if (NotiDoom == 'On' and buffactive['Doom']) or (NotiLowHP == 'On' and LowHP == true and Alive == true and not (buffactive['weakness'] or TownZones:contains(world.area))) and AlertSounds == 'On' and DangerCountdown > 0 then
				DangerCountdown = DangerCountdown - 1
				windower.play_sound(windower.addon_path..'data/sounds/Danger.wav')
			end
			if NotiCountdown > 0 then
				NotiCountdown = NotiCountdown - 1
			elseif NotiCountdown == 0 then
				send_command('gs c ClearNotifications')
				NotiCountdown = -1
				if Debug == 'On' then
					add_to_chat(8,'[NotiCountdown set to -1]')
				end
			end
			--Moving text object to their appropriate places
			if Mode == "Mode4" then --are we in Tank Mode?
				send_command('text focus pos '..HUDposXColumn1..' -100')						--Focus is not visible
				send_command('text dodge pos '..HUDposXColumn1..' '..HUDposYLine1..'')			--Dodge goes in Column 1
				send_command('text impetus pos '..HUDposXColumn2..' '..HUDposYLine1..'')		--Impetus goes in Column 2
				send_command('text footwork pos '..HUDposXColumn3..' '..HUDposYLine1..'')		--Footwork goes in Column 3
				send_command('text perfectcounter pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Perfect Counter goes in Column 5
				send_command('text chakra pos '..HUDposXColumn6..' '..HUDposYLine1..'')			--Chakra goes in Column 6
				if player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
					send_command('text aggressor pos '..HUDposXColumn4..' '..HUDposYLine1..'')	--Aggressor goes in Column 4
					send_command('text berserk pos '..HUDposXColumn5..' -100')					--Berserk is not visible
					send_command('text highjump pos '..HUDposXColumn5..' -100')					--High Jump is not visible
					send_command('text superjump pos '..HUDposXColumn6..' -100')				--Super Jump is not visible
				elseif player.sub_job == 'DRG' and player.sub_job_level ~= 0 then
					send_command('text aggressor pos '..HUDposXColumn4..' -100')				--Aggressor is not visible
					send_command('text berserk pos '..HUDposXColumn5..' -100')					--Berserk is not visible
					send_command('text highjump pos '..HUDposXColumn4..' '..HUDposYLine1..'')	--High Jump goes in Column 4
					send_command('text superjump pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Super Jump goes in Column 5
				else
					send_command('text berserk pos '..HUDposXColumn4..' -100')					--Berserk is not visible
					send_command('text aggressor pos '..HUDposXColumn5..' -100')				--Aggressor is not visible
					send_command('text highjump pos '..HUDposXColumn4..' -100')					--High Jump is not visible
					send_command('text superjump pos '..HUDposXColumn5..' -100')				--Super Jump is not visible
				end
			else --if not Tank Mode, then we are in one of the DPS modes
				send_command('text focus pos '..HUDposXColumn1..' '..HUDposYLine1..'')			--Focus goes in Column 1
				send_command('text dodge pos '..HUDposXColumn1..' -100')						--Dodge is not visible
				send_command('text impetus pos '..HUDposXColumn2..' '..HUDposYLine1..'')		--Impetus goes in Column 2
				send_command('text footwork pos '..HUDposXColumn3..' '..HUDposYLine1..'')		--Footwork goes in Column 3
				send_command('text perfectcounter pos '..HUDposXColumn4..' -100')				--Perfect Counter is not visible
				send_command('text chakra pos '..HUDposXColumn6..' '..HUDposYLine1..'')			--Chakra goes in Column 6
				if player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
					send_command('text aggressor pos '..HUDposXColumn4..' '..HUDposYLine1..'')	--Aggressor goes in Column 4
					send_command('text berserk pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Berserk goes in Column 5
				end
				if player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
					send_command('text aggressor pos '..HUDposXColumn4..' '..HUDposYLine1..'')	--Aggressor goes in Column 4
					send_command('text berserk pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Berserk goes in Column 5
					send_command('text highjump pos '..HUDposXColumn4..' -100')					--High Jump is not visible
					send_command('text superjump pos '..HUDposXColumn5..' -100')				--Super Jump is not visible
				elseif player.sub_job == 'DRG' and player.sub_job_level ~= 0 then
					send_command('text berserk pos '..HUDposXColumn4..' -100')					--Berserk is not visible
					send_command('text aggressor pos '..HUDposXColumn5..' -100')				--Aggressor is not visible
					send_command('text highjump pos '..HUDposXColumn4..' '..HUDposYLine1..'')	--High Jump goes in Column 4
					send_command('text superjump pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Super Jump goes in Column 5
				else
					send_command('text berserk pos '..HUDposXColumn4..' -100')					--Berserk is not visible
					send_command('text aggressor pos '..HUDposXColumn5..' -100')				--Aggressor is not visible
					send_command('text highjump pos '..HUDposXColumn4..' -100')					--High Jump is not visible
					send_command('text superjump pos '..HUDposXColumn5..' -100')				--Super Jump is not visible
				end

			end
			send_command('text mode pos '..HUDposXColumn1..' '..HUDposYLine2..'')				--Mode goes in Line 2, Column 1
			send_command('text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')		--Notifications goes in Line 3, Column 1
			send_command('text debuffs pos '..HUDposXColumn4..' '..HUDposYLine3..'')			--Debuffs goes in Line 3, Column 4
			--Recast updates:
			FocusRecast = windower.ffxi.get_ability_recasts()[13]
			DodgeRecast = windower.ffxi.get_ability_recasts()[14]
			ImpetusRecast = windower.ffxi.get_ability_recasts()[31]
			FootworkRecast = windower.ffxi.get_ability_recasts()[21]
			PerfectCounterRecast = windower.ffxi.get_ability_recasts()[22]
			ChakraRecast = windower.ffxi.get_ability_recasts()[15]
			if player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
				AggressorRecast = windower.ffxi.get_ability_recasts()[4]
				BerserkRecast = windower.ffxi.get_ability_recasts()[1]
			elseif player.sub_job == 'DRG' and player.sub_job_level ~= 0 then
				HighJumpRecast = windower.ffxi.get_ability_recasts()[159]
				SuperJumpRecast = windower.ffxi.get_ability_recasts()[160]
			end
			--Recast color updates - decide the colors:
			if buffactive['Focus'] then FocusColor = '75 255 75'
			elseif FocusRecast < 2 and FocusRecast ~= 0 then
				FocusColor = '255 165 0'
				send_command('wait .25;text focus color 255 255 125;wait .25;text focus color 255 165 0;wait .25;text focus color 255 255 125')
			elseif FocusRecast > 0 then FocusColor = '255 165 0'
			else FocusColor = '255 50 50'
			end
			if buffactive['Dodge'] then DodgeColor = '75 255 75'
			elseif DodgeRecast < 2 and DodgeRecast ~= 0 then
				DodgeColor = '255 165 0'
				send_command('wait .25;text dodge color 255 255 125;wait .25;text dodge color 255 165 0;wait .25;text dodge color 255 255 125')
			elseif DodgeRecast > 0 then DodgeColor = '255 165 0'
			else DodgeColor = '255 50 50'
			end
			if buffactive['Impetus'] then ImpetusColor = '75 255 75'
			elseif ImpetusRecast < 2 and ImpetusRecast ~= 0 then
				ImpetusColor = '255 165 0'
				send_command('wait .25;text impetus color 255 255 125;wait .25;text impetus color 255 165 0;wait .25;text impetus color 255 255 125')
			elseif ImpetusRecast > 0 then ImpetusColor = '255 165 0'
			else ImpetusColor = '255 50 50'
			end
			if buffactive['Footwork'] then FootworkColor = '75 255 75'
			elseif FootworkRecast < 2 and FootworkRecast ~= 0 then
				FootworkColor = '255 165 0'
				send_command('wait .25;text footwork color 255 255 125;wait .25;text footwork color 255 165 0;wait .25;text footwork color 255 255 125')
			elseif FootworkRecast > 0 then FootworkColor = '255 165 0'
			else FootworkColor = '255 50 50'
			end
			if buffactive['Perfect Counter'] then PerfectCounterColor = '75 255 75'
			elseif PerfectCounterRecast < 2 and PerfectCounterRecast ~= 0 then
				PerfectCounterColor = '255 165 0'
				send_command('wait .25;text perfectcounter color 255 255 125;wait .25;text perfectcounter color 255 165 0;wait .25;text perfectcounter color 255 255 125')
			elseif PerfectCounterRecast > 0 then PerfectCounterColor = '255 165 0'
			else PerfectCounterColor = '255 50 50'
			end
			if ChakraRecast == 0 then ChakraColor = '255 50 50'
			elseif ChakraRecast < 2 then
				ChakraColor = '255 165 0'
				send_command('wait .25;text chakra color 255 255 125;wait .25;text chakra color 255 165 0;wait .25;text chakra color 255 255 125')
			else ChakraColor = '255 165 0'
			end
			if player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
				if buffactive['Aggressor'] then AggressorColor = '75 255 75'
				elseif AggressorRecast < 2 and AggressorRecast ~= 0 then
					AggressorColor = '255 165 0'
					send_command('wait .25;text aggressor color 255 255 125;wait .25;text aggressor color 255 165 0;wait .25;text aggressor color 255 255 125')
				elseif AggressorRecast > 0 then AggressorColor = '255 165 0'
				else AggressorColor = '255 50 50'
				end
				if buffactive['Berserk'] then BerserkColor = '75 255 75'
				elseif BerserkRecast < 2 and BerserkRecast ~= 0 then
					BerserkColor = '255 165 0'
					send_command('wait .25;text berserk color 255 255 125;wait .25;text berserk color 255 165 0;wait .25;text berserk color 255 255 125')
				elseif BerserkRecast > 0 then BerserkColor = '255 165 0'
				else BerserkColor = '255 50 50'
				end
			elseif player.sub_job == 'DRG' and player.sub_job_level ~= 0 then
				if HighJumpRecast < 2 and HighJumpRecast ~= 0 then
					HighJumpColor = '255 165 0'
					send_command('wait .25;text highjump color 255 255 125;wait .25;text highjump color 255 165 0;wait .25;text highjump color 255 255 125')
				elseif HighJumpRecast > 0 then HighJumpColor = '255 165 0'
				else HighJumpColor = '255 50 50'
				end
				if SuperJumpRecast < 2 and SuperJumpRecast ~= 0 then
					SuperJumpColor = '255 165 0'
					send_command('wait .25;text superjump color 255 255 125;wait .25;text superjump color 255 165 0;wait .25;text superjump color 255 255 125')
				elseif SuperJumpRecast > 0 then SuperJumpColor = '255 165 0'
				else SuperJumpColor = '255 50 50'
				end
			end
			--Recast color updates - print the colors:
			send_command('text focus color '..FocusColor..'')
			send_command('text dodge color '..DodgeColor..'')
			send_command('text impetus color '..ImpetusColor..'')
			send_command('text footwork color '..FootworkColor..'')
			send_command('text perfectcounter color '..PerfectCounterColor..'')
			send_command('text chakra color '..ChakraColor..'')
			if player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
				send_command('text aggressor color '..AggressorColor..'')
				send_command('text berserk color '..BerserkColor..'')
			elseif player.sub_job == 'DRG' and player.sub_job_level ~= 0 then			
				send_command('text highjump color '..HighJumpColor..'')
				send_command('text superjump color '..SuperJumpColor..'')
			end
		end
	end
end)

-------------------------------------------
--             ZONE CHANGE               --
-------------------------------------------

windower.register_event('zone change',function()
	if AutoLockstyle == 'On' then
		send_command('gs c Zone Lockstyle') --set the appropriate lockstyle on zone
	end
	if ZoneGear ~= 'Off' then
		send_command('gs c Zone Gear') --equip appropriate gear on zone
	end
	send_command('gs c ClearNotifications') --clear any notifications on zone
	send_command('gs c ClearDebuffs') --clear any debuffs on zone
end)

-------------------------------------------
--           SUB JOB CHANGE              --
-------------------------------------------

function sub_job_change(newSubjob, oldSubjob)
	LockstyleDelay = 3
	if Debug == 'On' then
		add_to_chat(8,'[LockstyleDelay set to 3]')
	end
	if AutoLockstyle == 'On' then
		AutoLockstyleRun = true
		if Debug == 'On' then
			add_to_chat(8,'[AutoLockstyleRun set to True]')
		end
	end
	if SubWARPage ~= "Off" and newSubjob == 'WAR' then
		send_command('wait 2;input /macro set '..SubWARPage..'')
	elseif SubDRGPage ~= "Off" and newSubjob == 'DRG' then
		send_command('wait 2;input /macro set '..SubDRGPage..'')
	else
		send_command('wait 2;input /macro set 1')
	end
end

-------------------------------------------
--        INCOMING TEXT CHECKS           --
-------------------------------------------

windower.register_event('incoming text',function(org)
	if org:find('wishes to trade with you') then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav')
		end
		if NotiTrade == 'On' and LoadHUD == true then
			send_command('text notifications text "«« Trade Request »»";text notifications color 255 255 50;text notifications bg_transparency 1')
		end
	elseif org:find('The effect of') and org:find('is about to wear off.')then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if NotiSneak == 'On' and LoadHUD == true and org:find('Sneak') then
			send_command('text notifications text "«« Sneak Wearing »»";text notifications color 255 100 100;text notifications bg_transparency 1')
		elseif NotiInvis == 'On' and LoadHUD == true and org:find('Invisible') then
			send_command('text notifications text "«« Invisible Wearing »»";text notifications color 255 100 100;text notifications bg_transparency 1')
		end
	elseif org:find('Lost key item') and org:find('Radialens') then
		send_command('gs c Radialens')
	elseif org:find('invites you to') then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav')
		end
		if NotiInvite == 'On' and LoadHUD == true and org:find('party') and not org:find('alliance') then
			send_command('text notifications text "«« Party Invite »»";text notifications color 255 255 50;text notifications bg_transparency 1')
		elseif NotiInvite == 'On' and LoadHUD == true and org:find('alliance') then
			send_command('text notifications text "«« Alliance Invite »»";text notifications color 255 255 50;text notifications bg_transparency 1')
		end
		NotiCountdown = 180
		if Debug == 'On' then
			add_to_chat(8,'[NotiCountdown set to 180]')
		end
	elseif org:find('Your visitant status will wear off in') then
		if org:find(' 15 ') then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
			end
			if NotiTime == 'On' and LoadHUD == true then
				send_command('text notifications text "«« 15 Minutes Remaining »»";text notifications color 255 255 50;text notifications bg_transparency 1')
			end
		elseif org:find(' 10 ') then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
			end
			if NotiTime == 'On' and LoadHUD == true then
				send_command('text notifications text "«« 10 Minutes Remaining »»";text notifications color 255 255 50;text notifications bg_transparency 1')
			end
		elseif org:find(' 5 ') then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
			end
			if NotiTime == 'On' and LoadHUD == true then
				send_command('text notifications text "«« 5 Minutes Remaining »»";text notifications color 255 255 50;text notifications bg_transparency 1')
			end
		end
		NotiCountdown = NotiDelay
		if Debug == 'On' then
			add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
		end
	elseif org:find('Style lock mode enabled.') then
		LockstyleDelay = 5
		if Debug == 'On' then
			add_to_chat(8,'[LockstyleDelay set to 5]')
		end
	elseif org:find('>> /item "Holy Water" <me>') then
		HWater = false
		if Debug == 'On' then
			add_to_chat(8,'[HWater set to False]')
		end
		if LoadHUD == true then
			send_command('text notifications text "«« Out Of Holy Waters »»";text notifications color 255 50 50;text notifications bg_transparency 1')
		end
	elseif org:find('Trade complete') then
		send_command('gs c ClearNotifications')
	end
end)

-------------------------------------------
--         DAMAGE NOTIFICATIONS          --
-------------------------------------------

windower.register_event('action',function(act)

	local sc = {} sc[1] = 'Lght' sc[2] = 'Drkn' sc[3] = 'Grvt' sc[4] = 'Frgm' sc[5] = 'Dstn' sc[6] = 'Fusn' sc[7] = 'Cmpr' sc[8] = 'Lqfn' sc[9] = 'Indr' sc[10] = 'Rvrb' sc[11] = 'Trns' sc[12] = 'Scsn' sc[13] = 'Detn' sc[14] = 'Impc' sc[15] = 'Rdnc' sc[16] = 'Umbr'
	local weaponskills = require('resources').weapon_skills

	--Weapon Skills and Skillchains:
	if NotiDamage == 'On' and act.category == 3 and act.actor_id == player.id then
		--Weapon Skill misses:
		if act.targets[1].actions[1].message == 188 then
			send_command('wait .2;text notifications text "«« '..weaponskills[act.param].english..' Missed »»";text notifications color 0 255 255;text notifications bg_transparency 1')
		--Weapon Skill gets blinked:
		elseif act.targets[1].actions[1].message == 31 then
			send_command('wait .2;text notifications text "«« '..weaponskills[act.param].english..' Blinked »»";text notifications color 0 255 255;text notifications bg_transparency 1')
		--Weapon Skill lands and creates a Skillchain:
		elseif act.targets[1].actions[1].message == 185 and act.targets[1].actions[1].has_add_effect == true then
			send_command('wait .2;text notifications text "'..weaponskills[act.param].english..': '..addCommas(act.targets[1].actions[1].param)..' ('..sc[act.targets[1].actions[1].add_effect_animation]..': '..addCommas(act.targets[1].actions[1].add_effect_param)..')";text notifications color 0 255 255;text notifications bg_transparency 1')
		--Weapon Skill lands but no Skillchain:
		elseif act.targets[1].actions[1].message == 185 then
			send_command('wait .2;text notifications text "'..weaponskills[act.param].english..': '..addCommas(act.targets[1].actions[1].param)..'";text notifications color 0 255 255;text notifications bg_transparency 1')
		end
		NotiCountdown = -1
		if Debug == 'On' then
			add_to_chat(8,'[NotiCountdown set to -1]')
		end
	end
end)

-------------------------------------------
--             FILE UNLOAD               --
-------------------------------------------

function file_unload()
	send_command('wait 1;text bg1 delete;text bg2 delete;text bg3 delete;text focus delete;text dodge delete;text impetus delete;text footwork delete;text aggressor delete;text berserk delete;text highjump delete;text superjump delete;text perfectcounter delete;text chakra delete;text loading delete;text mode delete;text notifications delete;text debuffs delete;text weapons delete') --delete the different text objects
end
