--Copyright (c) 2024, Key
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
_addon.version = '1.10'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.commands = {'callouts','co'}

require 'logger'
config = require('config')
res = require 'resources'

defaults = {}
defaults.chatmode = 'echo'
defaults.callouts = {}
defaults.callouts.abyssea = true
defaults.callouts.ambuscade = true
defaults.callouts.charm = true
defaults.callouts.dynamis = true
defaults.callouts.odyssey = true
defaults.callouts.omen = true
defaults.callouts.ou = true
defaults.callouts.sortie = true
defaults.callouts.vagary = true

settings = config.load(defaults)

local chat = windower.chat.input
local callout = settings.callouts
local chatmode = settings.chatmode
local Heartbeat = 0

local Ou_pop = false
local Ou_100 = false
local Ou_95 = false
local Ou_75 = false
local Ou_65 = false
local Ou_60 = false
local Ou_55 = false
local Ou_45 = false
local Ou_30 = false
local Ou_15 = false
local Ou_10 = false
local Ou_Ebullient_used = false
local Ou_Bravado_used = false
local Ou_Fullers_used = false
local Ou_Zero_Hour_used = false
local Ou_Target_used = false
local Ou_Gardez_used = false

local charmed = T{}

local ally_pos = {
	'p0', 'p1', 'p2', 'p3', 'p4', 'p5', 'a10', 'a11', 'a12', 'a13', 'a14', 'a15', 'a20', 'a21', 'a22', 'a23', 'a24', 'a25'
}

