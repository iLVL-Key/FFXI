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
_addon.version = '1.0 BETA-2'
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

--Default settings the addon will use to create the data\settings.xml file
defaults = {
	pos = {x = 16.5, y = get_windower_settings().ui_y_res - 17},
	bg = {alpha = 255, red = 0, green = 0, blue = 0},
	text = {alpha = 255, blue = 255, green = 255, red = 255, font = 'Consolas', size = 10},
	flags = {draggable = false, italic = false, bold = true, right = false, bottom = false},
	padding = 5,
	window = {
		pos = {x = 300, y = 300}
	}
}

--Load those default settings into the 'settings' variable for the addon to use
settings = config.load(defaults)

--Default/example menu to pre-populate the data\menu.lua file with to start us off, the user can then change the menu structure however they see fit in the data\menu.lua file itself
main_menu_defaults = {
	["Bars"] = {
		["FT Override"] = "bars f",
		["Toggle Hex ID"] = "bars h",
	},
	["Emotes"] = {
		["Bandage"] = "input /jobemote whm",
		["Dance"] = "input /dance",
		["Poke"] = "input /poke",
		["Wave"] = "input /wave",
	},
	["Find"] = {
		["Primer Vol. One"] = "find Ambuscade Primer Volume One",
	},
	["GaolPlan"] = {
		["Open"] = "gaolplan",
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
	["Travel: Odyssey"] = {
		["Conflux Port"] = "od port",
	},
	["Pouches"] = {
		["Bead Pouch"] = "pouches Bead Pouch",
		["Codex of Etchings"] = "pouches Codex of Etchings",
		["Old Case"] = "pouches Old Case",
		["Silt Pouch"] = "pouches Silt Pouch",
	},
	["Travel: Sortie"] = {
		["Device #0"] = "so 0",
		["Device #A"] = "so 1",
		["Device #B"] = "so 2",
		["Device #C"] = "so 3",
		["Device #D"] = "so 4",
		["Gadget/Bitzer Port"] = "so port",
	},
	["Travel: World"] = {
		["HP: Curio Moogle"] = "hp portb mh",
		["HP: Norg"] = "hp norg 2",
		["HP: Port Jeuno Exit"] = "hp portj e",
		["HP: Rabao"] = "hp rabao 2;wait 15;find moglophone;wait 1;find moogle amplifier",
		["HP: Ru'Lude Gard. AH"] = "hp rul ah",
		["HP: Tav. Interchange"] = "hp tavn",
		["SG: Tav. Interchange"] = "sg tavn",
		["SG: King Ranp. Tomb"] = "sg king",
		["WP: Sortie"] = "wp drift 4",
		["HP: Leafalia"] = "hp leaf",
	},
	["Windower"] = {
		["Minimize Game"] = "game_minimize",
		["Windower Console"] = "console_toggle",
		["FPS"] = "showfps",
	},
}

menu_file = files.new('data\\menu.lua')

help_msg = '--Use this pre-populated menu as a guide to create your own customized menu.\n'
--If the data\menu.lua file doesn't exist, create it
if not menu_file:exists() then
	coroutine.schedule(function()
		add_to_chat(8,('[TaskBar] ':color(220))..('The menu.xml file has been pre-populated with an example menu structure.'):color(8))
		add_to_chat(8,('[TaskBar] ':color(220))..('Use this as a guide to create your own customized menu. Enjoy!  -Key'):color(8))
	end, 1)
	menu_file:write(help_msg..'return '..T(main_menu_defaults):tovstring())
end

--Load the menu from the data\menu.lua file
main_menu_data = require('data.menu')

mouse_is_on = nil --Used to determine where the mouse is.
max_label_characters = 20 --Maximum number of characters a label can have. (Note that labels added via directly editing the menu.lua file that exceed this limit will automatically be truncated in the menu)
max_command_characters = 100 --Maximum number of characters a command can have. (Note that commands added via directly editing the menu.lua file can exceed this limit with no issue)
zoning = false
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

--Colors
off_white = {r = 140, g = 140, b = 140}
highlight = {r = 255, g = 255, b = 255}

--Mapping of DirectInput key codes to characters
key_map = {
	--Numbers and symbols (without shift)
	[0x02] = '1', [0x03] = '2', [0x04] = '3', [0x05] = '4', [0x06] = '5',
	[0x07] = '6', [0x08] = '7', [0x09] = '8', [0x0A] = '9', [0x0B] = '0',
	[0x0C] = '-', [0x0D] = '=', [0x1A] = '[', [0x1B] = ']', [0x27] = ';',
	[0x28] = '\'', [0x29] = '`', [0x2B] = '\\', [0x33] = ',', [0x34] = '.',
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
task_bar = texts.new()
task_bar:bg_color(settings.bg.red, settings.bg.green, settings.bg.blue, settings.bg.alpha)
task_bar:font(settings.text.font)
task_bar:size(settings.text.size)
task_bar:alpha(settings.text.alpha)
task_bar:bold(settings.flags.bold)
task_bar:pad(0)
task_bar:pos(settings.pos.x, settings.pos.y)
task_bar:draggable(false)
task_bar:show()

--Menu categories
main_menu = texts.new()
main_menu:bg_color(settings.bg.red, settings.bg.green, settings.bg.blue, settings.bg.alpha)
main_menu:font(settings.text.font)
main_menu:size(settings.text.size + 2)
main_menu:alpha(settings.text.alpha)
main_menu:bold(settings.flags.bold)
main_menu:pad(settings.padding)
main_menu:draggable(false)

--Command buttons inside the categories
sub_menu = texts.new()
sub_menu:bg_color(settings.bg.red, settings.bg.green, settings.bg.blue, settings.bg.alpha)
sub_menu:font(settings.text.font)
sub_menu:size(settings.text.size + 2)
sub_menu:alpha(settings.text.alpha)
sub_menu:bold(settings.flags.bold)
sub_menu:pad(settings.padding)
sub_menu:draggable(false)

--Right-click Menu
right_click_menu = texts.new()
right_click_menu:bg_color(settings.bg.red, settings.bg.green, settings.bg.blue, settings.bg.alpha)
right_click_menu:font(settings.text.font)
right_click_menu:size(settings.text.size + 2)
right_click_menu:alpha(settings.text.alpha)
right_click_menu:bold(settings.flags.bold)
right_click_menu:pad(settings.padding)
right_click_menu:draggable(false)

--Text Input Window
text_input_window = texts.new()
text_input_window:pos(settings.window.pos.x, settings.window.pos.y)
text_input_window:bg_color(settings.bg.red, settings.bg.green, settings.bg.blue, settings.bg.alpha)
text_input_window:font(settings.text.font)
text_input_window:size(settings.text.size + 2)
text_input_window:alpha(settings.text.alpha)
text_input_window:bold(settings.flags.bold)
text_input_window:pad(settings.padding)
text_input_window:draggable(true)

--Confirm Window
confirm_window = texts.new()
confirm_window:pos(settings.window.pos.x, settings.window.pos.y)
confirm_window:bg_color(settings.bg.red, settings.bg.green, settings.bg.blue, settings.bg.alpha)
confirm_window:font(settings.text.font)
confirm_window:size(settings.text.size + 2)
confirm_window:alpha(settings.text.alpha)
confirm_window:bold(settings.flags.bold)
confirm_window:pad(settings.padding)
confirm_window:draggable(true)

--Format button text with hover effect
function formatButton(label, hover_key, brackets)

	local color = off_white

    local is_hovered = (mouse_is_on == hover_key)
    local main_menu_index = hover_key:match("^main_menu_(%d+)")
    local is_active_menu = main_menu_index and tonumber(main_menu_index) == active_sub_menu

    if is_hovered or is_active_menu or (hover_key == "open_task_bar" and main_menu:visible()) then
        color = highlight
    end

	if brackets then
		return string.format("[\\cs(%d,%d,%d)%s\\cr]", color.r, color.g, color.b, label)
	else
		return string.format("\\cs(%d,%d,%d)%s\\cr", color.r, color.g, color.b, label)
	end

end

--Setup all the button and sub menu positions. This gets done right off the bat when the addon loads so the menus snap into place instantly instead of being calculated on the fly a split second after they appear, preventing the menu from visually "jumping". A text object has to first be visible on-screen in order to get it's dimensions to then be able to calculate where it should be placed on the screen. Thus we temporarily show it off-screen to do the calculations ahead of time with the user being none the wiser.
function setupMenu()
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

	--Give Windower a moment to display the text object
	coroutine.sleep(0.1)

	--Loop and try again if either width or height returns the blank value of 10 (max of 10 tries/1 second)
	local tries = 0
	repeat
		main_menu_total_width, main_menu_total_height = main_menu:extents()
		tries = tries + 1
		if (main_menu_total_width == 10 or main_menu_total_height == 10) and tries < 10 then
			coroutine.sleep(0.1)
		end
	until (main_menu_total_width ~= 10 and main_menu_total_height ~= 10) or tries >= 10

	main_menu_total_height = main_menu_total_height - (settings.padding * 2)
	local row_height = main_menu_total_height / menu_index

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

		--If there are no submenu labels, insert a fake "Empty" entry
		if #sorted_sub_labels == 0 then
			table.insert(sorted_sub_labels, "Empty")
			sub_entries = { ["Empty"] = nil } --overwrite with fake entry
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

		-- Store sorted submenu labels for display later
		sub_menu_button_positions[button_name].sorted_labels = sorted_sub_labels

		local sub_menu_height = sub_row * row_height
		local y_offset = row_height * (menu_index - sub_row)
		local x_offset = main_menu_total_width

		sub_menu_positions[button_name] = {x_offset = x_offset, y_offset = y_offset}

	end
	main_menu:hide()
end
setupMenu() --Immediately run on addon load

--Format RGB values with leading zeros (helps prevent an issue with the text wiggling around)
function formatRGB(value)

	return string.format("%03d", value)

end

function createNewCategory()
	--Check if that category label already exists
	if main_menu_data[keyboard_input] then
		add_to_chat(8, ('[TaskBar] ':color(220))..('Category '):color(8)..('%s'):format(keyboard_input):color(1)..(' already exists.'):color(28))
		return
	end

	main_menu_data[keyboard_input] = {}

	--Update the file
	local file_contents = help_msg
	file_contents = file_contents..'return '..T(main_menu_data):tovstring()
	menu_file:write(file_contents)

	add_to_chat(8, ('[TaskBar] ':color(220))..('Category '):color(8)..('%s'):format(keyboard_input):color(1)..(' created.'):color(8))

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

	--Close the Confirm window
	closeConfirmWindow()

	add_to_chat(8, ('[TaskBar] ':color(220))..('Category '):color(8)..('%s'):format(label):color(1)..(' deleted.'):color(8))

	--Reload the menu layout
	setupMenu()

end

function renameCategory()
	if not menu_button_right_clicked_on then return end

	local index = menu_button_right_clicked_on:match("main_menu_(%d+)")
	if not index then return end

	index = tonumber(index)
	local pos = main_menu_button_positions[index]
	if not pos or not pos.label then return end

	local old_label = pos.label

	--Don’t allow renaming to an existing category
	if main_menu_data[keyboard_input] then
		add_to_chat(8, ('[TaskBar] ':color(220))..('A category named '):color(8)..('%s'):format(keyboard_input):color(1)..(' already exists.'):color(28))
		return
	end

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

end

function checkCommandLabel()
	if not menu_button_right_clicked_on then return end

	--Which category are we in?
	local index = menu_button_right_clicked_on:match("menu_(%d+)")
	if not index then return end

	index = tonumber(index)
	local pos = main_menu_button_positions[index]
	if not pos or not pos.label then return end

	local category_name = pos.label

	--Check if the entered label already exists
	if main_menu_data[category_name][keyboard_input] then
		add_to_chat(8, ('[TaskBar] ':color(220))..('Command named '):color(8)..('%s'):format(keyboard_input):color(1)..(' already exists in category '):color(8)..('%s'):format(category_name):color(1)..('.'):color(28))
		keyboard_input = ""
		displayTextInputWindow("text_input_add_command_text", "New command name:")
	else
		active_command_label = keyboard_input
		keyboard_input = ""
		displayTextInputWindow("add_command", string.format('New command text for "%s" (Windower will directly execute this text when clicked):', active_command_label))
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

	--Close the Confirm window
	closeConfirmWindow()

	--Reload the menu layout
	setupMenu()

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

	add_to_chat(8, ('[TaskBar] ':color(220))..('Command for "%s" updated.'):format(label):color(8))
end

function updateTaskBar()
	task_bar:text(formatButton("[TASKBAR]", "open_task_bar"))
end

function closeConfirmWindow()
	confirm_window:hide()
end

function updateConfirmWindow()
	local display_text_parts = {}
	local message = "│ "..confirm_message.." │"
	local message_row_length = #confirm_message
	confirm_char_num = message_row_length + 4 --Used to position buttons

	--Title bar
	local confirm_title = "┌─Confirm"
	confirm_title = confirm_title..string.rep("─", message_row_length - 6).."┐"

	local empty_row = "│"..string.rep(" ", message_row_length +2).."│"

	--Buttons
	local yes_button = formatButton("YES", confirm_yes, true)
	local no_button = formatButton("NO", "confirm_no", true)
	local button_padding = math.floor(message_row_length - 7)
	local button_row = "│"..string.rep(" ", button_padding)..yes_button..no_button.."│"

	local bottom_row = "└"..string.rep("─", message_row_length + 2).."┘"


	--Assemble full window text
	table.insert(display_text_parts, confirm_title.."\n")
	table.insert(display_text_parts, empty_row.."\n")
	table.insert(display_text_parts, message.."\n")
	table.insert(display_text_parts, empty_row.."\n")
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

function saveTextInput()

	if text_input_accept == "add_category" then
		createNewCategory()
	elseif text_input_accept == "rename_category" then
		renameCategory()
	elseif text_input_accept == "add_command" then
		createNewCommand()
	elseif text_input_accept == "rename_command" then
		renameCommand()
	elseif text_input_accept == "edit_command" then
		editCommand()
	end

	--Close the Text Input window
	closeTextInput()

	--Reload the menu layout
	setupMenu()

end

function updateTextInputWindow(pre_filled_text)
	local display_text_parts = {}
	
	--Set the minimum width of the window (category/command labels are shorter, while commands can be much longer)
	local min_window_width = max_label_characters
	if text_input_accept == "add_command" or text_input_accept == "edit_command" then
		min_window_width = max_command_characters
	end
	
	local text_input_message_length = math.max(#text_input_message, min_window_width)
	local padding = math.floor((text_input_message_length - #text_input_message) / 2)
	local message = "│ "..string.rep(" ", padding)..text_input_message..string.rep(" ", text_input_message_length - #text_input_message - padding).." │"

	local message_row_length = math.max(#text_input_message + 4, min_window_width + 4)
	text_input_char_num = message_row_length -- Used to determine button positions

	--Title bar
	local text_input_title = "┌─Text Input"
	text_input_title = text_input_title..string.rep("─", message_row_length - 13).."┐"

	local empty_row = "│"..string.rep(" ", message_row_length - 2).."│"

	-- Keyboard input line
	local keyboard_input_display = (#keyboard_input < min_window_width) and (keyboard_input.."_") or keyboard_input
	local input_length = #keyboard_input_display
	local new_text = "│ " .. keyboard_input_display .. string.rep(" ", message_row_length - input_length - 3) .. "│"

	--Buttons
	local accept_button = formatButton("ACCEPT", text_input_accept, true)
	local cancel_button = formatButton("CANCEL", "text_input_cancel", true)
	local button_padding = math.floor(message_row_length - 18)
	local button_row = "│"..string.rep(" ", button_padding)..accept_button..cancel_button.."│"

	local bottom_row = "└"..string.rep("─", message_row_length - 2).."┘"

	--Assemble full window text
	table.insert(display_text_parts, text_input_title.."\n")
	table.insert(display_text_parts, empty_row.."\n")
	table.insert(display_text_parts, message.."\n")
	table.insert(display_text_parts, empty_row.."\n")
	table.insert(display_text_parts, new_text.."\n")
	table.insert(display_text_parts, empty_row.."\n")
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

		label = "│"..label.." >"

		local formatted = formatButton(label, pos.button)
		table.insert(display_text_parts, formatted.."\n")
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
	
		formatted_label = "│"..formatted_label
	
		local button_text = formatButton(formatted_label, button_name)
		table.insert(display_text_parts, button_text.."\n")
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
		table.insert(display_text_parts, formatButton("│Rename Category", "text_input_rename_category_"..button_name).."\n")
		table.insert(display_text_parts, formatButton("│Delete Category", "confirm_delete_category_"..button_name).."\n")
		table.insert(display_text_parts, formatButton("│Add New Category", "text_input_add_category").."\n")
		table.insert(display_text_parts, formatButton("│Add New Command", "text_input_add_command_"..button_name).."\n")

	elseif menu_button_right_clicked_on:match("sub_menu_") then
		--Strip the prefix first so its not added to each button
		button_name = button_name:gsub("^text_input_rename_command_", ""):gsub("^text_input_edit_command_", ""):gsub("^confirm_delete_command_", ""):gsub("^text_input_add_command_", "")
		table.insert(display_text_parts, formatButton("│Rename Command", "text_input_rename_command_"..button_name).."\n")
		table.insert(display_text_parts, formatButton("│Edit Command", "text_input_edit_command_"..button_name).."\n")
		table.insert(display_text_parts, formatButton("│Delete Command", "confirm_delete_command_"..button_name).."\n")
		table.insert(display_text_parts, formatButton("│Add New Command", "text_input_add_command_"..button_name).."\n")

	end

	table.insert(display_text_parts, formatButton("│Options (coming soon)", "open_options_window"))
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
		displayConfirmWindow("delete_category", string.format('Delete "%s" and ALL commands within?', category_name))

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

	end

end

--Return which button the mouse is hovering over
function getMouseOnButton(mouse_x, mouse_y)

	local task_bar_button_position = {
		{button = "open_task_bar"},
	}

	--TaskBar button
	--No need to math out how wide each button is since the entire width is the button area
	local task_bar_grid_pos = {x = task_bar:pos_x(), y = task_bar:pos_y()}
	local task_bar_total_width, task_bar_total_height = task_bar:extents()

	--Determine which button the mouse is over
	for _, pos in ipairs(task_bar_button_position) do
		if mouse_x >= task_bar_grid_pos.x
		and mouse_x <= task_bar_grid_pos.x + task_bar_total_width
		and mouse_y >= task_bar_grid_pos.y
		and mouse_y <= task_bar_grid_pos.y + task_bar_total_height then
			return pos.button
		end
	end

	--Confirm Window buttons
	if confirm_window:visible() then
		local confirm_grid_pos = {x = confirm_window:pos_x(), y = confirm_window:pos_y()}
		local confirm_total_width, confirm_total_height = confirm_window:extents()
		local confirm_grid_width = confirm_total_width - (settings.padding * 2) --Width of the grid area (excludes padding)
		local confirm_grid_height = confirm_total_height - (settings.padding * 2) --Height of the grid area (excludes padding)
		local confirm_button_width = confirm_grid_width / confirm_char_num
		local confirm_button_height = confirm_grid_height / 6
		local confirm_button_positions = {
			{button = confirm_yes, x_begin = confirm_char_num - 8, x_end = confirm_char_num - 6, y = 5},
			{button = "confirm_no", x_begin = confirm_char_num - 3, x_end = confirm_char_num - 2, y = 5},
		}

		--Determine which button the mouse is over
		for _, pos in ipairs(confirm_button_positions) do
			if mouse_x >= confirm_grid_pos.x + (confirm_button_width * (pos.x_begin - 1))
			and mouse_x <= confirm_grid_pos.x + (confirm_button_width * pos.x_end)
			and mouse_y >= confirm_grid_pos.y + settings.padding + (confirm_button_height * (pos.y - 1))
			and mouse_y <= confirm_grid_pos.y + settings.padding + (confirm_button_height * pos.y) then
				return pos.button
			end
		end

	--Text Input Window buttons
	elseif text_input_window:visible() then
		local text_input_grid_pos = {x = text_input_window:pos_x(), y = text_input_window:pos_y()}
		local text_input_total_width, text_input_total_height = text_input_window:extents()
		local text_input_grid_width = text_input_total_width - (settings.padding * 2) --Width of the grid area (excludes padding)
		local text_input_grid_height = text_input_total_height - (settings.padding * 2) --Height of the grid area (excludes padding)
		local text_input_button_width = text_input_grid_width / text_input_char_num
		local text_input_button_height = text_input_grid_height / 8
		local text_input_button_positions = {
			{button = text_input_accept, x_begin = text_input_char_num - 15, x_end = text_input_char_num - 10, y = 7},
			{button = "text_input_cancel", x_begin = text_input_char_num - 7, x_end = text_input_char_num - 2, y = 7},
		}

		--Determine which button the mouse is over
		for _, pos in ipairs(text_input_button_positions) do
			if mouse_x >= text_input_grid_pos.x + (text_input_button_width * (pos.x_begin - 1))
			and mouse_x <= text_input_grid_pos.x + (text_input_button_width * pos.x_end)
			and mouse_y >= text_input_grid_pos.y + settings.padding + (text_input_button_height * (pos.y - 1))
			and mouse_y <= text_input_grid_pos.y + settings.padding + (text_input_button_height * pos.y) then
				return pos.button
			end
		end

	--Right-Click Menu buttons
	--No need to math out how wide each button is since the entire width is the button area
	elseif right_click_menu:visible() then
		local right_click_menu_grid_pos = {x = right_click_menu:pos_x() + settings.padding, y = right_click_menu:pos_y() + settings.padding}
		local right_click_menu_total_width, right_click_menu_total_height = right_click_menu:extents()
		local right_click_menu_grid_width = right_click_menu_total_width - (settings.padding * 2) --Width of the grid area (excludes padding)
		local right_click_menu_grid_height = right_click_menu_total_height - (settings.padding * 2) --Height of the grid area (excludes padding)
		local right_click_menu_button_height = 0

		local right_click_menu_button_positions = {}

		if menu_button_right_clicked_on == "task_bar" then
			right_click_menu_button_height = right_click_menu_grid_height
			right_click_menu_button_positions = {
				{button = "open_options_window", y = 1},
			}
		elseif menu_button_right_clicked_on:match("main_menu_") then
			right_click_menu_button_height = right_click_menu_grid_height / 5
			right_click_menu_button_positions = {
				{button = "text_input_rename_category_"..menu_button_right_clicked_on, y = 1},
				{button = "confirm_delete_category_"..menu_button_right_clicked_on, y = 2},
				{button = "text_input_add_category", y = 3},
				{button = "text_input_add_command_"..menu_button_right_clicked_on, y = 4},
				{button = "open_options_window", y = 5},
			}

		elseif menu_button_right_clicked_on:match("sub_menu_") then
			right_click_menu_button_height = right_click_menu_grid_height / 5
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
			if mouse_x >= right_click_menu_grid_pos.x
			and mouse_x <= right_click_menu_grid_pos.x + right_click_menu_total_width
			and mouse_y >= right_click_menu_grid_pos.y + (right_click_menu_button_height * (pos.y - 1))
			and mouse_y <= right_click_menu_grid_pos.y + (right_click_menu_button_height * pos.y) then
				return pos.button
			end
		end

	end

	--Main menu buttons
	if main_menu:visible() and not right_click_menu:visible() then
		local main_menu_grid_pos = {x = main_menu:pos_x() + settings.padding, y = main_menu:pos_y() + settings.padding}
		local main_menu_grid_width = main_menu_total_width - (settings.padding * 2) --Width of the grid area (excludes padding)
		local main_menu_grid_height = main_menu_total_height - (settings.padding * 2) --Height of the grid area (excludes padding)
		local main_menu_button_width = main_menu_grid_width / main_menu_columns
		local main_menu_button_height = main_menu_grid_height / main_menu_rows

		--Determine which button the mouse is over
		for _, pos in ipairs(main_menu_button_positions) do
			if mouse_x >= main_menu_grid_pos.x + (main_menu_button_width * (pos.x_begin - 1))
			and mouse_x <= main_menu_grid_pos.x + (main_menu_button_width * pos.x_end)
			and mouse_y >= main_menu_grid_pos.y + (main_menu_button_height * (pos.y - 1))
			and mouse_y <= main_menu_grid_pos.y + (main_menu_button_height * pos.y) then
				return pos.button
			end
		end

	end

	--Sub menu buttons
	if sub_menu:visible() and not right_click_menu:visible() then
		local sub_menu_key = "main_menu_"..active_sub_menu
		local sub_menu_grid_pos = {x = sub_menu:pos_x() + settings.padding, y = sub_menu:pos_y() + settings.padding}
		local sub_menu_total_width, sub_menu_total_height = sub_menu:extents()
		local sub_menu_grid_width = sub_menu_total_width - (settings.padding * 2) --Width of the grid area (excludes padding)
		local sub_menu_grid_height = sub_menu_total_height - (settings.padding * 2) --Height of the grid area (excludes padding)

		local sub_menu_button_width = sub_menu_grid_width / sub_menu_columns
		local sub_menu_button_height = sub_menu_grid_height / sub_menu_rows[sub_menu_key]

		local button_positions = sub_menu_button_positions[sub_menu_key]
		if button_positions then
			for _, pos in ipairs(button_positions) do
				if mouse_x >= sub_menu_grid_pos.x + (sub_menu_button_width * (pos.x_begin - 1))
				and mouse_x <= sub_menu_grid_pos.x + (sub_menu_button_width * pos.x_end)
				and mouse_y >= sub_menu_grid_pos.y + settings.padding + (sub_menu_button_height * (pos.y - 1))
				and mouse_y <= sub_menu_grid_pos.y + settings.padding + (sub_menu_button_height * pos.y) then
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

	--I've changed the actual logic to Do The Thing when clicking the mouse to when the mouse click is finished since every single click is technically two actions (mouse down then mouse up). This makes it easier to block clicks from reaching the game based on when the menus are open and not get the cursor stuck running your character or spinning the camera in a circle. This lets us cleanly click on menu buttons, and click outside of the menu to close it, without passing the clicks to the game.

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

	--Show main menu when hovering over task bar
	if mouse_is_on == "open_task_bar" and not (main_menu:visible() or right_click_menu:visible() or text_input_window:visible() or confirm_window:visible()) then
		main_menu:show()
		coroutine.schedule(function()
			main_menu_total_width, main_menu_total_height = main_menu:extents()
			local pos = {x = task_bar:pos_x(), y = task_bar:pos_y() - main_menu_total_height}
			main_menu:pos(pos.x, pos.y)
		end, 0.05)
		updateTaskBar()
	end

	if confirm_window:visible() then
		updateConfirmWindow()
		
		if mouse_type == 1 then --leftmousedown
			return true --blocked from reaching game

		elseif mouse_type == 2 then --leftmouseup

			if mouse_is_on == "confirm_no" then
				closeConfirmWindow()
			elseif mouse_is_on == "delete_category" then
				deleteCategory()
			elseif mouse_is_on == "delete_command" then
				deleteCommand()
			end
		end

	elseif text_input_window:visible() then
		updateTextInputWindow()

		if mouse_type == 1 then --leftmousedown
			return true --blocked from reaching game

		elseif mouse_type == 2 then --leftmouseup

			if mouse_is_on == "text_input_cancel" then
				closeTextInput()
			elseif mouse_is_on == "text_input_add_command_text" then
				checkCommandLabel()
			elseif mouse_is_on == "add_category" or mouse_is_on == "rename_category" or mouse_is_on == "add_command" or mouse_is_on == "rename_command" or mouse_is_on == "edit_command" then
				saveTextInput()
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

	if sub_menu:visible() and not (right_click_menu:visible() or text_input_window:visible() or confirm_window:visible()) then
		updateSubMenu()
	end

	--Main menu is visible, ie TaskBar is open
	if main_menu:visible() and not (right_click_menu:visible() or text_input_window:visible() or confirm_window:visible()) then
		updateMainMenu()

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

			else
				menu_button_right_clicked_on = mouse_is_on
				local pos_adjust_map = {
					["open_task_bar"] = 30,
					["main_menu_"] = 87,
					["sub_menu_"] = 106
				}
				local pos_adjust = 0
				if menu_button_right_clicked_on == "open_task_bar" then
					pos_adjust = pos_adjust_map["open_task_bar"]
				elseif menu_button_right_clicked_on:match("^main_menu_") then
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
					checkCommandLabel()
				else
					saveTextInput()
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
		task_bar:hide()
	elseif pos ~= "(?-?)" and zoning then
		zoning = false
		task_bar:show()
	end

	--Save Text Input window position if dragged
	if text_input_window:visible() then
		local x, y = text_input_window:pos()
		if not settings.window or settings.window.x ~= x or settings.window.y ~= y then
			settings.window.pos = {x = x, y = y}
			settings:save()
		end
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
