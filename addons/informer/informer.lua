--Copyright (c) 2022, Key
--All rights reserved.

--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:

--    * Redistributions of source code must retain the above copyright
--      notice, this list of conditions and the following disclaimer.
--    * Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in the
--      documentation and/or other materials provided with the distribution.
--    * Neither the name of Informer nor the
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

_addon.name = 'Informer'
_addon.version = '2.0'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'informer'}

require 'logger'
config = require('config')
texts = require('texts')
res = require('resources')

defaults = {}

defaults.pos = T{}
defaults.pos.x = 0
defaults.pos.y = -2
defaults.text = T{}
defaults.text.font = 'Consolas'
defaults.text.size = 11
defaults.text.alpha = 255

defaults.flags = T{}
defaults.flags.bold = false
defaults.flags.draggable = false

defaults.bg = T{}
defaults.bg.red = 0
defaults.bg.green = 0
defaults.bg.blue = 0
defaults.bg.alpha = 175

defaults.colors = {}
defaults.colors.light = '255, 248, 220'
defaults.colors.fire = '255, 0, 0'
defaults.colors.ice = '135, 206, 250'
defaults.colors.wind = '50, 205, 50'
defaults.colors.earth = '250, 130, 40'
defaults.colors.lightning = '186, 85, 211'
defaults.colors.water = '30, 144, 255'
defaults.colors.dark = '200, 30, 80'
defaults.colors.none = '255, 255, 255'
defaults.colors.good = '75, 255, 75'
defaults.colors.warning = '255, 165, 0'
defaults.colors.bad = '255, 50, 50'

defaults.display = {}
defaults.display.colors = true
defaults.display.job = true
defaults.display.location = true
defaults.display.day = true
defaults.display.inventory = true
defaults.display.food = true

settings = config.load(defaults)

informer_main = texts.new('${current_string}', settings)

local latest_item_used = {}

function show_informer_main()
	informer_main:show()
end

function hide_informer_main()
	informer_main:hide()
end

