--Copyright (c) 2025, Key
--All rights reserved.

--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:

--    * Redistributions of source code must retain the above copyright
--      notice, this list of conditions and the following disclaimer.
--    * Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in the
--      documentation and/or other materials provided with the distribution.
--    * Neither the name of VanaPad nor the
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

_addon.name = 'VanaPad'
_addon.version = '1.0'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'vanapad','vp'}

config = require('config')
texts = require('texts')
require 'chat'

add_to_chat = windower.add_to_chat
send_command = windower.send_command
register_event = windower.register_event

defaults = {
	pos = {
		x = windower.get_windower_settings().ui_x_res - 604,
		y = 16
	},
	text = {
		alpha = 255,
		blue = 25,
		green = 25,
		red = 25,
		font = 'Consolas',
		size = 12
	},
	padding = 5,
	flags = {
		draggable = true,
		italic = false,
		bold = false,
		right = false,
		bottom = false
	},
	notes = {},
	visible = true,
	options = {
		window_width = 40,
		fade_delay = 5,
		fade_multiplier = 3,
		fade_bg_max = 230,
		fade_bg_min = 75,
		colors = {
			text_header = { r = 25, g = 25, b = 25 },
			text_note = { r = 25, g = 25, b = 25 },
			bg_edit = { r = 178, g = 196, b = 223 },
			bg_normal = { r = 102, g = 137, b = 191 },
			btn_hover = { r = 255, g = 25, b = 25 },
			btn_note_current = { r = 25, g = 25, b = 25 },
			btn_note_empty = { r = 61, g = 82, b = 114 },
			btn_note_full = { r = 225, g = 225, b = 225 },
		}
	}
}

settings = config.load(defaults)

color = settings.options.colors
note = settings.notes
option = settings.options

c = {}
c.copy_delete = color.text_header
c.edit = color.text_header
c.note0 = note.note0 and color.btn_note_full or color.btn_note_empty
c.note1 = note.note1 and color.btn_note_full or color.btn_note_empty
c.note2 = note.note2 and color.btn_note_full or color.btn_note_empty
c.note3 = note.note3 and color.btn_note_full or color.btn_note_empty
c.note4 = note.note4 and color.btn_note_full or color.btn_note_empty
c.note5 = note.note5 and color.btn_note_full or color.btn_note_empty
c.note6 = note.note6 and color.btn_note_full or color.btn_note_empty
c.note7 = note.note7 and color.btn_note_full or color.btn_note_empty
c.note8 = note.note8 and color.btn_note_full or color.btn_note_empty
c.note9 = note.note9 and color.btn_note_full or color.btn_note_empty
c.help = color.text_header
c.underscore = color.text_header
c.pin = color.text_header
c.hide = color.text_header
c.content = color.text_note

hovering_over = {
    copy_delete = false,
    edit = false,
    note0 = false,
    note1 = false,
    note2 = false,
    note3 = false,
    note4 = false,
    note5 = false,
    note6 = false,
    note7 = false,
    note8 = false,
    note9 = false,
    help = false,
    underscore = false,
    pin = false,
    hide = false
}

addon_name = _addon.name
title = addon_name
current_note = "none"
title_override = nil
new_title = {
    note0 = "Note 0",
    note1 = "Note 1",
    note2 = "Note 2",
    note3 = "Note 3",
    note4 = "Note 4",
    note5 = "Note 5",
    note6 = "Note 6",
    note7 = "Note 7",
    note8 = "Note 8",
    note9 = "Note 9"
}
heartbeat = 0
fade = false
fade_delay = option.fade_delay
fade_num = option.fade_bg_max
zoning = false
entering_note = false
temp_string = ""
shift_down = false

--These help to fix a weird double-click bug in windower
double_click_fix_edit = false
double_click_fix_pin = settings.flags.draggable
double_click_fix_help = false
double_click_fix_copy = false

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

--Format RGB values with leading zeros (helps prevent an issue with text shifting when changing colors)
function formatRGB(value)
	return string.format("%03d", value)
end

