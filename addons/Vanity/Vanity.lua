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
_addon.version = '4.0'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'vanity','van'}

require 'logger'
config = require('config')
files = require('files')
res = require('resources')
items = res.items
require 'chat'
math.randomseed(os.time())

addon_path = windower.addon_path
add_to_chat = windower.add_to_chat
get_player = windower.ffxi.get_player
get_items = windower.ffxi.get_items
get_info = windower.ffxi.get_info
send_command = windower.send_command
register_event = windower.register_event

defaults = {}

defaults.options = {
	after_disable_delay = 9,
	after_job_change_delay = 6,
	after_zone_delay = 5,
}

defaults.town_zones = S{
	"Western Adoulin","Eastern Adoulin","Celennia Memorial Library","Silver Knife","Bastok Markets","Bastok Mines","Metalworks","Port Bastok","Chateau d'Oraguille","Northern San d'Oria","Port San d'Oria","Southern San d'Oria","Heavens Tower","Port Windurst","Windurst Walls","Windurst Waters","Windurst Woods","Lower Jeuno","Port Jeuno","Ru'Lude Gardens","Upper Jeuno","Aht Urhgan Whitegate","The Colosseum","Tavnazian Safehold","Southern San d'Oria [S]","Bastok Markets [S]","Windurst Waters [S]","Mhaura","Selbina","Rabao","Kazham","Norg","Nashmau","Mog Garden","Leafallia","Chocobo Circuit"
	}

settings = config.load(defaults)

lockstyles_help_msg = "--At the simplest, Vanity can use just one lockstyle for all conditions by setting either the town or combat lockstyle for each job.\n\n--Designate separate lockstyles for town and combat zones by setting different lockstyles for both town and combat for each job.\n\n--If you wish to have Vanity choose a random lockstyle, you can set multiple lockstyles by separating numbers with a comma.\n\n--Designate lockstyles for specific zones by using the zone option. For example, {zone=Western Adoulin:1,2,3} will set lockstyles 1, 2, and 3 for Western Adoulin.\n\n--Designate lockstyles for the common endgame activities Dynamis, Odyssey, Omen, Vagary, and Sortie by using the dynamis, odyssey, omen, vagary, and sortie conditions. For example, {dynamis:1,2,3} will set lockstyles 1, 2, and 3 for all Dynamis zones.\n\n--Designate lockstyles for specific weapons or weapon types by using the weapon name or skill conditions: main_name, main_skill, sub_name, sub_skill, range_name, and range_skill. For example, {main_name=Excalibur:1,2,3} will set lockstyles 1, 2, and 3 for Excalibur in the main slot. {sub_skill=Sword:1,2,3} will set lockstyles 1, 2, and 3 for any Sword in the sub slot.\n\n--Designate lockstyles for combinations of weapons or weapon types with the combo conditions: main_sub_name, main_sub_skill, main_range_name, and main_range_skill, and a slash between the weapons/skills. For example, {main_sub_name=Burtgang/Duban:1} will set lockstyle 1 for Burtgang in the main slot and Duban in the sub slot. {main_range_skill=sword/marksmanship:2} will set lockstyle 2 for any sword in the main slot and any gun/crossbow in the range slot.\n\n--Priority is as follows: zone, (dynamis, odyssey, omen, sortie, vagary), main_weapon, main_skill, sub_weapon, sub_skill, range_weapon, range_skill, combat, town. Will equip based on current condition and which conditions have lockstyles designated, going from highest to lowest priority (zone being the highest and town the lowest). The only exception is while in town: zone will still be prioritized first, then town immediately after.\n\n--If you wish to disable a lockstyle, set the lockstyles to 0. For example, {town:0} will disable the town lockstyle for that job. Removing the condition entirely will also disable it.\n\n--Things to note: All zone, weapon, and weapon skill names are case-insensitive but will still need to be spelled exactly including spaces and apostrophes, for example {main_name=bunzi's rod:10}. Lockstyle numbers must be between 1 and 200, numbers outside this (aside from 0) will simply be ignored. If no valid lockstyles are found for a condition, Vanity will do nothing. To manually set your lockstyle inside of a macro, use `/console vanity set` on its own line. Order does not matter, for example {town:1,2}{combat:3,4} is the same as {combat:4,3}{town:2,1}.\n\n"

