-------------------------------------------
-- Keys Gearswap lua file for Geomancer  --
-------------------------------------------
--[[

REQUIRED Windower Addons: Text

Updates to this file and other GearSwap files and addons can be found at
https://github.com/iLVL-Key/FFXI

Place both this file and the sounds folder inside the GearSwap data folder
ex:	/addons/GearSwap/data/sounds/
	/addons/GearSwap/data/GEO.lua

To activate Damage Taken Override, use any of these three options:
1. A macro with the following
	/console DT
2. An alias command
	//dt
3. A keybind shortcut
	CTRL+D
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
LockstyleField 	=	'4'		--[1-200]		Your Lockstyle set when in a field zone.
LockstyleTown	=	'1'		--[1-200]		Your Lockstyle set when in a town zone.
							--				If you do not want a separate town lockstyle, set this to the same as LockstyleField.
Book			=	'5'		--[1-20/Off]	Sets your Macro book to any number from 1 to 20 (or Off) on file load.
SubWHMPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing WHM.
SubRDMPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing RDM.
SubBLMPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing BLM.
SubSCHPage		=	'1'		--[1-10/Off]	Sets your Macro page to any number from 1 to 10 (or Off) on file load or subjob change when subbing SCH.
Chat			=	'p'		--[s/p/l/l2/Off]Sets your Default chat mode (say, party, linkshell, linkshell2, or Off) on file load.
BolTimer		=	'On'	--[On/Off]		Displays a timer for Bolster in echo.
WCTimer			=	'On'	--[On/Off]		Displays a timer for Widened Compass in echo.
ZoneGear		=	'All'	--[All/Town/Off]Automatically re-equips your gear after you zone based on certain conditions.
							--				(Town limits this to town gear only)
AlertSounds		=	'On'	--[On/Off]		Plays a sound on alerts. 
UseEcho			=	'R'		--[E/R/Off]		Automatically uses an (E)cho Drop or (R)emedy instead of spell when you are silenced.
AutoHWater		=	'On'	--[On/Off]		Automatically attempts to use Holy Waters when you get Doomed until it wears off.
AutoFullCircle	=	'On'	--[On/Off]		Automatically uses Full Circle when you cast a Geo- spell with a Luopan already out.
AutoEntrust		=	'On'	--[On/Off]		Automatically uses Entrust when you cast an Indi- spell on a party member. The first cast onto
							--				a party member will engage the AutoEntrust system, the second cast will execute as intended.
DoomAlert		=	'On'	--[On/Off]		Alerts your party when you are doomed.
DoomOnText		=	'doom'			--		Text that displays in party chat when you are doomed. 
DoomOffText		=	'doom off'		--		That that displays in party chat when you are no longer doomed.

-- Heads Up Display --
HUDposX			=	100		--	X position for the HUD. 0 is left of the window, increasing this number will move it to the right.
HUDposY			=	100		--	Y position for the HUD. 0 is top of the window, increasing this number will move it downward.
FontSize		=	12		--	Adjust the font size. Changing this will require you to adjust the Spacers below as well.
LineSpacer		=	20		--	Space in pixels between each Line of the HUD
ColumnSpacer	=	93		--	Space in pixels between each Column of the HUD
EntrustDuration	=	320		--	Duration in seconds of Entrusted Indi spells. Base duration is 180 seconds, this increases with
							--	Indicolure Duration gear. Adjust as needed to match up when the HUD shows the Entrusted Indicolure
							--	spell wearing off. This is only used with the HUD.

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

ShowHUD			=	true	--Initial state of the HUD. Use `//hud` to show/hide the HUD in game.
DTBind			=	'^d'	--Sets the keyboard shortcut you would like to activate the Damage Taken Override. CTRL+D (^d) is default.
							--    ^ = CTRL    ! = ALT    @ = WIN    # = APPS    ~ = SHIFT
LowHPThreshold	=	1000	--Below this number is considered Low HP.
DangerRepeat	=	10		--Maximum number of times the Danger Sound will repeat, once per second.
RRReminderTimer	=	1800	--Delay in seconds between checks to see if Reraise is up (300 is 5 minutes)
NotiDelay		=	6		--Delay in seconds before certain notifications will automatically clear.
HUDBGTrans		=	'175'	--Background transparency for the HUD. (0 = fully clear, 255 = fully opaque)
AddCommas		=	'On'	--[On/Off]  Adds commas to damage numbers.
Debug			=	'Off'	--[On/Off]

--Color Values
PetHPMeter100color	=	'0 255 0'	--Pet HP Meter color up to 100%
PetHPMeter50color	=	'255 165 0'	--Pet HP Meter color under 50%
PetHPMeter25color	=	'255 0 50'	--Pet HP Meter color under 25%

-------------------------------------------
--               GEAR SETS               --
-------------------------------------------

function get_sets()

	-- Idle (Movement Speed, Refresh, Regen, Damage Taken-, Enmity-)
	-- Used when you do NOT have a Luopan bubble out.
	sets.idle = {
		main="Idris",
		sub="Ammurapi Shield",
		range="Dunna",
		head="Befouled Crown",
		body="Azimuth Coat +3",
		hands="Bagua Mitaines +3",
		legs="Nyame Flanchard",
		feet="Geo. Sandals +3",
		neck="Twilight Torque",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear="Ethereal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}},
    }

	-- Luopan (Pet Damage Taken-, Pet Regen)
	-- Used when you DO have a Luopan bubble out.
	-- Combines with Idle set, only necessary to set the slots with specific desired stats
	sets.luopan = set_combine(sets.idle, {
		main="Idris",
		sub="Ammurapi Shield",
		range="Dunna",
		head="Azimuth Hood +3",
		hands="Geomancy Mitaines +3",
		legs="Nyame Flanchard",
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
		head="Amalric Coif +1", --11%
		body="Agwu's Robe", --8%
	    hands="Leyline Gloves", --5+1
		legs="Geomancy Pants", --9%???
		feet="Amalric Nails +1", --6%
		neck="Baetyl Pendant", --4%
		waist="Witful Belt", --3%
		left_ear="Malignance Earring", --4%
		right_ear="Loquac. Earring", --2%
		left_ring="Prolix Ring", --2%
		right_ring="Kishar Ring", --4%
		back="Lifestream Cape", --7%
	}

	-- Geomancy (Geomancy+, Geomancy Skill, Handbell Skill, Indicolure duration+, Lupoan duration+)
	-- NOTE: You only need a combined skill of 900 between Geomancy skill and Handbell skill to cap your potency, anything over 900 is wasted)
	sets.geomancy = {
		main="Idris",
		sub="Ammurapi Shield",
		range="Dunna",
		head="Azimuth Hood +3",
		body="Bagua Tunic",
		hands="Geomancy Mitaines +3",
		legs="Bagua Pants +3",
		feet="Azimuth Gaiters +3",
		neck="Bagua Charm +1",
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
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Mag. Evasion+15',}},
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
		neck="Bagua Charm +1",
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
		head="Bagua Galero",
		feet="Agwu's Pigaches",
		neck="Erra Pendant",
		waist="Fucho-no-obi",
		right_ring="Evanescence Ring",
	})

	-- Enfeeble (Enfeebling Magic Skill)
	-- Combines with Magic Accuracy set, only necessary to set the slots with specific desired stats
	sets.enfeeble = set_combine(sets.magicaccuracy, {
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
		head="Bagua Galero",
	}

	-- Life Cycle (Enhances Life Cycle gear)
	sets.lifecycle = {
		body="Geomancy Tunic",
		back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}},
	}

	-- Default Town Gear (Put all your fancy-pants gear in here you want to showboat around town. Does not lockstyle this gear, only equips)
	sets.town = set_combine(sets.idle, {
		main="Idris",
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




FileVersion = '13.1'

-------------------------------------------
--               UPDATES                 --
-------------------------------------------

--[[
MAJOR version updates add new feature(s). Usually require changes in the top portion of the file. Changes to gear sets will be noted.
MINOR version updates change how existing feature(s) function. Usually only require changes under the "Do Not Edit Below This Line".
PATCH version updates fix feature(s) that may not be functioning correctly or are otherwise broken. Usually only require changes under the "Do Not Edit Below This Line".
Ex: 1.2.3 (1 is the Major version, 2 is the Minor version, 3 is the patch version)

Version 13.1
- Adjusted HUD background to display the Luopan HP as a % meter.
- Fixed some errors that would display under certain circumstances immediately after switching characters.

Version 13.0.3
- Fixed a timing issue with the Luopan gear set equipping after casting a Geo- spell.

Version 13.0.2
- Fixed an issue with Aspir II/III and Drain not equipping the correct set.

Version 13.0.1
- Fixed an issue where the Entrust target is not captured correctly when the Indi- spell and target is typed manually into the chat.

Version 13.0
- Added Black halo and Exudation gear sets.
- Adjusted how the Weapon Skill sets are coded. You can now add a new set for a WS that is not already defined by simply copying another WS set and changing the set name to match the desired WS name. This change also tidies up the backend code a bit as well which was totally not the main reason for doing it.
- Adjusted Page Option. Now defined for subbing WHM, RDM, BLM, or SCH with a default of 1 for other subjobs.
- Adjusted HUD positioning options and text for clarity.
- Adjusted HUD Ability recast colors. Will now give a short blink when an ability is becoming ready to use again.
- Adjusted ability recast timings for equipping gear from `<= 1` to `< 2`. Should give a touch more room to fire off properly if you're camping that recast timer.
- Adjusted Gear Mode keybind Advanced Option to remove the hardcoded "CTRL+" requirement. Can now be fully customized (WIN+G, ALT+5, F9, etc.)
- Adjusted the //hidehud and //showhud aliases to condense to just //hud. It also now actually works.
- Fixed an issue with the name of the Entrust target being cleared when casting another Indi- spell afterwards.
- Reversed AutoFullCircle change from Version 12.1.

Version 12.1
- Adjusted AutoFullCircle to no longer cast the Geocolure spell after using Full Circle. This allows for using any Gecolure spell to dismiss the previous bubble, without also casting another one immediately after usage, removing the need for a separate Full Circle macro if you only want to dismiss your current bubble.

Version 12.0
- No gear set changes.
- Added Advanced Option to add commas to the damage numbers.
- Adjusted Weaponskill Missed notification to also display when a Weaponskill gets blinked.
- Removed notifications for Blood Pacts because I don't know why I added it in there.

Version 11.0.0
- No gear set changes.
- Renamed WS Damage Notification to Damage Notification.
- Updated Damage Notification to include Weapon Skills, Skillchains, Magic Bursts, and Blood Pacts.
- Adjusted AutoEntrust behavior. Using a macro to cast an Indi- spell on someone else will now instead of directly using Entrust then casting that spell, it will instead activate the AutoEntrust system for use. Simply repeat the cast to use AutoEntrust. AutoEntrust will deactivate after 10 seconds, or after casting on yourself instead. This change was made to prevent misfires in situations where you intend to cast an Indi- spell on yourself, but someone casts on you right before, therefore making you target them, and thus the target of the Indi- spell.
- Fixed Luopan gear set not equipping immediately after casting a Geo- spell.
- Fixed WS Damage Notification option displaying regardless of being on or off.
- Updated to semantic versioning. This removes the need for the Version Compatibility Codenames.

04.15.23 (Version Compatibility Codename: Indi-CHR)
- Fixed missing options listings in the File Info (//fileinfo)

02.22.23 (Version Compatibility Codename: Indi-CHR)
- Adjusted WS Damage Notification to display WSs for zero like normal. This reverses a previous change, but now with Skillchain damage being displayed alongside WS damage it made sense to show the zero damage instead of displaying as a miss.

02.07.23 (Version Compatibility Codename: Indi-CHR)
- Adjusted WS Damage Notification to filter out some Job Abilities that get listed in the same action category as Weapon Skills.

01.24.23 (Version Compatibility Codename: Indi-CHR)
- Adjusted WS Damage Notification to display Skillchain damage.

01.21.23 (Version Compatibility Codename: Indi-CHR)
- Adjusted Macro Page timing. Should fix occasional issue with macros deleting themselves.
- Adjusted WS Damage Notification to count blinked WSs and WSs for zero as a miss. Blinks would previously display the number of shadows as the damage number.
- Fixed issue with WS Damage Notification where some abilities and weapon skills would occasionally gets mixed up.

01.10.23 (Version Compatibility Codename: Indi-CHR)
- Adjusted HUD to automatically hide during zoning.
- Removed Omen and Vagary notifications. Those have been spun out into their own windower addon called Callouts.
- Updated Version Compatibility Codename to Indi-CHR.

12.27.22 (Version Compatibility Codename: Indi-Refresh)
- Removed the option to turn off the HUD. While I generally think the more options the better, the HUD is a main part of this lua.
- Fixed occasional error messages from the Text addon when loading/reloading the file.
- Updated Version Compatibility Codename to Indi-Refresh.
- Code cleanup.

12.06.22 (Version Compatibility Codename: Indi-Barrier)
- Overhauled Low HP notification. Notification and sound no longer activates in towns. Changed the Advanced Option from selecting "Once" or "Constant" to instead selecting the number of times the sound will repeat while your HP is low. Removed the 30 second window before triggering again.
- Adjusted certain notification to now automatically clear after a short delay.
- Removed the option for using the OhShit gear set. The gear set itself still remains and funtionality has not changed. Having the option was redundant as you can simply leave the set empty.
- Updated Version Compatibility Codename to Indi-Barrier.
- Code cleanup.

11.30.22 (Version Compatibility Codename: Indi-Focus)
- Overhauled how death is handled. More cleanly prevents unnecessary notifications from activating immediately upon raising (ie Reraise wearing off and Low HP).
- Added Mending Halation to the HUD.
- Added Danger sound file. Used by Doom and Low HP.
- Added Advanced Option for the Danger sound to play constantly while in danger or only once (with a 30 second delay to be able to play again).
- Added WS Damage option. Displays your damage (or miss) after a Weapon Skill.
- Added the //hidehud and //showhud alias commands.
- Added debug lines for redefining variables.
- Adjusted Low HP Notification to not trigger while weakened.
- Adjusted Low HP Notification Sound to have a 30 second window after triggering where it will not trigger again.
- Adjusted Low MP Notification to trigger in real-time rather than being tied to the Aftercast funtion.
- Adjusted HUD text object loading timing to avoid them occasionally not loading correctly.
- Adjusted AutoHWater option to stop and notify you once you are out of useable Holy Waters.
- Adjusted the Trade notification to clear once the trade is complete.
- Renamed OhShitThreshold to LowHPThreshold since it controls more than just the OhShit option.
- Removed the option to turn off the HUDRecast. While I generally think the more options the better, the recasts are a main part of the HUD.
- Removed the CharmNaked option. Apparently you can't Do Stuff while charmed ¯\_(ツ)_/¯
- Fixed incorrect SP Ability timers when wearing gear that augments (adds additional time to) the ability.
- Fixed ordering of Status Notifications.
- Fixed Lasting Emanation/Ecliptic Attrition not displaying their status correctly in the HUD.
- Fixed a few redundant checks for Amnesia.
- Updated Version Compatibility Codename to Indi-Focus.
- Code cleanup.

10.15.22 (Version Compatibility Codename: Indi-Attunement)
- Added an Oh Shit gear set and accompanying option to use it. HP threshold required to activate is adjustable in the Advanced Options.
- Added Low HP Notification.
- Added AutoHWater option. Automatically attempts to use Holy Waters when you get Doomed until it wears off. Currently will keep trying even if you run out of Holy Waters.
- Added DoomAlert option. Will alert your party when you are doomed. You can also customize the text that displays in party chat.
- Added CharmNaked option. Removes all gear, or all gear except weapons, when you are charmed.
- Added Sneak and Invisible status notification.
- Added missing listings in the /fileinfo printout for a few Notifications.
- Added Silver Knife to list of Adoulin/Town areas.
- Adjusted the code that tries to wake you when you are asleep to not trigger if you are charmed.
- Adjusted resting to equip Refresh + Rest gear sets.
- Moved RRReminderTimer from Options to Advanced Options.
- Fixed resting not equipping the DT Override set properly.
- Removed Gearswaps built-in showswaps function from the files debug mode.
- Updated Version Compatibility Codename to Indi-Attunement.
- Code cleanup.

09.07.22 (Version Compatibility Codename: Indi-Regen)
- Added Enfeebling set.
- Adjusted the Aspir/Drain set to combine with the Magic Accuracy set instead of the Buff set.
- Adjusted what the fastcast set ignores to include all "Ring" items (previously would ignore only Warp and Dimensional Rings specifically, will now also ignore XP/CP rings)
- Updated Version Compatibility Codename to Indi-Regen.

08.14.22 (Version Compatibility Codename: Indi-Precision)
- Added AutoEntrust option. Automatically uses Entrust when you cast an Indi- spell on a party member.
- Added Leafallia to list of towns.
- Added cancelling Stoneskin if its preventing poison from removing sleep.
- Added a Cataclysm set.
- Split the Cursna set into Cursna and Holy Water.
- Adjusted abilities to not equip their gear sets if they are still on cooldown.
- Renamed LockstyleField to LockstyleCombat. Just makes more sense.
- Fixed an issue where the debuff background color change from Doom (flashing white and yellow) would get stuck on yellow after Doom wears off and you have another debuff on that takes over in the debuff spot.
- Updated Version Compatibility Codename to Indi-Precision.
- Code cleanup.

07.18.22 (Version Compatibility Codename: Indi-Voidance)
- Adjusted some gear sets and logic in their usage. (removed the Luopan set and renamed Combinedskill to Geomancy)
- Overhauled how area checks are handled. Uses tables now for groups of areas.
- Fixed some errors that would show up on job change. These were caused by the Heartbeat function constantly checking for any debuffs present; when you unload the file (change job) it will delete the debuff text objects used for the HUD which will cause a split second where the debuff check freaks out. The fix was to simply disable the debuff checks in town zones.
- Fixed an issue with the Sleep debuff not showing properly in the HUD.
- Added a Hexa Strike set since it is multi-hit in case you have Fotia Belt/Gorget.
- Updated Version Compatibility Codename to Indi-Voidance.
- Code cleanup.

06.14.22 (Version Compatibility Codename: Indi-Poison)
- Adjusted HUD timings on load. Should fix the occasional errors about text objects not existing as well as objects loading underneath the background layer.
- Removed Gearswaps built-in debugmode from the files Debug mode.
- Moved the Updates section towards the top of the file.
- Code cleanup.

03.11.22 (Version Compatibility Codename: Indi-Poison)
- Overhauled Debuff Notifications. Will now check which debuffs are up in real time with a list of priority for which is displayed instead of clearing the notifications entirely when any of them are removed (leaving it blank even if a different debuff was still up).
- Added missing On/Off option/rules to Time Remaining (currently only for Abyssea), Omen, and Vagary
- Fixed Alliance invite incorrectly triggering Party invite notification.

02.02.22 (Version Compatibility Codename: Indi-Poison)
- Added Weak status notification.
- Fixed gear not fully equipping in towns.
- Fixed Abyssea Visitant status triggering on incorrect time remaining (ie 110 minutes would trigger the 10 minute)
- Fixed Fast Cast gear to not equip when using a Forbidden Key, Pickaxe, Sickle, or Hatchet.

02.01.22 (Version Compatibility Codename: Ind-Poison)
- Overhauled Notifications. Removed reliance on variables and spun out Debuffs into their own thing.
- Renamed the OnScreen Display to HUD.
- Added Paralysis to the Debuffs.
- Added option to automatically use an Echo Drop (or Remedy) instead of spell when you are silenced.
- Added AutoFullCircle function. Automatically uses Full Circle when you cast a Geo- spell with a Luopan already out.
- Added rule for White Magic Cure spells to the Healing set.
- Added option for setting macro book page (set).
- Added Trade, Invite, Sneak, Invisible, Vorseal, Signet, Sanction, Sigil, and Ionis to the Notifications.
- Added the 3000 TP notification to the Notification options.
- Added 2 new sounds (NotiGood and NotiBad) and adjusted sound usage accordingly.
- Added a Heartbeat function. This creates a one second "heartbeat" that we can use to do various things that may not otherwise have an automatic trigger.
- Added a background to the HUD creating a box that everything is displayed inside, instead of separate floating pieces of info.
- Moved the KO Notification into the Heartbeat function.
- Moved Luopan check into the Heartbeat function.
- Added HUD now hiding when in a cutscene. (The code to hide while zoning is adding a lot of lag, will look further into this)
- Adjusted the solid colors to be a little less solid (red was just so... ~*RED*~)
- Adjusted the Doom Notification to have a more noticeable presence.
- Fixed an issue with AutoLockstyle where it would not run correctly if you change your sub job immediately after changing to BLU.
- Fixed the Reraise Reminder.
- Fixed the Dead Notification.
- Changed «« and »» to << and >> for chatlog notifications since «« and »» don't actually display in the chatlog.
- Fixed displaying DT Override status while in towns.
- Fixed a lot calls to the Text plugin when not using the Text plugin (HUD turned off)
- Fixed the Reraise Reminder.
- Code cleanup.

12.02.21 (Version Compatibility Codename: Indi-Regen)
- First version
- Started from Blue Mage file version 11.30.21
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

IndiColure = 'None'
GeoColure = 'None'
Entrust = 'None'
UseEntrust = false
NotiLowMPToggle = 'Off' --start with the toggle off for the Low MP Notification so that it can trigger
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
LockstyleDelay = 5
AutoLockstyleRun = true
if pet.isvalid then
	LuopanActive = true
else
	LuopanActive = false
end
LowHP = false
Doom = false
Alive = true --makes it easier to Do Things or Not Do Things based on if we die.
DangerCountdown = 0
NotiCountdown = -1 --we set the countdown below 0 to stop the countdown from hitting 0 and triggering the ClearNotifications command

--set the initial recasts to 0, they will get updated in the Heartbeat function:
EntrustCountdown = 0
EntrustRecast = 0
BlazeRecast = 0
EclipticRecast = 0
DematerializeRecast = 0
LifeRecast = 0
RadialRecast = 0
MendingRecast = 0


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
send_command('wait 1.4;text pethpmeter1 create "";wait .3;text pethpmeter1 size '..FontSize..';text pethpmeter1 pos '..HUDposXColumn1..' -100;text pethpmeter1 bg_transparency 0; text pethpmeter1 bg_color 255 0 0')--Pet HP Meter
send_command('wait 1.4;text pethpmeter2 create "";wait .3;text pethpmeter2 size '..FontSize..';text pethpmeter2 pos '..HUDposXColumn1..' -100;text pethpmeter2 bg_transparency 0; text pethpmeter2 bg_color 255 0 0')--Pet HP Meter
send_command('wait 1.4;text pethpmeter3 create "";wait .3;text pethpmeter3 size '..FontSize..';text pethpmeter3 pos '..HUDposXColumn1..' -100;text pethpmeter3 bg_transparency 0; text pethpmeter3 bg_color 255 0 0')--Pet HP Meter
send_command('wait 1.4;text pethpmeter4 create "";wait .3;text pethpmeter4 size '..FontSize..';text pethpmeter4 pos '..HUDposXColumn1..' -100;text pethpmeter4 bg_transparency 0; text pethpmeter4 bg_color 255 0 0')--Pet HP Meter
send_command('wait 1.5;text bg1 create "                                                                                                                          ";wait .3;text bg1 size '..FontSize..';text bg1 pos '..HUDposXColumn1..' '..HUDposYLine1..';text bg1 bg_transparency '..HUDBGTrans..'')--Background Line 1
send_command('wait 1.6;text loading create "Loading Keys GEOMANCER file ver: '..FileVersion..' ...";wait .3;text loading size '..FontSize..';text loading pos '..HUDposXColumn1..' '..HUDposYLine1..';text loading bg_transparency 1') --Loading
send_command('wait 1.7;text bg2 create "                                                                                                                          ";wait .3;text bg2 size '..FontSize..';text bg2 pos '..HUDposXColumn1..' -100;text bg2 bg_transparency '..HUDBGTrans..'')--Background Line 2
send_command('wait 1.8;text bg3 create "                                                                                                                          ";wait .3;text bg3 size '..FontSize..';text bg3 pos '..HUDposXColumn1..' -100;text bg3 bg_transparency '..HUDBGTrans..'')--Background Line 3
send_command('wait 1.9;text bg4 create "                                                                                                                          ";wait .3;text bg4 size '..FontSize..';text bg4 pos '..HUDposXColumn1..' -100;text bg4 bg_transparency '..HUDBGTrans..'')--Background Line 4
--Create the Notifications and Debuffs text objects and put them above the screen for now, we'll move them to the correct place next
send_command('wait 2.0;text notifications create "Hello, '..player.name..'! (type //fileinfo for more information)";wait .3;text notifications size '..FontSize..';text notifications pos '..HUDposXColumn1..' -100;text notifications bg_transparency 1') --Notifications
send_command('wait 2.1;text debuffs create " ";wait .3;text debuffs size '..FontSize..';text debuffs pos '..HUDposXColumn4..' -100;text debuffs bg_transparency 1') --Debuffs
send_command('wait 2.2;text indicolurelabel create "Self";wait .3;text indicolurelabel size '..FontSize..';text indicolurelabel pos '..HUDposXColumn1..' -100;text indicolurelabel color 255 255 255;text indicolurelabel bg_transparency 1') --Self
send_command('wait 2.3;text indicolure create "'..IndiColure..'";wait .3;text indicolure size '..FontSize..';text indicolure pos '..HUDposXColumn1..' -100;text indicolure color 255 50 50;text indicolure bg_transparency 1') --Self
send_command('wait 2.4;text geocolurelabel create "Luopan";wait .3;text geocolurelabel size '..FontSize..';text geocolurelabel pos '..HUDposXColumn3..' -100;text geocolurelabel color 255 255 255;text geocolurelabel bg_transparency 1') --Luopan
send_command('wait 2.5;text geocolure create "'..GeoColure..'";wait .3;text geocolure size '..FontSize..';text geocolure pos '..HUDposXColumn3..' -100;text geocolure color 255 50 50;text geocolure bg_transparency 1') --Luopan
send_command('wait 2.6;text entrustlabel create "Entrust";wait .3;text entrustlabel size '..FontSize..';text entrustlabel pos '..HUDposXColumn5..' -100;text entrustlabel color 255 255 255;text entrustlabel bg_transparency 1') --Entrust
send_command('wait 2.7;text entrust create "'..Entrust..'";wait .3;text entrust size '..FontSize..';text entrust pos '..HUDposXColumn5..' -100;text entrust color 255 50 50;text entrust bg_transparency 1') --Entrust
--Create all the HUD Recast text objects and put them above the screen for now, we'll move them to the correct place next
send_command('wait 2.8;text radial create "[ Radial ]";wait .3;text radial size '..FontSize..';text radial pos '..HUDposXColumn1..' -100;text radial bg_transparency 1')
send_command('wait 2.9;text mending create "[ Mending ]";wait .3;text mending size '..FontSize..';text mending pos '..HUDposXColumn1..' -100;text mending bg_transparency 1')
send_command('wait 3.0;text blaze create "[ Blaze ]";wait .3;text blaze size '..FontSize..';text blaze pos '..HUDposXColumn1..' -100;text blaze bg_transparency 1')
send_command('wait 3.1;text dematerialize create "[ Demat. ]";wait .3;text dematerialize size '..FontSize..';text dematerialize pos '..HUDposXColumn1..' -100;text dematerialize bg_transparency 1')
send_command('wait 3.2;text ecliptic create "[ Ecliptic ]";wait .3;text ecliptic size '..FontSize..';text ecliptic pos '..HUDposXColumn1..' -100;text ecliptic bg_transparency 1')
send_command('wait 3.3;text life create "[ Life ]";wait .3;text life size '..FontSize..';text life pos '..HUDposXColumn1..' -100;text life bg_transparency 1')

send_command('alias lockstyle gs c Lockstyle') --creates the first lockstyle aliases
send_command('alias lstyle gs c Lockstyle') --creates the second lockstyle aliases
if Chat ~= "Off" then
	send_command('input /cm '..Chat..'')
end
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
send_command('alias fileinfo gs c Fileinfo') --creates the fileinfo alias
send_command('alias hud gs c HUD') --creates the HUD alias
send_command('bind '..DTBind..' gs c DT') --creates the DT Override keyboard shortcut
send_command('alias dt gs c DT') --creates the DT Override alias
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

-------------------------------------------
--            SELF COMMANDS              --
-------------------------------------------

function self_command(command)
	if command == 'DT' then
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
		if Debug == 'On' then
			add_to_chat(8,'[LoadHUD set to True]')
		end
		send_command('text loading hide')
		send_command('wait .1;text pethpmeter1 pos '..HUDposXColumn1..' '..HUDposYLine1..'')
		send_command('wait .1;text bg2 pos '..HUDposXColumn1..' '..HUDposYLine2..'')
		send_command('wait .1;text pethpmeter2 pos '..HUDposXColumn1..' '..HUDposYLine2..'')
		send_command('wait .2;text bg3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')
		send_command('wait .2;text pethpmeter3 pos '..HUDposXColumn1..' '..HUDposYLine3..'')
		send_command('wait .3;text bg4 pos '..HUDposXColumn1..' '..HUDposYLine4..'')
		send_command('wait .3;text pethpmeter4 pos '..HUDposXColumn1..' '..HUDposYLine4..'')
		send_command('wait .8;text radial pos '..HUDposXColumn1..' '..HUDposYLine1..'')
		send_command('wait .8;text mending pos '..HUDposXColumn2..' '..HUDposYLine1..'')
		send_command('wait .8;text blaze pos '..HUDposXColumn3..' '..HUDposYLine1..'')
		send_command('wait .8;text dematerialize pos '..HUDposXColumn4..' '..HUDposYLine1..'')
		send_command('wait .8;text ecliptic pos '..HUDposXColumn5..' '..HUDposYLine1..'')
		send_command('wait .8;text life pos '..HUDposXColumn6..' '..HUDposYLine1..'')
		send_command('wait .9;text indicolure pos '..HUDposXColumn1..' '..HUDposYLine2..'')
		send_command('wait .9;text geocolure pos '..HUDposXColumn3..' '..HUDposYLine2..'')
		send_command('wait .9;text entrust pos '..HUDposXColumn5..' '..HUDposYLine2..'')
		send_command('wait 1;text indicolurelabel pos '..HUDposXColumn1..' '..HUDposYLine3..'')
		send_command('wait 1;text geocolurelabel pos '..HUDposXColumn3..' '..HUDposYLine3..'')
		send_command('wait 1;text entrustlabel pos '..HUDposXColumn5..' '..HUDposYLine3..'')
		send_command('wait 1.1;text notifications pos '..HUDposXColumn1..' '..HUDposYLine4..'')
		send_command('wait 1.1;text debuffs pos '..HUDposXColumn4..' '..HUDposYLine4..'')
	elseif command == 'Fileinfo' then
		add_to_chat(3,'-------------------------------------------')
		add_to_chat(3,'-- Keys Gearswap lua file for Geomancer --')
		add_to_chat(3,'-------------------------------------------')
		add_to_chat(8,' ')
		add_to_chat(200,'File Version: '..FileVersion..'')
		add_to_chat(8,' ')
		add_to_chat(8,'REQUIRED Windower Addons: Text')
		add_to_chat(8,' ')
		add_to_chat(8,'Place both this file and the sounds folder')
		add_to_chat(8,'inside the GearSwap data folder')
		add_to_chat(200,'ex:     /addons/GearSwap/data/sounds/')
		add_to_chat(200,'        /addons/GearSwap/data/GEO.lua')
		add_to_chat(8,' ')
		add_to_chat(8,'To activate Damage Taken Override, use any of these')
		add_to_chat(8,'three options:')
		add_to_chat(8,'1. A macro with the following')
		add_to_chat(200,'        /console DT')
		add_to_chat(8,'2. An alias command')
		add_to_chat(200,'        //dt')
		add_to_chat(8,'3. A keybind shortcut')
		add_to_chat(200,'        CTRL+D')
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
		add_to_chat(200,'LockstyleField: '..(''..LockstyleField..''):color(8)..'')
		add_to_chat(200,'LockstyleTown: '..(''..LockstyleTown..''):color(8)..'')
		add_to_chat(200,'Book: '..(''..Book..''):color(8)..'')
		add_to_chat(200,'SubWHMPage: '..(''..SubWHMPage..''):color(8)..'')
		add_to_chat(200,'SubRDMPage: '..(''..SubRDMPage..''):color(8)..'')
		add_to_chat(200,'SubBLMPage: '..(''..SubBLMPage..''):color(8)..'')
		add_to_chat(200,'SubSCHPage: '..(''..SubSCHPage..''):color(8)..'')
		add_to_chat(200,'Chat: '..(''..Chat..''):color(8)..'')
		add_to_chat(200,'BolTimer: '..(''..BolTimer..''):color(8)..'')
		add_to_chat(200,'WCTimer: '..(''..WCTimer..''):color(8)..'')
		add_to_chat(200,'ZoneGear: '..(''..ZoneGear..''):color(8)..'')
		add_to_chat(200,'AlertSounds: '..(''..AlertSounds..''):color(8)..'')
		add_to_chat(200,'UseEcho: '..(''..UseEcho..''):color(8)..'')
		add_to_chat(200,'AutoHWater: '..(''..AutoHWater..''):color(8)..'')
		add_to_chat(200,'AutoFullCircle: '..(''..AutoFullCircle..''):color(8)..'')
		add_to_chat(200,'AutoEntrust: '..(''..AutoEntrust..''):color(8)..'')
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
		add_to_chat(200,'EntrustDuration: '..(''..EntrustDuration..''):color(8)..'')
		add_to_chat(200,' ')
		add_to_chat(3,'-- General Notifications --')
		add_to_chat(200,'Noti3000TP: '..(''..Noti3000TP..''):color(8)..'')
		add_to_chat(200,'NotiTrade: '..(''..NotiTrade..''):color(8)..'')
		add_to_chat(200,'NotiInvite: '..(''..NotiInvite..''):color(8)..'')
		add_to_chat(200,'NotiSneak: '..(''..NotiSneak..''):color(8)..'')
		add_to_chat(200,'NotiInvis: '..(''..NotiInvis..''):color(8)..'')
		add_to_chat(200,'NotiReraise: '..(''..NotiReraise..''):color(8)..'')
		add_to_chat(200,'NotiFood: '..(''..NotiFood..''):color(8)..'')
		add_to_chat(200,'NotiLowMP: '..(''..NotiLowMP..''):color(8)..'')
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
		add_to_chat(200,'DTBind: '..(''..DTBind..''):color(8)..'')
		add_to_chat(200,'LowHPThreshold: '..(''..LowHPThreshold..''):color(8)..'')
		add_to_chat(200,'DangerRepeat: '..(''..DangerRepeat..''):color(8)..'')
		add_to_chat(200,'RRReminderTimer: '..(''..RRReminderTimer..''):color(8)..'')
		add_to_chat(200,'NotiDelay: '..(''..NotiDelay..''):color(8)..'')
		add_to_chat(200,'HUDBGTrans: '..(''..HUDBGTrans..''):color(8)..'')
		add_to_chat(200,'AddCommas: '..(''..AddCommas..''):color(8)..'')
		add_to_chat(200,'Debug: '..(''..Debug..''):color(8)..'')
		add_to_chat(200,' ')
		add_to_chat(3,'-- Color Values --')
		add_to_chat(200,'PetHPMeter100color: '..(''..PetHPMeter100color..''):color(8)..'')
		add_to_chat(200,'PetHPMeter75color: '..(''..PetHPMeter75color..''):color(8)..'')
		add_to_chat(200,'PetHPMeter50color: '..(''..PetHPMeter50color..''):color(8)..'')
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
			send_command('input /lockstyleset '..LockstyleField..'')
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
	elseif command == 'NotiLowMPToggle' then
		NotiLowMPToggle = 'Off'
		if Debug == 'On' then
			add_to_chat(8,'[NotiLowMPToggle set to Off]')
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
		send_command('text pethpmeter1 show;text pethpmeter2 show;text pethpmeter3 show;text pethpmeter4 show;text bg1 show;text bg2 show;text bg3 show;text bg4 show;text indicolure show;text indicolurelabel show;text geocolure show;text geocolurelabel show;text entrust show;text entrustlabel show;text blaze show;text ecliptic show;text dematerialize show;text life show;text radial show;text mending show;text notifications show;text debuffs show')
	elseif command == 'HideHUD' then
		send_command('text pethpmeter1 hide;text pethpmeter2 hide;text pethpmeter3 hide;text pethpmeter4 hide;text bg1 hide;text bg2 hide;text bg3 hide;text bg4 hide;text indicolure hide;text indicolurelabel hide;text geocolure hide;text geocolurelabel hide;text entrust hide;text entrustlabel hide;text blaze hide;text ecliptic hide;text dematerialize hide;text life hide;text radial hide;text mending hide;text notifications hide;text debuffs hide')
	elseif command == 'CancelUseEntrust' then
		if UseEntrust == true then
			UseEntrust = false
			if Debug == 'On' then
				add_to_chat(8,'[UseEntrust set to False]')
			end
			send_command('text entrustlabel text "Entrust";text entrustlabel color 255 255 255;text entrustlabel bg_transparency 1') --reset the label when we deactivate AutoEntrust
		end
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
				add_to_chat(8,'[Equipped Set: Rest + DT Override]')
			end
		else
			equip(set_combine(sets.refresh, sets.rest))
			if Debug == 'On' then
				add_to_chat(8,'[Equipped Set: Refresh + Rest]')
			end
		end
	elseif player.status == "Engaged" then
		if LowHP == true then --no matter what Mode we're in, if we have low HP we equip the Oh Shit gear set
			equip(sets.ohshit)
			if Debug == 'On' then
				add_to_chat(8,'[Equipped Set: Oh Shit]')
			end
		elseif DTOverride == 'On' then
			equip(set_combine(sets.dps, sets.dtoverride))
			if Debug == 'On' then
				add_to_chat(8,'[Equipped Set: DPS + DT Override]')
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
				add_to_chat(8,'[Equipped Set: DPS]')
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
				add_to_chat(8,'[Equipped Set: Idle + Adoulin]')
			end
		elseif BastokZones:contains(world.area) then
			equip(set_combine(sets.idle, sets.bastok))
			if Debug == 'On' then
				add_to_chat(8,'[Equipped Set: Idle + Bastok]')
			end
		elseif SandyZones:contains(world.area) then
			equip(set_combine(sets.idle, sets.sandoria))
			if Debug == 'On' then
				add_to_chat(8,'[Equipped Set: Idle + San d\'Oria]')
			end
		elseif WindyZones:contains(world.area) then
			equip(set_combine(sets.idle, sets.windurst))
			if Debug == 'On' then
				add_to_chat(8,'[Equipped Set: Idle + Windurst]')
			end
		elseif TownZones:contains(world.area) then
			equip(set_combine(sets.idle, sets.town))
			if Debug == 'On' then
				add_to_chat(8,'[Equipped Set: Idle + Town]')
			end
		elseif LuopanActive == true then
			if LowHP == true then --no matter what Mode we're in, if we have low HP we equip the Oh Shit gear set
				equip(set_combine(sets.luopan, sets.ohshit))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Luopan + Oh Shit]')
				end
			elseif DTOverride == "On" then
				equip(set_combine(sets.luopan, sets.dtoverride))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Luopan + DT Override]')
				end
			else
				equip(sets.luopan)
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Luopan]')
				end
			end
		else
			if LowHP == true then --no matter what Mode we're in, if we have low HP we equip the Oh Shit gear set
				equip(set_combine(sets.idle, sets.ohshit))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Idle + Oh Shit]')
				end
			elseif DTOverride == "On" then
				equip(set_combine(sets.idle, sets.dtoverride))
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Idle + DT Override]')
				end
			else
				equip(sets.idle)
				if Debug == 'On' then
					add_to_chat(8,'[Equipped Set: Idle]')
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
		if sets[spell.english] then
			equip(sets[spell.english])
			if Debug == 'On' then
				add_to_chat(8,'[Equipped Set: '..spell.english..']')
			end
		else
			equip(sets.ws)
			if Debug == 'On' then
				add_to_chat(8,'[Equipped Set: Weapon Skill - Basic]')
			end
		end
	elseif spell.english == 'Bolster' and windower.ffxi.get_ability_recasts()[0] < 2 then
		equip(sets.bolster)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Bolster]')
		end
	elseif spell.english == 'Full Circle' then
		equip(sets.fullcircle)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Full Circle]')
		end
	elseif spell.english == 'Radial Arcana' and windower.ffxi.get_ability_recasts()[252] < 2 then
		equip(sets.radialarcana)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Radial Arcana]')
		end
	elseif spell.english == 'Mending Halation' and windower.ffxi.get_ability_recasts()[251] < 2 then
		equip(sets.mendinghalation)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Mending Halation]')
		end
	elseif spell.english == 'Collimated Fervor' and windower.ffxi.get_ability_recasts()[245] < 2 then
		equip(sets.collimatedfervor)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Collimated Fervor]')
		end
	elseif spell.english == 'Life Cycle' and windower.ffxi.get_ability_recasts()[246] < 2 then
		equip(sets.lifecycle)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Life Cycle]')
		end
	elseif spell.english == 'Holy Water' then
		equip(sets.hwater)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Holy Water]')
		end
	elseif string.find(spell.english,'Geo-') and LuopanActive == true and AutoFullCircle == 'On' and windower.ffxi.get_ability_recasts()[243] == 0 then
		--if we're casting a Geo- spell with a Luopan already out, we'll use Full Circle instead
		send_command('input /ja "Full Circle" <me>;wait 1;input /ma '..spell.english..' '..spell.target.raw..'')
		cancel_spell()
		return

	elseif string.find(spell.english,'Indi-') then
		if AutoEntrust == 'On' and windower.ffxi.get_ability_recasts()[93] == 0 and spell.target.ispartymember == true and spell.target.type ~= 'SELF' then
			if UseEntrust == false then
				--if we're casting an Indi- spell on a party member without Entrust active we first make sure thats what we want to do instead of just using it immediately, this helps prevent misfires when someone casts on us right before
				add_to_chat(8,'AutoEntrust is now active. Repeat cast to use Entrust.')
				UseEntrust = true
				if Debug == 'On' then
					add_to_chat(8,'[UseEntrust set to True]')
				end
				send_command('text entrustlabel text "AutoEntrust Active";text entrustlabel color 255 255 50;text entrustlabel bg_transparency 1') --indicate that AutoEntrust is active
				send_command('wait 10;gs c CancelUseEntrust') --wait 10 seconds then we cancel UseEntrust if its still active
				cancel_spell()
				return
			elseif UseEntrust == true then
				--now that AutoEntrust was activated above, we can Do The Thing
				send_command('input /ja "Entrust" <me>;wait 1;input /ma '..spell.english..' '..spell.target.raw..'')
				UseEntrust = false
				if Debug == 'On' then
					add_to_chat(8,'[UseEntrust set to False]')
				end
				send_command('text entrustlabel text "Entrust";text entrustlabel color 255 255 255;text entrustlabel bg_transparency 1') --reset the label when we use AutoEntrust
				cancel_spell()
				return
			end
		elseif UseEntrust == true and spell.target.type == 'SELF' then
			--if we cast an Indi- spell on ourselves we reset UseEntrust back to false, this allows us to cancel the use of AutoEntrust and go through the double-check above again for next time
			UseEntrust = false
			if Debug == 'On' then
				add_to_chat(8,'[UseEntrust set to False]')
			end
			send_command('text entrustlabel text "Entrust";text entrustlabel color 255 255 255;text entrustlabel bg_transparency 1') --reset the label when we deactivate AutoEntrust
		end
	elseif (spell.english == 'Spectral Jig' or spell.english == 'Sneak' or spell.english == 'Monomi: Ichi' or spell.english == 'Monomi: Ni') and buffactive['Sneak'] and spell.target.type == 'SELF' then
		send_command('cancel 71')
	elseif spell.english == 'Fire' or spell.english == 'Blizzard' or spell.english == 'Aero' or spell.english == 'Stone' or spell.english == 'Thunder' or spell.english == 'Water' then
		equip(sets.Elemental)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Elemental]')
		end
	elseif not (string.find(spell.english,' Ring') or spell.english == 'Forbidden Key' or spell.english == 'Pickaxe' or spell.english == 'Sickle' or spell.english == 'Hatchet') then
		equip(sets.fastcast)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Fast Cast]')
		end
	end