--Update the VanaPad text box
function updateBox(display_note)

	local cx = c.copy_delete
	local ce = c.edit
	local c0 = current_note == "note0" and color.btn_note_current or c.note0
	local c1 = current_note == "note1" and color.btn_note_current or c.note1
	local c2 = current_note == "note2" and color.btn_note_current or c.note2
	local c3 = current_note == "note3" and color.btn_note_current or c.note3
	local c4 = current_note == "note4" and color.btn_note_current or c.note4
	local c5 = current_note == "note5" and color.btn_note_current or c.note5
	local c6 = current_note == "note6" and color.btn_note_current or c.note6
	local c7 = current_note == "note7" and color.btn_note_current or c.note7
	local c8 = current_note == "note8" and color.btn_note_current or c.note8
	local c9 = current_note == "note9" and color.btn_note_current or c.note9
	local ch = c.help
	local cu = c.underscore
	local cp = c.pin
	local cX = c.hide
	local cc = c.content

	function wordWrap(input)
		local window_width = option.window_width - 1
		input = input and input:gsub("%$%{new_line%}", "\n") or " "
		local segments = {}
		for segment in input:gmatch("[^\n]+") do
			table.insert(segments, segment)
		end

		local result = ""
		local current_line_length = 0
		local lines = {}
		local last_segment = segments[#segments]

		for _, segment in ipairs(segments) do
			local words = {}
			for word in segment:gmatch("%S+") do
				table.insert(words, word)
			end

			for i, word in ipairs(words) do
				while #word >= window_width do
					if current_line_length > 0 then
						table.insert(lines, result)
						result = ""
						current_line_length = 0
					end
					result = word:sub(1, window_width - 1).."-"
					word = word:sub(window_width)
					table.insert(lines, result)
					result = ""
				end

				if current_line_length + #word >= window_width then
					if current_line_length > 0 then
						table.insert(lines, result)
						result = ""
					end
					current_line_length = 0
				elseif current_line_length > 0 then
					result = result.." "
					current_line_length = current_line_length + 1
				end

				result = result..word
				current_line_length = current_line_length + #word
			end

			if segment == last_segment and segment:match("%s+$") then
				local trailing_spaces = segment:match("%s+$")
				result = result..trailing_spaces
				current_line_length = current_line_length + #trailing_spaces
			end

			if #segment > 0 then
				table.insert(lines, result)
				result = ""
				current_line_length = 0
			end
		end

		if result ~= "" then
			table.insert(lines, result)
		end

		if entering_note then
			local last_line_index = #lines
			lines[last_line_index] = lines[last_line_index] and lines[last_line_index].."\\cs(255,050,050)|\\cr" or "\\cs(255,050,050)|\\cr"
		end

		return lines
	end

	local empty_note = "Click Edit (±) or type \n`//vp edit textgoeshere`"

	--Content of the note displayed
	local content = ""

	if display_note == "none" then
		title = title_override and title_override or addon_name
	else
		title = title_override and title_override or (entering_note and "Edit Mode" or (note[display_note] and note[display_note].title or new_title[display_note]))
		local wrapped_content = wordWrap(note[display_note] and note[display_note].content or "")
		content = note[display_note] and "\\cs("..formatRGB(cc.r)..","..formatRGB(cc.g)..","..formatRGB(cc.b)..")"..table.concat(wrapped_content, "\n").."\\cr" or (entering_note and "\\cs(255,050,050)|\\cr" or empty_note)
	end

	local total_length = option.window_width
	local title_max = total_length - 20 --Space for the buttons
	local truncated_title = string.sub(title, 1, title_max)
	local text_length = string.len(truncated_title)
	local spaces_count = title_max - text_length
	local spaces = string.rep(" ", spaces_count)
	local pin = settings.flags.draggable and "○" or "•"

	--Buttons
	local bx = entering_note and current_note ~= "none" and note[current_note] and "\\cs("..formatRGB(cx.r)..","..formatRGB(cx.g)..","..formatRGB(cx.b)..")×\\cr"
	or (
		not entering_note and current_note ~= "none" and note[current_note] and "\\cs("..formatRGB(cx.r)..","..formatRGB(cx.g)..","..formatRGB(cx.b)..")c\\cr" or "\\cs(255,255,255) \\cr"
	)
	local be = current_note ~= "none" and "\\cs("..formatRGB(ce.r)..","..formatRGB(ce.g)..","..formatRGB(ce.b)..")±\\cr" or "\\cs(255,255,255) \\cr"
	local b0 = "\\cs("..formatRGB(c0.r)..","..formatRGB(c0.g)..","..formatRGB(c0.b)..")0\\cr"
	local b1 = "\\cs("..formatRGB(c1.r)..","..formatRGB(c1.g)..","..formatRGB(c1.b)..")1\\cr"
	local b2 = "\\cs("..formatRGB(c2.r)..","..formatRGB(c2.g)..","..formatRGB(c2.b)..")2\\cr"
	local b3 = "\\cs("..formatRGB(c3.r)..","..formatRGB(c3.g)..","..formatRGB(c3.b)..")3\\cr"
	local b4 = "\\cs("..formatRGB(c4.r)..","..formatRGB(c4.g)..","..formatRGB(c4.b)..")4\\cr"
	local b5 = "\\cs("..formatRGB(c5.r)..","..formatRGB(c5.g)..","..formatRGB(c5.b)..")5\\cr"
	local b6 = "\\cs("..formatRGB(c6.r)..","..formatRGB(c6.g)..","..formatRGB(c6.b)..")6\\cr"
	local b7 = "\\cs("..formatRGB(c7.r)..","..formatRGB(c7.g)..","..formatRGB(c7.b)..")7\\cr"
	local b8 = "\\cs("..formatRGB(c8.r)..","..formatRGB(c8.g)..","..formatRGB(c8.b)..")8\\cr"
	local b9 = "\\cs("..formatRGB(c9.r)..","..formatRGB(c9.g)..","..formatRGB(c9.b)..")9\\cr"
	local bh = "\\cs("..formatRGB(ch.r)..","..formatRGB(ch.g)..","..formatRGB(ch.b)..")?\\cr"
	local bu = "\\cs("..formatRGB(cu.r)..","..formatRGB(cu.g)..","..formatRGB(cu.b)..")_\\cr"
	local bp = "\\cs("..formatRGB(cp.r)..","..formatRGB(cp.g)..","..formatRGB(cp.b)..")"..pin.."\\cr"
	local bX = "\\cs("..formatRGB(cX.r)..","..formatRGB(cX.g)..","..formatRGB(cX.b)..")X\\cr"

--VanaPad v1.0             x ± 0123456789 ?_•X
--○•

	return truncated_title..spaces.." "..bx.." "..be.." "..b0..b1..b2..b3..b4..b5..b6..b7..b8..b9.." "..bh..bu..bp..bX..(content ~= "" and "\n\n" or (entering_note and "\n\n\n\n" or ""))..content
end

--Create the VanaPad text object
formatted_display = updateBox("none")
VanaPad = texts.new(formatted_display, settings)
if settings.visible then
	VanaPad:show()
end

--Set initial state of the text box using settings from the options
function initialize()
	local tc = color.text_header
	VanaPad:color(tc.r,tc.g,tc.b)
	local bgc = color.bg_normal
	VanaPad:bg_color(bgc.r,bgc.g,bgc.b)
	VanaPad:bg_alpha(option.fade_bg_max)
end

--Delete the current note
function deleteNote(note)
	if note ~= "none" then
		settings.notes[note] = nil
		settings:save('all')
	end
	if double_click_fix_edit == true then
		disableEditMode()
	end
	VanaPad:text(updateBox(current_note))
end

--Copy the current note to the clipboard
function copyNote(note_to_copy)
    if note_to_copy ~= "none" then
        local note_content = note[note_to_copy].content:gsub("%${new_line}", " ") --Replace ${new_line} with space
        windower.copy_to_clipboard(note_content)
        add_to_chat(8,('[VanaPad] '):color(220)..('Note copied to clipboard. Use '):color(8)..('Ctrl+V'):color(1)..(' to paste.'):color(8))
    end
end

--Enable Edit Mode
function enableEditMode()
	entering_note = true
	double_click_fix_edit = true
	add_to_chat(8,('[VanaPad] '):color(220)..('Edit Mode enabled. Type directly into Vanapad.'):color(8)..(' ESC Key'):color(1)..(' to exit.'):color(8))
	VanaPad:bg_alpha(255)
	local bgc = color.bg_edit
	VanaPad:bg_color(bgc.r,bgc.g,bgc.b)
	VanaPad:text(updateBox(current_note))
end

--Disable Edit Mode
function disableEditMode()
	entering_note = false
	double_click_fix_edit = false
	add_to_chat(8,('[VanaPad] '):color(220)..('Edit Mode disabled. Normal keyboard function resumed.'):color(8))
	if note[current_note] and note[current_note].content == "" then
		deleteNote(current_note)
	end
	VanaPad:bg_alpha(option.fade_bg_max)
	local bgc = color.bg_normal
	VanaPad:bg_color(bgc.r,bgc.g,bgc.b)
	VanaPad:text(updateBox(current_note))
end

--Keyboard input
function keyboard_event(dik, down, flags, blocked)

	--Update shift state
	if dik == 0x2A or dik == 0x36 then  --0x2A and 0x36 are Left Shift and Right Shift
		shift_down = down
		return false
	end

	--If entering note mode, handle input differently
	if entering_note then
		temp_string = note[current_note] and note[current_note].content or ""
		if down then
			if dik == 0x01 then  --Escape key to finish Edit Mode
				disableEditMode()
				return true
			elseif dik == 0x0E then  --Backspace key to delete last character
				if temp_string:sub(-11) == '${new_line}' then
					temp_string = temp_string:sub(1, -12)
				else
					temp_string = temp_string:sub(1, -2)
				end
				editNote(temp_string)
				return true
			elseif dik == 0x1C then  --Enter key to insert a new line
				temp_string = temp_string .. '${new_line}'
				editNote(temp_string)
				return true
			end

			--Handle character input based on shift state
			if key_map.letters[dik] then
				temp_string = temp_string .. (shift_down and key_map.shift_letters[dik] or key_map.letters[dik])
				editNote(temp_string)
				return true
			elseif key_map[dik] then
				temp_string = temp_string .. (shift_down and key_map.shift[dik] or key_map[dik])
				editNote(temp_string)
				return true
			end

		end
		return true  --Block all other inputs while in note-taking mode
	end

	return false  --Allow all other inputs to reach the game
end

--Register the keyboard event
register_event('keyboard', keyboard_event)

function shrinkPad()

	current_note = "none"
	VanaPad:text(updateBox(current_note))

end

--Create a new note
function editNote(content)

	settings.notes[current_note] = {title = new_title[current_note], content = content}
	settings:save('all')
	VanaPad:text(updateBox(current_note))

end

--Update the title of a note
function updateTitle(title)

	settings.notes[current_note].title = title
	settings:save('all')
	VanaPad:text(updateBox(current_note))

end

--Display help information
function displayHelp()
	local prefix = "//vanapad, //vp"
	add_to_chat(8,('[VanaPad] ':color(220))..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220)..(' ('):color(8)..(prefix):color(1)..(')'):color(8))
	add_to_chat(8,' ')
	add_to_chat(8,(' Command '):color(36)..(' - Description'):color(8))
	add_to_chat(8,(' show/hide '):color(36)..(' - Show/hide the VanaPad window.'):color(8))
	add_to_chat(8,(' copy/c '):color(36)..(' - Copy the current note to the clipboard.'):color(8))
	add_to_chat(8,(' edit/e '):color(36)..(' - Edit the current note.'):color(8))
	add_to_chat(8,(' delete/d '):color(36)..(' - Delete the current note.'):color(8))
	add_to_chat(8,(' title/t '):color(36)..(' - Add a custom title to the current note.'):color(8))
