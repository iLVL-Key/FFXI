-------------------------------------------
-- Keys Gearswap lua file for Summoner   --
-------------------------------------------
--[[

Updates to this file and other GearSwap files and addons can be found at
https://github.com/iLVL-Key/FFXI

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

Hide or show the HUD at any time by typing
	//hidehud or //showhud

For the HUD function (see options below), suggested placement is center screen, just above your chat log.

IMPORTANT:
When you load this file for the first time, your HUD may look all wrong. The defaults preloaded are for a screen at 3440x1400.
Adjust the FontSize, LineSpacer, and ColumnSpacer options below as needed.

Required Windower Addons: Text
--]]
-------------------------------------------
--                OPTIONS                --
-------------------------------------------

AutoLockstyle	=	'On'	--[On/Off]		Automatically sets your lockstyle. Uses the Field and Town sets below.
LockstyleCombat =	'6'		--[1-200]		Your Lockstyle set when in a field zone.
LockstyleTown	=	'1'		--[1-200]		Your Lockstyle set when in a town zone.
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
UseEcho			=	'R'		--[E/R/Off]		Automatically uses an (E)cho Drop or (R)emedy instead of spell when you are silenced.
AutoHWater		=	'On'	--[On/Off]		Automatically attempts to use Holy Waters when you get Doomed until it wears off.
AutoRelease		=	'On'	--[On/Off]		Automatically uses Release when you summon an avatar with one already out.
DoomAlert		=	'On'	--[On/Off]		Alerts your party when you are doomed.
DoomOnText		=	'doom'			--		Text that displays in party chat when you are doomed. 
DoomOffText		=	'doom off'		--		That that displays in party chat when you are no longer doomed.

-- Avatar Macro Pages --
HomePage		=	'1'		--[1-10]		This is your starting macro page with all your summoning macros on them
IfritPage		=	'2'		--[1-10]		Individual macro pages for avatars
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

LowHPThreshold	=	1000	--Below this number is considered Low HP.
DangerRepeat	=	10		--Maximum number of times the Danger Sound will repeat, once per second.
RRReminderTimer	=	1800	--Delay in seconds between checks to see if Reraise is up (300 is 5 minutes)
NotiDelay		=	6		--Delay in seconds before certain notifications will automatically clear.
HUDBGTrans		=	'175'	--Background transparency for the HUD. (0 = fully clear, 255 = fully opaque)
Debug			=	'Off'	--[On/Off]

--Color Values
Aftermath1color		=	'0 127 255'		--Aftermath Level 1
Aftermath2color		=	'75 255 75'		--Aftermath Level 2
Aftermath3color		=	'255 255 50'	--Aftermath Level 3

-------------------------------------------
--               GEAR SETS               --
-------------------------------------------

