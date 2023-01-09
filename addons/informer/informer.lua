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
_addon.version = '01.08.23'
_addon.author = 'Key'
_addon.commands = {'info','informer'}

require 'logger'

-- texts = require('texts')
-- config = require('config')
-- require('sets')
res = require('resources')
-- packets = require('packets')
-- require('pack')
-- require('chat')




--Display settings
x_pos = 0
y_pos = -2
font_size = 12
text_transparency = 255
bg_transparency = 175


--Unless you know what you're doing, leave everything under here alone.

main_show = true

function create_objects()
	windower.send_command('text main create " Loading...";wait .3;text main size '..font_size..';text main pos '..x_pos..' '..y_pos..';text main transparency '..text_transparency..';text main bg_transparency '..bg_transparency..'')
end

function delete_objects()
	windower.send_command('text main delete') --delete all Objects
end

function display_help()
	windower.add_to_chat(200,'Informer: '..('Hello.'):color(8)..'')
end

function update_main()
	local player = windower.ffxi.get_player()
	local items = windower.ffxi.get_bag_info(0)
	local game = windower.ffxi.get_info()
	local pos = windower.ffxi.get_position()
	local player_job = ''..player.main_job..''..player.main_job_level..'/'..player.sub_job..''..player.sub_job_level..''
	local inventory = ''..items.count..'/'..items.max..''
	local game_time_hour = math.floor(game.time/60)
	local game_time_minute_unformatted = game.time - (math.floor(game.time/60)*60)
	local game_time_minute = string.format("%02d", game_time_minute_unformatted)
	local game_time = ''..game_time_hour..':'..game_time_minute..''
	local game_day = res.days[windower.ffxi.get_info().day].name
	local weather = res.weather[windower.ffxi.get_info().weather].name
	local zone = res.zones[windower.ffxi.get_info().zone].name
	if windower.ffxi.get_mob_by_target('me') == nil then
		facing = 10
	else
		facing = windower.ffxi.get_mob_by_target('me').facing
	end
	if facing >= (math.pi*.625)*-1 and facing < (math.pi*.375)*-1 then
		direction = " N  "
	elseif facing >= (math.pi*.375)*-1 and facing < (math.pi*.125)*-1 then
		direction = "NE "
	elseif (facing >= (math.pi*.125)*-1 and facing < math.pi*.125) or facing == 0 then
		direction = " E  "
	elseif facing >= math.pi*.125 and facing < math.pi*.375 then
		direction = "SE "
	elseif facing >= math.pi*.375 and facing < math.pi*.625 then
		direction = " S  "
	elseif facing >= math.pi*.625 and facing < math.pi*.875 then
		direction = "SW "
	elseif (facing >= math.pi*.875 and facing <= math.pi) or (facing >= (math.pi)*-1 and facing < (math.pi*.875)*-1) then
		direction = " W  "
	elseif facing >= (math.pi*.875)*-1 and facing < (math.pi*.625)*-1 then
		direction = "NW "
	else
		direction = "    "
	end
	if pos == "(?-?)" and main_show then
		windower.send_command('text main hide')
		main_show = false
	elseif pos ~= "(?-?)" and not main_show then
		windower.send_command('text main show')
		main_show = true
	end
	windower.send_command('text main text " '..player_job..' | '..zone..' '..pos..' '..direction..'| '..game_day..' ('..game_time..') '..weather..' | Inventory: '..inventory..'"')
end

windower.register_event('prerender', function()

	if windower.ffxi.get_player() ~= nil then
		update_main()
	end

end)

windower.register_event('load', create_objects)
windower.register_event('login', create_objects)
windower.register_event('logout', delete_objects)
windower.register_event('unload', delete_objects)


windower.register_event('addon command', function(cmd, ...)

	if cmd == 'help' then
		display_help()
	elseif cmd == 'test' then
		--local testname = windower.ffxi.get_mob_by_target('p1')
		local player = windower.ffxi.get_player()
		windower.send_command('input /echo '..player.m_level..'')
	else
		windower.add_to_chat(200,'Informer: '..('Invalid command'):color(8)..'')
		display_help()
	end
	
end)


windower.register_event('incoming text',function(org)     

end)
