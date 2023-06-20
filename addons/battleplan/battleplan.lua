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
_addon.version = '2.5.1'
_addon.author = 'Key'
_addon.commands = {'battleplan','bp'}

require 'logger'
texts = require('texts')
config = require('config')

tb_name = 'addon:battleplan'

defaults = T{}

defaults.firstLoad = true
defaults.visible = true

defaults.position = T{}
defaults.position.x = 15
defaults.position.y = (windower.get_windower_settings().ui_y_res) / 2 --Sets the default Y position in the middle of your screen

defaults.font = T{}
defaults.font.family = 'Arial'
defaults.font.size   = 10
defaults.font.a      = 255
defaults.font.bold   = true

defaults.colors = T{}
defaults.colors.background = T{}
defaults.colors.background.r = 0
defaults.colors.background.g = 0
defaults.colors.background.b = 0
defaults.colors.background.a = 200
defaults.colors.header = T{}
defaults.colors.header.r = 54
defaults.colors.header.g = 104
defaults.colors.header.b = 255
defaults.colors.text = T{}
defaults.colors.text.r = 240
defaults.colors.text.g = 240
defaults.colors.text.b = 240

settings = config.load(defaults)

local chat = windower.chat.input
local cmd = windower.send_command
local tutorialRun = false
local zoning = false

line = {}
line[1] = ""
line[2] = ""
line[3] = ""
line[4] = ""
line[5] = ""

-- Initial setup
function initialize()

    local background = settings.colors.background
    local textColor = settings.colors.text

    -- Create and setup the BP box
    windower.text.create(tb_name)
    windower.text.set_location(tb_name, settings.position.x, settings.position.y)
    windower.text.set_bg_color(tb_name, background.a, background.r, background.g, background.b)
    windower.text.set_color(tb_name, settings.font.a, textColor.r, textColor.g, textColor.b)
    windower.text.set_font(tb_name, settings.font.family)
    windower.text.set_font_size(tb_name, settings.font.size)
    windower.text.set_bold(tb_name, settings.font.bold)
    windower.text.set_text(tb_name, '')
    windower.text.set_bg_visibility(tb_name, true)
    updateBox()

    -- A quick message on the first time BP is loaded
    if settings.firstLoad then

        windower.add_to_chat(220,'[Battle Plan] '..('First load detected.'):color(8)..'')
        coroutine.sleep(1)
        windower.add_to_chat(220,'[Battle Plan] '..('Type'):color(8)..(' //bp help'):color(1)..(' for help or'):color(8)..(' //bp tutorial'):color(1)..(' to run the tutorial.'):color(8)..'')
        settings.firstLoad = false
        settings:save('all')

    end

end


-- On login, show the BP box if Visible is true
function login()

    if settings.visible then
        showBox()
    end
end


-- On logout, hide the BP box since we don't want it displayed on the title/character screen
function logout()

    hideBox()

end


-- Listen for when zoning
windower.register_event('prerender', function()

    local pos = windower.ffxi.get_position()

    if pos == "(?-?)" and not zoning then

        if settings.visible then
            hideBox()
        end
        zoning = true

    elseif pos ~= "(?-?)" and zoning then

        if settings.visible then
            showBox()
        end
        zoning = false

    end

end)


-- Run the initialize function when first loaded
windower.register_event('load', initialize)

-- Run the login/logout functions
windower.register_event('login', login)
windower.register_event('logout', logout)


--Temporarily display the BP box
function tempDisplay()

    -- If all lines are empty, show the BP box then start a 10 second countdown
    if line[1] == '' and line[2] == '' and line[3] == '' and line[4] == '' and line[5] == '' then

        showBox()

        for i = 10,0,-1
        do

            if i > 0 then
                line[5] = 'Make your adjustments... ['..i..']'
                updateBox()
                coroutine.sleep(1)

            else

                -- Once the countdown hits 0, clear the BP box
                clearBox()
            end

        end

    end

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
        hideBox()
    else
        showBox()
    end

    -- Flip the visibilty setting and save
    settings.visible = not settings.visible
    windower.add_to_chat(220,'[Battle Plan] '..('Visibility updated:'):color(8)..(' %s':format(settings.visible and 'True' or 'False')):color(200))
    settings:save('all')

