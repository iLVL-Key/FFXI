--Copyright (c) 2025, Key
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
_addon.version = '5.1.1'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'informer','info'}

require 'logger'
config = require('config')
packets = require('packets')
texts = require('texts')
res = require('resources')

defaults = {}

defaults.first_load = true
default_layout = '${job}(${mlvl}) | ${zone} ${pos} ${direction} | ${day} (${time}) ${weather} | Inv: ${inventory} | ${food}'

defaults.layout = {}
defaults.layout.aa_help = 'Informer is able to display multiple different things via the use of placeholders, you may change the layout for each individual job however you would like below.'
defaults.layout.ab_help = 'List of placeholders: ${day} ${direction} ${distance} ${earth_date} ${earth_day} ${earth_time} ${food} ${gil} ${inventory} ${job} ${mlvl} ${moon_percent} ${moon_phase} ${name} ${pos} ${region} ${reraise} ${speed} ${target} ${target_w_hpp} ${time} ${tp} ${track:Item Name} ${weather} ${zone}'
defaults.layout.ac_help = '(NOTE: mlvl is updated when the packet for it is called, so will not be correct immediately upon loading)'
defaults.layout.ad_help = 'Informer is able to track any item in the game with ${track:Item Name}. The item name must be spelled exactly as it appears in the items list (not the longer descriptive name) and is case sensitive. The first number is how many of that item is in your inventory, the second number is the total between inventory, satchel, case, and sack.'
defaults.layout.main = {}
defaults.layout.main.brd = default_layout
defaults.layout.main.blm = default_layout
defaults.layout.main.blu = default_layout
defaults.layout.main.bst = default_layout..' | PF Theta: ${track:Pet Food Theta}'
defaults.layout.main.cor = default_layout..' | Cards: ${track:Trump Card} | Eminent: ${track:Eminent Bullet} | Orichalc.: ${track:Orichalc. Bullet}'
defaults.layout.main.dnc = default_layout
defaults.layout.main.drg = default_layout..' | Angons: ${track:Angon}'
defaults.layout.main.drk = default_layout
defaults.layout.main.geo = default_layout
defaults.layout.main.mnk = default_layout
defaults.layout.main.nin = default_layout..' | Shihei: ${track:Shihei}'
defaults.layout.main.pld = default_layout..' | Remedies: ${track:Remedy} | H.Waters: ${track:Holy Water}'
defaults.layout.main.pup = default_layout..' | Oils: ${track:Automat. Oil +3}'
defaults.layout.main.rdm = default_layout
defaults.layout.main.rng = default_layout..' | Eminent: ${track:Eminent Bullet} | Orichalc.: ${track:Orichalc. Bullet}'
defaults.layout.main.run = default_layout
defaults.layout.main.sam = default_layout
defaults.layout.main.sch = default_layout
defaults.layout.main.smn = default_layout
defaults.layout.main.thf = default_layout
defaults.layout.main.war = default_layout
defaults.layout.main.whm = default_layout
defaults.layout.sub1 = '${pos} | ${zone} | ${region} | ${direction}'
defaults.layout.sub2 = '${day} | ${time} | ${weather}'

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

defaults.options = {}
defaults.options.colors = true
defaults.options.earth_date_format = '%m/%d/%Y'
defaults.options.earth_day_format = '%A'
defaults.options.earth_time_format = '%I:%M:%S %p'
defaults.options.min_width = {}
defaults.options.min_width.aa_help = 'Minimum widths control how wide these sections are, creating a more static overall width for the bar, and preventing other sections after them from moving around. Set to 0 to turn off'
defaults.options.min_width.target = 21
defaults.options.min_width.target_hpp = 5
defaults.options.min_width.food = 16
defaults.options.min_width.zone = 0
defaults.options.min_width.weather = 0
defaults.options.min_width.gil = 0
defaults.options.min_width.day = 0
defaults.options.min_width.tp = 4

defaults.options.sub1 = {}
defaults.options.sub1.alpha = 255
defaults.options.sub1.bg_alpha = 255
defaults.options.sub1.centered = false
defaults.options.sub1.hide_when_no_map = false
defaults.options.sub1.pos_x = math.floor(windower.get_windower_settings().ui_x_res / 2)
defaults.options.sub1.pos_y = 300
defaults.options.sub1.right_aligned = false
defaults.options.sub1.size = 11
defaults.options.sub1.visible = false

defaults.options.sub2 = {}
defaults.options.sub2.alpha = 255
defaults.options.sub2.bg_alpha = 255
defaults.options.sub2.centered = false
defaults.options.sub2.hide_when_no_map = false
defaults.options.sub2.pos_x = math.floor(windower.get_windower_settings().ui_x_res / 2)
defaults.options.sub2.pos_y = 400
defaults.options.sub2.right_aligned = false
defaults.options.sub2.size = 11
defaults.options.sub2.visible = false

