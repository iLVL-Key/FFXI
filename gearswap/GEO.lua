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

To switch between Nuke Modes, use any of these three options:
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
	/console dt
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

-------------------------------------------
--                OPTIONS                --
-------------------------------------------

Book			=	'5'		--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
SubWHMPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing WHM.
SubRDMPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing RDM.
SubBLMPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing BLM.
SubSCHPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing SCH.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
BolTimer		=	true	--[true/false]	Displays a timer for Bolster in echo.
WCTimer			=	true	--[true/false]	Displays a timer for Widened Compass in echo.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions
							--				(Town limits this to town gear only).
AlertSounds		=	true	--[true/false]	Plays a sound on alerts. 
UseEcho			=	'R'		--[E/R/Off]		Automatically uses an (E)cho Drop or (R)emedy instead of spell when you are silenced.
AutoFullCircle	=	true	--[true/false]	Automatically uses Full Circle when you cast a Geo- spell with a Luopan already out.
AutoEntrust		=	true	--[true/false]	Automatically uses Entrust when you cast an Indi- spell on a party member. The first cast onto
							--				a party member will engage the AutoEntrust system, the second cast will execute as intended.
AutoSubCharge	=	true	--[true/false]	Automatically attempts to keep Sublimation charging.
TransportLock	=	true	--[true/false]	Cancels your first Transport spell and unlocks for 3 min or until zone.

-- Heads Up Display --
HUDposX			=	100	--	X position for the HUD. 0 is left of the window, increasing this number will move it to the right.
HUDposY			=	100		--	Y position for the HUD. 0 is top of the window, increasing this number will move it downward.
FontSize		=	10.5	--	Adjust the font size. Changing this may require you to adjust the Spacers below as well.
LineSpacer		=	17		--	Space in pixels between each Line of the HUD.
ColumnSpacer	=	95		--	Space in pixels between each Column of the HUD.

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

ShowHUD			=	true	--[true/false]  Initial state of the HUD. Use `//hud` to show/hide the HUD in game.
StartMode		=	'Free'	--[Free/Burst]
							--	Determines the Nuke Mode you will start in. Current Mode can be changed at any time by using any
							--	of the three options listed above in the Notes section (a macro, alias, or keyboard shortcut).
ModeBind		=	'^g'	--Sets the keyboard shortcut you would like to cycle between Nuke Modes. CTRL+G (^g) is default.
DTBind			=	'^d'	--Sets the keyboard shortcut you would like to activate the Damage Taken Override. CTRL+D (^d) is default.
							--    ^ = CTRL    ! = ALT    @ = WIN    # = APPS    ~ = SHIFT
LowHPThreshold	=	1000	--Below this number is considered Low HP.
DangerRepeat	=	5		--Maximum number of times the Danger Sound will repeat, once per second.
RRReminderTimer	=	1800	--Delay in seconds between checks to see if Reraise is up (300 is 5 minutes).
NotiDelay		=	6		--Delay in seconds before certain notifications will automatically clear.
PollingRate		=	5		--Times per second to check for various conditions (debuffs, ammo, etc). Higher rates use more CPU.
AddCommas		=	true	--[true/false]  Adds commas to damage numbers.

-------------------------------------------
--              HUD RECAST               --
-------------------------------------------

-- Controls what is displayed in the HUD Recast section.
-- The first column tells the file which ability/spell to place in that slot, the following are valid for use:
--		Bolster, Widened Compass, Blaze of Glory, Collimated Fervor, Concentric Pulse, Convert, Dark Arts, Dematerialize, Divine Seal, Ecliptic Attrition, Elemental Seal, Entrust, Full Circle, Lasting Emanation, Life Cycle, Light Arts, Mending Halation, Radial Arcana, Sublimation, Theurgic Focus
-- The "_sh" column allows you to change the name displayed if you would like, leave blank otherwise.
-- NOTE: Names will automatically be truncated to 10 characters to fit correctly.

sub = {
	--GEO/WHM
	WHM = {
		Abil01 = "Radial Arcana",		Abil01_sh = "",
		Abil02 = "Blaze of Glory",		Abil02_sh = "BlazeGlory",
		Abil03 = "Dematerialize",		Abil03_sh = "Dematrialz",
		Abil04 = "Ecliptic Attrition",	Abil04_sh = "Ecliptic",
		Abil05 = "Life Cycle",			Abil05_sh = "",
		Abil06 = "Divine Seal",			Abil06_sh = "Divn Seal",
	},
	--GEO/RDM
	RDM = {
		Abil01 = "Radial Arcana",		Abil01_sh = "",
		Abil02 = "Blaze of Glory",		Abil02_sh = "BlazeGlory",
		Abil03 = "Dematerialize",		Abil03_sh = "Dematrialz",
		Abil04 = "Ecliptic Attrition",	Abil04_sh = "Ecliptic",
		Abil05 = "Life Cycle",			Abil05_sh = "",
		Abil06 = "Convert",				Abil06_sh = "",
	},
	--GEO/BLM
	BLM = {
		Abil01 = "Radial Arcana",		Abil01_sh = "",
		Abil02 = "Blaze of Glory",		Abil02_sh = "BlazeGlory",
		Abil03 = "Dematerialize",		Abil03_sh = "Dematrialz",
		Abil04 = "Ecliptic Attrition",	Abil04_sh = "Ecliptic",
		Abil05 = "Life Cycle",			Abil05_sh = "",
		Abil06 = "Elemental Seal",		Abil06_sh = "Elem Seal",
	},
	--GEO/SCH
	SCH = {
		Abil01 = "Radial Arcana",		Abil01_sh = "",
		Abil02 = "Blaze of Glory",		Abil02_sh = "BlazeGlory",
		Abil03 = "Dematerialize",		Abil03_sh = "Dematrialz",
		Abil04 = "Ecliptic Attrition",	Abil04_sh = "Ecliptic",
		Abil05 = "Life Cycle",			Abil05_sh = "",
		Abil06 = "Sublimation",			Abil06_sh = "Sublmation",
	},
	--GEO/other
	OTH = {
		Abil01 = "Radial Arcana",		Abil01_sh = "",
		Abil02 = "Mending Halation",	Abil02_sh = "Mending",
		Abil03 = "Blaze of Glory",		Abil03_sh = "BlazeGlory",
		Abil04 = "Dematerialize",		Abil04_sh = "Dematrialz",
		Abil05 = "Ecliptic Attrition",	Abil05_sh = "Ecliptic",
		Abil06 = "Life Cycle",			Abil06_sh = "",
	}
}

