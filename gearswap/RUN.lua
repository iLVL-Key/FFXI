-------------------------------------------
--Keys Gearswap lua file for Rune Fencer --
-------------------------------------------
--[[
-------------------------------------------
--                 NOTES                 --
-------------------------------------------

Updates to this file and other GearSwap files and addons can be found at
https://github.com/iLVL-Key/FFXI

Place both this file and the sounds folder inside the GearSwap data folder
	/addons/GearSwap/data/sounds/
	/addons/GearSwap/data/RUN.lua

To switch between gear modes, use any of these three options:
1. A macro with the following in it
	/console mode
2. An alias command
	//mode
3. A keyboard shortcut
	CTRL+G
	(Default is G, can be changed in the settings)

To use /BLU AOE spells, use a macro for Sheep Song and it will cycle through Sheep Song, Geist Wall,
Stinking Gas, and Soporific, in that order, as recast timers allow.

To use /BLU Single target spells, use a macro for Flash and it will cycle through Flash, Jettatura,
and Blank Gaze, in that order, as recast timers and distance allow (or if you are /WAR it will also Provoke).

To use the Rune Activator function, use any of these options to first select an element:
1. A macro with the following in it
	/console RuneCycle
	(this will cycle through the different elements)
	or
	/console RuneEarth
	/console RuneWater
	etc.
2. An alias command
	//runecycle
	(this will cycle through the different elements)
	or
	//runeearth
	//runewater
	etc.
	(these can also be shortened to //rcycle, //rearth, etc., as well as using earth or stone, wind or aero, etc.)
After an element is selected, use any of these options to activate a Rune of that element:
1. A macro with the following in it
	/console Rune
2. A alias command
	//rune

Run the Lockstyle function yourself at any time by typing
	//lockstyle or //lstyle

Hide or show the HUD at any time by typing
	//hidehud or //showhud

For the HUD function (see options below), suggested placement is center screen, just above your chat log.

IMPORTANT:
When you load this file for the first time, your HUD may look all wrong.
The defaults preloaded are for a screen at 3440x1400. I have not tested at any other resolution.
Adjust the FontSize, LineSpacer, and ColumnSpacer options as needed.

Required Windower Addons: Text

--]]

-------------------------------------------
--                OPTIONS                --
-------------------------------------------

AutoLockstyle	=	'On'	--[On/Off]		Automatically sets your lockstyle. Uses the Battle and Town sets below.
LockstyleCombat	=	'7'		--[1-20]		Your Lockstyle set when in a battle zone.
LockstyleTown	=	'1'		--[1-20]		Your Lockstyle set when in a town zone.
							--				If you do not want a separate town lockstyle, set this to the same as LockstyleCombat.
Book			=	'6'		--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
Page			=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
SfoTimer		=	'On'	--[On/Off]		Displays a timer for Elemental Sforzo in echo.
OdyTimer		=	'On'	--[On/Off]		Displays a timer for Odyllic Subterfuge in echo.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions
							--				(Town limits this to town gear only)
AlertSounds		=	'On'	--[On/Off]		Plays a sound on alerts.
UseEcho			=	'R'		--[E/R/Off]		Automatically uses an (E)cho Drop or (R)emedy instead of spell when you are silenced.
AutoHWater		=	'On'	--[On/Off]		Automatically attempts to use Holy Waters when you get Doomed until it wears off.
DoomAlert		=	'On'	--[On/Off]		Alerts your party when you are doomed.
DoomOnText		=	'doom'			--		Text that displays in party chat when you are doomed. 
DoomOffText		=	'doom off'		--		That that displays in party chat when you are no longer doomed.

-- Heads Up Display --
HUDposX			=	967		--				X position for the HUD. 0 is left of the window, increasing this number will move it to the right.
HUDposYLine1	=	745		--				Y position for the HUD. 0 is top of the window, increasing this number will move it downward.
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
NotiWSDamage		=	'On'	--[On/Off]	Displays your Weapon Skill damage.
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

StartMode		=	'Auto'		--[Auto/Combat/Neutral]
								--	Determines the Mode you will start in. Current Mode can be changed at any time by using any of the 
								--	three options listed above in the Notes section (a macro, alias, or keyboard shortcut).
RemoveAuto		=	'No'		--[Yes/No]	Don't like the Auto Mode? Remove it entirely.
DefaultRune		=	'Tenebrae'	--Starting Rune element for the Rune Activator function.
ModeCtrlPlus	=	'g'			--Sets the keyboard shortcut you would like to cycle between Modes. CTRL+G is default.
LowHPThreshold	=	1000		--Below this number is considered Low HP.
DangerRepeat	=	10			--Maximum number of times the Danger Sound will repeat, once per second.
RRReminderTimer	=	1800		--Delay in seconds between checks to see if Reraise is up (300 is 5 minutes)
NotiDelay		=	6			--Delay in seconds before certain notifications will automatically clear.
HUDBGTrans		=	'175'		--Background transparency for the HUD. (0 = fully clear, 255 = fully opaque)
Debug			=	'Off'		--[On/Off]

--Color values in RGB for the HUD gear modes
Autocolor		=	'125 200 255'	--Auto Mode
Combatcolor		=	'255 125 125'	--Combat Mode
Neutralcolor	=	'150 255 150'	--Neutral Mode

--Color values in RGB for the HUD Aftermath status
Aftermath1color =	'0 127 255'		--Aftermath Level 1
Aftermath2color =	'75 255 75'		--Aftermath Level 2
Aftermath3color =	'255 255 50'	--Aftermath Level 3

-------------------------------------------
--               GEAR SETS               --
-------------------------------------------

function get_sets()

	-- Tank (Damage Taken-, Parry, Magic Evasion, Double/Triple/Quadruple Attack, Accuracy, DEX)
	-- This is the main Tank set. Focus on DT first, then fill in DPS gear around that.
	sets.tank = {
		ammo="Staunch Tathlum",
		head="Nyame Helm",
		body="Erilaz Surcoat +3",
		hands="Turms Mittens +1",
		legs="Eri. Leg Guards +3",
		feet="Turms Leggings +1",
		neck="Futhark Torque +2",
		waist="Carrier's Sash",
		left_ear="Genmei Earring",
		right_ear="Erilaz Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Defending Ring",
		back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Parrying rate+5%',}},
	}

	-- Kite (Damage Taken-, Evasion, Magic Evasion, Enmity+, VIT, Defense)
	-- When you're tanking but not engaged. Focus is on pure survival.
	sets.kite = {
		ammo="Staunch Tathlum",
		head="Nyame Helm",
		body="Erilaz Surcoat +3",
		hands="Erilaz Gauntlets +3",
		legs="Carmine Cuisses +1",
		feet="Erilaz Greaves +3",
		neck="Futhark Torque +2",
		waist="Carrier's Sash",
		left_ear="Ethereal Earring",
		right_ear="Cryptic Earring",
		left_ring="Moonbeam Ring",
		right_ring="Defending Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
	}

	-- Oh Shit
	-- Full DT- and everything you've got with Absorbs or Annuls Damage
	sets.ohshit = {
		head="Erilaz Galea +3",
		body="Erilaz Surcoat +3",
		hands="Turms Mittens +1",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck="Warder's Charm +1",
		left_ring="Shadow Ring",
		right_ring="Defending Ring",
		back="Shadow Mantle"
	}

	-- Refresh (only need Refresh gear in here, will inherit the rest from the Kite set above)
	sets.refresh = set_combine(sets.kite, {
		ammo="Homiliary",
		head="Rawhide Mask",
		body="Agwu's Robe",
		hands="Regal Gauntlets",
		waist="Flume Belt",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
	})

	-- Idle (Movement speed)
	-- Combines with Tank/DPS set based on current mode
	sets.movementspeed = {
		legs="Carmine Cuisses +1",
	}

	-- Enmity (full Enmity+ for spells/abilities)
	sets.enmity = {
		ammo="Sapience Orb",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck="Moonlight Necklace",
		left_ear="Cryptic Earring",
		right_ear="Friomisi Earring",
		left_ring="Petrov Ring",
		right_ring="Vengeful Ring",
	}

	-- Rest
	sets.rest = {
		waist="Austerity Belt",
	}

	-- Fast Cast (cap is 80%)
	sets.fastcast = {
		ammo="Sapience Orb", --2
		head="Rune. Bandeau +3", --14
		body="Erilaz Surcoat +3", --13
		hands="Leyline Gloves", --5+1
		legs="Nyame Flanchard",
		feet="Carmine Greaves +1", --8
		neck="Baetyl Pendant", --4
		waist="Flume Belt",
		left_ear="Loquac. Earring", --2
		right_ear="Etiolation Earring", --1
		left_ring="Prolix Ring", --2
		right_ring="Kishar Ring", --4
	}

	-- Spell Interruption Rate Down (Need 102% for actual 100% cap, don't forget about 10% from merits)
	-- NOTE: This set gets combined with (and overwrites) the next 5 sets (Healing through Enhancing) based on Mode and whether or not you are in combat
	sets.sird = {
		ammo="Staunch Tathlum",			--10
		head="Erilaz Galea +3",			--20
		hands="Rawhide Gloves",			--15
		legs="Carmine Cuisses +1",		--20
		neck="Moonlight Necklace",		--15
		waist="Audumbla Sash",			--10
		--left_ring="Evanescence Ring",	--5
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Spell interruption rate down-10%',}}, --10
	}

	-- Healing (Cure Potency, Enmity)
	sets.healing = {
		body="Vrikodara Jupon",
		right_ear="Mendi. Earring",
	}

	-- Enmity Spells (Fast Cast, will not be used to cast faster but instead to help reduce recast)
	-- Combines with Enmity set
	-- Flash, Foil, BLU spells use this.
	sets.enmityspells = set_combine(sets.enmity, {
		head="Carmine Mask +1",
		feet="Carmine Greaves +1",
	})


	-- Regen (Regen+, Enhancing Magic Duration)
	sets.regen = {
		head="Rune. Bandeau +3",
		hands="Regal Gauntlets",
		right_ear="Erilaz Earring +1",
	}

	-- Enhancing Magic (Enhancing Magic Duration, Enhancing Magic Skill)
	-- Crusade, Aquaveil, Temper, Protect, Shell, and Spikes uses this.
	sets.enhancing = {
		head="Erilaz Galea +3",
		hands="Regal Gauntlets",
		legs="Carmine Cuisses +1",
		feet="Futhark Trousers +3",
		neck="Melic Torque",
		left_ear="Mimir Earring",
		right_ear="Andoaa Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
	}

	-- Phalanx (Phalanx, Enhancing Magic Duration)
	sets.phalanx = set_combine(sets.enhancing, {
		head="Fu. Bandeau +3",
	})

	-- Refresh Spell (Refresh potency, Enhancing Magic Duration)
	sets.refreshspell = {
		head="Erilaz Galea +3",
		hands="Regal Gauntlets",
		feet="Futhark Trousers +3",
	}

	-- Holy Water (Holy Water+)
	sets.hwater = {
		neck="Nicander's Necklace",
		ring1="Blenmot's Ring +1",
		ring2="Blenmot's Ring +1",
	}

	-- Weapon Skill (STR, Weapon Skill Damage, Attack, Double/Triple Attack)
	sets.ws = {
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Ishvara Earring",
		right_ear="Moonshade Earring",
		left_ring="Regal Ring",
		right_ring="Karieyh Ring +1",
		back={ name="Ogma's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}

	-- Dimidiation (80% DEX mod, 2-hit)
	-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
	sets.dim = set_combine(sets.ws, {
		neck="Fotia Gorget",
		waist="Fotia Belt",
		back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Parrying rate+5%',}},
	})

	-- Resolution (73~85% STR mod, 5-hit)
	-- Combines with Weapon Skill set, only necessary to set the slots with specific desired stats
	sets.res = set_combine(sets.ws, {
		neck="Fotia Gorget",
		waist="Fotia Belt",
	})

	-- Elemental Sforzo
	sets.sforzo = {
		body="Futhark Coat +3",
	}

	-- Valiance and Vallation (Enhances Valiance and Vallation gear)
	sets.valiance = set_combine(sets.enmity, {
		body="Runeist's Coat +3",
	})

	-- Swordplay (Enhances Swordplay gear)
	sets.swordplay = set_combine(sets.enmity, {
		hands="Futhark Mitons +3",
	})

	-- Swipe and Lunge (Magic Attack Bonus)
	sets.swipe = set_combine(sets.enmity, {
		sub="Balarama Grip",
		ammo="Ghastly Tathlum +1",
		body="Cohort Cloak +1",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Agwu's Pigaches",
		neck="Baetyl Pendant",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Halasz Earring",
		left_ring="Shiva Ring +1",
		right_ring="Metamor. Ring +1",
	})

	-- Embolden (Enhances Embolden gear)
	sets.embolden = set_combine(sets.enmity, {
		back="Evasionist's Cape",
	})

	-- Vivacious Pulse (Enhances Vivacious Pulse gear, Divine skill)
	sets.pulse = set_combine(sets.enmity, {
		head="Erilaz Galea +3",
	})

	-- Gambit (Enhances Gambit gear)
	sets.gambit = set_combine(sets.enmity, {
		hands="Runeist's Mitons +3",
	})

	-- Battuta (Enhances Battuta gear)
	sets.battuta = set_combine(sets.enmity, {
		head="Fu. Bandeau +3",
	})

	-- Rayke (Enhances Rayke gear)
	sets.rayke = set_combine(sets.enmity, {
		feet="Futhark Boots",
	})

	-- Liement (Enhances Liement gear)
	sets.liement = set_combine(sets.enmity, {
		body="Futhark Coat +3",
	})

	-- One For All (HP+)
	sets.one4all = set_combine(sets.enmity, {

	})

	-- Default Town Gear (Put all your fancy-pants gear in here you want to showboat around town. Does not lockstyle this gear, only equips)
	sets.town = {

	}

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
TopVersion = 'Max HP Boost' --Leave this alone, used for debugging purposes



	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX          DO NOT EDIT BELOW THIS LINE          XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXX                                               XXXXXXXXXXXXXXXXXX--
	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--



BottomVersion = 'Max HP Boost'
FileVersion = '01.24.23'

-------------------------------------------
--               UPDATES                 --
-------------------------------------------

--[[
If the new updates Version Compatibility Codename matches your current files TopVersion,
simply replace everything under the "Do Not Edit Below This Line".
Only when the Version Compatibility Codename changes will you need to update the entire file.

01.24.23 (Version Compatibility Codename: Max HP Boost)
-Adjusted WS Damage Notification to display Skillchain damage.

01.21.23 (Version Compatibility Codename: Max HP Boost)
-Adjusted Macro Page timing. Should fix occasional issue with macros deleting themselves.
-Adjusted WS Damage Notification to count blinked WSs and WSs for zero as a miss. Blinks would previously display the number of shadows as the damage number.
-Fixed issue with WS Damage Notification where some abilities and weapon skills would occasionally gets mixed up.

01.10.23 (Version Compatibility Codename: Max HP Boost)
-Adjusted HUD to automatically hide during zoning.
-Removed Omen and Vagary notifications. Those have been spun out into their own windower addon called Callouts.
-Updated Version Compatibility Codename to Max HP Boost.

12.27.22 (Version Compatibility Codename: Inquartata)
-Overhauled the Aftermath notification. Renamed to Weapons. Will now always show your equipped weapon as a default state when no aftermath is up. Will change colors based on what your current TP will give you for an Aftermath effect.
-Removed the option to turn off the HUD. While I generally think the more options the better, the HUD is a main part of this lua.
-Fixed an error with recast timers and the /BLU spells.
-Fixed occasional error messages from the Text addon when loading/reloading the file.
-Updated Version Compatibility Codename to Inquartata.
-Code cleanup.

12.06.22 (Version Compatibility Codename: Magic Defense Bonus)
-Overhauled Low HP notification. Notification and sound no longer activates in towns. Changed the Advanced Option from selecting "Once" or "Constant" to instead selecting the number of times the sound will repeat while your HP is low. Removed the 30 second window before triggering again.
-Adjusted certain notification to now automatically clear after a short delay.
-Adjusted the Rune Cycling notification to first show your currently selected Rune element before cycling.
-Removed the option for using the OhShit gear set. The gear set itself still remains and funtionality has not changed. Having the option was redundant as you can simply leave the set empty.
-Updated Version Compatibility Codename to Magic Defense Bonus.
-Code cleanup.

11.30.22 (Version Compatibility Codename: Tenacity)
-First version
-Started from Paladin file version 07.18.22
-Overhauled how enmity spells are handled. No more macro with a custom command in it. If you are /BLU, just use a macro for Sheep Song and it will cast Sheep Song, Geist Wall, Stinking Gas, or Soporific, in that order, as recasts timers allow. Additionally, now you can use a macro for Flash and it will also use Jettatura or Blank Gaze if you are /BLU, or Provoke if you are /WAR, depending on recast timers and distance to target.
-Overhauled the Mode functionality. There are now 3 modes: Auto, Combat, and Neutral. Combat and Neutral are the basic modes that can be selected individually or Auto will switch between the two in a (mostly) intelligent manner. Combat has a focus on tank sets and SIRD, while Neutral is for refresh and maximizing gear bonuses for buffs. What auto decides is based off when the game thinks you are in combat. This works just fine in most cases, but is not always exactly correct, so you can manually rotate between modes as needed.
-Overhauled how death is handled. More cleanly prevents unnecessary notifications from activating immediately upon raising (ie Reraise wearing off and Low HP).
-Added Danger sound file. Used by Doom and Low HP.
-Added Advanced Option for the Danger sound to play constantly while in danger or only once (with a 30 second delay to be able to play again).
-Added WSDamage option. Displays your damage (or miss) after a Weapon Skill.
-Added an Oh Shit gear set and accompanying option to use it. HP threshold required to activate is adjustable in the Advanced Options.
-Added Low HP Notification.
-Added AutoHWater option. Automatically attempts to use Holy Waters when you get Doomed until it wears off. Currently will keep trying even if you run out of Holy Waters.
-Added DoomAlert option. Will alert your party when you are doomed. You can also customize the text that displays in party chat.
-Added a Refresh Spell set
-Added Sneak and Invisible status notification.
-Added missing listings in the /fileinfo printout for a few Notifications.
-Added Leafallia to list of towns.
-Added Silver Knife to list of Adoulin/Town areas.
-Added equipping the Kite set when petrified, stunned, or terrored.
-Added the //hidehud and //showhud alias commands.
-Added debug lines for redefining variables.
-Adjusted the SIRD sets to not be needed when Aquaveil is up.
-Adjusted Low MP Notification to trigger in real-time rather than being tied to the Aftercast funtion.
-Adjusted HUD text object loading timing to avoid them occasionally not loading correctly.
-Adjusted the code that tries to wake you when you are asleep to not trigger if you are charmed.
-Adjusted resting to equip Refresh + Rest gear sets regardless of Mode.
-Adjusted the Trade notification to clear once the trade is complete.
-Changed the Cursna set to Holy Water.
-Adjusted the Frenzy Sallet code to first remove Stoneskin if its up, then check that we're not already DOT'd and HP is above 100.
-Adjusted abilities to not equip their gear sets if they are still on cooldown.
-Adjusted what the fastcast set ignores to include all "Ring" items (previously would ignore only Warp and Dimensional Rings specifically, will now also ignore XP/CP rings)
-Moved ModeCtrlPlus and RRReminderTimer from Options to Advanced Options.
-Curing while in combat will now fill in any undefined slots from the Healing set with the Enmity set.
-Renamed Idle set to Movement Speed since it's more accurate.
-Renamed LockstyleField to LockstyleCombat. Just makes more sense.
-Removed the option to turn off the HUDRecast. While I generally think the more options the better, the recasts are a main part of the HUD.
-Removed the Buffs set. Protect and Shell were using this, they now use the Enhancing set instead. (Thanks to Mailani for the catch)
-Removed Gearswaps built-in showswaps function from the files debug mode.
-Fixed incorrect SP Ability timers when wearing gear that augments (adds additional time to) the ability.
-Fixed an issue where the debuff background color change from Doom (flashing white and yellow) would get stuck on yellow after Doom wears off and you have another debuff on that takes over in the debuff spot.
-Code cleanup.
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
--              FILE LOAD                --
-------------------------------------------

RuneElement = DefaultRune
RuneCycleDisplay = false
Rune1 = 'No Rune'
Rune2 = 'No Rune'
Rune3 = 'No Rune'
Rune1Timer = 0
Rune2Timer = 0
Rune3Timer = 0
Rune1BGColor = '0 0 0'
Rune2BGColor = '0 0 0'
Rune3BGColor = '0 0 0'
Mode = StartMode --sets the starting mode (selected in the Options)
NotiLowMPToggle = 'Off' --start with the toggle off for the Low MP Notification so that it can trigger
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
DangerCountdown = 0
NotiCountdown = -1 --we set the countdown below 0 to stop the countdown from hitting 0 and triggering the ClearNotifications command
if player.in_combat == true then
	Combat = true
elseif player.in_combat == false then
	Combat = false
end

--set the initial recasts to 0, they will get updated in the Heartbeat function:
CrusadeRecast = 0
PhalanxRecast = 0
CocoonRecast = 0
DefenderRecast = 0
BattutaRecast = 0
SwordplayRecast = 0
VPulseRecast = 0

--Space out each line and column properly
HUDposYLine2 = HUDposYLine1 - LineSpacer --Note that Line 1 is the bottom line, additional line numbers move upward on the screen
HUDposYLine3 = HUDposYLine2 - LineSpacer
HUDposYLine4 = HUDposYLine3 - LineSpacer
HUDposXColumn1 = HUDposX
HUDposXColumn2 = HUDposXColumn1 + ColumnSpacer
HUDposXColumn3 = HUDposXColumn2 + ColumnSpacer
HUDposXColumn4 = HUDposXColumn3 + ColumnSpacer
HUDposXColumn5 = HUDposXColumn4 + ColumnSpacer
HUDposXColumn6 = HUDposXColumn5 + ColumnSpacer
send_command('wait '..LoadDelay..';gs c LoadHUD')
--Create all the HUD Background text objects and put them above the screen for now, we'll move them to the correct place next
send_command('wait 1.5;text bg1 create "                                                                                                                          ";wait .3;text bg1 size '..FontSize..';text bg1 pos '..HUDposXColumn1..' '..HUDposYLine1..';text bg1 bg_transparency '..HUDBGTrans..'')--Background Line 1
send_command('wait 1.6;text loading create "Loading Keys RUNE FENCER file ver: '..FileVersion..'...";wait .3;text loading size '..FontSize..';text loading pos '..HUDposXColumn1..' '..HUDposYLine1..';text loading bg_transparency 1') --Loading
send_command('wait 1.7;text bg2 create "                                                                                                                          ";wait .3;text bg2 size '..FontSize..';text bg2 pos '..HUDposXColumn1..' -100;text bg2 bg_transparency '..HUDBGTrans..'')--Background Line 2
send_command('wait 1.8;text bg3 create "                                                                                                                          ";wait .3;text bg3 size '..FontSize..';text bg3 pos '..HUDposXColumn1..' -100;text bg3 bg_transparency '..HUDBGTrans..'')--Background Line 3
send_command('wait 1.9;text bg4 create "                                                                                                                          ";wait .3;text bg4 size '..FontSize..';text bg4 pos '..HUDposXColumn1..' -100;text bg4 bg_transparency '..HUDBGTrans..'')--Background Line 4
--Create the Weapons, Mode, Notifications, and Debuffs text objects and put them above the screen for now, we'll move them to the correct place next
send_command('wait 2;text weapons create "« Weapon loading... »";wait .3;text weapons size '..FontSize..';text weapons pos '..HUDposXColumn4..' -100;text weapons color 255 50 50;text weapons bg_transparency 1') --Weapons
if Mode == 'Auto' then
	send_command('wait 2.1;text mode create "Mode: '..Mode..'";wait .3;text mode size '..FontSize..';text mode pos '..HUDposXColumn1..' -100;text mode color '..Autocolor..';text mode bg_transparency 1') --Auto Mode
elseif Mode == 'Combat' then
	send_command('wait 2.1;text mode create "Mode: '..Mode..'";wait .3;text mode size '..FontSize..';text mode pos '..HUDposXColumn1..' -100;text mode color '..Combatcolor..';text mode bg_transparency 1') --Combat Mode
elseif Mode == 'Neutral' then
	send_command('wait 2.1;text mode create "Mode: '..Mode..'";wait .3;text mode size '..FontSize..';text mode pos '..HUDposXColumn1..' -100;text mode color '..Neutralcolor..';text mode bg_transparency 1') --Neutral Mode
end
send_command('wait 2.2;text notifications create "Hello, '..player.name..'! (type //fileinfo for more information)";wait .3;text notifications size '..FontSize..';text notifications pos '..HUDposXColumn1..' -100;text notifications bg_transparency 1') --Notifications
send_command('wait 2.3;text debuffs create " ";wait .3;text debuffs size '..FontSize..';text debuffs pos '..HUDposXColumn4..' -100;text debuffs bg_transparency 1') --Debuffs
send_command('wait 2.4;text rune1 create "'..Rune1..'";wait .3;text rune1 size '..FontSize..';text rune1 pos '..HUDposXColumn1..' -100;text rune1 bg_transparency 1') --Rune 1
send_command('wait 2.5;text rune2 create "'..Rune2..'";wait .3;text rune2 size '..FontSize..';text rune2 pos '..HUDposXColumn3..' -100;text rune2 bg_transparency 1') --Rune 2
send_command('wait 2.6;text rune3 create "'..Rune3..'";wait .3;text rune3 size '..FontSize..';text rune3 pos '..HUDposXColumn5..' -100;text rune3 bg_transparency 1') --Rune 3
--Create all the HUD Recast text objects and put them above the screen for now, we'll move them to the correct place next
send_command('wait 2.7;text crusade create "[ Crusade ]";wait .3;text crusade size '..FontSize..';text crusade pos '..HUDposXColumn1..' -100;text crusade bg_transparency 1')
send_command('wait 2.8;text phalanx create "[ Phalanx ]";wait .3;text phalanx size '..FontSize..';text phalanx pos '..HUDposXColumn1..' -100;text phalanx bg_transparency 1')
send_command('wait 2.9;text cocoon create "[ Cocoon ]";wait .3;text cocoon size '..FontSize..';text cocoon pos '..HUDposXColumn1..' -100;text cocoon bg_transparency 1')
send_command('wait 3.0;text defender create "[ Defender ]";wait .3;text defender size '..FontSize..';text defender pos '..HUDposXColumn1..' -100;text defender bg_transparency 1')
send_command('wait 3.1;text battuta create "[ Battuta ]";wait .3;text battuta size '..FontSize..';text battuta pos '..HUDposXColumn1..' -100;text battuta bg_transparency 1')
send_command('wait 3.2;text swordplay create "[ Swdplay ]";wait .3;text swordplay size '..FontSize..';text swordplay pos '..HUDposXColumn1..' -100;text swordplay bg_transparency 1')
send_command('wait 3.3;text vpulse create "[ V Pulse ]";wait .3;text vpulse size '..FontSize..';text vpulse pos '..HUDposXColumn1..' -100;text vpulse bg_transparency 1')

send_command('alias runecycle gs c RuneCycle')
send_command('alias runestone gs c RuneStone')
send_command('alias runeearth gs c RuneStone')
send_command('alias runewater gs c RuneWater')
send_command('alias runeaero gs c RuneAero')
send_command('alias runewind gs c RuneAero')
send_command('alias runefire gs c RuneFire')
send_command('alias runeblizzard gs c RuneBlizzard')
send_command('alias runeice gs c RuneBlizzard')
send_command('alias runethunder gs c RuneThunder')
send_command('alias runelightning gs c RuneThunder')
send_command('alias runedark gs c RuneDark')
send_command('alias runelight gs c RuneLight')
send_command('alias rune gs c Rune')
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
send_command('alias mode gs c Mode') --creates the Mode alias
send_command('alias hidehud gs c HideHUD') --creates the HideHUD alias
send_command('alias showhud gs c ShowHUD') --creates the ShowHUD alias
send_command('bind ^'..ModeCtrlPlus..' gs c Mode') --creates the gear mode keyboard shortcut
if Debug == 'On' then
	windower.add_to_chat(8,'[Debug Mode: On]')
end

-------------------------------------------
--            SELF COMMANDS              --
-------------------------------------------

function self_command(command)
	if command == 'Mode' then
		if Mode == 'Auto' then
			Mode = 'Combat'
			send_command('text mode color '..Combatcolor..'')
		elseif Mode == 'Combat' then
			Mode = 'Neutral'
			send_command('text mode color '..Neutralcolor..'')
		elseif Mode == 'Neutral' then
			if RemoveAuto == 'No' then
				Mode = 'Auto'
				send_command('text mode color '..Autocolor..'')
			else
				Mode = 'Combat'
				send_command('text mode color '..Combatcolor..'')
			end
		end
		send_command('text mode text "Mode: '..Mode..'"')
		if Debug == 'On' then
			windower.add_to_chat(8,'[Mode set to '..Mode..']')
		end
		choose_set()
	elseif command == 'ClearNotifications' and LoadHUD == true then --these reset the Notifications display back to a basic state
		if buffactive['Sneak'] and buffactive['Invisible'] then
			send_command('text notifications text "Status: Sneak & Invisible";text notifications color 50 205 50;text notifications bg_transparency 1')
		elseif buffactive['Sneak'] then
			send_command('text notifications text "Status: Sneak";text notifications color 50 205 50;text notifications bg_transparency 1')
		elseif buffactive['Invisible'] then
			send_command('text notifications text "Status: Invisible";text notifications color 50 205 50;text notifications bg_transparency 1')
		elseif buffactive['weakness'] then
			send_command('text notifications text "Status: Weak";text notifications color 205 133 63;text notifications bg_transparency 1')
		elseif player.mpp <= 20 then
			send_command('text notifications text "«« Low MP »»";text notifications color 205 133 63;text notifications bg_transparency 1')
		elseif player.status == "Resting" then
			send_command('text notifications text "Status: Resting";text notifications color 255 255 255;text notifications bg_transparency 1')
		elseif player.status == "Engaged" then
			send_command('text notifications text "Status: Engaged";text notifications color 255 255 255;text notifications bg_transparency 1')
		elseif player.status == "Idle" and (Mode == 'Combat' or (Mode == 'Auto' and player.in_combat == true)) then
				send_command('text notifications text "Status: Kiting";text notifications color 255 255 255;text notifications bg_transparency 1')
		elseif player.status == "Idle" then
			send_command('text notifications text "Status: Idle";text notifications color 255 255 255;text notifications bg_transparency 1')
		end
		RuneCycleDisplay = false --just cleared the notifications, therefore not displaying the RuneCycle notification
	elseif command == 'ClearDebuffs' and LoadHUD == true then --these reset the Debuffs display back to a basic state
		send_command('text debuffs text "";text debuffs color 255 255 255;text debuffs bg_transparency 1')
	elseif command == 'LoadHUD' then
		LoadHUD = true
		send_command('text loading hide')
		send_command('wait .1;text bg2 pos '..HUDposXColumn1..' '..HUDposYLine2..'')
		send_command('wait .2;text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')
		send_command('wait .3;text bg4 pos '..HUDposXColumn1..' '..HUDposYLine4..'')
		send_command('wait .8;text crusade pos '..HUDposXColumn1..' '..HUDposYLine1..'')		--Crusade goes in Column 1
		send_command('wait .8;text phalanx pos '..HUDposXColumn2..' '..HUDposYLine1..'')		--Phalanx goes in Column 2
		if player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
			send_command('wait .8;text defender pos '..HUDposXColumn3..' '..HUDposYLine1..'')	--Defender goes in Column 3
			send_command('wait .8;text battuta pos '..HUDposXColumn4..' '..HUDposYLine1..'')	--Battuta goes in Column 4
			send_command('wait .8;text swordplay pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Swordlplay goes in Column 5
			send_command('wait .8;text vpulse pos '..HUDposXColumn6..' '..HUDposYLine1..'')		--Vivacious Pulse goes in Column 6
		elseif player.sub_job == 'BLU' and player.sub_job_level ~= 0 then
			send_command('wait .8;text cocoon pos '..HUDposXColumn3..' '..HUDposYLine1..'')		--Cocoon goes in Column 3
			send_command('wait .8;text battuta pos '..HUDposXColumn4..' '..HUDposYLine1..'')	--Battuta goes in Column 4
			send_command('wait .8;text swordplay pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Swordlplay goes in Column 5
			send_command('wait .8;text vpulse pos '..HUDposXColumn6..' '..HUDposYLine1..'')		--Vivacious Pulse goes in Column 6
		else
			send_command('wait .8;text battuta pos '..HUDposXColumn3..' '..HUDposYLine1..'')	--Battuta goes in Column 3
			send_command('wait .8;text swordplay pos '..HUDposXColumn4..' '..HUDposYLine1..'')	--Swordlplay goes in Column 4
			send_command('wait .8;text vpulse pos '..HUDposXColumn5..' '..HUDposYLine1..'')		--Vivacious Pulse goes in Column 5
		end
		send_command('wait .9;text rune1 pos '..HUDposXColumn1..' '..HUDposYLine2..'')
		send_command('wait .9;text rune2 pos '..HUDposXColumn3..' '..HUDposYLine2..'')
		send_command('wait .9;text rune3 pos '..HUDposXColumn5..' '..HUDposYLine2..'')
		send_command('wait 1.0;text mode pos '..HUDposXColumn1..' '..HUDposYLine3..'')
		if NotiWeapons == 'On' then
			send_command('wait 1.0;text weapons pos '..HUDposXColumn4..' '..HUDposYLine3..'')
		end
		send_command('wait 1.1;text notifications pos '..HUDposXColumn1..' '..HUDposYLine4..'')
		send_command('wait 1.1;text debuffs pos '..HUDposXColumn4..' '..HUDposYLine4..'')
	elseif command == 'Fileinfo' then
		windower.add_to_chat(3,'-------------------------------------------')
		windower.add_to_chat(3,'-- Keys Gearswap lua file for Rune Fencer --')
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
		windower.add_to_chat(200,'        /addons/GearSwap/data/RUN.lua')
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
		windower.add_to_chat(8,'To use /BLU AOE spells, use a macro for Sheep Song and it will')
		windower.add_to_chat(8,'cycle through Sheep Song, Geist Wall, Stinking Gas, and Soporific,')
		windower.add_to_chat(8,'in that order, as recasts timers allow.')
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,'To use /BLU Single target spells, use a macro for Flash and it will')
		windower.add_to_chat(8,'cycle through Flash, Jettatura, and Blank Gaze, in that order, as recast')
		windower.add_to_chat(8,'timers and distance allow (or if you are /WAR it will also Provoke).')
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
		windower.add_to_chat(8,'and ColumnSpacer options as needed.')
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
		windower.add_to_chat(200,'SfoTimer: '..(''..SfoTimer..''):color(8)..'')
		windower.add_to_chat(200,'OdyTimer: '..(''..OdyTimer..''):color(8)..'')
		windower.add_to_chat(200,'ZoneGear: '..(''..ZoneGear..''):color(8)..'')
		windower.add_to_chat(200,'AlertSounds: '..(''..AlertSounds..''):color(8)..'')
		windower.add_to_chat(200,'UseEcho: '..(''..UseEcho..''):color(8)..'')
		windower.add_to_chat(200,'AutoHWater: '..(''..AutoHWater..''):color(8)..'')
		windower.add_to_chat(200,'DoomAlert: '..(''..DoomAlert..''):color(8)..'')
		windower.add_to_chat(200,'DoomOnText: '..(''..DoomOnText..''):color(8)..'')
		windower.add_to_chat(200,'DoomOffText: '..(''..DoomOffText..''):color(8)..'')
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
		windower.add_to_chat(200,'NotiWSDamage: '..(''..NotiWSDamage..''):color(8)..'')
		windower.add_to_chat(200,'ReraiseReminder: '..(''..ReraiseReminder..''):color(8)..'')
		windower.add_to_chat(200,'NotiTime: '..(''..NotiTime..''):color(8)..'')
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
		windower.add_to_chat(200,'RemoveAuto: '..(''..RemoveAuto..''):color(8)..'')
		windower.add_to_chat(200,'ModeCtrlPlus: '..(''..ModeCtrlPlus..''):color(8)..'')
		windower.add_to_chat(200,'LowHPThreshold: '..(''..LowHPThreshold..''):color(8)..'')
		windower.add_to_chat(200,'RRReminderTimer: '..(''..RRReminderTimer..''):color(8)..'')
		windower.add_to_chat(200,'HUDBGTrans: '..(''..HUDBGTrans..''):color(8)..'')
		windower.add_to_chat(200,'Debug: '..(''..Debug..''):color(8)..'')
		windower.add_to_chat(200,'Autocolor: '..(''..Autocolor..''):color(8)..'')
		windower.add_to_chat(200,'Combatcolor: '..(''..Combatcolor..''):color(8)..'')
		windower.add_to_chat(200,'Neutralcolor: '..(''..Neutralcolor..''):color(8)..'')
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
	elseif command == 'RuneCycle' then
		if RuneCycleDisplay == false then --if we are not already displaying the RuneCycle notification (picking an element) then we display what element is already selected first
			RuneCycleDisplay = true --we are now displaying the RuneCycle notification to select an element
			if RuneElement == 'Tenebrae' then --Dark
				send_command('text notifications text "«« Tenebrae: Dark > Light »»";text notifications color 255 255 255;text notifications bg_color 200 30 80;text notifications bg_transparency 150')
			elseif RuneElement == 'Ignis' then --Fire
				send_command('text notifications text "«« Ignis: Fire > Ice »»";text notifications color 255 255 255;text notifications bg_color 255 0 0;text notifications bg_transparency 150')
			elseif RuneElement == 'Gelus' then --Ice
				send_command('text notifications text "«« Gelus: Ice > Wind »»";text notifications color 255 255 255;text notifications bg_color 135 206 250;text notifications bg_transparency 150')
			elseif RuneElement == 'Flabra' then --Wind
				send_command('text notifications text "«« Flabra: Wind > Earth »»";text notifications color 255 255 255;text notifications bg_color 50 205 50;text notifications bg_transparency 150')
			elseif RuneElement == 'Tellus' then --Earth
				send_command('text notifications text "«« Tellus: Earth > Lghtn. »»";text notifications color 255 255 255;text notifications bg_color 250 130 40;text notifications bg_transparency 150')
			elseif RuneElement == 'Sulpor' then --Lightning
				send_command('text notifications text "«« Sulpor: Lghtn. > Water »»";text notifications color 255 255 255;text notifications bg_color 186 85 211;text notifications bg_transparency 150')
			elseif RuneElement == 'Unda' then --Water
				send_command('text notifications text "«« Unda: Water > Fire »»";text notifications color 255 255 255;text notifications bg_color 30 144 255;text notifications bg_transparency 150')
			elseif RuneElement == 'Lux' then --Light
				send_command('text notifications text "«« Lux: Light > Dark »»";text notifications color 255 255 255;text notifications bg_color 180 180 160;text notifications bg_transparency 150')
			end
		else --now we are already displaying the RuneCycle notification so we cycle through the different elements
			if RuneElement == 'Tenebrae' then --Dark
				RuneElement = 'Ignis' --cycle to Fire
				send_command('text notifications text "«« Ignis: Fire > Ice »»";text notifications color 255 255 255;text notifications bg_color 255 0 0;text notifications bg_transparency 150')
			elseif RuneElement == 'Ignis' then --Fire
				RuneElement = 'Gelus' --cycle to Ice
				send_command('text notifications text "«« Gelus: Ice > Wind »»";text notifications color 255 255 255;text notifications bg_color 135 206 250;text notifications bg_transparency 150')
			elseif RuneElement == 'Gelus' then --Ice
				RuneElement = 'Flabra' --cycle to Wind
				send_command('text notifications text "«« Flabra: Wind > Earth »»";text notifications color 255 255 255;text notifications bg_color 50 205 50;text notifications bg_transparency 150')
			elseif RuneElement == 'Flabra' then --Wind
				RuneElement = 'Tellus' --cycle to Earth
				send_command('text notifications text "«« Tellus: Earth > Lghtn. »»";text notifications color 255 255 255;text notifications bg_color 250 130 40;text notifications bg_transparency 150')
			elseif RuneElement == 'Tellus' then --Earth
				RuneElement = 'Sulpor' --cycle to Lightning
				send_command('text notifications text "«« Sulpor: Lghtn. > Water »»";text notifications color 255 255 255;text notifications bg_color 186 85 211;text notifications bg_transparency 150')
			elseif RuneElement == 'Sulpor' then --Lightning
				RuneElement = 'Unda' --cycle to Water
				send_command('text notifications text "«« Unda: Water > Fire »»";text notifications color 255 255 255;text notifications bg_color 30 144 255;text notifications bg_transparency 150')
			elseif RuneElement == 'Unda' then --Water
				RuneElement = 'Lux' --cycle to Light
				send_command('text notifications text "«« Lux: Light > Dark »»";text notifications color 255 255 255;text notifications bg_color 180 180 160;text notifications bg_transparency 150')
			elseif RuneElement == 'Lux' then --Light
				RuneElement = 'Tenebrae' --cycle to Dark
				send_command('text notifications text "«« Tenebrae: Dark > Light »»";text notifications color 255 255 255;text notifications bg_color 200 30 80;text notifications bg_transparency 150')
			end
		end
		NotiCountdown = NotiDelay
		if Debug == 'On' then
			windower.add_to_chat(8,'[RuneElement set to '..RuneElement..' | NotiCountdown set to '..NotiDelay..']')
		end
	elseif command == 'RuneFire' then
		RuneElement = 'Ignis' --Fire
		if Debug == 'On' then
			windower.add_to_chat(8,'[RuneElement set to Ignis]')
		end
		send_command('text notifications text "«« Ignis: Fire > Ice »»";text notifications color 255 255 255;text notifications bg_color 255 0 0;text notifications bg_transparency 150')
		NotiCountdown = NotiDelay
		if Debug == 'On' then
			windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
		end
	elseif command == 'RuneBlizzard' or command =='RuneIce' then
		RuneElement = 'Gelus' --Ice
		if Debug == 'On' then
			windower.add_to_chat(8,'[RuneElement set to Gelus]')
		end
		send_command('text notifications text "«« Gelus: Ice > Wind »»";text notifications color 255 255 255;text notifications bg_color 135 206 250;text notifications bg_transparency 150')
		NotiCountdown = NotiDelay
		if Debug == 'On' then
			windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
		end
	elseif command == 'RuneAero' or command =='RuneWind' then
		RuneElement = 'Flabra' --Wind
		if Debug == 'On' then
			windower.add_to_chat(8,'[RuneElement set to Flabra]')
		end
		send_command('text notifications text "«« Flabra: Wind > Earth »»";text notifications color 255 255 255;text notifications bg_color 50 205 50;text notifications bg_transparency 150')
		NotiCountdown = NotiDelay
		if Debug == 'On' then
			windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
		end
	elseif command == 'RuneStone' or command =='RuneEarth' then
		RuneElement = 'Tellus' --Earth
		if Debug == 'On' then
			windower.add_to_chat(8,'[RuneElement set to Tellus]')
		end
		send_command('text notifications text "«« Tellus: Earth > Lghtn. »»";text notifications color 255 255 255;text notifications bg_color 210 105 30;text notifications bg_transparency 150')
		NotiCountdown = NotiDelay
		if Debug == 'On' then
			windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
		end
	elseif command == 'RuneThunder' or command =='RuneLightning' then
		RuneElement = 'Sulpor' --Lightning
		if Debug == 'On' then
			windower.add_to_chat(8,'[RuneElement set to Sulpor]')
		end
		send_command('text notifications text "«« Sulpor: Lghtn. > Water »»";text notifications color 255 255 255;text notifications bg_color 150 60 170;text notifications bg_transparency 150')
		NotiCountdown = NotiDelay
		if Debug == 'On' then
			windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
		end
	elseif command == 'RuneWater' then
		RuneElement = 'Unda' --Water
		if Debug == 'On' then
			windower.add_to_chat(8,'[RuneElement set to Unda]')
		end
		send_command('text notifications text "«« Unda: Water > Fire »»";text notifications color 255 255 255;text notifications bg_color 30 144 255;text notifications bg_transparency 150')
	elseif command == 'RuneLight' then
		RuneElement = 'Lux' --Light
		if Debug == 'On' then
			windower.add_to_chat(8,'[RuneElement set to Lux]')
		end
		send_command('text notifications text "«« Lux: Light > Dark »»";text notifications color 255 255 255;text notifications bg_color 180 180 160;text notifications bg_transparency 150')
		NotiCountdown = NotiDelay
		if Debug == 'On' then
			windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
		end
	elseif command == 'RuneDark' then
		RuneElement = 'Tenebrae' --Dark
		if Debug == 'On' then
			windower.add_to_chat(8,'[RuneElement set to Tenebrae]')
		end
		send_command('text notifications text "«« Tenebrae: Dark > Light »»";text notifications color 255 255 255;text notifications bg_color 80 20 40;text notifications bg_transparency 150')
		NotiCountdown = NotiDelay
		if Debug == 'On' then
			windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
		end
	elseif command == 'Rune' then
		send_command('input /ja '..RuneElement..' <me>')
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
		send_command('text bg1 hide;text bg2 hide;text bg3 hide;text bg4 hide;text rune1 hide;text rune2 hide;text rune3 hide;text crusade hide;text phalanx hide;text vpulse hide;text cocoon hide;text defender hide;text battuta hide;text swordplay hide;text mode hide;text notifications hide;text debuffs hide;text weapons hide')
	elseif command == 'ShowHUD' then
		ShowHUD = true
		if Debug == 'On' then
			windower.add_to_chat(8,'[ShowHUD set to True]')
		end
		send_command('text bg1 show;text bg2 show;text bg3 show;text bg4 show;text rune1 show;text rune2 show;text rune3 show;text crusade show;text phalanx show;text vpulse show;text cocoon show;text defender show;text battuta show;text swordplay show;text mode show;text notifications show;text debuffs show;text weapons show')
	end
end

-------------------------------------------
--              CHOOSE SET               --
-------------------------------------------

function choose_set()
	if player.status == "Resting" then
		if buffactive['weakness'] then
			send_command('text notifications text "Status: Weak";text notifications color 205 133 63;text notifications bg_transparency 1')
		elseif player.mpp <= 20 then
			send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50;text notifications bg_transparency 1')
		else
			send_command('text notifications text "Status: Resting";text notifications color 255 255 255;text notifications bg_transparency 1')
		end
		equip(set_combine(sets.refresh, sets.rest)) --No matter what Mode we're in, if we're resting its because we need MP so we equip the Refresh set along with the Rest set
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Refresh + Rest]')
		end
	elseif player.status == "Engaged" then
		if LoadHUD == true then
			if buffactive['weakness'] then
				send_command('text notifications text "Status: Weak";text notifications color 205 133 63;text notifications bg_transparency 1')
			elseif player.mpp <= 20 then
				send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50;text notifications bg_transparency 1')
			else
				send_command('text notifications text "Status: Engaged";text notifications color 255 255 255;text notifications bg_transparency 1')
			end
		end
		if LowHP == true then --no matter what Mode we're in, if we have low HP we equip the Oh Shit gear set
			equip(sets.ohshit)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Oh Shit]')
			end
		elseif Mode == 'Auto' then -- if we're engaged we automatically get put into combat so we equip the tank set
			equip(sets.tank)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Tank]')
			end
		elseif Mode == 'Neutral' then
			equip(sets.refresh)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Refresh]')
			end
		elseif Mode == 'Combat' then
			equip(sets.tank)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Tank]')
			end
		end
	elseif  player.status == "Idle" then 
		if LoadHUD == true then
			if buffactive['Sneak'] and buffactive['Invisible'] then
				send_command('text notifications text "Status: Sneak & Invisible";text notifications color 50 205 50;text notifications bg_transparency 1')
			elseif buffactive['Sneak'] then
				send_command('text notifications text "Status: Sneak";text notifications color 50 205 50;text notifications bg_transparency 1')
			elseif buffactive['Invisible'] then
				send_command('text notifications text "Status: Invisible";text notifications color 50 205 50;text notifications bg_transparency 1')
			elseif buffactive['weakness'] then
				send_command('text notifications text "Status: Weak";text notifications color 205 133 63;text notifications bg_transparency 1')
			elseif player.mpp <= 20 then
				send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50;text notifications bg_transparency 1')
			elseif Mode == 'Combat' or (Mode == 'Auto' and player.in_combat == true) then
				send_command('text notifications text "Status: Kiting";text notifications color 255 255 255;text notifications bg_transparency 1')
			else
				send_command('text notifications text "Status: Idle";text notifications color 255 255 255;text notifications bg_transparency 1')
			end
		end
		if AdoulinZones:contains(world.area) then
			equip(set_combine(sets.movementspeed, sets.adoulin))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Movement Speed + Adoulin]')
			end
		elseif BastokZones:contains(world.area) then
			equip(set_combine(sets.movementspeed, sets.bastok))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Movement Speed + Bastok]')
			end
		elseif SandyZones:contains(world.area) then
			equip(set_combine(sets.movementspeed, sets.sandoria))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Movement Speed + San d\'Oria]')
			end
		elseif WindyZones:contains(world.area) then
			equip(set_combine(sets.movementspeed, sets.windurst))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Movement Speed + Windurst]')
			end
		elseif TownZones:contains(world.area) then
			equip(set_combine(sets.movementspeed, sets.town))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Movement Speed + Town]')
			end
		else
			if LowHP == true then --no matter what Mode we're in, if we have low HP we equip the Oh Shit gear set (plus movement speed to <{Run away!}>)
				equip(set_combine(sets.ohshit, sets.movementspeed))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Oh Shit + Movement Speed]')
				end
			elseif (Mode == 'Auto' and player.in_combat == true) or Mode == 'Combat' then -- if we're idle but ARE in combat (ex: kiting, mob is aggressive) we equip the tank/idle sets
				equip(set_combine(sets.tank, sets.movementspeed))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Tank + Movement Speed]')
				end
			elseif (Mode == 'Auto' and player.in_combat == false) or Mode == 'Neutral' then --if we're idle and NOT in combat (ex: buffing up before a fight, mob is not aggressive yet) we equip the refresh/idle sets
				equip(set_combine(sets.refresh, sets.movementspeed))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Refresh + Movement Speed]')
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
		if UseEcho == 'E' then
			send_command('input /item "Echo Drop" <me>')
		elseif UseEcho == 'R' then
			send_command('input /item "Remedy" <me>')
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
					windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
				end
			else
				windower.add_to_chat(8,'<< Not Enough TP >>')
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
					windower.add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
				end
			else
				windower.add_to_chat(8,'<< Too Far >>')
			end
			cancel_spell()
			return
		end
		if spell.english == 'Dimidiation' then
			equip(sets.dim)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Dimidiation + Weapon Skill]')
			end
		elseif spell.english == 'Resolution' then
			equip(sets.res)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Resolution + Weapon Skill]')
			end
		else
			equip(sets.ws)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Weapon Skill]')
			end
		end
	elseif spell.english == 'Elemental Sforzo' then
		equip(sets.sforzo)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Elemental Sforzo]')
		end
	elseif spell.english == 'Valiance' and windower.ffxi.get_ability_recasts()[113] <= 1 then
		equip(sets.valiance)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Valiance/Vallation + Enmity]')
		end
	elseif spell.english == 'Vallation' and windower.ffxi.get_ability_recasts()[23] <= 1 then
		equip(sets.valiance)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Valiance/Vallation + Enmity]')
		end
	elseif spell.english == 'Ignis' or spell.english == 'Gelus' or spell.english == 'Flabra' or spell.english == 'Tellus' or spell.english == 'Sulpor' or spell.english == 'Unda' or spell.english == 'Lux' or spell.english == 'Tenebrae' then
		equip(sets.enmity)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Enmity]')
		end
	elseif spell.english == 'Swordplay' and windower.ffxi.get_ability_recasts()[24] <= 1 then
		equip(sets.swordplay)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Swordplay + Enmity]')
		end
	elseif spell.english == 'Swipe' and windower.ffxi.get_ability_recasts()[25] <= 1 then
		equip(sets.swipe)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Swipe + Enmity]')
		end
	elseif spell.english == 'Lunge' and windower.ffxi.get_ability_recasts()[24] <= 1 then
		equip(sets.swipe)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Swipe + Enmity]')
		end
	elseif spell.english == 'Embolden' and windower.ffxi.get_ability_recasts()[72] <= 1 then
		equip(sets.embolden)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Embolden + Enmity]')
		end
	elseif spell.english == 'Vivacious Pulse' and windower.ffxi.get_ability_recasts()[242] <= 1 then
		equip(sets.pulse)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Vivacious Pulse + Enmity]')
		end
	elseif spell.english == 'Gambit' and windower.ffxi.get_ability_recasts()[116] <= 1 then
		equip(sets.gambit)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Gambit + Enmity]')
		end
	elseif spell.english == 'Battuta' and windower.ffxi.get_ability_recasts()[120] <= 1 then
		equip(sets.battuta)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Battuta + Enmity]')
		end
	elseif spell.english == 'Rayke' and windower.ffxi.get_ability_recasts()[119] <= 1 then
		equip(sets.rayke)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Rayke + Enmity]')
		end
	elseif spell.english == 'Liement' and windower.ffxi.get_ability_recasts()[117] <= 1 then
		equip(sets.liement)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Liement + Enmity]')
		end
	elseif spell.english == 'One For All' and windower.ffxi.get_ability_recasts()[118] <= 1 then
		equip(sets.one4all)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: One For All + Enmity]')
		end
	elseif spell.english == 'Holy Water' then
		equip(sets.hwater)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Holy Water]')
		end
	elseif (spell.english == 'Spectral Jig' or spell.english == 'Sneak' or spell.english == 'Monomi: Ichi' or spell.english == 'Monomi: Ni') and buffactive['Sneak'] and spell.target.type == 'SELF' then
		send_command('cancel 71')
	elseif spell.english == "Flash" then
		if windower.ffxi.get_spell_recasts()[112] <= 1 then
			equip(sets.fastcast)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Fast Cast]')
			end
		elseif player.sub_job == 'BLU' and player.sub_job_level ~= 0 then
			if windower.ffxi.get_spell_recasts()[575] <= 1 and spell.target.distance <= 9 then
				send_command('input /ma "Jettatura" '..spell.target.raw..'')
				cancel_spell()
				return
			elseif windower.ffxi.get_spell_recasts()[592] <= 1 and spell.target.distance <= 14 then
				send_command('input /ma "Blank Gaze" '..spell.target.raw..'')
				cancel_spell()
				return
			end
		elseif player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
			if windower.ffxi.get_ability_recasts()[5] <= 1 and spell.target.distance <= 17.8 then
				send_command('input /ja "Provoke" '..spell.target.raw..'')
				cancel_spell()
				return
			end
		elseif player.sub_job == 'DRK' and player.sub_job_level ~= 0 then
			if windower.ffxi.get_spell_recasts()[252] <= 1 then
				send_command('input /ma "Stun" '..spell.target.raw..'')
				cancel_spell()
				return
			end
		end
	elseif spell.english == "Sheep Song" then
		if windower.ffxi.get_spell_recasts()[584] <= 1 then
			equip(sets.fastcast)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Fast Cast]')
			end
		elseif windower.ffxi.get_spell_recasts()[605] <= 1 then
			send_command('input /ma "Geist Wall" '..spell.target.raw..'')
			cancel_spell()
			return
		elseif windower.ffxi.get_spell_recasts()[537] <= 1 then
			send_command('input /ma "Stinking Gas" '..spell.target.raw..'')
			cancel_spell()
			return
		elseif windower.ffxi.get_spell_recasts()[598] <= 1 then
			send_command('input /ma "Soporific" '..spell.target.raw..'')
			cancel_spell()
			return
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
	if string.find(spell.english,'Cur') and spell.type == "WhiteMagic" then
		if Mode == 'Auto' then
			if (player.in_combat == false or buffactive['Aquaveil']) then --not in combat, or combat with Aquaveil up, no need for SIRD
				equip(sets.healing)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Healing]')
				end
			else -- in combat, so we need SIRD
				equip(set_combine(sets.enmity, sets.healing, sets.sird))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Enmity + Healing + SIRD]')
				end
			end
		elseif Mode == 'Combat' and not buffactive['Aquaveil'] then
			equip(set_combine(sets.enmity, sets.healing, sets.sird))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Enmity + Healing + SIRD]')
			end
		else
			equip(sets.healing)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Healing]')
			end		
		end
	elseif spell.english == 'Foil' or spell.english == 'Flash' or spell.english == 'Holy' or string.find(spell.english,'Banish') or spell.type == "BlueMagic" or string.find(spell.english,'Poison') then
		if Mode == 'Auto' then
			if (player.in_combat == false or buffactive['Aquaveil']) then --not in combat, or combat with Aquaveil up, no need for SIRD
				equip(sets.enmityspells)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Enmity Spells]')
				end
			else -- in combat, so we need SIRD
				equip(set_combine(sets.enmityspells, sets.sird))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Enmity Spells + SIRD]')
				end
			end
		elseif Mode == 'Combat' and not buffactive['Aquaveil'] then
			equip(set_combine(sets.enmityspells, sets.sird))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Enmity Spells + SIRD]')
			end	
		else
			equip(sets.enmityspells)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Enmity Spells]')
			end
		end
	elseif string.find(spell.english,'Regen') then
		if Mode == 'Auto' then
			if (player.in_combat == false or buffactive['Aquaveil']) then --not in combat, or combat with Aquaveil up, no need for SIRD
				equip(sets.regen)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Regen]')
				end
			else -- in combat, so we need SIRD
				equip(set_combine(sets.regen, sets.sird))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Regen + SIRD]')
				end
			end
		elseif Mode == 'Combat' and not buffactive['Aquaveil'] then
			equip(set_combine(sets.regen, sets.sird))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Regen + SIRD]')
			end
		elseif Mode == 'Neutral' then
			equip(sets.regen)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Regen]')
			end
		end
	elseif spell.english == 'Refresh' then
		if Mode == 'Auto' then
			if (player.in_combat == false or buffactive['Aquaveil']) then --not in combat, or combat with Aquaveil up, no need for SIRD
				equip(sets.refreshspell)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Refresh Spell]')
				end
			else -- in combat, so we need SIRD
				equip(set_combine(sets.refreshspell, sets.sird))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Refresh Spell + SIRD]')
				end
			end
		elseif Mode == 'Combat' and not buffactive['Aquaveil'] then
			equip(set_combine(sets.refreshspell, sets.sird))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Refresh Spell + SIRD]')
			end
		else
			equip(sets.refreshspell)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Refresh Spell]')
			end
		end
	elseif spell.english == 'Phalanx' then
		if Mode == 'Auto' then
			if (player.in_combat == false or buffactive['Aquaveil']) then --not in combat, or combat with Aquaveil up, no need for SIRD
				equip(sets.phalanx)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Phalanx]')
				end
			else -- in combat, so we need SIRD
				equip(set_combine(sets.phalanx, sets.sird))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Phalanx + SIRD]')
				end
			end
		elseif Mode == 'Combat' and not buffactive['Aquaveil'] then
			equip(set_combine(sets.phalanx, sets.sird))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Phalanx + SIRD]')
			end
		else
			equip(sets.phalanx)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Phalanx]')
			end
		end
	elseif spell.skill == "Enhancing Magic" then
		if Mode == 'Auto' then
			if (player.in_combat == false or buffactive['Aquaveil']) then --not in combat, or combat with Aquaveil up, no need for SIRD
				equip(sets.enhancing)
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Enhancing Magic]')
				end
			else -- in combat, so we need SIRD
				equip(set_combine(sets.enhancing, sets.sird))
				if Debug == 'On' then
					windower.add_to_chat(8,'[Equipped Set: Enhancing + SIRD]')
				end
			end
		elseif Mode == 'Combat' and not buffactive['Aquaveil'] then
			equip(set_combine(sets.enhancing, sets.sird))
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Enhancing + SIRD]')
			end
		else
			equip(sets.enhancing)
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Set: Enhancing Magic]')
			end
		end
	elseif spell.type == 'Trust' then
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
	if (spell.english == 'Ignis' or spell.english == 'Gelus' or spell.english == 'Flabra' or spell.english == 'Tellus' or spell.english == 'Sulpor' or spell.english == 'Unda' or spell.english == 'Lux' or spell.english == 'Tenebrae') and not spell.interrupted then
		Rune3 = Rune2
		Rune2 = Rune1
		Rune3Timer = Rune2Timer
		Rune2Timer = Rune1Timer
		Rune1Timer = 300
		Rune3BGColor = Rune2BGColor
		Rune2BGColor = Rune1BGColor
		if spell.english == 'Ignis'	then
			Rune1 = 'Ignis: Fire > Ice'
			Rune1BGColor = '255 0 0'
		elseif spell.english == 'Gelus' then
			Rune1 = 'Gelus: Ice > Wind'
			Rune1BGColor = '135 206 250'
		elseif spell.english == 'Flabra' then
			Rune1 = 'Flabra: Wind > Earth'
			Rune1BGColor = '50 205 50'
		elseif spell.english == 'Tellus' then
			Rune1 = 'Tellus: Earth > Lghtn.'
			Rune1BGColor = '2500 130 40'
		elseif spell.english == 'Sulpor' then
			Rune1 = 'Sulpor: Lghtn. > Water'
			Rune1BGColor = '186 85 211'
		elseif  spell.english == 'Unda' then
			Rune1 = 'Unda: Water > Fire'
			Rune1BGColor = '30 144 255'
		elseif spell.english == 'Lux' then
			Rune1 = 'Lux: Light > Dark'
			Rune1BGColor = '180 180 160'
		elseif spell.english == 'Tenebrae' then
			Rune1 = 'Tenebrae: Dark > Light'
			Rune1BGColor = '200 30 80'
		end
		if Debug == 'On' then
			windower.add_to_chat(8,'[Rune1 set to '..Rune1..' | Rune2 set to '..Rune2..' | Rune3 set to '..Rune3..']')
			windower.add_to_chat(8,'[Rune1Timer set to '..Rune1Timer..' | Rune2Timer set to '..Rune2Timer..' | Rune3Timer set to '..Rune3Timer..']')
		end
	elseif spell.english == 'Swipe' and player.status == "Engaged" and not spell.interrupted then
		Rune1 = Rune2
		Rune2 = Rune3
		Rune3 = 'No Rune'
		Rune1Timer = Rune2Timer
		Rune2Timer = Rune3Timer
		Rune3Timer = 0
		Rune1BGColor = Rune2BGColor
		Rune2BGColor = Rune3BGColor
		if Debug == 'On' then
			windower.add_to_chat(8,'[Rune1 set to '..Rune1..' | Rune2 set to '..Rune2..' | Rune3 set to '..Rune3..']')
			windower.add_to_chat(8,'[Rune1Timer set to '..Rune1Timer..' | Rune2Timer set to '..Rune2Timer..' | Rune3Timer set to '..Rune3Timer..']')
		end
	elseif spell.english == 'Rayke' or spell.english == 'Gambit' or spell.english == 'Lunge' and player.status == "Engaged" and not spell.interrupted then
		Rune1Timer = 0
		Rune2Timer = 0
		Rune3Timer = 0
		if Debug == 'On' then
			windower.add_to_chat(8,'[Rune1Timer set to '..Rune1Timer..' | Rune2Timer set to '..Rune2Timer..' | Rune3Timer set to '..Rune3Timer..']')
		end
	elseif spell.english == 'Elemental Sforzo' and SfoTimer == 'On' and not spell.interrupted then
		if player.equipment.body == 'Futhark Coat' or player.equipment.body == 'Futhark Coat +1' or player.equipment.body == 'Futhark Coat +2' or player.equipment.hands == 'Futhark Coat +3' then --these pieces extend Elemental Sforzo by 10 seconds so we adjust accordingly
			send_command('input /echo [Elemental Sforzo] 40 seconds;wait 10;input /echo [Elemental Sforzo] 30 seconds;wait 10;input /echo [Elemental Sforzo] 20 seconds;wait 10;input /echo [Elemental Sforzo] 10 seconds')
		else
			send_command('input /echo [Elemental Sforzo] 30 seconds;wait 10;input /echo [Elemental Sforzo] 20 seconds;wait 10;input /echo [Elemental Sforzo] 10 seconds')
		end
	elseif spell.english == 'Odyllic Subterfuge' and OdyTimer == 'On' and not spell.interrupted then
		send_command('input /echo [Odyllic Subterfuge] 30 seconds;wait 10;input /echo [Odyllic Subterfuge] 20 seconds;wait 10;input /echo [Odyllic Subterfuge] 10 seconds')
	end
	choose_set()
	RuneCycleDisplay = false --since we've done another action, we can assume we're done using the RuneCycle notification
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
    if status == 4 and ShowHUD == true then --In a cutscene: Hide the HUD
		ShowHUD = false
		if Debug == 'On' then
			windower.add_to_chat(8,'[ShowHUD set to False]')
		end
		send_command('text bg1 hide;text bg2 hide;text bg3 hide;text bg4 hide;text rune1 hide;text rune2 hide;text rune3 hide;text crusade hide;text phalanx hide;text vpulse hide;text cocoon hide;text defender hide;text battuta hide;text swordplay hide;text mode hide;text notifications hide;text debuffs hide;text weapons hide')
    elseif status ~= 4  and ShowHUD == false then --Out of cutscene: Show the HUD
		ShowHUD = true
		if Debug == 'On' then
			windower.add_to_chat(8,'[ShowHUD set to True]')
		end
		send_command('text bg1 show;text bg2 show;text bg3 show;text bg4 show;text rune1 show;text rune2 show;text rune3 show;text crusade show;text phalanx show;text vpulse show;text cocoon show;text defender show;text battuta show;text swordplay show;text mode show;text notifications show;text debuffs show;text weapons show')
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
			equip({head="Frenzy Sallet"}) --equip the Frenzy Sallet to wake us up
			if Debug == 'On' then
				windower.add_to_chat(8,'[Equipped Item: Frenzy Sallet]')
			end
		end
	elseif buff == 7 or Buff == 10 or buff == 28 then --If we get petrified, stunned, or terrored, then equip the Kite set
		equip(sets.kite)
		if Debug == 'On' then
			windower.add_to_chat(8,'[Equipped Set: Kite]')
		end
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
	elseif buff == 2 or buff == 19 then --lose sleep, run choose_set since we may have equipped the Frenzy Sallet
		choose_set()
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

	--Aftermath/Weapons checks
	if LoadHUD == true and NotiWeapons == 'On' then
		if player.equipment.main == 'Epeolatry' then
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
		elseif player.equipment.main == 'Lionheart' then
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

	--Auto Mode Combat check
	if Mode == 'Auto' then
		if player.in_combat == true then
			if Combat == false then
				Combat = true
				if Debug == 'On' then
					windower.add_to_chat(8,'[Combat set to True]')
				end
				choose_set()
				if LoadHUD == true then
					send_command('text mode text "Mode: Auto (Combat)";text mode color '..Autocolor..'')
				end
			end
		elseif player.in_combat == false then
			if Combat == true then
				Combat = false
				if Debug == 'On' then
					windower.add_to_chat(8,'[Combat set to False]')
				end
				choose_set()
				if LoadHUD == true then
					send_command('text mode text "Mode: Auto (Neutral)";text mode color '..Autocolor..'')
				end
			end
		end
	end

	--MP checks
	if NotiLowMP =='On' and player.mpp <= 20 and NotiLowMPToggle == 'Off' then
		NotiLowMPToggle = 'On' --turn the toggle on so this can't be triggered again until its toggled off (done below)
		if Debug == 'On' then
			windower.add_to_chat(8,'[NotiLowMPToggle set to On]')
		end
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
			Rune1Timer = 0 --Runes get wiped
			Rune2Timer = 0 
			Rune3Timer = 0
			if Debug == 'On' then
				windower.add_to_chat(8,'[Rune1Timer set to '..Rune1Timer..' | Rune2Timer set to '..Rune2Timer..' | Rune3Timer set to '..Rune3Timer..']')
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
		if player.equipment.main == nil or player.equipment.sub == nil then
			EquipMain = 'Weapon loading...'
		else
			EquipMain = player.equipment.main
		end
		if LoadHUD == true then
			if Rune1Timer > 151 then
				Rune1Timer = Rune1Timer - 1
				send_command('text rune1 text "'..Rune1..'";text rune1 bg_color '..Rune1BGColor..';text rune1 bg_transparency 150')
			elseif Rune1Timer > 21 then
				Rune1Timer = Rune1Timer - 1
				send_command('text rune1 text "'..Rune1..'";text rune1 bg_color '..Rune1BGColor..';text rune1 bg_transparency '..Rune1Timer..'')
			elseif Rune1Timer > 0 then
				Rune1Timer = Rune1Timer - 1
				send_command('text rune1 text "Wearing off in '..Rune1Timer..'";text rune1 bg_color '..Rune1BGColor..';text rune1 bg_transparency 150')
			else
				Rune1 = 'No Rune'
				if Debug == 'On' then
					windower.add_to_chat(8,'[Rune1 set to No Rune]')
				end
				send_command('text rune1 text "'..Rune1..'";text rune1 bg_transparency 1')
			end
			if Rune2Timer > 151 then
				Rune2Timer = Rune2Timer - 1
				send_command('text rune2 text "'..Rune2..'";text rune2 bg_color '..Rune2BGColor..';text rune2 bg_transparency 150')
			elseif Rune2Timer > 21 then
				Rune2Timer = Rune2Timer - 1
				send_command('text rune2 text "'..Rune2..'";text rune2 bg_color '..Rune2BGColor..';text rune2 bg_transparency '..Rune2Timer..'')
			elseif Rune2Timer > 0 then
				Rune2Timer = Rune2Timer - 1
				send_command('text rune2 text "Wearing off in '..Rune2Timer..'";text rune2 bg_color '..Rune2BGColor..';text rune2 bg_transparency 150')
			else
				Rune2 = 'No Rune'
				if Debug == 'On' then
					windower.add_to_chat(8,'[Rune2 set to No Rune]')
				end
				send_command('text rune2 text "'..Rune2..'";text rune2 bg_transparency 1')
			end
			if Rune3Timer > 151 then
				Rune3Timer = Rune3Timer - 1
				send_command('text rune3 text "'..Rune3..'";text rune3 bg_color '..Rune3BGColor..';text rune3 bg_transparency 150')
			elseif Rune3Timer > 21 then
				Rune3Timer = Rune3Timer - 1
				send_command('text rune3 text "'..Rune3..'";text rune3 bg_color '..Rune3BGColor..';text rune3 bg_transparency '..Rune3Timer..'')
			elseif Rune3Timer > 0 then
				Rune3Timer = Rune3Timer - 1
				send_command('text rune3 text "Wearing off in '..Rune3Timer..'";text rune3 bg_color '..Rune3BGColor..';text rune3 bg_transparency 150')
			else
				Rune3 = 'No Rune'
				if Debug == 'On' then
					windower.add_to_chat(8,'[Rune3 set to No Rune]')
				end
				send_command('text rune3 text "'..Rune3..'";text rune3 bg_transparency 1')
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
			if buffactive['Enmity Boost'] and buffactive['Phalanx'] and buffactive['Battuta'] and buffactive['Swordplay'] and (buffactive['Ignis'] or buffactive['Gelus'] or buffactive['Flabra'] or buffactive['Tellus'] or buffactive['Sulpor'] or buffactive['Unda'] or buffactive['Lux'] or buffactive['Tenebrae']) and player.in_combat == true then
				send_command('text mode text "Mode: '..Mode..' (Beast)"')
			else
				if Mode == 'Auto' then
					if player.in_combat == true then
						send_command('text mode text "Mode: '..Mode..' (Combat)"')
					else
						send_command('text mode text "Mode: '..Mode..' (Neutral)"')
					end
				else
					send_command('text mode text "Mode: '..Mode..'"')
				end
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
			send_command('text crusade pos '..HUDposXColumn1..' '..HUDposYLine1..'')		--Crusade goes in Column 1
			send_command('text phalanx pos '..HUDposXColumn2..' '..HUDposYLine1..'')		--Phalanx goes in Column 2
			if player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
				send_command('text cocoon pos '..HUDposXColumn3..' -100')					--Cocoon is not visible
				send_command('text defender pos '..HUDposXColumn3..' '..HUDposYLine1..'')	--Defender goes in Column 3
				send_command('text battuta pos '..HUDposXColumn4..' '..HUDposYLine1..'')	--Battuta goes in Column 4
				send_command('text swordplay pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Swordlplay goes in Column 5
				send_command('text vpulse pos '..HUDposXColumn6..' '..HUDposYLine1..'')		--Vivacious Pulse goes in Column 6
			elseif player.sub_job == 'BLU' and player.sub_job_level ~= 0 then
				send_command('text cocoon pos '..HUDposXColumn3..' '..HUDposYLine1..'')		--Cocoon goes in Column 3
				send_command('text defender pos '..HUDposXColumn3..' -100')					--Defender is not visible
				send_command('text battuta pos '..HUDposXColumn4..' '..HUDposYLine1..'')	--Battuta goes in Column 4
				send_command('text swordplay pos '..HUDposXColumn5..' '..HUDposYLine1..'')	--Swordlplay goes in Column 5
				send_command('text vpulse pos '..HUDposXColumn6..' '..HUDposYLine1..'')		--Vivacious Pulse goes in Column 6
			else
				send_command('text cocoon pos '..HUDposXColumn3..' -100')					--Cocoon is not visible
				send_command('text defender pos '..HUDposXColumn3..' -100')					--Defender is not visible
				send_command('text battuta pos '..HUDposXColumn3..' '..HUDposYLine1..'')	--Battuta goes in Column 3
				send_command('text swordplay pos '..HUDposXColumn4..' '..HUDposYLine1..'')	--Swordlplay goes in Column 4
				send_command('text vpulse pos '..HUDposXColumn5..' '..HUDposYLine1..'')		--Vivacious Pulse goes in Column 5
			end
			--Recast updates:
			if player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
				DefenderRecast = windower.ffxi.get_ability_recasts()[3]
			elseif player.sub_job == 'BLU' and player.sub_job_level ~= 0 then
				CocoonRecast = windower.ffxi.get_spell_recasts()[547]
			end
			CrusadeRecast = windower.ffxi.get_spell_recasts()[476]
			PhalanxRecast = windower.ffxi.get_spell_recasts()[106]
			BattutaRecast = windower.ffxi.get_ability_recasts()[120]
			SwordplayRecast = windower.ffxi.get_ability_recasts()[24]
			VPulseRecast = windower.ffxi.get_ability_recasts()[242]
			--Recast color updates - decide the colors:
			if buffactive['Enmity Boost'] then CrusadeColor = '75 255 75'
			elseif CrusadeRecast > 0 then CrusadeColor = '255 165 0'
			else CrusadeColor = '255 50 50'
			end
			if buffactive['Phalanx'] then PhalanxColor = '75 255 75'
			elseif PhalanxRecast > 0 then PhalanxColor = '255 165 0'
			else PhalanxColor = '255 50 50'
			end
			if buffactive['Battuta'] then BattutaColor = '75 255 75'
			elseif BattutaRecast > 0 then BattutaColor = '255 165 0'
			else BattutaColor = '255 50 50'
			end
			if buffactive['Swordplay'] then SwordplayColor = '75 255 75'
			elseif SwordplayRecast > 0 then SwordplayColor = '255 165 0'
			else SwordplayColor = '255 50 50'
			end
			if VPulseRecast == 0 then
				VPulseColor = '255 50 50'
			else
				VPulseColor = '255 165 0'
			end
			if player.sub_job == 'BLU' and player.sub_job_level ~= 0 then
				if buffactive['Defense Boost'] then CocoonColor = '75 255 75'
				elseif CocoonRecast > 0 then CocoonColor = '255 165 0'
				else CocoonColor = '255 50 50'
				end
			elseif player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
				if buffactive['Defender'] then DefenderColor = '75 255 75'
				elseif DefenderRecast > 0 then DefenderColor = '255 165 0'
				else DefenderColor = '255 50 50'
				end
			end
			--Recast color updates - print the colors:
			send_command('text crusade color '..CrusadeColor..'')
			send_command('text phalanx color '..PhalanxColor..'')
			send_command('text battuta color '..BattutaColor..'')
			send_command('text swordplay color '..SwordplayColor..'')
			send_command('text vpulse color '..VPulseColor..'')
			if player.sub_job == 'BLU' and player.sub_job_level ~= 0 then
				send_command('text cocoon color '..CocoonColor..'')
			elseif player.sub_job == 'WAR' and player.sub_job_level ~= 0 then
				send_command('text defender color '..DefenderColor..'')
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
	Rune1Timer = 0
	Rune2Timer = 0
	Rune3Timer = 0
	if Debug == 'On' then
		windower.add_to_chat(8,'[Rune1Timer set to '..Rune1Timer..' | Rune2Timer set to '..Rune2Timer..' | Rune3Timer set to '..Rune3Timer..']')
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
--         WS DAMAGE NOTIFICATION        --
-------------------------------------------

windower.register_event('action',function(act)
	local sc = {} sc[1] = 'Lgt' sc[2] = 'Drk' sc[3] = 'Grv' sc[4] = 'Frg' sc[5] = 'Dst' sc[6] = 'Fsn' sc[7] = 'Cmp' sc[8] = 'Lqf' sc[9] = 'Ind' sc[10] = 'Rvr' sc[11] = 'Trn' sc[12] = 'Scs' sc[13] = 'Dtn' sc[14] = 'Imp' sc[15] = 'Rdn' sc[16] = 'Umb'
	local weaponskills = require('resources').weapon_skills
	if act.category == 3 and act.actor_id == player.id then
		--Uses Weapon Skill but misses, gets blinked, or hits for 0
		if act.targets[1].actions[1].message == 188 or act.targets[1].actions[1].message == 31 or (act.targets[1].actions[1].message == 185 and act.targets[1].actions[1].param == 0) then
			send_command('wait .2;text notifications text "«« '..weaponskills[act.param].english..' Missed »»";text notifications color 0 255 255;text notifications bg_transparency 1')
		elseif act.targets[1].actions[1].has_add_effect == true then
			send_command('wait .2;text notifications text "'..weaponskills[act.param].english..': '..act.targets[1].actions[1].param..' ('..sc[act.targets[1].actions[1].add_effect_animation]..': '..act.targets[1].actions[1].add_effect_param..')";text notifications color 0 255 255;text notifications bg_transparency 1')
		else
			send_command('wait .2;text notifications text "'..weaponskills[act.param].english..': '..act.targets[1].actions[1].param..'";text notifications color 0 255 255;text notifications bg_transparency 1')
		end
		NotiCountdown = -1
		if Debug == 'On' then
			windower.add_to_chat(8,'[NotiCountdown set to -1]')
		end
	end
end)

-------------------------------------------
--             FILE UNLOAD               --
-------------------------------------------

function file_unload()
	send_command('wait 1;text bg1 delete;text bg2 delete;text bg3 delete;text bg4 delete;text rune1 delete;text rune2 delete;text rune3 delete;text crusade delete;text phalanx delete;text vpulse delete;text cocoon delete;text defender delete;text battuta delete;text swordplay delete;text loading delete;text mode delete;text notifications delete;text debuffs delete;text weapons delete') --delete the different text objects
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
