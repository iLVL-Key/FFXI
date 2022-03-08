-------------------------------------------
--  Keys Gearswap lua file for Paladin   --
-------------------------------------------

-------------------------------------------
--                 NOTES                 --
-------------------------------------------
--[[
Place both this file and the sounds folder inside the GearSwap data folder
	/addons/GearSwap/data/sounds/
	/addons/GearSwap/data/PLD.lua

To switch between gear modes, use any of these three options:
1. A macro with the following in it
	/console mode
2. An alias command
	//mode
3. A keyboard shortcut
	CTRL+G
	(Default is G, can be changed in the settings)

Run the Lockstyle function yourself at any time by typing
	//lockstyle or //lstyle

For the HUD function (see options below), suggested placement is center screen, just above your chat log.

IMPORTANT:
When you load this file for the first time, your HUD may look all wrong. The defaults preloaded are for a screen at 3440x1400.
Adjust the FontSize, LineSpacer, and ColumnSpacer options below as needed.

Recommended Windower Addons: Text
--]]
-------------------------------------------
--                OPTIONS                --
-------------------------------------------

Mode			=	'Tank'	--[Tank/DPS]	Sets the starting mode
AutoLockstyle	=	'On'	--[On/Off]		Automatically sets your lockstyle. Uses the Field and Town sets below.
LockstyleField	=	'5'		--[1-20]		Your Lockstyle set when in a field zone.
LockstyleTown	=	'1'		--[1-20]		Your Lockstyle set when in a town zone.
							--				If you do not want a separate town lockstyle, set this to the same as LockstyleField.
Book			=	'3'		--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
Page			=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
InvTimer		=	'On'	--[On/Off]		Displays a timer for Invincible in echo.
IntTimer		=	'On'	--[On/Off]		Displays a timer for Intervene in echo.
ModeCtrlPlus	=	'g'		--				Sets the keyboard shortcut you would like to cycle between Modes. CTRL+G is default.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions
							--				(Town limits this to town gear only)
AlertSounds		=	'On'	--[On/Off]		Plays a sound on alerts.
UseEcho			=	'R'		--[E/R/Off]		Automatically uses an Echo Drop (E), or Remedy (R) instead of spell when you are silenced.
AutoMajesty		=	'On'	--[On/Off]		Automatically activates Majesty before a cure/protect when Majesty is down.
AutoDefender	=	'On'	--[On/Off]		Automatically activates Defender after other defensive or hate generating abilities/spells when
							--				Defender is down and in Tank mode.

-- Heads Up Display --
HUD				=	'On'	--[On/Off]		A Heads Up Display for various things. Requires the Text Windower addon.
HUDposX			=	967		--				X position for the HUD. 0 is left of the window, increasing this number will move it to the right.
HUDposYLine1	=	745		--				Y position for the HUD. 0 is top of the window, increasing this number will move it downward.
							--				Note that this is for the first line of the HUD, the other lines will self-adjust. If you cannot
							--				see the HUD, set the x and y both to 100 to make sure it is showing up, then adjust from there.
FontSize		=	12		--				Font size. Changing this will require you to adjust the Spacers below as well.
LineSpacer		=	20		--				Space in pixels between each Line of the HUD
ColumnSpacer	=	93		--				Space in pixels between each Column of the HUD
HUDRecast		=	'On'	--[On/Off]		Displays common spells/abilities and their recast status

--  General Notifications  --
Noti3000TP			=	'On'	--[On/Off]	Displays a notification when you have 3000 TP.
NotiAftermath		=	'On'	--[On/Off]	Displays Aftermath information.
NotiTrade			=	'Off'	--[On/Off]	Displays a notification when someone trades you.
NotiInvite			=	'Off'	--[On/Off]	Displays a notification when someone invites to a party/alliance.
NotiSneak			=	'Off'	--[On/Off]	Displays a notification when Sneak is about to wear off.
NotiInvis			=	'Off'	--[On/Off]	Displays a notification when Invisible is about to wear off.
NotiReraise			=	'Off'	--[On/Off]	Displays a notification when reraise wears off.
NotiFood			=	'Off'	--[On/Off]	Displays a notification when food wears off.
NotiLowMP			=	'On'	--[On/Off]	Displays a notification when MP is under 20%. Will not trigger again for another 30 seconds.
NotiTPReturn		=	'On'	--[On/Off]	Displays your TP return after Weapon Skills.
ReraiseReminder		=	'On'	--[On/Off]	Displays an occasional reminder if Reraise is not up.
ReraiseReminderTimer=	1800	--			Delay in seconds between checks to see if Reraise is up (300 is 5 minutes)

-- Debuff Notifications --
NotiSleep			=	'On'	--[On/Off]	Displays a notification when you are slept.
NotiSilence			=	'On'	--[On/Off]	Displays a notification when you are silenced.
NotiPetrification	=	'On'	--[On/Off]	Displays a notification when you are petrified.
NotiCurse			=	'On'	--[On/Off]	Displays a notification when you are cursed.
NotiStun			=	'On'	--[On/Off]	Displays a notification when you are stunned.
NotiCharm			=	'On'	--[On/Off]	Displays a notification when you are charmed.
NotiDoom			=	'On'	--[On/Off]	Displays a notification when you are doomed.
NotiAmnesia			=	'On'	--[On/Off]	Displays a notification when you have amnesia.
NotiTerror			=	'On'	--[On/Off]	Displays a notification when you are terrorized.
NotiMute			=	'On'	--[On/Off]	Displays a notification when you are muted.
NotiPlague			=	'On'	--[On/Off]	Displays a notification when you are plagued.
NotiPara			=	'On'	--[On/Off]	Displays a notification when you are paralyzed.

-------------------------------------------
--           ADVANCED OPTIONS            --
-------------------------------------------

HUDBGTrans = 		'175'	--Background transparency for the HUD. (0 = fully clear, 255 = fully opaque)
TPReturnWait =		'0.2'	--Adjust this timing in seconds as needed. (TP Return may not always be 100% accurate
							--depending on lag, regain, etc.)
Debug =				'Off'	--[On/Off]

--Color values in RGB for the HUD gear modes
DPScolor =			'125 125 255'	--DPS
Tankcolor =			'255 125 125'	--Tank

--Color values in RGB for the HUD Aftermath status
Aftermath1color =	'0 127 255'		--Aftermath Level 1
Aftermath2color =	'75 255 75'		--Aftermath Level 2
Aftermath3color =	'255 255 50'	--Aftermath Level 3

-------------------------------------------
--               GEAR SETS               --
-------------------------------------------

