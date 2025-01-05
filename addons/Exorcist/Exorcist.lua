--Copyright (c) 2025, Key
--All rights reserved.

--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:

--    * Redistributions of source code must retain the above copyright
--      notice, this list of conditions and the following disclaimer.
--    * Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in the
--      documentation and/or other materials provided with the distribution.
--    * Neither the name of Exorcist nor the
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

_addon.name = 'Exorcist'
_addon.version = '1.1'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'exorcist'}

config = require('config')
texts = require('texts')
require 'chat'

defaults = {}

defaults.pos = T{}
defaults.pos.x = math.floor((windower.get_windower_settings().ui_x_res) / 5 * 2)
defaults.pos.y = math.floor((windower.get_windower_settings().ui_y_res) / 2)

defaults.text = T{}
defaults.text.font = 'Consolas'
defaults.text.size = 14
defaults.text.bg_alpha = 100

defaults.flags = T{}
defaults.flags.bold = true
defaults.flags.draggable = true

defaults.show_box = true

defaults.DoomOnText = "doom"
defaults.DoomOffText = "doom off"
defaults.wait = 3

settings = config.load(defaults)
local HWcount
local Doom = false

-- Create the Exorcist text object
local Exorcist_box = texts.new()
Exorcist_box:font(settings.text.font)
Exorcist_box:size(settings.text.size)
Exorcist_box:bg_alpha(settings.text.bg_alpha)
Exorcist_box:pos(settings.pos.x,settings.pos.y)
Exorcist_box:bold(settings.flags.bold)
Exorcist_box:draggable(settings.flags.draggable)


-- Count the number of Holy Waters and return the number
local function countHW()
	local inventory = windower.ffxi.get_items().inventory
	local invNum = 0

	-- Find the item and get the count
	for i, item in ipairs(inventory) do
		if item.id == 4154 then --id number of Holy Water
			invNum = invNum + item.count
			break
		end
	end

	return invNum

end


--Update the on-screen box
local function updateBox()

	local formattedNum = string.format("%2s", HWcount)

	if Doom then
		if HWcount > 0 then
			Exorcist_box:text('          ~YOU ARE DOOMED~\nAttempting to exorcize the demons...\n      '..formattedNum..' Holy Water'..(HWcount > 1 and 's' or '')..' remaining')
		else
			Exorcist_box:text('          ~YOU ARE DOOMED~\nAttempting to exorcize the demons...\n        \\cs(255,75,75)Out of Holy Waters!!\\cr')
		end
	end

end


--Main function that gets repeated until Doom wears off
local function useHolyWater()

	HWcount = countHW()

	if settings.show_box then
		updateBox()
		Exorcist_box:show()
	end

	if HWcount ~= 0 and Doom then
		windower.send_command('input /item "Holy Water" <me>')
	end
	coroutine.sleep(settings.wait)
	if Doom then
		useHolyWater()
	end
end


windower.register_event('gain buff', function(buff)

	if buff == 15 then --Doom

		--Setting "Doom" to true now, so that it can get set to false if we die, that way we don't announce that doom is off when we raise from the dead
		Doom = true

		if settings.DoomOnText ~= "" then
			windower.send_command('input /p '..settings.DoomOnText..'')
		end

		--Start up the Holy Waters
		useHolyWater()

	end
end)


windower.register_event('lose buff', function(buff)

	if buff == 15 then --Doom

		Exorcist_box:hide()

		if Doom then

			--"Doom" gets set to false so that we don't announce that doom is off when we raise from the dead after dying to it.
			Doom = false

			if settings.DoomOffText ~= "" then
				windower.send_command('input /p '..settings.DoomOffText..'')
			end

		end
	end
end)

windower.register_event('addon command',function(addcmd)
	windower.add_to_chat(8,('[Exorcist] '):color(220)..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220))
	windower.add_to_chat(36,' ')
	windower.add_to_chat(36,'   This addon has no commands, but you can change a few things in the settings file.')
	windower.add_to_chat(36,'   PRO TIP: Make sure your gearswap file has a rule and gear set for using Holy Waters.')
	windower.add_to_chat(36,'   Have a great day!')
end)