defaults.food = {}

settings = config.load(defaults)

use_colors = settings.options.colors
options = settings.options
colors = settings.colors
food = settings.food
flags = settings.flags

get_info = windower.ffxi.get_info
add_to_chat = windower.add_to_chat
get_map_data = windower.ffxi.get_map_data
register_event = windower.register_event
get_player = windower.ffxi.get_player
get_items = windower.ffxi.get_items
get_bag_info = windower.ffxi.get_bag_info
get_mob_by_target = windower.ffxi.get_mob_by_target
get_position = windower.ffxi.get_position
get_mob_by_id = windower.ffxi.get_mob_by_id

informer_main = texts.new('${current_string}', settings)

informer_sub1 = texts.new('${current_string}')
informer_sub1:alpha(options.sub1.alpha)
informer_sub1:bg_alpha(options.sub1.bg_alpha)
informer_sub1:draggable(false)
informer_sub1:font(settings.text.font)
informer_sub1:right_justified(options.sub1.right_aligned)
informer_sub1:pos(options.sub1.pos_x, options.sub1.pos_y)
informer_sub1:size(options.sub1.size)
sub1_visible = false

informer_sub2 = texts.new('${current_string}')
informer_sub2:alpha(options.sub2.alpha)
informer_sub2:bg_alpha(options.sub2.bg_alpha)
informer_sub2:draggable(false)
informer_sub2:font(settings.text.font)
informer_sub2:right_justified(options.sub2.right_aligned)
informer_sub2:pos(options.sub2.pos_x, options.sub2.pos_y)
informer_sub2:size(options.sub2.size)
sub2_visible = false

last_item_used = nil
master_level = nil
loading_inv = false
login_loading = false
loading_check = false
zoning = true
layout_main = ''
layout_sub1 = ''
layout_sub2 = ''
zone_name = ''
region_name = ''
game_day = ''
game_time = ''
earth_time_raw = os.time()
earth_time = ''
earth_date = ''
earth_day = ''
weather = ''
inventory = ''
food = "No Food"
reraise = 'No Reraise'
name = ''
job = ''
tp = ''
gil = '0'
moon_phase = "Waiting for moon update..."
moon_percent = nil
last_moon_value = nil
moon_direction = nil

function firstLoadMessage()
	add_to_chat(220,'[Informer] '..('First load detected.'):color(8))
	coroutine.sleep(1)
	add_to_chat(8,'   Welcome to '..('Informer '):color(220)..('Ver. '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220))
	coroutine.sleep(1)
	add_to_chat(8,'   Layouts for the Main bar are saved per job. Change the layouts at:')
	add_to_chat(1,'   addons/Informer/data/settings.xml')
	coroutine.sleep(1)
	add_to_chat(8,'   Type'..(' //informer help'):color(1)..(' for a list of command options.'):color(8))
	settings.first_load = false
	settings:save('all')
end

function showInformerBars()
	informer_main:show()
	local sub_map_id, map_x, map_y = get_map_data()
	local in_mh = get_info().mog_house
	if options.sub1.visible and not (options.sub1.hide_when_no_map and ((map_x == 0 and map_y == 0) or in_mh)) then
		informer_sub1:show()
		sub1_visible = true
	end
	if options.sub2.visible and not (options.sub2.hide_when_no_map and ((map_x == 0 and map_y == 0) or in_mh)) then
		informer_sub2:show()
		sub2_visible = true
	end
end

function hideInformerBars()
	informer_main:hide()
	informer_sub1:hide()
	sub1_visible = false
	informer_sub2:hide()
	sub2_visible = false
end

-- Master Level info
register_event('incoming chunk', function(id, original, modified, injected, blocked)
	if injected or blocked then return end
	local packet = packets.parse('incoming', original)
	if id == 0x061 then
		master_level = packet['Master Level']
	elseif id == 0x01D then
		loading_inv = packet['Flag'] == 0 and true or false
	end
end)

-- Check if we have food active
function foodActive()
	local buffs = get_player().buffs

	for _, buffId in ipairs(buffs) do
		if buffId == 251 then
			return true
		end
	end

	return false

end