function get_sets()

	-- Tank (Damage Taken-, Evasion, Magic Evasion, Enmity+, VIT, Defense)
	sets.tank = {
		head="Sakpata's Helm",
		body="Sakpata's Plate", -- 5 Sakpata + Defending ring caps DT, any additional pieces with any form of DT are wasted
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Unmoving Collar +1",
		waist="Flume Belt",
		left_ear="Ethereal Earring",
		right_ear="Genmei Earring",
		left_ring="Petrov Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Mag. Evasion+15',}},
	}

	-- Tank Idle (Movement speed, Damage Taken -, Enmity+, VIT+, Defense)
	-- Combines with Tank set
	sets.tankidle = set_combine(sets.tank, {
		legs="Carmine Cuisses +1",
	})

	-- DPS (Accuracy, Double/Triple Attack, DEX, Store TP, Attack, Refresh, Regain, Regen)
	sets.dps = {
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Defiant Collar",
		waist="Windbuffet Belt +1",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Hetairoi Ring",
		right_ring="Regal Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Mag. Evasion+15',}},
	}

	-- DPS Idle (Refresh, Regain, Regen, Damage Taken-)
	-- Combines with DPS set
	sets.dpsidle = set_combine(sets.dps, {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Carmine Cuisses +1",
		feet="Nyame Sollerets",
		neck="Coatl Gorget +1",
		waist="Flume Belt",
		left_ear="Ethereal Earring",
		right_ear="Cryptic Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Mag. Evasion+15',}},
	})

	-- Enmity (full Enmity+ for spells/abilities)
	sets.enmity = {
		head="Souv. Schaller +1",
		body="Souveran Cuirass",
		hands="Souv. Handschuhs",
		legs="Souveran Diechlings",
		feet="Eschite Greaves",
		neck="Unmoving Collar +1",
		waist="Creed Baudrier",
		left_ear="Cryptic Earring",
		right_ear="Friomisi Earring",
		left_ring="Petrov Ring",
		right_ring="Vengeful Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Mag. Evasion+15',}},
	}

	-- Rest
	sets.rest = {
		waist="Austerity Belt",
	}

	-- Fast Cast (cap is 80%)
	sets.fastcast = {
    head="Sakpata's Helm",
    body="Nyame Mail",
    hands="Leyline Gloves",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Baetyl Pendant",
    waist="Sailfi Belt +1",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Prolix Ring",
    right_ring="Kishar Ring",
	}

	-- Spell Interruption Rate Down (Need 102% for actual 100% caps, don't forget about 10% from merits)
	-- All spells (not abilities) will use this set FIRST, then fill in other unused slots.
	-- Either make sure any slots you set for other spells (healing, cursna, etc) don't use the slots definined here,
	-- or copy and paste these slots into your other sets and build/define slots around it.
	sets.sird = {
		ammo="Staunch Tathlum",		--10 SIRD
		head="Souv. Schaller +1",	--20 SIRD
		legs="Founder's Hose",		--30 SIRD
		feet="Eschite Greaves",		--15 SIRD
		neck="Moonbeam Necklace",	--10 SIRD
		waist="Rumination Sash",	--10 SIRD
	}

	-- Healing (SIRD, Cure Potency, Enmity)
	sets.healing = {
		ammo="Staunch Tathlum",		--10 SIRD
		head="Souv. Schaller +1",	--20 SIRD
		body="Souveran Cuirass",
		hands="Souv. Handschuhs",
		legs="Founder's Hose",		--30 SIRD
		feet="Eschite Greaves",		--15 SIRD
		neck="Moonbeam Necklace",	--10 SIRD
		waist="Rumination Sash",	--10 SIRD
	}

	-- Enmity Spells (SIRD)
	-- Combines with Enmity set
	-- Flash, Holy, Banish, BLU spells use this.
	sets.enmityspells = set_combine(sets.enmity, {
		ammo="Staunch Tathlum",		--10 SIRD
		head="Souv. Schaller +1",	--20 SIRD
		legs="Founder's Hose",		--30 SIRD
		feet="Eschite Greaves",		--15 SIRD
		neck="Moonbeam Necklace",	--10 SIRD
		waist="Rumination Sash",	--10 SIRD
	})


	-- Enlight (SIRD, Divine Magic Skill, Enmity)
	sets.enlight = {
		ammo="Staunch Tathlum",		--10 SIRD
		head="Souv. Schaller +1",	--20 SIRD
		legs="Founder's Hose",		--30 SIRD
		feet="Eschite Greaves",		--15 SIRD
		neck="Moonbeam Necklace",	--10 SIRD
		waist="Rumination Sash",	--10 SIRD
	}

	-- Phalanx (SIRD, Phalanx, Enhancing Magic Duration, Enmity)
	sets.phalanx = {
		ammo="Staunch Tathlum",		--10 SIRD
		head="Souv. Schaller +1",	--20 SIRD
		hands="Souv. Handschuhs",
		legs="Founder's Hose",		--30 SIRD
		feet="Eschite Greaves",		--15 SIRD
		neck="Moonbeam Necklace",	--10 SIRD
		waist="Rumination Sash",	--10 SIRD
	}

	-- Enhancing Magic (SIRD, Enhancing Magic Duration, Enmity)
	-- Crusade and Reprisal use this.
	sets.enhancing = {
		ammo="Staunch Tathlum",		--10 SIRD
		head="Souv. Schaller +1",	--20 SIRD
		legs="Founder's Hose",		--30 SIRD
		feet="Eschite Greaves",		--15 SIRD
		neck="Moonbeam Necklace",	--10 SIRD
		waist="Rumination Sash",	--10 SIRD
	}

	-- Buff (SIRD, Conserve MP, Enmity)
	-- Protect and Shell use this.
	sets.buff = {
		ammo="Staunch Tathlum",		--10 SIRD
		head="Souv. Schaller +1",	--20 SIRD
		legs="Founder's Hose",		--30 SIRD
		feet="Eschite Greaves",		--15 SIRD
		neck="Moonbeam Necklace",	--10 SIRD
		waist="Rumination Sash",	--10 SIRD
	}

	-- Cursna (Cursna+, Healing Magic)
	sets.cursna = {
		ammo="Staunch Tathlum",		--10 SIRD
		head="Souv. Schaller +1",	--20 SIRD
		legs="Founder's Hose",		--30 SIRD
		feet="Eschite Greaves",		--15 SIRD
		neck="Moonbeam Necklace",	--10 SIRD
		waist="Rumination Sash",	--10 SIRD
	}

	-- Weapon Skill (STR, Weapon Skill Damage, Attack, Double/Triple Attack)
	sets.ws = {
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Valorous Mitts",
		legs="Sakpata's Cuisses",
		feet="Valorous Greaves",
		neck="Defiant Collar",
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Karieyh Ring",
		right_ring="Regal Ring",
	}

	-- Savage Blade (50% STR, 50% MND mod)
	-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
	sets.sav = set_combine(sets.ws, {

	})

	-- Requiescat (~80% MND mod)
	-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
	sets.req = set_combine(sets.ws, {
		waist="Fotia Belt",
		left_ring="Stikini Ring +1",
		right_ring="Metamor. Ring +1",
		--right_ring="Rufescent Ring",
	})

	-- Chant du Cygne (80% DEX mod)
	-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
	sets.cdc = set_combine(sets.ws, {
		head="Flam. Zucchetto +2",
		body="Flamma Korazin +2",
		hands="Nyame Gauntlets",
		legs="Flamma Dirs +1",
		feet="Flam. Gambieras +2",
		waist="Fotia Belt",
		right_ear="Mache Earring +1",
		left_ring="Hetairoi Ring",
	})

	-- Atonement (Fotia Neck/Belt)
	-- Combines with Enmity set, only necessary to set the slots with specific desired stats
	sets.ato = set_combine(sets.enmity, {
		waist="Fotia Belt",
	})

	-- Invincible
	sets.invincible = {
		legs="Cab. Breeches",
	}

	-- Holy Circle (Enhances Holy Circle gear)
	sets.holycircle = set_combine(sets.enmity, {

	})

	-- Shield Bash (Enhances Shield Bash gear)
	sets.shieldbash = set_combine(sets.enmity, {
		hands="Cab. Gauntlets +2",
	})

	-- Sentinel (Enhances Sentinel gear)
	sets.sentinel = set_combine(sets.enmity, {
		feet="Cab. Leggings +3",
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
		hands="Cab. Gauntlets +2",
	}

	-- Divine Emblem (Enhances Divine Emblem gear)
	sets.divineemblem = {

	}

	-- Default Town Gear (Put all your fancy-pants gear in here you want to showboat around town. Does not lockstyle this gear, only equips)
	sets.town = {

	}

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
		--body="Yoran Unity Shirt",
	}

end
TopVersion = 'Undead Killer' --Leave this alone, used for debugging purposes



	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX          DO NOT EDIT BELOW THIS LINE          XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--

-------------------------------------------
--              FILE LOAD                --
-------------------------------------------

BottomVersion = 'Undead Killer'
FileVersion = '03.05.22'
NotiLowMPToggle = 'Off' --start with the toggle off for the Low MP Notification so that it can trigger
RRRCountdown = ReraiseReminderTimer
Heartbeat = 0 --set to 0 just to start the Heartbeat running
LoadDelay = 3 --delays loading the HUD, this makes sure all the variables get set correctly before being used, displays file version info, and waits to use lockstyle
LoadHUD = false --starts false then switched to true after the LoadDelay
ShowHUD = true --this changes to false when we zone or are in a cutscene
--set the initial recasts to 0, they will get updated in the Heartbeat function:
DefenderRecast = 0
CocoonRecast = 0
CrusadeRecast = 0
PhalanxRecast = 0
ReprisalRecast = 0
PalisadeRecast = 0
EnlightRecast = 0
AggressorRecast = 0
BerserkRecast = 0
if HUD == 'On' then
	--Space out each line and column properly
	HUDposYLine2 = HUDposYLine1 - LineSpacer --Note that Line 1 is the bottom line, additional line numbers move upward on the screen
	HUDposYLine3 = HUDposYLine2 - LineSpacer
	HUDposXColumn1 = HUDposX
	HUDposXColumn2 = HUDposXColumn1 + ColumnSpacer
	HUDposXColumn3 = HUDposXColumn2 + ColumnSpacer
	HUDposXColumn4 = HUDposXColumn3 + ColumnSpacer
	HUDposXColumn5 = HUDposXColumn4 + ColumnSpacer
	HUDposXColumn6 = HUDposXColumn5 + ColumnSpacer
	if player.equipment.main == 'Excalibur' or player.equipment.main == 'Almace' or player.equipment.main == 'Caladbolg' or player.equipment.main == 'Sequence' or player.equipment.main == 'Burtgang' then
		REMA = true --If we have a REMA equipped we set this toggle to true
	else
		REMA = false --If we do not have a REMA equipped, we set it to false
	end
	--Create all the HUD Background text objects and put them above the screen for now, we'll move them to the correct place next
	send_command('text bg1 create "                                                                                                                          ";text bg1 size '..FontSize..';text bg1 pos '..HUDposXColumn1..' '..HUDposYLine1..';text bg1 bg_transparency '..HUDBGTrans..'')--Background Line 1
	send_command('text bg2 create "                                                                                                                          ";wait .3;text bg2 size '..FontSize..';text bg2 pos '..HUDposXColumn1..' -100;text bg2 bg_transparency '..HUDBGTrans..'')--Background Line 2
	send_command('text bg3 create "                                                                                                                          ";wait .3;text bg3 size '..FontSize..';text bg3 pos '..HUDposXColumn1..' -100;text bg3 bg_transparency '..HUDBGTrans..'')--Background Line 3
	--Create all the HUD Recast text objects and put them above the screen for now, we'll move them to the correct place next
	send_command('text defender create "[ Defender ]";wait .3;text defender size '..FontSize..';text defender pos '..HUDposXColumn1..' -100;text defender bg_transparency 1')
	send_command('text cocoon create "[ Cocoon ]";wait .3;text cocoon size '..FontSize..';text cocoon pos '..HUDposXColumn1..' -100;text cocoon bg_transparency 1')
	send_command('text crusade create "[ Crusade ]";wait .3;text crusade size '..FontSize..';text crusade pos '..HUDposXColumn1..' -100;text crusade bg_transparency 1')
	send_command('text phalanx create "[ Phalanx ]";wait .3;text phalanx size '..FontSize..';text phalanx pos '..HUDposXColumn1..' -100;text phalanx bg_transparency 1')
	send_command('text reprisal create "[ Reprisal ]";wait .3;text reprisal size '..FontSize..';text reprisal pos '..HUDposXColumn1..' -100;text reprisal bg_transparency 1')
	send_command('text palisade create "[ Palisade ]";wait .3;text palisade size '..FontSize..';text palisade pos '..HUDposXColumn1..' -100;text palisade bg_transparency 1')
	send_command('text enlight create "[ Enlight ]";wait .3;text enlight size '..FontSize..';text enlight pos '..HUDposXColumn1..' -100;text enlight bg_transparency 1')
	send_command('text aggressor create "[ Aggres. ]";wait .3;text aggressor size '..FontSize..';text aggressor pos '..HUDposXColumn1..' -100;text aggressor bg_transparency 1')
	send_command('text berserk create "[ Berserk ]";wait .3;text berserk size '..FontSize..';text berserk pos '..HUDposXColumn1..' -100;text berserk bg_transparency 1')
	--Create the Aftermath, Mode, Notifications, and Debuffs text objects and put them above the screen for now, we'll move them to the correct place next
	send_command('text aftermath create "Aftermath: None";wait .3;text aftermath size '..FontSize..';text aftermath pos '..HUDposXColumn4..' -100;text aftermath color 255 50 50;text aftermath bg_transparency 1') --Aftermath
	send_command('text mode create "Mode: '..Mode..'";wait .3;text mode size '..FontSize..';text mode pos '..HUDposXColumn1..' -100;text mode color 255 50 50;text mode bg_transparency 1') --Mode
	send_command('text notifications create "Hello, '..player.name..'! (type //fileinfo for more information)";wait .3;text notifications size '..FontSize..';text notifications pos '..HUDposXColumn1..' -100;text notifications bg_transparency 1') --Notifications
	send_command('text debuffs create "";wait .3;text debuffs size '..FontSize..';text debuffs pos '..HUDposXColumn4..' -100;text debuffs bg_transparency 1') --Debuffs
	send_command('text loading create "Loading Keys PALADIN file ver: '..FileVersion..'...";text loading size '..FontSize..';text loading pos '..HUDposXColumn1..' '..HUDposYLine1..';text loading bg_transparency 1') --Loading
	send_command('wait '..LoadDelay..';gs c LoadHUD')
else
	windower.add_to_chat(8,'Keys PALADIN file ver: '..FileVersion..'')
	windower.add_to_chat(8,'Type //fileinfo for more information')
end
send_command('alias lockstyle gs c Lockstyle') --creates the first lockstyle aliases
send_command('alias lstyle gs c Lockstyle') --creates the second lockstyle aliases
if Chat ~= "Off" then
	send_command('input /cm '..Chat..'')
end
if Book ~= "Off" then
	send_command('input /macro book '..Book..'')
end
if Page ~= "Off" then
	send_command('input /macro set '..Page..'')
end
send_command('alias fileinfo gs c Fileinfo') --creates the fileinfo alias
send_command('alias mode gs c Mode') --creates the Mode aliase
send_command('bind ^'..ModeCtrlPlus..' gs c Mode') --creates the gear mode keyboard shortcut
if Debug == 'On' then
	windower.add_to_chat(8,'[Debug Mode: On]')
	send_command('gs debugmode;gs showswaps')
end
LockstyleDelay = 3
AutoLockstyleRun = true

-------------------------------------------
--            SELF COMMANDS              --
-------------------------------------------

function self_command(command)
	if command == 'Mode' then
		if Mode == 'DPS' then
			Mode = 'Tank'
			if HUD == 'On' then
				send_command('text mode color '..Tankcolor..'')
			end
		elseif Mode == 'Tank' then
			Mode = 'DPS'
			if HUD == 'On' then
				send_command('text mode color '..DPScolor..'')
			end
		end
		if HUD == 'On' then
			send_command('text mode text "Mode: '..Mode..'"')
		else
			windower.add_to_chat(8,'Mode: '..Mode..'')
		end
		choose_set()
	elseif command == 'TPReturn' then
		Notifications = 'TP Return: '..player.tp..''
		if HUD == 'On' then
			send_command('text notifications text "'..Notifications..'";text notifications color 0 255 255')
		else
			windower.add_to_chat(8,''..Notifications..'')
		end
	elseif command == 'ClearNotifications' then --these reset the Notifications display back to a basic state
		if HUD == 'On' then 
			if buffactive['weakness'] then
				send_command('text notifications text "Status: Weak";text notifications color 205 133 63')
			elseif player.mpp <= 20 then
				send_command('text notifications text "«« Low MP »»";text notifications color 205 133 63')
			elseif player.status == "Engaged" then
				send_command('text notifications text "Status: Engaged";text notifications color 255 255 255')
			elseif player.status == "Idle" then
				if Mode == 'Tank' then
					send_command('text notifications text "Status: Kiting";text notifications color 255 255 255')
				else
					send_command('text notifications text "Status: Idle";text notifications color 255 255 255')
				end
			end
		end
	elseif command == 'ClearDebuffs' then --these reset the Debuffs display back to a basic state
		send_command('text debuffs text "";text debuffs color 255 255 255;text debuffs bg_transparency 1')
	elseif command == 'LoadHUD' then
		LoadHUD = true
		send_command('text loading hide')
		if HUDRecast == 'On' then --using the HUDRecast
			if player.equipment.main == 'Excalibur' or player.equipment.main == 'Almace' or player.equipment.main == 'Caladbolg' or player.equipment.main == 'Sequence' or player.equipment.main == 'Burtgang' then
				--if we have any REMAs equipped we place the Aftermath, Mode, Notifications, Debuff, and appropriate BG text objects into view
				send_command('wait .05;text bg2 pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .1;text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')
				send_command('wait .35;text aftermath pos '..HUDposXColumn4..' '..HUDposYLine2..'')
				send_command('wait .4;text mode pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .45;text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')
				send_command('wait .45;text debuffs pos '..HUDposXColumn4..' '..HUDposYLine3..'')
			else
				--if we do not have any REMAs equipped we move the Mode, Notifications, Debuffs, and appropriate BG text objects into view
				send_command('wait .05;text bg2 pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .1;text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')
				send_command('wait .3;text mode pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .35;text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')
				send_command('wait .35;text debuffs pos '..HUDposXColumn4..' '..HUDposYLine3..'')
			end
		else --not using the HUDRecast
			if player.equipment.main == 'Excalibur' or player.equipment.main == 'Almace' or player.equipment.main == 'Caladbolg' or player.equipment.main == 'Sequence' or player.equipment.main == 'Burtgang' then
				--if we have any REMAs equipped we place the Aftermath, Mode, Notifications, Debuff, and appropriate BG text objects into view
				send_command('wait .05;text bg2 pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .15;text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')
				send_command('wait .35;text aftermath pos '..HUDposXColumn4..' '..HUDposYLine1..'')
				send_command('wait .4;text mode pos '..HUDposXColumn1..' '..HUDposYLine1..'')
				send_command('wait .45;text notifications pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .45;text debuffs pos '..HUDposXColumn4..' '..HUDposYLine2..'')
			else
				--if we do not have any REMAs equipped we move the Mode, Notifications, Debuffs, and appropriate BG text objects into view
				send_command('wait .05;text bg2 pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .25;text mode pos '..HUDposXColumn1..' '..HUDposYLine1..'')
				send_command('wait .3;text notifications pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .3;text debuffs pos '..HUDposXColumn4..' '..HUDposYLine2..'')
			end
		end
	elseif command == 'Fileinfo' then
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(3,'--  Keys Gearswap lua file for Paladin  --')
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(200,'File Version Number: '..(''..FileVersion..''):color(8)..'')
		windower.add_to_chat(200,'Top Version: '..(''..TopVersion..''):color(8)..'')
		windower.add_to_chat(200,'Bottom Version: '..(''..BottomVersion..''):color(8)..'')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'If you are having issues with the file, and the Top and Bottom')
		windower.add_to_chat(8,'versions do not match, redownload the latest version of this')
		windower.add_to_chat(8,'file and re-input your gear sets.')
		windower.add_to_chat(8,'(Copy and paste each set from this file to the new one)')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(3,'--                   Notes                   --')
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(8,'Place both this file and the sounds folder')
		windower.add_to_chat(8,'inside the GearSwap data folder')
		windower.add_to_chat(200,'ex:     /addons/GearSwap/data/sounds/')
		windower.add_to_chat(200,'        /addons/GearSwap/data/PLD.lua')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'To switch between gear modes, use any of these three options:')
		windower.add_to_chat(8,'1. A macro with the following in it')
		windower.add_to_chat(200,'        /console mode')
		windower.add_to_chat(8,'2. An alias command')
		windower.add_to_chat(200,'        //mode')
		windower.add_to_chat(8,'3. A keyboard shortcut')
		windower.add_to_chat(200,'        CTRL+G')
		windower.add_to_chat(8,'        (Default is G, can be changed in the settings)')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'Run the Lockstyle function yourself at any time by typing')
		windower.add_to_chat(200,'        //lockstyle or //lstyle')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'For the HUD function, suggested placement')
		windower.add_to_chat(8,'is center screen, just above your chat log.')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'IMPORTANT:')
		windower.add_to_chat(8,'When you load this file for the first time, your HUD')
		windower.add_to_chat(8,'may look all wrong. The defaults preloaded are for a')
		windower.add_to_chat(8,'screen at 3440x1400. Adjust the FontSize, LineSpacer,')
		windower.add_to_chat(8,'and ColumnSpacer options below as needed.')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'Recommended Windower Addons: Text')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(3,'--                  Options                  --')
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(200,'AutoLockstyle: '..(''..AutoLockstyle..''):color(8)..'')
		windower.add_to_chat(200,'LockstyleField: '..(''..LockstyleField..''):color(8)..'')
		windower.add_to_chat(200,'LockstyleTown: '..(''..LockstyleTown..''):color(8)..'')
		windower.add_to_chat(200,'Book: '..(''..Book..''):color(8)..'')
		windower.add_to_chat(200,'Page: '..(''..Page..''):color(8)..'')
		windower.add_to_chat(200,'Chat: '..(''..Chat..''):color(8)..'')
		windower.add_to_chat(200,'InvTimer: '..(''..InvTimer..''):color(8)..'')
		windower.add_to_chat(200,'IntTimer: '..(''..IntTimer..''):color(8)..'')
		windower.add_to_chat(200,'ModeCtrlPlus: '..(''..ModeCtrlPlus..''):color(8)..'')
		windower.add_to_chat(200,'ZoneGear: '..(''..ZoneGear..''):color(8)..'')
		windower.add_to_chat(200,'AlertSounds: '..(''..AlertSounds..''):color(8)..'')
		windower.add_to_chat(200,'UseEcho: '..(''..UseEcho..''):color(8)..'')
		windower.add_to_chat(200,' ')
		windower.add_to_chat(3,'-- Heads Up Display --')
		windower.add_to_chat(200,'HUD: '..(''..HUD..''):color(8)..'')
		windower.add_to_chat(200,'HUDposX: '..(''..HUDposX..''):color(8)..'')
		windower.add_to_chat(200,'HUDposYLine1: '..(''..HUDposYLine1..''):color(8)..'')
		windower.add_to_chat(200,'FontSize: '..(''..FontSize..''):color(8)..'')
		windower.add_to_chat(200,'LineSpacer: '..(''..LineSpacer..''):color(8)..'')
		windower.add_to_chat(200,'ColumnSpacer: '..(''..ColumnSpacer..''):color(8)..'')
		windower.add_to_chat(200,'HUDRecast: '..(''..HUDRecast..''):color(8)..'')
		windower.add_to_chat(200,' ')
		windower.add_to_chat(3,'-- General Notifications --')
		windower.add_to_chat(200,'Noti3000TP: '..(''..Noti3000TP..''):color(8)..'')
		windower.add_to_chat(200,'NotiAftermath: '..(''..NotiAftermath..''):color(8)..'')
		windower.add_to_chat(200,'NotiTrade: '..(''..NotiTrade..''):color(8)..'')
		windower.add_to_chat(200,'NotiInvite: '..(''..NotiInvite..''):color(8)..'')
		windower.add_to_chat(200,'NotiSneak: '..(''..NotiSneak..''):color(8)..'')
		windower.add_to_chat(200,'NotiInvis: '..(''..NotiInvis..''):color(8)..'')
		windower.add_to_chat(200,'NotiReraise: '..(''..NotiReraise..''):color(8)..'')
		windower.add_to_chat(200,'NotiFood: '..(''..NotiFood..''):color(8)..'')
		windower.add_to_chat(200,'NotiLowMP: '..(''..NotiLowMP..''):color(8)..'')
		windower.add_to_chat(200,'NotiTPReturn: '..(''..NotiTPReturn..''):color(8)..'')
		windower.add_to_chat(200,'ReraiseReminder: '..(''..ReraiseReminder..''):color(8)..'')
		windower.add_to_chat(200,'ReraiseReminderTimer: '..(''..ReraiseReminderTimer..''):color(8)..'')
		windower.add_to_chat(3,'-- Debuff Notifications --')
		windower.add_to_chat(200,'NotiSleep: '..(''..NotiSleep..''):color(8)..'')
		windower.add_to_chat(200,'NotiSilence: '..(''..NotiSilence..''):color(8)..'')
		windower.add_to_chat(200,'NotiPetrification: '..(''..NotiPetrification..''):color(8)..'')
		windower.add_to_chat(200,'NotiCurse: '..(''..NotiCurse..''):color(8)..'')
		windower.add_to_chat(200,'NotiStun: '..(''..NotiStun..''):color(8)..'')
		windower.add_to_chat(200,'NotiCharm: '..(''..NotiCharm..''):color(8)..'')
		windower.add_to_chat(200,'NotiDoom: '..(''..NotiDoom..''):color(8)..'')
		windower.add_to_chat(200,'NotiAmnesia: '..(''..NotiAmnesia..''):color(8)..'')
		windower.add_to_chat(200,'NotiTerror: '..(''..NotiTerror..''):color(8)..'')
		windower.add_to_chat(200,'NotiMute: '..(''..NotiMute..''):color(8)..'')
		windower.add_to_chat(200,'NotiPlague: '..(''..NotiPlague..''):color(8)..'')
		windower.add_to_chat(200,'NotiPara: '..(''..NotiPara..''):color(8)..'')
		windower.add_to_chat(200,' ')
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(3,'--           Advanced Options              --')
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(200,'HUDBGTrans: '..(''..HUDBGTrans..''):color(8)..'')
		windower.add_to_chat(200,'TPReturnWait: '..(''..TPReturnWait..''):color(8)..'')
		windower.add_to_chat(200,'Debug: '..(''..Debug..''):color(8)..'')
		windower.add_to_chat(200,'DPScolor: '..(''..DPScolor..''):color(8)..'')
		windower.add_to_chat(200,'Tankcolor: '..(''..Tankcolor..''):color(8)..'')
		windower.add_to_chat(200,'Aftermath1color: '..(''..Aftermath1color..''):color(8)..'')
		windower.add_to_chat(200,'Aftermath2color: '..(''..Aftermath2color..''):color(8)..'')
		windower.add_to_chat(200,'Aftermath3color: '..(''..Aftermath3color..''):color(8)..'')
		windower.add_to_chat(200,' ')
		windower.add_to_chat(3,'Options can be changed in the file itself.')
	elseif command == 'Zone Gear' then
		if ZoneGear == 'Town' then
			if world.area == "Western Adoulin" or world.area == "Eastern Adoulin" or world.area == "Celennia Memorial Library" or world.area == "Bastok Markets" or world.area == "Bastok Mines" or world.area == "Metalworks" or world.area == "Port Bastok" or world.area == "Chateau d'Oraguille" or world.area == "Northern San d'Oria" or world.area == "Port San d'Oria" or world.area == "Southern San d'Oria" or world.area == "Heavens Tower" or world.area == "Port Windurst" or world.area == "Windurst Walls" or world.area == "Windurst Waters" or world.area == "Windurst Woods" or world.area == "Lower Jeuno" or world.area == "Port Jeuno" or world.area == "Ru'Lude Gardens" or world.area == "Upper Jeuno" or world.area == "Aht Urhgan Whitegate" or world.area == "The Colosseum" or world.area == "Tavnazian Safehold" or world.area == "Southern San d'Oria [S]" or world.area == "Bastok Markets [S]" or world.area == "Windurst Waters [S]" or world.area == "Mhaura" or world.area == "Selbina" or world.area == "Rabao" or world.area == "Kazham" or world.area == "Norg" or world.area == "Nashmau" or world.area == "Mog Garden" then
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
		if world.area == "Western Adoulin" or world.area == "Eastern Adoulin" or world.area == "Celennia Memorial Library" or world.area == "Bastok Markets" or world.area == "Bastok Mines" or world.area == "Metalworks" or world.area == "Port Bastok" or world.area == "Chateau d'Oraguille" or world.area == "Northern San d'Oria" or world.area == "Port San d'Oria" or world.area == "Southern San d'Oria" or world.area == "Heavens Tower" or world.area == "Port Windurst" or world.area == "Windurst Walls" or world.area == "Windurst Waters" or world.area == "Windurst Woods" or world.area == "Lower Jeuno" or world.area == "Port Jeuno" or world.area == "Ru'Lude Gardens" or world.area == "Upper Jeuno" or world.area == "Aht Urhgan Whitegate" or world.area == "The Colosseum" or world.area == "Tavnazian Safehold" or world.area == "Southern San d'Oria [S]" or world.area == "Bastok Markets [S]" or world.area == "Windurst Waters [S]" or world.area == "Mhaura" or world.area == "Selbina" or world.area == "Rabao" or world.area == "Kazham" or world.area == "Norg" or world.area == "Nashmau" or world.area == "Mog Garden" then
			send_command('input /lockstyleset '..LockstyleTown..'')
		else
			send_command('input /lockstyleset '..LockstyleField..'')
		end
	elseif command == 'Radialens' then
		--we put this wait in to check what zone we're in when the Radialens wears so that it doesn't trigger when we're simply zoning out of an Escha zone
		send_command('wait 4;gs c RadialensCheck')
	elseif command == 'RadialensCheck' and string.find(world.area,'Escha') then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« Radialens Has Worn Off »»";text notifications color 255 50 50')
		end
	elseif command == 'NotiLowMPToggle' then
		NotiLowMPToggle = 'Off'
	elseif command == 'BLUAOE' then
		if windower.ffxi.get_spell_recasts()[584] == 0 then --Sheep Song
			send_command('input /ma "Sheep Song" <stnpc>')
		elseif windower.ffxi.get_spell_recasts()[598] == 0 then --Soporific
			send_command('input /ma "Soporific" <stnpc>')
		elseif windower.ffxi.get_spell_recasts()[537] == 0 then --Stinking Gas
			send_command('input /ma "Stinking Gas" <stnpc>')
		elseif windower.ffxi.get_spell_recasts()[605] == 0 then --Geist Wall
			send_command('input /ma "Geist Wall" <stnpc>')
		elseif windower.ffxi.get_spell_recasts()[572] == 0 then --Sound Blast
			send_command('input /ma "Sound Blast" <stnpc>')
		elseif windower.ffxi.get_spell_recasts()[575] == 0 then --Jettatura
			send_command('input /ma "Jettatura" <stnpc>')
		end
	end
