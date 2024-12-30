--[[
Copyright © 2025, Key
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
_addon.version = '5.0'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'leaderboard','lb'}

require 'logger'
require 'chat'
texts = require('texts')
config = require('config')
packets = require('packets')

defaults = {}							--In addition to the settings file, all of these are also configurable via commands in-game (//lb help).

defaults.party_commands = true			--Allow party/alliance members to trigger certain commands via chat while in Party/Raid/Mog Kart Mode.
defaults.flood_delay = 5				--Delay in seconds between incoming commands, preventing party members from spamming commands.
defaults.reminder = true				--Display a reminder upon zoning that Leaderboard is running while in Party/Raid/Mog Kart Mode.
defaults.commas = true					--Add commas to the scores.
defaults.optout = {}					--List of names to be excluded from data collection.
defaults.mode = 'Silent'				--Default mode Leaderboard starts in.
defaults.rival = ''						--Name of an optional Rival to track.
defaults.taunt = "Thought you should know I'm beating you on %s."	-- Text the taunt command sends your Rival
defaults.kart_item_interval = 50		--Number of interval actions between when a random item box is given to a player in Mog Kart Mode. Lower is more often.
defaults.kart_p_board_time = 300		--Time in seconds between when the Points Board gets put into party chat while in Mog Kart Mode (0 to turn off)
defaults.kart_trust_item_time_max = 120	--Maximum time in seconds that a trust will use an item after they receive it.
defaults.kart_trust_item_time_min = 10	--Minimum time in seconds that a trust will use an item after they receive it.
defaults.osd_show_number = 10			--Number of places the On-Screen Display will show.
defaults.default_osd_board = 'td'		--Initial board shown in the On-Screen Display upon loading the addon.
defaults.output_all_delay = 6			--Delay between printing boards to party chat using the `all` command.

--Party/Raid Mode party chat callouts while running
defaults.party_calls = T{}
defaults.party_calls.buff	= true	--Buff removal/land, every 25.
defaults.party_calls.cure	= true	--Cure, every 25k up to 100k then every 50k. Raid Mode: every 50k.
defaults.party_calls.death	= false	--Death, each up to 10, then every 5. Raid mode: First, then every 5.
defaults.party_calls.debuff	= true	--Debuff removal/land, every 25.
defaults.party_calls.hs		= true	--High WS, top 5. Raid Mode: first place only. Nines: every 10.
defaults.party_calls.kill	= true	--Kill, every 10.
defaults.party_calls.ls		= true	--Low WS, top 5. Raid Mode: first place only.
defaults.party_calls.mb		= true	--Magic Burst, top 5. Raid Mode: first place only.
defaults.party_calls.melee	= false	--Melee damage, every 250k up to 1m then every 500k. Raid Mode: every 500k.
defaults.party_calls.murder	= true	--Murder/Victim, each.
defaults.party_calls.nuke	= false	--Nuke damage, every 250k up to 1m then every 500k. Raid Mode: every 500k.
defaults.party_calls.ra		= false	--Ranged Attack damage, every 10k up to 50k then every 25k up to 100k then every 50k. Raid Mode: every 25k up to 100k then every 50k.
defaults.party_calls.sc		= true	--Skillchain, top 5. Raid Mode: first place only.
defaults.party_calls.td		= true	--Total Damage, every 250k up to 1m then every 1m up to 10m then every 5m. Raid Mode: every 1m up to 10m then every 5m.
defaults.party_calls.whiff	= false	--Whiff, each up to 10 then every 5. Raid Mode: every 5.
defaults.party_calls.ws		= false	--Weapon Skill damage, every 250k up to 1m then every 500k up to 5m then every 1m. Raid Mode: every 500k up to 5m then every 1m.

--Determines which boards are sent to party chat during the `//lb all` command
defaults.all_command_callouts = {}
defaults.all_command_callouts.buff	= true
defaults.all_command_callouts.cure	= true
defaults.all_command_callouts.death	= true
defaults.all_command_callouts.debuff= true
defaults.all_command_callouts.hs	= true
defaults.all_command_callouts.kill	= true
defaults.all_command_callouts.ls	= true
defaults.all_command_callouts.mb	= true
defaults.all_command_callouts.melee	= true
defaults.all_command_callouts.murder= true
defaults.all_command_callouts.nuke	= true
defaults.all_command_callouts.point	= true
defaults.all_command_callouts.ra	= true
defaults.all_command_callouts.sc	= true
defaults.all_command_callouts.td	= true
defaults.all_command_callouts.victim= true
defaults.all_command_callouts.whiff	= true
defaults.all_command_callouts.ws	= true

--Gain points per board, this affects whether a player gains any points at all (including bonus) for being on this board.
defaults.gainpt = {}
defaults.gainpt.buff	= true
defaults.gainpt.cure	= true
defaults.gainpt.death	= false
defaults.gainpt.debuff	= true
defaults.gainpt.hs		= true
defaults.gainpt.kill	= true
defaults.gainpt.ls		= true
defaults.gainpt.mb		= true
defaults.gainpt.melee	= true
defaults.gainpt.murder	= false
defaults.gainpt.nuke	= true
defaults.gainpt.ra		= true
defaults.gainpt.sc		= true
defaults.gainpt.td		= false
defaults.gainpt.victim	= true
defaults.gainpt.whiff	= false
defaults.gainpt.ws		= true

--Base points per board, this affects the point weight of each board.
defaults.basept = {}
defaults.basept.buff	= 1
defaults.basept.cure	= 3
defaults.basept.death	= 0
defaults.basept.debuff	= 2
defaults.basept.hs		= 1
defaults.basept.kill	= 1
defaults.basept.ls		= 1
defaults.basept.mb		= 2
defaults.basept.melee	= 1
defaults.basept.murder	= 0
defaults.basept.nuke	= 2
defaults.basept.ra		= 1
defaults.basept.sc		= 1
defaults.basept.td		= 0
defaults.basept.victim	= 1
defaults.basept.whiff	= 0
defaults.basept.ws		= 1

--Bonus points per place
defaults.bonuspt = {}
defaults.bonuspt.first		= 3
defaults.bonuspt.second		= 2
defaults.bonuspt.third		= 1
defaults.bonuspt.fourth		= 1
defaults.bonuspt.fifth		= 1
defaults.bonuspt.sixth		= 0
defaults.bonuspt.seventh	= 0
defaults.bonuspt.eighth		= 0
defaults.bonuspt.ninth		= 0
defaults.bonuspt.tenth		= 0
defaults.bonuspt.eleventh	= 0
defaults.bonuspt.twelfth	= 0
defaults.bonuspt.thirteenth	= 0
defaults.bonuspt.fourteenth	= 0
defaults.bonuspt.fifteenth	= 0
defaults.bonuspt.sixteenth	= 0
defaults.bonuspt.seventeenth= 0
defaults.bonuspt.eighteenth	= 0

--Percent of points lost per
defaults.pctloss = {}
defaults.pctloss.death	= 10 --A Murder will also transfer this amount from the Murderer to the Victim
defaults.pctloss.whiff	= 3

--Item details
-- .available = is the item available at all (ie set to false to disable)
-- .time = amount of time the item is active, if applicable
-- .points = the affect on the targets points (%-based unless otherwise noted)
-- .placeHi = The highest place eligible to receive these items
-- .placeLo = The lowest place eligible to receive these items
defaults.item = {}

--Blue Shell: Player in 1st place loses x% of their points
defaults.item.blue_shell = {}
defaults.item.blue_shell.available		= true
defaults.item.blue_shell.indart			= "a "
defaults.item.blue_shell.name			= "Crystal Meteor"
defaults.item.blue_shell.description	= "Cast a giant flaming rock on the head of the player in first place."
defaults.item.blue_shell.points			= 20
defaults.item.blue_shell.placeHi		= 3
defaults.item.blue_shell.placeLo		= 18
defaults.item.blue_shell.accuracy		= 99
defaults.item.blue_shell.castTime		= 10

--Red Shell: Player one place above loses x% of their points
defaults.item.red_shell = {}
defaults.item.red_shell.available		= true
defaults.item.red_shell.indart			= "an "
defaults.item.red_shell.name			= "Apex Shell"
defaults.item.red_shell.description		= "Shoot a highly accurate projectile at the player in front of you."
defaults.item.red_shell.points			= 10
defaults.item.red_shell.placeHi			= 2
defaults.item.red_shell.placeLo			= 18
defaults.item.red_shell.accuracy		= 95

--Green Shell: Player one place above loses x% of their points
defaults.item.green_shell = {}
defaults.item.green_shell.available		= true
defaults.item.green_shell.indart		= "a "
defaults.item.green_shell.name			= "Snipper Shell"
defaults.item.green_shell.description	= "Shoot a projectile at the player in front of you. May miss and hit the next player."
defaults.item.green_shell.points		= 8
defaults.item.green_shell.placeHi		= 2
defaults.item.green_shell.placeLo		= 18
defaults.item.green_shell.accuracy		= 75

--Fire Flower: The 3 players above lose x% of their points
defaults.item.fire_flower = {}
defaults.item.fire_flower.available		= true
defaults.item.fire_flower.indart		= "a "
defaults.item.fire_flower.name			= "Flare Petal"
defaults.item.fire_flower.description	= "Shoot small fireballs at the 3 players ahead of you."
defaults.item.fire_flower.points		= 5
defaults.item.fire_flower.placeHi		= 2
defaults.item.fire_flower.placeLo		= 18
defaults.item.fire_flower.accuracy		= 75

--Coin: Gain an immediate x% additional points
defaults.item.coin = {}
defaults.item.coin.available			= true
defaults.item.coin.indart				= "a "
defaults.item.coin.name					= "Moogle Coin Bag"
defaults.item.coin.description			= "Receive a gift of points from the Moogles, just don't drop it."
defaults.item.coin.pointsHi				= 15
defaults.item.coin.pointsLo				= 5
defaults.item.coin.placeHi				= 1
defaults.item.coin.placeLo				= 18
defaults.item.coin.accuracy				= 95

--Mushroom: Gain an additional x points per interval
defaults.item.mushroom = {}
defaults.item.mushroom.available		= true
defaults.item.mushroom.indart			= "a "
defaults.item.mushroom.name				= "Dasher's Drink"
defaults.item.mushroom.description		= "A quick boost in the right direction."
defaults.item.mushroom.points			= 1000
defaults.item.mushroom.time				= 10
defaults.item.mushroom.placeHi			= 1
defaults.item.mushroom.placeLo			= 18

--Super Horn: Players one place above and below lose x% of their points.
--A Blue Shell can be avoided with this if timed correctly (.time = window to avoid Blue Shell).
defaults.item.super_horn = {}
defaults.item.super_horn.available		= true
defaults.item.super_horn.indart			= "an "
defaults.item.super_horn.name			= "Aero Blaster"
defaults.item.super_horn.description	= "Fire a blast of air around you. I wonder if it can deflect things from above?"
defaults.item.super_horn.points			= 5
defaults.item.super_horn.time			= 3
defaults.item.super_horn.placeHi		= 1
defaults.item.super_horn.placeLo		= 3
defaults.item.super_horn.accuracy		= 100

--Banana: A random Player loses x% of their points after a random amount of time
defaults.item.banana = {}
defaults.item.banana.available			= true
defaults.item.banana.indart				= "an "
defaults.item.banana.name				= "Antlion Trap"
defaults.item.banana.description		= "Place on the ground and wait for an unsuspecting player to step on it!"
defaults.item.banana.points				= 5
defaults.item.banana.placeHi			= 1
defaults.item.banana.placeLo			= 12
defaults.item.banana.timeMin			= 30
defaults.item.banana.timeMax			= 300

--Bob-omb: The 3 players below loses x% of their points
defaults.item.bobomb = {}
defaults.item.bobomb.available			= true
defaults.item.bobomb.indart				= "a "
defaults.item.bobomb.name				= "Goblin Charge"
defaults.item.bobomb.description		= "This explosive hits the 3 people behind you, or if you're last, in front of you."
defaults.item.bobomb.points				= 5
defaults.item.bobomb.placeHi			= 1
defaults.item.bobomb.placeLo			= 6
defaults.item.bobomb.accuracy			= 90

--Super Star: Invincible to all other players items and gain an additional x% points per interval
defaults.item.super_star = {}
defaults.item.super_star.available		= true
defaults.item.super_star.indart			= "a "
defaults.item.super_star.name			= "Starseed"
defaults.item.super_star.description	= "Consume this to become invincible and gain additional points at a modest rate."
defaults.item.super_star.points			= 1
defaults.item.super_star.time			= 20
defaults.item.super_star.placeHi		= 7
defaults.item.super_star.placeLo		= 18

--Bullet Bill: Invincible to all other players items and gain an additional x% points per interval
defaults.item.bullet_bill = {}
defaults.item.bullet_bill.available		= true
defaults.item.bullet_bill.indart		= "a "
defaults.item.bullet_bill.name			= "Bolt Brew"
defaults.item.bullet_bill.description	= "Consume this to become invincible and gain additional points at a greater rate."
defaults.item.bullet_bill.points		= 2
defaults.item.bullet_bill.time			= 20
defaults.item.bullet_bill.placeHi		= 13
defaults.item.bullet_bill.placeLo		= 18

--Eft Bomb: Hit either a specified player (with name attached ie !item keylesta) or a random player (with no additional name attached)
--Using with a name incurs the point penalty on the using player if it misses (using without a name does not incur this penalty)
defaults.item.eft_bomb = {}
defaults.item.eft_bomb.available		= true
defaults.item.eft_bomb.indart			= "an "
defaults.item.eft_bomb.name				= "Eft Bomb"
defaults.item.eft_bomb.description		= "Designate a target by adding their name, but there are consequences if you miss."
defaults.item.eft_bomb.points			= 15
defaults.item.eft_bomb.placeHi			= 1
defaults.item.eft_bomb.placeLo			= 18
defaults.item.eft_bomb.accuracy			= 85

defaults.first_load = true
defaults.visible = true

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
live.places.buff = {}
live.places.cure = {}
live.places.death = {}
live.places.debuff = {}
live.places.hs = {}
live.places.kill = {}
live.places.point = {}
live.places.ls = {}
live.places.mb = {}
live.places.melee = {}
live.places.murder = {}
live.places.nuke = {}
live.places.ra = {}
live.places.sc = {}
live.places.td = {}
live.places.victim = {}
live.places.whiff = {}
live.places.ws = {}

live.individuals = {}
live.individuals.buff = {}
live.individuals.cure = {}
live.individuals.death = {}
live.individuals.debuff = {}
live.individuals.hs = {}
live.individuals.kill = {}
live.individuals.point = {}
live.individuals.ls = {}
live.individuals.mb = {}
live.individuals.melee = {}
live.individuals.murder = {}
live.individuals.nuke = {}
live.individuals.ra = {}
live.individuals.sc = {}
live.individuals.td = {}
live.individuals.victim = {}
live.individuals.whiff = {}
live.individuals.ws = {}

live.items = {}

--The index is used to order the scores as they are saved to indicate
--which came first, this will then properly order duplicate score values
live.index = 0
live.paused = false

settings = config.load(defaults)
live = config.load('data/live.xml', live)

local weaponskills = require('resources').weapon_skills
local spells = require('resources').spells
local jabils = require('resources').job_abilities
local mabils = require('resources').monster_abilities

local cmd = windower.send_command
local say = windower.chat.input
local add_to_chat = windower.add_to_chat
local get_mob_by_target = windower.ffxi.get_mob_by_target
local get_mob_by_id = windower.ffxi.get_mob_by_id
local register_event = windower.register_event

local self_name
if get_mob_by_target('me') then
	self_name = string.lower(get_mob_by_target('me').name)
end
register_event('login', function()
	coroutine.sleep(3)
	self_name = string.lower(get_mob_by_target('me').name)
end)

local Heartbeat = 0
local box_display = settings.default_osd_board
local zoning = false
local releaseValveOpen = true
local kart_p_board_time = 1
local output_all = false

local effects = {} --Current item effect players have active
local flood_delay = {} --Individual flood delay for players

local chatBuffer = {} --Temporarily stores party chat callouts before they are printed to chat

--Put places info into tables to call them in order
local function getPlacesInfo(places)

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
		places.tenth and places.tenth.name,
		places.eleventh and places.eleventh.name,
		places.twelfth and places.twelfth.name,
		places.thirteenth and places.thirteenth.name,
		places.fourteenth and places.fourteenth.name,
		places.fifteenth and places.fifteenth.name,
		places.sixteenth and places.sixteenth.name,
		places.seventeenth and places.seventeenth.name,
		places.eighteenth and places.eighteenth.name,
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
		places.tenth and places.tenth.score,
		places.eleventh and places.eleventh.score,
		places.twelfth and places.twelfth.score,
		places.thirteenth and places.thirteenth.score,
		places.fourteenth and places.fourteenth.score,
		places.fifteenth and places.fifteenth.score,
		places.sixteenth and places.sixteenth.score,
		places.seventeenth and places.seventeenth.score,
		places.eighteenth and places.eighteenth.score,
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
		places.tenth and places.tenth.nines,
		places.eleventh and places.eleventh.nines,
		places.twelfth and places.twelfth.nines,
		places.thirteenth and places.thirteenth.nines,
		places.fourteenth and places.fourteenth.nines,
		places.fifteenth and places.fifteenth.nines,
		places.sixteenth and places.sixteenth.nines,
		places.seventeenth and places.seventeenth.nines,
		places.eighteenth and places.eighteenth.nines,
	}

	return {
		name = name,
		score = score,
		nines = nines
	}

end


--Return the names back to their proper capitalization
--Names are saved in all lowercase to get around them being lowercased automatically in the
--settings file anyway when the addon is reloaded (ie to work properly with crash recovery).
--This prevents a sort of "duplication" issue where the older data is now lowercased and the
--new data started after recovery is capitalized as expected.
local function capitalize(str)

	local capitalized = string.gsub(str, "(%w[%w']*)", function(word)
		if word ~= "of" then
			word = word:gsub("^%l", string.upper)
		end
		return word
	end)

	return capitalized

end


--Capitalize and truncate names so they fit better into a board when called
local function capitalizeAndTruncate(str, length, ellipsis)

	--Check if the string length is greater than 8
	if #str > length then
		--Truncate to 7 characters and add a period/ellipsis
		str = string.sub(str, 1, length-1)..(ellipsis and "…" or ".")
	end

	--Capitalize the name
	local capitalized = string.gsub(str, "(%w[%w']*)", function(word)
		if word ~= "of" then
			word = word:gsub("^%l", string.upper)
		end
		return word
	end)

	return capitalized

end


--Turn the entire name into all uppercase
local function uppercase(str)

	local uppercased = string.gsub(str, "%a", function(letter)
		return letter:upper()
	end)

	return uppercased

end


--Add commas to numbers to make them easier to read
local function addCommas(number)

	--Convert the number to a string
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

	--Return the number (albeit as a string, we're not doing any math on it at this point)
	return formattedNumber

end


--Abbreviate numbers to make the shorter
function abbreviateNumber(num)
	if num >= 1e12 then
		return string.format("%.1ft", num / 1e12)
	elseif num >= 1e9 then
		return string.format("%.1fb", num / 1e9)
	elseif num >= 1e6 then
		return string.format("%.1fm", num / 1e6)
	elseif num >= 1e3 then
		return string.format("%.1fk", num / 1e3)
	else
		return string.format("%.1f", num)
	end
end


--Show the BP box
local function showBox()
	lbBox:show()
end


--Hide the BP box
local function hideBox()
	lbBox:hide()
end


--Get the Total Damage Percent for each player
local function getTDP(info)
	local percentages = {}
	local total = 0

	-- Calculate the sum of all entries in "info.score"
	for _, value in ipairs(info.score) do
		total = total + value
	end

	-- If total is zero, return a table of 0s with the same length as "info.score"
	if total == 0 then
		for i = 1, #info.score do
			percentages[i] = 0
		end
		return percentages
	end

	-- Calculate each entry's percentage and round to 2 decimal places
	for i, value in ipairs(info.score) do
		local percentage = (value / total) * 100
		percentages[i] = math.floor(percentage * 100 + 0.5) / 100 -- Rounding to 2 decimal places
	end

	return percentages
end


--Update the BP box
local function updateBox(box_display)

	local textColor = settings.colors.text
	local headerColor = settings.colors.header
	local selfColor = settings.colors.self
	local rivalColor = settings.colors.rival
	local t_c = textColor

	local places = live.places[box_display]
	local info = getPlacesInfo(places)
	local tdp = {}

	--Format RGB values with leading zeros (helps prevent an issue with the text not lining up correctly after color is added)
	local function formatRGB(value)
		return string.format("%03d", value)
	end

	--Which board is being displayed
	local board_name = Leaderboard
	if box_display == 'buff' then
		board_name = 'Buff Board'
	elseif box_display == 'cure' then
		board_name = 'Cure Board'
	elseif box_display == 'death' then
		board_name = 'Death Board'
	elseif box_display == 'debuff' then
		board_name = 'Debuff Board'
	elseif box_display == 'hs' then
		board_name = 'High WS Board'
	elseif box_display == 'kill' then
		board_name = 'Kill Board'
	elseif box_display == 'point' then
		board_name = 'Point Board'
	elseif box_display == 'ls' then
		board_name = 'Low WS Board'
	elseif box_display == 'mb' then
		board_name = 'Magic Burst Board'
	elseif box_display == 'melee' then
		board_name = 'Melee Board'
	elseif box_display == 'murder' then
		board_name = 'Murder Board'
	elseif box_display == 'nuke' then
		board_name = 'Nuke Board'
	elseif box_display == 'ra' then
		board_name = 'Ranged Att Board'
	elseif box_display == 'sc' then
		board_name = 'Skillchain Board'
	elseif box_display == 'td' then
		board_name = 'Total Damage Board'
		tdp = getTDP(info)
	elseif box_display == 'victim' then
		board_name = 'Victim Board'
	elseif box_display == 'whiff' then
		board_name = 'Whiff Board'
	elseif box_display == 'ws' then
		board_name = 'Total WS Board'
	end

	--Create a temporary "text" string that we use to build what's displayed in the box
	local text = '\\cs('..headerColor.r..', '..headerColor.g..', '..headerColor.b..')'
	--First row, always 35 characters long
	local first_row = ' '..board_name
	while string.len(first_row) < 25 do
		first_row = first_row..' '
	end
	first_row = first_row..'//lb help '

	--Add the first row into the text string
	text = text..first_row..'\n'

	--Second row, always 35 characters long
	local mode_text = ' '..settings.mode..' Mode'
	local space_text = ''
	local pause_text = ('%s\\cr \n'):format(live.paused and 'Paused' or 'Running')
	while string.len(mode_text) + string.len(space_text) + string.len(pause_text) < 39 do
		space_text = ' '..space_text
	end

	--Add the texts from the second row into the text string
	text = text..mode_text..space_text..pause_text

	if info.name[1] == nil then
		text = text..' Waiting For Data...'
	else
		--Pull the list of the top names/scores and add it to the text string
		for i = 1, settings.osd_show_number, 1
		do
			if info.name[i] ~= nil then --This may look redundant at first glance, but it removes any trailing empty places

				if capitalize(info.name[i]) == get_mob_by_target('me').name then
					t_c = selfColor
				elseif info.name[i] == settings.rival then
					t_c = rivalColor
				else
					t_c = textColor
				end

				local cs = '\\cs('..formatRGB(t_c.r)..','..formatRGB(t_c.g)..','..formatRGB(t_c.b)..')'
				local place = ' '..i..'|'
				local name = info.name[i]
				local cr = '\\cr'
				local spaces = ''
				local spaces_cs = '\\cs(100,100,100)'
				local score_info = ''
				if box_display == "buff" or box_display == "debuff" then
					local pct = math.floor((info.score[i] / info.nines[i]) * 100 + .5)
					pct = string.format("%3d", pct)
					score_info = ' '..addCommas(info.score[i])..'/'..info.nines[i]..' '..pct..'% '
				elseif box_display == "td" then
					local pct = tdp[i]
					pct = string.format("%.2f", pct)
					pct = string.rep(" ", 6 - #pct) .. pct
					score_info = ' '..addCommas(info.score[i])..' '..pct..'% '
				else
					score_info = ' '..addCommas(info.score[i])..(info.nines[i] > 0 and ':'..info.nines[i]..' ' or ' ')
				end
				local text_width = string.len(place..name) + string.len(spaces) + string.len(score_info)
				if text_width > 35 then
					local num_to_truncate_to = string.len(name) - (text_width - 35)
					name = capitalizeAndTruncate(name,num_to_truncate_to,true)--true tells it to use an ellipsis instead of a period (looks better imo)
				else
					name = capitalize(name)
				end
				while text_width < 35 do
					if #spaces == 0 then
						spaces = spaces .. " "
					else
						spaces = spaces .. "."
					end
					text_width = text_width + 1
				end
				local left_text = cs..place..name..cr
				spaces = spaces_cs..spaces..cr
				local right_text = cs..score_info..cr..'\n'
				text = text..left_text..spaces..right_text

			end
		end
	end

	--Update the on screen box with the text string
	lbBox.current_string = text

end


--Create the LB box
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

	add_to_chat(8,('[Leaderboard] '):color(220)..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..('Key'):color(220))
	coroutine.sleep(1)
	add_to_chat(8,'Please be mindful that Leaderboard is not intended to be a full parser, but to add some fun to events.')
	coroutine.sleep(1)
	add_to_chat(8,'Type'..(' //lb help'):color(1)..(' for a list of commands.'):color(8))
	settings.first_load = false
	settings:save('all')

end


--Checks that the actor is in our party/alliance and return the player table
local function getActor(id)
	local actor = nil
	local ally_pos = {
		'p0', 'p1', 'p2', 'p3', 'p4', 'p5', 'a10', 'a11', 'a12', 'a13', 'a14', 'a15', 'a20', 'a21', 'a22', 'a23', 'a24', 'a25'
	}

	--Loop through the alliance members to see if the index of the actor matches anyones pet
	for i = 1, 18, 1 do
		local ally_member = get_mob_by_target(ally_pos[i]) or nil
		if ally_member and get_mob_by_id(id) and get_mob_by_id(id).index == ally_member.pet_index then
			--If there is a match, return the name of the pets owner
			actor = ally_member
			return actor
		end
	end

	--If there is no match, check if the actor is in our alliance
	if actor == nil then
		local actor = get_mob_by_id(id)
		if actor == nil or (not actor.in_alliance and not actor.in_party) then
			--Not in our alliance, return false
			return false
		else
			--In our alliance, return the name of the actor
			return actor
		end
	end

end


--Checks that the target is in our party/alliance and return the player table
local function getTarget(id)
	local target = get_mob_by_id(id)
	if target == nil or (not target.in_alliance and not target.in_party) then
		return false
	else
		return target
	end
end


--Is the target a mob?
local function isTargetMob(id)
	local target = get_mob_by_id(id)
	if target and target.is_npc and target.spawn_type == 16 then
		return target
	else
		return false
	end
end


--Are any of the targets an alliance member OTHER THAN the actor?
local function isTargetingOthers(act)
	for i = 1, act.target_count do
		if getActor(act.targets[i].id) and act.targets[i].id ~= getActor(act.actor_id).id then
			return true
		end
	end
	return false
end


--Sort the list by highest scores and return the list
local function sortNamesHigh(data)

	--Convert the input table into a list of objects with names
	local dataList = {}
	for name, obj in pairs(data) do
		obj.name = name
		table.insert(dataList, obj)
	end

	--Sort the dataList table
	table.sort(dataList, function(a, b)
		if a.score ~= b.score then
			return a.score > b.score --Sort by score in descending order
		elseif a.nines ~= b.nines then
			return a.nines > b.nines --Sort by nines in descending order
		else
			return a.index < b.index --Sort by index in ascending order (lower numbers were first)
		end
	end)

	--Create the board table
	local board = {}
	for i = 1, math.min(18, #dataList) do
		table.insert(board, dataList[i])
	end

	return board

end


--Sort the list by lowest scores and return the list
local function sortNamesLow(data)

	--Convert the input table into a list of objects with names
	local dataList = {}
	for name, obj in pairs(data) do
		obj.name = name
		table.insert(dataList, obj)
	end

	--Sort the dataList table based on the specified criteria
	table.sort(dataList, function(a, b)
		if a.score ~= b.score then
			return a.score < b.score --Sort by score in ascending order
		else
			return a.index < b.index --Sort by index in ascending order
		end
	end)

	--Create the board table
	local board = {}
	for i = 1, math.min(18, #dataList) do
		table.insert(board, dataList[i])
	end

	return board

end


--Sort the list by highest success rate and return the list
local function sortNamesBySuccessRate(data)

	--Convert the input table into a list of objects with names
	local dataList = {}
	for name, obj in pairs(data) do
		obj.name = name
		table.insert(dataList, obj)
	end

	--Sort the dataList table
	table.sort(dataList, function(a, b)
		--Compare by score first
		if a.score ~= b.score then
			return a.score > b.score --Sort by score (descending)
		end

		--Calculate success rates
		local successRateA = a.nines > 0 and (a.score / a.nines) or 0
		local successRateB = b.nines > 0 and (b.score / b.nines) or 0

		--If score is tied, compare by success rate
		if successRateA ~= successRateB then
			return successRateA > successRateB -- Sort by success rate (descending)
		end

		--If both score and success rate are tied, compare by index
		return a.index < b.index -- Sort by index (ascending)
	end)

	--Create the board table with top 18 or fewer entries
	local board = {}
	for i = 1, math.min(18, #dataList) do
		table.insert(board, dataList[i])
	end

	return board
end


--Update the point board
local function updatePointsBoards(board)

	local indPts = live.individuals.point
	local base = settings.basept
	local bonus = settings.bonuspt

	if live.places[board] and live.places[board].first then
		local points = (indPts[live.places[board].first.name] and indPts[live.places[board].first.name].score) or (not settings.optout[live.places[board].first.name] and 0) or 0
		indPts[live.places[board].first.name] = {score = points + base[board] + bonus.first, nines = 0, index = 0}
	end
	if live.places[board] and live.places[board].second then
		local points = (indPts[live.places[board].second.name] and indPts[live.places[board].second.name].score) or (not settings.optout[live.places[board].second.name] and 0) or 0
		indPts[live.places[board].second.name] = {score = points + base[board] + bonus.second, nines = 0, index = 0}
	end
	if live.places[board] and live.places[board].third then
		local points = (indPts[live.places[board].third.name] and indPts[live.places[board].third.name].score) or (not settings.optout[live.places[board].third.name] and 0) or 0
		indPts[live.places[board].third.name] = {score = points + base[board] + bonus.third, nines = 0, index = 0}
	end
	if live.places[board] and live.places[board].fourth then
		local points = (indPts[live.places[board].fourth.name] and indPts[live.places[board].fourth.name].score) or (not settings.optout[live.places[board].fourth.name] and 0) or 0
		indPts[live.places[board].fourth.name] = {score = points + base[board] + bonus.fourth, nines = 0, index = 0}
	end
	if live.places[board] and live.places[board].fifth then
		local points = (indPts[live.places[board].fifth.name] and indPts[live.places[board].fifth.name].score) or (not settings.optout[live.places[board].fifth.name] and 0) or 0
		indPts[live.places[board].fifth.name] = {score = points + base[board] + bonus.fifth, nines = 0, index = 0}
	end
	if live.places[board] and live.places[board].sixth then
		local points = (indPts[live.places[board].sixth.name] and indPts[live.places[board].sixth.name].score) or (not settings.optout[live.places[board].sixth.name] and 0) or 0
		indPts[live.places[board].sixth.name] = {score = points + base[board] + bonus.sixth, nines = 0, index = 0}
	end
	if live.places[board] and live.places[board].seventh then
		local points = (indPts[live.places[board].seventh.name] and indPts[live.places[board].seventh.name].score) or (not settings.optout[live.places[board].seventh.name] and 0) or 0
		indPts[live.places[board].seventh.name] = {score = points + base[board] + bonus.seventh, nines = 0, index = 0}
	end
	if live.places[board] and live.places[board].eighth then
		local points = (indPts[live.places[board].eighth.name] and indPts[live.places[board].eighth.name].score) or (not settings.optout[live.places[board].eighth.name] and 0) or 0
		indPts[live.places[board].eighth.name] = {score = points + base[board] + bonus.eighth, nines = 0, index = 0}
	end
	if live.places[board] and live.places[board].ninth then
		local points = (indPts[live.places[board].ninth.name] and indPts[live.places[board].ninth.name].score) or (not settings.optout[live.places[board].ninth.name] and 0) or 0
		indPts[live.places[board].ninth.name] = {score = points + base[board] + bonus.ninth, nines = 0, index = 0}
	end
	if live.places[board] and live.places[board].tenth then
		local points = (indPts[live.places[board].tenth.name] and indPts[live.places[board].tenth.name].score) or (not settings.optout[live.places[board].tenth.name] and 0) or 0
		indPts[live.places[board].tenth.name] = {score = points + base[board] + bonus.tenth, nines = 0, index = 0}
	end
	if live.places[board] and live.places[board].eleventh then
		local points = (indPts[live.places[board].eleventh.name] and indPts[live.places[board].eleventh.name].score) or (not settings.optout[live.places[board].eleventh.name] and 0) or 0
		indPts[live.places[board].eleventh.name] = {score = points + base[board] + bonus.eleventh, nines = 0, index = 0}
	end
	if live.places[board] and live.places[board].twelfth then
		local points = (indPts[live.places[board].twelfth.name] and indPts[live.places[board].twelfth.name].score) or (not settings.optout[live.places[board].twelfth.name] and 0) or 0
		indPts[live.places[board].twelfth.name] = {score = points + base[board] + bonus.twelfth, nines = 0, index = 0}
	end
	if live.places[board] and live.places[board].thirteenth then
		local points = (indPts[live.places[board].thirteenth.name] and indPts[live.places[board].thirteenth.name].score) or (not settings.optout[live.places[board].thirteenth.name] and 0) or 0
		indPts[live.places[board].thirteenth.name] = {score = points + base[board] + bonus.thirteenth, nines = 0, index = 0}
	end
	if live.places[board] and live.places[board].fourteenth then
		local points = (indPts[live.places[board].fourteenth.name] and indPts[live.places[board].fourteenth.name].score) or (not settings.optout[live.places[board].fourteenth.name] and 0) or 0
		indPts[live.places[board].fourteenth.name] = {score = points + base[board] + bonus.fourteenth, nines = 0, index = 0}
	end
	if live.places[board] and live.places[board].fifteenth then
		local points = (indPts[live.places[board].fifteenth.name] and indPts[live.places[board].fifteenth.name].score) or (not settings.optout[live.places[board].fifteenth.name] and 0) or 0
		indPts[live.places[board].fifteenth.name] = {score = points + base[board] + bonus.fifteenth, nines = 0, index = 0}
	end
	if live.places[board] and live.places[board].sixteenth then
		local points = (indPts[live.places[board].sixteenth.name] and indPts[live.places[board].sixteenth.name].score) or (not settings.optout[live.places[board].sixteenth.name] and 0) or 0
		indPts[live.places[board].sixteenth.name] = {score = points + base[board] + bonus.sixteenth, nines = 0, index = 0}
	end
	if live.places[board] and live.places[board].seventeenth then
		local points = (indPts[live.places[board].seventeenth.name] and indPts[live.places[board].seventeenth.name].score) or (not settings.optout[live.places[board].seventeenth.name] and 0) or 0
		indPts[live.places[board].seventeenth.name] = {score = points + base[board] + bonus.seventeenth, nines = 0, index = 0}
	end
	if live.places[board] and live.places[board].eighteenth then
		local points = (indPts[live.places[board].eighteenth.name] and indPts[live.places[board].eighteenth.name].score) or (not settings.optout[live.places[board].eighteenth.name] and 0) or 0
		indPts[live.places[board].eighteenth.name] = {score = points + base[board] + bonus.eighteenth, nines = 0, index = 0}
	end

end


local function updatePoints()

	--Add appropriate points to each player on the different boards
	local boards = {"buff", "cure", "death", "debuff", "hs", "kill", "ls", "mb", "melee", "murder", "nuke", "ra", "sc", "td", "victim", "whiff", "ws"}
	for _, board in ipairs(boards) do
		if settings.gainpt[board] then
			updatePointsBoards(board)
		end
	end

	--Add item effect points
	local liveIndPt = live.individuals.point
	for name, _ in pairs(effects) do

		--Player has a Bullet Bill active
		if effects[name].active == "bullet_bill" then
			local pointsToAdd = math.floor(liveIndPt[name].score * (settings.item.bullet_bill.points / 100))
			liveIndPt[name].score = liveIndPt[name].score + pointsToAdd
			local gainedPoints = effects[name].gainedPoints or 0
			gainedPoints = gainedPoints + pointsToAdd
			effects[name].gainedPoints = gainedPoints

		--Player has a Mushroom active
		elseif effects[name].active == "mushroom" then
			local pointsToAdd = settings.item.mushroom.points
			liveIndPt[name].score = liveIndPt[name].score + pointsToAdd
			local gainedPoints = effects[name].gainedPoints or 0
			gainedPoints = gainedPoints + pointsToAdd
			effects[name].gainedPoints = gainedPoints

			-- Player has a Super Star active
		elseif effects[name].active == "super_star" then
			local pointsToAdd = math.floor(liveIndPt[name].score * (settings.item.super_star.points / 100))
			liveIndPt[name].score = liveIndPt[name].score + pointsToAdd
			local gainedPoints = effects[name].gainedPoints or 0
			gainedPoints = gainedPoints + pointsToAdd
			effects[name].gainedPoints = gainedPoints
		end

	end

end


local function updateBoard(board_name)

	local board = (board_name == "buff" or board_name == "debuff") and sortNamesBySuccessRate(live.individuals[board_name])
	or board_name == "ls" and sortNamesLow(live.individuals[board_name])
	or sortNamesHigh(live.individuals[board_name])

	live.places[board_name].first		= board[1]
	live.places[board_name].second		= (board and board[2]) or nil
	live.places[board_name].third		= (board and board[3]) or nil
	live.places[board_name].fourth		= (board and board[4]) or nil
	live.places[board_name].fifth		= (board and board[5]) or nil
	live.places[board_name].sixth		= (board and board[6]) or nil
	live.places[board_name].seventh		= (board and board[7]) or nil
	live.places[board_name].eighth		= (board and board[8]) or nil
	live.places[board_name].ninth		= (board and board[9]) or nil
	live.places[board_name].tenth		= (board and board[10]) or nil
	live.places[board_name].eleventh	= (board and board[11]) or nil
	live.places[board_name].twelfth		= (board and board[12]) or nil
	live.places[board_name].thirteenth	= (board and board[13]) or nil
	live.places[board_name].fourteenth	= (board and board[14]) or nil
	live.places[board_name].fifteenth	= (board and board[15]) or nil
	live.places[board_name].sixteenth	= (board and board[16]) or nil
	live.places[board_name].seventeenth	= (board and board[17]) or nil
	live.places[board_name].eighteenth	= (board and board[18]) or nil

end


--Add a name to the Optout list
local function addToOptout(name)

	--Add the name to the table
	settings.optout[name] = true
	settings:save('all')

	--Delete all related data for the player
	local ind = live.individuals
	local indTable = {ind.cure, ind.death, ind.debuff, ind.hs, live.items, ind.kill, ind.ls, ind.mb, ind.murder, ind.nuke, ind.point, ind.ra, ind.sc, ind.td, ind.victim, ind.whiff, ind.ws}
	for _, table in ipairs(indTable) do
		table[name] = nil
	end

	--Update all leaderboard places without the player (Low WS done separately below)
	local sortTable = {"buff", "cure", "death", "debuff", "hs", "kill", "ls", "mb", "melee", "murder", "nuke", "point", "ra", "sc", "td", "victim", "whiff", "ws"}
	for _, table in ipairs(sortTable) do
		updateBoard(table)
	end

	live:save('all')
	updateBox(box_display)

end


--Remove a name from the Optout list
local function removeFromOptout(name)
	settings.optout[name] = nil
	settings:save('all')
end


--Return the Optout list
local function optoutList()

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


--Send the specified player their score report via tell
local function reportPlayerScores(name)
	local ind = live.individuals
	local placeNum = {"1st","2nd","3rd","4th","5th","6th","7th","8th","9th","10th","11th","12th","13th","14th","15th","16th","17th","18th"}
	local text1 = ''
	local text2 = ''
	local text3 = ''

	local t_buff_result = findPlace(name, "buff")
	local t_buff_place = not t_buff_result and "" or placeNum[t_buff_result]
	local t_buff = (ind.buff[name] and ind.buff[name].score) and addCommas(ind.buff[name].score)..'-'..t_buff_place or 0

	local t_cure_result = findPlace(name, "cure")
	local t_cure_place = not t_cure_result and "" or placeNum[t_cure_result]
	local t_cure = (ind.cure[name] and ind.cure[name].score) and addCommas(ind.cure[name].score)..'-'..t_cure_place or 0

	local t_death_result = findPlace(name, "death")
	local t_death_place = not t_death_result and "" or placeNum[t_death_result]
	local t_death = (ind.death[name] and ind.death[name].score) and addCommas(ind.death[name].score)..'-'..t_death_place or 0

	local t_debuff_result = findPlace(name, "debuff")
	local t_debuff_place = not t_debuff_result and "" or placeNum[t_debuff_result]
	local t_debuff = (ind.debuff[name] and ind.debuff[name].score) and addCommas(ind.debuff[name].score)..'-'..t_debuff_place or 0

	local t_hs_result = findPlace(name, "hs")
	local t_hs_place = not t_hs_result and "" or placeNum[t_hs_result]
	local t_hs = (ind.hs[name] and ind.hs[name].score) and addCommas(ind.hs[name].score)..(ind.hs[name].nines > 0 and ':'..ind.hs[name].nines or '')..'-'..t_hs_place or 'none'

	local t_kill_result = findPlace(name, "kill")
	local t_kill_place = not t_kill_result and "" or placeNum[t_kill_result]
	local t_kill = (ind.kill[name] and ind.kill[name].score) and addCommas(ind.kill[name].score)..'-'..t_kill_place or 0

	local t_ls_result = findPlace(name, "ls")
	local t_ls_place = not t_ls_result and "" or placeNum[t_ls_result]
	local t_ls = (ind.ls[name] and ind.ls[name].score) and addCommas(ind.ls[name].score)..'-'..t_ls_place or 'none'

	local t_mb_result = findPlace(name, "mb")
	local t_mb_place = not t_mb_result and "" or placeNum[t_mb_result]
	local t_mb = (ind.mb[name] and ind.mb[name].score) and addCommas(ind.mb[name].score)..(ind.mb[name].nines > 0 and ':'..ind.mb[name].nines or '')..'-'..t_mb_place or 'none'

	local t_melee_result = findPlace(name, "melee")
	local t_melee_place = not t_melee_result and "" or placeNum[t_melee_result]
	local t_melee = (ind.melee[name] and ind.melee[name].score) and addCommas(ind.melee[name].score)..'-'..t_melee_place or 0

	local t_murder_result = findPlace(name, "murder")
	local t_murder_place = not t_murder_result and "" or placeNum[t_murder_result]
	local t_murder = (ind.murder[name] and ind.murder[name].score) and addCommas(ind.murder[name].score)..'-'..t_murder_place or 0

	local t_nuke_result = findPlace(name, "nuke")
	local t_nuke_place = not t_nuke_result and "" or placeNum[t_nuke_result]
	local t_nuke = (ind.nuke[name] and ind.nuke[name].score) and addCommas(ind.nuke[name].score)..'-'..t_nuke_place or 0

	local t_point_result = findPlace(name, "point")
	local t_point_place = not t_point_result and "" or placeNum[t_point_result]
	local t_point = (ind.point[name] and ind.point[name].score) and addCommas(ind.point[name].score)..'-'..t_point_place or 0

	local t_ra_result = findPlace(name, "ra")
	local t_ra_place = not t_ra_result and "" or placeNum[t_ra_result]
	local t_ra = (ind.ra[name] and ind.ra[name].score) and addCommas(ind.ra[name].score)..'-'..t_ra_place or 0

	local t_sc_result = findPlace(name, "sc")
	local t_sc_place = not t_sc_result and "" or placeNum[t_sc_result]
	local t_sc = (ind.sc[name] and ind.sc[name].score) and addCommas(ind.sc[name].score)..(ind.sc[name].nines > 0 and ':'..ind.sc[name].nines or '')..'-'..t_sc_place or 'none'

	local t_td_result = findPlace(name, "td")
	local t_td_place = not t_td_result and "" or placeNum[t_td_result]
	local t_td = (ind.td[name] and ind.td[name].score) and addCommas(ind.td[name].score)..'-'..t_td_place or 0

	local t_victim_result = findPlace(name, "victim")
	local t_victim_place = not t_victim_result and "" or placeNum[t_victim_result]
	local t_victim = (ind.victim[name] and ind.victim[name].score) and addCommas(ind.victim[name].score)..'-'..t_victim_place or 0

	local t_whiff_result = findPlace(name, "whiff")
	local t_whiff_place = not t_whiff_result and "" or placeNum[t_whiff_result]
	local t_whiff = (ind.whiff[name] and ind.whiff[name].score) and addCommas(ind.whiff[name].score)..'-'..t_whiff_place or 0

	local t_ws_result = findPlace(name, "ws")
	local t_ws_place = not t_ws_result and "" or placeNum[t_ws_result]
	local t_ws = (ind.ws[name] and ind.ws[name].score) and addCommas(ind.ws[name].score)..'-'..t_ws_place or 0

	if t_buff == 0 and t_cure == 0 and t_death == 0 and t_hs == "none" and t_kill == 0 and t_ls == "none" and t_mb == "none" and t_melee == 0  and t_murder == 0 and t_nuke == 0 and t_point == 0 and t_sc == "none" and t_debuff == 0 and t_victim == 0 and t_whiff == 0 and t_ws == 0 then
		text1 = 'No data for you yet.'
	else
		text1 = '(HiWS: '..t_hs..') (LoWS: '..t_ls..') (TotWS: '..t_ws..') (SC: '..t_sc..') (Whiff: '..t_whiff..') (Melee: '..t_melee..')'
		text2 = '(RA: '..t_ra..') (Nuke: '..t_nuke..') (MB: '..t_mb..') (Cure: '..t_cure..') (Buff: '..t_buff..') (Debuff: '..t_debuff..')'
		text3 = '(Kill: '..t_kill..') (Death: '..t_death..') (Murder: '..t_murder..') (Victim: '..t_victim..') (TotDMG: '..t_td..') (Point: '..t_point..')'
	end
	newChatMessage('/t '..name..' '..text1)
	if text2 ~= '' then
		newChatMessage('/t '..name..' '..text2)
	end
	if text3 ~= '' then
		newChatMessage('/t '..name..' '..text3)
	end
end


--Handle a new chat message
function newChatMessage(str)
	
	--If the releaseValve is open, send the new chat message straight to chat and close the valve
	if releaseValveOpen then
		say(str)
		releaseValveOpen = false
		coroutine.sleep(1.5)
		checkChatBuffer()
	
	--If the releaseValve is closed, add the new chat message to the chatBuffer
	else
    	table.insert(chatBuffer, str)
	end
end


--Check the chatBuffer for messages
function checkChatBuffer()
    
	--If the chatBuffer has messages in it, send them to chat then remove them, then check again after a short wait
	if #chatBuffer > 0 then
        local message = chatBuffer[1]
        say(message)
        table.remove(chatBuffer, 1)
		coroutine.sleep(1.5)
		checkChatBuffer()
	
	--If there are no more messages in the chatBuffer, open the releaseValve back up for new messages
	else
		releaseValveOpen = true
	end
end


--Check if an action message is one we want to do A Thing with
local function checkForMessage(tbl, value)
	for _, v in ipairs(tbl) do
		if v == value then
			return true
		end
	end
	return false
end


local function giveItem()
	--Select a random player from the list of players who have points	
	local player = selectPlayerForItem()
	local playerIsTrust
	if player then
		playerIsTrust = windower.ffxi.get_mob_by_name(capitalize(player)).is_npc
	else
		return
	end

	--Determine what place they are in on the points board
	local place = findPlace(player, "point")
	if place == false then
		return
	end

	--Select an appropriate item for them
	local item = selectItem(place)
	if item == false then
		return
	end
	local itemName = settings.item[item].name

	live.items[player] = item
	live:save('all')

	if player == self_name then
		add_to_chat(8,('[Leaderboard] '):color(220)..('Item Box! You receive '..settings.item[item].indart..' '..itemName..'! Type '):color(8)..('//lb item'):color(1)..(' to use, or '):color(8)..('//lb info'):color(1)..(' for a description.'):color(8))
	elseif playerIsTrust then --If the recipient is a trust, use the item after a random amount of time (ITS AI!)
		add_to_chat(8,('[Leaderboard] '):color(220)..('Item Box! '..capitalize(player)..' received '..settings.item[item].indart..' '..itemName..'!'):color(8))
		coroutine.sleep(math.random(settings.kart_trust_item_time_min, settings.kart_trust_item_time_max))
		if isPlayerInAlliance(player) then
			if settings.mode == "Mog Kart" and live.items[player] then
				useItem(player)
			end
		else
			live.items[player] = nil
			live:save('all')
		end
	else
		newChatMessage("/t "..player.." [LB] Item Box! You receive "..settings.item[item].indart.." "..itemName.."! Reply with `item` to use, or `info` for a description.")
	end

end


--Select a Player to give an item
local function selectPlayerForItem()

	local names = {}

	for name, _ in pairs(live.individuals.point) do
		--Do not include a player that already has an item, has an item effect active, or is no longer in the party/alliance
		if not live.items[name] and not effects[name] and isPlayerInAlliance(name) then
        	table.insert(names, name) --Add each name to the names table
		end
    end

	if #names == 0 then
		return false
	end

	local randomIndex = math.random(1, #names) --Generate a random index
    local selectedName = names[randomIndex] --Use the index number to select a name from the names table

	return selectedName --Return the name

end


--Select a random player
local function selectRandomPlayer(itemUser)
	local names = {}

	for name, _ in pairs(live.individuals.point) do
 		--Do not include the player that used the item or who is no longer in the party/alliance
		if name ~= itemUser and isPlayerInAlliance(name) then
        	table.insert(names, name) --Add each name to the names table
		end
    end

	if #names == 0 then
		return false
	end

	local randomIndex = math.random(1, #names) --Generate a random index
    local selectedName = names[randomIndex] --Use the index number to select a name from the names table

	return selectedName -- Return the name

end


--Find the place a player is in on a given board
function findPlace(name, board)

	local placeLookup = {first = 1, second = 2, third = 3, fourth = 4, fifth = 5, sixth = 6, seventh = 7, eighth = 8, ninth = 9, tenth = 10, eleventh = 11, twelfth = 12, thirteenth = 13, fourteenth = 14, fifteenth = 15, sixteenth = 16, seventeenth = 17, eighteenth = 18}

	--Match the selected name to the names on the points board
    for place, data in pairs(live.places[board]) do
        if data.name == name then
            return placeLookup[place]
        end
    end

	--If no match, return false
    return false

end


--Check if the given player is in the last place on the points board
local function isLastPlace(name)
	local placeNames = {"first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth", "thirteenth", "fourteenth", "fifteenth", "sixteenth", "seventeenth", "eighteenth"}

	local playerPlace = findPlace(name, "point")
	local nextPlace = playerPlace +1
	local placeName = placeNames[nextPlace]

	if live.places.point[placeName] then
		return false
	else
		return true
	end
end


--Find the name of the player in a given place on the Point board
local function findTargetName(targetPlace)

	local placeNames = {"first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth", "thirteenth", "fourteenth", "fifteenth", "sixteenth", "seventeenth", "eighteenth"}

	--Check if targetPlace is within the valid range
	if targetPlace >= 1 and targetPlace <= #placeNames then

		local placeName = placeNames[targetPlace]
		
		--Check if the place exists in the table
		if live.places.point[placeName] then
			return live.places.point[placeName].name
		else
			return false
		end

	else
		return false
	end

end


--Select a random item based on the place
local function selectItem(place)

	local eligibleItems = {}

	--Iterate through items and select eligible ones based on the criteria
	for item, info in pairs(settings.item) do
		if place >= info.placeHi and place <= info.placeLo and info.available then
			table.insert(eligibleItems, item)
		end
	end

	--Select a random item from the eligible list
	if #eligibleItems > 0 then
		local randomIndex = math.random(1, #eligibleItems)
		return eligibleItems[randomIndex]

	else
		return false
	end

end


--Check that the given player in currently in the party/alliance
local function isPlayerInAlliance(player)

	local ally_pos = {
		'p0', 'p1', 'p2', 'p3', 'p4', 'p5', 'a10', 'a11', 'a12', 'a13', 'a14', 'a15', 'a20', 'a21', 'a22', 'a23', 'a24', 'a25'
	}
	--Loop through the alliance members to see if the indicated player is in the alliance
	for i = 1, 18, 1 do
		local ally_member = get_mob_by_target(ally_pos[i]) or nil
		if ally_member and ally_member.name == capitalize(player) then
			-- If there is a match, return true
			return true
		end
	end
	--If not, return false
	return false
end


--Use an item
local function useItem(name, specifiedTarget)

	local points = live.individuals.point
	local playerPlace = findPlace(name, "point")


	--Banana
	if live.items[name] == "banana" then

		local banana = settings.item.banana

		newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' puts down '..banana.indart..' '..banana.name..'... Watch your feet!')

		live.items[name] = nil
		live:save('all')

		coroutine.sleep(math.random(banana.timeMin, banana.timeMax)) --wait a random amount of time

		local targetName = selectRandomPlayer(name) --select a random target
		local targetPlace = findPlace(targetName, "point")
		local updatedPlayerPlace = findPlace(name, "point")

		if targetName then
			if effects[targetName] and (effects[targetName].active == "bullet_bill" or effects[targetName].active == "super_star") then
				newChatMessage('/p [LB] '..targetPlace..'|'..capitalize(targetName)..' steps on '..updatedPlayerPlace..'|'..capitalize(name)..'\'s '..banana.name..'! (Invincible!)')
			else
				local lostPoints = math.floor(points[targetName].score * (banana.points / 100))
				points[targetName].score = points[targetName].score - lostPoints
				newChatMessage('/p [LB] '..targetPlace..'|'..capitalize(targetName)..' steps on '..updatedPlayerPlace..'|'..capitalize(name)..'\'s '..banana.name..'! (-'..addCommas(lostPoints)..')')
			end
		end


	--Blue Shell
	elseif live.items[name] == "blue_shell" then

		local blue_shell = settings.item.blue_shell
		local super_horn = settings.item.super_horn

		local targetPlace = 1
		local targetName = findTargetName(targetPlace)

		--If you have since moved into first place, target the second place player instead
		if targetName == name then
			targetPlace = 2
			targetName = findTargetName(targetPlace)
		end

		newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' starts casting '..blue_shell.name..' on '..targetPlace..'|'..capitalize(targetName)..'... 10 seconds to impact!')

		live.items[name] = nil
		live:save('all')

		coroutine.sleep(10) --wait a 10 second casting time

		local updatedPlayerPlace = findPlace(name, "point")

		if effects[targetName] and (effects[targetName].active == "bullet_bill" or effects[targetName].active == "super_star") then
			newChatMessage('/p [LB] '..targetPlace..'|'..capitalize(targetName)..' is hit with '..updatedPlayerPlace..'|'..capitalize(name)..'\'s '..blue_shell.name..'! (Invincible!)')
		elseif effects[targetName] and effects[targetName].active == "super_horn" then
			newChatMessage('/p [LB] '..targetPlace..'|'..capitalize(targetName)..' avoids '..updatedPlayerPlace..'|'..capitalize(name)..'\'s '..blue_shell.name..' with their '..super_horn.name..'!')
		elseif (math.random(1, 100) <= blue_shell.accuracy) then
			local lostPoints = math.floor(points[targetName].score * (blue_shell.points / 100))
			points[targetName].score = points[targetName].score - lostPoints
			newChatMessage('/p [LB] '..targetPlace..'|'..capitalize(targetName)..' is hit with '..updatedPlayerPlace..'|'..capitalize(name)..'\'s '..blue_shell.name..'! (-'..addCommas(lostPoints)..')')
		else
			newChatMessage('/p [LB] '..targetPlace..'|'..capitalize(targetName)..' resists '..updatedPlayerPlace..'|'..capitalize(name)..'\'s '..blue_shell.name..'!')
		end


	--Bob-omb
	elseif live.items[name] == "bobomb" then

		local bobomb = settings.item.bobomb

		local target1Place
		local target2Place
		local target3Place
		
		if isLastPlace(name) then
			target1Place = playerPlace - 1 --if you're in last place,
			target2Place = playerPlace - 2 --target the 3 players ahead of you
			target3Place = playerPlace - 3
		else
			target1Place = playerPlace + 1 --if you're not in last place,
			target2Place = playerPlace + 2 --target the 3 players behind you
			target3Place = playerPlace + 3
		end
		
		local target1Name = findTargetName(target1Place)
		local target2Name = findTargetName(target2Place)
		local target3Name = findTargetName(target3Place)

		local targetTable = {}
		
		if target1Name and (math.random(1, 100) <= bobomb.accuracy) then
			if effects[target1Name] and (effects[target1Name].active == "bullet_bill" or effects[target1Name].active == "super_star") then
				table.insert(targetTable, target1Place..'|'..capitalize(target1Name)..'(Invincible!)')
			else
				local lostPoints = math.floor(points[target1Name].score * (bobomb.points / 100))
				points[target1Name].score = points[target1Name].score - lostPoints
				table.insert(targetTable, target1Place..'|'..capitalize(target1Name)..'(-'..addCommas(lostPoints)..')')
			end
		end
		if target2Name and (math.random(1, 100) <= bobomb.accuracy) then
			if effects[target2Name] and (effects[target2Name].active == "bullet_bill" or effects[target2Name].active == "super_star") then
				table.insert(targetTable, target2Place..'|'..capitalize(target2Name)..'(Invincible!)')
			else
				local lostPoints = math.floor(points[target2Name].score * (bobomb.points / 100))
				points[target2Name].score = points[target2Name].score - lostPoints
				table.insert(targetTable, target2Place..'|'..capitalize(target2Name)..'(-'..addCommas(lostPoints)..')')
			end
		end
		if target3Name and (math.random(1, 100) <= bobomb.accuracy) then
			if effects[target3Name] and (effects[target3Name].active == "bullet_bill" or effects[target3Name].active == "super_star") then
				table.insert(targetTable, target3Place..'|'..capitalize(target3Name)..'(Invincible!)')
			else
				local lostPoints = math.floor(points[target3Name].score * (bobomb.points / 100))
				points[target3Name].score = points[target3Name].score - lostPoints
				table.insert(targetTable, target3Place..'|'..capitalize(target3Name)..'(-'..addCommas(lostPoints)..')')
			end
		end

		local targets = ""
		local count = #targetTable
	
		for i, target in ipairs(targetTable) do
			if i == count and count > 1 then
				targets = targets.." and "..target
			else
				targets = targets .. target
				if i < count - 1 then
					targets = targets..", "
				end
			end
		end

		if count >= 1 then
			newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' throws '..bobomb.indart..' '..bobomb.name..' and hits '..targets..'!')
		else
			newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' throws '..bobomb.indart..' '..bobomb.name..' but hits nobody!')
		end

		live.items[name] = nil
		live:save('all')


	--Bullet Bill
	elseif live.items[name] == "bullet_bill" then
			
		--Give the player the effect of "bullet_bill" for the designated amount of time
		local bullet_bill = settings.item.bullet_bill

		newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' uses '..bullet_bill.indart..' '..bullet_bill.name..' and gains a '..addCommas(bullet_bill.points)..'% point boost for '..bullet_bill.time..' seconds!')

		effects[name] = {}
		effects[name].active = "bullet_bill"

		live.items[name] = nil
		live:save('all')

		coroutine.sleep(bullet_bill.time)

		local gainedPoints = effects[name].gainedPoints or 0
		local updatedPlayerPlace = findPlace(name, "point")

		newChatMessage('/p [LB] '..updatedPlayerPlace..'|'..capitalize(name)..'\'s '..bullet_bill.name..' effect wears off. (+'..addCommas(gainedPoints)..')')

		effects[name] = nil


	--Coin
	elseif live.items[name] == "coin" then

		local coin = settings.item.coin

		if (math.random(1, 100) <= coin.accuracy) then

			local placeBonus = 0
			if playerPlace > 3 then
				placeBonus = math.floor(points[name].score * ((playerPlace / 2) / 100))
			end
			local gainedPoints = math.floor(points[name].score * (math.random(coin.pointsLo, coin.pointsHi) / 100)) + placeBonus

			points[name].score = points[name].score + gainedPoints

			newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' uses '..coin.indart..' '..coin.name..'! (+'..addCommas(gainedPoints)..')')

		else
			newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' goes to use '..coin.indart..' '..coin.name..' but fumbles and drops it instead.')
		end

		live.items[name] = nil
		live:save('all')


	--Eft Bomb
	elseif live.items[name] == "eft_bomb" then

		local eft_bomb = settings.item.eft_bomb
		local targetName = false

		if specifiedTarget then
			targetName = string.lower(specifiedTarget)
		end

		if targetName then
			local targetPlace = findPlace(targetName, "point")

			if targetPlace and isPlayerInAlliance(targetName) then
				if (math.random(1, 100) <= eft_bomb.accuracy) and targetName ~= name then
					if effects[targetName] and (effects[targetName].active == "bullet_bill" or effects[targetName].active == "super_star") then
						newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' drops '..eft_bomb.indart..' '..eft_bomb.name..' on '..targetPlace..'|'..capitalize(targetName)..'! (Invincible!)')
					else
						local lostPoints = math.floor(points[targetName].score * (eft_bomb.points / 100))
						points[targetName].score = points[targetName].score - lostPoints
						newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' drops '..eft_bomb.indart..' '..eft_bomb.name..' on '..targetPlace..'|'..capitalize(targetName)..'! (-'..addCommas(lostPoints)..')')
					end
				else
					local lostPoints = math.floor(points[name].score * (eft_bomb.points / 100))
					points[name].score = points[name].score - lostPoints
					newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' tries to use '..eft_bomb.indart..' '..eft_bomb.name..' but it blows up in their face instead! (-'..addCommas(lostPoints)..')')
				end
				live.items[name] = nil
				live:save('all')
			else
				if name == self_name then
					add_to_chat(8,('[Leaderboard] '):color(220)..('The player `'..capitalize(targetName)..'` is not currently playing Mog Kart, please try again.'):color(8))
				else
					newChatMessage('/t '..name..' [LB] The player `'..capitalize(targetName)..'` is not currently playing Mog Kart, please try again.')
				end
			end
		else
			targetName = selectRandomPlayer(name)
			local targetPlace = findPlace(targetName, "point")
			if targetName and (math.random(1, 100) <= eft_bomb.accuracy) then
				if effects[targetName] and (effects[targetName].active == "bullet_bill" or effects[targetName].active == "super_star") then
					newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' drops '..eft_bomb.indart..' '..eft_bomb.name..' on '..targetPlace..'|'..capitalize(targetName)..'! (Invincible!)')
				else
					local lostPoints = math.floor(points[targetName].score * (eft_bomb.points / 100))
					points[targetName].score = points[targetName].score - lostPoints
					newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' drops '..eft_bomb.indart..' '..eft_bomb.name..' on '..targetPlace..'|'..capitalize(targetName)..'! (-'..addCommas(lostPoints)..')')
				end
			else
				newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' tries to use '..eft_bomb.indart..' '..eft_bomb.name..' but it\'s a dud.')
			end
			live.items[name] = nil
			live:save('all')
		end


	--Fire Flower
	elseif live.items[name] == "fire_flower" then

		local fire_flower = settings.item.fire_flower

		local target1Place = playerPlace - 1 --target the 3 players in front of you
		local target2Place = playerPlace - 2
		local target3Place = playerPlace - 3
		local target1Name = findTargetName(target1Place)
		local target2Name = findTargetName(target2Place)
		local target3Name = findTargetName(target3Place)

		local targetTable = {}
		
		if target1Name and (math.random(1, 100) <= fire_flower.accuracy) then
			if effects[target1Name] and (effects[target1Name].active == "bullet_bill" or effects[target1Name].active == "super_star") then
				table.insert(targetTable, target1Place..'|'..capitalize(target1Name)..'(Invincible!)')
			else
				local lostPoints = math.floor(points[target1Name].score * (fire_flower.points / 100))
				points[target1Name].score = points[target1Name].score - lostPoints
				table.insert(targetTable, target1Place..'|'..capitalize(target1Name)..'(-'..addCommas(lostPoints)..')')
			end
		end
		if target2Name and (math.random(1, 100) <= fire_flower.accuracy) then
			if effects[target2Name] and (effects[target2Name].active == "bullet_bill" or effects[target2Name].active == "super_star") then
				table.insert(targetTable, target2Place..'|'..capitalize(target2Name)..'(Invincible!)')
			else
				local lostPoints = math.floor(points[target2Name].score * (fire_flower.points / 100))
				points[target2Name].score = points[target2Name].score - lostPoints
				table.insert(targetTable, target2Place..'|'..capitalize(target2Name)..'(-'..addCommas(lostPoints)..')')
			end
		end
		if target3Name and (math.random(1, 100) <= fire_flower.accuracy) then
			if effects[target3Name] and (effects[target3Name].active == "bullet_bill" or effects[target3Name].active == "super_star") then
				table.insert(targetTable, target3Place..'|'..capitalize(target3Name)..'(Invincible!)')
			else
				local lostPoints = math.floor(points[target3Name].score * (fire_flower.points / 100))
				points[target3Name].score = points[target3Name].score - lostPoints
				table.insert(targetTable, target3Place..'|'..capitalize(target3Name)..'(-'..addCommas(lostPoints)..')')
			end
		end

		local targets = ""
		local count = #targetTable
	
		for i, target in ipairs(targetTable) do
			if i == count and count > 1 then
				targets = targets.." and "..target
			else
				targets = targets..target
				if i < count - 1 then
					targets = targets..", "
				end
			end
		end

		if count >= 1 then
			newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' uses '..fire_flower.indart..' '..fire_flower.name..' and hits '..targets..'!')
		else
			newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' uses '..fire_flower.indart..' '..fire_flower.name..' but hits nobody!')
		end

		live.items[name] = nil
		live:save('all')

		
	--Green Shell
	elseif live.items[name] == "green_shell" then

		local green_shell = settings.item.green_shell

		local target1Place = playerPlace - 1 --target the player in front of you
		local target2Place = playerPlace - 2 --if it misses the first target, it could hit the next player

		local target1Name = findTargetName(target1Place)
		local target2Name = findTargetName(target2Place)

		if target1Name then
			if (math.random(1, 100) <= green_shell.accuracy) then
				if effects[target1Name] and (effects[target1Name].active == "bullet_bill" or effects[target1Name].active == "super_star") then
					newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' hits '..target1Place..'|'..capitalize(target1Name)..' with '..green_shell.indart..' '..green_shell.name..'! (Invincible!)')
				else
					local lostPoints = math.floor(points[target1Name].score * (green_shell.points / 100))
					points[target1Name].score = points[target1Name].score - lostPoints
					newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' hits '..target1Place..'|'..capitalize(target1Name)..' with '..green_shell.indart..' '..green_shell.name..'! (-'..addCommas(lostPoints)..')')
				end
			elseif target2Name then
				if effects[target2Name] and (effects[target2Name].active == "bullet_bill" or effects[target2Name].active == "super_star") then
					newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' misses '..target1Place..'|'..capitalize(target1Name)..' and hits '..target2Place..'|'..capitalize(target2Name)..' with '..green_shell.indart..' '..green_shell.name..'! (Invincible!)')
				else
					local lostPoints = math.floor(points[target2Name].score * (green_shell.points / 100))
					points[target2Name].score = points[target2Name].score - lostPoints
					newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' misses '..target1Place..'|'..capitalize(target1Name)..' and hits '..target2Place..'|'..capitalize(target2Name)..' with '..green_shell.indart..' '..green_shell.name..'! (-'..addCommas(lostPoints)..')')
				end
			end
		else
			newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' uses '..green_shell.indart..' '..green_shell.name..' but hits nobody!')
		end

		live.items[name] = nil
		live:save('all')


	--Mushroom
	elseif live.items[name] == "mushroom" then
		
		--Give the player the effect of "mushroom" for the designated amount of time
		local mushroom = settings.item.mushroom

		newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' uses '..mushroom.indart..' '..mushroom.name..' and gains a '..addCommas(mushroom.points)..' point boost for '..mushroom.time..' seconds!')

		effects[name] = {}
		effects[name].active = "mushroom"

		live.items[name] = nil
		live:save('all')

		coroutine.sleep(mushroom.time)

		local gainedPoints = effects[name].gainedPoints or 0
		local updatedPlayerPlace = findPlace(name, "point")

		newChatMessage('/p [LB] '..updatedPlayerPlace..'|'..capitalize(name)..'\'s '..mushroom.name..' effect wears off. (+'..addCommas(gainedPoints)..')')

		effects[name] = nil


	--Red Shell
	elseif live.items[name] == "red_shell" then

		local red_shell = settings.item.red_shell

		local targetPlace = playerPlace - 1 --target the player in front of you
		local targetName = findTargetName(targetPlace)

		if targetName then
			if (math.random(1, 100) <= red_shell.accuracy) then
				if effects[targetName] and (effects[targetName].active == "bullet_bill" or effects[targetName].active == "super_star") then
					newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' hits '..targetPlace..'|'..capitalize(targetName)..' with '..red_shell.indart..' '..red_shell.name..'! (Invincible!)')
				else
					local lostPoints = math.floor(points[targetName].score * (red_shell.points / 100))
					points[targetName].score = points[targetName].score - lostPoints
					newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' hits '..targetPlace..'|'..capitalize(targetName)..' with '..red_shell.indart..' '..red_shell.name..'! (-'..addCommas(lostPoints)..')')
				end
			else
				newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' aims '..red_shell.indart..' '..red_shell.name..' at '..targetPlace..'|'..capitalize(targetName)..' but misses!')
			end
		else
			newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' uses '..red_shell.indart..' '..red_shell.name..' but hits nobody!')
		end

		live.items[name] = nil
		live:save('all')


	--Super Horn
	elseif live.items[name] == "super_horn" then

		local super_horn = settings.item.super_horn

		local target1Place = playerPlace - 1 --target the player in front of and behind you
		local target2Place = playerPlace + 1
		local target1Name = findTargetName(target1Place)
		local target2Name = findTargetName(target2Place)
		local targetTable = {}
		
		if target1Name and (math.random(1, 100) <= super_horn.accuracy) then
			if effects[target1Name] and (effects[target1Name].active == "bullet_bill" or effects[target1Name].active == "super_star") then
				table.insert(targetTable, target1Place..'|'..capitalize(target1Name)..'(Invincible)')
			else
				local lostPoints = math.floor(points[target1Name].score * (super_horn.points / 100))
				points[target1Name].score = points[target1Name].score - lostPoints
				table.insert(targetTable, target1Place..'|'..capitalize(target1Name)..'(-'..addCommas(lostPoints)..')')
			end
		end
		if target2Name and (math.random(1, 100) <= super_horn.accuracy) then
			if effects[target2Name] and (effects[target2Name].active == "bullet_bill" or effects[target2Name].active == "super_star") then
				table.insert(targetTable, target2Place..'|'..capitalize(target2Name)..'(Invincible)')
			else
				local lostPoints = math.floor(points[target2Name].score * (super_horn.points / 100))
				points[target2Name].score = points[target2Name].score - lostPoints
				table.insert(targetTable, target2Place..'|'..capitalize(target2Name)..'(-'..addCommas(lostPoints)..')')
			end
		end

		local targets = ""
		local count = #targetTable

		if count == 1 then
			targets = targetTable[1]
		elseif count >= 2 then
			targets = targetTable[1].." and "..targetTable[2]
		end

		if count >= 1 then
			newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' uses '..super_horn.indart..' '..super_horn.name..' and hits '..targets..'!')
		else
			newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' uses '..super_horn.indart..' '..super_horn.name..' but hits nobody!')
		end

		live.items[name] = nil
		live:save('all')

		effects[name] = {}
		effects[name].active = "super_horn"

		coroutine.sleep(super_horn.time)

		effects[name] = nil


	--Super Star
	elseif live.items[name] == "super_star" then
			
		--Give the player the effect of "super_star" for the designated amount of time
		local super_star = settings.item.super_star

		newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..' uses '..super_star.indart..' '..super_star.name..' and gains a '..addCommas(super_star.points)..'% point boost for '..super_star.time..' seconds!')

		effects[name] = {}
		effects[name].active = "super_star"

		live.items[name] = nil
		live:save('all')

		coroutine.sleep(super_star.time)

		local gainedPoints = effects[name].gainedPoints or 0
		local updatedPlayerPlace = findPlace(name, "point")

		newChatMessage('/p [LB] '..playerPlace..'|'..capitalize(name)..'\'s '..super_star.name..' effect wears off. (+'..addCommas(gainedPoints)..')')

		effects[name] = nil


	else
		return
	end

