--Copyright (c) 2024, Key
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
_addon.version = '1.3'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'vanity','van'}

config = require('config')
res = require('resources')
require 'chat'

defaults = {}

defaults.options = {}
defaults.options.after_disable_delay = 9
defaults.options.after_job_change_delay = 6
defaults.options.after_zone_delay = 5

defaults.lockstyles = {}

defaults.lockstyles.blm = {}
defaults.lockstyles.blm.combat = 0
defaults.lockstyles.blm.town = 0

defaults.lockstyles.blu = {}
defaults.lockstyles.blu.combat = 0
defaults.lockstyles.blu.town = 0

defaults.lockstyles.brd = {}
defaults.lockstyles.brd.combat = 0
defaults.lockstyles.brd.town = 0

defaults.lockstyles.bst = {}
defaults.lockstyles.bst.combat = 0
defaults.lockstyles.bst.town = 0

defaults.lockstyles.cor = {}
defaults.lockstyles.cor.combat = 0
defaults.lockstyles.cor.town = 0

defaults.lockstyles.dnc = {}
defaults.lockstyles.dnc.combat = 0
defaults.lockstyles.dnc.town = 0

defaults.lockstyles.drg = {}
defaults.lockstyles.drg.combat = 0
defaults.lockstyles.drg.town = 0

defaults.lockstyles.drk = {}
defaults.lockstyles.drk.combat = 0
defaults.lockstyles.drk.town = 0

defaults.lockstyles.geo = {}
defaults.lockstyles.geo.combat = 0
defaults.lockstyles.geo.town = 0

defaults.lockstyles.mnk = {}
defaults.lockstyles.mnk.combat = 0
defaults.lockstyles.mnk.town = 0

defaults.lockstyles.nin = {}
defaults.lockstyles.nin.combat = 0
defaults.lockstyles.nin.town = 0

defaults.lockstyles.pld = {}
defaults.lockstyles.pld.combat = 0
defaults.lockstyles.pld.town = 0

defaults.lockstyles.pup = {}
defaults.lockstyles.pup.combat = 0
defaults.lockstyles.pup.town = 0

defaults.lockstyles.rdm = {}
defaults.lockstyles.rdm.combat = 0
defaults.lockstyles.rdm.town = 0

defaults.lockstyles.rng = {}
defaults.lockstyles.rng.combat = 0
defaults.lockstyles.rng.town = 0

defaults.lockstyles.run = {}
defaults.lockstyles.run.combat = 0
defaults.lockstyles.run.town = 0

defaults.lockstyles.sam = {}
defaults.lockstyles.sam.combat = 0
defaults.lockstyles.sam.town = 0

defaults.lockstyles.sch = {}
defaults.lockstyles.sch.combat = 0
defaults.lockstyles.sch.town = 0

defaults.lockstyles.smn = {}
defaults.lockstyles.smn.combat = 0
defaults.lockstyles.smn.town = 0

defaults.lockstyles.thf = {}
defaults.lockstyles.thf.combat = 0
defaults.lockstyles.thf.town = 0

defaults.lockstyles.war = {}
defaults.lockstyles.war.combat = 0
defaults.lockstyles.war.town = 0

defaults.lockstyles.whm = {}
defaults.lockstyles.whm.combat = 0
defaults.lockstyles.whm.town = 0

defaults.town_zones = {
	'Western Adoulin','Eastern Adoulin','Celennia Memorial Library','Silver Knife','Bastok Markets','Bastok Mines','Metalworks','Port Bastok','Chateau d\'Oraguille','Northern San d\'Oria','Port San d\'Oria','Southern San d\'Oria','Heavens Tower','Port Windurst','Windurst Walls','Windurst Waters','Windurst Woods','Lower Jeuno','Port Jeuno','Ru\'Lude Gardens','Upper Jeuno','Aht Urhgan Whitegate','The Colosseum','Tavnazian Safehold','Southern San d\'Oria [S]','Bastok Markets [S]','Windurst Waters [S]','Mhaura','Selbina','Rabao','Kazham','Norg','Nashmau','Mog Garden','Leafallia','Chocobo Circuit'
    }

settings = config.load(defaults)

local add_to_chat = windower.add_to_chat

local Heartbeat = 0
local lockstyle_delay = -1