function update_informer_main()
	local useColors = settings.display.colors
	local player = windower.ffxi.get_player()
	local bag = windower.ffxi.get_bag_info(0)
	local game = windower.ffxi.get_info()
	local pos = windower.ffxi.get_position()
	local player_job = player.main_job..player.main_job_level..'/'..(player.sub_job and player.sub_job..player.sub_job_level or '-----')
	local inventory = bag.count..'/'..bag.max
	local inventory_color = settings.colors.none
		if useColors and bag.count == bag.max then
			inventory_color = settings.colors.bad
		elseif useColors and bag.max - bag.count <= 10 then
			inventory_color = settings.colors.warning
		end
	local food = settings.food and settings.food or "None"
	local food_color = settings.colors.none
		if useColors then
			food_color = (settings.food == "None" or not settings.food) and settings.colors.bad or settings.colors.good
		end
	local game_time_hour = math.floor(game.time/60)
	local game_time_minute_unformatted = game.time - (math.floor(game.time/60)*60)
	local game_time_minute = string.format("%02d", game_time_minute_unformatted)
	local game_time = game_time_hour..':'..game_time_minute
	local game_day = res.days[windower.ffxi.get_info().day].name
	local day_color = settings.colors.none
		if useColors then
			day_color = settings.colors[string.lower(res.elements[res.days[windower.ffxi.get_info().day].element].name)]
		end
	local weather = res.weather[windower.ffxi.get_info().weather].name
	local weather_color = settings.colors.none
		if useColors then
			weather_color = settings.colors[string.lower(res.elements[res.weather[windower.ffxi.get_info().weather].element].name)]
		end
	local zone = res.zones[windower.ffxi.get_info().zone].name
	if windower.ffxi.get_mob_by_target('me') == nil then
		facing = 10
	else
		facing = windower.ffxi.get_mob_by_target('me').facing
	end
	if facing >= (math.pi*.625)*-1 and facing < (math.pi*.375)*-1 then
		direction = "N "
	elseif facing >= (math.pi*.375)*-1 and facing < (math.pi*.125)*-1 then
		direction = "NE"
	elseif (facing >= (math.pi*.125)*-1 and facing < math.pi*.125) or facing == 0 then
		direction = "E "
	elseif facing >= math.pi*.125 and facing < math.pi*.375 then
		direction = "SE"
	elseif facing >= math.pi*.375 and facing < math.pi*.625 then
		direction = "S "
	elseif facing >= math.pi*.625 and facing < math.pi*.875 then
		direction = "SW"
	elseif (facing >= math.pi*.875 and facing <= math.pi) or (facing >= (math.pi)*-1 and facing < (math.pi*.875)*-1) then
		direction = "W "
	elseif facing >= (math.pi*.875)*-1 and facing < (math.pi*.625)*-1 then
		direction = "NW"
	else
		direction = "    "
	end
	if pos == "(?-?)" then
		hide_informer_main()
	elseif pos ~= "(?-?)" then
		show_informer_main()
	end

	local text = ''

	if settings.display.job then
		text = text..' '..player_job..' '
	end
	if settings.display.location then
		if text ~= '' then
			text = text..'|'
		end
		text = text..' '..zone..' '..pos..' '..direction..' '
	end
	if settings.display.day then
		if text ~= '' then
			text = text..'|'
		end
		text = text..' \\cs('..day_color..')'..game_day..'\\cr ('..game_time..') \\cs('..weather_color..')'..weather..'\\cr '
	end
	if settings.display.inventory then
		if text ~= '' then
			text = text..'|'
		end
		text = text..' Inventory: \\cs('..inventory_color..')'..inventory..'\\cr '
	end
	if settings.display.food then
		if text ~= '' then
			text = text..'|'
		end
		text = text..' Food: \\cs('..food_color..')'..food..'\\cr '
	end

	informer_main.current_string = text

end

function isInParty(id)
	local actor = windower.ffxi.get_mob_by_id(id)

	if actor == nil or not actor.in_party then
		-- Not in our party
		return false
	else
		-- In our party
		return true
	end

end

windower.register_event('action',function(act)
	if settings.food and isInParty(act.actor_id) and act.category == 9 and act.targets[1].actions[1].message == 28 then
		latest_item_used[windower.ffxi.get_mob_by_target('me').name] = res.items[act.targets[1].actions[1].param].en
	end
end)

windower.register_event('gain buff', function(buff)
	if buff == 251 then
		settings.food = latest_item_used[windower.ffxi.get_mob_by_target('me').name]
		settings:save()
	end
end)

windower.register_event('lose buff', function(buff)
	if buff == 251 then
		settings.food = "None"
		settings:save()
	end
end)

windower.register_event('prerender', function()

	if windower.ffxi.get_player() ~= nil then
		update_informer_main()
	end

end)

--windower.register_event('load', create_informer_main)
windower.register_event('login', show_informer_main)
windower.register_event('logout', hide_informer_main)

function displayUnregnizedCommand()
	windower.add_to_chat(220,'[Informer] '..('Unrecognized command. Type'):color(39)..(' //informer help'):color(1)..(' if you need help.'):color(39))
end

