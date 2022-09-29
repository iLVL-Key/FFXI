-------------------------------------------
-- Keys Gearswap lua file for Blue Mage  --
-------------------------------------------
--[[

-------------------------------------------
--                 NOTES                 --
-------------------------------------------

Place both this file and the sounds folder inside the GearSwap data folder
	/addons/GearSwap/data/sounds/
	/addons/GearSwap/data/BLU.lua

While not required, it is highly recommended to use the Azuresets windower plugin.

This file has 4 modes available to use, you do not need to use each one.

To switch into each mode, create a macro for each one you are using with the following
	/console Mode#
With # being 1-4 depending on which ones you are using.

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

Recommended Windower Addons: Azuresets, BLUAlert, Text

-------------------------------------------
--               PRO TIPS                --
-------------------------------------------
1)Use macro page (set) 1 for your mode macros and a separate macro page for each mode. To move to a different
macro page use the following in each mode macro
	/macro set #
With # being the number of the page for each mode. This will automatically switch to that book page at the same time.

2)If you use Azuresets, add the following to each macro
	/console aset spellset nameofyourspellset
This will automatically load each spellset at the same time.

For example, a macro to switch into Melee Mode might look like:
	/console Mode2
	/console aset spellset melee
	/macro set 3

3)If you use Azuresets, you can integrate the cooldown timer into this file with a little bit of editing.
Open the azuresets file:
	/addons/azuresets/azuresets.lua
and look for the following on lines 150 and 179:
	windower.send_command('@timers c "Blue Magic Cooldown" 60 up')
Replace each of those two lines entirely with the following:
	windower.send_command('gs c SpellSetCooldown')
Then save the file and reload it in game by typing:
	//lua r azuresets
into your chatlog directly.

--]]

-------------------------------------------
--                OPTIONS                --
-------------------------------------------
AutoLockstyle	=	'On'	--[On/Off]		Automatically sets your lockstyle. Uses the Field and Town sets below.
LockstyleCombat	=	'2'		--[1-20]		Your Lockstyle set when in a field zone.
LockstyleTown	=	'1'		--[1-20]		Your Lockstyle set when in a town zone.
							--				If you do not want a separate town lockstyle, set this to the same as LockstyleCombat.
Book			=	'1'		--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
Page			=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
CJTimer			=	'p'		--[p/e/Off]		Displays a timer for Cruel Joke in the selected chat channel (party, echo, or off).
ALTimer			=	'On'	--[On/Off]		Displays a timer for Azure Lore in echo.
UWTimer			=	'On'	--[On/Off]		Displays a timer for Unbridled Wisdom in echo.
BLUAlert		=	'Off'	--[On/Off]		Automatically loads and unloads the BLUAlert Windower addon on file load/unload.
DTCtrlPlus		=	'd'		--				Sets the keyboard shortcut you would like to activate the Damage Taken Override.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions
							--				(Town limits this to town gear only)
AlertSounds		=	'On'	--[On/Off]		Plays a sound on alerts.
UseEcho			=	'R'		--[E/R/Off]		Automatically uses an Echo Drop (E), or Remedy (R) instead of spell when you are silenced.
OccShadows		=	13		--				How many shadows does your Occultation create. Every 50 Blue Magic Skill is 1 shadow (ie 12 at 600 skill)
CharmNaked		=	'On'	--[On/Off]		Automatically strips you naked (except weapons) when you're charmed so you don't murder anyone and allowing you to be more easily slept.

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

--HUD Mode Names
Mode1Name = 'General'
Mode2Name = 'Melee'
Mode3Name = 'Nuke'
Mode4Name = 'Support'

--HUD Recast Spells
--  The first column here MUST be input exactly as they are spelled in-game.
--  The second column here is for the shorthand to be used in the HUD.
--  Insert NONE if you want to leave a column unused
--Mode 1
RecastMode1C1 =	'Erratic Flutter'	RecastMode1C1SH = 'Erratic'	--Column 1
RecastMode1C2 =	'Battery Charge'	RecastMode1C2SH = 'Battery'	--Column 2
RecastMode1C3 =	'Occultation'		RecastMode1C3SH = 'Occult'	--Column 3
RecastMode1C4 =	'Diamondhide'		RecastMode1C4SH = 'Diamond'	--Column 4
RecastMode1C5 =	'Barrier Tusk'		RecastMode1C5SH = 'Barrier'	--Column 5
RecastMode1C6 =	'Reactor Cool'		RecastMode1C6SH = 'Reactor'	--Column 6
--Mode 2
RecastMode2C1 =	'Erratic Flutter'	RecastMode2C1SH = 'Erratic'	--Column 1
RecastMode2C2 =	'Occultation'		RecastMode2C2SH = 'Occult'	--Column 2
RecastMode2C3 =	'Cocoon'			RecastMode2C3SH = 'Cocoon'	--Column 3
RecastMode2C4 =	'Nat. Meditation'	RecastMode2C4SH = 'Nat Med'	--Column 4
RecastMode2C5 =	'Berserk'			RecastMode2C5SH = 'Berserk'	--Column 5
RecastMode2C6 =	'Aggressor'			RecastMode2C6SH = 'Aggres.'	--Column 6
--Mode 3
RecastMode3C1 =	'Erratic Flutter'	RecastMode3C1SH = 'Erratic'	--Column 1
RecastMode3C2 =	'Battery Charge'	RecastMode3C2SH = 'Battery'	--Column 2
RecastMode3C3 =	'Occultation'		RecastMode3C3SH = 'Occult'	--Column 3
RecastMode3C4 =	'Diamondhide'		RecastMode3C4SH = 'Diamond'	--Column 4
RecastMode3C5 =	'Barrier Tusk'		RecastMode3C5SH = 'Barrier'	--Column 5
RecastMode3C6 =	'Cocoon'			RecastMode3C6SH = 'Cocoon'	--Column 6
--Mode 4
RecastMode4C1 =	'Erratic Flutter'	RecastMode4C1SH = 'Erratic'	--Column 1
RecastMode4C2 =	'Battery Charge'	RecastMode4C2SH = 'Battery'	--Column 2
RecastMode4C3 =	'Occultation'		RecastMode4C3SH = 'Occult'	--Column 3
RecastMode4C4 =	'Diamondhide'		RecastMode4C4SH = 'Diamond'	--Column 4
RecastMode4C5 =	'NONE'				RecastMode4C5SH = 'NONE'	--Column 5
RecastMode4C6 =	'NONE'				RecastMode4C6SH = 'NONE'	--Column 6

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
NotiEncumbrance		=	'On'	--[On/Off]	Displays a notification when you have encumbrance.
-------------------------------------------
--           ADVANCED OPTIONS            --
-------------------------------------------

HUDBGTrans	=		'175'	--Background transparency for the HUD. (1 = fully clear, 256 = fully opaque)
TPReturnWait=		'0.2'	--Adjust this timing in seconds as needed. (TP Return may not always be 100% accurate depending on lag, regain, etc.)
Debug		=		'Off'	--[On/Off]

--Mode color values in RGB for the HUD
Mode1color =		'255 125 125'	--Mode 1
Mode2color =		'125 125 255'	--Mode 2
Mode3color =		'125 255 125'	--Mode 3
Mode4color =		'255 255 125'	--Mode 4

--Color values in RGB for the HUD Aftermath status
Aftermath1color =	'0 127 255'		--Aftermath Level 1
Aftermath2color =	'75 255 75'		--Aftermath Level 2
Aftermath3color =	'255 255 50'	--Aftermath Level 3

-------------------------------------------
--               GEAR SETS               --
-------------------------------------------

