-------------------------------------------
-- Keys Gearswap lua file for Summoner   --
-------------------------------------------

-------------------------------------------
--                 NOTES                 --
-------------------------------------------
--[[
Place both this file and the sounds folder inside the GearSwap data folder
ex:	/addons/GearSwap/data/sounds/
	/addons/GearSwap/data/SMN.lua

To activate Damage Taken Override, use any of these three options:
1. A macro with the following
	/console DT
2. An alias command
	//dt
3. A keyboard shortcut
	CTRL+D
	(Default is D, can be changed in the settings)

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

AutoLockstyle	=	'On'	--[On/Off]		Automatically sets your lockstyle. Uses the Field and Town sets below.
LockstyleCombat =	'6'		--[1-20]		Your Lockstyle set when in a field zone.
LockstyleTown	=	'1'		--[1-20]		Your Lockstyle set when in a town zone.
							--				If you do not want a separate town lockstyle, set this to the same as LockstyleCombat.
Book			=	'4'		--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
Page			=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
AFTimer			=	'On'	--[On/Off]		Displays a timer for Astral Flow in echo.
ACTimer			=	'On'	--[On/Off]		Displays a timer for Astral Conduit in echo.
DTCtrlPlus		=	'd'		--				Sets the keyboard shortcut you would like to activate the Damage Taken Override.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions.
							--				(Town limits this to town gear only)
AlertSounds		=	'On'	--[On/Off]		Plays a sound on alerts. 
UseEcho			=	'R'		--[E/R/Off]		Automatically uses an Echo Drop (or Remedy) instead of spell when you are silenced.
AutoRelease		=	'On'	--[On/Off]		Automatically uses Release when you summon an avatar with one already out.

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
NotiTime			=	'Off'	--[On/Off]	Displays a notification for time remaining notices.
NotiOmen			=	'On'	--[On/Off]	Party chat notifications for Scale drops in Omen.
NotiVagary			=	'On'	--[On/Off]	Party chat notifications for Perfidien and Plouton popping, as well as weaknesses.

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


-------------------------------------------
--               GEAR SETS               --
-------------------------------------------

function get_sets()

	-- Idle (Movement Speed, Refresh, Regen, Damage Taken-, Enmity-)
	-- Used when you do NOT have an avatar out.
	sets.idle = {
		main="Malignance Pole",
		sub="Enki Strap",
		ammo="Staunch Tathlum",
		head="Beckoner's Horn +1",
		body="Amalric Doublet +1",
		hands="Asteria Mitts +1",
		legs="Assid. Pants +1",
		feet="Herald's Gaiters",
		neck="Twilight Torque",
		waist="Carrier's Sash",
		left_ear="Lugalbanda Earring",
		right_ear="Ethereal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Magic Damage+10','"Fast Cast"+10','Mag. Evasion+15',}},
    }

	-- Avatar (Avatar Perpetuation-, Refresh, Avatar's Favor+, etc.)
	-- Used when you DO have an avatar out.
	-- Combines with Idle set, only necessary to set the slots with specific desired stats
	sets.avatar = set_combine(sets.idle, {
		main="Gridarvor",
		sub="Vox Grip",
		ammo="Sancus Sachet",
		head="Beckoner's Horn +1",
		body="Beck. Doublet +1",
		hands="Lamassu Mitts +1",
		legs="Assid. Pants +1",
		feet="Herald's Gaiters",
		neck="Caller's Pendant",
		waist="Incarnation Sash",
		left_ear="Lugalbanda Earring",
		right_ear="Evans Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: Haste+10','Pet: "Regen"+5',}},
	})

	-- DT Override (Damage Taken-, Magic Evasion)
	-- Will override all other gear sets but still inherit unused slots from them
	sets.dtoverride = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		right_ring="Defending Ring",
	}

	-- DPS (Accuracy, Double/Triple Attack, DEX, Store TP, Attack, Refresh, Regain, Regen)
	sets.dps = {

	}

	-- Rest
	sets.rest = {
		waist="Austerity Belt",
	}

	-- Weapon Skill (STR, Weapon Skill Damage, Attack, Double/Triple Attack)
	sets.ws = {

	}

	-- Fast Cast (cap is 80%) (precast for casting summons)
	sets.fastcast = {
		head="Amalric Coif +1", --11%
		body="Amalric Doublet +1", --4% (from augment)
	    hands="Amalric Gages +1", --SIRD 11%
		legs="Enticer's Pants",
		feet="Amalric Nails +1", --6%
		neck="Baetyl Pendant", --4%
		waist="Witful Belt", --3%
		left_ear="Malignance Earring", --4%
		right_ear="Loquac. Earring", --2%
		left_ring="Prolix Ring", --2%
		right_ring="Kishar Ring", --4%
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Magic Damage+10','"Fast Cast"+10','Mag. Evasion+15',}},
	}

	-- Blood Pact Delay (BP Ability Delay-, SMN Skill+) (BP precast)
	sets.bpdelay = {
		main="Espiritus",
		sub="Vox Grip",
		ammo="Sancus Sachet",
		head="Beckoner's Horn +1",
		body="Con. Doublet +3",
		hands="Lamassu Mitts +1",
		neck="Melic Torque",
		left_ear="Andoaa Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Conveyance Cape",
	}

	-- Blood Pact: Rage Physical (BP Damage+, Pet: Att+) (BP midcast)
	sets.bpragephysical = {
		main="Gridarvor",
		sub="Elan Strap",
		ammo="Sancus Sachet",
		head={ name="Merlinic Hood", augments={'Blood Pact Dmg.+10','Pet: DEX+3',}},
		body="Con. Doublet +3",
		hands={ name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+22','Blood Pact Dmg.+10','Pet: STR+8','Pet: Mag. Acc.+15',}},
		legs={ name="Enticer's Pants", augments={'MP+30','Pet: Mag. Acc.+12','Pet: Damage taken -1%',}},
		feet={ name="Merlinic Crackows", augments={'Pet: "Mag.Atk.Bns."+5','Blood Pact Dmg.+10','Pet: AGI+1',}},
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Lugalbanda Earring",
		right_ear="Gelos Earring",
		left_ring="Varar Ring",
		right_ring="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: Haste+10','Pet: "Regen"+5',}},
	}

	-- Blood Pact: Rage Magical (BP Damage+, Pet: MAB+) (BP midcast)
	sets.bpragemagical = {
		main="Grioavolr",
		sub="Elan Strap",
		ammo="Sancus Sachet",
		head={ name="Merlinic Hood", augments={'Blood Pact Dmg.+10','Pet: DEX+3',}},
		body="Con. Doublet +3",
		hands={ name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+22','Blood Pact Dmg.+10','Pet: STR+8','Pet: Mag. Acc.+15',}},
		legs={ name="Enticer's Pants", augments={'MP+30','Pet: Mag. Acc.+12','Pet: Damage taken -1%',}},
		feet={ name="Merlinic Crackows", augments={'Pet: "Mag.Atk.Bns."+5','Blood Pact Dmg.+10','Pet: AGI+1',}},
		neck="Melic Torque",
		waist="Incarnation Sash",
		left_ear="Lugalbanda Earring",
		right_ear="Gelos Earring",
		left_ring="Varar Ring",
		right_ring="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Magic Damage+10','"Fast Cast"+10','Mag. Evasion+15',}},
	}

	-- Blood Pact: Rage Hybrid (BP Damage+, Pet: MAB+, Pet: Att+) (BP midcast)
	sets.bpragehybrid = {
		main="Grioavolr",
		sub="Elan Strap",
		ammo="Sancus Sachet",
		head={ name="Merlinic Hood", augments={'Blood Pact Dmg.+10','Pet: DEX+3',}},
		body="Con. Doublet +3",
		hands={ name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+22','Blood Pact Dmg.+10','Pet: STR+8','Pet: Mag. Acc.+15',}},
		legs={ name="Enticer's Pants", augments={'MP+30','Pet: Mag. Acc.+12','Pet: Damage taken -1%',}},
		feet={ name="Merlinic Crackows", augments={'Pet: "Mag.Atk.Bns."+5','Blood Pact Dmg.+10','Pet: AGI+1',}},
		neck="Melic Torque",
		waist="Incarnation Sash",
		left_ear="Lugalbanda Earring",
		right_ear="Gelos Earring",
		left_ring="Varar Ring",
		right_ring="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Magic Damage+10','"Fast Cast"+10','Mag. Evasion+15',}},
	}

	-- Blood Pact: Ward Buff (SMN skill) (BP midcast)
	sets.bpwardbuff = {
		main="Grioavolr",
		main="Espiritus",
		sub="Vox Grip",
		ammo="Sancus Sachet",
		head="Beckoner's Horn +1",
		body="Beck. Doublet +1",
		hands="Lamassu Mitts +1",
		neck="Melic Torque",
		left_ear="Andoaa Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: Haste+10','Pet: "Regen"+5',}},
	}

	-- Blood Pact: Ward Debuff (SMN skill, Pet MAcc) (BP midcast)
	sets.bpwarddebuff = {
		main="Grioavolr",
		sub="Vox Grip",
		ammo="Sancus Sachet",
		head="Beckoner's Horn +1",
		body="Beck. Doublet +1",
		hands="Lamassu Mitts +1",
		neck="Adad Amulet",
		waist="Incarnation Sash",
		left_ear="Andoaa Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Magic Damage+10','"Fast Cast"+10','Mag. Evasion+15',}},
	}

	-- Elemental Spells (Magic Attack Bonus, Magic Damage, INT, Magic Accuracy)
	sets.elemental = {
		body="Cohort Cloak +1",
		hands="Amalric Gages +1",
		legs="Amalric Slops +1",
		feet="Amalric Nails +1",
		neck="Baetyl Pendant",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Halasz Earring",
		left_ring="Shiva Ring +1",
		right_ring="Metamor. Ring +1",
		back="Aurist's Cape +1",
	}

	-- Buff (Conserve MP)
	sets.buff = {
		head="Vanya Hood",
		body="Amalric Doublet +1",
		hands="Shrieker's Cuffs",
		legs="Vanya Slops",
		feet="Amalric Nails +1",
		neck="Reti Pendant",
		waist="Austerity Belt",
		left_ear="Calamitous Earring",
		right_ear="Mendi. Earring",
		back="Solemnity Cape",
	}

	-- Cursna (Cursna, Healing Magic)
	sets.cursna = {
		head="Vanya Hood",
		body="Vanya Robe",
		hands="Vanya Cuffs",
		legs="Vanya Slops",
		feet="Vanya Clogs",
		neck="Nicander's Necklace",
		ring1="Haoma's Ring",
		ring2="Haoma's Ring",
	}

	-- Holy Water (Holy Water+)
	sets.hwater = {
		neck="Nicander's Necklace",
		ring1="Blenmot's Ring +1",
		ring2="Blenmot's Ring +1",
	}

	-- Refresh (Refresh augmenting gear, not Refresh+)
	sets.refresh = {
		head="Amalric Coif +1",
		back="Grapevine Cape",
	}

	-- Cursna (Cursna, Healing Magic)
	sets.cursna = {
		head="Vanya Hood", --10
		body="Vanya Robe",
		hands="Vanya Cuffs",
		legs="Vanya Slops",
		feet="Vanya Clogs", --5
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
	}

	-- Astral Flow (Enhances Astral Flow gear)
	sets.astralflow = {

	}

	-- Elemental Siphon (Enhances Elemental Siphon gear)
	sets.elementalsiphon = {
		back="Conveyance Cape",
	}

	-- Mana Cede (Enhances Mana Cede gear)
	sets.manacede = {

	}

	-- Default Town Gear (Put all your fancy-pants gear in here you want to showboat around town. Does not lockstyle this gear, only equips)
	sets.town = set_combine(sets.idle, {
		main="Gridarvor",
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
TopVersion = 'Earthen Fury' --Leave this alone, used for debugging purposes



	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX          DO NOT EDIT BELOW THIS LINE          XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--



BottomVersion = 'Earthen Fury'
FileVersion = '08.13.22'

-------------------------------------------
--               UPDATES                 --
-------------------------------------------

--[[
If the new updates Version Compatibility Codename matches your current files TopVersion,
simply replace everything under the "Do Not Edit Below This Line".
Only when the Version Compatibility Codename changes will you need to update the entire file.

08.13.22 (Version Compatibility Codename: Earthen Fury)
-Added Leafallia to list of towns.
-Added cancelling Stonekin if its up and we get slept with poison on.
-Split the Cursna set into Cursna and Holy Water.
-Adjusted abilities to not equip their gear sets if they are still on cooldown.
-Renamed LockstyleField to LockstyleCombat. Just makes more sense.
-Fixed an issue where the debuff background color change from Doom (flashing white and yellow) would get stuck on yellow after Doom wears off and you have another debuff on that takes over in the debuff spot.
-Updated Version Compatibility Codename to Earthen Fury.

07.18.22 (Version Compatibility Codename: Inferno)
-Overhauled how area checks are handled. Uses tables now for groups of areas.
-Fixed some errors that would show up on job change. These were caused by the Heartbeat function constantly checking for any debuffs present; when you unload the file (change job) it will delete the debuff text objects used for the HUD which will cause a split second where the debuff check freaks out. The fix was to simply disable the debuff checks in town zones.
-Fixed an issue with the Sleep debuff not showing properly in the HUD.
-Removed a rule for losing Indicolure leftover from converting from the GEO file.
-Code cleanup

06.14.22 (Version Compatibility Codename: Inferno)
-First version
-Started from Geomancer file version 06.14.21
--]]

-------------------------------------------
--            SPELL MAPPING              --
-------------------------------------------

Avatars = S{
	'Carbuncle','Cait Sith','Ifrit','Shiva','Garuda','Titan','Ramuh','Leviathan','Fenrir','Diabolos','Siren','Atomos','Alexander','Odin'
    }

Spirits = S{
	'Light Spirit','Fire Spirit','Ice Spirit','Air Spirit','Earth Spirit','Thunder Spirit','Water Spirit','Dark Spirit'
    }

--Blood Pacts
BPRagePhysical = S{
	'Punch','Rock Throw','Barracuda Dive','Claw','Welt','Axe Kick','Shock Strike','Camisado','Regal Scratch','Poison Nails','Moonlit Charge','Crescent Fang','Rock Buster','Roundhouse','Tail Whip','Double Punch','Megalith Throw','Double Slap','Eclipse Bite','Mountain Buster','Spinning Dive','Predator Claws','Rush','Chaotic Strike','Volt Strike','Hysteric Assault','Crag Throw','Blindside','Regal Gash'
    }

BPRageMagical = S{
	'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Clarsach Call','Diamond Dust','Judgment Bolt','Searing Light','Howling Moon','Ruinous Omen','Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II','Thunderspark','Meteorite','Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV','Sonic Buffet','Nether Blast','Zantetsuken','Meteor Strike','Geocrush','Grand Fall','Wind Blade','Tornado II','Heavenly Strike','Thunderstorm','Level ? Holy','Holy Mist','Lunar Bay','Night Terror','Conflag Strike','Impact'
	}

BPRageHybrid = S{
	'Burning Strike','Flaming Crush'
    }

BPWardBuff = S{
	'Altana\'s Favor','Healing Ruby','Raise II','Shining Ruby','Aerial Armor','Frost Armor','Reraise II','Rolling Thunder','Katabatic Blades','Whispering Wind','Crimson Howl','Lightning Armor','Chinook','Ecliptic Growl','Glittering Ruby','Earthen Ward','Spring Water','Hastega','Noctoshield','Ecliptic Howl','Dream Shroud','Healing Ruby II','Perfect Defense','Earthen Armor','Fleet Wind','Inferno Howl','Wind\'s Blessing','Soothing Ruby','Heavenward Howl','Pacifying Ruby','Hastega II','Soothing Current','Crystal Blessing'
    }

BPWardDebuff = S{
	'Lunatic Voice','Somnolence','Lunar Cry','Mewing Lullaby','Nightmare','Lunar Roar','Slowga','Ultimate Terror','Sleepga','Bitter Elegy','Eerie Eye','Tidal Roar','Diamond Storm','Shock Squall','Pavor Nocturnus'
    }

-------------------------------------------
--             AREA MAPPING              --
-------------------------------------------

AdoulinZones = S{
	'Western Adoulin','Eastern Adoulin','Celennia Memorial Library'
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
	'Western Adoulin','Eastern Adoulin','Celennia Memorial Library','Bastok Markets','Bastok Mines','Metalworks','Port Bastok','Chateau d\'Oraguille','Northern San d\'Oria','Port San d\'Oria','Southern San d\'Oria','Heavens Tower','Port Windurst','Windurst Walls','Windurst Waters','Windurst Woods','Lower Jeuno','Port Jeuno','Ru\'Lude Gardens','Upper Jeuno','Aht Urhgan Whitegate','The Colosseum','Tavnazian Safehold','Southern San d\'Oria [S]','Bastok Markets [S]','Windurst Waters [S]','Mhaura','Selbina','Rabao','Kazham','Norg','Nashmau','Mog Garden','Leafallia'
    }

-------------------------------------------
--              FILE LOAD                --
-------------------------------------------

NotiLowMPToggle = 'Off' --start with the toggle off for the Low MP Notification so that it can trigger
DTOverride = "Off" --Start with the Damage Taken Override off
RRRCountdown = ReraiseReminderTimer
Heartbeat = 0 --set to 0 just to start the Heartbeat running
LoadDelay = 3 --delays loading the HUD, this makes sure all the variables get set correctly before being used, displays file version info, and waits to use lockstyle
LoadHUD = false --starts false then switched to true after the LoadDelay
ShowHUD = true --this changes to false when we are in a cutscene
--set the initial recasts to 0, they will get updated in the Heartbeat function:
FavorRecast = 0
SiphonRecast = 0
ApogeeRecast = 0
CedeRecast = 0
ConvertRecast = 0
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
	--Create all the HUD Background text objects and put them above the screen for now, we'll move them to the correct place next
	send_command('text bg1 create "                                                                                                                          ";wait .3;text bg1 size '..FontSize..';text bg1 pos '..HUDposXColumn1..' '..HUDposYLine1..';text bg1 bg_transparency '..HUDBGTrans..'')--Background Line 1
	send_command('text bg2 create "                                                                                                                          ";wait .3;text bg2 size '..FontSize..';text bg2 pos '..HUDposXColumn1..' -100;text bg2 bg_transparency '..HUDBGTrans..'')--Background Line 2
	send_command('text bg3 create "                                                                                                                          ";wait .3;text bg3 size '..FontSize..';text bg3 pos '..HUDposXColumn1..' -100;text bg3 bg_transparency '..HUDBGTrans..'')--Background Line 3
	send_command('text loading create "Loading Keys SUMMONER file ver: '..FileVersion..'...";wait .3;text loading size '..FontSize..';text loading pos '..HUDposXColumn1..' '..HUDposYLine1..';text loading bg_transparency 1') --Loading
	send_command('wait '..LoadDelay..';gs c LoadHUD')
	--Create the Aftermath, Avatar, Notifications and Debuffs text objects and put them above the screen for now, we'll move them to the correct place next
	send_command('wait .1;text aftermath create "Aftermath: None";wait .3;text aftermath size '..FontSize..';text aftermath pos '..HUDposXColumn4..' -100;text aftermath color 255 50 50;text aftermath bg_transparency 1') --Aftermath
	send_command('wait .1;text notifications create "Hello, '..player.name..'! (type //fileinfo for more information)";wait .3;text notifications size '..FontSize..';text notifications pos '..HUDposXColumn1..' -100;text notifications bg_transparency 1') --Notifications
	send_command('wait .1;text debuffs create " ";wait .3;text debuffs size '..FontSize..';text debuffs pos '..HUDposXColumn4..' -100;text debuffs bg_transparency 1') --Debuffs
	send_command('wait .1;text avatar create "No Avatar";wait .3;text avatar size '..FontSize..';text avatar pos '..HUDposXColumn1..' -100;text avatar color 255 255 255;text avatar bg_transparency 1') --Avatar
	--Create all the HUD Recast text objects and put them above the screen for now, we'll move them to the correct place next
	send_command('wait .2;text favor create "[ A. Favor ]";wait .3;text favor size '..FontSize..';text favor pos '..HUDposXColumn1..' -100;text favor bg_transparency 1')
	send_command('wait .2;text siphon create "[ E. Siphon ]";wait .3;text siphon size '..FontSize..';text siphon pos '..HUDposXColumn1..' -100;text siphon bg_transparency 1')
	send_command('wait .2;text apogee create "[ Apogee ]";wait .3;text apogee size '..FontSize..';text apogee pos '..HUDposXColumn1..' -100;text apogee bg_transparency 1')
	send_command('wait .2;text cede create "[ M. Cede ]";wait .3;text cede size '..FontSize..';text cede pos '..HUDposXColumn1..' -100;text cede bg_transparency 1')
	send_command('wait .2;text convert create "[ Convert ]";wait .3;text convert size '..FontSize..';text convert pos '..HUDposXColumn1..' -100;text convert bg_transparency 1')
else
	windower.add_to_chat(8,'Keys SUMMONER file ver: '..FileVersion..'')
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
send_command('bind ^'..DTCtrlPlus..' gs c DT') --creates the DT Override keyboard shortcut
send_command('alias dt gs c DT') --creates the DT Override and alias
if Debug == 'On' then
	windower.add_to_chat(8,'[Debug Mode: On]')
	send_command('gs showswaps')
end
LockstyleDelay = 3
AutoLockstyleRun = true

-------------------------------------------
--            SELF COMMANDS              --
-------------------------------------------

function self_command(command)
	if command == 'DT' then
		if DTOverride == 'Off' then
			DTOverride = 'On'
		elseif DTOverride == 'On' then
			DTOverride = 'Off'
		end
		choose_set()
	elseif command == 'TPReturn' then
		if HUD == 'On' then
			send_command('text notifications text "TP Return: '..player.tp..'";text notifications color 0 255 255')
		else
			windower.add_to_chat(8,'TP Return: '..player.tp..'')
		end
	elseif command == 'ClearNotifications' then --these reset the Notifications display back to a basic state
		if HUD == 'On' then
			if buffactive['weakness'] and DTOverride == 'On' then
				send_command('text notifications text "Status: Weak (DT Override)";text notifications color 205 133 63')
			elseif buffactive['weakness'] then
				send_command('text notifications text "Status: Weak";text notifications color 205 133 63')
			elseif player.mpp <= 20 then
					send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50')
			elseif player.status == "Engaged" then
				send_command('text notifications text "Status: Engaged";text notifications color 255 255 255')
			elseif player.status == "Idle" and DTOverride == "On" then
				send_command('text notifications text "Status: Idle (DT Override)";text notifications color 255 255 255')
			elseif player.status == "Idle" then
				send_command('text notifications text "Status: Idle";text notifications color 255 255 255')
			end
		end
	elseif command == 'ClearDebuffs' then --these reset the Debuffs display back to a basic state
		send_command('text debuffs text "";text debuffs color 255 255 255;text debuffs bg_transparency 1')
	elseif command == 'LoadHUD' then
		LoadHUD = true
		send_command('text loading hide')
		if HUDRecast == 'On' then --using the HUDRecast
			if player.equipment.main == 'Claustrum' or player.equipment.main == 'Hvergelmir' or player.equipment.main == 'Khatvanga' or player.equipment.main == 'Nirvana'  then
				send_command('wait .1;text bg2 pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .2;text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')
				send_command('wait .7;text favor pos '..HUDposXColumn1..' '..HUDposYLine1..'')
				send_command('wait .7;text siphon pos '..HUDposXColumn2..' '..HUDposYLine1..'')
				send_command('wait .7;text apogee pos '..HUDposXColumn3..' '..HUDposYLine1..'')
				send_command('wait .7;text cede pos '..HUDposXColumn4..' '..HUDposYLine1..'')
				send_command('wait .7;text convert pos '..HUDposXColumn5..' '..HUDposYLine1..'')
				send_command('wait .8;text avatar pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .8;text aftermath pos '..HUDposXColumn4..' '..HUDposYLine2..'')
				send_command('wait .9;text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')
				send_command('wait .9;text debuffs pos '..HUDposXColumn4..' '..HUDposYLine3..'')
			else
				send_command('wait .1;text bg2 pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .2;text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')
				send_command('wait .7;text favor pos '..HUDposXColumn1..' '..HUDposYLine1..'')
				send_command('wait .7;text siphon pos '..HUDposXColumn2..' '..HUDposYLine1..'')
				send_command('wait .7;text apogee pos '..HUDposXColumn3..' '..HUDposYLine1..'')
				send_command('wait .7;text cede pos '..HUDposXColumn4..' '..HUDposYLine1..'')
				if player.sub_job == 'RDM' and player.sub_job_level >= 1 then
					send_command('wait .7;text convert pos '..HUDposXColumn5..' '..HUDposYLine1..'')
				end
				send_command('wait .8;text avatar pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .9;text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')
				send_command('wait .9;text debuffs pos '..HUDposXColumn4..' '..HUDposYLine3..'')
			end
		else --not using the HUDRecast
			if player.equipment.main == 'Claustrum' or player.equipment.main == 'Hvergelmir' or player.equipment.main == 'Khatvanga' or player.equipment.main == 'Nirvana'  then
				send_command('wait .1;text bg2 pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .6;text avatar pos '..HUDposXColumn1..' '..HUDposYLine1..'')
				send_command('wait .6;text aftermath pos '..HUDposXColumn4..' '..HUDposYLine1..'')
				send_command('wait .7;text notifications pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .7;text debuffs pos '..HUDposXColumn4..' '..HUDposYLine2..'')
			else
				send_command('wait .1;text bg2 pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .6;text avatar pos '..HUDposXColumn1..' '..HUDposYLine1..'')
				send_command('wait .7;text notifications pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .7;text debuffs pos '..HUDposXColumn4..' '..HUDposYLine2..'')
			end
		end
	elseif command == 'Fileinfo' then
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(3,'-- Keys Gearswap lua file for Summoner  --')
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(200,'File Version Number '..FileVersion..'')
		windower.add_to_chat(200,'Top Version: '..TopVersion..' ')
		windower.add_to_chat(200,'Bottom Version: '..BottomVersion..' ')
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
		windower.add_to_chat(200,'        /addons/GearSwap/data/SMN.lua')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'To activate Damage Taken Override, use any of these')
		windower.add_to_chat(8,'three options:')
		windower.add_to_chat(8,'1. A macro with the following')
		windower.add_to_chat(200,'        /console DT')
		windower.add_to_chat(8,'2. An alias command')
		windower.add_to_chat(200,'        //dt')
		windower.add_to_chat(8,'3. A keyboard shortcut')
		windower.add_to_chat(200,'        CTRL+D')
		windower.add_to_chat(8,'        (Default is D, can be changed in the settings)')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'Run the Lockstyle function yourself at any time by typing')
		windower.add_to_chat(200,'        //lockstyle or //lstyle')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'For the HUD function (see options below), suggested')
		windower.add_to_chat(8,'placement is center screen, just above your chat log.')
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
		windower.add_to_chat(200,'LockstyleCombat: '..(''..LockstyleCombat..''):color(8)..'')
		windower.add_to_chat(200,'LockstyleTown: '..(''..LockstyleTown..''):color(8)..'')
		windower.add_to_chat(200,'Book: '..(''..Book..''):color(8)..'')
		windower.add_to_chat(200,'Page: '..(''..Page..''):color(8)..'')
		windower.add_to_chat(200,'Chat: '..(''..Chat..''):color(8)..'')
		windower.add_to_chat(200,'AFTimer: '..(''..AFTimer..''):color(8)..'')
		windower.add_to_chat(200,'ACTimer: '..(''..ACTimer..''):color(8)..'')
		windower.add_to_chat(200,'DTCtrlPlus: '..(''..DTCtrlPlus..''):color(8)..'')
		windower.add_to_chat(200,'ZoneGear: '..(''..ZoneGear..''):color(8)..'')
		windower.add_to_chat(200,'AlertSounds: '..(''..AlertSounds..''):color(8)..'')
		windower.add_to_chat(200,'UseEcho: '..(''..UseEcho..''):color(8)..'')
		windower.add_to_chat(200,'AutoRelease: '..(''..AutoRelease..''):color(8)..'')
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
		windower.add_to_chat(200,' ')
		windower.add_to_chat(3,'Options can be changed in the file itself.')
	elseif command == 'Zone Gear' then
		if ZoneGear == 'Town' then
			if TownZones:contains(world.area) then
			-- if world.area == "Western Adoulin" or world.area == "Eastern Adoulin" or world.area == "Celennia Memorial Library" or world.area == "Bastok Markets" or world.area == "Bastok Mines" or world.area == "Metalworks" or world.area == "Port Bastok" or world.area == "Chateau d'Oraguille" or world.area == "Northern San d'Oria" or world.area == "Port San d'Oria" or world.area == "Southern San d'Oria" or world.area == "Heavens Tower" or world.area == "Port Windurst" or world.area == "Windurst Walls" or world.area == "Windurst Waters" or world.area == "Windurst Woods" or world.area == "Lower Jeuno" or world.area == "Port Jeuno" or world.area == "Ru'Lude Gardens" or world.area == "Upper Jeuno" or world.area == "Aht Urhgan Whitegate" or world.area == "The Colosseum" or world.area == "Tavnazian Safehold" or world.area == "Southern San d'Oria [S]" or world.area == "Bastok Markets [S]" or world.area == "Windurst Waters [S]" or world.area == "Mhaura" or world.area == "Selbina" or world.area == "Rabao" or world.area == "Kazham" or world.area == "Norg" or world.area == "Nashmau" or world.area == "Mog Garden" then
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
		-- if world.area == "Western Adoulin" or world.area == "Eastern Adoulin" or world.area == "Celennia Memorial Library" or world.area == "Bastok Markets" or world.area == "Bastok Mines" or world.area == "Metalworks" or world.area == "Port Bastok" or world.area == "Chateau d'Oraguille" or world.area == "Northern San d'Oria" or world.area == "Port San d'Oria" or world.area == "Southern San d'Oria" or world.area == "Heavens Tower" or world.area == "Port Windurst" or world.area == "Windurst Walls" or world.area == "Windurst Waters" or world.area == "Windurst Woods" or world.area == "Lower Jeuno" or world.area == "Port Jeuno" or world.area == "Ru'Lude Gardens" or world.area == "Upper Jeuno" or world.area == "Aht Urhgan Whitegate" or world.area == "The Colosseum" or world.area == "Tavnazian Safehold" or world.area == "Southern San d'Oria [S]" or world.area == "Bastok Markets [S]" or world.area == "Windurst Waters [S]" or world.area == "Mhaura" or world.area == "Selbina" or world.area == "Rabao" or world.area == "Kazham" or world.area == "Norg" or world.area == "Nashmau" or world.area == "Mog Garden" then
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
		if HUD == 'On' then
			send_command('text notifications text "«« Radialens Has Worn Off »»";text notifications color 255 50 50')
		end
	elseif command == 'NotiLowMPToggle' then
		NotiLowMPToggle = 'Off'
	end
end

-------------------------------------------
--              CHOOSE SET               --
-------------------------------------------

function choose_set()
	if buffactive['Astral Conduit'] then
		if pet.isvalid and pet.name == 'Ifrit' then
			equip(sets.bpragehybrid)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: BP Hybrid]')
			end
		else
			equip(sets.bpragephysical)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: BP Physical]')
			end
		end
	elseif player.status == "Resting" then
		if HUD == 'On' then
			if buffactive['weakness'] and DTOverride == 'On' then
				send_command('text notifications text "Status: Weak (DT Override)";text notifications color 205 133 63')
			elseif buffactive['weakness'] then
				send_command('text notifications text "Status: Weak";text notifications color 205 133 63')
			elseif player.mpp <= 20 then
				send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50')
			elseif DTOverride == 'On' then
				send_command('text notifications text "Status: Resting (DT Override)";text notifications color 255 255 255')
			else
				send_command('text notifications text "Status: Resting";text notifications color 255 255 255')
			end
		end
		equip(sets.rest)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Rest]')
		end
	elseif player.status == "Engaged" then
		if DTOverride == 'On' then
			equip(set_combine(sets.dps, sets.dtoverride))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: DPS + DT Override]')
			end
			if HUD == 'On' then
				if buffactive['weakness'] then
					send_command('text notifications text "Status: Weak (DT Override)";text notifications color 205 133 63')
								elseif player.mpp <= 20 then
					send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50')
				else
					send_command('text notifications text "Status: Engaged (DT Override)";text notifications color 255 255 255')
				end
			end
		else
			equip(sets.dps)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: DPS]')
			end
			if HUD == 'On' then
				if buffactive['weakness'] then
					send_command('text notifications text "Status: Weak";text notifications color 205 133 63')
				elseif player.mpp <= 20 and HUD == 'On' then
					send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50')
				elseif HUD == 'On' then
					send_command('text notifications text "Status: Engaged";text notifications color 255 255 255')
				end
			end
		end
	elseif player.status == "Idle" then
		if HUD == 'On' then
			if buffactive['weakness'] and DTOverride == 'On' then
				send_command('text notifications text "Status: Weak (DT Override)";text notifications color 205 133 63')
			elseif buffactive['weakness'] then
				send_command('text notifications text "Status: Weak";text notifications color 205 133 63')
			elseif player.mpp <= 20 then
				send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50')
			elseif DTOverride == 'On' then
				send_command('text notifications text "Status: Idle (DT Override)";text notifications color 255 255 255')
			else
				send_command('text notifications text "Status: Idle";text notifications color 255 255 255')
			end
		end
		if AdoulinZones:contains(world.area) then
		-- if world.area == "Western Adoulin" or world.area == "Eastern Adoulin" or world.area == "Celennia Memorial Library" then
			equip(set_combine(sets.idle, sets.adoulin))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Idle + Adoulin]')
			end
		elseif BastokZones:contains(world.area) then
		-- elseif world.area == "Bastok Markets" or world.area == "Bastok Mines" or world.area == "Metalworks" or world.area == "Port Bastok" then
			equip(set_combine(sets.idle, sets.bastok))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Idle + Bastok]')
			end
		elseif SandyZones:contains(world.area) then
		-- elseif world.area == "Chateau d'Oraguille" or world.area == "Northern San d'Oria" or world.area == "Port San d'Oria" or world.area == "Southern San d'Oria" then
			equip(set_combine(sets.idle, sets.sandoria))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Idle + San d\'Oria]')
			end
		elseif WindyZones:contains(world.area) then
		-- elseif world.area == "Heavens Tower" or world.area == "Port Windurst" or world.area == "Windurst Walls" or world.area == "Windurst Waters" or world.area == "Windurst Woods" then
			equip(set_combine(sets.idle, sets.windurst))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Idle + Windurst]')
			end
		elseif TownZones:contains(world.area) then
		-- elseif world.area == "Lower Jeuno" or world.area == "Port Jeuno" or world.area == "Ru'Lude Gardens" or world.area == "Upper Jeuno" or world.area == "Aht Urhgan Whitegate" or world.area == "The Colosseum" or world.area == "Tavnazian Safehold" or world.area == "Southern San d'Oria [S]" or world.area == "Bastok Markets [S]" or world.area == "Windurst Waters [S]" or world.area == "Mhaura" or world.area == "Selbina" or world.area == "Rabao" or world.area == "Kazham" or world.area == "Norg" or world.area == "Nashmau" or world.area == "Mog Garden" then
			equip(set_combine(sets.idle, sets.town))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Idle + Town]')
			end
		elseif pet.isvalid == true then
			if DTOverride == "On" then
				equip(set_combine(sets.avatar, sets.dtoverride))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Avatar + DT Override]')
				end
			else
				equip(sets.avatar)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Avatar]')
				end
			end
		else
			if DTOverride == "On" then
				equip(set_combine(sets.idle, sets.dtoverride))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Idle + DT Override]')
				end
			else
				equip(sets.idle)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Idle]')
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
		elseif (spell.target.distance >= (spell.target.model_size + 3)) and not (spell.english == 'Starlight' or spell.english == 'Moonlight')then
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
		equip(sets.ws)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Weapon Skill]')
		end
	elseif spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard' then
	--elseif (spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard') and not (buffactive['Astral Conduit'] or buffactive['Apogee']) then
		if not (buffactive['Astral Conduit'] or buffactive['Apogee']) then
			equip(sets.bpdelay)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: BP Delay]')
			end
		end
	elseif spell.english == 'Astral Flow' then
		equip(sets.astralflow)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Astral Flow]')
		end
		if AFTimer == 'On' then
			if player.equipment.body == 'Summoner\'s Horn +2' or player.equipment.body == 'Glyphic Horn' or player.equipment.body == 'Glyphic Horn +1' or player.equipment.body == 'Glyphic Horn +2' or player.equipment.body == 'Glyphic Horn +3' then --these pieces extend Astral Flow by 30 seconds so we adjust accordingly
				send_command('input /echo [Astral Flow] 3:30;wait 30;input /echo [Astral Flow] 3:00;wait 30;input /echo [Astral Flow] 2:30;wait 30;input /echo [Astral Flow] 2:00;wait 30;input /echo [Astral Flow] 1:30;wait 30;input /echo [Astral Flow] 1:00;wait 30;input /echo [Astral Flow] 0:30;wait 10;input /echo [Astral Flow] 0:20;wait 10;input /echo [Astral Flow] 0:10')
			else
				send_command('input /echo [Astral Flow] 3:00;wait 30;input /echo [Astral Flow] 2:30;wait 30;input /echo [Astral Flow] 2:00;wait 30;input /echo [Astral Flow] 1:30;wait 30;input /echo [Astral Flow] 1:00;wait 30;input /echo [Astral Flow] 0:30;wait 10;input /echo [Astral Flow] 0:20;wait 10;input /echo [Astral Flow] 0:10')
			end
		end
	elseif spell.english == 'Astral Conduit' and ACTimer == 'On' then
		send_command('input /echo [Astral Conduit] 1:00;wait 30;input /echo [Astral Conduit] 0:30;wait 10;input /echo [Astral Conduit] 0:20;wait 10;input /echo [Astral Conduit] 0:10')
	elseif spell.english == 'Elemental Siphon' then
		if windower.ffxi.get_ability_recasts()[175] <= 1 then
			equip(sets.elementalsiphon)
		end
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Elemental Siphon]')
		end
	elseif spell.english == 'Mana Cede' then
		if windower.ffxi.get_ability_recasts()[71] <= 1 then
			equip(sets.manacede)
		end
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Mana Cede]')
		end
	elseif spell.english == 'Holy Water' then
		equip(sets.hwater)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Holy Water]')
		end
	--if we're casting an avatar with one already out, we'll use Release before casting:
	elseif (Avatars:contains(spell.english) or Spirits:contains(spell.english)) and pet.isvalid == true and AutoRelease == 'On' and windower.ffxi.get_ability_recasts()[172] == 0 then
		cancel_spell()
		send_command('input /pet "Release" <me>;wait 1;input /ma '..spell.english..' <me>')
	elseif (spell.english == 'Spectral Jig' or spell.english == 'Sneak' or spell.english == 'Monomi: Ichi' or spell.english == 'Monomi: Ni') and buffactive['Sneak'] and spell.target.type == 'SELF' then
		send_command('cancel 71')
	elseif spell.english == 'Fire' or spell.english == 'Blizzard' or spell.english == 'Aero' or spell.english == 'Stone' or spell.english == 'Thunder' or spell.english == 'Water' then
		equip(sets.Elemental)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Elemental]')
		end
	elseif not (spell.english == 'Assault' or spell.english == 'Retreat' or spell.english == 'Release' or spell.english == 'Avatar\'s Favor' or spell.english == 'Warp Ring' or spell.english == 'Dim. Ring (Dem)' or spell.english == 'Dim. Ring (Holla)' or spell.english == 'Dim. Ring (Mea)' or spell.english == 'Forbidden Key' or spell.english == 'Pickaxe' or spell.english == 'Sickle' or spell.english == 'Hatchet') then
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
	if spell.skill == 'Elemental Magic' and not (spell.english == 'Fire' or spell.english == 'Blizzard' or spell.english == 'Aero' or spell.english == 'Stone' or spell.english == 'Thunder' or spell.english == 'Water') then
		equip(sets.elemental)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Elemental]')
		end
	elseif spell.english == 'Refresh' then
		equip(set_combine(sets.buff, sets.refresh))
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Buff + Refresh]')
		end
	elseif spell.english == 'Cursna' then
		equip(sets.cursna)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Cursna]')
		end
	elseif string.find(spell.english,'Cur') and spell.type == "WhiteMagic" then
		equip(set_combine(sets.buff, sets.healing))
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Healing + Buff]')
		end
	elseif spell.type == 'Trust' then
		equip(sets.unity)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Unity]')
		end
	end
