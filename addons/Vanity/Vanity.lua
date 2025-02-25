--Copyright (c) 2025, Key
--All rights reserved.

--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:

--    * Redistributions of source code must retain the above copyright
--      notice, this list of conditions and the following disclaimer.
--    * Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in the
--      documentation and/or other materials provided with the distribution.
--    * Neither the name of Vanity nor the
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

_addon.name = 'Vanity'
_addon.version = '3.1'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'vanity','van'}

config = require('config')
res = require('resources')
items = res.items
require 'chat'
math.randomseed(os.time())

local win = {
	addon_path = windower.addon_path,
	add_to_chat = windower.add_to_chat,
	get_player = windower.ffxi.get_player,
	get_items = windower.ffxi.get_items,
	get_info = windower.ffxi.get_info,
	send_command = windower.send_command,
	register_event = windower.register_event,
}

defaults = {}

defaults.options = {
	after_disable_delay = 9,
	after_job_change_delay = 6,
	after_zone_delay = 5,
}

defaults.help = {
	a = "At the simplest, Vanity can use just one lockstyle for all conditions by setting either the town or combat lockstyle for each job.",
	b = "Designate separate lockstyles for town and combat zones by setting different lockstyles for both town and combat for each job.",
	c = "If you wish to have Vanity choose a random lockstyle, you can set multiple lockstyles by separating numbers with a comma.",
	d = "Designate lockstyles for specific zones by using the zone option. For example, {zone=Western Adoulin:1,2,3} will set lockstyles 1, 2, and 3 for Western Adoulin.",
	e = "Designate lockstyles for the common endgame activities Dynamis, Odyssey, Omen, Vagary, and Sortie by using the dynamis, odyssey, omen, vagary, and sortie conditions. For example, {dynamis:1,2,3} will set lockstyles 1, 2, and 3 for all Dynamis zones.",
	f = "Designate lockstyles for specific weapons or weapon types by using the weapon name or skill conditions: main_name, main_skill, sub_name, sub_skill, range_name, and range_skill. For example, {main_name=Excalibur:1,2,3} will set lockstyles 1, 2, and 3 for Excalibur in the main slot. {sub_skill=Sword:1,2,3} will set lockstyles 1, 2, and 3 for any Sword in the sub slot.",
	g = "Priority is as follows: zone, (dynamis, odyssey, omen, sortie, vagary), main_weapon, main_skill, sub_weapon, sub_skill, range_weapon, range_skill, combat, town. Will equip based on current condition and which conditions have lockstyles designated, going from highest to lowest priority (zone being the highest and town the lowest). The only exception is while in town: zone will still be prioritized first, then town immediately after.",
	h = "If you wish to disable a lockstyle, set the lockstyles to 0. For example, {town:0} will disable the town lockstyle for that job. Removing the condition entirely will also disable it.",
	i = "Things to note: All zone, weapon, and weapon skill names are case-insensitive but will still need to be spelled exactly including spaces and apostrophes, for example {main_name=bunzi`s rod:10} (thats technically a backtick in the example since an apostrophe here would be turned into ASCII code, but you get the idea). Lockstyle numbers must be between 1 and 200, numbers outside this (aside from 0) will simply be ignored. If no valid lockstyles are found for a condition, Vanity will do nothing. To manually set your lockstyle inside of a macro, use `/console vanity set` on its own line. Order does not matter, for example {town:1,2}{combat:3,4} is the same as {combat:4,3}{town:2,1}.",
}

defaults.lockstyles = {
	blm = "{combat:0}{town:0}",
	blu = "{combat:0}{town:0}",
	brd = "{combat:0}{town:0}",
	bst = "{combat:0}{town:0}",
	cor = "{combat:0}{town:0}",
	dnc = "{combat:0}{town:0}",
	drg = "{combat:0}{town:0}",
	drk = "{combat:0}{town:0}",
	geo = "{combat:0}{town:0}",
	mnk = "{combat:0}{town:0}",
	nin = "{combat:0}{town:0}",
	pld = "{combat:0}{town:0}",
	pup = "{combat:0}{town:0}",
	rdm = "{combat:0}{town:0}",
	rng = "{combat:0}{town:0}",
	run = "{combat:0}{town:0}",
	sam = "{combat:0}{town:0}",
	sch = "{combat:0}{town:0}",
	smn = "{combat:0}{town:0}",
	thf = "{combat:0}{town:0}",
	war = "{combat:0}{town:0}",
	whm = "{combat:0}{town:0}",
}