end

-------------------------------------------
--              CHOOSE SET               --
-------------------------------------------

function choose_set()
	if player.status == "Resting" then
		if HUD == 'On' then
			if buffactive['weakness'] then
				send_command('text notifications text "Status: Weak";text notifications color 205 133 63')
			elseif player.mpp <= 20 then
				send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50')
			else
				send_command('text notifications text "Status: Resting";text notifications color 255 255 255')
			end
		end
		equip(sets.rest)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Rest]')
		end
	elseif player.status == "Engaged" then
		if HUD == 'On' then
			if buffactive['weakness'] then
				send_command('text notifications text "Status: Weak";text notifications color 205 133 63')
			elseif player.mpp <= 20 and HUD == 'On' then
				send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50')
			elseif HUD == 'On' then
				send_command('text notifications text "Status: Engaged";text notifications color 255 255 255')
			end
		end
		if Mode == 'DPS' then
			equip(sets.dps)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: DPS]')
			end
		elseif Mode == 'Tank' then
			equip(sets.tank)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Tank]')
			end
		end
	elseif  player.status == "Idle" then 
		if HUD == 'On' then
			if buffactive['weakness'] then
				send_command('text notifications text "Status: Weak";text notifications color 205 133 63')
			elseif player.mpp <= 20 then
				send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50')
			elseif Mode == 'Tank' then
				send_command('text notifications text "Status: Kiting";text notifications color 255 255 255')
			else
				send_command('text notifications text "Status: Idle";text notifications color 255 255 255')
			end
		end
		if world.area == "Western Adoulin" or world.area == "Eastern Adoulin" or world.area == "Celennia Memorial Library" then
			if Mode == 'Tank' then
				equip(set_combine(sets.tankidle, sets.adoulin))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Tank Idle + Adoulin]')
				end
			else
				equip(set_combine(sets.dpsidle, sets.adoulin))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: DPS Idle + Adoulin]')
				end
			end
		elseif world.area == "Bastok Markets" or world.area == "Bastok Mines" or world.area == "Metalworks" or world.area == "Port Bastok" then
			if Mode == 'Tank' then
				equip(set_combine(sets.tankidle, sets.bastok))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Tank Idle + Bastok]')
				end
			else
				equip(set_combine(sets.dpsidle, sets.bastok))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: DPS Idle + Bastok]')
				end
			end
		elseif world.area == "Chateau d'Oraguille" or world.area == "Northern San d'Oria" or world.area == "Port San d'Oria" or world.area == "Southern San d'Oria" then
			if Mode == 'Tank' then
				equip(set_combine(sets.tankidle, sets.sandoria))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Tank Idle + San d\'Oria]')
				end
			else
				equip(set_combine(sets.dpsidle, sets.sandoria))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: DPS Idle + San d\'Oria]')
				end
			end
		elseif world.area == "Heavens Tower" or world.area == "Port Windurst" or world.area == "Windurst Walls" or world.area == "Windurst Waters" or world.area == "Windurst Woods" then
			if Mode == 'Tank' then
				equip(set_combine(sets.tankidle, sets.windurst))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Tank Idle + Windurst]')
				end
			else
				equip(set_combine(sets.dpsidle, sets.windurst))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: DPS Idle + Windurst]')
				end
			end
		elseif world.area == "Lower Jeuno" or world.area == "Port Jeuno" or world.area == "Ru'Lude Gardens" or world.area == "Upper Jeuno" or world.area == "Aht Urhgan Whitegate" or world.area == "The Colosseum" or world.area == "Tavnazian Safehold" or world.area == "Southern San d'Oria [S]" or world.area == "Bastok Markets [S]" or world.area == "Windurst Waters [S]" or world.area == "Mhaura" or world.area == "Selbina" or world.area == "Rabao" or world.area == "Kazham" or world.area == "Norg" or world.area == "Nashmau" or world.area == "Mog Garden" then
			if Mode == 'Tank' then
				equip(set_combine(sets.tankidle, sets.town))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Tank Idle + Town]')
				end
			else
				equip(set_combine(sets.dpsidle, sets.town))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: DPS Idle + Town]')
				end
			end
		else
			if Mode == 'Tank' then
				equip(sets.tankidle)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Tank Idle]')
				end
			else
				equip(sets.dpsidle)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: DPS Idle]')
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
		if HUD == 'On' then
		send_command('text debuffs text "«« TERROR »»";text debuffs color 255 50 50')
		else
			windower.add_to_chat(8,'<< TERROR >>')
		end
		cancel_spell()
	elseif buffactive['Petrification'] then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		if HUD == 'On' then
		send_command('text debuffs text "«« PETRIFICATION »»";text debuffs color 255 50 50')
		else
			windower.add_to_chat(8,'<< PETRIFICATION >>')
		end
		cancel_spell()
	elseif buffactive['Sleep'] then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		if HUD == 'On' then
		send_command('text debuffs text "«« SLEEP »»";text debuffs color 255 50 50')
		else
			windower.add_to_chat(8,'<< SLEEP >>')
		end
		cancel_spell()
	elseif buffactive['Stun'] then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		if HUD == 'On' then
		send_command('text debuffs text "«« STUN »»";text debuffs color 255 50 50')
		else
			windower.add_to_chat(8,'<< STUN >>')
		end
		cancel_spell()
	elseif buffactive['Amnesia'] and (spell.type == 'WeaponSkill' or spell.type == 'JobAbility') then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		if HUD == 'On' then
		send_command('text debuffs text "«« AMNESIA »»";text debuffs color 255 50 50')
		else
			windower.add_to_chat(8,'<< AMNESIA >>')
		end
		cancel_spell()
	elseif buffactive['Silence'] and (spell.prefix == '/magic' or spell.prefix == '/ninjutsu' or spell.prefix == '/song') then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		if HUD == 'On' then
		send_command('text debuffs text "«« SILENCE »»";text debuffs color 255 50 50')
		else
			windower.add_to_chat(8,'<< SILENCE >>')
		end
		cancel_spell()
		if UseEcho == 'E' then
			send_command('input /item "Echo Drop" <me>')
		elseif UseEcho == 'R' then
			send_command('input /item "Remedy" <me>')
		end
	elseif buffactive['Mute'] and (spell.prefix == '/magic' or spell.prefix == '/ninjutsu' or spell.prefix == '/song') then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		if HUD == 'On' then
		send_command('text debuffs text "«« MUTE »»";text debuffs color 255 50 50')
		else
			windower.add_to_chat(8,'<< MUTE >>')
		end
		cancel_spell()
	elseif spell.type == 'WeaponSkill' then
		if player.tp < 1000 then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
			end
			cancel_spell()
			if HUD == 'On' then
				send_command('text notifications text "«« Not Enough TP »»";text notifications color 255 50 50')
			else
				windower.add_to_chat(8,'<< Not Enough TP >>')
			end
		end
		if (spell.skill == 'Marksmanship' or spell.skill == 'Archery') and spell.target.distance >= (spell.target.model_size + 23) then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
			end
			cancel_spell()
			if HUD == 'On' then
				send_command('text notifications text "«« Too Far »»";text notifications color 255 50 50')
			else
				windower.add_to_chat(8,'<< Too Far >>')
			end
		elseif (spell.target.distance >= (spell.target.model_size + 3)) and not (spell.english == 'Starlight' or spell.english == 'Moonlight') then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
			end
			cancel_spell()
			if HUD == 'On' then
				send_command('text notifications text "«« Too Far »»";text notifications color 255 50 50')
			else
				windower.add_to_chat(8,'<< Too Far >>')
			end
		end
		if spell.english == 'Requiescat' then
			equip(sets.req)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Requiescat + Weapon Skill]')
			end
		elseif spell.english == 'Savage Blade' then
			equip(sets.sav)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Savage Blade + Weapon Skill]')
			end
		elseif spell.english == 'Chant du Cygne' then
			equip(sets.cdc)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Chant du Cygne + Weapon Skill]')
			end
		elseif spell.english == 'Atonement' then
			equip(sets.ato)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Atonement + Weapon Skill]')
			end
		else
			equip(sets.ws)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Weapon Skill]')
			end
		end
	elseif spell.english == 'Invincible' then
		equip(sets.invincible)
		if InvTimer == 'On' then
			if player.equipment.hands == 'Valor Breeches +2' or player.equipment.hands == 'Caballarius Breeches' or player.equipment.hands == 'Caballarius Breeches +1' or player.equipment.hands == 'Caballarius Breeches +2' or player.equipment.hands == 'Caballarius Breeches +3' then --these pieces extend Invincible by 10 seconds so we adjust accordingly
				send_command('input /echo [Invincible] 40 seconds;wait 10;input /echo [Invincible] 30 seconds;wait 10;input /echo [Invincible] 20 seconds;wait 10;input /echo [Invincible] 10 seconds')
			else
				send_command('input /echo [Invincible] 30 seconds;wait 10;input /echo [Invincible] 20 seconds;wait 10;input /echo [Invincible] 10 seconds')
			end
		end
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Invincible]')
		end
	elseif spell.english == 'Intervene' and IntTimer == 'On' then
		send_command('input /echo [Intervene] 30 seconds;wait 10;input /echo [Intervene] 20 seconds;wait 10;input /echo [Intervene] 10 seconds')
	elseif spell.english == 'Holy Circle' then
		equip(sets.holycircle)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Holy Circle + Enmity]')
		end
	elseif spell.english == 'Shield Bash' then
		equip(sets.shieldbash)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Shield Bash + Enmity]')
		end
	elseif spell.english == 'Sentinel' then
		equip(sets.sentinel)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Sentinel + Enmity]')
		end
	elseif spell.english == 'Cover' then
		equip(sets.cover)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Cover]')
		end
	elseif spell.english == 'Rampart' then
		equip(sets.rampart)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Rampart + Enmity]')
		end
	elseif spell.english == 'Fealty' then
		equip(sets.fealty)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Fealty]')
		end
	elseif spell.english == 'Chivalry' then
		equip(sets.chivalry)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Chivalry]')
		end
	elseif spell.english == 'Divine Emblem' then
		equip(sets.divineemblem)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Divine Emblem]')
		end
	elseif spell.english == 'Holy Water' then
		equip(sets.cursna)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Cursna]')
		end
	elseif (spell.english == 'Spectral Jig' or spell.english == 'Sneak' or spell.english == 'Monomi: Ichi' or spell.english == 'Monomi: Ni') and buffactive['Sneak'] and spell.target.type == 'SELF' then
		send_command('cancel 71')
	--if we're casting a cure or protect without Majesty up, we'll put it up before casting:
	elseif AutoMajesty == 'On' and ((string.find(spell.english,'Cur') and spell.type == 'WhiteMagic') or string.find(spell.english,'Protect')) and not buffactive['Majesty'] and not buffactive['Amnesia'] and windower.ffxi.get_ability_recasts()[150] == 0 then
		cancel_spell()
		send_command('input /ja Majesty <me>;wait 1;input /ma '..spell.english..' '..spell.target.raw..'')
	elseif not (spell.english == 'Warp Ring' or spell.english == 'Dim. Ring (Dem)' or spell.english == 'Dim. Ring (Holla)' or spell.english == 'Dim. Ring (Mea)' or spell.english == 'Forbidden Key' or spell.english == 'Pickaxe' or spell.english == 'Sickle' or spell.english == 'Hatchet') then
		equip(sets.fastcast)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Fast Cast]')
		end
	end
