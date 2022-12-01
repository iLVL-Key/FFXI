-------------------------------------------
--  Keys Gearswap lua file for Samurai   --
-------------------------------------------
--[[

-------------------------------------------
--                 NOTES                 --
-------------------------------------------

Place both this file and the sounds folder inside the GearSwap data folder
	/addons/GearSwap/data/sounds/
	/addons/GearSwap/data/SAM.lua

To switch between gear modes, use any of these three options:
1. A macro with the following in it
	/console mode
2. An alias command
	//mode
3. A keyboard shortcut
	CTRL+G
	(Default is G, can be changed in the settings)

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

Recommended Windower Addons: Text

--]]
-------------------------------------------
--                OPTIONS                --
-------------------------------------------

AutoLockstyle	=	'On'	--[On/Off]		Automatically sets your lockstyle. Uses the Field and Town sets below.
LockstyleCombat	=	'3'		--[1-20]		Your Lockstyle set when in a field zone.
LockstyleTown	=	'1'		--[1-20]		Your Lockstyle set when in a town zone.
							--				If you do not want a separate town lockstyle, set this to the same as LockstyleCombat.
Book			=	'2'		--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
Page			=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
MeikTimer		=	'On'	--[On/Off]		Displays a timer for Meikyo Shisui in echo.
YaegTimer		=	'On'	--[On/Off]		Displays a timer for Yaegasumi in echo.
DTCtrlPlus		=	'd'		--				Sets the keyboard shortcut you would like to activate the Damage Taken Override.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions
							--				(Town limits this to town gear only)
AlertSounds		=	'On'	--[On/Off]		Plays a sound on alerts.
AutoHWater		=	'On'	--[On/Off]		Automatically attempts to use Holy Waters when you get Doomed until it wears off.
UseOhShit		=	'On'	--[On/Off]		Equips your Oh Shit gear set when your HP gets low.
DoomAlert		=	'On'	--[On/Off]		Alerts your party when you are doomed.
DoomOnText		=	'doom'			--		Text that displays in party chat when you are doomed. 
DoomOffText		=	'doom off'		--		That that displays in party chat when you are no longer doomed.

-- Heads Up Display --
HUD				=	'On'	--[On/Off]		A Heads Up Display for various things. Requires the Text Windower addon.
HUDposX			=	967		--				X position for the HUD. 0 is left of the window, increasing this number will move it to the right.
HUDposYLine1	=	745		--				Y position for the HUD. 0 is top of the window, increasing this number will move it downward.
							--				Note that this is for the first line of the HUD, the other lines will self-adjust. If you cannot
							--				see the HUD, set the x and y both to 100 to make sure it is showing up, then adjust from there.
FontSize		=	12		--				Font size. Changing this will require you to adjust the Spacers below as well.
LineSpacer		=	20		--				Space in pixels between each Line of the HUD
ColumnSpacer	=	93		--				Space in pixels between each Column of the HUD

--HUD Mode Names
Mode1Name = 'Multi-Attack'	--Names displayed in the HUD for Hasso Mode 1, 2, and 3.
Mode2Name = 'All-Round'		--Change these as you see fit if you want to use them for different types of gear.
Mode3Name = 'High Accuracy'

--  General Notifications  --
Noti3000TP			=	'On'	--[On/Off]	Displays a notification when you have 3000 TP.
NotiAftermath		=	'On'	--[On/Off]	Displays Aftermath information.
NotiTrade			=	'On'	--[On/Off]	Displays a notification when someone trades you.
NotiInvite			=	'On'	--[On/Off]	Displays a notification when someone invites to a party/alliance.
NotiSneak			=	'On'	--[On/Off]	Displays a notification when Sneak is about to wear off.
NotiInvis			=	'On'	--[On/Off]	Displays a notification when Invisible is about to wear off.
NotiReraise			=	'On'	--[On/Off]	Displays a notification when reraise wears off.
NotiFood			=	'On'	--[On/Off]	Displays a notification when food wears off.
NotiLowHP			=	'On'	--[On/Off]	Displays a notification when HP is low.
NotiWSDamage		=	'On'	--[On/Off]	Displays your Weapon Skill damage.
ReraiseReminder		=	'On'	--[On/Off]	Displays an occasional reminder if Reraise is not up.
NotiTime			=	'On'	--[On/Off]	Displays a notification for time remaining notices.
NotiOmen			=	'On'	--[On/Off]	Party chat notifications for Scale drops in Omen.
NotiVagary			=	'On'	--[On/Off]	Party chat notifications for Perfidien and Plouton popping, as well as elemental weaknesses.

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

StartMode			=	'Mode1'	--[Mode1/Mode2/Mode3]
								--Determines the Mode you will start in. Current Mode can be changed at any time by using any of the 
								--three options listed above in the Notes section (a macro, alias, or keyboard shortcut).
ModeCtrlPlus		=	'g'		--Sets the keyboard shortcut you would like to cycle between Modes. CTRL+G is default.
DangerSound			=	'C'		--[C/O] Danger Sound will play [C]onstantly or [O]nce.
LowHPThreshold		=	1000	--If your HP goes below this number, your Oh Shit gear set will activate.
RRReminderTimer		=	1800	--Delay in seconds between checks to see if Reraise is up (300 is 5 minutes)
HUDBGTrans			= 	'175'	--Background transparency for the HUD. (0 = fully clear, 255 = fully opaque)
Debug				=	'On'	--[On/Off]

--Color values in RGB for the HUD stances
HassoStanceColor	=	'125 125 255'	--Hasso
SeiganStanceColor	=	'255 125 125'	--Seigan

--Color values in RGB for the HUD Aftermath status
Aftermath1color		=	'0 127 255'		--Aftermath Level 1
Aftermath2color		=	'75 255 75'		--Aftermath Level 2
Aftermath3color		=	'255 255 50'	--Aftermath Level 3

-------------------------------------------
--               GEAR SETS               --
-------------------------------------------

