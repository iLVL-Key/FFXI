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
_addon.version = '1.0'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'jingle'}

require 'logger'
require 'chat'
config = require('config')

defaults = {}
defaults.names = {}
defaults.timer = 3 -- determines how often memory is checked for nearby players

settings = config.load(defaults)

local heartbeat = 0
local timer = settings.timer
local nearby = T{}
local played = T{}


-- Capitalize a name
function capitalize(str)
	local capitalized = string.gsub(str, "(%w)(%w*)", function(firstLetter, rest)
		return string.upper(firstLetter) .. string.lower(rest)
	end)
	return capitalized
end

-- Add a name and sound file to the Names table
function addName(name, soundfile)
	local person = {
		soundfile = soundfile
	}
	
	settings.names[string.lower(name)] = person
	settings:save('all')
	
	windower.add_to_chat(220,'[Jingle] '..(capitalize(name)..' ('..soundfile..')'):color(1)..(' has been added.'):color(8))
end

-- Remove a name from the Names table
function removeName(name)
	local lowercaseName = string.lower(name)
	if settings.names[lowercaseName] then
		settings.names[lowercaseName] = nil
		windower.add_to_chat(220,'[Jingle] '..(capitalize(name)):color(1)..(' has been removed.'):color(8))
		settings:save('all')
	else
		windower.add_to_chat(220,'[Jingle] '..(capitalize(name)):color(1)..(' was not found.'):color(8))
	end
end

-- List the names in the Names table
function listNames()
	windower.add_to_chat(220,'[Jingle] '..('Names: '):color(8))
	for name, sound in pairs(settings.names) do
		windower.add_to_chat(1,' - '..capitalize(name)..' ('..sound.soundfile..')')
	end
end

-- Check for matching names
function checkForNames()

	nearby = T{}
	
	for i,v in pairs(windower.ffxi.get_mob_array()) do -- loop through all the mobs in memory (nearby)
		
		if settings.names[string.lower(v.name)] and v.valid_target then -- does a name nearby match one on our main Names table?
			table.insert(nearby, v.name) -- build list of those names
			if not played:contains(v.name) then -- sound for this name has not been played yet
				soundName = settings.names[string.lower(v.name)].soundfile
				windower.play_sound(windower.addon_path..'data/sounds/'..soundName..'.wav')
				windower.add_to_chat(220,'[Jingle] '..(capitalize(v.name)):color(1)..(' is nearby.'):color(8))
				table.insert(played, v.name) -- add name to the played list
			end
		end
		
	end
	
	-- At this point, everyone nearby has had their sound played, and the played and nearby tables will match,
	-- so any players that are no longer nearby will be removed from the played list so they can be played again next time
	played = nearby

end


windower.register_event('addon command',function(addcmd, ...)

	local args = {...}
	local arg1 = args[1] --person name
	local arg2 = args[2] --sound file name

	if addcmd == 'help' then
		windower.add_to_chat(220,'[Jingle] '..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..('Key (Keylesta@Valefor)'):color(220))
		windower.add_to_chat(220,' ')
		windower.add_to_chat(220,' Commands '..('[optional]'):color(53)..(' <required>'):color(2))
		windower.add_to_chat(36,'   add/a '..('<name>'):color(2)..(' [sound file name]'):color(53)..(' - Add a name with an optional sound file.'):color(8))
		windower.add_to_chat(36,'   '..(' - Do not include the extension in the sound file name.'):color(8))
		windower.add_to_chat(36,'   remove/r '..('<name>'):color(2)..(' - Remove a name.'):color(8))
		windower.add_to_chat(36,'   test/t '..('<sound file name>'):color(2)..(' - Test a sound file. Do not include the file extension.'):color(8))
		windower.add_to_chat(36,'   '..(' - New sounds added to the /data/sounds folder must be .wav format.'):color(8))
		windower.add_to_chat(36,'   list/l'..(' - Show the list of names and sounds associated.'):color(8))

	elseif addcmd == 'add' or addcmd == 'a' then
		if arg1 == nil then
			windower.add_to_chat(220,'[Jingle] '..('Please provide a name to be added.'):color(8))
			return
		end
		local name = arg1
		local soundfile = "default"
		if arg2 ~= nil then
			soundfile = arg2
		end
		addName(name, soundfile)

	elseif addcmd == 'remove' or addcmd == 'rem' or addcmd == 'rmv' or addcmd == 'r' then
		if arg1 == nil then
			windower.add_to_chat(220,'[Jingle] '..('Please provide a name to be removed.'):color(8))
			return
		end
		local name = arg1
		removeName(name)

	elseif addcmd == 'list' or addcmd == 'l' then
		listNames()

	elseif addcmd == 'test' or addcmd == 't' then
		if arg1 == nil then
			windower.add_to_chat(220,'[Jingle] '..('Please provide a sound file name to be tested. Do not include the file extension.'):color(8))
			windower.add_to_chat(220,'[Jingle] '..('Example: '):color(8)..(' //jingle test default'):color(1))
			return
		end
		soundName = arg1
		windower.play_sound(windower.addon_path..'data/sounds/'..soundName..'.wav')

	elseif addcmd == 'check' then
		checkForNames()

	elseif addcmd == 'reload' then
		windower.send_command('lua r jingle')

	end
end)

windower.register_event('prerender', function()
	
	-- Creates a 1 second heartbeat
	if os.time() > heartbeat then
		heartbeat = os.time()

		if timer > 0 and pos ~= "(?-?)" then
			timer = timer - 1
		else
			timer = settings.timer --start the timer back up
			checkForNames()
		end
	end

end)
