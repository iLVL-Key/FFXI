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
_addon.version = '01.21.23'
_addon.author = 'Key'
_addon.commands = {'leaderboard','lb'}

require 'logger'

local board_flood_delay = 5 --delay in seconds before boards can be called again

local weaponskills = require('resources').weapon_skills
local spells = require('resources').spells
local jabils = require('resources').job_abilities
local mabils = require('resources').monster_abilities
local whiff = {}
local cure = {}
local nuke = {}
local kill = {}
local death = {}
local cmd = windower.send_command
local say = windower.chat.input

local Heartbeat = 0
local board_flood_timer = 0
local Run = false
local Silent = false

WhiffFirstName = ""
WhiffSecondName = ""
WhiffThirdName = ""
WhiffFirstAmount = 0
WhiffSecondAmount = 0
WhiffThirdAmount = 0

HSFirstName = ""
HSSecondName = ""
HSThirdName = ""
HSFourthName = ""
HSFifthName = ""
HSFirstDamage = 0
HSSecondDamage = 0
HSThirdDamage = 0
HSFourthDamage = 0
HSFifthDamage = 0
HSFirstWS = ""
HSSecondWS = ""
HSThirdWS = ""
HSFourthWS = ""
HSFifthWS = ""
HSFirstTarget = ""
HSSecondTarget = ""
HSThirdTarget = ""
HSFourthTarget = ""
HSFifthTarget = ""

LSFirstName = ""
LSSecondName = ""
LSThirdName = ""
LSFirstDamage = 999999
LSSecondDamage = 999999
LSThirdDamage = 999999
LSFirstWS = ""
LSSecondWS = ""
LSThirdWS = ""
LSFirstTarget = ""
LSSecondTarget = ""
LSThirdTarget = ""

NukeFirstName = ""
NukeSecondName = ""
NukeThirdName = ""
NukeFourthName = ""
NukeFifthName = ""
NukeFirstDamage = 0
NukeSecondDamage = 0
NukeThirdDamage = 0
NukeFourthDamage = 0
NukeFifthDamage = 0


CureFirstName = ""
CureSecondName = ""
CureThirdName = ""
CureFirstAmount = 0
CureSecondAmount = 0
CureThirdAmount = 0

KillFirstName = ""
KillSecondName = ""
KillThirdName = ""
KillFirstAmount = 0
KillSecondAmount = 0
KillThirdAmount = 0
kills_total = 0

DeathFirstName = ""
DeathSecondName = ""
DeathThirdName = ""
DeathFirstAmount = 0
DeathSecondAmount = 0
DeathThirdAmount = 0
deaths_total = 0

CureThings = T{
	'Cure','Cure II','Cure III','Cure IV','Cure V','Cure VI','Curaga','Curaga II','Curaga III','Curaga IV','Curaga V','Cura','Cura II','Cura III','Pollen','Wild Carrot','Healing Breeze','Magic Fruit','Exuviation','Plenilune Embrace','White Wind','Restoral','Full Cure','Benediction','Repair','Curing Waltz','Curing Waltz II','Curing Waltz III','Curing Waltz IV','Curing Waltz V','Divine Waltz','Divine Waltz II','Life Cycle','Mending Halation','Vivacious Pulse','Healing Ruby','Healing Ruby II','Spring Water','Whispering Wind','Healing Breath','Healing Breath II','Healing Breath II','Healing Breath IV','Potion','Hi-Potion','X-Potion','Hyper Potion','Max. Potion','Mix: Max. Potion','Chakra'
    }


-- function get_actor(id)
    -- local actor = windower.ffxi.get_mob_by_id(id)
    -- if not actor == nil or (not actor.in_alliance and not actor.in_party) then --------------------------------------------------------------------------------------- nil value???
		-- return false
    -- else
        -- return actor
    -- end
-- end