end

-------------------------------------------
--               MIDCAST                 --
-------------------------------------------

function midcast(spell)
	if spell.type == 'Geomancy' then
		equip(sets.geomancy)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Geomancy]')
		end
	elseif spell.skill == 'Elemental Magic' and not (spell.english == 'Fire' or spell.english == 'Blizzard' or spell.english == 'Aero' or spell.english == 'Stone' or spell.english == 'Thunder' or spell.english == 'Water') then
		equip(sets.elemental)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Elemental]')
		end
	elseif spell.skill == 'Enfeebling Magic' then
		equip(sets.enfeeble)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Enfeeble]')
		end
	elseif spell.english == 'Refresh' then
		equip(set_combine(sets.buff, sets.refresh))
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Buff + Refresh]')
		end
	elseif spell.english == 'Cursna' then
		equip(sets.cursna)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Cursna]')
		end
	elseif string.find(spell.english,'Cur') and spell.type == "WhiteMagic" then
		equip(set_combine(sets.buff, sets.healing))
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Healing + Buff]')
		end
	elseif string.find(spell.english,'Aspir') or string.find(spell.english,'Drain') then
		equip(sets.aspirdrain)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Aspir/Drain]')
		end
	elseif string.find(spell.english,'Absorb') then
		equip(sets.magicaccuracy)
		if Debug == 'On' then
			add_to_chat(8,'[Equipped Set: Magic Accuracy]')
		end
	elseif spell.type == 'Trust' then
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
	if spell.type == 'Geomancy' and not spell.interrupted and LoadHUD == true then
		if string.find(spell.english,'Poison') then
			SpellSH = 'Poison'
		elseif string.find(spell.english,'Voidance') then
			SpellSH = 'Voidance (Eva Up)'
		elseif string.find(spell.english,'Precision') then
			SpellSH = 'Precision (Acc/RAcc Up)'
		elseif string.find(spell.english,'Regen') then
			SpellSH = 'Regen'
		elseif string.find(spell.english,'Attunement') then
			SpellSH = 'Attunement (MEva Up)'
		elseif string.find(spell.english,'Focus') then
			SpellSH = 'Focus (MAcc Up)'
		elseif string.find(spell.english,'Barrier') then
			SpellSH = 'Barrier (Def Up)'
		elseif string.find(spell.english,'Refresh') then
			SpellSH = 'Refresh'
		elseif string.find(spell.english,'CHR') then
			SpellSH = 'Charisma'
		elseif string.find(spell.english,'MND') then
			SpellSH = 'Mind'
		elseif string.find(spell.english,'Fury') then
			SpellSH = 'Fury (Att Up)'
		elseif string.find(spell.english,'INT') then
			SpellSH = 'Intelligence'
		elseif string.find(spell.english,'AGI') then
			SpellSH = 'Agility'
		elseif string.find(spell.english,'Fend') then
			SpellSH = 'Fend (MDef Up)'
		elseif string.find(spell.english,'VIT') then
			SpellSH = 'Vitality'
		elseif string.find(spell.english,'DEX') then
			SpellSH = 'Dexterity'
		elseif string.find(spell.english,'Acumen') then
			SpellSH = 'Acumen (MAtt Up)'
		elseif string.find(spell.english,'STR') then
			SpellSH = 'Strength'
		elseif string.find(spell.english,'Slow') then
			SpellSH = 'Slow'
		elseif string.find(spell.english,'Torpor') then
			SpellSH = 'Torpor (Eva Down)'
		elseif string.find(spell.english,'Slip') then
			SpellSH = 'Slip (Acc Down)'
		elseif string.find(spell.english,'Languor') then
			SpellSH = 'Languor (MEva Down)'
		elseif string.find(spell.english,'Paralysis') then
			SpellSH = 'Paralysis'
		elseif string.find(spell.english,'Vex') then
			SpellSH = 'Vex (MAcc Down)'
		elseif string.find(spell.english,'Frailty') then
			SpellSH = 'Frailty (Def Down)'
		elseif string.find(spell.english,'Precision') then
			SpellSH = 'Precision (Acc/Racc Up)'
		elseif string.find(spell.english,'Wilt') then
			SpellSH = 'Wilt (Att Down)'
		elseif string.find(spell.english,'Gravity') then
			SpellSH = 'Gravity'
		elseif string.find(spell.english,'Malaise') then
			SpellSH = 'Malaise (MDef Down)'
		elseif string.find(spell.english,'Haste') then
			SpellSH = 'Haste'
		elseif string.find(spell.english,'Fade') then
			SpellSH = 'Fade (MAtt Down)'
		end
		if string.find(spell.english,'Indi-') then
			if buffactive['Entrust'] then
				Entrust = SpellSH
				if Debug == 'On' then
					add_to_chat(8,'[Entrust set to '..SpellSH..']')
				end
				local Target = spell.target.name
				send_command('text entrustlabel text "Entrust - '..Target..'"')
				send_command('text entrust text "'..Entrust..'";text entrust color 75 255 75')
			else
				IndiColure = SpellSH
				if Debug == 'On' then
					add_to_chat(8,'[IndiColure set to '..SpellSH..']')
				end
				send_command('text indicolure text "'..IndiColure..'";text indicolure color 75 255 75')
			end
		elseif string.find(spell.english,'Geo-') then
			GeoColure = SpellSH
			if Debug == 'On' then
				add_to_chat(8,'[GeoColure set to SpellSH]')
			end
			send_command('wait 2;gs c Choose Set')
			--add in a 2 second wait after casting a Geo- spell because the choose_set function is called too quickly and the pet.isvalid hasn't had enough time to be set to true yet
		end
	elseif spell.english == 'Entrust' and not spell.interrupted and LoadHUD == true then
		EntrustCountdown = EntrustDuration
		if Debug == 'On' then
			add_to_chat(8,'[EntrustCountdown set to '..EntrustDuration..']')
		end
	elseif (spell.english == 'Lasting Emanation' or spell.english == 'Ecliptic Attrition') and not spell.interrupted and LoadHUD == true then
		EclipticActive = true
		if Debug == 'On' then
			add_to_chat(8,'[EclipticActive set to True]')
		end
	elseif spell.english == 'Dematerialize' and not spell.interrupted and LoadHUD == true then
		DematerializeActive = true
		if Debug == 'On' then
			add_to_chat(8,'[DematerializeActive set to True]')
		end
	elseif (spell.english == 'Full Circle' or spell.english == 'Concentric Pulse' or spell.english == 'Radial Arcana' or spell.english == 'Mending Halation') and not spell.interrupted and LoadHUD == true then
		send_command('text geocolure text "None";text geocolure color 255 50 50')
		LuopanActive = false
		if Debug == 'On' then
			add_to_chat(8,'[LuopanActive set to False]')
		end
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
end

