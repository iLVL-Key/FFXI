--Copyright (c) 2025, Key
--All rights reserved.

--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:

--    * Redistributions of source code must retain the above copyright
--      notice, this list of conditions and the following disclaimer.
--    * Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in the
--      documentation and/or other materials provided with the distribution.
--    * Neither the name of Vanity nor the
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

_addon.name = 'Vanity'
_addon.version = '2.0'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'vanity','van'}

config = require('config')
res = require('resources')
require 'chat'

local add_to_chat = windower.add_to_chat

defaults = {}

defaults.options = {
	after_disable_delay = 9,
	after_job_change_delay = 6,
	after_zone_delay = 5,
}

defaults.lockstyles = {
	blm = "{combat:0},{town:0}",
	blu = "{combat:0},{town:0}",
	brd = "{combat:0},{town:0}",
	bst = "{combat:0},{town:0}",
	cor = "{combat:0},{town:0}",
	dnc = "{combat:0},{town:0}",
	drg = "{combat:0},{town:0}",
	drk = "{combat:0},{town:0}",
	geo = "{combat:0},{town:0}",
	mnk = "{combat:0},{town:0}",
	nin = "{combat:0},{town:0}",
	pld = "{combat:0},{town:0}",
	pup = "{combat:0},{town:0}",
	rdm = "{combat:0},{town:0}",
	rng = "{combat:0},{town:0}",
	run = "{combat:0},{town:0}",
	sam = "{combat:0},{town:0}",
	sch = "{combat:0},{town:0}",
	smn = "{combat:0},{town:0}",
	thf = "{combat:0},{town:0}",
	war = "{combat:0},{town:0}",
	whm = "{combat:0},{town:0}",
}

defaults.town_zones = S{
	'Western Adoulin','Eastern Adoulin','Celennia Memorial Library','Silver Knife','Bastok Markets','Bastok Mines','Metalworks','Port Bastok','Chateau d\'Oraguille','Northern San d\'Oria','Port San d\'Oria','Southern San d\'Oria','Heavens Tower','Port Windurst','Windurst Walls','Windurst Waters','Windurst Woods','Lower Jeuno','Port Jeuno','Ru\'Lude Gardens','Upper Jeuno','Aht Urhgan Whitegate','The Colosseum','Tavnazian Safehold','Southern San d\'Oria [S]','Bastok Markets [S]','Windurst Waters [S]','Mhaura','Selbina','Rabao','Kazham','Norg','Nashmau','Mog Garden','Leafallia','Chocobo Circuit'
    }

settings = config.load(defaults)

local town_zones = settings.town_zones
local lockstyles = settings.lockstyles
local after_job_change_delay = settings.options.after_job_change_delay
local after_zone_delay = settings.options.after_zone_delay
local after_disable_delay = settings.options.after_disable_delay

local Heartbeat = 0
local lockstyle_delay = -1

--Turn the entire string into all uppercase
function uppercase(str)

	local uppercased = string.gsub(str, "%a", function(letter)
		return letter:upper()
	end)

	return uppercased

end

-- Are we located in a town zone?
local function townZone()

	local zone_name = res.zones[windower.ffxi.get_info().zone].name

	return settings.town_zones:contains(zone_name)

end