-- Turn the entire string into all uppercase
function uppercase(str)

	local uppercased = string.gsub(str, "%a", function(letter)
		return letter:upper()
	end)

	return uppercased

end

-- Are we located in a town zone?
local function townZone()
	local zone_name = res.zones[windower.ffxi.get_info().zone].name

	for _, name in ipairs(settings.town_zones) do
		if name == zone_name then
			return true
		end
	end

	return false
end

-- Run the lockstyle game command for the job/location combination
local function setLockstyle()

	if not windower.ffxi.get_info().logged_in then return end

	local job = string.lower(windower.ffxi.get_player().main_job)
	local lockstyle = settings.lockstyles
	local location = townZone() and 'town' or 'combat'

	if lockstyle[job][location] ~= 0 then
		windower.send_command('input /lockstyleset '..lockstyle[job][location])
	end

end

-- List all lockstyles that have been designated (not 0)
local function listLockstyles()

	local noneDesignated = true

	add_to_chat(8,('[Vanity] '):color(220)..('Lockstyles:'):color(8))

	for job, data in pairs(settings.lockstyles) do
		if data.combat ~= 0 then
			add_to_chat(8,' - '..(uppercase(job)..' Combat: '..data.combat):color(1))
			noneDesignated = false
		end
		if data.town ~= 0 then
			add_to_chat(8,' - '..(uppercase(job)..' Town: '..data.town):color(1))
			noneDesignated = false
		end
	end

	if noneDesignated then
		add_to_chat(8,' -'..('[None Designated]'):color(1))
	end

end

windower.register_event('job change',function()

	local delay = settings.options.after_job_change_delay

	--We use this way for a timer (instead of the coroutine.sleep like with zoning) so that we can reset it during the countdown in case we change jobs again while its running, preventing it from trying to set the lockstyle multiple times.
	if delay ~= 0 then
		lockstyle_delay = delay --start/restart the timer
	end

end)

windower.register_event('zone change',function()

	local delay = settings.options.after_zone_delay

	if delay ~= 0 then
		coroutine.sleep(delay) --wait a short delay after zoning, if too early will error
		setLockstyle() --set the appropriate lockstyle
	end

end)

