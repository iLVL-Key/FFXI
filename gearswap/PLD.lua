-------------------------------------------
--  Keys Gearswap lua file for Paladin   --
-------------------------------------------
--[[

Updates to this file and other GearSwap files and addons can be found at
https://github.com/iLVL-Key/FFXI

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

To use /BLU AOE spells, use a macro for Sheep Song and it will cycle through Sheep Song, Geist Wall,
Stinking Gas, and Soporific, in that order, as recast timers allow. Additionally, using this on a target
outside of these spells aoe range will change the spell to instead use Banishga.

To use /BLU Single target spells, use a macro for Flash and it will cycle through Flash, Jettatura,
and Blank Gaze, in that order, as recast timers and distance allow (or if you are /WAR it will also Provoke).

Run the Lockstyle function yourself at any time by typing
	//lockstyle or //lstyle

Hide or show the HUD at any time by typing
	//hidehud or //showhud

For the HUD function (see options below), suggested placement is center screen, just above your chat log.

IMPORTANT:
When you load this file for the first time, your HUD may look all wrong.
The defaults preloaded are for a screen at 3440x1400. I have not tested at any other resolution.
Adjust the FontSize, LineSpacer, and ColumnSpacer options as needed.

Required Windower Addons: Text

-------------------------------------------
--               PRO TIPS                --
-------------------------------------------

There are 4 Modes available in this file:
Auto-		Will decide gear based on whether or not the game thinks you are in combat. Spells will
			use their specific gear sets by themselves when you are not in combat (so you can get full
			gear bonuses), and will override them with the SIRD set if you are in combat. Will use
			idle/tank set if disengaged but in combat (ie kiting), or idle/refresh set if disengaged
			and not in combat.
Combat-		Gear set choices will always behave as if you are in combat.
Neutral-	Gear set choices will always behave as if you are not in combat.
DPS-		Uses the DPS gear set when in combat.

NOTE: Auto should work fine in most cases, but be aware that the game isn't always correct about when you
are in combat. For example, if you run by a mob and aggro it, you'll notice the battle music does not start.
If you are kiting a mob, and it goes yellow, the game will think you are out of combat. You can either keep
up actions on the mob to keep it claimed (voke, flash, etc) or switch into Combat mode manually.

--]]

-------------------------------------------
--                OPTIONS                --
-------------------------------------------

AutoLockstyle	=	'On'	--[On/Off]		Automatically sets your lockstyle. Uses the Field and Town sets below.
LockstyleCombat	=	'5'		--[1-200]		Your Lockstyle set when in a field zone.
LockstyleTown	=	'1'		--[1-200]		Your Lockstyle set when in a town zone.
							--				If you do not want a separate town lockstyle, set this to the same as LockstyleCombat.
Book			=	'3'		--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
Page			=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
InvTimer		=	'On'	--[On/Off]		Displays a timer for Invincible in echo.
IntTimer		=	'On'	--[On/Off]		Displays a timer for Intervene in echo.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions
							--				(Town limits this to town gear only)
AlertSounds		=	'On'	--[On/Off]		Plays a sound on alerts.
UseEcho			=	'R'		--[E/R/Off]		Automatically uses an (E)cho Drop or (R)emedy instead of spell when you are silenced.
AutoHWater		=	'On'	--[On/Off]		Automatically attempts to use Holy Waters when you get Doomed until it wears off.
AutoMajesty		=	'On'	--[On/Off]		Automatically activates and keeps Majesty active.
AutoDefender	=	'On'	--[On/Off]		Automatically activates and keeps Defender active.
AutoDEmblem		=	'On'	--[On/Off]		Automatically activates Divine Emblem before a Flash when Divine Emblem is up.
UseMaxHP		=	'On'	--[On/Off]		Equips your Max HP gear set when you cure yourself at or near full HP%.
AutoSentinel	=	'On'	--[On/Off]		Attempts to activate Sentinel when your HP gets critically low.
DoomAlert		=	'On'	--[On/Off]		Alerts your party when you are doomed.
DoomOnText		=	'doom'			--		Text that displays in party chat when you are doomed. 
DoomOffText		=	'doom off'		--		That that displays in party chat when you are no longer doomed.

-- Heads Up Display --
HUDposX			=	965		--				X position for the HUD. 0 is left of the window, increasing this number will move it to the right.
HUDposYLine1	=	794		--				Y position for the HUD. 0 is top of the window, increasing this number will move it downward.
							--				Note that this is for the first line of the HUD, the other lines will self-adjust. If you cannot
							--				see the HUD, set the x and y both to 100 to make sure it is showing up, then adjust from there.
FontSize		=	12		--				Font size. Changing this will require you to adjust the Spacers below as well.
LineSpacer		=	20		--				Space in pixels between each Line of the HUD
ColumnSpacer	=	93		--				Space in pixels between each Column of the HUD

--  General Notifications  --
Noti3000TP			=	'On'	--[On/Off]	Displays a notification when you have 3000 TP.
NotiWeapons			=	'On'	--[On/Off]	Displays weapon information.
NotiTrade			=	'On'	--[On/Off]	Displays a notification when someone trades you.
NotiInvite			=	'On'	--[On/Off]	Displays a notification when someone invites to a party/alliance.
NotiSneak			=	'On'	--[On/Off]	Displays a notification when Sneak is about to wear off.
NotiInvis			=	'On'	--[On/Off]	Displays a notification when Invisible is about to wear off.
NotiReraise			=	'On'	--[On/Off]	Displays a notification when reraise wears off.
NotiFood			=	'On'	--[On/Off]	Displays a notification when food wears off.
NotiLowMP			=	'On'	--[On/Off]	Displays a notification when MP is under 20%.
NotiLowHP			=	'On'	--[On/Off]	Displays a notification when HP is low.
NotiDamage			=	'On'	--[On/Off]	Displays your Weapon Skill, Skillchain, Magic Burst, and Blood Pact damage.
ReraiseReminder		=	'On'	--[On/Off]	Displays an occasional reminder if Reraise is not up.
NotiTime			=	'On'	--[On/Off]	Displays a notification for time remaining notices.

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

StartMode		=	'Auto'	--[Auto/Combat/Neutral/DPS]
							--	Determines the Mode you will start in. Current Mode can be changed at any time by using any
							--	of the three options listed above in the Notes section (a macro, alias, or keyboard shortcut).
ModeCtrlPlus	=	'g'		--Sets the keyboard shortcut you would like to cycle between Modes. CTRL+G is default.
AutoMajWindow	=	60		--Time in seconds left before Majesty wears off that AutoMajesty will activate after a cure/protect.
MaxHPThreshold	=	75		--If your HP% is above this number when you cure yourself, your Max HP gear set will activate.
							--Once it is activated, going below this will deactivate it.
LowHPThreshold	=	1000	--Below this number is considered Low HP.
DangerRepeat	=	10		--Maximum number of times the Danger Sound will repeat, once per second.
AutSntThreshold	=	500		--If your HP goes below this number, Sentinel will activate.
RRReminderTimer	=	1800	--Delay in seconds between checks to see if Reraise is up (300 is 5 minutes)
NotiDelay		=	6		--Delay in seconds before certain notifications will automatically clear.
HUDBGTrans		=	'175'	--Background transparency for the HUD. (0 = fully clear, 255 = fully opaque)
AddCommas		=	'On'	--[On/Off]  Adds commas to damage numbers.
Debug			=	'Off'	--[On/Off]

--Color Values
Autocolor		=	'125 200 255'	--Auto Mode
Combatcolor		=	'255 125 125'	--Combat Mode
Neutralcolor	=	'150 255 150'	--Neutral Mode
DPScolor		=	'255 255 125'	--DPS Mode
Aftermath1color =	'0 127 255'		--Aftermath Level 1
Aftermath2color =	'75 255 75'		--Aftermath Level 2
Aftermath3color =	'255 255 50'	--Aftermath Level 3

-------------------------------------------
--               GEAR SETS               --
-------------------------------------------

