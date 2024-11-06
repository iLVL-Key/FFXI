-------------------------------------------
-- Keys Gearswap lua file for Geomancer  --
-------------------------------------------
--[[

Updates to this file and other GearSwap files and addons can be found at
https://github.com/iLVL-Key/FFXI

Place both this file and the sounds folder inside the GearSwap data folder
ex:	/addons/GearSwap/data/sounds/
	/addons/GearSwap/data/GEO.lua

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
sub = {} sub.WHM = {} sub.RDM = {} sub.BLM = {} sub.SCH = {} sub.OTH = {} color = {} color.hi = {} color.md = {} color.lo = {} color.Light = {} color.Fire = {} color.Ice = {} color.Air = {} color.Earth = {} color.Thunder = {} color.Water = {} color.Dark = {} color.abil = {} color.abil.ready = {} color.abil.active = {} color.abil.cooldown = {} color.abil.flash = {} color.abil.notfound = {}
--^IGNORE THESE^--

-------------------------------------------
--                OPTIONS                --
-------------------------------------------

Book			=	'5'		--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
SubWHMPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing WHM.
SubRDMPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing RDM.
SubBLMPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing BLM.
SubSCHPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing SCH.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
BolTimer		=	'On'	--[On/Off]		Displays a timer for Bolster in echo.
WCTimer			=	'On'	--[On/Off]		Displays a timer for Widened Compass in echo.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions
							--				(Town limits this to town gear only).
AlertSounds		=	'On'	--[On/Off]		Plays a sound on alerts. 
UseEcho			=	'R'		--[E/R/Off]		Automatically uses an (E)cho Drop or (R)emedy instead of spell when you are silenced.
AutoFullCircle	=	'On'	--[On/Off]		Automatically uses Full Circle when you cast a Geo- spell with a Luopan already out.
AutoEntrust		=	'On'	--[On/Off]		Automatically uses Entrust when you cast an Indi- spell on a party member. The first cast onto
							--				a party member will engage the AutoEntrust system, the second cast will execute as intended.
AutoSubCharge	=	'On'	--[On/Off]		Automatically attempts to keep Sublimation charging.

-- Heads Up Display --
HUDposX			=	100		--	X position for the HUD. 0 is left of the window, increasing this number will move it to the right.
HUDposY			=	100		--	Y position for the HUD. 0 is top of the window, increasing this number will move it downward.
FontSize		=	10		--	Adjust the font size. Changing this may require you to adjust the Spacers below as well.
LineSpacer		=	16		--	Space in pixels between each Line of the HUD.
ColumnSpacer	=	90.5	--	Space in pixels between each Column of the HUD.

--  General Notifications  --
ReraiseReminder		=	'On'	--[On/Off]	Displays an occasional reminder if Reraise is not up.
Noti3000TP			=	'On'	--[On/Off]	Displays a notification when you have 3000 TP.
NotiTrade			=	'On'	--[On/Off]	Displays a notification when someone trades you.
NotiInvite			=	'On'	--[On/Off]	Displays a notification when someone invites to a party/alliance.
NotiSneak			=	'On'	--[On/Off]	Displays a notification when Sneak is about to wear off.
NotiInvis			=	'On'	--[On/Off]	Displays a notification when Invisible is about to wear off.
NotiReraise			=	'On'	--[On/Off]	Displays a notification when reraise wears off.
NotiFood			=	'On'	--[On/Off]	Displays a notification when food wears off.
NotiLowMP			=	'On'	--[On/Off]	Displays a notification when MP is under 20%.
NotiLowHP			=	'On'	--[On/Off]	Displays a notification when HP is low.
NotiDamage			=	'Off'	--[On/Off]	Displays your Weapon Skill, Skillchain, and Magic Burst damage.
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
--		Bolster, Widened Compass, Blaze of Glory, Collimated Fervor, Concentric Pulse, Convert, Dark Arts, Dematerialize, Divine Seal, Ecliptic Attrition, Elemental Seal, Entrust, Full Circle, Lasting Emanation, Life Cycle, Light Arts, Mending Halation, Radial Arcana, Sublimation, Theurgic Focus
-- The "_sh" column allows you to change the name displayed if you would like, leave blank otherwise
-- NOTE: Names will automatically be truncated to 10 characters to fit correctly.

--GEO/WHM
sub.WHM.Abil01 = "Radial Arcana"		sub.WHM.Abil01_sh = ""
sub.WHM.Abil02 = "Blaze of Glory"		sub.WHM.Abil02_sh = "BlazeGlory"
sub.WHM.Abil03 = "Dematerialize"		sub.WHM.Abil03_sh = "Dematrialz"
sub.WHM.Abil04 = "Ecliptic Attrition"	sub.WHM.Abil04_sh = "Ecliptic"
sub.WHM.Abil05 = "Life Cycle"			sub.WHM.Abil05_sh = ""
sub.WHM.Abil06 = "Divine Seal"			sub.WHM.Abil06_sh = "Divn Seal"
--GEO/RDM
sub.RDM.Abil01 = "Radial Arcana"		sub.RDM.Abil01_sh = ""
sub.RDM.Abil02 = "Blaze of Glory"		sub.RDM.Abil02_sh = "BlazeGlory"
sub.RDM.Abil03 = "Dematerialize"		sub.RDM.Abil03_sh = "Dematrialz"
sub.RDM.Abil04 = "Ecliptic Attrition"	sub.RDM.Abil04_sh = "Ecliptic"
sub.RDM.Abil05 = "Life Cycle"			sub.RDM.Abil05_sh = ""
sub.RDM.Abil06 = "Convert"				sub.RDM.Abil06_sh = ""
--GEO/BLM
sub.BLM.Abil01 = "Radial Arcana"		sub.BLM.Abil01_sh = ""
sub.BLM.Abil02 = "Blaze of Glory"		sub.BLM.Abil02_sh = "BlazeGlory"
sub.BLM.Abil03 = "Dematerialize"		sub.BLM.Abil03_sh = "Dematrialz"
sub.BLM.Abil04 = "Ecliptic Attrition"	sub.BLM.Abil04_sh = "Ecliptic"
sub.BLM.Abil05 = "Life Cycle"			sub.BLM.Abil05_sh = ""
sub.BLM.Abil06 = "Elemental Seal"		sub.BLM.Abil06_sh = "Elem Seal"
--GEO/SCH
sub.SCH.Abil01 = "Radial Arcana"		sub.SCH.Abil01_sh = ""
sub.SCH.Abil02 = "Blaze of Glory"		sub.SCH.Abil02_sh = "BlazeGlory"
sub.SCH.Abil03 = "Dematerialize"		sub.SCH.Abil03_sh = "Dematrialz"
sub.SCH.Abil04 = "Ecliptic Attrition"	sub.SCH.Abil04_sh = "Ecliptic"
sub.SCH.Abil05 = "Life Cycle"			sub.SCH.Abil05_sh = ""
sub.SCH.Abil06 = "Sublimation"			sub.SCH.Abil06_sh = "Sublmation"
--GEO/other
sub.OTH.Abil01 = "Radial Arcana"		sub.OTH.Abil01_sh = ""
sub.OTH.Abil02 = "Mending Halation"		sub.OTH.Abil02_sh = "Mending"
sub.OTH.Abil03 = "Blaze of Glory"		sub.OTH.Abil03_sh = "BlazeGlory"
sub.OTH.Abil04 = "Dematerialize"		sub.OTH.Abil04_sh = "Dematrialz"
sub.OTH.Abil05 = "Ecliptic Attrition"	sub.OTH.Abil05_sh = "Ecliptic"
sub.OTH.Abil06 = "Life Cycle"			sub.OTH.Abil06_sh = ""

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

--HUD RECAST

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
-- Used when you do NOT have a Luopan bubble out.
sets.idle = {
	main="Idris",
	sub="Genmei Shield",
	range="Dunna",
	head="Volte Beret",
	body="Azimuth Coat +3",
	hands="Bagua Mitaines +3",
	legs="Volte Brais",
	feet="Geo. Sandals +3",
	neck="Loricate Torque +1",
	waist="Carrier's Sash",
	left_ear="Eabani Earring",
	right_ear="Azimuth Earring +1",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
}

-- Luopan (Pet Damage Taken-, Pet Regen)
-- Used when you DO have a Luopan bubble out.
-- Combines with Idle set, only necessary to set the slots with specific desired stats
sets.luopan = set_combine(sets.idle, {
	main="Idris",
	sub="Genmei Shield",
	range="Dunna",
	head="Azimuth Hood +3",
	hands="Geo. Mitaines +3",
	legs="Volte Brais",
	feet="Bagua Sandals +3",
	waist="Isa Belt",
	back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}},
})