-------------------------------------------
--             COLOR VALUES              --
-------------------------------------------

color = {
	-- ELEMENTS --
	Light	= {r = 255, g = 248, b = 220},
	Fire	= {r = 255, g = 0, b = 0},
	Ice		= {r = 135, g = 206, b = 250},
	Air		= {r = 50, g = 205, b = 50},
	Earth	= {r = 250, g = 130, b = 40},
	Thunder	= {r = 186, g = 85, b = 211},
	Water	= {r = 30, g = 144, b = 255},
	Dark	= {r = 200, g = 30, b = 80},

	-- HUD Bubble HP Meter --
	hi = {r = 0, g = 255, b = 0},
	md = {r = 255, g = 165, b = 0},
	lo = {r = 255, g = 0, b = 50},

	-- HUD RECAST --
	abil = {
		ready		= {r = 255, g = 50, b = 50},	-- Ready to use
		active		= {r = 75, g = 255, b = 75},	-- Currently active
		cooldown	= {r = 255, g = 165, b = 0},	-- On cooldown
		flash		= {r = 255, g = 255, b = 125},	-- Flash (now ready)
		notfound	= {r = 125, g = 125, b = 125}	-- Not Found
	},

	-- HUD Nuke Modes --
	mode = {
		free = {r = 150, g = 255, b = 150},		--Free Nuke
		burst = {r = 100, g = 200, b = 255},	--Magic Burst
	},

	-- HUD Bubbles --
	bubble = {
		normal = {r = 150, g = 255,b = 150},	--Normal
		extra = {r = 100, g = 200, b = 255},	--Blaze of Glory OR Ecliptic Attrition
		boge = {r = 200, g = 100, b = 255},		--Blaze of Glory AND Ecliptic Attrition
		bolster = {r = 255, g = 223, b = 0},	--Bolster
	}
}

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
	head="Null Masque",
	body="Azimuth Coat +3",
	hands="Bagua Mitaines +4",
	legs="Volte Brais",
	feet="Geo. Sandals +4",
	neck="Loricate Torque +1",
	waist="Null Belt",
	left_ear="Alabaster Earring",
	right_ear="Azimuth Earring +1",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
}

-- Idle w/ Luopan (Pet Damage Taken-, Pet Regen)
-- Used when you DO have a Luopan bubble out.
-- Combines with Idle set, only necessary to set the slots with specific desired stats
-- NOTE: Lupoan has a native Pet DT-50%. Dunna has Pet DT-5%. Overall Pet DT cap is 87.5%. Idris and Geo. Mitaines will cap Pet DT for your Luopan allowing you to focus on Pet Regen.
sets.idle_luopan = set_combine(sets.idle, {
	main="Idris",
	sub="Genmei Shield",
	range="Dunna",
	head="Azimuth Hood +3",
	body="Azimuth Coat +3",
	hands="Geo. Mitaines +4",
	feet="Bagua Sandals +4",
	waist="Isa Belt",
	back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}},
})

-- Movement Speed
-- Automatically equips while in town, and while moving outside of town.
-- NOTE: To disable, leave this set empty and instead include your movement speed gear in the Idle set above.
sets.movement_speed = {
	feet="Geo. Sandals +4",
}

-- DT Override (Damage Taken-, Magic Evasion)
-- Will override all other gear sets but still inherit unused slots from them
sets.dt_override = {
	head="Azimuth Hood +3",
	body="Nyame Mail",
	hands="Azimuth Gloves +3",
	legs="Nyame Flanchard",
	right_ring="Defending Ring",
}

-- Oh Shit
-- Full DT- and everything you've got with Absorbs or Annuls Damage
sets.oh_shit = {
	head="Azimuth Hood +3",
	body="Nyame Mail",
	hands="Azimuth Gloves +3",
	legs="Nyame Flanchard",
	neck="Warder's Charm +1",
	left_ear="Lugalbanda Earring",
	right_ear="Eabani Earring",
	left_ring="Shadow Ring",
	right_ring="Defending Ring",
	back="Shadow Mantle"
}

-- Rest
sets.rest = {
	waist="Austerity Belt",
}

-- DPS (Accuracy, Double/Triple Attack, DEX, Store TP, Attack)
sets.melee = {
	head="Azimuth Hood +3",
	body="Azimuth Coat +3",
	hands="Azimuth Gloves +3",
	legs="Azimuth Tights +3",
	feet="Azimuth Gaiters +3",
	neck="Null Loop",
	waist="Windbuffet Belt +1",
	left_ear="Mache Earring +1",
	right_ear="Cessance Earring",
	left_ring="Hetairoi Ring",
	right_ring="Petrov Ring",
	back="Null Shawl",
}

-- Weapon Skill - Basic (STR, Weapon Skill Damage, Attack, Double/Triple Attack)
sets.weapon_skill = {
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
	back="Null Shawl",
}

