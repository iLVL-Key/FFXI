--Copyright (c) 2024, Key
--All rights reserved.

--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:

--    * Redistributions of source code must retain the above copyright
--      notice, this list of conditions and the following disclaimer.
--    * Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in the
--      documentation and/or other materials provided with the distribution.
--    * Neither the name of Bars nor the
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

_addon.name = 'Bars'
_addon.version = '2.0'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'bars'}

config = require('config')
texts = require('texts')
res = require('resources')
require 'chat'

defaults = {
	pos = {x = 600, y = 600},
	bg = {alpha = 190, red = 0, green = 0, blue = 0},
	text = {alpha = 255, blue = 255, green = 255, red = 255, font = 'Consolas', size = 10},
	flags = {draggable = false, italic = false, bold = true, right = false, bottom = false},
	auto_focus_target_list = {},
	options = {
		bar_width = 100,
		bars_vertical_spacing = {target_to_focus_target = -40, target_to_player_stats = 45, between_player_stats = 23},
		clear_action_delay = 4.5,
		focus_target_max_distance = 50,
		hide_focus_target_when_target = true,
		max_action_length = 17,
		max_name_length = 20,
		remove_tachi_blade_from_ws_name = false,
		self_action_text_size_difference = 1,
		short_skillchain_names = true,
		show_fancy_rolls = true,
		show_action_status_indicators = true,
		show_bar_markers = true,
		show_bars = {
			brd = {hp = true, mp = false, pet = false, tp = true, vertical_offset = 0},
			blm = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			blu = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			bst = {hp = true, mp = false, pet = true, tp = true, vertical_offset = 0},
			cor = {hp = true, mp = false, pet = false, tp = true, vertical_offset = 0},
			dnc = {hp = true, mp = false, pet = false, tp = true, vertical_offset = 0},
			drg = {hp = true, mp = false, pet = true, tp = true, vertical_offset = 0},
			drk = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			geo = {hp = true, mp = true, pet = true, tp = true, vertical_offset = 0},
			mnk = {hp = true, mp = false, pet = false, tp = true, vertical_offset = 0},
			nin = {hp = true, mp = false, pet = false, tp = true, vertical_offset = 0},
			pld = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			pup = {hp = true, mp = false, pet = true, tp = true, vertical_offset = 0},
			rdm = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			rng = {hp = true, mp = false, pet = false, tp = true, vertical_offset = 0},
			run = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			sam = {hp = true, mp = false, pet = false, tp = true, vertical_offset = 0},
			sch = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			smn = {hp = true, mp = true, pet = true, tp = true, vertical_offset = 0},
			thf = {hp = true, mp = false, pet = false, tp = true, vertical_offset = 0},
			war = {hp = true, mp = false, pet = false, tp = true, vertical_offset = 0},
			whm = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
		},
		show_commas_on_numbers = true,
		show_max_hp_mp_on_bar = true,
		show_roll_lucky_info = true,
		show_self_when_target = false,
		show_self_action = true,
		show_target_action = true,
		show_target_action_result = true,
		show_target_distance = true,
		show_target_index = false,
		target_action_text_size_difference = 1,
		target_text_size_difference = 4,
		text_vertical_offset = -8,
	},
	colors = {
		target = {
			monster_passive = {r = 247, g = 237, b = 141},
			monster_claimed_party = {r = 255, g = 77, b = 77},
			monster_claimed_alliance = {r = 255, g = 77, b = 100},
			monster_claimed_other = {r = 211, g = 107, b = 211},
			npc = {r = 140, g = 227, b = 132},
			pc_alliance = {r = 158, g = 226, b = 255},
			pc_other = {r = 230, g = 230, b = 230},
			pc_party = {r = 158, g = 226, b = 255},
			pc_self = {r = 66, g = 135, b = 245},
		},
		self = {
			bar = {r = 240, g = 240, b = 240},
		},
		hp = {
			bar = {r = 240, g = 128, b = 131},
			quarter_1 = {r = 255, g = 77, b = 77},
			quarter_2 = {r = 255, g = 139, b = 56},
			quarter_3 = {r = 230, g = 255, b = 117},
			quarter_4 = {r = 255, g = 255, b = 255},
		},
		mp = {
			bar = {r = 189, g = 192, b = 122},
			quarter_1 = {r = 255, g = 77, b = 77},
			quarter_2 = {r = 255, g = 139, b = 56},
			quarter_3 = {r = 230, g = 255, b = 117},
			quarter_4 = {r = 255, g = 255, b = 255},
		},
		pet = {
			bar = {r = 200, g = 75, b = 255},
			quarter_1 = {r = 255, g = 77, b = 77},
			quarter_2 = {r = 255, g = 139, b = 56},
			quarter_3 = {r = 230, g = 255, b = 117},
			quarter_4 = {r = 255, g = 255, b = 255},
		},
		tp = {
			less_than_1k = {r = 230, g = 230, b = 230},
			full_1k = {r = 0, g = 127, b = 255},
			full_2k = {r = 75, g = 255, b = 75},
			full_3k = {r = 255, g = 255, b = 50},
			ready_to_use = {r = 25, g = 255, b = 25},
		},
		elements = {
			light = {r = 255, g = 248, b = 220},
			fire = {r = 255, g = 0, b = 0},
			ice = {r = 135, g = 206, b = 250},
			wind = {r = 50, g = 205, b = 50},
			earth = {r = 250, g = 130, b = 40},
			lightning = {r = 186, g = 85, b = 211},
			water = {r = 30, g = 144, b = 255},
			dark = {r = 200, g = 30, b = 80},
			none = {r = 255, g = 255, b = 255},
		},
		rolls = {
			lucky = {r = 50, g = 255, b = 50},
			unlucky = {r = 255, g = 50, b = 50},
			eleven = {r = 255, g = 255, b = 50},
		},
	},
}

settings = config.load(defaults)

local bar_width = settings.options.bar_width
local bars_vertical_spacing = settings.options.bars_vertical_spacing
local clear_action_delay = settings.options.clear_action_delay
local auto_focus_target_list = settings.auto_focus_target_list
local focus_target_max_distance = settings.options.focus_target_max_distance
local hide_focus_target_when_target = settings.options.hide_focus_target_when_target
local max_action_length = settings.options.max_action_length
local max_name_length = settings.options.max_name_length
local remove_tachi_blade_from_ws_name = settings.options.remove_tachi_blade_from_ws_name
local short_skillchain_names = settings.options.short_skillchain_names
local show_bar_markers = settings.options.show_bar_markers
local show_bars = settings.options.show_bars
local show_commas_on_numbers = settings.options.show_commas_on_numbers
local show_fancy_rolls = settings.options.show_fancy_rolls
local show_max_hp_mp_on_bar = settings.options.show_max_hp_mp_on_bar
local show_roll_lucky_info = settings.options.show_roll_lucky_info
local show_self_action = settings.options.show_self_action
local show_self_when_target = settings.options.show_self_when_target
local show_target_action = settings.options.show_target_action
local show_target_action_result = settings.options.show_target_action_result
local show_target_distance = settings.options.show_target_distance
local show_action_status_indicators = settings.options.show_action_status_indicators
local show_target_index = settings.options.show_target_index
local self_action_text_size_difference = settings.options.self_action_text_size_difference
local target_action_text_size_difference = settings.options.target_action_text_size_difference
local target_text_size_difference = settings.options.target_text_size_difference
local text_vertical_offset = settings.options.text_vertical_offset
local color = settings.colors
local text_color = {r = settings.text.red, g = settings.text.green, b = settings.text.blue}
local font = settings.text.font
local bg_alpha = settings.bg.alpha
local cmd = windower.send_command
local element_colors = {
	[0] = { r = color.elements.fire.r, g = color.elements.fire.g, b = color.elements.fire.b },
	[1] = { r = color.elements.ice.r, g = color.elements.ice.g, b = color.elements.ice.b },
	[2] = { r = color.elements.wind.r, g = color.elements.wind.g, b = color.elements.wind.b },
	[3] = { r = color.elements.earth.r, g = color.elements.earth.g, b = color.elements.earth.b },
	[4] = { r = color.elements.lightning.r, g = color.elements.lightning.g, b = color.elements.lightning.b },
	[5] = { r = color.elements.water.r, g = color.elements.water.g, b = color.elements.water.b },
	[6] = { r = color.elements.light.r, g = color.elements.light.g, b = color.elements.light.b },
	[7] = { r = color.elements.dark.r, g = color.elements.dark.g, b = color.elements.dark.b },
	[15] = { r = color.elements.none.r, g = color.elements.none.g, b = color.elements.none.b },
}

local inCS = false
local zoning = false
local job = ''
local current_actions = {}
local focus_target = nil
local bars_bg_str = ''
local bars_bg_str_ft = ''
local bars_bg_str_hp = ''
local bars_bg_str_tp = ''
local index = 0

--BACKGROUNDS

--Create the Focus Target BACKGROUND text object
local bars_bg_focus_target = texts.new()
bars_bg_focus_target:font(font)
bars_bg_focus_target:pad(-4)
bars_bg_focus_target:bg_alpha(bg_alpha)
bars_bg_focus_target:draggable(false)

--Create the Target BACKGROUND text object
local bars_bg_target = texts.new()
bars_bg_target:font(font)
bars_bg_target:pad(-4)
bars_bg_target:bg_alpha(bg_alpha)
bars_bg_target:draggable(false)

--Create the Self Action BACKGROUND text object
local bars_bg_self_action = texts.new()
bars_bg_self_action:font(font)
bars_bg_self_action:pad(-4)
bars_bg_self_action:bg_alpha(bg_alpha)
bars_bg_self_action:draggable(false)

--Create the HP BACKGROUND text object
local bars_bg_hp = texts.new()
bars_bg_hp:font(font)
bars_bg_hp:pad(-4)
bars_bg_hp:bg_alpha(bg_alpha)
bars_bg_hp:draggable(false)

--Create the MP BACKGROUND text object
local bars_bg_mp = texts.new()
bars_bg_mp:font(font)
bars_bg_mp:pad(-4)
bars_bg_mp:bg_alpha(bg_alpha)
bars_bg_mp:draggable(false)

--Create the TP BACKGROUND text object
local bars_bg_tp = texts.new()
bars_bg_tp:font(font)
bars_bg_tp:pad(-4)
bars_bg_tp:bg_alpha(bg_alpha)
bars_bg_tp:draggable(false)

--Create the Pet BACKGROUND text object
local bars_bg_pet = texts.new()
bars_bg_pet:font(font)
bars_bg_pet:pad(-4)
bars_bg_pet:bg_alpha(bg_alpha)
bars_bg_pet:draggable(false)

--METERS

--Create the Focus Target METER text object
local bars_meter_focus_target = texts.new()
bars_meter_focus_target:font(font)
bars_meter_focus_target:pad(-5)
bars_meter_focus_target:bg_alpha(bg_alpha)
bars_meter_focus_target:draggable(false)

--Create the Target METER text object
local bars_meter_target = texts.new()
bars_meter_target:font(font)
bars_meter_target:pad(-5)
bars_meter_target:bg_alpha(bg_alpha)
bars_meter_target:draggable(false)

--Create the Self Action METER text object
local bars_meter_self_action = texts.new()
bars_meter_self_action:font(font)
bars_meter_self_action:pad(-5)
bars_meter_self_action:bg_alpha(bg_alpha)
bars_meter_self_action:bg_color(color.self.bar.r,color.self.bar.g,color.self.bar.b)
bars_meter_self_action:draggable(false)

--Create the HP METER text object
local bars_meter_hp = texts.new()
bars_meter_hp:font(font)
bars_meter_hp:pad(-5)
bars_meter_hp:bg_alpha(bg_alpha)
bars_meter_hp:bg_color(color.hp.bar.r,color.hp.bar.g,color.hp.bar.b)
bars_meter_hp:draggable(false)

--Create the MP METER text object
local bars_meter_mp = texts.new()
bars_meter_mp:font(font)
bars_meter_mp:pad(-5)
bars_meter_mp:bg_alpha(bg_alpha)
bars_meter_mp:bg_color(color.mp.bar.r,color.mp.bar.g,color.mp.bar.b)
bars_meter_mp:draggable(false)

--Create the TP METER text object
local bars_meter_tp = texts.new()
bars_meter_tp:font(font)
bars_meter_tp:pad(-5)
bars_meter_tp:bg_alpha(bg_alpha)
bars_meter_tp:draggable(false)

--Create the Pet METER text object
local bars_meter_pet = texts.new()
bars_meter_pet:font(font)
bars_meter_pet:pad(-5)
bars_meter_pet:bg_alpha(bg_alpha)
bars_meter_pet:draggable(false)

--MARKERS

--Create the HP MARKER text object
local bars_marker_hp = texts.new()
bars_marker_hp:font(font)
bars_marker_hp:pad(-4)
bars_marker_hp:bg_alpha(0)
bars_marker_hp:draggable(false)

--Create the TP MARKER text object
local bars_marker_tp = texts.new()
bars_marker_tp:font(font)
bars_marker_tp:pad(-4)
bars_marker_tp:bg_alpha(0)
bars_marker_tp:draggable(false)

--TEXT SHADOW

--Create the Focus Target TEXT SHADOW text object
local bars_text_shdw_focus_target = texts.new()
bars_text_shdw_focus_target:font(font)
bars_text_shdw_focus_target:color(0,0,0)
bars_text_shdw_focus_target:bg_alpha(0)
bars_text_shdw_focus_target:draggable(false)