function get_sets()

	-- Tank (Damage Taken-, Evasion, Magic Evasion, Enmity+, VIT, Defense)
	sets.tank = {
		ammo="Staunch Tathlum",			--2 DT
		head="Chev. Armet +3",			--11 DT
		body="Sakpata's Plate",			--10 DT
		hands="Sakpata's Gauntlets",	--8 DT
		legs="Chev. Cuisses +3",		--13 DT
		feet="Rev. Leggings +3",
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",		--3 DT
		left_ear="Tuisto Earring",
		right_ear="Chev. Earring +1",	--5 DT
		left_ring="Moonlight Ring",		--5 DT
		right_ring="Gelatinous Ring +1",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Mag. Evasion+15',}},
	}

	-- MAX HP (HP-focused tank gear, inherits any leftover slots from the Tank set above)
	-- NOTE: This set is only used when the "UseMaxHP" option is set to 'On'.
	sets.maxhp = set_combine(sets.tank, {
		ammo="Egoist's Tathlum",
		head="Souv. Schaller +1",
		body="Rev. Surcoat +3",
		hands="Souv. Handsch. +1",
		legs="Souv. Diechlings +1",
		feet="Souveran Schuhs +1",
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",
		left_ear="Tuisto Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Gelatinous Ring +1",
		back="Moonlight Cape",
	})

	-- MAX HP with SIRD (102%+ SIRD, HP-focused tank gear, inherits any leftover slots from the Tank set above)
	-- NOTE: This set is only used when the "UseMaxHP" option is set to 'On'.
	sets.maxhpsird = set_combine(sets.tank, {
		ammo="Staunch Tathlum",			--10 SIRD
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
	})

	-- DPS (DPS-focused gear, inherits any leftover slots from the Tank set above)
	sets.dps = set_combine(sets.tank, {
		ammo="Coiste Bodhar",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Ziel Charm",
		waist="Sailfi Belt +1",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Hetairoi Ring",
		right_ring="Petrov Ring",
		back="Moonlight Cape",
	})

	-- Oh Shit
	-- Full DT- and everything you've got with Absorbs or Annuls Damage
	sets.ohshit = {
		head="Chev. Armet +3",
		body="Chev. Cuirass +3",
		hands="Chev. Gauntlets +3",
		legs="Chev. Cuisses +3",
		feet="Chev. Sabatons +3",
		neck="Warder's Charm +1",
		left_ring="Shadow Ring",
		back="Shadow Mantle"
	}

	-- Refresh (only need Refresh gear in here, will inherit the rest from the Tank set above)
	sets.refresh = set_combine(sets.tank, {
		ammo="Homiliary",
		body="Crepuscular Mail",
		hands="Regal Gauntlets",
		neck="Coatl Gorget +1",
		waist="Flume Belt",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
	})

	-- Movement Speed
	-- Combines with Tank/Max HP/Refresh set based on current mode
	sets.movementspeed = {
		legs="Carmine Cuisses +1",
	}

	-- Rest
	sets.rest = {
		waist="Austerity Belt",
	}

	-- Fast Cast (cap is 80%)
	sets.fastcast = {
		ammo="Sapience Orb", --2
		head="Carmine Mask +1", --14
		body="Rev. Surcoat +3", --10
		hands="Leyline Gloves", --5+1
		legs="Souv. Diechlings +1",
		feet="Carmine Greaves +1", --8
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",
		left_ear="Tuisto Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back="Moonlight Cape",
	}

	-- Enmity (full Enmity+ for spells/abilities)
	sets.enmity = {
		ammo="Sapience Orb",
		head="Loess Barbuta +1",
		body="Souv. Cuirass +1",
		hands="Souv. Handsch. +1",
		legs="Souv. Diechlings +1",
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
	sets.enmityspells = set_combine(sets.enmity, {
		head="Carmine Mask +1",
		feet="Carmine Greaves +1",
	})

	-- Enmity Spells with SIRD (102%+ SIRD, Fast Cast, will not be used to cast faster but instead to help reduce recast)
	-- Combines with Enmity set
	-- Flash, Holy, Banish, BLU spells use this.
	sets.enmityspellssird = set_combine(sets.enmity, {
		ammo="Staunch Tathlum",			--10 SIRD
		head="Souv. Schaller +1",		--20 SIRD
		body="Chev. Cuirass +3",		--20 SIRD
		legs="Founder's Hose",			--30 SIRD
		neck="Moonlight Necklace",		--15 SIRD
		waist="Creed Baudrier",
		back="Moonlight Cape",
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
		right_ear="Chev. Earring +1",	--10 CP
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Cure" potency +10%','Spell interruption rate down-10%',}},	--10 CP
	}

	-- Healing with SIRD (102%+ SIRD, Cure Potency, HP+, Enmity)
	-- NOTE: Cure Potency cap is 50%, Cure Potency Received cap is 30%
	sets.healingsird = {
		ammo="Staunch Tathlum",
		head="Souv. Schaller +1",	--20 SIRD				15 CPR
		body="Souv. Cuirass +1",	--			11 CP		15 CPR
		hands="Regal Gauntlets",	--10 SIRD
		legs="Founder's Hose",		--30 SIRD
		feet="Odyssean Greaves",	--20 SIRD
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",
		left_ear="Mendi. Earring",	--			5 CP
		right_ear="Chev. Earring +1",	--			10 CP
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Cure" potency +10%','Spell interruption rate down-10%',}},	--10 SIRD, 10 CP
	}

	-- Enlight (Divine Magic Skill)
	sets.enlight = {
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
	}

	-- Enlight with SIRD (102%+ SIRD, Divine Magic Skill)
	sets.enlightsird = {
		ammo="Staunch Tathlum",		--10 SIRD
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
		head="Odyssean Helm",
		body="Odyssean Chestplate",
		hands="Souv. Handsch. +1",
		legs="Sakpata's Cuisses",
		feet="Souveran Schuhs +1",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Weard Mantle",
	}

	-- Phalanx with SIRD (102%+ SIRD, Phalanx+, Enhancing Magic+, Enhancing Magic Duration)
	sets.phalanxsird = {
		ammo="Staunch Tathlum",			--10 SIRD
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
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Cure" potency +10%','Spell interruption rate down-10%',}},	--10 SIRD
	}

	-- Enhancing Magic (Enhancing Magic Duration, Enhancing Magic Skill)
	-- Crusade, Reprisal, Protect, and Shell use this.
	sets.enhancing = {
		body="Shab. Cuirass +1",
		hands="Regal Gauntlets",
		legs="Carmine Cuisses +1",
		neck="Melic Torque",
		left_ear="Mimir Earring",
		right_ear="Andoaa Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
	}

	-- Enhancing Magic with SIRD (102%+ SIRD, Enhancing Magic Duration, Enhancing Magic Skill)
	-- Crusade, Reprisal, Protect, and Shell use this.
	sets.enhancingsird = {
		ammo="Staunch Tathlum",			--10 SIRD
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

	-- Raise (102%+ SIRD, Conserve MP)
	sets.raise = {
		ammo="Staunch Tathlum",		--10 SIRD
		head="Souv. Schaller +1",	--20 SIRD
		legs="Founder's Hose",		--30 SIRD
		feet="Odyssean Greaves",	--20 SIRD
		neck="Moonlight Necklace",	--15 SIRD
	}

	-- Holy Water (Holy Water+)
	sets.hwater = {
		neck="Nicander's Necklace",
		ring1="Blenmot's Ring +1",
		ring2="Blenmot's Ring +1",
	}

	-- Weapon Skill (STR, Weapon Skill Damage, Attack, Double/Triple Attack)
	sets.ws = {
		ammo="Oshasha's Treatise",
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
	sets.sav = set_combine(sets.ws, {
		
	})

	-- Sanguine Blade (Dark Magical, 50% STR, 50% MND mod)
	-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
	sets.sang = set_combine(sets.ws, {
		ammo="Oshasha's Treatise",
		head="Pixie Hairpin +1",
		waist="Eschan Stone",
		right_ear="Friomisi Earring",
		left_ring="Archon Ring",
	})

	-- Requiescat (~80% MND mod)
	-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
	sets.req = set_combine(sets.ws, {
		waist="Fotia Belt",
	})

	-- Chant du Cygne (80% DEX mod)
	-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
	sets.cdc = set_combine(sets.ws, {
		waist="Fotia Belt",
		right_ear="Mache Earring +1",
		left_ring="Hetairoi Ring",
	})

	-- Atonement (Fotia Neck/Belt)
	-- Combines with Enmity set, only necessary to set the slots with specific desired stats
	sets.ato = set_combine(sets.enmity, {

	})

	-- Invincible
	sets.invincible = {
		legs="Cab. Breeches",
	}

	-- Holy Circle (Enhances Holy Circle gear)
	sets.holycircle = set_combine(sets.enmity, {
		feet="Rev. Leggings +3",
	})

	-- Shield Bash (Enhances Shield Bash gear)
	sets.shieldbash = set_combine(sets.enmity, {
		hands="Cab. Gauntlets +3",
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
		hands="Cab. Gauntlets +3",
	}

	-- Divine Emblem (Enhances Divine Emblem gear)
	sets.divineemblem = {
		feet="Chev. Sabatons +3",
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
		body="Sylvie Unity Shirt",
	}

end




	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX          DO NOT EDIT BELOW THIS LINE          XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--




FileVersion = '12.0'

-------------------------------------------
--               UPDATES                 --
-------------------------------------------

--[[
MAJOR version updates require changes in the top portion of the file. Changes to gear sets will be noted.
MINOR and PATCH version updates typically only require changes under the "Do Not Edit Below This Line".
Ex: 1.2.3 (1 is the Major version, 2 is the Minor version, 3 is the patch version)

Version 12.0
-No gear set changes.
-Added Advanced Option to add commas to the damage numbers.
-Adjusted Weaponskill Missed notification to also display when a Weaponskill gets blinked.
-Removed notifications for Blood Pacts because I don't know why I added it in there.

Version 11.0
-No gear set changes.
-Renamed WS Damage Notification to Damage Notification.
-Updated Damage Notification to include Weapon Skills, Skillchains, Magic Bursts, and Blood Pacts.
-Fixed Damage Notification option displaying regardless of being on or off.
-Fixed some issues with SIRD sets not equipping correctly while in combat in DPS mode.
-Fixed AutoDefender checking for the old "Tank" mode as opposed to its current name "Combat".
-Updated to semantic versioning. This removes the need for the Version Compatibility Codenames.

04.15.23 (Version Compatibility Codename: Rampart)
-Added a DPS Gear Mode. There was a previous mode that was changed from DPS to Refresh (then later renamed to the current Neutral mode), this change keeps everything as is just adds a separate DPS mode in addition to the way the tanking modes are handled.
-Adjusted /BLU AOE spells to use Banishga if the target is outside of the 6' range that the /BLU spells have.
-Removed the ability to remove the Auto Gear Mode from the Gear Mode rotation. Added unnecessary complexity.
-Fixed missing options listings in the File Info (//fileinfo)
-Updated Version Compatibility Codename to Rampart.

02.22.23 (Version Compatibility Codename: Cover)
-Adjusted WS Damage Notification to display WSs for zero like normal. This reverses a previous change, but now with Skillchain damage being displayed alongside WS damage it made sense to show the zero damage instead of displaying as a miss.
-Fixed Invincible set not equipping when the Invincible Timer option is turned off.

02.07.23 (Version Compatibility Codename: Cover)
-Adjusted WS Damage Notification to filter out some Job Abilities that get listed in the same action category as Weapon Skills.

01.24.23 (Version Compatibility Codename: Cover)
-Adjusted WS Damage Notification to display Skillchain damage.

01.21.23 (Version Compatibility Codename: Cover)
-Adjusted Macro Page timing. Should fix occasional issue with macros deleting themselves.
-Adjusted WS Damage Notification to count blinked WSs and WSs for zero as a miss. Blinks would previously display the number of shadows as the damage number.
-Fixed issue with WS Damage Notification where some abilities and weapon skills would occasionally gets mixed up.

01.10.23 (Version Compatibility Codename: Cover)
-Adjusted HUD to automatically hide during zoning.
-Removed Omen and Vagary notifications. Those have been spun out into their own windower addon called Callouts.
-Fixed Intervene being counted as a Weapon Skill for the damage notification.
-Updated Version Compatibility Codename to Cover.

12.27.22 (Version Compatibility Codename: Sentinel)
-Overhauled the Aftermath notification. Renamed to Weapons. Will now always show your equipped weapon as a default state when no aftermath is up. Will change colors based on what your current TP will give you for an Aftermath effect.
-Adjusted AutoMajesty to not trigger in town.
-Removed the option to turn off the HUD. While I generally think the more options the better, the HUD is a main part of this lua.
-Fixed an error with AutoMajesty not triggering correctly during AfterCast.
-Fixed an error with recast timers and the /BLU spells.
-Fixed occasional error messages from the Text addon when loading/reloading the file.
-Updated Version Compatibility Codename to Sentinel.
-Code cleanup.

12.27.22 (Version Compatibility Codename: Shield Bash)
-Overhauled Low HP notification. Notification and sound no longer activates in towns. Changed the Advanced Option from selecting "Once" or "Constant" to instead selecting the number of times the sound will repeat while your HP is low. Removed the 30 second window before triggering again.
-Adjusted certain notification to now automatically clear after a short delay.
-Removed the option for using the OhShit gear set. The gear set itself still remains and funtionality has not changed. Having the option was redundant as you can simply leave the set empty.
-Fixed Aftermath notification displaying when the NotiAftermath option is turned off.
-Updated Version Compatibility Codename to Shield Bash.
-Code cleanup.

11.30.22 (Version Compatibility Codename: Holy Circle)
-Overhauled how death is handled. More cleanly prevents unnecessary notifications from activating immediately upon raising (ie Reraise wearing off and Low HP).
-Added Danger sound file. Used by Doom and Low HP.
-Added Advanced Option for the Danger sound to play constantly while in danger or only once (with a 30 second delay to be able to play again).
-Added WSDamage option. Displays your damage (or miss) after a Weapon Skill.
-Added Sanguine Blade set.
-Added the //hidehud and //showhud alias commands.
-Added debug lines for redefining variables.
-Adjusted the SIRD sets to not be needed when Aquaveil is up.
-Adjusted Low HP Notification to not trigger while weakened.
-Adjusted Low HP Notification Sound to have a 30 second window after triggering where it will not trigger again.
-Adjusted Low MP Notification to trigger in real-time rather than being tied to the Aftercast funtion.
-Adjusted HUD text object loading timing to avoid them occasionally not loading correctly.
-Adjusted AutoHWater option to stop and notify you once you are out of useable Holy Waters.
-Adjusted the Trade notification to clear once the trade is complete.
-Renamed OhShitThreshold to LowHPThreshold since it controls more than just the OhShit option.
-Removed the option to turn off the HUDRecast. While I generally think the more options the better, the recasts are a main part of the HUD.
-Removed the NotiTPReturn option. This was replaced by the WSDamage option
-Removed the CharmNaked option. Apparently you can't Do Stuff while charmed ¯\_(ツ)_/¯
-Fixed logic preventing Provoke from activating correctly when using Flash when Flash recast is down.
-Fixed incorrect SP Ability timers when wearing gear that augments (adds additional time to) the ability.
-Fixed missing AutoSentinel flag within the rule. Without this it would just trigger regardless of whether the option was set to on or off.
-Updated Version Compatibility Codename to Holy Circle.
-Code cleanup.

10.15.22 (Version Compatibility Codename: Invincible)
-Overhauled how enmity spells are handled. No more macro with a custom command in it. If you are /BLU, just use a macro for Sheep Song and it will cast Sheep Song, Geist Wall, Stinking Gas, or Soporific, in that order, as recasts timers allow. Additionally, now you can use a macro for Flash and it will also use Jettatura or Blank Gaze if you are /BLU, or Provoke if you are /WAR, depending on recast timers and distance to target.
-Added an Oh Shit gear set and accompanying option to use it. HP threshold required to activate is adjustable in the Advanced Options.
-Added AutoSentinel option. Automatically attempts to activate Sentinel when your HP gets critically low. HP threshold required to activate is adjustable in the Advanced Options.
-Added Low HP Notification.
-Added AutoHWater option. Automatically attempts to use Holy Waters when you get Doomed until it wears off. Currently will keep trying even if you run out of Holy Waters.
-Added DoomAlert option. Will alert your party when you are doomed. You can also customize the text that displays in party chat.
-Added CharmNaked option. Removes all gear, or all gear except weapons, when you are charmed.
-Added Crusade, Phalanx, Cocoon, Defender, Reprisal, Palisade, and Enlight to the list of things that will trigger AutoMajesty after use.
-Added Sneak and Invisible status notification.
-Added missing listings in the /fileinfo printout for a few Notifications.
-Added Silver Knife to list of Adoulin/Town areas.
-Adjusted the code that tries to wake you when you are asleep to not trigger if you are charmed.
-Adjusted resting to equip Refresh + Rest gear sets regardless of Mode.
-Moved AutoMajWindow, ModeCtrlPlus, and RRReminderTimer from Options to Advanced Options.
-Removed Gearswaps built-in showswaps function from the files debug mode.
-Fixed looking in the hands slot for the leg pieces to augment Invincible. (Thanks to Mailani for the catch)
-Updated Version Compatibility Codename to Invincible.
-Code cleanup.

09.10.22 (Version Compatibility Codename: Shield Mastery)
-Added AutoDEmblem option. Automatically activates Divine Emblem before a Flash when Divine Emblem is up.
-Added Max HP set and accompanying option to use it. Activates if you cure yourself while at or near capped HP% and will attempt to stay in it until your HP% falls too low, then switches back to your normal Tank set.
-Added all DOTs to the rule that removes Stoneskin if asleep.
-Split a number of sets into "X set" and "X set with SIRD" to have finer control over specific benefits per set (thanks Mailani for the idea).
-Renamed Idle set to Movement Speed since it's more accurate.
-Updated Version Compatibility Codename to Shield Mastery.

08.23.22 (Version Compatibility Codename: Resist Sleep)
-Adjusted what the fastcast set ignores to include all "Ring" items (previously would ignore only Warp and Dimensional Rings specifically, will now also ignore XP/CP rings)
-Fixed the macro needed for BLU Aoe spells in the Notes section

08.13.22 (Version Compatibility Codename: Resist Sleep)
-Overhauled the Mode functionality. There are now 3 modes: Auto, Combat, and Neutral. Combat and Neutral are the basic modes that can be selected individually or Auto will switch between the two in a (mostly) intelligent manner. Combat has a focus on tank sets and SIRD, while Neutral is for refresh and maximizing gear bonuses for buffs. What auto decides is based off when the game thinks you are in combat. This works just fine in most cases, but is not always exactly correct, so you can manually rotate between modes as needed.
-Added Leafallia to list of towns.
-Changed the Cursna set to Holy Water.
-Adjusted the Vim Torque code to first remove Stoneskin if its up, then check that we're not already poisoned and HP is above 50.
-Adjusted abilities to not equip their gear sets if they are still on cooldown.
-Curing while in combat will now fill in any undefined slots from the Healing set with the Enmity set.
-Removed the Buffs set. Protect and Shell were using this, they now use the Enhancing set instead. (Thanks to Mailani for the catch)
-Renamed LockstyleField to LockstyleCombat. Just makes more sense.
-Fixed an issue where the debuff background color change from Doom (flashing white and yellow) would get stuck on yellow after Doom wears off and you have another debuff on that takes over in the debuff spot.
-Updated Version Compatibility Codename to Resist Sleep.
-Code cleanup.

07.18.22 (Version Compatibility Codename: Defense Bonus)
-Updated AutoMajesty to now re-up Majesty before it wears off, exact timing window can be adjusted in the Options.
-Overhauled how area checks are handled. Uses tables now for groups of areas.
-Fixed some errors that would show up on job change. These were caused by the Heartbeat function constantly checking for any debuffs present; when you unload the file (change job) it will delete the debuff text objects used for the HUD which will cause a split second where the debuff check freaks out. The fix was to simply disable the debuff checks in town zones.
-Fixed an issue with the Sleep debuff not showing properly in the HUD.
-Updated Version Compatibility Codename to Defense Bonus.
-Code cleanup.

06.14.22 (Version Compatibility Codename: Undead Killer)
-Adjusted HUD timings on load. Should fix the occasional errors about text objects not existing as well as objects loading underneath the background layer.
-Adjusted Ability recast order in the HUD.
-Changed DPS mode to Refresh mode and adjusted gear equipping and HUD behavior accordingly.
-Removed Gearswaps built-in debugmode from the files Debug mode.
-Fixed Relic Aftermath not displaying in the HUD.
-Moved the Updates section towards the top of the file.
-Code cleanup.

03.11.22 (Version Compatibility Codename: Undead Killer)
-Overhauled Debuff Notifications. Will now check which debuffs are up in real time with a list of priority for which is displayed instead of clearing the notifications entirely when any of them are removed (leaving it blank even if a different debuff was still up).
-Added missing On/Off option/rules to Time Remaining (currently only for Abyssea), Omen, and Vagary
-Fixed Alliance invite incorrectly triggering Party invite notification.
-Fixed some subjob conditions throwing errors when you have no subjob (ie Odyssey NMs)
-Fixed AutoMajesty and AutoDefender to not attempt to activate when you have Amnesia.

02.02.22 (Version Compatibility Codename: Undead Killer)
-Added Weak status notification.
-Updated "Codename" to "Version Compatibility Codename" to be more clear in its purpose. Whenever changes are made to the top portion of the file, the Version Compatibility Codename is changed and the TopVersion and BottomVersion updated to reflect the new codename. The idea is that the Top and Bottom Versions should always match. If you update your file after the VCC changes and only update the bottom without also doing the top, they will then no longer match making it easier to help find a problem later.
-Updated how the HUD loading is handled. The loading is now smoother and objects don't overlap eachother while loading.
-Fixed gear not fully equipping in towns.
-Fixed Abyssea Visitant status triggering on incorrect time remaining (ie 110 minutes would trigger the 10 minute)
-Fixed Fast Cast gear to not equip when using a Forbidden Key, Pickaxe, Sickle, or Hatchet.

02.01.22 (Version Compatibility Codename: Undead Killer)
-First version
-Started from Blue Mage file version 02.01.22
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
NotiLowMPToggle = 'Off' --start with the toggle off for the Low MP Notification so that it can trigger
RRRCountdown = RRReminderTimer
HWaterRecast = 0
HWater = true --this is used as a simple on/off for when we run out of Holy Waters
Heartbeat = 0 --set to 0 just to start the Heartbeat running
LoadDelay = 4 --delays loading the HUD, this makes sure all the variables get set correctly before being used, displays file version info, and waits to use lockstyle
LoadHUD = false --starts false then switched to true after the LoadDelay
ShowHUD = true --this changes to false when we zone or are in a cutscene
MajestyTimer = 0
LockstyleDelay = 3
AutoLockstyleRun = true
MaxHP = false
LowHP = false
Doom = false
Alive = true --makes it easier to Do Things or Not Do Things based on if we die.
DangerCountdown = 0
NotiCountdown = -1 --we set the countdown below 0 to stop the countdown from hitting 0 and triggering the ClearNotifications command
if player.in_combat == true then
	Combat = true
elseif player.in_combat == false then
	Combat = false
end

--set the initial recasts to 0, they will get updated in the Heartbeat function:
DefenderRecast = 0
CocoonRecast = 0
CrusadeRecast = 0
PhalanxRecast = 0
ReprisalRecast = 0
PalisadeRecast = 0
EnlightRecast = 0

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
send_command('wait 1.6;text loading create "Loading Keys PALADIN file ver: '..FileVersion..'...";wait .3;text loading size '..FontSize..';text loading pos '..HUDposXColumn1..' '..HUDposYLine1..';text loading bg_transparency 1') --Loading
send_command('wait 1.7;text bg2 create "                                                                                                                          ";wait .3;text bg2 size '..FontSize..';text bg2 pos '..HUDposXColumn1..' -100;text bg2 bg_transparency '..HUDBGTrans..'')--Background Line 2
send_command('wait 1.8;text bg3 create "                                                                                                                          ";wait .3;text bg3 size '..FontSize..';text bg3 pos '..HUDposXColumn1..' -100;text bg3 bg_transparency '..HUDBGTrans..'')--Background Line 3
--Create the Aftermath, Mode, Notifications, and Debuffs text objects and put them above the screen for now, we'll move them to the correct place next
send_command('wait 1.9;text weapons create "« Weapons loading... »";wait .3;text weapons size '..FontSize..';text weapons pos '..HUDposXColumn4..' -100;text weapons color 255 50 50;text weapons bg_transparency 1') --Aftermath
if Mode == 'Auto' then
	send_command('wait 2;text mode create "Mode: '..Mode..'";wait .3;text mode size '..FontSize..';text mode pos '..HUDposXColumn1..' -100;text mode color '..Autocolor..';text mode bg_transparency 1') --Auto Mode
elseif Mode == 'Combat' then
	send_command('wait 2;text mode create "Mode: '..Mode..'";wait .3;text mode size '..FontSize..';text mode pos '..HUDposXColumn1..' -100;text mode color '..Combatcolor..';text mode bg_transparency 1') --Combat Mode
elseif Mode == 'Neutral' then
	send_command('wait 2;text mode create "Mode: '..Mode..'";wait .3;text mode size '..FontSize..';text mode pos '..HUDposXColumn1..' -100;text mode color '..Neutralcolor..';text mode bg_transparency 1') --Neutral Mode
elseif Mode == 'DPS' then
	send_command('wait 2;text mode create "Mode: '..Mode..'";wait .3;text mode size '..FontSize..';text mode pos '..HUDposXColumn1..' -100;text mode color '..DPScolor..';text mode bg_transparency 1') --DPS Mode
end
send_command('wait 2.1;text notifications create "Hello, '..player.name..'! (type //fileinfo for more information)";wait .3;text notifications size '..FontSize..';text notifications pos '..HUDposXColumn1..' -100;text notifications bg_transparency 1') --Notifications
send_command('wait 2.2;text debuffs create " ";wait .3;text debuffs size '..FontSize..';text debuffs pos '..HUDposXColumn4..' -100;text debuffs bg_transparency 1') --Debuffs
--Create all the HUD Recast text objects and put them above the screen for now, we'll move them to the correct place next
send_command('wait 2.3;text defender create "[ Defender ]";wait .3;text defender size '..FontSize..';text defender pos '..HUDposXColumn1..' -100;text defender bg_transparency 1')
send_command('wait 2.4;text cocoon create "[ Cocoon ]";wait .3;text cocoon size '..FontSize..';text cocoon pos '..HUDposXColumn1..' -100;text cocoon bg_transparency 1')
send_command('wait 2.5;text crusade create "[ Crusade ]";wait .3;text crusade size '..FontSize..';text crusade pos '..HUDposXColumn1..' -100;text crusade bg_transparency 1')
send_command('wait 2.6;text phalanx create "[ Phalanx ]";wait .3;text phalanx size '..FontSize..';text phalanx pos '..HUDposXColumn1..' -100;text phalanx bg_transparency 1')
send_command('wait 2.7;text reprisal create "[ Reprisal ]";wait .3;text reprisal size '..FontSize..';text reprisal pos '..HUDposXColumn1..' -100;text reprisal bg_transparency 1')
send_command('wait 2.8;text palisade create "[ Palisade ]";wait .3;text palisade size '..FontSize..';text palisade pos '..HUDposXColumn1..' -100;text palisade bg_transparency 1')
send_command('wait 2.9;text enlight create "[ Enlight ]";wait .3;text enlight size '..FontSize..';text enlight pos '..HUDposXColumn1..' -100;text enlight bg_transparency 1')

send_command('alias lockstyle gs c Lockstyle') --creates the first lockstyle aliases
send_command('alias lstyle gs c Lockstyle') --creates the second lockstyle aliases
if Chat ~= "Off" then
	send_command('input /cm '..Chat..'')
end
if Book ~= "Off" then
	send_command('input /macro book '..Book..'')
end
if Page ~= "Off" then
	send_command('wait 2;input /macro set '..Page..'')
end
send_command('alias fileinfo gs c Fileinfo') --creates the fileinfo alias
send_command('alias mode gs c Mode') --creates the Mode alias
send_command('alias hidehud gs c HideHUD') --creates the HideHUD alias
send_command('alias showhud gs c ShowHUD') --creates the ShowHUD alias
send_command('bind ^'..ModeCtrlPlus..' gs c Mode') --creates the gear mode keyboard shortcut
if Debug == 'On' then
	windower.add_to_chat(8,'[Debug Mode: On]')
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

-------------------------------------------
--            SELF COMMANDS              --
-------------------------------------------

function self_command(command)
	if command == 'Mode' then
		if Mode == 'Auto' then
			Mode = 'Combat'
			send_command('text mode color '..Combatcolor..'')
		elseif Mode == 'Combat' then
			Mode = 'Neutral'
			send_command('text mode color '..Neutralcolor..'')
		elseif Mode == 'Neutral' then
			Mode = 'DPS'
			send_command('text mode color '..DPScolor..'')
		elseif Mode == 'DPS' then
			Mode = 'Auto'
			send_command('text mode color '..Autocolor..'')
		end
		if LoadHUD == true then
			send_command('text mode text "Mode: '..Mode..'"')
		end
		if Debug == 'On' then
			windower.add_to_chat(8,'[Mode set to '..Mode..']')
		end
		choose_set()
	elseif command == 'ClearNotifications' and LoadHUD == true then --these reset the Notifications display back to a basic state
		if buffactive['Sneak'] and buffactive['Invisible'] then
			send_command('text notifications text "Status: Sneak & Invisible";text notifications color 50 205 50;text notifications bg_transparency 1')
		elseif buffactive['Sneak'] then
			send_command('text notifications text "Status: Sneak";text notifications color 50 205 50;text notifications bg_transparency 1')
		elseif buffactive['Invisible'] then
			send_command('text notifications text "Status: Invisible";text notifications color 50 205 50;text notifications bg_transparency 1')
		elseif buffactive['weakness'] then
			send_command('text notifications text "Status: Weak";text notifications color 205 133 63;text notifications bg_transparency 1')
		elseif player.mpp <= 20 then
			send_command('text notifications text "«« Low MP »»";text notifications color 205 133 63;text notifications bg_transparency 1')
		elseif player.status == "Resting" then
			send_command('text notifications text "Status: Resting";text notifications color 255 255 255;text notifications bg_transparency 1')
		elseif player.status == "Engaged" then
			send_command('text notifications text "Status: Engaged";text notifications color 255 255 255;text notifications bg_transparency 1')
		elseif player.status == "Idle" and (Mode == 'Combat' or (Mode == 'Auto' and player.in_combat == true)) then
				send_command('text notifications text "Status: Kiting";text notifications color 255 255 255;text notifications bg_transparency 1')
		elseif player.status == "Idle" then
			send_command('text notifications text "Status: Idle";text notifications color 255 255 255;text notifications bg_transparency 1')
		end
	elseif command == 'ClearDebuffs' and LoadHUD == true then --these reset the Debuffs display back to a basic state
		send_command('text debuffs text "";text debuffs color 255 255 255;text debuffs bg_transparency 1')
	elseif command == 'LoadHUD' then
		LoadHUD = true
		if Debug == 'On' then
			windower.add_to_chat(8,'[LoadHUD set to True]')
		end
		send_command('text loading hide')
		send_command('wait .1;text bg2 pos '..HUDposXColumn1..' '..HUDposYLine2..'')
		send_command('wait .2;text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')
		if player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
			send_command('wait .7;text crusade pos '..HUDposXColumn1..' '..HUDposYLine1..'')	--Crusade goes in Column 1
			send_command('wait .7;text phalanx pos '..HUDposXColumn2..' '..HUDposYLine1..'')	--Phalanx goes in Column 2
			send_command('wait .7;text defender pos '..HUDposXColumn3..' '..HUDposYLine1..'')	--Defender goes in Column 3
			send_command('wait .7;text reprisal pos '..HUDposXColumn4..' '..HUDposYLine1..'')	--Reprisal goes in Column 4
			send_command('wait .7;text palisade pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Palisade goes in Column 5
			send_command('wait .7;text enlight pos '..HUDposXColumn6..' '..HUDposYLine1..'')	--Enlight goes in Column 6
		elseif player.sub_job == 'BLU' and player.sub_job_level ~= 0 then
			send_command('wait .7;text crusade pos '..HUDposXColumn1..' '..HUDposYLine1..'')	--Crusade goes in Column 1
			send_command('wait .7;text phalanx pos '..HUDposXColumn2..' '..HUDposYLine1..'')	--Phalanx goes in Column 2
			send_command('wait .7;text cocoon pos '..HUDposXColumn3..' '..HUDposYLine1..'')		--Cocoon goes in Column 1
			send_command('wait .7;text reprisal pos '..HUDposXColumn4..' '..HUDposYLine1..'')	--Reprisal goes in Column 4
			send_command('wait .7;text palisade pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Palisade goes in Column 5
			send_command('wait .7;text enlight pos '..HUDposXColumn6..' '..HUDposYLine1..'')	--Enlight goes in Column 6
		else
			send_command('wait .7;text crusade pos '..HUDposXColumn1..' '..HUDposYLine1..'')	--Crusade goes in Column 1
			send_command('wait .7;text phalanx pos '..HUDposXColumn2..' '..HUDposYLine1..'')	--Phalanx goes in Column 2
			send_command('wait .7;text reprisal pos '..HUDposXColumn3..' '..HUDposYLine1..'')	--Reprisal goes in Column 3
			send_command('wait .7;text palisade pos '..HUDposXColumn4..' '..HUDposYLine1..'')	--Palisade goes in Column 4
			send_command('wait .7;text enlight pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Enlight goes in Column 5
		end
		send_command('wait .8;text mode pos '..HUDposXColumn1..' '..HUDposYLine2..'')
		if NotiWeapons == 'On' then
			send_command('wait .8;text weapons pos '..HUDposXColumn4..' '..HUDposYLine2..'')
		end
		send_command('wait .9;text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')
		send_command('wait .9;text debuffs pos '..HUDposXColumn4..' '..HUDposYLine3..'')
	elseif command == 'Fileinfo' then
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(3,'--  Keys Gearswap lua file for Paladin  --')
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(200,'File Version Number: '..(''..FileVersion..''):color(8)..'')
		windower.add_to_chat(8,' ')
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
		windower.add_to_chat(8,'To use /BLU AOE spells, use a macro for Sheep Song and it will')
		windower.add_to_chat(8,'cycle through Sheep Song, Geist Wall, Stinking Gas, and Soporific,')
		windower.add_to_chat(8,'in that order, as recasts timers allow. Additionally, using this on')
		windower.add_to_chat(8,'a target outside of these spells aoe range will change the spell to')
		windower.add_to_chat(8,'instead use Banishga.')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'To use /BLU Single target spells, use a macro for Flash and it will')
		windower.add_to_chat(8,'cycle through Flash, Jettatura, and Blank Gaze, in that order, as recast')
		windower.add_to_chat(8,'timers and distance allow (or if you are /WAR it will also Provoke).')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'Run the Lockstyle function yourself at any time by typing')
		windower.add_to_chat(200,'        //lockstyle or //lstyle')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'Hide or show the HUD at any time by typing')
		windower.add_to_chat(200,'        //hidehud or //showhud')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'For the HUD function, suggested placement is')
		windower.add_to_chat(8,'center screen, just above your chat log.')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'IMPORTANT:')
		windower.add_to_chat(8,'When you load this file for the first time, your HUD')
		windower.add_to_chat(8,'may look all wrong. The defaults preloaded are for a')
		windower.add_to_chat(8,'screen at 3440x1400. Adjust the FontSize, LineSpacer,')
		windower.add_to_chat(8,'and ColumnSpacer options as needed.')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'Recommended Windower Addons: Text')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'-------------------------------------------')
		windower.add_to_chat(8,'--               PRO TIPS                --')
		windower.add_to_chat(8,'-------------------------------------------')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'There are 4 Modes available in this file:')
		windower.add_to_chat(200,'Auto-')
		windower.add_to_chat(8,'Will decide gear based on whether or not the game thinks you are in')
		windower.add_to_chat(8,'combat. Spells will use their specific gear sets by themselves when')
		windower.add_to_chat(8,'you are not in combat (so you can get full gear bonuses), and will')
		windower.add_to_chat(8,'override them with the SIRD set if you are in combat. Will use')
		windower.add_to_chat(8,'idle/tank set if disengaged but in combat (ie kiting), or')
		windower.add_to_chat(8,'idle/refresh set if disengaged and not in combat.')
		windower.add_to_chat(200,'Combat-')
		windower.add_to_chat(8,'Gear set choices will always behave as if you are in combat.')
		windower.add_to_chat(200,'Neutral-')
		windower.add_to_chat(8,'Gear set choices will always behave as if you are not in combat.')
		windower.add_to_chat(200,'DPS-')
		windower.add_to_chat(8,'Uses the DPS gear set when in combat.')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'NOTE: Auto should work fine in most cases, but be aware that the')
		windower.add_to_chat(8,'game isn\'t always correct about when you are in combat. For example,')
		windower.add_to_chat(8,'if you run by a mob and aggro it, you\'ll notice the battle music')
		windower.add_to_chat(8,'does not start. If you are kiting a mob, and it goes yellow, the')
		windower.add_to_chat(8,'game will think you are out of combat. You can either keep up')
		windower.add_to_chat(8,'actions on the mob to keep it claimed (voke, flash, etc) or switch')
		windower.add_to_chat(8,'into Combat mode manually.')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(3,'--                  Options                  --')
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(200,'AutoLockstyle: '..(''..AutoLockstyle..''):color(8)..'')
		windower.add_to_chat(200,'LockstyleCombat: '..(''..LockstyleCombat..''):color(8)..'')
		windower.add_to_chat(200,'LockstyleTown: '..(''..LockstyleTown..''):color(8)..'')
		windower.add_to_chat(200,'Book: '..(''..Book..''):color(8)..'')
		windower.add_to_chat(200,'Page: '..(''..Page..''):color(8)..'')
		windower.add_to_chat(200,'Chat: '..(''..Chat..''):color(8)..'')
		windower.add_to_chat(200,'InvTimer: '..(''..InvTimer..''):color(8)..'')
		windower.add_to_chat(200,'IntTimer: '..(''..IntTimer..''):color(8)..'')
		windower.add_to_chat(200,'ZoneGear: '..(''..ZoneGear..''):color(8)..'')
		windower.add_to_chat(200,'AlertSounds: '..(''..AlertSounds..''):color(8)..'')
		windower.add_to_chat(200,'UseEcho: '..(''..UseEcho..''):color(8)..'')
		windower.add_to_chat(200,'AutoHWater: '..(''..AutoHWater..''):color(8)..'')
		windower.add_to_chat(200,'AutoMajesty: '..(''..AutoMajesty..''):color(8)..'')
		windower.add_to_chat(200,'AutoDefender: '..(''..AutoDefender..''):color(8)..'')
		windower.add_to_chat(200,'AutoDEmblem: '..(''..AutoDEmblem..''):color(8)..'')
		windower.add_to_chat(200,'UseMaxHP: '..(''..UseMaxHP..''):color(8)..'')
		windower.add_to_chat(200,'AutoSentinel: '..(''..AutoSentinel..''):color(8)..'')
		windower.add_to_chat(200,'DoomAlert: '..(''..DoomAlert..''):color(8)..'')
		windower.add_to_chat(200,'DoomOnText: '..(''..DoomOnText..''):color(8)..'')
		windower.add_to_chat(200,'DoomOffText: '..(''..DoomOffText..''):color(8)..'')
		windower.add_to_chat(200,' ')
		windower.add_to_chat(3,'-- Heads Up Display --')
		windower.add_to_chat(200,'HUDposX: '..(''..HUDposX..''):color(8)..'')
		windower.add_to_chat(200,'HUDposYLine1: '..(''..HUDposYLine1..''):color(8)..'')
		windower.add_to_chat(200,'FontSize: '..(''..FontSize..''):color(8)..'')
		windower.add_to_chat(200,'LineSpacer: '..(''..LineSpacer..''):color(8)..'')
		windower.add_to_chat(200,'ColumnSpacer: '..(''..ColumnSpacer..''):color(8)..'')
		windower.add_to_chat(200,' ')
		windower.add_to_chat(3,'-- General Notifications --')
		windower.add_to_chat(200,'Noti3000TP: '..(''..Noti3000TP..''):color(8)..'')
		windower.add_to_chat(200,'NotiWeapons: '..(''..NotiWeapons..''):color(8)..'')
		windower.add_to_chat(200,'NotiTrade: '..(''..NotiTrade..''):color(8)..'')
		windower.add_to_chat(200,'NotiInvite: '..(''..NotiInvite..''):color(8)..'')
		windower.add_to_chat(200,'NotiSneak: '..(''..NotiSneak..''):color(8)..'')
		windower.add_to_chat(200,'NotiInvis: '..(''..NotiInvis..''):color(8)..'')
		windower.add_to_chat(200,'NotiReraise: '..(''..NotiReraise..''):color(8)..'')
		windower.add_to_chat(200,'NotiFood: '..(''..NotiFood..''):color(8)..'')
		windower.add_to_chat(200,'NotiLowMP: '..(''..NotiLowMP..''):color(8)..'')
		windower.add_to_chat(200,'NotiLowHP: '..(''..NotiLowHP..''):color(8)..'')
		windower.add_to_chat(200,'NotiDamage: '..(''..NotiDamage..''):color(8)..'')
		windower.add_to_chat(200,'ReraiseReminder: '..(''..ReraiseReminder..''):color(8)..'')
		windower.add_to_chat(200,'NotiTime: '..(''..NotiTime..''):color(8)..'')
		windower.add_to_chat(200,' ')
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
		windower.add_to_chat(200,'StartMode: '..(''..StartMode..''):color(8)..'')
		windower.add_to_chat(200,'ModeCtrlPlus: '..(''..ModeCtrlPlus..''):color(8)..'')
		windower.add_to_chat(200,'AutoMajWindow: '..(''..AutoMajWindow..''):color(8)..'')
		windower.add_to_chat(200,'MaxHPThreshold: '..(''..MaxHPThreshold..''):color(8)..'')
		windower.add_to_chat(200,'LowHPThreshold: '..(''..LowHPThreshold..''):color(8)..'')
		windower.add_to_chat(200,'DangerRepeat: '..(''..DangerRepeat..''):color(8)..'')
		windower.add_to_chat(200,'AutSntThreshold: '..(''..AutSntThreshold..''):color(8)..'')
		windower.add_to_chat(200,'RRReminderTimer: '..(''..RRReminderTimer..''):color(8)..'')
		windower.add_to_chat(200,'NotiDelay: '..(''..NotiDelay..''):color(8)..'')
		windower.add_to_chat(200,'HUDBGTrans: '..(''..HUDBGTrans..''):color(8)..'')
		windower.add_to_chat(200,'AddCommas: '..(''..AddCommas..''):color(8)..'')
		windower.add_to_chat(200,'Debug: '..(''..Debug..''):color(8)..'')
		windower.add_to_chat(200,' ')
		windower.add_to_chat(3,'-- Color Values --')
		windower.add_to_chat(200,'Autocolor: '..(''..Autocolor..''):color(8)..'')
		windower.add_to_chat(200,'Combatcolor: '..(''..Combatcolor..''):color(8)..'')
		windower.add_to_chat(200,'Neutralcolor: '..(''..Neutralcolor..''):color(8)..'')
		windower.add_to_chat(200,'DPScolor: '..(''..DPScolor..''):color(8)..'')
		windower.add_to_chat(200,'Aftermath1color: '..(''..Aftermath1color..''):color(8)..'')
		windower.add_to_chat(200,'Aftermath2color: '..(''..Aftermath2color..''):color(8)..'')
		windower.add_to_chat(200,'Aftermath3color: '..(''..Aftermath3color..''):color(8)..'')
		windower.add_to_chat(200,' ')
		windower.add_to_chat(3,'Options can be changed in the file itself.')
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
				windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
			end
		end
	elseif command == 'NotiLowMPToggle' then
		NotiLowMPToggle = 'Off'
		if Debug == 'On' then
			windower.add_to_chat(8,'[NotiLowMPToggle set to Off]')
		end
	elseif command == 'AliveDelay' then
		Alive = true --putting this in a command lets us set a small delay to prevent things from triggering right when we raise up
		if Debug == 'On' then
			windower.add_to_chat(8,'[Alive set to True]')
		end
	elseif command == 'HideHUD' then
		ShowHUD = false
		if Debug == 'On' then
			windower.add_to_chat(8,'[ShowHUD set to False]')
		end
		send_command('text bg1 hide;text bg2 hide;text bg3 hide;text phalanx hide;text crusade hide;text palisade hide;text reprisal hide;text defender hide;text cocoon hide;text enlight hide;text mode hide;text notifications hide;text debuffs hide;text weapons hide')
	elseif command == 'ShowHUD' then
		ShowHUD = true
		if Debug == 'On' then
			windower.add_to_chat(8,'[ShowHUD set to True]')
		end
		send_command('text bg1 show;text bg2 show;text bg3 show;text phalanx show;text crusade show;text palisade show;text reprisal show;text defender show;text cocoon show;text enlight show;text mode show;text notifications show;text debuffs show;text weapons show')
	end
end

-------------------------------------------
--              CHOOSE SET               --
-------------------------------------------

function choose_set()
	if player.status == "Resting" then
		if LoadHUD == true then
			if buffactive['Weakness'] then
				send_command('text notifications text "Status: Weak";text notifications color 205 133 63;text notifications bg_transparency 1')
			elseif player.mpp <= 20 then
				send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50;text notifications bg_transparency 1')
			else
				send_command('text notifications text "Status: Resting";text notifications color 255 255 255;text notifications bg_transparency 1')
			end
		end
		equip(set_combine(sets.refresh, sets.rest)) --No matter what Mode we're in, if we're resting its because we need MP so we equip the Refresh set along with the Rest set
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Refresh + Rest]')
		end
	elseif player.status == "Engaged" then
		if LoadHUD == true then
			if buffactive['Weakness'] then
				send_command('text notifications text "Status: Weak";text notifications color 205 133 63;text notifications bg_transparency 1')
			elseif player.mpp <= 20 then
				send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50;text notifications bg_transparency 1')
			else
				send_command('text notifications text "Status: Engaged";text notifications color 255 255 255;text notifications bg_transparency 1')
			end
		end
		if LowHP == true then --no matter what Mode we're in, if we have low HP we equip the Oh Shit gear set
			equip(sets.ohshit)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Oh Shit]')
			end
		elseif Mode == 'Auto' or Mode == 'Combat' then -- if we're engaged we automatically get put into combat
			if MaxHP == true then
				equip(sets.maxhp)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Max HP]')
				end
			else
				equip(sets.tank)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Tank]')
				end
			end
		elseif Mode == 'Neutral' then
			equip(sets.refresh)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Refresh]')
			end
		elseif Mode == 'DPS' then
			equip(sets.dps)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: DPS]')
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
			elseif buffactive['Weakness'] then
				send_command('text notifications text "Status: Weak";text notifications color 205 133 63;text notifications bg_transparency 1')
			elseif player.mpp <= 20 then
				send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50;text notifications bg_transparency 1')
			elseif Mode == 'Combat' or (Mode == 'Auto' and player.in_combat == true) then
				send_command('text notifications text "Status: Kiting";text notifications color 255 255 255;text notifications bg_transparency 1')
			else
				send_command('text notifications text "Status: Idle";text notifications color 255 255 255;text notifications bg_transparency 1')
			end
		end
		if AdoulinZones:contains(world.area) then
			equip(set_combine(sets.refresh, sets.movementspeed, sets.adoulin))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Refresh + Movement Speed + Adoulin]')
			end
		elseif BastokZones:contains(world.area) then
			equip(set_combine(sets.refresh, sets.movementspeed, sets.bastok))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Refresh + Movement Speed + Bastok]')
			end
		elseif SandyZones:contains(world.area) then
			equip(set_combine(sets.refresh, sets.movementspeed, sets.sandoria))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Refresh + Movement Speed + San d\'Oria]')
			end
		elseif WindyZones:contains(world.area) then
			equip(set_combine(sets.refresh, sets.movementspeed, sets.windurst))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Refresh + Movement Speed + Windurst]')
			end
		elseif TownZones:contains(world.area) then
			equip(set_combine(sets.refresh, sets.movementspeed, sets.town))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Refresh + Movement Speed + Town]')
			end
		else
			if LowHP == true then --no matter what Mode we're in, if we have low HP we equip the Oh Shit gear set (plus movement speed to <{Run away!}>)
				equip(set_combine(sets.ohshit, sets.movementspeed))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Oh Shit + Movement Speed]')
				end
			elseif (Mode == 'Auto' and player.in_combat == true) or Mode == 'Combat' then -- if we're idle but ARE in combat (ex: kiting, mob is aggressive) we equip the tank/idle sets
				if MaxHP == true then
					equip(set_combine(sets.maxhp, sets.movementspeed))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Max HP + Movement Speed]')
					end
				else
					equip(set_combine(sets.tank, sets.movementspeed))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Tank + Movement Speed]')
					end
				end
			elseif (Mode == 'Auto' and player.in_combat == false) or Mode == 'Neutral' or Mode == 'DPS' then --if we're idle and NOT in combat (ex: buffing up before a fight, mob is not aggressive yet) we equip the refresh/idle sets
				if MaxHP == true then
					equip(set_combine(sets.maxhp, sets.movementspeed))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Max HP + Movement Speed]')
					end
				else
					equip(set_combine(sets.refresh, sets.movementspeed))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Refresh + Movement Speed]')
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
		if UseEcho == 'E' then
			send_command('input /item "Echo Drop" <me>')
		elseif UseEcho == 'R' then
			send_command('input /item "Remedy" <me>')
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
					windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
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
					windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
				end
			end
			cancel_spell()
			return
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
		elseif spell.english == 'Sanguine Blade' then
			equip(sets.sang)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Sanguine Blade + Weapon Skill]')
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
	elseif spell.english == 'Invincible' and windower.ffxi.get_ability_recasts()[0] <= 1 then
		equip(sets.invincible)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Invincible]')
		end
	elseif spell.english == 'Holy Circle' and windower.ffxi.get_ability_recasts()[74] <= 1 then
		equip(sets.holycircle)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Holy Circle + Enmity]')
		end
	elseif spell.english == 'Shield Bash' and windower.ffxi.get_ability_recasts()[73] <= 1 then
		equip(sets.shieldbash)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Shield Bash + Enmity]')
		end
	elseif spell.english == 'Sentinel' and windower.ffxi.get_ability_recasts()[75] <= 1 then
		equip(sets.sentinel)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Sentinel + Enmity]')
		end
	elseif spell.english == 'Cover' and windower.ffxi.get_ability_recasts()[76] <= 1 then
		equip(sets.cover)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Cover]')
		end
	elseif spell.english == 'Rampart' and windower.ffxi.get_ability_recasts()[77] <= 1 then
		equip(sets.rampart)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Rampart + Enmity]')
		end
	elseif spell.english == 'Fealty' and windower.ffxi.get_ability_recasts()[78] <= 1 then
		equip(sets.fealty)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Fealty]')
		end
	elseif spell.english == 'Chivalry' and windower.ffxi.get_ability_recasts()[79] <= 1 then
		equip(sets.chivalry)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Chivalry]')
		end
	elseif spell.english == 'Divine Emblem' and windower.ffxi.get_ability_recasts()[80] <= 1 then
		equip(sets.divineemblem)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Divine Emblem]')
		end
	elseif spell.english == 'Holy Water' then
		equip(sets.hwater)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Holy Water]')
		end
	elseif spell.english == 'Majesty' and windower.ffxi.get_ability_recasts()[150] <= 1 then
		MajestyTimer = 180
		if Debug == 'On' then
			windower.add_to_chat(8,'[MajestyTimer set to 180]')
		end
	elseif (spell.english == 'Spectral Jig' or spell.english == 'Sneak' or spell.english == 'Monomi: Ichi' or spell.english == 'Monomi: Ni') and buffactive['Sneak'] and spell.target.type == 'SELF' then
		send_command('cancel 71')
	--if we're casting a cure or protect without Majesty up, we'll put it up before casting:
	elseif AutoMajesty == 'On' and ((string.find(spell.english,'Cur') and spell.type == 'WhiteMagic') or string.find(spell.english,'Protect')) and not buffactive['Majesty'] and not buffactive['Amnesia'] and windower.ffxi.get_ability_recasts()[150] == 0 then
		send_command('input /ja Majesty <me>;wait 1;input /ma '..spell.english..' '..spell.target.raw..'')
		cancel_spell()
		return
	elseif spell.english == "Flash" then
		if windower.ffxi.get_spell_recasts()[112] <= 1 then
			if AutoDEmblem == 'On' and not buffactive['Amnesia'] and windower.ffxi.get_ability_recasts()[80] == 0 then
				send_command('input /ja "Divine Emblem" <me>;wait 1;input /ma Flash '..spell.target.raw..'')
				cancel_spell()
				return
			end
			equip(sets.fastcast)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Fast Cast]')
			end
		elseif player.sub_job == 'BLU' and player.sub_job_level ~= 0 then
			if windower.ffxi.get_spell_recasts()[575] <= 1 and spell.target.distance <= 9 then
				send_command('input /ma "Jettatura" '..spell.target.raw..'')
				cancel_spell()
				return
			elseif windower.ffxi.get_spell_recasts()[592] <= 1 and spell.target.distance <= 14 then
				send_command('input /ma "Blank Gaze" '..spell.target.raw..'')
				cancel_spell()
				return
			end
		elseif player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
			if windower.ffxi.get_ability_recasts()[5] <= 1 and spell.target.distance <= 17.8 and not buffactive['Amnesia'] then
				send_command('input /ja "Provoke" '..spell.target.raw..'')
				cancel_spell()
				return
			end
		end
	elseif spell.english == "Sheep Song" then
		if spell.target.distance > 6 then
			equip(sets.fastcast)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Fast Cast]')
			end
		elseif player.sub_job == 'RUN' then
			send_command('input /ma "Foil" <me>')
			cancel_spell()
			return
		elseif player.sub_job == 'BLU' then
			if windower.ffxi.get_spell_recasts()[605] <= 1 then
				send_command('input /ma "Geist Wall" '..spell.target.raw..'')
				cancel_spell()
				return
			elseif windower.ffxi.get_spell_recasts()[537] <= 1 then
				send_command('input /ma "Stinking Gas" '..spell.target.raw..'')
				cancel_spell()
				return
			elseif windower.ffxi.get_spell_recasts()[598] <= 1 then
				send_command('input /ma "Soporific" '..spell.target.raw..'')
				cancel_spell()
				return
			end
		end
	elseif not (string.find(spell.english,' Ring') or spell.english == 'Forbidden Key' or spell.english == 'Pickaxe' or spell.english == 'Sickle' or spell.english == 'Hatchet') then
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
	if string.find(spell.english,'Cur') and spell.type == "WhiteMagic" then
		if Mode == 'Combat' or ((Mode == 'Auto' or Mode == 'DPS') and player.in_combat == true) and not buffactive['Aquaveil'] then -- in combat, no Aquaveil, so we need SIRD
			if player.hpp >= MaxHPThreshold and spell.target.type == 'SELF' and UseMaxHP == 'On' then
				equip(sets.maxhpsird)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Max HP with SIRD]')
				end
			else
				equip(set_combine(sets.enmity, sets.healingsird))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Enmity + Healing with SIRD]')
				end
			end
		elseif Mode == 'Neutral' or ((Mode == 'Auto' or Mode == 'DPS') and player.in_combat == false) then --not in combat, no need for SIRD
			if spell.target.type == 'SELF' then
				equip(sets.maxhp)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Max HP]')
				end			
			else
				equip(sets.healing)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Healing]')
				end
			end
		end
	elseif spell.english =='Raise' then
		equip(sets.raise)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Raise]')
		end		
	elseif spell.english == 'Flash' or string.find(spell.english,'Holy') or string.find(spell.english,'Banish') or spell.type == "BlueMagic" then
		if Mode == 'Combat' or ((Mode == 'Auto' or Mode == 'DPS') and player.in_combat == true) and not buffactive['Aquaveil'] then -- in combat, no Aquaveil, so we need SIRD
			equip(sets.enmityspellssird)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Enmity Spells with SIRD]')
			end
		elseif Mode == 'Neutral' or ((Mode == 'Auto' or Mode == 'DPS') and player.in_combat == false) then --not in combat, no need for SIRD
			equip(sets.enmityspells)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Enmity Spells]')
			end
		end
	elseif string.find(spell.english,'Enlight') then
		if Mode == 'Combat' or ((Mode == 'Auto' or Mode == 'DPS') == 'Auto' and player.in_combat == true) and not buffactive['Aquaveil'] then -- in combat, no Aquaveil, so we need SIRD
			equip(sets.enlightsird)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Enlight Spells with SIRD]')
			end
		elseif Mode == 'Neutral' or ((Mode == 'Auto' or Mode == 'DPS') and player.in_combat == false) then --not in combat, no need for SIRD
			equip(sets.enlight)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Enlight]')
			end
		end
	elseif spell.english == 'Phalanx' then
		if Mode == 'Combat' or ((Mode == 'Auto' or Mode == 'DPS') and player.in_combat == true) and not buffactive['Aquaveil'] then -- in combat, no Aquaveil, so we need SIRD
			equip(sets.phalanxsird)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Phalanx with SIRD]')
			end
		elseif Mode == 'Neutral' or ((Mode == 'Auto' or Mode == 'DPS') and player.in_combat == false) then --not in combat, no need for SIRD
			equip(sets.phalanx)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Phalanx]')
			end
		end
	elseif spell.skill == "Enhancing Magic" then
		if Mode == 'Combat' or ((Mode == 'Auto' or Mode == 'DPS') and player.in_combat == true) and not buffactive['Aquaveil'] then -- in combat, no Aquaveil, so we need SIRD
			equip(sets.enhancingsird)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Enhancing with SIRD]')
			end
		elseif Mode == 'Neutral' or ((Mode == 'Auto' or Mode == 'DPS') and player.in_combat == false) then --not in combat, no need for SIRD
			equip(sets.enhancing)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Enhancing Magic]')
			end
		end
	elseif spell.type == 'Trust' then
		equip(sets.unity)
	end
