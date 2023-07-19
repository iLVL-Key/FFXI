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
_addon.version = '3.0'
_addon.author = 'Key'
_addon.commands = {'leaderboard','lb'}

require 'logger'
require 'chat'
texts = require('texts')
config = require('config')
packets = require('packets')

defaults = {}					-- All of these are configurable via commands in-game (//lb help), recommend that over editing the settings file
defaults.flood_delay = 5		-- Sets the delay between incoming commands, preventing party members from spamming commands
defaults.reminder = true		-- Display occasional reminders
defaults.commas = true			-- Add commas to the scores
defaults.visible = true			-- Display the scores with an On-Screen Display
defaults.party_commands = false	-- Allow party/alliance members to trigger certain commands via chat
defaults.optout = {}			-- A list of names to be excluded from data collection
defaults.rival = ''				-- The name of an optional Rival to track

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

defaults.places = {}
defaults.places.cure = {}
defaults.places.death = {}
defaults.places.hs = {}
defaults.places.kill = {}
defaults.places.ls = {}
defaults.places.mb = {}
defaults.places.murder = {}
defaults.places.nuke = {}
defaults.places.sc = {}
defaults.places.whiff = {}

defaults.individuals = {}
defaults.individuals.cure = {}
defaults.individuals.death = {}
defaults.individuals.hs = {}
defaults.individuals.kill = {}
defaults.individuals.ls = {}
defaults.individuals.mb = {}
defaults.individuals.murder = {}
defaults.individuals.nuke = {}
defaults.individuals.sc = {}
defaults.individuals.whiff = {}

defaults.indexes = {}		-- Used to order the scores as they are saved to indicate which came first,
defaults.indexes.death = 0	-- this will then properly place duplicate score values
defaults.indexes.hs = 0		-- ie multiple people hit 99999, order it by who hit 99999 first
defaults.indexes.kill = 0	-- Cure and Nuke are used to call out every x amount
defaults.indexes.ls = 0		
defaults.indexes.mb = 0		
defaults.indexes.murder = 0
defaults.indexes.sc = 0
defaults.indexes.whiff = 0

defaults.first_load = true
defaults.paused = false

settings = config.load(defaults)

local weaponskills = require('resources').weapon_skills
local spells = require('resources').spells
local jabils = require('resources').job_abilities
local mabils = require('resources').monster_abilities

local cmd = windower.send_command
local say = windower.chat.input
if windower.ffxi.get_info().logged_in then
	local myName = windower.ffxi.get_mob_by_target('me').name
end

-- When logging in
function login()

	-- Reset the players name
	myName = windower.ffxi.get_mob_by_target('me').name

	-- Show the box
	if settings.visible then
        showBox()
    end
end

-- When logging out, hide the box
function logout()
    hideBox()
end

windower.register_event('login', login)

local Heartbeat = 0
local flood_timer = 0
local box_display = 'hs'
local Mode = 'Silent'
local zoning = false


-- Put places info into tables to call them in order
function getPlacesInfo(places)
	local name = {
		places.first and places.first.name,
		places.second and places.second.name,
		places.third and places.third.name,
		places.fourth and places.fourth.name,
		places.fifth and places.fifth.name
	}
	local score = {
		places.first and places.first.score,
		places.second and places.second.score,
		places.third and places.third.score,
		places.fourth and places.fourth.score,
		places.fifth and places.fifth.score
	}
	local nines = {
		places.first and places.first.nines,
		places.second and places.second.nines,
		places.third and places.third.nines,
		places.fourth and places.fourth.nines,
		places.fifth and places.fifth.nines
	}

	return {
		name = name,
		score = score,
		nines = nines
	}
end


-- Return the names back to their proper capitalization
-- Names are saved in all lowercase to get around them being lowercased automatically in the
-- settings file any way when the addon is reloaded (ie to work properly with crash recovery).
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

	local places = settings.places[box_display]
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

	local header_text = ('%s '):format(settings.paused and 'Paused' or 'Running')
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
				text = text..'\\cs('..color.r..', '..color.g..', '..color.b..') '..i..': '..capitalize(info.name[i])..' ('..addCommas(info.score[i])..('%s'):format(info.nines[i] > 0 and ':'..info.nines[i]..')' or ')')..'\\cr \n'
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
	local actor = windower.ffxi.get_mob_by_id(id)
	if actor == nil or (not actor.in_alliance and not actor.in_party) then
		return false
	else
		return actor
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
	local l_name = string.lower(name)
	local ind = settings.individuals
	-- Check if the name already exists in the table
	if not settings.optout[l_name] then

		-- Add the name to the table
		settings.optout[l_name] = true

		-- Delete all related data for the player
		local tables = {ind.cure, ind.death, ind.hs, ind.kill, ind.ls, ind.mb, ind.murder, ind.nuke, ind.sc, ind.whiff}
		for _, table in ipairs(tables) do
			table[l_name] = nil
		end

		settings:save('all')
		windower.add_to_chat(220,'[Leaderboard] '..('Added '..name..' to the Optout list. All related data has been deleted. '):color(8)..'')

	else

		windower.add_to_chat(220,'[Leaderboard] '..(name..' is already in the Optout list.'):color(8)..'')

	end
end


-- Remove a name from the Optout list
function removeFromOptout(name)
	local l_name = string.lower(name)
	-- Check if the name exists in the table
	if settings.optout[l_name] then
		-- Remove the name from the table
		settings.optout[l_name] = nil
		settings:save('all')
		windower.add_to_chat(220,'[Leaderboard] '..('Removed '..name..' from the Optout list.'):color(8)..'')
	else
		windower.add_to_chat(220,'[Leaderboard] '..(name..' is not in the Optout list.'):color(8)..'')
	end
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
	local ind = settings.individuals
	local text1 = ''
	local text2 = ''
	local text_hs = (ind.hs[name] and ind.hs[name].score) and ind.hs[name].score..(ind.hs[name].nines > 0 and ':'..ind.hs[name].score or '') or 0
	local text_ls = (ind.ls[name] and ind.ls[name].score) and ind.ls[name].score or 0
	local text_sc = (ind.sc[name] and ind.sc[name].score) and ind.sc[name].score..(ind.sc[name].nines > 0 and ':'..ind.sc[name].score or '') or 0
	local text_whiff = (ind.whiff[name] and ind.whiff[name].score) and ind.whiff[name].score or 0
	local text_mb = (ind.mb[name] and ind.mb[name].score) and ind.mb[name].score..(ind.mb[name].nines > 0 and ':'..ind.mb[name].score or '') or 0
	local text_nuke = (ind.nuke[name] and ind.nuke[name].score) and ind.nuke[name].score or 0
	local text_cure = (ind.cure[name] and ind.cure[name].score) and ind.cure[name].score or 0
	local text_death = (ind.death[name] and ind.death[name].score) and ind.death[name].score or 0
	local text_kill = (ind.kill[name] and ind.kill[name].score) and ind.kill[name].score or 0
	local text_murder = (ind.murder[name] and ind.murder[name].score) and ind.murder[name].score or 0
	if text_hs == 0 and text_ls == 0 and text_sc == 0 and text_whiff == 0 and text_mb == 0 and text_nuke == 0 and text_cure == 0 and text_death == 0 and text_kill == 0 and text_murder == 0 then
		text1 = 'No data for you yet.'
		text2 = ''
	else
		text1 = 'High WS: '..text_hs..', Low WS: '..text_ls..', Skillchain: '..text_sc..', Whiffs: '..text_whiff..', Deaths: '..text_death
		text2 = 'Nukes: '..text_nuke..', Magic Burst: '..text_mb..', Cures: '..text_cure..', Kills: '..text_kill..', Murders: '..text_murder
	end
	say('/t '..name..' '..text1)
	if text2 ~= '' then
		coroutine.sleep(1.5)
		say('/t '..name..' '..text2)
	end
end


--Reset boards
function resetC()
	settings.individuals.cure = {}
	settings.places.cure = {}
end
function resetD()
	settings.individuals.death = {}
	settings.places.death = {}
	settings.indexes.death = 0
end
function resetHS()
	settings.individuals.hs = {}
	settings.places.hs = {}
	settings.indexes.hs = 0
end
function resetK()
	settings.individuals.kill = {}
	settings.places.kill = {}
	settings.indexes.kill = 0
end
function resetLS()
	settings.individuals.ls = {}
	settings.places.ls = {}
	settings.indexes.ls = 0
end
function resetMB()
	settings.individuals.mb = {}
	settings.places.mb = {}
	settings.indexes.mb = 0
end
function resetM()
	settings.individuals.murder = {}
	settings.places.murder = {}
	settings.indexes.murder = 0
end
function resetN()
	settings.individuals.nuke = {}
	settings.places.nuke = {}
end
function resetSC()
	settings.individuals.sc = {}
	settings.places.sc = {}
	settings.indexes.sc = 0
end
function resetW()
	settings.individuals.whiff = {}
	settings.places.whiff = {}
	settings.indexes.whiff = 0
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

	-- Limit to tells(3) and party chat(4), check if Party commands are enabled, check flood timer
	if not (mode == 3 or mode == 4) or not settings.party_commands or flood_timer ~= 0 then
		return
	end

	local l_name = string.lower(sender)

	-- CURE BOARD
	if (message:find('!lb c') or message:find('!lbc') or message:find('!LB C') or message:find('!LBC')) and not (message:find('[Leaderboard] Started!')) then
		cmd('lb c')

	-- DEATH BOARD
	elseif (message:find('!lb d') or message:find('!lbd') or message:find('!LB D') or message:find('!LBD')) and not (message:find('[Leaderboard] Started!')) then
		cmd('lb d')

	-- HIGH WS BOARD
	elseif (message:find('!lb hs') or message:find('!lbhs') or message:find('!LB HS') or message:find('!LBHS')) and not (message:find('[Leaderboard] Started!')) then
		cmd('lb hs')

	-- KILL BOARD
	elseif (message:find('!lb k') or message:find('!lbk') or message:find('!LB K') or message:find('!LBK')) and not (message:find('[Leaderboard] Started!')) then
		cmd('lb k')

	-- LOW WS BOARD
	elseif (message:find('!lb ls') or message:find('!lbls') or message:find('!LB LS') or message:find('!LBLS')) and not (message:find('[Leaderboard] Started!')) then
		cmd('lb ls')

	-- MAGIC BURST BOARD
	elseif (message:find('!lb mb') or message:find('!lbmb') or message:find('!LB MB') or message:find('!LBMB')) and not (message:find('[Leaderboard] Started!')) then
		cmd('lb mb')

	-- MURDER BOARD
	elseif (message:find('!lb m') or message:find('!lbm') or message:find('!LB M') or message:find('!LBM')) and not (message:find('[Leaderboard] Started!')) then
		cmd('lb m')

	-- NUKE BOARD
	elseif (message:find('!lb n') or message:find('!lbn') or message:find('!LB N') or message:find('!LBN')) and not (message:find('[Leaderboard] Started!')) then
		cmd('lb n')

	-- SKILLCHAIN BOARD
	elseif (message:find('!lb sc') or message:find('!lbsc') or message:find('!LB SC') or message:find('!LBSC')) and not (message:find('[Leaderboard] Started!')) then
		cmd('lb sc')

	-- WHIFF BOARD
	elseif (message:find('!lb w') or message:find('!lbw') or message:find('!LB W') or message:find('!LBW')) and not (message:find('[Leaderboard] Started!')) then
		cmd('lb w')

	-- Send a score update to the message sender
	elseif message:find('!lb report') then
		reportPlayerScores(l_name)

	-- Add/remove the message sender to the Optout list
	elseif message:find('!lb optout') then
		say('/t '..sender..(' You have been %s the Leaderboard Optout list.'):format(settings.optout[l_name] and 'removed from' or 'added to'))
		if settings.optout[l_name] then
			removeFromOptout(sender)
		else
			addToOptout(sender)
		end

	-- Unknown command
	elseif message:find('!lb') then
		say('/t '..sender..' [Leaderboard] Unknown command. Valid cammands are: \'!lb c|d|hs|k|ls|m|mb|n|sc|w|report|optout\'')

	end
	
	-- Reset the flood timer after a command comes in
	flood_timer = settings.flood_delay
end)


