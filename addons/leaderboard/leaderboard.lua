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
_addon.version = '01.08.23'
_addon.author = 'Key'
_addon.commands = {'leaderboard','lb'}


local update_flood_delay = 20 --delay in seconds before the update can be called again

local weaponskills = require('resources').weapon_skills
local miss = {}
local savage = {}
local fudo = {}
local cmd = windower.send_command
local say = windower.chat.input
function log(...) windower.add_to_chat(207,...) end

local Heartbeat = 0
local update_flood_timer = 0
local Run = false

MostMisses = 0
MostMissesName = "None"
MostSavages = 0
MostSavagesName = "None"
MostFudos = 0
MostFudoName = "None"

FirstName = ""
SecondName = ""
ThirdName = ""
FourthName = ""
FifthName = ""
LowName = "None"
FirstDamage = 0
SecondDamage = 0
ThirdDamage = 0
FourthDamage = 0
FifthDamage = 0
LowDamage = 0
FirstWS = ""
SecondWS = ""
ThirdWS = ""
FourthWS = ""
FifthWS = ""
LowWS = ""
FirstTarget = ""
SecondTarget = ""
ThirdTarget = ""
FourthTarget = ""
FifthTarget = ""
LowTarget = ""

function get_actor(id)
    local actor = windower.ffxi.get_mob_by_id(id)
    if not actor.in_alliance and not actor.in_party then
		return false
    else
        return actor
    end
end