-- Run the lockstyle game command for the job/location combination
local function setLockstyle()

	if not windower.ffxi.get_info().logged_in then return end

	local job = string.lower(windower.ffxi.get_player().main_job)
	local location = townZone() and "town" or "combat"
	local lockstyle_str = lockstyles[job] or "{combat:0}{town:0}"

	--Extract lockstyle numbers for the relevant location
	local lockstyle_numbers = lockstyle_str:match("{"..location..":([^}]*)}") or "0"

	--If "0" is present (disabled), do nothing
	if lockstyle_numbers == "0" then return end

	--Convert to a table of numbers
	local lockstyle_table = {}
	for num in lockstyle_numbers:gmatch("%d+") do
		table.insert(lockstyle_table, tonumber(num))
	end

	--Select a random lockstyle from the table
	if #lockstyle_table > 0 then
		local selected_lockstyle = lockstyle_table[math.random(#lockstyle_table)]
		windower.send_command('input /lockstyleset '..selected_lockstyle)
	end
end

--List all lockstyles
local function listAllLockstyles()

	add_to_chat(8,('[Vanity] '):color(220)..('Lockstyles:'):color(8))

	--Collect jobs in a table and sort them alphabetically
	local jobs = {}
	for job in pairs(settings.lockstyles) do
		table.insert(jobs, job)
	end
	table.sort(jobs)

	--Iterate over the sorted jobs
	for _, job in ipairs(jobs) do
		local lockstyle_str = settings.lockstyles[job]

		--Extract combat and town lockstyle numbers using pattern matching
		local combat_str = lockstyle_str:match("{combat:([^}]*)}") or "0"
		local town_str = lockstyle_str:match("{town:([^}]*)}") or "0"

		local combatLockstyles = combat_str == "0" and "x" or combat_str
		local townLockstyles = town_str == "0" and "x" or town_str

		add_to_chat(8,(uppercase(job)..' - Combat: '):color(8)..(combatLockstyles):color(combatLockstyles == 'x' and 39 or 1)..('  Town: '):color(8)..(townLockstyles):color(townLockstyles == 'x' and 39 or 1))
	end
end

local function displayLockstyles(job, location)

	--Retrieve the current lockstyle string
	local current_str = settings.lockstyles[job] or "{combat:0}{town:0}"

	--Extract the relevant lockstyle numbers using pattern matching
	local lockstyle_str = current_str:match("{"..location..":([^}]*)}") or "0"

	local list = lockstyle_str == "0" and "x" or lockstyle_str
	local loc = location == "combat" and " Combat" or " Town"

	add_to_chat(8,('[Vanity] '):color(220)..(uppercase(job)..loc):color(1)..((' %s: '):format(#list == 1 and 'lockstyle' or 'lockstyles')):color(8)..(list):color(list == 'x' and 39 or 1)..(list == 'x' and ' (Disabled)' or ''):color(8)..(#list > 1 and ' (Chosen at random)' or ''):color(8))

end

--Add a specified lockstyle number
local function addLockstyle(job, location, lockstyle_num)

	--Retrieve the current lockstyle string
	local current_str = settings.lockstyles[job] or "{combat:0}{town:0}"

	--Extract combat and town lockstyle groups using pattern matching
	local combat_str = current_str:match("{combat:([^}]*)}") or "0"
	local town_str = current_str:match("{town:([^}]*)}") or "0"

	--If the lockstyle_num is 0, disable the lockstyle by setting it to "0" and removing all others
	local new_combat_str = location == "combat" and "0" or combat_str
	local new_town_str = location == "town" and "0" or town_str

	--Otherwise, add the number normally
	if lockstyle_num ~= 0 then
		local lockstyles = {}
		for num in (location == "combat" and combat_str or town_str):gmatch("%d+") do
			lockstyles[tonumber(num)] = true
		end

		--Add the new lockstyle number and remove 0 if present
		lockstyles[tonumber(lockstyle_num)] = true
		lockstyles[0] = nil

		--Convert back to a sorted comma-separated string
		local new_lockstyle_str = table.concat(
			(function()
				local sorted = {}
				for num in pairs(lockstyles) do table.insert(sorted, num) end
				table.sort(sorted)
				return sorted
			end)(),
			","
		)

		--Update only the relevant location
		if location == "combat" then
			new_combat_str = new_lockstyle_str
		else
			new_town_str = new_lockstyle_str
		end
	end

	--Construct the new lockstyle string
	local new_str = string.format(
		"{combat:%s}{town:%s}",
		new_combat_str,
		new_town_str
	)

	--Save the updated string
	settings.lockstyles[job] = new_str
	settings:save()

	displayLockstyles(job, location)

end

--Remove a specified lockstyle number
local function removeLockstyle(job, location, lockstyle_num)

	--Retrieve the current lockstyle string
	local current_str = settings.lockstyles[job] or "{combat:0}{town:0}"

	--Extract combat and town lockstyle groups using pattern matching
	local combat_str = current_str:match("{combat:([^}]*)}") or "0"
	local town_str = current_str:match("{town:([^}]*)}") or "0"

	--Convert the relevant part into a table
	local lockstyles = {}
	for num in (location == "combat" and combat_str or town_str):gmatch("%d+") do
		lockstyles[tonumber(num)] = true
	end

	--Remove the specified lockstyle number
	lockstyles[tonumber(lockstyle_num)] = nil

	--If the table is now empty, set it to "0" (disabled)
	local new_lockstyle_str
	if next(lockstyles) == nil then
		new_lockstyle_str = "0"
	else
		--Convert back to a sorted comma-separated string
		new_lockstyle_str = table.concat(
			(function()
				local sorted = {}
				for num in pairs(lockstyles) do table.insert(sorted, num) end
				table.sort(sorted)
				return sorted
			end)(),
			","
		)
	end

	--Update only the relevant location
	local new_combat_str = location == "combat" and new_lockstyle_str or combat_str
	local new_town_str = location == "town" and new_lockstyle_str or town_str

	--Construct the new lockstyle string
	local new_str = string.format(
		"{combat:%s}{town:%s}",
		new_combat_str,
		new_town_str
	)

	--Save the updated string
	settings.lockstyles[job] = new_str
	settings:save()

	displayLockstyles(job, location)

end

windower.register_event('job change',function()

	--We use this way for a timer (instead of the coroutine.sleep like with zoning) so that we can reset it during the countdown in case we change jobs again while its running, preventing it from trying to set the lockstyle multiple times.
	if after_job_change_delay ~= 0 then
		lockstyle_delay = after_job_change_delay --start/restart the timer
	end

end)

windower.register_event('zone change',function()

	if after_zone_delay ~= 0 then
		coroutine.sleep(after_zone_delay) --wait a short delay after zoning, if too early will error
		setLockstyle() --set the appropriate lockstyle
	end

end)

windower.register_event('addon command',function(cmd, ...)

	local args = {...}
	local sub_cmd = args[1]
	local lockstyle_num = tonumber(args[2])
	local job = string.lower(windower.ffxi.get_player().main_job)

	if cmd == 'combat' or cmd == 'c' then

		if not sub_cmd then

			displayLockstyles(job, 'combat')

		elseif sub_cmd == 'add' or sub_cmd == 'a' then

			if lockstyle_num and (lockstyle_num >= 0 and lockstyle_num <= 200) then
				addLockstyle(job, 'combat', lockstyle_num)
			else
				add_to_chat(8,('[Vanity] '):color(220)..('Please provide a number '):color(8)..('1'):color(1)..('-'):color(8)..('200 '):color(1)..('('):color(8)..('0 '):color(1)..('to clear list and disable).'):color(8))
			end

		elseif sub_cmd == 'remove' or sub_cmd == 'rem' or sub_cmd == 'r' then

			removeLockstyle(job, 'combat', lockstyle_num)

		else
			add_to_chat(8,('[Vanity] '):color(220)..('Please provide the sub-command '):color(8)..('add '):color(1)..('or '):color(8)..('remove'):color(1)..('.'):color(8))
		end

	elseif cmd == 'town' or cmd == 't' then

		if not sub_cmd then

			displayLockstyles(job, 'town')

		elseif sub_cmd == 'add' or sub_cmd == 'a' then

			if lockstyle_num and (lockstyle_num >= 0 and lockstyle_num <= 200) then
				addLockstyle(job, 'town', lockstyle_num)
			else
				add_to_chat(8,('[Vanity] '):color(220)..('Please provide a number '):color(8)..('1'):color(1)..('-'):color(8)..('200 '):color(1)..('('):color(8)..('0 '):color(1)..('to clear list and disable).'):color(8))
			end

		elseif sub_cmd == 'remove' or sub_cmd == 'rem' or sub_cmd == 'r' then

			removeLockstyle(job, 'town', lockstyle_num)

		else
			add_to_chat(8,('[Vanity] '):color(220)..('Please provide the sub-command '):color(8)..('add '):color(1)..('or '):color(8)..('remove'):color(1)..('.'):color(8))
		end

	elseif cmd == 'help' then

		local currDisableDelay = after_disable_delay == 0 and 'OFF' or after_disable_delay
		local currJCDelay = after_job_change_delay == 0 and 'OFF' or after_job_change_delay
		local currZoneDelay = safter_zone_delay == 0 and 'OFF' or after_zone_delay

		local prefix = "//vanity, //van"
		add_to_chat(8,('[Vanity] '):color(220)..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220)..(' ('):color(8)..(prefix):color(1)..(')'):color(8))
		add_to_chat(8,(' Control your lockstyles based on character, job, and location.'):color(1))
		add_to_chat(8,(' If multiple lockstyle #\'s are set, will pick one at random.'):color(1))
		add_to_chat(8,' ')
		add_to_chat(8,(' Command '):color(36)..('Optional '):color(53)..('Required '):color(2)..(' - Description ['):color(8)..('Current Setting'):color(200)..(']'):color(8))
		add_to_chat(8,(' combat/c '):color(36)..('- Display Equip. Set #\'s for your current job in combat zones.'):color(8))
		add_to_chat(8,(' town/t '):color(36)..('- Display Equip. Set #\'s for your current job in town zones.'):color(8))
		add_to_chat(8,('   - add/a '):color(53)..('# '):color(2)..('- Add an Equip. Set # to the combat/town list.'):color(8))
		add_to_chat(8,('     - Number must be 1-200, 0 will clear list and disable.'):color(8))
		add_to_chat(8,('   - remove/r '):color(53)..('# '):color(2)..('- Remove an Equip. Set # from the combat/town list.'):color(8))
		add_to_chat(8,(' set/s'):color(36)..(' - Set current lockstyle based on job and zone.'):color(8))
		add_to_chat(8,(' list/l'):color(36)..(' - List all lockstyles for the current character.'):color(8))
		add_to_chat(8,(' disable/d'):color(36)..(' #'):color(53)..(' - Display/update After Disable Delay (1-20, 0 to disable). ['):color(8)..(''..currDisableDelay):color(200)..(']'):color(8))
		add_to_chat(8,(' job/j'):color(36)..(' #'):color(53)..(' - Display/update After Job Change Delay (1-20, 0 to disable). ['):color(8)..(''..currJCDelay):color(200)..(']'):color(8))
		add_to_chat(8,(' zone/z'):color(36)..(' #'):color(53)..(' - Display/update After Zone Delay (1-20, 0 to disable). ['):color(8)..(''..currZoneDelay):color(200)..(']'):color(8))

	elseif cmd == 'set' or cmd == 's' then
		setLockstyle()

	elseif cmd == 'disable' or cmd == 'd' then
		if sub_cmd == nil then
			local delay = after_disable_delay
			add_to_chat(8,('[Vanity] '):color(220)..('After Disable Delay'):color(1)..(' is currently set to '):color(8)..(delay == 0 and ('OFF'):color(1) or (''..delay):color(1)..((' %s'):format(delay == 1 and 'second' or 'seconds')):color(8))..'.':color(8))
		else
			sub_cmd = tonumber(sub_cmd)
			if sub_cmd and sub_cmd >= 1 and sub_cmd <= 20 then
				settings.options.after_disable_delay = sub_cmd
				after_disable_delay = settings.options.after_disable_delay
				settings:save('all')
				add_to_chat(8,('[Vanity] '):color(220)..('After Disable Delay'):color(1)..(' is now '):color(8)..(after_disable_delay..' seconds'):color(1)..('.'):color(8))
			elseif sub_cmd == 0 then
				settings.options.after_disable_delay = 0
				after_disable_delay = settings.options.after_disable_delay
				settings:save('all')
				add_to_chat(8,('[Vanity] '):color(220)..('After Disable Delay'):color(1)..(' is now '):color(8)..('OFF'):color(1)..('.'):color(8))
			else
				add_to_chat(8,('[Vanity] '):color(220)..('Please select a Disable Delay between '):color(8)..('1'):color(1)..(' and '):color(8)..('20'):color(1)..('.'):color(8))
				add_to_chat(8,'  Example: '..('//vanity '..cmd..' 9'):color(1))
			end
		end

	elseif cmd == 'jobchange' or cmd == 'j' then
		if sub_cmd == nil then
			local delay = after_job_change_delay
			add_to_chat(8,('[Vanity] '):color(220)..('After Job Change Delay'):color(1)..(' is currently set to '):color(8)..(delay == 0 and ('OFF'):color(1) or (''..delay):color(1)..((' %s'):format(delay == 1 and 'second' or 'seconds')):color(8))..'.':color(8))
		else
			sub_cmd = tonumber(sub_cmd)
			if sub_cmd and sub_cmd >= 1 and sub_cmd <= 20 then
				settings.options.after_job_change_delay = sub_cmd
				after_job_change_delay = settings.options.after_job_change_delay
				settings:save('all')
				add_to_chat(8,('[Vanity] '):color(220)..('After Job Change Delay'):color(1)..(' is now '):color(8)..(after_job_change_delay..' seconds'):color(1)..('.'):color(8))
			elseif sub_cmd == 0 then
				settings.options.after_job_change_delay = 0
				after_job_change_delay = settings.options.after_job_change_delay
				settings:save('all')
				add_to_chat(8,('[Vanity] '):color(220)..('After Job Change Delay'):color(1)..(' is now '):color(8)..('OFF'):color(1)..('.'):color(8))
			else
				add_to_chat(8,('[Vanity] '):color(220)..('Please select a Job Change Delay between '):color(8)..('1'):color(1)..(' and '):color(8)..('20'):color(1)..('.'):color(8))
				add_to_chat(8,'  Example: '..('//vanity '..cmd..' 9'):color(1))
			end
		end

	elseif cmd == 'zone' or cmd == 'z' then
		if sub_cmd == nil then
			local delay = after_zone_delay
			add_to_chat(8,('[Vanity] '):color(220)..('After Zone Delay'):color(1)..(' is currently set to '):color(8)..(delay == 0 and ('OFF'):color(1) or (''..delay):color(1)..((' %s'):format(delay == 1 and 'second' or 'seconds')):color(8))..'.':color(8))
		else
			sub_cmd = tonumber(sub_cmd)
			if sub_cmd and sub_cmd >= 1 and sub_cmd <= 20 then
				settings.options.after_zone_delay = sub_cmd
				after_zone_delay = settings.options.after_zone_delay
				settings:save('all')
				add_to_chat(8,('[Vanity] '):color(220)..('After Zone Delay'):color(1)..(' is now '):color(8)..(after_zone_delay..' seconds'):color(1)..('.'):color(8))
			elseif sub_cmd == 0 then
				settings.options.after_zone_delay = 0
				after_zone_delay = settings.options.after_zone_delay
				settings:save('all')
				add_to_chat(8,('[Vanity] '):color(220)..('After Zone Delay'):color(1)..(' is now '):color(8)..('OFF'):color(1)..('.'):color(8))
			else
				add_to_chat(8,('[Vanity] '):color(220)..('Please select a Zone Delay between '):color(8)..('1'):color(1)..(' and '):color(8)..('20'):color(1)..('.'):color(8))
				add_to_chat(8,'  Example: '..('//vanity '..cmd..' 9'):color(1))
			end
		end

	elseif cmd == 'list' or cmd == 'l' then
		listAllLockstyles()

	else
		add_to_chat(8,('[Vanity] '):color(220)..('Unrecognized command. Type'):color(8)..(' //vanity help'):color(1)..(' for a list of commands.'):color(8))

	end

end)

windower.register_event('prerender', function()

	if os.time() > Heartbeat then

		Heartbeat = os.time()

		if lockstyle_delay > 0 then

			lockstyle_delay = lockstyle_delay -1

		elseif lockstyle_delay == 0 then

			lockstyle_delay = -1
			setLockstyle()

		end

	end
end)

windower.register_event('incoming text',function(org)

	local delay = settings.options.after_disable_delay

	if delay ~= 0 and not townZone() and org:find('Style lock mode disabled.') then

		coroutine.sleep(delay) --wait a short delay after lockstyle is disabled, if too early will error

		setLockstyle() --set the appropriate lockstyle

	end
end)