windower.register_event('incoming chunk', function(id, original, modified, injected, blocked)
    if id == 0x029 and not settings.paused then
		local packet = packets.parse('incoming', original)
		local target = get_actor(packet['Target'])
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

			local killPlaces = settings.places.kill
			local killIndividuals = settings.individuals.kill

			-- Retrieve the actors relevant data
			local kills = (killIndividuals[data.actor_lower_name] and killIndividuals[data.actor_lower_name].score) or 0
			local index = settings.indexes.kill

			-- Update the actors score information
			kills = kills +1
			index = index +1 -- Increment the index number for every updated score, enduring no duplicates
			settings.indexes.kill = index
			killIndividuals[data.actor_lower_name] = {score = kills, nines = 0, index = index}

			-- Update the leaderboard places
			local board = sortNamesHigh(settings.individuals.kill)
			killPlaces.first	= board[1]
			killPlaces.second	= (board and board[2]) or nil
			killPlaces.third	= (board and board[3]) or nil
			killPlaces.fourth	= (board and board[4]) or nil
			killPlaces.fifth	= (board and board[5]) or nil
			settings:save('all')
			updateBox(box_display)

			-- Call out Kills, depending on the mode and how many Kills they are at
			if Mode ~= "Silent" then
				local everyNumKills = kills % 10 -- returns the remainder after euclidean division (division by subtraction)
				if everyNumKills == 0 then -- if that leftover number equals 0, then the number is a multiple of Num
					say('/p [KILL] '..data.actor_name..' has racked up '..kills..' kills!')
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

				local deathPlaces = settings.places.death
				local deathIndividuals = settings.individuals.death

				-- Retrieve the targets relevant data
				local deaths = (deathIndividuals[data.target_lower_name] and deathIndividuals[data.target_lower_name].score) or 0
				local index = settings.indexes.death

				-- Update the targets score information
				deaths = deaths +1
				index = index +1 -- Increment the index number for every updated score, enduring no duplicates
				settings.indexes.death = index
				deathIndividuals[data.target_lower_name] = {score = deaths, nines = 0, index = index}

				-- Update the leaderboard places
				local board = sortNamesHigh(settings.individuals.death)
				deathPlaces.first	= board[1]
				deathPlaces.second	= (board and board[2]) or nil
				deathPlaces.third	= (board and board[3]) or nil
				deathPlaces.fourth	= (board and board[4]) or nil
				deathPlaces.fifth	= (board and board[5]) or nil
				settings:save('all')
				updateBox(box_display)

				-- Call out Deaths, depending on the mode and how many Deaths they are at
				if Mode ~= "Silent" then
					if deaths == 1 and data.target_lower_name == deathPlaces.first.name then
						say('/p [DEATH] '..data.target_name..' is the first to die!')
					elseif deaths == 1 then
						say('/p [DEATH] '..data.target_name..' has their first death!')
					elseif deaths < 10 then
						say('/p [DEATH] '..data.target_name..(' has died %s'):format(deaths < 5 and '' or 'yet ')..'again...')
					else
						local everyNumDeaths = deaths % 5 -- returns the remainder after euclidean division (division by subtraction)
						if everyNumDeaths == 0 then -- if that leftover number equals 0, then the number is a multiple of Num
							say('/p [DEATH] '..data.target_name..' is up to '..deaths..' deaths!')
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

				local murderPlaces = settings.places.murder
				local murderIndividuals = settings.individuals.murder

				-- Retrieve the actors relevant data
				local murders = (murderIndividuals[data.actor_lower_name] and murderIndividuals[data.actor_lower_name].score) or 0
				local index = settings.indexes.murder

				-- Update the actors score information
				murders = murders +1
				index = index +1 -- Increment the index number for every updated score, enduring no duplicates
				settings.indexes.murder = index
				murderIndividuals[data.actor_lower_name] = {score = murders, nines = 0, index = index}

				-- Update the leaderboard places
				local board = sortNamesHigh(settings.individuals.murder)
				murderPlaces.first	= board[1]
				murderPlaces.second	= (board and board[2]) or nil
				murderPlaces.third	= (board and board[3]) or nil
				murderPlaces.fourth	= (board and board[4]) or nil
				murderPlaces.fifth	= (board and board[5]) or nil
				settings:save('all')
				updateBox(box_display)

				-- Call out Murders
				if Mode ~= "Silent" then
					if murders == 1 then
						say('/p [MURDER] '..data.actor_name..(' has %s'):format(data.actor_lower_name == murderPlaces.first.name and 'drawn First Blood and' or '')..' murdered '..data.target_name..'!')
					end
				end

			end
		end
	end
end)


