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
    * Neither the name of Leaderboard nor the
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

_addon.name = 'Leaderboard'
_addon.version = '05.17.23'
_addon.author = 'Key'
_addon.commands = {'leaderboard','lb'}

require 'logger'
config = require('config')

defaults = {}
defaults.flood_delay = 5
defaults.reminder = true
defaults.scores = {}
defaults.scores.Whiff = {}
defaults.scores.Whiff.FirstName = ""
defaults.scores.Whiff.SecondName = ""
defaults.scores.Whiff.ThirdName = ""
defaults.scores.Whiff.FirstAmount = 0
defaults.scores.Whiff.SecondAmount = 0
defaults.scores.Whiff.ThirdAmount = 0

defaults.scores.HS = {}
defaults.scores.HS.FirstName = ""
defaults.scores.HS.SecondName = ""
defaults.scores.HS.ThirdName = ""
defaults.scores.HS.FourthName = ""
defaults.scores.HS.FifthName = ""
defaults.scores.HS.FirstDamage = 0
defaults.scores.HS.SecondDamage = 0
defaults.scores.HS.ThirdDamage = 0
defaults.scores.HS.FourthDamage = 0
defaults.scores.HS.FifthDamage = 0
defaults.scores.HS.FirstWS = ""
defaults.scores.HS.SecondWS = ""
defaults.scores.HS.ThirdWS = ""
defaults.scores.HS.FourthWS = ""
defaults.scores.HS.FifthWS = ""
defaults.scores.HS.FirstTarget = ""
defaults.scores.HS.SecondTarget = ""
defaults.scores.HS.ThirdTarget = ""
defaults.scores.HS.FourthTarget = ""
defaults.scores.HS.FifthTarget = ""

defaults.scores.LS = {}
defaults.scores.LS.FirstName = ""
defaults.scores.LS.SecondName = ""
defaults.scores.LS.ThirdName = ""
defaults.scores.LS.FirstDamage = 999999
defaults.scores.LS.SecondDamage = 999999
defaults.scores.LS.ThirdDamage = 999999
defaults.scores.LS.FirstWS = ""
defaults.scores.LS.SecondWS = ""
defaults.scores.LS.ThirdWS = ""
defaults.scores.LS.FirstTarget = ""
defaults.scores.LS.SecondTarget = ""
defaults.scores.LS.ThirdTarget = ""

defaults.scores.SC = {}
defaults.scores.SC.FirstName = ""
defaults.scores.SC.SecondName = ""
defaults.scores.SC.ThirdName = ""
defaults.scores.SC.FourthName = ""
defaults.scores.SC.FifthName = ""
defaults.scores.SC.FirstDamage = 0
defaults.scores.SC.SecondDamage = 0
defaults.scores.SC.ThirdDamage = 0
defaults.scores.SC.FourthDamage = 0
defaults.scores.SC.FifthDamage = 0
defaults.scores.SC.FirstSC = ""
defaults.scores.SC.SecondSC = ""
defaults.scores.SC.ThirdSC = ""
defaults.scores.SC.FourthSC = ""
defaults.scores.SC.FifthSC = ""
defaults.scores.SC.FirstTarget = ""
defaults.scores.SC.SecondTarget = ""
defaults.scores.SC.ThirdTarget = ""
defaults.scores.SC.FourthTarget = ""
defaults.scores.SC.FifthTarget = ""

defaults.scores.Nuke = {}
defaults.scores.Nuke.FirstName = ""
defaults.scores.Nuke.SecondName = ""
defaults.scores.Nuke.ThirdName = ""
defaults.scores.Nuke.FourthName = ""
defaults.scores.Nuke.FifthName = ""
defaults.scores.Nuke.FirstDamage = 0
defaults.scores.Nuke.SecondDamage = 0
defaults.scores.Nuke.ThirdDamage = 0
defaults.scores.Nuke.FourthDamage = 0
defaults.scores.Nuke.FifthDamage = 0

defaults.scores.MB = {}
defaults.scores.MB.FirstName = ""
defaults.scores.MB.SecondName = ""
defaults.scores.MB.ThirdName = ""
defaults.scores.MB.FourthName = ""
defaults.scores.MB.FifthName = ""
defaults.scores.MB.FirstDamage = 0
defaults.scores.MB.SecondDamage = 0
defaults.scores.MB.ThirdDamage = 0
defaults.scores.MB.FourthDamage = 0
defaults.scores.MB.FifthDamage = 0
defaults.scores.MB.FirstSpell = ""
defaults.scores.MB.SecondSpell = ""
defaults.scores.MB.ThirdSpell = ""
defaults.scores.MB.FourthSpell = ""
defaults.scores.MB.FifthSpell = ""
defaults.scores.MB.FirstTarget = ""
defaults.scores.MB.SecondTarget = ""
defaults.scores.MB.ThirdTarget = ""
defaults.scores.MB.FourthTarget = ""
defaults.scores.MB.FifthTarget = ""

defaults.scores.Cure = {}
defaults.scores.Cure.FirstName = ""
defaults.scores.Cure.SecondName = ""
defaults.scores.Cure.ThirdName = ""
defaults.scores.Cure.FirstAmount = 0
defaults.scores.Cure.SecondAmount = 0
defaults.scores.Cure.ThirdAmount = 0

settings = config.load(defaults)

local weaponskills = require('resources').weapon_skills
local spells = require('resources').spells
local jabils = require('resources').job_abilities
local mabils = require('resources').monster_abilities
local whiff = {}
local cure = {}
local nuke = {}

local cmd = windower.send_command
local say = windower.chat.input

local Heartbeat = 0
local flood_timer = 0
local Run = false
local Paused = false

function reset_scores()
	settings.scores.Whiff.FirstName = ""
	settings.scores.Whiff.SecondName = ""
	settings.scores.Whiff.ThirdName = ""
	settings.scores.Whiff.FirstAmount = 0
	settings.scores.Whiff.SecondAmount = 0
	settings.scores.Whiff.ThirdAmount = 0

	settings.scores.HS.FirstName = ""
	settings.scores.HS.SecondName = ""
	settings.scores.HS.ThirdName = ""
	settings.scores.HS.FourthName = ""
	settings.scores.HS.FifthName = ""
	settings.scores.HS.FirstDamage = 0
	settings.scores.HS.SecondDamage = 0
	settings.scores.HS.ThirdDamage = 0
	settings.scores.HS.FourthDamage = 0
	settings.scores.HS.FifthDamage = 0
	settings.scores.HS.FirstWS = ""
	settings.scores.HS.SecondWS = ""
	settings.scores.HS.ThirdWS = ""
	settings.scores.HS.FourthWS = ""
	settings.scores.HS.FifthWS = ""
	settings.scores.HS.FirstTarget = ""
	settings.scores.HS.SecondTarget = ""
	settings.scores.HS.ThirdTarget = ""
	settings.scores.HS.FourthTarget = ""
	settings.scores.HS.FifthTarget = ""

	settings.scores.LS.FirstName = ""
	settings.scores.LS.SecondName = ""
	settings.scores.LS.ThirdName = ""
	settings.scores.LS.FirstDamage = 999999
	settings.scores.LS.SecondDamage = 999999
	settings.scores.LS.ThirdDamage = 999999
	settings.scores.LS.FirstWS = ""
	settings.scores.LS.SecondWS = ""
	settings.scores.LS.ThirdWS = ""
	settings.scores.LS.FirstTarget = ""
	settings.scores.LS.SecondTarget = ""
	settings.scores.LS.ThirdTarget = ""

	settings.scores.SC.FirstName = ""
	settings.scores.SC.SecondName = ""
	settings.scores.SC.ThirdName = ""
	settings.scores.SC.FourthName = ""
	settings.scores.SC.FifthName = ""
	settings.scores.SC.FirstDamage = 0
	settings.scores.SC.SecondDamage = 0
	settings.scores.SC.ThirdDamage = 0
	settings.scores.SC.FourthDamage = 0
	settings.scores.SC.FifthDamage = 0
	settings.scores.SC.FirstSC = ""
	settings.scores.SC.SecondSC = ""
	settings.scores.SC.ThirdSC = ""
	settings.scores.SC.FourthSC = ""
	settings.scores.SC.FifthSC = ""
	settings.scores.SC.FirstTarget = ""
	settings.scores.SC.SecondTarget = ""
	settings.scores.SC.ThirdTarget = ""
	settings.scores.SC.FourthTarget = ""
	settings.scores.SC.FifthTarget = ""

	settings.scores.Nuke.FirstName = ""
	settings.scores.Nuke.SecondName = ""
	settings.scores.Nuke.ThirdName = ""
	settings.scores.Nuke.FourthName = ""
	settings.scores.Nuke.FifthName = ""
	settings.scores.Nuke.FirstDamage = 0
	settings.scores.Nuke.SecondDamage = 0
	settings.scores.Nuke.ThirdDamage = 0
	settings.scores.Nuke.FourthDamage = 0
	settings.scores.Nuke.FifthDamage = 0

	settings.scores.MB.FirstName = ""
	settings.scores.MB.SecondName = ""
	settings.scores.MB.ThirdName = ""
	settings.scores.MB.FourthName = ""
	settings.scores.MB.FifthName = ""
	settings.scores.MB.FirstDamage = 0
	settings.scores.MB.SecondDamage = 0
	settings.scores.MB.ThirdDamage = 0
	settings.scores.MB.FourthDamage = 0
	settings.scores.MB.FifthDamage = 0
	settings.scores.MB.FirstSpell = ""
	settings.scores.MB.SecondSpell = ""
	settings.scores.MB.ThirdSpell = ""
	settings.scores.MB.FourthSpell = ""
	settings.scores.MB.FifthSpell = ""
	settings.scores.MB.FirstTarget = ""
	settings.scores.MB.SecondTarget = ""
	settings.scores.MB.ThirdTarget = ""
	settings.scores.MB.FourthTarget = ""
	settings.scores.MB.FifthTarget = ""

	settings.scores.Cure.FirstName = ""
	settings.scores.Cure.SecondName = ""
	settings.scores.Cure.ThirdName = ""
	settings.scores.Cure.FirstAmount = 0
	settings.scores.Cure.SecondAmount = 0
	settings.scores.Cure.ThirdAmount = 0
	settings:save('all')
end

CureThings = T{
	'Cure','Cure II','Cure III','Cure IV','Cure V','Cure VI','Curaga','Curaga II','Curaga III','Curaga IV','Curaga V','Cura','Cura II','Cura III','Pollen','Wild Carrot','Healing Breeze','Magic Fruit','Exuviation','Plenilune Embrace','White Wind','Restoral','Full Cure','Benediction','Repair','Curing Waltz','Curing Waltz II','Curing Waltz III','Curing Waltz IV','Curing Waltz V','Divine Waltz','Divine Waltz II','Life Cycle','Mending Halation','Vivacious Pulse','Healing Ruby','Healing Ruby II','Spring Water','Whispering Wind','Healing Breath','Healing Breath II','Healing Breath III','Healing Breath IV','Potion','Hi-Potion','X-Potion','Hyper Potion','Max. Potion','Mix: Max. Potion','Chakra'
    }

function get_actor(id)
	local actor = windower.ffxi.get_mob_by_id(id)
	if actor == nil then
		return false
	elseif not actor.in_alliance and not actor.in_party then
		return false
	else
		return actor
	end
end