function get_sets()

	-- Hasso Mode 1 (Example: Hasso+, with a focus on Multi-Attack, Zanshin, and Store TP, then filling in the rest with DEX, Accuracy, and Attack)
	sets.hassomodeone = {
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Kasuga Domaru +3",
		hands="Tatena. Gote +1",
		legs="Kasuga Haidate +3",
		feet="Ryuo Sune-Ate +1",
		neck="Sam. Nodowa +2",
		waist="Ioskeha Belt +1",
		left_ear="Brutal Earring",
		right_ear="Schere Earring",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
	}

	-- Hasso Mode 2 (Example: Hasso+, with a mix of Multi-Attack, Zanshin, Store TP, DEX, Accuracy, and Attack)
	sets.hassomodetwo = {
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Kasuga Domaru +3",
		hands="Tatena. Gote +1",
		legs="Kasuga Haidate +3",
		feet="Tatena. Sune. +1",
		neck="Sam. Nodowa +2",
		waist="Ioskeha Belt +1",
		left_ear="Brutal Earring",
		right_ear="Schere Earring",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
	}

	-- Hasso Mode 3 (Example: Hasso+, with a focus on DEX and Accuracy, then filling in the rest with Multi-Attack, Zanshin, Store TP, and Attack)
	sets.hassomodethree = {
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Kasuga Domaru +3",
		hands="Tatena. Gote +1",
		legs="Kasuga Haidate +3",
		feet="Tatena. Sune. +1",
		neck="Sam. Nodowa +2",
		waist="Ioskeha Belt +1",
		left_ear="Brutal Earring",
		right_ear="Schere Earring",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
	}

	-- Seigan (Seigan+, Third Eye+, Counter, DT-)
	-- Intended as a more defense oriented set for when you have to put Seigan up.
	sets.seigan = {
		ammo="Staunch Tathlum",
		head="Kasuga Kabuto +2",
		body="Mpaca's Doublet",
		--body="Dagon Breast.",
		hands="Mpaca's Gloves",
		legs="Sakonji Haidate +3",
		--legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Sam. Nodowa +2",
		waist="Ioskeha Belt +1",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Defending Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
	}

	-- Idle (Movement Speed, Regain, Regen)
	sets.idle = {
		head="Wakido Kabuto +3",
		feet="Danzo Sune-ate",
		neck="Rep. Plat. Medal",
		left_ring="Karieyh Ring +1",
	}

	-- DT Override (Damage Taken-, Magic Evasion)
	-- Will override all other gear sets and inherit unused slots from them
	sets.dtoverride = {
		head="Kasuga Kabuto +2",
		body="Kasuga Domaru +3",
		legs="Kasuga Haidate +3",
		feet="Nyame Sollerets",
		left_ring="Defending Ring",
	}

	-- Oh Shit
	-- Full DT- and everything you've got with Absorbs or Annuls Damage
	sets.ohshit = {
		head="Kasuga Kabuto +2",
		body="Kasuga Domaru +3",
		legs="Kasuga Haidate +3",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		left_ring="Defending Ring",
		right_ring="Shadow Ring",
		back="Shadow Mantle"
	}


	-- Weapon Skill (TP Bonus, STR, Weapon Skill Damage, Attack, Double/Triple Attack)
	sets.ws = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Sakonji Domaru +3",
		hands="Kasuga Kote +3",
		legs="Wakido Haidate +3",
		feet="Nyame Sollerets",
		neck="Sam. Nodowa +2",
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}

	-- Capped TP Weapon Skill (STR, Weapon Skill Damage, Attack, Double/Triple Attack)
	-- Intended to override any TP Bonus pieces in your Weapon Skill set if you're already at capped TP
	sets.cappedtpws = set_combine(sets.ws, {
		head="Nyame Helm",
		left_ear="Lugra Earring +1",
	})

	-- Hybrid Weapon Skill (Fotias, STR, INT, Weapon Skill Damage, Magic Attack Bonus, Attack, Double/Triple Attack)
	sets.hybridws = set_combine(sets.ws, {

	})

	-- Sekkanoki
	sets.sekkanoki = {
		hands="Kasuga Kote +3",
	}

	-- Shikikoyo
	sets.shikikoyo = {
		legs="Sakonji Haidate +3",
	}

	-- Blade Bash
	sets.bladebash = {

	}

	-- Sengikori
	sets.sengikori = {
		feet="Kasuga Sune-Ate +2",
	}

	-- Meditate
	sets.meditate = {
		head="Wakido Kabuto +3",
		hands="Sakonji Kote +3",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Occ. inc. resist. to stat. ailments+10',}},
	}
 
	-- Jump (Jumps+, VIT+ Double/Triple Attack, Attack, 
	sets.jump = {
		hands="Crusher Gauntlets",
		feet="Maenadic Gambieras",
	}

	-- Warding Circle
	sets.wardingcircle = {
		head="Wakido Kabuto +3"
	}

	-- Meikyo Shisui
	sets.meikyoshisui = {
		feet="Sak. Sune-Ate +3",
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
TopVersion = 'Tachi: Kagero' --Leave this alone, used for debugging purposes



	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX          DO NOT EDIT BELOW THIS LINE          XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--



BottomVersion = 'Tachi: Kagero'
FileVersion = '11.30.22'

-------------------------------------------
--               UPDATES                 --
-------------------------------------------

--[[
If the new updates Version Compatibility Codename matches your current files TopVersion,
simply replace everything under the "Do Not Edit Below This Line".
Only when the Version Compatibility Codename changes will you need to update the entire file.

11.30.22 (Version Compatibility Codename: Tachi: Kagero)
-Overhauled how death is handled. More cleanly prevents unnecessary notifications from activating immediately upon raising (ie Reraise wearing off and Low HP).
-Added Danger sound file. Used by Doom and Low HP.
-Added Advanced Option for the Danger sound to play constantly while in danger or only once (with a 30 second delay to be able to play again).
-Added WSDamage option. Displays your damage (or miss) after a Weapon Skill.
-Added the //hidehud and //showhud alias commands.
-Added debug lines for redefining variables.
-Adjusted Low HP Notification to not trigger while weakened.
-Adjusted Low HP Notification Sound to have a 30 second window after triggering where it will not trigger again.
-Adjusted HUD text object loading timing to avoid them occasionally not loading correctly.
-Adjusted AutoHWater option to stop and notify you once you are out of useable Holy Waters.
-Adjusted the Trade notification to clear once the trade is complete.
-Removed the option to turn off the HUDRecast. While I generally think the more options the better, the recasts are a main part of the HUD.
-Removed the CharmNaked option. Apparently you can't Do Stuff while charmed ¯\_(ツ)_/¯
-Fixed incorrect SP Ability timers when wearing gear that augments (adds additional time to) the ability.
-Fixed ordering of Status Notifications.
-Renamed OhShitThreshold to LowHPThreshold since it controls more than just the OhShit option.
-Updated Version Compatibility Codename to Tachi: Kagero.
-Code cleanup.

10.15.22 (Version Compatibility Codename: Tachi: Goten)
-Renamed Mode to Stance.
-Added new Hasso Modes. Seigan still uses one set while Hasso is split into 3. These modes can be used (and named) however you'd like. You can switch between the 3 modes on the fly with a macro, alias, or keyboard shortcut.
-Added Capped TP Weapon Skill set.
-Added Hybrid Weaponskill set.
-Added an Oh Shit gear set and accompanying option to use it. HP threshold required to activate is adjustable in the Advanced Options.
-Added Low HP Notification.
-Added AutoHWater option. Automatically attempts to use Holy Waters when you get Doomed until it wears off. Currently will keep trying even if you run out of Holy Waters.
-Added DoomAlert option. Will alert your party when you are doomed. You can also customize the text that displays in party chat.
-Added Sneak and Invisible status notification.
-Added missing listings in the /fileinfo printout for a few Notifications.
-Added Silver Knife to list of Adoulin/Town areas.
-Adjusted CharmNaked option to have three options: all gear, all gear except weapons, or off.
-Adjusted the code that tries to wake you when you are asleep to not trigger if you are charmed.
-Moved RRReminderTimer from Options to Advanced Options.
-Removed Gearswaps built-in showswaps function from the files debug mode.
-Updated Version Compatibility Codename to Tachi: Goten.
-Code cleanup.

09.04.22 (Version Compatibility Codename: Tachi: Hobaku)
-Added all DOTs to the rule that removes Stoneskin if asleep.

08.13.22 (Version Compatibility Codename: Tachi: Hobaku)
-Added Leafallia to list of towns.
-Added equipping the DT Override set when petrified, stunned, or terrored.
-Added option to remove all gear (except weapons) when you are charmed.
-Added a Holy Water set.
-Adjusted the Vim Torque code to first remove Stoneskin if its up, then check that we're not already poisoned and HP is above 50.
-Adjusted abilities to not equip their gear sets if they are still on cooldown.
-Renamed LockstyleField to LockstyleCombat. Just makes more sense.
-Fixed an issue where the debuff background color change from Doom (flashing white and yellow) would get stuck on yellow after Doom wears off and you have another debuff on that takes over in the debuff spot.
-Fixed a duplicate line in the sleep debuff code.
-Updated Version Compatibility Codename to Tachi: Hobaku.
-Code cleanup.

07.18.22 (Version Compatibility Codename: Tachi: Enpi)
-Overhauled how area checks are handled. Uses tables now for groups of areas.
-Fixed some errors that would show up on job change. These were caused by the Heartbeat function constantly checking for any debuffs present; when you unload the file (change job) it will delete the debuff text objects used for the HUD which will cause a split second where the debuff check freaks out. The fix was to simply disable the debuff checks in town zones.
-Fixed the DTOverride set not equipping correctly when idle.
-Fixed an issue with the Sleep debuff not showing properly in the HUD.
-Code cleanup.

06.14.22 (Version Compatibility Codename: Tachi: Enpi)
-Adjusted HUD timings on load. Should fix the occasional errors about text objects not existing as well as objects loading underneath the background layer.
-Fixed Relic Aftermath not displaying in the HUD.
-Removed Gearswaps built-in debugmode from the files Debug mode.
-Moved the Updates section towards the top of the file.
-Code cleanup.

03.10.22 (Version Compatibility Codename: Tachi: Enpi)
-Added missing On/Off option/rules to Time Remaining (currently only for Abyssea), Omen, and Vagary
-Fixed Alliance invite incorrectly triggering Party invite notification.
-Fixed some subjob conditions throwing errors when you have no subjob (ie Odyssey NMs)

02.02.22 (Version Compatibility Codename: Tachi: Enpi)
-Added Weak status notification.
-Fixed gear not fully equipping in towns.
-Fixed Abyssea Visitant status triggering on incorrect time remaining (ie 110 minutes would trigger the 10 minute)

02.01.22 (Version Compatibility Codename: Tachi: Enpi)
-First version
-Started from Blue Mage file version 02.01.22 (Version Compatibility Codename: Pollen)
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
--           HYBRID WS MAPPING           --
-------------------------------------------

HybridWS = S{
	'Flaming Arrow','Tachi: Goten','Tachi: Kagero','Tachi: Jinpu','Tachi: Koki'
    }

-------------------------------------------
--              FILE LOAD                --
-------------------------------------------

Mode = StartMode --sets the starting mode (selected in Advanced Options)
Stance = 'None' --Start off without Hasso/Seigan up, this will update when either is activated
DTOverride = "Off" --Start with the Damage Taken Override off
NotiLowHPToggle = 'Off' --start with the toggle off for the Low HP Notification so that it can trigger
RRRCountdown = RRReminderTimer
HWaterRecast = 0
HWater = true --this is used as a simple on/off for when we run out of Holy Waters
Heartbeat = 0 --set to 0 just to start the Heartbeat running
LoadDelay = 4 --delays loading the HUD, this makes sure all the variables get set correctly before being used, displays file version info, and waits to use lockstyle
LoadHUD = false --starts false then switched to true after the LoadDelay
ShowHUD = true --this changes to false when we zone or are in a cutscene
LockstyleDelay = 3
AutoLockstyleRun = true
LowHP = false
Doom = false
Alive = true --makes it easier to Do Things or Not Do Things based on if we die.
LastWS = "WS Damage"

--set the initial recasts to 0, they will get updated in the Heartbeat function:
MeditateRecast = 0
SekkanokiRecast = 0
SengikoriRecast = 0
HagakureRecast = 0
AggressorRecast = 0
BerserkRecast = 0
HighJumpRecast = 0
SuperJumpRecast = 0
HassoRecast = 0
SeiganRecast = 0

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
	send_command('wait '..LoadDelay..';gs c LoadHUD')
	--Create all the HUD Background text objects and put them above the screen for now, we'll move them to the correct place next
	send_command('wait .5;text bg1 create "                                                                                                                          ";wait .3;text bg1 size '..FontSize..';text bg1 pos '..HUDposXColumn1..' '..HUDposYLine1..';text bg1 bg_transparency '..HUDBGTrans..'')--Background Line 1
	send_command('wait .6;text bg2 create "                                                                                                                          ";wait .3;text bg2 size '..FontSize..';text bg2 pos '..HUDposXColumn1..' -100;text bg2 bg_transparency '..HUDBGTrans..'')--Background Line 2
	send_command('wait .7;text bg3 create "                                                                                                                          ";wait .3;text bg3 size '..FontSize..';text bg3 pos '..HUDposXColumn1..' -100;text bg3 bg_transparency '..HUDBGTrans..'')--Background Line 3
	send_command('wait .8;text loading create "Loading Keys SAMURAI file ver: '..FileVersion..'...";wait .3;text loading size '..FontSize..';text loading pos '..HUDposXColumn1..' '..HUDposYLine1..';text loading bg_transparency 1') --Loading
	--Create the Aftermath, Stance, Notifications, and Debuffs text objects and put them above the screen for now, we'll move them to the correct place next
	send_command('wait .9;text aftermath create "Aftermath: None";wait .3;text aftermath size '..FontSize..';text aftermath pos '..HUDposXColumn4..' -100;text aftermath color 255 50 50;text aftermath bg_transparency 1') --Aftermath
	send_command('wait 1;text stance create "Stance: '..Stance..'";wait .3;text stance size '..FontSize..';text stance pos '..HUDposXColumn1..' -100;text stance color 255 50 50;text stance bg_transparency 1') --Stance
	send_command('wait 1.1;text notifications create "Hello, '..player.name..'! (type //fileinfo for more information)";wait .3;text notifications size '..FontSize..';text notifications pos '..HUDposXColumn1..' -100;text notifications bg_transparency 1') --Notifications
	send_command('wait 1.2;text debuffs create " ";wait .3;text debuffs size '..FontSize..';text debuffs pos '..HUDposXColumn4..' -100;text debuffs bg_transparency 1') --Debuffs
	--Create all the HUD Recast text objects and put them above the screen for now, we'll move them to the correct place next
	send_command('wait 1.3;text meditate create "[ Meditate ]";wait .3;text meditate size '..FontSize..';text meditate pos '..HUDposXColumn1..' -100;text meditate bg_transparency 1')
	send_command('wait 1.4;text sekkanoki create "[ Sekkanoki ]";wait .3;text sekkanoki size '..FontSize..';text sekkanoki pos '..HUDposXColumn1..' -100;text sekkanoki bg_transparency 1')
	send_command('wait 1.5;text sengikori create "[ Sengikori ]";wait .3;text sengikori size '..FontSize..';text sengikori pos '..HUDposXColumn1..' -100;text sengikori bg_transparency 1')
	send_command('wait 1.6;text hagakure create "[ Hagakure ]";wait .3;text hagakure size '..FontSize..';text hagakure pos '..HUDposXColumn1..' -100;text hagakure bg_transparency 1')
	send_command('wait 1.7;text highjump create "[ High J. ]";wait .3;text highjump size '..FontSize..';text highjump pos '..HUDposXColumn1..' -100;text highjump bg_transparency 1')
	send_command('wait 1.8;text superjump create "[ Super J. ]";wait .3;text superjump size '..FontSize..';text superjump pos '..HUDposXColumn1..' -100;text superjump bg_transparency 1')
	send_command('wait 1.9;text aggressor create "[ Aggres. ]";wait .3;text aggressor size '..FontSize..';text aggressor pos '..HUDposXColumn1..' -100;text aggressor bg_transparency 1')
	send_command('wait 2.0;text berserk create "[ Berserk ]";wait .3;text berserk size '..FontSize..';text berserk pos '..HUDposXColumn1..' -100;text berserk bg_transparency 1')
	send_command('wait 2.1;text hasso create "[ Hasso ]";wait .3;text hasso size '..FontSize..';text hasso pos '..HUDposXColumn1..' -100;text hasso bg_transparency 1')
	send_command('wait 2.2;text seigan create "[ Seigan ]";wait .3;text seigan size '..FontSize..';text seigan pos '..HUDposXColumn1..' -100;text seigan bg_transparency 1')
else
	windower.add_to_chat(8,'Keys SAMURAI file ver: '..FileVersion..'')
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
send_command('alias mode gs c Mode') --creates the Mode alias
send_command('alias hidehud gs c HideHUD') --creates the HideHUD alias
send_command('alias showhud gs c ShowHUD') --creates the ShowHUD alias
send_command('bind ^'..ModeCtrlPlus..' gs c Mode') --creates the gear mode keyboard shortcut
send_command('bind ^'..DTCtrlPlus..' gs c DT') --creates the DT Override keyboard shortcut
send_command('alias dt gs c DT') --creates the DT Override and alias
if Debug == 'On' then
	windower.add_to_chat(8,'[Debug Mode: On]')
end

-------------------------------------------
--            SELF COMMANDS              --
-------------------------------------------

function self_command(command)
	if command == 'Mode' then
		if Mode == 'Mode1' then
			Mode = 'Mode2'
			if HUD == 'On' then
				if Stance == 'Hasso' then
					send_command('text stance text "Stance: Hasso ('..Mode2Name..')"')
				end
			else
				windower.add_to_chat(8,'Stance: Hasso ('..Mode2Name..')')
			end
		elseif Mode == 'Mode2' then
			Mode = 'Mode3'
			if HUD == 'On' then
				if Stance == 'Hasso' then
					send_command('text stance text "Stance: Hasso ('..Mode3Name..')"')
				end
			else
				windower.add_to_chat(8,'Stance: Hasso ('..Mode3Name..')')
			end
		elseif Mode == 'Mode3' then
			Mode = 'Mode1'
			if HUD == 'On' then
				if Stance == 'Hasso' then
					send_command('text stance text "Stance: Hasso ('..Mode1Name..')"')
				end
			else
				windower.add_to_chat(8,'Stance: Hasso ('..Mode1Name..')')
			end
		end
		if Debug == 'On' then
			windower.add_to_chat(8,'[Mode set to '..Mode..']')
		end
		choose_set()
	elseif command == 'DT' then
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
	elseif command == 'ClearNotifications' and HUD == 'On' then --these reset the Notifications display back to a basic state
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
	elseif command == 'ClearDebuffs' then --these reset the Debuffs display back to a basic state
		send_command('text debuffs text "";text debuffs color 255 255 255;text debuffs bg_transparency 1')
	elseif command == 'LoadHUD' then
		LoadHUD = true
		if Debug == 'On' then
			windower.add_to_chat(8,'[LoadHUD set to True]')
		end
		send_command('text loading hide')
		send_command('wait .1;text bg2 pos '..HUDposXColumn1..' '..HUDposYLine2..'')
		send_command('wait .2;text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')
		send_command('wait .7;text stance pos '..HUDposXColumn1..' '..HUDposYLine2..'')
		send_command('wait .8;text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')
		send_command('wait .8;text debuffs pos '..HUDposXColumn4..' '..HUDposYLine3..'')
		if player.equipment.main == 'Amanomurakumo' or player.equipment.main == 'Kogarasumaru' or player.equipment.main == 'Masamune' or player.equipment.main == 'Dojikiri Yasutsuna' then
			send_command('wait .7;text aftermath pos '..HUDposXColumn4..' '..HUDposYLine2..'')
			REMA = true
			if Debug == 'On' then
				windower.add_to_chat(8,'[REMA set to True]')
			end
		else
			REMA = false
			if Debug == 'On' then
				windower.add_to_chat(8,'[REMA set to False]')
			end
		end
	elseif command == 'Fileinfo' then
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(3,'--  Keys Gearswap lua file for Samurai  --')
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
		windower.add_to_chat(3,'--                   Notes                   --')
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(8,'Place both this file and the sounds folder')
		windower.add_to_chat(8,'inside the GearSwap data folder')
		windower.add_to_chat(200,'ex:     /addons/GearSwap/data/sounds/')
		windower.add_to_chat(200,'        /addons/GearSwap/data/SAM.lua')
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
		windower.add_to_chat(8,'To activate Damage Taken Override, use any of these three options:')
		windower.add_to_chat(8,'1. A macro with the following in it')
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
		windower.add_to_chat(8,'For the HUD function, suggested placement')
		windower.add_to_chat(8,'is center screen, just above your chat log.')
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
		windower.add_to_chat(200,'MeikTimer: '..(''..MeikTimer..''):color(8)..'')
		windower.add_to_chat(200,'YaegTimer: '..(''..YaegTimer..''):color(8)..'')
		windower.add_to_chat(200,'DTCtrlPlus: '..(''..DTCtrlPlus..''):color(8)..'')
		windower.add_to_chat(200,'ZoneGear: '..(''..ZoneGear..''):color(8)..'')
		windower.add_to_chat(200,'AlertSounds: '..(''..AlertSounds..''):color(8)..'')
		windower.add_to_chat(200,'AutoHWater: '..(''..AutoHWater..''):color(8)..'')
		windower.add_to_chat(200,'UseOhShit: '..(''..UseOhShit..''):color(8)..'')
		windower.add_to_chat(200,'DoomAlert: '..(''..DoomAlert..''):color(8)..'')
		windower.add_to_chat(200,'DoomOnText: '..(''..DoomOnText..''):color(8)..'')
		windower.add_to_chat(200,'DoomOffText: '..(''..DoomOffText..''):color(8)..'')
		windower.add_to_chat(200,' ')
		windower.add_to_chat(3,'-- Heads Up Display --')
		windower.add_to_chat(200,'HUD: '..(''..HUD..''):color(8)..'')
		windower.add_to_chat(200,'HUDposX: '..(''..HUDposX..''):color(8)..'')
		windower.add_to_chat(200,'HUDposYLine1: '..(''..HUDposYLine1..''):color(8)..'')
		windower.add_to_chat(200,'FontSize: '..(''..FontSize..''):color(8)..'')
		windower.add_to_chat(200,'LineSpacer: '..(''..LineSpacer..''):color(8)..'')
		windower.add_to_chat(200,'ColumnSpacer: '..(''..ColumnSpacer..''):color(8)..'')
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
		windower.add_to_chat(200,'NotiLowHP: '..(''..NotiLowHP..''):color(8)..'')
		windower.add_to_chat(200,'NotiWSDamage: '..(''..NotiWSDamage..''):color(8)..'')
		windower.add_to_chat(200,'ReraiseReminder: '..(''..ReraiseReminder..''):color(8)..'')
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
		windower.add_to_chat(200,'StartMode: '..(''..StartMode..''):color(8)..'')
		windower.add_to_chat(200,'ModeCtrlPlus: '..(''..ModeCtrlPlus..''):color(8)..'')
		windower.add_to_chat(200,'LowHPThreshold: '..(''..LowHPThreshold..''):color(8)..'')
		windower.add_to_chat(200,'RRReminderTimer: '..(''..RRReminderTimer..''):color(8)..'')
		windower.add_to_chat(200,'HUDBGTrans: '..(''..HUDBGTrans..''):color(8)..'')
		windower.add_to_chat(200,'Debug: '..(''..Debug..''):color(8)..'')
		windower.add_to_chat(200,'HassoStanceColor: '..(''..HassoStanceColor..''):color(8)..'')
		windower.add_to_chat(200,'SeiganStanceColor: '..(''..SeiganStanceColor..''):color(8)..'')
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
		if HUD == 'On' then
			send_command('text notifications text "«« Radialens Has Worn Off »»";text notifications color 255 50 50;text notifications bg_transparency 1')
		end
	elseif command == 'NotiLowHPToggle' then
		NotiLowHPToggle = 'Off'
		if Debug == 'On' then
			windower.add_to_chat(8,'[NotiLowHPToggle set to Off]')
		end
	elseif command == 'AliveDelay' then
		Alive = true --putting this in a command lets us set a small delay to prevent things from triggering right when we raise up
		if Debug == 'On' then
			windower.add_to_chat(8,'[Alive set to True]')
		end
	elseif command == 'HideHUD' then
		if HUD == 'On' and ShowHUD == true then --In a cutscene: Hide the HUD
			ShowHUD = false
			if Debug == 'On' then
				windower.add_to_chat(8,'[ShowHUD set to False]')
			end
			send_command('text bg1 hide;text bg2 hide;text bg3 hide;text meditate hide;text sekkanoki hide;text sengikori hide;text hagakure hide;text aggressor hide;text berserk hide;text highjump hide;text superjump hide;text hasso hide;text seigan hide;text stance hide;text notifications hide;text debuffs hide;text aftermath hide')
		end
	elseif command == 'ShowHUD' then
		if HUD == 'On' and ShowHUD == false then --Out of cutscene: Show the HUD
			ShowHUD = true
			if Debug == 'On' then
				windower.add_to_chat(8,'[ShowHUD set to True]')
			end
			send_command('text bg1 show;text bg2 show;text bg3 show;text meditate show;text sekkanoki show;text sengikori show;text hagakure show;text aggressor show;text berserk show;text highjump show;text superjump show;text hasso show;text seigan show;text stance show;text notifications show;text debuffs show;text aftermath show')
		end
	end
end

-------------------------------------------
--              CHOOSE SET               --
-------------------------------------------

function choose_set()
	if player.status == "Resting" and HUD == 'On' then
		if buffactive['weakness'] and DTOverride == 'On' then
			send_command('text notifications text "Status: Weak (DT Override)";text notifications color 205 133 63;text notifications bg_transparency 1')
		elseif buffactive['weakness'] then
			send_command('text notifications text "Status: Weak";text notifications color 205 133 63;text notifications bg_transparency 1')
		elseif DTOverride == 'On' then
			send_command('text notifications text "Status: Resting (DT Override)";text notifications color 255 255 255;text notifications bg_transparency 1')
		else
			send_command('text notifications text "Status: Resting";text notifications color 255 255 255;text notifications bg_transparency 1')
		end
	elseif player.status == "Engaged" then
		if HUD == 'On' then 
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
		if LowHP == true then --no matter what Stance we're in, if we have low HP we equip the Oh Shit gear set
			equip(sets.ohshit)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Oh Shit]')
			end
		elseif Stance == 'Hasso' then
			if DTOverride == 'On' then
				if Mode == 'Mode1' then
					equip(set_combine(sets.hassomodeone, sets.dtoverride))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Hasso Mode 1 ('..Mode1Name..') + DT Override]')
					end
				elseif Mode == 'Mode2' then
					equip(set_combine(sets.hassomodetwo, sets.dtoverride))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Hasso Mode 2 ('..Mode2Name..') + DT Override]')
					end
				elseif Mode == 'Mode3' then
					equip(set_combine(sets.hassomodethree, sets.dtoverride))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Hasso Mode 3 ('..Mode3Name..') + DT Override]')
					end
				end
			else
				if Mode == 'Mode1' then
					equip(sets.hassomodeone)
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 1 ('..Mode1Name..')]')
					end
				elseif Mode == 'Mode2' then
					equip(sets.hassomodetwo)
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 2 ('..Mode2Name..')]')
					end
				elseif Mode == 'Mode3' then
					equip(sets.hassomodethree)
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 3 ('..Mode3Name..')]')
					end
				end
			end
		elseif Stance == 'Seigan' then
			if DTOverride == 'On' then
				equip(set_combine(sets.seigan, sets.dtoverride))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Seigan + DT Override]')
				end
			else
				equip(sets.seigan)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Seigan]')
				end
			end
		end
	elseif player.status == "Idle" then 
		if HUD == 'On' then 
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
			if Stance == 'Seigan' then
				equip(set_combine(sets.seigan, sets.adoulin, sets.idle))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Seigan + Adoulin + Idle]')
				end
			else
				if Mode == 'Mode1' then
					equip(set_combine(sets.hassomodeone, sets.adoulin, sets.idle))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 1 ('..Mode1Name..') + Adoulin + Idle]')
					end
				elseif Mode == 'Mode2' then
					equip(set_combine(sets.hassomodetwo, sets.adoulin, sets.idle))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 2 ('..Mode2Name..') + Adoulin + Idle]')
					end
				elseif Mode == 'Mode3' then
					equip(set_combine(sets.hassomodethree, sets.adoulin, sets.idle))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 3 ('..Mode3Name..') + Adoulin + Idle]')
					end
				end
			end
		elseif BastokZones:contains(world.area) then
			if Stance == 'Seigan' then
				equip(set_combine(sets.seigan, sets.bastok, sets.idle))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Seigan + Bastok + Idle]')
				end
			else
				if Mode == 'Mode1' then
					equip(set_combine(sets.hassomodeone, sets.bastok, sets.idle))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 1 ('..Mode1Name..') + Bastok + Idle]')
					end
				elseif Mode == 'Mode2' then
					equip(set_combine(sets.hassomodetwo, sets.bastok, sets.idle))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 2 ('..Mode2Name..') + Bastok + Idle]')
					end
				elseif Mode == 'Mode3' then
					equip(set_combine(sets.hassomodethree, sets.bastok, sets.idle))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 3 ('..Mode3Name..') + Bastok + Idle]')
					end
				end
			end
		elseif SandyZones:contains(world.area) then
			if Stance == 'Seigan' then
				equip(set_combine(sets.seigan, sets.sandoria, sets.idle))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Seigan + San d\'Oria + Idle]')
				end
			else
				if Mode == 'Mode1' then
					equip(set_combine(sets.hassomodeone, sets.sandoria, sets.idle))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 1 ('..Mode1Name..') + San d\'Oria + Idle]')
					end
				elseif Mode == 'Mode2' then
					equip(set_combine(sets.hassomodetwo, sets.sandoria, sets.idle))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 2 ('..Mode2Name..') + San d\'Oria + Idle]')
					end
				elseif Mode == 'Mode3' then
					equip(set_combine(sets.hassomodethree, sets.sandoria, sets.idle))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 3 ('..Mode3Name..') + San d\'Oria + Idle]')
					end
				end
			end
		elseif WindyZones:contains(world.area) then
			if Stance == 'Seigan' then
				equip(set_combine(sets.seigan, sets.windurst, sets.idle))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Seigan + Windurst + Idle]')
				end
			else
				if Mode == 'Mode1' then
					equip(set_combine(sets.hassomodeone, sets.windurst, sets.idle))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 1 ('..Mode1Name..') + Windurst + Idle]')
					end
				elseif Mode == 'Mode2' then
					equip(set_combine(sets.hassomodetwo, sets.windurst, sets.idle))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 2 ('..Mode2Name..') + Windurst + Idle]')
					end
				elseif Mode == 'Mode3' then
					equip(set_combine(sets.hassomodethree, sets.windurst, sets.idle))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 3 ('..Mode3Name..') + Windurst + Idle]')
					end
				end
			end
		elseif TownZones:contains(world.area) then
			if Stance == 'Seigan' then
				equip(set_combine(sets.seigan, sets.town, sets.idle))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Seigan + Town + Idle]')
				end
			else
				if Mode == 'Mode1' then
					equip(set_combine(sets.hassomodeone, sets.town, sets.idle))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 1 ('..Mode1Name..') + Town + Idle]')
					end
				elseif Mode == 'Mode2' then
					equip(set_combine(sets.hassomodetwo, sets.town, sets.idle))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 2 ('..Mode2Name..') + Town + Idle]')
					end
				elseif Mode == 'Mode3' then
					equip(set_combine(sets.hassomodethree, sets.town, sets.idle))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 3 ('..Mode3Name..') + Town + Idle]')
					end
				end
			end
		elseif LowHP == true then --no matter what Stance we're in, if we have low HP we equip the Oh Shit gear set
			equip(set_combine(sets.idle, sets.ohshit))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Idle + Oh Shit]')
			end
		elseif DTOverride == 'On' then
			if Stance == 'Seigan' then
				equip(set_combine(sets.seigan, sets.idle, sets.dtoverride))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Seigan + DT Override + Idle]')
				end
			else
				if Mode == 'Mode1' then
					equip(set_combine(sets.hassomodeone, sets.idle, sets.dtoverride))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 1 ('..Mode1Name..') + Idle + DT Override]')
					end
				elseif Mode == 'Mode2' then
					equip(set_combine(sets.hassomodetwo, sets.idle, sets.dtoverride))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 2 ('..Mode2Name..') + Idle + DT Override]')
					end
				elseif Mode == 'Mode3' then
					equip(set_combine(sets.hassomodethree, sets.idle, sets.dtoverride))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 3 ('..Mode3Name..') + Idle + DT Override]')
					end
				end
			end
		else
			if Stance == 'Seigan' then
				equip(set_combine(sets.seigan, sets.idle))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Seigan + Idle]')
				end
			else
				if Mode == 'Mode1' then
					equip(set_combine(sets.hassomodeone, sets.idle))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 1 ('..Mode1Name..') + Idle]')
					end
				elseif Mode == 'Mode2' then
					equip(set_combine(sets.hassomodetwo, sets.idle))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 2 ('..Mode2Name..') + Idle]')
					end
				elseif Mode == 'Mode3' then
					equip(set_combine(sets.hassomodethree, sets.idle))
					if Debug == 'On' then
						windower.add_to_chat(8,'[Equipped Set: Hasso Mode 3 ('..Mode3Name..') + Idle]')
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
				send_command('text notifications text "«« Not Enough TP »»";text notifications color 255 50 50;text notifications bg_transparency 1')
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
				send_command('text notifications text "«« Too Far »»";text notifications color 255 50 50;text notifications bg_transparency 1')
			else
				windower.add_to_chat(8,'<< Too Far >>')
			end
		elseif (spell.target.distance >= (spell.target.model_size + 3)) and not (spell.english == 'Starlight' or spell.english == 'Moonlight') then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
			end
			cancel_spell()
			if HUD == 'On' then
				send_command('text notifications text "«« Too Far »»";text notifications color 255 50 50;text notifications bg_transparency 1')
			else
				windower.add_to_chat(8,'<< Too Far >>')
			end
		end
		if buffactive['Sekkanoki'] then
			equip(set_combine(sets.cappedtpws, sets.sekkanoki))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Capped TP Weapon Skill + Sekkanoki]')
			end
		elseif buffactive['Meikyo Shisui'] then
			if HybridWS:contains(spell.english) then
				equip(set_combine(sets.hybridws, sets.meikyoshisui))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Hybrid Weapon Skill + Meikyo Shisui]')
				end
			else
				equip(set_combine(sets.ws, sets.meikyoshisui))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Weapon Skill + Meikyo Shisui]')
				end
			end
		elseif HybridWS:contains(spell.english) then
			equip(sets.hybridws)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Hybrid Weapon Skill]')
			end			
		elseif player.tp == 3000 then
			equip(sets.cappedtpws)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Capped TP Weapon Skill]')
			end
		else
			equip(sets.ws)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Weapon Skill]')
			end
		end
	elseif spell.english == 'Hasso' then
		Stance = 'Hasso' --Set Stance to Hasso when we use it
		if Debug == 'On' then
			windower.add_to_chat(8,'[Stance set to Hasso]')
		end
		choose_set() --run the choose_set function to choose based on our status.
	elseif spell.english == 'Seigan' then
		Stance = 'Seigan' --Set Stance to Seigan when we use it
		if Debug == 'On' then
			windower.add_to_chat(8,'[Stance set to Seigan]')
		end
		choose_set() --run the choose_set function to choose based on our status.
	elseif spell.english == 'Meditate' and windower.ffxi.get_ability_recasts()[134] <= 1 then
		equip(sets.meditate)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Meditate]')
		end
	elseif string.find(spell.english,'Jump') and windower.ffxi.get_ability_recasts()[158] <= 1 then
		equip(sets.jump)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Jump]')
		end
	elseif spell.english == 'Warding Circle' and windower.ffxi.get_ability_recasts()[135] <= 1 then
		equip(sets.wardingcircle)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Warding Circle]')
		end
	elseif spell.english == 'Shikikoyo' and windower.ffxi.get_ability_recasts()[136] <= 1 then
		equip(sets.shikikoyo)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Shikikoyo]')
		end
	elseif spell.english == 'Blade Bash' and windower.ffxi.get_ability_recasts()[137] <= 1 then
		equip(sets.bladebash)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Blade Bash]')
		end
	elseif spell.english == 'Sengikori' and windower.ffxi.get_ability_recasts()[141] <= 1 then
		equip(sets.sengikori)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Sengikori]')
		end
	elseif (spell.english == 'Spectral Jig' or spell.english == 'Sneak' or spell.english == 'Monomi: Ichi' or spell.english == 'Monomi: Ni') and buffactive['Sneak'] and spell.target.type == 'SELF' then
		send_command('cancel 71')
	elseif spell.english == 'Holy Water' then
		equip(sets.hwater)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Holy Water]')
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
			windower.add_to_chat(8,'[Equipped Set: Unity]')
		end
	end