--Create the Focus Target Action TEXT SHADOW text object
local bars_text_shdw_focus_target_action = texts.new()
bars_text_shdw_focus_target_action:font(font)
bars_text_shdw_focus_target_action:color(0,0,0)
bars_text_shdw_focus_target_action:bg_alpha(0)
bars_text_shdw_focus_target_action:draggable(false)

--Create the Target TEXT SHADOW text object
local bars_text_shdw_target = texts.new()
bars_text_shdw_target:font(font)
bars_text_shdw_target:color(0,0,0)
bars_text_shdw_target:bg_alpha(0)
bars_text_shdw_target:draggable(false)

--Create the Target Action TEXT SHADOW text object
local bars_text_shdw_target_action = texts.new()
bars_text_shdw_target_action:font(font)
bars_text_shdw_target_action:color(0,0,0)
bars_text_shdw_target_action:bg_alpha(0)
bars_text_shdw_target_action:draggable(false)

--Create the Self Action TEXT SHADOW text object
local bars_text_shdw_self_action = texts.new()
bars_text_shdw_self_action:font(font)
bars_text_shdw_self_action:color(0,0,0)
bars_text_shdw_self_action:bg_alpha(0)
bars_text_shdw_self_action:draggable(false)

--Create the HP TEXT SHADOW text object
local bars_text_shdw_hp = texts.new()
bars_text_shdw_hp:font(font)
bars_text_shdw_hp:color(0,0,0)
bars_text_shdw_hp:bg_alpha(0)
bars_text_shdw_hp:draggable(false)

--Create the MP TEXT SHADOW text object
local bars_text_shdw_mp = texts.new()
bars_text_shdw_mp:font(font)
bars_text_shdw_mp:color(0,0,0)
bars_text_shdw_mp:bg_alpha(0)
bars_text_shdw_mp:draggable(false)

--Create the TP TEXT SHADOW text object
local bars_text_shdw_tp = texts.new()
bars_text_shdw_tp:font(font)
bars_text_shdw_tp:color(0,0,0)
bars_text_shdw_tp:bg_alpha(0)
bars_text_shdw_tp:draggable(false)

--Create the Pet TEXT SHADOW text object
local bars_text_shdw_pet = texts.new()
bars_text_shdw_pet:font(font)
bars_text_shdw_pet:color(0,0,0)
bars_text_shdw_pet:bg_alpha(0)
bars_text_shdw_pet:draggable(false)

--TEXT

--Create the Focus Target TEXT text object
local bars_text_focus_target = texts.new()
bars_text_focus_target:font(font)
bars_text_focus_target:color(text_color.r,text_color.g,text_color.b)
bars_text_focus_target:bg_alpha(0)
bars_text_focus_target:draggable(false)

--Create the Focus Target Action TEXT text object
local bars_text_focus_target_action = texts.new()
bars_text_focus_target_action:font(font)
bars_text_focus_target_action:color(text_color.r,text_color.g,text_color.b)
bars_text_focus_target_action:bg_alpha(0)
bars_text_focus_target_action:draggable(false)

--Create the Target TEXT text object
local bars_text_target = texts.new()
bars_text_target:font(font)
bars_text_target:color(text_color.r,text_color.g,text_color.b)
bars_text_target:bg_alpha(0)
bars_text_target:draggable(false)

--Create the Target Action TEXT text object
local bars_text_target_action = texts.new()
bars_text_target_action:font(font)
bars_text_target_action:color(text_color.r,text_color.g,text_color.b)
bars_text_target_action:bg_alpha(0)
bars_text_target_action:draggable(false)

--Create the Self Action TEXT text object
local bars_text_self_action = texts.new()
bars_text_self_action:font(font)
bars_text_self_action:color(text_color.r,text_color.g,text_color.b)
bars_text_self_action:bg_alpha(0)
bars_text_self_action:draggable(false)

--Create the HP TEXT text object
local bars_text_hp = texts.new()
bars_text_hp:font(font)
bars_text_hp:color(text_color.r,text_color.g,text_color.b)
bars_text_hp:bg_alpha(0)
bars_text_hp:draggable(false)

--Create the MP TEXT text object
local bars_text_mp = texts.new()
bars_text_mp:font(font)
bars_text_mp:color(text_color.r,text_color.g,text_color.b)
bars_text_mp:bg_alpha(0)
bars_text_mp:draggable(false)

--Create the TP TEXT text object
local bars_text_tp = texts.new()
bars_text_tp:font(font)
bars_text_tp:color(text_color.r,text_color.g,text_color.b)
bars_text_tp:bg_alpha(0)
bars_text_tp:draggable(false)

--Create the Pet TEXT text object
local bars_text_pet = texts.new()
bars_text_pet:font(font)
bars_text_pet:color(text_color.r,text_color.g,text_color.b)
bars_text_pet:bg_alpha(0)
bars_text_pet:draggable(false)

--Destroy all the text objects when we unload the addon
windower.register_event('unload', function()

	bars_bg_focus_target:destroy()
	bars_bg_target:destroy()
	bars_bg_self_action:destroy()
	bars_bg_hp:destroy()
	bars_bg_mp:destroy()
	bars_bg_tp:destroy()
	bars_bg_pet:destroy()
	bars_meter_focus_target:destroy()
	bars_meter_target:destroy()
	bars_meter_self_action:destroy()
	bars_meter_hp:destroy()
	bars_meter_mp:destroy()
	bars_meter_tp:destroy()
	bars_meter_pet:destroy()
	bars_marker_hp:destroy()
	bars_marker_tp:destroy()
	bars_text_shdw_focus_target:destroy()
	bars_text_shdw_focus_target_action:destroy()
	bars_text_shdw_target:destroy()
	bars_text_shdw_target_action:destroy()
	bars_text_shdw_self_action:destroy()
	bars_text_shdw_hp:destroy()
	bars_text_shdw_mp:destroy()
	bars_text_shdw_tp:destroy()
	bars_text_shdw_pet:destroy()
	bars_text_focus_target:destroy()
	bars_text_focus_target_action:destroy()
	bars_text_target:destroy()
	bars_text_target_action:destroy()
	bars_text_self_action:destroy()
	bars_text_hp:destroy()
	bars_text_mp:destroy()
	bars_text_tp:destroy()
	bars_text_pet:destroy()

end)

--Set the bars to bold or not
local function setBold()

	local bold = settings.flags.bold

	bars_marker_hp:bold(bold)
	bars_marker_tp:bold(bold)
	bars_text_shdw_focus_target:bold(bold)
	bars_text_shdw_focus_target_action:bold(bold)
	bars_text_shdw_target:bold(bold)
	bars_text_shdw_target_action:bold(bold)
	bars_text_shdw_self_action:bold(bold)
	bars_text_shdw_hp:bold(bold)
	bars_text_shdw_mp:bold(bold)
	bars_text_shdw_tp:bold(bold)
	bars_text_shdw_pet:bold(bold)
	bars_text_focus_target:bold(bold)
	bars_text_focus_target_action:bold(bold)
	bars_text_target:bold(bold)
	bars_text_target_action:bold(bold)
	bars_text_self_action:bold(bold)
	bars_text_hp:bold(bold)
	bars_text_mp:bold(bold)
	bars_text_tp:bold(bold)
	bars_text_pet:bold(bold)

end

--Set the bars to their appropriate sizes
local function setSize()

	local size = settings.text.size

	bars_bg_focus_target:size(size)
	bars_bg_target:size(size)
	bars_bg_self_action:size(size)
	bars_bg_hp:size(size)
	bars_bg_mp:size(size)
	bars_bg_tp:size(size)
	bars_bg_pet:size(size)
	bars_meter_focus_target:size(size)
	bars_meter_target:size(size)
	bars_meter_self_action:size(size)
	bars_meter_hp:size(size)
	bars_meter_mp:size(size)
	bars_meter_tp:size(size)
	bars_meter_pet:size(size)
	bars_marker_hp:size(size)
	bars_marker_tp:size(size)
	bars_text_shdw_focus_target:size(size)
	bars_text_shdw_focus_target_action:size(size)
	bars_text_shdw_target:size(size+target_text_size_difference)
	bars_text_shdw_target_action:size(size+target_action_text_size_difference)
	bars_text_shdw_self_action:size(size+self_action_text_size_difference)
	bars_text_shdw_hp:size(size)
	bars_text_shdw_mp:size(size)
	bars_text_shdw_tp:size(size)
	bars_text_shdw_pet:size(size)
	bars_text_focus_target:size(size)
	bars_text_focus_target_action:size(size)
	bars_text_target:size(size+target_text_size_difference)
	bars_text_target_action:size(size+target_action_text_size_difference)
	bars_text_self_action:size(size+self_action_text_size_difference)
	bars_text_hp:size(size)
	bars_text_mp:size(size)
	bars_text_tp:size(size)
	bars_text_pet:size(size)

end

--Set the bars in their appropriate positions
local function setPosition()

	local pos_target = {x = settings.pos.x, y = settings.pos.y + show_bars[job].vertical_offset}
	local pos_focus_target = {x = pos_target.x, y = pos_target.y + bars_vertical_spacing.target_to_focus_target}
	local player_stats_1 = {x = pos_target.x, y = pos_target.y + bars_vertical_spacing.target_to_player_stats}
	local player_stats_2 = {x = pos_target.x, y = player_stats_1.y + bars_vertical_spacing.between_player_stats}
	local player_stats_3 = {x = pos_target.x, y = player_stats_2.y + bars_vertical_spacing.between_player_stats}
	local player_stats_4 = {x = pos_target.x, y = player_stats_3.y + bars_vertical_spacing.between_player_stats}
	local player_stats_5 = {x = pos_target.x, y = player_stats_4.y + bars_vertical_spacing.between_player_stats}

	--Initial placement of bars assuming all are displayed
	local pos_self = player_stats_1
	local pos_hp = player_stats_2
	local pos_mp = player_stats_3
	local pos_tp = player_stats_4
	local pos_pet = player_stats_5

	--Order the bars based on which are displayed
	--This is super ugly, but... it works
	if not show_self_action then
		if not show_bars[job].hp then
			if not show_bars[job].mp then
				if not show_bars[job].tp then
					pos_pet = player_stats_1
				else
					pos_tp = player_stats_1
					pos_pet = player_stats_2
				end
			else
				pos_mp = player_stats_1
				if not show_bars[job].tp then
					pos_pet = player_stats_2
				else
					pos_tp = player_stats_2
					pos_pet = player_stats_3
				end
			end
		else
			pos_hp = player_stats_1
			if not show_bars[job].mp then
				if not show_bars[job].tp then
					pos_pet = player_stats_2
				else
					pos_tp = player_stats_2
					pos_pet = player_stats_3
				end
			else
				pos_mp = player_stats_2
				if not show_bars[job].tp then
					pos_pet = player_stats_3
				else
					pos_tp = player_stats_3
					pos_pet = player_stats_4
				end
			end
		end
	else
		pos_self = player_stats_1
		if not show_bars[job].hp then
			if not show_bars[job].mp then
				if not show_bars[job].tp then
					pos_pet = player_stats_2
				else
					pos_tp = player_stats_2
					pos_pet = player_stats_3
				end
			else
				pos_mp = player_stats_2
				if not show_bars[job].tp then
					pos_pet = player_stats_3
				else
					pos_tp = player_stats_3
					pos_pet = player_stats_4
				end
			end
		else
			pos_hp = player_stats_2
			if not show_bars[job].mp then
				if not show_bars[job].tp then
					pos_pet = player_stats_3
				else
					pos_tp = player_stats_3
					pos_pet = player_stats_4
				end
			else
				pos_mp = player_stats_3
				if not show_bars[job].tp then
					pos_pet = player_stats_4
				else
					pos_tp = player_stats_4
					pos_pet = player_stats_5
				end
			end
		end
	end

	bars_bg_focus_target:pos(pos_focus_target.x,pos_focus_target.y+8)
	bars_bg_target:pos(pos_target.x,pos_target.y+8)
	bars_bg_self_action:pos(pos_self.x,pos_self.y+8)
	bars_bg_hp:pos(pos_hp.x,pos_hp.y+8)
	bars_bg_mp:pos(pos_mp.x,pos_mp.y+8)
	bars_bg_tp:pos(pos_tp.x,pos_tp.y+8)
	bars_bg_pet:pos(pos_pet.x,pos_pet.y+8)
	bars_meter_focus_target:pos(pos_focus_target.x+1,pos_focus_target.y+9)
	bars_meter_target:pos(pos_target.x+1,pos_target.y+9)
	bars_meter_self_action:pos(pos_self.x+1,pos_self.y+9)
	bars_meter_hp:pos(pos_hp.x+1,pos_hp.y+9)
	bars_meter_mp:pos(pos_mp.x+1,pos_mp.y+9)
	bars_meter_tp:pos(pos_tp.x+1,pos_tp.y+9)
	bars_meter_pet:pos(pos_pet.x+1,pos_pet.y+9)
	bars_marker_hp:pos(pos_hp.x,pos_hp.y+7)
	bars_marker_tp:pos(pos_tp.x,pos_tp.y+7)
	bars_text_shdw_focus_target:pos(pos_focus_target.x+1.5,pos_focus_target.y+text_vertical_offset+1.5)
	bars_text_shdw_focus_target_action:pos(pos_focus_target.x+1.5,pos_focus_target.y+1.5+13)
	bars_text_shdw_target:pos(pos_target.x+1.5,pos_target.y+text_vertical_offset+1.5-target_text_size_difference)
	bars_text_shdw_target_action:pos(pos_target.x+1.5,pos_target.y+1.5+13)
	bars_text_shdw_self_action:pos(pos_self.x+1.5,pos_self.y+text_vertical_offset+1.5-self_action_text_size_difference)
	bars_text_shdw_hp:pos(pos_hp.x+1.5,pos_hp.y+text_vertical_offset+1.5)
	bars_text_shdw_mp:pos(pos_mp.x+1.5,pos_mp.y+text_vertical_offset+1.5)
	bars_text_shdw_tp:pos(pos_tp.x+1.5,pos_tp.y+text_vertical_offset+1.5)
	bars_text_shdw_pet:pos(pos_pet.x+1.5,pos_pet.y+text_vertical_offset+1.5)
	bars_text_focus_target:pos(pos_focus_target.x,pos_focus_target.y+text_vertical_offset)
	bars_text_focus_target_action:pos(pos_focus_target.x,pos_focus_target.y+13)
	bars_text_target:pos(pos_target.x,pos_target.y+text_vertical_offset-target_text_size_difference)
	bars_text_target_action:pos(pos_target.x,pos_target.y+13)
	bars_text_self_action:pos(pos_self.x,pos_self.y+text_vertical_offset-self_action_text_size_difference)
	bars_text_hp:pos(pos_hp.x,pos_hp.y+text_vertical_offset)
	bars_text_mp:pos(pos_mp.x,pos_mp.y+text_vertical_offset)
	bars_text_tp:pos(pos_tp.x,pos_tp.y+text_vertical_offset)
	bars_text_pet:pos(pos_pet.x,pos_pet.y+text_vertical_offset)

