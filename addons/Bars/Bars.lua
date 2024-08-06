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
_addon.version = '1.1'
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
		bars_vertical_spacing = {target_to_focus_target = -40, target_to_player_stats = 40, between_player_stats = 23},
		focus_target_max_distance = 50,
		hide_focus_target_when_target = true,
		show_action_status_indicators = true,
		show_bar_markers = true,
		show_bars = {
			brd = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			blm = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			blu = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			bst = {hp = true, mp = true, pet = true, tp = true, vertical_offset = 0},
			cor = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			dnc = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			drg = {hp = true, mp = true, pet = true, tp = true, vertical_offset = 0},
			drk = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			geo = {hp = true, mp = true, pet = true, tp = true, vertical_offset = 0},
			mnk = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			nin = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			pld = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			pup = {hp = true, mp = true, pet = true, tp = true, vertical_offset = 0},
			rdm = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			rng = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			run = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			sam = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			sch = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			smn = {hp = true, mp = true, pet = true, tp = true, vertical_offset = 0},
			thf = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			war = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
			whm = {hp = true, mp = true, pet = false, tp = true, vertical_offset = 0},
		},
		show_max_hp_mp_on_bar = true,
		show_self_when_target = true,
		show_self_action = true,
		show_target_action = true,
		show_target_index = false,
		self_action_pos = {
			x = 10,
			y = 80,
		},
		self_action_text_size_difference = 0,
		target_action_text_size_difference = 3,
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
	},
}

settings = config.load(defaults)

local bar_width = settings.options.bar_width
local bars_vertical_spacing = settings.options.bars_vertical_spacing
local auto_focus_target_list = settings.auto_focus_target_list
local focus_target_max_distance = settings.options.focus_target_max_distance
local hide_focus_target_when_target = settings.options.hide_focus_target_when_target
local show_bar_markers = settings.options.show_bar_markers
local show_bars = settings.options.show_bars
local show_max_hp_mp_on_bar = settings.options.show_max_hp_mp_on_bar
local show_self_action = settings.options.show_self_action
local show_self_when_target = settings.options.show_self_when_target
local show_target_action = settings.options.show_target_action
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
local inCS = false
local zoning = false
local job = ''
local current_actions = {}
local focus_target = nil
local bars_bg_str = ''
local bars_bg_str_ft = ''
local bars_bg_str_hp = ''
local bars_bg_str_tp = ''

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

--BACKGROUNDS

-- Create the Focus Target BACKGROUND text object
local bars_bg_focus_target = texts.new()
bars_bg_focus_target:font(font)
bars_bg_focus_target:pad(-4)
bars_bg_focus_target:bg_alpha(bg_alpha)
bars_bg_focus_target:draggable(false)

-- Create the Target BACKGROUND text object
local bars_bg_target = texts.new()
bars_bg_target:font(font)
bars_bg_target:pad(-4)
bars_bg_target:bg_alpha(bg_alpha)
bars_bg_target:draggable(false)

-- Create the HP BACKGROUND text object
local bars_bg_hp = texts.new()
bars_bg_hp:font(font)
bars_bg_hp:pad(-4)
bars_bg_hp:bg_alpha(bg_alpha)
bars_bg_hp:draggable(false)

-- Create the MP BACKGROUND text object
local bars_bg_mp = texts.new()
bars_bg_mp:font(font)
bars_bg_mp:pad(-4)
bars_bg_mp:bg_alpha(bg_alpha)
bars_bg_mp:draggable(false)

-- Create the TP BACKGROUND text object
local bars_bg_tp = texts.new()
bars_bg_tp:font(font)
bars_bg_tp:pad(-4)
bars_bg_tp:bg_alpha(bg_alpha)
bars_bg_tp:draggable(false)

-- Create the Pet BACKGROUND text object
local bars_bg_pet = texts.new()
bars_bg_pet:font(font)
bars_bg_pet:pad(-4)
bars_bg_pet:bg_alpha(bg_alpha)
bars_bg_pet:draggable(false)

--METERS

-- Create the Focus Target METER text object
local bars_meter_focus_target = texts.new()
bars_meter_focus_target:font(font)
bars_meter_focus_target:pad(-5)
bars_meter_focus_target:bg_alpha(bg_alpha)
bars_meter_focus_target:draggable(false)

-- Create the Target METER text object
local bars_meter_target = texts.new()
bars_meter_target:font(font)
bars_meter_target:pad(-5)
bars_meter_target:bg_alpha(bg_alpha)
bars_meter_target:draggable(false)

-- Create the Player Status HP METER text object
local bars_meter_hp = texts.new()
bars_meter_hp:font(font)
bars_meter_hp:pad(-5)
bars_meter_hp:bg_alpha(bg_alpha)
bars_meter_hp:bg_color(color.hp.bar.r,color.hp.bar.g,color.hp.bar.b)
bars_meter_hp:draggable(false)

-- Create the Player Status MP METER text object
local bars_meter_mp = texts.new()
bars_meter_mp:font(font)
bars_meter_mp:pad(-5)
bars_meter_mp:bg_alpha(bg_alpha)
bars_meter_mp:bg_color(color.mp.bar.r,color.mp.bar.g,color.mp.bar.b)
bars_meter_mp:draggable(false)

-- Create the Player Status TP METER text object
local bars_meter_tp = texts.new()
bars_meter_tp:font(font)
bars_meter_tp:pad(-5)
bars_meter_tp:bg_alpha(bg_alpha)
bars_meter_tp:draggable(false)

-- Create the Player Status Pet METER text object
local bars_meter_pet = texts.new()
bars_meter_pet:font(font)
bars_meter_pet:pad(-5)
bars_meter_pet:bg_alpha(bg_alpha)
bars_meter_pet:bg_color(color.pet.bar.r,color.pet.bar.g,color.pet.bar.b)
bars_meter_pet:draggable(false)

--MARKERS

-- Create the HP MARKER text object
local bars_marker_hp = texts.new()
bars_marker_hp:font(font)
bars_marker_hp:pad(-4)
bars_marker_hp:bg_alpha(0)
bars_marker_hp:draggable(false)

-- Create the TP MARKER text object
local bars_marker_tp = texts.new()
bars_marker_tp:font(font)
bars_marker_tp:pad(-4)
bars_marker_tp:bg_alpha(0)
bars_marker_tp:draggable(false)

--TEXT SHADOW

-- Create the Self Action TEXT SHADOW text object
local bars_text_shdw_self_action = texts.new()
bars_text_shdw_self_action:font(font)
bars_text_shdw_self_action:color(0,0,0)
bars_text_shdw_self_action:bg_alpha(0)
bars_text_shdw_self_action:draggable(false)