end

-------------------------------------------
--              AFTERCAST                --
-------------------------------------------

function aftercast(spell)
	if spell.type == 'WeaponSkill' and not spell.interrupted and HUD == 'On' and NotiWSDamage == 'On' then
		LastWS = spell.name --Records the WS name used for the WS Damage Notification
	elseif spell.english == 'Meikyo Shisui' and MeikTimer == 'On' and not spell.interrupted then
		send_command('input /echo [Meikyo Shisui] 30 seconds;wait 10;input /echo [Meikyo Shisui] 20 seconds;wait 10;input /echo [Meikyo Shisui] 10 seconds')
	elseif spell.english == 'Yaegasumi' and IntTimer == 'On' and not spell.interrupted then
		send_command('input /echo [Yaegasumi] 40 seconds;wait 10;input /echo [Yaegasumi] 30 seconds;wait 10;input /echo [Yaegasumi] 20 seconds;wait 10;input /echo [Yaegasumi] 10 seconds')
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
    if status == 4 and HUD == 'On' and ShowHUD == true then --In a cutscene: Hide the HUD
		ShowHUD = false
		if Debug == 'On' then
			windower.add_to_chat(8,'[ShowHUD set to False]')
		end
		send_command('text bg1 hide;text bg2 hide;text bg3 hide;text meditate hide;text sekkanoki hide;text sengikori hide;text hagakure hide;text aggressor hide;text berserk hide;text highjump hide;text superjump hide;text hasso hide;text seigan hide;text stance hide;text notifications hide;text debuffs hide;text aftermath hide')
    elseif status ~= 4  and HUD == 'On' and ShowHUD == false then --Out of cutscene: Show the HUD
		ShowHUD = true
		if Debug == 'On' then
			windower.add_to_chat(8,'[ShowHUD set to True]')
		end
		send_command('text bg1 show;text bg2 show;text bg3 show;text meditate show;text sekkanoki show;text sengikori show;text hagakure show;text aggressor show;text berserk show;text highjump show;text superjump show;text hasso show;text seigan show;text stance show;text notifications show;text debuffs show;text aftermath show')
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
		if player.equipment.main == 'Masamune' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 1 (30% Triple Dmg)";text aftermath color '..Aftermath1color..'')
			else
				windower.add_to_chat(220,'<< Aftermath: Level 1 (30% Triple Damage) >>')
			end
		elseif player.equipment.main == 'Dojikiri Yasutsuna' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 1 (4-Step Ultimate)";text aftermath color '..Aftermath1color..'')
			else
				windower.add_to_chat(220,'<< Aftermath: Level 1 (4-Step Ultimate) >>')
			end
		elseif player.equipment.main == 'Kogarasumaru' then
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
		if player.equipment.main == 'Masamune' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 2 (40% Triple Dmg)";text aftermath color '..Aftermath2color..'')
			else
				windower.add_to_chat(204,'<< Aftermath: Level 2 (40% Triple Damage) >>')
			end
		elseif player.equipment.main == 'Dojikiri Yasutsuna' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 2 (3-Step Ultimate)";text aftermath color '..Aftermath2color..'')
			else
				windower.add_to_chat(204,'<< Aftermath: Level 2 (3-Step Ultimate) >>')
			end
		elseif player.equipment.main == 'Kogarasumaru' then
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
		if player.equipment.main == 'Masamune' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 3 (50% Triple Dmg)";text aftermath color '..Aftermath3color..'')
			else
				windower.add_to_chat(50,'<< Aftermath: Level 3 (50% Triple Damage) >>')
			end
		elseif player.equipment.main == 'Dojikiri Yasutsuna' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Level 3 (2-Step Ultimate)";text aftermath color '..Aftermath3color..'')
			else
				windower.add_to_chat(50,'<< Aftermath: Level 3 (2-Step Ultimate) >>')
			end
		elseif player.equipment.main == 'Kogarasumaru' then
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
		if player.equipment.main == 'Amanomurakumo' then
			if HUD == 'On' then
				send_command('wait 1;text aftermath text "Aftermath: Active (Zanshin/STP)";text aftermath color '..Aftermath3color..'')
			else
				windower.add_to_chat(220,'<< Aftermath: Active (Zanshin/STP) >>')
			end
		end
	end
	if (buff == 2 or buff == 19) and not buffactive['Charm'] then --If we get slept,
		if buffactive['Stoneskin'] then --first remove stoneskin if its up,
			send_command('cancel 37')
		end
		if not (buffactive['Poison'] or buffactive['Dia'] or buffactive['bio'] or buffactive['Shock'] or buffactive['Rasp'] or buffactive['Choke'] or buffactive['Frost'] or buffactive['Burn'] or buffactive['Drown'] or buffactive['Requiem'] or buffactive['Kaustra'] or buffactive['Helix']) and player.hp > 50 and player.status == "Engaged" then --then as long as we're not already DOT'd, have more than 50 HP, and are engaged,
			equip({neck="Vim Torque"}) --equip the Vim Torque to wake us up
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Item: Vim Tourque]')
			end
		end
	end
	if buff == 7 or Buff == 10 or buff == 28 then --If we get petrified, stunned, or terrored, then equip the DT Override set
		equip(sets.dtoverride)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: DT Override]')
		end
	end
	if buff == 15 then --Doom
		if AlertSounds == 'On' and DangerSound == 'O' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
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
	end
	if buff == 17 then --Charm
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
		end
	end
	if buff == 71 or buff == 69 then --Sneak or Invisible
		send_command('gs c ClearNotifications')
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
	elseif buff == 251 and Alive == true and NotiFood == 'On' then --food wears off
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« Food Has Worn Off »»";text notifications color 255 50 50;text notifications bg_transparency 1')
		else
			windower.add_to_chat(8,'<< Food Has Worn Off >>')
		end
	elseif buff == 113 and NotiReraise == 'On' and Alive == true then --reraise wears off
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« Reraise Has Worn Off »»";text notifications color 255 50 50;text notifications bg_transparency 1')
		else
			windower.add_to_chat(8,'<< Reraise Has Worn Off >>')
		end
	elseif buff == 602 and string.find(world.area,'Escha') then --Vorseal
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« Vorseal Has Worn Off »»";text notifications color 255 50 50;text notifications bg_transparency 1')
		end
	elseif buff == 253 then --Signet
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« Signet Has Worn Off »»";text notifications color 255 50 50;text notifications bg_transparency 1')
		end
	elseif buff == 256 then --Sanction
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« Sanction Has Worn Off »»";text notifications color 255 50 50;text notifications bg_transparency 1')
		end
	elseif buff == 268 then --Sigil
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« Sigil Has Worn Off »»";text notifications color 255 50 50;text notifications bg_transparency 1')
		end
	elseif buff == 512 then --Ionis
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« Ionis Has Worn Off »»";text notifications color 255 50 50;text notifications bg_transparency 1')
		end
	elseif buff == 1 and Alive == true then --Weakness
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav')
		end
		if HUD == 'On' then
			send_command('text notifications text "«« Weakness Has Worn Off »»";text notifications color 75 255 75;text notifications bg_transparency 1')
		end
	elseif buff == 2 or buff == 19 or buff == 7 or buff == 17 then --lose sleep, petrify, or charm run choose_set since we changed gear for those
		choose_set()
	elseif buff == 15 and DoomAlert == 'On' and Doom == true then --Doom
		Doom = false --"Doom" gets set to false when we die, that way we don't announce that doom is off when we raise from the dead
		if Debug == 'On' then
			windower.add_to_chat(8,'[Doom set to False]')
		end
		send_command('input /p '..DoomOffText..'')
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
		if HUD == 'On' then
			send_command('text notifications text "«« 3000 TP »»";text notifications color 75 255 75;text notifications bg_transparency 1')
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
	--Debuff checks
	if HUD == 'On' and LoadHUD == true and not TownZones:contains(world.area) then
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
			send_command('text notifications text "Status: Dead X_x";text notifications color 255 50 50;text notifications bg_transparency 1')
			Alive = false
			if Debug == 'On' then
				windower.add_to_chat(8,'[Alive set to False]')
			end
			Doom = false --turn this off so it doesn't trigger the "doom is off" notification once we raise
			if Debug == 'On' then
				windower.add_to_chat(8,'Doom set to False]')
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
			send_command('wait 1;gs c AliveDelay') --we use a command to set this to true so that we can set a short delay to prevent things from triggering right when we raise
		end
		if player.hp <= LowHPThreshold then --when HP goes below a certain amount, turn on the LowHP flag and equip the appropriate gear set
			if LowHP == false and UseOhShit == 'On' then
				choose_set()
				LowHP = true
				if Debug == 'On' then
					windower.add_to_chat(8,'[LowHP set to True]')
				end
			end
			if NotiLowHP == 'On' and AlertSounds == 'On' and DangerSound == 'O' and NotiLowHPToggle == 'Off' then
				NotiLowHPToggle = 'On' --turn the toggle on so this can't be triggered again until its toggled off
				if Debug == 'On' then
					windower.add_to_chat(8,'[NotiLowHPToggle set to On]')
				end
				windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
				send_command('wait 30;gs c NotiLowHPToggle') --wait 30 sec then turns the toggle back off
			end
		elseif player.hp > LowHPThreshold and LowHP == true and UseOhShit == 'On' then --when HP goes back above a certain amount, turn off the LowHP flag and equip the appropriate gear set
			send_command('gs c ClearNotifications')
			choose_set()
			LowHP = false
			if Debug == 'On' then
				windower.add_to_chat(8,'[LowHP set to False]')
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
		if HUD == 'On' and LoadHUD == true then
			if buffactive['Hasso'] then --Hasso is up, so we're in Hasso Stance
				Stance = 'Hasso'
				if Debug == 'On' then
					--windower.add_to_chat(8,'[Stance set to Hasso]')
				end
				if Mode == 'Mode1' then
					send_command('text stance text "Stance: Hasso ('..Mode1Name..')";text stance color '..HassoStanceColor..'')
				elseif Mode == 'Mode2' then
					send_command('text stance text "Stance: Hasso ('..Mode2Name..')";text stance color '..HassoStanceColor..'')
				elseif Mode == 'Mode3' then
					send_command('text stance text "Stance: Hasso ('..Mode3Name..')";text stance color '..HassoStanceColor..'')
				end
			elseif buffactive['Seigan'] then --Seigan is up, so we're in Seigan Stance
				Stance = 'Seigan'
				if Debug == 'On' then
					--windower.add_to_chat(8,'[Stance set to Seigan]')
				end
				send_command('text stance text "Stance: Seigan";text stance color '..SeiganStanceColor..'')
			else --Neither Hasso or Seigan is up, no stance is set
				Stance = 'None'
				if Debug == 'On' then
					--windower.add_to_chat(8,'[Stance set to None]')
				end
				send_command('text stance text "Stance: None";text stance color 255 50 50')
			end
			if ReraiseReminder == 'On' then
				if RRRCountdown > 0 then
					RRRCountdown = RRRCountdown - 1
				else
					if not buffactive['Reraise'] and Alive == true then --if we are dead no need to remind us about reraise
						if AlertSounds == 'On' then
							windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
						end
						if HUD == 'On' then
							send_command('text notifications text "«« No Reraise »»";text notifications color 255 50 50;text notifications bg_transparency 1')
						else
							windower.add_to_chat(8,'<< No Reraise >>')
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
			if NotiLowHP == 'On' and LowHP == true and Alive == true and not buffactive['weakness'] then
				send_command('text notifications text "Status: LOW HP";text notifications bg_transparency 200;text notifications color 0 0 0;text notifications bg_color 255 255 255;wait .5;text notifications bg_color 255 204 51')
			end
			if (NotiDoom == 'On' and buffactive['Doom']) or (NotiLowHP == 'On' and LowHP == true and Alive == true and not buffactive['weakness']) and AlertSounds == 'On' and DangerSound == 'C' then
				windower.play_sound(windower.addon_path..'data/sounds/Danger.wav')
			end
			--Moving text object to their appropriate places
			if Stance == 'Hasso' or Stance == 'Seigan' then --are we in Hasso or Seigan Stance?
				send_command('text hasso pos '..HUDposXColumn1..' -100')						--Hasso is not visible
				send_command('text seigan pos '..HUDposXColumn2..' -100')						--Seigan is not visible
				send_command('text meditate pos '..HUDposXColumn1..' '..HUDposYLine1..'')		--Meditate goes in Column 1
				send_command('text sekkanoki pos '..HUDposXColumn2..' '..HUDposYLine1..'')		--Sekkanoki goes in Column 2
				send_command('text sengikori pos '..HUDposXColumn3..' '..HUDposYLine1..'')		--Sengikori goes in Column 3
				send_command('text hagakure pos '..HUDposXColumn4..' '..HUDposYLine1..'')		--Hagakure goes in Column 4
				if player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
					send_command('text berserk pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Berserk goes in Column 5
					send_command('text aggressor pos '..HUDposXColumn6..' '..HUDposYLine1..'')	--Aggressor goes in Column 6
					send_command('text highjump pos '..HUDposXColumn5..' -100')					--High Jump is not visible
					send_command('text superjump pos '..HUDposXColumn6..' -100')				--Super Jump is not visible
				elseif player.sub_job == 'DRG' and player.sub_job_level ~= 0 then
					send_command('text berserk pos '..HUDposXColumn5..' -100')					--Berserk is not visible
					send_command('text aggressor pos '..HUDposXColumn6..' -100')				--Aggressor is not visible
					send_command('text highjump pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--High Jump goes in Column 5
					send_command('text superjump pos '..HUDposXColumn6..' '..HUDposYLine1..'')	--Super Jump goes in Column 6
				else
					send_command('text berserk pos '..HUDposXColumn5..' -100')					--Berserk is not visible
					send_command('text aggressor pos '..HUDposXColumn6..' -100')				--Aggressor is not visible
					send_command('text highjump pos '..HUDposXColumn5..' -100')					--High Jump is not visible
					send_command('text superjump pos '..HUDposXColumn6..' -100')				--Super Jump is not visible
				end
			else --if not Hasso or Seigan, then we have no Stance set currently
				send_command('text hasso pos '..HUDposXColumn1..' '..HUDposYLine1..'')			--Hasso goes in Column 1
				send_command('text seigan pos '..HUDposXColumn2..' '..HUDposYLine1..'')			--Seigan goes in Column 2
				send_command('text meditate pos '..HUDposXColumn1..' -100')						--Meditate goes in Column 1
				send_command('text sekkanoki pos '..HUDposXColumn2..' -100')					--Sekkanoki goes in Column 2
				send_command('text sengikori pos '..HUDposXColumn3..' -100')					--Sengikori goes in Column 3
				send_command('text hagakure pos '..HUDposXColumn4..' -100')						--Hagakure goes in Column 4
				send_command('text berserk pos '..HUDposXColumn5..' -100')						--Berserk is not visible
				send_command('text aggressor pos '..HUDposXColumn6..' -100')					--Aggressor is not visible
				send_command('text highjump pos '..HUDposXColumn5..' -100')						--High Jump is not visible
				send_command('text superjump pos '..HUDposXColumn6..' -100')					--Super Jump is not visible
			end
			send_command('text stance pos '..HUDposXColumn1..' '..HUDposYLine2..'')				--Stance goes in Line 2, Column 1
			send_command('text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')		--Notifications goes in Line 3, Column 1
			send_command('text debuffs pos '..HUDposXColumn4..' '..HUDposYLine3..'')			--Debuffs goes in Line 3, Column 4
			--REMAs equipped:
			if (player.equipment.main == 'Amanomurakumo' or player.equipment.main == 'Kogarasumaru' or player.equipment.main == 'Masamune' or player.equipment.main == 'Dojikiri Yasutsuna') and REMA == false then
				send_command('text aftermath pos '..HUDposXColumn4..' '..HUDposYLine2..'')		--Aftermath goes in Line 2, Column 4
				REMA = true
				if Debug == 'On' then
					windower.add_to_chat(8,'[REMA set to True]')
				end
			elseif not (player.equipment.main == 'Amanomurakumo' or player.equipment.main == 'Kogarasumaru' or player.equipment.main == 'Masamune' or player.equipment.main == 'Dojikiri Yasutsuna') and REMA == true then 
				send_command('text aftermath pos '..HUDposXColumn4..' -100')					--Aftermath is not visible
				REMA = false
				if Debug == 'On' then
					windower.add_to_chat(8,'[REMA set to False]')
				end
			end
			--Recast updates:
			MeditateRecast = windower.ffxi.get_ability_recasts()[134]
			SekkanokiRecast = windower.ffxi.get_ability_recasts()[140]
			SengikoriRecast = windower.ffxi.get_ability_recasts()[141]
			HagakureRecast = windower.ffxi.get_ability_recasts()[54]
			HassoRecast = windower.ffxi.get_spell_recasts()[138]
			SeiganRecast = windower.ffxi.get_spell_recasts()[139]
			if player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
				AggressorRecast = windower.ffxi.get_ability_recasts()[4]
				BerserkRecast = windower.ffxi.get_ability_recasts()[1]
			elseif player.sub_job == 'DRG' and player.sub_job_level ~= 0 then
				HighJumpRecast = windower.ffxi.get_ability_recasts()[159]
				SuperJumpRecast = windower.ffxi.get_ability_recasts()[160]
			end
			--Recast color updates - decide the colors:
			if MeditateRecast == 0 then MeditateColor = '255 50 50'
			else MeditateColor = '255 165 0'
			end
			if buffactive['Sekkanoki'] then SekkanokiColor = '75 255 75'
			elseif SekkanokiRecast > 0 then SekkanokiColor = '255 165 0'
			else SekkanokiColor = '255 50 50'
			end
			if buffactive['Sengikori'] then SengikoriColor = '75 255 75'
			elseif SengikoriRecast > 0 then SengikoriColor = '255 165 0'
			else SengikoriColor = '255 50 50'
			end
			if buffactive['Hagakure'] then HagakureColor = '75 255 75'
			elseif HagakureRecast > 0 then HagakureColor = '255 165 0'
			else HagakureColor = '255 50 50'
			end
			if buffactive['Hasso'] then HassoColor = '75 255 75'
			elseif HassoRecast > 0 then HassoColor = '255 165 0'
			else HassoColor = '255 50 50'
			end
			if buffactive['Seigan'] then SeiganColor = '75 255 75'
			elseif SeiganRecast > 0 then SeiganColor = '255 165 0'
			else SeiganColor = '255 50 50'
			end
			if player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
				if buffactive['Aggressor'] then AggressorColor = '75 255 75'
				elseif AggressorRecast > 0 then AggressorColor = '255 165 0'
				else AggressorColor = '255 50 50'
				end
				if buffactive['Berserk'] then BerserkColor = '75 255 75'
				elseif BerserkRecast > 0 then BerserkColor = '255 165 0'
				else BerserkColor = '255 50 50'
				end
			elseif player.sub_job == 'DRG' and player.sub_job_level ~= 0 then
				if HighJumpRecast == 0 then HighJumpColor = '255 50 50'
				else HighJumpColor = '255 165 0'
				end
				if SuperJumpRecast == 0 then SuperJumpColor = '255 50 50'
				else SuperJumpColor = '255 165 0'
				end
			end
			--Recast color updates - print the colors:
			send_command('text meditate color '..MeditateColor..'')
			send_command('text sekkanoki color '..SekkanokiColor..'')
			send_command('text Sengikori color '..SengikoriColor..'')
			send_command('text hagakure color '..HagakureColor..'')
			send_command('text hasso color '..HassoColor..'')
			send_command('text seigan color '..SeiganColor..'')
			if player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
				send_command('text aggressor color '..AggressorColor..'')
				send_command('text berserk color '..BerserkColor..'')
			elseif player.sub_job == 'DRG' and player.sub_job_level ~= 0 then			
				send_command('text highjump color '..HighJumpColor..'')
				send_command('text superjump color '..SuperJumpColor..'')
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
		if NotiTrade == 'On' and HUD == 'On' then
			send_command('text notifications text "«« Trade Request »»";text notifications color 255 255 50;text notifications bg_transparency 1')
		end
	elseif org:find('The effect of') and org:find('is about to wear off.')then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if NotiSneak == 'On' and HUD == 'On' and org:find('Sneak') then
			send_command('text notifications text "«« Sneak Wearing »»";text notifications color 255 100 100;text notifications bg_transparency 1')
		elseif NotiInvis == 'On' and HUD == 'On' and org:find('Invisible') then
			send_command('text notifications text "«« Invisible Wearing »»";text notifications color 255 100 100;text notifications bg_transparency 1')
		end
	elseif org:find('Lost key item') and org:find('Radialens') then
		send_command('gs c Radialens')
	elseif org:find('invites you to') then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav')
		end
		if NotiInvite == 'On' and HUD == 'On' and org:find('party') and not org:find('alliance') then
			send_command('text notifications text "«« Party Invite »»";text notifications color 255 255 50;text notifications bg_transparency 1')
		elseif NotiInvite == 'On' and HUD == 'On' and org:find('alliance') then
			send_command('text notifications text "«« Alliance Invite »»";text notifications color 255 255 50;text notifications bg_transparency 1')
		end
	elseif org:find('Your visitant status will wear off in') then
		if org:find(' 15 ') then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
			end
			if NotiTime == 'On' and HUD == 'On' then
				send_command('text notifications text "«« 15 Minutes Remaining »»";text notifications color 255 255 50;text notifications bg_transparency 1')
			end
		elseif org:find(' 10 ') then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
			end
			if NotiTime == 'On' and HUD == ' On ' then
				send_command('text notifications text "«« 10 Minutes Remaining »»";text notifications color 255 255 50;text notifications bg_transparency 1')
			end
		elseif org:find(' 5 ') then
			if AlertSounds == 'On' then
				windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
			end
			if NotiTime == 'On' and HUD == 'On' then
				send_command('text notifications text "«« 5 Minutes Remaining »»";text notifications color 255 255 50;text notifications bg_transparency 1')
			end
		end
	elseif org:find('>> /item "Holy Water" <me>') then
		HWater = false
		if Debug == 'On' then
			windower.add_to_chat(8,'[HWater set to False]')
		end
		send_command('text notifications text "«« Out Of Holy Waters »»";text notifications color 255 50 50;text notifications bg_transparency 1')
	elseif org:find('Trade complete') then
		send_command('gs c ClearNotifications')
	elseif NotiOmen == 'On' and org:find('You find a') then
		if org:find('Fu\'s scale') then
			send_command('wait 2 5;input /p Fu\'s Scale: BST, DRG, SMN, PUP <call14>')
		elseif org:find('Gin\'s scale') then
			send_command('wait 2 5;input /p Gin\'s Scale: THF, NIN, DNC, RUN <call14>')
		elseif org:find('Kei\'s scale') then
			send_command('wait 2 5;input /p Kei\'s Scale: WHM, BLM, RDM, BLU, SCH <call14>')
		elseif org:find('Kin\'s scale') then
			send_command('wait 2 5;input /p Kin\'s Scale: WAR, MNK, PLD, DRK, SAM <call14>')
		elseif org:find('Kyou\'s scale') then
			send_command('wait 2 5;input /p Kyou\'s Scale: BRD, RNG, COR, GEO <call14>')
		end
	elseif NotiVagary == 'On' and org:find('You pitiful lot will never learn') then
		send_command('input /p Perfidien pop! <call14>')
	elseif NotiVagary == 'On' and org:find('the void calls') then
		send_command('input /p Plouton pop! <call14>')
	elseif NotiVagary == 'On' and (org:find('Hoho! Poked at a sore spot, didn\'t you?') or org:find('Switching things up, hmm?')) then
		if org:find('Lightning') then
			send_command('input /p Thunder <call14>')
		elseif org:find('Fire') then
			send_command('input /p Fire <call14>')
		elseif org:find('Wind') then
			send_command('input /p Aero <call14>')
		elseif org:find('Earth') then
			send_command('input /p Stone <call14>')
		elseif org:find('Ice') then
			send_command('input /p Blizzard <call14>')
		elseif org:find('Water') then
			send_command('input /p Water <call14>')
		end
	end
end)

-------------------------------------------
--         WS DAMAGE NOTIFICATION        --
-------------------------------------------

windower.register_event('action',function(act)
	if act.category == 3 and act.actor_id == player.id and not (act.param == 66 or act.param == 67 or act.param == 68) then --WS performed by me and not a Jump (Jumps classified as WSs for some reason)
		--WSDamage = act.targets[1].actions[1].param
		--send_command('input /echo WS Damage '..WSDamage..'')
		if act.targets[1].actions[1].param == 0 then
			send_command('wait .2;text notifications text "«« Weapon Skill Missed »»";text notifications color 255 0 0;text notifications bg_transparency 1')
		else
			send_command('wait .2;text notifications text "'..LastWS..': '..act.targets[1].actions[1].param..'";text notifications color 0 255 255;text notifications bg_transparency 1')
		end
	end
end)

-------------------------------------------
--             FILE UNLOAD               --
-------------------------------------------

function file_unload()
	if HUD == 'On' then
		send_command('wait .2;text bg1 delete;text bg2 delete;text bg3 delete;text meditate delete;text sekkanoki delete;text sengikori delete;text hagakure delete;text aggressor delete;text berserk delete;text highjump delete;text superjump delete;text hasso delete;text seigan delete;text loading delete;text stance delete;text notifications delete;text debuffs delete;text aftermath delete') --delete the different text objects
	end
end

--[[

-------------------------------------------
--            KEYS NOTEPAD               --
-------------------------------------------

Default text size is 12
Large 15 (+24)
Medium 12 (+20)
Small 9 (+15)

 --]]
