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
    * Neither the name of Emotes nor the names of its contributors may be
	  used to endorse or promote products derived from this software without
	  specific prior written permission.

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
_addon.version = '02.07.23'
_addon.author = 'Key'
_addon.commands = {'emotes','emote','em'}

require 'logger'
config = require('config')

defaults = {}
defaults.pronoun = 'builtin'

settings = config.load(defaults)

local chat = windower.chat.input
local cmd = windower.send_command

windower.register_event('outgoing text',function(original,modified)

	--current character name, race, and target
	if windower.ffxi.get_mob_by_target('me') == nil then
		return
	else
		self_name = windower.ffxi.get_mob_by_target('me').name
		self_race_num = windower.ffxi.get_mob_by_target('me').race
	end
	if windower.ffxi.get_mob_by_target('t') == nil then
		target_name = windower.ffxi.get_mob_by_target('me').name
		target_race = windower.ffxi.get_mob_by_target('me').race
		target_type = windower.ffxi.get_mob_by_target('me').spawn_type
	else
		target_name = windower.ffxi.get_mob_by_target('t').name
		target_race = windower.ffxi.get_mob_by_target('t').race
		target_type = windower.ffxi.get_mob_by_target('t').spawn_type
	end

	--Check what your pronoun is currently set to
	if settings.pronoun == 'nonbinary' then
		hishertheir = 'their'
		himselfherselfthemself = 'themself'
	elseif settings.pronoun == 'male' then
		hishertheir = 'his'
		himselfherselfthemself = 'himself'
	elseif settings.pronoun == 'female' then
		hishertheir = 'her'
		himselfherselfthemself = 'herself'
	else
		if self_race_num == 1 or self_race_num == 3 or self_race_num == 5 or self_race_num == 8 or self_race_num == 31 then
			hishertheir = 'his'
			himselfherselfthemself = 'himself'
		elseif self_race_num == 2 or self_race_num == 4 or self_race_num == 6 or self_race_num == 7 or self_race_num == 29 or self_race_num == 30 then
			hishertheir = 'her'
			himselfherselfthemself = 'herself'
		end
	end

	--reset values to false, then flip them to true depending on what is targeted
	self = false
	player = false
	monster = false
	npc = false
	object = false
	if target_type == 1 or target_type == 9 or (target_type == 13 and target_name ~= self_name) then
		player = true
		--print('player')
	elseif target_type == 13 then
		self = true
		--print('self')
	elseif target_type == 16 then
		monster = true
		--print('monster')
	elseif target_type == 14 or (target_type == 2 and target_race ~= 0) then
		npc = true
		--print('npc')
	elseif target_type == 2 or target_type == 34 then
		object = true
		--print('object')
	end

	--emotes
	if original == '/blame' then
		if self then
			chat('/em blames '..himselfherselfthemself..'.')
		elseif player or npc then
			chat('/em blames '..target_name..'.')
			chat('/point motion')
		elseif monster or object then
			chat('/em blames the '..target_name..'.')
			chat('/point motion')
		end

	elseif original == '/blowkiss' then
		if self then
			chat('/em blows a kiss.')
		elseif player or npc then
			chat('/em blows '..target_name..' a kiss and winks.')
		elseif monster or object then
			chat('/em blows the '..target_name..' a kiss.')
		end

	elseif original == '/boop' then
		if self then
			chat('/em boops '..hishertheir..' own nose.')
		elseif player or npc then
			chat('/em boops '..target_name..' on the nose.')
			chat('/point motion')
		elseif monster or object then
			chat('/em boops the '..target_name..'.')
			chat('/point motion')
		end

	elseif original == '/buttscratch' or original == 'butt' then
		if self then
			chat('/em scratches '..hishertheir..' butt.')
		elseif player or npc then
			chat('/em scratches '..hishertheir..' butt, looking at '..target_name..'.')
			chat('/point motion')
		elseif monster or object then
			chat('/em scratches '..hishertheir..' butt, looking at the '..target_name..'.')
			chat('/point motion')
		end

	elseif original == '/coldone' or original == '/beer' or original == '/soda' then
		if self then
			chat('/em cracks open a cold one.')
		elseif player or npc then
			chat('/em tosses '..target_name..' a cold one.')
			chat('/toss motion')
		elseif monster or object then
			chat('/em chugs a cold one in front of the '..target_name..'.')
		end

	elseif original == '/congratulations' or original == '/congrats' or original == '/grats' then
		if self then
			chat('/em offers '..hishertheir..' congratulations.')
			cmd('input /clap motion;wait 2;input /hurray motion')
		elseif player or npc then
			chat('/em congratulates '..target_name..'.')
			cmd('input /clap motion;wait 2;input /hurray motion')
		elseif monster or object then
			chat('/em congratulates the '..target_name..'.')
			cmd('input /clap motion;wait 2;input /hurray motion')
		end

	elseif original == '/cookie' then
		if self then
			chat('/em munches on a cookie.')
		elseif player or npc then
			chat('/em offers '..target_name..' a cookie.')
		elseif monster or object then
			chat('/em offers the '..target_name..' a cookie.')
		end

	elseif original == '/dab' then
		if self then
			chat('/em quietly dabs to '..himselfherselfthemself..'.')
		elseif player or npc then
			chat('/em dabs on '..target_name..'.')
		elseif monster or object then
			chat('/em quickly dabs at the '..target_name..'.')
		end

	elseif original == '/encourage' then
		if self then
			chat('/em offers '..hishertheir..' encouragement.')
			cmd('input /clap motion;wait 2;input /cheer motion')
		elseif player or npc then
			chat('/em offers '..target_name..' '..hishertheir..' encouragement.')
			cmd('input /clap motion;wait 2;input /cheer motion')
		elseif monster or object then
			chat('/em offers the '..target_name..' '..hishertheir..' encouragement.')
			cmd('input /clap motion;wait 2;input /cheer motion')
		end

	elseif original == '/facepalm' then
		if self then
			chat('/em quietly facepalms to '..himselfherselfthemself..'.')
		elseif player or npc then
			chat('/em looks at '..target_name..' and facepalms.')
		elseif monster or object then
			chat('/em looks at the '..target_name..' and facepalms.')
		end

	elseif original == '/fistbump' or original == '/fbump' or original == '/bump' then
		if self then
			chat('/em leaves '..hishertheir..' fist out for a bump.')
		elseif player or npc then
			chat('/em gives '..target_name..' a fist bump.')
		elseif monster or object then
			chat('/em fist bumps the '..target_name..'.')
		end

	elseif original == '/fistpump' or original == '/fpump' or original == '/pump' then
		if self then
			chat('/em pumps '..hishertheir..' fist with excitement.')
			chat('/think motion')
		elseif player or npc then
			chat('/em gives an excited fist pump for '..target_name..'.')
		elseif monster or object then
			chat('/em fist pumps in front of the '..target_name..'.')
		end

	elseif original == '/flex' then
		if self then
			chat('/em flexes.')
		elseif player or npc then
			chat('/em flexes on '..target_name..'.')
		elseif monster or object then
			chat('/em flexes on the '..target_name..'.')
		end

	elseif original == '/gasp' then
		if self then
			chat('/em gasps.')
			chat('/shocked motion')
		elseif player or npc then
			chat('/em looks at '..target_name..' and gasps.')
			chat('/shocked motion')
		elseif monster or object then
			chat('/em looks at the '..target_name..' and gasps.')
			chat('/shocked motion')
		end

	elseif original == '/grovel' then
		if self then
			chat('/em grovels.')
			chat('/kneel motion')
		elseif player or npc then
			chat('/em grovels in front of '..target_name..'.')
			chat('/kneel motion')
		elseif monster or object then
			chat('/em grovels in front of the '..target_name..'.')
			chat('/kneel motion')
		end

	elseif original == '/handover' or original == '/hand' then
		if self then
			chat('/em looks at something in '..hishertheir..' hand.')
		elseif player or npc then
			chat('/em hands something to '..target_name..'.')
		elseif monster or object then
			chat('/em hands something to the '..target_name..'.')
		end

	elseif original == '/happy' or original == '/glad' then
		if self then
			chat('/em is happy.')
			chat('/joy motion')
		elseif player or npc then
			chat('/em is happy to see '..target_name..'.')
			chat('/joy motion')
		elseif monster or object then
			chat('/em is happy to see the '..target_name..'.')
			chat('/joy motion')
		end

	elseif original == '/highfive' or original == '/hifive' or original == '/hfive' then
		if self then
			chat('/em holds '..hishertheir..' hand up for a high-five.')
		elseif player or npc then
			chat('/em gives '..target_name..' a high-five.')
		elseif monster or object then
			chat('/em high-fives the '..target_name..'.')
		end

	elseif original == '/hug' then
		if self then
			chat('/em spreads '..hishertheir..' arms open wide for a hug.')
		elseif player or npc then
			chat('/em hugs '..target_name..'.')
		elseif monster or object then
			chat('/em hugs the '..target_name..'.')
		end

	elseif original == '/playdead' then
		if self then
			chat('/em plays dead.')
		elseif player or npc then
			chat('/em plays dead in front of '..target_name..'.')
		elseif monster or object then
			chat('/em plays dead in front of the '..target_name..'.')
		end

	elseif original == '/popcorn' then
		if self then
			chat('/em munches on some popcorn and watches.')
		elseif player or npc then
			chat('/em offers '..target_name..' some popcorn.')
		elseif monster or object then
			chat('/em munches on some popcorn, watching the '..target_name..'.')
		end

	elseif original == '/pose' then
		if self then
			chat('/em strikes a pose.')
		elseif player or npc then
			chat('/em strikes a pose for '..target_name..'.')
		elseif monster or object then
			chat('/em strikes a pose for the '..target_name..'.')
		end

	elseif original == '/shakesfist' or original == '/shakefist' or original == '/fist' then
		if self then
			chat('/em shakes '..hishertheir..' fist.')
		elseif player or npc then
			chat('/em shakes '..hishertheir..' fist at '..target_name..'.')
		elseif monster or object then
			chat('/em shakes '..hishertheir..' fist at the '..target_name..'.')
		end

	elseif original == '/shrug' then
		if self then
			chat('/em shrugs.')
		elseif player or npc then
			chat('/em looks at '..target_name..' and shrugs.')
		elseif monster or object then
			chat('/em looks at the '..target_name..' and shrugs.')
		end

	elseif original == '/sing' then
		if self then
			chat('/em sings the song of '..hishertheir..' people.')
		elseif player or npc then
			chat('/em sings the song of '..hishertheir..' people for '..target_name..'.')
		elseif monster or object then
			chat('/em sings the song of '..hishertheir..' people for the '..target_name..'.')
		end

	elseif original == '/squint' then
		if self then
			chat('/em squints.')
		elseif player or npc then
			chat('/em squints at '..target_name..'.')
		elseif monster or object then
			chat('/em squints at the '..target_name..'.')
		end

	elseif original == '/taco' then
		if self then
			chat('/em munches on a tasty taco.')
		elseif player or npc then
			chat('/em offers '..target_name..' a taco.')
		elseif monster or object then
			chat('/em offers the '..target_name..' a taco.')
		end

	elseif original == '/tag' then
		if self then
			chat('/em looks around for someone to tag.')
		elseif player or npc then
			chat('/em tags '..target_name..'.')
			chat('/point motion')
		elseif monster or object then
			chat('/em tags the '..target_name..'.')
			chat('/point motion')
		end

	elseif original == '/thumbsup' then
		if self then
			chat('/em gives a thumbs up.')
		elseif player or npc then
			chat('/em gives '..target_name..' a thumbs up.')
		elseif monster or object then
			chat('/em gives the '..target_name..' a thumbs up.')
		end

	end
end)