-- Create the Focus Target TEXT SHADOW text object
local bars_text_shdw_focus_target = texts.new()
bars_text_shdw_focus_target:font(font)
bars_text_shdw_focus_target:color(0,0,0)
bars_text_shdw_focus_target:bg_alpha(0)
bars_text_shdw_focus_target:draggable(false)

-- Create the Focus Target Action TEXT SHADOW text object
local bars_text_shdw_focus_target_action = texts.new()
bars_text_shdw_focus_target_action:font(font)
bars_text_shdw_focus_target_action:color(0,0,0)
bars_text_shdw_focus_target_action:bg_alpha(0)
bars_text_shdw_focus_target_action:draggable(false)

-- Create the Target TEXT SHADOW text object
local bars_text_shdw_target = texts.new()
bars_text_shdw_target:font(font)
bars_text_shdw_target:color(0,0,0)
bars_text_shdw_target:bg_alpha(0)
bars_text_shdw_target:draggable(false)

-- Create the Target Action TEXT SHADOW text object
local bars_text_shdw_target_action = texts.new()
bars_text_shdw_target_action:font(font)
bars_text_shdw_target_action:color(0,0,0)
bars_text_shdw_target_action:bg_alpha(0)
bars_text_shdw_target_action:draggable(false)

-- Create the Player Status HP TEXT SHADOW text object
local bars_text_shdw_hp = texts.new()
bars_text_shdw_hp:font(font)
bars_text_shdw_hp:color(0,0,0)
bars_text_shdw_hp:bg_alpha(0)
bars_text_shdw_hp:draggable(false)

-- Create the Player Status MP TEXT SHADOW text object
local bars_text_shdw_mp = texts.new()
bars_text_shdw_mp:font(font)
bars_text_shdw_mp:color(0,0,0)
bars_text_shdw_mp:bg_alpha(0)
bars_text_shdw_mp:draggable(false)

-- Create the Player Status TP TEXT SHADOW text object
local bars_text_shdw_tp = texts.new()
bars_text_shdw_tp:font(font)
bars_text_shdw_tp:color(0,0,0)
bars_text_shdw_tp:bg_alpha(0)
bars_text_shdw_tp:draggable(false)

-- Create the Player Status Pet TEXT SHADOW text object
local bars_text_shdw_pet = texts.new()
bars_text_shdw_pet:font(font)
bars_text_shdw_pet:color(0,0,0)
bars_text_shdw_pet:bg_alpha(0)
bars_text_shdw_pet:draggable(false)

--TEXT

-- Create the Self Action TEXT text object
local bars_text_self_action = texts.new()
bars_text_self_action:font(font)
bars_text_self_action:color(text_color.r,text_color.g,text_color.b)
bars_text_self_action:bg_alpha(0)
bars_text_self_action:draggable(false)

-- Create the Focus Target TEXT text object
local bars_text_focus_target = texts.new()
bars_text_focus_target:font(font)
bars_text_focus_target:color(text_color.r,text_color.g,text_color.b)
bars_text_focus_target:bg_alpha(0)
bars_text_focus_target:draggable(false)

-- Create the Focus Target Action TEXT text object
local bars_text_focus_target_action = texts.new()
bars_text_focus_target_action:font(font)
bars_text_focus_target_action:color(text_color.r,text_color.g,text_color.b)
bars_text_focus_target_action:bg_alpha(0)
bars_text_focus_target_action:draggable(false)

-- Create the Target TEXT text object
local bars_text_target = texts.new()
bars_text_target:font(font)
bars_text_target:color(text_color.r,text_color.g,text_color.b)
bars_text_target:bg_alpha(0)
bars_text_target:draggable(false)

-- Create the Target Action TEXT text object
local bars_text_target_action = texts.new()
bars_text_target_action:font(font)
bars_text_target_action:color(text_color.r,text_color.g,text_color.b)
bars_text_target_action:bg_alpha(0)
bars_text_target_action:draggable(false)

-- Create the Player Status HP TEXT text object
local bars_text_hp = texts.new()
bars_text_hp:font(font)
bars_text_hp:color(text_color.r,text_color.g,text_color.b)
bars_text_hp:bg_alpha(0)
bars_text_hp:draggable(false)

-- Create the Player Status MP TEXT text object
local bars_text_mp = texts.new()
bars_text_mp:font(font)
bars_text_mp:color(text_color.r,text_color.g,text_color.b)
bars_text_mp:bg_alpha(0)
bars_text_mp:draggable(false)

-- Create the Player Status TP TEXT text object
local bars_text_tp = texts.new()
bars_text_tp:font(font)
bars_text_tp:color(text_color.r,text_color.g,text_color.b)
bars_text_tp:bg_alpha(0)
bars_text_tp:draggable(false)

-- Create the Player Status Pet TEXT text object
local bars_text_pet = texts.new()
bars_text_pet:font(font)
bars_text_pet:color(text_color.r,text_color.g,text_color.b)
bars_text_pet:bg_alpha(0)
bars_text_pet:draggable(false)

windower.register_event('unload', function()
	bars_bg_focus_target:destroy()
	bars_bg_target:destroy()
	bars_bg_hp:destroy()
	bars_bg_mp:destroy()
	bars_bg_tp:destroy()
	bars_bg_pet:destroy()
	bars_meter_focus_target:destroy()
	bars_meter_target:destroy()
	bars_meter_hp:destroy()
	bars_meter_mp:destroy()
	bars_meter_tp:destroy()
	bars_meter_pet:destroy()
	bars_marker_hp:destroy()
	bars_marker_tp:destroy()
	bars_text_shdw_self_action:destroy()
	bars_text_shdw_focus_target:destroy()
	bars_text_shdw_focus_target_action:destroy()
	bars_text_shdw_target:destroy()
	bars_text_shdw_target_action:destroy()
	bars_text_shdw_hp:destroy()
	bars_text_shdw_mp:destroy()
	bars_text_shdw_tp:destroy()
	bars_text_shdw_pet:destroy()
	bars_text_self_action:destroy()
	bars_text_focus_target:destroy()
	bars_text_focus_target_action:destroy()
	bars_text_target:destroy()
	bars_text_target_action:destroy()
	bars_text_hp:destroy()
	bars_text_mp:destroy()
	bars_text_tp:destroy()
	bars_text_pet:destroy()
end)

