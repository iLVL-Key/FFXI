--Copyright (c) 2025, Key
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
_addon.version = '2.0'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'callouts','co'}

require 'logger'
config = require('config')
res = require 'resources'

get_mob_by_id = windower.ffxi.get_mob_by_id
add_to_chat = windower.add_to_chat
input = windower.chat.input
get_mob_by_target = windower.ffxi.get_mob_by_target
get_info = windower.ffxi.get_info
register_event = windower.register_event
get_mob_by_name = windower.ffxi.get_mob_by_name

defaults = {}
defaults.chatmode = 'echo'
defaults.call_num = 14
defaults.galli_segs_after_zone_delay = 6
defaults.callouts = {
	abyssea = true,
	ambuscade = true,
	charm = true,
	htmb = true,
	dynamis = true,
	odyssey = true,
	omen = true,
	sortie = true,
	vagary = true
}

settings = config.load(defaults)

callout = settings.callouts
chatmode = settings.chatmode
call_num = settings.call_num
call = chatmode == 'party' and ' <call'..call_num..'>' or ''
Heartbeat = 0

charmed = T{}

gallimaufry = 0
segments = 0

--These track each Omen boss and their moves so we know which is the next one
craver_pop = false
gorger_pop = false
thinker_pop = false
fu_pop = false
fu_claimed = false
fu_used = {
	ebullient_at_100 = false,
	ebullient_at_75 = false,
	ebullient_at_50 = false,
	ebullient_at_25 = false,
}
kyou_pop = false
kyou_claimed = false
kyou_used = {
	bravado_at_75 = false,
	bravado_at_50 = false,
	bravado_at_25 = false,
}
kei_pop = false
kei_claimed = false
kei_used = {
	fullers_at_75 = false,
	fullers_at_50 = false,
	fullers_at_25 = false,
}
gin_pop = false
gin_claimed = false
gin_used = {
	zero_hour_at_75 = false,
	zero_hour_at_50 = false,
	zero_hour_at_25 = false,
}
kin_pop = false
kin_claimed = false
kin_used = {
	target_at_75 = false,
	target_at_50 = false,
	target_at_25 = false,
}
ou_pop = false
ou_claimed = false
statuses_drained = 0

--Sortie bosses
aita_claimed = false
degei_claimed = false
skomora_claimed = false
triboulex_claimed = false

--Aurix (Dynamis)
aurix_pop = false
aurix_hpp = 0
aurix_is_warping = false
aurix_last_distance = 0
aurix_last_hpp = 100

zone_bosses = {
	["Overseer's Tombstone"] = true,
	["Halphas"] = true,
	["Mu'Sha Effigy"] = true,
	["Ka'Rho Fearsinger"] = true,
	["Envincing Idol"] = true,
	["Fii Pexu the Eternal"] = true,
	["Impish Golem"] = true,
	["Obstatrix"] = true,
}

