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
_addon.version = '1.0.0'
_addon.author = 'Key'
_addon.commands = {'battleplan','bp'}

require 'logger'
config = require('config')

tb_name = 'addon:battleplan'

defaults = T{}
defaults.light     = false
defaults.timer     = false

defaults.position = T{}
defaults.position.x = 0
defaults.position.y = 350

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
defaults.colors.title = T{}
defaults.colors.title.r = 220
defaults.colors.title.g = 50
defaults.colors.title.b = 47
defaults.colors.value = T{}
defaults.colors.value.r = 147
defaults.colors.value.g = 161
defaults.colors.value.b = 161

settings = config.load(defaults)

line1 = ""
line2 = ""
line3 = ""

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
    local text = T{
        ' \\cs('..settings.colors.title.r..', '..settings.colors.title.g..', '..settings.colors.title.b..')--== Battle Plan ==--\\cr \n',
        ' \\cs('..settings.colors.value.r..', '..settings.colors.value.g..', '..settings.colors.value.b..')'..line1..'\\cr \n',
        ' \\cs('..settings.colors.value.r..', '..settings.colors.value.g..', '..settings.colors.value.b..')'..line2..'\\cr \n',
        ' \\cs('..settings.colors.value.r..', '..settings.colors.value.g..', '..settings.colors.value.b..')'..line3..'\\cr \n',
    }
    windower.text.set_text(tb_name, text:concat(''))
end

function getLine1(input)
    -- Take the entire line and put it into a string
    local inputString = input

    -- Extract the text after "!bp1" but before "!bp2" or "!bp3" (if they exist)
    local extractedText = string.match(inputString, "!bp1%s*(.-)%s*!bp2") or string.match(inputString, "!bp1%s*(.-)%s*!bp3") or string.match(inputString, "!bp1%s*(.-)$")
    
    -- Refine the text to catch any leftovers
    local refinedText = string.match(extractedText, "^(.-)!bp3") or extractedText

    -- Save the refined text to a variable so we can use it later
    line1 = refinedText

    -- Now that we have our desired text extracted we update the on-screen box with it
    updateBox()
end

function getLine2(input)
    -- Take the entire line and put it into a string
    local inputString = input

    -- Extract the text after "!bp2" but before "!bp1" or "!bp3" (if they exist)
    local extractedText = string.match(inputString, "!bp2%s*(.-)%s*!bp1") or string.match(inputString, "!bp2%s*(.-)%s*!bp3") or string.match(inputString, "!bp2%s*(.-)$")
    
    -- Refine the text to catch any leftovers
    local refinedText = string.match(extractedText, "^(.-)!bp3") or extractedText

    -- Save the refined text to a variable so we can use it later
    line2 = refinedText

    -- Now that we have our desired text extracted we update the on-screen box with it
    updateBox()
end

function getLine3(input)
    -- Take the entire line and put it into a string
    local inputString = input

    -- Extract the text after "!bp3" but before "!bp1" or "!bp2" (if they exist)
    local extractedText = string.match(inputString, "!bp3%s*(.-)%s*!bp1") or string.match(inputString, "!bp3%s*(.-)%s*!bp2") or string.match(inputString, "!bp3%s*(.-)$")
    
    -- Refine the text to catch any leftovers
    local refinedText = string.match(extractedText, "^(.-)!bp2") or extractedText

    -- Save the refined text to a variable so we can use it later
    line3 = refinedText

    -- Now that we have our desired text extracted we update the on-screen box with it
    updateBox()
end

windower.register_event('incoming text',function(command, ...)

    -- Look for the signals for Battle Plan to do its thing
    if command:find('!bp1') then
        getLine1(...)
    end

    if command:find('!bp2') then
        getLine2(...)
    end

    if command:find('!bp3') then
        getLine3(...)
    end

end)