local function setBold()

	local bold = settings.flags.bold

	bars_marker_hp:bold(bold)
	bars_marker_tp:bold(bold)
	bars_text_shdw_self_action:bold(bold)
	bars_text_shdw_focus_target:bold(bold)
	bars_text_shdw_focus_target_action:bold(bold)
	bars_text_shdw_target:bold(bold)
	bars_text_shdw_target_action:bold(bold)
	bars_text_shdw_hp:bold(bold)
	bars_text_shdw_mp:bold(bold)
	bars_text_shdw_tp:bold(bold)
	bars_text_shdw_pet:bold(bold)
	bars_text_self_action:bold(bold)
	bars_text_focus_target:bold(bold)
	bars_text_focus_target_action:bold(bold)
	bars_text_target:bold(bold)
	bars_text_target_action:bold(bold)
	bars_text_hp:bold(bold)
	bars_text_mp:bold(bold)
	bars_text_tp:bold(bold)
	bars_text_pet:bold(bold)
end
setBold()

local function setSize()

	local size = settings.text.size

	bars_bg_focus_target:size(size)
	bars_bg_target:size(size)
	bars_bg_hp:size(size)
	bars_bg_mp:size(size)
	bars_bg_tp:size(size)
	bars_bg_pet:size(size)
	bars_meter_focus_target:size(size)
	bars_meter_target:size(size)
	bars_meter_hp:size(size)
	bars_meter_mp:size(size)
	bars_meter_tp:size(size)
	bars_meter_pet:size(size)
	bars_marker_hp:size(size)
	bars_marker_tp:size(size)
	bars_text_shdw_self_action:size(size+self_action_text_size_difference)
	bars_text_shdw_focus_target:size(size)
	bars_text_shdw_focus_target_action:size(size)
	bars_text_shdw_target:size(size+target_text_size_difference)
	bars_text_shdw_target_action:size(size+target_action_text_size_difference)
	bars_text_shdw_hp:size(size)
	bars_text_shdw_mp:size(size)
	bars_text_shdw_tp:size(size)
	bars_text_shdw_pet:size(size)
	bars_text_self_action:size(size+self_action_text_size_difference)
	bars_text_focus_target:size(size)
	bars_text_focus_target_action:size(size)
	bars_text_target:size(size+target_text_size_difference)
	bars_text_target_action:size(size+target_action_text_size_difference)
	bars_text_hp:size(size)
	bars_text_mp:size(size)
	bars_text_tp:size(size)
	bars_text_pet:size(size)
end
setSize()

local function setPosition()

	local pos_self_action = {x = settings.options.self_action_pos.x, y = settings.options.self_action_pos.y}
	local pos_target = {x = settings.pos.x, y = settings.pos.y + show_bars[job].vertical_offset}
	local pos_focus_target = {x = pos_target.x, y = pos_target.y + bars_vertical_spacing.target_to_focus_target}
	local player_stats_1 = {x = pos_target.x, y = pos_target.y + bars_vertical_spacing.target_to_player_stats}
	local player_stats_2 = {x = pos_target.x, y = player_stats_1.y + bars_vertical_spacing.between_player_stats}
	local player_stats_3 = {x = pos_target.x, y = player_stats_2.y + bars_vertical_spacing.between_player_stats}
	local player_stats_4 = {x = pos_target.x, y = player_stats_3.y + bars_vertical_spacing.between_player_stats}

	local pos_hp = player_stats_1
	local pos_mp = player_stats_2
	local pos_tp = player_stats_3
	local pos_pet = player_stats_4

	-- Order the HP/MP/TP bars based on which are displayed
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
			pos_tp = player_stats_2
			pos_pet = player_stats_3
		end
	else
		if not show_bars[job].mp then
			if not show_bars[job].tp then
				pos_pet = player_stats_2
			else
				pos_tp = player_stats_2
				pos_pet = player_stats_3
			end
		else
			if not show_bars[job].tp then
				pos_pet = player_stats_3
			end
		end
	end

	bars_bg_focus_target:pos(pos_focus_target.x,pos_focus_target.y+8)
	bars_bg_target:pos(pos_target.x,pos_target.y+8)
	bars_bg_hp:pos(pos_hp.x,pos_hp.y+8)
	bars_bg_mp:pos(pos_mp.x,pos_mp.y+8)
	bars_bg_tp:pos(pos_tp.x,pos_tp.y+8)
	bars_bg_pet:pos(pos_pet.x,pos_pet.y+8)
	bars_meter_focus_target:pos(pos_focus_target.x+1,pos_focus_target.y+9)
	bars_meter_target:pos(pos_target.x+1,pos_target.y+9)
	bars_meter_hp:pos(pos_hp.x+1,pos_hp.y+9)
	bars_meter_mp:pos(pos_mp.x+1,pos_mp.y+9)
	bars_meter_tp:pos(pos_tp.x+1,pos_tp.y+9)
	bars_meter_pet:pos(pos_pet.x+1,pos_pet.y+9)
	bars_marker_hp:pos(pos_hp.x,pos_hp.y+7)
	bars_marker_tp:pos(pos_tp.x,pos_tp.y+7)
	bars_text_shdw_self_action:pos(pos_self_action.x+1.5,pos_self_action.y+1.5)
	bars_text_shdw_focus_target:pos(pos_focus_target.x+1.5,pos_focus_target.y+text_vertical_offset+1.5)
	bars_text_shdw_focus_target_action:pos(pos_focus_target.x+1.5,pos_focus_target.y+1.5+13)
	bars_text_shdw_target:pos(pos_target.x+1.5,pos_target.y+text_vertical_offset+1.5-5) -- -5 to compensate the +2 to size for the target text
	bars_text_shdw_target_action:pos(pos_target.x+1.5,pos_target.y+1.5+13)
	bars_text_shdw_hp:pos(pos_hp.x+1.5,pos_hp.y+text_vertical_offset+1.5)
	bars_text_shdw_mp:pos(pos_mp.x+1.5,pos_mp.y+text_vertical_offset+1.5)
	bars_text_shdw_tp:pos(pos_tp.x+1.5,pos_tp.y+text_vertical_offset+1.5)
	bars_text_shdw_pet:pos(pos_pet.x+1.5,pos_pet.y+text_vertical_offset+1.5)
	bars_text_self_action:pos(pos_self_action.x,pos_self_action.y)
	bars_text_focus_target:pos(pos_focus_target.x,pos_focus_target.y+text_vertical_offset)
	bars_text_focus_target_action:pos(pos_focus_target.x,pos_focus_target.y+13)
	bars_text_target:pos(pos_target.x,pos_target.y+text_vertical_offset-5) -- -5 to compensate the +2 to size for the target text
	bars_text_target_action:pos(pos_target.x,pos_target.y+13)
	bars_text_hp:pos(pos_hp.x,pos_hp.y+text_vertical_offset)
	bars_text_mp:pos(pos_mp.x,pos_mp.y+text_vertical_offset)
	bars_text_tp:pos(pos_tp.x,pos_tp.y+text_vertical_offset)
	bars_text_pet:pos(pos_pet.x,pos_pet.y+text_vertical_offset)

end