windower.register_event('action',function(act)

	if act.category == 3 and not (act.param == 66 or act.param == 67 or act.param == 68 or act.param == 77 or act.param == 137 or act.param == 260 or act.param == 293 or act.param == 46 or act.param == 285) and Run then
	--WSs (specifically excluding Jumps, Shield Bash, Bounty Shot, classified as WSs for some reason)
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

		if data.ws == 'Atonement' or data.ws == 'Flat Blade' or data.ws == 'Tachi: Hobaku' or data.ws == 'Shoulder Tackle' or data.ws == 'Leg Sweep' or data.ws == 'Mykr' or data.ws == 'Starlight' or data.ws == 'Moonlight' or data.ws == 'Energy Drain' and act.targets[1].actions[1].message == 188 then
			return
		-- elseif data.ws == 'Savage Blade' then
			-- local savages = savage[data.actor_name] or 0
			-- savage[data.actor_name] = savages+1
			-- if savage[data.actor_name] > MostSavages then
				-- MostSavages = savage[data.actor_name]
				-- MostSavagesName = data.actor_name
			-- end
		-- elseif data.ws == 'Tachi: Fudo' then
			-- local fudos = fudo[data.actor_name] or 0
			-- fudo[data.actor_name] = fudos+1
			-- if fudo[data.actor_name] > MostFudo then
				-- MostFudos = fudo[data.actor_name]
				-- MostFudosName = data.actor_name
			-- end
		end

		if data.damage == 0 then
			local misses = miss[data.actor_name] or 0
			miss[data.actor_name] = misses+1
			if miss[data.actor_name] == 10 then
				say:schedule(1,'/p '..data.actor_name..' whiffs '..data.ws..' yet again and has hit the whiff chat spam wall.')
			elseif miss[data.actor_name] > 5 and misses < 10 then
				say:schedule(1,'/p '..data.actor_name..' whiffs '..data.ws..' yet again...')
			elseif miss[data.actor_name] == 5 then
				say:schedule(1,'/p '..data.actor_name..' whiffs '..data.ws..' again and is halfway to the whiff chat spam wall.')
			elseif miss[data.actor_name] > 1 and miss[data.actor_name] < 5 then
				say:schedule(1,'/p '..data.actor_name..' whiffs '..data.ws..' again... ')
			elseif miss[data.actor_name] == 1 then
				say:schedule(1,'/p '..data.actor_name..' whiffs '..data.ws..'...')
			end
			if miss[data.actor_name] > MostMisses then
				if MostMisses > 1 and data.actor_name ~= MostMissesName then
					MostMisses = miss[data.actor_name]
					MostMissesName = data.actor_name
					say:schedule(3,'/p New Whiff Leader! '..MostMissesName..' with '..MostMisses..' whiffs.')
				else
					MostMisses = miss[data.actor_name]
					MostMissesName = data.actor_name				
				end
			end
		elseif data.damage >= 1 and data.damage <= 8 then
			return
		else

			if LowDamage == 0 or data.damage < LowDamage then
				if FifthDamage ~= 0 then
					coroutine.sleep(1)
					say('/p New LOW Score! '..data.actor_name..' with a '..data.damage..' '..data.ws..' on '..data.target_name..'')
				end
				LowName = data.actor_name
				LowWS = data.ws
				LowDamage = data.damage
				LowTarget = data.target_name
			end

			if data.damage > FirstDamage then
				if data.actor_name == FirstName or FirstDamage == 0 then 
					--First Place extends their lead (or the first ws)
					FirstName = data.actor_name
					FirstDamage = data.damage
					FirstWS = data.ws
					FirstTarget = data.target_name
				elseif data.actor_name == SecondName then
					--Second Place moves into First Place
					SecondName = FirstName
					FirstName = data.actor_name
					SecondDamage = FirstDamage
					FirstDamage = data.damage
					SecondWS = FirstWS
					FirstWS = data.ws
					SecondTarget = FirstTarget
					FirstTarget = data.target_name
				elseif data.actor_name == ThirdName then
					--Third Place moves into First Place
					ThirdName = SecondName
					SecondName = FirstName
					FirstName = data.actor_name
					ThirdDamage = SecondDamage
					SecondDamage = FirstDamage
					FirstDamage = data.damage
					ThirdWS = SecondWS
					SecondWS = FirstWS
					FirstWS = data.ws
					ThirdTarget = SecondTarget
					SecondTarget = FirstTarget
					FirstTarget = data.target_name
				elseif data.actor_name == FourthName then
					--Fourth Place moves into First Place
					FourthName = ThirdName
					ThirdName = SecondName
					SecondName = FirstName
					FirstName = data.actor_name
					FourthDamage = ThirdDamage
					ThirdDamage = SecondDamage
					SecondDamage = FirstDamage
					FirstDamage = data.damage
					FourthWS = ThirdWS
					ThirdWS = SecondWS
					SecondWS = FirstWS
					FirstWS = data.ws
					FourthTarget = ThirdTarget
					ThirdTarget = SecondTarget
					SecondTarget = FirstTarget
					FirstTarget = data.target_name
				else
					--Fifth Place or somebody not already on the board moves into First Place
					FifthName = FourthName
					FourthName = ThirdName
					ThirdName = SecondName
					SecondName = FirstName
					FirstName = data.actor_name
					FifthDamage = FourthDamage
					FourthDamage = ThirdDamage
					ThirdDamage = SecondDamage
					SecondDamage = FirstDamage
					FirstDamage = data.damage
					FifthWS = FourthWS
					FourthWS = ThirdWS
					ThirdWS = SecondWS
					SecondWS = FirstWS
					FirstWS = data.ws
					FifthTarget = FourthTarget
					FourthTarget = ThirdTarget
					ThirdTarget = SecondTarget
					SecondTarget = FirstTarget
					FirstTarget = data.target_name
				end
				coroutine.sleep(1)
				say('/p New HIGH Score! '..FirstName..' with a '..FirstDamage..' '..FirstWS..' on '..FirstTarget..'')
			elseif data.damage > SecondDamage then
				if data.actor_name == SecondName or (data.actor_name ~= FirstName and SecondDamage == 0) then
					--Second Place updates their best but stays in Second Place (or the second ws)
					SecondName = data.actor_name
					SecondDamage = data.damage
					SecondWS = data.ws
					SecondTarget = data.target_name
				elseif data.actor_name == ThirdName then
					--Third Place moves into Second Place
					ThirdName = SecondName
					SecondName = data.actor_name
					ThirdDamage = SecondDamage
					SecondDamage = data.damage
					ThirdWS = SecondWS
					SecondWS = data.ws
					ThirdTarget = SecondTarget
					SecondTarget = data.target_name
					coroutine.sleep(1)
					say('/p Leaderboard update: '..SecondName..' moves into the No.2 slot with a '..SecondDamage..' '..SecondWS..' on '..SecondTarget..'')
				elseif data.actor_name == FourthName then
					--Fourth Place moves into Second Place
					FourthName = ThirdName
					ThirdName = SecondName
					SecondName = data.actor_name
					FourthDamage = ThirdDamage
					ThirdDamage = SecondDamage
					SecondDamage = data.damage
					FourthWS = ThirdWS
					ThirdWS = SecondWS
					SecondWS = data.ws
					FourthTarget = ThirdTarget
					ThirdTarget = SecondTarget
					SecondTarget = data.target_name
					coroutine.sleep(1)
					say('/p Leaderboard update: '..SecondName..' moves into the No.2 slot with a '..SecondDamage..' '..SecondWS..' on '..SecondTarget..'')
				elseif data.actor_name ~= FirstName then
					--Fifth Place or somebody not already on the board moves into Second Place
					FifthName = FourthName
					FourthName = ThirdName
					ThirdName = SecondName
					SecondName = data.actor_name
					FifthDamage = FourthDamage
					FourthDamage = ThirdDamage
					ThirdDamage = SecondDamage
					SecondDamage = data.damage
					FifthWS = FourthWS
					FourthWS = ThirdWS
					ThirdWS = SecondWS
					SecondWS = data.ws
					FifthTarget  = FourthTarget
					FourthTarget = ThirdTarget
					ThirdTarget = SecondTarget
					SecondTarget = data.target_name
					coroutine.sleep(1)
					say('/p Leaderboard update: '..SecondName..' moves into the No.2 slot with a '..SecondDamage..' '..SecondWS..' on '..SecondTarget..'')
				end
			elseif data.damage > ThirdDamage then
				if data.actor_name == ThirdName or (data.actor_name ~= FirstName and data.actor_name ~= SecondName and ThirdDamage == 0) then
					--Third Place updates their best but stays in Third Place (or the third ws)
					ThirdName = data.actor_name
					ThirdDamage = data.damage
					ThirdWS = data.ws
					ThirdTarget = data.target_name
				elseif data.actor_name == FourthName then
					--Fourth Place moves into Third Place
					FourthName = ThirdName
					ThirdName = data.actor_name
					FourthDamage = ThirdDamage
					ThirdDamage = data.damage
					FourthWS = ThirdWS
					ThirdWS = data.ws
					FourthTarget = ThirdTarget
					ThirdTarget = data.target_name
					say('/p Leaderboard update: '..ThirdName..' moves into the No.3 slot with a '..ThirdDamage..' '..ThirdWS..' on '..ThirdTarget..'')
				elseif data.actor_name ~= FirstName and data.actor_name ~= SecondName then
					--Fifth Place or somebody not already on the board moves into Third Place
					FifthName = FourthName
					FourthName = ThirdName
					ThirdName = data.actor_name
					FifthDamage = FourthDamage
					FourthDamage = ThirdDamage
					ThirdDamage = data.damage
					FifthWS = FourthWS
					FourthWS = ThirdWS
					ThirdWS = data.ws
					FifthTarget = FourthTarget
					FourthTarget = ThirdTarget
					ThirdTarget = data.target_name
					coroutine.sleep(1)
					say('/p Leaderboard update: '..ThirdName..' moves into the No.3 slot with a '..ThirdDamage..' '..ThirdWS..' on '..ThirdTarget..'')
				end
			elseif data.damage > FourthDamage then
				if data.actor_name == FourthName or (data.actor_name ~= FirstName and data.actor_name ~= SecondName and data.actor_name ~= ThirdName and FourthDamage == 0) then
					--Fourth Place updates their best but stays in Fourth Place (or the fourth ws)
					FourthName = data.actor_name
					FourthDamage = data.damage
					FourthWS = data.ws
					FourthTarget = data.target_name
				elseif data.actor_name ~= FirstName and data.actor_name ~= SecondName and data.actor_name ~= ThirdName then
					--Fifth Place or somebody not already on the board moves into Fourth Place
					FifthName = FourthName
					FourthName = data.actor_name
					FifthDamage = FourthDamage
					FourthDamage = data.damage
					FifthWS = FourthWS
					FourthWS = data.ws
					FifthTarget = FourthTarget
					FourthTarget = data.target_name
					coroutine.sleep(1)
					say('/p Leaderboard update: '..FourthName..' moves into the No.4 slot with a '..FourthDamage..' '..FourthWS..' on '..FourthTarget..'')
				end
			elseif data.damage > FifthDamage then
				--Fifth Place or somebody not already on the board moves into Fifth Place
				if data.actor_name == FifthName or (data.actor_name ~= FirstName and data.actor_name ~= SecondName and data.actor_name ~= ThirdName and data.actor_name ~= FourthName and FifthDamage == 0) then
					--Fifth Place updates their best but stays in Fifth Place (or the fifth ws)
					FifthName = data.actor_name
					FifthDamage = data.damage
					FifthWS = data.ws
					FifthTarget = data.target_name
				elseif data.actor_name ~= FirstName and data.actor_name ~= SecondName and data.actor_name ~= ThirdName and data.actor_name ~= FourthName then
					--Somebody not already on the board moves into Fourth Place
					FifthName = data.actor_name
					FifthDamage = data.damage
					FifthWS = data.ws
					FifthTarget = data.target_name
					coroutine.sleep(1)
					say('/p Leaderboard update: '..FifthName..' moves into the No.5 slot with a '..FifthDamage..' '..FifthWS..' on '..FifthTarget..'')
				end
			end

		end

	end
end)

