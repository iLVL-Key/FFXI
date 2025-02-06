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
_addon.version = '1.0'
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
	last_check = 0,
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
		after_zone_party_check_delay = 5,
		auto_check_for_updates = true,
		auto_update = true,
		capped_job_points = true,
		capped_merit_points = true,
		check_party_for_low_mp = true,
		check_party_for_low_mp_delay = 900,
		current_helper = "Vana",
		flavor_text = true,
		flavor_text_window_max = 21600,
		flavor_text_window_min = 14400,
		helpers_loaded = {vana = true},
		introduce_on_load = true,
		mireu_popped = true,
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
		sound_effects = {
			ability_ready = true,
			member_joined_party = true,
			member_left_party = true,
			now_alliance_leader = true,
			now_party_leader = true,
			party_joined_alliance = true,
			party_left_alliance = true,
		},
		sublimation_charged = true,
		vorseal_reminder = true,
	},
}

helpers = {}
--Vana is the default Helper
vana = {
	info = {
		name = "Vana",
		introduction = "I am Vana, your personal Helper.",
		name_color = 39,
		text_color = 220,
		version = 1.0,
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
	capped_job_points = "Your Job Points are now capped.",
	capped_merit_points = "Your Merit Points are now capped.",
	party_low_mp = "It looks like ${member} could use a ${refresh}.",
	sublimation_charged = "Sublimation is now fully charged and ready to use.",
	ability_ready = "${ability} is ready to use again.",
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
	vorseal_reminder = "You have about 10 minutes left on your Vorseal effect.",
}

settings = config.load(defaults)
helpers.vana = config.load('data/helpers/Vana.xml', vana)

local current_helper = string.lower(settings.options.current_helper)
local current_helper_name
local c_name
local c_text

local introduce_on_load = settings.options.introduce_on_load
local auto_check_for_updates = settings.options.auto_check_for_updates
local auto_update = settings.options.auto_update
local ability_ready = settings.options.ability_ready
local capped_job_points = settings.options.capped_job_points
local capped_merit_points = settings.options.capped_merit_points
local sublimation_charged = settings.options.sublimation_charged
local sound_effects = settings.options.sound_effects
local party_announcements = settings.options.party_announcements
local after_zone_party_check_delay = settings.options.after_zone_party_check_delay

local check_party_for_low_mp = settings.options.check_party_for_low_mp
local check_party_for_low_mp_delay = settings.options.check_party_for_low_mp_delay
local check_party_for_low_mp_countdown = 0
local check_party_for_low_mp_toggle = true

local flavor_text = settings.options.flavor_text
local flavor_text_window_min = settings.options.flavor_text_window_min
local flavor_text_window_max = settings.options.flavor_text_window_max
local flavor_text_countdown = math.floor(math.random(flavor_text_window_min,flavor_text_window_max))

local mireu_popped = settings.options.mireu_popped
local mireu_countdown = 0

local vorseal_reminder = settings.options.vorseal_reminder
local vorseal_countdown = -1

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
local job_points = 0
local capped_job_points = true
local zoning = false
local paused = false
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

--Determine starting states
local function initialize()
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
	for name, enabled in pairs(settings.options.helpers_loaded) do
		if enabled then
			if file_exists(addon_path..'data/helpers/'..name..'.xml') then
				helpers[name] = config.load('data/helpers/'..name..'.xml')
			--If the file doesn't exist, unload the Helper
			else
				settings.options.helpers_loaded[name] = nil
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

	current_helper_name = helpers[current_helper].info.name
	c_name = helpers[current_helper].info.name_color
	c_text = helpers[current_helper].info.text_color

end

--Get a list of local Helper files
local function get_local_helpers()
	local local_helpers = {}

	--Check for known helper files by iterating over the loaded list
	for name, enabled in pairs(settings.options.helpers_loaded) do
		local file_name = "data/helpers/" .. name .. ".xml"
		if file_exists(addon_path .. file_name) then
			local_helpers[name] = true
		end
	end

	return local_helpers
end

--Get list of helpers from GitHub
local function get_github_helpers()
	local request_url = "https://api.github.com/repos/iLVL-Key/FFXI/contents/addons/Helper/data/helpers"

	-- Use curl to fetch GitHub API response directly into a Lua variable
	local response = io.popen(string.format('curl -s -L -H "User-Agent: Windower-Helper-Addon" "%s"', request_url)):read("*all")

	-- Ensure response was received
	if not response or response == "" then
		add_to_chat(8, ('[Helper] '):color(220) .. ('Failed to read GitHub response.'):color(8))
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
local function check_for_new_helpers()
	local local_helpers = get_local_helpers()
	local github_helpers = get_github_helpers()

	if not github_helpers then
		add_to_chat(8,('[Helper] '):color(220)..('Could not retrieve GitHub helpers.'):color(8))
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
		add_to_chat(8,('[Helper] '):color(220)..('New %s available: '):color(8):format(#new_helpers == 1 and 'Helper' or 'Helpers'))
		for _, helper in ipairs(new_helpers) do
			add_to_chat(8,(' - '):color(8)..(helper):color(1))
		end
		new_updates = true
	else
		add_to_chat(8,('[Helper] '):color(220)..('There are no new Helpers.'):color(8))
	end
end

--Get the SHA of the Helper.lua file on GitHub
local function get_github_addon_sha()
	local request_url = "https://api.github.com/repos/iLVL-Key/FFXI/contents/addons/Helper/Helper.lua"

	-- Fetch GitHub API response directly into a Lua variable
	local response = io.popen(string.format('curl -s -L -H "User-Agent: Windower-Helper-Addon" "%s"', request_url)):read("*all")

	-- Ensure response was received
	if not response or response == "" then
		add_to_chat(8,('[Helper] '):color(220)..('Failed to retrieve GitHub SHA for the Helper addon.'):color(8))
		return nil
	end

	-- Extract SHA using Lua pattern matching
	local helper_sha = response:match('"sha"%s*:%s*"([^"]+)"')

	return helper_sha or nil
end

--Check for updates to the Helper addon
local function check_for_addon_updates()
	-- Retrieve the latest SHA from GitHub
	local github_sha = get_github_addon_sha()

	-- Retrieve the locally stored SHA
	local local_sha = settings.addon_sha

	-- Compare SHAs
	if local_sha and local_sha == github_sha then
		add_to_chat(8,('[Helper] '):color(220)..('The Helper addon is up to date.'):color(8))
	else
		add_to_chat(8,('[Helper] '):color(220)..('Update available for the Helper addon!'):color(8))
		new_updates = true
	end
end

--Update the SHA tag of a downloaded Helper
local function update_helper_sha(file_name, new_sha)
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
	coroutine.schedule(function()
		helpers[name].info.sha = new_sha
		helpers[name]:save('all')
	end, 1)
end

--Uopdate the SHA tag of the Helper.lua file
local function update_addon_sha(new_sha)
	settings.addon_sha = new_sha
	settings:save()
end

--Retrieve the SHAs of the Helper files on GitHub
local function get_github_helper_shas()
	local request_url = "https://api.github.com/repos/iLVL-Key/FFXI/contents/addons/Helper/data/helpers"

	-- Fetch GitHub API response directly into a Lua variable
	local response = io.popen(string.format('curl -s -L -H "User-Agent: Windower-Helper-Addon" "%s"', request_url)):read("*all")

	-- Ensure response was received
	if not response or response == "" then
		add_to_chat(8,('[Helper] '):color(220)..('Failed to retrieve GitHub SHA for Helpers.'):color(8))
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
local function check_for_helper_updates()
	local github_helper_shas = get_github_helper_shas()

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
		add_to_chat(8,('[Helper] '):color(220)..('Updated %s available: '):color(8):format(#updated_helpers == 1 and 'Helper' or 'Helpers'))
		for _, helper in ipairs(updated_helpers) do
			add_to_chat(8,(' - '):color(8)..(helper):color(1))
		end
		new_updates = true
	else
		add_to_chat(8,('[Helper] '):color(220)..('All Helpers are up to date.'):color(8))
	end
end

--Download a Helper from GitHub
local function download_helper(file_name, github_helper_sha)
	local url = "https://raw.githubusercontent.com/iLVL-Key/FFXI/main/addons/Helper/data/helpers/" .. file_name
	local filepath = addon_path .. "data/helpers/" .. file_name

	-- Download the file
	local curl_command = string.format('curl -s -L -o "%s" "%s"', filepath, url)
	os.execute(curl_command)

	--Update the Helper table
	local name = string.lower(file_name:gsub("%.xml$", ""))
	helpers[name] = config.load('data/helpers/'..file_name)
	settings.options.helpers_loaded[name] = true
	settings:save('all')

	--Update the Helper SHA
	update_helper_sha(file_name, github_helper_sha)

	file_name = file_name:gsub("%.xml$", "")
	add_to_chat(8,('[Helper] '):color(220)..('Updated: '):color(8)..(file_name):color(1))
end

--Download the latest version of Helper.lua from GitHub
local function download_addon(github_addon_sha)

	-- Define the download URL and destination path
	local url = "https://raw.githubusercontent.com/iLVL-Key/FFXI/main/addons/Helper/Helper.lua"
	local filepath = addon_path .. "Helper.lua"

	-- Download the file
	local curl_command = string.format('curl -s -L -o "%s" "%s"', filepath, url)
	os.execute(curl_command)

	-- Update the stored SHA after successful download
	update_addon_sha(github_addon_sha)

	add_to_chat(8,('[Helper] '):color(220)..('Helper addon updated. Reloading...'):color(8))
	windower.send_command('lua r helper')
end

--Check for updated Helpers on GitHub
local function update_existing_helpers()
	print('Checking for updated Helpers...')
	local github_helper_shas = get_github_helper_shas()
	if not github_helper_shas then return end

	local updated_helpers = {}

	for name, github_helper_info in pairs(github_helper_shas) do
		local file_name = github_helper_info.file_name
		local github_helper_sha = github_helper_info.sha
		name = string.lower(name)
		local local_helper_sha = helpers[name] and helpers[name].info and helpers[name].info.sha

		-- Check if the Helper exists and has an outdated SHA or if local_helper_sha is nil
		if not local_helper_sha or local_helper_sha ~= github_helper_sha then
			download_helper(file_name, github_helper_sha)
			table.insert(updated_helpers, file_name)
		end
	end

	-- Notify user
	if #updated_helpers == 0 then
		add_to_chat(8,('[Helper] '):color(220)..('All Helpers are up to date.'):color(8))
	end
end

local function download_new_helpers()
	local github_helper_shas = get_github_helper_shas()
	if not github_helper_shas then return end

	local new_helpers = {}

	for name, github_helper_info in pairs(github_helper_shas) do
		local file_name = github_helper_info.file_name
		name = string.lower(name)
		local file_path = windower.addon_path .. 'data/helpers/' .. name .. '.xml'

		-- Check if the Helper file exists
		if not file_exists(file_path) then
			download_helper(file_name, github_helper_info.sha)
			table.insert(new_helpers, file_name)
		end
	end

	-- Notify user
	if #new_helpers == 0 then
		add_to_chat(8,('[Helper] '):color(220)..('No new Helpers found.'):color(8))
	end
end

--Check for updated addon on GitHub
local function update_addon()
	local github_addon_sha = get_github_addon_sha()
	local local_addon_sha = settings.addon_sha

	if not local_addon_sha or local_addon_sha ~= github_addon_sha then
		download_addon(github_addon_sha)
	else
		add_to_chat(8,('[Helper] '):color(220)..('Helper addon is up to date.'):color(8))
	end
end

local function save_last_check()
	settings.last_check = os.time()
	settings:save('all')
end

--Auto-check for updates
local function auto_check_for_updates()
	if not auto_check_for_updates and not auto_update then
		return --Exit if neither auto-check nor auto-update is enabled
	end

	local current_time = os.time()
	local last_check = settings.last_check or 0
	local one_week = 7 * 24 * 60 * 60  --7 days in seconds

	--Check for updates if this is the first run
	if get_info().logged_in and last_check == 0 then
		
		check_for_new_helpers()
		check_for_helper_updates()
		check_for_addon_updates()
		save_last_check()
		
	--Only check if logged in and at least a week has passed since last check
	elseif get_info().logged_in and (current_time - last_check >= one_week) then

		if settings.auto_update then
			update_existing_helpers()
			download_new_helpers()
			update_addon()
			save_last_check()
		elseif settings.auto_check_for_updates then
			check_for_new_helpers()
			check_for_helper_updates()
			check_for_addon_updates()
			save_last_check()
		end

	end
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
	if injected or blocked then return end
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
		local text = helpers[current_helper].capped_merit_points
		if text then
			add_to_chat(c_text,('['..current_helper_name..'] '):color(c_name)..(text):color(c_text))
		end
	elseif merit_points < max_merit_points and capped_merits then
		capped_merits = false
	end
	if capped_job_points and job_points == 500 and not capped_job_points then
		capped_job_points = true
		local text = helpers[current_helper].capped_job_points
		if text then
			add_to_chat(c_text,('['..current_helper_name..'] '):color(c_name)..(text):color(c_text))
		end
	elseif job_points < 500 and capped_job_points then
		capped_job_points = false
	end
end)

--Introduce the Helper
local function introduceHelper()
	local introduction = helpers[current_helper].info.introduction
	if introduction then
		add_to_chat(c_text,('['..current_helper_name..'] '):color(c_name)..(introduction):color(c_text))
	else
		add_to_chat(8,('[Helper] '):color(220)..('Current Helper is set to '):color(8)..(capitalize(helpers[current_helper].name)):color(1)..('.'):color(8))
	end
end

--Pick a random flavor text
local function flavorText()
	local flavor_text = helpers[current_helper].flavor_text

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
	recast.dematerialize = ability_recast[248] and math.floor(ability_recast[248]) or 0
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
	recast.manawell = ability_recast[35] and math.floor(ability_recast[235]) or 0
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
		if introduce_on_load then
			introduceHelper()
		end
		updateRecasts()
		auto_check_for_updates()
	end
end)

--Login
register_event('login', function()

	updateRecasts()
	initialize()

	--wait 2 seconds to let game values load
	paused = true
	coroutine.schedule(function()
		paused = false
		if introduce_on_load then
			introduceHelper()
		end
		auto_check_for_updates()
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

	--Check if the member has either Ballad or Refresh in their active buffs
	local function hasBalladOrRefresh(member)
		if member and member.mob and member.mob.buff_details then
			for _, buff in ipairs(member.mob.buff_details) do
				if buff.name and ((player_job == 'BRD' and string.find(buff.name, "Ballad")) or (player_job == 'RDM' and string.find(buff.name, "Refresh"))) then
					return true
				end
			end
		end
		return false
	end

	--Loop through party members p2 to p6
	local positions = {'p1','p2','p3','p4','p5'}
	for _, position in ipairs(positions) do
		local member = get_party()[position]
		if member and member.mp and member.mpp then
			--Calculate estimated max MP based on current MP and mpp
			local estimated_max_mp = math.floor(member.mp / (member.mpp / 100))
			--Check for high max MP, low mpp, and no existing Ballad or Refresh buff
			if estimated_max_mp > 1000 and member.mpp <= 25 and not hasBalladOrRefresh(member) then
				local text = helpers[current_helper].party_low_mp
				if text then
					local low_mp_text = refreshPlaceholder(text,member.name,player_job)
					add_to_chat(c_text, ('['..current_helper_name..'] '):color(c_name)..(low_mp_text):color(c_text))
					check_party_for_low_mp_toggle = false --turn the toggle off so this can't be triggered again until it's turned back on
					check_party_for_low_mp_countdown = check_party_for_low_mp_delay --reset the countdown timer so we don't check again until ready
				end
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
	current_helper_name = helpers[current_helper].info.name
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

	local text = nil
	--You join a party that is in an alliance
	if announce.you_joined_alliance and not previously_in_party and now_in_party and now_in_alliance then
		text = helpers[current_helper].you_joined_alliance
		if sound_effects.member_joined_party then
			play_sound(addon_path..'data/sounds/member_joined_party.wav')
		end
	--You join a party that is not in an alliance
	elseif announce.you_joined_party and not previously_in_party and now_in_party and not now_party_leader then
		text = helpers[current_helper].you_joined_party
		if sound_effects.member_joined_party then
			play_sound(addon_path..'data/sounds/member_joined_party.wav')
		end
	--You leave a party that is part of an alliance
	elseif announce.you_left_alliance and previously_in_alliance and not now_in_party then
		text = helpers[current_helper].you_left_alliance
		if sound_effects.member_left_party then
			play_sound(addon_path..'data/sounds/member_left_party.wav')
		end
	--You leave a party that is not part of an alliance
	elseif announce.you_left_party and previously_in_party and not now_in_party then
		text = helpers[current_helper].you_left_party
		if sound_effects.member_left_party then
			play_sound(addon_path..'data/sounds/member_left_party.wav')
		end
	--Your party joined an alliance
	elseif announce.your_party_joined_alliance and previously_in_party and now_in_alliance and not previously_in_alliance then
		text = helpers[current_helper].your_party_joined_alliance
		if sound_effects.party_joined_alliance then
			play_sound(addon_path..'data/sounds/party_joined_alliance.wav')
		end
	--Your party left an alliance
	elseif announce.your_party_left_alliance and previously_in_alliance and not now_in_alliance then
		text = helpers[current_helper].your_party_left_alliance
		if sound_effects.party_left_alliance then
			play_sound(addon_path..'data/sounds/party_left_alliance.wav')
		end
	-- Another party joined the alliance
	elseif announce.other_party_joined_alliance and previously_in_alliance and now_in_alliance and 
	((not old_p2_leader and new_p2_leader) or (not old_p3_leader and new_p3_leader)) then
		text = helpers[current_helper].other_party_joined_alliance
		if sound_effects.party_joined_alliance then
			play_sound(addon_path..'data/sounds/party_joined_alliance.wav')
		end
	-- Another party left the alliance
	elseif announce.other_party_left_alliance and previously_in_alliance and now_in_alliance and 
	((old_p2_leader and not new_p2_leader) or (old_p3_leader and not new_p3_leader)) then
		text = helpers[current_helper].other_party_left_alliance
		if sound_effects.party_left_alliance then
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
					text = memberPlaceholder(helpers[current_helper].member_joined_party, member)
					if sound_effects.member_joined_party then
						play_sound(addon_path..'data/sounds/member_joined_party.wav')
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
					text = memberPlaceholder(helpers[current_helper].member_left_party, member)
					if sound_effects.member_left_party then
						play_sound(addon_path..'data/sounds/member_left_party.wav')
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
					text = memberPlaceholder(helpers[current_helper].member_joined_alliance, member)
					if sound_effects.member_joined_party then
						play_sound(addon_path..'data/sounds/member_joined_party.wav')
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
					text = memberPlaceholder(helpers[current_helper].member_left_alliance, member)
					if sound_effects.member_left_party then
						play_sound(addon_path..'data/sounds/member_left_party.wav')
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
		text = helpers[current_helper].you_are_now_alliance_leader
		if sound_effects.now_alliance_leader then
			play_sound(addon_path..'data/sounds/now_alliance_leader.wav')
		end
	--You become the party leader
	elseif announce.you_are_now_party_leader and previously_in_party and not previously_party_leader and now_party_leader then
		text = helpers[current_helper].you_are_now_party_leader
		if sound_effects.now_party_leader then
			play_sound(addon_path..'data/sounds/now_party_leader.wav')
		end
	end

	if text then
		add_to_chat(c_text,('['..current_helper_name..'] '):color(c_name)..(text):color(c_text))
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
		local text = helpers[current_helper].sublimation_charged
		if text then
			add_to_chat(c_text,('['..current_helper_name..'] '):color(c_name)..(text):color(c_text))
		end
		if sound_effects.ability_ready then
			play_sound(addon_path..'data/sounds/ability_ready.wav')
		end
	elseif buff == 602 and vorseal_reminder then --Vorseal
		vorseal_countdown = 6600
	end

end)

--Player loses a buff
register_event('lose buff', function(buff)

	if buff == 602 and vorseal_reminder then --Vorseal
		vorseal_countdown = -1
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
					local text = helpers[current_helper].mireu_popped
					if text then
						if zone == "Zi'Tah" then
							text = mireuPlaceholder(text, "Escha - Zi'Tah")
						elseif zone == "Ru'Aun" then
							text = mireuPlaceholder(text, "Escha - Ru'Aun")
						else
							text = mireuPlaceholder(text, zone)
						end
						add_to_chat(c_text, ('['..current_helper_name..'] '):color(c_name)..(text):color(c_text))
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

	--Short delay after zoning to prevent "left...joined" messages after every zone.
	local pos = windower.ffxi.get_position()
	local logged_in = get_info().logged_in

	if pos == "(?-?)" and logged_in and not zoning then
		zoning = true
	elseif pos ~= "(?-?)" and zoning then
		coroutine.schedule(function()
			zoning = false
		end, after_zone_party_check_delay)
	end

	if not (zoning or paused) and logged_in then
		trackPartyStructure()
	end

	--1 second heartbeat
	if os.time() > heartbeat and logged_in then
		heartbeat = os.time()
		updateRecasts()
		local player_job = get_player().main_job
		local text = helpers[current_helper] and helpers[current_helper].ability_ready

		--Check if abilities are ready
		for ability, enabled in pairs(ability_ready) do
			if enabled then
				if recast[ability] and recast[ability] > 0 and ready[ability] then
					ready[ability] = false
				elseif recast[ability] == 0 and not ready[ability] then
					if not paused then
						if text then
							text = abilityPlaceholders(text, ability_name[ability])
							add_to_chat(c_text, ('['..current_helper_name..'] '):color(c_name)..(text):color(c_text))
						end
						if sound_effects.ability_ready then
							play_sound(addon_path..'data/sounds/ability_ready.wav')
						end
					end

					ready[ability] = true
				end
			end
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
				local text = flavorText()
				if text then
					add_to_chat(c_text,('['..current_helper_name..'] '):color(c_name)..(text):color(c_text))
					flavor_text_countdown = math.floor(math.random(flavor_text_window_min,flavor_text_window_max))
				end
			end
		end

		--Countdown for Vorseal Reminder
		local text = helpers[current_helper].vorseal_reminder
		if text then
			if vorseal_reminder then
				if vorseal_countdown > 0 then
					vorseal_countdown = vorseal_countdown - 1
				elseif vorseal_countdown == 0 then
					add_to_chat(c_text,('['..current_helper_name..'] '):color(c_name)..(text):color(c_text))
					vorseal_countdown = -1
				end
			end
			--Countdown for Mireu (so we don't call "Mireu popped" when the battle is over)
			if mireu_popped and mireu_countdown > 0 then
				mireu_countdown = mireu_countdown - 1
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
				if helpers[new_helper] then
					settings.options.current_helper = new_helper
					current_helper = new_helper
					current_helper_name = helpers[current_helper].info.name
					c_name = helpers[current_helper].info.name_color
					c_text = helpers[current_helper].info.text_color
					settings:save('all')
					introduceHelper()
				else
					helpers[new_helper] = config.load('data/helpers/'..file_name)
					settings.options.helpers_loaded[new_helper] = true
					settings.options.current_helper = new_helper
					current_helper = new_helper
					current_helper_name = helpers[current_helper].info.name
					c_name = helpers[current_helper].info.name_color
					c_text = helpers[current_helper].info.text_color
					settings:save('all')
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
				settings.options.helpers_loaded[helper_name] = nil
				--If the current Helper is the one we just unloaded, switch to Vana
				if settings.options.current_helper == name then
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
		local helper_list = {}
		for name, enabled in pairs(helpers) do
			if enabled and helpers[name].info and helpers[name].info.name then
				table.insert(helper_list, helpers[name].info.name)
			end
		end
		table.sort(helper_list)
		add_to_chat(1,('[Helper] '):color(220)..('Loaded Helpers: '):color(220)..('\n'..table.concat(helper_list, '\n')):color(1))

	elseif addcmd == 'help' then
		local prefix = "//helper"
		local helper_version = helpers[current_helper].info.version
		add_to_chat(8,('[Helper] '):color(220)..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220)..(' ('):color(8)..(prefix):color(1)..(')'):color(8))
		add_to_chat(8,(' Current Helper: '):color(8)..('['..current_helper_name..']'):color(c_name)..(' Version '..helper_version):color(c_text))
		add_to_chat(8,(' Command '):color(36)..('[optional] '):color(53)..('<required> '):color(2)..('- Description'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,(' (blank/no command) '):color(36)..('- Cycle to the next loaded Helper.'):color(8))
		add_to_chat(8,(' load/l '):color(36)..('<file_name> '):color(2)..('- Load a Helper file into the addon.'):color(8))
		add_to_chat(8,('   - Helper files must be in the /data/helpers folder.'):color(8))
		add_to_chat(8,('   - Loaded Helpers are saved and do not need to be loaded again unless unloaded.'):color(8))
		add_to_chat(8,(' unload/u '):color(36)..('<file_name> '):color(2)..('- Unload a Helper file from the addon.'):color(8))
		add_to_chat(8,('   - Unloaded Helper files are not deleted but are removed from use by the addon.'):color(8))
		add_to_chat(8,(' list '):color(36)..('- List currently loaded Helpers.'):color(8))
		add_to_chat(8,(' check '):color(36)..('[new|current|addon]'):color(53)..('- Check for new updates. Does not download anything.'):color(8))
		add_to_chat(8,(' update '):color(36)..('[new|current|addon]'):color(53)..('- Download new updates.'):color(8))
		add_to_chat(8,('   - Optionally specify which to check/update:'):color(8))
		add_to_chat(8,('       New Helpers, current Helpers, or the addon itself.'):color(8))

	elseif addcmd == "check" then
		if arg[1] then
			local subcmd = string.lower(table.concat(arg,' '))
			if subcmd == "new" then
				check_for_new_helpers()
				if new_updates then
					add_to_chat(8,('[Helper] '):color(220)..('Type'):color(8)..(' //helper update'):color(1)..(' to download new Helpers.'):color(8))
					new_updates = false
				end
			elseif subcmd == "current" then
				check_for_helper_updates()
				if new_updates then
					add_to_chat(8,('[Helper] '):color(220)..('Type'):color(8)..(' //helper update'):color(1)..(' to download current Helper updates.'):color(8))
					new_updates = false
				end
			elseif subcmd == "addon" then
				check_for_addon_updates()
				if new_updates then
					add_to_chat(8,('[Helper] '):color(220)..('Type'):color(8)..(' //helper update addon'):color(1)..(' to download addon update.'):color(8))
					new_updates = false
				end
			else
				add_to_chat(8,('[Helper] '):color(220)..('Unrecognized command. Type'):color(8)..(' //helper help'):color(1)..(' for a list of commands.'):color(8))
			end
		else
			check_for_new_helpers()
			check_for_helper_updates()
			check_for_addon_updates()
			if new_updates then
				add_to_chat(8,('[Helper] '):color(220)..('Type'):color(8)..(' //helper update'):color(1)..(' to download all updates.'):color(8))
				new_updates = false
			end
		end

	elseif addcmd == "update" then
		if arg[1] then
			local subcmd = string.lower(table.concat(arg,' '))
			if subcmd == "new" then
				download_new_helpers()
			elseif subcmd == "current" then
				update_existing_helpers()
			elseif subcmd == "addon" then
				update_addon()
			else
				add_to_chat(8,('[Helper] '):color(220)..('Unrecognized command. Type'):color(8)..(' //helper help'):color(1)..(' for a list of commands.'):color(8))
			end
		else
			update_existing_helpers()
			download_new_helpers()
			update_addon()
		end

	elseif addcmd == nil then
		cycleHelper()

	else
		add_to_chat(8,('[Helper] '):color(220)..('Unrecognized command. Type'):color(8)..(' //helper help'):color(1)..(' for a list of commands.'):color(8))

	end
end)