lockstyles_file = nil
lockstyles_data = {}
town_zones = settings.town_zones
Heartbeat = 0
job_change_timestamp = 0

--Determine what type of location we are in
function getLocation(old_zone_id)
	
	local player_name = get_player().name
	local job = get_player().main_job
	local zone_name = res.zones[get_info().zone].name
	local prev_zone_name = old_zone_id and res.zones[old_zone_id].name or ""

	--Default lockstyle string in case nothing is found
	local lockstyle_str = (lockstyles_data[player_name] and lockstyles_data[player_name][job]) or "{combat:0}{town:0}"

	--Check if any custom zone exists in lockstyles and has valid lockstyles
	for custom_zone_match, lockstyle_numbers in lockstyle_str:gmatch("{zone=([^:}]+):([^}]*)}") do
		if string.lower(custom_zone_match) == string.lower(zone_name) and lockstyle_numbers ~= "0" then
			for num in lockstyle_numbers:gmatch("%d+") do
				num = tonumber(num)
				if num and num >= 1 and num <= 200 then
					return "zone="..zone_name
				end
			end
		end
	end

	--Check special locations
	if zone_name:find("^Dynamis") then
		return 'dynamis'
	elseif zone_name:find("^Walk of Echoes") and prev_zone_name == "Rabao" then
		return 'odyssey'
	elseif zone_name == "Reisenjima Henge" then
		return 'omen'
	elseif zone_name:find("^Outer Ra'Kaznar") then
		if prev_zone_name == "Kamihr Drifts" then
			return 'sortie'
		elseif prev_zone_name == "Outer Ra'Kaznar" then
			return 'vagary'
		end
	elseif town_zones:contains(zone_name) or get_info().mog_house then
		return 'town'
	end

	--None of the above, so we must be in combat
	return 'combat'

end