end


-- Clear the BP box
function clearBox()

    for i = 1, #line, +1
    do
        line[i] = ""
    end
    updateBox()

end


-- Update the BP box
function updateBox()

    local textColor = settings.colors.text
    local headerColor = settings.colors.header

    -- Create a temporary "text" array that we use to build what's displayed in the box
    local text = T{}

    -- The header always goes first, at the top
    text[1] = ' \\cs('..headerColor.r..', '..headerColor.g..', '..headerColor.b..')[ -- Battle Plan -- ]\\cr \n'

    -- Starting at the bottom, check each line for content
    for i = #line, 1, -1
    do

        -- If a line has content (is not empty), then add it and every line above it to the BP box.
        -- This way any trailing empty lines are not displayed, making the BP box more compact if possible
        if line[i] ~= "" then
            for j = i, 1, -1
            do
                text[j+1] = ' \\cs('..textColor.r..', '..textColor.g..', '..textColor.b..')'..line[j]..'\\cr \n'
            end

        -- If a line does not have content (is empty), then do nothing and check the next line upward
        end

    end

    -- Turn the "text" array into a string and update the text inside the box
    windower.text.set_text(tb_name, text:concat(''))

    -- If all lines are empty, hide the BP box
    if line[1] == '' and line[2] == '' and line[3] == '' and line[4] == '' and line[5] == '' then
        hideBox()

        -- Otherwise, if the Visibility setting is on, display the box
    elseif settings.visible then
            windower.text.set_visibility(tb_name, true)

    end

end


-- Extract text for Line 1
function getLine1(input)

    -- Take the entire line and put it into a string
    local inputString = input

    -- Extract the text between "!bp1" and any other party commands
    local extractedText = string.match(inputString, "!bp1%s*(.-)$")
    local extractedText = string.match(extractedText, "^(.-)!bp2") or extractedText
    local extractedText = string.match(extractedText, "^(.-)!bp3") or extractedText
    local extractedText = string.match(extractedText, "^(.-)!bp4") or extractedText
    local extractedText = string.match(extractedText, "^(.-)!bp5") or extractedText

    return extractedText

end


-- Extract text for Line 2
function getLine2(input)

    -- Take the entire line and put it into a string
    local inputString = input

    -- Extract the text between "!bp2" and any other party commands
    local extractedText = string.match(inputString, "!bp2%s*(.-)$")
    local extractedText = string.match(extractedText, "^(.-)!bp1") or extractedText
    local extractedText = string.match(extractedText, "^(.-)!bp3") or extractedText
    local extractedText = string.match(extractedText, "^(.-)!bp4") or extractedText
    local extractedText = string.match(extractedText, "^(.-)!bp5") or extractedText

    return extractedText

end


-- Extract text for Line 3
function getLine3(input)

    -- Take the entire line and put it into a string
    local inputString = input

    -- Extract the text between "!bp3" and any other party commands
    local extractedText = string.match(inputString, "!bp3%s*(.-)$")
    local extractedText = string.match(extractedText, "^(.-)!bp1") or extractedText
    local extractedText = string.match(extractedText, "^(.-)!bp2") or extractedText
    local extractedText = string.match(extractedText, "^(.-)!bp4") or extractedText
    local extractedText = string.match(extractedText, "^(.-)!bp5") or extractedText

    return extractedText

end


-- Extract text for Line 4
function getLine4(input)

    -- Take the entire line and put it into a string
    local inputString = input

    -- Extract the text between "!bp4" and any other party commands
    local extractedText = string.match(inputString, "!bp4%s*(.-)$")
    local extractedText = string.match(extractedText, "^(.-)!bp1") or extractedText
    local extractedText = string.match(extractedText, "^(.-)!bp2") or extractedText
    local extractedText = string.match(extractedText, "^(.-)!bp3") or extractedText
    local extractedText = string.match(extractedText, "^(.-)!bp5") or extractedText

    return extractedText

