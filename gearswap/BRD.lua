-------------------------------------------
--    Keys Gearswap lua file for Bard    --
-------------------------------------------
--[[

Updates to this file and other GearSwap files and addons can be found at
https://github.com/iLVL-Key/FFXI

Place both this file and the sounds folder inside the GearSwap data folder
ex:	/addons/GearSwap/data/sounds/
	/addons/GearSwap/data/BRD.lua

--------------------

This file supports both "Dummy song" techniques:

-Partial Dummy Songs-
	Use Potency Mode to use full potency for your first 2 songs (or 3 with Clarion), switch to Dummy Mode to use an "extra song" instrument for the rest, then switch back to Potency Mode to repeat only the extra songs with full potency. You only need to switch to Dummy Mode if party members are missing any extra songs. This technique is slightly more involved (switching Modes) but faster and all songs are immediately useful.
		ex:
		[Start in Potency Mode]
		Sing: Honor March + Victory March
		[Change to Dummy Mode]
		Sing: Valor Minuet V + Valor Minuet IV
		[Change to Potency Mode]
		Sing: Valor Minuet V + Valor Minuet IV

-All Dummy Songs-
	Set specific songs to use an "extra song" instrument for all songs then overwrite all songs using full potency instrument. This technique is simpler (no Mode switching), but slower and the initial dummy songs are not beneficial to the party.
		ex:
		Sing: Fowl Aubade + Gold Capriccio + Shining Fantasia + Goblin Gavotte
		Sing: Honor March + Victory March + Valor Minuet V + Valor Minuet IV

--------------------

Regarding weapon slots and keeping TP:
	When engaged, weapons will be equipped based on your current Weapon Cycle selection. Weapons will also not be switched out for songs when engaged. This allows you to keep your TP when desired, as well as utilize the weapon slots for songs/spells when disengaged.
	TLDR;	Idle: full gear swapping, may lose TP.
			Engaged: Weapon slots ignored in gear sets, will keep TP.

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

To switch between Potency/Dummy instrument modes, use any of these three options:
1. A macro
	/console mode
2. An alias command
	//mode
3. A keybind shortcut
	CTRL+G
	(Can be changed in the Advanced Options section)

--------------------

To activate the Weapon Cycle, use any of these three options:
1. A macro with the following
	/console wc
2. An alias command
	//wc
3. A keybind shortcut
	CTRL+H
	(Can be changed in the Advanced Options section)

--------------------

Hide or show the HUD at any time by typing
	//hud

Hide or show the Song List at any time by typing
	//songs
or creating a macro with
	/console songs

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

Book			=	'9'		--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
SubDNCPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing DNC.
SubNINPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing NIN.
SubRDMPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing RDM.
SubSCHPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing SCH.
SubWHMPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing WHM.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
SVTimer			=	'On'	--[On/Off]		Displays a timer for Soul Voice in echo.
CCTimer			=	'On'	--[On/Off]		Displays a timer for Clarion Call in echo.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions
							--				(Town limits this to town gear only).
AlertSounds		=	'On'	--[On/Off]		Plays a sound on alerts. 
UseEcho			=	'R'		--[E/R/Off]		Automatically uses an (E)cho Drop or (R)emedy instead of spell when you are silenced.
AutoPianissimo	=	'On'	--[On/Off]		Automatically uses Pianissimo when you cast a song on a party member.
AutoSubCharge	=	'On'	--[On/Off]		Automatically attempts to keep Sublimation charging.
TransportLock	=	'On'	--[On/Off]		Cancels your first Transport spell and unlocks for 3 min or until zone.

-- Heads Up Display --
HUDposX			=	100		--	X position for the HUD. 0 is left of the window, increasing this number will move it to the right.
HUDposY			=	100		--	Y position for the HUD. 0 is top of the window, increasing this number will move it downward.
SongposX		=	400		--	X position for the Song list. 0 is left of the window, increasing this number will move it to the right.
SongposY		=	300		--	Y position for the Song list. 0 is top of the window, increasing this number will move it downward.
FontSize		=	10		--	Adjust the font size. Changing this may require you to adjust the Spacers below as well.
LineSpacer		=	16		--	Space in pixels between each Line of the HUD.
ColumnSpacer	=	90.5	--	Space in pixels between each Column of the HUD.
ShowTPMeter		=	'On'	--[On/Off]		Show the mini TP Meter inside the Weapons area.
PTMemNearDist	=	10		--	Maximum distance for a party member to be highlighted as "nearby".
SongsFontSize	=	9		--	Adjust the font size of the Songs List.

modeName = {
--HUD Mode Names
	Mode1 = 'Potency',	--Use Full Potency Instrument.
	Mode2 = 'Dummy',	--Use "Extra Song" Instrument.
}
-- Instruments --

inst = {
--"Partial Dummy Songs" - Using the Potency/Dummy Modes to trigger the extra songs
	dummy	= "Daurdabla",

--"All Dummy Songs" - Using specific songs to trigger the extra songs
--Note: You only need to set these to your "extra song" instrument if you use this technique,
--otherwise set these to whichever normal instrument you would like to use for these songs.
	aubade		= "Loughnashade",
	capriccio	= "Loughnashade",
	fantasia	= "Loughnashade",
	gavotte		= "Loughnashade",
	operetta	= "Loughnashade",
	pastoral	= "Loughnashade",
	round		= "Loughnashade",

--Potency Songs
	ballad			= "Loughnashade",
	carol			= "Loughnashade",
	dirge			= "Loughnashade",
	elegy			= "Loughnashade",
	etude			= "Loughnashade",
	finale			= "Loughnashade",
	horde_lullaby_II= "Blurred Harp +1",--Horde Lullaby II only
	hymnus			= "Loughnashade",
	lullaby			= "Loughnashade",	--All other lullabies
	madrigal		= "Loughnashade",
	mambo			= "Loughnashade",
	march			= "Loughnashade",	--Excludes Honor March
	mazurka			= "Marsyas",
	minne			= "Loughnashade",
	minuet			= "Loughnashade",
	nocturne		= "Loughnashade",
	paeon			= "Loughnashade",
	prelude			= "Loughnashade",
	requiem			= "Loughnashade",
	scherzo			= "Loughnashade",
	sirvente		= "Loughnashade",
	threnody		= "Loughnashade",
	virelai			= "Loughnashade",
}

--  General Notifications  --
ReraiseReminder		=	'On'	--[On/Off]	Displays an occasional reminder if Reraise is not up.
Noti3000TP			=	'On'	--[On/Off]	Displays a notification when you have 3000 TP.
NotiDamage			=	'On'	--[On/Off]	Displays your Weapon Skill, Skillchain, and Magic Burst damage.
NotiFood			=	'On'	--[On/Off]	Displays a notification when food wears off.
NotiInvis			=	'On'	--[On/Off]	Displays a notification when Invisible is about to wear off.
NotiInvite			=	'On'	--[On/Off]	Displays a notification when someone invites to a party/alliance.
NotiLowHP			=	'On'	--[On/Off]	Displays a notification when HP is low.
NotiLowMP			=	'On'	--[On/Off]	Displays a notification when MP is under 20% when you have a subjob that uses MP.
NotiReraise			=	'On'	--[On/Off]	Displays a notification when reraise wears off.
NotiSignet			=	'On'	--[On/Off]	Displays a notification when Signet/Sanction/Sigil/Ionis wears off.
NotiSneak			=	'On'	--[On/Off]	Displays a notification when Sneak is about to wear off.
NotiTime			=	'On'	--[On/Off]	Displays a notification for time remaining notices.
NotiTrade			=	'On'	--[On/Off]	Displays a notification when someone trades you.
NotiVorseal			=	'On'	--[On/Off]	Displays a notification when Vorseal wears off.

-- Debuff Notifications --
NotiAmnesia			=	'On'	--[On/Off]	Displays a notification when you have amnesia.
NotiCharm			=	'On'	--[On/Off]	Displays a notification when you are charmed/animated.
NotiCurse			=	'On'	--[On/Off]	Displays a notification when you are cursed/haunted/zombied.
NotiDoom			=	'On'	--[On/Off]	Displays a notification when you are doomed.
NotiEncumbrance		=	'On'	--[On/Off]	Displays a notification when you are encumbered.
NotiParalysis		=	'On'	--[On/Off]	Displays a notification when you are paralyzed.
NotiPetrification	=	'On'	--[On/Off]	Displays a notification when you are petrified.
NotiPlague			=	'On'	--[On/Off]	Displays a notification when you are plagued.
NotiSilence			=	'On'	--[On/Off]	Displays a notification when you are silenced/muted.
NotiSleep			=	'On'	--[On/Off]	Displays a notification when you are slept.
NotiStun			=	'On'	--[On/Off]	Displays a notification when you are stunned.
NotiTaint			=	'On'	--[On/Off]	Displays a notification when you are tainted.
NotiTerror			=	'On'	--[On/Off]	Displays a notification when you are terrorized.

-------------------------------------------
--           ADVANCED OPTIONS            --
-------------------------------------------

ShowHUD			=	'On'	--[On/Off]  Initial state of the HUD. Use `//hud` to show/hide the HUD in game.
ShowSongs		=	'On'	--[On/Off]  Initial state of the Song List. Use `//songs` to show/hide the Song List in game.
StartMode		=	'Mode1'	--[Mode1/Mode2]  (Mode1 = Full Potency Instrument, Mode2 = "Extra Song" Instrument)
								--	Determines the Mode you will start in. Current Mode can be changed at any time by using any
								--	of the three options listed above in the Notes section (a macro, alias, or keyboard shortcut).
DTBind			=	'^d'	--Sets the keyboard shortcut you would like to activate the Damage Taken Override. CTRL+D (^d) is default.
ModeBind		=	'^g'	--Sets the keyboard shortcut you would like to cycle between Modes. CTRL+G (^g) is default.
WCBind			=	'^h'	--Sets the keyboard shortcut you would like to activate the Weapon Cycle. CTRL+H (^h) is default.
							--    ^ = CTRL    ! = ALT    @ = WIN    # = APPS    ~ = SHIFT
LowHPThreshold	=	1000	--Below this number is considered Low HP.
DangerRepeat	=	5		--Maximum number of times the Danger Sound will repeat, once per second.
RRReminderTimer	=	1800	--Delay in seconds between checks to see if Reraise is up (300 is 5 minutes).
NotiDelay		=	6		--Delay in seconds before certain notifications will automatically clear.
AddCommas		=	'On'	--[On/Off]  Adds commas to damage numbers.

-------------------------------------------
--              HUD RECAST               --
-------------------------------------------

-- Controls what is displayed in the HUD Recast section.
-- The first column tells the file which ability/spell to place in that slot, the following are valid for use:
--		Sould Voice, Clarion Call, Contradance, Convert, Dark Arts, Divine Seal, Flourishes I, Flourishes II, Jigs Light Arts, Marcato, Nightingale,
--		Pianissimo, Sambas, Steps, Sublimation, Tenuto, Troubadour
-- The "_sh" column allows you to change the name displayed if you would like, leave blank otherwise
-- NOTE: Names will automatically be truncated to 10 characters to fit correctly.

sub = {
	--BRD/DNC
	DNC = {
		Abil01 = "Nightingale",		Abil01_sh = "Nightngale",
		Abil02 = "Troubadour",		Abil02_sh = "",
		Abil03 = "Marcato",			Abil03_sh = "",
		Abil04 = "Sambas",			Abil04_sh = "Samba",
		Abil05 = "Soul Voice",		Abil05_sh = "",
		Abil06 = "Clarion Call",	Abil06_sh = "Clarion"
	},
	--BRD/NIN
	NIN = {
		Abil01 = "Nightingale",		Abil01_sh = "Nightngale",
		Abil02 = "Troubadour",		Abil02_sh = "",
		Abil03 = "Marcato",			Abil03_sh = "",
		Abil04 = "Tenuto",			Abil04_sh = "",
		Abil05 = "Soul Voice",		Abil05_sh = "",
		Abil06 = "Clarion Call",	Abil06_sh = "Clarion"
	},
	--BRD/RDM
	RDM = {
		Abil01 = "Nightingale",		Abil01_sh = "Nightngale",
		Abil02 = "Troubadour",		Abil02_sh = "",
		Abil03 = "Marcato",			Abil03_sh = "",
		Abil04 = "Tenuto",			Abil04_sh = "",
		Abil05 = "Soul Voice",		Abil05_sh = "",
		Abil06 = "Clarion Call",	Abil06_sh = "Clarion"
	},
	--BRD/SCH
	SCH = {
		Abil01 = "Nightingale",		Abil01_sh = "Nightngale",
		Abil02 = "Troubadour",		Abil02_sh = "",
		Abil03 = "Marcato",			Abil03_sh = "",
		Abil04 = "Soul Voice",		Abil04_sh = "",
		Abil05 = "Clarion Call",	Abil05_sh = "Clarion",
		Abil06 = "Sublimation",		Abil06_sh = "Sublmation"
	},
	--BRD/WHM
	WHM = {
		Abil01 = "Nightingale",		Abil01_sh = "Nightngale",
		Abil02 = "Troubadour",		Abil02_sh = "",
		Abil03 = "Marcato",			Abil03_sh = "",
		Abil04 = "Tenuto", 			Abil04_sh = "",
		Abil05 = "Soul Voice",		Abil05_sh = "",
		Abil06 = "Clarion Call",	Abil06_sh = "Clarion"
	},
	--BRD/OTH (other)
	OTH = {
		Abil01 = "Nightingale",		Abil01_sh = "Nightngale",
		Abil02 = "Troubadour",		Abil02_sh = "",
		Abil03 = "Marcato",			Abil03_sh = "",
		Abil04 = "Tenuto",			Abil04_sh = "",
		Abil05 = "Soul Voice",		Abil05_sh = "",
		Abil06 = "Clarion Call",	Abil06_sh = "Clarion"
	}
}

-------------------------------------------
--             COLOR VALUES              --
-------------------------------------------

color = {
	-- MODES --
	Mode1	= {r = 125, g = 200, b = 255},  -- Full Potency Instrument
	Mode2	= {r = 255, g = 255, b = 125},  -- "Extra Song" Instrument

	-- AFTERMATH --
	AM1	= {r = 75, g = 255, b = 75},
	AM2	= {r = 0, g = 200, b = 255},
	AM3	= {r = 255, g = 255, b = 50},

	-- ELEMENTS --
	Light	= {r = 255, g = 248, b = 220},
	Fire	= {r = 255, g = 0, b = 0},
	Ice		= {r = 135, g = 206, b = 250},
	Air		= {r = 50, g = 205, b = 50},
	Earth	= {r = 250, g = 130, b = 40},
	Thunder	= {r = 186, g = 85, b = 211},
	Water	= {r = 30, g = 144, b = 255},
	Dark	= {r = 200, g = 30, b = 80},

	-- SONG LIST --
	song_list = {

		-- Bullet
		Paeon		= {r = 0, g = 102, b = 204},
		Ballad		= {r = 0, g = 154, b = 0},
		Minne		= {r = 207, g = 205, b = 0},
		Minuet		= {r = 207, g = 51, b = 49},
		Madrigal	= {r = 154, g = 51, b = 207},
		Mazurka		= {r = 241, g = 222, b = 70},
		Prelude		= {r = 185, g = 244, b = 190},
		Mambo		= {r = 0, g = 205, b = 0},
		Dummy		= {r = 162, g = 164, b = 206},
		March		= {r = 0, g = 154, b = 205},
		Etude		= {r = 154, g = 132, b = 102},
		Carol		= {r = 155, g = 102, b = 0},
		Sirvente	= {r = 255, g = 102, b = 99},
		Dirge		= {r = 101, g = 154, b = 155},
		Scherzo		= {r = 155, g = 205, b = 207},
		Aria		= {r = 90, g = 90, b = 90},

		-- Song Name
		soul_voice	= {r = 255, g = 223, b = 0},
		normal		= {r = 255, g = 255, b = 255},

		-- Duration
		very_long	= {r = 200, g = 100, b = 255},	-- Over 10 minutes
		long		= {r = 100, g = 200, b = 255},	-- Over 5 minutes
		regular		= {r = 150, g = 255, b = 150},	-- Under 5 minutes
		low			= {r = 255, g = 165, b = 0},	-- Under 1 minute
		critical	= {r = 255, g = 50, b = 50},	-- Under 30 seconds
		none		= {r = 255, g = 255, b = 255}	-- No songs
	},

	-- HUD RECAST --
	abil = {
		ready		= {r = 255, g = 50, b = 50},	-- Ready to use
		active		= {r = 75, g = 255, b = 75},	-- Currently active
		cooldown	= {r = 255, g = 165, b = 0},	-- On cooldown
		flash		= {r = 255, g = 255, b = 125},	-- Flash (now ready)
		notfound	= {r = 125, g = 125, b = 125}	-- Not Found
	}
}
  
-------------------------------------------
--                WEAPONS                --
-------------------------------------------

-- These are the Main/Sub combos that the Weapon Cycle goes through. Add more pairs on new lines as needed
-- NOTE: if a slot should be empty, use `empty` with no quotation marks. ie: {"Fruit Punches", empty},
WeaponCycle = {
	{"Carnwenhan", "Genmei Shield"},
	{"Naegling", "Genmei Shield"},
	{"Mpu Gandring", "Genmei Shield"},
	--{"Main Slot", "Sub Slot"},
}

-- These are the Main/Sub combos that the Weapon Cycle goes through. Add more pairs on new lines as needed
-- NOTE: if a slot should be empty, use `empty` with no quotation marks. ie: {"Fruit Punches", empty},
DualWieldCycle = {
	{"Carnwenhan", "Gleti's Knife"},
	{"Naegling", "Centovente"},
	{"Naegling", "Gleti's Knife"},
	{"Mpu Gandring", "Centovente"},
	{"Mpu Gandring", "Gleti's Knife"},
	--{"Main Slot", "Sub Slot"},
}

-- These are the Main/Sub combos that get added to the Weapon Cycle while in Abyssea for Procs. Add more pairs on new lines as needed
-- NOTE: if a slot should be empty, use `empty` with no quotation marks. ie: {"Fruit Punches", empty},
AbysseaProcCycle = {
	--{"Main Slot", "Sub Slot"},
}

-------------------------------------------
--               GEAR SETS               --
-------------------------------------------

-- NOTE:	Do not set instruments for songs in these sets (Linos for non-song stats is fine).
--			Instruments are instead set in the Options above.

function get_sets()

-- Idle (Movement Speed, Refresh, Regen, Damage Taken-, Enmity-)
-- NOTE: Do not use weapons in this set or it will override your Weapon Cycle choice every time you disengage.
sets.idle = {
	head="Fili Calot +3",
	body="Ashera Harness",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Fili Cothurnes +3",
	neck="Warder's Charm +1",
	waist="Null Belt",
	left_ear="Eabani Earring",
	right_ear="Fili Earring +2",
	left_ring="Shadow Ring",
	right_ring="Defending Ring",
	back="Null Shawl",
}

-- DT Override (Damage Taken-, Magic Evasion)
-- Will override all other gear sets but still inherit unused slots from them
sets.dt_override = {

}

-- Oh Shit
-- Full DT- and everything you've got with Absorbs or Annuls Damage
sets.oh_shit = {
	head="Bunzi's Hat",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	neck="Warder's Charm +1",
	waist="Null Belt",
	left_ring="Shadow Ring",
	right_ring="Defending Ring",
	back="Shadow Mantle"
}

-- Rest
sets.rest = {

}

-- Melee (Accuracy, Multi Attack, DEX, Store TP, Attack)
sets.melee = {
	range={ name="Linos", augments={'Accuracy+14','"Dbl.Atk."+2','Quadruple Attack +2',}},
	head="Bunzi's Hat",
	body="Ashera Harness",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Bard's Charm +2",
	waist="Reiki Yotai",
	left_ear="Eabani Earring",
	right_ear="Telos Earring",
	left_ring="Chirich Ring +1",
	right_ring="Chirich Ring +1",
	-- left_ring="Petrov Ring",
	-- right_ring="Hetairoi Ring",
	back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

-- Weapon Skill - Basic (STR, Weapon Skill Damage, Attack, Multi Attack)
sets.weapon_skill = {
	range={ name="Linos", augments={'Attack+13','Weapon skill damage +2%','STR+8',}},
	head="Nyame Helm",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Rep. Plat. Medal",
	waist="Sailfi Belt +1",
	left_ear="Moonshade Earring",
	right_ear="Ishvara Earring",
	left_ring="Karieyh Ring +1",
	right_ring="Cornelia's Ring",
	back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}

-- Savage Blade (50% STR, 50% MND mod)
-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
sets["Savage Blade"] = set_combine(sets.weapon_skill, {

})

-- Evisceration (combines with Weapon Skill set above)
sets["Evisceration"] = set_combine(sets.weapon_skill, {
	neck="Fotia Gorget",
	waist="Fotia Belt",
	right_ear="Mache Earring +1",
	left_ring="Ilabrat Ring",
})

-- Mordant Rime (combines with Weapon Skill set above)
sets["Mordant Rime"] = set_combine(sets.weapon_skill, {

})

-- Aeolian Edge (combines with Weapon Skill set above)
sets["Aeolian Edge"] = set_combine(sets.weapon_skill, {

})

-- Exenterator (combines with Weapon Skill set above)
sets["Exenterator"] = set_combine(sets.weapon_skill, {

})

-- Rudra's Storm (combines with Weapon Skill set above)
sets["Rudra's Storm"] = set_combine(sets.weapon_skill, {
	right_ear="Mache Earring +1",
	left_ring="Ilabrat Ring",
})

-- Songs Fast Cast (cap is 80%)
sets.fast_cast_song = {
	head="Fili Calot +3",
	body="Inyanga Jubbah +2",
	hands="Leyline Gloves",
	legs="Volte Brais",
	feet="Fili Cothurnes +3",
	neck="Baetyl Pendant",
	waist="Embla Sash",
	left_ear="Etiolation Earring",
	right_ear="Loquac. Earring",
	left_ring="Kishar Ring",
	right_ring="Prolix Ring",
	back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
}

-- Non-Song Fast Cast (cap is 80%)
sets.fast_cast_other = set_combine(sets.fast_cast_song, {
	head="Bunzi's Hat",
})

-- Song Buffs
-- NOTE: Do not set your main/sub here, set them in the sets below
sets.buff_song = {
	head="Fili Calot +3",
	body="Fili Hongreline +3",
	hands="Fili Manchettes +3",
	legs="Inyanga Shalwar +2",
	feet="Brioso Slippers +3",
	neck="Mnbw. Whistle +1",
}

-- Song Buffs - Main/Sub Dual Wield
-- NOTE: Only set Main and Sub slots here. Will only be equipped if NiTro is up or you are NOT engaged.
sets.buff_song_dual_wield =  {
	main="Carnwenhan",
	sub="Kali",
}

-- Song Buffs - Main/Sub Single Wield
-- NOTE: Only set Main and Sub slots here. Will only be equipped if NiTro is up or you are NOT engaged.
sets.buff_song_single_wield = {
	main="Carnwenhan",
	sub="Genmei Shield",
}

-- Ballads
sets.ballad = set_combine(sets.buff_song, {

})

-- Carols
sets.carol = set_combine(sets.buff_song, {
	hands="Mousai Gages +1",
})

-- Etudes
sets.etude = set_combine(sets.buff_song, {
	head="Mousai Turban +1",
})

-- Madrigals
sets.madrigal = set_combine(sets.buff_song, {
	feet="Fili Cothurnes +3",
	back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
})

-- Mambos
sets.mambo = set_combine(sets.buff_song, {

})

-- Marches
sets.march = set_combine(sets.buff_song, {

})

-- Minnes
sets.minne = set_combine(sets.buff_song, {
	legs="Mou. Seraweels +1",
})

-- Minuets
sets.minuet = set_combine(sets.buff_song, {

})

-- Paeons
sets.paeon = set_combine(sets.buff_song, {
	head="Brioso Roundlet +3",
})

-- Preludes
sets.prelude = set_combine(sets.buff_song, {
	feet="Fili Cothurnes +3",
	back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
})

-- Scherzos
sets.scherzo = set_combine(sets.buff_song, {
	feet="Fili Cothurnes +3",
})

-- Non-Song Buffs (Conserve MP)
sets.buff_other = {
	head="Vanya Hood",
	hands="Shrieker's Cuffs",
	legs="Vanya Slops",
	left_ear="Calamitous Earring",
	right_ear="Mendi. Earring",
	back="Solemnity Cape",
}

-- Song Debuffs
-- NOTE: Do not set your main/sub here, set them in the sets below
sets.debuff_song = {
	head="Brioso Roundlet +3",
	body="Fili Hongreline +3",
	hands="Fili Manchettes +3",
	legs="Inyanga Shalwar +2",
	feet="Brioso Slippers +3",
	neck="Mnbw. Whistle +1",
	waist="Null Belt",
	left_ear="Regal Earring",
	right_ear="Fili Earring +2",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back="Null Shawl",
}

-- Song Debuffs - Main/Sub Dual Wield
-- NOTE: Only set Main and Sub slots here. Will only be equipped if NiTro is up or you are NOT engaged.
sets.debuff_song_dual_wield =  {
	main="Carnwenhan",
	sub="Kali",
}

-- Song Debuffs - Main/Sub Single Wield
-- NOTE: Only set Main and Sub slots here. Will only be equipped if NiTro is up or you are NOT engaged.
sets.debuff_song_single_wield = {
	main="Carnwenhan",
	sub="Genmei Shield",
}

-- Threnodies
sets.threnody = set_combine(sets.debuff_song, {
	body="Mou. Manteel +1",
})

-- Lullaby (Foe Lullaby I & II, and Horde Lullaby I)
sets.lullaby = set_combine(sets.debuff_song, {
	hands="Brioso Cuffs +2",
})

-- Horde Lullaby II (String skill tiers: 6'=486, 7'=567)
-- NOTE: Do not set your main/sub here, set them in the sets below
sets.horde_lullaby_II = set_combine(sets.debuff_song, {
	body="Brioso Justau. +3",
	feet="Bihu Slippers +3",
	waist="Harfner's Sash",
	left_ear="Gersemi Earring",
})

-- Horde Lullaby II - Main/Sub Dual Wield (In case you want to equip Kali with the String skill augment to hit a Horde Lullaby II tier, leave the set empty otherwise)
-- NOTE: Only set Main and Sub slots here. Will only be equipped if NiTro is up or you are NOT engaged.
sets.horde_lullaby_II_dual_wield =  {

}

-- Horde Lullaby II - Main/Sub Single Wield (In case you want to equip Kali with the String skill augment to hit a Horde Lullaby II tier, leave the set empty otherwise)
-- NOTE: Only set Main and Sub slots here. Will only be equipped if NiTro is up or you are NOT engaged.
sets.horde_lullaby_II_single_wield = {

}

-- Non-Song Magic Accuracy
sets.magic_accuracy = {
	head="Brioso Roundlet +3",
	body="Fili Hongreline +3",
	hands="Fili Manchettes +3",
	legs="Fili Rhingrave +3",
	feet="Fili Cothurnes +3",
	neck="Null Loop",
	waist="Null Belt",
	left_ear="Regal Earring",
	right_ear="Fili Earring +2",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back="Null Shawl",
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
	left_ear="Regal Earring",
	right_ear="Mendi. Earring", --5
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back="Solemnity Cape", --7
}

-- Enfeeble (Enfeebling Magic Skill)
-- Combines with Magic Accuracy set, only necessary to set the slots with specific desired stats
sets.enfeeble = set_combine(sets.magic_accuracy, {
	left_ring="Kishar Ring",
})

-- Refresh (Refresh augmenting gear, not Refresh+)
sets.refresh = {
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
	left_ring="Haoma's Ring",
	right_ring="Haoma's Ring",
}

-- Soul Voice (Enhances Soul Voice gear)
sets.soul_voice = {
	legs="Bihu Cannions",
}

-- Nightingale (Enhances Nightingale gear)
sets.nightingale = {
	feet="Bihu Slippers +3",
}

-- Troubadour (Enhances Troubadour gear)
sets.troubadour = {
	body="Bihu Justaucorps",
}

-- Steps (physical accuracy)
sets.steps = {
	head="Fili Calot +3",
	body="Fili Hongreline +3",
	hands="Fili Manchettes +3",
	legs="Fili Rhingrave +3",
	feet="Fili Cothurnes +3",
	neck="Null Loop",
	waist="Null Belt",
	left_ear="Digni. Earring",
	right_ear="Fili Earring +2",
	left_ring="Chirich Ring +1",
	right_ring="Chirich Ring +1",
	back="Null Shawl",
}

-- Waltzes
sets.waltzes = {
	range={ name="Linos", augments={'Mag. Evasion+14','"Waltz" potency +3%',}},
	legs="Dashing Subligar",
	left_ring="Valseur's Ring",
}

-- Animated Flourish
sets.animated_flourish = {

}

-- Violent Flourish
sets.violent_flourish = {

}

-- Holy Water (Holy Water+)
sets.holy_water = {
	neck="Nicander's Necklace",
	left_ring="Blenmot's Ring +1",
	right_ring="Blenmot's Ring +1",
}

-- Default Town Gear (Put all your fancy-pants gear in here you want to showboat around town. Does not lockstyle this gear, only equips)
sets.town = set_combine(sets.idle, {
	range="Loughnashade",
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




FileVersion = '1.2.2'

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
NotiLowMPToggle = 'Off' --start with the toggle off for the Low MP Notification so that it can trigger
DTOverride = "Off" --Start with the Damage Taken Override off
RRRCountdown = RRReminderTimer
HUDposYLine1 = HUDposY
Heartbeat = 0 --set to 0 just to start the Heartbeat running
GreetingDelay = 6 --delay to display greeting and file version info
Zoning = false --flips automatically to hide the HUD while zoning
InCS = false --flips automatically to hide the HUD while in a cs
LowHP = false
Alive = true --makes it easier to Do Things or Not Do Things based on if we die.
announceAlive = false --simple flip when we raise to make sure the AliveDelay command and notification text is only done once
DangerCountdown = 0
NotiCountdown = -1 --we set the countdown below 0 to stop the countdown from hitting 0 and triggering the ClearNotifications command
EquipMain = ''
EquipSub = ''
EquipRange = ''
CurrentInstrument = ''
SwitchingWeapons = 0 --used to delay the Aftermath checks so the Weapon Cycler cycling can be displayed faster in the HUD
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
transport_locked = true
transport_lock_timestamp = 0
current_songs = {}
song_duration = nil
dummy_song = false
soul_voice_song = false
max_songs = 2
jp_gift_bonus_duration = 0
num_lost_songs = 0
missing_song_block = false
set_weapon_timestamp = 0

local play_sound = windower.play_sound
local addon_path = windower.addon_path
local Notification_Good = addon_path..'data/sounds/NotiGood.wav'
local Notification_Bad = addon_path..'data/sounds/NotiBad.wav'
local Notification_Danger = addon_path..'data/sounds/Danger.wav'
local Notification_Cancel = addon_path..'data/sounds/Cancel.wav'
local Notification_Aftermath_On = addon_path..'data/sounds/AftermathOn.wav'
local Notification_Aftermath_Off = addon_path..'data/sounds/AftermathOff.wav'
local Notification_3000TP = addon_path..'data/sounds/3000TP.wav'

--create a new table that combines both the WeaponCycle/DualWieldCycle and AbysseaProcCycle weapons into one table to be used while inside Abyssea
local WeaponCyclePlusAbyssea = {}
for _, v in ipairs(WeaponCycle) do
	table.insert(WeaponCyclePlusAbyssea, {v[1], v[2]})
end
for _, v in ipairs(AbysseaProcCycle) do
	table.insert(WeaponCyclePlusAbyssea, {v[1], v[2]})
end
local DualWieldCyclePlusAbyssea = {}
for _, v in ipairs(DualWieldCycle) do
	table.insert(DualWieldCyclePlusAbyssea, {v[1], v[2]})
end
for _, v in ipairs(AbysseaProcCycle) do
	table.insert(DualWieldCyclePlusAbyssea, {v[1], v[2]})
end

-- Sets the inital subjob
local subjob = 'OTH'
if player.sub_job == 'DNC' then
	subjob = 'DNC'
elseif player.sub_job == 'NIN' then
	subjob = 'NIN'
elseif player.sub_job == 'RDM' then
	subjob = 'RDM'
elseif player.sub_job == 'SCH' then
	subjob = 'SCH'
elseif player.sub_job == 'WHM' then
	subjob = 'WHM'
end

-- Sets the Chat Mode
if Chat ~= "Off" then
	send_command('input /cm '..Chat..'')
end

-- Sets the Macro Book and Page
if Book ~= "Off" then
	send_command('input /macro book '..Book..'')
end
if SubWHMPage ~= "Off" and player.sub_job == 'DNC' then
	send_command('wait 2;input /macro set '..SubDNCPage..'')
elseif SubRDMPage ~= "Off" and player.sub_job == 'NIN' then
	send_command('wait 2;input /macro set '..SubNINPage..'')
elseif SubBLMPage ~= "Off" and player.sub_job == 'RDM' then
	send_command('wait 2;input /macro set '..SubRDMPage..'')
elseif SubSCHPage ~= "Off" and player.sub_job == 'SCH' then
	send_command('wait 2;input /macro set '..SubSCHPage..'')
elseif SubSCHPage ~= "Off" and player.sub_job == 'WHM' then
	send_command('wait 2;input /macro set '..SubWHMPage..'')
else
	send_command('wait 2;input /macro set 1')
end

if ZoneGear ~= 'Off' then
	send_command('wait 2;gs c Zone Gear')
end

SoulVoice = {} ClarionCall = {} Contradance = {} Convert = {} DarkArts = {} DivineSeal = {} FlourishesI = {} FlourishesII = {} Jigs = {} LightArts = {} Marcato = {} Nightingale = {} Pianissimo = {} Sambas = {} Steps = {} Sublimation = {} Tenuto = {} Troubadour = {}

--Start true so the HUD recasts don't flash on load
SoulVoice.flashed = true
ClarionCall.flashed = true
Contradance.flashed = true
Convert.flashed = true
DarkArts.flashed = true
DivineSeal.flashed = true
FlourishesI.flashed = true
FlourishesII.flashed = true
Jigs.flashed = true
LightArts.flashed = true
Marcato.flashed = true
Nightingale.flashed = true
Pianissimo.flashed = true
Sambas.flashed = true
Steps.flashed = true
Sublimation.flashed = true
Tenuto.flashed = true
Troubadour.flashed = true

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

--Create the PT Member Song list text objext
local song_list = texts.new()
song_list:font('Consolas')
song_list:size(SongsFontSize)
song_list:bg_alpha(170)
song_list:pos(SongposX,SongposY)
song_list:draggable(true)

-- Create the HUD BG Color text object
local hud_bg_color = texts.new(hud_bg_str..'\n'..hud_bg_str..'\n'..hud_bg_str..'\n'..hud_bg_str)
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

-- Create the HUD PTMember01 BG text object
local hud_ptmember01_bg = texts.new('            ')
hud_ptmember01_bg:font("Consolas")
hud_ptmember01_bg:size(FontSize)
hud_ptmember01_bg:pad(-1)
hud_ptmember01_bg:bg_color(250,250,250)
hud_ptmember01_bg:bg_alpha(50)
hud_ptmember01_bg:pos(HUDposXColumn1+.5,HUDposYLine3)
hud_ptmember01_bg:draggable(false)
hud_ptmember01_bg:bold(true)

-- Create the HUD PTMember02 BG text object
local hud_ptmember02_bg = texts.new('            ')
hud_ptmember02_bg:font("Consolas")
hud_ptmember02_bg:size(FontSize)
hud_ptmember02_bg:pad(-1)
hud_ptmember02_bg:bg_color(250,250,250)
hud_ptmember02_bg:bg_alpha(0)
hud_ptmember02_bg:pos(HUDposXColumn2+1,HUDposYLine3)
hud_ptmember02_bg:draggable(false)
hud_ptmember02_bg:bold(true)

-- Create the HUD PTMember03 BG text object
local hud_ptmember03_bg = texts.new('            ')
hud_ptmember03_bg:font("Consolas")
hud_ptmember03_bg:size(FontSize)
hud_ptmember03_bg:pad(-1)
hud_ptmember03_bg:bg_color(250,250,250)
hud_ptmember03_bg:bg_alpha(0)
hud_ptmember03_bg:pos(HUDposXColumn3+1,HUDposYLine3)
hud_ptmember03_bg:draggable(false)
hud_ptmember03_bg:bold(true)

-- Create the HUD PTMember04 BG text object
local hud_ptmember04_bg = texts.new('            ')
hud_ptmember04_bg:font("Consolas")
hud_ptmember04_bg:size(FontSize)
hud_ptmember04_bg:pad(-1)
hud_ptmember04_bg:bg_color(250,250,250)
hud_ptmember04_bg:bg_alpha(0)
hud_ptmember04_bg:pos(HUDposXColumn4+1,HUDposYLine3)
hud_ptmember04_bg:draggable(false)
hud_ptmember04_bg:bold(true)

-- Create the HUD PTMember05 BG text object
local hud_ptmember05_bg = texts.new('            ')
hud_ptmember05_bg:font("Consolas")
hud_ptmember05_bg:size(FontSize)
hud_ptmember05_bg:pad(-1)
hud_ptmember05_bg:bg_color(250,250,250)
hud_ptmember05_bg:bg_alpha(0)
hud_ptmember05_bg:pos(HUDposXColumn5+1,HUDposYLine3)
hud_ptmember05_bg:draggable(false)
hud_ptmember05_bg:bold(true)

-- Create the HUD PTMember06 BG text object
local hud_ptmember06_bg = texts.new('            ')
hud_ptmember06_bg:font("Consolas")
hud_ptmember06_bg:size(FontSize)
hud_ptmember06_bg:pad(-1)
hud_ptmember06_bg:bg_color(250,250,250)
hud_ptmember06_bg:bg_alpha(0)
hud_ptmember06_bg:pos(HUDposXColumn6+1,HUDposYLine3)
hud_ptmember06_bg:draggable(false)
hud_ptmember06_bg:bold(true)

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
local hud_mode_shdw = texts.new('Mode: '..modeName[Mode]..' ('..EquipRange..')')
hud_mode_shdw:color(0,0,0)
hud_mode_shdw:font("Consolas")
hud_mode_shdw:size(FontSize)
hud_mode_shdw:bg_alpha(0)
hud_mode_shdw:pos(HUDposXColumn1+2.5,HUDposYLine2+0.5)
hud_mode_shdw:draggable(false)
hud_mode_shdw:bold(true)

-- Create the HUD Notifications Text Shadow text object
local hud_noti_shdw = texts.new('Keys BRD Gearswap file v'..FileVersion)
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

-- Create the HUD PTMember01 Text Shadow text object
local hud_ptmember01_shdw = texts.new()
hud_ptmember01_shdw:color(0,0,0)
hud_ptmember01_shdw:font("Consolas")
hud_ptmember01_shdw:size(FontSize)
hud_ptmember01_shdw:bg_alpha(0)
hud_ptmember01_shdw:pos(HUDposXColumn1+1.5,HUDposYLine3-0.5)
hud_ptmember01_shdw:draggable(false)
hud_ptmember01_shdw:bold(true)

-- Create the HUD PTMember02 Text Shadow text object
local hud_ptmember02_shdw = texts.new()
hud_ptmember02_shdw:color(0,0,0)
hud_ptmember02_shdw:font("Consolas")
hud_ptmember02_shdw:size(FontSize)
hud_ptmember02_shdw:bg_alpha(0)
hud_ptmember02_shdw:pos(HUDposXColumn2+1.5,HUDposYLine3-0.5)
hud_ptmember02_shdw:draggable(false)
hud_ptmember02_shdw:bold(true)

-- Create the HUD PTMember03 Text Shadow text object
local hud_ptmember03_shdw = texts.new()
hud_ptmember03_shdw:color(0,0,0)
hud_ptmember03_shdw:font("Consolas")
hud_ptmember03_shdw:size(FontSize)
hud_ptmember03_shdw:bg_alpha(0)
hud_ptmember03_shdw:pos(HUDposXColumn3+1.5,HUDposYLine3-0.5)
hud_ptmember03_shdw:draggable(false)
hud_ptmember03_shdw:bold(true)

-- Create the HUD PTMember04 Text Shadow text object
local hud_ptmember04_shdw = texts.new()
hud_ptmember04_shdw:color(0,0,0)
hud_ptmember04_shdw:font("Consolas")
hud_ptmember04_shdw:size(FontSize)
hud_ptmember04_shdw:bg_alpha(0)
hud_ptmember04_shdw:pos(HUDposXColumn4+1.5,HUDposYLine3-0.5)
hud_ptmember04_shdw:draggable(false)
hud_ptmember04_shdw:bold(true)

-- Create the HUD PTMember05 Text Shadow text object
local hud_ptmember05_shdw = texts.new()
hud_ptmember05_shdw:color(0,0,0)
hud_ptmember05_shdw:font("Consolas")
hud_ptmember05_shdw:size(FontSize)
hud_ptmember05_shdw:bg_alpha(0)
hud_ptmember05_shdw:pos(HUDposXColumn5+1.5,HUDposYLine3-0.5)
hud_ptmember05_shdw:draggable(false)
hud_ptmember05_shdw:bold(true)

-- Create the HUD PTMember06 Text Shadow text object
local hud_ptmember06_shdw = texts.new()
hud_ptmember06_shdw:color(0,0,0)
hud_ptmember06_shdw:font("Consolas")
hud_ptmember06_shdw:size(FontSize)
hud_ptmember06_shdw:bg_alpha(0)
hud_ptmember06_shdw:pos(HUDposXColumn6+1.5,HUDposYLine3-0.5)
hud_ptmember06_shdw:draggable(false)
hud_ptmember06_shdw:bold(true)

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
local hud_mode = texts.new('Mode: '..modeName[Mode]..' ('..EquipRange..')')
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
local hud_noti = texts.new('Keys BRD Gearswap file v'..FileVersion)
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

-- Create the HUD PTMember01 text object
local hud_ptmember01 = texts.new('')
hud_ptmember01:font("Consolas")
hud_ptmember01:size(FontSize)
hud_ptmember01:bg_alpha(0)
hud_ptmember01:pos(HUDposXColumn1,HUDposYLine3-2)
hud_ptmember01:draggable(false)
hud_ptmember01:bold(true)

-- Create the HUD PTMember02 text object
local hud_ptmember02 = texts.new('')
hud_ptmember02:font("Consolas")
hud_ptmember02:size(FontSize)
hud_ptmember02:bg_alpha(0)
hud_ptmember02:pos(HUDposXColumn2,HUDposYLine3-2)
hud_ptmember02:draggable(false)
hud_ptmember02:bold(true)

-- Create the HUD PTMember03 text object
local hud_ptmember03 = texts.new('')
hud_ptmember03:font("Consolas")
hud_ptmember03:size(FontSize)
hud_ptmember03:bg_alpha(0)
hud_ptmember03:pos(HUDposXColumn3,HUDposYLine3-2)
hud_ptmember03:draggable(false)
hud_ptmember03:bold(true)

-- Create the HUD PTMember04 text object
local hud_ptmember04 = texts.new('')
hud_ptmember04:font("Consolas")
hud_ptmember04:size(FontSize)
hud_ptmember04:bg_alpha(0)
hud_ptmember04:pos(HUDposXColumn4,HUDposYLine3-2)
hud_ptmember04:draggable(false)
hud_ptmember04:bold(true)

-- Create the HUD PTMember05 text object
local hud_ptmember05 = texts.new('')
hud_ptmember05:font("Consolas")
hud_ptmember05:size(FontSize)
hud_ptmember05:bg_alpha(0)
hud_ptmember05:pos(HUDposXColumn5,HUDposYLine3-2)
hud_ptmember05:draggable(false)
hud_ptmember05:bold(true)

-- Create the HUD PTMember06 text object
local hud_ptmember06 = texts.new('')
hud_ptmember06:font("Consolas")
hud_ptmember06:size(FontSize)
hud_ptmember06:bg_alpha(0)
hud_ptmember06:pos(HUDposXColumn6,HUDposYLine3-2)
hud_ptmember06:draggable(false)
hud_ptmember06:bold(true)

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
	if ShowTPMeter == 'On' then
		hud_tp_meter_bg1:show()
		hud_tp_meter_bg2:show()
		hud_tp_meter:show()
	end
	hud_noti_bg:show()
	hud_debuffs_bg:show()
	hud_ptmember01_bg:show()
	hud_ptmember02_bg:show()
	hud_ptmember03_bg:show()
	hud_ptmember04_bg:show()
	hud_ptmember05_bg:show()
	hud_ptmember06_bg:show()
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
	hud_ptmember01_shdw:show()
	hud_ptmember02_shdw:show()
	hud_ptmember03_shdw:show()
	hud_ptmember04_shdw:show()
	hud_ptmember05_shdw:show()
	hud_ptmember06_shdw:show()
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
	hud_ptmember01:show()
	hud_ptmember02:show()
	hud_ptmember03:show()
	hud_ptmember04:show()
	hud_ptmember05:show()
	hud_ptmember06:show()
	hud_abil01:show()
	hud_abil02:show()
	hud_abil03:show()
	hud_abil04:show()
	hud_abil05:show()
	hud_abil06:show()
end
if ShowSongs == 'On' then
	song_list:show()
end

-------------------------------------------
--            CUSTOM ALIASES             --
-------------------------------------------

send_command('alias dt gs c DT') --creates the DT Override alias
send_command('alias mode gs c Mode') --creates the Mode alias
send_command('alias wc gs c WC') --creates the Weapon Cycle alias
send_command('alias hud gs c HUD') --creates the HUD alias
send_command('alias songs gs c Songs') --creates the Song List alias
send_command('bind '..DTBind..' gs c DT') --creates the DT Override keyboard shortcut
send_command('bind '..ModeBind..' gs c Mode') --creates the gear mode keyboard shortcut
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
				formattedNumber = formattedNumber:sub(1, insertIndex)..","..formattedNumber:sub(insertIndex + 1)
				insertIndex = insertIndex + 4
				length = length + 1
			end
		end
	end

	-- Return the number (albeit as a string, we're not doing any math on it at this point)
    return formattedNumber
end

--Check if we have access to dual wield
local function hasDualWield()
	if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
		return true
	else
		return false
	end
end

--Check if our subjob has MP
local function subJobWithMP()
	if player.sub_job == 'WHM' or player.sub_job == 'BLM' or player.sub_job == 'RDM' or player.sub_job == 'PLD' or player.sub_job == 'DRK' or player.sub_job == 'SMN' or player.sub_job == 'BLU' or player.sub_job == 'SCH' or player.sub_job == 'GEO' or player.sub_job == 'RUN' then
		return true
	else
		return false
	end
end

--Set the initial main/sub weapon pair
local function setWeaponPair()
	WeaponCycleIndex = 1 --used to cycle through the WeaponCycle sets
	if string.find(world.area,'Abyssea') then --if inside Abyssea use the combined table
		if hasDualWield() then
			pair = DualWieldCyclePlusAbyssea[WeaponCycleIndex]
		else
			pair = WeaponCyclePlusAbyssea[WeaponCycleIndex]
		end
	else --otherwise, use just the basic WeaponCycle table
		if hasDualWield() then
			pair = DualWieldCycle[WeaponCycleIndex]
		else
			pair = WeaponCycle[WeaponCycleIndex]
		end
	end
end
setWeaponPair()

--Check if the equipped Main/Sub pair are in our defined AbysseaProcCycle weapons table
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

	SoulVoice.recast = ability_recast[0] and math.floor(ability_recast[0]) or nil
	ClarionCall.recast = ability_recast[254] and math.floor(ability_recast[254]) or 0
	Contradance.recast = ability_recast[229] and math.floor(ability_recast[229]) or nil
	Convert.recast = ability_recast[49] and math.floor(ability_recast[49]) or nil
	DarkArts.recast = ability_recast[232] and math.floor(ability_recast[232]) or nil
	DivineSeal.recast = ability_recast[26] and math.floor(ability_recast[26]) or nil
	FlourishesI.recast = ability_recast[221] and math.floor(ability_recast[221]) or nil
	FlourishesII.recast = ability_recast[222] and math.floor(ability_recast[222]) or nil
	Jigs.recast = ability_recast[218] and math.floor(ability_recast[218]) or nil
	LightArts.recast = ability_recast[228] and math.floor(ability_recast[228]) or nil
	Marcato.recast = ability_recast[48] and math.floor(ability_recast[48]) or nil
	Nightingale.recast = ability_recast[109] and math.floor(ability_recast[109]) or nil
	Pianissimo.recast = ability_recast[112] and math.floor(ability_recast[112]) or nil
	Sambas.recast = ability_recast[216] and math.floor(ability_recast[216]) or nil
	Steps.recast = ability_recast[220] and math.floor(ability_recast[220]) or nil
	Sublimation.recast = ability_recast[234] and math.floor(ability_recast[234]) or nil
	Tenuto.recast = ability_recast[47] and math.floor(ability_recast[47]) or nil
	Troubadour.recast = ability_recast[110] and math.floor(ability_recast[110]) or nil

end
getRecasts()

-- Format abilities/spells to fit into their allotted 12 spaces
local function formatAbils(input,input_sh)

	-- Valid abilities/spells
	local validAbilities = {
		"Soul Voice", "Clarion Call", "Contradance", "Convert", "Dark Arts", "Divine Seal", "Flourishes I", "Flourishes II", "Jigs", "Light Arts", "Marcato", "Nightingale", "Pianissimo", "Sambas", "Steps", "Sublimation", "Tenuto", "Troubadour"
	}

	local ab = {} ab['Soul Voice'] = SoulVoice ab['Clarion Call'] = ClarionCall ab['Contradance'] = Contradance ab['Convert'] = Convert ab['Dark Arts'] = DarkArts ab['Divine Seal'] = DivineSeal ab['Flourishes I'] = FlourishesI ab['Flourishes II'] = FlourishesII ab['Jigs'] = Jigs ab['Light Arts'] = LightArts ab['Marcato'] = Marcato ab['Nightingale'] = Nightingale ab['Pianissimo'] = Pianissimo ab['Sambas'] = Sambas ab['Steps'] = Steps ab['Sublimation'] = Sublimation ab['Tenuto'] = Tenuto ab['Troubadour'] = Troubadour
	
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

-- Format PT Member names to fit into their allotted 12 spaces
local function formatName(input)

	local function getNumberOfSongs(player)
		--Check if the player exists in the current_songs table
		if current_songs[player] then
			local song_count = 0
			--Count the number of songs the player has
			for _ in pairs(current_songs[player]) do
				song_count = song_count + 1
			end
			return song_count
		else
			--If the player doesn't exist in the table, return 0
			return 0
		end
	end
	
	-- Maximum length of output without parenthesis
	local maxLength = 10

	-- Number of songs player currently has active
	local numSongs = input and getNumberOfSongs(input.name) or 0

	-- Determine length to fit the recast timer
	local truncatedLength = maxLength
	if numSongs > 0 then
		truncatedLength = truncatedLength - 2
	end

	-- Is there a party member in this party slot?
	local startingString = input and input.name or '  ----  '

	-- Truncate if too long
	local truncatedString = string.sub(startingString, 1, truncatedLength)

	-- Get our output before we apply the parenthesis below
	local formattedString = truncatedString
	if numSongs >= 3 then
		formattedString = formattedString..'♫'..numSongs
	elseif numSongs > 0 then
		formattedString = formattedString..'♪'..numSongs
	end

	-- Determine padding needed to center the output
	local paddingTotalLength = maxLength - (numSongs > 0 and #formattedString-2 or #formattedString)
	local leftPaddingLength = math.floor(paddingTotalLength / 2)
	local leftPadding = string.rep(" ", leftPaddingLength)
	local rightPaddingLength = paddingTotalLength - leftPaddingLength
	local rightPadding = string.rep(" ", rightPaddingLength)

	-- Apply parenthesis with padding
	formattedString = leftPadding..'('..formattedString..')'..rightPadding

	return formattedString

end

local function getNameColor(input)

	local function getLowestSongDuration(player)
		-- Check if the player exists in the current_songs table
		if current_songs[player] then
			local lowest_duration = nil
			-- Iterate through the player's songs to find the one with the lowest duration
			for _, song_data in pairs(current_songs[player]) do
				local duration = song_data.duration
				if lowest_duration == nil or duration < lowest_duration then
					lowest_duration = duration
				end
			end
			return lowest_duration
		else
			-- If the player doesn't exist in the table, return nil (indicating no songs)
			return nil
		end
	end
	
	local lowestDuration = input and getLowestSongDuration(input) or nil
	local color = "none"

	if lowestDuration then
		if lowestDuration <= 60 then
			color = "critical"
		elseif lowestDuration <= 120 then
			color = "low"
		elseif lowestDuration <= 300 then
			color = "regular"
		elseif lowestDuration <= 600 then
			color = "long"
		else
			color = "very_long"
		end
	end

	return color

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
		pre_AMTimer = 120
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

	if primeMatch(21588) then --stage 3 Prime
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
	elseif primeMatch(21588) then --stage 4 Prime
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
	elseif primeMatch(21590) then --stage 5 Prime
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

local function itemMatch(input,slot)
	local locations = {"inventory", "wardrobe", "wardrobe2", "wardrobe3", "wardrobe4", "wardrobe5", "wardrobe6", "wardrobe7", "wardrobe8"}
	for _, location in ipairs(locations) do
		local weapon_id = windower.ffxi.get_items()[location][windower.ffxi.get_items().equipment[slot]].id
		if weapon_id == input then
			return true --match found
		end
	end
	return false --no match found
end

local function getJPGiftBonusDuration()
	local player = windower.ffxi.get_player()
	if player and player.job_points.brd.jp_spent >= 1200 then
		jp_gift_bonus_duration = .05
	end
end
getJPGiftBonusDuration()

local function getSongDuration(spell)

	song_duration = nil
	local multiplier = 1

	--1200 job point gift duration nonus
	multiplier = multiplier + jp_gift_bonus_duration

	--weapons
	if player.equipment.main == "Legato Dagger" or player.equipment.sub == "Legato Dagger" then
		multiplier = multiplier + .05
	end
	if player.equipment.main == "Kali" or player.equipment.sub == "Kali" then
		multiplier = multiplier + .05
	end
	if player.equipment.main == "Carnwenhan" then
		if itemMatch(20586,'main') or itemMatch(20562,'main') or itemMatch(20561,'main') or itemMatch(19957,'main') or itemMatch(19828,'main') then --99
			multiplier = multiplier + .5
		elseif itemMatch(19719,'main') then --95
			multiplier = multiplier + .4
		elseif itemMatch(19621,'main') then --90
			multiplier = multiplier + .4
		elseif itemMatch(19089,'main') then --85
			multiplier = multiplier + .3
		elseif itemMatch(19069,'main') then --80
			multiplier = multiplier + .2
		elseif itemMatch(19000,'main') then --75 (complete)
			multiplier = multiplier + .1
		end
	end

	--"all songs" instruments
	if player.equipment.range == 'Daurdabla' then
		if itemMatch(18571,'range') or itemMatch(18839,'range') then --99
			multiplier = multiplier + .3
		elseif itemMatch(18576,'range') then --95
			multiplier = multiplier + .3
		elseif itemMatch(18575,'range') then --90
			multiplier = multiplier + .25
		end
	elseif player.equipment.range == "Gjallarhorn" then
		if itemMatch(18840,'range') or itemMatch(18572,'range') then --99
			multiplier = multiplier + .4
		elseif itemMatch(18580,'range') or itemMatch(18579,'range') then --95/90
			multiplier = multiplier + .3
		elseif itemMatch(18578,'range') or itemMatch(18577,'range') or itemMatch(18342,'range') then --85/80/75
			multiplier = multiplier + .2
		end
	elseif player.equipment.range == "Marsyas" then
		multiplier = multiplier + .5
	elseif player.equipment.range == "Loughnashade" then
		if itemMatch(22307,'range') then --stage 5
			multiplier = multiplier + .4
		elseif itemMatch(22306,'range') then --stage 4
			multiplier = multiplier + .3
		elseif itemMatch(22305,'range') then --stage 3
			multiplier = multiplier + .2
		end
	elseif player.equipment.range == "Linos" then
		multiplier = multiplier + .1
	elseif player.equipment.range == "Blurred Harp" then
		multiplier = multiplier + .1
	elseif player.equipment.range == "Blurred Harp +1" then
		multiplier = multiplier + .2
	elseif player.equipment.range == "Eminent Flute" then
		multiplier = multiplier + .2
	end	

	--body
	if player.equipment.body == "Aoidos' Hngrln. +1" then
		multiplier = multiplier + .05
	elseif player.equipment.body == "Aoidos' Hngrln. +2" then
		multiplier = multiplier + .1
	elseif player.equipment.body == "Fili Hongreline" then
		multiplier = multiplier + .11
	elseif player.equipment.body == "Fili Hongreline +1" then
		multiplier = multiplier + .12
	elseif player.equipment.body == "Fili Hongreline +2" then
		multiplier = multiplier + .13
	elseif player.equipment.body == "Fili Hongreline +3" then
		multiplier = multiplier + .14
	end

	--legs
	if player.equipment.legs == "Mdk. Shalwar +1" then
		multiplier = multiplier + .1
	elseif player.equipment.legs == "Inyanga Shalwar" then
		multiplier = multiplier + .12
	elseif player.equipment.legs == "Inyanga Shalwar +1" then
		multiplier = multiplier + .15
	elseif player.equipment.legs == "Inyanga Shalwar +2" then
		multiplier = multiplier + .17
	end

	--feet
	if player.equipment.feet == "Brioso Slippers" then
		multiplier = multiplier + .1
	elseif player.equipment.feet == "Brioso Slippers +1" then
		multiplier = multiplier + .11
	elseif player.equipment.feet == "Brioso Slippers +2" then
		multiplier = multiplier + .13
	elseif player.equipment.feet == "Brioso Slippers +3" or player.equipment.feet == "Brioso Slippers +4" then
		multiplier = multiplier + .15
	end

	--neck
	if player.equipment.neck == "Aoidos' Matinee" or player.equipment.neck == "Brioso Whistle" then
		multiplier = multiplier + .1
	elseif player.equipment.neck == "Moonbow Whistle" then
		multiplier = multiplier + .2
	elseif player.equipment.neck == "Mnbw. Whistle +1" then
		multiplier = multiplier + .3
	end

	--specific song bonus gear
	if string.find(spell,'Ballad') then
		if player.equipment.legs == "Aoidos' Rhing. +2" or player.equipment.legs == "Fili Rhingrave" or player.equipment.legs == "Fili Rhingrave +1" or player.equipment.legs == "Fili Rhingrave +2" or player.equipment.legs == "Fili Rhingrave +3" then
			multiplier = multiplier + .1
		end
	elseif string.find(spell,'Carol') then
		if player.equipment.hands == "Mousai Gages" then
			multiplier = multiplier + .1	
		elseif player.equipment.hands == "Mousai Gages +1" then
			multiplier = multiplier + .2
		end
	elseif string.find(spell,'Etude') then
		if player.equipment.head == "Mousai Turban" then
			multiplier = multiplier + .1	
		elseif player.equipment.head == "Mousai Turban +1" then
			multiplier = multiplier + .2
		end
	elseif string.find(spell,'Madrigal') then
		if player.equipment.head == "Aoidos' Calot +2" or player.equipment.head == "Fili Calot" or player.equipment.head == "Fili Calot +1" or player.equipment.head == "Fili Calot +2" or player.equipment.head == "Fili Calot +3" then
			multiplier = multiplier + .1
		end
		if player.equipment.back == "Intarabus's Cape" then
			multiplier = multiplier + .1
		end
	elseif string.find(spell,'Mambo') then
		if player.equipment.legs == "Mousai Crackows" then
			multiplier = multiplier + .1	
		elseif player.equipment.legs == "Mou. Crackows +1" then
			multiplier = multiplier + .2
		end
	elseif string.find(spell,'March') then
		if player.equipment.hands == "Ad. Mnchtte. +2" or player.equipment.hands == "Fili Manchettes" or player.equipment.hands == "Fili Manchettes +1" or player.equipment.hands == "Fili Manchettes +2" or player.equipment.hands == "Fili Manchettes +3" then
			multiplier = multiplier + .1
		end
	elseif string.find(spell,'Minne') then
		if player.equipment.legs == "Mousai Seraweels" then
			multiplier = multiplier + .1	
		elseif player.equipment.legs == "Mou. Seraweels +1" then
			multiplier = multiplier + .2
		end
	elseif string.find(spell,'Minuet') then
		if player.equipment.body == "Aoidos' Hngrln. +2" or player.equipment.body == "Fili Hongreline" or player.equipment.body == "Fili Hongreline +1" or player.equipment.body == "Fili Hongreline +2" or player.equipment.body == "Fili Hongreline +3" then
			multiplier = multiplier + .1
		end
	elseif string.find(spell,'Paeon') then
		if player.equipment.head == "Brioso Roundlet" or player.equipment.head == "Brioso Roundlet +1" or player.equipment.head == "Brioso Roundlet +2" then
			multiplier = multiplier + .1
		elseif player.equipment.head == "Brioso Roundlet +3" or player.equipment.head == "Brioso Roundlet +4" then
			multiplier = multiplier + .2
		end
	elseif spell == "Sentinel's Scherzo" then
		if player.equipment.feet == "Aoidos' Cothrn. +2" or player.equipment.feet == "Fili Cothurnes" or player.equipment.feet == "Fili Cothurnes +1" or player.equipment.feet == "Fili Cothurnes +2" or player.equipment.feet == "Fili Cothurnes +3" then
			multiplier = multiplier + 0.1
		end
		--For Scherzo, Soul Voice and Marcato are multiplicative with Troubadour below
		if buffactive['Soul Voice'] then
			multiplier = multiplier * 2
		elseif buffactive['Marcato'] then
			multiplier = multiplier * 1.5
		end
	end

	--base duration is multiplied by the total multiplier number we get from all relevant gear combined.
	local total_duration = math.floor(120 * multiplier)

	--Troubadour doubles duration after all other bonuses are applied
	if buffactive['Troubadour'] then
		total_duration = total_duration * 2
	end

	--Again we make the assumption that if you are 99 then you are mastered and have the Clarion Call 40 second song duration bonus
	if player.main_job_level == 99 and buffactive['Clarion Call'] then
		total_duration = total_duration + 40
	end

	return total_duration
end

--Are we using a dummy instrument and not one for full strength songs?
local function isDummySong()

	local is_dummy_song = false

	if player.equipment.range == "Daurdabla" or player.equipment.range == "Blurred Harp" or player.equipment.range == "Blurred Harp +1" or player.equipment.range == "Terpander" then
		is_dummy_song = true
	end

	return is_dummy_song

end

local function getMaxSongs()
	max_songs = 2

	if player.equipment.range == "Daurdabla" then
		if itemMatch(18571,'range') or itemMatch(18839,'range') then --99
			max_songs = max_songs + 2
		else
			max_songs = max_songs + 1
		end
	elseif player.equipment.range == "Loughnashade" then
		if itemMatch(22307,'range') then --stage 5
			max_songs = max_songs + 2
		elseif itemMatch(22306,'range') then --stage 4
			max_songs = max_songs + 1
		end
	elseif player.equipment.range == "Blurred Harp" or player.equipment.range == "Blurred Harp +1" or player.equipment.range == "Terpander" then
		max_songs = max_songs + 1
	end

	if buffactive['Clarion Call'] then
		max_songs = max_songs + 1
	end

	return max_songs
end

--Create the song list to be displayed on the screen for tracking
local function getCurrentSongList()
	local formatted_list = "[SONG LIST         //songs]\n" --longest song name is 18 characters, plus formatting makes 27 char width

	-- Retrieve the party list
	local party = windower.ffxi.get_party()
	local party_order = {}

	--Store party members' names based on their position
	for i = 0, 5 do
		local position = 'p'..i
		if party[position] and party[position].name then
			table.insert(party_order, party[position].name)
		end
	end

	--Iterate over the party_order to ensure the correct order in the Song List
	for _, player_name in ipairs(party_order) do
		if current_songs[player_name] then
			
			--Format RGB values with leading zeros (helps prevent an issue with the text not lining up correctly after color is added)
			local function formatRGB(value)
				return string.format("%03d", value)
			end

			local cn = color.song_list[getNameColor(player_name)] or color.song.none
			local l_padding = math.floor((27 - #player_name) / 2)
			local r_padding = 27 - #player_name - l_padding
			local l_spaces = ""
			local r_spaces = ""
			while string.len(l_spaces) < l_padding do
				l_spaces = l_spaces..'-'
			end
			while string.len(r_spaces) < r_padding do
				r_spaces = r_spaces..'-'
			end
			formatted_list = formatted_list..l_spaces.."\\cs("..formatRGB(cn.r)..","..formatRGB(cn.g)..","..formatRGB(cn.b)..")"..player_name.."\\cr"..r_spaces.."\n"

			local song_list = {}
			for song_name, song_data in pairs(current_songs[player_name]) do
				table.insert(song_list, {name = song_name, duration = song_data.duration, dummy = song_data.dummy, soul_voice = song_data.soul_voice})
			end

			--Sort the song list by duration in descending order (longest first)
			table.sort(song_list, function(a, b)
				return a.duration > b.duration
			end)

			--Append each song and its duration to the formatted list
			for _, song in ipairs(song_list) do
				local cd = color.song_list.very_long
				if song.duration <= 60 then
					cd = color.song_list.critical
				elseif song.duration <= 120 then
					cd = color.song_list.low
				elseif song.duration <= 300 then
					cd = color.song_list.regular
				elseif song.duration <= 600 then
					cd = color.song_list.long
				end
				local cn = song.soul_voice and color.song_list.soul_voice or color.song_list.normal
				local minutes = math.floor(song.duration / 60)
				local seconds = song.duration % 60
				local cb = color.song_list.none
				if string.find(song.name, "Paeon") then
					cb = color.song_list.Paeon
				elseif string.find(song.name, "Ballad") then
					cb = color.song_list.Ballad
				elseif string.find(song.name, "Minne") then
					cb = color.song_list.Minne
				elseif string.find(song.name, "Minuet") then
					cb = color.song_list.Minuet
				elseif string.find(song.name, "Madrigal") then
					cb = color.song_list.Madrigal
				elseif string.find(song.name, "Mazurka") then
					cb = color.song_list.Mazurka
				elseif string.find(song.name, "Prelude") then
					cb = color.song_list.Prelude
				elseif string.find(song.name, "Mambo") then
					cb = color.song_list.Mambo
				elseif string.find(song.name, "Aubade") or string.find(song.name, "Pastoral") or string.find(song.name, "Fantasia") or string.find(song.name, "Operetta") or string.find(song.name, "Capriccio") or string.find(song.name, "Round") or string.find(song.name, "Gavotte") then
					cb = color.song_list.Dummy
				elseif string.find(song.name, "March") then
					cb = color.song_list.March
				elseif string.find(song.name, "Etude") then
					cb = color.song_list.Etude
				elseif string.find(song.name, "Carol") then
					cb = color.song_list.Carol
				elseif string.find(song.name, "Sirvente") then
					cb = color.song_list.Sirvente
				elseif string.find(song.name, "Dirge") then
					cb = color.song_list.Dirge
				elseif string.find(song.name, "Scherzo") then
					cb = color.song_list.Scherzo
				elseif string.find(song.name, "Aria") then
					cb = color.song_list.Aria
				end
				local bullet = "\\cs("..formatRGB(cb.r)..","..formatRGB(cb.g)..","..formatRGB(cb.b)..")"..(song.dummy and "♫" or "●").." \\cr"
				local song_name = "\\cs("..formatRGB(cn.r)..","..formatRGB(cn.g)..","..formatRGB(cn.b)..")"..song.name.."\\cr"
				local padding = 27 - (#song.name + (minutes >= 10 and 2 or 1) + 7)
				local spaces = ""
				while string.len(spaces) < padding do
					spaces = spaces..' '
				end
				formatted_list = formatted_list..bullet..song_name..":"..spaces.." \\cs("..formatRGB(cd.r)..","..formatRGB(cd.g)..","..formatRGB(cd.b)..")"..string.format("%d:%02d", minutes, seconds).."\\cr\n"
			end
		end
	end

	return formatted_list
end

--Reset the current_songs list (full clear)
local function resetCurrentSongs(player)
	if player then
		current_songs[player] = nil
	else
		current_songs = {}
	end
end

--Remove any songs that are no longer on the player (us)
function checkPlayerForLostSongs()

	local song_types = { "Paeon", "Ballad", "Minne", "Minuet", "Madrigal", "Prelude", "Aubade", "Pastoral", 
						"Fantasia", "Operetta", "Capriccio", "Round", "Gavotte", "March" }

	--Check if player has buffactive and current_songs
	if party[1] and party[1].buffactive then
		local player_name = party[1].name
		local buffactive = party[1].buffactive

		--Check if player has songs in current_songs
		if current_songs[player_name] then
			local player_songs = current_songs[player_name]

			--Loop through the defined song types
			for _, song_type in ipairs(song_types) do

				--Count occurrences of a specific song type in buffactive
				local function countBuffsOfTypeInBuffactive(buffactive, song_type)
					local lower_song_type = string.lower(song_type)
					return buffactive[lower_song_type] or 0
				end

				--Count occurrences of a specific song type in current_songs
				local function getSongsOfType(songs, song_type)
					local matching_songs = {}
					for song_name, song_data in pairs(songs) do
						if string.find(song_name, song_type) and song_data.duration >= 5 then
							table.insert(matching_songs, { name = song_name, duration = song_data.duration })
						end
					end
					return matching_songs
				end

				local buff_count = countBuffsOfTypeInBuffactive(buffactive, song_type)
				local matching_songs = getSongsOfType(player_songs, song_type)

				--Compare number of songs we think we have with number of songs we actually have
				if #matching_songs > buff_count then
					--Sort the matching songs by duration in descending order (to remove the highest duration first)
					--If we have multiple of the same song type up, there is no way to know which specific song was dispelled,
					--so we just make the assumption we lost the highest duration one. For example, the game simply tells us
					--we have 2 "Minuet" buffs on, and if we lose one we don't know which, we just now have 1 "Minuet" buff on.
					table.sort(matching_songs, function(a, b) return a.duration > b.duration end)

					--Tally up number of lost songs
					num_lost_songs = num_lost_songs + (#matching_songs - buff_count)

					--Remove extra songs
					-- for j = 1, (#matching_songs - buff_count) do
					-- 	local song_to_remove = matching_songs[j].name
					-- 	player_songs[song_to_remove] = nil
					-- end

				end
			end

			--If no songs are left on the player, remove the player from current_songs
			if next(player_songs) == nil then
				current_songs[player_name] = nil
			end
		end
	end
end

--Remove any songs that are no longer on party members (excludes player/us)
function checkPartyForLostSongs()
	--List of song types to care about
	local song_types = { "Paeon", "Ballad", "Minne", "Minuet", "Madrigal", "Prelude", "Aubade", "Pastoral", "Fantasia", 
						"Operetta", "Capriccio", "Round", "Gavotte", "March" }

	--Loop through players 2 to 6 in the party
	for i = 2, 6 do
		if party[i] and party[i].name and party[i].buff_details then
			local player_name = party[i].name
			local buff_details = party[i].buff_details

			--Check if player has songs in current_songs
			if current_songs[player_name] then
				local player_songs = current_songs[player_name]

				--Loop through defined song types
				for _, song_type in ipairs(song_types) do

					--Count occurrences of a specific song type in buff_details
					local function countBuffsOfType(buff_details, song_type)
						local count = 0
						for _, buff in pairs(buff_details) do
							if string.find(buff.name, song_type) then
								count = count + 1
							end
						end
						return count
					end

					--Count occurrences of a specific song type in current_songs
					local function getSongsOfType(songs, song_type)
						local matching_songs = {}
						for song_name, song_data in pairs(songs) do
							if string.find(song_name, song_type) and song_data.duration >= 5 then
								table.insert(matching_songs, { name = song_name, duration = song_data.duration })
							end
						end
						return matching_songs
					end

					local buff_count = countBuffsOfType(buff_details, song_type)
					local matching_songs = getSongsOfType(player_songs, song_type)

					--Compare the number of songs we think this player has with the number of songs they actually have
					if #matching_songs > buff_count then
						--Sort the matching songs by duration in descending order (to remove the highest duration first)
						--If we have multiple of the same song type up, there is no way to know which specific song was dispelled,
						--so we just make the assumption we lost the highest duration one. For example, the game simply tells us
						--we have 2 "Minuet" buffs on, and if we lose one we don't know which, we just now have 1 "Minuet" buff on.
						table.sort(matching_songs, function(a, b) return a.duration > b.duration end)

						--Tally up number of lost songs
						num_lost_songs = num_lost_songs + (#matching_songs - buff_count)

						--Remove extra songs
						-- for j = 1, (#matching_songs - buff_count) do
						-- 	local song_to_remove = matching_songs[j].name
						-- 	player_songs[song_to_remove] = nil
						-- end

					end
				end

				--If no songs are left on the player, remove the player from current_songs
				if next(player_songs) == nil then
					current_songs[player_name] = nil
				end
			end
		end
	end
end

--Set gear based on song and a few other factors
local function setSongGear(song,instrument)
	local set_name = "buff_song"
	local main_sub = hasDualWield() and "buff_song_dual_wield" or "buff_song_single_wield"

	if player.equipment.range == inst.dummy or (instrument and instrument == inst.dummy) then
		--doing a dummy song, don't use buff_song set so the durations are much lower making them easier to overwrite
		set_name = player.status == "Engaged" and "melee" or "idle"
	elseif string.find(song,'Ballad') then
		set_name = "ballad"
	elseif string.find(song,'Carol') then
		set_name = "carol"
	elseif string.find(song,'Etude') then
		set_name = "etude"
	elseif string.find(song,'Madrigal') then
		set_name = "madrigal"
	elseif string.find(song,'Mambo') then
		set_name = "mambo"
	elseif string.find(song,'March') then
		set_name = "march"
	elseif string.find(song,'Minne') then
		set_name = "minne"
	elseif string.find(song,'Minuet') then
		set_name = "minuet"
	elseif string.find(song,'Paeon') then
		set_name =  "paeon"
	elseif string.find(song,'Prelude') then
		set_name = "prelude"
	elseif string.find(song,'Horde Lullaby II') then
		set_name = "horde_lullaby_II"
		main_sub = hasDualWield() and "horde_lullaby_II_dual_wield" or "horde_lullaby_II_single_wield"
	else
		main_sub = hasDualWield() and "debuff_song_dual_wield" or "debuff_song_single_wield"
		if string.find(song,'Lullaby') then
			set_name = "foe_lullaby"
		elseif string.find(song,'Requiem') or string.find(song,'Elegy') or string.find(song,'Nocturne') or string.find(song,'Finale') or string.find(song,'Virelai') then
			set_name = "debuff_song"
		elseif string.find(song,'Threnody') then
			set_name = "threnody"
		end
	end

	if instrument then --If we're sent an instrument then we have nitro up, therefore use buff main/sub
		equip(set_combine(sets[set_name], sets[main_sub], {range=instrument}))
	elseif player.status == "Engaged" then
		equip(set_combine(sets[set_name], {main=pair[1],sub=pair[2]}))
	else
		equip(set_combine(sets[set_name], sets[main_sub]))
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
	elseif command == 'Mode' then
		if Mode == 'Mode1' then
			Mode = 'Mode2'
		elseif Mode == 'Mode2' then
			Mode = 'Mode1'
		end
		hud_mode_shdw:text('Mode: '..modeName[Mode]..' ('..EquipRange..')')
		hud_mode:text('Mode: '..modeName[Mode]..' ('..EquipRange..')')
		local c = color[Mode]
		hud_mode:color(c.r,c.g,c.b)
		hud_bg_color:bg_color(c.r,c.g,c.b)
		choose_set()
	elseif command == 'ClearNotifications' then --these reset the Notifications display back to a basic state
		if TownZones:contains(world.area) or windower.ffxi.get_info().mog_house then
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
		elseif subJobWithMP() and player.mpp <= 20 then
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
		if AlertSounds == 'On' then
			play_sound(Notification_Bad)
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
	elseif command == 'Songs' and ShowSongs == 'Off' then
		ShowSongs = 'On'
		windower.send_command('gs c ShowSongs')
		windower.add_to_chat(220,('[Songs List] Display: '):color(36)..('ON'):color(200))
	elseif command == 'Songs' and ShowSongs == 'On' then
		ShowSongs = 'Off'
		windower.send_command('gs c HideSongs')
		windower.add_to_chat(220,('[Songs List] Display: '):color(36)..('OFF'):color(200))
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
		hud_ptmember01_bg:show()
		hud_ptmember02_bg:show()
		hud_ptmember03_bg:show()
		hud_ptmember04_bg:show()
		hud_ptmember05_bg:show()
		hud_ptmember06_bg:show()
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
		hud_ptmember01_shdw:show()
		hud_ptmember02_shdw:show()
		hud_ptmember03_shdw:show()
		hud_ptmember04_shdw:show()
		hud_ptmember05_shdw:show()
		hud_ptmember06_shdw:show()
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
		hud_ptmember01:show()
		hud_ptmember02:show()
		hud_ptmember03:show()
		hud_ptmember04:show()
		hud_ptmember05:show()
		hud_ptmember06:show()
		hud_abil01:show()
		hud_abil02:show()
		hud_abil03:show()
		hud_abil04:show()
		hud_abil05:show()
		hud_abil06:show()
	elseif command == 'HideHUD' then
		song_list:hide()
		hud_bg_color:hide()
		hud_bg:hide()
		hud_tp_meter_bg1:hide()
		hud_tp_meter_bg2:hide()
		hud_tp_meter:hide()
		hud_noti_bg:hide()
		hud_debuffs_bg:hide()
		hud_ptmember01_bg:hide()
		hud_ptmember02_bg:hide()
		hud_ptmember03_bg:hide()
		hud_ptmember04_bg:hide()
		hud_ptmember05_bg:hide()
		hud_ptmember06_bg:hide()
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
		hud_ptmember01_shdw:hide()
		hud_ptmember02_shdw:hide()
		hud_ptmember03_shdw:hide()
		hud_ptmember04_shdw:hide()
		hud_ptmember05_shdw:hide()
		hud_ptmember06_shdw:hide()
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
		hud_ptmember01:hide()
		hud_ptmember02:hide()
		hud_ptmember03:hide()
		hud_ptmember04:hide()
		hud_ptmember05:hide()
		hud_ptmember06:hide()
		hud_abil01:hide()
		hud_abil02:hide()
		hud_abil03:hide()
		hud_abil04:hide()
		hud_abil05:hide()
		hud_abil06:hide()
	elseif command == 'ShowSongs' then
		song_list:show()
	elseif command == 'HideSongs' then
		song_list:hide()
	elseif command == 'WC' then
		CurrentEquip = ''
		if string.find(world.area,'Abyssea') then --if inside Abyssea use the combined table
			if hasDualWield() then
				pair = DualWieldCyclePlusAbyssea[WeaponCycleIndex]
				if pair == nil then
					WeaponCycleIndex = 1
					pair = DualWieldCyclePlusAbyssea[WeaponCycleIndex]
				end
			else
				pair = WeaponCyclePlusAbyssea[WeaponCycleIndex]
				if pair == nil then
					WeaponCycleIndex = 1
					pair = WeaponCyclePlusAbyssea[WeaponCycleIndex]
				end
			end
		else --otherwise, use just the basic WeaponCycle table
			if hasDualWield() then
				pair = DualWieldCycle[WeaponCycleIndex]
				if pair == nil then
					WeaponCycleIndex = 1
					pair = DualWieldCycle[WeaponCycleIndex]
				end
			else
				pair = WeaponCycle[WeaponCycleIndex]
				if pair == nil then
					WeaponCycleIndex = 1
					pair = WeaponCycle[WeaponCycleIndex]
				end
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
	elseif command == 'double_pianissimo_fix' then
		double_pianissimo_fix = false
	elseif command == "double_sublimation_fix" then
		double_sublimation_fix = false
	elseif command == "missing_song_block_false" then
		missing_song_block = false
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
		elseif subJobWithMP() and player.mpp <= 20 then
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
			equip(set_combine(sets.rest, sets.dt_override))
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
		elseif subJobWithMP() and player.mpp <= 20 then
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
			equip(set_combine(sets.melee, sets.dt_override))
		else
			equip(sets.melee)
		end
		if LowHP == true then --no matter what Mode we're in, if we have low HP we equip the Oh Shit gear set
			equip(sets.oh_shit)
		end
		equip({main=pair[1],sub=pair[2]})
	elseif player.status == "Idle" then
		if TownZones:contains(world.area) or windower.ffxi.get_info().mog_house then
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
		elseif subJobWithMP() and player.mpp <= 20 then
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
		elseif TownZones:contains(world.area) or windower.ffxi.get_info().mog_house then
			equip(set_combine(sets.idle, sets.town))
		else
			if LowHP == true then --no matter what Mode we're in, if we have low HP we equip the Oh Shit gear set
				equip(set_combine(sets.idle, sets.oh_shit))
			elseif DTOverride == "On" then
				equip(set_combine(sets.idle, sets.dt_override))
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
	local transport_spells = S{
		'Teleport-Holla', 'Teleport-Dem', 'Teleport-Mea', 'Teleport-Altep', 'Teleport-Yhoat', 'Teleport-Vahzl',
		'Recall-Jugner', 'Recall-Meriph', 'Recall-Pashh',
		'Warp', 'Warp II', 'Retrace', 'Escape'
	}
	if TransportLock and transport_spells:contains(spell.en) and transport_locked then
		cancel_spell()
		transport_locked = false
		windower.add_to_chat(8,('[Notice] '):color(39)..(spell.name):color(1)..(' cancelled. Unlocked for 3 min or until zone.'):color(8))
		if AlertSounds == 'On' then
			play_sound(Notification_Cancel)
		end
		transport_lock_timestamp = os.time() + 180
		return
	end
	if buffactive['terror'] then
		if AlertSounds == 'On' then
			play_sound(Notification_Cancel)
		end
		flash('Debuffs')
	elseif buffactive['petrification'] then
		if AlertSounds == 'On' then
			play_sound(Notification_Cancel)
		end
		flash('Debuffs')
	elseif buffactive['sleep'] then
		if AlertSounds == 'On' then
			play_sound(Notification_Cancel)
		end
		flash('Debuffs')
	elseif buffactive['stun'] then
		if AlertSounds == 'On' then
			play_sound(Notification_Cancel)
		end
		flash('Debuffs')
	elseif buffactive['amnesia'] and (spell.type == 'WeaponSkill' or spell.type == 'JobAbility') then
		if AlertSounds == 'On' then
			play_sound(Notification_Cancel)
		end
		flash('Debuffs')
	elseif buffactive['silence'] and (spell.prefix == '/magic' or spell.prefix == '/ninjutsu' or spell.prefix == '/song') then
		if AlertSounds == 'On' then
			play_sound(Notification_Cancel)
		end
		if UseEcho == 'E' then
			send_command('input /item "Echo Drop" <me>')
		elseif UseEcho == 'R' then
			send_command('input /item "Remedy" <me>')
		end
		flash('Debuffs')
	elseif buffactive['mute'] and (spell.prefix == '/magic' or spell.prefix == '/ninjutsu' or spell.prefix == '/song') then
		if AlertSounds == 'On' then
			play_sound(Notification_Cancel)
		end
		flash('Debuffs')
	elseif spell.type == 'WeaponSkill' then
		if player.tp < 1000 then
			if AlertSounds == 'On' then
				play_sound(Notification_Cancel)
			end
			hud_noti_shdw:text('«« Not Enough TP »»')
			hud_noti:text('«« Not Enough TP »»')
			hud_noti:color(255,50,50)
			NotiCountdown = NotiDelay
		elseif ((spell.skill == 'Marksmanship' or spell.skill == 'Archery') and spell.target.distance >= (spell.target.model_size + 23)) or ((spell.target.distance >= (spell.target.model_size + 3)) and not (spell.english == 'Starlight' or spell.english == 'Moonlight')) then
			if AlertSounds == 'On' then
				play_sound(Notification_Cancel)
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
			equip(sets.weapon_skill)
		end
		if player.equipment.main == "Aeneas" and spell.english == "Exenterator" then
			pre_AMTimer = 181
		elseif player.equipment.main == 'Mandau' and spell.english == "Mercy Stroke" then
			player_tp = player.tp
			TP_Window_Open = true
			relicAMUpdate(player_tp)
		elseif player.equipment.main == 'Twashtar' and spell.english == "Rudra's Storm" then
			player_tp = player.tp
			TP_Window_Open = true
			empyreanAMUpdate(player_tp)
		elseif player.equipment.main == "Carnwenhan" and spell.english == "Mordant Rime" then
			player_tp = player.tp
			TP_Window_Open = true
			mythicAMUpdate(player_tp)
		elseif player.equipment.main == 'Mpu Gandring' and spell.english == "Ruthless Stroke" then
			player_tp = player.tp
			TP_Window_Open = true
			primeAMUpdate(player_tp)
		end
	elseif spell.english == 'Soul Voice' and SoulVoice.recast < 2 then
		equip(sets.soul_voice)
	elseif spell.english == 'Nightingale' and Nightingale.recast < 2 then
		equip(sets.nightingale)
	elseif spell.english == 'Troubadour' and Troubadour.recast < 2 then
		equip(sets.troubadour)
	elseif spell.english == 'Quickstep' or string.find(spell.english,'Step') then
		equip(sets.steps)
	elseif string.find(spell.english,'Waltz') then
		equip(sets.waltzes)
	elseif spell.english == 'Animated Flourish' then
		equip(sets.animated_flourish)
	elseif spell.english == 'Violent Flourish' then
		equip(sets.violent_flourish)
	elseif spell.english == 'Holy Water' then
		equip(sets.holy_water)
	elseif (spell.english == 'Spectral Jig' or spell.english == 'Sneak' or spell.english == 'Monomi: Ichi' or spell.english == 'Monomi: Ni') and buffactive['Sneak'] and spell.target.type == 'SELF' then
		send_command('cancel 71')
		if spell.english ~= 'Spectral Jig' then
			equip(sets.fast_cast_other)
		end
	elseif spell.english == 'Stoneskin' and buffactive['Stoneskin'] then
		send_command('cancel 37')
		equip(sets.fast_cast_other)
	elseif spell.type == 'BardSong' then
		if AutoPianissimo == 'On' and spell.target.ispartymember == true and spell.target.type ~= 'SELF' and not (buffactive['amnesia'] or buffactive['Pianissimo'] or string.find(spell.english,'Lullaby')) then --exempt lullabies so we can put charmed players to sleep
			if not double_pianissimo_fix then
				double_pianissimo_fix = true --prevents this from running through here a second time after being cast again below
				cancel_spell()
				send_command('input /ja "Pianissimo" <me>;wait 1.5;input /ma \"'..spell.english..'\" '..spell.target.raw..';wait 1;gs c double_pianissimo_fix')
				return
			end
		end
		local instrument
		local main_sub = hasDualWield() and "buff_song_dual_wield" or "buff_song_single_wield"
		if spell.english == "Honor March" then
			instrument = "Marsyas"
		elseif spell.english == "Aria of Passion" then
			instrument = "Loughnashade"
		elseif Mode == "Mode2" then --Dummy/Extra Songs Mode
			instrument = inst.dummy
		elseif string.find(spell.english,'Aubade') then
			instrument = inst.aubade
		elseif string.find(spell.english,'Ballad') then
			instrument = inst.ballad
		elseif string.find(spell.english,'Capriccio') then
			instrument = inst.capriccio
		elseif string.find(spell.english,'Carol') then
			instrument = inst.carol
		elseif string.find(spell.english,'Dirge') then
			instrument = inst.dirge
		elseif string.find(spell.english,'Etude') then
			instrument = inst.etude
		elseif string.find(spell.english,'Fantasia') then
			instrument = inst.fantasia
		elseif string.find(spell.english,'Gavotte') then
			instrument = inst.gavotte
		elseif string.find(spell.english,'Hymnus') then
			instrument = inst.hymnus
		elseif string.find(spell.english,'Madrigal') then
			instrument = inst.madrigal
		elseif string.find(spell.english,'Mambo') then
			instrument = inst.mambo
		elseif string.find(spell.english,'March') then
			instrument = inst.march
		elseif string.find(spell.english,'Mazurka') then
			instrument = inst.mazurka
		elseif string.find(spell.english,'Minne') then
			instrument = inst.minne
		elseif string.find(spell.english,'Minuet') then
			instrument = inst.minuet
		elseif string.find(spell.english,'Operetta') then
			instrument = inst.operetta
		elseif string.find(spell.english,'Paeon') then
			instrument = inst.paeon
		elseif string.find(spell.english,'Pastoral') then
			instrument = inst.pastoral
		elseif string.find(spell.english,'Prelude') then
			instrument = inst.prelude
		elseif string.find(spell.english,'Round') then
			instrument = inst.round
		elseif string.find(spell.english,'Scherzo') then
			instrument = inst.scherzo
		elseif string.find(spell.english,'Sirvente') then
			instrument = inst.sirvente
		elseif string.find(spell.english,'Horde Lullaby II') then
			instrument = inst.horde_lullaby_II
			main_sub = hasDualWield() and "horde_lullaby_II_dual_wield" or "horde_lullaby_II_single_wield"
		else
			main_sub = hasDualWield() and "debuff_song_dual_wield" or "debuff_song_single_wield"
			if string.find(spell.english,'Elegy') then
				instrument = inst.elegy
			elseif string.find(spell.english,'Finale') then
				instrument = inst.finale
			elseif string.find(spell.english,'Lullaby') then
				instrument = inst.lullaby
			elseif string.find(spell.english,'Nocturne') then
				instrument = inst.nocturne
			elseif string.find(spell.english,'Requiem') then
				instrument = inst.requiem
			elseif string.find(spell.english,'Threnody') then
				instrument = inst.threnody
			elseif string.find(spell.english,'Virelai') then
				instrument = inst.virelai
			end
		end
		if buffactive['Nightingale'] then
			setSongGear(spell.english,instrument)
		else
			if player.status == "Engaged" then
				equip(set_combine(sets.fast_cast_song, {main=pair[1],sub=pair[2],range=instrument}))
			else
				equip(set_combine(sets.fast_cast_song, sets[main_sub], {range=instrument}))
			end
		end
	elseif not (spell.action_type == 'Item' or spell.action_type == 'Ability') then
		equip(sets.fast_cast_other)
	end
end

-------------------------------------------
--               MIDCAST                 --
-------------------------------------------

function midcast(spell)
	if spell.type == 'BardSong' then
		setSongGear(spell.english)
	elseif spell.skill == 'Enfeebling Magic' then
		if player.status == "Engaged" then
			equip(set_combine(sets.enfeeble, {main=pair[1],sub=pair[2]}))
		else
			equip(sets.enfeeble)
		end
	elseif spell.english == 'Refresh' then
		if player.status == "Engaged" then
			equip(set_combine(sets.buff, sets.refresh, {main=pair[1],sub=pair[2]}))
		else
			equip(set_combine(sets.buff, sets.refresh))
		end
	elseif spell.english == 'Cursna' then
		if player.status == "Engaged" then
			equip(set_combine(sets.cursna, {main=pair[1],sub=pair[2]}))
		else
			equip(sets.cursna)
		end
		equip(sets.cursna)
	elseif string.find(spell.english,'Cur') and spell.type == "WhiteMagic" then
		if player.status == "Engaged" then
			equip(set_combine(sets.buff, sets.healing, {main=pair[1],sub=pair[2]}))
		else
			equip(set_combine(sets.buff, sets.healing))
		end
	elseif spell.type == 'Trust' then
		equip(sets.unity)
	elseif spell.action_type == 'Magic' then
		equip(sets.buff_other)
	end
end

-------------------------------------------
--              AFTERCAST                --
-------------------------------------------

function aftercast(spell)
	if spell.english == 'Soul Voice' and SVTimer == 'On' and not spell.interrupted then
		if player.equipment.legs == 'Brd. Cannions +2' or player.equipment.legs == 'Bihu Cannions' or player.equipment.legs == 'Bihu Cannions +1' or player.equipment.legs == 'Bihu Cannions +2' or player.equipment.legs == 'Bihu Cannions +3' then --these pieces extend Soul Voice by 30 seconds so we adjust accordingly
			send_command('input /echo [Soul Voice] 3:30;wait 30;input /echo [Soul Voice] 3:00;wait 30;input /echo [Soul Voice] 2:30;wait 30;input /echo [Soul Voice] 2:00;wait 30;input /echo [Soul Voice] 1:30;wait 30;input /echo [Soul Voice] 1:00;wait 30;input /echo [Soul Voice] 0:30;wait 10;input /echo [Soul Voice] 0:20;wait 10;input /echo [Soul Voice] 0:10')
		else
			send_command('input /echo [Soul Voice] 3:00;wait 30;input /echo [Soul Voice] 2:30;wait 30;input /echo [Soul Voice] 2:00;wait 30;input /echo [Soul Voice] 1:30;wait 30;input /echo [Soul Voice] 1:00;wait 30;input /echo [Soul Voice] 0:30;wait 10;input /echo [Soul Voice] 0:20;wait 10;input /echo [Soul Voice] 0:10')
		end
	elseif spell.english == 'Clarion Call' and CCTimer == 'On' and not spell.interrupted then
		send_command('input /echo [Clarion Call] 3:00;wait 30;input /echo [Clarion Call] 2:30;wait 30;input /echo [Clarion Call] 2:00;wait 30;input /echo [Clarion Call] 1:30;wait 30;input /echo [Clarion Call] 1:00;wait 30;input /echo [Clarion Call] 0:30;wait 10;input /echo [Clarion Call] 0:20;wait 10;input /echo [Clarion Call] 0:10')
	end
	if spell.type == 'BardSong' and not spell.interrupted then
		song_duration = getSongDuration(spell.english)
		dummy_song = isDummySong()
		soul_voice_song = buffactive['Soul Voice'] and true or false
		max_songs = getMaxSongs()
		missing_song_block = true
		send_command('wait 5;gs c missing_song_block_false')
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
	if status == 4 and InCS == false then
		InCS = true
		if ShowHUD == 'On' then --In a cutscene: Hide the HUD
			windower.send_command('gs c HideHUD')
		end
		if ShowSongs == 'On' then --In a cutscene: Hide the Song List
			windower.send_command('gs c HideSongs')
		end
	elseif status ~= 4 and InCS == true then
		InCS = false
		if ShowHUD == 'On' then --Out of cutscene: Show the HUD
			windower.send_command('gs c ShowHUD')
		end
		if ShowSongs == 'On' then --Out of cutscene: Show the Song List
			windower.send_command('gs c ShowSongs')
		end
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

windower.register_event('gain buff', function(buff)
	if (buff == 270 or buff == 271 or buff == 272 or buff == 273) and AlertSounds == 'On' then --Aftermath
		play_sound(Notification_Aftermath_On)
		AMTimer = pre_AMTimer
		mythicNum = pre_mythicNum
		primeNum = pre_primeNum
	elseif (buff == 2 or buff == 19) then
		if buffactive['Stoneskin'] and not buffactive['charm'] then --If we get slept, remove stoneskin if its up
			send_command('cancel 37')
		end
		equip(sets.oh_shit)
	elseif buff == 7 or buff == 10 or buff == 28 then --If we get petrified, stunned, or terrored, then equip the Oh Shit set
		equip(sets.oh_shit)
	elseif buff == 15 then --Doom
		DangerCountdown = DangerRepeat --Start the Danger Sound going
	elseif buff == 17 and AlertSounds == 'On' then --Charm
		play_sound(Notification_Cancel)
	elseif buff == 71 or buff == 69 then --Sneak or Invisible
		send_command('gs c ClearNotifications')
	elseif buff == 252 then --Mounted
		send_command('wait .5;gs c ClearNotifications')
	end
end)

windower.register_event('lose buff', function(buff)
	if buff == 270 or buff == 271 or buff == 272 or buff == 273 and AlertSounds == 'On' then --lose any aftermath
		play_sound(Notification_Aftermath_Off)
	elseif buff == 251 and Alive == true and NotiFood == 'On' then --food wears off
		if AlertSounds == 'On' then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Food Has Worn Off »»')
		hud_noti:text('«« Food Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 113 and NotiReraise == 'On' and Alive == true then --reraise wears off
		if AlertSounds == 'On' then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Reraise Has Worn Off »»')
		hud_noti:text('«« Reraise Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 602 and string.find(world.area,'Escha') and NotiVorseal == 'On' then --Vorseal
		if AlertSounds == 'On' then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Vorseal Has Worn Off »»')
		hud_noti:text('«« Vorseal Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 253 and NotiSignet == 'On' then --Signet
		if AlertSounds == 'On' then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Signet Has Worn Off »»')
		hud_noti:text('«« Signet Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 256 and NotiSignet == 'On' then --Sanction
		if AlertSounds == 'On' then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Sanction Has Worn Off »»')
		hud_noti:text('«« Sanction Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 268 and NotiSignet == 'On' then --Sigil
		if AlertSounds == 'On' then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Sigil Has Worn Off »»')
		hud_noti:text('«« Sigil Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 512 and NotiSignet == 'On' then --Ionis
		if AlertSounds == 'On' then
			play_sound(Notification_Bad)
		end
		hud_noti_shdw:text('«« Ionis Has Worn Off »»')
		hud_noti:text('«« Ionis Has Worn Off »»')
		hud_noti:color(255,50,50)
		NotiCountdown = NotiDelay
	elseif buff == 1 and Alive == true then --Weakness
		if AlertSounds == 'On' then
			play_sound(Notification_Good)
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
		if AlertSounds == 'On' then
			play_sound(Notification_3000TP)
		end
		hud_noti_shdw:text('«« 3000 TP »»')
		hud_noti:text('«« 3000 TP »»')
		hud_noti:color(255,255,50)
		NotiCountdown = NotiDelay
	end

	--HUD TP Meter
	if not (TownZones:contains(world.area) or windower.ffxi.get_info().mog_house) then
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
		if player.equipment.main == 'Mandau' then
			relicAMUpdate(player_tp)
		elseif player.equipment.main == 'Twashtar' then
			empyreanAMUpdate(player_tp)
		elseif player.equipment.main == "Carnwenhan" then
			mythicAMUpdate(player_tp)
		elseif player.equipment.main == 'Mpu Gandring' then
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
	if pos == "(?-?)" and Zoning == false then
		Zoning = true
		if ShowHUD == 'On' then
			send_command('gs c HideHUD')
		end
		if ShowSongs == 'On' then
			send_command('gs c HideSongs')
		end
	elseif pos ~= "(?-?)" and Zoning == true then
		Zoning = false
		if ShowHUD == 'On' then
			send_command('gs c ShowHUD')
		end
		if ShowSongs == 'On' then
			send_command('gs c ShowSongs')
		end
	end

	--Aftermath checks
	if SwitchingWeapons == 0 then
		local function colorWeaponsText(AM)
			if ShowTPMeter ~= 'On' then
				local c = {r = 255, g = 255, b = 255}
				if AM == 1 then
					c = color.AM1
				elseif AM == 2 then
					c = color.AM2
				elseif AM == 3 then
					c = color.AM3
				end
				hud_weapons:color(c.r,c.g,c.b)
			end
		end
		if player.equipment.main == 'Mpu Gandring' then
			if buffactive['Aftermath: Lv.1'] then
				if currentAfterMath ~= 'PrimeAM1' or primeNum ~= currentPrimeNum or currentAMTimer ~= AMTimer then
					currentAfterMath = 'PrimeAM1'
					currentPrimeNum = primeNum
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM1: (Phys Dmg Lmt +'..primeNum..'%) '..am_time))
					hud_weapons:text(formatWeapons('AM1: (Phys Dmg Lmt +'..primeNum..'%) '..am_time))
					colorWeaponsText(1)
				end
			elseif buffactive['Aftermath: Lv.2'] then
				if currentAfterMath ~= 'PrimeAM2' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'PrimeAM2'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM2: (Phys Dmg Lmt +'..primeNum..'%) '..am_time))
					hud_weapons:text(formatWeapons('AM2: (Phys Dmg Lmt +'..primeNum..'%) '..am_time))
					colorWeaponsText(2)
				end
			elseif buffactive['Aftermath: Lv.3'] then
				if currentAfterMath ~= 'PrimeAM3' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'PrimeAM3'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM3: (Phys Dmg Lmt +'..primeNum..'%) '..am_time))
					hud_weapons:text(formatWeapons('AM3: (Phys Dmg Lmt +'..primeNum..'%) '..am_time))
					colorWeaponsText(3)
				end
			else
				if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain..EquipSub then
					CurrentEquip = EquipMain..EquipSub
					currentAfterMath = 'None'
					hud_weapons_shdw:text(formatWeapons(EquipMain..EquipSub))
					hud_weapons:text(formatWeapons(EquipMain..EquipSub))
					colorWeaponsText()
				end
			end
		elseif player.equipment.main == 'Mandau' then
			if buffactive['Aftermath'] then
				if currentAfterMath ~= 'RelicAM' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'RelicAM'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM: (Crit +5%/Crit DMG +5%) '..am_time))
					hud_weapons:text(formatWeapons('AM: (Crit +5%/Crit DMG +5%) '..am_time))
					colorWeaponsText(3)
				end
			else
				if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain..EquipSub then
					CurrentEquip = EquipMain..EquipSub
					currentAfterMath = 'None'
					hud_weapons_shdw:text(formatWeapons(EquipMain..EquipSub))
					hud_weapons:text(formatWeapons(EquipMain..EquipSub))
					colorWeaponsText()
				end
			end
		elseif player.equipment.main == 'Twashtar' then
			if buffactive['Aftermath: Lv.1'] then
				if currentAfterMath ~= 'EmpyreanAM1' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'EmpyreanAM1'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM1: (30% Triple Dmg) '..am_time))
					hud_weapons:text(formatWeapons('AM1: (30% Triple Dmg) '..am_time))
					colorWeaponsText(1)
				end
			elseif buffactive['Aftermath: Lv.2'] then
				if currentAfterMath ~= 'EmpyreanAM2' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'EmpyreanAM2'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM2: (40% Triple Dmg) '..am_time))
					hud_weapons:text(formatWeapons('AM2: (40% Triple Dmg) '..am_time))
					colorWeaponsText(2)
				end
			elseif buffactive['Aftermath: Lv.3'] then
				if currentAfterMath ~= 'EmpyreanAM3' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'EmpyreanAM3'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM3: (50% Triple Dmg) '..am_time))
					hud_weapons:text(formatWeapons('AM3: (50% Triple Dmg) '..am_time))
					colorWeaponsText(3)
				end
			else
				if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain..EquipSub then
					CurrentEquip = EquipMain..EquipSub
					currentAfterMath = 'None'
					hud_weapons_shdw:text(formatWeapons(EquipMain..EquipSub))
					hud_weapons:text(formatWeapons(EquipMain..EquipSub))
					colorWeaponsText()
				end
			end
		elseif player.equipment.main == 'Carnwenhan' then
			if buffactive['Aftermath: Lv.1'] then
				if currentAfterMath ~= 'MythicAM1' or mythicNum ~= currentMythicNum or currentAMTimer ~= AMTimer then
					currentAfterMath = 'MythicAM1'
					currentMythicNum = mythicNum
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM1: (Magic Acc. +'..mythicNum..') '..am_time))
					hud_weapons:text(formatWeapons('AM1: (Magic Acc. +'..mythicNum..') '..am_time))
					colorWeaponsText(1)
				end
			elseif buffactive['Aftermath: Lv.2'] then
				if currentAfterMath ~= 'MythicAM2' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'MythicAM2'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM2: (Accuracy +'..mythicNum..') '..am_time))
					hud_weapons:text(formatWeapons('AM2: (Accuracy +'..mythicNum..') '..am_time))
					colorWeaponsText(2)
				end
			elseif buffactive['Aftermath: Lv.3'] then
				if currentAfterMath ~= 'MythicAM3' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'MythicAM3'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM3: (Occ. Att. 2-3x) '..am_time))
					hud_weapons:text(formatWeapons('AM3: (Occ. Att. 2-3x) '..am_time))
					colorWeaponsText(3)
				end
			else
				if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain..EquipSub then
					CurrentEquip = EquipMain..EquipSub
					currentAfterMath = 'None'
					hud_weapons_shdw:text(formatWeapons(EquipMain..EquipSub))
					hud_weapons:text(formatWeapons(EquipMain..EquipSub))
					colorWeaponsText()
				end
			end
		elseif player.equipment.main == 'Aeneas' then
			if buffactive['Aftermath: Lv.1'] then
				if currentAfterMath ~= 'AeonicAM1' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'AeonicAM1'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM1: (4-Step Ultimate SC) '..am_time))
					hud_weapons:text(formatWeapons('AM1: (4-Step Ultimate SC) '..am_time))
					colorWeaponsText(1)
				end
			elseif buffactive['Aftermath: Lv.2'] then
				if currentAfterMath ~= 'AeonicAM2' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'AeonicAM2'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM2: (3-Step Ultimate SC) '..am_time))
					hud_weapons:text(formatWeapons('AM2: (3-Step Ultimate SC) '..am_time))
					colorWeaponsText(2)
				end
			elseif buffactive['Aftermath: Lv.3'] then
				if currentAfterMath ~= 'AeonicAM3' or currentAMTimer ~= AMTimer then
					currentAfterMath = 'AeonicAM3'
					currentAMTimer = AMTimer
					local am_time = formatAMTime(currentAMTimer)
					hud_weapons_shdw:text(formatWeapons('AM3: (2-Step Ultimate SC) '..am_time))
					hud_weapons:text(formatWeapons('AM3: (2-Step Ultimate SC) '..am_time))
					colorWeaponsText(3)
				end
			else
				if currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain..EquipSub then
					CurrentEquip = EquipMain..EquipSub
					currentAfterMath = 'None'
					hud_weapons_shdw:text(formatWeapons(EquipMain..EquipSub))
					hud_weapons:text(formatWeapons(EquipMain..EquipSub))
					colorWeaponsText()
				end
			end
		elseif currentAfterMath ~= 'None' or CurrentEquip ~= EquipMain..EquipSub then
			CurrentEquip = EquipMain..EquipSub
			currentAfterMath = 'None'
			hud_weapons_shdw:text(formatWeapons(EquipMain..EquipSub))
			hud_weapons:text(formatWeapons(EquipMain..EquipSub))
			colorWeaponsText()
		end
		if CurrentInstrument ~= EquipRange then
			CurrentInstrument = EquipRange
			hud_mode_shdw:text('Mode: '..modeName[Mode]..' ('..EquipRange..')')
			hud_mode:text('Mode: '..modeName[Mode]..' ('..EquipRange..')')
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
	if NotiLowMP =='On' and subJobWithMP() and player and player.mpp <= 20 and NotiLowMPToggle == 'Off' then
		NotiLowMPToggle = 'On' --turn the toggle on so this can't be triggered again until its toggled off (done below)
		if AlertSounds == 'On' then
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
		if player.hp <= LowHPThreshold and player.max_hp > LowHPThreshold and not (buffactive['weakness'] or TownZones:contains(world.area) or windower.ffxi.get_info().mog_house) then --when HP goes below a certain amount, turn on the LowHP flag and equip the appropriate gear set
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

	--Party distance checks
	local function distance(pt_member)
		local distance = pt_member and pt_member.mob and (math.floor(pt_member.mob.distance:sqrt() * 100) / 100) or 100
		return pt_member and pt_member.mob and (distance <= PTMemNearDist - 1) and 50 or (distance <= PTMemNearDist) and 20 or 0
	end
	hud_ptmember02_bg:bg_alpha(party[2] and distance(party[2]) or 0)
	hud_ptmember03_bg:bg_alpha(party[3] and distance(party[3]) or 0)
	hud_ptmember04_bg:bg_alpha(party[4] and distance(party[4]) or 0)
	hud_ptmember05_bg:bg_alpha(party[5] and distance(party[5]) or 0)
	hud_ptmember06_bg:bg_alpha(party[6] and distance(party[6]) or 0)

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
		if player.equipment.range == nil then
			EquipRange = 'Instruments loading...'
		else
			EquipRange = player.equipment.range
		end
		if ReraiseReminder == 'On' then
			if RRRCountdown > 0 then
				RRRCountdown = RRRCountdown - 1
			else
				if not buffactive['Reraise'] and Alive == true then --if we are dead no need to remind us about reraise
					if AlertSounds == 'On' then
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
		if AMTimer > 0 then
			AMTimer = AMTimer - 1
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
		if (NotiDoom == 'On' and buffactive['doom']) or (NotiLowHP == 'On' and LowHP == true and Alive == true and not (buffactive['weakness'] or TownZones:contains(world.area) or windower.ffxi.get_info().mog_house)) and AlertSounds == 'On' and DangerCountdown > 0 then
			DangerCountdown = DangerCountdown - 1
			play_sound(Notification_Danger)
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

		--On screen song list updates
		for player_name, songs in pairs(current_songs) do
			for song_name, song_data in pairs(songs) do
				-- Decrease the song duration by 1
				song_data.duration = song_data.duration - 1

				-- Remove the song if its duration falls to 0 or below
				if song_data.duration <= 0 then
					songs[song_name] = nil
				end
			end
			-- Remove the player from the table if they have no more songs
			if next(songs) == nil then
				current_songs[player_name] = nil
			end
		end
		--If a player dies, reset their songs
		for i = 0, 5 do
			local party_slot = 'p'..i
			local party_member = windower.ffxi.get_party()[party_slot]
			
			if party_member and party_member.hp == 0 then
				resetCurrentSongs(party_member.name)
			end
		end
		song_list:text(getCurrentSongList())

		--PT Member updates
		local c_not_found = {r = 125, g = 125, b = 125}
		local c = c_not_found
		local get_party = windower.ffxi.get_party
		hud_ptmember01_shdw:text(formatName(player):text_strip_format())
		hud_ptmember01:text(formatName(player))
		c = color.song_list[getNameColor(player.name)]
		hud_ptmember01:color(c.r,c.g,c.b)

		local p1 = get_party().p1
		hud_ptmember02_shdw:text(formatName(p1 or nil):text_strip_format())
		hud_ptmember02:text(formatName(p1 or nil))
		c = p1 and p1.mob and p1.mob.name and color.song_list[getNameColor(p1.mob.name)] or c_not_found
		hud_ptmember02:color(c.r,c.g,c.b)

		local p2 = get_party().p2
		hud_ptmember03_shdw:text(formatName(p2 or nil):text_strip_format())
		hud_ptmember03:text(formatName(p2 or nil))
		c = p2 and p2.mob and p2.mob.name and color.song_list[getNameColor(p2.mob.name)] or c_not_found
		hud_ptmember03:color(c.r,c.g,c.b)

		local p3 = get_party().p3
		hud_ptmember04_shdw:text(formatName(p3 or nil):text_strip_format())
		hud_ptmember04:text(formatName(p3 or nil))
		c = p3 and p3.mob and p3.mob.name and color.song_list[getNameColor(p3.mob.name)] or c_not_found
		hud_ptmember04:color(c.r,c.g,c.b)

		local p4 = get_party().p4
		hud_ptmember05_shdw:text(formatName(p4 or nil):text_strip_format())
		hud_ptmember05:text(formatName(p4 or nil))
		c = p4 and p4.mob and p4.mob.name and color.song_list[getNameColor(p4.mob.name)] or c_not_found
		hud_ptmember05:color(c.r,c.g,c.b)

		local p5 = get_party().p5
		hud_ptmember06_shdw:text(formatName(p5 or nil):text_strip_format())
		hud_ptmember06:text(formatName(p5 or nil))
		c = p5 and p5.mob and p5.mob.name and color.song_list[getNameColor(p5.mob.name)] or c_not_found
		hud_ptmember06:color(c.r,c.g,c.b)

		--Recast color updates

		if SoulVoice.recast then
			if buffactive['Soul Voice'] then
				textColor('Soul Voice','active')
				SoulVoice.flashed = false
			elseif SoulVoice.recast > 0 then
				textColor('Soul Voice','cooldown')
				SoulVoice.flashed = false
			else
				textColor('Soul Voice','ready')
				if not SoulVoice.flashed then
					flash('Soul Voice')
				end
				SoulVoice.flashed = true
			end
		else
			textColor('Soul Voice','notfound')
		end

		if ClarionCall.recast then
			if buffactive['Clarion Call'] then
				textColor('Clarion Call','active')
				ClarionCall.flashed = false
			elseif ClarionCall.recast > 0 then
				textColor('Clarion Call','cooldown')
				ClarionCall.flashed = false
			else
				textColor('Clarion Call','ready')
				if not ClarionCall.flashed then
					flash('Clarion Call')
				end
				ClarionCall.flashed = true
			end
		else
			textColor('Clarion Call','notfound')
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

		if Marcato.recast then
			if buffactive['Marcato'] then
				textColor('Marcato','active')
				Marcato.flashed = false
			elseif Marcato.recast > 0 then
				textColor('Marcato','cooldown')
				Marcato.flashed = false
			else
				textColor('Marcato','ready')
				if not Marcato.flashed then
					flash('Marcato')
				end
				Marcato.flashed = true
			end
		else
			textColor('Marcato','notfound')
		end

		if Nightingale.recast then
			if buffactive['Nightingale'] then
				textColor('Nightingale','active')
				Nightingale.flashed = false
			elseif Nightingale.recast > 0 then
				textColor('Nightingale','cooldown')
				Nightingale.flashed = false
			else
				textColor('Nightingale','ready')
				if not Nightingale.flashed then
					flash('Nightingale')
				end
				Nightingale.flashed = true
			end
		else
			textColor('Nightingale','notfound')
		end

		if Pianissimo.recast then
			if buffactive['Pianissimo'] then
				textColor('Pianissimo','active')
				Pianissimo.flashed = false
			elseif Pianissimo.recast > 0 then
				textColor('Pianissimo','cooldown')
				Pianissimo.flashed = false
			else
				textColor('Pianissimo','ready')
				if not Pianissimo.flashed then
					flash('Pianissimo')
				end
				Pianissimo.flashed = true
			end
		else
			textColor('Pianissimo','notfound')
		end

		if Sambas.recast then
			if buffactive['Haste Samba'] then
				textColor('Sambas','active')
				Sambas.flashed = false
			elseif Sambas.recast > 0 then
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

		if Tenuto.recast then
			if buffactive['Tenuto'] then
				textColor('Tenuto','active')
				Tenuto.flashed = false
			elseif Tenuto.recast > 0 then
				textColor('Tenuto','cooldown')
				Tenuto.flashed = false
			else
				textColor('Tenuto','ready')
				if not Tenuto.flashed then
					flash('Tenuto')
				end
				Tenuto.flashed = true
			end
		else
			textColor('Tenuto','notfound')
		end

		if Troubadour.recast then
			if buffactive['Troubadour'] then
				textColor('Troubadour','active')
				Troubadour.flashed = false
			elseif Troubadour.recast > 0 then
				textColor('Troubadour','cooldown')
				Troubadour.flashed = false
			else
				textColor('Troubadour','ready')
				if not Troubadour.flashed then
					flash('Troubadour')
				end
				Troubadour.flashed = true
			end
		else
			textColor('Troubadour','notfound')
		end

		if num_lost_songs > 0 then
			windower.add_to_chat(220,('[Song List] '):color(39)..(greeting().."Possible "..num_lost_songs..(" missing %s."):format(num_lost_songs == 1 and "song" or "songs")):color(220))
			num_lost_songs = 0
		end

		if set_weapon_timestamp > 0 and os.time() >= set_weapon_timestamp then
			set_weapon_timestamp = 0
			setWeaponPair()
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
	resetCurrentSongs() --clear current_songs list on zone
	getJPGiftBonusDuration() --update in case we just recently spent more JPs
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
	if newSubjob == 'DNC' then
		subjob = 'DNC'
		if SubDNCPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubDNCPage..'')
		end
	elseif newSubjob == 'NIN' then
		subjob = 'NIN'
		if SubNINPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubNINPage..'')
		end
	elseif newSubjob == 'RDM' then
		subjob = 'RDM'
		if SubRDMPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubRDMPage..'')
		end
	elseif newSubjob == 'SCH' then
		subjob = 'SCH'
		if SubSCHPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubSCHPage..'')
		end
	elseif newSubjob == 'WHM' then
		subjob = 'WHM'
		if SubWHMPage ~= "Off" then
			send_command('wait 2;input /macro set '..SubWHMPage..'')
		end
	else
		subjob = 'OTH'
	end
	getHUDAbils()

	--Set/reset a timer to set the weapons again
	set_weapon_timestamp = os.time() + 6

	if ZoneGear ~= 'Off' then
		send_command('wait 2;gs c Zone Gear')
	end

end

-------------------------------------------
--        INCOMING TEXT CHECKS           --
-------------------------------------------

windower.register_event('incoming text',function(org)
	if org:find('wishes to trade with you') then
		if AlertSounds == 'On' then
			play_sound(Notification_Good)
		end
		if NotiTrade == 'On' then
			hud_noti_shdw:text('«« Trade Request »»')
			hud_noti:text('«« Trade Request »»')
			hud_noti:color(255,255,50)
		end
	elseif org:find('The effect of') and org:find('is about to wear off.') then
		if AlertSounds == 'On' then
			play_sound(Notification_Bad)
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
			play_sound(Notification_Good)
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
				play_sound(Notification_Bad)
			end
			if NotiTime == 'On' then
				hud_noti_shdw:text('«« 15 Minutes Remaining »»')
				hud_noti:text('«« 15 Minutes Remaining »»')
				hud_noti:color(255,255,50)
			end
		elseif org:find(' 10 ') then
			if AlertSounds == 'On' then
				play_sound(Notification_Bad)
			end
			if NotiTime == 'On' then
				hud_noti_shdw:text('«« 10 Minutes Remaining »»')
				hud_noti:text('«« 10 Minutes Remaining »»')
				hud_noti:color(255,255,50)
			end
		elseif org:find(' 5 ') then
			if AlertSounds == 'On' then
				play_sound(Notification_Bad)
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
--             SONG TRACKING             --
-------------------------------------------

windower.register_event('action',function(act)

	local my_name = windower.ffxi.get_player().name
	local actor_name = windower.ffxi.get_mob_by_id(act.actor_id) and windower.ffxi.get_mob_by_id(act.actor_id).name or nil
	local get_mob_by_id = windower.ffxi.get_mob_by_id

	if actor_name == my_name and act.category == 4 then
		if (act.param and spells[act.param] and spells[act.param].type == "BardSong") then
			if act.targets[1].id and get_mob_by_id(act.targets[1].id).in_party then

				for i = 1, act.target_count do
					local target_id = act.targets[i].id
					local target_name = target_id and get_mob_by_id(target_id).name
					local song_name = spells[act.param].en

					-- Initialize the player's song list if it doesn't exist
					if target_name and current_songs[target_name] == nil then
						current_songs[target_name] = {}
					end

					local player_songs = target_name and current_songs[target_name]
					local song_count = 0
					if player_songs then
						for _ in pairs(player_songs) do song_count = song_count + 1 end
					end

					if player_songs and song_count < max_songs then
						-- If the player has fewer songs than max_songs, add or update the song
						player_songs[song_name] = {
							duration = song_duration,
							dummy = dummy_song,
							soul_voice = soul_voice_song,
						}
					elseif player_songs then
						-- If the player has max_songs or more, check if the song exists
						if player_songs[song_name] then
							-- Update the existing song duration
							player_songs[song_name] = {
								duration = song_duration,
								dummy = dummy_song,
								soul_voice = soul_voice_song,
							}
						else
							-- Find the song with the lowest duration
							local lowest_duration = nil
							local lowest_song_name = nil

							for s_name, song_data in pairs(player_songs) do
								if not lowest_duration or song_data.duration < lowest_duration then
									lowest_duration = song_data.duration
									lowest_song_name = s_name
								end
							end

							-- Replace the lowest duration song with the new song
							if lowest_song_name then
								player_songs[lowest_song_name] = nil
								player_songs[song_name] = {
									duration = song_duration,
									dummy = dummy_song,
									soul_voice = soul_voice_song,
								}
							end
						end
					end
				end

			end
		end
	end

-------------------------------------------
--         DAMAGE NOTIFICATIONS          --
-------------------------------------------

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
	hud_tp_meter_bg1:destroy()
	hud_tp_meter_bg2:destroy()
	hud_tp_meter:destroy()
	hud_noti_bg:destroy()
	hud_debuffs_bg:destroy()
	hud_ptmember01_bg:destroy()
	hud_ptmember02_bg:destroy()
	hud_ptmember03_bg:destroy()
	hud_ptmember04_bg:destroy()
	hud_ptmember05_bg:destroy()
	hud_ptmember06_bg:destroy()
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
	hud_ptmember01_shdw:destroy()
	hud_ptmember02_shdw:destroy()
	hud_ptmember03_shdw:destroy()
	hud_ptmember04_shdw:destroy()
	hud_ptmember05_shdw:destroy()
	hud_ptmember06_shdw:destroy()
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
	hud_ptmember01:destroy()
	hud_ptmember02:destroy()
	hud_ptmember03:destroy()
	hud_ptmember04:destroy()
	hud_ptmember05:destroy()
	hud_ptmember06:destroy()
	hud_abil01:destroy()
	hud_abil02:destroy()
	hud_abil03:destroy()
	hud_abil04:destroy()
	hud_abil05:destroy()
	hud_abil06:destroy()
	send_command('unalias dt')
	send_command('unalias mode')
	send_command('unalias wc')
	send_command('unalias hud')
	send_command('unalias songs')
	send_command('unbind '..DTBind)
	send_command('unbind '..ModeBind)
	send_command('unbind '..WCBind)

end