-- Exudation (combines with Weapon Skill set above)
sets["Exudation"] = set_combine(sets.weapon_skill, {
	neck="Fotia Gorget",
	waist="Fotia Belt",
})

-- Black Halo (combines with Weapon Skill set above)
sets["Black Halo"] = set_combine(sets.weapon_skill, {

})

-- Hexa Strike (combines with Weapon Skill set above)
sets["Hexa Strike"] = set_combine(sets.weapon_skill, {
	neck="Fotia Gorget",
	waist="Fotia Belt",
})

-- Cataclysm (combines with Weapon Skill set above)
sets["Cataclysm"] = set_combine(sets.weapon_skill, {
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

-- Hachirin-no-obi
sets.hachirin_no_obi = {
	waist="Hachirin-no-obi",
}

-- Fast Cast (cap is 80%)
sets.fast_cast = {
	sub="Genmei Shield",
	head="Amalric Coif +1", --11%
	body="Zendik Robe", --13%
	hands="Agwu's Gages", --6%
	legs="Geomancy Pants +4", --15%
	feet="Amalric Nails +1", --6%
	neck="Baetyl Pendant", --4%
	waist="Embla Sash", --5%
	left_ear="Malignance Earring", --4%
	right_ear="Alabaster Earring",
	left_ring="Prolix Ring", --2%
	right_ring="Kishar Ring", --4%
	back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --10%
}

-- Indicolure (Geomancy+, 900 Geomancy Skill+Handbell Skill, Indicolure duration+, Azimuth set bonus)
-- NOTE: You only need a combined skill of 900 between Geomancy skill and Handbell skill to cap your potency, anything over 900 is wasted)
sets.indicolure = {
	main="Idris",
	sub="Genmei Shield",
	range="Dunna",
	head="Azimuth Hood +3",
	body="Azimuth Coat +3",
	hands="Azimuth Gloves +3",
	legs="Bagua Pants +4",
	feet="Azimuth Gaiters +3",
	back="Lifestream Cape",
}

-- Geocolure (Geomancy+, 900 Geomancy Skill+Handbell Skill, Lupoan duration+ (Bagua Charm), Azimuth set bonus)
-- NOTE: You only need a combined skill of 900 between Geomancy skill and Handbell skill to cap your potency, anything over 900 is wasted)
-- NOTE: Geocolure spells don't get any bonus at mid-cast except from the "Lupoan duration" augment on Bagua Charm. Luopan duration specifically reduces the native perpetuation cost "poison" on the Luopan and is only applied to the Luopan at time of cast (ie midcast).
sets.geocolure = {
	main="Idris",
	sub="Genmei Shield",
	range="Dunna",
	head="Azimuth Hood +3",
	body="Azimuth Coat +3",
	hands="Azimuth Gloves +3",
	legs="Azimuth Tights +3",
	feet="Azimuth Gaiters +3",
	neck="Bagua Charm +2",
}

-- Entrust (900 Geomancy Skill+Handbell Skill, Indicolure duration+, Azimuth set bonus)
-- NOTE: Entrusted spells DO NOT receive and Geomancy+ bonus.
sets.entrust = set_combine(sets.indicolure, {
	main="Gada",
})

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
	right_ring="Freke Ring",
	back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
}

-- Magic Burst (Magic Burst Damage)
-- Combines with Elemental Spells set, only necessary to set the slots with specific desired stats
sets.magic_burst = {
	head="Ea Hat +1",
	waist="Acuity Belt +1",
	left_ring="Mujin Band",
}

-- Magic Accuracy (Magic Accuracy)
sets.magic_accuracy = {
	main="Idris",
	sub="Ammurapi Shield",
	head="Azimuth Hood +3",
	body="Azimuth Coat +3",
	hands="Azimuth Gloves +3",
	legs="Azimuth Tights +3",
	feet="Azimuth Gaiters +3",
	neck="Null Loop",
	waist="Null Belt",
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
sets.aspir_drain = set_combine(sets.magic_accuracy, {
	head="Bagua Galero +4",
	feet="Agwu's Pigaches",
	neck="Erra Pendant",
	waist="Fucho-no-obi",
	right_ring="Evanescence Ring",
})

-- Enfeeble (Enfeebling Magic Skill)
-- Combines with Magic Accuracy set, only necessary to set the slots with specific desired stats
sets.enfeeble = set_combine(sets.magic_accuracy, {
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
	hands="Geo. Mitaines +4", --temp for Bumba
	legs="Geomancy Pants +4", --temp for Bumba
	feet="Geo. Sandals +4", --temp for Bumba
}

-- Dispelga (Daybreak)
sets.dispelga = {
	main="Daybreak",
}

-- Enhancing Magic (Enhancing Magic Skill)
sets.enhancing = set_combine(sets.buff, {

})

-- Phalanx (Phalanx+)
sets.phalanx = set_combine(sets.enhancing, {

})

-- Aquaveil (Aquaveil+)
sets.aquaveil = set_combine(sets.enhancing, {

})

-- Holy Water (Holy Water+)
sets.holy_water = {
	neck="Nicander's Necklace",
	ring1="Blenmot's Ring +1",
	ring2="Blenmot's Ring +1",
}

-- Bolster (Enhances Bolster gear)
sets.bolster = {
	body="Bagua Tunic",
}

-- Full Circle (Enhances Curative Recantation gear)
sets.full_circle = {
	head="Azimuth Hood +3",
	hands="Bagua Mitaines +4",
}

-- Radial Arcana (Enhances Radial Arcana gear)
sets.radial_arcana = {
	feet="Bagua Sandals +4",
}

-- Mending Halation (Enhances Mending Halation gear)
sets.mending_halation = {
	legs="Bagua Pants +4",
}

-- Collimated Fervor (Enhances Privemal Zeal gear)
sets.collimated_fervor = {
	head="Bagua Galero +4",
}

-- Life Cycle (Enhances Life Cycle gear)
sets.life_cycle = {
	body="Geomancy Tunic +3",
	back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}},
}