windower.register_event('addon command',function(arg)

	if arg == 'r' then
        cmd('lua r leaderboard')
        return
    elseif arg == 'start' then
		Run = true
		say('/p Leaderboard started! (anyone can type \'!update\' into chat for current leaderboard)')
		coroutine.sleep(1)
		log('Leaderboard: Beware - This addon uses party chat heavily.')
		log('Leaderboard: //lb pause, update, or end')
    elseif arg == 'pause' then
		if Run == true then
			Run = false
			say('/p Leaderboard paused.')
			log('Leaderboard: \'//lb pause\' again to unpause.')
		else
			Run = true
			say('/p Leaderboard unpaused.')
		end
	elseif arg == 'update' then
		if update_flood_timer ~= 0 then
			return
		end
		update_flood_timer = update_flood_delay
		if FifthDamage ~= 0 then
			say('/p \r--High Score Leaderboard--\rNo.1: '..FirstName..' ('..FirstDamage..')\rNo.2: '..SecondName..' ('..SecondDamage..')\rNo.3: '..ThirdName..' ('..ThirdDamage..')\rNo.4: '..FourthName..' ('..FourthDamage..')\rNo.5: '..FifthName..' ('..FifthDamage..')')
		elseif FourthDamage ~= 0 then
			say('/p \r--High Score Leaderboard--\rNo.1: '..FirstName..' ('..FirstDamage..')\rNo.2: '..SecondName..' ('..SecondDamage..')\rNo.3: '..ThirdName..' ('..ThirdDamage..')\rNo.4: '..FourthName..' ('..FourthDamage..')')
		elseif ThirdDamage ~= 0 then
			say('/p \r--High Score Leaderboard--\rNo.1: '..FirstName..' ('..FirstDamage..')\rNo.2: '..SecondName..' ('..SecondDamage..')\rNo.3: '..ThirdName..' ('..ThirdDamage..')')
		elseif SecondDamage ~= 0 then
			say('/p \r--High Score Leaderboard--\rNo.1: '..FirstName..' ('..FirstDamage..')\rNo.2: '..SecondName..' ('..SecondDamage..')')
		elseif FirstDamage ~= 0 then
			say('/p \r--High Score Leaderboard--\rNo.1: '..FirstName..' ('..FirstDamage..')')
		else
			say('/p \r--High Score Leaderboard--\rNo data yet')
		end
		--coroutine.sleep(2)
		--say('/p \r--Other Leaderboard--\rWhiff Leader: '..MostMissesName..' ('..MostMisses..')\rLowest Damage: '..LowName..' ('..LowDamage..')')
		--say('/p \r--Other Leaderboard--\rWhiff Leader: '..MostMissesName..' ('..MostMisses..')\rLowest Damage: '..LowName..' ('..LowDamage..')\rSavages: '..MostSavagesName..' ('..MostSavages..')')
    elseif arg == 'end' then
		say('/p \r--Leaderboard Final Results--')
		if FifthDamage ~= 0 then
			coroutine.sleep(2)
			say('/p No.5: '..FifthName..' with a '..FifthWS..' for '..FifthDamage..' on '..FifthTarget..'.')
		end
		if FourthDamage ~= 0 then
			coroutine.sleep(2)
			say('/p No.4: '..FourthName..' with a '..FourthWS..' for '..FourthDamage..' on '..FourthTarget..'.')
		end
		if ThirdDamage ~= 0 then
			coroutine.sleep(2)
			say('/p No.3: '..ThirdName..' with a '..ThirdWS..' for '..ThirdDamage..' on '..ThirdTarget..'.')
		end
		if SecondDamage ~= 0 then
			coroutine.sleep(2)
			say('/p No.2: '..SecondName..' with a '..SecondWS..' for '..SecondDamage..' on '..SecondTarget..'.')
		end
		if FirstDamage ~= 0 then
			coroutine.sleep(2)
			say('/p No.1: '..FirstName..' with a '..FirstWS..' for '..FirstDamage..' on '..FirstTarget..'.')
		end
		if LowDamage > 0 then
			coroutine.sleep(2)
			say('/p '..LowName..' gets a Gold Star sticker for a '..LowDamage..' damage '..LowWS..' on '..LowTarget..'.')
		end
		if MostMisses > 0 then
			coroutine.sleep(2)
			if MostMisses == 1 then
				say('/p '..MostMissesName..' gets the OnlyFans Award for '..MostMisses..' whiff.')
			else
				say('/p '..MostMissesName..' gets the OnlyFans Award for '..MostMisses..' whiffs.')
			end
		end
		-- if MostSavages > 0 then
			-- coroutine.sleep(2)
			-- say('/p '..MostSavagesName..' gets the Straight Savage Award for '..MostSavages..' Savage Blades.')
		-- end
		cmd('lua r leaderboard')
	else
		log('Leaderboard: Commands')
		log('Leaderboard: start - start tracking')
		log('Leaderboard: pause - pause/unpause tracking')
		log('Leaderboard: update - print the current leaderboard to party chat')
		log('Leaderboard: end - end tracking, print the leaderboard to party chat, and reload the addon')
	end
end)

-- windower.register_event('chat message', function(message,sender)
	-- if message:find('Naga Raja') then
		-- say('/echo Testy: '..sender..'')
	-- end
-- end)


windower.register_event('incoming text',function(org)
	if org:find('!update') and not org:find('Leaderboard started!')then
		coroutine.sleep(2)
		cmd('lb update')
	end
	
end)

windower.register_event('prerender', function()
	if os.time() > Heartbeat then
		Heartbeat = os.time()
		if update_flood_timer >= 1 then
			update_flood_timer = update_flood_timer - 1
		end
	end
end)