end

-------------------------------------------
--               MIDCAST                 --
-------------------------------------------

function midcast(spell)
	if spell.english == 'Cursna' then
		equip(sets.cursna)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Cursna]')
		end
	elseif string.find(spell.english,'Cur') and spell.type == "WhiteMagic" then
		equip(sets.healing)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Healing]')
		end
	elseif spell.english == 'Flash' or string.find(spell.english,'Holy') or string.find(spell.english,'Banish') or spell.type == "BlueMagic" then
		equip(sets.enmityspells)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Enmity Spells]')
		end
	elseif string.find(spell.english,'Enlight') then
		equip(sets.enlight)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Enlight]')
		end
	elseif spell.english == 'Phalanx' then
		equip(sets.phalanx)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Phalanx]')
		end
	elseif spell.english == 'Crusade' or spell.english == 'Reprisal' then
		equip(sets.enhancing)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Enhancing Magic]')
		end
	elseif string.find(spell.english,'Protect') or string.find(spell.english,'Shell') then
		equip(sets.buff)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Buff]')
		end
	elseif spell.type == 'Trust' then
		equip(sets.unity)
	end
end

-------------------------------------------
--              AFTERCAST                --
-------------------------------------------

function aftercast(spell)
	choose_set()
	if spell.type == 'WeaponSkill' and not spell.interrupted and HUD == 'On' and NotiTPReturn == 'On' then
		send_command('wait '..TPReturnWait..';gs c TPReturn')
	--Put Defender up afterwards if we're doing active tank things:
	elseif AutoDefender == 'On' and (spell.english == 'Provoke' or spell.english == 'Holy Circle' or spell.english == 'Shield Bash' or spell.english == 'Sentinel' or spell.english == 'Rampart') and not buffactive['Defender'] and not buffactive['Amnesia'] and Mode == 'Tank' and player.sub_job == 'WAR' and DefenderRecast == 0 then
		send_command('wait .5;input /ja Defender <me>')
	elseif (spell.english == 'Flash' or spell.english == 'Phalanx' or spell.english == 'Reprisal' or spell.english == 'Crusade') and not buffactive['Defender'] and AutoDefender == 'On' and Mode == 'Tank' and player.sub_job == 'WAR' and DefenderRecast == 0 then
		send_command('wait 3;input /ja Defender <me>')
	elseif NotiLowMP =='On' and player.mpp <= 20 and NotiLowMPToggle == 'Off' then
		NotiLowMPToggle = 'On' --turn the toggle on so this can't be triggered again until its toggled off (done below)
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50')
		else
			windower.add_to_chat(8,'<< Low MP >>')
		end		
		send_command('wait 30;gs c NotiLowMPToggle') --wait 30 sec then turns the toggle back off
	end
