-------------------------------------------
--  Keys Gearswap lua file for Warrior   --
-------------------------------------------
--[[

REQUIRED Windower Addons: Text

Updates to this file and other GearSwap files and addons can be found at
https://github.com/iLVL-Key/FFXI

Place both this file and the sounds folder inside the GearSwap data folder
	/addons/GearSwap/data/sounds/
	/addons/GearSwap/data/WAR.lua

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
LockstyleCombat	=	'9'		--[1-200]		Your Lockstyle set when in a field zone.
LockstyleTown	=	'1'		--[1-200]		Your Lockstyle set when in a town zone.
							--				If you do not want a separate town lockstyle, set this to the same as LockstyleCombat.
Book			=	'8'		--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
SubDRGPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing DRG.
SubSAMPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing SAM.
SubNINPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing NIN.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
MSTimer			=	'On'	--[On/Off]		Displays a timer for Mighty Strikes in echo.
BRTimer			=	'On'	--[On/Off]		Displays a timer for Brazen Rush in echo.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions
							--				(Town limits this to town gear only)
AlertSounds		=	'On'	--[On/Off]		Plays a sound on alerts.
AutoHWater		=	'On'	--[On/Off]		Automatically attempts to use Holy Waters when you get Doomed until it wears off.
AutoStance		=	'On'	--[On/Off]		Automatically activates and keeps Hasso/Seigan Stances active.
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
Mode1Name = 'Multi-Attack'		--Standard melee set.
Mode2Name = 'Attack Cap'		--Uses melee sets from Mode 1. WSs will use the Weapon Skill - Attack Cap set.
Mode3Name = 'High Accuracy'		--WSs will use the Weapon Skill - Accuracy set.
Mode4Name = 'Tank'				--standard tank set.

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
StartMode			=	'Mode1'	--[Mode1/Mode2/Mode3/Mode4]
								--	Determines the Mode you will start in. Current Mode can be changed at any time by using any
								--	of the three options listed above in the Notes section (a macro, alias, or keyboard shortcut).
ModeBind			=	'^g'	--Sets the keyboard shortcut you would like to cycle between Modes. CTRL+G (^g) is default.
DTBind				=	'^d'	--Sets the keyboard shortcut you would like to activate the Damage Taken Override. CTRL+D (^d) is default.
WCBind				=	'^h'	--Sets the keyboard shortcut you would like to activate the Weapon Cycle. CTRL+H (^h) is default.
								--    ^ = CTRL    ! = ALT    @ = WIN    # = APPS    ~ = SHIFT
AutoStanceWindow	=	60		--Time in seconds left before a Stance wears off that AutoStance will activate after another ability.
LowHPThreshold		=	1000	--Below this number is considered Low HP.
AutoSaveThreshold	=	1000	--If your HP goes below this number, a "save" will be used.
CappedTPThreshhold	=	2550	--Using a WS with this much TP or higher will use the Capped TP WS set instead.
AttackCapThreshhold	=	6000	--Using a WS with while your attack is above this number will layer in the Attack Cap WS set
DangerRepeat		=	10		--Maximum number of times the Danger Sound will repeat, once per second.
RRReminderTimer		=	1800	--Delay in seconds between checks to see if Reraise is up (300 is 5 minutes)
NotiDelay			=	6		--Delay in seconds before certain notifications will automatically clear.
HUDBGTrans			= 	'175'	--Background transparency for the HUD. (0 = fully clear, 255 = fully opaque)
AddCommas			=	'On'	--[On/Off]  Adds commas to damage numbers.
Debug				=	'Off'	--[On/Off]

--Color Values
Mode1color		=	'255 125 125'	--Mode 1
Mode2color		=	'125 125 255'	--Mode 2
Mode3color		=	'125 255 125'	--Mode 3
Mode4color		=	'255 255 125'	--Mode 4
Aftermath1color	=	'0 127 255'		--Aftermath Level 1
Aftermath2color	=	'75 255 75'		--Aftermath Level 2
Aftermath3color	=	'255 255 50'	--Aftermath Level 3

-------------------------------------------
--                WEAPONS                --
-------------------------------------------

-- Equipping these weapons will trigger using the Two-Handed set in Mode 1. Add more weapons on new lines as needed.
TwoHandedWeapons = S{
	"Shining One",
	"Chango",
	"Ukonvasara",
	"Lycurgos",
	"Ragnarok",
	"Bravura",
	"Conqueror",
	"Helheim",
	"Laphria",
	"War. Chopper",
	"Agoge Chopper",
	"Labraunda",
}

-- Equipping these weapons in the OFFHAND slot will trigger using the Dual Wield set in Mode 1. Add more weapons on new lines as needed.
DualWieldWeapons = S{
	"Fernagu",
	"Thibron",
	"Zantetsuken",
	"Sangarius +1",
}

-- These are the Main/Sub combos that the Weapon Cycle goes through. Add more pairs on new lines as needed
-- NOTE: if a slot should be empty, use `empty` with no quotation marks. ie: {"Fruit Punches", empty},
WeaponCycle = {
	{"Naegling", "Blurred Shield +1"},
	{"Loxotic Mace +1", "Blurred Shield +1"},
	{"Ukonvasara", "Utu Grip"},
	{"Chango", "Utu Grip"},
	{"Shining One", "Utu Grip"},
	--{"Main Slot", "Sub Slot"},
}

-- These are the Main/Sub combos that get added to the Weapon Cycle while in Abyssea for Procs. Add more pairs on new lines as needed
-- NOTE: if a slot should be empty, use `empty` with no quotation marks. ie: {"Fruit Punches", empty},
AbysseaProcCycle = {
	{"Excalipoor II", "Blurred Shield +1"},
	{"Heartstopper +1", "Blurred Shield +1"},
	{"Qutrub Knife", "Blurred Shield +1"},
	--{"Yagyu Shortblade", "Blurred Shield +1"},
	{"Hapy Staff", "Flanged Grip"},
	{"Goujian", "Flanged Grip"},
	{"Melon Slicer", "Flanged Grip"},
	--{"Ark Scythe", "Flanged Grip"},
	--{"Za'Dha Chopper", "Flanged Grip"},
	{"Sha Wujing's Lance", "Flanged Grip"},
	--{"Main Slot", "Sub Slot"},
}

-------------------------------------------
--               GEAR SETS               --
-------------------------------------------

function get_sets()

-- Mode 1 (Multi-Attack) (Example: A focus on Multi-Attack and Store TP, then filling in the rest with DEX, Accuracy, and Attack)
-- NOTE: This is your standard melee set.
sets.modeone = {
	ammo="Coiste Bodhar",
	head="Boii Mask +3",
	body="Boii Lorica +3",
	hands="Sakpata's Gauntlets",
	legs="Pumm. Cuisses +3",
	feet="Pumm. Calligae +3",
	neck="War. Beads +2",
	waist="Sailfi Belt +1",
	left_ear="Schere Earring",
	right_ear="Boii Earring +2",
	left_ring="Moonlight Ring",
	right_ring="Niqmaddu Ring",
	back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

-- Mode 1 Two-Handed (Multi-Attack) (Example: A focus on Multi-Attack and Store TP, then filling in the rest with DEX, Accuracy, and Attack)
-- NOTE: This set is used when you have one of the two-handed weapons listed in the Weapons section above
sets.modeonetwohand = set_combine(sets.modeone, {
	ammo="Yetshila +1",
	head="Sakpata's Helm",
	body="Sakpata's Plate",
	hands="Sakpata's Gauntlets",
	legs="Boii Cuisses +3",
	feet="Boii Calligae +3",
	neck="War. Beads +2",
	waist="Ioskeha Belt +1",
	left_ear="Schere Earring",
	right_ear="Boii Earring +2",
	left_ring="Hetairoi Ring",
	right_ring="Niqmaddu Ring",
	back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
})

-- Mode 1 Dual Wield (Multi-Attack) (Example: A focus on Dual Wield, Multi-Attack and Store TP, then filling in the rest with DEX, Accuracy, and Attack)
-- NOTE: This set is used when you have one of the dual wield weapons listed in the Weapons section above equipped in your offhand
sets.modeonedualwield = set_combine(sets.modeone, {

})

-- Mode 2 (Attack Capped)
-- NOTE: This is a special mode for when you are attack capped. It does not have it's own TP set.
-- Instead, it uses your Mode 1 TP sets and weapon skills will use the Weapon Skill - Attack Cap set.


-- Mode 3 (Accuracy) (Example: A focus on DEX and Accuracy, then filling in the rest with a mix of Multi-Attack, Store TP, and Attack)
-- NOTE: This is a special mode for accuracy. In this mode, weapon skills will use the Weapon Skill - Accuracy set.
sets.modethree = set_combine(sets.modeone, {

})

-- Mode 4 (Tank) (Example: A focus on DT, HP, Killer effects, then filling in the rest with Multi-Attack, Store TP, and Attack)
sets.modefour = {

}

-- Idle (Movement Speed, Regain, Regen)
sets.idle = {
	feet="Hermes' Sandals",
	neck="Rep. Plat. Medal",
	left_ring="Karieyh Ring +1",
}

-- DT Override (Damage Taken-, Magic Evasion)
-- NOTE: Will override all other gear sets and inherit unused slots from them
sets.dtoverride = {
	right_ring="Defending Ring",
}

-- Oh Shit
-- Full DT- and everything you've got with Absorbs or Annuls Damage
sets.ohshit = {
	neck="Warder's Charm +1",
	left_ring="Defending Ring",
	right_ring="Shadow Ring",
	back="Shadow Mantle",
}

-- Weapon Skill - Basic (STR, TP Bonus, Multi-hit, Crit, Attack)
sets.ws = {
	ammo="Knobkierrie",
	head="Nyame Helm",
	body="Nyame Mail",
	hands="Boii Mufflers +3",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="War. Beads +2",
	waist="Sailfi Belt +1",
	left_ear="Thrud Earring",
	right_ear="Moonshade Earring",
	left_ring="Karieyh Ring +1",
	right_ring="Cornelia's Ring",
	back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}

-- Weapon Skill - Accuracy (WS Accuracy, Accuracy)
-- NOTE: This is a special set for weapon skill accuracy. When in Accuracy mode (mode 3), weapon skills will use this set.
sets.accws = set_combine(sets.ws, {
	neck="Fotia Gorget",
	waist="Fotia Belt",
	left_ring="Karieyh Ring +1",
	right_ring="Cornelia's Ring",
})

-- Weapon Skill - Capped TP (STR, Weapon Skill Damage, Attack, Multi-hit)
-- NOTE: Intended to override any TP Bonus pieces in your Weapon Skill set if you're already at capped TP
sets.cappedtpws = {
	left_ear="Lugra Earring +1",
}

-- Weapon Skill - Attack Cap (Physical Damage Limit)
sets.attackcapws = {
	head="Sakpata's Helm",
	body="Sakpata's Plate",
	hands="Sakpata's Gauntlets",
	legs="Sakpata's Cuisses",
	feet="Sakpata's Leggings",
}

-- Weapon Skill - Magic (Magic Attack Bonus)
sets.magicws = set_combine(sets.ws, {

})

-- Upheaval (VIT, TP Bonus, Multi-hit, Crit, Attack)
sets["Upheaval"] = set_combine(sets.ws, {
	body="Tatena. Harama. +1",
})

-- Savage Blade (STR, MND, Fencer, TP Bonus)
sets["Savage Blade"] = set_combine(sets.ws, {

})

-- Sanguine Blade (Dark Elemental Magic Attack Bonus)
sets["Sanguine Blade"] = set_combine(sets.magicws, {
	head="Pixie Hairpin +1",
	left_ring="Archon Ring",
})

-- Hachirin-no-obi
sets.hachirin = set_combine(sets.magicws,sets.ws, {
	waist="Hachirin-no-obi",
})

-- Ygnas's Resolve +1
-- NOTE: Will combine with the appropriate Weapon Skill set while participating in a Reive
sets.ygnas = {
	--neck="Ygnas's Resolve +1",
}

-- Tomahawk
sets.tomahawk = {
	ammo="Thr. Tomahawk",
	feet="Agoge Calligae +2",
}

-- Aggressor
sets.aggressor = {
	head="Pumm. Mask +2",
	body="Agoge Lorica +3",
}

-- Berserk
sets.berserk = {
	body="Pumm. Lorica +3",
	feet="Agoge Calligae +2",
}

-- Warcry
sets.warcry = {
	head="Agoge Mask +1",
}

-- Restraint
sets.restraint = {
	hands="Boii Mufflers +3",
}

-- Retaliation
sets.retaliation = {
	hands="Pumm. Mufflers +2",
}

-- Blood Rage
sets.bloodrage = {
	body="Boii Lorica +3",
}

-- Warrior's Charge
sets.charge = {
	legs="Agoge Cuisses +1",
}

-- Mighty Strikes
sets.mightystrikes = {

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




FileVersion = '7.2.3'

-------------------------------------------
--               UPDATES                 --
-------------------------------------------

--[[
MAJOR version updates add new feature(s). Usually require changes in the top portion of the file. Changes to gear sets will be noted.
MINOR version updates change how existing feature(s) function. Usually only require changes under the "Do Not Edit Below This Line".
PATCH version updates fix feature(s) that may not be functioning correctly or are otherwise broken. Usually only require changes under the "Do Not Edit Below This Line".
Ex: 1.2.3 (1 is the Major version, 2 is the Minor version, 3 is the patch version)

Version 7.2.3
- Fixed some errors that would display under certain circumstances immediately after switching characters.

Version 7.2.2
- Fixed AutoSave using multiple "saves" in a row.

Version 7.2.1
- Fixed AutoSave trying to use High/Super Jump while not in combat.

Version 7.2
- Adjusted Weaponskills to not equip a Weaponskill gear set when inside Abyssea and an Abyssea Proc Weapon pair is equipped.

Version 7.1.1
- Fixed AutoStance calling for a text object that does not exist.

Version 7.1
- Adjusted the Weapon Cycle have a second, separate list for Abyssea Proc Weapons that gets added into the cycle list when inside Abyssea.
- Updated the apostrophes used to define the TwoHandedWeapons and the DualWieldWeapons to quotation marks to avoid needing to escape any apostrophes in a weapons name.

Version 7.0
- Added Mode 1 Dual Wield gear set. This set will be used if you have one of the dual wield weapons equipped in the offhand that are listed in the Weapons sections directly above the gear sets.
- Adjusted how the Weapon Skill sets are coded. You can now add a new set for a WS that is not already defined by simply copying another WS set and changing the set name to match the desired WS name. This change also tidies up the backend code a bit as well which was totally not the main reason for doing it.
- Added Weapon Cycle feature. Cycles between pairs of Main slot weapons and Sub slot weapons/grips/shields. Use this to cycle between your commonly used weapons or add Abyssea proc weapons. Activated with a macro, an alias, or a keyboard shortcut (default is CTRL+H for Hweapon). Can be adjusted or new pairs added in the Weapons section.
- Added AutoStance option. Automatically activates and keeps sub SAM Stances active.
- Adjusted AutoSuperJump. Name changed to AutoSave. Will now try Super Jump then High Jump, in that order, based on cooldowns. Will not activate while in Seigan Stance. Will only attempt to activate one "save" each time you are below the HP threshold.
- Adjusted Page Option. Now defined for subbing DRG, SAM, or NIN with a default of 1 for other subjobs.
- Adjusted HUD positioning options and text for clarity.
- Adjusted HUD Ability recast colors. Will now give a short blink when an ability is becoming ready to use again.
- Adjusted ability recast timings for equipping gear from `<= 1` to `< 2`. Should give a touch more room to fire off properly if you're camping that recast timer.
- Adjusted Gear Mode keybind Advanced Option to remove the hardcoded "CTRL+" requirement. Can now be fully customized (WIN+G, ALT+5, F9, etc.)
- Adjusted the //hidehud and //showhud aliases to condense to just //hud. It also now actually works.

Version 6.0
- Added Warrior's Charge gear set.
- Added Mode 1 Two-Handed gear set. This set will be used if you have one of the two-handed weapons equipped that are listed in the Two-Handed Weapons sections directly above the gear sets.
- Adjusted the Weapons Notification to display what weapon/shield is equipped in your sub slot. Will not display if you have one of the weapons listed in the Two-Handed Weapons list equipped.

Version 5.0
- Added Tomahawk gear set.
- Added Advanced Option to add commas to the damage numbers.
- Adjusted Weaponskill Missed notification to also display when a Weaponskill gets blinked.
- Removed notifications for Magic Bursts and Blood Pacts because I don't know why I added it in there.

Version 4.0
- No gear set changes.
- Added AutoSuperJump option. Automatically attempts to use Super Jump when your HP gets critically low. HP threshold required to activate is adjustable in the Advanced Options.

Version 3.0
- Updated Attack Capped WS set. Attack threshold required to activate is adjustable in the Advanced Options.
- Removed the Attack Cap Mode. This is now handled automatically.

Version 2.0
- No gear set changes.
- Renamed WS Damage Notification to Damage Notification.
- Updated Damage Notification to include Weapon Skills, Skillchains, Magic Bursts, and Blood Pacts.
- Fixed Damage Notification option displaying regardless of being on or off.
- Updated to semantic versioning. This removes the need for the Version Compatibility Codenames.

04.15.22 (Version Compatibility Codename: Fast Blade)
- First version
- Started from Samurai file version 02.22.22 (Version Compatibility Codename: Tachi: Yukikaze)
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
--           MAGIC WS MAPPING           --
-------------------------------------------

MagicWS = S{
	'Burning Blade','Red Lotus Blade','Shining Blade','Seraph Blade','Frostbite','Freezebite'
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
LockstyleDelay = 5
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
AggressorRecast = 0
BerserkRecast = 0
WarcryRecast = 0
RestraintRecast = 0
RetaliationRecast = 0
BloodRageRecast = 0

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
send_command('wait 1.8;text loading create "Loading Keys WARRIOR file ver: '..FileVersion..' ...";wait .3;text loading size '..FontSize..';text loading pos '..HUDposXColumn1..' '..HUDposYLine1..';text loading bg_transparency 1') --Loading
--Create the Aftermath, Mode, Notifications, and Debuffs text objects and put them above the screen for now, we'll move them to the correct place next
send_command('wait 1.9;text weapons create "« Weapons loading... »";wait .3;text weapons size '..FontSize..';text weapons pos '..HUDposXColumn4..' -100;text weapons color 255 50 50;text weapons bg_transparency 1') --Aftermath
if Mode == 'Mode1' then
	send_command('wait 2.1;text mode create "Mode: '..Mode1Name..'";wait .3;text mode size '..FontSize..';text mode pos '..HUDposXColumn1..' -100;text mode color '..Mode1color..';text mode bg_transparency 1')
elseif Mode == 'Mode2' then
	send_command('wait 2.1;text mode create "Mode: '..Mode2Name..'";wait .3;text mode size '..FontSize..';text mode pos '..HUDposXColumn1..' -100;text mode color '..Mode2color..';text mode bg_transparency 1')
elseif Mode == 'Mode3' then
	send_command('wait 2.1;text mode create "Mode: '..Mode3Name..'";wait .3;text mode size '..FontSize..';text mode pos '..HUDposXColumn1..' -100;text mode color '..Mode3color..';text mode bg_transparency 1')
elseif Mode == 'Mode4' then
	send_command('wait 2.1;text mode create "Mode: '..Mode4Name..'";wait .3;text mode size '..FontSize..';text mode pos '..HUDposXColumn1..' -100;text mode color '..Mode4color..';text mode bg_transparency 1')
end
send_command('wait 2.1;text notifications create "Hello, '..player.name..'! (type //fileinfo for more information)";wait .3;text notifications size '..FontSize..';text notifications pos '..HUDposXColumn1..' -100;text notifications bg_transparency 1') --Notifications
send_command('wait 2.2;text debuffs create " ";wait .3;text debuffs size '..FontSize..';text debuffs pos '..HUDposXColumn4..' -100;text debuffs bg_transparency 1') --Debuffs
--Create all the HUD Recast text objects and put them above the screen for now, we'll move them to the correct place next
send_command('wait 2.3;text aggressor create "[ Aggres. ]";wait .3;text aggressor size '..FontSize..';text aggressor pos '..HUDposXColumn1..' -100;text aggressor bg_transparency 1')
send_command('wait 2.4;text berserk create "[ Berserk ]";wait .3;text berserk size '..FontSize..';text berserk pos '..HUDposXColumn1..' -100;text berserk bg_transparency 1')
send_command('wait 2.5;text warcry create "[ Warcry ]";wait .3;text warcry size '..FontSize..';text warcry pos '..HUDposXColumn1..' -100;text warcry bg_transparency 1')
send_command('wait 2.6;text restraint create "[ Restra. ]";wait .3;text restraint size '..FontSize..';text restraint pos '..HUDposXColumn1..' -100;text restraint bg_transparency 1')
send_command('wait 2.9;text retaliation create "[ Retali. ]";wait .3;text retaliation size '..FontSize..';text retaliation pos '..HUDposXColumn1..' -100;text retaliation bg_transparency 1')
send_command('wait 3.0;text bloodrage create "[ B.Rage ]";wait .3;text bloodrage size '..FontSize..';text bloodrage pos '..HUDposXColumn1..' -100;text bloodrage bg_transparency 1')

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
elseif SubSAMPage ~= "Off" and player.sub_job == 'SAM' then
	send_command('wait 2;input /macro set '..SubSAMPage..'')
elseif SubNINPage ~= "Off" and player.sub_job == 'NIN' then
	send_command('wait 2;input /macro set '..SubNINPage..'')
else
	send_command('wait 2;input /macro set 1')
end
send_command('alias fileinfo gs c Fileinfo') --creates the fileinfo alias
send_command('alias hud gs c HUD') --creates the HUD alias
send_command('bind '..ModeBind..' gs c Mode') --creates the gear mode keyboard shortcut
send_command('bind '..DTBind..' gs c DT') --creates the DT Override keyboard shortcut
send_command('bind '..WCBind..' gs c WC') --creates the Weapon Cycle keyboard shortcut
send_command('alias mode gs c Mode') --creates the Mode alias
send_command('alias dt gs c DT') --creates the DT Override alias
send_command('alias wc gs c WC') --creates the Weapon Cycle alias
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
			if LoadHUD == true then
				send_command('text mode text "Mode: '..Mode2Name..'";text mode color '..Mode2color..'')
			end
		elseif Mode == 'Mode2' then
			Mode = 'Mode3'
			if LoadHUD == true then
				send_command('text mode text "Mode: '..Mode3Name..'";text mode color '..Mode3color..'')
			end
		elseif Mode == 'Mode3' then
			Mode = 'Mode4'
			if LoadHUD == true then
				send_command('text mode text "Mode: '..Mode4Name..'";text mode color '..Mode4color..'')
			end
		elseif Mode == 'Mode4' then
			Mode = 'Mode1'
			if LoadHUD == true then
				send_command('text mode text "Mode: '..Mode1Name..'";text mode color '..Mode1color..'')
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
		send_command('wait .7;text mode pos '..HUDposXColumn1..' '..HUDposYLine2..';text mode color '..Mode1color..'')
		if NotiWeapons == 'On' then
			send_command('wait .7;text weapons pos '..HUDposXColumn4..' '..HUDposYLine2..'')
		end
		send_command('wait .8;text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')
		send_command('wait .8;text debuffs pos '..HUDposXColumn4..' '..HUDposYLine3..'')
	elseif command == 'Fileinfo' then
		add_to_chat(3,'-------------------------------------------')
		add_to_chat(3,'--  Keys Gearswap lua file for Warrior   --')
		add_to_chat(3,'-------------------------------------------')
		add_to_chat(8,' ')
		add_to_chat(200,'File Version: '..(''..FileVersion..''):color(8)..'')
		add_to_chat(8,' ')
		add_to_chat(8,'REQUIRED Windower Addons: Text')
		add_to_chat(8,' ')
		add_to_chat(8,'Place both this file and the sounds folder')
		add_to_chat(8,'inside the GearSwap data folder')
		add_to_chat(200,'ex:     /addons/GearSwap/data/sounds/')
		add_to_chat(200,'        /addons/GearSwap/data/WAR.lua')
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
		add_to_chat(200,'SubSAMPage: '..(''..SubSAMPage..''):color(8)..'')
		add_to_chat(200,'SubNINPage: '..(''..SubNINPage..''):color(8)..'')
		add_to_chat(200,'Chat: '..(''..Chat..''):color(8)..'')
		add_to_chat(200,'MSTimer: '..(''..MSTimer..''):color(8)..'')
		add_to_chat(200,'BRTimer: '..(''..BRTimer..''):color(8)..'')
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
		add_to_chat(200,'CappedTPThreshhold: '..(''..CappedTPThreshhold..''):color(8)..'')
		add_to_chat(200,'AttackCapThreshhold: '..(''..AttackCapThreshhold..''):color(8)..'')
		add_to_chat(200,'DangerRepeat: '..(''..DangerRepeat..''):color(8)..'')
		add_to_chat(200,'RRReminderTimer: '..(''..RRReminderTimer..''):color(8)..'')
		add_to_chat(200,'NotiDelay: '..(''..NotiDelay..''):color(8)..'')
		add_to_chat(200,'HUDBGTrans: '..(''..HUDBGTrans..''):color(8)..'')
		add_to_chat(200,'AddCommas: '..(''..AddCommas..''):color(8)..'')
		add_to_chat(200,'Debug: '..(''..Debug..''):color(8)..'')
		add_to_chat(200,' ')
		add_to_chat(3,'-- Color Values --')
		add_to_chat(200,'Mode1color: '..(''..Mode1color..''):color(8)..'')
		add_to_chat(200,'Mode2color: '..(''..Mode2color..''):color(8)..'')
		add_to_chat(200,'Mode3color: '..(''..Mode3color..''):color(8)..'')
		add_to_chat(200,'Mode4color: '..(''..Mode4color..''):color(8)..'')
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
		send_command('text bg1 show;text bg2 show;text bg3 show;text aggressor show;text berserk show;text warcry show;text restraint show;text retaliation show;text bloodrage show;text mode show;text notifications show;text debuffs show;text weapons show')
	elseif command == 'HideHUD' then
		send_command('text bg1 hide;text bg2 hide;text bg3 hide;text aggressor hide;text berserk hide;text warcry hide;text restraint hide;text retaliation hide;text bloodrage hide;text loading hide;text mode hide;text notifications hide;text debuffs hide;text weapons hide')
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
		if LowHP == true then --if we have low HP we equip the Oh Shit gear set
			equip(sets.ohshit)
			if Debug == 'On' then
				add_to_chat(8,'[Equipped Set: Oh Shit]')
			end
		else
			if DTOverride == 'On' then
				if Mode == 'Mode1' and TwoHandedWeapons:contains(player.equipment.main) then
					equip(set_combine(sets.modeonetwohand, sets.dtoverride))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: '..Mode1Name..' Two-Handed + DT Override]')
					end
				elseif Mode == 'Mode1' and DualWieldWeapons:contains(player.equipment.sub) then
					equip(set_combine(sets.modeonedualwield, sets.dtoverride))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: '..Mode1Name..' Dual Wield + DT Override]')
					end
				elseif Mode == 'Mode1' then
					equip(set_combine(sets.modeone, sets.dtoverride))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: '..Mode1Name..' + DT Override]')
					end
				elseif Mode == 'Mode2' and TwoHandedWeapons:contains(player.equipment.main) then
					equip(set_combine(sets.modeonetwohand, sets.dtoverride)) --Mode 2 uses the same TP set as Mode 1 (the difference is the WS set used)
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: '..Mode1Name..' Two-Handed + DT Override]')
					end
				elseif Mode == 'Mode2' and DualWieldWeapons:contains(player.equipment.sub) then
					equip(set_combine(sets.modeonedualwield, sets.dtoverride))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: '..Mode1Name..' Dual Wield + DT Override]')
					end
				elseif Mode == 'Mode2' then
					equip(set_combine(sets.modeone, sets.dtoverride))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: '..Mode1Name..' + DT Override]')
					end
				elseif Mode == 'Mode3' then
					equip(set_combine(sets.modethree, sets.dtoverride))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: '..Mode3Name..' + DT Override]')
					end
				elseif Mode == 'Mode4' then
					equip(set_combine(sets.modefour, sets.dtoverride))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: '..Mode4Name..' + DT Override]')
					end
				end
			else
				if Mode == 'Mode1' and TwoHandedWeapons:contains(player.equipment.main) then
					equip(sets.modeonetwohand)
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: '..Mode1Name..' Two-Handed]')
					end
				elseif Mode == 'Mode1' and DualWieldWeapons:contains(player.equipment.sub) then
					equip(sets.modeonedualwield)
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: '..Mode1Name..' Dual Wield]')
					end
				elseif Mode == 'Mode1' then
					equip(sets.modeone)
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: '..Mode1Name..']')
					end
				elseif Mode == 'Mode2' and TwoHandedWeapons:contains(player.equipment.main) then
					equip(sets.modeonetwohand) --Mode 2 uses the same TP set as Mode 1 (the difference is the WS set used)
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: '..Mode2Name..']')
					end
				elseif Mode == 'Mode2' and DualWieldWeapons:contains(player.equipment.sub) then
					equip(sets.modeonedualwield)
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: '..Mode2Name..' Dual Wield]')
					end
				elseif Mode == 'Mode2' then
					equip(sets.modeone)
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: '..Mode2Name..']')
					end
				elseif Mode == 'Mode3' then
					equip(sets.modethree)
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: '..Mode3Name..']')
					end
				elseif Mode == 'Mode4' then
					equip(sets.modefour)
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: '..Mode4Name..']')
					end
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
			if Mode == 'Mode1' and TwoHandedWeapons:contains(player.equipment.main) then
				equip(set_combine(sets.modeonetwohand, sets.adoulin, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' Two-Handed + Adoulin + Idle]')
				end
			elseif Mode == 'Mode1' and DualWieldWeapons:contains(player.equipment.sub) then
				equip(set_combine(sets.modeonedualwield, sets.adoulin, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' Dual Wield + Adoulin + Idle]')
				end
			elseif Mode == 'Mode1' then
				equip(set_combine(sets.modeone, sets.adoulin, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' + Adoulin + Idle]')
				end
			elseif Mode == 'Mode2' and TwoHandedWeapons:contains(player.equipment.main) then
				equip(set_combine(sets.modeonetwohand, sets.adoulin, sets.idle)) --Mode 2 uses the same TP set as Mode 1 (the difference is the WS set used)
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' Two-Handed + Adoulin + Idle]')
				end
			elseif Mode == 'Mode2' and DualWieldWeapons:contains(player.equipment.sub) then
				equip(set_combine(sets.modeonedualwield, sets.adoulin, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' Dual Wield + Adoulin + Idle]')
				end
			elseif Mode == 'Mode2' then
				equip(set_combine(sets.modeone, sets.adoulin, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' + Adoulin + Idle]')
				end
			elseif Mode == 'Mode3' then
				equip(set_combine(sets.modethree, sets.adoulin, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode3Name..' + Adoulin + Idle]')
				end
			elseif Mode == 'Mode4' then
				equip(set_combine(sets.modefour, sets.adoulin, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode4Name..' + Adoulin + Idle]')
				end
			end
		elseif BastokZones:contains(world.area) then
			if Mode == 'Mode1' and TwoHandedWeapons:contains(player.equipment.main) then
				equip(set_combine(sets.modeonetwohand, sets.bastok, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' Two-Handed + Bastok + Idle]')
				end
			elseif Mode == 'Mode1' and DualWieldWeapons:contains(player.equipment.sub) then
				equip(set_combine(sets.modeonedualwield, sets.bastok, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' Dual Wield + Bastok + Idle]')
				end
			elseif Mode == 'Mode1' then
				equip(set_combine(sets.modeone, sets.bastok, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' + Bastok + Idle]')
				end
			elseif Mode == 'Mode2' and TwoHandedWeapons:contains(player.equipment.main) then
				equip(set_combine(sets.modeonetwohand, sets.bastok, sets.idle)) --Mode 2 uses the same TP set as Mode 1 (the difference is the WS set used)
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' Two-Handed + Bastok + Idle]')
				end
			elseif Mode == 'Mode2' and DualWieldWeapons:contains(player.equipment.sub) then
				equip(set_combine(sets.modeonedualwield, sets.bastok, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' Two-Handed + Bastok + Idle]')
				end
			elseif Mode == 'Mode2' then
				equip(set_combine(sets.modeone, sets.bastok, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' + Bastok + Idle]')
				end
			elseif Mode == 'Mode3' then
				equip(set_combine(sets.modethree, sets.bastok, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode3Name..' + Bastok + Idle]')
				end
			elseif Mode == 'Mode4' then
				equip(set_combine(sets.modefour, sets.bastok, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode4Name..' + Bastok + Idle]')
				end
			end
		elseif SandyZones:contains(world.area) then
			if Mode == 'Mode1' and TwoHandedWeapons:contains(player.equipment.main) then
				equip(set_combine(sets.modeonetwohand, sets.sandoria, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' Two-Handed + San d\'Oria + Idle]')
				end
			elseif Mode == 'Mode1' and DualWieldWeapons:contains(player.equipment.sub) then
				equip(set_combine(sets.modeonedualwield, sets.sandoria, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' Dual Wield + San d\'Oria + Idle]')
				end
			elseif Mode == 'Mode1' then
				equip(set_combine(sets.modeone, sets.sandoria, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' + San d\'Oria + Idle]')
				end
			elseif Mode == 'Mode2' and TwoHandedWeapons:contains(player.equipment.main) then
				equip(set_combine(sets.modeonetwohand, sets.sandoria, sets.idle)) --Mode 2 uses the same TP set as Mode 1 (the difference is the WS set used)
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' Two-Handed + San d\'Oria + Idle]')
				end
			elseif Mode == 'Mode2' and DualWieldWeapons:contains(player.equipment.sub) then
				equip(set_combine(sets.modeonedualwield, sets.sandoria, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' Dual Wield + San d\'Oria + Idle]')
				end
			elseif Mode == 'Mode2' then
				equip(set_combine(sets.modeone, sets.sandoria, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' + San d\'Oria + Idle]')
				end
			elseif Mode == 'Mode3' then
				equip(set_combine(sets.modethree, sets.sandoria, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode3Name..' + San d\'Oria + Idle]')
				end
			elseif Mode == 'Mode4' then
				equip(set_combine(sets.modefour, sets.sandoria, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode4Name..' + San d\'Oria + Idle]')
				end
			end
		elseif WindyZones:contains(world.area) then
			if Mode == 'Mode1' and TwoHandedWeapons:contains(player.equipment.main) then
				equip(set_combine(sets.modeonetwohand, sets.windurst, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' Two-Handed + Windurst + Idle]')
				end
			elseif Mode == 'Mode1' and DualWieldWeapons:contains(player.equipment.sub) then
				equip(set_combine(sets.modeonedualwield, sets.windurst, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' Dual Wield + Windurst + Idle]')
				end
			elseif Mode == 'Mode1' then
				equip(set_combine(sets.modeone, sets.windurst, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' + Windurst + Idle]')
				end
			elseif Mode == 'Mode2' and TwoHandedWeapons:contains(player.equipment.main) then
				equip(set_combine(sets.modeonetwohand, sets.windurst, sets.idle)) --Mode 2 uses the same TP set as Mode 1 (the difference is the WS set used)
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' Two-Handed + Windurst + Idle]')
				end
			elseif Mode == 'Mode2' and DualWieldWeapons:contains(player.equipment.sub) then
				equip(set_combine(sets.modeonedualwield, sets.windurst, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' Dual Wield + Windurst + Idle]')
				end
			elseif Mode == 'Mode2' then
				equip(set_combine(sets.modeone, sets.windurst, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' + Windurst + Idle]')
				end
			elseif Mode == 'Mode3' then
				equip(set_combine(sets.modethree, sets.windurst, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode3Name..' + Windurst + Idle]')
				end
			elseif Mode == 'Mode4' then
				equip(set_combine(sets.modefour, sets.windurst, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode4Name..' + Windurst + Idle]')
				end
			end
		elseif TownZones:contains(world.area) then
			if Mode == 'Mode1' and TwoHandedWeapons:contains(player.equipment.main) then
				equip(set_combine(sets.modeonetwohand, sets.town, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' Two-Handed + Town + Idle]')
				end
			elseif Mode == 'Mode1' and DualWieldWeapons:contains(player.equipment.sub) then
				equip(set_combine(sets.modeonedualwield, sets.town, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' Dual Wield + Town + Idle]')
				end
			elseif Mode == 'Mode1' then
				equip(set_combine(sets.modeone, sets.town, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' + Town + Idle]')
				end
			elseif Mode == 'Mode2' and TwoHandedWeapons:contains(player.equipment.main) then
				equip(set_combine(sets.modeonetwohand, sets.town, sets.idle)) --Mode 2 uses the same TP set as Mode 1 (the difference is the WS set used)
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' Two-Handed + Town + Idle]')
				end
			elseif Mode == 'Mode2' and DualWieldWeapons:contains(player.equipment.sub) then
				equip(set_combine(sets.modeonedualwield, sets.town, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' Dual Wield + Town + Idle]')
				end
			elseif Mode == 'Mode2' then
				equip(set_combine(sets.modeone, sets.town, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' + Town + Idle]')
				end
			elseif Mode == 'Mode3' then
				equip(set_combine(sets.modethree, sets.town, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode3Name..' + Town + Idle]')
				end
			elseif Mode == 'Mode4' then
				equip(set_combine(sets.modefour, sets.town, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode4Name..' + Town + Idle]')
				end
			end
		elseif LowHP == true then --if we have low HP we equip the Oh Shit gear set
			equip(set_combine(sets.idle, sets.ohshit))
			if Debug == 'On' then
				add_to_chat(8,'[Equipped Set: Idle + Oh Shit]')
			end
		elseif DTOverride == 'On' then
			if Mode == 'Mode1' and TwoHandedWeapons:contains(player.equipment.main) then
				equip(set_combine(sets.modeonetwohand, sets.idle, sets.dtoverride))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' Two-Handed + Idle + DT Override]')
				end
			elseif Mode == 'Mode1' and DualWieldWeapons:contains(player.equipment.sub) then
				equip(set_combine(sets.modeonedualwield, sets.idle, sets.dtoverride))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' Dual Wield + Idle + DT Override]')
				end
			elseif Mode == 'Mode1' then
				equip(set_combine(sets.modeone, sets.idle, sets.dtoverride))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' + Idle + DT Override]')
				end
			elseif Mode == 'Mode2' and TwoHandedWeapons:contains(player.equipment.main) then
				equip(set_combine(sets.modeonetwohand, sets.idle, sets.dtoverride)) --Mode 2 uses the same TP set as Mode 1 (the difference is the WS set used)
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' Two-Handed + Idle + DT Override]')
				end
			elseif Mode == 'Mode2' and DualWieldWeapons:contains(player.equipment.sub) then
				equip(set_combine(sets.modeonedualwield, sets.idle, sets.dtoverride))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' Dual Wield + Idle + DT Override]')
				end
			elseif Mode == 'Mode2' then
				equip(set_combine(sets.modeone, sets.idle, sets.dtoverride))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' + Idle + DT Override]')
				end
			elseif Mode == 'Mode3' then
				equip(set_combine(sets.modethree, sets.idle, sets.dtoverride))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode3Name..' + Idle + DT Override]')
				end
			elseif Mode == 'Mode4' then
				equip(set_combine(sets.modefour, sets.idle, sets.dtoverride))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode4Name..' + Idle + DT Override]')
				end
			end
		else
			if Mode == 'Mode1' and TwoHandedWeapons:contains(player.equipment.main) then
				equip(set_combine(sets.modeonetwohand, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' Two-Handed + Idle]')
				end
			elseif Mode == 'Mode1' and DualWieldWeapons:contains(player.equipment.sub) then
				equip(set_combine(sets.modeonedualwield, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' Dual Wield + Idle]')
				end
			elseif Mode == 'Mode1' then
				equip(set_combine(sets.modeone, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode1Name..' + Idle]')
				end
			elseif Mode == 'Mode2' and TwoHandedWeapons:contains(player.equipment.main) then
				equip(set_combine(sets.modeonetwohand, sets.idle)) --Mode 2 uses the same TP set as Mode 1 (the difference is the WS set used)
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' Two-Handed + Idle]')
				end
			elseif Mode == 'Mode2' and DualWieldWeapons:contains(player.equipment.sub) then
				equip(set_combine(sets.modeonedualwield, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' Dual Wield + Idle]')
				end
			elseif Mode == 'Mode2' then
				equip(set_combine(sets.modeone, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode2Name..' + Idle]')
				end
			elseif Mode == 'Mode3' then
				equip(set_combine(sets.modethree, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode3Name..' + Idle]')
				end
			elseif Mode == 'Mode4' then
				equip(set_combine(sets.modefour, sets.idle))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: '..Mode4Name..' + Idle]')
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
		if MagicWS:contains(spell.english) then
			if ((spell.english == "Burning Blade" or spell.english == "Red Lotus Blade") and (world.day_element == "Fire" or world.weather_element == "Fire") and not (world.day_element == "Water" and world.weather_intensity == 1)) or ((spell.english == "Frostbite" or spell.english == "Freezebite") and (world.day_element == "Ice" or world.weather_element == "Ice") and not (world.day_element == "Fire" and world.weather_intensity == 1)) or ((spell.english == "Shining Blade" or spell.english == "Seraph Blade") and (world.day_element == "Light" or world.weather_element == "Light") and not (world.day_element == "Dark" and world.weather_intensity == 1)) then
				if buffactive['Reive Mark'] then
					equip(set_combine(sets.hachirin, sets.ygnas))
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hachirin-no-obi + Weapon Skill - Magic + Ygnas\'s Resolve]')
					end
				else
					equip(sets.hachirin)
					if Debug == 'On' then
						add_to_chat(8,'[Equipped Set: Hachirin-no-obi + Weapon Skill - Magic]')
					end				
				end
			elseif buffactive['Reive Mark'] then
				equip(set_combine(sets.magicws, sets.ygnas))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Weapon Skill - Magic + Ygnas\'s Resolve]')
				end
			else
				equip(sets.magicws)
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Weapon Skill - Magic]')
				end
			end
		elseif Mode == 'Mode2' then
			if buffactive['Reive Mark'] then
				equip(set_combine(sets.accws, sets.ygnas))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Weapon Skill - Accuracy + Ygnas\'s Resolve]')
				end
			else
				equip(sets.accws)
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Weapon Skill - Accuracy]')
				end
			end
		elseif player.tp >= CappedTPThreshhold then
			if player.attack >= AttackCapThreshhold then
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
		elseif player.attack >= AttackCapThreshhold then
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
	elseif spell.english == 'Mighty Strikes' and windower.ffxi.get_ability_recasts()[0] < 2 then
		equip(sets.mightystrikes)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Mighty Strikes]')
		end
	elseif spell.english == 'Tomahawk' and windower.ffxi.get_ability_recasts()[7] < 2 then
		equip(sets.tomahawk)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Tomahawk]')
		end
	elseif spell.english == 'Aggressor' and windower.ffxi.get_ability_recasts()[4] < 2 then
		equip(sets.aggressor)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Aggressor]')
		end
	elseif spell.english == 'Berserk' and windower.ffxi.get_ability_recasts()[1] < 2 then
		equip(sets.berserk)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Berserk]')
		end
	elseif spell.english == 'Warcry' and windower.ffxi.get_ability_recasts()[2] < 2 then
		equip(sets.warcry)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Warcry]')
		end
	elseif spell.english == 'Restraint' and windower.ffxi.get_ability_recasts()[9] < 2 then
		equip(sets.restraint)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Restraint]')
		end
	elseif spell.english == 'Retaliation' and windower.ffxi.get_ability_recasts()[8] < 2 then
		equip(sets.retaliation)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Retaliation]')
		end
	elseif spell.english == 'Blood Rage' and windower.ffxi.get_ability_recasts()[11] < 2 then
		equip(sets.bloodrage)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Blood Rage]')
		end
	elseif spell.english == 'Warrior\'s Charge' and windower.ffxi.get_ability_recasts()[6] < 2 then
		equip(sets.charge)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Warrior\'s Charge]')
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
	if spell.english == 'Mighty Strikes' and MSTimer == 'On' and not spell.interrupted then
		if player.equipment.legs == 'War. Mufflers +2' or player.equipment.legs == 'Agoge Mufflers' or player.equipment.legs == 'Agoge Mufflers +1' or player.equipment.legs == 'Agoge Mufflers +2' or player.equipment.legs == 'Agoge Mufflers +3' then --these pieces extend Mighty Strikes by 15 seconds so we adjust accordingly
			send_command('input /echo [Mighty Strikes] 60 seconds;wait 15;input /echo [Mighty Strikes] 45 seconds;wait 15;input /echo [Mighty Strikes] 30 seconds;wait 10;input /echo [Mighty Strikes] 20 seconds;wait 10;input /echo [Mighty Strikes] 10 seconds')
		else
			send_command('input /echo [Mighty Strikes] 45 seconds;wait 15;input /echo [Mighty Strikes] 30 seconds;wait 10;input /echo [Mighty Strikes] 20 seconds;wait 10;input /echo [Mighty Strikes] 10 seconds')
		end
	elseif spell.english == 'Brazen Rush' and BRTimer == 'On' and not spell.interrupted then
		send_command('input /echo [Brazen Rush] 30 seconds;wait 10;input /echo [Brazen Rush] 20 seconds;wait 10;input /echo [Brazen Rush] 10 seconds')
	elseif spell.english == 'Hasso' and not spell.interrupted then
		Stance = 'Hasso' --Set Stance to Hasso when we use it
		if Debug == 'On' then
			add_to_chat(8,'[Stance set to Hasso]')
		end
		StanceTimer = 300
		if Debug == 'On' then
			add_to_chat(8,'[StanceTimer set to 300]')
		end
	elseif spell.english == 'Seigan' and not spell.interrupted then
		Stance = 'Seigan' --Set Stance to Seigan when we use it
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
	if new == 'Engaged' or new == 'Idle' and player.sub_job == 'SAM' and player.sub_job_level ~= 0 then
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
		if not (buffactive['Poison'] or buffactive['Dia'] or buffactive['bio'] or buffactive['Shock'] or buffactive['Rasp'] or buffactive['Choke'] or buffactive['Frost'] or buffactive['Burn'] or buffactive['Drown'] or buffactive['Requiem'] or buffactive['Kaustra'] or buffactive['Helix']) and player.hp > 100 and player.status == "Engaged" then --then as long as we're not already DOT'd, have more than 100 HP, and are engaged,
			equip({neck="Vim Torque"}) --equip the Vim Torque to wake us up
			if Debug == 'On' then
				add_to_chat(8,'[Equipped Item: Frenzy Sallet]')
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
		if player.equipment.main == 'Ragnarok' then
			if buffactive['Aftermath'] then
				send_command('text weapons text "Aftermath (Accuracy/Crit Rate)";text weapons color '..Aftermath3color..'')
			elseif player.tp > 1000 then
				send_command('text weapons text "« '..EquipMain..''..EquipSub..' »";text weapons color '..Aftermath3color..'')
			else
				send_command('text weapons text "« '..EquipMain..''..EquipSub..' »";text weapons color 255 50 50')
			end
		elseif player.equipment.main == 'Bravura' then
			if buffactive['Aftermath'] then
				send_command('text weapons text "Aftermath (DT/Regen)";text weapons color '..Aftermath3color..'')
			elseif player.tp > 1000 then
				send_command('text weapons text "« '..EquipMain..''..EquipSub..' »";text weapons color '..Aftermath3color..'')
			else
				send_command('text weapons text "« '..EquipMain..''..EquipSub..' »";text weapons color 255 50 50')
			end
		elseif player.equipment.main == 'Farsha' or player.equipment.main == 'Ukonvasara' then
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
		elseif player.equipment.main == 'Conqueror' then
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
		elseif player.equipment.main == 'Chango' then
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
		if AutoSave == 'On' and player.sub_job == 'DRG' and player.hp <= AutoSaveThreshold and Alive == true and not (buffactive['Weakness'] or buffactive['Amnesia'] or buffactive['Terror'] or buffactive['Petrification'] or buffactive['Sleep'] or Stance == 'Seigan') and player.status == "Engaged" and not TownZones:contains(world.area) and not AutoSaveUsed then
			if player.sub_job_level >= 50 and windower.ffxi.get_ability_recasts()[160] == 0 then
				send_command('input /ja "Super Jump" <t>;wait .5;input /ja "Super Jump <t>')
			elseif player.sub_job_level >= 35 and windower.ffxi.get_ability_recasts()[159] == 0 then
				send_command('input /ja "High Jump" <t>;wait .5;input /ja "High Jump <t>')
			end
		end
		if player.equipment.main == nil or player.equipment.sub == nil then
			EquipMain = 'Weapons loading...'
			EquipSub = ''
		else
			EquipMain = player.equipment.main
			if player.equipment.sub == 'empty' or TwoHandedWeapons:contains(player.equipment.main) then
				EquipSub = ''
			else
				EquipSub = ' & '..player.equipment.sub..''
			end
		end
		if LoadHUD == true then
			if (buffactive['Hasso'] or buffactive['Seigan']) then
				StanceTimer = StanceTimer - 1
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
			send_command('text aggressor pos '..HUDposXColumn1..' '..HUDposYLine1..'')		--Aggressor goes in Column 1
			send_command('text berserk pos '..HUDposXColumn2..' '..HUDposYLine1..'')		--Berserk goes in Column 2
			send_command('text warcry pos '..HUDposXColumn3..' '..HUDposYLine1..'')			--Warcry goes in Column 3
			send_command('text restraint pos '..HUDposXColumn4..' '..HUDposYLine1..'')		--Restraint goes in Column 4
			send_command('text retaliation pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Retaliation goes in Column 5
			send_command('text bloodrage pos '..HUDposXColumn6..' '..HUDposYLine1..'')		--Blood Rage goes in Column 6
			send_command('text mode pos '..HUDposXColumn1..' '..HUDposYLine2..'')			--Mode goes in Line 2, Column 1
			send_command('text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')	--Notifications goes in Line 3, Column 1
			send_command('text debuffs pos '..HUDposXColumn4..' '..HUDposYLine3..'')		--Debuffs goes in Line 3, Column 4
			--Recast updates:
			if player.main_job == 'WAR' then --This check prevents errors when these fire off for a second after you switch characters
				AggressorRecast = windower.ffxi.get_ability_recasts()[4]
				BerserkRecast = windower.ffxi.get_ability_recasts()[1]
				WarcryRecast = windower.ffxi.get_ability_recasts()[2]
				RestraintRecast = windower.ffxi.get_ability_recasts()[9]
				RetaliationRecast = windower.ffxi.get_ability_recasts()[8]
				BloodRageRecast = windower.ffxi.get_ability_recasts()[11]
			end
			--Recast color updates - decide the colors:
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
			if buffactive['Warcry'] then WarcryColor = '75 255 75'
			elseif WarcryRecast < 2 and WarcryRecast ~= 0 then
				WarcryColor = '255 165 0'
				send_command('wait .25;text warcry color 255 255 125;wait .25;text warcry color 255 165 0;wait .25;text warcry color 255 255 125')
			elseif WarcryRecast > 0 then WarcryColor = '255 165 0'
			else WarcryColor = '255 50 50'
			end
			if buffactive['Restraint'] then RestraintColor = '75 255 75'
			elseif RestraintRecast < 2 and RestraintRecast ~= 0 then
				RestraintColor = '255 165 0'
				send_command('wait .25;text restraint color 255 255 125;wait .25;text restraint color 255 165 0;wait .25;text restraint color 255 255 125')
			elseif RestraintRecast > 0 then RestraintColor = '255 165 0'
			else RestraintColor = '255 50 50'
			end
			if buffactive['Retaliation'] then RetaliationColor = '75 255 75'
			elseif RetaliationRecast < 2 and RetaliationRecast ~= 0 then
				RetaliationColor = '255 165 0'
				send_command('wait .25;text retaliation color 255 255 125;wait .25;text retaliation color 255 165 0;wait .25;text retaliation color 255 255 125')
			elseif RetaliationRecast > 0 then RetaliationColor = '255 165 0'
			else RetaliationColor = '255 50 50'
			end
			if buffactive['Blood Rage'] then BloodRageColor = '75 255 75'
			elseif BloodRageRecast < 2 and BloodRageRecast ~= 0 then
				BloodRageColor = '255 165 0'
				send_command('wait .25;text bloodrage color 255 255 125;wait .25;text bloodrage color 255 165 0;wait .25;text bloodrage color 255 255 125')
			elseif BloodRageRecast > 0 then BloodRageColor = '255 165 0'
			else BloodRageColor = '255 50 50'
			end
			--Recast color updates - print the colors:
			send_command('text aggressor color '..AggressorColor..'')
			send_command('text berserk color '..BerserkColor..'')
			send_command('text warcry color '..WarcryColor..'')
			send_command('text restraint color '..RestraintColor..'')
			send_command('text retaliation color '..RetaliationColor..'')
			send_command('text bloodrage color '..BloodRageColor..'')
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
	elseif SubSAMPage ~= "Off" and newSubjob == 'SAM' then
		send_command('wait 2;input /macro set '..SubSAMPage..'')
	elseif SubNINPage ~= "Off" and newSubjob == 'NIN' then
		send_command('wait 2;input /macro set '..SubNINPage..'')
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
	send_command('wait 1;text bg1 delete;text bg2 delete;text bg3 delete;text aggressor delete;text berserk delete;text warcry delete;text restraint delete;text retaliation delete;text bloodrage delete;text loading delete;text mode delete;text notifications delete;text debuffs delete;text weapons delete') --delete the different text objects
end