--Watch for and callout Omen boss moves
function omenCallouts()

	--Define Boss names
	local mob_names = {
		["Glassy Craver"] = "craver",
		["Glassy Gorger"] = "gorger",
		["Glassy Thinker"] = "thinker",
		["Fu"] = "fu",
		["Kyou"] = "kyou",
		["Kei"] = "kei",
		["Gin"] = "gin",
		["Kin"] = "kin",
		["Ou"] = "ou",
	}
	local mob_nearby = {} --Store boss that is nearby (will only ever be one at a time)

	--Loop through mobs in memory to look for designated bosses
	for _, mob in pairs(windower.ffxi.get_mob_array()) do
		local name = mob_names[mob.name]
		if name and mob.valid_target then
			mob_nearby[name] = true
			break --stop after first match
		end
	end

	if mob_nearby.craver then
		local craver = get_mob_by_name('Glassy Craver')
		if not craver_pop and craver.hpp ~= 0 then --Glassy Craver first shows up
			craver_pop = true
			input('/%s View Sync: 25\' range, suck-in --> knock-back%s':format(chatmode, call))
		elseif craver.hpp == 0 then
			craver_pop = false
		end
	elseif mob_nearby.gorger then
		local gorger = get_mob_by_name('Glassy Gorger')
		if not gorger_pop and gorger.hpp ~= 0 then --Glassy Gorger first shows up
			gorger_pop = true
			input('/%s Blessing Sync: 10\' range, copies all buffs (incl. Dematerialize and Aftermath)%s':format(chatmode, call))
		elseif gorger.hpp == 0 then
			gorger_pop = false
		end
	elseif mob_nearby.thinker then
		local thinker = get_mob_by_name('Glassy Thinker')
		if not thinker_pop and thinker.hpp ~= 0 then --Glassy Thinker first shows up
			thinker_pop = true
			input('/%s Pain Sync: 20\' range, use Earthen Armor or Scherzo plus lots of debuff spam (Impact/Comet)%s':format(chatmode, call))
		elseif thinker.hpp == 0 then
			thinker_pop = false
		end
	elseif mob_nearby.fu then
		local fu = get_mob_by_name('Fu')
		if not fu_pop and fu.hpp ~= 0 then --Fu first shows up
			fu_pop = true
			input('/%s 100, 75, 50, 25, 10%% - Ebullient Nullification: Absorbs all buffs within 20\' AoE (sweet spot: 5~8 buffs)%s':format(chatmode, call))
		elseif not fu_claimed and fu.claim_id ~= 0 and fu.hpp ~= 0 then --Claimed, start of fight
			fu_claimed = true
		elseif fu_claimed and (fu.hpp == 0 or (fu.claim_id == 0 and fu.hpp == 100)) then --Reset if defeated or wiped
			fu_pop = false
			fu_claimed = false
			fu_used = {
				ebullient_at_100 = false,
				ebullient_at_75 = false,
				ebullient_at_50 = false,
				ebullient_at_25 = false,
			}
		end
	elseif mob_nearby.kyou then
		local kyou = get_mob_by_name('Kyou')
		if not kyou_pop and kyou.hpp ~= 0 then --Kyou first shows up
			kyou_pop = true
			input('/%s 75, 50, 25, 10%% - Unfaltering Bravado: Conal 10k damage split (line up behind tank)%s':format(chatmode, call))
		elseif not kyou_claimed and kyou.claim_id ~= 0 and kyou.hpp ~= 0 then --Claimed, start of fight
			kyou_claimed = true
		elseif kyou_claimed and (kyou.hpp == 0 or (kyou.claim_id == 0 and kyou.hpp == 100)) then --Reset if defeated or wiped
			kyou_pop = false
			kyou_claimed = false
			kyou_used = {
				bravado_at_75 = false,
				bravado_at_50 = false,
				bravado_at_25 = false,
			}
		end
	elseif mob_nearby.kei then
		local kei = get_mob_by_name('Kei')
		if not kei_pop and kei.hpp ~= 0 then --Kei first shows up
			kei_pop = true
			input('/%s 75, 50, 25, 10%% - Dancing Fullers: 2500 additive damage per player/pet hit dealt to each within 10\' AoE%s':format(chatmode, call))
		elseif not kei_claimed and kei.claim_id ~= 0 and kei.hpp ~= 0 then --Claimed, start of fight
			kei_claimed = true
		elseif kei_claimed and (kei.hpp == 0 or (kei.claim_id == 0 and kei.hpp == 100)) then --Reset if defeated or wiped
			kei_pop = false
			kei_claimed = false
			kei_used = {
				fullers_at_75 = false,
				fullers_at_50 = false,
				fullers_at_25 = false,
			}
		end
	elseif mob_nearby.gin then
		local gin = get_mob_by_name('Gin')
		if not gin_pop and gin.hpp ~= 0 then --Gin first shows up
			gin_pop = true
			input('/%s 75, 50, 25, 10%% - Zero Hour: Throat-Stab, hate reset within 10\' AoE%s':format(chatmode, call))
		elseif not gin_claimed and gin.claim_id ~= 0 and gin.hpp ~= 0 then --Claimed, start of fight
			gin_claimed = true
		elseif gin_claimed and (gin.hpp == 0 or (gin.claim_id == 0 and gin.hpp == 100)) then --Reset if defeated or wiped
			gin_pop = false
			gin_claimed = false
			gin_used = {
				zero_hour_at_75 = false,
				zero_hour_at_50 = false,
				zero_hour_at_25 = false,
			}
		end
	elseif mob_nearby.kin then
		local kin = get_mob_by_name('Kin')
		if not kin_pop and kin.hpp ~= 0 then --Kin first shows up
			kin_pop = true
			input('/%s 75, 50, 25, 10%% - Target: Switch hate after Target lands or 3min Terror%s':format(chatmode, call))
		elseif not kin_claimed and kin.claim_id ~= 0 and kin.hpp ~= 0 then --Claimed, start of fight
			kin_claimed = true
		elseif kin_claimed and (kin.hpp == 0 or (kin.claim_id == 0 and kin.hpp == 100)) then --Reset if defeated or wiped
			kin_pop = false
			kin_claimed = false
			kin_used = {
				target_at_75 = false,
				target_at_50 = false,
				target_at_25 = false,
			}
		end
	elseif mob_nearby.ou then
		local ou = get_mob_by_name('Ou')
		if not ou_pop and ou.hpp ~= 0 then --Ou first shows up
			ou_pop = true
			input('/%s 95%%:Ebullient 75%%:Bravado 60%%:Fullers 45%%:Zero Hour 30%%:Target 15%%:Gardez 10%%:Prophalaxis':format(chatmode))
		elseif not ou_claimed and ou.claim_id ~= 0 and ou.hpp ~= 0 then --Claimed, start of fight
			ou_claimed = true
			input('/%s First up @ 95%% - Ebullient Nullification: Absorbs all buffs within 20\' AoE (sweet spot: 5~8 buffs)%s':format(chatmode, call))
		elseif ou_claimed and (ou.hpp == 0 or (ou.claim_id == 0 and ou.hpp == 100)) then --Reset if defeated or wiped
			ou_pop = false
			ou_claimed = false
		end

	end
end

--Start up the 3 minute "rage" timer that a few different bosses have
function start3MinuteTimer(mob_name)
	input('/%s 3 Minute Timer started%s':format(chatmode, call))
	coroutine.schedule(function()
		if get_mob_by_name(mob_name) and get_mob_by_name(mob_name).hpp ~= 0 then
			input('/%s 1 minute remaining%s':format(chatmode, call))
			coroutine.schedule(function()
				if get_mob_by_name(mob_name) and get_mob_by_name(mob_name).hpp ~= 0 then
					input('/%s 30 seconds remaining%s':format(chatmode, call))
					coroutine.schedule(function()
						if get_mob_by_name(mob_name) and get_mob_by_name(mob_name).hpp ~= 0 then
							input('/%s 20 seconds remaining%s':format(chatmode, call))
							coroutine.schedule(function()
								if get_mob_by_name(mob_name) and get_mob_by_name(mob_name).hpp ~= 0 then
									input('/%s 10 seconds remaining%s':format(chatmode, call))
									coroutine.schedule(function()
										if get_mob_by_name(mob_name) and get_mob_by_name(mob_name).hpp ~= 0 then
											input('/%s Window open%s':format(chatmode, call))
										end
									end, 10)
								end
							end, 10)
						end
					end, 10)
				end
			end, 30)
		end
	end, 120)
end