function get_actor(id) --------------------------------------------------------------------------------------- trying to fix the nil value above
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
	if act.category == 4 or act.category == 6 or act.category == 14 or act.category == 5 or act.category == 11 and Run then
		local actor = get_actor(act.actor_id)

		if actor == false then
			return
		end

		local data = {}
		data.actor = actor.id
		data.actor_name = actor.name or 'Unknown'
		data.curething = (spells[act.param] and spells[act.param].english) or (jabils[act.param] and jabils[act.param].english) or (mabils[act.param] and mabils[act.param].english) or 'Unknown'

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

			if cure[data.actor_name] > CureFirstAmount then
				if data.actor_name == CureFirstName or CureFirstAmount == 0 then
					--First Place extends their lead (or the first cure)
					CureFirstName = data.actor_name
					CureFirstAmount = cure[data.actor_name]
				elseif data.actor_name == CureSecondName then
					--Second Place moves into First Place
					CureSecondName = CureFirstName
					CureFirstName = data.actor_name
					CureSecondAmount = CureFirstAmount
					CureFirstAmount = cure[data.actor_name]
				else
					--Third Place or lower moves into First Place
					CureThirdName = CureSecondName
					CureSecondName = CureFirstName
					CureFirstName = data.actor_name
					CureThirdAmount = CureSecondAmount
					CureSecondAmount = CureFirstAmount
					CureFirstAmount = cure[data.actor_name]
				end
			elseif cure[data.actor_name] > CureSecondAmount then
				if data.actor_name == CureSecondName or (data.actor_name ~= CureFirstName and CureSecondAmount == 0) then
					--Second Place updates their best but stays in Second Place (or the second cure)
					CureSecondName = data.actor_name
					CureSecondAmount = cure[data.actor_name]
				elseif data.actor_name ~= CureFirstName then
					--Third Place or lower moves into Second Place
					CureThirdName = CureSecondName
					CureSecondName = data.actor_name
					CureThirdAmount = CureSecondAmount
					CureSecondAmount = cure[data.actor_name]
				end
			elseif cure[data.actor_name] > CureThirdAmount and data.actor_name ~= CureFirstName and data.actor_name ~= CureSecondName then
				--Third Place updates their best or somebody not already on the board moves into Third Place
				CureThirdName = data.actor_name
				CureThirdAmount = cure[data.actor_name]
			end
		end

	--Weapon Skills
	elseif act.category == 3 and Run then
		--print(''..weaponskills[act.param].english..' ('..act.param..')')
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
		data.jabils = jabils[act.param] and jabils[act.param].english or 'Unknown'

		if data.ws == 'Atonement' or data.ws == 'Flat Blade' or data.ws == 'Tachi: Hobaku' or data.ws == 'Shoulder Tackle' or data.ws == 'Leg Sweep' or data.ws == 'Myrkr' or data.ws == 'Starlight' or data.ws == 'Moonlight' or data.ws == 'Energy Drain' or data.jabils == 'Eagle Eye Shot' or data.jabils == 'Mijin Gakure' or data.jabils == 'Shield Bash' or data.jabils == 'Jump' or data.jabils == 'High Jump' or data.jabils == 'Super Jump' or data.jabils == 'Weapon Bash' or data.jabils == 'Chi Blast' or data.jabils == 'Fire Shot' or data.jabils == 'Ice Shot' or data.jabils == 'Wind Shot' or data.jabils == 'Earth Shot' or data.jabils == 'Thunder Shot' or data.jabils == 'Water Shot' or data.jabils == 'Light Shot' or data.jabils == 'Dark Shot' or data.jabils == 'Blade Bash' or data.jabils == 'Spirit Jump' or data.jabils == 'Bounty Shot' or data.jabils == 'Soul Jump' or data.jabils == 'Intervene' or data.jabils == 'Swipe' or data.jabils == 'Concentric Pulse' or data.jabils == 'Lunge' then
			return
		end

		--Whiffs
		if act.targets[1].actions[1].message == 188 or act.targets[1].actions[1].message == 31 or data.damage == 0 then --Uses Weapon Skill, but misses or hit for 0
			local whiffs = whiff[data.actor_name] or 0
			whiff[data.actor_name] = whiffs+1
			if not Silent then
				if whiff[data.actor_name] == 10 and data.actor_name == WhiffFirstName then
					say:schedule(1,'/p '..data.actor_name..' whiffs '..data.ws..' and is the first to hit the whiff spam wall.')
				elseif whiff[data.actor_name] == 10 then
					say:schedule(1,'/p '..data.actor_name..' whiffs '..data.ws..' and has hit the whiff spam wall.')
				elseif whiff[data.actor_name] > 5 and whiffs < 10 then
					say:schedule(1,'/p '..data.actor_name..' whiffs '..data.ws..' yet again...')
				elseif whiff[data.actor_name] == 5 then
					say:schedule(1,'/p '..data.actor_name..' whiffs '..data.ws..' and is halfway to the whiff spam wall.')
				elseif whiff[data.actor_name] > 1 and whiff[data.actor_name] < 5 then
					say:schedule(1,'/p '..data.actor_name..' whiffs '..data.ws..' again... ')
				elseif whiff[data.actor_name] == 1 then
					say:schedule(1,'/p '..data.actor_name..' whiffs '..data.ws..'...')
				end
			end

			if whiff[data.actor_name] > WhiffFirstAmount then
				if data.actor_name == WhiffFirstName or WhiffFirstAmount == 0 then
					--First Place extends their lead (or the first whiff)
					WhiffFirstName = data.actor_name
					WhiffFirstAmount = whiff[data.actor_name]
				elseif data.actor_name == WhiffSecondName then
					--Second Place moves into First Place
					WhiffSecondName = WhiffFirstName
					WhiffFirstName = data.actor_name
					WhiffSecondAmount = WhiffFirstAmount
					WhiffFirstAmount = whiff[data.actor_name]
				elseif data.actor_name ~= WhiffFirstName and data.actor_name ~= WhiffSecondName then
					--Third Place or lower moves into First Place
					WhiffThirdName = WhiffSecondName
					WhiffSecondName = WhiffFirstName
					WhiffFirstName = data.actor_name
					WhiffThirdAmount = WhiffSecondAmount
					WhiffSecondAmount = WhiffFirstAmount
					WhiffFirstAmount = whiff[data.actor_name]
				end
			elseif whiff[data.actor_name] > WhiffSecondAmount then
				if data.actor_name == WhiffSecondName or (data.actor_name ~= WhiffFirstName and WhiffSecondAmount == 0) then
					--Second Place updates their best but stays in Second Place (or the second whiff)
					WhiffSecondName = data.actor_name
					WhiffSecondAmount = whiff[data.actor_name]
				elseif data.actor_name ~= WhiffFirstName then
					--Third Place or lower moves into Second Place
					WhiffThirdName = WhiffSecondName
					WhiffSecondName = data.actor_name
					WhiffThirdAmount = WhiffSecondAmount
					WhiffSecondAmount = whiff[data.actor_name]
				end
			elseif whiff[data.actor_name] > WhiffThirdAmount and data.actor_name ~= WhiffFirstName and data.actor_name ~= WhiffSecondName then
				--Third Place (or Lower) updates their best (or moves into Third Place)
				WhiffThirdName = data.actor_name
				WhiffThirdAmount = whiff[data.actor_name]
			end

		else

			--High Score
			if data.damage > HSFirstDamage then
				if data.actor_name == HSFirstName or HSFirstDamage == 0 then 
					--First Place extends their lead (or the first ws)
					HSFirstName = data.actor_name
					HSFirstDamage = data.damage
					HSFirstWS = data.ws
					HSFirstTarget = data.target_name
				elseif data.actor_name == HSSecondName then
					--Second Place moves into First Place
					HSSecondName = HSFirstName
					HSFirstName = data.actor_name
					HSSecondDamage = HSFirstDamage
					HSFirstDamage = data.damage
					HSSecondWS = HSFirstWS
					HSFirstWS = data.ws
					HSSecondTarget = HSFirstTarget
					HSFirstTarget = data.target_name
				elseif data.actor_name == HSThirdName then
					--Third Place moves into First Place
					HSThirdName = HSSecondName
					HSSecondName = HSFirstName
					HSFirstName = data.actor_name
					HSThirdDamage = HSSecondDamage
					HSSecondDamage = HSFirstDamage
					HSFirstDamage = data.damage
					HSThirdWS = HSSecondWS
					HSSecondWS = HSFirstWS
					HSFirstWS = data.ws
					HSThirdTarget = HSSecondTarget
					HSSecondTarget = HSFirstTarget
					HSFirstTarget = data.target_name
				elseif data.actor_name == HSFourthName then
					--Fourth Place moves into First Place
					HSFourthName = HSThirdName
					HSThirdName = HSSecondName
					HSSecondName = HSFirstName
					HSFirstName = data.actor_name
					HSFourthDamage = HSThirdDamage
					HSThirdDamage = HSSecondDamage
					HSSecondDamage = HSFirstDamage
					HSFirstDamage = data.damage
					HSFourthWS = HSThirdWS
					HSThirdWS = HSSecondWS
					HSSecondWS = HSFirstWS
					HSFirstWS = data.ws
					HSFourthTarget = HSThirdTarget
					HSThirdTarget = HSSecondTarget
					HSSecondTarget = HSFirstTarget
					HSFirstTarget = data.target_name
				else
					--Fifth Place or somebody not already on the board moves into First Place
					HSFifthName = HSFourthName
					HSFourthName = HSThirdName
					HSThirdName = HSSecondName
					HSSecondName = HSFirstName
					HSFirstName = data.actor_name
					HSFifthDamage = HSFourthDamage
					HSFourthDamage = HSThirdDamage
					HSThirdDamage = HSSecondDamage
					HSSecondDamage = HSFirstDamage
					HSFirstDamage = data.damage
					HSFifthWS = HSFourthWS
					HSFourthWS = HSThirdWS
					HSThirdWS = HSSecondWS
					HSSecondWS = HSFirstWS
					HSFirstWS = data.ws
					HSFifthTarget = HSFourthTarget
					HSFourthTarget = HSThirdTarget
					HSThirdTarget = HSSecondTarget
					HSSecondTarget = HSFirstTarget
					HSFirstTarget = data.target_name
				end
				if not Silent then
					coroutine.sleep(1)
					say('/p New HIGH Score! '..HSFirstName..' with a '..HSFirstDamage..' '..HSFirstWS..' on '..HSFirstTarget..'')
				end
			elseif data.damage > HSSecondDamage then
				if data.actor_name == HSSecondName or (data.actor_name ~= HSFirstName and HSSecondDamage == 0) then
					--Second Place updates their best but stays in Second Place (or the second ws)
					HSSecondName = data.actor_name
					HSSecondDamage = data.damage
					HSSecondWS = data.ws
					HSSecondTarget = data.target_name
				elseif data.actor_name == HSThirdName then
					--Third Place moves into Second Place
					HSThirdName = HSSecondName
					HSSecondName = data.actor_name
					HSThirdDamage = HSSecondDamage
					HSSecondDamage = data.damage
					HSThirdWS = HSSecondWS
					HSSecondWS = data.ws
					HSThirdTarget = HSSecondTarget
					HSSecondTarget = data.target_name
					if not Silent then
						coroutine.sleep(1)
						say('/p HIGH Score Leaderboard: '..HSSecondName..' moves into the No.2 slot with a '..HSSecondDamage..' '..HSSecondWS..' on '..HSSecondTarget..'')
					end
				elseif data.actor_name == HSFourthName then
					--Fourth Place moves into Second Place
					HSFourthName = HSThirdName
					HSThirdName = HSSecondName
					HSSecondName = data.actor_name
					HSFourthDamage = HSThirdDamage
					HSThirdDamage = HSSecondDamage
					HSSecondDamage = data.damage
					HSFourthWS = HSThirdWS
					HSThirdWS = HSSecondWS
					HSSecondWS = data.ws
					HSFourthTarget = HSThirdTarget
					HSThirdTarget = HSSecondTarget
					HSSecondTarget = data.target_name
					if not Silent then
						coroutine.sleep(1)
						say('/p HIGH Score Leaderboard: '..HSSecondName..' moves into the No.2 slot with a '..HSSecondDamage..' '..HSSecondWS..' on '..HSSecondTarget..'')
					end
				elseif data.actor_name ~= HSFirstName then
					--Fifth Place or somebody not already on the board moves into Second Place
					HSFifthName = HSFourthName
					HSFourthName = HSThirdName
					HSThirdName = HSSecondName
					HSSecondName = data.actor_name
					HSFifthDamage = HSFourthDamage
					HSFourthDamage = HSThirdDamage
					HSThirdDamage = HSSecondDamage
					HSSecondDamage = data.damage
					HSFifthWS = HSFourthWS
					HSFourthWS = HSThirdWS
					HSThirdWS = HSSecondWS
					HSSecondWS = data.ws
					HSFifthTarget  = HSFourthTarget
					HSFourthTarget = HSThirdTarget
					HSThirdTarget = HSSecondTarget
					HSSecondTarget = data.target_name
					if not Silent then
						coroutine.sleep(1)
						say('/p HIGH Score Leaderboard: '..HSSecondName..' moves into the No.2 slot with a '..HSSecondDamage..' '..HSSecondWS..' on '..HSSecondTarget..'')
					end
				end
			elseif data.damage > HSThirdDamage then
				if data.actor_name == HSThirdName or (data.actor_name ~= HSFirstName and data.actor_name ~= HSSecondName and HSThirdDamage == 0) then
					--Third Place updates their best but stays in Third Place (or the third ws)
					HSThirdName = data.actor_name
					HSThirdDamage = data.damage
					HSThirdWS = data.ws
					HSThirdTarget = data.target_name
				elseif data.actor_name == HSFourthName then
					--Fourth Place moves into Third Place
					HSFourthName = HSThirdName
					HSThirdName = data.actor_name
					HSFourthDamage = HSThirdDamage
					HSThirdDamage = data.damage
					HSFourthWS = HSThirdWS
					HSThirdWS = data.ws
					HSFourthTarget = HSThirdTarget
					HSThirdTarget = data.target_name
					if not Silent then
						coroutine.sleep(1)
						say('/p HIGH Score Leaderboard: '..HSThirdName..' moves into the No.3 slot with a '..HSThirdDamage..' '..HSThirdWS..' on '..HSThirdTarget..'')
					end
				elseif data.actor_name ~= HSFirstName and data.actor_name ~= HSSecondName then
					--Fifth Place or somebody not already on the board moves into Third Place
					HSFifthName = HSFourthName
					HSFourthName = HSThirdName
					HSThirdName = data.actor_name
					HSFifthDamage = HSFourthDamage
					HSFourthDamage = HSThirdDamage
					HSThirdDamage = data.damage
					HSFifthWS = HSFourthWS
					HSFourthWS = HSThirdWS
					HSThirdWS = data.ws
					HSFifthTarget = HSFourthTarget
					HSFourthTarget = HSThirdTarget
					HSThirdTarget = data.target_name
					if not Silent then
						coroutine.sleep(1)
						say('/p HIGH Score Leaderboard: '..HSThirdName..' moves into the No.3 slot with a '..HSThirdDamage..' '..HSThirdWS..' on '..HSThirdTarget..'')
					end
				end
			elseif data.damage > HSFourthDamage then
				if data.actor_name == HSFourthName or (data.actor_name ~= HSFirstName and data.actor_name ~= HSSecondName and data.actor_name ~= HSThirdName and HSFourthDamage == 0) then
					--Fourth Place updates their best but stays in Fourth Place (or the fourth ws)
					HSFourthName = data.actor_name
					HSFourthDamage = data.damage
					HSFourthWS = data.ws
					HSFourthTarget = data.target_name
				elseif data.actor_name ~= HSFirstName and data.actor_name ~= HSSecondName and data.actor_name ~= HSThirdName then
					--Fifth Place or somebody not already on the board moves into Fourth Place
					HSFifthName = HSFourthName
					HSFourthName = data.actor_name
					HSFifthDamage = HSFourthDamage
					HSFourthDamage = data.damage
					HSFifthWS = HSFourthWS
					HSFourthWS = data.ws
					HSFifthTarget = HSFourthTarget
					HSFourthTarget = data.target_name
					if not Silent then
						coroutine.sleep(1)
						say('/p HIGH Score Leaderboard: '..HSFourthName..' moves into the No.4 slot with a '..HSFourthDamage..' '..HSFourthWS..' on '..HSFourthTarget..'')
					end
				end
			elseif data.damage > HSFifthDamage then
				--Fifth Place or somebody not already on the board moves into Fifth Place
				if data.actor_name == HSFifthName or (data.actor_name ~= HSFirstName and data.actor_name ~= HSSecondName and data.actor_name ~= HSThirdName and data.actor_name ~= HSFourthName and HSFifthDamage == 0) then
					--Fifth Place updates their best but stays in Fifth Place (or the fifth ws)
					HSFifthName = data.actor_name
					HSFifthDamage = data.damage
					HSFifthWS = data.ws
					HSFifthTarget = data.target_name
				elseif data.actor_name ~= HSFirstName and data.actor_name ~= HSSecondName and data.actor_name ~= HSThirdName and data.actor_name ~= HSFourthName then
					--Somebody not already on the board moves into Fifth Place
					HSFifthName = data.actor_name
					HSFifthDamage = data.damage
					HSFifthWS = data.ws
					HSFifthTarget = data.target_name
					if not Silent then
						coroutine.sleep(1)
						say('/p HIGH Score Leaderboard: '..HSFifthName..' moves into the No.5 slot with a '..HSFifthDamage..' '..HSFifthWS..' on '..HSFifthTarget..'')
					end
				end
			end

			--Low Score
			if data.damage < LSFirstDamage then
				if data.actor_name == LSFirstName or LSFirstDamage == 999999 then
					--First Place extends their "lead" (or the first low ws)
					LSFirstName = data.actor_name
					LSFirstDamage = data.damage
					LSFirstWS = data.ws
					LSFirstTarget = data.target_name
				elseif data.actor_name == LSSecondName then
					--Second Place moves into First Place
					LSSecondName = LSFirstName
					LSFirstName = data.actor_name
					LSSecondDamage = LSFirstDamage
					LSFirstDamage = data.damage
					LSSecondWS = LSFirstWS
					LSFirstWS = data.ws
					LSSecondTarget = LSFirstTarget
					LSFirstTarget = data.target_name
				else
					--Third Place or somebody not already on the board moves into First Place
					LSThirdName = LSSecondName
					LSSecondName = LSFirstName
					LSFirstName = data.actor_name
					LSThirdDamage = LSSecondDamage
					LSSecondDamage = LSFirstDamage
					LSFirstDamage = data.damage
					LSThirdWS = LSSecondWS
					LSSecondWS = LSFirstWS
					LSFirstWS = data.ws
					LSThirdTarget = LSSecondTarget
					LSSecondTarget = LSFirstTarget
					LSFirstTarget = data.target_name
				end
				if LSThirdDamage ~= 999999 and not Silent then
					coroutine.sleep(1)
					say('/p New LOW Score! '..data.actor_name..' with a '..data.damage..' '..data.ws..' on '..data.target_name..'')
				end
			elseif data.damage < LSSecondDamage then
				if data.actor_name == LSSecondName or (data.actor_name ~= LSFirstName and LSSecondDamage == 999999) then
					--Second Place updates their best but stays in Second Place (or the second low ws)
					LSSecondName = data.actor_name
					LSSecondDamage = data.damage
					LSSecondWS = data.ws
					LSSecondTarget = data.target_name
				elseif data.actor_name ~= LSFirstName then
					--Third Place or somebody not already on the board moves into Second Place
					LSThirdName = LSSecondName
					LSSecondName = data.actor_name
					LSThirdDamage = LSSecondDamage
					LSSecondDamage = data.damage
					LSThirdWS = LSSecondWS
					LSSecondWS = data.ws
					LSThirdTarget = LSSecondTarget
					LSSecondTarget = data.target_name
					if LSThirdDamage ~= 999999 and not Silent then
						coroutine.sleep(1)
						say('/p LOW Score Leaderboard: '..LSSecondName..' moves into the No.2 slot with a '..LSSecondDamage..' '..LSSecondWS..' on '..LSSecondTarget..'')
					end
				end
			elseif data.damage < LSThirdDamage then
				--Third Place or somebody not already on the board moves into Third Place
				if data.actor_name == LSThirdName or (data.actor_name ~= LSFirstName and data.actor_name ~= LSSecondName and LSThirdDamage == 999999) then
					--Third Place updates their best but stays in Third Place (or the third low ws)
					LSThirdName = data.actor_name
					LSThirdDamage = data.damage
					LSThirdWS = data.ws
					LSThirdTarget = data.target_name
				elseif data.actor_name ~= LSFirstName and data.actor_name ~= LSSecondName then
					--Somebody not already on the board moves into Third Place
					LSThirdName = data.actor_name
					LSThirdDamage = data.damage
					LSThirdWS = data.ws
					LSThirdTarget = data.target_name
					if LSThirdDamage ~= 999999 and not Silent then
						coroutine.sleep(1)
						say('/p LOW Score Leaderboard: '..LSThirdName..' moves into the No.3 slot with a '..LSThirdDamage..' '..LSThirdWS..' on '..LSThirdTarget..'')
					end
				end
			end

		end
	end

	--Nukes
	if act.category == 4 and Run then

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

		if nuke[data.actor_name] > NukeFirstDamage then
			if data.actor_name == NukeFirstName or NukeFirstDamage == 0 then 
				--First Place extends their lead (or the first nuke)
				NukeFirstName = data.actor_name
				NukeFirstDamage = nuke[data.actor_name]
			elseif data.actor_name == NukeSecondName then
				--Second Place moves into First Place
				NukeSecondName = NukeFirstName
				NukeFirstName = data.actor_name
				NukeSecondDamage = NukeFirstDamage
				NukeFirstDamage = nuke[data.actor_name]
			elseif data.actor_name == NukeThirdName then
				--Third Place moves into First Place
				NukeThirdName = NukeSecondName
				NukeSecondName = NukeFirstName
				NukeFirstName = data.actor_name
				NukeThirdDamage = NukeSecondDamage
				NukeSecondDamage = NukeFirstDamage
				NukeFirstDamage = nuke[data.actor_name]
			elseif data.actor_name == NukeFourthName then
				--Fourth Place moves into First Place
				NukeFourthName = NukeThirdName
				NukeThirdName = NukeSecondName
				NukeSecondName = NukeFirstName
				NukeFirstName = data.actor_name
				NukeFourthDamage = NukeThirdDamage
				NukeThirdDamage = NukeSecondDamage
				NukeSecondDamage = NukeFirstDamage
				NukeFirstDamage = nuke[data.actor_name]

			else
				--Fifth Place or somebody not already on the board moves into First Place
				NukeFifthName = NukeFourthName
				NukeFourthName = NukeThirdName
				NukeThirdName = NukeSecondName
				NukeSecondName = NukeFirstName
				NukeFirstName = data.actor_name
				NukeFifthDamage = NukeFourthDamage
				NukeFourthDamage = NukeThirdDamage
				NukeThirdDamage = NukeSecondDamage
				NukeSecondDamage = NukeFirstDamage
				NukeFirstDamage = nuke[data.actor_name]
			end
		elseif nuke[data.actor_name] > NukeSecondDamage then
			if data.actor_name == NukeSecondName or (data.actor_name ~= NukeFirstName and NukeSecondDamage == 0) then
				--Second Place updates their best but stays in Second Place (or the second nuke)
				NukeSecondName = data.actor_name
				NukeSecondDamage = nuke[data.actor_name]
			elseif data.actor_name == NukeThirdName then
				--Third Place moves into Second Place
				NukeThirdName = NukeSecondName
				NukeSecondName = data.actor_name
				NukeThirdDamage = NukeSecondDamage
				NukeSecondDamage = nuke[data.actor_name]
			elseif data.actor_name == NukeFourthName then
				--Fourth Place moves into Second Place
				NukeFourthName = NukeThirdName
				NukeThirdName = NukeSecondName
				NukeSecondName = data.actor_name
				NukeFourthDamage = NukeThirdDamage
				NukeThirdDamage = NukeSecondDamage
				NukeSecondDamage = nuke[data.actor_name]
			elseif data.actor_name ~= NukeFirstName then
				--Fifth Place or somebody not already on the board moves into Second Place
				NukeFifthName = NukeFourthName
				NukeFourthName = NukeThirdName
				NukeThirdName = NukeSecondName
				NukeSecondName = data.actor_name
				NukeFifthDamage = NukeFourthDamage
				NukeFourthDamage = NukeThirdDamage
				NukeThirdDamage = NukeSecondDamage
				NukeSecondDamage = nuke[data.actor_name]
			end
		elseif nuke[data.actor_name] > NukeThirdDamage then
			if data.actor_name == NukeThirdName or (data.actor_name ~= NukeFirstName and data.actor_name ~= NukeSecondName and NukeThirdDamage == 0) then
				--Third Place updates their best but stays in Third Place (or the third nuke)
				NukeThirdName = data.actor_name
				NukeThirdDamage = nuke[data.actor_name]
			elseif data.actor_name == NukeFourthName then
				--Fourth Place moves into Third Place
				NukeFourthName = NukeThirdName
				NukeThirdName = data.actor_name
				NukeFourthDamage = NukeThirdDamage
				NukeThirdDamage = nuke[data.actor_name]
			elseif data.actor_name ~= NukeFirstName and data.actor_name ~= NukeSecondName then
				--Fifth Place or somebody not already on the board moves into Third Place
				NukeFifthName = NukeFourthName
				NukeFourthName = NukeThirdName
				NukeThirdName = data.actor_name
				NukeFifthDamage = NukeFourthDamage
				NukeFourthDamage = NukeThirdDamage
				NukeThirdDamage = nuke[data.actor_name]
			end
		elseif nuke[data.actor_name] > NukeFourthDamage then
			if data.actor_name == NukeFourthName or (data.actor_name ~= NukeFirstName and data.actor_name ~= NukeSecondName and data.actor_name ~= NukeThirdName and NukeFourthDamage == 0) then
				--Fourth Place updates their best but stays in Fourth Place (or the fourth nuke)
				NukeFourthName = data.actor_name
				NukeFourthDamage = nuke[data.actor_name]
			elseif data.actor_name ~= NukeFirstName and data.actor_name ~= NukeSecondName and data.actor_name ~= NukeThirdName then
				--Fifth Place or somebody not already on the board moves into Fourth Place
				NukeFifthName = NukeFourthName
				NukeFourthName = data.actor_name
				NukeFifthDamage = NukeFourthDamage
				NukeFourthDamage = nuke[data.actor_name]
			end
		elseif nuke[data.actor_name] > NukeFifthDamage and data.actor_name ~= NukeFirstName and data.actor_name ~= NukeSecondName and data.actor_name ~= NukeThirdName and data.actor_name ~= NukeFourthName then
			--Fifth Place updates their best or somebody not already on the board moves into Fifth Place
			NukeFifthName = data.actor_name
			NukeFifthDamage = nuke[data.actor_name]
		end
		print(''..data.actor_name..' - '..nuke[data.actor_name]..'')
	end