function get_sets()

	-- Idle (Refresh, Regain, Regen, Damage Taken-, Enmity-)
	sets.idle = {
		ammo="Staunch Tathlum",
		head="Rawhide Mask",
		body="Hashishin Mintan +2",
		hands="Serpentes Cuffs",
		legs="Carmine Cuisses +1",
		feet="Serpentes Sabots",
		neck="Twilight Torque",
		--neck="Loricate Torque",
		waist="Flume Belt",
		left_ear="Suppanomimi",
		--left_ear="Hearty Earring",
		right_ear="Ethereal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Rosmerta's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}},
    }

	-- DPS (Accuracy, Double/Triple Attack, DEX, Store TP, Attack, Refresh, Regain, Regen)
	sets.dps = {
		ammo="Coiste Bodhar",
		head="Adhemar Bonnet +1",
		body="Adhemar Jacket +1",
		hands="Adhemar Wrist. +1",
		legs="Herculean Trousers",
		feet={ name="Herculean Boots", augments={'Attack+21','"Triple Atk."+3','STR+10','Accuracy+15',}},
		neck="Mirage Stole +2",
		waist="Windbuffet Belt +1",
		left_ear="Suppanomimi",
		right_ear="Odr Earring",
		left_ring="Epona's Ring",
		right_ring="Hetairoi Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
	}

	-- DT Override (Damage Taken-, Magic Evasion)
	-- Will override all other gear sets and inherit unused slots from them
	sets.dtoverride = {
		head="Nyame Helm",
		body="Malignance Tabard",
		hands="Nyame Gauntlets",
		legs="Hashishin Tayt +2",
		feet="Nyame Sollerets",
		right_ring="Defending Ring",
	}

	-- Rest
	sets.rest = {
		waist="Austerity Belt",
	}

	-- Weapon Skill (STR, Weapon Skill Damage, Attack, Double/Triple Attack)
	sets.ws = {
		ammo="Aurgelmir Orb",
		head="Hashishin Kavuk +2",
		body="Assim. Jubbah +3",
		hands="Jhakri Cuffs +2",
		legs="Luhlaza Shalwar +3",
		feet="Nyame Sollerets",
		neck="Mirage Stole +2",
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Ishvara Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Ilabrat Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
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
		head="Adhemar Bonnet +1",
		body="Adhemar Jacket +1",
		hands="Adhemar Wrist. +1",
		legs="Herculean Trousers",
		feet="Aya. Gambieras +2",
		waist="Fotia Belt",
		left_ear="Mache Earring +1",
		right_ear="Odr Earring",
		left_ring="Epona's Ring",
		right_ring="Hetairoi Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
	})

	-- Expiacion (30% STR, 30% INT, 20% DEX mod)
	-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
	sets.exp = set_combine(sets.ws, {

	})

	-- Fast Cast (cap is 80%)
	sets.fastcast = {
		ammo="Sapience Orb", --2%
		head="Amalric Coif +1", --11%
		body="Amalric Doublet +1", --4% (from augment)
		hands="Leyline Gloves", --5% (possibly up to additional 3% with augments)
		legs="Pinga Pants", --11%
		feet="Amalric Nails +1", --6%
		neck="Baetyl Pendant", --4%
		waist="Witful Belt", --3%
		left_ear="Loquac. Earring", --2%
		right_ear="Etiolation Earring", --1%
		left_ring="Prolix Ring", --2%
		right_ring="Kishar Ring", --4%
		back={ name="Rosmerta's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}}, --10%
	}

	-- Physical Spells (STR, Accuracy, Attack)	(Macc only affects add'l effects landing, NOT the damage from the physical spell itself)
	sets.physical = {
		ammo="Aurgelmir Orb",
		head="Hashishin Kavuk +2",
		body="Hashishin Mintan +2",
		hands="Hashi. Bazu. +2",
		legs="Hashishin Tayt +2",
		feet="Hashi. Basmak +2",
		neck="Mirage Stole +2",
		waist="Sailfi Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Odr Earring",
		left_ring="Ilabrat Ring",
		right_ring="Jhakri Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}

	-- Magical Spells (Magic Attack Bonus, Magic Damage, INT, Magic Accuracy)
	sets.magical = {
		ammo="Ghastly Tathlum +1",
		body="Cohort Cloak +1",
		hands="Amalric Gages +1",
		legs="Amalric Slops +1",
		feet="Amalric Nails +1",
		neck="Sibyl Scarf",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Shiva Ring +1",
		right_ring="Metamor. Ring +1",
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}

	-- Earth
	-- Combines with Magical set, only necessary to set the slots with specific desired stats
	sets.magical.earth = set_combine(sets.magical, {
		neck="Quanpur Necklace",
	})

	-- Dark
	-- Combines with Magical set, only necessary to set the slots with specific desired stats
	sets.dark = set_combine(sets.magical, {
		head="Pixie Hairpin +1",
		body="Amalric Doublet +1",
		left_ring="Archon Ring",
	})

	-- Breath
	-- Combines with Magical set, only necessary to set the slots with specific desired stats
	sets.breath = set_combine(sets.magical, {
		head="Luh. Keffiyeh +3",
	})

	-- Magic Accuracy (Magic Accuracy, Blue Magic Skill)
	sets.magicaccuracy = {
		--ammo="Pemphredo Tathlum",
		ammo="Mavi Tathlum",
		head="Assim. Keffiyeh +3",
		body="Hashishin Mintan +2",
		hands="Rawhide Gloves",
		legs="Hashishin Tayt +2",
		feet="Hashi. Basmak +2",
		neck="Mirage Stole +2",
		waist="Acuity Belt +1",
		left_ear="Njordr Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Metamor. Ring +1",
		back="Aurist's Cape +1",
	}

	-- Buff (Conserve MP)
	sets.buff = {
		--ammo="Pemphredo Tathlum",
		body="Amalric Doublet +1",
		hands="Shrieker's Cuffs",
		feet="Amalric Nails +1",
		neck="Reti Pendant",
		waist="Austerity Belt",
		left_ear="Calamitous Earring",
		right_ear="Mendi. Earring",
		back="Solemnity Cape",
	}

	-- Blue Magic Skill (Blue Magic Skill)
	sets.bluemagicskill = {
		ammo="Mavi Tathlum",
		head="Luh. Keffiyeh +3",
		body="Assim. Jubbah +3",
		hands="Rawhide Gloves",
		legs="Hashishin Tayt +2",
		feet="Luhlaza Charuqs +3",
		neck="Mirage Stole +2",
		left_ear="Njordr Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Cornflower Cape",
	}

	-- Healing (Cure Potency, MND+)
	sets.healing = {
		head="Assim. Keffiyeh +3",
		body="Hashishin Mintan +2",
		hands="Hashi. Bazu +2",
		legs="Pinga Pants",
		feet="Nyame Sollerets", -- just for the HP
		neck="Phalaina Locket",
		waist="Eschan Stone", --just for the HP
		left_ear="Mendi. Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Solemnity Cape",
	}

	-- White Wind (HP+ gear)
	-- Combines with Healing set, only necessary to set the slots with specific desired stats
	sets.whitewind = set_combine(sets.healing, {

	})

	-- Battery (Refresh augmenting gear, not Refresh+)
	sets.battery = {
		head="Amalric Coif +1",
		back="Grapevine Cape",
	}

	-- Cursna (Cursna+, Healing Magic)
	sets.cursna = {
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

	-- Azure Lore
	sets.azurelore = {

	}

	-- Chain Affinity (must remain equipped during midcast)
	sets.chainaffinity = {
		head="Hashishin Kavuk +2",
		feet="Assim. Charuqs +2",
	}

	-- Burst Affinity (must remain equipped during midcast)
	sets.burstaffinity = {
		legs="Assim. Shalwar +3",
		feet="Hashi. Basmak +2",
	}

	-- Diffusion (must remain equipped during midcast)
	sets.diffusion = {
		feet="Luhlaza Charuqs +3",
	}

	-- Efflux
	sets.efflux = {
		legs="Hashishin Tayt +2",
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
TopVersion = 'Sandspin' --Leave this alone, used for debugging purposes



	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX          DO NOT EDIT BELOW THIS LINE          XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--



BottomVersion = 'Sandspin'
FileVersion = '09.29.22'

-------------------------------------------
--               UPDATES                 --
-------------------------------------------

--[[
If the new updates Version Compatibility Codename matches your current files TopVersion,
simply replace everything under the "Do Not Edit Below This Line".
Only when the Version Compatibility Codename changes will you need to update the entire file.

09.29.22 (Version Compatibility Codename: Sandspin)
-Added missing listings in the /fileinfo printout for a few Notifications.
-Added Silver Knife to list of Adoulin/Town areas.
-Fixed an issue where the spell cooldown timer would continue during the brief period between setting your spells right after setting them a first time, showing the new spell set name with the old timer attached to it.
-Removed Gearswaps built-in showswaps function from the files debug mode.

09.04.22 (Version Compatibility Codename: Sandspin)
-Added all DOTs to the rule that removes Stoneskin if asleep.

08.28.22 (Version Compatibility Codename: Sandspin)
-Adjusted what the fastcast set ignores to include all "Ring" items (previously would ignore only Warp and Dimensional Rings specifically, will now also ignore XP/CP rings)
-Fixed the Earth set name so it equips properly.

08.13.22 (Version Compatibility Codename: Sandspin)
-Added Leafallia to list of towns.
-Added cancelling Stoneskin if its preventing poison from removing sleep, otherwise equip the Opo-opo Necklace per usual.
-Added equipping the DT Override set when petrified, stunned, or terrored.
-Added option to remove all gear (except weapons) when you are charmed.
-Adjusted abilities to not equip their gear sets if they are still on cooldown.
-Split the Cursna set into Cursna and Holy Water.
-Renamed LockstyleField to LockstyleCombat. Just makes more sense.
-Fixed an issue where the debuff background color change from Doom (flashing white and yellow) would get stuck on yellow after Doom wears off and you have another debuff on that takes over in the debuff spot.
-Fixed an issue where resting would combine the Rest set with the DT Override set regardless of DT Override being on or off.
-Removed the leftover Enmity gear set. The functionality for this set was removed in a previous version, I simply forgot to remove the gear set.
-Updated Version Compatibility Codename to Sandspin.

07.18.22 (Version Compatibility Codename: Pollen)
-Overhauled how area checks are handled. Uses tables now for groups of areas.
-Fixed the DTOverride set not equipping correctly when idle.
-Fixed some errors that would show up on job change. These were caused by the Heartbeat function constantly checking for any debuffs present; when you unload the file (change job) it will delete the debuff text objects used for the HUD which will cause a split second where the debuff check freaks out. The fix was to simply disable the debuff checks in town zones.
-Fixed an issue with the Sleep debuff not showing properly in the HUD.
-Code cleanup

06.14.22 (Version Compatibility Codename: Pollen)
-Adjusted HUD timings on load. Should fix the occasional errors about text objects not existing as well as objects loading underneath the background layer.
-Removed Gearswaps built-in debugmode from the files Debug mode.
-Moved the Updates section towards the top of the file.
-Code cleanup

03.11.22 (Version Compatibility Codename: Pollen)
-Overhauled Debuff Notifications. Will now check which debuffs are up in real time with a list of priority for which is displayed instead of clearing the notifications entirely when any of them are removed (leaving it blank even if a different debuff was still up).
-Added missing On/Off option/rules to Time Remaining (currently only for Abyssea), Omen, and Vagary
-Added Encumbrance to the Debuffs.
-Fixed Alliance invite incorrectly triggering Party invite notification.
-Fixed some subjob conditions throwing errors when you have no subjob (ie Odyssey NMs)

02.02.22 (Version Compatibility Codename: Pollen)
-Added Weak status notification.
-Fixed gear not fully equipping in towns.
-Fixed Abyssea Visitant status triggering on incorrect time remaining (ie 110 minutes would trigger the 10 minute)
-Fixed Fast Cast gear to not equip when using a Forbidden Key, Pickaxe, Sickle, or Hatchet.

02.01.22 (Version Compatibility Codename: Pollen)
-Overhauled how Blue Magic spells are handled. Uses tables now for groups of spells that use certain gearsets.
-Overhauled Notifications. Removed reliance on variables and spun out Debuffs into their own thing.
-Renamed the OnScreen Display to HUD.
-Added Paralysis to the Debuffs.
-Added option to automatically use an Echo Drop (or Remedy) instead of spell when you are silenced.
-Added a Savage Blade Weapon Skill set.
-Added missing Luhlaza Bazubands +2 and +3 variants for extending Azure Lore timer.
-Added rule for White Magic Cure spells to the Healing set.
-Added rule for Elemental spells to use the Magical set.
-Added option for setting macro book page (set).
-Added Trade, Invite, Sneak, Invisible, Vorseal, Signet, Sanction, Sigil, and Ionis to the Notifications.
-Added the 3000 TP notification to the Notification options.
-Added 2 new sounds (NotiGood and NotiBad) and adjusted sound usage accordingly.
-Added a Heartbeat function. This creates a one second "heartbeat" that we can use to do various things that may not otherwise have an automatic trigger.
-Added a background to the HUD creating a box that everything is displayed inside, instead of separate floating pieces of info.
-Added Spell/Ability recasts to the HUD. Green when active, Orange when not active but on cooldown, red when not active and ready to use.
-Added equipping of Opo-opo Necklace when asleep (and un-equip after).
-Added HUD now hiding when in a cutscene. (The code to hide while zoning is adding a lot of lag, will look further into this)
-Adjusted the solid colors to be a little less solid (red was just so... ~*RED*~)
-Adjusted the Doom Notification to have a more noticeable presence.
-Fixed an issue with AutoLockstyle where it would not run correctly if you change your sub job immediately after changing to BLU.
-Fixed the Reraise Reminder.
-Fixed the Dead Notification.
-Changed «« and »» to << and >> for chatlog notifications since «« and »» don't actually display in the chatlog.
-Changed compatibility naming scheme to Blue Mage spells.
-Code cleanup

11.10.21 (Version Compatibility Codename: Maxprime-u1)
-Fixed Aftermath Notification colors displaying incorrectly.

10.27.21 (Version Compatibility Codename: Maxprime)
-Overhauled how lockstyle is handled. This now uses the in-game lockstyle set system instead of a gear set defined in this file.
-Added ability to use a Town lockstyle set separate from the set used while out in the field.
-Removed the Lockstyle gear set since it is no longer needed.
-Updated the Aftermath status to include Almace and Sequence (in addition to Tizona).
-Updated the Aftermath status in the OnScreen display to automatically display, or not, based on the equipped weapon.
-Layout of the OnScreen display will now self-adjust based on whether the Aftermath display is on or off.
-Removed the option to turn the Aftermath status in the OnScreen display on or off as this is now automatic as long as the OnScreen display is turned on.
-Added an Azure Lore and Unbridled Wisdom timer. These will show a countdown in echo until they wear off.
-Added a Cruel Joke chat log timer. Can choose between party chat or echo (or off).
-Added a "Food Has Worn Off" notification.
-Added Mute and Plague to the notifications.
-Added ability to turn on or off individual notifications.
-Added a sound notification to the Doom notification (if you have AlertSounds turned on of course).
-Overhauled AlertSounds. There is now a sounds folder with sound files included with this gearswap file. Simply drop the sounds folder inside your data folder (It should look like \addons\GearSwap\data\sounds).
-Fixed the spell Fantod using the magicaccuracy set while not in Tank mode, now uses the buff set instead.
-Adjusted the "Low MP" Notification to wait 30 seconds before being able to display the same notification again, instead of the above 40% threshhold previously used.
-Removed the Experimental feature GearCheck.
-Removed the Experimental feature AutoDefender.
-Removed reliance on Autoexec. Everything Autoexec did is now done completely through GearSwap functions.
-Code cleanup (lots of code cleanup...)
-Code comments added.
-Updated Top and Bottom version names.
-Updated //fileinfo

07.17.21 (Version Compatibility Codename: Jackup)
-Added an Expiacion Weapon Skill set.
-Added a White Wind set.
-Added a Kite set. This set will equip when in any Tank mode and not engaged (turning "Status: Idle" into "Status: Kiting")
-Added a Cursna/Holy Water set, replacing the Purity Ring code previously added.
-Added a "Reraise Has Worn Off" Notification.
-Added a Reraise Reminder Notification.
-Added a "Low MP" Notification. Triggers when MP is under 20%. This will not trigger again until the player’s HP reaches 40%.
-OnScreen Notifications will now reset after zoning.
-Fixed sneak cancelling on yourself if you cast sneak on another player.
-Fixed Learning submodes to correctly use the Blue Magic Skill set.
-Updated Top and Bottom version names.
-Updated //fileinfo

03.30.21 (Version Compatibility Codename: Fidant)
-Added a slight wait into the On-Screen display. This should prevent the occasional Text plugin error on file load.
-Added SoundAlerts function. This will play a sound for various things (cancelled spell due to silence, not enough TP for a WS, 3000 TP, etc)
-Updated which gear sets are equipped for a few of the Unbridled Learning spells where we care more about the additional effect landing than we do about the damage.
-Fixed Unity Trust set to actually equip as intended.
-Updated Top and Bottom version names.
-Minor formatting adjustments.

02.09.21 (Version Compatibility Codename: Neonstar)
-Added Purity Ring on casting Cursna on yourself or using a Holy Water.
-Added Enmity set. Will only equip for Fantod, Jettatura, and Blank Gaze when in any of the tank modes.
-Updated Top and Bottom version names.

01.10.21 (Version Compatibility Codename: Kedar)
-Added Aftermath status into the OnScreen display. This is a separate line and can be turned on or off in the options.
-Changed the Gear Mode logic. You can now independently turn on or off the Treasure Hunter and Learning sub-modes.
 This will skip the modes that are turned off when you cycle through modes. So for example if you do not need
 or use either of the Treasure Hunter or Learning modes it will simply cycle between DPS and Tank.
-Added options to use an alias command or a kb shortcut for cycling between gear modes.
-Simplified the command needed to use a macro to cycle between gear modes.
-Added town sets. Unless you don't use a lockstyle, this is mostly intended just for the movement speed gear for specific towns.
-Added Unity Trust set. Put your Unity Shirt in this set to get the bonus when calling your Unity Trust.
-Added a second shorthand alias (lstyle) for the Auto-Lockstyle function.
-Adjusted Auto-Lockstyle function to choose the correct set to change back into after locking the lockstyle set (tank, idle, town, etc)
-Added option to adjust the transparency level of the OnScreen display.
-Added option to automatically re-equip your gear after you zone. 'All' will either equip whichever Gear Mode you are in, or equip the
 set for the town you are in. 'Town' will only do this when you zone into a town.
-Added ability to turn off the Chat and Book options in case you either do not want to use them or another plugin does it already.
-Moved the GearCheck and AutoDefender functions into a new Experimental Options section.
-Added a new Top and Bottom version identifier. This will help narrow down issues when updating this file to a new version in the future.
 The idea is that whenever I make changes that require edits to the top half of the file, I will change the Top and Bottom version names.
 This is so that when you update the file and replace everything below the "Do Not Edit Below This Line" line and have issues,
 we can see if it stems from the Top and Bottom versions not matching.
-Minor adjustments to which gear sets are used in different gear modes while engaged/idle.
-Some code cleanup
-Changed //filehelp to //fileinfo. Don't @ me.
-Updated //fileinfo to reflect updates.

10.20.20
-Added a Rest set. You will need to add this set even if you don't intend to use it.
-Changed //help to //filehelp to avoid any possible overlap with plugins/addons
-Adjusted gear sets during idle and engaged. (ex. if you're in tank mode and engaged, it will now equip tank set first, then pull from
 dps set for any slots not assigned in your tank set)
-Adjusted BlueMagicSkill, Healing, and Battery gear rules to combine with Buff set.
-Adjusted Precast to cancel spell when unable to actually cast due to debuff(s) and to add a notification when that happens.

09.15.20
-Fixed spell subtarget on WS
-Fixed distance for ranged WS
-Fixed TH gear equipping at the appropriate time
-Fixed a lot of the chat log notifications not displaying properly
-Fixed Diffusion so that it has the set equipped for spell cast completion and not just at ability activation
-Will now warn you when you have certain items equipped (Warp Ring, Reraise Hairpin, etc.)
-Added a //help command that will print out the Notes/Options
-Lots of code cleanup
--]]

-------------------------------------------
--            SPELL MAPPING              --
-------------------------------------------

Physical = S{
	'Asuran Claws','Battle Dance','Bludgeon','Bloodrake','Cannonball','Death Scissors','Dimensional Death','Disseverment','Empty Thrash','Foot Kick','Frenetic Rip','Goblin Rush','Glutinous Dart','Mandibular Bite','Paralyzing Triad','Pinecone Bomb','Power Attack','Quad. Continuum','Quadrastrike','Queasyshroom','Ram Charge','Saurian Slide','Screwdriver','Sinker Drill','Smite of Rage','Spinal Cleave','Thrashing Assault','Uppercut','Vertical Cleave','Whirl of Rage','Amorphic Spikes','Barbed Crescent','Claw Cyclone','Hysteric Barrage','Seedspray','Sickle Slash','Terror Touch','Vanity Dive','Body Slam','Delta Thrust','Grand Slam','Sprout Smack','Feather Storm','Benthic Typhoon','Helldive','Hydro Shot','Jet Stream','Wild Oats','Spiral Spin','Heavy Strike'
    }

Magical = S{
	'Acrid Stream','Anvil Lightning','Crashing Thunder','Charged Whisker','Droning Whirlwind','Firespit','Foul Waters','Gates of Hades','Leafstorm','Molting Plumage','Nectarous Deluge','Polar Roar','Regurgitation','Rending Deluge','Scouring Spate','Searing Tempest','Silent Storm','Spectral Floe','Subduction','Tem. Upheaval','Thermal Pulse','Uproot','Water Bomb','Blazing Bound','Blinding Fulgor','Diffusion Ray','Ice Break','Magic Hammer','Rail Cannon','Retinal Glare'
    }

Earth = S{
	'Embalming Earth','Entomb','Sandspin'
    }

Dark = S{
	'Dark Orb', 'Death Ray', 'Evryone. Grudge', 'Eyes On Me', 'Palling Salvo', 'Tenebral Crush'
    }

MagicAccuracy = S{
	'1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye','Bilgestorm',"Blank Gaze",'Blastbomb','Blistering Roar','Blitzstrahl','Chaotic Eye','Cimicine Discharge','Cold Wave','Corrosive Ooze','Cruel Joke','Demoralizing Roar','Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar','Frypan','Geist Wall','Head Butt','Hecatomb Wave','Infrasonics',"Jettatura",'Light of Penance','Lowing','Mind Blast','Mortal Ray','Reaving Wind','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas','Sub-zero Smash','Sudden Lunge','Sweeping Gouge','Tail slap','Tearing Gust','Temporal Shift','Thunderbolt','Tourbillion','Venom Shell','Voracious Trunk','Yawn'
    }

Breath = S{
	'Bad Breath','Flying Hip Press','Final Sting','Frost Breath','Heat Breath','Magnetite Cloud','Poison Breath','Radiant Breath','Self Destruct','Thunder Breath','Vapor Spray','Wind Breath'
    }

Buff = S{
	'Amplification','Barrier Tusk','Cocoon','Erratic Flutter',"Fantod",'Feather Barrier','Harden Shell','Memento Mori','Mighty Guard','Nat. Meditation','Orcish Counterstance','Plasma Charge','Pyric Bulwark','Reactor Cool','Refueling','Saline Coat','Warm-Up','Zephyr Mantle'
    }

BlueMagicSkill = S{
	'Atra. Libations','Blood Drain','Blood Saber','Carcharian Verve','Diamondhide','Digest','Metallic Body','Magic Barrier','MP Drainkiss','Occultation','Osmosis'
    }

Healing = S{
	'Exuviation','Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','Wild Carrot'
    }

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

Mode = 'NONE' --We don't yet know what spellset you're using
NotiLowMPToggle = 'Off' --Start with the toggle off for the Low MP Notification so that it can trigger
DTOverride = "Off" --Start with the Damage Taken Override off
SpellSetCooldown = 0 --Spell Cooldown starts at 0 until its activated by the Azuresets plugin modifications if you made them
RRRCountdown = ReraiseReminderTimer
ShadowCount = 0
Heartbeat = 0 --set to 0 just to start the Heartbeat running
LoadDelay = 3 --delays loading the HUD, this makes sure all the variables get set correctly before being used, displays file version info, and waits to use lockstyle
LoadHUD = false --starts false then switched to true after the LoadDelay
ShowHUD = true --this changes to false when we are in a cutscene
--set the initial recasts to 0, they will get updated in the Heartbeat function:
DefenderRecast = 0
AggressorRecast = 0
BerserkRecast = 0
WarcryRecast = 0
ErraticRecast = 0
BatteryRecast = 0
OccultRecast = 0
DiamondRecast = 0
BarrierTRecast = 0
CocoonRecast = 0
NatMedRecast = 0
SalineRecast = 0
OCStanceRecast = 0
MementoRecast = 0
ReactorRecast = 0
FBarrierRecast = 0
AmplifiRecast = 0
RegenerRecast = 0
MBarrierRecast = 0
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
	if player.equipment.main == 'Tizona' or player.equipment.main == 'Almace' or player.equipment.main == 'Sequence' then
		REMA = true --If we have a REMA equipped we set this toggle to true
	else
		REMA = false --If we do not have a REMA equipped, we set it to false
	end
	--Create all the HUD Background text objects and put them above the screen for now, we'll move them to the correct place next
	send_command('text bg1 create "                                                                                                                          ";wait .3;text bg1 size '..FontSize..';text bg1 pos '..HUDposXColumn1..' '..HUDposYLine1..';text bg1 bg_transparency '..HUDBGTrans..'')--Background Line 1
	send_command('text bg2 create "                                                                                                                          ";wait .3;text bg2 size '..FontSize..';text bg2 pos '..HUDposXColumn1..' -100;text bg2 bg_transparency '..HUDBGTrans..'')--Background Line 2
	send_command('text bg3 create "                                                                                                                          ";wait .3;text bg3 size '..FontSize..';text bg3 pos '..HUDposXColumn1..' -100;text bg3 bg_transparency '..HUDBGTrans..'')--Background Line 3
	send_command('text loading create "Loading Keys BLUE MAGE file ver: '..FileVersion..'...";wait .3;text loading size '..FontSize..';text loading pos '..HUDposXColumn1..' '..HUDposYLine1..';text loading bg_transparency 1') --Loading
	send_command('wait '..LoadDelay..';gs c LoadHUD')
	--Create the Aftermath, Mode, Notifications, and Debuffs text objects and put them above the screen for now, we'll move them to the correct place next
	send_command('wait .1;text aftermath create "Aftermath: None";wait .3;text aftermath size '..FontSize..';text aftermath pos '..HUDposXColumn4..' -100;text aftermath color 255 50 50;text aftermath bg_transparency 1') --Aftermath
	send_command('wait .1;text mode create "Please select a Mode...";wait .3;text mode size '..FontSize..';text mode pos '..HUDposXColumn1..' -100;text mode color 255 50 50;text mode bg_transparency 1') --Mode
	send_command('wait .1;text notifications create "Hello, '..player.name..'! (type //fileinfo for more information)";wait .3;text notifications size '..FontSize..';text notifications pos '..HUDposXColumn1..' -100;text notifications bg_transparency 1') --Notifications
	send_command('wait .1;text debuffs create " ";wait .3;text debuffs size '..FontSize..';text debuffs pos '..HUDposXColumn4..' -100;text debuffs bg_transparency 1') --Debuffs
	--Create all the HUD Recast text objects and put them above the screen for now, we'll move them to the correct place next
	send_command('wait .2;text recastmode1c1 create "[ '..RecastMode1C1SH..' ]";wait .3;text recastmode1c1 size '..FontSize..';text recastmode1c1 pos '..HUDposXColumn1..' -100;text recastmode1c1 bg_transparency 1')--Mode 1, Column 1
	send_command('wait .2;text recastmode1c2 create "[ '..RecastMode1C2SH..' ]";wait .3;text recastmode1c2 size '..FontSize..';text recastmode1c2 pos '..HUDposXColumn2..' -100;text recastmode1c2 bg_transparency 1')--Mode 1, Column 2
	send_command('wait .2;text recastmode1c3 create "[ '..RecastMode1C3SH..' ]";wait .3;text recastmode1c3 size '..FontSize..';text recastmode1c3 pos '..HUDposXColumn3..' -100;text recastmode1c3 bg_transparency 1')--Mode 1, Column 3
	send_command('wait .2;text recastmode1c4 create "[ '..RecastMode1C4SH..' ]";wait .3;text recastmode1c4 size '..FontSize..';text recastmode1c4 pos '..HUDposXColumn4..' -100;text recastmode1c4 bg_transparency 1')--Mode 1, Column 4
	send_command('wait .2;text recastmode1c5 create "[ '..RecastMode1C5SH..' ]";wait .3;text recastmode1c5 size '..FontSize..';text recastmode1c5 pos '..HUDposXColumn5..' -100;text recastmode1c5 bg_transparency 1')--Mode 1, Column 5
	send_command('wait .2;text recastmode1c6 create "[ '..RecastMode1C6SH..' ]";wait .3;text recastmode1c6 size '..FontSize..';text recastmode1c6 pos '..HUDposXColumn6..' -100;text recastmode1c6 bg_transparency 1')--Mode 1, Column 6
	send_command('wait .2;text recastmode2c1 create "[ '..RecastMode2C1SH..' ]";wait .3;text recastmode2c1 size '..FontSize..';text recastmode2c1 pos '..HUDposXColumn1..' -100;text recastmode2c1 bg_transparency 1')--Mode 2, Column 1
	send_command('wait .2;text recastmode2c2 create "[ '..RecastMode2C2SH..' ]";wait .3;text recastmode2c2 size '..FontSize..';text recastmode2c2 pos '..HUDposXColumn2..' -100;text recastmode2c2 bg_transparency 1')--Mode 2, Column 2
	send_command('wait .2;text recastmode2c3 create "[ '..RecastMode2C3SH..' ]";wait .3;text recastmode2c3 size '..FontSize..';text recastmode2c3 pos '..HUDposXColumn3..' -100;text recastmode2c3 bg_transparency 1')--Mode 2, Column 3
	send_command('wait .2;text recastmode2c4 create "[ '..RecastMode2C4SH..' ]";wait .3;text recastmode2c4 size '..FontSize..';text recastmode2c4 pos '..HUDposXColumn4..' -100;text recastmode2c4 bg_transparency 1')--Mode 2, Column 4
	send_command('wait .2;text recastmode2c5 create "[ '..RecastMode2C5SH..' ]";wait .3;text recastmode2c5 size '..FontSize..';text recastmode2c5 pos '..HUDposXColumn5..' -100;text recastmode2c5 bg_transparency 1')--Mode 2, Column 5
	send_command('wait .2;text recastmode2c6 create "[ '..RecastMode2C6SH..' ]";wait .3;text recastmode2c6 size '..FontSize..';text recastmode2c6 pos '..HUDposXColumn6..' -100;text recastmode2c6 bg_transparency 1')--Mode 2, Column 6
	send_command('wait .2;text recastmode3c1 create "[ '..RecastMode3C1SH..' ]";wait .3;text recastmode3c1 size '..FontSize..';text recastmode3c1 pos '..HUDposXColumn1..' -100;text recastmode3c1 bg_transparency 1')--Mode 3, Column 1
	send_command('wait .2;text recastmode3c2 create "[ '..RecastMode3C2SH..' ]";wait .3;text recastmode3c2 size '..FontSize..';text recastmode3c2 pos '..HUDposXColumn2..' -100;text recastmode3c2 bg_transparency 1')--Mode 3, Column 2
	send_command('wait .2;text recastmode3c3 create "[ '..RecastMode3C3SH..' ]";wait .3;text recastmode3c3 size '..FontSize..';text recastmode3c3 pos '..HUDposXColumn3..' -100;text recastmode3c3 bg_transparency 1')--Mode 3, Column 3
	send_command('wait .2;text recastmode3c4 create "[ '..RecastMode3C4SH..' ]";wait .3;text recastmode3c4 size '..FontSize..';text recastmode3c4 pos '..HUDposXColumn4..' -100;text recastmode3c4 bg_transparency 1')--Mode 3, Column 4
	send_command('wait .2;text recastmode3c5 create "[ '..RecastMode3C5SH..' ]";wait .3;text recastmode3c5 size '..FontSize..';text recastmode3c5 pos '..HUDposXColumn5..' -100;text recastmode3c5 bg_transparency 1')--Mode 3, Column 5
	send_command('wait .2;text recastmode3c6 create "[ '..RecastMode3C6SH..' ]";wait .3;text recastmode3c6 size '..FontSize..';text recastmode3c6 pos '..HUDposXColumn6..' -100;text recastmode3c6 bg_transparency 1')--Mode 3, Column 6
	send_command('wait .2;text recastmode4c1 create "[ '..RecastMode4C1SH..' ]";wait .3;text recastmode4c1 size '..FontSize..';text recastmode4c1 pos '..HUDposXColumn1..' -100;text recastmode4c1 bg_transparency 1')--Mode 4, Column 1
	send_command('wait .2;text recastmode4c2 create "[ '..RecastMode4C2SH..' ]";wait .3;text recastmode4c2 size '..FontSize..';text recastmode4c2 pos '..HUDposXColumn2..' -100;text recastmode4c2 bg_transparency 1')--Mode 4, Column 2
	send_command('wait .2;text recastmode4c3 create "[ '..RecastMode4C3SH..' ]";wait .3;text recastmode4c3 size '..FontSize..';text recastmode4c3 pos '..HUDposXColumn3..' -100;text recastmode4c3 bg_transparency 1')--Mode 4, Column 3
	send_command('wait .2;text recastmode4c4 create "[ '..RecastMode4C4SH..' ]";wait .3;text recastmode4c4 size '..FontSize..';text recastmode4c4 pos '..HUDposXColumn4..' -100;text recastmode4c4 bg_transparency 1')--Mode 4, Column 4
	send_command('wait .2;text recastmode4c5 create "[ '..RecastMode4C5SH..' ]";wait .3;text recastmode4c5 size '..FontSize..';text recastmode4c5 pos '..HUDposXColumn5..' -100;text recastmode4c5 bg_transparency 1')--Mode 4, Column 5
	send_command('wait .2;text recastmode4c6 create "[ '..RecastMode4C6SH..' ]";wait .3;text recastmode4c6 size '..FontSize..';text recastmode4c6 pos '..HUDposXColumn6..' -100;text recastmode4c6 bg_transparency 1')--Mode 4, Column 6
else
	windower.add_to_chat(8,'Keys BLUE MAGE file ver: '..FileVersion..'')
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
send_command('alias Mode1 gs c Mode1') --creates Mode 1 alias
send_command('alias Mode2 gs c Mode2') --creates Mode 2 alias
send_command('alias Mode3 gs c Mode3') --creates Mode 3 alias
send_command('alias Mode4 gs c Mode4') --creates Mode 4 alias
send_command('bind ^'..DTCtrlPlus..' gs c DT') --creates the DT Override keyboard shortcut
send_command('alias dt gs c DT') --creates the DT Override and alias
if BLUAlert == 'On' then
	send_command('lua load blualert')
end
if Debug == 'On' then
	windower.add_to_chat(8,'[Debug Mode: On]')
end
LockstyleDelay = 3
AutoLockstyleRun = true

-------------------------------------------
--            SELF COMMANDS              --
-------------------------------------------

function self_command(command)
	if command == 'Mode1' then
		if HUD == 'On' then
			send_command('text mode text "Mode: '..Mode1Name..';text mode color '..Mode1color..'')
		else
			windower.add_to_chat(8,'Mode: '..Mode1Name..'')
		end
		choose_set()
		Mode = 'Mode1'
		SpellSetCooldown = 0
	elseif command == 'Mode2' then
		if HUD == 'On' then
			send_command('text mode text "Mode: '..Mode2Name..';text mode color '..Mode2color..'')
		else
			windower.add_to_chat(8,'Mode: '..Mode2Name..'')
		end
		choose_set()
		Mode = 'Mode2'
		SpellSetCooldown = 0
	elseif command == 'Mode3' then
		if HUD == 'On' then
			send_command('text mode text "Mode: '..Mode3Name..';text mode color '..Mode3color..'')
		else
			windower.add_to_chat(8,'Mode: '..Mode3Name..'')
		end
		choose_set()
		Mode = 'Mode3'
		SpellSetCooldown = 0
	elseif command == 'Mode4' then
		if HUD == 'On' then
			send_command('text mode text "Mode: '..Mode4Name..';text mode color '..Mode4color..'')
		else
			windower.add_to_chat(8,'Mode: '..Mode4Name..'')
		end
		choose_set()
		Mode = 'Mode4'
		SpellSetCooldown = 0
	elseif command == 'DT' then
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
			elseif player.status == "Engaged" and DTOverride == 'On' then
				send_command('text notifications text "Status: Engaged (DT Override)";text notifications color 255 255 255')
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
	elseif command == 'SpellSetCooldown' then
		SpellSetCooldown = 60
	elseif command == 'LoadHUD' then
		LoadHUD = true
		send_command('text loading hide')
		if HUDRecast == 'On' then --using the HUDRecast
			if player.equipment.main == 'Tizona' or player.equipment.main == 'Almace' or player.equipment.main == 'Sequence' then
				--if we have any REMAs equipped we place the Aftermath, Mode, Notifications, Debuff, and appropriate BG text objects into view
				send_command('wait .1;text bg2 pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .2;text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')
				send_command('wait .7;text aftermath pos '..HUDposXColumn4..' '..HUDposYLine2..'')
				send_command('wait .7;text mode pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .8;text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')
				send_command('wait .8;text debuffs pos '..HUDposXColumn4..' '..HUDposYLine3..'')
			else
				--if we do not have any REMAs equipped we move the Mode, Notifications, Debuffs, and appropriate BG text objects into view
				send_command('wait .1;text bg2 pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .2;text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')
				send_command('wait .7;text mode pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .8;text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')
				send_command('wait .8;text debuffs pos '..HUDposXColumn4..' '..HUDposYLine3..'')
			end
		else --not using the HUDRecast
			if player.equipment.main == 'Tizona' or player.equipment.main == 'Almace' or player.equipment.main == 'Sequence' then
				--if we have any REMAs equipped we place the Aftermath, Mode, Notifications, Debuff, and appropriate BG text objects into view
				send_command('wait .1;text bg2 pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .2;text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')
				send_command('wait .7;text aftermath pos '..HUDposXColumn4..' '..HUDposYLine1..'')
				send_command('wait .7;text mode pos '..HUDposXColumn1..' '..HUDposYLine1..'')
				send_command('wait .8;text notifications pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .8;text debuffs pos '..HUDposXColumn4..' '..HUDposYLine2..'')
			else
				--if we do not have any REMAs equipped we move the Mode, Notifications, Debuffs, and appropriate BG text objects into view
				send_command('wait .1;text bg2 pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .6;text mode pos '..HUDposXColumn1..' '..HUDposYLine1..'')
				send_command('wait .7;text notifications pos '..HUDposXColumn1..' '..HUDposYLine2..'')
				send_command('wait .7;text debuffs pos '..HUDposXColumn4..' '..HUDposYLine2..'')
			end
		end
	elseif command == 'Fileinfo' then
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(3,'-- Keys Gearswap lua file for Blue Mage --')
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
		windower.add_to_chat(3,'--                   NOTES                   --')
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(8,'Place both this file and the sounds folder')
		windower.add_to_chat(8,'inside the GearSwap data folder')
		windower.add_to_chat(200,'ex:     /addons/GearSwap/data/sounds/')
		windower.add_to_chat(200,'        /addons/GearSwap/data/BLU.lua')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'While not required, it is highly recommended to')
		windower.add_to_chat(8,'use the Azuresets windower plugin.')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'This file has 4 modes available to use,')
		windower.add_to_chat(8,'you do not need to use each one.')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'To switch into each mode, create a macro for')
		windower.add_to_chat(8,'each one you are using with the following')
		windower.add_to_chat(200,'        /console Mode#')
		windower.add_to_chat(8,'With # being 1-4 depending on which ones you are using')
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
		windower.add_to_chat(8,'Recommended Windower Addons: Azuresets, BLUAlert, Text')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(3,'--                 PRO TIPS                  --')
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(8,'1)Use macro page (set) 1 for your mode macros and a')
		windower.add_to_chat(8,'separate macro page for each mode. To move to a different')
		windower.add_to_chat(8,'macro page use the following in each mode macro')
		windower.add_to_chat(200,'        /macro set #')
		windower.add_to_chat(8,'With # being the number of the page for each mode. This')
		windower.add_to_chat(8,'will automatically switch to that book page at the same time.')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'2)If you use Azuresets, add the following to each macro')
		windower.add_to_chat(200,'        /console aset spellset nameofyourspellset')
		windower.add_to_chat(8,'This will automatically load each spellset at the same time.')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'For example, a macro to switch into Melee Mode might look like:')
		windower.add_to_chat(200,'        /console Mode2')
		windower.add_to_chat(200,'        /console aset spellset melee')
		windower.add_to_chat(200,'        /macro set 3')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'3)If you use Azuresets, you can integrate the cooldown')
		windower.add_to_chat(8,'timer into this file with a little bit of editing.')
		windower.add_to_chat(8,'Open the azuresets file:')
		windower.add_to_chat(200,'        /addons/azuresets/azuresets.lua')
		windower.add_to_chat(8,'and look for the following on lines 150 and 179:')
		windower.add_to_chat(200,'        windower.send_command(\'@timers c "Blue Magic Cooldown" 60 up\')')
		windower.add_to_chat(8,'Replace each of those two lines entirely with the following:')
		windower.add_to_chat(200,'        windower.send_command(\'gs c SpellSetCooldown\')')
		windower.add_to_chat(8,'Then save the file and reload it in game by typing:')
		windower.add_to_chat(200,'        //lua r azuresets')
		windower.add_to_chat(8,'into your chatlog directly.')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(3,'--                  Options                  --')
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(200,'AutoLockstyle: '..(''..AutoLockstyle..''):color(8)..'')
		windower.add_to_chat(200,'LockstyleBattle: '..(''..LockstyleBattle..''):color(8)..'')
		windower.add_to_chat(200,'LockstyleTown: '..(''..LockstyleTown..''):color(8)..'')
		windower.add_to_chat(200,'Book: '..(''..Book..''):color(8)..'')
		windower.add_to_chat(200,'Page: '..(''..Page..''):color(8)..'')
		windower.add_to_chat(200,'Chat: '..(''..Chat..''):color(8)..'')
		windower.add_to_chat(200,'CJTimer: '..(''..CJTimer..''):color(8)..'')
		windower.add_to_chat(200,'ALTimer: '..(''..ALTimer..''):color(8)..'')
		windower.add_to_chat(200,'UWTimer: '..(''..UWTimer..''):color(8)..'')
		windower.add_to_chat(200,'BLUAlert: '..(''..BLUAlert..''):color(8)..'')
		windower.add_to_chat(200,'DTCtrlPlus: '..(''..DTCtrlPlus..''):color(8)..'')
		windower.add_to_chat(200,'ZoneGear: '..(''..ZoneGear..''):color(8)..'')
		windower.add_to_chat(200,'AlertSounds: '..(''..AlertSounds..''):color(8)..'')
		windower.add_to_chat(200,'UseEcho: '..(''..UseEcho..''):color(8)..'')
		windower.add_to_chat(200,'OccShadows: '..(''..OccShadows..''):color(8)..'')
		windower.add_to_chat(200,'CharmNaked: '..(''..CharmNaked..''):color(8)..'')
		windower.add_to_chat(200,' ')
		windower.add_to_chat(3,'-- Heads Up Display --')
		windower.add_to_chat(200,'HUD: '..(''..HUD..''):color(8)..'')
		windower.add_to_chat(200,'HUDposX: '..(''..HUDposX..''):color(8)..'')
		windower.add_to_chat(200,'HUDposYLine1: '..(''..HUDposYLine1..''):color(8)..'')
		windower.add_to_chat(200,'FontSize: '..(''..FontSize..''):color(8)..'')
		windower.add_to_chat(200,'LineSpacer: '..(''..LineSpacer..''):color(8)..'')
		windower.add_to_chat(200,'ColumnSpacer: '..(''..ColumnSpacer..''):color(8)..'')
		windower.add_to_chat(200,'HUDRecast: '..(''..HUDRecast..''):color(8)..'')
		windower.add_to_chat(3,'--HUD Mode Names')
		windower.add_to_chat(200,'Mode1Name: '..(''..Mode1Name..''):color(8)..'')
		windower.add_to_chat(200,'Mode2Name: '..(''..Mode2Name..''):color(8)..'')
		windower.add_to_chat(200,'Mode3Name: '..(''..Mode3Name..''):color(8)..'')
		windower.add_to_chat(200,'Mode4Name: '..(''..Mode4Name..''):color(8)..'')
		windower.add_to_chat(3,'--HUD Recast Spells')
		windower.add_to_chat(3,'--Mode 1')
		windower.add_to_chat(200,'RecastMode1C1: '..(''..RecastMode1C1..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode1C1SH: '..(''..RecastMode1C1SH..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode1C2: '..(''..RecastMode1C2..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode1C2SH: '..(''..RecastMode1C2SH..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode1C3: '..(''..RecastMode1C3..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode1C3SH: '..(''..RecastMode1C3SH..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode1C4: '..(''..RecastMode1C4..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode1C4SH: '..(''..RecastMode1C4SH..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode1C5: '..(''..RecastMode1C5..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode1C5SH: '..(''..RecastMode1C5SH..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode1C6: '..(''..RecastMode1C6..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode1C6SH: '..(''..RecastMode1C6SH..''):color(8)..'')
		windower.add_to_chat(3,'--Mode 2')
		windower.add_to_chat(200,'RecastMode2C1: '..(''..RecastMode2C1..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode2C1SH: '..(''..RecastMode2C2SH..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode2C2: '..(''..RecastMode2C2..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode2C2SH: '..(''..RecastMode2C3SH..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode2C3: '..(''..RecastMode2C3..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode2C3SH: '..(''..RecastMode2C4SH..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode2C4: '..(''..RecastMode2C1..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode2C4SH: '..(''..RecastMode2C4SH..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode2C5: '..(''..RecastMode2C5..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode2C5SH: '..(''..RecastMode2C5SH..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode2C6: '..(''..RecastMode2C6..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode2C6SH: '..(''..RecastMode2C6SH..''):color(8)..'')
		windower.add_to_chat(3,'--Mode 3')
		windower.add_to_chat(200,'RecastMode3C1: '..(''..RecastMode3C1..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode3C1SH: '..(''..RecastMode3C1SH..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode3C2: '..(''..RecastMode3C2..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode3C2SH: '..(''..RecastMode3C2SH..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode3C3: '..(''..RecastMode3C3..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode3C3SH: '..(''..RecastMode3C3SH..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode3C4: '..(''..RecastMode3C4..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode3C4SH: '..(''..RecastMode3C4SH..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode3C5: '..(''..RecastMode3C5..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode3C5SH: '..(''..RecastMode3C5SH..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode3C6: '..(''..RecastMode3C6..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode3C6SH: '..(''..RecastMode3C6SH..''):color(8)..'')
		windower.add_to_chat(3,'--Mode 4')
		windower.add_to_chat(200,'RecastMode4C1: '..(''..RecastMode4C1..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode4C1SH: '..(''..RecastMode4C1SH..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode4C2: '..(''..RecastMode4C2..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode4C2SH: '..(''..RecastMode4C2SH..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode4C3: '..(''..RecastMode4C3..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode4C3SH: '..(''..RecastMode4C3SH..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode4C4: '..(''..RecastMode4C4..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode4C4SH: '..(''..RecastMode4C4SH..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode4C5: '..(''..RecastMode4C5..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode4C5SH: '..(''..RecastMode4C5SH..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode4C6: '..(''..RecastMode4C6..''):color(8)..'')
		windower.add_to_chat(200,'RecastMode4C6SH: '..(''..RecastMode4C6SH..''):color(8)..'')
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
		windower.add_to_chat(200,'NotiTime: '..(''..NotiTime..''):color(8)..'')
		windower.add_to_chat(200,'NotiOmen: '..(''..NotiOmen..''):color(8)..'')
		windower.add_to_chat(200,'NotiVagary: '..(''..NotiVagary..''):color(8)..'')
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
		windower.add_to_chat(200,'Mode1color: '..(''..Mode1color..''):color(8)..'')
		windower.add_to_chat(200,'Mode2color: '..(''..Mode2color..''):color(8)..'')
		windower.add_to_chat(200,'Mode3color: '..(''..Mode3color..''):color(8)..'')
		windower.add_to_chat(200,'Mode4color: '..(''..Mode4color..''):color(8)..'')
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
	elseif command == 'Lockstyle' and LockstyleDelay == 0 then
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
	if player.status == "Resting" then
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
		if DTOverride == 'On' then
			equip(set_combine(sets.rest, sets.dtoverride))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Rest + DT Override]')
			end
		else
			equip(sets.rest)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Rest]')
			end
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
			equip(set_combine(sets.idle, sets.adoulin))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Idle + Adoulin]')
			end
		elseif BastokZones:contains(world.area) then
			equip(set_combine(sets.idle, sets.bastok))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Idle + Bastok]')
			end
		elseif SandyZones:contains(world.area) then
			equip(set_combine(sets.idle, sets.sandoria))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Idle + San d\'Oria]')
			end
		elseif WindyZones:contains(world.area) then
			equip(set_combine(sets.idle, sets.windurst))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Idle + Windurst]')
			end
		elseif TownZones:contains(world.area) then
			equip(set_combine(sets.idle, sets.town))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Idle + Town]')
			end
		else
			if DTOverride == "On" then
				equip(set_combine(sets.idle, sets.dtoverride))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: DT Override + Idle]')
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
		elseif spell.english == 'Expiacion' then
			equip(sets.exp)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Expiacion + Weapon Skill]')
			end
		else
			equip(sets.ws)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Weapon Skill]')
			end
		end
	elseif spell.english == 'Azure Lore' then
		equip(sets.azurelore)
		if ALTimer == 'On' then
			--these pieces extend Azure Lore by 10 seconds so we adjust accordingly
			if player.equipment.hands == 'Mirage Bazubands +2' or player.equipment.hands == 'Luhlaza Bazubands' or player.equipment.hands == 'Luhlaza Bazubands +1' or player.equipment.hands == 'Luhlaza Bazubands +2' or player.equipment.hands == 'Luhlaza Bazubands +3' then
				send_command('input /echo [Azure Lore] 40 seconds;wait 10;input /echo [Azure Lore] 30 seconds;wait 10;input /echo [Azure Lore] 20 seconds;wait 10;input /echo [Azure Lore] 10 seconds')
			else
				send_command('input /echo [Azure Lore] 30 seconds;wait 10;input /echo [Azure Lore] 20 seconds;wait 10;input /echo [Azure Lore] 10 seconds')
			end
		end
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Azure Lore]')
		end
	elseif spell.english == 'Unbridled Wisdom' and UWTimer == 'On' then
		send_command('input /echo [Unbridled Wisdom] 60 seconds;wait 31;input /echo [Unbridled Wisdom] 30 seconds;wait 20;input /echo [Unbridled Wisdom] 10 seconds')
	elseif spell.english == 'Chain Affinity' then
		if windower.ffxi.get_ability_recasts()[181] <= 1 then
			equip(sets.chainaffinity)
		end
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Chain Affinity]')
		end
	elseif spell.english == 'Burst Affinity' then
		if windower.ffxi.get_ability_recasts()[182] <= 1 then
			equip(sets.burstaffinity)
		end
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Burst Affinity]')
		end
	elseif spell.english == 'Diffusion' then
		if windower.ffxi.get_ability_recasts()[184] <= 1 then
			equip(sets.diffusion)
		end
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Diffusion]')
		end
	elseif spell.english == 'Efflux' then
		if windower.ffxi.get_ability_recasts()[185] <= 1 then
			equip(sets.efflux)
		end
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Efflux]')
		end
	elseif spell.english == 'Holy Water' then
		equip(sets.hwater)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Holy Water]')
		end
	elseif (spell.english == 'Spectral Jig' or spell.english == 'Sneak' or spell.english == 'Monomi: Ichi' or spell.english == 'Monomi: Ni') and buffactive['Sneak'] and spell.target.type == 'SELF' then
		send_command('cancel 71')
	elseif spell.english == 'Fire' or spell.english == 'Blizzard' or spell.english == 'Aero' or spell.english == 'Stone' or spell.english == 'Thunder' or spell.english == 'Water' then
		equip(sets.magical)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Magical]')
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
	if spell.skill == 'Blue Magic' then
		if Physical:contains(spell.english) then
			equip(sets.physical)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Physical]')
			end
			if buffactive['Chain Affinity'] then
				equip(sets.chainaffinity)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Physical + Chain Affinity]')
				end
			end
			if buffactive['Efflux'] then
				equip(sets.efflux)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Physical + Efflux]')
				end
			end
		elseif Magical:contains(spell.english) then
			equip(sets.magical)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Magical]')
			end
			if buffactive['Burst Affinity'] then
				equip(sets.burstaffinity)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Magical + Burst Affinity]')
				end
			end
		elseif Earth:contains(spell.english) then
			equip(sets.magical.earth)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Earth]')
			end
			if buffactive['Burst Affinity'] then
				equip(sets.burstaffinity)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Earth + Burst Affinity]')
				end
			end
		elseif Dark:contains(spell.english) then
			equip(sets.dark)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Dark]')
			end
			if buffactive['Burst Affinity'] then
				equip(sets.burstaffinity)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Dark + Burst Affinity]')
				end
			end
		elseif MagicAccuracy:contains(spell.english) then
			equip(sets.magicaccuracy)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Magic Accuracy]')
			end
		elseif Breath:contains(spell.english) then
			equip(sets.breath)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Breath]')
			end
		elseif Buff:contains(spell.english) then
			if buffactive['Diffusion'] then
				equip(set_combine(sets.buff, sets.diffusion))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Buff + Diffusion]')
				end
			else
				equip(sets.buff)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Buff]')
				end
			end
		elseif BlueMagicSkill:contains(spell.english) then
			equip(set_combine(sets.buff, sets.bluemagicskill))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Blue Magic Skill + Buff]')
			end
		elseif Healing:contains(spell.english) then
			equip(set_combine(sets.buff, sets.healing))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Buff + Healing]')
			end
		elseif spell.english == 'White Wind' then
			equip(sets.whitewind)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: White Wind]')
			end
		elseif spell.english == 'Battery Charge' then
			if buffactive['Diffusion'] then
				equip(set_combine(sets.buff, sets.battery, sets.diffusion))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Battery + Diffusion]')
				end
			else
				equip(set_combine(sets.buff, sets.battery))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Battery + Buff]')
				end
			end
		end
	elseif spell.skill == 'Elemental Magic' and not (spell.english == 'Fire' or spell.english == 'Blizzard' or spell.english == 'Aero' or spell.english == 'Stone' or spell.english == 'Thunder' or spell.english == 'Water') then
		equip(sets.magical)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Magical]')
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
	end