end

--Return which button the mouse is hovering over
function getMouseOnCharacter(mouseX, mouseY)
	local box_pos = settings.pos
	local total_width = VanaPad:extents() --Total width of the text box
	local buttons_width = total_width - (settings.padding * 2) --Width of the buttons area (excludes padding)
	local char_width = buttons_width / option.window_width --Width of each character in the buttons area
	local hover_positions = {
		{char = "copy_delete", offset = 19},
		{char = "edit", offset = 17},
		{char = "note0", offset = 15},
		{char = "note1", offset = 14},
		{char = "note2", offset = 13},
		{char = "note3", offset = 12},
		{char = "note4", offset = 11},
		{char = "note5", offset = 10},
		{char = "note6", offset = 9},
		{char = "note7", offset = 8},
		{char = "note8", offset = 7},
		{char = "note9", offset = 6},
		{char = "help", offset = 4},
		{char = "underscore", offset = 3},
		{char = "pin", offset = 2},
		{char = "hide", offset = 1},
	}

	--Hovering over a button
	for _, pos in ipairs(hover_positions) do
		if mouseX >= box_pos.x + settings.padding + buttons_width - (char_width * pos.offset) and mouseX <= box_pos.x + settings.padding + buttons_width - (char_width * (pos.offset - 1)) and mouseY >= box_pos.y and mouseY <= box_pos.y + (settings.text.size * 2.3) then
			return pos.char
		end
	end

	--Not over a button, but still hovering over the bar itself
	if mouseX >= box_pos.x and mouseX <= box_pos.x + total_width and mouseY >= box_pos.y and mouseY <= box_pos.y + (settings.text.size * 2.3) then
		return "bar"
	end

	--Not hovering over the bar at all
	return "none"
