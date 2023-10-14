-------------------------------------------
--  Keys Gearswap lua file for Samurai   --
-------------------------------------------
--[[

REQUIRED Windower Addons: Text

Updates to this file and other GearSwap files and addons can be found at
https://github.com/iLVL-Key/FFXI

Place both this file and the sounds folder inside the GearSwap data folder
	/addons/GearSwap/data/sounds/
	/addons/GearSwap/data/SAM.lua

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
LockstyleCombat	=	'3'		--[1-200]		Your Lockstyle set when in a field zone.
LockstyleTown	=	'1'		--[1-200]		Your Lockstyle set when in a town zone.
							--				If you do not want a separate town lockstyle, set this to the same as LockstyleCombat.
Book			=	'2'		--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
SubDRGPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing DRG.
SubWARPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing WAR.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
MeikTimer		=	'On'	--[On/Off]		Displays a timer for Meikyo Shisui in echo.
YaegTimer		=	'On'	--[On/Off]		Displays a timer for Yaegasumi in echo.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions
							--				(Town limits this to town gear only)
AlertSounds		=	'On'	--[On/Off]		Plays a sound on alerts.
AutoHWater		=	'On'	--[On/Off]		Automatically attempts to use Holy Waters when you get Doomed until it wears off.
AutoStance		=	'On'	--[On/Off]		Automatically activates and keeps Stances active.
AutoSave		=	'On'	--[On/Off]		Attempts to use Super Jump then High Jump, in that order, when your HP gets critically low. Will not activate while in Seigan Stance.
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
Mode3Name = 'All-Round'			--NOTE: Mode 2 is the Hasso Accuracy set which is linked to the Accuracy Weapon Skill set.
Mode4Name = 'Subtle Blow'		--(Using a weapon skill while in mode 2 will default to the Accuracy WS set instead of the standard WS set)

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
StartMode			=	'Mode1'--[Mode1/Mode2/Mode3/Mode4]
								--	Determines the Hasso Mode you will start in. Current Mode can be changed at any time by using any
								--	of the three options listed above in the Notes section (a macro, alias, or keyboard shortcut).
ModeBind			=	'^g'	--Sets the keyboard shortcut you would like to cycle between Hasso Modes. CTRL+G (^g) is default.
DTBind				=	'^d'	--Sets the keyboard shortcut you would like to activate the Damage Taken Override. CTRL+D (^d) is default.
WCBind				=	'^h'	--Sets the keyboard shortcut you would like to activate the Weapon Cycle. CTRL+H (^h) is default.
AutoStanceWindow	=	60		--Time in seconds left before a Stance wears off that AutoStance will activate after another ability.
LowHPThreshold		=	1000	--Below this number is considered Low HP.
AutoSaveThreshold	=	1000	--If your HP goes below this number, Super Jump will be used.
CappedTPThreshold	=	2550	--Using a WS with this much TP or higher will layer in the Capped TP WS set.
AttackCapThreshold	=	6000	--Using a WS with while your attack is above this number will layer in the Attack Cap WS set
DangerRepeat		=	10		--Maximum number of times the Danger Sound will repeat, once per second.
RRReminderTimer		=	1800	--Delay in seconds between checks to see if Reraise is up (300 is 5 minutes)
NotiDelay			=	6		--Delay in seconds before certain notifications will automatically clear.
HUDBGTrans			= 	'175'	--Background transparency for the HUD. (0 = fully clear, 255 = fully opaque)
AddCommas			=	'On'	--[On/Off]  Adds commas to damage numbers.
Debug				=	'Off'	--[On/Off]

--Color Values
HassoStanceColor	=	'125 125 255'	--Hasso
SeiganStanceColor	=	'255 125 125'	--Seigan
Aftermath1color		=	'0 127 255'		--Aftermath Level 1
Aftermath2color		=	'75 255 75'		--Aftermath Level 2
Aftermath3color		=	'255 255 50'	--Aftermath Level 3

-------------------------------------------
--                WEAPONS                --
-------------------------------------------

-- These are the Main/Sub combos that the Weapon Cycle goes through. Add more pairs on new lines as needed
-- NOTE: if a slot should be empty, use `empty` with no quotation marks. ie: {"Fruit Punches", empty},
WeaponCycle = {
	{"Masamune", "Utu Grip"},
	{"Dojikiri Yasutsuna", "Utu Grip"},
	{"Amanomurakumo", "Utu Grip"},
	{"Soboro Sukehiro", "Utu Grip"},
	{"Shining One", "Utu Grip"},
	--{"Main Slot", "Sub Slot"},
}

-- These are the Main/Sub combos that get added to the Weapon Cycle while in Abyssea for Procs. Add more pairs on new lines as needed
-- NOTE: if a slot should be empty, use `empty` with no quotation marks. ie: {"Fruit Punches", empty},
AbysseaProcCycle = {
	{"Excalipoor II", "Blurred Shield +1"},
	{"Yagyu Shortblade", "Blurred Shield +1"},
	{"Melon Slicer", "Flanged Grip"},
	{"Sha Wujing's Lance", "Flanged Grip"},
	--{"Main Slot", "Sub Slot"},
}

-------------------------------------------
--               GEAR SETS               --
-------------------------------------------

function get_sets()

	-- Hasso Standard (Example: Hasso+, with a focus on Multi-Attack, Zanshin, and Store TP, then filling in the rest with DEX, Accuracy, and Attack)
	-- NOTE: This is your standard melee set.
	sets.hassomodeone = {
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Kasuga Domaru +3",
		hands="Tatena. Gote +1",
		legs="Kasuga Haidate +3",
		feet="Ryuo Sune-Ate +1",
		neck="Sam. Nodowa +2",
		waist="Sailfi Belt +1",
		left_ear="Schere Earring",
		right_ear="Kasuga Earring +1",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Mag. Evasion+15',}},
	}

	-- Hasso Accuracy (Example: Hasso+, with a focus on DEX and Accuracy, then filling in the rest with a mix of Multi-Attack, Zanshin, Store TP, and Attack)
	-- NOTE: This is a special mode for accuracy. When in this mode, weapon skills will default to the Accuracy Weapon Skill set.
	sets.hassomodetwo = {
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Kasuga Domaru +3",
		hands="Tatena. Gote +1",
		legs="Kasuga Haidate +3",
		feet="Tatena. Sune. +1",
		neck="Sam. Nodowa +2",
		waist="Sailfi Belt +1",
		left_ear="Schere Earring",
		right_ear="Kasuga Earring +1",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Mag. Evasion+15',}},
	}

	-- Hasso Mode 3 (Example: Hasso+, with a mix of Multi-Attack, Zanshin, Store TP, DEX, Accuracy, and Attack)
	sets.hassomodethree = {
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Kasuga Domaru +3",
		hands="Tatena. Gote +1",
		legs="Kasuga Haidate +3",
		feet="Tatena. Sune. +1",
		neck="Sam. Nodowa +2",
		waist="Sailfi Belt +1",
		left_ear="Schere Earring",
		right_ear="Kasuga Earring +1",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Mag. Evasion+15',}},
	}

	-- Hasso Mode 4 (Example: Hasso+, with a focus on Subtle Blow, then filling in the rest with Multi-Attack, Zanshin, Store TP, and Attack)
	sets.hassomodefour = {
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Dagon Breast.",
		hands="Wakido Kote +3",
		legs="Mpaca's Hose",
		feet="Tatena. Sune. +1",
		neck="Sam. Nodowa +2",
		waist="Sailfi Belt +1",
		left_ear="Schere Earring",
		right_ear="Kasuga Earring +1",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Mag. Evasion+15',}},
	}

	-- Seigan (Seigan+, Third Eye+, Counter, DT-)
	-- NOTE: Intended as a more defense oriented set for when you have to put Seigan up.
	sets.seigan = {
		ammo="Staunch Tathlum +1",
		head="Kasuga Kabuto +3",
		body="Dagon Breast.",
		--body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		--legs="Sakonji Haidate +3",
		feet="Mpaca's Boots",
		neck="Sam. Nodowa +2",
		waist="Sailfi Belt +1",
		left_ear="Schere Earring",
		right_ear="Kasuga Earring +1",
		left_ring="Defending Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Mag. Evasion+15',}},
	}

	-- Idle (Movement Speed, Regain, Regen)
	sets.idle = {
		head="Wakido Kabuto +3",
		feet="Danzo Sune-ate",
		neck="Rep. Plat. Medal",
		left_ring="Karieyh Ring +1",
	}

	-- DT Override (Damage Taken-, Magic Evasion)
	-- NOTE: Will override all other gear sets and inherit unused slots from them
	sets.dtoverride = {
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		legs="Kasuga Haidate +3",
		feet="Nyame Sollerets",
		right_ring="Defending Ring",
	}

	-- Oh Shit
	-- Full DT- and everything you've got with Absorbs or Annuls Damage
	sets.ohshit = {
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		legs="Kasuga Haidate +3",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		left_ring="Defending Ring",
		right_ring="Shadow Ring",
		back="Shadow Mantle"
	}

	-- Weapon Skill - Basic (TP Bonus, STR, Weapon Skill Damage, Attack, Double/Triple Attack)
	sets.ws = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Sakonji Domaru +3",
		hands="Kasuga Kote +3",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sam. Nodowa +2",
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Cornelia's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	-- Weapon Skill - Accuracy (WS Accuracy, Accuracy)
	-- NOTE: This is a special set for weapon skill accuracy. When in the Hasso Accuracy mode (mode 2), weapon skills will use this set.
	sets.accws = set_combine(sets.ws, {
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ring="Karieyh Ring +1",
	})

	-- Weapon Skill - Capped TP (STR, Weapon Skill Damage, Attack, Double/Triple Attack)
	-- NOTE: Intended to override any TP Bonus pieces in your Weapon Skill set if you're already at capped TP
	sets.cappedtpws = {
		head="Nyame Helm",
		left_ear="Lugra Earring +1",
	}

	-- Weapon Skill - Attack Cap (Physical Damage Limit+)
	sets.attackcapws = {
		
	}

	-- Weapon Skill - Hybrid (Magic Attack Bonus, Weapon Skill Damage, STR, Attack, Double/Triple Attack)
	sets.hybridws = set_combine(sets.ws, {
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sam. Nodowa +2",
		waist="Orpheus's Sash",
		left_ear="Moonshade Earring",
		right_ear="Schere Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Cornelia's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	})

	-- Tachi: Ageha (Magic Accuracy)
	sets["Tachi: Ageha"] = set_combine(sets.ws, {
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		hands="Kasuga Kote +3",
		legs="Kasuga Haidate +3",
		feet="Kasuga Sune-Ate +3",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
	})

	-- Tachi: Shoha
	-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
	sets["Tachi: Shoha"] = set_combine(sets.ws, {

	})

	-- Stardiver
	-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
	sets["Stardiver"] = set_combine(sets.ws, {

	})

	-- Hachirin-no-obi
	sets.hachirin = set_combine(sets.hybridws, {
		waist="Hachirin-no-obi",
	})

	-- Ygnas's Resolve +1
	-- NOTE: Will combine with the appropriate Weapon Skill set while participating in a Reive
	sets.ygnas = {
		--neck="Ygnas's Resolve +1",
	}

	-- Sekkanoki
	sets.sekkanoki = {
		hands="Kasuga Kote +3",
	}

	-- Shikikoyo
	sets.shikikoyo = {
		legs="Sakonji Haidate +3",
	}

	-- Blade Bash
	sets.bladebash = {

	}

	-- Sengikori
	sets.sengikori = {
		feet="Kasuga Sune-Ate +3",
	}

	-- Meditate
	sets.meditate = {
		head="Wakido Kabuto +3",
		hands="Sakonji Kote +3",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Occ. inc. resist. to stat. ailments+10',}},
	}
 
	-- Jump (Jumps+, VIT+ Double/Triple Attack, Attack, 
	sets.jump = {
		hands="Crusher Gauntlets",
		feet="Maenadic Gambieras",
	}

	-- Warding Circle
	sets.wardingcircle = {
		head="Wakido Kabuto +3"
	}

	-- Meikyo Shisui
	sets.meikyoshisui = {
		feet="Sak. Sune-Ate +3",
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




FileVersion = '13.2'

-------------------------------------------
--               UPDATES                 --
-------------------------------------------

--[[
MAJOR version updates add new feature(s). Usually require changes in the top portion of the file. Changes to gear sets will be noted.
MINOR version updates change how existing feature(s) function. Usually only require changes under the "Do Not Edit Below This Line".
PATCH version updates fix feature(s) that may not be functioning correctly or are otherwise broken. Usually only require changes under the "Do Not Edit Below This Line".
Ex: 1.2.3 (1 is the Major version, 2 is the Minor version, 3 is the patch version)

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
--           HYBRID WS MAPPING           --
-------------------------------------------

HybridWS = S{
	'Flaming Arrow','Tachi: Goten','Tachi: Kagero','Tachi: Jinpu','Tachi: Koki'
    }

-------------------------------------------
--              FILE LOAD                --
-------------------------------------------

Mode = StartMode --sets the starting mode (selected in the Advanced Options)
Stance = 'None' --Start off without Hasso/Seigan up, this will update when either is activated
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
StanceTimer = 0
LockstyleDelay = 3
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
MeditateRecast = 0
SekkanokiRecast = 0
SengikoriRecast = 0
HagakureRecast = 0
AggressorRecast = 0
BerserkRecast = 0
HighJumpRecast = 0
SuperJumpRecast = 0
HassoRecast = 0
SeiganRecast = 0

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
send_command('wait 1.8;text loading create "Loading Keys SAMURAI file ver: '..FileVersion..' ...";wait .3;text loading size '..FontSize..';text loading pos '..HUDposXColumn1..' '..HUDposYLine1..';text loading bg_transparency 1') --Loading
--Create the Aftermath, Stance, Notifications, and Debuffs text objects and put them above the screen for now, we'll move them to the correct place next
send_command('wait 1.9;text weapons create "« Weapons loading... »";wait .3;text weapons size '..FontSize..';text weapons pos '..HUDposXColumn4..' -100;text weapons color 255 50 50;text weapons bg_transparency 1') --Aftermath
send_command('wait 2;text stance create "Stance: '..Stance..'";wait .3;text stance size '..FontSize..';text stance pos '..HUDposXColumn1..' -100;text stance bg_color 255 50 50;text stance bg_transparency 1') --Stance
send_command('wait 2.1;text notifications create "Hello, '..player.name..'! (type //fileinfo for more information)";wait .3;text notifications size '..FontSize..';text notifications pos '..HUDposXColumn1..' -100;text notifications bg_transparency 1') --Notifications
send_command('wait 2.2;text debuffs create " ";wait .3;text debuffs size '..FontSize..';text debuffs pos '..HUDposXColumn4..' -100;text debuffs bg_transparency 1') --Debuffs
--Create all the HUD Recast text objects and put them above the screen for now, we'll move them to the correct place next
send_command('wait 2.3;text meditate create "[ Meditate ]";wait .3;text meditate size '..FontSize..';text meditate pos '..HUDposXColumn1..' -100;text meditate bg_transparency 1')
send_command('wait 2.4;text sekkanoki create "[ Sekkanoki ]";wait .3;text sekkanoki size '..FontSize..';text sekkanoki pos '..HUDposXColumn1..' -100;text sekkanoki bg_transparency 1')
send_command('wait 2.5;text sengikori create "[ Sengikori ]";wait .3;text sengikori size '..FontSize..';text sengikori pos '..HUDposXColumn1..' -100;text sengikori bg_transparency 1')
send_command('wait 2.6;text hagakure create "[ Hagakure ]";wait .3;text hagakure size '..FontSize..';text hagakure pos '..HUDposXColumn1..' -100;text hagakure bg_transparency 1')
send_command('wait 2.7;text highjump create "[ High J. ]";wait .3;text highjump size '..FontSize..';text highjump pos '..HUDposXColumn1..' -100;text highjump bg_transparency 1')
send_command('wait 2.8;text superjump create "[ Super J. ]";wait .3;text superjump size '..FontSize..';text superjump pos '..HUDposXColumn1..' -100;text superjump bg_transparency 1')
send_command('wait 2.9;text aggressor create "[ Aggres. ]";wait .3;text aggressor size '..FontSize..';text aggressor pos '..HUDposXColumn1..' -100;text aggressor bg_transparency 1')
send_command('wait 3.0;text berserk create "[ Berserk ]";wait .3;text berserk size '..FontSize..';text berserk pos '..HUDposXColumn1..' -100;text berserk bg_transparency 1')
send_command('wait 3.1;text hasso create "[ Hasso ]";wait .3;text hasso size '..FontSize..';text hasso pos '..HUDposXColumn1..' -100;text hasso bg_transparency 1')
send_command('wait 3.2;text seigan create "[ Seigan ]";wait .3;text seigan size '..FontSize..';text seigan pos '..HUDposXColumn1..' -100;text seigan bg_transparency 1')

send_command('alias lockstyle gs c Lockstyle') --creates the first lockstyle aliases
send_command('alias lstyle gs c Lockstyle') --creates the second lockstyle aliases
if Chat ~= "Off" then
	send_command('input /cm '..Chat..'')
end
if Book ~= "Off" then
	send_command('input /macro book '..Book..'')
end
if SubDRGPage ~= "Off" and player.sub_job == 'DRG' then
	send_command('wait 2;input /macro set '..SubDRGPage..'')
elseif SubWARPage ~= "Off" and player.sub_job == 'WAR' then
	send_command('wait 2;input /macro set '..SubWARPage..'')
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
			if Stance == 'Hasso' and LoadHUD == true then
				send_command('text stance text "Stance: Hasso ('..Mode2Name..')";text stance bg_color '..HassoStanceColor..'')
			end
		elseif Mode == 'Mode2' then
			Mode = 'Mode3'
			if Stance == 'Hasso' and LoadHUD == true then
				send_command('text stance text "Stance: Hasso ('..Mode3Name..')";text stance bg_color '..HassoStanceColor..'')
			end
		elseif Mode == 'Mode3' then
			Mode = 'Mode4'
			if Stance == 'Hasso' and LoadHUD == true then
				send_command('text stance text "Stance: Hasso ('..Mode4Name..')";text stance bg_color '..HassoStanceColor..'')
			end
		elseif Mode == 'Mode4' then
			Mode = 'Mode1'
			if Stance == 'Hasso' and LoadHUD == true then
				send_command('text stance text "Stance: Hasso ('..Mode1Name..')";text stance bg_color '..HassoStanceColor..'')
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
		send_command('wait .7;text stance pos '..HUDposXColumn1..' '..HUDposYLine2..'')
		if NotiWeapons == 'On' then
			send_command('wait .7;text weapons pos '..HUDposXColumn4..' '..HUDposYLine2..'')
		end
		send_command('wait .8;text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')
		send_command('wait .8;text debuffs pos '..HUDposXColumn4..' '..HUDposYLine3..'')
	elseif command == 'Fileinfo' then
		add_to_chat(3,'-------------------------------------------')
		add_to_chat(3,'--  Keys Gearswap lua file for Samurai  --')
		add_to_chat(3,'-------------------------------------------')
		add_to_chat(8,' ')
		add_to_chat(200,'File Version: '..(''..FileVersion..''):color(8)..'')
		add_to_chat(8,' ')
		add_to_chat(8,'REQUIRED Windower Addons: Text')
		add_to_chat(8,' ')
		add_to_chat(8,'Place both this file and the sounds folder')
		add_to_chat(8,'inside the GearSwap data folder')
		add_to_chat(200,'ex:     /addons/GearSwap/data/sounds/')
		add_to_chat(200,'        /addons/GearSwap/data/SAM.lua')
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
		add_to_chat(200,'SubDRGPage: '..(''..SubDRGPage..''):color(8)..'')
		add_to_chat(200,'SubWARPage: '..(''..SubWARPage..''):color(8)..'')
		add_to_chat(200,'Chat: '..(''..Chat..''):color(8)..'')
		add_to_chat(200,'MeikTimer: '..(''..MeikTimer..''):color(8)..'')
		add_to_chat(200,'YaegTimer: '..(''..YaegTimer..''):color(8)..'')
		add_to_chat(200,'ZoneGear: '..(''..ZoneGear..''):color(8)..'')
		add_to_chat(200,'AlertSounds: '..(''..AlertSounds..''):color(8)..'')
		add_to_chat(200,'AutoHWater: '..(''..AutoHWater..''):color(8)..'')
		add_to_chat(200,'AutoStance: '..(''..AutoStance..''):color(8)..'')
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
		add_to_chat(200,'AutoStanceWindow: '..(''..AutoStanceWindow..''):color(8)..'')
		add_to_chat(200,'LowHPThreshold: '..(''..LowHPThreshold..''):color(8)..'')
		add_to_chat(200,'AutoSaveThreshold: '..(''..AutoSaveThreshold..''):color(8)..'')
		add_to_chat(200,'CappedTPThreshold: '..(''..CappedTPThreshold..''):color(8)..'')
		add_to_chat(200,'AttackCapThreshold: '..(''..AttackCapThreshold..''):color(8)..'')
		add_to_chat(200,'DangerRepeat: '..(''..DangerRepeat..''):color(8)..'')
		add_to_chat(200,'RRReminderTimer: '..(''..RRReminderTimer..''):color(8)..'')
		add_to_chat(200,'NotiDelay: '..(''..NotiDelay..''):color(8)..'')
		add_to_chat(200,'HUDBGTrans: '..(''..HUDBGTrans..''):color(8)..'')
		add_to_chat(200,'AddCommas: '..(''..AddCommas..''):color(8)..'')
		add_to_chat(200,'Debug: '..(''..Debug..''):color(8)..'')
		add_to_chat(200,' ')
		add_to_chat(3,'-- Color Values --')
		add_to_chat(200,'HassoStanceColor: '..(''..HassoStanceColor..''):color(8)..'')
		add_to_chat(200,'SeiganStanceColor: '..(''..SeiganStanceColor..''):color(8)..'')
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
	elseif command == 'StanceCheck' then
		if not (buffactive['Hasso'] or buffactive['Seigan']) then
			StanceTimer = 0
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
		send_command('text bg1 show;text bg2 show;text bg3 show;text meditate show;text sekkanoki show;text sengikori show;text hagakure show;text aggressor show;text berserk show;text highjump show;text superjump show;text hasso show;text seigan show;text stance show;text notifications show;text debuffs show;text weapons show')
	elseif command == 'HideHUD' then
		send_command('text bg1 hide;text bg2 hide;text bg3 hide;text meditate hide;text sekkanoki hide;text sengikori hide;text hagakure hide;text aggressor hide;text berserk hide;text highjump hide;text superjump hide;text hasso hide;text seigan hide;text stance hide;text notifications hide;text debuffs hide;text weapons hide')
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
		if LowHP == true then --no matter what Stance we're in, if we have low HP we equip the Oh Shit gear set
			equip(sets.ohshit)
			if Debug == 'On' then
				add_to_chat(8,'[Equipped Set: Oh Shit]')
			end
		elseif Stance == 'Hasso' then
			if DTOverride == 'On' then
				if Mode == 'Mode1' then
					equip(set_combine(sets.hassomodeone, sets.dtoverride))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 1 ('..Mode1Name..') + DT Override]')
					end
				elseif Mode == 'Mode2' then
					equip(set_combine(sets.hassomodetwo, sets.dtoverride))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 2 ('..Mode2Name..') + DT Override]')
					end
				elseif Mode == 'Mode3' then
					equip(set_combine(sets.hassomodethree, sets.dtoverride))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 3 ('..Mode3Name..') + DT Override]')
					end
				elseif Mode == 'Mode4' then
					equip(set_combine(sets.hassomodefour, sets.dtoverride))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 4 ('..Mode4Name..') + DT Override]')
					end
				end
			else
				if Mode == 'Mode1' then
					equip(sets.hassomodeone)
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 1 ('..Mode1Name..')]')
					end
				elseif Mode == 'Mode2' then
					equip(sets.hassomodetwo)
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 2 ('..Mode2Name..')]')
					end
				elseif Mode == 'Mode3' then
					equip(sets.hassomodethree)
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 3 ('..Mode3Name..')]')
					end
				elseif Mode == 'Mode4' then
					equip(sets.hassomodefour)
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 4 ('..Mode4Name..')]')
					end
				end
			end
		elseif Stance == 'Seigan' then
			if DTOverride == 'On' then
				equip(set_combine(sets.seigan, sets.dtoverride))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Seigan + DT Override]')
				end
			else
				equip(sets.seigan)
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Seigan]')
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
			if Stance == 'Seigan' then
				equip(set_combine(sets.seigan, sets.adoulin, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Seigan + Adoulin + Idle]')
				end
			else
				if Mode == 'Mode1' then
					equip(set_combine(sets.hassomodeone, sets.adoulin, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 1 ('..Mode1Name..') + Adoulin + Idle]')
					end
				elseif Mode == 'Mode2' then
					equip(set_combine(sets.hassomodetwo, sets.adoulin, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 2 ('..Mode2Name..') + Adoulin + Idle]')
					end
				elseif Mode == 'Mode3' then
					equip(set_combine(sets.hassomodethree, sets.adoulin, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 3 ('..Mode3Name..') + Adoulin + Idle]')
					end
				elseif Mode == 'Mode4' then
					equip(set_combine(sets.hassomodefour, sets.adoulin, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 4 ('..Mode4Name..') + Adoulin + Idle]')
					end
				end
			end
		elseif BastokZones:contains(world.area) then
			if Stance == 'Seigan' then
				equip(set_combine(sets.seigan, sets.bastok, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Seigan + Bastok + Idle]')
				end
			else
				if Mode == 'Mode1' then
					equip(set_combine(sets.hassomodeone, sets.bastok, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 1 ('..Mode1Name..') + Bastok + Idle]')
					end
				elseif Mode == 'Mode2' then
					equip(set_combine(sets.hassomodetwo, sets.bastok, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 2 ('..Mode2Name..') + Bastok + Idle]')
					end
				elseif Mode == 'Mode3' then
					equip(set_combine(sets.hassomodethree, sets.bastok, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 3 ('..Mode3Name..') + Bastok + Idle]')
					end
				elseif Mode == 'Mode4' then
					equip(set_combine(sets.hassomodefour, sets.bastok, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 4 ('..Mode4Name..') + Bastok + Idle]')
					end
				end
			end
		elseif SandyZones:contains(world.area) then
			if Stance == 'Seigan' then
				equip(set_combine(sets.seigan, sets.sandoria, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Seigan + San d\'Oria + Idle]')
				end
			else
				if Mode == 'Mode1' then
					equip(set_combine(sets.hassomodeone, sets.sandoria, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 1 ('..Mode1Name..') + San d\'Oria + Idle]')
					end
				elseif Mode == 'Mode2' then
					equip(set_combine(sets.hassomodetwo, sets.sandoria, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 2 ('..Mode2Name..') + San d\'Oria + Idle]')
					end
				elseif Mode == 'Mode3' then
					equip(set_combine(sets.hassomodethree, sets.sandoria, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 3 ('..Mode3Name..') + San d\'Oria + Idle]')
					end
				elseif Mode == 'Mode4' then
					equip(set_combine(sets.hassomodefour, sets.sandoria, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 4 ('..Mode4Name..') + San d\'Oria + Idle]')
					end
				end
			end
		elseif WindyZones:contains(world.area) then
			if Stance == 'Seigan' then
				equip(set_combine(sets.seigan, sets.windurst, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Seigan + Windurst + Idle]')
				end
			else
				if Mode == 'Mode1' then
					equip(set_combine(sets.hassomodeone, sets.windurst, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 1 ('..Mode1Name..') + Windurst + Idle]')
					end
				elseif Mode == 'Mode2' then
					equip(set_combine(sets.hassomodetwo, sets.windurst, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 2 ('..Mode2Name..') + Windurst + Idle]')
					end
				elseif Mode == 'Mode3' then
					equip(set_combine(sets.hassomodethree, sets.windurst, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 3 ('..Mode3Name..') + Windurst + Idle]')
					end
				elseif Mode == 'Mode4' then
					equip(set_combine(sets.hassomodefour, sets.windurst, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 4 ('..Mode4Name..') + Windurst + Idle]')
					end
				end
			end
		elseif TownZones:contains(world.area) then
			if Stance == 'Seigan' then
				equip(set_combine(sets.seigan, sets.town, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Seigan + Town + Idle]')
				end
			else
				if Mode == 'Mode1' then
					equip(set_combine(sets.hassomodeone, sets.town, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 1 ('..Mode1Name..') + Town + Idle]')
					end
				elseif Mode == 'Mode2' then
					equip(set_combine(sets.hassomodetwo, sets.town, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 2 ('..Mode2Name..') + Town + Idle]')
					end
				elseif Mode == 'Mode3' then
					equip(set_combine(sets.hassomodethree, sets.town, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 3 ('..Mode3Name..') + Town + Idle]')
					end
				elseif Mode == 'Mode4' then
					equip(set_combine(sets.hassomodefour, sets.town, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 4 ('..Mode4Name..') + Town + Idle]')
					end
				end
			end
		elseif LowHP == true then --no matter what Stance we're in, if we have low HP we equip the Oh Shit gear set
			equip(set_combine(sets.idle, sets.ohshit))
			if Debug == 'On' then
				add_to_chat(8,'[Equipped Set: Idle + Oh Shit]')
			end
		elseif DTOverride == 'On' then
			if Stance == 'Seigan' then
				equip(set_combine(sets.seigan, sets.idle, sets.dtoverride))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Seigan + DT Override + Idle]')
				end
			else
				if Mode == 'Mode1' then
					equip(set_combine(sets.hassomodeone, sets.idle, sets.dtoverride))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 1 ('..Mode1Name..') + Idle + DT Override]')
					end
				elseif Mode == 'Mode2' then
					equip(set_combine(sets.hassomodetwo, sets.idle, sets.dtoverride))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 2 ('..Mode2Name..') + Idle + DT Override]')
					end
				elseif Mode == 'Mode3' then
					equip(set_combine(sets.hassomodethree, sets.idle, sets.dtoverride))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 3 ('..Mode3Name..') + Idle + DT Override]')
					end
				elseif Mode == 'Mode4' then
					equip(set_combine(sets.hassomodefour, sets.idle, sets.dtoverride))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 4 ('..Mode4Name..') + Idle + DT Override]')
					end
				end
			end
		else
			if Stance == 'Seigan' then
				equip(set_combine(sets.seigan, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Seigan + Idle]')
				end
			else
				if Mode == 'Mode1' then
					equip(set_combine(sets.hassomodeone, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 1 ('..Mode1Name..') + Idle]')
					end
				elseif Mode == 'Mode2' then
					equip(set_combine(sets.hassomodetwo, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 2 ('..Mode2Name..') + Idle]')
					end
				elseif Mode == 'Mode3' then
					equip(set_combine(sets.hassomodethree, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 3 ('..Mode3Name..') + Idle]')
					end
				elseif Mode == 'Mode4' then
					equip(set_combine(sets.hassomodefour, sets.idle))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hasso Mode 4 ('..Mode4Name..') + Idle]')
					end
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
		if buffactive['Meikyo Shisui'] then
			if HybridWS:contains(spell.english) then
				if ((spell.english == "Flaming Arrow" or spell.english == "Tachi: Kagero") and (world.day_element == "Fire" or world.weather_element == "Fire") and not (world.day_element == "Water" and world.weather_intensity == 1)) or (spell.english == "Tachi: Goten" and (world.day_element == "Lightning" or world.weather_element == "Lightning") and not (world.day_element == "Earth" and world.weather_intensity == 1)) or (spell.english == "Tachi: Jinpu" and (world.day_element == "Wind" or world.weather_element == "Wind") and not (world.day_element == "Wind" and world.weather_intensity == 1)) or (spell.english == "Tachi: Koki" and (world.day_element == "Light" or world.weather_element == "Light") and not (world.day_element == "Dark" and world.weather_intensity == 1)) then
					if buffactive['Reive Mark'] then
						equip(set_combine(sets.hachirin, sets.ygnas, sets.meikyoshisui))
						if Debug == 'On' then
							add_to_chat(8,'[Equipped Set: Hachirin-no-obi + Hybrid Weapon Skill + Ygnas\'s Resolve + Meikyo Shisui]')
						end
					else
						equip(set_combine(sets.hachirin, sets.meikyoshisui))
						if Debug == 'On' then
							add_to_chat(8,'[Equipped Set: Hachirin-no-obi + Hybrid Weapon Skill + Meikyo Shisui]')
						end
					end
				elseif buffactive['Reive Mark'] then
					equip(set_combine(sets.hybridws, sets.ygnas, sets.meikyoshisui))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hybrid Weapon Skill + Ygnas\'s Resolve + Meikyo Shisui]')
					end
				else
					equip(set_combine(sets.hybridws, sets.meikyoshisui))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hybrid Weapon Skill + Meikyo Shisui]')
					end
				end
			elseif spell.english == 'Tachi: Ageha' then
				equip(set_combine(sets["Tachi: Ageha"], sets.meikyoshisui))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Tachi: Ageha + Meikyo Shisui]')
				end
			elseif Mode == 'Mode2' then
				if buffactive['Reive Mark'] then
					equip(set_combine(sets.accws, sets.ygnas, sets.meikyoshisui))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Accuracy Weapon Skill + Ygnas\'s Resolve + Meikyo Shisui]')
					end
				else
					equip(set_combine(sets.accws, sets.meikyoshisui))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Accuracy Weapon Skill + Meikyo Shisui]')
					end
				end
			else
				if sets[spell.english] then
					if buffactive['Reive Mark'] then
						equip(set_combine(sets[spell.english], sets.ygnas, sets.meikyoshisui))
						if Debug == 'On' then
							add_to_chat(8,'[Equipped Set: '..spell.english..' + Ygnas\'s Resolve + Meikyo Shisui]')
						end
					else
						equip(set_combine(sets[spell.english], sets.meikyoshisui))
						if Debug == 'On' then
							add_to_chat(8,'[Equipped Set: '..spell.english..' + Meikyo Shisui]')
						end
					end
				elseif buffactive['Reive Mark'] then
					equip(set_combine(sets.ws, sets.ygnas, sets.meikyoshisui))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Weapon Skill - Basic + Ygnas\'s Resolve + Meikyo Shisui]')
					end
				else
					equip(set_combine(sets.ws, sets.meikyoshisui))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Weapon Skill - Basic + Meikyo Shisui]')
					end
				end
			end
		elseif buffactive['Sekkanoki'] then
			if HybridWS:contains(spell.english) then
				if ((spell.english == "Flaming Arrow" or spell.english == "Tachi: Kagero") and (world.day_element == "Fire" or world.weather_element == "Fire") and not (world.day_element == "Water" and world.weather_intensity == 1)) or (spell.english == "Tachi: Goten" and (world.day_element == "Lightning" or world.weather_element == "Lightning") and not (world.day_element == "Earth" and world.weather_intensity == 1)) or (spell.english == "Tachi: Jinpu" and (world.day_element == "Wind" or world.weather_element == "Wind") and not (world.day_element == "Wind" and world.weather_intensity == 1)) or (spell.english == "Tachi: Koki" and (world.day_element == "Light" or world.weather_element == "Light") and not (world.day_element == "Dark" and world.weather_intensity == 1)) then
					if buffactive['Reive Mark'] then
						equip(set_combine(sets.hachirin, sets.ygnas, sets.sekkanoki))
						if Debug == 'On' then
							add_to_chat(8,'[Equipped Set: Hachirin-no-obi + Hybrid Weapon Skill + Ygnas\'s Resolve + Sekkanoki]')
						end
					else
						equip(set_combine(sets.hachirin, sets.sekkanoki))
						if Debug == 'On' then
							add_to_chat(8,'[Equipped Set: Hachirin-no-obi + Hybrid Weapon Skill + Sekkanoki]')
						end
					end
				elseif buffactive['Reive Mark'] then
					equip(set_combine(sets.hybridws, sets.ygnas, sets.sekkanoki))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hybrid Weapon Skill + Ygnas\'s Resolve + Sekkanoki]')
					end
				else
					equip(set_combine(sets.hybridws, sets.sekkanoki))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hybrid Weapon Skill + Sekkanoki]')
					end
				end
			elseif spell.english == 'Tachi: Ageha' then
				equip(set_combine(sets["Tachi: Ageha"], sets.sekkanoki))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Tachi: Ageha + Sekkanoki]')
				end
			elseif Mode == 'Mode2' then
				if buffactive['Reive Mark'] then
					equip(set_combine(sets.accws, sets.ygnas, sets.sekkanoki))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Accuracy Weapon Skill + Ygnas\'s Resolve + Sekkanoki]')
					end
				else
					equip(set_combine(sets.accws, sets.sekkanoki))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Accuracy Weapon Skill + Sekkanoki]')
					end
				end
			else
				if sets[spell.english] then
					if buffactive['Reive Mark'] then
						equip(set_combine(sets[spell.english], sets.ygnas, sets.sekkanoki))
						if Debug == 'On' then
							add_to_chat(8,'[Equipped Set: '..spell.english..' + Ygnas\'s Resolve + Sekkanoki]')
						end
					else
						equip(set_combine(sets[spell.english], sets.sekkanoki))
						if Debug == 'On' then
							add_to_chat(8,'[Equipped Set: '..spell.english..' + Sekkanoki]')
						end
					end
				elseif buffactive['Reive Mark'] then
					equip(set_combine(sets.ws, sets.ygnas, sets.sekkanoki))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Weapon Skill - Basic + Ygnas\'s Resolve + Sekkanoki]')
					end
				else
					equip(set_combine(sets.ws, sets.sekkanoki))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Weapon Skill - Basic + Sekkanoki]')
					end
				end
			end
		elseif HybridWS:contains(spell.english) then
			if ((spell.english == "Flaming Arrow" or spell.english == "Tachi: Kagero") and (world.day_element == "Fire" or world.weather_element == "Fire") and not (world.day_element == "Water" and world.weather_intensity == 1)) or (spell.english == "Tachi: Goten" and (world.day_element == "Lightning" or world.weather_element == "Lightning") and not (world.day_element == "Earth" and world.weather_intensity == 1)) or (spell.english == "Tachi: Jinpu" and (world.day_element == "Wind" or world.weather_element == "Wind") and not (world.day_element == "Wind" and world.weather_intensity == 1)) or (spell.english == "Tachi: Koki" and (world.day_element == "Light" or world.weather_element == "Light") and not (world.day_element == "Dark" and world.weather_intensity == 1)) then
				if buffactive['Reive Mark'] then
					equip(set_combine(sets.hachirin, sets.ygnas))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hachirin-no-obi + Hybrid Weapon Skill + Ygnas\'s Resolve]')
					end
				else
					equip(sets.hachirin)
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hachirin-no-obi + Hybrid Weapon Skill]')
					end
				end
			elseif buffactive['Reive Mark'] then
				equip(set_combine(sets.hybridws, sets.ygnas))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Hybrid Weapon Skill + Ygnas\'s Resolve]')
				end
			else
				equip(sets.hybridws)
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Hybrid Weapon Skil]')
				end
			end
		elseif spell.english == 'Tachi: Ageha' then
			equip(sets.ageha)
			if Debug == 'On' then
				add_to_chat(8,'[Equipped Set: Tachi: Ageha]')
			end
		elseif player.tp >= CappedTPThreshold then
			if player.attack >= AttackCapThreshold then
				if sets[spell.english] then
					if buffactive['Reive Mark'] then
						equip(set_combine(sets[spell.english], sets.attackcapws, sets.cappedtpws, sets.ygnas))
						if Debug == 'On' then
							add_to_chat(8,'[Equipped Set: '..spell.english..' + Attack Cap + Capped TP + Ygnas\'s Resolve]')
						end
					else
						equip(set_combine(sets[spell.english], sets.attackcapws, sets.cappedtpwss))
						if Debug == 'On' then
							add_to_chat(8,'[Equipped Set: '..spell.english..' + Attack Cap + Capped TP]')
						end
					end
				elseif buffactive['Reive Mark'] then
					equip(set_combine(sets.ws, sets.attackcapws, sets.cappedtpws, sets.ygnas))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Weapon Skill - Basic + Attack Cap + Capped TP + Ygnas\'s Resolve]')
					end
				else
					equip(set_combine(sets.ws, sets.attackcapws, sets.cappedtpwss))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Weapon Skill - Basic + Attack Cap + Capped TP]')
					end
				end
			else
				if sets[spell.english] then
					if buffactive['Reive Mark'] then
						equip(set_combine(sets[spell.english], sets.cappedtpws, sets.ygnas))
						if Debug == 'On' then
							add_to_chat(8,'[Equipped Set: '..spell.english..' + Capped TP + Ygnas\'s Resolve]')
						end
					else
						equip(set_combine(sets[spell.english], sets.cappedtpwss))
						if Debug == 'On' then
							add_to_chat(8,'[Equipped Set: '..spell.english..' + Capped TP]')
						end
					end
				elseif buffactive['Reive Mark'] then
					equip(set_combine(sets.ws, sets.cappedtpws, sets.ygnas))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Weapon Skill - Basic + Capped TP + Ygnas\'s Resolve]')
					end
				else
					equip(set_combine(sets.ws, sets.cappedtpwss))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Weapon Skill - Basic + Capped TP]')
					end
				end
			end
		elseif player.attack >= AttackCapThreshold then
			if sets[spell.english] then
				if buffactive['Reive Mark'] then
					equip(set_combine(sets[spell.english], sets.attackcapws, sets.ygnas))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: '..spell.english..' + Attack Cap + Ygnas\'s Resolve]')
					end
				else
					equip(set_combine(sets[spell.english], sets.attackcapwss))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: '..spell.english..' + Attack Cap]')
					end
				end
			elseif buffactive['Reive Mark'] then
				equip(set_combine(sets.ws, sets.attackcapws, sets.ygnas))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Weapon Skill - Basic + Attack Cap + Ygnas\'s Resolve]')
				end
			else
				equip(set_combine(sets.ws, sets.attackcapwss))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Weapon Skill - Basic + Attack Cap]')
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
	elseif spell.english == 'Meditate' and windower.ffxi.get_ability_recasts()[134] < 2 then
		equip(sets.meditate)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Meditate]')
		end
	elseif string.find(spell.english,'Jump') and windower.ffxi.get_ability_recasts()[158] < 2 then
		equip(sets.jump)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Jump]')
		end
	elseif spell.english == 'Warding Circle' and windower.ffxi.get_ability_recasts()[135] < 2 then
		equip(sets.wardingcircle)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Warding Circle]')
		end
	elseif spell.english == 'Shikikoyo' and windower.ffxi.get_ability_recasts()[136] < 2 then
		equip(sets.shikikoyo)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Shikikoyo]')
		end
	elseif spell.english == 'Blade Bash' and windower.ffxi.get_ability_recasts()[137] < 2 then
		equip(sets.bladebash)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Blade Bash]')
		end
	elseif spell.english == 'Sengikori' and windower.ffxi.get_ability_recasts()[141] < 2 then
		equip(sets.sengikori)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Sengikori]')
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
	if spell.english == 'Meikyo Shisui' and MeikTimer == 'On' and not spell.interrupted then
		send_command('input /echo [Meikyo Shisui] 30 seconds;wait 10;input /echo [Meikyo Shisui] 20 seconds;wait 10;input /echo [Meikyo Shisui] 10 seconds')
	elseif spell.english == 'Yaegasumi' and IntTimer == 'On' and not spell.interrupted then
		send_command('wait 5;input /echo [Yaegasumi] 40 seconds;wait 10;input /echo [Yaegasumi] 30 seconds;wait 10;input /echo [Yaegasumi] 20 seconds;wait 10;input /echo [Yaegasumi] 10 seconds')
	elseif spell.english == 'Hasso' and not spell.interrupted then
		Stance = 'Hasso' --Set Stance to Hasso when we use it
		send_command('text stance bg_transparency 150')
		if Debug == 'On' then
			add_to_chat(8,'[Stance set to Hasso]')
		end
		StanceTimer = 300
		if Debug == 'On' then
			add_to_chat(8,'[StanceTimer set to 300]')
		end
	elseif spell.english == 'Seigan' and not spell.interrupted then
		Stance = 'Seigan' --Set Stance to Seigan when we use it
		send_command('text stance bg_transparency 150')
		if Debug == 'On' then
			add_to_chat(8,'[Stance set to Seigan]')
		end
		StanceTimer = 300
		if Debug == 'On' then
			add_to_chat(8,'[StanceTimer set to 300]')
		end
	elseif (spell.english == 'Super Jump' or spell.english == 'High Jump') and not spell.interrupted and player.hp <= AutoSaveThreshold then
		AutoSaveUsed = true
		if Debug == 'On' then
			add_to_chat(8,'[AutoSaveUsed set to True]')
		end
	end
	choose_set()
	if AutoStance and StanceTimer < AutoStanceWindow and not buffactive['Amnesia'] and not spell.interrupted then
		if Stance == 'Seigan' and windower.ffxi.get_ability_recasts()[139] == 0 then
			if spell.type == 'WeaponSkill' then
				send_command('wait 3;input /ja Seigan <me>')
			elseif spell.type == 'JobAbility' then
				send_command('wait .5;input /ja Seigan <me>')
			end
		elseif windower.ffxi.get_ability_recasts()[138] == 0 then
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

