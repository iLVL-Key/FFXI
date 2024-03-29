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
_addon.version = '1.6'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'callouts','co'}

require 'logger'
config = require('config')
res = require 'resources'

defaults = {}
defaults.chatmode = 'echo'

settings = config.load(defaults)

local chat = windower.chat.input

windower.register_event('action',function(act)

	local actor = (act.actor_id and windower.ffxi.get_mob_by_id(act.actor_id)) or 'unknown'
	if type(actor) == "table" then
		actor = actor.name
	end

	local monster_ability = res.monster_abilities[act.targets[1].actions[1].param]
	local spell_start = res.spells[act.targets[1].actions[1].param]

	-- A player is charmed
	if act.category == 11 and (act.targets[1].actions[1].param == 14 or act.targets[1].actions[1].param == 17) and act.targets[1].actions[1].message == 242 then
		chat(('/%s \r \r'..windower.ffxi.get_mob_by_id(act.targets[1].id).name..' is charmed!%s\r \r'):format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
	end




	-- if actor == 'Bumba' or actor == 'Bozzetto Autarch' then
	if actor == 'Bumba' then
		chat('/echo (Actor: '..actor..') (Cat: '..act.category..') (Param: '..act.param..') (Msg: '..act.targets[1].actions[1].message..') (target.actions.param: '..act.targets[1].actions[1].param..') (Target: '..windower.ffxi.get_mob_by_id(act.targets[1].id).name..')')
	end




	if act.category == 8 then
		if actor == 'Bozzetto Autarch' then
			if spell_start == nil then
				return
			elseif spell_start.en == 'Katon: San' then
				chat('/%s Mijin Gakure: 6%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif spell_start.en == 'Suiton: San' then
				chat('/%s Mijin Gakure: 5%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif spell_start.en == 'Raiton: San' then
				chat('/%s Mijin Gakure: 4%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif spell_start.en == 'Doton: San' then
				chat('/%s Mijin Gakure: 3%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif spell_start.en == 'Huton: San' then
				chat('/%s Mijin Gakure: 2%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif spell_start.en == 'Hyoton: San' then
				chat('/%s Mijin Gakure: 1%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end
		end
	end

	if act.category == 7 then -- initiation of weapon skill or monster TP move

		-- if actor == 'Locus Camelopard' then
			-- if monster_ability == nil then
				-- return
			-- else
				-- chat('/%s %s used %s on %s%s':format(settings.chatmode,actor,monster_ability.en,target_name,settings.chatmode == 'party' and ' <call14>' or ''))
			-- end
		-- end

		-- if actor == 'Locus Dire Bat' then
		-- 	if monster_ability == nil then
		-- 		return
		-- 	else
		-- 		chat('/%s %s used %s%s':format(settings.chatmode,actor,monster_ability.en,settings.chatmode == 'party' and ' <call14>' or ''))
		-- 	end
		-- end

		if actor == 'Aita' or actor == 'Degei' then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Flaming Kick' then
				chat('/%s Water (Flaming Kick)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Flashflood' then
				chat('/%s Thunder (Flashflood)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Icy Grasp' then
				chat('/%s Fire (Icy Grasp)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Eroding Flesh' then
				chat('/%s Aero (Eroding Flesh)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Fulminous Smash' then
				chat('/%s Stone (Fulminous Smash)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Glassy Craver' then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Impalement' then
				chat('/%s Hate Reset%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Triboulex' or actor == 'Skomora' then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Last Laugh' then
				chat('/%s Hate Reset%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Leshonn' or actor == 'Gartell' then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Undulating Shockwave' or monster_ability.en == 'Shrieking Gale' then
				chat('/%s Switching to %s%s':format(settings.chatmode,monster_ability.en == 'Undulating Shockwave' and 'Ice' or 'Stone',settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Aminon' then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Demonfire' then
				chat('/%s Water (Demonfire)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Torrential Pain' then
				chat('/%s Thunder (Torrential Pain)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Frozen Blood' then
				chat('/%s Fire (Frozen Blood)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Ensepulcher' then
				chat('/%s Aero (Ensepulcher)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Ceaseless Surge' then
				chat('/%s Stone (Ceaseless Surge)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Impudence' then
				chat('/%s Hate Reset (Impudence)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Blast of Reticence' then
				chat('/%s Blizzard (Blast of Reticence)%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Glassy Thinker' then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Pain Sync' then
				chat('/%s PAIN SYNC%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Ou' or actor == 'Kin' then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Target' then
				chat('/%s Target used on %s%s':format(settings.chatmode,windower.ffxi.get_mob_by_id(act.targets[1].id).name,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Prophylaxis' then
				chat('/%s Prophylaxis - 30 second countdown to reset%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
				windower.send_command('wait 10;input /%s 20 seconds to reset%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
				windower.send_command('wait 20;input /%s 10 seconds to reset%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
				windower.send_command('wait 25;input /%s 5 seconds to reset%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Arebati' then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Glassy Nova' then
				chat('/%s Full Dispel%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Bumba' then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Perfect Dodge' then
				chat('/%s Perfect Dodge%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
				chat:schedule(30,'/%s Perfect Dodge is off%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Invincible' then
				chat('/%s Invincible%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
				chat:schedule(30,'/%s Invincible is off%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Elemental Sforzo' then
				chat('/%s Elemental Sforzo%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
				chat:schedule(30,'/%s Elemental Sforzo is off%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Yaegasumi' then
				chat('/%s Yaegasumi%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
				chat:schedule(30,'/%s Yaegasumi is off%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Gigelorum' then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Debilitating Spout' then
				chat('/%s Full Dispel%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Henwen' then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Barreling Smash' then
				chat('/%s Hate Reset%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Kalunga' then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Volcanic Stasis' then
				chat('/%s Full Dispel%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Blistering Roar' then
				chat('/%s Fetters incoming!%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Mboze' then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Uproot' then
				chat('/%s Hate Reset%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Ngai' then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Protolithic Puncture' then
				chat('/%s Hate Reset%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Carcharian Verve' then
				chat('/%s Fetters incoming!%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Xevioso' then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Incisive Denouement' then
				chat('/%s Hate Reset%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Halphas' then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Full-On Tackle' then
				chat('/%s Hate Reset%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Bozzetto Crusader' then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Veil of Chaos' or monster_ability.en == 'Veil of Disarray' then
				chat('/%s Hate Reset%s':format(settings.chatmode,settings.chatmode == 'party' and ' <call14>' or ''))
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

	elseif org:find('the void calls') and windower.ffxi.get_info().zone ~= 277 then
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
		windower.add_to_chat(220,'[Callouts] '..('Version '):color(8)..(_addon.version):color(220)..(', by '):color(8)..('Key (Keylesta@Valefor)'):color(220))
		windower.add_to_chat(220,' ')
		windower.add_to_chat(200,' Addon Commands'..(' (prefixed with'):color(8)..(' //callouts'):color(1)..(' or'):color(8)..(' //co'):color(1)..('):'):color(8))
		windower.add_to_chat(36,'   chatmode/chat/mode'..(' - Switch between Echo and Party chat modes.'):color(8)..'')
		windower.add_to_chat(36,'   list'..(' - List the current callouts.'):color(8)..'')

	elseif addcmd == 'chatmode' or addcmd == 'chat' or addcmd == 'mode' then
		if settings.chatmode == 'echo' then
			settings.chatmode = 'party'
		else
			settings.chatmode = 'echo'
		end
		windower.add_to_chat(220,'[Callouts] '..(('Chat mode is now set to %s.'):format(settings.chatmode == 'party' and 'Party' or 'Echo')):color(8)..'')
		settings:save()

	elseif addcmd == 'list' or addcmd == 'lists' then
		windower.add_to_chat(220,'[Callouts] '..('Current callouts:'):color(200)..'')
		windower.add_to_chat(36,'   General'..(' - Charm'):color(8)..'')
		windower.add_to_chat(36,'   Odyssey'..(' - Hate resets, full dispels, Bumba 1-HRs (beta), Kalunga/Ngai fetters'):color(8)..'')
		windower.add_to_chat(36,'   Dyna-D'..(' - Halphas hate reset'):color(8)..'')
		windower.add_to_chat(36,'   Omen'..(' - Scales, Pain Sync, Prophylaxis, Target'):color(8)..'')
		windower.add_to_chat(36,'   Vagary'..(' - Perfidien/Plouton pop, weaknesses'):color(8)..'')
		windower.add_to_chat(36,'   Sortie'..(' - Elements/weaknesses, hate resets'):color(8)..'')
		windower.add_to_chat(36,'   Ambuscade'..(' - Bozzetto Autarch Mijin Gakure'):color(8)..'')

	elseif addcmd == 'reload' then
		windower.send_command('lua r callouts')
		return

	else
		windower.add_to_chat(220,'[Callouts] '..('Unknown command. Type \'//co help\' for list of commands.'):color(8)..'')
	end
	
end)
