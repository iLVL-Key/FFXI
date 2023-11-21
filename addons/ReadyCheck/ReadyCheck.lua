--[[
Copyright © 2023, Key
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of ReadyCheck nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Key BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

_addon.name = 'ReadyCheck'
_addon.version = '1.0'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'readycheck','rc'}

require 'logger'
require 'chat'
texts = require('texts')
config = require('config')
packets = require('packets')

defaults = {}

defaults.call_num = 14

defaults.flags = T{}
defaults.flags.bold = true
defaults.flags.draggable = true

defaults.pos = T{}
defaults.pos.x = math.floor(windower.get_windower_settings().ui_x_res / 3)
defaults.pos.y = math.floor(windower.get_windower_settings().ui_y_res / 3)

defaults.bg = T{}
defaults.bg.red = 0
defaults.bg.green = 0
defaults.bg.blue = 0
defaults.bg.alpha = 175

defaults.text = T{}
defaults.text.font = 'Courier New'
defaults.text.size = 10
defaults.text.alpha = 255

defaults.colors = T{}
defaults.colors.header = T{}
defaults.colors.header.r = 255
defaults.colors.header.g = 255
defaults.colors.header.b = 255
defaults.colors.ready = T{}
defaults.colors.ready.r = 50
defaults.colors.ready.g = 255
defaults.colors.ready.b = 50
defaults.colors.notReady = T{}
defaults.colors.notReady.r = 255
defaults.colors.notReady.g = 50
defaults.colors.notReady.b = 50
defaults.colors.self = T{}
defaults.colors.self.r = 255
defaults.colors.self.g = 255
defaults.colors.self.b = 255
defaults.colors.unknown = T{}
defaults.colors.unknown.r = 200
defaults.colors.unknown.g = 200
defaults.colors.unknown.b = 200

settings = config.load(defaults)

ready = {}
notReady = {}

local self_name
if windower.ffxi.get_mob_by_target('me') then
	self_name = windower.ffxi.get_mob_by_target('me').name
end
windower.register_event('login', function()
	coroutine.sleep(3)
	self_name = windower.ffxi.get_mob_by_target('me').name
end)

local ally_pos = {
	'p0', 'p1', 'p2', 'p3', 'p4', 'p5', 'a10', 'a11', 'a12', 'a13', 'a14', 'a15', 'a20', 'a21', 'a22', 'a23', 'a24', 'a25'
}
local say = windower.chat.input
local timer = 120 -- This timer is hard-coded so that all players running ReadyCheck have their timers synced
local timer_countdown = -1 -- A settings of -1 for this means there is no ready check active
local hideDelay = 5
local hideDelay_countdown = -1
local Heartbeat = 0
local zoning = false
local someoneElseIsAlreadyRunningAReadyCheck = false

rcBox = texts.new('${current_string}', settings)


-- Show the RC box
function showBox()
	rcBox:show()
end


-- Hide the RC box
function hideBox()
	rcBox:hide()
end


-- Update the RC box
function updateBox()

	local headerColor = settings.colors.header
	local readyColor = settings.colors.ready
	local notReadyColor = settings.colors.notReady
	local selfColor = settings.colors.self
	local unknownColor = settings.colors.unknown
	local color

	-- Create a temporary "text" string that we use to build what's displayed in the RC box
	local text = '\\cs('..headerColor.r..', '..headerColor.g..', '..headerColor.b..')'

	-- First row (the +1 is to compensate for a quirk with the timing being displayed)
	local first_row = ('---READY CHECK%s'):format(timer_countdown >= 0 and ':'..timer_countdown+1 or '')
	-- Keep it the same widtch
	while string.len(first_row) < 21 do
		first_row = first_row..'-'
	end
	first_row = first_row..'\\cr'

	--Add the first row into the text string
	text = text..first_row

	-- Loop through all party/alliance positions
	for _, pos in ipairs(ally_pos) do
		local member = windower.ffxi.get_party()[pos]

		-- If there is a party member in that position, add them to the list in the RC box
		if member and not (windower.ffxi.get_mob_by_target(pos) and windower.ffxi.get_mob_by_target(pos).is_npc) then
			local name = member.name

			-- They are ready, highlight their name
			if ready[name] then
				color = readyColor
				text = text..'\n \\cs('..color.r..', '..color.g..', '..color.b..')O '..name..'\\cr'

			-- They are not ready, highlight their name
			elseif notReady[name] then
				color = notReadyColor
				text = text..'\n \\cs('..color.r..', '..color.g..', '..color.b..')X '..name..'\\cr'

			-- Your own name is highlighted if you have not signified ready or not yet
			elseif name == self_name then
				color = selfColor
				text = text..'\n \\cs('..color.r..', '..color.g..', '..color.b..')- '..name..'\\cr'

			-- They are unknown so far
			else
				color = unknownColor
				text = text..'\n \\cs('..color.r..', '..color.g..', '..color.b..')- '..name..'\\cr'

			end
		end
	end

	-- Update the box with the text string
	rcBox.current_string = text

end


-- Add a name to the Ready List
function addToReadyList(name)
	-- Add the name to the ready table
	ready[name] = true

	-- Remove the name from the not ready table
	notReady[name] = nil
	
	-- Update the box
	updateBox()

	-- Update the box bg_color
	texts.bg_color(rcBox, 0, bgGreen(), 0)

	-- Did that make it so everyone is now accounted for?
	if checkAllReady() and not someoneElseIsAlreadyRunningAReadyCheck then
		allReady()

	end
end


-- Add a name to the Not Ready List
function addToNotReadyList(name)
	-- Add the name to the not ready table
	notReady[name] = true

	-- Remove the name from the ready table
	ready[name] = nil
	
	-- Update the box
	updateBox()

	-- Update the box bg_color
	texts.bg_color(rcBox, 0, bgGreen(), 0)

end

-- Calculate the level of bg_color green based on the percent of players ready
function bgGreen()

	local readyNames = {}
	local totalNames = {}

	-- Loop through all party/alliance positions
	for _, pos in ipairs(ally_pos) do
		local member = windower.ffxi.get_party()[pos]

		-- If there is a party member in that position, add to the totalNames table
		if member and not (windower.ffxi.get_mob_by_target(pos) and windower.ffxi.get_mob_by_target(pos).is_npc) then
			local name = member.name
			table.insert(totalNames, member.name)

			-- If that party member is ready, also add them to the readyNames list
			if ready[name] then
				table.insert(readyNames, name)

			end
		end
	end

	-- If all are ready then add a little extra green to make it pop
	if #readyNames == #totalNames then
		return 125

	-- Otherwise, we return a number that is the percentage ready, making it grow greener as more members are ready
	else
		local green = math.floor((#readyNames / #totalNames) * 100)
		return green

	end
end


-- Check if all members are ready
function checkAllReady()

	-- Start with true
	allMembersReady = true
	
	-- Loop through all party/alliance positions
	for _, pos in ipairs(ally_pos) do
		local member = windower.ffxi.get_party()[pos]

		-- Set to false and break out of the loop at the first member that it not ready
		if member and not ready[member.name] and not (windower.ffxi.get_mob_by_target(pos) and windower.ffxi.get_mob_by_target(pos).is_npc) then
			allMembersReady = false
			break

		end
	end

	-- Return the results
	return allMembersReady

end


-- Clear the Ready List
function clearLists()
	ready = {}
	notReady = {}
end


-- All players are ready
function allReady()
	timer_countdown = -1
	updateBox()
	coroutine.sleep(1.5)
	say("/p [RC] All members are ready!")
	hideDelay_countdown = hideDelay
end


-- Display in the RC Box players that are not ready
function displayNotAllReady()
	
	-- Loop through all party/alliance positions
	for _, pos in ipairs(ally_pos) do
		local member = windower.ffxi.get_party()[pos]

		-- If there is a party member in that position...
		if member and not (windower.ffxi.get_mob_by_target(pos) and windower.ffxi.get_mob_by_target(pos).is_npc) then
			local name = member.name

			-- ... and they are not ready...
			if not ready[name] then

				-- ... add them to the NotReady List so they get displayed as such in the RC Box
				addToNotReadyList(name)

			end
		end
	end
end


-- Say in party chat players that are not ready
function sayNotAllReady()

	local notReadyNames1 = {}
	local notReadyNames2 = {}
	
	-- Loop through all party/alliance positions
	for _, pos in ipairs(ally_pos) do
		local member = windower.ffxi.get_party()[pos]

		-- If there is a party member in that position...
		if member and not (windower.ffxi.get_mob_by_target(pos) and windower.ffxi.get_mob_by_target(pos).is_npc) then
			local name = member.name

			-- ... and they are not ready...
			if not ready[name] then

				-- ... and add them to the notReadyNames list(s) to be printed in chat below
				if #notReadyNames1 < 9 then
					table.insert(notReadyNames1, name)
				else
					table.insert(notReadyNames2, name)

				end
			end
		end
	end

	-- Print the list of names that are not ready
	say("/p [RC] Not ready: " .. table.concat(notReadyNames1, ", "))

	-- Print the second list names, if applicable
	if #notReadyNames2 > 0 then
		coroutine.sleep(1.5)
		say("/p [RC] Not ready: " .. table.concat(notReadyNames2, ", "))

	end
end


-- Check if you are solo
function areYouSolo()
	
	-- Start with true
	local solo = true
	
	-- Loop through all party/alliance positions
	for _, pos in ipairs(ally_pos) do
		local member = windower.ffxi.get_party()[pos]

		-- Set to false and break out of the loop at the first position that contains another member
		if member and not (member.name == self_name) and not (windower.ffxi.get_mob_by_target(pos) and windower.ffxi.get_mob_by_target(pos).is_npc) then
			solo = false
			break
		end
	end

	-- Return the results
	return solo

end


-- Incoming chat message - NOTE: these are checking incoming packets, messages originating from yourself will not trigger them
-- (tells work though because they go out to the server first then back to you as the receiver)
windower.register_event('chat message', function(message, sender, mode)

	-- Add name to the Ready List when they slash off (limited to while a ready check is running and party chat only)
	if message:match("^[/|\\]") and timer_countdown > 0 and mode == 4 then
		addToReadyList(sender)
		
	-- Add name to the Not Ready List when they x off (limited to while a ready check is running and party chat only)
	elseif message:match("^[xX]") and timer_countdown > 0 and mode == 4 then
		addToNotReadyList(sender)

	-- Look for the RC indicator
	elseif message:find('[RC]') and mode == 4 then

		-- Someone else cancels a Ready Check
		if message:find('Ready Check cancelled.') then
			timer_countdown = -1
			hideBox()

		-- Someone else starts a Ready Check
		elseif message:find('Ready Check!') then
			clearLists()
			addToReadyList(sender)
			showBox()
			timer_countdown = timer
			hideDelay_countdown = -1
			someoneElseIsAlreadyRunningAReadyCheck = true

		-- Someone else finishes a Ready Check, not everyone ready
		elseif message:find('Not ready:') then
			displayNotAllReady()
			timer_countdown = -1
			hideDelay_countdown = hideDelay
			someoneElseIsAlreadyRunningAReadyCheck = false
		
		-- Someone else finishes a Ready Check, everyone ready
		elseif message:find('All members are ready!') then
			timer_countdown = -1
			hideDelay_countdown = hideDelay
			someoneElseIsAlreadyRunningAReadyCheck = false

		end
	end
end)


-- Check outgoing text for ready/not ready
windower.register_event('outgoing text', function(original)

	local message = original:gsub("/p ", "") -- Remove /p if it exists

	-- Ready
	if message:match("^[/|\\]") and timer_countdown > 0 then
		addToReadyList(self_name)

	--Not ready
	elseif message:match("^[xX]") and timer_countdown > 0 then
		addToNotReadyList(self_name)

	end
end)


windower.register_event('addon command',function(addcmd)

	if addcmd == 'help' then
		windower.add_to_chat(220,'[ReadyCheck] '..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..('Key (Keylesta@Valefor)'):color(220))
		windower.add_to_chat(36,'//readycheck or //rc'..(' - Start/Stop a Ready Check'):color(8))
		windower.add_to_chat(36,'   cancel'..(' - Cancel a Ready Check'):color(8))

	elseif addcmd == 'reload' then
		windower.send_command('lua r readycheck')

	elseif addcmd == 'cancel' then
		if someoneElseIsAlreadyRunningAReadyCheck then
			windower.add_to_chat(220,'[ReadyCheck] '..('You cannot cancel a Ready Check started by another member.'):color(8)..'')

		else
			say('/p [RC] Ready Check cancelled.')
			timer_countdown = -1
			hideBox()

		end

	elseif someoneElseIsAlreadyRunningAReadyCheck then
		windower.add_to_chat(220,'[ReadyCheck] '..('Another member has already started a Ready Check.'):color(8)..'')

	else
		-- Start a ready check
		if timer_countdown == -1 then
			if areYouSolo() then
				windower.add_to_chat(220,'[ReadyCheck] '..('You cannot start a Ready Check when you are solo.'):color(8)..'')
				return
			end
			say('/p [RC] Ready Check!   / = ready   x = not ready   <call'..settings.call_num..'>')
			clearLists()
			addToReadyList(self_name)
			showBox()
			timer_countdown = timer
			hideDelay_countdown = -1

		-- End the ready check
		elseif timer_countdown > 0 then
			timer_countdown = -1
			updateBox()
			displayNotAllReady()
			sayNotAllReady()
			hideDelay_countdown = hideDelay

		end
	end
end)


windower.register_event('prerender', function()
	
	-- Creates a 1 second Heartbeat
	if os.time() > Heartbeat then
		Heartbeat = os.time()

		-- Ready Check countdown in progress (pause the countdown if we're zoning and its our RC running since we're about to cancel it)
		if timer_countdown >= 1 and not (zoning and not someoneElseIsAlreadyRunningAReadyCheck) then
			timer_countdown = timer_countdown - 1
			updateBox()

		-- Countdown reaches 0
		elseif timer_countdown == 0 then
			timer_countdown = -1
			updateBox()
			displayNotAllReady()
			if not someoneElseIsAlreadyRunningAReadyCheck then
				sayNotAllReady()
			end
			someoneElseIsAlreadyRunningAReadyCheck = false
			hideDelay_countdown = hideDelay

		end

		if hideDelay_countdown >= 1 then
			hideDelay_countdown = hideDelay_countdown -1
		elseif hideDelay_countdown == 0 then
			hideDelay_countdown = -1
			hideBox()

		end
	end

	local pos = windower.ffxi.get_position()

	-- Zoning, hide the RC Box
	if pos == "(?-?)" and not zoning then
		hideBox()
		zoning = true

	-- Finished zoning while a Ready Check in progress, show the RC Box
	elseif pos ~= "(?-?)" and zoning then
		zoning = false
		if timer_countdown >= 1 and not someoneElseIsAlreadyRunningAReadyCheck then
			timer_countdown = -1
			coroutine.sleep(3)
			say('/p [RC] Ready Check cancelled.')
		elseif timer_countdown > 0 then
			showBox()
		end

	end
end)