function status_change(new,old)
	choose_set() --run this any time your status changes (engage, disengage, rest)
	if new == 'Engaged' or new == 'Idle' then
		if AutoStance and StanceTimer < AutoStanceWindow and not buffactive['Amnesia'] and not TownZones:contains(world.area) then
			if Stance == 'Seigan' and windower.ffxi.get_ability_recasts()[139] == 0 then
				send_command('input /ja Seigan <me>')
			elseif windower.ffxi.get_ability_recasts()[138] == 0 then
				send_command('input /ja Hasso <me>')
			end
		end
	end
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
		if not (buffactive['Poison'] or buffactive['Dia'] or buffactive['bio'] or buffactive['Shock'] or buffactive['Rasp'] or buffactive['Choke'] or buffactive['Frost'] or buffactive['Burn'] or buffactive['Drown'] or buffactive['Requiem'] or buffactive['Kaustra'] or buffactive['Helix']) and player.hp > 50 and player.status == "Engaged" then --then as long as we're not already DOT'd, have more than 50 HP, and are engaged,
			equip({neck="Vim Torque"}) --equip the Vim Torque to wake us up
			if Debug == 'On' then
				add_to_chat(8,'[Equipped Item: Vim Tourque]')
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
	elseif buff == 353 or buff == 354 then --Hasso or Seigan
		send_command('wait 1;gs c StanceCheck')
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
		if player.equipment.main == 'Amanomurakumo' then
			if buffactive['Aftermath'] then
				send_command('text weapons text "Aftermath (Zanshin/STP)";text weapons color '..Aftermath3color..'')
			elseif player.tp > 1000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath3color..'')
			else
				send_command('text weapons text "« '..EquipMain..' »";text weapons color 255 50 50')
			end
		elseif player.equipment.main == 'Masamune' then
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
		elseif player.equipment.main == 'Kogarasumaru' then
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
		elseif player.equipment.main == 'Dojikiri Yasutsuna' then
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
		if player.hp > AutoSaveThreshold and AutoSaveUsed == true then --when HP goes back above a certain amountafter we use a "save", turn off the AutoSave flag so we can use another "save"
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
		if AutoSave == 'On' and player.sub_job == 'DRG' and player.hp <= AutoSaveThreshold and Alive == true and not (buffactive['Weakness'] or buffactive['Amnesia'] or buffactive['Terror'] or buffactive['Petrification'] or buffactive['Sleep'] or Stance == 'Seigan') and player.status == "Engaged" and not TownZones:contains(world.area) then
			if player.sub_job_level >= 50 and windower.ffxi.get_ability_recasts()[160] == 0 then
				send_command('input /ja "Super Jump" <t>;wait .5;input /ja "Super Jump <t>')
			elseif player.sub_job_level >= 35 and windower.ffxi.get_ability_recasts()[159] == 0 then
				send_command('input /ja "High Jump" <t>;wait .5;input /ja "High Jump <t>')
			end
		end
		if player.equipment.main == nil or player.equipment.sub == nil then
			EquipMain = 'Weapons loading...'
		else
			EquipMain = player.equipment.main
		end
		if LoadHUD == true then
			if (buffactive['Hasso'] or buffactive['Seigan']) then
				if StanceTimer > 151 then
					StanceTimer = StanceTimer - 1
					send_command('text stance bg_transparency 150')
				elseif StanceTimer > 21 then
					StanceTimer = StanceTimer - 1
					send_command('text stance bg_transparency '..StanceTimer..'')
				elseif StanceTimer > 0 then
					StanceTimer = StanceTimer - 1
					send_command('text stance bg_transparency 150')
				else
					send_command('text stance bg_transparency 150')
				end
			end
			if buffactive['Hasso'] then --Hasso is up, so we're in Hasso Stance
				--Stance = 'Hasso'
				if StanceTimer == 0 then
					send_command('text stance text "Stance: Hasso ('..Mode1Name..')";text stance bg_color '..HassoStanceColor..'')
				elseif StanceTimer <= 20 then
					send_command('text stance text "Stance: Wearing off in '..StanceTimer..'";text stance bg_color '..HassoStanceColor..'')
				elseif Mode == 'Mode1' then
					send_command('text stance text "Stance: Hasso ('..Mode1Name..')";text stance bg_color '..HassoStanceColor..'')
				elseif Mode == 'Mode2' then
					send_command('text stance text "Stance: Hasso ('..Mode2Name..')";text stance bg_color '..HassoStanceColor..'')
				elseif Mode == 'Mode3' then
					send_command('text stance text "Stance: Hasso ('..Mode3Name..')";text stance bg_color '..HassoStanceColor..'')
				elseif Mode == 'Mode4' then
					send_command('text stance text "Stance: Hasso ('..Mode4Name..')";text stance bg_color '..HassoStanceColor..'')
				end
			elseif buffactive['Seigan'] then --Seigan is up, so we're in Seigan Stance
				--Stance = 'Seigan'
				if StanceTimer <= 20 then
					send_command('text stance text "Stance: Wearing off in '..StanceTimer..'";text stance bg_color '..SeiganStanceColor..'')
				else
					send_command('text stance text "Stance: Seigan";text stance bg_color '..SeiganStanceColor..'')
				end
			else --Neither Hasso or Seigan is up, no stance is set
				send_command('text stance text "Stance: None";text stance bg_color 255 50 50;text stance bg_transparency 150')
			end
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
			if buffactive['Hasso'] or buffactive['Seigan'] then --are we in Hasso or Seigan Stance?
				send_command('text hasso pos '..HUDposXColumn1..' -100')						--Hasso is not visible
				send_command('text seigan pos '..HUDposXColumn2..' -100')						--Seigan is not visible
				send_command('text meditate pos '..HUDposXColumn1..' '..HUDposYLine1..'')		--Meditate goes in Column 1
				send_command('text sekkanoki pos '..HUDposXColumn2..' '..HUDposYLine1..'')		--Sekkanoki goes in Column 2
				send_command('text sengikori pos '..HUDposXColumn3..' '..HUDposYLine1..'')		--Sengikori goes in Column 3
				send_command('text hagakure pos '..HUDposXColumn4..' '..HUDposYLine1..'')		--Hagakure goes in Column 4
				if player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
					send_command('text berserk pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Berserk goes in Column 5
					send_command('text aggressor pos '..HUDposXColumn6..' '..HUDposYLine1..'')	--Aggressor goes in Column 6
					send_command('text highjump pos '..HUDposXColumn5..' -100')					--High Jump is not visible
					send_command('text superjump pos '..HUDposXColumn6..' -100')				--Super Jump is not visible
				elseif player.sub_job == 'DRG' and player.sub_job_level ~= 0 then
					send_command('text berserk pos '..HUDposXColumn5..' -100')					--Berserk is not visible
					send_command('text aggressor pos '..HUDposXColumn6..' -100')				--Aggressor is not visible
					send_command('text highjump pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--High Jump goes in Column 5
					send_command('text superjump pos '..HUDposXColumn6..' '..HUDposYLine1..'')	--Super Jump goes in Column 6
				else
					send_command('text berserk pos '..HUDposXColumn5..' -100')					--Berserk is not visible
					send_command('text aggressor pos '..HUDposXColumn6..' -100')				--Aggressor is not visible
					send_command('text highjump pos '..HUDposXColumn5..' -100')					--High Jump is not visible
					send_command('text superjump pos '..HUDposXColumn6..' -100')				--Super Jump is not visible
				end
			else --if not Hasso or Seigan, then we have no Stance set currently
				send_command('text hasso pos '..HUDposXColumn1..' '..HUDposYLine1..'')			--Hasso goes in Column 1
				send_command('text seigan pos '..HUDposXColumn2..' '..HUDposYLine1..'')			--Seigan goes in Column 2
				send_command('text meditate pos '..HUDposXColumn1..' -100')						--Meditate goes in Column 1
				send_command('text sekkanoki pos '..HUDposXColumn2..' -100')					--Sekkanoki goes in Column 2
				send_command('text sengikori pos '..HUDposXColumn3..' -100')					--Sengikori goes in Column 3
				send_command('text hagakure pos '..HUDposXColumn4..' -100')						--Hagakure goes in Column 4
				send_command('text berserk pos '..HUDposXColumn5..' -100')						--Berserk is not visible
				send_command('text aggressor pos '..HUDposXColumn6..' -100')					--Aggressor is not visible
				send_command('text highjump pos '..HUDposXColumn5..' -100')						--High Jump is not visible
				send_command('text superjump pos '..HUDposXColumn6..' -100')					--Super Jump is not visible
			end
			send_command('text stance pos '..HUDposXColumn1..' '..HUDposYLine2..'')				--Stance goes in Line 2, Column 1
			send_command('text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')		--Notifications goes in Line 3, Column 1
			send_command('text debuffs pos '..HUDposXColumn4..' '..HUDposYLine3..'')			--Debuffs goes in Line 3, Column 4
			--Recast updates:
			MeditateRecast = windower.ffxi.get_ability_recasts()[134]
			SekkanokiRecast = windower.ffxi.get_ability_recasts()[140]
			SengikoriRecast = windower.ffxi.get_ability_recasts()[141]
			HagakureRecast = windower.ffxi.get_ability_recasts()[54]
			HassoRecast = windower.ffxi.get_ability_recasts()[138]
			SeiganRecast = windower.ffxi.get_ability_recasts()[139]
			if player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
				AggressorRecast = windower.ffxi.get_ability_recasts()[4]
				BerserkRecast = windower.ffxi.get_ability_recasts()[1]
			elseif player.sub_job == 'DRG' and player.sub_job_level ~= 0 then
				HighJumpRecast = windower.ffxi.get_ability_recasts()[159]
				SuperJumpRecast = windower.ffxi.get_ability_recasts()[160]
			end
			--Recast color updates - decide the colors:
			if MeditateRecast == 0 then MeditateColor = '255 50 50'
			elseif MeditateRecast < 2 then
				MeditateColor = '255 165 0'
				send_command('wait .25;text meditate color 255 255 125;wait .25;text meditate color 255 165 0;wait .25;text meditate color 255 255 125')
			else MeditateColor = '255 165 0'
			end
			if buffactive['Sekkanoki'] then SekkanokiColor = '75 255 75'
			elseif SekkanokiRecast < 2 and SekkanokiRecast ~= 0 then
				SekkanokiColor = '255 165 0'
				send_command('wait .25;text sekkanoki color 255 255 125;wait .25;text sekkanoki color 255 165 0;wait .25;text sekkanoki color 255 255 125')
			elseif SekkanokiRecast > 0 then SekkanokiColor = '255 165 0'
			else SekkanokiColor = '255 50 50'
			end
			if buffactive['Sengikori'] then SengikoriColor = '75 255 75'
			elseif SengikoriRecast < 2 and SengikoriRecast ~= 0 then
				SengikoriColor = '255 165 0'
				send_command('wait .25;text sengikori color 255 255 125;wait .25;text sengikori color 255 165 0;wait .25;text sengikori color 255 255 125')
			elseif SengikoriRecast > 0 then SengikoriColor = '255 165 0'
			else SengikoriColor = '255 50 50'
			end
			if buffactive['Hagakure'] then HagakureColor = '75 255 75'
			elseif HagakureRecast < 2 and HagakureRecast ~= 0 then
				HagakureColor = '255 165 0'
				send_command('wait .25;text hagakure color 255 255 125;wait .25;text hagakure color 255 165 0;wait .25;text hagakure color 255 255 125')
			elseif HagakureRecast > 0 then HagakureColor = '255 165 0'
			else HagakureColor = '255 50 50'
			end
			if buffactive['Hasso'] then HassoColor = '75 255 75'
			elseif HassoRecast < 2 and HassoRecast ~= 0 then
				HassoColor = '255 165 0'
				send_command('wait .25;text hasso color 255 255 125;wait .25;text hasso color 255 165 0;wait .25;text hasso color 255 255 125')
			elseif HassoRecast > 0 then HassoColor = '255 165 0'
			else HassoColor = '255 50 50'
			end
			if buffactive['Seigan'] then SeiganColor = '75 255 75'
			elseif SeiganRecast < 2 and SeiganRecast ~= 0 then
				SeiganColor = '255 165 0'
				send_command('wait .25;text seigan color 255 255 125;wait .25;text seigan color 255 165 0;wait .25;text seigan color 255 255 125')
			elseif SeiganRecast > 0 then SeiganColor = '255 165 0'
			else SeiganColor = '255 50 50'
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
			send_command('text meditate color '..MeditateColor..'')
			send_command('text sekkanoki color '..SekkanokiColor..'')
			send_command('text sengikori color '..SengikoriColor..'')
			send_command('text hagakure color '..HagakureColor..'')
			send_command('text hasso color '..HassoColor..'')
			send_command('text seigan color '..SeiganColor..'')
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
	if SubDRGPage ~= "Off" and newSubjob == 'DRG' then
		send_command('wait 2;input /macro set '..SubDRGPage..'')
	elseif SubWARPage ~= "Off" and newSubjob == 'WAR' then
		send_command('wait 2;input /macro set '..SubWARPage..'')
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
	send_command('wait 1;text bg1 delete;text bg2 delete;text bg3 delete;text meditate delete;text sekkanoki delete;text sengikori delete;text hagakure delete;text aggressor delete;text berserk delete;text highjump delete;text superjump delete;text hasso delete;text seigan delete;text loading delete;text stance delete;text notifications delete;text debuffs delete;text weapons delete') --delete the different text objects
end