-- Default Town Gear (Put all your fancy-pants gear in here you want to showboat around town in. Does not lockstyle this gear, only equips)
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




FileVersion = '15.0'

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
spells = res.spells
Mode = StartMode --sets the starting mode (selected in the Advanced Options)
IndiSpell = 'None'
GeoSpell = 'None'
EntrustSpell = 'None'
UseEntrust = false
NotiLowMPToggle = false --start with the toggle off for the Low MP Notification so that it can trigger
DTOverride = false --Start with the Damage Taken Override off
RRRCountdown = RRReminderTimer
HUDposYLine1 = HUDposY
last_poll = 0 --keeps the timing for things that happen at the polling rate
last_second = 0 --keeps the timing for things that happen every second
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
transport_locked = true
transport_lock_timestamp = 0
player_x = nil
player_y = nil
moving = false

local play_sound = windower.play_sound
local addon_path = windower.addon_path
local Notification_Good = addon_path..'data/sounds/NotiGood.wav'
local Notification_Bad = addon_path..'data/sounds/NotiBad.wav'
local Notification_Danger = addon_path..'data/sounds/Danger.wav'
local Notification_Cancel = addon_path..'data/sounds/Cancel.wav'
local Notification_3000TP = addon_path..'data/sounds/3000TP.wav'

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
	send_command('input /cm '..Chat)
end

-- Sets the Macro Book and Page
if Book ~= "Off" then
	send_command('input /macro book '..Book)
end
if SubWHMPage ~= "Off" and player.sub_job == 'WHM' then
	send_command('wait 2;input /macro set '..SubWHMPage)
elseif SubRDMPage ~= "Off" and player.sub_job == 'RDM' then
	send_command('wait 2;input /macro set '..SubRDMPage)
elseif SubBLMPage ~= "Off" and player.sub_job == 'BLM' then
	send_command('wait 2;input /macro set '..SubBLMPage)
elseif SubSCHPage ~= "Off" and player.sub_job == 'SCH' then
	send_command('wait 2;input /macro set '..SubSCHPage)
else
	send_command('wait 2;input /macro set 1')
end

if ZoneGear ~= 'Off' then
	send_command('wait 2;gs c Zone Gear')
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

if ShowHUD then
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

send_command('alias mode gs c Mode') --creates the Mode alias
send_command('alias hud gs c HUD') --creates the HUD alias
send_command('alias dt gs c DT') --creates the DT Override alias
send_command('bind '..ModeBind..' gs c Mode') --creates the gear mode keyboard shortcut
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
				formattedNumber = formattedNumber:sub(1, insertIndex)..","..formattedNumber:sub(insertIndex + 1)
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

	Bolster.recast = ability_recast[0] and math.ceil(ability_recast[0])
	WidenedCompass.recast = ability_recast[254] and math.ceil(ability_recast[254]) or 0
	BlazeofGlory.recast = ability_recast[247] and math.ceil(ability_recast[247])
	CollimatedFervor.recast = ability_recast[245] and math.ceil(ability_recast[245])
	ConcentricPulse.recast = ability_recast[250] and math.ceil(ability_recast[250])
	Convert.recast = ability_recast[49] and math.ceil(ability_recast[49])
	DarkArts.recast = ability_recast[232] and math.ceil(ability_recast[232])
	Dematerialize.recast = ability_recast[248] and math.ceil(ability_recast[248])
	DivineSeal.recast = ability_recast[26] and math.ceil(ability_recast[26])
	EclipticAttrition.recast = ability_recast[244] and math.ceil(ability_recast[244])
	ElementalSeal.recast = ability_recast[38] and math.ceil(ability_recast[38])
	Entrust.recast = ability_recast[93] and math.ceil(ability_recast[93])
	FullCircle.recast = ability_recast[243] and math.ceil(ability_recast[243])
	LastingEmanation.recast = ability_recast[244] and math.ceil(ability_recast[244])
	LifeCycle.recast = ability_recast[246] and math.ceil(ability_recast[246])
	LightArts.recast = ability_recast[228] and math.ceil(ability_recast[228])
	MendingHalation.recast = ability_recast[251] and math.ceil(ability_recast[251])
	RadialArcana.recast = ability_recast[252] and math.ceil(ability_recast[252])
	Sublimation.recast = ability_recast[234] and math.ceil(ability_recast[234])
	TheurgicFocus.recast = ability_recast[249] and math.ceil(ability_recast[249])

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
			formattedString = leftPadding..'\\cs('..c.r..','..c.g..','..c.b..')[\\cr'..formattedString..'\\cs('..c.r..','..c.g..','..c.b..')]\\cr'..rightPadding

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

local function useHachirinNoObi(nuke_element)
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

	local day = world.day_element
	local weather = world.weather_element
	local weather_intensity = world.weather_intensity

	local bonus = 0
	local penalty = 0

	--Positive bonuses
	if day == nuke_element then
		bonus = bonus + 10
	end
	if weather == nuke_element then
		bonus = bonus + (weather_intensity == 2 and 25 or 10)
	end

	--Negative penalties from opposing element
	local oppose = opposites[nuke_element]
	if day == oppose then
		penalty = penalty + 10
	end
	if weather == oppose then
		penalty = penalty + (weather_intensity == 2 and 25 or 10)
	end

	--Use Obi only if the total bonus outweighs the penalty
	return bonus > penalty