-------------------------------------------
--             STATUS CHANGE             --
-------------------------------------------

function status_change(new,old)
	choose_set() --run this any time your status changes (engage, disengage, rest)
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
	if (buff == 2 or buff == 19) and buffactive['Stoneskin'] and not buffactive['Charm'] then --If we get slept, remove stoneskin if its on
		send_command('cancel 37')
	end
	if buff == 15 then --Doom
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
	end
	if buff == 17 and AlertSounds == 'On' then --Charm
		windower.play_sound(windower.addon_path..'data/sounds/Cancel.wav')
	end
	if buff == 612 and LoadHUD == true then --Colure Active
		send_command('text indicolure text "'..IndiColure..'";text indicolure color 75 255 75')
	end
	if buff == 71 or buff == 69 then --Sneak or Invisible
		send_command('gs c ClearNotifications')
	end
end)

windower.register_event('lose buff', function(buff)
	if buff == 251 and Alive == true and NotiFood == 'On' then --food wears off
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
	elseif buff == 612 and LoadHUD == true then
		send_command('text indicolure text "None";text indicolure color 255 50 50')
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
			send_command('text notifications text "«« 3000 TP »»";text notifications color 0 255 0;text notifications bg_transparency 1')
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

	--MP checks
	if NotiLowMP =='On' and player.mpp <= 20 and NotiLowMPToggle == 'Off' then
		NotiLowMPToggle = 'On' --turn the toggle on so this can't be triggered again until its toggled off (done below)
		if Debug == 'On' then
			add_to_chat(8,'[NotiLowMPToggle set to On]')
		end
		if AlertSounds == 'On' then
			windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav')
		end
		if LoadHUD == true then
			send_command('text notifications text "«« Low MP »»";text notifications color 255 50 50;text notifications bg_transparency 1')
			NotiCountdown = NotiDelay
			if Debug == 'On' then
				add_to_chat(8,'[NotiCountdown set to '..NotiDelay..']')
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
				add_to_chat(8,'[NotiCountdown set to -1]')
			end
			Alive = false
			if Debug == 'On' then
				add_to_chat(8,'[Alive set to False]')
			end
			Doom = false --turn this off so it doesn't trigger the "doom is off" notification once we raise
			if Debug == 'On' then
				add_to_chat(8,'[Doom set to False]')
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
			send_command('text notifications text "Status: Alive ^_^";text notifications color 75 255 75;text notifications bg_transparency 1')
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
		if LoadHUD == true then
			if EntrustCountdown > 0 then
				EntrustCountdown = EntrustCountdown -1
			elseif EntrustRecast > 0 then
				send_command('text entrust text "None";text entrust color 255 165 0')
				if UseEntrust == true then
					send_command('text entrustlabel text "AutoEntrust Activated"')
				else
					send_command('text entrustlabel text "Entrust"')
				end
			else
				send_command('text entrust text "None";text entrust color 255 50 50')
				if UseEntrust == true then
					send_command('text entrustlabel text "AutoEntrust Active"')
				else
					send_command('text entrustlabel text "Entrust"')
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
			if pet.isvalid == true then
				local petHPMeter = ""
				local spaces = math.floor(122 * (pet.hpp / 100))
				while string.len(petHPMeter) < spaces do
					petHPMeter = petHPMeter..' '
				end
				local color
				if pet.hpp <= 25 then
					color = PetHPMeter25color
				elseif pet.hpp <= 50 then
					color = PetHPMeter50color
				else
					color = PetHPMeter100color
				end
				send_command('text pethpmeter1 bg_transparency 100;text pethpmeter2 bg_transparency 100;text pethpmeter3 bg_transparency 100;text pethpmeter4 bg_transparency 100')
				send_command('text pethpmeter1 bg_color '..color..';text pethpmeter2 bg_color '..color..';text pethpmeter3 bg_color '..color..';text pethpmeter4 bg_color '..color..'')
				send_command('text pethpmeter1 text "'..petHPMeter..'";text pethpmeter2 text "'..petHPMeter..'";text pethpmeter3 text "'..petHPMeter..'";text pethpmeter4 text "'..petHPMeter..'"')
				send_command('text geocolurelabel text "Luopan - '..pet.hpp..'%"')
				send_command('text geocolure text "'..GeoColure..'";text geocolure color 0 255 0')
				LuopanActive = true
				if Debug == 'On' then
					add_to_chat(8,'[LuopanActive set to True]')
				end
			else
				send_command('text pethpmeter1 bg_transparency 1;text pethpmeter2 bg_transparency 1;text pethpmeter3 bg_transparency 1;text pethpmeter4 bg_transparency 1')
				send_command('text geocolurelabel text "Luopan"')
				send_command('text geocolure text "None";text geocolure color 255 50 50')
				LuopanActive = false
				BlazeActive = false
				DematerializeActive = false
				EclipticActive = false
				if Debug == 'On' then
					add_to_chat(8,'[LuopanActive set to False | BlazeActive set to False | DematerializeActive set to False | EclipticActive set to False]')
				end
			end
			if buffactive['Colure Active'] then
				send_command('text indicolure text "'..IndiColure..'";text indicolure color 0 255 0')
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
			--Recast updates:
			if player.main_job == 'GEO' then --This check prevents errors when these fire off for a second after you switch characters
				EntrustRecast = windower.ffxi.get_ability_recasts()[93]
				BlazeRecast = windower.ffxi.get_ability_recasts()[247]
				EclipticRecast = windower.ffxi.get_ability_recasts()[244]
				DematerializeRecast = windower.ffxi.get_ability_recasts()[248]
				LifeRecast = windower.ffxi.get_ability_recasts()[246]
				RadialRecast = windower.ffxi.get_ability_recasts()[252]
				MendingRecast = windower.ffxi.get_ability_recasts()[251]
			end
			--Recast color updates - decide the colors:
			if EntrustCountdown > 0 then EntrustColor = '75 255 75'
			elseif EntrustRecast < 2 and EntrustRecast ~= 0 then
				EntrustColor = '255 165 0'
				send_command('wait .25;text entrust color 255 255 125;wait .25;text entrust color 255 165 0;wait .25;text entrust color 255 255 125')
			elseif EntrustCountdown == 0 and EntrustRecast > 0 then EntrustColor = '255 165 0'
			else EntrustColor = '255 50 50'
			end
			if buffactive['Blaze of Glory'] then
				BlazeActive = true
			end
			if BlazeActive == true then BlazeColor = '75 255 75'
			elseif BlazeRecast < 2 and BlazeRecast ~= 0 then
				BlazeColor = '255 165 0'
				send_command('wait .25;text blaze color 255 255 125;wait .25;text blaze color 255 165 0;wait .25;text blaze color 255 255 125')
			elseif BlazeRecast == 0 then BlazeColor = '255 50 50'
			else BlazeColor = '255 165 0'
			end
			if EclipticActive == true then EclipticColor = '75 255 75'
			elseif EclipticRecast < 2 and EclipticRecast ~= 0 then
				EclipticColor = '255 165 0'
				send_command('wait .25;text ecliptic color 255 255 125;wait .25;text ecliptic color 255 165 0;wait .25;text ecliptic color 255 255 125')
			elseif EclipticRecast == 0 then EclipticColor = '255 50 50'
			else EclipticColor = '255 165 0'
			end
			if DematerializeActive == true then DematerializeColor = '75 255 75'
			elseif DematerializeRecast < 2 and DematerializeRecast ~= 0 then
				DematerializeColor = '255 165 0'
				send_command('wait .25;text dematerialize color 255 255 125;wait .25;text dematerialize color 255 165 0;wait .25;text dematerialize color 255 255 125')
			elseif DematerializeRecast == 0 then DematerializeColor = '255 50 50'
			else DematerializeColor = '255 165 0'
			end
			if LifeRecast == 0 then LifeColor = '255 50 50'
			elseif LifeRecast < 2 then
				LifeColor = '255 165 0'
				send_command('wait .25;text life color 255 255 125;wait .25;text life color 255 165 0;wait .25;text life color 255 255 125')
			else LifeColor = '255 165 0'
			end
			if RadialRecast == 0 then RadialColor = '255 50 50'
			elseif RadialRecast < 2 then
				RadialColor = '255 165 0'
				send_command('wait .25;text radial color 255 255 125;wait .25;text radial color 255 165 0;wait .25;text radial color 255 255 125')
			else RadialColor = '255 165 0'
			end
			if MendingRecast == 0 then MendingColor = '255 50 50'
			elseif MendingRecast < 2 then
				MendingColor = '255 165 0'
				send_command('wait .25;text mending color 255 255 125;wait .25;text mending color 255 165 0;wait .25;text mending color 255 255 125')
			else MendingColor = '255 165 0'
			end
			--Recast color updates - print the colors:
			send_command('text entrust color '..EntrustColor..'')
			send_command('text blaze color '..BlazeColor..'')
			send_command('text ecliptic color '..EclipticColor..'')
			send_command('text dematerialize color '..DematerializeColor..'')
			send_command('text life color '..LifeColor..'')
			send_command('text radial color '..RadialColor..'')
			send_command('text mending color '..MendingColor..'')
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
	if SubWHMPage ~= "Off" and newSubjob == 'WHM' then
		send_command('wait 2;input /macro set '..SubWHMPage..'')
	elseif SubRDMPage ~= "Off" and newSubjob == 'RDM' then
		send_command('wait 2;input /macro set '..SubRDMPage..'')
	elseif SubBLMPage ~= "Off" and newSubjob == 'BLM' then
		send_command('wait 2;input /macro set '..SubBLMPage..'')
	elseif SubSCHPage ~= "Off" and newSubjob == 'SCH' then
		send_command('wait 2;input /macro set '..SubSCHPage..'')
	else
		send_command('wait 2;input /macro set 1')
	end
end

-------------------------------------------
--        INCOMING TEXT CHECKS           --
-------------------------------------------

windower.register_event('incoming text',function(org)
	if org:find('Luopan') and org:find('Dematerialize') and org:find('effect wears off.')then
		DematerializeActive = false
		if Debug == 'On' then
			add_to_chat(8,'[DematerializeActive set to False]')
		end
	elseif org:find('wishes to trade with you') then
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
		send_command('text notifications text "«« Out Of Holy Waters »»";text notifications color 255 50 50;text notifications bg_transparency 1')
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
	local spells = require('resources').spells

	if NotiDamage == 'On' then
		--Weapon Skills and Skillchains:
		if act.category == 3 and act.actor_id == player.id then
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
		--Magic Bursts:
		elseif (act.category == 4 and act.targets[1].actions[1].message == 252) and act.actor_id == player.id then
			send_command('wait .2;text notifications text "Magic Burst! '..spells[act.param].english..': '..addCommas(act.targets[1].actions[1].param)..'";text notifications color 0 255 255;text notifications bg_transparency 1')
			NotiCountdown = -1
			if Debug == 'On' then
				add_to_chat(8,'[NotiCountdown set to -1]')
			end
		end
	end
end)

-------------------------------------------
--             FILE UNLOAD               --
-------------------------------------------

function file_unload()
	send_command('wait 1;text pethpmeter1 delete;text pethpmeter2 delete;text pethpmeter3 delete;text pethpmeter4 delete;text bg1 delete;text bg2 delete;text bg3 delete;text bg4 delete;text indicolure delete;text indicolurelabel delete;text geocolure delete;text geocolurelabel delete;text entrust delete;text entrustlabel delete;text blaze delete;text ecliptic delete;text dematerialize delete;text life delete;text radial delete;text mending delete;text loading delete;text notifications delete;text debuffs delete') --delete the different text objects
end
