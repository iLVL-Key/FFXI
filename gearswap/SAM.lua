-------------------------------------------
--  Keys Gearswap lua file for Samurai   --
-------------------------------------------

-------------------------------------------
--                 NOTES                 --
-------------------------------------------
--[[

Place both this file and the sounds folder inside the GearSwap data folder
	/addons/GearSwap/data/sounds/
	/addons/GearSwap/data/SAM.lua

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
LockstyleField	=	'3'		--[1-20]		Your Lockstyle set when in a field zone.
LockstyleTown	=	'1'		--[1-20]		Your Lockstyle set when in a town zone.
							--				If you do not want a separate town lockstyle, set this to the same as LockstyleField.
Book			=	'2'		--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
Page			=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
MeikTimer		=	'On'	--[On/Off]		Displays a timer for Meikyo Shisui in echo.
YaegTimer		=	'On'	--[On/Off]		Displays a timer for Yaegasumi in echo.
DTCtrlPlus		=	'd'		--				Sets the keyboard shortcut you would like to activate the Damage Taken Override.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions
							--				(Town limits this to town gear only)
AlertSounds		=	'On'	--[On/Off]		Plays a sound on alerts.

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
NotiTPReturn		=	'On'	--[On/Off]	Displays your TP return after Weapon Skills.
ReraiseReminder		=	'Off'	--[On/Off]	Displays an occasional reminder if Reraise is not up.
ReraiseReminderTimer=	1800	--			Delay in seconds between checks to see if Reraise is up (300 is 5 minutes)
NotiTime			=	'Off'	--[On/Off]	Displays a notification for time remaining notices.
NotiOmen			=	'On'	--[On/Off]	Party chat notifications for Scale drops in Omen.
NotiVagary			=	'On'	--[On/Off]	Party chat notifications for Perfidien and Plouton popping, as well as weaknesses.

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

HUDBGTrans = 		'175'	--Background transparency for the HUD. (0 = fully clear, 255 = fully opaque)
TPReturnWait =		'0.2'	--Adjust this timing in seconds as needed. (TP Return may not always be 100% accurate depending on lag, regain, etc.)
Debug =				'Off'	--[On/Off]

--Color values in RGB for the HUD modes
HassoModeColor	=	'125 125 255'	--Hasso
SeiganModeColor	=	'255 125 125'	--Seigan

--Color values in RGB for the HUD Aftermath status
Aftermath1color	=	'0 127 255'		--Aftermath Level 1
Aftermath2color	=	'75 255 75'		--Aftermath Level 2
Aftermath3color	=	'255 255 50'	--Aftermath Level 3

-------------------------------------------
--               GEAR SETS               --
-------------------------------------------

function get_sets()

	-- Hasso ()
	sets.hasso = {
		ammo="Aurgelmir Orb",
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Wakido Kote +3",
		legs="Ken. Hakama +1",
		feet="Mpaca's Boots",
		neck="Sam. Nodowa +2",
		waist="Windbuffet Belt +1",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Hetairoi Ring",
		right_ring="Ilabrat Ring",
		--right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},

		--right_ring="Niqmaddu Ring",
	}

	-- Seigan ()
	sets.seigan = {
		ammo="Aurgelmir Orb",
		head="Nyame Helm",
		body="Mpaca's Doublet",
		hands="Nyame Gauntlets",
		legs="Sakonji Haidate +3",
		feet="Mpaca's Boots",
		neck="Sam. Nodowa +2",
		waist="Windbuffet Belt +1",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Hetairoi Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}},

		--right_ring="Niqmaddu Ring",
	}

	-- Idle ()
	sets.idle = {
		ammo="Knobkierrie",
		head="Wakido Kabuto +3",
		feet="Danzo Sune-ate",
		neck="Rep. Plat. Medal",
		left_ring="Karieyh Ring +1",
	}

	-- DT Override (Damage Taken-, Magic Evasion)
	-- Will override all other gear sets and inherit unused slots from them
	sets.dtoverride = {
		head="Nyame Helm",
		body="Nyame Mail",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	}

	-- Weapon Skill (STR, Weapon Skill Damage, Attack, Double/Triple Attack)
	sets.ws = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Sakonji Domaru +3",
		hands="Valorous Mitts",
		legs="Wakido Haidate +3",
		feet="Valorous Greaves",
		neck="Sam. Nodowa +2",
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}

	-- Sekkanoki
	sets.sekkanoki = {
		hands="Kasuga Kote +1",
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
		feet="Kasuga Sune-Ate +1",
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
		--body="Yoran Unity Shirt",
	}