end

-------------------------------------------
--             STATUS CHANGE             --
-------------------------------------------

function status_change(new,old)
	choose_set() --run this any time your status changes (engage, disengage, rest)
end

-------------------------------------------
--             SHOW/HIDE HUD             --
-------------------------------------------

windower.register_event('status change', function(status)
    if status == 4 and HUD == 'On' and ShowHUD == true then --In a cutscene: Hide the HUD
		ShowHUD = false
		send_command('text bg1 hide;text bg2 hide;text bg3 hide;text phalanx hide;text crusade hide;text palisade hide;text reprisal hide;text defender hide;text cocoon hide;text enlight hide;text aggressor hide;text berserk hide;text mode hide;text notifications hide;text debuffs hide;text aftermath hide')
    elseif status ~= 4  and HUD == 'On' and ShowHUD == false then --Out of cutscene: SHow the HUD
		ShowHUD = true
		send_command('text bg1 show;text bg2 show;text bg3 show;text phalanx show;text crusade show;text palisade show;text reprisal show;text defender show;text cocoon show;text enlight show;text aggressor show;text berserk show;text mode show;text notifications show;text debuffs show;text aftermath show')
    end
end)

-------------------------------------------
--       Buff/Debuff Notifications       --
-------------------------------------------

windower.register_event('gain buff', function(buff)
	if buff == 270 and NotiAftermath =='On' then --Aftermath: Lv. 1
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/AftermathOn.wav')
		end
		if player.equipment.main == 'Excalibur' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 1 (Regen/Refresh)";text aftermath color '..Aftermath1color..'')
			else
				windower.add_to_chat(220,'<< Aftermath: Level 1 (Regen/Refresh) >>')
			end
		elseif player.equipment.main == 'Almace' or player.equipment.main == 'Caladbolg' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 1 (30% Triple Dmg)";text aftermath color '..Aftermath1color..'')
			else
				windower.add_to_chat(220,'<< Aftermath: Level 1 (30% Triple Damage) >>')
			end
		elseif player.equipment.main == 'Sequence' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 1 (4-Step Ultimate)";text aftermath color '..Aftermath1color..'')
			else
				windower.add_to_chat(220,'<< Aftermath: Level 1 (4-Step Ultimate) >>')
			end
		elseif player.equipment.main == 'Burtgang' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 1 (Accuracy)";text aftermath color '..Aftermath1color..'')
			else
				windower.add_to_chat(220,'<< Aftermath: Level 1 (Accuracy) >>')
			end
		end
	elseif buff == 271 and NotiAftermath == 'On' then --Aftermath: Lv. 2
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/AftermathOn.wav')
		end
		if player.equipment.main == 'Excalibur' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 2 (Regen/Refresh)";text aftermath color '..Aftermath2color..'')
			else
				windower.add_to_chat(204,'<< Aftermath: Level 2 (Regen/Refresh) >>')
			end
		elseif player.equipment.main == 'Almace' or player.equipment.main == 'Caladbolg' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 2 (40% Triple Dmg)";text aftermath color '..Aftermath2color..'')
			else
				windower.add_to_chat(204,'<< Aftermath: Level 2 (40% Triple Damage) >>')
			end
		elseif player.equipment.main == 'Sequence' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 2 (3-Step Ultimate)";text aftermath color '..Aftermath2color..'')
			else
				windower.add_to_chat(204,'<< Aftermath: Level 2 (3-Step Ultimate) >>')
			end
		elseif player.equipment.main == 'Burtgang' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 2 (Attack)";text aftermath color '..Aftermath2color..'')
			else
				windower.add_to_chat(204,'<< Aftermath: Level 2 (Attack) >>')
			end
		end
	elseif buff == 272 and NotiAftermath == 'On' then --Aftermath: Lv. 3
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/AftermathOn.wav')
		end
		if player.equipment.main == 'Excalibur' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 3 (Regen/Refresh)";text aftermath color '..Aftermath3color..'')
			else
				windower.add_to_chat(50,'<< Aftermath: Level 3 (Regen/Refresh) >>')
			end
		elseif player.equipment.main == 'Almace' or player.equipment.main == 'Caladbolg' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 3 (50% Triple Dmg)";text aftermath color '..Aftermath3color..'')
			else
				windower.add_to_chat(50,'<< Aftermath: Level 3 (50% Triple Damage) >>')
			end
		elseif player.equipment.main == 'Sequence' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 3 (2-Step Ultimate)";text aftermath color '..Aftermath3color..'')
			else
				windower.add_to_chat(50,'<< Aftermath: Level 3 (2-Step Ultimate) >>')
			end
		elseif player.equipment.main == 'Burtgang' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 3 (Occ. Att. 2-3x)";text aftermath color '..Aftermath3color..'')
			else
				windower.add_to_chat(50,'<< Aftermath: Level 3 (Occ. Att. 2-3x) >>')
			end
		end
	end
	if buff == 15 and NotiDoom == 'On' then
		if HUD == 'On' then
			send_command('text debuffs text "«« DOOM »»";text debuffs color 255 50 50')
		else
			windower.add_to_chat(8,'<< DOOM >>')
		end
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
	elseif (buff == 2 or buff == 19) and NotiSleep == On then
		if HUD == 'On' then
			send_command('text debuffs text "«« SLEEP »»";text debuffs color 255 50 50')
		else
			windower.add_to_chat(8,'<< SLEEP >>')
		end
		send_command('gs c OpoOpo')
	elseif buff == 6 and NotiSilence == 'On' then
		if HUD == 'On' then
			send_command('text debuffs text "«« SILENCE »»";text debuffs color 255 50 50')
		else
			windower.add_to_chat(8,'<< SILENCE >>')
		end
	elseif buff == 7 and NotiPetrification == 'On' then
		if HUD == 'On' then
			send_command('text debuffs text "«« PETRIFICATION »»";text debuffs color 255 50 50')
		else
			windower.add_to_chat(8,'<< PETRIFICATION >>')
		end
	elseif (buff == 9 or buff == 20) and NotiCurse =='On' then
		if HUD == 'On' then
			send_command('text debuffs text "«« CURSE »»";text debuffs color 255 50 50')
		else
			windower.add_to_chat(8,'<< CURSE >>')
		end
	elseif buff == 10 and NotiStun == 'On' then
		if HUD == 'On' then
			send_command('text debuffs text "«« STUN »»";text debuffs color 255 50 50')
		else
			windower.add_to_chat(8,'<< STUN >>')
		end
	elseif (buff == 14 or buff == 17) and NotiCharm == 'On' then
		if HUD == 'On' then
			send_command('text debuffs text "«« CHARM »»";text debuffs color 255 50 50')
		else
			windower.add_to_chat(8,'<< CHARM >>')
		end
	elseif buff == 16 and NotiAmnesia == 'On' then
		if HUD == 'On' then
			send_command('text debuffs text "«« AMNESIA »»";text debuffs color 255 50 50')
		else
			windower.add_to_chat(8,'<< AMNESIA >>')
		end
	elseif buff == 28 and NotiTerror == 'On' then
		if HUD == 'On' then
			send_command('text debuffs text "«« TERROR »»";text debuffs color 255 50 50')
		else
			windower.add_to_chat(8,'<< TERROR >>')
		end
	elseif buff == 29 and NotiMute == 'On' then
		if HUD == 'On' then
			send_command('text debuffs text "«« MUTE »»";text debuffs color 255 50 50')
		else
			windower.add_to_chat(8,'<< MUTE >>')
		end
	elseif buff == 31 and NotiPlague == 'On' then
		if HUD == 'On' then
			send_command('text debuffs text "«« PLAGUE »»";text debuffs color 255 50 50')
		else
			windower.add_to_chat(8,'<< PLAGUE >>')
		end
	elseif (buff == 4 or buff == 566) and NotiPara == 'On' then
		if HUD == 'On' then
			send_command('text debuffs text "«« PARALYSIS »»";text debuffs color 255 50 50')
		else
			windower.add_to_chat(8,'<< PARALYSIS >>')
		end
	end
end)

