--Copyright (c) 2025, Key
--All rights reserved.

--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:

--    * Redistributions of source code must retain the above copyright
--      notice, this list of conditions and the following disclaimer.
--    * Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in the
--      documentation and/or other materials provided with the distribution.
--    * Neither the name of Jingle nor the
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

_addon.name = 'Jingle'
_addon.version = '2.1'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'jingle','jin'}

require 'chat'
config = require('config')
files = require('files')

add_to_chat = windower.add_to_chat
addon_path = windower.addon_path
get_mob_array = windower.ffxi.get_mob_array
get_mob_by_target = windower.ffxi.get_mob_by_target
play_sound = windower.play_sound
register_event = windower.register_event

defaults = {
	distance = 50, --determines distance the target needs to be within before being "detected" (Note: Hard max is 50)
	flood_delay = 5, --how much time after a target goes out or range before it can be considered "nearby" again
}

settings = config.load(defaults)

--Default/example targets to pre-populate the targets.lua file
default_targets = {
	["Abject Obdella"] = "default",
	["Aurix"] = "default",
	["Biune Porxie"] = "default",
	["Cachaemic Bhoot"] = "default",
	["Chest"] = "default",
	["Demisang Deleterious"] = "default",
	["Diaphanous Bitzer"] = "default",
	["Esurient Botulus"] = "default",
	["Fetid Ixion"] = "default",
	["Grimslight"] = "default",
	["Gyvewrapped Naraka"] = "default",
	["Haughty Tulittia"] = "default",
	["Mog-Tablet"] = "default",
}

--Location of the targets file
targets_file = files.new('data\\targets.lua')

targets_help_msg = "--This file is used to store the names, IDs, and Hex IDs for targets that Jingle is looking for.\n\n"

function sortedTableString(tbl, indent)
	indent = indent or ""
	local lines = {}
	local keys = {}

	for k in pairs(tbl) do
		table.insert(keys, k)
	end
	table.sort(keys, function(a, b) return tostring(a):lower() < tostring(b):lower() end)

	for _, k in ipairs(keys) do
		local v = tbl[k]
		local formatted_key = type(k) == "string" and string.format("[%q]", k) or string.format("[%s]", tostring(k))
		if type(v) == "table" then
			table.insert(lines, indent..formatted_key.."={")
			table.insert(lines, sortedTableString(v, indent.."    "))
			table.insert(lines, indent.."},")
		else
			local formatted_val = type(v) == "string" and string.format("%q", v) or tostring(v)
			table.insert(lines, indent..formatted_key.."="..formatted_val..",")
		end
	end

	return table.concat(lines, "\n")
end

targets_data = {}

--If the data\targets.lua file doesn't exist, create it
if not targets_file:exists() then

	--Migrate legacy targets from settings file to new targets_data format
	local function migrateTargetsFromSettings()
		local function convertToDisplay(target)
			local function capitalize(str)
				-- Check if we think the string is a hex id
				local contains_numbers = string.match(str, "%d") ~= nil
				local is_special_case = #str == 3 and not string.match(str, "[G-Zg-z]")
				-- Hex ids get all their letters capitalized
				if contains_numbers or is_special_case then
					local capitalized = string.gsub(str, "(%a+)", function(word)
						return string.upper(word)
					end)
					return capitalized
				-- Otherwise we assume it's a name and capitalize it as such
				else
					local capitalized = string.gsub(str, "(%w)(%w*)", function(first_letter, rest)
						return string.upper(first_letter)..string.lower(rest)
					end)
					return capitalized
				end
			end
			target = capitalize(target) -- capitalize names
			target = string.gsub(target, "_", " ") --convert underscores to spaces
			return target
		end
		local migrated_targets = {}
		--Check if an old targets table exists in the settings file
		if settings.targets then
			--Loop through all the targets in it
			for key, value in pairs(settings.targets) do
				local readable_key = convertToDisplay(key)
				if not migrated_targets[readable_key] then
					migrated_targets[readable_key] = value.soundfile or 'default'
				end
			end
			add_to_chat(8,('[Jingle] '):color(220)..('Migration of old target data complete.'):color(36))
			add_to_chat(8,('[Jingle] '):color(220)..('You may safely delete target data in '):color(8)..('data/settings.xml '):color(1)..('if you wish.'):color(8))
			return migrated_targets
		else
			return nil
		end
	end

	local migrated = migrateTargetsFromSettings()
	targets_data = migrated and migrated or default_targets

	targets_file:write(targets_help_msg..'return {\n'..sortedTableString(targets_data, '    ')..'\n}')