end
TopVersion = 'Tachi: Enpi' --Leave this alone, used for debugging purposes



	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX          DO NOT EDIT BELOW THIS LINE          XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--



BottomVersion = 'Tachi: Enpi'
FileVersion = '07.18.22'

-------------------------------------------
--               UPDATES                 --
-------------------------------------------

--[[
If the new updates Version Compatibility Codename matches your current files TopVersion,
simply replace everything under the "Do Not Edit Below This Line".
Only when the Version Compatibility Codename changes will you need to update the entire file.

07.18.22 (Version Compatibility Codename: Tachi: Enpi)
-Overhauled how area checks are handled. Uses tables now for groups of areas.
-Fixed some errors that would show up on job change. These were caused by the Heartbeat function constantly checking for any debuffs present; when you unload the file (change job) it will delete the debuff text objects used for the HUD which will cause a split second where the debuff check freaks out. The fix was to simply disable the debuff checks in town zones.
-Fixed the DTOverride set not equipping correctly when idle.
-Fixed an issue with the Sleep debuff not showing properly in the HUD.
-Code cleanup

06.14.22 (Version Compatibility Codename: Tachi: Enpi)
-Adjusted HUD timings on load. Should fix the occasional errors about text objects not existing as well as objects loading underneath the background layer.
-Fixed Relic Aftermath not displaying in the HUD.
-Removed Gearswaps built-in debugmode from the files Debug mode.
-Moved the Updates section towards the top of the file.
-Code cleanup

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
	'Western Adoulin','Eastern Adoulin','Celennia Memorial Library','Bastok Markets','Bastok Mines','Metalworks','Port Bastok','Chateau d\'Oraguille','Northern San d\'Oria','Port San d\'Oria','Southern San d\'Oria','Heavens Tower','Port Windurst','Windurst Walls','Windurst Waters','Windurst Woods','Lower Jeuno','Port Jeuno','Ru\'Lude Gardens','Upper Jeuno','Aht Urhgan Whitegate','The Colosseum','Tavnazian Safehold','Southern San d\'Oria [S]','Bastok Markets [S]','Windurst Waters [S]','Mhaura','Selbina','Rabao','Kazham','Norg','Nashmau','Mog Garden'
    }

-------------------------------------------
--              FILE LOAD                --
-------------------------------------------

Mode = 'None' --Start off without Hasso/Seigan up, this will update when either is activated
DTOverride = "Off" --Start with the Damage Taken Override off
RRRCountdown = ReraiseReminderTimer
Heartbeat = 0 --set to 0 just to start the Heartbeat running
LoadDelay = 3 --delays loading the HUD, this makes sure all the variables get set correctly before being used, displays file version info, and waits to use lockstyle
LoadHUD = false --starts false then switched to true after the LoadDelay
ShowHUD = true --this changes to false when we zone or are in a cutscene
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
	if player.equipment.main == 'Amanomurakumo' or player.equipment.main == 'Kogarasumaru' or player.equipment.main == 'Masamune' or player.equipment.main == 'Dojikiri Yasutsuna' then
		REMA = true --If we have a REMA equipped we set this toggle to true
	else
		REMA = false --If we do not have a REMA equipped, we set it to false
	end
	--Create all the HUD Background text objects and put them above the screen for now, we'll move them to the correct place next
	send_command('text bg1 create "                                                                                                                          ";wait .3;text bg1 size '..FontSize..';text bg1 pos '..HUDposXColumn1..' '..HUDposYLine1..';text bg1 bg_transparency '..HUDBGTrans..'')--Background Line 1
	send_command('text bg2 create "                                                                                                                          ";wait .3;text bg2 size '..FontSize..';text bg2 pos '..HUDposXColumn1..' -100;text bg2 bg_transparency '..HUDBGTrans..'')--Background Line 2
	send_command('text bg3 create "                                                                                                                          ";wait .3;text bg3 size '..FontSize..';text bg3 pos '..HUDposXColumn1..' -100;text bg3 bg_transparency '..HUDBGTrans..'')--Background Line 3
	send_command('text loading create "Loading Keys SAMURAI file ver: '..FileVersion..'...";wait .3;text loading size '..FontSize..';text loading pos '..HUDposXColumn1..' '..HUDposYLine1..';text loading bg_transparency 1') --Loading
	send_command('wait '..LoadDelay..';gs c LoadHUD')
	--Create the Aftermath, Mode, Notifications, and Debuffs text objects and put them above the screen for now, we'll move them to the correct place next
	send_command('wait .1;text aftermath create "Aftermath: None";wait .3;text aftermath size '..FontSize..';text aftermath pos '..HUDposXColumn4..' -100;text aftermath color 255 50 50;text aftermath bg_transparency 1') --Aftermath
	send_command('wait .1;text mode create "Mode: '..Mode..'";wait .3;text mode size '..FontSize..';text mode pos '..HUDposXColumn1..' -100;text mode color 255 50 50;text mode bg_transparency 1') --Mode
	send_command('wait .1;text notifications create "Hello, '..player.name..'! (type //fileinfo for more information)";wait .3;text notifications size '..FontSize..';text notifications pos '..HUDposXColumn1..' -100;text notifications bg_transparency 1') --Notifications
	send_command('wait .1;text debuffs create " ";wait .3;text debuffs size '..FontSize..';text debuffs pos '..HUDposXColumn4..' -100;text debuffs bg_transparency 1') --Debuffs
	--Create all the HUD Recast text objects and put them above the screen for now, we'll move them to the correct place next
	send_command('wait .2;text meditate create "[ Meditate ]";wait .3;text meditate size '..FontSize..';text meditate pos '..HUDposXColumn1..' -100;text meditate bg_transparency 1')
	send_command('wait .2;text sekkanoki create "[ Sekkanoki ]";wait .3;text sekkanoki size '..FontSize..';text sekkanoki pos '..HUDposXColumn1..' -100;text sekkanoki bg_transparency 1')
	send_command('wait .2;text sengikori create "[ Sengikori ]";wait .3;text sengikori size '..FontSize..';text sengikori pos '..HUDposXColumn1..' -100;text sengikori bg_transparency 1')
	send_command('wait .2;text hagakure create "[ Hagakure ]";wait .3;text hagakure size '..FontSize..';text hagakure pos '..HUDposXColumn1..' -100;text hagakure bg_transparency 1')
	send_command('wait .2;text highjump create "[ High J. ]";wait .3;text highjump size '..FontSize..';text highjump pos '..HUDposXColumn1..' -100;text highjump bg_transparency 1')
	send_command('wait .2;text superjump create "[ Super J. ]";wait .3;text superjump size '..FontSize..';text superjump pos '..HUDposXColumn1..' -100;text superjump bg_transparency 1')
	send_command('wait .2;text aggressor create "[ Aggres. ]";wait .3;text aggressor size '..FontSize..';text aggressor pos '..HUDposXColumn1..' -100;text aggressor bg_transparency 1')
	send_command('wait .2;text berserk create "[ Berserk ]";wait .3;text berserk size '..FontSize..';text berserk pos '..HUDposXColumn1..' -100;text berserk bg_transparency 1')
	send_command('wait .2;text hasso create "[ Hasso ]";wait .3;text hasso size '..FontSize..';text hasso pos '..HUDposXColumn1..' -100;text hasso bg_transparency 1')
	send_command('wait .2;text seigan create "[ Seigan ]";wait .3;text seigan size '..FontSize..';text seigan pos '..HUDposXColumn1..' -100;text seigan bg_transparency 1')
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
		Notifications = 'TP Return: '..player.tp..''
		if HUD == 'On' then
			send_command('text notifications text "'..Notifications..'";text notifications color 0 255 255')
		else
			windower.add_to_chat(8,''..Notifications..'')
		end
	elseif command == 'ClearNotifications' then --these reset the Notifications display back to a basic state
		if HUD == 'On' then 
			if buffactive['weakness'] and DTOverride == 'On' then
				send_command('text notifications text "Status: Weak (DT Override)";text notifications color 205 133 63')
			elseif buffactive['weakness'] then
				send_command('text notifications text "Status: Weak";text notifications color 205 133 63')
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
	elseif command == 'LoadHUD' then
		LoadHUD = true
		send_command('text loading hide')
		if HUDRecast == 'On' then --using the HUDRecast
			if player.equipment.main == 'Amanomurakumo' or player.equipment.main == 'Kogarasumaru' or player.equipment.main == 'Masamune' or player.equipment.main == 'Dojikiri Yasutsuna' then
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
			if player.equipment.main == 'Amanomurakumo' or player.equipment.main == 'Kogarasumaru' or player.equipment.main == 'Masamune' or player.equipment.main == 'Dojikiri Yasutsuna' then
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
		windower.add_to_chat(200,'LockstyleField: '..(''..LockstyleField..''):color(8)..'')
		windower.add_to_chat(200,'LockstyleTown: '..(''..LockstyleTown..''):color(8)..'')
		windower.add_to_chat(200,'Book: '..(''..Book..''):color(8)..'')
		windower.add_to_chat(200,'Page: '..(''..Page..''):color(8)..'')
		windower.add_to_chat(200,'Chat: '..(''..Chat..''):color(8)..'')
		windower.add_to_chat(200,'MeikTimer: '..(''..MeikTimer..''):color(8)..'')
		windower.add_to_chat(200,'YaegTimer: '..(''..YaegTimer..''):color(8)..'')
		windower.add_to_chat(200,'DTCtrlPlus: '..(''..DTCtrlPlus..''):color(8)..'')
		windower.add_to_chat(200,'ZoneGear: '..(''..ZoneGear..''):color(8)..'')
		windower.add_to_chat(200,'AlertSounds: '..(''..AlertSounds..''):color(8)..'')
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
		windower.add_to_chat(200,'HassoModeColor: '..(''..HassoModeColor..''):color(8)..'')
		windower.add_to_chat(200,'SeiganModeColor: '..(''..SeiganModeColor..''):color(8)..'')
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
			send_command('input /lockstyleset '..LockstyleField..'')
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
	end
end

-------------------------------------------
--              CHOOSE SET               --
-------------------------------------------

function choose_set()
	if player.status == "Resting" and HUD == 'On' then
		if buffactive['weakness'] and DTOverride == 'On' then
			send_command('text notifications text "Status: Weak (DT Override)";text notifications color 205 133 63')
		elseif buffactive['weakness'] then
			send_command('text notifications text "Status: Weak";text notifications color 205 133 63')
		elseif DTOverride == 'On' then
			send_command('text notifications text "Status: Resting (DT Override)";text notifications color 255 255 255')
		else
			send_command('text notifications text "Status: Resting";text notifications color 255 255 255')
		end
	elseif player.status == "Engaged" then
		if HUD == 'On' then 
			if buffactive['weakness'] and DTOverride == 'On' then
				send_command('text notifications text "Status: Weak (DT Override)";text notifications color 205 133 63')
			elseif buffactive['weakness'] then
				send_command('text notifications text "Status: Weak";text notifications color 205 133 63')
			elseif DTOverride == 'On' then
				send_command('text notifications text "Status: Engaged (DT Override)";text notifications color 255 255 255')
			else
				send_command('text notifications text "Status: Engaged";text notifications color 255 255 255')
			end
		end
		if Mode == 'Hasso' then
			if DTOverride == 'On' then
				equip(set_combine(sets.hasso, sets.dtoverride))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Hasso + DT Override]')
				end
			else
				equip(sets.hasso)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Hasso]')
				end
			end
		elseif Mode == 'Seigan' then
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
			if buffactive['weakness'] and DTOverride == 'On' then
				send_command('text notifications text "Status: Weak (DT Override)";text notifications color 205 133 63')
			elseif buffactive['weakness'] then
				send_command('text notifications text "Status: Weak";text notifications color 205 133 63')
			elseif DTOverride == 'On' then
				send_command('text notifications text "Status: Idle (DT Override)";text notifications color 255 255 255')
			else
				send_command('text notifications text "Status: Idle";text notifications color 255 255 255')
			end
		end
		if AdoulinZones:contains(world.area) then
			if Mode == 'Seigan' then
				equip(set_combine(sets.seigan, sets.adoulin, sets.idle))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Seigan + Adoulin + Idle]')
				end
			else
				equip(set_combine(sets.hasso, sets.adoulin, sets.idle))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Hasso + Adoulin + Idle]')
				end
			end
		elseif BastokZones:contains(world.area) then
			if Mode == 'Seigan' then
				equip(set_combine(sets.seigan, sets.bastok, sets.idle))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Seigan + Bastok + Idle]')
				end
			else
				equip(set_combine(sets.hasso, sets.bastok, sets.idle))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Hasso + Bastok + Idle]')
				end
			end
		elseif SandyZones:contains(world.area) then
			if Mode == 'Seigan' then
				equip(set_combine(sets.seigan, sets.sandoria, sets.idle))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Seigan + San d\'Oria + Idle]')
				end
			else
				equip(set_combine(sets.hasso, sets.sandoria, sets.idle))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Hasso + San d\'Oria + Idle]')
				end
			end
		elseif WindyZones:contains(world.area) then
			if Mode == 'Seigan' then
				equip(set_combine(sets.seigan, sets.windurst, sets.idle))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Seigan + Windurst + Idle]')
				end
			else
				equip(set_combine(sets.hasso, sets.windurst, sets.idle))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Hasso + Windurst + Idle]')
				end
			end
		elseif TownZones:contains(world.area) then
			if Mode == 'Seigan' then
				equip(set_combine(sets.seigan, sets.town, sets.idle))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Seigan + Town + Idle]')
				end
			else
				equip(set_combine(sets.hasso, sets.town, sets.idle))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Hasso + Town + Idle]')
				end
			end
		elseif DTOverride == 'On' then
			if Mode == 'Seigan' then
				equip(set_combine(sets.seigan, sets.idle, sets.dtoverride))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Seigan + DT Override + Idle]')
				end
			else
				equip(set_combine(sets.hasso, sets.idle, sets.dtoverride))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Hasso + DT Override + Idle]')
				end
			end
		else
			if Mode == 'Seigan' then
				equip(set_combine(sets.seigan, sets.idle))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Seigan + Idle]')
				end
			else
				equip(set_combine(sets.hasso, sets.idle))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Hasso + Idle]')
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
		elseif (spell.target.distance >= (spell.target.model_size + 3)) and not (spell.english == 'Starlight' or spell.english == 'Moonlight') then
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
		if buffactive['Sekkanoki'] then
			equip(set_combine(sets.ws, sets.sekkanoki))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Sekkanoki + Weapon Skill]')
			end
		elseif buffactive['Meikyo Shisui'] then
			equip(set_combine(sets.ws, sets.meikyoshisui))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Meikyo Shisui + Weapon Skill]')
			end
		else
			equip(sets.ws)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Weapon Skill]')
			end
		end
	elseif spell.english == 'Meikyo Shisui' then
		if MeikTimer == 'On' then
			send_command('input /echo [Meikyo Shisui] 30 seconds;wait 10;input /echo [Meikyo Shisui] 20 seconds;wait 10;input /echo [Meikyo Shisui] 10 seconds')
		end
	elseif spell.english == 'Yaegasumi' and IntTimer == 'On' then
		send_command('input /echo [Yaegasumi] 40 seconds;wait 10;input /echo [Yaegasumi] 30 seconds;wait 10;input /echo [Yaegasumi] 20 seconds;wait 10;input /echo [Yaegasumi] 10 seconds')
	elseif spell.english == 'Holy Circle' then
		equip(sets.holycircle)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Holy Circle + Enmity]')
		end
	elseif spell.english == 'Hasso' then
		Mode = 'Hasso' --Set Mode to Hasso when we use it
		choose_set() --Instead of directly equipping sets.hasso, we run through the choose_set function to choose based on our status.
	elseif spell.english == 'Seigan' then
		Mode = 'Seigan' --Set Mode to Seigan when we use it
		choose_set() --Instead of directly equipping sets.seigan, we run through the choose_set function to choose based on our status.
	elseif spell.english == 'Meditate' then
		equip(sets.meditate)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Meditate]')
		end
	elseif string.find(spell.english,'Jump') then --Any Jump ability
		equip(sets.jump)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Jump]')
		end
	elseif spell.english == 'Warding Circle' then
		equip(sets.wardingcircle)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Warding Circle]')
		end
	elseif spell.english == 'Shikikoyo' then
		equip(sets.shikikoyo)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Shikikoyo]')
		end
	elseif spell.english == 'Blade Bash' then
		equip(sets.bladebash)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Blade Bash]')
		end
	elseif spell.english == 'Sengikori' then
		equip(sets.sengikori)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Sengikori]')
		end
	elseif (spell.english == 'Spectral Jig' or spell.english == 'Sneak' or spell.english == 'Monomi: Ichi' or spell.english == 'Monomi: Ni') and buffactive['Sneak'] and spell.target.type == 'SELF' then
		send_command('cancel 71')
	end
