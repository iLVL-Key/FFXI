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
_addon.version = '01.12.23'
_addon.author = 'Key'
_addon.commands = {'emotes','emote','em'}

require 'logger'


-------------------
--Gender Override--
local gender = '' --m/f/n (n will use they/them, leave blank to use games builtin gender for characters)
-------------------


local chat = windower.chat.input
local cmd = windower.send_command
function log(...) windower.add_to_chat(207,...) end

windower.register_event('addon command',function(addcmd)
	local emote_target = windower.ffxi.get_mob_by_target('t') or windower.ffxi.get_mob_by_target('me')
	--we use the 'me' in there in case 't' is nil(no target)
	local self_race_num = windower.ffxi.get_mob_by_target('me').race
	local self_name = windower.ffxi.get_mob_by_target('me').name

		if gender == 'n' then
			hishertheir = 'their'
			himselfherselfthemself = 'themself'
		elseif gender == 'm' or (self_race_num == 1 or self_race_num == 3 or self_race_num == 5 or self_race_num == 8 or self_race_num == 31) then
			hishertheir = 'his'
			himselfherselfthemself = 'himself'
		elseif gender == 'f' or (self_race_num == 2 or self_race_num == 4 or self_race_num == 6 or self_race_num == 7 or self_race_num == 29 or self_race_num == 30) then
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
		if self_race_num == 1 or self_race_num == 2 then
			self_race = 'Hume'
		elseif self_race_num == 3 or self_race_num == 4 then
			self_race = 'Elvaan'
		elseif self_race_num == 5 or self_race_num == 6 then
			self_race = 'Tarutaru'
		elseif self_race_num == 7 then
			self_race = 'Mithra'
		elseif self_race_num == 8 then
			self_race = 'Galka'
		end



	if addcmd == 'list' then
		log('[Emotes] List of current emotes')
		log('[Emotes] - blowkiss')
		log('[Emotes] - boop (w/ motion)')
		log('[Emotes] - coldone/beer/soda (w/ motion)')
		log('[Emotes] - congratulations/congrats/grats (w/ motion)')
		log('[Emotes] - cookie')
		log('[Emotes] - dab')
		log('[Emotes] - facepalm')
		log('[Emotes] - fistbump/fbump/bump')
		log('[Emotes] - flex')
		log('[Emotes] - gag (w/ motion)')
		log('[Emotes] - grovel (w/ motion)')
		log('[Emotes] - handover/hand')
		log('[Emotes] - highfive/hfive')
		log('[Emotes] - playdead')
		log('[Emotes] - pose')
		log('[Emotes] - sing')
		log('[Emotes] - squint')
		log('[Emotes] - taco')
		log('[Emotes] - tag (w/ motion)')
		log('[Emotes] - thumbsup')
		log('[Emotes] - whistle')

	elseif addcmd == 'blowkiss' then
		if self then
			chat('/em blows a kiss.')
		elseif player or npc_character then
			chat('/em blows '..emote_target.name..' a kiss and winks.')
		elseif monster or npc_object then
			chat('/em blows the '..emote_target.name..' a kiss.')
		end

	elseif addcmd == 'boop' then
		if self then
			chat('/em boops '..hishertheir..' own nose.')
		elseif player or npc_character then
			chat('/em boops '..emote_target.name..' on the nose.')
			chat('/point motion')
		elseif monster or npc_object then
			chat('/em boops the '..emote_target.name..'.')
			chat('/point motion')
		end

	elseif addcmd == 'coldone' or addcmd == 'beer' or addcmd == 'soda' then
		if self then
			chat('/em cracks open a cold one.')
		elseif player or npc_character then
			chat('/em tosses '..emote_target.name..' a cold one.')
			chat('/toss motion')
		elseif monster or npc_object then
			chat('/em chugs a cold one in front of the '..emote_target.name..'.')
		end

	elseif addcmd == 'congratulations' or addcmd == 'congrats' or addcmd == 'grats' then
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

	elseif addcmd == 'cookie' then
		if self then
			chat('/em munches on a cookie.')
		elseif player or npc_character then
			chat('/em offers '..emote_target.name..' a cookie.')
		elseif monster or npc_object then
			chat('/em offers the '..emote_target.name..' a cookie.')
		end

	elseif addcmd == 'dab' then
		if self then
			chat('/em quietly dabs to '..himselfherselfthemself..'.')
		elseif player or npc_character then
			chat('/em dabs on '..emote_target.name..'.')
		elseif monster or npc_object then
			chat('/em quickly dabs at the '..emote_target.name..'.')
		end

	elseif addcmd == 'facepalm' then
		if self then
			chat('/em quietly facepalms to '..himselfherselfthemself..'.')
		elseif player or npc_character then
			chat('/em looks at '..emote_target.name..' and facepalms.')
		elseif monster or npc_object then
			chat('/em looks at the '..emote_target.name..' and facepalms.')
		end

	elseif addcmd == 'fistbump' or addcmd == 'fbump' or addcmd == 'bump' then
		if self then
			chat('/em leaves '..hishertheir..' fist out for a bump.')
		elseif player or npc_character then
			chat('/em gives '..emote_target.name..' a fistbump.')
		elseif monster or npc_object then
			chat('/em fistbumps the '..emote_target.name..'.')
		end

	elseif addcmd == 'flex' then
		if self then
			chat('/em flexes.')
		elseif player or npc_character then
			chat('/em flexes on '..emote_target.name..'.')
		elseif monster or npc_object then
			chat('/em flexes on the '..emote_target.name..'.')
		end

	elseif addcmd == 'gag' then
		if self then
			chat('/em gags and '..hishertheir..' face turns a sickly shade of green.')
			chat('/think motion')
		elseif player or npc_character then
			chat('/em looks at '..emote_target.name..' and '..hishertheir..' face turns a sickly shade of green.')
			chat('/think motion')
		elseif monster or npc_object then
			chat('/em looks at the '..emote_target.name..' and '..hishertheir..' face turns a sickly shade of green.')
			chat('/think motion')
		end

	elseif addcmd == 'grovel' then
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

	elseif addcmd == 'handover' or addcmd == 'hand' then
		if self then
			chat('/em looks at something in '..hishertheir..' hand.')
		elseif player or npc_character then
			chat('/em hands something to '..emote_target.name..'.')
		elseif monster or npc_object then
			chat('/em hands something to the '..emote_target.name..'.')
		end

	elseif addcmd == 'highfive' or addcmd == 'hfive' then
		if self then
			chat('/em holds '..hishertheir..' hand up for a high-five.')
		elseif player or npc_character then
			chat('/em gives '..emote_target.name..' a high-five.')
		elseif monster or npc_object then
			chat('/em high-fives the '..emote_target.name..'.')
		end

	elseif addcmd == 'playdead' then
		if self then
			chat('/em plays dead.')
		elseif player or npc_character then
			chat('/em plays dead in front of '..emote_target.name..'.')
		elseif monster or npc_object then
			chat('/em plays dead in front of the '..emote_target.name..'.')
		end

	elseif addcmd == 'pose' then
		if self then
			chat('/em strikes a pose.')
		elseif player or npc_character then
			chat('/em strikes a pose for '..emote_target.name..'.')
		elseif monster or npc_object then
			chat('/em strikes a pose for the '..emote_target.name..'.')
		end

	elseif addcmd == 'sing' then
		if self then
			chat('/em sings the song of '..hishertheir..' people.')
		elseif player or npc_character then
			chat('/em sings the song of '..hishertheir..' people for '..emote_target.name..'.')
		elseif monster or npc_object then
			chat('/em sings the song of '..hishertheir..' people for the '..emote_target.name..'.')
		end

	elseif addcmd == 'squint' then
		if self then
			chat('/em squints.')
		elseif player or npc_character then
			chat('/em squints at '..emote_target.name..'.')
		elseif monster or npc_object then
			chat('/em squints at the '..emote_target.name..'.')
		end

	elseif addcmd == 'taco' then
		if self then
			chat('/em munches on a tasty taco.')
		elseif player or npc_character then
			chat('/em offers '..emote_target.name..' a taco.')
		elseif monster or npc_object then
			chat('/em offers the '..emote_target.name..' a taco.')
		end

	elseif addcmd == 'tag' then
		if self then
			chat('/em looks around for someone to tag.')
		elseif player or npc_character then
			chat('/em tags '..emote_target.name..'.')
			chat('/point motion')
		elseif monster or npc_object then
			chat('/em tags the '..emote_target.name..'.')
			chat('/point motion')
		end

	elseif addcmd == 'thumbsup' then
		if self then
			chat('/em gives a thumbs up.')
		elseif player or npc_character then
			chat('/em gives '..emote_target.name..' a thumbs up.')
		elseif monster or npc_object then
			chat('/em gives the '..emote_target.name..' a thumbs up.')
		end

	elseif addcmd == 'whistle' then
		if self then
			chat('/em whistles to '..himselfherselfthemself..'.')
		elseif player or npc_character then
			chat('/em whistles to '..emote_target.name..'.')
		elseif monster or npc_object then
			chat('/em whistles to the '..emote_target.name..'.')
		end




	elseif addcmd == 'test' then
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

	elseif addcmd == 'reload' then
        cmd('lua r emotes')
        return

	--original built-in emotes in case they are used with the //em in front by mistake
	elseif addcmd == 'aim' then chat('/aim')
	elseif addcmd == 'aim motion' then chat('/aim motion')
	elseif addcmd == 'amazed' then chat('/amazed')
	elseif addcmd == 'amazed motion' then chat('/amazed motion')
	elseif addcmd == 'angry' then chat('/angry')
	elseif addcmd == 'angry motion' then chat('/angry motion')
	elseif addcmd == 'blush' then chat('/blush')
	elseif addcmd == 'blush motion' then chat('/blush motion')
	elseif addcmd == 'bow' then chat('/bow')
	elseif addcmd == 'bow motion' then chat('/bow motion')
	elseif addcmd == 'cheer' then chat('/cheer')
	elseif addcmd == 'cheer motion' then chat('/cheer motion')
	elseif addcmd == 'clap' then chat('/clap')
	elseif addcmd == 'clap motion' then chat('/clap motion')
	elseif addcmd == 'comfort' then chat('/comfort')
	elseif addcmd == 'comfort motion' then chat('/comfort motion')
	elseif addcmd == 'cry' then chat('/cry')
	elseif addcmd == 'cry motion' then chat('/cry motion')
	elseif addcmd == 'dance' then chat('/dance')
	elseif addcmd == 'dance1' then chat('/dance1')
	elseif addcmd == 'dance1 motion' then chat('/dance1 motion')
	elseif addcmd == 'dance2' then chat('/dance2')
	elseif addcmd == 'dance2 motion' then chat('/dance2 motion')
	elseif addcmd == 'dance3' then chat('/dance3')
	elseif addcmd == 'dance3 motion' then chat('/dance3 motion')
	elseif addcmd == 'dance4' then chat('/dance4')
	elseif addcmd == 'dance4 motion' then chat('/dance4 motion')
	elseif addcmd == 'disgusted' then chat('/disgusted')
	elseif addcmd == 'disgusted motion' then chat('/disgusted motion')
	elseif addcmd == 'doubt' then chat('/doubt')
	elseif addcmd == 'doubt motion' then chat('/doubt motion')
	elseif addcmd == 'doze' then chat('/doze')
	elseif addcmd == 'farewell' then chat('/farewell')
	elseif addcmd == 'farewell motion' then chat('/farewell motion')
	elseif addcmd == 'fume' then chat('/fume')
	elseif addcmd == 'fume motion' then chat('/fume motion')
	elseif addcmd == 'goodbye' then chat('/goodbye')
	elseif addcmd == 'goodbye motion' then chat('/goodbye motion')
	elseif addcmd == 'grin' then chat('/grin')
	elseif addcmd == 'huh' then chat('/huh')
	elseif addcmd == 'huh motion' then chat('/huh motion')
	elseif addcmd == 'hurray' then chat('/hurray')
	elseif addcmd == 'hurray motion' then chat('/hurray motion')
	elseif addcmd == 'jobemote brd' or addcmd == 'jobemote bard' then chat('/jobemote brd')
	elseif addcmd == 'jobemote bst' or addcmd == 'jobemote beastmaster' then chat('/jobemote bst')
	elseif addcmd == 'jobemote blm' or addcmd == 'jobemote black mage' or addcmd == 'jobemote blackmage' then chat('/jobemote blm')
	elseif addcmd == 'jobemote brd' or addcmd == 'jobemote blue mage' or addcmd == 'jobemote bluemage' then chat('/jobemote blu')
	elseif addcmd == 'jobemote cor' or addcmd == 'jobemote corsair' then chat('/jobemote cor')
	elseif addcmd == 'jobemote dnc' or addcmd == 'jobemote dancer' then chat('/jobemote dnc')
	elseif addcmd == 'jobemote drk' or addcmd == 'jobemote dark knight' or addcmd == 'jobemote darkknight' then chat('/jobemote drk')
	elseif addcmd == 'jobemote drg' or addcmd == 'jobemote dragoon' then chat('/jobemote drg')
	elseif addcmd == 'jobemote geo' or addcmd == 'jobemote geomancer' then chat('/jobemote geo')
	elseif addcmd == 'jobemote mnk' or addcmd == 'jobemote monk' then chat('/jobemote mnk')
	elseif addcmd == 'jobemote nin' or addcmd == 'jobemote ninja' then chat('/jobemote nin')
	elseif addcmd == 'jobemote pld' or addcmd == 'jobemote paladin' then chat('/jobemote pld')
	elseif addcmd == 'jobemote pup' or addcmd == 'jobemote puppetmaster' then chat('/jobemote pup')
	elseif addcmd == 'jobemote rng' or addcmd == 'jobemote ranger' then chat('/jobemote rng')
	elseif addcmd == 'jobemote rdm' or addcmd == 'jobemote red mage' or addcmd == 'jobemote redmage' then chat('/jobemote rdm')
	elseif addcmd == 'jobemote run' or addcmd == 'jobemote rune fencer' or addcmd == 'jobemote runefencer' then chat('/jobemote run')
	elseif addcmd == 'jobemote sam' or addcmd == 'jobemote samurai' then chat('/jobemote sam')
	elseif addcmd == 'jobemote sch' or addcmd == 'jobemote scholar' then chat('/jobemote sch')
	elseif addcmd == 'jobemote smn' or addcmd == 'jobemote summoner' then chat('/jobemote smn')
	elseif addcmd == 'jobemote thf' or addcmd == 'jobemote thief' then chat('/jobemote thf')
	elseif addcmd == 'jobemote war' or addcmd == 'jobemote warrior' then chat('/jobemote war')
	elseif addcmd == 'jobemote whm' or addcmd == 'jobemote white mage' or addcmd == 'jobemote whitemage' then chat('/jobemote whm')
	elseif addcmd == 'joy' then chat('/joy')
	elseif addcmd == 'joy motion' then chat('/joy motion')
	elseif addcmd == 'jump' then chat('/jump')
	elseif addcmd == 'jump motion' then chat('/jump motion')
	elseif addcmd == 'kneel' then chat('/kneel')
	elseif addcmd == 'kneel motion' then chat('/kneel motion')
	elseif addcmd == 'laugh' then chat('/laugh')
	elseif addcmd == 'laugh motion' then chat('/laugh motion')
	elseif addcmd == 'muted' then chat('/muted')
	elseif addcmd == 'no' then chat('/no')
	elseif addcmd == 'no motion' then chat('/no motion')
	elseif addcmd == 'nod' then chat('/nod')
	elseif addcmd == 'nod motion' then chat('/nod motion')
	elseif addcmd == 'panic' then chat('/panic')
	elseif addcmd == 'panic motion' then chat('/panic motion')
	elseif addcmd == 'point' then chat('/point')
	elseif addcmd == 'point motion' then chat('/point motion')
	elseif addcmd == 'poke' then chat('/poke')
	elseif addcmd == 'poke motion' then chat('/poke motion')
	elseif addcmd == 'praise' then chat('/praise')
	elseif addcmd == 'praise motion' then chat('/praise motion')
	elseif addcmd == 'psych' then chat('/psych')
	elseif addcmd == 'psych motion' then chat('/psych motion')
	elseif addcmd == 'salute' then chat('/salute')
	elseif addcmd == 'salute motion' then chat('/salute motion')
	elseif addcmd == 'shocked' then chat('/shocked')
	elseif addcmd == 'shocked motion' then chat('/shocked motion')
	elseif addcmd == 'sigh' then chat('/sigh')
	elseif addcmd == 'sigh motion' then chat('/sigh motion')
	elseif addcmd == 'sit' then chat('/sit')
	elseif addcmd == 'sitchair' then chat('/sitchair')
	elseif addcmd == 'sitchair1' or addcmd == 'sitchair 1' then chat('/sitchair1')
	elseif addcmd == 'sitchair2' or addcmd == 'sitchair 2' then chat('/sitchair2')
	elseif addcmd == 'sitchair3' or addcmd == 'sitchair 3' then chat('/sitchair3')
	elseif addcmd == 'sitchair4' or addcmd == 'sitchair 4' then chat('/sitchair4')
	elseif addcmd == 'sitchair5' or addcmd == 'sitchair 5' then chat('/sitchair5')
	elseif addcmd == 'sitchair6' or addcmd == 'sitchair 6' then chat('/sitchair6')
	elseif addcmd == 'sitchair7' or addcmd == 'sitchair 7' then chat('/sitchair7')
	elseif addcmd == 'sitchair8' or addcmd == 'sitchair 8' then chat('/sitchair8')
	elseif addcmd == 'sitchair9' or addcmd == 'sitchair 9' then chat('/sitchair9')
	elseif addcmd == 'sitchair10' or addcmd == 'sitchair 10' then chat('/sitchair10')
	elseif addcmd == 'slap' then chat('/slap')
	elseif addcmd == 'smilee' then chat('/smile')
	elseif addcmd == 'stagger' then chat('/stagger')
	elseif addcmd == 'stagger motion' then chat('/stagger motion')
	elseif addcmd == 'stare' then chat('/stare')
	elseif addcmd == 'sulk' then chat('/sulk')
	elseif addcmd == 'sulk motion' then chat('/sulk motion')
	elseif addcmd == 'surprised' then chat('/surprised')
	elseif addcmd == 'surprised motion' then chat('/surprised motion')
	elseif addcmd == 'think' then chat('/think')
	elseif addcmd == 'think motion' then chat('/think motion')
	elseif addcmd == 'toss' then chat('/toss')
	elseif addcmd == 'toss motion' then chat('/toss motion')
	elseif addcmd == 'upset' then chat('/upset')
	elseif addcmd == 'upset motion' then chat('/upset motion')
	elseif addcmd == 'wave' then chat('/wave')
	elseif addcmd == 'wave motion' then chat('/wave motion')
	elseif addcmd == 'welcome' then chat('/welcome')
	elseif addcmd == 'welcome motion' then chat('/welcome motion')
	elseif addcmd == 'yes' then chat('/yes')
	elseif addcmd == 'yes motion' then chat('/yes motion')

	else
		log('[Emotes] Unrecognized emote. type \'//em list\' for current emotes.')

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