end


-- Extract text for Line 5
function getLine5(input)

    -- Take the entire line and put it into a string
    local inputString = input

    -- Extract the text between "!bp5" and any other party commands
    local extractedText = string.match(inputString, "!bp5%s*(.-)$")
    local extractedText = string.match(extractedText, "^(.-)!bp1") or extractedText
    local extractedText = string.match(extractedText, "^(.-)!bp2") or extractedText
    local extractedText = string.match(extractedText, "^(.-)!bp3") or extractedText
    local extractedText = string.match(extractedText, "^(.-)!bp4") or extractedText

    return extractedText

end


-- Display help text
function displayHelp()

    local defPos = defaults.position
    local curPos = settings.position
    local defSize = defaults.font.size
    local curSize = settings.font.size
    local defBold = defaults.font.bold
    local curBold = settings.font.bold

    windower.add_to_chat(220,'[Battle Plan] '..('  Battle Plan'):color(220)..(' version '):color(8)..(_addon.version):color(220))
    windower.add_to_chat(220,'[Battle Plan] ')
    windower.add_to_chat(220,'[Battle Plan] '..('Addon Commands'):color(200)..(' (prefixed with'):color(8)..(' //battleplan'):color(1)..(' or'):color(8)..(' //bp'):color(1)..('):'):color(8))
	windower.add_to_chat(220,'[Battle Plan] '..('  show'):color(36)..(' - Shows the BP box if there is content to diplay.'):color(8))
    windower.add_to_chat(220,'[Battle Plan] '..('  hide'):color(36)..(' - Hides the BP box regardless of content to display.'):color(8))
    windower.add_to_chat(220,'[Battle Plan] '..('  visible'):color(36)..(' - Toggle the BP box visibility (alternative to show/hide). [Current:'):color(8)..(' %s':format(settings.visible and 'Show' or 'Hide')):color(200)..(']'):color(8))
    windower.add_to_chat(220,'[Battle Plan] '..('  line#/l#/#'):color(36)..(' - Update YOUR BP box. Other people\'s BP boxes will remain the same.'):color(8))
    windower.add_to_chat(220,'[Battle Plan] '..('                # must be a number 1-5. (Ex.'):color(8)..(' //bp 3 Hello from iLVL of Valefor!'):color(1)..(')'):color(8))
    windower.add_to_chat(220,'[Battle Plan] '..('  clear'):color(36)..(' - Clear YOUR BP box. Other people\'s BP boxes will remain the same.'):color(8))
    windower.add_to_chat(220,'[Battle Plan] '..('  pos/move x y'):color(36)..(' - Update the position of the BP box. [Current: '):color(8)..(curPos.x..' '..curPos.y):color(200)..(', Default: '):color(8)..(defPos.x..' '..defPos.y):color(200)..(']'):color(8))
    windower.add_to_chat(220,'[Battle Plan] '..('  size #'):color(36)..(' - Update the font size of the BP box. [Current:'):color(8)..(' '..curSize):color(200)..(', Default: '):color(8)..(''..defSize):color(200)..(']'):color(8))
    windower.add_to_chat(220,'[Battle Plan] '..('  bold'):color(36)..(' - Update the bold setting. [Current:'):color(8)..(' %s':format(curBold and 'True' or 'False')):color(200)..(', Default: '):color(8)..(' %s':format(defBold and 'True' or 'False')):color(200)..(']'):color(8))
    windower.add_to_chat(220,'[Battle Plan] '..('  tutorial'):color(36)..(' - Run a short tutorial to give you the basics.'):color(8))
    windower.add_to_chat(220,'[Battle Plan] ')
    windower.add_to_chat(220,'[Battle Plan] '..('Party Commands'):color(200)..(' (input directly into chat):'):color(8))
    windower.add_to_chat(220,'[Battle Plan] '..('  !bp#'):color(36)..(' - Update EVERYONE\'S BP box with the text that follows it.'):color(8))
    windower.add_to_chat(220,'[Battle Plan] '..('          # must be a number 1-5. (Ex. '):color(8)..('!bp3 Pickle Surprise!'):color(1)..(')'):color(8))
    windower.add_to_chat(220,'[Battle Plan] '..('  !bpclear'):color(36)..(' - Clear EVERYONE\'S BP box.'):color(8))