function get_sets()

	-- Idle (Movement Speed, Refresh, Regen, Damage Taken-, Enmity-)
	-- Used when you do NOT have an avatar out.
	sets.idle = {
		main="Malignance Pole",
		sub="Vox Grip",
		ammo="Staunch Tathlum",
		head="Beckoner's Horn +3",
		body="Amalric Doublet +1",
		hands="Asteria Mitts +1",
		legs="Assid. Pants +1",
		feet="Herald's Gaiters",
		neck="Twilight Torque",
		waist="Regal Belt",
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
		ammo="Sancus Sachet +1",
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
		main="Gridarvor",
		sub="Vox Grip",
		ammo="Sancus Sachet +1",
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

	-- Weapon Skill (STR, Weapon Skill Damage, Attack, Double/Triple Attack)
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

	-- Fast Cast (cap is 80%) (precast for casting summons)
	sets.fastcast = {
		head="Amalric Coif +1", --11%
		body="Amalric Doublet +1", --4% (from augment)
	    hands="Leyline Gloves", --5+1
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
	--NOTE:	BPD-I + BPD-II + BPD-III (only from JP gifts, -10s) cap is -30s. This means that including the JP gifts, you only need a total of -20s between BPD-I and BPD-II (which each individually cap at -15s).
	--		Convokers Doublet plus the Sancus Sachet will do this together, then add in as much SMN skill as you can to bring your Avatar Favor tier up to break the -30s cap noted above.
	sets.bpdelay = {
		main="Espiritus",
		sub="Vox Grip",
		ammo="Sancus Sachet +1",		--BPD-II -7s
		head="Beckoner's Horn +3",
		body="Con. Doublet +3",			--BPD-I -15 (capping BPD-I)
		hands="Lamassu Mitts +1",
		legs="Beck. Spats +3",
		neck="Melic Torque",
		waist="Kobo Obi",
		left_ear="Andoaa Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Conveyance Cape",
	}

	-- Blood Pact: Rage Physical (BP Damage+, Pet: Att+) (BP midcast)
	sets.bpragephysical = {
		main="Gridarvor",
		sub="Elan Strap",
		ammo="Sancus Sachet +1",
		head={ name="Merlinic Hood", augments={'Blood Pact Dmg.+10','Pet: DEX+3',}},
		body="Con. Doublet +3",
		hands={ name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+22','Blood Pact Dmg.+10','Pet: STR+8','Pet: Mag. Acc.+15',}},
		legs={ name="Enticer's Pants", augments={'MP+30','Pet: Mag. Acc.+12','Pet: Damage taken -1%',}},
		feet={ name="Merlinic Crackows", augments={'Pet: "Mag.Atk.Bns."+5','Blood Pact Dmg.+10','Pet: AGI+1',}},
		neck="Smn. Collar +2",
		waist="Incarnation Sash",
		left_ear="Lugalbanda Earring",
		right_ear="Gelos Earring",
		left_ring="Varar Ring +1",
		right_ring="Varar Ring +1",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: Haste+10','Pet: "Regen"+5',}},
	}

	-- Blood Pact: Rage Magical (BP Damage+, Pet: MAB+) (BP midcast)
	sets.bpragemagical = {
		main="Grioavolr",
		sub="Elan Strap",
		ammo="Sancus Sachet +1",
		head={ name="Merlinic Hood", augments={'Blood Pact Dmg.+10','Pet: DEX+3',}},
		body="Con. Doublet +3",
		hands={ name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+22','Blood Pact Dmg.+10','Pet: STR+8','Pet: Mag. Acc.+15',}},
		legs={ name="Enticer's Pants", augments={'MP+30','Pet: Mag. Acc.+12','Pet: Damage taken -1%',}},
		feet={ name="Merlinic Crackows", augments={'Pet: "Mag.Atk.Bns."+5','Blood Pact Dmg.+10','Pet: AGI+1',}},
		neck="Smn. Collar +2",
		waist="Regal Belt",
		left_ear="Lugalbanda Earring",
		right_ear="Gelos Earring",
		left_ring="Varar Ring +1",
		right_ring="Varar Ring +1",
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Magic Damage+10','"Fast Cast"+10','Mag. Evasion+15',}},
	}

	-- Blood Pact: Rage Hybrid (BP Damage+, Pet: MAB+, Pet: Att+) (BP midcast)
	sets.bpragehybrid = {
		main="Grioavolr",
		sub="Elan Strap",
		ammo="Sancus Sachet +1",
		head={ name="Merlinic Hood", augments={'Blood Pact Dmg.+10','Pet: DEX+3',}},
		body="Con. Doublet +3",
		hands={ name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+22','Blood Pact Dmg.+10','Pet: STR+8','Pet: Mag. Acc.+15',}},
		legs={ name="Enticer's Pants", augments={'MP+30','Pet: Mag. Acc.+12','Pet: Damage taken -1%',}},
		feet={ name="Merlinic Crackows", augments={'Pet: "Mag.Atk.Bns."+5','Blood Pact Dmg.+10','Pet: AGI+1',}},
		neck="Smn. Collar +2",
		waist="Incarnation Sash",
		left_ear="Lugalbanda Earring",
		right_ear="Gelos Earring",
		left_ring="Varar Ring +1",
		right_ring="Varar Ring +1",
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Magic Damage+10','"Fast Cast"+10','Mag. Evasion+15',}},
	}

	-- Blood Pact: Ward Buff (SMN skill) (BP midcast)
	sets.bpwardbuff = {
		main="Grioavolr",
		main="Espiritus",
		sub="Vox Grip",
		ammo="Sancus Sachet +1",
		head="Beckoner's Horn +3",
		body="Beck. Doublet +3",
		hands="Lamassu Mitts +1",
		legs="Beck. Spats +3",
		neck="Melic Torque",
		waist="Kobo Obi",
		left_ear="Andoaa Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: Haste+10','Pet: "Regen"+5',}},
	}

	-- Blood Pact: Ward Debuff (SMN skill, Pet MAcc) (BP midcast)
	sets.bpwarddebuff = {
		main="Grioavolr",
		sub="Vox Grip",
		ammo="Sancus Sachet +1",
		head="Beckoner's Horn +3",
		body="Beck. Doublet +3",
		hands="Lamassu Mitts +1",
		legs="Beck. Spats +3",
		neck="Adad Amulet",
		waist="Incarnation Sash",
		left_ear="Andoaa Earring",
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




	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX          DO NOT EDIT BELOW THIS LINE          XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--




FileVersion = '8.0.0'

-------------------------------------------
--               UPDATES                 --
-------------------------------------------

--[[
If the new updates major version matches your current file,
simply replace everything under the "Do Not Edit Below This Line".
Only when the major version changes will you need to update the entire file.
Ex: 1.2.3 (1 is the Major version, 2 is the Minor version, 3 is the patch version

Version 8.0.0
-Renamed WS Damage Notification to Damage Notification.
-Updated Damage Notification to include Weapon Skills, Skillchains, Magic Bursts, and Blood Pacts.
-Fixed Damage Notification option displaying regardless of being on or off.
-Updated to semantic versioning. This removes the need for the Version Compatibility Codenames.

04.15.23 (Version Compatibility Codename: Judgment Bolt)
-Fixed missing options listings in the File Info (//fileinfo)

02.22.23 (Version Compatibility Codename: Judgment Bolt)
-Adjusted WS Damage Notification to display WSs for zero like normal. This reverses a previous change, but now with Skillchain damage being displayed alongside WS damage it made sense to show the zero damage instead of displaying as a miss.

02.07.23 (Version Compatibility Codename: Judgment Bolt)
-Added missing Aftermath colors.
-Adjusted WS Damage Notification to filter out some Job Abilities that get listed in the same action category as Weapon Skills.

01.24.23 (Version Compatibility Codename: Judgment Bolt)
-Adjusted WS Damage Notification to display Skillchain damage.

01.21.23 (Version Compatibility Codename: Judgment Bolt)
-Adjusted Macro Page timing. Should fix occasional issue with macros deleting themselves.
-Adjusted WS Damage Notification to count blinked WSs and WSs for zero as a miss. Blinks would previously display the number of shadows as the damage number.
-Fixed issue with WS Damage Notification where some abilities and weapon skills would occasionally gets mixed up.

01.10.23 (Version Compatibility Codename: Judgment Bolt)
-Adjusted HUD to automatically hide during zoning.
-Removed Omen and Vagary notifications. Those have been spun out into their own windower addon called Callouts.
-Updated Version Compatibility Codename to Judgment Bolt.

12.27.22 (Version Compatibility Codename: Diamond Dust)
-Overhauled the Aftermath notification. Renamed to Weapons. Will now always show your equipped weapon as a default state when no aftermath is up. Will change colors based on what your current TP will give you for an Aftermath effect.
-Removed the option to turn off the HUD. While I generally think the more options the better, the HUD is a main part of this lua.
-Fixed occasional error messages from the Text addon when loading/reloading the file.
-Updated Version Compatibility Codename to Diamond Dust.
-Code cleanup.

12.06.22 (Version Compatibility Codename: Clarsach Call)
-Overhauled Low HP notification. Notification and sound no longer activates in towns. Changed the Advanced Option from selecting "Once" or "Constant" to instead selecting the number of times the sound will repeat while your HP is low. Removed the 30 second window before triggering again.
-Adjusted certain notification to now automatically clear after a short delay.
-Removed the option for using the OhShit gear set. The gear set itself still remains and funtionality has not changed. Having the option was redundant as you can simply leave the set empty.
-Fixed Aftermath notification displaying when the NotiAftermath option is turned off.
-Updated Version Compatibility Codename to Clarsach Call.
-Code cleanup.

11.30.22 (Version Compatibility Codename: Aerial Blast)
-Overhauled how death is handled. More cleanly prevents unnecessary notifications from activating immediately upon raising (ie Reraise wearing off and Low HP).
-Added Danger sound file. Used by Doom and Low HP.
-Added Advanced Option for the Danger sound to play constantly while in danger or only once (with a 30 second delay to be able to play again).
-Added WSDamage option. Displays your damage (or miss) after a Weapon Skill.
-Added the //hidehud and //showhud alias commands.
-Added debug lines for redefining variables.
-Adjusted Low HP Notification Sound to have a 30 second window after triggering where it will not trigger again.
-Adjusted Low MP Notification to trigger in real-time rather than being tied to the Aftercast funtion.
-Adjusted HUD text object loading timing to avoid them occasionally not loading correctly.
-Adjusted AutoHWater option to stop and notify you once you are out of useable Holy Waters.
-Adjusted the Trade notification to clear once the trade is complete.
-Removed the option to turn off the HUDRecast. While I generally think the more options the better, the recasts are a main part of the HUD.
-Removed the CharmNaked option. Apparently you can't Do Stuff while charmed ¯\_(ツ)_/¯
-Fixed incorrect SP Ability timers when wearing gear that augments (adds additional time to) the ability.
-Fixed gear sets not equipping correctly when using Astral Conduit ot Apogee.
-Fixed ordering of Status Notifications.
-Renamed OhShitThreshold to LowHPThreshold since it controls more than just the OhShit option.
-Updated Version Compatibility Codename to Aerial Blast.
-Code cleanup.

10.15.22 (Version Compatibility Codename: Tidal Wave)
-Added an Oh Shit gear set and accompanying option to use it. HP threshold required to activate is adjustable in the Advanced Options.
-Added Low HP Notification.
-Added AutoHWater option. Automatically attempts to use Holy Waters when you get Doomed until it wears off. Currently will keep trying even if you run out of Holy Waters.
-Added DoomAlert option. Will alert your party when you are doomed. You can also customize the text that displays in party chat.
-Added CharmNaked option. Removes all gear, or all gear except weapons, when you are charmed.
-Added Sneak and Invisible status notification.
-Added missing listings in the /fileinfo printout for a few Notifications.
-Added missing Healing gear set.
-Added Silver Knife to list of Adoulin/Town areas.
-Adjusted the code that tries to wake you when you are asleep to not trigger if you are charmed.
-Adjusted resting to equip Refresh + Rest gear sets.
-Moved RRReminderTimer from Options to Advanced Options.
-Fixed resting not equipping the DT Override set properly.
-Removed the Elemental gear set.
-Removed Gearswaps built-in showswaps function from the files debug mode.
-Updated Version Compatibility Codename to Tidal Wave.
-Code cleanup.

08.24.22 (Version Compatibility Codename: Earthen Fury)
-Added Avatar Macro Pages. These will automatically swap to the correct pages for each avatar when you summon them, or go back to your "home page" when they are released or die.
-Adjusted what the fastcast set ignores to include all "Ring" items (previously would ignore only Warp and Dimensional Rings specifically, will now also ignore XP/CP rings)
-Fixed gear sets not equipping properly after bloodpacts or summoning an avatar.
-Code cleanup.

08.13.22 (Version Compatibility Codename: Earthen Fury)
-Added Leafallia to list of towns.
-Added cancelling Stoneskin if its preventing poison from removing sleep.
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
-Code cleanup.

06.14.22 (Version Compatibility Codename: Inferno)
-First version
-Started from Geomancer file version 06.14.21
--]]

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

NotiLowMPToggle = 'Off' --start with the toggle off for the Low MP Notification so that it can trigger
DTOverride = "Off" --Start with the Damage Taken Override off
RRRCountdown = RRReminderTimer
HWaterRecast = 0
HWater = true --this is used as a simple on/off for when we run out of Holy Waters
Heartbeat = 0 --set to 0 just to start the Heartbeat running
LoadDelay = 4 --delays loading the HUD, this makes sure all the variables get set correctly before being used, displays file version info, and waits to use lockstyle
LoadHUD = false --starts false then switched to true after the LoadDelay
ShowHUD = true --this changes to false when we are in a cutscene
LockstyleDelay = 3
AutoLockstyleRun = true
if pet.isvalid then
	PetPresent = true
else
	PetPresent = false
end
LowHP = false
Doom = false
Alive = true --makes it easier to Do Things or Not Do Things based on if we die.
DangerCountdown = 0
NotiCountdown = -1 --we set the countdown below 0 to stop the countdown from hitting 0 and triggering the ClearNotifications command

--set the initial recasts to 0, they will get updated in the Heartbeat function:
FavorRecast = 0
SiphonRecast = 0
ApogeeRecast = 0
CedeRecast = 0
ConvertRecast = 0

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
send_command('wait 1.6;text loading create "Loading Keys SUMMONER file ver: '..FileVersion..'...";wait .3;text loading size '..FontSize..';text loading pos '..HUDposXColumn1..' '..HUDposYLine1..';text loading bg_transparency 1') --Loading
send_command('wait 1.7;text bg2 create "                                                                                                                          ";wait .3;text bg2 size '..FontSize..';text bg2 pos '..HUDposXColumn1..' -100;text bg2 bg_transparency '..HUDBGTrans..'')--Background Line 2
send_command('wait 1.8;text bg3 create "                                                                                                                          ";wait .3;text bg3 size '..FontSize..';text bg3 pos '..HUDposXColumn1..' -100;text bg3 bg_transparency '..HUDBGTrans..'')--Background Line 3
--Create the Aftermath, Avatar, Notifications and Debuffs text objects and put them above the screen for now, we'll move them to the correct place next
send_command('wait 1.9;text weapons create "« Weapon loading... »";wait .3;text weapons size '..FontSize..';text weapons pos '..HUDposXColumn4..' -100;text weapons color 255 50 50;text weapons bg_transparency 1') --Aftermath
send_command('wait 2.0;text notifications create "Hello, '..player.name..'! (type //fileinfo for more information)";wait .3;text notifications size '..FontSize..';text notifications pos '..HUDposXColumn1..' -100;text notifications bg_transparency 1') --Notifications
send_command('wait 2.1;text debuffs create " ";wait .3;text debuffs size '..FontSize..';text debuffs pos '..HUDposXColumn4..' -100;text debuffs bg_transparency 1') --Debuffs
send_command('wait 2.2;text avatar create "No Avatar";wait .3;text avatar size '..FontSize..';text avatar pos '..HUDposXColumn1..' -100;text avatar color 255 255 255;text avatar bg_transparency 1') --Avatar
--Create all the HUD Recast text objects and put them above the screen for now, we'll move them to the correct place next
send_command('wait 2.3;text favor create "[ A. Favor ]";wait .3;text favor size '..FontSize..';text favor pos '..HUDposXColumn1..' -100;text favor bg_transparency 1')
send_command('wait 2.4;text siphon create "[ E. Siphon ]";wait .3;text siphon size '..FontSize..';text siphon pos '..HUDposXColumn1..' -100;text siphon bg_transparency 1')
send_command('wait 2.5;text apogee create "[ Apogee ]";wait .3;text apogee size '..FontSize..';text apogee pos '..HUDposXColumn1..' -100;text apogee bg_transparency 1')
send_command('wait 2.6;text cede create "[ M. Cede ]";wait .3;text cede size '..FontSize..';text cede pos '..HUDposXColumn1..' -100;text cede bg_transparency 1')
send_command('wait 2.7;text convert create "[ Convert ]";wait .3;text convert size '..FontSize..';text convert pos '..HUDposXColumn1..' -100;text convert bg_transparency 1')

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
send_command('alias hidehud gs c HideHUD') --creates the HideHUD alias
send_command('alias showhud gs c ShowHUD') --creates the ShowHUD alias
send_command('bind ^'..DTCtrlPlus..' gs c DT') --creates the DT Override keyboard shortcut
send_command('alias dt gs c DT') --creates the DT Override and alias
if Debug == 'On' then
	windower.add_to_chat(8,'[Debug Mode: On]')
end

-------------------------------------------
--            SELF COMMANDS              --
-------------------------------------------

function self_command(command)
	if command == 'DT' then
		if DTOverride == 'Off' then
			DTOverride = 'On'
			if Debug == 'On' then
				windower.add_to_chat(8,'[DTOverride set to On]')
			end
		elseif DTOverride == 'On' then
			DTOverride = 'Off'
			if Debug == 'On' then
				windower.add_to_chat(8,'[DTOverride set to Off]')
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
		elseif player.mpp <= 20 then
			send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50;text notifications bg_transparency 1')
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
		send_command('text loading hide')
		send_command('wait .1;text bg2 pos '..HUDposXColumn1..' '..HUDposYLine2..'')
		send_command('wait .2;text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')
		send_command('wait .7;text favor pos '..HUDposXColumn1..' '..HUDposYLine1..'')
		send_command('wait .7;text siphon pos '..HUDposXColumn2..' '..HUDposYLine1..'')
		send_command('wait .7;text apogee pos '..HUDposXColumn3..' '..HUDposYLine1..'')
		send_command('wait .7;text cede pos '..HUDposXColumn4..' '..HUDposYLine1..'')
		if player.sub_job == 'RDM' and player.sub_job_level ~= 0 then
			send_command('wait .7;text convert pos '..HUDposXColumn5..' '..HUDposYLine1..'')
		end
		send_command('wait .8;text avatar pos '..HUDposXColumn1..' '..HUDposYLine2..'')
		if NotiWeapons == 'On' then
			send_command('wait .8;text weapons pos '..HUDposXColumn4..' '..HUDposYLine2..'')
		end
		send_command('wait .9;text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')
		send_command('wait .9;text debuffs pos '..HUDposXColumn4..' '..HUDposYLine3..'')
	elseif command == 'Fileinfo' then
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(3,'-- Keys Gearswap lua file for Summoner  --')
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(200,'File Version Number '..FileVersion..'')
		windower.add_to_chat(8,' ')
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
		windower.add_to_chat(8,'Hide or show the HUD at any time by typing')
		windower.add_to_chat(200,'        //hidehud or //showhud')
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
		windower.add_to_chat(200,'AutoHWater: '..(''..AutoHWater..''):color(8)..'')
		windower.add_to_chat(200,'AutoRelease: '..(''..AutoRelease..''):color(8)..'')
		windower.add_to_chat(200,'DoomAlert: '..(''..DoomAlert..''):color(8)..'')
		windower.add_to_chat(200,'DoomOnText: '..(''..DoomOnText..''):color(8)..'')
		windower.add_to_chat(200,'DoomOffText: '..(''..DoomOffText..''):color(8)..'')
		windower.add_to_chat(200,' ')
		windower.add_to_chat(3,'-- Avatar Macro Pages --')
		windower.add_to_chat(200,'HomePage: '..(''..HomePage..''):color(8)..'')
		windower.add_to_chat(200,'IfritPage: '..(''..IfritPage..''):color(8)..'')
		windower.add_to_chat(200,'TitanPage: '..(''..TitanPage..''):color(8)..'')
		windower.add_to_chat(200,'LeviathanPage: '..(''..LeviathanPage..''):color(8)..'')
		windower.add_to_chat(200,'GarudaPage: '..(''..GarudaPage..''):color(8)..'')
		windower.add_to_chat(200,'ShivaPage: '..(''..ShivaPage..''):color(8)..'')
		windower.add_to_chat(200,'RamuhPage: '..(''..RamuhPage..''):color(8)..'')
		windower.add_to_chat(200,'CarbunclePage: '..(''..CarbunclePage..''):color(8)..'')
		windower.add_to_chat(200,'FenrirPage: '..(''..FenrirPage..''):color(8)..'')
		windower.add_to_chat(200,'CaitSithPage: '..(''..CaitSithPage..''):color(8)..'')
		windower.add_to_chat(200,'SirenPage: '..(''..SirenPage..''):color(8)..'')
		windower.add_to_chat(200,'DiabolosPage: '..(''..DiabolosPage..''):color(8)..'')
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
		windower.add_to_chat(200,'LowHPThreshold: '..(''..LowHPThreshold..''):color(8)..'')
		windower.add_to_chat(200,'DangerRepeat: '..(''..DangerRepeat..''):color(8)..'')
		windower.add_to_chat(200,'RRReminderTimer: '..(''..RRReminderTimer..''):color(8)..'')
		windower.add_to_chat(200,'NotiDelay: '..(''..NotiDelay..''):color(8)..'')
		windower.add_to_chat(200,'HUDBGTrans: '..(''..HUDBGTrans..''):color(8)..'')
		windower.add_to_chat(200,'Debug: '..(''..Debug..''):color(8)..'')
		windower.add_to_chat(200,' ')
		windower.add_to_chat(3,'-- Color Values --')
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
		send_command('text bg1 hide;text bg2 hide;text bg3 hide;text favor hide;text siphon hide;text apogee hide;text cede hide;text convert hide;text weapons hide;text notifications hide;text debuffs hide;text avatar hide')
	elseif command == 'ShowHUD' then
		ShowHUD = true
		if Debug == 'On' then
			windower.add_to_chat(8,'[ShowHUD set to True]')
		end
		send_command('text bg1 show;text bg2 show;text bg3 show;text favor show;text siphon show;text apogee show;text cede show;text convert show;text weapons show;text notifications show;text debuffs show;text avatar show')
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
			elseif player.mpp <= 20 then
				send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50;text notifications bg_transparency 1')
			elseif DTOverride == 'On' then
				send_command('text notifications text "Status: Resting (DT Override)";text notifications color 255 255 255;text notifications bg_transparency 1')
			else
				send_command('text notifications text "Status: Resting";text notifications color 255 255 255;text notifications bg_transparency 1')
			end
		end
		if DTOverride == 'On' then
			equip(set_combine(sets.rest, sets.dtoverride))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Rest + DT Override]')
			end
		else
			equip(set_combine(sets.refresh, sets.rest))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Refresh + Rest]')
			end
		end
	elseif player.status == "Engaged" then
		if LowHP == true then --no matter what Mode we're in, if we have low HP we equip the Oh Shit gear set
			equip(sets.ohshit)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Oh Shit]')
			end
		elseif DTOverride == 'On' then
			equip(set_combine(sets.dps, sets.dtoverride))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: DPS + DT Override]')
			end
			if LoadHUD == true then
				if buffactive['weakness'] then
					send_command('text notifications text "Status: Weak (DT Override)";text notifications color 205 133 63;text notifications bg_transparency 1')
								elseif player.mpp <= 20 then
					send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50;text notifications bg_transparency 1')
				else
					send_command('text notifications text "Status: Engaged (DT Override)";text notifications color 255 255 255;text notifications bg_transparency 1')
				end
			end
		else
			equip(sets.dps)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: DPS]')
			end
			if LoadHUD == true then
				if buffactive['weakness'] then
					send_command('text notifications text "Status: Weak";text notifications color 205 133 63;text notifications bg_transparency 1')
				elseif player.mpp <= 20 then
					send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50;text notifications bg_transparency 1')
				else
					send_command('text notifications text "Status: Engaged";text notifications color 255 255 255;text notifications bg_transparency 1')
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
			elseif player.mpp <= 20 then
				send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50;text notifications bg_transparency 1')
			elseif DTOverride == 'On' then
				send_command('text notifications text "Status: Idle (DT Override)";text notifications color 255 255 255;text notifications bg_transparency 1')
			else
				send_command('text notifications text "Status: Idle";text notifications color 255 255 255;text notifications bg_transparency 1')
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
			if LowHP == true then --no matter what Mode we're in, if we have low HP we equip the Oh Shit gear set
				equip(set_combine(sets.idle, sets.ohshit))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Idle + Oh Shit]')
				end
			elseif DTOverride == "On" then
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
		if LoadHUD == true then
			send_command('text debuffs text "«« TERROR »»";text debuffs color 255 50 50')
		end
		cancel_spell()
	elseif buffactive['Petrification'] then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		if LoadHUD == true then
			send_command('text debuffs text "«« PETRIFICATION »»";text debuffs color 255 50 50')
		end
		cancel_spell()
	elseif buffactive['Sleep'] then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		if LoadHUD == true then
			send_command('text debuffs text "«« SLEEP »»";text debuffs color 255 50 50')
		end
		cancel_spell()
	elseif buffactive['Stun'] then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		if LoadHUD == true then
			send_command('text debuffs text "«« STUN »»";text debuffs color 255 50 50')
		end
		cancel_spell()
	elseif buffactive['Amnesia'] and (spell.type == 'WeaponSkill' or spell.type == 'JobAbility') then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		if LoadHUD == true then
			send_command('text debuffs text "«« AMNESIA »»";text debuffs color 255 50 50')
		end
		cancel_spell()
	elseif buffactive['Silence'] and (spell.prefix == '/magic' or spell.prefix == '/ninjutsu' or spell.prefix == '/song') then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
		if LoadHUD == true then
			send_command('text debuffs text "«« SILENCE »»";text debuffs color 255 50 50')
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
		if LoadHUD == true then
			send_command('text debuffs text "«« MUTE »»";text debuffs color 255 50 50')
		end
		cancel_spell()
	elseif spell.type == 'WeaponSkill' then
		if player.tp < 1000 then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
			end
			cancel_spell()
			if LoadHUD == true then
				send_command('text notifications text "«« Not Enough TP »»";text notifications color 255 50 50;text notifications bg_transparency 1')
				NotiCountdown = NotiDelay
				if Debug == 'On' then
					windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
				end
			end
		end
		if ((spell.skill == 'Marksmanship' or spell.skill == 'Archery') and spell.target.distance >= (spell.target.model_size + 23)) or ((spell.target.distance >= (spell.target.model_size + 3)) and not (spell.english == 'Starlight' or spell.english == 'Moonlight')) then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
			end
			cancel_spell()
			if LoadHUD == true then
				send_command('text notifications text "«« Too Far »»";text notifications color 255 50 50;text notifications bg_transparency 1')
				NotiCountdown = NotiDelay
				if Debug == 'On' then
					windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
				end
			end
		end
		equip(sets.ws)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Weapon Skill]')
		end
	elseif (spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard') and not (buffactive['Astral Conduit'] or buffactive['Apogee']) then
		equip(sets.bpdelay)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: BP Delay]')
		end
	elseif spell.english == 'Astral Flow' then
		equip(sets.astralflow)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Astral Flow]')
		end
	elseif spell.english == 'Elemental Siphon' and windower.ffxi.get_ability_recasts()[175] <= 1 then
		equip(sets.elementalsiphon)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Elemental Siphon]')
		end
	elseif spell.english == 'Mana Cede' and windower.ffxi.get_ability_recasts()[71] <= 1 then
		equip(sets.manacede)
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
	elseif not (spell.english == 'Assault' or spell.english == 'Retreat' or spell.english == 'Release' or spell.english == 'Avatar\'s Favor' or string.find(spell.english,' Ring') or spell.english == 'Forbidden Key' or spell.english == 'Pickaxe' or spell.english == 'Sickle' or spell.english == 'Hatchet') then
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
	if spell.english == 'Refresh' then
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
	if spell.type == 'BloodPactRage' then
		if BPRagePhysical:contains(spell.english) then
			equip(sets.bpragephysical)
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
			equip(sets.bpwardbuff)
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

