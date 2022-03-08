--Copyright (c) 2022, Key
--All rights reserved.

--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:

--    * Redistributions of source code must retain the above copyright
--      notice, this list of conditions and the following disclaimer.
--    * Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in the
--      documentation and/or other materials provided with the distribution.
--    * Neither the name of Notify nor the
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

_addon.name = 'Notify'
_addon.version = '1.0'
_addon.author = 'Key'
_addon.commands = {'not','notify'}

require 'logger'



--Can turn certain notifications on or off (true or false)
alert_sounds = true
trade = true
sneak = true
invisible = true
invite = true
visitant_status = true
trial = true
coalition = true
nyzul = true
food = true
reraise = true
commitment = true
vorseal = true
signet = true
sanction = true
sigil = true
ionis = true
weakness = true


--Position for the Notifications to be place
x_pos = 750
y_pos = 665

--If you change the font size, you'll need to adjust the space between lines as well
font_size = 12
line_spacer = 20

text_transparency = 255
bg_transparency = 175

--Automatic fade delay for each notification in seconds
auto_fade_delay = 120



--Unless you know what you're doing, leave everything under here alone.



line_1_y_pos = y_pos
line_2_y_pos = y_pos + line_spacer
line_3_y_pos = line_2_y_pos + line_spacer
line_4_y_pos = line_3_y_pos + line_spacer
line_5_y_pos = line_4_y_pos + line_spacer
line_6_y_pos = line_5_y_pos + line_spacer

text_fade = text_transparency / line_spacer
text_fade = math.round(text_fade)
bg_fade = bg_transparency / line_spacer
bg_fade = math.round(bg_fade)

obj_a_line = 1
obj_b_line = 2
obj_c_line = 3
obj_d_line = 4
obj_e_line = 5
obj_f_line = 6

obj_a_color = "255 255 255"
obj_b_color = "255 255 255"
obj_c_color = "255 255 255"
obj_d_color = "255 255 255"
obj_e_color = "255 255 255"
obj_f_color = "255 255 255"

obj_a_y_pos = line_1_y_pos
obj_b_y_pos = line_2_y_pos
obj_c_y_pos = line_3_y_pos
obj_d_y_pos = line_4_y_pos
obj_e_y_pos = line_5_y_pos
obj_f_y_pos = line_6_y_pos

obj_a_transp = text_transparency
obj_b_transp = text_transparency
obj_c_transp = text_transparency
obj_d_transp = text_transparency
obj_e_transp = text_transparency
obj_f_transp = 1

obj_a_bg_transp = bg_transparency
obj_b_bg_transp = bg_transparency
obj_c_bg_transp = bg_transparency
obj_d_bg_transp = bg_transparency
obj_e_bg_transp = bg_transparency
obj_f_bg_transp = 1

obj_a_fade_delay = 0
obj_b_fade_delay = 0
obj_c_fade_delay = 0
obj_d_fade_delay = 0
obj_e_fade_delay = 0
obj_f_fade_delay = 0

obj_a_clear = false
obj_b_clear = false
obj_c_clear = false
obj_d_clear = false
obj_e_clear = false
obj_f_clear = false

next_obj = "F" --determines the next Object that a new notification gets written into
move = false  --used to start and stop moving the old notifications down
Heartbeat = 0