end

-------------------------------------------
--               MIDCAST                 --
-------------------------------------------

function midcast(spell)
	if spell.type == 'Trust' then
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
		send_command('text bg1 hide;text bg2 hide;text bg3 hide;text meditate hide;text sekkanoki hide;text sengikori hide;text hagakure hide;text aggressor hide;text berserk hide;text highjump hide;text superjump hide;text hasso hide;text seigan hide;text mode hide;text notifications hide;text debuffs hide;text aftermath hide')
    elseif status ~= 4  and HUD == 'On' and ShowHUD == false then --Out of cutscene: SHow the HUD
		ShowHUD = true
		send_command('text bg1 show;text bg2 show;text bg3 show;text meditate show;text sekkanoki show;text sengikori show;text hagakure show;text aggressor show;text berserk show;text highjump show;text superjump show;text hasso show;text seigan show;text mode show;text notifications show;text debuffs show;text aftermath show')
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
	if (buff == 2 or buff == 19) then
		equip({neck="Vim Torque"})
	end
	if buff == 15 and NotiDoom == 'On' then
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
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
	elseif buff == 2 or buff == 19 then --lose sleep, we of course clear debuffs but also run choose_set since we had equipped the OpoOpo
		if HUD == 'On' then
			send_command('gs c ClearDebuffs')
		end
		choose_set()
	end