local function setWidth()

	bar_width = settings.options.bar_width
	show_bar_markers = settings.options.show_bar_markers
	bars_bg_str = ''
	bars_bg_str_ft = ''
	bars_bg_str_hp = ''
	bars_bg_str_tp = ''

	-- Sets the width for most of the bg elements
	while string.len(bars_bg_str) < bar_width do
		bars_bg_str = bars_bg_str..' '
	end

	-- Sets the width for the focus target bg element
	while string.len(bars_bg_str_ft) < math.floor(bar_width / 2) do
		bars_bg_str_ft = bars_bg_str_ft..' '
	end

	-- Sets the width and yellow HP marker for the HP bar BG
	local marker_position = math.floor(bar_width * 0.75)

	for i = 1, bar_width do
		if i == marker_position then
			bars_bg_str_hp = bars_bg_str_hp .. '·'
		else
			bars_bg_str_hp = bars_bg_str_hp .. ' '
		end
	end

	-- Sets the width and 1k/2k markers for the TP bar BG
	local first_marker_position = math.floor(bar_width * 0.33)
	local second_marker_position = math.floor(bar_width * 0.66)

	for i = 1, bar_width do
		if i == first_marker_position or i == second_marker_position then
			bars_bg_str_tp = bars_bg_str_tp .. '·'
		else
			bars_bg_str_tp = bars_bg_str_tp .. ' '
		end
	end

	bars_bg_focus_target:text(bars_bg_str_ft)
	bars_bg_target:text(bars_bg_str)
	bars_bg_hp:text(bars_bg_str)
	bars_bg_mp:text(bars_bg_str)
	bars_bg_tp:text(bars_bg_str)
	bars_bg_pet:text(bars_bg_str)
	bars_marker_hp:text(show_bar_markers and bars_bg_str_hp or bars_bg_str)
	bars_marker_tp:text(show_bar_markers and bars_bg_str_tp or bars_bg_str)

end

local function hideBars()

	bars_bg_focus_target:hide()
	bars_bg_target:hide()
	bars_bg_hp:hide()
	bars_bg_mp:hide()
	bars_bg_tp:hide()
	bars_bg_pet:hide()
	bars_meter_focus_target:hide()
	bars_meter_target:hide()
	bars_meter_hp:hide()
	bars_meter_mp:hide()
	bars_meter_tp:hide()
	bars_marker_hp:hide()
	bars_marker_tp:hide()
	bars_text_shdw_self_action:hide()
	bars_text_shdw_focus_target:hide()
	bars_text_shdw_focus_target_action:hide()
	bars_text_shdw_target:hide()
	bars_text_shdw_target_action:hide()
	bars_text_shdw_hp:hide()
	bars_text_shdw_mp:hide()
	bars_text_shdw_tp:hide()
	bars_text_shdw_pet:hide()
	bars_text_self_action:hide()
	bars_text_focus_target:hide()
	bars_text_focus_target_action:hide()
	bars_text_target:hide()
	bars_text_target_action:hide()
	bars_text_hp:hide()
	bars_text_mp:hide()
	bars_text_tp:hide()
	bars_text_pet:hide()

end

local function showBars()

	if focus_target then
		bars_bg_focus_target:show()
	end

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

-- Set what job we are currently
local function setJob()

	local player = windower.ffxi.get_player()
	job = string.lower(player.main_job)

end

-- Add an action to the current_actions table
function addToActionsTable(actor_id, actor_action, action_status)

	current_actions[actor_id] = {
		action = actor_action,
		status = action_status,
	}

end

-- Update the status of an action in the current_actions table
function updateActionStatus(actor_id, action_status)

	if current_actions[actor_id] then
		current_actions[actor_id].status = action_status
	end

end

-- Remove an action from the current_actions table
function removeFromActionsTable(actor_id)

	current_actions[actor_id] = nil

end

-- Clear all actions from the current_actions table
function clearActionsTable()

	current_actions = {}

end

-- Is the target a player?
local function isPlayer(id)

	local actor = windower.ffxi.get_mob_by_id(id)

	if actor and (actor.spawn_type == 1 or actor.spawn_type == 13) then
		-- Is a player
		return true
	else
		-- Is not a player
		return false
	end

end

-- Is this player in our party?
local function isInParty(id)

	local actor = windower.ffxi.get_mob_by_id(id)

	if actor == nil or not actor.in_party then
		-- Not in our party
		return false
	else
		-- In our party
		return true
	end

end

-- Is this player in our alliance?
local function isInAlliance(id)

	local actor = windower.ffxi.get_mob_by_id(id)

	if actor == nil or not actor.in_alliance then
		-- Not in our alliance
		return false
	else
		-- In our alliance
		return true
	end

end

-- Return what color the target should be based on what/who it is
local function targetColor(target)

	local player = windower.ffxi.get_player()

	if target and target.id == player.id then
		return color.target.pc_self
	elseif target and isInParty(target.id) then
		return color.target.pc_party
	elseif target and isInAlliance(target.id) then
		return color.target.pc_alliance
	elseif target and target.is_npc then
		if target.spawn_type == 16 then
			if target.claim_id == 0 then
				return color.target.monster_passive
			elseif isInParty(target.claim_id) then
				return color.target.monster_claimed_party
			elseif isInAlliance(target.claim_id) then
				return color.target.monster_claimed_alliance
			else
				return color.target.monster_claimed_other
			end
		else
			return color.target.npc
		end
	else
		return color.target.pc_other
	end

end

-- Capitalize letters accordingly
function capitalize(str)

	return string.gsub(str, "(%w)(%w*)", function(firstLetter, rest)
		return string.upper(firstLetter) .. string.lower(rest)
	end)

end

-- Turn the entire string into all uppercase
function uppercase(str)

	local uppercased = string.gsub(str, "%a", function(letter)
		return letter:upper()
	end)

	return uppercased

end

-- Convert auto focus targets to save them properly
function convertToSave(target)

	target = string.lower(target) --convert target to all lowercase
	target = string.gsub(target, " ", "_") --convert spaces to underscores
	target = string.gsub(target, "'", "__apos__") --convert apostrophes to __apos__
	return target

end

-- Convert auto focus targets to display them properly
function convertToDisplay(target)

	target = string.gsub(target, "__apos__", "'") --convert __apos__ back to apostrophe
	target = capitalize(target) -- capitalize names
	target = string.gsub(target, "_", " ") --convert underscores to spaces
	return target

end

-- Add a target to the auto_focus_target_list
function addToAutoFocusTargetList(target)

	-- If target is a table, first convert it into a useable string
	if type(target) == 'table' then
		local concatenated_target = table.concat(target, ' ')
		target = concatenated_target
	end

	auto_focus_target_list[convertToSave(target)] = true
	settings:save('all')
	
	windower.add_to_chat(220,'[Bars] '..('Added to Auto Focus Target list: '):color(36)..(capitalize(target)):color(1))