windower.register_event('addon command',function(addcmd, ...)

	local args = {...}
	local arg = args[1]
	local arg2 = tonumber(args[2])
	local match = false
	local job_to_update = windower.ffxi.get_player().main_job
	local jobs = {
		"blm", "blu", "brd", "bst", "cor", "dnc", "drg", "drk", "geo", "mnk", "nin", "pld", "pup", "rdm", "rng", "run", "sam", "smn", "sch", "thf", "war", "whm"
	}

	local function pickRandomJob()
		local randomIndex = math.random(1, #jobs)
		return jobs[randomIndex]
	end

	local function pickRandomGear()
		local options = {"combat", "town"}
		local randomIndex = math.random(1, #options)
		return options[randomIndex]
	end

	local function pickRandomEquipSet()
		return math.random(0, 200)
	end

	local randomJob = pickRandomJob()
	local randomGear = pickRandomGear()
	local randomEquipSet = pickRandomEquipSet()

	for _, job in ipairs(jobs) do
		if job == addcmd then
			match = true
			job_to_update = job
		end
	end

	local job = string.lower(job_to_update)

	if addcmd == 'combat' or (addcmd == job and arg == 'combat') then
		if arg == nil or (arg == 'combat' and arg2 == nil) then
			add_to_chat(8,('[Vanity] '):color(220)..(uppercase(job)..' Combat'):color(1)..(' lockstyle is currently '):color(8)..(settings.lockstyles[job].combat == 0 and ('Disabled (0)'):color(1) or ('Equipment Set '..settings.lockstyles[job].combat):color(1))..('.'):color(8))
		elseif (tonumber(arg) >= 0 and tonumber(arg) <= 200) or (arg == 'combat' and arg2 and arg2 >= 0 and arg2 <= 200) then
			settings.lockstyles[job].combat = arg == 'combat' and arg2 or tonumber(arg)
			settings:save()
			add_to_chat(8,('[Vanity] '):color(220)..(uppercase(job)..' Combat'):color(1)..(' lockstyle is now '):color(8)..(settings.lockstyles[job].combat == 0 and ('Disabled (0)'):color(1) or ('Equipment Set '..settings.lockstyles[job].combat):color(1))..('.'):color(8))
		else
			add_to_chat(8,('[Vanity] '):color(220)..('Please select an Equipment Set number between '):color(8)..('1'):color(1)..(' and '):color(8)..('200'):color(1)..(' ('):color(8)..('0'):color(1)..(' to disable).'):color(8))
			add_to_chat(8,'  Example: '..('//vanity '..job..' combat '..randomEquipSet):color(1))
		end

	elseif addcmd == 'town' or (addcmd == job and arg == 'town') then
		if arg == nil or (arg == 'town' and arg2 == nil) then
			add_to_chat(8,('[Vanity] '):color(220)..(uppercase(job)..' Town'):color(1)..(' lockstyle is currently '):color(8)..(settings.lockstyles[job].town == 0 and ('Disabled (0)'):color(1) or ('Equipment Set '..settings.lockstyles[job].town):color(1))..('.'):color(8))
		elseif (tonumber(arg) >= 0 and tonumber(arg) <= 200) or (arg == 'town' and arg2 and arg2 >= 0 and arg2 <= 200) then
			settings.lockstyles[job].town = arg == 'town' and arg2 or tonumber(arg)
			settings:save()
			add_to_chat(8,('[Vanity] '):color(220)..(uppercase(job)..' Town'):color(1)..(' lockstyle is now '):color(8)..(settings.lockstyles[job].town == 0 and ('Disabled (0)'):color(1) or ('Equipment Set '..settings.lockstyles[job].town):color(1))..('.'):color(8))
		else
			add_to_chat(8,('[Vanity] '):color(220)..('Please select an Equipment Set number between '):color(8)..('1'):color(1)..(' and '):color(8)..('200'):color(1)..(' ('):color(8)..('0'):color(1)..(' to disable).'):color(8))
			add_to_chat(8,'  Example: '..('//vanity '..job..' town '..randomEquipSet):color(1))
		end

	elseif addcmd == 'help' then

		local currDisableDelay = settings.options.after_disable_delay == 0 and 'OFF' or settings.options.after_disable_delay
		local currJCDelay = settings.options.after_job_change_delay == 0 and 'OFF' or settings.options.after_job_change_delay
		local currZoneDelay = settings.options.after_zone_delay == 0 and 'OFF' or settings.options.after_zone_delay

		local prefix = "//vanity, //van"
		add_to_chat(8,('[Vanity] '):color(220)..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220)..(' ('):color(8)..(prefix):color(1)..(')'):color(8))
		add_to_chat(8,(' Command '):color(36)..('[optional]'):color(53)..(' <required>'):color(2)..(' - Description ['):color(8)..('Current Setting'):color(200)..(']'):color(8))
		add_to_chat(8,' ')
		add_to_chat(8,(' blm/blu/brd/etc '):color(36)..('<combat/town>'):color(2)..(' [#]'):color(53)..(' - Display/update which Equipment Set # is used (1-200, 0 to disable).'):color(8))
		add_to_chat(8,(' set/s'):color(36)..(' - Manually set lockstyle based on job and zone.'):color(8))
		add_to_chat(8,(' list/l'):color(36)..(' - List all non-disabled lockstyles for the current character.'):color(8))
		add_to_chat(8,(' disable/d'):color(36)..(' [#]'):color(53)..(' - Display/update After Disable Delay (1-20, 0 to disable). ['):color(8)..(''..currDisableDelay):color(200)..(']'):color(8))
		add_to_chat(8,(' job/j'):color(36)..(' [#]'):color(53)..(' - Display/update After Job Change Delay (1-20, 0 to disable). ['):color(8)..(''..currJCDelay):color(200)..(']'):color(8))
		add_to_chat(8,(' zone/z'):color(36)..(' [#]'):color(53)..(' - Display/update After Zone Delay (1-20, 0 to disable). ['):color(8)..(''..currZoneDelay):color(200)..(']'):color(8))

	elseif addcmd == 'set' or addcmd == 's' then
		setLockstyle()

	elseif addcmd == 'disable' or addcmd == 'd' then
		if arg == nil then
			local delay = settings.options.after_disable_delay
			add_to_chat(8,('[Vanity] '):color(220)..('After Disable Delay'):color(1)..(' is currently set to '):color(8)..(delay == 0 and ('OFF'):color(1) or (''..delay):color(1)..((' %s'):format(delay == 1 and 'second' or 'seconds')):color(8))..'.':color(8))
		else
			arg = tonumber(arg)
			if arg and arg >= 1 and arg <= 20 then
				settings.options.after_disable_delay = arg
				settings:save('all')
				add_to_chat(8,('[Vanity] '):color(220)..('After Disable Delay'):color(1)..(' is now '):color(8)..(settings.options.after_disable_delay..' seconds'):color(1)..('.'):color(8))
			elseif arg == 0 then
				settings.options.after_disable_delay = 0
				settings:save('all')
				add_to_chat(8,('[Vanity] '):color(220)..('After Disable Delay'):color(1)..(' is now '):color(8)..('OFF'):color(1)..('.'):color(8))
			else
				add_to_chat(8,('[Vanity] '):color(220)..('Please select a Disable Delay between '):color(8)..('1'):color(1)..(' and '):color(8)..('20'):color(1)..('.'):color(8))
				add_to_chat(8,'  Example: '..('//vanity '..addcmd..' 9'):color(1))
			end
		end

	elseif addcmd == 'jobchange' or addcmd == 'j' then
		if arg == nil then
			local delay = settings.options.after_job_change_delay
			add_to_chat(8,('[Vanity] '):color(220)..('After Job Change Delay'):color(1)..(' is currently set to '):color(8)..(delay == 0 and ('OFF'):color(1) or (''..delay):color(1)..((' %s'):format(delay == 1 and 'second' or 'seconds')):color(8))..'.':color(8))
		else
			arg = tonumber(arg)
			if arg and arg >= 1 and arg <= 20 then
				settings.options.after_job_change_delay = arg
				settings:save('all')
				add_to_chat(8,('[Vanity] '):color(220)..('After Job Change Delay'):color(1)..(' is now '):color(8)..(settings.options.after_job_change_delay..' seconds'):color(1)..('.'):color(8))
			elseif arg == 0 then
				settings.options.after_job_change_delay = 0
				settings:save('all')
				add_to_chat(8,('[Vanity] '):color(220)..('After Job Change Delay'):color(1)..(' is now '):color(8)..('OFF'):color(1)..('.'):color(8))
			else
				add_to_chat(8,('[Vanity] '):color(220)..('Please select a Job Change Delay between '):color(8)..('1'):color(1)..(' and '):color(8)..('20'):color(1)..('.'):color(8))
				add_to_chat(8,'  Example: '..('//vanity '..addcmd..' 9'):color(1))
			end
		end

	elseif addcmd == 'zone' or addcmd == 'z' then
		if arg == nil then
			local delay = settings.options.after_zone_delay
			add_to_chat(8,('[Vanity] '):color(220)..('After Zone Delay'):color(1)..(' is currently set to '):color(8)..(delay == 0 and ('OFF'):color(1) or (''..delay):color(1)..((' %s'):format(delay == 1 and 'second' or 'seconds')):color(8))..'.':color(8))
		else
			arg = tonumber(arg)
			if arg and arg >= 1 and arg <= 20 then
				settings.options.after_zone_delay = arg
				settings:save('all')
				add_to_chat(8,('[Vanity] '):color(220)..('After Zone Delay'):color(1)..(' is now '):color(8)..(settings.options.after_zone_delay..' seconds'):color(1)..('.'):color(8))
			elseif arg == 0 then
				settings.options.after_zone_delay = 0
				settings:save('all')
				add_to_chat(8,('[Vanity] '):color(220)..('After Zone Delay'):color(1)..(' is now '):color(8)..('OFF'):color(1)..('.'):color(8))
			else
				add_to_chat(8,('[Vanity] '):color(220)..('Please select a Zone Delay between '):color(8)..('1'):color(1)..(' and '):color(8)..('20'):color(1)..('.'):color(8))
				add_to_chat(8,'  Example: '..('//vanity '..addcmd..' 9'):color(1))
			end
		end

	elseif addcmd == 'list' or addcmd == 'l' then
		listLockstyles()

	elseif not match then
		add_to_chat(8,('[Vanity] '):color(220)..('Please use the 3 letter abbreviation for the job lockstyle you would like to update.'):color(8))
		add_to_chat(8,'  Example: '..('//vanity '..randomJob..' '..randomGear..' '..randomEquipSet):color(1))

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