windower.register_event('lose buff', function(buff)
	if buff == 270 or buff == 271 or buff == 272 or buff == 273 and NotiAftermath =='On' then --lose any aftermath
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/AftermathOff.wav')
		end
		if HUD == 'On' then
			send_command('text aftermath text "Aftermath: None";text aftermath color 255 50 50')
		else
			windower.add_to_chat(39,'<< Aftermath Off >>')
		end
	elseif buff == 251 and player.hp > 0 and NotiFood == 'On' then --food wears off
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« Food Has Worn Off »»";text notifications color 255 50 50')
		else
			windower.add_to_chat(8,'<< Food Has Worn Off >>')
		end
	elseif buff == 113 and NotiReraise == 'On' then --reraise wears off
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« Reraise Has Worn Off »»";text notifications color 255 50 50')
		else
			windower.add_to_chat(8,'<< Reraise Has Worn Off >>')
		end
	elseif buff == 602 and string.find(world.area,'Escha') then --Vorseal
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« Vorseal Has Worn Off »»";text notifications color 255 50 50')
		end
	elseif buff == 253 then --Signet
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« Signet Has Worn Off »»";text notifications color 255 50 50')
		end
	elseif buff == 256 then --Sanction
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« Sanction Has Worn Off »»";text notifications color 255 50 50')
		end
	elseif buff == 268 then --Sigil
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« Sigil Has Worn Off »»";text notifications color 255 50 50')
		end
	elseif buff == 512 then --Ionis
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« Ionis Has Worn Off »»";text notifications color 255 50 50')
		end
	elseif buff == 0 and HUD == 'On' then --No longer dead (Raise/HP)
		send_command('text notifications text "Status: Alive ^_^";text notifications color 75 255 75')
	elseif buff == 1 then --Weakness
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« Weakness Has Worn Off »»";text notifications color 75 255 75')
		end
	elseif buff == 2 or buff == 19 then --lose sleep, we of course clear debuffs but also run choose_set since we had equipped the OpoOpo
		if HUD == 'On' then
			send_command('gs c ClearDebuffs')
		end
		choose_set()
	elseif (buff == 6 or buff == 7 or buff == 9 or buff ==20 or buff == 10 or buff == 14 or buff == 17 or buff == 15 or buff == 16 or buff == 28 or buff == 29 or buff == 31 or buff == 4 or buff == 566) and HUD == 'On' then
		send_command('gs c ClearDebuffs') --clear debuffs if any debuffs wear off
	end
end)