defaults.town_zones = S{
	"Western Adoulin","Eastern Adoulin","Celennia Memorial Library","Silver Knife","Bastok Markets","Bastok Mines","Metalworks","Port Bastok","Chateau d'Oraguille","Northern San d'Oria","Port San d'Oria","Southern San d'Oria","Heavens Tower","Port Windurst","Windurst Walls","Windurst Waters","Windurst Woods","Lower Jeuno","Port Jeuno","Ru'Lude Gardens","Upper Jeuno","Aht Urhgan Whitegate","The Colosseum","Tavnazian Safehold","Southern San d'Oria [S]","Bastok Markets [S]","Windurst Waters [S]","Mhaura","Selbina","Rabao","Kazham","Norg","Nashmau","Mog Garden","Leafallia","Chocobo Circuit"
	}

settings = config.load(defaults)

Heartbeat = 0
job_change_timestamp = 0

--Turn the entire string into all uppercase
function uppercase(str)

	local uppercased = string.gsub(str, "%a", function(letter)
		return letter:upper()
	end)

	return uppercased

end

--These ended up not being used, but I didn't want to delete them just in case
-- --Are we using a two handed weapon?
-- local function twoHanded()

-- 	local equipment = win.get_items().equipment
-- 	local main = win.get_items(equipment.main_bag,equipment.main)

-- 	if not main then return false end

-- 	local skill = items[main.id].skill
-- 	return skill == 4 or skill == 6 or skill == 7 or skill == 8 or skill == 10 or skill == 12

-- end

-- --Are we dualwielding weapons?
-- local function dualWield()

-- 	local equipment = win.get_items().equipment
-- 	local sub = win.get_items(equipment.sub_bag,equipment.sub)

-- 	if not sub then return false end

-- 	local skill = items[sub.id].skill
-- 	return skill == 2 or skill == 3 or skill == 5 or skill == 9 or skill == 11

-- end

--Determine what type of location we are in
local function getLocation()

	--Reload the settings file to update with any new changes
	config.reload(settings)

	local job = string.lower(win.get_player().main_job)
	local zone_name = res.zones[win.get_info().zone].name
	local lockstyle_str = settings.lockstyles[job] or "{combat:0}{town:0}"

	--Check if any custom zone exists in lockstyles and has valid lockstyles
	for custom_zone_match, lockstyle_numbers in lockstyle_str:gmatch("{zone=([^:}]+):([^}]*)}") do
		if string.lower(custom_zone_match) == string.lower(zone_name) and lockstyle_numbers ~= "0" then
			--Extract numbers and check if at least one is within 1-200
			for num in lockstyle_numbers:gmatch("%d+") do
				if tonumber(num) >= 1 and tonumber(num) <= 200 then
					return "zone="..zone_name
				end
			end
		end
	end

	--Check special locations
	if zone_name:find("^Dynamis") then
		return 'dynamis'
	elseif zone_name == "Walk of Echoes [P1]" then
		return 'odyssey'
	elseif zone_name == "Reisenjima Henge" then
		return 'omen'
	elseif zone_name == "Outer Ra'Kaznar [U2]" then
		return 'sortie'
	elseif zone_name == "Outer Ra'Kaznar [U1]" then
		return 'vagary'
	elseif settings.town_zones:contains(zone_name) or win.get_info().mog_house then
		return 'town'
	end

	--None of the above, so we must be in combat
	return 'combat'

end

