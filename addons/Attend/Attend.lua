--Copyright (c) 2025, Key
--All rights reserved.

--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:

--    * Redistributions of source code must retain the above copyright
--      notice, this list of conditions and the following disclaimer.
--    * Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in the
--      documentation and/or other materials provided with the distribution.
--    * Neither the name of Attend nor the
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

_addon.name = 'Attend'
_addon.version = '1.0'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'attend'}

config = require('config')
res = require('resources')
require 'chat'

add_to_chat = windower.add_to_chat
copy_to_clipboard = windower.copy_to_clipboard
get_info = windower.ffxi.get_info
get_party = windower.ffxi.get_party
register_event = windower.register_event

previous_zone_name = nil

defaults = {
	after_zone_delay = 6,
	auto_run = {
		dynamis = true,
		omen = false,
		vagary = false,
	},
}

settings = config.load(defaults)

auto_run = settings.auto_run

function getEvent()

	local current_zone_name = res.zones[get_info().zone].en
	local event = current_zone_name

	if current_zone_name == "Reisenjima Henge" then
		event = 'Omen'
	elseif current_zone_name:find("^Outer Ra'Kaznar") and previous_zone_name == "Outer Ra'Kaznar" then
		event = 'Vagary'
	end

	return event

end

function getDate()

	-- %a = abbreviated weekday
	-- %B = full month name
	-- %e = day of month
	-- %Y = four-digit year
	local date_str = os.date("%a, %B %e, %Y")

	-- remove leading space from the day
	return date_str:gsub("%s(%d),", "%1,")

end

function getNames()

	local party = get_party()
	if not party then return "" end

	local result = {}
	local parties = {
		{label = "__Party 1__", keys = {"p0","p1","p2","p3","p4","p5"}},
		{label = "__Party 2__", keys = {"a10","a11","a12","a13","a14","a15"}},
		{label = "__Party 3__", keys = {"a20","a21","a22","a23","a24","a25"}},
	}

	for _, group in ipairs(parties) do
		local names = {}
		for _, key in ipairs(group.keys) do
			local member = party[key]
			if member and member.name then
				table.insert(names, "* " .. member.name)
			end
		end

		if #names > 0 then
			-- Add party label
			table.insert(result, group.label)
			-- Add players
			for i, name in ipairs(names) do
				if i < #names then
					table.insert(result, name) -- adds new line
				else
					table.insert(result, name) -- last one, no new line
				end
			end
		end
	end

	return table.concat(result, "\n")

end

function run()

	local event = getEvent()
	local event_title = event and event == "Dynamis" and res.zones[get_info().zone].en or event
	local date = getDate()
	local names = getNames()
	local text = '## ' .. event .. '\n' .. date .. '\n\n' .. names

	copy_to_clipboard(text)

	add_to_chat(8,('[Attend] '):color(220)..('Attendance copied to clipboard.'):color(36))

end

register_event('zone change',function(new_id, old_id)

	previous_zone_name = res.zones[old_id].en
	local current_zone_name = res.zones[get_info().zone].en

	local should_run =
		(auto_run.dynamis and current_zone_name:find("^Dynamis")) or
		(auto_run.omen and current_zone_name == "Reisenjima Henge") or
		(auto_run.vagary and current_zone_name:find("^Outer Ra'Kaznar") and previous_zone_name == "Outer Ra'Kaznar") or
		(current_zone_name:find("^Outer Ra'Kaznar") and previous_zone_name == "Kamihr Drifts")

	if should_run then
		coroutine.schedule(run, settings.after_zone_delay)
	end

end)

register_event('addon command',function(addcmd, ...)

	if addcmd == "help" then

		local curr_dynamis = auto_run.dynamis and "ON" or "OFF"
		local curr_omen = auto_run.omen and "ON" or "OFF"
		local curr_vagary = auto_run.vagary and "ON" or "OFF"
		local prefix = "//attend"
		add_to_chat(8,('[Attend] '):color(220)..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220)..(' ('):color(8)..(prefix):color(1)..(')'):color(8))
		add_to_chat(8,(' Copy a formatted list of attendees to the clipboard to paste into Discord.'):color(1))
		add_to_chat(8,(' Command '):color(36)..('- Description ['):color(8)..('Current Setting'):color(200)..(']'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,(' [blank/no command] '):color(36)..('- Copy current attendees to clipboard.'):color(8))
		add_to_chat(8,(' dynamis/d '):color(36)..('- Toggle auto-run for Dynamis. ['):color(8)..curr_dynamis:color(200)..(']'):color(8))
		add_to_chat(8,(' omen/o '):color(36)..('- Toggle auto-run for Omen. ['):color(8)..curr_omen:color(200)..(']'):color(8))
		add_to_chat(8,(' vagary/v '):color(36)..('- Toggle auto-run for Vagary. ['):color(8)..curr_vagary:color(200)..(']'):color(8))

	elseif addcmd == "dynamis" or addcmd == "dyna" or addcmd == "dyn" or addcmd == "d" then

		settings.auto_run.dynamis = not settings.auto_run.dynamis
		auto_run.dynamis = settings.auto_run.dynamis
		add_to_chat(8,('[Attend] '):color(220)..('Auto-run for Dynamis set to '):color(36)..('%s'):format(auto_run.dynamis and 'ON' or 'OFF'):color(200)..('.'):color(36))
		settings:save('all')

	elseif addcmd == "vagary" or addcmd == "vag" or addcmd == "v" then

		settings.auto_run.vagary = not settings.auto_run.vagary
		auto_run.vagary = settings.auto_run.vagary
		add_to_chat(8,('[Attend] '):color(220)..('Auto-run for Vagary set to '):color(36)..('%s'):format(auto_run.vagary and 'ON' or 'OFF'):color(200)..('.'):color(36))
		settings:save('all')

	elseif addcmd == "omen" or addcmd == "o" then

		settings.auto_run.omen = not settings.auto_run.omen
		auto_run.omen = settings.auto_run.omen
		add_to_chat(8,('[Attend] '):color(220)..('Auto-run for Omen set to '):color(36)..('%s'):format(auto_run.omen and 'ON' or 'OFF'):color(200)..('.'):color(36))
		settings:save('all')

	else

		run()

	end

end)