windower.register_event('tp change',function()
	if player.tp == 3000 and Noti3000TP == 'On' then
		Notifications = '«« 3000 TP »»'
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/3000TP.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« 3000 TP »»";text notifications color 75 255 75')
		else
			windower.add_to_chat(8,'<< 3000 TP >>')
		end
	end
end)

-------------------------------------------
--              HEARTBEAT                --
-------------------------------------------

--Miscellaneous things we check for to keep them updated
windower.register_event('prerender', function()
	if os.time() > Heartbeat then
		Heartbeat = os.time() --this gets updated once per second, then we do the things below
		if AutoLockstyle == 'On' and AutoLockstyleRun == true and LockstyleDelay > 0 then
			LockstyleDelay = LockstyleDelay - 1
		elseif AutoLockstyle == 'On' and AutoLockstyleRun == true and LockstyleDelay == 0 then
			send_command('gs c Lockstyle')
			AutoLockstyleRun = false
		end
		if HUD == 'On' and LoadHUD == true then
			if player.hp == 0 then --are we dead?
				send_command('text notifications text "Status: Dead X_x";text notifications color 255 50 50')
			end
			if ReraiseReminder == 'On' then
				if RRRCountdown > 0 then
					RRRCountdown = RRRCountdown - 1
				else
					if not buffactive['Reraise'] and player.hp > 0 then --if we are dead no need to remind us about reraise
						if AlertSounds == 'On' then
							windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
						end
						if HUD == 'On' then
							send_command('text notifications text "«« No Reraise »»";text notifications color 255 50 50')
						else
							windower.add_to_chat(8,'<< No Reraise >>')
						end
					end
					RRRCountdown = ReraiseReminderTimer --start the timer back up
				end
			end
			if NotiDoom == 'On' and buffactive['Doom'] then 
				send_command('text debuffs text "«« DOOM »»";text debuffs bg_transparency 200;text debuffs color 0 0 0;text debuffs bg_color 255 255 255;wait .5;text debuffs bg_color 255 204 51')
			end
			if HUDRecast == 'On' then --using the HUDRecast
				--HUDRecast goes in Line 1:
				if Mode == 'Tank' then --are we in Tank mode?
					if player.sub_job == 'WAR' then
						send_command('text defender pos '..HUDposXColumn1..' '..HUDposYLine1..'')	--Defender goes in Column 1
						send_command('text cocoon pos '..HUDposXColumn1..' -100')					--Cocoon is not visible (-100 puts it above the screen):
						send_command('text crusade pos '..HUDposXColumn2..' '..HUDposYLine1..'')	--Crusade goes in Column 2
						send_command('text phalanx pos '..HUDposXColumn3..' '..HUDposYLine1..'')	--Phalanx goes in Column 3
						send_command('text reprisal pos '..HUDposXColumn4..' '..HUDposYLine1..'')	--Reprisal goes in Column 4
						send_command('text palisade pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Palisade goes in Column 5
					elseif player.sub_job == 'BLU' then
						send_command('text defender pos '..HUDposXColumn1..' -100')					--Defender is not visible
						send_command('text cocoon pos '..HUDposXColumn1..' '..HUDposYLine1..'')		--Cocoon goes in Column 1
						send_command('text crusade pos '..HUDposXColumn2..' '..HUDposYLine1..'')	--Crusade goes in Column 2
						send_command('text phalanx pos '..HUDposXColumn3..' '..HUDposYLine1..'')	--Phalanx goes in Column 3
						send_command('text reprisal pos '..HUDposXColumn4..' '..HUDposYLine1..'')	--Reprisal goes in Column 4
						send_command('text palisade pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Palisade goes in Column 5
					else
						send_command('text defender pos '..HUDposXColumn1..' -100')					--Defender is not visible
						send_command('text cocoon pos '..HUDposXColumn1..' -100')					--Cocoon is not visible
						send_command('text crusade pos '..HUDposXColumn1..' '..HUDposYLine1..'')	--Crusade goes in Column 1
						send_command('text phalanx pos '..HUDposXColumn2..' '..HUDposYLine1..'')	--Phalanx goes in Column 2
						send_command('text reprisal pos '..HUDposXColumn3..' '..HUDposYLine1..'')	--Reprisal goes in Column 3
						send_command('text palisade pos '..HUDposXColumn4..' '..HUDposYLine1..'')	--Palisade goes in Column 4
					end
					send_command('text enlight pos '..HUDposXColumn1..' -100')						--None of these are visible
					send_command('text aggressor pos '..HUDposXColumn2..' -100')
					send_command('text berserk pos '..HUDposXColumn3..' -100')
				else --if not tank mode, assumes DPS mode
					send_command('text enlight pos '..HUDposXColumn1..' '..HUDposYLine1..'')		--Enlight goes in Column 1
					if player.sub_job == 'WAR' then
						send_command('text aggressor pos '..HUDposXColumn2..' '..HUDposYLine1..'')	--Aggressor goes in Column 2
						send_command('text berserk pos '..HUDposXColumn3..' '..HUDposYLine1..'')	--Berserk goes in Column 3
					else
						send_command('text aggressor pos '..HUDposXColumn2..' -100')				--Aggressor is not visible
						send_command('text berserk pos '..HUDposXColumn3..' -100')					--Berserk is not visible
					end
					send_command('text defender pos '..HUDposXColumn1..' -100')						--None of these are visible
					send_command('text cocoon pos '..HUDposXColumn1..' -100')
					send_command('text crusade pos '..HUDposXColumn1..' -100')
					send_command('text phalanx pos '..HUDposXColumn2..' -100')
					send_command('text reprisal pos '..HUDposXColumn3..' -100')
					send_command('text palisade pos '..HUDposXColumn4..' -100')
				end
				--REMAs equipped:
				if (player.equipment.main == 'Excalibur' or player.equipment.main == 'Almace' or player.equipment.main == 'Caladbolg' or player.equipment.main == 'Sequence' or player.equipment.main == 'Burtgang') and REMA == false then
					--if we have any REMAs equipped we place the Aftermath text object inline with the others
					send_command('text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')			--Background Line 3
					send_command('text mode pos '..HUDposXColumn1..' '..HUDposYLine2..'')			--Mode goes in Line 2, Column 1
					send_command('text aftermath pos '..HUDposXColumn4..' '..HUDposYLine2..'')		--Aftermath goes in Line 2, Column 4
					send_command('text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')	--Notifications goes in Line 3, Column 1
					send_command('text debuffs pos '..HUDposXColumn4..' '..HUDposYLine3..'')		--Debuffs goes in Line 3, Column 4
					REMA = true --This toggle then gets set to true since now we have a REMA equipped
				elseif not (player.equipment.main == 'Excalibur' or player.equipment.main == 'Almace' or player.equipment.main == 'Caladbolg' or player.equipment.main == 'Sequence' or player.equipment.main == 'Burtgang') and REMA == true then 
					--if we do not have any REMAs equipped we move the Aftermath text object out of view and adjust the others
					send_command('text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')			--Background Line 3
					send_command('text mode pos '..HUDposXColumn1..' '..HUDposYLine2..'')			--Mode goes in Line 2, Column 1
					send_command('text aftermath pos '..HUDposXColumn4..' -100')					--Aftermath is not visible
					send_command('text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')	--Notifications goes in Line 3, Column 1
					send_command('text debuffs pos '..HUDposXColumn4..' '..HUDposYLine3..'')		--Debuffs goes in Line 3, Column 4
					REMA = false --This toggle gets set to false since we no longer have a REMA equipped
				end
			else --not using the HUDRecast
				--REMAs equipped:
				if (player.equipment.main == 'Excalibur' or player.equipment.main == 'Almace' or player.equipment.main == 'Caladbolg' or player.equipment.main == 'Sequence' or player.equipment.main == 'Burtgang') and REMA == false then
					--if we have any REMAs equipped we place the Aftermath text object inline with the others
					send_command('text bg3 pos '..HUDposXColumn1..' -100')							--Background Line 3 is not visible
					send_command('text mode pos '..HUDposXColumn1..' '..HUDposYLine1..'')			--Mode goes in Line 1, Column 1
					send_command('text aftermath pos '..HUDposXColumn4..' '..HUDposYLine1..'')		--Aftermath goes in Line 1, Column 4
					send_command('text notifications pos '..HUDposXColumn1..' '..HUDposYLine2..'')	--Notifications goes in Line 2, Column 1
					send_command('text debuffs pos '..HUDposXColumn4..' '..HUDposYLine2..'')		--Debuffs goes in Line 2, Column 4
					REMA = true
				elseif not (player.equipment.main == 'Excalibur' or player.equipment.main == 'Almace' or player.equipment.main == 'Caladbolg' or player.equipment.main == 'Sequence' or player.equipment.main == 'Burtgang') and REMA == true then
					--if we do not have any REMAs equipped we move the Aftermath text object out of view and adjust the others
					send_command('text bg3 pos '..HUDposXColumn1..' -100')							--Background Line 3 is not visible
					send_command('text mode pos '..HUDposXColumn1..' '..HUDposYLine1..'')			--Mode goes in Line 1, Column 1
					send_command('text aftermath pos '..HUDposXColumn4..' -100')					--Aftermath is not visible
					send_command('text notifications pos '..HUDposXColumn1..' '..HUDposYLine2..'')	--Notifications goes in Line 2, Column 1
					send_command('text debuffs pos '..HUDposXColumn4..' '..HUDposYLine2..'')		--Debuffs goes in Line 2, Column 4
					REMA = false
				end
			end
			--Recast updates:
			if player.sub_job == 'WAR' then
				AggressorRecast = windower.ffxi.get_ability_recasts()[4]
				BerserkRecast = windower.ffxi.get_ability_recasts()[1]
				DefenderRecast = windower.ffxi.get_ability_recasts()[3]
			elseif player.sub_job == 'BLU' then
				CocoonRecast = windower.ffxi.get_spell_recasts()[547]
			end
			CrusadeRecast = windower.ffxi.get_spell_recasts()[476]
			PhalanxRecast = windower.ffxi.get_spell_recasts()[106]
			ReprisalRecast = windower.ffxi.get_spell_recasts()[97]
			PalisadeRecast = windower.ffxi.get_ability_recasts()[42]
			EnlightRecast = windower.ffxi.get_spell_recasts()[855]
			--Recast color updates - decide the colors:
			if buffactive['Enmity Boost'] then CrusadeColor = '75 255 75'
			elseif CrusadeRecast > 0 then CrusadeColor = '255 165 0'
			else CrusadeColor = '255 50 50'
			end
			if buffactive['Phalanx'] then PhalanxColor = '75 255 75'
			elseif PhalanxRecast > 0 then PhalanxColor = '255 165 0'
			else PhalanxColor = '255 50 50'
			end
			if buffactive['Reprisal'] then ReprisalColor = '75 255 75'
			elseif ReprisalRecast > 0 then ReprisalColor = '255 165 0'
			else ReprisalColor = '255 50 50'
			end
			if buffactive['Palisade'] then PalisadeColor = '75 255 75'
			elseif PalisadeRecast > 0 then PalisadeColor = '255 165 0'
			else PalisadeColor = '255 50 50'
			end
			if buffactive['Enlight'] then EnlightColor = '75 255 75'
			elseif EnlightRecast > 0 then EnlightColor = '255 165 0'
			else EnlightColor = '255 50 50'
			end
			if player.sub_job == 'BLU' then
				if buffactive['Defense Boost'] then CocoonColor = '75 255 75'
				elseif CocoonRecast > 0 then CocoonColor = '255 165 0'
				else CocoonColor = '255 50 50'
				end
			elseif player.sub_job == 'WAR' then
				if buffactive['Aggressor'] then AggressorColor = '75 255 75'
				elseif AggressorRecast > 0 then AggressorColor = '255 165 0'
				else AggressorColor = '255 50 50'
				end
				if buffactive['Berserk'] then BerserkColor = '75 255 75'
				elseif BerserkRecast > 0 then BerserkColor = '255 165 0'
				else BerserkColor = '255 50 50'
				end
				if buffactive['Defender'] then DefenderColor = '75 255 75'
				elseif DefenderRecast > 0 then DefenderColor = '255 165 0'
				else DefenderColor = '255 50 50'
				end
			end
			--Recast color updates - print the colors:
			send_command('text crusade color '..CrusadeColor..'')
			send_command('text phalanx color '..PhalanxColor..'')
			send_command('text reprisal color '..ReprisalColor..'')
			send_command('text palisade color '..PalisadeColor..'')
			send_command('text enlight color '..EnlightColor..'')
			if player.sub_job == 'BLU' then
				send_command('text cocoon color '..CocoonColor..'')
			elseif player.sub_job == 'WAR' then
				send_command('text defender color '..DefenderColor..'')
				send_command('text aggressor color '..AggressorColor..'')
				send_command('text berserk color '..BerserkColor..'')
			end
		end
		--Majesty recast update is done outside of the HUD check because we use it for AutoMajesty option instead
		MajestyRecast = windower.ffxi.get_ability_recasts()[150]
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
	if HUD =='On' then
		send_command('gs c ClearNotifications') --clear any notifications on zone
		send_command('gs c ClearDebuffs') --clear any debuffs on zone
	end
end)

-------------------------------------------
--           SUB JOB CHANGE              --
-------------------------------------------

function sub_job_change(newSubjob, oldSubjob)
LockstyleDelay = 3
	if AutoLockstyle == 'On' then
		AutoLockstyleRun = true
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
		if NotiTrade == 'On' and HUD == 'On' then
			send_command('text notifications text "«« Trade Request »»";text notifications color 255 255 50')
		end
	elseif org:find('The effect of') and org:find('is about to wear off.')then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if NotiSneak == 'On' and HUD == 'On' and org:find('Sneak') then
			send_command('text notifications text "«« Sneak Wearing »»";text notifications color 255 100 100')
		elseif NotiInvis == 'On' and HUD == 'On' and org:find('Invisible') then
			send_command('text notifications text "«« Invisible Wearing »»";text notifications color 255 100 100')
		end
	elseif org:find('Lost key item') and org:find('Radialens') then
		send_command('gs c Radialens')
	elseif org:find('invites you to') then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav')
		end
		if NotiInvite == 'On' and HUD == 'On' and org:find('party') and not org:find('alliance') then
			send_command('text notifications text "«« Party Invite »»";text notifications color 255 255 50')
		elseif NotiInvite == 'On' and HUD == 'On' and org:find('alliance') then
			send_command('text notifications text "«« Alliance Invite »»";text notifications color 255 255 50')
		end
	elseif org:find('Your visitant status will wear off in') then
		if org:find(' 15 ') then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
			end
			if HUD == 'On' then
				send_command('text notifications text "«« 15 Minutes Remaining »»";text notifications color 255 255 50')
			end
		elseif org:find(' 10 ') then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
			end
			if HUD == 'On' then
				send_command('text notifications text "«« 10 Minutes Remaining »»";text notifications color 255 255 50')
			end
		elseif org:find(' 5 ') then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
			end
			if HUD == 'On' then
				send_command('text notifications text "«« 5 Minutes Remaining »»";text notifications color 255 255 50')
			end
		end
	elseif org:find('Style lock mode enabled.') then
		StyleLockModeEnabledDelay = 5
	elseif org:find('You find a') then
		if org:find('Fu\'s scale') then
			send_command('wait 2 5;input /p Fu\'s Scale: BST, DRG, SMN, PUP <call14>')
		elseif org:find('Gin\'s scale') then
			send_command('wait 2 5;input /p Gin\'s Scale: THF, NIN, DNC, RUN <call14>')
		elseif org:find('Kei\'s scale') then
			send_command('wait 2 5;input /p Kei\'s Scale: WHM, BLM, RDM, BLU, SCH <call14>')
		elseif org:find('Kin\'s scale') then
			send_command('wait 2 5;input /p Kin\'s Scale: WAR, MNK, PLD, DRK, SAM <call14>')
		elseif org:find('Kyou\'s scale') then
			send_command('wait 2 5;input /p Kyou\'s Scale: BRD, RNG, COR, GEO <call14>')
		end
	elseif org:find('You pitiful lot will never learn') then
		send_command('input /p Perfidien pop! <call14>')
	elseif org:find('the void calls') then
		send_command('input /p Plouton pop! <call14>')
	elseif org:find('Hoho! Poked at a sore spot, didn\'t you?') or org:find('Switching things up, hmm?') then
		if org:find('Lightning') then
			send_command('input /p Lightning <call14>')
		elseif org:find('Fire') then
			send_command('input /p Fire <call14>')
		elseif org:find('Wind') then
			send_command('input /p Wind <call14>')
		elseif org:find('Earth') then
			send_command('input /p Earth <call14>')
		elseif org:find('Ice') then
			send_command('input /p Ice <call14>')
		elseif org:find('Water') then
			send_command('input /p Water <call14>')
		end
	end
end)

-------------------------------------------
--             FILE UNLOAD               --
-------------------------------------------

function file_unload()
	if Debug == 'On' then
		send_command('gs debugmode;gs showswaps') --turn off the built-in gearswap debug mode and turn off showswaps
	end
	if HUD == 'On' then
		send_command('text bg1 delete;text bg2 delete;text bg3 delete;text phalanx delete;text crusade delete;text palisade delete;text reprisal delete;text defender delete;text cocoon delete;text enlight delete;text aggressor delete;text berserk delete;text loading delete;text mode delete;text notifications delete;text debuffs delete;text aftermath delete') --delete the different text objects
	end
end

--[[

-------------------------------------------
--               UPDATES                 --
-------------------------------------------
If the new updates Version Compatibility Codename matches your current files TopVersion,
simply replace everything under the "Do Not Edit Below This Line".
Only when the Version Compatibility Codename changes will you need to update the entire file.

03.05.22 (Version Compatibility Codename: Undead Killer)
-Fixed Alliance invite incorrectly triggering Party invite notification.
-Fixed some subjob conditions throwing errors when you have no subjob (ie Odyssey NMs)
-Fixed AutoMajesty and AutoDefender to not attempt to activate when you have Amnesia.

02.02.22 (Version Compatibility Codename: Undead Killer)
-Added Weak status notification.
-Updated "Codename" to "Version Compatibility Codename" to be more clear in its purpose. Whenever changes are made to the top portion of the file, the Version Compatibility Codename is changed and the TopVersion and BottomVersion updated to reflect the new codename. This is done so that when a new update is posted and you 
-Updated how the HUD loading is handled. The loading is now smoother and objects don't overlap eachother while loading.
-Fixed gear not fully equipping in towns.
-Fixed Abyssea Visitant status triggering on incorrect time remaining (ie 110 minutes would trigger the 10 minute)
-Fixed Fast Cast gear to not equip when using a Forbidden Key, Pickaxe, Sickle, or Hatchet.

02.01.22 (Version Compatibility Codename: Undead Killer)
-First version
-Started from Blue Mage file version 02.01.22 (Version Compatibility Codename: Pollen)

-------------------------------------------
--            KEYS NOTEPAD               --
-------------------------------------------


Default text size is 12
Large 15 (+24)
Medium 12 (+20)
Small 9 (+15)

 --]]