end

-------------------------------------------
--            SELF COMMANDS              --
-------------------------------------------

function self_command(command)
	if command == 'Mode' then
		if Mode == 'Free' then
			Mode = 'Burst'
		elseif Mode == 'Burst' then
			Mode = 'Free'
		end
		local new_mode = Mode == 'Free' and 'Free Nuke' or 'Magic Burst'
		hud_noti_shdw:text('Nuke Mode set to '..new_mode)
		hud_noti:text('Nuke Mode set to '..new_mode)
		local c = Mode == 'Free' and color.mode.free or color.mode.burst
		hud_noti:color(c.r,c.g,c.b)
		NotiCountdown = NotiDelay
	elseif command == 'DT' then
		DTOverride = not DTOverride
		choose_set()
	elseif command == 'ClearNotifications' then --these reset the Notifications display back to a basic state
		local c = Mode == 'Free' and color.mode.free or color.mode.burst
		if TownZones:contains(world.area) or windower.ffxi.get_info().mog_house then
			hud_noti_shdw:text(player.name..': '..player.main_job..player.main_job_level..'/'..(player.sub_job_level and player.sub_job..player.sub_job_level or "---"))
			hud_noti:text(player.name..': '..player.main_job..player.main_job_level..'/'..(player.sub_job_level and player.sub_job..player.sub_job_level or "---"))
			hud_noti:color(c.r,c.g,c.b)
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
		elseif player.mpp <= 20 then
			hud_noti_shdw:text('«« Low MP »»')
			hud_noti:text('«« Low MP »»')
			hud_noti:color(255,50,50)
		elseif player.status == "Resting" and DTOverride then
			hud_noti_shdw:text('Status: Resting (DT Override)')
			hud_noti:text('Status: Resting (DT Override)')
			hud_noti:color(c.r,c.g,c.b)
		elseif player.status == "Resting" then
			hud_noti_shdw:text('Status: Resting')
			hud_noti:text('Status: Resting')
			hud_noti:color(c.r,c.g,c.b)
		elseif player.status == "Engaged" and DTOverride then
			hud_noti_shdw:text('Status: Engaged (DT Override)')
			hud_noti:text('Status: Engaged (DT Override)')
			hud_noti:color(c.r,c.g,c.b)
		elseif player.status == "Engaged" then
			hud_noti_shdw:text('Status: Engaged')
			hud_noti:text('Status: Engaged')
			hud_noti:color(c.r,c.g,c.b)
		elseif player.status == "Idle" and DTOverride then
			hud_noti_shdw:text('Status: Idle (DT Override)')
			hud_noti:text('Status: Idle (DT Override)')
			hud_noti:color(c.r,c.g,c.b)
		elseif player.status == "Idle" then
			hud_noti_shdw:text('Status: Idle')
			hud_noti:text('Status: Idle')
			hud_noti:color(c.r,c.g,c.b)
		elseif player.status == "Mount" then
			hud_noti_shdw:text('Status: Mounted')
			hud_noti:text('Status: Mounted')
			hud_noti:color(c.r,c.g,c.b)
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
		if UseEntrust then
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
	local c = Mode == 'Free' and color.mode.free or color.mode.burst
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
			elseif player.mpp <= 20 then
				hud_noti_shdw:text('«« Low MP »»')
				hud_noti:text('«« Low MP »»')
				hud_noti:color(255,50,50)
			elseif DTOverride then
				hud_noti_shdw:text('Status: Resting (DT Override)')
				hud_noti:text('Status: Resting (DT Override)')
				hud_noti:color(c.r,c.g,c.b)
			else
				hud_noti_shdw:text('Status: Resting')
				hud_noti:text('Status: Resting')
				hud_noti:color(c.r,c.g,c.b)
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
			elseif DTOverride then
				hud_noti_shdw:text('Status: Engaged (DT Override)')
				hud_noti:text('Status: Engaged (DT Override)')
				hud_noti:color(c.r,c.g,c.b)
			else
				hud_noti_shdw:text('Status: Engaged')
				hud_noti:text('Status: Engaged')
				hud_noti:color(c.r,c.g,c.b)
			end
		end
		local dt_override = DTOverride and sets.dt_override or nil
		local low_hp = LowHP and sets.oh_shit or nil
		equip(set_combine(sets.melee, dt_override, low_hp))
	elseif player.status == "Idle" then
		if GreetingDelay == -1 then
			if TownZones:contains(world.area) or windower.ffxi.get_info().mog_house then
				hud_noti_shdw:text(player.name..': '..player.main_job..player.main_job_level..'/'..(player.sub_job_level and player.sub_job..player.sub_job_level or "---"))
				hud_noti:text(player.name..': '..player.main_job..player.main_job_level..'/'..(player.sub_job_level and player.sub_job..player.sub_job_level or "---"))
				hud_noti:color(c.r,c.g,c.b)
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
			elseif player.mpp <= 20 then
				hud_noti_shdw:text('«« Low MP »»')
				hud_noti:text('«« Low MP »»')
				hud_noti:color(205,133,63)
			elseif DTOverride then
				hud_noti_shdw:text('Status: Idle (DT Override)')
				hud_noti:text('Status: Idle (DT Override)')
				hud_noti:color(c.r,c.g,c.b)
			else
				hud_noti_shdw:text('Status: Idle')
				hud_noti:text('Status: Idle')
				hud_noti:color(c.r,c.g,c.b)
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
			local base_set = LuopanActive and sets.idle_luopan or sets.idle
			local dt_override = DTOverride and sets.dt_override or nil
			local low_hp = LowHP and sets.oh_shit or nil
			equip(set_combine(base_set, dt_override, low_hp))
		end
	end
end