--Watch for and callout Sortie boss moves
function sortieCallouts()

	--Define Boss names
	local mob_names = {
		["Aita"] = "aita",
		["Degei"] = "degei",
		["Triboulex"] = "triboulex",
		["Skomora"] = "skomora",
	}
	local mob_nearby = {} --Store boss that is nearby (will only ever be one at a time)

	--Loop through mobs in memory to look for designated bosses
	for _, mob in pairs(windower.ffxi.get_mob_array()) do
		local name = mob_names[mob.name]
		if name and mob.valid_target then
			mob_nearby[name] = true
			break --stop after first match
		end
	end

	if mob_nearby.aita then
		local aita = get_mob_by_name('Aita')
		--Claimed, start the timer
		if aita.claim_id ~= 0 and aita.hpp ~= 0 and not aita_claimed then
			aita_claimed = true
			start3MinuteTimer('Aita')
		end
		--Reset if defeated/wipe
		if (aita_claimed and aita.hpp == 0) or (aita.claim_id == 0 and aita.hpp == 100) then
			aita_claimed = false
		end
	elseif mob_nearby.degei then
		local degei = get_mob_by_name('Degei')
		--Claimed, start the timer
		if degei.claim_id ~= 0 and degei.hpp ~= 0 and not degei_claimed then
			degei_claimed = true
			start3MinuteTimer('Degei')
		end
		--Reset if defeated/wipe
		if (degei_claimed and degei.hpp == 0) or (degei.claim_id == 0 and degei.hpp == 100) then
			degei_claimed = false
		end
	elseif mob_nearby.triboulex then
		local triboulex = get_mob_by_name('Triboulex')
		--Claimed, start the timer
		if triboulex.claim_id ~= 0 and triboulex.hpp ~= 0 and not triboulex_claimed then
			triboulex_claimed = true
			start3MinuteTimer('Triboulex')
		end
		--Reset if defeated/wipe
		if (triboulex_claimed and triboulex.hpp == 0) or (triboulex.claim_id == 0 and triboulex.hpp == 100) then
			triboulex_claimed = false
		end
	elseif mob_nearby.skomora then
		local skomora = get_mob_by_name('Skomora')
		--Claimed, start the timer
		if skomora.claim_id ~= 0 and skomora.hpp ~= 0 and not skomora_claimed then
			skomora_claimed = true
			start3MinuteTimer('Skomora')
		end
		--Reset if defeated/wipe
		if (skomora_claimed and skomora.hpp == 0) or (skomora.claim_id == 0 and skomora.hpp == 100) then
			skomora_claimed = false
		end
	end

end

--Scan memory for Aurix
function scanForAurix()
	local aurix = nil
	local zone_boss_status = { found = false, dead = false }

	for _, mob in pairs(windower.ffxi.get_mob_array()) do
		if mob.valid_target then
			if mob.name == 'Aurix' then
				aurix = {
					hpp = mob.hpp,
					distance = math.floor(mob.distance:sqrt() * 100) / 100,
				}
			elseif zone_bosses[mob.name] then
				zone_boss_status.found = true
				if mob.hpp == 0 then
					zone_boss_status.dead = true
				end
			end
		end

		if aurix and zone_boss_status.found then
			break
		end
	end

	--Discard Aurix if it popped while boss is dead
	if aurix and zone_boss_status.dead then
		aurix = nil
	end

	return aurix 
end

--Watch for and callout Aurix
function aurixCallouts()

	if aurix_is_warping then return end

	local aurix = scanForAurix()
	aurix_last_distance = aurix and aurix.distance or aurix_last_distance
	aurix_last_hpp = aurix and aurix.hpp or aurix_last_hpp

	--Announce Aurix pop as long as a Spawner is also nearby
	if aurix and not aurix_pop and aurix_last_hpp ~= 0 then
		aurix_pop = true
		input('/%s Aurix pop!%s':format(chatmode, call))

	--Announce Aurix running as long as we're not moving out of range of targeting him (50 is out of range)
	elseif not aurix and aurix_pop and aurix_last_distance <= 49 then
		aurix_pop = false
		input('/%s Aurix ran with %s%% HP!%s':format(chatmode, aurix_last_hpp, call))

	--Announce Aurix defeated
	elseif aurix and aurix_pop and aurix.hpp == 0 then
		aurix_pop = false
		input('/%s Aurix defeated!%s':format(chatmode, call))
	end

end

--Check memory for any party/alliance member that is charmed
function checkForCharm()

	local just_charmed = {}
	local ally_pos = {
		'p0', 'p1', 'p2', 'p3', 'p4', 'p5',
		'a10', 'a11', 'a12', 'a13', 'a14', 'a15',
		'a20', 'a21', 'a22', 'a23', 'a24', 'a25'
	}

	for _, pos in ipairs(ally_pos) do
		local member = get_mob_by_target(pos)
		if member and not member.is_npc then
			local name = member.name
			local is_charmed = member.charmed

			if is_charmed and not charmed[name] then
				table.insert(just_charmed, name)
				charmed[name] = true
			elseif not is_charmed and charmed[name] then
				charmed[name] = nil
			end
		end
	end

	if #just_charmed > 0 then
		input(('/%s \r \r Charmed: %s%s\r \r'):format(chatmode, table.concat(just_charmed, ", "), call))
	end
end

--Check for any abilities that Ebullient Nullification has drained
function checkForEbullient()

	if statuses_drained > 0 then
		input(('/%s Ebullient Status Effects Drained Total: %s%s'):format(chatmode, statuses_drained, call))
		statuses_drained = 0
	end

end

