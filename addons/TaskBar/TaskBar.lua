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
_addon.version = '1.0 BETA-1'
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
}

--Load those default settings into the 'settings' variable for the addon to use
settings = config.load(defaults)

--Default/example menu to pre-populate the data\menu.lua file with to start us off, the user can then change the menu structure however they see fit in the data\menu.lua file itself
main_menu = {
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
		["HP: Rabao"] = "hp rabao 2;wait 13;find moglophone;wait 1;find moogle amplifier",
		["HP: Ru'Lude Gard. AH"] = "hp rul ah",
		["HP: Tav. Interchange"] = "hp tavn",
		["SG: Tav. Interchange"] = "sg tavn",
		["SG: King Ranp. Tomb"] = "sg king",
	},
}

menu_file = files.new('data\\menu.lua')

--If the data\menu.lua file doesn't exist, create it
if not menu_file:exists() then
	coroutine.schedule(function()
		add_to_chat(8,('[TaskBar] ':color(220))..('The menu.xml file has been pre-populated with an example menu structure.'):color(8))
		add_to_chat(8,('[TaskBar] ':color(220))..('Use this as a guide to create your own customized menu. Enjoy!  -Key'):color(8))
	end, 1)
	local help_msg = '--Use this pre-populated menu as a guide to create your own customized menu.\n'
	menu_file:write(help_msg..'return '..T(main_menu):tovstring())
end

--Load the menu from the data\menu.lua file
settings.main_menu = require('data.menu')

mouse_is_on = nil --Used to determine where the mouse is.
main_menu_visible = false --Flag to determine if the main window is visible or not.
sub_menu_visible = false --Flag to determine if the confirmation window is visible or not.
max_label_characters = 20 --Maximum number of characters a label will display before getting automatically truncated. Also controls the overall width of the menus
zoning = false
main_menu_button_positions = {} --Stores Main menu buttons created from the settings file.
sub_menu_button_positions = {} --Stores Sub menu buttons created from the settings file.
active_sub_menu = nil --Used to store which sub menu is currently displayed

--Colors
off_white = {r = 140, g = 140, b = 140}
highlight = {r = 255, g = 255, b = 255}

--UI Elements
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

main_menu = texts.new()
main_menu:bg_color(settings.bg.red, settings.bg.green, settings.bg.blue, settings.bg.alpha)
main_menu:font(settings.text.font)
main_menu:size(settings.text.size + 2)
main_menu:alpha(settings.text.alpha)
main_menu:bold(settings.flags.bold)
main_menu:pad(settings.padding)
main_menu:draggable(false)

sub_menu = texts.new()
sub_menu:bg_color(settings.bg.red, settings.bg.green, settings.bg.blue, settings.bg.alpha)
sub_menu:font(settings.text.font)
sub_menu:size(settings.text.size + 2)
sub_menu:alpha(settings.text.alpha)
sub_menu:bold(settings.flags.bold)
sub_menu:pad(settings.padding)
sub_menu:draggable(false)

--Format button text with hover effect
function formatButton(label, hover_key)
	local color = off_white

    local is_hovered = (mouse_is_on == hover_key)
    local main_menu_index = hover_key:match("^main_menu_(%d+)")
    local is_active_menu = main_menu_index and tonumber(main_menu_index) == active_sub_menu

    if is_hovered or is_active_menu or (hover_key == "open_task_bar" and main_menu_visible) then
        color = highlight
    end

	return string.format("\\cs(%d,%d,%d)%s\\cr", color.r, color.g, color.b, label)
end

--Setup all the button and sub menu positions. This gets done right off the bat when the addon loads so the menus snap into place instantly instead of being calculated on the fly a split second after they appear, preventing the menu from visually "jumping". A text object has to first be visible on-screen in order to get it's dimensions to then be able to calculate where it should be placed on the screen. Thus we temporarily show it off-screen to do the calculations ahead of time with the user being none the wiser.
function setupMenuButtonPositions()
	main_menu_rows = 0
	sub_menu_rows = {}
	main_menu_button_positions = {}
	sub_menu_button_positions = {}
	sub_menu_positions = {}
	main_menu_columns = max_label_characters + 3 -- Account for adding the "|" and " >"
	sub_menu_columns = max_label_characters + 1 -- Account for adding the "|"

	local temp_lines = {}
	local menu_index = 0

	--Sort main menu labels
	local sorted_main_labels = {}
	for label in pairs(settings.main_menu) do
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

		label = "|"..label.." >"
		local formatted = formatButton(label, button_name)
		table.insert(temp_lines, formatted.."\n")
	end

	main_menu:text(table.concat(temp_lines))
	main_menu:pos(-1000, -1000)
	main_menu:show()

	--Give Windower a moment to display the text object so that we can then get its dimensions
	coroutine.sleep(0.1)

	main_menu_total_width, main_menu_total_height = main_menu:extents()
	main_menu_total_height = main_menu_total_height - (settings.padding * 2)
	local row_height = main_menu_total_height / menu_index

	--Re-loop to calculate positions, in sorted order
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

		local sub_entries = settings.main_menu[main_label]
		local sub_buttons = {}
		local sub_row = 0

		--Sort submenu labels too
		local sorted_sub_labels = {}
		for sub_label in pairs(sub_entries) do
			table.insert(sorted_sub_labels, sub_label)
		end
		table.sort(sorted_sub_labels)

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
end
setupMenuButtonPositions() --Immediately run on addon load