end

-------------------------------------------
--              AFTERCAST                --
-------------------------------------------

function aftercast(spell)
	choose_set()
	if spell.type == 'WeaponSkill' and not spell.interrupted and HUD == 'On' and NotiTPReturn == 'On' then
		send_command('wait '..TPReturnWait..';gs c TPReturn')
	elseif spell.english == 'Cruel Joke' and CJTimer ~= 'Off' and not spell.interrupted then
		if CJTimer == 'p' then
			send_command('input /p [Cruel Joke] 60 seconds;wait 31;input /p [Cruel Joke] 30 seconds;wait 20;input /p [Cruel Joke] 10 seconds')
		elseif CJTimer == 'e' then
			send_command('input /echo [Cruel Joke] 60 seconds;wait 31;input /echo [Cruel Joke] 30 seconds;wait 20;input /echo [Cruel Joke] 10 seconds')
		end
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
	if spell.english == 'Occultation' and not spell.interrupted then 
		ShadowCount = OccShadows
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
		send_command('text bg1 hide;text bg2 hide;text bg3 hide;text recastmode1c1 hide;text recastmode1c2 hide;text recastmode1c3 hide;text recastmode1c4 hide;text recastmode1c5 hide;text recastmode1c6 hide;text recastmode2c1 hide;text recastmode2c2 hide;text recastmode2c3 hide;text recastmode2c4 hide;text recastmode2c5 hide;text recastmode2c6 hide;text recastmode3c1 hide;text recastmode3c2 hide;text recastmode3c3 hide;text recastmode3c4 hide;text recastmode3c5 hide;text recastmode3c6 hide;text recastmode4c1 hide;text recastmode4c2 hide;text recastmode4c3 hide;text recastmode4c4 hide;text recastmode4c5 hide;text recastmode4c6 hide;text mode hide;text notifications hide;text debuffs hide;text aftermath hide')
    elseif status ~= 4  and HUD == 'On' and ShowHUD == false then --Out of cutscene: SHow the HUD
		ShowHUD = true
		send_command('text bg1 show;text bg2 show;text bg3 show;text recastmode1c1 show;text recastmode1c2 show;text recastmode1c3 show;text recastmode1c4 show;text recastmode1c5 show;text recastmode1c6 show;text recastmode2c1 show;text recastmode2c2 show;text recastmode2c3 show;text recastmode2c4 show;text recastmode2c5 show;text recastmode2c6 show;text recastmode3c1 show;text recastmode3c2 show;text recastmode3c3 show;text recastmode3c4 show;text recastmode3c5 show;text recastmode3c6 show;text recastmode4c1 show;text recastmode4c2 show;text recastmode4c3 show;text recastmode4c4 show;text recastmode4c5 show;text recastmode4c6 show;text mode show;text notifications show;text debuffs show;text aftermath show')
    end
