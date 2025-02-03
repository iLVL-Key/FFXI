--Copyright (c) 2025, Key
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
_addon.version = '3.2'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'bars'}

config = require('config')
texts = require('texts')
res = require('resources')
packets = require('packets')
require 'chat'

defaults = {
	pos = {x = 200, y = 200},
	bg = {alpha = 190, red = 0, green = 0, blue = 0},
	text = {alpha = 255, blue = 255, green = 255, red = 255, font = 'Consolas', size = 10},
	flags = {draggable = false, italic = false, bold = true, right = false, bottom = false},
	auto_focus_target_list = {
		aurix = true,
		dealan__dash__dhe = true,
		sgili = true,
		u_bnai = true,
		gogmagog = true,
		aristaeus = true,
		raskovniche = true,
		marmorkrebs = true,
		gigelorum = true,
		procne = true,
		henwen = true,
		xevioso = true,
		ngai = true,
		kalunga = true,
		ongo = true,
		mboze = true,
		arebati = true,
		bumba = true,
		glassy_craver = true,
		glassy_gorger = true,
		glassy_thinker = true,
		fu = true,
		kyou = true,
		kei = true,
		gin = true,
		kin = true,
		ou = true,
		abject_obdella = true,
		biune_porxie = true,
		cachaemic_bhoot = true,
		demisang_deleterious = true,
		esurient_botulus = true,
		fetid_ixion = true,
		gyvewrapped_naraka = true,
		haughty_tulittia = true,
		ghatjot = true,
		leshonn = true,
		skomora = true,
		degei = true,
		dhartok = true,
		gartell = true,
		triboulex = true,
		aita = true,
		aminon = true,
		palloritus = true,
		plouton = true,
		putraxia = true,
		perfidien = true,
		rancibus = true,
		azi_dahaka = true,
		naga_raja = true,
		quetzalcoatl = true,
		mireu = true,
	},
	options = {
		abbreviate_common_mob_names = true,
		bar_width = 100,
		bars_vertical_spacing = {target_to_focus_target = -40, target_to_player_stats = 45, between_player_stats = 23},
		char_width_multiplier = 0.77,
		clear_action_delay = 5.5,
		color_spells = true,
		condense_target_and_subtarget_bars = false,
		fade_after_delay = true,
		fade_delay = 60,
		fade_multiplier = 2,
		fade_to_alpha = 0,
		focus_target_max_distance = 40,
		hide_focus_target_when_target = true,
		highlight_when_sp_active = true,
		max_action_length = 17,
		max_name_length = 20,
		remove_tachi_blade_from_ws_name = true,
		self_action_text_size_difference = 1,
		short_skillchain_names = true,
		show_action_status_indicators = true,
		show_bar_markers = true,
		show_commas_on_numbers = true,
		show_dyna_jobs = true,
		show_fancy_rolls = true,
		show_max_hp_mp_on_bar = true,
		show_pet_distance = true,
		show_result_totals = true,
		show_roll_lucky_info = true,
		show_self_action = true,
		show_self_when_targeted = false,
		show_st_when_target = false,
		show_target_action = true,
		show_target_action_result = true,
		show_target_distance = true,
		show_target_hex = false,
		show_target_index = false,
		target_action_text_size_difference = 1,
		target_text_size_difference = 4,
		text_vertical_offset = -8,
		z_show_player_stat_bars = {
			brd = {hp = false, mp = false, pet = false, tp = false, vertical_offset = 0},
			blm = {hp = false, mp = false, pet = false, tp = false, vertical_offset = 0},
			blu = {hp = false, mp = false, pet = false, tp = false, vertical_offset = 0},
			bst = {hp = false, mp = false, pet = true, tp = false, vertical_offset = 0},
			cor = {hp = false, mp = false, pet = false, tp = false, vertical_offset = 0},
			dnc = {hp = false, mp = false, pet = false, tp = false, vertical_offset = 0},
			drg = {hp = false, mp = false, pet = true, tp = false, vertical_offset = 0},
			drk = {hp = false, mp = false, pet = false, tp = false, vertical_offset = 0},
			geo = {hp = false, mp = false, pet = true, tp = false, vertical_offset = 0},
			mnk = {hp = false, mp = false, pet = false, tp = false, vertical_offset = 0},
			nin = {hp = false, mp = false, pet = false, tp = false, vertical_offset = 0},
			pld = {hp = false, mp = false, pet = false, tp = false, vertical_offset = 0},
			pup = {hp = false, mp = false, pet = true, tp = false, vertical_offset = 0},
			rdm = {hp = false, mp = false, pet = false, tp = false, vertical_offset = 0},
			rng = {hp = false, mp = false, pet = false, tp = false, vertical_offset = 0},
			run = {hp = false, mp = false, pet = false, tp = false, vertical_offset = 0},
			sam = {hp = false, mp = false, pet = false, tp = false, vertical_offset = 0},
			sch = {hp = false, mp = false, pet = false, tp = false, vertical_offset = 0},
			smn = {hp = false, mp = false, pet = true, tp = false, vertical_offset = 0},
			thf = {hp = false, mp = false, pet = false, tp = false, vertical_offset = 0},
			war = {hp = false, mp = false, pet = false, tp = false, vertical_offset = 0},
			whm = {hp = false, mp = false, pet = false, tp = false, vertical_offset = 0},
		},
	},
	colors = {
		target = {
			monster_passive = {r = 247, g = 237, b = 141},
			monster_claimed_party = {r = 255, g = 50, b = 50},
			monster_claimed_alliance = {r = 255, g = 92, b = 114},
			monster_claimed_other = {r = 211, g = 107, b = 211},
			npc = {r = 140, g = 227, b = 132},
			pc_alliance = {r = 158, g = 226, b = 255},
			pc_other = {r = 255, g = 255, b = 255},
			pc_party = {r = 69, g = 199, b = 255},
			pc_self = {r = 66, g = 135, b = 245},
			sp_active_glow = {a = 75, r = 255, g = 225, b = 75},
		},
		self = {
			bar = {r = 240, g = 240, b = 240},
		},
		hp = {
			bar = {r = 240, g = 128, b = 131},
			quarter_1 = {r = 255, g = 77, b = 77},
			quarter_2 = {r = 255, g = 139, b = 56},
			quarter_3 = {r = 230, g = 255, b = 117},
		},
		mp = {
			bar = {r = 189, g = 192, b = 122},
			quarter_1 = {r = 255, g = 77, b = 77},
			quarter_2 = {r = 255, g = 139, b = 56},
			quarter_3 = {r = 230, g = 255, b = 117},
		},
		pet = {
			bar = {r = 200, g = 75, b = 255},
			quarter_1 = {r = 255, g = 77, b = 77},
			quarter_2 = {r = 255, g = 139, b = 56},
			quarter_3 = {r = 230, g = 255, b = 117},
		},
		tp = {
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
			eleven = {r = 255, g = 255, b = 50},
			lucky = {r = 50, g = 255, b = 50},
			total = {r = 30, g = 144, b = 255},
			unlucky = {r = 255, g = 50, b = 50},
		},
		result = {
			heal = {r = 140, g = 235, b = 255},
			damage = {r = 255, g = 200, b = 200},
		},
	},
}

settings = config.load(defaults)

local abbreviate_common_mob_names = settings.options.abbreviate_common_mob_names
local bar_width = settings.options.bar_width
local bars_vertical_spacing = settings.options.bars_vertical_spacing
local char_width_multiplier = settings.options.char_width_multiplier
local clear_action_delay = settings.options.clear_action_delay
local color_spells = settings.options.color_spells
local condense_target_and_subtarget_bars = settings.options.condense_target_and_subtarget_bars
local fade_after_delay = settings.options.fade_after_delay
local fade_delay = settings.options.fade_delay
local fade_multiplier = settings.options.fade_multiplier
local fade_to_alpha = settings.options.fade_to_alpha
local focus_target_max_distance = settings.options.focus_target_max_distance
local hide_focus_target_when_target = settings.options.hide_focus_target_when_target
local highlight_when_sp_active = settings.options.highlight_when_sp_active
local max_action_length = settings.options.max_action_length
local max_name_length = settings.options.max_name_length
local remove_tachi_blade_from_ws_name = settings.options.remove_tachi_blade_from_ws_name
local self_action_text_size_difference = settings.options.self_action_text_size_difference
local short_skillchain_names = settings.options.short_skillchain_names
local show_action_status_indicators = settings.options.show_action_status_indicators
local show_bar_markers = settings.options.show_bar_markers
local show_bars = settings.options.z_show_player_stat_bars
local show_commas_on_numbers = settings.options.show_commas_on_numbers
local show_dyna_jobs = settings.options.show_dyna_jobs
local show_fancy_rolls = settings.options.show_fancy_rolls
local show_max_hp_mp_on_bar = settings.options.show_max_hp_mp_on_bar
local show_pet_distance = settings.options.show_pet_distance
local show_result_totals = settings.options.show_result_totals
local show_roll_lucky_info = settings.options.show_roll_lucky_info
local show_self_action = settings.options.show_self_action
local show_self_when_targeted = settings.options.show_self_when_targeted
local show_st_when_target = settings.options.show_st_when_target
local show_target_action = settings.options.show_target_action
local show_target_action_result = settings.options.show_target_action_result
local show_target_distance = settings.options.show_target_distance
local show_target_hex = settings.options.show_target_hex
local show_target_index = settings.options.show_target_index
local target_action_text_size_difference = settings.options.target_action_text_size_difference
local target_text_size_difference = settings.options.target_text_size_difference
local text_vertical_offset = settings.options.text_vertical_offset

local auto_focus_target_list = settings.auto_focus_target_list
local bg_alpha = settings.bg.alpha
local color = settings.colors
local font = settings.text.font
local text_alpha = settings.text.alpha
local text_color = {r = settings.text.red, g = settings.text.green, b = settings.text.blue}

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

local cmd = windower.send_command
local get_mob_by_id = windower.ffxi.get_mob_by_id
local get_player = windower.ffxi.get_player
local add_to_chat = windower.add_to_chat
local get_mob_by_target = windower.ffxi.get_mob_by_target
local get_info = windower.ffxi.get_info

local inCS = false
local zoning = false
local job = ''
local current_actions = {}
local current_sp_actions = {}
local focus_target = nil
local focus_target_override = nil
local bars_bg_str = ''
local bars_bg_str_ft_st = ''
local bars_bg_str_hp = ''
local bars_bg_str_tp = ''
local index = 0
local Heartbeat = 0
local Fade = false
local bg_fade_num = settings.bg.alpha
local text_fade_num = settings.text.alpha
local screen_test = false
local screen_test_focus_target = {
	name = "Focus Target",
	hpp = 100,
	distance = 100,
	index = 12345,
}
local screen_test_sub_target = {
	name = "Sub Target",
	hpp = 100,
	distance = 100,
	index = 12345,
}
local screen_test_target = {
	name = "Target",
	hpp = 100,
	distance = 100,
	index = 12345,
}
local sp = settings.colors.target.sp_active_glow

--BACKGROUNDS

--Create the Focus Target BACKGROUND text object
local bars_bg_focus_target = texts.new()
bars_bg_focus_target:font(font)
bars_bg_focus_target:pad(-4)
bars_bg_focus_target:bg_alpha(bg_alpha)
bars_bg_focus_target:draggable(false)

--Create the Sub-Target BACKGROUND text object
local bars_bg_sub_target = texts.new()
bars_bg_sub_target:font(font)
bars_bg_sub_target:pad(-4)
bars_bg_sub_target:bg_alpha(bg_alpha)
bars_bg_sub_target:draggable(false)

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
bars_meter_focus_target:bg_alpha(text_alpha)
bars_meter_focus_target:draggable(false)

--Create the Sub-Target METER text object
local bars_meter_sub_target = texts.new()
bars_meter_sub_target:font(font)
bars_meter_sub_target:pad(-5)
bars_meter_sub_target:bg_alpha(text_alpha)
bars_meter_sub_target:draggable(false)

--Create the Target METER text object
local bars_meter_target = texts.new()
bars_meter_target:font(font)
bars_meter_target:pad(-5)
bars_meter_target:bg_alpha(text_alpha)
bars_meter_target:draggable(false)

--Create the Self Action METER text object
local bars_meter_self_action = texts.new()
bars_meter_self_action:font(font)
bars_meter_self_action:pad(-5)
bars_meter_self_action:bg_alpha(text_alpha)
bars_meter_self_action:bg_color(color.self.bar.r,color.self.bar.g,color.self.bar.b)
bars_meter_self_action:draggable(false)

--Create the HP METER text object
local bars_meter_hp = texts.new()
bars_meter_hp:font(font)
bars_meter_hp:pad(-5)
bars_meter_hp:bg_alpha(text_alpha)
bars_meter_hp:draggable(false)

--Create the MP METER text object
local bars_meter_mp = texts.new()
bars_meter_mp:font(font)
bars_meter_mp:pad(-5)
bars_meter_mp:bg_alpha(text_alpha)
bars_meter_mp:draggable(false)

--Create the TP METER text object
local bars_meter_tp = texts.new()
bars_meter_tp:font(font)
bars_meter_tp:pad(-5)
bars_meter_tp:bg_alpha(text_alpha)
bars_meter_tp:draggable(false)

--Create the Pet METER text object
local bars_meter_pet = texts.new()
bars_meter_pet:font(font)
bars_meter_pet:pad(-5)
bars_meter_pet:bg_alpha(text_alpha)
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
bars_text_shdw_focus_target:alpha(text_alpha)
bars_text_shdw_focus_target:bg_alpha(0)
bars_text_shdw_focus_target:draggable(false)

--Create the Focus Target Action TEXT SHADOW text object
local bars_text_shdw_focus_target_action = texts.new()
bars_text_shdw_focus_target_action:font(font)
bars_text_shdw_focus_target_action:color(0,0,0)
bars_text_shdw_focus_target_action:alpha(text_alpha)
bars_text_shdw_focus_target_action:bg_alpha(0)
bars_text_shdw_focus_target_action:draggable(false)

--Create the Sub-Target TEXT SHADOW text object
local bars_text_shdw_sub_target = texts.new()
bars_text_shdw_sub_target:font(font)
bars_text_shdw_sub_target:color(0,0,0)
bars_text_shdw_sub_target:alpha(text_alpha)
bars_text_shdw_sub_target:bg_alpha(0)
bars_text_shdw_sub_target:draggable(false)

--Create the Sub-Target Action TEXT SHADOW text object
local bars_text_shdw_sub_target_action = texts.new()
bars_text_shdw_sub_target_action:font(font)
bars_text_shdw_sub_target_action:color(0,0,0)
bars_text_shdw_sub_target_action:alpha(text_alpha)
bars_text_shdw_sub_target_action:bg_alpha(0)
bars_text_shdw_sub_target_action:draggable(false)

--Create the Target TEXT SHADOW text object
local bars_text_shdw_target = texts.new()
bars_text_shdw_target:font(font)
bars_text_shdw_target:color(0,0,0)
bars_text_shdw_target:alpha(text_alpha)
bars_text_shdw_target:bg_alpha(0)
bars_text_shdw_target:draggable(false)

--Create the Target Action TEXT SHADOW text object
local bars_text_shdw_target_action = texts.new()
bars_text_shdw_target_action:font(font)
bars_text_shdw_target_action:color(0,0,0)
bars_text_shdw_target_action:alpha(text_alpha)
bars_text_shdw_target_action:bg_alpha(0)
bars_text_shdw_target_action:draggable(false)

--Create the Self Action TEXT SHADOW text object
local bars_text_shdw_self_action = texts.new()
bars_text_shdw_self_action:font(font)
bars_text_shdw_self_action:color(0,0,0)
bars_text_shdw_self_action:alpha(text_alpha)
bars_text_shdw_self_action:bg_alpha(0)
bars_text_shdw_self_action:draggable(false)

--Create the HP TEXT SHADOW text object
local bars_text_shdw_hp = texts.new()
bars_text_shdw_hp:font(font)
bars_text_shdw_hp:color(0,0,0)
bars_text_shdw_hp:alpha(text_alpha)
bars_text_shdw_hp:bg_alpha(0)
bars_text_shdw_hp:draggable(false)

--Create the MP TEXT SHADOW text object
local bars_text_shdw_mp = texts.new()
bars_text_shdw_mp:font(font)
bars_text_shdw_mp:color(0,0,0)
bars_text_shdw_mp:alpha(text_alpha)
bars_text_shdw_mp:bg_alpha(0)
bars_text_shdw_mp:draggable(false)

--Create the TP TEXT SHADOW text object
local bars_text_shdw_tp = texts.new()
bars_text_shdw_tp:font(font)
bars_text_shdw_tp:color(0,0,0)
bars_text_shdw_tp:alpha(text_alpha)
bars_text_shdw_tp:bg_alpha(0)
bars_text_shdw_tp:draggable(false)

--Create the Pet TEXT SHADOW text object
local bars_text_shdw_pet = texts.new()
bars_text_shdw_pet:font(font)
bars_text_shdw_pet:color(0,0,0)
bars_text_shdw_pet:alpha(text_alpha)
bars_text_shdw_pet:bg_alpha(0)
bars_text_shdw_pet:draggable(false)

--TEXT

--Create the Focus Target TEXT text object
local bars_text_focus_target = texts.new()
bars_text_focus_target:font(font)
bars_text_focus_target:color(text_color.r,text_color.g,text_color.b)
bars_text_focus_target:alpha(text_alpha)
bars_text_focus_target:bg_alpha(0)
bars_text_focus_target:draggable(false)
bars_text_focus_target:stroke_color(sp.r,sp.g,sp.b)
bars_text_focus_target:stroke_alpha(0)
bars_text_focus_target:stroke_width(2.5)

--Create the Focus Target Action TEXT text object
local bars_text_focus_target_action = texts.new()
bars_text_focus_target_action:font(font)
bars_text_focus_target_action:color(text_color.r,text_color.g,text_color.b)
bars_text_focus_target_action:alpha(text_alpha)
bars_text_focus_target_action:bg_alpha(0)
bars_text_focus_target_action:draggable(false)

--Create the Sub-Target TEXT text object
local bars_text_sub_target = texts.new()
bars_text_sub_target:font(font)
bars_text_sub_target:color(text_color.r,text_color.g,text_color.b)
bars_text_sub_target:alpha(text_alpha)
bars_text_sub_target:bg_alpha(0)
bars_text_sub_target:draggable(false)
bars_text_sub_target:stroke_color(sp.r,sp.g,sp.b)
bars_text_sub_target:stroke_alpha(0)
bars_text_sub_target:stroke_width(2.5)

--Create the Sub-Target Action TEXT text object
local bars_text_sub_target_action = texts.new()
bars_text_sub_target_action:font(font)
bars_text_sub_target_action:color(text_color.r,text_color.g,text_color.b)
bars_text_sub_target_action:alpha(text_alpha)
bars_text_sub_target_action:bg_alpha(0)
bars_text_sub_target_action:draggable(false)

--Create the Target TEXT text object
local bars_text_target = texts.new()
bars_text_target:font(font)
bars_text_target:color(text_color.r,text_color.g,text_color.b)
bars_text_target:alpha(text_alpha)
bars_text_target:bg_alpha(0)
bars_text_target:draggable(false)
bars_text_target:stroke_color(sp.r,sp.g,sp.b)
bars_text_target:stroke_alpha(0)
bars_text_target:stroke_width(2.5)

--Create the Target Action TEXT text object
local bars_text_target_action = texts.new()
bars_text_target_action:font(font)
bars_text_target_action:color(text_color.r,text_color.g,text_color.b)
bars_text_target_action:alpha(text_alpha)
bars_text_target_action:bg_alpha(0)
bars_text_target_action:draggable(false)

--Create the Self Action TEXT text object
local bars_text_self_action = texts.new()
bars_text_self_action:font(font)
bars_text_self_action:color(text_color.r,text_color.g,text_color.b)
bars_text_self_action:alpha(text_alpha)
bars_text_self_action:bg_alpha(0)
bars_text_self_action:draggable(false)

