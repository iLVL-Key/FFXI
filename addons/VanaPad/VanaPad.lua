--Copyright (c) 2024, Key
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
_addon.version = '1.0 BETA-1'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'vanapad','vp'}

config = require('config')
texts = require('texts')
require 'chat'

local defaults = {
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
	notes = {
		note0 = "",
		note1 = "",
		note2 = "",
		note3 = "",
		note4 = "",
		note5 = "",
		note6 = "",
		note7 = "",
		note8 = "",
		note9 = "",
	},
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

local color = settings.options.colors
local note = settings.notes
local option = settings.options

local c = {}
c.little_x = color.text_header
c.edit = color.text_header
c.zero = note.zero and color.btn_note_full or color.btn_note_empty
c.one = note.one and color.btn_note_full or color.btn_note_empty
c.two = note.two and color.btn_note_full or color.btn_note_empty
c.three = note.three and color.btn_note_full or color.btn_note_empty
c.four = note.four and color.btn_note_full or color.btn_note_empty
c.five = note.five and color.btn_note_full or color.btn_note_empty
c.six = note.six and color.btn_note_full or color.btn_note_empty
c.seven = note.seven and color.btn_note_full or color.btn_note_empty
c.eight = note.eight and color.btn_note_full or color.btn_note_empty
c.nine = note.nine and color.btn_note_full or color.btn_note_empty
c.help = color.text_header
c.underscore = color.text_header
c.pin = color.text_header
c.big_x = color.text_header
c.content = color.text_note

local hoveringOver = {
    little_x = false,
    edit = false,
    zero = false,
    one = false,
    two = false,
    three = false,
    four = false,
    five = false,
    six = false,
    seven = false,
    eight = false,
    nine = false,
    help = false,
    underscore = false,
    pin = false,
    big_x = false
}

local addon_name = _addon.name
local title = addon_name
local currentNote = "none"
local titleOverride = nil
local newTitle = {
    zero = "Note 0",
    one = "Note 1",
    two = "Note 2",
    three = "Note 3",
    four = "Note 4",
    five = "Note 5",
    six = "Note 6",
    seven = "Note 7",
    eight = "Note 8",
    nine = "Note 9"
}
local Heartbeat = 0
local Fade = false
local FadeDelay = option.fade_delay
local FadeNum = option.fade_bg_max
local zoning = false
local entering_note = false
local temp_string = ""
local shift_down = false

--these help to fix a weird double-click bug in windower
local double_click_fix_edit = false
local double_click_fix_pin = settings.flags.draggable
local double_click_fix_help = false

-- Mapping of DirectInput key codes to characters
local key_map = {
	-- Numbers and symbols (without shift)
	[0x02] = '1', [0x03] = '2', [0x04] = '3', [0x05] = '4', [0x06] = '5',
	[0x07] = '6', [0x08] = '7', [0x09] = '8', [0x0A] = '9', [0x0B] = '0',
	[0x0C] = '-', [0x0D] = '=', [0x1A] = '[', [0x1B] = ']', [0x27] = ';',
	[0x28] = '\'', [0x29] = '`', [0x2B] = '\\', [0x33] = ',', [0x34] = '.',
	[0x35] = '/', [0x39] = ' ',

	-- Numbers and symbols (with shift)
	shift = {
		[0x02] = '!', [0x03] = '@', [0x04] = '#', [0x05] = '$', [0x06] = '%',
		[0x07] = '^', [0x08] = '&', [0x09] = '*', [0x0A] = '(', [0x0B] = ')',
		[0x0C] = '_', [0x0D] = '+', [0x1A] = '{', [0x1B] = '}', [0x27] = ':',
		[0x28] = '"', [0x29] = '~', [0x2B] = '|', [0x33] = '<', [0x34] = '>',
		[0x35] = '?'
	},

	-- Letters (lowercase)
	letters = {
		[0x10] = 'q', [0x11] = 'w', [0x12] = 'e', [0x13] = 'r', [0x14] = 't',
		[0x15] = 'y', [0x16] = 'u', [0x17] = 'i', [0x18] = 'o', [0x19] = 'p',
		[0x1E] = 'a', [0x1F] = 's', [0x20] = 'd', [0x21] = 'f', [0x22] = 'g',
		[0x23] = 'h', [0x24] = 'j', [0x25] = 'k', [0x26] = 'l', [0x2C] = 'z',
		[0x2D] = 'x', [0x2E] = 'c', [0x2F] = 'v', [0x30] = 'b', [0x31] = 'n',
		[0x32] = 'm'
	},

	-- Letters (uppercase)
	shift_letters = {
		[0x10] = 'Q', [0x11] = 'W', [0x12] = 'E', [0x13] = 'R', [0x14] = 'T',
		[0x15] = 'Y', [0x16] = 'U', [0x17] = 'I', [0x18] = 'O', [0x19] = 'P',
		[0x1E] = 'A', [0x1F] = 'S', [0x20] = 'D', [0x21] = 'F', [0x22] = 'G',
		[0x23] = 'H', [0x24] = 'J', [0x25] = 'K', [0x26] = 'L', [0x2C] = 'Z',
		[0x2D] = 'X', [0x2E] = 'C', [0x2F] = 'V', [0x30] = 'B', [0x31] = 'N',
		[0x32] = 'M'
	}
}

-- Update the VanaPad text box
local function updateBox(displayNote)

	local cx = c.little_x
	local ce = c.edit
	local c0 = currentNote == "zero" and color.btn_note_current or c.zero
	local c1 = currentNote == "one" and color.btn_note_current or c.one
	local c2 = currentNote == "two" and color.btn_note_current or c.two
	local c3 = currentNote == "three" and color.btn_note_current or c.three
	local c4 = currentNote == "four" and color.btn_note_current or c.four
	local c5 = currentNote == "five" and color.btn_note_current or c.five
	local c6 = currentNote == "six" and color.btn_note_current or c.six
	local c7 = currentNote == "seven" and color.btn_note_current or c.seven
	local c8 = currentNote == "eight" and color.btn_note_current or c.eight
	local c9 = currentNote == "nine" and color.btn_note_current or c.nine
	local ch = c.help
	local cu = c.underscore
	local cp = c.pin
	local cX = c.big_x
	local cc = c.content

	function wordWrap(input)
		local window_width = option.window_width - 1
		input = input and input:gsub("%{%$new_line%}", "\n") or " "
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

	local emptyNote = "Click Edit (±) or type \n`//vp edit textgoeshere`"

	--content of the note displayed
	local content = ""

	if displayNote == "none" then
		title = titleOverride and titleOverride or addon_name
	else
		title = titleOverride and titleOverride or (entering_note and "Edit Mode" or (note[displayNote] and note[displayNote].title or newTitle[displayNote]))
		local wrappedContent = wordWrap(note[displayNote] and note[displayNote].content or "")
		content = note[displayNote] and "\\cs("..cc.r..","..cc.g..","..cc.b..")"..table.concat(wrappedContent, "\n").."\\cr" or (entering_note and "\\cs(255,050,050)|\\cr" or emptyNote)
	end

	local totalLength = option.window_width
	local titleMax = totalLength - 20 --space for the buttons
	local truncatedTitle = string.sub(title, 1, titleMax)
	local textLength = string.len(truncatedTitle)
	local spacesCount = titleMax - textLength
	local spaces = string.rep(" ", spacesCount)
	local pin = settings.flags.draggable and "○" or "•"

	--buttons
	local bx = entering_note and currentNote ~= "none" and note[currentNote] and "\\cs("..cx.r..","..cx.g..","..cx.b..")×\\cr" or " "
	local be = currentNote ~= "none" and "\\cs("..ce.r..","..ce.g..","..ce.b..")±\\cr" or " "
	local b0 = "\\cs("..c0.r..","..c0.g..","..c0.b..")0\\cr"
	local b1 = "\\cs("..c1.r..","..c1.g..","..c1.b..")1\\cr"
	local b2 = "\\cs("..c2.r..","..c2.g..","..c2.b..")2\\cr"
	local b3 = "\\cs("..c3.r..","..c3.g..","..c3.b..")3\\cr"
	local b4 = "\\cs("..c4.r..","..c4.g..","..c4.b..")4\\cr"
	local b5 = "\\cs("..c5.r..","..c5.g..","..c5.b..")5\\cr"
	local b6 = "\\cs("..c6.r..","..c6.g..","..c6.b..")6\\cr"
	local b7 = "\\cs("..c7.r..","..c7.g..","..c7.b..")7\\cr"
	local b8 = "\\cs("..c8.r..","..c8.g..","..c8.b..")8\\cr"
	local b9 = "\\cs("..c9.r..","..c9.g..","..c9.b..")9\\cr"
	local bh = "\\cs("..ch.r..","..ch.g..","..ch.b..")?\\cr"
	local bu = "\\cs("..cu.r..","..cu.g..","..cu.b..")_\\cr"
	local bp = "\\cs("..cp.r..","..cp.g..","..cp.b..")"..pin.."\\cr"
	local bX = "\\cs("..cX.r..","..cX.g..","..cX.b..")X\\cr"

--VanaPad v1.0             x ± 0123456789 ?_•X
--○•

	return truncatedTitle..spaces.." "..bx.." "..be.." "..b0..b1..b2..b3..b4..b5..b6..b7..b8..b9.." "..bh..bu..bp..bX..(content ~= "" and "\n\n" or (entering_note and "\n\n\n\n" or ""))..content
end

-- Create the VanaPad text object
local formattedDisplay = updateBox("none")
local VanaPad = texts.new(formattedDisplay, settings)
VanaPad:show()

--Set initial state of the text box using settings from the options
local function initialize()
	local tc = color.text_header
	VanaPad:color(tc.r,tc.g,tc.b)
	local bgc = color.bg_normal
	VanaPad:bg_color(bgc.r,bgc.g,bgc.b)
	VanaPad:bg_alpha(option.fade_bg_max)
end

-- Delete the current note
local function deleteNote(note)
	if note ~= "none" then
		settings.notes[note] = nil
		settings:save('all')
	end
	if double_click_fix_edit == true then
		disableEditMode()
	end
	VanaPad:text(updateBox(currentNote))
end

-- Enable Edit Mode
function enableEditMode()
	entering_note = true
	double_click_fix_edit = true
	windower.add_to_chat(8,('[VanaPad] '):color(220)..('Edit Mode enabled. Type directly into Vanapad.'):color(8)..(' ESC Key'):color(1)..(' to exit.'):color(8))
	VanaPad:bg_alpha(255)
	local bgc = color.bg_edit
	VanaPad:bg_color(bgc.r,bgc.g,bgc.b)
	VanaPad:text(updateBox(currentNote))
end

-- Disable Edit Mode
function disableEditMode()
	entering_note = false
	double_click_fix_edit = false
	windower.add_to_chat(8,('[VanaPad] '):color(220)..('Edit Mode disabled. Normal keyboard function resumed.'):color(8))
	if note[currentNote] and note[currentNote].content == "" then
		deleteNote(currentNote)
	end
	VanaPad:bg_alpha(option.fade_bg_max)
	local bgc = color.bg_normal
	VanaPad:bg_color(bgc.r,bgc.g,bgc.b)
	VanaPad:text(updateBox(currentNote))
end

-- Keyboard input
local function keyboard_event(dik, down, flags, blocked)

	-- Update shift state
	if dik == 0x2A or dik == 0x36 then  -- 0x2A and 0x36 are Left Shift and Right Shift
		shift_down = down
		return false
	end

	-- If entering note mode, handle input differently
	if entering_note then
		temp_string = note[currentNote] and note[currentNote].content or ""
		if down then
			if dik == 0x01 then  -- Escape key to finish Edit Mode
				disableEditMode()
				return true
			elseif dik == 0x0E then  -- Backspace key to delete last character
				if temp_string:sub(-11) == '{$new_line}' then
					temp_string = temp_string:sub(1, -12)
				else
					temp_string = temp_string:sub(1, -2)
				end
				editNote(temp_string)
				return true
			elseif dik == 0x1C then  -- Enter key to insert a new line
				temp_string = temp_string .. '{$new_line}'
				editNote(temp_string)
				return true
			end

			-- Handle character input based on shift state
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
		return true  -- Block all other inputs while in note-taking mode
	end

	return false  -- Allow all other inputs to reach the game
end

-- Register the keyboard event
windower.register_event('keyboard', keyboard_event)

local function shrinkPad()

	currentNote = "none"
	VanaPad:text(updateBox(currentNote))

end

-- Create a new note
function editNote(content)

	settings.notes[currentNote] = {title = newTitle[currentNote], content = content}
	settings:save('all')
	VanaPad:text(updateBox(currentNote))

end

-- Update a notes title
function updateTitle(title)

	settings.notes[currentNote].title = title
	settings:save('all')
	VanaPad:text(updateBox(currentNote))

end

local function displayHelp()
	windower.add_to_chat(8,('[VanaPad] '):color(220)..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..('Key (Keylesta@Valefor)'):color(220))
	windower.add_to_chat(8,' ')
	windower.add_to_chat(8,('Commands '):color(220)..(' //vanapad, //vp'):color(1)..('[optional]'):color(53)..(' <required>'):color(2))
	windower.add_to_chat(8,('   show/hide '):color(36)..(' - Show/hide the VanaPad window.'):color(8))
	windower.add_to_chat(8,('   edit/e '):color(36)..(' - Edit the current note.'):color(8))
	windower.add_to_chat(8,('   title/t '):color(36)..(' - Add a custom title to the current note.'):color(8))
end

-- Return which button the mouse is hovering over
local function getMouseOnCharacter(mouseX, mouseY)
	local boxPos = settings.pos
	local charWidth = settings.text.size * 0.765  -- Approximate width of a character in pixels for Consolas at given font size
	local textWidth = option.window_width * charWidth  -- Total width for 30 characters
	local hoverPositions = {
		{char = "little_x", offset = 19},
		{char = "edit", offset = 17},
		{char = "zero", offset = 15},
		{char = "one", offset = 14},
		{char = "two", offset = 13},
		{char = "three", offset = 12},
		{char = "four", offset = 11},
		{char = "five", offset = 10},
		{char = "six", offset = 9},
		{char = "seven", offset = 8},
		{char = "eight", offset = 7},
		{char = "nine", offset = 6},
		{char = "help", offset = 4},
		{char = "underscore", offset = 3},
		{char = "pin", offset = 2},
		{char = "big_x", offset = 1},
	}

	-- Hovering over a button
	for _, pos in ipairs(hoverPositions) do
		if mouseX >= boxPos.x + textWidth - (charWidth * pos.offset) and mouseX <= boxPos.x + textWidth - (charWidth * (pos.offset - 1)) and mouseY >= boxPos.y and mouseY <= boxPos.y + (settings.text.size * 2.3) then
			return pos.char
		end
	end

	-- Not over a button, but still hovering over the bar itself
	if mouseX >= boxPos.x and mouseX <= boxPos.x + textWidth and mouseY >= boxPos.y and mouseY <= boxPos.y + (settings.text.size * 2.3) then
		return "bar"
	end

	-- Not hovering over the bar at all
	return "none"
end

-- Event handler for mouse movements
local function onMouseMove(type, mouseX, mouseY)

	--if the box is not visible, no need to bother with checking any mouse hovering
	if not settings.visible then
		return
	end

	--local settings.notes = notes
	local hover = getMouseOnCharacter(mouseX, mouseY)

	if hover ~= "none" then
		if FadeDelay < option.fade_delay then
			FadeDelay = option.fade_delay
		end
		if Fade then
			Fade = false
			VanaPad:bg_alpha(option.fade_bg_max)
			FadeNum = option.fade_bg_max
			c.zero = note.zero and color.btn_note_full or color.btn_note_empty
			c.one = note.one and color.btn_note_full or color.btn_note_empty
			c.two = note.two and color.btn_note_full or color.btn_note_empty
			c.three = note.three and color.btn_note_full or color.btn_note_empty
			c.four = note.four and color.btn_note_full or color.btn_note_empty
			c.five = note.five and color.btn_note_full or color.btn_note_empty
			c.six = note.six and color.btn_note_full or color.btn_note_empty
			c.seven = note.seven and color.btn_note_full or color.btn_note_empty
			c.eight = note.eight and color.btn_note_full or color.btn_note_empty
			c.nine = note.nine and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(currentNote))
		end
	end

	if titleOverride ~= nil and hover == "none" or hover == "bar" then
		titleOverride = nil
		VanaPad:text(updateBox(currentNote))
	end

	if hoveringOver[hover] == false then
		hoveringOver[hover] = true
		c[hover] = color.btn_hover
		if hover == "little_x" then
			titleOverride = note[currentNote] and "Delete" or nil
		elseif hover == "edit" then
			titleOverride = entering_note and "Finish" or (currentNote ~= "none" and "Edit" or nil)
		elseif hover == "help" then
			titleOverride = "Help"
		elseif hover == "underscore" then
			titleOverride = "Shrink"
		elseif hover == "pin" then
			titleOverride = settings.flags.draggable and "Pin" or "Unpin"
		elseif hover == "big_x" then
			titleOverride = "Hide"
		else
			titleOverride = note[hover] and note[hover].title or "Empty"
		end
		VanaPad:text(updateBox(currentNote))
	else
		if hover ~= "little_x" and hoveringOver.little_x == true then
			hoveringOver.little_x = false
			c.little_x = color.text_header
			VanaPad:text(updateBox(currentNote))
		end
		if hover ~= "edit" and hoveringOver.edit == true then
			hoveringOver.edit = false
			c.edit = color.text_header
			VanaPad:text(updateBox(currentNote))
		end
		if hover ~= "zero" and hoveringOver.zero == true then
			hoveringOver.zero = false
			c.zero = note.zero and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(currentNote))
		end
		if hover ~= "one" and hoveringOver.one == true then
			hoveringOver.one = false
			c.one = note.one and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(currentNote))
		end
		if hover ~= "two" and hoveringOver.two == true then
			hoveringOver.two = false
			c.two = note.two and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(currentNote))
		end
		if hover ~= "three" and hoveringOver.three == true then
			hoveringOver.three = false
			c.three = note.three and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(currentNote))
		end
		if hover ~= "four" and hoveringOver.four == true then
			hoveringOver.four = false
			c.four = note.four and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(currentNote))
		end
		if hover ~= "five" and hoveringOver.five == true then
			hoveringOver.five = false
			c.five = note.five and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(currentNote))
		end
		if hover ~= "six" and hoveringOver.six == true then
			hoveringOver.six = false
			c.six = note.six and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(currentNote))
		end
		if hover ~= "seven" and hoveringOver.seven == true then
			hoveringOver.seven = false
			c.seven = note.seven and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(currentNote))
		end
		if hover ~= "eight" and hoveringOver.eight == true then
			hoveringOver.eight = false
			c.eight = note.eight and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(currentNote))
		end
		if hover ~= "nine" and hoveringOver.nine == true then
			hoveringOver.nine = false
			c.nine = note.nine and color.btn_note_full or color.btn_note_empty
			VanaPad:text(updateBox(currentNote))
		end
		if hover ~= "help" and hoveringOver.help == true then
			hoveringOver.help = false
			c.help = color.text_header
			VanaPad:text(updateBox(currentNote))
		end
		if hover ~= "underscore" and hoveringOver.underscore == true then
			hoveringOver.underscore = false
			c.underscore = color.text_header
			VanaPad:text(updateBox(currentNote))
		end
		if hover ~= "pin" and hoveringOver.pin == true then
			hoveringOver.pin = false
			c.pin = color.text_header
			VanaPad:text(updateBox(currentNote))
		end
		if hover ~= "big_x" and hoveringOver.big_x == true then
			hoveringOver.big_x = false
			c.big_x = color.text_header
			VanaPad:text(updateBox(currentNote))
		end
	end