end

--Set the width of various elements based on the bar_width option
local function setWidth()

	bar_width = settings.options.bar_width
	show_bar_markers = settings.options.show_bar_markers
	bars_bg_str = ''
	bars_bg_str_ft = ''
	bars_bg_str_hp = ''
	bars_bg_str_tp = ''

	--Sets the width for most of the bg elements
	while string.len(bars_bg_str) < bar_width do
		bars_bg_str = bars_bg_str..' '
	end

	--Sets the width for the focus target bg element
	while string.len(bars_bg_str_ft) < math.floor(bar_width / 2) do
		bars_bg_str_ft = bars_bg_str_ft..' '
	end

	--Sets the width and yellow HP marker for the HP bar BG
	local marker_position = math.floor(bar_width * 0.75)

	for i = 1, bar_width do
		if i == marker_position then
			bars_bg_str_hp = bars_bg_str_hp..'·'
		else
			bars_bg_str_hp = bars_bg_str_hp..' '
		end
	end

	--Sets the width and 1k/2k markers for the TP bar BG
	local first_marker_position = math.floor(bar_width * 0.33)
	local second_marker_position = math.floor(bar_width * 0.66)

	for i = 1, bar_width do
		if i == first_marker_position or i == second_marker_position then
			bars_bg_str_tp = bars_bg_str_tp..'·'
		else
			bars_bg_str_tp = bars_bg_str_tp..' '
		end
	end

	bars_bg_focus_target:text(bars_bg_str_ft)
	bars_bg_target:text(bars_bg_str)
	bars_bg_self_action:text(bars_bg_str)
	bars_bg_hp:text(bars_bg_str)
	bars_bg_mp:text(bars_bg_str)
	bars_bg_tp:text(bars_bg_str)
	bars_bg_pet:text(bars_bg_str)
	bars_marker_hp:text(show_bar_markers and bars_bg_str_hp or bars_bg_str)
	bars_marker_tp:text(show_bar_markers and bars_bg_str_tp or bars_bg_str)

end

--Hide all bars
local function hideBars()

	bars_bg_focus_target:hide()
	bars_bg_target:hide()
	bars_bg_self_action:hide()
	bars_bg_hp:hide()
	bars_bg_mp:hide()
	bars_bg_tp:hide()
	bars_bg_pet:hide()
	bars_meter_focus_target:hide()
	bars_meter_target:hide()
	bars_meter_self_action:hide()
	bars_meter_hp:hide()
	bars_meter_mp:hide()
	bars_meter_tp:hide()
	bars_marker_hp:hide()
	bars_marker_tp:hide()
	bars_text_shdw_focus_target:hide()
	bars_text_shdw_focus_target_action:hide()
	bars_text_shdw_target:hide()
	bars_text_shdw_target_action:hide()
	bars_text_shdw_self_action:hide()
	bars_text_shdw_hp:hide()
	bars_text_shdw_mp:hide()
	bars_text_shdw_tp:hide()
	bars_text_shdw_pet:hide()
	bars_text_focus_target:hide()
	bars_text_focus_target_action:hide()
	bars_text_target:hide()
	bars_text_target_action:hide()
	bars_text_self_action:hide()
	bars_text_hp:hide()
	bars_text_mp:hide()
	bars_text_tp:hide()
	bars_text_pet:hide()

end

--Show appropriate bars
local function showBars()

	if show_bars[job].hp then
		bars_bg_hp:show()
		bars_meter_hp:show()
		if show_bar_markers then
			bars_marker_hp:show()
		end
		bars_text_shdw_hp:show()
		bars_text_hp:show()
	end

	if show_bars[job].mp then
		bars_bg_mp:show()
		bars_meter_mp:show()
		bars_text_shdw_mp:show()
		bars_text_mp:show()
	end

	if show_bars[job].tp then
		bars_bg_tp:show()
		bars_meter_tp:show()
		if show_bar_markers then
			bars_marker_tp:show()
		end
		bars_text_shdw_tp:show()
		bars_text_tp:show()
	end

	if show_bars[job].pet then
		bars_bg_pet:show()
		bars_meter_pet:show()
		bars_text_shdw_pet:show()
		bars_text_pet:show()
	end

end

--Set what job we are currently
local function setJob()

	local player = windower.ffxi.get_player()
	job = string.lower(player.main_job)

end

--Assign and incrememnt a new tracking index number
local function assignIndex()

	local assignedIndex = index

	index = (index + 1) % 1000 --Increment and reset to 0 when index reaches 1000

	return assignedIndex

end

--Add an action to the current_actions table
local function addToActionsTable(actor_id, action, action_shdw, status, status_shdw, result, result_shdw, index)

	current_actions[actor_id] = {
		action = action,
		action_shdw = action_shdw,
		status = status,
		status_shdw = status_shdw,
		result = result,
		result_shdw = result_shdw,
		index = index,
	}

end

--Update the status of an action in the current_actions table
local function updateActionTable(actor_id, status, status_shdw, result, result_shdw, index)

	local action = current_actions[actor_id]
	if action then
		action.status, action.status_shdw, action.result, action.result_shdw, action.index = 
			status, status_shdw, result, result_shdw, index
	end

end

--Remove an action from the current_actions table
local function removeFromActionsTable(actor_id, index)

	if current_actions[actor_id] and current_actions[actor_id].index == index then
		current_actions[actor_id] = nil
	end

end

--Clear all actions from the current_actions table
local function clearActionsTable()

	current_actions = {}

end

--Add commas to numbers to make them easier to read
local function addCommas(number)

	local formattedNumber = number
	
	if show_commas_on_numbers then

		--Convert the number to a string
		formattedNumber = tostring(number)

		local length = #formattedNumber

		--Every third place insert a comma
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

--Is the target a player?
local function isPlayer(id)

	local actor = windower.ffxi.get_mob_by_id(id)

	--Is a player
	if actor and (actor.spawn_type == 1 or actor.spawn_type == 9 or actor.spawn_type == 13) then
		return true
	--Is not a player
	else
		return false
	end

end

--Is this player in our party?
local function isInParty(id)

	local actor = windower.ffxi.get_mob_by_id(id)

	--Not in our party
	if actor == nil or not actor.in_party then
		return false
	--In our party
	else
		return true
	end

end

--Is this player in our alliance?
local function isInAlliance(id)

	local actor = windower.ffxi.get_mob_by_id(id)

	--Not in our alliance
	if actor == nil or not actor.in_alliance then
		return false
	--In our alliance
	else
		return true
	end

end

--Return what color the target should be based on what/who it is
local function targetColor(target)

	local player = windower.ffxi.get_player()

	--Player (us)
	if target and target.id == player.id then
		return color.target.pc_self

	--Party member
	elseif target and isInParty(target.id) then
		return color.target.pc_party

	--Alliance member
	elseif target and isInAlliance(target.id) then
		return color.target.pc_alliance

	--NPCs
	elseif target and target.is_npc then
		--Monsters
		if target.spawn_type == 16 then
			--Passive
			if target.claim_id == 0 then
				return color.target.monster_passive
			--Claimed by our Party
			elseif isInParty(target.claim_id) then
				return color.target.monster_claimed_party
			--Claimed by our alliance
			elseif isInAlliance(target.claim_id) then
				return color.target.monster_claimed_alliance
			--Claimed by others
			else
				return color.target.monster_claimed_other
			end
		else
			return color.target.npc
		end

	--Player (others)
	else
		return color.target.pc_other
	end

end

--Capitalize letters accordingly
local function capitalize(str)

	return string.gsub(str, "(%w)(%w*)", function(firstLetter, rest)
		return string.upper(firstLetter) .. string.lower(rest)
	end)

end

--Turn the entire string into all uppercase
local function uppercase(str)

	local uppercased = string.gsub(str, "%a", function(letter)
		return letter:upper()
	end)

	return uppercased

end

--Truncate names that are too long
local function truncateAction(action)

	local num = max_action_length

	-- Remove "Tachi: " or "Blade: " if present at the start
	if remove_tachi_blade_from_ws_name then
		if string.sub(action, 1, 7) == "Tachi: " then
			action = string.sub(action, 8)
		elseif string.sub(action, 1, 7) == "Blade: " then
			action = string.sub(action, 8)
		end
	end

	--Check if the string length is greater than max_name_length
	if #action > num then
		--Truncate to 14 characters and add a period
		action = string.sub(action, 1, num-1).."."
	end

	return action

end

--Truncate names that are too long
local function truncateName(name)

	local num = max_name_length

	--Check if the string length is greater than max_name_length
	if #name > num then
		--Truncate to 14 characters and add a period
		name = string.sub(name, 1, num-1).."."
	end

	return name

end

--Format RGB values with leading zeros (helps prevent an issue with the shadow text not lining up correctly)
local function formatRGB(value)

	return string.format("%03d", value)

end

--Convert auto focus targets to save them properly
local function convertToSave(target)

	target = string.lower(target) --convert target to all lowercase
	target = string.gsub(target, " ", "_") --convert spaces to underscores
	target = string.gsub(target, "'", "__apos__") --convert apostrophes to __apos__

	return target

end

--Convert auto focus targets to display them properly
local function convertToDisplay(target)

	target = string.gsub(target, "__apos__", "'") --convert __apos__ back to apostrophes
	target = capitalize(target) -- capitalize names
	target = string.gsub(target, "_", " ") --convert underscores to spaces

	return target

end

--Add a target to the auto_focus_target_list
local function addToAutoFocusTargetList(target)

	--If target is a table, first convert it into a useable string
	if type(target) == 'table' then
		local concatenated_target = table.concat(target, ' ')
		target = concatenated_target
	end

	auto_focus_target_list[convertToSave(target)] = true
	settings:save('all')
	
	windower.add_to_chat(8,('[Bars] '):color(220)..('Added to Auto Focus Target list: '):color(36)..(capitalize(target)):color(1))

end

--Remove a target from the auto_focus_target_list
local function removeFromAutoFocusTargetList(target)

	--If target is a table, first convert it into a useable string
	if type(target) == 'table' then
		local concatenated_target = table.concat(target, ' ')
		target = concatenated_target
	end

	local savedTarget = convertToSave(target)

	if auto_focus_target_list[savedTarget] then
		auto_focus_target_list[savedTarget] = nil
		windower.add_to_chat(8,('[Bars] '):color(220)..('Removed from Auto Focus Target list: '):color(36)..(capitalize(target)):color(1))
		settings:save('all')

	else
		windower.add_to_chat(8,('[Bars] '):color(220)..(capitalize(target)):color(1)..(' was not found.'):color(39))
		windower.add_to_chat(8,('[Bars] '):color(220)..('Type '):color(8)..('//bars list'):color(1)..(' to see stored targets.'):color(8))

	end
end