function create_objects()
	windower.send_command('text obj_a create "•";wait .3;text obj_a size '..font_size..';text obj_a pos '..x_pos..' '..line_1_y_pos..';text obj_a transparency '..obj_a_transp..';text obj_a bg_transparency '..obj_a_bg_transp..'')
	windower.send_command('wait .1;text obj_b create "•";wait .3;text obj_b size '..font_size..';text obj_b pos '..x_pos..' '..line_2_y_pos..';text obj_b transparency '..obj_b_transp..';text obj_b bg_transparency '..obj_b_bg_transp..'')
	windower.send_command('wait .2;text obj_c create "•";wait .3;text obj_c size '..font_size..';text obj_c pos '..x_pos..' '..line_3_y_pos..';text obj_c transparency '..obj_c_transp..';text obj_c bg_transparency '..obj_c_bg_transp..'')
	windower.send_command('wait .3;text obj_d create "•";wait .3;text obj_d size '..font_size..';text obj_d pos '..x_pos..' '..line_4_y_pos..';text obj_d transparency '..obj_d_transp..';text obj_d bg_transparency '..obj_d_bg_transp..'')
	windower.send_command('wait .4;text obj_e create "•";wait .3;text obj_e size '..font_size..';text obj_e pos '..x_pos..' '..line_5_y_pos..';text obj_e transparency '..obj_e_transp..';text obj_e bg_transparency '..obj_e_bg_transp..'')
	windower.send_command('wait .5;text obj_f create "•";wait .3;text obj_f size '..font_size..';text obj_f pos '..x_pos..' '..line_6_y_pos..';text obj_f transparency '..obj_f_transp..';text obj_f bg_transparency '..obj_f_bg_transp..'')
	
	obj_a_transp = 1 windower.send_command('wait .8;text obj_a transparency 1;text obj_a bg_transparency 1')
	obj_b_transp = 1 windower.send_command('wait .9;text obj_b transparency 1;text obj_b bg_transparency 1')
	obj_c_transp = 1 windower.send_command('wait 1;text obj_c transparency 1;text obj_c bg_transparency 1')
	obj_d_transp = 1 windower.send_command('wait 1.1;text obj_d transparency 1;text obj_d bg_transparency 1')
	obj_e_transp = 1 windower.send_command('wait 1.2;text obj_e transparency 1;text obj_e bg_transparency 1')
	obj_f_transp = 1 windower.send_command('wait 1.3;text obj_f transparency 1;text obj_f bg_transparency 1')
end

function test_start()
	windower.add_to_chat(200,'Notify: '..('Test start...'):color(8)..'')
	windower.send_command('wait 1;lua invoke notify trade;wait 2 3;lua invoke notify sneak;wait 2 3;lua invoke notify party;wait 2 3;lua invoke notify time_remaining_1;wait 2 3;lua invoke notify trial;wait 1;lua invoke notify test_finish')
end
function test_finish()
	windower.add_to_chat(200,'Notify: '..('...Test finish'):color(8)..'')
end

function clear_objects()
	obj_a_fade_delay = 0 obj_a_clear = true
	obj_b_fade_delay = 0 obj_b_clear = true
	obj_c_fade_delay = 0 obj_c_clear = true
	obj_d_fade_delay = 0 obj_d_clear = true
	obj_e_fade_delay = 0 obj_e_clear = true
	obj_f_fade_delay = 0 obj_f_clear = true
end

function delete_objects()
	windower.send_command('text obj_a delete;text obj_b delete;text obj_c delete;text obj_d delete;text obj_e delete;text obj_f delete') --delete all Objects
end

function display_help()
	windower.add_to_chat(200,'Notify: '..('Valid commands:'):color(8)..'')
	windower.add_to_chat(200,'Notify: '..('clear - Clears the on-screen display'):color(8)..'')
	windower.add_to_chat(200,'Notify: '..('help - Shows a list of valid commands'):color(8)..'')
	windower.add_to_chat(200,'Notify: '..('test - Displays a quick test of the Notify addon'):color(8)..'')
end

function new_notification()

	--Designates each Object as having moved one line down
	obj_a_line = obj_a_line + 1
	obj_b_line = obj_b_line + 1
	obj_c_line = obj_c_line + 1
	obj_d_line = obj_d_line + 1
	obj_e_line = obj_e_line + 1
	obj_f_line = obj_f_line + 1

	--If an Object is at the end, it moves back up to Line 1
	if obj_a_line == 7 then obj_a_line = 1 end
	if obj_b_line == 7 then obj_b_line = 1 end
	if obj_c_line == 7 then obj_c_line = 1 end
	if obj_d_line == 7 then obj_d_line = 1 end
	if obj_e_line == 7 then obj_e_line = 1 end
	if obj_f_line == 7 then obj_f_line = 1 end

	move = true --Tells the code inside prerender to start moving the Objects
end