--Create the HP TEXT text object
local bars_text_hp = texts.new()
bars_text_hp:font(font)
bars_text_hp:color(text_color.r,text_color.g,text_color.b)
bars_text_hp:alpha(text_alpha)
bars_text_hp:bg_alpha(0)
bars_text_hp:draggable(false)

--Create the MP TEXT text object
local bars_text_mp = texts.new()
bars_text_mp:font(font)
bars_text_mp:color(text_color.r,text_color.g,text_color.b)
bars_text_mp:alpha(text_alpha)
bars_text_mp:bg_alpha(0)
bars_text_mp:draggable(false)

--Create the TP TEXT text object
local bars_text_tp = texts.new()
bars_text_tp:font(font)
bars_text_tp:color(text_color.r,text_color.g,text_color.b)
bars_text_tp:alpha(text_alpha)
bars_text_tp:bg_alpha(0)
bars_text_tp:draggable(false)

--Create the Pet TEXT text object
local bars_text_pet = texts.new()
bars_text_pet:font(font)
bars_text_pet:color(text_color.r,text_color.g,text_color.b)
bars_text_pet:alpha(text_alpha)
bars_text_pet:bg_alpha(0)
bars_text_pet:draggable(false)

--Destroy all the text objects when we unload the addon
windower.register_event('unload', function()

	bars_bg_focus_target:destroy()
	bars_bg_sub_target:destroy()
	bars_bg_target:destroy()
	bars_bg_self_action:destroy()
	bars_bg_hp:destroy()
	bars_bg_mp:destroy()
	bars_bg_tp:destroy()
	bars_bg_pet:destroy()
	bars_meter_focus_target:destroy()
	bars_meter_sub_target:destroy()
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
	bars_text_shdw_sub_target:destroy()
	bars_text_shdw_sub_target_action:destroy()
	bars_text_shdw_target:destroy()
	bars_text_shdw_target_action:destroy()
	bars_text_shdw_self_action:destroy()
	bars_text_shdw_hp:destroy()
	bars_text_shdw_mp:destroy()
	bars_text_shdw_tp:destroy()
	bars_text_shdw_pet:destroy()
	bars_text_focus_target:destroy()
	bars_text_focus_target_action:destroy()
	bars_text_sub_target:destroy()
	bars_text_sub_target_action:destroy()
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
	bars_text_shdw_sub_target:bold(bold)
	bars_text_shdw_sub_target_action:bold(bold)
	bars_text_shdw_target:bold(bold)
	bars_text_shdw_target_action:bold(bold)
	bars_text_shdw_self_action:bold(bold)
	bars_text_shdw_hp:bold(bold)
	bars_text_shdw_mp:bold(bold)
	bars_text_shdw_tp:bold(bold)
	bars_text_shdw_pet:bold(bold)
	bars_text_focus_target:bold(bold)
	bars_text_focus_target_action:bold(bold)
	bars_text_sub_target:bold(bold)
	bars_text_sub_target_action:bold(bold)
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
	bars_bg_sub_target:size(size)
	bars_bg_target:size(size)
	bars_bg_self_action:size(size)
	bars_bg_hp:size(size)
	bars_bg_mp:size(size)
	bars_bg_tp:size(size)
	bars_bg_pet:size(size)
	bars_meter_focus_target:size(size)
	bars_meter_sub_target:size(size)
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
	bars_text_shdw_sub_target:size(size)
	bars_text_shdw_sub_target_action:size(size)
	bars_text_shdw_target:size(size+target_text_size_difference)
	bars_text_shdw_target_action:size(size+target_action_text_size_difference)
	bars_text_shdw_self_action:size(size+self_action_text_size_difference)
	bars_text_shdw_hp:size(size)
	bars_text_shdw_mp:size(size)
	bars_text_shdw_tp:size(size)
	bars_text_shdw_pet:size(size)
	bars_text_focus_target:size(size)
	bars_text_focus_target_action:size(size)
	bars_text_sub_target:size(size)
	bars_text_sub_target_action:size(size)
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

	--Set base positions
	local pos_target = {x = settings.pos.x, y = settings.pos.y + show_bars[job].vertical_offset}
	local st_x_pos_adjustment = math.floor(bar_width / 2) * (settings.text.size * char_width_multiplier)
	local pos_focus_target = {x = pos_target.x, y = pos_target.y + bars_vertical_spacing.target_to_focus_target}
	local pos_sub_target = {x = pos_target.x + st_x_pos_adjustment, y = pos_target.y + bars_vertical_spacing.target_to_focus_target}
	local player_stats_1 = {x = pos_target.x, y = pos_target.y + bars_vertical_spacing.target_to_player_stats}
	local player_stats_2 = {x = pos_target.x, y = player_stats_1.y + bars_vertical_spacing.between_player_stats}
	local player_stats_3 = {x = pos_target.x, y = player_stats_2.y + bars_vertical_spacing.between_player_stats}
	local player_stats_4 = {x = pos_target.x, y = player_stats_3.y + bars_vertical_spacing.between_player_stats}
	local player_stats_5 = {x = pos_target.x, y = player_stats_4.y + bars_vertical_spacing.between_player_stats}
	local pos_self = player_stats_1

	--Adjust base position for player stats if self-action is displayed
	local base_stat = player_stats_1
	if show_self_action then
		base_stat = player_stats_2
	end

	--Assign positions
	local function assign_positions(base_stat, bars)
		local positions = {}
		local offset_y = 0

		if bars.hp then
			positions.hp = {x = base_stat.x, y = base_stat.y + offset_y}
			offset_y = offset_y + bars_vertical_spacing.between_player_stats
		end

		if bars.mp then
			positions.mp = {x = base_stat.x, y = base_stat.y + offset_y}
			offset_y = offset_y + bars_vertical_spacing.between_player_stats
		end

		if bars.tp then
			positions.tp = {x = base_stat.x, y = base_stat.y + offset_y}
			offset_y = offset_y + bars_vertical_spacing.between_player_stats
		end

		positions.pet = {x = base_stat.x, y = base_stat.y + offset_y}
		return positions
	end

	--Determine positions based on which bars are displayed
	local positions = assign_positions(base_stat, show_bars[job])
	local pos_hp = positions.hp and positions.hp or player_stats_2
	local pos_mp = positions.mp and positions.mp or player_stats_3
	local pos_tp = positions.tp and positions.tp or player_stats_4
	local pos_pet = positions.pet and positions.pet or player_stats_5

	--Set bar positions
	bars_bg_focus_target:pos(pos_focus_target.x, pos_focus_target.y + 8)
	bars_bg_sub_target:pos(pos_sub_target.x, pos_sub_target.y + 8)
	bars_bg_target:pos(pos_target.x, pos_target.y + 8)
	bars_bg_self_action:pos(pos_self.x, pos_self.y + 8)
	bars_bg_hp:pos(pos_hp.x, pos_hp.y + 8)
	bars_bg_mp:pos(pos_mp.x, pos_mp.y + 8)
	bars_bg_tp:pos(pos_tp.x, pos_tp.y + 8)
	bars_bg_pet:pos(pos_pet.x, pos_pet.y + 8)
	bars_meter_focus_target:pos(pos_focus_target.x + 1, pos_focus_target.y + 9)
	bars_meter_sub_target:pos(pos_sub_target.x + 1, pos_sub_target.y + 9)
	bars_meter_target:pos(pos_target.x + 1, pos_target.y + 9)
	bars_meter_self_action:pos(pos_self.x + 1, pos_self.y + 9)
	bars_meter_hp:pos(pos_hp.x + 1, pos_hp.y + 9)
	bars_meter_mp:pos(pos_mp.x + 1, pos_mp.y + 9)
	bars_meter_tp:pos(pos_tp.x + 1, pos_tp.y + 9)
	bars_meter_pet:pos(pos_pet.x + 1, pos_pet.y + 9)
	bars_marker_hp:pos(pos_hp.x, pos_hp.y + 7)
	bars_marker_tp:pos(pos_tp.x, pos_tp.y + 7)
	bars_text_shdw_focus_target:pos(pos_focus_target.x + 1.5, pos_focus_target.y + text_vertical_offset + 1.5)
	bars_text_shdw_focus_target_action:pos(pos_focus_target.x + 1.5, pos_focus_target.y + 1.5 + 13)
	bars_text_shdw_sub_target:pos(pos_sub_target.x + 1.5, pos_sub_target.y + text_vertical_offset + 1.5)
	bars_text_shdw_sub_target_action:pos(pos_sub_target.x + 1.5, pos_sub_target.y + 1.5 + 13)
	bars_text_shdw_target:pos(pos_target.x + 1.5, pos_target.y + text_vertical_offset + 1.5 - target_text_size_difference)
	bars_text_shdw_target_action:pos(pos_target.x + 1.5, pos_target.y + 1.5 + 13)
	bars_text_shdw_self_action:pos(pos_self.x + 1.5, pos_self.y + text_vertical_offset + 1.5 - self_action_text_size_difference)
	bars_text_shdw_hp:pos(pos_hp.x + 1.5, pos_hp.y + text_vertical_offset + 1.5)
	bars_text_shdw_mp:pos(pos_mp.x + 1.5, pos_mp.y + text_vertical_offset + 1.5)
	bars_text_shdw_tp:pos(pos_tp.x + 1.5, pos_tp.y + text_vertical_offset + 1.5)
	bars_text_shdw_pet:pos(pos_pet.x + 1.5, pos_pet.y + text_vertical_offset + 1.5)
	bars_text_focus_target:pos(pos_focus_target.x, pos_focus_target.y + text_vertical_offset)
	bars_text_focus_target_action:pos(pos_focus_target.x, pos_focus_target.y + 13)
	bars_text_sub_target:pos(pos_sub_target.x, pos_sub_target.y + text_vertical_offset)
	bars_text_sub_target_action:pos(pos_sub_target.x, pos_sub_target.y + 13)
	bars_text_target:pos(pos_target.x, pos_target.y + text_vertical_offset - target_text_size_difference)
	bars_text_target_action:pos(pos_target.x, pos_target.y + 13)
	bars_text_self_action:pos(pos_self.x, pos_self.y + text_vertical_offset - self_action_text_size_difference)
	bars_text_hp:pos(pos_hp.x, pos_hp.y + text_vertical_offset)
	bars_text_mp:pos(pos_mp.x, pos_mp.y + text_vertical_offset)
	bars_text_tp:pos(pos_tp.x, pos_tp.y + text_vertical_offset)
	bars_text_pet:pos(pos_pet.x, pos_pet.y + text_vertical_offset)

end

--Set the width of various elements based on the bar_width option
local function setWidth()

	bar_width = settings.options.bar_width
	show_bar_markers = settings.options.show_bar_markers
	bars_bg_str = ''
	bars_bg_str_ft_st = ''
	bars_bg_str_hp = ''
	bars_bg_str_tp = ''

	--Sets the width for most of the bg elements
	while string.len(bars_bg_str) < bar_width do
		bars_bg_str = bars_bg_str..' '
	end

	--Sets the width for the focus target bg element
	while string.len(bars_bg_str_ft_st) < math.floor(bar_width / 2) do
		bars_bg_str_ft_st = bars_bg_str_ft_st..' '
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

	bars_bg_focus_target:text(bars_bg_str_ft_st)
	bars_bg_sub_target:text(bars_bg_str_ft_st)
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
	bars_bg_sub_target:hide()
	bars_bg_target:hide()
	bars_bg_self_action:hide()
	bars_bg_hp:hide()
	bars_bg_mp:hide()
	bars_bg_tp:hide()
	bars_bg_pet:hide()
	bars_meter_focus_target:hide()
	bars_meter_sub_target:hide()
	bars_meter_target:hide()
	bars_meter_self_action:hide()
	bars_meter_hp:hide()
	bars_meter_mp:hide()
	bars_meter_tp:hide()
	bars_meter_pet:hide()
	bars_marker_hp:hide()
	bars_marker_tp:hide()
	bars_text_shdw_focus_target:hide()
	bars_text_shdw_focus_target_action:hide()
	bars_text_shdw_sub_target:hide()
	bars_text_shdw_sub_target_action:hide()
	bars_text_shdw_target:hide()
	bars_text_shdw_target_action:hide()
	bars_text_shdw_self_action:hide()
	bars_text_shdw_hp:hide()
	bars_text_shdw_mp:hide()
	bars_text_shdw_tp:hide()
	bars_text_shdw_pet:hide()
	bars_text_focus_target:hide()
	bars_text_focus_target_action:hide()
	bars_text_sub_target:hide()
	bars_text_sub_target_action:hide()
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

	local player = get_player()
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

--Update the status of an action in the current_actions table when it gets interrupted
local function actionInterrupted(actor_id, status, status_shdw, result, result_shdw, index)
	local curr_action = current_actions[actor_id]

	if curr_action then
		curr_action.status, curr_action.status_shdw, curr_action.result, curr_action.result_shdw, curr_action.index = 
			status, status_shdw, result, result_shdw, index
	end

end

--Remove an action from the current_actions table
local function removeFromActionsTable(actor_id, index)

	if current_actions[actor_id] and current_actions[actor_id].index == index then
		current_actions[actor_id] = nil
	end

end

--Add an SP to the current_sp_actions table
local function addToSPTable(actor_id, sp_name)

	current_sp_actions[actor_id] = {
		sp_name = " "..sp_name,
	}

end

--Remove an SP from the current_sp_actions table
local function removeFromSPTable(actor_id)

	if current_sp_actions[actor_id] then
		current_sp_actions[actor_id] = nil
	end

end

--Clear all actions from the action tables
local function clearActionTables()

	current_actions = {}
	current_sp_actions = {}

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

	local actor = get_mob_by_id(id)

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

	local positions = {'p0', 'p1', 'p2', 'p3', 'p4', 'p5'}

	for _, position in ipairs(positions) do
		local member = get_mob_by_target(position)
		if member and member.id and member.id == id then
			--In our party
			return true
		end
	end

	--Not in our party
	return false

end

--Is this player in our alliance?
local function isInAlliance(id)

	local positions = {
		'a10', 'a11', 'a12', 'a13', 'a14', 'a15',
		'a20', 'a21', 'a22', 'a23', 'a24', 'a25'
	}

	for _, position in ipairs(positions) do
		local member = get_mob_by_target(position)
		if member and member.id and member.id == id then
			--In our alliance
			return true
		end
	end

	--Not in our alliance
	return false

end

--Return what color the target should be based on what/who it is
local function targetColor(target)

	local player = get_player()

	--Player (us)
	if target and target.id == player.id then
		return color.target.pc_self

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

	--Party member
	elseif target and isInParty(target.id) then
		return color.target.pc_party

	--Alliance member
	elseif target and isInAlliance(target.id) then
		return color.target.pc_alliance

	--Player (others)
	else
		return color.target.pc_other
	end

end

--Capitalize letters accordingly
local function capitalize(str)

	str = string.gsub(str, "(%w)(%w*)", function(firstLetter, rest)
		return string.upper(firstLetter) .. string.lower(rest)
	end)

	-- Fix capitalizing " ii" at the end of the string back to " II" (ex. Enstone II)
	str = string.gsub(str, " Ii$", " II")

	-- Ensure letters after an apostrophe are not capitalized
	str = string.gsub(str, "('%w)", function(apostropheLetter)
		return string.lower(apostropheLetter)
	end)

	return str

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

	--Remove "Tachi: " or "Blade: " if present at the start
	if remove_tachi_blade_from_ws_name then
		if string.sub(action, 1, 7) == "Tachi: " then
			action = string.sub(action, 8)
		elseif string.sub(action, 1, 7) == "Blade: " then
			action = string.sub(action, 8)
		end
	end

	--Check if the string length is greater than max_action_length
	if #action > num then
		--Truncate and add an ellipsis
		action = string.sub(action, 1, num-1).."…"
	end

	return action

end

--Truncate names that are too long
local function truncateName(name)

	local num = max_name_length

	--Abbreviate common names
	if abbreviate_common_mob_names then
		name = name:gsub("Apex", "A."):gsub("Locus", "L."):gsub("Bozzetto", "Bz."):gsub("Sweetwater", "Swt."):gsub("Transcended", "Trn."):gsub("Nostos", "N."):gsub("Abject", "A."):gsub("Biune", "B."):gsub("Cachaemic", "C."):gsub("Demisang", "D."):gsub("Esurient", "E."):gsub("Fetid", "F."):gsub("Gyvewrapped", "G."):gsub("Haughty", "H."):gsub("Squadron", "Sqd."):gsub("Regiment", "Rgm."):gsub("Vanguard", "Vng."):gsub("Awoken", "A."):gsub("Azi Dahaka's", "Azi's"):gsub("Naga Raja's", "Naga's"):gsub("Quetzalcoatl's", "Quetz's"):gsub("Commander", "Cmdr."):gsub("Leader", "Ldr.")
	end

	--Check if the string length is greater than max_name_length
	if #name > num then
		--Truncate and add an ellipsis
		name = string.sub(name, 1, num-1).."…"
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
	target = string.gsub(target, "-", "__dash__") --convert dashes to __dash__

	return target

end

--Convert auto focus targets to display them properly
local function convertToDisplay(target)

	target = string.gsub(target, "__apos__", "'") --convert __apos__ back to apostrophes
	target = string.gsub(target, "__dash__", "-") --convert __dash__ back to dashes
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

	if target == '' or target == '<t>' then
		target = get_mob_by_target('t')
		if target then
			target = target.name
		else
			add_to_chat(8,('[Bars] '):color(220)..('Please either target a player/npc, or specify a target to be added (name or id).'):color(8))
			return
		end
	elseif string.find(target, "[<>]") then
		add_to_chat(8,('[Bars] '):color(220)..('Target cannot contain "<" or ">" characters.'):color(8))
		return
	end

	auto_focus_target_list[convertToSave(target)] = true
	settings:save('all')
	
	add_to_chat(8,('[Bars] '):color(220)..('Added to Auto Focus Target list: '):color(36)..(capitalize(target)):color(1))

end

--Remove a target from the auto_focus_target_list
local function removeFromAutoFocusTargetList(target)

	--If target is a table, first convert it into a useable string
	if type(target) == 'table' then
		local concatenated_target = table.concat(target, ' ')
		target = concatenated_target
	end

	if target == '' or target == '<t>' then
		target = get_mob_by_target('t')
		if target then
			target = target.name
		else
			add_to_chat(8,('[Bars] '):color(220)..('Please either target a player/npc, or specify a target to be removed (name or id).'):color(8))
			return
		end
	end

	local savedTarget = convertToSave(target)

	if auto_focus_target_list[savedTarget] then
		auto_focus_target_list[savedTarget] = nil
		add_to_chat(8,('[Bars] '):color(220)..('Removed from Auto Focus Target list: '):color(36)..(capitalize(target)):color(1))
		settings:save('all')

	else
		add_to_chat(8,('[Bars] '):color(220)..(capitalize(target)):color(1)..(' was not found.'):color(8))
		add_to_chat(8,('[Bars] '):color(220)..('Type '):color(8)..('//bars list'):color(1)..(' to see stored targets.'):color(8))

	end
end

--What jobs are the target mob?
local function dynaJob(mob_name)

	local zone = res.zones[get_info().zone].en
	local in_dyna = string.match(zone, "%[D%]$") and true or false
	if in_dyna then
		--Volte NMs: Exact name-to-job mapping
		local volte_nms = {
			["Volte Cleaver"] = "WAR",
			["Volte Fistfighter"] = "MNK",
			["Volte Incanter"] = "BLM",
			["Volte Priest"] = "WHM",
			["Volte Duelist"] = "RUN",
			["Volte Vagabond"] = "THF",
			["Volte Crusader"] = "PLD",
			["Volte Reaper"] = "DRK",
			["Volte Trainer"] = "BST",
			["Volte Conductor"] = "BRD",
			["Volte Sniper"] = "RNG",
			["Volte Mononofu"] = "SAM",
			["Volte Shinobi"] = "NIN",
			["Volte Highwind"] = "DRG",
			["Volte Controller"] = "SMN",
			["Volte Joiner"] = "BLU",
			["Volte Sailor"] = "COR",
			["Volte Manipulator"] = "PUP",
			["Volte Twirler"] = "DNC",
			["Volte Erudite"] = "SCH",
			["Volte Communer"] = "GEO",
			["Volte Illusionist"] = "RDM"
		}

		--Squadron, Regiment, Leader, and Commander: Pattern-matching
		local job_designators = {
			["WAR|DRK"] = {"Berserker", "Skullcrusher", "Ravager", "Weaponmaster", "Fighter", "Hoplite"},
			["MNK|PUP"] = {"Fistfighter", "Pugilist", "Mendicant", "Combatant", "Brother", "Ascetic"},
			["THF|DNC"] = {"Vandal", "Fleetfoot", "Cutpurse", "Trickster", "Pickpocket", "Ruffian"},
			["BLM|GEO"] = {"Arcanomancer", "Evoker", "Invoker", "Magister", "Magus", "Magian"},
			["RDM|RUN"] = {"Defiler", "Enchanter", "Warlock", "Magician", "Shaman", "Prognosticator"},
			["PLD|DRG"] = {"Banneret", "Knight", "Stalwart", "Cavalier", "Chevalier", "Champion"},
			["BST|RNG"] = {"Animist", "Tamer", "Hunter", "Harnesser", "Domesticator", "Empath"},
			["WHM|SMN"] = {"Vivifier", "Medic", "Priest", "Mender", "Healer", "Orisha"},
			["BRD|SAM"] = {"Flautist", "Troubador", "Minstrel", "Balladeer", "Joculator", "Minnesinger"},
			["NIN|BLU"] = {"Operative", "Shinobi", "Kagemusha", "Shadowstalker", "Assassin", "Spy"},
			["COR|SCH"] = {"Buccaneer", "Pirate", "Canoneer", "Scallywag", "Freebooter", "Privateer"}
		}

		--First, check for an exact match for Volte NMs
		if volte_nms[mob_name] then
			return volte_nms[mob_name]
		end

		--Next, use pattern matching for the job designators
		for job, designators in pairs(job_designators) do
			for _, designator in ipairs(designators) do
				if string.find(mob_name, designator) then
					return job
				end
			end
		end

		--No match is found
		return false

	else
		return false
	end
end

--Update the Focus Target bar
local function updateFocusTarget()

	if not (focus_target_override or focus_target) then
		bars_bg_focus_target:hide()
		bars_meter_focus_target:hide()
		bars_text_shdw_focus_target:hide()
		bars_text_shdw_focus_target_action:hide()
		bars_text_focus_target:hide()
		bars_text_focus_target_action:hide()
		return
	end

	local target = get_mob_by_target('t') or nil
	local ft = focus_target_override and focus_target_override or focus_target
	local ft_sp_active = ft and current_sp_actions[ft.id]
	local ft_name = ft and (ft_sp_active and Heartbeat % 2 == 0 and current_sp_actions[ft.id].sp_name or ' '..ft.name) or ''
	local dyna_job = ft and show_dyna_jobs and dynaJob(ft.name) or false
	local ft_dyna_job = ft and dyna_job and ' '..dyna_job or ''
	local ft_index = ft and (show_target_index or show_target_hex) and ' ('..(show_target_hex and string.format("%03X", ft.index) or ft.index)..')' or ''
	local ft_distance = ft and show_target_distance and ' '..(string.format("%5.2f", math.floor(ft.distance:sqrt()*100)/100)) or ''
	local ft_hpp = ft and ft.hpp or 0
	local ft_meter = ''
	local spaces = ft_hpp and math.floor((bar_width / 2) * (ft_hpp / 100)) or 0
	--fix for the math flooring this to 0 when its not exactly 0
	if spaces == 0 and ft_hpp ~= 0 then
		spaces = 1
	end
	while string.len(ft_meter) < spaces do
		ft_meter = ft_meter..' '
	end
	local cm = ft and (Fade and text_color or targetColor(ft)) or color.target.pc_other
	local ct = text_color
	ft_hpp = string.format("%3s", ft_hpp)..'%'
	local text = ft_hpp..ft_distance..'\\cs('..formatRGB(cm.r)..','..formatRGB(cm.g)..','..formatRGB(cm.b)..')'..truncateName(ft_name)..'\\cr'..ft_dyna_job..ft_index
	local text_shdw = ft_hpp..ft_distance..'\\cs(000,000,000)'..truncateName(ft_name)..'\\cr'..ft_dyna_job..ft_index
	local ft_status = show_action_status_indicators and ft and current_actions[ft.id] and current_actions[ft.id].status or ''
	local ft_status_shdw = show_action_status_indicators and ft and current_actions[ft.id] and current_actions[ft.id].status_shdw or ''
	local ft_action = ft and current_actions[ft.id] and current_actions[ft.id].action or ''
	local ft_action_shdw = ft and current_actions[ft.id] and current_actions[ft.id].action_shdw or ''
	local text_ft_action = show_target_action and ' '..ft_status..ft_action or ''
	local text_ft_action_shdw = show_target_action and ' '..ft_status_shdw..ft_action_shdw or ''

	if not inCS then

		if focus_target_override and hide_focus_target_when_target and target then
			if target.id == focus_target_override.id then
				bars_bg_focus_target:hide()
				bars_meter_focus_target:hide()
				bars_text_shdw_focus_target:hide()
				bars_text_shdw_focus_target_action:hide()
				bars_text_focus_target:hide()
				bars_text_focus_target_action:hide()
			else

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
		else

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

	end

	bars_meter_focus_target:text(ft_meter)
	bars_meter_focus_target:bg_color(cm.r,cm.g,cm.b)
	bars_text_shdw_focus_target:text(Fade and text:text_strip_format() or text_shdw)
	bars_text_shdw_focus_target_action:text(Fade and text_ft_action_shdw:text_strip_format() or text_ft_action_shdw)
	bars_text_focus_target:text(Fade and text:text_strip_format() or text)
	bars_text_focus_target_action:text(Fade and text_ft_action:text_strip_format() or text_ft_action)
	bars_text_focus_target:color(ct.r,ct.g,ct.b)
	bars_text_focus_target_action:color(ct.r,ct.g,ct.b)
	bars_text_focus_target:stroke_alpha(ft_sp_active and sp.a or 0)

end

--Update the Target bar
local function updateTarget()

	local player = get_player()
	local target = screen_test and screen_test_target or (condense_target_and_subtarget_bars and get_mob_by_target('st', 't') or get_mob_by_target('t'))
	local target_sp_active = target and current_sp_actions[target.id]
	local target_name = target and (target_sp_active and Heartbeat % 2 == 0 and current_sp_actions[target.id].sp_name or ' '..target.name) or ''
	local dyna_job = target and show_dyna_jobs and dynaJob(target.name) or false
	local target_dyna_job = target and dyna_job and ' '..dyna_job or ''
	local target_index = target and (show_target_index or show_target_hex) and ' ('..(show_target_hex and string.format("%03X", target.index) or target.index)..')' or ''
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
	local cm = target and (Fade and text_color or targetColor(target)) or color.target.pc_other
	local ct = text_color
	target_hpp = string.format("%3s", target_hpp)..'%'
	local text = target_hpp..target_distance..'\\cs('..formatRGB(cm.r)..','..formatRGB(cm.g)..','..formatRGB(cm.b)..')'..target_name..'\\cr'..target_dyna_job..target_index
	local text_shdw = target_hpp..target_distance..'\\cs(000,000,000)'..target_name..'\\cr'..target_dyna_job..target_index
	local target_status = show_action_status_indicators and target and current_actions[target.id] and current_actions[target.id].status or ''
	local target_status_shdw = show_action_status_indicators and target and current_actions[target.id] and current_actions[target.id].status_shdw or ''
	local target_action = target and current_actions[target.id] and current_actions[target.id].action or ''
	local target_action_shdw = target and current_actions[target.id] and current_actions[target.id].action_shdw or ''
	local target_action_result = target and current_actions[target.id] and current_actions[target.id].result or ''
	local target_action_result_shdw = target and current_actions[target.id] and current_actions[target.id].result_shdw or ''
	local text_target_action = show_target_action and ' '..target_status..target_action..target_action_result or ''
	local text_target_action_shdw = show_target_action and ' '..target_status_shdw..target_action_shdw..target_action_result_shdw or ''

	if target and not (show_self_when_targeted == false and target.id == player.id) then
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
		bars_text_shdw_target:text(Fade and text:text_strip_format() or text_shdw)
		bars_text_shdw_target_action:text(Fade and text_target_action_shdw:text_strip_format() or text_target_action_shdw)
		bars_text_target:text(Fade and text:text_strip_format() or text)
		bars_text_target_action:text(Fade and text_target_action:text_strip_format() or text_target_action)
		bars_text_target:color(ct.r,ct.g,ct.b)
		bars_text_target_action:color(ct.r,ct.g,ct.b)
		bars_text_target:stroke_alpha(target_sp_active and sp.a or 0)

	else

		bars_bg_target:hide()
		bars_meter_target:hide()
		bars_text_shdw_target:hide()
		bars_text_shdw_target_action:hide()
		bars_text_target:hide()
		bars_text_target_action:hide()

	end
end

--Update the Sub-Target bar
local function updateSubTarget()

	local player = get_player()
	local st = screen_test and screen_test_sub_target or get_mob_by_target('st')
	local target = get_mob_by_target('t')
	local st_sp_active = st and current_sp_actions[st.id]
	local st_name = st and (st_sp_active and Heartbeat % 2 == 0 and current_sp_actions[st.id].sp_name or ' '..st.name) or ''
	local dyna_job = st and show_dyna_jobs and dynaJob(st.name) or false
	local st_dyna_job = st and dyna_job and ' '..dyna_job or ''
	local st_index = st and (show_target_index or show_target_hex) and ' ('..(show_target_hex and string.format("%03X", st.index) or st.index)..')' or ''
	local st_distance = st and show_target_distance and ' '..(string.format("%5.2f", math.floor(st.distance:sqrt()*100)/100)) or ''
	local st_hpp = st and st.hpp or 0
	local st_meter = ''
	local spaces = st_hpp and math.floor((bar_width / 2) * (st_hpp / 100)) or 0
	--fix for the math flooring this to 0 when its not exactly 0
	if spaces == 0 and st_hpp ~= 0 then
		spaces = 1
	end
	while string.len(st_meter) < spaces do
		st_meter = st_meter..' '
	end
	local cm = st and (Fade and text_color or targetColor(st)) or color.target.pc_other
	local ct = text_color
	st_hpp = string.format("%3s", st_hpp)..'%'
	local text = st_hpp..st_distance..'\\cs('..formatRGB(cm.r)..','..formatRGB(cm.g)..','..formatRGB(cm.b)..')'..truncateName(st_name)..'\\cr'..st_dyna_job..st_index
	local text_shdw = st_hpp..st_distance..'\\cs(000,000,000)'..truncateName(st_name)..'\\cr'..st_dyna_job..st_index
	local st_status = show_action_status_indicators and st and current_actions[st.id] and current_actions[st.id].status or ''
	local st_status_shdw = show_action_status_indicators and st and current_actions[st.id] and current_actions[st.id].status_shdw or ''
	local st_action = st and current_actions[st.id] and current_actions[st.id].action or ''
	local st_action_shdw = st and current_actions[st.id] and current_actions[st.id].action_shdw or ''
	local text_st_action = show_target_action and ' '..st_status..st_action or ''
	local text_st_action_shdw = show_target_action and ' '..st_status_shdw..st_action_shdw or ''

	if st and not ((show_st_when_target == false and target and st.id == target.id) or (show_self_when_targeted == false and st.id == player.id)) then
		if not inCS then

			--Fix the pad issue when 0
			if spaces == 0 then
				bars_meter_sub_target:hide()
			else
				bars_meter_sub_target:show()
			end

			bars_bg_sub_target:show()
			bars_text_shdw_sub_target:show()
			bars_text_shdw_sub_target_action:show()
			bars_text_sub_target:show()
			bars_text_sub_target_action:show()

		end

		bars_meter_sub_target:text(st_meter)
		bars_meter_sub_target:bg_color(cm.r,cm.g,cm.b)
		bars_text_shdw_sub_target:text(Fade and text:text_strip_format() or text_shdw)
		bars_text_shdw_sub_target_action:text(Fade and text_st_action_shdw:text_strip_format() or text_st_action_shdw)
		bars_text_sub_target:text(Fade and text:text_strip_format() or text)
		bars_text_sub_target_action:text(Fade and text_st_action:text_strip_format() or text_st_action)
		bars_text_sub_target:color(ct.r,ct.g,ct.b)
		bars_text_sub_target_action:color(ct.r,ct.g,ct.b)
		bars_text_sub_target:stroke_alpha(st_sp_active and sp.a or 0)

	else

		bars_bg_sub_target:hide()
		bars_meter_sub_target:hide()
		bars_text_shdw_sub_target:hide()
		bars_text_shdw_sub_target_action:hide()
		bars_text_sub_target:hide()
		bars_text_sub_target_action:hide()

	end
end


--Update the Self Action text
local function updateSelfAction()

	local player = get_player()
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

		bars_text_shdw_self_action:text(Fade and text_self_action_shdw:text_strip_format() or text_self_action_shdw)
		bars_text_self_action:text(Fade and text_self_action:text_strip_format() or text_self_action)

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

	if show_self_action then
		while string.len(self_meter) < bar_width do
			self_meter = self_meter..' '
		end
		bars_meter_self_action:text(self_meter)
		bars_meter_self_action:show()
	end

end

--Update the Self bar
local function updateSelfBar(cast_time, index)

	cast_time = cast_time ~= 0 and cast_time or 1
	local player = get_player()
	local self_meter = ''
	local spaces = 0
	local divisor = cast_time / 0.1 --Bar length gets updated every tenth of a second
	local increment = bar_width / divisor

	--Loop to update the bar length over time
	for i = 1, divisor do

		local curr_index = current_actions[player.id]

		--Cancel if a spell has finished early
		if (current_actions[player.id] and (current_actions[player.id].status == '\\cs(050,255,050)√\\cr' or current_actions[player.id].status == '\\cs(255,050,050)×\\cr') and not screen_test) or curr_index and index ~= curr_index.index then
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
		elseif spaces == 0 or not current_actions[player.id] then
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

	local player = get_player()
	local hp = player and player.vitals.hp or 0
	local max_hp = player and player.vitals.max_hp or 0
	local hpp = player and player.vitals.hpp or 0
	local hp_meter = ''
	local spaces = math.floor(bar_width * (hpp / 100))
	--fix for the math flooring this to 0 when its not exactly 0
	if spaces == 0 and hpp ~= 0 then
		spaces = 1
	end
	local ct = text_color
	local cm = Fade and text_color or color.hp.bar

	--Fix the pad issue when 0
	if spaces == 0 then
		bars_meter_hp:bg_alpha(0)
	else
		if not Fade then
			bars_meter_hp:bg_alpha(bg_alpha)
		end
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

	--Set the color for the text based on HP percentage
	if hpp <= 75 then
		ct = color.hp.quarter_3
	elseif hpp <= 50 then
		ct = color.hp.quarter_2
	elseif hpp <= 25 then
		ct = color.hp.quarter_1
	end

	local ct_r = formatRGB(ct.r)
	local ct_g = formatRGB(ct.g)
	local ct_b = formatRGB(ct.b)

	local text = 'HP: \\cs('..ct_r..','..ct_g..','..ct_b..')'..hp..'\\cr'..max_hp
	local text_shdw = 'HP: '..hp..max_hp

	bars_meter_hp:text(hp_meter)
	bars_meter_hp:bg_color(cm.r,cm.g,cm.b)
	bars_text_shdw_hp:text(text_shdw)
	bars_text_hp:text(Fade and text:text_strip_format() or text)

end

--Update the MP bar
local function updateMPBar()

	local player = get_player()
	local mp = player and player.vitals.mp or 0
	local max_mp = player and player.vitals.max_mp or 0
	local mpp = player and player.vitals.mpp or 0
	local mp_meter = ''
	local spaces = math.floor(bar_width * (mpp / 100))
	--fix for the math flooring this to 0 when its not exactly 0
	if spaces == 0 and mpp ~= 0 then
		spaces = 1
	end
	local ct = text_color
	local cm = Fade and text_color or color.mp.bar

	--Fix the pad issue when 0
	if spaces == 0 then
		bars_meter_mp:bg_alpha(0)
	else
		if not Fade then
			bars_meter_mp:bg_alpha(bg_alpha)
		end
		while string.len(mp_meter) < spaces do
			mp_meter = mp_meter..' '
		end
	end

	--Set the color for the text based on MP percentage
	if mpp <= 75 then
		ct = color.mp.quarter_3
	elseif mpp <= 50 then
		ct = color.mp.quarter_2
	elseif mpp <= 25 then
		ct = color.mp.quarter_1
	end

	local ct_r = formatRGB(ct.r)
	local ct_g = formatRGB(ct.g)
	local ct_b = formatRGB(ct.b)

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

	local text = 'MP: \\cs('..ct_r..','..ct_g..','..ct_b..')'..mp..'\\cr'..max_mp
	local text_shdw = 'MP: '..mp..max_mp

	bars_meter_mp:text(mp_meter)
	bars_meter_mp:bg_color(cm.r,cm.g,cm.b)
	bars_text_shdw_mp:text(text_shdw)
	bars_text_mp:text(Fade and text:text_strip_format() or text)

end

--Update the TP bar
local function updateTPBar()

	local player = get_player()
	local tp = player and player.vitals.tp or 0
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
		if not Fade then
			bars_meter_tp:bg_alpha(bg_alpha)
		end

		--Set the color for the bar based on TP percentage
		local cm = text_color

		if not Fade then
			if tp == 3000 then
				cm = color.tp.full_3k
				ct = color.tp.ready_to_use
			elseif tp >= 2000 then
				cm = color.tp.full_2k
				ct = color.tp.ready_to_use
			elseif tp >= 1000 then
				cm = color.tp.full_1k
				ct = color.tp.ready_to_use
			end
		end

		bars_meter_tp:bg_color(cm.r,cm.g,cm.b)

	end

	local r = formatRGB(ct.r)
	local g = formatRGB(ct.g)
	local b = formatRGB(ct.b)

	local text = 'TP: \\cs('..r..','..g..','..b..')'..tp..'\\cr'
	local text_shdw = 'TP: '..tp

	bars_text_shdw_tp:text(text_shdw)
	bars_text_tp:text(Fade and text:text_strip_format() or text)
	bars_meter_tp:text(tp_meter)

end

--Update the Pet bar
local function updatePetBar()

	local pet = get_mob_by_target('pet')
	local hpp = pet and pet.hpp or 0
	local status = job ~= 'geo' and pet and ' ('..res.statuses[pet.status].en..')' or ''
	local distance = pet and show_pet_distance and ' '..(string.format("%5.2f", math.floor(pet.distance:sqrt()*100)/100)) or ''
	local pet_meter = ''
	local spaces = math.floor(bar_width * (hpp / 100))
	--fix for the math flooring this to 0 when its not exactly 0
	if spaces == 0 and hpp ~= 0 then
		spaces = 1
	end
	local ct = color.hp

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
		if not Fade then
			bars_meter_pet:bg_alpha(bg_alpha)
		end
		while string.len(pet_meter) < spaces and string.len(pet_meter) < bar_width do
			pet_meter = pet_meter..' '
		end
	end

	--Set the color for the text based on hp percentage
	if hpp >= 75 then
		ct = text_color
	elseif hpp >= 50 then
		ct = color.hp.quarter_3
	elseif hpp >= 25 then
		ct = color.hp.quarter_2
	elseif hpp >= 0 then
		ct = color.hp.quarter_1
	end
	local ct_r = formatRGB(ct.r)
	local ct_g = formatRGB(ct.g)
	local ct_b = formatRGB(ct.b)

	local cm = Fade and text_color or color.pet.bar
	--If SMN, set the color of the meter based on the summon element
	if job == 'smn' and not Fade then
		if pet and (pet.name == "Carbuncle" or pet.name == "Cait Sith" or pet.name == "Alexander" or pet.name == "LightSpirit") then
			cm = color.elements.light
		elseif pet and (pet.name == "Ifrit" or pet.name == "FireSpirit") then
			cm = color.elements.fire
		elseif pet and (pet.name == "Shiva" or pet.name == "IceSpirit") then
			cm = color.elements.ice
		elseif pet and (pet.name == "Garuda" or pet.name == "Siren" or pet.name == "AirSpirit") then
			cm = color.elements.wind
		elseif pet and (pet.name == "Titan" or pet.name == "EarthSpirit") then
			cm = color.elements.earth
		elseif pet and (pet.name == "Ramuh" or pet.name == "ThunderSpirit") then
			cm = color.elements.lightning
		elseif pet and (pet.name == "Leviathan" or pet.name == "WaterSpirit") then
			cm = color.elements.water
		elseif pet and (pet.name == "Fenrir" or pet.name == "Diabolos" or pet.name == "Atomos" or pet.name == "Odin" or pet.name == "DarkSpirit") then
			cm = color.elements.dark
		end
	end
	local cm_r = formatRGB(cm.r)
	local cm_g = formatRGB(cm.g)
	local cm_b = formatRGB(cm.b)

	local text = pet_name..(pet and ': \\cs('..ct_r..','..ct_g..','..ct_b..')'..hpp..'%\\cr' or '')..distance..status
	local text_shdw = pet_name..(pet and ': \\cs(000,000,000)'..hpp..'%\\cr' or '')..distance..status

	bars_meter_pet:text(pet_meter)
	bars_text_shdw_pet:text(Fade and text_shdw:text_strip_format() or text_shdw)
	bars_text_pet:text(Fade and text:text_strip_format() or text)
	bars_meter_pet:bg_color(cm_r,cm_g,cm_b)

end

--List the contents of the Auto Focus Target list
local function listAutoFocusTargets()
	local sortedTargets = {}

	add_to_chat(8,('[Bars] '):color(220)..('Auto Focus Targets: '):color(8))

	--Copy targets and sort them alphabetically
	for target in pairs(auto_focus_target_list) do
		table.insert(sortedTargets, target)
	end
	table.sort(sortedTargets)

	--Check if sortedTargets is empty
	if next(sortedTargets) == nil then
		add_to_chat(8,' - '..('[Empty]'):color(1))
	end

	--Add sorted targets to chat
	for _, target in ipairs(sortedTargets) do
		add_to_chat(8,' - '..(convertToDisplay(target)):color(1))
	end

end

--Check for matching focus targets
local function checkForFocusTarget()

	local target = get_mob_by_target('t') or nil
	local nearby = nil

	--Loop through all the mobs in memory (nearby)
	for i,v in pairs(windower.ffxi.get_mob_array()) do

		local distance = math.floor(v.distance:sqrt() * 100) / 100
		local nearby_mob_by_id = get_mob_by_id(v.id)
		local nearby_mob_by_name = windower.ffxi.get_mob_by_name(v.name)

		--Does an id nearby match an entry in our auto focus target list?
		if nearby_mob_by_id and auto_focus_target_list[convertToSave(v.id)] 
		and v.valid_target and distance <= tonumber(focus_target_max_distance) 
		and not (hide_focus_target_when_target and target and target.id == nearby_mob_by_id.id) 
		--Fix bug where when a target on the list first enters memory, it has a distance of 0 for a split second, making it show up on the Focus Target Bar for a frame before it actually enters the focus_target_max_distance range. This will ofc make it disappear if you manage to stand exactly on top of it, but gl doing that.
		and not (tonumber(focus_target_max_distance) < 50 and distance == 0) then

			nearby = nearby_mob_by_id

		--Does a name nearby match an entry in our auto focus target list?
		elseif nearby_mob_by_name and auto_focus_target_list[convertToSave(v.name)] 
		and v.valid_target and distance <= tonumber(focus_target_max_distance) 
		and not (hide_focus_target_when_target and target and target.id == nearby_mob_by_name.id) 
		and not (tonumber(focus_target_max_distance) < 50 and distance == 0) then

			nearby = nearby_mob_by_name

		end

	end

	--Update focus_target if its new, will remove/nil if nothing in the auto_focus_target_list
	if focus_target ~= nearby then
		focus_target = nearby
	end

end

--Check if focus target override is still nearby
local function checkForFocusTargetOverride()

	local target = get_mob_by_target('t') or nil
	local nearby = false

	--Loop through all the mobs in memory (nearby)
	for i,v in pairs(windower.ffxi.get_mob_array()) do

		local distance = math.floor(v.distance:sqrt() * 100) / 100

		--Does the id of the focus target override match to any mob id nearby
		if focus_target_override.id == v.id and v.valid_target and distance <= tonumber(focus_target_max_distance) then
			nearby = true
		end
	end

	--Update their data if they are still nearby
	if nearby or screen_test then
		focus_target_override = screen_test and screen_test_focus_target or get_mob_by_id(focus_target_override.id)
	--Remove the Focus Target Override if they are no longer nearby
	else
		add_to_chat(8,('[Bars] '):color(220)..('Focus Target Override Removed: '):color(36)..(focus_target_override.name):color(1))
		focus_target_override = nil
	end

end

--Fade the text (alpha)
local function setTextFade(num)
	bars_marker_hp:alpha(num)
	bars_marker_tp:alpha(num)
	bars_text_shdw_focus_target:alpha(num)
	bars_text_shdw_focus_target_action:alpha(num)
	bars_text_shdw_sub_target:alpha(num)
	bars_text_shdw_sub_target_action:alpha(num)
	bars_text_shdw_target:alpha(num)
	bars_text_shdw_target_action:alpha(num)
	bars_text_shdw_self_action:alpha(num)
	bars_text_shdw_hp:alpha(num)
	bars_text_shdw_mp:alpha(num)
	bars_text_shdw_tp:alpha(num)
	bars_text_shdw_pet:alpha(num)
	bars_text_focus_target:alpha(num)
	bars_text_focus_target_action:alpha(num)
	bars_text_sub_target:alpha(num)
	bars_text_sub_target_action:alpha(num)
	bars_text_target:alpha(num)
	bars_text_target_action:alpha(num)
	bars_text_self_action:alpha(num)
	bars_text_hp:alpha(num)
	bars_text_mp:alpha(num)
	bars_text_tp:alpha(num)
	bars_text_pet:alpha(num)
end

--Fade the bars (bg_alpha)
local function setBarFade(num)
	bars_bg_focus_target:bg_alpha(num)
	bars_bg_sub_target:bg_alpha(num)
	bars_bg_target:bg_alpha(num)
	bars_bg_self_action:bg_alpha(num)
	bars_bg_hp:bg_alpha(num)
	bars_bg_mp:bg_alpha(num)
	bars_bg_tp:bg_alpha(num)
	bars_bg_pet:bg_alpha(num)
	bars_meter_focus_target:bg_alpha(num)
	bars_meter_sub_target:bg_alpha(num)
	bars_meter_target:bg_alpha(num)
	bars_meter_self_action:bg_alpha(num)
	if get_player() and get_player().vitals.hp ~= 0 then
		bars_meter_hp:bg_alpha(num)
	end
	if get_player() and get_player().vitals.mp ~= 0 then
		bars_meter_mp:bg_alpha(num)
	end
	if get_player() and get_player().vitals.tp ~= 0 then
		bars_meter_tp:bg_alpha(num)
	end
	if get_mob_by_target('pet') and get_mob_by_target('pet').hpp ~= 0 then
		bars_meter_pet:bg_alpha(num)
	end
end

--Reset the bars alpha/bg_alpha to normal
local function unFade()
	text_fade_num = settings.text.alpha
	bars_marker_hp:alpha(text_alpha)
	bars_marker_tp:alpha(text_alpha)
	bars_text_shdw_focus_target:alpha(text_alpha)
	bars_text_shdw_focus_target_action:alpha(text_alpha)
	bars_text_shdw_sub_target:alpha(text_alpha)
	bars_text_shdw_sub_target_action:alpha(text_alpha)
	bars_text_shdw_target:alpha(text_alpha)
	bars_text_shdw_target_action:alpha(text_alpha)
	bars_text_shdw_self_action:alpha(text_alpha)
	bars_text_shdw_hp:alpha(text_alpha)
	bars_text_shdw_mp:alpha(text_alpha)
	bars_text_shdw_tp:alpha(text_alpha)
	bars_text_shdw_pet:alpha(text_alpha)
	bars_text_focus_target:alpha(text_alpha)
	bars_text_focus_target_action:alpha(text_alpha)
	bars_text_sub_target:alpha(text_alpha)
	bars_text_sub_target_action:alpha(text_alpha)
	bars_text_target:alpha(text_alpha)
	bars_text_target_action:alpha(text_alpha)
	bars_text_self_action:alpha(text_alpha)
	bars_text_hp:alpha(text_alpha)
	bars_text_mp:alpha(text_alpha)
	bars_text_tp:alpha(text_alpha)
	bars_text_pet:alpha(text_alpha)
	bg_fade_num = settings.bg.alpha
	bars_bg_focus_target:bg_alpha(bg_alpha)
	bars_bg_sub_target:bg_alpha(bg_alpha)
	bars_bg_target:bg_alpha(bg_alpha)
	bars_bg_self_action:bg_alpha(bg_alpha)
	bars_bg_hp:bg_alpha(bg_alpha)
	bars_bg_mp:bg_alpha(bg_alpha)
	bars_bg_tp:bg_alpha(bg_alpha)
	bars_bg_pet:bg_alpha(bg_alpha)
	bars_meter_focus_target:bg_alpha(bg_alpha)
	bars_meter_sub_target:bg_alpha(bg_alpha)
	bars_meter_target:bg_alpha(bg_alpha)
	bars_meter_self_action:bg_alpha(bg_alpha)
	if get_player() and get_player().vitals.hp ~= 0 then
		bars_meter_hp:bg_alpha(bg_alpha)
	end
	if get_player() and get_player().vitals.mp ~= 0 then
		bars_meter_mp:bg_alpha(bg_alpha)
	end
	if get_player() and get_player().vitals.tp ~= 0 then
		bars_meter_tp:bg_alpha(bg_alpha)
	end
	if get_mob_by_target('pet') and get_mob_by_target('pet').hpp ~= 0 then
		bars_meter_pet:bg_alpha(bg_alpha)
	end
	bars_meter_hp:bg_color(color.hp.bar.r,color.hp.bar.g,color.hp.bar.b)
	bars_meter_mp:bg_color(color.mp.bar.r,color.mp.bar.g,color.mp.bar.b)
	updateTPBar() --the other Player Stat bars are always the same color, this one needs to be figured out based on current TP
	bars_meter_pet:bg_color(color.pet.bar.r,color.pet.bar.g,color.pet.bar.b)
end

--Reset the fade delay timer
local function resetFadeDelay()
	fade_delay = settings.options.fade_delay
	if Fade then
		Fade = false
		unFade()
	end
end

--Check a table if it contains a specific message number
local function checkForMessage(tbl, msg)
	for _, v in ipairs(tbl) do
		if v == msg then
			return true
		end
	end
	return false
end

--Show the Target, Sub Target, and Focus Target bars to test the screen layout
local function screenTest()

	screen_test = true
	resetFadeDelay()

	--Setup the self action bar
	local trackingIndex = assignIndex()
	local c = text_color
	local c_r = formatRGB(c.r)
	local c_g = formatRGB(c.g)
	local c_b = formatRGB(c.b)
	local ct = targetColor(get_player())
	local ct_r = formatRGB(ct.r)
	local ct_g = formatRGB(ct.g)
	local ct_b = formatRGB(ct.b)
	local target_action = ' \\cs('..c_r..','..c_g..','..c_b..')Screen Test →\\cr \\cs('..ct_r..','..ct_g..','..ct_b..')'..get_player().name..'\\cr'
	local target_action_shdw = ' \\cs(000,000,000)Screen Test →\\cr \\cs(000,000,000)'..get_player().name..'\\cr'
	local target_action_status = '\\cs(245,164,066)≈\\cr'
	local target_action_status_shdw = '\\cs(000,000,000)≈\\cr'
	local target_action_result = ''
	local target_action_result_shdw = ''
	addToActionsTable(get_player().id,target_action,target_action_shdw,target_action_status,target_action_status_shdw,target_action_result,target_action_result_shdw,trackingIndex)
	bars_meter_self_action:bg_color(color.self.bar.r,color.self.bar.g,color.self.bar.b)

	--Setup the focus target bar
	if not (focus_target_override or focus_target) then

		focus_target_override = screen_test_focus_target

		--Wait 5 seconds then remove the focus target override
		coroutine.schedule(function()
			focus_target_override = nil
		end, 5)

	end

	--Wait 5 seconds then remove the target and sub target bars
	coroutine.schedule(function()
		screen_test = false
		updateTarget()
		removeFromActionsTable(get_player().id,trackingIndex)
	end, 5)

	--Use the self action bar to show the screen test timer (timing adjust slightly lower to make sure the meter shows reaching the end, just looks better)
	updateSelfBar(4.5,trackingIndex)

end

--Job Changing
windower.register_event('job change', function()
	hideBars()
	setJob()
	setPosition()
	showBars()
	resetFadeDelay()
end)

--Target Changing
windower.register_event('target change', function()
	updateTarget()
	if not condense_target_and_subtarget_bars then
		updateSubTarget()
	end
	resetFadeDelay()
end)

--HP Changing
windower.register_event('hp change', function(new_hp,old_hp)
	updateHPBar()
	if new_hp < old_hp then
		resetFadeDelay()
	end
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
	updateSubTarget()
	updateHPBar()
	updateMPBar()
	updateTPBar()
	--Wait 2 sec then repeat since values are 0 when first logging into a character
	coroutine.schedule(function()
		updateHPBar()
		updateMPBar()
		updateTPBar()
	end, 2)
end

--Load
windower.register_event('load', function()
	if get_info().logged_in then
		initialize()
	end
end)

--Login
windower.register_event('login', function()
	initialize()
	resetFadeDelay()
end)

--Logout
windower.register_event('logout', function()
	resetFadeDelay()
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
	resetFadeDelay()
end)

windower.register_event('prerender', function()

	if get_info().logged_in and show_self_action then
		updateSelfAction()
	end

	local target = get_mob_by_target('t')
	local sub_target = get_mob_by_target('st')
	if condense_target_and_subtarget_bars then
		if target or sub_target or screen_test then
			updateTarget()
		end
	else
		if target or screen_test then
			updateTarget()
		end
		if sub_target or screen_test then
			updateSubTarget()
		else
			bars_bg_sub_target:hide()
			bars_meter_sub_target:hide()
			bars_text_shdw_sub_target:hide()
			bars_text_shdw_sub_target_action:hide()
			bars_text_sub_target:hide()
			bars_text_sub_target_action:hide()
		end
	end

	if focus_target_override then
		checkForFocusTargetOverride()
	else
		checkForFocusTarget()
	end
	updateFocusTarget()

	if get_info().logged_in and show_bars[job].pet then
		updatePetBar()
	end

	--Fade timer
	if fade_after_delay and os.time() > Heartbeat and get_info().logged_in then
		Heartbeat = os.time()
		local status = get_player() and get_player().status
		local in_combat = get_player() and get_player().in_combat
		local player = get_player()
		local target = get_mob_by_target('st','t')
		local has_target = target and target.id ~= player.id and true or false
		if fade_delay > 0 and status ~= 1 and not (in_combat or has_target) then
			fade_delay = fade_delay -1
		elseif fade_delay == 0 then
			Fade = true
			fade_delay = -1
			--Update so the color stripping happens before the fade
			updateFocusTarget()
			updateTarget()
			updateSubTarget()
			updateSelfAction()
			updateHPBar()
			updateMPBar()
			updateTPBar()
			updatePetBar()
		end
	end

	--Fade away
	if Fade then
		if bg_fade_num > fade_to_alpha then
			bg_fade_num = bg_fade_num - fade_multiplier
			setBarFade(bg_fade_num)
		elseif bg_fade_num <= fade_to_alpha then
			bg_fade_num = fade_to_alpha
			setBarFade(bg_fade_num)
		end
		if text_fade_num > (fade_to_alpha + fade_multiplier) then
			text_fade_num = text_fade_num - fade_multiplier
			setTextFade(text_fade_num)
		elseif text_fade_num <= fade_to_alpha then
			text_fade_num = fade_to_alpha
			setTextFade(text_fade_num)
		end
	end

	--Hide while zoning
	local pos = windower.ffxi.get_position()
	if pos == "(?-?)" and not zoning then
		zoning = true
		hideBars()
		clearActionTables() --flush the action tables to keep them clean
	elseif pos ~= "(?-?)" and zoning then
		zoning = false
		showBars()
		resetFadeDelay()
	end

end)

windower.register_event('action', function (act)
	local msg = act.targets[1].actions[1].message
	local player = get_player()
	local actor = get_mob_by_id(act.actor_id)
	local action_id = act.targets[1].actions[1].param
	local action_target = get_mob_by_id(act.targets[1].id)
	local action_target_id = action_target and action_target.id or nil
	local action_name = ''
	local action_name_shdw = ''
	local ct = targetColor(action_target)
	local ct_r = formatRGB(ct.r)
	local ct_g = formatRGB(ct.g)
	local ct_b = formatRGB(ct.b)
	local action_target_name = action_target_id and ' → \\cs('..ct_r..','..ct_g..','..ct_b..')'..truncateName(action_target.name)..'\\cr' or ''
	local action_target_name_shdw = action_target_id and ' → \\cs(000,000,000)'..truncateName(action_target.name)..'\\cr' or ''
	local target_action = ''
	local target_action_shdw = ''
	local target_action_result = ''
	local target_action_result_shdw = ''
	local buff = res.buffs
	local item = res.items
	local job_abil = res.job_abilities
	local monster_abil = res.monster_abilities
	local spell = res.spells
	local wep_skill = res.weapon_skills
	local cast_time = 0
	local nm_auto_tp = monster_abil[act.param] and monster_abil[act.param].en and (string.find(monster_abil[act.param].en,'Autoattack') or string.find(monster_abil[act.param].en,'Ranged') or string.find(monster_abil[act.param].en,'Vulture') or string.find(monster_abil[act.param].en,'Sabotender')) and true or false
	local target_count = act.target_count
	local amount = addCommas(act.targets[1].actions[1].param)
	local count = show_result_totals and target_count > 1 and target_count..'●' or ''

	local sp_abils = {['Mighty Strikes'] = 45, ['Brazen Rush'] = 30, ['Hundred Fists'] = 45, ['Manafont'] = 60, ['Chainspell'] = 60, ['Perfect Dodge'] = 30, ['Invincible'] = 30, ['Blood Weapon'] = 30, ['Soul Enslavement'] = 30, ['Soul Voice'] = 180, ['Meikyo Shisui'] = 30, ['Yaegasumi'] = 45, ['Mikage'] = 45, ['Spirit Surge'] = 60, ['Azure Lore'] = 30, ['Unbridled Wisdom'] = 60, ['Overdrive'] = 60, ['Trance'] = 60, ['Tabula Rasa'] = 180, ['Bolster'] = 180, ['Elemental Sforzo'] = 30, ['Inner Strength'] = 30, ['Subtle Sorcery'] = 60, ['Unleash'] = 60, ['Clarion Call'] = 180, ['Overkill'] = 60, ['Fly High'] = 30, ['Astral Flow'] = 180, ['Astral Conduit'] = 30, ['Grand Pas'] = 30, ['Widened Compas'] = 60}

	local rdc_r = formatRGB(color.result.damage.r)
	local rdc_g = formatRGB(color.result.damage.g)
	local rdc_b = formatRGB(color.result.damage.b)
	local rhc_r = formatRGB(color.result.heal.r)
	local rhc_g = formatRGB(color.result.heal.g)
	local rhc_b = formatRGB(color.result.heal.b)

	local function calculateInfo(act)
		local landed = 0
		local amount_total = 0
		local cure_total = false
		local last_buff_id = false
		local damage = false
		if show_result_totals and target_count > 1 then
			for i = 1, target_count do
				local msg = act.targets[i].actions[1].message
				--Buffs/Debuffs
				if msg == 186 or msg == 194 or msg == 205 or msg == 230 or msg == 266 or msg == 280 or msg == 319 or msg == 127 or msg == 141 or msg == 203 or msg == 236 or msg == 242 or msg == 270 or msg == 271 or msg == 272 or msg == 277 or msg == 279 or msg == 645 or msg == 237 or msg == 243 or msg == 267 or msg == 268 or msg == 269 or msg == 278 or msg == 320 or msg == 375 or msg == 412 then
					landed = landed + 1
					last_buff_id = act.targets[i].actions[1].param
				--Cures/absorbs
				elseif msg == 7 or msg == 24 or msg == 102 or msg == 103 or msg == 238 or msg == 263 or msg == 306 or msg == 318 or msg == 367 then
					landed = landed + 1
					amount_total = amount_total + act.targets[i].actions[1].param
					cure_total = cure_total and cure_total + act.targets[i].actions[1].param or act.targets[i].actions[1].param
				--Everything else that is NOT: Evaded/No Effect/Resisted/Immunobreak/Anticipated/Blinked/Dodged/Missed
				elseif not (msg == 282 
				or msg == 75 or msg == 156 or msg == 189 or msg == 248 or msg == 283 or msg == 323 or msg == 355 or msg == 408 or msg == 422 or msg == 423 or msg == 425 or msg == 659 or msg == 114 
				or msg == 85 or msg == 284 or msg == 655 or msg == 656 
				or msg == 653 or msg == 654 
				or msg == 30 
				or msg == 31 
				or msg == 32
				or msg == 15 or msg == 63 or msg == 158 or msg == 188 or msg == 245 or msg == 324 or msg == 658) then
					landed = landed + 1
					amount_total = amount_total + act.targets[i].actions[1].param
					if msg == 196 or msg == 264 or msg == 265 then
						damage = true
					end
				end
			end
		end
		local info = {landed = landed, cure_total = cure_total, amount_total = amount_total, last_buff_id = last_buff_id, damage = damage}
		return info
	end

	--Ignore regular melee and ranged attacks
	if msg == 1 or msg == 15 or msg == 373 or msg == 352 or msg == 353 or msg == 354 or msg == 382 or not actor then
		return
	end

	--Debug Stuff
	-- if actor.name == player.name then
	-- 	print(get_mob_by_id(act.actor_id).name.." - category: "..act.category.." a.param: "..act.param.." a.t.a.param: "..act.targets[1].actions[1].param.." message: "..msg.." target: "..get_mob_by_id(act.targets[1].id).name)
	-- end

	--Action failed/interrupted
	if (act.param == 28787 or msg == 78) and not (not isPlayer(actor.id) and nm_auto_tp) then

		local trackingIndex = assignIndex()
		local target_action_status = '\\cs(255,050,050)×\\cr'
		local target_action_status_shdw = '\\cs(000,000,000)×\\cr'

		if msg == 78 then
			target_action_result = ' (Too Far!)'
			target_action_result_shdw = ' (Too Far!)'
		end

		actionInterrupted(act.actor_id,target_action_status,target_action_status_shdw,target_action_result,target_action_result_shdw,trackingIndex)

		if player.id == act.actor_id then
			bars_meter_self_action:bg_color(255,050,050)
			completeSelfMeter()
		end

		coroutine.schedule(function()
			removeFromActionsTable(act.actor_id, trackingIndex)
		end, clear_action_delay)

		return

	end

	--Begin weapon skill(7), TP move(7), or spell(8), or item(9)
	if action_id and (act.category == 7 or act.category == 8 or act.category == 9) then

		local target_action_status = '\\cs(245,164,066)≈\\cr'
		local target_action_status_shdw = '\\cs(000,000,000)≈\\cr'

		--Weapon skill or TP move
		if act.category == 7 then

			local c = targetColor(action_target)
			local r = formatRGB(c.r)
			local g = formatRGB(c.g)
			local b = formatRGB(c.b)
			action_target_name = (action_target_id and action_target_id ~= act.actor_id) and ' → \\cs('..r..','..g..','..b..')'..truncateName(action_target.name)..'\\cr' or ''
			action_target_name_shdw = (action_target_id and action_target_id ~= act.actor_id) and ' → \\cs(000,000,000)'..truncateName(action_target.name)..'\\cr' or ''

			--Players
			if isPlayer(actor.id) then
				action_name = wep_skill[action_id] and ' '..truncateAction(wep_skill[action_id].name) or ' [REDACTED]'
				action_name_shdw = wep_skill[action_id] and ' '..truncateAction(wep_skill[action_id].name) or ' [REDACTED]'

			--Certain NMs regular melee attacks are actually TP moves
			elseif act.targets[1].actions[1].param == nil then
				return

			--Pets (& Synergy Furnaces)
			elseif get_mob_by_id(actor.id) and get_mob_by_id(actor.id).spawn_type == 2 then
				action_name = job_abil[action_id] and ' '..truncateAction(job_abil[action_id].name) or (monster_abil[action_id] and ' '..truncateAction(monster_abil[action_id].name) or ' [REDACTED]')
				action_name_shdw = job_abil[action_id] and ' '..truncateAction(job_abil[action_id].name) or (monster_abil[action_id] and ' '..truncateAction(monster_abil[action_id].name) or ' [REDACTED]')

			--Monsters (some use player WSs)
			else
				action_name = monster_abil[action_id] and ' '..truncateAction(monster_abil[action_id].name) or (wep_skill[action_id] and ' '..truncateAction(wep_skill[action_id].name) or ' [REDACTED]')
				action_name_shdw = monster_abil[action_id] and ' '..truncateAction(monster_abil[action_id].name) or (wep_skill[action_id] and ' '..truncateAction(wep_skill[action_id].name) or ' [REDACTED]')

			end

		--Spell
		elseif act.category == 8 then

			local element = spell[action_id] and spell[action_id].element or 15 --15 is 'no element/none'
			local c = color_spells and element_colors[element] or text_color
			local r = formatRGB(c.r)
			local g = formatRGB(c.g)
			local b = formatRGB(c.b)
			action_name = spell[action_id] and ' \\cs('..r..','..g..','..b..')'..truncateAction(spell[action_id].name)..'\\cr' or ' [REDACTED]'
			action_name_shdw = spell[action_id] and ' \\cs(000,000,000)'..truncateAction(spell[action_id].name)..'\\cr' or ' [REDACTED]'
			cast_time = spell[action_id].cast_time

		--Item
		elseif act.category == 9 then

			local item_id = act.targets[1].actions[1].param
			local item_name = item[item_id] and item[item_id].name or '[REDACTED]'

			action_name = ' '..truncateAction(item_name)
			action_name_shdw = ' '..truncateAction(item_name)

			cast_time = item[item_id] and item[item_id].cast_time or 0

		end

		target_action = action_name..action_target_name
		target_action_shdw = action_name_shdw..action_target_name_shdw

		if ((show_self_action and player.id == act.actor_id) or show_target_action) and action_name ~= ' [REDACTED]' then

			local trackingIndex = assignIndex()

			addToActionsTable(act.actor_id,target_action,target_action_shdw,target_action_status,target_action_status_shdw,target_action_result,target_action_result_shdw,trackingIndex)

			if player.id == act.actor_id then
				bars_meter_self_action:bg_color(color.self.bar.r,color.self.bar.g,color.self.bar.b)
				updateSelfBar(cast_time,trackingIndex)
				resetFadeDelay()
			end

			--In case of lag and we don't receive the "finished" action, we remove the action after a long enough wait to be sure
			coroutine.schedule(function()
				removeFromActionsTable(act.actor_id, trackingIndex)
			end, cast_time + clear_action_delay + 5)

		end

	--Job abilities
	elseif (act.category == 3 and (msg == 110 or msg == 102 or msg == 122 or msg == 125 or msg == 129 or msg == 153 or msg == 244 or msg == 306 or msg == 318 or msg == 321 or msg == 322 or msg == 453 or msg == 593 or msg == 594 or msg == 595 or msg == 596 or msg == 597 or msg == 598 or msg == 599)) or act.category == 6 or act.category == 14 or act.category == 15 then

		local target_action = ''
		local target_action_shdw = ''
		local target_action_status = '\\cs(050,255,050)√\\cr'
		local target_action_status_shdw = '\\cs(000,000,000)√\\cr'
		local abil_id = act.param
		local abil_name = ''
		if act.category == 6 and actor.spawn_type == 16 then
		 	abil_name = monster_abil[abil_id] and monster_abil[abil_id].name or '[REDACTED]'
		else
			abil_name = job_abil[abil_id] and job_abil[abil_id].name or '[REDACTED]'
		end
		action_name = ' '..truncateAction(abil_name)
		action_name_shdw = ' '..truncateAction(abil_name)

		--Some RUN abilities
		if act.category == 15 then
			--Absorbed - Lunge/Swipes/Pulse
			if msg == 102 or msg == 306 or msg == 318 or msg == 122 then
				local lunge_mb = act.targets[1].actions[1].unknown == 4 and true or false
				target_action_result = ' ('..(lunge_mb and 'Magic Burst! ' or '')..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr)'
				target_action_result_shdw = ' ('..(lunge_mb and 'Magic Burst! ' or '')..'\\cs(000,000,000)'..amount..'\\cr)'
			--Lunge/Swipes
			elseif msg == 110 then
				local lunge_mb = act.targets[1].actions[1].unknown == 4 and true or false
				target_action_result = ' ('..(lunge_mb and 'Magic Burst! ' or '')..'\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr)'
				target_action_result_shdw = ' ('..(lunge_mb and 'Magic Burst! ' or '')..'\\cs(000,000,000)'..amount..'\\cr)'
			--Buff/Debuff
			elseif msg == 319 or msg == 320 or msg == 668 or msg == 670 or msg == 671 or msg == 672 then
				local landed = calculateInfo(act).landed
				count = show_result_totals and target_count > 1 and landed..(landed < target_count and '/'..target_count or '')..'●' or ''
				local buff_name = (action_id == 0 or action_id == 232) and job_abil[act.param] and capitalize(job_abil[act.param].name) or buff[act.targets[1].actions[1].param] and capitalize(buff[act.targets[1].actions[1].param].name)
				target_action_result = ' ('..count..buff_name..')'
				target_action_result_shdw = ' ('..count..buff_name..')'
			--Evaded/No Effect/Resisted/Immunobreak/Anticipated/Blinked/Dodged/Missed
			elseif msg == 282 or msg == 75 or msg == 156 or msg == 189 or msg == 248 or msg == 283 or msg == 323 or msg == 355 or msg == 408 or msg == 422 or msg == 423 or msg == 425 or msg == 659 or msg == 114 or msg == 85 or msg == 284 or msg == 653 or msg == 654 or msg == 655 or msg == 656 or msg == 30 or msg == 31 or msg == 32 or msg == 15 or msg == 63 or msg == 158 or msg == 188 or msg == 245 or msg == 324 or msg == 658 then
				local info = calculateInfo(act)
				local landed = info.landed
				local last_buff_id = info.last_buff_id
				local buff_name = last_buff_id and buff[last_buff_id] and capitalize(buff[last_buff_id].name)
				local damage = info.damage
				if buff_name then
					--redo count to show how many landed out of the total target_count
					count = show_result_totals and target_count > 1 and landed..'/'..target_count..'●' or ''
					target_action_result = ' ('..count..buff_name..')'
					target_action_result_shdw = ' ('..count..buff_name..')'
				elseif damage then
					local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
					count = count == '' and '' or ' '..count
					target_action_result = ' (\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr '..count..'\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount_total..'\\cr)'
					target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr '..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
				else
					--Evaded
					if msg == 282 then
						target_action_result = ' ('..count..'Evaded)'
						target_action_result_shdw = ' ('..count..'Evaded)'
					--No Effect
					elseif msg == 75 or msg == 156 or msg == 189 or msg == 248 or msg == 283 or msg == 323 or msg == 355 or msg == 408 or msg == 422 or msg == 423 or msg == 425 or msg == 659 or msg == 114 then
						target_action_result = ' ('..count..'No Effect)'
						target_action_result_shdw = ' ('..count..'No Effect)'
					--Resisted
					elseif msg == 85 or msg == 284 or msg == 655 or msg == 656 then
						target_action_result = ' ('..count..'Resisted)'
						target_action_result_shdw = ' ('..count..'Resisted)'
					--Immunobreak
					elseif msg == 653 or msg == 654 then
						target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')Immunobreak!\\cr)'
						target_action_result_shdw = ' (\\cs(000,000,000)Immunobreak!\\cr)'
					--Anticipated
					elseif msg == 30 then
						target_action_result = ' ('..count..'Anticipated)'
						target_action_result_shdw = ' ('..count..'Anticipated)'
					--Blinked
					elseif msg == 31 then
						target_action_result = ' ('..count..'Blinked)'
						target_action_result_shdw = ' ('..count..'Blinked)'
					--Dodged
					elseif msg == 32 then
						target_action_result = ' ('..count..'Dodged)'
						target_action_result_shdw = ' ('..count..'Dodged)'
					--Missed
					elseif msg == 15 or msg == 63 or msg == 158 or msg == 188 or msg == 245 or msg == 324 or msg == 658 then
						target_action_result = ' ('..count..'Missed)'
						target_action_result_shdw = ' ('..count..'Missed)'
					end
				end
			end
		--Absorbed - job abilities
		elseif (act.category == 3 or act.category == 6 or act.category == 14) and (msg == 102 or msg == 122 or msg == 306 or msg == 318) then
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr)'
		--Most direct damage abilities
		elseif act.category == 3 and msg == 110 then
			target_action_result = ' (\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr)'
		--Mug Success
		elseif msg == 129 then
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr Gil)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr Gil)'
		--Mug Fail
		elseif msg == 244 then
			target_action_result = ' (Failed)'
			target_action_result_shdw = ' (Failed)'
		--Steal Success
		elseif msg == 125 then
			local item = res.items[action_id].name
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..item..'\\cr)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..item..'\\cr)'
		--Aura Steal Absorb
		elseif msg == 453 then
			local aura = res.buffs[action_id].name
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..aura..'\\cr)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..aura..'\\cr)'
		--Aura Steal Dispel
		elseif msg == 321 or msg == 322 then
			local aura = res.buffs[action_id].name
			target_action_result = ' ('..aura..')'
			target_action_result_shdw = ' ('..aura..')'
		--Despoil Success + Attack Down
		elseif msg == 593 then
			local item = res.items[action_id].name
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..item..'\\cr + Att Down)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..item..'\\cr + Att Down)'
		--Despoil Success + Defense Down
		elseif msg == 594 then
			local item = res.items[action_id].name
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..item..'\\cr + Def Down)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..item..'\\cr + Def Down)'
		--Despoil Success + Magic Attack Down
		elseif msg == 595 then
			local item = res.items[action_id].name
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..item..'\\cr + MAtt Down)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..item..'\\cr + MAtt Down)'
		--Despoil Success + Magic Defense Down
		elseif msg == 596 then
			local item = res.items[action_id].name
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..item..'\\cr + MDef Down)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..item..'\\cr + MDef Down)'
		--Despoil Success + Evasion Down
		elseif msg == 597 then
			local item = res.items[action_id].name
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..item..'\\cr + Eva Down)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..item..'\\cr + Eva Down)'
		--Despoil Success + Accuracy Down
		elseif msg == 598 then
			local item = res.items[action_id].name
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..item..'\\cr + Acc Down)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..item..'\\cr + Acc Down)'
		--Despoil Success + Slow
		elseif msg == 599 then
			local item = res.items[action_id].name
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..item..'\\cr + Slow)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..item..'\\cr + Slow)'
		--Steal/Despoil Fail
		elseif msg == 153 then
			target_action_result = ' (Failed)'
			target_action_result_shdw = ' (Failed)'
		--Most job abilities
		elseif act.category == 6 then
			--Erase
			if msg == 123 then
				local buff_name = capitalize(buff[act.targets[1].actions[1].param].name)
				target_action_result = ' ('..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..buff_name..'\\cr)'
				target_action_result_shdw = ' ('..count..'\\cs(000,000,000)'..buff_name..'\\cr)'
			--Monberaux healing? idr
			elseif msg == 103 then
				local info = calculateInfo(act)
				local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
				count = count == '' and '' or ' '..count
				target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr HP'..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount_total..'\\cr)'
				target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr HP'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
			--Plain Damage
			elseif msg == 110 then
				local info = calculateInfo(act)
				local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
				count = count == '' and '' or ' '..count
				target_action_result = ' (\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr '..count..'\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount_total..'\\cr)'
				target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr '..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
			--Evaded/No Effect/Resisted/Immunobreak/Anticipated/Blinked/Dodged/Missed
			elseif msg == 282 or msg == 75 or msg == 156 or msg == 189 or msg == 248 or msg == 283 or msg == 323 or msg == 355 or msg == 408 or msg == 422 or msg == 423 or msg == 425 or msg == 659 or msg == 114 or msg == 85 or msg == 284 or msg == 653 or msg == 654 or msg == 655 or msg == 656 or msg == 30 or msg == 31 or msg == 32 or msg == 15 or msg == 63 or msg == 158 or msg == 188 or msg == 245 or msg == 324 or msg == 658 then
				local info = calculateInfo(act)
				local landed = info.landed
				local last_buff_id = info.last_buff_id
				local buff_name = last_buff_id and buff[last_buff_id] and capitalize(buff[last_buff_id].name)
				local damage = info.damage
				if buff_name then
					--redo count to show how many landed out of the total target_count
					count = show_result_totals and target_count > 1 and landed..'/'..target_count..'●' or ''
					target_action_result = ' ('..count..buff_name..')'
					target_action_result_shdw = ' ('..count..buff_name..')'
				elseif damage then
					local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
					count = count == '' and '' or ' '..count
					target_action_result = ' (\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr '..count..'\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount_total..'\\cr)'
					target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr '..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
				else
					--Evaded
					if msg == 282 then
						target_action_result = ' ('..count..'Evaded)'
						target_action_result_shdw = ' ('..count..'Evaded)'
					--No Effect
					elseif msg == 75 or msg == 156 or msg == 189 or msg == 248 or msg == 283 or msg == 323 or msg == 355 or msg == 408 or msg == 422 or msg == 423 or msg == 425 or msg == 659 or msg == 114 then
						target_action_result = ' ('..count..'No Effect)'
						target_action_result_shdw = ' ('..count..'No Effect)'
					--Resisted
					elseif msg == 85 or msg == 284 or msg == 655 or msg == 656 then
						target_action_result = ' ('..count..'Resisted)'
						target_action_result_shdw = ' ('..count..'Resisted)'
					--Immunobreak
					elseif msg == 653 or msg == 654 then
						target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')Immunobreak!\\cr)'
						target_action_result_shdw = ' (\\cs(000,000,000)Immunobreak!\\cr)'
					--Anticipated
					elseif msg == 30 then
						target_action_result = ' ('..count..'Anticipated)'
						target_action_result_shdw = ' ('..count..'Anticipated)'
					--Blinked
					elseif msg == 31 then
						target_action_result = ' ('..count..'Blinked)'
						target_action_result_shdw = ' ('..count..'Blinked)'
					--Dodged
					elseif msg == 32 then
						target_action_result = ' ('..count..'Dodged)'
						target_action_result_shdw = ' ('..count..'Dodged)'
					--Missed
					elseif msg == 15 or msg == 63 or msg == 158 or msg == 188 or msg == 245 or msg == 324 or msg == 658 then
						target_action_result = ' ('..count..'Missed)'
						target_action_result_shdw = ' ('..count..'Missed)'
					end
				end

				--Cover
			elseif msg == 311 then
				target_action_result = ' (Cover)'
				target_action_result_shdw = ' (Cover)'
			--Buff/Debuff
			elseif msg == 127 or msg == 141 or msg == 645 or msg == 319 or msg == 320 or msg == 441 or msg == 602 then --removed 100
				local landed = calculateInfo(act).landed
				count = show_result_totals and target_count > 1 and landed..(landed < target_count and '/'..target_count or '')..'●' or ''
				local buff_name = (action_id == 0 or action_id == 232) and job_abil[act.param] and capitalize(job_abil[act.param].name) or buff[act.targets[1].actions[1].param] and capitalize(buff[act.targets[1].actions[1].param].name)
				target_action_result = ' ('..count..buff_name..')'
				target_action_result_shdw = ' ('..count..buff_name..')'
			--Phantom Roll/Double-Up
			elseif msg == 420 or msg == 424 then
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

				if show_roll_lucky_info then
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

						local r_c1 = r_tot == 1 and color.rolls.total or text_color
						local r_c2 = (rolls[r_id].lucky == '2' and color.rolls.lucky or (rolls[r_id].unlucky == '2' and color.rolls.unlucky or (r_tot == 2 and color.rolls.total or text_color)))
						local r_c3 = (rolls[r_id].lucky == '3' and color.rolls.lucky or (rolls[r_id].unlucky == '3' and color.rolls.unlucky or (r_tot == 3 and color.rolls.total or text_color)))
						local r_c4 = (rolls[r_id].lucky == '4' and color.rolls.lucky or (rolls[r_id].unlucky == '4' and color.rolls.unlucky or (r_tot == 4 and color.rolls.total or text_color)))
						local r_c5 = (rolls[r_id].lucky == '5' and color.rolls.lucky or (rolls[r_id].unlucky == '5' and color.rolls.unlucky or (r_tot == 5 and color.rolls.total or text_color)))
						local r_c6 = (rolls[r_id].lucky == '6' and color.rolls.lucky or (rolls[r_id].unlucky == '6' and color.rolls.unlucky or (r_tot == 6 and color.rolls.total or text_color)))
						local r_c7 = (rolls[r_id].lucky == '7' and color.rolls.lucky or (rolls[r_id].unlucky == '7' and color.rolls.unlucky or (r_tot == 7 and color.rolls.total or text_color)))
						local r_c8 = (rolls[r_id].lucky == '8' and color.rolls.lucky or (rolls[r_id].unlucky == '8' and color.rolls.unlucky or (r_tot == 8 and color.rolls.total or text_color)))
						local r_c9 = (rolls[r_id].lucky == '9' and color.rolls.lucky or (rolls[r_id].unlucky == '9' and color.rolls.unlucky or (r_tot == 9 and color.rolls.total or text_color)))
						local r_c10 = (rolls[r_id].lucky == '10' and color.rolls.lucky or (rolls[r_id].unlucky == '10' and color.rolls.unlucky or (r_tot == 10 and color.rolls.total or text_color)))
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
						local r_10_t = '\\cs('..formatRGB(r_c10.r)..','..formatRGB(r_c10.g)..','..formatRGB(r_c10.b)..')'..r_10..'\\cr'
						local r_10_t_shdw = '\\cs(000,000,000)'..r_10..'\\cr'
						local r_11_t = '\\cs('..formatRGB(r_c11.r)..','..formatRGB(r_c11.g)..','..formatRGB(r_c11.b)..')'..r_11..'\\cr'
						local r_11_t_shdw = '\\cs(000,000,000)'..r_11..'\\cr'

						target_action_result = ' ('..count..r_1_t..r_2_t..r_3_t..r_4_t..r_5_t..r_6_t..r_7_t..r_8_t..r_9_t..r_10_t..r_11_t..')'
						target_action_result_shdw = ' ('..count..r_1_t_shdw..r_2_t_shdw..r_3_t_shdw..r_4_t_shdw..r_5_t_shdw..r_6_t_shdw..r_7_t_shdw..r_8_t_shdw..r_9_t_shdw..r_10_t_shdw..r_11_t_shdw..')'
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

						count = count..' '
						target_action_result = ' ('..count..'\\cs('..r..','..g..','..b..')L:'..rolls[r_id].lucky..' U:'..rolls[r_id].unlucky..' Total:'..r_tot..(r_tot == rolls[r_id].lucky and '!' or (r_tot == 11 and '!!' or ''))..'\\cr)'
						target_action_result_shdw = ' ('..count..'\\cs(000,000,000)L:'..rolls[r_id].lucky..' U:'..rolls[r_id].unlucky..' Total:'..r_tot..(r_tot == rolls[r_id].lucky and '!' or (r_tot == 11 and '!!' or ''))..')\\cr)'
					end
				else
					count = count..' '
					target_action_result = ' ('..count..'Total: '..r_tot..')'
					target_action_result_shdw = ' ('..count..'Total: '..r_tot..')'
				end

			--Bust
			elseif msg == 426 then
				target_action_result = ' ('..count..'Bust!)'
				target_action_result_shdw = ' ('..count..'Bust!)'
			--Wild Card 1-2
			elseif msg == 435 then
				target_action_result = ' ('..count..'JAs reset)'
				target_action_result_shdw = ' ('..count..'JAs reset)'
			--WIld Card 3-4
			elseif msg == 437 then
				target_action_result = ' ('..count..'TP, JAs reset)'
				target_action_result_shdw = ' ('..count..'TP, JAs reset)'
			--Wild Card 5-6
			elseif msg == 439 then
				target_action_result = ' ('..count..'SP, MP, TP, JAs reset)'
				target_action_result_shdw = ' ('..count..'SP, MP, TP, JAs reset)'
			--Regains MP
			elseif msg == 451 then
				local info = calculateInfo(act)
				local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
				count = count == '' and '' or ' '..count
				target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr MP'..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount_total..'\\cr)'
				target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr MP'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
			--Regains TP
			elseif msg == 452 then
				local info = calculateInfo(act)
				local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
				count = count == '' and '' or ' '..count
				target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr TP'..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount_total..'\\cr)'
				target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr TP'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
			--No Foot Rise
			elseif msg == 560 then
				local fin_moves = act.targets[1].actions[1].param
				target_action_result = ' (Finishing Moves: '..fin_moves..')'
				target_action_result_shdw = ' (Finishing Moves: '..fin_moves..')'
			--Caper Emissarius
			elseif msg == 657 then
				target_action_result = ' (Party Enmity Transferred)'
				target_action_result_shdw = ' (Party Enmity Transferred)'
			end

			if highlight_when_sp_active then

				local time = nil

				if abil_name ~= "[REDACTED]" then
					time = sp_abils[abil_name]
				end

				if time then
					addToSPTable(act.actor_id, abil_name)
					coroutine.schedule(function()
						removeFromSPTable(act.actor_id)
					end, time)
				end

			end

		--Non-blinkable job abilities
		elseif act.category == 14 then
			--Plain Damage (I don't think any do just direct damage but doesn't hurt)
			if msg == 110 then
				local info = calculateInfo(act)
				local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
				count = count == '' and '' or ' '..count
				target_action_result = ' (\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr'..count..'\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount_total..'\\cr)'
				target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
			--Buff/Debuff
			elseif msg == 127 then
				local landed = calculateInfo(act).landed
				count = show_result_totals and target_count > 1 and landed..(landed < target_count and '/'..target_count or '')..'●' or ''
				local buff_name = (action_id == 0 or action_id == 232) and job_abil[act.param] and capitalize(job_abil[act.param].name) or buff[act.targets[1].actions[1].param] and capitalize(buff[act.targets[1].actions[1].param].name)
				target_action_result = ' ('..count..buff_name..')'
				target_action_result_shdw = ' ('..count..buff_name..')'
			--Evaded/No Effect/Resisted/Immunobreak/Anticipated/Blinked/Dodged/Missed
			elseif msg == 282 or msg == 75 or msg == 156 or msg == 189 or msg == 248 or msg == 283 or msg == 323 or msg == 355 or msg == 408 or msg == 422 or msg == 423 or msg == 425 or msg == 659 or msg == 114 or msg == 85 or msg == 284 or msg == 653 or msg == 654 or msg == 655 or msg == 656 or msg == 30 or msg == 31 or msg == 32 or msg == 15 or msg == 63 or msg == 158 or msg == 188 or msg == 245 or msg == 324 or msg == 658 then
				local info = calculateInfo(act)
				local landed = info.landed
				local last_buff_id = info.last_buff_id
				local buff_name = last_buff_id and buff[last_buff_id] and capitalize(buff[last_buff_id].name)
				local damage = info.damage
				if buff_name then
					--redo count to show how many landed out of the total target_count
					count = show_result_totals and target_count > 1 and landed..'/'..target_count..'●' or ''
					target_action_result = ' ('..count..buff_name..')'
					target_action_result_shdw = ' ('..count..buff_name..')'
				elseif damage then
					local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
					count = count == '' and '' or ' '..count
					target_action_result = ' (\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr '..count..'\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount_total..'\\cr)'
					target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr '..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
				else
					--Evaded
					if msg == 282 then
						target_action_result = ' ('..count..'Evaded)'
						target_action_result_shdw = ' ('..count..'Evaded)'
					--No Effect
					elseif msg == 75 or msg == 156 or msg == 189 or msg == 248 or msg == 283 or msg == 323 or msg == 355 or msg == 408 or msg == 422 or msg == 423 or msg == 425 or msg == 659 or msg == 114 then
						target_action_result = ' ('..count..'No Effect)'
						target_action_result_shdw = ' ('..count..'No Effect)'
					--Resisted
					elseif msg == 85 or msg == 284 or msg == 655 or msg == 656 then
						target_action_result = ' ('..count..'Resisted)'
						target_action_result_shdw = ' ('..count..'Resisted)'
					--Immunobreak
					elseif msg == 653 or msg == 654 then
						target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')Immunobreak!\\cr)'
						target_action_result_shdw = ' (\\cs(000,000,000)Immunobreak!\\cr)'
					--Anticipated
					elseif msg == 30 then
						target_action_result = ' ('..count..'Anticipated)'
						target_action_result_shdw = ' ('..count..'Anticipated)'
					--Blinked
					elseif msg == 31 then
						target_action_result = ' ('..count..'Blinked)'
						target_action_result_shdw = ' ('..count..'Blinked)'
					--Dodged
					elseif msg == 32 then
						target_action_result = ' ('..count..'Dodged)'
						target_action_result_shdw = ' ('..count..'Dodged)'
					--Missed
					elseif msg == 15 or msg == 63 or msg == 158 or msg == 188 or msg == 245 or msg == 324 or msg == 658 then
						target_action_result = ' ('..count..'Missed)'
						target_action_result_shdw = ' ('..count..'Missed)'
					end
				end
			--Dazes
			elseif msg == 519 or msg == 520 or msg == 521 or msg == 591 then
				local daze_name = job_abil[abil_id].name
				local daze_lvl = act.targets[1].actions[1].param
				target_action_result = ' ('..daze_name..' Lv.'..daze_lvl..')'
				target_action_result_shdw = ' ('..daze_name..' Lv.'..daze_lvl..')'
			elseif msg == 522 then
				target_action_result = ' ('..amount..' + Stunned)'
				target_action_result_shdw = ' ('..amount..' + Stunned)'
			end
		end

		target_action = action_name..action_target_name
		target_action_shdw = action_name_shdw..action_target_name_shdw

		if ((show_self_action and player.id == act.actor_id) or show_target_action) and action_name ~= ' [REDACTED]' then

			local trackingIndex = assignIndex()

			addToActionsTable(act.actor_id,target_action,target_action_shdw,target_action_status,target_action_status_shdw,target_action_result,target_action_result_shdw,trackingIndex)

			if player.id == act.actor_id then
				bars_meter_self_action:bg_color(050,255,050)
				completeSelfMeter()
			end

			coroutine.schedule(function()
				removeFromActionsTable(act.actor_id, trackingIndex)
			end, clear_action_delay)

		end

	--Finish weapon skill(3), spell(4), item(5), or Pet TP move(13)
	elseif act.category == 3 or act.category == 5 or act.category == 13 or (act.category == 4 and not ((msg == 0 or msg == 29 or msg == 84 or msg == 106) and act.param == 0)) then

		local trackingIndex = assignIndex()
		local target_action_status = '\\cs(050,255,050)√\\cr'
		local target_action_status_shdw = '\\cs(000,000,000)√\\cr'
		local sc = {}
		if short_skillchain_names then
			sc = {} sc[1] = 'Lght' sc[2] = 'Drkn' sc[3] = 'Grvt' sc[4] = 'Frgm' sc[5] = 'Dstn' sc[6] = 'Fusn' sc[7] = 'Cmpr' sc[8] = 'Lqfn' sc[9] = 'Indr' sc[10] = 'Rvrb' sc[11] = 'Trns' sc[12] = 'Scsn' sc[13] = 'Detn' sc[14] = 'Impc' sc[15] = 'Rdnc' sc[16] = 'Umbr'
		else
			sc = {} sc[1] = 'Light' sc[2] = 'Darkness' sc[3] = 'Gravitation' sc[4] = 'Fragmentation' sc[5] = 'Distortion' sc[6] = 'Fusion' sc[7] = 'Compression' sc[8] = 'Liquifaction' sc[9] = 'Induration' sc[10] = 'Reverberation' sc[11] = 'Transfixion' sc[12] = 'Scission' sc[13] = 'Detonation' sc[14] = 'Impaction' sc[15] = 'Radiance' sc[16] = 'Umbra'
		end
		local sc_amount = addCommas(act.targets[1].actions[1].add_effect_param)
		local sc_name = sc[act.targets[1].actions[1].add_effect_animation]
		local abs_msgs = {385,386,387,388,389,390,391,392,393,394,395,396,397,398}
		local ae_msg = act.targets[1].actions[1].add_effect_message
		local sc_c = checkForMessage(abs_msgs,ae_msg) and color.result.heal or color.result.damage
		local sc_c_r = formatRGB(sc_c.r)
		local sc_c_g = formatRGB(sc_c.g)
		local sc_c_b = formatRGB(sc_c.b)

		--Weapon Skills and most direct damage job abilities
		if act.category == 3 then
			local action_id = act.param

			--Players
			if isPlayer(actor.id) then
				if msg == 317 or msg == 318 or msg == 324 then
					action_name = job_abil[action_id] and ' '..truncateAction(job_abil[action_id].name) or ' [REDACTED]'
					action_name_shdw = job_abil[action_id] and ' '..truncateAction(job_abil[action_id].name) or ' [REDACTED]'
				else
					action_name = wep_skill[action_id] and ' '..truncateAction(wep_skill[action_id].name) or ' [REDACTED]'
					action_name_shdw = wep_skill[action_id] and ' '..truncateAction(wep_skill[action_id].name) or ' [REDACTED]'
				end
			--Certain NMs regular melee attacks are actually TP moves
			elseif act.param == nil then
				return
			--Monsters (some use player WSs)
			else
				action_name = monster_abil[action_id] and ' '..truncateAction(monster_abil[action_id].name) or (wep_skill[action_id] and ' '..truncateAction(wep_skill[action_id].name) or ' [REDACTED]')
				action_name_shdw = monster_abil[action_id] and ' '..truncateAction(monster_abil[action_id].name) or (wep_skill[action_id] and ' '..truncateAction(wep_skill[action_id].name) or ' [REDACTED]')
			end

			--Absorbed and creates a Skillchain
			if msg == 103 and act.targets[1].actions[1].has_add_effect == true then
				target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr + \\cs('..sc_c_r..','..sc_c_g..','..sc_c_b..')'..sc_amount..'\\cr '..sc_name..')'
				target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr + \\cs(000,000,000)'..sc_amount..'\\cr '..sc_name..')'
			--Absorbed
			elseif msg == 103 or msg == 318 then
				target_action_result = ' ('..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr)'
				target_action_result_shdw = ' ('..count..'\\cs(000,000,000)'..amount..'\\cr)'
			--Creates a Skillchain
			elseif msg == 185 and act.targets[1].actions[1].has_add_effect == true then
				target_action_result = ' (\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr + \\cs('..sc_c_r..','..sc_c_g..','..sc_c_b..')'..sc_amount..'\\cr '..sc_name..')'
				target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr + \\cs(000,000,000)'..sc_amount..'\\cr '..sc_name..')'
			--Plain Damage
			elseif msg == 185 or msg == 317 then
				local info = calculateInfo(act)
				local landed = info.landed
				local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
				count = show_result_totals and target_count > 1 and ' '..landed..(landed < target_count and '/'..target_count or '')..'●' or ''
				target_action_result = ' (\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr'..count..'\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount_total..'\\cr)'
				target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
			--Evaded/No Effect/Resisted/Immunobreak/Anticipated/Blinked/Dodged/Missed
			elseif msg == 282 or msg == 75 or msg == 156 or msg == 189 or msg == 248 or msg == 283 or msg == 323 or msg == 355 or msg == 408 or msg == 422 or msg == 423 or msg == 425 or msg == 659 or msg == 114 or msg == 85 or msg == 284 or msg == 653 or msg == 654 or msg == 655 or msg == 656 or msg == 30 or msg == 31 or msg == 32 or msg == 15 or msg == 63 or msg == 158 or msg == 188 or msg == 245 or msg == 324 or msg == 658 then
				local info = calculateInfo(act)
				local landed = info.landed
				local last_buff_id = info.last_buff_id
				local buff_name = last_buff_id and buff[last_buff_id] and capitalize(buff[last_buff_id].name)
				local damage = info.damage
				if buff_name then
					--redo count to show how many landed out of the total target_count
					count = show_result_totals and target_count > 1 and landed..'/'..target_count..'●' or ''
					target_action_result = ' ('..count..buff_name..')'
					target_action_result_shdw = ' ('..count..buff_name..')'
				elseif damage then
					local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
					count = count == '' and '' or ' '..count
					target_action_result = ' (\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr '..count..'\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount_total..'\\cr)'
					target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr '..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
				else
					--Evaded
					if msg == 282 then
						target_action_result = ' ('..count..'Evaded)'
						target_action_result_shdw = ' ('..count..'Evaded)'
					--No Effect
					elseif msg == 75 or msg == 156 or msg == 189 or msg == 248 or msg == 283 or msg == 323 or msg == 355 or msg == 408 or msg == 422 or msg == 423 or msg == 425 or msg == 659 or msg == 114 then
						target_action_result = ' ('..count..'No Effect)'
						target_action_result_shdw = ' ('..count..'No Effect)'
					--Resisted
					elseif msg == 85 or msg == 284 or msg == 655 or msg == 656 then
						target_action_result = ' ('..count..'Resisted)'
						target_action_result_shdw = ' ('..count..'Resisted)'
					--Immunobreak
					elseif msg == 653 or msg == 654 then
						target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')Immunobreak!\\cr)'
						target_action_result_shdw = ' (\\cs(000,000,000)Immunobreak!\\cr)'
					--Anticipated
					elseif msg == 30 then
						target_action_result = ' ('..count..'Anticipated)'
						target_action_result_shdw = ' ('..count..'Anticipated)'
					--Blinked
					elseif msg == 31 then
						target_action_result = ' ('..count..'Blinked)'
						target_action_result_shdw = ' ('..count..'Blinked)'
					--Dodged
					elseif msg == 32 then
						target_action_result = ' ('..count..'Dodged)'
						target_action_result_shdw = ' ('..count..'Dodged)'
					--Missed
					elseif msg == 15 or msg == 63 or msg == 158 or msg == 188 or msg == 245 or msg == 324 or msg == 658 then
						target_action_result = ' ('..count..'Missed)'
						target_action_result_shdw = ' ('..count..'Missed)'
					end
				end
			--Recover MP
			elseif msg == 224 then
				local info = calculateInfo(act)
				local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
				count = count == '' and '' or ' '..count
				target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr MP'..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount_total..'\\cr)'
				target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr MP'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
			end

		--Spells
		elseif act.category == 4 then
			local action_id = act.param
			local element = spell[action_id] and spell[action_id].element or 15 --15 is 'no element/none'
			local c = color_spells and element_colors[element] or text_color
			local r = formatRGB(c.r)
			local g = formatRGB(c.g)
			local b = formatRGB(c.b)
			action_name = spell[action_id] and ' \\cs('..r..','..g..','..b..')'..truncateAction(spell[action_id].name)..'\\cr' or ' [REDACTED]'
			action_name_shdw = spell[action_id] and ' \\cs(000,000,000)'..truncateAction(spell[action_id].name)..'\\cr' or ' [REDACTED]'
			--Creates a Skillchain
			if msg == 2 and act.targets[1].actions[1].has_add_effect == true then
				target_action_result = ' (\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr + \\cs('..sc_c_r..','..sc_c_g..','..sc_c_b..')'..sc_amount..'\\cr '..sc_name..')'
				target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr + \\cs(000,000,000)'..sc_amount..'\\cr '..sc_name..')'
			--Plain Damage
			elseif msg == 2 then
				local info = calculateInfo(act)
				local landed = info.landed
				local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
				count = show_result_totals and target_count > 1 and ' '..landed..(landed < target_count and '/'..target_count or '')..'●' or ''
				target_action_result = ' (\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr'..count..'\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount_total..'\\cr)'
				target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
			--Absorbed and creates a Skillchain
			elseif msg == 7 and act.targets[1].actions[1].has_add_effect == true then
				target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr + \\cs('..sc_c_r..','..sc_c_g..','..sc_c_b..')'..sc_amount..'\\cr '..sc_name..')'
				target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr + \\cs(000,000,000)'..sc_amount..'\\cr '..sc_name..')'
			--Cures/Absorbed
			elseif msg == 7 then
				local info = calculateInfo(act)
				local amount_total = info.amount_total
				local cure_total = info.cure_total
				count = count == '' and '' or ' '..count
				if cure_total then
					cure_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(cure_total) or ''
					target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr'..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..cure_total..'\\cr)'
					target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr'..count..'\\cs(000,000,000)'..cure_total..'\\cr)'
				else
					amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
					target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr'..count..'\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount_total..'\\cr)'
					target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
				end
			--Transportation
			elseif msg == 93 then
				target_action_result = ' ('..count..'Vanish)'
				target_action_result_shdw = ' ('..count..'Vanish)'
			--Magic Bursts
			elseif msg == 252 then
				local info = calculateInfo(act)
				local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
				count = count == '' and '' or ' '..count
				target_action_result = ' (Magic Burst! \\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr'..count..'\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount_total..'\\cr)'
				target_action_result_shdw = ' (Magic Burst! \\cs(000,000,000)'..amount..'\\cr'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
			--Drain
			elseif msg == 227 or msg == 274 then
				local info = calculateInfo(act)
				local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
				count = count == '' and '' or ' '..count
				target_action_result = ' ('..(msg == 274 and 'Magic Burst! ' or '')..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr HP'..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount_total..'\\cr)'
				target_action_result_shdw = ' ('..(msg == 274 and 'Magic Burst! ' or '')..'\\cs(000,000,000)'..amount..'\\cr HP'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
			--Aspir
			elseif msg == 228 or msg == 275 then
				local info = calculateInfo(act)
				local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
				count = count == '' and '' or ' '..count
				target_action_result = ' ('..(msg == 275 and 'Magic Burst! ' or '')..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr MP'..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount_total..'\\cr)'
				target_action_result_shdw = ' ('..(msg == 275 and 'Magic Burst! ' or '')..'\\cs(000,000,000)'..amount..'\\cr MP'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
			--Absorb-TP
			elseif msg == 454 then
				local info = calculateInfo(act)
				local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
				count = count == '' and '' or ' '..count
				target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr TP'..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount_total..'\\cr)'
				target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr TP'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
			--Buff/Debuff
			elseif msg == 230 or msg == 236 or msg == 237 or msg == 268 or msg == 271 then
				local landed = calculateInfo(act).landed
				local buff_name = (action_id == 0 or action_id == 232) and job_abil[act.param] and capitalize(job_abil[act.param].name) or buff[act.targets[1].actions[1].param] and capitalize(buff[act.targets[1].actions[1].param].name)
				count = show_result_totals and target_count > 1 and landed..(landed < target_count and '/'..target_count or '')..'●' or ''
				target_action_result = ' ('..((msg == 268 or msg == 271) and 'Magic Burst! ' or '')..count..buff_name..')'
				target_action_result_shdw = ' ('..((msg == 268 or msg == 271) and 'Magic Burst! ' or '')..count..buff_name..')'
			--Evaded/No Effect/Resisted/Immunobreak/Anticipated/Blinked/Dodged/Missed
			elseif msg == 282 or msg == 75 or msg == 156 or msg == 189 or msg == 248 or msg == 283 or msg == 323 or msg == 355 or msg == 408 or msg == 422 or msg == 423 or msg == 425 or msg == 659 or msg == 114 or msg == 85 or msg == 284 or msg == 653 or msg == 654 or msg == 655 or msg == 656 or msg == 30 or msg == 31 or msg == 32 or msg == 15 or msg == 63 or msg == 158 or msg == 188 or msg == 245 or msg == 324 or msg == 658 then
				local info = calculateInfo(act)
				local landed = info.landed
				local last_buff_id = info.last_buff_id
				local buff_name = last_buff_id and buff[last_buff_id] and capitalize(buff[last_buff_id].name)
				local damage = info.damage
				if buff_name then
					--redo count to show how many landed out of the total target_count
					count = show_result_totals and target_count > 1 and landed..'/'..target_count..'●' or ''
					target_action_result = ' ('..count..buff_name..')'
					target_action_result_shdw = ' ('..count..buff_name..')'
				elseif damage then
					local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
					count = count == '' and '' or ' '..count
					target_action_result = ' (\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr '..count..'\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount_total..'\\cr)'
					target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr '..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
				else
					--Evaded
					if msg == 282 then
						target_action_result = ' ('..count..'Evaded)'
						target_action_result_shdw = ' ('..count..'Evaded)'
					--No Effect
					elseif msg == 75 or msg == 156 or msg == 189 or msg == 248 or msg == 283 or msg == 323 or msg == 355 or msg == 408 or msg == 422 or msg == 423 or msg == 425 or msg == 659 or msg == 114 then
						target_action_result = ' ('..count..'No Effect)'
						target_action_result_shdw = ' ('..count..'No Effect)'
					--Resisted
					elseif msg == 85 or msg == 284 or msg == 655 or msg == 656 then
						target_action_result = ' ('..count..'Resisted)'
						target_action_result_shdw = ' ('..count..'Resisted)'
					--Immunobreak
					elseif msg == 653 or msg == 654 then
						target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')Immunobreak!\\cr)'
						target_action_result_shdw = ' (\\cs(000,000,000)Immunobreak!\\cr)'
					--Anticipated
					elseif msg == 30 then
						target_action_result = ' ('..count..'Anticipated)'
						target_action_result_shdw = ' ('..count..'Anticipated)'
					--Blinked
					elseif msg == 31 then
						target_action_result = ' ('..count..'Blinked)'
						target_action_result_shdw = ' ('..count..'Blinked)'
					--Dodged
					elseif msg == 32 then
						target_action_result = ' ('..count..'Dodged)'
						target_action_result_shdw = ' ('..count..'Dodged)'
					--Missed
					elseif msg == 15 or msg == 63 or msg == 158 or msg == 188 or msg == 245 or msg == 324 or msg == 658 then
						target_action_result = ' ('..count..'Missed)'
						target_action_result_shdw = ' ('..count..'Missed)'
					end
				end
			--Dispel/Erase
			elseif msg == 83 or msg == 341 or msg == 342 then
				local buff_name = capitalize(buff[act.targets[1].actions[1].param].name)
				target_action_result = ' ('..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..buff_name..'\\cr)'
				target_action_result_shdw = ' ('..count..'\\cs(000,000,000)'..buff_name..'\\cr)'
			--TP reduced
			elseif msg == 431 then
				target_action_result = ' ('..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')TP Reduced\\cr)'
				target_action_result_shdw = ' ('..count..'\\cs(000,000,000)TP Reduced\\cr)'
			end

		--Items
		elseif act.category == 5 then
			local item_id = act.param
			local item_name = item[item_id] and item[item_id].name or '[REDACTED]'
			action_name = ' '..truncateAction(item_name)
			action_name_shdw = ' '..truncateAction(item_name)
			local buff_name = buff[act.targets[1].actions[1].param] and capitalize(buff[act.targets[1].actions[1].param].name)
			local obtained_item_name = item[act.targets[1].actions[1].param] and capitalize(item[act.targets[1].actions[1].param].name)
			--HP
			if msg == 24 then
				local info = calculateInfo(act)
				local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
				count = count == '' and '' or ' '..count
				target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr HP'..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount_total..'\\cr)'
				target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr HP'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
			--MP
			elseif msg == 25 then
				local info = calculateInfo(act)
				local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
				target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr MP'..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount_total..'\\cr)'
				target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr MP'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
			--HP and MP
			elseif msg == 26 then
				local info = calculateInfo(act)
				local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
				count = count == '' and '' or ' '..count
				target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr HP/MP'..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount_total..'\\cr)'
				target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr HP/MP'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
			--Buff/Debuff
			elseif msg == 375 then
				local landed = calculateInfo(act).landed
				count = show_result_totals and target_count > 1 and landed..(landed < target_count and '/'..target_count or '')..'●' or ''
				target_action_result = ' ('..count..buff_name..')'
				target_action_result_shdw = ' ('..count..buff_name..')'
			--Dispel/Erase
			elseif msg == 378 then
				target_action_result = ' ('..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..buff_name..'\\cr)'
				target_action_result_shdw = ' ('..count..'\\cs(000,000,000)'..buff_name..'\\cr)'
			--Obtains item
			elseif msg == 376 or msg == 377 then
				target_action_result = ' ('..count..obtained_item_name..')'
				target_action_result_shdw = ' ('..count..obtained_item_name..')'
			--No Effect
			elseif msg == 408 then
				local info = calculateInfo(act)
				local landed = info.landed
				local last_buff_id = info.last_buff_id
				local buff_name = last_buff_id and buff[last_buff_id] and capitalize(buff[last_buff_id].name)
				if buff_name then
					--redo count to show how many landed out of the total target_count
					count = show_result_totals and target_count > 1 and landed..'/'..target_count..'●' or ''
					target_action_result = ' ('..count..buff_name..')'
					target_action_result_shdw = ' ('..count..buff_name..')'
				else
					--No Effect
					target_action_result = ' ('..count..'No Effect)'
					target_action_result_shdw = ' ('..count..'No Effect)'
				end
			end

		--Pets
		elseif act.category == 13 then
			local action_id = act.param
			action_name = job_abil[action_id] and ' '..truncateAction(job_abil[action_id].name) or (monster_abil[action_id] and ' '..truncateAction(monster_abil[action_id].name) or ' [REDACTED]')
			action_name_shdw = job_abil[action_id] and ' '..truncateAction(job_abil[action_id].name) or (monster_abil[action_id] and ' '..truncateAction(monster_abil[action_id].name) or ' [REDACTED]')
			--Creates a Skillchain
			if act.targets[1].actions[1].has_add_effect then
				target_action_result = ' (\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr + \\cs('..sc_c_r..','..sc_c_g..','..sc_c_b..')'..sc_amount..'\\cr '..sc_name..')'
				target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr + \\cs(000,000,000)'..sc_amount..'\\cr '..sc_name..')'
			--Accuracy/Evasion Down
			elseif msg == 144 then
				target_action_result = ' ('..count..'Acc./Eva. Down)'
				target_action_result_shdw = ' ('..count..'Acc./Eva. Down)'
			--Accuracy/Evasion Down
			elseif msg == 146 then
				target_action_result = ' ('..count..'Acc./Eva. Boost)'
				target_action_result_shdw = ' ('..count..'Acc./Eva. Boost)'
			--Magic Burst
			elseif msg == 379 then
				local info = calculateInfo(act)
				local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
				count = count == '' and '' or ' '..count
				target_action_result = ' (Magic Burst! \\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr'..count..'\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount_total..'\\cr)'
				target_action_result_shdw = ' (Magic Burst! \\cs(000,000,000)'..amount..'\\cr'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
			--Plain Damage
			elseif msg == 317 then
				local info = calculateInfo(act)
				local landed = info.landed
				local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
				count = show_result_totals and target_count > 1 and ' '..landed..(landed < target_count and '/'..target_count or '')..'●' or ''
				target_action_result = ' (\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr'..count..'\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount_total..'\\cr)'
				target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
			--Cures
			elseif msg == 318 then
				local info = calculateInfo(act)
				local amount_total = info.amount_total
				local cure_total = info.cure_total
				count = count == '' and '' or ' '..count
				if cure_total then
					cure_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(cure_total) or ''
					target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr'..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..cure_total..'\\cr)'
					target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr'..count..'\\cs(000,000,000)'..cure_total..'\\cr)'
				else
					amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
					target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr'..count..'\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount_total..'\\cr)'
					target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
				end
			--Buff/Debuff
			elseif msg == 319 or msg == 320 then
				local landed = calculateInfo(act).landed
				local buff_name = (action_id == 0 or action_id == 232) and job_abil[act.param] and capitalize(job_abil[act.param].name) or buff[act.targets[1].actions[1].param] and capitalize(buff[act.targets[1].actions[1].param].name)
				count = show_result_totals and target_count > 1 and landed..(landed < target_count and '/'..target_count or '')..'●' or ''
				target_action_result = ' ('..count..buff_name..')'
				target_action_result_shdw = ' ('..count..buff_name..')'
			--Erase/Dispel
			elseif msg == 321 or msg == 322 then
				local buff_name = buff[act.targets[1].actions[1].param] and capitalize(buff[act.targets[1].actions[1].param].name)
				target_action_result = ' ('..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..''..buff_name..'\\cr)'
				target_action_result_shdw = ' ('..count..'\\cs(000,000,000'..buff_name..'\\cr)'
			--Evaded/No Effect/Resisted/Immunobreak/Anticipated/Blinked/Dodged/Missed
			elseif msg == 282 or msg == 75 or msg == 156 or msg == 189 or msg == 248 or msg == 283 or msg == 323 or msg == 355 or msg == 408 or msg == 422 or msg == 423 or msg == 425 or msg == 659 or msg == 114 or msg == 85 or msg == 284 or msg == 653 or msg == 654 or msg == 655 or msg == 656 or msg == 30 or msg == 31 or msg == 32 or msg == 15 or msg == 63 or msg == 158 or msg == 188 or msg == 245 or msg == 324 or msg == 658 then
				local info = calculateInfo(act)
				local landed = info.landed
				local last_buff_id = info.last_buff_id
				local buff_name = last_buff_id and buff[last_buff_id] and capitalize(buff[last_buff_id].name)
				local damage = info.damage
				if buff_name then
					--redo count to show how many landed out of the total target_count
					count = show_result_totals and target_count > 1 and landed..'/'..target_count..'●' or ''
					target_action_result = ' ('..count..buff_name..')'
					target_action_result_shdw = ' ('..count..buff_name..')'
				elseif damage then
					local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
					count = count == '' and '' or ' '..count
					target_action_result = ' (\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr '..count..'\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount_total..'\\cr)'
					target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr '..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
				else
					--Evaded
					if msg == 282 then
						target_action_result = ' ('..count..'Evaded)'
						target_action_result_shdw = ' ('..count..'Evaded)'
					--No Effect
					elseif msg == 75 or msg == 156 or msg == 189 or msg == 248 or msg == 283 or msg == 323 or msg == 355 or msg == 408 or msg == 422 or msg == 423 or msg == 425 or msg == 659 or msg == 114 then
						target_action_result = ' ('..count..'No Effect)'
						target_action_result_shdw = ' ('..count..'No Effect)'
					--Resisted
					elseif msg == 85 or msg == 284 or msg == 655 or msg == 656 then
						target_action_result = ' ('..count..'Resisted)'
						target_action_result_shdw = ' ('..count..'Resisted)'
					--Immunobreak
					elseif msg == 653 or msg == 654 then
						target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')Immunobreak!\\cr)'
						target_action_result_shdw = ' (\\cs(000,000,000)Immunobreak!\\cr)'
					--Anticipated
					elseif msg == 30 then
						target_action_result = ' ('..count..'Anticipated)'
						target_action_result_shdw = ' ('..count..'Anticipated)'
					--Blinked
					elseif msg == 31 then
						target_action_result = ' ('..count..'Blinked)'
						target_action_result_shdw = ' ('..count..'Blinked)'
					--Dodged
					elseif msg == 32 then
						target_action_result = ' ('..count..'Dodged)'
						target_action_result_shdw = ' ('..count..'Dodged)'
					--Missed
					elseif msg == 15 or msg == 63 or msg == 158 or msg == 188 or msg == 245 or msg == 324 or msg == 658 then
						target_action_result = ' ('..count..'Missed)'
						target_action_result_shdw = ' ('..count..'Missed)'
					end
				end
			--Stat Boost
			elseif msg == 364 then
				target_action_result = ' ('..count..'Stat Boost)'
				target_action_result_shdw = ' ('..count..'Stat Boost)'
			--TP Reduced
			elseif msg == 730 then
				target_action_result = ' (TP Reduced to \\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr)'
				target_action_result_shdw = ' (TP Reduced to \\cs(000,000,000)'..amount..'\\cr)'
			--Enmity Reduced
			elseif msg == 743 then
				target_action_result = ' ('..count..'Enmity Reduced)'
				target_action_result_shdw = ' ('..count..'Enmity Reduced)'
			--Absorbed
			elseif msg == 802 then
				local info = calculateInfo(act)
				local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
				count = count == '' and '' or ' '..count
				target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr'..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount_total..'\\cr)'
				target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
			end
		end

		target_action = action_name..action_target_name
		target_action_shdw = action_name_shdw..action_target_name_shdw

		--The actor is our pet
		if get_mob_by_id(act.actor_id).index == get_mob_by_id(player.id).pet_index then

			bars_meter_self_action:bg_color(050,255,050)
			completeSelfMeter()

			addToActionsTable(player.id,target_action,target_action_shdw,target_action_status,target_action_status_shdw,target_action_result,target_action_result_shdw,trackingIndex)
			addToActionsTable(act.actor_id,target_action,target_action_shdw,target_action_status,target_action_status_shdw,target_action_result,target_action_result_shdw,trackingIndex)

			if act.param ~= nil then

				coroutine.schedule(function()
					removeFromActionsTable(player.id, trackingIndex)
					removeFromActionsTable(act.actor_id, trackingIndex)
				end, clear_action_delay)

			end
		else

			if player.id == act.actor_id then
				bars_meter_self_action:bg_color(050,255,050)
				completeSelfMeter()
			end

			addToActionsTable(act.actor_id,target_action,target_action_shdw,target_action_status,target_action_status_shdw,target_action_result,target_action_result_shdw,trackingIndex)

			if act.param ~= nil then

				coroutine.schedule(function()
					removeFromActionsTable(act.actor_id, trackingIndex)
				end, clear_action_delay)

			end
		end

	--Finish Monster TP move(11)
	elseif act and act.category == 11 and not nm_auto_tp then

		local target_action_status = '\\cs(050,255,050)√\\cr'
		local target_action_status_shdw = '\\cs(000,000,000)√\\cr'
		local abil_id = act.param
		local abil_name = monster_abil[abil_id] and monster_abil[abil_id].name or '[REDACTED]'
		action_name = ' '..truncateAction(abil_name)
		action_name_shdw = ' '..truncateAction(abil_name)
		target_action = action_name..action_target_name
		target_action_shdw = action_name_shdw..action_target_name_shdw

		--Dispel/Erase
		if msg == 159 then
			local buff_name = buff[act.targets[1].actions[1].param] and capitalize(buff[act.targets[1].actions[1].param].name)
			target_action_result = ' ('..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..buff_name..'\\cr)'
			target_action_result_shdw = ' ('..count..'\\cs(000,000,000)'..buff_name..'\\cr)'
		--Buff/Debuff
		elseif msg == 186 or msg == 194 or msg == 243 then
			local landed = calculateInfo(act).landed
			local buff_name = (action_id == 0 or action_id == 232) and job_abil[act.param] and capitalize(job_abil[act.param].name) or buff[act.targets[1].actions[1].param] and capitalize(buff[act.targets[1].actions[1].param].name)
			count = show_result_totals and target_count > 1 and landed..(landed < target_count and '/'..target_count or '')..'●' or ''
			target_action_result = ' ('..count..buff_name..')'
			target_action_result_shdw = ' ('..count..buff_name..')'
		--Plain Damage
		elseif msg == 185 then
			local info = calculateInfo(act)
			local landed = info.landed
			local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
			count = show_result_totals and target_count > 1 and ' '..landed..(landed < target_count and '/'..target_count or '')..'●' or ''
			target_action_result = ' (\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr'..count..'\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount_total..'\\cr)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
		--Drain
		elseif msg == 187 then
			local info = calculateInfo(act)
			local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
			count = count == '' and '' or ' '..count
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr HP'..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount_total..'\\cr)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr HP'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
		--Evaded/No Effect/Resisted/Immunobreak/Anticipated/Blinked/Dodged/Missed
		elseif msg == 282 or msg == 75 or msg == 156 or msg == 189 or msg == 248 or msg == 283 or msg == 323 or msg == 355 or msg == 408 or msg == 422 or msg == 423 or msg == 425 or msg == 659 or msg == 114 or msg == 85 or msg == 284 or msg == 653 or msg == 654 or msg == 655 or msg == 656 or msg == 30 or msg == 31 or msg == 32 or msg == 15 or msg == 63 or msg == 158 or msg == 188 or msg == 245 or msg == 324 or msg == 658 then
			local info = calculateInfo(act)
			local landed = info.landed
			local last_buff_id = info.last_buff_id
			local buff_name = last_buff_id and buff[last_buff_id] and capitalize(buff[last_buff_id].name)
			local damage = info.damage
			if buff_name then
				--redo count to show how many landed out of the total target_count
				count = show_result_totals and target_count > 1 and landed..'/'..target_count..'●' or ''
				target_action_result = ' ('..count..buff_name..')'
				target_action_result_shdw = ' ('..count..buff_name..')'
				elseif damage then
					local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
					count = count == '' and '' or ' '..count
					target_action_result = ' (\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr '..count..'\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount_total..'\\cr)'
					target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr '..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
			else
				--Evaded
				if msg == 282 then
					target_action_result = ' ('..count..'Evaded)'
					target_action_result_shdw = ' ('..count..'Evaded)'
				--No Effect
				elseif msg == 75 or msg == 156 or msg == 189 or msg == 248 or msg == 283 or msg == 323 or msg == 355 or msg == 408 or msg == 422 or msg == 423 or msg == 425 or msg == 659 or msg == 114 then
					target_action_result = ' ('..count..'No Effect)'
					target_action_result_shdw = ' ('..count..'No Effect)'
				--Resisted
				elseif msg == 85 or msg == 284 or msg == 655 or msg == 656 then
					target_action_result = ' ('..count..'Resisted)'
					target_action_result_shdw = ' ('..count..'Resisted)'
				--Immunobreak
				elseif msg == 653 or msg == 654 then
					target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')Immunobreak!\\cr)'
					target_action_result_shdw = ' (\\cs(000,000,000)Immunobreak!\\cr)'
				--Anticipated
				elseif msg == 30 then
					target_action_result = ' ('..count..'Anticipated)'
					target_action_result_shdw = ' ('..count..'Anticipated)'
				--Blinked
				elseif msg == 31 then
					target_action_result = ' ('..count..'Blinked)'
					target_action_result_shdw = ' ('..count..'Blinked)'
				--Dodged
				elseif msg == 32 then
					target_action_result = ' ('..count..'Dodged)'
					target_action_result_shdw = ' ('..count..'Dodged)'
				--Missed
				elseif msg == 15 or msg == 63 or msg == 158 or msg == 188 or msg == 245 or msg == 324 or msg == 658 then
					target_action_result = ' ('..count..'Missed)'
					target_action_result_shdw = ' ('..count..'Missed)'
				end
			end
		--Aspir
		elseif msg == 225 then
			local info = calculateInfo(act)
			local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
			count = count == '' and '' or ' '..count
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr MP'..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount_total..'\\cr)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr MP'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
		--Absorb-TP
		elseif msg == 226 then
			local info = calculateInfo(act)
			local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
			count = count == '' and '' or ' '..count
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr TP'..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount_total..'\\cr)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr TP'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
		--Absorbed
		elseif msg == 238 then
			local info = calculateInfo(act)
			local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
			count = count == '' and '' or ' '..count
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr'..count..'\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount_total..'\\cr)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr'..count..'\\cs(000,000,000)'..amount_total..'\\cr)'
		--Stat Boost
		elseif msg == 762 then
			target_action_result = ' ('..count..'Stat Boost)'
			target_action_result_shdw = ' ('..count..'Stat Boost)'
		end

		if show_target_action and action_name ~= ' [REDACTED]' then

			local trackingIndex = assignIndex()

			addToActionsTable(act.actor_id,target_action,target_action_shdw,target_action_status,target_action_status_shdw,target_action_result,target_action_result_shdw,trackingIndex)

			coroutine.schedule(function()
				removeFromActionsTable(act.actor_id, trackingIndex)
			end, clear_action_delay)

		end

		if highlight_when_sp_active then

			local time = nil

			if abil_name ~= "[REDACTED]" then
				time = sp_abils[abil_name]
			end

			if time then
				addToSPTable(act.actor_id, abil_name)
				coroutine.schedule(function()
					removeFromSPTable(act.actor_id)
				end, time)
			end

		end

	end
