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
    * Neither the name of TaskBar nor the names of its contributors may be
	  used to endorse or promote products derived from this software without
	  specific prior written permission.

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

_addon.name = 'Taskbar'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.version = '1.0 BETA-3'
_addon.commands = {'taskbar'}

require 'logger'
config = require('config')
texts = require('texts')
files = require 'files'

add_to_chat = windower.add_to_chat
addon_path = windower.addon_path
get_party = windower.ffxi.get_party
get_position = windower.ffxi.get_position
get_windower_settings = windower.get_windower_settings
file_exists = windower.file_exists
input = windower.chat.input
open_url = windower.open_url
register_event = windower.register_event
send_command = windower.send_command
open_url = windower.open_url
copy_to_clipboard = windower.copy_to_clipboard

--Default settings the addon will use to create the data\settings.xml file
defaults = {
	pos = {x = 16.5, y = get_windower_settings().ui_y_res - 17},
	bg = {alpha = 255, red = 0, green = 0, blue = 0},
	text = {alpha = 255, blue = 255, green = 255, red = 255, font = 'Consolas', size = 11},
	flags = {draggable = false, italic = false, bold = true, right = false, bottom = false},
	padding = 5,
	input_confirm_window = {
		pos = {x = 300, y = 300}
	},
	options = {
		color_theme = 'white',
		colors = {
			normal = {
				white = {r = 140, g = 140, b = 140},
				red = {r = 170, g = 0, b = 0},
				orange = {r = 160, g = 90, b = 0},
				yellow = {r = 140, g = 140, b = 0},
				green = {r = 0, g = 170, b = 0},
				blue = {r = 0, g = 100, b = 255},
				pink = {r = 230, g = 0, b = 135},
				purple = {r = 170, g = 0, b = 255},
			},
			highlight = {
				white = {r = 255, g = 255, b = 255},
				red = {r = 255, g = 30, b = 30},
				orange = {r = 255, g = 150, b = 0},
				yellow = {r = 255, g = 255, b = 0},
				green = {r = 100, g = 255, b = 100},
				blue = {r = 0, g = 200, b = 255},
				pink = {r = 255, g = 135, b = 195},
				purple = {r = 230, g = 140, b = 255},
			},
		},
		menu_size = 14,
		window_size = 11,
	},
	options_window = {
		pos = {x = 300, y = 300}
	},
}

--Load those default settings into the 'settings' variable for the addon to use
settings = config.load(defaults)

--Default/example menu to pre-populate the data\menu.lua file with to start us off, the user can then change the menu structure however they see fit through the right-click menu or in the data\menu.lua file itself
main_menu_defaults = {
	["Bars"] = {
		["FT Override"] = "bars f",
		["Toggle Hex ID"] = "bars h",
	},
	["Chairs"] = {
		["00: Wooden Stool"] = "input /sitchair",
		["01: Imperial Chair"] = "input /sitchair 1",
		["02: Decorative Chair"] = "input /sitchair 2",
		["03: Ornate Stool"] = "input /sitchair 3",
		["04: Refined Chair"] = "input /sitchair 4",
		["05: Port. Container"] = "input /sitchair 5",
		["06: Chocobo Chair"] = "input /sitchair 6",
		["07: Ephramad. Throne"] = "input /sitchair 7",
		["08: Shadow Throne"] = "input /sitchair 8",
		["09: Leaf Bench"] = "input /sitchair 9",
		["10: Astral Cube"] = "input /sitchair 10",
		["11: Chocobo Chair II"] = "input /sitchair 11",
		["12: Adenium Bench"] = "input /sitchair 12",
	},
	["Find"] = {
		["Abdhaljs Items"]="find abdhaljs",
		["Etched Memories"]="find etched memory",
		["Moglophones"] = "find moglophone;wait 1;find moogle amplifier",
		["Primer Vol. One"] = "find Ambuscade Primer Volume One",
		["Vagary Key Items"]="find prototype pearl;wait 1;find prototype sigil pearl",
	},
	["GaolPlan"] = {
		["Open"] = "gaolplan",
	},
	["GearSwap"] = {
		["Disable All Swaps"] = "gs disable all",
		["Enable All Swaps"] = "gs enable all",
		["Export Gear"] = "gs export",
		["Get Naked"] = "gs naked",
		["Reload File"] = "gs reload",
		["Show Gear Swaps"] = "gs showswaps",
		["Validate Gear"] = "gs validate",
	},
	["LeaderBoard"] = {
		["Reset ALL Data"] = "lb reset all",
		["Mode: Silent "] = "lb silent",
		["Mode: Party"] = "lb party",
		["Mode: Raid"] = "lb raid",
		["Mode: Kart"] = "lb kart",
		["OSD: Hide"] = "lb hide",
		["OSD: Show"] = "lb show",
		["Print ALL Boards"] = "lb all",
	},
	["Pouches"] = {
		["Bead Pouch"] = "pouches Bead Pouch",
		["Codex of Etchings"] = "pouches Codex of Etchings",
		["Old Case"] = "pouches Old Case",
		["Silt Pouch"] = "pouches Silt Pouch",
	},
	["Travel: Dynamis"]={
		["Div-Jeuno (HP)"]="hp rulude ah",
		["Div-Bastok (HP)"]="hp bas mines ah",
		["Div-Windurst (HP)"]="hp win wall 1",
		["Div-San d'Oria (HP)"]="hp south san ah",
		["Tavnazia (HP)"]="hp tav 2",
		["Valkrum (SG)"]="sg val",
		["Qufim (HP)"]="hp Qufim",
		["Buburimu (HP)"]="hp mhaura",
		["Bastok (HP)"]="hp bas mines mh",
		["San d'Oria (HP)"]="hp south san mh",
		["Windurst (HP)"]="hp win wall mh",
		["Jeuno (HP)"]="hp rulude mh",
		["Xarcabard (SG)"]="sg xarc",
		["Beaucedine (SG)"]="sg beauc",
	},
	["Travel: Guild HPs"]={
		["Goldsmithing"]="hp bas mar 4",
		["Cooking"]="hp win water 4",
		["Fishing"]="hp port win 1",
		["Smithing/Woodworking"]="hp nort san 4",
		["Leathercraft"]="hp south san 4",
		["Bonecraft/Clothcraft"]="hp win wood 5",
		["Alchemy"]="hp bas mine 3",
	}, 
	["Travel: Home Points"] = {
		["Curio Moogle"] = "hp portb mh",
		["Leafalia"] = "hp leaf",
        ["Mhaura"]="hp mhaura", 
		["Norg"] = "hp norg 2",
		["Port Jeuno Exit"] = "hp portj e",
		["Rabao"] = "hp rabao 2;wait 15;find moglophone;wait 1;find moogle amplifier",
		["Ru'Lude Auct House"] = "hp rul ah",
		["Tavnazia Interchange"] = "hp tavn",
        ["W Adoulin Auct House"]="hp west ah", 
        ["W Adoulin Mog House"]="hp west mh", 
	},
	["Travel: Odyssey"] = {
		["Conflux Port"] = "od port",
	},
	["Travel: Sortie"] = {
		["Device #0"] = "so 0",
		["Device #A"] = "so 1",
		["Device #B"] = "so 2",
		["Device #C"] = "so 3",
		["Device #D"] = "so 4",
		["Gadget/Bitzer Port"] = "so port",
	},
	["Travel: Surv. Guides"] = {
		["Tavnazia Interchange"] = "sg tavn",
		["King Ranp. Tomb"] = "sg king",
	},
	["Travel: Waypoints"] = {
		["Sortie"] = "wp drift 4",
		["W Adoulin Auct House"] = "wp west ah",
		["W Adoulin Mog House"] = "wp west mh",
		["Vagary"] = "wp rak",
	},
	["Windower"] = {
		["Minimize Game"] = "game_minimize",
		["Toggle Console"] = "console_toggle",
		["Toggle FPS"] = "showfps",
		["Console Logging ON"] = "console_log 1;input /echo Windower Console output now logged to windower/console.log",
		["Console Logging OFF"] = "console_log 0;input /echo Windower Console output logging turned off",
	},
}

--Location of the file that is used to create the menu
menu_file = files.new('data\\menu.lua')

help_msg = '--Add, remove, rename, and edit categories and commands by right-clicking anywhere on the menu in-game.\n--You can still customize the menu here in this file if you wish to.\n--Commands can be anything that Windower will accept directly into the console, no need to use the double-slashes "//" at the start.\n--String multiple Windower commands together with a semi-colon ";" between them.\n--Add a pause between commands with "wait #".\n--Send text to the games chat log using "input"\n--Example:\n--input /wave;wait 1;input /s Hello!\n\n'

--If the data\menu.lua file doesn't exist, create it and say a little something to the user
if not menu_file:exists() then
	coroutine.schedule(function()
		add_to_chat(8,('[TaskBar] ':color(220))..('Right-click anywhere on the menu to bring up customization options.'):color(8))
		add_to_chat(8,('[TaskBar] ':color(220))..('Thanks for using TaskBar. Enjoy!  -Key'):color(8))
	end, 1)
	menu_file:write(help_msg..'return '..T(main_menu_defaults):tovstring())
end

--Load the menu from the data\menu.lua file
main_menu_data = require('data.menu')

mouse_is_on = nil --Used to determine where the mouse is.
max_label_characters = 20 --Maximum number of characters a label can have. (Note that labels added via directly editing the menu.lua file that exceed this limit will automatically be truncated in the menu)
max_command_characters = 100 --Maximum number of characters a command can have. (Note that commands added via directly editing the menu.lua file can exceed this limit with no issue)
zoning = false --Used to toggle back and forth to hide the TashBar button when zoning
main_menu_button_positions = {} --Stores Main menu buttons created from the settings file.
sub_menu_button_positions = {} --Stores Sub menu buttons created from the settings file.
active_sub_menu = nil --Stores which sub menu is currently displayed.
menu_button_right_clicked_on = nil --Stores which menu button we right-clicked on for the Right-click menu.
active_right_click_button = nil --Stores which Right-click menu button we clicked on.
text_input_message = nil --Stores what the confirmation message is.
text_input_accept = nil --Stores what the Accept button does in the Text Input Window.
text_input_char_num = 0 --Used to count the number of characters in the text input window message to determine how wide the confirmation window will be.
keyboard_input = "" --Holds the input from the keyboard as its typed out.
active_command_label = "" --Holds the name of the new command being created/edited.
shift_down = false --Is the Shift key held down?
confirm_yes = nil --Stores what the Yes button does in the confirmation window.
confirm_message = nil --Stores what the confirmation message is.
confirm_char_num = 0 --Used to count the number of characters in the confirmation message to determine how wide the confirmation window will be.
pos_adjust_map = {} --Originally needed when the right-click menu had a different number of options depending on whether you clicked on the main or sub menu. The right-click menu still has different options but now its the same total number of options so the y position adjustment is the same. Leaving this in here in case I ever change the options and it differs again.
calculating_dimensions = false --Prevents a strange bug where if the mouse is moving while the setupMenu function is running and trying to calculate the dimensions of the main_menu it will not calculate correctly, instead returning a height and width of either 10 or sometimes 11. Moving the mouse while setupMenu runs immediately after load does not affect it, but when running it after doing things like closing the Options window it will do it. This makes no sense whatsoever. But sure, why not.

