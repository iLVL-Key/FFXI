--Copyright (c) 2024, Key
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
_addon.version = '1.2'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'jingle'}

require 'chat'
config = require('config')

defaults = {}
defaults.targets = {} --the main list of targets we're searching for
defaults.distance = 50 --determines distance the target needs to be within before being "detected" (Note: Hard max is 50)

settings = config.load(defaults)

local played = T{}


-- Capitalize letters accordingly
function capitalize(str)

	-- Check if we think the string is a hex id
	local containsNumbers = string.match(str, "%d") ~= nil
	local isSpecialCase = #str == 3 and not string.match(str, "[G-Zg-z]")

	-- Hex ids get all their letters capitalized
	if containsNumbers or isSpecialCase then
		local capitalized = string.gsub(str, "(%a+)", function(word)
			return string.upper(word)
		end)
		return capitalized

	-- Otherwise we assume it's a name and capitalize it as such
	else
		local capitalized = string.gsub(str, "(%w)(%w*)", function(firstLetter, rest)
			return string.upper(firstLetter) .. string.lower(rest)
		end)
		return capitalized

	end

end

-- Convert an index to a hex id (albeit with lowercase to match the saved entries)
function convertToHexId(num)
    local hexChars = "0123456789abcdef"
    local result = ""

	while num > 0 do
        local remainder = num % 16
        result = string.sub(hexChars, remainder+1, remainder+1) .. result
        num = math.floor(num / 16)
    end
    
    -- Add leading zeros if necessary
    local padding = 3 - #result
    if padding > 0 then
        result = string.rep("0", padding) .. result
    end
    
    return result

end

-- Convert targets to save them properly
function convertToSave(target)
	target = string.lower(target) --convert target to all lowercase
	target = string.gsub(target, " ", "_") --convert spaces to underscores
	return target
end

-- Convert targets to display them properly
function convertToDisplay(target)
	target = capitalize(target) -- capitalize names
	target = string.gsub(target, "_", " ") --convert underscores to spaces
	return target
end

-- Add a target and sound file to the targets table
function addTarget(target, soundfile)
	local person = {
		soundfile = soundfile
	}
	
	settings.targets[convertToSave(target)] = person
	settings:save('all')
	
	windower.add_to_chat(220,'[Jingle] '..('Added: '):color(36)..(capitalize(target)..' ('..soundfile..')'):color(1))

end

-- Remove a target from the Names table
function removeName(target)
	local savedTarget = convertToSave(target)

	if settings.targets[savedTarget] then
		settings.targets[savedTarget] = nil
		windower.add_to_chat(220,'[Jingle] '..('Removed: '):color(36)..(capitalize(target)):color(1))
		settings:save('all')

	else
		windower.add_to_chat(220,'[Jingle] '..(capitalize(target)):color(1)..(' was not found.'):color(39))
		windower.add_to_chat(220,'[Jingle] '..('Type '):color(8)..('//jingle list'):color(1)..(' to see stored targets.'):color(8))

	end
end

-- List the targets in the targets table
function listTargets()
	local sortedTargets = {}

	windower.add_to_chat(220,'[Jingle] '..('Targets: '):color(8))

	-- Copy targets and sort them alphabetically
	for target, sound in pairs(settings.targets) do
		table.insert(sortedTargets, target)
	end
	table.sort(sortedTargets)

	-- Check if sortedTargets is empty
	if next(sortedTargets) == nil then
		windower.add_to_chat(1,(' - '):color(8)..'[Empty]')
	end

	-- Add sorted targets to chat
	for _, target in ipairs(sortedTargets) do
		local sound = settings.targets[target]
		windower.add_to_chat(1,(' - '):color(8)..convertToDisplay(target)..' ('..sound.soundfile..')')
	end

end

-- Check for matching targets
function checkForTarget()
	local nearby = T{}

	for i,v in pairs(windower.ffxi.get_mob_array()) do -- loop through all the mobs in memory (nearby)
		local distance = math.floor(v.distance:sqrt() * 100) / 100

		-- does a name nearby match an entry in our main targets table?
		if settings.targets[convertToSave(v.name)] and v.valid_target and distance <= tonumber(settings.distance) then
			table.insert(nearby, v.name) -- add target to list of those nearby

			if not played:contains(v.name) then -- sound for this target has not been played yet
				local soundFile = settings.targets[convertToSave(v.name)].soundfile
				windower.play_sound(windower.addon_path..'data/sounds/'..soundFile..'.wav')
				
				windower.add_to_chat(220,'[Jingle] '..(v.name):color(1)..(' is nearby.'):color(8))
				
				table.insert(played, v.name) -- add target to the played list

			end

		-- does an id nearby match an entry in our main targets table?
		elseif settings.targets[convertToSave(v.id)] and v.valid_target and distance <= tonumber(settings.distance) then
			table.insert(nearby, v.id) -- add id to list of those nearby

			if not played:contains(v.id) then -- sound for this id has not been played yet
				local soundFile = settings.targets[convertToSave(v.id)].soundfile
				windower.play_sound(windower.addon_path..'data/sounds/'..soundFile..'.wav')

				windower.add_to_chat(220,'[Jingle] '..(v.name):color(1)..(' is nearby.'):color(8))

				table.insert(played, v.id) -- add id to the played list

			end

		-- does an index (hex id) nearby match an entry in our main targets table?
		elseif settings.targets[convertToHexId(v.index)] and v.valid_target and distance <= tonumber(settings.distance) then
			table.insert(nearby, convertToHexId(v.index)) -- add index to list of those nearby

			if not played:contains(convertToHexId(v.index)) then -- sound for this index has not been played yet
				local soundFile = settings.targets[convertToHexId(v.index)].soundfile
				windower.play_sound(windower.addon_path..'data/sounds/'..soundFile..'.wav')

				windower.add_to_chat(220,'[Jingle] '..(v.name..'('..convertToDisplay(convertToHexId(v.index))..')'):color(1)..(' is nearby.'):color(8))

				table.insert(played, convertToHexId(v.index)) -- add index to the played list

			end
		end
	end
	
	-- At this point, everything nearby has had their sound played, and the played and nearby tables will match,
	-- so anything that is no longer nearby will be removed from the played list so they can be played again next time
	played = nearby

