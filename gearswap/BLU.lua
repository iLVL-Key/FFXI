-------------------------------------------
-- Keys Gearswap lua file for Blue Mage  --
-------------------------------------------
--[[

Recommended Windower Addons: Azuresets

Updates to this file and other GearSwap files and addons can be found at
https://github.com/iLVL-Key/FFXI

Place both this file and the sounds folder inside the GearSwap data folder
	/addons/GearSwap/data/sounds/
	/addons/GearSwap/data/BLU.lua

--------------------

This file has 5 modes available to use and customize, though you do not need to use each one.

To switch into each mode, create a macro for each one you are using with the following
	/console mode#
With # being 1-5 depending on which ones you are using. See Pro Tips below for more macro suggestions.

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

-------------------------------------------
--               PRO TIPS                --
-------------------------------------------

1) Use macro page (set) 1 for your mode macros and a separate macro page for each mode. To move to a different
macro page use the following in each mode macro
	/macro set #
With # being the number of the page for each mode. This will automatically switch to that book page at the same time.

2) If you use Azuresets, add the following to each macro
	/console aset spellset nameofyourspellset
This will automatically load each spellset at the same time.

For example, a macro to switch into Melee Mode might look like:
	/console Mode2
	/console aset spellset melee
	/macro set 3

3) You can remove the cooldown timer from Azuresets with a very simple edit.
Open the azuresets file:
	/addons/azuresets/azuresets.lua
Look for the following on lines 150 and 179:
	windower.send_command('@timers c "Blue Magic Cooldown" 60 up')
Simply add two dashes (--) at the start of those lines so they now looks like this:
	--windower.send_command('@timers c "Blue Magic Cooldown" 60 up')
Then SAVE the file and reload it in game by typing the following directly into your chatlog:
	//lua r azuresets
That's it!

--]]

--vIGNORE THESEv--
color = {} color.Mode1 = {} color.Mode2 = {} color.Mode3 = {} color.Mode4 = {} color.Mode5 = {} color.Light = {} color.Fire = {} color.Ice = {} color.Air = {} color.Earth = {} color.Thunder = {} color.Water = {} color.Dark = {} color.None = {} color.AM1 = {} color.AM2 = {} color.AM3 = {} color.abil = {} color.abil.ready = {} color.abil.active = {} color.abil.cooldown = {} color.abil.flash = {} color.abil.notfound = {} modeName = {} HUDrecast = {} HUDrecast.Mode1 = {} HUDrecast.Mode2 = {} HUDrecast.Mode3 = {} HUDrecast.Mode4 = {} HUDrecast.Mode5 = {} sets.Mode1 = {} sets.Mode2 = {} sets.Mode3 = {} sets.Mode4 = {} sets.Mode5 = {} sets.None = {}
--^IGNORE THESE^--

-------------------------------------------
--                OPTIONS                --
-------------------------------------------

Book			=	'1'		--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
Page			=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
CJTimer			=	'p'		--[p/e/Off]		Displays a timer for Cruel Joke in the selected chat channel (party, echo, or off).
ALTimer			=	'On'	--[On/Off]		Displays a timer for Azure Lore in echo.
UWTimer			=	'On'	--[On/Off]		Displays a timer for Unbridled Wisdom in echo.
BLUAlert		=	'Off'	--[On/Off]		Automatically loads and unloads the BLUAlert Windower addon on file load/unload.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions
							--				(Town limits this to town gear only).
AlertSounds		=	'On'	--[On/Off]		Plays a sound on alerts.
UseEcho			=	'R'		--[E/R/Off]		Automatically uses an (E)cho Drop or (R)emedy instead of spell when you are silenced.
OccShadows		=	13		--				How many shadows does your Occultation create. Every 50 Blue Magic Skill is 1 shadow (ie 12 at 600 skill).

-- Heads Up Display --
HUDposX			=	100		--	X position for the HUD. 0 is left of the window, increasing this number will move it to the right.
HUDposY			=	100		--	Y position for the HUD. 0 is top of the window, increasing this number will move it downward.
FontSize		=	10		--	Adjust the font size. Changing this may require you to adjust the Spacers below as well.
LineSpacer		=	16		--	Space in pixels between each Line of the HUD.
ColumnSpacer	=	90.5	--	Space in pixels between each Column of the HUD.
ShowTPMeter		=	'On'	--[On/Off]		Show the mini TP Meter inside the Weapons area.

--HUD Mode Names
modeName.Mode1 = 'General'
modeName.Mode2 = 'Melee'
modeName.Mode3 = 'Nuke'
modeName.Mode4 = 'Support'
modeName.Mode5 = 'Tank'

--  General Notifications  --
Noti3000TP			=	'On'	--[On/Off]	Displays a notification when you have 3000 TP.
NotiTrade			=	'On'	--[On/Off]	Displays a notification when someone trades you.
NotiInvite			=	'On'	--[On/Off]	Displays a notification when someone invites to a party/alliance.
NotiSneak			=	'On'	--[On/Off]	Displays a notification when Sneak is about to wear off.
NotiInvis			=	'On'	--[On/Off]	Displays a notification when Invisible is about to wear off.
NotiReraise			=	'On'	--[On/Off]	Displays a notification when reraise wears off.
NotiFood			=	'On'	--[On/Off]	Displays a notification when food wears off.
NotiLowMP			=	'On'	--[On/Off]	Displays a notification when MP is under 20%.
NotiLowHP			=	'On'	--[On/Off]	Displays a notification when HP is low.
NotiDamage			=	'On'	--[On/Off]	Displays your Weapon Skill, Skillchain, and Magic Burst damage.
ReraiseReminder		=	'On'	--[On/Off]	Displays an occasional reminder if Reraise is not up.
NotiTime			=	'On'	--[On/Off]	Displays a notification for time remaining notices.

-- Debuff Notifications --
NotiDoom			=	'On'	--[On/Off]	Displays a notification when you are doomed.
NotiCharm			=	'On'	--[On/Off]	Displays a notification when you are charmed/animated.
NotiTerror			=	'On'	--[On/Off]	Displays a notification when you are terrorized.
NotiPetrification	=	'On'	--[On/Off]	Displays a notification when you are petrified.
NotiSleep			=	'On'	--[On/Off]	Displays a notification when you are slept.
NotiStun			=	'On'	--[On/Off]	Displays a notification when you are stunned.
NotiSilence			=	'On'	--[On/Off]	Displays a notification when you are silenced/muted.
NotiParalysis		=	'On'	--[On/Off]	Displays a notification when you are paralyzed.
NotiPlague			=	'On'	--[On/Off]	Displays a notification when you are plagued.
NotiCurse			=	'On'	--[On/Off]	Displays a notification when you are cursed/haunted/zombied.
NotiAmnesia			=	'On'	--[On/Off]	Displays a notification when you have amnesia.
NotiTaint			=	'On'	--[On/Off]	Displays a notification when you are tainted.
NotiEncumbrance		=	'On'	--[On/Off]	Displays a notification when you are encumbered.

-------------------------------------------
--           ADVANCED OPTIONS            --
-------------------------------------------

ShowHUD			=	'On'	--[On/Off]  Initial state of the HUD. Use `//hud` to show/hide the HUD in game.
DTBind			=	'^d'	--Sets the keyboard shortcut you would like to activate the Damage Taken Override. CTRL+D (^d) is default.
WCBind			=	'^h'	--Sets the keyboard shortcut you would like to activate the Weapon Cycle. CTRL+H (^h) is default.
							--    ^ = CTRL    ! = ALT    @ = WIN    # = APPS    ~ = SHIFT
LowHPThreshold	=	1000	--Below this number is considered Low HP.
DangerRepeat	=	10		--Maximum number of times the Danger Sound will repeat, once per second.
RRReminderTimer	=	1800	--Delay in seconds between checks to see if Reraise is up (300 is 5 minutes).
NotiDelay		=	6		--Delay in seconds before certain notifications will automatically clear.
AddCommas		=	'On'	--[On/Off]  Adds commas to damage numbers.

-------------------------------------------
--              HUD RECAST               --
-------------------------------------------

-- Controls what is displayed in the HUD Recast section.
-- The first column tells the file which ability/spell to place in that slot, the following are valid for use:
--		Abilities: Azure Lore, Unbridled Wisdom, Aggressor, Berserk, Burst Affinity, Chain Affinity, Contradance, Convergence, Defender, Diffusion, Divine Seal, Efflux, Elemental Seal, Flourishes I, Flourishes II, High Jump, Jigs, Jump, Sambas, Steps, Super Jump, Unbridled Learning, Warcry
--		Spells: Amplification, Animating Wail, Barrier Tusk, Battery Charge, Carcharian Verve, Cocoon, Diamondhide, Erratic Flutter, Feather Barrier, Magic Barrier, Memento Mori, Mighty Guard, Nature's Meditation, Occultation, Orcish Counterstance, Plasma Charge, Reactor Cool, Refueling, Regeneration, Saline Coat, Triumphant Roar
-- The "_sh" column allows you to change the name displayed if you would like, leave blank otherwise
-- NOTE: Names will automatically be truncated to 10 characters to fit correctly.

--Mode 1
HUDrecast.Mode1.Abil01 =	"Erratic Flutter"	HUDrecast.Mode1.Abil01_sh = "Erratic"
HUDrecast.Mode1.Abil02 =	"Battery Charge"	HUDrecast.Mode1.Abil02_sh = "Battery"
HUDrecast.Mode1.Abil03 =	"Occultation"		HUDrecast.Mode1.Abil03_sh = "Occult"
HUDrecast.Mode1.Abil04 =	"Diamondhide"		HUDrecast.Mode1.Abil04_sh = "Diamond"
HUDrecast.Mode1.Abil05 =	"Barrier Tusk"		HUDrecast.Mode1.Abil05_sh = "Barrier"
HUDrecast.Mode1.Abil06 =	"Reactor Cool"		HUDrecast.Mode1.Abil06_sh = "Reactor"
--Mode 2
HUDrecast.Mode2.Abil01 =	"Erratic Flutter"		HUDrecast.Mode2.Abil01_sh = "Erratic"
HUDrecast.Mode2.Abil02 =	"Occultation"			HUDrecast.Mode2.Abil02_sh = "Occult"
HUDrecast.Mode2.Abil03 =	"Cocoon"				HUDrecast.Mode2.Abil03_sh = ""
HUDrecast.Mode2.Abil04 =	"Nature's Meditation"	HUDrecast.Mode2.Abil04_sh = "Nat Med"
HUDrecast.Mode2.Abil05 =	"Berserk"				HUDrecast.Mode2.Abil05_sh = ""
HUDrecast.Mode2.Abil06 =	"Aggressor"				HUDrecast.Mode2.Abil06_sh = ""
--Mode 3
HUDrecast.Mode3.Abil01 =	"Erratic Flutter"	HUDrecast.Mode3.Abil01_sh = "Erratic"
HUDrecast.Mode3.Abil02 =	"Battery Charge"	HUDrecast.Mode3.Abil02_sh = "Battery"
HUDrecast.Mode3.Abil03 =	"Occultation"		HUDrecast.Mode3.Abil03_sh = "Occult"
HUDrecast.Mode3.Abil04 =	"Diamondhide"		HUDrecast.Mode3.Abil04_sh = "Diamond"
HUDrecast.Mode3.Abil05 =	"Barrier Tusk"		HUDrecast.Mode3.Abil05_sh = "Barrier"
HUDrecast.Mode3.Abil06 =	"Carcharian Verve"	HUDrecast.Mode3.Abil06_sh = "C Verve"
--Mode 4
HUDrecast.Mode4.Abil01 =	"Erratic Flutter"	HUDrecast.Mode4.Abil01_sh = "Erratic"
HUDrecast.Mode4.Abil02 =	"Battery Charge"	HUDrecast.Mode4.Abil02_sh = "Battery"
HUDrecast.Mode4.Abil03 =	"Occultation"		HUDrecast.Mode4.Abil03_sh = "Occult"
HUDrecast.Mode4.Abil04 =	"Diamondhide"		HUDrecast.Mode4.Abil04_sh = "Diamond"
HUDrecast.Mode4.Abil05 =	"Carcharian Verve"	HUDrecast.Mode4.Abil05_sh = "C Verve"
HUDrecast.Mode4.Abil06 =	"Mighty Guard"		HUDrecast.Mode4.Abil06_sh = "Mighty Grd"
--Mode 5
HUDrecast.Mode5.Abil01 =	"Erratic Flutter"	HUDrecast.Mode5.Abil01_sh = "Erratic"
HUDrecast.Mode5.Abil02 =	"Battery Charge"	HUDrecast.Mode5.Abil02_sh = "Battery"
HUDrecast.Mode5.Abil03 =	"Occultation"		HUDrecast.Mode5.Abil03_sh = "Occult"
HUDrecast.Mode5.Abil04 =	"Diamondhide"		HUDrecast.Mode5.Abil04_sh = "Diamond"
HUDrecast.Mode5.Abil05 =	"Cocoon"			HUDrecast.Mode5.Abil05_sh = ""
HUDrecast.Mode5.Abil06 =	"Carcharian Verve"	HUDrecast.Mode5.Abil06_sh = "C Verve"

-------------------------------------------
--             COLOR VALUES              --
-------------------------------------------