-------------------------------------------
--              AFTERCAST                --
-------------------------------------------

function aftercast(spell)
	if spell.english == 'Astral Flow' and AFTimer == 'On' and not spell.interrupted then
		if player.equipment.body == 'Summoner\'s Horn +2' or player.equipment.body == 'Glyphic Horn' or player.equipment.body == 'Glyphic Horn +1' or player.equipment.body == 'Glyphic Horn +2' or player.equipment.body == 'Glyphic Horn +3' then --these pieces extend Astral Flow by 30 seconds so we adjust accordingly
			send_command('input /echo [Astral Flow] 3:30;wait 30;input /echo [Astral Flow] 3:00;wait 30;input /echo [Astral Flow] 2:30;wait 30;input /echo [Astral Flow] 2:00;wait 30;input /echo [Astral Flow] 1:30;wait 30;input /echo [Astral Flow] 1:00;wait 30;input /echo [Astral Flow] 0:30;wait 10;input /echo [Astral Flow] 0:20;wait 10;input /echo [Astral Flow] 0:10')
		else
			send_command('input /echo [Astral Flow] 3:00;wait 30;input /echo [Astral Flow] 2:30;wait 30;input /echo [Astral Flow] 2:00;wait 30;input /echo [Astral Flow] 1:30;wait 30;input /echo [Astral Flow] 1:00;wait 30;input /echo [Astral Flow] 0:30;wait 10;input /echo [Astral Flow] 0:20;wait 10;input /echo [Astral Flow] 0:10')
		end
	elseif spell.english == 'Astral Conduit' then
		if pet.isvalid and pet.name == 'Ifrit' then
			equip(sets.bpragehybrid)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: BP Hybrid]')
			end
		elseif pet.isvalid then
			equip(sets.bpragephysical)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: BP Physical]')
			end
		end
		if ACTimer == 'On' then
			send_command('input /echo [Astral Conduit] 1:00;wait 30;input /echo [Astral Conduit] 0:30;wait 10;input /echo [Astral Conduit] 0:20;wait 10;input /echo [Astral Conduit] 0:10')
		end
	end
	if spell.type == "SummonerPact" then
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
	elseif not (spell.type == "BloodPactRage" or spell.type == "BloodPactWard" or spell.english == 'Astral Conduit') then
		choose_set()
	end