-- Replace ${track:Item Name}
function updateTrackItems(loading)

	-- Count the number of given item and return the number and the color
	local function countItem(item_id)

		if loading then
			return " ?",colors.none,"? ",colors.none
		end

		local items = get_items()
		local inventory = items.inventory
		local containers = {items.inventory, items.case, items.sack, items.satchel}
		local invNum = 0
		local otherNum = 0
		local invColor = colors.none
		local otherColor = colors.none

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
			invColor = colors.bad
		elseif use_colors and (invNum / res.items[item_id].stack) <= .26 then
			invColor = colors.warning
		end
		invNum = string.format("%2s", invNum)

		if use_colors and otherNum == 0 then
			otherColor = colors.bad
		elseif use_colors and (otherNum / res.items[item_id].stack) <= .26 then
			otherColor = colors.warning
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

	local player = get_player()

	local function processTrackedItems(input_layout)
		return input_layout:gsub("%${track:(.-)}", function(match)
			local itemName = match:match("(.-)$")
			if itemName then
				local itemId = getIdFromName(itemName)
				if itemId then
					local item_inv_num, item_inv_color, item_other_num, item_other_color = countItem(itemId)
					return '\\cs('..item_inv_color..')'..item_inv_num..'\\cr/\\cs('..item_other_color..')'..item_other_num..'\\cr'
				else
					return '\\cs('..colors.bad..')NO MATCH\\cr'
				end
			end
		end)
	end

	layout_main = processTrackedItems(settings.layout.main[string.lower(player.main_job)])
	layout_sub1 = processTrackedItems(settings.layout.sub1)
	layout_sub2 = processTrackedItems(settings.layout.sub2)

end

-- Update Zone
function updateZone()
	local zone_id = get_info().zone
	local zone = res.zones[zone_id].name
	local zone_width = options.min_width.zone
	zone_name = string.format("%-"..zone_width.."s", zone)

	local region_map = {
		[0] = {230,231,232,233},
		[1] = {234,235,236,237},
		[2] = {238,239,240,241,242},
		[3] = {243,244,245,246},
		[4] = {100,101,139,140,141,142,167,190},
		[5] = {102,103,108,193,196,248},
		[6] = {1,2,104,105,149,150,195},
		[7] = {106,107,143,144,172,173,191},
		[8] = {109,110,147,148,197},
		[9] = {115,116,145,146,169,170,192,194},
		[10] = {3,4,117,118,198,213,249},
		[11] = {7,8,119,120,151,152,200},
		[12] = {9,10,111,166,203,204,206},
		[13] = {5,6,112,161,162,165},
		[14] = {126,127,157,158,179,184},
		[15] = {121,122,153,154,202,251},
		[16] = {114,125,168,208,209,247},
		[17] = {113,128,174,201,212,128},
		[18] = {123,176,250,252},
		[19] = {124,159,160,163,205,207,211},
		[20] = {130,177,178,180,181},
		[21] = {39,40,41,42,134,135,185,186,187,188,294,295,296,297},
		[22] = {11,12,13},
		[23] = {26},
		[24] = {24,25,27,28,29,30,31,32},
		[25] = {14,16,17,18,19,20,21,22,23},
		[26] = {33,34,35,36},
		[27] = {37,38},
		[28] = {58,59},
		[29] = {48,50,52,71},
		[30] = {65,66,67,68,51},
		[31] = {61,62,63,64},
		[32] = {53,54,55,56,57,60,69,78,79},
		[33] = {72,73,74,75,76,77},
		[34] = {80,81,86},
		[35] = {82,84,175},
		[36] = {87,88,89,93},
		[37] = {83,90,91,171},
		[38] = {94,95,96,129},
		[39] = {97,98,164},
		[40] = {136},
		[41] = {137},
		[42] = {85},
		[43] = {92},
		[44] = {99},
		[45] = {155,138,156},
		[46] = {15,45,132,215,216,217,218,253,254,255},
		[47] = {182,222,279,298},
		[48] = {43,44,183,287},
		[49] = {256,257,258,283,284},
		[50] = {280},
		[51] = {259,260,261,262,263,265,266,267,268,269,270,271,272,273,281,264,282},
		[52] = {133,189,274,276,277,275},
		[53] = {288,289},
		[54] = {291,292,293},
	}

	region_name = false
	for region_key, zone_list in pairs(region_map) do
		for _, z in ipairs(zone_list) do
			if z == zone_id then
				region_name = res.regions[region_key].name
			end
		end
	end
	if not region_name then
		if zone_id == 46 or zone_id == 47 or zone_id == 58 or zone_id == 59 
		or zone_id == 220 or zone_id == 221 or zone_id == 227 or zone_id == 228 then
			region_name = "International Waters"
		elseif zone_id == 223 or zone_id == 224 or zone_id == 225 or zone_id == 226 then
			region_name = "International Airspace"
		end
	end
	if not region_name then
		region_name = "Unknown Region"
	end

end

-- Update Game Day
function updateGameDay()
	local day_width = options.min_width.day
	local day = string.format("%-"..day_width.."s", res.days[get_info().day].name)
	local game_day_color = colors.none
	if use_colors then
		game_day_color = colors[string.lower(res.elements[res.days[get_info().day].element].name)]
	end
	game_day = '\\cs('..game_day_color..')'..day..'\\cr'
