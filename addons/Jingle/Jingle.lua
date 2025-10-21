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
_addon.version = '2.5'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'jingle','jin'}

require 'chat'
config = require('config')
files = require('files')
res = require('resources')
texts = require('texts')

add_to_chat = windower.add_to_chat
addon_path = windower.addon_path
get_info = windower.ffxi.get_info
get_mob_array = windower.ffxi.get_mob_array
get_mob_by_index = windower.ffxi.get_mob_by_index
get_mob_by_target = windower.ffxi.get_mob_by_target
get_player = windower.ffxi.get_player
play_sound = windower.play_sound
register_event = windower.register_event

current_time = 0
last_check_time = 0
announced = T{}
last_seen = T{}
dir_full = {
	['E '] = 'East',
	['NE'] = 'North-East',
	['N '] = 'North',
	['NW'] = 'North-West',
	['W '] = 'West',
	['SW'] = 'South-West',
	['S '] = 'South',
	['SE'] = 'South-East',
}

--Defaults values loaded on first run. Do not edit these here, edit them in the data/settings.xml file
defaults = {
	distance = 50, --Distance the target needs to be within before being "detected" (Note: Hard max is 50).
	flood_delay = 5, --Time in seconds after a target goes out of range before it can be considered "nearby" again.
	polling_rate = .2, --Time in seconds between each check for targets (0 = every frame).
	target_tracker = {
		auto_hide = true,
		bg_alpha = 150,
		bold = true,
		colorize = true,
		colors = {
			close = "255,050,050",
			far = "050,255,050",
			mid = "250,130,40",
		},
		distance_close = 10,
		distance_mid = 20,
		draggable = true,
		font = "Consolas",
		pos = {
			x = 10,
			y = 400,
		},
		show = false,
		size = 10,
	},
}

settings = config.load(defaults)
settings:save('all')

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
	["???|Temenos"] = "default",
	["???|Apollyon"] = "default",
}

--Location of the targets file
targets_file = files.new('data\\targets.lua')

targets_help_msg = "--This file stores the names, IDs, and Hex IDs for targets that Jingle is looking for.\n\n"

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
			add_to_chat(1,'[Jingle] ':color(220)..'Migration of old target data complete.':color(36))
			add_to_chat(1,'[Jingle] ':color(220)..'You may safely delete target data in ':color(8)..'data/settings.xml '..'if you wish.':color(8))
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

--Create the Target Tracker text object
target_tracker = texts.new()
target_tracker:bold(settings.target_tracker.bold)
target_tracker:bg_alpha(settings.target_tracker.bg_alpha)
target_tracker:draggable(settings.target_tracker.draggable)
target_tracker:font(settings.target_tracker.font)
target_tracker:pad(2)
target_tracker:pos(settings.target_tracker.pos.x, settings.target_tracker.pos.y)
target_tracker:show(settings.target_tracker.show)
target_tracker:size(settings.target_tracker.size)

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

--Truncate names that are too long
function truncateName(name)

	--max name length
	local num = 20

	--Check if the string length is greater than the max name length
	if #name > num then
		--Truncate and add an ellipsis
		name = string.sub(name, 1, num-1).."…"
	end

	return name
end

--Add a target and sound file
function addTarget(target, sound_file)

	--Remove file extension if present
	sound_file = string.match(sound_file, '^[^%.]+') or sound_file

	--Save new target info
	targets_data[target] = sound_file

	--Save the updated targets_data back to the file
	targets_file:write(targets_help_msg..'return {\n'..sortedTableString(targets_data, '    ')..'\n}')

	add_to_chat(1,'[Jingle] ':color(220)..'Target added: ':color(36)..target..' (':color(8)..sound_file..' sound file)':color(8))

end

--Add a zone-based target and sound file
function addZoneTarget(target, sound_file)
	--Remove file extension if present
	sound_file = string.match(sound_file, '^[^%.]+') or sound_file

	--Get current zone name
	local zone_info = get_info()
	local zone_name = res.zones[zone_info.zone] and res.zones[zone_info.zone].name or "Unknown"

	--Create a compound key using the target and zone
	local compound_key = target..'|'..zone_name

	--Add or update the target
	targets_data[compound_key] = sound_file

	--Save updated data to file
	targets_file:write(targets_help_msg..'return {\n'..sortedTableString(targets_data, '    ')..'\n}')

	add_to_chat(1,'[Jingle] ':color(220)..'Zone Target added: ':color(36)..target..' in '..zone_name:color(200)..(sound_file ~= "default" and ' ('..sound_file..')' or ''))