end

--Event handler for mouse movements
function onMouseMove(type, mouseX, mouseY)

	--If the box is not visible, no need to bother with checking any mouse hovering
	if not settings.visible then
		return
	end

	local hover = getMouseOnCharacter(mouseX, mouseY)

	if hover ~= "none" then
		if fade_delay < option.fade_delay then
			fade_delay = option.fade_delay
		end
		if fade then
			fade = false
			VanaPad:bg_alpha(option.fade_bg_max)
			fade_num = option.fade_bg_max
			c.note0 = note.note0 and color.btn_note_full or color.btn_note_empty
			c.note1 = note.note1 and color.btn_note_full or color.btn_note_empty
			c.note2 = note.note2 and color.btn_note_full or color.btn_note_empty
			c.note3 = note.note3 and color.btn_note_full or color.btn_note_empty
			c.note4 = note.note4 and color.btn_note_full or color.btn_note_empty
			c.note5 = note.note5 and color.btn_note_full or color.btn_note_empty
			c.note6 = note.note6 and color.btn_note_full or color.btn_note_empty
			c.note7 = note.note7 and color.btn_note_full or color.btn_note_empty
			c.note8 = note.note8 and color.btn_note_full or color.btn_note_empty
			c.note9 = note.note9 and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(current_note))
		end
	end

	if title_override ~= nil and hover == "none" or hover == "bar" then
		title_override = nil
		VanaPad:text(updateBox(current_note))
	end

	if hovering_over[hover] == false then
		hovering_over[hover] = true
		c[hover] = color.btn_hover
		if hover == "copy_delete" then
			title_override = entering_note and note[current_note] and "Delete"
			or (
				not entering_note and current_note ~= "none" and note[current_note] and "Copy" or nil
			)
		elseif hover == "edit" then
			title_override = entering_note and "Finish" or (current_note ~= "none" and "Edit" or nil)
		elseif hover == "help" then
			title_override = "Help"
		elseif hover == "underscore" then
			title_override = "Shrink"
		elseif hover == "pin" then
			title_override = settings.flags.draggable and "Pin" or "Unpin"
		elseif hover == "hide" then
			title_override = "Hide"
		else
			title_override = note[hover] and note[hover].title or "Empty"
		end
		VanaPad:text(updateBox(current_note))
	else
		if hover ~= "copy_delete" and hovering_over.copy_delete == true then
			hovering_over.copy_delete = false
			c.copy_delete = color.text_header
			VanaPad:text(updateBox(current_note))
		end
		if hover ~= "edit" and hovering_over.edit == true then
			hovering_over.edit = false
			c.edit = color.text_header
			VanaPad:text(updateBox(current_note))
		end
		if hover ~= "note0" and hovering_over.note0 == true then
			hovering_over.note0 = false
			c.note0 = note.note0 and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(current_note))
		end
		if hover ~= "note1" and hovering_over.note1 == true then
			hovering_over.note1 = false
			c.note1 = note.note1 and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(current_note))
		end
		if hover ~= "note2" and hovering_over.note2 == true then
			hovering_over.note2 = false
			c.note2 = note.note2 and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(current_note))
		end
		if hover ~= "note3" and hovering_over.note3 == true then
			hovering_over.note3 = false
			c.note3 = note.note3 and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(current_note))
		end
		if hover ~= "note4" and hovering_over.note4 == true then
			hovering_over.note4 = false
			c.note4 = note.note4 and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(current_note))
		end
		if hover ~= "note5" and hovering_over.note5 == true then
			hovering_over.note5 = false
			c.note5 = note.note5 and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(current_note))
		end
		if hover ~= "note6" and hovering_over.note6 == true then
			hovering_over.note6 = false
			c.note6 = note.note6 and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(current_note))
		end
		if hover ~= "note7" and hovering_over.note7 == true then
			hovering_over.note7 = false
			c.note7 = note.note7 and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(current_note))
		end
		if hover ~= "note8" and hovering_over.note8 == true then
			hovering_over.note8 = false
			c.note8 = note.note8 and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(current_note))
		end
		if hover ~= "note9" and hovering_over.note9 == true then
			hovering_over.note9 = false
			c.note9 = note.note9 and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(current_note))
		end
		if hover ~= "help" and hovering_over.help == true then
			hovering_over.help = false
			c.help = color.text_header
			VanaPad:text(updateBox(current_note))
		end
		if hover ~= "underscore" and hovering_over.underscore == true then
			hovering_over.underscore = false
			c.underscore = color.text_header
			VanaPad:text(updateBox(current_note))
		end
		if hover ~= "pin" and hovering_over.pin == true then
			hovering_over.pin = false
			c.pin = color.text_header
			VanaPad:text(updateBox(current_note))
		end
		if hover ~= "hide" and hovering_over.hide == true then
			hovering_over.hide = false
			c.hide = color.text_header
			VanaPad:text(updateBox(current_note))
		end
	end