end)

-- windower.register_event('incoming chunk',function(id,original,modified,injected,blocked)
	-- if id == 0xB and HUD == 'On' and ShowHUD == true then --Start Zoning: Hide the HUD
        -- ShowHUD = false
		-- send_command('text bg1 hide;text bg2 hide;text bg3 hide;text recastmode1c1 hide;text recastmode1c2 hide;text recastmode1c3 hide;text recastmode1c4 hide;text recastmode1c5 hide;text recastmode1c6 hide;text recastmode2c1 hide;text recastmode2c2 hide;text recastmode2c3 hide;text recastmode2c4 hide;text recastmode2c5 hide;text recastmode2c6 hide;text recastmode3c1 hide;text recastmode3c2 hide;text recastmode3c3 hide;text recastmode3c4 hide;text recastmode3c5 hide;text recastmode3c6 hide;text recastmode4c1 hide;text recastmode4c2 hide;text recastmode4c3 hide;text recastmode4c4 hide;text recastmode4c5 hide;text recastmode4c6 hide;text mode hide;text notifications hide;text debuffs hide;text aftermath hide')
    -- elseif id == 0xA and HUD == 'On' and ShowHUD == false then --Finish Zoning: Show the HUD
		-- ShowHUD = true
		-- send_command('wait 3;text bg1 show;text bg2 show;text bg3 show;text recastmode1c1 show;text recastmode1c2 show;text recastmode1c3 show;text recastmode1c4 show;text recastmode1c5 show;text recastmode1c6 show;text recastmode2c1 show;text recastmode2c2 show;text recastmode2c3 show;text recastmode2c4 show;text recastmode2c5 show;text recastmode2c6 show;text recastmode3c1 show;text recastmode3c2 show;text recastmode3c3 show;text recastmode3c4 show;text recastmode3c5 show;text recastmode3c6 show;text recastmode4c1 show;text recastmode4c2 show;text recastmode4c3 show;text recastmode4c4 show;text recastmode4c5 show;text recastmode4c6 show;text mode show;text notifications show;text debuffs show;text aftermath show')
    -- end
-- end)

-------------------------------------------
--       Buff/Debuff Notifications       --
-------------------------------------------

windower.register_event('gain buff', function(buff)
	if buff == 270 and NotiAftermath =='On' then --Aftermath: Lv. 1
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/AftermathOn.wav')
		end
		if player.equipment.main == 'Tizona' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 1 (Accuracy)";text aftermath color '..Aftermath1color..'')
			else
				windower.add_to_chat(220,'<< Aftermath: Level 1 (Accuracy) >>')
			end
		elseif player.equipment.main == 'Almace' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 1 (30% Triple Damage)";text aftermath color '..Aftermath1color..'')
			else
				windower.add_to_chat(220,'<< Aftermath: Level 1 (30% Triple Damage) >>')
			end
		elseif player.equipment.main == 'Sequence' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 1 (4-Step Ultimate)";text aftermath color '..Aftermath1color..'')
			else
				windower.add_to_chat(220,'<< Aftermath: Level 1 (4-Step Ultimate) >>')
			end
		end
	elseif buff == 271 and NotiAftermath == 'On' then --Aftermath: Lv. 2
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/AftermathOn.wav')
		end
		if player.equipment.main == 'Tizona' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 2 (Magic Accuracy)";text aftermath color '..Aftermath2color..'')
			else
				windower.add_to_chat(204,'<< Aftermath: Level 2 (Magic Accuracy) >>')
			end
		elseif player.equipment.main == 'Almace' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 2 (40% Triple Damage)";text aftermath color '..Aftermath2color..'')
			else
				windower.add_to_chat(204,'<< Aftermath: Level 2 (40% Triple Damage) >>')
			end
		elseif player.equipment.main == 'Sequence' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 2 (3-Step Ultimate)";text aftermath color '..Aftermath2color..'')
			else
				windower.add_to_chat(204,'<< Aftermath: Level 2 (3-Step Ultimate) >>')
			end
		end
	elseif buff == 272 and NotiAftermath == 'On' then --Aftermath: Lv. 3
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/AftermathOn.wav')
		end
		if player.equipment.main == 'Tizona' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 3 (Occ. Att. 2-3x)";text aftermath color '..Aftermath3color..'')
			else
				windower.add_to_chat(50,'<< Aftermath: Level 3 (Occ. Att. 2-3x) >>')
			end
		elseif player.equipment.main == 'Almace' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 3 (50% Triple Damage)";text aftermath color '..Aftermath3color..'')
			else
				windower.add_to_chat(50,'<< Aftermath: Level 3 (50% Triple Damage) >>')
			end
		elseif player.equipment.main == 'Sequence' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 3 (2-Step Ultimate)";text aftermath color '..Aftermath3color..'')
			else
				windower.add_to_chat(50,'<< Aftermath: Level 3 (2-Step Ultimate) >>')
			end
		end
	end
	if (buff == 2 or buff == 19) then --If we get put to sleep,
		if buffactive['Stoneskin'] and (buffactive['Poison'] or buffactive['Dia'] or buffactive['bio'] or buffactive['Shock'] or buffactive['Rasp'] or buffactive['Choke'] or buffactive['Frost'] or buffactive['Burn'] or buffactive['Drown'] or buffactive['Requiem'] or buffactive['Kaustra'] or buffactive['Helix']) then --first check and remove stoneskin if its up and we're DOT'd
			send_command('cancel 37')
		else
			equip(set_combine({neck="Opo-opo Necklace"}, sets.dtoverride)) --otherwise, equip the DT Override set and the Opo-opo Necklace for free TP
		end
	end
	if buff == 7 or Buff == 10 or buff == 28 then --If we get petrified, stunned, or terrored, then equip the DT Override set
		equip(sets.dtoverride)
	end
	if buff == 15 and AlertSounds == 'On' then --Doom
		windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
	end
	if buff == 17 then --Charm
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		if CharmNaked == 'Yes' then
			equip({head=empty, body=empty, hands=empty, legs=empty, feet=empty, neck=empty, waist=empty, left_ear=empty, right_ear=empty, left_ring=empty, right_ring=empty, back=empty})
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
	elseif buff == 0 and HUD == 'On' then
		send_command('text notifications text "Status: Alive ^_^";text notifications color 75 255 75')
	elseif buff == 1 then --Weakness
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« Weakness Has Worn Off »»";text notifications color 75 255 75')
		end
	elseif buff == 2 or buff == 19 or buff == 7 or buff == 17 then --lose sleep, petrify, or charm run choose_set since we chenged gear for those
		choose_set()
	elseif buff == 36 then --lose blink, clear shadow count to 0
		ShadowCount = 0
	end
end)