end

function pet_aftercast(spell)
	if not (buffactive['Astral Conduit'] or buffactive['Apogee']) then
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
    if status == 4 and ShowHUD == true then --In a cutscene: Hide the HUD
		ShowHUD = false
		if Debug == 'On' then
			windower.add_to_chat(8,'[ShowHUD set to False]')
		end
		send_command('text bg1 hide;text bg2 hide;text bg3 hide;text favor hide;text siphon hide;text apogee hide;text cede hide;text convert hide;text weapons hide;text notifications hide;text debuffs hide;text avatar hide')
    elseif status ~= 4 and ShowHUD == false then --Out of cutscene: Show the HUD
		ShowHUD = true
		if Debug == 'On' then
			windower.add_to_chat(8,'[ShowHUD set to True]')
		end
		send_command('text bg1 show;text bg2 show;text bg3 show;text favor show;text siphon show;text apogee show;text cede show;text convert show;text weapons show;text notifications show;text debuffs show;text avatar show')
    end
end)

-------------------------------------------
--       Buff/Debuff Notifications       --
-------------------------------------------

windower.register_event('gain buff', function(buff)
	if (buff == 270 or buff == 271 or buff == 272 or buff == 273) and AlertSounds == 'On' and NotiWeapons == 'On' then --Aftermath
		windower.play_sound(windower.addon_path..'data/sounds/AftermathOn.wav')
	elseif (buff == 2 or buff == 19) and buffactive['Stoneskin'] and not buffactive['Charm'] then --If we get slept, remove stoneskin if its on
		send_command('cancel 37')
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
	if LoadHUD == true then
		if player.equipment.main == 'Claustrum' then
			if buffactive['Aftermath'] then
				send_command('text weapons text "Aftermath: Active (DT/Refresh)";text weapons color '..Aftermath3color..'')
			elseif player.tp > 1000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath3color..'')
			else
				send_command('text weapons text "« '..EquipMain..' »";text weapons color 255 50 50')
			end
		elseif player.equipment.main == 'Hvergelmir' then
			if buffactive['Aftermath: Lv.1'] then
				if player.tp == 3000 then
					send_command('text weapons text "Aftermath: Level 1 (30% Triple Dmg)";text weapons color '..Aftermath3color..'')
				elseif player.tp < 3000 and player.tp >= 2000 then
					send_command('text weapons text "Aftermath: Level 1 (30% Triple Dmg)";text weapons color '..Aftermath2color..'')
				else
					send_command('text weapons text "Aftermath: Level 1 (30% Triple Dmg)";text weapons color '..Aftermath1color..'')
				end
			elseif buffactive['Aftermath: Lv.2'] then
				if player.tp == 3000 then
					send_command('text weapons text "Aftermath: Level 2 (40% Triple Dmg)";text weapons color '..Aftermath3color..'')
				else
					send_command('text weapons text "Aftermath: Level 2 (40% Triple Dmg)";text weapons color '..Aftermath2color..'')
				end
			elseif buffactive['Aftermath: Lv.3'] then
				send_command('text weapons text "Aftermath: Level 3 (50% Triple Dmg)";text weapons color '..Aftermath3color..'')
			elseif player.tp == 3000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath3color..'')
			elseif player.tp < 3000 and player.tp >= 2000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath2color..'')
			elseif player.tp < 2000 and player.tp >= 1000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath1color..'')
			else
				send_command('text weapons text "« '..EquipMain..' »";text weapons color 255 50 50')
			end
		elseif player.equipment.main == 'Nirvana' then
			if buffactive['Aftermath: Lv.1'] then
				if player.tp == 3000 then
					send_command('text weapons text "Aftermath: Level 1 (Accuracy)";text weapons color '..Aftermath3color..'')
				elseif player.tp < 3000 and player.tp >= 2000 then
					send_command('text weapons text "Aftermath: Level 1 (Accuracy)";text weapons color '..Aftermath2color..'')
				else
					send_command('text weapons text "Aftermath: Level 1 (Accuracy)";text weapons color '..Aftermath1color..'')
				end
			elseif buffactive['Aftermath: Lv.2'] then
				if player.tp == 3000 then
					send_command('text weapons text "Aftermath: Level 2 (Attack)";text weapons color '..Aftermath3color..'')
				else
					send_command('text weapons text "Aftermath: Level 2 (Attack)";text weapons color '..Aftermath2color..'')
				end
			elseif buffactive['Aftermath: Lv.3'] then
				send_command('text weapons text "Aftermath: Level 3 (Occ. Att. 2-3x)";text weapons color '..Aftermath3color..'')
			elseif player.tp == 3000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath3color..'')
			elseif player.tp < 3000 and player.tp >= 2000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath2color..'')
			elseif player.tp < 2000 and player.tp >= 1000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath1color..'')
			else
				send_command('text weapons text "« '..EquipMain..' »";text weapons color 255 50 50')
			end
		elseif player.equipment.main == 'Khatvanga' then
			if buffactive['Aftermath: Lv.1'] then
				if player.tp == 3000 then
					send_command('text weapons text "Aftermath: Level 1 (4-Step Ultimate)";text weapons color '..Aftermath3color..'')
				elseif player.tp < 3000 and player.tp >= 2000 then
					send_command('text weapons text "Aftermath: Level 1 (4-Step Ultimate)";text weapons color '..Aftermath2color..'')
				else
					send_command('text weapons text "Aftermath: Level 1 (4-Step Ultimate)";text weapons color '..Aftermath1color..'')
				end
			elseif buffactive['Aftermath: Lv.2'] then
				if player.tp == 3000 then
					send_command('text weapons text "Aftermath: Level 2 (3-Step Ultimate)";text weapons color '..Aftermath3color..'')
				else
					send_command('text weapons text "Aftermath: Level 2 (3-Step Ultimate)";text weapons color '..Aftermath2color..'')
				end
			elseif buffactive['Aftermath: Lv.3'] then
				send_command('text weapons text "Aftermath: Level 3 (2-Step Ultimate)";text weapons color '..Aftermath3color..'')
			elseif player.tp == 3000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath3color..'')
			elseif player.tp < 3000 and player.tp >= 2000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath2color..'')
			elseif player.tp < 2000 and player.tp >= 1000 then
				send_command('text weapons text "« '..EquipMain..' »";text weapons color '..Aftermath1color..'')
			else
				send_command('text weapons text "« '..EquipMain..' »";text weapons color 255 50 50')
			end
		else
			send_command('text weapons text "« '..EquipMain..' »";text weapons color 255 50 50')
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

	--Pet checks
	if pet.isvalid == true and PetPresent == false then --we have an avatar out when we did not have one out already (ie summoning)
		PetPresent = true
		if Debug == 'On' then
			windower.add_to_chat(8,'[PetPresent set to True]')
		end
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
	elseif pet.isvalid == false and PetPresent == true then --we do not have an avatar out when we previously did (ie releasing or they die)
		PetPresent = false
		if Debug == 'On' then
			windower.add_to_chat(8,'[PetPresent set to False]')
		end
		send_command('input /macro set '..HomePage..'')
	end

	--MP checks
	if NotiLowMP =='On' and player.mpp <= 20 and NotiLowMPToggle == 'Off' then
		NotiLowMPToggle = 'On' --turn the toggle on so this can't be triggered again until its toggled off (done below)
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
			Doom = false --turn this off so it doesn't trigger the "doom is off" notification once we raise
			if Debug == 'On' then
				windower.add_to_chat(8,'[Doom set to False]')
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
		Heartbeat = os.time()
		if AutoLockstyle == 'On' and AutoLockstyleRun == true and LockstyleDelay > 0 then
			LockstyleDelay = LockstyleDelay - 1
		elseif AutoLockstyle == 'On' and AutoLockstyleRun == true and LockstyleDelay == 0 then
			send_command('gs c Lockstyle')
			AutoLockstyleRun = false
			if Debug == 'On' then
				windower.add_to_chat(8,'[AutoLockstyleRun set to False]')
			end
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
		if player.equipment.main == nil or player.equipment.sub == nil then
			EquipMain = 'Weapon loading...'
		else
			EquipMain = player.equipment.main
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
			if NotiCountdown > 0 then
				NotiCountdown = NotiCountdown - 1
			elseif NotiCountdown == 0 then
				send_command('gs c ClearNotifications')
				NotiCountdown = -1
				if Debug == 'On' then
					windower.add_to_chat(8,'[NotiCountdown set to -1]')
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
					send_command('text avatar color 250 130 40')
				elseif pet.name == "Ramuh" or pet.name == "Thunder Spirit" then
					send_command('text avatar color 186 85 211')
				elseif pet.name == "Leviathan" or pet.name == "Water Spirit"  then
					send_command('text avatar color 30 144 255')
				elseif pet.name == "Fenrir" or pet.name == "Diabolos" or pet.name == "Atomos" or pet.name == "Odin" or pet.name == "Dark Spirit" then
					send_command('text avatar color 200 30 80')
				end
			else
				send_command('text avatar text "No Avatar"')
				send_command('text avatar color 255 50 50')
			end
			--Recast updates:
			FavorRecast = windower.ffxi.get_ability_recasts()[176]
			SiphonRecast = windower.ffxi.get_ability_recasts()[175]
			ApogeeRecast = windower.ffxi.get_ability_recasts()[108]
			CedeRecast = windower.ffxi.get_ability_recasts()[71]
			if player.sub_job == 'RDM' and player.sub_job_level ~= 0 then
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
			if player.sub_job == 'RDM' and player.sub_job_level ~= 0 then
				if ConvertRecast == 0 then ConvertColor = '255 50 50'
				else ConvertColor = '255 165 0'
				end
			end
			--Recast color updates - print the colors:
			send_command('text favor color '..FavorColor..'')
			send_command('text siphon color '..SiphonColor..'')
			send_command('text apogee color '..ApogeeColor..'')
			send_command('text cede color '..CedeColor..'')
			if player.sub_job == 'RDM' and player.sub_job_level ~= 0 then
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
			windower.add_to_chat(8,'[AutoLockstyleRun set to True]')
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
--     WS/MB/BP DAMAGE NOTIFICATION      --
-------------------------------------------