--Update the Focus Target bar
local function updateFocusTarget()

	if not focus_target then
		bars_bg_focus_target:hide()
		bars_meter_focus_target:hide()
		bars_text_shdw_focus_target:hide()
		bars_text_shdw_focus_target_action:hide()
		bars_text_focus_target:hide()
		bars_text_focus_target_action:hide()
		return
	end

	local focus_target_name = focus_target and focus_target.name or ''
	local focus_target_hpp = focus_target and focus_target.hpp or 0
	local focus_target_meter = ''
	local spaces = focus_target_hpp and math.floor((bar_width / 2) * (focus_target_hpp / 100)) or 0
	--fix for the math flooring this to 0 when its not exactly 0
	if spaces == 0 and focus_target_hpp ~= 0 then
		spaces = 1
	end
	while string.len(focus_target_meter) < spaces do
		focus_target_meter = focus_target_meter..' '
	end
	local cm = focus_target and targetColor(focus_target) or color.target.pc_other
	local ct = text_color
	focus_target_hpp = string.format("%3s", focus_target_hpp)
	local text = focus_target_hpp..'% '..focus_target_name
	local focus_target_status = show_action_status_indicators and focus_target and current_actions[focus_target.id] and current_actions[focus_target.id].status or ''
	local focus_target_status_shdw = show_action_status_indicators and focus_target and current_actions[focus_target.id] and current_actions[focus_target.id].status_shdw or ''
	local focus_target_action = focus_target and current_actions[focus_target.id] and current_actions[focus_target.id].action or ''
	local focus_target_action_shdw = focus_target and current_actions[focus_target.id] and current_actions[focus_target.id].action_shdw or ''
	local text_focus_target_action = show_target_action and ' '..focus_target_status..focus_target_action or ''
	local text_focus_target_action_shdw = show_target_action and ' '..focus_target_status_shdw..focus_target_action_shdw or ''

	if not inCS then

		--Fix the pad issue when 0
		if spaces == 0 then
			bars_meter_focus_target:hide()
		else
			bars_meter_focus_target:show()
		end

		bars_bg_focus_target:show()
		bars_text_shdw_focus_target:show()
		bars_text_shdw_focus_target_action:show()
		bars_text_focus_target:show()
		bars_text_focus_target_action:show()

	end

	bars_meter_focus_target:text(focus_target_meter)
	bars_meter_focus_target:bg_color(cm.r,cm.g,cm.b)
	bars_text_shdw_focus_target:text(text)
	bars_text_shdw_focus_target_action:text(text_focus_target_action_shdw)
	bars_text_focus_target:text(text)
	bars_text_focus_target_action:text(text_focus_target_action)
	bars_text_focus_target:color(ct.r,ct.g,ct.b)
	bars_text_focus_target_action:color(ct.r,ct.g,ct.b)

end

--Update the Target bar
local function updateTarget()

	local player = windower.ffxi.get_player()
	local target = windower.ffxi.get_mob_by_target('st', 't')
	local target_name = target and ' '..target.name or ''
	local target_index = target and show_target_index and ' ('..target.index..')' or ''
	local target_distance = target and show_target_distance and ' '..(string.format("%5.2f", math.floor(target.distance:sqrt()*100)/100)) or ''
	local target_hpp = target and target.hpp or 0
	local target_meter = ''
	local spaces = target_hpp and math.floor(bar_width * (target_hpp / 100)) or 0
	--fix for the math flooring this to 0 when its not exactly 0
	if spaces == 0 and target_hpp ~= 0 then
		spaces = 1
	end
	while string.len(target_meter) < spaces do
		target_meter = target_meter..' '
	end
	local cm = target and targetColor(target) or color.target.pc_other
	local ct = text_color
	target_hpp = string.format("%3s", target_hpp)..'%'
	local text = target_hpp..target_distance..target_name..target_index
	local target_status = show_action_status_indicators and target and current_actions[target.id] and current_actions[target.id].status or ''
	local target_status_shdw = show_action_status_indicators and target and current_actions[target.id] and current_actions[target.id].status_shdw or ''
	local target_action = target and current_actions[target.id] and current_actions[target.id].action or ''
	local target_action_shdw = target and current_actions[target.id] and current_actions[target.id].action_shdw or ''
	local target_action_result = target and current_actions[target.id] and current_actions[target.id].result or ''
	local target_action_result_shdw = target and current_actions[target.id] and current_actions[target.id].result_shdw or ''
	local text_target_action = show_target_action and ' '..target_status..target_action..target_action_result or ''
	local text_target_action_shdw = show_target_action and ' '..target_status_shdw..target_action_shdw..target_action_result_shdw or ''

	if target and not (show_self_when_target == false and target.id == player.id) then
		if not inCS then

			--Fix the pad issue when 0
			if spaces == 0 then
				bars_meter_target:hide()
			else
				bars_meter_target:show()
			end

			bars_bg_target:show()
			bars_text_shdw_target:show()
			bars_text_shdw_target_action:show()
			bars_text_target:show()
			bars_text_target_action:show()

		end

		bars_meter_target:text(target_meter)
		bars_meter_target:bg_color(cm.r,cm.g,cm.b)
		bars_text_shdw_target:text(text)
		bars_text_shdw_target_action:text(text_target_action_shdw)
		bars_text_target:text(text)
		bars_text_target_action:text(text_target_action)
		bars_text_target:color(ct.r,ct.g,ct.b)
		bars_text_target_action:color(ct.r,ct.g,ct.b)

	else

		bars_bg_target:hide()
		bars_meter_target:hide()
		bars_text_shdw_target:hide()
		bars_text_shdw_target_action:hide()
		bars_text_target:hide()
		bars_text_target_action:hide()

	end
end

--Update the Self Action text
local function updateSelfAction()

	local player = windower.ffxi.get_player()
	local ct = text_color
	local self_status = show_action_status_indicators and current_actions[player.id] and current_actions[player.id].status or ''
	local self_status_shdw = show_action_status_indicators and current_actions[player.id] and current_actions[player.id].status_shdw or ''
	local self_action = current_actions[player.id] and current_actions[player.id].action or ''
	local self_action_shdw = current_actions[player.id] and current_actions[player.id].action_shdw or ''
	local self_action_result = current_actions[player.id] and current_actions[player.id].result or ''
	local self_action_result_shdw = current_actions[player.id] and current_actions[player.id].result_shdw or ''
	local text_self_action = ' '..self_status..self_action..self_action_result
	local text_self_action_shdw = ' '..self_status_shdw..self_action_shdw..self_action_result_shdw

	if self_status ~= '' then
		if not inCS then

			bars_bg_self_action:show()
			bars_text_shdw_self_action:show()
			bars_text_self_action:show()

		end

		bars_text_shdw_self_action:text(text_self_action_shdw)
		bars_text_self_action:text(text_self_action)

	else

		bars_bg_self_action:hide()
		bars_meter_self_action:hide()
		bars_text_shdw_self_action:hide()
		bars_text_self_action:hide()

	end
end

--Complete the Self meter to full
local function completeSelfMeter()

	local self_meter = ''

	while string.len(self_meter) < bar_width do
		self_meter = self_meter..' '
	end
	bars_meter_self_action:text(self_meter)
	bars_meter_self_action:show()

end

--Update the Self bar
local function updateSelfBar(cast_time)

	local player = windower.ffxi.get_player()
	local self_meter = ''
	local spaces = 0
	local divisor = cast_time / 0.1 --Bar length gets updated every tenth of a second
	local increment = bar_width / divisor

	if cast_time == 0 then
		while string.len(self_meter) < bar_width do
			self_meter = self_meter..' '
		end
		bars_meter_self_action:text(self_meter)
		bars_meter_self_action:show()
		return
	end

	--Loop to update the bar length over time
	for i = 1, divisor do

		--Cancel if a spell has finished early
		if current_actions[player.id] and (current_actions[player.id].status == '\\cs(050,255,050)√\\cr' or current_actions[player.id].status == '\\cs(255,050,050)×\\cr') then
			break
		end

		--Make sure the meter hits exactly 100% when finished
		if i == divisor then
			spaces = bar_width
		end

		--Update the bar length
		while string.len(self_meter) < spaces do
			self_meter = self_meter..' '
		end
		bars_meter_self_action:text(self_meter)

		--Fix the pad issue when 0
		if spaces ~= 0 and current_actions[player.id] then
			bars_meter_self_action:show()
		elseif not current_actions[player.id] then
			bars_meter_self_action:hide()
		end

		--Incremement spaces for the next go round
		if i ~= divisor then
			spaces = spaces + increment
		end

		--Pause for a tenth of a second before running the loop again
		coroutine.sleep(.1)

	end

end

--Update the HP bar
local function updateHPBar()

	local player = windower.ffxi.get_player()
	local hp = player.vitals.hp
	local max_hp = player.vitals.max_hp
	local hpp = player.vitals.hpp
	local hp_meter = ''
	local spaces = math.floor(bar_width * (hpp / 100))
	--fix for the math flooring this to 0 when its not exactly 0
	if spaces == 0 and hpp ~= 0 then
		spaces = 1
	end
	local c = color.hp

	--Fix the pad issue when 0
	if spaces == 0 then
		bars_meter_hp:bg_alpha(0)
	else
		bars_meter_hp:bg_alpha(bg_alpha)
		while string.len(hp_meter) < spaces do
			hp_meter = hp_meter..' '
		end
	end

	--Add the max hp to the right-side of the bar
	local center_padding = ''
	if show_max_hp_mp_on_bar then
		local center_spaces = bar_width - string.len(tostring(hp)) - string.len(tostring(max_hp)) - 5
		while string.len(center_padding) < center_spaces do
			center_padding = center_padding..' '
		end
		max_hp = center_padding..max_hp
	else
		max_hp = ''
	end

	--Set the color for the bar based on HP percentage
	if hpp >= 75 then
		c = text_color
	elseif hpp >= 50 then
		c = color.hp.quarter_3
	elseif hpp >= 25 then
		c = color.hp.quarter_2
	elseif hpp >= 0 then
		c = color.hp.quarter_1
	end

	local r = formatRGB(c.r)
	local g = formatRGB(c.g)
	local b = formatRGB(c.b)

	local text = 'HP: \\cs('..r..','..g..','..b..')'..hp..'\\cr'..max_hp
	local text_shdw = 'HP: '..hp..max_hp

	bars_meter_hp:text(hp_meter)
	bars_text_shdw_hp:text(text_shdw)
	bars_text_hp:text(text)

end

--Update the MP bar
local function updateMPBar()

	local player = windower.ffxi.get_player()
	local mp = player.vitals.mp
	local max_mp = player.vitals.max_mp
	local mpp = player.vitals.mpp
	local mp_meter = ''
	local spaces = math.floor(bar_width * (mpp / 100))
	--fix for the math flooring this to 0 when its not exactly 0
	if spaces == 0 and mpp ~= 0 then
		spaces = 1
	end
	local c = color.mp

	--Fix the pad issue when 0
	if spaces == 0 then
		bars_meter_mp:bg_alpha(0)
	else
		bars_meter_mp:bg_alpha(bg_alpha)
		while string.len(mp_meter) < spaces do
			mp_meter = mp_meter..' '
		end
	end

	--Set the color for the bar based on MP percentage
	if mpp >= 75 then
		c = text_color
	elseif mpp >= 50 then
		c = color.mp.quarter_3
	elseif mpp >= 25 then
		c = color.mp.quarter_2
	elseif mpp >= 0 then
		c = color.mp.quarter_1
	end

	local r = formatRGB(c.r)
	local g = formatRGB(c.g)
	local b = formatRGB(c.b)

	--Add the max mp to the right-side of the bar
	local center_padding = ''
	if show_max_hp_mp_on_bar then
		local center_spaces = bar_width - string.len(tostring(mp)) - string.len(tostring(max_mp)) - 5
		while string.len(center_padding) < center_spaces do
			center_padding = center_padding..' '
		end
		max_mp = center_padding..max_mp
	else
		max_mp = ''
	end

	local text = 'MP: \\cs('..r..','..g..','..b..')'..mp..'\\cr'..max_mp
	local text_shdw = 'MP: '..mp..max_mp

	bars_meter_mp:text(mp_meter)
	bars_text_shdw_mp:text(text_shdw)
	bars_text_mp:text(text)

end

--Update the TP bar
local function updateTPBar()

	local player = windower.ffxi.get_player()
	local tp = player.vitals.tp
	local tp_meter = ''
	local spaces = 0
	spaces = math.floor(bar_width * (tp / 3000))
	--fix for the math flooring this to 0 when its not exactly 0
	if spaces == 0 and tp ~= 0 then
		spaces = 1
	end
	while string.len(tp_meter) < spaces do
		tp_meter = tp_meter..' '
	end
	local ct = text_color

	--Fix the pad issue when 0
	if spaces == 0 then
		bars_meter_tp:bg_alpha(0)

	else
		bars_meter_tp:bg_alpha(bg_alpha)

		--Set the color for the bar based on TP percentage
		local cm = color.tp.less_than_1k

		if tp == 3000 then
			cm = color.tp.full_3k
			ct = color.tp.ready_to_use
		elseif tp > 2000 then
			cm = color.tp.full_2k
			ct = color.tp.ready_to_use
		elseif tp > 1000 then
			cm = color.tp.full_1k
			ct = color.tp.ready_to_use
		end

		bars_meter_tp:bg_color(cm.r,cm.g,cm.b)

	end

	local r = formatRGB(ct.r)
	local g = formatRGB(ct.g)
	local b = formatRGB(ct.b)

	local text = 'TP: \\cs('..r..','..g..','..b..')'..tp..'\\cr'
	local text_shdw = 'TP: '..tp

	bars_text_shdw_tp:text(text_shdw)
	bars_text_tp:text(text)
	bars_meter_tp:text(tp_meter)

end