windower.register_event('tp change',function()
	if player.tp == 3000 and Noti3000TP == 'On' then
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
			if SpellSetCooldown > 0 then
				SpellSetCooldown = SpellSetCooldown - 1
				if SpellSetCooldown == 0 then
					if Mode == 'Mode1' then
						send_command('text mode text "Mode: '..Mode1Name..' (Spells ready!)";wait 5;text mode text "Mode: '..Mode1Name..'"')
					elseif Mode == 'Mode2' then
						send_command('text mode text "Mode: '..Mode2Name..' (Spells ready!)";wait 5;text mode text "Mode: '..Mode2Name..'"')
					elseif Mode == 'Mode3' then
						send_command('text mode text "Mode: '..Mode3Name..' (Spells ready!)";wait 5;text mode text "Mode: '..Mode3Name..'"')
					elseif Mode == 'Mode4' then
						send_command('text mode text "Mode: '..Mode4Name..' (Spells ready!)";wait 5;text mode text "Mode: '..Mode4Name..'"')
					end
					if AlertSounds == 'On' then
						windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav')
					end
				elseif Mode == 'Mode1' then
					send_command('text mode text "Mode: '..Mode1Name..' (Cooldown: '..SpellSetCooldown..')"')
				elseif Mode == 'Mode2' then
					send_command('text mode text "Mode: '..Mode2Name..' (Cooldown: '..SpellSetCooldown..')"')
				elseif Mode == 'Mode3' then
					send_command('text mode text "Mode: '..Mode3Name..' (Cooldown: '..SpellSetCooldown..')"')
				elseif Mode == 'Mode4' then
					send_command('text mode text "Mode: '..Mode4Name..' (Cooldown: '..SpellSetCooldown..')"')
				end
			end
			if NotiDoom == 'On' and buffactive['Doom'] then 
				send_command('text debuffs text "«« DOOM »»";text debuffs bg_transparency 200;text debuffs color 0 0 0;text debuffs bg_color 255 255 255;wait .5;text debuffs bg_color 255 204 51')
			end
			if RecastMode1C1 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode1c1 text ['..RecastMode1C1SH..'~'..ShadowCount..']')
				else send_command('text recastmode1c1 text [ '..RecastMode1C1SH..' ]') end end
			if RecastMode1C2 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode1c2 text ['..RecastMode1C2SH..'~'..ShadowCount..']')
				else send_command('text recastmode1c2 text [ '..RecastMode1C2SH..' ]') end end
			if RecastMode1C3 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode1c3 text ['..RecastMode1C3SH..'~'..ShadowCount..']')
				else send_command('text recastmode1c3 text [ '..RecastMode1C3SH..' ]') end end
			if RecastMode1C4 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode1c4 text ['..RecastMode1C4SH..'~'..ShadowCount..']')
				else send_command('text recastmode1c4 text [ '..RecastMode1C4SH..' ]') end end
			if RecastMode1C5 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode1c5 text ['..RecastMode1C5SH..'~'..ShadowCount..']')
				else send_command('text recastmode1c5 text [ '..RecastMode1C5SH..' ]') end end
			if RecastMode1C6 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode1c6 text ['..RecastMode1C6SH..'~'..ShadowCount..']')
				else send_command('text recastmode1c6 text [ '..RecastMode1C6SH..' ]') end end
			if RecastMode2C1 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode2c1 text ['..RecastMode2C1SH..'~'..ShadowCount..']')
				else send_command('text recastmode2c1 text [ '..RecastMode2C1SH..' ]') end end
			if RecastMode2C2 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode2c2 text ['..RecastMode2C2SH..'~'..ShadowCount..']')
				else send_command('text recastmode2c2 text [ '..RecastMode2C2SH..' ]') end end
			if RecastMode2C3 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode2c3 text ['..RecastMode2C3SH..'~'..ShadowCount..']')
				else send_command('text recastmode2c3 text [ '..RecastMode2C3SH..' ]') end end
			if RecastMode2C4 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode2c4 text ['..RecastMode2C4SH..'~'..ShadowCount..']')
				else send_command('text recastmode2c4 text [ '..RecastMode2C4SH..' ]') end end
			if RecastMode2C5 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode2c5 text ['..RecastMode2C5SH..'~'..ShadowCount..']')
				else send_command('text recastmode2c5 text [ '..RecastMode2C5SH..' ]') end end
			if RecastMode2C6 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode2c6 text ['..RecastMode2C6SH..'~'..ShadowCount..']')
				else send_command('text recastmode2c6 text [ '..RecastMode2C6SH..' ]') end end
			if RecastMode3C1 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode3c1 text ['..RecastMode3C1SH..'~'..ShadowCount..']')
				else send_command('text recastmode3c1 text [ '..RecastMode3C1SH..' ]') end end
			if RecastMode3C2 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode3c2 text ['..RecastMode3C2SH..'~'..ShadowCount..']')
				else send_command('text recastmode3c2 text [ '..RecastMode3C2SH..' ]') end end
			if RecastMode3C3 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode3c3 text ['..RecastMode3C3SH..'~'..ShadowCount..']')
				else send_command('text recastmode3c3 text [ '..RecastMode3C3SH..' ]') end end
			if RecastMode3C4 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode3c4 text ['..RecastMode3C4SH..'~'..ShadowCount..']')
				else send_command('text recastmode3c4 text [ '..RecastMode3C4SH..' ]') end end
			if RecastMode3C5 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode3c5 text ['..RecastMode3C5SH..'~'..ShadowCount..']')
				else send_command('text recastmode3c5 text [ '..RecastMode3C5SH..' ]') end end
			if RecastMode3C6 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode3c6 text ['..RecastMode3C6SH..'~'..ShadowCount..']')
				else send_command('text recastmode3c6 text [ '..RecastMode3C6SH..' ]') end end
			if RecastMode4C1 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode4c1 text ['..RecastMode4C1SH..'~'..ShadowCount..']')
				else send_command('text recastmode4c1 text [ '..RecastMode4C1SH..' ]') end end
			if RecastMode4C2 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode4c2 text ['..RecastMode4C2SH..'~'..ShadowCount..']')
				else send_command('text recastmode4c2 text [ '..RecastMode4C2SH..' ]') end end
			if RecastMode4C3 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode4c3 text ['..RecastMode4C3SH..'~'..ShadowCount..']')
				else send_command('text recastmode4c3 text [ '..RecastMode4C3SH..' ]') end end
			if RecastMode4C4 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode4c4 text ['..RecastMode4C4SH..'~'..ShadowCount..']')
				else send_command('text recastmode4c4 text [ '..RecastMode4C4SH..' ]') end end
			if RecastMode4C5 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode4c5 text ['..RecastMode4C5SH..'~'..ShadowCount..']')
				else send_command('text recastmode4c5 text [ '..RecastMode4C5SH..' ]') end end
			if RecastMode4C6 == 'Occultation' then
				if ShadowCount > 0 then send_command('text recastmode4c6 text ['..RecastMode4C6SH..'~'..ShadowCount..']')
				else send_command('text recastmode4c6 text [ '..RecastMode4C6SH..' ]') end end
			if HUDRecast == 'On' then --using the HUDRecast
				--Moving text object to their appropriate places
				if Mode == 'NONE' then
					send_command('text recastmode1c1 pos '..HUDposXColumn1..' -100')--Mode 1, Column 1
					send_command('text recastmode1c2 pos '..HUDposXColumn2..' -100')--Mode 1, Column 2
					send_command('text recastmode1c3 pos '..HUDposXColumn3..' -100')--Mode 1, Column 3
					send_command('text recastmode1c4 pos '..HUDposXColumn4..' -100')--Mode 1, Column 4
					send_command('text recastmode1c5 pos '..HUDposXColumn5..' -100')--Mode 1, Column 5
					send_command('text recastmode1c6 pos '..HUDposXColumn6..' -100')--Mode 1, Column 6
					send_command('text recastmode2c1 pos '..HUDposXColumn1..' -100')--Mode 2, Column 1
					send_command('text recastmode2c2 pos '..HUDposXColumn2..' -100')--Mode 2, Column 2
					send_command('text recastmode2c3 pos '..HUDposXColumn3..' -100')--Mode 2, Column 3
					send_command('text recastmode2c4 pos '..HUDposXColumn4..' -100')--Mode 2, Column 4
					send_command('text recastmode2c5 pos '..HUDposXColumn5..' -100')--Mode 2, Column 5
					send_command('text recastmode2c6 pos '..HUDposXColumn6..' -100')--Mode 2, Column 6
					send_command('text recastmode3c1 pos '..HUDposXColumn1..' -100')--Mode 3, Column 1
					send_command('text recastmode3c2 pos '..HUDposXColumn2..' -100')--Mode 3, Column 2
					send_command('text recastmode3c3 pos '..HUDposXColumn3..' -100')--Mode 3, Column 3
					send_command('text recastmode3c4 pos '..HUDposXColumn4..' -100')--Mode 3, Column 4
					send_command('text recastmode3c5 pos '..HUDposXColumn5..' -100')--Mode 3, Column 5
					send_command('text recastmode3c6 pos '..HUDposXColumn6..' -100')--Mode 3, Column 6
					send_command('text recastmode4c1 pos '..HUDposXColumn1..' -100')--Mode 4, Column 1
					send_command('text recastmode4c2 pos '..HUDposXColumn2..' -100')--Mode 4, Column 2
					send_command('text recastmode4c3 pos '..HUDposXColumn3..' -100')--Mode 4, Column 3
					send_command('text recastmode4c4 pos '..HUDposXColumn4..' -100')--Mode 4, Column 4
					send_command('text recastmode4c5 pos '..HUDposXColumn5..' -100')--Mode 4, Column 5
					send_command('text recastmode4c6 pos '..HUDposXColumn6..' -100')--Mode 4, Column 6
				elseif Mode == 'Mode1' then
					if RecastMode1C1 == 'NONE' then
						send_command('text recastmode1c1 pos '..HUDposXColumn1..' -100')--Not visible if NONE
					else
						send_command('text recastmode1c1 pos '..HUDposXColumn1..' '..HUDposYLine1..'')--Column 1
					end
					if RecastMode1C2 == 'NONE' then
						send_command('text recastmode1c2 pos '..HUDposXColumn2..' -100')--Not visible if NONE
					else
						send_command('text recastmode1c2 pos '..HUDposXColumn2..' '..HUDposYLine1..'')--Column 2
					end
					if RecastMode1C3 == 'NONE' then
						send_command('text recastmode1c3 pos '..HUDposXColumn3..' -100')--Not visible if NONE
					else
						send_command('text recastmode1c3 pos '..HUDposXColumn3..' '..HUDposYLine1..'')--Column 3
					end
					if RecastMode1C4 == 'NONE' then
						send_command('text recastmode1c4 pos '..HUDposXColumn4..' -100')--Not visible if NONE
					else
						send_command('text recastmode1c4 pos '..HUDposXColumn4..' '..HUDposYLine1..'')--Column 4
					end
					if RecastMode1C5 == 'NONE' then
						send_command('text recastmode1c5 pos '..HUDposXColumn5..' -100')--Not visible if NONE
					else
						send_command('text recastmode1c5 pos '..HUDposXColumn5..' '..HUDposYLine1..'')--Column 5
					end
					if RecastMode1C6 == 'NONE' then
						send_command('text recastmode1c6 pos '..HUDposXColumn6..' -100')--Not visible if NONE
					else
						send_command('text recastmode1c6 pos '..HUDposXColumn6..' '..HUDposYLine1..'')--Column 6
					end
					send_command('text recastmode2c1 pos '..HUDposXColumn1..' -100')--Column 1
					send_command('text recastmode2c2 pos '..HUDposXColumn2..' -100')--Column 2
					send_command('text recastmode2c3 pos '..HUDposXColumn3..' -100')--Column 3
					send_command('text recastmode2c4 pos '..HUDposXColumn4..' -100')--Column 4
					send_command('text recastmode2c5 pos '..HUDposXColumn5..' -100')--Column 5
					send_command('text recastmode2c6 pos '..HUDposXColumn6..' -100')--Column 6
					send_command('text recastmode3c1 pos '..HUDposXColumn1..' -100')--Column 1
					send_command('text recastmode3c2 pos '..HUDposXColumn2..' -100')--Column 2
					send_command('text recastmode3c3 pos '..HUDposXColumn3..' -100')--Column 3
					send_command('text recastmode3c4 pos '..HUDposXColumn4..' -100')--Column 4
					send_command('text recastmode3c5 pos '..HUDposXColumn5..' -100')--Column 5
					send_command('text recastmode3c6 pos '..HUDposXColumn6..' -100')--Column 6
					send_command('text recastmode4c1 pos '..HUDposXColumn1..' -100')--Column 1
					send_command('text recastmode4c2 pos '..HUDposXColumn2..' -100')--Column 2
					send_command('text recastmode4c3 pos '..HUDposXColumn3..' -100')--Column 3
					send_command('text recastmode4c4 pos '..HUDposXColumn4..' -100')--Column 4
					send_command('text recastmode4c5 pos '..HUDposXColumn5..' -100')--Column 5
					send_command('text recastmode4c6 pos '..HUDposXColumn6..' -100')--Column 6
				elseif Mode == 'Mode2' then
					send_command('text recastmode1c1 pos '..HUDposXColumn1..' -100')--Column 1
					send_command('text recastmode1c2 pos '..HUDposXColumn2..' -100')--Column 2
					send_command('text recastmode1c3 pos '..HUDposXColumn3..' -100')--Column 3
					send_command('text recastmode1c4 pos '..HUDposXColumn4..' -100')--Column 4
					send_command('text recastmode1c5 pos '..HUDposXColumn5..' -100')--Column 5
					send_command('text recastmode1c6 pos '..HUDposXColumn6..' -100')--Column 6
					if RecastMode2C1 == 'NONE' then
						send_command('text recastmode2c1 pos '..HUDposXColumn1..' -100')--Not visible if NONE
					else
						send_command('text recastmode2c1 pos '..HUDposXColumn1..' '..HUDposYLine1..'')--Column 1
					end
					if RecastMode2C2 == 'NONE' then
						send_command('text recastmode2c2 pos '..HUDposXColumn2..' -100')--Not visible if NONE
					else
						send_command('text recastmode2c2 pos '..HUDposXColumn2..' '..HUDposYLine1..'')--Column 2
					end
					if RecastMode2C3 == 'NONE' then
						send_command('text recastmode2c3 pos '..HUDposXColumn3..' -100')--Not visible if NONE
					else
						send_command('text recastmode2c3 pos '..HUDposXColumn3..' '..HUDposYLine1..'')--Column 3
					end
					if RecastMode2C4 == 'NONE' then
						send_command('text recastmode2c4 pos '..HUDposXColumn4..' -100')--Not visible if NONE
					else
						send_command('text recastmode2c4 pos '..HUDposXColumn4..' '..HUDposYLine1..'')--Column 4
					end
					if RecastMode2C5 == 'NONE' then
						send_command('text recastmode2c5 pos '..HUDposXColumn5..' -100')--Not visible if NONE
					else
						send_command('text recastmode2c5 pos '..HUDposXColumn5..' '..HUDposYLine1..'')--Column 5
					end
					if RecastMode2C6 == 'NONE' then
						send_command('text recastmode2c6 pos '..HUDposXColumn6..' -100')--Not visible if NONE
					else
						send_command('text recastmode2c6 pos '..HUDposXColumn6..' '..HUDposYLine1..'')--Column 6
					end
					send_command('text recastmode3c1 pos '..HUDposXColumn1..' -100')--Column 1
					send_command('text recastmode3c2 pos '..HUDposXColumn2..' -100')--Column 2
					send_command('text recastmode3c3 pos '..HUDposXColumn3..' -100')--Column 3
					send_command('text recastmode3c4 pos '..HUDposXColumn4..' -100')--Column 4
					send_command('text recastmode3c5 pos '..HUDposXColumn5..' -100')--Column 5
					send_command('text recastmode3c6 pos '..HUDposXColumn6..' -100')--Column 6
					send_command('text recastmode4c1 pos '..HUDposXColumn1..' -100')--Column 1
					send_command('text recastmode4c2 pos '..HUDposXColumn2..' -100')--Column 2
					send_command('text recastmode4c3 pos '..HUDposXColumn3..' -100')--Column 3
					send_command('text recastmode4c4 pos '..HUDposXColumn4..' -100')--Column 4
					send_command('text recastmode4c5 pos '..HUDposXColumn5..' -100')--Column 5
					send_command('text recastmode4c6 pos '..HUDposXColumn6..' -100')--Column 6
				elseif Mode == 'Mode3' then
					send_command('text recastmode1c1 pos '..HUDposXColumn1..' -100')--Column 1
					send_command('text recastmode1c2 pos '..HUDposXColumn2..' -100')--Column 2
					send_command('text recastmode1c3 pos '..HUDposXColumn3..' -100')--Column 3
					send_command('text recastmode1c4 pos '..HUDposXColumn4..' -100')--Column 4
					send_command('text recastmode1c5 pos '..HUDposXColumn5..' -100')--Column 5
					send_command('text recastmode1c6 pos '..HUDposXColumn6..' -100')--Column 6
					send_command('text recastmode2c1 pos '..HUDposXColumn1..' -100')--Column 1
					send_command('text recastmode2c2 pos '..HUDposXColumn2..' -100')--Column 2
					send_command('text recastmode2c3 pos '..HUDposXColumn3..' -100')--Column 3
					send_command('text recastmode2c4 pos '..HUDposXColumn4..' -100')--Column 4
					send_command('text recastmode2c5 pos '..HUDposXColumn5..' -100')--Column 5
					send_command('text recastmode2c6 pos '..HUDposXColumn6..' -100')--Column 6
					if RecastMode3C1 == 'NONE' then
						send_command('text recastmode3c1 pos '..HUDposXColumn1..' -100')--Not visible if NONE
					else
						send_command('text recastmode3c1 pos '..HUDposXColumn1..' '..HUDposYLine1..'')--Column 1
					end
					if RecastMode3C2 == 'NONE' then
						send_command('text recastmode3c2 pos '..HUDposXColumn2..' -100')--Not visible if NONE
					else
						send_command('text recastmode3c2 pos '..HUDposXColumn2..' '..HUDposYLine1..'')--Column 2
					end
					if RecastMode3C3 == 'NONE' then
						send_command('text recastmode3c3 pos '..HUDposXColumn3..' -100')--Not visible if NONE
					else
						send_command('text recastmode3c3 pos '..HUDposXColumn3..' '..HUDposYLine1..'')--Column 3
					end
					if RecastMode3C4 == 'NONE' then
						send_command('text recastmode3c4 pos '..HUDposXColumn4..' -100')--Not visible if NONE
					else
						send_command('text recastmode3c4 pos '..HUDposXColumn4..' '..HUDposYLine1..'')--Column 4
					end
					if RecastMode3C5 == 'NONE' then
						send_command('text recastmode3c5 pos '..HUDposXColumn5..' -100')--Not visible if NONE
					else
						send_command('text recastmode3c5 pos '..HUDposXColumn5..' '..HUDposYLine1..'')--Column 5
					end
					if RecastMode3C6 == 'NONE' then
						send_command('text recastmode3c6 pos '..HUDposXColumn6..' -100')--Not visible if NONE
					else
						send_command('text recastmode3c6 pos '..HUDposXColumn6..' '..HUDposYLine1..'')--Column 6
					end
					send_command('text recastmode4c1 pos '..HUDposXColumn1..' -100')--Column 1
					send_command('text recastmode4c2 pos '..HUDposXColumn2..' -100')--Column 2
					send_command('text recastmode4c3 pos '..HUDposXColumn3..' -100')--Column 3
					send_command('text recastmode4c4 pos '..HUDposXColumn4..' -100')--Column 4
					send_command('text recastmode4c5 pos '..HUDposXColumn5..' -100')--Column 5
					send_command('text recastmode4c6 pos '..HUDposXColumn6..' -100')--Column 6
				elseif Mode == 'Mode4' then
					send_command('text recastmode1c1 pos '..HUDposXColumn1..' -100')--Column 1
					send_command('text recastmode1c2 pos '..HUDposXColumn2..' -100')--Column 2
					send_command('text recastmode1c3 pos '..HUDposXColumn3..' -100')--Column 3
					send_command('text recastmode1c4 pos '..HUDposXColumn4..' -100')--Column 4
					send_command('text recastmode1c5 pos '..HUDposXColumn5..' -100')--Column 5
					send_command('text recastmode1c6 pos '..HUDposXColumn6..' -100')--Column 6
					send_command('text recastmode2c1 pos '..HUDposXColumn1..' -100')--Column 1
					send_command('text recastmode2c2 pos '..HUDposXColumn2..' -100')--Column 2
					send_command('text recastmode2c3 pos '..HUDposXColumn3..' -100')--Column 3
					send_command('text recastmode2c4 pos '..HUDposXColumn4..' -100')--Column 4
					send_command('text recastmode2c5 pos '..HUDposXColumn5..' -100')--Column 5
					send_command('text recastmode2c6 pos '..HUDposXColumn6..' -100')--Column 6
					send_command('text recastmode3c1 pos '..HUDposXColumn1..' -100')--Column 1
					send_command('text recastmode3c2 pos '..HUDposXColumn2..' -100')--Column 2
					send_command('text recastmode3c3 pos '..HUDposXColumn3..' -100')--Column 3
					send_command('text recastmode3c4 pos '..HUDposXColumn4..' -100')--Column 4
					send_command('text recastmode3c5 pos '..HUDposXColumn5..' -100')--Column 5
					send_command('text recastmode3c6 pos '..HUDposXColumn6..' -100')--Column 6
					if RecastMode4C1 == 'NONE' then
						send_command('text recastmode4c1 pos '..HUDposXColumn1..' -100')--Not visible if NONE
					else
						send_command('text recastmode4c1 pos '..HUDposXColumn1..' '..HUDposYLine1..'')--Column 1
					end
					if RecastMode4C2 == 'NONE' then
						send_command('text recastmode4c2 pos '..HUDposXColumn2..' -100')--Not visible if NONE
					else
						send_command('text recastmode4c2 pos '..HUDposXColumn2..' '..HUDposYLine1..'')--Column 2
					end
					if RecastMode4C3 == 'NONE' then
						send_command('text recastmode4c3 pos '..HUDposXColumn3..' -100')--Not visible if NONE
					else
						send_command('text recastmode4c3 pos '..HUDposXColumn3..' '..HUDposYLine1..'')--Column 3
					end
					if RecastMode4C4 == 'NONE' then
						send_command('text recastmode4c4 pos '..HUDposXColumn4..' -100')--Not visible if NONE
					else
						send_command('text recastmode4c4 pos '..HUDposXColumn4..' '..HUDposYLine1..'')--Column 4
					end
					if RecastMode4C5 == 'NONE' then
						send_command('text recastmode4c5 pos '..HUDposXColumn5..' -100')--Not visible if NONE
					else
						send_command('text recastmode4c5 pos '..HUDposXColumn5..' '..HUDposYLine1..'')--Column 5
					end
					if RecastMode4C6 == 'NONE' then
						send_command('text recastmode4c6 pos '..HUDposXColumn6..' -100')--Not visible if NONE
					else
						send_command('text recastmode4c6 pos '..HUDposXColumn6..' '..HUDposYLine1..'')--Column 6
					end
				end
				if (player.equipment.main == 'Tizona' or player.equipment.main == 'Almace' or player.equipment.main == 'Sequence') and REMA == false then
					--if we have any REMAs equipped we place the Aftermath text object inline with the others
					send_command('text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')	--Background Line 3
					send_command('text aftermath pos '..HUDposXColumn4..' '..HUDposYLine2..'')		--Aftermath - visible
					send_command('text mode pos '..HUDposXColumn1..' '..HUDposYLine2..'')			--Mode - visible
					send_command('text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')	--Notifications - visible
					REMA = true --This toggle then gets set to true since now we have a REMA equipped
				elseif not (player.equipment.main == 'Tizona' or player.equipment.main == 'Almace' or player.equipment.main == 'Sequence') and REMA == true then
					--if we do not have any REMAs equipped we move the Aftermath text object out of view and adjust the others
					send_command('text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')	--Background Line 3
					send_command('text aftermath pos '..HUDposXColumn4..' -100')					--Aftermath - not visible
					send_command('text mode pos '..HUDposXColumn1..' '..HUDposYLine2..'')			--Mode - visible
					send_command('text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')	--Notifications - visible
					REMA = false --This toggle gets set to false since we no longer have a REMA equipped
				end
			else --not using the HUDRecast
				if (player.equipment.main == 'Tizona' or player.equipment.main == 'Almace' or player.equipment.main == 'Sequence') and REMA == false then
					--if we have any REMAs equipped we place the Aftermath text object inline with the others
					send_command('text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')	--Background Line 3 - visible
					send_command('text aftermath pos '..HUDposXColumn4..' '..HUDposYLine1..'')		--Aftermath - visible
					send_command('text mode pos '..HUDposXColumn1..' '..HUDposYLine1..'')			--Mode - visible
					send_command('text notifications pos '..HUDposXColumn1..' '..HUDposYLine2..'')	--Notifications - visible
					REMA = true
				elseif not (player.equipment.main == 'Tizona' or player.equipment.main == 'Almace' or player.equipment.main == 'Sequence') and REMA == true then
					--if we do not have any REMAs equipped we move the Aftermath text object out of view and adjust the others
					send_command('text bg3 pos '..HUDposXColumn1..' -100')					--Background Line 3 - not visible
					send_command('text mode pos '..HUDposXColumn1..' '..HUDposYLine1..'')			--Mode - visible
					send_command('text notifications pos '..HUDposXColumn1..' '..HUDposYLine2..'')	--Notifications - visible
					send_command('text aftermath pos '..HUDposXColumn4..' -100')					--Aftermath - not visible
					REMA = false
				end
			end
			--Recast updates:
			if player.sub_job == 'WAR' and player.sub_job_level >= 1 then
				AggressorRecast = windower.ffxi.get_ability_recasts()[4]
				BerserkRecast = windower.ffxi.get_ability_recasts()[1]
				DefenderRecast = windower.ffxi.get_ability_recasts()[3]
				WarcryRecast = windower.ffxi.get_ability_recasts()[2]
			end
			ErraticRecast = windower.ffxi.get_spell_recasts()[710]
			BatteryRecast = windower.ffxi.get_spell_recasts()[662]
			OccultRecast = windower.ffxi.get_spell_recasts()[679]
			DiamondRecast = windower.ffxi.get_spell_recasts()[632]
			BarrierTRecast = windower.ffxi.get_spell_recasts()[685]
			CocoonRecast = windower.ffxi.get_spell_recasts()[547]
			NatMedRecast = windower.ffxi.get_spell_recasts()[700]
			SalineRecast = windower.ffxi.get_spell_recasts()[614]
			OCStanceRecast = windower.ffxi.get_spell_recasts()[696]
			ReactorRecast = windower.ffxi.get_spell_recasts()[613]
			FBarrierRecast = windower.ffxi.get_spell_recasts()[574]
			AmplifiRecast = windower.ffxi.get_spell_recasts()[642]
			RegenerRecast = windower.ffxi.get_spell_recasts()[664]
			MBarrierRecast = windower.ffxi.get_spell_recasts()[668]
			--Recast color updates - decide the colors:
			if buffactive['Haste'] then ErraticColor = '75 255 75'
			elseif ErraticRecast > 0 then ErraticColor = '255 165 0'
			else ErraticColor = '255 50 50'
			end
			if buffactive['Refresh'] then BatteryColor = '75 255 75'
			elseif BatteryRecast > 0 then BatteryColor = '255 165 0'
			else BatteryColor = '255 50 50'
			end
			if buffactive['Blink'] then OccultColor = '75 255 75'
			elseif OccultRecast > 0 then OccultColor = '255 165 0'
			else OccultColor = '255 50 50'
			end
			if buffactive['Stoneskin'] then DiamondColor = '75 255 75'
			elseif DiamondRecast > 0 then DiamondColor = '255 165 0'
			else DiamondColor = '255 50 50'
			end
			if buffactive['Phalanx'] then BarrierTColor = '75 255 75'
			elseif BarrierTRecast > 0 then BarrierTColor = '255 165 0'
			else BarrierTColor = '255 50 50'
			end
			if buffactive['Defense Boost'] then CocoonColor = '75 255 75'
			elseif CocoonRecast > 0 then CocoonColor = '255 165 0'
			else CocoonColor = '255 50 50'
			end
			if buffactive['Attack Boost'] then NatMedColor = '75 255 75'
			elseif NatMedRecast > 0 then NatMedColor = '255 165 0'
			else NatMedColor = '255 50 50'
			end
			if buffactive['Magic Def. Boost'] then SalineColor = '75 255 75'
			elseif SalineRecast > 0 then SalineColor = '255 165 0'
			else SalineColor = '255 50 50'
			end
			if buffactive['Counter Boost'] then OCStanceColor = '75 255 75'
			elseif OCStanceRecast > 0 then OCStanceColor = '255 165 0'
			else OCStanceColor = '255 50 50'
			end
			if buffactive['Magic Atk. Boost'] then MementoColor = '75 255 75'
			elseif MementoRecast > 0 then MementoColor = '255 165 0'
			else MementoColor = '255 50 50'
			end
			if buffactive['Ice Spikes'] and buffactive['Defense Boost'] then ReactorColor = '75 255 75'
			elseif ReactorRecast > 0 then ReactorColor = '255 165 0'
			else ReactorColor = '255 50 50'
			end
			if buffactive['Evasion Boost'] then FBarrierColor = '75 255 75'
			elseif FBarrierRecast > 0 then FBarrierColor = '255 165 0'
			else FBarrierColor = '255 50 50'
			end
			if buffactive['Magic Atk. Boost'] and buffactive['Magic Def. Boost'] then AmplifiColor = '75 255 75'
			elseif AmplifiRecast > 0 then AmplifiColor = '255 165 0'
			else AmplifiColor = '255 50 50'
			end
			if buffactive['Regen'] then RegenerColor = '75 255 75'
			elseif RegenerRecast > 0 then RegenerColor = '255 165 0'
			else RegenerColor = '255 50 50'
			end
			if buffactive['Magic Shield'] then MBarrierColor = '75 255 75'
			elseif MBarrierRecast > 0 then MBarrierColor = '255 165 0'
			else MBarrierColor = '255 50 50'
			end
			if player.sub_job == 'WAR' and player.sub_job_level >= 1 then
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
				if buffactive['Warcry'] then WarcryColor = '75 255 75'
				elseif WarcryRecast > 0 then WarcryColor = '255 165 0'
				else WarcryColor = '255 50 50'
				end
			end
			--Recast color updates - print the colors:
			--Mode 1 Column 1
			if RecastMode1C1 == 'Erratic Flutter' then send_command('text recastmode1c1 color '..ErraticColor..'')
			elseif RecastMode1C1 == 'Battery Charge' then send_command('text recastmode1c1 color '..BatteryColor..'')
			elseif RecastMode1C1 == 'Occultation' then send_command('text recastmode1c1 color '..OccultColor..'')
			elseif RecastMode1C1 == 'Diamondhide' then send_command('text recastmode1c1 color '..DiamondColor..'')
			elseif RecastMode1C1 == 'Barrier Tusk' then send_command('text recastmode1c1 color '..BarrierTColor..'')
			elseif RecastMode1C1 == 'Cocoon' then send_command('text recastmode1c1 color '..CocoonColor..'')
			elseif RecastMode1C1 == 'Nat. Meditation' then send_command('text recastmode1c1 color '..NatMedColor..'')
			elseif RecastMode1C1 == 'Saline Coat' then send_command('text recastmode1c1 color '..SalineColor..'')
			elseif RecastMode1C1 == 'O. Counterstance' then send_command('text recastmode1c1 color '..OCStanceColor..'')
			elseif RecastMode1C1 == 'Memento Mori' then send_command('text recastmode1c1 color '..MementoColor..'')
			elseif RecastMode1C1 == 'Reactor Cool' then send_command('text recastmode1c1 color '..ReactorColor..'')
			elseif RecastMode1C1 == 'Feather Barrier' then send_command('text recastmode1c1 color '..FBarrierColor..'')
			elseif RecastMode1C1 == 'Amplification' then send_command('text recastmode1c1 color '..AmplifiColor..'')
			elseif RecastMode1C1 == 'Regeneration' then send_command('text recastmode1c1 color '..RegenerColor..'')
			elseif RecastMode1C1 == 'Magic Barrier' then send_command('text recastmode1c1 color '..MBarrierColor..'')
			elseif RecastMode1C1 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c1 color '..AggressorColor..'')
			elseif RecastMode1C1 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c1 color '..BerserkColor..'')
			elseif RecastMode1C1 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c1 color '..DefenderColor..'')
			elseif RecastMode1C1 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c1 color '..WarcryColor..'')
			end
			--Mode 1 Column 2
			if RecastMode1C2 == 'Erratic Flutter' then send_command('text recastmode1c2 color '..ErraticColor..'')
			elseif RecastMode1C2 == 'Battery Charge' then send_command('text recastmode1c2 color '..BatteryColor..'')
			elseif RecastMode1C2 == 'Occultation' then send_command('text recastmode1c2 color '..OccultColor..'')
			elseif RecastMode1C2 == 'Diamondhide' then send_command('text recastmode1c2 color '..DiamondColor..'')
			elseif RecastMode1C2 == 'Barrier Tusk' then send_command('text recastmode1c2 color '..BarrierTColor..'')
			elseif RecastMode1C2 == 'Cocoon' then send_command('text recastmode1c2 color '..CocoonColor..'')
			elseif RecastMode1C2 == 'Nat. Meditation' then send_command('text recastmode1c2 color '..NatMedColor..'')
			elseif RecastMode1C2 == 'Saline Coat' then send_command('text recastmode1c2 color '..SalineColor..'')
			elseif RecastMode1C2 == 'O. Counterstance' then send_command('text recastmode1c2 color '..OCStanceColor..'')
			elseif RecastMode1C2 == 'Memento Mori' then send_command('text recastmode1c2 color '..MementoColor..'')
			elseif RecastMode1C2 == 'Reactor Cool' then send_command('text recastmode1c2 color '..ReactorColor..'')
			elseif RecastMode1C2 == 'Feather Barrier' then send_command('text recastmode1c2 color '..FBarrierColor..'')
			elseif RecastMode1C2 == 'Amplification' then send_command('text recastmode1c2 color '..AmplifiColor..'')
			elseif RecastMode1C2 == 'Regeneration' then send_command('text recastmode1c2 color '..RegenerColor..'')
			elseif RecastMode1C2 == 'Magic Barrier' then send_command('text recastmode1c2 color '..MBarrierColor..'')
			elseif RecastMode1C2 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c2 color '..AggressorColor..'')
			elseif RecastMode1C2 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c2 color '..BerserkColor..'')
			elseif RecastMode1C2 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c2 color '..DefenderColor..'')
			elseif RecastMode1C2 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c2 color '..WarcryColor..'')
			end
			--Mode 1 Column 3
			if RecastMode1C3 == 'Erratic Flutter' then send_command('text recastmode1c3 color '..ErraticColor..'')
			elseif RecastMode1C3 == 'Battery Charge' then send_command('text recastmode1c3 color '..BatteryColor..'')
			elseif RecastMode1C3 == 'Occultation' then send_command('text recastmode1c3 color '..OccultColor..'')
			elseif RecastMode1C3 == 'Diamondhide' then send_command('text recastmode1c3 color '..DiamondColor..'')
			elseif RecastMode1C3 == 'Barrier Tusk' then send_command('text recastmode1c3 color '..BarrierTColor..'')
			elseif RecastMode1C3 == 'Cocoon' then send_command('text recastmode1c3 color '..CocoonColor..'')
			elseif RecastMode1C3 == 'Nat. Meditation' then send_command('text recastmode1c3 color '..NatMedColor..'')
			elseif RecastMode1C3 == 'Saline Coat' then send_command('text recastmode1c3 color '..SalineColor..'')
			elseif RecastMode1C3 == 'O. Counterstance' then send_command('text recastmode1c3 color '..OCStanceColor..'')
			elseif RecastMode1C3 == 'Memento Mori' then send_command('text recastmode1c3 color '..MementoColor..'')
			elseif RecastMode1C3 == 'Reactor Cool' then send_command('text recastmode1c3 color '..ReactorColor..'')
			elseif RecastMode1C3 == 'Feather Barrier' then send_command('text recastmode1c3 color '..FBarrierColor..'')
			elseif RecastMode1C3 == 'Amplification' then send_command('text recastmode1c3 color '..AmplifiColor..'')
			elseif RecastMode1C3 == 'Regeneration' then send_command('text recastmode1c3 color '..RegenerColor..'')
			elseif RecastMode1C3 == 'Magic Barrier' then send_command('text recastmode1c3 color '..MBarrierColor..'')
			elseif RecastMode1C3 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c3 color '..AggressorColor..'')
			elseif RecastMode1C3 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c3 color '..BerserkColor..'')
			elseif RecastMode1C3 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c3 color '..DefenderColor..'')
			elseif RecastMode1C3 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c3 color '..WarcryColor..'')
			end
			--Mode 1 Column 4
			if RecastMode1C4 == 'Erratic Flutter' then send_command('text recastmode1c4 color '..ErraticColor..'')
			elseif RecastMode1C4 == 'Battery Charge' then send_command('text recastmode1c4 color '..BatteryColor..'')
			elseif RecastMode1C4 == 'Occultation' then send_command('text recastmode1c4 color '..OccultColor..'')
			elseif RecastMode1C4 == 'Diamondhide' then send_command('text recastmode1c4 color '..DiamondColor..'')
			elseif RecastMode1C4 == 'Barrier Tusk' then send_command('text recastmode1c4 color '..BarrierTColor..'')
			elseif RecastMode1C4 == 'Cocoon' then send_command('text recastmode1c4 color '..CocoonColor..'')
			elseif RecastMode1C4 == 'Nat. Meditation' then send_command('text recastmode1c4 color '..NatMedColor..'')
			elseif RecastMode1C4 == 'Saline Coat' then send_command('text recastmode1c4 color '..SalineColor..'')
			elseif RecastMode1C4 == 'O. Counterstance' then send_command('text recastmode1c4 color '..OCStanceColor..'')
			elseif RecastMode1C4 == 'Memento Mori' then send_command('text recastmode1c4 color '..MementoColor..'')
			elseif RecastMode1C4 == 'Reactor Cool' then send_command('text recastmode1c4 color '..ReactorColor..'')
			elseif RecastMode1C4 == 'Feather Barrier' then send_command('text recastmode1c4 color '..FBarrierColor..'')
			elseif RecastMode1C4 == 'Amplification' then send_command('text recastmode1c4 color '..AmplifiColor..'')
			elseif RecastMode1C4 == 'Regeneration' then send_command('text recastmode1c4 color '..RegenerColor..'')
			elseif RecastMode1C4 == 'Magic Barrier' then send_command('text recastmode1c4 color '..MBarrierColor..'')
			elseif RecastMode1C4 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c4 color '..AggressorColor..'')
			elseif RecastMode1C4 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c4 color '..BerserkColor..'')
			elseif RecastMode1C4 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c4 color '..DefenderColor..'')
			elseif RecastMode1C4 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c4 color '..WarcryColor..'')
			end
			--Mode 1 Column 5
			if RecastMode1C5 == 'Erratic Flutter' then send_command('text recastmode1c5 color '..ErraticColor..'')
			elseif RecastMode1C5 == 'Battery Charge' then send_command('text recastmode1c5 color '..BatteryColor..'')
			elseif RecastMode1C5 == 'Occultation' then send_command('text recastmode1c5 color '..OccultColor..'')
			elseif RecastMode1C5 == 'Diamondhide' then send_command('text recastmode1c5 color '..DiamondColor..'')
			elseif RecastMode1C5 == 'Barrier Tusk' then send_command('text recastmode1c5 color '..BarrierTColor..'')
			elseif RecastMode1C5 == 'Cocoon' then send_command('text recastmode1c5 color '..CocoonColor..'')
			elseif RecastMode1C5 == 'Nat. Meditation' then send_command('text recastmode1c5 color '..NatMedColor..'')
			elseif RecastMode1C5 == 'Saline Coat' then send_command('text recastmode1c5 color '..SalineColor..'')
			elseif RecastMode1C5 == 'O. Counterstance' then send_command('text recastmode1c5 color '..OCStanceColor..'')
			elseif RecastMode1C5 == 'Memento Mori' then send_command('text recastmode1c5 color '..MementoColor..'')
			elseif RecastMode1C5 == 'Reactor Cool' then send_command('text recastmode1c5 color '..ReactorColor..'')
			elseif RecastMode1C5 == 'Feather Barrier' then send_command('text recastmode1c5 color '..FBarrierColor..'')
			elseif RecastMode1C5 == 'Amplification' then send_command('text recastmode1c5 color '..AmplifiColor..'')
			elseif RecastMode1C5 == 'Regeneration' then send_command('text recastmode1c5 color '..RegenerColor..'')
			elseif RecastMode1C5 == 'Magic Barrier' then send_command('text recastmode1c5 color '..MBarrierColor..'')
			elseif RecastMode1C5 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c5 color '..AggressorColor..'')
			elseif RecastMode1C5 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c5 color '..BerserkColor..'')
			elseif RecastMode1C5 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c5 color '..DefenderColor..'')
			elseif RecastMode1C5 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c5 color '..WarcryColor..'')
			end
			--Mode 1 Column 6
			if RecastMode1C6 == 'Erratic Flutter' then send_command('text recastmode1c6 color '..ErraticColor..'')
			elseif RecastMode1C6 == 'Battery Charge' then send_command('text recastmode1c6 color '..BatteryColor..'')
			elseif RecastMode1C6 == 'Occultation' then send_command('text recastmode1c6 color '..OccultColor..'')
			elseif RecastMode1C6 == 'Diamondhide' then send_command('text recastmode1c6 color '..DiamondColor..'')
			elseif RecastMode1C6 == 'Barrier Tusk' then send_command('text recastmode1c6 color '..BarrierTColor..'')
			elseif RecastMode1C6 == 'Cocoon' then send_command('text recastmode1c6 color '..CocoonColor..'')
			elseif RecastMode1C6 == 'Nat. Meditation' then send_command('text recastmode1c6 color '..NatMedColor..'')
			elseif RecastMode1C6 == 'Saline Coat' then send_command('text recastmode1c6 color '..SalineColor..'')
			elseif RecastMode1C6 == 'O. Counterstance' then send_command('text recastmode1c6 color '..OCStanceColor..'')
			elseif RecastMode1C6 == 'Memento Mori' then send_command('text recastmode1c6 color '..MementoColor..'')
			elseif RecastMode1C6 == 'Reactor Cool' then send_command('text recastmode1c6 color '..ReactorColor..'')
			elseif RecastMode1C6 == 'Feather Barrier' then send_command('text recastmode1c6 color '..FBarrierColor..'')
			elseif RecastMode1C6 == 'Amplification' then send_command('text recastmode1c6 color '..AmplifiColor..'')
			elseif RecastMode1C6 == 'Regeneration' then send_command('text recastmode1c6 color '..RegenerColor..'')
			elseif RecastMode1C6 == 'Magic Barrier' then send_command('text recastmode1c6 color '..MBarrierColor..'')
			elseif RecastMode1C6 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c6 color '..AggressorColor..'')
			elseif RecastMode1C6 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c6 color '..BerserkColor..'')
			elseif RecastMode1C6 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c6 color '..DefenderColor..'')
			elseif RecastMode1C6 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode1c6 color '..WarcryColor..'')
			end
			--Mode 2 Column 1
			if RecastMode2C1 == 'Erratic Flutter' then send_command('text recastmode2c1 color '..ErraticColor..'')
			elseif RecastMode2C1 == 'Battery Charge' then send_command('text recastmode2c1 color '..BatteryColor..'')
			elseif RecastMode2C1 == 'Occultation' then send_command('text recastmode2c1 color '..OccultColor..'')
			elseif RecastMode2C1 == 'Diamondhide' then send_command('text recastmode2c1 color '..DiamondColor..'')
			elseif RecastMode2C1 == 'Barrier Tusk' then send_command('text recastmode2c1 color '..BarrierTColor..'')
			elseif RecastMode2C1 == 'Cocoon' then send_command('text recastmode2c1 color '..CocoonColor..'')
			elseif RecastMode2C1 == 'Nat. Meditation' then send_command('text recastmode2c1 color '..NatMedColor..'')
			elseif RecastMode2C1 == 'Saline Coat' then send_command('text recastmode2c1 color '..SalineColor..'')
			elseif RecastMode2C1 == 'O. Counterstance' then send_command('text recastmode2c1 color '..OCStanceColor..'')
			elseif RecastMode2C1 == 'Memento Mori' then send_command('text recastmode2c1 color '..MementoColor..'')
			elseif RecastMode2C1 == 'Reactor Cool' then send_command('text recastmode2c1 color '..ReactorColor..'')
			elseif RecastMode2C1 == 'Feather Barrier' then send_command('text recastmode2c1 color '..FBarrierColor..'')
			elseif RecastMode2C1 == 'Amplification' then send_command('text recastmode2c1 color '..AmplifiColor..'')
			elseif RecastMode2C1 == 'Regeneration' then send_command('text recastmode2c1 color '..RegenerColor..'')
			elseif RecastMode2C1 == 'Magic Barrier' then send_command('text recastmode2c1 color '..MBarrierColor..'')
			elseif RecastMode2C1 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c1 color '..AggressorColor..'')
			elseif RecastMode2C1 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c1 color '..BerserkColor..'')
			elseif RecastMode2C1 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c1 color '..DefenderColor..'')
			elseif RecastMode2C1 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c1 color '..WarcryColor..'')
			end
			--Mode 2 Column 2
			if RecastMode2C2 == 'Erratic Flutter' then send_command('text recastmode2c2 color '..ErraticColor..'')
			elseif RecastMode2C2 == 'Battery Charge' then send_command('text recastmode2c2 color '..BatteryColor..'')
			elseif RecastMode2C2 == 'Occultation' then send_command('text recastmode2c2 color '..OccultColor..'')
			elseif RecastMode2C2 == 'Diamondhide' then send_command('text recastmode2c2 color '..DiamondColor..'')
			elseif RecastMode2C2 == 'Barrier Tusk' then send_command('text recastmode2c2 color '..BarrierTColor..'')
			elseif RecastMode2C2 == 'Cocoon' then send_command('text recastmode2c2 color '..CocoonColor..'')
			elseif RecastMode2C2 == 'Nat. Meditation' then send_command('text recastmode2c2 color '..NatMedColor..'')
			elseif RecastMode2C2 == 'Saline Coat' then send_command('text recastmode2c2 color '..SalineColor..'')
			elseif RecastMode2C2 == 'O. Counterstance' then send_command('text recastmode2c2 color '..OCStanceColor..'')
			elseif RecastMode2C2 == 'Memento Mori' then send_command('text recastmode2c2 color '..MementoColor..'')
			elseif RecastMode2C2 == 'Reactor Cool' then send_command('text recastmode2c2 color '..ReactorColor..'')
			elseif RecastMode2C2 == 'Feather Barrier' then send_command('text recastmode2c2 color '..FBarrierColor..'')
			elseif RecastMode2C2 == 'Amplification' then send_command('text recastmode2c2 color '..AmplifiColor..'')
			elseif RecastMode2C2 == 'Regeneration' then send_command('text recastmode2c2 color '..RegenerColor..'')
			elseif RecastMode2C2 == 'Magic Barrier' then send_command('text recastmode2c2 color '..MBarrierColor..'')
			elseif RecastMode2C2 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c2 color '..AggressorColor..'')
			elseif RecastMode2C2 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c2 color '..BerserkColor..'')
			elseif RecastMode2C2 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c2 color '..DefenderColor..'')
			elseif RecastMode2C2 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c2 color '..WarcryColor..'')
			end
			--Mode 2 Column 3
			if RecastMode2C3 == 'Erratic Flutter' then send_command('text recastmode2c3 color '..ErraticColor..'')
			elseif RecastMode2C3 == 'Battery Charge' then send_command('text recastmode2c3 color '..BatteryColor..'')
			elseif RecastMode2C3 == 'Occultation' then send_command('text recastmode2c3 color '..OccultColor..'')
			elseif RecastMode2C3 == 'Diamondhide' then send_command('text recastmode2c3 color '..DiamondColor..'')
			elseif RecastMode2C3 == 'Barrier Tusk' then send_command('text recastmode2c3 color '..BarrierTColor..'')
			elseif RecastMode2C3 == 'Cocoon' then send_command('text recastmode2c3 color '..CocoonColor..'')
			elseif RecastMode2C3 == 'Nat. Meditation' then send_command('text recastmode2c3 color '..NatMedColor..'')
			elseif RecastMode2C3 == 'Saline Coat' then send_command('text recastmode2c3 color '..SalineColor..'')
			elseif RecastMode2C3 == 'O. Counterstance' then send_command('text recastmode2c3 color '..OCStanceColor..'')
			elseif RecastMode2C3 == 'Memento Mori' then send_command('text recastmode2c3 color '..MementoColor..'')
			elseif RecastMode2C3 == 'Reactor Cool' then send_command('text recastmode2c3 color '..ReactorColor..'')
			elseif RecastMode2C3 == 'Feather Barrier' then send_command('text recastmode2c3 color '..FBarrierColor..'')
			elseif RecastMode2C3 == 'Amplification' then send_command('text recastmode2c3 color '..AmplifiColor..'')
			elseif RecastMode2C3 == 'Regeneration' then send_command('text recastmode2c3 color '..RegenerColor..'')
			elseif RecastMode2C3 == 'Magic Barrier' then send_command('text recastmode2c3 color '..MBarrierColor..'')
			elseif RecastMode2C3 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c3 color '..AggressorColor..'')
			elseif RecastMode2C3 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c3 color '..BerserkColor..'')
			elseif RecastMode2C3 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c3 color '..DefenderColor..'')
			elseif RecastMode2C3 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c3 color '..WarcryColor..'')
			end
			--Mode 2 Column 4
			if RecastMode2C4 == 'Erratic Flutter' then send_command('text recastmode2c4 color '..ErraticColor..'')
			elseif RecastMode2C4 == 'Battery Charge' then send_command('text recastmode2c4 color '..BatteryColor..'')
			elseif RecastMode2C4 == 'Occultation' then send_command('text recastmode2c4 color '..OccultColor..'')
			elseif RecastMode2C4 == 'Diamondhide' then send_command('text recastmode2c4 color '..DiamondColor..'')
			elseif RecastMode2C4 == 'Barrier Tusk' then send_command('text recastmode2c4 color '..BarrierTColor..'')
			elseif RecastMode2C4 == 'Cocoon' then send_command('text recastmode2c4 color '..CocoonColor..'')
			elseif RecastMode2C4 == 'Nat. Meditation' then send_command('text recastmode2c4 color '..NatMedColor..'')
			elseif RecastMode2C4 == 'Saline Coat' then send_command('text recastmode2c4 color '..SalineColor..'')
			elseif RecastMode2C4 == 'O. Counterstance' then send_command('text recastmode2c4 color '..OCStanceColor..'')
			elseif RecastMode2C4 == 'Memento Mori' then send_command('text recastmode2c4 color '..MementoColor..'')
			elseif RecastMode2C4 == 'Reactor Cool' then send_command('text recastmode2c4 color '..ReactorColor..'')
			elseif RecastMode2C4 == 'Feather Barrier' then send_command('text recastmode2c4 color '..FBarrierColor..'')
			elseif RecastMode2C4 == 'Amplification' then send_command('text recastmode2c4 color '..AmplifiColor..'')
			elseif RecastMode2C4 == 'Regeneration' then send_command('text recastmode2c4 color '..RegenerColor..'')
			elseif RecastMode2C4 == 'Magic Barrier' then send_command('text recastmode2c4 color '..MBarrierColor..'')
			elseif RecastMode2C4 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c4 color '..AggressorColor..'')
			elseif RecastMode2C4 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c4 color '..BerserkColor..'')
			elseif RecastMode2C4 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c4 color '..DefenderColor..'')
			elseif RecastMode2C4 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c4 color '..WarcryColor..'')
			end
			--Mode 2 Column 5
			if RecastMode2C5 == 'Erratic Flutter' then send_command('text recastmode2c5 color '..ErraticColor..'')
			elseif RecastMode2C5 == 'Battery Charge' then send_command('text recastmode2c5 color '..BatteryColor..'')
			elseif RecastMode2C5 == 'Occultation' then send_command('text recastmode2c5 color '..OccultColor..'')
			elseif RecastMode2C5 == 'Diamondhide' then send_command('text recastmode2c5 color '..DiamondColor..'')
			elseif RecastMode2C5 == 'Barrier Tusk' then send_command('text recastmode2c5 color '..BarrierTColor..'')
			elseif RecastMode2C5 == 'Cocoon' then send_command('text recastmode2c5 color '..CocoonColor..'')
			elseif RecastMode2C5 == 'Nat. Meditation' then send_command('text recastmode2c5 color '..NatMedColor..'')
			elseif RecastMode2C5 == 'Saline Coat' then send_command('text recastmode2c5 color '..SalineColor..'')
			elseif RecastMode2C5 == 'O. Counterstance' then send_command('text recastmode2c5 color '..OCStanceColor..'')
			elseif RecastMode2C5 == 'Memento Mori' then send_command('text recastmode2c5 color '..MementoColor..'')
			elseif RecastMode2C5 == 'Reactor Cool' then send_command('text recastmode2c5 color '..ReactorColor..'')
			elseif RecastMode2C5 == 'Feather Barrier' then send_command('text recastmode2c5 color '..FBarrierColor..'')
			elseif RecastMode2C5 == 'Amplification' then send_command('text recastmode2c5 color '..AmplifiColor..'')
			elseif RecastMode2C5 == 'Regeneration' then send_command('text recastmode2c5 color '..RegenerColor..'')
			elseif RecastMode2C5 == 'Magic Barrier' then send_command('text recastmode2c5 color '..MBarrierColor..'')
			elseif RecastMode2C5 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c5 color '..AggressorColor..'')
			elseif RecastMode2C5 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c5 color '..BerserkColor..'')
			elseif RecastMode2C5 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c5 color '..DefenderColor..'')
			elseif RecastMode2C5 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c5 color '..WarcryColor..'')
			end
			--Mode 2 Column 6
			if RecastMode2C6 == 'Erratic Flutter' then send_command('text recastmode2c6 color '..ErraticColor..'')
			elseif RecastMode2C6 == 'Battery Charge' then send_command('text recastmode2c6 color '..BatteryColor..'')
			elseif RecastMode2C6 == 'Occultation' then send_command('text recastmode2c6 color '..OccultColor..'')
			elseif RecastMode2C6 == 'Diamondhide' then send_command('text recastmode2c6 color '..DiamondColor..'')
			elseif RecastMode2C6 == 'Barrier Tusk' then send_command('text recastmode2c6 color '..BarrierTColor..'')
			elseif RecastMode2C6 == 'Cocoon' then send_command('text recastmode2c6 color '..CocoonColor..'')
			elseif RecastMode2C6 == 'Nat. Meditation' then send_command('text recastmode2c6 color '..NatMedColor..'')
			elseif RecastMode2C6 == 'Saline Coat' then send_command('text recastmode2c6 color '..SalineColor..'')
			elseif RecastMode2C6 == 'O. Counterstance' then send_command('text recastmode2c6 color '..OCStanceColor..'')
			elseif RecastMode2C6 == 'Memento Mori' then send_command('text recastmode2c6 color '..MementoColor..'')
			elseif RecastMode2C6 == 'Reactor Cool' then send_command('text recastmode2c6 color '..ReactorColor..'')
			elseif RecastMode2C6 == 'Feather Barrier' then send_command('text recastmode2c6 color '..FBarrierColor..'')
			elseif RecastMode2C6 == 'Amplification' then send_command('text recastmode2c6 color '..AmplifiColor..'')
			elseif RecastMode2C6 == 'Regeneration' then send_command('text recastmode2c6 color '..RegenerColor..'')
			elseif RecastMode2C6 == 'Magic Barrier' then send_command('text recastmode2c6 color '..MBarrierColor..'')
			elseif RecastMode2C6 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c6 color '..AggressorColor..'')
			elseif RecastMode2C6 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c6 color '..BerserkColor..'')
			elseif RecastMode2C6 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c6 color '..DefenderColor..'')
			elseif RecastMode2C6 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode2c6 color '..WarcryColor..'')
			end
			--Mode 3 Column 1
			if RecastMode3C1 == 'Erratic Flutter' then send_command('text recastmode3c1 color '..ErraticColor..'')
			elseif RecastMode3C1 == 'Battery Charge' then send_command('text recastmode3c1 color '..BatteryColor..'')
			elseif RecastMode3C1 == 'Occultation' then send_command('text recastmode3c1 color '..OccultColor..'')
			elseif RecastMode3C1 == 'Diamondhide' then send_command('text recastmode3c1 color '..DiamondColor..'')
			elseif RecastMode3C1 == 'Barrier Tusk' then send_command('text recastmode3c1 color '..BarrierTColor..'')
			elseif RecastMode3C1 == 'Cocoon' then send_command('text recastmode3c1 color '..CocoonColor..'')
			elseif RecastMode3C1 == 'Nat. Meditation' then send_command('text recastmode3c1 color '..NatMedColor..'')
			elseif RecastMode3C1 == 'Saline Coat' then send_command('text recastmode3c1 color '..SalineColor..'')
			elseif RecastMode3C1 == 'O. Counterstance' then send_command('text recastmode3c1 color '..OCStanceColor..'')
			elseif RecastMode3C1 == 'Memento Mori' then send_command('text recastmode3c1 color '..MementoColor..'')
			elseif RecastMode3C1 == 'Reactor Cool' then send_command('text recastmode3c1 color '..ReactorColor..'')
			elseif RecastMode3C1 == 'Feather Barrier' then send_command('text recastmode3c1 color '..FBarrierColor..'')
			elseif RecastMode3C1 == 'Amplification' then send_command('text recastmode3c1 color '..AmplifiColor..'')
			elseif RecastMode3C1 == 'Regeneration' then send_command('text recastmode3c1 color '..RegenerColor..'')
			elseif RecastMode3C1 == 'Magic Barrier' then send_command('text recastmode3c1 color '..MBarrierColor..'')
			elseif RecastMode3C1 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c1 color '..AggressorColor..'')
			elseif RecastMode3C1 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c1 color '..BerserkColor..'')
			elseif RecastMode3C1 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c1 color '..DefenderColor..'')
			elseif RecastMode3C1 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c1 color '..WarcryColor..'')
			end
			--Mode 3 Column 2
			if RecastMode3C2 == 'Erratic Flutter' then send_command('text recastmode3c2 color '..ErraticColor..'')
			elseif RecastMode3C2 == 'Battery Charge' then send_command('text recastmode3c2 color '..BatteryColor..'')
			elseif RecastMode3C2 == 'Occultation' then send_command('text recastmode3c2 color '..OccultColor..'')
			elseif RecastMode3C2 == 'Diamondhide' then send_command('text recastmode3c2 color '..DiamondColor..'')
			elseif RecastMode3C2 == 'Barrier Tusk' then send_command('text recastmode3c2 color '..BarrierTColor..'')
			elseif RecastMode3C2 == 'Cocoon' then send_command('text recastmode3c2 color '..CocoonColor..'')
			elseif RecastMode3C2 == 'Nat. Meditation' then send_command('text recastmode3c2 color '..NatMedColor..'')
			elseif RecastMode3C2 == 'Saline Coat' then send_command('text recastmode3c2 color '..SalineColor..'')
			elseif RecastMode3C2 == 'O. Counterstance' then send_command('text recastmode3c2 color '..OCStanceColor..'')
			elseif RecastMode3C2 == 'Memento Mori' then send_command('text recastmode3c2 color '..MementoColor..'')
			elseif RecastMode3C2 == 'Reactor Cool' then send_command('text recastmode3c2 color '..ReactorColor..'')
			elseif RecastMode3C2 == 'Feather Barrier' then send_command('text recastmode3c2 color '..FBarrierColor..'')
			elseif RecastMode3C2 == 'Amplification' then send_command('text recastmode3c2 color '..AmplifiColor..'')
			elseif RecastMode3C2 == 'Regeneration' then send_command('text recastmode3c2 color '..RegenerColor..'')
			elseif RecastMode3C2 == 'Magic Barrier' then send_command('text recastmode3c2 color '..MBarrierColor..'')
			elseif RecastMode3C2 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c2 color '..AggressorColor..'')
			elseif RecastMode3C2 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c2 color '..BerserkColor..'')
			elseif RecastMode3C2 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c2 color '..DefenderColor..'')
			elseif RecastMode3C2 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c2 color '..WarcryColor..'')
			end
			--Mode 3 Column 3
			if RecastMode3C3 == 'Erratic Flutter' then send_command('text recastmode3c3 color '..ErraticColor..'')
			elseif RecastMode3C3 == 'Battery Charge' then send_command('text recastmode3c3 color '..BatteryColor..'')
			elseif RecastMode3C3 == 'Occultation' then send_command('text recastmode3c3 color '..OccultColor..'')
			elseif RecastMode3C3 == 'Diamondhide' then send_command('text recastmode3c3 color '..DiamondColor..'')
			elseif RecastMode3C3 == 'Barrier Tusk' then send_command('text recastmode3c3 color '..BarrierTColor..'')
			elseif RecastMode3C3 == 'Cocoon' then send_command('text recastmode3c3 color '..CocoonColor..'')
			elseif RecastMode3C3 == 'Nat. Meditation' then send_command('text recastmode3c3 color '..NatMedColor..'')
			elseif RecastMode3C3 == 'Saline Coat' then send_command('text recastmode3c3 color '..SalineColor..'')
			elseif RecastMode3C3 == 'O. Counterstance' then send_command('text recastmode3c3 color '..OCStanceColor..'')
			elseif RecastMode3C3 == 'Memento Mori' then send_command('text recastmode3c3 color '..MementoColor..'')
			elseif RecastMode3C3 == 'Reactor Cool' then send_command('text recastmode3c3 color '..ReactorColor..'')
			elseif RecastMode3C3 == 'Feather Barrier' then send_command('text recastmode3c3 color '..FBarrierColor..'')
			elseif RecastMode3C3 == 'Amplification' then send_command('text recastmode3c3 color '..AmplifiColor..'')
			elseif RecastMode3C3 == 'Regeneration' then send_command('text recastmode3c3 color '..RegenerColor..'')
			elseif RecastMode3C3 == 'Magic Barrier' then send_command('text recastmode3c3 color '..MBarrierColor..'')
			elseif RecastMode3C3 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c3 color '..AggressorColor..'')
			elseif RecastMode3C3 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c3 color '..BerserkColor..'')
			elseif RecastMode3C3 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c3 color '..DefenderColor..'')
			elseif RecastMode3C3 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c3 color '..WarcryColor..'')
			end
			--Mode 3 Column 4
			if RecastMode3C4 == 'Erratic Flutter' then send_command('text recastmode3c4 color '..ErraticColor..'')
			elseif RecastMode3C4 == 'Battery Charge' then send_command('text recastmode3c4 color '..BatteryColor..'')
			elseif RecastMode3C4 == 'Occultation' then send_command('text recastmode3c4 color '..OccultColor..'')
			elseif RecastMode3C4 == 'Diamondhide' then send_command('text recastmode3c4 color '..DiamondColor..'')
			elseif RecastMode3C4 == 'Barrier Tusk' then send_command('text recastmode3c4 color '..BarrierTColor..'')
			elseif RecastMode3C4 == 'Cocoon' then send_command('text recastmode3c4 color '..CocoonColor..'')
			elseif RecastMode3C4 == 'Nat. Meditation' then send_command('text recastmode3c4 color '..NatMedColor..'')
			elseif RecastMode3C4 == 'Saline Coat' then send_command('text recastmode3c4 color '..SalineColor..'')
			elseif RecastMode3C4 == 'O. Counterstance' then send_command('text recastmode3c4 color '..OCStanceColor..'')
			elseif RecastMode3C4 == 'Memento Mori' then send_command('text recastmode3c4 color '..MementoColor..'')
			elseif RecastMode3C4 == 'Reactor Cool' then send_command('text recastmode3c4 color '..ReactorColor..'')
			elseif RecastMode3C4 == 'Feather Barrier' then send_command('text recastmode3c4 color '..FBarrierColor..'')
			elseif RecastMode3C4 == 'Amplification' then send_command('text recastmode3c4 color '..AmplifiColor..'')
			elseif RecastMode3C4 == 'Regeneration' then send_command('text recastmode3c4 color '..RegenerColor..'')
			elseif RecastMode3C4 == 'Magic Barrier' then send_command('text recastmode3c4 color '..MBarrierColor..'')
			elseif RecastMode3C4 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c4 color '..AggressorColor..'')
			elseif RecastMode3C4 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c4 color '..BerserkColor..'')
			elseif RecastMode3C4 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c4 color '..DefenderColor..'')
			elseif RecastMode3C4 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c4 color '..WarcryColor..'')
			end
			--Mode 3 Column 5
			if RecastMode3C5 == 'Erratic Flutter' then send_command('text recastmode3c5 color '..ErraticColor..'')
			elseif RecastMode3C5 == 'Battery Charge' then send_command('text recastmode3c5 color '..BatteryColor..'')
			elseif RecastMode3C5 == 'Occultation' then send_command('text recastmode3c5 color '..OccultColor..'')
			elseif RecastMode3C5 == 'Diamondhide' then send_command('text recastmode3c5 color '..DiamondColor..'')
			elseif RecastMode3C5 == 'Barrier Tusk' then send_command('text recastmode3c5 color '..BarrierTColor..'')
			elseif RecastMode3C5 == 'Cocoon' then send_command('text recastmode3c5 color '..CocoonColor..'')
			elseif RecastMode3C5 == 'Nat. Meditation' then send_command('text recastmode3c5 color '..NatMedColor..'')
			elseif RecastMode3C5 == 'Saline Coat' then send_command('text recastmode3c5 color '..SalineColor..'')
			elseif RecastMode3C5 == 'O. Counterstance' then send_command('text recastmode3c5 color '..OCStanceColor..'')
			elseif RecastMode3C5 == 'Memento Mori' then send_command('text recastmode3c5 color '..MementoColor..'')
			elseif RecastMode3C5 == 'Reactor Cool' then send_command('text recastmode3c5 color '..ReactorColor..'')
			elseif RecastMode3C5 == 'Feather Barrier' then send_command('text recastmode3c5 color '..FBarrierColor..'')
			elseif RecastMode3C5 == 'Amplification' then send_command('text recastmode3c5 color '..AmplifiColor..'')
			elseif RecastMode3C5 == 'Regeneration' then send_command('text recastmode3c5 color '..RegenerColor..'')
			elseif RecastMode3C5 == 'Magic Barrier' then send_command('text recastmode3c5 color '..MBarrierColor..'')
			elseif RecastMode3C5 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c5 color '..AggressorColor..'')
			elseif RecastMode3C5 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c5 color '..BerserkColor..'')
			elseif RecastMode3C5 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c5 color '..DefenderColor..'')
			elseif RecastMode3C5 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c5 color '..WarcryColor..'')
			end
			--Mode 3 Column 6
			if RecastMode3C6 == 'Erratic Flutter' then send_command('text recastmode3c6 color '..ErraticColor..'')
			elseif RecastMode3C6 == 'Battery Charge' then send_command('text recastmode3c6 color '..BatteryColor..'')
			elseif RecastMode3C6 == 'Occultation' then send_command('text recastmode3c6 color '..OccultColor..'')
			elseif RecastMode3C6 == 'Diamondhide' then send_command('text recastmode3c6 color '..DiamondColor..'')
			elseif RecastMode3C6 == 'Barrier Tusk' then send_command('text recastmode3c6 color '..BarrierTColor..'')
			elseif RecastMode3C6 == 'Cocoon' then send_command('text recastmode3c6 color '..CocoonColor..'')
			elseif RecastMode3C6 == 'Nat. Meditation' then send_command('text recastmode3c6 color '..NatMedColor..'')
			elseif RecastMode3C6 == 'Saline Coat' then send_command('text recastmode3c6 color '..SalineColor..'')
			elseif RecastMode3C6 == 'O. Counterstance' then send_command('text recastmode3c6 color '..OCStanceColor..'')
			elseif RecastMode3C6 == 'Memento Mori' then send_command('text recastmode3c6 color '..MementoColor..'')
			elseif RecastMode3C6 == 'Reactor Cool' then send_command('text recastmode3c6 color '..ReactorColor..'')
			elseif RecastMode3C6 == 'Feather Barrier' then send_command('text recastmode3c6 color '..FBarrierColor..'')
			elseif RecastMode3C6 == 'Amplification' then send_command('text recastmode3c6 color '..AmplifiColor..'')
			elseif RecastMode3C6 == 'Regeneration' then send_command('text recastmode3c6 color '..RegenerColor..'')
			elseif RecastMode3C6 == 'Magic Barrier' then send_command('text recastmode3c6 color '..MBarrierColor..'')
			elseif RecastMode3C6 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c6 color '..AggressorColor..'')
			elseif RecastMode3C6 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c6 color '..BerserkColor..'')
			elseif RecastMode3C6 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c6 color '..DefenderColor..'')
			elseif RecastMode3C6 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode3c6 color '..WarcryColor..'')
			end
			--Mode 4 Column 1
			if RecastMode4C1 == 'Erratic Flutter' then send_command('text recastmode4c1 color '..ErraticColor..'')
			elseif RecastMode4C1 == 'Battery Charge' then send_command('text recastmode4c1 color '..BatteryColor..'')
			elseif RecastMode4C1 == 'Occultation' then send_command('text recastmode4c1 color '..OccultColor..'')
			elseif RecastMode4C1 == 'Diamondhide' then send_command('text recastmode4c1 color '..DiamondColor..'')
			elseif RecastMode4C1 == 'Barrier Tusk' then send_command('text recastmode4c1 color '..BarrierTColor..'')
			elseif RecastMode4C1 == 'Cocoon' then send_command('text recastmode4c1 color '..CocoonColor..'')
			elseif RecastMode4C1 == 'Nat. Meditation' then send_command('text recastmode4c1 color '..NatMedColor..'')
			elseif RecastMode4C1 == 'Saline Coat' then send_command('text recastmode4c1 color '..SalineColor..'')
			elseif RecastMode4C1 == 'O. Counterstance' then send_command('text recastmode4c1 color '..OCStanceColor..'')
			elseif RecastMode4C1 == 'Memento Mori' then send_command('text recastmode4c1 color '..MementoColor..'')
			elseif RecastMode4C1 == 'Reactor Cool' then send_command('text recastmode4c1 color '..ReactorColor..'')
			elseif RecastMode4C1 == 'Feather Barrier' then send_command('text recastmode4c1 color '..FBarrierColor..'')
			elseif RecastMode4C1 == 'Amplification' then send_command('text recastmode4c1 color '..AmplifiColor..'')
			elseif RecastMode4C1 == 'Regeneration' then send_command('text recastmode4c1 color '..RegenerColor..'')
			elseif RecastMode4C1 == 'Magic Barrier' then send_command('text recastmode4c1 color '..MBarrierColor..'')
			elseif RecastMode4C1 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c1 color '..AggressorColor..'')
			elseif RecastMode4C1 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c1 color '..BerserkColor..'')
			elseif RecastMode4C1 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c1 color '..DefenderColor..'')
			elseif RecastMode4C1 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c1 color '..WarcryColor..'')
			end
			--Mode 4 Column 2
			if RecastMode4C2 == 'Erratic Flutter' then send_command('text recastmode4c2 color '..ErraticColor..'')
			elseif RecastMode4C2 == 'Battery Charge' then send_command('text recastmode4c2 color '..BatteryColor..'')
			elseif RecastMode4C2 == 'Occultation' then send_command('text recastmode4c2 color '..OccultColor..'')
			elseif RecastMode4C2 == 'Diamondhide' then send_command('text recastmode4c2 color '..DiamondColor..'')
			elseif RecastMode4C2 == 'Barrier Tusk' then send_command('text recastmode4c2 color '..BarrierTColor..'')
			elseif RecastMode4C2 == 'Cocoon' then send_command('text recastmode4c2 color '..CocoonColor..'')
			elseif RecastMode4C2 == 'Nat. Meditation' then send_command('text recastmode4c2 color '..NatMedColor..'')
			elseif RecastMode4C2 == 'Saline Coat' then send_command('text recastmode4c2 color '..SalineColor..'')
			elseif RecastMode4C2 == 'O. Counterstance' then send_command('text recastmode4c2 color '..OCStanceColor..'')
			elseif RecastMode4C2 == 'Memento Mori' then send_command('text recastmode4c2 color '..MementoColor..'')
			elseif RecastMode4C2 == 'Reactor Cool' then send_command('text recastmode4c2 color '..ReactorColor..'')
			elseif RecastMode4C2 == 'Feather Barrier' then send_command('text recastmode4c2 color '..FBarrierColor..'')
			elseif RecastMode4C2 == 'Amplification' then send_command('text recastmode4c2 color '..AmplifiColor..'')
			elseif RecastMode4C2 == 'Regeneration' then send_command('text recastmode4c2 color '..RegenerColor..'')
			elseif RecastMode4C2 == 'Magic Barrier' then send_command('text recastmode4c2 color '..MBarrierColor..'')
			elseif RecastMode4C2 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c2 color '..AggressorColor..'')
			elseif RecastMode4C2 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c2 color '..BerserkColor..'')
			elseif RecastMode4C2 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c2 color '..DefenderColor..'')
			elseif RecastMode4C2 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c2 color '..WarcryColor..'')
			end
			--Mode 4 Column 3
			if RecastMode4C3 == 'Erratic Flutter' then send_command('text recastmode4c3 color '..ErraticColor..'')
			elseif RecastMode4C3 == 'Battery Charge' then send_command('text recastmode4c3 color '..BatteryColor..'')
			elseif RecastMode4C3 == 'Occultation' then send_command('text recastmode4c3 color '..OccultColor..'')
			elseif RecastMode4C3 == 'Diamondhide' then send_command('text recastmode4c3 color '..DiamondColor..'')
			elseif RecastMode4C3 == 'Barrier Tusk' then send_command('text recastmode4c3 color '..BarrierTColor..'')
			elseif RecastMode4C3 == 'Cocoon' then send_command('text recastmode4c3 color '..CocoonColor..'')
			elseif RecastMode4C3 == 'Nat. Meditation' then send_command('text recastmode4c3 color '..NatMedColor..'')
			elseif RecastMode4C3 == 'Saline Coat' then send_command('text recastmode4c3 color '..SalineColor..'')
			elseif RecastMode4C3 == 'O. Counterstance' then send_command('text recastmode4c3 color '..OCStanceColor..'')
			elseif RecastMode4C3 == 'Memento Mori' then send_command('text recastmode4c3 color '..MementoColor..'')
			elseif RecastMode4C3 == 'Reactor Cool' then send_command('text recastmode4c3 color '..ReactorColor..'')
			elseif RecastMode4C3 == 'Feather Barrier' then send_command('text recastmode4c3 color '..FBarrierColor..'')
			elseif RecastMode4C3 == 'Amplification' then send_command('text recastmode4c3 color '..AmplifiColor..'')
			elseif RecastMode4C3 == 'Regeneration' then send_command('text recastmode4c3 color '..RegenerColor..'')
			elseif RecastMode4C3 == 'Magic Barrier' then send_command('text recastmode4c3 color '..MBarrierColor..'')
			elseif RecastMode4C3 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c3 color '..AggressorColor..'')
			elseif RecastMode4C3 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c3 color '..BerserkColor..'')
			elseif RecastMode4C3 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c3 color '..DefenderColor..'')
			elseif RecastMode4C3 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c3 color '..WarcryColor..'')
			end
			--Mode 4 Column 4
			if RecastMode4C4 == 'Erratic Flutter' then send_command('text recastmode4c4 color '..ErraticColor..'')
			elseif RecastMode4C4 == 'Battery Charge' then send_command('text recastmode4c4 color '..BatteryColor..'')
			elseif RecastMode4C4 == 'Occultation' then send_command('text recastmode4c4 color '..OccultColor..'')
			elseif RecastMode4C4 == 'Diamondhide' then send_command('text recastmode4c4 color '..DiamondColor..'')
			elseif RecastMode4C4 == 'Barrier Tusk' then send_command('text recastmode4c4 color '..BarrierTColor..'')
			elseif RecastMode4C4 == 'Cocoon' then send_command('text recastmode4c4 color '..CocoonColor..'')
			elseif RecastMode4C4 == 'Nat. Meditation' then send_command('text recastmode4c4 color '..NatMedColor..'')
			elseif RecastMode4C4 == 'Saline Coat' then send_command('text recastmode4c4 color '..SalineColor..'')
			elseif RecastMode4C4 == 'O. Counterstance' then send_command('text recastmode4c4 color '..OCStanceColor..'')
			elseif RecastMode4C4 == 'Memento Mori' then send_command('text recastmode4c4 color '..MementoColor..'')
			elseif RecastMode4C4 == 'Reactor Cool' then send_command('text recastmode4c4 color '..ReactorColor..'')
			elseif RecastMode4C4 == 'Feather Barrier' then send_command('text recastmode4c4 color '..FBarrierColor..'')
			elseif RecastMode4C4 == 'Amplification' then send_command('text recastmode4c4 color '..AmplifiColor..'')
			elseif RecastMode4C4 == 'Regeneration' then send_command('text recastmode4c4 color '..RegenerColor..'')
			elseif RecastMode4C4 == 'Magic Barrier' then send_command('text recastmode4c4 color '..MBarrierColor..'')
			elseif RecastMode4C4 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c4 color '..AggressorColor..'')
			elseif RecastMode4C4 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c4 color '..BerserkColor..'')
			elseif RecastMode4C4 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c4 color '..DefenderColor..'')
			elseif RecastMode4C4 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c4 color '..WarcryColor..'')
			end
			--Mode 4 Column 5
			if RecastMode4C5 == 'Erratic Flutter' then send_command('text recastmode4c5 color '..ErraticColor..'')
			elseif RecastMode4C5 == 'Battery Charge' then send_command('text recastmode4c5 color '..BatteryColor..'')
			elseif RecastMode4C5 == 'Occultation' then send_command('text recastmode4c5 color '..OccultColor..'')
			elseif RecastMode4C5 == 'Diamondhide' then send_command('text recastmode4c5 color '..DiamondColor..'')
			elseif RecastMode4C5 == 'Barrier Tusk' then send_command('text recastmode4c5 color '..BarrierTColor..'')
			elseif RecastMode4C5 == 'Cocoon' then send_command('text recastmode4c5 color '..CocoonColor..'')
			elseif RecastMode4C5 == 'Nat. Meditation' then send_command('text recastmode4c5 color '..NatMedColor..'')
			elseif RecastMode4C5 == 'Saline Coat' then send_command('text recastmode4c5 color '..SalineColor..'')
			elseif RecastMode4C5 == 'O. Counterstance' then send_command('text recastmode4c5 color '..OCStanceColor..'')
			elseif RecastMode4C5 == 'Memento Mori' then send_command('text recastmode4c5 color '..MementoColor..'')
			elseif RecastMode4C5 == 'Reactor Cool' then send_command('text recastmode4c5 color '..ReactorColor..'')
			elseif RecastMode4C5 == 'Feather Barrier' then send_command('text recastmode4c5 color '..FBarrierColor..'')
			elseif RecastMode4C5 == 'Amplification' then send_command('text recastmode4c5 color '..AmplifiColor..'')
			elseif RecastMode4C5 == 'Regeneration' then send_command('text recastmode4c5 color '..RegenerColor..'')
			elseif RecastMode4C5 == 'Magic Barrier' then send_command('text recastmode4c5 color '..MBarrierColor..'')
			elseif RecastMode4C5 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c5 color '..AggressorColor..'')
			elseif RecastMode4C5 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c5 color '..BerserkColor..'')
			elseif RecastMode4C5 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c5 color '..DefenderColor..'')
			elseif RecastMode4C5 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c5 color '..WarcryColor..'')
			end
			--Mode 4 Column 6
			if RecastMode4C6 == 'Erratic Flutter' then send_command('text recastmode4c6 color '..ErraticColor..'')
			elseif RecastMode4C6 == 'Battery Charge' then send_command('text recastmode4c6 color '..BatteryColor..'')
			elseif RecastMode4C6 == 'Occultation' then send_command('text recastmode4c6 color '..OccultColor..'')
			elseif RecastMode4C6 == 'Diamondhide' then send_command('text recastmode4c6 color '..DiamondColor..'')
			elseif RecastMode4C6 == 'Barrier Tusk' then send_command('text recastmode4c6 color '..BarrierTColor..'')
			elseif RecastMode4C6 == 'Cocoon' then send_command('text recastmode4c6 color '..CocoonColor..'')
			elseif RecastMode4C6 == 'Nat. Meditation' then send_command('text recastmode4c6 color '..NatMedColor..'')
			elseif RecastMode4C6 == 'Saline Coat' then send_command('text recastmode4c6 color '..SalineColor..'')
			elseif RecastMode4C6 == 'O. Counterstance' then send_command('text recastmode4c6 color '..OCStanceColor..'')
			elseif RecastMode4C6 == 'Memento Mori' then send_command('text recastmode4c6 color '..MementoColor..'')
			elseif RecastMode4C6 == 'Reactor Cool' then send_command('text recastmode4c6 color '..ReactorColor..'')
			elseif RecastMode4C6 == 'Feather Barrier' then send_command('text recastmode4c6 color '..FBarrierColor..'')
			elseif RecastMode4C6 == 'Amplification' then send_command('text recastmode4c6 color '..AmplifiColor..'')
			elseif RecastMode4C6 == 'Regeneration' then send_command('text recastmode4c6 color '..RegenerColor..'')
			elseif RecastMode4C6 == 'Magic Barrier' then send_command('text recastmode4c6 color '..MBarrierColor..'')
			elseif RecastMode4C6 == 'Aggressor' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c6 color '..AggressorColor..'')
			elseif RecastMode4C6 == 'Berserk' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c6 color '..BerserkColor..'')
			elseif RecastMode4C6 == 'Defender' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c6 color '..DefenderColor..'')
			elseif RecastMode4C6 == 'Warcry' and player.sub_job == 'WAR' and player.sub_job_level >= 1 then send_command('text recastmode4c6 color '..WarcryColor..'')
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
			if NotiTime == 'On'and  HUD == 'On' then
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
			if NotiTime == 'On'and  HUD == 'On' then
				send_command('text notifications text "«« 5 Minutes Remaining »»";text notifications color 255 255 50')
			end
		end
	elseif org:find('1 shadow absorbed by') and org:find(''..player.name..'') then
		ShadowCount = ShadowCount - 1
	elseif org:find('2 shadows absorbed by') and org:find(''..player.name..'') then
		ShadowCount = ShadowCount - 2
	elseif org:find('3 shadows absorbed by') and org:find(''..player.name..'') then
		ShadowCount = ShadowCount - 3
	elseif org:find('4 shadows absorbed by') and org:find(''..player.name..'') then
		ShadowCount = ShadowCount - 4
	elseif org:find('5 shadows absorbed by') and org:find(''..player.name..'') then
		ShadowCount = ShadowCount - 5
	elseif org:find('6 shadows absorbed by') and org:find(''..player.name..'') then
		ShadowCount = ShadowCount - 6
	elseif org:find('7 shadows absorbed by') and org:find(''..player.name..'') then
		ShadowCount = ShadowCount - 7
	elseif org:find('8 shadows absorbed by') and org:find(''..player.name..'') then
		ShadowCount = ShadowCount - 8
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
	elseif NotiSortie == 'On' and org:find('Degei') then
		if org:find('Flaming Kick') then
			send_command('input /p Water (Flaming Kick) <call14>')
		elseif org:find('Flashflood') then
			send_command('input /p Lightning (Flashflood) <call14>')
		elseif org:find('Icy Grasp') then
			send_command('input /p Fire (Icy Grasp) <call14>')
		elseif org:find('Eroding Flesh') then
			send_command('input /p Wind (Eroding Flesh) <call14>')
		elseif org:find('Fulminous Smash') then
			send_command('input /p Earth (Fulminous Smash) <call14>')
		end
	end
end)