end

-- Update Game Time
function updateGameTime()
	local game = get_info()
	local game_time_hour = math.floor(game.time/60)
	local game_time_minute = game.time - (math.floor(game.time/60)*60)
	game_time_minute = string.format("%02d", game_time_minute)
	local game_time_color = colors.none
	if use_colors and game_time_hour >= 6 and game_time_hour < 7 then --dawn
		game_time_color = colors.dusk_dawn
	elseif use_colors and game_time_hour >= 7 and game_time_hour < 17 then --daytime
		game_time_color = colors.day			
	elseif use_colors and game_time_hour >= 17 and game_time_hour < 18 then --dusk
		game_time_color = colors.dusk_dawn			
	elseif use_colors and ((game_time_hour >= 18 and game_time_hour < 24) or (game_time_hour >= 0 and game_time_hour < 7)) then --nighttime
		game_time_color = colors.night
	end
	game_time_hour = string.format("%02d", game_time_hour)
	local formatted_time = game_time_hour..':'..game_time_minute
	game_time = '\\cs('..game_time_color..')'..formatted_time..'\\cr'
end

-- Update Earth Time
function updateEarthData()
	earth_date = os.date(options.earth_date_format)
	earth_day = os.date(options.earth_day_format)
	earth_time = os.date(options.earth_time_format)
end

-- Update Weather
function updateWeather()
	local weather_width = options.min_width.weather
	local formatted_weather = string.format("%-"..weather_width.."s", res.weather[get_info().weather].name)
	local weather_color = colors.none
	if use_colors then
		weather_color = colors[string.lower(res.elements[res.weather[get_info().weather].element].name)]
	end
	weather = '\\cs('..weather_color..')'..formatted_weather..'\\cr'
end

-- Update Inventory
function updateInventory(loading)
	local inventory_color = colors.none
	local inv = ''

	if loading then
		inv = ' ?/?'
	else
		local bag = get_bag_info(0)
		inv = bag.count..'/'..bag.max
		if use_colors and bag.count == bag.max then
			inventory_color = colors.bad
		elseif use_colors and bag.max - bag.count <= 10 then
			inventory_color = colors.warning
		end
	end

	local formatted_inventory = string.format("%5s", inv)

	inventory = '\\cs('..inventory_color..')'..formatted_inventory..'\\cr'
end

-- Update Food
function updateFood()
	local player = get_player()
	local food_width = options.min_width.food
	local formatted_food = "No Food"
	if char_loading then
		formatted_food = "Loading..."
	elseif settings.food[string.lower(player.name)] then
		formatted_food = settings.food[string.lower(player.name)]
	elseif foodActive() then
		formatted_food = "Unknown Food"
	end
	formatted_food = string.format("%-"..food_width.."s", formatted_food)
	local food_color = colors.none
	if use_colors then
		food_color = foodActive() and colors.good or colors.bad
	end
	food = '\\cs('..food_color..')'..formatted_food..'\\cr'
end

-- Update Reraise
function updateReraise()

	-- Check if we have reraise active
	local function reraiseActive()
		local buffs = get_player().buffs

		for _, buffId in ipairs(buffs) do
			if buffId == 113 then
				return true
			end
		end
		return false
	end

	local reraise_color = colors.none
	local rr = "No Reraise"
	if reraiseActive() then
		rr = "Reraise On"
		if use_colors then
			reraise_color = colors.good
		end
	else
		if use_colors then
			reraise_color = colors.bad
		end
	end
	reraise = '\\cs('..reraise_color..')'..rr..'\\cr'

end

-- Update Player Name
function updatePlayerName()
	name = get_player().name
end

-- Update Player Job
function updatePlayerJob()
	local player = get_player()
	job = player.main_job..player.main_job_level..'/'..(player.sub_job and player.sub_job..player.sub_job_level or '-----')
end

-- Update TP
function updateTP(player_tp)
	local tp_width = options.min_width.tp
	local player = get_player()
	player_tp = player and player.vitals.tp or 0
	local tp_color = colors.none
	if use_colors and player_tp >= 1000 then
		tp_color = colors.good
	end
	player_tp = string.format("%-"..tp_width.."s", player_tp)
	tp = '\\cs('..tp_color..')'..player_tp..'\\cr'
end

-- Update Gil
function updateGil(player_tp)
	local gil_width = options.min_width.gil
	local player_gil = get_items().gil
	player_gil = addCommas(player_gil)
	gil = string.format("%-"..gil_width.."s", player_gil)
end