--Update the Pet bar
local function updatePetBar()

	local pet = windower.ffxi.get_mob_by_target('pet')
	local hpp = pet and pet.hpp or 0
	local status = pet and pet.status or nil
	local pet_meter = ''
	local spaces = math.floor(bar_width * (hpp / 100))
	--fix for the math flooring this to 0 when its not exactly 0
	if spaces == 0 and hpp ~= 0 then
		spaces = 1
	end
	local c = color.hp

	local pet_name = pet and 'Pet' or 'No Pet'
	if job == 'bst' then pet_name = pet and pet.name or 'No Pet' end
	if job == 'drg' then pet_name = pet and pet.name or 'No Wyvern' end
	if job == 'geo' then pet_name = pet and 'Luopan' or 'No Luopan' end
	if job == 'pup' then pet_name = pet and pet.name or 'No Automaton' end
	if job == 'smn' then pet_name = pet and pet.name or 'No Avatar' end

	--Fix the pad issue when 0
	if spaces == 0 then
		bars_meter_pet:bg_alpha(0)
	else
		bars_meter_pet:bg_alpha(bg_alpha)
		while string.len(pet_meter) < spaces do
			pet_meter = pet_meter..' '
		end
	end

	--Set the color for the HPP based on hp percentage
	if hpp >= 75 then
		c_hpp = text_color
	elseif hpp >= 50 then
		c_hpp = color.hp.quarter_3
	elseif hpp >= 25 then
		c_hpp = color.hp.quarter_2
	elseif hpp >= 0 then
		c_hpp = color.hp.quarter_1
	end
	local c_hpp_r = formatRGB(c_hpp.r)
	local c_hpp_g = formatRGB(c_hpp.g)
	local c_hpp_b = formatRGB(c_hpp.b)

	--If SMN, set the color of the bar based on the summon element
	local c_bar = color.pet.bar
	if pet and (pet.name == "Carbuncle" or pet.name == "Cait Sith" or pet.name == "Alexander" or pet.name == "LightSpirit") then
		c_bar = color.elements.light
	elseif pet and (pet.name == "Ifrit" or pet.name == "FireSpirit") then
		c_bar = color.elements.fire
	elseif pet and (pet.name == "Shiva" or pet.name == "IceSpirit") then
		c_bar = color.elements.ice
	elseif pet and (pet.name == "Garuda" or pet.name == "Siren" or pet.name == "AirSpirit") then
		c_bar = color.elements.wind
	elseif pet and (pet.name == "Titan" or pet.name == "EarthSpirit") then
		c_bar = color.elements.earth
	elseif pet and (pet.name == "Ramuh" or pet.name == "ThunderSpirit") then
		c_bar = color.elements.lightning
	elseif pet and (pet.name == "Leviathan" or pet.name == "WaterSpirit")  then
		c_bar = color.elements.water
	elseif pet and (pet.name == "Fenrir" or pet.name == "Diabolos" or pet.name == "Atomos" or pet.name == "Odin" or pet.name == "DarkSpirit") then
		c_bar = color.elements.dark
	end
	local c_bar_r = formatRGB(c_bar.r)
	local c_bar_g = formatRGB(c_bar.g)
	local c_bar_b = formatRGB(c_bar.b)

	local text = pet_name..(pet and ': \\cs('..c_hpp_r..','..c_hpp_g..','..c_hpp_b..')'..hpp..'%\\cr' or '')..(pet and status and ' ('..res.statuses[status].en..')' or '')
	local text_shdw = pet_name..(pet and ': \\cs(000,000,000)'..hpp..'%\\cr' or '')..(pet and status and ' ('..res.statuses[status].en..')' or '')

	bars_meter_pet:text(pet_meter)
	bars_text_shdw_pet:text(text_shdw)
	bars_text_pet:text(text)
	bars_meter_pet:bg_color(c_bar_r,c_bar_g,c_bar_b)

end

--List the contents of the Auto Focus Target list
local function listAutoFocusTargets()
	local sortedTargets = {}

	windower.add_to_chat(8,('[Bars] '):color(220)..('Auto Focus Targets: '):color(8))

	--Copy targets and sort them alphabetically
	for target in pairs(auto_focus_target_list) do
		table.insert(sortedTargets, target)
	end
	table.sort(sortedTargets)

	--Check if sortedTargets is empty
	if next(sortedTargets) == nil then
		windower.add_to_chat(8,' - '..('[Empty]'):color(1))
	end

	--Add sorted targets to chat
	for _, target in ipairs(sortedTargets) do
		windower.add_to_chat(8,' - '..(convertToDisplay(target)):color(1))
	end

end

-- Check for matching focus targets
local function checkForFocusTarget()

	local target = windower.ffxi.get_mob_by_target('t') or nil
	local nearby = nil

	--Loop through all the mobs in memory (nearby)
	for i,v in pairs(windower.ffxi.get_mob_array()) do

		local distance = math.floor(v.distance:sqrt() * 100) / 100

		--Does an id nearby match an entry in our auto focus target list?
		if auto_focus_target_list[convertToSave(v.id)] and v.valid_target and distance <= tonumber(focus_target_max_distance) then

			nearby = windower.ffxi.get_mob_by_id(v.id)

			if hide_focus_target_when_target and target and nearby and target.id == nearby.id then
				nearby = nil
			end

		--Does a name nearby match an entry in our auto focus target list?
		elseif auto_focus_target_list[convertToSave(v.name)] and v.valid_target and distance <= tonumber(focus_target_max_distance) then

			nearby = windower.ffxi.get_mob_by_name(v.name)

			if hide_focus_target_when_target and target and nearby and target.id == nearby.id then
				nearby = nil
			end

		end
	end

	--Update focus_target if its new, will remove/nil if nothing in the auto_focus_target_list
	if focus_target ~= nearby then
		focus_target = nearby
	end

	updateFocusTarget()

end

--Job Changing
windower.register_event('job change', function()
	hideBars()
	setJob()
	setPosition()
	showBars()
end)

--Target Changing
windower.register_event('target change', function()
	updateTarget()
end)

--HP Changing
windower.register_event('hp change', function()
	updateHPBar()
end)
windower.register_event('hpp change', function()
	updateHPBar()
end)
windower.register_event('hpmax change', function()
	updateHPBar()
end)

--MP Changing
windower.register_event('mp change', function()
	updateMPBar()
end)
windower.register_event('mpp change', function()
	updateMPBar()
end)
windower.register_event('mpmax change', function()
	updateMPBar()
end)

--TP Changing
windower.register_event('tp change', function()
	updateTPBar()
end)

--Run necessarry functions at start
local function initialize()
	setJob()
	setWidth()
	setBold()
	setSize()
	setPosition()
	showBars()
	updateTarget()
	updateHPBar()
	updateMPBar()
	updateTPBar()
	--Wait a sec then repeat since values are 0 when first logging into a character
	coroutine.sleep(1)
	updateHPBar()
	updateMPBar()
	updateTPBar()
end

--Load
windower.register_event('load', function()
	if windower.ffxi.get_info().logged_in then
		initialize()
	end
end)

--Login
windower.register_event('login', function()
	initialize()
end)

windower.register_event('status change', function(status)

	--In a cutscene: Hide the bars
	if status == 4 and not inCS then
		inCS = true
		hideBars()

		--Out of cutscene: Show the bars
	elseif status ~= 4 and inCS then
		inCS = false
		showBars()

	end
end)

windower.register_event('prerender', function()

	if windower.ffxi.get_info().logged_in and show_self_action then
		updateSelfAction()
	end

	local target = windower.ffxi.get_mob_by_target('st', 't')
	if target then
		updateTarget()
	end

	checkForFocusTarget()

	if windower.ffxi.get_info().logged_in and show_bars[job].pet then
		updatePetBar()
	end

	--Hide while zoning
	local pos = windower.ffxi.get_position()
	if pos == "(?-?)" and not zoning then
		zoning = true
		hideBars()
		clearActionsTable() --flush the current_actions table to keep it clean just in case
	elseif pos ~= "(?-?)" and zoning then
		zoning = false
		showBars()
	end

end)