--Add commas to numbers to make them easier to read
function addCommas(number)

	--Convert the number to a string
	local formatted_number = tostring(number)
	local length = #formatted_number

	if length > 3 then
		local insert_index = length % 3
		if insert_index == 0 then
			insert_index = 3
		end

		while insert_index < length do
			formatted_number = formatted_number:sub(1, insert_index)..","..formatted_number:sub(insert_index + 1)
			insert_index = insert_index + 4
			length = length + 1
		end
	end

	--Return the number (albeit as a string, we're not doing any math on it at this point)
	return formatted_number

end

register_event('action',function(act)

	local mob = act.actor_id and get_mob_by_id(act.actor_id)
	local actor = mob and mob.name
	if not actor then return end

	if act.category == 11 then
		local m_abil = res.monster_abilities[act.param]
		if not m_abil then return end

		if callout.odyssey then
			local boss_set = {
				["Dealan-dhe"] = true, ["Sgili"] = true, ["U Bnai"] = true, ["Gogmagog"] = true,
				["Aristaeus"] = true, ["Raskovniche"] = true, ["Marmorkrebs"] = true, ["Gigelorum"] = true,
				["Procne"] = true, ["Henwen"] = true, ["Xevioso"] = true, ["Ngai"] = true,
				["Kalunga"] = true, ["Ongo"] = true, ["Mboze"] = true, ["Arebati"] = true, ["Bumba"] = true,
			}

			if boss_set[actor] then
				local ability = m_abil.en
				local duration = nil

				if ability == 'Perfect Dodge' or ability == 'Invincible' or ability == 'Elemental Sforzo' then
					input('/%s %s%s':format(chatmode, ability, call))
					duration = 30
				elseif ability == 'Yaegasumi' then
					input('/%s Yaegasumi%s':format(chatmode, call))
					duration = 45
				elseif actor == 'Bumba' and ability == 'Brazen Rush' then
					input('/%s Brazen Rush%s':format(chatmode, call))
				end

				if duration then
					input:schedule(duration - 5, '/%s %s off in 5 seconds%s':format(chatmode, ability, call))
					input:schedule(duration, '/%s %s is off%s':format(chatmode, ability, call))
				end
			end
		end

		if callout.ambuscade then
			if m_abil and actor == 'Dullahan Axegrinder' then
				if m_abil.en == 'Nether Castigation' then
					input('/%s Rage is over%s':format(chatmode, call))
				end
			end
		end

	elseif act.category == 8 then
		local spell = res.spells[act.targets[1].actions[1].param]
		if not spell then return end

		if callout.ambuscade then
			if actor == 'Bozzetto Autarch' then
				if spell.en == 'Katon: San' then
					input('/%s Mijin Gakure: 6%s':format(chatmode, call))
				elseif spell.en == 'Suiton: San' then
					input('/%s Mijin Gakure: 5%s':format(chatmode, call))
				elseif spell.en == 'Raiton: San' then
					input('/%s Mijin Gakure: 4%s':format(chatmode, call))
				elseif spell.en == 'Doton: San' then
					input('/%s Mijin Gakure: 3%s':format(chatmode, call))
				elseif spell.en == 'Huton: San' then
					input('/%s Mijin Gakure: 2%s':format(chatmode, call))
				elseif spell.en == 'Hyoton: San' then
					input('/%s Mijin Gakure: 1%s':format(chatmode, call))
				end
			end
		end

		if callout.dynamis then
			if actor == 'Aurix' and spell.en == 'Warp' then
				aurix_is_warping = true
			end
		end

	elseif act.category == 7 then
		local m_abil = res.monster_abilities[act.targets[1].actions[1].param]
		if not m_abil then return end

		if callout.sortie then
			if (actor == 'Aita' or actor == 'Degei') then
				if m_abil.en == 'Flaming Kick' then
					input('/%s Water (Flaming Kick)%s':format(chatmode, call))
				elseif m_abil.en == 'Flashflood' then
					input('/%s Thunder (Flashflood)%s':format(chatmode, call))
				elseif m_abil.en == 'Icy Grasp' then
					input('/%s Fire (Icy Grasp)%s':format(chatmode, call))
				elseif m_abil.en == 'Eroding Flesh' then
					input('/%s Aero (Eroding Flesh)%s':format(chatmode, call))
				elseif m_abil.en == 'Fulminous Smash' then
					input('/%s Stone (Fulminous Smash)%s':format(chatmode, call))
				elseif m_abil.en == 'Vivisection' then
					start3MinuteTimer(actor)
				end

			elseif (actor == 'Triboulex' or actor == 'Skomora') then
				if m_abil.en == 'Last Laugh' then
					input('/%s Hate Reset%s':format(chatmode, call))
				elseif m_abil.en == 'Setting The Stage' then
					start3MinuteTimer(actor)
				end

			elseif (actor == 'Leshonn' or actor == 'Gartell') then
				if m_abil.en == 'Undulating Shockwave' or m_abil.en == 'Shrieking Gale' then
					input('/%s Switching to %s%s':format(chatmode,m_abil.en == 'Undulating Shockwave' and 'Ice' or 'Stone', call))
				end

			elseif actor == 'Aminon' then
				if m_abil.en == 'Demonfire' then
					input('/%s Water (Demonfire)%s':format(chatmode, call))
				elseif m_abil.en == 'Torrential Pain' then
					input('/%s Thunder (Torrential Pain)%s':format(chatmode, call))
				elseif m_abil.en == 'Frozen Blood' then
					input('/%s Fire (Frozen Blood)%s':format(chatmode, call))
				elseif m_abil.en == 'Ensepulcher' then
					input('/%s Aero (Ensepulcher)%s':format(chatmode, call))
				elseif m_abil.en == 'Ceaseless Surge' then
					input('/%s Stone (Ceaseless Surge)%s':format(chatmode, call))
				elseif m_abil.en == 'Impudence' then
					input('/%s Hate Reset (Impudence)%s':format(chatmode, call))
				elseif m_abil.en == 'Blast of Reticence' then
					input('/%s Blizzard (Blast of Reticence)%s':format(chatmode, call))
				end
			end
		end

		if callout.omen then
			if actor == 'Glassy Craver' then
				if m_abil.en == 'Impalement' then
					input('/%s Hate Reset%s':format(chatmode, call))
				end

			elseif actor == 'Glassy Thinker' then
				if m_abil.en == 'Pain Sync' then
					input('/%s PAIN SYNC%s':format(chatmode, call))
				end

			elseif actor == 'Fu' then
				if m_abil.en == 'Ebullient Nullification' then
					if not fu_used.ebullient_at_100 then
						fu_used.ebullient_at_100 = true
						input('/%s Next Ebullient Nullification @ 75%%%s':format(chatmode, call))
					elseif not fu_used.ebullient_at_75 then
						fu_used.ebullient_at_75 = true
						input('/%s Next Ebullient Nullification @ 50%%%s':format(chatmode, call))
					elseif not fu_used.ebullient_at_50 then
						fu_used.ebullient_at_50 = true
						input('/%s Next Ebullient Nullification @ 25%%%s':format(chatmode, call))
					elseif not fu_used.ebullient_at_25 then
						fu_used.ebullient_at_25 = true
						input('/%s Next Ebullient Nullification @ 10%%%s':format(chatmode, call))
					end
				end

			elseif actor == 'Kyou' then
				if m_abil.en == 'Unfaltering Bravado' then
					if not kyou_used.bravado_at_75 then
						kyou_used.bravado_at_75 = true
						input('/%s Next Unfaltering Bravado @ 50%%%s':format(chatmode, call))
					elseif not kyou_used.bravado_at_50 then
						kyou_used.bravado_at_50 = true
						input('/%s Next Unfaltering Bravado @ 25%%%s':format(chatmode, call))
					elseif not kyou_used.bravado_at_25 then
						kyou_used.bravado_at_25 = true
						input('/%s Next Unfaltering Bravado @ 10%%%s':format(chatmode, call))
					end
				end

			elseif actor == 'Kei' then
				if m_abil.en == 'Dancing Fullers' then
					if not kei_used.fullers_at_75 then
						kei_used.fullers_at_75 = true
						input('/%s Next Dancing Fullers @ 50%%%s':format(chatmode, call))
					elseif not kei_used.fullers_at_50 then
						kei_used.fullers_at_50 = true
						input('/%s Next Dancing Fullers @ 25%%%s':format(chatmode, call))
					elseif not kei_used.fullers_at_25 then
						kei_used.fullers_at_25 = true
						input('/%s Next Dancing Fullers @ 10%%%s':format(chatmode, call))
					end
				end

			elseif actor == 'Gin' then
				if m_abil.en == 'Zero Hour' then
					if not gin_used.zero_hour_at_75 then
						gin_used.zero_hour_at_75 = true
						input('/%s Next Zero Hour @ 50%%%s':format(chatmode, call))
					elseif not gin_used.zero_hour_at_50 then
						gin_used.zero_hour_at_50 = true
						input('/%s Next Zero Hour @ 25%%%s':format(chatmode, call))
					elseif not gin_used.zero_hour_at_25 then
						gin_used.zero_hour_at_25 = true
						input('/%s Next Zero Hour @ 10%%%s':format(chatmode, call))
					end
				end

			elseif actor == 'Kin' then
				if m_abil.en == 'Target' then
					if not kin_used.target_at_75 then
						kin_used.target_at_75 = true
						input('/%s Next Target @ 50%%%s':format(chatmode, call))
					elseif not kin_used.target_at_50 then
						kin_used.target_at_50 = true
						input('/%s Next Target @ 25%%%s':format(chatmode, call))
					elseif not kin_used.target_at_25 then
						kin_used.target_at_25 = true
						input('/%s Next Target @ 10%%%s':format(chatmode, call))
					end
				end

			elseif actor == 'Ou' then
				if m_abil.en == 'Ebullient Nullification' then
					input('/%s Next Up @ 75%% - Ulfaltering Bravado: Conal 10k damage split (line up behind tank)':format(chatmode, call))
				elseif m_abil.en == 'Unfaltering Bravado' then
					input('/%s Next Up @ 60%% - Dancing Fullers: 2500 additive damage per player/pet hit dealt to each within 10\' AoE':format(chatmode, call))
				elseif m_abil.en == 'Dancing Fullers' then
					input('/%s Next Up @ 45%% - Zero Hour: Throat-Stab, hate reset within 10\' AoE':format(chatmode, call))
				elseif m_abil.en == 'Zero Hour' then
					input('/%s Next Up @ 30%% - Target: Switch hate after Target lands or 3min Terror':format(chatmode, call))
				elseif m_abil.en == 'Target' then
					input('/%s Target used on %s%s':format(chatmode, get_mob_by_id(act.targets[1].id).name, call))
					coroutine.schedule(function()
						input('/%s Next Up @ 15%% - Gardez: Short Terror within 20\' AoE':format(chatmode, call))
					end, 2)
				elseif m_abil.en == 'Gardez' then
					input('/%s Next Up @ 10%% - Prophylaxis: HP recover to 22%%, 30 seconds to kill or complete battle reset':format(chatmode, call))
				elseif m_abil.en == 'Prophylaxis' then
					input('/%s Prophylaxis - 30 second countdown to reset%s':format(chatmode, call))
					coroutine.schedule(function()
						if get_mob_by_name('Ou').hpp ~= 0 then
							input('/%s 20 seconds to reset%s':format(chatmode, call))
							coroutine.schedule(function()
								if get_mob_by_name('Ou').hpp ~= 0 then
									input('/%s 10 seconds to reset%s':format(chatmode, call))
									coroutine.schedule(function()
										if get_mob_by_name('Ou').hpp ~= 0 then
											input('/%s 5 seconds to reset%s':format(chatmode, call))
										end
									end, 5)
								end
							end, 10)
						end
					end, 10)
				end

			elseif actor == 'Kin' then
				if m_abil.en == 'Target' then
					input('/%s Target used on %s%s':format(chatmode, get_mob_by_id(act.targets[1].id).name, call))
				end
			end
		end

		if callout.odyssey then
			if actor == 'Arebati' then
				if m_abil.en == 'Glassy Nova' then
					input('/%s Full Dispel%s':format(chatmode, call))
				elseif m_abil.en == 'Polar Roar' then
					input('/%s Fetters incoming!%s':format(chatmode, call))
				end

			elseif actor == 'Gigelorum' then
				if m_abil.en == 'Debilitating Spout' then
					input('/%s Full Dispel%s':format(chatmode, call))
				end

			elseif actor == 'Henwen' then
				if m_abil.en == 'Barreling Smash' then
					input('/%s Hate Reset%s':format(chatmode, call))
				end

			elseif actor == 'Kalunga' then
				if m_abil.en == 'Volcanic Stasis' then
					input('/%s Full Dispel%s':format(chatmode, call))
				elseif m_abil.en == 'Blistering Roar' then
					input('/%s Fetters incoming!%s':format(chatmode, call))
				end

			elseif actor == 'Mboze' then
				if m_abil.en == 'Uproot' then
					input('/%s Hate Reset/Fetters incoming!%s':format(chatmode, call))
				end

			elseif actor == 'Ngai' then
				if m_abil.en == 'Protolithic Puncture' then
					input('/%s Hate Reset%s':format(chatmode, call))
				elseif m_abil.en == 'Carcharian Verve' then
					input('/%s Fetters incoming!%s':format(chatmode, call))
				end

			elseif actor == 'Ongo' then
				if m_abil.en == 'Crashing Thunder' then
					input('/%s Fetters incoming!%s':format(chatmode, call))
				end

			elseif actor == 'Xevioso' then
				if m_abil.en == 'Incisive Denouement' then
					input('/%s Hate Reset%s':format(chatmode, call))
				elseif m_abil.en == 'Stinger Volley' then
					input('/%s Zombie%s':format(chatmode, call))
				elseif m_abil.en == 'Droning Whirlwind' then
					input('/%s Fetters incoming!%s':format(chatmode, call))
				end
			end
		end

		if callout.dynamis then
			if actor == 'Halphas' then
				if m_abil and m_abil.en == 'Full-On Tackle' then
					input('/%s Hate Reset%s':format(chatmode, call))
				end
			end
		end

		if callout.ambuscade then
			if actor == 'Bozzetto Crusader' then
				if m_abil and m_abil.en == 'Veil of Chaos' or m_abil.en == 'Veil of Disarray' then
					input('/%s Hate Reset%s':format(chatmode, call))
				end
			end
		end

		if callout.htmb then
			if actor == 'Lady Lilith' then
				if m_abil and m_abil.en == 'Dark Thorn' then
					input('/%s Dread Spikes%s':format(chatmode,  call))
				end
			end
		end

	elseif act.category == 4 then

		if callout.dynamis then
			local spell = act and act.param
			if actor == 'Aurix' and spell and res.spells[spell] and res.spells[spell].en == 'Warp' then
				input('/%s Aurix has warped!%s':format(chatmode, call))
				coroutine.schedule(function()
					aurix_is_warping = false
					aurix_pop = false
				end, 10)
			end
		end

		if callout.omen then
			local spell = act and act.param
			if actor == 'Kei' and spell and res.spells[spell]
			and (string.find(res.spells[spell].en,'Aero') or string.find(res.spells[spell].en,'Gravity')) then
				input('/%s Cast Blizzard spells!%s':format(chatmode, call))
			elseif actor == 'Kei' and spell and res.spells[spell]
			and (string.find(res.spells[spell].en,'Fir') or string.find(res.spells[spell].en,'Addle')) then
				input('/%s Cast Water spells!%s':format(chatmode, call))
			end
		end

	end
end)


register_event('incoming text',function(org)

	local info = get_info()
	local zone = info and info.zone and res.zones[info.zone] and res.zones[info.zone].en

	if callout.omen and zone == "Reisenjima Henge" then

		local ebullient_match = org:match("(%d+) status effects are drained from")

		if (fu_pop or ou_pop) and ebullient_match then
			local drained = tonumber(ebullient_match)
			statuses_drained = statuses_drained + drained

		elseif org:find('You find a') then
			local scale_map = {
				["Fu's scale"]   = "Fu's Scale: BST, DRG, SMN, PUP",
				["Gin's scale"]  = "Gin's Scale: THF, NIN, DNC, RUN",
				["Kei's scale"]  = "Kei's Scale: WHM, BLM, RDM, BLU, SCH",
				["Kin's scale"]  = "Kin's Scale: WAR, MNK, PLD, DRK, SAM",
				["Kyou's scale"] = "Kyou's Scale: BRD, RNG, COR, GEO",
			}

			for keyword, message in pairs(scale_map) do
				if org:find(keyword) then
					input('/%s %s%s':format(chatmode, message, call))
					break --stop after first match
				end
			end

		end
	end

	if callout.vagary and zone:find("^Outer Ra'Kaznar") then
		if org:find('You pitiful lot will never learn') then
			input('/%s Perfidien pop!%s':format(chatmode, call))

		elseif org:find('the void calls') and zone ~= "Ra'Kaznar Turris" then
			input('/%s Plouton pop!%s':format(chatmode, call))

		elseif org:find("Hoho! Poked at a sore spot, didn't you?") or org:find('Switching things up, hmm?') then
			local element_map = {
				Lightning = 'Thunder',
				Fire = 'Fire',
				Wind = 'Aero',
				Earth = 'Stone',
				Ice = 'Blizzard',
				Water = 'Water'
			}

			for keyword, spell in pairs(element_map) do
				if org:find(keyword) then
					input('/%s %s%s':format(chatmode, spell, call))
					break --stop after first match
				end
			end
		end
	end

	if callout.abyssea and zone:find('Abyssea') and org:find('The fiend appears vulnerable to') and org:find('weapon skills') then
		local proc_table = {
			['lightning'] = 'RED Proc: Lightning - Raiden Thrust(PLM)',
			['fire'] = 'RED Proc: Fire - Red Lotus Blade(SWD)',
			['wind'] = 'RED Proc: Wind - Cyclone(DGR), Tachi: Jinpu(GKT)',
			['earth'] = 'RED Proc: Earth - Earth Crusher(STF)',
			['ice'] = 'RED Proc: Ice - Freezebite(GSD)',
			['dark'] = 'RED Proc: Dark - Energy Drain(DGR), Shadow of Death(SCY), Blade: Ei(KTN)',
			['light'] = 'RED Proc: Light - Seraph Blade(SWD), Tachi: Koki(GKT), Seraph Strike(CLB), Sunburst(STF)',
			['dagger'] = 'BLUE Proc: Dagger - Shadowstitch, Dancing Edge, Shark Bite, Evisceration',
			['polearm'] = 'BLUE Proc: Polearm - Skewer, Wheeling Thrust, Impulse Drive',
			['archery'] = 'BLUE Proc: Archery - Sidewinder, Blast Arrow, Arching Arrow, Empyreal Arrow',
			['marksmanship'] = 'BLUE Proc: Marksmanship - Slugshot, Blast Shot, Heavy Shot, Detonator',
			['great sword'] = 'BLUE Proc: Great Sword - Spinning Slash, Ground Strike',
			['sword'] = 'BLUE Proc: Sword - Vorpal Blade, Swift Blade, Savage Blade',
			['great axe'] = 'BLUE Proc: Great Axe - Full Break, Steel Cyclone',
			['axe'] = 'BLUE Proc: Axe - Mistral Axe, Decimation',
			['scythe'] = 'BLUE Proc: Scythe - Cross Reaper, Spiral Hell',
			['great katana'] = 'BLUE Proc: Great Katana - Tachi: Gekko, Tachi: Kasha',
			['katana'] = 'BLUE Proc: Katana - Blade: Ten, Blade: Ku',
			['hand'] = 'BLUE Proc: Hand-to-Hand - Raging Fists, Spinning Attack, Howling Fist, Dragon Kick, Asuran Fists',
			['club'] = 'BLUE Proc: Club - Skullbreaker, True Strike, Judgment, Hexa Strike, Black Halo',
			['staff'] = 'BLUE Proc: Staff - Heavy Swing, Shell Crusher, Full Swing, Spirit Taker, Retribution',
		}

		for keyword, message in pairs(proc_table) do
			if org:find(keyword) then
				input('/%s %s%s':format(chatmode, message, call))
				break --stop after first match
			end
		end
	end

	if callout.ambuscade and zone:find("^Maquette") then
		if org:find('rage is beginning to boil over.') then
			input('/%s Rage is boiling over!%s':format(chatmode, call))
		end

	end

	if zone:find("^Outer Ra'Kaznar") then

		local galli_match = org:match("received (%d+) gallimaufry for a total of (%d+).")
		if galli_match then
			local gained = tonumber(galli_match)
			gallimaufry = gallimaufry + gained
		end

	end

	if zone:find("^Walk of Echoes") then

		local seg_match = org:match("receive (%d+) moogle segments for a total of (%d+).")
		if seg_match then
			local gained = tonumber(seg_match)
			segments = segments + gained
		end

	end
end)

register_event('zone change', function(new_id, old_id)

	--Check if we zoned out of Sortie
	--Gallimaufry can only be gained inside Sortie, so if we are zoning at all with any gallimaufry collected, logic says we just exited Sortie
	if gallimaufry > 0 then

		--Wait x seconds after zoning out of Sortie to output results
		coroutine.schedule(function()

			if callout.sortie then
				gallimaufry = addCommas(gallimaufry)
				input('/%s Gallimaufry: %s%s':format(chatmode, gallimaufry, call))
			end

			--Reset gallimaufry/boss claims
			gallimaufry = 0
			aita_claimed = false
			degei_claimed = false
			skomora_claimed = false
			triboulex_claimed = false

		end, settings.galli_segs_after_zone_delay)

	end

	--Check if we zoned out of Odyssey
	--Segments can only be gained inside Odyssey, so if we are zoning at all with any segments collected, logic says we just exited Odyssey
	if segments > 0 then

		--Wait x seconds after zoning out of Odyssey to output results
		coroutine.schedule(function()

			if callout.odyssey then
				segments = addCommas(segments)
				input('/%s Segments: %s%s':format(chatmode, segments, call))
			end

			--Reset segments
			segments = 0

		end, settings.galli_segs_after_zone_delay)

	end

end)

register_event('addon command', function(addcmd, ...)

	if addcmd == 'help' then
		local prefix = "//callouts, //co"
		add_to_chat(8,('[Callouts] ':color(220))..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220)..(' ('):color(8)..(prefix):color(1)..(')'):color(8))
		add_to_chat(8,(' Command '):color(36)..(' - Description ['):color(8)..('Current Setting'):color(200)..(']'):color(8))
		add_to_chat(8,' ')
		add_to_chat(36,' chatmode/chat/mode'..(' - Switch between Echo and Party chat modes. ['):color(8)..(('%s'):format(chatmode == 'party' and 'Party' or 'Echo')):color(200)..(']'):color(8))
		add_to_chat(8,(' abyssea/ambuscade/charm/dynamis/htmb/odyssey/omen/sortie/vagary'):color(36)..(' - Turn individual callouts on or off.'):color(8))
		add_to_chat(8,(' callnum/call/num'):color(36)..(' - Update the call number used for Party chat mode.'):color(8))
		add_to_chat(8,(' list/l'):color(36)..(' - List the current callouts and their ON/OFF state.'):color(8))

	elseif addcmd == 'chatmode' or addcmd == 'chat' or addcmd == 'mode' then
		if chatmode == 'echo' then
			chatmode = 'party'
		else
			chatmode = 'echo'
		end
		call = chatmode == 'party' and ' <call'..call_num..'>' or ''
		add_to_chat(8,('[Callouts] '):color(220)..('Chat mode is now set to '):color(8)..(chatmode == 'party' and 'Party' or 'Echo'):color(200)..('.'):color(8))
		settings:save('all')

	elseif addcmd == 'call' or addcmd == 'num' or addcmd == 'callnum' then
		local new_num = {...}
		--If there are no parameters then output the current call number and remind how to update
		if #new_num < 1 then
			add_to_chat(8,('[Callouts] '):color(220)..('Call number:'):color(36)..(' '..call_num):color(200))
			add_to_chat(8,('[Callouts] '):color(220)..('Update by adding a number between 0 and 21 (ex.'):color(8)..(' //co '..addcmd..' 14'):color(1)..(')'):color(8))
		--Call number is provided
		else
			--Take the provided string parameter and turn it into a number
			new_num = tonumber(new_num[1])
			--Save the new setting, update the width, then alert the user
			if new_num == nil or new_num < 0 or new_num > 21 then
				add_to_chat(8,('[Callouts] '):color(220)..('Call number:'):color(36)..(' '..call_num):color(200))
				add_to_chat(8,('[Callouts] '):color(220)..('Update by adding a number between 0 and 21 (ex.'):color(8)..(' //co '..addcmd..' 14'):color(1)..(')'):color(8))
				return
			else
				settings.call_num = new_num
				call_num = new_num
				settings:save('all')
				add_to_chat(8,('[Callouts] '):color(220)..('Call number:'):color(36)..(' '..settings.call_num):color(200))
			end
		end

	elseif addcmd == 'abyssea' or addcmd == 'aby' then
		callout.abyssea = not callout.abyssea
		add_to_chat(8,('[Callouts] '):color(220)..('Abyssea callout is now set to '):color(8)..(callout.abyssea and 'ON' or 'OFF'):color(200)..('.'):color(8))
		settings:save('all')

	elseif addcmd == 'ambuscade' or addcmd == 'ambu' then
		callout.ambuscade = not callout.ambuscade
		add_to_chat(8,('[Callouts] '):color(220)..('Ambuscade callout is now set to '):color(8)..(callout.ambuscade and 'ON' or 'OFF'):color(200)..('.'):color(8))
		settings:save('all')

	elseif addcmd == 'charm' then
		callout.charm = not callout.charm
		add_to_chat(8,('[Callouts] '):color(220)..('Charm callout is now set to '):color(8)..(callout.charm and 'ON' or 'OFF'):color(200)..('.'):color(8))
		settings:save('all')

	elseif addcmd == 'dynamis' or addcmd == 'dyna' or addcmd == 'dyn' then
		callout.dynamis = not callout.dynamis
		add_to_chat(8,('[Callouts] '):color(220)..('Dynamis callout is now set to '):color(8)..(callout.dynamis and 'ON' or 'OFF'):color(200)..('.'):color(8))
		settings:save('all')

	elseif addcmd == 'htmb' then
		callout.htmb = not callout.htmb
		add_to_chat(8,('[Callouts] '):color(220)..('HTMB callout is now set to '):color(8)..(callout.htmb and 'ON' or 'OFF'):color(200)..('.'):color(8))
		settings:save('all')

	elseif addcmd == 'odyssey' or addcmd == 'ody' then
		callout.odyssey = not callout.odyssey
		add_to_chat(8,('[Callouts] '):color(220)..('Odyssey callout is now set to '):color(8)..(callout.odyssey and 'ON' or 'OFF'):color(200)..('.'):color(8))
		settings:save('all')

	elseif addcmd == 'omen' then
		callout.omen = not callout.omen
		add_to_chat(8,('[Callouts] '):color(220)..('Omen callout is now set to '):color(8)..(callout.omen and 'ON' or 'OFF'):color(200)..('.'):color(8))
		settings:save('all')

	elseif addcmd == 'sortie' then
		callout.sortie = not callout.sortie
		add_to_chat(8,('[Callouts] '):color(220)..('Sortie callout is now set to '):color(8)..(callout.sortie and 'ON' or 'OFF'):color(200)..('.'):color(8))
		settings:save('all')

	elseif addcmd == 'vagary' or addcmd == 'vag' then
		callout.vagary = not callout.vagary
		add_to_chat(8,('[Callouts] '):color(220)..('Vagary callout is now set to '):color(8)..(callout.vagary and 'ON' or 'OFF'):color(200)..('.'):color(8))
		settings:save('all')

	elseif addcmd == 'list' or addcmd == 'lists' or addcmd == 'l' then
		add_to_chat(8,('[Callouts] '):color(220)..('Current callouts:'):color(8))
		add_to_chat(8,(' Abyssea:'):color(36)..(' %s':format(callout.abyssea and 'ON' or 'OFF')):color(200)..(' - Red and Blue Procs'):color(8))
		add_to_chat(8,(' Ambuscade:'):color(36)..(' %s':format(callout.ambuscade and 'ON' or 'OFF')):color(200)..(' - Bozzetto Autarch Mijin Gakure countdown, Bozzetto Crusader hate reset'):color(8))
		add_to_chat(8,(' Charm:'):color(36)..(' %s':format(callout.charm and 'ON' or 'OFF')):color(200)..(' - Party/Alliance members who get charmed'):color(8))
		add_to_chat(8,(' Dynamis:'):color(36)..(' %s':format(callout.dynamis and 'ON' or 'OFF')):color(200)..(' - Halphas hate reset, Aurix pop/run/warp'):color(8))
		add_to_chat(8,(' HTMB:'):color(36)..(' %s':format(callout.htmb and 'ON' or 'OFF')):color(200)..(' - Lilith Dread Spikes'):color(8))
		add_to_chat(8,(' Odyssey:'):color(36)..(' %s':format(callout.odyssey and 'ON' or 'OFF')):color(200)..(' - Certain 1-HRs, segment total after run, others'):color(8))
		add_to_chat(8,(' Omen:'):color(36)..(' %s':format(callout.omen and 'ON' or 'OFF')):color(200)..(' - Scale drops/jobs, certain abilities, boss info'):color(8))
		add_to_chat(8,(' Sortie:'):color(36)..(' %s':format(callout.sortie and 'ON' or 'OFF')):color(200)..(' - Elements, gallimaufry total after run, rage timers'):color(8))
		add_to_chat(8,(' Vagary:'):color(36)..(' %s':format(callout.vagary and 'ON' or 'OFF')):color(200)..(' - Perfidien/Plouton pop, weaknesses'):color(8))

	else
		add_to_chat(8,('[Callouts] '):color(220)..('Unknown command. Type \'//co help\' for list of commands.'):color(8))

	end
end)

register_event('prerender', function()

	local info = get_info()
	local zone = info and info.zone and res.zones[info.zone] and res.zones[info.zone].en

	--Real-time callouts
	if zone == "Reisenjima Henge" and callout.omen then
		omenCallouts()
	elseif zone:find("^Outer Ra'Kaznar") and callout.sortie then
		sortieCallouts()
	elseif zone:find("^Dynamis.*%[D%]$") and callout.dynamis then
		aurixCallouts()
	end

	--Once per second callouts
	if os.time() > Heartbeat then

		Heartbeat = os.time()

		if callout.charm then
			checkForCharm()
		end

		if zone == "Reisenjima Henge" and callout.omen then
			checkForEbullient()
		end

	end

end)