end


local function informItem(name)

	if live.items[name] then
		if name == self_name then
			add_to_chat(8,('[Leaderboard] '):color(220)..(settings.item[live.items[name]].name..': '..settings.item[live.items[name]].description):color(8))
		else
			newChatMessage("/t "..name.." [LB] "..settings.item[live.items[name]].name..": "..settings.item[live.items[name]].description)
		end
	else
		if name == self_name then
			add_to_chat(8,('[Leaderboard] '):color(220)..('You have no items available to use. '):color(8))
		else
			newChatMessage('/t '..name..' [LB] You have no items available to use.')
		end
	end

end


--Reset boards
local function resetB()
	live.individuals.buff = {}
	live.places.buff = {}
end
local function resetC()
	live.individuals.cure = {}
	live.places.cure = {}
end
local function resetD()
	live.individuals.death = {}
	live.places.death = {}
end
local function resetDB()
	live.individuals.debuff = {}
	live.places.debuff = {}
end
local function resetHS()
	live.individuals.hs = {}
	live.places.hs = {}
end
local function resetI()
	live.items = {}
end
local function resetK()
	live.individuals.kill = {}
	live.places.kill = {}
end
local function resetLS()
	live.individuals.ls = {}
	live.places.ls = {}
end
local function resetMB()
	live.individuals.mb = {}
	live.places.mb = {}