-- DT Override (Damage Taken-, Magic Evasion)
-- Will override all other gear sets but still inherit unused slots from them
sets.dtoverride = {
	head="Azimuth Hood +3",
	body="Nyame Mail",
	hands="Azimuth Gloves +3",
	legs="Nyame Flanchard",
	right_ring="Defending Ring",
}

-- Oh Shit
-- Full DT- and everything you've got with Absorbs or Annuls Damage
sets.ohshit = {
	head="Azimuth Hood +3",
	body="Nyame Mail",
	hands="Azimuth Gloves +3",
	legs="Nyame Flanchard",
	neck="Warder's Charm +1",
	left_ring="Shadow Ring",
	right_ring="Defending Ring",
	back="Shadow Mantle"
}

-- Rest
sets.rest = {
	waist="Austerity Belt",
}

-- DPS (Accuracy, Double/Triple Attack, DEX, Store TP, Attack)
sets.dps = {
	head="Azimuth Hood +3",
	body="Azimuth Coat +3",
	hands="Azimuth Gloves +3",
	legs="Azimuth Tights +3",
	feet="Azimuth Gaiters +3",
	neck="Ziel Charm",
	waist="Windbuffet Belt +1",
	left_ear="Mache Earring +1",
	right_ear="Cessance Earring",
	left_ring="Hetairoi Ring",
	right_ring="Petrov Ring",
	back="Aurist's Cape +1",
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
	back="Aurist's Cape +1",
}

-- Exudation (combines with Weapon Skill set above)
sets["Exudation"] = set_combine(sets.ws, {
	neck="Fotia Gorget",
	waist="Fotia Belt",
})

-- Black Halo (combines with Weapon Skill set above)
sets["Black Halo"] = set_combine(sets.ws, {

})

-- Hexa Strike (combines with Weapon Skill set above)
sets["Hexa Strike"] = set_combine(sets.ws, {
	neck="Fotia Gorget",
	waist="Fotia Belt",
})

-- Cataclysm (combines with Weapon Skill set above)
sets["Cataclysm"] = set_combine(sets.ws, {
	head="Pixie Hairpin +1",
	body="Azimuth Coat +3",
	hands="Azimuth Gloves +3",
	legs="Azimuth Tights +3",
	feet="Azimuth Gaiters +3",
	neck="Baetyl Pendant",
	waist="Acuity Belt +1",
	left_ear="Malignance Earring",
	right_ear="Regal Earring",
	left_ring="Archon Ring",
	right_ring="Metamor. Ring +1",
	back="Aurist's Cape +1",
})

-- Fast Cast (cap is 80%)
sets.fastcast = {
	sub="Chanter's Shield", --3%
	head="Amalric Coif +1", --11%
	body="Agwu's Robe", --8%
	hands="Agwu's Gages", --6%
	legs="Geomancy Pants +3", --15%
	feet="Amalric Nails +1", --6%
	neck="Baetyl Pendant", --4%
	waist="Embla Sash", --5%
	left_ear="Malignance Earring", --4%
	right_ear="Loquac. Earring", --2%
	left_ring="Prolix Ring", --2%
	right_ring="Kishar Ring", --4%
	back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --10%
}

-- Geomancy (Geomancy+, Geomancy Skill, Handbell Skill, Indicolure duration+, Lupoan duration+)
-- NOTE: You only need a combined skill of 900 between Geomancy skill and Handbell skill to cap your potency, anything over 900 is wasted)
sets.geomancy = {
	main="Idris",
	sub="Genmei Shield",
	range="Dunna",
	head="Azimuth Hood +3",
	body="Bagua Tunic",
	hands="Geo. Mitaines +3",
	legs="Bagua Pants +3",
	feet="Azimuth Gaiters +3",
	neck="Bagua Charm +2",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back="Lifestream Cape",
}

-- Elemental Spells (Magic Attack Bonus, Magic Damage, INT, Magic Accuracy)
sets.elemental = {
	main="Bunzi's Rod",
	sub="Ammurapi Shield",
	head="Agwu's Cap",
	body="Azimuth Coat +3",
	hands="Agwu's Gages",
	legs="Azimuth Tights +3",
	feet="Agwu's Pigaches",
	neck="Sibyl Scarf",
	waist="Orpheus's Sash",
	left_ear="Malignance Earring",
	right_ear="Regal Earring",
	left_ring="Shiva Ring +1",
	right_ring="Metamor. Ring +1",
	back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
}

-- Magic Accuracy (Magic Accuracy)
sets.magicaccuracy = {
	main="Bunzi's Rod",
	sub="Ammurapi Shield",
	head="Azimuth Hood +3",
	body="Azimuth Coat +3",
	hands="Azimuth Gloves +3",
	legs="Azimuth Tights +3",
	feet="Azimuth Gaiters +3",
	neck="Bagua Charm +2",
	waist="Acuity Belt +1",
	left_ear="Malignance Earring",
	right_ear="Azimuth Earring +1",
	left_ring="Stikini Ring +1",
	right_ring="Metamor. Ring +1",
	back="Aurist's Cape +1",
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
	right_ear="Regal Earring",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back="Solemnity Cape", --7
}

-- Aspir/Drain (Aspir/Drain, Dark Magic Skill)
-- Combines with Magic Accuracy set, only necessary to set the slots with specific desired stats
sets.aspirdrain = set_combine(sets.magicaccuracy, {
	head="Bagua Galero +3",
	feet="Agwu's Pigaches",
	neck="Erra Pendant",
	waist="Fucho-no-obi",
	right_ring="Evanescence Ring",
})

-- Enfeeble (Enfeebling Magic Skill)
-- Combines with Magic Accuracy set, only necessary to set the slots with specific desired stats
sets.enfeeble = set_combine(sets.magicaccuracy, {
	main="Idris",
	sub="Ammurapi Shield",
	right_ring="Kishar Ring",
})

-- Refresh (Refresh augmenting gear, not Refresh+)
sets.refresh = {
	head="Amalric Coif +1",
	back="Grapevine Cape",
	waist="Gishdubar Sash",
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

-- Impact (Twilight/Crepuscular Cloak)
sets.impact = {
	head=empty,
	body="Twilight Cloak",
}

-- Holy Water (Holy Water+)
sets.hwater = {
	neck="Nicander's Necklace",
	ring1="Blenmot's Ring +1",
	ring2="Blenmot's Ring +1",
}

-- Bolster (Enhances Bolster gear)
sets.bolster = {
	body="Bagua Tunic",
}

-- Full Circle (Enhances Curative Recantation gear)
sets.fullcircle = {
	head="Azimuth Hood +3",
	hands="Bagua Mitaines +3",
}

-- Radial Arcana (Enhances Radial Arcana gear)
sets.radialarcana = {
	feet="Bagua Sandals +3",
}

-- Mending Halation (Enhances Mending Halation gear)
sets.mendinghalation = {
	legs="Bagua Pants +3",
}

-- Collimated Fervor (Enhances Privemal Zeal gear)
sets.collimatedfervor = {
	head="Bagua Galero +3",
}

-- Life Cycle (Enhances Life Cycle gear)
sets.lifecycle = {
	body="Geomancy Tunic +3",
	back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}},
}

