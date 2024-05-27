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
_addon.version = '1.0'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'vanity','van'}

config = require('config')
res = require('resources')
require 'chat'

defaults = {}

defaults.after_zone_delay = 5
defaults.after_job_change_delay = 6

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
	'Western Adoulin','Eastern Adoulin','Celennia Memorial Library','Silver Knife','Bastok Markets','Bastok Mines','Metalworks','Port Bastok','Chateau d\'Oraguille','Northern San d\'Oria','Port San d\'Oria','Southern San d\'Oria','Heavens Tower','Port Windurst','Windurst Walls','Windurst Waters','Windurst Woods','Lower Jeuno','Port Jeuno','Ru\'Lude Gardens','Upper Jeuno','Aht Urhgan Whitegate','The Colosseum','Tavnazian Safehold','Southern San d\'Oria [S]','Bastok Markets [S]','Windurst Waters [S]','Mhaura','Selbina','Rabao','Kazham','Norg','Nashmau','Mog Garden','Leafallia'
    }

settings = config.load(defaults)

local Heartbeat = 0
local LockstyleDelay = -1

-- Turn the entire string into all uppercase
function uppercase(str)

	local uppercased = string.gsub(str, "%a", function(letter)
		return letter:upper()
	end)

	return uppercased

end

local function townZone()
	local zone_name = res.zones[windower.ffxi.get_info().zone].name

	for _, name in ipairs(settings.town_zones) do
		if name == zone_name then
			return true
		end
	end

	return false
end

local function setLockstyle()

	local job = string.lower(windower.ffxi.get_player().main_job)
	local lockstyle = settings.lockstyles
	local location = townZone() and 'town' or 'combat'

	if lockstyle[job][location] ~= 0 then
		windower.send_command('input /lockstyleset '..lockstyle[job][location])
	end

end

windower.register_event('job change',function()

	LockstyleDelay = settings.after_job_change_delay --start/restart the timer

end)

windower.register_event('zone change',function()

	coroutine.sleep(settings.after_zone_delay) --wait a short delay after zoning, if too early will error

	setLockstyle() --set the appropriate lockstyle

end)

