--Copyright (c) 2025, Key
--All rights reserved.

--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:

--    * Redistributions of source code must retain the above copyright
--      notice, this list of conditions and the following disclaimer.
--    * Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in the
--      documentation and/or other materials provided with the distribution.
--    * Neither the name of Helper nor the
--      names of its contributors may be used to endorse or promote products
--      derived from this software without specific prior written permission.

--THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
--ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
--WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
--DISCLAIMED. IN NO EVENT SHALL Key BE LIABLE FOR ANY
--DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
--(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
--LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
--ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
--(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
--SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

_addon.name = 'Helper'
_addon.version = '1.7'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'helper'}

config = require('config')
packets = require('packets')
res = require('resources')
require 'chat'
math.randomseed(os.time())

local get_mob_by_id = windower.ffxi.get_mob_by_id
local get_player = windower.ffxi.get_player
local get_party = windower.ffxi.get_party
local add_to_chat = windower.add_to_chat
local get_info = windower.ffxi.get_info
local register_event = windower.register_event
local file_exists = windower.file_exists
local addon_path = windower.addon_path
local play_sound = windower.play_sound

defaults = {
	addon_sha = nil,
	first_run = true,
	have_key_item = {
		canteen = false,
		moglophone = false,
		plate = false,
	},
	timestamps = {
		canteen = 0,
		last_check = 0,
		moglophone = 0,
		mog_locker_expiration = 0,
		mog_locker_reminder = 0,
		plate = 0,
		sparkolades = 0,
	},
	options = {
		ability_ready = {
			bestial_loyalty = true,
			blaze_of_glory = true,
			call_wyvern = true,
			chivalry = true,
			convergence = true,
			convert = true,
			crooked_cards = true,
			dematerialize = true,
			devotion = true,
			diffusion = true,
			divine_seal = true,
			elemental_seal = true,
			embolden = true,
			enmity_douse = true,
			entrust = true,
			fealty = true,
			flashy_shot = true,
			formless_strikes = true,
			life_cycle = true,
			mana_wall = true,
			manawell = true,
			marcato = true,
			martyr = true,
			nightingale = true,
			random_deal = true,
			restraint = true,
			sacrosanctity = true,
			sp1 = true,
			sp2 = true,
			spontaneity = true,
			tame = true,
			troubadour = true,
		},
		after_zone_party_check_delay_seconds = 6,
		auto_check_for_updates = true,
		auto_update = false,
		check_party_for_low_mp = true,
		check_party_for_low_mp_delay_minutes = 15,
		current_helper = "Vana",
		flavor_text = true,
		flavor_text_window_max_hours = 4,
		flavor_text_window_min_hours = 2,
		helpers_loaded = {vana = true},
		introduce_on_load = true,
		key_item_reminders = {
			canteen = true,
			canteen_repeat_hours = 12,
			moglophone = true,
			moglophone_repeat_hours = 6,
			plate = true,
			plate_repeat_hours = 6,
		},
		notifications = {
			capped_job_points = true,
			capped_merit_points = true,
			food_wears_off = true,
			mireu_popped = true,
			mog_locker_expiring = true,
			reraise_wears_off = true,
			signet_wears_off = true,
			sublimation_charged = true,
			vorseal_wearing = true,
		},
		party_announcements = {
			member_joined_party = true,
			member_left_party = true,
			member_joined_alliance = true,
			member_left_alliance = true,
			you_joined_party = true,
			you_left_party = true,
			you_joined_alliance = true,
			you_left_alliance = true,
			your_party_joined_alliance = true,
			your_party_left_alliance = true,
			other_party_joined_alliance = true,
			other_party_left_alliance = true,
			you_are_now_alliance_leader = true,
			you_are_now_party_leader = true,
		},
		reraise_check = true,
		reraise_check_delay_minutes = 60,
		reraise_check_not_in_town = true,
		sound_effects = true,
		sparkolade_reminder = true,
		sparkolade_reminder_day = "Saturday",
		sparkolade_reminder_time = 1200,
		voices = false,
	},
}

helpers = {}
--Vana is the default Helper
vana = {
	info = {
		name = "Vana",
		introduction = "I am Vana, your personal Helper.",
		description = "Friendly, encouraging, and always positive.",
		name_color = 39,
		text_color = 220,
		type = "NPC",
		sha = nil,
	},
	flavor_text = {
		"You have a great sense of humor.",
		"You're a great listener.",
		"You light up the room.",
		"Your creativity is inspiring.",
		"You have a contagious smile.",
		"Your positivity is infectious.",
		"You bring out the best in people.",
		"You have a heart of gold.",
		"You're a wonderful friend.",
		"Your enthusiasm is refreshing.",
		"You're incredibly thoughtful.",
		"You have a fantastic sense of lockstyle.",
		"You always make people feel welcome.",
		"You're full of great ideas.",
		"You have an amazing work ethic.",
		"Your confidence is inspiring.",
		"You're always so helpful.",
		"Your job mastery is impressive-you're a true expert!",
		"You always know how to strategize perfectly in battle.",
		"Your gear is top-notch; you really know how to optimize your character!",
		"You're always there to back up the party when things get tough.",
		"You make raids and missions look easy.",
		"Your timing with abilities is flawless.",
		"The way you handle aggro is amazing-you never let us down.",
		"Your knowledge of the game is outstanding.",
		"You're the glue that holds this alliance together.",
		"Your dedication to leveling your job is truly inspiring.",
		"Your DPS output is insane; you're a powerhouse in every fight.",
		"You're so good at coordinating group tactics and keeping us organized.",
		"The way you manage your macros is super smooth-never a missed step.",
		"You always find the perfect balance between offense and defense.",
		"Your ability to multi-task in intense fights is amazing.",
		"You're always up for helping others; you're a true team player.",
		"You look stunning in that lockstyle.",
	},
	ability_ready = "${ability} is ready to use again.",
	capped_job_points = "Your Job Points are now capped.",
	capped_merit_points = "Your Merit Points are now capped.",
	food_wears_off = "Your food has worn off.",
	mog_locker_expiring = "Your Mog Locker lease is expiring soon.",
	reminder_canteen = "Another Mystical Canteen should be available now.",
	reminder_moglophone = "Another Moglophone should be available now.",
	reminder_plate = "Another Shiny Ra'Kaznarian Plate should be available now.",
	party_low_mp = "It looks like ${member} could use a ${refresh}.",
	reraise_check = "You do not have Reraise on.",
	reraise_wears_off = "Your Reraise effect has worn off.",
	signet_wears_off = "Your ${signet} effect has worn off.",
	sparkolade_reminder = "Don't forget to spend your Sparkolades.",
	sublimation_charged = "Sublimation is now fully charged and ready to use.",
	mireu_popped = "Mireu was just mentioned in ${zone}.",
	member_joined_party = "${member} has joined the party.",
	member_left_party = "${member} has left the party.",
	member_joined_alliance = "${member} has joined the alliance.",
	member_left_alliance = "${member} has left the alliance.",
	you_joined_party = "You have joined a party.",
	you_left_party = "You have left the party.",
	you_joined_alliance = "You have joined an alliance.",
	you_left_alliance = "You have left the alliance.",
	your_party_joined_alliance = "Your party has joined an alliance.",
	your_party_left_alliance = "Your party has left the alliance.",
	other_party_joined_alliance = "A party has joined the alliance.",
	other_party_left_alliance = "A party has left the alliance.",
	you_are_now_alliance_leader = "You are now the alliance leader.",
	you_are_now_party_leader = "You are now the party leader.",
	vorseal_wearing = "You have about 10 minutes left on your Vorseal effect.",
}

settings = config.load(defaults)
helpers.vana = config.load('data/helpers/Vana.xml', vana)

local current_helper = string.lower(settings.options.current_helper)
local c_name
local c_text

local addon_sha = settings.addon_sha
local first_run = settings.first_run
local have_key_item = settings.have_key_item
local timestamps = settings.timestamps

local ability_ready = settings.options.ability_ready
local after_zone_party_check_delay_seconds = math.floor(settings.options.after_zone_party_check_delay_seconds)
local auto_check_for_updates = settings.options.auto_check_for_updates
local auto_update = settings.options.auto_update
local check_party_for_low_mp = settings.options.check_party_for_low_mp
local check_party_for_low_mp_delay_minutes = math.floor(settings.options.check_party_for_low_mp_delay_minutes * 60)
local capped_job_points = settings.options.notifications.capped_job_points
local capped_merit_points = settings.options.notifications.capped_merit_points
local flavor_text = settings.options.flavor_text
local flavor_text_window_max_hours = math.floor(settings.options.flavor_text_window_max_hours * 60 * 60)
local flavor_text_window_min_hours = math.floor(settings.options.flavor_text_window_min_hours * 60 * 60)
local food_wears_off = settings.options.notifications.food_wears_off
local helpers_loaded = settings.options.helpers_loaded
local introduce_on_load = settings.options.introduce_on_load
local key_item_reminders = settings.options.key_item_reminders
local mireu_popped = settings.options.notifications.mireu_popped
local mog_locker_expiring = settings.options.notifications.mog_locker_expiring
local party_announcements = settings.options.party_announcements
local reraise_check = settings.options.reraise_check
local reraise_check_delay_minutes = math.floor(settings.options.reraise_check_delay_minutes * 60)
local reraise_check_not_in_town = settings.options.reraise_check_not_in_town
local reraise_wears_off = settings.options.notifications.reraise_wears_off
local signet_wears_off = settings.options.notifications.signet_wears_off
local sound_effects = settings.options.sound_effects
local sparkolade_reminder = settings.options.sparkolade_reminder
local sublimation_charged = settings.options.notifications.sublimation_charged
local vorseal_wearing = settings.options.notifications.vorseal_wearing
local voices = settings.options.voices

local check_party_for_low_mp_countdown = 0
local check_party_for_low_mp_toggle = true

local flavor_text_countdown = math.floor(math.random(flavor_text_window_min_hours,flavor_text_window_max_hours))
local mireu_countdown = 0
local vorseal_countdown = -1
local reraise_countdown = reraise_check_delay_minutes

local ready = {
	bestial_loyalty = true,
	blaze_of_glory = true,
	call_wyvern = true,
	chivalry = true,
	convergence = true,
	convert = true,
	crooked_cards = true,
	dematerialize = true,
	devotion = true,
	diffusion = true,
	divine_seal = true,
	elemental_seal = true,
	embolden = true,
	enmity_douse = true,
	entrust = true,
	fealty = true,
	flashy_shot = true,
	formless_strikes = true,
	life_cycle = true,
	mana_wall = true,
	manawell = true,
	marcato = true,
	martyr = true,
	nightingale = true,
	random_deal = true,
	restraint = true,
	sacrosanctity = true,
	sp1 = true,
	sp2 = true,
	spontaneity = true,
	tame = true,
	troubadour = true,
}
local ability_name = {
	bestial_loyalty = "Bestial Loyalty",
	blaze_of_glory = "Blaze of Glory",
	call_wyvern = "Call Wyvern",
	chivalry = "Chivalry",
	convergence = "Convergence",
	convert = "Convert",
	crooked_cards = "Crooked Cards",
	dematerialize = "Dematerialize",
	devotion = "Devotion",
	diffusion = "Diffusion",
	divine_seal = "Divine Seal",
	elemental_seal = "Elemental Seal",
	embolden = "Embolden",
	enmity_douse = "Enmity Douse",
	entrust = "Entrust",
	fealty = "Fealty",
	flashy_shot = "Flashy Shot",
	formless_strikes = "Formless Strikes",
	life_cycle = "Life Cycle",
	mana_wall = "Mana Wall",
	manawell = "Manawell",
	marcato = "Marcato",
	martyr = "Martyr",
	nightingale = "Nightingale",
	random_deal = "Random Deal",
	restraint = "Restraint",
	sacrosanctity = "Sacrosanctity",
	sp1 = "SP1",
	sp2 = "SP2",
	spontaneity = "Spontaneity",
	tame = "Tame",
	troubadour = "Troubadour",
}
local recast = {}
local party_structure = {}
local heartbeat = 0
local in_party = false
local in_alliance = false
local party_leader = false
local alliance_leader = false
local limit_points = 0
local merit_points = 0
local max_merit_points = 0
local capped_merits = true
local cap_points = 0
local job_points = 500
local capped_jps = true
local zoning = false
local paused = false
local alive = true
local new_updates = false

--Update the party/alliance structure
local function updatePartyStructure()

	-- Get the current party data
	local current_party = get_party()

	local new_party_structure = {
		alliance_leader = nil,
		party1_leader = nil,
		party2_leader = nil,
		party3_leader = nil,
		party1_count = nil,
		party2_count = nil,
		party3_count = nil,
		p0 = nil, p1 = nil, p2 = nil, p3 = nil, p4 = nil, p5 = nil,
		a10 = nil, a11 = nil, a12 = nil, a13 = nil, a14 = nil, a15 = nil,
		a20 = nil, a21 = nil, a22 = nil, a23 = nil, a24 = nil, a25 = nil
	}

	-- List of positions to iterate over in the current_party table
	local all_positions = {
		'p0', 'p1', 'p2', 'p3', 'p4', 'p5',
		'a10', 'a11', 'a12', 'a13', 'a14', 'a15',
		'a20', 'a21', 'a22', 'a23', 'a24', 'a25',
	}

	-- Fill the new_party_structure table with player names
	for _, position in ipairs(all_positions) do
		local name = current_party[position] and current_party[position].name or nil
		if name then
			new_party_structure[position] = name
		end
	end

	-- Fill leader positions in new_party_structure
	new_party_structure.alliance_leader = current_party.alliance_leader
	new_party_structure.party1_leader = current_party.party1_leader
	new_party_structure.party2_leader = current_party.party2_leader
	new_party_structure.party3_leader = current_party.party3_leader
	new_party_structure.party1_count = current_party.party1_count
	new_party_structure.party2_count = current_party.party2_count
	new_party_structure.party3_count = current_party.party3_count

	return new_party_structure

end

local function firstRun()

	-- Exit if this isn't the first run
	if not first_run then return end

	first_run = false
	settings.first_run = false
	settings:save('all')

	add_to_chat(8,('[Helper] '):color(220)..('Thank you for installing Helper.'):color(8))
	coroutine.sleep(1)

	add_to_chat(8,('[Helper] '):color(220)..('Type '):color(8)..('//helper update '):color(1)..('to make sure Helper is up to date with all files.'):color(8))
	coroutine.sleep(1)

	add_to_chat(8,('[Helper] '):color(220)..('Type '):color(8)..('//helper help '):color(1)..('at any time to view the list of commands.'):color(8))
	coroutine.sleep(1)

	add_to_chat(8,('[Helper] '):color(220)..('I hope you enjoy!  -Key'):color(8))
	coroutine.sleep(1)

end

--Set the Sparkolade reminder timestamp
local function setSparkoladeReminderTimestamp()

	local days_of_week = {
		sunday = 1, sun = 1, su = 1,
		monday = 2, mon = 2, mo = 2,
		tuesday = 3, tue = 3, tues = 3, tu = 3,
		wednesday = 4, wed = 4, weds = 4, we = 4,
		thursday = 5, thurs = 5, thu = 5, th = 5,
		friday = 6, fri = 6, fr = 6,
		saturday = 7, sat = 7, sa = 7,
	}

	-- Get user-configured day and time, default to "Monday 12:00"
	local day_input = (settings.options.sparkolade_reminder_day or "Saturday"):lower()
	local time_input = tonumber(settings.options.sparkolade_reminder_time) or 1200

	-- Convert the input day to a numeric day of the week
	local target_day = days_of_week[day_input]

	-- Ensure time_input is in valid military time format (HHMM)
	local hour = math.floor(time_input / 100)  -- Extract hours
	local minute = time_input % 100  -- Extract minutes
	if hour < 0 or hour > 23 then
		hour = 12
	end
	if minute < 0 or minute > 59 then
		minute = 0
	end

	-- Convert to number
	hour = tonumber(hour) or 0
	minute = tonumber(minute) or 0

	-- Get current date/time
	local now = os.time()
	local now_table = os.date("*t", now)
	local today = now_table.wday  -- Lua weeks start on Sunday (1)

	-- Correct the day adjustment logic
	local days_until_next = (target_day - today + 7) % 7
	
	-- If today is the target day but the time has passed, move to next week
	if days_until_next == 0 and (now_table.hour > hour or (now_table.hour == hour and now_table.min >= minute)) then
		days_until_next = 7
	end

    -- Use `os.time()` to properly roll over months and years
    local future_time = now + (days_until_next * 86400)  -- Add days in seconds
    local reminder_table = os.date("*t", future_time)  -- Get the correct date

    -- Set the exact reminder time
    reminder_table.hour = hour
    reminder_table.min = minute
    reminder_table.sec = 0

    -- Convert back to a timestamp
    local reminder_time = os.time(reminder_table)

    -- Save the new timestamp
    settings.timestamps = settings.timestamps or {}
    settings.timestamps.sparkolades = reminder_time
    settings:save('all')

end

--Get the correct Helper
local function getHelper()
	
	if voices then

		local active_helpers = {}
		for name, enabled in pairs(helpers_loaded) do
			if enabled then
				table.insert(active_helpers, name)
			end
		end

		local random_helper = active_helpers[math.random(#active_helpers)]
		local selected_helper = {
			helper = random_helper,
			name = helpers[random_helper].info.name,
			c_name = helpers[random_helper].info.name_color,
			c_text = helpers[random_helper].info.text_color,
		}

		return selected_helper

	else

		local selected_helper = {
			helper = current_helper,
			name = helpers[current_helper].info.name,
			c_name = helpers[current_helper].info.name_color,
			c_text = helpers[current_helper].info.text_color,
		}

		return selected_helper

	end
end

local function checkSparkoladeReminder()

	if not sparkolade_reminder or not settings.timestamps or not settings.timestamps.sparkolades then
		return
	end

	local current_time = os.time()

	--Check if the reminder time has passed
	if current_time >= settings.timestamps.sparkolades then

		if settings.timestamps.sparkolades ~= 0 then

			local selected = getHelper()
			local text = helpers[selected.helper].sparkolade_reminder
			if text then

				add_to_chat(selected.c_text, ('[' .. selected.name .. '] '):color(selected.c_name) .. (text):color(selected.c_text))

				--Play sound if enabled
				if sound_effects then 
					play_sound(addon_path..'data/sounds/notification.wav') 
				end

			end

		end

		--Set the next reminder
		setSparkoladeReminderTimestamp()

	end
end

--Determine starting states
local function initialize()

	limit_points = 0
	merit_points = 0
	max_merit_points = 0
	capped_merits = true
	cap_points = 0
	job_points = 500
	capped_jps = true

	--Update the party/alliance structure
	party_structure = updatePartyStructure()
	in_alliance = false
	if get_party().alliance_leader then
		in_alliance = true
		in_party = true
		if get_party().alliance_leader == get_player().id then
			alliance_leader = true
			party_leader = true
		end
	end
	if not in_alliance then
		in_party = false
		if get_party().party1_leader then
			in_party = true
			if get_party().party1_leader == get_player().id then
				party_leader = true
			end
		end
	end
	zoning = false

	--Load up the Helpers we have enabled
	for name, enabled in pairs(helpers_loaded) do
		if enabled then
			if file_exists(addon_path..'data/helpers/'..name..'.xml') then
				helpers[name] = config.load('data/helpers/'..name..'.xml')
			--If the file doesn't exist, unload the Helper
			else
				helpers_loaded[name] = nil
				--If the current Helper is the one we just unloaded, switch to Vana
				if settings.options.current_helper == name then
					settings.options.current_helper = 'vana'
					current_helper = 'vana'
				end
				add_to_chat(8,('[Helper] '):color(220)..('File '):color(8)..('data/'..name):color(1)..(' does not exist - unloaded from the addon.'):color(8))
				settings:save('all')
			end
		end
	end

	--Check if we've passed the Sparkolade reminder timestamp while logged out
	coroutine.schedule(function()
		checkSparkoladeReminder()
	end, 5)

end

--Get a list of local Helper files
local function getLocalHelpers()

	local local_helpers = {}

	--Check for known helper files by iterating over the loaded list
	for name, _ in pairs(helpers_loaded) do
		local file_name = "data/helpers/" .. name .. ".xml"
		if file_exists(addon_path .. file_name) then
			local_helpers[name] = true
		end
	end

	return local_helpers

end

--Get list of helpers from GitHub
local function getGitHubHelpers()

	local request_url = "https://api.github.com/repos/iLVL-Key/FFXI/contents/addons/Helper/data/helpers"

	-- Use curl to fetch GitHub API response directly into a Lua variable
	local response = io.popen(string.format('curl -s -L -H "User-Agent: Windower-Helper-Addon" "%s"', request_url)):read("*all")

	-- Ensure response was received
	if not response or response == "" then
		return nil
	end

	-- Extract file_names using Lua pattern matching
	local github_helpers = {}
	for file_name in response:gmatch('"name"%s*:%s*"([^"]+%.xml)"') do
		local name = file_name:gsub("%.xml$", "")
		github_helpers[name] = true
	end

	return github_helpers

end

--Check for new helpers on GitHub
local function checkForNewHelpers()

	local local_helpers = getLocalHelpers()
	local github_helpers = getGitHubHelpers()

	if not github_helpers then
		add_to_chat(8,('[Helper] '):color(220)..('Could not retrieve list of Helpers from GitHub. Please try again.'):color(8))
		return
	end

	--Find new helpers that exist on GitHub but not locally
	local new_helpers = {}
	for file_name in pairs(github_helpers) do
		if not local_helpers[string.lower(file_name)] then
			table.insert(new_helpers, file_name)
		end
	end

	-- Notify the user of new Helpers
	if #new_helpers > 0 then
		add_to_chat(8,('[Helper] '):color(220)..('New %s available: '):color(6):format(#new_helpers == 1 and 'Helper' or 'Helpers'))
		for _, helper in ipairs(new_helpers) do
			add_to_chat(8,(' - '):color(8)..(helper):color(1))
		end
		new_updates = true
	else
		add_to_chat(8,('[Helper] '):color(220)..('No new Helpers available.'):color(28))
	end

end

--Get the SHA of the Helper.lua file on GitHub
local function getGitHubAddonSHA()

	local request_url = "https://api.github.com/repos/iLVL-Key/FFXI/contents/addons/Helper/Helper.lua"

	-- Fetch GitHub API response directly into a Lua variable
	local response = io.popen(string.format('curl -s -L -H "User-Agent: Windower-Helper-Addon" "%s"', request_url)):read("*all")

	-- Ensure response was received
	if not response or response == "" then
		return nil
	end

	-- Extract SHA using Lua pattern matching
	local helper_sha = response:match('"sha"%s*:%s*"([^"]+)"')

	return helper_sha or nil

end

--Check for updates to the Helper addon
local function checkForAddonUpdates()

	-- Retrieve the latest SHA from GitHub
	local github_addon_sha = getGitHubAddonSHA()

	if not github_addon_sha then
		add_to_chat(8,('[Helper] '):color(220)..('Could not retrieve Helper addon version info from GitHub. Please try again.'):color(8))
		return
	end

	-- Retrieve the locally stored SHA
	local local_addon_sha = addon_sha

	-- Compare SHAs
	if local_addon_sha and local_addon_sha == github_addon_sha then
		add_to_chat(8,('[Helper] '):color(220)..('No Helper addon update available.'):color(28))
	else
		add_to_chat(8,('[Helper] '):color(220)..('Helper addon update available!'):color(6))
		new_updates = true
	end

end

--Update the SHA tag of a downloaded Helper
local function updateHelperSHA(file_name, new_sha)

	local filepath = addon_path .. "data/helpers/" .. file_name

	-- Read XML file
	local file = io.open(filepath, "r")
	if not file then return end
	local content = file:read("*all")
	file:close()

	-- Check if SHA tag already exists
	if content:match("<sha>.-</sha>") then
		-- Replace existing SHA
		content = content:gsub("<sha>.-</sha>", "<sha>" .. new_sha .. "</sha>")
	else
		-- Insert new SHA tag inside <info>
		content = content:gsub("(<info>.-)</info>", "%1\n    <sha>" .. new_sha .. "</sha>\n</info>")
	end

	-- Save updated XML
	local name = string.lower(file_name:gsub("%.xml$", ""))
	helpers[name].info.sha = new_sha
	helpers[name]:save('all')

end

--Uopdate the SHA tag of the Helper.lua file
local function updateAddonSHA(new_sha)
	settings.addon_sha = new_sha
	settings:save('all')
end

--Retrieve the SHAs of the Helper files on GitHub
local function getGitHubHelperSHAs()

	local request_url = "https://api.github.com/repos/iLVL-Key/FFXI/contents/addons/Helper/data/helpers"

	-- Fetch GitHub API response directly into a Lua variable
	local response = io.popen(string.format('curl -s -L -H "User-Agent: Windower-Helper-Addon" "%s"', request_url)):read("*all")

	-- Ensure response was received
	if not response or response == "" then
		return nil
	end

	-- Extract SHAs using Lua pattern matching
	local github_helper_shas = {}
	for file_name, sha in response:gmatch('"name"%s*:%s*"([^"]+%.xml)",.-"sha"%s*:%s*"([^"]+)"') do
		local name = file_name:gsub("%.xml$", ""):lower()
		github_helper_shas[name] = {
			sha = sha,
			file_name = file_name,
		}
	end

	return github_helper_shas

end

--Check for updates to the Helpers
local function checkForHelperUpdates()

	local github_helper_shas = getGitHubHelperSHAs()

	if not github_helper_shas then
		add_to_chat(8,('[Helper] '):color(220)..('Could not retrieve version info for Helpers from GitHub. Please try again.'):color(8))
		return
	end

	local updated_helpers = {}

	-- Loop through loaded Helpers and compare SHAs
	for name, helper in pairs(helpers) do
		local local_sha = helper.info and helper.info.sha
		local github_sha = github_helper_shas[name].sha
		
		-- If SHA is different or missing locally, mark as updated
		if github_sha and (not local_sha or local_sha ~= github_sha) then
			name = string.lower(name)
			local helper_name = helpers[name].info.name
			table.insert(updated_helpers, helper_name)
		end
	end

	-- Notify the user about updates
	if #updated_helpers > 0 then
		add_to_chat(8,('[Helper] '):color(220)..('Updated %s available: '):color(6):format(#updated_helpers == 1 and 'Helper' or 'Helpers'))
		for _, helper in ipairs(updated_helpers) do
			add_to_chat(8,(' - '):color(8)..(helper):color(1))
		end
		new_updates = true
	else
		add_to_chat(8,('[Helper] '):color(220)..('No updated Helpers available.'):color(28))
	end

end

--Download a Helper from GitHub
local function downloadHelper(file_name, github_helper_sha)

	local url = "https://raw.githubusercontent.com/iLVL-Key/FFXI/main/addons/Helper/data/helpers/" .. file_name
	local filepath = addon_path .. "data/helpers/" .. file_name

	-- Download the file
	local curl_command = string.format('curl -s -L -o "%s" "%s"', filepath, url)
	os.execute(curl_command)

	--Update the Helper table
	local name = string.lower(file_name:gsub("%.xml$", ""))
	helpers[name] = config.load('data/helpers/'..file_name)
	helpers_loaded[name] = true
	settings:save('all')

	--Update the Helper SHA
	updateHelperSHA(file_name, github_helper_sha)

end

--Download the latest version of Helper.lua from GitHub
local function downloadAddon(github_addon_sha)

	-- Define the download URL and destination path
	local url = "https://raw.githubusercontent.com/iLVL-Key/FFXI/main/addons/Helper/Helper.lua"
	local filepath = addon_path .. "Helper.lua"

	-- Download the file
	local curl_command = string.format('curl -s -L -o "%s" "%s"', filepath, url)
	os.execute(curl_command)

	-- Update the stored SHA after successful download
	updateAddonSHA(github_addon_sha)

	add_to_chat(8,('[Helper] '):color(220)..('Helper addon updated. Reloading...'):color(8))
	windower.send_command('lua r helper')

end

--Update any current Helpers that have been changed on GitHub
local function updateCurrentHelpers()

	local github_helper_shas = getGitHubHelperSHAs()

	if not github_helper_shas then
		add_to_chat(8,('[Helper] '):color(220)..('Could not retrieve version info for Helpers from GitHub. Please try again.'):color(8))
		return
	end

	local updated_helpers = {}

	for name, github_helper_info in pairs(github_helper_shas) do

		local file_name = github_helper_info.file_name
		local github_helper_sha = github_helper_info.sha
		name = string.lower(name)
		local local_helper_sha = helpers[name] and helpers[name].info and helpers[name].info.sha

		-- Check if the Helper exists and has an outdated SHA or if local_helper_sha is nil
		if not local_helper_sha or local_helper_sha ~= github_helper_sha then
			downloadHelper(file_name, github_helper_sha)
			table.insert(updated_helpers, file_name)
		end
	end

	if #updated_helpers > 0 then
		add_to_chat(8,('[Helper] '):color(220)..('Updated %s:'):color(6):format(#updated_helpers == 1 and 'Helper' or 'Helpers'))
		for _, helper in ipairs(updated_helpers) do
			add_to_chat(8,(' - '):color(8)..(helper):color(1))
		end
	else
		add_to_chat(8,('[Helper] '):color(220)..('No updated Helpers available.'):color(28))
	end

end

--Download any new Helpers from GitHub
local function downloadNewHelpers()

	local github_helper_shas = getGitHubHelperSHAs()

	if not github_helper_shas then
		add_to_chat(8,('[Helper] '):color(220)..('Could not retrieve version info for Helpers from GitHub. Please try again.'):color(8))
		return
	end

	local new_helpers = {}

	for name, github_helper_info in pairs(github_helper_shas) do
		local file_name = github_helper_info.file_name
		name = string.lower(name)
		local file_path = windower.addon_path .. 'data/helpers/' .. name .. '.xml'

		-- Check if the Helper file exists
		if not file_exists(file_path) then
			downloadHelper(file_name, github_helper_info.sha)
			table.insert(new_helpers, file_name)
		end
	end

	if #new_helpers > 0 then
		add_to_chat(8,('[Helper] '):color(220)..('New %s:'):color(6):format(#new_helpers == 1 and 'Helper' or 'Helpers'))
		for _, helper in ipairs(new_helpers) do
			add_to_chat(8,(' - '):color(8)..(helper):color(1))
		end
	else
		add_to_chat(8,('[Helper] '):color(220)..('No new Helpers available.'):color(28))
	end

end

--Check for missing sound files
local function checkAndDownloadSounds()
	local sound_folder = windower.addon_path .. "data/sounds/"
	
	--Ensure the data/sounds folder exists
	if not windower.dir_exists(sound_folder) then
		windower.create_dir(sound_folder)
	end

	--List of required sound files
	local sound_files = {
		"ability_ready.wav",
		"member_joined_party.wav",
		"member_left_party.wav",
		"notification.wav",
		"now_alliance_leader.wav",
		"now_party_leader.wav",
		"party_joined_alliance.wav",
		"party_left_alliance.wav"
	}

	--Base URL for sound files on GitHub
	local base_url = "https://raw.githubusercontent.com/iLVL-Key/FFXI/main/addons/Helper/data/sounds/"

	--Check each sound file
	for _, filename in ipairs(sound_files) do
		local file_path = sound_folder .. filename

		--If the file does not exist, download it
		if not windower.file_exists(file_path) then

			local download_url = base_url .. filename
			local curl_command = string.format('start /B curl -s -L -o "%s" "%s"', file_path, download_url)
			os.execute(curl_command)

		end
	end
end

--Check for updated addon on GitHub
local function updateAddon()

	--Make sure all sound files are present
	checkAndDownloadSounds()

	local local_addon_sha = addon_sha
	local github_addon_sha = getGitHubAddonSHA()

	if not github_addon_sha then
		add_to_chat(8,('[Helper] '):color(220)..('Could not retrieve Helper addon version info from GitHub. Please try again.'):color(8))
		return
	end

	if not local_addon_sha or local_addon_sha ~= github_addon_sha then
		downloadAddon(github_addon_sha)
	else
		add_to_chat(8,('[Helper] '):color(220)..('No Helper addon update available.'):color(28))
	end
end

--Save the time of the last check
local function saveLastCheckTime()
	timestamps.last_check = os.time()
	settings:save('all')
end

--Update everything
local function updateAll()

	add_to_chat(8,('[Helper] '):color(220)..('Downloading new Helpers...'):color(8))
	coroutine.sleep(1)
	downloadNewHelpers()

	add_to_chat(8,('[Helper] '):color(220)..('Updating current Helpers...'):color(8))
	coroutine.sleep(1)
	updateCurrentHelpers()

	add_to_chat(8,('[Helper] '):color(220)..('Updating Helper addon...'):color(8))
	coroutine.sleep(1)
	updateAddon()

	saveLastCheckTime()

end

--Check for updates to everything
local function checkAll()

	add_to_chat(8,('[Helper] '):color(220)..('Checking for new Helpers...'):color(8))
	coroutine.sleep(1)
	checkForNewHelpers()

	add_to_chat(8,('[Helper] '):color(220)..('Checking for updates to current Helpers...'):color(8))
	coroutine.sleep(1)
	checkForHelperUpdates()

	add_to_chat(8,('[Helper] '):color(220)..('Checking for updates to Helper addon...'):color(8))
	coroutine.sleep(1)
	checkForAddonUpdates()

	saveLastCheckTime()

end

--Auto-check for updates
local function checkForUpdates()

	if first_run or (not auto_check_for_updates and not auto_update) then
		return --Exit if neither auto-check nor auto-update is enabled
	end

	local current_time = os.time()
	local last_check = timestamps.last_check or 0
	local one_week = 7 * 24 * 60 * 60  --7 days in seconds

	--Only check if logged in and at least a week has passed since last check
	if get_info().logged_in and (current_time - last_check >= one_week) then

		if settings.auto_update then

			updateAll()

		elseif settings.auto_check_for_updates then
			checkAll()
		end

	end
end

--Save the current timestamp for a key item
local function saveReminderTimestamp(key_item, key_item_reminder_repeat_hours)
	if not key_item then
		return
	end

	local hours = 20
	if key_item_reminder_repeat_hours then
		hours = key_item_reminder_repeat_hours
	end

	--Save the timestamp for 20 hours into the future
	timestamps[key_item] = os.time() + (hours * 60 * 60)

	--Save settings to persist the timestamp
	settings:save('all')
end

--Check if the player has a key item
local function haveKeyItem(key_item_id)
	if not key_item_id then
		return false
	end

	--Get the player's key items
	local key_items = windower.ffxi.get_key_items()

	--Check if the given key_item_id exists in the player's key items
	for _, id in ipairs(key_items) do
		if id == key_item_id then
			return true
		end
	end

	return false
end

--Check if a key item reminder should be triggered
local function checkKIReminderTimestamps()

	--List of tracked key items
	local tracked_items = { canteen = 3137, moglophone = 3212, plate = 3300 }

	--Get the current time
	local current_time = os.time()

	--Loop through each tracked KI
	for key_item, id in pairs(tracked_items) do

		if key_item_reminders[key_item] then

			local reminder_time = timestamps[key_item]
			local have_ki = have_key_item[key_item]

			--We just used the KI
			if have_ki and not haveKeyItem(id) then
				have_key_item[key_item] = false
				settings:save("all")
				saveReminderTimestamp(key_item) --Set the reminder time for 20 hours from now

			--We just received the KI again
			elseif not have_ki and haveKeyItem(id) then
				have_key_item[key_item] = true
				settings:save("all")

			--We do not yet have the KI
			elseif not have_ki and not haveKeyItem(id) then

				--Not the first run (reminder timestamp of 0) and the reminder timestamp has pased
				if reminder_time and reminder_time ~= 0 and current_time >= reminder_time then

					local selected = getHelper()
					local text = helpers[selected.helper]['reminder_'..key_item]
					if text then

						add_to_chat(selected.c_text, ('['..selected.name..'] '):color(selected.c_name) .. (text):color(selected.c_text))

						--Play sound if enabled
						if sound_effects then 
							play_sound(addon_path..'data/sounds/notification.wav') 
						end

					end 

					--Reset the reminder time to repeat
					saveReminderTimestamp(key_item, key_item_reminders[key_item..'_repeat_hours'])

				end
			end
		end
	end
end

local function checkMogLockerReminder()

	if not mog_locker_expiring then
		return
	end

	local current_time = os.time()
	local one_week = 7 * 24 * 60 * 60  -- 7 days in seconds
	local one_day = 24 * 60 * 60  -- 24 hours in seconds

	--Expiration is more than a week away, clear reminder timestamp
	if timestamps.mog_locker_reminder ~= 0 and timestamps.mog_locker_expiration - current_time > one_week then
		timestamps.mog_locker_reminder = 0
		settings:save('all')

	--Expiration is under a week away
	elseif timestamps.mog_locker_expiration - current_time < one_week then

		if current_time >= timestamps.mog_locker_reminder then

			local selected = getHelper()
			local text = helpers[selected.helper].mog_locker_expiring
			if text then

				add_to_chat(selected.c_text, ('['..selected.name..'] '):color(selected.c_name)..(text):color(selected.c_text))

				--Play sound if enabled
				if sound_effects then 
					play_sound(addon_path..'data/sounds/notification.wav') 
				end

			end
	
			--Update the reminder timestamp to trigger again in 24 hours
			timestamps.mog_locker_reminder = current_time + one_day
			settings:save('all')

		end
	end
end

--Check if we have reraise active
local function reraiseActive()

	local buffs = get_player().buffs

	for _, buffId in ipairs(buffs) do
		if buffId == 113 then
			return true
		end
	end

	return false

end

--Check if the player is in a town zone
local function isInTownZone()

	local current_zone = res.zones[get_info().zone].name
	local town_zones = {
		'Western Adoulin','Eastern Adoulin','Celennia Memorial Library','Silver Knife','Bastok Markets','Bastok Mines','Metalworks','Port Bastok','Chateau d\'Oraguille','Northern San d\'Oria','Port San d\'Oria','Southern San d\'Oria','Heavens Tower','Port Windurst','Windurst Walls','Windurst Waters','Windurst Woods','Lower Jeuno','Port Jeuno','Ru\'Lude Gardens','Upper Jeuno','Aht Urhgan Whitegate','The Colosseum','Tavnazian Safehold','Southern San d\'Oria [S]','Bastok Markets [S]','Windurst Waters [S]','Mhaura','Selbina','Rabao','Kazham','Norg','Nashmau','Mog Garden','Leafallia','Chocobo Circuit'
		}

	for _, town in ipairs(town_zones) do
		if current_zone == town then
			return true
		end
	end

	return false

end

--Reset starting states
local function reset()

	party_structure = {}
	in_party = false
	in_alliance = false
	party_leader = false
	alliance_leader = false
	zoning = false

end

--Capitalize first letter
local function capitalize(str)

	str = string.gsub(str, "(%w)(%w*)", function(firstLetter, rest)
		return string.upper(firstLetter) .. string.lower(rest)
	end)

	return str

end

register_event('incoming chunk', function(id, original, modified, injected, blocked)

	if injected or blocked or paused then return end

	local packet = packets.parse('incoming', original)

	if id == 0x063 then

		local player = get_player()

		if player then -- on menu/zone update packet
			limit_points = packet['Limit Points'] or limit_points
			merit_points = packet['Merit Points'] or merit_points
			max_merit_points = packet['Max Merit Points'] or max_merit_points
			local job = player.main_job_full
			cap_points = packet[job..' Capacity Points'] or cap_points
			job_points = packet[job..' Job Points'] or job_points
		end

	elseif id == 0x02D then -- on kill packet

		local msg = packet['Message']

		if msg == 371 or msg == 372 then
			local lp_gained = packet['Param 1']
			limit_points = limit_points + lp_gained
			local merits_gained = math.floor(limit_points / 10000)
			limit_points = limit_points - (merits_gained * 10000)
			merit_points = merit_points + merits_gained >= max_merit_points and max_merit_points or merit_points + merits_gained

		elseif msg == 718 or msg == 735 then
			local cp_gained = packet['Param 1']
			cap_points = cap_points + cp_gained
			local jp_gained = math.floor(cap_points / 30000)
			cap_points = cap_points - (jp_gained * 30000)
			job_points = job_points + jp_gained >= 500 and 500 or job_points + jp_gained

		end
	end

	if capped_merit_points and merit_points == max_merit_points and not capped_merits then

		capped_merits = true

		local selected = getHelper()
		local text = helpers[selected.helper].capped_merit_points
		if text then

			add_to_chat(selected.c_text,('['..selected.name..'] '):color(selected.c_name)..(text):color(selected.c_text))

			--Play sound if enabled
			if sound_effects then 
				play_sound(addon_path..'data/sounds/notification.wav') 
			end

		end

	elseif merit_points < max_merit_points and capped_merits then

		capped_merits = false

	end

	if capped_job_points and job_points == 500 and not capped_jps then

		capped_jps = true

		local selected = getHelper()
		local text = helpers[selected.helper].capped_job_points
		if text then

			add_to_chat(selected.c_text,('['..selected.name..'] '):color(selected.c_name)..(text):color(selected.c_text))

			--Play sound if enabled
			if sound_effects then 
				play_sound(addon_path..'data/sounds/notification.wav') 
			end

		end

	elseif job_points < 500 and capped_jps then

		capped_jps = false

	end

end)

--Introduce the Helper
local function introduceHelper()

	local selected = getHelper()
	local introduction = helpers[selected.helper].info.introduction

	if introduction then
		add_to_chat(selected.c_text,('['..selected.name..'] '):color(selected.c_name)..(introduction):color(selected.c_text))
	else
		if voices then
			add_to_chat(8,('[Helper] '):color(220)..('Voices Mode: '):color(8)..('On'):color(1))
		else
			add_to_chat(8,('[Helper] '):color(220)..('Current Helper is set to '):color(8)..(capitalize(helpers[current_helper].name)):color(1)..('.'):color(8))
		end
	end

end

--Pick a random flavor text
local function flavorText(selected_helper)

	local flavor_text = helpers[selected_helper].flavor_text

	--Check if there are no flavor text entries for the current Helper
	if not flavor_text or next(flavor_text) == nil then
		return false
	end
	
	local text_entries = {}

	--Collect all entries in flavor_text into a list
	for _, text in pairs(flavor_text) do
		table.insert(text_entries, text)
	end

	--Return a random entry from the list
	return text_entries[math.random(#text_entries)]

end

--Update recast timers
local function updateRecasts()

	local ability_recast = windower.ffxi.get_ability_recasts()

	recast.sp1 = ability_recast[0] and math.floor(ability_recast[0]) or 0
	recast.sp2 = ability_recast[254] and math.floor(ability_recast[254]) or 0
	recast.bestial_loyalty = ability_recast[94] and math.floor(ability_recast[94]) or 0
	recast.blaze_of_glory = ability_recast[247] and math.floor(ability_recast[247]) or 0
	recast.call_wyvern = ability_recast[163] and math.floor(ability_recast[163]) or 0
	recast.chivalry = ability_recast[79] and math.floor(ability_recast[79]) or 0
	recast.convergence = ability_recast[183] and math.floor(ability_recast[183]) or 0
	recast.convert = ability_recast[49] and math.floor(ability_recast[49]) or 0
	recast.crooked_cards = ability_recast[96] and math.floor(ability_recast[96]) or 0
	recast.dematerialize = ability_recast[351] and math.floor(ability_recast[351]) or 0
	recast.devotion = ability_recast[28] and math.floor(ability_recast[28]) or 0
	recast.diffusion = ability_recast[184] and math.floor(ability_recast[184]) or 0
	recast.divine_seal = ability_recast[26] and math.floor(ability_recast[26]) or 0
	recast.elemental_seal = ability_recast[38] and math.floor(ability_recast[38]) or 0
	recast.enmity_douse = ability_recast[34] and math.floor(ability_recast[34]) or 0
	recast.entrust = ability_recast[93] and math.floor(ability_recast[93]) or 0
	recast.fealty = ability_recast[78] and math.floor(ability_recast[78]) or 0
	recast.flashy_shot = ability_recast[128] and math.floor(ability_recast[128]) or 0
	recast.formless_strikes = ability_recast[20] and math.floor(ability_recast[20]) or 0
	recast.life_cycle = ability_recast[246] and math.floor(ability_recast[246]) or 0
	recast.mana_wall = ability_recast[39] and math.floor(ability_recast[39]) or 0
	recast.manawell = ability_recast[35] and math.floor(ability_recast[35]) or 0
	recast.marcato = ability_recast[48] and math.floor(ability_recast[48]) or 0
	recast.martyr = ability_recast[27] and math.floor(ability_recast[27]) or 0
	recast.nightingale = ability_recast[109] and math.floor(ability_recast[109]) or 0
	recast.random_deal = ability_recast[196] and math.floor(ability_recast[196]) or 0
	recast.restraint = ability_recast[9] and math.floor(ability_recast[9]) or 0
	recast.sacrosanctity = ability_recast[33] and math.floor(ability_recast[33]) or 0
	recast.spontaneity = ability_recast[37] and math.floor(ability_recast[37]) or 0
	recast.tame = ability_recast[99] and math.floor(ability_recast[99]) or 0
	recast.troubadour = ability_recast[110] and math.floor(ability_recast[110]) or 0

end

--Load
register_event('load', function()

	if get_info().logged_in then

		initialize()
		updateRecasts()
		checkForUpdates()
		firstRun()
		if introduce_on_load then
			introduceHelper()
		end

	end

end)

--Login
register_event('login', function()

	paused = true
	
	--wait 2 seconds to let game values load
	coroutine.schedule(function()
		
		initialize()

		paused = false

		updateRecasts()
		checkForUpdates()
		firstRun()
		if introduce_on_load then
			introduceHelper()
		end

	end, 2)

end)

--Logout
register_event('logout', function()
	reset()
end)

--Party MP checks
local function checkPartyForLowMP()

	local player_job = get_player().main_job

	--Replace redresh placeholders
	local function refreshPlaceholder(text, member, job)
		if job == "BRD" then
			text = text:gsub("%${refresh}", "ballad")
		elseif job == "RDM" then
			text = text:gsub("%${refresh}", "refresh")
		end
		return text:gsub("%${member}", member)
	end

	--Loop through party members 2 through 6
	local positions = {'p1','p2','p3','p4','p5'}
	for _, position in ipairs(positions) do

		local member = get_party()[position]

		if member and member.mp and member.mpp then

			--Calculate estimated max MP based on current MP and mpp
			local estimated_max_mp = math.floor(member.mp / (member.mpp / 100))

			--Check for high max MP, low mpp, and no existing Ballad or Refresh buff
			if estimated_max_mp > 1000 and member.mpp <= 25 then

				local selected = getHelper()
				local text = helpers[selected.helper].party_low_mp
				if text then

					text = refreshPlaceholder(text,member.name,player_job)

					add_to_chat(selected.c_text, ('['..selected.name..'] '):color(selected.c_name)..(text):color(selected.c_text))
					
					--Play sound if enabled
					if sound_effects then 
						play_sound(addon_path..'data/sounds/notification.wav') 
					end

				end

				--Turn the toggle off so this can't be triggered again until it's turned back on
				check_party_for_low_mp_toggle = false
				--Reset the countdown timer so we don't check again until ready
				check_party_for_low_mp_countdown = check_party_for_low_mp_delay_minutes

			end
		end
	end
end

--Replace Mireu zone placeholder
local function mireuPlaceholder(text, zone)
	return text:gsub("%${zone}", zone)
end

--Replace party/alliance member names placeholder
local function memberPlaceholder(text, name)
	return text:gsub("%${member}", name)
end

--Replace Signet placeholder
local function signetPlaceholder(text, buff)
	return text:gsub("%${signet}", buff)
end

--Replace the ability placeholders
local function abilityPlaceholders(text, ability)

	local player_job = get_player().main_job
	local SP1 = {
		WAR = "Mighty Strikes", MNK = "Hundred Fists", WHM = "Benediction",
		BLM = "Manafont", RDM = "Chainspell", THF = "Perfect Dodge",
		PLD = "Invincible", DRK = "Blood Weapon", BST = "Familiar",
		BRD = "Soul Voice", RNG = "Eagle Eye Shot", SMN = "Astral Flow",
		SAM = "Meikyo Shisui", NIN = "Mijin Gakure", DRG = "Spirit Surge",
		BLU = "Azure Lore", COR = "Wild Card", PUP = "Overdrive",
		DNC = "Trance", SCH = "Tabula Rasa", GEO = "Bolster",
		RUN = "Elemental Sforzo"
	}
	local SP2 = {
		WAR = "Brazen Rush", MNK = "Inner Strength", WHM = "Asylum",
		BLM = "Subtle Sorcery", RDM = "Stymie", THF = "Larceny",
		PLD = "Intervene", DRK = "Soul Enslavement", BST = "Unleash",
		BRD = "Clarion Call", RNG = "Overkill", SMN = "Astral Conduit",
		SAM = "Yaegasumi", NIN = "Mikage", DRG = "Fly High",
		BLU = "Unbridled Wisdom", COR = "Cutting Cards", PUP = "Heady Artifice",
		DNC = "Grand Pas", SCH = "Caper Emissarius", GEO = "Widened Compass",
		RUN = "Odyllic Subterfuge"
	}

	local ability_name
	if ability == "SP1" then
		ability_name = SP1[player_job]
	elseif ability == "SP2" then
		ability_name = SP2[player_job]
	else
		ability_name = ability
	end

	return text:gsub("%${ability}", ability_name)

end

-- Function to cycle to the next Helper
function cycleHelper()

	-- Convert the Helper keys to a list
	local helperNames = {}
	for name, enabled in pairs(helpers) do
		if enabled then
			table.insert(helperNames, name)
		end
	end

	-- Sort the names to ensure consistent order
	table.sort(helperNames)

	-- Find the current position of the current Helper
	local currentIndex = 1
	for i, name in ipairs(helperNames) do
		if name == current_helper then
			currentIndex = i
			break
		end
	end

	-- Move to the next Helper in the list and update info, wrap around if needed
	local nextIndex = currentIndex % #helperNames + 1
	current_helper = helperNames[nextIndex]
	c_name = helpers[current_helper].info.name_color
	c_text = helpers[current_helper].info.text_color

	settings.options.current_helper = current_helper
	settings:save('all')
	introduceHelper()

end

-- Helper function to create a table of member names for a given set of positions
local function getMemberNames(structure, positions)

	local members = {}

	for _, position in ipairs(positions) do
		if structure[position] then
			table.insert(members, structure[position])
		end
	end

	return members

end

-- Helper function to find the difference between two tables of member names
local function findDifferences(old_members, new_members)

	local changes = {
		added = {},
		removed = {}
	}

	-- Convert tables to sets for comparison
	local old_set = {}
	for _, name in ipairs(old_members) do
		old_set[name] = true
	end

	local new_set = {}
	for _, name in ipairs(new_members) do
		new_set[name] = true
	end

	-- Find added members
	for _, name in ipairs(new_members) do
		if not old_set[name] then
			table.insert(changes.added, name)
		end
	end

	-- Find removed members
	for _, name in ipairs(old_members) do
		if not new_set[name] then
			table.insert(changes.removed, name)
		end
	end

	return changes

end

--Compare party/alliance structure
function trackPartyStructure()

	-- Initialize the new_party_structure table
	local new_party_structure = updatePartyStructure()
	local previously_in_party = in_party
	local previously_in_alliance = in_alliance
	local previously_party_leader = party_leader
	local previously_alliance_leader = alliance_leader
	local now_in_party = false
	local now_in_alliance = false
	local now_party_leader = false
	local now_alliance_leader = false
	local announce = party_announcements
	local old_p1_count = party_structure.party1_count
	local old_p2_count = party_structure.party2_count
	local old_p3_count = party_structure.party3_count
	local new_p1_count = new_party_structure.party1_count
	local new_p2_count = new_party_structure.party2_count
	local new_p3_count = new_party_structure.party3_count
	local old_p2_leader = party_structure.party2_leader
	local old_p3_leader = party_structure.party3_leader
	local new_p2_leader = new_party_structure.party2_leader
	local new_p3_leader = new_party_structure.party3_leader

	-- Get the current party data
	local current_party = get_party()

	--Are we in an alliance
	if current_party.alliance_leader then
		now_in_alliance = true
		now_in_party = true
		if get_party().alliance_leader == get_player().id then
			now_alliance_leader = true
			now_party_leader = true
		end
	end

	if not now_in_alliance then
		--Are we in a party
		if current_party.party1_leader then
			now_in_party = true
			if get_party().party1_leader == get_player().id then
				now_party_leader = true
			end
		end
	end

	local selected = getHelper()
	local text = nil
	--You join a party that is in an alliance
	if announce.you_joined_alliance and not previously_in_party and now_in_party and now_in_alliance then
		text = helpers[selected.helper].you_joined_alliance
		if text and sound_effects then
			play_sound(addon_path..'data/sounds/member_joined_party.wav')
		end

	--You join a party that is not in an alliance
	elseif announce.you_joined_party and not previously_in_party and now_in_party and not now_party_leader then
		text = helpers[selected.helper].you_joined_party
		if text and sound_effects then
			play_sound(addon_path..'data/sounds/member_joined_party.wav')
		end

	--You leave a party that is part of an alliance
	elseif announce.you_left_alliance and previously_in_alliance and not now_in_party then
		text = helpers[selected.helper].you_left_alliance
		if text and sound_effects then
			play_sound(addon_path..'data/sounds/member_left_party.wav')
		end

	--You leave a party that is not part of an alliance
	elseif announce.you_left_party and previously_in_party and not now_in_party then
		text = helpers[selected.helper].you_left_party
		if text and sound_effects then
			play_sound(addon_path..'data/sounds/member_left_party.wav')
		end

	--Your party joined an alliance
	elseif announce.your_party_joined_alliance and previously_in_party and now_in_alliance and not previously_in_alliance then
		text = helpers[selected.helper].your_party_joined_alliance
		if text and sound_effects then
			play_sound(addon_path..'data/sounds/party_joined_alliance.wav')
		end

	--Your party left an alliance
	elseif announce.your_party_left_alliance and previously_in_alliance and not now_in_alliance then
		text = helpers[selected.helper].your_party_left_alliance
		if text and sound_effects then
			play_sound(addon_path..'data/sounds/party_left_alliance.wav')
		end

	-- Another party joined the alliance
	elseif announce.other_party_joined_alliance and previously_in_alliance and now_in_alliance and 
	((not old_p2_leader and new_p2_leader) or (not old_p3_leader and new_p3_leader)) then
		text = helpers[selected.helper].other_party_joined_alliance
		if text and sound_effects then
			play_sound(addon_path..'data/sounds/party_joined_alliance.wav')
		end

	-- Another party left the alliance
	elseif announce.other_party_left_alliance and previously_in_alliance and now_in_alliance and 
	((old_p2_leader and not new_p2_leader) or (old_p3_leader and not new_p3_leader)) then
		text = helpers[selected.helper].other_party_left_alliance
		if text and sound_effects then
			play_sound(addon_path..'data/sounds/party_left_alliance.wav')
		end

	--Member joined/left your party
	elseif not text and new_party_structure and party_structure and 
	new_p1_count and old_p1_count and new_p1_count ~= old_p1_count then

		-- Compare member names for changes in party 1
		local party1_positions = {'p0', 'p1', 'p2', 'p3', 'p4', 'p5'}
		local old_party1_members = getMemberNames(party_structure, party1_positions)
		local new_party1_members = getMemberNames(new_party_structure, party1_positions)
		local party1_changes = findDifferences(old_party1_members, new_party1_members)

		--Member joined your party
		if announce.member_joined_party and new_p1_count > old_p1_count then
			for _, member in ipairs(party1_changes.added) do
				if member ~= '' then
					text = helpers[selected.helper].member_joined_party
					if text then
						text = memberPlaceholder(text, member)
						if sound_effects then
							play_sound(addon_path..'data/sounds/member_joined_party.wav')
						end
					end
				else
					--if the name of the member hasn't loaded yet and thus comes back nil/empty,
					--set the party count back to it's original state to try again
					new_party_structure.party1_count = party_structure.party1_count
				end
			end

		--Member left your party
		elseif announce.member_left_party and new_p1_count < old_p1_count then
			for _, member in ipairs(party1_changes.removed) do
				if member ~= '' then
					text = helpers[selected.helper].member_left_party
					if text then
						text = memberPlaceholder(text, member)
						if sound_effects then
							play_sound(addon_path..'data/sounds/member_left_party.wav')
						end
					end
				else
					--if the name of the member hasn't loaded yet and thus comes back nil/empty,
					--set the party count back to it's original state to try again
					new_party_structure.party1_count = party_structure.party1_count
				end
			end
		end

	--Member joined/left an alliance party
	elseif not text and new_party_structure and party_structure and 
	new_p2_count and old_p2_count and new_p3_count and old_p3_count and
	(new_p2_count ~= old_p2_count or new_p3_count ~= old_p3_count) then

		-- Compare member names for changes in party 2 and 3 combined (alliance parties)
		local alliance_positions = {
			'a10', 'a11', 'a12', 'a13', 'a14', 'a15',
			'a20', 'a21', 'a22', 'a23', 'a24', 'a25'
		}
		local old_alliance_members = getMemberNames(party_structure, alliance_positions)
		local new_alliance_members = getMemberNames(new_party_structure, alliance_positions)
		local alliance_changes = findDifferences(old_alliance_members, new_alliance_members)

		--Member joined an alliance party
		if announce.member_joined_alliance and (new_p2_count > old_p2_count or new_p3_count > old_p3_count) then
			for _, member in ipairs(alliance_changes.added) do
				if member ~= '' then
					text = helpers[selected.helper].member_joined_alliance
					if text then
						text = memberPlaceholder(text, member)
						if sound_effects then
							play_sound(addon_path..'data/sounds/member_joined_party.wav')
						end
					end
				else
					--if the name of the member hasn't loaded yet and thus comes back nil/empty,
					--set the party count back to it's original state to try again
					new_party_structure.party2_count = party_structure.party2_count
					new_party_structure.party3_count = party_structure.party3_count
				end
			end

		--Member left an alliance party
		elseif announce.member_left_alliance and (new_p2_count < old_p2_count or new_p3_count < old_p3_count) then
			for _, member in ipairs(alliance_changes.removed) do
				if member ~= '' then
					text = helpers[selected.helper].member_left_alliance
					if text then
						text = memberPlaceholder(text, member)
						if sound_effects then
							play_sound(addon_path..'data/sounds/member_left_party.wav')
						end
					end
				else
					--if the name of the member hasn't loaded yet and thus comes back nil/empty,
					--set the party count back to it's original state to try again
					new_party_structure.party2_count = party_structure.party2_count
					new_party_structure.party3_count = party_structure.party3_count
				end
			end
		end

	--You become the alliance leader
	elseif announce.you_are_now_alliance_leader and previously_in_alliance and not previously_alliance_leader and now_alliance_leader then
		text = helpers[selected.helper].you_are_now_alliance_leader
		if text and sound_effects then
			play_sound(addon_path..'data/sounds/now_alliance_leader.wav')
		end

	--You become the party leader
	elseif announce.you_are_now_party_leader and previously_in_party and not previously_party_leader and now_party_leader then
		text = helpers[selected.helper].you_are_now_party_leader
		if text and sound_effects then
			play_sound(addon_path..'data/sounds/now_party_leader.wav')
		end
	end

	if text then
		add_to_chat(selected.c_text,('['..selected.name..'] '):color(selected.c_name)..(text):color(selected.c_text))
	end

	-- Save the current states for future comparison
	in_party = now_in_party
	in_alliance = now_in_alliance
	party_leader = now_party_leader
	alliance_leader = now_alliance_leader
	party_structure = new_party_structure

end

--Player gains a buff
register_event('gain buff', function(buff)

	if buff == 188 and sublimation_charged and not paused then --Sublimation: Complete

		local selected = getHelper()
		local text = helpers[selected.helper].sublimation_charged
		if text then

			add_to_chat(selected.c_text,('['..selected.name..'] '):color(selected.c_name)..(text):color(selected.c_text))

			--Play sound if enabled
			if sound_effects then 
				play_sound(addon_path..'data/sounds/notification.wav') 
			end

		end

	elseif buff == 602 and vorseal_wearing then --Vorseal

		--Set the countdown to 110 minutes (Vorseal lasts 2 hours)
		vorseal_countdown = 6600

	end
end)

--Player loses a buff
register_event('lose buff', function(buff)

	if buff == 602 and vorseal_wearing then --Vorseal

		--Turn the countdown off
		vorseal_countdown = -1

	--Food
	elseif buff == 251 and food_wears_off and alive then

		local selected = getHelper()
		local text = helpers[selected.helper].food_wears_off
		if text then

			add_to_chat(selected.c_text,('['..selected.name..'] '):color(selected.c_name)..(text):color(selected.c_text))

			--Play sound if enabled
			if sound_effects then 
				play_sound(addon_path..'data/sounds/notification.wav') 
			end

		end

	--Reraise
	elseif buff == 133 and reraise_wears_off and alive then

		local selected = getHelper()
		local text = helpers[selected.helper].reraise_wears_off
		if text then

			add_to_chat(selected.c_text,('['..selected.name..'] '):color(selected.c_name)..(text):color(selected.c_text))

			--Play sound if enabled
			if sound_effects then 
				play_sound(addon_path..'data/sounds/notification.wav') 
			end

		end

		--Signet, Sanction, Sigil, Ionis
	elseif (buff == 253 or buff == 256 or buff == 268 or buff == 512) and signet_wears_off then

		local selected = getHelper()
		local text = helpers[selected.helper].signet_wears_off
		if text then

			text = signetPlaceholder(text, buff)

			add_to_chat(selected.c_text,('['..selected.name..'] '):color(selected.c_name)..(text):color(selected.c_text))

			--Play sound if enabled
			if sound_effects then 
				play_sound(addon_path..'data/sounds/notification.wav') 
			end

		end

	end

end)

--Player changes job
register_event('job change', function()

	--prevents job changing from triggerring ability ready notifications
	paused = true
	coroutine.sleep(3)
	paused = false

end)

--Parses incoming text
register_event("incoming text", function(original,modified,original_mode)

	if original_mode == 148 then

		--Match the lease expiration message and extract the date/time
		local year, month, day, hour, minute, second = original:match("Your Mog Locker lease is valid until (%d+)/(%d+)/(%d+) (%d+):(%d+):(%d+), kupo%.")

		--If a match is found, convert it to a timestamp
		if year and month and day and hour and minute and second then
			local lease_expiry_time = os.time({
				year = tonumber(year),
				month = tonumber(month),
				day = tonumber(day),
				hour = tonumber(hour),
				min = tonumber(minute),
				sec = tonumber(second)
			})

			timestamps.mog_locker_expiration = lease_expiry_time
			settings:save('all')

		end
	end

	if original_mode == 212 and mireu_popped and mireu_countdown == 0 then

		local dragons = {
			'Azi Dahaka',
			'Naga Raja',
			'Quetzalcoatl',
		}
		local unity_leaders = {
			'{Aldo}',
			'{Apururu}',
			'{Ayame}',
			'{Flaviria}',
			'{Invincible Shield}',
			'{Jakoh Wahcondalo}',
			'{Maat}',
			'{Naja Salaheem}',
			'{Pieuje}',
			'{Sylvie}',
			'{Yoran-Oran}',
		}
		local zones = {
			"Reisenjima",
			"Ru'Aun",
			"Zi'Tah",
		}

		--Extract all names enclosed in curly brackets
		local function extract_bracketed_names(str)
			local names = {}
			for name in str:gmatch("%b{}") do
				table.insert(names, name)
			end
			return names
		end

		for _, zone in ipairs(zones) do
			--Check if the zone is found in the unity message
			if original:find(zone) then

				local bracketed_names = extract_bracketed_names(original)
				local leader_count = 0

				--Check how many bracketed names are valid unity leaders
				for _, name in ipairs(bracketed_names) do
					for _, leader in ipairs(unity_leaders) do
						if name == leader then
							leader_count = leader_count + 1
							break
						end
					end
				end

				--Proceed only if exactly one unity leader is found, and no extra names are enclosed in brackets
				if leader_count == 1 and #bracketed_names == 1 then

					--Check if any dragon name is found
					for _, dragon in ipairs(dragons) do
						if original:find(dragon) then
							return
						end
					end

					--No dragon name is found, so therefore is Mireu
					local selected = getHelper()
					local text = helpers[selected.helper].mireu_popped
					if text then

						if zone == "Zi'Tah" then
							text = mireuPlaceholder(text, "Escha - Zi'Tah")
						elseif zone == "Ru'Aun" then
							text = mireuPlaceholder(text, "Escha - Ru'Aun")
						else
							text = mireuPlaceholder(text, zone)
						end

						add_to_chat(selected.c_text, ('['..selected.name..'] '):color(selected.c_name)..(text):color(selected.c_text))

						--Play sound if enabled
						if sound_effects then 
							play_sound(addon_path..'data/sounds/notification.wav') 
						end

					end

					mireu_countdown = 3900
					return

				end

				return
			end
		end
	end

end)

register_event('prerender', function()

	local pos = windower.ffxi.get_position()
	local logged_in = get_info().logged_in
	local player = get_player()

	--The zoning flag prevents a few things from happening while zoning
	if pos == "(?-?)" and logged_in and not zoning then
		zoning = true
	elseif pos ~= "(?-?)" and zoning then
		--Short delay after zoning to prevent "left...joined" messages after every zone.
		coroutine.schedule(function()
			zoning = false
		end, after_zone_party_check_delay_seconds)
	end

	--The alive flag prevents a few things from happening when you die
	if player.vitals.hp == 0 and alive then
		alive = false
	elseif player.vitals.hp > 0 and not alive then
		alive = true
	end

	if not (zoning or paused) and logged_in then
		trackPartyStructure()
	end

	--1 second heartbeat (does not run while zoning, paused(job change or immediately after logging in), or not logged in)
	if os.time() > heartbeat and not (zoning or paused) and logged_in then

		heartbeat = os.time()

		updateRecasts()

		local player_job = get_player().main_job

		local selected = getHelper()
		local text = helpers[selected.helper].ability_ready
		if text then
			--Check if abilities are ready
			for ability, enabled in pairs(ability_ready) do
				if enabled then
					if recast[ability] and recast[ability] > 0 and ready[ability] then
						ready[ability] = false
					elseif recast[ability] == 0 and not ready[ability] then
						if not paused then
							text = abilityPlaceholders(text, ability_name[ability])
							add_to_chat(selected.c_text, ('['..selected.name..'] '):color(selected.c_name)..(text):color(selected.c_text))
							if sound_effects then
								play_sound(addon_path..'data/sounds/ability_ready.wav')
							end
						end
						ready[ability] = true
					end
				end
			end
		end

		--Check if any Key Items are ready
		checkKIReminderTimestamps()

		--Check on Mog Locker lease expiration time once per hour
		if heartbeat % 3600 == 0 then
			checkMogLockerReminder()
		end

		--Check Sparkolade reminder every 1 minute
		if heartbeat % 60 == 0 then
			checkSparkoladeReminder()
		end

		--Coutdown for checking party for low mp
		if check_party_for_low_mp and (player_job == 'RDM' or player_job == 'BRD') then

			if check_party_for_low_mp_countdown > 0 then

				check_party_for_low_mp_countdown = check_party_for_low_mp_countdown - 1

			elseif check_party_for_low_mp_countdown == 0 then

				check_party_for_low_mp_toggle = true
				checkPartyForLowMP()

			end
		end

		--Countdown for Flavor text
		if flavor_text then

			if flavor_text_countdown > 0 then

				flavor_text_countdown = flavor_text_countdown - 1

			elseif flavor_text_countdown == 0 then

				local selected = getHelper()
				local text = flavorText(selected.helper)
				if text then
					add_to_chat(selected.c_text,('['..selected.name..'] '):color(selected.c_name)..(text):color(selected.c_text))
					flavor_text_countdown = math.floor(math.random(flavor_text_window_min_hours,flavor_text_window_max_hours))
				end
			end
		end

		--Countdown for Vorseal Reminder
		local selected = getHelper()
		local vorseal_text = helpers[selected.helper].vorseal_wearing
		if vorseal_wearing and vorseal_text then

			if vorseal_countdown > 0 then

				vorseal_countdown = vorseal_countdown - 1

			elseif vorseal_countdown == 0 then

				vorseal_countdown = -1

				add_to_chat(selected.c_text,('['..selected.name..'] '):color(selected.c_name)..(vorseal_text):color(selected.c_text))

				--Play sound if enabled
				if sound_effects then 
					play_sound(addon_path..'data/sounds/notification.wav') 
				end

			end

		end

		--Countdown for Mireu (so we don't call "Mireu popped" when the battle is over)
		if mireu_popped and mireu_countdown > 0 then
			mireu_countdown = mireu_countdown - 1
		end

		--Countdown for Reraise Check
		local selected = getHelper()
		local reraise_text = helpers[selected.helper].reraise_check
		if reraise_check and reraise_text then

			if reraise_countdown > 0 then
				reraise_countdown = reraise_countdown - 1

			elseif reraise_countdown == 0 then
				reraise_countdown = reraise_check_delay_minutes

				--Don't inform if in town
				if not reraiseActive() and (not reraise_check_not_in_town or (reraise_check_not_in_town and not isInTownZone())) then
					add_to_chat(selected.c_text,('['..selected.name..'] '):color(selected.c_name)..(reraise_text):color(selected.c_text))

					--Play sound if enabled
					if sound_effects then 
						play_sound(addon_path..'data/sounds/notification.wav') 
					end

				end
			end
		end
	end
end)

register_event('addon command',function(addcmd, ...)

	local arg = {...}

	if addcmd == 'load' or addcmd == 'l' then
		if arg[1] then
			local file_name = table.concat(arg,' ')
			local new_helper = string.lower(file_name)
			if file_name:sub(-4):lower() ~= '.xml' then
				file_name = file_name..'.xml'
			end
			if file_exists(addon_path..'data/helpers/'..file_name) then
				if not helpers[new_helper] then
					helpers[new_helper] = config.load('data/helpers/'..file_name)
					settings.options.helpers_loaded[new_helper] = true
				end
				settings.options.current_helper = new_helper
				current_helper = new_helper
				helper_name = helpers[current_helper].info.name
				c_name = helpers[current_helper].info.name_color
				c_text = helpers[current_helper].info.text_color
				settings:save('all')
				if voices then
					add_to_chat(8,('[Helper] '):color(220)..('Helper loaded: '):color(8)..(helper_name):color(1))
				else
					introduceHelper()
				end
			else
				add_to_chat(8,('[Helper] '):color(220)..('File '):color(8)..('data/'..file_name):color(1)..(' does not exist.'):color(8))
			end
		else
			add_to_chat(8,('[Helper] '):color(220)..('Please provide a file name to be loaded.'):color(8))
		end

	elseif addcmd == 'unload' or addcmd == 'u' then
		if arg[1] then
			local helper_name = string.lower(table.concat(arg,' '))
			if helpers[helper_name] then
				helpers[helper_name] = nil
				settings.options.helpers_loaded[helper_name] = false
				--If the current Helper is the one we just unloaded, switch to Vana
				if settings.options.current_helper == helper_name then
					settings.options.current_helper = 'vana'
					current_helper = 'vana'
				end
				settings:save('all')
				add_to_chat(8,('[Helper] '):color(220)..(capitalize(helper_name)):color(1)..(' has been unloaded.'):color(8))
			else
				add_to_chat(8,('[Helper] '):color(220)..(capitalize(helper_name)):color(1)..(' is not currently loaded.'):color(8))
			end
		else
			add_to_chat(8,('[Helper] '):color(220)..('Please provide the name of a Helper to be unloaded.'):color(8))
		end

	elseif addcmd == 'list' then
		local sorted_helpers = {}
		for name, enabled in pairs(helpers) do
			if enabled and helpers[name].info then
				table.insert(sorted_helpers, name)
			end
		end
		table.sort(sorted_helpers)
		for _, name in ipairs(sorted_helpers) do
			local helper_name = helpers[name].info.name or "Unknown"
			local helper_type = helpers[name].info.type and helpers[name].info.type.." - " or "Unknown Type - "
			local helper_description = helpers[name].info.description or "No description available."
			local c_name = helpers[name].info.name_color or 220
			local c_text = helpers[name].info.text_color or 1
			add_to_chat(8, ('['..helper_name..'] '):color(c_name)..(helper_type..helper_description):color(c_text))
		end

	elseif addcmd == 'help' then
		local function getLastCheckDate()
			if not timestamps.last_check or timestamps.last_check == 0 then
				return "Never"
			end
			-- Convert the timestamp into a readable date
			return os.date("%a, %b %d, %I:%M %p", timestamps.last_check)
		end
		local function getNextSparkoladeReminder()
			if not sparkolade_reminder then
				return "Off"
			end
			-- Convert the timestamp into a readable date
			return os.date("%a, %b %d, %I:%M %p", timestamps.sparkolades)
		end
		local last_check_date = getLastCheckDate()		
		local prefix = "//helper"
		local helper_name = helpers[current_helper].info.name and helpers[current_helper].info.name or "Unknown"
		local helper_type = helpers[current_helper].info.type and helpers[current_helper].info.type.." - " or "Unknown Type - "
		local helper_description = helpers[current_helper].info.description or "No description available."
		local c_name = helpers[current_helper].info.name_color or 220
		local c_text = helpers[current_helper].info.text_color or 1
		local next_sparkolade_reminder = getNextSparkoladeReminder()
		add_to_chat(8,('[Helper] '):color(220)..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220)..(' ('):color(8)..(prefix):color(1)..(')'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,(' Last update check: '):color(8)..(last_check_date):color(1))
		add_to_chat(8,(' Next Sparkolade reminder: ')..(next_sparkolade_reminder):color(1))
		add_to_chat(8,voices and (' Voices Mode: '):color(8)..('On'):color(1) or (' ['..helper_name..'] '):color(c_name)..(helper_type..helper_description):color(c_text))
		add_to_chat(8,' ')
		add_to_chat(8,(' Command '):color(36)..('[optional] '):color(53)..('<required> '):color(2)..('- Description'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,(' (blank/no command) '):color(36)..('- Cycle to the next loaded Helper.'):color(8))
		add_to_chat(8,(' load/l '):color(36)..('<file_name> '):color(2)..('- Load a Helper file into the addon and select for use.'):color(8))
		add_to_chat(8,('   - Helper files must be in the /data/helpers folder.'):color(8))
		add_to_chat(8,('   - Loaded Helpers are saved and do not need to be loaded again unless unloaded.'):color(8))
		add_to_chat(8,(' unload/u '):color(36)..('<file_name> '):color(2)..('- Unload a Helper file from the addon.'):color(8))
		add_to_chat(8,('   - Unloaded Helper files are not deleted but are removed from use by the addon.'):color(8))
		add_to_chat(8,(' list '):color(36)..('- List currently loaded Helpers.'):color(8))
		add_to_chat(8,(' voices/v '):color(36)..('- Randomly selects a Helper to use for EACH alert/notification.'):color(8))
		add_to_chat(8,(' check '):color(36)..('[new|current|addon]'):color(53)..('- Check for new updates. Does not update.'):color(8))
		add_to_chat(8,(' update '):color(36)..('[new|current|addon]'):color(53)..('- Download new updates.'):color(8))
		add_to_chat(8,('   - Optionally specify which to check/update:'):color(8))
		add_to_chat(8,('       New Helpers, current Helpers, or the addon itself.'):color(8))

	elseif addcmd == "check" then
		if arg[1] then
			local subcmd = string.lower(table.concat(arg,' '))
			if subcmd == "new" then
				add_to_chat(8,('[Helper] '):color(220)..('Checking for new Helpers...'):color(8))
				coroutine.sleep(1)
				checkForNewHelpers()
				if new_updates then
					add_to_chat(8,('[Helper] '):color(220)..('Type'):color(8)..(' //helper update'):color(1)..(' to download new Helpers.'):color(8))
					new_updates = false
				end
			elseif subcmd == "current" then
				add_to_chat(8,('[Helper] '):color(220)..('Checking for updates to current Helpers...'):color(8))
				coroutine.sleep(1)
				checkForHelperUpdates()
				if new_updates then
					add_to_chat(8,('[Helper] '):color(220)..('Type'):color(8)..(' //helper update'):color(1)..(' to download current Helper updates.'):color(8))
					new_updates = false
				end
			elseif subcmd == "addon" then
				add_to_chat(8,('[Helper] '):color(220)..('Checking for updates to Helper addon...'):color(8))
				coroutine.sleep(1)
				checkForAddonUpdates()
				if new_updates then
					add_to_chat(8,('[Helper] '):color(220)..('Type'):color(8)..(' //helper update addon'):color(1)..(' to download addon update.'):color(8))
					new_updates = false
				end
			else
				add_to_chat(8,('[Helper] '):color(220)..('Unrecognized command. Type'):color(8)..(' //helper help'):color(1)..(' for a list of commands.'):color(8))
			end
		else
			checkAll()
			if new_updates then
				add_to_chat(8,('[Helper] '):color(220)..('Type'):color(8)..(' //helper update'):color(1)..(' to download updates.'):color(8))
				new_updates = false
			end
		end

	elseif addcmd == "update" then
		if arg[1] then
			local subcmd = string.lower(table.concat(arg,' '))
			if subcmd == "new" then
				add_to_chat(8,('[Helper] '):color(220)..('Downloading new Helpers...'):color(8))
				coroutine.sleep(1)
				downloadNewHelpers()
			elseif subcmd == "current" then
				add_to_chat(8,('[Helper] '):color(220)..('Updating current Helpers...'):color(8))
				coroutine.sleep(1)
				updateCurrentHelpers()
			elseif subcmd == "addon" then
				add_to_chat(8,('[Helper] '):color(220)..('Updating Helper addon...'):color(8))
				coroutine.sleep(1)
				updateAddon()
			else
				add_to_chat(8,('[Helper] '):color(220)..('Unrecognized command. Type'):color(8)..(' //helper help'):color(1)..(' for a list of commands.'):color(8))
			end
		else
			updateAll()
		end

	elseif addcmd == "voices" or addcmd == "voice" or addcmd == "v" then
		settings.options.voices = not settings.options.voices
		voices = settings.options.voices
		settings:save('all')
		add_to_chat(8,('[Helper] '):color(220)..('Voices Mode: '):color(8)..(voices and 'On' or 'Off'):color(1))

	elseif addcmd == nil then
		cycleHelper()

	else
		add_to_chat(8,('[Helper] '):color(220)..('Unrecognized command. Type'):color(8)..(' //helper help'):color(1)..(' for a list of commands.'):color(8))

	end
end)