windower.register_event('action',function(act)

	--Cures
	if act.category == 4 or act.category == 5 or act.category == 6 or act.category == 11 or act.category == 14 and Run and not Paused then
		local actor = get_actor(act.actor_id)

		if actor == false then
			return
		end

		local data = {}
		data.actor = actor.id
		data.actor_name = actor.name or 'Unknown'
		if act.category == 4 then 
			data.curething = (spells[act.param] and spells[act.param].english) or 'Unknown'
		elseif act.category == 5 then
			data.curething = (mabils[act.param] and mabils[act.param].english) or 'Unknown'
		elseif act.category == 6 or act.category == 14 then
			data.curething = (jabils[act.param] and jabils[act.param].english) or 'Unknown'
		elseif act.category == 11 then
			data.curething = (mabils[act.param] and mabils[act.param].english) or 'Unknown'
		end

		if CureThings:contains(data.curething) then
			local cures = cure[data.actor_name] or 0
			if act.target_count == 6 then
				cure[data.actor_name] = cures + act.targets[1].actions[1].param + act.targets[2].actions[1].param + act.targets[3].actions[1].param + act.targets[4].actions[1].param + act.targets[5].actions[1].param + act.targets[6].actions[1].param
			elseif act.target_count == 5 then
				cure[data.actor_name] = cures + act.targets[1].actions[1].param + act.targets[2].actions[1].param + act.targets[3].actions[1].param + act.targets[4].actions[1].param + act.targets[5].actions[1].param
			elseif act.target_count == 4 then
				cure[data.actor_name] = cures + act.targets[1].actions[1].param + act.targets[2].actions[1].param + act.targets[3].actions[1].param + act.targets[4].actions[1].param
			elseif act.target_count == 3 then
				cure[data.actor_name] = cures + act.targets[1].actions[1].param + act.targets[2].actions[1].param + act.targets[3].actions[1].param
			elseif act.target_count == 2 then
				cure[data.actor_name] = cures + act.targets[1].actions[1].param + act.targets[2].actions[1].param
			else
				cure[data.actor_name] = cures + act.targets[1].actions[1].param
			end

			if cure[data.actor_name] > settings.scores.Cure.FirstAmount then
				if data.actor_name == settings.scores.Cure.FirstName or settings.scores.Cure.FirstAmount == 0 then
					--First Place extends their lead (or the first cure)
					settings.scores.Cure.FirstName = data.actor_name
					settings.scores.Cure.FirstAmount = cure[data.actor_name]
					settings:save('all')
				elseif data.actor_name == settings.scores.Cure.SecondName then
					--Second Place moves into First Place
					settings.scores.Cure.SecondName = settings.scores.Cure.FirstName
					settings.scores.Cure.FirstName = data.actor_name
					settings.scores.Cure.SecondAmount = settings.scores.Cure.FirstAmount
					settings.scores.Cure.FirstAmount = cure[data.actor_name]
					settings:save('all')
				else
					--Third Place or lower moves into First Place
					settings.scores.Cure.ThirdName = settings.scores.Cure.SecondName
					settings.scores.Cure.SecondName = settings.scores.Cure.FirstName
					settings.scores.Cure.FirstName = data.actor_name
					settings.scores.Cure.ThirdAmount = settings.scores.Cure.SecondAmount
					settings.scores.Cure.SecondAmount = settings.scores.Cure.FirstAmount
					settings.scores.Cure.FirstAmount = cure[data.actor_name]
					settings:save('all')
				end
			elseif cure[data.actor_name] > settings.scores.Cure.SecondAmount then
				if data.actor_name == settings.scores.Cure.SecondName or (data.actor_name ~= settings.scores.Cure.FirstName and settings.scores.Cure.SecondAmount == 0) then
					--Second Place updates their best but stays in Second Place (or the second cure)
					settings.scores.Cure.SecondName = data.actor_name
					settings.scores.Cure.SecondAmount = cure[data.actor_name]
					settings:save('all')
				elseif data.actor_name ~= settings.scores.Cure.FirstName then
					--Third Place or lower moves into Second Place
					settings.scores.Cure.ThirdName = settings.scores.Cure.SecondName
					settings.scores.Cure.SecondName = data.actor_name
					settings.scores.Cure.ThirdAmount = settings.scores.Cure.SecondAmount
					settings.scores.Cure.SecondAmount = cure[data.actor_name]
					settings:save('all')
				end
			elseif cure[data.actor_name] > settings.scores.Cure.ThirdAmount and data.actor_name ~= settings.scores.Cure.FirstName and data.actor_name ~= settings.scores.Cure.SecondName then
				--Third Place updates their best or somebody not already on the board moves into Third Place
				settings.scores.Cure.ThirdName = data.actor_name
				settings.scores.Cure.ThirdAmount = cure[data.actor_name]
				settings:save('all')
			end
		end

	elseif act.category == 3 and Run and not Paused then
		local actor = get_actor(act.actor_id)

		if actor == false then
			return
		end

		local data = {}
		data.actor = actor.id
		data.actor_name = actor.name or 'Unknown'
		data.target = act.targets[1].id
		data.target_name = windower.ffxi.get_mob_by_id(data.target).name or 'Unknown'
		data.damage = act.targets[1].actions[1].param
		data.ws = weaponskills[act.param] and weaponskills[act.param].english or 'Unknown'
		data.spell = spells[act.param] and spells[act.param].english or 'Unknown'
		data.jabils = jabils[act.param] and jabils[act.param].english or 'Unknown'

		if data.ws == 'Atonement' or data.ws == 'Flat Blade' or data.ws == 'Tachi: Hobaku' or data.ws == 'Shoulder Tackle' or data.ws == 'Leg Sweep' or data.ws == 'Myrkr' or data.ws == 'Starlight' or data.ws == 'Moonlight' or data.ws == 'Energy Drain' and (act.targets[1].actions[1].message == 185 or act.targets[1].actions[1].message == 188) then
			return
		end

		--Whiffs
		if act.targets[1].actions[1].message == 188 or act.targets[1].actions[1].message == 31 or (act.targets[1].actions[1].message == 185 and data.damage == 0) then --Uses Weapon Skill but misses, gets blinked, or hits for 0
			local whiffs = whiff[data.actor_name] or 0
			whiff[data.actor_name] = whiffs+1
			if Mode ~= "Silent" then
				if whiff[data.actor_name] == 10 and data.actor_name == settings.scores.Whiff.FirstName then
					say:schedule(1,'/p '..data.actor_name..' whiffs '..data.ws..' and is the first to hit the whiff spam wall.')
				elseif whiff[data.actor_name] == 10 then
					say:schedule(1,'/p '..data.actor_name..' whiffs '..data.ws..' and has hit the whiff spam wall.')
				elseif whiff[data.actor_name] > 5 and whiffs < 10 then
					if Mode == "Normal" then
						say:schedule(1,'/p '..data.actor_name..' whiffs '..data.ws..' yet again...')
					end
				elseif whiff[data.actor_name] == 5 then
					say:schedule(1,'/p '..data.actor_name..' whiffs '..data.ws..' and is halfway to the whiff spam wall.')
				elseif whiff[data.actor_name] > 1 and whiff[data.actor_name] < 5 then
					if Mode == "Normal" then
						say:schedule(1,'/p '..data.actor_name..' whiffs '..data.ws..' again... ')
					end
				elseif whiff[data.actor_name] == 1 then
					if Mode == "Normal" then
						say:schedule(1,'/p '..data.actor_name..' whiffs '..data.ws..'...')
					end
				end
			end

			if whiff[data.actor_name] > settings.scores.Whiff.FirstAmount then
				if data.actor_name == settings.scores.Whiff.FirstName or settings.scores.Whiff.FirstAmount == 0 then
					--First Place extends their lead (or the first whiff)
					settings.scores.Whiff.FirstName = data.actor_name
					settings.scores.Whiff.FirstAmount = whiff[data.actor_name]
					settings:save('all')
				elseif data.actor_name == settings.scores.Whiff.SecondName then
					--Second Place moves into First Place
					settings.scores.Whiff.SecondName = settings.scores.Whiff.FirstName
					settings.scores.Whiff.FirstName = data.actor_name
					settings.scores.Whiff.SecondAmount = settings.scores.Whiff.FirstAmount
					settings.scores.Whiff.FirstAmount = whiff[data.actor_name]
					settings:save('all')
				elseif data.actor_name ~= settings.scores.Whiff.FirstName and data.actor_name ~= settings.scores.Whiff.SecondName then
					--Third Place or lower moves into First Place
					settings.scores.Whiff.ThirdName = settings.scores.Whiff.SecondName
					settings.scores.Whiff.SecondName = settings.scores.Whiff.FirstName
					settings.scores.Whiff.FirstName = data.actor_name
					settings.scores.Whiff.ThirdAmount = settings.scores.Whiff.SecondAmount
					settings.scores.Whiff.SecondAmount = settings.scores.Whiff.FirstAmount
					settings.scores.Whiff.FirstAmount = whiff[data.actor_name]
					settings:save('all')
				end
			elseif whiff[data.actor_name] > settings.scores.Whiff.SecondAmount then
				if data.actor_name == settings.scores.Whiff.SecondName or (data.actor_name ~= settings.scores.Whiff.FirstName and settings.scores.Whiff.SecondAmount == 0) then
					--Second Place updates their best but stays in Second Place (or the second whiff)
					settings.scores.Whiff.SecondName = data.actor_name
					settings.scores.Whiff.SecondAmount = whiff[data.actor_name]
					settings:save('all')
				elseif data.actor_name ~= settings.scores.Whiff.FirstName then
					--Third Place or lower moves into Second Place
					settings.scores.Whiff.ThirdName = settings.scores.Whiff.SecondName
					settings.scores.Whiff.SecondName = data.actor_name
					settings.scores.Whiff.ThirdAmount = settings.scores.Whiff.SecondAmount
					settings.scores.Whiff.SecondAmount = whiff[data.actor_name]
					settings:save('all')
				end
			elseif whiff[data.actor_name] > settings.scores.Whiff.ThirdAmount and data.actor_name ~= settings.scores.Whiff.FirstName and data.actor_name ~= settings.scores.Whiff.SecondName then
				--Third Place (or Lower) updates their best (or moves into Third Place)
				settings.scores.Whiff.ThirdName = data.actor_name
				settings.scores.Whiff.ThirdAmount = whiff[data.actor_name]
				settings:save('all')
			end

		elseif act.targets[1].actions[1].message == 185 then

			--Skillchains
			if act.targets[1].actions[1].has_add_effect == true then

				local actor = get_actor(act.actor_id)

				if actor == false then
					return
				end

				local sc = {} sc[1] = 'Light' sc[2] = 'Dark' sc[3] = 'Gravitation' sc[4] = 'Fragmentation' sc[5] = 'Distortion' sc[6] = 'Fusion' sc[7] = 'Compression' sc[8] = 'Liquefaction' sc[9] = 'Induration' sc[10] = 'Reverberation' sc[11] = 'Transfixion' sc[12] = 'Scission' sc[13] = 'Detonation' sc[14] = 'Impaction' sc[15] = 'Radiance' sc[16] = 'Umbra'

				local data = {}
				data.actor = actor.id
				data.actor_name = actor.name or 'Unknown'
				data.target = act.targets[1].id
				data.target_name = windower.ffxi.get_mob_by_id(data.target).name or 'Unknown'
				data.damage = act.targets[1].actions[1].add_effect_param
				data.sc = sc[act.targets[1].actions[1].add_effect_animation] or 'Unknown'

				if data.damage > settings.scores.SC.FirstDamage then
					if data.actor_name == settings.scores.SC.FirstName or settings.scores.SC.FirstDamage == 0 then 
						--First Place extends their lead (or the first sc)
						settings.scores.SC.FirstName = data.actor_name
						settings.scores.SC.FirstDamage = data.damage
						settings.scores.SC.FirstSC = data.sc
						settings.scores.SC.FirstTarget = data.target_name
						settings:save('all')
					elseif data.actor_name == settings.scores.SC.SecondName then
						--Second Place moves into First Place
						settings.scores.SC.SecondName = settings.scores.SC.FirstName
						settings.scores.SC.FirstName = data.actor_name
						settings.scores.SC.SecondDamage = settings.scores.SC.FirstDamage
						settings.scores.SC.FirstDamage = data.damage
						settings.scores.SC.SecondSC = settings.scores.SC.FirstSC
						settings.scores.SC.FirstSC = data.sc
						settings.scores.SC.SecondTarget = settings.scores.SC.FirstTarget
						settings.scores.SC.FirstTarget = data.target_name
						settings:save('all')
					elseif data.actor_name == settings.scores.SC.ThirdName then
						--Third Place moves into First Place
						settings.scores.SC.ThirdName = settings.scores.SC.SecondName
						settings.scores.SC.SecondName = settings.scores.SC.FirstName
						settings.scores.SC.FirstName = data.actor_name
						settings.scores.SC.ThirdDamage = settings.scores.SC.SecondDamage
						settings.scores.SC.SecondDamage = settings.scores.SC.FirstDamage
						settings.scores.SC.FirstDamage = data.damage
						settings.scores.SC.ThirdSC = settings.scores.SC.SecondSC
						settings.scores.SC.SecondSC = settings.scores.SC.FirstSC
						settings.scores.SC.FirstSC = data.sc
						settings.scores.SC.ThirdTarget = settings.scores.SC.SecondTarget
						settings.scores.SC.SecondTarget = settings.scores.SC.FirstTarget
						settings.scores.SC.FirstTarget = data.target_name
						settings:save('all')
					elseif data.actor_name == settings.scores.SC.FourthName then
						--Fourth Place moves into First Place
						settings.scores.SC.FourthName = settings.scores.SC.ThirdName
						settings.scores.SC.ThirdName = settings.scores.SC.SecondName
						settings.scores.SC.SecondName = settings.scores.SC.FirstName
						settings.scores.SC.FirstName = data.actor_name
						settings.scores.SC.FourthDamage = settings.scores.SC.ThirdDamage
						settings.scores.SC.ThirdDamage = settings.scores.SC.SecondDamage
						settings.scores.SC.SecondDamage = settings.scores.SC.FirstDamage
						settings.scores.SC.FirstDamage = data.damage
						settings.scores.SC.FourthSC = settings.scores.SC.ThirdSC
						settings.scores.SC.ThirdSC = settings.scores.SC.SecondSC
						settings.scores.SC.SecondSC = settings.scores.SC.FirstSC
						settings.scores.SC.FirstSC = data.sc
						settings.scores.SC.FourthTarget = settings.scores.SC.ThirdTarget
						settings.scores.SC.ThirdTarget = settings.scores.SC.SecondTarget
						settings.scores.SC.SecondTarget = settings.scores.SC.FirstTarget
						settings.scores.SC.FirstTarget = data.target_name
						settings:save('all')
					else
						--Fifth Place or somebody not already on the board moves into First Place
						settings.scores.SC.FifthName = settings.scores.SC.FourthName
						settings.scores.SC.FourthName = settings.scores.SC.ThirdName
						settings.scores.SC.ThirdName = settings.scores.SC.SecondName
						settings.scores.SC.SecondName = settings.scores.SC.FirstName
						settings.scores.SC.FirstName = data.actor_name
						settings.scores.SC.FifthDamage = settings.scores.SC.FourthDamage
						settings.scores.SC.FourthDamage = settings.scores.SC.ThirdDamage
						settings.scores.SC.ThirdDamage = settings.scores.SC.SecondDamage
						settings.scores.SC.SecondDamage = settings.scores.SC.FirstDamage
						settings.scores.SC.FirstDamage = data.damage
						settings.scores.SC.FifthSC = settings.scores.SC.FourthSC
						settings.scores.SC.FourthSC = settings.scores.SC.ThirdSC
						settings.scores.SC.ThirdSC = settings.scores.SC.SecondSC
						settings.scores.SC.SecondSC = settings.scores.SC.FirstSC
						settings.scores.SC.FirstSC = data.sc
						settings.scores.SC.FifthTarget = settings.scores.SC.FourthTarget
						settings.scores.SC.FourthTarget = settings.scores.SC.ThirdTarget
						settings.scores.SC.ThirdTarget = settings.scores.SC.SecondTarget
						settings.scores.SC.SecondTarget = settings.scores.SC.FirstTarget
						settings.scores.SC.FirstTarget = data.target_name
						settings:save('all')
					end
					if Mode ~= "Silent" then
						coroutine.sleep(1)
						say('/p New SKILLCHAIN HIGH Score! '..settings.scores.SC.FirstName..' with a '..settings.scores.SC.FirstDamage..' '..settings.scores.SC.FirstSC..' on '..settings.scores.SC.FirstTarget..'')
					end
				elseif data.damage > settings.scores.SC.SecondDamage then
					if data.actor_name == settings.scores.SC.SecondName or (data.actor_name ~= settings.scores.SC.FirstName and settings.scores.SC.SecondDamage == 0) then
						--Second Place updates their best but stays in Second Place (or the second mb)
						settings.scores.SC.SecondName = data.actor_name
						settings.scores.SC.SecondDamage = data.damage
						settings.scores.SC.SecondSC = data.sc
						settings.scores.SC.SecondTarget = data.target_name
						settings:save('all')
					elseif data.actor_name == settings.scores.SC.ThirdName then
						--Third Place moves into Second Place
						settings.scores.SC.ThirdName = settings.scores.SC.SecondName
						settings.scores.SC.SecondName = data.actor_name
						settings.scores.SC.ThirdDamage = settings.scores.SC.SecondDamage
						settings.scores.SC.SecondDamage = data.damage
						settings.scores.SC.ThirdSC = settings.scores.SC.SecondSC
						settings.scores.SC.SecondSC = data.sc
						settings.scores.SC.ThirdTarget = settings.scores.SC.SecondTarget
						settings.scores.SC.SecondTarget = data.target_name
						settings:save('all')
						if Mode == "Normal" then
							coroutine.sleep(1)
							say('/p SKILLCHAIN: '..settings.scores.SC.SecondName..' moves into the No.2 slot with a '..settings.scores.SC.SecondDamage..' '..settings.scores.SC.SecondSC..' on '..settings.scores.SC.SecondTarget..'')
						end
					elseif data.actor_name == settings.scores.SC.FourthName then
						--Fourth Place moves into Second Place
						settings.scores.SC.FourthName = settings.scores.SC.ThirdName
						settings.scores.SC.ThirdName = settings.scores.SC.SecondName
						settings.scores.SC.SecondName = data.actor_name
						settings.scores.SC.FourthDamage = settings.scores.SC.ThirdDamage
						settings.scores.SC.ThirdDamage = settings.scores.SC.SecondDamage
						settings.scores.SC.SecondDamage = data.damage
						settings.scores.SC.FourthSC = settings.scores.SC.ThirdSC
						settings.scores.SC.ThirdSC = settings.scores.SC.SecondSC
						settings.scores.SC.SecondSC = data.sc
						settings.scores.SC.FourthTarget = settings.scores.SC.ThirdTarget
						settings.scores.SC.ThirdTarget = settings.scores.SC.SecondTarget
						settings.scores.SC.SecondTarget = data.target_name
						settings:save('all')
						if Mode == "Normal" then
							coroutine.sleep(1)
							say('/p SKILLCHAIN: '..settings.scores.SC.SecondName..' moves into the No.2 slot with a '..settings.scores.SC.SecondDamage..' '..settings.scores.SC.SecondSC..' on '..settings.scores.SC.SecondTarget..'')
						end
					elseif data.actor_name ~= settings.scores.SC.FirstName then
						--Fifth Place or somebody not already on the board moves into Second Place
						settings.scores.SC.FifthName = settings.scores.SC.FourthName
						settings.scores.SC.FourthName = settings.scores.SC.ThirdName
						settings.scores.SC.ThirdName = settings.scores.SC.SecondName
						settings.scores.SC.SecondName = data.actor_name
						settings.scores.SC.FifthDamage = settings.scores.SC.FourthDamage
						settings.scores.SC.FourthDamage = settings.scores.SC.ThirdDamage
						settings.scores.SC.ThirdDamage = settings.scores.SC.SecondDamage
						settings.scores.SC.SecondDamage = data.damage
						settings.scores.SC.FifthSC = settings.scores.SC.FourthSC
						settings.scores.SC.FourthSC = settings.scores.SC.ThirdSC
						settings.scores.SC.ThirdSC = settings.scores.SC.SecondSC
						settings.scores.SC.SecondSC = data.sc
						settings.scores.SC.FifthTarget  = settings.scores.SC.FourthTarget
						settings.scores.SC.FourthTarget = settings.scores.SC.ThirdTarget
						settings.scores.SC.ThirdTarget = settings.scores.SC.SecondTarget
						settings.scores.SC.SecondTarget = data.target_name
						settings:save('all')
						if Mode == "Normal" then
							coroutine.sleep(1)
							say('/p SKILLCHAIN: '..settings.scores.SC.SecondName..' moves into the No.2 slot with a '..settings.scores.SC.SecondDamage..' '..settings.scores.SC.SecondSC..' on '..settings.scores.SC.SecondTarget..'')
						end
					end
				elseif data.damage > settings.scores.SC.ThirdDamage then
					if data.actor_name == settings.scores.SC.ThirdName or (data.actor_name ~= settings.scores.SC.FirstName and data.actor_name ~= settings.scores.SC.SecondName and settings.scores.SC.ThirdDamage == 0) then
						--Third Place updates their best but stays in Third Place (or the third sc)
						settings.scores.SC.ThirdName = data.actor_name
						settings.scores.SC.ThirdDamage = data.damage
						settings.scores.SC.ThirdSC = data.sc
						settings.scores.SC.ThirdTarget = data.target_name
						settings:save('all')
					elseif data.actor_name == settings.scores.SC.FourthName then
						--Fourth Place moves into Third Place
						settings.scores.SC.FourthName = settings.scores.SC.ThirdName
						settings.scores.SC.ThirdName = data.actor_name
						settings.scores.SC.FourthDamage = settings.scores.SC.ThirdDamage
						settings.scores.SC.ThirdDamage = data.damage
						settings.scores.SC.FourthSC = settings.scores.SC.ThirdSC
						settings.scores.SC.ThirdSC = data.sc
						settings.scores.SC.FourthTarget = settings.scores.SC.ThirdTarget
						settings.scores.SC.ThirdTarget = data.target_name
						settings:save('all')
						if Mode == "Normal" then
							coroutine.sleep(1)
							say('/p SKILLCHAIN: '..settings.scores.SC.ThirdName..' moves into the No.3 slot with a '..settings.scores.SC.ThirdDamage..' '..settings.scores.SC.ThirdSC..' on '..settings.scores.SC.ThirdTarget..'')
						end
					elseif data.actor_name ~= settings.scores.SC.FirstName and data.actor_name ~= settings.scores.SC.SecondName then
						--Fifth Place or somebody not already on the board moves into Third Place
						settings.scores.SC.FifthName = settings.scores.SC.FourthName
						settings.scores.SC.FourthName = settings.scores.SC.ThirdName
						settings.scores.SC.ThirdName = data.actor_name
						settings.scores.SC.FifthDamage = settings.scores.SC.FourthDamage
						settings.scores.SC.FourthDamage = settings.scores.SC.ThirdDamage
						settings.scores.SC.ThirdDamage = data.damage
						settings.scores.SC.FifthSC = settings.scores.SC.FourthSC
						settings.scores.SC.FourthSC = settings.scores.SC.ThirdSC
						settings.scores.SC.ThirdSC = data.sc
						settings.scores.SC.FifthTarget = settings.scores.SC.FourthTarget
						settings.scores.SC.FourthTarget = settings.scores.SC.ThirdTarget
						settings.scores.SC.ThirdTarget = data.target_name
						settings:save('all')
						if Mode == "Normal" then
							coroutine.sleep(1)
							say('/p SKILLCHAIN: '..settings.scores.SC.ThirdName..' moves into the No.3 slot with a '..settings.scores.SC.ThirdDamage..' '..settings.scores.SC.ThirdSC..' on '..settings.scores.SC.ThirdTarget..'')
						end
					end
				elseif data.damage > settings.scores.SC.FourthDamage then
					if data.actor_name == settings.scores.SC.FourthName or (data.actor_name ~= settings.scores.SC.FirstName and data.actor_name ~= settings.scores.SC.SecondName and data.actor_name ~= settings.scores.SC.ThirdName and settings.scores.SC.FourthDamage == 0) then
						--Fourth Place updates their best but stays in Fourth Place (or the fourth sc)
						settings.scores.SC.FourthName = data.actor_name
						settings.scores.SC.FourthDamage = data.damage
						settings.scores.SC.FourthSC = data.sc
						settings.scores.SC.FourthTarget = data.target_name
						settings:save('all')
					elseif data.actor_name ~= settings.scores.SC.FirstName and data.actor_name ~= settings.scores.SC.SecondName and data.actor_name ~= settings.scores.SC.ThirdName then
						--Fifth Place or somebody not already on the board moves into Fourth Place
						settings.scores.SC.FifthName = settings.scores.SC.FourthName
						settings.scores.SC.FourthName = data.actor_name
						settings.scores.SC.FifthDamage = settings.scores.SC.FourthDamage
						settings.scores.SC.FourthDamage = data.damage
						settings.scores.SC.FifthSC = settings.scores.SC.FourthSC
						settings.scores.SC.FourthSC = data.sc
						settings.scores.SC.FifthTarget = settings.scores.SC.FourthTarget
						settings.scores.SC.FourthTarget = data.target_name
						settings:save('all')
						if Mode == "Normal" then
							coroutine.sleep(1)
							say('/p SKILLCHAIN: '..settings.scores.SC.FourthName..' moves into the No.4 slot with a '..settings.scores.SC.FourthDamage..' '..settings.scores.SC.FourthSC..' on '..settings.scores.SC.FourthTarget..'')
						end
					end
				elseif data.damage > settings.scores.SC.FifthDamage then
					--Fifth Place or somebody not already on the board moves into Fifth Place
					if data.actor_name == settings.scores.SC.FifthName or (data.actor_name ~= settings.scores.SC.FirstName and data.actor_name ~= settings.scores.SC.SecondName and data.actor_name ~= settings.scores.SC.ThirdName and data.actor_name ~= settings.scores.SC.FourthName and settings.scores.SC.FifthDamage == 0) then
						--Fifth Place updates their best but stays in Fifth Place (or the fifth sc)
						settings.scores.SC.FifthName = data.actor_name
						settings.scores.SC.FifthDamage = data.damage
						settings.scores.SC.FifthSC = data.sc
						settings.scores.SC.FifthTarget = data.target_name
						settings:save('all')
					elseif data.actor_name ~= settings.scores.SC.FirstName and data.actor_name ~= settings.scores.SC.SecondName and data.actor_name ~= settings.scores.SC.ThirdName and data.actor_name ~= settings.scores.SC.FourthName then
						--Somebody not already on the board moves into Fifth Place
						settings.scores.SC.FifthName = data.actor_name
						settings.scores.SC.FifthDamage = data.damage
						settings.scores.SC.FifthSC = data.sc
						settings.scores.SC.FifthTarget = data.target_name
						settings:save('all')
						if Mode == "Normal" then
							coroutine.sleep(1)
							say('/p SKILLCHAIN: '..settings.scores.SC.FifthName..' moves into the No.5 slot with a '..settings.scores.SC.FifthDamage..' '..settings.scores.SC.FifthSC..' on '..settings.scores.SC.FifthTarget..'')
						end
					end
				end

			end

			--WS High Score
			if data.damage > settings.scores.HS.FirstDamage then
				if data.actor_name == settings.scores.HS.FirstName or settings.scores.HS.FirstDamage == 0 then 
					--First Place extends their lead (or the first ws)
					settings.scores.HS.FirstName = data.actor_name
					settings.scores.HS.FirstDamage = data.damage
					settings.scores.HS.FirstWS = data.ws
					settings.scores.HS.FirstTarget = data.target_name
					settings:save('all')
				elseif data.actor_name == settings.scores.HS.SecondName then
					--Second Place moves into First Place
					settings.scores.HS.SecondName = settings.scores.HS.FirstName
					settings.scores.HS.FirstName = data.actor_name
					settings.scores.HS.SecondDamage = settings.scores.HS.FirstDamage
					settings.scores.HS.FirstDamage = data.damage
					settings.scores.HS.SecondWS = settings.scores.HS.FirstWS
					settings.scores.HS.FirstWS = data.ws
					settings.scores.HS.SecondTarget = settings.scores.HS.FirstTarget
					settings.scores.HS.FirstTarget = data.target_name
					settings:save('all')
				elseif data.actor_name == settings.scores.HS.ThirdName then
					--Third Place moves into First Place
					settings.scores.HS.ThirdName = settings.scores.HS.SecondName
					settings.scores.HS.SecondName = settings.scores.HS.FirstName
					settings.scores.HS.FirstName = data.actor_name
					settings.scores.HS.ThirdDamage = settings.scores.HS.SecondDamage
					settings.scores.HS.SecondDamage = settings.scores.HS.FirstDamage
					settings.scores.HS.FirstDamage = data.damage
					settings.scores.HS.ThirdWS = settings.scores.HS.SecondWS
					settings.scores.HS.SecondWS = settings.scores.HS.FirstWS
					settings.scores.HS.FirstWS = data.ws
					settings.scores.HS.ThirdTarget = settings.scores.HS.SecondTarget
					settings.scores.HS.SecondTarget = settings.scores.HS.FirstTarget
					settings.scores.HS.FirstTarget = data.target_name
					settings:save('all')
				elseif data.actor_name == settings.scores.HS.FourthName then
					--Fourth Place moves into First Place
					settings.scores.HS.FourthName = settings.scores.HS.ThirdName
					settings.scores.HS.ThirdName = settings.scores.HS.SecondName
					settings.scores.HS.SecondName = settings.scores.HS.FirstName
					settings.scores.HS.FirstName = data.actor_name
					settings.scores.HS.FourthDamage = settings.scores.HS.ThirdDamage
					settings.scores.HS.ThirdDamage = settings.scores.HS.SecondDamage
					settings.scores.HS.SecondDamage = settings.scores.HS.FirstDamage
					settings.scores.HS.FirstDamage = data.damage
					settings.scores.HS.FourthWS = settings.scores.HS.ThirdWS
					settings.scores.HS.ThirdWS = settings.scores.HS.SecondWS
					settings.scores.HS.SecondWS = settings.scores.HS.FirstWS
					settings.scores.HS.FirstWS = data.ws
					settings.scores.HS.FourthTarget = settings.scores.HS.ThirdTarget
					settings.scores.HS.ThirdTarget = settings.scores.HS.SecondTarget
					settings.scores.HS.SecondTarget = settings.scores.HS.FirstTarget
					settings.scores.HS.FirstTarget = data.target_name
					settings:save('all')
				else
					--Fifth Place or somebody not already on the board moves into First Place
					settings.scores.HS.FifthName = settings.scores.HS.FourthName
					settings.scores.HS.FourthName = settings.scores.HS.ThirdName
					settings.scores.HS.ThirdName = settings.scores.HS.SecondName
					settings.scores.HS.SecondName = settings.scores.HS.FirstName
					settings.scores.HS.FirstName = data.actor_name
					settings.scores.HS.FifthDamage = settings.scores.HS.FourthDamage
					settings.scores.HS.FourthDamage = settings.scores.HS.ThirdDamage
					settings.scores.HS.ThirdDamage = settings.scores.HS.SecondDamage
					settings.scores.HS.SecondDamage = settings.scores.HS.FirstDamage
					settings.scores.HS.FirstDamage = data.damage
					settings.scores.HS.FifthWS = settings.scores.HS.FourthWS
					settings.scores.HS.FourthWS = settings.scores.HS.ThirdWS
					settings.scores.HS.ThirdWS = settings.scores.HS.SecondWS
					settings.scores.HS.SecondWS = settings.scores.HS.FirstWS
					settings.scores.HS.FirstWS = data.ws
					settings.scores.HS.FifthTarget = settings.scores.HS.FourthTarget
					settings.scores.HS.FourthTarget = settings.scores.HS.ThirdTarget
					settings.scores.HS.ThirdTarget = settings.scores.HS.SecondTarget
					settings.scores.HS.SecondTarget = settings.scores.HS.FirstTarget
					settings.scores.HS.FirstTarget = data.target_name
					settings:save('all')
				end
				settings:save('all')
				if Mode ~= "Silent" then
					coroutine.sleep(1)
					say('/p New WS HIGH Score! '..settings.scores.HS.FirstName..' with a '..settings.scores.HS.FirstDamage..' '..settings.scores.HS.FirstWS..' on '..settings.scores.HS.FirstTarget..'')
				end
			elseif data.damage > settings.scores.HS.SecondDamage then
				if data.actor_name == settings.scores.HS.SecondName or (data.actor_name ~= settings.scores.HS.FirstName and settings.scores.HS.SecondDamage == 0) then
					--Second Place updates their best but stays in Second Place (or the second ws)
					settings.scores.HS.SecondName = data.actor_name
					settings.scores.HS.SecondDamage = data.damage
					settings.scores.HS.SecondWS = data.ws
					settings.scores.HS.SecondTarget = data.target_name
					settings:save('all')
				elseif data.actor_name == settings.scores.HS.ThirdName then
					--Third Place moves into Second Place
					settings.scores.HS.ThirdName = settings.scores.HS.SecondName
					settings.scores.HS.SecondName = data.actor_name
					settings.scores.HS.ThirdDamage = settings.scores.HS.SecondDamage
					settings.scores.HS.SecondDamage = data.damage
					settings.scores.HS.ThirdWS = settings.scores.HS.SecondWS
					settings.scores.HS.SecondWS = data.ws
					settings.scores.HS.ThirdTarget = settings.scores.HS.SecondTarget
					settings.scores.HS.SecondTarget = data.target_name
					settings:save('all')
					if Mode == "Normal" then
						coroutine.sleep(1)
						say('/p WS HIGH Score: '..settings.scores.HS.SecondName..' moves into the No.2 slot with a '..settings.scores.HS.SecondDamage..' '..settings.scores.HS.SecondWS..' on '..settings.scores.HS.SecondTarget..'')
					end
				elseif data.actor_name == settings.scores.HS.FourthName then
					--Fourth Place moves into Second Place
					settings.scores.HS.FourthName = settings.scores.HS.ThirdName
					settings.scores.HS.ThirdName = settings.scores.HS.SecondName
					settings.scores.HS.SecondName = data.actor_name
					settings.scores.HS.FourthDamage = settings.scores.HS.ThirdDamage
					settings.scores.HS.ThirdDamage = settings.scores.HS.SecondDamage
					settings.scores.HS.SecondDamage = data.damage
					settings.scores.HS.FourthWS = settings.scores.HS.ThirdWS
					settings.scores.HS.ThirdWS = settings.scores.HS.SecondWS
					settings.scores.HS.SecondWS = data.ws
					settings.scores.HS.FourthTarget = settings.scores.HS.ThirdTarget
					settings.scores.HS.ThirdTarget = settings.scores.HS.SecondTarget
					settings.scores.HS.SecondTarget = data.target_name
					settings:save('all')
					if Mode == "Normal" then
						coroutine.sleep(1)
						say('/p WS HIGH Score: '..settings.scores.HS.SecondName..' moves into the No.2 slot with a '..settings.scores.HS.SecondDamage..' '..settings.scores.HS.SecondWS..' on '..settings.scores.HS.SecondTarget..'')
					end
				elseif data.actor_name ~= settings.scores.HS.FirstName then
					--Fifth Place or somebody not already on the board moves into Second Place
					settings.scores.HS.FifthName = settings.scores.HS.FourthName
					settings.scores.HS.FourthName = settings.scores.HS.ThirdName
					settings.scores.HS.ThirdName = settings.scores.HS.SecondName
					settings.scores.HS.SecondName = data.actor_name
					settings.scores.HS.FifthDamage = settings.scores.HS.FourthDamage
					settings.scores.HS.FourthDamage = settings.scores.HS.ThirdDamage
					settings.scores.HS.ThirdDamage = settings.scores.HS.SecondDamage
					settings.scores.HS.SecondDamage = data.damage
					settings.scores.HS.FifthWS = settings.scores.HS.FourthWS
					settings.scores.HS.FourthWS = settings.scores.HS.ThirdWS
					settings.scores.HS.ThirdWS = settings.scores.HS.SecondWS
					settings.scores.HS.SecondWS = data.ws
					settings.scores.HS.FifthTarget  = settings.scores.HS.FourthTarget
					settings.scores.HS.FourthTarget = settings.scores.HS.ThirdTarget
					settings.scores.HS.ThirdTarget = settings.scores.HS.SecondTarget
					settings.scores.HS.SecondTarget = data.target_name
					settings:save('all')
					if Mode == "Normal" then
						coroutine.sleep(1)
						say('/p WS HIGH Score: '..settings.scores.HS.SecondName..' moves into the No.2 slot with a '..settings.scores.HS.SecondDamage..' '..settings.scores.HS.SecondWS..' on '..settings.scores.HS.SecondTarget..'')
					end
				end
			elseif data.damage > settings.scores.HS.ThirdDamage then
				if data.actor_name == settings.scores.HS.ThirdName or (data.actor_name ~= settings.scores.HS.FirstName and data.actor_name ~= settings.scores.HS.SecondName and settings.scores.HS.ThirdDamage == 0) then
					--Third Place updates their best but stays in Third Place (or the third ws)
					settings.scores.HS.ThirdName = data.actor_name
					settings.scores.HS.ThirdDamage = data.damage
					settings.scores.HS.ThirdWS = data.ws
					settings.scores.HS.ThirdTarget = data.target_name
					settings:save('all')
				elseif data.actor_name == settings.scores.HS.FourthName then
					--Fourth Place moves into Third Place
					settings.scores.HS.FourthName = settings.scores.HS.ThirdName
					settings.scores.HS.ThirdName = data.actor_name
					settings.scores.HS.FourthDamage = settings.scores.HS.ThirdDamage
					settings.scores.HS.ThirdDamage = data.damage
					settings.scores.HS.FourthWS = settings.scores.HS.ThirdWS
					settings.scores.HS.ThirdWS = data.ws
					settings.scores.HS.FourthTarget = settings.scores.HS.ThirdTarget
					settings.scores.HS.ThirdTarget = data.target_name
					settings:save('all')
					if Mode == "Normal" then
						coroutine.sleep(1)
						say('/p WS HIGH Score: '..settings.scores.HS.ThirdName..' moves into the No.3 slot with a '..settings.scores.HS.ThirdDamage..' '..settings.scores.HS.ThirdWS..' on '..settings.scores.HS.ThirdTarget..'')
					end
				elseif data.actor_name ~= settings.scores.HS.FirstName and data.actor_name ~= settings.scores.HS.SecondName then
					--Fifth Place or somebody not already on the board moves into Third Place
					settings.scores.HS.FifthName = settings.scores.HS.FourthName
					settings.scores.HS.FourthName = settings.scores.HS.ThirdName
					settings.scores.HS.ThirdName = data.actor_name
					settings.scores.HS.FifthDamage = settings.scores.HS.FourthDamage
					settings.scores.HS.FourthDamage = settings.scores.HS.ThirdDamage
					settings.scores.HS.ThirdDamage = data.damage
					settings.scores.HS.FifthWS = settings.scores.HS.FourthWS
					settings.scores.HS.FourthWS = settings.scores.HS.ThirdWS
					settings.scores.HS.ThirdWS = data.ws
					settings.scores.HS.FifthTarget = settings.scores.HS.FourthTarget
					settings.scores.HS.FourthTarget = settings.scores.HS.ThirdTarget
					settings.scores.HS.ThirdTarget = data.target_name
					settings:save('all')
					if Mode == "Normal" then
						coroutine.sleep(1)
						say('/p WS HIGH Score: '..settings.scores.HS.ThirdName..' moves into the No.3 slot with a '..settings.scores.HS.ThirdDamage..' '..settings.scores.HS.ThirdWS..' on '..settings.scores.HS.ThirdTarget..'')
					end
				end
			elseif data.damage > settings.scores.HS.FourthDamage then
				if data.actor_name == settings.scores.HS.FourthName or (data.actor_name ~= settings.scores.HS.FirstName and data.actor_name ~= settings.scores.HS.SecondName and data.actor_name ~= settings.scores.HS.ThirdName and settings.scores.HS.FourthDamage == 0) then
					--Fourth Place updates their best but stays in Fourth Place (or the fourth ws)
					settings.scores.HS.FourthName = data.actor_name
					settings.scores.HS.FourthDamage = data.damage
					settings.scores.HS.FourthWS = data.ws
					settings.scores.HS.FourthTarget = data.target_name
					settings:save('all')
				elseif data.actor_name ~= settings.scores.HS.FirstName and data.actor_name ~= settings.scores.HS.SecondName and data.actor_name ~= settings.scores.HS.ThirdName then
					--Fifth Place or somebody not already on the board moves into Fourth Place
					settings.scores.HS.FifthName = settings.scores.HS.FourthName
					settings.scores.HS.FourthName = data.actor_name
					settings.scores.HS.FifthDamage = settings.scores.HS.FourthDamage
					settings.scores.HS.FourthDamage = data.damage
					settings.scores.HS.FifthWS = settings.scores.HS.FourthWS
					settings.scores.HS.FourthWS = data.ws
					settings.scores.HS.FifthTarget = settings.scores.HS.FourthTarget
					settings.scores.HS.FourthTarget = data.target_name
					settings:save('all')
					if Mode == "Normal" then
						coroutine.sleep(1)
						say('/p WS HIGH Score: '..settings.scores.HS.FourthName..' moves into the No.4 slot with a '..settings.scores.HS.FourthDamage..' '..settings.scores.HS.FourthWS..' on '..settings.scores.HS.FourthTarget..'')
					end
				end
			elseif data.damage > settings.scores.HS.FifthDamage then
				--Fifth Place or somebody not already on the board moves into Fifth Place
				if data.actor_name == settings.scores.HS.FifthName or (data.actor_name ~= settings.scores.HS.FirstName and data.actor_name ~= settings.scores.HS.SecondName and data.actor_name ~= settings.scores.HS.ThirdName and data.actor_name ~= settings.scores.HS.FourthName and settings.scores.HS.FifthDamage == 0) then
					--Fifth Place updates their best but stays in Fifth Place (or the fifth ws)
					settings.scores.HS.FifthName = data.actor_name
					settings.scores.HS.FifthDamage = data.damage
					settings.scores.HS.FifthWS = data.ws
					settings.scores.HS.FifthTarget = data.target_name
					settings:save('all')
				elseif data.actor_name ~= settings.scores.HS.FirstName and data.actor_name ~= settings.scores.HS.SecondName and data.actor_name ~= settings.scores.HS.ThirdName and data.actor_name ~= settings.scores.HS.FourthName then
					--Somebody not already on the board moves into Fifth Place
					settings.scores.HS.FifthName = data.actor_name
					settings.scores.HS.FifthDamage = data.damage
					settings.scores.HS.FifthWS = data.ws
					settings.scores.HS.FifthTarget = data.target_name
					settings:save('all')
					if Mode == "Normal" then
						coroutine.sleep(1)
						say('/p WS HIGH Score: '..settings.scores.HS.FifthName..' moves into the No.5 slot with a '..settings.scores.HS.FifthDamage..' '..settings.scores.HS.FifthWS..' on '..settings.scores.HS.FifthTarget..'')
					end
				end
			end

			--WS Low Score
			if data.damage < settings.scores.LS.FirstDamage then
				if data.actor_name == settings.scores.LS.FirstName or settings.scores.LS.FirstDamage == 999999 then
					--First Place extends their "lead" (or the first low ws)
					settings.scores.LS.FirstName = data.actor_name
					settings.scores.LS.FirstDamage = data.damage
					settings.scores.LS.FirstWS = data.ws
					settings.scores.LS.FirstTarget = data.target_name
					settings:save('all')
				elseif data.actor_name == settings.scores.LS.SecondName then
					--Second Place moves into First Place
					settings.scores.LS.SecondName = settings.scores.LS.FirstName
					settings.scores.LS.FirstName = data.actor_name
					settings.scores.LS.SecondDamage = settings.scores.LS.FirstDamage
					settings.scores.LS.FirstDamage = data.damage
					settings.scores.LS.SecondWS = settings.scores.LS.FirstWS
					settings.scores.LS.FirstWS = data.ws
					settings.scores.LS.SecondTarget = settings.scores.LS.FirstTarget
					settings.scores.LS.FirstTarget = data.target_name
					settings:save('all')
				else
					--Third Place or somebody not already on the board moves into First Place
					settings.scores.LS.ThirdName = settings.scores.LS.SecondName
					settings.scores.LS.SecondName = settings.scores.LS.FirstName
					settings.scores.LS.FirstName = data.actor_name
					settings.scores.LS.ThirdDamage = settings.scores.LS.SecondDamage
					settings.scores.LS.SecondDamage = settings.scores.LS.FirstDamage
					settings.scores.LS.FirstDamage = data.damage
					settings.scores.LS.ThirdWS = settings.scores.LS.SecondWS
					settings.scores.LS.SecondWS = settings.scores.LS.FirstWS
					settings.scores.LS.FirstWS = data.ws
					settings.scores.LS.ThirdTarget = settings.scores.LS.SecondTarget
					settings.scores.LS.SecondTarget = settings.scores.LS.FirstTarget
					settings.scores.LS.FirstTarget = data.target_name
					settings:save('all')
				end
				if settings.scores.LS.ThirdDamage ~= 999999 and Mode ~= "Silent" then
					coroutine.sleep(1)
					say('/p New WS LOW Score! '..data.actor_name..' with a '..data.damage..' '..data.ws..' on '..data.target_name..'')
				end
			elseif data.damage < settings.scores.LS.SecondDamage then
				if data.actor_name == settings.scores.LS.SecondName or (data.actor_name ~= settings.scores.LS.FirstName and settings.scores.LS.SecondDamage == 999999) then
					--Second Place updates their best but stays in Second Place (or the second low ws)
					settings.scores.LS.SecondName = data.actor_name
					settings.scores.LS.SecondDamage = data.damage
					settings.scores.LS.SecondWS = data.ws
					settings.scores.LS.SecondTarget = data.target_name
					settings:save('all')
				elseif data.actor_name ~= settings.scores.LS.FirstName then
					--Third Place or somebody not already on the board moves into Second Place
					settings.scores.LS.ThirdName = settings.scores.LS.SecondName
					settings.scores.LS.SecondName = data.actor_name
					settings.scores.LS.ThirdDamage = settings.scores.LS.SecondDamage
					settings.scores.LS.SecondDamage = data.damage
					settings.scores.LS.ThirdWS = settings.scores.LS.SecondWS
					settings.scores.LS.SecondWS = data.ws
					settings.scores.LS.ThirdTarget = settings.scores.LS.SecondTarget
					settings.scores.LS.SecondTarget = data.target_name
					settings:save('all')
					if settings.scores.LS.ThirdDamage ~= 999999 and Mode == "Normal" then
						coroutine.sleep(1)
						say('/p WS LOW Score: '..settings.scores.LS.SecondName..' moves into the No.2 slot with a '..settings.scores.LS.SecondDamage..' '..settings.scores.LS.SecondWS..' on '..settings.scores.LS.SecondTarget..'')
					end
				end
			elseif data.damage < settings.scores.LS.ThirdDamage then
				--Third Place or somebody not already on the board moves into Third Place
				if data.actor_name == settings.scores.LS.ThirdName or (data.actor_name ~= settings.scores.LS.FirstName and data.actor_name ~= settings.scores.LS.SecondName and settings.scores.LS.ThirdDamage == 999999) then
					--Third Place updates their best but stays in Third Place (or the third low ws)
					settings.scores.LS.ThirdName = data.actor_name
					settings.scores.LS.ThirdDamage = data.damage
					settings.scores.LS.ThirdWS = data.ws
					settings.scores.LS.ThirdTarget = data.target_name
					settings:save('all')
				elseif data.actor_name ~= settings.scores.LS.FirstName and data.actor_name ~= settings.scores.LS.SecondName then
					--Somebody not already on the board moves into Third Place
					settings.scores.LS.ThirdName = data.actor_name
					settings.scores.LS.ThirdDamage = data.damage
					settings.scores.LS.ThirdWS = data.ws
					settings.scores.LS.ThirdTarget = data.target_name
					settings:save('all')
					if settings.scores.LS.ThirdDamage ~= 999999 and Mode == "Normal" then
						coroutine.sleep(1)
						say('/p WS LOW Score: '..settings.scores.LS.ThirdName..' moves into the No.3 slot with a '..settings.scores.LS.ThirdDamage..' '..settings.scores.LS.ThirdWS..' on '..settings.scores.LS.ThirdTarget..'')
					end
				end
			end

		end
	end

	--Magic Burst
	if act.category == 4 and act.targets[1].actions[1].message == 252 and Run and not Paused then
		local actor = get_actor(act.actor_id)

		if actor == false then
			return
		end

		local data = {}
		data.actor = actor.id
		data.actor_name = actor.name or 'Unknown'
		data.target = act.targets[1].id
		data.target_name = windower.ffxi.get_mob_by_id(data.target).name or 'Unknown'
		data.damage = act.targets[1].actions[1].param
		data.spell = spells[act.param] and spells[act.param].english or 'Unknown'

		if data.damage > settings.scores.MB.FirstDamage then
			if data.actor_name == settings.scores.MB.FirstName or settings.scores.MB.FirstDamage == 0 then 
				--First Place extends their lead (or the first mb)
				settings.scores.MB.FirstName = data.actor_name
				settings.scores.MB.FirstDamage = data.damage
				settings.scores.MB.FirstSpell = data.spell
				settings.scores.MB.FirstTarget = data.target_name
				settings:save('all')
			elseif data.actor_name == settings.scores.MB.SecondName then
				--Second Place moves into First Place
				settings.scores.MB.SecondName = settings.scores.MB.FirstName
				settings.scores.MB.FirstName = data.actor_name
				settings.scores.MB.SecondDamage = settings.scores.MB.FirstDamage
				settings.scores.MB.FirstDamage = data.damage
				settings.scores.MB.SecondSpell = settings.scores.MB.FirstSpell
				settings.scores.MB.FirstSpell = data.spell
				settings.scores.MB.SecondTarget = settings.scores.MB.FirstTarget
				settings.scores.MB.FirstTarget = data.target_name
				settings:save('all')
			elseif data.actor_name == settings.scores.MB.ThirdName then
				--Third Place moves into First Place
				settings.scores.MB.ThirdName = settings.scores.MB.SecondName
				settings.scores.MB.SecondName = settings.scores.MB.FirstName
				settings.scores.MB.FirstName = data.actor_name
				settings.scores.MB.ThirdDamage = settings.scores.MB.SecondDamage
				settings.scores.MB.SecondDamage = settings.scores.MB.FirstDamage
				settings.scores.MB.FirstDamage = data.damage
				settings.scores.MB.ThirdSpell = settings.scores.MB.SecondSpell
				settings.scores.MB.SecondSpell = settings.scores.MB.FirstSpell
				settings.scores.MB.FirstSpell = data.spell
				settings.scores.MB.ThirdTarget = settings.scores.MB.SecondTarget
				settings.scores.MB.SecondTarget = settings.scores.MB.FirstTarget
				settings.scores.MB.FirstTarget = data.target_name
				settings:save('all')
			elseif data.actor_name == settings.scores.MB.FourthName then
				--Fourth Place moves into First Place
				settings.scores.MB.FourthName = settings.scores.MB.ThirdName
				settings.scores.MB.ThirdName = settings.scores.MB.SecondName
				settings.scores.MB.SecondName = settings.scores.MB.FirstName
				settings.scores.MB.FirstName = data.actor_name
				settings.scores.MB.FourthDamage = settings.scores.MB.ThirdDamage
				settings.scores.MB.ThirdDamage = settings.scores.MB.SecondDamage
				settings.scores.MB.SecondDamage = settings.scores.MB.FirstDamage
				settings.scores.MB.FirstDamage = data.damage
				settings.scores.MB.FourthSpell = settings.scores.MB.ThirdSpell
				settings.scores.MB.ThirdSpell = settings.scores.MB.SecondSpell
				settings.scores.MB.SecondSpell = settings.scores.MB.FirstSpell
				settings.scores.MB.FirstSpell = data.spell
				settings.scores.MB.FourthTarget = settings.scores.MB.ThirdTarget
				settings.scores.MB.ThirdTarget = settings.scores.MB.SecondTarget
				settings.scores.MB.SecondTarget = settings.scores.MB.FirstTarget
				settings.scores.MB.FirstTarget = data.target_name
				settings:save('all')
			else
				--Fifth Place or somebody not already on the board moves into First Place
				settings.scores.MB.FifthName = settings.scores.MB.FourthName
				settings.scores.MB.FourthName = settings.scores.MB.ThirdName
				settings.scores.MB.ThirdName = settings.scores.MB.SecondName
				settings.scores.MB.SecondName = settings.scores.MB.FirstName
				settings.scores.MB.FirstName = data.actor_name
				settings.scores.MB.FifthDamage = settings.scores.MB.FourthDamage
				settings.scores.MB.FourthDamage = settings.scores.MB.ThirdDamage
				settings.scores.MB.ThirdDamage = settings.scores.MB.SecondDamage
				settings.scores.MB.SecondDamage = settings.scores.MB.FirstDamage
				settings.scores.MB.FirstDamage = data.damage
				settings.scores.MB.FifthSpell = settings.scores.MB.FourthSpell
				settings.scores.MB.FourthSpell = settings.scores.MB.ThirdSpell
				settings.scores.MB.ThirdSpell = settings.scores.MB.SecondSpell
				settings.scores.MB.SecondSpell = settings.scores.MB.FirstSpell
				settings.scores.MB.FirstSpell = data.spell
				settings.scores.MB.FifthTarget = settings.scores.MB.FourthTarget
				settings.scores.MB.FourthTarget = settings.scores.MB.ThirdTarget
				settings.scores.MB.ThirdTarget = settings.scores.MB.SecondTarget
				settings.scores.MB.SecondTarget = settings.scores.MB.FirstTarget
				settings.scores.MB.FirstTarget = data.target_name
				settings:save('all')
			end
			if Mode ~= "Silent" then
				coroutine.sleep(1)
				say('/p New MAGIC BURST HIGH Score! '..settings.scores.MB.FirstName..' with a '..settings.scores.MB.FirstDamage..' '..settings.scores.MB.FirstSpell..' on '..settings.scores.MB.FirstTarget..'')
			end
		elseif data.damage > settings.scores.MB.SecondDamage then
			if data.actor_name == settings.scores.MB.SecondName or (data.actor_name ~= settings.scores.MB.FirstName and settings.scores.MB.SecondDamage == 0) then
				--Second Place updates their best but stays in Second Place (or the second mb)
				settings.scores.MB.SecondName = data.actor_name
				settings.scores.MB.SecondDamage = data.damage
				settings.scores.MB.SecondSpell = data.spell
				settings.scores.MB.SecondTarget = data.target_name
				settings:save('all')
			elseif data.actor_name == settings.scores.MB.ThirdName then
				--Third Place moves into Second Place
				settings.scores.MB.ThirdName = settings.scores.MB.SecondName
				settings.scores.MB.SecondName = data.actor_name
				settings.scores.MB.ThirdDamage = settings.scores.MB.SecondDamage
				settings.scores.MB.SecondDamage = data.damage
				settings.scores.MB.ThirdSpell = settings.scores.MB.SecondSpell
				settings.scores.MB.SecondSpell = data.spell
				settings.scores.MB.ThirdTarget = settings.scores.MB.SecondTarget
				settings.scores.MB.SecondTarget = data.target_name
				settings:save('all')
				if Mode == "Normal" then
					coroutine.sleep(1)
					say('/p MAGIC BURST: '..settings.scores.MB.SecondName..' moves into the No.2 slot with a '..settings.scores.MB.SecondDamage..' '..settings.scores.MB.SecondSpell..' on '..settings.scores.MB.SecondTarget..'')
				end
			elseif data.actor_name == settings.scores.MB.FourthName then
				--Fourth Place moves into Second Place
				settings.scores.MB.FourthName = settings.scores.MB.ThirdName
				settings.scores.MB.ThirdName = settings.scores.MB.SecondName
				settings.scores.MB.SecondName = data.actor_name
				settings.scores.MB.FourthDamage = settings.scores.MB.ThirdDamage
				settings.scores.MB.ThirdDamage = settings.scores.MB.SecondDamage
				settings.scores.MB.SecondDamage = data.damage
				settings.scores.MB.FourthSpell = settings.scores.MB.ThirdSpell
				settings.scores.MB.ThirdSpell = settings.scores.MB.SecondSpell
				settings.scores.MB.SecondSpell = data.spell
				settings.scores.MB.FourthTarget = settings.scores.MB.ThirdTarget
				settings.scores.MB.ThirdTarget = settings.scores.MB.SecondTarget
				settings.scores.MB.SecondTarget = data.target_name
				settings:save('all')
				if Mode == "Normal" then
					coroutine.sleep(1)
					say('/p MAGIC BURST: '..settings.scores.MB.SecondName..' moves into the No.2 slot with a '..settings.scores.MB.SecondDamage..' '..settings.scores.MB.SecondSpell..' on '..settings.scores.MB.SecondTarget..'')
				end
			elseif data.actor_name ~= settings.scores.MB.FirstName then
				--Fifth Place or somebody not already on the board moves into Second Place
				settings.scores.MB.FifthName = settings.scores.MB.FourthName
				settings.scores.MB.FourthName = settings.scores.MB.ThirdName
				settings.scores.MB.ThirdName = settings.scores.MB.SecondName
				settings.scores.MB.SecondName = data.actor_name
				settings.scores.MB.FifthDamage = settings.scores.MB.FourthDamage
				settings.scores.MB.FourthDamage = settings.scores.MB.ThirdDamage
				settings.scores.MB.ThirdDamage = settings.scores.MB.SecondDamage
				settings.scores.MB.SecondDamage = data.damage
				settings.scores.MB.FifthSpell = settings.scores.MB.FourthSpell
				settings.scores.MB.FourthSpell = settings.scores.MB.ThirdSpell
				settings.scores.MB.ThirdSpell = settings.scores.MB.SecondSpell
				settings.scores.MB.SecondSpell = data.spell
				settings.scores.MB.FifthTarget  = settings.scores.MB.FourthTarget
				settings.scores.MB.FourthTarget = settings.scores.MB.ThirdTarget
				settings.scores.MB.ThirdTarget = settings.scores.MB.SecondTarget
				settings.scores.MB.SecondTarget = data.target_name
				settings:save('all')
				if Mode == "Normal" then
					coroutine.sleep(1)
					say('/p MAGIC BURST: '..settings.scores.MB.SecondName..' moves into the No.2 slot with a '..settings.scores.MB.SecondDamage..' '..settings.scores.MB.SecondSpell..' on '..settings.scores.MB.SecondTarget..'')
				end
			end
		elseif data.damage > settings.scores.MB.ThirdDamage then
			if data.actor_name == settings.scores.MB.ThirdName or (data.actor_name ~= settings.scores.MB.FirstName and data.actor_name ~= settings.scores.MB.SecondName and settings.scores.MB.ThirdDamage == 0) then
				--Third Place updates their best but stays in Third Place (or the third mb)
				settings.scores.MB.ThirdName = data.actor_name
				settings.scores.MB.ThirdDamage = data.damage
				settings.scores.MB.ThirdSpell = data.spell
				settings.scores.MB.ThirdTarget = data.target_name
				settings:save('all')
			elseif data.actor_name == settings.scores.MB.FourthName then
				--Fourth Place moves into Third Place
				settings.scores.MB.FourthName = settings.scores.MB.ThirdName
				settings.scores.MB.ThirdName = data.actor_name
				settings.scores.MB.FourthDamage = settings.scores.MB.ThirdDamage
				settings.scores.MB.ThirdDamage = data.damage
				settings.scores.MB.FourthSpell = settings.scores.MB.ThirdSpell
				settings.scores.MB.ThirdSpell = data.spell
				settings.scores.MB.FourthTarget = settings.scores.MB.ThirdTarget
				settings.scores.MB.ThirdTarget = data.target_name
				settings:save('all')
				if Mode == "Normal" then
					coroutine.sleep(1)
					say('/p MAGIC BURST: '..settings.scores.MB.ThirdName..' moves into the No.3 slot with a '..settings.scores.MB.ThirdDamage..' '..settings.scores.MB.ThirdSpell..' on '..settings.scores.MB.ThirdTarget..'')
				end
			elseif data.actor_name ~= settings.scores.MB.FirstName and data.actor_name ~= settings.scores.MB.SecondName then
				--Fifth Place or somebody not already on the board moves into Third Place
				settings.scores.MB.FifthName = settings.scores.MB.FourthName
				settings.scores.MB.FourthName = settings.scores.MB.ThirdName
				settings.scores.MB.ThirdName = data.actor_name
				settings.scores.MB.FifthDamage = settings.scores.MB.FourthDamage
				settings.scores.MB.FourthDamage = settings.scores.MB.ThirdDamage
				settings.scores.MB.ThirdDamage = data.damage
				settings.scores.MB.FifthSpell = settings.scores.MB.FourthSpell
				settings.scores.MB.FourthSpell = settings.scores.MB.ThirdSpell
				settings.scores.MB.ThirdSpell = data.spell
				settings.scores.MB.FifthTarget = settings.scores.MB.FourthTarget
				settings.scores.MB.FourthTarget = settings.scores.MB.ThirdTarget
				settings.scores.MB.ThirdTarget = data.target_name
				settings:save('all')
				if Mode == "Normal" then
					coroutine.sleep(1)
					say('/p MAGIC BURST: '..settings.scores.MB.ThirdName..' moves into the No.3 slot with a '..settings.scores.MB.ThirdDamage..' '..settings.scores.MB.ThirdSpell..' on '..settings.scores.MB.ThirdTarget..'')
				end
			end
		elseif data.damage > settings.scores.MB.FourthDamage then
			if data.actor_name == settings.scores.MB.FourthName or (data.actor_name ~= settings.scores.MB.FirstName and data.actor_name ~= settings.scores.MB.SecondName and data.actor_name ~= settings.scores.MB.ThirdName and settings.scores.MB.FourthDamage == 0) then
				--Fourth Place updates their best but stays in Fourth Place (or the fourth mb)
				settings.scores.MB.FourthName = data.actor_name
				settings.scores.MB.FourthDamage = data.damage
				settings.scores.MB.FourthSpell = data.spell
				settings.scores.MB.FourthTarget = data.target_name
				settings:save('all')
			elseif data.actor_name ~= settings.scores.MB.FirstName and data.actor_name ~= settings.scores.MB.SecondName and data.actor_name ~= settings.scores.MB.ThirdName then
				--Fifth Place or somebody not already on the board moves into Fourth Place
				settings.scores.MB.FifthName = settings.scores.MB.FourthName
				settings.scores.MB.FourthName = data.actor_name
				settings.scores.MB.FifthDamage = settings.scores.MB.FourthDamage
				settings.scores.MB.FourthDamage = data.damage
				settings.scores.MB.FifthSpell = settings.scores.MB.FourthSpell
				settings.scores.MB.FourthSpell = data.spell
				settings.scores.MB.FifthTarget = settings.scores.MB.FourthTarget
				settings.scores.MB.FourthTarget = data.target_name
				settings:save('all')
				if Mode == "Normal" then
					coroutine.sleep(1)
					say('/p MAGIC BURST: '..settings.scores.MB.FourthName..' moves into the No.4 slot with a '..settings.scores.MB.FourthDamage..' '..settings.scores.MB.FourthSpell..' on '..settings.scores.MB.FourthTarget..'')
				end
			end
		elseif data.damage > settings.scores.MB.FifthDamage then
			--Fifth Place or somebody not already on the board moves into Fifth Place
			if data.actor_name == settings.scores.MB.FifthName or (data.actor_name ~= settings.scores.MB.FirstName and data.actor_name ~= settings.scores.MB.SecondName and data.actor_name ~= settings.scores.MB.ThirdName and data.actor_name ~= settings.scores.MB.FourthName and settings.scores.MB.FifthDamage == 0) then
				--Fifth Place updates their best but stays in Fifth Place (or the fifth mb)
				settings.scores.MB.FifthName = data.actor_name
				settings.scores.MB.FifthDamage = data.damage
				settings.scores.MB.FifthSpell = data.spell
				settings.scores.MB.FifthTarget = data.target_name
				settings:save('all')
			elseif data.actor_name ~= settings.scores.MB.FirstName and data.actor_name ~= settings.scores.MB.SecondName and data.actor_name ~= settings.scores.MB.ThirdName and data.actor_name ~= settings.scores.MB.FourthName then
				--Somebody not already on the board moves into Fifth Place
				settings.scores.MB.FifthName = data.actor_name
				settings.scores.MB.FifthDamage = data.damage
				settings.scores.MB.FifthSpell = data.spell
				settings.scores.MB.FifthTarget = data.target_name
				settings:save('all')
				if Mode == "Normal" then
					coroutine.sleep(1)
					say('/p MAGIC BURST: '..settings.scores.MB.FifthName..' moves into the No.5 slot with a '..settings.scores.MB.FifthDamage..' '..settings.scores.MB.FifthSpell..' on '..settings.scores.MB.FifthTarget..'')
				end
			end
		end
	end

	--Nukes
	if act.category == 4 and act.targets[1].actions[1].message == 2 and Run and not Paused then

		local actor = get_actor(act.actor_id)

		if actor == false then
			return
		end

		local data = {}
		data.actor = actor.id
		data.actor_name = actor.name or 'Unknown'

		local nukes = nuke[data.actor_name] or 0
		if act.target_count == 6 then
			nuke[data.actor_name] = nukes + act.targets[1].actions[1].param + act.targets[2].actions[1].param + act.targets[3].actions[1].param + act.targets[4].actions[1].param + act.targets[5].actions[1].param + act.targets[6].actions[1].param
		elseif act.target_count == 5 then
			nuke[data.actor_name] = nukes + act.targets[1].actions[1].param + act.targets[2].actions[1].param + act.targets[3].actions[1].param + act.targets[4].actions[1].param + act.targets[5].actions[1].param
		elseif act.target_count == 4 then
			nuke[data.actor_name] = nukes + act.targets[1].actions[1].param + act.targets[2].actions[1].param + act.targets[3].actions[1].param + act.targets[4].actions[1].param
		elseif act.target_count == 3 then
			nuke[data.actor_name] = nukes + act.targets[1].actions[1].param + act.targets[2].actions[1].param + act.targets[3].actions[1].param
		elseif act.target_count == 2 then
			nuke[data.actor_name] = nukes + act.targets[1].actions[1].param + act.targets[2].actions[1].param
		else
			nuke[data.actor_name] = nukes + act.targets[1].actions[1].param
		end

		if nuke[data.actor_name] > settings.scores.Nuke.FirstDamage then
			if data.actor_name == settings.scores.Nuke.FirstName or settings.scores.Nuke.FirstDamage == 0 then 
				--First Place extends their lead (or the first nuke)
				settings.scores.Nuke.FirstName = data.actor_name
				settings.scores.Nuke.FirstDamage = nuke[data.actor_name]
				settings:save('all')
			elseif data.actor_name == settings.scores.Nuke.SecondName then
				--Second Place moves into First Place
				settings.scores.Nuke.SecondName = settings.scores.Nuke.FirstName
				settings.scores.Nuke.FirstName = data.actor_name
				settings.scores.Nuke.SecondDamage = settings.scores.Nuke.FirstDamage
				settings.scores.Nuke.FirstDamage = nuke[data.actor_name]
				settings:save('all')
			elseif data.actor_name == settings.scores.Nuke.ThirdName then
				--Third Place moves into First Place
				settings.scores.Nuke.ThirdName = settings.scores.Nuke.SecondName
				settings.scores.Nuke.SecondName = settings.scores.Nuke.FirstName
				settings.scores.Nuke.FirstName = data.actor_name
				settings.scores.Nuke.ThirdDamage = settings.scores.Nuke.SecondDamage
				settings.scores.Nuke.SecondDamage = settings.scores.Nuke.FirstDamage
				settings.scores.Nuke.FirstDamage = nuke[data.actor_name]
				settings:save('all')
			elseif data.actor_name == settings.scores.Nuke.FourthName then
				--Fourth Place moves into First Place
				settings.scores.Nuke.FourthName = settings.scores.Nuke.ThirdName
				settings.scores.Nuke.ThirdName = settings.scores.Nuke.SecondName
				settings.scores.Nuke.SecondName = settings.scores.Nuke.FirstName
				settings.scores.Nuke.FirstName = data.actor_name
				settings.scores.Nuke.FourthDamage = settings.scores.Nuke.ThirdDamage
				settings.scores.Nuke.ThirdDamage = settings.scores.Nuke.SecondDamage
				settings.scores.Nuke.SecondDamage = settings.scores.Nuke.FirstDamage
				settings.scores.Nuke.FirstDamage = nuke[data.actor_name]
				settings:save('all')
			else
				--Fifth Place or somebody not already on the board moves into First Place
				settings.scores.Nuke.FifthName = settings.scores.Nuke.FourthName
				settings.scores.Nuke.FourthName = settings.scores.Nuke.ThirdName
				settings.scores.Nuke.ThirdName = settings.scores.Nuke.SecondName
				settings.scores.Nuke.SecondName = settings.scores.Nuke.FirstName
				settings.scores.Nuke.FirstName = data.actor_name
				settings.scores.Nuke.FifthDamage = settings.scores.Nuke.FourthDamage
				settings.scores.Nuke.FourthDamage = settings.scores.Nuke.ThirdDamage
				settings.scores.Nuke.ThirdDamage = settings.scores.Nuke.SecondDamage
				settings.scores.Nuke.SecondDamage = settings.scores.Nuke.FirstDamage
				settings.scores.Nuke.FirstDamage = nuke[data.actor_name]
				settings:save('all')
			end
		elseif nuke[data.actor_name] > settings.scores.Nuke.SecondDamage then
			if data.actor_name == settings.scores.Nuke.SecondName or (data.actor_name ~= settings.scores.Nuke.FirstName and settings.scores.Nuke.SecondDamage == 0) then
				--Second Place updates their best but stays in Second Place (or the second nuke)
				settings.scores.Nuke.SecondName = data.actor_name
				settings.scores.Nuke.SecondDamage = nuke[data.actor_name]
				settings:save('all')
			elseif data.actor_name == settings.scores.Nuke.ThirdName then
				--Third Place moves into Second Place
				settings.scores.Nuke.ThirdName = settings.scores.Nuke.SecondName
				settings.scores.Nuke.SecondName = data.actor_name
				settings.scores.Nuke.ThirdDamage = settings.scores.Nuke.SecondDamage
				settings.scores.Nuke.SecondDamage = nuke[data.actor_name]
				settings:save('all')
			elseif data.actor_name == settings.scores.Nuke.FourthName then
				--Fourth Place moves into Second Place
				settings.scores.Nuke.FourthName = settings.scores.Nuke.ThirdName
				settings.scores.Nuke.ThirdName = settings.scores.Nuke.SecondName
				settings.scores.Nuke.SecondName = data.actor_name
				settings.scores.Nuke.FourthDamage = settings.scores.Nuke.ThirdDamage
				settings.scores.Nuke.ThirdDamage = settings.scores.Nuke.SecondDamage
				settings.scores.Nuke.SecondDamage = nuke[data.actor_name]
				settings:save('all')
			elseif data.actor_name ~= settings.scores.Nuke.FirstName then
				--Fifth Place or somebody not already on the board moves into Second Place
				settings.scores.Nuke.FifthName = settings.scores.Nuke.FourthName
				settings.scores.Nuke.FourthName = settings.scores.Nuke.ThirdName
				settings.scores.Nuke.ThirdName = settings.scores.Nuke.SecondName
				settings.scores.Nuke.SecondName = data.actor_name
				settings.scores.Nuke.FifthDamage = settings.scores.Nuke.FourthDamage
				settings.scores.Nuke.FourthDamage = settings.scores.Nuke.ThirdDamage
				settings.scores.Nuke.ThirdDamage = settings.scores.Nuke.SecondDamage
				settings.scores.Nuke.SecondDamage = nuke[data.actor_name]
				settings:save('all')
			end
		elseif nuke[data.actor_name] > settings.scores.Nuke.ThirdDamage then
			if data.actor_name == settings.scores.Nuke.ThirdName or (data.actor_name ~= settings.scores.Nuke.FirstName and data.actor_name ~= settings.scores.Nuke.SecondName and settings.scores.Nuke.ThirdDamage == 0) then
				--Third Place updates their best but stays in Third Place (or the third nuke)
				settings.scores.Nuke.ThirdName = data.actor_name
				settings.scores.Nuke.ThirdDamage = nuke[data.actor_name]
				settings:save('all')
			elseif data.actor_name == settings.scores.Nuke.FourthName then
				--Fourth Place moves into Third Place
				settings.scores.Nuke.FourthName = settings.scores.Nuke.ThirdName
				settings.scores.Nuke.ThirdName = data.actor_name
				settings.scores.Nuke.FourthDamage = settings.scores.Nuke.ThirdDamage
				settings.scores.Nuke.ThirdDamage = nuke[data.actor_name]
				settings:save('all')
			elseif data.actor_name ~= settings.scores.Nuke.FirstName and data.actor_name ~= settings.scores.Nuke.SecondName then
				--Fifth Place or somebody not already on the board moves into Third Place
				settings.scores.Nuke.FifthName = settings.scores.Nuke.FourthName
				settings.scores.Nuke.FourthName = settings.scores.Nuke.ThirdName
				settings.scores.Nuke.ThirdName = data.actor_name
				settings.scores.Nuke.FifthDamage = settings.scores.Nuke.FourthDamage
				settings.scores.Nuke.FourthDamage = settings.scores.Nuke.ThirdDamage
				settings.scores.Nuke.ThirdDamage = nuke[data.actor_name]
				settings:save('all')
			end
		elseif nuke[data.actor_name] > settings.scores.Nuke.FourthDamage then
			if data.actor_name == settings.scores.Nuke.FourthName or (data.actor_name ~= settings.scores.Nuke.FirstName and data.actor_name ~= settings.scores.Nuke.SecondName and data.actor_name ~= settings.scores.Nuke.ThirdName and settings.scores.Nuke.FourthDamage == 0) then
				--Fourth Place updates their best but stays in Fourth Place (or the fourth nuke)
				settings.scores.Nuke.FourthName = data.actor_name
				settings.scores.Nuke.FourthDamage = nuke[data.actor_name]
				settings:save('all')
			elseif data.actor_name ~= settings.scores.Nuke.FirstName and data.actor_name ~= settings.scores.Nuke.SecondName and data.actor_name ~= settings.scores.Nuke.ThirdName then
				--Fifth Place or somebody not already on the board moves into Fourth Place
				settings.scores.Nuke.FifthName = settings.scores.Nuke.FourthName
				settings.scores.Nuke.FourthName = data.actor_name
				settings.scores.Nuke.FifthDamage = settings.scores.Nuke.FourthDamage
				settings.scores.Nuke.FourthDamage = nuke[data.actor_name]
				settings:save('all')
			end
		elseif nuke[data.actor_name] > settings.scores.Nuke.FifthDamage and data.actor_name ~= settings.scores.Nuke.FirstName and data.actor_name ~= settings.scores.Nuke.SecondName and data.actor_name ~= settings.scores.Nuke.ThirdName and data.actor_name ~= settings.scores.Nuke.FourthName then
			--Fifth Place updates their best or somebody not already on the board moves into Fifth Place
			settings.scores.Nuke.FifthName = data.actor_name
			settings.scores.Nuke.FifthDamage = nuke[data.actor_name]
				settings:save('all')
		end

	end
end)