windower.register_event('prerender', function()

	--fades the transparency of an object if it's hit the fade delay
	if obj_a_fade_delay == 0 and obj_a_transp > text_fade and obj_a_clear then
		obj_a_transp = obj_a_transp - text_fade obj_a_bg_transp = obj_a_bg_transp - bg_fade windower.send_command('text obj_a transparency '..obj_a_transp..';text obj_a bg_transparency '..obj_a_bg_transp..'')
	elseif obj_a_fade_delay == 0 and obj_a_clear then
		windower.send_command('wait .1;text obj_a transparency 1;text obj_a bg_transparency 1')
		obj_a_clear = false
	end
	if obj_b_fade_delay == 0 and obj_b_transp > text_fade and obj_b_clear then
		obj_b_transp = obj_b_transp - text_fade obj_b_bg_transp = obj_b_bg_transp - bg_fade windower.send_command('text obj_b transparency '..obj_b_transp..';text obj_b bg_transparency '..obj_b_bg_transp..'')
	elseif obj_b_fade_delay == 0 and obj_b_clear then
		windower.send_command('wait .1;text obj_b transparency 1;text obj_b bg_transparency 1')
		obj_b_clear = false
	end
	if obj_c_fade_delay == 0 and obj_c_transp > text_fade and obj_c_clear then
		obj_c_transp = obj_c_transp - text_fade obj_c_bg_transp = obj_c_bg_transp - bg_fade windower.send_command('text obj_c transparency '..obj_c_transp..';text obj_c bg_transparency '..obj_c_bg_transp..'')
	elseif obj_c_fade_delay == 0 and obj_c_clear then
		windower.send_command('wait .1;text obj_c transparency 1;text obj_c bg_transparency 1')
		obj_c_clear = false
	end
	if obj_d_fade_delay == 0 and obj_d_transp > text_fade and obj_d_clear then
		obj_d_transp = obj_d_transp - text_fade obj_d_bg_transp = obj_d_bg_transp - bg_fade windower.send_command('text obj_d transparency '..obj_d_transp..';text obj_d bg_transparency '..obj_d_bg_transp..'')
	elseif obj_d_fade_delay == 0 and obj_d_clear then
		windower.send_command('wait .1;text obj_d transparency 1;text obj_d bg_transparency 1')
		obj_d_clear = false
	end
	if obj_e_fade_delay == 0 and obj_e_transp > text_fade and obj_e_clear then
		obj_e_transp = obj_e_transp - text_fade obj_e_bg_transp = obj_e_bg_transp - bg_fade windower.send_command('text obj_e transparency '..obj_e_transp..';text obj_e bg_transparency '..obj_e_bg_transp..'')
	elseif obj_e_fade_delay == 0 and obj_e_clear then
		windower.send_command('wait .1;text obj_e transparency 1;text obj_e bg_transparency 1')
		obj_e_clear = false
	end
	if obj_f_fade_delay == 0 and obj_f_transp > text_fade and obj_f_clear then
		obj_f_transp = obj_f_transp - text_fade obj_f_bg_transp = obj_f_bg_transp - bg_fade windower.send_command('text obj_f transparency '..obj_f_transp..';text obj_f bg_transparency '..obj_f_bg_transp..'')
	elseif obj_f_fade_delay == 0 and obj_f_clear then
		windower.send_command('wait .1;text obj_f transparency 1;text obj_f bg_transparency 1')
		obj_f_clear = false
	end

	if move then

		--moves the y position of each object down by 1 pixel each frame
		obj_a_y_pos = obj_a_y_pos + 1
		obj_b_y_pos = obj_b_y_pos + 1
		obj_c_y_pos = obj_c_y_pos + 1
		obj_d_y_pos = obj_d_y_pos + 1
		obj_e_y_pos = obj_e_y_pos + 1
		obj_f_y_pos = obj_f_y_pos + 1
		windower.send_command('text obj_a pos '..x_pos..' '..obj_a_y_pos..'')
		windower.send_command('text obj_b pos '..x_pos..' '..obj_b_y_pos..'')
		windower.send_command('text obj_c pos '..x_pos..' '..obj_c_y_pos..'')
		windower.send_command('text obj_d pos '..x_pos..' '..obj_d_y_pos..'')
		windower.send_command('text obj_e pos '..x_pos..' '..obj_e_y_pos..'')
		windower.send_command('text obj_f pos '..x_pos..' '..obj_f_y_pos..'')

		--fades the transparency of an object if it's moving to line 6
		if obj_a_line == 6 and obj_a_transp - text_fade >= 1 then obj_a_transp = obj_a_transp - text_fade obj_a_bg_transp = obj_a_bg_transp - bg_fade windower.send_command('text obj_a transparency '..obj_a_transp..';text obj_a bg_transparency '..obj_a_bg_transp..'') end
		if obj_b_line == 6 and obj_b_transp - text_fade >= 1 then obj_b_transp = obj_b_transp - text_fade obj_b_bg_transp = obj_b_bg_transp - bg_fade windower.send_command('text obj_b transparency '..obj_b_transp..';text obj_b bg_transparency '..obj_b_bg_transp..'') end
		if obj_c_line == 6 and obj_c_transp - text_fade >= 1 then obj_c_transp = obj_c_transp - text_fade obj_c_bg_transp = obj_c_bg_transp - bg_fade windower.send_command('text obj_c transparency '..obj_c_transp..';text obj_c bg_transparency '..obj_c_bg_transp..'') end
		if obj_d_line == 6 and obj_d_transp - text_fade >= 1 then obj_d_transp = obj_d_transp - text_fade obj_d_bg_transp = obj_d_bg_transp - bg_fade windower.send_command('text obj_d transparency '..obj_d_transp..';text obj_d bg_transparency '..obj_d_bg_transp..'') end
		if obj_e_line == 6 and obj_e_transp - text_fade >= 1 then obj_e_transp = obj_e_transp - text_fade obj_e_bg_transp = obj_e_bg_transp - bg_fade windower.send_command('text obj_e transparency '..obj_e_transp..';text obj_e bg_transparency '..obj_e_bg_transp..'') end
		if obj_f_line == 6 and obj_f_transp - text_fade >= 1 then obj_f_transp = obj_f_transp - text_fade obj_f_bg_transp = obj_f_bg_transp - bg_fade windower.send_command('text obj_f transparency '..obj_f_transp..';text obj_f bg_transparency '..obj_f_bg_transp..'') end

		if obj_a_y_pos == line_1_y_pos or obj_a_y_pos == line_2_y_pos or obj_a_y_pos == line_3_y_pos or obj_a_y_pos == line_4_y_pos or obj_a_y_pos == line_5_y_pos or obj_a_y_pos == line_6_y_pos or obj_a_y_pos == line_6_y_pos + line_spacer then

			move = false --Stops moving the Objects

			--If an Object is now on Line 6 we make sure its now invisible since the fade number was rounded and may not be perfect
			if obj_a_line == 6 then windower.send_command('wait .1;text obj_a transparency 1;text obj_a bg_transparency 1') end
			if obj_b_line == 6 then windower.send_command('wait .1;text obj_b transparency 1;text obj_b bg_transparency 1') end
			if obj_c_line == 6 then windower.send_command('wait .1;text obj_c transparency 1;text obj_c bg_transparency 1') end
			if obj_d_line == 6 then windower.send_command('wait .1;text obj_d transparency 1;text obj_d bg_transparency 1') end
			if obj_e_line == 6 then windower.send_command('wait .1;text obj_e transparency 1;text obj_e bg_transparency 1') end
			if obj_f_line == 6 then windower.send_command('wait .1;text obj_f transparency 1;text obj_f bg_transparency 1') end

			--If an Object is now on line 1 then we update the y position, transparency, and background transparency for it
			if obj_a_line == 1 then obj_a_y_pos = line_1_y_pos obj_a_transp = text_transparency obj_a_bg_transp = bg_transparency windower.send_command('wait .1;text obj_a pos '..x_pos..' '..line_1_y_pos..';text obj_a transparency '..obj_a_transp..';text obj_a bg_transparency '..obj_a_bg_transp..'') end
			if obj_b_line == 1 then obj_b_y_pos = line_1_y_pos obj_b_transp = text_transparency obj_b_bg_transp = bg_transparency windower.send_command('wait .1;text obj_b pos '..x_pos..' '..line_1_y_pos..';text obj_b transparency '..obj_b_transp..';text obj_b bg_transparency '..obj_b_bg_transp..'') end
			if obj_c_line == 1 then obj_c_y_pos = line_1_y_pos obj_c_transp = text_transparency obj_c_bg_transp = bg_transparency windower.send_command('wait .1;text obj_c pos '..x_pos..' '..line_1_y_pos..';text obj_c transparency '..obj_c_transp..';text obj_c bg_transparency '..obj_c_bg_transp..'') end
			if obj_d_line == 1 then obj_d_y_pos = line_1_y_pos obj_d_transp = text_transparency obj_d_bg_transp = bg_transparency windower.send_command('wait .1;text obj_d pos '..x_pos..' '..line_1_y_pos..';text obj_d transparency '..obj_d_transp..';text obj_d bg_transparency '..obj_d_bg_transp..'') end
			if obj_e_line == 1 then obj_e_y_pos = line_1_y_pos obj_e_transp = text_transparency obj_e_bg_transp = bg_transparency windower.send_command('wait .1;text obj_e pos '..x_pos..' '..line_1_y_pos..';text obj_e transparency '..obj_e_transp..';text obj_e bg_transparency '..obj_e_bg_transp..'') end
			if obj_f_line == 1 then obj_f_y_pos = line_1_y_pos obj_f_transp = text_transparency obj_f_bg_transp = bg_transparency windower.send_command('wait .1;text obj_f pos '..x_pos..' '..line_1_y_pos..';text obj_f transparency '..obj_f_transp..';text obj_f bg_transparency '..obj_f_bg_transp..'') end

			--Adds the new notifications text and color into the next object (the one now at the top)
			if next_obj == "A" then
				windower.send_command('wait .1;text obj_a text "• '..notification_text..'";text obj_a color '..notification_color..'')
				obj_a_fade_delay = auto_fade_delay
				obj_a_clear = true
				next_obj = "F"
			elseif next_obj == "B" then
				windower.send_command('wait .1;text obj_b text "• '..notification_text..'";text obj_b color '..notification_color..'')
				obj_b_fade_delay = auto_fade_delay
				obj_b_clear = true
				next_obj = "A"
			elseif next_obj == "C" then
				windower.send_command('wait .1;text obj_c text "• '..notification_text..'";text obj_c color '..notification_color..'')
				obj_c_fade_delay = auto_fade_delay
				obj_c_clear = true
				next_obj = "B"
			elseif next_obj == "D" then
				windower.send_command('wait .1;text obj_d text "• '..notification_text..'";text obj_d color '..notification_color..'')
				obj_d_fade_delay = auto_fade_delay
				obj_d_clear = true
				next_obj = "C"
			elseif next_obj == "E" then
				windower.send_command('wait .1;text obj_e text "• '..notification_text..'";text obj_e color '..notification_color..'')
				obj_e_fade_delay = auto_fade_delay
				obj_e_clear = true
				next_obj = "D"
			elseif next_obj == "F" then
				windower.send_command('wait .1;text obj_f text "• '..notification_text..'";text obj_f color '..notification_color..'')
				obj_f_fade_delay = auto_fade_delay
				obj_f_clear = true
				next_obj = "E"
			end
		end
	end

	if os.time() > Heartbeat then
		Heartbeat = os.time() --this gets updated once per second, then we do the things below

		--fade delay countdown
		if obj_a_fade_delay > 0 then obj_a_fade_delay = obj_a_fade_delay - 1 end
		if obj_b_fade_delay > 0 then obj_b_fade_delay = obj_b_fade_delay - 1 end
		if obj_c_fade_delay > 0 then obj_c_fade_delay = obj_c_fade_delay - 1 end
		if obj_d_fade_delay > 0 then obj_d_fade_delay = obj_d_fade_delay - 1 end
		if obj_e_fade_delay > 0 then obj_e_fade_delay = obj_e_fade_delay - 1 end
		if obj_f_fade_delay > 0 then obj_f_fade_delay = obj_f_fade_delay - 1 end

	end
end)