windower.register_event('addon command',function(addcmd, ...)
	-- Update the position
	if addcmd == 'pos' or addcmd == 'position' or addcmd == 'move' or addcmd == 'lock' or addcmd == 'unlock' then

		local pos = {...}

		-- Lock by turning drag off
		if addcmd == 'lock' or (addcmd ~= 'unlock' and pos[1] == 'lock') then
			settings.flags.draggable = false
			settings:save('all')
			windower.add_to_chat(220,'[Informer] '..('Position:'):color(36)..(' '..settings.pos.x..' '..settings.pos.y..' - Locked'):color(200))
		
		--Unlock by turning drag on
		elseif addcmd == 'unlock' or pos[1] == 'unlock' then
			settings.flags.draggable = true
			settings:save('all')
			windower.add_to_chat(220,'[Informer] '..('Position:'):color(36)..(' '..settings.pos.x..' '..settings.pos.y..' - Unlocked'):color(200)..(' (draggable)'):color(8))
		
		-- If there are not enough parameters then output the current position and remind how to update
		elseif #pos < 2 then
			windower.add_to_chat(220,'[Informer] '..('Position:'):color(36)..(' '..settings.pos.x..' '..settings.pos.y):color(200)..' %s':format(settings.flags.draggable and ('- Unlocked'):color(200)..(' (draggable)'):color(8) or ('- Locked'):color(200)))
			windower.add_to_chat(220,'[Informer] '..('Update'):color(8)..'%s':format(settings.flags.draggable and (' by dragging'):color(8) or (' with'):color(8)..(' //informer pos unlock'):color(1))..(' or adding X and Y coordinates (ex.'):color(8)..(' //informer pos 100 200'):color(1)..(')'):color(8))

		-- X and Y coordinates are provided
		else
			-- Take the provided string parameters and turn them into numbers
			settings.pos.x = tonumber(pos[1])
			settings.pos.y = tonumber(pos[2])
			
			-- Save the new setting, update the position, then alert the user
			if settings.pos.x == nil or settings.pos.y == nil then
				displayUnregnizedCommand()
			else
				settings:save('all')
				texts.pos(informer_main, settings.pos.x, settings.pos.y)
				windower.add_to_chat(220,'[Informer] '..('Position:'):color(36)..(' '..settings.pos.x..' '..settings.pos.y):color(200)..' %s':format(settings.flags.draggable and ('- Unlocked'):color(200)..(' (draggable)'):color(8) or ('- Locked'):color(200)))
			end
		end

	-- Update the font size
	elseif addcmd == 'size' or addcmd == 'fontsize' then
		
		local size = {...}
		
		-- If there are no parameters then output the current size and remind how to update
		if #size < 1 then
			windower.add_to_chat(220,'[Informer] '..('Font size:'):color(36)..(' '..settings.text.size):color(200))
			windower.add_to_chat(220,'[Informer] '..('Update by adding a number (ex.'):color(8)..(' //informer size 12'):color(1)..(')'):color(8))

		-- Size number is provided
		else
			-- Take the provided string parameter and turn it into a number
			settings.text.size = tonumber(size[1])
					
			-- Save the new setting, update the size, then alert the user
			if settings.text.size == nil then
				displayUnregnizedCommand()
			else
				settings:save('all')
				texts.size(informer_main, settings.text.size)
				windower.add_to_chat(220,'[Informer] '..('Font Size:'):color(36)..(' '..settings.text.size):color(200))
			end
		end

	-- Turn bold on or off
	elseif addcmd == 'bold' then

		settings.flags.bold = not settings.flags.bold

		-- Save the new setting, update the bold setting, then alert the user
		settings:save('all')
		texts.bold(informer_main, settings.flags.bold)
		windower.add_to_chat(220,'[Informer] '..('Bold:'):color(36)..(' %s':format(settings.flags.bold and 'ON' or 'OFF')):color(200))

	-- Turn colors on or off
	elseif addcmd == 'color' or addcmd == 'colors' then

		settings.display.colors = not settings.display.colors

		-- Save the new setting, update the colors setting, then alert the user
		settings:save('all')
		windower.add_to_chat(220,'[Informer] '..('Colors:'):color(36)..(' %s':format(settings.display.colors and 'ON' or 'OFF')):color(200))

	-- Turn job display on or off
	elseif addcmd == 'job' then

		settings.display.job = not settings.display.job

		-- Save the new setting, update the job display setting, then alert the user
		settings:save('all')
		windower.add_to_chat(220,'[Informer] '..('Job Display:'):color(36)..(' %s':format(settings.display.job and 'ON' or 'OFF')):color(200))

	-- Turn location display on or off
	elseif addcmd == 'location' or addcmd == 'loc' then

		settings.display.location = not settings.display.location

		-- Save the new setting, update the location display setting, then alert the user
		settings:save('all')
		windower.add_to_chat(220,'[Informer] '..('Location display:'):color(36)..(' %s':format(settings.display.location and 'ON' or 'OFF')):color(200))

	-- Turn day display on or off
	elseif addcmd == 'day' then

		settings.display.day = not settings.display.day

		-- Save the new setting, update the day display setting, then alert the user
		settings:save('all')
		windower.add_to_chat(220,'[Informer] '..('Day display:'):color(36)..(' %s':format(settings.display.day and 'ON' or 'OFF')):color(200))

	-- Turn inventory display on or off
	elseif addcmd == 'inventory' or addcmd == 'inv' then

		settings.display.inventory = not settings.display.inventory

		-- Save the new setting, update the inventory display setting, then alert the user
		settings:save('all')
		windower.add_to_chat(220,'[Informer] '..('Inventory display:'):color(36)..(' %s':format(settings.display.inventory and 'ON' or 'OFF')):color(200))

	-- Turn food display on or off
	elseif addcmd == 'food' then

		settings.display.food = not settings.display.food

		-- Save the new setting, update the food display setting, then alert the user
		settings:save('all')
		windower.add_to_chat(220,'[Informer] '..('Food display:'):color(36)..(' %s':format(settings.display.food and 'ON' or 'OFF')):color(200))

	elseif addcmd == 'help' then
		local currPos = settings.pos
		local currSize = settings.text.size
		local currBold = settings.flags.bold
		local currColor = settings.display.colors
		local currJob = settings.display.job
		local currLoc = settings.display.location
		local currDay = settings.display.day
		local currInv = settings.display.inventory
		local currFood = settings.display.food
		
		windower.add_to_chat(220,'[Informer] '..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..('Key (Keylesta@Valefor)'):color(220))
		windower.add_to_chat(220,' ')
		windower.add_to_chat(220,' Commands ')
		windower.add_to_chat(36,'   job/location/day/inventory/food'..(' - Update display setting.'):color(8))
		windower.add_to_chat(8,'   ['..(currJob and ('Job'):color(158) or ('Job'):color(39))..(' | ')..(currLoc and ('Location'):color(158) or ('Location'):color(39))..(' | ')..(currDay and ('Day'):color(158) or ('Day'):color(39))..(' | ')..(currInv and ('Inventory'):color(158) or ('Inventory'):color(39))..(' | ')..(currFood and ('Food'):color(158) or ('Food'):color(39))..(']'):color(8))
		windower.add_to_chat(36,'   pos [x y]'..(' - Update position. ['):color(8)..(currPos.x..' '..currPos.y):color(200)..(']'):color(8))
		windower.add_to_chat(36,'   lock/unlock'..(' - Update position via drag. ['):color(8)..(settings.flags.draggable and ('Unlocked'):color(200)..(' (draggable)'):color(8) or ('Locked'):color(200))..(']'):color(8))
		windower.add_to_chat(36,'   size [#]'..(' - Update font size. ['):color(8)..(''..currSize):color(200)..(']'):color(8))
		windower.add_to_chat(36,'   bold'..(' - Update bold setting. ['):color(8)..('%s':format(currBold and 'ON' or 'OFF')):color(200)..(']'):color(8))
		windower.add_to_chat(36,'   color'..(' - Update color setting. ['):color(8)..('%s':format(currColor and 'ON' or 'OFF')):color(200)..(']'):color(8))

	elseif addcmd == 'reload' then
		windower.send_command('lua r informer')
        return
	else
		displayUnregnizedCommand()
	end
	
end)
