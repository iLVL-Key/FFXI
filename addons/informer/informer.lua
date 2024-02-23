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
_addon.version = '3.1'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'informer'}

require 'logger'
config = require('config')
packets = require('packets')
texts = require('texts')
res = require('resources')

defaults = {}

defaults.first_load = true

defaults.layout = {}
defaults.layout.aa_help = 'Informer is able to display multiple different things via the use of placeholders, you may change the layout for each individual job however you would like below.'
defaults.layout.ab_help = 'List of placeholders: ${day} ${direction} ${food} ${gil} ${inventory} ${job} ${mlvl} ${pos} ${reraise} ${target} ${target_w_hpp} ${time} ${tp} ${weather} ${zone}'
defaults.layout.ac_help = '(NOTE: mlvl is updated when the packet for it is called, so will not be correct immediately upon loading)'
defaults.layout.ad_help = 'Informer is able to track any item in the game with ${track:Item Name}. The item name must be spelled exactly as it appears in the items list (not the longer descriptive name) and is case sensitive. The first number is how many of that item is in your inventory, the second number is the total between inventory, satchel, case, and sack.'
defaults.layout.default = '${job}(${mlvl}) | ${zone} ${pos} ${direction} | ${day} (${time}) ${weather} | Inv: ${inventory} | ${food}'
defaults.layout.brd = defaults.layout.default
defaults.layout.blm = defaults.layout.default
defaults.layout.blu = defaults.layout.default
defaults.layout.bst = defaults.layout.default..' | PF Theta: ${track:Pet Food Theta}'
defaults.layout.cor = defaults.layout.default..' | Cards: ${track:Trump Card} | Eminent: ${track:Eminent Bullet} | Orichalc.: ${track:Orichalc. Bullet}'
defaults.layout.dnc = defaults.layout.default
defaults.layout.drg = defaults.layout.default..' | Angons: ${track:Angon}'
defaults.layout.drk = defaults.layout.default
defaults.layout.geo = defaults.layout.default
defaults.layout.mnk = defaults.layout.default
defaults.layout.nin = defaults.layout.default..' | Shihei: ${track:Shihei}'
defaults.layout.pld = defaults.layout.default..' | Remedies: ${track:Remedy} | H.Waters: ${track:Holy Water}'
defaults.layout.pup = defaults.layout.default..' | Oils: ${track:Automat. Oil +3}'
defaults.layout.rdm = defaults.layout.default
defaults.layout.rng = defaults.layout.default..' | Eminent: ${track:Eminent Bullet} | Orichalc.: ${track:Orichalc. Bullet}'
defaults.layout.run = defaults.layout.default
defaults.layout.sam = defaults.layout.default
defaults.layout.sch = defaults.layout.default
defaults.layout.smn = defaults.layout.default
defaults.layout.thf = defaults.layout.default
defaults.layout.war = defaults.layout.default
defaults.layout.whm = defaults.layout.default

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
defaults.colors.self = '66, 135, 245'
defaults.colors.party = '158, 226, 255'
defaults.colors.alliance = '158, 226, 255'
defaults.colors.npc = '140, 227, 132'
defaults.colors.monster_passive = '247, 237, 141'
defaults.colors.monster_claimed_other = '188, 112, 255'
defaults.colors.monster_claimed_party = '255, 77, 77'
defaults.colors.monster_claimed_alliance = '255, 77, 100'
defaults.colors.day = '255, 255, 0'
defaults.colors.dusk_dawn = '170, 170, 0'
defaults.colors.night = '171, 171, 171'

defaults.display = {}
defaults.display.colors = true
defaults.display.min_width = {}
defaults.display.min_width.aa_help = 'Minimum widths control how wide these sections are, creating a more static overall width for the bar, and preventing other sections after them from moving around. Set to 0 to turn off'
defaults.display.min_width.target = 21
defaults.display.min_width.target_hpp = 5
defaults.display.min_width.food = 16
defaults.display.min_width.zone = 0
defaults.display.min_width.weather = 0
defaults.display.min_width.gil = 0
defaults.display.min_width.day = 0
defaults.display.min_width.tp = 4

defaults.food = {}

settings = config.load(defaults)

local informer_main = texts.new('${current_string}', settings)

local last_item_used = nil
local master_level = nil
local reraise = false

function firstLoadMessage()
	windower.add_to_chat(220,'[informer] '..('First load detected.'):color(8))
	coroutine.sleep(1)
	windower.add_to_chat(8,'   Welcome to '..('Informer '):color(220)..('Ver. '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220))
	coroutine.sleep(1)
	windower.add_to_chat(8,'   Layouts are saved per job. Change the layouts at:')
	windower.add_to_chat(1,'   addons/Informer/data/settings.xml')
	coroutine.sleep(1)
	windower.add_to_chat(8,'   Type'..(' //informer help'):color(1)..(' for a list of command options.'):color(8))
	settings.first_load = false
	settings:save('all')
