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
_addon.version = '4.4.5'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'bars'}

config = require('config')
files = require('files')
images = require('images')
packets = require('packets')
res = require('resources')
texts = require('texts')
require 'chat'
math.randomseed(os.time())

add_to_chat = windower.add_to_chat
file_exists = windower.file_exists
get_info = windower.ffxi.get_info
get_items = windower.ffxi.get_items
get_mob_array = windower.ffxi.get_mob_array
get_mob_by_id = windower.ffxi.get_mob_by_id
get_mob_by_name = windower.ffxi.get_mob_by_name
get_mob_by_target = windower.ffxi.get_mob_by_target
get_party_info = windower.ffxi.get_party_info
get_player = windower.ffxi.get_player
get_windower_settings = windower.get_windower_settings
register_event = windower.register_event
windower_path = windower.windower_path

defaults = {
	bg = {alpha = 240, red = 0, green = 0, blue = 0},
	text = {alpha = 255, blue = 255, green = 255, red = 255, size = 10, font = 'Consolas'},
	icons = {
		casting = "≈",
		cancelled = "×",
		completed = "√",
		monster_target = "►",
		monster_target_aoe = "○",
		number_of_targets_hit = "●",
		target_lock_left = "»",
		target_lock_right = "«",
		targeting = "→",
		truncate = "…",
	},
	first_run = true,
	job_specific = {
		brd = {hp = false, mp = false, pet = false, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		blm = {hp = false, mp = false, pet = false, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		blu = {hp = false, mp = false, pet = false, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		bst = {hp = false, mp = false, pet = true, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		cor = {hp = false, mp = false, pet = false, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		dnc = {hp = false, mp = false, pet = false, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		drg = {hp = false, mp = false, pet = true, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		drk = {hp = false, mp = false, pet = false, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		geo = {hp = false, mp = false, pet = true, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		mnk = {hp = false, mp = false, pet = false, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		nin = {hp = false, mp = false, pet = false, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		pld = {hp = false, mp = false, pet = false, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		pup = {hp = false, mp = false, pet = true, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		rdm = {hp = false, mp = false, pet = false, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		rng = {hp = false, mp = false, pet = false, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		run = {hp = false, mp = false, pet = false, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		sam = {hp = false, mp = false, pet = false, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		sch = {hp = false, mp = false, pet = false, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		smn = {hp = false, mp = false, pet = true, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		thf = {hp = false, mp = false, pet = false, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		war = {hp = false, mp = false, pet = false, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
		whm = {hp = false, mp = false, pet = false, tp = false,
			vertical_offsets = {
				target = 0, sub_target = 0, focus_target = 0, self_action = 0, player_stats = 0
			},
		},
	},
	options = {
		abbreviate_common_mob_names = true,
		animations = {
			drain_brightness = 6,
			drain_hp_bar = true,
			drain_mp_bar = true,
			drain_pet_bar = true,
			drain_speed = 5,
			drain_target_bars = true,
			drain_tp_bar = true,
			fade_after_a_delay = true,
			fade_delay = 60,
			fade_down_to_alpha = 0,
			fade_speed = 2,
			floating_tp_number = false,
			pulse_bar_when_target_sp_active = true,
			pulse_brightness = 150,
			pulse_name_when_target_sp_active = true,
			pulse_speed = 5,
			pulse_tp_meter_only = false,
			pulse_when_hp_low = true,
			pulse_when_mp_low = true,
			pulse_when_pet_low = true,
			pulse_when_tp_ready = true,
		},
		clear_action_delay = 5.5,
		colorize_spells = true,
		condense_target_and_subtarget_bars = false,
		condense_target_name_and_sp_name = {
			focus_target = true,
			sub_target = true,
			target = true,
		},
		debuffs = {
			blacklist = true,
			duration_cap = 642,
			list = S{},
		},
		flip_doom_timer_coloring = false,
		focus_target_max_distance = 40,
		hide_pet_bar_when_no_pet = true,
		hide_player_stats_bars_when_no_target = false,
		max_action_length = 17,
		max_monster_target_length = 8,
		max_name_length = 20,
		monster_target_confidence_timer = 6,
		remove_tachi_blade_from_ws_name = true,
		short_skillchain_names = true,
		show_action_status_indicators = true,
		show_commas_on_numbers = true,
		show_dyna_jobs = true,
		show_fancy_rolls = true,
		show_focus_target_when_targeted = false,
		show_hp_tp_markers = true,
		show_max_hp_mp_on_bar = true,
		show_pet_distance = true,
		show_pet_status = true,
		show_pet_tp = true,
		show_result_totals = true,
		show_roll_lucky_info = true,
		show_self_action_result = true,
		show_self_when_sub_targeted = true,
		show_self_when_targeted = false,
		show_sub_target_when_targeted = true,
		show_target_action = true,
		show_target_action_result = true,
		show_target_distance = true,
		show_target_distance_colors = true,
		show_target_hex = false,
		show_target_index = false,
		show_target_lock = true,
		update_intervals = {
			aggro_list = 0.2,
			focus_target = 0.05,
			party_actions = 0.05,
			player_stats_pet = 0.05,
			sub_target = 0.05,
			target = 0.05,
		},
	},
	sections = {
		aggro_list = {
			bg_alpha = 150,
			bold = true,
			ignore_list = S{
				"Poison Mist", "Malicious Spire", "Zisurru",
			},
			italic = false,
			max_monsters_listed = 6,
			min_monsters_to_show = 0,
			open_mobs = S{
				"Mireu", "Azi Dahaka", "Naga Raja", "Quetzalcoatl",
				"Azi Dahaka's Dragon", "Naga Raja's Lamia", "Quetzalcoatl's Sibilus",
				"Academic's", "Agoge", "Anchorite's", "Ankusa",
				"Arcadian", "Archmage's", "Assimilator's", "Atrophy",
				"Bagua", "Bihu", "Brioso", "Caballarius",
				"Convoker's", "Fallen's", "Foire", "Futhark",
				"Geomancy", "Glyphic", "Hachiya", "Hesychast's",
				"Horos", "Ignominy", "Laksamana's", "Lanun",
				"Luhlaza", "Maxixi", "Mochizuki", "Orion",
				"Pedagogy", "Piety", "Pillager's", "Pitre",
				"Plunderer's", "Pteroslaver", "Pummeler's", "Reverence",
				"Runeist", "Sakonji", "Spaekona's", "Theophany",
				"Totemic", "Vishap", "Vitiation", "Wakido",
			},
			pos = {x = 200, y = 320},
			show = true,
			show_cursor_target = true,
			size = 10,
			stroke_alpha = 255,
			stroke_color = {r = 0, g = 0, b = 0,},
			stroke_width = 1,
		},
		focus_target = {
			bar_size = 10,
			bar_width = 50,
			bold = true,
			debuff_icon_offset = -37,
			debuff_icon_size = 18,
			debuff_icon_spacing = 2,
			debuff_icons = true,
			debuff_max_icons = 12,
			debuff_timer_offset = -26, 
			debuff_timer_size = 8,
			debuff_timers = true,
			font = 'Consolas',
			italic = false,
			pos = {x = 576, y = 180},
			show_monster_level = false,
			show_monster_target = true,
			spaces_between_text_parts = 1,
			stroke_alpha = 255,
			stroke_color = {r = 0, g = 0, b = 0,},
			stroke_width = 0.5,
			sub_text_offset = 6,
			sub_text_shadow_offset = 2,
			sub_text_size = 10,
			text_offset = -16,
			text_shadow_offset = 2,
			text_size = 10,
			ui_bg = true,
			ui_bg_alpha = 100,
		},
		party_1_actions = {
			bold = true,
			bottom_up = true,
			font = "Consolas",
			italic = false,
			pos = {
				x = -155,
				y = get_windower_settings().ui_y_res - 144,
			},
			right_align = true,
			show = true,
			show_results = false,
			show_self = true,
			stroke_alpha = 255,
			stroke_color = {r = 0, g = 0, b = 0,},
			stroke_width = 1,
			text_color = {r = 255, g = 255, b = 255,},
			text_size = 9,
			vertical_spacing_between_players = 20,
		},
		party_2_actions = {
			bold = true,
			bottom_up = true,
			font = "Consolas",
			italic = false,
			pos = {
				x = -155,
				y = get_windower_settings().ui_y_res - 400,
			},
			show = true,
			show_results = false,
			stroke_alpha = 255,
			stroke_color = {r = 0, g = 0, b = 0,},
			stroke_width = 1,
			text_color = {r = 255, g = 255, b = 255,},
			text_size = 9,
			vertical_spacing_between_players = 16,
			right_align = true,
		},
		party_3_actions = {
			bold = true,
			bottom_up = true,
			font = "Consolas",
			italic = false,
			pos = {
				x = -155,
				y = get_windower_settings().ui_y_res - 297,
			},
			right_align = true,
			show = true,
			show_results = false,
			stroke_alpha = 255,
			stroke_color = {r = 0, g = 0, b = 0,},
			stroke_width = 1,
			text_color = {r = 255, g = 255, b = 255,},
			text_size = 9,
			vertical_spacing_between_players = 16,
		},
		player_stats = {
			bar_size = 10,
			bar_width = 100,
			bold = true,
			font = 'Consolas',
			italic = false,
			pos = {x = 200, y = 330},
			stroke_alpha = 255,
			stroke_color = {r = 0, g = 0, b = 0,},
			stroke_width = 0.5,
			text_offset = -15,
			text_shadow_offset = 2,
			text_size = 10,
			vertical_spacing_between_player_stats = 23,
		},
		self_action = {
			bar_size = 10,
			bar_width = 100,
			bold = true,
			font = 'Consolas',
			italic = false,
			pos = {x = 200, y = 300},
			show = true,
			show_bar = true,
			stroke_alpha = 255,
			stroke_color = {r = 0, g = 0, b = 0,},
			stroke_width = 0.5,
			text_shadow_offset = 2,
			text_size = 11,
			text_offset = -17,
			ui_bg = true,
			ui_bg_alpha = 100,
		},
		sub_target = {
			bar_size = 10,
			bar_width = 50,
			bold = true,
			debuff_icon_offset = -37,
			debuff_icon_size = 18,
			debuff_icon_spacing = 2,
			debuff_icons = true,
			debuff_max_icons = 12,
			debuff_timer_offset = -26, 
			debuff_timer_size = 8,
			debuff_timers = true,
			font = 'Consolas',
			italic = false,
			pos = {x = 200, y = 180},
			show_monster_level = false,
			show_monster_target = true,
			spaces_between_text_parts = 1,
			stroke_alpha = 255,
			stroke_color = {r = 0, g = 0, b = 0,},
			stroke_width = 0.5,
			sub_text_offset = 6,
			sub_text_shadow_offset = 2,
			sub_text_size = 10,
			text_offset = -16,
			text_shadow_offset = 2,
			text_size = 10,
			ui_bg = true,
			ui_bg_alpha = 100,
		},
		target= {
			bar_size = 10,
			bar_width = 100,
			bold = true,
			debuff_icon_offset = -44,
			debuff_icon_size = 20,
			debuff_icon_spacing = 2,
			debuff_icons = true,
			debuff_max_icons = 12,
			debuff_timer_offset = -31, 
			debuff_timer_size = 9,
			debuff_timers = true,
			font = 'Consolas',
			italic = false,
			pos = {x = 200, y = 250},
			show_monster_level = true,
			show_monster_target = true,
			spaces_between_text_parts = 1,
			stroke_alpha = 255,
			stroke_color = {r = 0, g = 0, b = 0,},
			stroke_width = 0.5,
			sub_text_offset = 6,
			sub_text_shadow_offset = 2,
			sub_text_size = 11,
			target_lock_icon_size = 40,
			target_lock_icon_stroke_alpha = 255,
			target_lock_icon_stroke_color = {r = 0, g = 0, b = 0,},
			target_lock_icon_stroke_width = 1,
			target_lock_underline_pixel_width = 2.5,
			text_offset = -21,
			text_shadow_offset = 2,
			text_size = 14,
			ui_bg = true,
			ui_bg_alpha = 100,
		},
	},
	colors = {
		bar_bg = {
			normal = {r = 0, g = 0, b = 0},
			dead = {r = 150, g = 30, b = 30},
		},
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
			sp_active_glow = {r = 100, g = 100, b = 25},
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
			full_1k = {r = 75, g = 255, b = 75},
			full_2k = {r = 0, g = 200, b = 255},
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
		range = {
			out_of_range = {r = 255, g = 255, b = 255},
			in_range = {r = 75, g = 255, b = 75},
			hits_squarely = {r = 0, g = 200, b = 255},
			strikes_true = {r = 255, g = 255, b = 50},
			outer_blue_magic = {r = 0, g = 200, b = 255},
			inner_blue_magic = {r = 255, g = 255, b = 50},
			song_aoe = {r = 255, g = 255, b = 50},
		},
		result = {
			heal = {r = 140, g = 235, b = 255},
			damage = {r = 255, g = 200, b = 200},
		},
		debuffs = {
			almost_ready = {r = 77, g = 255, b = 77},
			critical_low = {r = 255, g = 77, b = 77},
			low = {r = 255, g = 139, b = 56},
			normal = {r = 255, g = 255, b = 255},
		},
	},
}

settings = config.load(defaults)
settings:save('all') --only useful for when Bars gets updated, will automatically add in any new default settings.

--Default/example targets to pre-populate the auto_focus_targets.lua file
default_auto_focus_targets = {
	['Aurix'] = true,
	['Dealan-dhe'] = true,
	['Sgili'] = true,
	['U Bnai'] = true,
	['Gogmagog'] = true,
	['Aristaeus'] = true,
	['Raskovniche'] = true,
	['Marmorkrebs'] = true,
	['Gigelorum'] = true,
	['Procne'] = true,
	['Henwen'] = true,
	['Xevioso'] = true,
	['Ngai'] = true,
	['Kalunga'] = true,
	['Ongo'] = true,
	['Mboze'] = true,
	['Arebati'] = true,
	['Bumba'] = true,
	['Glassy Craver'] = true,
	['Glassy Gorger'] = true,
	['Glassy Thinker'] = true,
	['Fu'] = true,
	['Kyou'] = true,
	['Kei'] = true,
	['Gin'] = true,
	['Kin'] = true,
	['Ou'] = true,
	['Abject Obdella'] = true,
	['Biune Porxie'] = true,
	['Cachaemic Bhoot'] = true,
	['Demisang Deleterious'] = true,
	['Esurient Botulus'] = true,
	['Fetid Ixion'] = true,
	['Gyvewrapped Naraka'] = true,
	['Haughty Tulittia'] = true,
	['Ghatjot'] = true,
	['Leshonn'] = true,
	['Skomora'] = true,
	['Degei'] = true,
	['Dhartok'] = true,
	['Gartell'] = true,
	['Triboulex'] = true,
	['Aita'] = true,
	['Aminon'] = true,
	['Palloritus'] = true,
	['Plouton'] = true,
	['Putraxia'] = true,
	['Perfidien'] = true,
	['Rancibus'] = true,
	['Azi Dahaka'] = true,
	['Naga Raja'] = true,
	['Quetzalcoatl'] = true,
	['Mireu'] = true,
}

--Location of the targets file
auto_focus_targets_file = files.new('data\\auto_focus_targets.lua')

auto_focus_targets_help_msg = "--This file is used to store the names, IDs, and Hex IDs for Auto Focus Targets that Bars is looking for.\n\n"

function sortedTableString(tbl, indent)
	indent = indent or ""
	local lines = {}
	local keys = {}

	for k in pairs(tbl) do
		table.insert(keys, k)
	end
	table.sort(keys, function(a, b) return tostring(a):lower() < tostring(b):lower() end)

	for _, k in ipairs(keys) do
		local v = tbl[k]
		local formatted_key = type(k) == "string" and string.format("[%q]", k) or string.format("[%s]", tostring(k))
		if type(v) == "table" then
			table.insert(lines, indent..formatted_key.."={")
			table.insert(lines, sortedTableString(v, indent.."    "))
			table.insert(lines, indent.."},")
		else
			local formatted_val = type(v) == "string" and string.format("%q", v) or tostring(v)
			table.insert(lines, indent..formatted_key.."="..formatted_val..",")
		end
	end

	return table.concat(lines, "\n")
end

--Capitalize accordingly
function capitalize(str)

	str = string.gsub(str, "(%w)(%w*)", function(firstLetter, rest)
		return string.upper(firstLetter)..string.lower(rest)
	end)

	-- Fix capitalizing " ii" at the end of the string back to " II" (ex. Enstone II)
	str = string.gsub(str, " Ii$", " II")

	-- Ensure letters after an apostrophe are not capitalized
	str = string.gsub(str, "('%w)", function(apostropheLetter)
		return string.lower(apostropheLetter)
	end)

	return str

end

auto_focus_targets_data = {}

--If the data\auto_focus_targets.lua file doesn't exist, create it
if not auto_focus_targets_file:exists() then

	--Migrate legacy targets from settings file to new auto_focus_targets_data format
	local function migrateTargetsFromSettings()
		local function convertToDisplay(target)
			target = string.gsub(target, "__apos__", "'") --convert __apos__ back to apostrophes
			target = string.gsub(target, "__dash__", "-") --convert __dash__ back to dashes
			target = capitalize(target) --capitalize names
			target = string.gsub(target, "_", " ") --convert underscores to spaces
			return target
		end
		local migrated_targets = {}
		--Check if an old auto_focus_target_list table exists in the settings file
		if settings.auto_focus_target_list then
			--Loop through all the targets in it
			for key, value in pairs(settings.auto_focus_target_list) do
				local readable_key = convertToDisplay(key)
				if not migrated_targets[readable_key] then
					migrated_targets[readable_key] = true
				end
			end
			add_to_chat(8,('[Bars] '):color(220)..('Migration of old Auto Focus Target data complete.'):color(36))
			add_to_chat(8,('[Bars] '):color(220)..('You may safely delete '):color(8)..('auto_focus_target_list '):color(1)..('data in '):color(8)..('data/settings.xml '):color(1)..('if you wish.'):color(8))
			return migrated_targets
		else
			return nil
		end
	end

	local migrated = migrateTargetsFromSettings()
	auto_focus_targets_data = migrated and migrated or default_auto_focus_targets

	auto_focus_targets_file:write(auto_focus_targets_help_msg..'return {\n'..sortedTableString(auto_focus_targets_data, '    ')..'\n}')

else
	--File already exists, load it
	auto_focus_targets_data = require('data.auto_focus_targets')
end

default_mob_abbreviations = {
	["Apex"] = "A.",
	["Locus"] = "L.",
	["Bozzetto"] = "Bz.",
	["Sweetwater"] = "Swt.",
	["Transcended"] = "Trn.",
	["Nostos"] = "N.",
	["Abject"] = "A.",
	["Biune"] = "B.",
	["Cachaemic"] = "C.",
	["Demisang"] = "D.",
	["Esurient"] = "E.",
	["Fetid"] = "F.",
	["Gyvewrapped"] = "G.",
	["Haughty"] = "H.",
	["Squadron"] = "Sqd.",
	["Regiment"] = "Rgm.",
	["Vanguard"] = "Vng.",
	["Awoken"] = "A.",
	["Azi Dahaka's"] = "Azi's",
	["Naga Raja's"] = "Naga's",
	["Quetzalcoatl's"] = "Quetz's",
	["Commander"] = "Cmdr.",
	["Leader"] = "Ldr.",
	["Temenos"] = "T.",
	["Apollyon"] = "A.",
}

--Location of the mob abbreviations file
mob_abbreviations_file = files.new('data\\mob_abbreviations.lua')

mob_abbreviations_help_msg = "--This file is used to store the mob names and their abbreviations used by the `abbreviate_common_mob_names` option in Bars.\n--Please note the name to be replaced is case-sensitive but does not have to be the complete mob name, only the part of the name you wish to be replaced.\n\n"

mob_abbreviations_data = {}

--If the data\mob_abbreviations.lua file doesn't exist, create it
if not mob_abbreviations_file:exists() then

	mob_abbreviations_data = default_mob_abbreviations

	mob_abbreviations_file:write(mob_abbreviations_help_msg..'return {\n'..sortedTableString(mob_abbreviations_data, '    ')..'\n}')

else
	--File already exists, load it
	mob_abbreviations_data = require('data.mob_abbreviations')
end

default_durations = {
	["Valefor"] = {
		["Keylesta"] = {
			["Angon"] = 0,
			["Arcane Crest"] = 0,
			["Dragon Breaker"] = 0,
			["Enfeebling Magic"] = 10,
			["Gambit"] = 36,
			["Hamanoha"] = 0,
			["Cumulative Spells"] = 0,
			["Rayke"] = 20,
			["Sepulcher"] = 20,
			["Shadowbind"] = 0,
			["Singing"] = 161,
			["Tomahawk"] = 60,
		}
	},
}

--Location of the durations file
durations_file = files.new('data\\durations.lua')

durations_help_msg = "--This file is used to store custom duration bonuses used by the `debuff_icons` and `debuff_timers` options in Bars.\n--Please note the servers, character names, and duration labels are case-sensitive.\n--Available durations: Angon, Arcane Crest, Dragon Breaker, Enfeebling Magic, Gambit, Hamanoha, Rayke, Sepulcher, Shadowbind, Singing, and Tomahawk.\n--Enfeebling Magic and Singing are the total PERCENT bonus from all gear combined. These may vary based on specific gear for specific spells/songs, but a good ballpark average should be fine.\n--All abilities and Cumulative Magic are total SECONDS bonus from all gear, merits, and/or job gifts combined.\n--Only set duration bonuses that are known. Any duration numbers defined here will be taken as a \"known value\", meaning if you set a duration to 0 it will assume you have a specific bonus of 0 and will remove the relevant debuff based on that duration. If a specific duration is unknown, do not include it under the character.\n--Included by default are my own current durations as an example.\n\n"

durations_data = {}

--If the data\durations.lua file doesn't exist, create it
if not durations_file:exists() then

	durations_data = default_durations

	durations_file:write(durations_help_msg..'return {\n'..sortedTableString(durations_data, '    ')..'\n}')

else
	--File already exists, load it
	durations_data = require('data.durations')
end

bg_alpha = settings.bg.alpha
text_alpha = settings.text.alpha

abbreviate_common_mob_names = settings.options.abbreviate_common_mob_names
aggro_list_ignore = settings.sections.aggro_list.ignore_list
aggro_list_open_mobs = settings.sections.aggro_list.open_mobs
clear_action_delay = settings.options.clear_action_delay
colorize_spells = settings.options.colorize_spells
condense_target_and_subtarget_bars = settings.options.condense_target_and_subtarget_bars
condense_focus_target_name_and_sp_name = settings.options.condense_target_name_and_sp_name.focus_target
condense_sub_target_name_and_sp_name = settings.options.condense_target_name_and_sp_name.sub_target
condense_target_name_and_sp_name = settings.options.condense_target_name_and_sp_name.target
debuff_duration_cap = settings.options.debuffs.duration_cap
drain_decay = (settings.options.animations.drain_speed / 10)
drain_brightness = math.max(1, math.min(10, settings.options.animations.drain_brightness))
drain_bg_alpha = bg_alpha * (drain_brightness / 10)
meter_bg_alpha = bg_alpha * ((10 - drain_brightness) / 10)
drain_hp_bar = settings.options.animations.drain_hp_bar
drain_mp_bar = settings.options.animations.drain_mp_bar
drain_pet_bar = settings.options.animations.drain_pet_bar
drain_target_bars = settings.options.animations.drain_target_bars
drain_tp_bar = settings.options.animations.drain_tp_bar
fade_after_a_delay = settings.options.animations.fade_after_a_delay
fade_down_to_alpha = settings.options.animations.fade_down_to_alpha
fade_bg_num = settings.bg.alpha
fade_delay = settings.options.animations.fade_delay
fade_speed = settings.options.animations.fade_speed
fade_text_num = settings.text.alpha
fade_icon_num = 255
fade_bg_ui_num = settings.sections.focus_target.ui_bg_alpha
floating_tp_number = settings.options.animations.floating_tp_number
flip_doom_timer_coloring = settings.options.flip_doom_timer_coloring
focus_target_max_distance = settings.options.focus_target_max_distance
hide_pet_bar_when_no_pet = settings.options.hide_pet_bar_when_no_pet
hide_player_stats_bars_when_no_target = settings.options.hide_player_stats_bars_when_no_target
job_specific = settings.job_specific
max_action_length = settings.options.max_action_length
max_icons = {
	focus_target = math.max(0, math.min(settings.sections.focus_target.debuff_max_icons, 32)),
	sub_target = math.max(0, math.min(settings.sections.sub_target.debuff_max_icons, 32)),
	target = math.max(0, math.min(settings.sections.target.debuff_max_icons, 32)),
}
max_monster_target_length = settings.options.max_monster_target_length
max_monsters_listed = math.max(0, math.min(settings.sections.aggro_list.max_monsters_listed, 15))
max_name_length = settings.options.max_name_length
min_monsters_to_show = math.max(0, math.min(settings.sections.aggro_list.min_monsters_to_show, 15))
monster_target_confidence_timer = settings.options.monster_target_confidence_timer
pulse_brightness = settings.options.animations.pulse_brightness
pulse_bar_when_target_sp_active = settings.options.animations.pulse_bar_when_target_sp_active
pulse_when_hp_low = settings.options.animations.pulse_when_hp_low
pulse_when_mp_low = settings.options.animations.pulse_when_mp_low
pulse_speed = settings.options.animations.pulse_speed
pulse_name_when_target_sp_active = settings.options.animations.pulse_name_when_target_sp_active
pulse_when_pet_low = settings.options.animations.pulse_when_pet_low
pulse_tp_meter_only = settings.options.animations.pulse_tp_meter_only
pulse_when_tp_ready = settings.options.animations.pulse_when_tp_ready
remove_tachi_blade_from_ws_name = settings.options.remove_tachi_blade_from_ws_name
short_skillchain_names = settings.options.short_skillchain_names
show_action_status_indicators = settings.options.show_action_status_indicators
show_aggro_list = settings.sections.aggro_list.show
show_cursor_target = settings.sections.aggro_list.show_cursor_target
show_hp_tp_markers = settings.options.show_hp_tp_markers
show_commas_on_numbers = settings.options.show_commas_on_numbers
show_dyna_jobs = settings.options.show_dyna_jobs
show_fancy_rolls = settings.options.show_fancy_rolls
show_focus_target_when_targeted = settings.options.show_focus_target_when_targeted
show_max_hp_mp_on_bar = settings.options.show_max_hp_mp_on_bar
show_pet_status = settings.options.show_pet_status
show_pet_distance = settings.options.show_pet_distance
show_pet_tp = settings.options.show_pet_tp
show_result_totals = settings.options.show_result_totals
show_roll_lucky_info = settings.options.show_roll_lucky_info
show_self_action = settings.sections.self_action.show
show_self_action_bar = settings.sections.self_action.show_bar
show_self_action_result = settings.options.show_self_action_result
show_self_when_sub_targeted = settings.options.show_self_when_sub_targeted
show_self_when_targeted = settings.options.show_self_when_targeted
show_sub_target_when_targeted = settings.options.show_sub_target_when_targeted
show_target_action = settings.options.show_target_action
show_target_action_result = settings.options.show_target_action_result
show_target_distance = settings.options.show_target_distance
show_target_distance_colors = settings.options.show_target_distance_colors
show_target_hex = settings.options.show_target_hex
show_target_index = settings.options.show_target_index
show_target_lock = settings.options.show_target_lock

focus_target_bar_size = settings.sections.focus_target.bar_size
focus_target_bar_width = settings.sections.focus_target.bar_width
focus_target_stroke_alpha = settings.sections.focus_target.stroke_alpha
focus_target_stroke_color = settings.sections.focus_target.stroke_color
focus_target_stroke_width = settings.sections.focus_target.stroke_width
focus_target_sub_text_size = settings.sections.focus_target.sub_text_size
focus_target_text_size = settings.sections.focus_target.text_size

sub_target_bar_size = settings.sections.sub_target.bar_size
sub_target_bar_width = settings.sections.sub_target.bar_width
sub_target_stroke_alpha = settings.sections.sub_target.stroke_alpha
sub_target_stroke_color = settings.sections.sub_target.stroke_color
sub_target_stroke_width = settings.sections.sub_target.stroke_width
sub_target_sub_text_size = settings.sections.sub_target.sub_text_size
sub_target_text_size = settings.sections.sub_target.text_size

target_bar_size = settings.sections.target.bar_size
target_bar_width = settings.sections.target.bar_width
target_stroke_alpha = settings.sections.target.stroke_alpha
target_stroke_color = settings.sections.target.stroke_color
target_stroke_width = settings.sections.target.stroke_width
target_sub_text_size = settings.sections.target.sub_text_size
target_text_size = settings.sections.target.text_size

self_action_bar_size = settings.sections.self_action.bar_size
self_action_bar_width = settings.sections.self_action.bar_width
self_action_stroke_alpha = settings.sections.self_action.stroke_alpha
self_action_stroke_color = settings.sections.self_action.stroke_color
self_action_stroke_width = settings.sections.self_action.stroke_width
self_action_text_size = settings.sections.self_action.text_size

player_stats_bar_size = settings.sections.player_stats.bar_size
player_stats_bar_width = settings.sections.player_stats.bar_width
player_stats_stroke_alpha = settings.sections.player_stats.stroke_alpha
player_stats_stroke_color = settings.sections.player_stats.stroke_color
player_stats_stroke_width = settings.sections.player_stats.stroke_width
player_stats_text_size = settings.sections.player_stats.text_size

aggro_list_size = settings.sections.aggro_list.size
aggro_list_bg_alpha = settings.sections.aggro_list.bg_alpha
aggro_list_bold = settings.sections.aggro_list.bold
aggro_list_italic = settings.sections.aggro_list.italic
aggro_list_stroke_alpha = settings.sections.aggro_list.stroke_alpha
aggro_list_stroke_color = settings.sections.aggro_list.stroke_color
aggro_list_stroke_width = settings.sections.aggro_list.stroke_width

party_1_actions = settings.sections.party_1_actions
party_2_actions = settings.sections.party_2_actions
party_3_actions = settings.sections.party_3_actions

target_lock_icon_stroke_alpha = settings.sections.target.target_lock_icon_stroke_alpha
target_lock_icon_stroke_color = settings.sections.target.target_lock_icon_stroke_color
target_lock_icon_stroke_width = settings.sections.target.target_lock_icon_stroke_width
target_lock_icon_size = settings.sections.target.target_lock_icon_size

casting_icon = settings.icons.casting
cancelled_icon = settings.icons.cancelled
completed_icon = settings.icons.completed
targeting_icon = settings.icons.targeting
num_hit_icon = settings.icons.number_of_targets_hit
truncate_icon = settings.icons.truncate

aggro_list_update_interval = settings.options.update_intervals.aggro_list
focus_target_update_interval = settings.options.update_intervals.focus_target
party_actions_update_interval = settings.options.update_intervals.party_actions
player_stats_pet_update_interval = settings.options.update_intervals.player_stats_pet
sub_target_update_interval = settings.options.update_intervals.sub_target
target_update_interval = settings.options.update_intervals.target

color = settings.colors
font = settings.text.font
text_color = {r = settings.text.red, g = settings.text.green, b = settings.text.blue}
pt1_text_color = {r = party_1_actions.text_color.r, g = party_1_actions.text_color.g, b = party_1_actions.text_color.b}
pt2_text_color = {r = party_2_actions.text_color.r, g = party_2_actions.text_color.g, b = party_2_actions.text_color.b}
pt3_text_color = {r = party_3_actions.text_color.r, g = party_3_actions.text_color.g, b = party_3_actions.text_color.b}
pt1_stroke_color = {r = party_1_actions.stroke_color.r, g = party_1_actions.stroke_color.g, b = party_1_actions.stroke_color.b}
pt2_stroke_color = {r = party_2_actions.stroke_color.r, g = party_2_actions.stroke_color.g, b = party_2_actions.stroke_color.b}
pt3_stroke_color = {r = party_3_actions.stroke_color.r, g = party_3_actions.stroke_color.g, b = party_3_actions.stroke_color.b}

element_colors = {
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

sp_abils = {
	['Mighty Strikes'] = 45, ['Brazen Rush'] = 30,
	['Hundred Fists'] = 45, ['Inner Strength'] = 30,
	['Manafont'] = 60, ['Subtle Sorcery'] = 60,
	['Chainspell'] = 60,
	['Perfect Dodge'] = 30,
	['Invincible'] = 30,
	['Blood Weapon'] = 30, ['Soul Enslavement'] = 30,
	['Unleash'] = 60,
	['Soul Voice'] = 180, ['Clarion Call'] = 180,
	['Overkill'] = 60,
	['Meikyo Shisui'] = 30, ['Yaegasumi'] = 45,
	['Mikage'] = 45,
	['Spirit Surge'] = 60, ['Fly High'] = 30,
	['Astral Flow'] = 180, ['Astral Conduit'] = 30,
	['Azure Lore'] = 30, ['Unbridled Wisdom'] = 60,
	['Overdrive'] = 60,
	['Trance'] = 60, ['Grand Pas'] = 30,
	['Tabula Rasa'] = 180,
	['Bolster'] = 180, ['Widened Compass'] = 60,
	['Elemental Sforzo'] = 30,
}

sp_shorter_names = {
	['Mighty Strikes'] = 'M. Strikes',
	['Brazen Rush'] = 'Brzn. Rush',
	['Hundred Fists'] = 'Hnd. Fists',
	['Inner Strength'] = 'Inner Str.',
	['Manafont'] = 'Manafont',
	['Subtle Sorcery'] = 'Sbtl. Src.',
	['Chainspell'] = 'Chainspell',
	['Perfect Dodge'] = 'Prf. Dodge',
	['Invincible'] = 'Invincible',
	['Blood Weapon'] = 'Bl. Weapon',
	['Soul Enslavement'] = 'Soul Enslv.',
	['Unleash'] = 'Unleash',
	['Soul Voice'] = 'Soul Voice',
	['Clarion Call'] = 'Clar. Call',
	['Overkill'] = 'Overkill',
	['Meikyo Shisui'] = 'Mk. Shisui',
	['Yaegasumi'] = 'Yaegasumi',
	['Mikage'] = 'Mikage',
	['Spirit Surge'] = 'Spr. Surge',
	['Fly High'] = 'Fly High',
	['Astral Flow'] = 'Ast. Flow',
	['Astral Conduit'] = 'Ast. Cond.',
	['Azure Lore'] = 'Azure Lore',
	['Unbridled Wisdom'] = 'Un. Wisdom',
	['Overdrive'] = 'Overdrive',
	['Trance'] = 'Trance',
	['Grand Pas'] = 'Grand Pas',
	['Tabula Rasa'] = 'Tab. Rasa',
	['Bolster'] = 'Bolster',
	['Widened Compass'] = 'W. Compass',
	['Elemental Sforzo'] = 'El. Sforzo',
}

--note that these aren't the actual spell names, just used to denote the tier of cumulative magic boost
custom_spells = {
	[9023]	= "Boosted Dia",
	[9024]	= "Boosted Dia II",
	[9025]	= "Boosted Dia III",
	[9230]	= "Boosted Bio",
	[9231]	= "Boosted Bio II",
	[9232]	= "Boosted Bio III",
	[9235]	= "Boosted Burn",
	[9236]	= "Boosted Frost",
	[9237]	= "Boosted Choke",
	[9238]	= "Boosted Rasp",
	[9239]	= "Boosted Shock",
	[9240]	= "Boosted Drown",
	[9219]	= "Comet",
	[10219]	= "Comet II",
	[11219]	= "Comet III",
	[12219]	= "Comet IV",
	[13219]	= "Comet V",
	[9496]	= "Firaja",
	[10496]	= "Firaja II",
	[11496]	= "Firaja III",
	[12496]	= "Firaja IV",
	[13496]	= "Firaja V",
	[9497]	= "Blizzaja",
	[10497]	= "Blizzaja II",
	[11497]	= "Blizzaja III",
	[12497]	= "Blizzaja IV",
	[13497]	= "Blizzaja V",
	[9498]	= "Aeroja",
	[10498]	= "Aeroja II",
	[11498]	= "Aeroja III",
	[12498]	= "Aeroja IV",
	[13498]	= "Aeroja V",
	[9499]	= "Stoneja",
	[10499]	= "Stoneja II",
	[11499]	= "Stoneja III",
	[12499]	= "Stoneja IV",
	[13499]	= "Stoneja V",
	[9500]	= "Thundaja",
	[10500]	= "Thundaja II",
	[11500]	= "Thundaja III",
	[12500]	= "Thundaja IV",
	[13500]	= "Thundaja V",
	[9501]	= "Waterja",
	[10501]	= "Waterja II",
	[11501]	= "Waterja III",
	[12501]	= "Waterja IV",
	[13501]	= "Waterja V",
}
remove_all_debuffs = S{
	"Benediction",
	"Depuration",
	"Stygian Sphere",
}

in_cutscene = false
zoning = false
logged_in = false
job = false
pet_tp = 0
current_actions = {}
current_sp_actions = {}
current_debuffs = {}
current_levels = {}
current_aggro_list = {}
last_aggro_list_update = 0
last_focus_target_update = 0
last_party_actions_update = 0
last_player_stats_update = 0
last_sub_target_update = 0
last_target_update = 0
next_wide_scan_time = os.time() + math.random(30, 45)
ft_targeting_id = nil
st_targeting_id = nil
t_targeting_id = nil
focus_target = nil
focus_target_override = nil
focus_target_bar_width_str = ''
player_stats_bar_width_str = ''
sub_target_bar_width_str = ''
self_action_bar_width_str = ''
target_bar_width_str = ''
player_stats_top_bar = ''
index = 0
Heartbeat = 0
server = nil
in_dyna = false
wide_scan_locked = false
drain_previous_ft_id = nil
drain_previous_st_id = nil
drain_previous_t_id = nil
drain_ft_hpp = 0
drain_st_hpp = 0
drain_t_hpp = 100
drain_ps_hpp = 100
drain_ps_mpp = 100
drain_ps_tp = 0
drain_ps_pet = 100
Fade = false
Pulse_HP = false
Pulse_MP = false
Pulse_TP = false
Pulse_Pet = false
Pulse_Focus_Target_Bar = false
Pulse_Sub_Target_Bar = false
Pulse_Target_Bar = false
Pulse_Focus_Target_Name = false
Pulse_Sub_Target_Name = false
Pulse_Target_Name = false
pulse_hp_alpha_num = settings.bg.alpha
pulse_mp_alpha_num = settings.bg.alpha
pulse_tp_alpha_num = settings.bg.alpha
pulse_pet_alpha_num = settings.bg.alpha
pulse_focus_target_alpha_num = settings.bg.alpha
pulse_sub_target_alpha_num = settings.bg.alpha
pulse_target_alpha_num = settings.bg.alpha
pulse_hp_directio_up = true
pulse_mp_direction_up = true
pulse_tp_direction_up = true
pulse_pet_direction_up = true
pulse_focus_target_direction_up = true
pulse_sub_target_direction_up = true
pulse_target_direction_up = true
ft_spaces = string.rep(' ', settings.sections.focus_target.spaces_between_text_parts)
st_spaces = string.rep(' ', settings.sections.sub_target.spaces_between_text_parts)
t_spaces = string.rep(' ', settings.sections.target.spaces_between_text_parts)
target_lock_icon_pixel_width = 0
target_lock_icon_pixel_height = 0
target_lock_underline_pixel_width = 0
self_action_bar_pixel_width = 0
target_bar_pixel_width = 0
target_bar_pixel_height = 0
num_party1_members = 0
num_party2_members = 0
num_party3_members = 0
Screen_Test = false
screen_test_focus_target = {
	name = "Focus Target",
	action = "Focus Target Action",
	hpp = 50,
	distance = 100,
	id = 99999,
	index = 12345,
	model_size = 5,
}
screen_test_sub_target = {
	name = "Sub Target",
	action = "Sub Target Action",
	hpp = 50,
	distance = 100,
	id = 99999,
	index = 12345,
	model_size = 5,
}
screen_test_target = {
	name = "Target",
	action = "Target Action",
	hpp = 50,
	distance = 100,
	id = 99999,
	index = 12345,
	model_size = 5,
}
screen_test_debuffs = {
	focus_target = {},
	sub_target = {},
	target = {},
}
for section, section_table in pairs(screen_test_debuffs) do
	for i = 1, max_icons[section] do
		section_table[i] = math.random(1, 640)
	end
end

sp_active_glow = settings.colors.target.sp_active_glow

ft_text_stroke = {
	a = focus_target_stroke_alpha,
	r = focus_target_stroke_color.r,
	g = focus_target_stroke_color.g,
	b = focus_target_stroke_color.b,
	w = focus_target_stroke_width,
}
st_text_stroke = {
	a = sub_target_stroke_alpha,
	r = sub_target_stroke_color.r,
	g = sub_target_stroke_color.g,
	b = sub_target_stroke_color.b,
	w = sub_target_stroke_width,
}
t_text_stroke = {
	a = target_stroke_alpha,
	r = target_stroke_color.r,
	g = target_stroke_color.g,
	b = target_stroke_color.b,
	w = target_stroke_width,
}
sa_text_stroke = {
	a = self_action_stroke_alpha,
	r = self_action_stroke_color.r,
	g = self_action_stroke_color.g,
	b = self_action_stroke_color.b,
	w = self_action_stroke_width,
}
ps_text_stroke = {
	a = player_stats_stroke_alpha,
	r = player_stats_stroke_color.r,
	g = player_stats_stroke_color.g,
	b = player_stats_stroke_color.b,
	w = player_stats_stroke_width,
}

wide_scan_exclude_zones = S{
	"Western Adoulin","Eastern Adoulin","Celennia Memorial Library","Silver Knife","Bastok Markets","Bastok Mines","Metalworks","Port Bastok","Chateau d'Oraguille","Northern San d'Oria","Port San d'Oria","Southern San d'Oria","Heavens Tower","Port Windurst","Windurst Walls","Windurst Waters","Windurst Woods","Lower Jeuno","Port Jeuno","Ru'Lude Gardens","Upper Jeuno","Aht Urhgan Whitegate","The Colosseum","Tavnazian Safehold","Southern San d'Oria [S]","Bastok Markets [S]","Windurst Waters [S]","Mhaura","Selbina","Rabao","Kazham","Norg","Nashmau","Mog Garden","Leafallia","Chocobo Circuit"
}

--CREATE IMAGE/TEXT OBJECTS

--MONSTER AGGRO LIST

aggro_list_box = texts.new()
aggro_list_box:text(test_text)
aggro_list_box:pos(settings.sections.aggro_list.pos.x,settings.sections.aggro_list.pos.y)
aggro_list_box:bold(true)
aggro_list_box:show(true)
aggro_list_box:font(font)
aggro_list_box:size(settings.sections.aggro_list.size)
aggro_list_box:bg_alpha(aggro_list_bg_alpha)
aggro_list_box:pad(2)

--MONSTER DEBUFFS

--Create the UI BG LEFT image objects
ui_bg_left = {
	focus_target = {},
	sub_target = {},
	target = {},
	self_action = {},
}
for section in pairs(ui_bg_left) do
	local file = section == 'self_action' and 'ui_bg_half_left' or 'ui_bg_left'
	ui_bg_left[section] = images.new({
		color = {alpha = settings.sections[section].ui_bg_alpha},
		texture = {
			path = windower_path..'addons/Bars/data/ui/'..file..'.png',
			fit = false,
		},
		draggable = false,
	})
end

--Create the UI BG MIDDLE image objects
ui_bg_middle = {
	focus_target = {},
	sub_target = {},
	target = {},
	self_action = {},
}
for section in pairs(ui_bg_middle) do
	local file = section == 'self_action' and 'ui_bg_half_middle' or 'ui_bg_middle'
	ui_bg_middle[section] = images.new({
		color = {alpha = settings.sections[section].ui_bg_alpha},
		texture = {
			path = windower_path..'addons/Bars/data/ui/'..file..'.png',
			fit = false,
		},
		draggable = false,
	})
end

--Create the UI BG RIGHT image objects
ui_bg_right = {
	focus_target = {},
	sub_target = {},
	target = {},
	self_action = {},
}
for section in pairs(ui_bg_right) do
	local file = section == 'self_action' and 'ui_bg_half_right' or 'ui_bg_right'
	ui_bg_right[section] = images.new({
		color = {alpha = settings.sections[section].ui_bg_alpha},
		texture = {
			path = windower_path..'addons/Bars/data/ui/'..file..'.png',
			fit = false,
		},
		draggable = false,
	})
end

--Create the DEBUFF ICON image objects
debuff_icons = {
	focus_target = {},
	sub_target = {},
	target = {}
}
for section, section_table in pairs(debuff_icons) do
	local section_settings = settings.sections[section]

	--Make sure Debuff Icons are enabled for each section
	if section_settings.debuff_icons then
		for i = 1, max_icons[section] do
			section_table[i] = images.new({
				color = {alpha = 255},
				texture = {fit = false},
				draggable = false,
				size = {height = section_settings.debuff_icon_size, width = section_settings.debuff_icon_size},
			})
		end
	end
end

--Create the DEBUFF TIMER text objects
debuff_timers = {
	focus_target = {},
	sub_target = {},
	target = {}
}
for section, section_table in pairs(debuff_timers) do
	local section_settings = settings.sections[section]

	--Make sure Debuff Icons and Timers are both enabled for each section
	if section_settings.debuff_icons and section_settings.debuff_timers then
		for i = 1, max_icons[section] do
			section_table[i] = texts.new({
				text = {
					alpha = 255,
					font = font,
					size = section_settings.debuff_timer_size,
					stroke = {alpha = 255, width = 1},
				},
				bg = {alpha = 0},
				flags = {
					draggable = false,
					bold = true,
				},
			})
		end
	end
end

--TARGET LOCK

--Create the TARGET LOCK Left text object
target_bar_lock_left = texts.new()
target_bar_lock_left:text(settings.icons.target_lock_left)
target_bar_lock_left:font(font)
target_bar_lock_left:alpha(text_alpha)
target_bar_lock_left:bg_alpha(0)
target_bar_lock_left:stroke_width(target_lock_icon_stroke_width)
target_bar_lock_left:stroke_color(target_lock_icon_stroke_color.r,target_lock_icon_stroke_color.g,target_lock_icon_stroke_color.b)
target_bar_lock_left:stroke_alpha(target_lock_icon_stroke_alpha)
target_bar_lock_left:bold(true)
target_bar_lock_left:draggable(false)
target_bar_lock_left:size(target_lock_icon_size)

--Create the TARGET LOCK Right text object
target_bar_lock_right = texts.new()
target_bar_lock_right:text(settings.icons.target_lock_right)
target_bar_lock_right:font(font)
target_bar_lock_right:alpha(text_alpha)
target_bar_lock_right:bg_alpha(0)
target_bar_lock_right:stroke_width(target_lock_icon_stroke_width)
target_bar_lock_right:stroke_color(target_lock_icon_stroke_color.r,target_lock_icon_stroke_color.g,target_lock_icon_stroke_color.b)
target_bar_lock_right:stroke_alpha(target_lock_icon_stroke_alpha)
target_bar_lock_right:bold(true)
target_bar_lock_right:draggable(false)
target_bar_lock_right:size(target_lock_icon_size)

--Create the TARGET LOCK Underline text object
target_bar_lock_underline = texts.new()
target_bar_lock_underline:font(font)
target_bar_lock_underline:pad(-(focus_target_bar_size - settings.sections.target.target_lock_underline_pixel_width))
target_bar_lock_underline:bg_alpha(bg_alpha)
target_bar_lock_underline:draggable(false)
target_bar_lock_underline:size(focus_target_bar_size)

--BAR BACKGROUNDS

--Create the Focus Target BAR BACKGROUND text object
focus_target_bar_bg = texts.new()
focus_target_bar_bg:font('Consolas')
focus_target_bar_bg:pad(-4)
focus_target_bar_bg:bg_color(color.bar_bg.normal.r,color.bar_bg.normal.g,color.bar_bg.normal.b)
focus_target_bar_bg:bg_alpha(bg_alpha)
focus_target_bar_bg:draggable(false)
focus_target_bar_bg:size(focus_target_bar_size)

--Create the Sub Target BAR BACKGROUND text object
sub_target_bar_bg = texts.new()
sub_target_bar_bg:font('Consolas')
sub_target_bar_bg:pad(-4)
sub_target_bar_bg:bg_color(color.bar_bg.normal.r,color.bar_bg.normal.g,color.bar_bg.normal.b)
sub_target_bar_bg:bg_alpha(bg_alpha)
sub_target_bar_bg:draggable(false)
sub_target_bar_bg:size(sub_target_bar_size)

--Create the Target BAR BACKGROUND text object
target_bar_bg = texts.new()
target_bar_bg:font('Consolas')
target_bar_bg:pad(-4)
target_bar_bg:bg_color(color.bar_bg.normal.r,color.bar_bg.normal.g,color.bar_bg.normal.b)
target_bar_bg:bg_alpha(bg_alpha)
target_bar_bg:draggable(false)
target_bar_bg:size(target_bar_size)

--Create the Self Action BAR BACKGROUND text object
self_action_bar_bg = texts.new()
self_action_bar_bg:font('Consolas')
self_action_bar_bg:pad(-4)
self_action_bar_bg:bg_color(color.bar_bg.normal.r,color.bar_bg.normal.g,color.bar_bg.normal.b)
self_action_bar_bg:bg_alpha(bg_alpha)
self_action_bar_bg:draggable(false)
self_action_bar_bg:size(self_action_bar_size)

--Create the Player Stats HP BAR BACKGROUND text object
player_stats_hp_bar_bg = texts.new()
player_stats_hp_bar_bg:font('Consolas')
player_stats_hp_bar_bg:pad(-4)
player_stats_hp_bar_bg:bg_color(color.bar_bg.normal.r,color.bar_bg.normal.g,color.bar_bg.normal.b)
player_stats_hp_bar_bg:bg_alpha(bg_alpha)
player_stats_hp_bar_bg:draggable(false)
player_stats_hp_bar_bg:size(player_stats_bar_size)

--Create the Player Stats MP BAR BACKGROUND text object
player_stats_mp_bar_bg = texts.new()
player_stats_mp_bar_bg:font('Consolas')
player_stats_mp_bar_bg:pad(-4)
player_stats_mp_bar_bg:bg_color(color.bar_bg.normal.r,color.bar_bg.normal.g,color.bar_bg.normal.b)
player_stats_mp_bar_bg:bg_alpha(bg_alpha)
player_stats_mp_bar_bg:draggable(false)
player_stats_mp_bar_bg:size(player_stats_bar_size)

--Create the Player Stats TP BAR BACKGROUND text object
player_stats_tp_bar_bg = texts.new()
player_stats_tp_bar_bg:font('Consolas')
player_stats_tp_bar_bg:pad(-4)
player_stats_tp_bar_bg:bg_color(color.bar_bg.normal.r,color.bar_bg.normal.g,color.bar_bg.normal.b)
player_stats_tp_bar_bg:bg_alpha(bg_alpha)
player_stats_tp_bar_bg:draggable(false)
player_stats_tp_bar_bg:size(player_stats_bar_size)

--Create the Player Stats Pet BAR BACKGROUND text object
player_stats_pet_bar_bg = texts.new()
player_stats_pet_bar_bg:font('Consolas')
player_stats_pet_bar_bg:pad(-4)
player_stats_pet_bar_bg:bg_color(color.bar_bg.normal.r,color.bar_bg.normal.g,color.bar_bg.normal.b)
player_stats_pet_bar_bg:bg_alpha(bg_alpha)
player_stats_pet_bar_bg:draggable(false)
player_stats_pet_bar_bg:size(player_stats_bar_size)

--BAR PULSE

--Create the Player Stats HP BAR PULSE text object
player_stats_hp_bar_pulse = texts.new()
player_stats_hp_bar_pulse:font('Consolas')
player_stats_hp_bar_pulse:pad(-4)
player_stats_hp_bar_pulse:bg_alpha(0)
player_stats_hp_bar_pulse:draggable(false)
player_stats_hp_bar_pulse:size(player_stats_bar_size)

--Create the Player Stats MP BAR PULSE text object
player_stats_mp_bar_pulse = texts.new()
player_stats_mp_bar_pulse:font('Consolas')
player_stats_mp_bar_pulse:pad(-4)
player_stats_mp_bar_pulse:bg_alpha(0)
player_stats_mp_bar_pulse:draggable(false)
player_stats_mp_bar_pulse:size(player_stats_bar_size)

--Create the Player Stats TP BAR PULSE text object
player_stats_tp_bar_pulse = texts.new()
player_stats_tp_bar_pulse:font('Consolas')
player_stats_tp_bar_pulse:pad(-4)
player_stats_tp_bar_pulse:bg_alpha(0)
player_stats_tp_bar_pulse:draggable(false)
player_stats_tp_bar_pulse:size(pulse_tp_meter_only and player_stats_bar_size / 10 or player_stats_bar_size)

--Create the Player Stats PET BAR PULSE text object
player_stats_pet_bar_pulse = texts.new()
player_stats_pet_bar_pulse:font('Consolas')
player_stats_pet_bar_pulse:pad(-4)
player_stats_pet_bar_pulse:bg_alpha(0)
player_stats_pet_bar_pulse:draggable(false)
player_stats_pet_bar_pulse:size(player_stats_bar_size)

--Create the Focus Target BAR PULSE text object
focus_target_bar_pulse = texts.new()
focus_target_bar_pulse:font('Consolas')
focus_target_bar_pulse:pad(-4)
focus_target_bar_pulse:bg_color(sp_active_glow.r,sp_active_glow.g,sp_active_glow.b)
focus_target_bar_pulse:bg_alpha(0)
focus_target_bar_pulse:draggable(false)
focus_target_bar_pulse:size(focus_target_bar_size)

--Create the Sub Target BAR PULSE text object
sub_target_bar_pulse = texts.new()
sub_target_bar_pulse:font('Consolas')
sub_target_bar_pulse:pad(-4)
sub_target_bar_pulse:bg_color(sp_active_glow.r,sp_active_glow.g,sp_active_glow.b)
sub_target_bar_pulse:bg_alpha(0)
sub_target_bar_pulse:draggable(false)
sub_target_bar_pulse:size(sub_target_bar_size)

--Create the Target BAR PULSE text object
target_bar_pulse = texts.new()
target_bar_pulse:font('Consolas')
target_bar_pulse:pad(-4)
target_bar_pulse:bg_color(sp_active_glow.r,sp_active_glow.g,sp_active_glow.b)
target_bar_pulse:bg_alpha(0)
target_bar_pulse:draggable(false)
target_bar_pulse:size(target_bar_size)

--BAR DRAIN METERS

--Create the Focus Target BAR DRAIN METER text object
focus_target_bar_drain_meter = texts.new()
focus_target_bar_drain_meter:font('Consolas')
focus_target_bar_drain_meter:pad(-5)
focus_target_bar_drain_meter:bg_alpha(drain_target_bars and drain_bg_alpha or 0)
focus_target_bar_drain_meter:draggable(false)
focus_target_bar_drain_meter:size(focus_target_bar_size / 10)

--Create the Sub Target BAR DRAIN METER text object
sub_target_bar_drain_meter = texts.new()
sub_target_bar_drain_meter:font('Consolas')
sub_target_bar_drain_meter:pad(-5)
sub_target_bar_drain_meter:bg_alpha(drain_target_bars and drain_bg_alpha or 0)
sub_target_bar_drain_meter:draggable(false)
sub_target_bar_drain_meter:size(sub_target_bar_size / 10)

--Create the Target BAR DRAIN METER text object
target_bar_drain_meter = texts.new()
target_bar_drain_meter:font('Consolas')
target_bar_drain_meter:pad(-5)
target_bar_drain_meter:bg_alpha(drain_target_bars and drain_bg_alpha or 0)
target_bar_drain_meter:draggable(false)
target_bar_drain_meter:size(target_bar_size / 10)

--Create the HP BAR DRAIN METER text object
player_stats_hp_bar_drain_meter = texts.new()
player_stats_hp_bar_drain_meter:font('Consolas')
player_stats_hp_bar_drain_meter:pad(-5)
player_stats_hp_bar_drain_meter:bg_alpha(drain_hp_bar and drain_bg_alpha or 0)
player_stats_hp_bar_drain_meter:draggable(false)
player_stats_hp_bar_drain_meter:size(player_stats_bar_size / 10)

--Create the MP BAR DRAIN METER text object
player_stats_mp_bar_drain_meter = texts.new()
player_stats_mp_bar_drain_meter:font('Consolas')
player_stats_mp_bar_drain_meter:pad(-5)
player_stats_mp_bar_drain_meter:bg_alpha(drain_mp_bar and drain_bg_alpha or 0)
player_stats_mp_bar_drain_meter:draggable(false)
player_stats_mp_bar_drain_meter:size(player_stats_bar_size / 10)

--Create the TP BAR DRAIN METER text object
player_stats_tp_bar_drain_meter = texts.new()
player_stats_tp_bar_drain_meter:font('Consolas')
player_stats_tp_bar_drain_meter:pad(-5)
player_stats_tp_bar_drain_meter:bg_alpha(drain_tp_bar and drain_bg_alpha or 0)
player_stats_tp_bar_drain_meter:draggable(false)
player_stats_tp_bar_drain_meter:size(player_stats_bar_size / 10)

--Create the Pet BAR DRAIN METER text object
player_stats_pet_bar_drain_meter = texts.new()
player_stats_pet_bar_drain_meter:font('Consolas')
player_stats_pet_bar_drain_meter:pad(-5)
player_stats_pet_bar_drain_meter:bg_alpha(drain_pet_bar and drain_bg_alpha or 0)
player_stats_pet_bar_drain_meter:draggable(false)
player_stats_pet_bar_drain_meter:size(player_stats_bar_size / 10)

--BAR METERS

--Create the Focus Target BAR METER text object
focus_target_bar_meter = texts.new()
focus_target_bar_meter:font('Consolas')
focus_target_bar_meter:pad(-5)
focus_target_bar_meter:bg_alpha(drain_target_bars and meter_bg_alpha or bg_alpha)
focus_target_bar_meter:draggable(false)
focus_target_bar_meter:size(focus_target_bar_size / 10)

--Create the Sub Target BAR METER text object
sub_target_bar_meter = texts.new()
sub_target_bar_meter:font('Consolas')
sub_target_bar_meter:pad(-5)
sub_target_bar_meter:bg_alpha(drain_target_bars and meter_bg_alpha or bg_alpha)
sub_target_bar_meter:draggable(false)
sub_target_bar_meter:size(sub_target_bar_size / 10)

--Create the Target BAR METER text object
target_bar_meter = texts.new()
target_bar_meter:font('Consolas')
target_bar_meter:pad(-5)
target_bar_meter:bg_alpha(drain_target_bars and meter_bg_alpha or bg_alpha)
target_bar_meter:draggable(false)
target_bar_meter:size(target_bar_size / 10)

--Create the Self Action BAR METER text object
self_action_bar_meter = texts.new()
self_action_bar_meter:font('Consolas')
self_action_bar_meter:pad(-5)
self_action_bar_meter:bg_alpha(bg_alpha)
self_action_bar_meter:bg_color(color.self.bar.r,color.self.bar.g,color.self.bar.b)
self_action_bar_meter:draggable(false)
self_action_bar_meter:size(self_action_bar_size / 10)

--Create the HP BAR METER text object
player_stats_hp_bar_meter = texts.new()
player_stats_hp_bar_meter:font('Consolas')
player_stats_hp_bar_meter:pad(-5)
player_stats_hp_bar_meter:bg_alpha(drain_hp_bar and meter_bg_alpha or bg_alpha)
player_stats_hp_bar_meter:draggable(false)
player_stats_hp_bar_meter:size(player_stats_bar_size / 10)

--Create the MP BAR METER text object
player_stats_mp_bar_meter = texts.new()
player_stats_mp_bar_meter:font('Consolas')
player_stats_mp_bar_meter:pad(-5)
player_stats_mp_bar_meter:bg_alpha(drain_mp_bar and meter_bg_alpha or bg_alpha)
player_stats_mp_bar_meter:draggable(false)
player_stats_mp_bar_meter:size(player_stats_bar_size / 10)

--Create the TP BAR METER text object
player_stats_tp_bar_meter = texts.new()
player_stats_tp_bar_meter:font('Consolas')
player_stats_tp_bar_meter:pad(-5)
player_stats_tp_bar_meter:bg_alpha(drain_tp_bar and meter_bg_alpha or bg_alpha)
player_stats_tp_bar_meter:draggable(false)
player_stats_tp_bar_meter:size(player_stats_bar_size / 10)

--Create the Pet BAR METER text object
player_stats_pet_bar_meter = texts.new()
player_stats_pet_bar_meter:font('Consolas')
player_stats_pet_bar_meter:pad(-5)
player_stats_pet_bar_meter:bg_alpha(drain_pet_bar and meter_bg_alpha or bg_alpha)
player_stats_pet_bar_meter:draggable(false)
player_stats_pet_bar_meter:size(player_stats_bar_size / 10)

--MARKERS

--Create the HP MARKER text object
player_stats_hp_marker = texts.new()
player_stats_hp_marker:font('Consolas')
player_stats_hp_marker:pad(-5)
player_stats_hp_marker:alpha(255)
player_stats_hp_marker:bg_alpha(0)
player_stats_hp_marker:draggable(false)
player_stats_hp_marker:bold(settings.sections.player_stats.bold)
player_stats_hp_marker:size(player_stats_bar_size / 5) --Only shrinking by 5x so as not to make the marker too small to see

--Create the TP MARKER text object
player_stats_tp_marker = texts.new()
player_stats_tp_marker:font('Consolas')
player_stats_tp_marker:pad(-5)
player_stats_tp_marker:alpha(255)
player_stats_tp_marker:bg_alpha(0)
player_stats_tp_marker:draggable(false)
player_stats_tp_marker:bold(settings.sections.player_stats.bold)
player_stats_tp_marker:size(player_stats_bar_size / 5) --Only shrinking by 5x so as not to make the marker too small to see

--TEXT SHADOW

--Create the Focus Target TEXT SHADOW text object
focus_target_text_shadow = texts.new()
focus_target_text_shadow:font(settings.sections.focus_target.font)
focus_target_text_shadow:color(0,0,0)
focus_target_text_shadow:alpha(text_alpha)
focus_target_text_shadow:bg_alpha(0)
focus_target_text_shadow:draggable(false)
focus_target_text_shadow:bold(settings.sections.focus_target.bold)
focus_target_text_shadow:italic(settings.sections.focus_target.italic)
focus_target_text_shadow:size(settings.sections.focus_target.text_size)

--Create the Focus Target Action TEXT SHADOW text object
focus_target_action_text_shadow = texts.new()
focus_target_action_text_shadow:font(settings.sections.focus_target.font)
focus_target_action_text_shadow:color(0,0,0)
focus_target_action_text_shadow:alpha(text_alpha)
focus_target_action_text_shadow:bg_alpha(0)
focus_target_action_text_shadow:draggable(false)
focus_target_action_text_shadow:bold(settings.sections.focus_target.bold)
focus_target_action_text_shadow:italic(settings.sections.focus_target.italic)
focus_target_action_text_shadow:size(settings.sections.focus_target.sub_text_size)

--Create the Sub Target TEXT SHADOW text object
sub_target_text_shadow = texts.new()
sub_target_text_shadow:font(settings.sections.sub_target.font)
sub_target_text_shadow:color(0,0,0)
sub_target_text_shadow:alpha(text_alpha)
sub_target_text_shadow:bg_alpha(0)
sub_target_text_shadow:draggable(false)
sub_target_text_shadow:bold(settings.sections.sub_target.bold)
sub_target_text_shadow:italic(settings.sections.sub_target.italic)
sub_target_text_shadow:size(settings.sections.sub_target.text_size)

--Create the Sub Target Action TEXT SHADOW text object
sub_target_action_text_shadow = texts.new()
sub_target_action_text_shadow:font(settings.sections.sub_target.font)
sub_target_action_text_shadow:color(0,0,0)
sub_target_action_text_shadow:alpha(text_alpha)
sub_target_action_text_shadow:bg_alpha(0)
sub_target_action_text_shadow:draggable(false)
sub_target_action_text_shadow:bold(settings.sections.sub_target.bold)
sub_target_action_text_shadow:italic(settings.sections.sub_target.italic)
sub_target_action_text_shadow:size(settings.sections.sub_target.sub_text_size)

--Create the Target TEXT SHADOW text object
target_text_shadow = texts.new()
target_text_shadow:font(settings.sections.target.font)
target_text_shadow:color(0,0,0)
target_text_shadow:alpha(text_alpha)
target_text_shadow:bg_alpha(0)
target_text_shadow:draggable(false)
target_text_shadow:bold(settings.sections.target.bold)
target_text_shadow:italic(settings.sections.target.italic)
target_text_shadow:size(settings.sections.target.text_size)

--Create the Target Action TEXT SHADOW text object
target_action_text_shadow = texts.new()
target_action_text_shadow:font(settings.sections.target.font)
target_action_text_shadow:color(0,0,0)
target_action_text_shadow:alpha(text_alpha)
target_action_text_shadow:bg_alpha(0)
target_action_text_shadow:draggable(false)
target_action_text_shadow:bold(settings.sections.target.bold)
target_action_text_shadow:italic(settings.sections.target.italic)
target_action_text_shadow:size(settings.sections.target.sub_text_size)

--Create the Self Action TEXT SHADOW text object
self_action_text_shadow = texts.new()
self_action_text_shadow:font(settings.sections.self_action.font)
self_action_text_shadow:color(0,0,0)
self_action_text_shadow:alpha(text_alpha)
self_action_text_shadow:bg_alpha(0)
self_action_text_shadow:draggable(false)
self_action_text_shadow:bold(settings.sections.self_action.bold)
self_action_text_shadow:italic(settings.sections.self_action.italic)
self_action_text_shadow:size(settings.sections.self_action.text_size)

--Create the Player Stats HP TEXT SHADOW text object
player_stats_hp_text_shadow = texts.new()
player_stats_hp_text_shadow:font(settings.sections.player_stats.font)
player_stats_hp_text_shadow:color(0,0,0)
player_stats_hp_text_shadow:alpha(text_alpha)
player_stats_hp_text_shadow:bg_alpha(0)
player_stats_hp_text_shadow:draggable(false)
player_stats_hp_text_shadow:bold(settings.sections.player_stats.bold)
player_stats_hp_text_shadow:italic(settings.sections.player_stats.italic)
player_stats_hp_text_shadow:size(settings.sections.player_stats.text_size)

--Create the Player Stats MP TEXT SHADOW text object
player_stats_mp_text_shadow = texts.new()
player_stats_mp_text_shadow:font(settings.sections.player_stats.font)
player_stats_mp_text_shadow:color(0,0,0)
player_stats_mp_text_shadow:alpha(text_alpha)
player_stats_mp_text_shadow:bg_alpha(0)
player_stats_mp_text_shadow:draggable(false)
player_stats_mp_text_shadow:bold(settings.sections.player_stats.bold)
player_stats_mp_text_shadow:italic(settings.sections.player_stats.italic)
player_stats_mp_text_shadow:size(settings.sections.player_stats.text_size)

--Create the Player Stats TP TEXT SHADOW text object
player_stats_tp_text_shadow = texts.new()
player_stats_tp_text_shadow:font(settings.sections.player_stats.font)
player_stats_tp_text_shadow:color(0,0,0)
player_stats_tp_text_shadow:alpha(text_alpha)
player_stats_tp_text_shadow:bg_alpha(0)
player_stats_tp_text_shadow:draggable(false)
player_stats_tp_text_shadow:bold(settings.sections.player_stats.bold)
player_stats_tp_text_shadow:italic(settings.sections.player_stats.italic)
player_stats_tp_text_shadow:size(settings.sections.player_stats.text_size)

--Create the Player Stats Pet TEXT SHADOW text object
player_stats_pet_text_shadow = texts.new()
player_stats_pet_text_shadow:font(settings.sections.player_stats.font)
player_stats_pet_text_shadow:color(0,0,0)
player_stats_pet_text_shadow:alpha(text_alpha)
player_stats_pet_text_shadow:bg_alpha(0)
player_stats_pet_text_shadow:draggable(false)
player_stats_pet_text_shadow:bold(settings.sections.player_stats.bold)
player_stats_pet_text_shadow:italic(settings.sections.player_stats.italic)
player_stats_pet_text_shadow:size(settings.sections.player_stats.text_size)

--TEXT

--Create the Focus Target TEXT text object
focus_target_text = texts.new()
focus_target_text:font(settings.sections.focus_target.font)
focus_target_text:color(text_color.r,text_color.g,text_color.b)
focus_target_text:alpha(text_alpha)
focus_target_text:bg_alpha(0)
focus_target_text:draggable(false)
focus_target_text:stroke_color(ft_text_stroke.r,ft_text_stroke.g,ft_text_stroke.b)
focus_target_text:stroke_alpha(ft_text_stroke.a)
focus_target_text:stroke_width(ft_text_stroke.w)
focus_target_text:bold(settings.sections.focus_target.bold)
focus_target_text:italic(settings.sections.focus_target.italic)
focus_target_text:size(settings.sections.focus_target.text_size)

--Create the Focus Target Action TEXT text object
focus_target_action_text = texts.new()
focus_target_action_text:font(settings.sections.focus_target.font)
focus_target_action_text:color(text_color.r,text_color.g,text_color.b)
focus_target_action_text:alpha(text_alpha)
focus_target_action_text:bg_alpha(0)
focus_target_action_text:draggable(false)
focus_target_action_text:stroke_color(ft_text_stroke.r,ft_text_stroke.g,ft_text_stroke.b)
focus_target_action_text:stroke_alpha(ft_text_stroke.a)
focus_target_action_text:stroke_width(ft_text_stroke.w)
focus_target_action_text:bold(settings.sections.focus_target.bold)
focus_target_action_text:italic(settings.sections.focus_target.italic)
focus_target_action_text:size(settings.sections.focus_target.sub_text_size)

--Create the Sub Target TEXT text object
sub_target_text = texts.new()
sub_target_text:font(settings.sections.sub_target.font)
sub_target_text:color(text_color.r,text_color.g,text_color.b)
sub_target_text:alpha(text_alpha)
sub_target_text:bg_alpha(0)
sub_target_text:draggable(false)
sub_target_text:stroke_color(st_text_stroke.r,st_text_stroke.g,st_text_stroke.b)
sub_target_text:stroke_alpha(st_text_stroke.a)
sub_target_text:stroke_width(st_text_stroke.w)
sub_target_text:bold(settings.sections.sub_target.bold)
sub_target_text:italic(settings.sections.sub_target.italic)
sub_target_text:size(settings.sections.sub_target.text_size)

--Create the Sub Target Action TEXT text object
sub_target_action_text = texts.new()
sub_target_action_text:font(settings.sections.sub_target.font)
sub_target_action_text:color(text_color.r,text_color.g,text_color.b)
sub_target_action_text:alpha(text_alpha)
sub_target_action_text:bg_alpha(0)
sub_target_action_text:draggable(false)
sub_target_action_text:stroke_color(st_text_stroke.r,st_text_stroke.g,st_text_stroke.b)
sub_target_action_text:stroke_alpha(st_text_stroke.a)
sub_target_action_text:stroke_width(st_text_stroke.w)
sub_target_action_text:bold(settings.sections.sub_target.bold)
sub_target_action_text:italic(settings.sections.sub_target.italic)
sub_target_action_text:size(settings.sections.sub_target.sub_text_size)

--Create the Target TEXT text object
target_text = texts.new()
target_text:font(settings.sections.target.font)
target_text:color(text_color.r,text_color.g,text_color.b)
target_text:alpha(text_alpha)
target_text:bg_alpha(0)
target_text:draggable(false)
target_text:stroke_color(t_text_stroke.r,t_text_stroke.g,t_text_stroke.b)
target_text:stroke_alpha(t_text_stroke.a)
target_text:stroke_width(t_text_stroke.w)
target_text:bold(settings.sections.target.bold)
target_text:italic(settings.sections.target.italic)
target_text:size(settings.sections.target.text_size)

--Create the Target Action TEXT text object
target_action_text = texts.new()
target_action_text:font(settings.sections.target.font)
target_action_text:color(text_color.r,text_color.g,text_color.b)
target_action_text:alpha(text_alpha)
target_action_text:bg_alpha(0)
target_action_text:draggable(false)
target_action_text:stroke_color(t_text_stroke.r,t_text_stroke.g,t_text_stroke.b)
target_action_text:stroke_alpha(t_text_stroke.a)
target_action_text:stroke_width(t_text_stroke.w)
target_action_text:bold(settings.sections.target.bold)
target_action_text:italic(settings.sections.target.italic)
target_action_text:size(settings.sections.target.sub_text_size)

--Create the Self Action TEXT text object
self_action_text = texts.new()
self_action_text:font(settings.sections.self_action.font)
self_action_text:color(text_color.r,text_color.g,text_color.b)
self_action_text:alpha(text_alpha)
self_action_text:bg_alpha(0)
self_action_text:draggable(false)
self_action_text:stroke_color(sa_text_stroke.r,sa_text_stroke.g,sa_text_stroke.b)
self_action_text:stroke_alpha(sa_text_stroke.a)
self_action_text:stroke_width(sa_text_stroke.w)
self_action_text:bold(settings.sections.self_action.bold)
self_action_text:italic(settings.sections.self_action.italic)
self_action_text:size(settings.sections.self_action.text_size)

--Create the Player Stats HP TEXT text object
player_stats_hp_text = texts.new()
player_stats_hp_text:font(settings.sections.player_stats.font)
player_stats_hp_text:color(text_color.r,text_color.g,text_color.b)
player_stats_hp_text:alpha(text_alpha)
player_stats_hp_text:bg_alpha(0)
player_stats_hp_text:draggable(false)
player_stats_hp_text:stroke_color(ps_text_stroke.r,ps_text_stroke.g,ps_text_stroke.b)
player_stats_hp_text:stroke_alpha(ps_text_stroke.a)
player_stats_hp_text:stroke_width(ps_text_stroke.w)
player_stats_hp_text:bold(settings.sections.player_stats.bold)
player_stats_hp_text:italic(settings.sections.player_stats.italic)
player_stats_hp_text:size(settings.sections.player_stats.text_size)

--Create the Player Stats MP TEXT text object
player_stats_mp_text = texts.new()
player_stats_mp_text:font(settings.sections.player_stats.font)
player_stats_mp_text:color(text_color.r,text_color.g,text_color.b)
player_stats_mp_text:alpha(text_alpha)
player_stats_mp_text:bg_alpha(0)
player_stats_mp_text:draggable(false)
player_stats_mp_text:stroke_color(ps_text_stroke.r,ps_text_stroke.g,ps_text_stroke.b)
player_stats_mp_text:stroke_alpha(ps_text_stroke.a)
player_stats_mp_text:stroke_width(ps_text_stroke.w)
player_stats_mp_text:bold(settings.sections.player_stats.bold)
player_stats_mp_text:italic(settings.sections.player_stats.italic)
player_stats_mp_text:size(settings.sections.player_stats.text_size)

--Create the Player Stats TP TEXT text object
player_stats_tp_text = texts.new()
player_stats_tp_text:font(settings.sections.player_stats.font)
player_stats_tp_text:color(text_color.r,text_color.g,text_color.b)
player_stats_tp_text:alpha(text_alpha)
player_stats_tp_text:bg_alpha(0)
player_stats_tp_text:draggable(false)
player_stats_tp_text:stroke_color(ps_text_stroke.r,ps_text_stroke.g,ps_text_stroke.b)
player_stats_tp_text:stroke_alpha(ps_text_stroke.a)
player_stats_tp_text:stroke_width(ps_text_stroke.w)
player_stats_tp_text:bold(settings.sections.player_stats.bold)
player_stats_tp_text:italic(settings.sections.player_stats.italic)
player_stats_tp_text:size(settings.sections.player_stats.text_size)

--Create the Player Stats Pet TEXT text object
player_stats_pet_text = texts.new()
player_stats_pet_text:font(settings.sections.player_stats.font)
player_stats_pet_text:color(text_color.r,text_color.g,text_color.b)
player_stats_pet_text:alpha(text_alpha)
player_stats_pet_text:bg_alpha(0)
player_stats_pet_text:draggable(false)
player_stats_pet_text:stroke_color(ps_text_stroke.r,ps_text_stroke.g,ps_text_stroke.b)
player_stats_pet_text:stroke_alpha(ps_text_stroke.a)
player_stats_pet_text:stroke_width(ps_text_stroke.w)
player_stats_pet_text:bold(settings.sections.player_stats.bold)
player_stats_pet_text:italic(settings.sections.player_stats.italic)
player_stats_pet_text:size(settings.sections.player_stats.text_size)

--Create the Party 1 P0 TEXT text object
party_actions_pt1_p0_text = texts.new()
party_actions_pt1_p0_text:font(party_1_actions.font)
party_actions_pt1_p0_text:color(pt1_text_color.r,pt1_text_color.g,pt1_text_color.b)
party_actions_pt1_p0_text:alpha(text_alpha)
party_actions_pt1_p0_text:italic(party_1_actions.italic)
party_actions_pt1_p0_text:bg_alpha(0)
party_actions_pt1_p0_text:draggable(false)
party_actions_pt1_p0_text:size(party_1_actions.text_size)
party_actions_pt1_p0_text:stroke_alpha(party_1_actions.stroke_alpha)
party_actions_pt1_p0_text:stroke_color(pt1_stroke_color.r,pt1_stroke_color.g,pt1_stroke_color.b)
party_actions_pt1_p0_text:stroke_width(party_1_actions.stroke_width)
party_actions_pt1_p0_text:right_justified(party_1_actions.right_align)
party_actions_pt1_p0_text:bold(party_1_actions.bold)

--Create the Party 1 P1 TEXT text object
party_actions_pt1_p1_text = texts.new()
party_actions_pt1_p1_text:font(party_1_actions.font)
party_actions_pt1_p1_text:color(pt1_text_color.r,pt1_text_color.g,pt1_text_color.b)
party_actions_pt1_p1_text:alpha(text_alpha)
party_actions_pt1_p1_text:italic(party_1_actions.italic)
party_actions_pt1_p1_text:bg_alpha(0)
party_actions_pt1_p1_text:draggable(false)
party_actions_pt1_p1_text:size(party_1_actions.text_size)
party_actions_pt1_p1_text:stroke_alpha(party_1_actions.stroke_alpha)
party_actions_pt1_p1_text:stroke_color(pt1_stroke_color.r,pt1_stroke_color.g,pt1_stroke_color.b)
party_actions_pt1_p1_text:stroke_width(party_1_actions.stroke_width)
party_actions_pt1_p1_text:right_justified(party_1_actions.right_align)
party_actions_pt1_p1_text:bold(party_1_actions.bold)

--Create the Party 1 P2 TEXT text object
party_actions_pt1_p2_text = texts.new()
party_actions_pt1_p2_text:font(party_1_actions.font)
party_actions_pt1_p2_text:color(pt1_text_color.r,pt1_text_color.g,pt1_text_color.b)
party_actions_pt1_p2_text:alpha(text_alpha)
party_actions_pt1_p2_text:italic(party_1_actions.italic)
party_actions_pt1_p2_text:bg_alpha(0)
party_actions_pt1_p2_text:draggable(false)
party_actions_pt1_p2_text:size(party_1_actions.text_size)
party_actions_pt1_p2_text:stroke_alpha(party_1_actions.stroke_alpha)
party_actions_pt1_p2_text:stroke_color(pt1_stroke_color.r,pt1_stroke_color.g,pt1_stroke_color.b)
party_actions_pt1_p2_text:stroke_width(party_1_actions.stroke_width)
party_actions_pt1_p2_text:right_justified(party_1_actions.right_align)
party_actions_pt1_p2_text:bold(party_1_actions.bold)


--Create the Party 1 P3 TEXT text object
party_actions_pt1_p3_text = texts.new()
party_actions_pt1_p3_text:font(party_1_actions.font)
party_actions_pt1_p3_text:color(pt1_text_color.r,pt1_text_color.g,pt1_text_color.b)
party_actions_pt1_p3_text:alpha(text_alpha)
party_actions_pt1_p3_text:italic(party_1_actions.italic)
party_actions_pt1_p3_text:bg_alpha(0)
party_actions_pt1_p3_text:draggable(false)
party_actions_pt1_p3_text:size(party_1_actions.text_size)
party_actions_pt1_p3_text:stroke_alpha(party_1_actions.stroke_alpha)
party_actions_pt1_p3_text:stroke_color(pt1_stroke_color.r,pt1_stroke_color.g,pt1_stroke_color.b)
party_actions_pt1_p3_text:stroke_width(party_1_actions.stroke_width)
party_actions_pt1_p3_text:right_justified(party_1_actions.right_align)
party_actions_pt1_p3_text:bold(party_1_actions.bold)

--Create the Party 1 P4 TEXT text object
party_actions_pt1_p4_text = texts.new()
party_actions_pt1_p4_text:font(party_1_actions.font)
party_actions_pt1_p4_text:color(pt1_text_color.r,pt1_text_color.g,pt1_text_color.b)
party_actions_pt1_p4_text:alpha(text_alpha)
party_actions_pt1_p4_text:italic(party_1_actions.italic)
party_actions_pt1_p4_text:bg_alpha(0)
party_actions_pt1_p4_text:draggable(false)
party_actions_pt1_p4_text:size(party_1_actions.text_size)
party_actions_pt1_p4_text:stroke_alpha(party_1_actions.stroke_alpha)
party_actions_pt1_p4_text:stroke_color(pt1_stroke_color.r,pt1_stroke_color.g,pt1_stroke_color.b)
party_actions_pt1_p4_text:stroke_width(party_1_actions.stroke_width)
party_actions_pt1_p4_text:right_justified(party_1_actions.right_align)
party_actions_pt1_p4_text:bold(party_1_actions.bold)

--Create the Party 1 P5 TEXT text object
party_actions_pt1_p5_text = texts.new()
party_actions_pt1_p5_text:font(party_1_actions.font)
party_actions_pt1_p5_text:color(pt1_text_color.r,pt1_text_color.g,pt1_text_color.b)
party_actions_pt1_p5_text:alpha(text_alpha)
party_actions_pt1_p5_text:italic(party_1_actions.italic)
party_actions_pt1_p5_text:bg_alpha(0)
party_actions_pt1_p5_text:draggable(false)
party_actions_pt1_p5_text:size(party_1_actions.text_size)
party_actions_pt1_p5_text:stroke_alpha(party_1_actions.stroke_alpha)
party_actions_pt1_p5_text:stroke_color(pt1_stroke_color.r,pt1_stroke_color.g,pt1_stroke_color.b)
party_actions_pt1_p5_text:stroke_width(party_1_actions.stroke_width)
party_actions_pt1_p5_text:right_justified(party_1_actions.right_align)
party_actions_pt1_p5_text:bold(party_1_actions.bold)

--Create the Party 2 P0 TEXT text object
party_actions_pt2_p0_text = texts.new()
party_actions_pt2_p0_text:font(party_2_actions.font)
party_actions_pt2_p0_text:color(pt2_text_color.r,pt2_text_color.g,pt2_text_color.b)
party_actions_pt2_p0_text:alpha(text_alpha)
party_actions_pt2_p0_text:italic(party_2_actions.italic)
party_actions_pt2_p0_text:bg_alpha(0)
party_actions_pt2_p0_text:draggable(false)
party_actions_pt2_p0_text:size(party_2_actions.text_size)
party_actions_pt2_p0_text:stroke_alpha(party_2_actions.stroke_alpha)
party_actions_pt2_p0_text:stroke_color(pt2_stroke_color.r,pt2_stroke_color.g,pt2_stroke_color.b)
party_actions_pt2_p0_text:stroke_width(party_2_actions.stroke_width)
party_actions_pt2_p0_text:right_justified(party_2_actions.right_align)
party_actions_pt2_p0_text:bold(party_2_actions.bold)

--Create the Party 2 P1 TEXT text object
party_actions_pt2_p1_text = texts.new()
party_actions_pt2_p1_text:font(party_2_actions.font)
party_actions_pt2_p1_text:color(pt2_text_color.r,pt2_text_color.g,pt2_text_color.b)
party_actions_pt2_p1_text:alpha(text_alpha)
party_actions_pt2_p1_text:italic(party_2_actions.italic)
party_actions_pt2_p1_text:bg_alpha(0)
party_actions_pt2_p1_text:draggable(false)
party_actions_pt2_p1_text:size(party_2_actions.text_size)
party_actions_pt2_p1_text:stroke_alpha(party_2_actions.stroke_alpha)
party_actions_pt2_p1_text:stroke_color(pt2_stroke_color.r,pt2_stroke_color.g,pt2_stroke_color.b)
party_actions_pt2_p1_text:stroke_width(party_2_actions.stroke_width)
party_actions_pt2_p1_text:right_justified(party_2_actions.right_align)
party_actions_pt2_p1_text:bold(party_2_actions.bold)

--Create the Party 2 P2 TEXT text object
party_actions_pt2_p2_text = texts.new()
party_actions_pt2_p2_text:font(party_2_actions.font)
party_actions_pt2_p2_text:color(pt2_text_color.r,pt2_text_color.g,pt2_text_color.b)
party_actions_pt2_p2_text:alpha(text_alpha)
party_actions_pt2_p2_text:italic(party_2_actions.italic)
party_actions_pt2_p2_text:bg_alpha(0)
party_actions_pt2_p2_text:draggable(false)
party_actions_pt2_p2_text:size(party_2_actions.text_size)
party_actions_pt2_p2_text:stroke_alpha(party_2_actions.stroke_alpha)
party_actions_pt2_p2_text:stroke_color(pt2_stroke_color.r,pt2_stroke_color.g,pt2_stroke_color.b)
party_actions_pt2_p2_text:stroke_width(party_2_actions.stroke_width)
party_actions_pt2_p2_text:right_justified(party_2_actions.right_align)
party_actions_pt2_p2_text:bold(party_2_actions.bold)

--Create the Party 2 P3 TEXT text object
party_actions_pt2_p3_text = texts.new()
party_actions_pt2_p3_text:font(party_2_actions.font)
party_actions_pt2_p3_text:color(pt2_text_color.r,pt2_text_color.g,pt2_text_color.b)
party_actions_pt2_p3_text:alpha(text_alpha)
party_actions_pt2_p3_text:italic(party_2_actions.italic)
party_actions_pt2_p3_text:bg_alpha(0)
party_actions_pt2_p3_text:draggable(false)
party_actions_pt2_p3_text:size(party_2_actions.text_size)
party_actions_pt2_p3_text:stroke_alpha(party_2_actions.stroke_alpha)
party_actions_pt2_p3_text:stroke_color(pt2_stroke_color.r,pt2_stroke_color.g,pt2_stroke_color.b)
party_actions_pt2_p3_text:stroke_width(party_2_actions.stroke_width)
party_actions_pt2_p3_text:right_justified(party_2_actions.right_align)
party_actions_pt2_p3_text:bold(party_2_actions.bold)

--Create the Party 2 P4 TEXT text object
party_actions_pt2_p4_text = texts.new()
party_actions_pt2_p4_text:font(party_2_actions.font)
party_actions_pt2_p4_text:color(pt2_text_color.r,pt2_text_color.g,pt2_text_color.b)
party_actions_pt2_p4_text:alpha(text_alpha)
party_actions_pt2_p4_text:italic(party_2_actions.italic)
party_actions_pt2_p4_text:bg_alpha(0)
party_actions_pt2_p4_text:draggable(false)
party_actions_pt2_p4_text:size(party_2_actions.text_size)
party_actions_pt2_p4_text:stroke_alpha(party_2_actions.stroke_alpha)
party_actions_pt2_p4_text:stroke_color(pt2_stroke_color.r,pt2_stroke_color.g,pt2_stroke_color.b)
party_actions_pt2_p4_text:stroke_width(party_2_actions.stroke_width)
party_actions_pt2_p4_text:right_justified(party_2_actions.right_align)
party_actions_pt2_p4_text:bold(party_2_actions.bold)

--Create the Party 2 P5 TEXT text object
party_actions_pt2_p5_text = texts.new()
party_actions_pt2_p5_text:font(party_2_actions.font)
party_actions_pt2_p5_text:color(pt2_text_color.r,pt2_text_color.g,pt2_text_color.b)
party_actions_pt2_p5_text:alpha(text_alpha)
party_actions_pt2_p5_text:italic(party_2_actions.italic)
party_actions_pt2_p5_text:bg_alpha(0)
party_actions_pt2_p5_text:draggable(false)
party_actions_pt2_p5_text:size(party_2_actions.text_size)
party_actions_pt2_p5_text:stroke_alpha(party_2_actions.stroke_alpha)
party_actions_pt2_p5_text:stroke_color(pt2_stroke_color.r,pt2_stroke_color.g,pt2_stroke_color.b)
party_actions_pt2_p5_text:stroke_width(party_2_actions.stroke_width)
party_actions_pt2_p5_text:right_justified(party_2_actions.right_align)
party_actions_pt2_p5_text:bold(party_2_actions.bold)

--Create the Party 3 P0 TEXT text object
party_actions_pt3_p0_text = texts.new()
party_actions_pt3_p0_text:font(party_3_actions.font)
party_actions_pt3_p0_text:color(pt3_text_color.r,pt3_text_color.g,pt3_text_color.b)
party_actions_pt3_p0_text:alpha(text_alpha)
party_actions_pt3_p0_text:italic(party_3_actions.italic)
party_actions_pt3_p0_text:bg_alpha(0)
party_actions_pt3_p0_text:draggable(false)
party_actions_pt3_p0_text:size(party_3_actions.text_size)
party_actions_pt3_p0_text:stroke_alpha(party_3_actions.stroke_alpha)
party_actions_pt3_p0_text:stroke_color(pt3_stroke_color.r,pt3_stroke_color.g,pt3_stroke_color.b)
party_actions_pt3_p0_text:stroke_width(party_3_actions.stroke_width)
party_actions_pt3_p0_text:right_justified(party_3_actions.right_align)
party_actions_pt3_p0_text:bold(party_3_actions.bold)

--Create the Party 3 P1 TEXT text object
party_actions_pt3_p1_text = texts.new()
party_actions_pt3_p1_text:font(party_3_actions.font)
party_actions_pt3_p1_text:color(pt3_text_color.r,pt3_text_color.g,pt3_text_color.b)
party_actions_pt3_p1_text:alpha(text_alpha)
party_actions_pt3_p1_text:italic(party_3_actions.italic)
party_actions_pt3_p1_text:bg_alpha(0)
party_actions_pt3_p1_text:draggable(false)
party_actions_pt3_p1_text:size(party_3_actions.text_size)
party_actions_pt3_p1_text:stroke_alpha(party_3_actions.stroke_alpha)
party_actions_pt3_p1_text:stroke_color(pt3_stroke_color.r,pt3_stroke_color.g,pt3_stroke_color.b)
party_actions_pt3_p1_text:stroke_width(party_3_actions.stroke_width)
party_actions_pt3_p1_text:right_justified(party_3_actions.right_align)
party_actions_pt3_p1_text:bold(party_3_actions.bold)

--Create the Party 3 P2 TEXT text object
party_actions_pt3_p2_text = texts.new()
party_actions_pt3_p2_text:font(party_3_actions.font)
party_actions_pt3_p2_text:color(pt3_text_color.r,pt3_text_color.g,pt3_text_color.b)
party_actions_pt3_p2_text:alpha(text_alpha)
party_actions_pt3_p2_text:italic(party_3_actions.italic)
party_actions_pt3_p2_text:bg_alpha(0)
party_actions_pt3_p2_text:draggable(false)
party_actions_pt3_p2_text:size(party_3_actions.text_size)
party_actions_pt3_p2_text:stroke_alpha(party_3_actions.stroke_alpha)
party_actions_pt3_p2_text:stroke_color(pt3_stroke_color.r,pt3_stroke_color.g,pt3_stroke_color.b)
party_actions_pt3_p2_text:stroke_width(party_3_actions.stroke_width)
party_actions_pt3_p2_text:right_justified(party_3_actions.right_align)
party_actions_pt3_p2_text:bold(party_3_actions.bold)

--Create the Party 3 P3 TEXT text object
party_actions_pt3_p3_text = texts.new()
party_actions_pt3_p3_text:font(party_3_actions.font)
party_actions_pt3_p3_text:color(pt3_text_color.r,pt3_text_color.g,pt3_text_color.b)
party_actions_pt3_p3_text:alpha(text_alpha)
party_actions_pt3_p3_text:italic(party_3_actions.italic)
party_actions_pt3_p3_text:bg_alpha(0)
party_actions_pt3_p3_text:draggable(false)
party_actions_pt3_p3_text:size(party_3_actions.text_size)
party_actions_pt3_p3_text:stroke_alpha(party_3_actions.stroke_alpha)
party_actions_pt3_p3_text:stroke_color(pt3_stroke_color.r,pt3_stroke_color.g,pt3_stroke_color.b)
party_actions_pt3_p3_text:stroke_width(party_3_actions.stroke_width)
party_actions_pt3_p3_text:right_justified(party_3_actions.right_align)
party_actions_pt3_p3_text:bold(party_3_actions.bold)

--Create the Party 3 P4 TEXT text object
party_actions_pt3_p4_text = texts.new()
party_actions_pt3_p4_text:font(party_3_actions.font)
party_actions_pt3_p4_text:color(pt3_text_color.r,pt3_text_color.g,pt3_text_color.b)
party_actions_pt3_p4_text:alpha(text_alpha)
party_actions_pt3_p4_text:italic(party_3_actions.italic)
party_actions_pt3_p4_text:bg_alpha(0)
party_actions_pt3_p4_text:draggable(false)
party_actions_pt3_p4_text:size(party_3_actions.text_size)
party_actions_pt3_p4_text:stroke_alpha(party_3_actions.stroke_alpha)
party_actions_pt3_p4_text:stroke_color(pt3_stroke_color.r,pt3_stroke_color.g,pt3_stroke_color.b)
party_actions_pt3_p4_text:stroke_width(party_3_actions.stroke_width)
party_actions_pt3_p4_text:right_justified(party_3_actions.right_align)
party_actions_pt3_p4_text:bold(party_3_actions.bold)

--Create the Party 3 P5 TEXT text object
party_actions_pt3_p5_text = texts.new()
party_actions_pt3_p5_text:font(party_3_actions.font)
party_actions_pt3_p5_text:color(pt3_text_color.r,pt3_text_color.g,pt3_text_color.b)
party_actions_pt3_p5_text:alpha(text_alpha)
party_actions_pt3_p5_text:italic(party_3_actions.italic)
party_actions_pt3_p5_text:bg_alpha(0)
party_actions_pt3_p5_text:draggable(false)
party_actions_pt3_p5_text:size(party_3_actions.text_size)
party_actions_pt3_p5_text:stroke_alpha(party_3_actions.stroke_alpha)
party_actions_pt3_p5_text:stroke_color(pt3_stroke_color.r,pt3_stroke_color.g,pt3_stroke_color.b)
party_actions_pt3_p5_text:stroke_width(party_3_actions.stroke_width)
party_actions_pt3_p5_text:right_justified(party_3_actions.right_align)
party_actions_pt3_p5_text:bold(party_3_actions.bold)

--Setup UI object positions
function setUIPositions()

	--Prevent prerender from hiding the UI objects while we use extents
	calculating_dimensions = true

	--Place UI objects off screen
	--A text object needs to be visible in order to use extents to calculate it's dimensions, so we put them way off screen so the user never sees it.
	focus_target_bar_bg:pos(-1000,-1000)
	focus_target_bar_bg:show()

	sub_target_bar_bg:pos(-1000,-1000)
	sub_target_bar_bg:show()

	target_bar_bg:pos(-1000,-1000)
	target_bar_bg:show()

	target_bar_lock_left:pos(-1000,-1000)
	target_bar_lock_left:show()
	target_bar_lock_right:pos(-1000,-1000)
	target_bar_lock_underline:pos(-1000,-1000)
	target_bar_lock_underline:show()

	self_action_bar_bg:pos(-1000,-1000)
	self_action_bar_bg:show()

	player_stats_hp_bar_bg:pos(-1000,-1000)
	player_stats_hp_bar_bg:show()

	--Wait 0.1 seconds to give time for text objects to display on screen so extents has something to calculate with
	coroutine.schedule(function()

		--Calculate dimensions of UI objects
		focus_target_bar_pixel_width, focus_target_bar_pixel_height = focus_target_bar_bg:extents()
		sub_target_bar_pixel_width, sub_target_bar_pixel_height = sub_target_bar_bg:extents()
		target_bar_pixel_width, target_bar_pixel_height = target_bar_bg:extents()
		target_lock_icon_pixel_width, target_lock_icon_pixel_height = target_bar_lock_left:extents()
		target_lock_underline_pixel_width = target_bar_lock_underline:extents()
		self_action_bar_pixel_width, self_action_bar_pixel_height = self_action_bar_bg:extents()
		player_stats_bars_pixel_width, player_stats_bars_pixel_height = player_stats_hp_bar_bg:extents()

		--Done with extent calculations
		calculating_dimensions = false

		--Position of bar sections
		local ft_pos = {x = settings.sections.focus_target.pos.x, y = settings.sections.focus_target.pos.y + job_specific[job].vertical_offsets.focus_target}
		local st_pos = {x = settings.sections.sub_target.pos.x, y = settings.sections.sub_target.pos.y + job_specific[job].vertical_offsets.sub_target}
		local t_pos = {x = settings.sections.target.pos.x, y = settings.sections.target.pos.y + job_specific[job].vertical_offsets.target}
		local sa_pos = {x = settings.sections.self_action.pos.x, y = settings.sections.self_action.pos.y + job_specific[job].vertical_offsets.self_action}
		local ps_pos = {x = settings.sections.player_stats.pos.x, y = settings.sections.player_stats.pos.y + job_specific[job].vertical_offsets.player_stats}
		
		--Determine positioning of UI objects
		local icon_left_x = t_pos.x - target_lock_icon_pixel_width
		local icon_y = t_pos.y - (target_lock_icon_pixel_height / 2)
		local icon_right_x = t_pos.x + target_bar_pixel_width + 2
		local underline_x = t_pos.x + (target_bar_pixel_width / 2) - (target_lock_underline_pixel_width / 2)
		local underline_y = t_pos.y + target_bar_pixel_height

		local ui_bg_ft_l_x = ft_pos.x
		local ui_bg_ft_m_x = ft_pos.x + 10
		local ui_bg_ft_r_x = ft_pos.x + (focus_target_bar_pixel_width - 10)
		local ui_bg_ft_y = ft_pos.y + (focus_target_bar_pixel_height / 2) - 25

		local ui_bg_st_l_x = st_pos.x
		local ui_bg_st_m_x = st_pos.x + 10
		local ui_bg_st_r_x = st_pos.x + (sub_target_bar_pixel_width - 10)
		local ui_bg_st_y = st_pos.y + (sub_target_bar_pixel_height / 2) - 25

		local ui_bg_t_l_x = t_pos.x
		local ui_bg_t_m_x = t_pos.x + 10
		local ui_bg_t_r_x = t_pos.x + (target_bar_pixel_width - 10)
		local ui_bg_t_y = t_pos.y + (target_bar_pixel_height / 2) - 25

		local ui_bg_sa_l_x = sa_pos.x
		local ui_bg_sa_m_x = sa_pos.x + 10
		local ui_bg_sa_r_x = sa_pos.x + (self_action_bar_pixel_width - 10)
		local ui_bg_sa_y = sa_pos.y + (self_action_bar_pixel_height / 2) - 25

		--Hide objects then move them into correct positions
		focus_target_bar_bg:hide()
		focus_target_bar_bg:pos(ft_pos.x, ft_pos.y)

		sub_target_bar_bg:hide()
		sub_target_bar_bg:pos(st_pos.x, st_pos.y)

		target_bar_bg:hide()
		target_bar_bg:pos(t_pos.x, t_pos.y)

		self_action_bar_bg:hide()
		self_action_bar_bg:pos(sa_pos.x, sa_pos.y)

		player_stats_hp_bar_bg:hide()
		player_stats_hp_bar_bg:pos(ps_pos.x, ps_pos.y)
		hpChange()

		target_bar_lock_left:hide()
		target_bar_lock_left:pos(icon_left_x,icon_y)
		target_bar_lock_right:hide()
		target_bar_lock_right:pos(icon_right_x,icon_y)
		target_bar_lock_underline:hide()
		target_bar_lock_underline:pos(underline_x, underline_y)

		ui_bg_left.focus_target:pos(ui_bg_ft_l_x,ui_bg_ft_y)
		ui_bg_left.focus_target:size(10,50)
		ui_bg_middle.focus_target:pos(ui_bg_ft_m_x,ui_bg_ft_y)
		ui_bg_middle.focus_target:size(focus_target_bar_pixel_width - 20,50)
		ui_bg_right.focus_target:pos(ui_bg_ft_r_x,ui_bg_ft_y)
		ui_bg_right.focus_target:size(10,50)

		ui_bg_left.sub_target:pos(ui_bg_st_l_x,ui_bg_st_y)
		ui_bg_left.sub_target:size(10,50)
		ui_bg_middle.sub_target:pos(ui_bg_st_m_x,ui_bg_st_y)
		ui_bg_middle.sub_target:size(sub_target_bar_pixel_width - 20,50)
		ui_bg_right.sub_target:pos(ui_bg_st_r_x,ui_bg_st_y)
		ui_bg_right.sub_target:size(10,50)

		ui_bg_left.target:pos(ui_bg_t_l_x,ui_bg_t_y)
		ui_bg_left.target:size(10,50)
		ui_bg_middle.target:pos(ui_bg_t_m_x,ui_bg_t_y)
		ui_bg_middle.target:size(target_bar_pixel_width - 20,50)
		ui_bg_right.target:pos(ui_bg_t_r_x,ui_bg_t_y)
		ui_bg_right.target:size(10,50)

		ui_bg_left.self_action:pos(ui_bg_sa_l_x,ui_bg_sa_y)
		ui_bg_left.self_action:size(10,25)
		ui_bg_middle.self_action:pos(ui_bg_sa_m_x,ui_bg_sa_y)
		ui_bg_middle.self_action:size(self_action_bar_pixel_width - 20,25)
		ui_bg_right.self_action:pos(ui_bg_sa_r_x,ui_bg_sa_y)
		ui_bg_right.self_action:size(10,25)

	end, 0.1)

end

--Set the bars in their appropriate positions
function setPositions()

	--Section spacing/offsets
	local ft_text_offset = settings.sections.focus_target.text_offset
	local ft_text_shadow_offset = settings.sections.focus_target.text_shadow_offset
	local ft_sub_text_offset = settings.sections.focus_target.sub_text_offset
	local ft_sub_text_shadow_offset = settings.sections.focus_target.sub_text_shadow_offset

	local st_text_offset = settings.sections.sub_target.text_offset
	local st_text_shadow_offset = settings.sections.sub_target.text_shadow_offset
	local st_sub_text_offset = settings.sections.sub_target.sub_text_offset
	local st_sub_text_shadow_offset = settings.sections.sub_target.sub_text_shadow_offset

	local t_text_offset = settings.sections.target.text_offset
	local t_text_shadow_offset = settings.sections.target.text_shadow_offset
	local t_sub_text_offset = settings.sections.target.sub_text_offset
	local t_sub_text_shadow_offset = settings.sections.target.sub_text_shadow_offset

	local sa_text_offset = settings.sections.self_action.text_offset
	local sa_text_shadow_offset = settings.sections.self_action.text_shadow_offset
	
	local ps_vertical_spacing_between_player_stats = settings.sections.player_stats.vertical_spacing_between_player_stats
	local ps_text_offset = settings.sections.player_stats.text_offset
	local ps_text_shadow_offset = settings.sections.player_stats.text_shadow_offset

	--Set section anchor positions
	local ft_pos = {x = settings.sections.focus_target.pos.x, y = settings.sections.focus_target.pos.y + job_specific[job].vertical_offsets.focus_target}
	local st_pos = {x = settings.sections.sub_target.pos.x, y = settings.sections.sub_target.pos.y + job_specific[job].vertical_offsets.sub_target}
	local t_pos = {x = settings.sections.target.pos.x, y = settings.sections.target.pos.y + job_specific[job].vertical_offsets.target}
	local sa_pos = {x = settings.sections.self_action.pos.x, y = settings.sections.self_action.pos.y + job_specific[job].vertical_offsets.self_action}
	local ps_pos = {x = settings.sections.player_stats.pos.x, y = settings.sections.player_stats.pos.y + job_specific[job].vertical_offsets.player_stats}

	local player_stats_1 = {x = ps_pos.x, y = ps_pos.y}
	local player_stats_2 = {x = t_pos.x, y = player_stats_1.y + ps_vertical_spacing_between_player_stats}
	local player_stats_3 = {x = t_pos.x, y = player_stats_2.y + ps_vertical_spacing_between_player_stats}
	local player_stats_4 = {x = t_pos.x, y = player_stats_3.y + ps_vertical_spacing_between_player_stats}

	--Assign positions
	local function assign_positions(bars)
		local positions = {}
		local offset_y = 0

		if bars.hp then
			positions.hp = {x = player_stats_1.x, y = player_stats_1.y + offset_y}
			offset_y = offset_y + ps_vertical_spacing_between_player_stats
		end

		if bars.mp then
			positions.mp = {x = player_stats_1.x, y = player_stats_1.y + offset_y}
			offset_y = offset_y + ps_vertical_spacing_between_player_stats
		end

		if bars.tp then
			positions.tp = {x = player_stats_1.x, y = player_stats_1.y + offset_y}
			offset_y = offset_y + ps_vertical_spacing_between_player_stats
		end

		positions.pet = {x = player_stats_1.x, y = player_stats_1.y + offset_y}
		return positions
	end

	--Determine Player Stats bars positions based on which bars are displayed
	local positions = assign_positions(job_specific[job])
	local pos_hp = positions.hp or player_stats_1
	local pos_mp = positions.mp or player_stats_2
	local pos_tp = positions.tp or player_stats_3
	local pos_pet = positions.pet or player_stats_4

	--Set bar positions
	focus_target_bar_meter:pos(ft_pos.x + 1, ft_pos.y + 1)
	focus_target_bar_drain_meter:pos(ft_pos.x + 1, ft_pos.y + 1)
	focus_target_bar_bg:pos(ft_pos.x, ft_pos.y)
	focus_target_bar_pulse:pos(ft_pos.x, ft_pos.y)
	focus_target_text:pos(ft_pos.x, ft_pos.y + ft_text_offset)
	focus_target_text_shadow:pos(ft_pos.x + ft_text_shadow_offset, ft_pos.y + ft_text_offset + ft_text_shadow_offset)
	focus_target_action_text:pos(ft_pos.x, ft_pos.y + ft_sub_text_offset)
	focus_target_action_text_shadow:pos(ft_pos.x + ft_sub_text_shadow_offset, ft_pos.y + ft_sub_text_offset + ft_sub_text_shadow_offset)

	sub_target_bar_meter:pos(st_pos.x + 1, st_pos.y + 1)
	sub_target_bar_drain_meter:pos(st_pos.x + 1, st_pos.y + 1)
	sub_target_bar_bg:pos(st_pos.x, st_pos.y)
	sub_target_bar_pulse:pos(st_pos.x, st_pos.y)
	sub_target_text:pos(st_pos.x, st_pos.y + st_text_offset)
	sub_target_text_shadow:pos(st_pos.x + st_text_shadow_offset, st_pos.y + st_text_offset + st_text_shadow_offset)
	sub_target_action_text:pos(st_pos.x, st_pos.y + st_sub_text_offset)
	sub_target_action_text_shadow:pos(st_pos.x + st_sub_text_shadow_offset, st_pos.y + st_sub_text_offset + st_sub_text_shadow_offset)

	target_bar_meter:pos(t_pos.x + 1, t_pos.y + 1)
	target_bar_drain_meter:pos(t_pos.x + 1, t_pos.y + 1)
	--target_bar_bg pos gets set below since we need to borrow it rq to caluclate where to put the Target Lock
	target_bar_pulse:pos(t_pos.x, t_pos.y)
	target_text:pos(t_pos.x, t_pos.y + t_text_offset)
	target_text_shadow:pos(t_pos.x + t_text_shadow_offset, t_pos.y + t_text_offset + t_text_shadow_offset)
	target_action_text:pos(t_pos.x, t_pos.y + t_sub_text_offset)
	target_action_text_shadow:pos(t_pos.x + t_sub_text_shadow_offset, t_pos.y + t_sub_text_offset + t_sub_text_shadow_offset)

	self_action_bar_meter:pos(sa_pos.x + 1, sa_pos.y + 1)
	self_action_bar_bg:pos(sa_pos.x, sa_pos.y)
	self_action_text:pos(sa_pos.x, sa_pos.y + sa_text_offset)
	self_action_text_shadow:pos(sa_pos.x + sa_text_shadow_offset, sa_pos.y + sa_text_offset + sa_text_shadow_offset)

	player_stats_hp_bar_meter:pos(pos_hp.x + 1, pos_hp.y + 1)
	player_stats_hp_bar_drain_meter:pos(pos_hp.x + 1, pos_hp.y + 1)
	player_stats_hp_bar_bg:pos(pos_hp.x, pos_hp.y)
	player_stats_hp_bar_pulse:pos(pos_hp.x, pos_hp.y)
	player_stats_hp_marker:pos(pos_hp.x, pos_hp.y - 1)
	player_stats_hp_text:pos(pos_hp.x, pos_hp.y + ps_text_offset)
	player_stats_hp_text_shadow:pos(pos_hp.x + ps_text_shadow_offset, pos_hp.y + ps_text_offset + ps_text_shadow_offset)

	player_stats_mp_bar_drain_meter:pos(pos_mp.x + 1, pos_mp.y + 1)
	player_stats_mp_bar_meter:pos(pos_mp.x + 1, pos_mp.y + 1)
	player_stats_mp_bar_bg:pos(pos_mp.x, pos_mp.y)
	player_stats_mp_bar_pulse:pos(pos_mp.x, pos_mp.y)
	player_stats_mp_text:pos(pos_mp.x, pos_mp.y + ps_text_offset)
	player_stats_mp_text_shadow:pos(pos_mp.x + ps_text_shadow_offset, pos_mp.y + ps_text_offset + ps_text_shadow_offset)

	player_stats_tp_bar_meter:pos(pos_tp.x + 1, pos_tp.y + 1)
	player_stats_tp_bar_drain_meter:pos(pos_tp.x + 1, pos_tp.y + 1)
	player_stats_tp_bar_bg:pos(pos_tp.x, pos_tp.y)
	player_stats_tp_bar_pulse:pos(pos_tp.x, pos_tp.y)
	player_stats_tp_marker:pos(pos_tp.x, pos_tp.y - 1)
	player_stats_tp_text:pos(pos_tp.x, pos_tp.y + ps_text_offset)
	player_stats_tp_text_shadow:pos(pos_tp.x + ps_text_shadow_offset, pos_tp.y + ps_text_offset + ps_text_shadow_offset)

	player_stats_pet_bar_meter:pos(pos_pet.x + 1, pos_pet.y + 1)
	player_stats_pet_bar_drain_meter:pos(pos_pet.x + 1, pos_pet.y + 1)
	player_stats_pet_bar_bg:pos(pos_pet.x, pos_pet.y)
	player_stats_pet_bar_pulse:pos(pos_pet.x, pos_pet.y)
	player_stats_pet_text:pos(pos_pet.x, pos_pet.y + ps_text_offset)
	player_stats_pet_text_shadow:pos(pos_pet.x + ps_text_shadow_offset, pos_pet.y + ps_text_offset + ps_text_shadow_offset)

	--Determine which Player Stat is at the top Player Stat bar position
	if positions.hp and positions.hp.y == player_stats_1.y then
		player_stats_top_bar = 'hp'
	elseif positions.mp and positions.mp.y == player_stats_1.y then
		player_stats_top_bar = 'mp'
	elseif positions.tp and positions.tp.y == player_stats_1.y then
		player_stats_top_bar = 'tp'
	elseif positions.pet and positions.pet.y == player_stats_1.y then
		player_stats_top_bar = 'pet'
	end

	--Set Debuff Icons image object positions
	for section, section_table in pairs(debuff_icons) do
		local spacing = 0
		local section_settings = settings.sections[section]

		for i, icon in ipairs(section_table) do
			icon:pos(section_settings.pos.x + spacing, section_settings.pos.y + job_specific[job].vertical_offsets[section] + section_settings.debuff_icon_offset)

			spacing = spacing + section_settings.debuff_icon_size + section_settings.debuff_icon_spacing
		end
	end

	--Set Debuff Timers text object positions
	for section, section_table in pairs(debuff_timers) do
		local spacing = 0
		local section_settings = settings.sections[section]

		for i, timer in ipairs(section_table) do
			timer:pos(section_settings.pos.x + spacing, section_settings.pos.y + job_specific[job].vertical_offsets[section] + section_settings.debuff_timer_offset)

			spacing = spacing + section_settings.debuff_icon_size + section_settings.debuff_icon_spacing
		end
	end

	setUIPositions()

end

--Update the positions of the Party Actions text objects
function updatePartyActionsPos(num_party1_members, num_party2_members, num_party3_members)
	local pt1_bottom_up = party_1_actions.bottom_up
	local pt1_pos_x = party_1_actions.pos.x
	local pt1_pos_y = party_1_actions.pos.y
	local pt1_y_spacing = party_1_actions.vertical_spacing_between_players
	local pt2_bottom_up = party_2_actions.bottom_up
	local pt2_pos_x = party_2_actions.pos.x
	local pt2_pos_y = party_2_actions.pos.y
	local pt2_y_spacing = party_2_actions.vertical_spacing_between_players
	local pt3_bottom_up = party_3_actions.bottom_up
	local pt3_pos_x = party_3_actions.pos.x
	local pt3_pos_y = party_3_actions.pos.y
	local pt3_y_spacing = party_3_actions.vertical_spacing_between_players

	--Define Party 1 positions
	local pt1_positions = {
		{x = pt1_pos_x, y = pt1_pos_y},							--position 1 (top)
		{x = pt1_pos_x, y = pt1_pos_y + pt1_y_spacing},			--position 2
		{x = pt1_pos_x, y = pt1_pos_y + (pt1_y_spacing * 2)},	--position 3
		{x = pt1_pos_x, y = pt1_pos_y + (pt1_y_spacing * 3)},	--position 4
		{x = pt1_pos_x, y = pt1_pos_y + (pt1_y_spacing * 4)},	--position 5
		{x = pt1_pos_x, y = pt1_pos_y + (pt1_y_spacing * 5)},	--position 6 (bottom)
	}

	--Define Party 2 positions
	local pt2_positions = {
		{x = pt2_pos_x, y = pt2_pos_y},							--position 1 (top)
		{x = pt2_pos_x, y = pt2_pos_y + pt2_y_spacing},			--position 2
		{x = pt2_pos_x, y = pt2_pos_y + (pt2_y_spacing * 2)},	--position 3
		{x = pt2_pos_x, y = pt2_pos_y + (pt2_y_spacing * 3)},	--position 4
		{x = pt2_pos_x, y = pt2_pos_y + (pt2_y_spacing * 4)},	--position 5
		{x = pt2_pos_x, y = pt2_pos_y + (pt2_y_spacing * 5)},	--position 6 (bottom)
	}

	--Define Party 3 positions
	local pt3_positions = {
		{x = pt3_pos_x, y = pt3_pos_y},							--position 1 (top)
		{x = pt3_pos_x, y = pt3_pos_y + pt3_y_spacing},			--position 2
		{x = pt3_pos_x, y = pt3_pos_y + (pt3_y_spacing * 2)},	--position 3
		{x = pt3_pos_x, y = pt3_pos_y + (pt3_y_spacing * 3)},	--position 4
		{x = pt3_pos_x, y = pt3_pos_y + (pt3_y_spacing * 4)},	--position 5
		{x = pt3_pos_x, y = pt3_pos_y + (pt3_y_spacing * 5)},	--position 6 (bottom)
	}

	pt1_text_objects = {
		party_actions_pt1_p0_text,
		party_actions_pt1_p1_text,
		party_actions_pt1_p2_text,
		party_actions_pt1_p3_text,
		party_actions_pt1_p4_text,
		party_actions_pt1_p5_text
	}

	pt2_text_objects = {
		party_actions_pt2_p0_text,
		party_actions_pt2_p1_text,
		party_actions_pt2_p2_text,
		party_actions_pt2_p3_text,
		party_actions_pt2_p4_text,
		party_actions_pt2_p5_text
	}

	pt3_text_objects = {
		party_actions_pt3_p0_text,
		party_actions_pt3_p1_text,
		party_actions_pt3_p2_text,
		party_actions_pt3_p3_text,
		party_actions_pt3_p4_text,
		party_actions_pt3_p5_text
	}

	--Handle Party 1
	if num_party1_members and num_party1_members > 0 then
		for i = 1, num_party1_members do
			local pos_index = pt1_bottom_up and (7 - (num_party1_members - (i - 1))) or i --flip order if bottom_up
			local obj = pt1_text_objects[i]
			local pos = pt1_positions[pos_index]
			if obj and pos then
				obj:pos(pos.x, pos.y)
			end
		end
	end

	--Handle Party 2
	if num_party2_members and num_party2_members > 0 then
		for i = 1, num_party2_members do
			local pos_index = pt2_bottom_up and (7 - (num_party2_members - (i - 1))) or i --flip order if bottom_up
			local obj = pt2_text_objects[i]
			local pos = pt2_positions[pos_index]
			if obj and pos then
				obj:pos(pos.x, pos.y)
			end
		end
	end

	--Handle Party 3
	if num_party3_members and num_party3_members > 0 then
		for i = 1, num_party3_members do
			local pos_index = pt3_bottom_up and (7 - (num_party3_members - (i - 1))) or i --flip order if bottom_up
			local obj = pt3_text_objects[i]
			local pos = pt3_positions[pos_index]
			if obj and pos then
				obj:pos(pos.x, pos.y)
			end
		end
	end

end

--Set the width of the different sections based on the bar_width options
function setWidth()

	local function generateMarkerString(bar_width, marker_positions)
		local marker_str = {}
		for i = 1, (bar_width * 10) do
			if marker_positions[i] then
				table.insert(marker_str, '█') --·█│■●║
			else
				table.insert(marker_str, ' ')
			end
		end
		return table.concat(marker_str)
	end

	local function generateWidthString(width)
		return string.rep(' ', width)
	end

	--Marker positions
	local hp_marker_index = math.floor((player_stats_bar_width * 5) * 0.75)
	local tp_marker_indices = {
		[math.floor((player_stats_bar_width * 5) * 0.33)] = true,
		[math.floor((player_stats_bar_width * 5) * 0.66)] = true,
	}
	local hp_markers_str = generateMarkerString(player_stats_bar_width, { [hp_marker_index] = true })
	local tp_markers_str = generateMarkerString(player_stats_bar_width, tp_marker_indices)
	player_stats_hp_marker:text(show_hp_tp_markers and '\n\n'..hp_markers_str or '')
	player_stats_tp_marker:text(show_hp_tp_markers and '\n\n'..tp_markers_str or '')

	--Apply width strings
	local width_config = {
		{ var = "focus_target_bar_width",	target = focus_target_bar_bg },
		{ var = "focus_target_bar_width",	target = focus_target_bar_pulse },
		{ var = "sub_target_bar_width",		target = sub_target_bar_bg },
		{ var = "sub_target_bar_width",		target = sub_target_bar_pulse },
		{ var = "target_bar_width",			target = target_bar_bg },
		{ var = "target_bar_width",			target = target_bar_pulse },
		{ var = "target_bar_width",			target = target_bar_lock_underline },
		{ var = "self_action_bar_width",	target = self_action_bar_bg },
		{ var = "player_stats_bar_width",	target = player_stats_hp_bar_bg },
		{ var = "player_stats_bar_width",	target = player_stats_hp_bar_pulse },
		{ var = "player_stats_bar_width",	target = player_stats_mp_bar_bg },
		{ var = "player_stats_bar_width",	target = player_stats_mp_bar_pulse },
		{ var = "player_stats_bar_width",	target = player_stats_tp_bar_bg },
		{ var = "player_stats_bar_width",	target = player_stats_tp_bar_pulse },
		{ var = "player_stats_bar_width",	target = player_stats_pet_bar_bg },
		{ var = "player_stats_bar_width",	target = player_stats_pet_bar_pulse },
	}

	for _, item in ipairs(width_config) do
		item.target:text(generateWidthString(_G[item.var]))
	end

end

--Hide all bars
function hideBars()

	focus_target_bar_meter:hide()
	focus_target_bar_drain_meter:hide()
	focus_target_bar_bg:hide()
	focus_target_bar_pulse:hide()
	focus_target_text:hide()
	focus_target_text_shadow:hide()
	focus_target_action_text:hide()
	focus_target_action_text_shadow:hide()
	ui_bg_left.focus_target:hide()
	ui_bg_middle.focus_target:hide()
	ui_bg_right.focus_target:hide()
	local ft_icon_set = debuff_icons.focus_target
	local ft_settings = settings.sections.focus_target
	local ft_timer_set = debuff_timers.focus_target
	if ft_icon_set[1]:visible() then
		for k = 1, max_icons.focus_target do
			ft_icon_set[k]:hide()
			if ft_settings.debuff_timers then
				ft_timer_set[k]:hide()
			end
		end
	end

	sub_target_bar_meter:hide()
	sub_target_bar_drain_meter:hide()
	sub_target_bar_bg:hide()
	sub_target_bar_pulse:hide()
	sub_target_text:hide()
	sub_target_text_shadow:hide()
	sub_target_action_text:hide()
	sub_target_action_text_shadow:hide()
	ui_bg_left.sub_target:hide()
	ui_bg_middle.sub_target:hide()
	ui_bg_right.sub_target:hide()
	local st_icon_set = debuff_icons.sub_target
	local st_settings = settings.sections.sub_target
	local st_timer_set = debuff_timers.sub_target
	if st_icon_set[1]:visible() then
		for k = 1, max_icons.sub_target do
			st_icon_set[k]:hide()
			if st_settings.debuff_timers then
				st_timer_set[k]:hide()
			end
		end
	end

	--These need to be visible when calculating their dimensions so we can set the UI image objects correctly
	if not calculating_dimensions then
		focus_target_bar_bg:hide()
		sub_target_bar_bg:hide()
		target_bar_bg:hide()
		target_bar_lock_left:hide()
		target_bar_lock_underline:hide()
		self_action_bar_bg:hide()
	end
	target_bar_meter:hide()
	target_bar_drain_meter:hide()
	target_bar_pulse:hide()
	target_bar_lock_right:hide()
	target_text:hide()
	target_text_shadow:hide()
	target_action_text:hide()
	target_action_text_shadow:hide()
	ui_bg_left.target:hide()
	ui_bg_middle.target:hide()
	ui_bg_right.target:hide()
	local t_icon_set = debuff_icons.target
	local t_settings = settings.sections.target
	local t_timer_set = debuff_timers.target
	if t_icon_set[1]:visible() then
		for k = 1, max_icons.target do
			t_icon_set[k]:hide()
			if t_settings.debuff_timers then
				t_timer_set[k]:hide()
			end
		end
	end

	self_action_bar_meter:hide()
	self_action_text:hide()
	self_action_text_shadow:hide()
	ui_bg_left.self_action:hide()
	ui_bg_middle.self_action:hide()
	ui_bg_right.self_action:hide()

	player_stats_hp_bar_meter:hide()
	player_stats_hp_bar_drain_meter:hide()
	player_stats_hp_bar_bg:hide()
	player_stats_hp_bar_pulse:hide()
	player_stats_hp_marker:hide()
	player_stats_hp_text:hide()
	player_stats_hp_text_shadow:hide()

	player_stats_mp_bar_meter:hide()
	player_stats_mp_bar_drain_meter:hide()
	player_stats_mp_bar_bg:hide()
	player_stats_mp_bar_pulse:hide()
	player_stats_mp_text:hide()
	player_stats_mp_text_shadow:hide()

	player_stats_tp_bar_meter:hide()
	player_stats_tp_bar_drain_meter:hide()
	player_stats_tp_bar_bg:hide()
	player_stats_tp_bar_pulse:hide()
	player_stats_tp_marker:hide()
	player_stats_tp_text:hide()
	player_stats_tp_text_shadow:hide()

	player_stats_pet_bar_meter:hide()
	player_stats_pet_bar_drain_meter:hide()
	player_stats_pet_bar_bg:hide()
	player_stats_pet_bar_pulse:hide()
	player_stats_pet_text:hide()
	player_stats_pet_text_shadow:hide()

	party_actions_pt1_p0_text:hide()
	party_actions_pt1_p1_text:hide()
	party_actions_pt1_p2_text:hide()
	party_actions_pt1_p3_text:hide()
	party_actions_pt1_p4_text:hide()
	party_actions_pt1_p5_text:hide()

	party_actions_pt2_p0_text:hide()
	party_actions_pt2_p1_text:hide()
	party_actions_pt2_p2_text:hide()
	party_actions_pt2_p3_text:hide()
	party_actions_pt2_p4_text:hide()
	party_actions_pt2_p5_text:hide()

	party_actions_pt3_p0_text:hide()
	party_actions_pt3_p1_text:hide()
	party_actions_pt3_p2_text:hide()
	party_actions_pt3_p3_text:hide()
	party_actions_pt3_p4_text:hide()
	party_actions_pt3_p5_text:hide()

	aggro_list_box:hide()

end

--Hide only the Player Stats bars
function hidePlayerStatBars()

	player_stats_hp_bar_meter:hide()
	player_stats_hp_bar_drain_meter:hide()
	player_stats_hp_bar_bg:hide()
	player_stats_hp_bar_pulse:hide()
	player_stats_hp_marker:hide()
	player_stats_hp_text:hide()
	player_stats_hp_text_shadow:hide()

	player_stats_mp_bar_meter:hide()
	player_stats_mp_bar_drain_meter:hide()
	player_stats_mp_bar_bg:hide()
	player_stats_mp_bar_pulse:hide()
	player_stats_mp_text:hide()
	player_stats_mp_text_shadow:hide()

	player_stats_tp_bar_meter:hide()
	player_stats_tp_bar_drain_meter:hide()
	player_stats_tp_bar_bg:hide()
	player_stats_tp_bar_pulse:hide()
	player_stats_tp_marker:hide()
	player_stats_tp_text:hide()
	player_stats_tp_text_shadow:hide()

	player_stats_pet_bar_meter:hide()
	player_stats_pet_bar_drain_meter:hide()
	player_stats_pet_bar_bg:hide()
	player_stats_pet_bar_pulse:hide()
	player_stats_pet_text:hide()
	player_stats_pet_text_shadow:hide()

end

--Show appropriate bars
function showBars(target)

	if job and not (hide_player_stats_bars_when_no_target and not target) then

		if job_specific[job].hp then
			player_stats_hp_bar_meter:show()
			player_stats_hp_bar_drain_meter:show()
			player_stats_hp_bar_bg:show()
			player_stats_hp_bar_pulse:show()
			if show_hp_tp_markers then
				player_stats_hp_marker:show()
			end
			player_stats_hp_text:show()
			player_stats_hp_text_shadow:show()
		end

		if job_specific[job].mp then
			player_stats_mp_bar_meter:show()
			player_stats_mp_bar_drain_meter:show()
			player_stats_mp_bar_bg:show()
			player_stats_mp_bar_pulse:show()
			player_stats_mp_text:show()
			player_stats_mp_text_shadow:show()
		end

		if job_specific[job].tp then
			player_stats_tp_bar_meter:show()
			player_stats_tp_bar_drain_meter:show()
			player_stats_tp_bar_bg:show()
			player_stats_tp_bar_pulse:show()
			if show_hp_tp_markers then
				player_stats_tp_marker:show()
			end
			player_stats_tp_text:show()
			player_stats_tp_text_shadow:show()
		end

		if job_specific[job].pet then
			local pet = get_mob_by_target('pet')
			if not (hide_pet_bar_when_no_pet and not pet) then
				player_stats_pet_bar_meter:show()
				player_stats_pet_bar_drain_meter:show()
				player_stats_pet_bar_bg:show()
				player_stats_pet_bar_pulse:show()
				player_stats_pet_text:show()
				player_stats_pet_text_shadow:show()
			end
		end

	end

	if party_1_actions.show then
		party_actions_pt1_p0_text:show()
		party_actions_pt1_p1_text:show()
		party_actions_pt1_p2_text:show()
		party_actions_pt1_p3_text:show()
		party_actions_pt1_p4_text:show()
		party_actions_pt1_p5_text:show()
	end

	if party_2_actions.show then
		party_actions_pt2_p0_text:show()
		party_actions_pt2_p1_text:show()
		party_actions_pt2_p2_text:show()
		party_actions_pt2_p3_text:show()
		party_actions_pt2_p4_text:show()
		party_actions_pt2_p5_text:show()
	end

	if party_3_actions.show then
		party_actions_pt3_p0_text:show()
		party_actions_pt3_p1_text:show()
		party_actions_pt3_p2_text:show()
		party_actions_pt3_p3_text:show()
		party_actions_pt3_p4_text:show()
		party_actions_pt3_p5_text:show()
	end

end

--Set what job we are currently
function setJob()

	local player = get_player()
	job = string.lower(player.main_job)

end

--Assign and incrememnt a new tracking index number
function assignIndex()

	local assignedIndex = index

	index = (index + 1) % 10000 --Increment and reset to 0 when index reaches 10000

	return assignedIndex

end

--Update monster targeting tables
function updateTargeting(actor_id, target_id, timestamp, icon)

	current_actions[actor_id] = {
		target_id = target_id,
		timestamp = timestamp,
		icon = icon,
	}

	--If the target of an action done by a monster (checked before this function was triggered)
	--is in our alliance, or if the monster is on the open_mobs list, then add the monster to the aggro list table
	if isInPartyOrAlliance(target_id) or aggro_list_open_mobs:contains(get_mob_by_id(actor_id).name) then
		current_aggro_list[actor_id] = {
			target_id = target_id,
			timestamp = timestamp,
			icon = icon,
		}
	end

end

--Add an action to the current_actions table
function addToActionsTable(actor_id, action, action_shdw, status, status_shdw, result, result_shdw, index)

	local entry = current_actions[actor_id] or {}
	entry.action = action
	entry.action_shdw = action_shdw
	entry.status = status
	entry.status_shdw = status_shdw
	entry.result = result
	entry.result_shdw = result_shdw
	entry.index = index
	current_actions[actor_id] = entry

end

--Update the status of an action in the current_actions table when it gets interrupted
function actionInterrupted(actor_id, status, status_shdw, result, result_shdw, index)
	local curr_action = current_actions[actor_id]

	if curr_action then
		curr_action.status, curr_action.status_shdw, curr_action.result, curr_action.result_shdw, curr_action.index = 
			status, status_shdw, result, result_shdw, index
	end

end

--Remove an action from the current_actions table
function removeFromActionsTable(actor_id, index)

	if current_actions[actor_id] and current_actions[actor_id].index == index then
		current_actions[actor_id] = nil
	end

end

--Add an SP to the current_sp_actions table
function addToSPTable(actor_id, sp_name)

	current_sp_actions[actor_id] = {
		sp_name = sp_name,
		timestamp = os.clock() + sp_abils[sp_name],
	}

end

--Remove an SP from the current_sp_actions table
function removeFromSPTable(actor_id)

	if current_sp_actions[actor_id] then
		current_sp_actions[actor_id] = nil
	end

end

--Check for expired SP abilities
function checkSPTimers(clock)

	for id, sp_action in pairs(current_sp_actions) do

		local timestamp = sp_action.timestamp

		if clock > timestamp then
			removeFromSPTable(id)
		end

	end

end

--Clear all tables to keep them clean
function clearTables()

	current_actions = {}
	current_sp_actions = {}
	current_debuffs = {}
	current_levels = {}
	current_aggro_list = {}

end

--Add commas to numbers to make them easier to read
function addCommas(number)

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
				formattedNumber = formattedNumber:sub(1, insertIndex)..","..formattedNumber:sub(insertIndex + 1)
				insertIndex = insertIndex + 4
				length = length + 1
			end
		end
	end

	--Return the number (albeit as a string, we're not doing any math on it at this point)
	return formattedNumber

end

--Is the target a monster?
function isMonster(id)

	local actor = get_mob_by_id(id)

	--Is a monster (not in_party to exclude trusts)
	if actor and actor.spawn_type == 16 and not actor.in_party then
		return true
	--Is not a monster
	else
		return false
	end

end

--Is the target a player?
function isPlayer(id)

	local actor = get_mob_by_id(id)

	--Is a player
	if actor and (actor.spawn_type == 1 or actor.spawn_type == 9 or actor.spawn_type == 13) then
		return true
	--Is not a player
	else
		return false
	end

end

--Is this player in our party or alliance?
function isInPartyOrAlliance(id)

	local actor = get_mob_by_id(id)
	local positions = {
		'p0', 'p1', 'p2', 'p3', 'p4', 'p5',
		'a10', 'a11', 'a12', 'a13', 'a14', 'a15',
		'a20', 'a21', 'a22', 'a23', 'a24', 'a25'
	}

	for _, position in ipairs(positions) do
		local member = get_mob_by_target(position)
		if member and member.id == id or (member and actor and member.pet_index == actor.index) then
			--In our party or alliance
			return true
		end
	end

	--Not in our party or alliance
	return false

end

--Is this player in our party?
function isInParty(id)

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
function isInAlliance(id)

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
function targetColor(player, target)

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

		--Pets/Trusts
		elseif target.charmed then

			--Trusts
			if target.spawn_type == 14 then
				return color.target.npc

			--Pet belongs to us
			elseif target.index == get_mob_by_target('p0').pet_index then
				return color.target.pc_self

			else

				local party_pos = {
					'p1', 'p2', 'p3', 'p4', 'p5',
				}
				local alliance_pos = {
					'a10', 'a11', 'a12', 'a13', 'a14', 'a15',
					'a20', 'a21', 'a22', 'a23', 'a24', 'a25'
				}

				--Pet belongs to someone in our party
				for _, pos in ipairs(party_pos) do
					local ally = get_mob_by_target(pos)
					if ally and ally.pet_index == target.index then
						return color.target.pc_party
					end
				end

				--Pet belongs to someone in our alliance
				for _, pos in ipairs(alliance_pos) do
					local ally = get_mob_by_target(pos)
					if ally and ally.pet_index == target.index then
						return color.target.pc_alliance
					end
				end

				--None of the above, pet belongs to a player outside of our party/alliance
				return color.target.pc_other

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

--Turn the entire string into all uppercase
function uppercase(str)

	local uppercased = string.gsub(str, "%a", function(letter)
		return letter:upper()
	end)

	return uppercased

end

--Truncate action names that are too long
function truncateAction(action)

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
		action = string.sub(action, 1, num-1)..truncate_icon
	end

	return action

end

--Truncate names that are too long
function truncateName(name)

	local num = max_name_length

	--Abbreviate common names (from the mob_abbreviations.lua file)
	if abbreviate_common_mob_names then
		for key, abbreviation in pairs(mob_abbreviations_data) do
			name = name:gsub(key, abbreviation, 1)
		end
	end

	--Check if the string length is greater than max_name_length
	if #name > num then
		--Truncate and add an ellipsis
		name = string.sub(name, 1, num-1)..truncate_icon
	end

	return name
end

--Format RGB values with leading zeros (helps prevent an issue with the shadow text not lining up correctly)
function formatRGB(value)

	return string.format("%03d", value)

end

function saveToAutoFocusTargetFile()

	coroutine.schedule(function()
		auto_focus_targets_file:write(auto_focus_targets_help_msg..'return {\n'..sortedTableString(auto_focus_targets_data, '    ')..'\n}')
	end, 0)

end

--Add a target to the auto_focus_targets_data
function addToAutoFocusTargetList(target)

	--If target is a table, first convert it into a useable string
	if type(target) == 'table' then
		local concatenated_target = table.concat(target, ' ')
		target = capitalize(string.lower(concatenated_target))
	end

	if target == '' then
		target = get_mob_by_target('t')
		if target then
			target = target.name
		else
			add_to_chat(8,('[Bars] '):color(220)..('Please highlight or specify a target to be added (name or id).'):color(28))
			return
		end
	end

	auto_focus_targets_data[target] = true
	saveToAutoFocusTargetFile()
	add_to_chat(8,('[Bars] '):color(220)..('Added to Auto Focus Target list: '):color(36)..(target):color(1))

end

--Remove a target from the auto_focus_targets_data
function removeFromAutoFocusTargetList(target)

	--If target is a table, first convert it into a useable string
	if type(target) == 'table' then
		local concatenated_target = table.concat(target, ' ')
		target = capitalize(string.lower(concatenated_target))
	end

	if target == '' then
		target = get_mob_by_target('t')
		if target then
			target = target.name
		else
			add_to_chat(8,('[Bars] '):color(220)..('Please highlight or specify a target to be removed (name or id).'):color(28))
			return
		end
	end

	if auto_focus_targets_data[target] then
		auto_focus_targets_data[target] = nil
		saveToAutoFocusTargetFile()
		add_to_chat(8,('[Bars] '):color(220)..('Removed from Auto Focus Target list: '):color(36)..(target):color(1))

	else
		add_to_chat(8,('[Bars] '):color(220)..(target):color(1)..(' was not found.'):color(28))
		add_to_chat(8,('[Bars] '):color(220)..('Type '):color(8)..('//bars list'):color(1)..(' to see stored targets.'):color(8))

	end
end

--Are we in Dyna-[D]?
function inDyna()
	local zone = res.zones[get_info().zone].en
	in_dyna = string.match(zone, "%[D%]$") and true or false
end

--What jobs are the target mob?
function dynaJob(mob_name)

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
			if string.find(mob_name, designator) and mob_name ~= "Volte Dark Knight" then --Make sure we don't count the Volte Dark KNIGHT as a "PLD|DRG"
				return job
			end
		end
	end

	--Not in Dyna, or no matches
	return false

end

--Apply Range coloring to Distance number (most of the distance calculations come from DistancePlus)
function colorizeDistance(text, distance, target)

	--Only apply distance coloring if turned on
	if distance and show_target_distance_colors and not (spawn_type == 2 or spawn_type == 14 or spawn_type == 34) then

		local player = get_mob_by_target('me')
		local spawn_type = target and target.spawn_type
		local equipment = get_items().equipment or nil
		local range = equipment and equipment.range_bag and equipment.range and get_items(equipment.range_bag, equipment.range) or nil
		local range_type = range and range.id and res.items[range.id] and res.items[range.id].range_type or nil

		--NPC or object
		if  spawn_type == 2 or spawn_type == 14 or spawn_type == 34 then
			local max_distance = 6
			if distance < max_distance then
				local c = color.range.in_range
				return '\\cs('..c.r..','..c.g..','..c.b..')'..text..'\\cr'
			end

		--Magic
		elseif player and job == 'whm' or job == 'blm' or job == 'rdm' or job == 'pld' or job == 'drk' or job == 'brd' or job == 'smn' or job == 'sch' or job == 'geo' or job == 'run' or job == 'blu' then

			local sub_job = player and player.sub_job and string.lower(player.sub_job)

			local max_distance = 20
			local song_aoe_max = 10 --Song party AOE range is 10 with a Wind instrument. String range is calulated at cast time based on skill and we can't get that reliably.
			local outer_blue_max = 10
			local inner_blue_max = 5
			if target.model_size > 2 then
				max_distance = 20.1
			elseif math.floor(target.model_size * 10) == 44 then
				max_distance = 20.0666
			end
			
			local target_distance = max_distance + target.model_size + player.model_size
			local outer_blue_distance = outer_blue_max + target.model_size + player.model_size
			local inner_blue_distance = inner_blue_max + target.model_size + player.model_size

			--In Range (Song AOE), party members only
			if job == 'brd' and target.in_party and distance < song_aoe_max then
				local c = color.range.song_aoe
				return '\\cs('..c.r..','..c.g..','..c.b..')'..text..'\\cr'

			--In Range (Inner Blue Magic), only apply if monster or charmed player
			elseif (job == 'blu' or sub_job == 'blu') and distance < inner_blue_distance
			and (
				target.spawn_type == 16
				or (
					(target.spawn_type == 1 or target.spawn_type == 9 or target.spawn_type == 13)
					and target.charmed
				)
			) then
				local c = color.range.inner_blue_magic
				return '\\cs('..c.r..','..c.g..','..c.b..')'..text..'\\cr'

			--In Range (Outer Blue Magic), only apply if monster or charmed player, or party member within diffusion range
			elseif (job == 'blu' or sub_job == 'blu')
			and (
				(target.in_party and distance < outer_blue_max)
				or (
					not target.in_party and distance < outer_blue_distance
					and (
						target.spawn_type == 16
						or ((target.spawn_type == 1 or target.spawn_type == 9 or target.spawn_type == 13) and target.charmed)
					)
				)
			) then
				local c = color.range.outer_blue_magic
				return '\\cs('..c.r..','..c.g..','..c.b..')'..text..'\\cr'

			--In Range
			elseif distance < target_distance then
				local c = color.range.in_range
				return '\\cs('..c.r..','..c.g..','..c.b..')'..text..'\\cr'

			--Out of Range
			else
				local c = color.range.out_of_range
				return '\\cs('..c.r..','..c.g..','..c.b..')'..text..'\\cr'
			end

		--Ranged, only apply color if ranged weapon is equipped and target is monster or charmed player
		elseif player and (job == 'cor' or job == 'rng' or job == 'thf' or 'sam' or 'war')
		and range_type
		and (target.spawn_type == 16
			or (
				(target.spawn_type == 1 or target.spawn_type == 9 or target.spawn_type == 13) and target.charmed)
			) then

			local max_distance = 25
			local range_skill = range and range.id and res.items[range.id] and res.items[range.id].skill or nil
			local square_max = player.model_size + target.model_size + (target.model_size > 1.6 and 0.1 or 0)
			local true_max = player.model_size + target.model_size + (target.model_size > 1.6 and 0.1 or 0)
			local true_min = player.model_size + target.model_size + (target.model_size > 1.6 and 0.1 or 0)
			local square_min = player.model_size + target.model_size + (target.model_size > 1.6 and 0.1 or 0)

			--Bow
			if range_type == "Bow" then

				local range_delay = range and range.id and res.items[range.id] and res.items[range.id].delay or nil

				--Shortbow
				if range_delay < 400 then
					square_max = square_max + 11.3199
					true_max = true_max + 6.3199
					true_min = true_min + 2.82
					square_min = square_min + 1.42

				--Longbow
				else
					square_max = square_max + 14.5199
					true_max = true_max + 9.5199
					true_min = true_min + 6.02
					square_min = square_min + 4.62
				end

			--Crossbow
			elseif range_type == "Crossbow" then
				square_max = square_max + 11.7199
				true_max = true_max + 8.3999
				true_min = true_min + 5.0007
				square_min = square_min + 3.6199

			--Gun
			elseif range_type == "Gun" or range_type == "Cannon" then
				square_max = square_max + 6.8199
				true_max = true_max + 4.3189
				true_min = true_min + 3.0209
				square_min = square_min + 2.2219

			--Throwing
			elseif range_skill == 27 then --Throwing
				square_max = square_max + 3.8199
				true_max = true_max + 1.3189
				true_min = true_min + 0.0209
				square_min = square_min - 0.7781
			end

			--In range, no boost
			if distance < max_distance and (distance > square_max or distance < square_min) then
				local c = color.range.in_range
				return '\\cs('..c.r..','..c.g..','..c.b..')'..text..'\\cr'

			--Hits Squarely
			elseif (distance <= square_max and distance > true_max) or (distance < true_min and distance >= square_min) then
				local c = color.range.hits_squarely
				return '\\cs('..c.r..','..c.g..','..c.b..')'..text..'\\cr'

			--Strikes True
			elseif (distance <= true_max and distance >= true_min) then
				local c = color.range.strikes_true
				return '\\cs('..c.r..','..c.g..','..c.b..')'..text..'\\cr'

			--Out of range
			else
				local c = color.range.out_of_range
				return '\\cs('..c.r..','..c.g..','..c.b..')'..text..'\\cr'
			end

		--Ninjutsu, only apply color if target is monster or charmed player
		elseif player and job == 'nin'
		and (target.spawn_type == 16
			or (
				(target.spawn_type == 1 or target.spawn_type == 9 or target.spawn_type == 13)
				and target.charmed
			)
		) then

			local max_distance = 16.1

			if target.model_size > 2 then
				max_distance = 16.2
			end

			local target_distance = max_distance + target.model_size + player.model_size

			--In range
			if distance < target_distance then
				local c = color.range.in_range
				return '\\cs('..c.r..','..c.g..','..c.b..')'..text..'\\cr'

			--Out of Range
			else
				local c = color.range.out_of_range
				return '\\cs('..c.r..','..c.g..','..c.b..')'..text..'\\cr'
			end

		end		
	end

	--Jobs without a distance type, or if disabled
	local c = color.range.out_of_range
	return '\\cs('..c.r..','..c.g..','..c.b..')'..text..'\\cr'

end

--Format the Debuff timers
function formatTimer(num, flip_coloring)
	local colors = settings.colors.debuffs
	local formatted_num = ''
	local c = flip_coloring and colors.critical_low or colors.normal
	if num > 3600 then
		local hr = math.floor(num / 3600)
		formatted_num = hr..'h'
	elseif num > 60 then
		local min = math.floor(num / 60)
		formatted_num = min..'m'
	elseif num > 0 then
		if num <= 10 then
			c = flip_coloring and colors.almost_ready or colors.critical_low
		elseif num <= 30 then
			c = colors.low
		end
		num = tostring(math.floor(num))
		formatted_num = string.format("%2s", num)
	else
		c = colors.critical_low
		formatted_num = '??'
	end
	return '\\cs('..c.r..','..c.g..','..c.b..')'..formatted_num..'\\cr'
end

--Get the proper Icon File to display based on the spell cast
function getIconFile(spell_name, debuff_id)

	local icon_path_base = windower_path..'addons/Bars/data/icons/'
	local roman_numerals = {[" II"] = "ii", [" III"] = "iii", [" IV"] = "iv", [" V"] = "v", [" VI"] = "vi", [" VII"] = "vii"}
	local custom_names = {
		'pyrohelix', 'cryohelix', 'anemohelix', 'geohelix',
		'ionohelix', 'hydrohelix', 'luminohelix', 'noctohelix',
		'fire threnody', 'ice threnody', 'wind threnody', 'earth threnody',
		'ltng. threnody', 'water threnody', 'light threnody', 'dark threnody',
		'comet', 'firaja', 'blizzaja', 'aeroja', 'stoneja', 'thundaja', 'waterja',
		'carnage elegy', 'impact',
	}
	local shot_boosted_names = {
		'boosted dia', 'boosted bio', 'boosted shock', 'boosted rasp',
		'boosted choke', 'boosted frost', 'boosted burn', 'boosted drown',
	}

	spell_name = spell_name:lower()
	local icon_file = debuff_id

	--Check for custom prefix
	for _, custom in ipairs(custom_names) do
		if spell_name:sub(1, #custom) == custom and debuff_id ~= 464 then --NOT Arcane Crest (matches Hydrohelix id number)
			icon_file = string.gsub(custom, " ", "_") --convert spaces to underscores
			break
		end
	end

	--Check for Roman numeral suffix
	for suffix, roman_num in pairs(roman_numerals) do
		if spell_name:sub(-#suffix) == suffix:lower() then
			local roman_num_path = icon_path_base..icon_file.."_"..roman_num..'.png'
			if file_exists(roman_num_path) then
				--Add Roman numeral to the end of the file name
				icon_file = icon_file.."_"..roman_num
			end
			break
		end
	end

	--Check for boosted prefix
	for _, boosted in ipairs(shot_boosted_names) do
		if spell_name:sub(1, #boosted) == boosted then
			--Add "shot" to the end of the file name
			icon_file = icon_file..'_shot'
			break
		end
	end

	--Ensure the file exists
	local final_icon_path = icon_path_base..icon_file..'.png'
	if not file_exists(final_icon_path) then
		icon_file = nil
	end

	return icon_file
end

--Truncate Monster Target names that are too long
function truncateMonsterTarget(name)

	local num = max_monster_target_length

	--Abbreviate common names (from the mob_abbreviations.lua file)
	if abbreviate_common_mob_names then
		for key, abbreviation in pairs(mob_abbreviations_data) do
			name = name:gsub(key, abbreviation, 1)
		end
	end

	--Check if the string length is greater than max_monster_target_length
	if #name > num then
		--Truncate and add an ellipsis
		name = string.sub(name, 1, num-1)..truncate_icon
	end

	return name
end

--Format (color and truncate) the monster target name
function formatTargetingName(player, targeting)

	local formatted_name = 'Unknown'

	if targeting then
		local c = targetColor(player, targeting)
		local c_r = formatRGB(c.r)
		local c_g = formatRGB(c.g)
		local c_b = formatRGB(c.b)
		local name = truncateMonsterTarget(targeting.name)
		formatted_name = '\\cs('..c_r..','..c_g..','..c_b..')'..name..'\\cr'
	end

	return formatted_name

end

--Update the Aggro List
function updateAggroList(player, t)

	--If the Aggro List is turned off, hide it
	if not show_aggro_list and not Screen_Test then
		if aggro_list_box:visible() then
			aggro_list_box:hide()
		end
		return
	end

	local width = 3 + 5 + max_name_length + 2 + max_monster_target_length --ZZZ(3)/hpp(5)/icon(2)
	local num = 0
	local plus_num_more = 0
	local text = ""

	for actor_id, data in pairs(current_aggro_list) do

		local actor = get_mob_by_id(actor_id)
		local cursor_target = show_cursor_target and t and t.id == actor_id

		if actor and actor.valid_target and not aggro_list_ignore:contains(actor.name) and actor.hpp ~= 0 then

			num = num + 1

			if num <= max_monsters_listed then
				local actor_name = truncateName(actor.name)
				actor_name = actor_name and (cursor_target and uppercase(actor_name) or actor_name)
				local target = data.target_id and get_mob_by_id(data.target_id)
				local target_name = target and target.name and truncateMonsterTarget(target.name)
				target_name = target_name and (cursor_target and uppercase(target_name) or target_name)
				local target_icon = os.time() >= data.timestamp and ' ?' or (data.icon and ' '..data.icon or ' ?')
				local hpp_raw =actor.hpp or 0
				local hpp = string.format("%3s", hpp_raw)..'%' or ''
				local asleep = current_debuffs[actor_id] and (current_debuffs[actor_id][2] or current_debuffs[actor_id][19]) and (cursor_target and "ZZZ" or "zzz") or ""

				--Colorize the actor name
				local ca = targetColor(player, actor)
				local ca_r = formatRGB(ca.r)
				local ca_g = formatRGB(ca.g)
				local ca_b = formatRGB(ca.b)

				--Colorize the target name
				local ct = targetColor(player, target)
				local ct_r = formatRGB(ct.r)
				local ct_g = formatRGB(ct.g)
				local ct_b = formatRGB(ct.b)

				local padding = ""
				local padding_spaces = width - (#hpp + math.min(#actor_name, max_name_length) + 2 + #asleep + (target_name and max_monster_target_length or 0))
				while string.len(padding) < padding_spaces do
					if padding == "" then
						padding = padding..' '
					else
						padding = padding..'.'
					end
				end
				local targeted = cursor_target and "●" or " "
				actor_name = "\\cs("..ca_r..","..ca_g..","..ca_b..")"..(actor_name and actor_name or "").."\\cr" --add color start and reset to name
				local pc = cursor_target and text_color or {r = 100, g = 100, b = 100}
				padding = "\\cs("..pc.r..","..pc.g..","..pc.b..")"..padding.."\\cr"
				target_name = "\\cs("..ct_r..","..ct_g..","..ct_b..")"..(target_name and target_name or "").."\\cr" --add color start and reset to name
				text = text..hpp..targeted..actor_name..padding..asleep..(target_name and target_icon..target_name).."\n"
			else
				plus_num_more = plus_num_more + 1
			end

		else
			--Remove monster from the Aggro List when it's no longer a valid target or dies
			--(Prevents monsters from getting stuck on the list in certain circumstances, mostly high lag areas)
			current_aggro_list[actor_id] = nil
		end

	end
	local padding = ""
	local plus_text = max_monsters_listed > 0 and plus_num_more > 0 and "+"..plus_num_more.." more" or ((num == 0 or max_monsters_listed == 0) and "Aggro List" or "")
	local total_text = "Total: "..num
	local padding_spaces = width - #plus_text - #total_text
	while #padding < padding_spaces do
		padding = padding..' '
	end
	local header = text == "" and "" or "Aggro List\n"
	text = header..text..plus_text..padding..total_text
	aggro_list_box:text(text)

	--If in a cutscene or less aggro than we have set to show, hide the entire list
	if aggro_list_box:visible() and (in_cutscene or num < min_monsters_to_show) and not Screen_Test then
		aggro_list_box:hide()
	elseif not aggro_list_box:visible() and num >= min_monsters_to_show and not in_cutscene then
		aggro_list_box:show()
	end

end

--Update the Focus Target bar
function updateFocusTargetBar(player, target, clock)

	if calculating_dimensions then return end --skip all this while we're calculating dimensions off screen

	local ft_settings = settings.sections.focus_target
	local icon_set = debuff_icons.focus_target
	local timer_set = debuff_timers.focus_target

	--Hide the Focus Target bar if there is no Focus Target to display, or the Focus Target is targeted
	if not (focus_target_override or focus_target)
	or (focus_target_override and target and not show_focus_target_when_targeted and target.id == focus_target_override.id) then
		if focus_target_bar_bg:visible() then
			focus_target_bar_meter:hide()
			focus_target_bar_drain_meter:hide()
			focus_target_bar_bg:hide()
			focus_target_bar_pulse:hide()
			focus_target_text:hide()
			focus_target_text_shadow:hide()
			focus_target_action_text:hide()
			focus_target_action_text_shadow:hide()
			ui_bg_left.focus_target:hide()
			ui_bg_middle.focus_target:hide()
			ui_bg_right.focus_target:hide()
			for k = 1, max_icons.focus_target do
				icon_set[k]:hide()
				if ft_settings.debuff_timers then
					timer_set[k]:hide()
				end
			end
		end
		return
	end

	local ft = focus_target_override and focus_target_override or focus_target
	local hpp_raw = ft and ft.hpp or 0
	local sp_active = ft and hpp_raw ~= 0 and current_sp_actions[ft.id]
	local sp_timestamp = sp_active and clock and math.floor(math.max(current_sp_actions[ft.id].timestamp - clock, 0))
	local sp_timer = sp_active and string.format("%d:%02d", math.floor(sp_timestamp / 60), sp_timestamp % 60) or ''
	local sp_name = sp_active and current_sp_actions[ft.id].sp_name
	local ft_name = ft and ft.name or ''
	if sp_active then
		if condense_focus_target_name_and_sp_name then
			ft_name = sp_timer..' '..(sp_timestamp % 2 == 0 and sp_name or ft.name)
		else
			ft_name = ft.name..' '..sp_timer..' '..sp_shorter_names[sp_name]
		end
	end
	ft_name = ft_spaces..ft_name
	local dyna_job_raw = ft and show_dyna_jobs and in_dyna and dynaJob(ft.name) or false
	local dyna_job = ft and dyna_job_raw and ft_spaces..dyna_job_raw or ''
	local index_hex = ft and (show_target_index or show_target_hex) and ft_spaces..'('..(show_target_hex and string.format("%03X", ft.index) or ft.index)..')' or ''
	local dist_raw = ft and math.floor(ft.distance:sqrt()*100)/100
	local dist = ft and show_target_distance and ft_spaces..(string.format("%5.2f", dist_raw)) or ''
	local level = ft and ft_settings.show_monster_level and not (show_dyna_jobs and in_dyna) and isMonster(ft.id) and (current_levels[ft.index] and ft_spaces..'Lv '..current_levels[ft.index] or '') or ''
	local meter = ''
	local spaces = hpp_raw and math.floor((focus_target_bar_width * 10) * (hpp_raw / 100)) or 0
	local cm = ft and (Fade and text_color or targetColor(player, ft)) or color.target.pc_other
	local ct = text_color
	local hpp = string.format("%3s", hpp_raw)..'%'
	local m_targeting = ft_settings.show_monster_target and current_actions[ft.id] and current_actions[ft.id].target_id and get_mob_by_id(current_actions[ft.id].target_id)
	ft_targeting_id = m_targeting and m_targeting.id or ft_targeting_id
	local target_icon = m_targeting
		and os.time() >= current_actions[ft.id].timestamp and ' ?'
		or (current_actions[ft.id] and current_actions[ft.id].icon and ' '..current_actions[ft.id].icon or ' ?')
	local targeting = m_targeting and target_icon..formatTargetingName(player, m_targeting) or (ft_targeting_id and target_icon..formatTargetingName(player, get_mob_by_id(ft_targeting_id)) or '')
	local targeting_shdw = m_targeting and target_icon..truncateMonsterTarget(m_targeting.name) or (ft_targeting_id and target_icon..truncateMonsterTarget(get_mob_by_id(ft_targeting_id).name) or '')
	local text = hpp..colorizeDistance(dist, dist_raw, ft)..'\\cs('..formatRGB(cm.r)..','..formatRGB(cm.g)..','..formatRGB(cm.b)..')'..truncateName(ft_name)..'\\cr'..index_hex..dyna_job..level..(hpp_raw ~= 0 and targeting or '')
	local text_shdw = hpp..'\\cs(000,000,000)'..dist..'\\cr'..'\\cs(000,000,000)'..truncateName(ft_name)..'\\cr'..index_hex..dyna_job..level..(hpp_raw ~= 0 and targeting_shdw or '')
	local status = show_action_status_indicators and ft and current_actions[ft.id] and current_actions[ft.id].status or ''
	local status_shdw = show_action_status_indicators and ft and current_actions[ft.id] and current_actions[ft.id].status_shdw or ''
	local action = Screen_Test and screen_test_focus_target.action or (ft and current_actions[ft.id] and current_actions[ft.id].action or '')
	local action_shdw = Screen_Test and screen_test_focus_target.action or (ft and current_actions[ft.id] and current_actions[ft.id].action_shdw or '')
	local text_action = show_target_action and ' '..status..action or ''
	local text_action_shdw = show_target_action and ' '..status_shdw..action_shdw or ''

	--Fix the pad issue when 0
	if spaces == 0 then
		focus_target_bar_meter:hide()
		focus_target_bar_bg:bg_color(color.bar_bg.dead.r,color.bar_bg.dead.g,color.bar_bg.dead.b)
	else
		focus_target_bar_meter:show()
		--fix for the math flooring this to 0 when its not exactly 0 (13 is because of padding issue though)
		if spaces < 13 and hpp_raw > 0 then
			spaces = 13
		end
		while string.len(meter) < spaces do
			meter = meter..' '
		end
		if not Screen_Test then
			focus_target_bar_bg:bg_color(color.bar_bg.normal.r,color.bar_bg.normal.g,color.bar_bg.normal.b)
		end
	end

	--Update the Focus Target text objects
	focus_target_bar_meter:text('\n\n\n\n\n\n\n'..meter)
	focus_target_bar_meter:bg_color(cm.r,cm.g,cm.b)
	focus_target_bar_drain_meter:bg_color(cm.r,cm.g,cm.b)
	focus_target_text:text(Fade and text:text_strip_format() or text)
	focus_target_text:color(ct.r,ct.g,ct.b)
	focus_target_text_shadow:text(Fade and text:text_strip_format() or text_shdw)
	focus_target_action_text:text(Fade and text_action:text_strip_format() or text_action)
	focus_target_action_text:color(ct.r,ct.g,ct.b)
	focus_target_action_text_shadow:text(Fade and text_action_shdw:text_strip_format() or text_action_shdw)

	--Pulse/Glow Focus Target when SP active
	Pulse_Focus_Target_Bar = pulse_bar_when_target_sp_active and sp_active
	Pulse_Focus_Target_Name = pulse_name_when_target_sp_active and sp_active
	if Pulse_Focus_Target_Name then
		focus_target_text:stroke_color(sp_active_glow.r,sp_active_glow.g,sp_active_glow.b)
		focus_target_text:stroke_width(ft_text_stroke.w < 1 and 1 or ft_text_stroke.w)
	else
		focus_target_text:stroke_color(ft_text_stroke.r,ft_text_stroke.g,ft_text_stroke.b)
		focus_target_text:stroke_width(ft_text_stroke.w)
	end

	--Show current debuffs
	local debuff_list = current_debuffs[ft.id]
	local i = 1
	if Screen_Test then
		for k = 1, max_icons.focus_target do
			local num = screen_test_debuffs.focus_target[k]
			local timer = formatTimer(num)
			local file_path = windower_path..'addons/Bars/data/icons/'..num..'.png'
			if file_exists(file_path) then
				icon_set[k]:path(file_path)
				icon_set[k]:show()
				if ft_settings.debuff_timers then
					timer_set[k]:text(timer)
					timer_set[k]:show()
				end
				i = i + 1
			end
		end
	elseif debuff_list then
		--Sort debuff IDs numerically
		local sorted_keys = {}
		for k in pairs(debuff_list) do
			table.insert(sorted_keys, tonumber(k))
		end
		table.sort(sorted_keys)

		--Show debuffs up to max_icons
		for _, debuff_id in ipairs(sorted_keys) do
			if i > max_icons.focus_target then break end

			local spell_data = debuff_list[debuff_id]
			local custom_spell = custom_spells[spell_data.id]
			local spell = res.spells[spell_data.id]
			local name = custom_spell and custom_spell or (spell and spell.name or "???")
			local time_remaining = spell_data.timer and math.max(0, spell_data.timer - os.clock()) or 0

			--Determine whether to show debuff icon/timer
			local show_debuff = false
			if settings.options.debuffs.blacklist then
				show_debuff = not settings.options.debuffs.list:contains(name)
			else
				show_debuff = settings.options.debuffs.list:contains(name)
			end

			if show_debuff then
				local text = ''
				if ft_settings.debuff_timers then
					local flip_coloring = flip_doom_timer_coloring and debuff_id == 15 and true or false
					text = formatTimer(time_remaining, flip_coloring)
				end
				local icon_file = getIconFile(name, debuff_id)
				if icon_file then
					icon_set[i]:path(windower_path..'addons/Bars/data/icons/'..icon_file..'.png')
					icon_set[i]:show()
					if ft_settings.debuff_timers then
						timer_set[i]:text(Fade and text:text_strip_format() or text)
						timer_set[i]:show()
					end
					i = i + 1
				end
			end
		end

		--Clear Sleep, Petrify, Bind debuffs if the mob has moved
		local moved = false
		--Check for movement greater than 3 yalms (account for target moving when initially slept/petrified/bound)
		if debuff_list.pos and (math.abs(debuff_list.pos.x - ft.x) > 3 or math.abs(debuff_list.pos.y - ft.y) > 3) then
			moved = true
		end
		if moved then
			local watch_effects = {2, 7, 11, 19}
			for _, effect_id in ipairs(watch_effects) do
				debuff_list[effect_id] = nil
			end
		end

	end

	--Hide remaining unused slots
	for k = i, max_icons.focus_target do
		icon_set[k]:hide()
		if ft_settings.debuff_timers then
			timer_set[k]:hide()
		end
	end

	--Show the Focus Target text objects
	focus_target_bar_bg:show()
	focus_target_bar_pulse:show()
	focus_target_text:show()
	focus_target_text_shadow:show()
	focus_target_action_text:show()
	focus_target_action_text_shadow:show()
	if ft_settings.ui_bg then
		ui_bg_left.focus_target:show()
		ui_bg_middle.focus_target:show()
		ui_bg_right.focus_target:show()
	end

	--Update the previous focus target id
	drain_previous_ft_id = ft and ft.id or nil

end

function updateFocusTargetBarAnimations(player, target)

	if not (focus_target_override or focus_target)
	or (focus_target_override and target and not show_focus_target_when_targeted and target.id == focus_target_override.id) then
		return
	end

	--Pulse the Focus Target bar (but not when the bar is fading/faded)
	if Pulse_Focus_Target_Bar and focus_target_bar_bg:visible() and not (Fade or Screen_Test) then
		if pulse_focus_target_direction_up and pulse_focus_target_alpha_num < pulse_brightness then
			pulse_focus_target_alpha_num = pulse_focus_target_alpha_num + pulse_speed
		elseif pulse_focus_target_direction_up and pulse_focus_target_alpha_num >= pulse_brightness then
			pulse_focus_target_alpha_num = pulse_brightness
			pulse_focus_target_direction_up = false
		elseif not pulse_focus_target_direction_up and pulse_focus_target_alpha_num > 10 then
			pulse_focus_target_alpha_num = pulse_focus_target_alpha_num - pulse_speed
		elseif not pulse_focus_target_direction_up and pulse_focus_target_alpha_num <= 10 then
			pulse_focus_target_alpha_num = 10
			pulse_focus_target_direction_up = true
		end
		if Pulse_Focus_Target_Bar then
			focus_target_bar_pulse:bg_alpha(pulse_focus_target_alpha_num)
		end
		if Pulse_Focus_Target_Name then
			focus_target_text:stroke_alpha(pulse_focus_target_alpha_num)
		end
	else
		if focus_target_bar_pulse:visible() then
			focus_target_bar_pulse:hide()
			focus_target_bar_pulse:bg_alpha(0)
		end
		if not Fade then
			focus_target_text:stroke_alpha(ft_text_stroke.a)
		end
	end

	if drain_target_bars then

		local ft = focus_target_override and focus_target_override or focus_target
		local hpp_raw = ft and ft.hpp or 0
		local hpp_diff = drain_ft_hpp - hpp_raw
		local current_decay = math.min(hpp_diff * 0.1, drain_decay * 3)
		drain_ft_hpp = ft and drain_previous_ft_id == ft.id and hpp_raw < drain_ft_hpp and drain_ft_hpp - current_decay or hpp_raw
		local drain_spaces = drain_ft_hpp and math.floor((focus_target_bar_width * 10) * (drain_ft_hpp / 100)) or 0
		local drain_meter = ''

		--Fix the pad issue
		if drain_spaces <= 6 then
			focus_target_bar_drain_meter:hide()
		elseif not Fade then
			--fix for the math flooring this to 0 when its not exactly 0 (13 is because of padding issue though)
			if drain_spaces < 13 and drain_ft_hpp > 0 then
				drain_spaces = 13
			end
			while string.len(drain_meter) < drain_spaces do
				drain_meter = drain_meter..' '
			end
			focus_target_bar_drain_meter:text('\n\n\n\n\n\n\n'..drain_meter)
			focus_target_bar_drain_meter:show()
		end

	end

end

--Update the Sub Target bar
function updateSubTargetBar(player, st, target, clock)
	
	if calculating_dimensions then return end --skip all this while we're calculating dimensions off screen

	local st_settings = settings.sections.sub_target
	local icon_set = debuff_icons.sub_target
	local timer_set = debuff_timers.sub_target

	--Hide the Sub Target bar if there is no Sub Target to display, the Sub Target is targeted, or the Sub Target is ourselves
	if not st
	or (show_sub_target_when_targeted == false and target and st.id == target.id)
	or (show_self_when_sub_targeted == false and st.id == player.id) then
		if sub_target_bar_bg:visible() then
			sub_target_bar_meter:hide()
			sub_target_bar_drain_meter:hide()
			sub_target_bar_bg:hide()
			sub_target_bar_pulse:hide()
			sub_target_text:hide()
			sub_target_text_shadow:hide()
			sub_target_action_text:hide()
			sub_target_action_text_shadow:hide()
			ui_bg_left.sub_target:hide()
			ui_bg_middle.sub_target:hide()
			ui_bg_right.sub_target:hide()
			for k = 1, max_icons.sub_target do
				icon_set[k]:hide()
				if st_settings.debuff_timers then
					timer_set[k]:hide()
				end
			end
		end
		return
	end

	local hpp_raw = st and st.hpp or 0
	local sp_active = st and hpp_raw ~= 0 and current_sp_actions[st.id]
	local sp_timestamp = sp_active and clock and math.floor(math.max(current_sp_actions[st.id].timestamp - clock, 0))
	local sp_timer = sp_active and string.format("%d:%02d", math.floor(sp_timestamp / 60), sp_timestamp % 60) or ''
	local sp_name = sp_active and current_sp_actions[st.id].sp_name
	local st_name = st and st.name or ''
	if sp_active then
		if condense_sub_target_name_and_sp_name then
			st_name = sp_timer..' '..(sp_timestamp % 2 == 0 and sp_name or st.name)
		else
			st_name = st.name..' '..sp_timer..' '..sp_shorter_names[sp_name]
		end
	end
	st_name = st_spaces..st_name
	local dyna_job_raw = st and show_dyna_jobs and in_dyna and dynaJob(st.name) or false
	local dyna_job = st and dyna_job_raw and st_spaces..dyna_job_raw or ''
	local index_hex = st and (show_target_index or show_target_hex) and st_spaces..'('..(show_target_hex and string.format("%03X", st.index) or st.index)..')' or ''
	local dist_raw = st and math.floor(st.distance:sqrt()*100)/100
	local dist = st and show_target_distance and st_spaces..(string.format("%5.2f", dist_raw)) or ''
	local level = st and st_settings.show_monster_level and not (show_dyna_jobs and in_dyna) and isMonster(st.id) and (current_levels[st.index] and st_spaces..'Lv '..current_levels[st.index] or '') or ''
	local meter = ''
	local spaces = hpp_raw and math.floor((sub_target_bar_width * 10) * (hpp_raw / 100)) or 0
	local cm = st and (Fade and text_color or targetColor(player, st)) or color.target.pc_other
	local ct = text_color
	local hpp = string.format("%3s", hpp_raw)..'%'
	local m_targeting = st_settings.show_monster_target and current_actions[st.id] and current_actions[st.id].target_id and get_mob_by_id(current_actions[st.id].target_id)
	st_targeting_id = m_targeting and m_targeting.id or st_targeting_id
	local target_icon = m_targeting
		and os.time() >= current_actions[st.id].timestamp and ' ?'
		or (current_actions[st.id] and current_actions[st.id].icon and ' '..current_actions[st.id].icon or ' ?')
	local targeting = m_targeting and target_icon..formatTargetingName(player, m_targeting) or (st_targeting_id and target_icon..formatTargetingName(player, get_mob_by_id(st_targeting_id)) or '')
	local targeting_shdw = m_targeting and target_icon..truncateMonsterTarget(m_targeting.name) or (st_targeting_id and target_icon..truncateMonsterTarget(get_mob_by_id(st_targeting_id).name) or '')
	local text = hpp..colorizeDistance(dist, dist_raw, st)..'\\cs('..formatRGB(cm.r)..','..formatRGB(cm.g)..','..formatRGB(cm.b)..')'..truncateName(st_name)..'\\cr'..index_hex..dyna_job..level..(hpp_raw ~= 0 and targeting or '')
	local text_shdw = hpp..'\\cs(000,000,000)'..dist..'\\cr'..'\\cs(000,000,000)'..truncateName(st_name)..'\\cr'..index_hex..dyna_job..level..(hpp_raw ~= 0 and targeting_shdw or '')
	local status = show_action_status_indicators and st and current_actions[st.id] and current_actions[st.id].status or ''
	local status_shdw = show_action_status_indicators and st and current_actions[st.id] and current_actions[st.id].status_shdw or ''
	local action = Screen_Test and screen_test_sub_target.action or (st and current_actions[st.id] and current_actions[st.id].action or '')
	local action_shdw = Screen_Test and screen_test_sub_target.action or (st and current_actions[st.id] and current_actions[st.id].action_shdw or '')
	local text_action = show_target_action and ' '..status..action or ''
	local text_action_shdw = show_target_action and ' '..status_shdw..action_shdw or ''

	--Fix the pad issue when 0
	if spaces == 0 then
		sub_target_bar_meter:hide()
		sub_target_bar_bg:bg_color(color.bar_bg.dead.r,color.bar_bg.dead.g,color.bar_bg.dead.b)
	else
		sub_target_bar_meter:show()
		--fix for the math flooring this to 0 when its not exactly 0 (13 is because of padding issue though)
		if spaces < 13 and hpp_raw > 0 then
			spaces = 13
		end
		while string.len(meter) < spaces do
			meter = meter..' '
		end
		if not Screen_Test then
			sub_target_bar_bg:bg_color(color.bar_bg.normal.r,color.bar_bg.normal.g,color.bar_bg.normal.b)
		end
	end

	--Update the Sub Target text objects
	sub_target_bar_meter:text('\n\n\n\n\n\n\n'..meter)
	sub_target_bar_meter:bg_color(cm.r,cm.g,cm.b)
	sub_target_bar_drain_meter:bg_color(cm.r,cm.g,cm.b)
	sub_target_text:text(Fade and text:text_strip_format() or text)
	sub_target_text:color(ct.r,ct.g,ct.b)
	sub_target_text_shadow:text(Fade and text:text_strip_format() or text_shdw)
	sub_target_action_text:text(Fade and text_action:text_strip_format() or text_action)
	sub_target_action_text:color(ct.r,ct.g,ct.b)
	sub_target_action_text_shadow:text(Fade and text_action_shdw:text_strip_format() or text_action_shdw)

	--Pulse/Glow Sub Target when SP active
	Pulse_Sub_Target_Bar = pulse_bar_when_target_sp_active and sp_active
	Pulse_Sub_Target_Name = pulse_name_when_target_sp_active and sp_active
	if Pulse_Sub_Target_Name then
		sub_target_text:stroke_color(sp_active_glow.r,sp_active_glow.g,sp_active_glow.b)
		sub_target_text:stroke_width(st_text_stroke.w < 1 and 1 or st_text_stroke.w)
	else
		sub_target_text:stroke_color(st_text_stroke.r,st_text_stroke.g,st_text_stroke.b)
		sub_target_text:stroke_width(st_text_stroke.w)
	end

	--Show current debuffs
	local debuff_list = current_debuffs[st.id]
	local i = 1
	if Screen_Test then
		for k = 1, max_icons.sub_target do
			local num = screen_test_debuffs.sub_target[k]
			local timer = formatTimer(num)
			local file_path = windower_path..'addons/Bars/data/icons/'..num..'.png'
			if file_exists(file_path) then
				icon_set[k]:path(file_path)
				icon_set[k]:show()
				if st_settings.debuff_timers then
					timer_set[k]:text(timer)
					timer_set[k]:show()
				end
				i = i + 1
			end
		end
	elseif debuff_list then
		--Sort debuff IDs numerically
		local sorted_keys = {}
		for k in pairs(debuff_list) do
			table.insert(sorted_keys, tonumber(k))
		end
		table.sort(sorted_keys)

		--Show debuffs up to max_icons
		for _, debuff_id in ipairs(sorted_keys) do
			if i > max_icons.sub_target then break end

			local spell_data = debuff_list[debuff_id]
			local custom_spell = custom_spells[spell_data.id]
			local spell = res.spells[spell_data.id]
			local name = custom_spell and custom_spell or (spell and spell.name or "???")
			local time_remaining = spell_data.timer and math.max(0, spell_data.timer - os.clock()) or 0

			--Determine whether to show debuff icon/timer
			local show_debuff = false
			if settings.options.debuffs.blacklist then
				show_debuff = not settings.options.debuffs.list:contains(name)
			else
				show_debuff = settings.options.debuffs.list:contains(name)
			end

			if show_debuff then
				local text = ''
				if st_settings.debuff_timers then
					local flip_coloring = flip_doom_timer_coloring and debuff_id == 15 and true or false
					text = formatTimer(time_remaining, flip_coloring)
				end
				local icon_file = getIconFile(name, debuff_id)
				if icon_file then
					icon_set[i]:path(windower_path..'addons/Bars/data/icons/'..icon_file..'.png')
					icon_set[i]:show()
					if st_settings.debuff_timers then
						timer_set[i]:text(text)
						timer_set[i]:show()
					end
					i = i + 1
				end
			end
		end

		--Clear Sleep, Petrify, Bind debuffs if the mob has moved
		local moved = false
		--Check for movement greater than 3 yalms (account for target moving when initially slept/petrified/bound)
		if debuff_list.pos and (math.abs(debuff_list.pos.x - st.x) > 3 or math.abs(debuff_list.pos.y - st.y) > 3) then
			moved = true
		end
		if moved then
			local watch_effects = {2, 7, 11, 19}
			for _, effect_id in ipairs(watch_effects) do
				debuff_list[effect_id] = nil
			end
		end

	end

	--Hide remaining unused slots
	for k = i, max_icons.sub_target do
		icon_set[k]:hide()
		if st_settings.debuff_timers then
			timer_set[k]:hide()
		end
	end

	--Show the Sub Target text objects
	sub_target_bar_bg:show()
	sub_target_bar_pulse:show()
	sub_target_text:show()
	sub_target_text_shadow:show()
	sub_target_action_text:show()
	sub_target_action_text_shadow:show()
	if st_settings.ui_bg then
		ui_bg_left.sub_target:show()
		ui_bg_middle.sub_target:show()
		ui_bg_right.sub_target:show()
	end

	--Update the previous sub target id
	drain_previous_st_id = st and st.id or nil

end

function updateSubTargetBarAnimations(player, st)

	--Pulse the Sub Target bar (but not when the bar is fading/faded)
	if (Pulse_Sub_Target_Bar or Pulse_Sub_Target_Name) and sub_target_bar_bg:visible() and not (Fade or Screen_Test) then
		if pulse_sub_target_direction_up and pulse_sub_target_alpha_num < pulse_brightness then
			pulse_sub_target_alpha_num = pulse_sub_target_alpha_num + pulse_speed
		elseif pulse_sub_target_direction_up and pulse_sub_target_alpha_num >= pulse_brightness then
			pulse_sub_target_alpha_num = pulse_brightness
			pulse_sub_target_direction_up = false
		elseif not pulse_sub_target_direction_up and pulse_sub_target_alpha_num > 10 then
			pulse_sub_target_alpha_num = pulse_sub_target_alpha_num - pulse_speed
		elseif not pulse_sub_target_direction_up and pulse_sub_target_alpha_num <= 10 then
			pulse_sub_target_alpha_num = 10
			pulse_sub_target_direction_up = true
		end
		if Pulse_Sub_Target_Bar then
			sub_target_bar_pulse:bg_alpha(pulse_sub_target_alpha_num)
		end
		if Pulse_Sub_Target_Name then
			sub_target_text:stroke_alpha(pulse_sub_target_alpha_num)
		end
	else
		if sub_target_bar_pulse:visible() then
			sub_target_bar_pulse:hide()
			sub_target_bar_pulse:bg_alpha(0)
		end
		if not Fade then
			sub_target_text:stroke_alpha(st_text_stroke.a)
		end
	end

	if drain_target_bars then

		local hpp_raw = st and st.hpp or 0
		local hpp_diff = drain_st_hpp - hpp_raw
		local current_decay = math.min(hpp_diff * 0.1, drain_decay * 3)
		drain_st_hpp = st and drain_previous_st_id == st.id and hpp_raw < drain_st_hpp and drain_st_hpp - current_decay or hpp_raw
		local drain_spaces = drain_st_hpp and math.floor((sub_target_bar_width * 10) * (drain_st_hpp / 100)) or 0
		local drain_meter = ''

		--Fix the pad issue when 0
		if drain_spaces <= 0 then
			sub_target_bar_drain_meter:hide()
		elseif drain_target_bars then
			--fix for the math flooring this to 0 when its not exactly 0 (13 is because of padding issue though)
			if drain_spaces < 13 and drain_st_hpp > 0 then
				drain_spaces = 13
			end
			while string.len(drain_meter) < drain_spaces do
				drain_meter = drain_meter..' '
			end
			sub_target_bar_drain_meter:text('\n\n\n\n\n\n\n'..drain_meter)
			sub_target_bar_drain_meter:show()
		end

	end

end

--Update the Target bar
function updateTargetBar(player, t, clock)

	if calculating_dimensions then return end --skip all this while we're calculating dimensions off screen

	local t_settings = settings.sections.target
	local icon_set = debuff_icons.target
	local timer_set = debuff_timers.target

	--Hide the Target bar if there is no Target to display, or the Target is ourselves
	if not t or (not show_self_when_targeted and t.id == player.id) then
		if target_bar_bg:visible() then
			target_bar_meter:hide()
			target_bar_drain_meter:hide()
			target_bar_bg:hide()
			target_bar_pulse:hide()
			target_text:hide()
			target_text_shadow:hide()
			target_action_text:hide()
			target_action_text_shadow:hide()
			ui_bg_left.target:hide()
			ui_bg_middle.target:hide()
			ui_bg_right.target:hide()
			for k = 1, max_icons.target do
				icon_set[k]:hide()
				if t_settings.debuff_timers then
					timer_set[k]:hide()
				end
			end
		end
		return
	end

	local hpp_raw = t and t.hpp or 0
	local sp_active = t and hpp_raw > 0 and current_sp_actions[t.id]
	local sp_timestamp = sp_active and clock and math.floor(math.max(current_sp_actions[t.id].timestamp - clock, 0))
	local sp_timer = sp_active and string.format("%d:%02d", math.floor(sp_timestamp / 60), sp_timestamp % 60) or ''
	local sp_name = sp_active and current_sp_actions[t.id].sp_name
	local t_name = t and t.name or ''
	if sp_active then
		if condense_target_name_and_sp_name then
			t_name = sp_timer..' '..(sp_timestamp % 2 == 0 and sp_name or t.name)
		else
			t_name = t.name..' '..sp_timer..' '..sp_shorter_names[sp_name]
		end
	end
	t_name = t_spaces..t_name
	local dyna_job_raw = t and show_dyna_jobs and in_dyna and dynaJob(t.name) or false
	local dyna_job = t and dyna_job_raw and t_spaces..dyna_job_raw or ''
	local index_hex = t and (show_target_index or show_target_hex) and t_spaces..'('..(show_target_hex and string.format("%03X", t.index) or t.index)..')' or ''
	local dist_raw = t and math.floor(t.distance:sqrt()*100)/100
	local dist = t and show_target_distance and t_spaces..(string.format("%5.2f", dist_raw)) or ''
	local level = t and t_settings.show_monster_level and not (show_dyna_jobs and in_dyna) and isMonster(t.id) and (current_levels[t.index] and t_spaces..'Lv '..current_levels[t.index] or '') or ''
	local meter = ''
	local spaces = hpp_raw and math.floor((target_bar_width * 10) * (hpp_raw / 100)) or 0
	local cm = t and (Fade and text_color or targetColor(player, t)) or color.t.pc_other
	local ct = text_color
	local hpp = string.format("%3s", hpp_raw)..'%'
	local m_targeting = t_settings.show_monster_target and current_actions[t.id] and current_actions[t.id].target_id and get_mob_by_id(current_actions[t.id].target_id)
	t_targeting_id = m_targeting and m_targeting.id or t_targeting_id
	local target_icon = m_targeting
		and os.time() >= current_actions[t.id].timestamp and ' ?'
		or (current_actions[t.id] and current_actions[t.id].icon and ' '..current_actions[t.id].icon or ' ?')
	local targeting = m_targeting and target_icon..formatTargetingName(player, m_targeting) or (t_targeting_id and target_icon..formatTargetingName(player, get_mob_by_id(t_targeting_id)) or '')
	local targeting_shdw = m_targeting and target_icon..truncateMonsterTarget(m_targeting.name) or (t_targeting_id and target_icon..truncateMonsterTarget(get_mob_by_id(t_targeting_id).name) or '')
	local text = hpp..colorizeDistance(dist, dist_raw, t)..'\\cs('..formatRGB(cm.r)..','..formatRGB(cm.g)..','..formatRGB(cm.b)..')'..t_name..'\\cr'..index_hex..dyna_job..level..(hpp_raw ~= 0 and targeting or '')
	local text_shdw = hpp..'\\cs(000,000,000)'..dist..'\\cr'..'\\cs(000,000,000)'..t_name..'\\cr'..index_hex..dyna_job..level..(hpp_raw ~= 0 and targeting_shdw or '')
	local status = show_action_status_indicators and t and current_actions[t.id] and current_actions[t.id].status or ''
	local status_shdw = show_action_status_indicators and t and current_actions[t.id] and current_actions[t.id].status_shdw or ''
	local action = Screen_Test and screen_test_target.action or (t and current_actions[t.id] and current_actions[t.id].action or '')
	local action_shdw = Screen_Test and screen_test_target.action or (t and current_actions[t.id] and current_actions[t.id].action_shdw or '')
	local action_result = t and show_target_action_result and current_actions[t.id] and current_actions[t.id].result or ''
	local action_result_shdw = t and show_target_action_result and current_actions[t.id] and current_actions[t.id].result_shdw or ''
	local text_action = show_target_action and ' '..status..action..action_result or ''
	local text_action_shdw = show_target_action and ' '..status_shdw..action_shdw..action_result_shdw or ''

	--Fix the pad issue when 0
	if spaces == 0 then
		target_bar_meter:hide()
		target_text:stroke_color(color.bar_bg.dead.r,color.bar_bg.dead.g,color.bar_bg.dead.b)
		target_bar_bg:bg_color(color.bar_bg.dead.r,color.bar_bg.dead.g,color.bar_bg.dead.b)
		target_bar_lock_left:color(color.bar_bg.dead.r,color.bar_bg.dead.g,color.bar_bg.dead.b)
		target_bar_lock_right:color(color.bar_bg.dead.r,color.bar_bg.dead.g,color.bar_bg.dead.b)
		target_bar_lock_underline:bg_color(color.bar_bg.dead.r,color.bar_bg.dead.g,color.bar_bg.dead.b)
	else
		target_bar_meter:show()
		--fix for the math flooring this to 0 when its not exactly 0 (13 is because of padding issue though)
		if spaces < 13 and hpp_raw > 0 then
			spaces = 13
		end
		while string.len(meter) < spaces do
			meter = meter..' '
		end
		if not Screen_Test then
			target_text:stroke_color(t_text_stroke.r,t_text_stroke.g,t_text_stroke.b)
			target_bar_bg:bg_color(color.bar_bg.normal.r,color.bar_bg.normal.g,color.bar_bg.normal.b)
			target_bar_lock_left:color(cm.r,cm.g,cm.b)
			target_bar_lock_right:color(cm.r,cm.g,cm.b)
			target_bar_lock_underline:bg_color(cm.r,cm.g,cm.b)
		end
	end

	--Show Target Lock
	if show_target_lock and player and player.target_locked and not target_bar_lock_left:visible() then
		target_bar_lock_left:show()
		target_bar_lock_right:show()
		target_bar_lock_underline:show()
	elseif player and not player.target_locked and target_bar_lock_left:visible() then
		target_bar_lock_left:hide()
		target_bar_lock_right:hide()
		target_bar_lock_underline:hide()
	end

	--Update the Target text objects
	target_bar_meter:text('\n\n\n\n\n\n\n'..meter)
	target_bar_meter:bg_color(cm.r,cm.g,cm.b)
	target_bar_drain_meter:bg_color(cm.r,cm.g,cm.b)
	target_text:text(Fade and text:text_strip_format() or text)
	target_text:color(ct.r,ct.g,ct.b)
	target_text_shadow:text(Fade and text:text_strip_format() or text_shdw)
	target_action_text:text(Fade and text_action:text_strip_format() or text_action)
	target_action_text:color(ct.r,ct.g,ct.b)
	target_action_text_shadow:text(Fade and text_action_shdw:text_strip_format() or text_action_shdw)

	--Pulse/Glow Target when SP active
	Pulse_Target_Bar = pulse_bar_when_target_sp_active and sp_active
	Pulse_Target_Name = pulse_name_when_target_sp_active and sp_active
	if Pulse_Target_Name then
		target_text:stroke_color(sp_active_glow.r,sp_active_glow.g,sp_active_glow.b)
		target_text:stroke_width(t_text_stroke.w < 1 and 1 or t_text_stroke.w)
	else
		target_text:stroke_color(t_text_stroke.r,t_text_stroke.g,t_text_stroke.b)
		target_text:stroke_width(t_text_stroke.w)
	end

	--Show current debuffs
	local debuff_list = current_debuffs[t.id]
	local i = 1
	if Screen_Test then
		for k = 1, max_icons.target do
			local num = screen_test_debuffs.target[k]
			local timer = formatTimer(num)
			local file_path = windower_path..'addons/Bars/data/icons/'..num..'.png'
			if file_exists(file_path) then
				icon_set[k]:path(file_path)
				icon_set[k]:show()
				if t_settings.debuff_timers then
					timer_set[k]:text(timer)
					timer_set[k]:show()
				end
				i = i + 1
			end
		end
	elseif debuff_list then
		--Sort debuff IDs numerically
		local sorted_keys = {}
		for k in pairs(debuff_list) do
			table.insert(sorted_keys, tonumber(k))
		end
		table.sort(sorted_keys)

		--Show debuffs up to max_icons
		for _, debuff_id in ipairs(sorted_keys) do
			if i > max_icons.target then break end

			local spell_data = debuff_list[debuff_id]
			local custom_spell = custom_spells[spell_data.id]
			local spell = res.spells[spell_data.id]
			local name = custom_spell and custom_spell or (spell and spell.name or "???")
			local time_remaining = spell_data.timer and math.max(0, spell_data.timer - os.clock()) or 0

			--Determine whether to show debuff icon/timer
			local show_debuff = false
			if settings.options.debuffs.blacklist then
				show_debuff = not settings.options.debuffs.list:contains(name)
			else
				show_debuff = settings.options.debuffs.list:contains(name)
			end

			if show_debuff then
				local text = ''
				if t_settings.debuff_timers then
					local flip_coloring = flip_doom_timer_coloring and debuff_id == 15 and true or false
					text = formatTimer(time_remaining, flip_coloring)
				end
				local icon_file = getIconFile(name, debuff_id)
				if icon_file then
					icon_set[i]:path(windower_path..'addons/Bars/data/icons/'..icon_file..'.png')
					icon_set[i]:show()
					if t_settings.debuff_timers then
						timer_set[i]:text(text)
						timer_set[i]:show()
					end
					i = i + 1
				end
			end
		end

		--Clear Sleep, Petrify, Bind debuffs if the mob has moved
		local moved = false
		--Check for movement greater than 3 yalms (account for target moving when initially slept/petrified/bound)
		if debuff_list.pos and (math.abs(debuff_list.pos.x - t.x) > 3 or math.abs(debuff_list.pos.y - t.y) > 3) then
			moved = true
		end
		if moved then
			local watch_effects = {2, 7, 11, 19}
			for _, effect_id in ipairs(watch_effects) do
				debuff_list[effect_id] = nil
			end
		end

	end

	--Hide remaining unused slots
	for k = i, max_icons.target do
		icon_set[k]:hide()
		if t_settings.debuff_timers then
			timer_set[k]:hide()
		end
	end

	--Show the Target text objects
	target_bar_bg:show()
	target_bar_pulse:show()
	target_text:show()
	target_action_text:show()
	target_text_shadow:show()
	target_action_text_shadow:show()
	if t_settings.ui_bg then
		ui_bg_left.target:show()
		ui_bg_middle.target:show()
		ui_bg_right.target:show()
	end
		
	--Update the previous target id
	drain_previous_t_id = t and t.id or nil

end

function updateTargetBarAnimations(player, t)

	--Target Bar Pulse animation
	if (Pulse_Target_Bar or Pulse_Target_Name) and target_bar_bg:visible() and not (Fade or Screen_Test) then
		if pulse_target_direction_up and pulse_target_alpha_num < pulse_brightness then
			pulse_target_alpha_num = pulse_target_alpha_num + pulse_speed
		elseif pulse_target_direction_up and pulse_target_alpha_num >= pulse_brightness then
			pulse_target_alpha_num = pulse_brightness
			pulse_target_direction_up = false
		elseif not pulse_target_direction_up and pulse_target_alpha_num > 10 then
			pulse_target_alpha_num = pulse_target_alpha_num - pulse_speed
		elseif not pulse_target_direction_up and pulse_target_alpha_num <= 10 then
			pulse_target_alpha_num = 10
			pulse_target_direction_up = true
		end
		if Pulse_Target_Bar then
			target_bar_pulse:bg_alpha(pulse_target_alpha_num)
		end
		if Pulse_Target_Name then
			target_text:stroke_alpha(pulse_target_alpha_num)
		end
	else
		if target_bar_pulse:visible() then
			target_bar_pulse:hide()
			target_bar_pulse:bg_alpha(0)
		end
		if not Fade then
			target_text:stroke_alpha(t_text_stroke.a)
		end
	end

	--Target Bar Drain animation
	if drain_target_bars then

		local hpp_raw = t and t.hpp or 0
		local hpp_diff = drain_t_hpp - hpp_raw
		local current_decay = math.min(hpp_diff * 0.1, drain_decay * 3)
		drain_t_hpp = t and drain_previous_t_id == t.id and hpp_raw < drain_t_hpp and drain_t_hpp - current_decay or hpp_raw
		local drain_spaces = drain_t_hpp and math.floor((target_bar_width * 10) * (drain_t_hpp / 100)) or 0
		local drain_meter = ''

		--Fix the pad issue
		if drain_spaces <= 6 then
			target_bar_drain_meter:hide()
		elseif not (not show_self_when_targeted and t.id == player.id) and not Fade then
			--fix for the math flooring this to 0 when its not exactly 0 (13 is because of padding issue though)
			if drain_spaces < 13 and drain_t_hpp > 0 then
				drain_spaces = 13
			end
			while string.len(drain_meter) < drain_spaces do
				drain_meter = drain_meter..' '
			end
			target_bar_drain_meter:text('\n\n\n\n\n\n\n'..drain_meter)
			target_bar_drain_meter:show()
		end

	end

end

--Update the Self Action text
function updateSelfAction(player)

	local self_status = show_action_status_indicators and current_actions[player.id] and current_actions[player.id].status or ''

	--Hide the Self Action bar disabled, we are in a cutscene, or no actions
	if not show_self_action_result
	or self_status == '' then
		if self_action_bar_bg:visible() and not calculating_dimensions then
			self_action_bar_meter:hide()
			self_action_bar_bg:hide()
			self_action_text:hide()
			self_action_text_shadow:hide()
			ui_bg_left.self_action:hide()
			ui_bg_middle.self_action:hide()
			ui_bg_right.self_action:hide()
		end
		return
	end

	local self_status_shdw = show_action_status_indicators and current_actions[player.id] and current_actions[player.id].status_shdw or ''
	local self_action = current_actions[player.id] and current_actions[player.id].action or ''
	local self_action_shdw = current_actions[player.id] and current_actions[player.id].action_shdw or ''
	local self_action_result = show_self_action_result and current_actions[player.id] and current_actions[player.id].result or ''
	local self_action_result_shdw = show_self_action_result and current_actions[player.id] and current_actions[player.id].result_shdw or ''
	local text_self_action = ' '..self_status..self_action..self_action_result
	local text_self_action_shdw = ' '..self_status_shdw..self_action_shdw..self_action_result_shdw

	--Update Self Action text objects
	self_action_text:text(Fade and text_self_action:text_strip_format() or text_self_action)
	self_action_text_shadow:text(Fade and text_self_action_shdw:text_strip_format() or text_self_action_shdw)

	--Show Self Action text objects
	if show_self_action_bar and not self_action_bar_bg:visible() then
		self_action_bar_bg:show()
	end
	if not self_action_text:visible() then
		self_action_text:show()
		self_action_text_shadow:show()
	end
	if settings.sections.self_action.ui_bg and not ui_bg_left.self_action:visible() then
		ui_bg_left.self_action:show()
		ui_bg_middle.self_action:show()
		ui_bg_right.self_action:show()
	end

end

--Complete the Self meter to full
function completeSelfMeter()

	if not show_self_action or not show_self_action_bar then return end

	local self_meter = ''

	while string.len(self_meter) < self_action_bar_width * 10 do
		self_meter = self_meter..' '
	end
	self_action_bar_meter:text('\n\n\n\n\n\n\n'..self_meter)
	self_action_bar_meter:show()

end

--Update the Self bar
function updateSelfBar(player, cast_time, index)

	if not show_self_action or not show_self_action_bar then return end

	cast_time = cast_time ~= 0 and cast_time or 1
	local self_meter = ''
	local spaces = 0
	local multiplier = 0.02 --Bar length gets updated 50 times per second
	local divisor = cast_time / multiplier
	local increment = (self_action_bar_width * 10) / divisor

	--Loop to update the bar length over time
	for i = 1, divisor do

		local curr_index = current_actions[player.id]

		--Cancel if a spell has finished early
		local status = current_actions[player.id] and current_actions[player.id].status
		if (status and (status:find(completed_icon, 1, true) or status:find(cancelled_icon, 1, true)) and not Screen_Test)
			or curr_index and index ~= curr_index.index then
			break
		end

		--Make sure the meter hits exactly 100% when finished
		if i == divisor then
			spaces = self_action_bar_width * 10
		end

		--Update the bar length
		while string.len(self_meter) < spaces do
			self_meter = self_meter..' '
		end
		self_action_bar_meter:text('\n\n\n\n\n\n\n'..self_meter)

		--Fix the pad issue when under 13
		if spaces >= 13 and current_actions[player.id] and not self_action_bar_meter:visible() then
			self_action_bar_meter:show()
		elseif spaces < 13 or not current_actions[player.id] and self_action_bar_meter:visible() then
			self_action_bar_meter:hide()
		end

		--Incremement spaces for the next go round
		if i ~= divisor then
			spaces = spaces + increment
		end

		--Pause before running the loop again
		coroutine.sleep(multiplier)

	end

end

--Update the HP bar
function updateHPBar(player)

	local hp = player and player.vitals.hp or 0
	local max_hp = player and player.vitals.max_hp or 0
	local hpp = player and player.vitals.hpp or 0
	local hp_meter = ''
	local spaces = math.floor((player_stats_bar_width * 10) * (hpp / 100))
	local ct = text_color
	local cm = Fade and text_color or color.hp.bar

	--Fix the pad issue when 0
	if spaces == 0 then
		player_stats_hp_bar_meter:bg_alpha(0)
	else
		player_stats_hp_bar_meter:bg_alpha(not Fade and (drain_hp_bar and meter_bg_alpha or bg_alpha))
		--fix for the math flooring this to 0 when its not exactly 0 (13 is because of padding issue though)
		if spaces < 13 and hp > 0 then
			spaces = 13
		end
		while string.len(hp_meter) < spaces do
			hp_meter = hp_meter..' '
		end
	end

	--Add the max hp to the right-side of the bar
	local center_padding = ''
	if show_max_hp_mp_on_bar then
		local center_spaces = player_stats_bar_width - string.len(tostring(hp)) - string.len(tostring(max_hp)) - 5
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

	--Pulse HP when its critically low (and not dead)
	if pulse_when_hp_low and hpp > 0 and hpp <= 25 and not Pulse_HP then
		Pulse_HP = true
	elseif Pulse_HP and (hpp == 0 or hpp > 25) then
		player_stats_hp_bar_pulse:bg_alpha(0)
		Pulse_HP = false
	end
	player_stats_hp_bar_pulse:bg_color(ct.r,ct.g,ct.b)

	--Format the text output
	local text = 'HP: \\cs('..ct.r..','..ct.g..','..ct.b..')'..hp..'\\cr'..max_hp
	local text_shdw = 'HP: '..hp..max_hp
	player_stats_hp_bar_meter:text('\n\n\n\n\n\n\n'..hp_meter)
	player_stats_hp_bar_meter:bg_color(cm.r,cm.g,cm.b)
	player_stats_hp_bar_drain_meter:bg_color(cm.r,cm.g,cm.b)
	player_stats_hp_text:text(Fade and text:text_strip_format() or text)
	player_stats_hp_text_shadow:text(text_shdw)

end

function updateHPBarAnimations(player)

	--HP Bar Pulse animation
	if Pulse_HP and not (Fade or Screen_Test) then
		if pulse_hp_direction_up and pulse_hp_alpha_num < pulse_brightness then
			pulse_hp_alpha_num = pulse_hp_alpha_num + pulse_speed
			player_stats_hp_bar_pulse:bg_alpha(pulse_hp_alpha_num)
		elseif pulse_hp_direction_up and pulse_hp_alpha_num >= pulse_brightness then
			pulse_hp_alpha_num = pulse_brightness
			player_stats_hp_bar_pulse:bg_alpha(pulse_hp_alpha_num)
			pulse_hp_direction_up = false
		elseif not pulse_hp_direction_up and pulse_hp_alpha_num > 10 then
			pulse_hp_alpha_num = pulse_hp_alpha_num - pulse_speed
			player_stats_hp_bar_pulse:bg_alpha(pulse_hp_alpha_num)
		elseif not pulse_hp_direction_up and pulse_hp_alpha_num <= 10 then
			pulse_hp_alpha_num = 10
			player_stats_hp_bar_pulse:bg_alpha(pulse_hp_alpha_num)
			pulse_hp_direction_up = true
		end
	end

	--HP Bar Drain animation
	if drain_hp_bar then

		local hpp = player and player.vitals.hpp or 0
		local hp_diff = drain_ps_hpp - hpp
		local current_decay = math.min(hp_diff * 0.1, drain_decay * 120)
		drain_ps_hpp = hpp and hpp < drain_ps_hpp and drain_ps_hpp - current_decay or hpp
		local drain_spaces = drain_ps_hpp and math.floor((player_stats_bar_width * 10) * (drain_ps_hpp / 100)) or 0
		local drain_meter = ''

		--Fix the pad issue
		if drain_spaces <= 6 then
			player_stats_hp_bar_drain_meter:bg_alpha(0)
		elseif not Fade then
			--fix for the math flooring this to 0 when its not exactly 0 (13 is because of padding issue though)
			if drain_spaces < 13 and drain_ps_hpp > 0 then
				drain_spaces = 13
			end
			while string.len(drain_meter) < drain_spaces do
				drain_meter = drain_meter..' '
			end
			player_stats_hp_bar_drain_meter:text('\n\n\n\n\n\n\n'..drain_meter)
			player_stats_hp_bar_drain_meter:bg_alpha(drain_bg_alpha)
		end

	end

end

--Update the MP bar
function updateMPBar(player)

	local mp = player and player.vitals.mp or 0
	local max_mp = player and player.vitals.max_mp or 0
	local mpp = player and player.vitals.mpp or 0
	local hpp = player and player.vitals.hpp or 0
	local mp_meter = ''
	local spaces = math.floor((player_stats_bar_width * 10) * (mpp / 100))
	local ct = text_color
	local cm = Fade and text_color or color.mp.bar

	--Fix the pad issue when 0
	if spaces == 0 then
		player_stats_mp_bar_meter:bg_alpha(0)
	else
		player_stats_mp_bar_meter:bg_alpha(not Fade and (drain_mp_bar and meter_bg_alpha or bg_alpha))
		--fix for the math flooring this to 0 when its not exactly 0 (13 is because of padding issue though)
		if spaces < 13 and mp >= 0 then
			spaces = 13
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

	--Add the max mp to the right-side of the bar
	local center_padding = ''
	if show_max_hp_mp_on_bar then
		local center_spaces = player_stats_bar_width - string.len(tostring(mp)) - string.len(tostring(max_mp)) - 5
		while string.len(center_padding) < center_spaces do
			center_padding = center_padding..' '
		end
		max_mp = center_padding..max_mp
	else
		max_mp = ''
	end

	--Pulse MP when its critically low (and not dead)
	if pulse_when_mp_low and hpp > 0 and mpp <= 25 and not Pulse_MP then
		Pulse_MP = true
	elseif Pulse_MP and (hpp == 0 or mpp > 25) then
		player_stats_mp_bar_pulse:bg_alpha(0)
		Pulse_MP = false
	end
	player_stats_mp_bar_pulse:bg_color(ct.r,ct.g,ct.b)

	--Format the text output
	local text = 'MP: \\cs('..ct.r..','..ct.g..','..ct.b..')'..mp..'\\cr'..max_mp
	local text_shdw = 'MP: '..mp..max_mp
	player_stats_mp_bar_meter:text('\n\n\n\n\n\n\n'..mp_meter)
	player_stats_mp_bar_meter:bg_color(cm.r,cm.g,cm.b)
	player_stats_mp_bar_drain_meter:bg_color(cm.r,cm.g,cm.b)
	player_stats_mp_text:text(Fade and text:text_strip_format() or text)
	player_stats_mp_text_shadow:text(text_shdw)

end

function updateMPBarAnimations(player)

	--MP Bar Pulse animation
	if Pulse_MP and not (Fade or Screen_Test) then
		if pulse_mp_direction_up and pulse_mp_alpha_num < pulse_brightness then
			pulse_mp_alpha_num = pulse_mp_alpha_num + pulse_speed
			player_stats_mp_bar_pulse:bg_alpha(pulse_mp_alpha_num)
		elseif pulse_mp_direction_up and pulse_mp_alpha_num >= pulse_brightness then
			pulse_mp_alpha_num = pulse_brightness
			player_stats_mp_bar_pulse:bg_alpha(pulse_mp_alpha_num)
			pulse_mp_direction_up = false
		elseif not pulse_mp_direction_up and pulse_mp_alpha_num > 10 then
			pulse_mp_alpha_num = pulse_mp_alpha_num - pulse_speed
			player_stats_mp_bar_pulse:bg_alpha(pulse_mp_alpha_num)
		elseif not pulse_mp_direction_up and pulse_mp_alpha_num <= 10 then
			pulse_mp_alpha_num = 10
			player_stats_mp_bar_pulse:bg_alpha(pulse_mp_alpha_num)
			pulse_mp_direction_up = true
		end
	end

	--MP Bar Drain animation
	if drain_mp_bar then

		local mpp = player and player.vitals.mpp or 0
		local mp_diff = drain_ps_mpp - mpp
		local current_decay = math.min(mp_diff * 0.1, drain_decay * 120)
		drain_ps_mpp = mpp and mpp < drain_ps_mpp and drain_ps_mpp - current_decay or mpp
		local drain_spaces = drain_ps_mpp and math.floor((player_stats_bar_width * 10) * (drain_ps_mpp / 100)) or 0
		local drain_meter = ''

		--Fix the pad issue
		if drain_spaces <= 6 then
			player_stats_mp_bar_drain_meter:bg_alpha(0)
		elseif not Fade then
			--fix for the math flooring this to 0 when its not exactly 0 (13 is because of padding issue though)
			if drain_spaces < 13 and drain_ps_mpp > 0 then
				drain_spaces = 13
			end
			while string.len(drain_meter) < drain_spaces do
				drain_meter = drain_meter..' '
			end
			player_stats_mp_bar_drain_meter:text('\n\n\n\n\n\n\n'..drain_meter)
			player_stats_mp_bar_drain_meter:bg_alpha(drain_bg_alpha)
		end

	end

end

--Update the TP bar
function updateTPBar(player)

	local tp = player and player.vitals.tp or 0
	local hpp = player and player.vitals.hpp or 0
	local tp_meter = ''
	local spaces = math.floor((player_stats_bar_width * 10) * (tp / 3000))
	local floating_tp_spaces = math.floor(player_stats_bar_width * (tp / 3000))
	local floating_tp = ''
	local tp_spaces = floating_tp_number and math.max(math.min(floating_tp_spaces - (tp < 1000 and 8 or 9), player_stats_bar_width - 9), 0) or 0
	while string.len(floating_tp) < tp_spaces do
		floating_tp = floating_tp..' '
	end
	local cm = text_color

	--Fix the pad issue when 0
	if spaces == 0 then
		player_stats_tp_bar_meter:bg_alpha(0)
	else
		if not Fade then
			if drain_tp_bar then
				player_stats_tp_bar_meter:bg_alpha(meter_bg_alpha)
			else
				player_stats_tp_bar_meter:bg_alpha(bg_alpha)
			end
		end
		--fix for the math flooring this to 0 when its not exactly 0 (13 is because of padding issue though)
		if spaces < 13 and tp > 0 then
			spaces = 13
		end
		while string.len(tp_meter) < spaces do
			tp_meter = tp_meter..' '
		end
	end

	--Set the color for the bar based on TP percentage
	if not Fade then
		if tp == 3000 then
			cm = color.tp.full_3k
		elseif tp >= 2000 then
			cm = color.tp.full_2k
		elseif tp >= 1000 then
			cm = color.tp.full_1k
		end
	end

	--Pulse TP when its ready to use (and not dead)
	if pulse_when_tp_ready and hpp > 0 and tp >= 1000 and not Pulse_TP and not Screen_Test then
		Pulse_TP = true
	elseif (Pulse_TP and (hpp == 0 or tp < 1000)) or Screen_Test then
		player_stats_tp_bar_pulse:bg_alpha(0)
		Pulse_TP = false
	end
	player_stats_tp_bar_pulse:bg_color(cm.r,cm.g,cm.b)

	--Format the text output
	local text = 'TP: '..floating_tp..'\\cs('..cm.r..','..cm.g..','..cm.b..')'..tp..'\\cr'
	local text_shdw = 'TP: '..floating_tp..''..tp
	player_stats_tp_bar_meter:text('\n\n\n\n\n\n\n'..tp_meter)
	if pulse_tp_meter_only then
		player_stats_tp_bar_pulse:text('\n\n\n\n\n\n\n'..tp_meter)
	end
	player_stats_tp_text:text(Fade and text:text_strip_format() or text)
	player_stats_tp_text_shadow:text(text_shdw)

	--Set the color for the bar based on TP percentage
	player_stats_tp_bar_drain_meter:bg_color(cm.r,cm.g,cm.b)
	player_stats_tp_bar_meter:bg_color(cm.r,cm.g,cm.b)

end

function updateTPBarAnimations(player)

	--TP Bar Pulse animation
	if Pulse_TP and not (Fade or Screen_Test) then
		if pulse_tp_direction_up and pulse_tp_alpha_num < pulse_brightness then
			pulse_tp_alpha_num = pulse_tp_alpha_num + pulse_speed
			player_stats_tp_bar_pulse:bg_alpha(pulse_tp_alpha_num)
		elseif pulse_tp_direction_up and pulse_tp_alpha_num >= pulse_brightness then
			pulse_tp_alpha_num = pulse_brightness
			player_stats_tp_bar_pulse:bg_alpha(pulse_tp_alpha_num)
			pulse_tp_direction_up = false
		elseif not pulse_tp_direction_up and pulse_tp_alpha_num > 10 then
			pulse_tp_alpha_num = pulse_tp_alpha_num - pulse_speed
			player_stats_tp_bar_pulse:bg_alpha(pulse_tp_alpha_num)
		elseif not pulse_tp_direction_up and pulse_tp_alpha_num <= 10 then
			pulse_tp_alpha_num = 10
			player_stats_tp_bar_pulse:bg_alpha(pulse_tp_alpha_num)
			pulse_tp_direction_up = true
		end
	end

	--TP Bar Drain animation
	if drain_tp_bar then

		local tp = player and player.vitals.tp or 0
		local tp_diff = drain_ps_tp - tp
		local current_decay = math.min(tp_diff * 0.1, drain_decay * 120)
		drain_ps_tp = tp and tp < drain_ps_tp and drain_ps_tp - current_decay or tp
		local drain_spaces = drain_ps_tp and math.floor((player_stats_bar_width * 10) * (drain_ps_tp / 3000)) or 0
		local drain_meter = ''

		--Fix the pad issue
		if drain_spaces <= 6 then
			player_stats_tp_bar_drain_meter:bg_alpha(0)
		elseif not Fade then
			--fix for the math flooring this to 0 when its not exactly 0 (13 is because of padding issue though)
			if drain_spaces < 13 and drain_ps_tp > 0 then
				drain_spaces = 13
			end
			while string.len(drain_meter) < drain_spaces do
				drain_meter = drain_meter..' '
			end
			player_stats_tp_bar_drain_meter:text('\n\n\n\n\n\n\n'..drain_meter)
			player_stats_tp_bar_drain_meter:bg_alpha(drain_bg_alpha)
		end

	end

end

--Update the Pet bar
function updatePetBar(pet)

	local hpp = pet and pet.hpp or 0
	local status = job ~= 'geo' and pet and show_pet_status and ' ('..res.statuses[pet.status].en..')' or ''
	local distance = pet and show_pet_distance and (string.format("%5.2f", math.floor(pet.distance:sqrt()*100)/100))..' ' or ''
	local tp = job ~= 'geo' and pet and show_pet_tp and ' TP: '..pet_tp or ''
	local pet_meter = ''
	local spaces = math.floor((player_stats_bar_width * 10) * (hpp / 100))
	local ct = color.hp

	--Hide the Pet bar if the option is turned on and there is no pet
	if hide_pet_bar_when_no_pet and not pet and player_stats_pet_bar_bg:visible() then
		player_stats_pet_bar_bg:hide()
		player_stats_pet_bar_pulse:hide()
		player_stats_pet_bar_drain_meter:hide()
		player_stats_pet_bar_meter:hide()
		player_stats_pet_text_shadow:hide()
		player_stats_pet_text:hide()
	elseif player_stats_pet_bar_bg:visible() then
		player_stats_pet_bar_bg:show()
		player_stats_pet_bar_pulse:show()
		player_stats_pet_bar_drain_meter:show()
		player_stats_pet_bar_meter:show()
		player_stats_pet_text_shadow:show()
		player_stats_pet_text:show()
	end

	local pet_name = pet and 'Pet' or 'No Pet'
	if job == 'bst' then pet_name = pet and pet.name or 'No Pet' end
	if job == 'drg' then pet_name = pet and pet.name or 'No Wyvern' end
	if job == 'geo' then pet_name = pet and 'Luopan' or 'No Luopan' end
	if job == 'pup' then pet_name = pet and pet.name or 'No Automaton' end
	if job == 'smn' then pet_name = pet and pet.name or 'No Avatar' end

	--Fix the pad issue when 0
	if spaces == 0 then
		player_stats_pet_bar_meter:bg_alpha(0)
	else
		player_stats_pet_bar_meter:bg_alpha(not Fade and (drain_pet_bar and meter_bg_alpha or bg_alpha))
		--fix for the math flooring this to 0 when its not exactly 0 (13 is because of padding issue though)
		if spaces == 0 and hpp > 0 then
			spaces = 13
		end
		while string.len(pet_meter) < spaces and string.len(pet_meter) < (player_stats_bar_width * 10) do
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

	--Pulse Pet when its critically low
	if pulse_when_pet_low and pet and hpp <= 25 and not Pulse_Pet then
		Pulse_Pet = true
	elseif Pulse_Pet and (hpp > 25 or not pet) then
		player_stats_pet_bar_pulse:bg_alpha(0)
		Pulse_Pet = false
	end
	player_stats_pet_bar_pulse:bg_color(cm.r,cm.g,cm.b)

	--Format the text output
	hpp = string.format("%3s", hpp)..'% '
	local text = (pet and '\\cs('..ct.r..','..ct.g..','..ct.b..')'..hpp..'\\cr' or '')..distance..pet_name..status..tp
	local text_shdw = (pet and '\\cs(000,000,000)'..hpp..'\\cr' or '')..distance..pet_name..status..tp
	player_stats_pet_bar_meter:text('\n\n\n\n\n\n\n'..pet_meter)
	player_stats_pet_bar_meter:bg_color(cm.r,cm.g,cm.b)
	player_stats_pet_bar_drain_meter:bg_color(cm.r,cm.g,cm.b)
	player_stats_pet_text:text(Fade and text:text_strip_format() or text)
	player_stats_pet_text_shadow:text(Fade and text_shdw:text_strip_format() or text_shdw)

end

function updatePetBarAnimations(pet)

	--Pet Bar Pulse animation
	if Pulse_Pet and not (Fade or Screen_Test) then
		if pulse_pet_direction_up and pulse_pet_alpha_num < pulse_brightness then
			pulse_pet_alpha_num = pulse_pet_alpha_num + pulse_speed
			player_stats_pet_bar_pulse:bg_alpha(pulse_pet_alpha_num)
		elseif pulse_pet_direction_up and pulse_pet_alpha_num >= pulse_brightness then
			pulse_pet_alpha_num = pulse_brightness
			player_stats_pet_bar_pulse:bg_alpha(pulse_pet_alpha_num)
			pulse_pet_direction_up = false
		elseif not pulse_pet_direction_up and pulse_pet_alpha_num > 10 then
			pulse_pet_alpha_num = pulse_pet_alpha_num - pulse_speed
			player_stats_pet_bar_pulse:bg_alpha(pulse_pet_alpha_num)
		elseif not pulse_pet_direction_up and pulse_pet_alpha_num <= 10 then
			pulse_pet_alpha_num = 10
			player_stats_pet_bar_pulse:bg_alpha(pulse_pet_alpha_num)
			pulse_pet_direction_up = true
		end
	end

	--Pet Bar Drain animation
	if drain_pet_bar then

		local hpp = pet and pet.hpp or 0
		local pet_diff = drain_ps_pet - hpp
		local current_decay = math.min(pet_diff * 0.1, drain_decay * 120)
		drain_ps_pet = hpp and hpp < drain_ps_pet and drain_ps_pet - current_decay or hpp
		local drain_spaces = drain_ps_pet and math.floor((player_stats_bar_width * 10) * (drain_ps_pet / 100)) or 0
		local drain_meter = ''

		--Fix the pad issue
		if drain_spaces <= 6 then
			player_stats_pet_bar_drain_meter:bg_alpha(0)
		elseif drain_pet_bar and not Fade then
			--fix for the math flooring this to 0 when its not exactly 0 (13 is because of padding issue though)
			if drain_spaces < 13 and drain_ps_pet > 0 then
				drain_spaces = 13
			end
			while string.len(drain_meter) < drain_spaces do
				drain_meter = drain_meter..' '
			end
			player_stats_pet_bar_drain_meter:text('\n\n\n\n\n\n\n'..drain_meter)
			player_stats_pet_bar_drain_meter:bg_alpha(drain_bg_alpha)
		end

	end

end

function updatePartyActions()

	local show_party_1 = party_1_actions.show
	local show_party_2 = party_2_actions.show
	local show_party_3 = party_3_actions.show
	local party_1_results = party_1_actions.show_results
	local party_2_results = party_2_actions.show_results
	local party_3_results = party_3_actions.show_results

	if not show_party_1 and not show_party_2 and not show_party_3 then return end

	local function formatPartyAction(str)
		local raw = str:text_strip_format()

		--Remove everything from the tageting icon onward leaving just the action
		local arrow_pos = raw:find(' '..targeting_icon..' ')
		local display_str = arrow_pos and raw:sub(1, arrow_pos - 1) or raw

		return display_str
	end	

	--Party 1
	if show_party_1 then

		if party_1_actions.show_self then
			local p0 = get_mob_by_target('p0')
			local p0_action = Screen_Test and "Party 1: Player 0" or (p0 and current_actions[p0.id] and current_actions[p0.id].action or '')
			local p0_result = party_1_results and not Screen_Test and p0 and current_actions[p0.id] and current_actions[p0.id].result or ''
			local text_p0_action = formatPartyAction(p0_action)..formatPartyAction(p0_result)
			party_actions_pt1_p0_text:text(text_p0_action)
		end

		local p1 = get_mob_by_target('p1')
		local p1_action = Screen_Test and "Party 1: Player 1" or (p1 and current_actions[p1.id] and current_actions[p1.id].action or '')
		local p1_result = party_1_results and not Screen_Test and p1 and current_actions[p1.id] and current_actions[p1.id].result or ''
		local text_p1_action = formatPartyAction(p1_action)..formatPartyAction(p1_result)
		party_actions_pt1_p1_text:text(text_p1_action)

		local p2 = get_mob_by_target('p2')
		local p2_action = Screen_Test and "Party 1: Player 2" or (p2 and current_actions[p2.id] and current_actions[p2.id].action or '')
		local p2_result = party_1_results and not Screen_Test and p2 and current_actions[p2.id] and current_actions[p2.id].result or ''
		local text_p2_action = formatPartyAction(p2_action)..formatPartyAction(p2_result)
		party_actions_pt1_p2_text:text(text_p2_action)

		local p3 = get_mob_by_target('p3')
		local p3_action = Screen_Test and "Party 1: Player 3" or (p3 and current_actions[p3.id] and current_actions[p3.id].action or '')
		local p3_result = party_1_results and not Screen_Test and p3 and current_actions[p3.id] and current_actions[p3.id].result or ''
		local text_p3_action = formatPartyAction(p3_action)..formatPartyAction(p3_result)
		party_actions_pt1_p3_text:text(text_p3_action)

		local p4 = get_mob_by_target('p4')
		local p4_action = Screen_Test and "Party 1: Player 4" or (p4 and current_actions[p4.id] and current_actions[p4.id].action or '')
		local p4_result = party_1_results and not Screen_Test and p4 and current_actions[p4.id] and current_actions[p4.id].result or ''
		local text_p4_action = formatPartyAction(p4_action)..formatPartyAction(p4_result)
		party_actions_pt1_p4_text:text(text_p4_action)

		local p5 = get_mob_by_target('p5')
		local p5_action = Screen_Test and "Party 1: Player 5" or (p5 and current_actions[p5.id] and current_actions[p5.id].action or '')
		local p5_result = party_1_results and not Screen_Test and p5 and current_actions[p5.id] and current_actions[p5.id].result or ''
		local text_p5_action = formatPartyAction(p5_action)..formatPartyAction(p5_result)
		party_actions_pt1_p5_text:text(text_p5_action)
	end

	--Party 2
	if show_party_2 then

		local a10 = get_mob_by_target('a10')
		local a10_action = Screen_Test and "Party 2: Player 0" or (a10 and current_actions[a10.id] and current_actions[a10.id].action or '')
		local a10_result = party_2_results and not Screen_Test and a10 and current_actions[a10.id] and current_actions[a10.id].result or ''
		local text_a10_action = formatPartyAction(a10_action)..formatPartyAction(a10_result)
		party_actions_pt2_p0_text:text(text_a10_action)

		local a11 = get_mob_by_target('a11')
		local a11_action = Screen_Test and "Party 2: Player 1" or (a11 and current_actions[a11.id] and current_actions[a11.id].action or '')
		local a11_result = party_2_results and not Screen_Test and a11 and current_actions[a11.id] and current_actions[a11.id].result or ''
		local text_a11_action = formatPartyAction(a11_action)..formatPartyAction(a11_result)
		party_actions_pt2_p1_text:text(text_a11_action)

		local a12 = get_mob_by_target('a12')
		local a12_action = Screen_Test and "Party 2: Player 2" or (a12 and current_actions[a12.id] and current_actions[a12.id].action or '')
		local a12_result = party_2_results and not Screen_Test and a12 and current_actions[a12.id] and current_actions[a12.id].result or ''
		local text_a12_action = formatPartyAction(a12_action)..formatPartyAction(a12_result)
		party_actions_pt2_p2_text:text(text_a12_action)

		local a13 = get_mob_by_target('a13')
		local a13_action = Screen_Test and "Party 2: Player 3" or (a13 and current_actions[a13.id] and current_actions[a13.id].action or '')
		local a13_result = party_2_results and not Screen_Test and a13 and current_actions[a13.id] and current_actions[a13.id].result or ''
		local text_a13_action = formatPartyAction(a13_action)..formatPartyAction(a13_result)
		party_actions_pt2_p3_text:text(text_a13_action)

		local a14 = get_mob_by_target('a14')
		local a14_action = Screen_Test and "Party 2: Player 4" or (a14 and current_actions[a14.id] and current_actions[a14.id].action or '')
		local a14_result = party_2_results and not Screen_Test and a14 and current_actions[a14.id] and current_actions[a14.id].result or ''
		local text_a14_action = formatPartyAction(a14_action)..formatPartyAction(a14_result)
		party_actions_pt2_p4_text:text(text_a14_action)

		local a15 = get_mob_by_target('a15')
		local a15_action = Screen_Test and "Party 2: Player 5" or (a15 and current_actions[a15.id] and current_actions[a15.id].action or '')
		local a15_result = party_2_results and not Screen_Test and a15 and current_actions[a15.id] and current_actions[a15.id].result or ''
		local text_a15_action = formatPartyAction(a15_action)..formatPartyAction(a15_result)
		party_actions_pt2_p5_text:text(text_a15_action)
	end

	--Party 3
	if show_party_3 then

		local a20 = get_mob_by_target('a20')
		local a20_action = Screen_Test and "Party 3: Player 0" or (a20 and current_actions[a20.id] and current_actions[a20.id].action or '')
		local a20_result = party_3_results and not Screen_Test and a20 and current_actions[a20.id] and current_actions[a20.id].result or ''
		local text_a20_action = formatPartyAction(a20_action)..formatPartyAction(a20_result)
		party_actions_pt3_p0_text:text(text_a20_action)

		local a21 = get_mob_by_target('a21')
		local a21_action = Screen_Test and "Party 3: Player 1" or (a21 and current_actions[a21.id] and current_actions[a21.id].action or '')
		local a21_result = party_3_results and not Screen_Test and a21 and current_actions[a21.id] and current_actions[a21.id].result or ''
		local text_a21_action = formatPartyAction(a21_action)..formatPartyAction(a21_result)
		party_actions_pt3_p1_text:text(text_a21_action)

		local a22 = get_mob_by_target('a22')
		local a22_action = Screen_Test and "Party 3: Player 2" or (a22 and current_actions[a22.id] and current_actions[a22.id].action or '')
		local a22_result = party_3_results and not Screen_Test and a22 and current_actions[a22.id] and current_actions[a22.id].result or ''
		local text_a22_action = formatPartyAction(a22_action)..formatPartyAction(a22_result)
		party_actions_pt3_p2_text:text(text_a22_action)

		local a23 = get_mob_by_target('a23')
		local a23_action = Screen_Test and "Party 3: Player 3" or (a23 and current_actions[a23.id] and current_actions[a23.id].action or '')
		local a23_result = party_3_results and not Screen_Test and a23 and current_actions[a23.id] and current_actions[a23.id].result or ''
		local text_a23_action = formatPartyAction(a23_action)..formatPartyAction(a23_result)
		party_actions_pt3_p3_text:text(text_a23_action)

		local a24 = get_mob_by_target('a24')
		local a24_action = Screen_Test and "Party 3: Player 4" or (a24 and current_actions[a24.id] and current_actions[a24.id].action or '')
		local a24_result = party_3_results and not Screen_Test and a24 and current_actions[a24.id] and current_actions[a24.id].result or ''
		local text_a24_action = formatPartyAction(a24_action)..formatPartyAction(a24_result)
		party_actions_pt3_p4_text:text(text_a24_action)

		local a25 = get_mob_by_target('a25')
		local a25_action = Screen_Test and "Party 3: Player 5" or (a25 and current_actions[a25.id] and current_actions[a25.id].action or '')
		local a25_result = party_3_results and not Screen_Test and a25 and current_actions[a25.id] and current_actions[a25.id].result or ''
		local text_a25_action = formatPartyAction(a25_action)..formatPartyAction(a25_result)
		party_actions_pt3_p5_text:text(text_a25_action)
	end

end

--List the contents of the Auto Focus Target list
function listAutoFocusTargets()
	local sortedTargets = {}

	add_to_chat(8,('[Bars] '):color(220)..('Auto Focus Targets: '):color(8))

	--Copy targets and sort them alphabetically
	for target in pairs(auto_focus_targets_data) do
		table.insert(sortedTargets, target)
	end
	table.sort(sortedTargets)

	--Check if sortedTargets is empty
	if next(sortedTargets) == nil then
		add_to_chat(8,' - '..('[Empty]'):color(1))
	end

	--Add sorted targets to chat
	for _, target in ipairs(sortedTargets) do
		add_to_chat(8,' - '..(target):color(1))
	end

end

--Check for matching focus targets
function checkForFocusTarget(target)

	local nearby = nil

	--Loop through all the mobs in memory (nearby)
	for i,v in pairs(get_mob_array()) do

		local distance = math.floor(v.distance:sqrt() * 100) / 100
		local nearby_mob_by_id = get_mob_by_id(v.id)
		local nearby_mob_by_name = get_mob_by_name(v.name)

		--Does an id nearby match an entry in our auto focus target list?
		if nearby_mob_by_id and auto_focus_targets_data[v.id] 
		and v.valid_target and distance <= tonumber(focus_target_max_distance) 
		and (show_focus_target_when_targeted or not (target and target.id == nearby_mob_by_id.id)) 
		--Fix bug where when a target on the list first enters memory, it has a distance of 0 for a split second, making it show up on the Focus Target Bar for a frame before it actually enters the focus_target_max_distance range. This will ofc make it disappear if you manage to stand exactly on top of it, but gl doing that.
		and not (tonumber(focus_target_max_distance) < 50 and distance == 0) then

			nearby = nearby_mob_by_id

		--Does a name nearby match an entry in our auto focus target list?
		elseif nearby_mob_by_name and auto_focus_targets_data[v.name] 
		and v.valid_target and distance <= tonumber(focus_target_max_distance) 
		and (show_focus_target_when_targeted or not (target and target.id == nearby_mob_by_name.id)) 
		and not (tonumber(focus_target_max_distance) < 50 and distance == 0) then

			nearby = nearby_mob_by_name

		end

	end

	--Update focus_target if its new, will remove/nil if nothing in the auto_focus_targets_data
	if focus_target ~= nearby then
		focus_target = nearby
		if not nearby then
			focus_target_bar_drain_meter:hide()
		end
	end

end

--Check if focus target override is still nearby
function checkForFocusTargetOverride(target)

	local nearby = false

	--Loop through all the mobs in memory (nearby)
	for i,v in pairs(get_mob_array()) do

		local distance = math.floor(v.distance:sqrt() * 100) / 100

		--Does the id of the focus target override match to any mob id nearby
		if focus_target_override.id == v.id and v.valid_target and distance <= tonumber(focus_target_max_distance) then
			nearby = true
		end
	end

	--Update their data if they are still nearby
	if nearby or Screen_Test then
		focus_target_override = Screen_Test and screen_test_focus_target or get_mob_by_id(focus_target_override.id)
	--Remove the Focus Target Override if they are no longer nearby
	else
		add_to_chat(8,('[Bars] '):color(220)..('Focus Target Override Removed: '):color(36)..(focus_target_override.name):color(1))
		focus_target_override = nil
		focus_target_bar_drain_meter:hide()
	end

end

--Fade the text (alpha)
function setTextFade(num)

	focus_target_text:alpha(num)
	focus_target_text:stroke_alpha(num)
	focus_target_text_shadow:alpha(num)
	focus_target_action_text:alpha(num)
	focus_target_action_text:stroke_alpha(num)
	focus_target_action_text_shadow:alpha(num)

	sub_target_text:alpha(num)
	sub_target_text:stroke_alpha(num)
	sub_target_text_shadow:alpha(num)
	sub_target_action_text:alpha(num)
	sub_target_action_text:stroke_alpha(num)
	sub_target_action_text_shadow:alpha(num)

	target_bar_lock_left:alpha(num)
	target_bar_lock_right:alpha(num)
	target_text:alpha(num)
	target_text:stroke_alpha(num)
	target_text_shadow:alpha(num)
	target_action_text:alpha(num)
	target_action_text:stroke_alpha(num)
	target_action_text_shadow:alpha(num)

	player_stats_hp_text:alpha(num)
	player_stats_hp_text:stroke_alpha(num)
	player_stats_hp_text_shadow:alpha(num)
	player_stats_hp_marker:alpha(num)

	player_stats_mp_text:alpha(num)
	player_stats_mp_text:stroke_alpha(num)
	player_stats_mp_text_shadow:alpha(num)

	player_stats_tp_text:alpha(num)
	player_stats_tp_text:stroke_alpha(num)
	player_stats_tp_text_shadow:alpha(num)
	player_stats_tp_marker:alpha(num)

	player_stats_pet_text:alpha(num)
	player_stats_pet_text:stroke_alpha(num)
	player_stats_pet_text_shadow:alpha(num)

	self_action_text:alpha(num)
	self_action_text:stroke_alpha(num)
	self_action_text_shadow:alpha(num)

end

--Fade the bars (bg_alpha)
function setBarFade(num, player, pet)

	focus_target_bar_meter:bg_alpha(num)
	focus_target_bar_drain_meter:bg_alpha(0)
	focus_target_bar_bg:bg_alpha(num)

	sub_target_bar_meter:bg_alpha(num)
	sub_target_bar_drain_meter:bg_alpha(0)
	sub_target_bar_bg:bg_alpha(num)

	target_bar_meter:bg_alpha(num)
	target_bar_drain_meter:bg_alpha(0)
	target_bar_bg:bg_alpha(num)
	target_bar_lock_underline:bg_alpha(num)

	self_action_bar_meter:bg_alpha(num)
	self_action_bar_bg:bg_alpha(num)

	if player and player.vitals.hp > 0 then
		player_stats_hp_bar_meter:bg_alpha(num)
		player_stats_hp_bar_drain_meter:bg_alpha(0)
	end
	player_stats_hp_bar_bg:bg_alpha(num)

	if player and player.vitals.mp > 0 then
		player_stats_mp_bar_meter:bg_alpha(num)
		player_stats_mp_bar_drain_meter:bg_alpha(0)
	end
	player_stats_mp_bar_bg:bg_alpha(num)

	if player and player.vitals.tp > 0 then
		player_stats_tp_bar_meter:bg_alpha(num)
		player_stats_tp_bar_drain_meter:bg_alpha(0)
	end
	player_stats_tp_bar_bg:bg_alpha(num)

	if pet and pet.hpp > 0 then
		player_stats_pet_bar_meter:bg_alpha(num)
		player_stats_pet_bar_drain_meter:bg_alpha(0)
	end
	player_stats_pet_bar_bg:bg_alpha(num)

end

--Fade the icons
function setIconFade(num)

	for section, section_table in pairs(debuff_icons) do

		local section_settings = settings.sections[section]
		local icon_set = debuff_icons[section]
		local timer_set = debuff_timers[section]

		for k = 1, max_icons[section] do
			icon_set[k]:alpha(num)
			if section_settings.debuff_timers then
				timer_set[k]:alpha(num)
				timer_set[k]:stroke_alpha(num)
			end
		end

	end

end

--Fade the BG UI images
function setBGUIFade(num)

	for section, section_table in pairs(ui_bg_left) do

		ui_bg_left[section]:alpha(num)
		ui_bg_middle[section]:alpha(num)
		ui_bg_right[section]:alpha(num)

	end

end


--Reset the bars alpha/bg_alpha to normal
function unFade()

	local player = get_player()
	local pet = get_mob_by_target('pet')

	focus_target_bar_meter:bg_alpha(drain_target_bars and meter_bg_alpha or bg_alpha)
	focus_target_bar_drain_meter:bg_alpha(drain_bg_alpha)
	focus_target_bar_bg:bg_alpha(bg_alpha)
	focus_target_text:alpha(text_alpha)
	focus_target_text:stroke_alpha(ft_text_stroke.a)
	focus_target_text_shadow:alpha(text_alpha)
	focus_target_action_text:alpha(text_alpha)
	focus_target_action_text:stroke_alpha(ft_text_stroke.a)
	focus_target_action_text_shadow:alpha(text_alpha)

	sub_target_bar_meter:bg_alpha(drain_target_bars and meter_bg_alpha or bg_alpha)
	sub_target_bar_drain_meter:bg_alpha(drain_bg_alpha)
	sub_target_bar_bg:bg_alpha(bg_alpha)
	sub_target_text:alpha(text_alpha)
	sub_target_text:stroke_alpha(st_text_stroke.a)
	sub_target_text_shadow:alpha(text_alpha)
	sub_target_action_text:alpha(text_alpha)
	sub_target_action_text:stroke_alpha(st_text_stroke.a)
	sub_target_action_text_shadow:alpha(text_alpha)

	target_bar_meter:bg_alpha(drain_target_bars and meter_bg_alpha or bg_alpha)
	target_bar_drain_meter:bg_alpha(drain_bg_alpha)
	target_bar_bg:bg_alpha(bg_alpha)
	target_bar_lock_left:alpha(text_alpha)
	target_bar_lock_right:alpha(text_alpha)
	target_bar_lock_underline:bg_alpha(bg_alpha)
	target_text:alpha(text_alpha)
	target_text:stroke_alpha(t_text_stroke.a)
	target_text_shadow:alpha(text_alpha)
	target_action_text:alpha(text_alpha)
	target_action_text:stroke_alpha(t_text_stroke.a)
	target_action_text_shadow:alpha(text_alpha)

	if player and player.vitals.hp > 0 then
		player_stats_hp_bar_meter:bg_alpha(drain_hp_bar and meter_bg_alpha or bg_alpha)
		player_stats_hp_bar_drain_meter:bg_alpha(drain_bg_alpha)
	end
	player_stats_hp_bar_meter:bg_color(color.hp.bar.r,color.hp.bar.g,color.hp.bar.b)
	player_stats_hp_bar_bg:bg_alpha(bg_alpha)
	player_stats_hp_marker:alpha(text_alpha)
	player_stats_hp_text:alpha(text_alpha)
	player_stats_hp_text:stroke_alpha(ps_text_stroke.a)
	player_stats_hp_text_shadow:alpha(text_alpha)

	if player and player.vitals.mp > 0 then
		player_stats_mp_bar_meter:bg_alpha(drain_mp_bar and meter_bg_alpha or bg_alpha)
		player_stats_mp_bar_drain_meter:bg_alpha(drain_bg_alpha)
	end
	player_stats_mp_bar_meter:bg_color(color.mp.bar.r,color.mp.bar.g,color.mp.bar.b)
	player_stats_mp_bar_bg:bg_alpha(bg_alpha)
	player_stats_mp_text:alpha(text_alpha)
	player_stats_mp_text:stroke_alpha(ps_text_stroke.a)
	player_stats_mp_text_shadow:alpha(text_alpha)

	if player and player.vitals.tp > 0 then
		player_stats_tp_bar_meter:bg_alpha(drain_tp_bar and meter_bg_alpha or bg_alpha)
		player_stats_tp_bar_drain_meter:bg_alpha(drain_bg_alpha)
	end
	player_stats_tp_bar_bg:bg_alpha(bg_alpha)
	player_stats_tp_marker:alpha(text_alpha)
	player_stats_tp_text:alpha(text_alpha)
	player_stats_tp_text:stroke_alpha(ps_text_stroke.a)
	player_stats_tp_text_shadow:alpha(text_alpha)

	if pet and pet.hpp > 0 then
		player_stats_pet_bar_meter:bg_alpha(drain_pet_bar and meter_bg_alpha or bg_alpha)
		player_stats_pet_bar_drain_meter:bg_alpha(drain_bg_alpha)
	end
	player_stats_pet_bar_meter:bg_color(color.pet.bar.r,color.pet.bar.g,color.pet.bar.b)
	player_stats_pet_bar_bg:bg_alpha(bg_alpha)
	player_stats_pet_text:alpha(text_alpha)
	player_stats_pet_text:stroke_alpha(ps_text_stroke.a)
	player_stats_pet_text_shadow:alpha(text_alpha)

	self_action_bar_meter:bg_alpha(bg_alpha)
	self_action_bar_bg:bg_alpha(bg_alpha)
	self_action_text:alpha(text_alpha)
	self_action_text:stroke_alpha(sa_text_stroke.a)
	self_action_text_shadow:alpha(text_alpha)

	for section, _ in pairs(debuff_icons) do

		local section_settings = settings.sections[section]
		local icon_set = debuff_icons[section]
		local timer_set = debuff_timers[section]

		for k = 1, max_icons[section] do
			icon_set[k]:alpha(255)
			if section_settings.debuff_timers then
				timer_set[k]:alpha(255)
				timer_set[k]:stroke_alpha(255)
			end
		end

	end

	for section, _ in pairs(ui_bg_left) do

		ui_bg_left[section]:alpha(settings.sections[section].ui_bg_alpha)
		ui_bg_middle[section]:alpha(settings.sections[section].ui_bg_alpha)
		ui_bg_right[section]:alpha(settings.sections[section].ui_bg_alpha)

	end

	--Run Wide Scan immediately after coming back from Fade
	runWideScan()

	--Update Player Stat Bars (mostly to re-enable any Pulses)
	updateHPBar(player)
	updateMPBar(player)
	updateTPBar(player)

end

--Reset the fade delay timer
function resetFadeDelay()
	fade_delay = settings.options.animations.fade_delay
	if Fade then
		Fade = false
		fade_bg_num = settings.bg.alpha
		fade_text_num = settings.text.alpha
		fade_icon_num = 255
		fade_bg_ui_num = settings.sections.focus_target.ui_bg_alpha
		unFade()
	end
end

--Check a table if it contains a specific message number
function checkForMessage(tbl, msg)
	for _, v in ipairs(tbl) do
		if v == msg then
			return true
		end
	end
	return false
end

--Show the Target, Sub Target, and Focus Target bars to test the screen layout
function screenTest()

	local player = get_player()

	--If already active, cancel test
	if Screen_Test then

		local target = get_mob_by_target('t')
		local sub_target = get_mob_by_target('st')
		Screen_Test = false
		focus_target_override = nil
		updateFocusTargetBar(player)
		updateSubTargetBar(player, sub_target, target)
		updateTargetBar(player, target)
		removeFromActionsTable(get_player().id, screen_test_tracking_index)
		resetFadeDelay()

		return
	end

	--Activate test mode
	Screen_Test = true

	--Setup the Self Action bar
	local trackingIndex = assignIndex()
	screen_test_tracking_index = trackingIndex  --Save so we can remove it later

	local c = text_color
	local c_r = formatRGB(c.r)
	local c_g = formatRGB(c.g)
	local c_b = formatRGB(c.b)
	local ct = targetColor(player, player)
	local ct_r = formatRGB(ct.r)
	local ct_g = formatRGB(ct.g)
	local ct_b = formatRGB(ct.b)

	local target_action = ' \\cs('..c_r..','..c_g..','..c_b..')Screen Test '..targeting_icon..'\\cr \\cs('..ct_r..','..ct_g..','..ct_b..')'..get_player().name..'\\cr'
	local target_action_shdw = ' \\cs(000,000,000)Screen Test '..targeting_icon..'\\cr \\cs(000,000,000)'..get_player().name..'\\cr'
	local target_action_status = '\\cs(245,164,066)'..casting_icon..'\\cr'
	local target_action_status_shdw = '\\cs(000,000,000)'..casting_icon..'\\cr'
	local target_action_result = ''
	local target_action_result_shdw = ''
	local action_target_name = ''
	local action_target_name_shdw = ''

	addToActionsTable(get_player().id, target_action, target_action_shdw, target_action_status, target_action_status_shdw, target_action_result, target_action_result_shdw, trackingIndex, action_target_name, action_target_name_shdw)

	self_action_bar_meter:bg_color(color.self.bar.r, color.self.bar.g, color.self.bar.b)

	--Setup the Focus Target bar (if not already overridden)
	if not (focus_target_override or focus_target) then
		focus_target_override = screen_test_focus_target
	end

	self_action_bar_bg:show()

	if show_aggro_list then
		aggro_list_box:show()
	end

end

--Run Wide Scan
function runWideScan()

	local in_town = wide_scan_exclude_zones:contains(zone_name)
	local in_mh = get_info().mog_house

	--Cancel if the option is completely turned off, currently locked, or user is zoning, in a cutscene, in town, or in their Mog House
	if not (
		settings.sections.focus_target.show_monster_level
		or settings.sections.sub_target.show_monster_level
		or settings.sections.target.show_monster_level
	)
	or wide_scan_locked
	or in_town or in_mh then
		return
	end

	local zone_name = res.zones[get_info().zone].name
	local packet = packets.new('outgoing', 0xF4, {
        ['Flags'] = 1,
        ['_unknown1'] = 0,
        ['_unknown2'] = 0,
    })

	--Send the Wide Scan request
	packets.inject(packet)

    --Schedule the next Wide Scan attempt for 30 to 60 seconds from now
    next_wide_scan_time = os.time() + math.random(30, 60)

	--Lock Wide Scan again
	wide_scan_locked = true

end

--Job Changing
register_event('job change', function()

	local target = get_mob_by_target('t')

	hideBars()
	setJob()
	setPositions()
	showBars(target)
	resetFadeDelay()

end)

--Target Changing
register_event('target change', function()

	local player = get_player()
	local target = get_mob_by_target('t')
	local sub_target = get_mob_by_target('st')
	local clock = os.clock()

	updateTargetBar(player, target, clock)
	if not condense_target_and_subtarget_bars then
		updateSubTargetBar(player, sub_target, target, clock)
	end
	resetFadeDelay()

	wide_scan_locked = false --Unlock to enable another Wide Scan since we're actively targeting things

	if target_bar_pixel_width <= 20
	or target_lock_underline_pixel_width <= 20
	or self_action_bar_pixel_width <= 20 then
		setUIPositions()
	end

	--Reset so the bars don't drain by simply targeting something else
	drain_st_hpp = 0
	drain_ft_hpp = 0
	drain_t_hpp = 0

	--Reset Monster Target id
	ft_targeting_id = nil
	st_targeting_id = nil
	t_targeting_id = nil

	if hide_player_stats_bars_when_no_target and not target then
		hidePlayerStatBars()
	elseif not in_cutscene and not zoning then
		showBars(target)
	end

	updateAggroList(player, target)

end)

function hpChange()

	if in_cutscene or zoning then return end

	local target = get_mob_by_target('t')
	if hide_player_stats_bars_when_no_target and not target then
		if player_stats_hp_bar_bg:visible() then
			hidePlayerStatBars()
		end
	else
		local player = get_player()
		updateHPBar(player)
		if not player_stats_hp_bar_bg:visible() then
			showBars(target)
		end
	end

end

--HP Changing
register_event('hp change', function(new_hp,old_hp)

	if new_hp < old_hp then
		resetFadeDelay()
	end

	hpChange()

end)
register_event('hpp change', hpChange)

function mpChange()

	if in_cutscene or zoning then return end

	if job and job_specific[job].mp then
		local target = get_mob_by_target('t')
		if hide_player_stats_bars_when_no_target and not target then
			if player_stats_mp_bar_bg:visible() then
				hidePlayerStatBars()
			end
		else
			local player = get_player()
			updateMPBar(player)
			if not player_stats_mp_bar_bg:visible() then
				showBars(target)
			end
		end
	end

end

--MP Changing
register_event('mp change', mpChange)
register_event('mpp change', mpChange)

--TP Changing
register_event('tp change', function(new_tp,old_tp)

	if in_cutscene or zoning then return end

	if job and job_specific[job].tp then
		local target = get_mob_by_target('t')
		if hide_player_stats_bars_when_no_target and not target then
			if player_stats_tp_bar_bg:visible() then
				hidePlayerStatBars()
			end
		else
			local player = get_player()
			updateTPBar(player)
			if not player_stats_tp_bar_bg:visible() then
				showBars(target)
			end
		end
	end

end)

--Greet the player on the first run of the addon
function greeting()

	if settings.first_run then
		add_to_chat(8,('[Bars] '):color(220)..('Welcome to Bars '.._addon.version.."!"):color(36))
		add_to_chat(8,('[Bars] '):color(220)..('Type '):color(8)..('//bars ui '):color(1)..('to unlock and drag the UI sections around.'):color(8))
		add_to_chat(8,('[Bars] '):color(220)..('Type '):color(8)..('//bars help '):color(1)..('for a list of other commands.'):color(8))
		add_to_chat(8,('[Bars] '):color(220)..('More detailed settings can be found in the '):color(8)..('Bars/data/settings.xml '):color(1)..('file.'):color(8))
		settings.first_run = false
		settings:save('all')
	end

end

--Run necessarry functions at start
function initialize()

	local player = get_player()
	local target = get_mob_by_target('t')
	local sub_target = get_mob_by_target('st')

	greeting()
	setJob()
	setPositions()
	setWidth()
	updateTargetBar(player, target)
	updateSubTargetBar(player, sub_target, target)
	updateHPBar(player)
	updateMPBar(player)
	updateTPBar(player)
	runWideScan()

	--Wait 2 sec then repeat since values are 0 when first logging into a character
	coroutine.schedule(function()
		player = get_player()
		updateHPBar(player)
		updateMPBar(player)
		updateTPBar(player)
		setUIPositions()
		showBars(target)
		logged_in = true
		server = res.servers[get_info().server].name
	end, 2)

end

--Load
register_event('load', function()

	if get_info().logged_in then
		initialize()
	end

end)

--Login
register_event('login', function()

	initialize()
	resetFadeDelay()
	logged_in = true

end)

--Logout
register_event('logout', function()

	hideBars()
	resetFadeDelay()
	clearTables()
	logged_in = false

end)

register_event('status change', function(status)

	--In a cutscene: Hide the bars
	if status == 4 and not in_cutscene then
		in_cutscene = true
		hideBars()

	--Out of cutscene: Show the bars
	elseif status ~= 4 and in_cutscene then
		in_cutscene = false
		local target = get_mob_by_target('t')
		showBars(target)

	end
	resetFadeDelay()
end)

register_event('prerender', function()

	if not logged_in or in_cutscene or zoning then return end

	local player = get_player()
	local target = get_mob_by_target('t')
	local sub_target = get_mob_by_target('st')
	local pet = get_mob_by_target('pet')
	local clock = os.clock()

	if sub_target and not condense_target_and_subtarget_bars then
		updateSubTargetBarAnimations(player, sub_target)
	end
	if target then
		updateTargetBarAnimations(player, target)
	end
	updateFocusTargetBarAnimations(player, target)

	updateSelfAction(player)

	if job and job_specific[job].hp then
		updateHPBarAnimations(player)
	end
	if job and job_specific[job].mp then
		updateMPBarAnimations(player)
	end
	if job and job_specific[job].tp then
		updateTPBarAnimations(player)
	end
	if job and job_specific[job].pet then
		updatePetBarAnimations(pet)
	end

	if clock - last_party_actions_update >= party_actions_update_interval then
		updatePartyActions()
		last_party_actions_update = clock
	end

	if clock - last_aggro_list_update >= aggro_list_update_interval then
		updateAggroList(player, target)
		last_aggro_list_update = clock
	end

	if clock - last_player_stats_update >= player_stats_pet_update_interval then
		if hide_player_stats_bars_when_no_target and not target then
			if player_stats_pet_bar_bg:visible() then
				hidePlayerStatBars()
			end
		else
			if job and job_specific[job].pet then
				if hide_pet_bar_when_no_pet and not pet and player_stats_pet_bar_bg:visible() then
					player_stats_pet_text:hide()
					player_stats_pet_text_shadow:hide()
					player_stats_pet_bar_bg:hide()
					player_stats_pet_bar_pulse:hide()
					player_stats_pet_bar_drain_meter:hide()
					player_stats_pet_bar_meter:hide()
				elseif not player_stats_pet_bar_bg:visible() then
					showBars(target)
				end
				updatePetBar(pet)
			end
		end
		last_player_stats_update = clock
	end

	if clock - last_target_update >= target_update_interval then
		if Screen_Test then
			updateTargetBar(player, screen_test_target)
		elseif condense_target_and_subtarget_bars and sub_target then
			updateTargetBar(player, sub_target, clock)
		else
			updateTargetBar(player, target, clock)
		end
		last_target_update = clock
	end

	if not condense_target_and_subtarget_bars and clock - last_sub_target_update >= sub_target_update_interval then
		if Screen_Test then
			updateSubTargetBar(player, screen_test_sub_target, target, clock)
		else
			updateSubTargetBar(player, sub_target, target, clock)
		end
		last_sub_target_update = clock
	end

	if (not target and not sub_target and not Screen_Test) and target_bar_lock_left:visible() and not calculating_dimensions then
		target_bar_lock_left:hide()
		target_bar_lock_right:hide()
		target_bar_lock_underline:hide()
	end

	if clock - last_focus_target_update >= focus_target_update_interval then
		if focus_target_override then
			checkForFocusTargetOverride(target)
		else
			checkForFocusTarget(target)
		end
		updateFocusTargetBar(player, target, clock)
		last_focus_target_update = clock
	end

	if os.time() > Heartbeat then

		Heartbeat = os.time()

		--Determine if we are in Dynamis-D
		inDyna()		

		--Run Wide Scan after next time has passed
		if Heartbeat >= next_wide_scan_time then
			runWideScan()
		end

		--Check for expired SP Abilities
		checkSPTimers(clock)

		--Fade timer
		if fade_after_a_delay and player.vitals.hp ~= 0 and not Screen_Test then

			local status = player and player.status
			local in_combat = player and player.in_combat
			local target = get_mob_by_target('st','t')
			local has_target = target and target.id ~= player.id and true or false

			if fade_delay > 0 and status ~= 1 and not (in_combat or has_target) then

				fade_delay = fade_delay -1

			elseif fade_delay == 0 then

				Fade = true
				fade_delay = -1

				--Update to remove formatting from text
				updateHPBar(player)
				updateTPBar(player)
				updateMPBar(player)

				--Turn Pulse off
				Pulse_HP = false
				Pulse_MP = false
				Pulse_TP = false
				Pulse_Pet = false
				Pulse_Focus_Target_Bar = false
				Pulse_Focus_Target_Name = false
				Pulse_Sub_Target_Bar = false
				Pulse_Sub_Target_Name = false
				Pulse_Target_Bar = false
				Pulse_Target_Name = false
				player_stats_hp_bar_pulse:bg_alpha(0)
				player_stats_mp_bar_pulse:bg_alpha(0)
				player_stats_tp_bar_pulse:bg_alpha(0)
				player_stats_pet_bar_pulse:bg_alpha(0)
				focus_target_bar_pulse:bg_alpha(0)
				sub_target_bar_pulse:bg_alpha(0)
				target_bar_pulse:bg_alpha(0)

			end
		end

		local party_info = get_party_info()
		
		--Adjust Party Action positioning if the party/alliance changes
		if Screen_Test then
			updatePartyActionsPos(6,6,6)

		elseif not Screen_Test
		or num_party1_members ~= party_info.party1_count
		or num_party2_members ~= party_info.party2_count
		or num_party3_members ~= party_info.party3_count then

			num_party1_members = party_info.party1_count
			num_party2_members = party_info.party2_count
			num_party3_members = party_info.party3_count
			updatePartyActionsPos(num_party1_members,num_party2_members,num_party3_members)

		end

	end

	--Fade away (but not if the Screen Test is active)
	if Fade and not Screen_Test then
		if fade_bg_num > fade_down_to_alpha then
			fade_bg_num = fade_bg_num - fade_speed
			setBarFade(fade_bg_num, player, pet)
		elseif fade_bg_num <= fade_down_to_alpha then
			fade_bg_num = fade_down_to_alpha
			setBarFade(fade_bg_num, player, pet)
		end
		if fade_text_num > (fade_down_to_alpha + fade_speed) then
			fade_text_num = fade_text_num - fade_speed
			setTextFade(fade_text_num)
		elseif fade_text_num <= fade_down_to_alpha then
			fade_text_num = fade_down_to_alpha
			setTextFade(fade_text_num)
		end
		if fade_icon_num > (fade_down_to_alpha + fade_speed) then
			fade_icon_num = fade_icon_num - fade_speed
			setIconFade(fade_icon_num)
		elseif fade_icon_num <= fade_down_to_alpha then
			fade_icon_num = fade_down_to_alpha
			setIconFade(fade_icon_num)
		end
		if fade_bg_ui_num > (fade_down_to_alpha + fade_speed) then
			fade_bg_ui_num = fade_bg_ui_num - fade_speed
			setBGUIFade(fade_bg_ui_num)
		elseif fade_bg_ui_num <= fade_down_to_alpha then
			fade_bg_ui_num = fade_down_to_alpha
			setBGUIFade(fade_bg_ui_num)
		end
	end

end)

register_event('action', function (act)
	local msg = act.targets[1].actions[1].message
	local aoe_main_target_messages = {
		2,7,14,67,75,83,85,102,103,110,116,127,131,134,141,148,150,156,185,186,187,188,189,194,197,
		224,225,226,227,228,230,231,236,237,238,242,243,252,268,271,274,275,306,317,318,319,320,321,322,323,324,
		341,342,362,373,375,379,408,412,413,435,441,570,645,658
	}
	local player = get_player()
	local actor = get_mob_by_id(act.actor_id)
	local target_count = act.target_count
	local action_id = act.targets[1].actions[1].param
	local action_target_id = act.targets[1].id
	monster_target_icon = settings.icons.monster_target
	if target_count > 1 then
		local main_target_found = false
		for i = 1, target_count do
			local message = act.targets[i].actions[1].message
			if checkForMessage(aoe_main_target_messages,message) then
				action_target_id = act.targets[i].id
				main_target_found = true
				break
			end
		end
		--If the attack was AOE, but we did not find a "main target" type message, we assume then its a mob who's melee attacks are AOE
		--In that case, the 1st target in the table may not be the actual target, as the list seems to be sorted by id
		--So, we fall back to checking who the target is looking at (credit: enemybar2)
		if not main_target_found then
			local function looking_at(a, b)
				if not a or not b then return false end
				local h = a.facing % math.pi
				local h2 = (math.atan2(a.x-b.x,a.y-b.y) + math.pi/2) % math.pi
				return math.abs(h-h2) < 0.05
			end
			for _,v in pairs(get_mob_array()) do
				local distance = math.floor(v.distance:sqrt())
				if v.valid_target and distance < 50 and not isMonster(v.id) and looking_at(actor,v) then
					action_target_id = v.id
				end
			end
			monster_target_icon = settings.icons.monster_target_aoe
		end
	end
	if not action_target_id then return end
	local action_target = get_mob_by_id(action_target_id)
	local action_name = ''
	local action_name_shdw = ''
	local ct = targetColor(player, action_target)
	local ct_r = formatRGB(ct.r)
	local ct_g = formatRGB(ct.g)
	local ct_b = formatRGB(ct.b)
	local truncated_name = action_target and truncateName(action_target.name) or ''
	local action_target_name = ' '..targeting_icon..' \\cs('..ct_r..','..ct_g..','..ct_b..')'..truncated_name..'\\cr' or ''
	local action_target_name_shdw = ' '..targeting_icon..' \\cs(000,000,000)'..truncated_name..'\\cr' or ''
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
	local nm_auto_tp = monster_abil[act.param] and monster_abil[act.param].en and (string.find(monster_abil[act.param].en,'Autoattack') or string.find(monster_abil[act.param].en,'Auto Attack') or string.find(monster_abil[act.param].en,'Ranged') or string.find(monster_abil[act.param].en,'Vulture') or string.find(monster_abil[act.param].en,'Sabotender')) and true or false
	local amount = addCommas(act.targets[1].actions[1].param)
	local count = show_result_totals and target_count > 1 and target_count..num_hit_icon or ''

	local rdc_r = formatRGB(color.result.damage.r)
	local rdc_g = formatRGB(color.result.damage.g)
	local rdc_b = formatRGB(color.result.damage.b)
	local rhc_r = formatRGB(color.result.heal.r)
	local rhc_g = formatRGB(color.result.heal.g)
	local rhc_b = formatRGB(color.result.heal.b)

	function calculateInfo(act)
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
		local info = {
			landed = landed,
			cure_total = cure_total,
			amount_total = amount_total,
			last_buff_id = last_buff_id,
			damage = damage,
		}
		return info
	end

	--If a target is doing an action (except having an action interupted), remove Sleep/Petrify debuff
	if act.param ~= 28787 and current_debuffs[act.actor_id] then
		current_debuffs[act.actor_id][2] = nil
		current_debuffs[act.actor_id][7] = nil
		current_debuffs[act.actor_id][19] = nil
	end

	--Update monster targeting
	if (isMonster(act.actor_id) and not isMonster(action_target_id)) then --monster targets a player
		local timestamp = os.time() + monster_target_confidence_timer
		updateTargeting(act.actor_id, action_target_id, timestamp, monster_target_icon)
	elseif not isMonster(act.actor_id) and isMonster(action_target_id) then --player targets a monster...
		local timestamp = os.time() + monster_target_confidence_timer
		for i = 1, target_count do
			if not current_aggro_list[act.targets[i].id] then --...that is not already targeting a player
				updateTargeting(act.targets[i].id, act.actor_id, timestamp, monster_target_icon)
			end
		end
	end

	--Ignore regular melee and ranged attacks
	if msg == 1 or msg == 15 or msg == 373 or msg == 352 or msg == 353 or msg == 354 or msg == 382 or not actor then
		return
	end

	--Debug Stuff
	-- if (act.category == 4 or act.category == 8) and actor.name ~= player.name then
	-- if actor.name == player.name and act.category ~= 1 then
	-- 	print(get_mob_by_id(act.actor_id).name.." - category: "..act.category.." a.param: "..act.param.." a.t.a.param: "..act.targets[1].actions[1].param.." message: "..msg.." target: "..get_mob_by_id(action_target_id).name.." add_eff_param: "..act.targets[1].actions[1].add_effect_param)
	-- 	add_to_chat(1, get_mob_by_id(act.actor_id).name.." - category: "..act.category.." a.param: "..act.param.." a.t.a.param: "..act.targets[1].actions[1].param.." message: "..msg.." target: "..get_mob_by_id(action_target_id).name.." add_eff_param: "..act.targets[1].actions[1].add_effect_param)
	-- end

	--Action failed/interrupted
	if (act.param == 28787 or msg == 78) and not (not isPlayer(actor.id) and nm_auto_tp) and not ((act.category == 7 or act.category == 9) and msg == 0) then

		local trackingIndex = assignIndex()
		local target_action_status = '\\cs(255,050,050)'..cancelled_icon..'\\cr'
		local target_action_status_shdw = '\\cs(000,000,000)'..cancelled_icon..'\\cr'

		if msg == 78 then
			target_action_result = ' (Too Far!)'
			target_action_result_shdw = ' (Too Far!)'
		end

		actionInterrupted(act.actor_id,target_action_status,target_action_status_shdw,target_action_result,target_action_result_shdw,trackingIndex)

		if player.id == act.actor_id and msg ~= 246 then
			self_action_bar_meter:bg_color(255,050,050)
			completeSelfMeter()
		end

		coroutine.schedule(function()
			removeFromActionsTable(act.actor_id, trackingIndex)
		end, clear_action_delay)

		return

	end

	--Begin weapon skill(7), TP move(7), or spell(8), or item(9)
	if action_id and (act.category == 7 or act.category == 8 or act.category == 9) then

		local target_action_status = '\\cs(245,164,066)'..casting_icon..'\\cr'
		local target_action_status_shdw = '\\cs(000,000,000)'..casting_icon..'\\cr'

		--Weapon skill or TP move
		if act.category == 7 then

			local c = targetColor(player, action_target)
			local r = formatRGB(c.r)
			local g = formatRGB(c.g)
			local b = formatRGB(c.b)
			action_target_name = action_target and action_target_id ~= act.actor_id and ' '..targeting_icon..' \\cs('..r..','..g..','..b..')'..truncateName(action_target.name)..'\\cr' or ''
			action_target_name_shdw = action_target and action_target_id ~= act.actor_id and ' '..targeting_icon..' \\cs(000,000,000)'..truncateName(action_target.name)..'\\cr' or ''

			--Players
			if isPlayer(actor.id) then
				action_name = wep_skill[action_id] and ' '..truncateAction(wep_skill[action_id].name) or ' [REDACTED]'
				action_name_shdw = wep_skill[action_id] and ' '..truncateAction(wep_skill[action_id].name) or ' [REDACTED]'

			--Certain NMs regular melee attacks are actually TP moves
			elseif act.targets[1].actions[1].param == nil then
				return

			--Pets (& Synergy Furnaces)
			elseif actor and actor.spawn_type == 2 then
			-- elseif get_mob_by_id(actor.id) and get_mob_by_id(actor.id).spawn_type == 2 then
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
			local c = colorize_spells and element_colors[element] or text_color
			local r = formatRGB(c.r)
			local g = formatRGB(c.g)
			local b = formatRGB(c.b)
			action_name = spell[action_id] and ' \\cs('..r..','..g..','..b..')'..truncateAction(spell[action_id].name)..'\\cr' or ' [REDACTED]'
			action_name_shdw = spell[action_id] and ' \\cs(000,000,000)'..truncateAction(spell[action_id].name)..'\\cr' or ' [REDACTED]'
			cast_time = spell[action_id].cast_time
			--If a target starts casting, remove Silence debuff
			if current_debuffs[act.actor_id] and act.param ~= 28787 then
				current_debuffs[act.actor_id][6] = nil
			end

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
				self_action_bar_meter:bg_color(color.self.bar.r,color.self.bar.g,color.self.bar.b)
				updateSelfBar(player, cast_time,trackingIndex)
				resetFadeDelay()
			end

			--In case of lag and we don't receive the "finished" action, we remove the action after a long enough wait to be sure
			coroutine.schedule(function()
				removeFromActionsTable(act.actor_id, trackingIndex)
			end, cast_time + clear_action_delay + 5)

		end

	--Job abilities
	elseif (
		act.category == 3
		and (
			msg == 110 or msg == 102 or msg == 122 or msg == 125 or msg == 129 or msg == 153 or msg == 244 or msg == 306 or msg == 318 or msg == 321 or msg == 322 or msg == 453 or msg == 593 or msg == 594 or msg == 595 or msg == 596 or msg == 597 or msg == 598 or msg == 599 or msg == 608 or msg == 736 or msg == 746 or msg == 127 or msg == 141 or msg == 645 or msg == 319 or msg == 320 or msg == 441 or msg == 602
			or msg == 156 or msg == 323 or msg == 30 or msg == 31 or msg == 32 or msg == 158 or msg == 324 or msg == 658
		)
	)
	or act.category == 6 or act.category == 14 or act.category == 15 then

		local target_action = ''
		local target_action_shdw = ''
		local target_action_status = '\\cs(050,255,050)'..completed_icon..'\\cr'
		local target_action_status_shdw = '\\cs(000,000,000)'..completed_icon..'\\cr'
		local abil_id = act.param
		local abil_name = ''
		if act.category == 6 and actor.spawn_type == 16 then
		 	abil_name = monster_abil[abil_id] and monster_abil[abil_id].name or '[REDACTED]'
		elseif act.category == 3 and actor.spawn_type == 16 then
		 	abil_name = wep_skill[abil_id] and wep_skill[abil_id].name or '[REDACTED]'
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
				count = show_result_totals and target_count > 1 and landed..(landed < target_count and '/'..target_count or '')..num_hit_icon or ''
				local buff_name = (action_id == 0 or action_id == 232) and job_abil[act.param] and capitalize(job_abil[act.param].name) or buff[act.targets[1].actions[1].param] and capitalize(buff[act.targets[1].actions[1].param].name)
				target_action_result = ' ('..count..buff_name..')'
				target_action_result_shdw = ' ('..count..buff_name..')'
			end

		--Absorbed - job abilities
		elseif (act.category == 3 or act.category == 6 or act.category == 14) and (msg == 102 or msg == 122 or msg == 306 or msg == 318) then
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr)'
		--Most direct damage abilities
		elseif act.category == 3 and msg == 110 then
			target_action_result = ' (\\cs('..rdc_r..','..rdc_g..','..rdc_b..')'..amount..'\\cr)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr)'
		--No Effect
		elseif act.category == 3 and (msg == 156 or msg == 323) then
			target_action_result = ' ('..count..'No Effect)'
			target_action_result_shdw = ' ('..count..'No Effect)'
		--Anticipated
		elseif act.category == 3 and msg == 30 then
			target_action_result = ' ('..count..'Anticipated)'
			target_action_result_shdw = ' ('..count..'Anticipated)'
		--Blinked
		elseif act.category == 3 and msg == 31 then
			target_action_result = ' ('..count..'Blinked)'
			target_action_result_shdw = ' ('..count..'Blinked)'
		--Dodged
		elseif act.category == 3 and msg == 32 then
			target_action_result = ' ('..count..'Dodged)'
			target_action_result_shdw = ' ('..count..'Dodged)'
		--Missed
		elseif act.category == 3 and (msg == 158 or msg == 324 or msg == 658) then
			target_action_result = ' ('..count..'Missed)'
			target_action_result_shdw = ' ('..count..'Missed)'
		--Buff/Debuff
		elseif msg == 127 or msg == 141 or msg == 645 or msg == 319 or msg == 320 or msg == 441 or msg == 602 then
			local landed = calculateInfo(act).landed
			count = show_result_totals and target_count > 1 and landed..(landed < target_count and '/'..target_count or '')..num_hit_icon or ''
			local buff_name = (action_id == 0 or action_id == 232) and job_abil[act.param] and capitalize(job_abil[act.param].name) or buff[act.targets[1].actions[1].param] and capitalize(buff[act.targets[1].actions[1].param].name)
			target_action_result = ' ('..count..buff_name..')'
			target_action_result_shdw = ' ('..count..buff_name..')'

		--Mug Success + HP
		elseif msg == 129 and act.targets[1].actions[1].has_add_effect then
			local hp_drain = act.targets[1].actions[1].add_effect_param
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr Gil + \\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..hp_drain..'\\cr HP)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr Gil + \\cs(000,000,000)'..hp_drain..'\\cr HP)'
		--Mug Success
		elseif msg == 129 then
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr Gil)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..amount..'\\cr Gil)'
		--Mug Fail
		elseif msg == 244 then
			target_action_result = ' (Failed)'
			target_action_result_shdw = ' (Failed)'
		--Mug Fail + HP Drain
		elseif msg == 736 then
			target_action_result = ' (Failed + \\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr HP)'
			target_action_result_shdw = ' (Failed + \\cs(000,000,000)'..amount..'\\cr HP)'
		--Steal Success
		elseif msg == 125 then
			local item = item[action_id].name
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..item..'\\cr)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..item..'\\cr)'
		--Aura Steal Absorb
		elseif msg == 453 then
			local aura = buff[action_id].name
			local stolen_sp = sp_abils[aura]
			if stolen_sp then --if the ability stolen was an SP ability, cancel it for that mob
				removeFromSPTable(act.targets[1].id)
			end
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..aura..'\\cr)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..aura..'\\cr)'
		--Aura Steal Dispel
		elseif msg == 321 or msg == 322 then
			local aura = buff[action_id].name
			target_action_result = ' ('..aura..')'
			target_action_result_shdw = ' ('..aura..')'
		--Despoil Success + Attack Down
		elseif msg == 593 then
			local item = item[action_id].name
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..item..'\\cr + Att Down)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..item..'\\cr + Att Down)'
		--Despoil Success + Defense Down
		elseif msg == 594 then
			local item = item[action_id].name
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..item..'\\cr + Def Down)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..item..'\\cr + Def Down)'
		--Despoil Success + Magic Attack Down
		elseif msg == 595 then
			local item = item[action_id].name
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..item..'\\cr + MAtt Down)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..item..'\\cr + MAtt Down)'
		--Despoil Success + Magic Defense Down
		elseif msg == 596 then
			local item = item[action_id].name
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..item..'\\cr + MDef Down)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..item..'\\cr + MDef Down)'
		--Despoil Success + Evasion Down
		elseif msg == 597 then
			local item = item[action_id].name
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..item..'\\cr + Eva Down)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..item..'\\cr + Eva Down)'
		--Despoil Success + Accuracy Down
		elseif msg == 598 then
			local item = item[action_id].name
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..item..'\\cr + Acc Down)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..item..'\\cr + Acc Down)'
		--Despoil Success + Slow
		elseif msg == 599 then
			local item = item[action_id].name
			target_action_result = ' (\\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..item..'\\cr + Slow)'
			target_action_result_shdw = ' (\\cs(000,000,000)'..item..'\\cr + Slow)'
		--Steal/Despoil Fail
		elseif msg == 153 then
			target_action_result = ' (Failed)'
			target_action_result_shdw = ' (Failed)'
		--Bounty Shot Success
		elseif msg == 608 then
			target_action_result = ' (TH: \\cs('..rhc_r..','..rhc_g..','..rhc_b..')'..amount..'\\cr)'
			target_action_result_shdw = ' (TH: \\cs(000,000,000)'..amount..'\\cr)'
		--Evaded/No Effect/Resisted/Immunobreak/Anticipated/Blinked/Dodged/Missed
		elseif msg == 282 or msg == 75 or msg == 156 or msg == 189 or msg == 248 or msg == 283 or msg == 323 or msg == 355 or msg == 408 or msg == 422 or msg == 423 or msg == 425 or msg == 659 or msg == 114 or msg == 85 or msg == 284 or msg == 653 or msg == 654 or msg == 655 or msg == 656 or msg == 30 or msg == 31 or msg == 32 or msg == 15 or msg == 63 or msg == 158 or msg == 188 or msg == 245 or msg == 324 or msg == 658 then
			local info = calculateInfo(act)
			local landed = info.landed
			local last_buff_id = info.last_buff_id
			local buff_name = last_buff_id and buff[last_buff_id] and capitalize(buff[last_buff_id].name)
			local damage = info.damage
			if buff_name then
				--redo count to show how many landed out of the total target_count
				count = show_result_totals and target_count > 1 and landed..'/'..target_count..num_hit_icon or ''
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
					count = show_result_totals and target_count > 1 and landed..'/'..target_count..num_hit_icon or ''
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
			elseif msg == 127 or msg == 141 or msg == 645 or msg == 319 or msg == 320 or msg == 441 or msg == 602 then
				local landed = calculateInfo(act).landed
				count = show_result_totals and target_count > 1 and landed..(landed < target_count and '/'..target_count or '')..num_hit_icon or ''
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

			if abil_name ~= "[REDACTED]" then
				--check if the ability used was an SP ability
				local sp_abil = sp_abils[abil_name]
				if sp_abil then
					addToSPTable(act.actor_id, abil_name)

				--If Benediction is used, remove all debuffs from all targets it hits
				elseif abil_name == "Benediction" then
					for i = 1, target_count do
						current_debuffs[act.targets[i].id] = nil
					end
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
				count = show_result_totals and target_count > 1 and landed..(landed < target_count and '/'..target_count or '')..num_hit_icon or ''
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
					count = show_result_totals and target_count > 1 and landed..'/'..target_count..num_hit_icon or ''
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
				self_action_bar_meter:bg_color(050,255,050)
				completeSelfMeter()
			end

			coroutine.schedule(function()
				removeFromActionsTable(act.actor_id, trackingIndex)
			end, clear_action_delay)

		end

	--Finish weapon skill(3), spell(4), item(5), or Pet TP move(13)
	elseif act.category == 3 or act.category == 5 or act.category == 13 or (act.category == 4 and not ((msg == 0 or msg == 29 or msg == 84 or msg == 106) and act.param == 0)) then

		local trackingIndex = assignIndex()
		local target_action_status = '\\cs(050,255,050)'..completed_icon..'\\cr'
		local target_action_status_shdw = '\\cs(000,000,000)'..completed_icon..'\\cr'
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
				if msg == 100 or msg == 317 or msg == 318 or msg == 324 then
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
				count = show_result_totals and target_count > 1 and ' '..landed..(landed < target_count and '/'..target_count or '')..num_hit_icon or ''
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
					count = show_result_totals and target_count > 1 and landed..'/'..target_count..num_hit_icon or ''
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
			local c = colorize_spells and element_colors[element] or text_color
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
				count = show_result_totals and target_count > 1 and ' '..landed..(landed < target_count and '/'..target_count or '')..num_hit_icon or ''
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
				count = show_result_totals and target_count > 1 and landed..(landed < target_count and '/'..target_count or '')..num_hit_icon or ''
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
					count = show_result_totals and target_count > 1 and landed..'/'..target_count..num_hit_icon or ''
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
				count = show_result_totals and target_count > 1 and landed..(landed < target_count and '/'..target_count or '')..num_hit_icon or ''
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
					count = show_result_totals and target_count > 1 and landed..'/'..target_count..num_hit_icon or ''
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
				count = show_result_totals and target_count > 1 and ' '..landed..(landed < target_count and '/'..target_count or '')..num_hit_icon or ''
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
				count = show_result_totals and target_count > 1 and landed..(landed < target_count and '/'..target_count or '')..num_hit_icon or ''
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
					count = show_result_totals and target_count > 1 and landed..'/'..target_count..num_hit_icon or ''
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
			--MAB/MDB
			elseif msg == 414 then
				target_action_result = ' ('..count..'MAB/MDB)'
				target_action_result_shdw = ' ('..count..'MAB/MDB)'
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
		if get_mob_by_id(act.actor_id) and get_mob_by_id(player.id) and get_mob_by_id(act.actor_id).index == get_mob_by_id(player.id).pet_index then

			self_action_bar_meter:bg_color(050,255,050)
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
				self_action_bar_meter:bg_color(050,255,050)
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

		local target_action_status = '\\cs(050,255,050)'..completed_icon..'\\cr'
		local target_action_status_shdw = '\\cs(000,000,000)'..completed_icon..'\\cr'
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
			count = show_result_totals and target_count > 1 and landed..(landed < target_count and '/'..target_count or '')..num_hit_icon or ''
			target_action_result = ' ('..count..buff_name..')'
			target_action_result_shdw = ' ('..count..buff_name..')'
		--Plain Damage
		elseif msg == 185 then
			local info = calculateInfo(act)
			local landed = info.landed
			local amount_total = show_result_totals and target_count > 1 and not info.last_buff_id and addCommas(info.amount_total) or ''
			count = show_result_totals and target_count > 1 and ' '..landed..(landed < target_count and '/'..target_count or '')..num_hit_icon or ''
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
				count = show_result_totals and target_count > 1 and landed..'/'..target_count..num_hit_icon or ''
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

		if abil_name ~= "[REDACTED]" then

			--Check if the ability used was an SP ability
			local sp_abil = sp_abils[abil_name]
			if sp_abil then
				addToSPTable(act.actor_id, abil_name)

			--If specific moves are used, remove all debuffs from all targets it hits
			elseif remove_all_debuffs:contains(abil_name) then
				for i = 1, target_count do
					current_debuffs[act.targets[i].id] = nil
				end
			end

		end

	end
end)

function handleOverwrites(target_id, new_spell_id)

	--Over 9000 special case spells (Impact, boosted versions of Dia, Bio, Burn, etc.)
	new_spell_id = new_spell_id > 9000 and new_spell_id - 9000 or new_spell_id

	--If the target has no current debuffs, return true so the new debuff gets saved
	if not current_debuffs[target_id] then
		return true
	end

	--Loop through all debuffs the target currently has
	for effect_id, spell in pairs(current_debuffs[target_id]) do
		--Over 9000 special case spells (Impact, boosted versions of Dia, Bio, Burn, etc.)
		local old_spell_id = spell and spell.id and spell.id > 9000 and spell.id - 9000 or (spell and spell.id)
		if old_spell_id == 503 then return false end --Impact does not overwrite itself
		local old_debuff_overwrites = old_spell_id and res.spells[old_spell_id] and res.spells[old_spell_id].overwrites or {}

		--Check if there is a higher priority debuff already active
		if table.length(old_debuff_overwrites) > 0 then
			for _,v in ipairs(old_debuff_overwrites) do
				if new_spell_id == v then
					--If there is, return false so that the previous debuff is not overwritten
					return false
				end
			end
		end

		--Check if a lower priority debuff is being overwritten
		local new_debuff_overwrites = res.spells[new_spell_id] and res.spells[new_spell_id].overwrites or {}
		if table.length(new_debuff_overwrites) > 0 then
			for _,v in ipairs(new_debuff_overwrites) do
				if old_spell_id == v then
					--If there is, clear the previous debuff
					current_debuffs[target_id][effect_id] = nil
				end
			end
		end
	end
	--Retrun true to continue to saving the new debuff
	return true

end

--Remove a debuff from a monster if the specific debuff is still present
function removeDebuff(target_id, effect_id, index)
	if current_debuffs[target_id]
	and current_debuffs[target_id][effect_id]
	and current_debuffs[target_id][effect_id].index == index then
		current_debuffs[target_id][effect_id] = nil
	end
end

--Save debuff to current_debuffs table
function saveDebuff(actor_id, target_id, effect_id, spell_id)

	--Make sure the effect numbers we're getting are within the correct range
	if not ((effect_id >= 1 and effect_id <= 634) or effect_id >= 9000) then return end

	--Create target table if it doesn't already exist
	if not current_debuffs[target_id] then
		current_debuffs[target_id] = {}
	end

	local actor = get_mob_by_id(actor_id)
	if not actor then return end
	local actor_name = actor and actor.name
	local duration = res.spells[spell_id] and res.spells[spell_id].duration or 0
	local removal_timer = debuff_duration_cap
	local trackingIndex = assignIndex()
	local check_override = true

	--Determine if this effect is a Daze and set duration accordingly
	local daze_durations = {
		[1] = 60,
		[2] = 90,
		[3] = 120,
		[4] = 120,
		[5] = 120,
		[6] = 120,
		[7] = 120,
		[8] = 120,
		[9] = 120,
		[10] = 120,
	}
	local daze_levels = {
		[386] = 1, [387] = 2, [388] = 3, [389] = 4, [390] = 5, --Lethargic Daze
		[391] = 1, [392] = 2, [393] = 3, [394] = 4, [395] = 5, --Sluggish Daze
		[396] = 1, [397] = 2, [398] = 3, [399] = 4, [400] = 5, --Weakened Daze
		[448] = 1, [449] = 2, [450] = 3, [451] = 4, [452] = 5, --Bewildered Daze
	}

	--Match the effect with daze level
	local level = daze_levels[effect_id]
	if level then
		duration = daze_durations[level]
	end

	--Shadowbind
	if effect_id == 11 and spell_id == 57 then
		local base_duration = 30
		local max_duration = 62
		local bonus = durations_data[server] and durations_data[server][actor_name] and durations_data[server][actor_name]["Shadowbind"] or nil
		duration = bonus and base_duration + bonus or base_duration
		removal_timer = bonus and duration or max_duration
	--Bully
	elseif effect_id == 22 and spell_id == 321 then
		check_override = false
		duration = 30 --lasts only 30 seconds
		removal_timer = duration
	--Angon
	elseif (effect_id == 149 or effect_id == 558) and spell_id == 170 then
		local base_duration = 30
		local max_duration = 90
		local bonus = durations_data[server] and durations_data[server][actor_name] and durations_data[server][actor_name]["Angon"]or nil
		duration = bonus and base_duration + bonus or base_duration
		removal_timer = bonus and duration or max_duration
	--Chainbound
	elseif effect_id == 164 then
		check_override = false
		duration = 9 --lasts a maximum of 9 seconds
		removal_timer = duration
	--Tomahawk
	elseif effect_id == 232 then
		check_override = false
		local base_duration = 30
		local max_duration = 90
		local bonus = durations_data[server] and durations_data[server][actor_name] and durations_data[server][actor_name]["Tomahawk"] or nil
		duration = bonus and base_duration + bonus or base_duration
		removal_timer = bonus and duration or max_duration
	--Sepulcher
	elseif effect_id == 463 then
		check_override = false
		local base_duration = 180
		local max_duration = 200
		local bonus = durations_data[server] and durations_data[server][actor_name] and durations_data[server][actor_name]["Sepulcher"] or nil
		duration = bonus and base_duration + bonus or base_duration
		removal_timer = bonus and duration or max_duration
	--Arcane Crest
	elseif effect_id == 464 then
		check_override = false
		local base_duration = 180
		local max_duration = 200
		local bonus = durations_data[server] and durations_data[server][actor_name] and durations_data[server][actor_name]["Arcane Crest"] or nil
		duration = bonus and base_duration + bonus or base_duration
		removal_timer = bonus and duration or max_duration
	--Hamanoha
	elseif effect_id == 465 then
		check_override = false
		local base_duration = 180
		local max_duration = 200
		local bonus = durations_data[server] and durations_data[server][actor_name] and durations_data[server][actor_name]["Hamanoha"] or nil
		duration = bonus and base_duration + bonus or base_duration
		removal_timer = bonus and duration or max_duration
	--Dragon Breaker
	elseif effect_id == 466 then
		check_override = false
		local base_duration = 180
		local max_duration = 200
		local bonus = durations_data[server] and durations_data[server][actor_name] and durations_data[server][actor_name]["Dragon Breaker"] or nil
		duration = bonus and base_duration + bonus or base_duration
		removal_timer = bonus and duration or max_duration
	--Intervene/Odyllic Subterfuge
	elseif effect_id == 496 or effect_id == 509 then
		check_override = false
		duration = 30 --lasts only 30 seconds
		removal_timer = duration
	--Gambit
	elseif effect_id == 536 then
		check_override = false
		local base_duration = 60
		local max_duration = 96
		local bonus = durations_data[server] and durations_data[server][actor_name] and durations_data[server][actor_name]["Gambit"] or nil
		duration = bonus and base_duration + bonus or base_duration
		removal_timer = bonus and duration or max_duration
	--Rayke
	elseif effect_id == 571 then
		check_override = false
		local base_duration = 30
		local max_duration = 50
		local bonus = durations_data[server] and durations_data[server][actor_name] and durations_data[server][actor_name]["Rayke"] or nil
		duration = bonus and base_duration + bonus or base_duration
		removal_timer = bonus and duration or max_duration
	--Cait Sith Amnesia (Eerie Eye)
	elseif spell_id == 523 then
		duration = 15
		removal_timer = duration
	--Leviathan Attack Down (Tidal Roar)
	elseif spell_id == 585 then
		duration = 90
		removal_timer = duration
	--Shiva Sleepga
	elseif spell_id == 611 then
		spell_id = 273
		duration = 90
		removal_timer = duration
	--Shiva Evasion Down (Diamond Storm)
	elseif spell_id == 617 then
		duration = 180
		removal_timer = duration
	--Siren Elegy
	elseif spell_id == 966 then
		spell_id = 422
		duration = 180
		removal_timer = duration
	--Enfeebling Magic
	elseif res.spells[spell_id] and res.spells[spell_id].skill == 35 then
		local base_duration = duration
		local max_duration = debuff_duration_cap
		local bonus = durations_data[server] and durations_data[server][actor_name] and durations_data[server][actor_name]["Enfeebling Magic"] and durations_data[server][actor_name]["Enfeebling Magic"] / 100 or nil
		duration = bonus and base_duration + (base_duration * bonus) or base_duration
		removal_timer = bonus and duration or max_duration
	--Singing
	elseif res.spells[spell_id] and res.spells[spell_id].skill == 40 then
		--Threnodies override eachother (at this point they've already landed so we can ignore tiers)
		if effect_id == 217 and current_debuffs[target_id][217] then
			current_debuffs[target_id][217] = nil
		end
		--Lullaby fixes (incorrect durations in res\spells.lua)
		if spell_id == 376 or spell_id == 463 then --Foe I/II
			duration = 30
		elseif spell_id == 377 or spell_id == 471 then --Horde I/II
			duration = 60
		end
		local base_duration = duration
		local max_duration = debuff_duration_cap
		local bonus = durations_data[server] and durations_data[server][actor_name] and durations_data[server][actor_name]["Singing"] and durations_data[server][actor_name]["Singing"] / 100 or nil
		duration = bonus and base_duration + (base_duration * bonus) or base_duration
		removal_timer = bonus and duration or max_duration
	--Blue Magic spells get no duration bonuses, so we remove them right at the duration length
	elseif res.spells[spell_id] and res.spells[spell_id].skill == 43 then
		removal_timer = duration
	--Comet/Firaja/Blizzaja/Aeroja/Stoneja/Thundaja/Waterja (Cumulative Magic)
	elseif T{9219,9496,9497,9498,9499,9500,9501}:contains(effect_id) then
		local base_duration = 60
		local bonus = durations_data[server] and durations_data[server][actor_name] and durations_data[server][actor_name]["Cumulative Spells"] or nil
		duration = bonus and base_duration + bonus or base_duration
		removal_timer = duration
	--Impact
	elseif effect_id == 9503 then
		-- check_override = false
		duration = 180
		removal_timer = duration
	end

	--Check for spells that overwrite a current debuff
	if check_override and not handleOverwrites(target_id, spell_id) then
		--If there is a higher priority buff already active, do not save the new debuff
		return
	end

	--Set timer to remove the specific debuff
	coroutine.schedule(function()
		removeDebuff(target_id, effect_id, trackingIndex)
	end, removal_timer)

	--Addle overwrites Nocturne
	if effect_id == 21 and current_debuffs[target_id][223] then
		current_debuffs[target_id][223] = nil
	end

	--Get target position if slept, bound, or petrified so we can later determine if it wears off
	if effect_id == 2 or effect_id == 7 or effect_id == 11 or effect_id == 19 then
		local target_data = get_mob_by_id(target_id)
		current_debuffs[target_id].pos = {
			x = target_data.x,
			y = target_data.y,
		}
	end

	--Save debuff data to the current_debuffs table
	--target_id = id of the target (monster)
	--effect_id = id of the debuff/status
	current_debuffs[target_id][effect_id] = {
		id = spell_id, --id of the spell that was cast
		timer = os.clock() + duration, --expiration time
		index = trackingIndex, --Unique ID for this debuff
	}

end

function handleAction(act)

	local actor_id = act.actor_id
	local main_target_id = act.targets[1].id

	--Ignore if target is not a monster, or if the actor is a monster
	if not isMonster(main_target_id) or isMonster(actor_id) then return end

	local spell_id = act.param
	local target_count = act.target_count
	local shot_boosts = {
		[131] = { --Light Shot -> Dia
			effect_id = 134,
			spell_map = {[23] = 9023, [24] = 9024, [25] = 9025}
		},
		[132] = { --Dark Shot -> Bio
			effect_id = 135,
			spell_map = {[230] = 9230, [231] = 9231, [232] = 9232}
		},
		[125] = {effect_id = 128, spell_map = {[235] = 9235}}, --Fire Shot		-> Burn
		[126] = {effect_id = 129, spell_map = {[236] = 9236}}, --Ice Shot		-> Frost
		[127] = {effect_id = 130, spell_map = {[237] = 9237}}, --Wind Shot		-> Choke
		[128] = {effect_id = 131, spell_map = {[238] = 9238}}, --Earth Shot		-> Rasp
		[129] = {effect_id = 132, spell_map = {[239] = 9239}}, --Thunder Shot	-> Shock
		[130] = {effect_id = 133, spell_map = {[240] = 9240}}, --Water Shot		-> Drown
	}
	for i = 1, target_count do

		local target_id = act.targets[i].id
		local message_id = act.targets[i].actions[1].message

		--Spells that include a debuff
		if act.category == 4 then

			--Spell messages to look for
			local damaging_spell_messages = S{2,7,252,264,265}
			local debuff_spell_messages = S{203,236,237,267,268,269,270,271,272,277,278,279}

			--Damaging spells
			if damaging_spell_messages:contains(message_id) then
				local effect_id = res.spells[spell_id] and res.spells[spell_id].status
				--Diaga
				if spell_id == 23 or spell_id == 33 then
					spell_id = 23 --Diaga (33) puts Dia (23/134) on each target
					effect_id = 134
				--Comet/Firaja/Blizzaja/Aeroja/Stoneja/Thundaja/Waterja (Cumulative Magic)
				elseif T{219,496,497,498,499,500,501}:contains(spell_id) then
					local ja_spell = spell_id + 9000
					--If a Cumulative Magic boost of the same element already exists, bump it up a tier
					if current_debuffs[target_id] and current_debuffs[target_id][ja_spell] then
						local current = current_debuffs[target_id][ja_spell]
						current.id = current.id + 1000 --Add 1000 to go up a tier
					--Otherwise, add the new one
					else
						effect_id = ja_spell
						spell_id = ja_spell
						--Remove boosts of other elements before applying the new one
						if current_debuffs[target_id] then
							current_debuffs[target_id][9219] = nil
							current_debuffs[target_id][9496] = nil
							current_debuffs[target_id][9497] = nil
							current_debuffs[target_id][9498] = nil
							current_debuffs[target_id][9499] = nil
							current_debuffs[target_id][9500] = nil
							current_debuffs[target_id][9501] = nil
						end
					end
				--Impact
				elseif spell_id == 503 then
					effect_id = 9503
				end
				if effect_id then
					saveDebuff(actor_id, target_id, effect_id, spell_id)
				end

			--Debuff spells
			elseif debuff_spell_messages:contains(message_id) then
				local effect_id = act.targets[i].actions[1].param
				local spell_status = res.spells[spell_id] and res.spells[spell_id].status
				--Poisonga
				if spell_id == 220 or spell_id == 225 then
					spell_id = 220 --Poisonga (225) puts Poison (220/3) on each target
					spell_status = 3
					effect_id = 3
				--Poisonga II
				elseif spell_id == 221 or spell_id == 226 then
					spell_id = 221 --Poisonga II (226) puts Poison II (221/3) on each target
					spell_status = 3
					effect_id = 3
				end
				if spell_status and spell_status == effect_id then
					saveDebuff(actor_id, target_id, effect_id, spell_id)
				end
			end

		--Most job abilities
		elseif act.category == 3 or act.category == 6 or act.category == 13 or act.category == 15 then
			local messages = S{100, 110, 127, 141, 144, 203, 242, 243, 267, 270, 277, 278, 279, 320, 645, 672}
			if messages:contains(message_id) then
				local effect_id = act.targets[i].actions[1].param
				--Odyllic Subterfuge
				if message_id == 100 and spell_id == 378 then
					effect_id = 509
				--Job Abilities that do damage
				elseif message_id == 110 then
					--Intervene
					if spell_id == 329 then
						effect_id = 496
					else
						effect_id = nil
					end
				end
				if effect_id then
					saveDebuff(actor_id, target_id, effect_id, spell_id)
				end
			end
			--Fenrir Impact
			if act.category == 13 and spell_id == 539 then
				effect_id = 9503
				saveDebuff(actor_id, target_id, effect_id, spell_id)
			end
			--Boost debuff based on Corsair shot type
			local boost = shot_boosts[act.param]
			if act.category == 6 and boost and current_debuffs[main_target_id] then
				local debuff = current_debuffs[main_target_id][boost.effect_id]
				if debuff then
					local boosted_id = boost.spell_map[debuff.id]
					if boosted_id then
						--Update the debuff id to the boosted version
						debuff.id = boosted_id
					end
				end
			end

		--Some job abilities that include a debuff (unblinkable)
		elseif act.category == 14 then

			--Daze effect groups mapped to their level/message_id
			local daze_types = {
				[519] = {[1]=386, [2]=387, [3]=388, [4]=389, [5]=390, [6]=390, [7]=390, [8]=390, [9]=390, [10]=390}, --Lethargic Daze
				[520] = {[1]=391, [2]=392, [3]=393, [4]=394, [5]=395, [6]=395, [7]=395, [8]=395, [9]=395, [10]=395}, --Sluggish Daze
				[521] = {[1]=396, [2]=397, [3]=398, [4]=399, [5]=400, [6]=400, [7]=400, [8]=400, [9]=400, [10]=400}, --Weakened Daze
				[591] = {[1]=448, [2]=449, [3]=450, [4]=451, [5]=452, [6]=452, [7]=452, [8]=452, [9]=452, [10]=452}, --Bewildered Daze
			}

			--Check if the message ID is one of the Daze types
			local daze_group = daze_types[message_id]
			if daze_group then
				local level = act.targets[i].actions[1].param
				local effect_id = daze_group[level]
				if effect_id then
					if current_debuffs[target_id] then
						for _, id in pairs(daze_group) do
							current_debuffs[target_id][id] = nil
						end
					end
					saveDebuff(actor_id, target_id, effect_id, spell_id)
				end
			end

			local messages = S{127, 141, 320, 645}
			if messages:contains(message_id) then
				local effect_id = act.targets[i].actions[1].param
				saveDebuff(actor_id, target_id, effect_id, spell_id)
			--Chainbound
			elseif message_id == 529 then
				local effect_id = 164
				saveDebuff(actor_id, target_id, effect_id, spell_id)
			end

		end
	end
end

function handleActionMessage(data)

	local target_id = data.target_id
	local message_id = data.message_id
	local effect_id = data.param_1
	local target_info = target_id and get_mob_by_id(target_id)
	local target_index = target_info and target_info.index

	--Action messages to look for
	local death_messages = S{6, 20, 113, 406, 605, 646}
	local expire_messages = S{64, 204, 206, 350, 531}

	--Check if the target died and clear their table entries
	if death_messages:contains(message_id) then
		if target_id then
			current_debuffs[target_id] = nil
			current_actions[target_id] = nil
			current_aggro_list[target_id] = nil
		end
		if target_index then
			current_levels[target_index] = nil
		end

	--Check if the debuff expired and clear just that debuff
	elseif expire_messages:contains(message_id) and current_debuffs[target_id] then
		local dazes = {
			lethargic	= {386, 387, 388, 389, 390},
			sluggish	= {391, 392, 393, 394, 395},
			weakened	= {396, 397, 398, 399, 400},
			bewildered	= {448, 449, 450, 451, 452},
		}

		local found_daze = nil

		--Check if the effect is a Daze
		for _, group in pairs(dazes) do
			if S(group):contains(effect_id) then
				found_daze = group
				break
			end
		end

		if found_daze then
			for _, id in ipairs(found_daze) do
				current_debuffs[target_id][id] = nil
			end
		else
			--Check if the effect is from Impact
			local impact_effects = S{136, 137, 138, 139, 140, 141, 142}
			if impact_effects:contains(effect_id) then
				current_debuffs[target_id][9503] = nil
			end

			current_debuffs[target_id][effect_id] = nil
		end

	end

end

register_event('incoming chunk',function(id,original,modified,injected,blocked)

	if injected then return end

	if id == 0x67 or id == 0x068 then --pet tp
		local packet = packets.parse('incoming', original)
		local msg_type = packet['Message Type']
		if (msg_type == 0x04) then
			pet_tp = packet['Pet TP']
		end

	elseif id == 0x028 then --actions (for debuffs)
		handleAction(windower.packets.parse_action(original))

	elseif id == 0x029 then --action messages (for debuffs)
		local data = {}
		data.target_id = original:unpack('I',0x09)
		data.param_1 = original:unpack('I',0x0D)
		data.message_id = original:unpack('H',0x19)%32768
		handleActionMessage(data)

	elseif id == 0xF4 then --wide scan (for monster levels)
		local packet = packets.parse( 'incoming', original )
		current_levels[packet.Index] = packet.Level

	elseif id == 0xB then --zone start
		zoning = true
		hideBars()
		clearTables()
		if Screen_Test then
			windower.send_command('bars ui')
		end

	elseif id == 0xA then --zone finish
		zoning = false
		local target = get_mob_by_target('t')
		showBars(target)
		resetFadeDelay()

	end

end)

--Unrecognized command
function displayUnregnizedCommand()

	add_to_chat(8,('[Bars] '):color(220)..('Unrecognized command. Type'):color(28)..(' //bars help'):color(1)..(' for a list of commands.'):color(28))

end

register_event('addon command',function(addcmd, ...)

	local player = get_player()
	local target = get_mob_by_target('t')
	local clock = os.clock()

	--Toggle the HP bar display setting for the current job
	if addcmd == 'hp' then

		if Screen_Test then
			add_to_chat(8,('[Bars] '):color(220)..('Please lock the UI with '):color(28)..('//bars lock '):color(1)..('before using the '):color(28)..(addcmd):color(1)..(' command.'):color(28))
		else
			job_specific[job].hp = not job_specific[job].hp
			settings:save('all')
			hideBars()
			setPositions()
			showBars(target)
			if job_specific[job].hp then
				updateHPBar(player)
			end
			add_to_chat(8,('[Bars] '):color(220)..('HP bar display for '..uppercase(job)..':'):color(36)..(' %s':format(job_specific[job].hp and 'ON' or 'OFF')):color(200))
		end

	--Toggle the MP bar display setting for the current job
	elseif addcmd == 'mp' then

		if Screen_Test then
			add_to_chat(8,('[Bars] '):color(220)..('Please lock the UI with '):color(28)..('//bars lock '):color(1)..('before using the '):color(28)..(addcmd):color(1)..(' command.'):color(28))
		else
			job_specific[job].mp = not job_specific[job].mp
			settings:save('all')
			hideBars()
			setPositions()
			showBars(target)
			if job_specific[job].mp then
				updateMPBar(player)
			end
			add_to_chat(8,('[Bars] '):color(220)..('MP bar display for '..uppercase(job)..':'):color(36)..(' %s':format(job_specific[job].mp and 'ON' or 'OFF')):color(200))
		end

	--Toggle the TP bar display setting for the current job
	elseif addcmd == 'tp' then

		if Screen_Test then
			add_to_chat(8,('[Bars] '):color(220)..('Please lock the UI with '):color(28)..('//bars lock '):color(1)..('before using the '):color(28)..(addcmd):color(1)..(' command.'):color(28))
		else
			job_specific[job].tp = not job_specific[job].tp
			settings:save('all')
			hideBars()
			setPositions()
			showBars(target)
			if job_specific[job].tp then
				updateTPBar(player)
			end
			add_to_chat(8,('[Bars] '):color(220)..('TP bar display for '..uppercase(job)..':'):color(36)..(' %s':format(job_specific[job].tp and 'ON' or 'OFF')):color(200))
		end

	--Toggle the Pet bar display setting for the current job
	elseif addcmd == 'pet' then

		if Screen_Test then
			add_to_chat(8,('[Bars] '):color(220)..('Please lock the UI with '):color(28)..('//bars lock '):color(1)..('before using the '):color(28)..(addcmd):color(1)..(' command.'):color(28))
		else
			job_specific[job].pet = not job_specific[job].pet
			settings:save('all')
			hideBars()
			setPositions()
			showBars(target)
			add_to_chat(8,('[Bars] '):color(220)..('Pet bar display for '..uppercase(job)..':'):color(36)..(' %s':format(job_specific[job].pet and 'ON' or 'OFF')):color(200))
		end

	--Update the Focus Target bar widths
	elseif addcmd == 'width' or addcmd == 'w' then
		add_to_chat(8,('[Bars] '):color(220)..('Focus Target Bar Width:'):color(36)..(' '..focus_target_bar_width):color(200)..(' ('):color(8)..('//bars ftbw #'):color(1)..(')'):color(8))
		add_to_chat(8,('[Bars] '):color(220)..('Sub Target Bar Width:'):color(36)..(' '..sub_target_bar_width):color(200)..(' ('):color(8)..('//bars stbw #'):color(1)..(')'):color(8))
		add_to_chat(8,('[Bars] '):color(220)..('Target Bar Width:'):color(36)..(' '..target_bar_width):color(200)..(' ('):color(8)..('//bars tbw #'):color(1)..(')'):color(8))
		add_to_chat(8,('[Bars] '):color(220)..('Player Stats Bar Width:'):color(36)..(' '..player_stats_bar_width):color(200)..(' ('):color(8)..('//bars psbw #'):color(1)..(')'):color(8))
		add_to_chat(8,('[Bars] '):color(220)..('Self Action Bar Width:'):color(36)..(' '..self_action_bar_width):color(200)..(' ('):color(8)..('//bars sabw #'):color(1)..(')'):color(8))

	--Update the Focus Target bar width
	elseif addcmd == 'ftbw' then
		local args = {...}
		local new_width = tonumber(args[1])

		if new_width then
			settings.sections.focus_target.bar_width = new_width
			focus_target_bar_width = new_width
			settings:save('all')
			add_to_chat(8,('[Bars] '):color(220)..('Focus Target Bar Width:'):color(36)..(' '..new_width):color(200))
			setWidth()
		else
			add_to_chat(8,('[Bars] '):color(220)..('Focus Target Bar Width:'):color(36)..(' '..focus_target_bar_width):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars '..addcmd..' 36'):color(1)..(')'):color(8))
		end

	--Update the Sub Target bar width
	elseif addcmd == 'stbw' then
		local args = {...}
		local new_width = tonumber(args[1])

		if new_width then
			settings.sections.sub_target.bar_width = new_width
			sub_target_bar_width = new_width
			settings:save('all')
			add_to_chat(8,('[Bars] '):color(220)..('Sub Target Bar Width:'):color(36)..(' '..new_width):color(200))
			setWidth()
		else
			add_to_chat(8,('[Bars] '):color(220)..('Sub Target Bar Width:'):color(36)..(' '..sub_target_bar_width):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars '..addcmd..' 36'):color(1)..(')'):color(8))
		end

	--Update the Target bar width
	elseif addcmd == 'tbw' then
		local args = {...}
		local new_width = tonumber(args[1])

		if new_width then
			settings.sections.target.bar_width = new_width
			target_bar_width = new_width
			settings:save('all')
			add_to_chat(8,('[Bars] '):color(220)..('Target Bar Width:'):color(36)..(' '..new_width):color(200))
			setWidth()
		else
			add_to_chat(8,('[Bars] '):color(220)..('Target Bar Width:'):color(36)..(' '..target_bar_width):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars '..addcmd..' 73'):color(1)..(')'):color(8))
		end

	--Update the Player Stats bar width
	elseif addcmd == 'psbw' then
		local args = {...}
		local new_width = tonumber(args[1])

		if new_width then
			settings.sections.player_stats.bar_width = new_width
			player_stats_bar_width = new_width
			settings:save('all')
			add_to_chat(8,('[Bars] '):color(220)..('Player Stats Bar Width:'):color(36)..(' '..new_width):color(200))
			setWidth()
		else
			add_to_chat(8,('[Bars] '):color(220)..('Player Stats Bar Width:'):color(36)..(' '..player_stats_bar_width):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars '..addcmd..' 73'):color(1)..(')'):color(8))
		end

	--Update the Self Action bar width
	elseif addcmd == 'sabw' then
		local args = {...}
		local new_width = tonumber(args[1])

		if new_width then
			settings.sections.self_action.bar_width = new_width
			self_action_bar_width = new_width
			settings:save('all')
			add_to_chat(8,('[Bars] '):color(220)..('Self Action Bar Width:'):color(36)..(' '..new_width):color(200))
			setWidth()
		else
			add_to_chat(8,('[Bars] '):color(220)..('Self Action Bar Width:'):color(36)..(' '..self_action_bar_width):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars '..addcmd..' 73'):color(1)..(')'):color(8))
		end

	--Update the Focus Target bar sizes
	elseif addcmd == 'size' or addcmd == 's' then
		add_to_chat(8,('[Bars] '):color(220)..('Focus Target Bar Size:'):color(36)..(' '..focus_target_bar_size):color(200)..(' ('):color(8)..('//bars ftbs #'):color(1)..(')'):color(8))
		add_to_chat(8,('[Bars] '):color(220)..('Sub Target Bar Size:'):color(36)..(' '..sub_target_bar_size):color(200)..(' ('):color(8)..('//bars stbs #'):color(1)..(')'):color(8))
		add_to_chat(8,('[Bars] '):color(220)..('Target Bar Size:'):color(36)..(' '..target_bar_size):color(200)..(' ('):color(8)..('//bars tbs #'):color(1)..(')'):color(8))
		add_to_chat(8,('[Bars] '):color(220)..('Player Stats Bar Size:'):color(36)..(' '..player_stats_bar_size):color(200)..(' ('):color(8)..('//bars psbs #'):color(1)..(')'):color(8))
		add_to_chat(8,('[Bars] '):color(220)..('Self Action Bar Size:'):color(36)..(' '..self_action_bar_size):color(200)..(' ('):color(8)..('//bars sabs #'):color(1)..(')'):color(8))

	--Update the Focus Target bar size
	elseif addcmd == 'ftbs' then
		local args = {...}
		local new_size = tonumber(args[1])

		if new_size then
			settings.sections.focus_target.bar_size = new_size
			focus_target_bar_size = new_size
			settings:save('all')
			add_to_chat(8,('[Bars] '):color(220)..('Focus Target Bar Size:'):color(36)..(' '..new_size):color(200))
			focus_target_bar_bg:size(new_size)
			focus_target_bar_meter:size(new_size)
			focus_target_bar_pulse:size(new_size)
		else
			add_to_chat(8,('[Bars] '):color(220)..('Focus Target Bar Size:'):color(36)..(' '..focus_target_bar_size):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars '..addcmd..' 10'):color(1)..(')'):color(8))
		end

	--Update the Sub Target bar size
	elseif addcmd == 'stbs' then
		local args = {...}
		local new_size = tonumber(args[1])

		if new_size then
			settings.sections.sub_target.bar_size = new_size
			sub_target_bar_size = new_size
			settings:save('all')
			add_to_chat(8,('[Bars] '):color(220)..('Sub Target Bar Size:'):color(36)..(' '..new_size):color(200))
			sub_target_bar_bg:size(new_size)
			sub_target_bar_meter:size(new_size)
			sub_target_bar_pulse:size(new_size)
		else
			add_to_chat(8,('[Bars] '):color(220)..('Sub Target Bar Size:'):color(36)..(' '..sub_target_bar_size):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars '..addcmd..' 10'):color(1)..(')'):color(8))
		end

	--Update the Target bar size
	elseif addcmd == 'tbs' then
		local args = {...}
		local new_size = tonumber(args[1])

		if new_size then
			settings.sections.target.bar_size = new_size
			target_bar_size = new_size
			settings:save('all')
			add_to_chat(8,('[Bars] '):color(220)..('Target Bar Size:'):color(36)..(' '..new_size):color(200))
			target_bar_bg:size(new_size)
			target_bar_meter:size(new_size)
			target_bar_drain_meter:size(new_size)
			target_bar_pulse:size(new_size)
		else
			add_to_chat(8,('[Bars] '):color(220)..('Target Bar Size:'):color(36)..(' '..target_bar_size):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars '..addcmd..' 10'):color(1)..(')'):color(8))
		end

	--Update the Player Stats bar size
	elseif addcmd == 'psbs' then
		local args = {...}
		local new_size = tonumber(args[1])

		if new_size then
			settings.sections.player_stats.bar_size = new_size
			player_stats_bar_size = new_size
			settings:save('all')
			add_to_chat(8,('[Bars] '):color(220)..('Player Stats Bar Size:'):color(36)..(' '..new_size):color(200))
			player_stats_hp_bar_bg:size(new_size)
			player_stats_hp_bar_meter:size(new_size)
			player_stats_hp_bar_drain_meter:size(new_size)
			player_stats_hp_bar_pulse:size(new_size)
			player_stats_hp_marker:size(new_size)
			player_stats_mp_bar_bg:size(new_size)
			player_stats_mp_bar_meter:size(new_size)
			player_stats_mp_bar_drain_meter:size(new_size)
			player_stats_mp_bar_pulse:size(new_size)
			player_stats_tp_bar_bg:size(new_size)
			player_stats_tp_bar_meter:size(new_size)
			player_stats_tp_bar_drain_meter:size(new_size)
			player_stats_tp_bar_pulse:size(new_size)
			player_stats_tp_marker:size(new_size)
			player_stats_pet_bar_bg:size(new_size)
			player_stats_pet_bar_meter:size(new_size)
			player_stats_pet_bar_drain_meter:size(new_size)
			player_stats_pet_bar_pulse:size(new_size)
		else
			add_to_chat(8,('[Bars] '):color(220)..('Player Stats Bar Size:'):color(36)..(' '..player_stats_bar_size):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars '..addcmd..' 10'):color(1)..(')'):color(8))
		end

	--Update the Self Action bar size
	elseif addcmd == 'sabs' then
		local args = {...}
		local new_size = tonumber(args[1])

		if new_size then
			settings.sections.self_action.bar_size = new_size
			self_action_bar_size = new_size
			settings:save('all')
			add_to_chat(8,('[Bars] '):color(220)..('Self Action Bar Size:'):color(36)..(' '..new_size):color(200))
			self_action_bar_bg:size(new_size)
			self_action_bar_meter:size(new_size)
		else
			add_to_chat(8,('[Bars] '):color(220)..('Self Action Bar Size:'):color(36)..(' '..self_action_bar_size):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars '..addcmd..' 10'):color(1)..(')'):color(8))
		end

	--Update the Focus Target text sizes
	elseif addcmd == 'text' or addcmd == 't' then
		add_to_chat(8,('[Bars] '):color(220)..('Focus Target Text Size:'):color(36)..(' '..focus_target_text_size):color(200)..(' ('):color(8)..('//bars ftts #'):color(1)..(')'):color(8))
		add_to_chat(8,('[Bars] '):color(220)..('Sub Target Text Size:'):color(36)..(' '..sub_target_text_size):color(200)..(' ('):color(8)..('//bars stts #'):color(1)..(')'):color(8))
		add_to_chat(8,('[Bars] '):color(220)..('Target Text Size:'):color(36)..(' '..target_text_size):color(200)..(' ('):color(8)..('//bars tts #'):color(1)..(')'):color(8))
		add_to_chat(8,('[Bars] '):color(220)..('Player Stats Text Size:'):color(36)..(' '..player_stats_text_size):color(200)..(' ('):color(8)..('//bars psts #'):color(1)..(')'):color(8))
		add_to_chat(8,('[Bars] '):color(220)..('Self Action Text Size:'):color(36)..(' '..self_action_text_size):color(200)..(' ('):color(8)..('//bars sats #'):color(1)..(')'):color(8))

	--Update the Focus Target text size
	elseif addcmd == 'ftts' then
		local args = {...}
		local new_size = tonumber(args[1])

		if new_size then
			settings.sections.focus_target.text_size = new_size
			focus_target_text_size = new_size
			settings:save('all')
			add_to_chat(8,('[Bars] '):color(220)..('Focus Target Text Size:'):color(36)..(' '..new_size):color(200))
			focus_target_text:size(new_size)
			focus_target_text_shadow:size(new_size)
		else
			add_to_chat(8,('[Bars] '):color(220)..('Focus Target Text Size:'):color(36)..(' '..focus_target_text_size):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars '..addcmd..' 10'):color(1)..(')'):color(8))
		end

	--Update the Sub Target text size
	elseif addcmd == 'stts' then
		local args = {...}
		local new_size = tonumber(args[1])

		if new_size then
			settings.sections.sub_target.text_size = new_size
			sub_target_text_size = new_size
			settings:save('all')
			add_to_chat(8,('[Bars] '):color(220)..('Sub Target Text Size:'):color(36)..(' '..new_size):color(200))
			sub_target_text:size(new_size)
			sub_target_text_shadow:size(new_size)
		else
			add_to_chat(8,('[Bars] '):color(220)..('Sub Target Text Size:'):color(36)..(' '..sub_target_text_size):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars '..addcmd..' 10'):color(1)..(')'):color(8))
		end

	--Update the Target text size
	elseif addcmd == 'tts' then
		local args = {...}
		local new_size = tonumber(args[1])

		if new_size then
			settings.sections.target.text_size = new_size
			target_text_size = new_size
			settings:save('all')
			add_to_chat(8,('[Bars] '):color(220)..('Target Text Size:'):color(36)..(' '..new_size):color(200))
			target_text:size(new_size)
			target_text_shadow:size(new_size)
		else
			add_to_chat(8,('[Bars] '):color(220)..('Target Text Size:'):color(36)..(' '..target_text_size):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars '..addcmd..' 14'):color(1)..(')'):color(8))
		end

	--Update the Player Stats text size
	elseif addcmd == 'psts' then
		local args = {...}
		local new_size = tonumber(args[1])

		if new_size then
			settings.sections.player_stats.text_size = new_size
			player_stats_text_size = new_size
			settings:save('all')
			add_to_chat(8,('[Bars] '):color(220)..('Player Stats Text Size:'):color(36)..(' '..new_size):color(200))
			player_stats_hp_text:size(new_size)
			player_stats_hp_text_shadow:size(new_size)
			player_stats_mp_text:size(new_size)
			player_stats_mp_text_shadow:size(new_size)
			player_stats_tp_text:size(new_size)
			player_stats_tp_text_shadow:size(new_size)
			player_stats_pet_text:size(new_size)
			player_stats_pet_text_shadow:size(new_size)
		else
			add_to_chat(8,('[Bars] '):color(220)..('Player Stats Text Size:'):color(36)..(' '..player_stats_text_size):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars '..addcmd..' 10'):color(1)..(')'):color(8))
		end

	--Update the Self Action text size
	elseif addcmd == 'sats' then
		local args = {...}
		local new_size = tonumber(args[1])

		if new_size then
			settings.sections.self_action.text_size = new_size
			self_action_text_size = new_size
			settings:save('all')
			add_to_chat(8,('[Bars] '):color(220)..('Self Action Text Size:'):color(36)..(' '..new_size):color(200))
			self_action_text:size(new_size)
			self_action_text_shadow:size(new_size)
		else
			add_to_chat(8,('[Bars] '):color(220)..('Self Action Text Size:'):color(36)..(' '..self_action_text_size):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars '..addcmd..' 11'):color(1)..(')'):color(8))
		end

	--Update the Focus Target sub text sizes
	elseif addcmd == 'subtext' or addcmd == 'st' then
		add_to_chat(8,('[Bars] '):color(220)..('Focus Target Sub Text Size:'):color(36)..(' '..focus_target_sub_text_size):color(200)..(' ('):color(8)..('//bars ftsts #'):color(1)..(')'):color(8))
		add_to_chat(8,('[Bars] '):color(220)..('Sub Target Sub Text Size:'):color(36)..(' '..sub_target_sub_text_size):color(200)..(' ('):color(8)..('//bars ststs #'):color(1)..(')'):color(8))
		add_to_chat(8,('[Bars] '):color(220)..('Target Sub Text Size:'):color(36)..(' '..target_sub_text_size):color(200)..(' ('):color(8)..('//bars tsts #'):color(1)..(')'):color(8))

	--Update the Focus Target sub text size
	elseif addcmd == 'ftsts' then
		local args = {...}
		local new_size = tonumber(args[1])

		if new_size then
			settings.sections.focus_target.sub_text_size = new_size
			focus_target_sub_text_size = new_size
			settings:save('all')
			add_to_chat(8,('[Bars] '):color(220)..('Focus Target Sub Text Size:'):color(36)..(' '..new_size):color(200))
			focus_target_action_text:size(new_size)
			focus_target_action_text_shadow:size(new_size)
		else
			add_to_chat(8,('[Bars] '):color(220)..('Focus Target Sub Text Size:'):color(36)..(' '..focus_target_sub_text_size):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars '..addcmd..' 10'):color(1)..(')'):color(8))
		end

	--Update the Sub Target sub text size
	elseif addcmd == 'ststs' then
		local args = {...}
		local new_size = tonumber(args[1])

		if new_size then
			settings.sections.sub_target.sub_text_size = new_size
			sub_target_sub_text_size = new_size
			settings:save('all')
			add_to_chat(8,('[Bars] '):color(220)..('Sub Target Sub Text Size:'):color(36)..(' '..new_size):color(200))
			sub_target_action_text:size(new_size)
			sub_target_action_text_shadow:size(new_size)
		else
			add_to_chat(8,('[Bars] '):color(220)..('Sub Target Sub Text Size:'):color(36)..(' '..sub_target_sub_text_size):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars '..addcmd..' 10'):color(1)..(')'):color(8))
		end

	--Update the Target sub text size
	elseif addcmd == 'tsts' then
		local args = {...}
		local new_size = tonumber(args[1])

		if new_size then
			settings.sections.target.sub_text_size = new_size
			target_text_sub_size = new_size
			settings:save('all')
			add_to_chat(8,('[Bars] '):color(220)..('Target Sub Text Size:'):color(36)..(' '..new_size):color(200))
			target_action_text:size(new_size)
			target_action_text_shadow:size(new_size)
		else
			add_to_chat(8,('[Bars] '):color(220)..('Target Sub Text Size:'):color(36)..(' '..target_sub_text_size):color(200))
			add_to_chat(8,('[Bars] '):color(220)..('Update by adding a number (ex.'):color(8)..(' //bars '..addcmd..' 11'):color(1)..(')'):color(8))
		end

	--Toggle the Aggro List setting
	elseif addcmd == 'aggro' or addcmd == 'agg' then

		settings.sections.aggro_list.show = not settings.sections.aggro_list.show
		show_aggro_list = settings.sections.aggro_list.show
		settings:save('all')
		add_to_chat(8,('[Bars] '):color(220)..('Aggro List:'):color(36)..(' %s':format(settings.sections.aggro_list.show and 'ON' or 'OFF')):color(200))

	--Toggle the target distance setting
	elseif addcmd == 'distance' or addcmd == 'dist' or addcmd == 'd' then

		settings.options.show_target_distance = not settings.options.show_target_distance
		show_target_distance = settings.options.show_target_distance
		settings:save('all')
		add_to_chat(8,('[Bars] '):color(220)..('Distance:'):color(36)..(' %s':format(settings.options.show_target_distance and 'ON' or 'OFF')):color(200))

	--Toggle the markers setting
	elseif addcmd == 'marker' or addcmd == 'markers' or addcmd == 'm' then

		settings.options.show_hp_tp_markers = not settings.options.show_hp_tp_markers
		settings:save('all')
		add_to_chat(8,('[Bars] '):color(220)..('Markers:'):color(36)..(' %s':format(settings.options.show_hp_tp_markers and 'ON' or 'OFF')):color(200))
		hideBars()
		setWidth()
		showBars(target)

	--Toggle the hex setting
	elseif addcmd == 'hex' or addcmd == 'h' then

		settings.options.show_target_hex = not settings.options.show_target_hex
		show_target_hex = settings.options.show_target_hex
		settings.options.show_target_index = false
		show_target_index = false
		settings:save('all')
		add_to_chat(8,('[Bars] '):color(220)..('Hex:'):color(36)..(' %s':format(settings.options.show_target_hex and 'ON' or 'OFF')):color(200))
		updateTargetBar(player, target, clock)

	--Toggle the index setting
	elseif addcmd == 'index' or addcmd == 'i' then

		settings.options.show_target_index = not settings.options.show_target_index
		show_target_index = settings.options.show_target_index
		settings.options.show_target_hex = false
		show_target_hex = false
		settings:save('all')
		add_to_chat(8,('[Bars] '):color(220)..('Index:'):color(36)..(' %s':format(settings.options.show_target_index and 'ON' or 'OFF')):color(200))
		updateTargetBar(player, target, clock)

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
			if target then
				focus_target_override = target
				local currFTMDist = settings.options.focus_target_max_distance
				add_to_chat(8,('[Bars] '):color(220)..('Focus Target Override Added: '):color(36)..(focus_target_override.name):color(1))
				add_to_chat(8,('[Bars] '):color(220)..('Override removed when out of range ('):color(8)..(''..currFTMDist):color(200)..(') or by typing '):color(8)..('//bars '..addcmd):color(1)..(' again.'):color(8))
			else
				add_to_chat(8,('[Bars] '):color(220)..('Please highlight a target and try again.'):color(28))
			end
		end

	elseif addcmd == "ui" or addcmd == "lock" or addcmd == "unlock" then

		resetFadeDelay()
		screenTest()
		local r = 0
		local g = Screen_Test and 255 or 0
		local b = 0
		local player_stat_bars = {
			hp = player_stats_hp_bar_bg,
			mp = player_stats_mp_bar_bg,
			tp = player_stats_tp_bar_bg,
			pet = player_stats_pet_bar_bg,
		}

		target_bar_bg:draggable(Screen_Test)
		target_bar_bg:bg_color(r,g,b)
		focus_target_bar_bg:draggable(Screen_Test)
		focus_target_bar_bg:bg_color(r,g,b)
		sub_target_bar_bg:draggable(Screen_Test)
		sub_target_bar_bg:bg_color(r,g,b)
		self_action_bar_bg:draggable(Screen_Test)
		self_action_bar_bg:bg_color(r,g,b)
		player_stat_bars[player_stats_top_bar]:draggable(Screen_Test)
		player_stat_bars[player_stats_top_bar]:bg_color(r,g,b)

		if Screen_Test then
			add_to_chat(8,('[Bars] '):color(220)..('UI editing unlocked. Dragging enabled for highlighted bars.'):color(36))
			add_to_chat(8,('[Bars] '):color(220)..('NOTICE: May not work if Windower\'s '):color(28)..('Window Mode '):color(1)..('is set to '):color(28)..('Window'):color(1)..('.'):color(28))
			add_to_chat(8,('[Bars] '):color(220)..('Display and adjust bar widths: '):color(8)..('//bars width'):color(1))
			add_to_chat(8,('[Bars] '):color(220)..('Display and adjust bar sizes: '):color(8)..('//bars size'):color(1))
			add_to_chat(8,('[Bars] '):color(220)..('Display and adjust text sizes: '):color(8)..('//bars text'):color(1))
			add_to_chat(8,('[Bars] '):color(220)..('Display and adjust sub text sizes: '):color(8)..('//bars subtext'):color(1))
		else
			add_to_chat(8,('[Bars] '):color(220)..('UI editing locked.'):color(36))
		end

	--Display help text
	elseif addcmd == 'help' then

		local currHP = job_specific[job].hp
		local currMP = job_specific[job].mp
		local currTP = job_specific[job].tp
		local currPet = job_specific[job].pet
		local currAggro = settings.sections.aggro_list.show
		local currDistance = settings.options.show_target_distance
		local currMarker = settings.options.show_hp_tp_markers
		local currHex = settings.options.show_target_hex
		local currIndex = settings.options.show_target_index
		local currJob = uppercase(job)
		local currFTMDist = settings.options.focus_target_max_distance

		local prefix = "//bars"
		add_to_chat(8,('[Bars] '):color(220)..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220)..(' ('):color(8)..(prefix):color(1)..(')'):color(8))
		add_to_chat(8,(' Command '):color(36)..('[optional]'):color(53)..(' - Description ['):color(8)..('Current Setting'):color(200)..(']'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,(' add/a '):color(36)..('[target]'):color(53)..(' - Add a target to the Auto Focus Target list.'):color(8))
		add_to_chat(8,('   - Valid targets: Names, IDs or current cursor target.'):color(8))
		add_to_chat(8,('   - Use quotes to surround names with spaces.'):color(8))
		add_to_chat(8,(' remove/r '):color(36)..('[target]'):color(53)..(' - Remove a target from the Auto Focus Target list.'):color(8))
		add_to_chat(8,(' focus/f '):color(36)..(' - Temporarily override the Auto Focus Target with current cursor target.'):color(8))
		add_to_chat(8,('   - Type again to remove the override.'):color(8))
		add_to_chat(8,('   - Automatically removed when target moves out of range ('):color(8)..(tostring(currFTMDist)):color(200)..(').'):color(8))
		add_to_chat(8,(' list/l'):color(36)..(' - Show the Auto Focus Target list.'):color(8))
		add_to_chat(8,(' aggro/agg '):color(36)..(' - Toggle the Aggro List. ['):color(8)..('%s':format(currAggro and 'ON' or 'OFF')):color(200)..(']'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,(' Target Bar Display Options '):color(220))
		add_to_chat(8,(' distance/d '):color(36)..(' - Toggle the target Distance. ['):color(8)..('%s':format(currDistance and 'ON' or 'OFF')):color(200)..(']'):color(8))
		add_to_chat(8,(' marker/m '):color(36)..(' - Toggle the HP/TP Marker. ['):color(8)..('%s':format(currMarker and 'ON' or 'OFF')):color(200)..(']'):color(8))
		add_to_chat(8,(' hex/h '):color(36)..(' - Toggle the target Hex (overrides Index). ['):color(8)..('%s':format(currHex and 'ON' or 'OFF')):color(200)..(']'):color(8))
		add_to_chat(8,(' index/i '):color(36)..(' - Toggle the target Index (overrides Hex). ['):color(8)..('%s':format(currIndex and 'ON' or 'OFF')):color(200)..(']'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,(' UI Adjustents '):color(220))
		add_to_chat(8,(' hp/mp/tp/pet'):color(36)..(' - Toggle HP/MP/TP/Pet bar display for current job.'):color(8))
		add_to_chat(8,('   ['..currJob..' - HP: '):color(8)..('%s':format(currHP and 'ON' or 'OFF')):color(200)..(' MP: '):color(8)..('%s':format(currMP and 'ON' or 'OFF')):color(200)..(' TP: '):color(8)..('%s':format(currTP and 'ON' or 'OFF')):color(200)..(' Pet: '):color(8)..('%s':format(currPet and 'ON' or 'OFF')):color(200)..(']'):color(8))
		add_to_chat(8,(' ui/lock/unlock'):color(36)..(' - Toggle Screen Test to drag sections of the UI around.'):color(8))
		add_to_chat(8,(' width/w '):color(36)..(' - Display bar widths and how to update them.'):color(8))
		add_to_chat(8,(' size/s '):color(36)..(' - Display bar sizes and how to update them.'):color(8))
		add_to_chat(8,(' text/t '):color(36)..(' - Display text sizes and how to update them.'):color(8))
		add_to_chat(8,(' subtext/st '):color(36)..(' - Display sub text sizes and how to update them.'):color(8))

	else

		displayUnregnizedCommand()

	end
end)

--Handle mouse events
register_event('mouse',function(mouse_type, mouse_x, mouse_y)

	if logged_in and mouse_type == 2 then --leftmouseup

		local player_stats_bars = {
			hp = player_stats_hp_bar_bg,
			mp = player_stats_mp_bar_bg,
			tp = player_stats_tp_bar_bg,
			pet = player_stats_pet_bar_bg,
		}

		--Save Bar positions after dragged
		local focus_target_x = focus_target_bar_bg:pos_x()
		local focus_target_y = focus_target_bar_bg:pos_y() - job_specific[job].vertical_offsets.focus_target

		local sub_target_x = sub_target_bar_bg:pos_x()
		local sub_target_y = sub_target_bar_bg:pos_y() - job_specific[job].vertical_offsets.sub_target

		local target_x = target_bar_bg:pos_x()
		local target_y = target_bar_bg:pos_y() - job_specific[job].vertical_offsets.target

		local self_action_x = self_action_bar_bg:pos_x()
		local self_action_y = self_action_bar_bg:pos_y() - job_specific[job].vertical_offsets.self_action

		local player_stats_x = player_stats_bars[player_stats_top_bar]:pos_x()
		local player_stats_y = player_stats_bars[player_stats_top_bar]:pos_y() - job_specific[job].vertical_offsets.player_stats

		local aggro_list_x = aggro_list_box:pos_x()
		local aggro_list_y = aggro_list_box:pos_y()

		if settings.sections.focus_target.pos.x ~= focus_target_x or settings.sections.focus_target.pos.y ~= focus_target_y then
			settings.sections.focus_target.pos = {x = focus_target_x, y = focus_target_y}
			settings:save('all')
			setPositions()

		elseif settings.sections.sub_target.pos.x ~= sub_target_x or settings.sections.sub_target.pos.y ~= sub_target_y then
			settings.sections.sub_target.pos = {x = sub_target_x, y = sub_target_y}
			settings:save('all')
			setPositions()

		elseif settings.sections.target.pos.x ~= target_x or settings.sections.target.pos.y ~= target_y then
			settings.sections.target.pos = {x = target_x, y = target_y}
			settings:save('all')
			setPositions()

		elseif settings.sections.self_action.pos.x ~= self_action_x or settings.sections.self_action.pos.y ~= self_action_y then
			settings.sections.self_action.pos = {x = self_action_x, y = self_action_y}
			settings:save('all')
			setPositions()

		elseif settings.sections.player_stats.pos.x ~= player_stats_x or settings.sections.player_stats.pos.y ~= player_stats_y then
			settings.sections.player_stats.pos = {x = player_stats_x, y = player_stats_y}
			settings:save('all')
			setPositions()

		elseif settings.sections.aggro_list.pos.x ~= aggro_list_x or settings.sections.aggro_list.pos.y ~= aggro_list_y then
			settings.sections.aggro_list.pos = {x = aggro_list_x, y = aggro_list_y}
			settings:save('all')

		end
	end

end)