end

--Add a temporary target and sound file
function addTempTarget(target, sound_file)

    --Remove file extension if present
    sound_file = string.match(sound_file, '^[^%.]+') or sound_file

    --Create compound key for temporary target
    local key = ('%s|temporary'):format(target)

    --Save new target info to main targets_data
    targets_data[key] = sound_file

    --Write back to file
    targets_file:write(targets_help_msg..'return {\n'..sortedTableString(targets_data, '    ')..'\n}')

    add_to_chat(1, '[Jingle] ':color(220)..'Temp. Target added: ':color(36)..target..' (':color(8)..sound_file..' sound file)':color(8))
end

function removeTarget(target)
	local target_lower = target:lower()
	local matched_key = nil
	local matched_type = nil
	local base_name = nil

	local zone_info = get_info()
	local zone_name = res.zones[zone_info.zone] and res.zones[zone_info.zone].name or "Unknown"

	--Check permanent and zone targets
	for key, _ in pairs(targets_data) do
		local name, suffix = string.match(key, "^(.-)|(.+)$")
		if not name then
			name = key
			suffix = nil
		end

		if name:lower() == target_lower then
			if suffix == nil then
				matched_key = key
				base_name = name
				matched_type = "permanent"
				break
			elseif suffix == "temporary" then
				matched_key = key
				base_name = name
				matched_type = "temporary"
				break
			elseif suffix == zone_name then
				matched_key = key
				base_name = name
				matched_type = "zone-exact"
				break
			elseif not matched_key then
				matched_key = key
				base_name = name
				matched_type = "zone"
			end
		end
	end

	if matched_key and matched_type then
		targets_data[matched_key] = nil
		targets_file:write(targets_help_msg..'return {\n'..sortedTableString(targets_data, '    ')..'\n}')

		local type_display = ({
			["temporary"] = " (Temp. Target)",
			["zone"] = " (Zone Target)",
			["zone-exact"] = " (Zone Target)",
		})[matched_type] or ""

		add_to_chat(1,'[Jingle] ':color(220)..'Removed: ':color(36)..base_name..type_display:color(8))
	else
		add_to_chat(1,'[Jingle] ':color(220)..target..' was not found.':color(28))
		add_to_chat(1,'[Jingle] ':color(220)..'Type ':color(8)..'//jin list'..' to see stored targets.':color(8))
	end
end

--List the targets in the external targets_data table
function listTargets()
	local permanent = {}
	local temporary = {}
	local zone_based = {}

	local zone_info = get_info()
	local current_zone = res.zones[zone_info.zone] and res.zones[zone_info.zone].name or "Unknown"

	add_to_chat(1,'[Jingle] ':color(220)..'Permanent Targets: ':color(36))

	for target in pairs(targets_data) do
		if target:find("|") then
			local base, suffix = target:match("^(.-)|(.*)$")
			if suffix == "temporary" then
				table.insert(temporary, target)
			else
				table.insert(zone_based, target)
			end
		else
			table.insert(permanent, target)
		end
	end

	--Sort alphabetically
	local sorter = function(a, b) return a:lower() < b:lower() end
	table.sort(permanent, sorter)
	table.sort(temporary, sorter)
	table.sort(zone_based, sorter)

	--Permanent targets
	if #permanent > 0 then
		for _, target in ipairs(permanent) do
			local sound = targets_data[target]
			add_to_chat(1, ' - ':color(8)..target..(sound ~= 'default' and ' ('..sound..')' or ''))
		end
	else
		add_to_chat(1, ' - ':color(8)..'[Empty]')
	end

	--Zone-based targets
	if #zone_based > 0 then
		add_to_chat(1, '[Jingle] ':color(220)..'Zone Targets:':color(36))
		for _, target in ipairs(zone_based) do
			local name, zone = target:match("^(.-)|(.*)$")
			local sound = targets_data[target]
			add_to_chat(1, ' - ':color(8)..name..' ['..zone..']'..(sound ~= 'default' and ' ('..sound..')' or ''))
		end
	end

	--Temporary targets
	if #temporary > 0 then
		add_to_chat(1, '[Jingle] ':color(220)..'Temporary Targets:':color(36))
		for _, target in ipairs(temporary) do
			local name = target:match("^(.-)|") or target
			local sound = targets_data[target]
			add_to_chat(1, ' - ':color(8)..name..(sound ~= 'default' and ' ('..sound..')' or ''))
		end
	end