end

function showInformerMain()
	informer_main:show()
end

function hideInformerMain()
	informer_main:hide()
end

windower.register_event('incoming chunk', function(id, original, modified, injected, blocked)
	if injected or blocked then return end
	if id == 0x061 then
		local packet = packets.parse('incoming', original)
		master_level = packet['Master Level']
	end
end)

function updateInformerMain()

	local use_colors = settings.display.colors
	local target_width = settings.display.min_width.target
	local target_hpp_width = settings.display.min_width.target_hpp
	local food_width = settings.display.min_width.food
	local zone_width = settings.display.min_width.zone
	local weather_width = settings.display.min_width.weather
	local gil_width = settings.display.min_width.gil
	local day_width = settings.display.min_width.day
	local tp_width = settings.display.min_width.tp

	local player = windower.ffxi.get_player()
	local player_job = player.main_job..player.main_job_level..'/'..(player.sub_job and player.sub_job..player.sub_job_level or '-----')
	local mlvl = master_level or '--'

	local gil = windower.ffxi.get_items().gil
		gil = addCommas(gil)
		gil = string.format("%-"..gil_width.."s", gil)

	local bag = windower.ffxi.get_bag_info(0)
	local game = windower.ffxi.get_info()
	local pos = windower.ffxi.get_position()
	local zone_name = res.zones[windower.ffxi.get_info().zone].name
		zone_name = string.format("%-"..zone_width.."s", zone_name)

	local party = windower.ffxi.get_party()
	local tp = (party and party.p0) and (party.p0.tp or 0) or 0
	local tp_color = settings.colors.none
		if use_colors and tp >= 1000 then
			tp_color = settings.colors.good
		end
		tp = string.format("%-"..tp_width.."s", tp)

	local target = windower.ffxi.get_mob_by_target('st') or windower.ffxi.get_mob_by_target('t')
	local target_name = target and target.name or 'No Target'
		target_name = string.format("%-"..target_width.."s", target_name)
	local target_hpp = target and target.hpp..'% ' or '---- '
		target_hpp = string.format("%"..target_hpp_width.."s", target_hpp)
	local target_w_hpp = target_hpp..target_name
	local target_color = settings.colors.none
		if use_colors and target and target.id == player.id then
			target_color = settings.colors.self
		elseif use_colors and target and isInParty(target.id) then
			target_color = settings.colors.party
		elseif use_colors and target and isInAlliance(target.id) then
			target_color = settings.colors.alliance
		elseif use_colors and target and target.is_npc then
			if target.spawn_type == 16 then
				if target.claim_id == 0 then
					target_color = settings.colors.monster_passive
				elseif isInParty(target.claim_id) then
					target_color = settings.colors.monster_claimed_party
				elseif isInAlliance(target.claim_id) then
					target_color = settings.colors.monster_claimed_alliance
				else
					target_color = settings.colors.monster_claimed_other
				end
			else
				target_color = settings.colors.npc
			end
		end

	local inventory = bag.count..'/'..bag.max
		inventory = string.format("%5s", inventory)
	local inventory_color = settings.colors.none
		if use_colors and bag.count == bag.max then
			inventory_color = settings.colors.bad
		elseif use_colors and bag.max - bag.count <= 10 then
			inventory_color = settings.colors.warning
		end

	local food = "No Food"
		if food_loading then
			food = "Loading..."
		elseif settings.food[string.lower(player.name)] then
			food = settings.food[string.lower(player.name)]
		elseif foodActive() then
			food = "Unknown Food"
		end
		food = string.format("%-"..food_width.."s", food)
	local food_color = settings.colors.none
		if use_colors then
			food_color = foodActive() and settings.colors.good or settings.colors.bad
		end

	local game_time_hour = math.floor(game.time/60)
	local game_time_minute = game.time - (math.floor(game.time/60)*60)
		game_time_minute = string.format("%02d", game_time_minute)
	local time_color = settings.colors.none
		if use_colors and game_time_hour >= 6 and game_time_hour < 7 then --dawn
			time_color = settings.colors.dusk_dawn
		elseif use_colors and game_time_hour >= 7 and game_time_hour < 17 then --daytime
			time_color = settings.colors.day			
		elseif use_colors and game_time_hour >= 17 and game_time_hour < 18 then --dusk
			time_color = settings.colors.dusk_dawn			
		elseif use_colors and (game_time_hour >= 18 and game_time_hour < 24) or (game_time_hour >= 0 and game_time_hour < 7) then --nighttime
			time_color = settings.colors.night
		end
		game_time_hour = string.format("%02d", game_time_hour)
	local game_time = game_time_hour..':'..game_time_minute

	local game_day = res.days[windower.ffxi.get_info().day].name
		game_day = string.format("%-"..day_width.."s", game_day)
	local day_color = settings.colors.none
		if use_colors then
			day_color = settings.colors[string.lower(res.elements[res.days[windower.ffxi.get_info().day].element].name)]
		end

	local weather = res.weather[windower.ffxi.get_info().weather].name
		weather = string.format("%-"..weather_width.."s", weather)
	local weather_color = settings.colors.none
		if use_colors then
			weather_color = settings.colors[string.lower(res.elements[res.weather[windower.ffxi.get_info().weather].element].name)]
		end

	local rr = 'No Reraise'
	local rr_color = settings.colors.none
		if reraise then
			rr = 'Reraise On'
			if use_colors then
				rr_color = settings.colors.good
			end
		end

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
		direction = "--"
	end

	-- Count the number of given item and return the number and the color
	local function countItem(item_id)
		local items = windower.ffxi.get_items()
		local inventory = items.inventory
		local containers = {items.inventory, items.case, items.sack, items.satchel}
		local invNum = 0
		local otherNum = 0
		local invColor = settings.colors.none
		local otherColor = settings.colors.none

		-- Find the item and get the count
		for i, item in ipairs(inventory) do
			if item.id == item_id then
				invNum = invNum + item.count
				--break
			end
		end

		-- Iterate through each container
		for _, container in ipairs(containers) do
			-- Find the item and add to the count if found
			for _, item in ipairs(container) do
				if item.id == item_id then
					otherNum = otherNum + item.count
				end
			end
		end

		-- Determine the color based on the count / stack
		if use_colors and invNum == 0 then
			invColor = settings.colors.bad
		elseif use_colors and (invNum / res.items[item_id].stack) <= .26 then
			invColor = settings.colors.warning
		end
		invNum = string.format("%2s", invNum)

		if use_colors and otherNum == 0 then
			otherColor = settings.colors.bad
		elseif use_colors and (otherNum / res.items[item_id].stack) <= .26 then
			otherColor = settings.colors.warning
		end
		otherNum = string.format("%-2s", otherNum)

		return invNum, invColor, otherNum, otherColor

	end

	-- Find the id of an item based on its name
	local function getIdFromName(item_name)
		for _, item in pairs(res.items) do
			if item.name == item_name then
				return item.id --match found
			end
		end
		return false --no match found
	end

	-- Replace ${track:Item Name}
	local function replaceTrackItems(input)
		local output = input:gsub("%${track:(.-)}", function(match)
			local itemName = match:match("(.-)$")
			if itemName then
				local itemId = getIdFromName(itemName)
				local item_inv_num, item_inv_color, item_other_num, item_other_color = countItem(itemId)
				if itemId then
					-- Match was found via getIdFromName, return the number (via countItem) and color it
					return '\\cs('..item_inv_color..')'..item_inv_num..'\\cr/\\cs('..item_other_color..')'..item_other_num..'\\cr'
				else
					return '\\cs('..settings.colors.bad..')NO MATCH\\cr' --no match
				end
			end
		end)
		return output
	end

	-- Replace placeholders
	local function replacePlaceholders(str, replacements)
		return str:gsub("%${(.-)}", replacements)
	end

	-- Rebuild the text string to be displayed in the bar
	local layout = settings.layout[string.lower(player.main_job)]
	local text = replaceTrackItems(layout)
	text = replacePlaceholders(text, {
		job = player_job,
		gil = gil,
		zone = zone_name,
		pos = pos,
		direction = direction,
		day = '\\cs('..day_color..')'..game_day..'\\cr',
		time = '\\cs('..time_color..')'..game_time..'\\cr',
		weather = '\\cs('..weather_color..')'..weather..'\\cr',
		inventory = '\\cs('..inventory_color..')'..inventory..'\\cr',
		food = '\\cs('..food_color..')'..food..'\\cr',
		target = '\\cs('..target_color..')'..target_name..'\\cr',
		target_w_hpp = '\\cs('..target_color..')'..target_w_hpp..'\\cr',
		tp = '\\cs('..tp_color..')'..tp..'\\cr',
		mlvl = mlvl,
		reraise = '\\cs('..rr_color..')'..rr..'\\cr',
	})

	-- Update the bar with the rebuilt text string
	informer_main.current_string = ' '..text..' ' --the spaces add a touch of padding at the begining and end

	-- Hide while zoning
	if pos == "(?-?)" then
		hideInformerMain()
	elseif pos ~= "(?-?)" then
		showInformerMain()
	end

