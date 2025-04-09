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
    * Neither the name of GaolPlan nor the names of its contributors may be
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

_addon.name = 'GaolPlan'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.version = '1.1'
_addon.commands = {'gaolplan', 'gp'}

require 'logger'
config = require('config')
texts = require('texts')

register_event = windower.register_event
get_party = windower.ffxi.get_party
add_to_chat = windower.add_to_chat
input = windower.chat.input
send_command = windower.send_command
open_url = windower.open_url
copy_to_clipboard = windower.copy_to_clipboard

defaults = {
	pos = {x = 200, y = 300},
	bg = {alpha = 195, red = 0, green = 0, blue = 0},
	text = {alpha = 255, blue = 255, green = 255, red = 255, font = 'Consolas', size = 10},
	flags = {draggable = true, italic = false, bold = true, right = false, bottom = false},
	padding = 5,
	options = {
		hover_effects = true
	},
	save_data = {
		save_1 = {
			phone_selection = {nil, nil, nil},
			player_jobs = {blm = nil, blu = nil, brd = nil, bst = nil, cor = nil, dnc = nil, drg = nil, drk = nil, geo = nil, mnk = nil, nin = nil, pld = nil, pup = nil, rdm = nil, rng = nil, run = nil, sam = nil, sch = nil, smn = nil, thf = nil, war = nil, whm = nil}
		},
		save_2 = {
			phone_selection = {nil, nil, nil},
			player_jobs = {blm = nil, blu = nil, brd = nil, bst = nil, cor = nil, dnc = nil, drg = nil, drk = nil, geo = nil, mnk = nil, nin = nil, pld = nil, pup = nil, rdm = nil, rng = nil, run = nil, sam = nil, sch = nil, smn = nil, thf = nil, war = nil, whm = nil}
		},
		save_3 = {
			phone_selection = {nil, nil, nil},
			player_jobs = {blm = nil, blu = nil, brd = nil, bst = nil, cor = nil, dnc = nil, drg = nil, drk = nil, geo = nil, mnk = nil, nin = nil, pld = nil, pup = nil, rdm = nil, rng = nil, run = nil, sam = nil, sch = nil, smn = nil, thf = nil, war = nil, whm = nil}
		},
		save_4 = {
			phone_selection = {nil, nil, nil},
			player_jobs = {blm = nil, blu = nil, brd = nil, bst = nil, cor = nil, dnc = nil, drg = nil, drk = nil, geo = nil, mnk = nil, nin = nil, pld = nil, pup = nil, rdm = nil, rng = nil, run = nil, sam = nil, sch = nil, smn = nil, thf = nil, war = nil, whm = nil}
		},
		save_5 = {
			phone_selection = {nil, nil, nil},
			player_jobs = {blm = nil, blu = nil, brd = nil, bst = nil, cor = nil, dnc = nil, drg = nil, drk = nil, geo = nil, mnk = nil, nin = nil, pld = nil, pup = nil, rdm = nil, rng = nil, run = nil, sam = nil, sch = nil, smn = nil, thf = nil, war = nil, whm = nil}
		},
	}
}

settings = config.load(defaults)

heartbeat = 0
hover = nil --Used to determine which button is being hovered over
current_screen = "bosses"
previous_screen = nil
main_window_visible = false --Flag to determine if the main window is visible or not
confirm_window_visible = false --Flag to determine if the confirmation window is visible or not
confirm_yes = nil --Used to determine what the Yes button does in the confirmation window
confirm_message = nil --Used to determine what the confirmation message is
hover_effects = settings.options.hover_effects
jobs_row_num = 0 --Used to count the number of rows in the grid to know where the buttons on the bottom of the jobs screen will be
confirm_char_num = 0 --Used to count the number of characters in the confirmation message to determine how wide the confirmation window will be
boss_num = 0 --Used to count the number of bosses selected to determine where the buttons for jobs will be
double_click_fix = true --Fix a weird double-click bug in windower
bg_alpha_num = settings.bg.alpha --Temporarily store the bg_alpha value of the main window to be used when the confirm window is closed
text_alpha_num = settings.text.alpha --Temporarily store the text_alpha value of the main window to be used when the confirm window is closed

--Define bosses list with section headers
bosses = {
	{label = "Atonement 1"}, {"Dealan-dhe", "Sgili", "U Bnai", "Gogmagog"},
	{label = "Atonement 2"}, {"Aristaeus", "Raskovniche", "Marmorkrebs", "Gigelorum", "Procne", "Henwen"},
	{label = "Atonement 3"}, {"Xevioso", "Ngai", "Kalunga", "Ongo", "Mboze", "Arebati"},
	{label = "Atonement 4"}, {"Bumba"}
}

--Boss variable names to formatted name matching
boss_map = {
	dealan_dhe = "Dealan-dhe", sgili = "Sgili", u_bnai = "U Bnai", gogmagog = "Gogmagog",
	aristaeus = "Aristaeus", raskovniche = "Raskovniche", marmorkrebs = "Marmorkrebs",
	gigelorum = "Gigelorum", procne = "Procne", henwen = "Henwen", xevioso = "Xevioso",
	ngai = "Ngai", kalunga = "Kalunga", ongo = "Ongo", mboze = "Mboze", arebati = "Arebati",
	bumba = "Bumba"
}

--Colors
off_white = {r = 150, g = 150, b = 150}
highlight = {r = 255, g = 255, b = 255}
disable = {r = 200, g = 100, b = 100}
ph1_color = {r = 75, g = 255, b = 75}
ph2_color = {r = 0, g = 200, b = 255}
ph3_color = {r = 255, g = 255, b = 50}
colors = {
	ph1 = ph1_color,
	ph2 = ph2_color,
	ph3 = ph3_color
}

--Initialize boss selections
phone_selection = {nil, nil, nil}

--Stores selected party member for each job
player_jobs = {blm = nil, blu = nil, brd = nil, bst = nil, cor = nil, dnc = nil, drg = nil, drk = nil, geo = nil, mnk = nil, nin = nil, pld = nil, pup = nil, rdm = nil, rng = nil, run = nil, sam = nil, sch = nil, smn = nil, thf = nil, war = nil, whm = nil}

--UI Elements
main_window = texts.new(settings)
confirm_window = texts.new()
confirm_window:bg_color(settings.bg.red, settings.bg.green, settings.bg.blue, settings.bg.alpha)
confirm_window:font(settings.text.font)
confirm_window:size(settings.text.size)
confirm_window:alpha(settings.text.alpha)
confirm_window:bold(settings.flags.bold)
confirm_window:pad(settings.padding)