end

windower.register_event('addon command',function(addcmd, ...)

	local args = {...}
	local arg1 = args[1] --target
	local arg2 = args[2] --sound file name

	if addcmd == 'help' then
		windower.add_to_chat(220,'[Jingle] '..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..('Key (Keylesta@Valefor)'):color(220))
		windower.add_to_chat(220,' ')
		windower.add_to_chat(220,' Commands '..('[optional]'):color(53)..(' <required>'):color(2))
		windower.add_to_chat(36,'   add/a '..('<target>'):color(2)..(' [sound_file_name]'):color(53)..(' - Add a target with an optional sound file.'):color(8))
		windower.add_to_chat(36,'   '..(' - Valid targets: Names (ex: Oseem), IDs (ex: 17809550), Hex IDs (ex: 08E).'):color(8))
		windower.add_to_chat(36,'   '..(' - Use quotes to surround an NPC/mob name that contains spaces.'):color(8))
		windower.add_to_chat(36,'   '..(' - Do not include the extension in the sound file name.'):color(8))
		windower.add_to_chat(36,'   remove/r '..('<target>'):color(2)..(' - Remove a target.'):color(8))
		windower.add_to_chat(36,'   list/l'..(' - Show the list of targets and sounds associated.'):color(8))
		windower.add_to_chat(36,'   distance/d '..('<#1-50>'):color(2)..(' - Set the detection distance.'):color(8))
		windower.add_to_chat(36,'   test/t '..('<sound_file_name>'):color(2)..(' - Test a sound file. Do not include the extension.'):color(8))
		windower.add_to_chat(36,'   '..(' - New sounds added to the /data/sounds folder must be .wav format.'):color(8))

	elseif addcmd == 'add' or addcmd == 'a' then
		if arg1 == nil then
			windower.add_to_chat(220,'[Jingle] '..('Please specify a target to be added (name, id, or hexid).'):color(39))
			return
		end

		local target = arg1
		local soundfile = "default"

		if arg2 ~= nil then
			soundfile = arg2
		end

		addTarget(target, soundfile)

	elseif addcmd == 'remove' or addcmd == 'rem' or addcmd == 'rmv' or addcmd == 'r' then
		if arg1 == nil then
			windower.add_to_chat(220,'[Jingle] '..('Please specify a target to be removed.'):color(39))
			return
		end

		local target = arg1
		removeName(target)

	elseif addcmd == 'list' or addcmd == 'l' then
		listTargets()

	elseif addcmd == 'test' or addcmd == 't' then
		if arg1 == nil then
			windower.add_to_chat(220,'[Jingle] '..('Please specify a sound file name to be tested. Do not include the file extension.'):color(39))
			windower.add_to_chat(220,'[Jingle] '..('Example: '):color(8)..(' //jingle test default'):color(1))
			return
		end
		
		local soundFile = arg1
		windower.play_sound(windower.addon_path..'data/sounds/'..soundFile..'.wav')
		windower.add_to_chat(220,'[Jingle] '..('Testing file: '):color(8)..('addons/Jingle/data/sounds/'..soundFile..'.wav'):color(1))
		windower.add_to_chat(220,'[Jingle] '..('If you do not hear the sound:'):color(8))
		windower.add_to_chat(220,'[Jingle] '..('Make sure the file is in the correct folder is in the .wav format.'):color(8))

	elseif addcmd == 'distance' or addcmd == 'dist' or addcmd == 'd' then
		local distance = tonumber(arg1)

		if distance == nil then
			windower.add_to_chat(220,'[Jingle] '..('Detection distance:'):color(36)..(' '..settings.distance):color(200))

		elseif distance ~= nil and (distance >= 1 and distance <= 50) then
			settings.distance = distance
			settings:save('all')
			windower.add_to_chat(220,'[Jingle] '..('Detection distance:'):color(36)..(' '..settings.distance):color(200))

		else
			windower.add_to_chat(220,'[Jingle] '..('Detection distance must be a number between 1 and 50.'):color(39))

		end

	elseif addcmd == 'reload' then
		windower.send_command('lua r jingle')

	else
		windower.add_to_chat(220,'[Jingle] '..('Unrecognized command. Type'):color(39)..(' //jingle help'):color(1)..(' if you need help.'):color(39))

	end
end)

windower.register_event('prerender', function()
	checkForTarget()
end)