end


-- Run the tutorial
function runTutorial()

    -- Typing '//bp stop' will set this to false, ending the tutorial
    tutorialRunning = true

    windower.add_to_chat(220,'[Battle Plan] '..('Cancel this short tutorial at any time by typing'):color(8)..(' //bp stop'):color(1)..(' [...]'):color(8))
    coroutine.sleep(4)

    if tutorialRunning then
        windower.add_to_chat(220,'[Battle Plan] '..('Battle Plan'):color(220)..(' is a collaborative "whiteboard" for you and your party. [...]'):color(8))
        coroutine.sleep(4)
    end

    if tutorialRunning then
        windower.add_to_chat(220,'[Battle Plan] '..('The \'BP box\' is the window you should now see on your screen. [...]'):color(8))
        line[1] = 'Hello!'
        updateBox()
        coroutine.sleep(5)
    end

    if tutorialRunning then
        windower.add_to_chat(220,'[Battle Plan] '..('Up to 5 lines are available to use. The BP box is not visible when all lines are empty. [...]'):color(8))
        coroutine.sleep(4)
    end

    if tutorialRunning then
        windower.add_to_chat(220,'[Battle Plan] '..('It is controlled by special commands detected through the chat log. [...]'):color(8))
        coroutine.sleep(5)
    end

    if tutorialRunning then
        windower.add_to_chat(220,'[Battle Plan] '..('Anyone running Battle Plan that sees these commands will be updated. [...]'):color(8))
        coroutine.sleep(5)
    end

    if tutorialRunning then
        windower.add_to_chat(220,'[Battle Plan] '..('This means that you can keep a group of players all on the same page! [...]'):color(8))
        coroutine.sleep(5)
    end

    if tutorialRunning then
        windower.add_to_chat(220,'[Battle Plan] '..('We\'ll test it here by using /echo so only you see it: [...]'):color(8))
        coroutine.sleep(5)
    end

    if tutorialRunning then
        chat('/echo !bp1 Tonights Omen runs: !bp2 1: Card farm, bring any job you want !bp3 2: Kin !bp4 3: Ou')
        coroutine.sleep(5)
    end

    if tutorialRunning then
        windower.add_to_chat(220,'[Battle Plan] '..('As you can see, you can even update multiple lines at the same time. [...]'):color(8))
        coroutine.sleep(5)
    end

    if tutorialRunning then
        windower.add_to_chat(220,'[Battle Plan] '..('Type'):color(8)..(' //bp hide'):color(1)..(' at any time to hide the BP box. [...]'):color(8))
        hideBox()
        coroutine.sleep(4)
    end

    if tutorialRunning then
        windower.add_to_chat(220,'[Battle Plan] '..('Type'):color(8)..(' //bp show'):color(1)..(' at any time to bring the BP box back. [...]'):color(8))
        showBox()
        coroutine.sleep(4)
    end

    if tutorialRunning then
        windower.add_to_chat(220,'[Battle Plan] '..('Lastly, you can update the size and position of the BP box at any time. [...]'):color(8))
        coroutine.sleep(5)
    end

    if tutorialRunning then
        windower.add_to_chat(220,'[Battle Plan] '..('Try typing'):color(8)..(' //bp size 15'):color(1)..(' and'):color(8)..(' //bp pos 100 300'):color(1)..(' to see what happens. [...]'):color(8))
        coroutine.sleep(2)
        windower.add_to_chat(220,'[Battle Plan] '..('Tutorial finished.'):color(8))
        clearBox()
    end

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

    -- Update Line 3 (but not if it was found from the help command)
    if partycmd:find('!bp3') and not partycmd:find('%[Battle Plan%]') then
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

    -- Clear the BP box (but not if it was found from the help command)
    if partycmd:find('!bpclear') and not partycmd:find('%[Battle Plan%]') then
        clearBox()
    end