end

-- Remove a target from the auto_focus_target_list
function removeFromAutoFocusTargetList(target)

	-- If target is a table, first convert it into a useable string
	if type(target) == 'table' then
		local concatenated_target = table.concat(target, ' ')
		target = concatenated_target
	end

	local savedTarget = convertToSave(target)

	if auto_focus_target_list[savedTarget] then
		auto_focus_target_list[savedTarget] = nil
		windower.add_to_chat(220,'[Bars] '..('Removed from Auto Focus Target list: '):color(36)..(capitalize(target)):color(1))
		settings:save('all')

	else
		windower.add_to_chat(220,'[Bars] '..(capitalize(target)):color(1)..(' was not found.'):color(39))
		windower.add_to_chat(220,'[Bars] '..('Type '):color(8)..('//bars list'):color(1)..(' to see stored targets.'):color(8))

	end
end

local function updateSelfAction()

	local player = windower.ffxi.get_player()
	local ct = text_color
	local self_status = show_action_status_indicators and current_actions[player.id] and current_actions[player.id].status or ''
	local self_action = current_actions[player.id] and current_actions[player.id].action or ''
	local text_self_action = ' '..self_status..self_action

	if self_status ~= '' then
		if not inCS then

			bars_text_shdw_self_action:show()
			bars_text_self_action:show()

		end

		bars_text_shdw_self_action:text(text_self_action:text_strip_format()) --strip out the custom coloring of the spells
		bars_text_self_action:text(text_self_action)

	else

		bars_text_shdw_self_action:hide()
		bars_text_self_action:hide()

	end

end

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
	while string.len(focus_target_meter) < spaces do
		focus_target_meter = focus_target_meter..' '
	end
	local cm = focus_target and targetColor(focus_target) or color.target.pc_other
	local ct = text_color
	focus_target_hpp = string.format("%3s", focus_target_hpp)
	local text = focus_target_hpp..'% '..focus_target_name
	local focus_target_status = show_action_status_indicators and focus_target and current_actions[focus_target.id] and current_actions[focus_target.id].status or ''
	local focus_target_action = focus_target and current_actions[focus_target.id] and current_actions[focus_target.id].action or ''
	local text_focus_target_action = show_target_action and '      '..focus_target_status..focus_target_action or ''

	if not inCS then

		-- fix the pad issue when 0
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
	bars_text_shdw_focus_target_action:text(text_focus_target_action:text_strip_format()) --strip out the custom coloring of the spells
	bars_text_focus_target:text(text)
	bars_text_focus_target_action:text(text_focus_target_action)
	bars_text_focus_target:color(ct.r,ct.g,ct.b)
	bars_text_focus_target_action:color(ct.r,ct.g,ct.b)

end

local function updateTarget()

	local player = windower.ffxi.get_player()
	local target = windower.ffxi.get_mob_by_target('st', 't')
	local target_name = target and target.name or ''
	local target_index = target and target.index or ''
	local target_hpp = target and target.hpp or 0
	local target_meter = ''
	local spaces = target_hpp and math.floor(bar_width * (target_hpp / 100)) or 0
	while string.len(target_meter) < spaces do
		target_meter = target_meter..' '
	end
	local cm = target and targetColor(target) or color.target.pc_other
	local ct = text_color
	target_hpp = string.format("%3s", target_hpp)
	local text = target_hpp..'% '..target_name..(show_target_index and ' ('..target_index..')' or '')
	local target_status = show_action_status_indicators and target and current_actions[target.id] and current_actions[target.id].status or ''
	local target_action = target and current_actions[target.id] and current_actions[target.id].action or ''
	local text_target_action = show_target_action and '      '..target_status..target_action or ''

	if target and not (show_self_when_target == false and target.id == player.id) then
		if not inCS then

			-- fix the pad issue when 0
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
		bars_text_shdw_target_action:text(text_target_action:text_strip_format()) --strip out the custom coloring of the spells
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

--Update the HP BAR
local function updateHP()

	local player = windower.ffxi.get_player()
	local hp = player.vitals.hp
	local max_hp = player.vitals.max_hp
	local hpp = player.vitals.hpp
	local hp_meter = ''
	local spaces = math.floor(bar_width * (hpp / 100))
	local c = color.hp

	-- fix the pad issue when 0
	if spaces == 0 then
		bars_meter_hp:bg_alpha(0)
	else
		bars_meter_hp:bg_alpha(bg_alpha)
		while string.len(hp_meter) < spaces do
			hp_meter = hp_meter..' '
		end
	end

	-- add the max hp to the right-side of the bar
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

	-- set the color for the bar based on hp percentage
	if hpp >= 75 then
		c = text_color
	elseif hpp >= 50 then
		c = color.hp.quarter_3
	elseif hpp >= 25 then
		c = color.hp.quarter_2
	elseif hpp >= 0 then
		c = color.hp.quarter_1
	end

	local text = 'HP: \\cs('..c.r..','..c.g..','..c.b..')'..hp..'\\cr'..max_hp
	local text_shdw = 'HP: '..hp..max_hp

	bars_meter_hp:text(hp_meter)
	bars_text_shdw_hp:text(text_shdw)
	bars_text_hp:text(text)

end

--Update the MP BAR
local function updateMP()

	local player = windower.ffxi.get_player()
	local mp = player.vitals.mp
	local max_mp = player.vitals.max_mp
	local mpp = player.vitals.mpp
	local mp_meter = ''
	local spaces = math.floor(bar_width * (mpp / 100))
	local c = color.mp

	-- fix the pad issue when 0
	if spaces == 0 then
		bars_meter_mp:bg_alpha(0)
	else
		bars_meter_mp:bg_alpha(bg_alpha)
		while string.len(mp_meter) < spaces do
			mp_meter = mp_meter..' '
		end
	end

	-- set the color for the bar based on mp percentage
	if mpp >= 75 then
		c = text_color
	elseif mpp >= 50 then
		c = color.mp.quarter_3
	elseif mpp >= 25 then
		c = color.mp.quarter_2
	elseif mpp >= 0 then
		c = color.mp.quarter_1
	end

	-- add the max mp to the right-side of the bar
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

	local text = 'MP: \\cs('..c.r..','..c.g..','..c.b..')'..mp..'\\cr'..max_mp
	local text_shdw = 'MP: '..mp..max_mp

	bars_meter_mp:text(mp_meter)
	bars_text_shdw_mp:text(text_shdw)
	bars_text_mp:text(text)

end