end

--Get angle in degrees between player and target (thanks Genoxd!)
function getAngle(player, target)
	local dx = target.x - player.x
	local dy = target.y - player.y
	local angle = math.atan2(dy, dx) --returns radians
	local degrees = math.deg(angle) --convert to degrees
	return (degrees + 360) % 360 --normalize to 0-360
end

--Convert angle in degrees to compass direction
function getDirection(degrees)
	if degrees >= 337.5 or degrees < 22.5 then
		return 'E '
	elseif degrees < 67.5 then
		return 'NE'
	elseif degrees < 112.5 then
		return 'N '
	elseif degrees < 157.5 then
		return 'NW'
	elseif degrees < 202.5 then
		return 'W '
	elseif degrees < 247.5 then
		return 'SW'
	elseif degrees < 292.5 then
		return 'S '
	elseif degrees < 337.5 then
		return 'SE'
	end
end

--Check for matching targets
function checkForTarget()

	local current_time = os.clock()
	local nearby = T{}
	local mob_array = get_mob_array()
	local max_distance = tonumber(settings.distance)
	local current_zone_id = windower.ffxi.get_info().zone
	local current_zone_name = res.zones[current_zone_id] and res.zones[current_zone_id].name or "Unknown"

	--Loop through all mobs in memory
	for _, mob in pairs(mob_array) do

		local distance = math.floor(mob.distance:sqrt() * 100) / 100

		--Mob is a valid_target and within distance range
		if mob.valid_target and distance ~= 0 and distance <= max_distance then

			--Keys to match this mob to (in order)
			local keys = {
				mob.name..'|' .. current_zone_name,	-- Zone-based
				mob.name..'|temporary',				-- Temporary
				mob.name,							-- Permanent
				string.lower(mob.name),
				tostring(mob.id),
				convertToHexId(mob.index)
			}

			--Loop through all keys to check if this mob is being tracked
			for _, key in ipairs(keys) do
				local sound_file = targets_data[key]

				if sound_file then
					table.insert(nearby, key)

					local last_seen_time = last_seen[key] or 0
					local player = get_mob_by_index(get_player().index)
					local degrees = getAngle(player, mob)
					local direction = getDirection(degrees)
					local rounded_distance = math.floor(distance + 0.5)

					--Notify player if not already announced or flood delay has passed
					if (not announced[key]) and (current_time - last_seen_time > settings.flood_delay) then
						local displayName = (key == convertToHexId(mob.index)) and (mob.name..' ('..key..')') or mob.name

						if direction then
							add_to_chat(1, '[Jingle] ':color(220)..displayName:color(1)..' detected ':color(8)..rounded_distance..'y':color(1)..' to the ':color(8)..dir_full[direction]:color(1)..'.':color(8))
						else
							add_to_chat(1, '[Jingle] ':color(220)..displayName..' is nearby.':color(8))
						end

						play_sound(addon_path..'data/sounds/'..sound_file..'.wav')

						-- Store full data for target in announced table
						announced[key] = {
							name = mob.name,
							distance = rounded_distance,
							direction = direction or "??",
							last_seen = current_time
						}
					else
						-- Update distance/direction if already announced
						if announced[key] then
							announced[key].distance = rounded_distance
							announced[key].direction = direction or "??"
							announced[key].last_seen = current_time
						end
					end

					--Track last seen for flood delay
					last_seen[key] = current_time
					break --Stop checking further keys
				end
			end
		end
	end

	--Clean up old announced entries
	for key, info in pairs(announced) do
		if not last_seen[key] or (current_time - info.last_seen > settings.flood_delay) then
			announced[key] = nil
			last_seen[key] = nil
		end
	end
end