-------------------------------------------
--               PRECAST                 --
-------------------------------------------

function precast(spell)
	local transport_spells = S{
		'Teleport-Holla', 'Teleport-Dem', 'Teleport-Mea', 'Teleport-Altep', 'Teleport-Yhoat', 'Teleport-Vahzl',
		'Recall-Jugner', 'Recall-Meriph', 'Recall-Pashh',
		'Warp', 'Warp II', 'Retrace', 'Escape'
	}
	if TransportLock and transport_spells:contains(spell.en) and transport_locked then
		cancel_spell()
		transport_locked = false
		windower.add_to_chat(8,('[Notice] '):color(39)..(spell.name):color(1)..(' cancelled. Unlocked for 3 min or until zone.'):color(8))
		if AlertSounds then
			play_sound(Notification_Cancel)
		end
		transport_lock_timestamp = os.time() + 180
		return
	end
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
		equip(sets[spell.english] and sets[spell.english] or sets.weapon_skill)
	elseif spell.english == 'Bolster' and Bolster.recast < 2 then
		equip(sets.bolster)
	elseif spell.english == 'Full Circle' and FullCircle.recast < 2 then
		equip(sets.full_circle)
	elseif spell.english == 'Radial Arcana' and RadialArcana.recast < 2 then
		equip(sets.radial_arcana)
	elseif spell.english == 'Mending Halation' and MendingHalation.recast < 2 then
		equip(sets.mending_halation)
	elseif spell.english == 'Collimated Fervor' and CollimatedFervor.recast < 2 then
		equip(sets.collimated_fervor)
	elseif spell.english == 'Life Cycle' and LifeCycle.recast < 2 then
		equip(sets.life_cycle)
	elseif spell.english == 'Holy Water' then
		equip(sets.holy_water)
	elseif string.find(spell.english,'Geo-') and LuopanActive and AutoFullCircle and FullCircle.recast < 2 then
		--if we're casting a Geo- spell with a Luopan already out, we'll use Full Circle instead
		if not double_full_circle_fix then
			double_full_circle_fix = true --prevents this from running through here a second time after being cast again below
			cancel_spell()
			send_command('input /ja "Full Circle" <me>;wait 1;input /ma \"'..spell.english..'\" '..spell.target.raw..';wait 1;gs c double_full_circle_fix')
			return
		end
		equip(sets.fast_cast)
	elseif string.find(spell.english,'Indi-') then
		if AutoEntrust and Entrust.recast == 0 and spell.target.ispartymember and spell.target.type ~= 'SELF' then
			if not UseEntrust then
				--if we're casting an Indi- spell on a party member without Entrust active we first make sure thats what we want to do instead of just using it immediately, this helps prevent misfires when someone casts on us right before
				add_to_chat(8,'AutoEntrust is now active. Repeat cast to use Entrust.')
				UseEntrust = true
				hud_entrust_label_shdw:text(format24('AutoEntrust Active'))
				hud_entrust_label:text(format24('AutoEntrust Active'))
				hud_entrust_label:color(255,255,50)
				send_command('wait 10;gs c CancelUseEntrust') --wait 10 seconds then we cancel UseEntrust if its still active
				cancel_spell()
				return
			elseif UseEntrust then
				--now that AutoEntrust was activated above, we can Do The Thing
				if not double_entrust_fix then
					double_entrust_fix = true --prevents this from running through here a second time after being cast again below
					cancel_spell()
					send_command('input /ja "Entrust" <me>;wait 1;input /ma \"'..spell.english..'\" '..spell.target.raw)
					send_command('wait 5;gs c CancelUseEntrust')
					return
				end
			end
		elseif UseEntrust and spell.target.type == 'SELF' then
			--if we cast an Indi- spell on ourselves we reset UseEntrust back to false, this allows us to cancel the use of AutoEntrust and go through the double-check above again for next time
			send_command('gs c CancelUseEntrust')
		end
		equip(sets.fast_cast)
	elseif (spell.english == 'Spectral Jig' or spell.english == 'Sneak' or spell.english == 'Monomi: Ichi' or spell.english == 'Monomi: Ni') and buffactive['Sneak'] and spell.target.type == 'SELF' then
		send_command('cancel 71')
		if spell.english ~= 'Spectral Jig' then
			equip(sets.fast_cast)
		end
	elseif spell.english == 'Stoneskin' and buffactive['Stoneskin'] then
		send_command('cancel 37')
		equip(sets.fast_cast)
	elseif spell.english == 'Fire' or spell.english == 'Blizzard' or spell.english == 'Aero' or spell.english == 'Stone' or spell.english == 'Thunder' or spell.english == 'Water' then
		equip(sets.Elemental)
	elseif spell.english == 'Impact' then
		equip(set_combine(sets.fast_cast, sets.impact))
	elseif spell.english == 'Dispelga' then
		equip(set_combine(sets.fast_cast, sets.dispelga))
	elseif not (spell.action_type == 'Item' or spell.action_type == 'Ability') then
		equip(sets.fast_cast)
	end
end

-------------------------------------------
--               MIDCAST                 --
-------------------------------------------