windower.register_event('action',function(act)

	local actor = (act.actor_id and windower.ffxi.get_mob_by_id(act.actor_id)) or 'unknown'
	if type(actor) == "table" then
		actor = actor.name
	end

	local monster_ability = res.monster_abilities[act.targets[1].actions[1].param]
	local spell_start = res.spells[act.targets[1].actions[1].param]

	if act.category == 11 then
		if actor == 'Bumba' and callout.odyssey then
			local monster_ability = res.monster_abilities[act.param]
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Perfect Dodge' then
				chat('/%s Perfect Dodge%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
				chat:schedule(30,'/%s Perfect Dodge is off%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Invincible' then
				chat('/%s Invincible%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
				chat:schedule(30,'/%s Invincible is off%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Elemental Sforzo' then
				chat('/%s Elemental Sforzo%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
				chat:schedule(30,'/%s Elemental Sforzo is off%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Yaegasumi' then
				chat('/%s Yaegasumi%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
				chat:schedule(45,'/%s Yaegasumi is off%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Brazen Rush' then
				chat('/%s Brazen Rush%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end
		end
	end

	if act.category == 8 then
		if actor == 'Bozzetto Autarch' and callout.ambuscade then
			if spell_start == nil then
				return
			elseif spell_start.en == 'Katon: San' then
				chat('/%s Mijin Gakure: 6%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif spell_start.en == 'Suiton: San' then
				chat('/%s Mijin Gakure: 5%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif spell_start.en == 'Raiton: San' then
				chat('/%s Mijin Gakure: 4%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif spell_start.en == 'Doton: San' then
				chat('/%s Mijin Gakure: 3%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif spell_start.en == 'Huton: San' then
				chat('/%s Mijin Gakure: 2%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif spell_start.en == 'Hyoton: San' then
				chat('/%s Mijin Gakure: 1%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end
		end
	end

	if act.category == 7 then -- initiation of weapon skill or monster TP move

		if (actor == 'Aita' or actor == 'Degei') and callout.sortie then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Flaming Kick' then
				chat('/%s Water (Flaming Kick)%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Flashflood' then
				chat('/%s Thunder (Flashflood)%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Icy Grasp' then
				chat('/%s Fire (Icy Grasp)%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Eroding Flesh' then
				chat('/%s Aero (Eroding Flesh)%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Fulminous Smash' then
				chat('/%s Stone (Fulminous Smash)%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Glassy Craver' and callout.omen then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Impalement' then
				chat('/%s Hate Reset%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end

		elseif (actor == 'Triboulex' or actor == 'Skomora') and callout.sortie then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Last Laugh' then
				chat('/%s Hate Reset%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end

		elseif (actor == 'Leshonn' or actor == 'Gartell') and callout.sortie then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Undulating Shockwave' or monster_ability.en == 'Shrieking Gale' then
				chat('/%s Switching to %s%s':format(chatmode,monster_ability.en == 'Undulating Shockwave' and 'Ice' or 'Stone',chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Aminon' and callout.sortie then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Demonfire' then
				chat('/%s Water (Demonfire)%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Torrential Pain' then
				chat('/%s Thunder (Torrential Pain)%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Frozen Blood' then
				chat('/%s Fire (Frozen Blood)%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Ensepulcher' then
				chat('/%s Aero (Ensepulcher)%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Ceaseless Surge' then
				chat('/%s Stone (Ceaseless Surge)%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Impudence' then
				chat('/%s Hate Reset (Impudence)%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Blast of Reticence' then
				chat('/%s Blizzard (Blast of Reticence)%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Glassy Thinker' and callout.omen then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Pain Sync' then
				chat('/%s PAIN SYNC%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Ou' then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Ebullient Nullification' then
				Ou_Ebullient_used = true
			elseif monster_ability.en == 'Unfaltering Bravado' then
				Ou_Bravado_used = true
			elseif monster_ability.en == 'Dancing Fullers' then
				Ou_Fullers_used = true
			elseif monster_ability.en == 'Zero Hour' then
				Ou_Zero_Hour_used = true
			elseif monster_ability.en == 'Target' then
				if callout.ou then
					chat('/%s Target used on %s%s':format(chatmode,windower.ffxi.get_mob_by_id(act.targets[1].id).name,chatmode == 'party' and ' <call14>' or ''))
				end
				Ou_Target_used = true
			elseif monster_ability.en == 'Gardez' then
				Ou_Gardez_used = true
			elseif monster_ability.en == 'Prophylaxis' then
				if callout.ou then
					chat('/%s Prophylaxis - 30 second countdown to reset%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
				end
				coroutine.sleep(10)
				if windower.ffxi.get_mob_by_name('Ou').hpp ~= 0 then
					if callout.ou then
						chat('/%s 20 seconds to reset%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
					end
					coroutine.sleep(10)
					if windower.ffxi.get_mob_by_name('Ou').hpp ~= 0 then
						if callout.ou then
							chat('/%s 10 seconds to reset%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
						end
						coroutine.sleep(5)
						if windower.ffxi.get_mob_by_name('Ou').hpp ~= 0 then
							if callout.ou then
								chat('/%s 5 seconds to reset%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
							end
						end
					end
				end
			end

		elseif actor == 'Kin' and callout.omen then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Target' then
				chat('/%s Target used on %s%s':format(chatmode,windower.ffxi.get_mob_by_id(act.targets[1].id).name,chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Arebati' and callout.odyssey then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Glassy Nova' then
				chat('/%s Full Dispel%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Gigelorum' and callout.odyssey then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Debilitating Spout' then
				chat('/%s Full Dispel%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Henwen' and callout.odyssey then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Barreling Smash' then
				chat('/%s Hate Reset%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Kalunga' and callout.odyssey then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Volcanic Stasis' then
				chat('/%s Full Dispel%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Blistering Roar' then
				chat('/%s Fetters incoming!%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Mboze' and callout.odyssey then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Uproot' then
				chat('/%s Hate Reset%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Ngai' and callout.odyssey then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Protolithic Puncture' then
				chat('/%s Hate Reset%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Carcharian Verve' then
				chat('/%s Fetters incoming!%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Xevioso' and callout.odyssey then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Incisive Denouement' then
				chat('/%s Hate Reset%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Stinger Volley' then
				chat('/%s Zombie%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			elseif monster_ability.en == 'Droning Whirlwind' then
				chat('/%s Fetters incoming!%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Halphas' and callout.dynamis then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Full-On Tackle' then
				chat('/%s Hate Reset%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end

		elseif actor == 'Bozzetto Crusader' and callout.ambuscade then
			if monster_ability == nil then
				return
			elseif monster_ability.en == 'Veil of Chaos' or monster_ability.en == 'Veil of Disarray' then
				chat('/%s Hate Reset%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end

		end
	end
end)


windower.register_event('incoming text',function(org)

	if org:find('You find a') and callout.omen then
		if org:find('Fu\'s scale') then
			chat('/%s Fu\'s Scale: BST, DRG, SMN, PUP%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('Gin\'s scale') then
			chat('/%s Gin\'s Scale: THF, NIN, DNC, RUN%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('Kei\'s scale') then
			chat('/%s Kei\'s Scale: WHM, BLM, RDM, BLU, SCH%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('Kin\'s scale') then
			chat('/%s Kin\'s Scale: WAR, MNK, PLD, DRK, SAM%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('Kyou\'s scale') then
			chat('/%s Kyou\'s Scale: BRD, RNG, COR, GEO%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		end

	elseif org:find('You pitiful lot will never learn') and callout.vagary then
		chat('/%s Perfidien pop!%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))

	elseif org:find('the void calls') and windower.ffxi.get_info().zone ~= 277 and callout.vagary then
		chat('/%s Plouton pop!%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))

	elseif org:find('Hoho! Poked at a sore spot, didn\'t you?') or org:find('Switching things up, hmm?') and callout.vagary then
		if org:find('Lightning') then
			chat('/%s Thunder%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('Fire') then
			chat('/%s Fire%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('Wind') then
			chat('/%s Aero%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('Earth') then
			chat('/%s Stone%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('Ice') then
			chat('/%s Blizzard%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('Water') then
			chat('/%s Water%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		end

	elseif org:find('The fiend appears vulnerable to') and callout.abyssea then
		if org:find('lightning') then
			chat('/%s RED Proc: Lightning - Raiden Thrust(PLM)%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('fire') then
			chat('/%s RED Proc: Fire - Red Lotus Blade(SWD)%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('wind') then
			chat('/%s RED Proc: Wind - Cyclone(DGR), Tachi: Jinpu(GKT)%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('earth') then
			chat('/%s RED Proc: Earth - Earth Crusher(STF)%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('ice') then
			chat('/%s RED Proc: Ice - Freezebite(GSD)%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('dark') then
			chat('/%s RED Proc: Dark - Energy Drain(DGR), Shadow of Death(SCY), Blade: Ei(KTN)%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('light') then
			chat('/%s RED Proc: Light - Seraph Blade(SWD), Tachi: Koki(GKT), Seraph Strike(CLB), Sunburst(STF)%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('dagger') then
			chat('/%s BLUE Proc: Dagger - Shadowstitch, Dancing Edge, Shark Bite, Evisceration%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('polearm') then
			chat('/%s BLUE Proc: Polearm - Skewer, Wheeling Thrust, Impulse Drive%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('archery') then
			chat('/%s BLUE Proc: Archery - Sidewinder, Blast Arrow, Arching Arrow, Empyreal Arrow%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('marksmanship') then
			chat('/%s BLUE Proc: Marksmanship - Slugshot, Blast Shot, Heavy Shot, Detonator%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('sword') then
			chat('/%s BLUE Proc: Sword - Vorpal Blade, Swift Blade, Savage Blade%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('great sword') then
			chat('/%s BLUE Proc: Great Sword - Spinning Slash, Ground Strike%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('axe') then
			chat('/%s BLUE Proc: Axe - Nistral Axe, Decimation%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('great axe') then
			chat('/%s BLUE Proc: Great Axe - Full Break, Steel Cyclone%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('scythe') then
			chat('/%s BLUE Proc: Scythe - Cross Reaper, Spiral Hell%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('katana') then
			chat('/%s BLUE Proc: Katana - Blade: Ten, Blade: Ku%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('great katana') then
			chat('/%s BLUE Proc: Great Katana - Tachi: Gekko, Tachi: Kasha%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('hand') then
			chat('/%s BLUE Proc: Hand-to-Hand - Raging Fists, Spinning Attack, Howling Fist, Dragon Kick, Asuran Fists%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('club') then
			chat('/%s BLUE Proc: Club - Skullbreaker, True Strike, Judgment, Hexa Strike, Black Halo%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		elseif org:find('staff') then
			chat('/%s BLUE Proc: Staff - Heavy Swing, Shell Crusher, Full Swing, Spirit Taker, Retribution%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
		end

	end
end)

function resetOu()
	Ou_pop = false
	Ou_100 = false
	Ou_95 = false
	Ou_75 = false
	Ou_65 = false
	Ou_60 = false
	Ou_55 = false
	Ou_45 = false
	Ou_30 = false
	Ou_15 = false
	Ou_10 = false
	Ou_Ebullient_used = false
	Ou_Bravado_used = false
	Ou_Fullers_used = false
	Ou_Zero_Hour_used = false
	Ou_Target_used = false
	Ou_Gardez_used = false
end

function OuCallouts()
	local Ou = windower.ffxi.get_mob_by_name('Ou')
	local Ou_nearby = Ou and Ou.valid_target

	if Ou_nearby then
		if not Ou_pop then
			Ou_pop = true
			if callout.ou then
				chat('/%s 95%%:Ebullient 75%%:Bravado 60%%:Fullers 45%%:Zero Hour 30%%:Target 15%%:Gardez 10%%:Prophalaxis':format(chatmode))
			end
		elseif not Ou_100 and Ou.claim_id ~= 0 then --Claimed, start of fight
			Ou_100 = true
			if callout.ou then
				chat('/%s First up @ 95%% - Ebullient Nullification: Absorbs all buffs within 20\' AoE (sweet spot: 5~8 buffs)%s':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end
		elseif not Ou_95 and Ou_Ebullient_used then
			Ou_95 = true
			if callout.ou then
				chat('/%s Next Up @ 75%% - Ulfaltering Bravado: Conal 10k damage split (line up behind tank)':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end
		elseif not Ou_75 and Ou_Bravado_used then
			Ou_75 = true
			if callout.ou then
				chat('/%s Next Up @ 60%% - Dancing Fullers: 2500 additive damage per player/pet hit dealt to each within 10\' AoE':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end
		elseif not Ou_60 and Ou_Fullers_used then
			Ou_60 = true
			if callout.ou then
				chat('/%s Next Up @ 45%% - Zero Hour: Throat-Stab, hate reset within 10\'(?) AoE':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end
		elseif not Ou_45 and Ou_Zero_Hour_used then
			Ou_45 = true
			if callout.ou then
				chat('/%s Next Up @ 30%% - Target: Switch hate after Target lands or 3min Terror':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end
		elseif not Ou_30 and Ou_Target_used then
			Ou_30 = true
			coroutine.sleep(2)
			if callout.ou then
				chat('/%s Next Up @ 15%% - Gardez: Short Terror within 20\' AoE':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end
		elseif not Ou_15 and Ou_Gardez_used then
			Ou_15 = true
			if callout.ou then
				chat('/%s Next Up @ 10%% - Prophylaxis: HP recover to 22%%, 30 seconds to kill or complete battle reset':format(chatmode,chatmode == 'party' and ' <call14>' or ''))
			end
		end

		if Ou_95 and Ou.hpp == 100 then
			resetOu()

		end
	end
end

function checkForCharm()
	local justCharmed = {}

	-- Loop through all party/alliance positions
	for _, pos in ipairs(ally_pos) do
		local member = windower.ffxi.get_mob_by_target(pos)
		if member and member.charmed and not member.is_npc and not charmed[member.name] then
			table.insert(justCharmed, member.name)
			charmed[member.name] = true
		elseif member and charmed[member.name] and not member.charmed then
			charmed[member.name] = nil
		end
	end

	if #justCharmed > 0 then
		chat(('/%s \r \r Charmed: '..table.concat(justCharmed, ", ")..'%s\r \r'):format(chatmode,chatmode == 'party' and ' <call14>' or ''))

	end
end

windower.register_event('addon command', function(addcmd)

	if addcmd == 'help' then
		windower.add_to_chat(220,'[Callouts] '..('Version '):color(8)..(_addon.version):color(220)..(', by '):color(8)..('Key (Keylesta@Valefor)'):color(220))
		windower.add_to_chat(220,' ')
		windower.add_to_chat(220,' Commands'..(' (prefixed with'):color(8)..(' //callouts'):color(1)..(' or'):color(8)..(' //co'):color(1)..('):'):color(8))
		windower.add_to_chat(36,'   chatmode/chat/mode'..(' - Switch between Echo and Party chat modes. (Current setting:'):color(8)..((' %s'):format(chatmode == 'party' and 'Party' or 'Echo')):color(200)..(')'):color(8))
		windower.add_to_chat(8,('   abyssea/ambuscade/charm/dynamis/odyssey/omen/ou/sortie/vagary'):color(36)..(' - Turn individual callouts on or off.'):color(8))
		windower.add_to_chat(8,'      NOTE: Ou is separate from Omen')
		windower.add_to_chat(8,('   list'):color(36)..(' - List the current callouts and their ON/OFF state.'):color(8))

	elseif addcmd == 'chatmode' or addcmd == 'chat' or addcmd == 'mode' then
		if chatmode == 'echo' then
			chatmode = 'party'
		else
			chatmode = 'echo'
		end
		windower.add_to_chat(220,'[Callouts] '..('Chat mode is now set to '):color(8)..(chatmode == 'party' and 'Party' or 'Echo'):color(200)..('.'):color(8))
		settings:save()

	elseif addcmd == 'abyssea' or addcmd == 'aby' then
		callout.abyssea = not callout.abyssea
		windower.add_to_chat(220,'[Callouts] '..('Abyssea callout is now set to '):color(8)..(callout.abyssea and 'ON' or 'OFF'):color(200)..('.'):color(8))
		settings:save()

	elseif addcmd == 'ambuscade' or addcmd == 'ambu' then
		callout.ambuscade = not callout.ambuscade
		windower.add_to_chat(220,'[Callouts] '..('Ambuscade callout is now set to '):color(8)..(callout.ambuscade and 'ON' or 'OFF'):color(200)..('.'):color(8))
		settings:save()

	elseif addcmd == 'charm' then
		callout.charm = not callout.charm
		windower.add_to_chat(220,'[Callouts] '..('Charm callout is now set to '):color(8)..(callout.charm and 'ON' or 'OFF'):color(200)..('.'):color(8))
		settings:save()

	elseif addcmd == 'dynamis' or addcmd == 'dyna' or addcmd == 'dyn' then
		callout.dynamis = not callout.dynamis
		windower.add_to_chat(220,'[Callouts] '..('Dynamis callout is now set to '):color(8)..(callout.dynamis and 'ON' or 'OFF'):color(200)..('.'):color(8))
		settings:save()

	elseif addcmd == 'odyssey' or addcmd == 'ody' then
		callout.odyssey = not callout.odyssey
		windower.add_to_chat(220,'[Callouts] '..('Odyssey callout is now set to '):color(8)..(callout.odyssey and 'ON' or 'OFF'):color(200)..('.'):color(8))
		settings:save()

	elseif addcmd == 'omen' then
		callout.omen = not callout.omen
		windower.add_to_chat(220,'[Callouts] '..('Omen callout is now set to '):color(8)..(callout.omen and 'ON' or 'OFF'):color(200)..('.'):color(8))
		settings:save()

	elseif addcmd == 'ou' then
		callout.ou = not callout.ou
		windower.add_to_chat(220,'[Callouts] '..('Ou callout is now set to '):color(8)..(callout.ou and 'ON' or 'OFF'):color(200)..('.'):color(8))
		settings:save()

	elseif addcmd == 'sortie' then
		callout.sortie = not callout.sortie
		windower.add_to_chat(220,'[Callouts] '..('Sortie callout is now set to '):color(8)..(callout.sortie and 'ON' or 'OFF'):color(200)..('.'):color(8))
		settings:save()

	elseif addcmd == 'vagary' or addcmd == 'vag' then
		callout.vagary = not callout.vagary
		windower.add_to_chat(220,'[Callouts] '..('Vagary callout is now set to '):color(8)..(callout.vagary and 'ON' or 'OFF'):color(200)..('.'):color(8))
		settings:save()

	elseif addcmd == 'list' or addcmd == 'lists' then
		windower.add_to_chat(220,'[Callouts] '..('Current callouts:'):color(200))
		windower.add_to_chat(8,('   Abyssea:'):color(36)..(' %s':format(callout.abyssea and 'ON' or 'OFF')):color(200)..(' - Red and Blue Procs'):color(8))
		windower.add_to_chat(8,('   Ambuscade:'):color(36)..(' %s':format(callout.ambuscade and 'ON' or 'OFF')):color(200)..(' - Bozzetto Autarch Mijin Gakure countdown, Bozzetto Crusader hate reset'):color(8))
		windower.add_to_chat(8,('   Charm:'):color(36)..(' %s':format(callout.charm and 'ON' or 'OFF')):color(200)..(' - Party/Alliance members who get charmed'):color(8))
		windower.add_to_chat(8,('   Dynamis:'):color(36)..(' %s':format(callout.dynamis and 'ON' or 'OFF')):color(200)..(' - Halphas hate reset'):color(8))
		windower.add_to_chat(8,('   Odyssey:'):color(36)..(' %s':format(callout.odyssey and 'ON' or 'OFF')):color(200)..(' - Hate resets, full dispels, Bumba 1-HRs, Kalunga/Ngai fetters'):color(8))
		windower.add_to_chat(8,('   Omen:'):color(36)..(' %s':format(callout.omen and 'ON' or 'OFF')):color(200)..(' - Scales, Pain Sync, Target'):color(8))
		windower.add_to_chat(8,('   Ou:'):color(36)..(' %s':format(callout.ou and 'ON' or 'OFF')):color(200)..(' - Upcoming abilities'):color(8))
		windower.add_to_chat(8,('   Sortie:'):color(36)..(' %s':format(callout.sortie and 'ON' or 'OFF')):color(200)..(' - Elements/weaknesses, hate resets'):color(8))
		windower.add_to_chat(8,('   Vagary:'):color(36)..(' %s':format(callout.vagary and 'ON' or 'OFF')):color(200)..(' - Perfidien/Plouton pop, weaknesses'):color(8))

	elseif addcmd == 'reload' then
		windower.send_command('lua r callouts')
		return

	else
		windower.add_to_chat(8,('[Callouts] '):color(220)..('Unknown command. Type \'//co help\' for list of commands.'):color(8))

	end
end)

windower.register_event('prerender', function()
	local zone = windower.ffxi.get_info() and windower.ffxi.get_info().zone
	if zone and zone == 292 then -- Reisenjima Henge
		OuCallouts()
	end
	if os.time() > Heartbeat then
		Heartbeat = os.time()
		if callout.charm then
			checkForCharm()
		end
	end
end)