-- Default Town Gear (Put all your fancy-pants gear in here you want to showboat around town. Does not lockstyle this gear, only equips)
sets.town = set_combine(sets.idle, {
	main="Idris",
	sub="Ammurapi Shield",
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




FileVersion = '14.4'

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
IndiSpell = 'None'
GeoSpell = 'None'
EntrustSpell = 'None'
UseEntrust = false
NotiLowMPToggle = 'Off' --start with the toggle off for the Low MP Notification so that it can trigger
DTOverride = "Off" --Start with the Damage Taken Override off
RRRCountdown = RRReminderTimer
HUDposYLine1 = HUDposY
Heartbeat = 0 --set to 0 just to start the Heartbeat running
GreetingDelay = 6 --delay to display greeting and file version info
Zoning = false --flips automatically to hide the HUD while zoning
InCS = false --flips automatically to hide the HUD while in a cs
if pet.isvalid then
	LuopanActive = true
else
	LuopanActive = false
end
LowHP = false
Alive = true --makes it easier to Do Things or Not Do Things based on if we die.
announceAlive = false --simple flip when we raise to make sure the AliveDelay command and notification text is only done once
DangerCountdown = 0
NotiCountdown = -1 --we set the countdown below 0 to stop the countdown from hitting 0 and triggering the ClearNotifications command
PetHPP = 0
LuopanDelay = false --used to create a short delay between casting a luopan and checking if it still exists, pet.isvalid does a weird on/off/on thing when a luopan is cast which messes with checking if certain buffs are still active on the lupoan
EntrustCountdown = 0
EntrustTarget = nil
party_count = party and party.count or 1

-- Sets the inital subjob
local subjob = 'OTH'
if player.sub_job == 'WHM' then
	subjob = 'WHM'
elseif player.sub_job == 'RDM' then
	subjob = 'RDM'
elseif player.sub_job == 'BLM' then
	subjob = 'BLM'
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
if SubWHMPage ~= "Off" and player.sub_job == 'WHM' then
	send_command('wait 2;input /macro set '..SubWHMPage..'')
elseif SubRDMPage ~= "Off" and player.sub_job == 'RDM' then
	send_command('wait 2;input /macro set '..SubRDMPage..'')
elseif SubBLMPage ~= "Off" and player.sub_job == 'BLM' then
	send_command('wait 2;input /macro set '..SubBLMPage..'')
elseif SubSCHPage ~= "Off" and player.sub_job == 'SCH' then
	send_command('wait 2;input /macro set '..SubSCHPage..'')
else
	send_command('wait 2;input /macro set 1')
end

Bolster = {} WidenedCompass = {} BlazeofGlory = {} CollimatedFervor = {} ConcentricPulse = {} Convert = {} DarkArts = {} Dematerialize = {} DivineSeal = {} EclipticAttrition = {} ElementalSeal = {} Entrust = {} FullCircle = {} LastingEmanation = {} LifeCycle = {} LightArts = {} MendingHalation = {} RadialArcana = {} Sublimation = {} TheurgicFocus = {}

--Start true so the HUD recasts don't flash on load
Bolster.flashed = true
WidenedCompass.flashed = true
BlazeofGlory.flashed = true
CollimatedFervor.flashed = true
ConcentricPulse.flashed = true
Convert.flashed = true
DarkArts.flashed = true
Dematerialize.flashed = true
DivineSeal.flashed = true
EclipticAttrition.flashed = true
ElementalSeal.flashed = true
Entrust.flashed = true
FullCircle.flashed = true
LastingEmanation.flashed = true
LifeCycle.flashed = true
LightArts.flashed = true
MendingHalation.flashed = true
RadialArcana.flashed = true
Sublimation.flashed = true
TheurgicFocus.flashed = true

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

-- Create the HUD BG Color text object (Luopan HP Bar)
local hud_bg_color = texts.new()
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

-- Create the HUD Notifications Text Shadow text object
local hud_noti_shdw = texts.new('Keys GEO Gearswap file v'..FileVersion)
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

-- Create the HUD Indi Label Text Shadow text object
local hud_indi_label_shdw = texts.new('          Self')
hud_indi_label_shdw:color(0,0,0)
hud_indi_label_shdw:font("Consolas")
hud_indi_label_shdw:size(FontSize)
hud_indi_label_shdw:bg_alpha(0)
hud_indi_label_shdw:pos(HUDposXColumn1+1.5,HUDposYLine2+0.5)
hud_indi_label_shdw:draggable(false)
hud_indi_label_shdw:bold(true)

-- Create the HUD Geo Label Text Shadow text object
local hud_geo_label_shdw = texts.new('         Luopan')
hud_geo_label_shdw:color(0,0,0)
hud_geo_label_shdw:font("Consolas")
hud_geo_label_shdw:size(FontSize)
hud_geo_label_shdw:bg_alpha(0)
hud_geo_label_shdw:pos(HUDposXColumn3+1.5,HUDposYLine2+0.5)
hud_geo_label_shdw:draggable(false)
hud_geo_label_shdw:bold(true)

-- Create the HUD Entrust Label Text Shadow text object
local hud_entrust_label_shdw = texts.new('        Entrust')
hud_entrust_label_shdw:color(0,0,0)
hud_entrust_label_shdw:font("Consolas")
hud_entrust_label_shdw:size(FontSize)
hud_entrust_label_shdw:bg_alpha(0)
hud_entrust_label_shdw:pos(HUDposXColumn5+1.5,HUDposYLine2+0.5)
hud_entrust_label_shdw:draggable(false)
hud_entrust_label_shdw:bold(true)

-- Create the HUD Indi Spell Text Shadow text object
local hud_indi_spell_shdw = texts.new('          None')
hud_indi_spell_shdw:color(0,0,0)
hud_indi_spell_shdw:font("Consolas")
hud_indi_spell_shdw:size(FontSize)
hud_indi_spell_shdw:bg_alpha(0)
hud_indi_spell_shdw:pos(HUDposXColumn1+1.5,HUDposYLine3+0.5)
hud_indi_spell_shdw:draggable(false)
hud_indi_spell_shdw:bold(true)

-- Create the HUD Geo Spell Text Shadow text object
local hud_geo_spell_shdw = texts.new('          None')
hud_geo_spell_shdw:color(0,0,0)
hud_geo_spell_shdw:font("Consolas")
hud_geo_spell_shdw:size(FontSize)
hud_geo_spell_shdw:bg_alpha(0)
hud_geo_spell_shdw:pos(HUDposXColumn3+1.5,HUDposYLine3+0.5)
hud_geo_spell_shdw:draggable(false)
hud_geo_spell_shdw:bold(true)

-- Create the HUD Entrust Text Shadow Spell text object
local hud_entrust_spell_shdw = texts.new('          None')
hud_entrust_spell_shdw:color(0,0,0)
hud_entrust_spell_shdw:font("Consolas")
hud_entrust_spell_shdw:size(FontSize)
hud_entrust_spell_shdw:bg_alpha(0)
hud_entrust_spell_shdw:pos(HUDposXColumn5+1.5,HUDposYLine3+0.5)
hud_entrust_spell_shdw:draggable(false)
hud_entrust_spell_shdw:bold(true)

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

-- Create the HUD Notifications text object
local hud_noti = texts.new('Keys GEO Gearswap file v'..FileVersion)
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

-- Create the HUD Indi Label text object
local hud_indi_label = texts.new('          Self')
hud_indi_label:font("Consolas")
hud_indi_label:size(FontSize)
hud_indi_label:bg_alpha(0)
hud_indi_label:pos(HUDposXColumn1,HUDposYLine2-1)
hud_indi_label:draggable(false)
hud_indi_label:bold(true)

-- Create the HUD Geo Label text object
local hud_geo_label = texts.new('         Luopan')
hud_geo_label:font("Consolas")
hud_geo_label:size(FontSize)
hud_geo_label:bg_alpha(0)
hud_geo_label:pos(HUDposXColumn3,HUDposYLine2-1)
hud_geo_label:draggable(false)
hud_geo_label:bold(true)

-- Create the HUD Entrust Label text object
local hud_entrust_label = texts.new('        Entrust')
hud_entrust_label:font("Consolas")
hud_entrust_label:size(FontSize)
hud_entrust_label:bg_alpha(0)
hud_entrust_label:pos(HUDposXColumn5,HUDposYLine2-1)
hud_entrust_label:draggable(false)
hud_entrust_label:bold(true)

-- Create the HUD Indi Spell text object
local hud_indi_spell = texts.new('          None')
hud_indi_spell:color(255,50,50)
hud_indi_spell:font("Consolas")
hud_indi_spell:size(FontSize)
hud_indi_spell:bg_alpha(0)
hud_indi_spell:pos(HUDposXColumn1,HUDposYLine3-1)
hud_indi_spell:draggable(false)
hud_indi_spell:bold(true)

-- Create the HUD Geo Spell text object
local hud_geo_spell = texts.new('          None')
hud_geo_spell:font("Consolas")
hud_geo_spell:size(FontSize)
hud_geo_spell:bg_alpha(0)
hud_geo_spell:pos(HUDposXColumn3,HUDposYLine3-1)
hud_geo_spell:draggable(false)
hud_geo_spell:bold(true)

-- Create the HUD Entrust Spell text object
local hud_entrust_spell = texts.new('          None')
hud_entrust_spell:font("Consolas")
hud_entrust_spell:size(FontSize)
hud_entrust_spell:bg_alpha(0)
hud_entrust_spell:pos(HUDposXColumn5,HUDposYLine3-1)
hud_entrust_spell:draggable(false)
hud_entrust_spell:bold(true)

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

if ShowHUD == 'On' then
	hud_bg_color:show()
	hud_bg:show()
	hud_noti_bg:show()
	hud_debuffs_bg:show()
	hud_abil01_bg:show()
	hud_abil02_bg:show()
	hud_abil03_bg:show()
	hud_abil04_bg:show()
	hud_abil05_bg:show()
	hud_abil06_bg:show()
	hud_noti_shdw:show()
	hud_debuffs_shdw:show()
	hud_indi_label_shdw:show()
	hud_geo_label_shdw:show()
	hud_entrust_label_shdw:show()
	hud_indi_spell_shdw:show()
	hud_geo_spell_shdw:show()
	hud_entrust_spell_shdw:show()
	hud_abil01_shdw:show()
	hud_abil02_shdw:show()
	hud_abil03_shdw:show()
	hud_abil04_shdw:show()
	hud_abil05_shdw:show()
	hud_abil06_shdw:show()
	hud_noti:show()
	hud_debuffs:show()
	hud_indi_label:show()
	hud_geo_label:show()
	hud_entrust_label:show()
	hud_indi_spell:show()
	hud_geo_spell:show()
	hud_entrust_spell:show()
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

send_command('alias hud gs c HUD') --creates the HUD alias
send_command('alias dt gs c DT') --creates the DT Override alias
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

	Bolster.recast = ability_recast[0] and math.floor(ability_recast[0]) or nil
	WidenedCompass.recast = ability_recast[254] and math.floor(ability_recast[254]) or 0
	BlazeofGlory.recast = ability_recast[247] and math.floor(ability_recast[247]) or nil
	CollimatedFervor.recast = ability_recast[245] and math.floor(ability_recast[245]) or nil
	ConcentricPulse.recast = ability_recast[250] and math.floor(ability_recast[250]) or nil
	Convert.recast = ability_recast[49] and math.floor(ability_recast[49]) or nil
	DarkArts.recast = ability_recast[232] and math.floor(ability_recast[232]) or nil
	Dematerialize.recast = ability_recast[248] and math.floor(ability_recast[248]) or nil
	DivineSeal.recast = ability_recast[26] and math.floor(ability_recast[26]) or nil
	EclipticAttrition.recast = ability_recast[244] and math.floor(ability_recast[244]) or nil
	ElementalSeal.recast = ability_recast[38] and math.floor(ability_recast[38]) or nil
	Entrust.recast = ability_recast[93] and math.floor(ability_recast[93]) or nil
	FullCircle.recast = ability_recast[243] and math.floor(ability_recast[243]) or nil
	LastingEmanation.recast = ability_recast[244] and math.floor(ability_recast[244]) or nil
	LifeCycle.recast = ability_recast[246] and math.floor(ability_recast[246]) or nil
	LightArts.recast = ability_recast[228] and math.floor(ability_recast[228]) or nil
	MendingHalation.recast = ability_recast[251] and math.floor(ability_recast[251]) or nil
	RadialArcana.recast = ability_recast[252] and math.floor(ability_recast[252]) or nil
	Sublimation.recast = ability_recast[234] and math.floor(ability_recast[234]) or nil
	TheurgicFocus.recast = ability_recast[249] and math.floor(ability_recast[249]) or nil

end

getRecasts()

-- Format abilities/spells to fit into their allotted 12 spaces
local function formatAbils(input,input_sh)

	-- Valid abilities/spells
	local validAbilities = {
		"Bolster", "Widened Compass", "Blaze of Glory", "Collimated Fervor", "Concentric Pulse", "Convert", "Dark Arts", "Dematerialize", "Divine Seal", "Ecliptic Attrition", "Elemental Seal", "Entrust", "Full Circle", "Lasting Emanation", "Life Cycle", "Light Arts", "Mending Halation", "Radial Arcana", "Sublimation", "Theurgic Focus"
	}

	local ab = {} ab['Bolster'] = Bolster ab['Widened Compass'] = WidenedCompass ab['Blaze of Glory'] = BlazeofGlory ab['Collimated Fervor'] = CollimatedFervor ab['Concentric Pulse'] = ConcentricPulse ab['Convert'] = Convert ab['Dark Arts'] = DarkArts ab['Dematerialize'] = Dematerialize ab['Divine Seal'] = DivineSeal ab['Ecliptic Attrition'] = EclipticAttrition ab['Elemental Seal'] = ElementalSeal ab['Entrust'] = Entrust ab['Full Circle'] = FullCircle ab['Lasting Emanation'] = LastingEmanation ab['Life Cycle'] = LifeCycle ab['Light Arts'] = LightArts ab['Mending Halation'] = MendingHalation ab['Radial Arcana'] = RadialArcana ab['Sublimation'] = Sublimation ab['Theurgic Focus'] = TheurgicFocus
	
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
			local c = recast == 0 and color.abil.active or color.abil.ready

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

-- Format Indi/Geo/Entrust Labels/Spells to be centered in their allotted 24 spaces
local function format24(input)

	local maxLength = 24
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
		hud_noti_bg:show()
		hud_debuffs_bg:show()
		hud_abil01_bg:show()
		hud_abil02_bg:show()
		hud_abil03_bg:show()
		hud_abil04_bg:show()
		hud_abil05_bg:show()
		hud_abil06_bg:show()
		hud_noti_shdw:show()
		hud_debuffs_shdw:show()
		hud_indi_label_shdw:show()
		hud_geo_label_shdw:show()
		hud_entrust_label_shdw:show()
		hud_indi_spell_shdw:show()
		hud_geo_spell_shdw:show()
		hud_entrust_spell_shdw:show()
		hud_abil01_shdw:show()
		hud_abil02_shdw:show()
		hud_abil03_shdw:show()
		hud_abil04_shdw:show()
		hud_abil05_shdw:show()
		hud_abil06_shdw:show()
		hud_noti:show()
		hud_debuffs:show()
		hud_indi_label:show()
		hud_geo_label:show()
		hud_entrust_label:show()
		hud_indi_spell:show()
		hud_geo_spell:show()
		hud_entrust_spell:show()
		hud_abil01:show()
		hud_abil02:show()
		hud_abil03:show()
		hud_abil04:show()
		hud_abil05:show()
		hud_abil06:show()
	elseif command == 'HideHUD' then
		hud_bg_color:hide()
		hud_bg:hide()
		hud_noti_bg:hide()
		hud_debuffs_bg:hide()
		hud_abil01_bg:hide()
		hud_abil02_bg:hide()
		hud_abil03_bg:hide()
		hud_abil04_bg:hide()
		hud_abil05_bg:hide()
		hud_abil06_bg:hide()
		hud_noti_shdw:hide()
		hud_debuffs_shdw:hide()
		hud_indi_label_shdw:hide()
		hud_geo_label_shdw:hide()
		hud_entrust_label_shdw:hide()
		hud_indi_spell_shdw:hide()
		hud_geo_spell_shdw:hide()
		hud_entrust_spell_shdw:hide()
		hud_abil01_shdw:hide()
		hud_abil02_shdw:hide()
		hud_abil03_shdw:hide()
		hud_abil04_shdw:hide()
		hud_abil05_shdw:hide()
		hud_abil06_shdw:hide()
		hud_noti:hide()
		hud_debuffs:hide()
		hud_indi_label:hide()
		hud_geo_label:hide()
		hud_entrust_label:hide()
		hud_indi_spell:hide()
		hud_geo_spell:hide()
		hud_entrust_spell:hide()
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
	elseif command == 'double_full_circle_fix' then
		double_full_circle_fix = false
	elseif command == "double_sublimation_fix" then
		double_sublimation_fix = false
	elseif command == 'CancelUseEntrust' then --reset the label when we deactivate AutoEntrust
		double_entrust_fix = false
		if UseEntrust == true then
			UseEntrust = false
			if Entrust.recast == 0 then -- If we haven't used Entrust yet, reset the label too
				hud_entrust_label_shdw:text(format24('Entrust'))
				hud_entrust_label:text(format24('Entrust'))
				hud_entrust_label:color(255,255,255)
			end
		end
	elseif command == 'LuopanDelay' then
		LuopanDelay = false
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
			equip(set_combine(sets.idle, sets.rest))
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
		elseif LuopanActive == true then
			if LowHP == true then --no matter what Mode we're in, if we have low HP we equip the Oh Shit gear set
				equip(set_combine(sets.luopan, sets.ohshit))
			elseif DTOverride == "On" then
				equip(set_combine(sets.luopan, sets.dtoverride))
			else
				equip(sets.luopan)
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
	elseif spell.english == 'Bolster' and Bolster.recast < 2 then
		equip(sets.bolster)
	elseif spell.english == 'Full Circle' and FullCircle.recast < 2 then
		equip(sets.fullcircle)
	elseif spell.english == 'Radial Arcana' and RadialArcana.recast < 2 then
		equip(sets.radialarcana)
	elseif spell.english == 'Mending Halation' and MendingHalation.recast < 2 then
		equip(sets.mendinghalation)
	elseif spell.english == 'Collimated Fervor' and CollimatedFervor.recast < 2 then
		equip(sets.collimatedfervor)
	elseif spell.english == 'Life Cycle' and LifeCycle.recast < 2 then
		equip(sets.lifecycle)
	elseif spell.english == 'Holy Water' then
		equip(sets.hwater)
	elseif string.find(spell.english,'Geo-') and LuopanActive == true and AutoFullCircle == 'On' and FullCircle.recast < 2 then
		--if we're casting a Geo- spell with a Luopan already out, we'll use Full Circle instead
		if not double_full_circle_fix then
			double_full_circle_fix = true --prevents this from running through here a second time after being cast again below
			cancel_spell()
			send_command('input /ja "Full Circle" <me>;wait 1;input /ma \"'..spell.english..'\" '..spell.target.raw..';wait 1;gs c double_full_circle_fix')
			return
		end
		equip(sets.fastcast)
	elseif string.find(spell.english,'Indi-') then
		if AutoEntrust == 'On' and Entrust.recast == 0 and spell.target.ispartymember == true and spell.target.type ~= 'SELF' then
			if UseEntrust == false then
				--if we're casting an Indi- spell on a party member without Entrust active we first make sure thats what we want to do instead of just using it immediately, this helps prevent misfires when someone casts on us right before
				add_to_chat(8,'AutoEntrust is now active. Repeat cast to use Entrust.')
				UseEntrust = true
				hud_entrust_label_shdw:text(format24('AutoEntrust Active'))
				hud_entrust_label:text(format24('AutoEntrust Active'))
				hud_entrust_label:color(255,255,50)
				send_command('wait 10;gs c CancelUseEntrust') --wait 10 seconds then we cancel UseEntrust if its still active
				cancel_spell()
				return
			elseif UseEntrust == true then
				--now that AutoEntrust was activated above, we can Do The Thing
				if not double_entrust_fix then
					double_entrust_fix = true --prevents this from running through here a second time after being cast again below
					cancel_spell()
					send_command('input /ja "Entrust" <me>;wait 1;input /ma \"'..spell.english..'\" '..spell.target.raw..'')
					send_command('wait 5;gs c CancelUseEntrust')
					return
				end
			end
		elseif UseEntrust == true and spell.target.type == 'SELF' then
			--if we cast an Indi- spell on ourselves we reset UseEntrust back to false, this allows us to cancel the use of AutoEntrust and go through the double-check above again for next time
			send_command('gs c CancelUseEntrust')
		end
		equip(sets.fastcast)
	elseif (spell.english == 'Spectral Jig' or spell.english == 'Sneak' or spell.english == 'Monomi: Ichi' or spell.english == 'Monomi: Ni') and buffactive['Sneak'] and spell.target.type == 'SELF' then
		send_command('cancel 71')
		if spell.english ~= 'Spectral Jig' then
			equip(sets.fastcast)
		end
	elseif spell.english == 'Stoneskin' and buffactive['Stoneskin'] then
		send_command('cancel 37')
		equip(sets.fastcast)
	elseif spell.english == 'Fire' or spell.english == 'Blizzard' or spell.english == 'Aero' or spell.english == 'Stone' or spell.english == 'Thunder' or spell.english == 'Water' then
		equip(sets.Elemental)
	elseif spell.english == 'Impact' then
		equip(set_combine(sets.fastcast, sets.impact))
	elseif not (spell.action_type == 'Item' or spell.action_type == 'Ability') then
		equip(sets.fastcast)
	end
end

-------------------------------------------
--               MIDCAST                 --
-------------------------------------------

function midcast(spell)
	if spell.type == 'Geomancy' then
		equip(sets.geomancy)
	elseif spell.english == 'Impact' then
		equip(set_combine(sets.magicaccuracy, sets.impact))
	elseif spell.skill == 'Elemental Magic' and not (spell.english == 'Fire' or spell.english == 'Blizzard' or spell.english == 'Aero' or spell.english == 'Stone' or spell.english == 'Thunder' or spell.english == 'Water') then
		equip(sets.elemental)
	elseif spell.skill == 'Enfeebling Magic' then
		equip(sets.enfeeble)
	elseif spell.english == 'Refresh' then
		equip(set_combine(sets.buff, sets.refresh))
	elseif spell.english == 'Cursna' then
		equip(sets.cursna)
	elseif string.find(spell.english,'Cur') and spell.type == "WhiteMagic" then
		equip(set_combine(sets.buff, sets.healing))
	elseif string.find(spell.english,'Aspir') or string.find(spell.english,'Drain') then
		equip(sets.aspirdrain)
	elseif string.find(spell.english,'Absorb') then
		equip(sets.magicaccuracy)
	elseif spell.type == 'Trust' then
		equip(sets.unity)
	end
end

-------------------------------------------
--              AFTERCAST                --
-------------------------------------------

function aftercast(spell)
	if spell.type == 'Geomancy' and not spell.interrupted then

		if player.equipment.main == 'Idris' then
			Multiplier = 10
		elseif player.equipment.neck == 'Bagua Charm +2' then
			Multiplier = 7
		elseif player.equipment.neck == 'Bagua Charm +1' then
			Multiplier = 6
		elseif player.equipment.neck == 'Bagua Charm' or player.equipment.range == 'Dunna' or player.equipment.range == 'Nepote Bell' then
			Multiplier = 5
		elseif player.equipment.range == 'Eminent Bell' then
			Multiplier = 3
		else
			Multiplier = 1
		end
		
		if string.find(spell.english,'Poison') then
			SpellSH = 'Poison'
			Base = 30
			Bonus = 3
			Suffix = '/tic'
		elseif string.find(spell.english,'Voidance') then
			SpellSH = 'Voidance (Eva +'
			Base = 65
			Bonus = 6
			Suffix = ')'
		elseif string.find(spell.english,'Precision') then
			SpellSH = 'Precision (Acc/R.Acc +'
			Base = 50
			Bonus = 5
			Suffix = ')'
		elseif string.find(spell.english,'Regen') then
			SpellSH = 'Regen +'
			Base = 30
			Bonus = 2
			Suffix = '/tic'
		elseif string.find(spell.english,'Attunement') then
			SpellSH = 'Attunement (M.Eva +'
			Base = 65
			Bonus = 6
			Suffix = ')'
		elseif string.find(spell.english,'Focus') then
			SpellSH = 'Focus (M.Acc +'
			Base = 50
			Bonus = 5
			Suffix = ')'
		elseif string.find(spell.english,'Barrier') then
			SpellSH = 'Barrier (Def +'
			Base = 39.8
			Bonus = 4.6
			Suffix = '%)'
		elseif string.find(spell.english,'Refresh') then
			SpellSH = 'Refresh +'
			Base = 6
			Bonus = 1
			Suffix = '/tic'
		elseif string.find(spell.english,'CHR') then
			SpellSH = 'Charisma +'
			Base = 25
			Bonus = 2
			Suffix = ''
		elseif string.find(spell.english,'MND') then
			SpellSH = 'Mind +'
			Base = 25
			Bonus = 2
			Suffix = ''
		elseif string.find(spell.english,'Fury') then
			SpellSH = 'Fury (Att +'
			Base = 34.7
			Bonus = 2.7
			Suffix = '%)'
		elseif string.find(spell.english,'INT') then
			SpellSH = 'Intelligence +'
			Base = 25
			Bonus = 2
			Suffix = ''
		elseif string.find(spell.english,'AGI') then
			SpellSH = 'Agility +'
			Base = 25
			Bonus = 2
			Suffix = ''
		elseif string.find(spell.english,'Fend') then
			SpellSH = 'Fend (M.Def +'
			Base = 19.9
			Bonus = 4
			Suffix = '%)'
		elseif string.find(spell.english,'VIT') then
			SpellSH = 'Vitality +'
			Base = 25
			Bonus = 2
			Suffix = ''
		elseif string.find(spell.english,'DEX') then
			SpellSH = 'Dexterity +'
			Base = 25
			Bonus = 2
			Suffix = ''
		elseif string.find(spell.english,'Acumen') then
			SpellSH = 'Acumen (MAtt +'
			Base = 15
			Bonus = 3
			Suffix = ')'
		elseif string.find(spell.english,'STR') then
			SpellSH = 'Strength +'
			Base = 25
			Bonus = 2
			Suffix = ''
		elseif string.find(spell.english,'Slow') then
			SpellSH = 'Slow +'
			Base = 14.9
			Bonus = 0.5
			Suffix = '%'
		elseif string.find(spell.english,'Torpor') then
			SpellSH = 'Torpor (Eva -'
			Base = 50
			Bonus = 5
			Suffix = ')'
		elseif string.find(spell.english,'Slip') then
			SpellSH = 'Slip (Acc -'
			Base = 65
			Bonus = 6
			Suffix = ')'
		elseif string.find(spell.english,'Languor') then
			SpellSH = 'Languor (M.Eva -'
			Base = 50
			Bonus = 5
			Suffix = ')'
		elseif string.find(spell.english,'Paralysis') then
			SpellSH = 'Paralysis +'
			Base = 15
			Bonus = 1
			Suffix = ''
		elseif string.find(spell.english,'Vex') then
			SpellSH = 'Vex (M.Acc -'
			Base = 65
			Bonus = 6
			Suffix = ')'
		elseif string.find(spell.english,'Frailty') then
			SpellSH = 'Frailty (Def -'
			Base = 14.8
			Bonus = 2.7
			Suffix = '%)'
		elseif string.find(spell.english,'Precision') then
			SpellSH = 'Precision (Acc/R.Acc +'
			Base = 50
			Bonus = 5
			Suffix = ')'
		elseif string.find(spell.english,'Wilt') then
			SpellSH = 'Wilt (Att -'
			Base = 25
			Bonus = 4.6
			Suffix = '%)'
		elseif string.find(spell.english,'Gravity') then
			SpellSH = 'Gravity +'
			Base = 19.9
			Bonus = 1.1
			Suffix = '%'
		elseif string.find(spell.english,'Malaise') then
			SpellSH = 'Malaise (M.Def -'
			Base = 15
			Bonus = 3
			Suffix = ')'
		elseif string.find(spell.english,'Haste') then
			SpellSH = 'Haste +'
			Base = 29.9
			Bonus = 1.1
			Suffix = '%'
		elseif string.find(spell.english,'Fade') then
			SpellSH = 'Fade (M.Att -'
			Base = 20
			Bonus = 4
			Suffix = ')'
		end

		local Total = Base + (Bonus * Multiplier)

		if string.find(spell.english,'Indi-') then
			if buffactive['Entrust'] then
				local Target = spell.target.name
				EntrustSpell = SpellSH
				EntrustTotal = Base
				EntrustSuffix = Suffix
				hud_entrust_label_shdw:text(format24('Entrust - '..Target))
				hud_entrust_label:text(format24('Entrust - '..Target))
				hud_entrust_label:color(255,255,255)
				hud_entrust_spell_shdw:text(format24(EntrustSpell..EntrustTotal..EntrustSuffix))
				hud_entrust_spell:text(format24(EntrustSpell..EntrustTotal..EntrustSuffix))
				hud_entrust_spell:color(75,255,75)
				local is_npc = windower.ffxi.get_mob_by_name(Target).is_npc
				if is_npc then
					EntrustCountdown = 330 -- 5:30 is about the longest you can get with Indi-spell duration gear
				else
					EntrustTarget = Target -- this is the main way we determine when the Entrusted spell has worn off another player
					EntrustCountdown = 360 -- but we still run a slightly longer timer as a backup just in case
				end
			else
				IndiSpell = SpellSH
				IndiTotal = Total
				IndiSuffix = Suffix
				hud_indi_spell_shdw:text(format24(IndiSpell..IndiTotal..IndiSuffix))
				hud_indi_spell:text(format24(IndiSpell..IndiTotal..IndiSuffix))
				hud_indi_spell:color(75,255,75)
			end
		elseif string.find(spell.english,'Geo-') then
			if buffactive['Bolster'] then
				BolsteredBubble = true
			end
			GeoSpell = SpellSH
			GeoTotal = Total
			GeoSuffix = Suffix
			send_command('wait 2;gs c Choose Set;gs c LuopanDelay')
			--add in a 2 second wait after casting a Geo- spell because the choose_set function is called too quickly and the pet.isvalid hasn't had enough time to be set to true yet
		end
	elseif spell.english == 'Blaze of Glory' and not spell.interrupted then
		BlazeActive = true
		LuopanDelay = true
	elseif spell.english == 'Lasting Emanation' and not spell.interrupted then
		LastingActive = true
	elseif spell.english == 'Ecliptic Attrition' and not spell.interrupted then
		EclipticActive = true
	elseif spell.english == 'Dematerialize' and not spell.interrupted then
		DematerializeActive = true
	elseif (spell.english == 'Full Circle' or spell.english == 'Concentric Pulse' or spell.english == 'Radial Arcana' or spell.english == 'Mending Halation') and not spell.interrupted then
		hud_geo_spell_shdw:text(format24('None'))
		hud_geo_spell:text(format24('None'))
		hud_geo_spell:color(255,50,50)
		LuopanActive = false
	elseif spell.english == 'Bolster' and BolTimer == 'On' and not spell.interrupted then
		if player.equipment.body == 'Bagua Tunic' or player.equipment.body == 'Bagua Tunic +1' or player.equipment.body == 'Bagua Tunic +2' or player.equipment.body == 'Bagua Tunic +3' then --these pieces extend Bolster by 30 seconds so we adjust accordingly
			send_command('input /echo [Bolster] 3:30;wait 30;input /echo [Bolster] 3:00;wait 30;input /echo [Bolster] 2:30;wait 30;input /echo [Bolster] 2:00;wait 30;input /echo [Bolster] 1:30;wait 30;input /echo [Bolster] 1:00;wait 30;input /echo [Bolster] 0:30;wait 10;input /echo [Bolster] 0:20;wait 10;input /echo [Bolster] 0:10')
		else
			send_command('input /echo [Bolster] 3:00;wait 30;input /echo [Bolster] 2:30;wait 30;input /echo [Bolster] 2:00;wait 30;input /echo [Bolster] 1:30;wait 30;input /echo [Bolster] 1:00;wait 30;input /echo [Bolster] 0:30;wait 10;input /echo [Bolster] 0:20;wait 10;input /echo [Bolster] 0:10')
		end
	elseif spell.english == 'Widened Compass' and WCTimer == 'On' and not spell.interrupted then
		send_command('input /echo [Widened Compass] 1:00;wait 30;input /echo [Widened Compass] 0:30;wait 10;input /echo [Widened Compass] 0:20;wait 10;input /echo [Widened Compass] 0:10')
	end
	choose_set()
	if AutoSubCharge and player.sub_job == 'SCH' and Sublimation.recast and Sublimation.recast < 2 and not (buffactive['amnesia'] or buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete'] or buffactive['Refresh'] or buffactive['Invisible']) then
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
	if AutoSubCharge and player.sub_job == 'SCH' and status == 0 and Sublimation.recast and Sublimation.recast < 2 and not (buffactive['amnesia'] or buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete'] or buffactive['Refresh'] or buffactive['Invisible']) then
		if not double_sublimation_fix then
			double_sublimation_fix = true --prevents this from running a second time (as an aftercast above) after being run here
			send_command('input /ja Sublimation <me>;wait 1;gs c double_sublimation_fix')
			return
		end
	end
end)

-------------------------------------------
--       Buff/Debuff Notifications       --
-------------------------------------------

function party_buff_change(party_member,name,gain,buff)
	if name == 'Colure Active' and gain == false and party_member.name == EntrustTarget then
		EntrustTarget = nil
		hud_entrust_spell_shdw:text(format24('None'))
		hud_entrust_spell:text(format24('None'))
		hud_entrust_label_shdw:text(format24('Entrust'))
		hud_entrust_label:text(format24('Entrust'))
		if Entrust.recast and Entrust.recast > 0 then
			hud_entrust_spell:color(255,165,0)
		else
			hud_entrust_spell:color(255,50,50)	
		end
	end
end

windower.register_event('gain buff', function(buff)
	if (buff == 2 or buff == 19) then
		if buffactive['Stoneskin'] and not buffactive['charm'] then --If we get slept, remove stoneskin if its up
			send_command('cancel 37')
		end
		equip(sets.ohshit)
	elseif buff == 7 or buff == 10 or buff == 28 then --If we get petrified, stunned, or terrored, then equip the Oh Shit set
		equip(sets.ohshit)
	elseif buff == 15 then --Doom
		DangerCountdown = DangerRepeat --Start the Danger Sound going
	elseif buff == 17 and AlertSounds == 'On' then --Charm
		windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
	elseif buff == 612 then --Colure Active
		hud_indi_spell_shdw:text(format24((IndiSpell == 'None' and 'Unknown' or IndiSpell)..(IndiTotal and IndiTotal or '')..(IndiSuffix and IndiSuffix or '')))
		hud_indi_spell:text(format24((IndiSpell == 'None' and 'Unknown' or IndiSpell)..(IndiTotal and IndiTotal or '')..(IndiSuffix and IndiSuffix or '')))
		hud_indi_spell:color(75,255,75)
	elseif buff == 71 or buff == 69 then --Sneak or Invisible
		send_command('gs c ClearNotifications')
	elseif buff == 252 then --Mounted
		send_command('wait .5;gs c ClearNotifications')
	end
end)

windower.register_event('lose buff', function(buff)
	if buff == 251 and Alive == true and NotiFood == 'On' then --food wears off
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
	elseif buff == 612 then --Indicolure
		hud_indi_spell_shdw:text(format24('None'))
		hud_indi_spell:text(format24('None'))
		hud_indi_spell:color(255,50,50)
	elseif buff == 513 then --Bolster
		BolsteredBubble = false
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

windower.register_event('tp change',function()
	if player.tp == 3000 and Noti3000TP == 'On' then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/3000TP.wav')
		end
		hud_noti_shdw:text('«« 3000 TP »»')
		hud_noti:text('«« 3000 TP »»')
		hud_noti:color(255,255,50)
		NotiCountdown = NotiDelay
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
	if NotiLowMP =='On' and player and player.mpp <= 20 and NotiLowMPToggle == 'Off' then
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

	--Luopan HP checks
	if pet.isvalid == true then
		local pet = windower.ffxi.get_mob_by_target('pet')
		if pet and PetHPP ~= pet.hpp then
			PetHPP = pet.hpp
			local petHPMeter = ''
			local spaces = math.floor(72 * (pet.hpp / 100)) --HUD is 72 spaces wide
			while string.len(petHPMeter) < spaces and string.len(petHPMeter) < 72 do
				petHPMeter = petHPMeter..' '
			end
			petHPMeter = petHPMeter..'\n'..petHPMeter..'\n'..petHPMeter..'\n'..petHPMeter
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
			hud_geo_label_shdw:text(format24('Luopan - '..pet.hpp..'%'))
			hud_geo_label:text(format24('Luopan - '..pet.hpp..'%'))
		end
		local tempTotal = GeoTotal and GeoTotal or nil --used instead of GeoTotal so it doesn't just multiply itself every time below
		if BolsteredBubble and buffactive['Bolster'] then
			tempTotal = GeoTotal and (math.floor((GeoTotal * 2) * 100)) / 100
		elseif EclipticActive and BlazeActive then
			tempTotal = (math.floor((GeoTotal * 1.75) * 100)) / 100
		elseif BlazeActive then
			tempTotal = (math.floor((GeoTotal * 1.50) * 100)) / 100
		elseif EclipticActive then
			tempTotal = (math.floor((GeoTotal * 1.25) * 100)) / 100
		end
		hud_geo_spell_shdw:text(format24((GeoSpell == 'None' and 'Unknown' or GeoSpell)..(tempTotal and tempTotal or '')..(GeoSuffix and GeoSuffix or '')))
		hud_geo_spell:text(format24((GeoSpell == 'None' and 'Unknown' or GeoSpell)..(tempTotal and tempTotal or '')..(GeoSuffix and GeoSuffix or '')))
		hud_geo_spell:color(0,255,0)
		LuopanActive = true
	elseif PetHPP ~= -1 then
		PetHPP = -1 --We use -1 to avoid an issue with Luopan being killed not triggering this
		hud_bg_color:bg_alpha(0)
		hud_geo_label_shdw:text(format24('Luopan'))
		hud_geo_label:text(format24('Luopan'))
		hud_geo_spell_shdw:text(format24('None'))
		hud_geo_spell:text(format24('None'))
		hud_geo_spell:color(255,50,50)
		LuopanActive = false
		if not LuopanDelay then --wait for the delay to finish before we definitively say these are down
			DematerializeActive = false
			EclipticActive = false
			LastingActive = false
			BlazeActive = false
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

		if EntrustCountdown > 0 then
			EntrustCountdown = EntrustCountdown -1
		else
			hud_entrust_spell_shdw:text(format24('None'))
			hud_entrust_spell:text(format24('None'))
			if not UseEntrust then
				hud_entrust_label_shdw:text(format24('Entrust'))
				hud_entrust_label:text(format24('Entrust'))
			end
			if Entrust.recast and Entrust.recast > 0 then
				hud_entrust_spell:color(255,165,0)
			else
				hud_entrust_spell:color(255,50,50)	
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
		if buffactive['Colure Active'] then
			local tempTotal = IndiTotal and IndiTotal or nil --used instead of IndiTotal so it doesn't just double itself every second below
			if buffactive['Bolster'] then
				tempTotal = IndiTotal and (math.floor((IndiTotal * 2) * 100)) / 100
			end
			hud_indi_spell_shdw:text(format24((IndiSpell == 'None' and 'Unknown' or IndiSpell)..(tempTotal and tempTotal or '')..(IndiSuffix and IndiSuffix or '')))
			hud_indi_spell:text(format24((IndiSpell == 'None' and 'Unknown' or IndiSpell)..(tempTotal and tempTotal or '')..(IndiSuffix and IndiSuffix or '')))
			hud_indi_spell:color(0,255,0)
		end
		if NotiDoom == 'On' and buffactive['doom'] then
			flash('Debuffs')
		end
		if NotiLowHP == 'On' and LowHP == true and Alive == true then
			hud_noti_shdw:text('«« Low HP »»')
			hud_noti:text('«« Low HP »»')
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
		if party and party_count == 1 and party_count ~= party.count then
			party_count = party.count
			send_command('gs c ClearNotifications')
		elseif party and party_count ~= 1 and party.count == 1 then
			party_count = 1
		end

		--Recast color updates

		if Bolster.recast then
			if buffactive['Bolster'] then
				textColor('Bolster','active')
				Bolster.flashed = false
			elseif Bolster.recast > 0 then
				textColor('Bolster','cooldown')
				Bolster.flashed = false
			else
				textColor('Bolster','ready')
				if not Bolster.flashed then
					flash('Bolster')
				end
				Bolster.flashed = true
			end
		else
			textColor('Bolster','notfound')
		end

		if WidenedCompass.recast then
			if buffactive['Widened Compass'] then
				textColor('Widened Compass','active')
				WidenedCompass.flashed = false
			elseif WidenedCompass.recast > 0 then
				textColor('Widened Compass','cooldown')
				WidenedCompass.flashed = false
			else
				textColor('Widened Compass','ready')
				if not WidenedCompass.flashed then
					flash('Widened Compass')
				end
				WidenedCompass.flashed = true
			end
		else
			textColor('Widened Compass','notfound')
		end

		if BlazeofGlory.recast then
			if BlazeActive or buffactive['Blaze of Glory']then
				textColor('Blaze of Glory','active')
				BlazeofGlory.flashed = false
			elseif BlazeofGlory.recast > 0 then
				textColor('Blaze of Glory','cooldown')
				BlazeofGlory.flashed = false
			else
				textColor('Blaze of Glory','ready')
				if not BlazeofGlory.flashed then
					flash('Blaze of Glory')
				end
				BlazeofGlory.flashed = true
			end
		else
			textColor('Blaze of Glory','notfound')
		end

		if CollimatedFervor.recast then
			if buffactive['Collimated Fervor'] then
				textColor('Collimated Fervor','active')
				CollimatedFervor.flashed = false
			elseif CollimatedFervor.recast > 0 then
				textColor('Collimated Fervor','cooldown')
				CollimatedFervor.flashed = false
			else
				textColor('Collimated Fervor','ready')
				if not CollimatedFervor.flashed then
					flash('Collimated Fervor')
				end
				CollimatedFervor.flashed = true
			end
		else
			textColor('Collimated Fervor','notfound')
		end

		if ConcentricPulse.recast then
			if ConcentricPulse.recast > 0 then
				textColor('Concentric Pulse','cooldown')
				ConcentricPulse.flashed = false
			else
				textColor('Concentric Pulse','ready')
				if not ConcentricPulse.flashed then
					flash('Concentric Pulse')
				end
				ConcentricPulse.flashed = true
			end
		else
			textColor('Concentric Pulse','notfound')
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

		if Dematerialize.recast then
			if DematerializeActive then
				textColor('Dematerialize','active')
				Dematerialize.flashed = false
			elseif Dematerialize.recast > 0 then
				textColor('Dematerialize','cooldown')
				Dematerialize.flashed = false
			else
				textColor('Dematerialize','ready')
				if not Dematerialize.flashed then
					flash('Dematerialize')
				end
				Dematerialize.flashed = true
			end
		else
			textColor('Dematerialize','notfound')
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

		if EclipticAttrition.recast then
			if EclipticActive then
				textColor('Ecliptic Attrition','active')
				EclipticAttrition.flashed = false
			elseif EclipticAttrition.recast > 0 then
				textColor('Ecliptic Attrition','cooldown')
				EclipticAttrition.flashed = false
			else
				textColor('Ecliptic Attrition','ready')
				if not EclipticAttrition.flashed then
					flash('Ecliptic Attrition')
				end
				EclipticAttrition.flashed = true
			end
		else
			textColor('Ecliptic Attrition','notfound')
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

		if Entrust.recast then
			if EntrustCountdown > 0 then
				textColor('Entrust','active')
				Entrust.flashed = false
			elseif Entrust.recast > 0 then
				textColor('Entrust','cooldown')
				Entrust.flashed = false
			else
				textColor('Entrust','ready')
				if not Entrust.flashed then
					flash('Entrust')
				end
				Entrust.flashed = true
			end
		else
			textColor('Entrust','notfound')
		end

		if FullCircle.recast then
			if FullCircle.recast > 0 then
				textColor('Full Circle','cooldown')
				FullCircle.flashed = false
			else
				textColor('Full Circle','ready')
				if not FullCircle.flashed then
					flash('Full Circle')
				end
				FullCircle.flashed = true
			end
		else
			textColor('Full Circle','notfound')
		end

		if LastingEmanation.recast then
			if LastingActive then
				textColor('Lasting Emanation','active')
				LastingEmanation.flashed = false
			elseif LastingEmanation.recast > 0 then
				textColor('Lasting Emanation','cooldown')
				LastingEmanation.flashed = false
			else
				textColor('Lasting Emanation','ready')
				if not LastingEmanation.flashed then
					flash('Lasting Emanation')
				end
				LastingEmanation.flashed = true
			end
		else
			textColor('Lasting Emanation','notfound')
		end

		if LifeCycle.recast then
			if LifeCycle.recast > 0 then
				textColor('Life Cycle','cooldown')
				LifeCycle.flashed = false
			else
				textColor('Life Cycle','ready')
				if not LifeCycle.flashed then
					flash('Life Cycle')
				end
				LifeCycle.flashed = true
			end
		else
			textColor('Life Cycle','notfound')
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

		if MendingHalation.recast then
			if MendingHalation.recast > 0 then
				textColor('Mending Halation','cooldown')
				MendingHalation.flashed = false
			else
				textColor('Mending Halation','ready')
				if not MendingHalation.flashed then
					flash('Mending Halation')
				end
				MendingHalation.flashed = true
			end
		else
			textColor('Mending Halation','notfound')
		end

		if RadialArcana.recast then
			if RadialArcana.recast > 0 then
				textColor('Radial Arcana','cooldown')
				RadialArcana.flashed = false
			else
				textColor('Radial Arcana','ready')
				if not RadialArcana.flashed then
					flash('Radial Arcana')
				end
				RadialArcana.flashed = true
			end
		else
			textColor('Radial Arcana','notfound')
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

		if TheurgicFocus.recast then
			if buffactive['Theurgic Focus'] then
				textColor('Theurgic Focus','active')
				TheurgicFocus.flashed = false
			elseif TheurgicFocus.recast > 0 then
				textColor('Theurgic Focus','cooldown')
				TheurgicFocus.flashed = false
			else
				textColor('Theurgic Focus','ready')
				if not TheurgicFocus.flashed then
					flash('Theurgic Focus')
				end
				TheurgicFocus.flashed = true
			end
		else
			textColor('Theurgic Focus','notfound')
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

	-- Reset HUD Abilities/Spells and Macro Page
	if newSubjob == 'WHM' then
		subjob = 'WHM'
		if SubWHMPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubWHMPage..'')
		end
	elseif newSubjob == 'RDM' then
		subjob = 'RDM'
		if SubRDMPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubRDMPage..'')
		end
	elseif newSubjob == 'BLM' then
		subjob = 'BLM'
		if SubBLMPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubBLMPage..'')
		end
	elseif newSubjob == 'SCH' then
		subjob = 'SCH'
		if SubSCHPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubSCHPage..'')
		end
	else
		subjob = 'OTH'
	end
	getHUDAbils()

end

-------------------------------------------
--        INCOMING TEXT CHECKS           --
-------------------------------------------

windower.register_event('incoming text',function(org)
	if org:find('Luopan') and org:find('Dematerialize') and org:find('effect wears off.')then
		DematerializeActive = false
	elseif org:find('wishes to trade with you') then
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

	--Delete our text objects, aliases, and binds, thank you for your service
	hud_bg_color:destroy()
	hud_bg:destroy()
	hud_noti_bg:destroy()
	hud_debuffs_bg:destroy()
	hud_abil01_bg:destroy()
	hud_abil02_bg:destroy()
	hud_abil03_bg:destroy()
	hud_abil04_bg:destroy()
	hud_abil05_bg:destroy()
	hud_abil06_bg:destroy()
	hud_noti_shdw:destroy()
	hud_debuffs_shdw:destroy()
	hud_indi_label_shdw:destroy()
	hud_geo_label_shdw:destroy()
	hud_entrust_label_shdw:destroy()
	hud_indi_spell_shdw:destroy()
	hud_geo_spell_shdw:destroy()
	hud_entrust_spell_shdw:destroy()
	hud_abil01_shdw:destroy()
	hud_abil02_shdw:destroy()
	hud_abil03_shdw:destroy()
	hud_abil04_shdw:destroy()
	hud_abil05_shdw:destroy()
	hud_abil06_shdw:destroy()
	hud_noti:destroy()
	hud_debuffs:destroy()
	hud_indi_label:destroy()
	hud_geo_label:destroy()
	hud_entrust_label:destroy()
	hud_indi_spell:destroy()
	hud_geo_spell:destroy()
	hud_entrust_spell:destroy()
	hud_abil01:destroy()
	hud_abil02:destroy()
	hud_abil03:destroy()
	hud_abil04:destroy()
	hud_abil05:destroy()
	hud_abil06:destroy()
	send_command('unalias hud')
	send_command('unalias dt')
	send_command('unbind '..DTBind)

end