end

-------------------------------------------
--              AFTERCAST                --
-------------------------------------------

function aftercast(spell)
	if spell.english == 'Invincible' and InvTimer == 'On' and not spell.interrupted then
		if player.equipment.legs == 'Valor Breeches +2' or player.equipment.legs == 'Caballarius Breeches' or player.equipment.legs == 'Caballarius Breeches +1' or player.equipment.legs == 'Caballarius Breeches +2' or player.equipment.legs == 'Caballarius Breeches +3' then --these pieces extend Invincible by 10 seconds so we adjust accordingly
			send_command('input /echo [Invincible] 40 seconds;wait 10;input /echo [Invincible] 30 seconds;wait 10;input /echo [Invincible] 20 seconds;wait 10;input /echo [Invincible] 10 seconds')
		else
			send_command('input /echo [Invincible] 30 seconds;wait 10;input /echo [Invincible] 20 seconds;wait 10;input /echo [Invincible] 10 seconds')
		end
	elseif spell.english == 'Intervene' and IntTimer == 'On' and not spell.interrupted then
		send_command('input /echo [Intervene] 30 seconds;wait 10;input /echo [Intervene] 20 seconds;wait 10;input /echo [Intervene] 10 seconds')
	elseif (string.find(spell.english,'Cur') and spell.type == "WhiteMagic" and spell.target.type == 'SELF') and UseMaxHP == 'On' then
		MaxHP = true
		if Debug == 'On' then
			windower.add_to_chat(8,'[MaxHP set to True]')
		end
	end
	--Put Defender up afterwards if we're doing active tank things:
	if AutoDefender == 'On' and (spell.english == 'Provoke' or spell.english == 'Holy Circle' or spell.english == 'Shield Bash' or spell.english == 'Sentinel' or spell.english == 'Rampart') and not buffactive['Defender'] and not buffactive['Amnesia'] and (Mode == 'Combat' or Mode == 'Auto') and player.sub_job == 'WAR' and player.sub_job_level ~= 0 and DefenderRecast == 0 then
		send_command('wait .5;input /ja Defender <me>')
	elseif (spell.english == 'Flash' or spell.english == 'Phalanx' or spell.english == 'Reprisal' or spell.english == 'Crusade') and not buffactive['Defender'] and AutoDefender == 'On' and not buffactive['Amnesia'] and (Mode == 'Combat' or Mode == 'Auto') and player.sub_job == 'WAR' and player.sub_job_level ~= 0 and DefenderRecast == 0 then
		send_command('wait 3;input /ja Defender <me>')
	end
	if AutoMajesty == 'On' and ((string.find(spell.english,'Cur') and spell.type == 'WhiteMagic') or string.find(spell.english,'Protect') or spell.english == 'Crusade' or spell.english == 'Phalanx' or spell.english == 'Cocoon' or spell.english == 'Defender' or spell.english == 'Reprisal' or spell.english == 'Palisade' or spell.english == 'Enlight') and MajestyTimer <= AutoMajWindow and not buffactive['Amnesia'] then
		send_command('wait 3; input /ja Majesty <me>')
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
--             SHOW/HIDE HUD             --
-------------------------------------------

