-------------------------------------------
-- Keys Gearswap lua file for Summoner   --
-------------------------------------------
--[[

Updates to this file and other GearSwap files and addons can be found at
https://github.com/iLVL-Key/FFXI

Place both this file and the sounds folder inside the GearSwap data folder
ex:	/addons/GearSwap/data/sounds/
	/addons/GearSwap/data/SMN.lua

--------------------

To activate Damage Taken Override, use any of these three options:
1. A macro with the following
	/console DT
2. An alias command
	//dt
3. A keybind shortcut
	CTRL+D
	(Can be changed in the Advanced Options section)

--------------------

To use the Auto Elemental Siphon function, use either of these two option:
1. A macro with the following
	/console Siphon
2. An alias command
	//siphon

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

--vIGNORE THESEv--
sub = {} sub.WHM = {} sub.RDM = {} sub.SCH = {} sub.OTH = {} color = {} color.hi = {} color.md = {} color.lo = {} color.Light = {} color.Fire = {} color.Ice = {} color.Air = {} color.Earth = {} color.Thunder = {} color.Water = {} color.Dark = {} color.None = {} color.AM1 = {} color.AM2 = {} color.AM3 = {} color.abil = {} color.abil.ready = {} color.abil.active = {} color.abil.cooldown = {} color.abil.flash = {} color.abil.notfound = {}
--^IGNORE THESE^--

-------------------------------------------
--                OPTIONS                --
-------------------------------------------

Book			=	'4'		--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
Page			=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
AFTimer			=	'On'	--[On/Off]		Displays a timer for Astral Flow in echo.
ACTimer			=	'On'	--[On/Off]		Displays a timer for Astral Conduit in echo.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions
							--				(Town limits this to town gear only).
AlertSounds		=	'On'	--[On/Off]		Plays a sound on alerts. 
UseEcho			=	'R'		--[E/R/Off]		Automatically uses an (E)cho Drop or (R)emedy instead of spell when you are silenced.
AutoFavor		=	'On'	--[On/Off]		Automatically uses Favor when you summon an avatar.
AutoRelease		=	'On'	--[On/Off]		Automatically uses Release when you summon an avatar with one already out.
AutoSubCharge	=	'On'	--[On/Off]		Automatically attempts to keep Sublimation charging.

-- Avatar Macro Pages --
HomePage		=	'1'		--[1-10]		This is your starting macro page with all your summoning macros on them.
IfritPage		=	'2'		--[1-10]		Individual macro pages for avatars.
TitanPage		=	'3'		--[1-10]
LeviathanPage	=	'4'		--[1-10]
GarudaPage		=	'5'		--[1-10]
ShivaPage		=	'6'		--[1-10]
RamuhPage		=	'7'		--[1-10]
CarbunclePage	=	'8'		--[1-10]
FenrirPage		=	'9'		--[1-10]
CaitSithPage	=	'8'		--[1-10]
SirenPage		=	'10'	--[1-10]
DiabolosPage	=	'9'		--[1-10]

-- Heads Up Display --
HUDposX			=	100		--	X position for the HUD. 0 is left of the window, increasing this number will move it to the right.
HUDposY			=	100		--	Y position for the HUD. 0 is top of the window, increasing this number will move it downward.
FontSize		=	10		--	Adjust the font size. Changing this may require you to adjust the Spacers below as well.
LineSpacer		=	16		--	Space in pixels between each Line of the HUD.
ColumnSpacer	=	90.5	--	Space in pixels between each Column of the HUD.
ShowTPMeter		=	'On'	--[On/Off]		Show the mini TP Meter inside the Weapons area.

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
NotiDamage			=	'On'	--[On/Off]	Displays your Weapon Skill, Skillchain, Magic Burst, and Blood Pact damage.
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
--		Astral Flow, Astral Conduit, Apogee, Avatar's Favor, Blood Pact: Rage, Blood Pact: Ward, Convert, Dark Arts, Divine Seal, Elemental Siphon, Light Arts, Mana Cede, Sublimation
-- The "_sh" column allows you to change the name displayed if you would like, leave blank otherwise
-- NOTE: Names will automatically be truncated to 10 characters to fit correctly.

--SMN/WHM
sub.WHM.Abil01 = "Apogee"			sub.WHM.Abil01_sh = ""
sub.WHM.Abil02 = "Mana Cede"		sub.WHM.Abil02_sh = ""
sub.WHM.Abil03 = "Elemental Siphon"	sub.WHM.Abil03_sh = "E Siphon"
sub.WHM.Abil04 = "Blood Pact: Ward"	sub.WHM.Abil04_sh = "BP Ward"
sub.WHM.Abil05 = "Blood Pact: Rage"	sub.WHM.Abil05_sh = "BP Rage"
sub.WHM.Abil06 = "Divine Seal"		sub.WHM.Abil06_sh = "Divn Seal"
--SMN/RDM
sub.RDM.Abil01 = "Apogee"			sub.RDM.Abil01_sh = ""
sub.RDM.Abil02 = "Mana Cede"		sub.RDM.Abil02_sh = ""
sub.RDM.Abil03 = "Elemental Siphon"	sub.RDM.Abil03_sh = "E Siphon"
sub.RDM.Abil04 = "Blood Pact: Ward"	sub.RDM.Abil04_sh = "BP Ward"
sub.RDM.Abil05 = "Blood Pact: Rage"	sub.RDM.Abil05_sh = "BP Rage"
sub.RDM.Abil06 = "Convert"			sub.RDM.Abil06_sh = ""
--SMN/SCH
sub.SCH.Abil01 = "Apogee"			sub.SCH.Abil01_sh = ""
sub.SCH.Abil02 = "Mana Cede"		sub.SCH.Abil02_sh = ""
sub.SCH.Abil03 = "Elemental Siphon"	sub.SCH.Abil03_sh = "E Siphon"
sub.SCH.Abil04 = "Blood Pact: Ward"	sub.SCH.Abil04_sh = "BP Ward"
sub.SCH.Abil05 = "Blood Pact: Rage"	sub.SCH.Abil05_sh = "BP Rage"
sub.SCH.Abil06 = "Sublimation"		sub.SCH.Abil06_sh = "Sublmation"
--SMN/other
sub.OTH.Abil01 = "Apogee"			sub.OTH.Abil01_sh = ""
sub.OTH.Abil02 = "Mana Cede"		sub.OTH.Abil02_sh = ""
sub.OTH.Abil03 = "Elemental Siphon"	sub.OTH.Abil03_sh = "E Siphon"
sub.OTH.Abil04 = "Blood Pact: Ward"	sub.OTH.Abil04_sh = "BP Ward"
sub.OTH.Abil05 = "Blood Pact: Rage"	sub.OTH.Abil05_sh = "BP Rage"
sub.OTH.Abil06 = "Avatar's Favor"	sub.OTH.Abil06_sh = "Avtr Favor"

-------------------------------------------
--             COLOR VALUES              --
-------------------------------------------

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
color.None.r = 255
color.None.g = 50
color.None.b = 50

--HP Meter

--High
color.hi.r = 0
color.hi.g = 255
color.hi.b = 0
--Medium
color.md.r = 255
color.md.g = 165
color.md.b = 0
--Low
color.lo.r = 255
color.lo.g = 0
color.lo.b = 50

--Aftermath

--Level 1
color.AM1.r = 0
color.AM1.g = 127
color.AM1.b = 255
--Level 2
color.AM2.r = 75
color.AM2.g = 255
color.AM2.b = 75
--Level 3
color.AM3.r = 255
color.AM3.g = 255
color.AM3.b = 50

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
--               GEAR SETS               --
-------------------------------------------

function get_sets()

-- Idle (Movement Speed, Refresh, Regen, Damage Taken-, Enmity-)
-- Used when you do NOT have an avatar out.
sets.idle = {
	main="Malignance Pole",
	sub="Vox Grip",
	ammo="Staunch Tathlum +1",
	head="Beckoner's Horn +3",
	body="Apo. Dalmatica +1",
	hands="Asteria Mitts +1",
	legs="Assid. Pants +1",
	feet="Herald's Gaiters",
	neck="Smn. Collar +2",
	waist="Regal Belt",
	left_ear="Lugalbanda Earring",
	right_ear="Beck. Earring +2",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Magic Damage+10','"Fast Cast"+10','Mag. Evasion+15',}},
}

-- Avatar (Avatar Perpetuation- (cap is -14), Refresh, Avatar's Favor+, etc.)
-- Used when you DO have an avatar out.
-- Combines with Idle set, only necessary to set the slots with specific desired stats
sets.avatar = set_combine(sets.idle, {
	main="Nirvana",					--Perp -8
	sub="Vox Grip",
	ammo="Epitaph",
	head="Beckoner's Horn +3",
	body="Beck. Doublet +3",		--Perp -8
	hands="Asteria Mitts +1",
	legs="Assid. Pants +1",			--Perp -3 (over cap but it has refresh)
	feet="Baaya. Sabots +1",
	neck="Smn. Collar +2",
	waist="Incarnation Sash",
	left_ear="Lugalbanda Earring",
	right_ear="Beck. Earring +2",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: Haste+10','Pet: "Regen"+5',}},
})

-- DT Override (Damage Taken-, Magic Evasion)
-- Will override all other gear sets but still inherit unused slots from them
sets.dtoverride = {
	body="Beck. Doublet +3",
	hands="Nyame Gauntlets",
	legs="Beck. Spats +3",
	feet="Nyame Sollerets",
	neck="Smn. Collar +2",
	right_ring="Defending Ring",
}

-- Oh Shit
-- Full DT- and everything you've got with Absorbs or Annuls Damage
sets.ohshit = {
	body="Beck. Doublet +3",
	hands="Nyame Gauntlets",
	legs="Beck. Spats +3",
	feet="Nyame Sollerets",
	neck="Warder's Charm +1",
	left_ring="Shadow Ring",
	right_ring="Defending Ring",
	back="Shadow Mantle",
}

-- DPS (Accuracy, Double/Triple Attack, DEX, Store TP, Attack)
sets.dps = {
	main="Nirvana",
	sub="Vox Grip",
	ammo="Epitaph",
	head="Beckoner's Horn +3",
	body="Beck. Doublet +3",
	hands="Lamassu Mitts +1",
	legs="Assid. Pants +1",
	feet="Beck. Pigaches +3",
	neck="Caller's Pendant",
	waist="Incarnation Sash",
	left_ear="Lugalbanda Earring",
	right_ear="Evans Earring",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: Haste+10','Pet: "Regen"+5',}},
}

-- Rest
sets.rest = {
	waist="Austerity Belt",
}

-- Weapon Skill - Basic (STR, Weapon Skill Damage, Attack, Double/Triple Attack)
sets.ws = {
	head="Nyame Helm",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Rep. Plat. Medal",
	waist="Windbuffet Belt +1",
	left_ear="Ishvara Earring",
	right_ear="Moonshade Earring",
	left_ring="Hetairoi Ring",
	right_ring="Karieyh Ring +1",
}

-- Garland of Bliss (combines with Weapon Skill set above)
sets["Garland of Bliss"] = set_combine(sets.ws, {
	neck="Fotia Gorget",
	waist="Fotia Belt",
})

-- Fast Cast (cap is 80%) (precast for casting summons)
sets.fastcast = {
	head="Amalric Coif +1", --11%
	body="Amalric Doublet +1", --4% (from augment)
	hands="Leyline Gloves", --5+1
	feet="Amalric Nails +1", --6%
	neck="Baetyl Pendant", --4%
	waist="Embla Sash", --5%
	left_ear="Malignance Earring", --4%
	right_ear="Loquac. Earring", --2%
	left_ring="Prolix Ring", --2%
	right_ring="Kishar Ring", --4%
	back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Magic Damage+10','"Fast Cast"+10','Mag. Evasion+15',}},
}

-- Summoning (Summoning Magic Interruption Rate Down)
sets.summoning = set_combine(sets.fastcast, {
	body="Baayami Robe +1",
})

-- Blood Pact Delay (BP Ability Delay-, SMN Skill+) (BP precast)
-- NOTE:	BPD-I + BPD-II + BPD-III (only from JP gifts, -10s) cap is -30s. This means that including the JP gifts, you only need a total of -20s between BPD-I and BPD-II (which each individually cap at -15s).
sets.bpdelay = {
	main="Espiritus",				--Skill +15		BPD-II -2
	sub="Vox Grip",					--Skill +3
	ammo="Epitaph",					--				BPD-II -5
	head="Beckoner's Horn +3",		--Skill +23
	body="Baayami Robe +1",			--Skill +37
	hands="Baayami Cuffs +1",		--Skill +33		BPD-I -7
	legs="Baayami Slops +1",		--Skill +35		BPD-I -8
	feet="Baaya. Sabots +1",		--Skill +29
	neck="Incanter's Torque",		--Skill +10
	waist="Kobo Obi",				--Skill +8
	left_ear="Lodurr Earring",		--Skill +10
	right_ear="Beck. Earring +2",
	left_ring="Stikini Ring +1",	--Skill +8
	right_ring="Stikini Ring +1",	--Skill +8
	back="Conveyance Cape",			--Skill +13
}

-- Blood Pact: Rage Physical (BP Damage+, Pet: Att+) (BP midcast)
sets.bpragephysical = {
	main="Nirvana",
	sub="Elan Strap",
	ammo="Epitaph",
	head={ name="Apogee Crown +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}},
	body="Beck. Doublet +3",
	hands={ name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+22','Blood Pact Dmg.+10','Pet: STR+8','Pet: Mag. Acc.+15',}},
	legs={ name="Enticer's Pants", augments={'MP+30','Pet: Mag. Acc.+12','Pet: Damage taken -1%',}},
	feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}},
	neck="Smn. Collar +2",
	waist="Incarnation Sash",
	left_ear="Lugalbanda Earring",
	right_ear="Beck. Earring +2",
	left_ring="Varar Ring +1",
	right_ring="Varar Ring +1",
	back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: Haste+10','Pet: "Regen"+5',}},
}

-- Blood Pact: Rage Magical (BP Damage+, Pet: MAB+) (BP midcast)
sets.bpragemagical = {
	main="Grioavolr",
	sub="Elan Strap",
	ammo="Epitaph",
	head={ name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
	body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
	hands={ name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+22','Blood Pact Dmg.+10','Pet: STR+8','Pet: Mag. Acc.+15',}},
	legs={ name="Enticer's Pants", augments={'MP+30','Pet: Mag. Acc.+12','Pet: Damage taken -1%',}},
	feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
	neck="Smn. Collar +2",
	waist="Regal Belt",
	left_ear="Lugalbanda Earring",
	right_ear="Beck. Earring +2",
	left_ring="Varar Ring +1",
	right_ring="Varar Ring +1",
	back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Magic Damage+10','"Fast Cast"+10','Mag. Evasion+15',}},
}

-- Blood Pact: Rage Hybrid (BP Damage+, Pet: MAB+, Pet: Att+) (BP midcast)
sets.bpragehybrid = {
	main="Nirvana",
	sub="Elan Strap",
	ammo="Epitaph",
	head={ name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
	body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
	hands={ name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+22','Blood Pact Dmg.+10','Pet: STR+8','Pet: Mag. Acc.+15',}},
	legs={ name="Enticer's Pants", augments={'MP+30','Pet: Mag. Acc.+12','Pet: Damage taken -1%',}},
	feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
	neck="Smn. Collar +2",
	waist="Regal Belt",
	left_ear="Lugalbanda Earring",
	right_ear="Beck. Earring +2",
	left_ring="Varar Ring +1",
	right_ring="Varar Ring +1",
	back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Magic Damage+10','"Fast Cast"+10','Mag. Evasion+15',}},
}

-- Blood Pact: Ward Buff (SMN skill) (BP midcast)
sets.bpwardbuff = {
	main="Espiritus",
	sub="Vox Grip",
	ammo="Epitaph",
	head="Baayami Hat +1",
	body="Baayami Robe +1",
	hands="Baayami Cuffs +1",
	legs="Baayami Slops +1",
	feet="Baaya. Sabots +1",
	neck="Incanter's Torque",
	waist="Kobo Obi",
	left_ear="Lodurr Earring",
	right_ear="Beck. Earring +2",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back="Conveyance Cape",
}

-- Blood Pact: Ward Debuff (SMN skill, Pet MAcc) (BP midcast)
sets.bpwarddebuff = {
	main="Espiritus",
	sub="Vox Grip",
	ammo="Epitaph",
	head="Beckoner's Horn +3",
	body="Baayami Robe +1",
	hands="Lamassu Mitts +1",
	legs="Beck. Spats +3",
	feet="Baaya. Sabots +1",
	neck="Incanter's Torque",
	waist="Kobo Obi",
	left_ear="Lodurr Earring",
	right_ear="Beck. Earring +2",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Magic Damage+10','"Fast Cast"+10','Mag. Evasion+15',}},
}

-- Healing (Cure Potency, Healing Magic Skill)
-- NOTE: Cure Potency cap is 50%
sets.healing = {
	head="Vanya Hood", --10
	body="Vrikodara Jupon", --13
	hands="Vanya Cuffs",
	legs="Vanya Slops",
	feet="Vanya Clogs", --5
	neck="Nodens Gorget", --5
	left_ear="Mendi. Earring", --5
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back="Solemnity Cape", --7
}

-- Buff (Conserve MP)
sets.buff = {
	head="Vanya Hood",
	body="Vedic Coat",
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
	waist="Gishdubar Sash",
}

-- Astral Flow (Enhances Astral Flow gear)
sets.astralflow = {
	head="Glyphic Horn",
}

-- Elemental Siphon (Enhances Elemental Siphon gear)
sets.elementalsiphon = {
	main="Chatoyant Staff",
	ammo="Esper Stone +1",
	back="Conveyance Cape",
}

-- Mana Cede (Enhances Mana Cede gear)
sets.manacede = {
	hands="Beck. Bracers +3",
}

-- Default Town Gear (Put all your fancy-pants gear in here you want to showboat around town. Does not lockstyle this gear, only equips)
sets.town = set_combine(sets.idle, {
	main="Nirvana",
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




FileVersion = '12.3'

-------------------------------------------
--            AVATAR MAPPING             --
-------------------------------------------

Avatars = S{
	'Carbuncle','Cait Sith','Ifrit','Shiva','Garuda','Titan','Ramuh','Leviathan','Fenrir','Diabolos','Siren','Atomos','Alexander','Odin'
	}

Spirits = S{
	'Light Spirit','Fire Spirit','Ice Spirit','Air Spirit','Earth Spirit','Thunder Spirit','Water Spirit','Dark Spirit'
	}

-------------------------------------------
--          BLOOD PACT MAPPING           --
-------------------------------------------

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
res = require('resources')
texts = require('texts')
weaponskills = res.weapon_skills
spells = res.spells
jobabilities = res.job_abilities
NotiLowMPToggle = 'Off' --start with the toggle off for the Low MP Notification so that it can trigger
DTOverride = "Off" --Start with the Damage Taken Override off
RRRCountdown = RRReminderTimer
HUDposYLine1 = HUDposY
Heartbeat = 0 --set to 0 just to start the Heartbeat running
GreetingDelay = 6 --delay to display greeting and file version info
Zoning = false --flips automatically to hide the HUD while zoning
InCS = false --flips automatically to hide the HUD while in a cs
PetPresent = false
LowHP = false
Alive = true --makes it easier to Do Things or Not Do Things based on if we die.
announceAlive = false --simple flip when we raise to make sure the AliveDelay command and notification text is only done once
DangerCountdown = 0
NotiCountdown = -1 --we set the countdown below 0 to stop the countdown from hitting 0 and triggering the ClearNotifications command
EquipMain = ''
PetHPP = -1
PetStatus = -1
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

-- Sets the inital subjob
local subjob = 'OTH'
if player.sub_job == 'WHM' then
	subjob = 'WHM'
elseif player.sub_job == 'RDM' then
	subjob = 'RDM'
elseif player.sub_job == 'SCH' then
	subjob = 'SCH'
end

-- Sets the Chat Mode
if Chat ~= "Off" then
	send_command('input /cm '..Chat..'')
end

-- Sets the Macro Book and Page
if Book ~= "Off" then
	send_command('input /macro book '..Book..'')
end
if Page ~= "Off" and not pet.isvalid then
	send_command('wait 2;input /macro set '..Page..'')
else
	send_command('wait 2;input /macro set 1')
end

AstralFlow = {} AstralConduit = {} Apogee = {} AvatarsFavor = {} BloodPactRage = {} BloodPactWard = {} Convert = {} DarkArts = {} DivineSeal = {} ElementalSiphon = {} LightArts = {} ManaCede = {} Sublimation = {} 

AstralFlow.flashed = true
AstralConduit.flashed = true
Apogee.flashed = true
AvatarsFavor.flashed = true
BloodPactRage.flashed = true
BloodPactWard.flashed = true
Convert.flashed = true
DarkArts.flashed = true
DivineSeal.flashed = true
ElementalSiphon.flashed = true
LightArts.flashed = true
ManaCede.flashed = true
Sublimation.flashed = true

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

-- Create the HUD BG Color text object (Avatar HP Bar)
local hud_bg_color = texts.new()
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

-- Create the HUD Avatar Text Shadow text object
local hud_avatar_shdw = texts.new('No Avatar')
hud_avatar_shdw:color(0,0,0)
hud_avatar_shdw:font("Consolas")
hud_avatar_shdw:size(FontSize)
hud_avatar_shdw:bg_alpha(0)
hud_avatar_shdw:pos(HUDposXColumn1+2.5,HUDposYLine2+0.5)
hud_avatar_shdw:draggable(false)
hud_avatar_shdw:bold(true)

-- Create the HUD Notifications Text Shadow text object
local hud_noti_shdw = texts.new('Keys SMN Gearswap file v'..FileVersion)
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
hud_weapons:font("Consolas")
hud_weapons:size(FontSize)
hud_weapons:bg_alpha(0)
hud_weapons:pos(HUDposXColumn4,HUDposYLine2-1)
hud_weapons:draggable(false)
hud_weapons:bold(true)

-- Create the HUD Avatar text object
local hud_avatar = texts.new('No Avatar')
hud_avatar:font("Consolas")
hud_avatar:size(FontSize)
hud_avatar:bg_alpha(0)
hud_avatar:pos(HUDposXColumn1+1,HUDposYLine2-1)
hud_avatar:draggable(false)
hud_avatar:bold(true)

local c = color.None
hud_avatar:color(c.r,c.g,c.b)

-- Create the HUD Notifications text object
local hud_noti = texts.new('Keys SMN Gearswap file v'..FileVersion)
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
	hud_abil01_bg:show()
	hud_abil02_bg:show()
	hud_abil03_bg:show()
	hud_abil04_bg:show()
	hud_abil05_bg:show()
	hud_abil06_bg:show()
	hud_weapons_shdw:show()
	hud_avatar_shdw:show()
	hud_noti_shdw:show()
	hud_debuffs_shdw:show()
	hud_abil01_shdw:show()
	hud_abil02_shdw:show()
	hud_abil03_shdw:show()
	hud_abil04_shdw:show()
	hud_abil05_shdw:show()
	hud_abil06_shdw:show()
	hud_weapons:show()
	hud_avatar:show()
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

send_command('alias dt gs c DT') --creates the DT Override and alias
send_command('alias hud gs c HUD') --creates the HUD alias
send_command('alias siphon gs c Siphon') --creates the Elemental Siphon alias
send_command('bind '..DTBind..' gs c DT') --creates the DT Override keyboard shortcut

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

	AstralFlow.recast = ability_recast[0] and math.floor(ability_recast[0]) or nil
	AstralConduit.recast = ability_recast[254] and math.floor(ability_recast[254]) or nil
	Apogee.recast = ability_recast[108] and math.floor(ability_recast[108]) or nil
	AvatarsFavor.recast = ability_recast[176] and math.floor(ability_recast[176]) or nil
	BloodPactRage.recast = ability_recast[173] and math.floor(ability_recast[173]) or nil
	BloodPactWard.recast = ability_recast[174] and math.floor(ability_recast[174]) or nil
	Convert.recast = ability_recast[49] and math.floor(ability_recast[49]) or nil
	DarkArts.recast = ability_recast[232] and math.floor(ability_recast[232]) or nil
	DivineSeal.recast = ability_recast[26] and math.floor(ability_recast[26]) or nil
	ElementalSiphon.recast = ability_recast[175] and math.floor(ability_recast[175]) or nil
	LightArts.recast = ability_recast[228] and math.floor(ability_recast[228]) or nil
	ManaCede.recast = ability_recast[71] and math.floor(ability_recast[71]) or nil
	Sublimation.recast = ability_recast[234] and math.floor(ability_recast[234]) or nil

end

getRecasts()

-- Format abilities/spells to fit into their allotted 12 spaces
local function formatAbils(input,input_sh)

	-- Valid abilities/spells
	local validAbilities = {
		"Astral Flow", "Astral Conduit", "Apogee", "Avatar\'s Favor", "Blood Pact: Rage", "Blood Pact: Ward", "Convert", "Dark Arts", "Divine Seal", "Elemental Siphon", "Light Arts", "Mana Cede", "Sublimation"
	}

	local ab = {} ab['Astral Flow'] = AstralFlow ab['Astral Conduit'] = AstralConduit ab['Apogee'] = Apogee ab['Avatar\'s Favor'] = AvatarsFavor ab['Blood Pact: Rage'] = BloodPactRage ab['Blood Pact: Ward'] = BloodPactWard ab['Convert'] = Convert ab['Dark Arts'] = DarkArts ab['Divine Seal'] = DivineSeal ab['Elemental Siphon'] = ElementalSiphon ab['Light Arts'] = LightArts ab['Mana Cede'] = ManaCede ab['Sublimation'] = Sublimation
	
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
			local c = (ab[ability] and ab[ability].recast == 0) and color.abil.active or color.abil.ready

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

local function relicAMUpdate(tp)
	pre_AMTimer = math.floor(tp * 0.06)
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
		pre_AMTimer = 270
	elseif tp >= 2000 and tp < 3000 then
		pre_mythicNum = math.floor((tp * 0.06) - 80)
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

	if primeMatch(22104) then --stage 3 Prime
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
	elseif primeMatch(22105) then --stage 4 Prime
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
	elseif primeMatch(22106) then --stage 5 Prime
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
	if command == 'DT' then
		if DTOverride == 'Off' then
			DTOverride = 'On'
		elseif DTOverride == 'On' then
			DTOverride = 'Off'
		end
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
	elseif command == 'Siphon' then
		SpiritElements={Light='Light Spirit',Fire='Fire Spirit',Ice='Ice Spirit',Wind='Air Spirit',Earth='Earth Spirit',Lightning='Thunder Spirit',Water='Water Spirit',Dark='Dark Spirit'}
		SpiritOpposing={Light='Dark',Fire='Ice',Ice='Wind',Wind='Earth',Earth='Lightning',Lightning='Water',Water='Fire',Dark='Light'}
		if world.weather_element ~= 'None' and SpiritOpposing[world.day_element] ~= world.weather_element then
			send_command('input /ma '..SpiritElements[world.weather_element]..' <me>')
		else
			send_command('input /ma '..SpiritElements[world.day_element]..' <me>')
		end
		send_command('wait 4.5;input /ja "Elemental Siphon" <me>;wait 1;input /pet Release <me>')
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
		hud_avatar_shdw:show()
		hud_noti_shdw:show()
		hud_debuffs_shdw:show()
		hud_abil01_shdw:show()
		hud_abil02_shdw:show()
		hud_abil03_shdw:show()
		hud_abil04_shdw:show()
		hud_abil05_shdw:show()
		hud_abil06_shdw:show()
		hud_weapons:show()
		hud_avatar:show()
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
		hud_avatar_shdw:hide()
		hud_noti_shdw:hide()
		hud_debuffs_shdw:hide()
		hud_abil01_shdw:hide()
		hud_abil02_shdw:hide()
		hud_abil03_shdw:hide()
		hud_abil04_shdw:hide()
		hud_abil05_shdw:hide()
		hud_abil06_shdw:hide()
		hud_weapons:hide()
		hud_avatar:hide()
		hud_noti:hide()
		hud_debuffs:hide()
		hud_abil01:hide()
		hud_abil02:hide()
		hud_abil03:hide()
		hud_abil04:hide()
		hud_abil05:hide()
		hud_abil06:hide()
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
	elseif command == "double_avatars_favor_fix" then
		double_avatars_favor_fix = false
	elseif command == "double_release_fix" then
		double_release_fix = false
	elseif command == "double_sublimation_fix" then
		double_sublimation_fix = false
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
			equip(set_combine(sets.dps, sets.dtoverride))
		else
			equip(sets.dps)
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
			equip(set_combine(sets.idle, sets.adoulin))
		elseif BastokZones:contains(world.area) then
			equip(set_combine(sets.idle, sets.bastok))
		elseif SandyZones:contains(world.area) then
			equip(set_combine(sets.idle, sets.sandoria))
		elseif WindyZones:contains(world.area) then
			equip(set_combine(sets.idle, sets.windurst))
		elseif TownZones:contains(world.area) then
			equip(set_combine(sets.idle, sets.town))
		elseif pet.isvalid == true then
			if DTOverride == "On" then
				equip(set_combine(sets.avatar, sets.dtoverride))
			else
				equip(sets.avatar)
			end
		else
			if LowHP == true then --no matter what Mode we're in, if we have low HP we equip the Oh Shit gear set
				equip(set_combine(sets.idle, sets.ohshit))
			elseif DTOverride == "On" then
				equip(set_combine(sets.idle, sets.dtoverride))
			else
				equip(sets.idle)
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
		elseif sets[spell.english] then
			equip(sets[spell.english])
		else
			equip(sets.ws)
		end
		if player.equipment.main == "Khatvanga" and spell.english == "Shattersoul" then
			pre_AMTimer = 181
		elseif player.equipment.main == 'Claustrum' and spell.english == "Gates of Tartarus" then
			player_tp = player.tp
			TP_Window_Open = true
			relicAMUpdate(player_tp)
		elseif player.equipment.main == 'Hvergelmir' and spell.english == "Myrkr" then
			player_tp = player.tp
			TP_Window_Open = true
			empyreanAMUpdate(player_tp)
		elseif player.equipment.main == "Nirvana" and spell.english == "Garland of Bliss" then
			player_tp = player.tp
			TP_Window_Open = true
			mythicAMUpdate(player_tp)
		elseif player.equipment.main == 'Opashoro' and spell.english == "Oshala" then
			player_tp = player.tp
			TP_Window_Open = true
			primeAMUpdate(player_tp)
		end
	elseif (spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard') and not (buffactive['Astral Conduit'] or buffactive['Apogee']) then
		--if we're using a BP without Avatar's Favor up, we'll put it up before casting:
		if AutoFavor == 'On' and not buffactive['Avatar\'s Favor'] and not buffactive['amnesia'] and windower.ffxi.get_ability_recasts()[176] == 0 then
			if not double_avatars_favor_fix then
				double_avatars_favor_fix = true --prevents this from running through here a second time after being cast again below
				cancel_spell()
				send_command('input /ja "Avatar\'s Favor" <me>;wait 1;input /pet \"'..spell.english..'\" '..spell.target.raw..';wait 1;gs c double_avatars_favor_fix')
				return
			end
		else
			equip(sets.bpdelay)
		end
	elseif spell.english == 'Astral Flow' then
		equip(sets.astralflow)
	elseif spell.english == 'Mana Cede' and windower.ffxi.get_ability_recasts()[71] < 2 then
		equip(sets.manacede)
	elseif spell.english == 'Holy Water' then
		equip(sets.hwater)
	elseif spell.english == 'Elemental Siphon' and windower.ffxi.get_ability_recasts()[175] < 2 then
		equip(sets.elementalsiphon)
	elseif (Avatars:contains(spell.english) or Spirits:contains(spell.english)) then
		--if we're casting an avatar with one already out, we'll use Release before casting:
		if pet.isvalid == true and AutoRelease == 'On' and windower.ffxi.get_ability_recasts()[172] == 0 then
			if not double_release_fix then
				double_release_fix = true
				cancel_spell()
				send_command('input /pet "Release" <me>;wait 1;input /ma \"'..spell.english..'\" <me>;wait 1;gs c double_release_fix')
			end
		end
		equip(sets.summoning)
	elseif (spell.english == 'Spectral Jig' or spell.english == 'Sneak' or spell.english == 'Monomi: Ichi' or spell.english == 'Monomi: Ni') and buffactive['Sneak'] and spell.target.type == 'SELF' then
		send_command('cancel 71')
		equip(sets.fastcast)
	elseif spell.english == 'Stoneskin' and buffactive['Stoneskin'] then
		send_command('cancel 37')
		equip(sets.fastcast)
	elseif not (spell.english == 'Assault' or spell.english == 'Retreat' or spell.english == 'Release' or spell.english == 'Avatar\'s Favor' or string.find(spell.english,' Ring') or spell.english == 'Forbidden Key' or spell.english == 'Pickaxe' or spell.english == 'Sickle' or spell.english == 'Hatchet') then
		equip(sets.fastcast)
	end
end

-------------------------------------------
--               MIDCAST                 --
-------------------------------------------

function midcast(spell)
	if spell.english == 'Refresh' then
		equip(set_combine(sets.buff, sets.refresh))
	elseif spell.english == 'Cursna' then
		equip(sets.cursna)
	elseif string.find(spell.english,'Cur') and spell.type == "WhiteMagic" then
		equip(set_combine(sets.buff, sets.healing))
	elseif spell.type == 'Trust' then
		equip(sets.unity)
	end
end

function pet_midcast(spell)
	if spell.type == 'BloodPactRage' then
		if BPRagePhysical:contains(spell.english) then
			equip(sets.bpragephysical)
		elseif BPRageMagical:contains(spell.english) then
			equip(sets.bpragemagical)
		else
			equip(sets.bpragehybrid)
		end
	elseif spell.type == 'BloodPactWard' then
		if BPWardBuff:contains(spell.english) then
			equip(sets.bpwardbuff)
		else
			equip(sets.bpwarddebuff)
		end
	end
end

-------------------------------------------
--              AFTERCAST                --
-------------------------------------------

function aftercast(spell)
	if spell.english == 'Astral Flow' and AFTimer == 'On' and not spell.interrupted then
		if player.equipment.head == 'Glyphic Horn' or player.equipment.head == 'Glyphic Horn +1' or player.equipment.head == 'Glyphic Horn +2' or player.equipment.head == 'Glyphic Horn +3' then --these pieces extend Astral Flow by 30 seconds so we adjust accordingly
			send_command('input /echo [Astral Flow] 3:30;wait 30;input /echo [Astral Flow] 3:00;wait 30;input /echo [Astral Flow] 2:30;wait 30;input /echo [Astral Flow] 2:00;wait 30;input /echo [Astral Flow] 1:30;wait 30;input /echo [Astral Flow] 1:00;wait 30;input /echo [Astral Flow] 0:30;wait 10;input /echo [Astral Flow] 0:20;wait 10;input /echo [Astral Flow] 0:10')
		else
			send_command('input /echo [Astral Flow] 3:00;wait 30;input /echo [Astral Flow] 2:30;wait 30;input /echo [Astral Flow] 2:00;wait 30;input /echo [Astral Flow] 1:30;wait 30;input /echo [Astral Flow] 1:00;wait 30;input /echo [Astral Flow] 0:30;wait 10;input /echo [Astral Flow] 0:20;wait 10;input /echo [Astral Flow] 0:10')
		end
	elseif spell.english == 'Astral Conduit' then
		if pet.isvalid and pet.name == 'Ifrit' then
			equip(sets.bpragehybrid)
		elseif pet.isvalid then
			equip(sets.bpragephysical)
		end
		if ACTimer == 'On' then
			send_command('input /echo [Astral Conduit] 1:00;wait 30;input /echo [Astral Conduit] 0:30;wait 10;input /echo [Astral Conduit] 0:20;wait 10;input /echo [Astral Conduit] 0:10')
		end
	end
	if spell.type == "SummonerPact" then
		if DTOverride == "On" then
			equip(set_combine(sets.avatar, sets.dtoverride))
		else
			equip(sets.avatar)
		end
		if AutoFavor == 'On' and not buffactive['Avatar\'s Favor'] and not buffactive['amnesia'] and windower.ffxi.get_ability_recasts()[176] == 0 then
			send_command('wait 3.5;input /ja "Avatar\'s Favor" <me>')
		end
	elseif spell.english == "Release" then
		if DTOverride == "On" then
			equip(set_combine(sets.idle, sets.dtoverride))
		else
			equip(sets.idle)
		end
	elseif not (spell.type == "BloodPactRage" or spell.type == "BloodPactWard" or spell.english == 'Astral Conduit') then
		choose_set()
	end
	if AutoSubCharge and Sublimation.recast < 2 and not (buffactive['amnesia'] or buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete']) then
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

function pet_aftercast(spell)
	if not (buffactive['Astral Conduit'] or buffactive['Apogee']) then
		if DTOverride == "On" then
			equip(set_combine(sets.avatar, sets.dtoverride))
		else
			equip(sets.avatar)
		end
	end
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

function pet_status_change(new,old)
	if new == "Engaged dead" then
		equip(sets.idle) --if the avatar despawns we equip the idle (no avatar) set
	end
end

-------------------------------------------
--       Buff/Debuff Notifications       --
-------------------------------------------

windower.register_event('gain buff', function(buff)
	if (buff == 270 or buff == 271 or buff == 272 or buff == 273) and AlertSounds == 'On' then --Aftermath
		windower.play_sound(windower.addon_path..'data/sounds/AftermathOn.wav')
		AMTimer = pre_AMTimer
		mythicNum = pre_mythicNum
		primeNum = pre_primeNum
	elseif (buff == 2 or buff == 19) then
		if buffactive['Stoneskin'] and not buffactive['charm'] then --If we get slept, remove stoneskin if its up
			send_command('cancel 37')
		end
		equip(sets.ohshit)
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
		Notifications = '«« 3000 TP »»'
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/3000TP.wav')
		end
		hud_noti_shdw:text('«« 3000 TP »»')
		hud_noti:text('«« 3000 TP »»')
		hud_noti:color(255,255,50)
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
		if player.equipment.main == 'Claustrum' then
			relicAMUpdate(player_tp)
		elseif player.equipment.main == 'Hvergelmir' then
			empyreanAMUpdate(player_tp)
		elseif player.equipment.main == "Nirvana" then
			mythicAMUpdate(player_tp)
		elseif player.equipment.main == 'Opashoro' then
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
	if player.equipment.main == 'Opashoro' then
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
			if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain then
				CurrentEquip = EquipMain
				currentAfterMath = 'None'
				hud_weapons_shdw:text(formatWeapons(EquipMain))
				hud_weapons:text(formatWeapons(EquipMain))
			end
		end
	elseif player.equipment.main == 'Claustrum' then
			if buffactive['Aftermath'] then
				if currentAfterMath ~= 'RelicAM' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'RelicAM'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM: (DT -20%/Refresh +15) '..am_time))
					hud_weapons:text(formatWeapons('AM: (DT -20%/Refresh +15) '..am_time))
				end
			else
				if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain then
					CurrentEquip = EquipMain
					currentAfterMath = 'None'
					hud_weapons_shdw:text(formatWeapons(EquipMain))
					hud_weapons:text(formatWeapons(EquipMain))
				end
			end
	elseif player.equipment.main == 'Hvergelmir' then
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
			if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain then
				CurrentEquip = EquipMain
				currentAfterMath = 'None'
				hud_weapons_shdw:text(formatWeapons(EquipMain))
				hud_weapons:text(formatWeapons(EquipMain))
			end
		end
	elseif player.equipment.main == 'Nirvana' then
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
				hud_weapons_shdw:text(formatWeapons('AM2: (Attack +'..mythicNum..') '..am_time))
				hud_weapons:text(formatWeapons('AM2: (Attack +'..mythicNum..') '..am_time))
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
			if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain then
				CurrentEquip = EquipMain
				currentAfterMath = 'None'
				hud_weapons_shdw:text(formatWeapons(EquipMain))
				hud_weapons:text(formatWeapons(EquipMain))
			end
		end
	elseif player.equipment.main == 'Khatvanga' then
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
			if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain then
				CurrentEquip = EquipMain
				currentAfterMath = 'None'
				hud_weapons_shdw:text(formatWeapons(EquipMain))
				hud_weapons:text(formatWeapons(EquipMain))
			end
		end
	elseif currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain then
		CurrentEquip = EquipMain
		currentAfterMath = 'None'
		hud_weapons_shdw:text(formatWeapons(EquipMain))
		hud_weapons:text(formatWeapons(EquipMain))
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

	--Pet checks
	if pet.isvalid == true and PetPresent == false then --we have an avatar out when we did not have one out already (ie summoning)
		PetPresent = true
		if pet.name == "Ifrit" then
			send_command('input /macro set '..IfritPage..'')
		elseif pet.name == "Titan" then
			send_command('input /macro set '..TitanPage..'')
		elseif pet.name == "Leviathan" then
			send_command('input /macro set '..LeviathanPage..'')
		elseif pet.name == "Garuda" then
			send_command('input /macro set '..GarudaPage..'')
		elseif pet.name == "Shiva" then
			send_command('input /macro set '..ShivaPage..'')
		elseif pet.name == "Ramuh" then
			send_command('input /macro set '..RamuhPage..'')
		elseif pet.name == "Carbuncle" then
			send_command('input /macro set '..CarbunclePage..'')
		elseif pet.name == "Fenrir" then
			send_command('input /macro set '..FenrirPage..'')
		elseif pet.name == "Cait Sith" then
			send_command('input /macro set '..CaitSithPage..'')
		elseif pet.name == "Siren" then
			send_command('input /macro set '..SirenPage..'')
		elseif pet.name == "Diabolos" then
			send_command('input /macro set '..DiabolosPage..'')
		end

		local c = color.None
		if pet.name == "Carbuncle" or pet.name == "Cait Sith" or pet.name == "Alexander" or pet.name == "LightSpirit" then
			c = color.Light
		elseif pet.name == "Ifrit" or pet.name == "FireSpirit" then
			c = color.Fire
		elseif pet.name == "Shiva" or pet.name == "IceSpirit" then
			c = color.Ice
		elseif pet.name == "Garuda" or pet.name == "Siren" or pet.name == "AirSpirit" then
			c = color.Air
		elseif pet.name == "Titan" or pet.name == "EarthSpirit" then
			c = color.Earth
		elseif pet.name == "Ramuh" or pet.name == "ThunderSpirit" then
			c = color.Thunder
		elseif pet.name == "Leviathan" or pet.name == "WaterSpirit"  then
			c = color.Water
		elseif pet.name == "Fenrir" or pet.name == "Diabolos" or pet.name == "Atomos" or pet.name == "Odin" or pet.name == "DarkSpirit" then
			c = color.Dark
		end
		hud_avatar:color(c.r,c.g,c.b)

	elseif pet.isvalid == false and PetPresent == true then --we do not have an avatar out when we previously did (ie releasing or they die)
		PetPresent = false
		send_command('input /macro set '..HomePage..'')
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

	-- Avatar HP checks
	if pet.isvalid == true then
		local pet = windower.ffxi.get_mob_by_target('pet')
		if pet and (PetHPP ~= pet.hpp or PetStatus ~= pet.status) then
			PetHPP = pet.hpp
			PetStatus = pet.status
			local petHPMeter = ""
			local spaces = math.floor(72 * (pet.hpp / 100)) --HUD is 72 spaces wide
			while string.len(petHPMeter) < spaces and string.len(petHPMeter) < 72 do
				petHPMeter = petHPMeter..' '
			end
			petHPMeter = petHPMeter..'\n'..petHPMeter..'\n'..petHPMeter
			local c
			if pet.hpp <= 25 then
				c = color.lo
			elseif pet.hpp <= 50 then
				c = color.md
			else
				c = color.hi
			end
			hud_bg_color:text(petHPMeter)
			hud_bg_color:bg_color(c.r,c.g,c.b)
			hud_bg_color:bg_alpha(100)
			hud_avatar_shdw:text(pet.name..' - '..pet.hpp..'% ('..res.statuses[pet.status].en..')')
			hud_avatar:text(pet.name..' - '..pet.hpp..'% ('..res.statuses[pet.status].en..')')
		end
	elseif PetHPP ~= -1 then
		PetHPP = -1 --We use -1 to avoid an issue with Avatar being killed not triggering this
		hud_bg_color:bg_alpha(0)
		hud_avatar_shdw:text('No Avatar')
		hud_avatar:text('No Avatar')
		hud_avatar:color(255,50,50)
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
		else
			EquipMain = player.equipment.main
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
		if GreetingDelay > 0 then
			GreetingDelay = GreetingDelay - 1
		elseif GreetingDelay == 0 then
			send_command('gs c ClearNotifications')
			GreetingDelay = -1
		end

		--Recast color updates

		if AstralFlow.recast then
			if buffactive['Astral Flow'] then
				textColor('Astral Flow','active')
				AstralFlow.flashed = false
			elseif AstralFlow.recast > 0 then
				textColor('Astral Flow','cooldown')
				AstralFlow.flashed = false
			else
				textColor('Astral Flow','ready')
				if not AstralFlow.flashed then
					flash('Astral Flow')
				end
				AstralFlow.flashed = true
			end
		else
			textColor('Astral Flow','notfound')
		end

		if AstralConduit.recast then
			if buffactive['Astral Conduit'] then
				textColor('Astral Conduit','active')
				AstralConduit.flashed = false
			elseif AstralConduit.recast > 0 then
				textColor('Astral Conduit','cooldown')
				AstralConduit.flashed = false
			else
				textColor('Astral Conduit','ready')
				if not AstralConduit.flashed then
					flash('Astral Conduit')
				end
				AstralConduit.flashed = true
			end
		else
			textColor('Astral Conduit','notfound')
		end

		if Apogee.recast then
			if buffactive['Apogee'] then
				textColor('Apogee','active')
				Apogee.flashed = false
			elseif Apogee.recast > 0 then
				textColor('Apogee','cooldown')
				Apogee.flashed = false
			else
				textColor('Apogee','ready')
				if not Apogee.flashed then
					flash('Apogee')
				end
				Apogee.flashed = true
			end
		else
			textColor('Apogee','notfound')
		end

		if AvatarsFavor.recast then
			if buffactive['Avatar\'s Favor'] then
				textColor('Avatar\'s Favor','active')
				AvatarsFavor.flashed = false
			elseif AvatarsFavor.recast > 0 then
				textColor('Avatar\'s Favor','cooldown')
				AvatarsFavor.flashed = false
			else
				textColor('Avatar\'s Favor','ready')
				if not AvatarsFavor.flashed then
					flash('Avatar\'s Favor')
				end
				AvatarsFavor.flashed = true
			end
		else
			textColor('Avatar\'s Favor','notfound')
		end

		if BloodPactRage.recast then
			if BloodPactRage.recast > 0 then
				textColor('Blood Pact: Rage','cooldown')
				BloodPactRage.flashed = false
			else
				textColor('Blood Pact: Rage','ready')
				if not BloodPactRage.flashed then
					flash('Blood Pact: Rage')
				end
				BloodPactRage.flashed = true
			end
		else
			textColor('Blood Pact: Rage','notfound')
		end

		if BloodPactWard.recast then
			if BloodPactWard.recast > 0 then
				textColor('Blood Pact: Ward','cooldown')
				BloodPactWard.flashed = false
			else
				textColor('Blood Pact: Ward','ready')
				if not BloodPactWard.flashed then
					flash('Blood Pact: Ward')
				end
				BloodPactWard.flashed = true
			end
		else
			textColor('Blood Pact: Ward','notfound')
		end

		if Convert.recast then
			if Convert.recast > 0 then
				textColor('Convert','cooldown')
				Convert.flashed = false
			else
				textColor('Convert','ready')
				if not Convert.flashed then
					flash('Convert')
				end
				Convert.flashed = true
			end
		else
			textColor('Convert','notfound')
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

		if ElementalSiphon.recast then
			if ElementalSiphon.recast > 0 then
				textColor('Elemental Siphon','cooldown')
				ElementalSiphon.flashed = false
			else
				textColor('Elemental Siphon','ready')
				if not ElementalSiphon.flashed then
					flash('Elemental Siphon')
				end
				ElementalSiphon.flashed = true
			end
		else
			textColor('Elemental Siphon','notfound')
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

		if ManaCede.recast then
			if ManaCede.recast > 0 then
				textColor('Mana Cede','cooldown')
				ManaCede.flashed = false
			else
				textColor('Mana Cede','ready')
				if not ManaCede.flashed then
					flash('Mana Cede')
				end
				ManaCede.flashed = true
			end
		else
			textColor('Mana Cede','notfound')
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
		elseif ((act.category == 4 and act.targets[1].actions[1].message == 252) or (act.category == 13 and act.targets[1].actions[1].message == 379)) and act.actor_id == player.id then
			--Magic:
			if act.category == 4 then
				hud_noti_shdw:text('Magic Burst! '..spells[act.param].english..': '..addCommas(act.targets[1].actions[1].param))
				hud_noti:text('Magic Burst! '..spells[act.param].english..': '..addCommas(act.targets[1].actions[1].param))
				hud_noti:color(0,255,255)
			--Blood Pacts:
			elseif act.category == 13 then
				hud_noti_shdw:text('Magic Burst! '..jobabilities[act.param].english..': '..addCommas(act.targets[1].actions[1].param))
				hud_noti:text('Magic Burst! '..jobabilities[act.param].english..': '..addCommas(act.targets[1].actions[1].param))
				hud_noti:color(0,255,255)
			end
			NotiCountdown = -1
		--Blood Pact: Rages:
	--elseif act.category == 13 and act.actor_id == pet.id and not (BPWardBuff:contains(jobabilities[act.param].english) or (BPWardDebuff:contains(jobabilities[act.param].english))) then
	elseif act.category == 13 then
		--Blood Pact misses:
			if act.targets[1].actions[1].message == 324 then
				hud_noti_shdw:text('«« '..jobabilities[act.param].english..' Missed »»')
				hud_noti:text('«« '..jobabilities[act.param].english..' Missed »»')
				hud_noti:color(0,255,255)
			--Blood pact gets blinked:
			elseif act.targets[1].actions[1].message == 31 then
				hud_noti_shdw:text('«« '..jobabilities[act.param].english..' Blinked »»')
				hud_noti:text('«« '..jobabilities[act.param].english..' Blinked »»')
				hud_noti:color(0,255,255)
			--Blood Pact lands and creates a Skillchain:
			elseif act.targets[1].actions[1].has_add_effect then
				hud_noti_shdw:text(jobabilities[act.param].english..': '..addCommas(act.targets[1].actions[1].param)..' ('..sc[act.targets[1].actions[1].add_effect_animation]..': '..addCommas(act.targets[1].actions[1].add_effect_param)..')')
				hud_noti:text(jobabilities[act.param].english..': '..addCommas(act.targets[1].actions[1].param)..' ('..sc[act.targets[1].actions[1].add_effect_animation]..': '..addCommas(act.targets[1].actions[1].add_effect_param)..')')
				hud_noti:color(0,255,255)
			--Blood Pact lands but no Skillchain:
			elseif act.targets[1].actions[1].message == 317 then
				hud_noti_shdw:text(jobabilities[act.param].english..': '..addCommas(act.targets[1].actions[1].param))
				hud_noti:text(jobabilities[act.param].english..': '..addCommas(act.targets[1].actions[1].param))
				hud_noti:color(0,255,255)
			end
			NotiCountdown = -1
		end
	end
end)

-------------------------------------------
--             FILE UNLOAD               --
-------------------------------------------

function file_unload()

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
	hud_avatar_shdw:destroy()
	hud_noti_shdw:destroy()
	hud_debuffs_shdw:destroy()
	hud_abil01_shdw:destroy()
	hud_abil02_shdw:destroy()
	hud_abil03_shdw:destroy()
	hud_abil04_shdw:destroy()
	hud_abil05_shdw:destroy()
	hud_abil06_shdw:destroy()
	hud_weapons:destroy()
	hud_avatar:destroy()
	hud_noti:destroy()
	hud_debuffs:destroy()
	hud_abil01:destroy()
	hud_abil02:destroy()
	hud_abil03:destroy()
	hud_abil04:destroy()
	hud_abil05:destroy()
	hud_abil06:destroy()
	send_command('unalias hud')
	send_command('unalias dt')
	send_command('unalias siphon')
	send_command('unbind '..DTBind)

end