--Update the on-screen Target Tracker
function updateTargetTracker()

	local text = ""

	for key, info in pairs(announced) do

		local last_seen = info.last_seen or 0

		if current_time <= last_seen + .1 then -- add .1 seconds difference tolerance so it doesn't blink when slightly off

			local name = info.name or key
			local distance = info.distance or 0
			local direction = info.direction or "??"
			local max_name_length = 20 -- max spaces allocated to a name
			local name_length = math.min(#name, max_name_length)

			-- Determine color based on distance
			local color = "255,255,255"
			if settings.target_tracker.colorize then
				if distance <= settings.target_tracker.distance_close then
					color = settings.target_tracker.colors.close
				elseif distance <= settings.target_tracker.distance_mid then
					color = settings.target_tracker.colors.mid
				else
					color = settings.target_tracker.colors.far
				end
			end

			local spaces = ""
			local diff = max_name_length - name_length
			for i = 1, diff do
				spaces = spaces.." "
			end

			distance = string.format("%2d", distance)

			text = text..string.format("\\cs("..color..")%sy %s ·\\cr%s\n", --●
				distance,
				direction,
				truncateName(name)
			)

		end

	end

	if settings.target_tracker.auto_hide then
		if text == "" then
			target_tracker:hide()
		else
			target_tracker:show()
		end
	end

	local header = "\\cs(50,120,255)Target Tracker    //jin help\\cr\n"
	text = header..text
	target_tracker:text(text)

end

register_event('addon command',function(addcmd, ...)

	local args = {...}
	local arg1 = args[1] --target
	local arg2 = args[2] --sound file name

	if addcmd == 'help' then

		local currDist = tostring(settings.distance)
		local currTracker = settings.target_tracker.show and "ON" or "OFF"

		local prefix = "//jingle, //jin"
		add_to_chat(1,'[Jingle] ':color(220)..'Version ':color(8).._addon.version:color(220)..' by ':color(8).._addon.author:color(220)..' (':color(8)..prefix..')':color(8))
		add_to_chat(1,' Command ':color(36)..'<required>':color(2)..' [optional]':color(53)..' - Description [':color(8)..'Current Setting':color(200)..']':color(8))
		add_to_chat(1,' ')
		add_to_chat(1,' add/a ':color(36)..'[target]':color(53)..' [sound_file_name]':color(53)..' - Add a target with an optional sound file.':color(8))
		add_to_chat(1,' zone/z ':color(36)..'[target]':color(53)..' [sound_file_name]':color(53)..' - Add a target with an optional sound file for the current zone only.':color(8))
		add_to_chat(1,' temp/t ':color(36)..'[target]':color(53)..' [sound_file_name]':color(53)..' - Add a temporary target with an optional sound file.':color(8))
		add_to_chat(1,'   - Valid targets: Names (ex: Oseem), IDs (ex: 17809550), Hex IDs (ex: 08E).':color(8))
		add_to_chat(1,'   - Use quotes to surround an NPC/mob name that contains spaces or an apostrophe.':color(8))
		add_to_chat(1,'   - If no target supplied, the current cursor target name will be used with the default sound.':color(8))
		add_to_chat(1,'   - Temporary targets will be removed after zoning.':color(8))
		add_to_chat(1,' remove/r ':color(36)..'[target]':color(53)..' - Remove a target.':color(8))
		add_to_chat(1,' list/l':color(36)..' - Show the list of targets and sounds associated.':color(8))
		add_to_chat(1,' distance/d ':color(36)..'<#1-50>':color(2)..' - Set the detection distance. [':color(8)..currDist:color(200)..']':color(8))
		add_to_chat(1,' show/hide ':color(36)..' - Enable the Target Tracker. [':color(8)..currTracker:color(200)..']':color(8))
		add_to_chat(1,' test ':color(36)..'<sound_file_name>':color(2)..' - Test a sound file.':color(8))
		add_to_chat(1,'   - New sounds added to the /data/sounds folder must be .wav format.':color(8))

	elseif addcmd == 'add' or addcmd == 'a' then
		local target = arg1 or (get_mob_by_target('t') or {}).name
		local sound_file = arg2 or "default"

		if target then
			addTarget(target, sound_file)
		else
			add_to_chat(1,'[Jingle] ':color(220)..'Please highlight or specify a target to be added (name, id, or hex id).':color(28))
		end

	elseif addcmd == 'zone' or addcmd == 'z' then
		local target = arg1 or (get_mob_by_target('t') or {}).name
		local sound_file = arg2 or "default"

		if target then
			addZoneTarget(target, sound_file)
		else
			add_to_chat(1,'[Jingle] ':color(220)..'Please highlight or specify a target to be added (name, id, or hex id).':color(28))
		end

	elseif addcmd == 'temp' or addcmd == 't' then
		local target = arg1 or (get_mob_by_target('t') or {}).name
		local sound_file = arg2 or "default"

		if target then
			addTempTarget(target, sound_file)
		else
			add_to_chat(1,'[Jingle] ':color(220)..'Please highlight or specify a target to be added (name, id, or hex id).':color(28))
		end

	elseif addcmd == 'remove' or addcmd == 'rem' or addcmd == 'rmv' or addcmd == 'r' or addcmd == 'delete' then
		local target = arg1 or (get_mob_by_target('t') or {}).name
		if target then
			removeTarget(target)
		else
			add_to_chat(1,'[Jingle] ':color(220)..'Please highlight or specify a target to be removed (name, ID, or Hex ID).':color(28))
		end

	elseif addcmd == 'list' or addcmd == 'l' then
		listTargets()

	elseif addcmd == 'test' then
		if arg1 == nil then
			add_to_chat(1,'[Jingle] ':color(220)..'Please specify a sound file name to be tested.':color(28))
			add_to_chat(1,'[Jingle] ':color(220)..'Example: ':color(8)..' //jin test default')
			return
		end
		
		local sound_file = arg1

		--Remove file extension if present
		sound_file = string.match(sound_file, '^[^%.]+') or sound_file

		play_sound(addon_path..'data/sounds/'..sound_file..'.wav')
		add_to_chat(1,'[Jingle] ':color(220)..'Testing file: ':color(8)..'addons/Jingle/data/sounds/'..sound_file..'.wav')
		add_to_chat(1,'[Jingle] ':color(220)..'If you do not hear the sound, make sure the file is in the correct folder and is in the .wav format.':color(8))

	elseif addcmd == 'distance' or addcmd == 'dist' or addcmd == 'd' then
		local distance = tonumber(arg1)

		if not distance then
			distance = tostring(settings.distance)
			add_to_chat(1,'[Jingle] ':color(220)..'Detection distance: ':color(8)..distance:color(200))

		elseif distance >= 1 and distance <= 50 then
			settings.distance = distance
			settings:save('all')
			distance = tostring(distance)
			add_to_chat(1,'[Jingle] ':color(220)..'Detection distance set to: ':color(36)..distance:color(200))

		else
			add_to_chat(1,'[Jingle] ':color(220)..'Detection distance must be a number between 1 and 50.':color(28))
		end

	elseif addcmd == 'show' or addcmd == 'hide' or addcmd == "tracker" or addcmd == "track" then
		settings.target_tracker.show = not settings.target_tracker.show
		settings:save('all')
		local tracker = settings.target_tracker.show and "ON" or "OFF"
		add_to_chat(1,'[Jingle] ':color(220)..'Target Tracker set to: ':color(36)..tracker:color(200))
		if settings.target_tracker.show then
			target_tracker:show()
		else
			target_tracker:hide()
		end

	else
		add_to_chat(1,'[Jingle] ':color(220)..'Unrecognized command. Type':color(28)..' //jin help'..' for a list of commands.':color(28))

	end
end)

register_event('prerender', function()

	current_time = os.clock()

	if settings.polling_rate == 0 then
        --Run every frame
        checkForTarget()
		if settings.target_tracker.show then
			updateTargetTracker()
		end
    else
        if current_time - last_check_time >= settings.polling_rate then
            last_check_time = current_time
            checkForTarget()
			if settings.target_tracker.show then
				updateTargetTracker()
			end
        end
    end

end)

windower.register_event('zone change', function()

	--Clear temporary targets after zone
	local temp_targets_cleared = false

	for key in pairs(targets_data) do
		if key:sub(-10) == '|temporary' then
			targets_data[key] = nil
			temp_targets_cleared = true
		end
	end

	if temp_targets_cleared then
		targets_file:write(targets_help_msg..'return {\n'..sortedTableString(targets_data, '    ')..'\n}')
		coroutine.schedule(function()
			add_to_chat(1, '[Jingle] ':color(220)..'Temporary targets cleared on zone change.':color(8))
		end, 5)
	end

end)

--Handle mouse events
register_event('mouse',function(mouse_type, mouse_x, mouse_y)

	if mouse_type == 2 then --leftmouseup

		--Save Bar positions after dragged
		local x = target_tracker:pos_x()
		local y = target_tracker:pos_y()

		if settings.target_tracker.pos.x ~= x or settings.target_tracker.pos.y ~= y then
			settings.target_tracker.pos = {x = x, y = y}
			settings:save('all')
		end

	end

end)