--windower.register_event('load', create_objects:cond(function() return windower.ffxi.get_info().logged_in end))
windower.register_event('load', create_objects)

windower.register_event('login', create_objects)

windower.register_event('logout', delete_objects)

windower.register_event('unload', delete_objects)

windower.register_event('addon command', function(cmd, ...)

	if cmd == 'clear' then
		clear_objects()
    elseif cmd == 'help' then
		display_help()
	elseif cmd == 'test' then
		test_start()
	else
		windower.add_to_chat(200,'Notify: '..('Invalid command'):color(8)..'')
		display_help()
	end
	
end)

function trade()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav') end
	notification_text = "Trade Request"
	notification_color = "255 255 50"
	new_notification()
end

function sneak()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav') end
	notification_text = "Sneak Wearing"
	notification_color = "255 100 100"
	new_notification()
end

function invisible()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav') end
	notification_text = "Invisible Wearing"
	notification_color = "255 100 100"
	new_notification()
end

function party()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav') end
	notification_text = "Party Invite"
	notification_color = "255 255 50"
	new_notification()
end

function alliance()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav') end
	notification_text = "Alliance Invite"
	notification_color = "255 255 50"
	new_notification()
end

function time_remaining_15()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav') end
	notification_text = "15 Minutes Remaining"
	notification_color = "255 100 100"
	new_notification()