--Modes

--Mode 1
color.Mode1.r = 255
color.Mode1.g = 125
color.Mode1.b = 125
--Mode 2
color.Mode2.r = 125
color.Mode2.g = 125
color.Mode2.b = 255
--Mode 3
color.Mode3.r = 125
color.Mode3.g = 255
color.Mode3.b = 125
--Mode 4
color.Mode4.r = 255
color.Mode4.g = 125
color.Mode4.b = 255
--Mode 5
color.Mode5.r = 255
color.Mode5.g = 255
color.Mode5.b = 125
--None
color.None.r = 255
color.None.g = 50
color.None.b = 50

--Aftermath

--Level 1
color.AM1.r = 0
color.AM1.g = 127
color.AM1.b = 255
--Level 2
color.AM2.r = 50
color.AM2.g = 255
color.AM2.b = 50
--Level 3
color.AM3.r = 255
color.AM3.g = 255
color.AM3.b = 50

--Element Colors

color.Light.r = 255
color.Light.g = 248
color.Light.b = 220
color.Fire.r = 255
color.Fire.g = 0
color.Fire.b = 0
color.Ice.r = 135
color.Ice.g = 206
color.Ice.b = 250
color.Air.r = 50
color.Air.g = 205
color.Air.b = 50
color.Earth.r = 250
color.Earth.g = 130
color.Earth.b = 40
color.Thunder.r = 186
color.Thunder.g = 85
color.Thunder.b = 211
color.Water.r = 30
color.Water.g = 144
color.Water.b = 255
color.Dark.r = 200
color.Dark.g = 30
color.Dark.b = 80

--HUD Recast

--Ready to use
color.abil.ready.r = 255
color.abil.ready.g = 50
color.abil.ready.b = 50
--Currently active
color.abil.active.r = 75
color.abil.active.g = 255
color.abil.active.b = 75
--On cooldown
color.abil.cooldown.r = 255
color.abil.cooldown.g = 165
color.abil.cooldown.b = 0
--Flash (now ready)
color.abil.flash.r = 255
color.abil.flash.g = 255
color.abil.flash.b = 125
--Not Found
color.abil.notfound.r = 125
color.abil.notfound.g = 125
color.abil.notfound.b = 125

-------------------------------------------
--                WEAPONS                --
-------------------------------------------