--Run the lockstyle game command for the job/condition combination
function setLockstyle(old_zone_id)

	if not get_info().logged_in then return end

	local player = get_player()
	local player_name = player.name
	local job = player.main_job
	local location = getLocation(old_zone_id)
	local lockstyle_str = (lockstyles_data[player_name] and lockstyles_data[player_name][job]) or "{combat:0}{town:0}"

	--Get equipped weapon names and skills
	local equipment = get_items().equipment

	local main = equipment.main_bag ~= 0 and get_items(equipment.main_bag, equipment.main) or nil
	local main_name = main and main.id and items[main.id] and items[main.id].name or nil
	local main_skill = main and main.id and items[main.id] and items[main.id].skill and res.skills[items[main.id].skill] and res.skills[items[main.id].skill].name or nil

	local sub = equipment.sub_bag ~= 0 and get_items(equipment.sub_bag, equipment.sub) or nil
	local sub_name = sub and sub.id and items[sub.id] and items[sub.id].name or nil
	local sub_skill = sub and sub.id and items[sub.id] and items[sub.id].skill and res.skills[items[sub.id].skill] and res.skills[items[sub.id].skill].name or nil

	local range = equipment.range_bag ~= 0 and get_items(equipment.range_bag, equipment.range) or nil
	local range_name = range and range.id and items[range.id] and items[range.id].name or nil
	local range_skill = range and range.id and items[range.id] and items[range.id].skill and res.skills[items[range.id].skill] and res.skills[items[range.id].skill].name or nil

	--Get combos of equipped weapon names and skills
	local main_sub_name = main_name and sub_name and (main_name.."/"..sub_name) or nil
	local main_sub_skill = main_skill and sub_skill and (main_skill.."/"..sub_skill) or nil
	local main_range_name = main_name and range_name and (main_name.."/"..range_name) or nil
	local main_range_skill = main_skill and range_skill and (main_skill.."/"..range_skill) or nil

	--Build the priority order based on current conditions
	local priority = {}

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
	if main_sub_name then table.insert(priority, "main_sub_name="..escapePattern(main_sub_name)) end
	if main_sub_skill then table.insert(priority, "main_sub_skill="..escapePattern(main_sub_skill)) end
	if main_range_name then table.insert(priority, "main_range_name="..escapePattern(main_range_name)) end
	if main_range_skill then table.insert(priority, "main_range_skill="..escapePattern(main_range_skill)) end
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
	for _, cond in ipairs(priority) do
		local temp_lockstyle = lockstyle_str:lower():match("{"..cond:lower()..":([^}]*)}") or "0"

		if temp_lockstyle ~= "0" then
			--Extract numbers and check if at least one is valid (1-200)
			local valid_lockstyles = {}
			for num in temp_lockstyle:gmatch("%d+") do
				num = tonumber(num)
				if num and num >= 1 and num <= 200 then
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
		local selected = lockstyle_numbers[math.random(#lockstyle_numbers)]
		send_command('input /lockstyleset '..selected)
	end

end

--List all lockstyles
function listAllLockstyles()

	local player_name = get_player().name
	local char_data = lockstyles_data[player_name]

	if not char_data then
		add_to_chat(8, '[Vanity] No lockstyles found for '..player_name)
		return
	end

	add_to_chat(8, ('[Vanity] '):color(220)..('Lockstyles for '..player_name..':'):color(8))

	--Collect jobs from the lockstyles_data and sort them alphabetically
	local jobs = {}
	for job in pairs(char_data) do
		table.insert(jobs, job)
	end
	table.sort(jobs)

	--Iterate over the sorted jobs
	for _, job in ipairs(jobs) do
		local lockstyle_str = char_data[job]
		local parts = {}

		--Extract all `{key=value}` and `{key:value}` sections dynamically
		for key, value in lockstyle_str:gmatch("{([^=:}]+)[:=]([^}]*)}") do
			if value ~= "0" then
				local formatted_key = key:gsub("_", " "):gsub("^%l", string.upper)
				table.insert(parts, (formatted_key..": "):color(8)..value:color(1))
			end
		end

		--Only print if at least one lockstyle category is enabled
		if #parts > 0 then
			add_to_chat(8, (job):color(1).." - "..table.concat(parts, "  "))
		end
	end
end

--Display lockstyles for the specified job/location (only used for in-game commands which are limited to combat and town only)
function displayLockstyles(job, location)

	local player_name = get_player().name

	--Retrieve the current lockstyle string
	local current_str = (lockstyles_data[player_name] and lockstyles_data[player_name][job]) or "{combat:0}{town:0}"

	--Extract the relevant lockstyle numbers
	local lockstyle_str = current_str:match("{"..location..":([^}]*)}") or "0"

	--Count valid lockstyle numbers in the list
	local num_count = 0
	for _ in lockstyle_str:gmatch("%d+") do
		num_count = num_count + 1
	end

	--Make the location name look nice
	local list = lockstyle_str == "0" and "x" or lockstyle_str
	local loc = location == "combat" and " Combat" or " Town"

	add_to_chat(8, ('[Vanity] '):color(220)..
		(job..loc):color(1)..
		(' %s: '):format(num_count == 1 and 'lockstyle' or 'lockstyles'):color(8)..
		(list):color(list == 'x' and 39 or 1)..
		(list == 'x' and ' (Disabled)' or ''):color(8)..
		(num_count > 1 and ' (Chosen at random)' or ''):color(8))

end

--Add a lockstyle number to the specified location (Combat and Town only)
function addLockstyle(job, location, lockstyle_num)

	local player_name = get_player().name

	--Make sure the character and job entry exist
	if not lockstyles_data[player_name] then
		lockstyles_data[player_name] = {}
	end
	if not lockstyles_data[player_name][job] then
		lockstyles_data[player_name][job] = "{combat:0}{town:0}"
	end

	--Retrieve the current lockstyle string
	local current_str = lockstyles_data[player_name][job]

	--Extract and remove the relevant section ({combat:...} or {town:...})
	local updated_str = current_str:gsub("{"..location..":([^}]*)}", "", 1)
	local existing_section = current_str:match("{"..location..":([^}]*)}") or "0"

	--If disabling, set section to "0"
	if lockstyle_num == 0 then
		existing_section = "0"
	else
		--Convert existing lockstyles to a table
		local temp_lockstyles = {}
		for num in existing_section:gmatch("%d+") do
			temp_lockstyles[tonumber(num)] = true
		end

		--Add the new lockstyle number and remove 0 if present
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
	lockstyles_data[player_name][job] = new_str

	--Write updated lockstyles_data back to file
	local file_contents = lockstyles_help_msg..'return '..T(lockstyles_data):tovstring()
	lockstyles_file:write(file_contents)

	--Display the updated changes to the player
	displayLockstyles(job, location)

end

--Remove a lockstyle number from the specified location (Combat and Town only)
function removeLockstyle(job, location, lockstyle_num)

	local player_name = get_player().name

	--Make sure the character and job exist
	if not lockstyles_data[player_name] then return end
	if not lockstyles_data[player_name][job] then return end

	--Retrieve the current lockstyle string
	local current_str = lockstyles_data[player_name][job]

	--Extract and remove the relevant section ({combat:...} or {town:...})
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
	lockstyles_data[player_name][job] = new_str

	--Write updated lockstyles_data back to file
	local file_contents = lockstyles_help_msg..'return '..T(lockstyles_data):tovstring()
	lockstyles_file:write(file_contents)

	--Display the updated changes to the player
	displayLockstyles(job, location)

end

register_event('job change',function()

	--We use this way for a timer (instead of the coroutine.sleep like with zoning) so that we can reset it during the countdown in case we change jobs again while its running, preventing it from trying to set the lockstyle multiple times.
	if settings.options.after_job_change_delay ~= 0 then
		job_change_timestamp = os.time() + settings.options.after_job_change_delay
	end

end)

register_event('zone change',function(new_id, old_id)

	if settings.options.after_zone_delay ~= 0 then
		--Set the appropriate lockstyle after the delay
		coroutine.schedule(function()
			setLockstyle(old_id)
		end, settings.options.after_zone_delay)
	end

end)

register_event('addon command',function(cmd, ...)

	local args = {...}
	local sub_cmd = args[1]
	local lockstyle_num = tonumber(args[2])
	local job = get_player().main_job

	if cmd == 'combat' or cmd == 'c' then

		if not sub_cmd then

			displayLockstyles(job, 'combat')

		elseif sub_cmd == 'add' or sub_cmd == 'a' then

			if lockstyle_num and (lockstyle_num >= 0 and lockstyle_num <= 200) then
				addLockstyle(job, 'combat', lockstyle_num)
			else
				add_to_chat(8,('[Vanity] '):color(220)..('Please provide a number '):color(8)..('1'):color(1)..('-'):color(8)..('200 '):color(1)..('('):color(8)..('0 '):color(1)..('to clear list and disable).'):color(8))
				add_to_chat(8,'  Example: '..('//van '..cmd..' '..sub_cmd..' 7'):color(1))
			end

		elseif sub_cmd == 'remove' or sub_cmd == 'rem' or sub_cmd == 'r' then

			removeLockstyle(job, 'combat', lockstyle_num)

		else
			add_to_chat(8,('[Vanity] '):color(220)..('Please provide the sub-command '):color(8)..('add/a '):color(1)..('or '):color(8)..('remove/r'):color(1)..('.'):color(8))
			add_to_chat(8,'  Example: '..('//van '..cmd..' add 7'):color(1))
		end

	elseif cmd == 'town' or cmd == 't' then

		if not sub_cmd then

			displayLockstyles(job, 'town')

		elseif sub_cmd == 'add' or sub_cmd == 'a' then

			if lockstyle_num and (lockstyle_num >= 0 and lockstyle_num <= 200) then
				addLockstyle(job, 'town', lockstyle_num)
			else
				add_to_chat(8,('[Vanity] '):color(220)..('Please provide a number '):color(8)..('1'):color(1)..('-'):color(8)..('200 '):color(1)..('('):color(8)..('0 '):color(1)..('to clear list and disable).'):color(8))
				add_to_chat(8,'  Example: '..('//van '..cmd..' '..sub_cmd..' 7'):color(1))
			end

		elseif sub_cmd == 'remove' or sub_cmd == 'rem' or sub_cmd == 'r' then

			removeLockstyle(job, 'town', lockstyle_num)

		else
			add_to_chat(8,('[Vanity] '):color(220)..('Please provide the sub-command '):color(8)..('add/a '):color(1)..('or '):color(8)..('remove/r'):color(1)..('.'):color(8))
			add_to_chat(8,'  Example: '..('//van '..cmd..' add 7'):color(1))
		end

	elseif cmd == 'help' then

		local currDisableDelay = settings.options.after_disable_delay == 0 and 'OFF' or settings.options.after_disable_delay
		local currJCDelay = settings.options.after_job_change_delay == 0 and 'OFF' or settings.options.after_job_change_delay
		local currZoneDelay = settings.options.after_zone_delay == 0 and 'OFF' or settings.options.after_zone_delay

		local prefix = "//vanity, //van"
		add_to_chat(8,('[Vanity] '):color(220)..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220)..(' ('):color(8)..(prefix):color(1)..(')'):color(8))
		add_to_chat(8,(' Control your lockstyles based on character, job, and other conditions.'):color(1))
		add_to_chat(8,(' If multiple lockstyles are designated, one will be chosen at random.'):color(1))
		add_to_chat(8,' ')
		add_to_chat(8,(' Command '):color(36)..('Optional '):color(53)..('Required '):color(2)..(' - Description ['):color(8)..('Current Setting'):color(200)..(']'):color(8))
		add_to_chat(8,(' combat/c '):color(36)..('- Display lockstyles for your current job in combat zones.'):color(8))
		add_to_chat(8,(' town/t '):color(36)..('- Display lockstyles for your current job in town zones.'):color(8))
		add_to_chat(8,('   - add/a '):color(53)..('# '):color(2)..('- Add a lockstyle to the combat/town list.'):color(8))
		add_to_chat(8,('     - Number must be 1-200, 0 will clear list and disable.'):color(8))
		add_to_chat(8,('   - remove/r '):color(53)..('# '):color(2)..('- Remove a lockstyle from the combat/town list.'):color(8))
		add_to_chat(8,(' set/s'):color(36)..(' - Set (apply) lockstyle based on current conditions.'):color(8))
		add_to_chat(8,(' list/l'):color(36)..(' - List ALL lockstyles for the current character.'):color(8))
		add_to_chat(8,(' disable/d'):color(36)..(' #'):color(53)..(' - Display/update After Disable Delay (1-20, 0 to disable). ['):color(8)..(''..currDisableDelay):color(200)..(']'):color(8))
		add_to_chat(8,(' job/j'):color(36)..(' #'):color(53)..(' - Display/update After Job Change Delay (1-20, 0 to disable). ['):color(8)..(''..currJCDelay):color(200)..(']'):color(8))
		add_to_chat(8,(' zone/z'):color(36)..(' #'):color(53)..(' - Display/update After Zone Delay (1-20, 0 to disable). ['):color(8)..(''..currZoneDelay):color(200)..(']'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,(' Advanced Lockstyle conditions such as '):color(8)..('custom zones '):color(6)..('and '):color(8)..('specific weapons'):color(6))
		add_to_chat(8,(' can be found in the '):color(8)..('Vanity/data/lockstyles.lua '):color(1)..('file.'):color(8))

	elseif cmd == 'set' or cmd == 's' then
		setLockstyle()

	elseif cmd == 'disable' or cmd == 'd' then
		if sub_cmd == nil then
			local delay = settings.options.after_disable_delay
			add_to_chat(8,('[Vanity] '):color(220)..('After Disable Delay'):color(1)..(' is currently set to '):color(8)..(delay == 0 and ('OFF'):color(1) or (''..delay):color(1)..((' %s'):format(delay == 1 and 'second' or 'seconds')):color(8))..'.':color(8))
		else
			sub_cmd = tonumber(sub_cmd)
			--Reload the settings file to update with any new changes
			settings = config.load(defaults)
			if sub_cmd and sub_cmd >= 1 and sub_cmd <= 20 then
				settings.options.after_disable_delay = sub_cmd
				settings:save()
				local delay = settings.options.after_disable_delay
				add_to_chat(8,('[Vanity] '):color(220)..('After Disable Delay'):color(1)..(' is now '):color(8)..(delay..' seconds'):color(1)..('.'):color(8))
			elseif sub_cmd == 0 then
				settings.options.after_disable_delay = 0
				settings:save()
				add_to_chat(8,('[Vanity] '):color(220)..('After Disable Delay'):color(1)..(' is now '):color(8)..('OFF'):color(1)..('.'):color(8))
			else
				add_to_chat(8,('[Vanity] '):color(220)..('Please select a Disable Delay between '):color(8)..('1'):color(1)..(' and '):color(8)..('20'):color(1)..('.'):color(8))
				add_to_chat(8,'  Example: '..('//van '..cmd..' 9'):color(1))
			end
		end

	elseif cmd == 'jobchange' or cmd == 'j' then
		if sub_cmd == nil then
			local delay = settings.options.after_job_change_delay
			add_to_chat(8,('[Vanity] '):color(220)..('After Job Change Delay'):color(1)..(' is currently set to '):color(8)..(delay == 0 and ('OFF'):color(1) or (''..delay):color(1)..((' %s'):format(delay == 1 and 'second' or 'seconds')):color(8))..'.':color(8))
		else
			sub_cmd = tonumber(sub_cmd)
			--Reload the settings file to update with any new changes
			settings = config.load(defaults)
			if sub_cmd and sub_cmd >= 1 and sub_cmd <= 20 then
				settings.options.after_job_change_delay = sub_cmd
				settings:save()
				local delay = settings.options.after_job_change_delay
				add_to_chat(8,('[Vanity] '):color(220)..('After Job Change Delay'):color(1)..(' is now '):color(8)..(delay..' seconds'):color(1)..('.'):color(8))
			elseif sub_cmd == 0 then
				settings.options.after_job_change_delay = 0
				settings:save()
				add_to_chat(8,('[Vanity] '):color(220)..('After Job Change Delay'):color(1)..(' is now '):color(8)..('OFF'):color(1)..('.'):color(8))
			else
				add_to_chat(8,('[Vanity] '):color(220)..('Please select a Job Change Delay between '):color(8)..('1'):color(1)..(' and '):color(8)..('20'):color(1)..('.'):color(8))
				add_to_chat(8,'  Example: '..('//van '..cmd..' 9'):color(1))
			end
		end

	elseif cmd == 'zone' or cmd == 'z' then
		if sub_cmd == nil then
			local delay = settings.options.after_zone_delay
			add_to_chat(8,('[Vanity] '):color(220)..('After Zone Delay'):color(1)..(' is currently set to '):color(8)..(delay == 0 and ('OFF'):color(1) or (''..delay):color(1)..((' %s'):format(delay == 1 and 'second' or 'seconds')):color(8))..'.':color(8))
		else
			sub_cmd = tonumber(sub_cmd)
			--Reload the settings file to update with any new changes
			settings = config.load(defaults)
			if sub_cmd and sub_cmd >= 1 and sub_cmd <= 20 then
				settings.options.after_zone_delay = sub_cmd
				settings:save()
				local delay = settings.options.after_zone_delay
				add_to_chat(8,('[Vanity] '):color(220)..('After Zone Delay'):color(1)..(' is now '):color(8)..(delay..' seconds'):color(1)..('.'):color(8))
			elseif sub_cmd == 0 then
				settings.options.after_zone_delay = 0
				settings:save()
				add_to_chat(8,('[Vanity] '):color(220)..('After Zone Delay'):color(1)..(' is now '):color(8)..('OFF'):color(1)..('.'):color(8))
			else
				add_to_chat(8,('[Vanity] '):color(220)..('Please select a Zone Delay between '):color(8)..('1'):color(1)..(' and '):color(8)..('20'):color(1)..('.'):color(8))
				add_to_chat(8,'  Example: '..('//van '..cmd..' 9'):color(1))
			end
		end

	elseif cmd == 'list' or cmd == 'l' then
		listAllLockstyles()

	else
		add_to_chat(8,('[Vanity] '):color(220)..('Unrecognized command. Type'):color(8)..(' //van help'):color(1)..(' for a list of commands.'):color(8))

	end

end)

register_event('prerender', function()

	if os.time() > Heartbeat then

		Heartbeat = os.time()

		if job_change_timestamp > 0 and os.time() >= job_change_timestamp then
			job_change_timestamp = 0
			setLockstyle()
		end

	end
end)

register_event('incoming text',function(org)

	if settings.options.after_disable_delay ~= 0 and org:find('Style lock mode disabled.') then

		local location = getLocation()

		if location ~= 'town' then

			--wait a short delay after lockstyle is disabled, if too early will error
			coroutine.schedule(setLockstyle, settings.options.after_disable_delay)

		end

	end
end)

function initialize()
	player_name = get_player().name

	--Default lockstyles for this player (used only if migration fails)
	local default_lockstyles = {
		[player_name] = {
			["BLM"] = "{combat:0}{town:0}",
			["BLU"] = "{combat:0}{town:0}",
			["BRD"] = "{combat:0}{town:0}",
			["BST"] = "{combat:0}{town:0}",
			["COR"] = "{combat:0}{town:0}",
			["DNC"] = "{combat:0}{town:0}",
			["DRG"] = "{combat:0}{town:0}",
			["DRK"] = "{combat:0}{town:0}",
			["GEO"] = "{combat:0}{town:0}",
			["MNK"] = "{combat:0}{town:0}",
			["NIN"] = "{combat:0}{town:0}",
			["PLD"] = "{combat:0}{town:0}",
			["PUP"] = "{combat:0}{town:0}",
			["RDM"] = "{combat:0}{town:0}",
			["RNG"] = "{combat:0}{town:0}",
			["RUN"] = "{combat:0}{town:0}",
			["SAM"] = "{combat:0}{town:0}",
			["SCH"] = "{combat:0}{town:0}",
			["SMN"] = "{combat:0}{town:0}",
			["THF"] = "{combat:0}{town:0}",
			["WAR"] = "{combat:0}{town:0}",
			["WHM"] = "{combat:0}{town:0}",
		}
	}

	--Location of the lockstyles file
	lockstyles_file = files.new('data\\lockstyles.lua')

	--Reload settings file
	local settings = config.load(defaults)

	--Migrate any old-style lockstyle data from the settings file
	local function migrateOldLockstyles()
		local old_data = settings.lockstyles
		if not old_data then return false end

		lockstyles_data[player_name] = {}
		for job, value in pairs(old_data) do
			if type(value) == "string" then
				lockstyles_data[player_name][job:upper()] = value
			end
		end

		--Save old lockstyle data to lockstyles.lua file
		local file_contents = lockstyles_help_msg..'return '..T(lockstyles_data):tovstring()
		lockstyles_file:write(file_contents)

		add_to_chat(8, ('[Vanity] '):color(220)..('Migration of old lockstyle data complete for '):color(8)..(player_name):color(1)..('.'):color(8))
		add_to_chat(8, ('[Vanity] '):color(220)..('You may safely delete lockstyle data for '):color(8)..(player_name):color(1)..(' in '):color(8)..('data/settings.xml '):color(1)..('if you wish.'):color(8))
		return true
	end

	--File doesn't exist yet, create it using migrated data if available, otherwise use defaults
	if not lockstyles_file:exists() then
		local migrated = migrateOldLockstyles()
		if not migrated then
			lockstyles_data = default_lockstyles
			add_to_chat(8, ('[Vanity] '):color(220)..('Created default lockstyle data for '):color(8)..(player_name):color(1)..('.'):color(8))
			local file_contents = lockstyles_help_msg..'return '..T(lockstyles_data):tovstring()
			lockstyles_file:write(file_contents)
		end
	else
		--File already exists, load it
		lockstyles_data = require('data.lockstyles')

		--If this character has no lockstyle data yet, attempt migration or use defaults
		if not lockstyles_data[player_name] then
			local migrated = migrateOldLockstyles()
			if not migrated then
				lockstyles_data[player_name] = default_lockstyles[player_name]
				add_to_chat(8, ('[Vanity] '):color(220)..('Created default lockstyle data for '):color(8)..(player_name):color(1)..('.'):color(8))
				local file_contents = lockstyles_help_msg..'return '..T(lockstyles_data):tovstring()
				lockstyles_file:write(file_contents)
			end
		end
	end
end

register_event('load', function()
	--If already logged in, run initialize immediately and set the lockstyle
	if get_info().logged_in then
		initialize()
		setLockstyle()
	end
end)

register_event('login', function()
	--Wait 4 seconds for info to load then run initialize
	coroutine.schedule(function()
		initialize()
	end, 4)
end)