end

--Event handler for mouse clicks
function onMouseClick(type, mouseX, mouseY)

	if type == 1 then
		
		local click = getMouseOnCharacter(mouseX, mouseY)
		
		if click == "copy_delete" then
			if entering_note and note[current_note] then
				deleteNote(current_note)
			elseif not entering_note and current_note ~= "none" and note[current_note] then
				if not double_click_fix_copy then
					double_click_fix_copy = true
					copyNote(current_note)
				else
					double_click_fix_copy = false
				end
			end
		elseif click == "edit" then
			if entering_note then
				send_command('wait .1;vanapad double_click_fix_edit_false')
			else
				send_command('wait .1;vanapad double_click_fix_edit_true')
			end
		elseif click == "help" then
			double_click_fix_help = true
			send_command('wait .1;vanapad double_click_fix_help')
		elseif click == "underscore" then
			if entering_note then
				disableEditMode()
			end
			shrinkPad()
		elseif click == "pin" then
			if double_click_fix_pin then
				send_command('wait .1;vanapad double_click_fix_pin_false')
				settings.flags.draggable = false
				settings:save('all')
				VanaPad:text(updateBox(current_note))
			else
				send_command('wait .1;vanapad double_click_fix_pin_true')
				settings.flags.draggable = true
				settings:save('all')
				VanaPad:text(updateBox(current_note))
			end
		elseif click == "hide" then
			double_click_fix_hide = true
			send_command('wait .1;vanapad double_click_fix_hide')
		elseif click ~= "none" and click ~= "bar" then
			current_note = click
			VanaPad:text(updateBox(current_note))
		end
	end