-- These are the Main/Sub combos that the Weapon Cycle goes through. Add more pairs on new lines as needed
-- NOTE: if a slot should be empty, use `empty` with no quotation marks. ie: {"Fruit Punches", empty},
WeaponCycle = {
	{"Tizona", "Bunzi's Rod"},
	{"Tizona", "Almace"},
	{"Tizona", "Thibron"},
	{"Naegling", "Thibron"},
	{"Maxentius", "Thibron"},
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

-------------------------------------------
--               GEAR SETS               --
-------------------------------------------

function get_sets()

-- Idle Mode 1 (Refresh, Regain, Regen, Damage Taken-, Enmity-)
-- NOTE: All other Modes will use this Idle set unless gear is specified in each one. If you only care to use one Idle set, regardless of Mode, you may ignore the other Idle sets. They are only available should you wish to make use of them.
sets.Mode1.idle = {
	ammo="Staunch Tathlum +1",
	head="Rawhide Mask",
	body="Hashishin Mintan +3",
	hands={ name="Herculean Gloves", augments={'Enmity-4','"Avatar perpetuation cost" -2','"Refresh"+2','Accuracy+3 Attack+3',}},
	legs="Carmine Cuisses +1",
	feet={ name="Herculean Boots", augments={'Pet: "Regen"+2','VIT+1','"Refresh"+2','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
	neck="Loricate Torque +1",
	waist="Flume Belt",
	left_ear="Suppanomimi",
	--left_ear="Hearty Earring",
	right_ear="Ethereal Earring",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back={ name="Rosmerta's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}},
}

-- Idle Mode 2
sets.Mode2.idle = set_combine(sets.Mode1.idle, {

})

-- Idle Mode 3
sets.Mode3.idle = set_combine(sets.Mode1.idle, {

})

-- Idle Mode 4
sets.Mode4.idle = set_combine(sets.Mode1.idle, {

})

-- Idle Mode 5
sets.Mode5.idle = set_combine(sets.Mode1.idle, {

})

-- DPS (Accuracy, Double/Triple Attack, DEX, Store TP, Attack, Refresh, Regain, Regen)
-- NOTE: All other Modes will use this DPS set unless gear is specified in each one. If you only care to use one DPS set, regardless of Mode, you may ignore the other DPS sets. They are only available should you wish to make use of them.
sets.Mode1.dps = {
	ammo="Coiste Bodhar",
	head="Adhemar Bonnet +1",
	body="Adhemar Jacket +1",
	hands="Adhemar Wrist. +1",
	legs="Gleti's Breeches",
	feet={ name="Herculean Boots", augments={'Attack+21','"Triple Atk."+3','STR+10','Accuracy+15',}},
	neck="Mirage Stole +2",
	waist="Windbuffet Belt +1",
	left_ear="Suppanomimi",
	right_ear="Hashi. Earring +1",
	left_ring="Epona's Ring",
	right_ring="Hetairoi Ring",
	back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
}

-- DPS Mode 2
sets.Mode2.dps = set_combine(sets.Mode1.dps, {

})

-- DPS Mode 3
sets.Mode3.dps = set_combine(sets.Mode1.dps, {

})

-- DPS Mode 4
sets.Mode4.dps = set_combine(sets.Mode1.dps, {

})

-- DPS Mode 5
sets.Mode5.dps = set_combine(sets.Mode1.dps, {

})

-- DT Override (Damage Taken-, Magic Evasion)
-- Will override all other gear sets and inherit unused slots from them
sets.dtoverride = {
	head="Nyame Helm",
	body="Hashishin Mintan +3",
	hands="Hashi. Bazu. +3",
	legs="Hashishin Tayt +3",
	feet="Nyame Sollerets",
}

-- Oh Shit
-- Full DT- and everything you've got with Absorbs or Annuls Damage
sets.ohshit = {
	head="Nyame Helm",
	body="Malignance Tabard",
	hands="Nyame Gauntlets",
	legs="Hashishin Tayt +3",
	feet="Nyame Sollerets",
	neck="Warder's Charm +1",
	left_ring="Shadow Ring",
	right_ring="Defending Ring",
	back="Shadow Mantle"
}

-- Rest
sets.rest = {
	waist="Austerity Belt",
}

-- Weapon Skill - Basic (STR, Weapon Skill Damage, Attack, Double/Triple Attack)
sets.ws = {
	ammo="Coiste Bodhar",
	head="Hashishin Kavuk +3",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Mirage Stole +2",
	waist="Sailfi Belt +1",
	left_ear="Moonshade Earring",
	right_ear="Hashi. Earring +1",
	left_ring="Karieyh Ring +1",
	right_ring="Cornelia's Ring",
	back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
}

-- Savage Blade (50% STR, 50% MND mod)
-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
sets["Savage Blade"] = set_combine(sets.ws, {
	right_ear="Ishvara Earring",
})

-- Sanguine Blade (Dark Magical, 50% STR, 50% MND mod)
-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
sets["Sanguine Blade"] = set_combine(sets.ws, {
	ammo="Ghastly Tathlum +1",
	head="Pixie Hairpin +1",
	neck="Sibyl Scarf",
	waist="Eschan Stone",
	left_ear="Friomisi Earring",
	right_ear="Regal Earring",
	left_ring="Archon Ring",
})

-- Requiescat (~80% MND mod)
-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
sets["Requiescat"] = set_combine(sets.ws, {
	neck="Fotia Gorget",
	waist="Fotia Belt",
	right_ear="Regal Earring",
	left_ring="Stikini Ring +1",
	right_ring="Metamor. Ring +1",
	--right_ring="Rufescent Ring",
})

-- Chant du Cygne (80% DEX mod)
-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
sets["Chant du Gyne"] = set_combine(sets.ws, {
	head="Adhemar Bonnet +1",
	body="Gleti's Cuirass",
	hands="Adhemar Wrist. +1",
	legs="Gleti's Breeches",
	feet="Aya. Gambieras +2",
	waist="Fotia Belt",
	left_ear="Mache Earring +1",
	right_ear="Odr Earring",
	left_ring="Epona's Ring",
	right_ring="Hetairoi Ring",
	back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Damage taken-5%',}},
})

-- Expiacion (30% STR, 30% INT, 20% DEX mod)
-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
sets["Expiacion"] = set_combine(sets.ws, {

})

-- Imperator (70% DEX, 70% MND, mod)
-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
sets["Imperator"] = set_combine(sets.ws, {

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

-- Snapshot
-- For ranged attacks when you need to pull without aggroing via magic
sets.snapshot = {

}

-- Physical Spells (STR, Accuracy, Attack)	(Macc only affects add'l effects landing, NOT the damage from the physical spell itself)
sets.physical = {
	ammo="Coiste Bodhar",
	head="Hashishin Kavuk +3",
	body="Hashishin Mintan +3",
	hands="Hashi. Bazu. +3",
	legs="Hashishin Tayt +3",
	feet="Hashi. Basmak +3",
	neck="Mirage Stole +2",
	waist="Sailfi Belt +1",
	left_ear="Mache Earring +1",
	right_ear="Hashi. Earring +1",
	left_ring="Ilabrat Ring",
	right_ring="Jhakri Ring",
	back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
}

-- Magical Spells (Magic Attack Bonus, Magic Damage, INT, Magic Accuracy)
sets.magical = {
	ammo="Ghastly Tathlum +1",
	head="Hashishin Kavuk +3",
	body="Amalric Doublet +1",
	hands="Hashi. Bazu. +3",
	legs="Amalric Slops +1",
	feet="Hashi. Basmak +3",
	neck="Sibyl Scarf",
	waist="Orpheus's Sash",
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
	head="Hashishin Kavuk +3",
	body="Hashishin Mintan +3",
	hands="Hashi. Bazu. +3",
	legs="Hashishin Tayt +3",
	feet="Hashi. Basmak +3",
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
	legs="Hashishin Tayt +3",
	feet="Luhlaza Charuqs +3",
	neck="Mirage Stole +2",
	left_ear="Njordr Earring",
	right_ear="Hashi. Earring +1",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back="Cornflower Cape",
}

-- Healing (Cure Potency, MND+)
sets.healing = {
	head="Hashishin Kavuk +3",
	body="Hashishin Mintan +3",
	hands="Hashi. Bazu. +3",
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
	head="Nyame Helm",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Unmoving Collar +1",
	waist="Plat. Mog. Belt",
	left_ear="Odnowa Earring +1",
	right_ear="Tuisto Earring",
	left_ring="Ilabrat Ring",
	right_ring="Prolix Ring",
	back="Moonlight Cape",
})

-- Battery (Refresh augmenting gear, not Refresh+)
sets.battery = {
	head="Amalric Coif +1",
	back="Grapevine Cape",
	waist="Gishdubar Sash",
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
	head="Hashishin Kavuk +3",
}

-- Burst Affinity (must remain equipped during midcast)
sets.burstaffinity = {
	legs="Assim. Shalwar +3",
	feet="Hashi. Basmak +3",
}

-- Diffusion (must remain equipped during midcast)
sets.diffusion = {
	feet="Luhlaza Charuqs +3",
}

-- Efflux
sets.efflux = {
	legs="Hashishin Tayt +3",
}

-- Default Town Gear (Put all your fancy-pants gear in here you want to showboat around town. Does not lockstyle this gear, only equips)
sets.town = set_combine(sets[Mode].idle, {

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




FileVersion = '18.3.2'

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
sets.None.idle = sets.Mode1.idle
sets.None.dps = sets.Mode1.dps
res = require('resources')
texts = require('texts')
weaponskills = res.weapon_skills
spells = res.spells
Mode = 'None' --We don't yet know what spellset you're using
modeName.None = 'None'
NotiLowMPToggle = 'Off' --Start with the toggle off for the Low MP Notification so that it can trigger
DTOverride = "Off" --Start with the Damage Taken Override off
SpellSetCooldown = 0 --Spell Cooldown starts at 0 until its activated by the Azuresets plugin if you use it
RRRCountdown = RRReminderTimer
HUDposYLine1 = HUDposY
ShadowCount = 0
Heartbeat = 0 --set to 0 just to start the Heartbeat running
GreetingDelay = 6 --delay to display greeting and file version info
Zoning = false --flips automatically to hide the HUD while zoning
InCS = false --flips automatically to hide the HUD while in a cs
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
currentTP = 0
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

--create a new table that combines both the WeaponCycle and AbysseaProcCycle weapons into one table to be used while inside Abyssea
local WeaponCyclePlusAbyssea = {}
for _, v in ipairs(WeaponCycle) do
    table.insert(WeaponCyclePlusAbyssea, {v[1], v[2]})
end
for _, v in ipairs(AbysseaProcCycle) do
    table.insert(WeaponCyclePlusAbyssea, {v[1], v[2]})
end

-- Sets the Chat Mode
if Chat ~= "Off" then
	send_command('input /cm '..Chat..'')
end

-- Sets the Macro Book and Page
if Book ~= "Off" then
	send_command('input /macro book '..Book..'')
end
if Page ~= "Off" then
	send_command('wait 2;input /macro set '..Page..'')
end
-- Load BLUAlert addon
if BLUAlert == 'On' then
	send_command('lua load blualert')
end

AzureLore = {} UnbridledWisdom = {} Aggressor = {} Berserk = {} BurstAffinity = {} ChainAffinity = {} Contradance = {} Convergence = {} Defender = {} Diffusion = {} DivineSeal = {} Efflux = {} ElementalSeal = {} FlourishesI = {} FlourishesII = {} HighJump = {} Jigs = {} Jump = {} Sambas = {} Steps = {} SuperJump = {} UnbridledLearning = {} Warcry = {} Amplification = {} AnimatingWail = {} BarrierTusk = {} BatteryCharge = {} CarcharianVerve = {} Cocoon = {} Diamondhide = {} ErraticFlutter = {} FeatherBarrier = {} MagicBarrier = {} MementoMori = {} MightyGuard = {} NaturesMeditation = {} Occultation = {} OrcishCounterstance = {} PlasmaCharge = {} ReactorCool = {} Refueling = {} Regeneration = {} SalineCoat = {} TriumphantRoar = {} 

--Start true so the HUD recasts don't flash on load
AzureLore.flashed = true
UnbridledWisdom.flashed = true
Aggressor.flashed = true
Berserk.flashed = true
BurstAffinity.flashed = true
ChainAffinity.flashed = true
Contradance.flashed = true
Convergence.flashed = true
Defender.flashed = true
Diffusion.flashed = true
DivineSeal.flashed = true
Efflux.flashed = true
ElementalSeal.flashed = true
FlourishesI.flashed = true
FlourishesII.flashed = true
HighJump.flashed = true
Jigs.flashed = true
Jump.flashed = true
Sambas.flashed = true
Steps.flashed = true
SuperJump.flashed = true
UnbridledLearning.flashed = true
Warcry.flashed = true
Amplification.flashed = true
AnimatingWail.flashed = true
BarrierTusk.flashed = true
BatteryCharge.flashed = true
CarcharianVerve.flashed = true
Cocoon.flashed = true
Diamondhide.flashed = true
ErraticFlutter.flashed = true
FeatherBarrier.flashed = true
MagicBarrier.flashed = true
MementoMori.flashed = true
MightyGuard.flashed = true
NaturesMeditation.flashed = true
Occultation.flashed = true
OrcishCounterstance.flashed = true
PlasmaCharge.flashed = true
ReactorCool.flashed = true
Refueling.flashed = true
Regeneration.flashed = true
SalineCoat.flashed = true
TriumphantRoar.flashed = true

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
local hud_mode_shdw = texts.new('Please select a mode...')
hud_mode_shdw:color(0,0,0)
hud_mode_shdw:font("Consolas")
hud_mode_shdw:size(FontSize)
hud_mode_shdw:bg_alpha(0)
hud_mode_shdw:pos(HUDposXColumn1+2.5,HUDposYLine2+0.5)
hud_mode_shdw:draggable(false)
hud_mode_shdw:bold(true)

-- Create the HUD Notifications Text Shadow text object
local hud_noti_shdw = texts.new('Keys BLU Gearswap file v'..FileVersion)
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
local hud_mode = texts.new('Please select a mode...')
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
local hud_noti = texts.new('Keys BLU Gearswap file v'..FileVersion)
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

if ShowHUD == 'On' then
	hud_bg_color:show()
	hud_bg:show()
	if ShowTPMeter == 'On' then
		hud_tp_meter_bg1:show()
		hud_tp_meter_bg2:show()
		hud_tp_meter:show()
	end
	hud_noti_bg:show()
	hud_debuffs_bg:show()
	hud_weapons_shdw:show()
	hud_mode_shdw:show()
	hud_noti_shdw:show()
	hud_debuffs_shdw:show()
	hud_weapons:show()
	hud_mode:show()
	hud_noti:show()
	hud_debuffs:show()
end

-------------------------------------------
--            CUSTOM ALIASES             --
-------------------------------------------

send_command('alias mode1 gs c Mode1') --creates Mode 1 alias
send_command('alias mode2 gs c Mode2') --creates Mode 2 alias
send_command('alias mode3 gs c Mode3') --creates Mode 3 alias
send_command('alias mode4 gs c Mode4') --creates Mode 4 alias
send_command('alias mode5 gs c Mode5') --creates Mode 5 alias
send_command('alias dt gs c DT') --creates the DT Override alias
send_command('alias wc gs c WC') --creates the Weapon Cycle alias
send_command('alias hud gs c HUD') --creates the HUD alias
send_command('bind '..DTBind..' gs c DT') --creates the DT Override keyboard shortcut
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
local function checkProcWeapons(mainSlot, subSlot)
    for _, equipmentPair in pairs(AbysseaProcCycle) do
        if equipmentPair[1] == mainSlot and equipmentPair[2] == subSlot then
            return true
        end
    end
    return false
end

--Color the appropriate Ability/spell recast
local function textColor(abil,state)

	local c = color.abil[state]

	if Mode ~= 'None' then
		if HUDrecast[Mode].Abil01 == abil then
			hud_abil01:color(c.r,c.g,c.b)

		elseif HUDrecast[Mode].Abil02 == abil then
			hud_abil02:color(c.r,c.g,c.b)

		elseif HUDrecast[Mode].Abil03 == abil then
			hud_abil03:color(c.r,c.g,c.b)

		elseif HUDrecast[Mode].Abil04 == abil then
			hud_abil04:color(c.r,c.g,c.b)

		elseif HUDrecast[Mode].Abil05 == abil then
			hud_abil05:color(c.r,c.g,c.b)

		elseif HUDrecast[Mode].Abil06 == abil then
			hud_abil06:color(c.r,c.g,c.b)
		end
	end
end

--Flash a specific text area
local function flash(area)

	if Mode ~= 'None' then
		if HUDrecast[Mode].Abil01 == area then
			send_command('gs c Flash_Abil01_A;wait .25;gs c Flash_Abil01_B;wait .25;gs c Flash_Abil01_A;wait .25;gs c Flash_Abil01_B;wait .25;gs c Flash_Abil01_A;wait .25;gs c Flash_Abil01_B;wait .25;gs c Flash_Abil01_A;wait .25;gs c Flash_Abil01_B')

		elseif HUDrecast[Mode].Abil02 == area then
			send_command('gs c Flash_Abil02_A;wait .25;gs c Flash_Abil02_B;wait .25;gs c Flash_Abil02_A;wait .25;gs c Flash_Abil02_B;wait .25;gs c Flash_Abil02_A;wait .25;gs c Flash_Abil02_B;wait .25;gs c Flash_Abil02_A;wait .25;gs c Flash_Abil02_B')

		elseif HUDrecast[Mode].Abil03 == area then
			send_command('gs c Flash_Abil03_A;wait .25;gs c Flash_Abil03_B;wait .25;gs c Flash_Abil03_A;wait .25;gs c Flash_Abil03_B;wait .25;gs c Flash_Abil03_A;wait .25;gs c Flash_Abil03_B;wait .25;gs c Flash_Abil03_A;wait .25;gs c Flash_Abil03_B')

		elseif HUDrecast[Mode].Abil04 == area then
			send_command('gs c Flash_Abil04_A;wait .25;gs c Flash_Abil04_B;wait .25;gs c Flash_Abil04_A;wait .25;gs c Flash_Abil04_B;wait .25;gs c Flash_Abil04_A;wait .25;gs c Flash_Abil04_B;wait .25;gs c Flash_Abil04_A;wait .25;gs c Flash_Abil04_B')

		elseif HUDrecast[Mode].Abil05 == area then
			send_command('gs c Flash_Abil05_A;wait .25;gs c Flash_Abil05_B;wait .25;gs c Flash_Abil05_A;wait .25;gs c Flash_Abil05_B;wait .25;gs c Flash_Abil05_A;wait .25;gs c Flash_Abil05_B;wait .25;gs c Flash_Abil05_A;wait .25;gs c Flash_Abil05_B')

		elseif HUDrecast[Mode].Abil06 == area then
			send_command('gs c Flash_Abil06_A;wait .25;gs c Flash_Abil06_B;wait .25;gs c Flash_Abil06_A;wait .25;gs c Flash_Abil06_B;wait .25;gs c Flash_Abil06_A;wait .25;gs c Flash_Abil06_B;wait .25;gs c Flash_Abil06_A;wait .25;gs c Flash_Abil06_B')

		elseif area == 'Noti' then
			send_command('gs c Flash_Noti_A;wait .25;gs c Flash_Noti_B;wait .25;gs c Flash_Noti_A;wait .25;gs c Flash_Noti_B')

		elseif area == 'Debuffs' then
			send_command('gs c Flash_Debuffs_A;wait .25;gs c Flash_Debuffs_B;wait .25;gs c Flash_Debuffs_A;wait .25;gs c Flash_Debuffs_B')

		end
	end
end

local function getRecasts()

	--Abilities
	local ability_recast = windower.ffxi.get_ability_recasts()

	AzureLore.recast = ability_recast[0] and math.floor(ability_recast[0]) or nil
	UnbridledWisdom.recast = ability_recast[254] and math.floor(ability_recast[254]) or nil
	Aggressor.recast = ability_recast[4] and math.floor(ability_recast[4]) or nil
	Berserk.recast = ability_recast[1] and math.floor(ability_recast[1]) or nil
	BurstAffinity.recast = ability_recast[182] and math.floor(ability_recast[182]) or nil
	ChainAffinity.recast = ability_recast[181] and math.floor(ability_recast[181]) or nil
	Contradance.recast = ability_recast[229] and math.floor(ability_recast[229]) or nil
	Convergence.recast = ability_recast[183] and math.floor(ability_recast[183]) or nil
	Defender.recast = ability_recast[3] and math.floor(ability_recast[3]) or nil
	Diffusion.recast = ability_recast[184] and math.floor(ability_recast[184]) or nil
	DivineSeal.recast = ability_recast[26] and math.floor(ability_recast[26]) or nil
	Efflux.recast = ability_recast[185] and math.floor(ability_recast[185]) or nil
	ElementalSeal.recast = ability_recast[38] and math.floor(ability_recast[38]) or nil
	FlourishesI.recast = ability_recast[221] and math.floor(ability_recast[221]) or nil
	FlourishesII.recast = ability_recast[222] and math.floor(ability_recast[222]) or nil
	HighJump.recast = ability_recast[159] and math.floor(ability_recast[159]) or nil
	Jigs.recast = ability_recast[218] and math.floor(ability_recast[218]) or nil
	Jump.recast = ability_recast[158] and math.floor(ability_recast[158]) or nil
	Sambas.recast = ability_recast[216] and math.floor(ability_recast[216]) or nil
	Steps.recast = ability_recast[220] and math.floor(ability_recast[220]) or nil
	SuperJump.recast = ability_recast[160] and math.floor(ability_recast[160]) or nil
	UnbridledLearning.recast = ability_recast[81] and math.floor(ability_recast[81]) or nil
	Warcry.recast = ability_recast[2] and math.floor(ability_recast[2]) or nil

	--Spells
	local spell_data = windower.ffxi.get_mjob_data().spells
	local spell_recast = windower.ffxi.get_spell_recasts()

	Amplification.recast = (type(spell_data) == 'table' and table.contains(spell_data,642)) and math.floor(spell_recast[642] / 60) or nil
	AnimatingWail.recast = (type(spell_data) == 'table' and table.contains(spell_data,661)) and math.floor(spell_recast[661] / 60) or nil
	BarrierTusk.recast = (type(spell_data) == 'table' and table.contains(spell_data,685)) and math.floor(spell_recast[685] / 60) or nil
	BatteryCharge.recast = (type(spell_data) == 'table' and table.contains(spell_data,662)) and math.floor(spell_recast[662] / 60) or nil
	CarcharianVerve.recast = (type(spell_data) == 'table' and spell_recast[745]) and math.floor(spell_recast[745] / 60) or nil
	Cocoon.recast = (type(spell_data) == 'table' and table.contains(spell_data,547)) and math.floor(spell_recast[547] / 60) or nil
	Diamondhide.recast = (type(spell_data) == 'table' and table.contains(spell_data,632)) and math.floor(spell_recast[632] / 60) or nil
	ErraticFlutter.recast = (type(spell_data) == 'table' and table.contains(spell_data,710)) and math.floor(spell_recast[710] / 60) or nil
	FeatherBarrier.recast = (type(spell_data) == 'table' and table.contains(spell_data,574)) and math.floor(spell_recast[574] / 60) or nil
	MagicBarrier.recast = (type(spell_data) == 'table' and table.contains(spell_data,668)) and math.floor(spell_recast[668] / 60) or nil
	MementoMori.recast = (type(spell_data) == 'table' and table.contains(spell_data,538)) and math.floor(spell_recast[538] / 60) or nil
	MightyGuard.recast = (type(spell_data) == 'table' and spell_recast[750]) and math.floor(spell_recast[750] / 60) or nil
	NaturesMeditation.recast = (type(spell_data) == 'table' and table.contains(spell_data,700)) and math.floor(spell_recast[700] / 60) or nil
	Occultation.recast = (type(spell_data) == 'table' and table.contains(spell_data,679)) and math.floor(spell_recast[679] / 60) or nil
	OrcishCounterstance.recast = (type(spell_data) == 'table' and table.contains(spell_data,696)) and math.floor(spell_recast[696] / 60) or nil
	PlasmaCharge.recast = (type(spell_data) == 'table' and table.contains(spell_data,615)) and math.floor(spell_recast[615] / 60) or nil
	ReactorCool.recast = (type(spell_data) == 'table' and table.contains(spell_data,613)) and math.floor(spell_recast[613] / 60) or nil
	Refueling.recast = (type(spell_data) == 'table' and table.contains(spell_data,530)) and math.floor(spell_recast[530] / 60) or nil
	Regeneration.recast = (type(spell_data) == 'table' and table.contains(spell_data,664)) and math.floor(spell_recast[664] / 60) or nil
	SalineCoat.recast = (type(spell_data) == 'table' and table.contains(spell_data,614)) and math.floor(spell_recast[614] / 60) or nil
	TriumphantRoar.recast = (type(spell_data) == 'table' and table.contains(spell_data,655)) and math.floor(spell_recast[655] / 60) or nil

end

getRecasts()

-- Format abilities/spells to fit into their allotted 12 spaces
local function formatAbils(input,input_sh)

	-- Valid abilities/spells
	local validAbilities = {
		"Azure Lore", "Unbridled Wisdom", "Aggressor", "Berserk", "Burst Affinity", "Chain Affinity", "Contradance", "Convergence", "Defender", "Diffusion", "Divine Seal", "Efflux", "Elemental Seal", "Flourishes I", "Flourishes II", "High Jump", "Jigs", "Jump", "Sambas", "Steps", "Super Jump", "Unbridled Learning", "Warcry", "Amplification", "Animating Wail", "Barrier Tusk", "Battery Charge", "Carcharian Verve", "Cocoon", "Diamondhide", "Erratic Flutter", "Feather Barrier", "Magic Barrier", "Memento Mori", "Mighty Guard", "Nature's Meditation", "Occultation", "Orcish Counterstance", "Plasma Charge", "Reactor Cool", "Refueling", "Regeneration", "Saline Coat", "Triumphant Roar"
	}

	local ab = {} ab['Azure Lore'] = AzureLore ab['Unbridled Wisdom'] = UnbridledWisdom ab['Aggressor'] = Aggressor ab['Berserk'] = Berserk ab['Burst Affinity'] = BurstAffinity ab['Chain Affinity'] = ChainAffinity ab['Contradance'] = Contradance ab['Convergence'] = Convergence ab['Defender'] = Defender ab['Diffusion'] = Diffusion ab['Divine Seal'] = DivineSeal ab['Efflux'] = Efflux ab['Elemental Seal'] = ElementalSeal ab['Flourishes I'] = FlourishesI ab['Flourishes II'] = FlourishesII ab['High Jump'] = HighJump ab['Jigs'] = Jigs ab['Jump'] = Jump ab['Sambas'] = Sambas ab['Steps'] = Steps ab['Super Jump'] = SuperJump ab['Unbridled Learning'] = UnbridledLearning ab['Warcry'] = Warcry ab['Amplification'] = Amplification ab['Animating Wail'] = AnimatingWail ab['Barrier Tusk'] = BarrierTusk ab['Battery Charge'] = BatteryCharge ab['Carcharian Verve'] = CarcharianVerve ab['Cocoon'] = Cocoon ab['Diamondhide'] = Diamondhide ab['Erratic Flutter'] = ErraticFlutter ab['Feather Barrier'] = FeatherBarrier ab['Magic Barrier'] = MagicBarrier ab['Memento Mori'] = MementoMori ab['Mighty Guard'] = MightyGuard ab['Nature\'s Meditation'] = NaturesMeditation ab['Occultation'] = Occultation ab['Orcish Counterstance'] = OrcishCounterstance ab['Plasma Charge'] = PlasmaCharge ab['Reactor Cool'] = ReactorCool ab['Refueling'] = Refueling ab['Regeneration'] = Regeneration ab['Saline Coat'] = SalineCoat ab['Triumphant Roar'] = TriumphantRoar

	-- Check if the input matches any of the valid abilities/spells
	for _, ability in ipairs(validAbilities) do

		if input == ability then

			local recast = ab[ability].recast or 0

			-- Are we using the ability/spell name itself, or a shorthand supplied in the Options?
			local startingString = input_sh == '' and input or input_sh
			-- Adjust for Occultation
			if input == 'Occultation' and buffactive['Blink'] then
				startingString = ShadowCount..'~Shadows'
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
			local c = ((SpellSetCooldown == 0 or SpellSetCooldown == 1) and recast == 0) and color.abil.active or color.abil.ready
			-- Adjust for Unbridled Wisdom or Learning
			if input == 'Carcharian Verve' or input == 'Mighty Guard' then
				c = (recast == 0 and (UnbridledLearning.recast == 0 or buffactive['Unbridled Wisdom'])) and color.abil.active or color.abil.ready
			end

			-- Apply brackets with recast coloring
			if leftPaddingLength == 0 then --the \\q somehow fixes the issue with \\cs not working if it is the first thing in the string (any non-reserved letter seems to work)
				formattedString = leftPadding..'\\q\\cs('..c.r..','..c.g..','..c.b..')[\\cr'..formattedString..'\\cs('..c.r..','..c.g..','..c.b..')]\\cr'..rightPadding
			else --but the q itself will show up in the string if it gets spaces applied in front of it as padding (from being centered)
				formattedString = leftPadding..'\\cs('..c.r..','..c.g..','..c.b..')[\\cr'..formattedString..'\\cs('..c.r..','..c.g..','..c.b..')]\\cr'..rightPadding
			end

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

	if Mode ~= 'None' then

		local abil01 = formatAbils(HUDrecast[Mode].Abil01,HUDrecast[Mode].Abil01_sh)
		local abil02 = formatAbils(HUDrecast[Mode].Abil02,HUDrecast[Mode].Abil02_sh)
		local abil03 = formatAbils(HUDrecast[Mode].Abil03,HUDrecast[Mode].Abil03_sh)
		local abil04 = formatAbils(HUDrecast[Mode].Abil04,HUDrecast[Mode].Abil04_sh)
		local abil05 = formatAbils(HUDrecast[Mode].Abil05,HUDrecast[Mode].Abil05_sh)
		local abil06 = formatAbils(HUDrecast[Mode].Abil06,HUDrecast[Mode].Abil06_sh)

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
end

getHUDAbils()

local function formatAMTime(input)

	local am_time_minute = math.floor(input/60)
	local am_time_second = input - (math.floor(input/60)*60)
	am_time_second = string.format("%02d", am_time_second)
	return am_time_minute..':'..am_time_second

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
		pre_mythicNum = math.floor((tp / 50) - 10)
		pre_AMTimer = 270
	elseif tp == 3000 then
		pre_AMTimer = 180
	end
end

local function primeAMUpdate(tp)

	local function primeMatch(input)
		local locations = {"inventory", "wardrobe", "wardrobe2", "wardrobe3", "wardrobe4", "wardrobe5", "wardrobe6", "wardrobe7", "wardrobe8"}
		for _, location in ipairs(locations) do
			local weapon_id = windower.ffxi.get_items()[location][windower.ffxi.get_items().equipment.main].id
			if weapon_id == input then
				return true --match found
			end
		end
		return false --no match found
	end

	if primeMatch(21644) then --stage 3 Prime
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
	elseif primeMatch(21645) then --stage 4 Prime
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
	elseif primeMatch(21646) then --stage 5 Prime
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

-------------------------------------------
--            SELF COMMANDS              --
-------------------------------------------

function self_command(command)

	local function setMode(mode)
		hud_mode_shdw:text('Mode: '..modeName[mode])
		hud_mode:text('Mode: '..modeName[mode])
		local c = color[mode]
		hud_mode:color(c.r,c.g,c.b)
		hud_bg_color:bg_color(c.r,c.g,c.b)
		hud_abil01_bg:show()
		hud_abil02_bg:show()
		hud_abil03_bg:show()
		hud_abil04_bg:show()
		hud_abil05_bg:show()
		hud_abil06_bg:show()
		hud_abil01_shdw:show()
		hud_abil02_shdw:show()
		hud_abil03_shdw:show()
		hud_abil04_shdw:show()
		hud_abil05_shdw:show()
		hud_abil06_shdw:show()
		hud_abil01:show()
		hud_abil02:show()
		hud_abil03:show()
		hud_abil04:show()
		hud_abil05:show()
		hud_abil06:show()
	end

	if command == 'DT' then
		if DTOverride == 'Off' then
			DTOverride = 'On'
		elseif DTOverride == 'On' then
			DTOverride = 'Off'
		end
		choose_set()
	elseif command == 'Mode1' then
		Mode = 'Mode1'
		SpellSetCooldown = 0
		setMode('Mode1')
		choose_set()
	elseif command == 'Mode2' then
		Mode = 'Mode2'
		SpellSetCooldown = 0
		setMode('Mode2')
		choose_set()
	elseif command == 'Mode3' then
		Mode = 'Mode3'
		SpellSetCooldown = 0
		setMode('Mode3')
		choose_set()
	elseif command == 'Mode4' then
		Mode = 'Mode4'
		SpellSetCooldown = 0
		setMode('Mode4')
		choose_set()
	elseif command == 'Mode5' then
		Mode = 'Mode5'
		SpellSetCooldown = 0
		setMode('Mode5')
		choose_set()
	elseif command == 'ClearNotifications' then --these reset the Notifications display back to a basic state
		if TownZones:contains(world.area) then
			hud_noti_shdw:text(player.name..': '..player.main_job..player.main_job_level..'/'..player.sub_job..player.sub_job_level)
			hud_noti:text(player.name..': '..player.main_job..player.main_job_level..'/'..player.sub_job..player.sub_job_level)
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
		elseif LowHP == true then
			hud_noti_shdw:text('«« Low HP »»')
			hud_noti:text('«« Low HP »»')
			hud_noti:color(255,50,50)
		elseif buffactive['weakness'] and DTOverride == 'On' then
			hud_noti_shdw:text('Status: Weakness (DT Override)')
			hud_noti:text('Status: Weakness (DT Override)')
			hud_noti:color(205,133,63)
		elseif buffactive['weakness'] then
			hud_noti_shdw:text('Status: Weakness')
			hud_noti:text('Status: Weakness')
			hud_noti:color(205,133,63)
		elseif player.mpp <= 20 then
			hud_noti_shdw:text('«« Low MP »»')
			hud_noti:text('«« Low MP »»')
			hud_noti:color(255,50,50)
		elseif player.status == "Resting" and DTOverride == 'On' then
			hud_noti_shdw:text('Status: Resting (DT Override)')
			hud_noti:text('Status: Resting (DT Override)')
			hud_noti:color(255,255,255)
		elseif player.status == "Resting" then
			hud_noti_shdw:text('Status: Resting')
			hud_noti:text('Status: Resting')
			hud_noti:color(255,255,255)
		elseif player.status == "Engaged" and DTOverride == 'On' then
			hud_noti_shdw:text('Status: Engaged (DT Override)')
			hud_noti:text('Status: Engaged (DT Override)')
			hud_noti:color(255,255,255)
		elseif player.status == "Engaged" then
			hud_noti_shdw:text('Status: Engaged')
			hud_noti:text('Status: Engaged')
			hud_noti:color(255,255,255)
		elseif player.status == "Idle" and DTOverride == "On" then
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
		hud_debuffs:color(255,255,255)
	elseif command == 'SpellSetCooldown' then
		SpellSetCooldown = 60
	elseif command == 'clearMode' then
		hud_mode_shdw:text('Mode: '..modeName[Mode])
		hud_mode:text('Mode: '..modeName[Mode])
	elseif command == 'Zone Gear' then
		if ZoneGear == 'Town' then
			if TownZones:contains(world.area) then
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
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		hud_noti_shdw:text('«« Radialens Has Worn Off »»')
		hud_noti:text('«« Radialens Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif command == 'NotiLowMPToggle' then
		NotiLowMPToggle = 'Off'
	elseif command == 'AliveDelay' then
		Alive = true --putting this in a command lets us set a small delay to prevent things from triggering right when we raise up
	elseif command == 'HUD' and ShowHUD == 'Off' then
		ShowHUD = 'On'
		windower.send_command('gs c ShowHUD')
	elseif command == 'HUD' and ShowHUD == 'On' then
		ShowHUD = 'Off'
		windower.send_command('gs c HideHUD')
	elseif command == 'ShowHUD' then
		hud_bg_color:show()
		hud_bg:show()
		if ShowTPMeter == 'On' then
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
	if player.status == "Resting" then
		if LowHP == true then
			hud_noti_shdw:text('«« Low HP »»')
			hud_noti:text('«« Low HP »»')
			hud_noti:color(255,50,50)
		elseif buffactive['weakness'] and DTOverride == 'On' then
			hud_noti_shdw:text('Status: Weak (DT Override)')
			hud_noti:text('Status: Weak (DT Override)')
			hud_noti:color(205,133,63)
		elseif buffactive['weakness'] then
			hud_noti_shdw:text('Status: Weak')
			hud_noti:text('Status: Weak')
			hud_noti:color(205,133,63)
		elseif player.mpp <= 20 then
			hud_noti_shdw:text('«« Low MP »»')
			hud_noti:text('«« Low MP »»')
			hud_noti:color(255,50,50)
		elseif DTOverride == 'On' then
			hud_noti_shdw:text('Status: Resting (DT Override)')
			hud_noti:text('Status: Resting (DT Override)')
			hud_noti:color(255,255,255)
		else
			hud_noti_shdw:text('Status: Resting')
			hud_noti:text('Status: Resting')
			hud_noti:color(255,255,255)
		end
		if DTOverride == 'On' then
			equip(set_combine(sets.rest, sets.dtoverride))
		else
			equip(set_combine(sets.refresh, sets.rest))
		end
	elseif player.status == "Engaged" then
		if LowHP == true then
			hud_noti_shdw:text('«« Low HP »»')
			hud_noti:text('«« Low HP »»')
			hud_noti:color(255,50,50)
		elseif buffactive['weakness'] and DTOverride == 'On' then
			hud_noti_shdw:text('Status: Weak (DT Override)')
			hud_noti:text('Status: Weak (DT Override)')
			hud_noti:color(205,133,63)
		elseif buffactive['weakness'] then
			hud_noti_shdw:text('Status: Weak')
			hud_noti:text('Status: Weak')
			hud_noti:color(205,133,63)
		elseif player.mpp <= 20 then
			hud_noti_shdw:text('«« Low MP »»')
			hud_noti:text('«« Low MP »»')
			hud_noti:color(255,50,50)
		elseif DTOverride == 'On' then
			hud_noti_shdw:text('Status: Engaged (DT Override)')
			hud_noti:text('Status: Engaged (DT Override)')
			hud_noti:color(255,255,255)
		else
			hud_noti_shdw:text('Status: Engaged')
			hud_noti:text('Status: Engaged')
			hud_noti:color(255,255,255)
		end
		if DTOverride == 'On' then
			equip(set_combine(sets[Mode].dps, sets.dtoverride))
		else
			equip(sets[Mode].dps)
		end
		if LowHP == true then --no matter what Mode we're in, if we have low HP we equip the Oh Shit gear set
			equip(sets.ohshit)
		end
	elseif player.status == "Idle" then
		if TownZones:contains(world.area) then
			hud_noti_shdw:text(player.name..': '..player.main_job..player.main_job_level..'/'..player.sub_job..player.sub_job_level)
			hud_noti:text(player.name..': '..player.main_job..player.main_job_level..'/'..player.sub_job..player.sub_job_level)
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
		elseif LowHP == true then
			hud_noti_shdw:text('«« Low HP »»')
			hud_noti:text('«« Low HP »»')
			hud_noti:color(255,50,50)
		elseif buffactive['weakness'] and DTOverride == 'On' then
			hud_noti_shdw:text('Status: Weak (DT Override)')
			hud_noti:text('Status: Weak (DT Override)')
			hud_noti:color(205,133,63)
		elseif buffactive['weakness'] then
			hud_noti_shdw:text('Status: Weak')
			hud_noti:text('Status: Weak')
			hud_noti:color(205,133,63)
		elseif player.mpp <= 20 then
			hud_noti_shdw:text('«« Low MP »»')
			hud_noti:text('«« Low MP »»')
			hud_noti:color(205,133,63)
		elseif DTOverride == 'On' then
			hud_noti_shdw:text('Status: Idle (DT Override)')
			hud_noti:text('Status: Idle (DT Override)')
			hud_noti:color(255,255,255)
		else
			hud_noti_shdw:text('Status: Idle')
			hud_noti:text('Status: Idle')
			hud_noti:color(255,255,255)
		end
		if AdoulinZones:contains(world.area) then
			equip(set_combine(sets[Mode].idle, sets.adoulin))
		elseif BastokZones:contains(world.area) then
			equip(set_combine(sets[Mode].idle, sets.bastok))
		elseif SandyZones:contains(world.area) then
			equip(set_combine(sets[Mode].idle, sets.sandoria))
		elseif WindyZones:contains(world.area) then
			equip(set_combine(sets[Mode].idle, sets.windurst))
		elseif TownZones:contains(world.area) then
			equip(set_combine(sets[Mode].idle, sets.town))
		else
			if LowHP == true then --no matter what Mode we're in, if we have low HP we equip the Oh Shit gear set
				equip(set_combine(sets[Mode].idle, sets.ohshit))
			elseif DTOverride == "On" then
				equip(set_combine(sets[Mode].idle, sets.dtoverride))
			else
				equip(sets[Mode].idle)
			end
		end
	end
end

-------------------------------------------
--               PRECAST                 --
-------------------------------------------

function precast(spell)
	if buffactive['terror'] then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		flash('Debuffs')
	elseif buffactive['petrification'] then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		flash('Debuffs')
	elseif buffactive['sleep'] then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		flash('Debuffs')
	elseif buffactive['stun'] then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		flash('Debuffs')
	elseif buffactive['amnesia'] and (spell.type == 'WeaponSkill' or spell.type == 'JobAbility') then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		flash('Debuffs')
	elseif buffactive['silence'] and (spell.prefix == '/magic' or spell.prefix == '/ninjutsu' or spell.prefix == '/song') then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		if UseEcho == 'E' then
			send_command('input /item "Echo Drop" <me>')
		elseif UseEcho == 'R' then
			send_command('input /item "Remedy" <me>')
		end
		flash('Debuffs')
	elseif buffactive['mute'] and (spell.prefix == '/magic' or spell.prefix == '/ninjutsu' or spell.prefix == '/song') then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		flash('Debuffs')
	elseif spell.type == 'WeaponSkill' then
		if player.tp < 1000 then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
			end
			hud_noti_shdw:text('«« Not Enough TP »»')
			hud_noti:text('«« Not Enough TP »»')
			hud_noti:color(255,50,50)
			NotiCountdown = NotiDelay
		elseif ((spell.skill == 'Marksmanship' or spell.skill == 'Archery') and spell.target.distance >= (spell.target.model_size + 23)) or ((spell.target.distance >= (spell.target.model_size + 3)) and not (spell.english == 'Starlight' or spell.english == 'Moonlight')) then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
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
		elseif sets[spell.english] then
			equip(sets[spell.english])
		else
			equip(sets.ws)
		end
		if player.equipment.main == "Sequence" and spell.english == "Requiescat" then
			pre_AMTimer = 181
		elseif player.equipment.main == 'Almace' and spell.english == "Chant du Cygne" then
			player_tp = player.tp
			TP_Window_Open = true
			empyreanAMUpdate(player_tp)
		elseif  player.equipment.main == 'Tizona' and spell.english == "Expiacion" then
			player_tp = player.tp
			TP_Window_Open = true
			mythicAMUpdate(player_tp)
		elseif (player.equipment.main == 'Caliburnus' and spell.english == "Imperator") then
			player_tp = player.tp
			TP_Window_Open = true
			primeAMUpdate(player_tp)
		end
	elseif spell.english == 'Azure Lore' then
		equip(sets.azurelore)
	elseif spell.english == 'Chain Affinity' and ChainAffinity.recast < 2 then
		equip(sets.chainaffinity)
	elseif spell.english == 'Burst Affinity' and BurstAffinity.recast < 2 then
		equip(sets.burstaffinity)
	elseif spell.english == 'Diffusion' and Diffusion.recast < 2 then
		equip(sets.diffusion)
	elseif spell.english == 'Efflux' and Efflux.recast < 2 then
		equip(sets.efflux)
	elseif spell.english == 'Holy Water' then
		equip(sets.hwater)
	elseif (spell.english == 'Spectral Jig' or spell.english == 'Sneak' or spell.english == 'Monomi: Ichi' or spell.english == 'Monomi: Ni') and buffactive['Sneak'] and spell.target.type == 'SELF' then
		send_command('cancel 71')
		equip(sets.fastcast)
	elseif spell.english == 'Stoneskin' and buffactive['Stoneskin'] then
		send_command('cancel 37')
		equip(sets.fastcast)
	elseif spell.english == 'Fire' or spell.english == 'Blizzard' or spell.english == 'Aero' or spell.english == 'Stone' or spell.english == 'Thunder' or spell.english == 'Water' then
		equip(sets.magical)
	elseif spell.action_type == 'Ranged Attack' then
		equip(sets.snapshot)
	elseif not (spell.action_type == 'Item' or spell.action_type == 'Ability') then
		equip(sets.fastcast)
	end
end

-------------------------------------------
--               MIDCAST                 --
-------------------------------------------

function midcast(spell)
	if spell.skill == 'Blue Magic' then
		if Physical:contains(spell.english) then
			equip(sets.physical)
			if buffactive['Chain Affinity'] then
				equip(sets.chainaffinity)
			end
			if buffactive['Efflux'] then
				equip(sets.efflux)
			end
		elseif Magical:contains(spell.english) then
			equip(sets.magical)
			if buffactive['Burst Affinity'] then
				equip(sets.burstaffinity)
			end
		elseif Earth:contains(spell.english) then
			equip(sets.magical.earth)
			if buffactive['Burst Affinity'] then
				equip(sets.burstaffinity)
			end
		elseif Dark:contains(spell.english) then
			equip(sets.dark)
			if buffactive['Burst Affinity'] then
				equip(sets.burstaffinity)
			end
		elseif MagicAccuracy:contains(spell.english) then
			equip(sets.magicaccuracy)
		elseif Breath:contains(spell.english) then
			equip(sets.breath)
		elseif Buff:contains(spell.english) then
			if buffactive['Diffusion'] then
				equip(set_combine(sets.buff, sets.diffusion))
			else
				equip(sets.buff)
			end
		elseif BlueMagicSkill:contains(spell.english) then
			equip(set_combine(sets.buff, sets.bluemagicskill))
		elseif Healing:contains(spell.english) then
			equip(set_combine(sets.buff, sets.healing))
		elseif spell.english == 'White Wind' then
			equip(sets.whitewind)
		elseif spell.english == 'Battery Charge' then
			if buffactive['Diffusion'] then
				equip(set_combine(sets.buff, sets.battery, sets.diffusion))
			else
				equip(set_combine(sets.buff, sets.battery))
			end
		end
	elseif spell.skill == 'Elemental Magic' and not (spell.english == 'Fire' or spell.english == 'Blizzard' or spell.english == 'Aero' or spell.english == 'Stone' or spell.english == 'Thunder' or spell.english == 'Water') then
		equip(sets.magical)
	elseif spell.english == 'Cursna' then
		equip(sets.cursna)
	elseif string.find(spell.english,'Cur') and spell.type == "WhiteMagic" then
		equip(set_combine(sets.buff, sets.healing))
	elseif spell.type == 'Trust' then
		equip(sets.unity)
	end
end

-------------------------------------------
--              AFTERCAST                --
-------------------------------------------

function aftercast(spell)
	if spell.english == 'Cruel Joke' and CJTimer ~= 'Off' and not spell.interrupted then
		if CJTimer == 'p' then
			send_command('input /p [Cruel Joke] 60 seconds;wait 31;input /p [Cruel Joke] 30 seconds;wait 20;input /p [Cruel Joke] 10 seconds')
		elseif CJTimer == 'e' then
			send_command('input /echo [Cruel Joke] 60 seconds;wait 31;input /echo [Cruel Joke] 30 seconds;wait 20;input /echo [Cruel Joke] 10 seconds')
		end
	elseif spell.english == 'Occultation' and not spell.interrupted then 
		ShadowCount = OccShadows
	elseif spell.english == 'Azure Lore' then
		if ALTimer == 'On' then
			--these pieces extend Azure Lore by 10 seconds so we adjust accordingly
			if player.equipment.hands == 'Luhlaza Bazubands' or player.equipment.hands == 'Luh. Bazubands +1' or player.equipment.hands == 'Luh. Bazubands +2' or player.equipment.hands == 'Luh. Bazubands +3' then
				send_command('input /echo [Azure Lore] 40 seconds;wait 10;input /echo [Azure Lore] 30 seconds;wait 10;input /echo [Azure Lore] 20 seconds;wait 10;input /echo [Azure Lore] 10 seconds')
			else
				send_command('input /echo [Azure Lore] 30 seconds;wait 10;input /echo [Azure Lore] 20 seconds;wait 10;input /echo [Azure Lore] 10 seconds')
			end
		end
	elseif spell.english == 'Unbridled Wisdom' and UWTimer == 'On' then
		send_command('input /echo [Unbridled Wisdom] 60 seconds;wait 31;input /echo [Unbridled Wisdom] 30 seconds;wait 20;input /echo [Unbridled Wisdom] 10 seconds')
	end
	choose_set()
end

-------------------------------------------
--             STATUS CHANGE             --
-------------------------------------------

windower.register_event('status change', function(status)
    if status == 4 and InCS == false and ShowHUD == 'On' then --In a cutscene: Hide the HUD
		InCS = true
		windower.send_command('gs c HideHUD')
    elseif status ~= 4 and InCS == true and ShowHUD == 'On' then --Out of cutscene: Show the HUD
		InCS = false
		windower.send_command('gs c ShowHUD')
    end
	choose_set() --run this any time your status changes (engage, disengage, rest)
end)

-------------------------------------------
--       Buff/Debuff Notifications       --
-------------------------------------------

windower.register_event('gain buff', function(buff)
	if (buff == 270 or buff == 271 or buff == 272 or buff == 273) and AlertSounds == 'On' then --Aftermath
		windower.play_sound(windower.addon_path..'data/sounds/AftermathOn.wav')
		AMTimer = pre_AMTimer
		mythicNum = pre_mythicNum
		primeNum = pre_primeNum
	elseif (buff == 2 or buff == 19) then --If we get put to sleep,
		if buffactive['Stoneskin'] and not buffactive['charm'] then --first remove stoneskin if its up,
			send_command('cancel 37')
			equip(sets.ohshit)
		else --then equip the Oh Shit set and the Opo-opo Necklace for free TP
			equip(set_combine({neck="Opo-opo Necklace"}, sets.ohshit))
		end
	elseif buff == 7 or buff == 10 or buff == 28 then --If we get petrified, stunned, or terrored, then equip the Oh Shit set
		equip(sets.ohshit)
	elseif buff == 15 then --Doom
		DangerCountdown = DangerRepeat --Start the Danger Sound going
	elseif buff == 17 then --Charm
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
	elseif buff == 71 or buff == 69 then --Sneak or Invisible
		send_command('gs c ClearNotifications')
	elseif buff == 252 then --Mounted
		send_command('wait .5;gs c ClearNotifications')
	end
end)

windower.register_event('lose buff', function(buff)
	if buff == 270 or buff == 271 or buff == 272 or buff == 273 and AlertSounds == 'On' then --lose any aftermath
		windower.play_sound(windower.addon_path..'data/sounds/AftermathOff.wav')
		-- mythicNum = 0
		-- primeNum = 0
	elseif buff == 251 and Alive == true and NotiFood == 'On' then --food wears off
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		hud_noti_shdw:text('«« Food Has Worn Off »»')
		hud_noti:text('«« Food Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 113 and NotiReraise == 'On' and Alive == true then --reraise wears off
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		hud_noti_shdw:text('«« Reraise Has Worn Off »»')
		hud_noti:text('«« Reraise Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 602 and string.find(world.area,'Escha') then --Vorseal
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		hud_noti_shdw:text('«« Vorseal Has Worn Off »»')
		hud_noti:text('«« Vorseal Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 253 then --Signet
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		hud_noti_shdw:text('«« Signet Has Worn Off »»')
		hud_noti:text('«« Signet Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 256 then --Sanction
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		hud_noti_shdw:text('«« Sanction Has Worn Off »»')
		hud_noti:text('«« Sanction Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 268 then --Sigil
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		hud_noti_shdw:text('«« Sigil Has Worn Off »»')
		hud_noti:text('«« Sigil Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 512 then --Ionis
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		hud_noti_shdw:text('«« Ionis Has Worn Off »»')
		hud_noti:text('«« Ionis Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 1 and Alive == true then --Weakness
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav')
		end
		hud_noti_shdw:text('«« Weakness Has Worn Off »»')
		hud_noti:text('«« Weakness Has Worn Off »»')
		hud_noti:color(75,255,75)
		NotiCountdown = NotiDelay
	elseif buff == 2 or buff == 19 or buff == 7 or buff == 10 or buff == 28 then --lose sleep, petrify, stun, or terror run choose_set since we changed gear for those
		choose_set()
	elseif buff == 36 then --lose blink, clear shadow count to 0
		ShadowCount = 0
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
	if player.tp == 3000 and Noti3000TP == 'On' then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/3000TP.wav')
		end
		local c = color.AM3
		hud_noti_shdw:text('«« 3000 TP »»')
		hud_noti:text('«« 3000 TP »»')
		hud_noti:color(c.r,c.g,c.b)
		NotiCountdown = NotiDelay
	end

	--HUD TP Meter
	if not TownZones:contains(world.area) then
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
		if player.equipment.main == 'Almace' then
			empyreanAMUpdate(player_tp)
		elseif player.equipment.main == "Tizona" then
			mythicAMUpdate(player_tp)
		elseif player.equipment.main == 'Caliburnus' then
			primeAMUpdate(player_tp)
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
	if pos == "(?-?)" and Zoning == false and ShowHUD == 'On' then
		send_command('gs c HideHUD')
		Zoning = true
	elseif pos ~= "(?-?)" and Zoning == true and ShowHUD == 'On' then
		send_command('gs c ShowHUD')
		Zoning = false
	end

	--Aftermath checks
	if SwitchingWeapons == 0 then
		if player.equipment.main == 'Caliburnus' then
			if buffactive['Aftermath: Lv.1'] then
				if currentAfterMath ~= 'PrimeAM1' or primeNum ~= currentPrimeNum or currentAMTimer ~= AMTimer then
					currentAfterMath = 'PrimeAM1'
					currentPrimeNum = primeNum
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM1: (Phys Dmg Lmt +'..primeNum..'%) '..am_time))
					hud_weapons:text(formatWeapons('AM1: (Phys Dmg Lmt +'..primeNum..'%) '..am_time))
				end
			elseif buffactive['Aftermath: Lv.2'] then
				if currentAfterMath ~= 'PrimeAM2' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'PrimeAM2'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM2: (Phys Dmg Lmt +'..primeNum..'%) '..am_time))
					hud_weapons:text(formatWeapons('AM2: (Phys Dmg Lmt +'..primeNum..'%) '..am_time))
				end
			elseif buffactive['Aftermath: Lv.3'] then
				if currentAfterMath ~= 'PrimeAM3' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'PrimeAM3'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM3: (Phys Dmg Lmt +'..primeNum..'%) '..am_time))
					hud_weapons:text(formatWeapons('AM3: (Phys Dmg Lmt +'..primeNum..'%) '..am_time))
				end
			else
				if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain..EquipSub then
					CurrentEquip = EquipMain..EquipSub
					currentAfterMath = 'None'
					hud_weapons_shdw:text(formatWeapons(EquipMain..EquipSub))
					hud_weapons:text(formatWeapons(EquipMain..EquipSub))
				end
			end
		elseif player.equipment.main == 'Almace' then
			if buffactive['Aftermath: Lv.1'] then
				if currentAfterMath ~= 'EmpyreanAM1' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'EmpyreanAM1'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM1: (30% Triple Dmg) '..am_time))
					hud_weapons:text(formatWeapons('AM1: (30% Triple Dmg) '..am_time))
				end
			elseif buffactive['Aftermath: Lv.2'] then
				if currentAfterMath ~= 'EmpyreanAM2' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'EmpyreanAM2'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM2: (40% Triple Dmg) '..am_time))
					hud_weapons:text(formatWeapons('AM2: (40% Triple Dmg) '..am_time))
				end
			elseif buffactive['Aftermath: Lv.3'] then
				if currentAfterMath ~= 'EmpyreanAM3' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'EmpyreanAM3'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM3: (50% Triple Dmg) '..am_time))
					hud_weapons:text(formatWeapons('AM3: (50% Triple Dmg) '..am_time))
				end
			else
				if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain..EquipSub then
					CurrentEquip = EquipMain..EquipSub
					currentAfterMath = 'None'
					hud_weapons_shdw:text(formatWeapons(EquipMain..EquipSub))
					hud_weapons:text(formatWeapons(EquipMain..EquipSub))
				end
			end
		elseif player.equipment.main == 'Tizona' then
			if buffactive['Aftermath: Lv.1'] then
				if currentAfterMath ~= 'MythicAM1' or mythicNum ~= currentMythicNum or currentAMTimer ~= AMTimer then
					currentAfterMath = 'MythicAM1'
					currentMythicNum = mythicNum
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM1: (Accuracy +'..mythicNum..') '..am_time))
					hud_weapons:text(formatWeapons('AM1: (Accuracy +'..mythicNum..') '..am_time))
				end
			elseif buffactive['Aftermath: Lv.2'] then
				if currentAfterMath ~= 'MythicAM2' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'MythicAM2'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM2: (Magic Acc. +'..mythicNum..') '..am_time))
					hud_weapons:text(formatWeapons('AM2: (Magic Acc. +'..mythicNum..') '..am_time))
				end
			elseif buffactive['Aftermath: Lv.3'] then
				if currentAfterMath ~= 'MythicAM3' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'MythicAM3'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM3: (Occ. Att. 2-3x) '..am_time))
					hud_weapons:text(formatWeapons('AM3: (Occ. Att. 2-3x) '..am_time))
				end
			else
				if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain..EquipSub then
					CurrentEquip = EquipMain..EquipSub
					currentAfterMath = 'None'
					hud_weapons_shdw:text(formatWeapons(EquipMain..EquipSub))
					hud_weapons:text(formatWeapons(EquipMain..EquipSub))
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
				end
			elseif buffactive['Aftermath: Lv.2'] then
				if currentAfterMath ~= 'AeonicAM2' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'AeonicAM2'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM2: (3-Step Ultimate SC) '..am_time))
					hud_weapons:text(formatWeapons('AM2: (3-Step Ultimate SC) '..am_time))
				end
			elseif buffactive['Aftermath: Lv.3'] then
				if currentAfterMath ~= 'AeonicAM3' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'AeonicAM3'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM3: (2-Step Ultimate SC) '..am_time))
					hud_weapons:text(formatWeapons('AM3: (2-Step Ultimate SC) '..am_time))
				end
			else
				if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain..EquipSub then
					CurrentEquip = EquipMain..EquipSub
					currentAfterMath = 'None'
					hud_weapons_shdw:text(formatWeapons(EquipMain..EquipSub))
					hud_weapons:text(formatWeapons(EquipMain..EquipSub))
				end
			end
		elseif currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain..EquipSub then
			CurrentEquip = EquipMain..EquipSub
			currentAfterMath = 'None'
			hud_weapons_shdw:text(formatWeapons(EquipMain..EquipSub))
			hud_weapons:text(formatWeapons(EquipMain..EquipSub))
		end
	end

	--Debuff checks
	if buffactive['doom'] and NotiDoom == 'On' then
		if not debuffs.Charm then
			debuffs.Charm = true
			hud_debuffs_shdw:text('            «« DOOMED »»')
			local c = color.Dark
			hud_debuffs:text('            «« \\cs('..c.r..','..c.g..','..c.b..')DOOMED\\cr »»')
		end
	elseif buffactive['animated'] and NotiCharm == 'On' then
		if not debuffs.Animated then
			debuffs.Animated = true
			hud_debuffs_shdw:text('           «« ANIMATED »»')
			local c = color.Light
			hud_debuffs:text('           «« \\cs('..c.r..','..c.g..','..c.b..')ANIMATED\\cr »»')
		end
	elseif buffactive['charm'] and NotiCharm == 'On' then
		if not debuffs.Charm then
			debuffs.Charm = true
			hud_debuffs_shdw:text('           «« CHARMED »»')
			local c = color.Light
			hud_debuffs:text('           «« \\cs('..c.r..','..c.g..','..c.b..')CHARMED\\cr »»')
		end
	elseif buffactive['terror'] and NotiTerror == 'On' then
		if not debuffs.Terror then
			debuffs.Terror = true
			hud_debuffs_shdw:text('          «« TERRORIZED »»')
			local c = color.Dark
			hud_debuffs:text('          «« \\cs('..c.r..','..c.g..','..c.b..')TERRORIZED\\cr »»')
		end
	elseif buffactive['petrification'] and NotiPetrification == 'On' then
		if not debuffs.Petrification then
			debuffs.Petrification = true
			hud_debuffs_shdw:text('          «« PETRIFIED »»')
			local c = color.Earth
			hud_debuffs:text('          «« \\cs('..c.r..','..c.g..','..c.b..')PETRIFIED\\cr »»')
		end
	elseif buffactive['sleep'] and NotiSleep == 'On' then
		if not debuffs.Sleep then
			debuffs.Sleep = true
			hud_debuffs_shdw:text('            «« ASLEEP »»')
			local c = color.Dark
			hud_debuffs:text('            «« \\cs('..c.r..','..c.g..','..c.b..')ASLEEP\\cr »»')
		end
	elseif buffactive['stun'] and NotiStun == 'On' then
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
		if NotiSilence == 'On' then
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
		if NotiParalysis == 'On' then
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
		if NotiPlague == 'On' then
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
		if NotiCurse == 'On' then
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
		if NotiAmnesia == 'On' then
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
		if NotiTaint == 'On' then
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
		if NotiEncumbrance == 'On' then
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
	if NotiLowMP =='On' and player.mpp <= 20 and NotiLowMPToggle == 'Off' then
		NotiLowMPToggle = 'On' --turn the toggle on so this can't be triggered again until its toggled off (done below)
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		hud_noti_shdw:text('«« Low MP »»')
		hud_noti:text('«« Low MP »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay	
		send_command('wait 30;gs c NotiLowMPToggle') --wait 30 sec then turns the toggle back off
	end

	--HP checks
	if player.hp == 0 then --are we dead?
		if Alive == true then
			hud_noti_shdw:text('Status: Dead X_x')
			hud_noti:text('Status: Dead X_x')
			hud_noti:color(255,50,50)
			NotiCountdown = -1
			Alive = false
			announceAlive = true
			if LowHP == true then
				LowHP = false
			end
		end
	else
		if Alive == false and announceAlive == true then
			hud_noti_shdw:text('Status: Alive ^_^')
			hud_noti:text('Status: Alive ^_^')
			hud_noti:color(75,255,75)
			NotiCountdown = -1
			announceAlive = false
			send_command('wait 1;gs c AliveDelay') --we use a command to set this to true so that we can set a short delay to prevent things from triggering right when we raise
		end
		if player.hp <= LowHPThreshold and player.max_hp > LowHPThreshold and not (buffactive['weakness'] or TownZones:contains(world.area)) then --when HP goes below a certain amount, turn on the LowHP flag and equip the appropriate gear set
			if LowHP == false then
				LowHP = true
				DangerCountdown = DangerRepeat
				choose_set()
			end
		elseif player.hp > LowHPThreshold and LowHP == true then --when HP goes back above a certain amount, turn off the LowHP flag and equip the appropriate gear set
			send_command('gs c ClearNotifications')
			LowHP = false
			choose_set()
		end
	end

	--1 second heartbeat
	if os.time() > Heartbeat then

		--Using the teleports in Sortie pauses timers
		if world.area == "Outer Ra'Kaznar [U]" and player.status == "Event" then
			return
		end

		Heartbeat = os.time()

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
				EquipSub = ' & '..player.equipment.sub..''
			end
		end
		if ReraiseReminder == 'On' then
			if RRRCountdown > 0 then
				RRRCountdown = RRRCountdown - 1
			else
				if not buffactive['Reraise'] and Alive == true then --if we are dead no need to remind us about reraise
					if AlertSounds == 'On' then
						windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
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
		if SpellSetCooldown > 0 then
			SpellSetCooldown = SpellSetCooldown - 1
			if SpellSetCooldown == 0 then
				hud_mode_shdw:text('Mode: '..modeName[Mode]..' (Spells ready!)')
				hud_mode:text('Mode: '..modeName[Mode]..' (Spells ready!)')
				send_command('wait 5;gs c clearMode')
				if AlertSounds == 'On' then
					windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav')
				end
			else
				hud_mode_shdw:text('Mode: '..modeName[Mode]..' (Cooldown: '..SpellSetCooldown..')')
				hud_mode:text('Mode: '..modeName[Mode]..' (Cooldown: '..SpellSetCooldown..')')
			end
		end
		if NotiDoom == 'On' and buffactive['doom'] then 
			flash('Debuffs')
		end
		if NotiLowHP == 'On' and LowHP == true and Alive == true then
			hud_noti_shdw:text('«« LOW HP »»')
			hud_noti:text('«« LOW HP »»')
			hud_noti:color(255,50,50)
			flash('Noti')
			NotiCountdown = -1
		end
		if (NotiDoom == 'On' and buffactive['doom']) or (NotiLowHP == 'On' and LowHP == true and Alive == true and not (buffactive['weakness'] or TownZones:contains(world.area))) and AlertSounds == 'On' and DangerCountdown > 0 then
			DangerCountdown = DangerCountdown - 1
			windower.play_sound(windower.addon_path..'data/sounds/Danger.wav')
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

		--Recast color updates

		if AzureLore.recast then
			if buffactive['Azure Lore'] then
				textColor('Azure Lore','active')
				AzureLore.flashed = false
			elseif AzureLore.recast > 0 then
				textColor('Azure Lore','cooldown')
				AzureLore.flashed = false
			else
				textColor('Azure Lore','ready')
				if not AzureLore.flashed then
					flash('Azure Lore')
				end
				AzureLore.flashed = true
			end
		else
			textColor('Azure Lore','notfound')
		end

		if UnbridledWisdom.recast then
			if buffactive['Unbridled Wisdom'] then
				textColor('Unbridled Wisdom','active')
				UnbridledWisdom.flashed = false
			elseif UnbridledWisdom.recast > 0 then
				textColor('Unbridled Wisdom','cooldown')
				UnbridledWisdom.flashed = false
			else
				textColor('Unbridled Wisdom','ready')
				if not UnbridledWisdom.flashed then
					flash('Unbridled Wisdom')
				end
				UnbridledWisdom.flashed = true
			end
		else
			textColor('Unbridled Wisdom','notfound')
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

		if BurstAffinity.recast then
			if buffactive['Burst Affinity'] then
				textColor('Burst Affinity','active')
				BurstAffinity.flashed = false
			elseif BurstAffinity.recast > 0 then
				textColor('Burst Affinity','cooldown')
				BurstAffinity.flashed = false
			else
				textColor('Burst Affinity','ready')
				if not BurstAffinity.flashed then
					flash('Burst Affinity')
				end
				BurstAffinity.flashed = true
			end
		else
			textColor('Burst Affinity','notfound')
		end

		if ChainAffinity.recast then
			if buffactive['Chain Affinity'] then
				textColor('Chain Affinity','active')
				ChainAffinity.flashed = false
			elseif ChainAffinity.recast > 0 then
				textColor('Chain Affinity','cooldown')
				ChainAffinity.flashed = false
			else
				textColor('Chain Affinity','ready')
				if not ChainAffinity.flashed then
					flash('Chain Affinity')
				end
				ChainAffinity.flashed = true
			end
		else
			textColor('Chain Affinity','notfound')
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

		if Convergence.recast then
			if buffactive['Convergence'] then
				textColor('Convergence','active')
				Convergence.flashed = false
			elseif Convergence.recast > 0 then
				textColor('Convergence','cooldown')
				Convergence.flashed = false
			else
				textColor('Convergence','ready')
				if not Convergence.flashed then
					flash('Convergence')
				end
				Convergence.flashed = true
			end
		else
			textColor('Convergence','notfound')
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

		if Diffusion.recast then
			if buffactive['Diffusion'] then
				textColor('Diffusion','active')
				Diffusion.flashed = false
			elseif Diffusion.recast > 0 then
				textColor('Diffusion','cooldown')
				Diffusion.flashed = false
			else
				textColor('Diffusion','ready')
				if not Diffusion.flashed then
					flash('Diffusion')
				end
				Diffusion.flashed = true
			end
		else
			textColor('Diffusion','notfound')
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

		if Efflux.recast then
			if buffactive['Efflux'] then
				textColor('Efflux','active')
				Efflux.flashed = false
			elseif Efflux.recast > 0 then
				textColor('Efflux','cooldown')
				Efflux.flashed = false
			else
				textColor('Efflux','ready')
				if not Efflux.flashed then
					flash('Efflux')
				end
				Efflux.flashed = true
			end
		else
			textColor('Efflux','notfound')
		end

		if ElementalSeal.recast then
			if buffactive['Elemental Seal'] then
				textColor('Elemental Seal','active')
				ElementalSeal.flashed = false
			elseif ElementalSeal.recast > 0 then
				textColor('Elemental Seal','cooldown')
				ElementalSeal.flashed = false
			else
				textColor('Elemental Seal','ready')
				if not ElementalSeal.flashed then
					flash('Elemental Seal')
				end
				ElementalSeal.flashed = true
			end
		else
			textColor('Elemental Seal','notfound')
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

		if Sambas.recast then
			if Sambas.recast > 0 then
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

		if UnbridledLearning.recast then
			if buffactive['Unbridled Learning'] then
				textColor('Unbridled Learning','active')
				UnbridledLearning.flashed = false
			elseif UnbridledLearning.recast > 0 then
				textColor('Unbridled Learning','cooldown')
				UnbridledLearning.flashed = false
			else
				textColor('Unbridled Learning','ready')
				if not UnbridledLearning.flashed then
					flash('Unbridled Learning')
				end
				UnbridledLearning.flashed = true
			end
		else
			textColor('Unbridled Learning','notfound')
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

		if Amplification.recast then
			if buffactive['Magic Atk. Boost'] and buffactive['Magic Def. Boost'] then
				textColor('Amplification','active')
				Amplification.flashed = false
			elseif Amplification.recast > 0 then
				textColor('Amplification','cooldown')
				Amplification.flashed = false
			else
				textColor('Amplification','ready')
				if not Amplification.flashed then
					flash('Amplification')
				end
				Amplification.flashed = true
			end
		else
			textColor('Amplification','notfound')
		end

		if AnimatingWail.recast then
			if buffactive['Haste'] then
				textColor('Animating Wail','active')
				AnimatingWail.flashed = false
			elseif AnimatingWail.recast > 0 then
				textColor('Animating Wail','cooldown')
				AnimatingWail.flashed = false
			else
				textColor('Animating Wail','ready')
				if not AnimatingWail.flashed then
					flash('Animating Wail')
				end
				AnimatingWail.flashed = true
			end
		else
			textColor('Animating Wail','notfound')
		end

		if BarrierTusk.recast then
			if buffactive['Phalanx'] then
				textColor('Barrier Tusk','active')
				BarrierTusk.flashed = false
			elseif BarrierTusk.recast > 0 then
				textColor('Barrier Tusk','cooldown')
				BarrierTusk.flashed = false
			else
				textColor('Barrier Tusk','ready')
				if not BarrierTusk.flashed then
					flash('Barrier Tusk')
				end
				BarrierTusk.flashed = true
			end
		else
			textColor('Barrier Tusk','notfound')
		end

		if BatteryCharge.recast then
			if buffactive['Refresh'] then
				textColor('Battery Charge','active')
				BatteryCharge.flashed = false
			elseif BatteryCharge.recast > 0 then
				textColor('Battery Charge','cooldown')
				BatteryCharge.flashed = false
			else
				textColor('Battery Charge','ready')
				if not BatteryCharge.flashed then
					flash('Battery Charge')
				end
				BatteryCharge.flashed = true
			end
		else
			textColor('Battery Charge','notfound')
		end

		if CarcharianVerve.recast then
			if buffactive['Aquaveil'] then
				textColor('Carcharian Verve','active')
				CarcharianVerve.flashed = false
			elseif CarcharianVerve.recast > 0 then
				textColor('Carcharian Verve','cooldown')
				CarcharianVerve.flashed = false
			else
				textColor('Carcharian Verve','ready')
				if not CarcharianVerve.flashed then
					flash('Carcharian Verve')
				end
				CarcharianVerve.flashed = true
			end
		else
			textColor('Carcharian Verve','notfound')
		end

		if Cocoon.recast then
			if buffactive['Defense Boost'] then
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

		if Diamondhide.recast then
			if buffactive['Stoneskin'] then
				textColor('Diamondhide','active')
				Diamondhide.flashed = false
			elseif Diamondhide.recast > 0 then
				textColor('Diamondhide','cooldown')
				Diamondhide.flashed = false
			else
				textColor('Diamondhide','ready')
				if not Diamondhide.flashed then
					flash('Diamondhide')
				end
				Diamondhide.flashed = true
			end
		else
			textColor('Diamondhide','notfound')
		end

		if ErraticFlutter.recast then
			if buffactive['Haste'] then
				textColor('Erratic Flutter','active')
				ErraticFlutter.flashed = false
			elseif ErraticFlutter.recast > 0 then
				textColor('Erratic Flutter','cooldown')
				ErraticFlutter.flashed = false
			else
				textColor('Erratic Flutter','ready')
				if not ErraticFlutter.flashed then
					flash('Erratic Flutter')
				end
				ErraticFlutter.flashed = true
			end
		else
			textColor('Erratic Flutter','notfound')
		end

		if FeatherBarrier.recast then
			if buffactive['Evasion Boost'] then
				textColor('Feather Barrier','active')
				FeatherBarrier.flashed = false
			elseif FeatherBarrier.recast > 0 then
				textColor('Feather Barrier','cooldown')
				FeatherBarrier.flashed = false
			else
				textColor('Feather Barrier','ready')
				if not FeatherBarrier.flashed then
					flash('Feather Barrier')
				end
				FeatherBarrier.flashed = true
			end
		else
			textColor('Feather Barrier','notfound')
		end

		if MagicBarrier.recast then
			if buffactive['Magic Shield'] then
				textColor('Magic Barrier','active')
				MagicBarrier.flashed = false
			elseif MagicBarrier.recast > 0 then
				textColor('Magic Barrier','cooldown')
				MagicBarrier.flashed = false
			else
				textColor('Magic Barrier','ready')
				if not MagicBarrier.flashed then
					flash('Magic Barrier')
				end
				MagicBarrier.flashed = true
			end
		else
			textColor('Magic Barrier','notfound')
		end

		if MementoMori.recast then
			if buffactive['Magic Atk. Boost'] then
				textColor('Memento Mori','active')
				MementoMori.flashed = false
			elseif MementoMori.recast > 0 then
				textColor('Memento Mori','cooldown')
				MementoMori.flashed = false
			else
				textColor('Memento Mori','ready')
				if not MementoMori.flashed then
					flash('Memento Mori')
				end
				MementoMori.flashed = true
			end
		else
			textColor('Memento Mori','notfound')
		end

		if MightyGuard.recast then
			if buffactive['Mighty Guard'] then
				textColor('Mighty Guard','active')
				MightyGuard.flashed = false
			elseif MightyGuard.recast > 0 then
				textColor('Mighty Guard','cooldown')
				MightyGuard.flashed = false
			else
				textColor('Mighty Guard','ready')
				if not MightyGuard.flashed then
					flash('Mighty Guard')
				end
				MightyGuard.flashed = true
			end
		else
			textColor('Mighty Guard','notfound')
		end

		if NaturesMeditation.recast then
			if buffactive['Attack Boost'] then
				textColor('Nature\'s Meditation','active')
				NaturesMeditation.flashed = false
			elseif NaturesMeditation.recast > 0 then
				textColor('Nature\'s Meditation','cooldown')
				NaturesMeditation.flashed = false
			else
				textColor('Nature\'s Meditation','ready')
				if not NaturesMeditation.flashed then
					flash('Nature\'s Meditation')
				end
				NaturesMeditation.flashed = true
			end
		else
			textColor('Nature\'s Meditation','notfound')
		end

		if Occultation.recast then
			if buffactive['Blink'] then
				textColor('Occultation','active')
				Occultation.flashed = false
			elseif Occultation.recast > 0 then
				textColor('Occultation','cooldown')
				Occultation.flashed = false
			else
				textColor('Occultation','ready')
				if not Occultation.flashed then
					flash('Occultation')
				end
				Occultation.flashed = true
			end
		else
			textColor('Occultation','notfound')
		end

		if OrcishCounterstance.recast then
			if buffactive['Counter Boost'] then
				textColor('Orcish Counterstance','active')
				OrcishCounterstance.flashed = false
			elseif OrcishCounterstance.recast > 0 then
				textColor('Orcish Counterstance','cooldown')
				OrcishCounterstance.flashed = false
			else
				textColor('Orcish Counterstance','ready')
				if not OrcishCounterstance.flashed then
					flash('Orcish Counterstance')
				end
				OrcishCounterstance.flashed = true
			end
		else
			textColor('Orcish Counterstance','notfound')
		end

		if PlasmaCharge.recast then
			if buffactive['Shock Spikes'] then
				textColor('Plasma Charge','active')
				PlasmaCharge.flashed = false
			elseif PlasmaCharge.recast > 0 then
				textColor('Plasma Charge','cooldown')
				PlasmaCharge.flashed = false
			else
				textColor('Plasma Charge','ready')
				if not PlasmaCharge.flashed then
					flash('Plasma Charge')
				end
				PlasmaCharge.flashed = true
			end
		else
			textColor('Plasma Charge','notfound')
		end

		if ReactorCool.recast then
			if buffactive['Ice Spikes'] and buffactive['Defense Boost'] then
				textColor('Reactor Cool','active')
				ReactorCool.flashed = false
			elseif ReactorCool.recast > 0 then
				textColor('Reactor Cool','cooldown')
				ReactorCool.flashed = false
			else
				textColor('Reactor Cool','ready')
				if not ReactorCool.flashed then
					flash('Reactor Cool')
				end
				ReactorCool.flashed = true
			end
		else
			textColor('Reactor Cool','notfound')
		end

		if Refueling.recast then
			if buffactive['Haste'] then
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

		if Regeneration.recast then
			if buffactive['Regen'] then
				textColor('Regeneration','active')
				Regeneration.flashed = false
			elseif Regeneration.recast > 0 then
				textColor('Regeneration','cooldown')
				Regeneration.flashed = false
			else
				textColor('Regeneration','ready')
				if not Regeneration.flashed then
					flash('Regeneration')
				end
				Regeneration.flashed = true
			end
		else
			textColor('Regeneration','notfound')
		end

		if SalineCoat.recast then
			if buffactive['Magic Def. Boost'] then
				textColor('Saline Coat','active')
				SalineCoat.flashed = false
			elseif SalineCoat.recast > 0 then
				textColor('Saline Coat','cooldown')
				SalineCoat.flashed = false
			else
				textColor('Saline Coat','ready')
				if not SalineCoat.flashed then
					flash('Saline Coat')
				end
				SalineCoat.flashed = true
			end
		else
			textColor('Saline Coat','notfound')
		end

		if TriumphantRoar.recast then
			if buffactive['Attack Boost'] then
				textColor('Triumphant Roar','active')
				TriumphantRoar.flashed = false
			elseif TriumphantRoar.recast > 0 then
				textColor('Triumphant Roar','cooldown')
				TriumphantRoar.flashed = false
			else
				textColor('Triumphant Roar','ready')
				if not TriumphantRoar.flashed then
					flash('Triumphant Roar')
				end
				TriumphantRoar.flashed = true
			end
		else
			textColor('Triumphant Roar','notfound')
		end

	end
end)

-------------------------------------------
--             ZONE CHANGE               --
-------------------------------------------

windower.register_event('zone change',function()
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

	if GreetingDelay == -1 then
		send_command('gs c ClearNotifications')
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
		if NotiTrade == 'On' then
			hud_noti_shdw:text('«« Trade Request »»')
			hud_noti:text('«« Trade Request »»')
			hud_noti:color(255,255,50)
		end
	elseif org:find('The effect of') and org:find('is about to wear off.') then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if NotiSneak == 'On' and org:find('Sneak') then
			hud_noti_shdw:text('«« Sneak Wearing »»')
			hud_noti:text('«« Sneak Wearing »»')
			hud_noti:color(255,100,100)
		elseif NotiInvis == 'On' and org:find('Invisible') then
			hud_noti_shdw:text('«« Invisible Wearing »»')
			hud_noti:text('«« Invisible Wearing »»')
			hud_noti:color(255,100,100)
		end
	elseif org:find('Lost key item') and org:find('Radialens') then
		send_command('gs c Radialens')
	elseif org:find('invites you to') then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav')
		end
		if NotiInvite == 'On' and org:find('party') and not org:find('alliance') then
			hud_noti_shdw:text('«« Party Invite »»')
			hud_noti:text('«« Party Invite »»')
			hud_noti:color(255,255,50)
		elseif NotiInvite == 'On' and org:find('alliance') then
			hud_noti_shdw:text('«« Alliance Invite »»')
			hud_noti:text('«« Alliance Invite »»')
			hud_noti:color(255,255,50)
		end
		NotiCountdown = 180
	elseif org:find('Your visitant status will wear off in') then
		if org:find(' 15 ') then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
			end
			if NotiTime == 'On' then
				hud_noti_shdw:text('«« 15 Minutes Remaining »»')
				hud_noti:text('«« 15 Minutes Remaining »»')
				hud_noti:color(255,255,50)
			end
		elseif org:find(' 10 ') then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
			end
			if NotiTime == 'On' then
				hud_noti_shdw:text('«« 10 Minutes Remaining »»')
				hud_noti:text('«« 10 Minutes Remaining »»')
				hud_noti:color(255,255,50)
			end
		elseif org:find(' 5 ') then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
			end
			if NotiTime == 'On' then
				hud_noti_shdw:text('«« 5 Minutes Remaining »»')
				hud_noti:text('«« 5 Minutes Remaining »»')
				hud_noti:color(255,255,50)
			end
		end
		NotiCountdown = NotiDelay
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
	elseif org:find('AzureSets:') then
		if org:find('Starting to set') then
			hud_mode_shdw:text('Mode: '..modeName[Mode]..' (Setting spells...)')
			hud_mode:text('Mode: '..modeName[Mode]..' (Setting spells...)')
			SpellSetCooldown = -1
		elseif org:find('has been equipped') then
			windower.send_command('gs c SpellSetCooldown')
		end
	elseif org:find('Trade complete') then
		send_command('gs c ClearNotifications')
	end
end)

-------------------------------------------
--         DAMAGE NOTIFICATIONS          --
-------------------------------------------

windower.register_event('action',function(act)

	if NotiDamage == 'On' then
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
			elseif act.targets[1].actions[1].message == 185 and act.targets[1].actions[1].has_add_effect == true then
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
		--Magic Bursts:
		elseif (act.category == 4 and act.targets[1].actions[1].message == 252) and act.actor_id == player.id then
			hud_noti_shdw:text('Magic Burst! '..spells[act.param].english..': '..addCommas(act.targets[1].actions[1].param))
			hud_noti:text('Magic Burst! '..spells[act.param].english..': '..addCommas(act.targets[1].actions[1].param))
			hud_noti:color(0,255,255)
			NotiCountdown = -1
		end
	end
end)

-------------------------------------------
--             FILE UNLOAD               --
-------------------------------------------

function file_unload()

	--unload the blualert plugin
	if BLUAlert == 'On' then
		send_command('lua unload blualert')
	end

	--Delete our text objects, aliases, and binds, thank you for your service
	hud_bg_color:destroy()
	hud_bg:destroy()
	hud_tp_meter_bg1:destroy()
	hud_tp_meter_bg2:destroy()
	hud_tp_meter:destroy()
	hud_noti_bg:destroy()
	hud_debuffs_bg:destroy()
	hud_abil01_bg:destroy()
	hud_abil02_bg:destroy()
	hud_abil03_bg:destroy()
	hud_abil04_bg:destroy()
	hud_abil05_bg:destroy()
	hud_abil06_bg:destroy()
	hud_weapons_shdw:destroy()
	hud_mode_shdw:destroy()
	hud_noti_shdw:destroy()
	hud_debuffs_shdw:destroy()
	hud_abil01_shdw:destroy()
	hud_abil02_shdw:destroy()
	hud_abil03_shdw:destroy()
	hud_abil04_shdw:destroy()
	hud_abil05_shdw:destroy()
	hud_abil06_shdw:destroy()
	hud_weapons:destroy()
	hud_mode:destroy()
	hud_noti:destroy()
	hud_debuffs:destroy()
	hud_abil01:destroy()
	hud_abil02:destroy()
	hud_abil03:destroy()
	hud_abil04:destroy()
	hud_abil05:destroy()
	hud_abil06:destroy()
	send_command('unalias mode1')
	send_command('unalias mode2')
	send_command('unalias mode3')
	send_command('unalias mode4')
	send_command('unalias mode5')
	send_command('unalias dt')
	send_command('unalias wc')
	send_command('unalias hud')
	send_command('unbind '..DTBind)
	send_command('unbind '..WCBind)

end

--[[

-------------------------------------------
--            KEYS NOTEPAD               --
-------------------------------------------


<general>
	<slot01>magic fruit</slot01>
	<slot02>tenebral crush</slot02>
	<slot03>barbed crescent</slot03>
	<slot04>sheep song</slot04>
	<slot05>occultation</slot05>
	<slot06>subduction</slot06>
	<slot07>battery charge</slot07>
	<slot08>blank gaze</slot08>
	<slot09>magic hammer</slot09>
	<slot10>erratic flutter</slot10>
	<slot11>delta thrust</slot11>
	<slot12>winds of promy.</slot12>
	<slot13>actinic burst</slot13>
	<slot14>dream flower</slot14>
	<slot15>reactor cool</slot15>
	<slot16>barrier tusk</slot16>
	<slot17>diamondhide</slot17>
	<slot18>white wind</slot18>
	<slot19>sudden lunge</slot19>
	<slot20>retinal glare</slot20>
</general>
<melee>
	<slot01>delta thrust</slot01>
	<slot02>barbed crescent</slot02>
	<slot03>occultation</slot03>
	<slot04>heavy strike</slot04>
	<slot05>cocoon</slot05>
	<slot06>searing tempest</slot06>
	<slot07>erratic flutter</slot07>
	<slot08>uppercut</slot08>
	<slot09>nat. meditation</slot09>
	<slot10>battle dance</slot10>
	<slot11>vanity dive</slot11>
	<slot12>sinker drill</slot12>
	<slot13>empty thrash</slot13>
	<slot14>anvil lightning</slot14>
	<slot15>frenetic rip</slot15>
	<slot16>embalming earth</slot16>
	<slot17>magic fruit</slot17>
	<slot18>sudden lunge</slot18>
	<slot19>fantod</slot19>
	<slot20>thrashing assault</slot20>
</melee>
<nuke>
	<slot01>delta thrust</slot01>
	<slot02>barbed crescent</slot02>
	<slot03>occultation</slot03>
	<slot04>tenebral crush</slot04>
	<slot05>cocoon</slot05>
	<slot06>sheep song</slot06>
	<slot07>diamondhide</slot07>
	<slot08>magic hammer</slot08>
	<slot09>battery charge</slot09>
	<slot10>magic fruit</slot10>
	<slot11>cursed sphere</slot11>
	<slot12>memento mori</slot12>
	<slot13>barrier tusk</slot13>
	<slot14>glutinous dart</slot14>
	<slot15>entomb</slot15>
	<slot16>retinal glare</slot16>
	<slot17>erratic flutter</slot17>
	<slot18>subduction</slot18>
	<slot19>dream flower</slot19>
	<slot20>spectral floe</slot20>
</nuke>
<support>
	<slot01>delta thrust</slot01>
	<slot02>barbed crescent</slot02>
	<slot03>occultation</slot03>
	<slot04>feather tickle</slot04>
	<slot05>lowing</slot05>
	<slot06>winds of promy.</slot06>
	<slot07>diamondhide</slot07>
	<slot08>blank gaze</slot08>
	<slot09>battery charge</slot09>
	<slot10>magic fruit</slot10>
	<slot11>sudden lunge</slot11>
	<slot12>tenebral crush</slot12>
	<slot13>reaving wind</slot13>
	<slot14>white wind</slot14>
	<slot15>osmosis</slot15>
	<slot16>retinal glare</slot16>
	<slot17>erratic flutter</slot17>
	<slot18>subduction</slot18>
	<slot19>silent storm</slot19>
	<slot20>pollen</slot20>
</support>

--]]