windower.register_event('status change', function(status)
    if status == 4 and ShowHUD == true then --In a cutscene: Hide the HUD
		ShowHUD = false
		if Debug == 'On' then
			windower.add_to_chat(8,'[ShowHUD set to False]')
		end
		send_command('text bg1 hide;text bg2 hide;text bg3 hide;text phalanx hide;text crusade hide;text palisade hide;text reprisal hide;text defender hide;text cocoon hide;text enlight hide;text mode hide;text notifications hide;text debuffs hide;text weapons hide')
    elseif status ~= 4 and ShowHUD == false then --Out of cutscene: Show the HUD
		ShowHUD = true
		if Debug == 'On' then
			windower.add_to_chat(8,'[ShowHUD set to True]')
		end
		send_command('text bg1 show;text bg2 show;text bg3 show;text phalanx show;text crusade show;text palisade show;text reprisal show;text defender show;text cocoon show;text enlight show;text mode show;text notifications show;text debuffs show;text weapons show')
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
				windower.add_to_chat(8,'[Equipped Item: Vim Tourque]')
			end
		end
	elseif buff == 15 then --Doom
		DangerCountdown = DangerRepeat --Start the Danger Sound going
		if Debug == 'On' then
			windower.add_to_chat(8,'[DangerCountdown set to '..DangerRepeat..']')
		end
		if DoomAlert == 'On' then
			Doom = true --Setting "Doom" to true now, so that it can get set to false if we die, that way we don't announce that doom is off when we raise from the dead
			if Debug == 'On' then
				windower.add_to_chat(8,'[Doom set to True]')
			end
			send_command('input /p '..DoomOnText..'')
		end
		if AutoHWater == 'On' then
			HWaterRecast = 3 --Set the recast timer so we can start using the Holy Waters
			HWater = true
			if Debug == 'On' then
				windower.add_to_chat(8,'[HWaterRecast set to 3 | HWater set to True]')
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
				windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
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
				windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
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
				windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
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
				windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
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
				windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
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
				windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
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
				windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
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
				windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
			end
		end
	elseif buff == 2 or buff == 19 then --lose sleep, run choose_set since we had equipped the Vim Torque to wake us up
		choose_set()
	elseif buff == 15 then --Doom
		DangerCountdown = 0 --Set to 0 to turn the sound off when we are no longer Doomed
		if Debug == 'On' then
			windower.add_to_chat(8,'[DangerCountdown set to 0]')
		end
		if DoomAlert == 'On' and Doom == true then
			Doom = false --"Doom" gets set to false so that we don't announce that doom is off when we raise from the dead after dying to it.
			if Debug == 'On' then
				windower.add_to_chat(8,'[Doom set to False]')
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
				windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
			end
		end
	end
end)