end)

windower.register_event('tp change',function()
	if player.tp == 3000 and Noti3000TP == 'On' then
		Notifications = '«« 3000 TP »»'
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
			send_command('text debuffs text "«« CHARM »»";text debuffs color 255 50 50')
		elseif buffactive['Terror'] and NotiTerror == 'On' then
			send_command('text debuffs text "«« TERROR »»";text debuffs color 255 50 50')
		elseif buffactive['Petrification'] and NotiPetrification == 'On' then
			send_command('text debuffs text "«« PETRIFICATION »»";text debuffs color 255 50 50')
		elseif buffactive['Sleep'] and NotiSleep == 'On' then
		elseif buffactive['Sleep'] and NotiSleep == 'On' then
			send_command('text debuffs text "«« SLEEP »»";text debuffs color 255 50 50')
		elseif buffactive['Stun'] and NotiStun == 'On' then
			send_command('text debuffs text "«« STUN »»";text debuffs color 255 50 50')
		elseif buffactive['Amnesia'] and NotiAmnesia == 'On' then
			send_command('text debuffs text "«« AMNESIA »»";text debuffs color 255 50 50')
		elseif buffactive['Silence'] and NotiSilence == 'On' then
			send_command('text debuffs text "«« SILENCE »»";text debuffs color 255 50 50')
		elseif buffactive['Mute'] and NotiMute == 'On' then
			send_command('text debuffs text "«« MUTE »»";text debuffs color 255 50 50')
		elseif buffactive['Plague'] and NotiPlague == 'On' then
			send_command('text debuffs text "«« PLAGUE »»";text debuffs color 255 50 50')
		elseif buffactive['Paralysis'] and NotiPara == 'On' then
			send_command('text debuffs text "«« PARALYSIS »»";text debuffs color 255 50 50')
		elseif buffactive['Encumbrance'] and NotiEncumbrance == 'On' then
			send_command('text debuffs text "«« ENCUMBRANCE »»";text debuffs color 255 50 50')
		elseif buffactive['Curse'] and NotiCurse == 'On' then
			send_command('text debuffs text "«« CURSE »»";text debuffs color 255 50 50')
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
			if buffactive['Hasso'] then --Hasso is up, so we're in Hasso mode
				Mode = 'Hasso'
				send_command('text mode text "Mode: Hasso";text mode color '..HassoModeColor..'')
			elseif buffactive['Seigan'] then --Seigan is up, so we're in Seigan Mode
				Mode = 'Seigan'
				send_command('text mode text "Mode: Seigan";text mode color '..SeiganModeColor..'')
			else --Neither Hasso or Seigan is up, no mode is set
				Mode = 'None'
				send_command('text mode text "Mode: None";text mode color 255 50 50')
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
			if NotiDoom == 'On' and buffactive['Doom'] then 
				send_command('text debuffs text "«« DOOM »»";text debuffs bg_transparency 200;text debuffs color 0 0 0;text debuffs bg_color 255 255 255;wait .5;text debuffs bg_color 255 204 51')
			end
			if HUDRecast == 'On' then --using the HUDRecast
				--HUDRecast goes in Line 1:
				if Mode == 'Hasso' or Mode == 'Seigan' then --are we in Hasso or Seigan mode?
					send_command('text hasso pos '..HUDposXColumn1..' -100')						--Hasso is not visible
					send_command('text seigan pos '..HUDposXColumn2..' -100')						--Seigan is not visible
					send_command('text meditate pos '..HUDposXColumn1..' '..HUDposYLine1..'')		--Meditate goes in Column 1
					send_command('text sekkanoki pos '..HUDposXColumn2..' '..HUDposYLine1..'')		--Sekkanoki goes in Column 2
					send_command('text sengikori pos '..HUDposXColumn3..' '..HUDposYLine1..'')		--Sengikori goes in Column 3
					send_command('text hagakure pos '..HUDposXColumn4..' '..HUDposYLine1..'')		--Hagakure goes in Column 4
					if player.sub_job == 'WAR' and player.sub_job_level >= 1 then
						send_command('text berserk pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Berserk goes in Column 5
						send_command('text aggressor pos '..HUDposXColumn6..' '..HUDposYLine1..'')	--Aggressor goes in Column 6
						send_command('text highjump pos '..HUDposXColumn5..' -100')					--High Jump is not visible
						send_command('text superjump pos '..HUDposXColumn6..' -100')				--Super Jump is not visible
					elseif player.sub_job == 'DRG' and player.sub_job_level >= 1 then
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
				else --if not Hasso or Seigan, then we have no Mode set currently
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
				--REMAs equipped:
				if (player.equipment.main == 'Amanomurakumo' or player.equipment.main == 'Kogarasumaru' or player.equipment.main == 'Masamune' or player.equipment.main == 'Dojikiri Yasutsuna') and REMA == false then
					--if we have any REMAs equipped we place the Aftermath text object inline with the others
					send_command('text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')			--Background Line 3
					send_command('text mode pos '..HUDposXColumn1..' '..HUDposYLine2..'')			--Mode goes in Line 2, Column 1
					send_command('text aftermath pos '..HUDposXColumn4..' '..HUDposYLine2..'')		--Aftermath goes in Line 2, Column 4
					send_command('text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')	--Notifications goes in Line 3, Column 1
					send_command('text debuffs pos '..HUDposXColumn4..' '..HUDposYLine3..'')		--Debuffs goes in Line 3, Column 4
					REMA = true --This toggle then gets set to true since now we have a REMA equipped
				elseif not (player.equipment.main == 'Amanomurakumo' or player.equipment.main == 'Kogarasumaru' or player.equipment.main == 'Masamune' or player.equipment.main == 'Dojikiri Yasutsuna') and REMA == true then 
					--if we do not have any REMAs equipped we move the Aftermath text object out of view and adjust the others
					send_command('text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')			--Background Line 3
					send_command('text mode pos '..HUDposXColumn1..' '..HUDposYLine2..'')			--Mode goes in Line 2, Column 1
					send_command('text aftermath pos '..HUDposXColumn4..' -100')					--Aftermath is not visible
					send_command('text notifications pos '..HUDposXColumn1..' '..HUDposYLine3..'')	--Notifications goes in Line 3, Column 1
					send_command('text debuffs pos '..HUDposXColumn4..' '..HUDposYLine3..'')		--Debuffs goes in Line 3, Column 4
					REMA = false --This toggle gets set to false since we no longer have a REMA equipped
				end
			else --not using the HUDRecast
				--REMAs equipped:
				if (player.equipment.main == 'Amanomurakumo' or player.equipment.main == 'Kogarasumaru' or player.equipment.main == 'Masamune' or player.equipment.main == 'Dojikiri Yasutsuna') and REMA == false then
					--if we have any REMAs equipped we place the Aftermath text object inline with the others
					send_command('text bg3 pos '..HUDposXColumn1..' -100')							--Background Line 3 is not visible
					send_command('text mode pos '..HUDposXColumn1..' '..HUDposYLine1..'')			--Mode goes in Line 1, Column 1
					send_command('text aftermath pos '..HUDposXColumn4..' '..HUDposYLine1..'')		--Aftermath goes in Line 1, Column 4
					send_command('text notifications pos '..HUDposXColumn1..' '..HUDposYLine2..'')	--Notifications goes in Line 2, Column 1
					send_command('text debuffs pos '..HUDposXColumn4..' '..HUDposYLine2..'')		--Debuffs goes in Line 2, Column 4
					REMA = true
				elseif not (player.equipment.main == 'Amanomurakumo' or player.equipment.main == 'Kogarasumaru' or player.equipment.main == 'Masamune' or player.equipment.main == 'Dojikiri Yasutsuna') and REMA == true then
					--if we do not have any REMAs equipped we move the Aftermath text object out of view and adjust the others
					send_command('text bg3 pos '..HUDposXColumn1..' -100')							--Background Line 3 is not visible
					send_command('text mode pos '..HUDposXColumn1..' '..HUDposYLine1..'')			--Mode goes in Line 1, Column 1
					send_command('text aftermath pos '..HUDposXColumn4..' -100')					--Aftermath is not visible
					send_command('text notifications pos '..HUDposXColumn1..' '..HUDposYLine2..'')	--Notifications goes in Line 2, Column 1
					send_command('text debuffs pos '..HUDposXColumn4..' '..HUDposYLine2..'')		--Debuffs goes in Line 2, Column 4
					REMA = false
				end
			end
			--Recast updates:
			MeditateRecast = windower.ffxi.get_ability_recasts()[134]
			SekkanokiRecast = windower.ffxi.get_ability_recasts()[140]
			SengikoriRecast = windower.ffxi.get_ability_recasts()[141]
			HagakureRecast = windower.ffxi.get_ability_recasts()[54]
			HassoRecast = windower.ffxi.get_spell_recasts()[138]
			SeiganRecast = windower.ffxi.get_spell_recasts()[139]
			if player.sub_job == 'WAR' and player.sub_job_level >= 1 then
				AggressorRecast = windower.ffxi.get_ability_recasts()[4]
				BerserkRecast = windower.ffxi.get_ability_recasts()[1]
			elseif player.sub_job == 'DRG' and player.sub_job_level >= 1 then
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
			if player.sub_job == 'WAR' and player.sub_job_level >= 1 then
				if buffactive['Aggressor'] then AggressorColor = '75 255 75'
				elseif AggressorRecast > 0 then AggressorColor = '255 165 0'
				else AggressorColor = '255 50 50'
				end
				if buffactive['Berserk'] then BerserkColor = '75 255 75'
				elseif BerserkRecast > 0 then BerserkColor = '255 165 0'
				else BerserkColor = '255 50 50'
				end
			elseif player.sub_job == 'DRG' and player.sub_job_level >= 1 then
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
			if player.sub_job == 'WAR' and player.sub_job_level >= 1 then
				send_command('text aggressor color '..AggressorColor..'')
				send_command('text berserk color '..BerserkColor..'')
			elseif player.sub_job == 'DRG' and player.sub_job_level >= 1 then			
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
			if NotiTime == 'On' and HUD == ' On ' then
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
		send_command('text bg1 delete;text bg2 delete;text bg3 delete;text meditate delete;text sekkanoki delete;text sengikori delete;text hagakure delete;text aggressor delete;text berserk delete;text highjump delete;text superjump delete;text hasso delete;text seigan delete;text loading delete;text mode delete;text notifications delete;text debuffs delete;text aftermath delete') --delete the different text objects
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