end)

--Unrecognized command
local function displayUnregnizedCommand()
	add_to_chat(8,('[Bars] '):color(220)..('Unrecognized command. Type'):color(8)..(' //bars help'):color(1)..(' for a list of commands.'):color(8))
end

windower.register_event('addon command',function(addcmd, ...)

	--Update the bar position
	if addcmd == 'pos' or addcmd == 'position' or addcmd == 'p' then
		local pos = {...}

		--If there are not enough parameters then output the current position and remind how to update
		if #pos < 2 then
			add_to_chat(8,('[Bars] '):color(220)..('Position:'):color(36)..(' '..settings.pos.x..' '..settings.pos.y):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding X and Y coordinates (ex. '):color(8)..('//bars pos 100 200'):color(1)..(')'):color(8))

		--X and Y coordinates are provided
		else
			--Take the provided string parameters and turn them into numbers
			settings.pos.x = tonumber(pos[1])
			settings.pos.y = tonumber(pos[2])
			
			--Position must be numbers
			if settings.pos.x == nil or settings.pos.y == nil then
				displayUnregnizedCommand()
				return
				
			--Save the new setting, update the position, then alert the user
			else
				settings:save('all')
				add_to_chat(8,('[Bars] '):color(220)..('Position:'):color(36)..(' '..settings.pos.x..' '..settings.pos.y):color(200))
				setPosition()

			end
		end
		screenTest()

	--Update the bar width
	elseif addcmd == 'width' or addcmd == 'w' then
		local width = {...}
		local new_width = nil

		--If there are no parameters then output the current bar width and remind how to update
		if #width < 1 then
			add_to_chat(8,('[Bars] '):color(220)..('Width:'):color(36)..(' '..settings.options.bar_width):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars width 73'):color(1)..(')'):color(8))

		--Size number is provided
		else
			--Take the provided string parameter and turn it into a number
			new_width = tonumber(width[1])
					
			--Save the new setting, update the width, then alert the user
			if new_width == nil then
				displayUnregnizedCommand()
				return

			else
				settings.options.bar_width = new_width
				settings:save('all')
				add_to_chat(8,('[Bars] '):color(220)..('Width:'):color(36)..(' '..settings.options.bar_width):color(200))
				hideBars()
				setWidth()
				setPosition()
				updateHPBar()
				updateMPBar()
				updateTPBar()
				showBars()

			end
		end
		screenTest()

	--Toggle the HP bar display setting for the current job
	elseif addcmd == 'hp' then

		show_bars[job].hp = not show_bars[job].hp
		settings:save('all')
		hideBars()
		setPosition()
		showBars()
		add_to_chat(8,('[Bars] '):color(220)..('HP bar display for '..uppercase(job)..':'):color(36)..(' %s':format(show_bars[job].hp and 'ON' or 'OFF')):color(200))

	--Toggle the MP bar display setting for the current job
	elseif addcmd == 'mp' then

		show_bars[job].mp = not show_bars[job].mp
		settings:save('all')
		hideBars()
		setPosition()
		showBars()
		add_to_chat(8,('[Bars] '):color(220)..('MP bar display for '..uppercase(job)..':'):color(36)..(' %s':format(show_bars[job].mp and 'ON' or 'OFF')):color(200))

	--Toggle the TP bar display setting for the current job
	elseif addcmd == 'tp' then

		show_bars[job].tp = not show_bars[job].tp
		settings:save('all')
		hideBars()
		setPosition()
		showBars()
		add_to_chat(8,('[Bars] '):color(220)..('TP bar display for '..uppercase(job)..':'):color(36)..(' %s':format(show_bars[job].tp and 'ON' or 'OFF')):color(200))

	--Toggle the Pet bar display setting for the current job
	elseif addcmd == 'pet' then

		show_bars[job].pet = not show_bars[job].pet
		settings:save('all')
		hideBars()
		setPosition()
		showBars()
		add_to_chat(8,('[Bars] '):color(220)..('Pet bar display for '..uppercase(job)..':'):color(36)..(' %s':format(show_bars[job].pet and 'ON' or 'OFF')):color(200))

	--Update the vertical offset for the current job
	elseif addcmd == 'offset' or addcmd == 'o' then
		local offset = {...}
		local new_offset = nil

		--If there are no parameters then output the current offset and remind how to update
		if #offset < 1 then
			add_to_chat(8,('[Bars] '):color(220)..('Vertical Offset for '..uppercase(job)..':'):color(36)..(' '..show_bars[job].vertical_offset):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars offset 29'):color(1)..(')'):color(8))

		--Size number is provided
		else
			--Take the provided string parameter and turn it into a number
			new_offset = tonumber(offset[1])

			--Save the new setting, update the offset, then alert the user
			if new_offset == nil then
				displayUnregnizedCommand()
				return

			else
				show_bars[job].vertical_offset = new_offset
				settings:save('all')
				add_to_chat(8,('[Bars] '):color(220)..('Vertical Offset for '..uppercase(job)..':'):color(36)..(' '..show_bars[job].vertical_offset):color(200))
				hideBars()
				setPosition()
				showBars()

			end
		end
		screenTest()

	--Update the size
	elseif addcmd == 'size' or addcmd == 's' then
		local size = {...}
		local new_size = nil

		--If there are no parameters then output the current size and remind how to update
		if #size < 1 then
			add_to_chat(8,('[Bars] '):color(220)..('Size:'):color(36)..(' '..settings.text.size):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars size 10'):color(1)..(')'):color(8))

		--Size number is provided
		else
			--Take the provided string parameter and turn it into a number
			new_size = tonumber(size[1])
					
			--Save the new setting, update the size, then alert the user
			if new_size == nil then
				displayUnregnizedCommand()
				return

			else
				settings.text.size = new_size
				settings:save('all')
				add_to_chat(8,('[Bars] '):color(220)..('Size:'):color(36)..(' '..settings.text.size):color(200))
				setSize()

			end
		end
		screenTest()

	--Toggle the target distance setting
	elseif addcmd == 'distance' or addcmd == 'dist' or addcmd == 'd' then

		settings.options.show_target_distance = not settings.options.show_target_distance
		show_target_distance = settings.options.show_target_distance
		settings:save('all')
		add_to_chat(8,('[Bars] '):color(220)..('Distance:'):color(36)..(' %s':format(settings.options.show_target_distance and 'ON' or 'OFF')):color(200))

	--Toggle the markers setting
	elseif addcmd == 'marker' or addcmd == 'markers' or addcmd == 'm' then

		settings.options.show_bar_markers = not settings.options.show_bar_markers
		settings:save('all')
		add_to_chat(8,('[Bars] '):color(220)..('Markers:'):color(36)..(' %s':format(settings.options.show_bar_markers and 'ON' or 'OFF')):color(200))
		hideBars()
		setWidth()
		showBars()

	--Toggle the hex setting
	elseif addcmd == 'hex' or addcmd == 'h' then

		settings.options.show_target_hex = not settings.options.show_target_hex
		show_target_hex = settings.options.show_target_hex
		settings.options.show_target_index = false
		show_target_index = false
		settings:save('all')
		add_to_chat(8,('[Bars] '):color(220)..('Hex:'):color(36)..(' %s':format(settings.options.show_target_hex and 'ON' or 'OFF')):color(200))
		updateTarget()

	--Toggle the index setting
	elseif addcmd == 'index' or addcmd == 'i' then

		settings.options.show_target_index = not settings.options.show_target_index
		show_target_index = settings.options.show_target_index
		settings.options.show_target_hex = false
		show_target_hex = false
		settings:save('all')
		add_to_chat(8,('[Bars] '):color(220)..('Index:'):color(36)..(' %s':format(settings.options.show_target_index and 'ON' or 'OFF')):color(200))
		updateTarget()

	--Toggle the bold setting
	elseif addcmd == 'bold' or addcmd == 'b' then

		settings.flags.bold = not settings.flags.bold
		settings:save('all')
		add_to_chat(8,('[Bars] '):color(220)..('Bold:'):color(36)..(' %s':format(settings.flags.bold and 'ON' or 'OFF')):color(200))
		setBold()
		screenTest()

	--Add a target to the Auto Focus Target list
	elseif addcmd == 'add' or addcmd == 'a' then

		local target = {...}
		addToAutoFocusTargetList(target)

	--Remove a target from the Auto Focus Target list
	elseif addcmd == 'remove' or addcmd == 'rem' or addcmd == 'rmv' or addcmd == 'r' then

		local target = {...}
		removeFromAutoFocusTargetList(target)

	--Display the Auto Focus Target list
	elseif addcmd == 'list' or addcmd == 'l' then

		listAutoFocusTargets()

	--Focus Target Override
	elseif addcmd == 'focus' or addcmd == 'f' then

		--Remove the current Focus Target Override
		if focus_target_override then
			add_to_chat(8,('[Bars] '):color(220)..('Focus Target Override Removed: '):color(36)..(focus_target_override.name):color(1))
			focus_target_override = nil
		--Create a new Focus Target Override
		else
			local target = get_mob_by_target('t')
			if target then
				focus_target_override = target
				local currFTMDist = settings.options.focus_target_max_distance
				add_to_chat(8,('[Bars] '):color(220)..('Focus Target Override Added: '):color(36)..(focus_target_override.name):color(1))
				add_to_chat(8,('[Bars] '):color(220)..('Override removed when out of range ('):color(8)..(''..currFTMDist):color(200)..(') or by typing '):color(8)..('//bars focus'):color(1)..(' again.'):color(8))
			else
				add_to_chat(8,('[Bars] '):color(220)..('Please select a target with your cursor and try again.'):color(8))
			end
		end

	--Display help text
	elseif addcmd == 'help' then

		local currPos = settings.pos
		local currHP = show_bars[job].hp
		local currMP = show_bars[job].mp
		local currTP = show_bars[job].tp
		local currPet = show_bars[job].pet
		local currWidth = settings.options.bar_width
		local currDistance = settings.options.show_target_distance
		local currMarker = settings.options.show_bar_markers
		local currHex = settings.options.show_target_hex
		local currIndex = settings.options.show_target_index
		local currJob = uppercase(job)
		local currOffset = show_bars[job].vertical_offset
		local currSize = settings.text.size
		local currBold = settings.flags.bold
		local currFTMDist = settings.options.focus_target_max_distance

		local prefix = "//bars"
		add_to_chat(8,('[Bars] '):color(220)..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220)..(' ('):color(8)..(prefix):color(1)..(')'):color(8))
		add_to_chat(8,(' Command '):color(36)..('[optional]'):color(53)..(' - Description ['):color(8)..('Current Setting'):color(200)..(']'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,(' pos/p '):color(36)..('[x y]'):color(53)..(' - Update overall Position. ['):color(8)..(currPos.x..' '..currPos.y):color(200)..(']'):color(8))
		add_to_chat(8,(' hp/mp/tp/pet'):color(36)..(' - Toggle HP/MP/TP/Pet bar display setting for current job.'):color(8))
		add_to_chat(8,('   ['..currJob..' - HP: '):color(8)..('%s':format(currHP and 'ON' or 'OFF')):color(200)..(' MP: '):color(8)..('%s':format(currMP and 'ON' or 'OFF')):color(200)..(' TP: '):color(8)..('%s':format(currTP and 'ON' or 'OFF')):color(200)..(' Pet: '):color(8)..('%s':format(currPet and 'ON' or 'OFF')):color(200)..(']'):color(8))
		add_to_chat(8,(' width/w '):color(36)..('[#]'):color(53)..(' - Update the bar Width. ['):color(8)..(''..currWidth):color(200)..(']'):color(8))
		add_to_chat(8,(' distance/d '):color(36)..(' - Toggle the target Distance option. ['):color(8)..('%s':format(currDistance and 'ON' or 'OFF')):color(200)..(']'):color(8))
		add_to_chat(8,(' marker/m '):color(36)..(' - Toggle the HP/TP Marker option. ['):color(8)..('%s':format(currMarker and 'ON' or 'OFF')):color(200)..(']'):color(8))
		add_to_chat(8,(' hex/h '):color(36)..(' - Toggle the target Hex option (overrides Index). ['):color(8)..('%s':format(currHex and 'ON' or 'OFF')):color(200)..(']'):color(8))
		add_to_chat(8,(' index/i '):color(36)..(' - Toggle the target Index option (overrides Hex). ['):color(8)..('%s':format(currIndex and 'ON' or 'OFF')):color(200)..(']'):color(8))
		add_to_chat(8,(' offset/o '):color(36)..('[#]'):color(53)..(' - Update the vertical Offset for the current job. ['..currJob..': '):color(8)..(''..currOffset):color(200)..(']'):color(8))
		add_to_chat(8,(' add/a '):color(36)..('[target]'):color(53)..(' - Add a target to the Auto Focus Target list.'):color(8))
		add_to_chat(8,('   - Valid targets: Names, IDs, <t>, or current highlighted target.'):color(8))
		add_to_chat(8,('   - Use quotes to surround names with spaces.'):color(8))
		add_to_chat(8,(' remove/r '):color(36)..('[target]'):color(53)..(' - Remove a target from the Auto Focus Target list.'):color(8))
		add_to_chat(8,(' focus/f '):color(36)..(' - Temporarily override the Auto Focus Target with the current cursor target.'):color(8))
		add_to_chat(8,('   - Type again to remove the override.'):color(8))
		add_to_chat(8,('   - Automatically removed when target moves out of range. ['):color(8)..(''..currFTMDist):color(200)..(']'):color(8))
		add_to_chat(8,(' list/l'):color(36)..(' - Show the Auto Focus Target list.'):color(8))
		add_to_chat(8,(' size/s '):color(36)..('[#]':color(53))..(' - Update font Size. ['):color(8)..(''..currSize):color(200)..(']'):color(8))
		add_to_chat(8,(' bold/b'):color(36)..(' - Toggle the Bold setting. ['):color(8)..('%s':format(currBold and 'ON' or 'OFF')):color(200)..(']'):color(8))

	else

		displayUnregnizedCommand()

	end
end)