windower.register_event('addon command',function(addcmd, ...)

	local args = {...}
	local arg = args[1]
	local arg2 = tonumber(args[2])
	local match = false
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
			if arg == 'combat' then
				if arg2 == nil then
					windower.add_to_chat(220,'[Vanity] '..(uppercase(job)..' Combat'):color(1)..(' lockstyle currently set to '):color(8)..('Equipment Set '..settings.lockstyles[job].combat):color(1)..('.'):color(8))
				elseif arg2 and arg2 >= 0 and arg2 <= 200 then
					settings.lockstyles[job].combat = arg2
					settings:save()
					windower.add_to_chat(220,'[Vanity] '..(uppercase(job)..' Combat'):color(1)..(' lockstyle set to '):color(8)..('Equipment Set '..settings.lockstyles[job].combat):color(1)..('.'):color(8))
				else
					windower.add_to_chat(220,'[Vanity] '..('Please select an Equipment Set number between '):color(8)..('1'):color(1)..(' and '):color(8)..('200'):color(1)..(' ('):color(8)..('0'):color(1)..(' to disable).'):color(8))
					windower.add_to_chat(8,'  Example: '..('//vanity '..job..' combat '..randomEquipSet):color(1))
				end
			elseif arg == 'town' then
				if arg2 == nil then
					windower.add_to_chat(220,'[Vanity] '..(uppercase(job)..'Town'):color(1)..(' lockstyle currently set to '):color(8)..('Equipment Set '..settings.lockstyles[job].town):color(1)..('.'):color(8))
				elseif arg2 and arg2 >= 0 and arg2 <= 200 then
					settings.lockstyles[job].town = arg2
					settings:save()
					windower.add_to_chat(220,'[Vanity] '..(uppercase(job)..'Town'):color(1)..(' lockstyle set to '):color(8)..('Equipment Set '..settings.lockstyles[job].town):color(1)..('.'):color(8))
				else
					windower.add_to_chat(220,'[Vanity] '..('Please select an Equipment Set number between '):color(8)..('1'):color(1)..(' and '):color(8)..('200'):color(1)..(' ('):color(8)..('0'):color(1)..(' to disable).'):color(8))
					windower.add_to_chat(8,'  Example: '..('//vanity '..job..' town '..randomEquipSet):color(1))
				end
			else
				windower.add_to_chat(220,'[Vanity] '..('Please select either the '):color(8)..('combat'):color(1)..(' or '):color(8)..('town'):color(1)..(' lockstyle to update.'):color(8))
				windower.add_to_chat(8,'  Example: '..('//vanity '..job..' '..randomGear..' '..randomEquipSet):color(1))
			end
		end
	end

	if addcmd == nil or addcmd == 'help' then
		windower.add_to_chat(220,'[Vanity] '..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..('Key (Keylesta@Valefor)'):color(220))
		windower.add_to_chat(220,' ')
		windower.add_to_chat(220,'Commands '..('[optional]'):color(53)..(' <required>'):color(2))
		windower.add_to_chat(36,'   blm/blu/brd/etc '..('<combat/town> [#]'):color(2)..(' - Display/update which Equipment Set # is used (1-200, 0 to disable).'):color(8))
		windower.add_to_chat(36,'   set/s'..(' - Manually set lockstyle based on job and zone.'):color(8))
		windower.add_to_chat(36,'   job/j [#]'..(' - Display/update After Job Change Delay (1-10).'):color(8))
		windower.add_to_chat(36,'   zone/z [#]'..(' - Display/update After Zone Delay (1-10).'):color(8))
	elseif addcmd == 'set' or addcmd == 's' then
		setLockstyle()
	elseif addcmd == 'change' or addcmd == 'job' or addcmd == 'jc' or addcmd == 'j' or addcmd == 'c' or addcmd == 'changedelay' then
		arg = tonumber(arg)
		if arg == nil then
			windower.add_to_chat(220,'[Vanity] '..('After Job Change Delay'):color(1)..(' currently set to '):color(8)..(settings.after_job_change_delay..' seconds.'):color(1))
		elseif arg and arg >= 1 and arg <= 10 then
			settings.after_job_change_delay = arg
			settings:save('all')
			windower.add_to_chat(220,'[Vanity] '..('After Job Change Delay'):color(1)..(' set to '):color(8)..(settings.after_job_change_delay..' seconds.'):color(1))
		else
			windower.add_to_chat(220,'[Vanity] '..('Please select an After Job Change Delay between '):color(8)..('1'):color(1)..(' and '):color(8)..('10'):color(1)..('.'):color(8))
			windower.add_to_chat(8,'  Example: '..('//vanity '..addcmd..' 6'):color(1))
		end
	elseif addcmd == 'zone' or addcmd == 'zoning' or addcmd == 'z' or addcmd == 'zonedelay' or addcmd == 'zoningdelay' then
		arg = tonumber(arg)
		if arg == nil then
			windower.add_to_chat(220,'[Vanity] '..('After Zone Delay'):color(1)..(' currently set to '):color(8)..(settings.after_zone_delay..' seconds.'):color(1))
		elseif arg and arg >= 1 and arg <= 10 then
			settings.after_job_change_delay = arg
			settings:save('all')
			windower.add_to_chat(220,'[Vanity] '..('After Zone Delay'):color(1)..(' set to '):color(8)..(settings.after_zone_delay..' seconds.'):color(1))
		else
			windower.add_to_chat(220,'[Vanity] '..('Please select an After Zone Delay between '):color(8)..('1'):color(1)..(' and '):color(8)..('10'):color(1)..('.'):color(8))
			windower.add_to_chat(8,'  Example: '..('//vanity '..addcmd..' 5'):color(1))
		end
	elseif not match then
		windower.add_to_chat(220,'[Vanity] '..('Please use the 3 letter abbreviation for the job lockstyle you would like to update.'):color(8))
		windower.add_to_chat(8,'  Example: '..('//vanity '..randomJob..' '..randomGear..' '..randomEquipSet):color(1))
	end

end)

windower.register_event('prerender', function()
	if os.time() > Heartbeat then
		Heartbeat = os.time()
		--We use this way for a timer (instead of the coroutine.sleep like with zoning) so that we can reset it during the countdown in case we change jobs again while its running, preventing it from trying to set the lockstyle multiple times.
		if LockstyleDelay > 0 then
			LockstyleDelay = LockstyleDelay -1
		elseif LockstyleDelay == 0 then
			LockstyleDelay = -1
			setLockstyle()
		end
	end
end)