-------------------------------------------
--              HEARTBEAT                --
-------------------------------------------

--Miscellaneous things we check for to keep them updated
windower.register_event('prerender', function()

	--Zoning check for HUD
	local pos = windower.ffxi.get_position()
	if pos == "(?-?)" and ShowHUD then
		windower.send_command('gs c HideHUD')
		ShowHUD = false
		if Debug == 'On' then
			windower.add_to_chat(8,'[ShowHUD set to False]')
		end
	elseif pos ~= "(?-?)" and not ShowHUD then
		windower.send_command('gs c ShowHUD')
		ShowHUD = true
		if Debug == 'On' then
			windower.add_to_chat(8,'[ShowHUD set to True]')
		end
	end

	--Aftermath checks
	if LoadHUD == true and NotiWeapons == 'On' then
	--if LoadHUD == true and not player.target.name == 'Pilgrim Moogle' then
		--windower.add_to_chat(8,'[TEST]')
		if player.equipment.main == 'Excalibur' then
			if buffactive['Aftermath'] then
				send_command('text weapons text "Aftermath (Regen/Refresh)";text weapons color '..Aftermath3color..'')
			elseif player.tp > 1000 then
				send_command('text weapons text "« '..EquipMain..''..EquipSub..' »";text weapons color '..Aftermath3color..'')
			else
				send_command('text weapons text "« '..EquipMain..''..EquipSub..' »";text weapons color 255 50 50')
			end
		elseif player.equipment.main == 'Almace' or player.equipment.main == 'Caladbolg' then
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
				send_command('text weapons text "« '..EquipMain..''..EquipSub..' »";text weapons color '..Aftermath3color..'')
			elseif player.tp < 3000 and player.tp >= 2000 then
				send_command('text weapons text "« '..EquipMain..''..EquipSub..' »";text weapons color '..Aftermath2color..'')
			elseif player.tp < 2000 and player.tp >= 1000 then
				send_command('text weapons text "« '..EquipMain..''..EquipSub..' »";text weapons color '..Aftermath1color..'')
			else
				send_command('text weapons text "« '..EquipMain..''..EquipSub..' »";text weapons color 255 50 50')
			end
		elseif player.equipment.main == 'Burtgang' then
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
				send_command('text weapons text "« '..EquipMain..''..EquipSub..' »";text weapons color '..Aftermath3color..'')
			elseif player.tp < 3000 and player.tp >= 2000 then
				send_command('text weapons text "« '..EquipMain..''..EquipSub..' »";text weapons color '..Aftermath2color..'')
			elseif player.tp < 2000 and player.tp >= 1000 then
				send_command('text weapons text "« '..EquipMain..''..EquipSub..' »";text weapons color '..Aftermath1color..'')
			else
				send_command('text weapons text "« '..EquipMain..''..EquipSub..' »";text weapons color 255 50 50')
			end
		elseif player.equipment.main == 'Sequence' then
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
				send_command('text weapons text "« '..EquipMain..''..EquipSub..' »";text weapons color '..Aftermath3color..'')
			elseif player.tp < 3000 and player.tp >= 2000 then
				send_command('text weapons text "« '..EquipMain..''..EquipSub..' »";text weapons color '..Aftermath2color..'')
			elseif player.tp < 2000 and player.tp >= 1000 then
				send_command('text weapons text "« '..EquipMain..''..EquipSub..' »";text weapons color '..Aftermath1color..'')
			else
				send_command('text weapons text "« '..EquipMain..''..EquipSub..' »";text weapons color 255 50 50')
			end
		else
			send_command('text weapons text "« '..EquipMain..''..EquipSub..' »";text weapons color 255 50 50')
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

	--Auto Mode Combat check
	if Mode == 'Auto' then
		if player.in_combat == true then
			if Combat == false then
				Combat = true
				choose_set()
				if Debug == 'On' then
					windower.add_to_chat(8,'[Combat set to True]')
				end
				if LoadHUD == true then
					send_command('text mode text "Mode: Auto (Combat)";text mode color '..Autocolor..'')
				end
			end
		elseif player.in_combat == false then
			if Combat == true then
				Combat = false
				choose_set()
				if Debug == 'On' then
					windower.add_to_chat(8,'[Combat set to False]')
				end
				if LoadHUD == true then
					send_command('text mode text "Mode: Auto (Neutral)";text mode color '..Autocolor..'')
				end
			end
		end
	end

	--MP checks
	if NotiLowMP =='On' and player.mpp <= 20 and NotiLowMPToggle == 'Off' then
		NotiLowMPToggle = 'On' --turn the toggle on so this can't be triggered again until its toggled off
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if LoadHUD == true then
			send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50;text notifications bg_transparency 1')
			NotiCountdown = NotiDelay
			if Debug == 'On' then
				windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
			end
		end
		send_command('wait 30;gs c NotiLowMPToggle') --wait 30 sec then turns the toggle back off
	end

	--HP checks
	if player.hp == 0 then --are we dead?
		if Alive == true then
			send_command('text notifications text "Status: Dead X_x";text notifications color 255 50 50;text notifications bg_transparency 1')
			NotiCountdown = -1
			if Debug == 'On' then
				windower.add_to_chat(8,'[NotiCountdown set to -1]')
			end
			Alive = false
			if Debug == 'On' then
				windower.add_to_chat(8,'[Alive set to False]')
			end
			Doom = false  --turn this off so it doesn't trigger the "doom is off" notification once we raise
			if Debug == 'On' then
				windower.add_to_chat(8,'[MaxHP set to False]')
			end
			if LowHP == true then
				LowHP = false
				if Debug == 'On' then
					windower.add_to_chat(8,'[LowHP set to False]')
				end
			end
		end
	else
		if Alive == false then
			send_command('text notifications text "Status: Alive ^_^";text notifications color 75 255 75;text notifications bg_transparency 1')
			NotiCountdown = -1
			if Debug == 'On' then
				windower.add_to_chat(8,'[NotiCountdown set to -1]')
			end
			send_command('wait 1;gs c AliveDelay') --we use a command to set this to true so that we can set a short delay to prevent things from triggering right when we raise
		end
		if player.hpp <= MaxHPThreshold and MaxHP == true and UseMaxHP == 'On' then --when HP% goes below a certain amount, turn off the MaxHP flag and equip the appropriate gear set
			MaxHP = false
			if Debug == 'On' then
				windower.add_to_chat(8,'[MaxHP set to False]')
			end
			choose_set()
		end
		if player.hp <= LowHPThreshold then --when HP goes below a certain amount, turn on the LowHP flag and equip the appropriate gear set
			if LowHP == false then
				LowHP = true
				if Debug == 'On' then
					windower.add_to_chat(8,'[LowHP set to True]')
				end
				DangerCountdown = DangerRepeat
				if Debug == 'On' then
					windower.add_to_chat(8,'[DangerCountdown set to '..DangerRepeat..']')
				end
				choose_set()
			end
		elseif player.hp > LowHPThreshold and LowHP == true then --when HP goes back above a certain amount, turn off the LowHP flag and equip the appropriate gear set
			send_command('gs c ClearNotifications')
			LowHP = false
			if Debug == 'On' then
				windower.add_to_chat(8,'[LowHP set to False]')
			end
			choose_set()
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
				windower.add_to_chat(8,'[AutoLockstyleRun set to False]')
			end
		end
		if AutoMajesty == 'On' and buffactive['Majesty'] then
			MajestyTimer = MajestyTimer - 1
		end
		if HWaterRecast == 3 then
			send_command('input /item "Holy Water" <me>')
			HWaterRecast = HWaterRecast - 1
		elseif HWaterRecast == 0 and HWater == true and buffactive['Doom'] then
			HWaterRecast = 3
			if Debug == 'On' then
				windower.add_to_chat(8,'[HWaterRecast set to 3]')
			end
		elseif HWater == true then
			HWaterRecast = HWaterRecast - 1
		end
		if AutoSentinel == 'On' and player.hp <= AutSntThreshold and Alive == true and not (buffactive['Weakness'] or buffactive['Amnesia'] or buffactive['Terror'] or buffactive['Petrification'] or buffactive['Sleep']) and windower.ffxi.get_ability_recasts()[75] == 0 and not TownZones:contains(world.area) then
			send_command('input /ja Sentinel <me>;wait .5;input /ja Sentinel <me>')
		end
		if player.equipment.main == nil or player.equipment.sub == nil then
			EquipMain = 'Weapons loading...'
			EquipSub = ''
		else
			EquipMain = player.equipment.main
			if player.equipment.sub == 'empty' then
				EquipSub = ''
			else
				EquipSub = ' & '..player.equipment.sub..''
			end
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
							windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
						end
					end
					RRRCountdown = RRReminderTimer --start the timer back up
					if Debug == 'On' then
						windower.add_to_chat(8,'[RRRCountdown set to '..RRReminderTimer..']')
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
					windower.add_to_chat(8,'[NotiCountdown set to -1]')
				end
			end
			if (NotiDoom == 'On' and buffactive['Doom']) or (NotiLowHP == 'On' and LowHP == true and Alive == true and not (buffactive['weakness'] or TownZones:contains(world.area))) and AlertSounds == 'On' and DangerCountdown > 0 then
				DangerCountdown = DangerCountdown - 1
				windower.play_sound(windower.addon_path..'data/sounds/Danger.wav')
			end
			if buffactive['Enmity Boost'] and buffactive['Phalanx'] and (buffactive['Reprisal'] or buffactive['Palisade']) and (buffactive['Defense Boost'] or buffactive['Defender']) and player.in_combat == true then
				send_command('text mode text "Mode: '..Mode..' (Turtle)"')
			else
				if Mode == 'Auto' then
					if player.in_combat == true then
						send_command('text mode text "Mode: '..Mode..' (Combat)"')
					else
						send_command('text mode text "Mode: '..Mode..' (Neutral)"')
					end
				else
					send_command('text mode text "Mode: '..Mode..'"')
				end
			end
			if NotiCountdown > 0 then
				NotiCountdown = NotiCountdown - 1
			elseif NotiCountdown == 0 then
				send_command('gs c ClearNotifications')
				NotiCountdown = -1
				if Debug == 'On' then
					windower.add_to_chat(8,'[NotiCountdown set to -1]')
				end
			end
			send_command('text crusade pos '..HUDposXColumn1..' '..HUDposYLine1..'')		--Crusade goes in Column 1
			send_command('text phalanx pos '..HUDposXColumn2..' '..HUDposYLine1..'')		--Phalanx goes in Column 2
			if player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
				send_command('text cocoon pos '..HUDposXColumn3..' -100')					--Cocoon is not visible
				send_command('text defender pos '..HUDposXColumn3..' '..HUDposYLine1..'')	--Defender goes in Column 3
				send_command('text reprisal pos '..HUDposXColumn4..' '..HUDposYLine1..'')	--Reprisal goes in Column 4
				send_command('text palisade pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Palisade goes in Column 5
				send_command('text enlight pos '..HUDposXColumn6..' '..HUDposYLine1..'')	--Enlight goes in Column 6
			elseif player.sub_job == 'BLU' and player.sub_job_level ~= 0 then
				send_command('text cocoon pos '..HUDposXColumn3..' '..HUDposYLine1..'')		--Cocoon goes in Column 1
				send_command('text defender pos '..HUDposXColumn3..' -100')					--Defender is not visible
				send_command('text reprisal pos '..HUDposXColumn4..' '..HUDposYLine1..'')	--Reprisal goes in Column 4
				send_command('text palisade pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Palisade goes in Column 5
				send_command('text enlight pos '..HUDposXColumn6..' '..HUDposYLine1..'')	--Enlight goes in Column 6
			else
				send_command('text cocoon pos '..HUDposXColumn3..' -100')					--Cocoon is not visible
				send_command('text defender pos '..HUDposXColumn3..' -100')					--Defender is not visible
				send_command('text reprisal pos '..HUDposXColumn3..' '..HUDposYLine1..'')	--Reprisal goes in Column 3
				send_command('text palisade pos '..HUDposXColumn4..' '..HUDposYLine1..'')	--Palisade goes in Column 4
				send_command('text enlight pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Enlight goes in Column 5
			end
			--Recast updates:
			if player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
				DefenderRecast = windower.ffxi.get_ability_recasts()[3]
			elseif player.sub_job == 'BLU' and player.sub_job_level ~= 0 then
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
			if player.sub_job == 'BLU' and player.sub_job_level ~= 0 then
				if buffactive['Defense Boost'] then CocoonColor = '75 255 75'
				elseif CocoonRecast > 0 then CocoonColor = '255 165 0'
				else CocoonColor = '255 50 50'
				end
			elseif player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
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
			if player.sub_job == 'BLU' and player.sub_job_level ~= 0 then
				send_command('text cocoon color '..CocoonColor..'')
			elseif player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
				send_command('text defender color '..DefenderColor..'')
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
		windower.add_to_chat(8,'[LockstyleDelay set to 3]')
	end
	if AutoLockstyle == 'On' then
		AutoLockstyleRun = true
		if Debug == 'On' then
			windower.add_to_chat(8,'[AutoLockstyleRune set to True]')
		end
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
			windower.add_to_chat(8,'[NotiCountdown set to 180]')
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
			windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
		end
	elseif org:find('Style lock mode enabled.') then
		LockstyleDelay = 5
		if Debug == 'On' then
			windower.add_to_chat(8,'[LockstyleDelay set to 5]')
		end
	elseif org:find('>> /item "Holy Water" <me>') then
		HWater = false
		if Debug == 'On' then
			windower.add_to_chat(8,'[HWater set to False]')
		end
		send_command('text notifications text "«« Out Of Holy Waters »»";text notifications color 255 50 50;text notifications bg_transparency 1')
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
	local spells = require('resources').spells
	local jobabilities = require('resources').job_abilities

	if NotiDamage == 'On' then
		--Weapon Skills and Skillchains:
		if act.category == 3 and act.actor_id == player.id then
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
				windower.add_to_chat(8,'[NotiCountdown set to -1]')
			end
		--Magic Bursts:
		elseif (act.targets[1].actions[1].message == 252 or act.targets[1].actions[1].message == 265 or act.targets[1].actions[1].message == 274 or act.targets[1].actions[1].message == 379 or act.targets[1].actions[1].message == 650 or act.targets[1].actions[1].message == 749 or act.targets[1].actions[1].message == 751 or act.targets[1].actions[1].message == 753 or act.targets[1].actions[1].message == 803) and act.actor_id == player.id then
			--Magic:
			if act.category == 4 then
				send_command('wait .2;text notifications text "Magic Burst! '..spells[act.param].english..': '..addCommas(act.targets[1].actions[1].param)..'";text notifications color 0 255 255;text notifications bg_transparency 1')
			--Lunges:
			elseif act.category == 15 then
				send_command('wait .2;text notifications text "Magic Burst! '..jobabilities[act.param].english..': '..addCommas(act.targets[1].actions[1].param)..'";text notifications color 0 255 255;text notifications bg_transparency 1')
			end
			NotiCountdown = -1
			if Debug == 'On' then
				windower.add_to_chat(8,'[NotiCountdown set to -1]')
			end
		end
	end
end)

-------------------------------------------
--             FILE UNLOAD               --
-------------------------------------------

function file_unload()
	send_command('wait 1;text bg1 delete;text bg2 delete;text bg3 delete;text phalanx delete;text crusade delete;text palisade delete;text reprisal delete;text defender delete;text cocoon delete;text enlight delete;text loading delete;text mode delete;text notifications delete;text debuffs delete;text weapons delete') --delete the different text objects
end

--[[

-------------------------------------------
--            KEYS NOTEPAD               --
-------------------------------------------

/BLU spells:

30 points: (sub job 50 or under)
Cocoon			-Cast for defense
Blank Gaze		-Cast for single target hate
Jettatura		-Cast for single target/narrow frontal cone hate
Sheep Song 		-Cast for AOE hate
Geist Wall		-Cast for AOE hate
Stinking Gas	-Cast for AOE hate
Soporific		-Cast for AOE hate
Wild Oats		-Beast Killer trait
Sprout Smack	-Beast Killer trait
Foot Kick		-Lizard Killer trait
Claw Cyclone	-Lizard Killer trait
Power Attack	-Plantoid Killer trait
Mandibular Bite	-Plantoid Killer trait

35 points: (sub job 51 or higher)
Feather Storm	-HP+5 trait
Helldive		-HP+5 trait

 --]]