end
local function resetML()
	live.individuals.melee = {}
	live.places.melee = {}
end
local function resetM()
	live.individuals.murder = {}
	live.places.murder = {}
end
local function resetN()
	live.individuals.nuke = {}
	live.places.nuke = {}
end
local function resetP()
	live.individuals.point = {}
	live.places.point = {}
end
local function resetRA()
	live.individuals.ra = {}
	live.places.ra = {}
end
local function resetSC()
	live.individuals.sc = {}
	live.places.sc = {}
end
local function resetTD()
	live.individuals.td = {}
	live.places.td = {}
end
local function resetV()
	live.individuals.victim = {}
	live.places.victim = {}
end
local function resetW()
	live.individuals.whiff = {}
	live.places.whiff = {}
end
local function resetWS()
	live.individuals.ws = {}
	live.places.ws = {}
end
local function resetALL()
	resetB()
	resetC()
	resetD()
	resetDB()
	resetHS()
	resetI()
	resetK()
	resetLS()
	resetM()
	resetML()
	resetMB()
	resetN()
	resetP()
	resetRA()
	resetSC()
	resetTD()
	resetV()
	resetW()
	resetWS()
	live.index = 0
end


--Incoming chat message - NOTE: these are checking incoming packets, messages originating from yourself will not trigger them
--(tells work though because they go out to the server first then back to you as the receiver)
register_event('chat message', function(message, sender, mode)

	local l_name = string.lower(sender)

	--Ignore if the message sender sent another command within the
	--flood_delay timeframe, and limit to tells(3) and party chat(4)
	if flood_delay[l_name] or not (mode == 3 or mode == 4) then
		return
	end


	--Send a score update to the message sender
	if message:lower():match("^report") and mode == 3 then
		reportPlayerScores(l_name)
		return

	--Add/remove the message sender to the Optout list
	elseif message:lower():match("^optout") and mode == 3 then
		if settings.optout[l_name] then
			removeFromOptout(l_name)
			newChatMessage('/t '..sender..' [LB] You have been removed from the Optout list.')
		else
			addToOptout(l_name)
			newChatMessage('/t '..sender..' [LB] You have been added to the Optout list. Any related data has been deleted.')
		end
		return
	end


	--Party Commands
	if settings.party_commands and settings.mode ~= 'Silent' then

		--BUFF BOARD
		elseif (message:lower():match("^lb b") or message:lower():match("^lbb")) then
			cmd('lb b')

		--CURE BOARD
		if (message:lower():match("^lb c") or message:lower():match("^lbc")) then
			cmd('lb c')

		--DEATH BOARD
		elseif (message:lower():match("^lb d") or message:lower():match("^lbd")) then
			cmd('lb d')

		--DEBUFF BOARD
		elseif (message:lower():match("^lb db") or message:lower():match("^lbdb")) then
			cmd('lb db')

		--HIGH WS BOARD
		elseif (message:lower():match("^lb hs") or message:lower():match("^lbhs")) then
			cmd('lb hs')

		--KILL BOARD
		elseif (message:lower():match("^lb k") or message:lower():match("^lbk")) then
			cmd('lb k')

		--LOW WS BOARD
		elseif (message:lower():match("^lb ls") or message:lower():match("^lbls")) then
			cmd('lb ls')

		--MAGIC BURST BOARD
		elseif (message:lower():match("^lb mb") or message:lower():match("^lbmb")) then
			cmd('lb mb')

		--MELEE BOARD
		elseif (message:lower():match("^lb ml") or message:lower():match("^lbml")) then
			cmd('lb ml')

		--MURDER BOARD
		elseif (message:lower():match("^lb m") or message:lower():match("^lbm")) then
			cmd('lb m')

		--NUKE BOARD
		elseif (message:lower():match("^lb n") or message:lower():match("^lbn")) then
			cmd('lb n')

		--POINT BOARD
		elseif (message:lower():match("^lb p") or message:lower():match("^lbp")) then
			cmd('lb p')

		--RANGED ATT BOARD
		elseif (message:lower():match("^lb ra") or message:lower():match("^lra")) then
			cmd('lb ra')

		--SKILLCHAIN BOARD
		elseif (message:lower():match("^lb sc") or message:lower():match("^lbsc")) then
			cmd('lb sc')

		--TOTAL DAMAGE BOARD
		elseif (message:lower():match("^lb td") or message:lower():match("^lbtd")) then
			cmd('lb td')

		--VICTIM BOARD
		elseif (message:lower():match("^lb v") or message:lower():match("^lbv")) then
			cmd('lb v')

		--TOTAL WS BOARD
		elseif (message:lower():match("^lb ws") or message:lower():match("^lbws")) then
			cmd('lb ws')

		--WHIFF BOARD
		elseif (message:lower():match("^lb w") or message:lower():match("^lbw")) then
			cmd('lb w')

		--Unknown command
		elseif message:lower():match("^lb") then
			newChatMessage('/t '..sender..' [LB] Unknown command. Valid cammands are: \'lb b/c/d/db/hs/k/ls/m/mb/n/p/ra/sc/v/ws/w/report/optout\'')

		end
	end

	--Mog Kart Mode commands (limited to tells(3))
	if settings.mode == 'Mog Kart' and mode == 3 then

		--Use an item
		if message:lower():match("^item") then
			if live.items[l_name] then
				local extractedName = string.match(message, "item%s+(%S+)")
				useItem(l_name, extractedName)
			else
				newChatMessage('/t '..sender..' [LB] You have no items available to use.')
			end

		--Get information on item
		elseif message:lower():match("^info") then
			informItem(l_name)
		end

	end

	--Add the sender to the flood_delay table for a set amount of time, then remove them
	flood_delay[l_name] = true
	coroutine.sleep(settings.flood_delay)
	flood_delay[l_name] = nil

end)