end

-- Event handler for mouse clicks
local function onMouseClick(type, mouseX, mouseY)

	if type == 1 then
		
		local click = getMouseOnCharacter(mouseX, mouseY)
		
		if click == "little_x" then
			deleteNote(currentNote)
		elseif click == "edit" then
			if entering_note then
				windower.send_command('wait .1;vanapad double_click_fix_edit_false')
			else
				windower.send_command('wait .1;vanapad double_click_fix_edit_true')
			end
		elseif click == "help" then
			double_click_fix_help = true
			windower.send_command('wait .1;vanapad double_click_fix_help')
		elseif click == "underscore" then
			if entering_note then
				disableEditMode()
			end
			shrinkPad()
		elseif click == "pin" then
			if double_click_fix_pin then
				windower.send_command('wait .1;vanapad double_click_fix_pin_false')
				settings.flags.draggable = false
				settings:save('all')
				VanaPad:text(updateBox(currentNote))
			else
				windower.send_command('wait .1;vanapad double_click_fix_pin_true')
				settings.flags.draggable = true
				settings:save('all')
				VanaPad:text(updateBox(currentNote))
			end
		elseif click == "big_x" then
			if entering_note then
				disableEditMode()
			end
			VanaPad:hide()
			windower.add_to_chat(8,('[VanaPad] '):color(220)..('Now hidden. Type '):color(8)..('//vanapad show'):color(1)..(' to display again'):color(8))
		elseif click ~= "none" and click ~= "bar" then
			currentNote = click
			VanaPad:text(updateBox(currentNote))
		end
	end