windower.register_event('addon command',function(addcmd, arg)

	if addcmd == 'reload' then
        cmd('lua r leaderboard')
        return

	elseif addcmd == 'recoverl' or (addcmd == 'recover' and (arg == 'lite' or arg == 'l')) then
		Run = true
		Paused = false
		Mode = "Lite"
		windower.add_to_chat(200,'[Leaderboard] '..('Recovering in Lite Mode'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('Only High/Low scores are recovered. Cures, Nukes, and Whiffs are not'):color(8)..'')
		if settings.reminder then
			coroutine.sleep(1)
			windower.add_to_chat(200,'[Leaderboard] '..('//lb pause, mode, normal, silent, boards, reset'):color(8)..'')
			windower.add_to_chat(200,'[Leaderboard] '..('//lb c, hs, ls, mb, n, sc, or w to print current leaderboards to party chat'):color(8)..'')
		end

	elseif addcmd == 'recovers' or (addcmd == 'recover' and (arg == 'silent' or arg == 's')) then
		Run = true
		Paused = false
		Mode = "Silent"
		windower.add_to_chat(200,'[Leaderboard] '..('Recovering in Silent Mode'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('Only High/Low scores are recovered. Cure, Nuke, and Whiff counts are not'):color(8)..'')
		if settings.reminder then
			coroutine.sleep(1)
			windower.add_to_chat(200,'[Leaderboard] '..('//lb pause, mode, normal, lite, boards, reset'):color(8)..'')
			windower.add_to_chat(200,'[Leaderboard] '..('//lb c, hs, ls, mb, n, sc, or w to print current leaderboards to party chat'):color(8)..'')
		end

	elseif addcmd == 'recover' or addcmd == 'recovern' or (addcmd == 'recover' and (arg == 'normal' or arg == 'n')) then
		Run = true
		Paused = false
		Mode = "Normal"
		say('/p Leaderboard recovered! Only High/Low scores are recovered. Cure, Nuke, and Whiff counts are not')
		if settings.reminder then
			coroutine.sleep(1)
			windower.add_to_chat(200,'[Leaderboard] '..('Beware - Normal Mode uses party chat heavily'):color(8)..'')
			windower.add_to_chat(200,'[Leaderboard] '..('//lb pause, mode, lite, silent, boards, reset'):color(8)..'')
			windower.add_to_chat(200,'[Leaderboard] '..('//lb c, hs, ls, mb, n, sc, or w to print current leaderboards to party chat'):color(8)..'')
		end

	elseif addcmd == 'reset' then
		reset_scores()
		windower.add_to_chat(200,'[Leaderboard] '..('Data reset'):color(8)..'')

	elseif addcmd == 'reminder' or addcmd == 'r' then
		if arg == 'on' or arg == 'true' then
			settings.reminder = true
			settings:save('all')
		elseif arg == 'off' or arg == 'false' then
			settings.reminder = false
			settings:save('all')
		else
			if settings.reminder then
				windower.add_to_chat(200,'[Leaderboard] '..('Reminder is currently on'):color(8)..'')
			else
				windower.add_to_chat(200,'[Leaderboard] '..('Reminder is currently off'):color(8)..'')
			end
		end

	elseif addcmd == 'flood' then
		if arg == nil then
			windower.add_to_chat(200,'[Leaderboard] '..('Flood Delay is currently set to '..settings.flood_delay..' seconds'):color(8)..'')
		elseif tonumber(arg) ~= nil then
			settings.flood_delay = arg
			settings:save('all')
			windower.add_to_chat(200,'[Leaderboard] '..('Flood Delay is now set to '..settings.flood_delay..' seconds'):color(8)..'')
		else
			windower.add_to_chat(200,'[Leaderboard] '..('Flood Delay must be a number'):color(8)..'')
		end

 	elseif addcmd == 'help' then
		windower.add_to_chat(200,'[Leaderboard] '..('--Commands--'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('start [normal/n/lite/l/silent/s]- start tracking in Normal/Lite/Silent Mode'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('recover [normal/n/lite/l/silent/s]- recover from a crash/disconnect in Normal/Lite/Silent Mode'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('pause/p - pause/unpause tracking'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('mode/m [normal/n/lite/l/silent/s] - displays/changes current Mode'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('c, hs, ls, mb, n, sc, w - print current leaderboards to party chat'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('boards - list the different leaderboards that are tracked'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('reminder/r [on/off] - displays/changes current reminder setting'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('flood [#] - displays/changes the flood delay'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('reset - reset the data'):color(8)..'')

	elseif addcmd == 'startl' or (addcmd == 'start' and (arg == 'lite' or arg == 'l')) then
		reset_scores()
		Run = true
		Paused = false
		Mode = "Lite"
		windower.add_to_chat(200,'[Leaderboard] '..('Started in Lite Mode'):color(8)..'')
		if settings.reminder then
			coroutine.sleep(1)
			windower.add_to_chat(200,'[Leaderboard] '..('//lb pause, mode, normal, silent, boards, reset'):color(8)..'')
			windower.add_to_chat(200,'[Leaderboard] '..('//lb c, hs, ls, mb, n, sc, or w to print current leaderboards to party chat'):color(8)..'')
		end

	elseif addcmd == 'starts' or (addcmd == 'start' and (arg == 'silent' or arg == 's')) then
		reset_scores()
		Run = true
		Paused = false
		Mode = "Silent"
		windower.add_to_chat(200,'[Leaderboard] '..('Started in Silent Mode'):color(8)..'')
		if settings.reminder then
			coroutine.sleep(1)
			windower.add_to_chat(200,'[Leaderboard] '..('//lb pause, mode, normal, lite, boards, reset'):color(8)..'')
			windower.add_to_chat(200,'[Leaderboard] '..('//lb c, hs, ls, mb, n, sc, or w to print current leaderboards to party chat'):color(8)..'')
		end

	elseif addcmd == 'start' or addcmd == 'startn' or (addcmd == 'start' and (arg == 'normal' or arg == 'n')) then
		reset_scores()
		Run = true
		Paused = false
		Mode = "Normal"
		say('/p Leaderboard started! Type !lb c, hs, ls, mb, n, sc, or w into party chat for current leaderboards')
		if settings.reminder then
			coroutine.sleep(1)
			windower.add_to_chat(200,'[Leaderboard] '..('Beware - Normal Mode uses party chat heavily'):color(8)..'')
			windower.add_to_chat(200,'[Leaderboard] '..('//lb pause, mode, lite, silent, boards, reset'):color(8)..'')
			windower.add_to_chat(200,'[Leaderboard] '..('//lb c, hs, ls, mb, n, sc, or w to print current leaderboards to party chat'):color(8)..'')
		end

	elseif addcmd == 'pause' or addcmd == 'p' then
		if not Run then
			windower.add_to_chat(200,'[Leaderboard] '..('Not currently running'):color(8)..'')
		else
			if not Paused then
				Paused = true
				say('/p Leaderboard paused.')
			else
				Paused = false
				say('/p Leaderboard unpaused.')
			end
		end

	elseif addcmd == 'moden' or (addcmd == 'mode' and (arg == 'normal' or arg == 'n')) then
		if not Run then
			windower.add_to_chat(200,'[Leaderboard] '..('Not currently running'):color(8)..'')
		elseif Mode == "Normal" then
			if Paused then
				windower.add_to_chat(200,'[Leaderboard] '..('Currently paused in Normal Mode (Use lite or silent to switch to those modes)'):color(8)..'')
			else
				windower.add_to_chat(200,'[Leaderboard] '..('Currently running in Normal Mode (Use lite or silent to switch to those modes)'):color(8)..'')
			end
		else
			Mode = "Normal"
			if Paused then
				windower.add_to_chat(200,'[Leaderboard] '..('Normal Mode on (paused)'):color(8)..'')
			else
				windower.add_to_chat(200,'[Leaderboard] '..('Normal Mode on (running)'):color(8)..'')
			end
			if settings.reminder then
				windower.add_to_chat(200,'[Leaderboard] '..('Beware - Normal Mode uses party chat heavily'):color(8)..'')
			end
		end

	elseif addcmd == 'model' or (addcmd == 'mode' and (arg == 'lite' or arg == 'l')) then
		if not Run then
			windower.add_to_chat(200,'[Leaderboard] '..('Not currently running'):color(8)..'')
		elseif Mode == "Lite" then
			if Paused then
				windower.add_to_chat(200,'[Leaderboard] '..('Currently paused in Lite Mode (Use normal or silent to switch to those modes)'):color(8)..'')
			else
				windower.add_to_chat(200,'[Leaderboard] '..('Currently running in Lite Mode (Use normal or silent to switch to those modes)'):color(8)..'')
			end
		else
			Mode = "Lite"
			if Paused then
				windower.add_to_chat(200,'[Leaderboard] '..('Lite Mode on (paused)'):color(8)..'')
			else
				windower.add_to_chat(200,'[Leaderboard] '..('Lite Mode on (running)'):color(8)..'')
			end
		end

	elseif addcmd == 'modes' or (addcmd == 'mode' and (arg == 'silent' or arg == 's')) then
		if not Run then
			windower.add_to_chat(200,'[Leaderboard] '..('Not currently running'):color(8)..'')
		elseif Mode == "Silent" then
			if Paused then
				windower.add_to_chat(200,'[Leaderboard] '..('Currently paused in Silent Mode (Use normal or lite to switch to those modes)'):color(8)..'')
			else
				windower.add_to_chat(200,'[Leaderboard] '..('Currently running in Silent Mode (Use normal or lite to switch to those modes)'):color(8)..'')
			end
		else
			Mode = "Silent"
			if Paused then
				windower.add_to_chat(200,'[Leaderboard] '..('Silent Mode on (paused)'):color(8)..'')
			else
				windower.add_to_chat(200,'[Leaderboard] '..('Silent Mode on (running)'):color(8)..'')
			end
		end

	elseif addcmd == 'mode' then
		if Mode == "Normal" then
			if Paused then
				windower.add_to_chat(200,'[Leaderboard] '..('Currently paused in Normal Mode (Use lite or silent to switch to those modes)'):color(8)..'')
			else
				windower.add_to_chat(200,'[Leaderboard] '..('Currently running in Normal Mode (Use lite or silent to switch to those modes)'):color(8)..'')
			end
		elseif Mode == "Lite" then
			if Paused then
				windower.add_to_chat(200,'[Leaderboard] '..('Currently paused in Lite Mode (Use normal or silent to switch to those modes)'):color(8)..'')
			else
				windower.add_to_chat(200,'[Leaderboard] '..('Currently running in Lite Mode (Use normal or silent to switch to those modes)'):color(8)..'')
			end
		elseif Mode == "Silent" then
			if Paused then
				windower.add_to_chat(200,'[Leaderboard] '..('Currently paused in Silent Mode (Use normal or lite to switch to those modes)'):color(8)..'')
			else
				windower.add_to_chat(200,'[Leaderboard] '..('Currently running in Silent Mode (Use normal or lite to switch to those modes)'):color(8)..'')
			end
		end

	elseif addcmd == 'board' or addcmd == 'boards' then
		windower.add_to_chat(200,'[Leaderboard] '..('--Current Tracked Leaderboards--'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('c/cure - Running total of cures (up to 3 places)'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('hs/highscore - Highest individual WS damage (up to 5 places)'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('ls/lowscore - Lowest individual WS damage (up to 3 places)'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('mb/magicburst - Highest individual MB damage (up to 5 places)'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('n/nuke - Running total of nukes (up to 5 places)'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('sc/skillchain - Highest individual SC damage (up to 5 places)'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('w/whiffs - Running total of whiffs (up to 3 places)'):color(8)..'')

	elseif addcmd == 'c' or addcmd =='cure' or addcmd =='cures' then
		if settings.scores.Cure.ThirdAmount ~= 0 then
			say('/p \r--Cure Leaderboard--\rNo.1: '..settings.scores.Cure.FirstName..' ('..settings.scores.Cure.FirstAmount..')\rNo.2: '..settings.scores.Cure.SecondName..' ('..settings.scores.Cure.SecondAmount..')\rNo.3: '..settings.scores.Cure.ThirdName..' ('..settings.scores.Cure.ThirdAmount..')')
		elseif settings.scores.Cure.SecondAmount ~= 0 then
			say('/p \r--Cure Leaderboard--\rNo.1: '..settings.scores.Cure.FirstName..' ('..settings.scores.Cure.FirstAmount..')\rNo.2: '..settings.scores.Cure.SecondName..' ('..settings.scores.Cure.SecondAmount..')')
		elseif settings.scores.Cure.FirstAmount ~= 0 then
			say('/p \r--Cure Leaderboard--\rNo.1: '..settings.scores.Cure.FirstName..' ('..settings.scores.Cure.FirstAmount..')')
		else
			say('/p \r--Cure Leaderboard--\rNo data yet')
		end

	elseif addcmd == 'ls' or addcmd =='lowscore' then
		if settings.scores.LS.ThirdDamage ~= 999999 then
			say('/p \r--Low Score Leaderboard--\rNo.1: '..settings.scores.LS.FirstName..' ('..settings.scores.LS.FirstDamage..')\rNo.2: '..settings.scores.LS.SecondName..' ('..settings.scores.LS.SecondDamage..')\rNo.3: '..settings.scores.LS.ThirdName..' ('..settings.scores.LS.ThirdDamage..')')
		elseif settings.scores.LS.SecondDamage ~= 999999 then
			say('/p \r--Low Score Leaderboard--\rNo.1: '..settings.scores.LS.FirstName..' ('..settings.scores.LS.FirstDamage..')\rNo.2: '..settings.scores.LS.SecondName..' ('..settings.scores.LS.SecondDamage..')')
		elseif settings.scores.LS.FirstDamage ~= 999999 then
			say('/p \r--Low Score Leaderboard--\rNo.1: '..settings.scores.LS.FirstName..' ('..settings.scores.LS.FirstDamage..')')
		else
			say('/p \r--Low Score Leaderboard--\rNo data yet')
		end

	elseif addcmd == 'hs' or addcmd =='highscore' or addcmd =='hiscore' then
		if settings.scores.HS.FifthDamage ~= 0 then
			say('/p \r--High Score Leaderboard--\rNo.1: '..settings.scores.HS.FirstName..' ('..settings.scores.HS.FirstDamage..')\rNo.2: '..settings.scores.HS.SecondName..' ('..settings.scores.HS.SecondDamage..')\rNo.3: '..settings.scores.HS.ThirdName..' ('..settings.scores.HS.ThirdDamage..')\rNo.4: '..settings.scores.HS.FourthName..' ('..settings.scores.HS.FourthDamage..')\rNo.5: '..settings.scores.HS.FifthName..' ('..settings.scores.HS.FifthDamage..')')
		elseif settings.scores.HS.FourthDamage ~= 0 then
			say('/p \r--High Score Leaderboard--\rNo.1: '..settings.scores.HS.FirstName..' ('..settings.scores.HS.FirstDamage..')\rNo.2: '..settings.scores.HS.SecondName..' ('..settings.scores.HS.SecondDamage..')\rNo.3: '..settings.scores.HS.ThirdName..' ('..settings.scores.HS.ThirdDamage..')\rNo.4: '..settings.scores.HS.FourthName..' ('..settings.scores.HS.FourthDamage..')')
		elseif settings.scores.HS.ThirdDamage ~= 0 then
			say('/p \r--High Score Leaderboard--\rNo.1: '..settings.scores.HS.FirstName..' ('..settings.scores.HS.FirstDamage..')\rNo.2: '..settings.scores.HS.SecondName..' ('..settings.scores.HS.SecondDamage..')\rNo.3: '..settings.scores.HS.ThirdName..' ('..settings.scores.HS.ThirdDamage..')')
		elseif settings.scores.HS.SecondDamage ~= 0 then
			say('/p \r--High Score Leaderboard--\rNo.1: '..settings.scores.HS.FirstName..' ('..settings.scores.HS.FirstDamage..')\rNo.2: '..settings.scores.HS.SecondName..' ('..settings.scores.HS.SecondDamage..')')
		elseif settings.scores.HS.FirstDamage ~= 0 then
			say('/p \r--High Score Leaderboard--\rNo.1: '..settings.scores.HS.FirstName..' ('..settings.scores.HS.FirstDamage..')')
		else
			say('/p \r--High Score Leaderboard--\rNo data yet')
		end

	elseif addcmd == 'mb' or addcmd =='magicburst' or addcmd =='burst' then
		if settings.scores.MB.FifthDamage ~= 0 then
			say('/p \r--Magic Burst Leaderboard--\rNo.1: '..settings.scores.MB.FirstName..' ('..settings.scores.MB.FirstDamage..')\rNo.2: '..settings.scores.MB.SecondName..' ('..settings.scores.MB.SecondDamage..')\rNo.3: '..settings.scores.MB.ThirdName..' ('..settings.scores.MB.ThirdDamage..')\rNo.4: '..settings.scores.MB.FourthName..' ('..settings.scores.MB.FourthDamage..')\rNo.5: '..settings.scores.MB.FifthName..' ('..settings.scores.MB.FifthDamage..')')
		elseif settings.scores.MB.FourthDamage ~= 0 then
			say('/p \r--Magic Burst Leaderboard--\rNo.1: '..settings.scores.MB.FirstName..' ('..settings.scores.MB.FirstDamage..')\rNo.2: '..settings.scores.MB.SecondName..' ('..settings.scores.MB.SecondDamage..')\rNo.3: '..settings.scores.MB.ThirdName..' ('..settings.scores.MB.ThirdDamage..')\rNo.4: '..settings.scores.MB.FourthName..' ('..settings.scores.MB.FourthDamage..')')
		elseif settings.scores.MB.ThirdDamage ~= 0 then
			say('/p \r--Magic Burst Leaderboard--\rNo.1: '..settings.scores.MB.FirstName..' ('..settings.scores.MB.FirstDamage..')\rNo.2: '..settings.scores.MB.SecondName..' ('..settings.scores.MB.SecondDamage..')\rNo.3: '..settings.scores.MB.ThirdName..' ('..settings.scores.MB.ThirdDamage..')')
		elseif settings.scores.MB.SecondDamage ~= 0 then
			say('/p \r--Magic Burst Leaderboard--\rNo.1: '..settings.scores.MB.FirstName..' ('..settings.scores.MB.FirstDamage..')\rNo.2: '..settings.scores.MB.SecondName..' ('..settings.scores.MB.SecondDamage..')')
		elseif settings.scores.MB.FirstDamage ~= 0 then
			say('/p \r--Magic Burst Leaderboard--\rNo.1: '..settings.scores.MB.FirstName..' ('..settings.scores.MB.FirstDamage..')')
		else
			say('/p \r--Magic Burst Leaderboard--\rNo data yet')
		end

	elseif addcmd == 'n' or addcmd =='nuke' or addcmd =='nukes' then
		if settings.scores.Nuke.FifthDamage ~= 0 then
			say('/p \r--Nuke Leaderboard--\rNo.1: '..settings.scores.Nuke.FirstName..' ('..settings.scores.Nuke.FirstDamage..')\rNo.2: '..settings.scores.Nuke.SecondName..' ('..settings.scores.Nuke.SecondDamage..')\rNo.3: '..settings.scores.Nuke.ThirdName..' ('..settings.scores.Nuke.ThirdDamage..')\rNo.4: '..settings.scores.Nuke.FourthName..' ('..settings.scores.Nuke.FourthDamage..')\rNo.5: '..settings.scores.Nuke.FifthName..' ('..settings.scores.Nuke.FifthDamage..')')
		elseif settings.scores.Nuke.FourthDamage ~= 0 then
			say('/p \r--Nuke Leaderboard--\rNo.1: '..settings.scores.Nuke.FirstName..' ('..settings.scores.Nuke.FirstDamage..')\rNo.2: '..settings.scores.Nuke.SecondName..' ('..settings.scores.Nuke.SecondDamage..')\rNo.3: '..settings.scores.Nuke.ThirdName..' ('..settings.scores.Nuke.ThirdDamage..')\rNo.4: '..settings.scores.Nuke.FourthName..' ('..settings.scores.Nuke.FourthDamage..')')
		elseif settings.scores.Nuke.ThirdDamage ~= 0 then
			say('/p \r--Nuke Leaderboard--\rNo.1: '..settings.scores.Nuke.FirstName..' ('..settings.scores.Nuke.FirstDamage..')\rNo.2: '..settings.scores.Nuke.SecondName..' ('..settings.scores.Nuke.SecondDamage..')\rNo.3: '..settings.scores.Nuke.ThirdName..' ('..settings.scores.Nuke.ThirdDamage..')')
		elseif settings.scores.Nuke.SecondDamage ~= 0 then
			say('/p \r--Nuke Leaderboard--\rNo.1: '..settings.scores.Nuke.FirstName..' ('..settings.scores.Nuke.FirstDamage..')\rNo.2: '..settings.scores.Nuke.SecondName..' ('..settings.scores.Nuke.SecondDamage..')')
		elseif settings.scores.Nuke.FirstDamage ~= 0 then
			say('/p \r--Nuke Leaderboard--\rNo.1: '..settings.scores.Nuke.FirstName..' ('..settings.scores.Nuke.FirstDamage..')')
		else
			say('/p \r--Nuke Leaderboard--\rNo data yet')
		end

	elseif addcmd == 'sc' or addcmd =='skillchain' then
		if settings.scores.SC.FifthDamage ~= 0 then
			say('/p \r--Skillchain Leaderboard--\rNo.1: '..settings.scores.SC.FirstName..' ('..settings.scores.SC.FirstDamage..')\rNo.2: '..settings.scores.SC.SecondName..' ('..settings.scores.SC.SecondDamage..')\rNo.3: '..settings.scores.SC.ThirdName..' ('..settings.scores.SC.ThirdDamage..')\rNo.4: '..settings.scores.SC.FourthName..' ('..settings.scores.SC.FourthDamage..')\rNo.5: '..settings.scores.SC.FifthName..' ('..settings.scores.SC.FifthDamage..')')
		elseif settings.scores.SC.FourthDamage ~= 0 then
			say('/p \r--Skillchain Leaderboard--\rNo.1: '..settings.scores.SC.FirstName..' ('..settings.scores.SC.FirstDamage..')\rNo.2: '..settings.scores.SC.SecondName..' ('..settings.scores.SC.SecondDamage..')\rNo.3: '..settings.scores.SC.ThirdName..' ('..settings.scores.SC.ThirdDamage..')\rNo.4: '..settings.scores.SC.FourthName..' ('..settings.scores.SC.FourthDamage..')')
		elseif settings.scores.SC.ThirdDamage ~= 0 then
			say('/p \r--Skillchain Leaderboard--\rNo.1: '..settings.scores.SC.FirstName..' ('..settings.scores.SC.FirstDamage..')\rNo.2: '..settings.scores.SC.SecondName..' ('..settings.scores.SC.SecondDamage..')\rNo.3: '..settings.scores.SC.ThirdName..' ('..settings.scores.SC.ThirdDamage..')')
		elseif settings.scores.SC.SecondDamage ~= 0 then
			say('/p \r--Skillchain Leaderboard--\rNo.1: '..settings.scores.SC.FirstName..' ('..settings.scores.SC.FirstDamage..')\rNo.2: '..settings.scores.SC.SecondName..' ('..settings.scores.SC.SecondDamage..')')
		elseif settings.scores.SC.FirstDamage ~= 0 then
			say('/p \r--Skillchain Leaderboard--\rNo.1: '..settings.scores.SC.FirstName..' ('..settings.scores.SC.FirstDamage..')')
		else
			say('/p \r--Skillchain Leaderboard--\rNo data yet')
		end

	elseif addcmd == 'w' or addcmd =='whiff' or addcmd =='whiffs' then
		if settings.scores.Whiff.ThirdAmount ~= 0 then
			say('/p \r--Whiff Leaderboard--\rNo.1: '..settings.scores.Whiff.FirstName..' ('..settings.scores.Whiff.FirstAmount..')\rNo.2: '..settings.scores.Whiff.SecondName..' ('..settings.scores.Whiff.SecondAmount..')\rNo.3: '..settings.scores.Whiff.ThirdName..' ('..settings.scores.Whiff.ThirdAmount..')')
		elseif settings.scores.Whiff.SecondAmount ~= 0 then
			say('/p \r--Whiff Leaderboard--\rNo.1: '..settings.scores.Whiff.FirstName..' ('..settings.scores.Whiff.FirstAmount..')\rNo.2: '..settings.scores.Whiff.SecondName..' ('..settings.scores.Whiff.SecondAmount..')')
		elseif settings.scores.Whiff.FirstAmount ~= 0 then
			say('/p \r--Whiff Leaderboard--\rNo.1: '..settings.scores.Whiff.FirstName..' ('..settings.scores.Whiff.FirstAmount..')')
		else
			say('/p \r--Whiff Leaderboard--\rNo data yet')
		end

	else
		windower.add_to_chat(200,'[Leaderboard] '..('Unknown command. Type \'//em help\' for list of commands.'):color(8)..'')
		if Run and settings.reminder then
			if Mode == "Normal" then
				if Paused then
					windower.add_to_chat(200,'[Leaderboard] '..('Currently paused in Normal Mode (Use lite or silent to switch to those modes)'):color(8)..'')
				else
					windower.add_to_chat(200,'[Leaderboard] '..('Currently running in Normal Mode (Use lite or silent to switch to those modes)'):color(8)..'')
				end
			elseif Mode == "Lite" then
				if Paused then
					windower.add_to_chat(200,'[Leaderboard] '..('Currently paused in Lite Mode (Use normal or silent to switch to those modes)'):color(8)..'')
				else
					windower.add_to_chat(200,'[Leaderboard] '..('Currently running in Lite Mode (Use normal or silent to switch to those modes)'):color(8)..'')
				end
			elseif Mode == "Silent" then
				if Paused then
					windower.add_to_chat(200,'[Leaderboard] '..('Currently paused in Silent Mode (Use normal or lite to switch to those modes)'):color(8)..'')
				else
					windower.add_to_chat(200,'[Leaderboard] '..('Currently running in Silent Mode (Use normal or lite to switch to those modes)'):color(8)..'')
				end
			end
		elseif settings.reminder then
			windower.add_to_chat(200,'[Leaderboard] '..('Not currently running'):color(8)..'')
		end
	end
end)

windower.register_event('incoming text',function(org, modified, mode)
	if (org:find('!lb c') or org:find('!lbc') or org:find('!LB C') or org:find('!LBC')) and not (org:find('Leaderboard started!') or org:find('Leaderboard recovered!')) then
		if flood_timer ~= 0 then
			return
		end
		flood_timer = settings.flood_delay
		coroutine.sleep(2)
		cmd('lb c')
	elseif (org:find('!lb ls') or org:find('!lbls') or org:find('!LB LS') or org:find('!LBLS')) and not (org:find('Leaderboard started!') or org:find('Leaderboard recovered!')) then
		if flood_timer ~= 0 then
			return
		end
		flood_timer = settings.flood_delay
		coroutine.sleep(2)
		cmd('lb ls')
	elseif (org:find('!lb hs') or org:find('!lbhs') or org:find('!LB HS') or org:find('!LBHS')) and not (org:find('Leaderboard started!') or org:find('Leaderboard recovered!')) then
		if flood_timer ~= 0 then
			return
		end
		flood_timer = settings.flood_delay
		coroutine.sleep(2)
		cmd('lb hs')
	elseif (org:find('!lb mb') or org:find('!lbmb') or org:find('!LB MB') or org:find('!LBMB')) and not (org:find('Leaderboard started!') or org:find('Leaderboard recovered!')) then
		if flood_timer ~= 0 then
			return
		end
		flood_timer = settings.flood_delay
		coroutine.sleep(2)
		cmd('lb mb')
	elseif (org:find('!lb n') or org:find('!lbn') or org:find('!LB N') or org:find('!LBN')) and not (org:find('Leaderboard started!') or org:find('Leaderboard recovered!')) then
		if flood_timer ~= 0 then
			return
		end
		flood_timer = settings.flood_delay
		coroutine.sleep(2)
		cmd('lb n')
	elseif (org:find('!lb sc') or org:find('!lbsc') or org:find('!LB SC') or org:find('!LBSC')) and not (org:find('Leaderboard started!') or org:find('Leaderboard recovered!')) then
		if flood_timer ~= 0 then
			return
		end
		flood_timer = settings.flood_delay
		coroutine.sleep(2)
		cmd('lb sc')
	elseif (org:find('!lb w') or org:find('!lbw') or org:find('!LB W') or org:find('!LBW')) and not (org:find('Leaderboard started!') or org:find('Leaderboard recovered!')) then
		if flood_timer ~= 0 then
			return
		end
		flood_timer = settings.flood_delay
		coroutine.sleep(2)
		cmd('lb w')
	end
end)

windower.register_event('prerender', function()
	if os.time() > Heartbeat then
		Heartbeat = os.time()
		if flood_timer >= 1 then
			flood_timer = flood_timer - 1
		end
	end
end)

windower.register_event('zone change',function()
	coroutine.sleep(5)
	if Run and settings.reminder then
		if Paused then
			windower.add_to_chat(200,'[Leaderboard] '..('Currently paused in '..Mode..' Mode'):color(8)..'')
		else
			windower.add_to_chat(200,'[Leaderboard] '..('Currently running in '..Mode..' Mode'):color(8)..'')
		end
	end
end)