--Format names so they fit correctly into the Job Selection screen
local function formatName(str)

	--Check if the string length is less than 8
	if #str < 8 then
		--Pad with spaces to make it exactly 8 characters
		str = str .. string.rep(" ", 8 - #str)
	elseif #str > 8 then
		--Truncate to 7 characters and add an ellipsis
		str = string.sub(str, 1, 7) .. "…"
	end

	return str

end

--Format RGB values with leading zeros (helps prevent an issue with the text wiggling around)
function formatRGB(value)

	return string.format("%03d", value)

end

--Format button text with hover effect
function formatButton(label, hover_key, highlight_override)
	local color = off_white
	if highlight_override == "disable" then
		color = disable
	elseif highlight_override == "highlight" or hover == hover_key then
		color = highlight
	end
	return "[\\cs("..color.r..","..color.g..","..color.b..")"..label.."\\cr]"
end

--Check if any job has been assigned
function isAnyJobAssigned(phone)
	if phone then
		local target = "ph" .. phone .. "_"
		for _, v in pairs(player_jobs) do
			if v and v:sub(1, #target) == target then
				return true
			end
		end
	else
		for _, v in pairs(player_jobs) do
			if v ~= nil then
				return true
			end
		end
	end

	return false
end

--Check if any boss has been assigned to any phone
function isAnyBossAssigned()

	local assigned = (phone_selection[1] ~= nil or phone_selection[2] ~= nil or phone_selection[3] ~= nil)
	return assigned

end

--Check if save data is preset
function isSaveDataPresent(save_num)
	local selections = settings.save_data[save_num] and settings.save_data[save_num].phone_selection

	if selections then
		for i = 1, 3 do
			local name = selections[tostring(i)]
			if name and name ~= "" then
				return true
			end
		end
	end

	return false
end

function generatePlanOutput()

	local plan_output = {}

	for phone_index, boss in ipairs(phone_selection) do
		if boss then
			local phone_string = '['..phone_index..'-'..boss.."] "
			local player_assignments = {}

			--Loop through each party member
			for p = 1, 6 do
				local player_key = "ph"..phone_index.."_pl"..p
				local player_name = get_party()["p"..(p-1)] and get_party()["p"..(p-1)].name or "Player "..p
				--Truncate if the players name is longer than 8 characters
				if #player_name > 8 then
					player_name = string.sub(player_name, 1, 7) .. "."
				end

				--Find the job assigned to this player
				local assigned_job = nil
				for job, assigned_player in pairs(player_jobs) do
					if assigned_player == player_key then
						assigned_job = job:upper()  --Convert job to uppercase
						break
					end
				end

				--If no job is assigned, use "None" or a placeholder
				if not assigned_job then
					assigned_job = "None"
				end

				--Format it and add to the list
				table.insert(player_assignments, player_name..": "..assigned_job)
			end

			--Concatenate player assignments into a single string and add it to the plan_output table
			phone_string = phone_string..table.concat(player_assignments, "  ")
			plan_output["phone_"..phone_index] = phone_string

		end
	end

	return plan_output
end

function updateConfirmWindow()
	local display_text_parts = {} --Use a table to store strings for faster concatenation
	local message = confirm_message
	message = "| "..message.." |"
	local message_length = #message
	confirm_char_num = message_length --Used to determine the position of the buttons
	local confirm_title = "--Confirm"
	confirm_title = confirm_title..string.rep("-", message_length - 9) --Fill in dashes to the right of the title
	local empty_row = "|"..string.rep(" ", message_length - 2).."|"
	local button_row = "|"..string.rep(" ", message_length - 12)
	local bottom_row = string.rep("-", message_length)

	table.insert(display_text_parts, confirm_title.."\n")
	table.insert(display_text_parts, empty_row.."\n")
	table.insert(display_text_parts, message.."\n")
	table.insert(display_text_parts, empty_row.."\n")
	table.insert(display_text_parts, button_row)
	table.insert(display_text_parts, formatButton("YES", confirm_yes))
	table.insert(display_text_parts, formatButton("NO", "confirm_no").." |\n")
	table.insert(display_text_parts, bottom_row)

	--Concatenate everything at once
	display_text = table.concat(display_text_parts)
	confirm_window:text(display_text)
end

function displayConfirmWindow(button, message)
	confirm_window_visible = true
	confirm_yes = button --Store the button that was clicked for later use
	confirm_message = message --Store the message for later use

	updateConfirmWindow()

	--Show the Confirm window, dim the Main window
	confirm_window:bg_alpha(255)
	confirm_window:show()
	bg_alpha_num = settings.bg.alpha --Store the current bg_alpha value of the main window
	text_alpha_num = settings.text.alpha --Store the current text_alpha value of the main window
	main_window:bg_alpha(settings.bg.alpha / 3)
	main_window:alpha(settings.text.alpha / 3)

	 --Delay the positioning by 0.05 seconds to allow the window to be created first
	coroutine.schedule(function()
		--Calculate the position of the confirmation window
		local main_total_width, main_total_height = main_window:extents()
		local confirm_total_width, confirm_total_height = confirm_window:extents()
		local x = settings.pos.x + ((main_total_width / 2) - (confirm_total_width / 2))
		local y = settings.pos.y + ((main_total_height / 2) - (confirm_total_height / 2))
		confirm_window:pos(x,y)
	end, .01)
end

function hideConfirmWindow()
	confirm_window:hide()
	confirm_window_visible = false
	main_window:bg_alpha(bg_alpha_num) --Restore the main window's bg_alpha value
	main_window:alpha(text_alpha_num) --Restore the main window's text_alpha value
end

--Update the combined boss and job selection display
function updateMainWindow()

	local display_text = ""
	local pin = settings.flags.draggable and "○" or "•"

	--Return which Phone is hovered over
	local function getPhone(hover)
		local prefix = hover and hover:sub(1, 3) --Extract the first three characters
		if prefix == "ph1" or prefix == "ph2" or prefix == "ph3" then
			return prefix
		end
		return nil
	end

	--Return which boss is hovered over
	local function getBoss(hover)
		local valid_suffixes = {
			"dealan_dhe", "sgili", "u_bnai", "gogmagog", "aristaeus", 
			"raskovniche", "marmorkrebs", "gigelorum", "procne", "henwen", 
			"xevioso", "ngai", "kalunga", "ongo", "mboze", "arebati", "bumba"
		}
		local suffix = hover and #hover > 4 and hover:sub(5) or nil
		for _, valid_suffix in ipairs(valid_suffixes) do
			if suffix == valid_suffix then
				return suffix
			end
		end
		return nil
	end

	local function getPlayer(hover)
		return hover and hover:sub(5, 7)
	end

	if current_screen == "bosses" then

		local display_text_parts = {} --Use a table to store strings for faster concatenation
		local hover_phone = getPhone(hover)
		local hover_name = getBoss(hover)

		--Add title and buttons
		table.insert(display_text_parts, "GaolPlan - Bosses            ")
		table.insert(display_text_parts, formatButton(pin, "pin"))
		table.insert(display_text_parts, formatButton("X", "close").."\n")

		--Add phone number selections with color coding
		table.insert(display_text_parts, "                      | \\cs("..ph1_color.r..","..ph1_color.g..","..ph1_color.b..")1\\cr ")
		table.insert(display_text_parts, "| \\cs("..ph2_color.r..","..ph2_color.g..","..ph2_color.b..")2\\cr ")
		table.insert(display_text_parts, "| \\cs("..ph3_color.r..","..ph3_color.g..","..ph3_color.b..")3\\cr |\n")

		for _, entry in ipairs(bosses) do

			if entry.label then

				table.insert(display_text_parts, "      "..entry.label.."     -------------\n") --Display Atonement headers

			else

				for _, boss in ipairs(entry) do

					local total_width = 35
					local spaces = string.rep(" ", total_width - #boss - 13)

					-- Check if the boss is selected for any phone
					local is_selected = false
					for i = 1, 3 do
						if phone_selection[i] == boss then
							is_selected = true
							break
						end
					end

					--Determine boss name color
					local c = off_white
					if boss_map[hover_name] == boss then
						c = colors[hover_phone] --Use phone color if mouse is over it
					elseif is_selected then
						c = highlight --Use highlight color if boss is selected for any phone
					end

					-- Apply color formatting to the boss name
					local row = "\\cs("..formatRGB(c.r)..","..formatRGB(c.g)..","..formatRGB(c.b)..")"..boss..spaces.."\\cr|"

					for i = 1, 3 do
						local assigned_boss = phone_selection[i] -- Get the boss assigned to this phone
						local hover_over_boss = boss_map[hover_name] == boss and hover_phone == "ph"..i

						--Determine the color: 
						--Use the phone's color if this boss is already assigned to the phone
						--Use the hover color if the mouse is hovering over it
						local c = hover_over_boss and colors[hover_phone] or (assigned_boss == boss and colors["ph"..i] or off_white)

						-- Check if the hovered boss matches the current selection or if the mouse is hovering over this box
						if assigned_boss == boss or hover_over_boss then
							row = row.." \\cs("..formatRGB(c.r)..","..formatRGB(c.g)..","..formatRGB(c.b)..")√\\cr "
						else
							row = row.." \\cs(000,000,000)×\\cr "
						end

						row = row.."|"
					end					

					table.insert(display_text_parts, row.."\n")

				end
			end
		end

		--Add the buttons at the bottom of the screen
		table.insert(display_text_parts, "                      -------------\n")
		table.insert(display_text_parts, formatButton("CLEAR", "clear_bosses", not isAnyBossAssigned() and "disable").." ")
		table.insert(display_text_parts, formatButton("OPTIONS", "options").."            ")
		table.insert(display_text_parts, formatButton("JOBS", "jobs", not isAnyBossAssigned() and "disable"))

		--Concatenate everything at once
		display_text = table.concat(display_text_parts)

	elseif current_screen == "options" then

		local display_text_parts = {} --Use a table to store strings for faster concatenation

		--Create the save summary for each save slot using the boss names
		local function getBossSummary(save_num)
			local selections = settings.save_data[save_num] and settings.save_data[save_num].phone_selection

			local parts = {}
			for i = 1, 3 do
				local name = selections and selections[tostring(i)]
				if name and name ~= "" then
					if #name > 7 then
						name = name:sub(1, 7)
					end
					table.insert(parts, name)
				end
			end

			if #parts == 0 then
				local c = off_white
				return "\\cs("..c.r..","..c.g..","..c.b..")EMPTY                   \\cr"
			end

			local result = table.concat(parts, "|")
			local c = highlight
			result = result..string.rep(" ", 24 - #result)
			result = "\\cs("..c.r..","..c.g..","..c.b..")"..result
			result = result.."\\cr"
			return result
		end

		local save_1_name = getBossSummary("save_1")
		local save_2_name = getBossSummary("save_2")
		local save_3_name = getBossSummary("save_3")
		local save_4_name = getBossSummary("save_4")
		local save_5_name = getBossSummary("save_5")

		table.insert(display_text_parts, "GaolPlan - Options           ")
		table.insert(display_text_parts, formatButton(pin, "pin"))
		table.insert(display_text_parts, formatButton("X", "close").."\n\n")

		table.insert(display_text_parts, "--SETTINGS-------------------------\n\n")

		table.insert(display_text_parts, "Hover Effects:            ")
		table.insert(display_text_parts, formatButton("ON", "hover_effects_on", hover_effects and "highlight"))
		table.insert(display_text_parts, formatButton("OFF", "hover_effects_off", not hover_effects and "highlight").."\n")
		local c = off_white
		table.insert(display_text_parts, "\\cs("..c.r..","..c.g..","..c.b..")WARNING: Very high hit to FPS\\cr\n")

		table.insert(display_text_parts, "Size:                     ")
		table.insert(display_text_parts, formatButton("UP", "size_up"))
		table.insert(display_text_parts, formatButton("DWN", "size_down").."\n")

		table.insert(display_text_parts, "BG Alpha:                 ")
		table.insert(display_text_parts, formatButton("UP", "bg_alpha_up"))
		table.insert(display_text_parts, formatButton("DWN", "bg_alpha_down").."\n")

		local bold = settings.flags.bold
		table.insert(display_text_parts, "Bold:                     ")
		table.insert(display_text_parts, formatButton("ON", "bold_on", bold and "highlight"))
		table.insert(display_text_parts, formatButton("OFF", "bold_off", not bold and "highlight").."\n\n")

		table.insert(display_text_parts, "--LOAD/SAVE/DELETE DATA------------\n\n")

		table.insert(display_text_parts, "1:")
		table.insert(display_text_parts, save_1_name)
		table.insert(display_text_parts, formatButton("L", "load_1", not isSaveDataPresent("save_1") and "disable"))
		table.insert(display_text_parts, formatButton("S", "save_1", not isAnyBossAssigned() and "disable"))
		table.insert(display_text_parts, formatButton("D", "confirm_delete_1", not isSaveDataPresent("save_1") and "disable").."\n")

		table.insert(display_text_parts, "2:")
		table.insert(display_text_parts, save_2_name)
		table.insert(display_text_parts, formatButton("L", "load_2", not isSaveDataPresent("save_2") and "disable"))
		table.insert(display_text_parts, formatButton("S", "save_2", not isAnyBossAssigned() and "disable"))
		table.insert(display_text_parts, formatButton("D", "confirm_delete_2", not isSaveDataPresent("save_2") and "disable").."\n")

		table.insert(display_text_parts, "3:")
		table.insert(display_text_parts, save_3_name)
		table.insert(display_text_parts, formatButton("L", "load_3", not isSaveDataPresent("save_3") and "disable"))
		table.insert(display_text_parts, formatButton("S", "save_3", not isAnyBossAssigned() and "disable"))
		table.insert(display_text_parts, formatButton("D", "confirm_delete_3", not isSaveDataPresent("save_3") and "disable").."\n")

		table.insert(display_text_parts, "4:")
		table.insert(display_text_parts, save_4_name)
		table.insert(display_text_parts, formatButton("L", "load_4", not isSaveDataPresent("save_4") and "disable"))
		table.insert(display_text_parts, formatButton("S", "save_4", not isAnyBossAssigned() and "disable"))
		table.insert(display_text_parts, formatButton("D", "confirm_delete_4", not isSaveDataPresent("save_4") and "disable").."\n")

		table.insert(display_text_parts, "5:")
		table.insert(display_text_parts, save_5_name)
		table.insert(display_text_parts, formatButton("L", "load_5", not isSaveDataPresent("save_5") and "disable"))
		table.insert(display_text_parts, formatButton("S", "save_5", not isAnyBossAssigned() and "disable"))
		table.insert(display_text_parts, formatButton("D", "confirm_delete_5", not isSaveDataPresent("save_5") and "disable").."\n")
		table.insert(display_text_parts, "\\cs("..c.r..","..c.g..","..c.b..")Data does not include player names\\cr\n\n")

		table.insert(display_text_parts, "--ABOUT----------------------------\n\n")
		
		table.insert(display_text_parts, "Version: ".._addon.version.."\n")
		table.insert(display_text_parts, "Author: ".._addon.author.."\n")
		table.insert(display_text_parts, "\\cs("..c.r..","..c.g..","..c.b..")Find BattlePlan (BP) on my GitHub\n\n")
		
		table.insert(display_text_parts, formatButton("BACK", "back").." ")
		table.insert(display_text_parts, formatButton("GITHUB", "github").." ")
		table.insert(display_text_parts, formatButton("DISCORD", "discord").." ")
		table.insert(display_text_parts, formatButton("DEFAULT", "confirm_default"))

		--Concatenate everything at once
		display_text = table.concat(display_text_parts)

	elseif current_screen == "jobs" then

		--I've done what I could to make this screen as efficient as possible for the "Hover Effects", but the fact of
		--the matter is that there are up to 396 job selection areas alone to compute each time this gets called as the
		--mouse moves. So, it's just gonna be slow ¯\_(ツ)_/¯ but at least you're not running this while doing anything else.

		local hover_phone = getPhone(hover)
		local hover_player = getPlayer(hover)

		local display_text_parts = {} --Use a table to store strings for faster concatenation
		table.insert(display_text_parts, "GaolPlan - Jobs                                                                            ")
		table.insert(display_text_parts, formatButton(pin, "pin"))
		table.insert(display_text_parts, formatButton("X", "close").."\n")

		jobs_row_num = 1
		boss_num = 0
		local party_data = get_party()

		for i = 1, 3 do

			local boss = phone_selection[i]

			if boss then

				--Determine the appropriate color based on phone selection
				local boss_color = i == 1 and ph1_color or i == 2 and ph2_color or ph3_color

				--Create spacing and format the boss title with color
				local total_width = 97
				local pre_spaces = string.rep("-", math.floor((total_width - (10 + #boss)) / 2))
				local post_spaces = string.rep("-", total_width - #pre_spaces - #boss - 10)
				boss_num = boss_num + 1

				--Insert colored boss name
				table.insert(display_text_parts, "\\cs("..formatRGB(boss_color.r)..","..formatRGB(boss_color.g)..","..formatRGB(boss_color.b)..")"..pre_spaces.."Phone "..boss_num.." - "..boss..post_spaces.."\\cr\n")
				table.insert(display_text_parts, "        \\cs("..formatRGB(boss_color.r)..","..formatRGB(boss_color.g)..","..formatRGB(boss_color.b)..")|BLM|BLU|BRD|BST|COR|DNC|DRG|DRK|GEO|MNK|NIN|PLD|PUP|RDM|RNG|RUN|SAM|SCH|SMN|THF|WAR|WHM|\\cr\n")
				jobs_row_num = jobs_row_num + 2

				for p = 1, 6 do

					local player = party_data["p"..(p-1)]
					local player_name = player and formatName(player.name) or "Player "..p
					local player_job_parts = {}
					local is_selected = false
					local phone_player, job_code = hover and hover:sub(1, 7), hover and hover:sub(-3) --Extract "phX_plY" and job code

					--Loop through each job to fill in the selection field for it
					for _, job in ipairs({"blm", "blu", "brd", "bst", "cor", "dnc", "drg", "drk", "geo", "mnk", "nin", "pld", "pup", "rdm", "rng", "run", "sam", "sch", "smn", "thf", "war", "whm"}) do
						local hover_over_job = job_code == job and phone_player == "ph"..i.."_pl"..p
						table.insert(player_job_parts, (player_jobs[job] == "ph"..i.."_pl"..p or hover_over_job) and "|".."\\cs("..formatRGB(boss_color.r)..","..formatRGB(boss_color.g)..","..formatRGB(boss_color.b)..")"..job:upper().."\\cr" or "|\\cs(000,000,000) × \\cr")
						if (player_jobs[job] == "ph"..i.."_pl"..p) then
							is_selected = true
						end
					end

					--Put the table together to form the text output for the job selection field
					player_job_text = table.concat(player_job_parts)

					--Determine player name color
					local c = off_white
					if hover_player == "pl"..p and hover_phone == "ph"..i then
						c = colors["ph"..i] --Use phone color if mouse is over it
					elseif is_selected then
						c = highlight --Use highlight color if boss is selected for any phone
					end

					--Apply color formatting to the player name and add it to the table
					player_name = "\\cs("..formatRGB(c.r)..","..formatRGB(c.g)..","..formatRGB(c.b)..")"..player_name.."\\cr"
					table.insert(display_text_parts, player_name)

					--Add the job selection field to the table
					table.insert(display_text_parts, player_job_text)

					table.insert(display_text_parts, "|\n")
					jobs_row_num = jobs_row_num + 1

				end
			end
		end

		--Add separator line
		table.insert(display_text_parts, "-------------------------------------------------------------------------------------------------\n")

		--Add buttons at the bottom
		table.insert(display_text_parts, formatButton("BOSSES", "bosses").." ")
		table.insert(display_text_parts, formatButton("CLEAR", "clear_jobs", not isAnyJobAssigned() and "disable").." ")
		table.insert(display_text_parts, formatButton("OPTIONS", "options").."                            COPY:")
		table.insert(display_text_parts, formatButton("1", "copy_1",  not isAnyJobAssigned("1") and "disable"))
		table.insert(display_text_parts, formatButton("2", "copy_2",  not isAnyJobAssigned("2") and "disable"))
		table.insert(display_text_parts, formatButton("3", "copy_3",  not isAnyJobAssigned("3") and "disable").." SEND TO:")
		table.insert(display_text_parts, formatButton("PARTY", "party",  not isAnyJobAssigned() and "disable"))
		table.insert(display_text_parts, formatButton("PARTY W/ BP", "party_w_bp",  not isAnyJobAssigned() and "disable"))
		jobs_row_num = jobs_row_num + 2

		--Concatenate everything at once
		display_text = table.concat(display_text_parts)

	end

	main_window:text(display_text)
end

--Return which button the mouse is hovering over
function getMouseOnButton(mouseX, mouseY)
	local grid_pos = settings.pos
	local total_width, total_height = main_window:extents()
	local grid_width = total_width - (settings.padding * 2) --Width of the grid area (excludes padding)
	local grid_height = total_height - (settings.padding * 2) --Height of the grid area (excludes padding)
	local button_width = 0
	local button_height = 0

	if confirm_window_visible then
		grid_pos = {x = confirm_window:pos_x(), y = confirm_window:pos_y()}
		total_width, total_height = confirm_window:extents()
		grid_width = total_width - (settings.padding * 2) --Width of the grid area (excludes padding)
		grid_height = total_height - (settings.padding * 2) --Height of the grid area (excludes padding)
		button_width = grid_width / confirm_char_num
		button_height = grid_height / 6
		button_positions = {
			{button = confirm_yes, x_begin = confirm_char_num - 10, x_end = confirm_char_num - 6, y = 5},
			{button = "confirm_no", x_begin = confirm_char_num - 5, x_end = confirm_char_num - 2, y = 5},
		}

	elseif current_screen == "bosses" then
		button_width = grid_width / 35
		button_height = grid_height / 25
		button_positions = {
			{button = "pin", x_begin = 30, x_end = 32, y = 1},
			{button = "close", x_begin = 33, x_end = 35, y = 1},
			{button = "ph1_dealan_dhe", x_begin = 24, x_end = 26, y = 4},
			{button = "ph2_dealan_dhe", x_begin = 28, x_end = 30, y = 4},
			{button = "ph3_dealan_dhe", x_begin = 32, x_end = 34, y = 4},
			{button = "ph1_sgili", x_begin = 24, x_end = 26, y = 5},
			{button = "ph2_sgili", x_begin = 28, x_end = 30, y = 5},
			{button = "ph3_sgili", x_begin = 32, x_end = 34, y = 5},
			{button = "ph1_u_bnai", x_begin = 24, x_end = 26, y = 6},
			{button = "ph2_u_bnai", x_begin = 28, x_end = 30, y = 6},
			{button = "ph3_u_bnai", x_begin = 32, x_end = 34, y = 6},
			{button = "ph1_gogmagog", x_begin = 24, x_end = 26, y = 7},
			{button = "ph2_gogmagog", x_begin = 28, x_end = 30, y = 7},
			{button = "ph3_gogmagog", x_begin = 32, x_end = 34, y = 7},
			{button = "ph1_aristaeus", x_begin = 24, x_end = 26, y = 9},
			{button = "ph2_aristaeus", x_begin = 28, x_end = 30, y = 9},
			{button = "ph3_aristaeus", x_begin = 32, x_end = 34, y = 9},
			{button = "ph1_raskovniche", x_begin = 24, x_end = 26, y = 10},
			{button = "ph2_raskovniche", x_begin = 28, x_end = 30, y = 10},
			{button = "ph3_raskovniche", x_begin = 32, x_end = 34, y = 10},
			{button = "ph1_marmorkrebs", x_begin = 24, x_end = 26, y = 11},
			{button = "ph2_marmorkrebs", x_begin = 28, x_end = 30, y = 11},
			{button = "ph3_marmorkrebs", x_begin = 32, x_end = 34, y = 11},
			{button = "ph1_gigelorum", x_begin = 24, x_end = 26, y = 12},
			{button = "ph2_gigelorum", x_begin = 28, x_end = 30, y = 12},
			{button = "ph3_gigelorum", x_begin = 32, x_end = 34, y = 12},
			{button = "ph1_procne", x_begin = 24, x_end = 26, y = 13},
			{button = "ph2_procne", x_begin = 28, x_end = 30, y = 13},
			{button = "ph3_procne", x_begin = 32, x_end = 34, y = 13},
			{button = "ph1_henwen", x_begin = 24, x_end = 26, y = 14},
			{button = "ph2_henwen", x_begin = 28, x_end = 30, y = 14},
			{button = "ph3_henwen", x_begin = 32, x_end = 34, y = 14},
			{button = "ph1_xevioso", x_begin = 24, x_end = 26, y = 16},
			{button = "ph2_xevioso", x_begin = 28, x_end = 30, y = 16},
			{button = "ph3_xevioso", x_begin = 32, x_end = 34, y = 16},
			{button = "ph1_ngai", x_begin = 24, x_end = 26, y = 17},
			{button = "ph2_ngai", x_begin = 28, x_end = 30, y = 17},
			{button = "ph3_ngai", x_begin = 32, x_end = 34, y = 17},
			{button = "ph1_kalunga", x_begin = 24, x_end = 26, y = 18},
			{button = "ph2_kalunga", x_begin = 28, x_end = 30, y = 18},
			{button = "ph3_kalunga", x_begin = 32, x_end = 34, y = 18},
			{button = "ph1_ongo", x_begin = 24, x_end = 26, y = 19},
			{button = "ph2_ongo", x_begin = 28, x_end = 30, y = 19},
			{button = "ph3_ongo", x_begin = 32, x_end = 34, y = 19},
			{button = "ph1_mboze", x_begin = 24, x_end = 26, y = 20},
			{button = "ph2_mboze", x_begin = 28, x_end = 30, y = 20},
			{button = "ph3_mboze", x_begin = 32, x_end = 34, y = 20},
			{button = "ph1_arebati", x_begin = 24, x_end = 26, y = 21},
			{button = "ph2_arebati", x_begin = 28, x_end = 30, y = 21},
			{button = "ph3_arebati", x_begin = 32, x_end = 34, y = 21},
			{button = "ph1_bumba", x_begin = 24, x_end = 26, y = 23},
			{button = "ph2_bumba", x_begin = 28, x_end = 30, y = 23},
			{button = "ph3_bumba", x_begin = 32, x_end = 34, y = 23},
			{button = "clear_bosses", x_begin = 1, x_end = 7, y = 25},
			{button = "options", x_begin = 9, x_end = 17, y = 25},
			{button = "jobs", x_begin = 30, x_end = 35, y = 25},
		}

	elseif current_screen == "options" then
		button_width = grid_width / 35
		button_height = grid_height / 26
		button_positions = {
			{button = "pin", x_begin = 30, x_end = 32, y = 1},
			{button = "close", x_begin = 33, x_end = 35, y = 1},
			{button = "hover_effects_on", x_begin = 27, x_end = 30, y = 5},
			{button = "hover_effects_off", x_begin = 31, x_end = 35, y = 5},
			{button = "size_up", x_begin = 27, x_end = 30, y = 7},
			{button = "size_down", x_begin = 31, x_end = 35, y = 7},
			{button = "bg_alpha_up", x_begin = 27, x_end = 30, y = 8},
			{button = "bg_alpha_down", x_begin = 31, x_end = 35, y = 8},
			{button = "bold_on", x_begin = 27, x_end = 30, y = 9},
			{button = "bold_off", x_begin = 31, x_end = 35, y = 9},
			{button = "load_1", x_begin = 27, x_end = 29, y = 13},
			{button = "save_1", x_begin = 30, x_end = 32, y = 13},
			{button = "confirm_delete_1", x_begin = 33, x_end = 35, y = 13},
			{button = "load_2", x_begin = 27, x_end = 29, y = 14},
			{button = "save_2", x_begin = 30, x_end = 32, y = 14},
			{button = "confirm_delete_2", x_begin = 33, x_end = 35, y = 14},
			{button = "load_3", x_begin = 27, x_end = 29, y = 15},
			{button = "save_3", x_begin = 30, x_end = 32, y = 15},
			{button = "confirm_delete_3", x_begin = 33, x_end = 35, y = 15},
			{button = "load_4", x_begin = 27, x_end = 29, y = 16},
			{button = "save_4", x_begin = 30, x_end = 32, y = 16},
			{button = "confirm_delete_4", x_begin = 33, x_end = 35, y = 16},
			{button = "load_5", x_begin = 27, x_end = 29, y = 17},
			{button = "save_5", x_begin = 30, x_end = 32, y = 17},
			{button = "confirm_delete_5", x_begin = 33, x_end = 35, y = 17},
			{button = "back", x_begin = 1, x_end = 6, y = 26},
			{button = "github", x_begin = 8, x_end = 15, y = 26},
			{button = "discord", x_begin = 17, x_end = 25, y = 26},
			{button = "confirm_default", x_begin = 27, x_end = 35, y = 26},
		}

	elseif current_screen == "jobs" then
		button_width = grid_width / 97
		button_height = grid_height / jobs_row_num
		button_positions = {
			{button = "pin", x_begin = 92, x_end = 94, y = 1},
			{button = "close", x_begin = 95, x_end = 97, y = 1},
			{button = "bosses", x_begin = 1, x_end = 8, y = jobs_row_num},
			{button = "confirm_clear_jobs", x_begin = 8, x_end = 14, y = jobs_row_num},
			{button = "options", x_begin = 16, x_end = 24, y = jobs_row_num},
			{button = "copy_1", x_begin = 60, x_end = 62, y = jobs_row_num},
			{button = "copy_2", x_begin = 63, x_end = 65, y = jobs_row_num},
			{button = "copy_3", x_begin = 66, x_end = 68, y = jobs_row_num},
			{button = "party", x_begin = 78, x_end = 84, y = jobs_row_num},
			{button = "party_w_bp", x_begin = 85, x_end = 97, y = jobs_row_num},
		}

		--Add buttons for Phone 1
		if boss_num >= 1 then
			local additional_buttons = {
				{button = "ph1_pl1_blm", x_begin = 10, x_end = 12, y = 4},
				{button = "ph1_pl1_blu", x_begin = 14, x_end = 16, y = 4},
				{button = "ph1_pl1_brd", x_begin = 18, x_end = 20, y = 4},
				{button = "ph1_pl1_bst", x_begin = 22, x_end = 24, y = 4},
				{button = "ph1_pl1_cor", x_begin = 26, x_end = 28, y = 4},
				{button = "ph1_pl1_dnc", x_begin = 30, x_end = 32, y = 4},
				{button = "ph1_pl1_drg", x_begin = 34, x_end = 36, y = 4},
				{button = "ph1_pl1_drk", x_begin = 38, x_end = 40, y = 4},
				{button = "ph1_pl1_geo", x_begin = 42, x_end = 44, y = 4},
				{button = "ph1_pl1_mnk", x_begin = 46, x_end = 48, y = 4},
				{button = "ph1_pl1_nin", x_begin = 50, x_end = 52, y = 4},
				{button = "ph1_pl1_pld", x_begin = 54, x_end = 56, y = 4},
				{button = "ph1_pl1_pup", x_begin = 58, x_end = 60, y = 4},
				{button = "ph1_pl1_rdm", x_begin = 62, x_end = 64, y = 4},
				{button = "ph1_pl1_rng", x_begin = 66, x_end = 68, y = 4},
				{button = "ph1_pl1_run", x_begin = 70, x_end = 72, y = 4},
				{button = "ph1_pl1_sam", x_begin = 74, x_end = 76, y = 4},
				{button = "ph1_pl1_sch", x_begin = 78, x_end = 80, y = 4},
				{button = "ph1_pl1_smn", x_begin = 82, x_end = 84, y = 4},
				{button = "ph1_pl1_thf", x_begin = 86, x_end = 88, y = 4},
				{button = "ph1_pl1_war", x_begin = 90, x_end = 92, y = 4},
				{button = "ph1_pl1_whm", x_begin = 94, x_end = 96, y = 4},
				{button = "ph1_pl2_blm", x_begin = 10, x_end = 12, y = 5},
				{button = "ph1_pl2_blu", x_begin = 14, x_end = 16, y = 5},
				{button = "ph1_pl2_brd", x_begin = 18, x_end = 20, y = 5},
				{button = "ph1_pl2_bst", x_begin = 22, x_end = 24, y = 5},
				{button = "ph1_pl2_cor", x_begin = 26, x_end = 28, y = 5},
				{button = "ph1_pl2_dnc", x_begin = 30, x_end = 32, y = 5},
				{button = "ph1_pl2_drg", x_begin = 34, x_end = 36, y = 5},
				{button = "ph1_pl2_drk", x_begin = 38, x_end = 40, y = 5},
				{button = "ph1_pl2_geo", x_begin = 42, x_end = 44, y = 5},
				{button = "ph1_pl2_mnk", x_begin = 46, x_end = 48, y = 5},
				{button = "ph1_pl2_nin", x_begin = 50, x_end = 52, y = 5},
				{button = "ph1_pl2_pld", x_begin = 54, x_end = 56, y = 5},
				{button = "ph1_pl2_pup", x_begin = 58, x_end = 60, y = 5},
				{button = "ph1_pl2_rdm", x_begin = 62, x_end = 64, y = 5},
				{button = "ph1_pl2_rng", x_begin = 66, x_end = 68, y = 5},
				{button = "ph1_pl2_run", x_begin = 70, x_end = 72, y = 5},
				{button = "ph1_pl2_sam", x_begin = 74, x_end = 76, y = 5},
				{button = "ph1_pl2_sch", x_begin = 78, x_end = 80, y = 5},
				{button = "ph1_pl2_smn", x_begin = 82, x_end = 84, y = 5},
				{button = "ph1_pl2_thf", x_begin = 86, x_end = 88, y = 5},
				{button = "ph1_pl2_war", x_begin = 90, x_end = 92, y = 5},
				{button = "ph1_pl2_whm", x_begin = 94, x_end = 96, y = 5},
				{button = "ph1_pl3_blm", x_begin = 10, x_end = 12, y = 6},
				{button = "ph1_pl3_blu", x_begin = 14, x_end = 16, y = 6},
				{button = "ph1_pl3_brd", x_begin = 18, x_end = 20, y = 6},
				{button = "ph1_pl3_bst", x_begin = 22, x_end = 24, y = 6},
				{button = "ph1_pl3_cor", x_begin = 26, x_end = 28, y = 6},
				{button = "ph1_pl3_dnc", x_begin = 30, x_end = 32, y = 6},
				{button = "ph1_pl3_drg", x_begin = 34, x_end = 36, y = 6},
				{button = "ph1_pl3_drk", x_begin = 38, x_end = 40, y = 6},
				{button = "ph1_pl3_geo", x_begin = 42, x_end = 44, y = 6},
				{button = "ph1_pl3_mnk", x_begin = 46, x_end = 48, y = 6},
				{button = "ph1_pl3_nin", x_begin = 50, x_end = 52, y = 6},
				{button = "ph1_pl3_pld", x_begin = 54, x_end = 56, y = 6},
				{button = "ph1_pl3_pup", x_begin = 58, x_end = 60, y = 6},
				{button = "ph1_pl3_rdm", x_begin = 62, x_end = 64, y = 6},
				{button = "ph1_pl3_rng", x_begin = 66, x_end = 68, y = 6},
				{button = "ph1_pl3_run", x_begin = 70, x_end = 72, y = 6},
				{button = "ph1_pl3_sam", x_begin = 74, x_end = 76, y = 6},
				{button = "ph1_pl3_sch", x_begin = 78, x_end = 80, y = 6},
				{button = "ph1_pl3_smn", x_begin = 82, x_end = 84, y = 6},
				{button = "ph1_pl3_thf", x_begin = 86, x_end = 88, y = 6},
				{button = "ph1_pl3_war", x_begin = 90, x_end = 92, y = 6},
				{button = "ph1_pl3_whm", x_begin = 94, x_end = 96, y = 6},
				{button = "ph1_pl4_blm", x_begin = 10, x_end = 12, y = 7},
				{button = "ph1_pl4_blu", x_begin = 14, x_end = 16, y = 7},
				{button = "ph1_pl4_brd", x_begin = 18, x_end = 20, y = 7},
				{button = "ph1_pl4_bst", x_begin = 22, x_end = 24, y = 7},
				{button = "ph1_pl4_cor", x_begin = 26, x_end = 28, y = 7},
				{button = "ph1_pl4_dnc", x_begin = 30, x_end = 32, y = 7},
				{button = "ph1_pl4_drg", x_begin = 34, x_end = 36, y = 7},
				{button = "ph1_pl4_drk", x_begin = 38, x_end = 40, y = 7},
				{button = "ph1_pl4_geo", x_begin = 42, x_end = 44, y = 7},
				{button = "ph1_pl4_mnk", x_begin = 46, x_end = 48, y = 7},
				{button = "ph1_pl4_nin", x_begin = 50, x_end = 52, y = 7},
				{button = "ph1_pl4_pld", x_begin = 54, x_end = 56, y = 7},
				{button = "ph1_pl4_pup", x_begin = 58, x_end = 60, y = 7},
				{button = "ph1_pl4_rdm", x_begin = 62, x_end = 64, y = 7},
				{button = "ph1_pl4_rng", x_begin = 66, x_end = 68, y = 7},
				{button = "ph1_pl4_run", x_begin = 70, x_end = 72, y = 7},
				{button = "ph1_pl4_sam", x_begin = 74, x_end = 76, y = 7},
				{button = "ph1_pl4_sch", x_begin = 78, x_end = 80, y = 7},
				{button = "ph1_pl4_smn", x_begin = 82, x_end = 84, y = 7},
				{button = "ph1_pl4_thf", x_begin = 86, x_end = 88, y = 7},
				{button = "ph1_pl4_war", x_begin = 90, x_end = 92, y = 7},
				{button = "ph1_pl4_whm", x_begin = 94, x_end = 96, y = 7},
				{button = "ph1_pl5_blm", x_begin = 10, x_end = 12, y = 8},
				{button = "ph1_pl5_blu", x_begin = 14, x_end = 16, y = 8},
				{button = "ph1_pl5_brd", x_begin = 18, x_end = 20, y = 8},
				{button = "ph1_pl5_bst", x_begin = 22, x_end = 24, y = 8},
				{button = "ph1_pl5_cor", x_begin = 26, x_end = 28, y = 8},
				{button = "ph1_pl5_dnc", x_begin = 30, x_end = 32, y = 8},
				{button = "ph1_pl5_drg", x_begin = 34, x_end = 36, y = 8},
				{button = "ph1_pl5_drk", x_begin = 38, x_end = 40, y = 8},
				{button = "ph1_pl5_geo", x_begin = 42, x_end = 44, y = 8},
				{button = "ph1_pl5_mnk", x_begin = 46, x_end = 48, y = 8},
				{button = "ph1_pl5_nin", x_begin = 50, x_end = 52, y = 8},
				{button = "ph1_pl5_pld", x_begin = 54, x_end = 56, y = 8},
				{button = "ph1_pl5_pup", x_begin = 58, x_end = 60, y = 8},
				{button = "ph1_pl5_rdm", x_begin = 62, x_end = 64, y = 8},
				{button = "ph1_pl5_rng", x_begin = 66, x_end = 68, y = 8},
				{button = "ph1_pl5_run", x_begin = 70, x_end = 72, y = 8},
				{button = "ph1_pl5_sam", x_begin = 74, x_end = 76, y = 8},
				{button = "ph1_pl5_sch", x_begin = 78, x_end = 80, y = 8},
				{button = "ph1_pl5_smn", x_begin = 82, x_end = 84, y = 8},
				{button = "ph1_pl5_thf", x_begin = 86, x_end = 88, y = 8},
				{button = "ph1_pl5_war", x_begin = 90, x_end = 92, y = 8},
				{button = "ph1_pl5_whm", x_begin = 94, x_end = 96, y = 8},
				{button = "ph1_pl6_blm", x_begin = 10, x_end = 12, y = 9},
				{button = "ph1_pl6_blu", x_begin = 14, x_end = 16, y = 9},
				{button = "ph1_pl6_brd", x_begin = 18, x_end = 20, y = 9},
				{button = "ph1_pl6_bst", x_begin = 22, x_end = 24, y = 9},
				{button = "ph1_pl6_cor", x_begin = 26, x_end = 28, y = 9},
				{button = "ph1_pl6_dnc", x_begin = 30, x_end = 32, y = 9},
				{button = "ph1_pl6_drg", x_begin = 34, x_end = 36, y = 9},
				{button = "ph1_pl6_drk", x_begin = 38, x_end = 40, y = 9},
				{button = "ph1_pl6_geo", x_begin = 42, x_end = 44, y = 9},
				{button = "ph1_pl6_mnk", x_begin = 46, x_end = 48, y = 9},
				{button = "ph1_pl6_nin", x_begin = 50, x_end = 52, y = 9},
				{button = "ph1_pl6_pld", x_begin = 54, x_end = 56, y = 9},
				{button = "ph1_pl6_pup", x_begin = 58, x_end = 60, y = 9},
				{button = "ph1_pl6_rdm", x_begin = 62, x_end = 64, y = 9},
				{button = "ph1_pl6_rng", x_begin = 66, x_end = 68, y = 9},
				{button = "ph1_pl6_run", x_begin = 70, x_end = 72, y = 9},
				{button = "ph1_pl6_sam", x_begin = 74, x_end = 76, y = 9},
				{button = "ph1_pl6_sch", x_begin = 78, x_end = 80, y = 9},
				{button = "ph1_pl6_smn", x_begin = 82, x_end = 84, y = 9},
				{button = "ph1_pl6_thf", x_begin = 86, x_end = 88, y = 9},
				{button = "ph1_pl6_war", x_begin = 90, x_end = 92, y = 9},
				{button = "ph1_pl6_whm", x_begin = 94, x_end = 96, y = 9},
			}
			for _, btn in ipairs(additional_buttons) do
				table.insert(button_positions, btn)
			end
		end

		--Add buttons for Phone 2
		if boss_num >= 2 then
			local additional_buttons = {
				{button = "ph2_pl1_blm", x_begin = 10, x_end = 12, y = 12},
				{button = "ph2_pl1_blu", x_begin = 14, x_end = 16, y = 12},
				{button = "ph2_pl1_brd", x_begin = 18, x_end = 20, y = 12},
				{button = "ph2_pl1_bst", x_begin = 22, x_end = 24, y = 12},
				{button = "ph2_pl1_cor", x_begin = 26, x_end = 28, y = 12},
				{button = "ph2_pl1_dnc", x_begin = 30, x_end = 32, y = 12},
				{button = "ph2_pl1_drg", x_begin = 34, x_end = 36, y = 12},
				{button = "ph2_pl1_drk", x_begin = 38, x_end = 40, y = 12},
				{button = "ph2_pl1_geo", x_begin = 42, x_end = 44, y = 12},
				{button = "ph2_pl1_mnk", x_begin = 46, x_end = 48, y = 12},
				{button = "ph2_pl1_nin", x_begin = 50, x_end = 52, y = 12},
				{button = "ph2_pl1_pld", x_begin = 54, x_end = 56, y = 12},
				{button = "ph2_pl1_pup", x_begin = 58, x_end = 60, y = 12},
				{button = "ph2_pl1_rdm", x_begin = 62, x_end = 64, y = 12},
				{button = "ph2_pl1_rng", x_begin = 66, x_end = 68, y = 12},
				{button = "ph2_pl1_run", x_begin = 70, x_end = 72, y = 12},
				{button = "ph2_pl1_sam", x_begin = 74, x_end = 76, y = 12},
				{button = "ph2_pl1_sch", x_begin = 78, x_end = 80, y = 12},
				{button = "ph2_pl1_smn", x_begin = 82, x_end = 84, y = 12},
				{button = "ph2_pl1_thf", x_begin = 86, x_end = 88, y = 12},
				{button = "ph2_pl1_war", x_begin = 90, x_end = 92, y = 12},
				{button = "ph2_pl1_whm", x_begin = 94, x_end = 96, y = 12},
				{button = "ph2_pl2_blm", x_begin = 10, x_end = 12, y = 13},
				{button = "ph2_pl2_blu", x_begin = 14, x_end = 16, y = 13},
				{button = "ph2_pl2_brd", x_begin = 18, x_end = 20, y = 13},
				{button = "ph2_pl2_bst", x_begin = 22, x_end = 24, y = 13},
				{button = "ph2_pl2_cor", x_begin = 26, x_end = 28, y = 13},
				{button = "ph2_pl2_dnc", x_begin = 30, x_end = 32, y = 13},
				{button = "ph2_pl2_drg", x_begin = 34, x_end = 36, y = 13},
				{button = "ph2_pl2_drk", x_begin = 38, x_end = 40, y = 13},
				{button = "ph2_pl2_geo", x_begin = 42, x_end = 44, y = 13},
				{button = "ph2_pl2_mnk", x_begin = 46, x_end = 48, y = 13},
				{button = "ph2_pl2_nin", x_begin = 50, x_end = 52, y = 13},
				{button = "ph2_pl2_pld", x_begin = 54, x_end = 56, y = 13},
				{button = "ph2_pl2_pup", x_begin = 58, x_end = 60, y = 13},
				{button = "ph2_pl2_rdm", x_begin = 62, x_end = 64, y = 13},
				{button = "ph2_pl2_rng", x_begin = 66, x_end = 68, y = 13},
				{button = "ph2_pl2_run", x_begin = 70, x_end = 72, y = 13},
				{button = "ph2_pl2_sam", x_begin = 74, x_end = 76, y = 13},
				{button = "ph2_pl2_sch", x_begin = 78, x_end = 80, y = 13},
				{button = "ph2_pl2_smn", x_begin = 82, x_end = 84, y = 13},
				{button = "ph2_pl2_thf", x_begin = 86, x_end = 88, y = 13},
				{button = "ph2_pl2_war", x_begin = 90, x_end = 92, y = 13},
				{button = "ph2_pl2_whm", x_begin = 94, x_end = 96, y = 13},
				{button = "ph2_pl3_blm", x_begin = 10, x_end = 12, y = 14},
				{button = "ph2_pl3_blu", x_begin = 14, x_end = 16, y = 14},
				{button = "ph2_pl3_brd", x_begin = 18, x_end = 20, y = 14},
				{button = "ph2_pl3_bst", x_begin = 22, x_end = 24, y = 14},
				{button = "ph2_pl3_cor", x_begin = 26, x_end = 28, y = 14},
				{button = "ph2_pl3_dnc", x_begin = 30, x_end = 32, y = 14},
				{button = "ph2_pl3_drg", x_begin = 34, x_end = 36, y = 14},
				{button = "ph2_pl3_drk", x_begin = 38, x_end = 40, y = 14},
				{button = "ph2_pl3_geo", x_begin = 42, x_end = 44, y = 14},
				{button = "ph2_pl3_mnk", x_begin = 46, x_end = 48, y = 14},
				{button = "ph2_pl3_nin", x_begin = 50, x_end = 52, y = 14},
				{button = "ph2_pl3_pld", x_begin = 54, x_end = 56, y = 14},
				{button = "ph2_pl3_pup", x_begin = 58, x_end = 60, y = 14},
				{button = "ph2_pl3_rdm", x_begin = 62, x_end = 64, y = 14},
				{button = "ph2_pl3_rng", x_begin = 66, x_end = 68, y = 14},
				{button = "ph2_pl3_run", x_begin = 70, x_end = 72, y = 14},
				{button = "ph2_pl3_sam", x_begin = 74, x_end = 76, y = 14},
				{button = "ph2_pl3_sch", x_begin = 78, x_end = 80, y = 14},
				{button = "ph2_pl3_smn", x_begin = 82, x_end = 84, y = 14},
				{button = "ph2_pl3_thf", x_begin = 86, x_end = 88, y = 14},
				{button = "ph2_pl3_war", x_begin = 90, x_end = 92, y = 14},
				{button = "ph2_pl3_whm", x_begin = 94, x_end = 96, y = 14},
				{button = "ph2_pl4_blm", x_begin = 10, x_end = 12, y = 15},
				{button = "ph2_pl4_blu", x_begin = 14, x_end = 16, y = 15},
				{button = "ph2_pl4_brd", x_begin = 18, x_end = 20, y = 15},
				{button = "ph2_pl4_bst", x_begin = 22, x_end = 24, y = 15},
				{button = "ph2_pl4_cor", x_begin = 26, x_end = 28, y = 15},
				{button = "ph2_pl4_dnc", x_begin = 30, x_end = 32, y = 15},
				{button = "ph2_pl4_drg", x_begin = 34, x_end = 36, y = 15},
				{button = "ph2_pl4_drk", x_begin = 38, x_end = 40, y = 15},
				{button = "ph2_pl4_geo", x_begin = 42, x_end = 44, y = 15},
				{button = "ph2_pl4_mnk", x_begin = 46, x_end = 48, y = 15},
				{button = "ph2_pl4_nin", x_begin = 50, x_end = 52, y = 15},
				{button = "ph2_pl4_pld", x_begin = 54, x_end = 56, y = 15},
				{button = "ph2_pl4_pup", x_begin = 58, x_end = 60, y = 15},
				{button = "ph2_pl4_rdm", x_begin = 62, x_end = 64, y = 15},
				{button = "ph2_pl4_rng", x_begin = 66, x_end = 68, y = 15},
				{button = "ph2_pl4_run", x_begin = 70, x_end = 72, y = 15},
				{button = "ph2_pl4_sam", x_begin = 74, x_end = 76, y = 15},
				{button = "ph2_pl4_sch", x_begin = 78, x_end = 80, y = 15},
				{button = "ph2_pl4_smn", x_begin = 82, x_end = 84, y = 15},
				{button = "ph2_pl4_thf", x_begin = 86, x_end = 88, y = 15},
				{button = "ph2_pl4_war", x_begin = 90, x_end = 92, y = 15},
				{button = "ph2_pl4_whm", x_begin = 94, x_end = 96, y = 15},
				{button = "ph2_pl5_blm", x_begin = 10, x_end = 12, y = 16},
				{button = "ph2_pl5_blu", x_begin = 14, x_end = 16, y = 16},
				{button = "ph2_pl5_brd", x_begin = 18, x_end = 20, y = 16},
				{button = "ph2_pl5_bst", x_begin = 22, x_end = 24, y = 16},
				{button = "ph2_pl5_cor", x_begin = 26, x_end = 28, y = 16},
				{button = "ph2_pl5_dnc", x_begin = 30, x_end = 32, y = 16},
				{button = "ph2_pl5_drg", x_begin = 34, x_end = 36, y = 16},
				{button = "ph2_pl5_drk", x_begin = 38, x_end = 40, y = 16},
				{button = "ph2_pl5_geo", x_begin = 42, x_end = 44, y = 16},
				{button = "ph2_pl5_mnk", x_begin = 46, x_end = 48, y = 16},
				{button = "ph2_pl5_nin", x_begin = 50, x_end = 52, y = 16},
				{button = "ph2_pl5_pld", x_begin = 54, x_end = 56, y = 16},
				{button = "ph2_pl5_pup", x_begin = 58, x_end = 60, y = 16},
				{button = "ph2_pl5_rdm", x_begin = 62, x_end = 64, y = 16},
				{button = "ph2_pl5_rng", x_begin = 66, x_end = 68, y = 16},
				{button = "ph2_pl5_run", x_begin = 70, x_end = 72, y = 16},
				{button = "ph2_pl5_sam", x_begin = 74, x_end = 76, y = 16},
				{button = "ph2_pl5_sch", x_begin = 78, x_end = 80, y = 16},
				{button = "ph2_pl5_smn", x_begin = 82, x_end = 84, y = 16},
				{button = "ph2_pl5_thf", x_begin = 86, x_end = 88, y = 16},
				{button = "ph2_pl5_war", x_begin = 90, x_end = 92, y = 16},
				{button = "ph2_pl5_whm", x_begin = 94, x_end = 96, y = 16},
				{button = "ph2_pl6_blm", x_begin = 10, x_end = 12, y = 17},
				{button = "ph2_pl6_blu", x_begin = 14, x_end = 16, y = 17},
				{button = "ph2_pl6_brd", x_begin = 18, x_end = 20, y = 17},
				{button = "ph2_pl6_bst", x_begin = 22, x_end = 24, y = 17},
				{button = "ph2_pl6_cor", x_begin = 26, x_end = 28, y = 17},
				{button = "ph2_pl6_dnc", x_begin = 30, x_end = 32, y = 17},
				{button = "ph2_pl6_drg", x_begin = 34, x_end = 36, y = 17},
				{button = "ph2_pl6_drk", x_begin = 38, x_end = 40, y = 17},
				{button = "ph2_pl6_geo", x_begin = 42, x_end = 44, y = 17},
				{button = "ph2_pl6_mnk", x_begin = 46, x_end = 48, y = 17},
				{button = "ph2_pl6_nin", x_begin = 50, x_end = 52, y = 17},
				{button = "ph2_pl6_pld", x_begin = 54, x_end = 56, y = 17},
				{button = "ph2_pl6_pup", x_begin = 58, x_end = 60, y = 17},
				{button = "ph2_pl6_rdm", x_begin = 62, x_end = 64, y = 17},
				{button = "ph2_pl6_rng", x_begin = 66, x_end = 68, y = 17},
				{button = "ph2_pl6_run", x_begin = 70, x_end = 72, y = 17},
				{button = "ph2_pl6_sam", x_begin = 74, x_end = 76, y = 17},
				{button = "ph2_pl6_sch", x_begin = 78, x_end = 80, y = 17},
				{button = "ph2_pl6_smn", x_begin = 82, x_end = 84, y = 17},
				{button = "ph2_pl6_thf", x_begin = 86, x_end = 88, y = 17},
				{button = "ph2_pl6_war", x_begin = 90, x_end = 92, y = 17},
				{button = "ph2_pl6_whm", x_begin = 94, x_end = 96, y = 17},
			}
			for _, btn in ipairs(additional_buttons) do
				table.insert(button_positions, btn)
			end
		end

		--Additional buttons for Phone 3
		if boss_num >= 3 then
			local additional_buttons = {
				{button = "ph3_pl1_blm", x_begin = 10, x_end = 12, y = 20},
				{button = "ph3_pl1_blu", x_begin = 14, x_end = 16, y = 20},
				{button = "ph3_pl1_brd", x_begin = 18, x_end = 20, y = 20},
				{button = "ph3_pl1_bst", x_begin = 22, x_end = 24, y = 20},
				{button = "ph3_pl1_cor", x_begin = 26, x_end = 28, y = 20},
				{button = "ph3_pl1_dnc", x_begin = 30, x_end = 32, y = 20},
				{button = "ph3_pl1_drg", x_begin = 34, x_end = 36, y = 20},
				{button = "ph3_pl1_drk", x_begin = 38, x_end = 40, y = 20},
				{button = "ph3_pl1_geo", x_begin = 42, x_end = 44, y = 20},
				{button = "ph3_pl1_mnk", x_begin = 46, x_end = 48, y = 20},
				{button = "ph3_pl1_nin", x_begin = 50, x_end = 52, y = 20},
				{button = "ph3_pl1_pld", x_begin = 54, x_end = 56, y = 20},
				{button = "ph3_pl1_pup", x_begin = 58, x_end = 60, y = 20},
				{button = "ph3_pl1_rdm", x_begin = 62, x_end = 64, y = 20},
				{button = "ph3_pl1_rng", x_begin = 66, x_end = 68, y = 20},
				{button = "ph3_pl1_run", x_begin = 70, x_end = 72, y = 20},
				{button = "ph3_pl1_sam", x_begin = 74, x_end = 76, y = 20},
				{button = "ph3_pl1_sch", x_begin = 78, x_end = 80, y = 20},
				{button = "ph3_pl1_smn", x_begin = 82, x_end = 84, y = 20},
				{button = "ph3_pl1_thf", x_begin = 86, x_end = 88, y = 20},
				{button = "ph3_pl1_war", x_begin = 90, x_end = 92, y = 20},
				{button = "ph3_pl1_whm", x_begin = 94, x_end = 96, y = 20},
				{button = "ph3_pl2_blm", x_begin = 10, x_end = 12, y = 21},
				{button = "ph3_pl2_blu", x_begin = 14, x_end = 16, y = 21},
				{button = "ph3_pl2_brd", x_begin = 18, x_end = 20, y = 21},
				{button = "ph3_pl2_bst", x_begin = 22, x_end = 24, y = 21},
				{button = "ph3_pl2_cor", x_begin = 26, x_end = 28, y = 21},
				{button = "ph3_pl2_dnc", x_begin = 30, x_end = 32, y = 21},
				{button = "ph3_pl2_drg", x_begin = 34, x_end = 36, y = 21},
				{button = "ph3_pl2_drk", x_begin = 38, x_end = 40, y = 21},
				{button = "ph3_pl2_geo", x_begin = 42, x_end = 44, y = 21},
				{button = "ph3_pl2_mnk", x_begin = 46, x_end = 48, y = 21},
				{button = "ph3_pl2_nin", x_begin = 50, x_end = 52, y = 21},
				{button = "ph3_pl2_pld", x_begin = 54, x_end = 56, y = 21},
				{button = "ph3_pl2_pup", x_begin = 58, x_end = 60, y = 21},
				{button = "ph3_pl2_rdm", x_begin = 62, x_end = 64, y = 21},
				{button = "ph3_pl2_rng", x_begin = 66, x_end = 68, y = 21},
				{button = "ph3_pl2_run", x_begin = 70, x_end = 72, y = 21},
				{button = "ph3_pl2_sam", x_begin = 74, x_end = 76, y = 21},
				{button = "ph3_pl2_sch", x_begin = 78, x_end = 80, y = 21},
				{button = "ph3_pl2_smn", x_begin = 82, x_end = 84, y = 21},
				{button = "ph3_pl2_thf", x_begin = 86, x_end = 88, y = 21},
				{button = "ph3_pl2_war", x_begin = 90, x_end = 92, y = 21},
				{button = "ph3_pl2_whm", x_begin = 94, x_end = 96, y = 21},
				{button = "ph3_pl3_blm", x_begin = 10, x_end = 12, y = 22},
				{button = "ph3_pl3_blu", x_begin = 14, x_end = 16, y = 22},
				{button = "ph3_pl3_brd", x_begin = 18, x_end = 20, y = 22},
				{button = "ph3_pl3_bst", x_begin = 22, x_end = 24, y = 22},
				{button = "ph3_pl3_cor", x_begin = 26, x_end = 28, y = 22},
				{button = "ph3_pl3_dnc", x_begin = 30, x_end = 32, y = 22},
				{button = "ph3_pl3_drg", x_begin = 34, x_end = 36, y = 22},
				{button = "ph3_pl3_drk", x_begin = 38, x_end = 40, y = 22},
				{button = "ph3_pl3_geo", x_begin = 42, x_end = 44, y = 22},
				{button = "ph3_pl3_mnk", x_begin = 46, x_end = 48, y = 22},
				{button = "ph3_pl3_nin", x_begin = 50, x_end = 52, y = 22},
				{button = "ph3_pl3_pld", x_begin = 54, x_end = 56, y = 22},
				{button = "ph3_pl3_pup", x_begin = 58, x_end = 60, y = 22},
				{button = "ph3_pl3_rdm", x_begin = 62, x_end = 64, y = 22},
				{button = "ph3_pl3_rng", x_begin = 66, x_end = 68, y = 22},
				{button = "ph3_pl3_run", x_begin = 70, x_end = 72, y = 22},
				{button = "ph3_pl3_sam", x_begin = 74, x_end = 76, y = 22},
				{button = "ph3_pl3_sch", x_begin = 78, x_end = 80, y = 22},
				{button = "ph3_pl3_smn", x_begin = 82, x_end = 84, y = 22},
				{button = "ph3_pl3_thf", x_begin = 86, x_end = 88, y = 22},
				{button = "ph3_pl3_war", x_begin = 90, x_end = 92, y = 22},
				{button = "ph3_pl3_whm", x_begin = 94, x_end = 96, y = 22},
				{button = "ph3_pl4_blm", x_begin = 10, x_end = 12, y = 23},
				{button = "ph3_pl4_blu", x_begin = 14, x_end = 16, y = 23},
				{button = "ph3_pl4_brd", x_begin = 18, x_end = 20, y = 23},
				{button = "ph3_pl4_bst", x_begin = 22, x_end = 24, y = 23},
				{button = "ph3_pl4_cor", x_begin = 26, x_end = 28, y = 23},
				{button = "ph3_pl4_dnc", x_begin = 30, x_end = 32, y = 23},
				{button = "ph3_pl4_drg", x_begin = 34, x_end = 36, y = 23},
				{button = "ph3_pl4_drk", x_begin = 38, x_end = 40, y = 23},
				{button = "ph3_pl4_geo", x_begin = 42, x_end = 44, y = 23},
				{button = "ph3_pl4_mnk", x_begin = 46, x_end = 48, y = 23},
				{button = "ph3_pl4_nin", x_begin = 50, x_end = 52, y = 23},
				{button = "ph3_pl4_pld", x_begin = 54, x_end = 56, y = 23},
				{button = "ph3_pl4_pup", x_begin = 58, x_end = 60, y = 23},
				{button = "ph3_pl4_rdm", x_begin = 62, x_end = 64, y = 23},
				{button = "ph3_pl4_rng", x_begin = 66, x_end = 68, y = 23},
				{button = "ph3_pl4_run", x_begin = 70, x_end = 72, y = 23},
				{button = "ph3_pl4_sam", x_begin = 74, x_end = 76, y = 23},
				{button = "ph3_pl4_sch", x_begin = 78, x_end = 80, y = 23},
				{button = "ph3_pl4_smn", x_begin = 82, x_end = 84, y = 23},
				{button = "ph3_pl4_thf", x_begin = 86, x_end = 88, y = 23},
				{button = "ph3_pl4_war", x_begin = 90, x_end = 92, y = 23},
				{button = "ph3_pl4_whm", x_begin = 94, x_end = 96, y = 23},
				{button = "ph3_pl5_blm", x_begin = 10, x_end = 12, y = 24},
				{button = "ph3_pl5_blu", x_begin = 14, x_end = 16, y = 24},
				{button = "ph3_pl5_brd", x_begin = 18, x_end = 20, y = 24},
				{button = "ph3_pl5_bst", x_begin = 22, x_end = 24, y = 24},
				{button = "ph3_pl5_cor", x_begin = 26, x_end = 28, y = 24},
				{button = "ph3_pl5_dnc", x_begin = 30, x_end = 32, y = 24},
				{button = "ph3_pl5_drg", x_begin = 34, x_end = 36, y = 24},
				{button = "ph3_pl5_drk", x_begin = 38, x_end = 40, y = 24},
				{button = "ph3_pl5_geo", x_begin = 42, x_end = 44, y = 24},
				{button = "ph3_pl5_mnk", x_begin = 46, x_end = 48, y = 24},
				{button = "ph3_pl5_nin", x_begin = 50, x_end = 52, y = 24},
				{button = "ph3_pl5_pld", x_begin = 54, x_end = 56, y = 24},
				{button = "ph3_pl5_pup", x_begin = 58, x_end = 60, y = 24},
				{button = "ph3_pl5_rdm", x_begin = 62, x_end = 64, y = 24},
				{button = "ph3_pl5_rng", x_begin = 66, x_end = 68, y = 24},
				{button = "ph3_pl5_run", x_begin = 70, x_end = 72, y = 24},
				{button = "ph3_pl5_sam", x_begin = 74, x_end = 76, y = 24},
				{button = "ph3_pl5_sch", x_begin = 78, x_end = 80, y = 24},
				{button = "ph3_pl5_smn", x_begin = 82, x_end = 84, y = 24},
				{button = "ph3_pl5_thf", x_begin = 86, x_end = 88, y = 24},
				{button = "ph3_pl5_war", x_begin = 90, x_end = 92, y = 24},
				{button = "ph3_pl5_whm", x_begin = 94, x_end = 96, y = 24},
				{button = "ph3_pl6_blm", x_begin = 10, x_end = 12, y = 25},
				{button = "ph3_pl6_blu", x_begin = 14, x_end = 16, y = 25},
				{button = "ph3_pl6_brd", x_begin = 18, x_end = 20, y = 25},
				{button = "ph3_pl6_bst", x_begin = 22, x_end = 24, y = 25},
				{button = "ph3_pl6_cor", x_begin = 26, x_end = 28, y = 25},
				{button = "ph3_pl6_dnc", x_begin = 30, x_end = 32, y = 25},
				{button = "ph3_pl6_drg", x_begin = 34, x_end = 36, y = 25},
				{button = "ph3_pl6_drk", x_begin = 38, x_end = 40, y = 25},
				{button = "ph3_pl6_geo", x_begin = 42, x_end = 44, y = 25},
				{button = "ph3_pl6_mnk", x_begin = 46, x_end = 48, y = 25},
				{button = "ph3_pl6_nin", x_begin = 50, x_end = 52, y = 25},
				{button = "ph3_pl6_pld", x_begin = 54, x_end = 56, y = 25},
				{button = "ph3_pl6_pup", x_begin = 58, x_end = 60, y = 25},
				{button = "ph3_pl6_rdm", x_begin = 62, x_end = 64, y = 25},
				{button = "ph3_pl6_rng", x_begin = 66, x_end = 68, y = 25},
				{button = "ph3_pl6_run", x_begin = 70, x_end = 72, y = 25},
				{button = "ph3_pl6_sam", x_begin = 74, x_end = 76, y = 25},
				{button = "ph3_pl6_sch", x_begin = 78, x_end = 80, y = 25},
				{button = "ph3_pl6_smn", x_begin = 82, x_end = 84, y = 25},
				{button = "ph3_pl6_thf", x_begin = 86, x_end = 88, y = 25},
				{button = "ph3_pl6_war", x_begin = 90, x_end = 92, y = 25},
				{button = "ph3_pl6_whm", x_begin = 94, x_end = 96, y = 25},
			}
			for _, btn in ipairs(additional_buttons) do
				table.insert(button_positions, btn)
			end
		end
	end

	--Determine which button the mouse is over
	for _, pos in ipairs(button_positions) do
		if mouseX >= grid_pos.x + settings.padding + (button_width * (pos.x_begin - 1))
		and mouseX <= grid_pos.x + settings.padding + (button_width * pos.x_end)
		and mouseY >= grid_pos.y + settings.padding + (button_height * (pos.y - 1))
		and mouseY <= grid_pos.y + settings.padding + (button_height * pos.y) then
			return pos.button
		end
	end

	--The mouse is not over a button
	return "none"

end

--Event handler for mouse clicks
function onMouseClick(type, mouseX, mouseY)

	--Block if not visible
	if not main_window_visible then return end

	--Block any clicks within 0.05 seconds of the last click to prevent Windower double-click bug
	if double_click_fix then
		double_click_fix = false
		coroutine.schedule(function()
			double_click_fix = true
		end, 0.01)
	else
		return
	end

	if type == 1 then

		--Get the mouse position relative to the grid
		local click = getMouseOnButton(mouseX, mouseY)

		--Load Phone/boss data
		local function loadBossSaveData(save_num)
			local saved = settings.save_data[save_num] and settings.save_data[save_num].phone_selection
			if not saved then
				return {nil, nil, nil}
			end

			local result = {}
			for i = 1, 3 do
				local name = saved[tostring(i)]
				result[i] = (name and name ~= "") and name or nil
			end

			return result
		end		

		--Save Phone/boss data
		local function saveBossSaveData(phone_selection)
			local result = {}
			local index = 1

			--Shift non-nil values up to fill earlier slots
			for i = 1, 3 do
				local name = phone_selection[i]
				if name then
					result[tostring(index)] = name
					index = index + 1
				end
			end

			return result
		end

		--Adjust any non-nil Phone/boss selections left in the table
		local function adjustPhoneNumbers()
			--If any Phone selections are empty, move the next available selection up (Bumba, nil, Ongo --> Bumba, Ongo, nil)
			for i = 1, 3 do
				if phone_selection[i] == nil then
					--If there's a non-nil selection after this one, move it up
					for j = i + 1, 3 do
						if phone_selection[j] ~= nil then
							phone_selection[i] = phone_selection[j]
							phone_selection[j] = nil
							break
						end
					end
				end
			end
		end
		
		--Handle Navigation/Action button clicks
		if click == "none" then
			return
		elseif click == "jobs" then
			--Make sure at least one boss has been selected before proceeding
			if isAnyBossAssigned() then
				adjustPhoneNumbers()
				current_screen = "jobs"
			end
		elseif click == "confirm_clear_jobs" then
			if isAnyJobAssigned() then
				displayConfirmWindow("clear_jobs", "Clear all job selections?")
			end
		elseif click == "clear_jobs" then
			player_jobs = {blm = nil, blu = nil, brd = nil, bst = nil, cor = nil, dnc = nil, drg = nil, drk = nil, geo = nil, mnk = nil, nin = nil, pld = nil, pup = nil, rdm = nil, rng = nil, run = nil, sam = nil, sch = nil, smn = nil, thf = nil, war = nil, whm = nil}
			hideConfirmWindow()
		elseif click == "clear_bosses" then
			phone_selection = {nil, nil, nil}
		elseif click == "back" then
			if not isAnyJobAssigned() then
				current_screen = "bosses"
			else
				current_screen = previous_screen
			end
		elseif click == "bosses" then
			current_screen = "bosses"
		elseif click == "options" then
			adjustPhoneNumbers()
			previous_screen = current_screen
			current_screen = "options"
		elseif click == "hover_effects_on" then
			hover_effects = true
			settings.options.hover_effects = true
			settings:save('all')
		elseif click == "hover_effects_off" then
			hover_effects = false
			settings.options.hover_effects = false
			settings:save('all')
		elseif click == "size_up" then
			settings.text.size = math.min(15, settings.text.size + 1)
			main_window:size(settings.text.size)
			confirm_window:size(settings.text.size)
			settings:save('all')
		elseif click == "size_down" then
			settings.text.size = math.max(5, settings.text.size - 1)
			main_window:size(settings.text.size)
			confirm_window:size(settings.text.size)
			settings:save('all')
		elseif click == "bg_alpha_up" then
			settings.bg.alpha = math.min(255, settings.bg.alpha + 15)
			main_window:bg_alpha(settings.bg.alpha)
			settings:save('all')
		elseif click == "bg_alpha_down" then
			settings.bg.alpha = math.max(0, settings.bg.alpha - 15)
			main_window:bg_alpha(settings.bg.alpha)
			settings:save('all')
		elseif click == "bold_on" then
			settings.flags.bold = true
			main_window:bold(true)
			confirm_window:bold(true)
			settings:save('all')
		elseif click == "bold_off" then
			settings.flags.bold = false
			main_window:bold(false)
			confirm_window:bold(false)
			settings:save('all')
		elseif click == "save_1" then
			settings.save_data.save_1.phone_selection = saveBossSaveData(phone_selection)
			settings.save_data.save_1.player_jobs = player_jobs
			settings:save('all')
		elseif click == "load_1" then
			phone_selection = loadBossSaveData("save_1")
			player_jobs = settings.save_data.save_1.player_jobs
		elseif click == "confirm_delete_1" then
			if isSaveDataPresent("save_1") then
				displayConfirmWindow("delete_1", "Delete Save 1?")
			end
		elseif click == "delete_1" then
			settings.save_data.save_1.phone_selection = nil
			settings.save_data.save_1.player_jobs = nil
			settings:save('all')
			hideConfirmWindow()
		elseif click == "save_2" then
			settings.save_data.save_2.phone_selection = saveBossSaveData(phone_selection)
			settings.save_data.save_2.player_jobs = player_jobs
			settings:save('all')
		elseif click == "load_2" then
			phone_selection = loadBossSaveData("save_2")
			player_jobs = settings.save_data.save_2.player_jobs
		elseif click == "confirm_delete_2" then
			if isSaveDataPresent("save_2") then
				displayConfirmWindow("delete_2", "Delete Save 2?")
			end
		elseif click == "delete_2" then
			settings.save_data.save_2.phone_selection = nil
			settings.save_data.save_2.player_jobs = nil
			settings:save('all')
			hideConfirmWindow()
		elseif click == "save_3" then
			settings.save_data.save_3.phone_selection = saveBossSaveData(phone_selection)
			settings.save_data.save_3.player_jobs = player_jobs
			settings:save('all')
		elseif click == "load_3" then
			phone_selection = loadBossSaveData("save_3")
			player_jobs = settings.save_data.save_3.player_jobs
		elseif click == "confirm_delete_3" then
			if isSaveDataPresent("save_3") then
				displayConfirmWindow("delete_3", "Delete Save 3?")
			end
		elseif click == "delete_3" then
			settings.save_data.save_3.phone_selection = nil
			settings.save_data.save_3.player_jobs = nil
			settings:save('all')
			hideConfirmWindow()
		elseif click == "save_4" then
			settings.save_data.save_4.phone_selection = saveBossSaveData(phone_selection)
			settings.save_data.save_4.player_jobs = player_jobs
			settings:save('all')
		elseif click == "load_4" then
			phone_selection = loadBossSaveData("save_4")
			player_jobs = settings.save_data.save_4.player_jobs
		elseif click == "confirm_delete_4" then
			if isSaveDataPresent("save_4") then
				displayConfirmWindow("delete_4", "Delete Save 4?")
			end
		elseif click == "delete_4" then
			settings.save_data.save_4.phone_selection = nil
			settings.save_data.save_4.player_jobs = nil
			settings:save('all')
			hideConfirmWindow()
		elseif click == "save_5" then
			settings.save_data.save_5.phone_selection = saveBossSaveData(phone_selection)
			settings.save_data.save_5.player_jobs = player_jobs
			settings:save('all')
		elseif click == "load_5" then
			phone_selection = loadBossSaveData("save_5")
			player_jobs = settings.save_data.save_5.player_jobs
		elseif click == "confirm_delete_5" then
			if isSaveDataPresent("save_5") then
				displayConfirmWindow("delete_5", "Delete Save 5?")
			end
		elseif click == "delete_5" then
			settings.save_data.save_5.phone_selection = nil
			settings.save_data.save_5.player_jobs = nil
			settings:save('all')
			hideConfirmWindow()
		elseif click == "github" then
			local url = "https://github.com/iLVL-Key/FFXI"
			open_url(url)
			copy_to_clipboard(url)
			add_to_chat(1,'[GaolPlan] ':color(220)..'GitHub URL Copied To Clipboard.':color(8))
		elseif click == "discord" then
			local url = "https://discord.gg/eKtpvjx"
			open_url(url)
			copy_to_clipboard(url)
			add_to_chat(1,'[GaolPlan] ':color(220)..'Discord URL Copied To Clipboard.':color(8))
		elseif click == "confirm_default" then
			displayConfirmWindow("default", "Reset settings to defaults?")
		elseif click == "default" then
			settings.options.hover_effects = defaults.options.hover_effects
			hover_effects = defaults.options.hover_effects
			settings.text.size = defaults.text.size
			settings.bg.alpha = defaults.bg.alpha
			settings.text.alpha = defaults.text.alpha
			bg_alpha_num = defaults.bg.alpha
			text_alpha_num = defaults.text.alpha
			settings.flags.bold = defaults.flags.bold
			main_window:size(defaults.text.size)
			main_window:bg_alpha(defaults.bg.alpha)
			main_window:bold(defaults.flags.bold)
			confirm_window:size(defaults.text.size)
			confirm_window:bold(defaults.flags.bold)
			settings:save('all')
			hideConfirmWindow()
		elseif click == "copy_1" then
			local text = generatePlanOutput().phone_1
			if text then
				copy_to_clipboard(text)
				add_to_chat(1,'[GaolPlan] ':color(220)..'Phone 1 Plan Copied To Clipboard.':color(8))
			end
		elseif click == "copy_2" then
			local text = generatePlanOutput().phone_2
			if text then
				copy_to_clipboard(text)
				add_to_chat(1,'[GaolPlan] ':color(220)..'Phone 2 Plan Copied To Clipboard.':color(8))
			end
		elseif click == "copy_3" then
			local text = generatePlanOutput().phone_3
			if text then
				copy_to_clipboard(text)
				add_to_chat(1,'[GaolPlan] ':color(220)..'Phone 3 Plan Copied To Clipboard.':color(8))
			end
		elseif click == "party" then
			local text = generatePlanOutput()
			for i = 1, 3 do
				if text["phone_"..i] then
					input("/p "..text["phone_"..i])
					coroutine.sleep(1.5)
				end
			end
		elseif click == "party_w_bp" then
			local text = generatePlanOutput()
			for i = 1, 3 do
				if text["phone_"..i] then
					input("/p !bp"..i.." "..text["phone_"..i])
					coroutine.sleep(1.5)
				end
			end
		elseif click == "close" then
			main_window:hide()
			main_window_visible = false
		elseif click == "pin" then
			settings.flags.draggable = not settings.flags.draggable
			settings:save('all')
		elseif click == "confirm_no" then
			hideConfirmWindow()

		--Handle button clicks on the Bosses screen
		elseif current_screen == "bosses" then
			for boss_button, boss_name in pairs(boss_map) do
				for i = 1, 3 do
					if click == "ph"..i.."_"..boss_button then
						if phone_selection[i] == boss_name then
							phone_selection[i] = nil
						else
							phone_selection[i] = boss_name
						end
					end
				end
			end

		--Handle button clicks on the Jobs screen
		elseif current_screen == "jobs" then
			local phone_player, job_code = click:sub(1, 7), click:sub(-3) --Extract "phX_plY" and job code

			--If the job is already assigned to this phone/player, deselect it
			if player_jobs[job_code] == phone_player then
				player_jobs[job_code] = nil
			else
				--Remove the player from any other assigned job
				for job, assigned_player in pairs(player_jobs) do
					if assigned_player == phone_player then
						player_jobs[job] = nil  --Clear the previous job assignment
					end
				end
		
				--Assign the new job to the player
				player_jobs[job_code] = phone_player
			end
		end

		updateMainWindow()
	end

end

--Event hndler for mouse movement
function onMouseMove(type, mouseX, mouseY)

	if main_window_visible and hover_effects then
		--Get the mouse position relative to the grid
		hover = getMouseOnButton(mouseX, mouseY)
		-- print(hover)

		if confirm_window_visible then
			updateConfirmWindow()
		else
			updateMainWindow()
		end
	end

end


--Register the mouse click event
register_event('mouse', onMouseClick)

--Register the mouse move event
register_event('mouse', onMouseMove)

register_event('addon command',function(add_cmd, ...)

	local arg = {...}

	if add_cmd == "help" then
		local currSize = settings.text.size
		local prefix = "//gaolplan, //gp"
		add_to_chat(8,('[GaolPlan] ':color(220))..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220)..(' ('):color(8)..(prefix):color(1)..(')'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,(' Command '):color(36)..('[optional]'):color(53)..(' - Description ['):color(8)..('Current Setting'):color(200)..(']'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,(' (blank/no command) '):color(36)..('- Show/hide the window.'):color(8))

	else

		--If the screen is already visible, hide it
		if main_window_visible then
			main_window:hide()
			main_window_visible = false

		--If the screen is not visible, show it
		else
			main_window:show()
			main_window_visible = true
		end

	end
end)

register_event('prerender', function()

	--Once per second...
	if os.time() > heartbeat then
		heartbeat = os.time()
		--Update main_window to adjust player name positions if party is rearranged
		if main_window_visible and not hover_effects then
			updateMainWindow()
		end
	end

end)

updateMainWindow()