windower.register_event('action',function(act)

	local sc = {} sc[1] = 'Lght' sc[2] = 'Drkn' sc[3] = 'Grvt' sc[4] = 'Frgm' sc[5] = 'Dstn' sc[6] = 'Fusn' sc[7] = 'Cmpr' sc[8] = 'Lqfn' sc[9] = 'Indr' sc[10] = 'Rvrb' sc[11] = 'Trns' sc[12] = 'Scsn' sc[13] = 'Detn' sc[14] = 'Impc' sc[15] = 'Rdnc' sc[16] = 'Umbr'
	local weaponskills = require('resources').weapon_skills
	local spells = require('resources').spells
	local jobabilities = require('resources').job_abilities

	if NotiDamage == 'On' then
		--Weapon Skills and Skillchains:
		if act.category == 3 and act.actor_id == player.id then
			--Uses Weapon Skill but misses or gets blinked:
			if act.targets[1].actions[1].message == 188 or act.targets[1].actions[1].message == 31 then
				send_command('wait .2;text notifications text "«« '..weaponskills[act.param].english..' Missed »»";text notifications color 0 255 255;text notifications bg_transparency 1')
			--Weapon Skill lands and creates a Skillchain:
			elseif act.targets[1].actions[1].message == 185 and act.targets[1].actions[1].has_add_effect == true then
				send_command('wait .2;text notifications text "'..weaponskills[act.param].english..': '..act.targets[1].actions[1].param..' ('..sc[act.targets[1].actions[1].add_effect_animation]..': '..act.targets[1].actions[1].add_effect_param..')";text notifications color 0 255 255;text notifications bg_transparency 1')
			--Weapon Skill lands but no Skillchain:
			elseif act.targets[1].actions[1].message == 185 then
				send_command('wait .2;text notifications text "'..weaponskills[act.param].english..': '..act.targets[1].actions[1].param..'";text notifications color 0 255 255;text notifications bg_transparency 1')
			end
			NotiCountdown = -1
			if Debug == 'On' then
				windower.add_to_chat(8,'[NotiCountdown set to -1]')
			end
		--Magic Bursts:
		elseif (act.targets[1].actions[1].message == 252 or act.targets[1].actions[1].message == 265 or act.targets[1].actions[1].message == 274 or act.targets[1].actions[1].message == 379 or act.targets[1].actions[1].message == 650 or act.targets[1].actions[1].message == 749 or act.targets[1].actions[1].message == 751 or act.targets[1].actions[1].message == 753 or act.targets[1].actions[1].message == 803) and act.actor_id == player.id then
			--Magic:
			if act.category == 4 then
				send_command('wait .2;text notifications text "Magic Burst! '..spells[act.param].english..': '..act.targets[1].actions[1].param..'";text notifications color 0 255 255;text notifications bg_transparency 1')
			--Lunges:
			elseif act.category == 15 then
				send_command('wait .2;text notifications text "Magic Burst! '..jobabilities[act.param].english..': '..act.targets[1].actions[1].param..'";text notifications color 0 255 255;text notifications bg_transparency 1')
			--Blood Pacts?:
			elseif act.category == 13 then
				send_command('wait .2;text notifications text "Magic Burst! '..jobabilities[act.param].english..': '..act.targets[1].actions[1].param..'";text notifications color 0 255 255;text notifications bg_transparency 1')
			end
			NotiCountdown = -1
			if Debug == 'On' then
				windower.add_to_chat(8,'[NotiCountdown set to -1]')
			end
		--Blood Pacts:
		elseif act.category == 13 and act.actor_id == pet.id then
			send_command('wait .2;text notifications text "'..jobabilities[act.param].english..': '..act.targets[1].actions[1].param..'";text notifications color 0 255 255;text notifications bg_transparency 1')
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
	send_command('wait 1;text bg1 delete;text bg2 delete;text bg3 delete;text favor delete;text siphon delete;text apogee delete;text cede delete;text convert delete;text weapons delete;text notifications delete;text debuffs delete;text loading delete;text avatar delete') --delete the different text objects
end

--[[

-------------------------------------------
--            KEYS NOTEPAD               --
-------------------------------------------

-Auto-Favor

 --]]