-- Get Direction
function getDirection()
	local player = get_mob_by_target('me')
	local facing = player and player.facing or 10
	local pi = math.pi
	local directions = {
		{min = -pi * 0.625, max = -pi * 0.375, dir = "N "},
		{min = -pi * 0.375, max = -pi * 0.125, dir = "NE"},
		{min = -pi * 0.125, max = pi * 0.125, dir = "E "},
		{min = pi * 0.125, max = pi * 0.375, dir = "SE"},
		{min = pi * 0.375, max = pi * 0.625, dir = "S "},
		{min = pi * 0.625, max = pi * 0.875, dir = "SW"},
		{min = pi * 0.875, max = pi, dir = "W "},
		{min = -pi, max = -pi * 0.875, dir = "W "},
		{min = -pi * 0.875, max = -pi * 0.625, dir = "NW"}
	}
	local direction = "--"
	for _, entry in ipairs(directions) do
		if facing >= entry.min and facing < entry.max then
			direction = entry.dir
			break
		end
	end
	return direction
end

-- Get Target
function getTarget(name_type)
	local player = get_player()
	local target_width = options.min_width.target
	local target = get_mob_by_target('st') or get_mob_by_target('t')
	local target_name = target and target.name or 'No Target'
	target_name = string.format("%-"..target_width.."s", target_name)
	local target_color = colors.none
	if use_colors and target and target.id == player.id then
		target_color = colors.self
	elseif use_colors and target and isInParty(target.id) then
		target_color = colors.party
	elseif use_colors and target and isInAlliance(target.id) then
		target_color = colors.alliance
	elseif use_colors and target and target.is_npc then
		if target.spawn_type == 16 then
			if target.claim_id == 0 then
				target_color = colors.monster_passive
			elseif isInParty(target.claim_id) then
				target_color = colors.monster_claimed_party
			elseif isInAlliance(target.claim_id) then
				target_color = colors.monster_claimed_alliance
			else
				target_color = colors.monster_claimed_other
			end
		else
			target_color = colors.npc
		end
	end
	if name_type == "w_hpp" then
		local target_hpp_width = options.min_width.target_hpp
		local target_hpp = target and target.hpp..'% ' or '---- '
		target_hpp = string.format("%"..target_hpp_width.."s", target_hpp)
		local target_w_hpp = target_hpp..target_name
		target_w_hpp = '\\cs('..target_color..')'..target_w_hpp..'\\cr'
		return target_w_hpp
	else
		target_name = '\\cs('..target_color..')'..target_name..'\\cr'
		return target_name
	end
end

function updateMoon()

	local moon_phases_by_range = {
		{min = 0, max = 5, dir = "up", phase = "New Moon"},
		{min = 6, max = 38, dir = "up", phase = "Waxing Crescent"},
		{min = 39, max = 55, dir = "up", phase = "First Quarter Moon"},
		{min = 56, max = 88, dir = "up", phase = "Waxing Gibbous"},
		{min = 89, max = 100, dir = "up", phase = "Full Moon"},
		{min = 95, max = 100, dir = "down", phase = "Full Moon"},
		{min = 94, max = 62, dir = "down", phase = "Waning Gibbous"},
		{min = 61, max = 43, dir = "down", phase = "Last Quarter Moon"},
		{min = 25, max = 12, dir = "down", phase = "Waning Crescent"},
		{min = 11, max = 0, dir = "down", phase = "New Moon"},
	}

	local info = get_info()
	local current = info.moon

	moon_percent = tostring(current)

	--Determine direction
	if last_moon_value then
		if current > last_moon_value then
			moon_direction = "up"
		elseif current < last_moon_value then
			moon_direction = "down"
		end
	end

	--Determine moon phase once we know the direction
	if moon_direction then
		for _, phase_info in ipairs(moon_phases_by_range) do
			if moon_direction == phase_info.dir then
				--Check if current % falls within this phase's range
				if current >= math.min(phase_info.min, phase_info.max) and current <= math.max(phase_info.min, phase_info.max) then
					moon_phase = phase_info.phase
					break
				end
			end
		end
	end

	--Update last value
	last_moon_value = current

end