local function updateTP()

	local player = windower.ffxi.get_player()
	local tp = player.vitals.tp
	local tp_meter = ''
	local spaces = 0
	spaces = math.floor(bar_width * (tp / 3000))
	while string.len(tp_meter) < spaces do
		tp_meter = tp_meter..' '
	end
	local ct = text_color

	-- fix the pad issue when 0
	if spaces == 0 then
		bars_meter_tp:bg_alpha(0)

	else
		bars_meter_tp:bg_alpha(bg_alpha)

		-- set the color for the bar based on tp percentage
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

	local text = 'TP: \\cs('..ct.r..','..ct.g..','..ct.b..')'..tp..'\\cr'
	local text_shdw = 'TP: '..tp

	bars_text_shdw_tp:text(text_shdw)
	bars_text_tp:text(text)
	bars_meter_tp:text(tp_meter)

end

--Update the Pet BAR
local function updatePet()

	local pet = windower.ffxi.get_mob_by_target('pet')
	local hpp = pet and pet.hpp or 0
	local pet_meter = ''
	local spaces = math.floor(bar_width * (hpp / 100))
	local c = color.hp

	local pet_name = pet and 'Pet' or 'No Pet'
	if job == 'bst' then pet_name = pet and pet.name or 'No Pet' end
	if job == 'drg' then pet_name = pet and pet.name or 'No Wyvern' end
	if job == 'geo' then pet_name = pet and 'Luopan' or 'No Luopan' end
	if job == 'pup' then pet_name = pet and pet.name or 'No Automaton' end
	if job == 'smn' then pet_name = pet and pet.name or 'No Avatar' end

	-- fix the pad issue when 0
	if spaces == 0 then
		bars_meter_pet:bg_alpha(0)
	else
		bars_meter_pet:bg_alpha(bg_alpha)
		while string.len(pet_meter) < spaces do
			pet_meter = pet_meter..' '
		end
	end

	-- set the color for the bar based on hp percentage
	if hpp >= 75 then
		c = text_color
	elseif hpp >= 50 then
		c = color.hp.quarter_3
	elseif hpp >= 25 then
		c = color.hp.quarter_2
	elseif hpp >= 0 then
		c = color.hp.quarter_1
	end

	local text = pet_name..(pet and ': \\cs('..c.r..','..c.g..','..c.b..')'..hpp..'%\\cr' or '')
	local text_shdw = pet_name..(pet and ': '..hpp..'%' or '')

	bars_meter_pet:text(pet_meter)
	bars_text_shdw_pet:text(text_shdw)
	bars_text_pet:text(text)

end

-- List the contents of the auto_focus_target_list
function listAutoFocusTargets()
	local sortedTargets = {}

	windower.add_to_chat(220,'[Bars] '..('Auto Focus Targets: '):color(8))

	-- Copy targets and sort them alphabetically
	for target in pairs(auto_focus_target_list) do
		table.insert(sortedTargets, target)
	end
	table.sort(sortedTargets)

	-- Check if sortedTargets is empty
	if next(sortedTargets) == nil then
		windower.add_to_chat(1,(' - '):color(8)..'[Empty]')
	end

	-- Add sorted targets to chat
	for _, target in ipairs(sortedTargets) do
		windower.add_to_chat(1,(' - '):color(8)..convertToDisplay(target))
	end

end

-- Check for matching focus targets
function checkForFocusTarget()

	local target = windower.ffxi.get_mob_by_target('t') or nil
	local nearby = nil

	for i,v in pairs(windower.ffxi.get_mob_array()) do -- loop through all the mobs in memory (nearby)

		local distance = math.floor(v.distance:sqrt() * 100) / 100

		-- does an id nearby match an entry in our auto focus target list?
		if auto_focus_target_list[convertToSave(v.id)] and v.valid_target and distance <= tonumber(focus_target_max_distance) then

			nearby = windower.ffxi.get_mob_by_id(v.id)

			if hide_focus_target_when_target and target and nearby and target.id == nearby.id then
				nearby = nil
			end

		-- does a name nearby match an entry in our auto focus target list?
		elseif auto_focus_target_list[convertToSave(v.name)] and v.valid_target and distance <= tonumber(focus_target_max_distance) then

			nearby = windower.ffxi.get_mob_by_name(v.name)

			if hide_focus_target_when_target and target and nearby and target.id == nearby.id then
				nearby = nil
			end

		end
	end

	-- update focus_target if its new, will remove/nil if nothing in the auto_focus_target_list
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
	updateHP()
end)
windower.register_event('hpp change', function()
	updateHP()
end)
windower.register_event('hpmax change', function()
	updateHP()
end)

--MP Changing
windower.register_event('mp change', function()
	updateMP()
end)
windower.register_event('mpp change', function()
	updateMP()
end)
windower.register_event('mpmax change', function()
	updateMP()
end)

--TP Changing
windower.register_event('tp change', function()
	updateTP()
end)

local function initialize()
	setJob()
	setWidth()
	setPosition()
	showBars()
	updateTarget()
	updateHP()
	updateMP()
	updateTP()
	-- wait a sec then repeat since values are 0 when first logging into a character
	coroutine.sleep(1)
	updateHP()
	updateMP()
	updateTP()
end

-- Load
windower.register_event('load', function()
	if windower.ffxi.get_info().logged_in then
		initialize()
	end
end)

-- Login
windower.register_event('login', function()
	initialize()
end)