register_event('incoming chunk', function(id, original, modified, injected, blocked)
	if id == 0x029 and not live.paused then

		local packet = packets.parse('incoming', original)
		local target = getTarget(packet['Target'])
		local target_name = target and target.name or '[REDACTED]'
		local target_lower_name = target and string.lower(target.name) or '[REDACTED]'
		local actor = getActor(packet['Actor'])
		local actor_name = actor and actor.name or '[REDACTED]'
		local actor_lower_name = actor and string.lower(actor.name) or '[REDACTED]'

		--A monster is killed
		if packet['Message'] == 6 then

			----------
			-- KILL -- Actor: does the killing, Target: was killed
			----------

			--Make sure the actor is part of the party/alliance
			if actor == false then
				return
			end

			--Make sure the actor is not on the Optout list
			if settings.optout[actor_lower_name] then
				return
			end

			local killIndividuals = live.individuals.kill

			--Retrieve the actors relevant data
			local kills = (killIndividuals[actor_lower_name] and killIndividuals[actor_lower_name].score) or 0
			local index = live.index
			
			--Update the actors score information
			kills = kills +1
			killIndividuals[actor_lower_name] = {score = kills, nines = 0, index = index}
			
			--Update the leaderboard places
			updateBoard("kill")
			live:save('all')
			if box_display == 'kill' then
				updateBox(box_display)
			end

			--Call out Kills, depending on the mode and how many Kills they are at
			if (settings.mode == "Party" or settings.mode == "Raid") and settings.party_calls.kill then
				local everyNumKills = kills % 10 --returns the remainder after euclidean division (division by subtraction)
				if everyNumKills == 0 then --if that leftover number equals 0, then the number is a multiple of Num
					newChatMessage('/p [KILL] '..actor_name..' has racked up '..addCommas(kills)..' kills!')
				end
			end

		--A player is killed
		elseif packet['Message'] == 97 then

			--The killer was a monster
			if actor == false then

				-----------
				-- DEATH -- Actor: does the killing, Target: was killed
				-----------

				--Make sure the target is part of the party/alliance
				if target == false then
					return
				end

				--Make sure the target is not on the Optout list
				if settings.optout[target_lower_name] then
					return
				end

				local deathPlaces = live.places.death
				local deathIndividuals = live.individuals.death

				--Retrieve the targets relevant data
				local deaths = (deathIndividuals[target_lower_name] and deathIndividuals[target_lower_name].score) or 0
				local index = live.index

				--Update the targets score information
				deaths = deaths +1
				deathIndividuals[target_lower_name] = {score = deaths, nines = 0, index = index}

				--Update the targets points
				local points = live.individuals.point
				local name = target_lower_name
				local pct_loss = 100 - settings.pctloss.death
				if points[name] and points[name].score then
					points[name].score = math.floor(points[name].score * (pct_loss / 100))
				end

				--Update the leaderboard places
				updateBoard("death")
				live:save('all')
				if box_display == 'death' then
					updateBox(box_display)
				end

				local amount_lost = math.floor(((points[name] and points[name].score) or 0) * (settings.pctloss.death / 100))

				--Call out Deaths, depending on the mode and how many Deaths they are at
				if settings.mode ~= "Silent" and settings.party_calls.death then
					if deaths == 1 and target_lower_name == deathPlaces.first.name then
						newChatMessage('/p [DEATH] '..target_name..(' is the first to die!%s'):format(settings.mode == "Mog Kart" and ' (-'..addCommas(amount_lost)..')' or ''))
					elseif deaths == 1 then
						newChatMessage('/p [DEATH] '..target_name..(' has their first death!%s'):format(settings.mode == "Mog Kart" and ' (-'..addCommas(amount_lost)..')' or ''))
					elseif settings.mode == "Mog Kart" then
						newChatMessage('/p [DEATH] '..target_name..' has died again... (-'..addCommas(amount_lost)..')')
					elseif deaths < 10 and settings.mode == "Party" then
						newChatMessage('/p [DEATH] '..target_name..(' has died %s'):format(deaths < 5 and '' or 'yet ')..'again...')
					else
						local everyNumDeaths = deaths % 5 --returns the remainder after euclidean division (division by subtraction)
						if everyNumDeaths == 0 then --if that leftover number equals 0, then the number is a multiple of Num
							newChatMessage('/p [DEATH] '..target_name..' is up to '..addCommas(deaths)..' deaths!')
						end
					end
				end

			--The killer was a player
			else

				-------------------
				-- MURDER/VICTIM -- Actor: does the killing, Target: was killed
				-------------------

				--Make sure the actor and target are part of the party/alliance
				if actor == false or target == false then
					return
				end

				local points_transfered = 0

				--Make sure the actor (Murderer) is not on the Optout list
				if not settings.optout[actor_lower_name] then

					local murderPlaces = live.places.murder
					local murderIndividuals = live.individuals.murder

					--Retrieve the actors relevant data
					local murders = (murderIndividuals[actor_lower_name] and murderIndividuals[actor_lower_name].score) or 0
					local index = live.index

					--Update the actors score information
					murders = murders +1
					murderIndividuals[actor_lower_name] = {score = murders, nines = 0, index = index}

					--Update the actors points
					local points = live.individuals.point
					local murderer = actor_lower_name
					local pct_loss = 100 - settings.pctloss.death
					if points[murderer] and points[murderer].score then
						points_transfered = math.floor(points[murderer].score * (settings.pctloss.death / 100)) --Points taken from the Murderer to give to the Victim
						points[murderer].score = math.floor(points[murderer].score * (pct_loss / 100))
					end

					--Update the leaderboard places
					updateBoard("murder")
					live:save('all')
					if box_display == 'murder' then
						updateBox(box_display)
					end

				end

				--Make sure the target (Victim) is not on the Optout list
				if not settings.optout[target_lower_name] then

					local victimIndividuals = live.individuals.victim

					--Retrieve the targets relevant data
					local victims = (victimIndividuals[target_lower_name] and victimIndividuals[target_lower_name].score) or 0
					local index = live.index

					--Update the targets score information
					victims = victims +1
					victimIndividuals[target_lower_name] = {score = victims, nines = 0, index = index}

					--Update the targets points
					local points = live.individuals.point
					local victim = target_lower_name
					local pct_loss = 100 - settings.pctloss.death
					if points[victim] and points[victim].score then
						points[victim].score = points[victim].score + points_transfered --Points taken from the Murderer and given to the Victim
					else
						points[victim].score = points_transfered
					end

					--Update the leaderboard places
					updateBoard("victim")
					live:save('all')
					if box_display == 'victim' then
						updateBox(box_display)
					end

				end

				--Call out Murders/Victims
				if settings.mode ~= "Silent" and settings.party_calls.murder then
					if not settings.optout[actor_lower_name] and not settings.optout[target_lower_name] then
						newChatMessage('/p [MURDER/VICTIM] '..actor_name..(' has %s'):format((murders == 1 and actor_lower_name == murderPlaces.first.name) and 'drawn First Blood and ' or '')..'sacrificed '..target_name..(' to Altana!%s'):format(settings.mode == "Mog Kart" and ' ('..addCommas(points_transfered)..' transferred)' or ''))
					elseif not settings.optout[actor_lower_name] then
						newChatMessage('/p [MURDER/VICTIM] '..actor_name..(' has %s'):format((murders == 1 and actor_lower_name == murderPlaces.first.name) and 'drawn First Blood and ' or '')..('sacrificed a victim to Altana!'):format(settings.mode == "Mog Kart" and ' (-'..addCommas(points_transfered)..')' or ''))
					elseif not settings.optout[target_lower_name] then
						newChatMessage('/p [MURDER/VICTIM] '..target_name..(' %s'):format((murders == 1 and actor_lower_name == murderPlaces.first.name) and 'is the first to be ' or 'has been ')..'sacrificed to Altana!')
					end
				end

			end
		end
	end
end)