function updateInformerMain()

	local mlvl = master_level or '--'
	local speed = get_mob_by_target('me') and math.floor(100 * (get_mob_by_target('me').movement_speed / 5 - 1) + .1)
	local formatted_speed = speed and (speed >= 0 and '+' or '')..speed..'%'
	local target = get_mob_by_target('st','t')
	local target_distance = target and (string.format("%5.2f", math.floor(target.distance:sqrt()*100)/100)) or ''

	local pos = get_position()

	-- Replace placeholders
	local function replacePlaceholders(str, replacements)
		return str:gsub("%${(.-)}", replacements)
	end

	-- Rebuild the text string to be displayed in the bar
	local placeholders = {
		name = name,
		job = job,
		gil = gil,
		zone = zone_name,
		region = region_name,
		pos = pos,
		direction = getDirection(),
		day = game_day,
		time = game_time,
		earth_date = earth_date,
		earth_day = earth_day,
		earth_time = earth_time,
		weather = weather,
		inventory = inventory,
		food = food,
		target = getTarget(),
		target_w_hpp = getTarget("w_hpp"),
		tp = tp,
		mlvl = mlvl,
		reraise = reraise,
		speed = formatted_speed,
		distance = target_distance,
		moon_percent = moon_percent,
		moon_phase = moon_phase,
	}
	local text = replacePlaceholders(layout_main, placeholders)
	local text_sub1 = replacePlaceholders(layout_sub1, placeholders)
	local text_sub2 = replacePlaceholders(layout_sub2, placeholders)

	-- Update the bars with the rebuilt text strings (the spaces add a touch of padding at the begining and end)
	informer_main.current_string = ' '..text..' '
	informer_sub1.current_string = ' '..text_sub1..' '
	informer_sub2.current_string = ' '..text_sub2..' '

	--Update the position for centering if enabled for the 2 Sub Bars
	if options.sub1.centered then
		local width = informer_sub1:extents()
		local x = math.floor(options.sub1.pos_x - (width / 2))
		informer_sub1:pos(x, options.sub1.pos_y)
	end
	if options.sub2.centered then
		local width = informer_sub2:extents()
		local x = math.floor(options.sub2.pos_x - (width / 2))
		informer_sub2:pos(x, options.sub2.pos_y)
	end

	local sub_map_id, map_x, map_y = get_map_data()
	local in_mh = get_info().mog_house
	
	if options.sub1.hide_when_no_map then
		if map_x == 0 and map_y == 0 and sub1_visible then
			sub1_visible = false
			informer_sub1:hide()
		elseif map_x ~= nil and map_y ~= nil and map_x ~= 0 and map_y ~= 0 and options.sub1.visible and not sub1_visible and not in_mh then
			sub1_visible = true
			informer_sub1:show()
		end
	end
	if options.sub2.hide_when_no_map then
		if map_x == 0 and map_y == 0 and sub2_visible then
			sub2_visible = false
			informer_sub2:hide()
		elseif map_x ~= nil and map_y ~= nil and map_x ~= 0 and map_y ~= 0 and options.sub2.visible and not sub2_visible and not in_mh then
			sub2_visible = true
			informer_sub2:show()
		end
	end

	-- Hide while zoning
	if pos == "(?-?)" and not zoning then
		zoning = true
		hideInformerBars()
	elseif pos ~= "(?-?)" and zoning then
		zoning = false
		showInformerBars()
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
			formattedNumber = formattedNumber:sub(1, insertIndex)..","..formattedNumber:sub(insertIndex + 1)
			insertIndex = insertIndex + 4
			length = length + 1
		end
	end

	-- Return the number (albeit as a string, we're not doing any math on it at this point)
    return formattedNumber
end

-- Is this player in our party
function isInParty(id)
	local actor = get_mob_by_id(id)

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
	local actor = get_mob_by_id(id)

	if actor == nil or not actor.in_alliance then
		-- Not in our alliance
		return false
	else
		-- In our alliance
		return true
	end

end

-- Record the last item used
register_event('action',function(act)
	if not foodActive() and isInParty(act.actor_id) and act.category == 9 and act.targets[1].actions[1].message == 28 then
		last_item_used = res.items[act.targets[1].actions[1].param].en
	end
end)

-- Gain buffs
register_event('gain buff', function(buff)
	local player = get_player()

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
		updateFood()

	elseif buff == 113 then -- Reraise
		updateReraise()

	elseif buff == 157 then -- SJ Restriction
		updatePlayerJob()

	end
end)

-- Lose buffs
register_event('lose buff', function(buff)
	local player = get_player()

	if buff == 251 and not char_loading then -- Food
		settings.food[string.lower(player.name)] = nil
		settings:save('all')
		updateFood()

	elseif buff == 113 then -- Reraise
		updateReraise()

	end
end)

register_event('prerender', function()

	-- Main call to update the Informer bar
	if get_info().logged_in then
		updateInformerMain()
		if not char_loading then
			if not loading_inv then
				if login_loading then
					login_loading = false
				end
				updateTrackItems()
				updateInventory()
			end
		end
	end

	-- Once per second...
	if os.time() > earth_time_raw then
		earth_time_raw = os.time()
		updateEarthData()
		updateGil()
		updateMoon()
	end

end)

-- Load
register_event('load', function()
	if get_info().logged_in then
		updateEarthData()
		updateTrackItems()
		updateZone()
		updateGameDay()
		updateGameTime()
		updateWeather()
		updateInventory()
		updateFood()
		updateReraise()
		updatePlayerName()
		updatePlayerJob()
		updateTP()
		updateMoon()
		if settings.first_load then
			firstLoadMessage()
		end
	end
end)

-- Login
register_event('login', function()
	char_loading = true --prevents food clearing immediately on login
	login_loading = true --prevents frame lag while loading inventory from a login
	updateEarthData()
	updateTrackItems()
	updateZone()
	updateGameDay()
	updateGameTime()
	updateWeather()
	updateFood()
	updateReraise()
	updatePlayerName()
	updatePlayerJob()
	updateTP()
	updateMoon()
	showInformerBars()
	coroutine.sleep(5)
	if settings.first_load then
		firstLoadMessage()
	end
	char_loading = false
	updateInventory()
	updateFood()
	updatePlayerJob()
end)

-- Logout
register_event('logout', function()
	hideInformerBars()
	last_item_used = nil --delete the last item used when we switch characters
end)

-- Item movement
register_event('add item', function(bag,index,id,count)
	updateTrackItems(login_loading)
	updateInventory(login_loading)
end)
register_event('remove item', function(bag,index,id,count)
	updateTrackItems()
	updateInventory()
end)

-- Job Change
register_event('job change', function()
	updateTrackItems()
	updatePlayerJob()
end)

-- Zone Change
register_event('zone change', function()
	updateZone()
	updatePlayerJob()
end)

-- Time Change
register_event('time change', function()
	updateGameTime()
end)

-- Day Change
register_event('day change', function()
	updateGameDay()
end)

-- Weather Change
register_event('weather change', function()
	updateWeather()
end)

-- TP Change
register_event('tp change', function(new_tp)
	updateTP(new_tp)
end)

-- Unrecognized command
function displayUnregnizedCommand()
	add_to_chat(220,'[Informer] '..('Unrecognized command. Type'):color(39)..(' //informer help'):color(1)..(' if you need help.'):color(39))
end

register_event('addon command',function(addcmd, ...)

	-- Update the Main bar position
	if addcmd == 'pos' or addcmd == 'posmain' or addcmd == 'mainpos' then
		local pos = {...}

		-- If there are not enough parameters then output the current position and remind how to update
		if #pos < 2 then
			add_to_chat(220,'[Informer] '..('Main Bar Position:'):color(36)..(' '..settings.pos.x..' '..settings.pos.y):color(200))
			add_to_chat(220,'[Informer] '..('Update by adding X and Y coordinates (ex.'):color(8)..(' //informer mainpos 100 200'):color(1)..(')'):color(8))

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
				add_to_chat(220,'[Informer] '..('Main Bar Position:'):color(36)..(' '..settings.pos.x..' '..settings.pos.y):color(200))

			end
		end

	-- Update the Sub1 bar position
	elseif addcmd == 'possub1' or addcmd == 'sub1pos' then
		local pos = {...}

		-- If there are not enough parameters then output the current position and remind how to update
		if #pos < 2 then
			add_to_chat(220,'[Informer] '..('Sub1 Bar Position: '):color(36)..(options.sub1.pos_x..' '..options.sub1.pos_y):color(200)..(options.sub1.visible and '' or (' Visible: '):color(8)..('Off'):color(200)))
			add_to_chat(220,'[Informer] '..('Update by adding X and Y coordinates (ex.'):color(8)..(' //informer sub1pos 100 200'):color(1)..(')'):color(8))

		-- X and Y coordinates are provided
		else
			-- Take the provided string parameters and turn them into numbers
			options.sub1.pos_x = tonumber(pos[1])
			options.sub1.pos_y = tonumber(pos[2])

			-- Position must be numbers
			if options.sub1.pos_x == nil or options.sub1.pos_y == nil then
				displayUnregnizedCommand()

			-- Save the new setting, update the position, then alert the user
			else
				settings:save('all')
				texts.pos(informer_sub1, options.sub1.pos_x, options.sub1.pos_y)
				add_to_chat(220,'[Informer] '..('Sub1 Bar Position:'):color(36)..(' '..options.sub1.pos_x..' '..options.sub1.pos_y):color(200)..(options.sub1.visible and '' or (' Visible: '):color(8)..('Off'):color(200)))

			end
		end

	-- Update the Sub2 bar position
	elseif addcmd == 'possub2' or addcmd == 'sub2pos' then
		local pos = {...}

		-- If there are not enough parameters then output the current position and remind how to update
		if #pos < 2 then
			add_to_chat(220,'[Informer] '..('Sub2 Bar Position: '):color(36)..(options.sub2.pos_x..' '..options.sub2.pos_y):color(200)..(options.sub2.visible and '' or (' Visible: '):color(8)..('Off'):color(200)))
			add_to_chat(220,'[Informer] '..('Update by adding X and Y coordinates (ex.'):color(8)..(' //informer sub2pos 100 200'):color(1)..(')'):color(8))

		-- X and Y coordinates are provided
		else
			-- Take the provided string parameters and turn them into numbers
			options.sub2.pos_x = tonumber(pos[1])
			options.sub2.pos_y = tonumber(pos[2])

			-- Position must be numbers
			if options.sub2.pos_x == nil or options.sub2.pos_y == nil then
				displayUnregnizedCommand()

			-- Save the new setting, update the position, then alert the user
			else
				settings:save('all')
				texts.pos(informer_sub2, options.sub2.pos_x, options.sub2.pos_y)
				add_to_chat(220,'[Informer] '..('Sub2 Bar Position:'):color(36)..(' '..options.sub2.pos_x..' '..options.sub2.pos_y):color(200)..(options.sub2.visible and '' or (' Visible: '):color(8)..('Off'):color(200)))

			end
		end

	-- Update the font size
	elseif addcmd == 'size' or addcmd == 'fontsize' then
		local size = {...}

		-- If there are no parameters then output the current size and remind how to update
		if #size < 1 then
			add_to_chat(220,'[Informer] '..('Font size:'):color(36)..(' '..settings.text.size):color(200))
			add_to_chat(220,'[Informer] '..('Update by adding a number (ex.'):color(8)..(' //informer size 12'):color(1)..(')'):color(8))

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
				texts.size(informer_sub1, settings.text.size)
				texts.size(informer_sub2, settings.text.size)
				add_to_chat(220,'[Informer] '..('Font Size:'):color(36)..(' '..settings.text.size):color(200))
			end
		end

	-- Turn bold on or off
	elseif addcmd == 'bold' then
		flags.bold = not flags.bold

		-- Save the new setting, update the bold setting, then alert the user
		settings:save('all')
		texts.bold(informer_main, flags.bold)
		texts.bold(informer_sub1, flags.bold)
		texts.bold(informer_sub2, flags.bold)
		add_to_chat(220,'[Informer] '..('Bold:'):color(36)..(' %s':format(flags.bold and 'ON' or 'OFF')):color(200))

	-- Turn colors on or off
	elseif addcmd == 'color' or addcmd == 'colors' then
		options.colors = not options.colors
		use_colors = options.colors

		--Update the Things that use color
		updateTrackItems()
		updateGameDay()
		updateGameTime()
		updateWeather()
		updateInventory()
		updateFood()
		updateReraise()
		updateTP()

		-- Save the new setting, update the colors setting, then alert the user
		settings:save('all')
		add_to_chat(220,'[Informer] '..('Colors:'):color(36)..(' %s':format(options.colors and 'ON' or 'OFF')):color(200))

	elseif addcmd == 'help' then
		local currMainPos = settings.pos
		local currSub1Pos = {x = options.sub1.pos_x, y = options.sub1.pos_y}
		local currSub2Pos = {x = options.sub2.pos_x, y = options.sub2.pos_y}
		local currSize = settings.text.size
		local currBold = flags.bold
		local currColor = options.colors
		local currJob = options.job
		local currLoc = options.location
		local currDay = options.day
		local currInv = options.inventory
		local currFood = options.food

		local prefix = "//informer, //info"
		add_to_chat(8,('[Informer] ':color(220))..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220)..(' ('):color(8)..(prefix):color(1)..(')'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,(' Command '):color(36)..('[optional]'):color(53)..(' - Description ['):color(8)..('Current Setting'):color(200)..(']'):color(8))
		add_to_chat(8,(' mainpos '):color(36)..('[x y]'):color(53)..(' - Update Main Bar Position. ['):color(8)..(currMainPos.x..' '..currMainPos.y):color(200)..(']'):color(8))
		add_to_chat(8,(' sub1pos '):color(36)..('[x y]'):color(53)..(' - Update Sub1 Bar Position. ['):color(8)..(currSub1Pos.x..' '..currSub1Pos.y):color(200)..(']'):color(8))
		add_to_chat(8,(' sub2pos '):color(36)..('[x y]'):color(53)..(' - Update Sub2 Bar Position. ['):color(8)..(currSub2Pos.x..' '..currSub2Pos.y):color(200)..(']'):color(8))
		add_to_chat(8,(' size '):color(36)..('[#]'):color(53)..(' - Update font size. ['):color(8)..(''..currSize):color(200)..(']'):color(8))
		add_to_chat(8,(' bold'):color(36)..(' - Update bold setting. ['):color(8)..('%s':format(currBold and 'ON' or 'OFF')):color(200)..(']'):color(8))
		add_to_chat(8,(' color'):color(36)..(' - Update color setting. ['):color(8)..('%s':format(currColor and 'ON' or 'OFF')):color(200)..(']'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,' Change the bar layouts in /data/settings.xml')

	else
		displayUnregnizedCommand()
	end
	
end)