end

-- Add commas to numbers to make them easier to read
function addCommas(number)
	-- Convert the number to a string
	local formattedNumber = tostring(number)

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

	-- Return the number (albeit as a string, we're not doing any math on it at this point)
    return formattedNumber
end

-- Check if we have food active
function foodActive()
	local buffs = windower.ffxi.get_player().buffs

	for _, buffId in ipairs(buffs) do
		if buffId == 251 then
			return true
		end
	end

	return false

end

-- Is this player in our party
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

-- Is this player in our alliance
function isInAlliance(id)
	local actor = windower.ffxi.get_mob_by_id(id)

	if actor == nil or not actor.in_alliance then
		-- Not in our alliance
		return false
	else
		-- In our alliance
		return true
	end

end

-- Record the last item used
windower.register_event('action',function(act)
	if not foodActive() and isInParty(act.actor_id) and act.category == 9 and act.targets[1].actions[1].message == 28 then
		last_item_used = res.items[act.targets[1].actions[1].param].en
	end
end)

-- Gain buffs
windower.register_event('gain buff', function(buff)
	local player = windower.ffxi.get_player()

	if buff == 251 then -- Food, so the last item used was food

		--First check if we already have food saved, if do that means we just logged back into a character with food on
		if settings.food[string.lower(player.name)] then
		--If not, check if last_item_used exists, if it does that means we just used food (or a party member used AOE food)
		elseif last_item_used then
			settings.food[string.lower(player.name)] = last_item_used
		--If neither of those exist then we probably just re/loaded the addon with food already on so use "Unknown Food" for now
		else
			settings.food[string.lower(player.name)] = "Unknown Food"
		end

		settings:save('all')
		last_item_used = nil --delete the last item used after we gain the food buff

	elseif buff == 113 then -- Reraise
		reraise = true

	end
end)

-- Lose buffs
windower.register_event('lose buff', function(buff)
	local player = windower.ffxi.get_player()

	if buff == 251 and not food_loading then -- Food
		settings.food[string.lower(player.name)] = nil
		settings:save('all')

	elseif buff == 113 then -- Reraise
		reraise = false

	end
end)

-- Main call to update the Informer bar
windower.register_event('prerender', function()

	if windower.ffxi.get_player() ~= nil then
		updateInformerMain()
	end

end)

-- Load
windower.register_event('load', function()
	if windower.ffxi.get_info().logged_in and settings.first_load then
		firstLoadMessage()
	end
end)

-- Login
windower.register_event('login', function()
	food_loading = true --prevents food clearing immediately on login
	showInformerMain()
	coroutine.sleep(5)
	if settings.first_load then
		firstLoadMessage()
	end
	food_loading = false
end)

-- Logout
windower.register_event('logout', function()
	hideInformerMain()
	last_item_used = nil --delete the last item used when we switch characters
end)

-- Unrecognized command
function displayUnregnizedCommand()
	windower.add_to_chat(220,'[Informer] '..('Unrecognized command. Type'):color(39)..(' //informer help'):color(1)..(' if you need help.'):color(39))
end

windower.register_event('addon command',function(addcmd, ...)

	-- Update the bar position
	if addcmd == 'pos' or addcmd == 'position' or addcmd == 'move' or addcmd == 'lock' or addcmd == 'unlock' then
		local pos = {...}

		-- Lock by turning drag off
		if addcmd == 'lock' or (addcmd ~= 'unlock' and pos[1] == 'lock') then
			settings.flags.draggable = false
			settings:save('all')
			windower.add_to_chat(220,'[Informer] '..('Position:'):color(36)..(' '..settings.pos.x..' '..settings.pos.y..' - Locked'):color(200))
		
		-- Unlock by turning drag on
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

			-- Position must be numbers
			if settings.pos.x == nil or settings.pos.y == nil then
				displayUnregnizedCommand()

			-- Save the new setting, update the position, then alert the user
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
		windower.add_to_chat(36,'   pos [x y]'..(' - Update position. ['):color(8)..(currPos.x..' '..currPos.y):color(200)..(']'):color(8))
		windower.add_to_chat(36,'   lock/unlock'..(' - Update position via drag. ['):color(8)..(settings.flags.draggable and ('Unlocked'):color(200)..(' (draggable)'):color(8) or ('Locked'):color(200))..(']'):color(8))
		windower.add_to_chat(36,'   size [#]'..(' - Update font size. ['):color(8)..(''..currSize):color(200)..(']'):color(8))
		windower.add_to_chat(36,'   bold'..(' - Update bold setting. ['):color(8)..('%s':format(currBold and 'ON' or 'OFF')):color(200)..(']'):color(8))
		windower.add_to_chat(36,'   color'..(' - Update color setting. ['):color(8)..('%s':format(currColor and 'ON' or 'OFF')):color(200)..(']'):color(8))
		windower.add_to_chat(220,' ')
		windower.add_to_chat(8,' You can change the layout per job in /data/settings.xml')

	elseif addcmd == 'reload' then
		windower.send_command('lua r informer')
		return

	else
		displayUnregnizedCommand()
	end
	
end)