end

function time_remaining_10()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav') end
	notification_text = "10 Minutes Remaining"
	notification_color = "255 100 100"
	new_notification()
end

function time_remaining_5()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav') end
	notification_text = "5 Minutes Remaining"
	notification_color = "255 50 50"
	new_notification()
end

function time_remaining_1()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav') end
	notification_text = "1 Minute Remaining"
	notification_color = "255 50 50"
	new_notification()
end

function trial()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav') end
	notification_text = "Trial complete"
	notification_color = "255 255 50"
	new_notification()
end

function coalition()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav') end
	notification_text = "Assigment complete"
	notification_color = "255 255 50"
	new_notification()
end

function nyzul_leader()
	notification_text = "Enemy Leader"
	notification_color = "255 255 50"
	new_notification()
end

function nyzul_lamps()
	notification_text = "Lamps"
	notification_color = "255 255 50"
	new_notification()
end

function nyzul_all()
	notification_text = "All enemies"
	notification_color = "255 255 50"
	new_notification()
end

function nyzul_specified()
	notification_text = "Specified enemies"
	notification_color = "255 255 50"
	new_notification()
end

function nyzul_specific()
	notification_text = "Specific enemy"
	notification_color = "255 255 50"
	new_notification()
end

function nyzul_gears_avoid()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav') end
	notification_text = "Avoid Gears"
	notification_color = "255 255 50"
	new_notification()