windower.register_event('status change', function(status)
	
	if status == 4 and not inCS then --In a cutscene: Hide the bars
		inCS = true
		hideBars()
	elseif status ~= 4 and inCS then --Out of cutscene: Show the bars
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

	if show_bars[job].pet then
		updatePet()
	end

	-- Hide while zoning
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
	local action_target_name = ''

	-- Action failed/interrupted
	if act.param == 28787 then

		local target_action_status_indicator = '\\cs(255,050,050)×\\cr'
		updateActionStatus(act.actor_id,target_action_status_indicator)
		coroutine.sleep(2.5)
		removeFromActionsTable(act.actor_id)
		return

	end

	-- Begin weapon skill(7), TP move(7), or spell(8), or item(9)
	if action_id and (act.category == 7 or act.category == 8 or act.category == 9) then

		local target_action = ''
		local target_action_status_indicator = '\\cs(245,164,066)≈\\cr'

		-- Weapon skill or TP move
		if act.category == 7 then

			local ct = targetColor(action_target)
			action_target_name = (action_target_id and action_target_id ~= act.actor_id) and ' → \\cs('..ct.r..','..ct.g..','..ct.b..')'..action_target.name..'\\cr' or ''

			if actor and isPlayer(actor.id) then
				action_name = ' '..res.weapon_skills[action_id].name
			elseif act.targets[1].actions[1].param == nil then
				return
			else
				action_name = res.monster_abilities[action_id] and ' '..res.monster_abilities[action_id].name or ' '..res.weapon_skills[action_id].name
			end

		-- Spell
		elseif act.category == 8 then

			local element = res.spells[action_id].element
			local ca = element_colors[element]
			local ct = targetColor(action_target)
			action_name = ' \\cs('..ca.r..','..ca.g..','..ca.b..')'..res.spells[action_id].name..'\\cr'
			action_target_name = action_target_id and ' → \\cs('..ct.r..','..ct.g..','..ct.b..')'..action_target.name..'\\cr' or ''

		-- Item
		elseif act.category == 9 then

			local item_id = act.targets[1].actions[1].param
			local item_name = res.items[item_id].name
			local ct = targetColor(action_target)
			action_name = ' '..item_name
			action_target_name = action_target_id and ' → \\cs('..ct.r..','..ct.g..','..ct.b..')'..windower.ffxi.get_mob_by_id(action_target_id).name..'\\cr' or ''

		end

		target_action = action_name..action_target_name

		if (show_self_action and player.id == act.actor_id) or show_target_action then
			addToActionsTable(act.actor_id,target_action,target_action_status_indicator)
		end

	-- Finish weapon skill(3), spell(4), item(5), or TP move(11)
	elseif act.category == 3 or act.category == 4 or act.category == 5 or act.category == 11 then

		target_action_status_indicator = '\\cs(050,255,050)√\\cr'
		updateActionStatus(act.actor_id,target_action_status_indicator)

		-- Items can be spammed fast and gets weird if the delay is too long
		if act.category == 5 then

			coroutine.sleep(1)
			removeFromActionsTable(act.actor_id)

		elseif act.param ~= nil then

			coroutine.sleep(2.5)
			removeFromActionsTable(act.actor_id)

		end

	end
end)

-- Unrecognized command
function displayUnregnizedCommand()
	windower.add_to_chat(39,('[Bars] '):color(220)..('Unrecognized command. Type'):color(39)..(' //bars help'):color(1)..(' if you need help.'):color(39))
end