else
	--File already exists, load it
	targets_data = require('data.targets')
end

announced = T{}
last_seen = T{}
temp_targets = {}

--Convert an index to a hex id
function convertToHexId(num)

	local hex_chars = "0123456789ABCDEF"
	local result = ""

	while num > 0 do
		local remainder = num % 16
		result = string.sub(hex_chars, remainder+1, remainder+1)..result
		num = math.floor(num / 16)
	end
	
	--Add leading zeros if necessary
	local padding = 3 - #result
	if padding > 0 then
		result = string.rep("0", padding)..result
	end
	
	return result

end

--Add a target and sound file to the external targets_data table
function addTarget(target, sound_file)

	--Remove file extension if present
	sound_file = string.match(sound_file, '^[^%.]+') or sound_file

	targets_data[target] = sound_file

	--Save the updated targets_data back to the file
	targets_file:write(targets_help_msg..'return {\n'..sortedTableString(targets_data, '    ')..'\n}')

	add_to_chat(8,('[Jingle] '):color(220)..('Target added: '):color(36)..(target):color(1)..(' ('):color(8)..(sound_file):color(1)..(' sound file)'):color(8))

end

--Add a temporary target and sound file to the internal temp_targets table
function addTempTarget(target, sound_file)

	--Remove file extension if present
	sound_file = string.match(sound_file, '^[^%.]+') or sound_file

	temp_targets[target] = sound_file

	add_to_chat(8,('[Jingle] '):color(220)..('Temp. Target added: '):color(36)..(target):color(1)..(' ('):color(8)..(sound_file):color(1)..(' sound file)'):color(8))

end

--Remove a target from targets_data or temp_targets
function removeTarget(target)

	local target_lower = target:lower()
	local matched_key = nil
	local source_table = nil

	--Search in permanent targets
	for key, _ in pairs(targets_data) do
		if key:lower() == target_lower then
			matched_key = key
			source_table = "permanent"
			break
		end
	end

	--If not found, search in temporary targets
	if not matched_key then
		for key, _ in pairs(temp_targets) do
			if key:lower() == target_lower then
				matched_key = key
				source_table = "temporary"
				break
			end
		end
	end

	if matched_key and source_table then
		if source_table == "permanent" then
			targets_data[matched_key] = nil
			targets_file:write(targets_help_msg..'return {\n'..sortedTableString(targets_data, '    ')..'\n}')
		elseif source_table == "temporary" then
			temp_targets[matched_key] = nil
		end

		add_to_chat(8, '[Jingle] '..('Removed: '):color(36)..matched_key:color(1)..('%s'):format(source_table == "temporary" and ' (Temp. Target)' or ''):color(8))
	else
		add_to_chat(8, '[Jingle] '..target:color(1)..' was not found.':color(28))
		add_to_chat(8, '[Jingle] '..'Type '..'//jin list':color(1)..' to see stored targets.':color(8))
	end
end

