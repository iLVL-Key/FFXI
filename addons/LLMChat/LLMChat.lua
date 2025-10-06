--Copyright (c) 2025, Key
--All rights reserved.

--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:

--    * Redistributions of source code must retain the above copyright
--      notice, this list of conditions and the following disclaimer.
--    * Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in the
--      documentation and/or other materials provided with the distribution.
--    * Neither the name of LLMChat nor the
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

_addon.name = 'LLMChat'
_addon.version = '1.0 BETA-2'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'llmchat','llm'}

http = require("socket.http")
ltn12 = require("ltn12")
config = require('config')
files = require('files')
require 'chat'

add_to_chat = windower.add_to_chat

--Defaults values loaded on first run. Do not edit these here, edit them in the data/settings.xml file
defaults = {
	lm_studio_url = "http://127.0.0.1:1234",
	model_name = "qwen/qwen3-4b-2507",
	universal_instructions = "Keep your response to one sentence. Do not use emojis.",
}
settings = config.load(defaults)

default_personalities = {
	["Altana"] = "You are Altana, the goddess of dawn and creation from Final Fantasy XI. You are gentle, radiant, and nurturing. Speak with kindness and warmth, offering comfort even in darkness. Tone should always feel maternal, inspiring, and protective.",
    ["Promathia"]="You are Promathia, the god of twilight and chains from Final Fantasy XI. You are cold, distant, and fatalistic. Speak solemnly, as if every word is inevitable truth. Tone should be grim, heavy, and detached - never warm or humorous.",
    ["Odin"]="You are Odin, the dark rider and sovereign of the Einherjar from Final Fantasy XI. You are proud, commanding, and merciless in tone. You speak as a warlord addressing warriors on the battlefield. Tone should be stern, clipped, and commanding - never playful.",
    ["Moogle"]="You are a Moogle from Final Fantasy XI. You are cheerful, whimsical, and helpful, speaking with warmth and playful charm. Reply must include at least one clear instance of alliteration (two or more consecutive words beginning with the same sound). Favor soft, whimsical alliteration like 'marvelous magical mischief' or 'brave bold battlers,' not forced or awkward phrases. Tone should be upbeat, kind, and friendly, with a little sparkle of silliness. End with ', kupo!' unless the refusal or context makes it awkward.",
    ["Brygid"]="You are Brygid the Stylist from Final Fantasy XI. You are dramatic, flamboyant, and obsessed with fashion. You judge everything through the lens of style, flair, and appearance. Tone should be judgmental, over-the-top, and dramatic - as if delivering a fashion critique on a grand stage.",
    ["Boombox"]="You are Boombox, a goblin from Final Fantasy XI. You are excitable, eccentric, and obsessed with machines and explosives. You love onomatopoeia like 'BOOM,' 'CLANG,' and 'KA-POW.' Reply should include a sound effect (BOOM, BANG, CLANG, etc.) only if applicable. Use goblin-style elliptical speech: drop helping verbs and small words when possible (e.g., 'What you want' instead of 'What do you want?'). Tone should be manic, playful, and full of noisy energy - like a goblin hyped on his own inventions.",
}

--Location of the mob abbreviations file
personalities_file = files.new('data\\personalities.lua')

personalities_help_msg = "--This file is used to store the personality data used with your LLM.\\n--To create a new peresonality, simply create a new entry here and fill in the neccessary prompt that will tell your LLM how to reply to each query it receives.\\n--For universal instructions applied to all personalities/queries, please see the data/settings.xml file.\n\n"

personalities = {}

--If the data\personalities.lua file doesn't exist, create it
if not personalities_file:exists() then

	local function sortedTableString(tbl, indent)
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

	personalities = default_personalities

	personalities_file:write(personalities_help_msg..'return {\n'..sortedTableString(personalities, '    ')..'\n}')

else
	--File already exists, load it
	personalities = require('data.personalities')
end

flood_delay = false
chat_buffer = {} --Temporarily stores multi-line query responses before being sent to party chat
release_valve_open = true --If true will send new messages straight to the ls channel, otherwise sends them to the chat_buffer

-- Check the chat_buffer for messages to send
function checkChatBuffer()

	-- If the chat_buffer has messages in it, send them to chat then remove them, then check again after a short wait
	if #chat_buffer > 0 then
		local message = chat_buffer[1]
		windower.chat.input(message)
		table.remove(chat_buffer, 1)
		coroutine.sleep(1.5)
		checkChatBuffer()

	-- If there are no more messages in the chat_buffer, open the releaseValve back up for new messages
	else
		release_valve_open = true
	end