end

-- Register the mouse click event
windower.register_event('mouse', onMouseClick)

-- Register the mouse move event
windower.register_event('mouse', onMouseMove)

-- On login, show the BP box if Visible is true
function login()
	if settings.visible then
		VanaPad:show()
	end
end

-- On logout, hide the BP box since we don't want it displayed on the title/character screen
function logout()
	VanaPad:hide()
end

-- Run the login/logout functions
windower.register_event('login', login)
windower.register_event('logout', logout)

windower.register_event('addon command',function(addcmd, ...)

	if addcmd == "edit" or addcmd == "e" or addcmd == "new" or addcmd == "n" then
		local text = table.concat({...}, " ")
		editNote(text)
	elseif addcmd == "show" then
		VanaPad:show()
	elseif addcmd == "hide" then
		VanaPad:hide()
	elseif addcmd == "title" or addcmd == "t" then
		local text = table.concat({...}, " ")
		updateTitle(text)
	elseif addcmd == nil or addcmd == "help" then
		displayHelp()
	elseif addcmd == "double_click_fix_edit_true" then
		if double_click_fix_edit == false then
			enableEditMode()
		end
	elseif addcmd == "double_click_fix_edit_false" then
		if double_click_fix_edit == true then
			disableEditMode()
		end
	elseif addcmd == "double_click_fix_help" then
		if double_click_fix_help then
			displayHelp()
			double_click_fix_help = false
		end
	elseif addcmd == "double_click_fix_pin_true" then
		double_click_fix_pin = true
	elseif addcmd == "double_click_fix_pin_false" then
		double_click_fix_pin = false
	end
end)

windower.register_event('prerender', function()

	--Fade timer
	if os.time() > Heartbeat then
		Heartbeat = os.time()
		if FadeDelay > 0 then
			FadeDelay = FadeDelay -1
		elseif FadeDelay == 0 then
			if currentNote == "none" then
				Fade = true
			end
			FadeDelay = -1
		end
	end
	
	-- Fade away
	if Fade then
		if FadeNum > option.fade_bg_min then
			FadeNum = FadeNum - option.fade_multiplier
			VanaPad:bg_alpha(FadeNum)
		elseif FadeNum <= option.fade_bg_min then
			FadeNum = option.fade_bg_min
			VanaPad:bg_alpha(FadeNum)
			c.zero = color.text_header
			c.one = color.text_header
			c.two = color.text_header
			c.three = color.text_header
			c.four = color.text_header
			c.five = color.text_header
			c.six = color.text_header
			c.seven = color.text_header
			c.eight = color.text_header
			c.nine = color.text_header
			VanaPad:text(updateBox(currentNote))
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

windower.register_event('load', function()
	initialize()
end)

windower.register_event('unload', function()
	VanaPad:destroy()
end)