--List the targets in the external targets_data table
function listTargets()
	local permanent = {}
	local temporary = {}

	add_to_chat(8,('[Jingle] '):color(220)..('Targets: '):color(36))

	--Separate permanent and temporary targets
	for target in pairs(targets_data) do
		table.insert(permanent, target)
	end
	for target in pairs(temp_targets) do
		table.insert(temporary, target)
	end

	--Sort both alphabetically (case-insensitive)
	table.sort(permanent, function(a, b) return a:lower() < b:lower() end)
	table.sort(temporary, function(a, b) return a:lower() < b:lower() end)

	--Display permanent targets
	if #permanent == 0 then
		add_to_chat(1,(' - '):color(8)..'[Empty]')
	else
		for _, target in ipairs(permanent) do
			local sound = targets_data[target]
			add_to_chat(1,(' - '):color(8)..target..' ('..sound..')')
		end
	end

	--Display temporary targets only if they exist
	if #temporary > 0 then
		add_to_chat(8,('[Jingle] '):color(220)..('Temporary Targets:'):color(36))
		for _, target in ipairs(temporary) do
			local sound = temp_targets[target]
			add_to_chat(1,(' - '):color(8)..target..' ('..sound..')')
		end
	end
end

--Check for matching targets
function checkForTarget()

	local current_time = os.time()
	local nearby = T{}
	local mob_array = get_mob_array()
	local max_distance = tonumber(settings.distance)

	--Loop through all mobs in memory
	for _, mob in pairs(mob_array) do

		local distance = math.floor(mob.distance:sqrt() * 100) / 100

		--Mob is a valid_target and is within our determined distance
		if mob.valid_target and distance <= max_distance then

			--Keys to match this mob to
			local keys = {
				mob.name,					--Exact case-sensitive name match
				string.lower(mob.name),		--Lowercased name
				tostring(mob.id),			--Numeric ID
				convertToHexId(mob.index)	--Hex ID
			}

			--Loop through the above keys
			for _, key in ipairs(keys) do

				local sound_file = targets_data[key] or temp_targets[key]

				--Does this key have an entry in targets_data?
				if sound_file then

					--Add this target to the list of nearby mobs
					table.insert(nearby, key)

					local last_seen_time = last_seen[key] or 0

					--Notify player as long as this target 1)hasn't already been announced or 2)isn't within the flood delay
					if not announced:contains(key) and (current_time - last_seen_time > settings.flood_delay) then

						local displayName = (key == convertToHexId(mob.index)) and (mob.name..' ('..key..')') or mob.name
						play_sound(addon_path..'data/sounds/'..sound_file..'.wav')
						add_to_chat(8,('[Jingle] '):color(220)..displayName:color(1)..' is nearby.':color(8))
						table.insert(announced, key)

					end

					--Update the last time we saw this target nearby (for the flood delay)
					last_seen[key] = current_time
					break --Stop checking other keys once a match is found

				end
			end
		end
	end

	--Remove targets from 'announced' if they haven't been seen in the last X seconds
	for i = #announced, 1, -1 do

		local key = announced[i]

		if not last_seen[key] or (current_time - last_seen[key] > settings.flood_delay) then
			table.remove(announced, i)
			last_seen[key] = nil
		end

	end
end

