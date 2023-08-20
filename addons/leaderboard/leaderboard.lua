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
    * Neither the name of Leaderboard nor the
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

_addon.name = 'Leaderboard'
_addon.version = '3.4'
_addon.author = 'Key'
_addon.commands = {'leaderboard','lb'}

require 'logger'
require 'chat'
texts = require('texts')
config = require('config')
packets = require('packets')

defaults = {}					-- In addition to the settings file, all of these are also configurable via commands in-game (//lb help).
defaults.party_commands = true	-- Allow party/alliance members to trigger certain commands via chat while in Party/Lite Mode.
defaults.flood_delay = 5		-- Sets the delay between incoming party commands, preventing party members from spamming commands.
defaults.reminder = true		-- Display a reminder upon zoning that Leaderboard is running while in Party/Lite Mode.
defaults.commas = true			-- Add commas to the scores.
defaults.visible = true			-- Display the scores with an On-Screen Display.
defaults.optout = {}			-- List of names to be excluded from data collection.
defaults.rival = ''				-- Name of an optional Rival to track.
defaults.taunt = 'I&apos;m beating you on %s. Just thought you should know.'	-- Text the taunt command sends your Rival
defaults.partymode_calls = T{}			-- Party Mode party chat calls for:
defaults.partymode_calls.cure = true	--  Cure, every 50k
defaults.partymode_calls.death = true	--  Death, each
defaults.partymode_calls.hs = true		--  High WS, top 5
defaults.partymode_calls.kill = true	--  Kill, every 10
defaults.partymode_calls.ls = true		--  Low WS, top 5
defaults.partymode_calls.mb = true		--  Magic Burst, top 5
defaults.partymode_calls.murder = true	--  Murder, each
defaults.partymode_calls.nuke = true	--  Nuke, every 500k
defaults.partymode_calls.sc = true		--  Skillchains, top 5
defaults.partymode_calls.whiff = true	--  Whiff, each up to 10 then every 5

defaults.first_load = true

defaults.flags = T{}
defaults.flags.bold = true
defaults.flags.draggable = true

defaults.pos = T{}
defaults.pos.x = (windower.get_windower_settings().ui_x_res) - 350 --Sets the default X position near the right side of your screen
defaults.pos.y = (windower.get_windower_settings().ui_y_res) / 2 --Sets the default Y position in the middle of your screen

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
defaults.colors.header.r = 37
defaults.colors.header.g = 110
defaults.colors.header.b = 255
defaults.colors.text = T{}
defaults.colors.text.r = 240
defaults.colors.text.g = 240
defaults.colors.text.b = 240
defaults.colors.self = T{}
defaults.colors.self.r = 142
defaults.colors.self.g = 225
defaults.colors.self.b = 169
defaults.colors.rival = T{}
defaults.colors.rival.r = 236
defaults.colors.rival.g = 137
defaults.colors.rival.b = 142

live = {}

live.places = {}
live.places.cure = {}
live.places.death = {}
live.places.hs = {}
live.places.kill = {}
live.places.ls = {}
live.places.mb = {}
live.places.murder = {}
live.places.nuke = {}
live.places.sc = {}
live.places.whiff = {}

live.individuals = {}
live.individuals.cure = {}
live.individuals.death = {}
live.individuals.hs = {}
live.individuals.kill = {}
live.individuals.ls = {}
live.individuals.mb = {}
live.individuals.murder = {}
live.individuals.nuke = {}
live.individuals.sc = {}
live.individuals.whiff = {}

live.indexes = {}		-- Used to order the scores as they are saved to indicate which came first,
live.indexes.death = 0	-- this will then properly place duplicate score values
live.indexes.hs = 0		-- ie multiple people hit 99999, order it by who hit 99999 first
live.indexes.kill = 0	-- Cure and Nuke are used to call out every x amount
live.indexes.ls = 0		
live.indexes.mb = 0		
live.indexes.murder = 0
live.indexes.sc = 0
live.indexes.whiff = 0

live.paused = false

settings = config.load(defaults)
live = config.load('data/live.xml', live)

local weaponskills = require('resources').weapon_skills
local spells = require('resources').spells
local jabils = require('resources').job_abilities
local mabils = require('resources').monster_abilities

local cmd = windower.send_command
local say = windower.chat.input

local Heartbeat = 0
local flood_timer = 0
local box_display = 'hs'
local Mode = 'Silent'
local zoning = false


-- When logging in, show the box
function login()
	if settings.visible then
		showBox()
	end
end


-- When logging out, hide the box
function logout()
	hideBox()
end

windower.register_event('login', login)


-- Put places info into tables to call them in order
function getPlacesInfo(places)

	local name = {
		places.first and places.first.name,
		places.second and places.second.name,
		places.third and places.third.name,
		places.fourth and places.fourth.name,
		places.fifth and places.fifth.name,
		places.sixth and places.sixth.name,
		places.seventh and places.seventh.name,
		places.eighth and places.eighth.name,
		places.ninth and places.ninth.name,
		places.tenth and places.tenth.name
	}

	local score = {
		places.first and places.first.score,
		places.second and places.second.score,
		places.third and places.third.score,
		places.fourth and places.fourth.score,
		places.fifth and places.fifth.score,
		places.sixth and places.sixth.score,
		places.seventh and places.seventh.score,
		places.eighth and places.eighth.score,
		places.ninth and places.ninth.score,
		places.tenth and places.tenth.score
	}

	local nines = {
		places.first and places.first.nines,
		places.second and places.second.nines,
		places.third and places.third.nines,
		places.fourth and places.fourth.nines,
		places.fifth and places.fifth.nines,
		places.sixth and places.sixth.nines,
		places.seventh and places.seventh.nines,
		places.eighth and places.eighth.nines,
		places.ninth and places.ninth.nines,
		places.tenth and places.tenth.nines
	}

	return {
		name = name,
		score = score,
		nines = nines
	}

end


-- Return the names back to their proper capitalization
-- Names are saved in all lowercase to get around them being lowercased automatically in the
-- settings file anyway when the addon is reloaded (ie to work properly with crash recovery).
-- This prevents a sort of "duplication" issue where the older data is now lowercased and the
-- new data started after recovery is capitalized as expected.
function capitalize(str)

	local capitalized = string.gsub(str, "(%w[%w']*)", function(word)
		if word ~= "of" then
			word = word:gsub("^%l", string.upper)
		end
		return word
	end)

	return capitalized

end


-- Turn the entire name into all uppercase
function uppercase(str)

	local uppercased = string.gsub(str, "%a", function(letter)
		return letter:upper()
	end)

	return uppercased

end


-- Add commas to numbers to make them easier to read
function addCommas(number)

	-- Convert the number to a string
	local formattedNumber = tostring(number)

	if settings.commas then
		local length = #formattedNumber

		if length > 3 then
			local insertIndex = length % 3
			if insertIndex == 0 then
				insertIndex = 3
			end

			while insertIndex < length do
				formattedNumber = formattedNumber:sub(1, insertIndex) .. "," .. formattedNumber:sub(insertIndex + 1)
				insertIndex = insertIndex + 4
				length = length + 1
			end
		end
	end

	-- Return the number (albeit as a string, we're not doing any math on it at this point)
	return formattedNumber

end


-- Show the BP box
function showBox()
	lbBox:show()
end


-- Hide the BP box
function hideBox()
	lbBox:hide()
end


-- Toggle the visibility of the LB box
function toggleBox()
	if settings.visible then
		showBox()
	else
		hideBox()
	end
end


-- Update the BP box
function updateBox(box_display)

	local textColor = settings.colors.text
	local headerColor = settings.colors.header
	local selfColor = settings.colors.self
	local rivalColor = settings.colors.rival
	local color = textColor

	local places = live.places[box_display]
	local info = getPlacesInfo(places)

	-- Create a temporary "text" array that we use to build what's displayed in the box
	local text = ''
	local board_name = Leaderboard
	if box_display == 'cure' then
		board_name = 'Cure Board'
	elseif box_display == 'death' then
		board_name = 'Death Board'
	elseif box_display == 'hs' then
		board_name = 'High WS Board'
	elseif box_display == 'kill' then
		board_name = 'Kill Board'
	elseif box_display == 'ls' then
		board_name = 'Low WS Board'
	elseif box_display == 'mb' then
		board_name = 'Magic Burst Board'
	elseif box_display == 'murder' then
		board_name = 'Murder Board'
	elseif box_display == 'nuke' then
		board_name = 'Nuke Board'
	elseif box_display == 'sc' then
		board_name = 'Skillchain Board'
	elseif box_display == 'whiff' then
		board_name = 'whiff Board'
	end

	-- The header always goes first, at the top
	text = ' \\cs('..headerColor.r..', '..headerColor.g..', '..headerColor.b..')'

	local header_text = ('%s '):format(live.paused and 'Paused' or 'Running')
	while string.len(header_text) < 19 do
		header_text = ' '..header_text
	end
	header_text = 'Leaderboard'..header_text

	text = text..header_text..'\n'

	local board_text = ' '..board_name
	while string.len(board_text) < 21 do
		board_text = board_text..' '
	end
	board_text = board_text..'//lb help\\cr \n'

	text = text..board_text

	if info.name[1] == nil then
		text = text..' Waiting For Data...'
	else
		for i = 1, 10, 1
		do
			if info.name[i] ~= nil then
				if capitalize(info.name[i]) == windower.ffxi.get_mob_by_target('me').name then
					color = selfColor
				elseif info.name[i] == settings.rival then
					color = rivalColor
				else
					color = textColor
				end
				-- Add in ternary for nines
				text = text..'\\cs('..color.r..', '..color.g..', '..color.b..') '..i..': '..capitalize(info.name[i])..' ('..addCommas(info.score[i])..(info.nines[i] > 0 and ':'..info.nines[i]..')' or ')')..'\\cr \n'
			end
		end
	end

	-- Turn the "text" array into a string and update the text inside the box
	lbBox.current_string = text

end


-- Create the LB box
lbBox = texts.new('${current_string}', settings)
if settings.visible and windower.ffxi.get_info().logged_in then
	showBox()
	updateBox(box_display)
end


cureThings = T{
	'Cure','Cure II','Cure III','Cure IV','Cure V','Cure VI','Curaga','Curaga II','Curaga III','Curaga IV','Curaga V','Cura','Cura II','Cura III','Pollen','Wild Carrot','Healing Breeze','Magic Fruit','Exuviation','Plenilune Embrace','White Wind','Restoral','Full Cure','Benediction','Repair','Curing Waltz','Curing Waltz II','Curing Waltz III','Curing Waltz IV','Curing Waltz V','Divine Waltz','Divine Waltz II','Life Cycle','Mending Halation','Vivacious Pulse','Healing Ruby','Healing Ruby II','Spring Water','Whispering Wind','Healing Breath','Healing Breath II','Healing Breath III','Healing Breath IV','Potion','Hi-Potion','X-Potion','Hyper Potion','Max. Potion','Mix: Max. Potion','Chakra'
    }


BPWS = S{
	'Punch','Rock Throw','Barracuda Dive','Claw','Welt','Axe Kick','Shock Strike','Camisado','Regal Scratch','Poison Nails','Moonlit Charge','Crescent Fang','Rock Buster','Roundhouse','Tail Whip','Double Punch','Megalith Throw','Double Slap','Eclipse Bite','Mountain Buster','Spinning Dive','Predator Claws','Rush','Chaotic Strike','Volt Strike','Hysteric Assault','Crag Throw','Blindside','Regal Gash','Burning Strike','Flaming Crush'
	}

BPNuke = S{
	'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Clarsach Call','Diamond Dust','Judgment Bolt','Searing Light','Howling Moon','Ruinous Omen','Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II','Thunderspark','Meteorite','Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV','Sonic Buffet','Nether Blast','Zantetsuken','Meteor Strike','Geocrush','Grand Fall','Wind Blade','Tornado II','Heavenly Strike','Thunderstorm','Level ? Holy','Holy Mist','Lunar Bay','Night Terror','Conflag Strike','Impact'
	}


	if settings.first_load then

		windower.add_to_chat(220,'[Leaderboard] '..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..('Key'):color(220))
		coroutine.sleep(1)
		windower.add_to_chat(220,'[Leaderboard] '..('First load detected. Type'):color(8)..(' //lb help'):color(1)..(' for a list of commands.'):color(8))
		settings.first_load = false
		settings:save('all')
	
	end


-- Hide the box when zoning
windower.register_event('prerender', function()

	local pos = windower.ffxi.get_position()

	if pos == "(?-?)" and not zoning then

		hideBox()
		zoning = true

	elseif pos ~= "(?-?)" and zoning then

		if settings.visible then
			showBox()
		end
		zoning = false

	end

end)


-- Checks that the actor is in our party/alliance and return the name
function get_actor(id)
	local actor = nil
	local ally_pos = {
		'p0', 'p1', 'p2', 'p3', 'p4', 'p5', 'a10', 'a11', 'a12', 'a13', 'a14', 'a15', 'a20', 'a21', 'a22', 'a23', 'a24', 'a25'
	}

	-- Loop through the alliance members to see if the index of the actor matches anyones pet
	for i = 1, 18, 1 do
		local ally_member = windower.ffxi.get_mob_by_target(ally_pos[i]) or nil
		if ally_member and windower.ffxi.get_mob_by_id(id) and windower.ffxi.get_mob_by_id(id).index == ally_member.pet_index then
			-- If there is a match, return the name of the pets owner
			actor = ally_member
			return actor
		end
	end

	-- If there is no match, check if the actor is in our alliance
	if actor == nil then
		local actor = windower.ffxi.get_mob_by_id(id)
		if actor == nil or (not actor.in_alliance and not actor.in_party) then
			-- Not in our alliance, return false
			return false
		else
			-- In our alliance, return the name of the actor
			return actor
		end
	end

end


-- Checks that the target is in our party/alliance and return the name
function get_target(id)
	local target = windower.ffxi.get_mob_by_id(id)
	if target == nil or (not target.in_alliance and not target.in_party) then
		return false
	else
		return target
	end
end


-- Sort the list by highest scores and return a list of the top 10
function sortNamesHigh(data)

	-- Convert the input table into a list of objects with names
	local dataList = {}
	for name, obj in pairs(data) do
		obj.name = name
		table.insert(dataList, obj)
	end

	-- Sort the dataList table
	table.sort(dataList, function(a, b)
		if a.score ~= b.score then
			return a.score > b.score -- Sort by score in descending order
		elseif a.nines ~= b.nines then
			return a.nines > b.nines -- Sort by nines in descending order
		else
			return a.index < b.index -- Sort by index in ascending order (lower numbers were first)
		end
	end)

	-- Create the board table with the top 10 results
	local board = {}
	for i = 1, math.min(10, #dataList) do
		table.insert(board, dataList[i])
	end

	return board

end


-- Sort the list by lowest scores and return a list of the top 10
function sortNamesLow(data)

	-- Convert the input table into a list of objects with names
	local dataList = {}
	for name, obj in pairs(data) do
		obj.name = name
		table.insert(dataList, obj)
	end

	-- Sort the dataList table based on the specified criteria
	table.sort(dataList, function(a, b)
		if a.score ~= b.score then
			return a.score < b.score -- Sort by score in ascending order
		else
			return a.index < b.index -- Sort by index in ascending order
		end
	end)

	-- Create the board table with the top 10 results
	local board = {}
	for i = 1, math.min(10, #dataList) do
		table.insert(board, dataList[i])
	end

	return board

end


-- Add a name to the Optout list
function addToOptout(name)

	-- Add the name to the table
	settings.optout[name] = true

	-- Delete all related data for the player
	local ind = live.individuals
	local tables = {ind.cure, ind.death, ind.hs, ind.kill, ind.ls, ind.mb, ind.murder, ind.nuke, ind.sc, ind.whiff}
	for _, table in ipairs(tables) do
		table[name] = nil
	end

	settings:save('all')

end


-- Remove a name from the Optout list
function removeFromOptout(name)
	settings.optout[name] = nil
	settings:save('all')
end


-- Return the Optout list
function optoutList()

	local names = {}

	for name, _ in pairs(settings.optout) do
		table.insert(names, name)
	end

	if next(names) == nil then
		return "[empty]"
	else
		return table.concat(names, ', ')
	end

end


-- Send the specified player their score report via tell
function reportPlayerScores(name)
	local ind = live.individuals
	local text1 = ''
	local text2 = ''
	local text_hs = (ind.hs[name] and ind.hs[name].score) and addCommas(ind.hs[name].score)..(ind.hs[name].nines > 0 and ':'..ind.hs[name].nines or '') or 'none'
	local text_ls = (ind.ls[name] and ind.ls[name].score) and addCommas(ind.ls[name].score) or 'none'
	local text_sc = (ind.sc[name] and ind.sc[name].score) and addCommas(ind.sc[name].score)..(ind.sc[name].nines > 0 and ':'..ind.sc[name].nines or '') or 'none'
	local text_whiff = (ind.whiff[name] and ind.whiff[name].score) and addCommas(ind.whiff[name].score) or 0
	local text_mb = (ind.mb[name] and ind.mb[name].score) and addCommas(ind.mb[name].score)..(ind.mb[name].nines > 0 and ':'..ind.mb[name].nines or '') or 'none'
	local text_nuke = (ind.nuke[name] and ind.nuke[name].score) and addCommas(ind.nuke[name].score) or 0
	local text_cure = (ind.cure[name] and ind.cure[name].score) and addCommas(ind.cure[name].score) or 0
	local text_death = (ind.death[name] and ind.death[name].score) and addCommas(ind.death[name].score) or 0
	local text_kill = (ind.kill[name] and ind.kill[name].score) and addCommas(ind.kill[name].score) or 0
	local text_murder = (ind.murder[name] and ind.murder[name].score) and addCommas(ind.murder[name].score) or 0
	if text_hs == "none" and text_ls == "none" and text_sc == "none" and text_whiff == 0 and text_mb == "none" and text_nuke == 0 and text_cure == 0 and text_death == 0 and text_kill == 0 and text_murder == 0 then
		text1 = 'No data for you yet.'
		text2 = ''
	else
		text1 = '(High WS: '..text_hs..') (Low WS: '..text_ls..') (Skillchain: '..text_sc..') (Magic Burst: '..text_mb..')'
		text2 = '(Whiffs: '..text_whiff..') (Nukes: '..text_nuke..') (Cures: '..text_cure..') (Murders: '..text_murder..') (Deaths: '..text_death..') (Kills: '..text_kill..')'
	end
	say('/t '..name..' '..text1)
	if text2 ~= '' then
		coroutine.sleep(1.5)
		say('/t '..name..' '..text2)
	end
end


--Reset boards
function resetC()
	live.individuals.cure = {}
	live.places.cure = {}
end
function resetD()
	live.individuals.death = {}
	live.places.death = {}
	live.indexes.death = 0
end
function resetHS()
	live.individuals.hs = {}
	live.places.hs = {}
	live.indexes.hs = 0
end
function resetK()
	live.individuals.kill = {}
	live.places.kill = {}
	live.indexes.kill = 0
end
function resetLS()
	live.individuals.ls = {}
	live.places.ls = {}
	live.indexes.ls = 0
end
function resetMB()
	live.individuals.mb = {}
	live.places.mb = {}
	live.indexes.mb = 0
end
function resetM()
	live.individuals.murder = {}
	live.places.murder = {}
	live.indexes.murder = 0
end
function resetN()
	live.individuals.nuke = {}
	live.places.nuke = {}
end
function resetSC()
	live.individuals.sc = {}
	live.places.sc = {}
	live.indexes.sc = 0
end
function resetW()
	live.individuals.whiff = {}
	live.places.whiff = {}
	live.indexes.whiff = 0
end
function resetALL()
	resetC()
	resetD()
	resetHS()
	resetK()
	resetLS()
	resetMB()
	resetM()
	resetN()
	resetSC()
	resetW()
end


-- Incoming chat message - NOTE: these are checking incoming packets, messages originating from yourself will not trigger them
-- (tells work though because they go out to the server first then back to you as the receiver)
windower.register_event('chat message', function(message, sender, mode)

	-- Limit to tells(3) and party chat(4), and make sure we're in Party or Lite Mode, Party Commands are enabled, and the flood timer is not running
	if not (mode == 3 or mode == 4) or Mode == "Silent" or not settings.party_commands or flood_timer ~= 0 then
		return
	end

	local l_name = string.lower(sender)

	-- CURE BOARD
	if (message:find('!lb c') or message:find('!lbc') or message:find('!LB C') or message:find('!LBC')) then
		cmd('lb c')

	-- DEATH BOARD
	elseif (message:find('!lb d') or message:find('!lbd') or message:find('!LB D') or message:find('!LBD')) then
		cmd('lb d')

	-- HIGH WS BOARD
	elseif (message:find('!lb hs') or message:find('!lbhs') or message:find('!LB HS') or message:find('!LBHS')) then
		cmd('lb hs')

	-- KILL BOARD
	elseif (message:find('!lb k') or message:find('!lbk') or message:find('!LB K') or message:find('!LBK')) then
		cmd('lb k')

	-- LOW WS BOARD
	elseif (message:find('!lb ls') or message:find('!lbls') or message:find('!LB LS') or message:find('!LBLS')) then
		cmd('lb ls')

	-- MAGIC BURST BOARD
	elseif (message:find('!lb mb') or message:find('!lbmb') or message:find('!LB MB') or message:find('!LBMB')) then
		cmd('lb mb')

	-- MURDER BOARD
	elseif (message:find('!lb m') or message:find('!lbm') or message:find('!LB M') or message:find('!LBM')) then
		cmd('lb m')

	-- NUKE BOARD
	elseif (message:find('!lb n') or message:find('!lbn') or message:find('!LB N') or message:find('!LBN')) then
		cmd('lb n')

	-- SKILLCHAIN BOARD
	elseif (message:find('!lb sc') or message:find('!lbsc') or message:find('!LB SC') or message:find('!LBSC')) then
		cmd('lb sc')

	-- WHIFF BOARD
	elseif (message:find('!lb w') or message:find('!lbw') or message:find('!LB W') or message:find('!LBW')) then
		cmd('lb w')

	-- Send a score update to the message sender
	elseif message:find('!lb report') then
		reportPlayerScores(l_name)

	-- Add/remove the message sender to the Optout list
	elseif message:find('!lb optout') then
		if settings.optout[l_name] then
			removeFromOptout(sender)
			say('/t '..sender..' [Leaderboard] You have been removed from the Optout list.')
		else
			addToOptout(sender)
			say('/t '..sender..' [Leaderboard] You have been added to the Optout list. Any related data has been deleted.')
		end

	-- Unknown command
	elseif message:find('!lb') then
		say('/t '..sender..' [Leaderboard] Unknown command. Valid cammands are: \'!lb c|d|hs|k|ls|m|mb|n|sc|w|report|optout\'')

	end
	
	-- Reset the flood timer after a command comes in
	flood_timer = settings.flood_delay
end)


windower.register_event('incoming chunk', function(id, original, modified, injected, blocked)
	if id == 0x029 and not live.paused then

		local packet = packets.parse('incoming', original)
		local target = get_target(packet['Target'])
		local actor = get_actor(packet['Actor'])

		-- A monster is killed
		if packet['Message'] == 6 then

			----------
			-- KILL -- Actor: does the killing, Target: is what was killed
			----------

			-- Make sure the actor is part of the party/alliance
			if actor == false then
				return
			end

			local data = {}
			data.actor = actor.id
			data.actor_name = actor.name or 'unknown'
			data.actor_lower_name = string.lower(actor.name) or 'unknown'

			-- Make sure the actor is not on the Optout list
			if settings.optout[data.actor_lower_name] then
				return
			end

			local killPlaces = live.places.kill
			local killIndividuals = live.individuals.kill

			-- Retrieve the actors relevant data
			local kills = (killIndividuals[data.actor_lower_name] and killIndividuals[data.actor_lower_name].score) or 0
			local index = live.indexes.kill

			-- Update the actors score information
			kills = kills +1
			index = index +1 -- Increment the index number for every updated score, ensuring no duplicates
			live.indexes.kill = index
			killIndividuals[data.actor_lower_name] = {score = kills, nines = 0, index = index}

			-- Update the leaderboard places
			local board = sortNamesHigh(live.individuals.kill)
			killPlaces.first	= board[1]
			killPlaces.second	= (board and board[2]) or nil
			killPlaces.third	= (board and board[3]) or nil
			killPlaces.fourth	= (board and board[4]) or nil
			killPlaces.fifth	= (board and board[5]) or nil
			killPlaces.sixth	= (board and board[6]) or nil
			killPlaces.seventh	= (board and board[7]) or nil
			killPlaces.eighth	= (board and board[8]) or nil
			killPlaces.ninth	= (board and board[9]) or nil
			killPlaces.tenth	= (board and board[10]) or nil
			live:save('all')
			updateBox(box_display)

			-- Call out Kills, depending on the mode and how many Kills they are at
			if Mode ~= "Silent" and settings.partymode_calls.kill then
				local everyNumKills = kills % 10 -- returns the remainder after euclidean division (division by subtraction)
				if everyNumKills == 0 then -- if that leftover number equals 0, then the number is a multiple of Num
					say('/p [KILL] '..data.actor_name..' has racked up '..addCommas(kills)..' kills!')
				end
			end

		-- A player is killed
		elseif packet['Message'] == 97 then

			-- The killer was a monster
			if actor == false then

				-----------
				-- DEATH -- Actor: does the killing, Target: is what was killed
				-----------

				-- Make sure the target is part of the party/alliance
				if target == false then
					return
				end

				local data = {}
				data.target = target.id
				data.target_name = target.name or 'unknown'
				data.target_lower_name = string.lower(target.name) or 'unknown'

				-- Make sure the target is not on the Optout list
				if settings.optout[data.target_lower_name] then
					return
				end

				local deathPlaces = live.places.death
				local deathIndividuals = live.individuals.death

				-- Retrieve the targets relevant data
				local deaths = (deathIndividuals[data.target_lower_name] and deathIndividuals[data.target_lower_name].score) or 0
				local index = live.indexes.death

				-- Update the targets score information
				deaths = deaths +1
				index = index +1 -- Increment the index number for every updated score, ensuring no duplicates
				live.indexes.death = index
				deathIndividuals[data.target_lower_name] = {score = deaths, nines = 0, index = index}

				-- Update the leaderboard places
				local board = sortNamesHigh(live.individuals.death)
				deathPlaces.first	= board[1]
				deathPlaces.second	= (board and board[2]) or nil
				deathPlaces.third	= (board and board[3]) or nil
				deathPlaces.fourth	= (board and board[4]) or nil
				deathPlaces.fifth	= (board and board[5]) or nil
				deathPlaces.sixth	= (board and board[6]) or nil
				deathPlaces.seventh	= (board and board[7]) or nil
				deathPlaces.eighth	= (board and board[8]) or nil
				deathPlaces.ninth	= (board and board[9]) or nil
				deathPlaces.tenth	= (board and board[10]) or nil
				live:save('all')
				updateBox(box_display)

				-- Call out Deaths, depending on the mode and how many Deaths they are at
				if Mode ~= "Silent" and settings.partymode_calls.death then
					if deaths == 1 and data.target_lower_name == deathPlaces.first.name then
						say('/p [DEATH] '..data.target_name..' is the first to die!')
					elseif deaths == 1 then
						say('/p [DEATH] '..data.target_name..' has their first death!')
					elseif deaths < 10 then
						say('/p [DEATH] '..data.target_name..(' has died %s'):format(deaths < 5 and '' or 'yet ')..'again...')
					else
						local everyNumDeaths = deaths % 5 -- returns the remainder after euclidean division (division by subtraction)
						if everyNumDeaths == 0 then -- if that leftover number equals 0, then the number is a multiple of Num
							say('/p [DEATH] '..data.target_name..' is up to '..addCommas(deaths)..' deaths!')
						end
					end
				end

			-- The killer was a player
			else

				------------
				-- MURDER -- Actor: does the killing, Target: is what was killed
				------------

				-- Check if the actor and target what we want to track data for 
				if actor == false or target == false then
					return
				end

				local data = {}
				data.actor = actor.id
				data.actor_name = actor.name or 'unknown'
				data.actor_lower_name = string.lower(actor.name) or 'unknown'
				data.target = target.id
				data.target_name = target.name or 'unknown'
				data.target_lower_name = string.lower(target.name) or 'unknown'

				-- Check if the actor and target what we want to track data for 
				if settings.optout[data.actor_lower_name] or settings.optout[data.target_lower_name] then
					return
				end

				local murderPlaces = live.places.murder
				local murderIndividuals = live.individuals.murder

				-- Retrieve the actors relevant data
				local murders = (murderIndividuals[data.actor_lower_name] and murderIndividuals[data.actor_lower_name].score) or 0
				local index = live.indexes.murder

				-- Update the actors score information
				murders = murders +1
				index = index +1 -- Increment the index number for every updated score, ensuring no duplicates
				live.indexes.murder = index
				murderIndividuals[data.actor_lower_name] = {score = murders, nines = 0, index = index}

				-- Update the leaderboard places
				local board = sortNamesHigh(live.individuals.murder)
				murderPlaces.first	= board[1]
				murderPlaces.second	= (board and board[2]) or nil
				murderPlaces.third	= (board and board[3]) or nil
				murderPlaces.fourth	= (board and board[4]) or nil
				murderPlaces.fifth	= (board and board[5]) or nil
				murderPlaces.sixth	= (board and board[6]) or nil
				murderPlaces.seventh= (board and board[7]) or nil
				murderPlaces.eighth	= (board and board[8]) or nil
				murderPlaces.ninth	= (board and board[9]) or nil
				murderPlaces.tenth	= (board and board[10]) or nil
				live:save('all')
				updateBox(box_display)

				-- Call out Murders
				if Mode ~= "Silent" and settings.partymode_calls.murder then
					if murders == 1 then
						say('/p [MURDER] '..data.actor_name..(' has %s'):format(data.actor_lower_name == murderPlaces.first.name and 'drawn First Blood and' or '')..' murdered '..data.target_name..'!')
					end
				end

			end
		end
	end
end)


windower.register_event('action',function(act)

	-- if windower.ffxi.get_mob_by_id(act.actor_id).name == "Bozzetto Trainer" then
	-- 	say('/echo Actor: '..windower.ffxi.get_mob_by_id(act.actor_id).name..' Target: '..windower.ffxi.get_mob_by_id(act.targets[1].id).name..' param: '..act.param..' targets.actions.param: '..act.targets[1].actions[1].param..' Category: '..act.category..' Message #: '..act.targets[1].actions[1].message)
	-- end

	-- A certain type of Spell, Ability, or Item is used that cures
	if (act.category == 4 or act.category == 5 or act.category == 6 or act.category == 11 or act.category == 14) or (act.category == 13 and act.targets[1].actions[1].message == 318) and not live.paused then

		----------
		-- CURE --
		----------

		local actor = get_actor(act.actor_id)

		-- Make sure the actor is part of the party/alliance
		if actor == false then
			return
		end

		-- Determine the actors relevant data
		local data = {}
		data.actor = actor.id
		data.actor_name = actor.name or 'unknown'
		data.actor_lower_name = string.lower(actor.name) or 'unknown'
		if act.category == 4 then 
			data.cureThing = (spells[act.param] and spells[act.param].english) or 'unknown'
		elseif act.category == 5 then
			data.cureThing = (mabils[act.param] and mabils[act.param].english) or 'unknown'
		elseif act.category == 6 or act.category == 13 or act.category == 14 then
			data.cureThing = (jabils[act.param] and jabils[act.param].english) or 'unknown'
		elseif act.category == 11 then
			data.cureThing = (mabils[act.param] and mabils[act.param].english) or 'unknown'
		end

		-- Make sure the actor is not on the Optout list
		if settings.optout[data.actor_lower_name] then
			return
		end

		-- Check if the thing used is one we want to track data for
		if cureThings:contains(data.cureThing) then

			local curePlaces = live.places.cure
			local cureIndividuals = live.individuals.cure

			-- Retrieve the actors relevant data
			local cures = (cureIndividuals[data.actor_lower_name] and cureIndividuals[data.actor_lower_name].score) or 0
			local index = (cureIndividuals[data.actor_lower_name] and cureIndividuals[data.actor_lower_name].index) or 0
			
			-- Update the actors score information
			local cureSum = 0
			for i = 1, act.target_count do
				cureSum = cureSum + act.targets[i].actions[1].param
			end
			cures = cures + cureSum
			local everyNumCures = math.floor(cures / 50000) -- returns how many times 50,000 goes into cures
			local points = everyNumCures * 50000 -- returns the multiple of 50,000 that cures is over
			cureIndividuals[data.actor_lower_name] = {score = cures, nines = 0, index = everyNumCures}

			-- Update the leaderboard places
			local board = sortNamesHigh(live.individuals.cure)
			curePlaces.first	= board[1]
			curePlaces.second	= (board and board[2]) or nil
			curePlaces.third	= (board and board[3]) or nil
			curePlaces.fourth	= (board and board[4]) or nil
			curePlaces.fifth	= (board and board[5]) or nil
			curePlaces.sixth	= (board and board[6]) or nil
			curePlaces.seventh	= (board and board[7]) or nil
			curePlaces.eighth	= (board and board[8]) or nil
			curePlaces.ninth	= (board and board[9]) or nil
			curePlaces.tenth	= (board and board[10]) or nil
			live:save('all')
			updateBox(box_display)

			-- Call out Cures, only if they've reached the next 50,000 threshhold
			if Mode ~= "Silent" and settings.partymode_calls.cure then
				if everyNumCures > index then
					say('/p [CURE] '..data.actor_name..' has cured for over '..addCommas(points)..' HP!')
				end
			end

		end

	-- Weapon Skill is used
	elseif act.category == 3 or (act.category == 13 and BPWS:contains(jabils[act.param].english)) and not live.paused then

		local actor = get_actor(act.actor_id)
		local myName = windower.ffxi.get_mob_by_target('me').name

		-- Make sure the actor is part of the party/alliance
		if actor == false then
			return
		end

		-- Determine the actors relevant data
		local data = {}
		data.actor = actor.id
		data.actor_name = actor.name or 'unknown'
		data.actor_lower_name = string.lower(actor.name) or 'unknown'
		data.target = act.targets[1].id
		data.target_name = windower.ffxi.get_mob_by_id(data.target).name or 'unknown'
		data.damage = act.targets[1].actions[1].param
		data.ws = weaponskills[act.param] and weaponskills[act.param].english or 'unknown'
		data.spell = spells[act.param] and spells[act.param].english or 'unknown'
		data.jabils = jabils[act.param] and jabils[act.param].english or 'unknown'

		-- Make sure the actor is not on the Optout list
		if settings.optout[data.actor_lower_name] then
			return
		end

		-- Exclude utility Weapon Skills
		if data.ws == 'Atonement' or data.ws == 'Flat Blade' or data.ws == 'Tachi: Hobaku' or data.ws == 'Shoulder Tackle' or data.ws == 'Leg Sweep' or data.ws == 'Myrkr' or data.ws == 'Starlight' or data.ws == 'Moonlight' or data.ws == 'Energy Drain' and (act.targets[1].actions[1].message == 185 or act.targets[1].actions[1].message == 188) then
			return
		end

		-- Weapon Skill misses, gets blinked, or hits for 0
		if act.targets[1].actions[1].message == 188 or act.targets[1].actions[1].message == 31 or (act.category == 13 and act.targets[1].actions[1].message == 324) or (act.targets[1].actions[1].message == 185 and data.damage == 0) then 

			-----------
			-- WHIFF --
			-----------

			local whiffPlaces = live.places.whiff
			local whiffIndividuals = live.individuals.whiff

			-- Retrieve the actors relevant data
			local whiffs = (whiffIndividuals[data.actor_lower_name] and whiffIndividuals[data.actor_lower_name].score) or 0
			local index = live.indexes.whiff

			-- Update the actors score information
			whiffs = whiffs +1
			index = index +1 -- Increment the index number for every updated score, ensuring no duplicates
			live.indexes.whiff = index
			whiffIndividuals[data.actor_lower_name] = {score = whiffs, nines = 0, index = index}

			-- Update the leaderboard places
			local board = sortNamesHigh(live.individuals.whiff)
			whiffPlaces.first	= board[1]
			whiffPlaces.second	= (board and board[2]) or nil
			whiffPlaces.third	= (board and board[3]) or nil
			whiffPlaces.fourth	= (board and board[4]) or nil
			whiffPlaces.fifth	= (board and board[5]) or nil
			whiffPlaces.sixth	= (board and board[6]) or nil
			whiffPlaces.seventh	= (board and board[7]) or nil
			whiffPlaces.eighth	= (board and board[8]) or nil
			whiffPlaces.ninth	= (board and board[9]) or nil
			whiffPlaces.tenth	= (board and board[10]) or nil
			live:save('all')
			updateBox(box_display)

			-- Call out Whiffs, depending on the mode and how many Whiffs they are at
			if Mode ~= "Silent" and settings.partymode_calls.whiff then
				if whiffs == 1 then
					if Mode == "Party" then
						say:schedule(1,'/p [WHIFF] '..data.actor_name..' whiffs '..data.ws..('%s'):format(data.actor_lower_name == whiffPlaces.first.name and ' and is the first on the board.' or '.'))
					end
				elseif whiffs == 5 or whiffs == 10 then
					say:schedule(1,'/p [WHIFF] '..data.actor_name..' whiffs '..data.ws..' and is up to '..whiffs..' whiffs now.')
				elseif whiffs < 10 then
					if Mode == "Party" then
						say:schedule(1,'/p [WHIFF] '..data.actor_name..(' whiffs %s'):format(whiffs < 5 and '' or 'yet ')..'again with '..data.ws..'...')
					end
				elseif whiffs > 10 then
					local everyFiveWhiffs = whiffs % 5 -- returns the remainder after euclidean division (division by subtraction)
					if everyFiveWhiffs == 0 then -- if that leftover number equals 0, then the number is a multiple of 5
						say:schedule(1,'/p [WHIFF] '..data.actor_name..' is up to '..whiffs..' whiffs now.')
					end
				end
			end

		-- Weapon Skill lands
		elseif act.targets[1].actions[1].message == 185 or (act.category == 13 and act.targets[1].actions[1].message == 317 or act.targets[1].actions[1].message == 802) then

			-------------
			-- HIGH WS --
			-------------

			local hsPlaces = live.places.hs
			local hsIndividuals = live.individuals.hs

			-- What place was the actor in originally
			local originalHSPlace = 6 -- not on the board
			if hsPlaces.first and data.actor_lower_name == hsPlaces.first.name then
				originalHSPlace = 1
			elseif hsPlaces.second and data.actor_lower_name == hsPlaces.second.name then
				originalHSPlace = 2
			elseif hsPlaces.third and data.actor_lower_name == hsPlaces.third.name then
				originalHSPlace = 3
			elseif hsPlaces.fourth and data.actor_lower_name == hsPlaces.fourth.name then
				originalHSPlace = 4
			elseif hsPlaces.fifth and data.actor_lower_name == hsPlaces.fifth.name then
				originalHSPlace = 5
			end

			-- What was the original first place score
			local originalHSfirstscore = (hsPlaces and hsPlaces.first and hsPlaces.first.score) or 0

			-- What are you and your Rivals original scores
			local myOriginalHSNines = (hsIndividuals and hsIndividuals[string.lower(myName)] and hsIndividuals[string.lower(myName)].nines) or 0
			local myOriginalHSScore = (hsIndividuals and hsIndividuals[string.lower(myName)] and hsIndividuals[string.lower(myName)].score) or 0
			local rivalOriginalHSNines = (hsIndividuals and hsIndividuals[settings.rival] and hsIndividuals[settings.rival].nines) or 0
			local rivalOriginalHSScore = (hsIndividuals and hsIndividuals[settings.rival] and hsIndividuals[settings.rival].score) or 0

			-- Retrieve the actors relevant data
			local nines = (hsIndividuals[data.actor_lower_name] and hsIndividuals[data.actor_lower_name].nines) or 0
			local index = live.indexes.hs

			-- Count the number of 99999 WSs
			if data.damage == 99999 then
				nines = nines + 1
			end

			-- Update the actors score information
			if (hsIndividuals[data.actor_lower_name] == nil) or (data.damage >= hsIndividuals[data.actor_lower_name].score) then
				index = index +1 -- Increment the index number for every updated score, ensuring no duplicates
				live.indexes.hs = index
				hsIndividuals[data.actor_lower_name] = {score = data.damage, nines = nines, index = index}
			end

			-- Update the leaderboard places
			local board = sortNamesHigh(live.individuals.hs)
			hsPlaces.first	= board[1]
			hsPlaces.second	= (board and board[2]) or nil
			hsPlaces.third	= (board and board[3]) or nil
			hsPlaces.fourth	= (board and board[4]) or nil
			hsPlaces.fifth	= (board and board[5]) or nil
			hsPlaces.sixth	= (board and board[6]) or nil
			hsPlaces.seventh= (board and board[7]) or nil
			hsPlaces.eighth	= (board and board[8]) or nil
			hsPlaces.ninth	= (board and board[9]) or nil
			hsPlaces.tenth	= (board and board[10]) or nil
			live:save('all')
			updateBox(box_display)

			-- What place is the actor in now
			local newHSPlace = 6 -- Not on the board
			if data.actor_lower_name == hsPlaces.first.name then
				newHSPlace = 1
			elseif data.actor_lower_name == hsPlaces.second.name then
				newHSPlace = 2
			elseif data.actor_lower_name == hsPlaces.third.name then
				newHSPlace = 3
			elseif data.actor_lower_name == hsPlaces.fourth.name then
				newHSPlace = 4
			elseif data.actor_lower_name == hsPlaces.fifth.name then
				newHSPlace = 5
			end

			-- Code for HIGH WS callouts is down inside LOW WS so that we can Do Logic to prevent it from calling both LOW WS and HIGH WS for the same WS

			-- Did you or your rival beat the other
			if settings.rival ~= "" then
				if data.actor_name == myName then
					if ((rivalOriginalHSNines == myOriginalHSNines) and (nines > rivalOriginalHSNines)) or ((rivalOriginalHSScore > myOriginalHSScore) and (data.damage > rivalOriginalHSScore)) then
						windower.add_to_chat(220,'[Leaderboard] '..('You\'re now beating '..capitalize(settings.rival)..'\'s '..addCommas(rivalOriginalHSScore)..(rivalOriginalHSNines > 0 and ':'..rivalOriginalHSNines or '')..' HIGH WS score with '):color(6)..(addCommas(data.damage)..(nines > 0 and ':'..nines or '')..'.'):color(158))
					end
				elseif data.actor_name == capitalize(settings.rival) then
					if ((rivalOriginalHSNines == myOriginalHSNines) and (nines > myOriginalHSNines)) or ((myOriginalHSScore > rivalOriginalHSScore) and data.damage > myOriginalHSScore) then
						windower.add_to_chat(220,'[Leaderboard] '..(capitalize(settings.rival)..' is now beating your '..addCommas(myOriginalHSScore)..(myOriginalHSNines > 0 and ':'..myOriginalHSNines or '')..' HIGH WS score with '):color(28)..(addCommas(data.damage)..(nines > 0 and ':'..nines or '')..'.'):color(167))
					end
				end
			end

			------------
			-- LOW WS --
			------------

			local lsPlaces = live.places.ls
			local lsIndividuals = live.individuals.ls

			-- What place was the actor in originally
			local originalLSPlace = 6 -- not on the board
			if lsPlaces.first and data.actor_lower_name == lsPlaces.first.name then
				originalLSPlace = 1
			elseif lsPlaces.second and data.actor_lower_name == lsPlaces.second.name then
				originalLSPlace = 2
			elseif lsPlaces.third and data.actor_lower_name == lsPlaces.third.name then
				originalLSPlace = 3
			elseif lsPlaces.fourth and data.actor_lower_name == lsPlaces.fourth.name then
				originalLSPlace = 4
			elseif lsPlaces.fifth and data.actor_lower_name == lsPlaces.fifth.name then
				originalLSPlace = 5
			end

			-- What was the original first place score
			local originalLSfirstscore = (lsPlaces and lsPlaces.first and lsPlaces.first.score) or 0

			-- What are you and your Rivals original scores
			local myOriginalLSScore = (lsIndividuals and lsIndividuals[string.lower(myName)] and lsIndividuals[string.lower(myName)].score) or 0
			local rivalOriginalLSScore = (lsIndividuals and lsIndividuals[settings.rival] and lsIndividuals[settings.rival].score) or 0

			-- Retrieve the actors relevant data
			local index = live.indexes.ls

			-- Update the actors score
			if (live.individuals.ls[data.actor_lower_name] == nil) or (data.damage < live.individuals.ls[data.actor_lower_name].score) then
				index = index +1 -- Increment the index number for every updated score, ensuring no duplicates
				live.indexes.ls = index
				lsIndividuals[data.actor_lower_name] = {score = data.damage, nines = 0, index = index}
			end

			-- Update the leaderboard places
			local board = sortNamesLow(live.individuals.ls)
			lsPlaces.first	= board[1]
			lsPlaces.second	= (board and board[2]) or nil
			lsPlaces.third	= (board and board[3]) or nil
			lsPlaces.fourth	= (board and board[4]) or nil
			lsPlaces.fifth	= (board and board[5]) or nil
			lsPlaces.sixth	= (board and board[6]) or nil
			lsPlaces.seventh= (board and board[7]) or nil
			lsPlaces.eighth	= (board and board[8]) or nil
			lsPlaces.ninth	= (board and board[9]) or nil
			lsPlaces.tenth	= (board and board[10]) or nil
			live:save('all')
			updateBox(box_display)

			-- What place is the actor in now
			local newLSPlace = 6 -- not on the board
			if data.actor_lower_name == lsPlaces.first.name then
				newLSPlace = 1
			elseif data.actor_lower_name == lsPlaces.second.name then
				newLSPlace = 2
			elseif data.actor_lower_name == lsPlaces.third.name then
				newLSPlace = 3
			elseif data.actor_lower_name == lsPlaces.fourth.name then
				newLSPlace = 4
			elseif data.actor_lower_name == lsPlaces.fifth.name then
				newLSPlace = 5
			end

			if Mode ~= "Silent" then

				-- Did the actor move up the HIGH WS leaderboard
				if newHSPlace == originalHSPlace and newHSPlace == 1 and (data.damage > originalHSfirstscore or data.damage == 99999) and settings.partymode_calls.hs then
					say('/p [HIGH WS] '..uppercase(data.actor_name)..' extends the lead! '..data.ws..' for '..addCommas(data.damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..data.target_name..'!')
				elseif newHSPlace < originalHSPlace and settings.partymode_calls.hs then
					if newHSPlace == 1 then
						if data.damage > originalHSfirstscore then
							say('/p [HIGH WS] '..uppercase(data.actor_name)..' takes the board! '..data.ws..' for '..addCommas(data.damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..data.target_name..'!')
						end
					elseif newHSPlace ~= originalHSPlace and newHSPlace ~= 6 and Mode == "Party" then
						say('/p [HIGH WS] '..data.actor_name..' moves up to No.'..newHSPlace..'! '..data.ws..' for '..addCommas(data.damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..data.target_name..'!')
					end

				-- Did the actor move up the LOW WS leaderboard
				elseif newLSPlace == originalLSPlace and newLSPlace == 1 and data.damage < originalLSfirstscore and settings.partymode_calls.ls then
					say('/p [LOW WS] '..uppercase(data.actor_name)..' extends the lead! '..data.ws..' for '..addCommas(data.damage)..' on the '..data.target_name..'!')
				elseif newLSPlace < originalLSPlace and settings.partymode_calls.ls then
					if newLSPlace == 1 then
						if data.damage < originalLSfirstscore then
							say('/p [LOW WS] '..uppercase(data.actor_name)..' takes the board! '..data.ws..' for '..addCommas(data.damage)..' on the '..data.target_name..'!')
						end
					elseif newLSPlace ~= originalLSPlace and newLSPlace ~= 6 and Mode == "Party" then
						say('/p [LOW WS] '..data.actor_name..' moves up to No.'..newLSPlace..'! '..data.ws..' for '..addCommas(data.damage)..' on the '..data.target_name..'!')
					end
				end

			end

			-- Did you or your rival beat the other
			if settings.rival ~= "" then
				if data.actor_name == myName then
					if (rivalOriginalLSScore < myOriginalLSScore) and	(data.damage < rivalOriginalLSScore) then
						windower.add_to_chat(220,'[Leaderboard] '..('You\'re now beating '..capitalize(settings.rival)..'\'s '..addCommas(lsIndividuals[settings.rival].score)..' LOW WS score with a '):color(6)..(addCommas(data.damage)..' '..data.ws..'.'):color(158))
					end
				elseif data.actor_name == capitalize(settings.rival) then
					if (myOriginalLSScore < rivalOriginalLSScore) and data.damage < myOriginalLSScore then
						windower.add_to_chat(220,'[Leaderboard] '..(capitalize(settings.rival)..' is now beating your '..addCommas(lsIndividuals[string.lower(myName)].score)..' LOW WS score with a '):color(28)..(addCommas(data.damage)..' '..data.ws..'.'):color(167))
					end
				end
			end

		end
	end

	-- Skillchain is created
	if ((act.category == 4 and act.targets[1].actions[1].message == 2) or (act.category == 3 and act.targets[1].actions[1].message == 185) or (act.category == 13 and BPWS:contains(jabils[act.param].english))) and act.targets[1].actions[1].has_add_effect and not live.paused then

		----------------
		-- SKILLCHAIN --
		----------------

		local actor = get_actor(act.actor_id)
		local myName = windower.ffxi.get_mob_by_target('me').name

		-- Make sure the actor is part of the party/alliance
		if actor == false then
			return
		end

		local sc = {} sc[1] = 'Light' sc[2] = 'Darkness' sc[3] = 'Gravitation' sc[4] = 'Fragmentation' sc[5] = 'Distortion' sc[6] = 'Fusion' sc[7] = 'Compression' sc[8] = 'Liquefaction' sc[9] = 'Induration' sc[10] = 'Reverberation' sc[11] = 'Transfixion' sc[12] = 'Scission' sc[13] = 'Detonation' sc[14] = 'Impaction' sc[15] = 'Radiance' sc[16] = 'Umbra'

		-- Determine the actors relevant data
		local data = {}
		data.actor = actor.id
		data.actor_name = actor.name or 'unknown'
		data.actor_lower_name = string.lower(actor.name) or 'unknown'
		data.target = act.targets[1].id
		data.target_name = windower.ffxi.get_mob_by_id(data.target).name or 'unknown'
		data.damage = act.targets[1].actions[1].add_effect_param
		data.sc = sc[act.targets[1].actions[1].add_effect_animation] or 'unknown'

		-- Make sure the actor is not on the Optout list
		if settings.optout[data.actor_lower_name] then
			return
		end

		local scPlaces = live.places.sc
		local scIndividuals = live.individuals.sc

		-- What place was the actor in originally
		local originalSCPlace = 6 -- not on the board
		if scPlaces.first and data.actor_lower_name == scPlaces.first.name then
			originalSCPlace = 1
		elseif scPlaces.second and data.actor_lower_name == scPlaces.second.name then
			originalSCPlace = 2
		elseif scPlaces.third and data.actor_lower_name == scPlaces.third.name then
			originalSCPlace = 3
		elseif scPlaces.fourth and data.actor_lower_name == scPlaces.fourth.name then
			originalSCPlace = 4
		elseif scPlaces.fifth and data.actor_lower_name == scPlaces.fifth.name then
			originalSCPlace = 5
		end

		-- What was the original first place score
		local originalSCfirstscore = (scPlaces and scPlaces.first and scPlaces.first.score) or 0

		-- What are you and your Rivals original scores
		local myOriginalSCScore = (scIndividuals and scIndividuals[string.lower(myName)] and scIndividuals[string.lower(myName)].score) or 0
		local rivalOriginalSCScore = (scIndividuals and scIndividuals[settings.rival] and scIndividuals[settings.rival].score) or 0
		local rivalOriginalSCNines = (scIndividuals and scIndividuals[settings.rival] and scIndividuals[settings.rival].nines) or 0
		local rivalOriginalSCScore = (scIndividuals and scIndividuals[settings.rival] and scIndividuals[settings.rival].score) or 0

		-- Retrieve the actors relevant data
		local nines = (scIndividuals[data.actor_lower_name] and scIndividuals[data.actor_lower_name].nines) or 0
		local index = live.indexes.sc

		-- Count the number of 99999 WSs
		if data.damage == 99999 then
			nines = nines + 1
		end

		-- Update the actors score information
		if (scIndividuals[data.actor_lower_name] == nil) or (data.damage >= scIndividuals[data.actor_lower_name].score) then
			index = index +1 -- Increment the index number for every updated score, ensuring no duplicates
			live.indexes.sc = index
			scIndividuals[data.actor_lower_name] = {score = data.damage, nines = nines, index = index}
		end

		-- Update the leaderboard places
		local board = sortNamesHigh(live.individuals.sc)
		scPlaces.first	= board[1]
		scPlaces.second	= (board and board[2]) or nil
		scPlaces.third	= (board and board[3]) or nil
		scPlaces.fourth	= (board and board[4]) or nil
		scPlaces.fifth	= (board and board[5]) or nil
		scPlaces.sixth	= (board and board[6]) or nil
		scPlaces.seventh= (board and board[7]) or nil
		scPlaces.eighth	= (board and board[8]) or nil
		scPlaces.ninth	= (board and board[9]) or nil
		scPlaces.tenth	= (board and board[10]) or nil
		live:save('all')
		updateBox(box_display)

		-- What place is the actor in now
		local newSCPlace = 6 -- Not on the board
		if data.actor_lower_name == scPlaces.first.name then
			newSCPlace = 1
		elseif data.actor_lower_name == scPlaces.second.name then
			newSCPlace = 2
		elseif data.actor_lower_name == scPlaces.third.name then
			newSCPlace = 3
		elseif data.actor_lower_name == scPlaces.fourth.name then
			newSCPlace = 4
		elseif data.actor_lower_name == scPlaces.fifth.name then
			newSCPlace = 5
		end

		-- Did the actor move up the leaderboard
		if Mode ~= "Silent" and settings.partymode_calls.sc then
			if newSCPlace == originalSCPlace and newSCPlace == 1 and (data.damage > originalSCfirstscore or data.damage == 99999) then
				coroutine.sleep(1.5)
				say('/p [SKILLCHAIN] '..uppercase(data.actor_name)..' extends the lead! '..data.sc..' for '..addCommas(data.damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..data.target_name..'!')
			elseif newSCPlace < originalSCPlace then
				if newSCPlace == 1 then
					if data.damage > originalSCfirstscore then
						coroutine.sleep(1.5)
						say('/p [SKILLCHAIN] '..uppercase(data.actor_name)..' takes the board! '..data.sc..' for '..addCommas(data.damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..data.target_name..'!')
					end
				elseif newSCPlace ~= originalSCPlace and newSCPlace ~= 6 and Mode == "Party" then
					coroutine.sleep(1.5)
					say('/p [SKILLCHAIN] '..data.actor_name..' moves up to No.'..newSCPlace..'! '..data.sc..' for '..addCommas(data.damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..data.target_name..'!')
				end
			end
		end

		-- Did you or your rival beat the other
		if settings.rival ~= "" then
			if data.actor_name == myName then
				if ((rivalOriginalSCNines == myOriginalSCNines) and (nines > rivalOriginalSCNines)) or ((rivalOriginalSCScore > myOriginalSCScore) and (data.damage > rivalOriginalSCScore)) then
					windower.add_to_chat(220,'[Leaderboard] '..('You\'re now beating '..capitalize(settings.rival)..'\'s '..addCommas(rivalOriginalSCScore)..(rivalOriginalSCNines > 0 and ':'..rivalOriginalSCNines or '')..' SKILLCHAIN score with '):color(6)..(addCommas(data.damage)..(nines > 0 and ':'..nines or '')..'.'):color(158))
				end
			elseif data.actor_name == capitalize(settings.rival) then
				if ((rivalOriginalSCNines == myOriginalSCNines) and (nines > myOriginalSCNines)) or ((myOriginalSCScore > rivalOriginalSCScore) and data.damage > myOriginalSCScore) then
					windower.add_to_chat(220,'[Leaderboard] '..(capitalize(settings.rival)..' is now beating your '..addCommas(myOriginalSCScore)..(myOriginalSCNines > 0 and ':'..myOriginalSCNines or '')..' SKILLCHAIN score with '):color(28)..(addCommas(data.damage)..(nines > 0 and ':'..nines or '')..'.'):color(167))
				end
			end
		end

	end

	-- Magic Burst lands
	if ((act.category == 4 and act.targets[1].actions[1].message == 252) or (act.category == 15 and act.targets[1].actions[1].message == 110) or (act.category == 13 and act.targets[1].actions[1].message == 379)) and not live.paused then

		-----------------
		-- MAGIC BURST --
		-----------------

		local actor = get_actor(act.actor_id)
		local myName = windower.ffxi.get_mob_by_target('me').name

		-- Make sure the actor is part of the party/alliance
		if actor == false then
			return
		end

		-- Determine the actors relevant data
		local data = {}
		data.actor = actor.id
		data.actor_name = actor.name or 'unknown'
		data.actor_lower_name = string.lower(actor.name) or 'unknown'
		data.target = act.targets[1].id
		data.target_name = windower.ffxi.get_mob_by_id(data.target).name or 'unknown'
		data.damage = act.targets[1].actions[1].param
		if act.category == 4 then
			data.spell = spells[act.param] and spells[act.param].english or 'unknown'
		else
			data.spell = jabils[act.param] and jabils[act.param].english or 'unknown'
		end

		-- Make sure the actor is not on the Optout list
		if settings.optout[data.actor_lower_name] then
			return
		end

		local mbPlaces = live.places.mb
		local mbIndividuals = live.individuals.mb

		-- What place was the actor in originally
		local originalMBPlace = 6 -- not on the board
		if mbPlaces.first and data.actor_lower_name == mbPlaces.first.name then
			originalMBPlace = 1
		elseif mbPlaces.second and data.actor_lower_name == mbPlaces.second.name then
			originalMBPlace = 2
		elseif mbPlaces.third and data.actor_lower_name == mbPlaces.third.name then
			originalMBPlace = 3
		elseif mbPlaces.fourth and data.actor_lower_name == mbPlaces.fourth.name then
			originalMBPlace = 4
		elseif mbPlaces.fifth and data.actor_lower_name == mbPlaces.fifth.name then
			originalMBPlace = 5
		end

		-- What was the original first place score
		local originalMBfirstscore = (mbPlaces and mbPlaces.first and mbPlaces.first.score) or 0

		-- What are you and your Rivals original scores
		local myOriginalMBScore = (mbIndividuals and mbIndividuals[string.lower(myName)] and mbIndividuals[string.lower(myName)].score) or 0
		local rivalOriginalMBScore = (mbIndividuals and mbIndividuals[settings.rival] and mbIndividuals[settings.rival].score) or 0
		local rivalOriginalMBNines = (mbIndividuals and mbIndividuals[settings.rival] and mbIndividuals[settings.rival].nines) or 0
		local rivalOriginalMBScore = (mbIndividuals and mbIndividuals[settings.rival] and mbIndividuals[settings.rival].score) or 0

		-- Retrieve the actors relevant data
		local nines = (mbIndividuals[data.actor_lower_name] and mbIndividuals[data.actor_lower_name].nines) or 0
		local index = live.indexes.mb

		-- Count the number of 99999 WSs
		if data.damage == 99999 then
			nines = nines + 1
		end

		-- Update the actors score information
		if (mbIndividuals[data.actor_lower_name] == nil) or (data.damage >= mbIndividuals[data.actor_lower_name].score) then
			index = index +1 -- Increment the index number for every updated score, ensuring no duplicates
			live.indexes.mb = index
			mbIndividuals[data.actor_lower_name] = {score = data.damage, nines = nines, index = index}
		end

		-- Update the leaderboard places
		local board = sortNamesHigh(live.individuals.mb)
		mbPlaces.first	= board[1]
		mbPlaces.second	= (board and board[2]) or nil
		mbPlaces.third	= (board and board[3]) or nil
		mbPlaces.fourth	= (board and board[4]) or nil
		mbPlaces.fifth	= (board and board[5]) or nil
		mbPlaces.sixth	= (board and board[6]) or nil
		mbPlaces.seventh= (board and board[7]) or nil
		mbPlaces.eighth	= (board and board[8]) or nil
		mbPlaces.ninth	= (board and board[9]) or nil
		mbPlaces.tenth	= (board and board[10]) or nil
		live:save('all')
		updateBox(box_display)

		-- What place is the actor in now
		local newMBPlace = 6 -- Not on the board
		if data.actor_lower_name == mbPlaces.first.name then
			newMBPlace = 1
		elseif data.actor_lower_name == mbPlaces.second.name then
			newMBPlace = 2
		elseif data.actor_lower_name == mbPlaces.third.name then
			newMBPlace = 3
		elseif data.actor_lower_name == mbPlaces.fourth.name then
			newMBPlace = 4
		elseif data.actor_lower_name == mbPlaces.fifth.name then
			newMBPlace = 5
		end

		-- Did the actor move up the leaderboard
		if Mode ~= "Silent" and settings.partymode_calls.mb then
			if newMBPlace == originalMBPlace and newMBPlace == 1 and (data.damage > originalMBfirstscore or data.damage == 99999) then
				coroutine.sleep(1)
				say('/p [MAGIC BURST] '..uppercase(data.actor_name)..' extends the lead! '..data.spell..' for '..addCommas(data.damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..data.target_name..'!')
			elseif newMBPlace < originalMBPlace then
				if newMBPlace == 1 then
					if data.damage > originalMBfirstscore then
						coroutine.sleep(1)
						say('/p [MAGIC BURST] '..uppercase(data.actor_name)..' takes the board! '..data.spell..' for '..addCommas(data.damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..data.target_name..'!')
					end
				elseif newMBPlace ~= originalMBPlace and newMBPlace ~= 6 and Mode == "Party" then
					coroutine.sleep(1)
					say('/p [MAGIC BURST] '..data.actor_name..' moves up to No.'..newMBPlace..'! '..data.spell..' for '..addCommas(data.damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..data.target_name..'!')
				end
			end
		end

		-- Did you or your rival beat the other
		if settings.rival ~= "" then
			if data.actor_name == myName then
				if ((rivalOriginalMBNines == myOriginalMBNines) and (nines > rivalOriginalMBNines)) or ((rivalOriginalMBScore > myOriginalMBScore) and (data.damage > rivalOriginalMBScore)) then
					windower.add_to_chat(220,'[Leaderboard] '..('You\'re now beating '..capitalize(settings.rival)..'\'s '..addCommas(rivalOriginalMBScore)..(rivalOriginalMBNines > 0 and ':'..rivalOriginalMBNines or '')..' MAGIC BURST score with '):color(6)..(addCommas(data.damage)..(nines > 0 and ':'..nines or '')..'.'):color(158))
				end
			elseif data.actor_name == capitalize(settings.rival) then
				if ((rivalOriginalMBNines == myOriginalMBNines) and (nines > myOriginalMBNines)) or ((myOriginalMBScore > rivalOriginalMBScore) and data.damage > myOriginalMBScore) then
					windower.add_to_chat(220,'[Leaderboard] '..(capitalize(settings.rival)..' is now beating your '..addCommas(myOriginalMBScore)..(myOriginalMBNines > 0 and ':'..myOriginalMBNines or '')..' MAGIC BURST score with '):color(28)..(addCommas(data.damage)..(nines > 0 and ':'..nines or '')..'.'):color(167))
				end
			end
		end

	end

	--Nuke lands (includes Magic Bursts)
	if ((act.category == 4 and act.targets[1].actions[1].message == 2) or (act.category == 4 and act.targets[1].actions[1].message == 252) or (act.category == 15 and act.targets[1].actions[1].message == 110) or (act.category == 13 and BPNuke:contains(jabils[act.param].english)) or (act.category == 13 and act.targets[1].actions[1].message == 379)) and not live.paused then

		----------
		-- Nuke --
		----------

		local actor = get_actor(act.actor_id)

		-- Make sure the actor is part of the party/alliance
		if actor == false then
			return
		end

		-- Determine the actors relevant data
		local data = {}
		data.actor = actor.id
		data.actor_name = actor.name or 'unknown'
		data.actor_lower_name = string.lower(actor.name) or 'unknown'

		-- Make sure the actor is not on the Optout list
		if settings.optout[data.actor_lower_name] then
			return
		end

		local nukePlaces = live.places.nuke
		local nukeIndividuals = live.individuals.nuke

		-- Retrieve the actors relevant data
		local nukes = (nukeIndividuals[data.actor_lower_name] and nukeIndividuals[data.actor_lower_name].score) or 0
		local index = (nukeIndividuals[data.actor_lower_name] and nukeIndividuals[data.actor_lower_name].index) or 0

		-- Update the actors score information
		local nukeSum = 0
		for i = 1, act.target_count do
			nukeSum = nukeSum + act.targets[i].actions[1].param
		end
		nukes = nukes + nukeSum
		local everyNumNukes = math.floor(nukes / 500000) -- returns how many times 500,000 goes into nukes
		local points = everyNumNukes * 500000 -- returns the multiple of 500,000 that nukes is over
		nukeIndividuals[data.actor_lower_name] = {score = nukes, nines = 0, index = everyNumNukes}

		-- Update the leaderboard places
		local board = sortNamesHigh(live.individuals.nuke)
		nukePlaces.first	= board[1]
		nukePlaces.second	= (board and board[2]) or nil
		nukePlaces.third	= (board and board[3]) or nil
		nukePlaces.fourth	= (board and board[4]) or nil
		nukePlaces.fifth	= (board and board[5]) or nil
		nukePlaces.sixth	= (board and board[6]) or nil
		nukePlaces.seventh	= (board and board[7]) or nil
		nukePlaces.eighth	= (board and board[8]) or nil
		nukePlaces.ninth	= (board and board[9]) or nil
		nukePlaces.tenth	= (board and board[10]) or nil
		live:save('all')
		updateBox(box_display)

		-- Call out Nukes, only if they've reached the next 500,000 point threshhold
		if Mode ~= "Silent" and settings.partymode_calls.nuke then
			if everyNumNukes > index then 
				say('/p [NUKE] '..data.actor_name..' has nuked for over '..addCommas(points)..' damage!')
			end
		end

	end
end)

windower.register_event('addon command',function(addcmd, ...)

    local args = {...}
    local arg = args[1]
    local arg2 = args[2]

	-- Reload LB
	if addcmd == 'reload' then
		cmd('lua r leaderboard')
		return


	-- Reset the data, does not stop LB from running
	elseif addcmd == 'reset' then
		local board = ''
		if arg == 'c' or arg == 'cure' or arg == 'cures' then
			resetC()
			board = 'CURE'
		elseif arg == 'd' or arg == 'death' or arg == 'deaths' then
			resetD()
			board = 'DEATH'
		elseif arg == 'hs' or arg == 'highscore' or arg == 'hiscore' then
			resetHS()
			board = 'HIGH WS'
		elseif arg == 'k' or arg == 'kill' or arg == 'kills' then
			resetK()
			board = 'KILL'
		elseif arg == 'ls' or arg == 'lowscore' or arg == 'loscore' then
			resetLS()
			board = 'LOW WS'
		elseif arg == 'n' or arg == 'nuke' or arg == 'nukes' then
			resetN()
			board = 'NUKE'
		elseif arg == 'mb' or arg == 'magicburst' or arg == 'burst' then
			resetMB()
			board = 'MAGIC BURST'
		elseif arg == 'm' or arg == 'murder' then
			resetM()
			board = 'MURDER'
		elseif arg == 'sc' or arg == 'skillchain' or arg == 'skillchains' then
			resetSC()
			board = 'SKILLCHAIN'
		elseif arg == 'w' or arg == 'whiff' or arg == 'whiffs' then
			resetW()
			board = 'WHIFF'
		elseif arg == 'all' then
			resetALL()
			board = 'ALL'
		else
			windower.add_to_chat(220,'[Leaderboard] '..('Please add which board you would like reset (all/c/d/hs/k/ls/m/mb/n/sc/w).'):color(8))
			return
		end
		if Mode ~= "Silent" then
			say('/p [Leaderboard] '..board..' data reset.')
		else
			windower.add_to_chat(220,'[Leaderboard] '..(board..' data reset.'):color(8))
		end
		live:save('all')
		updateBox(box_display)


	-- Callouts for Party Mode setting
	elseif addcmd == 'call' or addcmd == 'calls' or addcmd == 'callout' or addcmd == 'callouts' then
		if arg == 'c' or arg == 'cure' or arg == 'cures' then
			settings.partymode_calls.cure = not settings.partymode_calls.cure
			windower.add_to_chat(220,'[Leaderboard] '..(('CURE call is now set to %s'):format(settings.partymode_calls.cure and 'on.' or 'off.')):color(8))
		elseif arg == 'd' or arg == 'death' or arg == 'deaths' then
			settings.partymode_calls.death = not settings.partymode_calls.death
			windower.add_to_chat(220,'[Leaderboard] '..(('DEATH call is now set to %s'):format(settings.partymode_calls.death and 'on.' or 'off.')):color(8))
		elseif arg == 'hs' or arg == 'highscore' or arg == 'hiscore' then
			settings.partymode_calls.hs = not settings.partymode_calls.hs
			windower.add_to_chat(220,'[Leaderboard] '..(('HIGH WS call is now set to %s'):format(settings.partymode_calls.hs and 'on.' or 'off.')):color(8))
		elseif arg == 'k' or arg == 'kill' or arg == 'kills' then
			settings.partymode_calls.kill = not settings.partymode_calls.kill
			windower.add_to_chat(220,'[Leaderboard] '..(('KILL call is now set to %s'):format(settings.partymode_calls.kill and 'on.' or 'off.')):color(8))
		elseif arg == 'ls' or arg == 'lowscore'  or arg == 'loscore' then
			settings.partymode_calls.ls = not settings.partymode_calls.ls
			windower.add_to_chat(220,'[Leaderboard] '..(('LOW WS call is now set to %s'):format(settings.partymode_calls.ls and 'on.' or 'off.')):color(8))
		elseif arg == 'mb' or arg == 'magicburst' or arg == 'burst' then
			settings.partymode_calls.mb = not settings.partymode_calls.mb
			windower.add_to_chat(220,'[Leaderboard] '..(('MAGIC BURST call is now set to %s'):format(settings.partymode_calls.mb and 'on.' or 'off.')):color(8))
		elseif arg == 'm' or arg == 'murder' or arg == 'murders' then
			settings.partymode_calls.murder = not settings.partymode_calls.murder
			windower.add_to_chat(220,'[Leaderboard] '..(('MURDER call is now set to %s'):format(settings.partymode_calls.murder and 'on.' or 'off.')):color(8))
		elseif arg == 'n' or arg == 'nuke' or arg == 'nukes' then
			settings.partymode_calls.nuke = not settings.partymode_calls.nuke
			windower.add_to_chat(220,'[Leaderboard] '..(('NUKE call is now set to %s'):format(settings.partymode_calls.nuke and 'on.' or 'off.')):color(8))
		elseif arg == 'sc' or arg == 'skillchain' or arg == 'skillchains' then
			settings.partymode_calls.sc = not settings.partymode_calls.sc
			windower.add_to_chat(220,'[Leaderboard] '..(('SKILLCHAIN call is now set to %s'):format(settings.partymode_calls.sc and 'on.' or 'off.')):color(8))
		elseif arg == 'w' or arg == 'whiff' or arg == 'whiffs' then
			settings.partymode_calls.whiff = not settings.partymode_calls.whiff
			windower.add_to_chat(220,'[Leaderboard] '..(('WHIFF call is now set to %s'):format(settings.partymode_calls.whiff and 'on.' or 'off.')):color(8))
		else
			windower.add_to_chat(220,'[Leaderboard] '..('Party/Lite Mode party call settings'):color(220))
			windower.add_to_chat(36,'CURE (c) '..(('- %s'):format(settings.partymode_calls.cure and 'On' or 'Off')):color(8))
			windower.add_to_chat(36,'DEATH (d) '..(('- %s'):format(settings.partymode_calls.death and 'On' or 'Off')):color(8))
			windower.add_to_chat(36,'HIGH WS (hs) '..(('- %s'):format(settings.partymode_calls.hs and 'On' or 'Off')):color(8))
			windower.add_to_chat(36,'KILL (k) '..(('- %s'):format(settings.partymode_calls.kill and 'On' or 'Off')):color(8))
			windower.add_to_chat(36,'LOW WS (ls) '..(('- %s'):format(settings.partymode_calls.ls and 'On' or 'Off')):color(8))
			windower.add_to_chat(36,'MAGIC BURST (mb) '..(('- %s'):format(settings.partymode_calls.mb and 'On' or 'Off')):color(8))
			windower.add_to_chat(36,'MURDER (m) '..(('- %s'):format(settings.partymode_calls.murder and 'On' or 'Off')):color(8))
			windower.add_to_chat(36,'NUKE (n) '..(('- %s'):format(settings.partymode_calls.nuke and 'On' or 'Off')):color(8))
			windower.add_to_chat(36,'SKILLCHAIN (sc) '..(('- %s'):format(settings.partymode_calls.sc and 'On' or 'Off')):color(8))
			windower.add_to_chat(36,'WHIFF (w) '..(('- %s'):format(settings.partymode_calls.whiff and 'On' or 'Off')):color(8))
		end
		settings:save('all')


	-- Reminder setting
	elseif addcmd == 'reminder' or addcmd == 'reminders' or addcmd == 'remind' then
		settings.reminder = not settings.reminder
		windower.add_to_chat(220,'[Leaderboard] '..(('Reminders are set to %s'):format(settings.reminder and 'on.' or 'off.')):color(8))
		settings:save('all')


	-- Comma setting
	elseif addcmd == 'comma' or addcmd == 'commas' then
		settings.commas = not settings.commas
		windower.add_to_chat(220,'[Leaderboard] '..(('Commas are set to %s'):format(settings.commas and 'on.' or 'off.')):color(8))
		settings:save('all')
		updateBox(box_display)


	-- Party Commands setting
	elseif addcmd == 'party' or addcmd == 'partycommand' or addcmd == 'partycommands' then
		settings.party_commands = not settings.party_commands
		windower.add_to_chat(220,'[Leaderboard] '..(('Party Commands for Party/Lite Mode are set to %s'):format(settings.party_commands and 'on.' or 'off.')):color(8))
		settings:save('all')


	-- Flood Delay setting
	elseif addcmd == 'flood' or addcmd == 'flooddelay' then
		if arg == nil then
			windower.add_to_chat(220,'[Leaderboard] '..('Flood Delay for Party/Lite Mode Party Commands is currently set to '..settings.flood_delay..' seconds.'):color(8))
		elseif tonumber(arg) ~= nil then
			settings.flood_delay = arg
			settings:save('all')
			windower.add_to_chat(220,'[Leaderboard] '..('Flood Delay for Party/Lite Mode Party Commands is now set to '..settings.flood_delay..' seconds.'):color(8))
		else
			windower.add_to_chat(220,'[Leaderboard] '..('Flood Delay must be a number.'):color(8))
		end


	-- Display help
	elseif addcmd == 'help' then
		windower.add_to_chat(220,'[Leaderboard] '..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..('Key'):color(220))
		windower.add_to_chat(220,' ')
		windower.add_to_chat(220,' Basic Commands '..('[optional]'):color(53)..(' <required>'):color(2))
		windower.add_to_chat(36,'   pause/p'..(' - Pause/unpause tracking.'):color(8))
		windower.add_to_chat(36,'   boards'..(' - List the different boards that are tracked.'):color(8))
		windower.add_to_chat(36,'   show/hide'..(' [c/d/hs/k/ls/m/mb/n/sc/w]'):color(53)..(' - Display boards on screen.'):color(8))
		windower.add_to_chat(36,'   reset'..(' <all/c/d/hs/k/ls/m/mb/n/sc/w>'):color(2)..(' - Reset specified data.'):color(8))
		windower.add_to_chat(36,'   rival'..(' <name>'):color(2)..(' - Set the specified player as your Rival. Repeat to remove.'):color(8))
		windower.add_to_chat(36,'   taunt'..(' - Send your rival a tell letting them know which boards you have them beat on.'):color(8))
		windower.add_to_chat(220,' ')
		windower.add_to_chat(220,' Advanced Commands '..('[optional]'):color(53)..(' <required>'):color(2))
		windower.add_to_chat(36,'   mode/silent/lite/party'..(' - Display/change the current Mode.'):color(8))
		windower.add_to_chat(36,'   c/d/hs/k/ls/m/mb/n/sc/w'..(' - Print board to party chat.'):color(8))
		windower.add_to_chat(36,'   call'..(' [ch/c/d/hs/k/ls/m/mb/n/sc/w]'):color(53)..(' - Display/change the Party/Lite mode party call settings.'):color(8))
		windower.add_to_chat(36,'   lock/unlock'..(' - Drag the On-Screen Display.'):color(8))
		windower.add_to_chat(36,'   optout'..(' [add/remove'):color(53)..(' <name>'):color(2)..(']'):color(53)..(' - Display/update the Optout list.'):color(8))
		windower.add_to_chat(36,'   report'..(' <name>'):color(2)..(' - Send the specified player their score report via tell.'):color(8))
		windower.add_to_chat(36,'   reminder'..(' - Change the Reminder setting.'):color(8))
		windower.add_to_chat(36,'   comma'..(' - Change the Comma setting.'):color(8))
		windower.add_to_chat(36,'   party'..(' - Change the Party Command setting.'):color(8))
		windower.add_to_chat(36,'   flood'..(' [#]'):color(53)..(' - Display/change the current Flood Delay for Party/Lite Mode Party Commands.'):color(8))


	-- Pause
	elseif addcmd == 'pause' or addcmd == 'p' then
		if not live.paused then
			live.paused = true
		else
			live.paused = false
		end
		live:save('all')
		if Mode ~= "Silent" then
			say(('/p [Leaderboard] %s'):format(live.paused and 'Paused' or 'Unpaused')..' ('..Mode..' Mode).')
		else
			windower.add_to_chat(220,'[Leaderboard] '..(('%s'):format(live.paused and 'Paused' or 'Unpaused')..' ('..Mode..' Mode).'):color(8))
		end
		updateBox(box_display)


	-- Switch to Party Mode
	elseif addcmd == 'party' or (addcmd == 'mode' and (arg == 'party' or arg == 'p')) then
		Mode = "Party"
		say(('/p [Leaderboard] Mode set to '..Mode..' (%s).'):format(live.paused and 'paused' or 'running'))
		coroutine.sleep(1)
		windower.add_to_chat(220,'[Leaderboard] '..('Beware - Party Mode uses party chat heavily.'):color(8))


	-- Switch to Lite Mode
	elseif addcmd == 'lite' or (addcmd == 'mode' and (arg == 'lite' or arg == 'l')) then
		Mode = "Lite"
		say(('/p [Leaderboard] Mode set to '..Mode..' (%s).'):format(live.paused and 'paused' or 'running'))


	-- Switch to Silent Mode
	elseif addcmd == 'silent' or (addcmd == 'mode' and (arg == 'silent' or arg == 's')) then
		Mode = "Silent"
		say(('/p [Leaderboard] Mode set to '..Mode..' (%s).'):format(live.paused and 'paused' or 'running'))


	-- Display which mode Leaderboard is currently running in
	elseif addcmd == 'mode' then
		windower.add_to_chat(220,'[Leaderboard] '..(('Currently %s'):format(live.paused and 'paused' or 'running')..' in '..Mode..' Mode'):color(8))


	-- Display the commands for the different boards
	elseif addcmd == 'board' or addcmd == 'boards' or addcmd == 'leaderboard' or addcmd == 'leaderboards' then
		windower.add_to_chat(220,'[Leaderboard] '..('Current Tracked Boards'):color(220))
		windower.add_to_chat(36,'   c/cure'..(' - Running total of cures'):color(8))
		windower.add_to_chat(36,'   d/death'..(' - Running total of deaths'):color(8))
		windower.add_to_chat(36,'   hs/highscore'..(' - Highest individual WS damage'):color(8))
		windower.add_to_chat(36,'   k/kill'..(' - Running total of kills'):color(8))
		windower.add_to_chat(36,'   ls/lowscore'..(' - Lowest individual WS damage'):color(8))
		windower.add_to_chat(36,'   mb/magicburst'..(' - Highest individual MB damage'):color(8))
		windower.add_to_chat(36,'   m/murder'..(' - Running total of murders'):color(8))
		windower.add_to_chat(36,'   n/nuke'..(' - Running total of nukes'):color(8))
		windower.add_to_chat(36,'   sc/skillchain'..(' - Highest individual SC damage'):color(8))
		windower.add_to_chat(36,'   w/whiffs'..(' - Running total of whiffs'):color(8))


	-- CURE BOARD
	elseif addcmd == 'c' or addcmd == 'cure' or addcmd == 'cures' then
		if arg == 'reset' then
			resetC()
			updateBox(box_display)
			windower.add_to_chat(220,'[Leaderboard] '..('CURE data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'cure'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'callout' or arg == 'callouts' then
			settings.partymode_calls.cure = not settings.partymode_calls.cure
			windower.add_to_chat(220,'[Leaderboard] '..(('CURE call is now set to %s'):format(settings.partymode_calls.cure and 'on.' or 'off.')):color(8))
			settings:save('all')
		else
			local places = live.places.cure
			local info = getPlacesInfo(places)
			local text = ""
			if places.first == nil then
				text = "/p \r--CURE BOARD--\rNo Cures Yet"
			else
				text = "/p \r--"..uppercase(places.first.name).."\'S CURE BOARD--"
				for i = 1, 5, 1
				do
					if info.name[i] ~= nil then
						text = text.."\r"..i..": "..capitalize(info.name[i]).." ("..addCommas(info.score[i])..")"
					end
				end
			end
			say(text)
		end


	-- DEATH BOARD
	elseif addcmd == 'd' or addcmd == 'death' or addcmd == 'deaths' then
		if arg == 'reset' then
			resetD()
			updateBox(box_display)
			windower.add_to_chat(220,'[Leaderboard] '..('DEATH data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'death'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'callout' or arg == 'callouts' then
			settings.partymode_calls.death = not settings.partymode_calls.death
			windower.add_to_chat(220,'[Leaderboard] '..(('DEATH call is now set to %s'):format(settings.partymode_calls.death and 'on.' or 'off.')):color(8))
			settings:save('all')
		else
			local places = live.places.death
			local info = getPlacesInfo(places)
			local text = ""
			if places.first == nil then
				text = "/p \r--DEATH BOARD--\rNo Deaths Yet"
			else
				text = "/p \r--"..uppercase(places.first.name).."\'S DEATH BOARD--"
				for i = 1, 5, 1
				do
					if info.name[i] ~= nil then
						text = text.."\r"..i..": "..capitalize(info.name[i]).." ("..addCommas(info.score[i])..("%s"):format(info.nines[i] > 0 and ':'..info.nines[i]..')' or ')')
					end
				end
			end
			say(text)
		end


	-- HIGH WS BOARD
	elseif addcmd == 'hs' or addcmd == 'highscore' or addcmd == 'hiscore' then
		if arg == 'reset' then
			resetHS()
			windower.add_to_chat(220,'[Leaderboard] '..('HIGH WS data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'hs'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'callout' or arg == 'callouts' then
			settings.partymode_calls.hs = not settings.partymode_calls.hs
			windower.add_to_chat(220,'[Leaderboard] '..(('HIGH WS call is now set to %s'):format(settings.partymode_calls.hs and 'on.' or 'off.')):color(8))
			settings:save('all')
		else
			local places = live.places.hs
			local info = getPlacesInfo(places)
			local text = ""
			if places.first == nil then
				text = "/p \r--HIGH WS BOARD--\rNo Weapon Skills Yet"
			else
				text = "/p \r--"..uppercase(places.first.name).."\'S HIGH WS BOARD--"
				for i = 1, 5, 1
				do
					if info.name[i] ~= nil then
						text = text.."\r"..i..": "..capitalize(info.name[i]).." ("..addCommas(info.score[i])..("%s"):format(info.nines[i] > 0 and ':'..info.nines[i]..')' or ')')
					end
				end
			end
			say(text)
		end


	-- KILL BOARD
	elseif addcmd == 'k' or addcmd == 'kill' or addcmd == 'kills' then
		if arg == 'reset' then
			resetK()
			updateBox(box_display)
			windower.add_to_chat(220,'[Leaderboard] '..('KILL data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'kill'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'callout' or arg == 'callouts' then
			settings.partymode_calls.kill = not settings.partymode_calls.kill
			windower.add_to_chat(220,'[Leaderboard] '..(('KILL call is now set to %s'):format(settings.partymode_calls.kill and 'on.' or 'off.')):color(8))
			settings:save('all')
		else
			local places = live.places.kill
			local info = getPlacesInfo(places)
			local text = ""
			if places.first == nil then
				text = "/p \r--KILL BOARD--\rNo Kills Yet"
			else
				text = "/p \r--"..uppercase(places.first.name).."\'S KILL BOARD--"
				for i = 1, 5, 1
				do
					if info.name[i] ~= nil then
						text = text.."\r"..i..": "..capitalize(info.name[i]).." ("..addCommas(info.score[i])..("%s"):format(info.nines[i] > 0 and ':'..info.nines[i]..')' or ')')
					end
				end
			end
			say(text)
		end


	-- LOW WS BOARD
	elseif addcmd == 'ls' or addcmd == 'lowscore'  or addcmd == 'loscore' then
		if arg == 'reset' then
			resetLS()
			updateBox(box_display)
			windower.add_to_chat(220,'[Leaderboard] '..('LOW WS data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'ls'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'callout' or arg == 'callouts' then
			settings.partymode_calls.ls = not settings.partymode_calls.ls
			windower.add_to_chat(220,'[Leaderboard] '..(('LOW WS call is now set to %s'):format(settings.partymode_calls.ls and 'on.' or 'off.')):color(8))
			settings:save('all')
		else
			local places = live.places.ls
			local info = getPlacesInfo(places)
			local text = ""
			if places.first == nil then
				text = "/p \r--LOW WS BOARD--\rNo Weapon Skills Yet"
			else
				text = "/p \r--"..uppercase(places.first.name).."\'S LOW WS BOARD--"
				for i = 1, 5, 1
				do
					if info.name[i] ~= nil then
						text = text.."\r"..i..": "..capitalize(info.name[i]).." ("..addCommas(info.score[i])..")"
					end
				end
			end
			say(text)
		end


	-- MAGIC BURST BOARD
	elseif addcmd == 'mb' or addcmd == 'magicburst' or addcmd == 'burst' then
		if arg == 'reset' then
			resetMB()
			updateBox(box_display)
			windower.add_to_chat(220,'[Leaderboard] '..('MAGIC BURST data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'mb'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'callout' or arg == 'callouts' then
			settings.partymode_calls.mb = not settings.partymode_calls.mb
			windower.add_to_chat(220,'[Leaderboard] '..(('MAGIC BURST call is now set to %s'):format(settings.partymode_calls.mb and 'on.' or 'off.')):color(8))
			settings:save('all')
		else
			local places = live.places.mb
			local info = getPlacesInfo(places)
			local text = ""
			if places.first == nil then
				text = "/p \r--MAGIC BURST BOARD--\rNo Magic Bursts Yet"
			else
				text = "/p \r--"..uppercase(places.first.name).."\'S MAGIC BURST BOARD--"
				for i = 1, 5, 1
				do
					if info.name[i] ~= nil then
						text = text.."\r"..i..": "..capitalize(info.name[i]).." ("..addCommas(info.score[i])..("%s"):format(info.nines[i] > 0 and ':'..info.nines[i]..')' or ')')
					end
				end
			end
			say(text)
		end


	-- MURDER BOARD
	elseif addcmd == 'm' or addcmd == 'murder' or addcmd == 'murders' then
		if arg == 'reset' then
			resetM()
			updateBox(box_display)
			windower.add_to_chat(220,'[Leaderboard] '..('MURDER data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'murder'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'callout' or arg == 'callouts' then
			settings.partymode_calls.murder = not settings.partymode_calls.murder
			windower.add_to_chat(220,'[Leaderboard] '..(('MURDER call is now set to %s'):format(settings.partymode_calls.murder and 'on.' or 'off.')):color(8))
			settings:save('all')
		else
			local places = live.places.murder
			local info = getPlacesInfo(places)
			local text = ""
			if places.first == nil then
				text = "/p \r--MURDER BOARD--\rNo Murders Yet"
			else
				text = "/p \r--"..uppercase(places.first.name).."\'S MURDER BOARD--"
				for i = 1, 5, 1
				do
					if info.name[i] ~= nil then
						text = text.."\r"..i..": "..capitalize(info.name[i]).." ("..addCommas(info.score[i])..")"
					end
				end
			end
			say(text)
		end


	-- NUKE BOARD
	elseif addcmd == 'n' or addcmd == 'nuke' or addcmd == 'nukes' then
		if arg == 'reset' then
			resetN()
			updateBox(box_display)
			windower.add_to_chat(220,'[Leaderboard] '..('NUKE data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'nuke'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'callout' or arg == 'callouts' then
			settings.partymode_calls.nuke = not settings.partymode_calls.nuke
			windower.add_to_chat(220,'[Leaderboard] '..(('NUKE call is now set to %s'):format(settings.partymode_calls.nuke and 'on.' or 'off.')):color(8))
			settings:save('all')
		else
			local places = live.places.nuke
			local info = getPlacesInfo(places)
			local text = ""
			if places.first == nil then
				text = "/p \r--NUKE BOARD--\rNo Nukes Yet"
			else
				text = "/p \r--"..uppercase(places.first.name).."\'S NUKE BOARD--"
				for i = 1, 5, 1
				do
					if info.name[i] ~= nil then
						text = text.."\r"..i..": "..capitalize(info.name[i]).." ("..addCommas(info.score[i])..")"
					end
				end
			end
			say(text)
		end


	-- SKILLCHAIN BOARD
	elseif addcmd == 'sc' or addcmd == 'skillchain' then
		if arg == 'reset' then
			resetSC()
			updateBox(box_display)
			windower.add_to_chat(220,'[Leaderboard] '..('SKILLCHAIN data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'sc'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'callout' or arg == 'callouts' then
			settings.partymode_calls.sc = not settings.partymode_calls.sc
			windower.add_to_chat(220,'[Leaderboard] '..(('SKILLCHAIN call is now set to %s'):format(settings.partymode_calls.sc and 'on.' or 'off.')):color(8))
			settings:save('all')
		else
			local places = live.places.sc
			local info = getPlacesInfo(places)
			local text = ""
			if places.first == nil then
				text = "/p \r--SKILLCHAIN BOARD--\rNo Skillchains Yet"
			else
				text = "/p \r--"..uppercase(places.first.name).."\'S SKILLCHAIN BOARD--"
				for i = 1, 5, 1
				do
					if info.name[i] ~= nil then
						text = text.."\r"..i..": "..capitalize(info.name[i]).." ("..addCommas(info.score[i])..("%s"):format(info.nines[i] > 0 and ':'..info.nines[i]..')' or ')')
					end
				end
			end
			say(text)
		end


	-- WHIFF BOARD
	elseif addcmd == 'w' or addcmd == 'whiff' or addcmd == 'whiffs' then
		if arg == 'reset' then
			resetW()
			updateBox(box_display)
			windower.add_to_chat(220,'[Leaderboard] '..('WHIFF data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'whiff'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'callout' or arg == 'callouts' then
			settings.partymode_calls.whiff = not settings.partymode_calls.whiff
			windower.add_to_chat(220,'[Leaderboard] '..(('WHIFF call is now set to %s'):format(settings.partymode_calls.whiff and 'on.' or 'off.')):color(8))
			settings:save('all')
		else
			local places = live.places.whiff
			local info = getPlacesInfo(places)
			local text = ""
			if places.first == nil then
				text = "/p \r--WHIFF BOARD--\rNo Whiffs Yet"
			else
				text = "/p \r--"..uppercase(places.first.name).."\'S WHIFF BOARD--"
				for i = 1, 5, 1
				do
					if info.name[i] ~= nil then
						text = text.."\r"..i..": "..capitalize(info.name[i]).." ("..info.score[i]..")"
					end
				end
			end
			say(text)
		end


	--Add name to optout list
	elseif addcmd == 'optout' or addcmd == 'o' then
		if arg == 'add' or arg == 'a' then
			if arg2 == nil then
				windower.add_to_chat(220,'[Leaderboard] '..('Please add a name to be added to the Optout list.'):color(8))
			else
				local l_name = string.lower(arg2)
				if settings.optout[l_name] then
					windower.add_to_chat(220,'[Leaderboard] '..(capitalize(arg2)..' is already in the Optout list.'):color(8)..'')
				else
					addToOptout(l_name)
					windower.add_to_chat(220,'[Leaderboard] '..(capitalize(arg2)..' has been added to the Optout list. Any related data has been deleted.'):color(8)..'')
				end
			end
		elseif arg == 'remove' or arg == 'r' or arg == 'delete' or arg == 'd' then
			if arg2 == nil then
				windower.add_to_chat(220,'[Leaderboard] '..('Please add a name to be removed from the Optout list.'):color(8))
			else
				local l_name = string.lower(arg2)
				if settings.optout[l_name] then
					removeFromOptout(l_name)
					windower.add_to_chat(220,'[Leaderboard] '..(capitalize(arg2)..' has been removed from the Optout list.'):color(8)..'')
				else
					windower.add_to_chat(220,'[Leaderboard] '..(capitalize(arg2)..' is not in the Optout list.'):color(8)..'')
				end
			end
		else
			local list = optoutList()
			windower.add_to_chat(220,'[Leaderboard] '..('Optout list: '):color(8)..(capitalize(list)):color(1))
		end


	-- Send a specific player their score report via tell
	elseif addcmd == 'report' or addcmd == 'r' then
		if arg == nil then
			windower.add_to_chat(220,'[Leaderboard] '..('Please add a name.'):color(8))
		else
			reportPlayerScores(string.lower(arg))
		end


	-- Show the On-Screen Display
	elseif addcmd == 'show' then
		settings.visible = true
		showBox()
		settings:save('all')
		if arg == 'c' or arg == 'cure' or arg == 'cures' then
			box_display = 'cure'
		elseif arg == 'd' or arg == 'death' or arg == 'deaths' then
			box_display = 'death'
		elseif arg == 'hs' or arg == 'highscore' or arg == 'hiscore' then
			box_display = 'hs'
		elseif arg == 'k' or arg == 'kill' or arg == 'kills' then
			box_display = 'kill'
		elseif arg == 'ls' or arg == 'lowscore'  or arg == 'loscore' then
			box_display = 'ls'
		elseif arg == 'mb' or arg == 'magicburst' or arg == 'burst' then
			box_display = 'mb'
		elseif arg == 'm' or arg == 'murder' or arg == 'murders' then
			box_display = 'murder'
		elseif arg == 'n' or arg == 'nuke' or arg == 'nukes' then
			box_display = 'nuke'
		elseif arg == 'sc' or arg == 'skillchain' or arg == 'skillchains' then
			box_display = 'sc'
		elseif arg == 'w' or arg == 'whiff' or arg == 'whiffs' then
			box_display = 'whiff'
		end
		updateBox(box_display)


	-- Hide the On-Screen Display
	elseif addcmd == 'hide' then
		settings.visible = false
		settings:save('all')
		hideBox()


	-- Lock the On-Screen Display by turning drag off
	elseif addcmd == 'lock' then
		settings.flags.draggable = false
		settings:save('all')
		windower.add_to_chat(220,'[Leaderboard] '..('On-Screen Display is locked. Dragging is disabled.'):color(8))


	--Unlock the On-Screen Display by turning drag on
	elseif addcmd == 'unlock' then
		settings.flags.draggable = true
		settings:save('all')
		windower.add_to_chat(220,'[Leaderboard] '..('On-Screen Display is unlocked. Dragging is enabled.'):color(8))


	-- Set a specific player as your Rival
	elseif addcmd == 'rival' then
		if arg == nil then
			windower.add_to_chat(220,'[Leaderboard] '..('%s'):format(settings.rival ~= '' and capitalize(settings.rival)..' is your Rival.' or 'No Rival set.'):color(8))
		elseif string.lower(arg) == settings.rival then
			settings.rival = ""
			windower.add_to_chat(220,'[Leaderboard] '..(capitalize(arg)..' has been removed as your Rival. No Rival set.'):color(8))
		else
			settings.rival = string.lower(arg)
			windower.add_to_chat(220,'[Leaderboard] '..(capitalize(arg)..' is now your Rival!'):color(8))
		end
		settings:save('all')
		updateBox(box_display)


	-- Taunt your Rival with a tell
	elseif addcmd == 'taunt' then
		-- Update the taunt text
		if next(args) ~= nil then
			local tauntText = table.concat(args, ' ')
			-- Make sure %s is included in the taunt
			if not string.match(tauntText, "%%s") then
				windower.add_to_chat(220,'[Leaderboard] '..('Please use a \"%s\" where the board names will go. Your current taunt text is:'):color(8))
				windower.add_to_chat(220,'[Leaderboard] '..(settings.taunt):color(1))
			else
				settings.taunt = tauntText
				settings:save('all')
				windower.add_to_chat(220,'[Leaderboard] '..('Your taunt text has been updated to:'):color(8))
				windower.add_to_chat(220,'[Leaderboard] '..(settings.taunt):color(1))
			end
			return
		end
		-- Check if the settings file was manually updated without a "%s" in it.
		if not string.match(settings.taunt, "%%s") then
			windower.add_to_chat(220,'[Leaderboard] '..('Please update your taunt text to use a \"%s\" where the board names will go.'):color(8))
			windower.add_to_chat(220,'[Leaderboard] '..('Ex. '):color(8)..('//lb taunt I\'m beating you in %s. Just thought you should know.'):color(1))
			return
		end
		-- No Rival is set
		if settings.rival == '' then
			windower.add_to_chat(220,'[Leaderboard] '..('No Rival set.'):color(8))
			return
		end
		local myName = windower.ffxi.get_mob_by_target('me').name
		local yourHSScore = (live.individuals.hs and live.individuals.hs[string.lower(myName)] and live.individuals.hs[string.lower(myName)].score) or 0
		local yourHSNines = (live.individuals.hs and live.individuals.hs[string.lower(myName)] and live.individuals.hs[string.lower(myName)].nines) or 0
		local yourLSScore = (live.individuals.ls and live.individuals.ls[string.lower(myName)] and live.individuals.ls[string.lower(myName)].score) or 99999
		local yourSCScore = (live.individuals.sc and live.individuals.sc[string.lower(myName)] and live.individuals.sc[string.lower(myName)].score) or 0
		local yourSCNines = (live.individuals.sc and live.individuals.sc[string.lower(myName)] and live.individuals.sc[string.lower(myName)].nines) or 0
		local yourMBScore = (live.individuals.mb and live.individuals.mb[string.lower(myName)] and live.individuals.mb[string.lower(myName)].score) or 0
		local yourMBNines = (live.individuals.mb and live.individuals.mb[string.lower(myName)] and live.individuals.mb[string.lower(myName)].nines) or 0
		local rivalHSScore = (live.individuals.hs and live.individuals.hs[settings.rival] and live.individuals.hs[settings.rival].score) or 0
		local rivalHSNines = (live.individuals.hs and live.individuals.hs[settings.rival] and live.individuals.hs[settings.rival].nines) or 0
		local rivalLSScore = (live.individuals.ls and live.individuals.ls[settings.rival] and live.individuals.ls[settings.rival].score) or 99999
		local rivalSCScore = (live.individuals.sc and live.individuals.sc[settings.rival] and live.individuals.sc[settings.rival].score) or 0
		local rivalSCNines = (live.individuals.sc and live.individuals.sc[settings.rival] and live.individuals.sc[settings.rival].nines) or 0
		local rivalMBScore = (live.individuals.mb and live.individuals.mb[settings.rival] and live.individuals.mb[settings.rival].score) or 0
		local rivalMBNines = (live.individuals.mb and live.individuals.mb[settings.rival] and live.individuals.mb[settings.rival].nines) or 0
		local text = settings.taunt
		local imBeatingText = ''
		local imBeating = {}
		-- Compare scores, add ones that you are beating your rival in into the imBeating table
		if (yourHSNines > rivalHSNines) or (yourHSScore > rivalHSScore) then
			table.insert(imBeating, "High WS")
		end
		if yourLSScore < rivalLSScore then
			table.insert(imBeating, "Low WS")
		end
		if (yourSCNines > rivalSCNines) or (yourSCScore > rivalSCScore) then
			table.insert(imBeating, "Skillchain")
		end
		if (yourMBNines > rivalMBNines) or (yourMBScore > rivalMBScore) then
			table.insert(imBeating, "Magic Burst")
		end
		-- Put together which scores you're beating your Rival in, then add it to the text to send them
		if #imBeating == 0 then
			windower.add_to_chat(220,'[Leaderboard] '..('You are not currently beating your Rival in anything.'):color(8))
			return
		elseif #imBeating == 2 then
			imBeatingText = imBeating[1].." and "..imBeating[2]
		else
			for i, board in ipairs(imBeating) do
				if i == 1 then
					imBeatingText = imBeatingText..board
				elseif i == #imBeating then
					imBeatingText = imBeatingText .. ", and "..board
				else
					imBeatingText = imBeatingText..", "..board
				end
			end
		end
		say("/t "..settings.rival.." "..(text):format(imBeatingText))


	-- Unknown command
	else
		windower.add_to_chat(220,'[Leaderboard] '..('unknown command. Type \'//em help\' for list of commands.'):color(8))

	end
end)


-- Creates the countdown for the flood delay timer
windower.register_event('prerender', function()
	if os.time() > Heartbeat then
		Heartbeat = os.time()
		if flood_timer >= 1 then
			flood_timer = flood_timer - 1
		end
	end
end)


-- On zone change, remind that LB is running
windower.register_event('zone change',function()
	if settings.reminder and Mode == 'Lite' or Mode == 'Party' then
		coroutine.sleep(5)
		windower.add_to_chat(220,'[Leaderboard] '..(('Currently %s'):format(settings.paused and 'paused' or 'running')..' in '..Mode..' Mode'):color(8))
	end
end)