--Run the lockstyle game command for the job/condition combination
local function setLockstyle()

	if not win.get_info().logged_in then return end

	--Reload the settings file to update with any new changes
	config.reload(settings)

	local job = string.lower(win.get_player().main_job)
	local location = getLocation()
	local lockstyle_str = settings.lockstyles[job] or "{combat:0}{town:0}"

	--Get equipped weapon names and skills
	local equipment = win.get_items().equipment

	local main = equipment.main_bag ~= 0 and win.get_items(equipment.main_bag, equipment.main) or nil
	local main_name = main and main.id and items[main.id] and items[main.id].name or nil
	local main_skill = main and main.id and items[main.id] and items[main.id].skill and res.skills[items[main.id].skill] and res.skills[items[main.id].skill].name or nil

	local sub = equipment.sub_bag ~= 0 and win.get_items(equipment.sub_bag, equipment.sub) or nil
	local sub_name = sub and sub.id and items[sub.id] and items[sub.id].name or nil
	local sub_skill = sub and sub.id and items[sub.id] and items[sub.id].skill and res.skills[items[sub.id].skill].name or nil

	local range = equipment.range_bag ~= 0 and win.get_items(equipment.range_bag, equipment.range) or nil
	local range_name = range and range.id and items[range.id] and items[range.id].name or nil
	local range_skill = range and range.id and items[range.id] and items[range.id].skill and res.skills[items[range.id].skill] and res.skills[items[range.id].skill].name or nil

	--Builde the priority order based on current conditions
	local priority = {}

	--First priorities based on location conditions
	if location:find("zone=") then
		table.insert(priority, location)
	elseif location == "town" then
		table.insert(priority, "town")
	elseif location == "dynamis" then
		table.insert(priority, "dynamis")
	elseif location == "odyssey" then
		table.insert(priority, "odyssey")
	elseif location == "omen" then
		table.insert(priority, "omen")
	elseif location == "sortie" then
		table.insert(priority, "sortie")
	elseif location == "vagary" then
		table.insert(priority, "vagary")
	end
	--If none of the above are true then we can assume we are in a combat location

	--Escape special characters for pattern matching (mamely for +1 weapons since + is a special character)
	local function escapePattern(str)
		return str:gsub("([%(%)%.%%%+%-%*%?%[%]%^%$])", "%%%1")
	end

	--Weapon-based conditions come next
	if main_name then table.insert(priority, "main_name="..escapePattern(main_name)) end
	if main_skill then table.insert(priority, "main_skill="..main_skill) end
	if sub_name then table.insert(priority, "sub_name="..escapePattern(sub_name)) end
	if sub_skill then table.insert(priority, "sub_skill="..sub_skill) end
	if range_name then table.insert(priority, "range_name="..escapePattern(range_name)) end
	if range_skill then table.insert(priority, "range_skill="..range_skill) end

	--Last priorities are combat and town (town will be duplicate if location is town but that's fine)
	table.insert(priority, "combat")
	table.insert(priority, "town")

	--Find the first valid (non-disabled) lockstyle in order of priority
	local lockstyle_numbers = "0"
	for _, loc in ipairs(priority) do
		local temp_lockstyle = lockstyle_str:lower():match("{"..loc:lower()..":([^}]*)}") or "0"
		
		if temp_lockstyle ~= "0" then
			--Extract numbers and check if at least one is valid (1-200)
			local valid_lockstyles = {}
			for num in temp_lockstyle:gmatch("%d+") do
				-- print(loc, num)
				num = tonumber(num)
				if num >= 1 and num <= 200 then
					table.insert(valid_lockstyles, num)
				end
			end
			
			--If we found valid lockstyles, use them
			if #valid_lockstyles > 0 then
				lockstyle_numbers = valid_lockstyles
				break
			end
		end
	end

	--If no valid lockstyles were found, do nothing
	if lockstyle_numbers == "0" then return end

	--Select a random lockstyle from the valid numbers
	if #lockstyle_numbers > 0 then
		local selected_lockstyle = lockstyle_numbers[math.random(#lockstyle_numbers)]
		win.send_command('input /lockstyleset ' .. selected_lockstyle)
	end

end

--List all lockstyles
local function listAllLockstyles()

	--Reload the settings file to update with any new changes
	config.reload(settings)

	win.add_to_chat(8,('[Vanity] '):color(220)..('Lockstyles:'):color(8))

	--Convert settings.lockstyles into a standard Lua table to ensure all jobs are processed
	local jobs = {}
	for job in pairs(settings.lockstyles) do
		table.insert(jobs, job)
	end

	--Sort the jobs alphabetically
	table.sort(jobs)

	--Iterate over the sorted jobs
	for _, job in ipairs(jobs) do
		local lockstyle_str = settings.lockstyles[job]
		local parts = {}

		--Extract all `{key=value}` and `{key:value}` sections dynamically
		for key, value in lockstyle_str:gmatch("{([^=:}]+)[:=]([^}]*)}") do
			if value ~= "0" then
				local formatted_key = key:gsub("_", " "):gsub("^%l", string.upper) --Format key nicely
				table.insert(parts, (formatted_key .. ": "):color(8) .. value:color(1))
			end
		end

		--Only print if at least one lockstyle category is enabled
		if #parts > 0 then
			win.add_to_chat(8, (uppercase(job)):color(1) .. " - " .. table.concat(parts, "  "))
		end
	end
end

--Display lockstyles for the specified job/location (only used for in-game commands which are limited to combat and town only)
local function displayLockstyles(job, location)

	--Reload the settings file to update with any new changes
	config.reload(settings)

	--Retrieve the current lockstyle string
	local current_str = settings.lockstyles[job] or "{combat:0}{town:0}"

	--Extract the relevant lockstyle numbers
	local lockstyle_str = current_str:match("{"..location..":([^}]*)}") or "0"

	--Count how many numbers are in the list
	local num_count = 0
	for _ in lockstyle_str:gmatch("%d+") do
		num_count = num_count + 1
	end

	--Make the location name look nice
	local list = lockstyle_str == "0" and "x" or lockstyle_str
	local loc = " Town"
	if location == 'combat' then
		loc = " Combat"
	end

	win.add_to_chat(8, ('[Vanity] '):color(220)..
		(uppercase(job)..loc):color(1)..
		(' %s: '):format(num_count == 1 and 'lockstyle' or 'lockstyles'):color(8)..
		(list):color(list == 'x' and 39 or 1)..
		(list == 'x' and ' (Disabled)' or ''):color(8)..
		(num_count > 1 and ' (Chosen at random)' or ''):color(8))

end

--Add a lockstyle number to the specified location (Combat and Town only)
local function addLockstyle(job, location, lockstyle_num)

	--Reload the settings file to update with any new changes
	config.reload(settings)

	--Retrieve the current lockstyle string
	local current_str = settings.lockstyles[job] or "{combat:0}{town:0}"

	--Extract and remove the relevant section (`{combat:...}` or `{town:...}`)
	local updated_str = current_str:gsub("{"..location..":([^}]*)}", "", 1)
	local existing_section = current_str:match("{"..location..":([^}]*)}")

	--If there was no existing section, default to "0"
	existing_section = existing_section or "0"

	--If disabling, set section to "0"
	if lockstyle_num == 0 then
		existing_section = "0"
	else
		--Convert existing lockstyles to a table
		local temp_lockstyles = {}
		for num in existing_section:gmatch("%d+") do
			temp_lockstyles[tonumber(num)] = true
		end

		--Add the new lockstyle number and remove `0` if present
		temp_lockstyles[tonumber(lockstyle_num)] = true
		temp_lockstyles[0] = nil

		--Convert back to a sorted comma-separated string
		local sorted_lockstyles = {}
		for num in pairs(temp_lockstyles) do table.insert(sorted_lockstyles, num) end
		table.sort(sorted_lockstyles)

		--Rebuild the updated section
		existing_section = table.concat(sorted_lockstyles, ",")
	end

	--Append the modified section back to the string
	local new_str = updated_str.."{"..location..":"..existing_section.."}"

	--Save the updated lockstyle string
	settings.lockstyles[job] = new_str
	settings:save()

	displayLockstyles(job, location)
end

--Remove a lockstyle number from the specified location (Combat and Town only)
local function removeLockstyle(job, location, lockstyle_num)

	--Reload the settings file to update with any new changes
	config.reload(settings)

	--Retrieve the current lockstyle string
	local current_str = settings.lockstyles[job] or "{combat:0}{town:0}"

	--Extract and remove the relevant section (`{combat:...}` or `{town:...}`)
	local updated_str = current_str:gsub("{"..location..":([^}]*)}", "", 1)
	local existing_section = current_str:match("{"..location..":([^}]*)}")

	--If there was no existing section, do nothing
	if not existing_section then return end

	--Convert existing lockstyles to a table
	local temp_lockstyles = {}
	for num in existing_section:gmatch("%d+") do
		temp_lockstyles[tonumber(num)] = true
	end

	--Remove the specified lockstyle number
	temp_lockstyles[tonumber(lockstyle_num)] = nil

	--If the table is empty, set it to "0" (disabled)
	local updated_section = "0"
	if next(temp_lockstyles) then
		--Convert back to a sorted comma-separated string
		local sorted_lockstyles = {}
		for num in pairs(temp_lockstyles) do table.insert(sorted_lockstyles, num) end
		table.sort(sorted_lockstyles)
		updated_section = table.concat(sorted_lockstyles, ",")
	end

	--Append the modified section back to the string
	local new_str = updated_str.."{"..location..":"..updated_section.."}"

	-- Save the updated lockstyle string
	settings.lockstyles[job] = new_str
	settings:save()

	displayLockstyles(job, location)
end

win.register_event('job change',function()

	--We use this way for a timer (instead of the coroutine.sleep like with zoning) so that we can reset it during the countdown in case we change jobs again while its running, preventing it from trying to set the lockstyle multiple times.
	if settings.options.after_job_change_delay ~= 0 then
		job_change_timestamp = os.time() + settings.options.after_job_change_delay
	end

end)

win.register_event('zone change',function()

	if settings.options.after_zone_delay ~= 0 then
		--Set the appropriate lockstyle after the delay
		coroutine.schedule(setLockstyle, settings.options.after_zone_delay)
	end

end)

win.register_event('addon command',function(cmd, ...)

	local args = {...}
	local sub_cmd = args[1]
	local lockstyle_num = tonumber(args[2])
	local job = string.lower(win.get_player().main_job)

	if cmd == 'combat' or cmd == 'c' then

		if not sub_cmd then

			displayLockstyles(job, 'combat')

		elseif sub_cmd == 'add' or sub_cmd == 'a' then

			if lockstyle_num and (lockstyle_num >= 0 and lockstyle_num <= 200) then
				addLockstyle(job, 'combat', lockstyle_num)
			else
				win.add_to_chat(8,('[Vanity] '):color(220)..('Please provide a number '):color(8)..('1'):color(1)..('-'):color(8)..('200 '):color(1)..('('):color(8)..('0 '):color(1)..('to clear list and disable).'):color(8))
				win.add_to_chat(8,'  Example: '..('//van '..cmd..' '..sub_cmd..' 7'):color(1))
			end

		elseif sub_cmd == 'remove' or sub_cmd == 'rem' or sub_cmd == 'r' then

			removeLockstyle(job, 'combat', lockstyle_num)

		else
			win.add_to_chat(8,('[Vanity] '):color(220)..('Please provide the sub-command '):color(8)..('add/a '):color(1)..('or '):color(8)..('remove/r'):color(1)..('.'):color(8))
			win.add_to_chat(8,'  Example: '..('//van '..cmd..' add 7'):color(1))
		end

	elseif cmd == 'town' or cmd == 't' then

		if not sub_cmd then

			displayLockstyles(job, 'town')

		elseif sub_cmd == 'add' or sub_cmd == 'a' then

			if lockstyle_num and (lockstyle_num >= 0 and lockstyle_num <= 200) then
				addLockstyle(job, 'town', lockstyle_num)
			else
				win.add_to_chat(8,('[Vanity] '):color(220)..('Please provide a number '):color(8)..('1'):color(1)..('-'):color(8)..('200 '):color(1)..('('):color(8)..('0 '):color(1)..('to clear list and disable).'):color(8))
				win.add_to_chat(8,'  Example: '..('//van '..cmd..' '..sub_cmd..' 7'):color(1))
			end

		elseif sub_cmd == 'remove' or sub_cmd == 'rem' or sub_cmd == 'r' then

			removeLockstyle(job, 'town', lockstyle_num)

		else
			win.add_to_chat(8,('[Vanity] '):color(220)..('Please provide the sub-command '):color(8)..('add/a '):color(1)..('or '):color(8)..('remove/r'):color(1)..('.'):color(8))
			win.add_to_chat(8,'  Example: '..('//van '..cmd..' add 7'):color(1))
		end

	elseif cmd == 'help' then

		local currDisableDelay = settings.options.after_disable_delay == 0 and 'OFF' or settings.options.after_disable_delay
		local currJCDelay = settings.options.after_job_change_delay == 0 and 'OFF' or settings.options.after_job_change_delay
		local currZoneDelay = settings.options.after_zone_delay == 0 and 'OFF' or settings.options.after_zone_delay

		local prefix = "//vanity, //van"
		win.add_to_chat(8,('[Vanity] '):color(220)..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220)..(' ('):color(8)..(prefix):color(1)..(')'):color(8))
		win.add_to_chat(8,(' Control your lockstyles based on character, job, and other conditions.'):color(1))
		win.add_to_chat(8,(' If multiple lockstyles are designated, one will be chosen at random.'):color(1))
		win.add_to_chat(8,' ')
		win.add_to_chat(8,(' Command '):color(36)..('Optional '):color(53)..('Required '):color(2)..(' - Description ['):color(8)..('Current Setting'):color(200)..(']'):color(8))
		win.add_to_chat(8,(' combat/c '):color(36)..('- Display lockstyles for your current job in combat zones.'):color(8))
		win.add_to_chat(8,(' town/t '):color(36)..('- Display lockstyles for your current job in town zones.'):color(8))
		win.add_to_chat(8,('   - add/a '):color(53)..('# '):color(2)..('- Add a lockstyle to the combat/town list.'):color(8))
		win.add_to_chat(8,('     - Number must be 1-200, 0 will clear list and disable.'):color(8))
		win.add_to_chat(8,('   - remove/r '):color(53)..('# '):color(2)..('- Remove a lockstyle from the combat/town list.'):color(8))
		win.add_to_chat(8,(' set/s'):color(36)..(' - Set (apply) lockstyle based on current conditions.'):color(8))
		win.add_to_chat(8,(' list/l'):color(36)..(' - List ALL lockstyles for the current character.'):color(8))
		win.add_to_chat(8,(' disable/d'):color(36)..(' #'):color(53)..(' - Display/update After Disable Delay (1-20, 0 to disable). ['):color(8)..(''..currDisableDelay):color(200)..(']'):color(8))
		win.add_to_chat(8,(' job/j'):color(36)..(' #'):color(53)..(' - Display/update After Job Change Delay (1-20, 0 to disable). ['):color(8)..(''..currJCDelay):color(200)..(']'):color(8))
		win.add_to_chat(8,(' zone/z'):color(36)..(' #'):color(53)..(' - Display/update After Zone Delay (1-20, 0 to disable). ['):color(8)..(''..currZoneDelay):color(200)..(']'):color(8))
		win.add_to_chat(8,' ')
		win.add_to_chat(8,(' Advanced Lockstyle conditions such as '):color(8)..('custom zones '):color(6)..('and '):color(8)..('specific weapons'):color(6))
		win.add_to_chat(8,(' can be found in the '):color(8)..('Vanity/data/settings.xml '):color(1)..('file.'):color(8))

	elseif cmd == 'set' or cmd == 's' then
		setLockstyle()

	elseif cmd == 'disable' or cmd == 'd' then
		if sub_cmd == nil then
			local delay = settings.options.after_disable_delay
			win.add_to_chat(8,('[Vanity] '):color(220)..('After Disable Delay'):color(1)..(' is currently set to '):color(8)..(delay == 0 and ('OFF'):color(1) or (''..delay):color(1)..((' %s'):format(delay == 1 and 'second' or 'seconds')):color(8))..'.':color(8))
		else
			sub_cmd = tonumber(sub_cmd)
			if sub_cmd and sub_cmd >= 1 and sub_cmd <= 20 then
				settings.options.after_disable_delay = sub_cmd
				settings:save()
				local delay = settings.options.after_disable_delay
				win.add_to_chat(8,('[Vanity] '):color(220)..('After Disable Delay'):color(1)..(' is now '):color(8)..(delay..' seconds'):color(1)..('.'):color(8))
			elseif sub_cmd == 0 then
				settings.options.after_disable_delay = 0
				settings:save()
				win.add_to_chat(8,('[Vanity] '):color(220)..('After Disable Delay'):color(1)..(' is now '):color(8)..('OFF'):color(1)..('.'):color(8))
			else
				win.add_to_chat(8,('[Vanity] '):color(220)..('Please select a Disable Delay between '):color(8)..('1'):color(1)..(' and '):color(8)..('20'):color(1)..('.'):color(8))
				win.add_to_chat(8,'  Example: '..('//van '..cmd..' 9'):color(1))
			end
		end

	elseif cmd == 'jobchange' or cmd == 'j' then
		if sub_cmd == nil then
			local delay = settings.options.after_job_change_delay
			win.add_to_chat(8,('[Vanity] '):color(220)..('After Job Change Delay'):color(1)..(' is currently set to '):color(8)..(delay == 0 and ('OFF'):color(1) or (''..delay):color(1)..((' %s'):format(delay == 1 and 'second' or 'seconds')):color(8))..'.':color(8))
		else
			sub_cmd = tonumber(sub_cmd)
			if sub_cmd and sub_cmd >= 1 and sub_cmd <= 20 then
				settings.options.after_job_change_delay = sub_cmd
				settings:save()
				local delay = settings.options.after_job_change_delay
				win.add_to_chat(8,('[Vanity] '):color(220)..('After Job Change Delay'):color(1)..(' is now '):color(8)..(delay..' seconds'):color(1)..('.'):color(8))
			elseif sub_cmd == 0 then
				settings.options.after_job_change_delay = 0
				settings:save()
				win.add_to_chat(8,('[Vanity] '):color(220)..('After Job Change Delay'):color(1)..(' is now '):color(8)..('OFF'):color(1)..('.'):color(8))
			else
				win.add_to_chat(8,('[Vanity] '):color(220)..('Please select a Job Change Delay between '):color(8)..('1'):color(1)..(' and '):color(8)..('20'):color(1)..('.'):color(8))
				win.add_to_chat(8,'  Example: '..('//van '..cmd..' 9'):color(1))
			end
		end

	elseif cmd == 'zone' or cmd == 'z' then
		if sub_cmd == nil then
			local delay = settings.options.after_zone_delay
			win.add_to_chat(8,('[Vanity] '):color(220)..('After Zone Delay'):color(1)..(' is currently set to '):color(8)..(delay == 0 and ('OFF'):color(1) or (''..delay):color(1)..((' %s'):format(delay == 1 and 'second' or 'seconds')):color(8))..'.':color(8))
		else
			sub_cmd = tonumber(sub_cmd)
			if sub_cmd and sub_cmd >= 1 and sub_cmd <= 20 then
				settings.options.after_zone_delay = sub_cmd
				settings:save()
				local delay = settings.options.after_zone_delay
				win.add_to_chat(8,('[Vanity] '):color(220)..('After Zone Delay'):color(1)..(' is now '):color(8)..(delay..' seconds'):color(1)..('.'):color(8))
			elseif sub_cmd == 0 then
				settings.options.after_zone_delay = 0
				settings:save()
				win.add_to_chat(8,('[Vanity] '):color(220)..('After Zone Delay'):color(1)..(' is now '):color(8)..('OFF'):color(1)..('.'):color(8))
			else
				win.add_to_chat(8,('[Vanity] '):color(220)..('Please select a Zone Delay between '):color(8)..('1'):color(1)..(' and '):color(8)..('20'):color(1)..('.'):color(8))
				win.add_to_chat(8,'  Example: '..('//van '..cmd..' 9'):color(1))
			end
		end

	elseif cmd == 'list' or cmd == 'l' then
		listAllLockstyles()

	else
		win.add_to_chat(8,('[Vanity] '):color(220)..('Unrecognized command. Type'):color(8)..(' //van help'):color(1)..(' for a list of commands.'):color(8))

	end

end)

win.register_event('prerender', function()

	if os.time() > Heartbeat then

		Heartbeat = os.time()

		if job_change_timestamp > 0 and os.time() >= job_change_timestamp then
			job_change_timestamp = 0
			setLockstyle()
		end

	end
end)

win.register_event('incoming text',function(org)

	if settings.options.after_disable_delay ~= 0 and org:find('Style lock mode disabled.') then

		local location = getLocation()

		if location ~= 'town' then

			--wait a short delay after lockstyle is disabled, if too early will error
			coroutine.schedule(setLockstyle, settings.options.after_disable_delay)

		end

	end
end)