end

--Register the mouse click event
register_event('mouse', onMouseClick)

--Register the mouse move event
register_event('mouse', onMouseMove)

--On login, show the BP box if Visible is true
function login()
	if settings.visible then
		VanaPad:show()
	end
end

--On logout, hide the BP box since we don't want it displayed on the title/character screen
function logout()
	VanaPad:hide()
end

--Run the login/logout functions
register_event('login', login)
register_event('logout', logout)

register_event('addon command',function(add_cmd, ...)

	if add_cmd == "edit" or add_cmd == "e" or add_cmd == "new" or add_cmd == "n" then
		local text = table.concat({...}, " ")
		editNote(text)
	elseif add_cmd == "delete" or add_cmd == "d" then
		deleteNote(current_note)
	elseif add_cmd == "copy" or add_cmd == "c" then
		copyNote(current_note)
	elseif add_cmd == "show" then
		VanaPad:show()
		settings.visible = true
		settings:save('all')
	elseif add_cmd == "hide" then
		VanaPad:hide()
		settings.visible = false
		settings:save('all')
	elseif add_cmd == "title" or add_cmd == "t" then
		local text = table.concat({...}, " ")
		updateTitle(text)
	elseif add_cmd == nil or add_cmd == "help" then
		displayHelp()
	elseif add_cmd == "double_click_fix_edit_true" then
		if double_click_fix_edit == false then
			enableEditMode()
		end
	elseif add_cmd == "double_click_fix_edit_false" then
		if double_click_fix_edit == true then
			disableEditMode()
		end
	elseif add_cmd == "double_click_fix_help" then
		if double_click_fix_help then
			displayHelp()
			double_click_fix_help = false
		end
	elseif add_cmd == "double_click_fix_hide" then
		if double_click_fix_hide then
			if entering_note then
				disableEditMode()
			end
			VanaPad:hide()
			add_to_chat(8,('[VanaPad] '):color(220)..('Now hidden. Type '):color(8)..('//vanapad show'):color(1)..(' to display again'):color(8))
			double_click_fix_hide = false
			settings.visible = false
			settings:save('all')
		end
	elseif add_cmd == "double_click_fix_pin_true" then
		double_click_fix_pin = true
	elseif add_cmd == "double_click_fix_pin_false" then
		double_click_fix_pin = false
	end
end)