end

function pet_midcast(spell)
	if not (buffactive['Astral Conduit'] or buffactive['Apogee']) then
		if spell.type == 'BloodPactRage' then
			if BPRagePhysical:contains(spell.english) then
				equip(sets.bpragephysical)
				--windower.add_to_chat(8,'[Equipped Set: BP Rage Physical]')
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: BP Rage Physical]')
				end
			elseif BPRageMagical:contains(spell.english) then
				equip(sets.bpragemagical)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: BP Rage Magical]')
				end
			else
				equip(sets.bpragehybrid)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: BP Rage Hybrid]')
				end
			end
		elseif spell.type == 'BloodPactWard' then
			if BPWardBuff:contains(spell.english) then
				--equip(sets.bpdelay)
				equip(sets.bpwardbuff)
				--windower.add_to_chat(8,'[Equipped Set: BP Ward Buff]')
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: BP Ward Buff]')
				end
			else
				equip(sets.bpwarddebuff)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: BP Ward Debuff]')
				end
			end
		end
	end
end


-------------------------------------------
--              AFTERCAST                --
-------------------------------------------

function aftercast(spell)
	if spell.type == 'WeaponSkill' and not spell.interrupted and HUD == 'On' and NotiTPReturn == 'On' then
		send_command('wait '..TPReturnWait..';gs c TPReturn')
	end
	if NotiLowMP =='On' and player.mpp <= 20 and NotiLowMPToggle == 'Off' then
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

	if spell.type == "BloodPactRage" or spell.type == "BloodPactWard" then
		if DTOverride == "On" then
			equip(set_combine(sets.avatar, sets.dtoverride))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Avatar + DT Override]')
			end
		else
			equip(sets.avatar)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Avatar]')
			end
		end
	elseif spell.english == "Release" then
		if DTOverride == "On" then
			equip(set_combine(sets.idle, sets.dtoverride))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Idle + DT Override]')
			end
		else
			equip(sets.idle)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Idle]')
			end
		end
	else
		choose_set()
	end