--Mapping of DirectInput key codes to characters, used to translate keyboard key presses into characters in the text input window
key_map = {
	--Numbers and symbols (without shift)
	[0x02] = '1', [0x03] = '2', [0x04] = '3', [0x05] = '4', [0x06] = '5',
	[0x07] = '6', [0x08] = '7', [0x09] = '8', [0x0A] = '9', [0x0B] = '0',
	[0x0C] = '-', [0x0D] = '=', [0x1A] = '[', [0x1B] = ']', [0x27] = ';',
	[0x28] = '\'', [0x29] = '`', [0x33] = ',', [0x34] = '.',
	[0x35] = '/', [0x39] = ' ',

	--Numbers and symbols (with shift)
	shift = {
		[0x02] = '!', [0x03] = '@', [0x04] = '#', [0x05] = '$', [0x06] = '%',
		[0x07] = '^', [0x08] = '&', [0x09] = '*', [0x0A] = '(', [0x0B] = ')',
		[0x0C] = '_', [0x0D] = '+', [0x1A] = '{', [0x1B] = '}', [0x27] = ':',
		[0x28] = '"', [0x29] = '~', [0x2B] = '|', [0x33] = '<', [0x34] = '>',
		[0x35] = '?'
	},

	--Letters (lowercase)
	letters = {
		[0x10] = 'q', [0x11] = 'w', [0x12] = 'e', [0x13] = 'r', [0x14] = 't',
		[0x15] = 'y', [0x16] = 'u', [0x17] = 'i', [0x18] = 'o', [0x19] = 'p',
		[0x1E] = 'a', [0x1F] = 's', [0x20] = 'd', [0x21] = 'f', [0x22] = 'g',
		[0x23] = 'h', [0x24] = 'j', [0x25] = 'k', [0x26] = 'l', [0x2C] = 'z',
		[0x2D] = 'x', [0x2E] = 'c', [0x2F] = 'v', [0x30] = 'b', [0x31] = 'n',
		[0x32] = 'm'
	},

	--Letters (uppercase)
	shift_letters = {
		[0x10] = 'Q', [0x11] = 'W', [0x12] = 'E', [0x13] = 'R', [0x14] = 'T',
		[0x15] = 'Y', [0x16] = 'U', [0x17] = 'I', [0x18] = 'O', [0x19] = 'P',
		[0x1E] = 'A', [0x1F] = 'S', [0x20] = 'D', [0x21] = 'F', [0x22] = 'G',
		[0x23] = 'H', [0x24] = 'J', [0x25] = 'K', [0x26] = 'L', [0x2C] = 'Z',
		[0x2D] = 'X', [0x2E] = 'C', [0x2F] = 'V', [0x30] = 'B', [0x31] = 'N',
		[0x32] = 'M'
	}
}

--UI Elements--

--TaskBar button
taskbar_button = texts.new()
taskbar_button:color(settings.text.red, settings.text.green, settings.text.blue, settings.text.alpha)
taskbar_button:bg_color(settings.bg.red, settings.bg.green, settings.bg.blue, settings.bg.alpha)
taskbar_button:font(settings.text.font)
taskbar_button:size(settings.text.size)
taskbar_button:alpha(settings.text.alpha)
taskbar_button:bold(settings.flags.bold)
taskbar_button:pad(0)
taskbar_button:pos(settings.pos.x, settings.pos.y)
taskbar_button:draggable(false)
taskbar_button:show()

--Menu categories
main_menu = texts.new()
main_menu:color(settings.text.red, settings.text.green, settings.text.blue, settings.text.alpha)
main_menu:bg_color(settings.bg.red, settings.bg.green, settings.bg.blue, settings.bg.alpha)
main_menu:font(settings.text.font)
main_menu:size(settings.options.menu_size)
main_menu:alpha(settings.text.alpha)
main_menu:bold(settings.flags.bold)
main_menu:pad(settings.padding)
main_menu:draggable(false)

--Command buttons inside the categories
sub_menu = texts.new()
sub_menu:color(settings.text.red, settings.text.green, settings.text.blue, settings.text.alpha)
sub_menu:bg_color(settings.bg.red, settings.bg.green, settings.bg.blue, settings.bg.alpha)
sub_menu:font(settings.text.font)
sub_menu:size(settings.options.menu_size)
sub_menu:alpha(settings.text.alpha)
sub_menu:bold(settings.flags.bold)
sub_menu:pad(settings.padding)
sub_menu:draggable(false)

--Right-click Menu
right_click_menu = texts.new()
right_click_menu:color(settings.text.red, settings.text.green, settings.text.blue, settings.text.alpha)
right_click_menu:bg_color(settings.bg.red, settings.bg.green, settings.bg.blue, settings.bg.alpha)
right_click_menu:font(settings.text.font)
right_click_menu:size(settings.options.menu_size)
right_click_menu:alpha(settings.text.alpha)
right_click_menu:bold(settings.flags.bold)
right_click_menu:pad(settings.padding)
right_click_menu:draggable(false)

--Text Input Window
text_input_window = texts.new()
text_input_window:color(settings.text.red, settings.text.green, settings.text.blue, settings.text.alpha)
text_input_window:pos(settings.input_confirm_window.pos.x, settings.input_confirm_window.pos.y)
text_input_window:bg_color(settings.bg.red, settings.bg.green, settings.bg.blue, settings.bg.alpha)
text_input_window:font(settings.text.font)
text_input_window:size(settings.options.window_size)
text_input_window:alpha(settings.text.alpha)
text_input_window:bold(settings.flags.bold)
text_input_window:pad(settings.padding)
text_input_window:draggable(true)

--Confirm Window
confirm_window = texts.new()
confirm_window:color(settings.text.red, settings.text.green, settings.text.blue, settings.text.alpha)
confirm_window:pos(settings.input_confirm_window.pos.x, settings.input_confirm_window.pos.y)
confirm_window:bg_color(settings.bg.red, settings.bg.green, settings.bg.blue, settings.bg.alpha)
confirm_window:font(settings.text.font)
confirm_window:size(settings.options.window_size)
confirm_window:alpha(settings.text.alpha)
confirm_window:bold(settings.flags.bold)
confirm_window:pad(settings.padding)
confirm_window:draggable(true)

--Options Window
options_window = texts.new()
options_window:color(settings.text.red, settings.text.green, settings.text.blue, settings.text.alpha)
options_window:pos(settings.options_window.pos.x, settings.options_window.pos.y)
options_window:bg_color(settings.bg.red, settings.bg.green, settings.bg.blue, settings.bg.alpha)
options_window:font(settings.text.font)
options_window:size(settings.options.window_size)
options_window:alpha(settings.text.alpha)
options_window:bold(settings.flags.bold)
options_window:pad(settings.padding)
options_window:draggable(true)

--Format RGB values with leading zeros (helps prevent an issue with the text wiggling around)
function formatRGB(value)

	return string.format("%03d", value)

end

--Format button text with hover effect
function formatButton(label, hover_key, highlight_override, add_brackets)

	local color = settings.options.colors.normal[settings.options.color_theme]

	local is_hovered = (mouse_is_on == hover_key)
	local main_menu_index = hover_key:match("^main_menu_(%d+)")
	local is_active_menu = main_menu_index and tonumber(main_menu_index) == active_sub_menu

	if highlight_override or is_hovered or is_active_menu or (hover_key == "open_taskbar" and main_menu:visible()) then
		color = settings.options.colors.highlight[settings.options.color_theme]
	end

	if add_brackets then
		return "[\\cs("..formatRGB(color.r)..","..formatRGB(color.g)..","..formatRGB(color.b)..")"..label.."\\cr]"
	else
		return "\\cs("..formatRGB(color.r)..","..formatRGB(color.g)..","..formatRGB(color.b)..")"..label.."\\cr"
	end

end

