--[[
Copyright © 2023, Key
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Battle Plan nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

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

_addon.name = 'Battle Plan'
_addon.version = '2.1.1'
_addon.author = 'Key'
_addon.commands = {'battleplan','bp'}

require 'logger'
texts = require('texts')
config = require('config')

tb_name = 'addon:battleplan'

defaults = T{}

defaults.visible = true

defaults.position = T{}
defaults.position.x = 0
defaults.position.y = (windower.get_windower_settings().ui_y_res) / 2 --Makes the default Y position in the middle of your screen

defaults.font = T{}
defaults.font.family = 'Arial'
defaults.font.size   = 10
defaults.font.a      = 255
defaults.font.bold   = false
defaults.font.italic = false

defaults.colors = T{}
defaults.colors.background = T{}
defaults.colors.background.r = 0
defaults.colors.background.g = 43
defaults.colors.background.b = 54
defaults.colors.background.a = 200
defaults.colors.header = T{}
defaults.colors.header.r = 220
defaults.colors.header.g = 50
defaults.colors.header.b = 47
defaults.colors.text = T{}
defaults.colors.text.r = 147
defaults.colors.text.g = 161
defaults.colors.text.b = 161

settings = config.load(defaults)

local chat = windower.chat.input
local cmd = windower.send_command

line = {}
line[1] = ""
line[2] = ""
line[3] = ""
line[4] = ""
line[5] = ""


function initialize()
    local background = settings.colors.background

    windower.text.create(tb_name)
    windower.text.set_location(tb_name, settings.position.x, settings.position.y)
    windower.text.set_bg_color(tb_name, background.a, background.r, background.g, background.b)
    windower.text.set_color(tb_name, settings.font.a, 147, 161, 161)
    windower.text.set_font(tb_name, settings.font.family)
    windower.text.set_font_size(tb_name, settings.font.size)
    windower.text.set_bold(tb_name, settings.font.bold)
    windower.text.set_italic(tb_name, settings.font.italic)
    windower.text.set_text(tb_name, '')
    windower.text.set_bg_visibility(tb_name, true)
    updateBox()
end

windower.register_event('load', initialize)

function updateBox()

    if settings.visible then
        windower.text.set_visibility(tb_name, true)
    end

    local textColor = settings.colors.text
    local headerColor = settings.colors.header

    -- Create a temporary "text" array that we use to build what's displayed in the box
    local text = T{}
    text[1] = ' \\cs('..headerColor.r..', '..headerColor.g..', '..headerColor.b..')--== Battle Plan ==--\\cr \n'

    -- If Line 5 is not empty, we display it and every line above it plus the BP header
    if line[5] ~= "" then
        text[2] = ' \\cs('..textColor.r..', '..textColor.g..', '..textColor.b..')'..line[1]..'\\cr \n'
        text[3] = ' \\cs('..textColor.r..', '..textColor.g..', '..textColor.b..')'..line[2]..'\\cr \n'
        text[4] = ' \\cs('..textColor.r..', '..textColor.g..', '..textColor.b..')'..line[3]..'\\cr \n'
        text[5] = ' \\cs('..textColor.r..', '..textColor.g..', '..textColor.b..')'..line[4]..'\\cr \n'
        text[6] = ' \\cs('..textColor.r..', '..textColor.g..', '..textColor.b..')'..line[5]..'\\cr \n'
    
    -- If Line 5 is empty, but Line 4 is not empty, we display it and every line above it plus the BP header
    elseif line[4] ~= "" then
        text[2] = ' \\cs('..textColor.r..', '..textColor.g..', '..textColor.b..')'..line[1]..'\\cr \n'
        text[3] = ' \\cs('..textColor.r..', '..textColor.g..', '..textColor.b..')'..line[2]..'\\cr \n'
        text[4] = ' \\cs('..textColor.r..', '..textColor.g..', '..textColor.b..')'..line[3]..'\\cr \n'
        text[5] = ' \\cs('..textColor.r..', '..textColor.g..', '..textColor.b..')'..line[4]..'\\cr \n'
    
    -- If Lines 4-5 are empty, but Line 3 is not empty, we display it and every line above it plus the BP header
    elseif line[3] ~= "" then
        text[2] = ' \\cs('..textColor.r..', '..textColor.g..', '..textColor.b..')'..line[1]..'\\cr \n'
        text[3] = ' \\cs('..textColor.r..', '..textColor.g..', '..textColor.b..')'..line[2]..'\\cr \n'
        text[4] = ' \\cs('..textColor.r..', '..textColor.g..', '..textColor.b..')'..line[3]..'\\cr \n'
    
    -- If Lines 3-5 are empty, but Line 2 is not empty, we display it and every line above it plus the BP header
    elseif line[2] ~= "" then
        text[2] = ' \\cs('..textColor.r..', '..textColor.g..', '..textColor.b..')'..line[1]..'\\cr \n'
        text[3] = ' \\cs('..textColor.r..', '..textColor.g..', '..textColor.b..')'..line[2]..'\\cr \n'
    
    -- If Lines 2-5 are empty, but Line 1 is not empty, we display it plus the BP header
    elseif line[1] ~= "" then
        text[2] = ' \\cs('..textColor.r..', '..textColor.g..', '..textColor.b..')'..line[1]..'\\cr \n'
    
    -- If all lines are empty, we hide the whole box
    else
        hideBox()
    end

    -- Now we take our temporary "text" array and turn it into a string and update the text inside the box
    windower.text.set_text(tb_name, text:concat(''))    

end

-- Update Line 1
function getLine1(input)

    -- Take the entire line and put it into a string
    local inputString = input

    -- Remove the text before and including "!bp1"
    local extractedText = string.match(inputString, "!bp1%s*(.-)$")
    
    -- Remove any text after and including "!bp2", if found
    local extractedText = string.match(extractedText, "^(.-)!bp2") or extractedText

    -- Remove any text after and including "!bp3", if found
    local extractedText = string.match(extractedText, "^(.-)!bp3") or extractedText

    -- Remove any text after and including "!bp4", if found
    local extractedText = string.match(extractedText, "^(.-)!bp4") or extractedText

    -- Remove any text after and including "!bp5", if found
    local extractedText = string.match(extractedText, "^(.-)!bp5") or extractedText

    -- Return the text we extracted to what called for it
    return extractedText

end

-- Update Line 2
function getLine2(input)

    -- Take the entire line and put it into a string
    local inputString = input

    -- Remove the text before and including "!bp2"
    local extractedText = string.match(inputString, "!bp2%s*(.-)$")
    
    -- Remove any text after and including "!bp1", if found
    local extractedText = string.match(extractedText, "^(.-)!bp1") or extractedText

    -- Remove any text after and including "!bp3", if found
    local extractedText = string.match(extractedText, "^(.-)!bp3") or extractedText

    -- Remove any text after and including "!bp4", if found
    local extractedText = string.match(extractedText, "^(.-)!bp4") or extractedText

    -- Remove any text after and including "!bp5", if found
    local extractedText = string.match(extractedText, "^(.-)!bp5") or extractedText

    -- Return the text we extracted to what called for it
    return extractedText

end

-- Update Line 3
function getLine3(input)

    -- Take the entire line and put it into a string
    local inputString = input

    -- Remove the text before and including "!bp3"
    local extractedText = string.match(inputString, "!bp3%s*(.-)$")
    
    -- Remove any text after and including "!bp1", if found
    local extractedText = string.match(extractedText, "^(.-)!bp1") or extractedText

    -- Remove any text after and including "!bp2", if found
    local extractedText = string.match(extractedText, "^(.-)!bp2") or extractedText

    -- Remove any text after and including "!bp4", if found
    local extractedText = string.match(extractedText, "^(.-)!bp4") or extractedText

    -- Remove any text after and including "!bp5", if found
    local extractedText = string.match(extractedText, "^(.-)!bp5") or extractedText

    -- Return the text we extracted to what called for it
    return extractedText

end

-- Update Line 4
function getLine4(input)

    -- Take the entire line and put it into a string
    local inputString = input

    -- Remove the text before and including "!bp4"
    local extractedText = string.match(inputString, "!bp4%s*(.-)$")
    
    -- Remove any text after and including "!bp1", if found
    local extractedText = string.match(extractedText, "^(.-)!bp1") or extractedText

    -- Remove any text after and including "!bp2", if found
    local extractedText = string.match(extractedText, "^(.-)!bp2") or extractedText

    -- Remove any text after and including "!bp3", if found
    local extractedText = string.match(extractedText, "^(.-)!bp3") or extractedText

    -- Remove any text after and including "!bp5", if found
    local extractedText = string.match(extractedText, "^(.-)!bp5") or extractedText

    -- Save the refined text to a variable so we can use it later
    line[4] = extractedText

    -- Return the text we extracted to what called for it
    return extractedText

end

-- Update Line 5
function getLine5(input)

    -- Take the entire line and put it into a string
    local inputString = input

    -- Remove the text before and including "!bp5"
    local extractedText = string.match(inputString, "!bp5%s*(.-)$")
    
    -- Remove any text after and including "!bp1", if found
    local extractedText = string.match(extractedText, "^(.-)!bp1") or extractedText

    -- Remove any text after and including "!bp2", if found
    local extractedText = string.match(extractedText, "^(.-)!bp2") or extractedText

    -- Remove any text after and including "!bp3", if found
    local extractedText = string.match(extractedText, "^(.-)!bp3") or extractedText

    -- Remove any text after and including "!bp4", if found
    local extractedText = string.match(extractedText, "^(.-)!bp4") or extractedText

    -- Return the text we extracted to what called for it
    return extractedText

end

-- Show the BP box
function showBox()
    windower.text.set_visibility(tb_name, true)
    updateBox()
end

-- Hide the BP box
function hideBox()
    windower.text.set_visibility(tb_name, false)
end

-- Toggle the visibility of the BP box
function toggleBox()
    if settings.visible then
        settings.visible = false
        settings:save('all')
        hideBox()
        windower.add_to_chat(200,'[Battle Plan] '..('Visibility updated: Hide'):color(8)..'')
    else
        settings.visible = true
        settings:save('all')
        showBox()
        windower.add_to_chat(200,'[Battle Plan] '..('Visibility updated: Show'):color(8)..'')
    end
end


-- Clear the appropriate BP box
function clear(who)
    if who == "mine" then
        line[1] = ""
        line[2] = ""
        line[3] = ""
        line[4] = ""
        line[5] = ""
        updateBox()
        windower.add_to_chat(200,'[Battle Plan] '..('Clearing YOUR BP box. Other people\'s BP boxes remain the same.'):color(8)..'')
    elseif who == "everyone" then
        chat('/p !bpclear')
        windower.add_to_chat(200,'[Battle Plan] '..('Clearing EVERYONE\'S BP box.'):color(8)..'')
    end
end

function displayHelp()
    windower.add_to_chat(200,'[Battle Plan] '..('A collaborative "whiteboard" to keep you and your party members on the same page.'):color(8)..'')
    windower.add_to_chat(200,'[Battle Plan] '..('Up to 5 lines are available to use. BP box is not visible when all lines are empty.'):color(8)..'')
    windower.add_to_chat(200,'[Battle Plan] '..('Commands:'):color(8)..'')
	windower.add_to_chat(200,'[Battle Plan] '..(' show - Show the BP box.'):color(8)..'')
    windower.add_to_chat(200,'[Battle Plan] '..(' hide - Hide the BP box.'):color(8)..'')
    windower.add_to_chat(200,'[Battle Plan] '..(' visible - Toggle the BP box visibility (alternative to show/hide). [Current: %s':format(settings.visible and 'Show]' or 'Hide]')):color(8)..'')
    windower.add_to_chat(200,'[Battle Plan] '..(' clear - Clear EVERYONE\'S BP box.'):color(8)..'')
    windower.add_to_chat(200,'[Battle Plan] '..(' clearmine - Clear YOUR BP box. Other people\'s BP boxes remain the same.'):color(8)..'')
    windower.add_to_chat(200,'[Battle Plan] '..(' line#/l#/# - Create party text to update the BP box for all members running BP.'):color(8)..'')
    windower.add_to_chat(200,'[Battle Plan] '..('               # must be a number 1-5. (Ex. //bp 3 Hello from iLVL of Valefor!)'):color(8)..'')
    windower.add_to_chat(200,'[Battle Plan] '..(' pos/move x y - Update the position of the BP box. [Current: '..settings.position.x..' '..settings.position.y..', Default: '..defaults.position.x..' '..defaults.position.y..']'):color(8)..'')
    windower.add_to_chat(200,'[Battle Plan] '..(' size # - Update the font size of the BP box. [Current: '..settings.font.size..', Default: '..defaults.font.size..']'):color(8)..'')
end

-- "Party Commands" issued through party chat, denoted by starting with !bp
windower.register_event('incoming text',function(partycmd, ...)

    -- Update Line 1
    if partycmd:find('!bp1') then
        line[1] = getLine1(...)
        updateBox()
    end

    -- Update Line 2
    if partycmd:find('!bp2') then
        line[2] = getLine2(...)
        updateBox()
    end

    -- Update Line 3
    if partycmd:find('!bp3') then
        line[3] = getLine3(...)
        updateBox()
    end

    -- Update Line 4
    if partycmd:find('!bp4') then
        line[4] = getLine4(...)
        updateBox()
    end

    -- Update Line 5
    if partycmd:find('!bp5') then
        line[5] = getLine5(...)
        updateBox()
    end

    if partycmd:find('!bpclear') then
        clear('mine')
    end

end)

-- "Addon Commands" issued through the chat log, denoted by starting with //battleplan or //bp
windower.register_event('addon command',function(addcmd, ...)

    -- Show the BP box
    if addcmd == 'show' then
        settings.visible = true
        settings:save('all')
        showBox()
        windower.add_to_chat(200,'[Battle Plan] '..('Visibility updated: Show'):color(8)..'')
    
    -- Hide the BP box
    elseif addcmd == 'hide' then
        settings.visible = false
        settings:save('all')
        hideBox()
        windower.add_to_chat(200,'[Battle Plan] '..('Visibility updated: Hide'):color(8)..'')

    -- Toggle the visibility of the BP box
    elseif addcmd == 'visible' then
        toggleBox()

    -- Clear EVERYONE'S BP box (or only yours if you add 'mine' after)
    elseif addcmd == 'clear' then
        if ... == "mine" then
            clear('mine')
        else
            clear('everyone')
        end

    -- Clear YOUR BP box
    elseif addcmd == 'clearmine' then
        clear('mine')

    -- Update Line 1
    elseif addcmd == 'line1' or addcmd == 'l1' or addcmd == '1' then
        local line = table.concat({...}, " ")
        chat('!bp1 ' ..line)

    -- Update Line 2
    elseif addcmd == 'line2' or addcmd == 'l2' or addcmd == '2' then
        local line = table.concat({...}, " ")
        chat('!bp2 ' ..line)

    -- Update Line 3
    elseif addcmd == 'line3' or addcmd == 'l3' or addcmd == '3' then
        local line = table.concat({...}, " ")
        chat('!bp3 ' ..line)

    -- Update Line 4
    elseif addcmd == 'line4' or addcmd == 'l4' or addcmd == '4' then
        local line = table.concat({...}, " ")
        chat('!bp4 ' ..line)

    -- Update Line 5
    elseif addcmd == 'line5' or addcmd == 'l5' or addcmd == '5' then
        local line = table.concat({...}, " ")
        chat('!bp5 ' ..line)

    elseif addcmd == 'pos' or addcmd == 'position' or addcmd == 'move' then
        local pos = {...}
        if #pos < 2 then
            windower.add_to_chat(200,'[Battle Plan] '..('Error: Need both X and Y coordinates (ex. //bp pos 100 200). Current position: '..settings.position.x..' '..settings.position.y):color(8)..'')
            return
        end
        settings.position.x = tonumber(pos[1])
        settings.position.y = tonumber(pos[2])
        settings:save('all')
        windower.text.set_location(tb_name, settings.position.x, settings.position.y)
        windower.add_to_chat(200,'[Battle Plan] '..('Position updated: '..settings.position.x..' '..settings.position.y):color(8)..'')

    elseif addcmd == 'size' or addcmd == 'fontsize' then
        local size = {...}
        settings.font.size = tonumber(size[1])
        settings:save('all')
        windower.text.set_font_size(tb_name, settings.font.size)
        windower.add_to_chat(200,'[Battle Plan] '..('Font Size updated: '..settings.font.size):color(8)..'')

    -- Reload Battle Plan
    elseif addcmd == 'reload' then
        cmd('lua r battleplan')

    -- Unload Battle Plan
    elseif addcmd == 'unload' then
        windower.add_to_chat(200,'[Battle Plan] '..('Unloaded. Type \'//lua l battleplan\' if you wish to load again.'):color(8)..'')
        cmd('lua u battleplan')
    
    elseif addcmd == 'help' then
        displayHelp()

    else
        windower.add_to_chat(200,'[Battle Plan] '..('Unrecognized command. Type \'//bp help\' if you need help.'):color(8)..'')

    end
end)