register_event('addon command',function(addcmd, ...)

	local args = {...}
	local arg1 = args[1] --target
	local arg2 = args[2] --sound file name

	if addcmd == 'help' then

		local currDist = settings.distance

		local prefix = "//jingle, //jin"
		add_to_chat(8,('[Jingle] '):color(220)..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220)..(' ('):color(8)..(prefix):color(1)..(')'):color(8))
		add_to_chat(8,(' Command '):color(36)..('<required>'):color(2)..(' [optional]'):color(53)..(' - Description ['):color(8)..('Current Setting'):color(200)..(']'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,(' add/a '):color(36)..('[target]'):color(53)..(' [sound_file_name]'):color(53)..(' - Add a target with an optional sound file.'):color(8))
		add_to_chat(8,(' temp/t '):color(36)..('[target]'):color(53)..(' [sound_file_name]'):color(53)..(' - Add a temporary target with an optional sound file.'):color(8))
		add_to_chat(8,('   - Valid targets: Names (ex: Oseem), IDs (ex: 17809550), Hex IDs (ex: 08E).'):color(8))
		add_to_chat(8,('   - Use quotes to surround an NPC/mob name that contains spaces or an apostrophe.'):color(8))
		add_to_chat(8,('   - If no target supplied, the current cursor target name will be used with the default sound.'):color(8))
		add_to_chat(8,('   - Temporary targets will be removed after zoning.'):color(8))
		add_to_chat(8,(' remove/r '):color(36)..('[target]'):color(53)..(' - Remove a target.'):color(8))
		add_to_chat(8,(' list/l'):color(36)..(' - Show the list of targets and sounds associated.'):color(8))
		add_to_chat(8,(' distance/d '):color(36)..('<#1-50>'):color(2)..(' - Set the detection distance. ['):color(8)..(''..currDist):color(200)..(']'):color(8))
		add_to_chat(8,(' test '):color(36)..('<sound_file_name>'):color(2)..(' - Test a sound file.'):color(8))
		add_to_chat(8,('   - New sounds added to the /data/sounds folder must be .wav format.'):color(8))

	elseif addcmd == 'add' or addcmd == 'a' then
		local target = arg1 or (get_mob_by_target('t') or {}).name
		local sound_file = arg2 or "default"

		if target then
			addTarget(target, sound_file)
		else
			add_to_chat(8,('[Jingle] '):color(220)..('Please highlight or specify a target to be added (name, id, or hex id).'):color(28))
		end

	elseif addcmd == 'temp' or addcmd == 't' then
		local target = arg1 or (get_mob_by_target('t') or {}).name
		local sound_file = arg2 or "default"

		if target then
			addTempTarget(target, sound_file)
		else
			add_to_chat(8,('[Jingle] '):color(220)..('Please highlight or specify a target to be added (name, id, or hex id).'):color(28))
		end

	elseif addcmd == 'remove' or addcmd == 'rem' or addcmd == 'rmv' or addcmd == 'r' then
		local target = arg1 or (get_mob_by_target('t') or {}).name
		if target then
			removeTarget(target)
		else
			add_to_chat(8,('[Jingle] '):color(220)..('Please highlight or specify a target to be removed (name, ID, or Hex ID).'):color(28))
		end

	elseif addcmd == 'list' or addcmd == 'l' then
		listTargets()

	elseif addcmd == 'test' then
		if arg1 == nil then
			add_to_chat(8,('[Jingle] '):color(220)..('Please specify a sound file name to be tested.'):color(28))
			add_to_chat(8,('[Jingle] '):color(220)..('Example: '):color(8)..(' //jin test default'):color(1))
			return
		end
		
		local sound_file = arg1

		--Remove file extension if present
		sound_file = string.match(sound_file, '^[^%.]+') or sound_file

		play_sound(addon_path..'data/sounds/'..sound_file..'.wav')
		add_to_chat(8,('[Jingle] '):color(220)..('Testing file: '):color(8)..('addons/Jingle/data/sounds/'..sound_file..'.wav'):color(1))
		add_to_chat(8,('[Jingle] '):color(220)..('If you do not hear the sound, make sure the file is in the correct folder and is in the .wav format.'):color(8))

	elseif addcmd == 'distance' or addcmd == 'dist' or addcmd == 'd' then
		local distance = tonumber(arg1)

		if not distance then
			add_to_chat(8,('[Jingle] '):color(220)..('Detection distance:'):color(8)..(' '..settings.distance):color(200))

		elseif distance >= 1 and distance <= 50 then
			settings.distance = distance
			settings:save('all')
			add_to_chat(8,('[Jingle] '):color(220)..('Detection distance set to:'):color(36)..(' '..distance):color(200))

		else
			add_to_chat(8,('[Jingle] '):color(220)..('Detection distance must be a number between 1 and 50.'):color(28))
		end

	else
		add_to_chat(8,('[Jingle] '):color(220)..('Unrecognized command. Type'):color(28)..(' //jin help'):color(1)..(' if you need help.'):color(28))

	end
end)

register_event('prerender', function()
	checkForTarget()
end)

windower.register_event('zone change', function()

	--Clear temporary targets after zone
	if next(temp_targets) ~= nil then

		temp_targets = {}

		coroutine.schedule(function()
			add_to_chat(8, ('[Jingle] '):color(220)..('Temporary targets cleared on zone change.'):color(8))
		end, 5)

	end

end)
