--Copyright (c) 2023, Key
--All rights reserved.

--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:

--    * Redistributions of source code must retain the above copyright
--      notice, this list of conditions and the following disclaimer.
--    * Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in the
--      documentation and/or other materials provided with the distribution.
--    * Neither the name of Callouts nor the
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

_addon.name = 'Callouts'
_addon.version = '01.17.23'
_addon.author = 'Key'
_addon.commands = {'callouts','co'}

require 'logger'
res = require 'resources'
local chat = windower.chat.input
local cmd = windower.send_command


--Default Chat mode on load.
chatmode = 'e'
--Party (p) and Echo (echo) are the two that can be toggled between via command but any can be used for default (careful!)



--Unless you know what you're doing, leave everything under here alone.



windower.register_event('action',function(act)

	local actor = windower.ffxi.get_mob_by_id(act.actor_id)
	local target_name = windower.ffxi.get_mob_by_id(act.targets[1].id).name or 'Unknown'

	if act.category == 7 then

		if actor.name == "Aita" or actor.name == "Degei" then
			if res.monster_abilities[act.targets[1].actions[1].param] == nil then
				return
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Flaming Kick' then
				chat('/'..chatmode..' Water (Flaming Kick) <call14>')
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Flashflood' then
				chat('/'..chatmode..' Thunder (Flashflood) <call14>')
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Icy Grasp' then
				chat('/'..chatmode..' Fire (Icy Grasp) <call14>')
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Eroding Flesh' then
				chat('/'..chatmode..' Aero (Eroding Flesh) <call14>')
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Fulminous Smash' then
				chat('/'..chatmode..' Stone (Fulminous Smash) <call14>')
			end

		elseif actor.name == "Aminon" then
			if res.monster_abilities[act.targets[1].actions[1].param] == nil then
				return
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Demonfire' then
				chat('/'..chatmode..' Water (Demon Fire) <call14>')
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Torrential Pain' then
				chat('/'..chatmode..' Thunder (Torrential Pain) <call14>')
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Frozen Blood' then
				chat('/'..chatmode..' Fire (Frozen Blood) <call14>')
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Ensepulcher' then
				chat('/'..chatmode..' Aero (Ensepulcher) <call14>')
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Ceaseless Surge' then
				chat('/'..chatmode..' Stone (Ceaseless Surge) <call14>')
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Blast of Reticence' then
				chat('/'..chatmode..' Blizzard (Blast of Reticence) <call14>')
			end

		elseif actor.name == "Glassy Thinker" then
			if res.monster_abilities[act.targets[1].actions[1].param] == nil then
				return
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Pain Sync' then
				chat('/'..chatmode..' PAIN SYNC <call14>')
			end

		elseif actor.name == "Ou" or actor.name == "Kin" then
			if res.monster_abilities[act.targets[1].actions[1].param] == nil then
				return
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Target' then
				chat('/'..chatmode..' Target used on '..target_name..' <call14>')
			end

		elseif actor.name == "Bumba" then
			if res.monster_abilities[act.targets[1].actions[1].param] == nil then
				return
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Perfect Dodge' then
				chat('/'..chatmode..' Perfect Dodge <call14>')
				chat:schedule(30,'/'..chatmode..' Perfect Dodge is off <call14>')
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Invincible' then
				chat('/'..chatmode..' Invincible <call14>')
				chat:schedule(30,'/'..chatmode..' Invincible is off <call14>')
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Elemental Sforzo' then
				chat('/'..chatmode..' Elemental Sforzo <call14>')
				chat:schedule(30,'/'..chatmode..' Elemental Sforzo is off <call14>')
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Yaegasumi' then
				chat('/'..chatmode..' Yaegasumi <call14>')
				chat:schedule(45,'/'..chatmode..' Yaegasumi is off <call14>')
			end
		end

	end
end)


windower.register_event('incoming text',function(org)

	if org:find('You find a') then
		if org:find('Fu\'s scale') then
			cmd('wait 2 5;input /'..chatmode..' Fu\'s Scale: BST, DRG, SMN, PUP <call14>')
		elseif org:find('Gin\'s scale') then
			cmd('wait 2 5;input /'..chatmode..' Gin\'s Scale: THF, NIN, DNC, RUN <call14>')
		elseif org:find('Kei\'s scale') then
			cmd('wait 2 5;input /'..chatmode..' Kei\'s Scale: WHM, BLM, RDM, BLU, SCH <call14>')
		elseif org:find('Kin\'s scale') then
			cmd('wait 2 5;input /'..chatmode..' Kin\'s Scale: WAR, MNK, PLD, DRK, SAM <call14>')
		elseif org:find('Kyou\'s scale') then
			cmd('wait 2 5;input /'..chatmode..' Kyou\'s Scale: BRD, RNG, COR, GEO <call14>')
		end

	elseif org:find('You pitiful lot will never learn') then
		cmd('input /'..chatmode..' Perfidien pop! <call14>')

	elseif org:find('the void calls') then
		cmd('input /'..chatmode..' Plouton pop! <call14>')

	elseif org:find('Hoho! Poked at a sore spot, didn\'t you?') or org:find('Switching things up, hmm?') then
		if org:find('Lightning') then
			cmd('input /'..chatmode..' Thunder <call14>')
		elseif org:find('Fire') then
			cmd('input /'..chatmode..' Fire <call14>')
		elseif org:find('Wind') then
			cmd('input /'..chatmode..' Aero <call14>')
		elseif org:find('Earth') then
			cmd('input /'..chatmode..' Stone <call14>')
		elseif org:find('Ice') then
			cmd('input /'..chatmode..' Blizzard <call14>')
		elseif org:find('Water') then
			cmd('input /'..chatmode..' Water <call14>')
		end

	end
end)


function display_help()
	windower.add_to_chat(200,'[Callouts] '..('Use \'//co chatmode\' to switch between Echo and Party chat modes'):color(8)..'')
	windower.add_to_chat(200,'[Callouts] '..('Current callouts:'):color(8)..'')
	windower.add_to_chat(200,'[Callouts] '..('Odyssey (Bumba 1-HRs)'):color(8)..'')
	windower.add_to_chat(200,'[Callouts] '..('Omen (Scales, Pain Sync, Target)'):color(8)..'')
	windower.add_to_chat(200,'[Callouts] '..('Vagary (Perfidien/Plouton pop, weaknesses'):color(8)..'')
	windower.add_to_chat(200,'[Callouts] '..('Sortie (weaknesses)'):color(8)..'')
end

windower.register_event('addon command', function(addcmd)

	if addcmd == 'help' then
		display_help()

	elseif addcmd == 'chatmode' then
		if chatmode == 'echo' then
			chatmode = 'p'
			windower.add_to_chat(200,'[Callouts] '..('Chat mode is now set to Party'):color(8)..'')
		else
			chatmode = 'echo'
			windower.add_to_chat(200,'[Callouts] '..('Chat mode is now set to Echo'):color(8)..'')
		end

	elseif addcmd == 'reload' then
        cmd('lua r callouts')
        return

	else
		windower.add_to_chat(200,'[Callouts] '..('Unknown command'):color(8)..'')
		display_help()
	end
	
end)