windower.register_event('action',function(act)

	-- A certain type of Spell, Ability, or Item is used that cures
	if (act.category == 4 or act.category == 5 or act.category == 6 or act.category == 11 or act.category == 14) and not settings.paused then

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
		elseif act.category == 6 or act.category == 14 then
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

			local curePlaces = settings.places.cure
			local cureIndividuals = settings.individuals.cure

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
			local board = sortNamesHigh(settings.individuals.cure)
			curePlaces.first	= board[1]
			curePlaces.second	= (board and board[2]) or nil
			curePlaces.third	= (board and board[3]) or nil
			curePlaces.fourth	= (board and board[4]) or nil
			curePlaces.fifth	= (board and board[5]) or nil
			settings:save('all')
			updateBox(box_display)

			-- Call out Cures, only if they've reached the next 50,000 threshhold
			if Mode ~= "Silent" then
				if everyNumCures > index then
					say('/p [CURE] '..data.actor_name..' has cured for over '..addCommas(points)..' HP!')
				end
			end

		end

	-- Weapon Skill is used
	elseif act.category == 3 and not settings.paused then
		
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
		if act.targets[1].actions[1].message == 188 or act.targets[1].actions[1].message == 31 or (act.targets[1].actions[1].message == 185 and data.damage == 0) then 

			-----------
			-- WHIFF --
			-----------

			local whiffPlaces = settings.places.whiff
			local whiffIndividuals = settings.individuals.whiff

			-- Retrieve the actors relevant data
			local whiffs = (whiffIndividuals[data.actor_lower_name] and whiffIndividuals[data.actor_lower_name].score) or 0
			local index = settings.indexes.whiff

			-- Update the actors score information
			whiffs = whiffs +1
			index = index +1 -- Increment the index number for every updated score, enduring no duplicates
			settings.indexes.whiff = index
			whiffIndividuals[data.actor_lower_name] = {score = whiffs, nines = 0, index = index}

			-- Update the leaderboard places
			local board = sortNamesHigh(settings.individuals.whiff)
			whiffPlaces.first	= board[1]
			whiffPlaces.second	= (board and board[2]) or nil
			whiffPlaces.third	= (board and board[3]) or nil
			whiffPlaces.fourth	= (board and board[4]) or nil
			whiffPlaces.fifth	= (board and board[5]) or nil
			settings:save('all')
			updateBox(box_display)

			-- Call out Whiffs, depending on the mode and how many Whiffs they are at
			if Mode ~= "Silent" then
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
		elseif act.targets[1].actions[1].message == 185 then

			-------------
			-- HIGH WS --
			-------------

			local hsPlaces = settings.places.hs
			local hsIndividuals = settings.individuals.hs

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
			local yourOriginalHSScore = (hsIndividuals and hsIndividuals[string.lower(myName)] and hsIndividuals[string.lower(myName)].score) or 0
			local rivalOriginalHSScore = (hsIndividuals and hsIndividuals[settings.rival] and hsIndividuals[settings.rival].score) or 0
			
			-- Retrieve the actors relevant data
			local nines = (hsIndividuals[data.actor_lower_name] and hsIndividuals[data.actor_lower_name].nines) or 0
			local index = settings.indexes.hs

			-- Count the number of 99999 WSs
			if data.damage == 99999 then
				nines = nines + 1
			end

			-- Update the actors score information
			if (hsIndividuals[data.actor_lower_name] == nil) or (data.damage >= hsIndividuals[data.actor_lower_name].score) then
				index = index +1 -- Increment the index number for every updated score, enduring no duplicates
				settings.indexes.hs = index
				hsIndividuals[data.actor_lower_name] = {score = data.damage, nines = nines, index = index}
			end

			-- Update the leaderboard places
			local board = sortNamesHigh(settings.individuals.hs)
			hsPlaces.first	= board[1]
			hsPlaces.second	= (board and board[2]) or nil
			hsPlaces.third	= (board and board[3]) or nil
			hsPlaces.fourth	= (board and board[4]) or nil
			hsPlaces.fifth	= (board and board[5]) or nil
			settings:save('all')
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

			-- Did the actor move up the leaderboard
			if Mode ~= "Silent" then
				if newHSPlace == originalHSPlace and newHSPlace == 1 and (data.damage > originalHSfirstscore or data.damage == 99999) then
					--coroutine.sleep(1)
					say('/p [HIGH WS] '..uppercase(data.actor_name)..' extends the lead! '..data.ws..' for '..addCommas(data.damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..data.target_name..'!')
				elseif newHSPlace < originalHSPlace then
					if newHSPlace == 1 then
						if data.damage > originalHSfirstscore then
							--coroutine.sleep(1)
							say('/p [HIGH WS] '..uppercase(data.actor_name)..' takes the board! '..data.ws..' for '..addCommas(data.damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..data.target_name..'!')
						end
					elseif newHSPlace ~= originalHSPlace and newHSPlace ~= 6 and Mode == "Party" then
						--coroutine.sleep(1)
						say('/p [HIGH WS] '..data.actor_name..' moves up to No.'..newHSPlace..'! '..data.ws..' for '..addCommas(data.damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..data.target_name..'!')
					end
				end
			end

			-- Did you or your rival beat one or the other
			if settings.rival ~= "" then
				if data.actor_name == myName then
					if (rivalOriginalHSScore > yourOriginalHSScore) and	(data.damage > rivalOriginalHSScore) then
						windower.add_to_chat(220,'[Leaderboard] '..('You\'re now beating '..capitalize(settings.rival)..'\'s '..addCommas(hsIndividuals[settings.rival].score)..' HIGH WS score with a '):color(6)..(addCommas(data.damage)..' '..data.ws..'.'):color(158))
					end
				elseif data.actor_name == capitalize(settings.rival) then
					if (yourOriginalHSScore > rivalOriginalHSScore) and data.damage > yourOriginalHSScore then
						windower.add_to_chat(220,'[Leaderboard] '..(capitalize(settings.rival)..' is now beating your '..addCommas(hsIndividuals[string.lower(myName)].score)..' HIGH WS score with a '):color(28)..(addCommas(data.damage)..' '..data.ws..'.'):color(167))
					end
				end
			end

			------------
			-- LOW WS --
			------------

			local lsPlaces = settings.places.ls
			local lsIndividuals = settings.individuals.ls

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
			local yourOriginalLSScore = (lsIndividuals and lsIndividuals[string.lower(myName)] and lsIndividuals[string.lower(myName)].score) or 0
			local rivalOriginalLSScore = (lsIndividuals and lsIndividuals[settings.rival] and lsIndividuals[settings.rival].score) or 0

			-- Retrieve the actors relevant data
			local index = settings.indexes.ls

			-- Update the actors score
			if (settings.individuals.ls[data.actor_lower_name] == nil) or (data.damage < settings.individuals.ls[data.actor_lower_name].score) then
				index = index +1 -- Increment the index number for every updated score, enduring no duplicates
				settings.indexes.ls = index
				lsIndividuals[data.actor_lower_name] = {score = data.damage, nines = 0, index = index}
			end

			-- Update the leaderboard places
			local board = sortNamesLow(settings.individuals.ls)
			lsPlaces.first	= board[1]
			lsPlaces.second	= (board and board[2]) or nil
			lsPlaces.third	= (board and board[3]) or nil
			lsPlaces.fourth	= (board and board[4]) or nil
			lsPlaces.fifth	= (board and board[5]) or nil
			settings:save('all')
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

			-- Did the actor move up the leaderboard
			-- Wait until at least 2 low scores are filled before calling out new 1st place score
			if Mode ~= "Silent" then
				if newLSPlace == originalLSPlace and newLSPlace == 1 and data.damage < originalLSfirstscore and (lsPlaces.second and lsPlaces.second.score ~= nil) then
					coroutine.sleep(1.6)
					say('/p [LOW WS] '..uppercase(data.actor_name)..' extends the lead! '..data.ws..' for '..addCommas(data.damage)..' on the '..data.target_name..'!')
				elseif newLSPlace < originalLSPlace and (lsPlaces.second and lsPlaces.second.score ~= nil) then
					if newLSPlace == 1 then
						if data.damage < originalLSfirstscore then
							coroutine.sleep(1.6)
							say('/p [LOW WS] '..uppercase(data.actor_name)..' takes the board! '..data.ws..' for '..addCommas(data.damage)..' on the '..data.target_name..'!')
						end
					elseif newLSPlace ~= originalLSPlace and newLSPlace ~= 6 and Mode == "Party" then
						coroutine.sleep(1.6)
						say('/p [LOW WS] '..data.actor_name..' moves up to No.'..newLSPlace..'! '..data.ws..' for '..addCommas(data.damage)..' on the '..data.target_name..'.')
					end
				end
			end

			-- Did you or your rival beat one or the other
			if settings.rival ~= "" then
				if data.actor_name == myName then
					if (rivalOriginalLSScore < yourOriginalLSScore) and	(data.damage < rivalOriginalLSScore) then
						windower.add_to_chat(220,'[Leaderboard] '..('You\'re now beating '..capitalize(settings.rival)..'\'s '..addCommas(lsIndividuals[settings.rival].score)..' LOW WS score with a '):color(6)..(addCommas(data.damage)..' '..data.ws..'.'):color(158))
					end
				elseif data.actor_name == capitalize(settings.rival) then
					if (yourOriginalLSScore < rivalOriginalLSScore) and data.damage < yourOriginalLSScore then
						windower.add_to_chat(220,'[Leaderboard] '..(capitalize(settings.rival)..' is now beating your '..addCommas(lsIndividuals[string.lower(myName)].score)..' LOW WS score with a '):color(28)..(addCommas(data.damage)..' '..data.ws..'.'):color(167))
					end
				end
			end

		end
	end

	-- Skillchain is created
	if ((act.category == 4 and act.targets[1].actions[1].message == 2) or (act.category == 3 and act.targets[1].actions[1].message == 185)) and act.targets[1].actions[1].has_add_effect and not settings.paused then

		----------------
		-- SKILLCHAIN --
		----------------

		local actor = get_actor(act.actor_id)

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

		local scPlaces = settings.places.sc
		local scIndividuals = settings.individuals.sc

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

		-- What are you and your Rivals original cores
		local yourOriginalSCScore = (scIndividuals and scIndividuals[string.lower(myName)] and scIndividuals[string.lower(myName)].score) or 0
		local rivalOriginalSCScore = (scIndividuals and scIndividuals[settings.rival] and scIndividuals[settings.rival].score) or 0

		-- Retrieve the actors relevant data
		local nines = (scIndividuals[data.actor_lower_name] and scIndividuals[data.actor_lower_name].nines) or 0
		local index = settings.indexes.sc

		-- Count the number of 99999 WSs
		if data.damage == 99999 then
			nines = nines + 1
		end

		-- Update the actors score information
		if (scIndividuals[data.actor_lower_name] == nil) or (data.damage >= scIndividuals[data.actor_lower_name].score) then
			index = index +1 -- Increment the index number for every updated score, enduring no duplicates
			settings.indexes.sc = index
			scIndividuals[data.actor_lower_name] = {score = data.damage, nines = nines, index = index}
		end

		-- Update the leaderboard places
		local board = sortNamesHigh(settings.individuals.sc)
		scPlaces.first	= board[1]
		scPlaces.second	= (board and board[2]) or nil
		scPlaces.third	= (board and board[3]) or nil
		scPlaces.fourth	= (board and board[4]) or nil
		scPlaces.fifth	= (board and board[5]) or nil
		settings:save('all')
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
		if Mode ~= "Silent" then
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

		-- Did you or your rival beat one or the other
		if settings.rival ~= "" then
			if data.actor_name == myName then
				if (rivalOriginalSCScore > yourOriginalSCScore) and	(data.damage > rivalOriginalSCScore) then
					windower.add_to_chat(220,'[Leaderboard] '..('You\'re now beating '..capitalize(settings.rival)..'\'s '..addCommas(scIndividuals[settings.rival].score)..' SKILLCHAIN score with a '):color(6)..(addCommas(data.damage)..' '..data.sc..'.'):color(158))
				end
			elseif data.actor_name == capitalize(settings.rival) then
				if (yourOriginalSCScore > rivalOriginalSCScore) and data.damage > yourOriginalSCScore then
					windower.add_to_chat(220,'[Leaderboard] '..(capitalize(settings.rival)..' is now beating your '..addCommas(scIndividuals[string.lower(myName)].score)..' SKILLCHAIN score with a '):color(28)..(addCommas(data.damage)..' '..data.sc..'.'):color(167))
				end
			end
		end

	end

	-- Magic Burst lands
	if ((act.category == 4 and act.targets[1].actions[1].message == 252) or (act.category == 15 and act.targets[1].actions[1].message == 110)) and not settings.paused then

		-----------------
		-- MAGIC BURST --
		-----------------

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

		local mbPlaces = settings.places.mb
		local mbIndividuals = settings.individuals.mb

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
		local yourOriginalMBScore = (mbIndividuals and mbIndividuals[string.lower(myName)] and mbIndividuals[string.lower(myName)].score) or 0
		local rivalOriginalMBScore = (mbIndividuals and mbIndividuals[settings.rival] and mbIndividuals[settings.rival].score) or 0

		-- Retrieve the actors relevant data
		local nines = (mbIndividuals[data.actor_lower_name] and mbIndividuals[data.actor_lower_name].nines) or 0
		local index = settings.indexes.mb

		-- Count the number of 99999 WSs
		if data.damage == 99999 then
			nines = nines + 1
		end

		-- Update the actors score information
		if (mbIndividuals[data.actor_lower_name] == nil) or (data.damage >= mbIndividuals[data.actor_lower_name].score) then
			index = index +1 -- Increment the index number for every updated score, enduring no duplicates
			settings.indexes.mb = index
			mbIndividuals[data.actor_lower_name] = {score = data.damage, nines = nines, index = index}
		end

		-- Update the leaderboard places
		local board = sortNamesHigh(settings.individuals.mb)
		mbPlaces.first	= board[1]
		mbPlaces.second	= (board and board[2]) or nil
		mbPlaces.third	= (board and board[3]) or nil
		mbPlaces.fourth	= (board and board[4]) or nil
		mbPlaces.fifth	= (board and board[5]) or nil
		settings:save('all')
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
		if Mode ~= "Silent" then
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

		-- Did you or your rival beat one or the other
		if settings.rival ~= "" then
			if data.actor_name == myName then
				if (rivalOriginalMBScore > yourOriginalMBScore) and	(data.damage > rivalOriginalMBScore) then
					windower.add_to_chat(220,'[Leaderboard] '..('You\'re now beating '..capitalize(settings.rival)..'\'s '..addCommas(mbIndividuals[settings.rival].score)..' MAGIC BURST score with a '):color(6)..(addCommas(data.damage)..' '..data.spell..'.'):color(158))
				end
			elseif data.actor_name == capitalize(settings.rival) then
				if (yourOriginalMBScore > rivalOriginalMBScore) and data.damage > yourOriginalMBScore then
					windower.add_to_chat(220,'[Leaderboard] '..(capitalize(settings.rival)..' is now beating your '..addCommas(mbIndividuals[string.lower(myName)].score)..' MAGIC BURST score with a '):color(28)..(addCommas(data.damage)..' '..data.spell..'.'):color(167))
				end
			end
		end

	end

	--Nuke lands (includes Magic Bursts)
	if ((act.category == 4 and act.targets[1].actions[1].message == 2) or (act.category == 4 and act.targets[1].actions[1].message == 252) or (act.category == 15 and act.targets[1].actions[1].message == 110)) and not settings.paused then

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

		local nukePlaces = settings.places.nuke
		local nukeIndividuals = settings.individuals.nuke

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
		local board = sortNamesHigh(settings.individuals.nuke)
		nukePlaces.first	= board[1]
		nukePlaces.second	= (board and board[2]) or nil
		nukePlaces.third	= (board and board[3]) or nil
		nukePlaces.fourth	= (board and board[4]) or nil
		nukePlaces.fifth	= (board and board[5]) or nil
		settings:save('all')
		updateBox(box_display)

		-- Call out Nukes, only if they've reached the next 500,000 point threshhold
		if Mode ~= "Silent" then
			if everyNumNukes > index then 
				say('/p [NUKE] '..data.actor_name..' has nuked for over '..addCommas(points)..' damage!')
			end
		end

	end
end)

windower.register_event('addon command',function(addcmd, arg, arg2)

	-- Reload LB
	if addcmd == 'reload' then
        cmd('lua r leaderboard')
        return


	-- Reset the data, does not stop LB from running
	elseif addcmd == 'reset' then
		local data = ''
		if arg == 'c' or arg == 'cure' or arg == 'cures' then
			resetC()
			data = 'CURE'
		elseif arg == 'd' or arg == 'death' or arg == 'deaths' then
			resetD()
			data = 'DEATH'
		elseif arg == 'hs' or arg == 'highscore' or arg == 'hiscore' then
			resetHS()
			data = 'HIGH WS'
		elseif arg == 'k' or arg == 'kill' or arg == 'kills' then
			resetK()
			data = 'KILL'
		elseif arg == 'ls' or arg == 'lowscore' or arg == 'loscore' then
			resetLS()
			data = 'LOW WS'
		elseif arg == 'n' or arg == 'nuke' or arg == 'nukes' then
			resetN()
			data = 'NUKE'
		elseif arg == 'mb' or arg == 'magicburst' or arg == 'burst' then
			resetMB()
			data = 'MAGIC BURST'
		elseif arg == 'm' or arg == 'murder' then
			resetM()
			data = 'MURDER'
		elseif arg == 'sc' or arg == 'skillchain' then
			resetSC()
			data = 'SKILLCHAIN'
		elseif arg == 'w' or arg == 'whiff' or arg == 'whiffs' then
			resetW()
			data = 'WHIFF'
		elseif arg == 'all' then
			resetALL()
			data = 'ALL'
		else
			windower.add_to_chat(220,'[Leaderboard] '..('Please add which board you would like reset (all/c/d/hs/k/ls/m/mb/n/sc/w).'):color(8))
			return
		end
		if Mode ~= "Silent" then
			say('/p [Leaderboard] '..data..' data reset.')
		else
			windower.add_to_chat(220,'[Leaderboard] '..(data..' data reset.'):color(8))
		end
		settings:save('all')
		updateBox(box_display)


	-- Reminder setting
	elseif addcmd == 'reminder' or addcmd == 'reminders' then
		if arg == 'on' or arg == 'true' then
			settings.reminder = true
		elseif arg == 'off' or arg == 'false' then
			settings.reminder = false
		end
		windower.add_to_chat(220,'[Leaderboard] '..(('Reminders are set to %s'):format(settings.reminder and 'on.' or 'off.')):color(8))
		settings:save('all')


	-- Comma setting
	elseif addcmd == 'comma' or addcmd == 'commas' then
		if arg == 'on' or arg == 'true' then
			settings.commas = true
		elseif arg == 'off' or arg == 'false' then
			settings.commas = false
		end
		windower.add_to_chat(220,'[Leaderboard] '..(('Commas are set to %s'):format(settings.commas and 'on.' or 'off.')):color(8))
		settings:save('all')


	-- Party Commands setting
	elseif addcmd == 'party' or addcmd == 'partycommand' or addcmd == 'partycommands' then
		if arg == 'on' or arg == 'true' then
			settings.party_commands = true
		elseif arg == 'off' or arg == 'false' then
			settings.party_commands = false
		end
		windower.add_to_chat(220,'[Leaderboard] '..(('Party Commands are set to %s'):format(settings.party_commands and 'on.' or 'off.')):color(8))
		settings:save('all')


	-- Flood Delay setting
	elseif addcmd == 'flood' or addcmd == 'flooddelay' then
		if arg == nil then
			windower.add_to_chat(220,'[Leaderboard] '..('Flood Delay is currently set to '..settings.flood_delay..' seconds.'):color(8))
		elseif tonumber(arg) ~= nil then
			settings.flood_delay = arg
			settings:save('all')
			windower.add_to_chat(220,'[Leaderboard] '..('Flood Delay is now set to '..settings.flood_delay..' seconds.'):color(8))
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
		windower.add_to_chat(36,'   visible/show/hide'..(' [c/d/hs/k/ls/m/mb/n/sc/w]'):color(53)..(' - Display boards on screen.'):color(8))
		windower.add_to_chat(36,'   rival'..(' <name>'):color(2)..(' - Set the specified player as your Rival. Repeat to remove.'):color(8))
		windower.add_to_chat(220,' ')
		windower.add_to_chat(220,' Advanced Commands '..('[optional]'):color(53)..(' <required>'):color(2))
		windower.add_to_chat(36,'   mode/m'..(' [lite/l/party/p/silent/s]'):color(53)..(' - Display/change the current Mode.'):color(8))
		windower.add_to_chat(36,'   c/d/hs/k/ls/m/mb/n/sc/w'..(' - Print board to party chat.'):color(8))
		windower.add_to_chat(36,'   lock/unlock'..(' - Drag the On-Screen Display.'):color(8))
		windower.add_to_chat(36,'   report'..(' <name>'):color(2)..(' - Send the specified player their score report via tell.'):color(8))
		windower.add_to_chat(36,'   comma'..(' [on/off]'):color(53)..(' - Display/change the Comma setting.'):color(8))
		windower.add_to_chat(36,'   party'..(' [on/off]'):color(53)..(' - Display/change the Party Command setting.'):color(8))
		windower.add_to_chat(36,'   reminder'..(' [on/off]'):color(53)..(' - Display/change the Reminder setting.'):color(8))
		windower.add_to_chat(36,'   flood'..(' [#]'):color(53)..(' - Display/change the current Flood Delay setting.'):color(8))


	-- Pause
	elseif addcmd == 'pause' or addcmd == 'p' then

		if not settings.paused then
			settings.paused = true
		else
			settings.paused = false
		end
		settings:save('all')
		if Mode ~= "Silent" then
			say(('/p [Leaderboard] %s'):format(settings.paused and 'Paused' or 'Unpaused')..' ('..Mode..' Mode).')
		else
			windower.add_to_chat(220,'[Leaderboard] '..(('%s'):format(settings.paused and 'Paused' or 'Unpaused')..' ('..Mode..' Mode).'):color(8))
		end
		updateBox(box_display)


	-- Switch to Party Mode
	elseif addcmd == 'modep' or (addcmd == 'mode' and (arg == 'party' or arg == 'p')) then
		Mode = "Party"
		say(('/p [Leaderboard] Mode set to '..Mode..' (%s).'):format(settings.paused and 'paused' or 'running'))
		if settings.reminder then
			coroutine.sleep(1)
			windower.add_to_chat(220,'[Leaderboard] '..('Beware - Party Mode uses party chat heavily.'):color(8))
		end


	-- Switch to Lite Mode
	elseif addcmd == 'model' or (addcmd == 'mode' and (arg == 'lite' or arg == 'l')) then
		Mode = "Lite"
		say(('/p [Leaderboard] Mode set to '..Mode..' (%s).'):format(settings.paused and 'paused' or 'running'))


	-- Switch to Silent Mode
	elseif addcmd == 'modes' or (addcmd == 'mode' and (arg == 'silent' or arg == 's')) then
		Mode = "Silent"
		say(('/p [Leaderboard] Mode set to '..Mode..' (%s).'):format(settings.paused and 'paused' or 'running'))


	-- Display which mode Leaderboard is currently running in
	elseif addcmd == 'mode' then
		windower.add_to_chat(220,'[Leaderboard] '..(('Currently %s'):format(settings.paused and 'paused' or 'running')..' in '..Mode..' Mode'):color(8))


	-- Display the commands for the different boards
	elseif addcmd == 'board' or addcmd == 'boards' or addcmd == 'leaderboard' or addcmd == 'leaderboards' then
		windower.add_to_chat(220,'[Leaderboard] '..('Current Tracked Boards'):color(220))
		windower.add_to_chat(36,'   c/cure'..(' - Running total of cures'):color(8))
		windower.add_to_chat(36,'   d/death'..(' - Running total of deaths'):color(8))
		windower.add_to_chat(36,'   hs/highscore'..(' - Highest individual WS damage'):color(8))
		windower.add_to_chat(36,'   k/kill'..(' - Running total of kills'):color(8))
		windower.add_to_chat(36,'   ls/lowscore'..(' - Lowest individual WS damage'):color(8))
		windower.add_to_chat(36,'   m/murder'..(' - Running total of murders'):color(8))
		windower.add_to_chat(36,'   mb/magicburst'..(' - Highest individual MB damage'):color(8))
		windower.add_to_chat(36,'   n/nuke'..(' - Running total of nukes'):color(8))
		windower.add_to_chat(36,'   sc/skillchain'..(' - Highest individual SC damage'):color(8))
		windower.add_to_chat(36,'   w/whiffs'..(' - Running total of whiffs'):color(8))


	-- CURE BOARD
	elseif addcmd == 'c' or addcmd == 'cure' or addcmd == 'cures' then

		if arg == 'reset' then
			resetC()
			updateBox(box_display)
			windower.add_to_chat(220,'[Leaderboard] '..('CURE data reset.'):color(8))
		else
			local places = settings.places.cure
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
		else
			local places = settings.places.death
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
		else
			local places = settings.places.hs
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
		else
			local places = settings.places.kill
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
		else
			local places = settings.places.ls
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
		else
			local places = settings.places.mb
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
		else
			local places = settings.places.murder
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
		else
			local places = settings.places.nuke
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
		else
			local places = settings.places.sc
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
		else
			local places = settings.places.whiff
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
			addToOptout(arg2)
		elseif arg == 'remove' or arg == 'r' or arg == 'delete' or arg == 'd' then
			removeFromOptout(arg2)
		else
			local list = optoutList()
			windower.add_to_chat(220,'[Leaderboard] '..('Optout list: '):color(8)..(capitalize(list)):color(1))
		end


	-- Send a specific player their score report via tell
	elseif addcmd == 'report' or addcmd == 'r' then

		if arg == nil then
			windower.add_to_chat(220,'[Leaderboard] '..('Please add a name.'):color(8))
		else
			local c_name = capitalize(arg)
			local actor = windower.ffxi.get_mob_by_name(c_name)
			if actor == nil or (not actor.in_alliance and not actor.in_party) then
				windower.add_to_chat(220,'[Leaderboard] '..(c_name..' is not in the party.'):color(8))
			else
				reportPlayerScores(string.lower(actor.name))
			end
		end


    -- Show the LB box
    elseif addcmd == 'show' or addcmd == 'visible' then
		-- Toggle the visibility of the LB box
		if addcmd == 'visible' then
			-- Flip the visibilty setting and save
			settings.visible = not settings.visible
			toggleBox()
		else
			settings.visible = true
			showBox()
		end
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
		elseif arg == 'sc' or arg == 'skillchain' then
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


	-- Unknown command
	else
		windower.add_to_chat(220,'[Leaderboard] '..('unknown command. Type \'//em help\' for list of commands.'):color(8))

		-- Throw a reminder in there if they are turned on
		if settings.reminder then
			windower.add_to_chat(220,'[Leaderboard] '..(('Currently %s'):format(settings.paused and 'paused' or 'running')..' in '..Mode..' Mode.'):color(8))
		end

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
	coroutine.sleep(5)
	if settings.reminder then
		windower.add_to_chat(220,'[Leaderboard] '..(('Currently %s'):format(settings.paused and 'paused' or 'running')..' in '..Mode..' Mode'):color(8))
	end
end)