end

-------------------------------------------
--             STATUS CHANGE             --
-------------------------------------------

function status_change(new,old)
	choose_set() --run this any time your status changes (engage, disengage, rest)
end

function pet_status_change(new,old)
	if new == "Engaged dead" then
		equip(sets.idle) --if the avatar despawns we equip the idle (no avatar) set
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Idle]')
		end
	end
end
-------------------------------------------
--             SHOW/HIDE HUD             --
-------------------------------------------

windower.register_event('status change', function(status)
    if status == 4 and HUD == 'On' and ShowHUD == true then --In a cutscene: Hide the HUD
		ShowHUD = false
		send_command('text bg1 hide;text bg2 hide;text bg3 hide;text favor hide;text siphon hide;text apogee hide;text cede hide;text convert hide;text aftermath hide;text notifications hide;text debuffs hide;text avatar hide')
    elseif status ~= 4  and HUD == 'On' and ShowHUD == false then --Out of cutscene: SHow the HUD
		ShowHUD = true
		send_command('text bg1 show;text bg2 show;text bg3 show;text favor show;text siphon show;text apogee show;text cede show;text convert show;text aftermath show;text notifications show;text debuffs show;text avatar show')
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
		if player.equipment.main == 'Hvergelmir' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 1 (30% Triple Dmg)";text aftermath color '..Aftermath1color..'')
			else
				windower.add_to_chat(220,'<< Aftermath: Level 1 (30% Triple Damage) >>')
			end
		elseif player.equipment.main == 'Khatvanga' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 1 (4-Step Ultimate)";text aftermath color '..Aftermath1color..'')
			else
				windower.add_to_chat(220,'<< Aftermath: Level 1 (4-Step Ultimate) >>')
			end
		elseif player.equipment.main == 'Nirvana' then
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
		if player.equipment.main == 'Hvergelmir' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 2 (40% Triple Dmg)";text aftermath color '..Aftermath2color..'')
			else
				windower.add_to_chat(204,'<< Aftermath: Level 2 (40% Triple Damage) >>')
			end
		elseif player.equipment.main == 'Khatvanga' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 2 (3-Step Ultimate)";text aftermath color '..Aftermath2color..'')
			else
				windower.add_to_chat(204,'<< Aftermath: Level 2 (3-Step Ultimate) >>')
			end
		elseif player.equipment.main == 'Nirvana' then
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
		if player.equipment.main == 'Hvergelmir' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 3 (50% Triple Dmg)";text aftermath color '..Aftermath3color..'')
			else
				windower.add_to_chat(50,'<< Aftermath: Level 3 (50% Triple Damage) >>')
			end
		elseif player.equipment.main == 'Khatvanga' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 3 (2-Step Ultimate)";text aftermath color '..Aftermath3color..'')
			else
				windower.add_to_chat(50,'<< Aftermath: Level 3 (2-Step Ultimate) >>')
			end
		elseif player.equipment.main == 'Nirvana' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 3 (Occ. Att. 2-3x)";text aftermath color '..Aftermath3color..'')
			else
				windower.add_to_chat(50,'<< Aftermath: Level 3 (Occ. Att. 2-3x) >>')
			end
		end
	elseif buff == 273 and NotiAftermath =='On' then --Relic Aftermath
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/AftermathOn.wav')
		end
		if player.equipment.main == 'Claustrum' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Active (DT/Refresh)";text aftermath color '..Aftermath3color..'')
			else
				windower.add_to_chat(220,'<< Aftermath: Active (DT/Refresh) >>')
			end
		end
	end
	if buff == 2 or buff == 19 and buffactive['Stoneskin'] then --If we get slept, remove stoneskin if its on
		send_command('cancel 37')
	end
	if buff == 15 and AlertSounds == 'On' then --Doom
		windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
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
	elseif buff == 0 and HUD == 'On' then
		send_command('text notifications text "Status: Alive ^_^";text notifications color 75 255 75')
	elseif buff == 1 then --Weakness
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« Weakness Has Worn Off »»";text notifications color 75 255 75')
		end
	end
end)