end)


-- "Addon Commands" issued through the chat log, denoted by starting with //battleplan or //bp
windower.register_event('addon command',function(addcmd, ...)

    -- Show the BP box
    if addcmd == 'show' then
        settings.visible = true
        settings:save('all')
        showBox()
        windower.add_to_chat(220,'[Battle Plan] '..('Visibility updated:'):color(8)..(' Show'):color(200))
    
    -- Hide the BP box
    elseif addcmd == 'hide' then
        settings.visible = false
        settings:save('all')
        hideBox()
        windower.add_to_chat(220,'[Battle Plan] '..('Visibility updated:'):color(8)..(' Hide'):color(200))

    -- Toggle the visibility of the BP box
    elseif addcmd == 'visible' then
        toggleBox()

    -- Clear YOUR BP box
    elseif addcmd == 'clear' then
        clearBox()
        windower.add_to_chat(220,'[Battle Plan] '..('Clearing YOUR BP box. Other people\'s BP boxes remain the same.'):color(8))

    -- Update YOUR Line 1
    elseif addcmd == 'line1' or addcmd == 'l1' or addcmd == '1' then
        local text = table.concat({...}, " ")
        line[1] = text
        updateBox()

    -- Update YOUR Line 2
    elseif addcmd == 'line2' or addcmd == 'l2' or addcmd == '2' then
        local text = table.concat({...}, " ")
        line[2] = text
        updateBox()

    -- Update YOUR Line 3
    elseif addcmd == 'line3' or addcmd == 'l3' or addcmd == '3' then
        local text = table.concat({...}, " ")
        line[3] = text
        updateBox()

    -- Update YOUR Line 4
    elseif addcmd == 'line4' or addcmd == 'l4' or addcmd == '4' then
        local text = table.concat({...}, " ")
        line[4] = text
        updateBox()

    -- Update YOUR Line 5
    elseif addcmd == 'line5' or addcmd == 'l5' or addcmd == '5' then
        local text = table.concat({...}, " ")
        line[5] = text
        updateBox()

    -- Send the contents of your BP box to others
    elseif addcmd == 'send' then

        -- If all lines are empty, let them know
        if line[1] == '' and line[2] == '' and line[3] == '' and line[4] == '' and line[5] == '' then
            windower.add_to_chat(220,'[Battle Plan] '..('No messages to send, all lines are empty.'):color(8))

        -- Otherwise, do a little loop to print out each line that isn't empty
        else
            for i = 1,5,1
            do
                if line[i] ~= '' then
                    chat('/p !bp'..i..' '..line[i])
                    coroutine.sleep(2)
                end
            end
        end

    -- Update the position
    elseif addcmd == 'pos' or addcmd == 'position' or addcmd == 'move' then

        local pos = {...}
        
        -- If there are not enough parameters then output the current position and remind how to update
        if #pos < 2 then

            windower.add_to_chat(220,'[Battle Plan] '..('Current position:'):color(8)..(' '..settings.position.x..' '..settings.position.y):color(200))
            windower.add_to_chat(220,'[Battle Plan] '..('Update using both X and Y coordinates (ex.'):color(8)..(' //bp pos 100 200'):color(1)..(')'):color(8))

            -- Run tempDisplay to determine if the BP box is currently visible or not
            tempDisplay()
            return

        end
        
        -- Take the provided string parameters and turn them into numbers
        settings.position.x = tonumber(pos[1])
        settings.position.y = tonumber(pos[2])
        
        -- Save the new setting, update the BP box, then alert the user
        settings:save('all')
        windower.text.set_location(tb_name, settings.position.x, settings.position.y)
        windower.add_to_chat(220,'[Battle Plan] '..('Position updated:'):color(8)..(' '..settings.position.x..' '..settings.position.y):color(200))

        -- Run tempDisplay to determine if the BP box is currently visible or not
        tempDisplay()

    -- Update the font size
    elseif addcmd == 'size' or addcmd == 'fontsize' then
        
        local size = {...}
        
        -- If there are no parameters then output the current size and remind how to update
        if #size < 1 then

            windower.add_to_chat(220,'[Battle Plan] '..('Current font size:'):color(8)..(' '..settings.font.size):color(200))
            windower.add_to_chat(220,'[Battle Plan] '..('Update by adding a number (ex.'):color(8)..(' //bp size 12'):color(1)..(')'):color(8))

            -- Run tempDisplay to determine if the BP box is currently visible or not
            tempDisplay()
            return

        end
        
        -- Take the provided string parameter and turn it into a number
        settings.font.size = tonumber(size[1])
        
        -- Save the new setting, update the BP box, then alert the user
        settings:save('all')
        windower.text.set_font_size(tb_name, settings.font.size)
        windower.add_to_chat(220,'[Battle Plan] '..('Font Size updated:'):color(8)..(' '..settings.font.size):color(200))

        -- Run tempDisplay to determine if the BP box is currently visible or not
        tempDisplay()

    -- Update the bold setting
    elseif addcmd == 'bold' then

        local setting = {...}
        
        -- If there are no parameters then output the current bold setting and remind how to update
        if #setting < 1 then

            windower.add_to_chat(220,'[Battle Plan] '..('Current bold setting:'):color(8)..(' %s':format(settings.font.bold and 'True' or 'False')):color(200))
            windower.add_to_chat(220,'[Battle Plan] '..('Update by adding true/on or false/off (ex.'):color(8)..(' //bp bold on'):color(1)..(')'):color(8))

            -- Run tempDisplay to determine if the BP box is currently visible or not
            tempDisplay()
            return

        end
        
        if setting[1] == 'on' or setting[1] == 'true' then
            settings.font.bold = true

        elseif setting[1] == 'off' or setting[1] == 'false' then
            settings.font.bold = false

        -- If there are incorrect parameters then output the current bold setting and remind how to update
        else

            windower.add_to_chat(220,'[Battle Plan] '..('Current bold setting:'):color(8)..(' %s':format(settings.font.bold and 'True' or 'False')):color(200))
            windower.add_to_chat(220,'[Battle Plan] '..('Update by adding true/on or false/off (ex.'):color(8)..(' //bp bold on'):color(1)..(')'):color(8))

            -- Run tempDisplay to determine if the BP box is currently visible or not
            tempDisplay()
            return

        end
        
        -- Save the new setting, update the BP box, then alert the user
        settings:save('all')
        windower.text.set_bold(tb_name, settings.font.bold)
        windower.add_to_chat(220,'[Battle Plan] '..('Bold setting updated:'):color(8)..(' %s':format(settings.font.bold and 'True' or 'False')):color(200))

        -- Run tempDisplay to determine if the BP box is currently visible or not
        tempDisplay()

        -- Run the tutorial
    elseif addcmd == 'tutorial' then
        runTutorial()

    -- Stop the tutorial
    elseif addcmd == 'stop' then
        tutorialRunning = false
        windower.add_to_chat(220,'[Battle Plan] '..('Tutorial stopped.'):color(8))
        clearBox()

    -- Reload Battle Plan
    elseif addcmd == 'reload' then
        cmd('lua r battleplan')

    -- Unload Battle Plan
    elseif addcmd == 'unload' then
        windower.add_to_chat(220,'[Battle Plan] '..('Unloaded. Type'):color(8)..(' //lua l battleplan'):color(1)..(' if you wish to load again.'):color(8))
        cmd('lua u battleplan')
    
    --Display help
    elseif addcmd == 'help' then
        displayHelp()

    -- Unrecognized command
    else
        windower.add_to_chat(220,'[Battle Plan] '..('Unrecognized command. Type'):color(8)..(' //bp help'):color(1)..(' if you need help.'):color(8))

    end

end)