--Setup all the button and sub menu positions. This gets done right off the bat when the addon loads and when the menu is modified so the menus snap into place instantly instead of being calculated on the fly a split second after they appear, preventing the menu from visually "jumping". A text object has to first be visible on-screen in order to get it's dimensions to then be able to calculate where it should be placed on the screen, so we temporarily show it off-screen to do the calculations ahead of time with the user being none the wiser.
function setupMenu()
	
	calculating_dimensions = true
	main_menu_rows = 0
	sub_menu_rows = {}
	main_menu_button_positions = {}
	sub_menu_button_positions = {}
	sub_menu_positions = {}
	main_menu_columns = max_label_characters + 3 -- Account for adding the "│" and " >"
	sub_menu_columns = max_label_characters + 1 -- Account for adding the "│"

	local temp_lines = {}
	local menu_index = 0

	--Sort main menu labels
	local sorted_main_labels = {}
	for label in pairs(main_menu_data) do
		table.insert(sorted_main_labels, label)
	end
	table.sort(sorted_main_labels)

	--Build main menu buttons
	for _, main_label in ipairs(sorted_main_labels) do
		menu_index = menu_index + 1
		local button_name = "main_menu_"..menu_index
		local label = main_label

		if #label > max_label_characters then
			label = label:sub(1, max_label_characters - 1).."…"
		elseif #label < max_label_characters then
			label = label..string.rep(" ", max_label_characters - #label)
		end

		label = "│"..label.." >"
		local formatted = formatButton(label, button_name)
		table.insert(temp_lines, formatted.."\n")
	end

	main_menu:text(table.concat(temp_lines))
	main_menu:pos(-1000, -1000)
	main_menu:show()

	--Give Windower a moment to display the text objects
	coroutine.sleep(0.1)

	main_menu_total_width, main_menu_total_height = main_menu:extents()

	local row_height = main_menu_total_height / menu_index

	pos_adjust_map = {
		["main_menu_"] = row_height * 5, --pixel height of a row times number of rows in the right-click menu
		["sub_menu_"] = row_height * 5
	}

	--Loop again for positions and submenu setup
	menu_index = 0
	for _, main_label in ipairs(sorted_main_labels) do
		menu_index = menu_index + 1
		local button_name = "main_menu_"..menu_index
		main_menu_rows = main_menu_rows + 1

		table.insert(main_menu_button_positions, {
			button = button_name,
			x_begin = 1,
			x_end = main_menu_columns,
			y = main_menu_rows,
			label = main_label,
			sub_menu = {}
		})

		local sub_entries = main_menu_data[main_label]
		local sub_buttons = {}
		local sub_row = 0

		--Sort submenu labels
		local sorted_sub_labels = {}
		for sub_label in pairs(sub_entries) do
			table.insert(sorted_sub_labels, sub_label)
		end
		table.sort(sorted_sub_labels)

		--If there are no submenu labels, insert a blank "Empty" entry
		if #sorted_sub_labels == 0 then
			table.insert(sorted_sub_labels, "Empty")
			sub_entries = { ["Empty"] = nil }
		end

		--Create buttons
		for _, sub_label in ipairs(sorted_sub_labels) do
			sub_row = sub_row + 1
			local sub_button_name = "sub_menu_"..menu_index.."_"..sub_row

			table.insert(sub_buttons, {
				button = sub_button_name,
				x_begin = 1,
				x_end = sub_menu_columns,
				y = sub_row
			})
		end

		sub_menu_rows[button_name] = sub_row
		sub_menu_button_positions[button_name] = sub_buttons

		--Store sorted submenu labels for display later
		sub_menu_button_positions[button_name].sorted_labels = sorted_sub_labels

		local sub_menu_height = sub_row * row_height
		local y_offset = row_height * (menu_index - sub_row)
		local x_offset = main_menu_total_width - 1

		sub_menu_positions[button_name] = {x_offset = x_offset, y_offset = y_offset}

	end

	main_menu:hide()
	sub_menu:hide()
	calculating_dimensions = false

end
setupMenu() --Immediately run on addon load

function createNewCategory()

	main_menu_data[keyboard_input] = {}

	--Update the file
	local file_contents = help_msg
	file_contents = file_contents..'return '..T(main_menu_data):tovstring()
	menu_file:write(file_contents)

	add_to_chat(8, ('[TaskBar] ':color(220))..('Category '):color(8)..('%s'):format(keyboard_input):color(1)..(' created.'):color(8))

	--Close the Text Input window
	closeTextInput()

	--Reload the menu layout
	setupMenu()

end

function deleteCategory()
	if not menu_button_right_clicked_on then return end

	local index = menu_button_right_clicked_on:match("main_menu_(%d+)")
	if not index then return end

	index = tonumber(index)
	local pos = main_menu_button_positions[index]
	if not pos or not pos.label then return end

	local label = pos.label

	--Remove from main_menu_data
	main_menu_data[label] = nil

	--Remove from button positions
	table.remove(main_menu_button_positions, index)

	--Update the file
	local file_contents = help_msg
	file_contents = file_contents..'return '..T(main_menu_data):tovstring()
	menu_file:write(file_contents)

	add_to_chat(8, ('[TaskBar] ':color(220))..('Category '):color(8)..('%s'):format(label):color(1)..(' deleted.'):color(8))

end

function renameCategory()
	if not menu_button_right_clicked_on then return end

	local index = menu_button_right_clicked_on:match("main_menu_(%d+)")
	if not index then return end

	index = tonumber(index)
	local pos = main_menu_button_positions[index]
	if not pos or not pos.label then return end

	local old_label = pos.label

	--Rename in the data table
	main_menu_data[keyboard_input] = main_menu_data[old_label]
	main_menu_data[old_label] = nil

	--Update the button label
	main_menu_button_positions[index].label = keyboard_input

	--Save changes to file
	local file_contents = help_msg
	file_contents = file_contents..'return '..T(main_menu_data):tovstring()
	menu_file:write(file_contents)

	add_to_chat(8, ('[TaskBar] ':color(220))..('Category '):color(8)..('%s'):format(old_label):color(1)..(' renamed to '):color(8)..('%s'):format(keyboard_input):color(1)..('.'):color(8))

	--Close the Text Input window
	closeTextInput()

	--Reload the menu layout
	setupMenu()

end

function categoryLabelexists()

	-- Check if a category with the same name already exists
	if main_menu_data[keyboard_input] then
		return true
	else
		return false
	end
end

function commandLabelexists()
	if not menu_button_right_clicked_on then return end

	--Which category are we in?
	local index = menu_button_right_clicked_on:match("menu_(%d+)")

	index = tonumber(index)
	local pos = main_menu_button_positions[index]

	local category_name = pos.label

	--Check if the entered label already exists
	if main_menu_data[category_name][keyboard_input] then
		return category_name
	else
		return false
	end
end

function createNewCommand()
	if not menu_button_right_clicked_on then return end

	--Which category are we in?
	local index = menu_button_right_clicked_on:match("menu_(%d+)")
	if not index then return end

	index = tonumber(index)
	local pos = main_menu_button_positions[index]
	if not pos or not pos.label then return end

	local category_name = pos.label

	--Add the new command
	main_menu_data[category_name][active_command_label] = keyboard_input

	--Update the file
	local file_contents = help_msg
	file_contents = file_contents..'return '..T(main_menu_data):tovstring()
	menu_file:write(file_contents)

	add_to_chat(8, ('[TaskBar] ':color(220))..('Command '):color(8)..('%s'):format(active_command_label):color(1)..(' added to category '):color(8)..('%s'):format(category_name):color(1)..('.'):color(8))

	--Close the Text Input window
	closeTextInput()

	--Reload the menu layout
	setupMenu()

end

function deleteCommand()
	if not menu_button_right_clicked_on then return end

	--Extract indexes from the clicked button
	local main_index, sub_index = menu_button_right_clicked_on:match("sub_menu_(%d+)_(%d+)")
	main_index = tonumber(main_index)
	sub_index = tonumber(sub_index)

	if not main_index or not sub_index then return end

	local menu_pos = main_menu_button_positions[main_index]
	if not menu_pos or not menu_pos.label then return end

	local category_label = menu_pos.label
	local sub_menu = main_menu_data[category_label]
	if not sub_menu then return end

	local sorted_labels = sub_menu_button_positions["main_menu_"..main_index].sorted_labels
	if not sorted_labels then return end

	local label = sorted_labels[sub_index]
	if not label then return end

	--Delete the command from memory
	sub_menu[label] = nil

	--Update the file
	local file_contents = help_msg
	file_contents = file_contents..'return '..T(main_menu_data):tovstring()
	menu_file:write(file_contents)

	add_to_chat(8, ('[TaskBar] ':color(220))..('Command '):color(8)..('%s'):format(label):color(1)..(' deleted from category '):color(8)..('%s'):format(category_label):color(1)..('.'):color(8))
end

function renameCommand()
	if not menu_button_right_clicked_on then return end

	--Extract indexes from active context menu button
	local main_index, sub_index = menu_button_right_clicked_on:match("sub_menu_(%d+)_(%d+)")
	main_index = tonumber(main_index)
	sub_index = tonumber(sub_index)

	if not main_index or not sub_index then return end

	local menu_pos = main_menu_button_positions[main_index]
	if not menu_pos or not menu_pos.label then return end

	local sub_menu = main_menu_data[menu_pos.label]
	if not sub_menu then return end

	local button_key = "main_menu_"..main_index
	local sorted_labels = sub_menu_button_positions[button_key].sorted_labels
	if not sorted_labels then return end

	local old_label = sorted_labels[sub_index]
	if not old_label then return end

	local command = sub_menu[old_label]
	if not command then return end

	--Remove old label and add new label with the same command
	sub_menu[old_label] = nil
	sub_menu[keyboard_input] = command

	--Update the file
	local file_contents = help_msg
	file_contents = file_contents..'return '..T(main_menu_data):tovstring()
	menu_file:write(file_contents)

	add_to_chat(8, ('[TaskBar] ':color(220))..('Command '):color(8)..('%s'):format(old_label):color(1)..(' renamed to '):color(8)..('%s'):format(keyboard_input):color(1)..('.'):color(8))

	--Close the Text Input window
	closeTextInput()

	--Reload the menu layout
	setupMenu()

end

function editCommand()
	if not menu_button_right_clicked_on then return end

	--Extract indexes from active context menu button
	local main_index, sub_index = menu_button_right_clicked_on:match("sub_menu_(%d+)_(%d+)")
	main_index = tonumber(main_index)
	sub_index = tonumber(sub_index)

	if not main_index or not sub_index then return end

	local menu_pos = main_menu_button_positions[main_index]
	if not menu_pos or not menu_pos.label then return end

	local sub_menu = main_menu_data[menu_pos.label]
	if not sub_menu then return end

	local button_key = "main_menu_"..main_index
	local sorted_labels = sub_menu_button_positions[button_key].sorted_labels
	if not sorted_labels then return end

	local label = sorted_labels[sub_index]
	if not label then return end

	--Update the command text for the existing label
	sub_menu[label] = keyboard_input

	--Update the file
	local file_contents = help_msg
	file_contents = file_contents..'return '..T(main_menu_data):tovstring()
	menu_file:write(file_contents)

	add_to_chat(8, ('[TaskBar] ':color(220))..('Command text for '):color(8)..('%s'):format(label):color(1)..(' updated.'):color(8))

	--Close the Text Input window
	closeTextInput()

	--Reload the menu layout
	setupMenu()

end

function updateTaskBar()
	taskbar_button:text(formatButton("TASKBAR", "open_taskbar", false, true))
end

function closeConfirmWindow()
	confirm_window:hide()
end

function updateConfirmWindow()
	local display_text_parts = {}
	
	local cn = settings.options.colors.normal[settings.options.color_theme]
	local ch = settings.options.colors.highlight[settings.options.color_theme]

	local message = " \\cs("..cn.r..","..cn.g..","..cn.b..")"..confirm_message.."\\cr"
	local message_row_length = #confirm_message
	confirm_char_num = message_row_length + 2 --Used to position buttons

	--Title bar
	local confirm_title = "──\\cs("..ch.r..","..ch.g..","..ch.b..")Confirm\\cr"
	confirm_title = confirm_title..string.rep("─", message_row_length - 7)

	--Buttons
	local yes_button = formatButton("YES", confirm_yes, false, true)
	local no_button = formatButton("NO", "confirm_no", false, true)
	local button_padding = math.floor(message_row_length - 8)
	local button_row = string.rep(" ", button_padding)..yes_button..no_button

	local bottom_row = string.rep("─", message_row_length + 2)


	--Assemble full window text
	table.insert(display_text_parts, confirm_title.."\n\n")
	table.insert(display_text_parts, message.."\n\n")
	table.insert(display_text_parts, button_row.."\n")
	table.insert(display_text_parts, bottom_row)

	display_text = table.concat(display_text_parts)
	confirm_window:text(display_text)
end

function displayConfirmWindow(button, message)
	confirm_yes = button --Store the button that was clicked for later use
	confirm_message = message:text_strip_format() --Srip any formatting and store the message for later use

	updateConfirmWindow()

	confirm_window:show()

end

function closeTextInput()
	text_input_message = nil
	text_input_accept = nil
	text_input_char_num = 0
	keyboard_input = ""
	active_command_label = ""
	text_input_window:hide()
end

function updateTextInputWindow()
	local display_text_parts = {}

	--Set the minimum width of the window (category/command labels are shorter, while commands can be much longer)
	local min_window_width = max_label_characters
	if text_input_accept == "add_command" or text_input_accept == "edit_command" then
		min_window_width = max_command_characters
	end

	local cn = settings.options.colors.normal[settings.options.color_theme]
	local ch = settings.options.colors.highlight[settings.options.color_theme]

	local text_input_message_length = math.max(#text_input_message, min_window_width)
	local padding = math.floor((text_input_message_length - #text_input_message) / 2)
	local message = " "..string.rep(" ", padding).."\\cs("..cn.r..","..cn.g..","..cn.b..")"..text_input_message.."\\cr"

	local message_row_length = math.max(#text_input_message + 2, min_window_width + 2)
	text_input_char_num = message_row_length -- Used to determine button positions

	--Title bar
	local text_input_title = "──\\cs("..ch.r..","..ch.g..","..ch.b..")Text Input\\cr"
	text_input_title = text_input_title..string.rep("─", message_row_length - 13).."─"

	-- Keyboard input line
	local keyboard_input_display = (#keyboard_input < min_window_width) and (keyboard_input.."_") or keyboard_input
	local input_length = #keyboard_input_display
	local new_text = " \\cs("..ch.r..","..ch.g..","..ch.b..")"..keyboard_input_display.."\\cr"

	--Buttons
	local accept_button = formatButton("ACCEPT", text_input_accept, false, true)
	local cancel_button = formatButton("CANCEL", "text_input_cancel", false, true)
	local button_padding = math.floor(message_row_length - 17)
	local button_row = string.rep(" ", button_padding)..accept_button..cancel_button

	local bottom_row = string.rep("─", message_row_length)

	--Assemble full window text
	table.insert(display_text_parts, text_input_title.."\n\n")
	table.insert(display_text_parts, message.."\n\n")
	table.insert(display_text_parts, new_text.."\n\n")
	table.insert(display_text_parts, button_row.."\n")
	table.insert(display_text_parts, bottom_row)

	display_text = table.concat(display_text_parts)
	text_input_window:text(display_text)
end

function displayTextInputWindow(accept_button, message)
	text_input_accept = accept_button --Store the button that was clicked for later use
	text_input_message = message:text_strip_format() --Srip any formatting and store the message for later use

	updateTextInputWindow()

	text_input_window:show()

end

function updateOptionsWindow()
	local display_text_parts = {}
	local cn = settings.options.colors.normal[settings.options.color_theme]
	local ch = settings.options.colors.highlight[settings.options.color_theme]

	table.insert(display_text_parts, "\\cs("..ch.r..","..ch.g..","..ch.b..")TaskBar - Options\\cr                ")
	table.insert(display_text_parts, formatButton("X", "close_options_window", false, true).."\n\n")

	table.insert(display_text_parts, "──\\cs("..ch.r..","..ch.g..","..ch.b..")SETTINGS\\cr──────────────────────────\n\n")

	table.insert(display_text_parts, " \\cs("..cn.r..","..cn.g..","..cn.b..")TaskBar Button Size:\\cr  ")
	local current_taskbar_button_size = "\\cs("..ch.r..","..ch.g..","..ch.b..")"..string.format("%2d", settings.text.size).."\\cr "
	table.insert(display_text_parts, current_taskbar_button_size)
	table.insert(display_text_parts, formatButton("UP", "taskbar_button_size_up", false, true))
	table.insert(display_text_parts, formatButton("DWN", "taskbar_button_size_down", false, true).."\n")

	table.insert(display_text_parts, " \\cs("..cn.r..","..cn.g..","..cn.b..")Menu Size:\\cr            ")
	local current_menu_size = "\\cs("..ch.r..","..ch.g..","..ch.b..")"..string.format("%2d", settings.options.menu_size).."\\cr "
	table.insert(display_text_parts, current_menu_size)
	table.insert(display_text_parts, formatButton("UP", "menu_size_up", false, true))
	table.insert(display_text_parts, formatButton("DWN", "menu_size_down", false, true).."\n")

	table.insert(display_text_parts, " \\cs("..cn.r..","..cn.g..","..cn.b..")Window Size:\\cr          ")
	local current_window_size = "\\cs("..ch.r..","..ch.g..","..ch.b..")"..string.format("%2d", settings.options.window_size).."\\cr "
	table.insert(display_text_parts, current_window_size)
	table.insert(display_text_parts, formatButton("UP", "window_size_up", false, true))
	table.insert(display_text_parts, formatButton("DWN", "window_size_down", false, true).."\n")

	table.insert(display_text_parts, " \\cs("..cn.r..","..cn.g..","..cn.b..")BG Alpha:\\cr            ")
	local current_bg_alpha = "\\cs("..ch.r..","..ch.g..","..ch.b..")"..string.format("%3d", settings.bg.alpha).."\\cr "
	table.insert(display_text_parts, current_bg_alpha)
	table.insert(display_text_parts, formatButton("UP", "bg_alpha_up", false, true))
	table.insert(display_text_parts, formatButton("DWN", "bg_alpha_down", false, true).."\n")

	local bold = settings.flags.bold
	table.insert(display_text_parts, " \\cs("..cn.r..","..cn.g..","..cn.b..")Bold:\\cr                    ")
	table.insert(display_text_parts, formatButton("ON", "bold_on", bold and true, true))
	table.insert(display_text_parts, formatButton("OFF", "bold_off", not bold and true, true).."\n\n")

	table.insert(display_text_parts, "──\\cs("..ch.r..","..ch.g..","..ch.b..")COLOR THEME\\cr───────────────────────\n\n")

	local color_theme = settings.options.color_theme
	table.insert(display_text_parts, "  ")
	table.insert(display_text_parts, formatButton("WHITE", "color_theme_white", color_theme == "white" and true, true).." ")
	table.insert(display_text_parts, formatButton("RED", "color_theme_red", color_theme == "red" and true, true).." ")
	table.insert(display_text_parts, formatButton("ORANGE", "color_theme_orange", color_theme == "orange" and true, true).." ")
	table.insert(display_text_parts, formatButton("YELLOW", "color_theme_yellow", color_theme == "yellow" and true, true).."\n")
	table.insert(display_text_parts, "  ")
	table.insert(display_text_parts, formatButton("GREEN", "color_theme_green", color_theme == "green" and true, true).." ")
	table.insert(display_text_parts, formatButton("BLUE", "color_theme_blue", color_theme == "blue" and true, true).."  ")
	table.insert(display_text_parts, formatButton("PINK", "color_theme_pink", color_theme == "pink" and true, true).." ")
	table.insert(display_text_parts, formatButton("PURPLE", "color_theme_purple", color_theme == "purple" and true, true).."\n\n")

	table.insert(display_text_parts, "──\\cs("..ch.r..","..ch.g..","..ch.b..")ABOUT\\cr─────────────────────────────\n\n")

	local version_padding = string.rep(" ", 25 - #_addon.version)
	table.insert(display_text_parts, " \\cs("..cn.r..","..cn.g..","..cn.b..")Version: ".._addon.version..version_padding.."\\cr\n")
	local author_padding = string.rep(" ", 26 - #_addon.author)
	table.insert(display_text_parts, " \\cs("..cn.r..","..cn.g..","..cn.b..")Author: ".._addon.author..author_padding.."\\cr\n\n")

	local c = settings.options.colors.normal[settings.options.color_theme]
	table.insert(display_text_parts, "\\cs("..cn.r..","..cn.g..","..cn.b..")")
	table.insert(display_text_parts, " Commands can be anything Windower\n")
	table.insert(display_text_parts, " accepts directly into the console,\n")
	table.insert(display_text_parts, " no double-slashes `//` needed.\n")
	table.insert(display_text_parts, " String multiple commands together\n")
	table.insert(display_text_parts, " with a semi-colon `;` between\n")
	table.insert(display_text_parts, " them. Add a pause between commands\n")
	table.insert(display_text_parts, " with `wait #`. Send text to the\n")
	table.insert(display_text_parts, " games chat log using `input`.\n\n")
	table.insert(display_text_parts, "\\cr")

	table.insert(display_text_parts, formatButton("GITHUB", "github", false, true).." ")
	table.insert(display_text_parts, formatButton("DISCORD", "discord", false, true).."         ")
	table.insert(display_text_parts, formatButton("DEFAULT", "confirm_default", false, true))

	display_text = table.concat(display_text_parts)
	options_window:text(display_text)
end

function displayOptionsWindow()
	updateOptionsWindow()
	options_window:show()
end

function closeOptionsWindow()
	options_window:hide()
end

--Update the Main menu
function updateMainMenu()
	local display_text_parts = {}

	for i, pos in ipairs(main_menu_button_positions) do
		local label = pos.button:match("main_menu_(%d+)")
		label = pos.label or ("Menu "..(label or "?"))

		if #label > max_label_characters then
			label = label:sub(1, max_label_characters - 1).."…"
		elseif #label < max_label_characters then
			label = label..string.rep(" ", max_label_characters - #label)
		end

		local formatted = formatButton(label, pos.button)
		local is_hovered = (mouse_is_on == pos.button)
		local main_menu_index = pos.button:match("^main_menu_(%d+)")
		local is_active_menu = main_menu_index and tonumber(main_menu_index) == active_sub_menu	
		table.insert(display_text_parts, ("│"..formatted.." %s\n"):format((is_hovered or is_active_menu) and ">" or ""))
	end

	display_text = table.concat(display_text_parts)
	main_menu:text(display_text)
end

--Update the Sub menu
function updateSubMenu()
	if not active_sub_menu then return end

	local menu_pos = main_menu_button_positions[tonumber(active_sub_menu)]
	if not menu_pos or not menu_pos.label then return end

	local sub_menu_data = main_menu_data[menu_pos.label]
	if not sub_menu_data then return end

	local button_key = "main_menu_"..active_sub_menu
	local sorted_labels = sub_menu_button_positions[button_key].sorted_labels
	if not sorted_labels then return end

	local display_text_parts = {}
	local sub_index = 0

	for _, label in ipairs(sorted_labels) do
		sub_index = sub_index + 1
		local button_name = "sub_menu_"..active_sub_menu.."_"..sub_index

		--Format label
		local formatted_label = label
		if #formatted_label > max_label_characters then
			formatted_label = formatted_label:sub(1, max_label_characters - 1).."…"
		else
			formatted_label = formatted_label..string.rep(" ", max_label_characters - #formatted_label)
		end

		local button_text = formatButton(formatted_label, button_name)
		table.insert(display_text_parts, "│"..button_text.."\n")
	end

	sub_menu:text(table.concat(display_text_parts))

	local anchor_x, anchor_y = main_menu:pos()
	local pos_data = sub_menu_positions[button_key]

	if pos_data then
		sub_menu:pos(anchor_x + pos_data.x_offset, anchor_y + pos_data.y_offset)
	end
end

function handleSubMenuClick(button_name)
	-- Extract indexes from button name
	local main_index, sub_index = button_name:match("sub_menu_(%d+)_(%d+)")
	main_index = tonumber(main_index)
	sub_index = tonumber(sub_index)

	if not main_index or not sub_index then return end

	local menu_pos = main_menu_button_positions[main_index]
	if not menu_pos or not menu_pos.label then return end

	local sub_menu = main_menu_data[menu_pos.label]
	if not sub_menu then return end

	local button_key = "main_menu_"..main_index
	local sorted_labels = sub_menu_button_positions[button_key].sorted_labels
	if not sorted_labels then return end

	local label = sorted_labels[sub_index]
	if not label then return end

	local command = sub_menu[label]
	if command then
		send_command(command)
	end
end

function updateRightClickMenu(button_name)
	if not menu_button_right_clicked_on then return end

	local display_text_parts = {}

	if menu_button_right_clicked_on:match("main_menu_") then
		--Strip the prefix first so its not added to each button
		button_name = button_name:gsub("^text_input_rename_category_", ""):gsub("^confirm_delete_category_", ""):gsub("^text_input_add_command_", "")
		table.insert(display_text_parts, "│"..formatButton("Rename Category", "text_input_rename_category_"..button_name).."\n")
		table.insert(display_text_parts, "│"..formatButton("Delete Category", "confirm_delete_category_"..button_name).."\n")
		table.insert(display_text_parts, "│"..formatButton("Add New Category", "text_input_add_category").."\n")
		table.insert(display_text_parts, "│"..formatButton("Add New Command", "text_input_add_command_"..button_name).."\n")
		table.insert(display_text_parts, "│"..formatButton("Options", "open_options_window"))

	elseif menu_button_right_clicked_on:match("sub_menu_") then
		--Strip the prefix first so its not added to each button
		button_name = button_name:gsub("^text_input_rename_command_", ""):gsub("^text_input_edit_command_", ""):gsub("^confirm_delete_command_", ""):gsub("^text_input_add_command_", "")
		table.insert(display_text_parts, "│"..formatButton("Rename Command", "text_input_rename_command_"..button_name).."\n")
		table.insert(display_text_parts, "│"..formatButton("Edit Command", "text_input_edit_command_"..button_name).."\n")
		table.insert(display_text_parts, "│"..formatButton("Delete Command", "confirm_delete_command_"..button_name).."\n")
		table.insert(display_text_parts, "│"..formatButton("Add New Command", "text_input_add_command_"..button_name).."\n")
		table.insert(display_text_parts, "│"..formatButton("Options", "open_options_window"))

	end

	right_click_menu:text(table.concat(display_text_parts))

end

function handleRightClickMenuClick(button)

	--Return the category name
	local function getCategoryLabel()
		local index = button:match("menu_(%d+)")
		if not index then return end

		index = tonumber(index)
		local pos = main_menu_button_positions[index]
		if not pos or not pos.label then return end

		return pos.label
	end

	--Return the command name
	local function getCommandLabel()
		--Extract indexes from button name
		local main_index, sub_index = button:match("sub_menu_(%d+)_(%d+)")
		if not main_index or not sub_index then return end

		main_index = tonumber(main_index)
		sub_index = tonumber(sub_index)

		local menu_pos = main_menu_button_positions[main_index]
		if not menu_pos or not menu_pos.label then return end

		local sub_menu = main_menu_data[menu_pos.label]
		if not sub_menu then return end

		local button_key = "main_menu_"..main_index
		local sorted_labels = sub_menu_button_positions[button_key].sorted_labels
		if not sorted_labels then return end

		local label = sorted_labels[sub_index]
		return label
	end

	--Return the command text
	local function getCommandText()
		--Extract indexes from button name
		local main_index, sub_index = button:match("sub_menu_(%d+)_(%d+)")
		if not main_index or not sub_index then return end

		main_index = tonumber(main_index)
		sub_index = tonumber(sub_index)

		local menu_pos = main_menu_button_positions[main_index]
		if not menu_pos or not menu_pos.label then return end

		local sub_menu = main_menu_data[menu_pos.label]
		if not sub_menu then return end

		local button_key = "main_menu_"..main_index
		local sorted_labels = sub_menu_button_positions[button_key].sorted_labels
		if not sorted_labels then return end

		local label = sorted_labels[sub_index]
		if not label then return end

		local command = sub_menu[label]
		return command
	end

	if button == "text_input_add_category" then
		active_right_click_button = "add_category"
		displayTextInputWindow("add_category", "New category name:")

	elseif button:match("confirm_delete_category_") then
		local category_name = getCategoryLabel()
		active_right_click_button = "delete_category"
		displayConfirmWindow("delete_category", string.format('Delete category "%s" and ALL COMMANDS within?', category_name))

	elseif button:match("text_input_rename_category_") then
		keyboard_input = getCategoryLabel() --pre-fill the category name into the text input area
		active_right_click_button = "rename_category"
		displayTextInputWindow("rename_category", "Rename category:")

	elseif button:match("text_input_add_command_") then
		active_right_click_button = "text_input_add_command_text"
		displayTextInputWindow("text_input_add_command_text", "New command name:")

	elseif button:match("confirm_delete_command_") then
		local command_label = getCommandLabel()
		active_right_click_button = "delete_command"
		displayConfirmWindow("delete_command", string.format('Delete "%s"?', command_label))

	elseif button:match("text_input_rename_command_") then
		keyboard_input = getCommandLabel() --pre-fill the command name into the text input area
		active_right_click_button = "rename_command"
		displayTextInputWindow("rename_command", "Rename command:")

	elseif button:match("text_input_edit_command_") then
		local command_label = getCommandLabel()
		active_command_label = command_label
		keyboard_input = getCommandText() --pre-fill the command text into the text input area
		active_right_click_button = "edit_command"
		displayTextInputWindow("edit_command", string.format('Edit command text for "%s" (Windower will directly execute this text when clicked):', command_label))

	elseif button == "open_options_window" then
		displayOptionsWindow()

	end

end

--Return which button the mouse is hovering over
function getMouseOnButton(mouse_x, mouse_y)

	local taskbar_button_position = {
		{button = "open_taskbar"},
	}

	--TaskBar button
	--No need to math out how wide each button is since the entire width is the button area
	local taskbar_grid_pos = {x = taskbar_button:pos_x(), y = taskbar_button:pos_y()}
	local taskbar_total_width, taskbar_total_height = taskbar_button:extents()
	local taskbar_grid_width = taskbar_total_width and taskbar_total_width or 0
	local taskbar_grid_height = taskbar_total_height and taskbar_total_height or 0

	--Determine which button the mouse is over
	for _, pos in ipairs(taskbar_button_position) do
		local x_start = taskbar_grid_pos.x
		local x_end = taskbar_grid_pos.x + taskbar_grid_width
		local y_start = taskbar_grid_pos.y
		local y_end = taskbar_grid_pos.y + taskbar_grid_height
		if mouse_x >= x_start and mouse_x <= x_end and mouse_y >= y_start and mouse_y <= y_end then
			return pos.button
		end
	end

	--Confirm Window buttons
	if confirm_window:visible() then
		local confirm_grid_pos = {x = confirm_window:pos_x(), y = confirm_window:pos_y()}
		local confirm_total_width, confirm_total_height = confirm_window:extents()
		local confirm_grid_width = confirm_total_width and confirm_total_width - (settings.padding * 2) --Width of the grid area (excludes padding)
		local confirm_grid_height = confirm_total_height and confirm_total_height - (settings.padding * 2) --Height of the grid area (excludes padding)
		local confirm_button_width = confirm_grid_width and confirm_grid_width / confirm_char_num or 0
		local confirm_button_height = confirm_grid_height and confirm_grid_height / 6 or 0
		local confirm_button_positions = {
			{button = confirm_yes, x_begin = confirm_char_num - 9, x_end = confirm_char_num - 5, y = 5},
			{button = "confirm_no", x_begin = confirm_char_num - 4, x_end = confirm_char_num - 1, y = 5},
		}

		--Determine which button the mouse is over
		for _, pos in ipairs(confirm_button_positions) do
			local x_start = confirm_grid_pos.x + (confirm_button_width * (pos.x_begin - 1))
			local x_end = confirm_grid_pos.x + (confirm_button_width * pos.x_end)
			local y_start = confirm_grid_pos.y + settings.padding + (confirm_button_height * (pos.y - 1))
			local y_end = confirm_grid_pos.y + settings.padding + (confirm_button_height * pos.y)
			if mouse_x >= x_start and mouse_x <= x_end and mouse_y >= y_start and mouse_y <= y_end then
				return pos.button
			end
		end

	--Text Input Window buttons
	elseif text_input_window:visible() then
		local text_input_grid_pos = {x = text_input_window:pos_x(), y = text_input_window:pos_y()}
		local text_input_total_width, text_input_total_height = text_input_window:extents()
		local text_input_grid_width = text_input_total_width and text_input_total_width - (settings.padding * 2) --Width of the grid area (excludes padding)
		local text_input_grid_height = text_input_total_height and text_input_total_height - (settings.padding * 2) --Height of the grid area (excludes padding)
		local text_input_button_width = text_input_grid_width and text_input_grid_width / text_input_char_num or 0
		local text_input_button_height = text_input_grid_height and text_input_grid_height / 8 or 0
		local text_input_button_positions = {
			{button = text_input_accept, x_begin = text_input_char_num - 16, x_end = text_input_char_num - 9, y = 7},
			{button = "text_input_cancel", x_begin = text_input_char_num - 8, x_end = text_input_char_num - 1, y = 7},
		}

		--Determine which button the mouse is over
		for _, pos in ipairs(text_input_button_positions) do
			local x_start = text_input_grid_pos.x + (text_input_button_width * (pos.x_begin - 1))
			local x_end = text_input_grid_pos.x + (text_input_button_width * pos.x_end)
			local y_start = text_input_grid_pos.y + settings.padding + (text_input_button_height * (pos.y - 1))
			local y_end = text_input_grid_pos.y + settings.padding + (text_input_button_height * pos.y)
			if mouse_x >= x_start and mouse_x <= x_end and mouse_y >= y_start and mouse_y <= y_end then
				return pos.button
			end
		end

	--Options Window buttons
	elseif options_window:visible() then
		local options_grid_pos = {x = options_window:pos_x() + settings.padding, y = options_window:pos_y()} --I'm not sure why, but the pos_y here already includes the padding adjustment.
		local options_total_width, options_total_height = options_window:extents()
		local options_grid_width = options_total_width and options_total_width - (settings.padding * 2) --Width of the grid area (excludes padding)
		local options_grid_height = options_total_height and options_total_height - (settings.padding * 2) --Height of the grid area (excludes padding)
		local options_button_width = options_grid_width and options_grid_width / 36 or 0
		local options_button_height = options_grid_height and options_grid_height / 30 or 0
		local options_button_positions = {
			{button = "close_options_window", x_begin = 34, x_end = 36, y = 1},
			{button = "taskbar_button_size_up", x_begin = 27, x_end = 30, y = 5},
			{button = "taskbar_button_size_down", x_begin = 31, x_end = 35, y = 5},
			{button = "menu_size_up", x_begin = 27, x_end = 30, y = 6},
			{button = "menu_size_down", x_begin = 31, x_end = 35, y = 6},
			{button = "window_size_up", x_begin = 27, x_end = 30, y = 7},
			{button = "window_size_down", x_begin = 31, x_end = 35, y = 7},
			{button = "bg_alpha_up", x_begin = 27, x_end = 30, y = 8},
			{button = "bg_alpha_down", x_begin = 31, x_end = 35, y = 8},
			{button = "bold_on", x_begin = 27, x_end = 30, y = 9},
			{button = "bold_off", x_begin = 31, x_end = 35, y = 9},
			{button = "color_theme_white", x_begin = 3, x_end = 9, y = 13},
			{button = "color_theme_red", x_begin = 11, x_end = 15, y = 13},
			{button = "color_theme_orange", x_begin = 17, x_end = 24, y = 13},
			{button = "color_theme_yellow", x_begin = 26, x_end = 33, y = 13},
			{button = "color_theme_green", x_begin = 3, x_end = 9, y = 14},
			{button = "color_theme_blue", x_begin = 11, x_end = 16, y = 14},
			{button = "color_theme_pink", x_begin = 19, x_end = 24, y = 14},
			{button = "color_theme_purple", x_begin = 26, x_end = 33, y = 14},
			{button = "github", x_begin = 1, x_end = 8, y = 30},
			{button = "discord", x_begin = 10, x_end = 18, y = 30},
			{button = "confirm_default", x_begin = 28, x_end = 36, y = 30},
		}

		--Determine which button the mouse is over
		for _, pos in ipairs(options_button_positions) do
			local x_start = options_grid_pos.x + (options_button_width * (pos.x_begin - 1))
			local x_end = options_grid_pos.x + (options_button_width * pos.x_end)
			local y_start = options_grid_pos.y + settings.padding + (options_button_height * (pos.y - 1))
			local y_end = options_grid_pos.y + settings.padding + (options_button_height * pos.y)
			if mouse_x >= x_start and mouse_x <= x_end and mouse_y >= y_start and mouse_y <= y_end then
				return pos.button
			end
		end

	--Right-Click Menu buttons
	--No need to math out how wide each button is since the entire width is the button area
	elseif right_click_menu:visible() then
		local right_click_menu_grid_pos = {x = right_click_menu:pos_x() + settings.padding, y = right_click_menu:pos_y() + settings.padding}
		local right_click_menu_total_width, right_click_menu_total_height = right_click_menu:extents()
		local right_click_menu_grid_width = right_click_menu_total_width and right_click_menu_total_width or 0
		local right_click_menu_grid_height = right_click_menu_total_height and right_click_menu_total_height - (settings.padding * 2) --Height of the grid area (excludes padding)
		local right_click_menu_button_height = 0

		local right_click_menu_button_positions = {}

		if menu_button_right_clicked_on:match("main_menu_") then
			right_click_menu_button_height = right_click_menu_grid_height and right_click_menu_grid_height / 5 or 0
			right_click_menu_button_positions = {
				{button = "text_input_rename_category_"..menu_button_right_clicked_on, y = 1},
				{button = "confirm_delete_category_"..menu_button_right_clicked_on, y = 2},
				{button = "text_input_add_category", y = 3},
				{button = "text_input_add_command_"..menu_button_right_clicked_on, y = 4},
				{button = "open_options_window", y = 5},
			}

		elseif menu_button_right_clicked_on:match("sub_menu_") then
			right_click_menu_button_height = right_click_menu_grid_height and right_click_menu_grid_height / 5 or 0
			right_click_menu_button_positions = {
				{button = "text_input_rename_command_"..menu_button_right_clicked_on, y = 1},
				{button = "text_input_edit_command_"..menu_button_right_clicked_on, y = 2},
				{button = "confirm_delete_command_"..menu_button_right_clicked_on, y = 3},
				{button = "text_input_add_command_"..menu_button_right_clicked_on, y = 4},
				{button = "open_options_window", y = 5},
			}

		end

		--Determine which button the mouse is over
		for _, pos in ipairs(right_click_menu_button_positions) do
			local x_start = right_click_menu_grid_pos.x
			local x_end = right_click_menu_grid_pos.x + right_click_menu_grid_width
			local y_start = right_click_menu_grid_pos.y + (right_click_menu_button_height * (pos.y - 1))
			local y_end = right_click_menu_grid_pos.y + (right_click_menu_button_height * pos.y)
			if mouse_x >= x_start and mouse_x <= x_end and mouse_y >= y_start and mouse_y <= y_end then
				return pos.button
			end
		end

	end

	--Main menu buttons
	--No need to math out how wide each button is since the entire width is the button area
	if main_menu:visible() and not right_click_menu:visible() then
		local main_menu_grid_pos = {x = main_menu:pos_x(), y = main_menu:pos_y() + settings.padding}
		local main_menu_grid_width = main_menu_total_width and main_menu_total_width --Width of the grid area
		local main_menu_grid_height = main_menu_total_height and main_menu_total_height - (settings.padding * 2) --Height of the grid area (excludes padding)
		local main_menu_button_height = main_menu_grid_height and main_menu_grid_height / main_menu_rows or 0

		--Determine which button the mouse is over
		for _, pos in ipairs(main_menu_button_positions) do
			local x_start = main_menu_grid_pos.x
			local x_end = main_menu_grid_pos.x + main_menu_grid_width
			local y_start = main_menu_grid_pos.y + (main_menu_button_height * (pos.y - 1))
			local y_end = main_menu_grid_pos.y + (main_menu_button_height * pos.y)
			if mouse_x >= x_start and mouse_x <= x_end and mouse_y >= y_start and mouse_y <= y_end then
				return pos.button
			end
		end

	end

	--Sub menu buttons
	--No need to math out how wide each button is since the entire width is the button area
	if sub_menu:visible() and not right_click_menu:visible() then
		local sub_menu_key = "main_menu_"..active_sub_menu
		local sub_menu_grid_pos = {x = sub_menu:pos_x(), y = sub_menu:pos_y()} --I'm not sure why, but the pos_y here already includes the padding adjustment.
		local sub_menu_total_width, sub_menu_total_height = sub_menu:extents()
		local sub_menu_grid_width = sub_menu_total_width and sub_menu_total_width --Width of the grid area
		local sub_menu_grid_height = sub_menu_total_height and sub_menu_total_height - (settings.padding * 2) --Height of the grid area (excludes padding)
		local sub_menu_button_height = sub_menu_grid_height and sub_menu_grid_height / sub_menu_rows[sub_menu_key] or 0

		local button_positions = sub_menu_button_positions[sub_menu_key]
		if button_positions then
			for _, pos in ipairs(button_positions) do
				local x_start = sub_menu_grid_pos.x
				local x_end = sub_menu_grid_pos.x + sub_menu_grid_width
				local y_start = sub_menu_grid_pos.y + settings.padding + (sub_menu_button_height * (pos.y - 1))
				local y_end = sub_menu_grid_pos.y + settings.padding + (sub_menu_button_height * pos.y)
				if mouse_x >= x_start and mouse_x <= x_end and mouse_y >= y_start and mouse_y <= y_end then
					return pos.button
				end
			end
		end
	end	

	--The mouse is not over a button
	return "none"

end

--Handle mouse events
register_event("mouse", function(mouse_type, mouse_x, mouse_y)

	if calculating_dimensions then return end

	local function closeMenus()
		main_menu:hide()
		active_sub_menu = nil
		sub_menu:hide()
		right_click_menu:hide()
		updateTaskBar()
	end

	local function closeRightClickMenu()
		right_click_menu:hide()
		updateTaskBar()
	end

	--Get the mouse position relative to the grid
	mouse_is_on = getMouseOnButton(mouse_x, mouse_y)
	-- print(mouse_is_on)

	--Activate/show main menu when hovering over task bar
	if mouse_is_on == "open_taskbar" and not (main_menu:visible() or right_click_menu:visible() or text_input_window:visible() or confirm_window:visible()) then
		main_menu:show()
		coroutine.schedule(function()
			main_menu_total_width, main_menu_total_height = main_menu:extents()
			local pos = {x = taskbar_button:pos_x(), y = taskbar_button:pos_y() - main_menu_total_height}
			main_menu:pos(pos.x, pos.y)
		end, 0.05)
		updateTaskBar()
	end

	if options_window:visible() then
		updateOptionsWindow()

		if mouse_type == 1 then --leftmousedown
			if mouse_is_on ~= "none" then
				return true --blocked from reaching game
			end

		elseif mouse_type == 2 then --leftmouseup

			if mouse_is_on == "close_options_window" then
				closeOptionsWindow()
				setupMenu()

			elseif mouse_is_on == "taskbar_button_size_up" then
				settings.text.size = math.min(20, settings.text.size + 1)
				taskbar_button:size(settings.text.size)
				updateOptionsWindow()
				settings:save('all')

			elseif mouse_is_on == "taskbar_button_size_down" then
				settings.text.size = math.max(5, settings.text.size - 1)
				taskbar_button:size(settings.text.size)
				updateOptionsWindow()
				settings:save('all')

			elseif mouse_is_on == "menu_size_up" then
				settings.options.menu_size = math.min(20, settings.options.menu_size + 1)
				main_menu:size(settings.options.menu_size)
				sub_menu:size(settings.options.menu_size)
				right_click_menu:size(settings.options.menu_size)
				updateOptionsWindow()
				settings:save('all')

			elseif mouse_is_on == "menu_size_down" then
				settings.options.menu_size = math.max(5, settings.options.menu_size - 1)
				main_menu:size(settings.options.menu_size)
				sub_menu:size(settings.options.menu_size)
				right_click_menu:size(settings.options.menu_size)
				updateOptionsWindow()
				settings:save('all')

			elseif mouse_is_on == "window_size_up" then
				settings.options.window_size = math.min(20, settings.options.window_size + 1)
				text_input_window:size(settings.options.window_size)
				confirm_window:size(settings.options.window_size)
				options_window:size(settings.options.window_size)
				updateOptionsWindow()
				settings:save('all')

			elseif mouse_is_on == "window_size_down" then
				settings.options.window_size = math.max(5, settings.options.window_size - 1)
				text_input_window:size(settings.options.window_size)
				confirm_window:size(settings.options.window_size)
				options_window:size(settings.options.window_size)
				updateOptionsWindow()
				settings:save('all')

			elseif mouse_is_on == "bg_alpha_up" then
				settings.bg.alpha = math.min(255, settings.bg.alpha + 15)
				taskbar_button:bg_alpha(settings.bg.alpha)
				main_menu:bg_alpha(settings.bg.alpha)
				sub_menu:bg_alpha(settings.bg.alpha)
				right_click_menu:bg_alpha(settings.bg.alpha)
				text_input_window:bg_alpha(settings.bg.alpha)
				confirm_window:bg_alpha(settings.bg.alpha)
				options_window:bg_alpha(settings.bg.alpha)
				updateOptionsWindow()
				settings:save('all')

			elseif mouse_is_on == "bg_alpha_down" then
				settings.bg.alpha = math.max(0, settings.bg.alpha - 15)
				taskbar_button:bg_alpha(settings.bg.alpha)
				main_menu:bg_alpha(settings.bg.alpha)
				sub_menu:bg_alpha(settings.bg.alpha)
				right_click_menu:bg_alpha(settings.bg.alpha)
				text_input_window:bg_alpha(settings.bg.alpha)
				confirm_window:bg_alpha(settings.bg.alpha)
				options_window:bg_alpha(settings.bg.alpha)
				updateOptionsWindow()
				settings:save('all')

			elseif mouse_is_on == "bold_on" then
				settings.flags.bold = true
				taskbar_button:bold(settings.flags.bold)
				main_menu:bold(settings.flags.bold)
				sub_menu:bold(settings.flags.bold)
				right_click_menu:bold(settings.flags.bold)
				text_input_window:bold(settings.flags.bold)
				confirm_window:bold(settings.flags.bold)
				options_window:bold(settings.flags.bold)
				updateOptionsWindow()
				settings:save('all')

			elseif mouse_is_on == "bold_off" then
				settings.flags.bold = false
				taskbar_button:bold(settings.flags.bold)
				main_menu:bold(settings.flags.bold)
				sub_menu:bold(settings.flags.bold)
				right_click_menu:bold(settings.flags.bold)
				text_input_window:bold(settings.flags.bold)
				confirm_window:bold(settings.flags.bold)
				options_window:bold(settings.flags.bold)
				updateOptionsWindow()
				settings:save('all')

			elseif mouse_is_on == "color_theme_white" then
				settings.options.color_theme = "white"
				updateOptionsWindow()
				updateTaskBar()
				updateMainMenu()
				updateSubMenu()
				settings:save('all')

			elseif mouse_is_on == "color_theme_red" then
				settings.options.color_theme = "red"
				updateOptionsWindow()
				updateTaskBar()
				updateMainMenu()
				updateSubMenu()
				settings:save('all')

			elseif mouse_is_on == "color_theme_orange" then
				settings.options.color_theme = "orange"
				updateOptionsWindow()
				updateTaskBar()
				updateMainMenu()
				updateSubMenu()
				settings:save('all')

			elseif mouse_is_on == "color_theme_yellow" then
				settings.options.color_theme = "yellow"
				updateOptionsWindow()
				updateTaskBar()
				updateMainMenu()
				updateSubMenu()
				settings:save('all')

			elseif mouse_is_on == "color_theme_green" then
				settings.options.color_theme = "green"
				updateOptionsWindow()
				updateTaskBar()
				updateMainMenu()
				updateSubMenu()
				settings:save('all')

			elseif mouse_is_on == "color_theme_blue" then
				settings.options.color_theme = "blue"
				updateOptionsWindow()
				updateTaskBar()
				updateMainMenu()
				updateSubMenu()
				settings:save('all')

			elseif mouse_is_on == "color_theme_pink" then
				settings.options.color_theme = "pink"
				updateOptionsWindow()
				updateTaskBar()
				updateMainMenu()
				updateSubMenu()
				settings:save('all')

			elseif mouse_is_on == "color_theme_purple" then
				settings.options.color_theme = "purple"
				updateOptionsWindow()
				updateTaskBar()
				updateMainMenu()
				updateSubMenu()
				settings:save('all')

			elseif mouse_is_on == "github" then
				local url = "https://github.com/iLVL-Key/FFXI"
				open_url(url)
				copy_to_clipboard(url)
				add_to_chat(1,'[TaskBar] ':color(220)..'GitHub URL Copied To Clipboard.':color(8))
				updateOptionsWindow()

			elseif mouse_is_on == "discord" then
				local url = "https://discord.gg/eKtpvjx"
				open_url(url)
				copy_to_clipboard(url)
				add_to_chat(1,'[TaskBar] ':color(220)..'Discord URL Copied To Clipboard.':color(8))
				updateOptionsWindow()

			elseif mouse_is_on == "confirm_default" then
				displayConfirmWindow("default", "Reset settings to defaults?")
				return true --blocked from reaching game

			end

			--Save Options window position after dragged
			local x, y = options_window:pos()
			if not settings.options_window or settings.options_window.pos.x ~= x or settings.options_window.pos.y ~= y then
				settings.options_window.pos = {x = x, y = y}
				settings:save('all')
			end

			if mouse_is_on ~= "none" then
				return true --blocked from reaching game
			end

		end

	end

	if confirm_window:visible() then
		updateConfirmWindow()
		
		if mouse_type == 1 then --leftmousedown
			if mouse_is_on ~= "none" then
				return true --blocked from reaching game
			end

		elseif mouse_type == 2 then --leftmouseup

			if mouse_is_on == "confirm_no" then
				closeConfirmWindow()

			elseif mouse_is_on == "delete_category" then
				deleteCategory()
				closeConfirmWindow()
				setupMenu()

			elseif mouse_is_on == "delete_command" then
				deleteCommand()
				closeConfirmWindow()
				setupMenu()

			elseif mouse_is_on == "default" then
				settings.text.size = defaults.text.size
				settings.options.menu_size = defaults.options.menu_size
				settings.options.window_size = defaults.options.window_size
				settings.bg.alpha = defaults.bg.alpha
				settings.flags.bold = defaults.flags.bold
				settings.options.color_theme = defaults.options.color_theme
				taskbar_button:size(defaults.text.size)
				main_menu:size(defaults.options.menu_size)
				sub_menu:size(defaults.options.menu_size)
				right_click_menu:size(defaults.options.menu_size)
				text_input_window:size(defaults.options.window_size)
				confirm_window:size(defaults.options.window_size)
				options_window:size(defaults.options.window_size)
				taskbar_button:bg_alpha(defaults.bg.alpha)
				main_menu:bg_alpha(defaults.bg.alpha)
				sub_menu:bg_alpha(defaults.bg.alpha)
				right_click_menu:bg_alpha(defaults.bg.alpha)
				text_input_window:bg_alpha(defaults.bg.alpha)
				confirm_window:bg_alpha(defaults.bg.alpha)
				options_window:bg_alpha(defaults.bg.alpha)
				taskbar_button:bold(defaults.flags.bold)
				main_menu:bold(defaults.flags.bold)
				sub_menu:bold(defaults.flags.bold)
				right_click_menu:bold(defaults.flags.bold)
				text_input_window:bold(defaults.flags.bold)
				confirm_window:bold(defaults.flags.bold)
				options_window:bold(defaults.flags.bold)
				settings:save('all')
				closeConfirmWindow()
				return true --blocked from reaching game

			end

			--Save Options window position after dragged
			local x, y = confirm_window:pos()
			if not settings.input_confirm_window or settings.input_confirm_window.x ~= x or settings.input_confirm_window.y ~= y then
				settings.input_confirm_window.pos = {x = x, y = y}
				settings:save('all')
			end

			if mouse_is_on ~= "none" then
				return true --blocked from reaching game
			end

		end

	elseif text_input_window:visible() then
		updateTextInputWindow()

		if mouse_type == 1 then --leftmousedown
			if mouse_is_on ~= "none" then
				return true --blocked from reaching game
			end

		elseif mouse_type == 2 then --leftmouseup

			if mouse_is_on == "text_input_cancel" then
				closeTextInput()

			elseif mouse_is_on == "text_input_add_command_text"then
				--Check if the entered label already exists
				local category_name = commandLabelexists()
				if keyboard_input == "" then
					add_to_chat(8, ('[TaskBar] ':color(220))..('Command name must not be empty.'):color(28))
					displayTextInputWindow("text_input_add_command_text", "New command name:")
				elseif category_name then
					add_to_chat(8, ('[TaskBar] ':color(220))..('Command named '):color(28)..('%s'):format(keyboard_input):color(1)..(' already exists in category '):color(8)..('%s'):format(category_name):color(1)..('.'):color(28))
					displayTextInputWindow("text_input_add_command_text", "New command name:")
				else
					active_command_label = keyboard_input
					keyboard_input = ""
					displayTextInputWindow("add_command", string.format('New command text for "%s" (Windower will directly execute this text when clicked):', active_command_label))
				end

			elseif mouse_is_on == "rename_command" then
				--Check if the entered label already exists
				local category_name = commandLabelexists()
				if keyboard_input == "" then
					add_to_chat(8, ('[TaskBar] ':color(220))..('Command name must not be empty.'):color(28))
					displayTextInputWindow("rename_command", "Rename command:")
				elseif category_name then
					add_to_chat(8, ('[TaskBar] ':color(220))..('Command named '):color(28)..('%s'):format(keyboard_input):color(1)..(' already exists in category '):color(8)..('%s'):format(category_name):color(1)..('.'):color(28))
					displayTextInputWindow("rename_command", "Rename command:")
				else
					renameCommand()
				end

			elseif mouse_is_on == "add_category" then
				-- Check if a category with the same name already exists
				if keyboard_input == "" then
					add_to_chat(8, ('[TaskBar] ':color(220))..('Category name must not be empty.'):color(28))
					displayTextInputWindow("add_category", "New category name:")
				elseif categoryLabelexists() then
					add_to_chat(8, ('[TaskBar] ':color(220))..('Category named '):color(28)..('%s'):format(keyboard_input):color(1)..(' already exists.'):color(28))
					displayTextInputWindow("add_category", "New category name:")
				else
					createNewCategory()
				end

			elseif mouse_is_on == "rename_category" then
				-- Check if a category with the same name already exists
				if keyboard_input == "" then
					add_to_chat(8, ('[TaskBar] ':color(220))..('Category name must not be empty.'):color(28))
					displayTextInputWindow("rename_category", "Rename category:")
				elseif categoryLabelexists() then
					add_to_chat(8, ('[TaskBar] ':color(220))..('Category named '):color(28)..('%s'):format(keyboard_input):color(1)..(' already exists.'):color(28))
					displayTextInputWindow("rename_category", "Rename category:")
				else
					renameCategory()
				end

			elseif mouse_is_on == "add_command" then
				if keyboard_input == "" then
					add_to_chat(8, ('[TaskBar] ':color(220))..('Command text must not be empty.'):color(28))
					displayTextInputWindow("add_command", string.format('New command text for "%s" (Windower will directly execute this text when clicked):', active_command_label))
				else
					createNewCommand()
				end

			elseif mouse_is_on == "edit_command" then
				if keyboard_input == "" then
					add_to_chat(8, ('[TaskBar] ':color(220))..('Command text must not be empty.'):color(28))
					displayTextInputWindow("add_command", string.format('New command text for "%s" (Windower will directly execute this text when clicked):', active_command_label))
				else
					editCommand()
				end

			end

			--Save Options window position after dragged
			local x, y = text_input_window:pos()
			if not settings.input_confirm_window or settings.input_confirm_window.x ~= x or settings.input_confirm_window.y ~= y then
				settings.input_confirm_window.pos = {x = x, y = y}
				settings:save('all')
			end

			if mouse_is_on ~= "none" then
				return true --blocked from reaching game
			end

		end

	elseif right_click_menu:visible() then
		updateRightClickMenu(mouse_is_on)

		if mouse_type == 1 then --leftmousedown
			return true --blocked from reaching game

		elseif mouse_type == 2 then --leftmouseup

			if mouse_is_on == "none" then
				--Clicked outside the menu, close the menus
				closeRightClickMenu()
			else
				--Clicked on a Sub menu button, Do The Thing and also close the menus
				handleRightClickMenuClick(mouse_is_on)
				closeMenus()
			end

			return true --blocked from reaching game

		elseif mouse_type == 5 and mouse_is_on == "none" then --rightmouseup
			--Clicked outside the menu, close the menus
			closeRightClickMenu()
			return true --blocked from reaching game
			
		end
		
		return true --blocked from reaching game

	end

	--Main menu is visible, ie TaskBar is open
	if main_menu:visible() and not (right_click_menu:visible() or text_input_window:visible() or confirm_window:visible()) then

		--Check if hovering over a main menu button
		local main_menu_index = mouse_is_on and mouse_is_on:match("^main_menu_(%d+)")
		if main_menu_index then
			local menu_pos = main_menu_button_positions[tonumber(main_menu_index)]
			if menu_pos and menu_pos.label then
				local submenu = main_menu_data[menu_pos.label]
				if submenu then
					active_sub_menu = tonumber(main_menu_index)
					
					if not sub_menu:visible() then
						sub_menu:show()
					end
				else
					if sub_menu:visible() then
						sub_menu:hide()
					end
				end
			end			
		end

		if mouse_type == 1 then --leftmousedown
			return true --blocked from reaching game

		elseif mouse_type == 2 then --leftmouseup

			if mouse_is_on == "none" then
				--Clicked outside the menu, close the menus
				closeMenus()
			elseif mouse_is_on:match("sub_menu_") then
				--Clicked on a Sub menu button, Do The Thing and also close the menus
				handleSubMenuClick(mouse_is_on)
				closeMenus()
			end

			return true --blocked from reaching game

		elseif mouse_type == 4 and mouse_is_on == "none" then --rightmousedown
			return true --blocked from reaching game

		elseif mouse_type == 5 then --rightmouseup

			if mouse_is_on == "none" then
				--Clicked outside the menu, close the menus
				closeMenus()

				return true --blocked from reaching game

			elseif mouse_is_on ~= "open_taskbar" then
				--Store the button we right-clicked on so we can use it later
				menu_button_right_clicked_on = mouse_is_on

				--Adjust the right-click menu upwards from where the mouse is depending on how many options it has.
				local pos_adjust = 0
				if menu_button_right_clicked_on:match("^main_menu_") then
					pos_adjust = pos_adjust_map["main_menu_"]
				elseif menu_button_right_clicked_on:match("^sub_menu_") then
					pos_adjust = pos_adjust_map["sub_menu_"]
				end
				right_click_menu:pos(mouse_x, mouse_y - pos_adjust)
				right_click_menu:show()
				updateRightClickMenu(mouse_is_on)

				return true --blocked from reaching game

			end

		end

		updateMainMenu()
		updateSubMenu()
		return true --blocked from reaching game

	end

end)

register_event('keyboard', function(dik, down, flags, blocked)

	--Update shift key state
	if dik == 0x2A or dik == 0x36 then --Left Shift and Right Shift
		shift_down = down
		return false
	end

	--If Text Input window is open, handle input differently
	if text_input_window:visible() then

		if down then

			if dik == 0x01 then --Escape key to cancel

				closeTextInput()
				return true

			elseif dik == 0x0E then --Backspace key to delete last character

				keyboard_input = keyboard_input:sub(1, -2)
				updateTextInputWindow()
				return true

			elseif dik == 0x1C then --Enter key to finish

				if active_right_click_button == "text_input_add_command_text" and active_command_label == "" then
					--Check if the entered label already exists
					local category_name = commandLabelexists()
					if keyboard_input == "" then
						add_to_chat(8, ('[TaskBar] ':color(220))..('Command name must not be empty.'):color(28))
						displayTextInputWindow("text_input_add_command_text", "New command name:")
					elseif category_name then
						add_to_chat(8, ('[TaskBar] ':color(220))..('Command named '):color(28)..('%s'):format(keyboard_input):color(1)..(' already exists in category '):color(8)..('%s'):format(category_name):color(1)..('.'):color(28))
						displayTextInputWindow("text_input_add_command_text", "New command name:")
					else
						active_command_label = keyboard_input
						keyboard_input = ""
						displayTextInputWindow("add_command", string.format('New command text for "%s" (Windower will directly execute this text when clicked):', active_command_label))
					end

				elseif active_right_click_button == "rename_command" and active_command_label == "" then
					--Check if the entered label already exists
					local category_name = commandLabelexists()
					if keyboard_input == "" then
						add_to_chat(8, ('[TaskBar] ':color(220))..('Command name must not be empty.'):color(28))
						displayTextInputWindow("rename_command", "Rename command:")
					elseif category_name then
						add_to_chat(8, ('[TaskBar] ':color(220))..('Command named '):color(28)..('%s'):format(keyboard_input):color(1)..(' already exists in category '):color(8)..('%s'):format(category_name):color(1)..('.'):color(28))
						displayTextInputWindow("rename_command", "Rename command:")
					else
						renameCommand()
					end
	
				elseif active_right_click_button == "add_category" and active_command_label == "" then
					-- Check if a category with the same name already exists
					if keyboard_input == "" then
						add_to_chat(8, ('[TaskBar] ':color(220))..('Category name must not be empty.'):color(28))
						displayTextInputWindow("add_category", "New category name:")
					elseif categoryLabelexists() then
						add_to_chat(8, ('[TaskBar] ':color(220))..('Category named '):color(28)..('%s'):format(keyboard_input):color(1)..(' already exists.'):color(28))
						displayTextInputWindow("add_category", "New category name:")
					else
						createNewCategory()
					end

				elseif active_right_click_button == "rename_category" and active_command_label == "" then
					-- Check if a category with the same name already exists
					if keyboard_input == "" then
						add_to_chat(8, ('[TaskBar] ':color(220))..('Category name must not be empty.'):color(28))
						displayTextInputWindow("rename_category", "Rename category:")
					elseif categoryLabelexists() then
						add_to_chat(8, ('[TaskBar] ':color(220))..('Category named '):color(28)..('%s'):format(keyboard_input):color(1)..(' already exists.'):color(28))
						displayTextInputWindow("rename_category", "Rename category:")
					else
						renameCategory()
					end

				elseif text_input_accept == "add_command" then
					if keyboard_input == "" then
						add_to_chat(8, ('[TaskBar] ':color(220))..('Command text must not be empty.'):color(28))
						displayTextInputWindow("add_command", string.format('New command text for "%s" (Windower will directly execute this text when clicked):', active_command_label))
					else
						createNewCommand()
					end

				elseif text_input_accept == "edit_command" then
					if keyboard_input == "" then
						add_to_chat(8, ('[TaskBar] ':color(220))..('Command text must not be empty.'):color(28))
						displayTextInputWindow("add_command", string.format('New command text for "%s" (Windower will directly execute this text when clicked):', active_command_label))
					else
						editCommand()
					end

				end

				return true

			end

			--Only accept new input if we're under the character limit
			if #keyboard_input < (active_command_label == "" and max_label_characters or max_command_characters) then
				--Handle character input based on shift state
				if key_map.letters[dik] then
					keyboard_input = keyboard_input..(shift_down and key_map.shift_letters[dik] or key_map.letters[dik])
					updateTextInputWindow()
					return true
				elseif key_map[dik] then
					keyboard_input = keyboard_input..(shift_down and key_map.shift[dik] or key_map[dik])
					updateTextInputWindow()
					return true
				end
			end
		end
		return true --Block all other inputs while in text input mode
	elseif confirm_window:visible() then
		if down then
			if dik == 0x01 then --Escape key to cancel
				closeConfirmWindow()
				return true
			end
		end
	end

	return false --Allow all other inputs to reach the game
end)

register_event('prerender', function()

	--Hide while zoning
	local pos = get_position()
	if pos == "(?-?)" and not zoning then
		zoning = true
		taskbar_button:hide()
	elseif pos ~= "(?-?)" and zoning then
		zoning = false
		taskbar_button:show()
	end

end)

register_event('addon command',function(add_cmd)

	add_to_chat(8,('[TaskBar] ':color(220))..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220))
	add_to_chat(8,' ')
	add_to_chat(8,('Right-click on the menu to bring up different options.'):color(8))
	add_to_chat(8,' ')
	add_to_chat(8,('This addon has no keyboard commands. Have a great day :)'):color(8))

end)

updateTaskBar()
