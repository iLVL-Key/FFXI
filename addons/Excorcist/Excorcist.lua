--Copyright (c) 2024, Key
--All rights reserved.

--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:

--    * Redistributions of source code must retain the above copyright
--      notice, this list of conditions and the following disclaimer.
--    * Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in the
--      documentation and/or other materials provided with the distribution.
--    * Neither the name of Excorcist nor the
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

_addon.name = 'Excorcist'
_addon.version = '1.0'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'excorcist'}

config = require('config')
texts = require('texts')

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

defaults.DoomOnText = ""
defaults.DoomOffText = ""

settings = config.load(defaults)

-- Count the number of Holy Waters and return the number
local function countHW()
	local HolyWater = 4154 --id number of Holy Water
	local items = windower.ffxi.get_items()
	local inventory = items.inventory
	local invNum = 0

	-- Find the item and get the count
	for i, item in ipairs(inventory) do
		if item.id == HolyWater then
			invNum = invNum + item.count
			break
		end
	end

	return invNum

end

-- Create the Excorcist text object
local Excorcist_box = texts.new()
Excorcist_box:font(settings.text.font)
Excorcist_box:size(settings.text.size)
Excorcist_box:bg_alpha(settings.text.bg_alpha)
Excorcist_box:pos(settings.pos.x,settings.pos.y)
Excorcist_box:bold(settings.flags.bold)
Excorcist_box:draggable(settings.flags.draggable)

local HWaterRecast = 0
local Doom = false
local Heartbeat = 0
local buffactive = windower.ffxi.get_player().buffs

windower.register_event('gain buff', function(buff)

	if buff == 15 then --Doom

		--Setting "Doom" to true now, so that it can get set to false if we die, that way we don't announce that doom is off when we raise from the dead
		Doom = true

		if settings.show_box then
			Excorcist_box:show()
		end

		if settings.DoomOnText ~= "" then
			windower.send_command('input /p '..settings.DoomOnText..'')
		end

		--Set the recast timer so we can start using the Holy Waters
		HWaterRecast = 2

	end
end)

windower.register_event('lose buff', function(buff)

	if buff == 15 then --Doom

		Excorcist_box:hide()

		if Doom then

			--"Doom" gets set to false so that we don't announce that doom is off when we raise from the dead after dying to it.
			Doom = false

			if settings.DoomOffText ~= "" then
				windower.send_command('input /p '..settings.DoomOffText..'')
			end

			--Stop the timer
			HWaterRecast = 0

		end
	end
end)

windower.register_event('prerender', function()

	local HWcount = countHW()
	local formattedNum = string.format("%2s", HWcount)

	if Doom then
		if HWcount > 0 then
			Excorcist_box:text('          ~YOU ARE DOOMED~\nAttempting to excorcize the demons..\n      '..formattedNum..' Holy Waters remaining')
		else
			Excorcist_box:text('          ~YOU ARE DOOMED~\nAttempting to excorcize the demons..\n        \\cs(255,75,75)Out of Holy Waters!!\\cr')
		end
	end

	if os.time() > Heartbeat then
		Heartbeat = os.time()

		if HWaterRecast == 2 and HWcount ~= 0 and Doom then
			windower.send_command('input /item "Holy Water" <me>')
			HWaterRecast = HWaterRecast - 1
		elseif HWaterRecast == 0 and Doom then
			HWaterRecast = 2
		elseif Doom then
			HWaterRecast = HWaterRecast - 1
		end

	end

end)