windower.register_event('addon command',function(addcmd, arg1, arg2)

	--current character name, only used to print into chat for the pronoun command
	local self_name = windower.ffxi.get_mob_by_target('me').name

	--current list of emotes
	if addcmd == 'list' then
		windower.add_to_chat(200,'[Emotes] '..('Current Emotes:'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- blame'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- blowkiss'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- boop (w/ motion)'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- buttscratch/butt'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- coldone/beer/soda (w/ motion)'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- congratulations/congrats/grats (w/ motion)'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- cookie'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- dab'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- encourage (w/ motion)'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- facepalm'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- fistbump/fbump/bump'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- fistpump/fpump/pump'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- flex'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- gasp (w/ motion)'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- grovel (w/ motion)'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- handover/hand'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- happy/glad'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- hifive/hfive'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- hug'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- playdead'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- popcorn'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- pose'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- shakesfist/shakefist/fist'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- shrug'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- sing'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- squint'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- taco'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- tag (w/ motion)'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('- thumbsup'):color(8)..'')

	--reload the addon (unlisted command)
	elseif addcmd == 'reload' then
        cmd('lua r emotes')
        return

	--list of commands
	elseif addcmd == 'help' then
		windower.add_to_chat(200,'[Emotes] '..('Commands:'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('list - list the current emotes.'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('pronoun - display the current pronoun used.'):color(8)..'')
		windower.add_to_chat(200,'[Emotes] '..('pronoun b/m/f/n - change the current pronoun to [b]uilt-in, [m]ale, [f]emale, or [N]on-binary.'):color(8)..'')

	--change the pronouns used per character or all
	elseif addcmd == 'pronoun' or addcmd == 'pro' then
		if arg1 == 'b' or arg1 == 'builtin' or arg1 == 'game' then
			settings.pronoun = 'builtin'
			if arg2 == 'all' then
				windower.add_to_chat(200,'[Emotes] '..('Pronoun is now set to Built-in for all characters.'):color(8)..'')
				settings:save('all')
			else
				windower.add_to_chat(200,'[Emotes] '..('Pronoun is now set to Built-in for '..self_name..''):color(8)..'')
				settings:save()
			end
		elseif arg1 == 'm' or arg1 == 'male' or arg1 == 'he' or arg1 == 'him' then
			settings.pronoun = 'male'
			if arg2 == 'all' then
				windower.add_to_chat(200,'[Emotes] '..('Pronoun is now set to Male for all characters.'):color(8)..'')
				settings:save('all')
			else
				windower.add_to_chat(200,'[Emotes] '..('Pronoun is now set to Male for '..self_name..''):color(8)..'')
				settings:save()
			end
		elseif arg1 == 'f' or arg1 == 'female' or arg1 == 'she' or arg1 == 'her' then
			settings.pronoun = 'female'
			if arg2 == 'all' then
				windower.add_to_chat(200,'[Emotes] '..('Pronoun is now set to Female for all characters.'):color(8)..'')
				settings:save('all')
			else
				windower.add_to_chat(200,'[Emotes] '..('Pronoun is now set to Female for '..self_name..''):color(8)..'')
				settings:save()
			end
		elseif arg1 == 'n' or arg1 == 'nonbinary' or arg1 == 't' or arg1 == 'they' or arg1 == 'them' or arg1 == 'theythem' then
			settings.pronoun = 'nonbinary'
			if arg2 == 'all' then
				windower.add_to_chat(200,'[Emotes] '..('Pronoun is now set to Non-binary for all characters.'):color(8)..'')
				settings:save('all')
			else
				windower.add_to_chat(200,'[Emotes] '..('Pronoun is now set to Non-binary for '..self_name..''):color(8)..'')
				settings:save()
			end
		else
			if settings.pronoun == 'builtin' then
				windower.add_to_chat(200,'[Emotes] '..('Pronoun is currently set to Built-in for '..self_name..''):color(8)..'')
			elseif settings.pronoun == 'male' then
				windower.add_to_chat(200,'[Emotes] '..('Pronoun is currently set to Male for '..self_name..''):color(8)..'')
			elseif settings.pronoun == 'female' then
				windower.add_to_chat(200,'[Emotes] '..('Pronoun is currently set to Female for '..self_name..''):color(8)..'')
			elseif settings.pronoun == 'nonbinary' then
				windower.add_to_chat(200,'[Emotes] '..('Pronoun is currently set to Non-binary for '..self_name..''):color(8)..'')
			end
		end

	elseif addcmd == 'test' then
		if self then
			chat('/echo [SELF]')
		elseif player then
			chat('/echo [PLAYER]')
		elseif npc then
			chat('/echo [NPC]')
		elseif monster then
			chat('/echo [MONSTER]')
		elseif object then
			chat('/echo [OBJECT]')
		else
			chat('/echo [NO TARGET]')
		end

	--unknown command
	else
		windower.add_to_chat(200,'[Emotes] '..('Unknown command. Type \'//em help\' for list of commands.'):color(8)..'')

	end
end)

--[[
Game emotes with motions:
amazed
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
nod (same as yes)
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
wave (same as farewell and goodbye)
welcome
yes (same as nod)

]]