end

function nyzul_gears_kill()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav') end
	notification_text = "Do Not Kill Gears"
	notification_color = "255 255 50"
	new_notification()
end

function nyzul_complete()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav') end
	notification_text = "Floor complete"
	notification_color = "255 255 50"
	new_notification()
end

function food()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav') end
	notification_text = "Food Has Worn Off"
	notification_color = "255 50 50"
	new_notification()
end

function reraise()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav') end
	notification_text = "Reraise Has Worn Off"
	notification_color = "255 50 50"
	new_notification()
end

function commitment()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav') end
	notification_text = "Commitment Has Worn Off"
	notification_color = "255 50 50"
	new_notification()
end

function vorseal()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav') end
	notification_text = "Vorseal Has Worn Off"
	notification_color = "255 50 50"
	new_notification()
end

function signet()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav') end
	notification_text = "Signet Has Worn Off"
	notification_color = "255 50 50"
	new_notification()
end

function sanction()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav') end
	notification_text = "Sanction Has Worn Off"
	notification_color = "255 50 50"
end

function sigil()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav') end
	notification_text = "Sigil Has Worn Off"
	notification_color = "255 50 50"
	new_notification()
end

function ionis()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiBad.wav') end
	notification_text = "Ionis Has Worn Off"
	notification_color = "255 50 50"
	new_notification()