end

-- Handle a new chat message
function newChatMessage(str)

	-- If the releaseValve is open, send the new chat message straight to chat and close the valve
	if release_valve_open then
		windower.chat.input(str)
		release_valve_open = false
		coroutine.sleep(1.5)
		checkChatBuffer()

	-- If the releaseValve is closed, add the new chat message to the chat_buffer
	else
		table.insert(chat_buffer, str)
	end
end

-- Send messages from LM Studio to the Chat Buffer
function sendMessagesToChatBuffer(message_table)
	for _, message in ipairs(message_table) do
		newChatMessage(message)
	end
end

--Get personality data from data/personalities.lua
function getPersonality(message)
    local msg_lower = message:lower()
    for name, description in pairs(personalities) do
        if msg_lower:match("^" .. name:lower()) then
            return name, description
        end
    end
    return nil, nil
end

-- Parse response by pattern matching instead of JSON decode
function parseJsonResponse(json_string)
	-- Look for "content": "...."
	local content = json_string:match([["content"%s*:%s*"([^"]+)]])
	if content then
		-- Unescape any escaped quotes (\" → ")
		content = content:gsub("\\\"", "\"")
		return content
	end
	return "No text found in response"
end

-- Send prompt to LM Studio
function sendToLMStudio(query, personality_desc)

	query = personality_desc.." "..query.." "..settings.universal_instructions

	-- Build JSON body
	local request_body = [[{
		"model": "]] .. settings.model_name .. [[",
		"messages": [
			{"role": "user", "content": "]] .. query:gsub('"', '\\"') .. [["}
		],
		"max_tokens": 200,
		"temperature": 0.7
	}]]

	local response_table = {}

	local headers = {
		["Content-Type"] = "application/json",
		["Content-Length"] = tostring(#request_body)
	}

	-- POST to the chat endpoint
	local response, status_code, response_headers = http.request{
		url = settings.lm_studio_url .. "/v1/chat/completions",
		method = "POST",
		headers = headers,
		source = ltn12.source.string(request_body),
		sink = ltn12.sink.table(response_table)
	}

	if status_code == 200 then
		local response_string = table.concat(response_table)
		response_string = parseJsonResponse(response_string)
		response_string = response_string:gsub('\\n', ' '):gsub('—', ' - '):gsub('’', '\''):gsub("[\128-\255]", "")
		return response_string
	else
		return "Error: HTTP " .. tostring(status_code)
	end

end

-- Handle query
function handleQuery(query, send_to, personality_name, personality_desc)

	--Set the flood delay
	flood_delay = true

	add_to_chat(8,('[LLMChat] ':color(220))..('Generating response from '..personality_name..'...'):color(8))

	-- Split the message into parts
	local function splitMessage(send_to, message, personality_name)
		local result = {}
		local prefix = "/" .. send_to .. " [" .. personality_name .. "] "
		local max_length = 120
		local message_length = max_length - #prefix
		local start_index = 1

		-- Loop to split the message
		while start_index <= #message do
			-- Calculate the end index for the substring
			local end_index = start_index + message_length - 1

			-- If the remaining part of the message is too long, truncate
			if end_index < #message then
				-- Find the split point at 119 chars, then append a hyphen
				table.insert(result, prefix .. message:sub(start_index, end_index) .. "-")
			else
				-- If the rest fits in one entry, just append it
				table.insert(result, prefix .. message:sub(start_index))
			end

			-- Update the start index for the next loop
			start_index = end_index + 1
		end

		return result
	end

	-- Send to LM Studio
	local response = sendToLMStudio(query, personality_desc)

	-- Display the response
	if response and not response:match("^Error:") then
		sendMessagesToChatBuffer(splitMessage(send_to, response, personality_name))

		-- Release flood delay
		flood_delay = false
	else
		add_to_chat(8,('[LLMChat] ':color(220))..('Error communicating with LM Studio'):color(28))
	end

end

--Incoming chat message - NOTE: these are checking incoming packets, messages originating from yourself will not trigger them
--(tells work though because they go out to the server first then back to you as the receiver)
windower.register_event('chat message', function(message, sender, chat_mode)

	--Ignore if another query while already working on one
	if flood_delay then
		return
	end

	local personality_name, personality_desc = getPersonality(message)
	local chat_map = {
		-- [3] = "t " .. sender,	--tell
		[4] = "p",				--party
		[5] = "l",				--linkshell 1
		[27] = "l2"				--linkshell 2
	}

	if personality_name and personality_desc and chat_map[chat_mode] then
		local send_to = chat_map[chat_mode]
		handleQuery(message, send_to, personality_name, personality_desc)
	end

end)

windower.register_event('outgoing text', function(original)

    -- Ignore if already processing a query
    if flood_delay then
        return
    end

    -- Map chat commands to channel codes
    local chat_map = {
        ["echo"]        = "echo",
        ["party"]       = "p",
        ["p"]           = "p",
        ["linkshell"]   = "l",
        ["l"]           = "l",
        ["linkshell2"]  = "l2",
        ["l2"]          = "l2",
    }

    -- Detect prefix like "/p ", "/party ", "/l2 ", etc.
    local chat_prefix, remainder = original:match("^/(%S+)%s+(.*)")
    local send_to

    if chat_prefix and chat_map[chat_prefix:lower()] then
        send_to = chat_map[chat_prefix:lower()]
        original = remainder -- Remove the prefix for processing
    end

    -- Detect if it starts with a known personality name
    local personality_name, personality_desc = getPersonality(original)

    -- Only handle if both personality and send_to exist
    if personality_name and personality_desc and send_to then
		coroutine.sleep(1.5) -- Delay to avoid chat error if reply comes back too fast.
        handleQuery(original, send_to, personality_name, personality_desc)
    end
end)

-- Handle addon commands
windower.register_event('addon command', function(addon_command, ...)

	local args = {...}

	local chat_map = {
		["echo"]		= "echo",
		["e"]			= "echo",
		["party"]		= "p",
		["p"]			= "p",
		["linkshell"]	= "l",
		["linkshell1"]	= "l",
		["link"]		= "l",
		["link1"]		= "l",
		["ls"]			= "l",
		["ls1"]			= "l",
		["l"]			= "l",
		["l1"]			= "l",
		["linkshell2"]	= "l2",
		["link2"]		= "l2",
		["ls2"]			= "l2",
		["l2"]			= "l2",
	}

	-- Show help info
	local function showHelp()
		local prefix = "//llmchat, //llm"
		add_to_chat(8,('[LLMChat] ':color(220))..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220)..(' ('):color(8)..(prefix):color(1)..(')'):color(8))
		add_to_chat(8,(' Command '):color(36)..'<required>':color(2)..(' - Description'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,(' list '):color(36)..('- List all Personalities that are loaded.'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,(' Query Commands '):color(220))
		add_to_chat(8,(' <Personality Name> <Query> '):color(2)..('is required after every Querry Command.'):color(8))
		add_to_chat(8,(' echo/e '):color(36)..('- Send the reply to echo.'):color(8))
		add_to_chat(8,(' party/p '):color(36)..('- Send the reply to party.'):color(8))
		add_to_chat(8,(' linkshell/link/ls/l '):color(36)..('- Send the reply to linkshell 1.'):color(8))
		add_to_chat(8,(' linkshell2/link2/ls2/l2 '):color(36)..('- Send the reply to linkshell 2.'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,' Example: '..('//llm '):color(1)..('ls '):color(36)..('altana introduce yourself to the linkshell'):color(2))
	end

	-- List all personalities loaded
	local function listPersonalities()
		local names = {}
		-- Pull names and add them to a table
		for name, _ in pairs(personalities) do
			table.insert(names, name)
		end
		-- Sort those names alphabetically
		table.sort(names, function(a, b)
			return a:lower() < b:lower()
		end)
		-- Print to chat log
		add_to_chat(8,('[LLMChat] ':color(220))..('Available Personalities:'):color(8))
		for _, name in ipairs(names) do
			windower.add_to_chat(36, (" - "):color(8)..name)
		end
	end

	if chat_map[addon_command] then
		if next(args) ~= nil then
			local query = table.concat(args, ' ')
			local personality_name, personality_desc = getPersonality(query)
			handleQuery(query, chat_map[addon_command], personality_name, personality_desc)
		else
			showHelp()
		end
	elseif addon_command == "list" then
		listPersonalities()
	else
		showHelp()
	end
end)