end)

windower.register_event('addon command',function(addcmd, arg)

	if addcmd == 'reload' then
        cmd('lua r leaderboard')
        return

 	elseif addcmd == 'help' then
		windower.add_to_chat(200,'[Leaderboard] '..('--Commands--'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('start - start tracking'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('starts - start tracking in Silent Mode'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('pause/p - pause/unpause tracking)'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('silent/s - toggle Silent Mode on or off'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('c, d, hs, k, ls, n, w - print current leaderboards to party chat'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('boards - list the different leaderboards that are tracked)'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('reload - reload the addon)'):color(8)..'')

	elseif addcmd == 'start' then
		Run = true
		say('/p Leaderboard started! Type \'!lb\' followed by \'c\' \'d\' \'hs\' \'k\' \'ls\' \'n\' or \'w\' for current leaderboards')
		coroutine.sleep(1)
		windower.add_to_chat(200,'[Leaderboard] '..('Beware - This addon uses party chat heavily.'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('//lb pause, silent, boards, reload'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('//lb c, d, hs, k, ls, n, or w to print current leaderboards to party chat'):color(8)..'')

	elseif addcmd == 'starts' then
		Run = true
		Silent = true
		windower.add_to_chat(200,'[Leaderboard] '..('Leaderboard started in Silent Mode'):color(8)..'')
		coroutine.sleep(1)
		windower.add_to_chat(200,'[Leaderboard] '..('//lb pause, silent, boards, reload'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('//lb c, d, hs, k, ls, n, or w to print current leaderboards to party chat'):color(8)..'')

	elseif addcmd == 'pause' or addcmd == 'p' then
		if Run == true then
			Run = false
			say('/p Leaderboard paused.')
		else
			Run = true
			say('/p Leaderboard unpaused.')
		end

	elseif addcmd == 'silent' or addcmd == 's' then
		if Silent == true then
			Silent = false
			windower.add_to_chat(200,'[Leaderboard] '..('Silent Mode off'):color(8)..'')
		else
			Silent = true
			windower.add_to_chat(200,'[Leaderboard] '..('Silent Mode on'):color(8)..'')
		end

	elseif addcmd == 'board' or addcmd == 'boards' then
		windower.add_to_chat(200,'[Leaderboard] '..('--Current Tracked Leaderboards--'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('c/cure - Running total of cures (up to 3 places)'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('d/death - Running total of deaths (up to 3 places)'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('hs/highscore - Highest individual WS damage (up to 5 places)'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('k/kill - Running total of kills (up to 3 places)'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('ls/lowscore - Lowest individual WS damage (up to 3 places)'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('n/nuke - Running total of nukes (up to 5 places)'):color(8)..'')
		windower.add_to_chat(200,'[Leaderboard] '..('w/whiffs - Running total of whiffs (up to 3 places)'):color(8)..'')

	elseif addcmd == 'c' or addcmd =='cure' or addcmd =='cures' then
		if CureThirdAmount ~= 0 then
			say('/p \r--Cure Leaderboard--\rNo.1: '..CureFirstName..' ('..CureFirstAmount..')\rNo.2: '..CureSecondName..' ('..CureSecondAmount..')\rNo.3: '..CureThirdName..' ('..CureThirdAmount..')')
		elseif CureSecondAmount ~= 0 then
			say('/p \r--Cure Leaderboard--\rNo.1: '..CureFirstName..' ('..CureFirstAmount..')\rNo.2: '..CureSecondName..' ('..CureSecondAmount..')')
		elseif CureFirstAmount ~= 0 then
			say('/p \r--Cure Leaderboard--\rNo.1: '..CureFirstName..' ('..CureFirstAmount..')')
		else
			say('/p \r--Cure Leaderboard--\rNo data yet')
		end

	elseif addcmd == 'd' or addcmd =='death' or addcmd =='deaths' then
		if DeathThirdAmount ~= 0 then
			local DeathFirstPercent = (math.floor((DeathFirstAmount/deaths_total)*10000))/100
			local DeathSecondPercent = (math.floor((DeathSecondAmount/deaths_total)*10000))/100
			local DeathThirdPercent = (math.floor((DeathThirdAmount/deaths_total)*10000))/100
			say('/p \r--Death Leaderboard--\rNo.1: '..DeathFirstName..' ('..DeathFirstAmount..', '..DeathFirstPercent..'%)\rNo.2: '..DeathSecondName..' ('..DeathSecondAmount..', '..DeathSecondPercent..'%)\rNo.3: '..DeathThirdName..' ('..DeathThirdAmount..', '..DeathThirdPercent..'%)')
		elseif DeathSecondAmount ~= 0 then
			local DeathFirstPercent = (math.floor((DeathFirstAmount/deaths_total)*10000))/100
			local DeathSecondPercent = (math.floor((DeathSecondAmount/deaths_total)*10000))/100
			say('/p \r--Death Leaderboard--\rNo.1: '..DeathFirstName..' ('..DeathFirstAmount..', '..DeathFirstPercent..'%)\rNo.2: '..DeathSecondName..' ('..DeathSecondAmount..', '..DeathSecondPercent..'%)')
		elseif DeathFirstAmount ~= 0 then
			local DeathFirstPercent = (math.floor((DeathFirstAmount/deaths_total)*10000))/100
			say('/p \r--Death Leaderboard--\rNo.1: '..DeathFirstName..' ('..DeathFirstAmount..', '..DeathFirstPercent..'%)')
		else
			say('/p \r--Death Leaderboard--\rNo data yet')
		end

	elseif addcmd == 'ls' or addcmd =='lowscore' then
		if LSThirdDamage ~= 999999 then
			say('/p \r--Low Score Leaderboard--\rNo.1: '..LSFirstName..' ('..LSFirstDamage..')\rNo.2: '..LSSecondName..' ('..LSSecondDamage..')\rNo.3: '..LSThirdName..' ('..LSThirdDamage..')')
		elseif LSSecondDamage ~= 999999 then
			say('/p \r--Low Score Leaderboard--\rNo.1: '..LSFirstName..' ('..LSFirstDamage..')\rNo.2: '..LSSecondName..' ('..LSSecondDamage..')')
		elseif LSFirstDamage ~= 999999 then
			say('/p \r--Low Score Leaderboard--\rNo.1: '..LSFirstName..' ('..LSFirstDamage..')')
		else
			say('/p \r--Low Score Leaderboard--\rNo data yet')
		end

	elseif addcmd == 'hs' or addcmd =='highscore' or addcmd =='hiscore' then
		if HSFifthDamage ~= 0 then
			say('/p \r--High Score Leaderboard--\rNo.1: '..HSFirstName..' ('..HSFirstDamage..')\rNo.2: '..HSSecondName..' ('..HSSecondDamage..')\rNo.3: '..HSThirdName..' ('..HSThirdDamage..')\rNo.4: '..HSFourthName..' ('..HSFourthDamage..')\rNo.5: '..HSFifthName..' ('..HSFifthDamage..')')
		elseif HSFourthDamage ~= 0 then
			say('/p \r--High Score Leaderboard--\rNo.1: '..HSFirstName..' ('..HSFirstDamage..')\rNo.2: '..HSSecondName..' ('..HSSecondDamage..')\rNo.3: '..HSThirdName..' ('..HSThirdDamage..')\rNo.4: '..HSFourthName..' ('..HSFourthDamage..')')
		elseif HSThirdDamage ~= 0 then
			say('/p \r--High Score Leaderboard--\rNo.1: '..HSFirstName..' ('..HSFirstDamage..')\rNo.2: '..HSSecondName..' ('..HSSecondDamage..')\rNo.3: '..HSThirdName..' ('..HSThirdDamage..')')
		elseif HSSecondDamage ~= 0 then
			say('/p \r--High Score Leaderboard--\rNo.1: '..HSFirstName..' ('..HSFirstDamage..')\rNo.2: '..HSSecondName..' ('..HSSecondDamage..')')
		elseif HSFirstDamage ~= 0 then
			say('/p \r--High Score Leaderboard--\rNo.1: '..HSFirstName..' ('..HSFirstDamage..')')
		else
			say('/p \r--High Score Leaderboard--\rNo data yet')
		end

	elseif addcmd == 'k' or addcmd =='kill' or addcmd =='kills' then
		if KillThirdAmount ~= 0 then
			local KillFirstPercent = math.floor((KillFirstAmount/kills_total)*10000)/100
			local KillSecondPercent = math.floor((KillSecondAmount/kills_total)*10000)/100
			local KillThirdPercent = math.floor((KillThirdAmount/kills_total)*10000)/100
			say('/p \r--Kill Leaderboard--\rNo.1: '..KillFirstName..' ('..KillFirstAmount..', '..KillFirstPercent..'%)\rNo.2: '..KillSecondName..' ('..KillSecondAmount..', '..KillSecondPercent..'%)\rNo.3: '..KillThirdName..' ('..KillThirdAmount..', '..KillThirdPercent..'%)')
		elseif KillSecondAmount ~= 0 then
			local KillFirstPercent = math.floor((KillFirstAmount/kills_total)*10000)/100
			local KillSecondPercent = math.floor((KillSecondAmount/kills_total)*10000)/100
			say('/p \r--Kill Leaderboard--\rNo.1: '..KillFirstName..' ('..KillFirstAmount..', '..KillFirstPercent..'%)\rNo.2: '..KillSecondName..' ('..KillSecondAmount..', '..KillSecondPercent..'%)')
		elseif KillFirstAmount ~= 0 then
			local KillFirstPercent = math.floor((KillFirstAmount/kills_total)*10000)/100
			say('/p \r--Kill Leaderboard--\rNo.1: '..KillFirstName..' ('..KillFirstAmount..', '..KillFirstPercent..'%)')
		else
			say('/p \r--Kill Leaderboard--\rNo data yet')
		end

	elseif addcmd == 'n' or addcmd =='nuke' or addcmd =='nukes' then
		if NukeFifthDamage ~= 0 then
			say('/p \r--Nuke Leaderboard--\rNo.1: '..NukeFirstName..' ('..NukeFirstDamage..')\rNo.2: '..NukeSecondName..' ('..NukeSecondDamage..')\rNo.3: '..NukeThirdName..' ('..NukeThirdDamage..')\rNo.4: '..NukeFourthName..' ('..NukeFourthDamage..')\rNo.5: '..NukeFifthName..' ('..NukeFifthDamage..')')
		elseif NukeFourthDamage ~= 0 then
			say('/p \r--Nuke Leaderboard--\rNo.1: '..NukeFirstName..' ('..NukeFirstDamage..')\rNo.2: '..NukeSecondName..' ('..NukeSecondDamage..')\rNo.3: '..NukeThirdName..' ('..NukeThirdDamage..')\rNo.4: '..NukeFourthName..' ('..NukeFourthDamage..')')
		elseif NukeThirdDamage ~= 0 then
			say('/p \r--Nuke Leaderboard--\rNo.1: '..NukeFirstName..' ('..NukeFirstDamage..')\rNo.2: '..NukeSecondName..' ('..NukeSecondDamage..')\rNo.3: '..NukeThirdName..' ('..NukeThirdDamage..')')
		elseif NukeSecondDamage ~= 0 then
			say('/p \r--Nuke Leaderboard--\rNo.1: '..NukeFirstName..' ('..NukeFirstDamage..')\rNo.2: '..NukeSecondName..' ('..NukeSecondDamage..')')
		elseif NukeFirstDamage ~= 0 then
			say('/p \r--Nuke Leaderboard--\rNo.1: '..NukeFirstName..' ('..NukeFirstDamage..')')
		else
			say('/p \r--Nuke Leaderboard--\rNo data yet')
		end

	elseif addcmd == 'w' or addcmd =='whiff' or addcmd =='whiffs' then
		if WhiffThirdAmount ~= 0 then
			say('/p \r--Whiff Leaderboard--\rNo.1: '..WhiffFirstName..' ('..WhiffFirstAmount..')\rNo.2: '..WhiffSecondName..' ('..WhiffSecondAmount..')\rNo.3: '..WhiffThirdName..' ('..WhiffThirdAmount..')')
		elseif WhiffSecondAmount ~= 0 then
			say('/p \r--Whiff Leaderboard--\rNo.1: '..WhiffFirstName..' ('..WhiffFirstAmount..')\rNo.2: '..WhiffSecondName..' ('..WhiffSecondAmount..')')
		elseif WhiffFirstAmount ~= 0 then
			say('/p \r--Whiff Leaderboard--\rNo.1: '..WhiffFirstName..' ('..WhiffFirstAmount..')')
		else
			say('/p \r--Whiff Leaderboard--\rNo data yet')
		end

	else
		windower.add_to_chat(200,'[Leaderboard] '..('Unknown command. Type \'//em help\' for list of commands.'):color(8)..'')
	end
end)

windower.register_event('incoming text',function(org, modified, mode)

	--print('Mode: '..mode..'   -   '..org..'')

	if org:find('!lb c') and not org:find('Leaderboard started!')then
		if board_flood_timer ~= 0 then
			return
		end
		board_flood_timer = board_flood_delay
		coroutine.sleep(2)
		cmd('lb c')
	elseif org:find('!lb d') and not org:find('Leaderboard started!')then
		if board_flood_timer ~= 0 then
			return
		end
		board_flood_timer = board_flood_delay
		coroutine.sleep(2)
		cmd('lb d')
	elseif org:find('!lb ls') and not org:find('Leaderboard started!')then
		if board_flood_timer ~= 0 then
			return
		end
		board_flood_timer = board_flood_delay
		coroutine.sleep(2)
		cmd('lb ls')
	elseif org:find('!lb hs') and not org:find('Leaderboard started!')then
		if board_flood_timer ~= 0 then
			return
		end
		board_flood_timer = board_flood_delay
		coroutine.sleep(2)
		cmd('lb hs')
	elseif org:find('!lb k') and not org:find('Leaderboard started!')then
		if board_flood_timer ~= 0 then
			return
		end
		board_flood_timer = board_flood_delay
		coroutine.sleep(2)
		cmd('lb k')
	elseif org:find('!lb n') and not org:find('Leaderboard started!')then
		if board_flood_timer ~= 0 then
			return
		end
		board_flood_timer = board_flood_delay
		coroutine.sleep(2)
		cmd('lb n')
	elseif org:find('!lb w') and not org:find('Leaderboard started!')then
		if board_flood_timer ~= 0 then
			return
		end
		board_flood_timer = board_flood_delay
		coroutine.sleep(2)
		cmd('lb w')
	end

	--remove the color formating so we can reprint the names later without it
	org = org:strip_colors()

	--Kills
	if mode == 36 and Run then

		actor_name = org:match('(.*) defeats the')
--print('Mode: '..mode..'   -   ['..actor_name..']   -   '..org..'')
		kills_total = kills_total+1
		local kills = kill[actor_name] or 0
--print('kills_total: '..kills_total..'')
--print('kills: ['..kills..']')
--print('kill[actor_name]: '..kill[actor_name]..'') --attempt to concatenate field '?' (a nil value)
		-- if kill[actor_name] == nil then  ----------------------------------------------------------trying to fix the nil value below
			-- return
		-- else
			-- kill[actor_name] = kills+1  ------------------------------------------------------------------------------------------------------- nil?
		-- end

		kill[actor_name] = kills+1  ------------------------------------------------------------------------------------------------------- nil?
		if kill[actor_name] > KillFirstAmount then
			if actor_name == KillFirstName or KillFirstAmount == 0 then
				--First Place extends their lead (or the first kill)
				KillFirstName = actor_name
				KillFirstAmount = kill[actor_name]
			elseif actor_name == KillSecondName then
				--Second Place moves into First Place
				KillSecondName = KillFirstName
				KillFirstName = actor_name
				KillSecondAmount = KillFirstAmount
				KillFirstAmount = kill[actor_name]
			else
				--Third Place or lower moves into First Place
				KillThirdName = KillSecondName
				KillSecondName = KillFirstName
				KillFirstName = actor_name
				KillThirdAmount = KillSecondAmount
				KillSecondAmount = KillFirstAmount
				KillFirstAmount = kill[actor_name]
			end
		elseif kill[actor_name] > KillSecondAmount then
			if actor_name == KillSecondName or (actor_name ~= KillFirstName and KillSecondAmount == 0) then
				--Second Place updates their best but stays in Second Place (or the second kill)
				KillSecondName = actor_name
				KillSecondAmount = kill[actor_name]
			elseif actor_name ~= KillFirstName then
				--Third Place or lower moves into Second Place
				KillThirdName = KillSecondName
				KillSecondName = actor_name
				KillThirdAmount = KillSecondAmount
				KillSecondAmount = kill[actor_name]
			end
		elseif kill[actor_name] > KillThirdAmount and actor_name ~= KillFirstName and actor_name ~= KillSecondName then
			--Third Place (or Lower) updates their best (or moves into Third Place)
			KillThirdName = actor_name
			KillThirdAmount = kill[actor_name]
		end
		--say('/echo '..actor_name..' made a kill (Running Total: '..kill[actor_name]..' | Total Kills: '..kills_total..')')

	end

	--Deaths
	if mode == 38 and Run then

		actor_name = org:match('(.*) was defeated by')

		deaths_total = deaths_total+1
		local deaths = death[actor_name] or 0

		death[actor_name] = deaths+1
		if death[actor_name] > DeathFirstAmount then
			if actor_name == DeathFirstName or DeathFirstAmount == 0 then
				--First Place extends their lead (or the first death)
				DeathFirstName = actor_name
				DeathFirstAmount = death[actor_name]
			elseif actor_name == DeathSecondName then
				--Second Place moves into First Place
				DeathSecondName = DeathFirstName
				DeathFirstName = actor_name
				DeathSecondAmount = DeathFirstAmount
				DeathFirstAmount = death[actor_name]
			else
				--Third Place or lower moves into First Place
				DeathThirdName = DeathSecondName
				DeathSecondName = DeathFirstName
				DeathFirstName = actor_name
				DeathThirdAmount = DeathSecondAmount
				DeathSecondAmount = DeathFirstAmount
				DeathFirstAmount = death[actor_name]
			end
		elseif death[actor_name] > DeathSecondAmount then
			if actor_name == DeathSecondName or (actor_name ~= DeathFirstName and DeathSecondAmount == 0) then
				--Second Place updates their best but stays in Second Place (or the second death)
				DeathSecondName = actor_name
				DeathSecondAmount = death[actor_name]
			elseif actor_name ~= DeathFirstName then
				--Third Place or lower moves into Second Place
				DeathThirdName = DeathSecondName
				DeathSecondName = actor_name
				DeathThirdAmount = DeathSecondAmount
				DeathSecondAmount = death[actor_name]
			end
		elseif death[actor_name] > DeathThirdAmount and actor_name ~= DeathFirstName and actor_name ~= DeathSecondName then
			--Third Place (or Lower) updates their best (or moves into Third Place)
			DeathThirdName = actor_name
			DeathThirdAmount = death[actor_name]
		end
		--say('/echo '..actor_name..' died (Running Total: '..death[actor_name]..')')

	end

end)

windower.register_event('prerender', function()
	if os.time() > Heartbeat then
		Heartbeat = os.time()
		if board_flood_timer >= 1 then
			board_flood_timer = board_flood_timer - 1
		end
	end
end)

--[[



]]--
