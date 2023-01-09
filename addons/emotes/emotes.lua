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
    * Neither the name of Emotes nor the
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

_addon.name = 'Emotes'
_addon.version = '01.08.23'
_addon.author = 'Key'
_addon.commands = {'emotes','emote','em'}

-------------------
--Gender Override--
local gender = '' --m/f/n (n will use they/them, leave blank to use games builtin gender for characters)
-------------------



local chat = windower.chat.input
local cmd = windower.send_command
function log(...) windower.add_to_chat(207,...) end

windower.register_event('addon command',function(arg)
	local emote_target = windower.ffxi.get_mob_by_target('t') or windower.ffxi.get_mob_by_target('me')
	--(we use the 'me' in there in case 't' is nil)
	local self_name = windower.ffxi.get_mob_by_target('me').name

		if gender == 'n' then
			hishertheir = 'their'
			himselfherselfthemself = 'themself'
		elseif gender == 'm' or (emote_target.race == 1 or emote_target.race == 3 or emote_target.race == 5 or emote_target.race == 8 or emote_target.race == 31) then
			hishertheir = 'his'
			himselfherselfthemself = 'himself'
		elseif gender == 'f' or (emote_target.race == 2 or emote_target.race == 4 or emote_target.race == 6 or emote_target.race == 7 or emote_target.race == 29 or emote_target.race == 30) then
			hishertheir = 'her'
			himselfherselfthemself = 'herself'
		end
		self = false
		player = false
		monster = false
		npc_character = false
		npc_object = false
		if emote_target.spawn_type == 1 or emote_target.spawn_type == 9 or (emote_target.spawn_type == 13 and emote_target.name ~= self_name) then
			player = true
		elseif emote_target.spawn_type == 13 then
			self = true
		elseif emote_target.spawn_type == 16 then
			monster = true
		elseif emote_target.spawn_type == 14 or (emote_target.spawn_type == 2 and emote_target.race ~= 0) then
			npc_character = true
		elseif emote_target.spawn_type == 2 or emote_target.spawn_type == 34 then
			npc_object = true
		end




	if arg == 'list' then
		log('Emotes: List of current emotes')
		log('Emotes: - blowkiss')
		log('Emotes: - boop (w/ motion)')
		log('Emotes: - congratulations/congrats/grats (w/ motion)')
		log('Emotes: - cookie')
		log('Emotes: - dab')
		log('Emotes: - facepalm')
		log('Emotes: - fistbump')
		log('Emotes: - flex')
		log('Emotes: - grovel (w/ motion)')
		log('Emotes: - handover/hand')
		log('Emotes: - highfive/hfive')
		log('Emotes: - playdead')
		log('Emotes: - pose')
		log('Emotes: - squint')
		log('Emotes: - tag (w/ motion)')
		log('Emotes: - thumbsup')

	elseif arg == 'blowkiss' then
		if self then
			chat('/em blows a kiss.')
		elseif player or npc_character then
			chat('/em blows '..emote_target.name..' a kiss and winks.')
		elseif monster or npc_object then
			chat('/em blows the '..emote_target.name..' a kiss.')
		end

	elseif arg == 'boop' then
		if self then
			chat('/em boops '..hishertheir..' own nose.')
		elseif player or npc_character then
			chat('/em boops '..emote_target.name..' on the nose.')
			chat('/point motion')
		elseif monster or npc_object then
			chat('/em boops the '..emote_target.name..'.')
			chat('/point motion')
		end

	elseif arg == 'congratulations' or arg == 'congrats' or arg == 'grats' then
		if self then
			chat('/em offers '..hishertheir..' congratulations.')
			cmd('input /clap motion;wait 2;input cheer motion')
		elseif player or npc_character then
			chat('/em congratulates '..emote_target.name..'.')
			cmd('input /clap motion;wait 2;input /cheer motion')
		elseif monster or npc_object then
			chat('/em congratulates the '..emote_target.name..'.')
			cmd('input /clap motion;wait 2;input /cheer motion')
		end

	elseif arg == 'cookie' then
		if self then
			chat('/em munches on a cookie.')
		elseif player or npc_character then
			chat('/em offers '..emote_target.name..' a cookie.')
		elseif monster or npc_object then
			chat('/em offers the '..emote_target.name..' a cookie.')
		end

	elseif arg == 'dab' then
		if self then
			chat('/em quietly dabs to '..himselfherselfthemself..'.')
		elseif player or npc_character then
			chat('/em dabs on '..emote_target.name..'.')
		elseif monster or npc_object then
			chat('/em quickly dabs at the '..emote_target.name..'.')
		end

	elseif arg == 'facepalm' then
		if self then
			chat('/em quietly facepalms to '..himselfherselfthemself..'.')
		elseif player or npc_character then
			chat('/em looks at '..emote_target.name..' and facepalms.')
		elseif monster or npc_object then
			chat('/em looks at the '..emote_target.name..' and facepalms.')
		end

	elseif arg == 'fistbump' then
		if self then
			chat('/em leaves '..hishertheir..' fist out for a bump.')
		elseif player or npc_character then
			chat('/em gives '..emote_target.name..' a fistbump.')
		elseif monster or npc_object then
			chat('/em fistbumps the '..emote_target.name..'.')
		end

	elseif arg == 'flex' then
		if self then
			chat('/em flexes.')
		elseif player or npc_character then
			chat('/em flexes on '..emote_target.name..'.')
		elseif monster or npc_object then
			chat('/em flexes on the '..emote_target.name..'.')
		end

	elseif arg == 'grovel' then
		if self then
			chat('/em grovels.')
			chat('/kneel motion')
		elseif player or npc_character then
			chat('/em grovels in front of '..emote_target.name..'.')
			chat('/kneel motion')
		elseif monster or npc_object then
			chat('/em grovels in front of the '..emote_target.name..'.')
			chat('/kneel motion')
		end

	elseif arg == 'handover' or arg == 'hand' then
		if self then
			chat('/em looks at something in '..hishertheir..' hand.')
		elseif player or npc_character then
			chat('/em hands something to '..emote_target.name..'.')
		elseif monster or npc_object then
			chat('/em hands something to the '..emote_target.name..'.')
		end

	elseif arg == 'highfive' or arg == 'hfive' then
		if self then
			chat('/em holds '..hishertheir..' hand up for a high-five.')
		elseif player or npc_character then
			chat('/em gives '..emote_target.name..' a high-five.')
		elseif monster or npc_object then
			chat('/em high-fives the '..emote_target.name..'.')
		end

	elseif arg == 'playdead' then
		if self then
			chat('/em plays dead.')
		elseif player or npc_character then
			chat('/em plays dead in front of '..emote_target.name..'.')
		elseif monster or npc_object then
			chat('/em plays dead in front of the '..emote_target.name..'.')
		end

	elseif arg == 'pose' then
		if self then
			chat('/em strikes a pose.')
		elseif player or npc_character then
			chat('/em strikes a pose for '..emote_target.name..'.')
		elseif monster or npc_object then
			chat('/em strikes a pose for the '..emote_target.name..'.')
		end

	elseif arg == 'squint' then
		if self then
			chat('/em squints.')
		elseif player or npc_character then
			chat('/em squints at '..emote_target.name..'.')
		elseif monster or npc_object then
			chat('/em squints at the '..emote_target.name..'.')
		end

	elseif arg == 'tag' then
		if self then
			chat('/em looks around for someone to tag.')
		elseif player or npc_character then
			chat('/em tags '..emote_target.name..'.')
			chat('/point motion')
		elseif monster or npc_object then
			chat('/em tags the '..emote_target.name..'.')
			chat('/point motion')
		end

	elseif arg == 'thumbsup' then
		if self then
			chat('/em gives a thumbs up.')
		elseif player or npc_character then
			chat('/em gives '..emote_target.name..' a thumbs up.')
		elseif monster or npc_object then
			chat('/em gives the '..emote_target.name..' a thumbs up.')
		end




	elseif arg == 'test' then
		log('['..emote_target.name..'] [Self_name: '..self_name..'] - [spawn_type = '..emote_target.spawn_type..'] [race = '..emote_target.race..' ]')
		if self then
			log('[self]')
		end
		if player then
			log('[player]')
		end
		if monster then
			log('[monster]')
		end
		if npc_character then
			log('[npc_character]')
		end
		if npc_object then
			log('[npc_object]')
		end
		log('--------------------------')

	else
		log('Emotes: Unrecognized emote. type \'//em list\' for current emotes.')
	end

end)

--[[
Game emotes with motions:
angry
blush
bow
cheer
clap (same as praise)
comfort
cry
dance1
dance2
dance3
dance4
disgusted
doubt (same as poke but slightly faster)
farewell (same as goodbye and wave)
fume
goodbye (same as farewell and wave)
huh
hurray
joy
jump
kneel
laugh
no
nod (same as yes
panic
point
poke (same as doubt but slightly slower)
praise (same as clap)
psych
salute
shocked (same as surprised)
sigh (same as sulk)
stagger
sulk (same as sigh)
surprised (same as shocked)
think
toss
upset
wave (same as farell and goodbye)
welcome
yes (same as nod)


]]