register_event('prerender', function()

	--Fade timer
	if os.time() > heartbeat then
		heartbeat = os.time()
		if fade_delay > 0 then
			fade_delay = fade_delay -1
		elseif fade_delay == 0 then
			if current_note == "none" then
				fade = true
			end
			fade_delay = -1
		end
	end
	
	--Fade away
	if fade then
		if fade_num > option.fade_bg_min then
			fade_num = fade_num - option.fade_multiplier
			VanaPad:bg_alpha(fade_num)
		elseif fade_num <= option.fade_bg_min then
			fade_num = option.fade_bg_min
			VanaPad:bg_alpha(fade_num)
			c.note0 = color.text_header
			c.note1 = color.text_header
			c.note2 = color.text_header
			c.note3 = color.text_header
			c.note4 = color.text_header
			c.note5 = color.text_header
			c.note6 = color.text_header
			c.note7 = color.text_header
			c.note8 = color.text_header
			c.note9 = color.text_header
			VanaPad:text(updateBox(current_note))
		end
	end

	--Hide while zoning
	local pos = windower.ffxi.get_position()
	if pos == "(?-?)" and not zoning then
		VanaPad:hide()
		zoning = true
	elseif pos ~= "(?-?)" and zoning then
		if settings.visible then
			VanaPad:show()
		end
		zoning = false
	end

end)

register_event('load', function()
	initialize()
end)

register_event('unload', function()
	VanaPad:destroy()
end)