windower.register_event('action', function (act)

	local player = windower.ffxi.get_player()
	local actor = windower.ffxi.get_mob_by_id(act.actor_id)
	local action_id = act.targets[1].actions[1].param
	local action_target = windower.ffxi.get_mob_by_id(act.targets[1].id)
	local action_target_id = action_target and action_target.id or nil
	local action_name = ''
	local action_name_shdw = ''
	local action_target_name = ''
	local action_target_name_shdw = ''
	local target_action_result = ''
	local target_action_result_shdw = ''
	local cast_time = 0

	if not actor then
		return
	end

	--Action failed/interrupted
	if act.param == 28787 then

		local trackingIndex = assignIndex()

		local target_action_status = '\\cs(255,050,050)×\\cr'
		local target_action_status_shdw = '\\cs(000,000,000)×\\cr'

		updateActionTable(act.actor_id,target_action_status,target_action_status_shdw,target_action_result,target_action_result_shdw,trackingIndex)

		if player.id == act.actor_id then
			bars_meter_self_action:bg_color(255,050,050)
			completeSelfMeter()
		end

		coroutine.sleep(clear_action_delay)
		removeFromActionsTable(act.actor_id,trackingIndex)

		return

	end

	--Begin weapon skill(7), TP move(7), or spell(8), or item(9)
	if action_id and (act.category == 7 or act.category == 8 or act.category == 9) then

		local target_action = ''
		local target_action_shdw = ''
		local target_action_status = '\\cs(245,164,066)≈\\cr'
		local target_action_status_shdw = '\\cs(000,000,000)≈\\cr'

		--Weapon skill or TP move
		if act.category == 7 then

			local ct = targetColor(action_target)
			local r = formatRGB(ct.r)
			local g = formatRGB(ct.g)
			local b = formatRGB(ct.b)

			action_target_name = (action_target_id and action_target_id ~= act.actor_id) and ' → \\cs('..r..','..g..','..b..')'..truncateName(action_target.name)..'\\cr' or ''
			action_target_name_shdw = (action_target_id and action_target_id ~= act.actor_id) and ' → \\cs(000,000,000)'..truncateName(action_target.name)..'\\cr' or ''

			if actor then

				local tc = text_color
				local r = formatRGB(tc.r)
				local g = formatRGB(tc.g)
				local b = formatRGB(tc.b)

				--Players
				if isPlayer(actor.id) then
					action_name = res.weapon_skills[action_id] and ' \\cs('..r..','..g..','..b..')'..truncateAction(res.weapon_skills[action_id].name) or ' \\cs('..r..','..g..','..b..')[REDACTED]'..'\\cr'
					action_name_shdw = res.weapon_skills[action_id] and ' \\cs(000,000,000)'..truncateAction(res.weapon_skills[action_id].name)..'\\cr' or ' \\cs(000,000,000)[REDACTED]\\cr'

				--Certain NMs regular melee attacks are actually TP moves
				elseif act.targets[1].actions[1].param == nil then
					return

				--Pets (& Synergy Furnaces)
				elseif windower.ffxi.get_mob_by_id(actor.id) and windower.ffxi.get_mob_by_id(actor.id).spawn_type == 2 then
					action_name = res.job_abilities[action_id] and ' \\cs('..r..','..g..','..b..')'..truncateAction(res.job_abilities[action_id].name)..'\\cr' or ' \\cs('..r..','..g..','..b..')'..truncateAction(res.monster_abilities[action_id].name)..'\\cr'
					action_name_shdw = res.job_abilities[action_id] and ' \\cs(000,000,000)'..truncateAction(res.job_abilities[action_id].name)..'\\cr' or ' \\cs(000,000,000)'..truncateAction(res.monster_abilities[action_id].name)..'\\cr'

				--Monsters (some use player WSs)
				else
					action_name = res.monster_abilities[action_id] and ' \\cs('..r..','..g..','..b..')'..truncateAction(res.monster_abilities[action_id].name)..'\\cr' or ' \\cs('..r..','..g..','..b..')'..truncateAction(res.weapon_skills[action_id].name)..'\\cr'
					action_name_shdw = res.monster_abilities[action_id] and ' \\cs(000,000,000)'..truncateAction(res.monster_abilities[action_id].name)..'\\cr' or ' \\cs(000,000,000)'..truncateAction(res.weapon_skills[action_id].name)..'\\cr'

				end
			end

		--Spell
		elseif act.category == 8 then

			local element = res.spells[action_id].element
			local ca = element_colors[element]
			local ct = targetColor(action_target)
			local ca_r = formatRGB(ca.r)
			local ca_g = formatRGB(ca.g)
			local ca_b = formatRGB(ca.b)
			local ct_r = formatRGB(ct.r)
			local ct_g = formatRGB(ct.g)
			local ct_b = formatRGB(ct.b)

			action_name = ' \\cs('..ca_r..','..ca_g..','..ca_b..')'..truncateAction(res.spells[action_id].name)..'\\cr'
			action_name_shdw = ' \\cs(000,000,000)'..truncateAction(res.spells[action_id].name)..'\\cr'
			action_target_name = action_target_id and ' → \\cs('..ct_r..','..ct_g..','..ct_b..')'..truncateName(action_target.name)..'\\cr' or ''
			action_target_name_shdw = action_target_id and ' → \\cs(000,000,000)'..truncateName(action_target.name)..'\\cr' or ''
			cast_time = res.spells[action_id].cast_time

		--Item
		elseif act.category == 9 then

			local item_id = act.targets[1].actions[1].param
			local item_name = res.items[item_id].name
			local tc = text_color
			local tc_r = formatRGB(tc.r)
			local tc_g = formatRGB(tc.g)
			local tc_b = formatRGB(tc.b)
			local ct = targetColor(action_target)
			local r = formatRGB(ct.r)
			local g = formatRGB(ct.g)
			local b = formatRGB(ct.b)

			action_name = ' \\cs('..tc_r..','..tc_g..','..tc_b..')'..truncateAction(item_name)..'\\cr'
			action_name_shdw = ' \\cs(000,000,000)'..truncateAction(item_name)..'\\cr'
			action_target_name = action_target_id and ' → \\cs('..r..','..g..','..b..')'..truncateName(windower.ffxi.get_mob_by_id(action_target_id).name)..'\\cr' or ''
			action_target_name_shdw = action_target_id and ' → \\cs(000,000,000)'..truncateName(windower.ffxi.get_mob_by_id(action_target_id).name)..'\\cr' or ''
			cast_time = res.items[item_id].cast_time

		end

		target_action = action_name..action_target_name
		target_action_shdw = action_name_shdw..action_target_name_shdw

		if (show_self_action and player.id == act.actor_id) or show_target_action then

			local trackingIndex = assignIndex()

			addToActionsTable(act.actor_id,target_action,target_action_shdw,target_action_status,target_action_status_shdw,target_action_result,target_action_result_shdw,trackingIndex)

			if player.id == act.actor_id then
				bars_meter_self_action:bg_color(color.self.bar.r,color.self.bar.g,color.self.bar.b)
				updateSelfBar(cast_time)
			end

			--In case of lag and we don't receive the "finished" action, we remove the action after a long enough wait to be sure
			coroutine.sleep(cast_time+clear_action_delay+5)
			removeFromActionsTable(act.actor_id,trackingIndex)

		end

	--Job abilities or Monster tp moves(11)
	elseif (act.category == 3 and act.targets[1].actions[1].message == 110) or act.category == 6 or act.category == 14 or act.category == 15 or (act.category == 11 and not act.targets[1].actions[1].message == 1 --[[and act.targets[1].actions[1].message == 101]]) then

		local target_action = ''
		local target_action_shdw = ''
		local target_action_status = '\\cs(050,255,050)√\\cr'
		local target_action_status_shdw = '\\cs(000,000,000)√\\cr'

		local abil_id = act.param

		local abil_name = ''
		if act.category == 11 or (act.category == 6 and actor.spawn_type == 16) then
		 	abil_name = res.monster_abilities[abil_id] and res.monster_abilities[abil_id].name or '[REDACTED]'
		else
			abil_name = res.job_abilities[abil_id] and res.job_abilities[abil_id].name or '[REDACTED]'
		end

		local tc = text_color
		local tc_r = formatRGB(tc.r)
		local tc_g = formatRGB(tc.g)
		local tc_b = formatRGB(tc.b)
		local ct = targetColor(action_target)
		local r = formatRGB(ct.r)
		local g = formatRGB(ct.g)
		local b = formatRGB(ct.b)

		action_name = ' \\cs('..tc_r..','..tc_g..','..tc_b..')'..truncateAction(abil_name)..'\\cr'
		action_name_shdw = ' \\cs(000,000,000)'..truncateAction(abil_name)..'\\cr'
		action_target_name = action_target_id and ' → \\cs('..r..','..g..','..b..')'..truncateName(windower.ffxi.get_mob_by_id(action_target_id).name)..'\\cr' or ''
		action_target_name_shdw = action_target_id and ' → \\cs(000,000,000)'..truncateName(windower.ffxi.get_mob_by_id(action_target_id).name)..'\\cr' or ''

		--Lunge/Swipes
		if act.category == 15 and act.targets[1].actions[1].message == 110 then
			target_action_result = ' ('..addCommas(act.targets[1].actions[1].param)..(act.targets[1].actions[1].unknown == 4 and ' Magic Burst!)' or ')')
			target_action_result_shdw = ' ('..addCommas(act.targets[1].actions[1].param)..(act.targets[1].actions[1].unknown == 4 and ' Magic Burst!)' or ')')
		--Certain direct damage abilities
		elseif act.category == 3 then
			target_action_result = ' ('..addCommas(act.targets[1].actions[1].param)..')'
			target_action_result_shdw = ' ('..addCommas(act.targets[1].actions[1].param)..')'
		--Most job abilities
		elseif act.category == 6 then
			if act.targets[1].actions[1].message == 101 then
				target_action_result = ' ('..res.buffs[act.targets[1].actions[1].param].name..')'
				target_action_result_shdw = ' ('..res.buffs[act.targets[1].actions[1].param].name..')'
			elseif act.targets[1].actions[1].message == 103 then
				target_action_result = ' ('..addCommas(act.targets[1].actions[1].param)..' HP)'
				target_action_result_shdw = ' ('..addCommas(act.targets[1].actions[1].param)..' HP)'
			elseif act.targets[1].actions[1].message == 110 then
				target_action_result = ' ('..addCommas(act.targets[1].actions[1].param)..')'
				target_action_result_shdw = ' ('..addCommas(act.targets[1].actions[1].param)..')'
			elseif act.targets[1].actions[1].message == 420 or act.targets[1].actions[1].message == 424 then
				local rolls = {
					[98] = {lucky = '5', unlucky = '9'},	-- Fighter's Roll
					[99] = {lucky = '3', unlucky = '7'},	-- Monk's Roll
					[100] = {lucky = '3', unlucky = '7'},	-- Healer's Roll
					[101] = {lucky = '5', unlucky = '9'},	-- Wizard's Roll
					[102] = {lucky = '4', unlucky = '8'},	-- Warlock's Roll
					[103] = {lucky = '5', unlucky = '9'},	-- Rogue's Roll
					[104] = {lucky = '3', unlucky = '7'},	-- Gallant's Roll
					[105] = {lucky = '4', unlucky = '8'},	-- Chaos Roll
					[106] = {lucky = '4', unlucky = '8'},	-- Beast Roll
					[107] = {lucky = '2', unlucky = '6'},	-- Choral Roll
					[108] = {lucky = '4', unlucky = '8'},	-- Hunter's Roll
					[109] = {lucky = '2', unlucky = '6'},	-- Samurai Roll
					[110] = {lucky = '4', unlucky = '8'},	-- Ninja Roll
					[111] = {lucky = '4', unlucky = '8'},	-- Drachen Roll
					[112] = {lucky = '5', unlucky = '9'},	-- Evoker's Roll
					[113] = {lucky = '2', unlucky = '6'},	-- Magus's Roll
					[114] = {lucky = '5', unlucky = '9'},	-- Corsair's Roll
					[115] = {lucky = '3', unlucky = '7'},	-- Puppet Roll
					[116] = {lucky = '3', unlucky = '7'},	-- Dancer's Roll
					[117] = {lucky = '2', unlucky = '6'},	-- Scholar's Roll
					[118] = {lucky = '3', unlucky = '9'},	-- Bolter's Roll
					[119] = {lucky = '2', unlucky = '7'},	-- Caster's Roll
					[120] = {lucky = '3', unlucky = '9'},	-- Courser's Roll
					[121] = {lucky = '4', unlucky = '9'},	-- Blitzer's Roll
					[122] = {lucky = '5', unlucky = '8'},	-- Tactician's Roll
					[302] = {lucky = '3', unlucky = '10'},	-- Allies' Roll
					[303] = {lucky = '5', unlucky = '7'},	-- Miser's Roll
					[304] = {lucky = '2', unlucky = '10'},	-- Companion's Roll
					[305] = {lucky = '4', unlucky = '8'},	-- Avenger's Roll
					[390] = {lucky = '3', unlucky = '7'},	-- Naturalit's Roll
					[391] = {lucky = '4', unlucky = '8'},	-- Runeist's Roll
				}
				local r_id = act.param --roll id
				local r_tot = act.targets[1].actions[1].param--roll total
				local c = text_color

				if show_fancy_rolls then

					local r_1 = (r_tot == 1 and '[' or ' ')..'1'..(r_tot == 1 and ']' or (r_tot == 2 and '' or ' '))
					local r_2 = (r_tot == 2 and '[' or '')..'2'..(r_tot == 2 and ']' or (r_tot == 3 and '' or ' '))
					local r_3 = (r_tot == 3 and '[' or '')..'3'..(r_tot == 3 and ']' or (r_tot == 4 and '' or ' '))
					local r_4 = (r_tot == 4 and '[' or '')..'4'..(r_tot == 4 and ']' or (r_tot == 5 and '' or ' '))
					local r_5 = (r_tot == 5 and '[' or '')..'5'..(r_tot == 5 and ']' or (r_tot == 6 and '' or ' '))
					local r_6 = (r_tot == 6 and '[' or '')..'6'..(r_tot == 6 and ']' or (r_tot == 7 and '' or ' '))
					local r_7 = (r_tot == 7 and '[' or '')..'7'..(r_tot == 7 and ']' or (r_tot == 8 and '' or ' '))
					local r_8 = (r_tot == 8 and '[' or '')..'8'..(r_tot == 8 and ']' or (r_tot == 9 and '' or ' '))
					local r_9 = (r_tot == 9 and '[' or '')..'9'..(r_tot == 9 and ']' or (r_tot == 10 and '' or ' '))
					local r_10 = (r_tot == 10 and '[' or '')..'10'..(r_tot == 10 and ']' or (r_tot == 11 and '' or ' '))
					local r_11 = (r_tot == 11 and '[' or '')..'11'..(r_tot == 11 and ']' or ' ')

					local r_c1 = text_color
					local r_c2 = (rolls[r_id].lucky == '2' and color.rolls.lucky or (rolls[r_id].unlucky == '2' and color.rolls.unlucky or text_color))
					local r_c3 = (rolls[r_id].lucky == '3' and color.rolls.lucky or (rolls[r_id].unlucky == '3' and color.rolls.unlucky or text_color))
					local r_c4 = (rolls[r_id].lucky == '4' and color.rolls.lucky or (rolls[r_id].unlucky == '4' and color.rolls.unlucky or text_color))
					local r_c5 = (rolls[r_id].lucky == '5' and color.rolls.lucky or (rolls[r_id].unlucky == '5' and color.rolls.unlucky or text_color))
					local r_c6 = (rolls[r_id].lucky == '6' and color.rolls.lucky or (rolls[r_id].unlucky == '6' and color.rolls.unlucky or text_color))
					local r_c7 = (rolls[r_id].lucky == '7' and color.rolls.lucky or (rolls[r_id].unlucky == '7' and color.rolls.unlucky or text_color))
					local r_c8 = (rolls[r_id].lucky == '8' and color.rolls.lucky or (rolls[r_id].unlucky == '8' and color.rolls.unlucky or text_color))
					local r_c9 = (rolls[r_id].lucky == '9' and color.rolls.lucky or (rolls[r_id].unlucky == '9' and color.rolls.unlucky or text_color))
					local r_c10 = (rolls[r_id].lucky == '10' and color.rolls.lucky or (rolls[r_id].unlucky == '10' and color.rolls.unlucky or text_color))
					local r_c11 = color.rolls.eleven

					local r_1_t = '\\cs('..formatRGB(r_c1.r)..','..formatRGB(r_c1.g)..','..formatRGB(r_c1.b)..')'..r_1..'\\cr'
					local r_1_t_shdw = '\\cs(000,000,000)'..r_1..'\\cr'
					local r_2_t = '\\cs('..formatRGB(r_c2.r)..','..formatRGB(r_c2.g)..','..formatRGB(r_c2.b)..')'..r_2..'\\cr'
					local r_2_t_shdw = '\\cs(000,000,000)'..r_2..'\\cr'
					local r_3_t = '\\cs('..formatRGB(r_c3.r)..','..formatRGB(r_c3.g)..','..formatRGB(r_c3.b)..')'..r_3..'\\cr'
					local r_3_t_shdw = '\\cs(000,000,000)'..r_3..'\\cr'
					local r_4_t = '\\cs('..formatRGB(r_c4.r)..','..formatRGB(r_c4.g)..','..formatRGB(r_c4.b)..')'..r_4..'\\cr'
					local r_4_t_shdw = '\\cs(000,000,000)'..r_4..'\\cr'
					local r_5_t = '\\cs('..formatRGB(r_c5.r)..','..formatRGB(r_c5.g)..','..formatRGB(r_c5.b)..')'..r_5..'\\cr'
					local r_5_t_shdw = '\\cs(000,000,000)'..r_5..'\\cr'
					local r_6_t = '\\cs('..formatRGB(r_c6.r)..','..formatRGB(r_c6.g)..','..formatRGB(r_c6.b)..')'..r_6..'\\cr'
					local r_6_t_shdw = '\\cs(000,000,000)'..r_6..'\\cr'
					local r_7_t = '\\cs('..formatRGB(r_c7.r)..','..formatRGB(r_c7.g)..','..formatRGB(r_c7.b)..')'..r_7..'\\cr'
					local r_7_t_shdw = '\\cs(000,000,000)'..r_7..'\\cr'
					local r_8_t = '\\cs('..formatRGB(r_c8.r)..','..formatRGB(r_c8.g)..','..formatRGB(r_c8.b)..')'..r_8..'\\cr'
					local r_8_t_shdw = '\\cs(000,000,000)'..r_8..'\\cr'
					local r_9_t = '\\cs('..formatRGB(r_c9.r)..','..formatRGB(r_c9.g)..','..formatRGB(r_c9.b)..')'..r_9..'\\cr'
					local r_9_t_shdw = '\\cs(000,000,000)'..r_9..'\\cr'
					local r_10_t =  '\\cs('..formatRGB(r_c10.r)..','..formatRGB(r_c10.g)..','..formatRGB(r_c10.b)..')'..r_10..'\\cr'
					local r_10_t_shdw = '\\cs(000,000,000)'..r_10..'\\cr'
					local r_11_t = '\\cs('..formatRGB(r_c11.r)..','..formatRGB(r_c11.g)..','..formatRGB(r_c11.b)..')'..r_11..'\\cr'
					local r_11_t_shdw = '\\cs(000,000,000)'..r_11..'\\cr'

					target_action_result = ' ('..r_1_t..r_2_t..r_3_t..r_4_t..r_5_t..r_6_t..r_7_t..r_8_t..r_9_t..r_10_t..r_11_t..')'
					target_action_result_shdw = ' ('..r_1_t_shdw..r_2_t_shdw..r_3_t_shdw..r_4_t_shdw..r_5_t_shdw..r_6_t_shdw..r_7_t_shdw..r_8_t_shdw..r_9_t_shdw..r_10_t_shdw..r_11_t_shdw..')'
				else

					if r_tot == tonumber(rolls[r_id].lucky) then
						c = color.rolls.lucky
					elseif r_tot == tonumber(rolls[r_id].unlucky) then
						c = color.rolls.unlucky
					elseif r_tot == 11 then
						c = color.rolls.eleven
					end

					local r = formatRGB(c.r)
					local g = formatRGB(c.g)
					local b = formatRGB(c.b)

					target_action_result = ' \\cs('..r..','..g..','..b..')(L:'..rolls[r_id].lucky..' U:'..rolls[r_id].unlucky..' Total:'..r_tot..(r_tot == rolls[r_id].lucky and '!' or (r_tot == 11 and '!!' or ''))..')\\cr'
					target_action_result_shdw = ' \\cs(000,000,000)(L:'..rolls[r_id].lucky..' U:'..rolls[r_id].unlucky..' Total:'..r_tot..(r_tot == rolls[r_id].lucky and '!' or (r_tot == 11 and '!!' or ''))..')\\cr'
				end

			elseif act.targets[1].actions[1].message == 426 then
				target_action_result = ' (Bust!)'
				target_action_result_shdw = ' (Bust!)'
			elseif act.targets[1].actions[1].message == 451 then
				target_action_result = ' ('..addCommas(act.targets[1].actions[1].param)..' MP)'
				target_action_result_shdw = ' ('..addCommas(act.targets[1].actions[1].param)..' MP)'
			elseif act.targets[1].actions[1].message == 452 then
				target_action_result = ' ('..addCommas(act.targets[1].actions[1].param)..' TP)'
				target_action_result_shdw = ' ('..addCommas(act.targets[1].actions[1].param)..' TP)'
			end
		elseif act.category == 14 then
			if act.targets[1].actions[1].message == 519 or act.targets[1].actions[1].message == 520 or act.targets[1].actions[1].message == 521 then
				target_action_result = ' ('..res.job_abilities[abil_id].name..' Lv.'..addCommas(act.targets[1].actions[1].param)..')'
				target_action_result_shdw = ' ('..res.job_abilities[abil_id].name..' Lv.'..addCommas(act.targets[1].actions[1].param)..')'
			elseif act.targets[1].actions[1].message == 522 then
				target_action_result = ' (Stunned)'
				target_action_result_shdw = ' (Stunned)'
			end
		end

		target_action = action_name..action_target_name
		target_action_shdw = action_name_shdw..action_target_name_shdw

		if (show_self_action and player.id == act.actor_id) or show_target_action then

			--Don't assign a new index since category 11 is the completion of category 7 (which was already given an index above)
			local trackingIndex = 0
			if act.category ~= 11 then
				trackingIndex = assignIndex()
			end

			addToActionsTable(act.actor_id,target_action,target_action_shdw,target_action_status,target_action_status_shdw,target_action_result,target_action_result_shdw,trackingIndex)

			if player.id == act.actor_id then
				bars_meter_self_action:bg_color(050,255,050)
				completeSelfMeter()
			end

			coroutine.sleep(clear_action_delay)
			removeFromActionsTable(act.actor_id,trackingIndex)

		end

	--Finish weapon skill(3), spell(4), item(5), Monster TP move(11), or Pet TP move(13)
	elseif act.category == 3 or act.category == 4 or act.category == 5 or act.category == 11 or act.category == 13 then

		local trackingIndex = assignIndex()

		local target_action_status = '\\cs(050,255,050)√\\cr'
		local target_action_status_shdw = '\\cs(000,000,000)√\\cr'

		local sc = {}
		if short_skillchain_names then
			sc = {} sc[1] = 'Lght' sc[2] = 'Drkn' sc[3] = 'Grvt' sc[4] = 'Frgm' sc[5] = 'Dstn' sc[6] = 'Fusn' sc[7] = 'Cmpr' sc[8] = 'Lqfn' sc[9] = 'Indr' sc[10] = 'Rvrb' sc[11] = 'Trns' sc[12] = 'Scsn' sc[13] = 'Detn' sc[14] = 'Impc' sc[15] = 'Rdnc' sc[16] = 'Umbr'
		else
			sc = {} sc[1] = 'Light' sc[2] = 'Darkness' sc[3] = 'Gravitation' sc[4] = 'Fragmentation' sc[5] = 'Distortion' sc[6] = 'Fusion' sc[7] = 'Compression' sc[8] = 'Liquifaction' sc[9] = 'Induration' sc[10] = 'Reverberation' sc[11] = 'Transfixion' sc[12] = 'Scission' sc[13] = 'Detonation' sc[14] = 'Impaction' sc[15] = 'Radiance' sc[16] = 'Umbra'
		end

		--Weapon Skills
		if act.category == 3 then
			--Misses
			if act.targets[1].actions[1].message == 188 then
				target_action_result = ' (Missed)'
				target_action_result_shdw = ' (Missed)'
			--Blinked
			elseif act.targets[1].actions[1].message == 31 then
				target_action_result = ' (Blinked)'
				target_action_result_shdw = ' (Blinked)'
			--Creates a Skillchain
			elseif act.targets[1].actions[1].message == 185 and act.targets[1].actions[1].has_add_effect == true then
				target_action_result = ' ('..addCommas(act.targets[1].actions[1].param)..' + '..addCommas(act.targets[1].actions[1].add_effect_param)..' '..sc[act.targets[1].actions[1].add_effect_animation]..')'
				target_action_result_shdw =  ' ('..addCommas(act.targets[1].actions[1].param)..' + '..addCommas(act.targets[1].actions[1].add_effect_param)..' '..sc[act.targets[1].actions[1].add_effect_animation]..')'
			--Plain Damage
			elseif act.targets[1].actions[1].message == 185 then
				target_action_result = ' ('..addCommas(act.targets[1].actions[1].param)..')'
				target_action_result_shdw = ' ('..addCommas(act.targets[1].actions[1].param)..')'
			end

		--Spells
		elseif act.category == 4 then
			--Plain damage
			if act.targets[1].actions[1].message == 2 then
				target_action_result = ' ('..addCommas(act.targets[1].actions[1].param)..')'
				target_action_result_shdw = ' ('..addCommas(act.targets[1].actions[1].param)..')'
			--Cures
			elseif act.targets[1].actions[1].message == 7 then
				target_action_result = ' ('..addCommas(act.targets[1].actions[1].param)..')'
				target_action_result_shdw = ' ('..addCommas(act.targets[1].actions[1].param)..')'
			--Magic Bursts
			elseif act.targets[1].actions[1].message == 252 then
				target_action_result = ' ('..addCommas(act.targets[1].actions[1].param)..' Magic Burst!)'
				target_action_result_shdw = ' ('..addCommas(act.targets[1].actions[1].param)..' Magic Burst!)'
			--Drain
			elseif act.targets[1].actions[1].message == 227 or act.targets[1].actions[1].message == 274 then
				target_action_result = ' ('..addCommas(act.targets[1].actions[1].param)..' HP)'
				target_action_result_shdw = ' ('..addCommas(act.targets[1].actions[1].param)..' HP)'
			--Aspir
			elseif act.targets[1].actions[1].message == 228 or act.targets[1].actions[1].message == 275 then
				target_action_result = ' ('..addCommas(act.targets[1].actions[1].param)..' MP)'
				target_action_result_shdw = ' ('..addCommas(act.targets[1].actions[1].param)..' MP)'
			--Absorb-TP
			elseif act.targets[1].actions[1].message == 454 then
				target_action_result = ' ('..addCommas(act.targets[1].actions[1].param)..' TP)'
				target_action_result_shdw = ' ('..addCommas(act.targets[1].actions[1].param)..' TP)'
			--Buffs/Debuffs
			elseif act.targets[1].actions[1].message == 230 or act.targets[1].actions[1].message == 236 or act.targets[1].actions[1].message == 237 or act.targets[1].actions[1].message == 271 then -- 271 = magic burst debuff
				target_action_result = ' ('..res.buffs[act.targets[1].actions[1].param].name..')'
				target_action_result_shdw = ' ('..res.buffs[act.targets[1].actions[1].param].name..')'
			--No effect
			elseif act.targets[1].actions[1].message == 75 then
				target_action_result = ' (No effect)'
				target_action_result_shdw = ' (No effect)'
			--Resist
			elseif act.targets[1].actions[1].message == 85 then
				target_action_result = ' (Resist)'
				target_action_result_shdw = ' (Resist)'
			--Complete Resist
			elseif act.targets[1].actions[1].message == 655 then
				target_action_result = ' (Complete Resist)'
				target_action_result_shdw = ' (Complete Resist)'
			--Immunobreak
			elseif act.targets[1].actions[1].message == 653 then
				target_action_result = ' (Immunobreak)'
				target_action_result_shdw = ' (Immunobreak)'
			--Dispel
			elseif act.targets[1].actions[1].message == 341 or act.targets[1].actions[1].message == 342 then
				target_action_result = ' ('..res.buffs[act.targets[1].actions[1].param].name..')'
				target_action_result_shdw = ' ('..res.buffs[act.targets[1].actions[1].param].name..')'
			end

		--Monsters
		elseif act.category == 11 then
			if act.targets[1].actions[1].message == 186 or act.targets[1].actions[1].message == 194 or act.targets[1].actions[1].message == 243 then
				target_action_result = ' ('..res.buffs[act.targets[1].actions[1].param].name..')'
				target_action_result_shdw = ' ('..res.buffs[act.targets[1].actions[1].param].name..')'
			elseif act.targets[1].actions[1].message == 185 then
				target_action_result = ' ('..addCommas(act.targets[1].actions[1].param)..')'
				target_action_result_shdw = ' ('..addCommas(act.targets[1].actions[1].param)..')'
			elseif act.targets[1].actions[1].message == 187 then
				target_action_result = ' ('..addCommas(act.targets[1].actions[1].param)..' HP)'
				target_action_result_shdw = ' ('..addCommas(act.targets[1].actions[1].param)..' HP)'
			elseif act.targets[1].actions[1].message == 188 then
				target_action_result = ' (Miss)'
				target_action_result_shdw = ' (Miss)'
			end

		--Pets
		elseif act.category == 13 then
			--If the pet is ours, switch the act.actor id to match the players so it shows up in the self bar
			-- if windower.ffxi.get_mob_by_id(act.actor_id).index == windower.ffxi.get_mob_by_id(player.id).pet_index then
			-- 	act.actor_id = player.id
			-- end
			--Missed
			if act.targets[1].actions[1].message == 324 then
				target_action_result = ' (Missed)'
				target_action_result_shdw = ' (Missed)'
			--Blinked
			elseif act.targets[1].actions[1].message == 31 then
				target_action_result = ' (Blinked)'
				target_action_result_shdw = ' (Blinked)'
			--Creates a Skillchain
			elseif act.targets[1].actions[1].has_add_effect then
				target_action_result = ' ('..addCommas(act.targets[1].actions[1].param)..' + '..addCommas(act.targets[1].actions[1].add_effect_param)..' '..sc[act.targets[1].actions[1].add_effect_animation]..')'
				target_action_result_shdw = ' ('..addCommas(act.targets[1].actions[1].param)..' + '..addCommas(act.targets[1].actions[1].add_effect_param)..' '..sc[act.targets[1].actions[1].add_effect_animation]..')'
			--Magic Burst
			elseif act.targets[1].actions[1].message == 379 then
				target_action_result = ' ('..addCommas(act.targets[1].actions[1].param)..' Magic Burst!)'
				target_action_result_shdw = ' ('..addCommas(act.targets[1].actions[1].param)..' Magic Burst!)'
			--Plain damage
			elseif act.targets[1].actions[1].message == 317 then
				target_action_result = ' ('..addCommas(act.targets[1].actions[1].param)..')'
				target_action_result_shdw = ' ('..addCommas(act.targets[1].actions[1].param)..')'
			--Buff
			elseif act.targets[1].actions[1].message == 319 then
				target_action_result = ' ('..res.buffs[act.targets[1].actions[1].param].name..')'
				target_action_result_shdw = ' ('..res.buffs[act.targets[1].actions[1].param].name..')'
			end
		end

		local pet_is_ours = windower.ffxi.get_mob_by_id(act.actor_id).index == windower.ffxi.get_mob_by_id(player.id).pet_index and true or false
		if pet_is_ours then

			bars_meter_self_action:bg_color(050,255,050)
			completeSelfMeter()

			updateActionTable(player.id,target_action_status,target_action_status_shdw,target_action_result,target_action_result_shdw,trackingIndex)
			updateActionTable(act.actor_id,target_action_status,target_action_status_shdw,target_action_result,target_action_result_shdw,trackingIndex)

			if act.param ~= nil then

				coroutine.sleep(clear_action_delay)
				removeFromActionsTable(player.id,trackingIndex)
				removeFromActionsTable(act.actor_id,trackingIndex)
	
			end
		else

			if player.id == act.actor_id then
				bars_meter_self_action:bg_color(050,255,050)
				completeSelfMeter()
			end

			updateActionTable(act.actor_id,target_action_status,target_action_status_shdw,target_action_result,target_action_result_shdw,trackingIndex)

			if act.param ~= nil then

				coroutine.sleep(clear_action_delay)
				removeFromActionsTable(act.actor_id,trackingIndex)

			end
		end

	end
end)