end

function weakness()
	if alertsounds then windower.play_sound(windower.addon_path..'data/sounds/NotiGood.wav') end
	notification_text = "Weakness Has Worn Off"
	notification_color = "75 255 75"
	new_notification()
end

windower.register_event('incoming text',function(org)     
	if trade and org:find('wishes to trade with you') then								--Trade
		trade()
	elseif org:find('The effect of') and org:find('is about to wear off.')then			--Sneak/Invis
		if sneak and org:find('Sneak') then
			sneak()
		elseif invisible and org:find('Invisible') then
			invisible()
		end
	-- elseif org:find('Lost key item') and org:find('Radialens') then
		-- send_command('gs c Radialens')
	elseif invite and org:find('invites you to') then									--Invite
		if org:find('party') and not org:find('alliance') then
			party()
		elseif org:find('alliance') then
			alliance()
		end
	elseif visitant_status and org:find('Your visitant status will wear off in') then	--Visitant
		if org:find(' 15 ') then
			time_remaining_15()
		elseif org:find(' 10 ') then
			time_remaining_10()
		elseif org:find(' 5 ') then
			time_remaining_5()
		end
	elseif trial and org:find('You have completed Trial') then							--Trials
		trial()
	elseif coalition and org:find('You have accomplished a coalition assignment!') then	--Coalition
		coalition()
	elseif nyzul and org:find('Objective: Eliminate enemy leader.') then				--Nyzul Leader
		nyzul_leader()
	elseif nyzul and org:find('Objective: Activate all lamps.') then					--Nyzul Lamps
		nyzul_lamps()
	elseif nyzul and org:find('Objective: Eliminate all enemies.') then					--Nyzul All
		nyzul_all()
	elseif nyzul and org:find('Objective: Eliminate specified enemies.') then			--Nyzul Specified
		specified()
	elseif nyzul and org:find('Objective: Eliminate specified enemy.') then				--Nyzul Specific
		nyzul_specific()
	elseif nyzul and org:find('Avoid discovery by archaic gears!') then					--Nyzul Gears Avoid
		nyzul_gears_avoid()
	elseif nyzul and org:find('Do not destroy archaic gears!') then						--Nyzul Gears Kill
		nyzul_gears_kill()
	elseif nyzul and org:find('Time remaining') and org:find('minute') then				--Nyzul Time Remaining
		if org:find(' 10 ') then
			time_remaining_10()
		elseif org:find(' 5 ') then
			time_remaining_5()
		elseif org:find(' 1 ') then
			time_remaining_1()
		end
	elseif nyzul and org:find('objective complete. Rune of Transfer activated.') then	--Nyzul Complete
		nyzul_complete()
	end
end)

windower.register_event('lose buff', function(buff)
	if buff == 251 and food then														--food wears off
		food()
	elseif buff == 113 and reraise then													--reraise wears off
		reraise()
	elseif buff == 579 and commitment then												--commitment wears off
		commitment()
	elseif buff == 602 and (windower.ffxi.get_info().zone == 288 or windower.ffxi.get_info().zone == 289 or windower.ffxi.get_info().zone == 291) and vorseal then --Vorseal
		vorseal()
	elseif buff == 253 and signet then													--Signet
		signet()
	elseif buff == 256 and sanction then												--Sanction
		sanction()
	elseif buff == 268 and sigil then													--Sigil
		sigil()
	elseif buff == 512 and ionis then													--Ionis
		ionis()
	elseif buff == 1 and weakness then													--Weakness
		weakness()
	end
end)

windower.register_event('status change', function(status)
    if status == 4 then --In a cutscene: Hide all Objects
		windower.send_command('text obj_a hide;text obj_b hide;text obj_c hide;text obj_d hide;text obj_e hide;text obj_f hide')
    elseif status ~= 4 then --Out of cutscene: Show all Objects
		windower.send_command('text obj_a show;text obj_b show;text obj_c show;text obj_d show;text obj_e show;text obj_f show')
    end
end)

--emporox