-------------------------------------------
--             FILE UNLOAD               --
-------------------------------------------

function file_unload()
	if BLUAlert == 'On' then
		send_command('lua unload blualert') --unload the blualert plugin
	end
	if HUD == 'On' then
		--delete the different text objects
		send_command('text bg1 delete;text bg2 delete;text bg3 delete;text recastmode1c1 delete;text recastmode1c2 delete;text recastmode1c3 delete;text recastmode1c4 delete;text recastmode1c5 delete;text recastmode1c6 delete;text recastmode2c1 delete;text recastmode2c2 delete;text recastmode2c3 delete;text recastmode2c4 delete;text recastmode2c5 delete;text recastmode2c6 delete;text recastmode3c1 delete;text recastmode3c2 delete;text recastmode3c3 delete;text recastmode3c4 delete;text recastmode3c5 delete;text recastmode3c6 delete;text recastmode4c1 delete;text recastmode4c2 delete;text recastmode4c3 delete;text recastmode4c4 delete;text recastmode4c5 delete;text recastmode4c6 delete;text loading delete;text mode delete;text notifications delete;text debuffs delete;text aftermath delete')
	end
end

--[[


-------------------------------------------
--            KEYS NOTEPAD               --
-------------------------------------------

React - can put react type code into file?
Ou - do the % callouts when in Omen zone and target is Ou and target hpp
"Trade complete" is there a "Trade cancelled"?

1-hour Notification with Notification Override
Blue color for 1-hours bg_color
51 102 255
maybe white for the bg_color that blue for color?

 --]]