function midcast(spell)
	if spell.type == 'Geomancy' then
		if string.find(spell.english,'Geo-') then
			equip(sets.geocolure)
		else
			if buffactive['Entrust'] then
				equip(sets.entrust)
			else
				equip(sets.indicolure)
			end
		end
	elseif spell.english == 'Impact' then
		equip(set_combine(sets.magic_accuracy, sets.impact))
	elseif spell.english == 'Dispelga' then
		equip(set_combine(sets.magic_accuracy, sets.dispelga))
	elseif spell.english == 'Refresh' then
		equip(set_combine(sets.buff, sets.refresh))
	elseif spell.english == 'Cursna' then
		equip(sets.cursna)
	elseif string.find(spell.english,'Cur') and spell.type == "WhiteMagic" then
		equip(set_combine(sets.buff, sets.healing))
	elseif string.find(spell.english,'Aspir') or string.find(spell.english,'Drain') then
		equip(sets.aspir_drain)
	elseif string.find(spell.english,'Absorb') or spell.english == 'Stun' or spell.english == 'Dispel' then
		equip(sets.magic_accuracy)
	elseif spell.english == 'Phalanx' then
		equip(sets.phalanx)
	elseif spell.english == 'Aquaveil' then
		equip(sets.aquaveil)
	elseif spell.skill == 'Enhancing Magic' then
		equip(sets.enhancing)
	elseif spell.skill == 'Elemental Magic' and not (spell.english == 'Fire' or spell.english == 'Blizzard' or spell.english == 'Aero' or spell.english == 'Stone' or spell.english == 'Thunder' or spell.english == 'Water') then
		local magic_burst = Mode == 'Burst' and sets.magic_burst or nil
		local hachirin_no_obi = useHachirinNoObi(spell.element) and sets.hachirin_no_obi or nil
		equip(set_combine(sets.elemental, magic_burst, hachirin_no_obi))
	elseif spell.skill == 'Enfeebling Magic' then
		equip(sets.enfeeble)
	elseif spell.type == 'Trust' then
		equip(sets.unity)
	elseif spell.action_type == 'Magic' then
		equip(sets.buff)
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
			SpellSH = 'Poison -'
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
			Suffix = '%'
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
			SpellSH = 'Gravity (Mv.Spd -'
			Base = 19.9
			Bonus = 1.1
			Suffix = '%)'
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
				local c = color.bubble.normal
				hud_entrust_spell:color(c.r,c.g,c.b)
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
				local c = buffactive['Bolster'] and color.bubble.bolster or color.bubble.normal
				hud_indi_spell:color(c.r,c.g,c.b)
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
		local c = color.bubble.normal
		if BolsteredBubble and buffactive['Bolster'] then
			c = color.bubble.bolster
		elseif EclipticActive and BlazeActive then
			c = color.bubble.boge
		elseif BlazeActive then
			c = color.bubble.extra
		elseif EclipticActive then
			c = color.bubble.extra
		end
		hud_geo_spell:color(c.r,c.g,c.b)
		LuopanActive = false
	elseif spell.english == 'Bolster' and BolTimer and not spell.interrupted then
		if player.equipment.body == 'Bagua Tunic' or player.equipment.body == 'Bagua Tunic +1' or player.equipment.body == 'Bagua Tunic +2' or player.equipment.body == 'Bagua Tunic +3' or player.equipment.body == 'Bagua Tunic +4' then --these pieces extend Bolster by 30 seconds so we adjust accordingly
			send_command('input /echo [Bolster] 3:30;wait 30;input /echo [Bolster] 3:00;wait 30;input /echo [Bolster] 2:30;wait 30;input /echo [Bolster] 2:00;wait 30;input /echo [Bolster] 1:30;wait 30;input /echo [Bolster] 1:00;wait 30;input /echo [Bolster] 0:30;wait 10;input /echo [Bolster] 0:20;wait 10;input /echo [Bolster] 0:10')
		else
			send_command('input /echo [Bolster] 3:00;wait 30;input /echo [Bolster] 2:30;wait 30;input /echo [Bolster] 2:00;wait 30;input /echo [Bolster] 1:30;wait 30;input /echo [Bolster] 1:00;wait 30;input /echo [Bolster] 0:30;wait 10;input /echo [Bolster] 0:20;wait 10;input /echo [Bolster] 0:10')
		end
	elseif spell.english == 'Widened Compass' and WCTimer and not spell.interrupted then
		send_command('input /echo [Widened Compass] 1:00;wait 30;input /echo [Widened Compass] 0:30;wait 10;input /echo [Widened Compass] 0:20;wait 10;input /echo [Widened Compass] 0:10')
	end
	choose_set()
	if AutoSubCharge and player.sub_job == 'SCH' and Sublimation.recast and Sublimation.recast < 2 and not (buffactive['amnesia'] or buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete'] or buffactive['Refresh'] or buffactive['Invisible'] or windower.ffxi.get_info().mog_house or world.area == 'Mog Garden') then
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
    if status == 4 and not InCS and ShowHUD then --In a cutscene: Hide the HUD
		InCS = true
		windower.send_command('gs c HideHUD')
    elseif status ~= 4 and InCS and ShowHUD then --Out of cutscene: Show the HUD
		InCS = false
		windower.send_command('gs c ShowHUD')
    end
	choose_set() --run this any time your status changes (engage, disengage, rest)
	if AutoSubCharge and player.sub_job == 'SCH' and status == 0 and Sublimation.recast and Sublimation.recast < 2 and not (buffactive['amnesia'] or buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete'] or buffactive['Refresh'] or buffactive['Invisible'] or windower.ffxi.get_info().mog_house or world.area == 'Mog Garden') then
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
	if name == 'Colure Active' and not gain and party_member.name == EntrustTarget then
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
		equip(sets.oh_shit)
	elseif buff == 7 or buff == 10 or buff == 28 then --If we get petrified, stunned, or terrored, then equip the Oh Shit set
		equip(sets.oh_shit)
	elseif buff == 15 then --Doom
		DangerCountdown = DangerRepeat --Start the Danger Sound going
	elseif buff == 17 and AlertSounds then --Charm
		play_sound(Notification_Cancel)
	elseif buff == 612 then --Colure Active
		hud_indi_spell_shdw:text(format24((IndiSpell == 'None' and 'Unknown' or IndiSpell)..(IndiTotal and IndiTotal or '')..(IndiSuffix and IndiSuffix or '')))
		hud_indi_spell:text(format24((IndiSpell == 'None' and 'Unknown' or IndiSpell)..(IndiTotal and IndiTotal or '')..(IndiSuffix and IndiSuffix or '')))
		local c = buffactive['Bolster'] and color.bubble.bolster or color.bubble.normal
		hud_indi_spell:color(c.r,c.g,c.b)
	elseif buff == 71 or buff == 69 then --Sneak or Invisible
		send_command('gs c ClearNotifications')
	elseif buff == 252 then --Mounted
		send_command('wait .5;gs c ClearNotifications')
	end
end)

windower.register_event('lose buff', function(buff)
	if buff == 251 and Alive and notifications.Food then --food wears off
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
	if player.tp == 3000 and notifications.TP3000 then
		if AlertSounds then
			play_sound(Notification_3000TP)
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

	--Using the teleports in Sortie pauses timers
	if world.area == "Outer Ra'Kaznar [U]" and player.status == "Event" then
		return
	end

	--Polling rate
	local current_time = os.clock()

	if current_time - last_poll >= 1 / PollingRate then

		last_poll = current_time

		--Zoning: hide HUD
		local pos = windower.ffxi.get_position()
		if pos == "(?-?)" and not Zoning and ShowHUD then
			send_command('gs c HideHUD')
			Zoning = true
		elseif pos ~= "(?-?)" and Zoning and ShowHUD then
			send_command('gs c ShowHUD')
			Zoning = false
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
		if notifications.LowMP and player and player.mpp <= 20 and not NotiLowMPToggle then
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
		end

		--Luopan HP checks
		if pet.isvalid then
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
			local tempTotal = GeoTotal --used instead of GeoTotal so it doesn't just multiply itself every time below
			local c = color.bubble.normal
			if BolsteredBubble and buffactive['Bolster'] then
				tempTotal = GeoTotal and (math.floor((GeoTotal * 2) * 100)) / 100
				c = color.bubble.bolster
			elseif EclipticActive and BlazeActive then
				tempTotal = (math.floor((GeoTotal * 1.75) * 100)) / 100
				c = color.bubble.boge
			elseif BlazeActive then
				tempTotal = (math.floor((GeoTotal * 1.50) * 100)) / 100
				c = color.bubble.extra
			elseif EclipticActive then
				tempTotal = (math.floor((GeoTotal * 1.25) * 100)) / 100
				c = color.bubble.extra
			end
			hud_geo_spell_shdw:text(format24((GeoSpell == 'None' and 'Unknown' or GeoSpell)..(tempTotal and tempTotal or '')..(GeoSuffix and GeoSuffix or '')))
			hud_geo_spell:text(format24((GeoSpell == 'None' and 'Unknown' or GeoSpell)..(tempTotal and tempTotal or '')..(GeoSuffix and GeoSuffix or '')))
			hud_geo_spell:color(c.r,c.g,c.b)
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

		--Recast updates
		getRecasts()
		getHUDAbils()

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

		if buffactive['Colure Active'] then
			local tempTotal = IndiTotal --used instead of IndiTotal so it doesn't just double itself every second below
			local c = color.bubble.normal
			if buffactive['Bolster'] then
				tempTotal = IndiTotal and (math.floor((IndiTotal * 2) * 100)) / 100
				c = color.bubble.bolster
			end
			hud_indi_spell_shdw:text(format24((IndiSpell == 'None' and 'Unknown' or IndiSpell)..(tempTotal and tempTotal or '')..(IndiSuffix and IndiSuffix or '')))
			hud_indi_spell:text(format24((IndiSpell == 'None' and 'Unknown' or IndiSpell)..(tempTotal and tempTotal or '')..(IndiSuffix and IndiSuffix or '')))
			hud_indi_spell:color(c.r,c.g,c.b)
		end

	end

	--1 second heartbeat
	if current_time - last_second >= 1 then

		last_second = current_time

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

		if transport_lock_timestamp ~= 0 and os.time() > transport_lock_timestamp then
			transport_locked = true
			transport_lock_timestamp = 0
			windower.add_to_chat(8,('[Notice] '):color(39)..('Transport locked.'):color(8))
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

	--Unlock Transport spells
	transport_locked = true
	transport_lock_timestamp = 0

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
			send_command('wait 2;input /macro set '..SubWHMPage)
		end
	elseif newSubjob == 'RDM' then
		subjob = 'RDM'
		if SubRDMPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubRDMPage)
		end
	elseif newSubjob == 'BLM' then
		subjob = 'BLM'
		if SubBLMPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubBLMPage)
		end
	elseif newSubjob == 'SCH' then
		subjob = 'SCH'
		if SubSCHPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubSCHPage)
		end
	else
		subjob = 'OTH'
	end
	getHUDAbils()

	if ZoneGear ~= 'Off' then
		send_command('wait 2;gs c Zone Gear')
	end

end

-------------------------------------------
--        INCOMING TEXT CHECKS           --
-------------------------------------------

windower.register_event('incoming text',function(org)
	if org:find('Luopan') and org:find('Dematerialize') and org:find('effect wears off.')then
		DematerializeActive = false
	elseif org:find('wishes to trade with you') then
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

	if notifications.Damage then
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
			elseif act.targets[1].actions[1].message == 185 and act.targets[1].actions[1].has_add_effect then
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

	--Delete our aliases and binds, thank you for your service
	send_command('unalias mode')
	send_command('unalias dt')
	send_command('unalias hud')
	send_command('unbind '..ModeBind)
	send_command('unbind '..DTBind)

end