windower.register_event('addon command',function(addcmd, ...)

	-- Update the bar position
	if addcmd == 'pos' or addcmd == 'position' then
		local pos = {...}

		-- If there are not enough parameters then output the current position and remind how to update
		if #pos < 2 then
			windower.add_to_chat(8,('[Bars] '):color(220)..('Position:'):color(36)..(' '..settings.pos.x..' '..settings.pos.y):color(200))
			windower.add_to_chat(8,('[Bars] '):color(220)..('Update by adding X and Y coordinates (ex. '):color(8)..(' //bars pos 100 200'):color(1)..(')'):color(8))

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
				windower.add_to_chat(8,('[Bars] '):color(220)..('Position:'):color(36)..(' '..settings.pos.x..' '..settings.pos.y):color(200))
				setPosition()

			end
		end

	-- Update the bar width
	elseif addcmd == 'width' or addcmd == 'w' then
		local width = {...}
		local new_width = nil

		-- If there are no parameters then output the current bar width and remind how to update
		if #width < 1 then
			windower.add_to_chat(220,'[Bars] '..('Width:'):color(36)..(' '..settings.options.bar_width):color(200))
			windower.add_to_chat(220,'[Bars] '..('Update by adding a number (ex.'):color(8)..(' //bars width 73'):color(1)..(')'):color(8))

		-- Size number is provided
		else
			-- Take the provided string parameter and turn it into a number
			new_width = tonumber(width[1])
					
			-- Save the new setting, update the width, then alert the user
			if new_width == nil then
				displayUnregnizedCommand()

			else
				settings.options.bar_width = new_width
				settings:save('all')
				windower.add_to_chat(220,'[Bars] '..('Width:'):color(36)..(' '..settings.options.bar_width):color(200))
				hideBars()
				setWidth()
				updateHP()
				updateMP()
				updateTP()
				showBars()

			end
		end

	-- Toggle the HP bar display setting for the current job
	elseif addcmd == 'hp' then

		settings.options.show_bars[job].hp = not settings.options.show_bars[job].hp
		settings:save('all')
		hideBars()
		setPosition()
		showBars()
		windower.add_to_chat(220,'[Bars] '..('HP bar display for '..uppercase(job)..':'):color(36)..(' %s':format(settings.options.show_bars[job].hp and 'ON' or 'OFF')):color(200))

	-- Toggle the MP bar display setting for the current job
	elseif addcmd == 'mp' then

		settings.options.show_bars[job].mp = not settings.options.show_bars[job].mp
		settings:save('all')
		hideBars()
		setPosition()
		showBars()
		windower.add_to_chat(220,'[Bars] '..('MP bar display for '..uppercase(job)..':'):color(36)..(' %s':format(settings.options.show_bars[job].mp and 'ON' or 'OFF')):color(200))

	-- Toggle the TP bar display setting for the current job
	elseif addcmd == 'tp' then

		settings.options.show_bars[job].tp = not settings.options.show_bars[job].tp
		settings:save('all')
		hideBars()
		setPosition()
		showBars()
		windower.add_to_chat(220,'[Bars] '..('TP bar display for '..uppercase(job)..':'):color(36)..(' %s':format(settings.options.show_bars[job].tp and 'ON' or 'OFF')):color(200))

	-- Toggle the Pet bar display setting for the current job
	elseif addcmd == 'pet' then

		settings.options.show_bars[job].pet = not settings.options.show_bars[job].pet
		settings:save('all')
		hideBars()
		setPosition()
		showBars()
		windower.add_to_chat(220,'[Bars] '..('Pet bar display for '..uppercase(job)..':'):color(36)..(' %s':format(settings.options.show_bars[job].pet and 'ON' or 'OFF')):color(200))

	-- Update the vertical offset for the current job
	elseif addcmd == 'offset' or addcmd == 'o' then
		local offset = {...}
		local new_offset = nil
		
		-- If there are no parameters then output the current offset and remind how to update
		if #offset < 1 then
			windower.add_to_chat(220,'[Bars] '..('Vertical Offset for '..uppercase(job)..':'):color(36)..(' '..show_bars[job].vertical_offset):color(200))
			windower.add_to_chat(220,'[Bars] '..('Update by adding a number (ex.'):color(8)..(' //bars offset 29'):color(1)..(')'):color(8))

		-- Size number is provided
		else
			-- Take the provided string parameter and turn it into a number
			new_offset = tonumber(offset[1])
					
			-- Save the new setting, update the offset, then alert the user
			if new_offset == nil then
				displayUnregnizedCommand()

			else
				show_bars[job].vertical_offset = new_offset
				settings:save('all')
				windower.add_to_chat(220,'[Bars] '..('Vertical Offset for '..uppercase(job)..':'):color(36)..(' '..show_bars[job].vertical_offset):color(200))
				hideBars()
				setPosition()
				showBars()

			end
		end

	-- Update the size
	elseif addcmd == 'size' or addcmd == 's' then
		local size = {...}
		local new_size = nil
		
		-- If there are no parameters then output the current size and remind how to update
		if #size < 1 then
			windower.add_to_chat(220,'[Bars] '..('Size:'):color(36)..(' '..settings.text.size):color(200))
			windower.add_to_chat(220,'[Bars] '..('Update by adding a number (ex.'):color(8)..(' //bars size 10'):color(1)..(')'):color(8))

		-- Size number is provided
		else
			-- Take the provided string parameter and turn it into a number
			new_size = tonumber(size[1])
					
			-- Save the new setting, update the size, then alert the user
			if new_size == nil then
				displayUnregnizedCommand()

			else
				settings.text.size = new_size
				settings:save('all')
				windower.add_to_chat(220,'[Bars] '..('Size:'):color(36)..(' '..settings.text.size):color(200))
				setSize()

			end
		end

	-- Toggle the markers setting
	elseif addcmd == 'marker' or addcmd == 'markers' or addcmd == 'm' then

		settings.options.show_bar_markers = not settings.options.show_bar_markers
		settings:save('all')
		windower.add_to_chat(220,'[Bars] '..('Markers:'):color(36)..(' %s':format(settings.options.show_bar_markers and 'ON' or 'OFF')):color(200))
		hideBars()
		setWidth()
		showBars()

	-- Toggle the index setting
	elseif addcmd == 'index' or addcmd == 'i' then

		settings.options.show_target_index = not settings.options.show_target_index
		show_target_index = settings.options.show_target_index
		settings:save('all')
		windower.add_to_chat(220,'[Bars] '..('Index:'):color(36)..(' %s':format(settings.options.show_target_index and 'ON' or 'OFF')):color(200))
		updateTarget()

	-- Toggle the bold setting
	elseif addcmd == 'bold' or addcmd == 'b' then

		settings.flags.bold = not settings.flags.bold
		settings:save('all')
		windower.add_to_chat(220,'[Bars] '..('Bold:'):color(36)..(' %s':format(settings.flags.bold and 'ON' or 'OFF')):color(200))
		setBold()

	-- Add a target to the Auto Focus Target list
	elseif addcmd == 'add' or addcmd == 'a' then

		local target = {...}

		if target == nil then
			windower.add_to_chat(39,('[Bars] '):color(220)..('Please specify a target to be added (name or id).'):color(39))
			return
		end

		addToAutoFocusTargetList(target)

	-- Remove a target from the Auto Focus Target lsit
	elseif addcmd == 'remove' or addcmd == 'rem' or addcmd == 'rmv' or addcmd == 'r' then

		local target = {...}

		if target == nil then
			windower.add_to_chat(220,'[Bars] '..('Please specify a target to be removed.'):color(39))
			return
		end

		removeFromAutoFocusTargetList(target)

	-- Display the Auto Focus Target list
	elseif addcmd == 'list' or addcmd == 'l' then

		listAutoFocusTargets()

	-- Display help text
	elseif addcmd == 'help' then

		local currPos = settings.pos
		local currHP = settings.options.show_bars[job].hp
		local currMP = settings.options.show_bars[job].mp
		local currTP = settings.options.show_bars[job].tp
		local currPet = settings.options.show_bars[job].pet
		local currWidth = settings.options.bar_width
		local currMarker = settings.options.show_bar_markers
		local currIndex = settings.options.show_target_index
		local currJob = uppercase(job)
		local currOffset = settings.options.show_bars[job].vertical_offset
		local currSize = settings.text.size
		local currBold = settings.flags.bold

		windower.add_to_chat(220,'[Bars] '..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..('Key (Keylesta@Valefor)'):color(220))
		windower.add_to_chat(220,' ')
		windower.add_to_chat(220,' Commands '..('[optional]'):color(53)..(' <required>'):color(2))
		windower.add_to_chat(36,'   pos '..('[x y]'):color(53)..(' - Update position. ['):color(8)..(currPos.x..' '..currPos.y):color(200)..(']'):color(8))
		windower.add_to_chat(36,'   hp/mp/tp/pet'..(' - Toggle HP/MP/TP/Pet bar display setting for current job.'):color(8))
		windower.add_to_chat(36,'   '..(' ['..currJob..' - HP: '):color(8)..('%s':format(currHP and 'ON' or 'OFF')):color(200)..(' MP: '):color(8)..('%s':format(currMP and 'ON' or 'OFF')):color(200)..(' TP: '):color(8)..('%s':format(currTP and 'ON' or 'OFF')):color(200)..(' Pet: '):color(8)..('%s':format(currPet and 'ON' or 'OFF')):color(200)..(']'):color(8))
		windower.add_to_chat(36,'   width/w '..('[#]'):color(53)..(' - Update the bar width. ['):color(8)..(''..currWidth):color(200)..(']'):color(8))
		windower.add_to_chat(36,'   marker/m '..(' - Toggle the Marker option. ['):color(8)..('%s':format(currMarker and 'ON' or 'OFF')):color(200)..(']'):color(8))
		windower.add_to_chat(36,'   index/i '..(' - Toggle the Index option. ['):color(8)..('%s':format(currIndex and 'ON' or 'OFF')):color(200)..(']'):color(8))
		windower.add_to_chat(36,'   offset/o '..('[#]'):color(53)..(' - Update the vertical offset for the current job. ['..currJob..' - '):color(8)..(''..currOffset):color(200)..(']'):color(8))
		windower.add_to_chat(36,'   add/a '..('<target>'):color(2)..(' - Add a target to the Auto Focus Target list.'):color(8))
		windower.add_to_chat(36,'   '..(' - Valid targets: Names (ex: Oseem), IDs (ex: 17809550).'):color(8))
		windower.add_to_chat(36,'   '..(' - Use quotes to surround names with spaces.'):color(8))
		windower.add_to_chat(36,'   remove/r '..('<target>'):color(2)..(' - Remove a target from the Auto Focus Target list.'):color(8))
		windower.add_to_chat(36,'   list/l'..(' - Show the Auto Focus Target list.'):color(8))
		windower.add_to_chat(36,'   size/s '..('[#]':color(53))..(' - Update font size. ['):color(8)..(''..currSize):color(200)..(']'):color(8))
		windower.add_to_chat(36,'   bold/b'..(' - Toggle the bold setting. ['):color(8)..('%s':format(currBold and 'ON' or 'OFF')):color(200)..(']'):color(8))

	else

		displayUnregnizedCommand()

	end
end)
