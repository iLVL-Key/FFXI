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
_addon.version = '02.27.23'
_addon.author = 'Key'
_addon.commands = {'callouts','co'}

require 'logger'
config = require('config')
res = require 'resources'

defaults = {}
defaults.chatmode = 'echo'

settings = config.load(defaults)

local chat = windower.chat.input

windower.register_event('action',function(act)

	local actor = windower.ffxi.get_mob_by_id(act.actor_id)

	-- if act.category ~= 1 then
		-- print('(Actor: '..actor.name..') (Cat: '..act.category..') (Message: '..act.targets[1].actions[1].message..') (Param: '..act.targets[1].actions[1].param..')  (Target: '..target_name..')')
	-- end

	if act.category == 7 then -- initiation of weapon skill or monster TP move

		-- if actor.name == 'Locus Camelopard' then
			-- if res.monster_abilities[act.targets[1].actions[1].param] == nil then
				-- return
			-- else
				-- chat('/%s %s used %s on %s%s':format(settings.chatmode,actor.name,res.monster_abilities[act.targets[1].actions[1].param].en,target_name,settings.chatmode == 'party' and ' <call14>' or ''))
			-- end
		-- end

		if actor.name == 'Aita' or actor.name == 'Degei' then
			if res.monster_abilities[act.targets[1].actions[1].param] == nil then
				return
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Flaming Kick' then
				chat('/%s Water (Flaming Kick)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Flashflood' then
				chat('/%s Thunder (Flashflood)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Icy Grasp' then
				chat('/%s Fire (Icy Grasp)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Eroding Flesh' then
				chat('/%s Aero (Eroding Flesh)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Fulminous Smash' then
				chat('/%s Stone (Fulminous Smash)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor.name == 'Triboulex' or actor.name == 'Skomora' then
			if res.monster_abilities[act.targets[1].actions[1].param] == nil then
				return
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Last Laugh' then
				chat('/%s Hate Reset%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor.name == 'Aminon' then
			if res.monster_abilities[act.targets[1].actions[1].param] == nil then
				return
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Demonfire' then
				chat('/%s Water (Demonfire)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Torrential Pain' then
				chat('/%s Thunder (Torrential Pain)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Frozen Blood' then
				chat('/%s Fire (Frozen Blood)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Ensepulcher' then
				chat('/%s Aero (Ensepulcher)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Ceaseless Surge' then
				chat('/%s Stone (Ceaseless Surge)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Impudence' then
				chat('/%s HATE RESET (Impudence)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Blast of Reticence' then
				chat('/%s Blizzard (Blast of Reticence)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor.name == 'Glassy Thinker' then
			if res.monster_abilities[act.targets[1].actions[1].param] == nil then
				return
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Pain Sync' then
				chat('/%s PAIN SYNC%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor.name == 'Ou' or actor.name == 'Kin' then
			if res.monster_abilities[act.targets[1].actions[1].param] == nil then
				return
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Target' then
				chat('/%s Target used on %s%s':format(settings.chatmode,windower.ffxi.get_mob_by_id(act.targets[1].id).name,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Prophylaxis' then
				chat('/%s Prophylaxis - 30 second countdown to reset%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
				windower.send_command('wait 10;input /%s 20 seconds to reset%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
				windower.send_command('wait 20;input /%s 10 seconds to reset%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
				windower.send_command('wait 25;input /%s 5 seconds to reset%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor.name == 'Bumba' then
			if res.monster_abilities[act.targets[1].actions[1].param] == nil then
				return
			elseif res.job_abilities[act.targets[1].actions[1].param].en == 'Perfect Dodge' then
				chat('/%s Perfect Dodge%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
				chat:schedule(30,'/%s Perfect Dodge is off%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif res.job_abilities[act.targets[1].actions[1].param].en == 'Invincible' then
				chat('/%s Invincible%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
				chat:schedule(30,'/%s Invincible is off%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif res.job_abilities[act.targets[1].actions[1].param].en == 'Elemental Sforzo' then
				chat('/%s Elemental Sforzo%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
				chat:schedule(30,'/%s Elemental Sforzo is off%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif res.job_abilities[act.targets[1].actions[1].param].en == 'Yaegasumi' then
				chat('/%s Yaegasumi%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
				chat:schedule(30,'/%s Yaegasumi is off%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor.name == 'Kalunga' then
			if res.monster_abilities[act.targets[1].actions[1].param] == nil then
				return
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Volcanic Stasis' then
				chat('/%s Full Dispel%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor.name == 'Halphas' then
			if res.monster_abilities[act.targets[1].actions[1].param] == nil then
				return
			elseif res.monster_abilities[act.targets[1].actions[1].param].en == 'Full-On Tackle' then
				chat('/%s HATE RESET%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		end
	end
end)


windower.register_event('incoming text',function(org)

	if org:find('You find a') then
		if org:find('Fu\'s scale') then
			chat('/%s Fu\'s Scale: BST, DRG, SMN, PUP%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('Gin\'s scale') then
			chat('/%s Gin\'s Scale: THF, NIN, DNC, RUN%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('Kei\'s scale') then
			chat('/%s Kei\'s Scale: WHM, BLM, RDM, BLU, SCH%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('Kin\'s scale') then
			chat('/%s Kin\'s Scale: WAR, MNK, PLD, DRK, SAM%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('Kyou\'s scale') then
			chat('/%s Kyou\'s Scale: BRD, RNG, COR, GEO%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
		end

	elseif org:find('You pitiful lot will never learn') then
		chat('/%s Perfidien pop!%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))

	elseif org:find('the void calls') then
		chat('/%s Plouton pop!%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))

	elseif org:find('Hoho! Poked at a sore spot, didn\'t you?') or org:find('Switching things up, hmm?') then
		if org:find('Lightning') then
			chat('/%s Thunder%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('Fire') then
			chat('/%s Fire%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('Wind') then
			chat('/%s Aero%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('Earth') then
			chat('/%s Stone%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('Ice') then
			chat('/%s Blizzard%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('Water') then
			chat('/%s Water%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
		end

	end
end)

windower.register_event('addon command', function(addcmd)

	if addcmd == 'help' then
		windower.add_to_chat(200,'[Callouts] '..('Use \'//co chatmode\' to switch between Echo and Party chat modes.'):color(8)..'')
		windower.add_to_chat(200,'[Callouts] '..('Current callouts:'):color(8)..'')
		windower.add_to_chat(200,'[Callouts] '..('Odyssey (Bumba 1-HRs)'):color(8)..'')
		windower.add_to_chat(200,'[Callouts] '..('Dyna-D (Halphas hate reset)'):color(8)..'')
		windower.add_to_chat(200,'[Callouts] '..('Omen (Scales, Pain Sync, Prophylaxis, Target)'):color(8)..'')
		windower.add_to_chat(200,'[Callouts] '..('Vagary (Perfidien/Plouton pop, weaknesses'):color(8)..'')
		windower.add_to_chat(200,'[Callouts] '..('Sortie (weaknesses, hate resets)'):color(8)..'')

	elseif addcmd == 'chatmode' or addcmd == 'chat' or addcmd == 'mode' then
		if settings.chatmode == 'echo' then
			settings.chatmode = 'party'
			windower.add_to_chat(200,'[Callouts] '..('Chat mode is now set to Party.'):color(8)..'')
			settings:save()
		else
			settings.chatmode = 'echo'
			windower.add_to_chat(200,'[Callouts] '..('Chat mode is now set to Echo.'):color(8)..'')
			settings:save()
		end

	elseif addcmd == 'reload' then
        windower.send_command('lua r callouts')
        return

	else
		windower.add_to_chat(200,'[Callouts] '..('Unknown command'):color(8)..'')
		windower.add_to_chat(200,'[Callouts] '..('Type \'//co help\' for help.'):color(8)..'')
	end
	
end)