windower.register_event('tp change',function()
	if player.tp == 3000 and Noti3000TP == 'On' then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/3000TP.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« 3000 TP »»";text notifications color 0 255 0')
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
	if HUD == 'On' and LoadHUD == true and not TownZones:contains(world.area) then
		if buffactive['Doom'] and NotiDoom == 'On' then
			send_command('text debuffs text "«« DOOM »»";text debuffs color 255 50 50')
		elseif buffactive['Charm'] and NotiCharm == 'On' then
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
		else
			send_command('gs c ClearDebuffs') --clear debuffs if no debuffs are present
		end
	end
	if os.time() > Heartbeat then
		Heartbeat = os.time()
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
			if pet.isvalid == true then
				send_command('text avatar text "'..pet.name..' - '..pet.hpp..'% ('..pet.status..')"')
				if pet.name == "Carbuncle" or pet.name == "Cait Sith" or pet.name == "Alexander" or pet.name == "Light Spirit" then
					send_command('text avatar color 255 248 220')
				elseif pet.name == "Ifrit" or pet.name == "Fire Spirit" then
					send_command('text avatar color 255 0 0')
				elseif pet.name == "Shiva" or pet.name == "Ice Spirit" then
					send_command('text avatar color 135 206 250')
				elseif pet.name == "Garuda" or pet.name == "Siren" or pet.name == "Air Spirit" then
					send_command('text avatar color 50 205 50')
				elseif pet.name == "Titan" or pet.name == "Earth Spirit" then
					send_command('text avatar color 210 105 30')
				elseif pet.name == "Ramuh" or pet.name == "Thunder Spirit" then
					send_command('text avatar color 186 85 211')
				elseif pet.name == "Leviathan" or pet.name == "Water Spirit"  then
					send_command('text avatar color 30 144 255')
				elseif pet.name == "Fenrir" or pet.name == "Diabolos" or pet.name == "Atomos" or pet.name == "Odin" or pet.name == "Dark Spirit" then
					send_command('text avatar color 138 43 226')
				end
			else
				send_command('text avatar text "No Avatar"')
				send_command('text avatar color 255 50 50')
			end
			if NotiDoom == 'On' and buffactive['Doom'] then 
				send_command('text debuffs text "«« DOOM »»";text debuffs bg_transparency 200;text debuffs color 0 0 0;text debuffs bg_color 255 255 255;wait .5;text debuffs bg_color 255 204 51')
			end
			--Recast updates:
			FavorRecast = windower.ffxi.get_ability_recasts()[176]
			SiphonRecast = windower.ffxi.get_ability_recasts()[175]
			ApogeeRecast = windower.ffxi.get_ability_recasts()[108]
			CedeRecast = windower.ffxi.get_ability_recasts()[71]
			if player.sub_job == 'RDM' and player.sub_job_level >= 1 then
				ConvertRecast = windower.ffxi.get_ability_recasts()[49]
			end
			--Recast color updates - decide the colors:
			if buffactive['Avatar\'s Favor'] then FavorColor = '75 255 75'
			elseif FavorRecast > 0 then FavorColor = '255 165 0'
			else FavorColor = '255 50 50'
			end
			if SiphonRecast == 0 then SiphonColor = '255 50 50'
			else SiphonColor = '255 165 0'
			end
			if ApogeeRecast == 0 then ApogeeColor = '255 50 50'
			else ApogeeColor = '255 165 0'
			end
			if CedeRecast == 0 then CedeColor = '255 50 50'
			else CedeColor = '255 165 0'
			end
			if player.sub_job == 'RDM' and player.sub_job_level >= 1 then
				if ConvertRecast == 0 then ConvertColor = '255 50 50'
				else ConvertColor = '255 165 0'
				end
			end
			--Recast color updates - print the colors:
			send_command('text favor color '..FavorColor..'')
			send_command('text siphon color '..SiphonColor..'')
			send_command('text apogee color '..ApogeeColor..'')
			send_command('text cede color '..CedeColor..'')
			if player.sub_job == 'RDM' and player.sub_job_level >= 1 then
				send_command('text convert color '..ConvertColor..'')
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
	if HUD =='On' then
		send_command('gs c Clear') --clear any notifications on zone
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
			if NotiTime == 'On' and HUD == 'On' then
				send_command('text notifications text "«« 15 Minutes Remaining »»";text notifications color 255 255 50')
			end
		elseif org:find(' 10 ') then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
			end
			if NotiTime == 'On' and HUD == 'On' then
				send_command('text notifications text "«« 10 Minutes Remaining »»";text notifications color 255 255 50')
			end
		elseif org:find(' 5 ') then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
			end
			if NotiTime == 'On' and HUD == 'On' then
				send_command('text notifications text "«« 5 Minutes Remaining »»";text notifications color 255 255 50')
			end
		end
	elseif NotiOmen == 'On' and org:find('You find a') then
		if org:find('Fu\'s scale') then
			send_command('input /p Fu\'s Scale: BST, DRG, SMN, PUP <call14>')
		elseif org:find('Gin\'s scale') then
			send_command('input /p Gin\'s Scale: THF, NIN, DNC, RUN <call14>')
		elseif org:find('Kei\'s scale') then
			send_command('input /p Kei\'s Scale: WHM, BLM, RDM, BLU, SCH <call14>')
		elseif org:find('Kin\'s scale') then
			send_command('input /p Kin\'s Scale: WAR, MNK, PLD, DRK, SAM <call14>')
		elseif org:find('Kyou\'s scale') then
			send_command('input /p Kyou\'s Scale: BRD, RNG, COR, GEO <call14>')
		end
	elseif NotiVagary == 'On' and org:find('You pitiful lot will never learn') then
		send_command('input /p Perfidien pop! <call14>')
	elseif NotiVagary == 'On' and org:find('the void calls') then
		send_command('input /p Plouton pop! <call14>')
	elseif NotiVagary == 'On' and org:find('Hoho! Poked at a sore spot, didn\'t you?') or org:find('Switching things up, hmm?') then
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
		send_command('gs showswaps') --turn off the built-in gearswap debug mode and turn off showswaps
	end
	if HUD == 'On' then
		send_command('text bg1 delete;text bg2 delete;text bg3 delete;text favor delete;text siphon delete;text apogee delete;text cede delete;text convert delete;text aftermath delete;text notifications delete;text debuffs delete;text loading delete;text avatar delete') --delete the different text objects
	end
end

--[[

-------------------------------------------
--            KEYS NOTEPAD               --
-------------------------------------------

-Auto-Favor

Default text size is 12
Large 15 (+24)
Medium 12 (+20)
Small 9 (+15)

 --]]