register_event('action',function(act)

	-- local msg = act.targets[1].actions[1].message --duplicate
	-- if act.category == 1 then
		-- print(get_mob_by_id(act.actor_id).name.." - category: "..act.category.." a.t.a.param: "..act.targets[1].actions[1].param.." message: "..msg.." target: "..get_mob_by_id(act.targets[1].id).name..' add_e_e: '..act.targets[1].actions[1].add_effect_effect..' add_e_p: '..act.targets[1].actions[1].add_effect_param..' s_e_message: '..act.targets[1].actions[1].add_effect_message)
	-- end

	local actor = getActor(act.actor_id)

	local myName = get_mob_by_target('me').name
	local actor_name = actor and actor.name or '[REDACTED]'
	local actor_lower_name = actor and string.lower(actor.name) or '[REDACTED]'
	local target = act.targets[1].id or false
	local target_name = target and get_mob_by_id(target) and get_mob_by_id(target).name or '[REDACTED]'
	local msg = act.targets[1].actions[1].message

	local direct_damage = {
		1, 2, 15, 63, 67, 77, 110, 157, 163, 185, 188, 252, 317, 352, 353, 379, 413, 522, 576, 577, 648, 650
	}
	local spike_damage = {
		33, 44, 132, 536
	}

	local spike = 0
	--Was the target of the initial melee attack a member of our alliance?
	if getActor(target) then
		for i = 1, act.targets[1].action_count do
			local spike_e_msg = act.targets[1].actions[i].spike_effect_message
			local spike_e_param = act.targets[1].actions[i].spike_effect_param
			if checkForMessage(spike_damage, spike_e_msg) and spike_e_param ~= 0 then
				spike = spike + spike_e_param
			end
		end
	end

	if checkForMessage(direct_damage, msg) or spike ~= 0 then

		---------------
		-- TOTAL DMG --
		---------------

		if spike ~= 0 then
			actor_name = target_name
			actor_lower_name = string.lower(actor_name)
		end

		if (actor == false and spike == 0) or settings.optout[actor_lower_name] or (actor_name == '[REDACTED]' and actor) then
			return
		end

		local tdIndividuals = live.individuals.td

		--What are you and your Rivals original scores
		local myOriginalTDScore = (tdIndividuals and tdIndividuals[string.lower(myName)] and tdIndividuals[string.lower(myName)].score) or 0
		local rivalOriginalTDScore = (tdIndividuals and tdIndividuals[settings.rival] and tdIndividuals[settings.rival].score) or 0

		--Retrieve the actors relevant data
		local tot_dmg = (tdIndividuals[actor_lower_name] and tdIndividuals[actor_lower_name].score) or 0
		local index = (tdIndividuals[actor_lower_name] and tdIndividuals[actor_lower_name].index) or 0

		--Update the actors score information
		local sum = 0
		for i = 1, act.target_count do
			for j = 1, act.targets[i].action_count do
				local spike_e_msg = act.targets[i].actions[j].spike_effect_message
				if not checkForMessage(spike_damage, spike_e_msg) then
					sum = sum + act.targets[i].actions[j].param
					sum = sum + act.targets[i].actions[j].add_effect_param
				end
			end
		end

		tot_dmg = tot_dmg + sum + spike
		local everyNumTDs = math.floor(tot_dmg / 250000) --returns how many times 250,000 goes into tot_dmg
		local points = everyNumTDs * 250000 --returns the multiple of 250,000 that tot_dmg is over
		tdIndividuals[actor_lower_name] = {score = tot_dmg, nines = 0, index = everyNumTDs}

		--Update the leaderboard places
		updateBoard("td")
		live:save('all')
		if box_display == 'td' then
			updateBox(box_display)
		end

		--Call out Total Damage
		if (settings.mode == "Party" or settings.mode == "Raid") and settings.party_calls.td then
			if everyNumTDs > index then

				--Party Mode under 1m in WSs: call it out every 250k
				if everyNumTDs < 5 and settings.mode == 'Party' then
					newChatMessage('/p [TOTAL DMG] '..actor_name..' has done over '..addCommas(points)..' total damage!')

				--Party Mode over 1m in WSs, or Raid Mode: call it out every 500k
				elseif everyNumTDs < 21 then
					local everyOtherNum = everyNumTDs % 2 --returns the remainder after euclidean division (division by subtraction)
					if everyOtherNum == 0 then --if that leftover number equals 0, then the number is a multiple of 2 (2x250k = every 500k)
						newChatMessage('/p [TOTAL DMG] '..actor_name..' has done over '..addCommas(points)..' total damage!')
					end

				--Party/Raid Mode over 5m in WSs: call it out every 1m
				else
					local everyOtherNum = everyNumTDs % 4 --returns the remainder after euclidean division (division by subtraction)
					if everyOtherNum == 0 then --if that leftover number equals 0, then the number is a multiple of 4 (4x250k = every 1m)
						newChatMessage('/p [TOTAL DMG] '..actor_name..' has done over '..addCommas(points)..' total damage!')
					end

				end
			end
		end

		--Did you or your rival beat the other
		if settings.rival ~= "" then
			if actor_name == myName then
				if (rivalOriginalTDScore > myOriginalTDScore) and (tot_dmg > rivalOriginalTDScore) then
					add_to_chat(8,('[Leaderboard] '):color(220)..('You\'re now beating '..capitalize(settings.rival)..'\'s '..addCommas(rivalOriginalTDScore)..' score with '):color(6)..(addCommas(tot_dmg)..' TOTAL DMG.'):color(158))
				end
			elseif actor_name == capitalize(settings.rival) then
				if (myOriginalTDScore > rivalOriginalTDScore) and (tot_dmg > myOriginalTDScore) then
					add_to_chat(8,('[Leaderboard] '):color(220)..(capitalize(settings.rival)..' is now beating your '..addCommas(myOriginalTDScore)..' score with '):color(28)..(addCommas(tot_dmg)..' TOTAL DMG.'):color(167))
				end
			end
		end

	end

	local counter = 0
	--Was the target of the initial melee attack a member of our alliance?
	if getActor(target) then
		for i = 1, act.targets[1].action_count do
			local spike_e_msg = act.targets[1].actions[i].spike_effect_message
			local spike_e_param = act.targets[1].actions[i].spike_effect_param
			--Was the initial melee attack countered (33) or retaliated (536)?
			if (spike_e_msg == 33 or spike_e_msg == 536) and spike_e_param ~= 0 then
				counter = counter + spike_e_param
			end
		end
	end

	if act.category == 1 and (msg == 1 or msg == 67 or counter ~= 0) and not live.paused then

		------------
		-- Melee --  Counters: Actor/Target are flipped - Actor is the original attacker, Target is the one doing the counter
		------------

		if counter ~= 0 then
			actor_name = target_name
			actor_lower_name = string.lower(actor_name)
		end

		if (actor == false and counter == 0) or settings.optout[actor_lower_name] or (actor_name == '[REDACTED]' and actor) then
			return
		end

		local meleeIndividuals = live.individuals.melee

		--Retrieve the actors relevant data
		local melees = (meleeIndividuals[actor_lower_name] and meleeIndividuals[actor_lower_name].score) or 0
		local index = (meleeIndividuals[actor_lower_name] and meleeIndividuals[actor_lower_name].index) or 0

		--Update the actors score information
		local meleeSum = 0
		local aeSum = 0
		for i = 1, act.targets[1].action_count do
			meleeSum = meleeSum + act.targets[1].actions[i].param
			aeSum = aeSum + act.targets[1].actions[i].add_effect_param
		end
		melees = melees + meleeSum + aeSum + counter
		local everyNumMelees = math.floor(melees / 250000) --returns how many times 250,000 goes into melees
		local points = everyNumMelees * 250000 --returns the multiple of 250,000 that melees is over
		meleeIndividuals[actor_lower_name] = {score = melees, nines = 0, index = everyNumMelees}

		--Update the leaderboard places
		updateBoard("melee")
		live:save('all')
		if box_display == 'melee' then
			updateBox(box_display)
		end

		--Call out Melee damage
		if (settings.mode == "Party" or settings.mode == "Raid") and settings.party_calls.melee then
			if everyNumMelees > index then

				--Party Mode under 1m melee damage: call it out every 250k
				if everyNumMelees < 5 and settings.mode == 'Party' then
					newChatMessage('/p [MELEE] '..actor_name..' has done over '..addCommas(points)..' in melee damage!')

				--Party Mode over 1m melee damage, or Raid Mode: call it out every 500k
				else
					local everyOtherNum = everyNumMelees % 2 --returns the remainder after euclidean division (division by subtraction)
					if everyOtherNum == 0 then --if that leftover number equals 0, then the number is a multiple of 2
						newChatMessage('/p [MELEE] '..actor_name..' has done over '..addCommas(points)..' in melee damage!')
					end

				end
			end
		end
	end

	--Make sure the actor is part of the party/alliance and not on the Optout list
	--Do this after Melee since counters are initiated by the mobs we are attacking (Target not the Actor)
	if actor == false or settings.optout[actor_lower_name] then
		return
	end

	--A certain type of Spell, Ability, or Item is used that cures
	if ((act.category == 4 or act.category == 5 or act.category == 6 or act.category == 11 or act.category == 14) or (act.category == 13 and msg == 318)) and not live.paused then

		----------
		-- CURE --
		----------

		--Determine the actors relevant data
		local cureThing = ''
		if act.category == 4 then 
			cureThing = (spells[act.param] and spells[act.param].english) or '[REDACTED]'
		elseif act.category == 5 then
			cureThing = (mabils[act.param] and mabils[act.param].english) or '[REDACTED]'
		elseif act.category == 6 or act.category == 13 or act.category == 14 then
			cureThing = (jabils[act.param] and jabils[act.param].english) or '[REDACTED]'
		elseif act.category == 11 then
			cureThing = (mabils[act.param] and mabils[act.param].english) or '[REDACTED]'
		end

		--Check if the thing used is one we want to track data for
		if cureThings:contains(cureThing) then

			local cureIndividuals = live.individuals.cure

			--Retrieve the actors relevant data
			local cures = (cureIndividuals[actor_lower_name] and cureIndividuals[actor_lower_name].score) or 0
			local index = (cureIndividuals[actor_lower_name] and cureIndividuals[actor_lower_name].index) or 0
			
			--Update the actors score information
			local cureSum = 0
			for i = 1, act.target_count do
				cureSum = cureSum + act.targets[i].actions[1].param
			end
			cures = cures + cureSum
			local everyNumCures = math.floor(cures / 25000) --returns how many times 25,000 goes into cures
			local points = everyNumCures * 25000 --returns the multiple of 25,000 that cures is over
			cureIndividuals[actor_lower_name] = {score = cures, nines = 0, index = everyNumCures}

			--Update the leaderboard places
			updateBoard("cure")
			live:save('all')
			if box_display == 'cure' then
				updateBox(box_display)
			end

			--Call out Cures
			if (settings.mode == "Party" or settings.mode == "Raid") and settings.party_calls.cure then
				if everyNumCures > index then

					--Party Mode under 100k cures: call it out every 25k
					if everyNumCures < 5 and settings.mode == 'Party' then
						newChatMessage('/p [CURE] '..actor_name..' has cured for over '..addCommas(points)..' HP!')

					--Party Mode over 100k cures, or Raid Mode: call it out every 50k
					else
						local everyOtherNum = everyNumCures % 2 --returns the remainder after euclidean division (division by subtraction)
						if everyOtherNum == 0 then --if that leftover number equals 0, then the number is a multiple of 2
							newChatMessage('/p [CURE] '..actor_name..' has cured for over '..addCommas(points)..' HP!')
						end

					end
				end
			end

		end

	--Weapon Skill is used
	elseif (act.category == 3 or (act.category == 13 and BPWS:contains(jabils[act.param].english))) and not live.paused then

		local damage = act.targets[1].actions[1].param
		local ws_name = act.category == 13 and (jabils[act.param] and jabils[act.param].english or '[REDACTED]') or (weaponskills[act.param] and weaponskills[act.param].english or '[REDACTED]')

		local function notUtilWS()
			--Exclude utility Weapon Skills
			if ws_name == 'Atonement' or ws_name == 'Flat Blade' or ws_name == 'Tachi: Hobaku' or ws_name == 'Tachi: Ageha' or ws_name == 'Shoulder Tackle' or ws_name == 'Leg Sweep' or ws_name == 'Smash Axe' or ws_name == 'Brainshaker' or ws_name == 'Myrkr' or ws_name == 'Starlight' or ws_name == 'Moonlight' or ws_name == 'Energy Drain' or ws_name == 'Shield Break' or ws_name == 'Armor Break' or ws_name == 'Weapon Break' or ws_name == 'Full Break' or ws_name == 'Shell Crusher' or ws_name == 'Spirit Taker' or ws_name == 'Shockwave' and (msg == 185 or msg == 188) then
				return false
			else
				return true
			end
		end

		--Weapon Skill misses, gets blinked, or hits for 0
		if notUtilWS() and (msg == 188 or msg == 31 or (act.category == 13 and (msg == 324 or (msg == 317 and damage == 0))) or (msg == 185 and damage == 0)) then 

			-----------
			-- WHIFF --
			-----------

			local whiffPlaces = live.places.whiff
			local whiffIndividuals = live.individuals.whiff

			--Retrieve the actors relevant data
			local whiffs = (whiffIndividuals[actor_lower_name] and whiffIndividuals[actor_lower_name].score) or 0
			local index = live.index

			--Update the actors score information
			whiffs = whiffs +1
			whiffIndividuals[actor_lower_name] = {score = whiffs, nines = 0, index = index}

			--Update the targets points
			local points = live.individuals.point
			local name = actor_lower_name
			local pct_loss = 100 - settings.pctloss.whiff

			if points[name] and points[name].score then
				points[name].score = math.floor(points[name].score * (pct_loss / 100))
			end

			--Update the leaderboard places
			updateBoard("whiff")
			live:save('all')
			if box_display == 'whiff' then
				updateBox(box_display)
			end

			local amount_lost = math.floor(((points[name] and points[name].score) or 0) * (settings.pctloss.whiff / 100))

			--Call out Whiffs, depending on the mode and how many Whiffs they are at
			if settings.mode ~= "Silent" and settings.party_calls.whiff then
				if whiffs == 1 then
					if settings.mode == 'Party' then
						newChatMessage('/p [WHIFF] '..actor_name..' whiffs '..ws_name..('%s'):format(actor_lower_name == whiffPlaces.first.name and ' and is the first on the board.' or '.')..('%s'):format(settings.mode == "Mog Kart" and ' (-'..addCommas(amount_lost)..')' or ''))
					end
				elseif settings.mode == "Mog Kart" then
					newChatMessage('/p [WHIFF] '..actor_name..' whiffs '..ws_name..'. (-'..addCommas(amount_lost)..')')
				elseif whiffs == 5 or whiffs == 10 then
					newChatMessage('/p [WHIFF] '..actor_name..' whiffs '..ws_name..' and is up to '..whiffs..' whiffs now.')
				elseif whiffs < 10 then
					if settings.mode == 'Party' then
						newChatMessage('/p [WHIFF] '..actor_name..(' whiffs %s'):format(whiffs < 5 and '' or 'yet ')..'again with '..ws_name..'...')
					end
				elseif whiffs > 10 then
					local everyFiveWhiffs = whiffs % 5 --returns the remainder after euclidean division (division by subtraction)
					if everyFiveWhiffs == 0 then --if that leftover number equals 0, then the number is a multiple of 5
						newChatMessage('/p [WHIFF] '..actor_name..' is up to '..whiffs..' whiffs now.')
					end
				end
			end

		--Weapon Skill lands
		elseif msg == 185 or (act.category == 13 and msg == 317 or msg == 802) then

			if notUtilWS() then

				-------------
				-- HIGH WS --
				-------------

				local hsPlaces = live.places.hs
				local hsIndividuals = live.individuals.hs

				--What place was the actor in originally
				local originalHSPlace = 6 --not on the board
				if hsPlaces.first and actor_lower_name == hsPlaces.first.name then
					originalHSPlace = 1
				elseif hsPlaces.second and actor_lower_name == hsPlaces.second.name then
					originalHSPlace = 2
				elseif hsPlaces.third and actor_lower_name == hsPlaces.third.name then
					originalHSPlace = 3
				elseif hsPlaces.fourth and actor_lower_name == hsPlaces.fourth.name then
					originalHSPlace = 4
				elseif hsPlaces.fifth and actor_lower_name == hsPlaces.fifth.name then
					originalHSPlace = 5
				end

				--What was the original first place score
				local originalHSfirstscore = (hsPlaces and hsPlaces.first and hsPlaces.first.score) or 0

				--What are you and your Rivals original scores
				local myOriginalHSNines = (hsIndividuals and hsIndividuals[string.lower(myName)] and hsIndividuals[string.lower(myName)].nines) or 0
				local myOriginalHSScore = (hsIndividuals and hsIndividuals[string.lower(myName)] and hsIndividuals[string.lower(myName)].score) or 0
				local rivalOriginalHSNines = (hsIndividuals and hsIndividuals[settings.rival] and hsIndividuals[settings.rival].nines) or 0
				local rivalOriginalHSScore = (hsIndividuals and hsIndividuals[settings.rival] and hsIndividuals[settings.rival].score) or 0

				--Retrieve the actors relevant data
				local nines = (hsIndividuals[actor_lower_name] and hsIndividuals[actor_lower_name].nines) or 0
				local index = live.index

				--Count the number of 99999 WSs
				if damage == 99999 then
					nines = nines + 1
				end

				--Update the actors score information
				if (hsIndividuals[actor_lower_name] == nil) or (damage >= hsIndividuals[actor_lower_name].score) then
					hsIndividuals[actor_lower_name] = {score = damage, nines = nines, index = index}
				end

				--Update the leaderboard places
				updateBoard("hs")
				live:save('all')
				if box_display == 'hs' then
					updateBox(box_display)
				end

				--What place is the actor in now
				local newHSPlace = 6 --not on the board
				if actor_lower_name == hsPlaces.first.name then
					newHSPlace = 1
				elseif actor_lower_name == hsPlaces.second.name then
					newHSPlace = 2
				elseif actor_lower_name == hsPlaces.third.name then
					newHSPlace = 3
				elseif actor_lower_name == hsPlaces.fourth.name then
					newHSPlace = 4
				elseif actor_lower_name == hsPlaces.fifth.name then
					newHSPlace = 5
				end

				--Code for HIGH WS callouts is down inside LOW WS so that we can Do Logic to prevent it from calling both LOW WS and HIGH WS for the same WS

				--Did you or your rival beat the other
				if settings.rival ~= "" then
					if actor_name == myName then
						if ((rivalOriginalHSNines == myOriginalHSNines) and (nines > rivalOriginalHSNines) and (rivalOriginalHSScore > 0)) or ((rivalOriginalHSScore > myOriginalHSScore) and (damage > rivalOriginalHSScore)) then
							add_to_chat(8,('[Leaderboard] '):color(220)..('You\'re now beating '..capitalize(settings.rival)..'\'s '..addCommas(rivalOriginalHSScore)..(rivalOriginalHSNines > 0 and ':'..rivalOriginalHSNines or '')..' HIGH WS score with '):color(6)..(addCommas(damage)..(nines > 0 and ':'..nines or '')..'.'):color(158))
						end
					elseif actor_name == capitalize(settings.rival) then
						if ((rivalOriginalHSNines == myOriginalHSNines) and (nines > myOriginalHSNines)) or ((myOriginalHSScore > rivalOriginalHSScore) and damage > myOriginalHSScore) then
							add_to_chat(8,('[Leaderboard] '):color(220)..(capitalize(settings.rival)..' is now beating your '..addCommas(myOriginalHSScore)..(myOriginalHSNines > 0 and ':'..myOriginalHSNines or '')..' HIGH WS score with '):color(28)..(addCommas(damage)..(nines > 0 and ':'..nines or '')..'.'):color(167))
						end
					end
				end

				------------
				-- LOW WS --
				------------

				local lsPlaces = live.places.ls
				local lsIndividuals = live.individuals.ls

				--What place was the actor in originally
				local originalLSPlace = 6 --not on the board
				if lsPlaces.first and actor_lower_name == lsPlaces.first.name then
					originalLSPlace = 1
				elseif lsPlaces.second and actor_lower_name == lsPlaces.second.name then
					originalLSPlace = 2
				elseif lsPlaces.third and actor_lower_name == lsPlaces.third.name then
					originalLSPlace = 3
				elseif lsPlaces.fourth and actor_lower_name == lsPlaces.fourth.name then
					originalLSPlace = 4
				elseif lsPlaces.fifth and actor_lower_name == lsPlaces.fifth.name then
					originalLSPlace = 5
				end

				--What was the original first place score
				local originalLSfirstscore = (lsPlaces and lsPlaces.first and lsPlaces.first.score) or 0

				--Retrieve the actors relevant data
				local index = live.index

				--Update the actors score
				if (lsIndividuals[actor_lower_name] == nil) or (damage < lsIndividuals[actor_lower_name].score) then
					lsIndividuals[actor_lower_name] = {score = damage, nines = 0, index = index}
				end

				--Update the leaderboard places
				updateBoard("ls")
				live:save('all')
				if box_display == 'ls' then
					updateBox(box_display)
				end

				--What place is the actor in now
				local newLSPlace = 6 --not on the board
				if actor_lower_name == lsPlaces.first.name then
					newLSPlace = 1
				elseif actor_lower_name == lsPlaces.second.name then
					newLSPlace = 2
				elseif actor_lower_name == lsPlaces.third.name then
					newLSPlace = 3
				elseif actor_lower_name == lsPlaces.fourth.name then
					newLSPlace = 4
				elseif actor_lower_name == lsPlaces.fifth.name then
					newLSPlace = 5
				end

				if (settings.mode == "Party" or settings.mode == "Raid") then

					--Did the actor move up the HIGH WS leaderboard
					if newHSPlace == originalHSPlace and newHSPlace == 1 and (damage > originalHSfirstscore or damage == 99999) and settings.party_calls.hs then
						local everyTenNines = nines % 10 --returns the remainder after euclidean division (division by subtraction)
						if nines == 1 or (nines >= 10 and everyTenNines == 0) or (nines < 10 and settings.mode == "Party") then
							newChatMessage('/p [HIGH WS] '..uppercase(actor_name)..' extends the lead! '..ws_name..' for '..addCommas(damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..target_name..'!')
						end
					elseif newHSPlace < originalHSPlace and settings.party_calls.hs then
						if newHSPlace == 1 then
							if damage > originalHSfirstscore then
								newChatMessage('/p [HIGH WS] '..uppercase(actor_name)..' takes the board! '..ws_name..' for '..addCommas(damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..target_name..'!')
							end
						elseif newHSPlace ~= originalHSPlace and newHSPlace ~= 6 and settings.mode == 'Party' then
							newChatMessage('/p [HIGH WS] '..actor_name..' moves up to No.'..newHSPlace..'! '..ws_name..' for '..addCommas(damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..target_name..'!')
						end

					--Did the actor move up the LOW WS leaderboard
					elseif newLSPlace == originalLSPlace and newLSPlace == 1 and damage < originalLSfirstscore and settings.party_calls.ls then
						newChatMessage('/p [LOW WS] '..uppercase(actor_name)..' extends the lead! '..ws_name..' for '..addCommas(damage)..' on the '..target_name..'!')
					elseif newLSPlace < originalLSPlace and settings.party_calls.ls then
						if newLSPlace == 1 then
							if damage < originalLSfirstscore then
								newChatMessage('/p [LOW WS] '..uppercase(actor_name)..' takes the board! '..ws_name..' for '..addCommas(damage)..' on the '..target_name..'!')
							end
						elseif newLSPlace ~= originalLSPlace and newLSPlace ~= 6 and settings.mode == 'Party' then
							newChatMessage('/p [LOW WS] '..actor_name..' moves up to No.'..newLSPlace..'! '..ws_name..' for '..addCommas(damage)..' on the '..target_name..'!')
						end
					end

				end

			end

			--------------
			-- TOTAL WS --
			--------------

			local wsIndividuals = live.individuals.ws

			--What are you and your Rivals original scores
			local myOriginalWSScore = (wsIndividuals and wsIndividuals[string.lower(myName)] and wsIndividuals[string.lower(myName)].score) or 0
			local rivalOriginalWSScore = (wsIndividuals and wsIndividuals[settings.rival] and wsIndividuals[settings.rival].score) or 0

			--Retrieve the actors relevant data
			local wss = (wsIndividuals[actor_lower_name] and wsIndividuals[actor_lower_name].score) or 0
			local index = (wsIndividuals[actor_lower_name] and wsIndividuals[actor_lower_name].index) or 0

			--Update the actors score information
			local wsSum = 0
			for i = 1, act.target_count do
				wsSum = wsSum + act.targets[i].actions[1].param
			end
			wss = wss + wsSum
			local everyNumWSs = math.floor(wss / 250000) --returns how many times 250,000 goes into wss
			local points = everyNumWSs * 250000 --returns the multiple of 250,000 that wss is over
			wsIndividuals[actor_lower_name] = {score = wss, nines = 0, index = everyNumWSs}

			--Update the leaderboard places
			updateBoard("ws")
			live:save('all')
			if box_display == 'ws' then
				updateBox(box_display)
			end

			--Call out WSs
			if (settings.mode == "Party" or settings.mode == "Raid") and settings.party_calls.ws then
				if everyNumWSs > index then

					--Party Mode under 1m in WSs: call it out every 250k
					if everyNumWSs < 5 and settings.mode == 'Party' then
						newChatMessage('/p [TOTAL WS] '..actor_name..' has weapon skilled for over '..addCommas(points)..' damage!')

					--Party Mode over 1m in WSs, or Raid Mode: call it out every 500k
					elseif everyNumWSs < 21 then
						local everyOtherNum = everyNumWSs % 2 --returns the remainder after euclidean division (division by subtraction)
						if everyOtherNum == 0 then --if that leftover number equals 0, then the number is a multiple of 2 (2x250k = every 500k)
							newChatMessage('/p [TOTAL WS] '..actor_name..' has weapon skilled for over '..addCommas(points)..' damage!')
						end

					--Party/Raid Mode over 5m in WSs: call it out every 1m
					else
						local everyOtherNum = everyNumWSs % 4 --returns the remainder after euclidean division (division by subtraction)
						if everyOtherNum == 0 then --if that leftover number equals 0, then the number is a multiple of 4 (4x250k = every 1m)
							newChatMessage('/p [TOTAL WS] '..actor_name..' has weapon skilled for over '..addCommas(points)..' damage!')
						end

					end
				end
			end

			--Did you or your rival beat the other
			if settings.rival ~= "" then
				if actor_name == myName then
					if (rivalOriginalWSScore > myOriginalWSScore) and (wss > rivalOriginalWSScore) then
						add_to_chat(8,('[Leaderboard] '):color(220)..('You\'re now beating '..capitalize(settings.rival)..'\'s '..addCommas(rivalOriginalWSScore)..' score with '):color(6)..(addCommas(wss)..' TOTAL WS damage.'):color(158))
					end
				elseif actor_name == capitalize(settings.rival) then
					if (myOriginalWSScore > rivalOriginalWSScore) and (wss > myOriginalWSScore) then
						add_to_chat(8,('[Leaderboard] '):color(220)..(capitalize(settings.rival)..' is now beating your '..addCommas(myOriginalWSScore)..' score with '):color(28)..(addCommas(wss)..' TOTAL WS damage.'):color(167))
					end
				end
			end

		end
	end

	--Skillchain is created
	if ((act.category == 4 and msg == 2) or (act.category == 3 and msg == 185) or (act.category == 13 and BPWS:contains(jabils[act.param].english))) and act.targets[1].actions[1].has_add_effect and not live.paused then

		----------------
		-- SKILLCHAIN --
		----------------

		local damage = act.targets[1].actions[1].add_effect_param
		
		local sc = {} sc[1] = 'Light' sc[2] = 'Darkness' sc[3] = 'Gravitation' sc[4] = 'Fragmentation' sc[5] = 'Distortion' sc[6] = 'Fusion' sc[7] = 'Compression' sc[8] = 'Liquefaction' sc[9] = 'Induration' sc[10] = 'Reverberation' sc[11] = 'Transfixion' sc[12] = 'Scission' sc[13] = 'Detonation' sc[14] = 'Impaction' sc[15] = 'Radiance' sc[16] = 'Umbra'
		local sc_name = sc[act.targets[1].actions[1].add_effect_animation] or '[REDACTED]'

		local scPlaces = live.places.sc
		local scIndividuals = live.individuals.sc

		--What place was the actor in originally
		local originalSCPlace = 6 -- not on the board
		if scPlaces.first and actor_lower_name == scPlaces.first.name then
			originalSCPlace = 1
		elseif scPlaces.second and actor_lower_name == scPlaces.second.name then
			originalSCPlace = 2
		elseif scPlaces.third and actor_lower_name == scPlaces.third.name then
			originalSCPlace = 3
		elseif scPlaces.fourth and actor_lower_name == scPlaces.fourth.name then
			originalSCPlace = 4
		elseif scPlaces.fifth and actor_lower_name == scPlaces.fifth.name then
			originalSCPlace = 5
		end

		--What was the original first place score
		local originalSCfirstscore = (scPlaces and scPlaces.first and scPlaces.first.score) or 0

		--What are you and your Rivals original scores
		local myOriginalSCNines = (scIndividuals and scIndividuals[string.lower(myName)] and scIndividuals[string.lower(myName)].nines) or 0
		local myOriginalSCScore = (scIndividuals and scIndividuals[string.lower(myName)] and scIndividuals[string.lower(myName)].score) or 0
		local rivalOriginalSCNines = (scIndividuals and scIndividuals[settings.rival] and scIndividuals[settings.rival].nines) or 0
		local rivalOriginalSCScore = (scIndividuals and scIndividuals[settings.rival] and scIndividuals[settings.rival].score) or 0

		--Retrieve the actors relevant data
		local nines = (scIndividuals[actor_lower_name] and scIndividuals[actor_lower_name].nines) or 0
		local index = live.index

		--Count the number of 99999 WSs
		if damage == 99999 then
			nines = nines + 1
		end

		--Update the actors score information
		if (scIndividuals[actor_lower_name] == nil) or (damage >= scIndividuals[actor_lower_name].score) then
			scIndividuals[actor_lower_name] = {score = damage, nines = nines, index = index}
		end

		--Update the leaderboard places
		updateBoard("sc")
		live:save('all')
		if box_display == 'sc' then
			updateBox(box_display)
		end

		--What place is the actor in now
		local newSCPlace = 6 -- Not on the board
		if actor_lower_name == scPlaces.first.name then
			newSCPlace = 1
		elseif actor_lower_name == scPlaces.second.name then
			newSCPlace = 2
		elseif actor_lower_name == scPlaces.third.name then
			newSCPlace = 3
		elseif actor_lower_name == scPlaces.fourth.name then
			newSCPlace = 4
		elseif actor_lower_name == scPlaces.fifth.name then
			newSCPlace = 5
		end

		--Did the actor move up the leaderboard
		if (settings.mode == "Party" or settings.mode == "Raid") and settings.party_calls.sc then
			if newSCPlace == originalSCPlace and newSCPlace == 1 and (damage > originalSCfirstscore or damage == 99999) then
				local everyFiveNines = nines % 5 -- returns the remainder after euclidean division (division by subtraction)
				if nines == 1 or (nines >= 5 and everyFiveNines == 0) or (nines < 10 and settings.mode == "Party") then
					newChatMessage('/p [SKILLCHAIN] '..uppercase(actor_name)..' extends the lead! '..sc_name..' for '..addCommas(damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..target_name..'!')
				end
			elseif newSCPlace < originalSCPlace then
				if newSCPlace == 1 then
					if damage > originalSCfirstscore then
						newChatMessage('/p [SKILLCHAIN] '..uppercase(actor_name)..' takes the board! '..sc_name..' for '..addCommas(damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..target_name..'!')
					end
				elseif newSCPlace ~= originalSCPlace and newSCPlace ~= 6 and settings.mode == 'Party' then
					newChatMessage('/p [SKILLCHAIN] '..actor_name..' moves up to No.'..newSCPlace..'! '..sc_name..' for '..addCommas(damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..target_name..'!')
				end
			end
		end

		--Did you or your rival beat the other
		if settings.rival ~= "" then
			if actor_name == myName then
				if ((rivalOriginalSCNines == myOriginalSCNines) and (nines > rivalOriginalSCNines) and (rivalOriginalSCScore > 0)) or ((rivalOriginalSCScore > myOriginalSCScore) and (damage > rivalOriginalSCScore)) then
					add_to_chat(8,('[Leaderboard] '):color(220)..('You\'re now beating '..capitalize(settings.rival)..'\'s '..addCommas(rivalOriginalSCScore)..(rivalOriginalSCNines > 0 and ':'..rivalOriginalSCNines or '')..' SKILLCHAIN score with '):color(6)..(addCommas(damage)..(nines > 0 and ':'..nines or '')..'.'):color(158))
				end
			elseif actor_name == capitalize(settings.rival) then
				if ((rivalOriginalSCNines == myOriginalSCNines) and (nines > myOriginalSCNines)) or ((myOriginalSCScore > rivalOriginalSCScore) and damage > myOriginalSCScore) then
					add_to_chat(8,('[Leaderboard] '):color(220)..(capitalize(settings.rival)..' is now beating your '..addCommas(myOriginalSCScore)..(myOriginalSCNines > 0 and ':'..myOriginalSCNines or '')..' SKILLCHAIN score with '):color(28)..(addCommas(damage)..(nines > 0 and ':'..nines or '')..'.'):color(167))
				end
			end
		end

	end

	--Magic Burst lands
	if ((act.category == 4 and msg == 252) or (act.category == 15 and msg == 110 and act.targets[1].actions[1].unknown == 4) or (act.category == 13 and msg == 379)) and not live.paused then

		-----------------
		-- MAGIC BURST --
		-----------------

		local damage = act.targets[1].actions[1].param

		--Determine the actors relevant data
		local spell_name = ''
		if act.category == 4 then
			spell_name = spells[act.param] and spells[act.param].english or '[REDACTED]'
		else
			spell_name = jabils[act.param] and jabils[act.param].english or '[REDACTED]'
		end

		local mbPlaces = live.places.mb
		local mbIndividuals = live.individuals.mb

		--What place was the actor in originally
		local originalMBPlace = 6 -- not on the board
		if mbPlaces.first and actor_lower_name == mbPlaces.first.name then
			originalMBPlace = 1
		elseif mbPlaces.second and actor_lower_name == mbPlaces.second.name then
			originalMBPlace = 2
		elseif mbPlaces.third and actor_lower_name == mbPlaces.third.name then
			originalMBPlace = 3
		elseif mbPlaces.fourth and actor_lower_name == mbPlaces.fourth.name then
			originalMBPlace = 4
		elseif mbPlaces.fifth and actor_lower_name == mbPlaces.fifth.name then
			originalMBPlace = 5
		end

		--What was the original first place score
		local originalMBfirstscore = (mbPlaces and mbPlaces.first and mbPlaces.first.score) or 0

		--Retrieve the actors relevant data
		local nines = (mbIndividuals[actor_lower_name] and mbIndividuals[actor_lower_name].nines) or 0
		local index = live.index

		--Count the number of 99999 WSs
		if damage == 99999 then
			nines = nines + 1
		end

		--Update the actors score information
		if (mbIndividuals[actor_lower_name] == nil) or (damage >= mbIndividuals[actor_lower_name].score) then
			mbIndividuals[actor_lower_name] = {score = damage, nines = nines, index = index}
		end

		--Update the leaderboard places
		updateBoard("mb")
		live:save('all')
		if box_display == 'mb' then
			updateBox(box_display)
		end
		
		--What place is the actor in now
		local newMBPlace = 6 --Not on the board
		if actor_lower_name == mbPlaces.first.name then
			newMBPlace = 1
		elseif actor_lower_name == mbPlaces.second.name then
			newMBPlace = 2
		elseif actor_lower_name == mbPlaces.third.name then
			newMBPlace = 3
		elseif actor_lower_name == mbPlaces.fourth.name then
			newMBPlace = 4
		elseif actor_lower_name == mbPlaces.fifth.name then
			newMBPlace = 5
		end

		--Did the actor move up the leaderboard
		if (settings.mode == "Party" or settings.mode == "Raid") and settings.party_calls.mb then
			if newMBPlace == originalMBPlace and newMBPlace == 1 and (damage > originalMBfirstscore or damage == 99999) then
				local everyFiveNines = nines % 5 -- returns the remainder after euclidean division (division by subtraction)
				if nines == 1 or (nines >= 5 and everyFiveNines == 0) or (nines < 10 and settings.mode == "Party") then
					newChatMessage('/p [MAGIC BURST] '..uppercase(actor_name)..' extends the lead! '..spell_name..' for '..addCommas(damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..target_name..'!')
				end
			elseif newMBPlace < originalMBPlace then
				if newMBPlace == 1 then
					if damage > originalMBfirstscore then
						newChatMessage('/p [MAGIC BURST] '..uppercase(actor_name)..' takes the board! '..spell_name..' for '..addCommas(damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..target_name..'!')
					end
				elseif newMBPlace ~= originalMBPlace and newMBPlace ~= 6 and settings.mode == 'Party' then
					newChatMessage('/p [MAGIC BURST] '..actor_name..' moves up to No.'..newMBPlace..'! '..spell_name..' for '..addCommas(damage)..('%s on the '):format(nines > 0 and ':'..nines or '')..target_name..'!')
				end
			end
		end

	end

	--Nuke lands (includes Magic Bursts)
	if ((act.category == 4 and msg == 2) or (act.category == 4 and msg == 252) or (act.category == 15 and msg == 110) or (act.category == 13 and BPNuke:contains(jabils[act.param].english)) or (act.category == 13 and msg == 379)) and not live.paused then

		----------
		-- Nuke --
		----------

		local nukeIndividuals = live.individuals.nuke

		--Retrieve the actors relevant data
		local nukes = (nukeIndividuals[actor_lower_name] and nukeIndividuals[actor_lower_name].score) or 0
		local index = (nukeIndividuals[actor_lower_name] and nukeIndividuals[actor_lower_name].index) or 0

		--Update the actors score information
		local nukeSum = 0
		for i = 1, act.target_count do
			nukeSum = nukeSum + act.targets[i].actions[1].param
		end
		nukes = nukes + nukeSum
		local everyNumNukes = math.floor(nukes / 250000) --returns how many times 250,000 goes into nukes
		local points = everyNumNukes * 250000 --returns the multiple of 250,000 that nukes is over
		nukeIndividuals[actor_lower_name] = {score = nukes, nines = 0, index = everyNumNukes}

		--Update the leaderboard places
		updateBoard("nuke")
		live:save('all')
		if box_display == 'nuke' then
			updateBox(box_display)
		end

		--Call out Nukes
		if (settings.mode == "Party" or settings.mode == "Raid") and settings.party_calls.nuke then
			if everyNumNukes > index then

				--Party Mode under 1m nukes: call it out every 250k
				if everyNumNukes < 5 and settings.mode == 'Party' then
					newChatMessage('/p [NUKE] '..actor_name..' has nuked for over '..addCommas(points)..' damage!')

				--Party Mode over 1m nukes, or Raid Mode: call it out every 500k
				else
					local everyOtherNum = everyNumNukes % 2 --returns the remainder after euclidean division (division by subtraction)
					if everyOtherNum == 0 then --if that leftover number equals 0, then the number is a multiple of 2
						newChatMessage('/p [NUKE] '..actor_name..' has nuked for over '..addCommas(points)..' damage!')
					end

				end
			end
		end
	end

	--Was there are Daken attack attached to a melee attack?
	local daken = 0
	if act.category == 1 then
		for i = 1, act.targets[1].action_count do
			if act.targets[1].actions[i] and act.targets[1].actions[i].animation == 4 then
				daken = act.targets[1].actions[i].param
			end
		end
	end

	--Ranged Attack lands (includes daken and barrage)
	if ((act.category == 1 and daken ~= 0) or (act.category == 2 and (msg == 352 or msg == 353 or msg == 576 or msg == 577 or msg == 157))) and not live.paused then

		----------------
		-- RANGED ATT --
		----------------

		local raIndividuals = live.individuals.ra

		--Retrieve the actors relevant data
		local ras = (raIndividuals[actor_lower_name] and raIndividuals[actor_lower_name].score) or 0
		local index = (raIndividuals[actor_lower_name] and raIndividuals[actor_lower_name].index) or 0

		--Update the actors score information
		if act.category == 1 then
			ras = ras + daken
		else
			ras = ras + act.targets[1].actions[1].param
		end
		local everyNumRas = math.floor(ras / 5000) --returns how many times 5,000 goes into ras
		local points = everyNumRas * 5000 --returns the multiple of 5,000 that ras is over
		raIndividuals[actor_lower_name] = {score = ras, nines = 0, index = everyNumRas}

		--Update the leaderboard places
		updateBoard("ra")
		live:save('all')
		if box_display == 'ra' then
			updateBox(box_display)
		end

		--Call out Ranged Attacks
		if (settings.mode == "Party" or settings.mode == "Raid") and settings.party_calls.ra then
			if everyNumRas > index then

				--Party Mode under 50k in ras: call it out every 10k
				if everyNumRas < 11 and settings.mode == 'Party' then
					local everyOtherNum = everyNumRas % 2 --returns the remainder after euclidean division (division by subtraction)
					if everyOtherNum == 0 then --if that leftover number equals 0, then the number is a multiple of 2 (2x5k = every 10k)
						newChatMessage('/p [RANGED ATT] '..actor_name..' has ranged attacked for over '..addCommas(points)..' damage!')
					end

				--Party Mode over 50k in ras, or Raid Mode: call it out every 25k
				elseif everyNumRas < 21 then
					local everyOtherNum = everyNumRas % 5 --returns the remainder after euclidean division (division by subtraction)
					if everyOtherNum == 0 then --if that leftover number equals 0, then the number is a multiple of 5 (5x5k = every 25k)
						newChatMessage('/p [RANGED ATT] '..actor_name..' has ranged attacked for over '..addCommas(points)..' damage!')
					end

				--Party/Raid Mode over 100k in ras: call it out every 50k
				else
					local everyOtherNum = everyNumRas % 10 --returns the remainder after euclidean division (division by subtraction)
					if everyOtherNum == 0 then --if that leftover number equals 0, then the number is a multiple of 10 (10x5k = every 50k)
						newChatMessage('/p [RANGED ATT] '..actor_name..' has ranged attacked for over '..addCommas(points)..' damage!')
					end

				end
			end
		end
	end

	local removed_from_alliance = {
		83, 123, 159, 321, 322, 341, 342
	}
	local landed_on_mobs = {
		127, 141, 142, 144, 230, 236, 237, 242, 243, 268, 271, 319, 320, 329, 330, 331, 332, 333, 334, 
		335, 369, 374, 375, 400, 412, 417, 430, 519, 520, 521, 522, 529, 533, 534, 570, 572, 591, 593, 
		594, 595, 596, 597, 598, 599, 603, 608, 641, 642, 644, 645, 672
	}
	local not_removed_from_alliance = {
		75, 156
	}
	local not_landed_on_mobs = {
		75, 85, 114, 156, 189, 323, 408, 653, 655
	}
	local removed_from_mob = {
		83, 123, 168, 231, 341, 342, 370, 401, 405, 453, 647
	}
	local landed_on_alliance = {
		116, 120, 121, 131, 134, 146, 148, 150, 186, 194, 230, 236, 237, 242, 
		243, 268, 271, 319, 320, 364, 375, 402, 412, 414, 416, 420, 432, 433, 
		435, 437, 439, 441, 451, 452, 668, 670, 671
	}
	local not_removed_from_mob = {
		75, 85, 114, 156, 323, 653, 655
	}
	local not_landed_on_alliance = {
		75, 156, 426
	}

	--Is the spell/ability one that can remove a mobs buffs?
	local function isDispel(id)
		local valid_ids = {132, 260, 360, 462, 592, 605}
		
		for _, v in ipairs(valid_ids) do
			if id == v then
				return true
			end
		end
		
		return false
	end

	--Is the spell/ability one that can remove a players debuffs?
	local function isErase(id)
		local valid_ids = {14, 15, 16, 17, 18, 19, 20, 94, 95, 123, 143, 194, 681, 893} --Double-UP (123) is added to account for busting
		
		for _, v in ipairs(valid_ids) do
			if id == v then
				return true
			end
		end
		
		return false
	end
	
	if  ((checkForMessage(landed_on_alliance, msg) or (checkForMessage(not_landed_on_alliance, msg) and isErase(act.param))) and isTargetingOthers(act)) or ((checkForMessage(removed_from_mob, msg) or (checkForMessage(not_removed_from_mob, msg) and isDispel(act.param))) and isTargetMob(target)) and not live.paused then

		----------
		-- BUFF --
		----------

		local buffIndividuals = live.individuals.buff

		--Retrieve the actors relevant data
		local buffs = (buffIndividuals[actor_lower_name] and buffIndividuals[actor_lower_name].score) or 0
		local tries = (buffIndividuals[actor_lower_name] and buffIndividuals[actor_lower_name].nines) or 0
		local index = live.index

		--Update the actors score information
		if (checkForMessage(landed_on_alliance, msg) and isTargetingOthers(act)) or (checkForMessage(removed_from_mob, msg) and isTargetMob(target)) then
			if msg == 231 or msg == 370 or msg == 401 or msg == 405 then
				buffs = buffs + act.targets[1].actions[1].param
				tries = tries + 1
			else
				buffs = buffs + 1
				tries = tries + 1
			end
			--Call out Buff removals/lands, depending on the mode and how many Buff removals/lands they are at
			if (settings.mode == "Party" or settings.mode == "Raid") and settings.party_calls.buff then
				local everyNumBuffs = buffs % 25 --returns the remainder after euclidean division (division by subtraction)
				if everyNumBuffs == 0 and buffs ~= 0 then --if that leftover number equals 0, then the number is a multiple of Num
					newChatMessage('/p [BUFF] '..actor.name..' has landed/removed '..addCommas(buffs)..' buffs!')
				end
			end
		elseif (checkForMessage(not_landed_on_alliance, msg) and isErase(act.param) and isTargetingOthers(act)) or (checkForMessage(not_removed_from_mob, msg) and isDispel(act.param) and isTargetMob(target)) then
			if msg == 426 then --Corsair bust instead removes a buff from the count
				buffs = buffs - 1
			else
				tries = tries + 1
			end
		end
		buffIndividuals[actor_lower_name] = {score = buffs, nines = tries, index = index}

		--Update the leaderboard places
		updateBoard("buff")
		live:save('all')
		if box_display == 'buff' then
			updateBox(box_display)
		end

	elseif ((checkForMessage(removed_from_alliance, msg) or checkForMessage(not_removed_from_alliance, msg)) and isTargetingOthers(act)) or ((checkForMessage(landed_on_mobs, msg) or checkForMessage(not_landed_on_mobs, msg)) and isTargetMob(target)) and not live.paused then

	------------
	-- DEBUFF --
	------------

		local debuffIndividuals = live.individuals.debuff

		--Retrieve the actors relevant data
		local debuffs = (debuffIndividuals[actor_lower_name] and debuffIndividuals[actor_lower_name].score) or 0
		local tries = (debuffIndividuals[actor_lower_name] and debuffIndividuals[actor_lower_name].nines) or 0
		local index = live.index

		--Update the actors score information
		if (checkForMessage(removed_from_alliance, msg) and isTargetingOthers(act)) or (checkForMessage(landed_on_mobs, msg) and isTargetMob(target)) then
			if msg == 369 or msg == 400 or msg == 417 or msg == 570 or msg == 572 or msg == 642 or msg == 644 then
				debuffs = debuffs + act.targets[1].actions[1].param
				tries = tries + 1
			else
				debuffs = debuffs + 1
				tries = tries + 1
			end
			--Call out Debuff removals/lands, depending on the mode and how many Debuff removals/lands they are at
			if (settings.mode == "Party" or settings.mode == "Raid") and settings.party_calls.debuff then
				local everyNumDebuffs = debuffs % 25 --returns the remainder after euclidean division (division by subtraction)
				if everyNumDebuffs == 0 and debuffs ~= 0 then --if that leftover number equals 0, then the number is a multiple of Num
					newChatMessage('/p [DEBUFF] '..actor.name..' has landed/removed '..addCommas(debuffs)..' debuffs!')
				end
			end
		elseif (checkForMessage(not_removed_from_alliance, msg) and isTargetingOthers(act)) or (checkForMessage(not_landed_on_mobs, msg) and isTargetMob(target)) then
			tries = tries + 1
		end

		debuffIndividuals[actor_lower_name] = {score = debuffs, nines = tries, index = index}

		--Update the leaderboard places
		updateBoard("debuff")
		live:save('all')
		if box_display == 'debuff' then
			updateBox(box_display)
		end

	end

	if not live.paused then

		------------
		-- POINT --
		------------

		updatePoints()

		local index = live.index
		index = index +1 --Increment the index number at every interval
		live.index = index

		if settings.mode == "Mog Kart" then
			local everyNumGiveItem = live.index % settings.kart_item_interval
			if everyNumGiveItem == 0 then
				giveItem()
			end
		end

		local pointPlaces = live.places.point

		--Update the leaderboard places
		updateBoard("point")
		live:save('all')
		if box_display == 'point' then
			updateBox(box_display)
		end

	end
end)

register_event('addon command',function(addcmd, ...)

    local args = {...}
    local arg = args[1]
    local arg2 = args[2]


	--Give a random player a random item
	if addcmd == 'randomitem' then
		if settings.mode == "Mog Kart" then
			giveItem()
		else
			add_to_chat(8,('[Leaderboard] '):color(220)..('Items can only be given in Mog Kart Mode.'):color(8))
		end


	elseif addcmd == 'item' then
		if arg == 'reset' then
			resetI()
			live:save('all')
			if settings.mode == "Mog Kart" then
				newChatMessage('/p [LB] ITEM data reset.')
			else
				add_to_chat(8,('[Leaderboard] '):color(220)..('ITEM data reset.'):color(8))
			end
			return
		elseif arg == 'info' then
			informItem(self_name)
			return
		end
		if live.items[self_name] then
			useItem(self_name, arg)
		else
			add_to_chat(8,('[Leaderboard] '):color(220)..('You have no items available to use.'):color(8))
		end


	elseif addcmd == 'info' then
		informItem(self_name)


	--Reset the data, does not stop LB from running
	elseif addcmd == 'reset' then
		local board = ''
		if arg == 'b' or arg == 'buff' or arg == 'buffs' then
			resetB()
			board = 'BUFF'
		elseif arg == 'c' or arg == 'cure' or arg == 'cures' then
			resetC()
			board = 'CURE'
		elseif arg == 'db' or arg == 'debuff' or arg == 'debuffs' then
			resetDB()
			board = 'DEBUFF'
		elseif arg == 'd' or arg == 'death' or arg == 'deaths' then
			resetD()
			board = 'DEATH'
		elseif arg == 'hs' or arg == 'highscore' or arg == 'hiscore' then
			resetHS()
			board = 'HIGH WS'
		elseif arg == 'i' or arg == 'item' or arg == 'items' then
			resetI()
			board = 'ITEM'
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
		elseif arg == 'ml' or arg == 'melee' or arg == 'mele' then
			resetML()
			board = 'MELEE'
		elseif arg == 'm' or arg == 'murder' then
			resetM()
			board = 'MURDER'
		elseif arg == 'p' or arg == 'point' or arg == 'points' then
			resetP()
			board = 'POINT'
		elseif arg == 'ra' or arg == 'range' or arg == 'ranged' or arg == 'rangedatt' or arg == 'rangedattack' then
			resetSC()
			board = 'RANGED ATT'
		elseif arg == 'sc' or arg == 'skillchain' or arg == 'skillchains' then
			resetSC()
			board = 'SKILLCHAIN'
		elseif arg == 'td' or arg == 'totaldamage' or arg == 'totaldmg' or arg == 'totdmg' then
			resetTD()
			board = 'TOTAL DMG'
		elseif arg == 'v' or arg == 'victim' or arg == 'victims' then
			resetV()
			board = 'VICTIM'
		elseif arg == 'ws' or arg == 'weaponskill' or arg == 'weaponskills' then
			resetWS()
			board = 'TOTAL WS'
		elseif arg == 'w' or arg == 'whiff' or arg == 'whiffs' then
			resetW()
			board = 'WHIFF'
		elseif arg == 'all' then
			resetALL()
			board = 'ALL'
		else
			add_to_chat(8,('[Leaderboard] '):color(220)..('Please add which board you would like reset (all/b/c/d/db/hs/k/ls/m/mb/ml/n/p/ra/sc/td/v/ws/w).'):color(8))
			return
		end
		if settings.mode ~= "Silent" then
			newChatMessage('/p [LB] '..board..' data reset.')
		else
			add_to_chat(8,('[Leaderboard] '):color(220)..(board..' data reset.'):color(8))
		end
		live:save('all')
		updateBox(box_display)


	--Callouts for Party Mode setting
	elseif addcmd == 'call' or addcmd == 'calls' or addcmd == 'callout' or addcmd == 'callouts' then
		local party_calls = settings.party_calls
		if arg == 'b' or arg == 'buff' or arg == 'buffs' then
			party_calls.buff = not party_calls.buff
			add_to_chat(8,('[Leaderboard] '):color(220)..('BUFF call:'):color(8)..(' %s':format(party_calls.buff and 'ON' or 'OFF')):color(200))
		elseif arg == 'c' or arg == 'cure' or arg == 'cures' then
			party_calls.cure = not party_calls.cure
			add_to_chat(8,('[Leaderboard] '):color(220)..('CURE call:'):color(8)..(' %s':format(party_calls.cure and 'ON' or 'OFF')):color(200))
		elseif arg == 'db' or arg == 'debuff' or arg == 'debuffs' then
			party_calls.debuff = not party_calls.debuff
			add_to_chat(8,('[Leaderboard] '):color(220)..('DEBUFF call:'):color(8)..(' %s':format(party_calls.debuff and 'ON' or 'OFF')):color(200))
		elseif arg == 'd' or arg == 'death' or arg == 'deaths' then
			party_calls.death = not party_calls.death
			add_to_chat(8,('[Leaderboard] '):color(220)..('DEATH call:'):color(8)..(' %s':format(party_calls.death and 'ON' or 'OFF')):color(200))
		elseif arg == 'hs' or arg == 'highscore' or arg == 'hiscore' then
			party_calls.hs = not party_calls.hs
			add_to_chat(8,('[Leaderboard] '):color(220)..('HIGH WS call:'):color(8)..(' %s':format(party_calls.hs and 'ON' or 'OFF')):color(200))
		elseif arg == 'k' or arg == 'kill' or arg == 'kills' then
			party_calls.kill = not party_calls.kill
			add_to_chat(8,('[Leaderboard] '):color(220)..('KILL call:'):color(8)..(' %s':format(party_calls.kill and 'ON' or 'OFF')):color(200))
		elseif arg == 'ls' or arg == 'lowscore' or arg == 'loscore' then
			party_calls.ls = not party_calls.ls
			add_to_chat(8,('[Leaderboard] '):color(220)..('LOW WS call:'):color(8)..(' %s':format(party_calls.ls and 'ON' or 'OFF')):color(200))
		elseif arg == 'mb' or arg == 'magicburst' or arg == 'burst' then
			party_calls.mb = not party_calls.mb
			add_to_chat(8,('[Leaderboard] '):color(220)..('MAGIC BURST call:'):color(8)..(' %s':format(party_calls.mb and 'ON' or 'OFF')):color(200))
		elseif arg == 'ml' or arg == 'melee' or arg == 'mele' then
			party_calls.melee = not party_calls.melee
			add_to_chat(8,('[Leaderboard] '):color(220)..('MELEE call:'):color(8)..(' %s':format(party_calls.melee and 'ON' or 'OFF')):color(200))
		elseif arg == 'm' or arg == 'murder' or arg == 'murders' or arg == 'v' or arg == 'victim' or arg == 'victims' then
			party_calls.murder = not party_calls.murder
			add_to_chat(8,('[Leaderboard] '):color(220)..('MURDER/VICTIM call:'):color(8)..(' %s':format(party_calls.murder and 'ON' or 'OFF')):color(200))
		elseif arg == 'n' or arg == 'nuke' or arg == 'nukes' then
			party_calls.nuke = not party_calls.nuke
			add_to_chat(8,('[Leaderboard] '):color(220)..('NUKE call:'):color(8)..(' %s':format(party_calls.nuke and 'ON' or 'OFF')):color(200))
		elseif arg == 'ra' or arg == 'range' or arg == 'ranged' or arg == 'rangedatt' or arg == 'rangedattack' then
			party_calls.ra = not party_calls.ra
			add_to_chat(8,('[Leaderboard] '):color(220)..('RANGED ATT call:'):color(8)..(' %s':format(party_calls.ra and 'ON' or 'OFF')):color(200))
		elseif arg == 'sc' or arg == 'skillchain' or arg == 'skillchains' then
			party_calls.sc = not party_calls.sc
			add_to_chat(8,('[Leaderboard] '):color(220)..('SKILLCHAIN call:'):color(8)..(' %s':format(party_calls.sc and 'ON' or 'OFF')):color(200))
		elseif arg == 'td' or arg == 'totaldamage' or arg == 'totaldmg' or arg == 'totdmg' then
			party_calls.td = not party_calls.td
			add_to_chat(8,('[Leaderboard] '):color(220)..('TOTAL DMG call:'):color(8)..(' %s':format(party_calls.td and 'ON' or 'OFF')):color(200))
		elseif arg == 'ws' or arg == 'weaponskill' or arg == 'weaponskills' then
			party_calls.ws = not party_calls.ws
			add_to_chat(8,('[Leaderboard] '):color(220)..('TOTAL WS call:'):color(8)..(' %s':format(party_calls.ws and 'ON' or 'OFF')):color(200))
		elseif arg == 'w' or arg == 'whiff' or arg == 'whiffs' then
			party_calls.whiff = not party_calls.whiff
			add_to_chat(8,('[Leaderboard] '):color(220)..('WHIFF call:'):color(8)..(' %s':format(party_calls.whiff and 'ON' or 'OFF')):color(200))
		else
			add_to_chat(8,('[Leaderboard] '):color(220)..('Party/Raid/Mog Kart Mode party call settings'):color(220))
			add_to_chat(8,(' BUFF (b):'):color(36)..((' %s'):format(party_calls.buff and 'ON' or 'OFF')):color(200))
			add_to_chat(8,(' CURE (c):'):color(36)..((' %s'):format(party_calls.cure and 'ON' or 'OFF')):color(200))
			add_to_chat(8,(' DEATH (d):'):color(36)..((' %s'):format(party_calls.death and 'ON' or 'OFF')):color(200))
			add_to_chat(8,(' DEBUFF (db):'):color(36)..((' %s'):format(party_calls.debuff and 'ON' or 'OFF')):color(200))
			add_to_chat(8,(' HIGH WS (hs):'):color(36)..((' %s'):format(party_calls.hs and 'ON' or 'OFF')):color(200))
			add_to_chat(8,(' KILL (k):'):color(36)..((' %s'):format(party_calls.kill and 'ON' or 'OFF')):color(200))
			add_to_chat(8,(' LOW WS (ls):'):color(36)..((' %s'):format(party_calls.ls and 'ON' or 'OFF')):color(200))
			add_to_chat(8,(' MAGIC BURST (mb):'):color(36)..((' %s'):format(party_calls.mb and 'ON' or 'OFF')):color(200))
			add_to_chat(8,(' MELEE (ml):'):color(36)..((' %s'):format(party_calls.melee and 'ON' or 'OFF')):color(200))
			add_to_chat(8,(' MURDER/VICTIM (m):'):color(36)..((' %s'):format(party_calls.murder and 'ON' or 'OFF')):color(200))
			add_to_chat(8,(' NUKE (n):'):color(36)..((' %s'):format(party_calls.nuke and 'ON' or 'OFF')):color(200))
			add_to_chat(8,(' RANGED ATT (ra):'):color(36)..((' %s'):format(party_calls.ra and 'ON' or 'OFF')):color(200))
			add_to_chat(8,(' SKILLCHAIN (sc):'):color(36)..((' %s'):format(party_calls.sc and 'ON' or 'OFF')):color(200))
			add_to_chat(8,(' TOTAL DMG (td):'):color(36)..((' %s'):format(party_calls.td and 'ON' or 'OFF')):color(200))
			add_to_chat(8,(' TOTAL WS (ws):'):color(36)..((' %s'):format(party_calls.ws and 'ON' or 'OFF')):color(200))
			add_to_chat(8,(' WHIFF (w):'):color(36)..((' %s'):format(party_calls.whiff and 'ON' or 'OFF')):color(200))
		end
		settings:save('all')


	--Reminder setting
	elseif addcmd == 'reminder' or addcmd == 'reminders' or addcmd == 'remind' then
		settings.reminder = not settings.reminder
		add_to_chat(8,('[Leaderboard] '):color(220)..('Reminders:'):color(36)..(' %s':format(settings.reminder and 'ON' or 'OFF')):color(200))
		settings:save('all')


	--Bold setting
	elseif addcmd == 'bold' then
		settings.flags.bold = not settings.flags.bold
		texts.bold(lbBox, settings.flags.bold)
		add_to_chat(8,('[Leaderboard] '):color(220)..('Bold:'):color(36)..(' %s':format(settings.flags.bold and 'ON' or 'OFF')):color(200))
		settings:save('all')


	--Font Size setting
	elseif addcmd == 'size' or addcmd == 'fontsize' then
		local size = {...}
		if #size < 1 then
			add_to_chat(8,('[Leaderboard] '):color(220)..('Font Size:'):color(36)..(' '..settings.text.size):color(200))
		elseif tonumber(size[1]) ~= nil then
			settings.text.size = size[1]
			settings:save('all')
			texts.size(lbBox, settings.text.size)
			add_to_chat(8,('[Leaderboard] '):color(220)..('Font Size:'):color(36)..(' '..settings.text.size):color(200))
		else
			add_to_chat(8,('[Leaderboard] '):color(220)..('Font Size must be a number.'):color(8))
		end


	--BG Alpha setting
	elseif addcmd == 'alpha' or addcmd == 'bgalpha' then
		local alpha = {...}
		if #alpha < 1 then
			add_to_chat(8,('[Leaderboard] '):color(220)..('Alpha:'):color(36)..(' '..settings.bg.alpha):color(200))
		elseif tonumber(alpha[1]) ~= nil and tonumber(alpha[1]) >= 0 and tonumber(alpha[1]) <= 255 then
			settings.bg.alpha = alpha[1]
			settings:save('all')
			texts.bg_alpha(lbBox, settings.bg.alpha)
			add_to_chat(8,('[Leaderboard] '):color(220)..('Alpha:'):color(36)..(' '..settings.bg.alpha):color(200))
		else
			add_to_chat(8,('[Leaderboard] '):color(220)..('Alpha must be a number 0-255.'):color(8))
		end


	--Comma setting
	elseif addcmd == 'comma' or addcmd == 'commas' then
		settings.commas = not settings.commas
		add_to_chat(8,('[Leaderboard] '):color(220)..('Commas:'):color(36)..(' %s':format(settings.commas and 'ON' or 'OFF')):color(200))
		settings:save('all')
		updateBox(box_display)


	--Party Commands setting
	elseif addcmd == 'partycommand' or addcmd == 'partycmd' or addcmd == 'partycommands' or addcmd == 'pcmd' then
		settings.party_commands = not settings.party_commands
		add_to_chat(8,('[Leaderboard] '):color(220)..('Party Commands (Party/Raid/Mog Kart mode only):'):color(36)..(' %s':format(settings.party_commands and 'ON' or 'OFF')):color(200))
		settings:save('all')


	--Flood Delay setting
	elseif addcmd == 'flood' or addcmd == 'flooddelay' then
		if arg == nil then
			add_to_chat(8,('[Leaderboard] '):color(220)..('Flood Delay for Party Commands: '):color(36)..(settings.flood_delay..' seconds.'):color(200))
		elseif tonumber(arg) ~= nil then
			settings.flood_delay = arg
			settings:save('all')
			add_to_chat(8,('[Leaderboard] '):color(220)..('Flood Delay for Party Commands: '):color(36)..(settings.flood_delay..' seconds.'):color(200))
		else
			add_to_chat(8,('[Leaderboard] '):color(220)..('Flood Delay must be a number.'):color(8))
		end


	--Mog Kart Mode Point Board Callout Time setting
	elseif addcmd == 'boardtime' or addcmd == 'boardtimer' then
		local timer = {...}
		if #timer < 1 then
			add_to_chat(8,('[Leaderboard] '):color(220)..('Timer for Mog Kart Mode Point Board Callout:'):color(36)..(' '..settings.kart_p_board_time..('%s'):format(settings.kart_p_board_time == 0 and ' (off)' or '')):color(200))
		elseif tonumber(timer[1]) ~= nil then
			settings.kart_p_board_time = tonumber(timer[1])
			settings:save('all')
			add_to_chat(8,('[Leaderboard] '):color(220)..('Timer for Mog Kart Mode Point Board Callout:'):color(36)..(' '..settings.kart_p_board_time..('%s'):format(settings.kart_p_board_time == 0 and ' (off)' or '')):color(200))
		else
			add_to_chat(8,('[Leaderboard] '):color(220)..('Timer for Mog Kart Mode Point Board Callout must be a number.'):color(8))
		end


	--Mog Kart Mode Give Item interval setting
	elseif addcmd == 'itemtime' or addcmd == 'itemtimer' then
		local timer = {...}
		if #timer < 1 then
			add_to_chat(8,('[Leaderboard] '):color(220)..('Timer for Mog Kart Mode Give Item Box:'):color(36)..(' '..settings.kart_item_interval):color(200))
		elseif tonumber(timer[1]) ~= nil then
			settings.kart_item_interval = tonumber(timer[1])
			settings:save('all')
			add_to_chat(8,('[Leaderboard] '):color(220)..('Timer for Mog Kart Mode Give Item Box:'):color(36)..(' '..settings.kart_item_interval):color(200))
		else
			add_to_chat(8,('[Leaderboard] '):color(220)..('Timer for Mog Kart Mode Give Item Box must be a number.'):color(8))
		end


	--Display help
	elseif addcmd == 'help' then
		local prefix = "//leaderboard, //lb"
		add_to_chat(8,('[Leaderboard] '):color(220)..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220)..(' ('):color(8)..(prefix):color(1)..(')'):color(8))
		add_to_chat(8,(' Command '):color(36)..('[optional]'):color(53)..(' <required>'):color(2)..(' - Description ['):color(8)..('Current Setting'):color(200)..(']'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,(' Basic '):color(220))
		add_to_chat(8,(' pause'):color(36)..(' - Pause/unpause tracking.'):color(8))
		add_to_chat(8,(' b/c/d/db/hs/k/ls/m/mb/ml/n/p/ra/sc/td/v/ws/w'):color(36)..(' - Print board to party chat.'):color(8))
		add_to_chat(8,(' mode/kart/raid/party/silent'):color(36)..(' - Display/change the current Mode.'):color(8))
		add_to_chat(8,(' reset'):color(36)..(' <all/i/b/c/d/db/hs/k/ls/m/mb/ml/n/p/ra/sc/td/v/ws/w>'):color(2)..(' - Reset specified data.'):color(8))
		add_to_chat(8,(' show/hide'):color(36)..(' [#/b/c/d/db/hs/k/ls/m/mb/ml/n/p/ra/sc/td/v/ws/w]'):color(53)..(' - Display board on screen.'):color(8))
		add_to_chat(8,(' boards'):color(36)..(' - List the different boards that are tracked.'):color(8))
		add_to_chat(8,(' rival'):color(36)..(' <name>'):color(2)..(' - Set the specified player as your Rival. Repeat to remove.'):color(8))
		add_to_chat(8,(' taunt'):color(36)..(' [text]'):color(53)..(' - Send your rival a tell with which boards you have them beat on.'):color(8))
		add_to_chat(8,'   - Including [text] updates the taunt text. Must include a \'%s\' where the boards will go.')
		add_to_chat(8,' ')
		add_to_chat(8,(' Advanced '):color(220))
		add_to_chat(8,(' call'):color(36)..(' [b/c/d/db/hs/k/ls/m/mb/ml/n/ra/sc/td/ws/w]'):color(53)..(' - Display/change the party chat call settings.'):color(8))
		add_to_chat(8,(' lock/unlock'):color(36)..(' - Drag the On-Screen Display.'):color(8))
		add_to_chat(8,(' optout'):color(36)..(' [add/remove'):color(53)..(' <name>'):color(2)..(']'):color(53)..(' - Display/update the Optout list.'):color(8))
		add_to_chat(8,(' report'):color(36)..(' <name>'):color(2)..(' - Send the specified player their score report via tell.'):color(8))
		add_to_chat(8,(' reminder'):color(36)..(' - Enable/disable the Reminder.'):color(8))
		add_to_chat(8,(' alpha'):color(36)..(' [#]'):color(53)..(' - Update the bg alpha for the on-screen display.'):color(8))
		add_to_chat(8,(' bold'):color(36)..(' - Enable/disable the bold setting for the on-screen display.'):color(8))
		add_to_chat(8,(' comma'):color(36)..(' - Enable/disable Commas in the scores.'):color(8))
		add_to_chat(8,(' size'):color(36)..(' [#]'):color(53)..(' - Update the font size for the on-screen display.'):color(8))
		add_to_chat(8,(' partycommand/pcmd'):color(36)..(' - Enable/disable Party Commands.'):color(8))
		add_to_chat(8,(' flood'):color(36)..(' [#]'):color(53)..(' - Display/change the current Flood Delay for Party Commands.'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,(' Kart Mode '):color(220))
		add_to_chat(8,(' itemtimer'):color(36)..(' [#]'):color(53)..(' - Update the interval timer between Item Boxes.'):color(8))
		add_to_chat(8,(' boardtimer'):color(36)..(' [#]'):color(53)..(' - Update the timer between Points Board chat callout (0 = off).'):color(8))
		add_to_chat(8,(' randomitem'):color(36)..(' - Give a random player a random item.'):color(8))


	--Pause
	elseif addcmd == 'pause' then
		if not live.paused then
			live.paused = true
		else
			live.paused = false
		end
		live:save('all')
		if settings.mode ~= "Silent" then
			newChatMessage(('/p [LB] '..settings.mode..' Mode %s'):format(live.paused and 'Paused' or 'Unpaused'))
		else
			add_to_chat(8,('[Leaderboard] '):color(220)..((settings.mode..' Mode %s'):format(live.paused and 'Paused' or 'Unpaused')):color(36))
		end
		updateBox(box_display)


	--Switch to Raid Mode
	elseif addcmd == 'raid' or (addcmd == 'mode' and (arg == 'raid' or arg == 'r')) then
		if settings.mode == "Raid" then
			add_to_chat(8,('[Leaderboard] '):color(220)..(('Raid Mode is currently active and %s.'):format(live.paused and 'paused' or 'running')):color(8))
		else
			settings.mode = "Raid"
			settings:save('all')
			newChatMessage(('/p [LB] Raid Mode activated and %s.'):format(live.paused and 'paused' or 'running'))
			updateBox(box_display)
		end


	--Switch to Mog Kart Mode
	elseif addcmd == 'kart' or addcmd == 'mog' or addcmd == 'mogkart' or (addcmd == 'mode' and (arg == 'kart' or arg == 'k' or arg == 'mog' or arg == 'm' or arg == 'mogkart')) then
		if settings.mode == "Mog Kart" then
			if arg == 'intro' then
				if live.paused == false then
					add_to_chat(8,('[Leaderboard] '):color(220)..('Mog Kart Mode is currently running. Please pause first before running the intro.'):color(8))
					return
				end
				newChatMessage("/p [LB] Welcome to Mog Kart!")
				newChatMessage("/p [LB] How to play: Players will occasionally receive an item (sent via tell from me).")
				newChatMessage("/p [LB] Reply to the tell with `item` to use the item.")
				newChatMessage("/p [LB] Reply to the tell with `info` to receive a short description.")
				newChatMessage("/p [LB] You may opt out of playing at any time by sending me a tell with `optout`.")
				resetALL()
				live.paused = false
				live:save('all')
				updateBox(box_display)
			else
				add_to_chat(8,('[Leaderboard] '):color(220)..(('Mog Kart Mode is currently active and %s.'):format(live.paused and 'paused' or 'running')):color(8))
			end
		else
			settings.mode = "Mog Kart"
			settings:save('all')
			live.paused = true
			live:save('all')
			newChatMessage(('/p [LB] Mog Kart Mode activated and %s.'):format(live.paused and 'paused' or 'running'))
			box_display = 'point'
			updateBox(box_display)
			coroutine.sleep(1)
			add_to_chat(8,('[Leaderboard] '):color(220)..('Beware - Mog Kart Mode uses party chat and tells heavily.'):color(8))
			add_to_chat(8,('[Leaderboard] '):color(220)..('Currently paused.'):color(8))
			add_to_chat(8,('[Leaderboard] '):color(220)..('//lb kart intro'):color(1)..(' - Unpause, reset all data, and display how to play in party chat.'):color(8))
			add_to_chat(8,('[Leaderboard] '):color(220)..('//lb pause'):color(1)..(' - Unpause, keep all current data.'):color(8))
			if settings.kart_p_board_time ~= 0 then
				kart_p_board_time = 1 --start the points board callout timer back up
			end
		end


	--Switch to Party Mode
	elseif addcmd == 'party' or (addcmd == 'mode' and (arg == 'party' or arg == 'p')) then
		if settings.mode == "Party" then
			add_to_chat(8,('[Leaderboard] '):color(220)..(('Party Mode is currently active and %s.'):format(live.paused and 'paused' or 'running')):color(8))
		else
			settings.mode = "Party"
			settings:save('all')
			newChatMessage(('/p [LB] Party Mode activated and %s.'):format(live.paused and 'paused' or 'running'))
			coroutine.sleep(0.5)
			add_to_chat(8,('[Leaderboard] '):color(220)..('Beware - Party Mode uses party chat heavily.'):color(8))
			updateBox(box_display)
		end


	--Switch to Silent Mode
	elseif addcmd == 'silent' or (addcmd == 'mode' and (arg == 'silent' or arg == 's')) then
		if settings.mode == "Silent" then
			add_to_chat(8,('[Leaderboard] '):color(220)..(('Silent Mode is currently active and %s.'):format(live.paused and 'paused' or 'running')):color(8))
		else
			settings.mode = "Silent"
			settings:save('all')
			add_to_chat(8,('[Leaderboard] '):color(220)..(('Silent Mode activated and %s.'):format(live.paused and 'paused' or 'running')):color(8))
			updateBox(box_display)
		end


	--Display which mode Leaderboard is currently running in
	elseif addcmd == 'mode' then
		add_to_chat(8,('[Leaderboard] '):color(220)..(('Currently %s'):format(live.paused and 'paused' or 'running')..' in '..settings.mode..' Mode'):color(8))


	--Display the commands for the different boards
	elseif addcmd == 'board' or addcmd == 'boards' or addcmd == 'leaderboard' or addcmd == 'leaderboards' then
		add_to_chat(8,('[Leaderboard] '):color(220)..('Current Tracked Boards'):color(220))
		add_to_chat(8,(' buff/b'):color(36)..(' - Running total of buffs landed/removed'):color(8))
		add_to_chat(8,(' cure/c'):color(36)..(' - Running total of cures'):color(8))
		add_to_chat(8,(' death/d'):color(36)..(' - Running total of deaths'):color(8))
		add_to_chat(8,(' debuff/db'):color(36)..(' - Running total of debuffs landed/removed'):color(8))
		add_to_chat(8,(' highscore/hs'):color(36)..(' - Highest individual WS damage'):color(8))
		add_to_chat(8,(' kill/k'):color(36)..(' - Running total of kills'):color(8))
		add_to_chat(8,(' lowscore/ls'):color(36)..(' - Lowest individual WS damage'):color(8))
		add_to_chat(8,(' magicburst/mb'):color(36)..(' - Highest individual MB damage'):color(8))
		add_to_chat(8,(' melee/ml'):color(36)..(' - Running total of melee damage'):color(8))
		add_to_chat(8,(' murder/m'):color(36)..(' - Running total of murders'):color(8))
		add_to_chat(8,(' nuke/nk'):color(36)..(' - Running total of nukes'):color(8))
		add_to_chat(8,(' point/p'):color(36)..(' - Running total of points'):color(8))
		add_to_chat(8,(' ranged/ra'):color(36)..(' - Running total of ranged attacks'):color(8))
		add_to_chat(8,(' skillchain/sc'):color(36)..(' - Highest individual SC damage'):color(8))
		add_to_chat(8,(' totaldamage/td'):color(36)..(' - Running total of overall damage'):color(8))
		add_to_chat(8,(' victim/v'):color(36)..(' - Running total of victims'):color(8))
		add_to_chat(8,(' weaponskill/ws'):color(36)..(' - Running total of weapon skills'):color(8))
		add_to_chat(8,(' whiff/w'):color(36)..(' - Running total of whiffs'):color(8))


	--ALL BOARDS
	elseif addcmd == 'all' then
		if output_all then
			output_all = false
			add_to_chat(8,('[Leaderboard] '):color(220)..('Board output cancelled.'):color(8))
		else
			local delay = settings.output_all_delay
			output_all = true

			--Original boards list
			local boards = {'hs', 'ls', 'ws', 'sc', 'whiff', 'melee', 'ra', 'nuke', 'mb', 'cure', 'buff', 'debuff', 'kill', 'death', 'murder', 'victim', 'td', 'point'}

			--Create table of selected boards based on settings
			local selected_boards = {}
			for i = 1, #boards do
				local board = boards[i]
				if settings.all_command_callouts[board] then
					table.insert(selected_boards, board)
				end
			end

			add_to_chat(8,('[Leaderboard] '):color(220)..('Outputting '):color(8)..(tostring(#selected_boards)):color(1)..(' boards to party chat. Starting in '):color(8)..(tostring(delay)):color(1)..(' seconds.'):color(8))
			coroutine.sleep(1)
			local approx_time = (#selected_boards - 1) * delay
			add_to_chat(8,('[Leaderboard] '):color(220)..('Process will take approximately '):color(8)..(tostring(approx_time)):color(1)..(' seconds to complete.'):color(8))
			coroutine.sleep(1)
			add_to_chat(8,('[Leaderboard] '):color(220)..('Repeat '):color(8)..('//lb all'):color(1)..(' at any time to cancel.'):color(8))
			coroutine.sleep(delay)

			--Output only the selected boards
			for i = 1, #selected_boards do
				if output_all then
					local board = selected_boards[i]
					cmd('lb ' .. board)
					coroutine.sleep(.1)
					if i == #selected_boards then
						add_to_chat(8,('[Leaderboard] '):color(220)..('('):color(8)..(tostring(i)):color(1)..('/'):color(8)..(tostring(#selected_boards)):color(1)..(') Board output complete.'):color(8))
						output_all = false
					else
						add_to_chat(8,('[Leaderboard] '):color(220)..('('):color(8)..(tostring(i)):color(1)..('/'):color(8)..(tostring(#selected_boards)):color(1)..(') Repeat '):color(8)..('//lb all'):color(1)..(' to cancel.'):color(8))
						coroutine.sleep(delay)
					end
				else
					break
				end
			end
		end


	--BUFF BOARD
	elseif addcmd == 'b' or addcmd == 'buff' or addcmd == 'buffs' then
		if arg == 'reset' then
			resetB()
			updateBox(box_display)
			add_to_chat(8,('[Leaderboard] '):color(220)..('BUFF data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'buff'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'calls' or arg == 'callout' or arg == 'callouts' then
			settings.party_calls.buff = not settings.party_calls.buff
			add_to_chat(8,('[Leaderboard] '):color(220)..('BUFF call:'):color(8)..(' %s':format(settings.party_calls.buff and 'ON' or 'OFF')):color(200))
			settings:save('all')
		else
			local places = live.places.buff
			local info = getPlacesInfo(places)
			if arg == 'all' then
				if places.first == nil then
					local text = "/p \r--BUFF BOARD--\rNo Buffs Landed/Removed Yet"
					newChatMessage(text)
				else
					if #info.name >= 1 then
						local text = "/p \r--"..uppercase(places.first.name).."\'S BUFF BOARD--"
						for i = 1, 3, 1 do
							if info.name[i] ~= nil then
								local pct = math.floor((info.score[i] / info.nines[i]) * 100 + .5)
								text = text.."\r"..i.."|"..capitalize(info.name[i])..": "..addCommas(info.score[i])..":"..info.nines[i].." "..pct.."%"
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 4 then
						local text = "/p "
						for i = 4, 8, 1 do
							if info.name[i] ~= nil then
								local pct = math.floor((info.score[i] / info.nines[i]) * 100 + .5)
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])..":"..info.nines[i].." "..pct.."%"
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 9 then
						local text = "/p "
						for i = 9, 13, 1 do
							if info.name[i] ~= nil then
								local pct = math.floor((info.score[i] / info.nines[i]) * 100 + .5)
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])..":"..info.nines[i].." "..pct.."%"
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 14 then
						local text = "/p "
						for i = 14, 18, 1 do
							if info.name[i] ~= nil then
								local pct = math.floor((info.score[i] / info.nines[i]) * 100 + .5)
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])..":"..info.nines[i].." "..pct.."%"
							end
						end
						newChatMessage(text)
					end
				end
			else
				local chatmode = 'p'
				if arg == 'l2' or arg == 'ls2' then
					chatmode = 'l2'
				elseif arg == 'l' or arg == 'l1' or arg == 'ls' or arg == 'ls1' then
					chatmode = 'l'
				end
				local text = ""
				if places.first == nil then
					text = "/"..chatmode.." \r--BUFF BOARD--\rNo Buffs Landed/Removed Yet"
				else
					text = "/"..chatmode.." \r--"..uppercase(places.first.name).."\'S BUFF BOARD--"
					for i = 1, 5, 1 do
						if info.name[i] ~= nil then
							local pct = math.floor((info.score[i] / info.nines[i]) * 100 + .5)
							text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i]).."/"..info.nines[i].." "..pct.."%"
						end
					end
				end
				newChatMessage(text)
			end
		end


	--CURE BOARD
	elseif addcmd == 'c' or addcmd == 'cure' or addcmd == 'cures' then
		if arg == 'reset' then
			resetC()
			updateBox(box_display)
			add_to_chat(8,('[Leaderboard] '):color(220)..('CURE data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'cure'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'calls' or arg == 'callout' or arg == 'callouts' then
			settings.party_calls.cure = not settings.party_calls.cure
			add_to_chat(8,('[Leaderboard] '):color(220)..('CURE call:'):color(8)..(' %s':format(settings.party_calls.cure and 'ON' or 'OFF')):color(200))
			settings:save('all')
		else
			local places = live.places.cure
			local info = getPlacesInfo(places)
			if arg == 'all' then
				if places.first == nil then
					local text = "/p \r--CURE BOARD--\rNo Cures Yet"
					newChatMessage(text)
				else
					if #info.name >= 1 then
						local text = "/p \r--"..uppercase(places.first.name).."\'S CURE BOARD--"
						for i = 1, 3, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalize(info.name[i])..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 4 then
						local text = "/p "
						for i = 4, 8, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 9 then
						local text = "/p "
						for i = 9, 13, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 14 then
						local text = "/p "
						for i = 14, 18, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
				end
			else
				local chatmode = 'p'
				if arg == 'l2' or arg == 'ls2' then
					chatmode = 'l2'
				elseif arg == 'l' or arg == 'l1' or arg == 'ls' or arg == 'ls1' then
					chatmode = 'l'
				end
				local text = ""
				if places.first == nil then
					text = "/"..chatmode.." \r--CURE BOARD--\rNo Cures Yet"
				else
					text = "/"..chatmode.." \r--"..uppercase(places.first.name).."\'S CURE BOARD--"
					for i = 1, 5, 1 do
						if info.name[i] ~= nil then
							text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
						end
					end
				end
				newChatMessage(text)
			end
		end


	--DEBUFF BOARD
	elseif addcmd == 'db' or addcmd == 'debuff' or addcmd == 'debuffs' then
		if arg == 'reset' then
			resetDB()
			updateBox(box_display)
			add_to_chat(8,('[Leaderboard] '):color(220)..('DEBUFF data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'debuff'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'calls' or arg == 'callout' or arg == 'callouts' then
			settings.party_calls.debuff = not settings.party_calls.debuff
			add_to_chat(8,('[Leaderboard] '):color(220)..('DEBUFF call:'):color(8)..(' %s':format(settings.party_calls.debuff and 'ON' or 'OFF')):color(200))
			settings:save('all')
		else
			local places = live.places.debuff
			local info = getPlacesInfo(places)
			if arg == 'all' then
				if places.first == nil then
					local text = "/p \r--DEBUFF BOARD--\rNo Debuffs Landed/Removed Yet"
					newChatMessage(text)
				else
					if #info.name >= 1 then
						local text = "/p \r--"..uppercase(places.first.name).."\'S DEBUFF BOARD--"
						for i = 1, 3, 1 do
							if info.name[i] ~= nil then
								local pct = math.floor((info.score[i] / info.nines[i]) * 100 + .5)
								text = text.."\r"..i.."|"..capitalize(info.name[i])..": "..addCommas(info.score[i])..":"..info.nines[i].." "..pct.."%"
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 4 then
						local text = "/p "
						for i = 4, 8, 1 do
							if info.name[i] ~= nil then
								local pct = math.floor((info.score[i] / info.nines[i]) * 100 + .5)
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])..":"..info.nines[i].." "..pct.."%"
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 9 then
						local text = "/p "
						for i = 9, 13, 1 do
							if info.name[i] ~= nil then
								local pct = math.floor((info.score[i] / info.nines[i]) * 100 + .5)
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])..":"..info.nines[i].." "..pct.."%"
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 14 then
						local text = "/p "
						for i = 14, 18, 1 do
							if info.name[i] ~= nil then
								local pct = math.floor((info.score[i] / info.nines[i]) * 100 + .5)
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])..":"..info.nines[i].." "..pct.."%"
							end
						end
						newChatMessage(text)
					end
				end
			else
				local chatmode = 'p'
				if arg == 'l2' or arg == 'ls2' then
					chatmode = 'l2'
				elseif arg == 'l' or arg == 'l1' or arg == 'ls' or arg == 'ls1' then
					chatmode = 'l'
				end
				local text = ""
				if places.first == nil then
					text = "/"..chatmode.." \r--DEBUFF BOARD--\rNo Debuffs Landed/Removed Yet"
				else
					text = "/"..chatmode.." \r--"..uppercase(places.first.name).."\'S DEBUFF BOARD--"
					for i = 1, 5, 1 do
						if info.name[i] ~= nil then
							local pct = math.floor((info.score[i] / info.nines[i]) * 100 + .5)
							text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i]).."/"..info.nines[i].." "..pct.."%"
						end
					end
				end
				newChatMessage(text)
			end
		end


	--DEATH BOARD
	elseif addcmd == 'd' or addcmd == 'death' or addcmd == 'deaths' then
		if arg == 'reset' then
			resetD()
			updateBox(box_display)
			add_to_chat(8,('[Leaderboard] '):color(220)..('DEATH data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'death'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'calls' or arg == 'callout' or arg == 'callouts' then
			settings.party_calls.death = not settings.party_calls.death
			add_to_chat(8,('[Leaderboard] '):color(220)..('DEATH call:'):color(8)..(' %s':format(settings.party_calls.death and 'ON' or 'OFF')):color(200))
			settings:save('all')
		else
			local places = live.places.death
			local info = getPlacesInfo(places)
			if arg == 'all' then
				if places.first == nil then
					local text = "/p \r--DEATH BOARD--\rNo Deaths Yet"
					newChatMessage(text)
				else
					if #info.name >= 1 then
						local text = "/p \r--"..uppercase(places.first.name).."\'S DEATH BOARD--"
						for i = 1, 3, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalize(info.name[i])..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 4 then
						local text = "/p "
						for i = 4, 8, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 9 then
						local text = "/p "
						for i = 9, 13, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 14 then
						local text = "/p "
						for i = 14, 18, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
				end
			else
				local chatmode = 'p'
				if arg == 'l2' or arg == 'ls2' then
					chatmode = 'l2'
				elseif arg == 'l' or arg == 'l1' or arg == 'ls' or arg == 'ls1' then
					chatmode = 'l'
				end
				local text = ""
				if places.first == nil then
					text = "/"..chatmode.." \r--DEATH BOARD--\rNo Deaths Yet"
				else
					text = "/"..chatmode.." \r--"..uppercase(places.first.name).."\'S DEATH BOARD--"
					for i = 1, 5, 1 do
						if info.name[i] ~= nil then
							text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
						end
					end
				end
				newChatMessage(text)
			end
		end


	--HIGH WS BOARD
	elseif addcmd == 'hs' or addcmd == 'highscore' or addcmd == 'hiscore' then
		if arg == 'reset' then
			resetHS()
			add_to_chat(8,('[Leaderboard] '):color(220)..('HIGH WS data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'hs'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'calls' or arg == 'callout' or arg == 'callouts' then
			settings.party_calls.hs = not settings.party_calls.hs
			add_to_chat(8,('[Leaderboard] '):color(220)..('HIGH WS call:'):color(8)..(' %s':format(settings.party_calls.hs and 'ON' or 'OFF')):color(200))
			settings:save('all')
		else
			local places = live.places.hs
			local info = getPlacesInfo(places)
			if arg == 'all' then
				if places.first == nil then
					local text = "/p \r--HIGH WS BOARD--\rNo Weapon Skills Yet"
					newChatMessage(text)
				else
					if #info.name >= 1 then
						local text = "/p \r--"..uppercase(places.first.name).."\'S HIGH WS BOARD--"
						for i = 1, 3, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalize(info.name[i])..": "..addCommas(info.score[i])..("%s"):format(info.nines[i] > 0 and ":"..info.nines[i] or "")
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 4 then
						local text = "/p "
						for i = 4, 8, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])..("%s"):format(info.nines[i] > 0 and ":"..info.nines[i] or "")
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 9 then
						local text = "/p "
						for i = 9, 13, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])..("%s"):format(info.nines[i] > 0 and ":"..info.nines[i] or "")
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 14 then
						local text = "/p "
						for i = 14, 18, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])..("%s"):format(info.nines[i] > 0 and ":"..info.nines[i] or "")
							end
						end
						newChatMessage(text)
					end
				end
			else
				local chatmode = 'p'
				if arg == 'l2' or arg == 'ls2' then
					chatmode = 'l2'
				elseif arg == 'l' or arg == 'l1' or arg == 'ls' or arg == 'ls1' then
					chatmode = 'l'
				end
				local text = ""
				if places.first == nil then
					text = "/"..chatmode.." \r--HIGH WS BOARD--\rNo Weapon Skills Yet"
				else
					text = "/"..chatmode.." \r--"..uppercase(places.first.name).."\'S HIGH WS BOARD--"
					for i = 1, 5, 1 do
						if info.name[i] ~= nil then
							text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])..("%s"):format(info.nines[i] > 0 and ":"..info.nines[i] or "")
						end
					end
				end
				newChatMessage(text)
			end
		end


	--KILL BOARD
	elseif addcmd == 'k' or addcmd == 'kill' or addcmd == 'kills' then
		if arg == 'reset' then
			resetK()
			updateBox(box_display)
			add_to_chat(8,('[Leaderboard] '):color(220)..('KILL data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'kill'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'calls' or arg == 'callout' or arg == 'callouts' then
			settings.party_calls.kill = not settings.party_calls.kill
			add_to_chat(8,('[Leaderboard] '):color(220)..('KILL call:'):color(8)..(' %s':format(settings.party_calls.kill and 'ON' or 'OFF')):color(200))
			settings:save('all')
		else
			local places = live.places.kill
			local info = getPlacesInfo(places)
			if arg == 'all' then
				if places.first == nil then
					local text = "/p \r--KILL BOARD--\rNo Kills Yet"
					newChatMessage(text)
				else
					if #info.name >= 1 then
						local text = "/p \r--"..uppercase(places.first.name).."\'S KILL BOARD--"
						for i = 1, 3, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalize(info.name[i])..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 4 then
						local text = "/p "
						for i = 4, 8, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 9 then
						local text = "/p "
						for i = 9, 13, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 14 then
						local text = "/p "
						for i = 14, 18, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
				end
			else
				local chatmode = 'p'
				if arg == 'l2' or arg == 'ls2' then
					chatmode = 'l2'
				elseif arg == 'l' or arg == 'l1' or arg == 'ls' or arg == 'ls1' then
					chatmode = 'l'
				end
				local text = ""
				if places.first == nil then
					text = "/"..chatmode.." \r--KILL BOARD--\rNo Kills Yet"
				else
					text = "/"..chatmode.." \r--"..uppercase(places.first.name).."\'S KILL BOARD--"
					for i = 1, 5, 1 do
						if info.name[i] ~= nil then
							text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
						end
					end
				end
				newChatMessage(text)
			end
		end


	--LOW WS BOARD
	elseif addcmd == 'ls' or addcmd == 'lowscore' or addcmd == 'loscore' then
		if arg == 'reset' then
			resetLS()
			updateBox(box_display)
			add_to_chat(8,('[Leaderboard] '):color(220)..('LOW WS data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'ls'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'calls' or arg == 'callout' or arg == 'callouts' then
			settings.party_calls.ls = not settings.party_calls.ls
			add_to_chat(8,('[Leaderboard] '):color(220)..('LOW WS call:'):color(8)..(' %s':format(settings.party_calls.ls and 'ON' or 'OFF')):color(200))
			settings:save('all')
		else
			local places = live.places.ls
			local info = getPlacesInfo(places)
			if arg == 'all' then
				if places.first == nil then
					local text = "/p \r--LOW WS BOARD--\rNo Weapon Skills Yet"
					newChatMessage(text)
				else
					if #info.name >= 1 then
						local text = "/p \r--"..uppercase(places.first.name).."\'S LOW WS BOARD--"
						for i = 1, 3, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalize(info.name[i])..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 4 then
						local text = "/p "
						for i = 4, 8, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 9 then
						local text = "/p "
						for i = 9, 13, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 14 then
						local text = "/p "
						for i = 14, 18, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
				end
			else
				local chatmode = 'p'
				if arg == 'l2' or arg == 'ls2' then
					chatmode = 'l2'
				elseif arg == 'l' or arg == 'l1' or arg == 'ls' or arg == 'ls1' then
					chatmode = 'l'
				end
				local text = ""
				if places.first == nil then
					text = "/"..chatmode.." \r--LOW WS BOARD--\rNo Weapon Skills Yet"
				else
					text = "/"..chatmode.." \r--"..uppercase(places.first.name).."\'S LOW WS BOARD--"
					for i = 1, 5, 1 do
						if info.name[i] ~= nil then
							text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
						end
					end
				end
				newChatMessage(text)
			end
		end


	--MAGIC BURST BOARD
	elseif addcmd == 'mb' or addcmd == 'magicburst' or addcmd == 'burst' then
		if arg == 'reset' then
			resetMB()
			updateBox(box_display)
			add_to_chat(8,('[Leaderboard] '):color(220)..('MAGIC BURST data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'mb'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'calls' or arg == 'callout' or arg == 'callouts' then
			settings.party_calls.mb = not settings.party_calls.mb
			add_to_chat(8,('[Leaderboard] '):color(220)..('MAGIC BURST call:'):color(8)..(' %s':format(settings.party_calls.mb and 'ON' or 'OFF')):color(200))
			settings:save('all')
		else
			local places = live.places.mb
			local info = getPlacesInfo(places)
			if arg == 'all' then
				if places.first == nil then
					local text = "/p \r--MAGIC BURST BOARD--\rNo Magic Bursts Yet"
					newChatMessage(text)
				else
					if #info.name >= 1 then
						local text = "/p \r--"..uppercase(places.first.name).."\'S MAGIC BURST BOARD--"
						for i = 1, 3, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalize(info.name[i])..": "..addCommas(info.score[i])..("%s"):format(info.nines[i] > 0 and ":"..info.nines[i] or "")
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 4 then
						local text = "/p "
						for i = 4, 8, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])..("%s"):format(info.nines[i] > 0 and ":"..info.nines[i] or "")
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 9 then
						local text = "/p "
						for i = 9, 13, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])..("%s"):format(info.nines[i] > 0 and ":"..info.nines[i] or "")
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 14 then
						local text = "/p "
						for i = 14, 18, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])..("%s"):format(info.nines[i] > 0 and ":"..info.nines[i] or "")
							end
						end
						newChatMessage(text)
					end
				end
			else
				local chatmode = 'p'
				if arg == 'l2' or arg == 'ls2' then
					chatmode = 'l2'
				elseif arg == 'l' or arg == 'l1' or arg == 'ls' or arg == 'ls1' then
					chatmode = 'l'
				end
				local text = ""
				if places.first == nil then
					text = "/"..chatmode.." \r--MAGIC BURST BOARD--\rNo Magic Burssts Yet"
				else
					text = "/"..chatmode.." \r--"..uppercase(places.first.name).."\'S MAGIC BURST BOARD--"
					for i = 1, 5, 1 do
						if info.name[i] ~= nil then
							text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])..("%s"):format(info.nines[i] > 0 and ":"..info.nines[i] or "")
						end
					end
				end
				newChatMessage(text)
			end
		end


	--MELEE BOARD
	elseif addcmd == 'ml' or addcmd == 'melee' or addcmd == 'mele' then
		if arg == 'reset' then
			resetML()
			updateBox(box_display)
			add_to_chat(8,('[Leaderboard] '):color(220)..('MELEE data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'melee'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'calls' or arg == 'callout' or arg == 'callouts' then
			settings.party_calls.melee = not settings.party_calls.melee
			add_to_chat(8,('[Leaderboard] '):color(220)..('MELEE call:'):color(8)..(' %s':format(settings.party_calls.melee and 'ON' or 'OFF')):color(200))
			settings:save('all')
		else
			local places = live.places.melee
			local info = getPlacesInfo(places)
			if arg == 'all' then
				if places.first == nil then
					local text = "/p \r--MELEE BOARD--\rNo Melee Damage Yet"
					newChatMessage(text)
				else
					if #info.name >= 1 then
						local text = "/p \r--"..uppercase(places.first.name).."\'S MELEE BOARD--"
						for i = 1, 3, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalize(info.name[i])..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 4 then
						local text = "/p "
						for i = 4, 8, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..abbreviateNumber(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 9 then
						local text = "/p "
						for i = 9, 13, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..abbreviateNumber(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 14 then
						local text = "/p "
						for i = 14, 18, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..abbreviateNumber(info.score[i])
							end
						end
						newChatMessage(text)
					end
				end
			else
				local chatmode = 'p'
				if arg == 'l2' or arg == 'ls2' then
					chatmode = 'l2'
				elseif arg == 'l' or arg == 'l1' or arg == 'ls' or arg == 'ls1' then
					chatmode = 'l'
				end
				local text = ""
				if places.first == nil then
					text = "/"..chatmode.." \r--MELEE BOARD--\rNo Nukes Yet"
				else
					text = "/"..chatmode.." \r--"..uppercase(places.first.name).."\'S MELEE BOARD--"
					for i = 1, 5, 1 do
						if info.name[i] ~= nil then
							text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..abbreviateNumber(info.score[i])
						end
					end
				end
				newChatMessage(text)
			end
		end


	--MURDER BOARD
	elseif addcmd == 'm' or addcmd == 'murder' or addcmd == 'murders' then
		if arg == 'reset' then
			resetM()
			updateBox(box_display)
			add_to_chat(8,('[Leaderboard] '):color(220)..('MURDER data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'murder'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'calls' or arg == 'callout' or arg == 'callouts' then
			settings.party_calls.murder = not settings.party_calls.murder
			add_to_chat(8,('[Leaderboard] '):color(220)..('MURDER call:'):color(8)..(' %s':format(settings.party_calls.murder and 'ON' or 'OFF')):color(200))
			settings:save('all')
		else
			local places = live.places.murder
			local info = getPlacesInfo(places)
			if arg == 'all' then
				if places.first == nil then
					local text = "/p \r--MURDER BOARD--\rNo Murders Yet"
					newChatMessage(text)
				else
					if #info.name >= 1 then
						local text = "/p \r--"..uppercase(places.first.name).."\'S MURDER BOARD--"
						for i = 1, 3, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalize(info.name[i])..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 4 then
						local text = "/p "
						for i = 4, 8, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 9 then
						local text = "/p "
						for i = 9, 13, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 14 then
						local text = "/p "
						for i = 14, 18, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
				end
			else
				local chatmode = 'p'
				if arg == 'l2' or arg == 'ls2' then
					chatmode = 'l2'
				elseif arg == 'l' or arg == 'l1' or arg == 'ls' or arg == 'ls1' then
					chatmode = 'l'
				end
				local text = ""
				if places.first == nil then
					text = "/"..chatmode.." \r--MURDER BOARD--\rNo Murders Yet"
				else
					text = "/"..chatmode.." \r--"..uppercase(places.first.name).."\'S MURDER BOARD--"
					for i = 1, 5, 1 do
						if info.name[i] ~= nil then
							text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
						end
					end
				end
				newChatMessage(text)
			end
		end


	--NUKE BOARD
	elseif addcmd == 'n' or addcmd == 'nuke' or addcmd == 'nukes' then
		if arg == 'reset' then
			resetN()
			updateBox(box_display)
			add_to_chat(8,('[Leaderboard] '):color(220)..('NUKE data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'nuke'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'calls' or arg == 'callout' or arg == 'callouts' then
			settings.party_calls.nuke = not settings.party_calls.nuke
			add_to_chat(8,('[Leaderboard] '):color(220)..('NUKE call:'):color(8)..(' %s':format(settings.party_calls.nuke and 'ON' or 'OFF')):color(200))
			settings:save('all')
		else
			local places = live.places.nuke
			local info = getPlacesInfo(places)
			if arg == 'all' then
				if places.first == nil then
					local text = "/p \r--NUKE BOARD--\rNo Nukes Yet"
					newChatMessage(text)
				else
					if #info.name >= 1 then
						local text = "/p \r--"..uppercase(places.first.name).."\'S NUKE BOARD--"
						for i = 1, 3, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalize(info.name[i])..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 4 then
						local text = "/p "
						for i = 4, 8, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..abbreviateNumber(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 9 then
						local text = "/p "
						for i = 9, 13, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..abbreviateNumber(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 14 then
						local text = "/p "
						for i = 14, 18, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..abbreviateNumber(info.score[i])
							end
						end
						newChatMessage(text)
					end
				end
			else
				local chatmode = 'p'
				if arg == 'l2' or arg == 'ls2' then
					chatmode = 'l2'
				elseif arg == 'l' or arg == 'l1' or arg == 'ls' or arg == 'ls1' then
					chatmode = 'l'
				end
				local text = ""
				if places.first == nil then
					text = "/"..chatmode.." \r--NUKE BOARD--\rNo Nukes Yet"
				else
					text = "/"..chatmode.." \r--"..uppercase(places.first.name).."\'S NUKE BOARD--"
					for i = 1, 5, 1 do
						if info.name[i] ~= nil then
							text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..abbreviateNumber(info.score[i])
						end
					end
				end
				newChatMessage(text)
			end
		end


	--POINT BOARD
	elseif addcmd == 'p' or addcmd == 'point' or addcmd == 'points' then
		if arg == 'reset' then
			resetP()
			updateBox(box_display)
			add_to_chat(8,('[Leaderboard] '):color(220)..('POINT data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'point'
			updateBox(box_display)
			settings.visible = true
			showBox()
		else
			local places = live.places.point
			local info = getPlacesInfo(places)
			if settings.mode == "Mog Kart" or arg == 'all' then
				if places.first == nil then
					local text = "/p \r--POINTS BOARD--\rNo Points Yet"
					newChatMessage(text)
				else
					if #info.name >= 1 then
						local text = "/p \r--"..uppercase(places.first.name).."\'S POINT BOARD--"
						for i = 1, 3, 1 do
							if info.name[i] ~= nil then
								text = text..'\r'..i.."|"..capitalize(info.name[i])..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 4 then
						local text = "/p "
						for i = 4, 8, 1 do
							if info.name[i] ~= nil then
								text = text..'\r'..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 9 then
						local text = "/p "
						for i = 9, 13, 1 do
							if info.name[i] ~= nil then
								text = text..'\r'..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 14 then
						local text = "/p "
						for i = 14, 18, 1 do
							if info.name[i] ~= nil then
								text = text..'\r'..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					
				end
				if settings.kart_p_board_time ~= 0 then
					kart_p_board_time = 1 --restart the timer
				end
			else
				local chatmode = 'p'
				if arg == 'l2' or arg == 'ls2' then
					chatmode = 'l2'
				elseif arg == 'l' or arg == 'l1' or arg == 'ls' or arg == 'ls1' then
					chatmode = 'l'
				end
				local text = ""
				if places.first == nil then
					text = "/"..chatmode.." \r--POINT BOARD--\rNo Points Yet"
				else
					text = "/"..chatmode.." \r--"..uppercase(places.first.name).."\'S POINT BOARD--"
					for i = 1, 5, 1 do
						if info.name[i] ~= nil then
							text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
						end
					end
				end
				newChatMessage(text)
			end
		end


	--RANGED ATT BOARD
	elseif addcmd == 'ra' or addcmd == 'range' or addcmd == 'ranged' or addcmd == 'rangedatt' or addcmd == 'rangedattack' then
		if arg == 'reset' then
			resetRA()
			updateBox(box_display)
			add_to_chat(8,('[Leaderboard] '):color(220)..('RANGED ATT data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'ra'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'calls' or arg == 'callout' or arg == 'callouts' then
			settings.party_calls.ra = not settings.party_calls.ra
			add_to_chat(8,('[Leaderboard] '):color(220)..('RANGED ATT call:'):color(8)..(' %s':format(settings.party_calls.ra and 'ON' or 'OFF')):color(200))
			settings:save('all')
		else
			local places = live.places.ra
			local info = getPlacesInfo(places)
			if arg == 'all' then
				if places.first == nil then
					local text = "/p \r--RANGED ATT BOARD--\rNo Ranged Attacks Yet"
					newChatMessage(text)
				else
					if #info.name >= 1 then
						local text = "/p \r--"..uppercase(places.first.name).."\'S RANGED ATT BOARD--"
						for i = 1, 3, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalize(info.name[i])..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 4 then
						local text = "/p "
						for i = 4, 8, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..abbreviateNumber(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 9 then
						local text = "/p "
						for i = 9, 13, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..abbreviateNumber(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 14 then
						local text = "/p "
						for i = 14, 18, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..abbreviateNumber(info.score[i])
							end
						end
						newChatMessage(text)
					end
				end
			else
				local chatmode = 'p'
				if arg == 'l2' or arg == 'ls2' then
					chatmode = 'l2'
				elseif arg == 'l' or arg == 'l1' or arg == 'ls' or arg == 'ls1' then
					chatmode = 'l'
				end
				local text = ""
				if places.first == nil then
					text = "/"..chatmode.." \r--RANGED ATT BOARD--\rNo Ranged Attacks Yet"
				else
					text = "/"..chatmode.." \r--"..uppercase(places.first.name).."\'S RANGED ATT BOARD--"
					for i = 1, 5, 1 do
						if info.name[i] ~= nil then
							text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..abbreviateNumber(info.score[i])
						end
					end
				end
				newChatMessage(text)
			end
		end


	--SKILLCHAIN BOARD
	elseif addcmd == 'sc' or addcmd == 'skillchain' then
		if arg == 'reset' then
			resetSC()
			updateBox(box_display)
			add_to_chat(8,('[Leaderboard] '):color(220)..('SKILLCHAIN data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'sc'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'calls' or arg == 'callout' or arg == 'callouts' then
			settings.party_calls.sc = not settings.party_calls.sc
			add_to_chat(8,('[Leaderboard] '):color(220)..('SKILLCHAIN call:'):color(8)..(' %s':format(settings.party_calls.sc and 'ON' or 'OFF')):color(200))
			settings:save('all')
		else
			local places = live.places.sc
			local info = getPlacesInfo(places)
			if arg == 'all' then
				if places.first == nil then
					local text = "/p \r--SKILLCHAIN BOARD--\rNo Skillchains Yet"
					newChatMessage(text)
				else
					if #info.name >= 1 then
						local text = "/p \r--"..uppercase(places.first.name).."\'S SKILLCHAIN BOARD--"
						for i = 1, 3, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalize(info.name[i])..": "..addCommas(info.score[i])..("%s"):format(info.nines[i] > 0 and ":"..info.nines[i] or "")
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 4 then
						local text = "/p "
						for i = 4, 8, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])..("%s"):format(info.nines[i] > 0 and ":"..info.nines[i] or "")
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 9 then
						local text = "/p "
						for i = 9, 13, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])..("%s"):format(info.nines[i] > 0 and ":"..info.nines[i] or "")
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 14 then
						local text = "/p "
						for i = 14, 18, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])..("%s"):format(info.nines[i] > 0 and ":"..info.nines[i] or "")
							end
						end
						newChatMessage(text)
					end
				end
			else
				local chatmode = 'p'
				if arg == 'l2' or arg == 'ls2' then
					chatmode = 'l2'
				elseif arg == 'l' or arg == 'l1' or arg == 'ls' or arg == 'ls1' then
					chatmode = 'l'
				end
				local text = ""
				if places.first == nil then
					text = "/"..chatmode.." \r--SKILLCHAIN BOARD--\rNo Skillchains Yet"
				else
					text = "/"..chatmode.." \r--"..uppercase(places.first.name).."\'S SKILLCHAIN BOARD--"
					for i = 1, 5, 1 do
						if info.name[i] ~= nil then
							text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])..("%s"):format(info.nines[i] > 0 and ":"..info.nines[i] or "")
						end
					end
				end
				newChatMessage(text)
			end
		end


	--TOTAL DMG BOARD
	elseif addcmd == 'td' or addcmd == 'totaldamage' or addcmd == 'totaldmg' or addcmd == 'totdmg' then
		if arg == 'reset' then
			reseTD()
			updateBox(box_display)
			add_to_chat(8,('[Leaderboard] '):color(220)..('TOTAL DMG data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'td'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'calls' or arg == 'callout' or arg == 'callouts' then
			settings.party_calls.td = not settings.party_calls.td
			add_to_chat(8,('[Leaderboard] '):color(220)..('TOTAL DMG call:'):color(8)..(' %s':format(settings.party_calls.td and 'ON' or 'OFF')):color(200))
			settings:save('all')
		else
			local places = live.places.td
			local info = getPlacesInfo(places)
			local tdp = getTDP(info)
		
			if arg == 'all' then
				if places.first == nil then
					local text = "/p \r--TOTAL DMG BOARD--\rNo Damage Yet"
					newChatMessage(text)
				else
					if #info.name >= 1 then
						local text = "/p \r--"..uppercase(places.first.name).."\'S TOTAL DMG BOARD--"
						for i = 1, 3, 1 do
							if info.name[i] ~= nil then
								local pct = math.floor(tdp[i] + 0.5)
								text = text.."\r"..i.."|"..capitalize(info.name[i])..": "..addCommas(info.score[i]).." "..pct.."%"
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 4 then
						local text = "/p "
						for i = 4, 8, 1 do
							if info.name[i] ~= nil then
								local pct = math.floor(tdp[i] + 0.5)
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..abbreviateNumber(info.score[i]).." "..pct.."%"
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 9 then
						local text = "/p "
						for i = 9, 13, 1 do
							if info.name[i] ~= nil then
								local pct = math.floor(tdp[i] + 0.5)
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..abbreviateNumber(info.score[i]).." "..pct.."%"
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 14 then
						local text = "/p "
						for i = 14, 18, 1 do
							if info.name[i] ~= nil then
								local pct = math.floor(tdp[i] + 0.5)
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..abbreviateNumber(info.score[i]).." "..pct.."%"
							end
						end
						newChatMessage(text)
					end
				end
			else
				local chatmode = 'p'
				if arg == 'l2' or arg == 'ls2' then
					chatmode = 'l2'
				elseif arg == 'l' or arg == 'l1' or arg == 'ls' or arg == 'ls1' then
					chatmode = 'l'
				end
				local text = ""
				if places.first == nil then
					text = "/"..chatmode.." \r--TOTAL DMG BOARD--\rNo Damage Yet"
				else
					text = "/"..chatmode.." \r--"..uppercase(places.first.name).."\'S TOTAL DMG BOARD--"
					for i = 1, 5, 1 do
						if info.name[i] ~= nil then
							local pct = math.floor(tdp[i] + 0.5)
							text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..abbreviateNumber(info.score[i]).." "..pct.."%"
						end
					end
				end
				newChatMessage(text)
			end
		end


	--VICTIM BOARD
	elseif addcmd == 'v' or addcmd == 'victim' or addcmd == 'victims' then
		if arg == 'reset' then
			resetV()
			updateBox(box_display)
			add_to_chat(8,('[Leaderboard] '):color(220)..('VICTIM data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'victim'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'calls' or arg == 'callout' or arg == 'callouts' then
			settings.party_calls.murder = not settings.party_calls.murder
			add_to_chat(8,('[Leaderboard] '):color(220)..('MURDER/VICTIM call:'):color(8)..(' %s':format(settings.party_calls.murder and 'ON' or 'OFF')):color(200))
			settings:save('all')
		else
			local places = live.places.victim
			local info = getPlacesInfo(places)
			if arg == 'all' then
				if places.first == nil then
					local text = "/p \r--VICTIM BOARD--\rNo Victims Yet"
					newChatMessage(text)
				else
					if #info.name >= 1 then
						local text = "/p \r--"..uppercase(places.first.name).."\'S VICTIM BOARD--"
						for i = 1, 3, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalize(info.name[i])..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 4 then
						local text = "/p "
						for i = 4, 8, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 9 then
						local text = "/p "
						for i = 9, 13, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 14 then
						local text = "/p "
						for i = 14, 18, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
				end
			else
				local chatmode = 'p'
				if arg == 'l2' or arg == 'ls2' then
					chatmode = 'l2'
				elseif arg == 'l' or arg == 'l1' or arg == 'ls' or arg == 'ls1' then
					chatmode = 'l'
				end
				local text = ""
				if places.first == nil then
					text = "/"..chatmode.." \r--VICTIM BOARD--\rNo Victims Yet"
				else
					text = "/"..chatmode.." \r--"..uppercase(places.first.name).."\'S VICTIM BOARD--"
					for i = 1, 5, 1 do
						if info.name[i] ~= nil then
							text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
						end
					end
				end
				newChatMessage(text)
			end
		end


	--TOTAL WS BOARD
	elseif addcmd == 'ws' or addcmd == 'weaponskill' or addcmd == 'weaponskills' then
		if arg == 'reset' then
			resetWS()
			updateBox(box_display)
			add_to_chat(8,('[Leaderboard] '):color(220)..('TOTAL WS data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'ws'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'calls' or arg == 'callout' or arg == 'callouts' then
			settings.party_calls.ws = not settings.party_calls.ws
			add_to_chat(8,('[Leaderboard] '):color(220)..('TOTAL WS call:'):color(8)..(' %s':format(settings.party_calls.ws and 'ON' or 'OFF')):color(200))
			settings:save('all')
		else
			local places = live.places.ws
			local info = getPlacesInfo(places)
			if arg == 'all' then
				if places.first == nil then
					local text = "/p \r--TOTAL WS BOARD--\rNo Weapon Skills Yet"
					newChatMessage(text)
				else
					if #info.name >= 1 then
						local text = "/p \r--"..uppercase(places.first.name).."\'S TOTAL WS BOARD--"
						for i = 1, 3, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalize(info.name[i])..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 4 then
						local text = "/p "
						for i = 4, 8, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..abbreviateNumber(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 9 then
						local text = "/p "
						for i = 9, 13, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..abbreviateNumber(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 14 then
						local text = "/p "
						for i = 14, 18, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..abbreviateNumber(info.score[i])
							end
						end
						newChatMessage(text)
					end
				end
			else
				local chatmode = 'p'
				if arg == 'l2' or arg == 'ls2' then
					chatmode = 'l2'
				elseif arg == 'l' or arg == 'l1' or arg == 'ls' or arg == 'ls1' then
					chatmode = 'l'
				end
				local text = ""
				if places.first == nil then
					text = "/"..chatmode.." \r--TOTAL WS BOARD--\rNo Weapon Skills Yet"
				else
					text = "/"..chatmode.." \r--"..uppercase(places.first.name).."\'S TOTAL WS BOARD--"
					for i = 1, 5, 1 do
						if info.name[i] ~= nil then
							text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..abbreviateNumber(info.score[i])
						end
					end
				end
				newChatMessage(text)
			end
		end


	--WHIFF BOARD
	elseif addcmd == 'w' or addcmd == 'whiff' or addcmd == 'whiffs' then
		if arg == 'reset' then
			resetW()
			updateBox(box_display)
			add_to_chat(8,('[Leaderboard] '):color(220)..('WHIFF data reset.'):color(8))
		elseif arg == 'show' then
			box_display = 'whiff'
			updateBox(box_display)
			settings.visible = true
			showBox()
		elseif arg == 'call' or arg == 'calls' or arg == 'callout' or arg == 'callouts' then
			settings.party_calls.whiff = not settings.party_calls.whiff
			add_to_chat(8,('[Leaderboard] '):color(220)..('WHIFF call:'):color(8)..(' %s':format(settings.party_calls.whiff and 'ON' or 'OFF')):color(200))
			settings:save('all')
		else
			local places = live.places.whiff
			local info = getPlacesInfo(places)
			if arg == 'all' then
				if places.first == nil then
					local text = "/p \r--WHIFF BOARD--\rNo Whiffs Yet"
					newChatMessage(text)
				else
					if #info.name >= 1 then
						local text = "/p \r--"..uppercase(places.first.name).."\'S WHIFF BOARD--"
						for i = 1, 3, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalize(info.name[i])..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 4 then
						local text = "/p "
						for i = 4, 8, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 9 then
						local text = "/p "
						for i = 9, 13, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
					if #info.name >= 14 then
						local text = "/p "
						for i = 14, 18, 1 do
							if info.name[i] ~= nil then
								text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
							end
						end
						newChatMessage(text)
					end
				end
			else
				local chatmode = 'p'
				if arg == 'l2' or arg == 'ls2' then
					chatmode = 'l2'
				elseif arg == 'l' or arg == 'l1' or arg == 'ls' or arg == 'ls1' then
					chatmode = 'l'
				end
				local text = ""
				if places.first == nil then
					text = "/"..chatmode.." \r--WHIFF BOARD--\rNo Whiffs Yet"
				else
					text = "/"..chatmode.." \r--"..uppercase(places.first.name).."\'S WHIFF BOARD--"
					for i = 1, 5, 1 do
						if info.name[i] ~= nil then
							text = text.."\r"..i.."|"..capitalizeAndTruncate(info.name[i],8)..": "..addCommas(info.score[i])
						end
					end
				end
				newChatMessage(text)
			end
		end


	--Add name to optout list
	elseif addcmd == 'optout' or addcmd == 'o' then
		if arg == 'add' or arg == 'a' then
			if arg2 == nil then
				add_to_chat(8,('[Leaderboard] '):color(220)..('Please add a name to be added to the Optout list.'):color(8))
			else
				local l_name = string.lower(arg2)
				if settings.optout[l_name] then
					add_to_chat(8,('[Leaderboard] '):color(220)..(capitalize(arg2)):color(1)..(' is already in the Optout list.'):color(8)..'')
				else
					addToOptout(l_name)
					add_to_chat(8,('[Leaderboard] '):color(220)..(capitalize(arg2)):color(1)..(' has been added to the Optout list. Any related data has been deleted.'):color(8)..'')
				end
			end
		elseif arg == 'remove' or arg == 'r' or arg == 'delete' or arg == 'd' then
			if arg2 == nil then
				add_to_chat(8,('[Leaderboard] '):color(220)..('Please add a name to be removed from the Optout list.'):color(8))
			else
				local l_name = string.lower(arg2)
				if settings.optout[l_name] then
					removeFromOptout(l_name)
					add_to_chat(8,('[Leaderboard] '):color(220)..(capitalize(arg2)):color(1)..(' has been removed from the Optout list.'):color(8)..'')
				else
					add_to_chat(8,('[Leaderboard] '):color(220)..(capitalize(arg2)):color(1)..(' is not in the Optout list.'):color(8)..'')
				end
			end
		else
			local list = optoutList()
			add_to_chat(8,('[Leaderboard] '):color(220)..('Optout list: '):color(8)..('['..capitalize(list)..']'):color(1))
			add_to_chat(8,('[Leaderboard] '):color(220)..('Type '):color(8)..('//lb optout add/remove playername'):color(1)..(' to add or remove a player to the Optout list.'):color(8))
		end


	--Send a specific player their score report via tell
	elseif addcmd == 'report' or addcmd == 'r' then
		if arg == nil then
			add_to_chat(8,('[Leaderboard] '):color(220)..('Please add a name.'):color(8))
		else
			reportPlayerScores(string.lower(arg))
		end


	--Show the On-Screen Display
	elseif addcmd == 'show' then
		settings.visible = true
		showBox()
		settings:save('all')
		if arg == 'b' or arg == 'buff' or arg == 'buffs' then
			box_display = 'buff'
		elseif arg == 'c' or arg == 'cure' or arg == 'cures' then
			box_display = 'cure'
		elseif arg == 'db' or arg == 'debuff' or arg == 'debuffs' then
			box_display = 'debuff'
		elseif arg == 'd' or arg == 'death' or arg == 'deaths' then
			box_display = 'death'
		elseif arg == 'hs' or arg == 'highscore' or arg == 'hiscore' then
			box_display = 'hs'
		elseif arg == 'k' or arg == 'kill' or arg == 'kills' then
			box_display = 'kill'
		elseif arg == 'p' or arg == 'point' or arg == 'points' then
			box_display = 'point'
		elseif arg == 'ls' or arg == 'lowscore' or arg == 'loscore' then
			box_display = 'ls'
		elseif arg == 'mb' or arg == 'magicburst' or arg == 'burst' then
			box_display = 'mb'
		elseif arg == 'ml' or arg == 'melee' or arg == 'mele' then
			box_display = 'melee'
		elseif arg == 'm' or arg == 'murder' or arg == 'murders' then
			box_display = 'murder'
		elseif arg == 'n' or arg == 'nuke' or arg == 'nukes' then
			box_display = 'nuke'
		elseif arg == 'ra' or arg == 'range' or arg == 'ranged' or arg == 'rangedatt' or arg == 'rangedattack' then
			box_display = 'ra'
		elseif arg == 'sc' or arg == 'skillchain' or arg == 'skillchains' then
			box_display = 'sc'
		elseif arg == 'td' or arg == 'totaldamage' or arg == 'totaldmg' or arg == 'totdmg' then
			box_display = 'td'
		elseif arg == 'v' or arg == 'victim' or arg == 'victims' then
			box_display = 'victim'
		elseif arg == 'ws' or arg == 'weaponskill' or arg == 'weaponskills' then
			box_display = 'ws'
		elseif arg == 'w' or arg == 'whiff' or arg == 'whiffs' then
			box_display = 'whiff'
		elseif tonumber(arg) ~= nil then
			settings.osd_show_number = tonumber(arg)
			settings:save('all')
			add_to_chat(8,('[Leaderboard] '):color(220)..('On-Screen Display Show to Place:'):color(36)..(' '..settings.osd_show_number):color(200))
		end
		updateBox(box_display)


	--Hide the On-Screen Display
	elseif addcmd == 'hide' then
		settings.visible = false
		settings:save('all')
		hideBox()


	--Lock the On-Screen Display by turning drag off
	elseif addcmd == 'lock' then
		settings.flags.draggable = false
		settings:save('all')
		add_to_chat(8,('[Leaderboard] '):color(220)..('On-Screen Display is locked. Dragging is disabled.'):color(8))


	--Unlock the On-Screen Display by turning drag on
	elseif addcmd == 'unlock' then
		settings.flags.draggable = true
		settings:save('all')
		add_to_chat(8,('[Leaderboard] '):color(220)..('On-Screen Display is unlocked. Dragging is enabled.'):color(8))


	--Set a specific player as your Rival
	elseif addcmd == 'rival' then
		if arg == nil then
			add_to_chat(8,('[Leaderboard] '):color(220)..('%s'):format(settings.rival ~= '' and (capitalize(settings.rival)):color(1)..(' is your Rival. Type '):color(8)..('//lb rival '..settings.rival):color(1)..(' to remove them.'):color(8) or ('No Rival set.'):color(8)))
		elseif string.lower(arg) == settings.rival then
			settings.rival = ""
			add_to_chat(8,('[Leaderboard] '):color(220)..(capitalize(arg)):color(1)..(' has been removed as your Rival. No Rival set.'):color(8))
		else
			settings.rival = string.lower(arg)
			add_to_chat(8,('[Leaderboard] '):color(220)..(capitalize(arg)):color(1)..(' is now your Rival!'):color(8))
		end
		settings:save('all')
		updateBox(box_display)


	--Taunt your Rival with a tell
	elseif addcmd == 'taunt' then
		--Update the taunt text
		if next(args) ~= nil then
			local tauntText = table.concat(args, ' ')
			--Make sure %s is included in the taunt
			if not string.match(tauntText, "%%s") then
				add_to_chat(8,('[Leaderboard] '):color(220)..('Please include a \'%s\' where the board names will go. Your current taunt text is:'):color(8))
				add_to_chat(8,('[Leaderboard] '):color(220)..(settings.taunt):color(1))
			else
				settings.taunt = tauntText
				settings:save('all')
				add_to_chat(8,('[Leaderboard] '):color(220)..('Your taunt text has been updated to:'):color(8))
				add_to_chat(8,('[Leaderboard] '):color(220)..(settings.taunt):color(1))
			end
			return
		end
		--Check if the settings file was manually updated without a "%s" in it.
		if not string.match(settings.taunt, "%%s") then
			add_to_chat(8,('[Leaderboard] '):color(220)..('Please update your taunt text to include a \'%s\' where the board names will go.'):color(8))
			add_to_chat(8,('[Leaderboard] '):color(220)..('Ex. '):color(8)..('//lb taunt I\'m beating you in %s. Just thought you should know.'):color(1))
			return
		end
		--No Rival is set
		if settings.rival == '' then
			add_to_chat(8,('[Leaderboard] '):color(220)..('No Rival set.'):color(8))
			return
		end
		local myName = get_mob_by_target('me').name
		local yourHSScore = (live.individuals.hs and live.individuals.hs[string.lower(myName)] and live.individuals.hs[string.lower(myName)].score) or 0
		local yourHSNines = (live.individuals.hs and live.individuals.hs[string.lower(myName)] and live.individuals.hs[string.lower(myName)].nines) or 0
		local yourTDScore = (live.individuals.td and live.individuals.td[string.lower(myName)] and live.individuals.td[string.lower(myName)].score) or 0
		local yourSCScore = (live.individuals.sc and live.individuals.sc[string.lower(myName)] and live.individuals.sc[string.lower(myName)].score) or 0
		local yourSCNines = (live.individuals.sc and live.individuals.sc[string.lower(myName)] and live.individuals.sc[string.lower(myName)].nines) or 0
		local yourWSScore = (live.individuals.ws and live.individuals.ws[string.lower(myName)] and live.individuals.ws[string.lower(myName)].score) or 0
		local rivalHSScore = (live.individuals.hs and live.individuals.hs[settings.rival] and live.individuals.hs[settings.rival].score) or 0
		local rivalHSNines = (live.individuals.hs and live.individuals.hs[settings.rival] and live.individuals.hs[settings.rival].nines) or 0
		local rivalTDScore = (live.individuals.td and live.individuals.td[settings.rival] and live.individuals.td[settings.rival].score) or 0
		local rivalSCScore = (live.individuals.sc and live.individuals.sc[settings.rival] and live.individuals.sc[settings.rival].score) or 0
		local rivalSCNines = (live.individuals.sc and live.individuals.sc[settings.rival] and live.individuals.sc[settings.rival].nines) or 0
		local rivalWSScore = (live.individuals.ws and live.individuals.ws[settings.rival] and live.individuals.ws[settings.rival].score) or 0
		local text = settings.taunt
		local imBeatingText = ''
		local imBeating = {}
		--Compare scores, add ones that you are beating your rival in into the imBeating table
		if (yourHSNines > rivalHSNines) or (yourHSScore > rivalHSScore) then
			table.insert(imBeating, "High WS")
		end
		if yourTDScore > rivalTDScore then
			table.insert(imBeating, "Total WS")
		end
		if (yourSCNines > rivalSCNines) or (yourSCScore > rivalSCScore) then
			table.insert(imBeating, "Skillchain")
		end
		if (yourWSScore > rivalWSScore) then
			table.insert(imBeating, "Total WS")
		end
		--Put together which scores you're beating your Rival in, then add it to the text to send them
		if #imBeating == 0 then
			add_to_chat(8,('[Leaderboard] '):color(220)..('You are not currently beating your Rival in anything.'):color(8))
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
		newChatMessage("/t "..settings.rival.." "..(text):format(imBeatingText))


	--Unknown command
	else
		add_to_chat(8,('[Leaderboard] '):color(220)..('Unrecognized command. Type'):color(8)..(' //lb help'):color(1)..(' for a list of commands.'):color(8))

	end
end)


register_event('prerender', function()

	--Hide the box when zoning and logging out
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

	--Creates a 1 second Heartbeat
	if os.time() > Heartbeat then
		Heartbeat = os.time()

		--Mog Kart Mode Party Board
		if settings.kart_p_board_time > 0 and settings.mode == "Mog Kart" and not live.paused then
			if kart_p_board_time <= settings.kart_p_board_time then
				kart_p_board_time = kart_p_board_time + 1
			else
				cmd('lb p') --call the point board
				kart_p_board_time = 1 --start the timer back up
			end
		end

	end
end)


--On zone change, remind that LB is running
register_event('zone change',function()
	if settings.reminder and settings.mode ~= 'Silent' then
		coroutine.sleep(5)
		add_to_chat(8,('[Leaderboard] '):color(220)..(('Currently %s'):format(live.paused and 'paused' or 'running')..' in '..settings.mode..' Mode'):color(8))
	end
end)