--Unrecognized command
local function displayUnregnizedCommand()
	windower.add_to_chat(8,('[Bars] '):color(220)..('Unrecognized command. Type'):color(39)..(' //bars help'):color(1)..(' for a list of commands.'):color(39))
end

windower.register_event('addon command',function(addcmd, ...)

	--Update the bar position
	if addcmd == 'pos' or addcmd == 'position' then
		local pos = {...}

		--If there are not enough parameters then output the current position and remind how to update
		if #pos < 2 then
			windower.add_to_chat(8,('[Bars] '):color(220)..('Position:'):color(36)..(' '..settings.pos.x..' '..settings.pos.y):color(200))
			windower.add_to_chat(8,('[Bars] '):color(220)..('Update by adding X and Y coordinates (ex. '):color(8)..(' //bars pos 100 200'):color(1)..(')'):color(8))

		--X and Y coordinates are provided
		else
			--Take the provided string parameters and turn them into numbers
			settings.pos.x = tonumber(pos[1])
			settings.pos.y = tonumber(pos[2])
			
			--Position must be numbers
			if settings.pos.x == nil or settings.pos.y == nil then
				displayUnregnizedCommand()
				
			--Save the new setting, update the position, then alert the user
			else
				settings:save('all')
				windower.add_to_chat(8,('[Bars] '):color(220)..('Position:'):color(36)..(' '..settings.pos.x..' '..settings.pos.y):color(200))
				setPosition()

			end
		end

	--Update the bar width
	elseif addcmd == 'width' or addcmd == 'w' then
		local width = {...}
		local new_width = nil

		--If there are no parameters then output the current bar width and remind how to update
		if #width < 1 then
			windower.add_to_chat(8,('[Bars] '):color(220)..('Width:'):color(36)..(' '..settings.options.bar_width):color(200))
			windower.add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars width 73'):color(1)..(')'):color(8))

		--Size number is provided
		else
			--Take the provided string parameter and turn it into a number
			new_width = tonumber(width[1])
					
			--Save the new setting, update the width, then alert the user
			if new_width == nil then
				displayUnregnizedCommand()

			else
				settings.options.bar_width = new_width
				settings:save('all')
				windower.add_to_chat(8,('[Bars] '):color(220)..('Width:'):color(36)..(' '..settings.options.bar_width):color(200))
				hideBars()
				setWidth()
				updateHPBar()
				updateMPBar()
				updateTPBar()
				showBars()

			end
		end

	--Toggle the HP bar display setting for the current job
	elseif addcmd == 'hp' then

		settings.options.show_bars[job].hp = not settings.options.show_bars[job].hp
		settings:save('all')
		hideBars()
		setPosition()
		showBars()
		windower.add_to_chat(8,('[Bars] '):color(220)..('HP bar display for '..uppercase(job)..':'):color(36)..(' %s':format(settings.options.show_bars[job].hp and 'ON' or 'OFF')):color(200))

	--Toggle the MP bar display setting for the current job
	elseif addcmd == 'mp' then

		settings.options.show_bars[job].mp = not settings.options.show_bars[job].mp
		settings:save('all')
		hideBars()
		setPosition()
		showBars()
		windower.add_to_chat(8,('[Bars] '):color(220)..('MP bar display for '..uppercase(job)..':'):color(36)..(' %s':format(settings.options.show_bars[job].mp and 'ON' or 'OFF')):color(200))

	--Toggle the TP bar display setting for the current job
	elseif addcmd == 'tp' then

		settings.options.show_bars[job].tp = not settings.options.show_bars[job].tp
		settings:save('all')
		hideBars()
		setPosition()
		showBars()
		windower.add_to_chat(8,('[Bars] '):color(220)..('TP bar display for '..uppercase(job)..':'):color(36)..(' %s':format(settings.options.show_bars[job].tp and 'ON' or 'OFF')):color(200))

	--Toggle the Pet bar display setting for the current job
	elseif addcmd == 'pet' then

		settings.options.show_bars[job].pet = not settings.options.show_bars[job].pet
		settings:save('all')
		hideBars()
		setPosition()
		showBars()
		windower.add_to_chat(8,('[Bars] '):color(220)..('Pet bar display for '..uppercase(job)..':'):color(36)..(' %s':format(settings.options.show_bars[job].pet and 'ON' or 'OFF')):color(200))

	--Update the vertical offset for the current job
	elseif addcmd == 'offset' or addcmd == 'o' then
		local offset = {...}
		local new_offset = nil

		--If there are no parameters then output the current offset and remind how to update
		if #offset < 1 then
			windower.add_to_chat(8,('[Bars] '):color(220)..('Vertical Offset for '..uppercase(job)..':'):color(36)..(' '..show_bars[job].vertical_offset):color(200))
			windower.add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars offset 29'):color(1)..(')'):color(8))

		--Size number is provided
		else
			--Take the provided string parameter and turn it into a number
			new_offset = tonumber(offset[1])
					
			--Save the new setting, update the offset, then alert the user
			if new_offset == nil then
				displayUnregnizedCommand()

			else
				show_bars[job].vertical_offset = new_offset
				settings:save('all')
				windower.add_to_chat(8,('[Bars] '):color(220)..('Vertical Offset for '..uppercase(job)..':'):color(36)..(' '..show_bars[job].vertical_offset):color(200))
				hideBars()
				setPosition()
				showBars()

			end
		end

	--Update the size
	elseif addcmd == 'size' or addcmd == 's' then
		local size = {...}
		local new_size = nil
		
		--If there are no parameters then output the current size and remind how to update
		if #size < 1 then
			windower.add_to_chat(8,('[Bars] '):color(220)..('Size:'):color(36)..(' '..settings.text.size):color(200))
			windower.add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars size 10'):color(1)..(')'):color(8))

		--Size number is provided
		else
			--Take the provided string parameter and turn it into a number
			new_size = tonumber(size[1])
					
			--Save the new setting, update the size, then alert the user
			if new_size == nil then
				displayUnregnizedCommand()

			else
				settings.text.size = new_size
				settings:save('all')
				windower.add_to_chat(8,('[Bars] '):color(220)..('Size:'):color(36)..(' '..settings.text.size):color(200))
				setSize()

			end
		end

	--Toggle the target distance setting
	elseif addcmd == 'distance' or addcmd == 'dist' or addcmd == 'd' then

		settings.options.show_target_distance = not settings.options.show_target_distance
		show_target_distance = settings.options.show_target_distance
		settings:save('all')
		windower.add_to_chat(8,('[Bars] '):color(220)..('Distance:'):color(36)..(' %s':format(settings.options.show_target_distance and 'ON' or 'OFF')):color(200))

	--Toggle the markers setting
	elseif addcmd == 'marker' or addcmd == 'markers' or addcmd == 'm' then

		settings.options.show_bar_markers = not settings.options.show_bar_markers
		settings:save('all')
		windower.add_to_chat(8,('[Bars] '):color(220)..('Markers:'):color(36)..(' %s':format(settings.options.show_bar_markers and 'ON' or 'OFF')):color(200))
		hideBars()
		setWidth()
		showBars()

	--Toggle the index setting
	elseif addcmd == 'index' or addcmd == 'i' then

		settings.options.show_target_index = not settings.options.show_target_index
		show_target_index = settings.options.show_target_index
		settings:save('all')
		windower.add_to_chat(8,('[Bars] '):color(220)..('Index:'):color(36)..(' %s':format(settings.options.show_target_index and 'ON' or 'OFF')):color(200))
		updateTarget()

	--Toggle the bold setting
	elseif addcmd == 'bold' or addcmd == 'b' then

		settings.flags.bold = not settings.flags.bold
		settings:save('all')
		windower.add_to_chat(8,('[Bars] '):color(220)..('Bold:'):color(36)..(' %s':format(settings.flags.bold and 'ON' or 'OFF')):color(200))
		setBold()

	--Add a target to the Auto Focus Target list
	elseif addcmd == 'add' or addcmd == 'a' then

		local target = {...}

		if target == nil then
			windower.add_to_chat(8,('[Bars] '):color(220)..('Please specify a target to be added (name or id).'):color(39))
			return
		end

		addToAutoFocusTargetList(target)

	--Remove a target from the Auto Focus Target lsit
	elseif addcmd == 'remove' or addcmd == 'rem' or addcmd == 'rmv' or addcmd == 'r' then

		local target = {...}

		if target == nil then
			windower.add_to_chat(8,('[Bars] '):color(220)..('Please specify a target to be removed.'):color(39))
			return
		end

		removeFromAutoFocusTargetList(target)

	--Display the Auto Focus Target list
	elseif addcmd == 'list' or addcmd == 'l' then

		listAutoFocusTargets()

	--Display help text
	elseif addcmd == 'help' then

		local currPos = settings.pos
		local currHP = settings.options.show_bars[job].hp
		local currMP = settings.options.show_bars[job].mp
		local currTP = settings.options.show_bars[job].tp
		local currPet = settings.options.show_bars[job].pet
		local currWidth = settings.options.bar_width
		local currDistance = settings.options.show_target_distance
		local currMarker = settings.options.show_bar_markers
		local currIndex = settings.options.show_target_index
		local currJob = uppercase(job)
		local currOffset = settings.options.show_bars[job].vertical_offset
		local currSize = settings.text.size
		local currBold = settings.flags.bold

		windower.add_to_chat(8,('[Bars] ':color(220))..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..('Key (Keylesta@Valefor)'):color(220))
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,(' Commands '):color(220)..('[optional]'):color(53)..(' <required>'):color(2))
		windower.add_to_chat(8,('   pos '):color(36)..('[x y]'):color(53)..(' - Update position. ['):color(8)..(currPos.x..' '..currPos.y):color(200)..(']'):color(8))
		windower.add_to_chat(8,('   hp/mp/tp/pet'):color(36)..(' - Toggle HP/MP/TP/Pet bar display setting for current job.'):color(8))
		windower.add_to_chat(8,'   '..(' ['..currJob..' - HP: '):color(8)..('%s':format(currHP and 'ON' or 'OFF')):color(200)..(' MP: '):color(8)..('%s':format(currMP and 'ON' or 'OFF')):color(200)..(' TP: '):color(8)..('%s':format(currTP and 'ON' or 'OFF')):color(200)..(' Pet: '):color(8)..('%s':format(currPet and 'ON' or 'OFF')):color(200)..(']'):color(8))
		windower.add_to_chat(8,('   width/w '):color(36)..('[#]'):color(53)..(' - Update the bar width. ['):color(8)..(''..currWidth):color(200)..(']'):color(8))
		windower.add_to_chat(8,('   distance/d '):color(36)..(' - Toggle the Distance option. ['):color(8)..('%s':format(currDistance and 'ON' or 'OFF')):color(200)..(']'):color(8))
		windower.add_to_chat(8,('   marker/m '):color(36)..(' - Toggle the Marker option. ['):color(8)..('%s':format(currMarker and 'ON' or 'OFF')):color(200)..(']'):color(8))
		windower.add_to_chat(8,('   index/i '):color(36)..(' - Toggle the Index option. ['):color(8)..('%s':format(currIndex and 'ON' or 'OFF')):color(200)..(']'):color(8))
		windower.add_to_chat(8,('   offset/o '):color(36)..('[#]'):color(53)..(' - Update the vertical offset for the current job. ['..currJob..': '):color(8)..(''..currOffset):color(200)..(']'):color(8))
		windower.add_to_chat(8,('   add/a '):color(36)..('<target>'):color(2)..(' - Add a target to the Auto Focus Target list.'):color(8))
		windower.add_to_chat(8,'   '..(' - Valid targets: Names (ex: Oseem), IDs (ex: 17809550).'):color(8))
		windower.add_to_chat(8,'   '..(' - Use quotes to surround names with spaces.'):color(8))
		windower.add_to_chat(8,('   remove/r '):color(36)..('<target>'):color(2)..(' - Remove a target from the Auto Focus Target list.'):color(8))
		windower.add_to_chat(8,('   list/l'):color(36)..(' - Show the Auto Focus Target list.'):color(8))
		windower.add_to_chat(8,('   size/s '):color(36)..('[#]':color(53))..(' - Update font size. ['):color(8)..(''..currSize):color(200)..(']'):color(8))
		windower.add_to_chat(8,('   bold/b'):color(36)..(' - Toggle the bold setting. ['):color(8)..('%s':format(currBold and 'ON' or 'OFF')):color(200)..(']'):color(8))

	else

		displayUnregnizedCommand()

	end
end)