--Format RGB values with leading zeros (helps prevent an issue with the text wiggling around)
function formatRGB(value)

	return string.format("%03d", value)

end

function updateTaskBar()
	task_bar:text(formatButton("[TASKBAR]", "open_task_bar"))
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

		label = "|"..label.." >"

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

	local sub_menu_data = settings.main_menu[menu_pos.label]
	if not sub_menu_data then return end

	local button_key = "main_menu_"..active_sub_menu
	local sorted_labels = sub_menu_button_positions[button_key].sorted_labels
	if not sorted_labels then return end

	local display_text_parts = {}
	local sub_index = 0

	for _, label in ipairs(sorted_labels) do
		local command = sub_menu_data[label]
		if command then
			sub_index = sub_index + 1
			local button_name = "sub_menu_"..active_sub_menu.."_"..sub_index

			--Format label
			local formatted_label = label
			if #formatted_label > max_label_characters then
				formatted_label = formatted_label:sub(1, max_label_characters - 1).."…"
			else
				formatted_label = formatted_label..string.rep(" ", max_label_characters - #formatted_label)
			end

			formatted_label = "|"..formatted_label

			local button_text = formatButton(formatted_label, button_name)
			table.insert(display_text_parts, button_text.."\n")
		end
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

	local sub_menu = settings.main_menu[menu_pos.label]
	if not sub_menu then return end

	local button_key = "main_menu_"..main_index
	local sorted_labels = sub_menu_button_positions[button_key].sorted_labels
	if not sorted_labels then return end

	local label = sorted_labels[sub_index]
	if not label then return end

	local command = sub_menu[label]
	if command then
		windower.send_command(command)
	end
end

--Return which button the mouse is hovering over
function getMouseOnButton(mouse_x, mouse_y)

	local task_bar_button_position = {
		{button = "open_task_bar", x_begin = 1, x_end = 9, y = 1},
	}

	--TaskBar button
	local task_bar_grid_pos = {x = task_bar:pos_x(), y = task_bar:pos_y()}
	local task_bar_total_width, task_bar_total_height = task_bar:extents()
	local task_bar_button_width = task_bar_total_width / 9 --([TASKBAR] is 9 characters)
	local task_bar_button_height = task_bar_total_height / 1

	--Determine which button the mouse is over
	for _, pos in ipairs(task_bar_button_position) do
		if mouse_x >= task_bar_grid_pos.x + (task_bar_button_width * (pos.x_begin - 1))
		and mouse_x <= task_bar_grid_pos.x + (task_bar_button_width * pos.x_end)
		and mouse_y >= task_bar_grid_pos.y + (task_bar_button_height * (pos.y - 1))
		and mouse_y <= task_bar_grid_pos.y + (task_bar_button_height * pos.y) then
			return pos.button
		end
	end

	--Main menu buttons
	if main_menu_visible then
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
	if sub_menu_visible then
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
		main_menu_visible = false
		main_menu:hide()
		sub_menu_visible = false
		sub_menu:hide()
		active_sub_menu = nil
		updateTaskBar()
	end

	--Get the mouse position relative to the grid
	mouse_is_on = getMouseOnButton(mouse_x, mouse_y)

	updateTaskBar()

	--Show main menu when hovering over task bar
	if mouse_is_on == "open_task_bar" and not main_menu_visible then
		main_menu:show()
		main_menu_visible = true
		coroutine.schedule(function()
			main_menu_total_width, main_menu_total_height = main_menu:extents()
			local pos = {x = task_bar:pos_x(), y = task_bar:pos_y() - main_menu_total_height}
			main_menu:pos(pos.x, pos.y)
		end, 0.05)
	end

	--Main menu is visible, ie TaskBar is open
	if main_menu_visible then
		updateMainMenu()

		--Check if hovering over a main menu button
		local main_menu_index = mouse_is_on and mouse_is_on:match("^main_menu_(%d+)")
		if main_menu_index then
			local menu_pos = main_menu_button_positions[tonumber(main_menu_index)]
			if menu_pos and menu_pos.label then
				local submenu = settings.main_menu[menu_pos.label]
				if submenu then
					active_sub_menu = tonumber(main_menu_index)
			
					if not sub_menu_visible then
						sub_menu:show()
						sub_menu_visible = true
					end
				else
					if sub_menu_visible then
						sub_menu:hide()
						sub_menu_visible = false
					end
				end
			end			
		end

		if mouse_type == 1 then --leftmousedown
			return true --blocked from reaching game

		elseif mouse_type == 2 then --leftmouseup

			--Handle clicks
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
			
		elseif mouse_type == 5 and mouse_is_on == "none" then --rightmouseup
			--Clicked outside the menu, close the menus
			closeMenus()
			return true --blocked from reaching game

		end

	end

	if sub_menu_visible then
		updateSubMenu()
	end

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

end)

	register_event('addon command',function(add_cmd)

	if add_cmd == "help" then
		local currSize = settings.text.size
		local prefix = "//taskbar"
		add_to_chat(8,('[TaskBar] ':color(220))..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220)..(' ('):color(8)..(prefix):color(1)..(')'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,('This addon has no commands. Have a great day :)'):color(8))

	end
end)

updateTaskBar()
