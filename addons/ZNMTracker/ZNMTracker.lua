--Copyright (c) 2026, Key
--All rights reserved.

--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:

--    * Redistributions of source code must retain the above copyright
--      notice, this list of conditions and the following disclaimer.
--    * Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in the
--      documentation and/or other materials provided with the distribution.
--    * Neither the name of ZNMTracker nor the
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

_addon.name = 'ZNMTracker'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.version = '1.0'
_addon.commands = {'znmtracker', 'znmtrack', 'znmt'}

require 'logger'
config = require('config')
texts = require('texts')

defaults = {

	flags = {
		bold = true,
	},

	pos = {
		x = windower.get_windower_settings().ui_x_res - 600,
		y = 200,
	},

	bg = {
		alpha = 200,
	},

	padding = 2,

	text = {
		
		font = "Consolas",
		size = 10,
		stroke = {
			alpha = 100,
			width = 1,
		},
	},

	colors = {
		unavailable		= {r = 125, g = 120, b = 120},
		available		= {r = 245, g = 255, b = 200},
		hilight			= {r = 150, g = 255, b = 150},
		maroon			= {r = 148, g =   0, b =   0},
		apple_green		= {r = 141, g = 182, b =   0},
		charcoal_grey	= {r =  54, g =  69, b =  79},
		deep_purple		= {r =  75, g =   0, b = 130},
		chestnut		= {r = 149, g =  69, b =  53},
		lilac			= {r = 200, g = 162, b = 200},
		cerise			= {r = 222, g =  49, b =  99},
		salmon			= {r = 250, g = 128, b = 114},
		purplish_grey	= {r = 112, g = 102, b = 119},
		gold			= {r = 255, g = 215, b =   0},
		copper			= {r = 184, g = 115, b =  51},
		bright_blue		= {r =   0, g = 191, b = 255},
		pine_green		= {r =   1, g = 121, b = 111},
		amber			= {r = 255, g = 191, b =   0},
		fallow			= {r = 193, g = 154, b = 107},
		taupe			= {r = 139, g = 133, b = 137},
		sienna			= {r = 160, g =  82, b =  45},
		lavender		= {r = 230, g = 230, b = 250},
	},

	icons = {
		pop = "○",
		trophy = "●",
		ki = "√",
	},

}

settings = config.load(defaults)

box = texts.new('', settings)

colors = settings.colors

pop_items = {
	[2572] = "Pandemonium Key (Pandemonium Warden)",
	[2573] = "Monkey Wine (Tinnin)",
	[2574] = "Ferrite (Armed Gears)",
	[2575] = "Sheep Botfly (Gotoh Zha the Redolent)",
	[2576] = "Olzhiryan Cactus (Dea)",
	[2577] = "Senorita Pamama (Iriz Ima)",
	[2578] = "Oily Blood (Lividroot Amooshah)",
	[2579] = "Samariri Corpsehair (Iriri Samariri)",
	[2580] = "Hellcage Butterfly (Vulpangue)",
	[2581] = "Floral Nectar (Chamrosh)",
	[2582] = "Rodent Cheese (Cheese Hoarder Gigiroon)",
	[2583] = "Buffalo Corpse (Sarameya)",
	[2584] = "Pure Blood (Nosferatu)",
	[2585] = "Vinegar Pie (Khromasoul Bhurborlor)",
	[2586] = "Rock Juice (Achamoth)",
	[2587] = "Raw Buffalo (Anantaboga)",
	[2588] = "Bone Charcoal (Reacton)",
	[2589] = "Granulated Sugar (Dextrose)",
	[2590] = "Shadeleaf (Brass Borer)",
	[2591] = "Pectin (Claret)",
	[2592] = "Cog Lubricant (Ob)",
	[2593] = "Singed Buffalo (Tyger)",
	[2594] = "Exorcism Treatise (Mahjlaef the Paintorn)",
	[2595] = "Myrrh (Experimental Lamia)",
	[2596] = "Rose Scampi (Nuhn)",
	[2597] = "Opalus Gem (Wulgaru)",
	[2598] = "M. No. 11 Molting (Zareehkl the Jubilant)",
	[2599] = "Mint Drop (Verdelet)",
	[2600] = "Golden Teeth (Velionis)",
	[2601] = "Greenling (Lil' Apkallu)",
	[2602] = "Spoilt Blood (Chigre)",
}

trophy_items = {
	[2609] = "Tinnin's Fang",
	[2610] = "A. Gears' Fragment",
	[2611] = "G. Zha's Necklace",
	[2612] = "Dea's Horn",
	[2613] = "Iriz Ima's Hide",
	[2614] = "Amoosh.'s Tendril",
	[2615] = "Iriri Samariri's Hat",
	[2616] = "Vulpangue's Wing",
	[2617] = "Chamrosh's Beak",
	[2618] = "Gigiroon's Cape",
	[2619] = "Sarameya's Hide",
	[2620] = "Nosferatu's Claw",
	[2621] = "Bblr.'s Vambrace",
	[2622] = "Acham.'s Antenna",
	[2623] = "Anantaboga's Heart",
	[2624] = "Reacton's Ashes",
	[2625] = "Dextrose's Blubber",
	[2626] = "B. Borer's Cocoon",
	[2627] = "Claret Globule",
	[2628] = "Ob's Arm",
	[2629] = "Tyger's Tail",
	[2630] = "Mahjlaef's Staff",
	[2631] = "Ex. Lamia Armband",
	[2632] = "Nuhn's Esca",
	[2633] = "Wulgaru's Head",
	[2634] = "Zrkl.'s Neckpiece",
	[2635] = "Verdelet's Wing",
	[2636] = "Velionis's Bone",
	[2637] = "Lil' Apkallu's Egg",
	[2638] = "Chigre",
}

key_items = {
	[998]  = "Maroon Seal",
	[999]  = "Apple Green Seal",
	[1000] = "Charcoal Grey Seal",
	[1001] = "Deep Purple Seal",
	[1002] = "Chestnut-Colored Seal",
	[1003] = "Lilac-Colored Seal",
	[1004] = "Cerise Seal",
	[1005] = "Salmon-Colored Seal",
	[1006] = "Purplish Grey Seal",
	[1007] = "Gold-Colored Seal",
	[1008] = "Copper-Colored Seal",
	[1009] = "Bright Blue Seal",
	[1010] = "Pine Green Seal",
	[1011] = "Amber-Colored Seal",
	[1012] = "Fallow-Colored Seal",
	[1013] = "Taupe-Colored Seal",
	[1014] = "Sienna-Colored Seal",
	[1015] = "Lavender-Colored Seal",
}

bags = {
	[0]  = "Inventory",
	[1]  = "Safe",
	[2]  = "Storage",
	[4]  = "Locker",
	[5]  = "Satchel",
	[6]  = "Sack",
	[7]  = "Case",
	[9]  = "Safe 2",
	[17] = "Recycle",
}

pop = {}
trophy = {}
ki = {}
display = "All"

--Format RGB values with leading zeros (helps prevent an issue with the text not lining up correctly after color is added)
function formatRGB(value)
	return string.format("%03d", value)
end

cs_hilight = "\\cs("..formatRGB(colors.hilight.r)..","..formatRGB(colors.hilight.g)..","..formatRGB(colors.hilight.b)..")"
icons = {
	pop		= cs_hilight..settings.icons.pop.."\\cr",
	trophy	= cs_hilight..settings.icons.trophy.."\\cr",
	ki		= cs_hilight..settings.icons.ki.."\\cr",
}

function findItems()

	pop = {}
	trophy = {}
	ki = {}

	--Check through your bags for pop/trophy items
	for bag_id, bag_name in pairs(bags) do
		local bag_items = windower.ffxi.get_items(bag_id)
		if bag_items then
			for slot = 1, (bag_items.max or 0) do
				local item = bag_items[slot]
				if item and item.id then
					if pop_items[item.id] then
						pop[item.id] = bag_id
					elseif trophy_items[item.id] then
						trophy[item.id] = bag_id
					end
				end
			end
		end
	end

	--Check for Key Items
	local get_key_items = windower.ffxi.get_key_items()
	if get_key_items then
		for _, ki_id in pairs(get_key_items) do
			if key_items[ki_id] then
				ki[ki_id] = true
			end
		end
	end

end

function printItems()

	findItems()

	--Print out what we found (and where)
	local function printFound(title, items, found_table, bags, show_bag)
		windower.add_to_chat(207, title)

		--Nothing found for this table, can skip everything else
		if next(found_table) == nil then
			windower.add_to_chat(214, "- None")
			return
		end

		--Take everything found and put it in a nice neat table first so we can sort it
		local output = {}
		for item_id, item_name in pairs(items) do
			if found_table[item_id] then
				table.insert(output, {
					name = item_name,
					bag_id = found_table[item_id],
					bag_name = bags[found_table[item_id]]
				})
			end
		end

		--Sort by bag first, then alphabetically
		if show_bag then
			table.sort(output, function(a, b)
				if a.bag_id == b.bag_id then
					return a.name < b.name
				else
					return a.bag_id < b.bag_id
				end
			end)

			for _, entry in ipairs(output) do
				windower.add_to_chat(214, string.format("- [%s] %s", entry.bag_name, entry.name))
			end

		--Key Items just get sorted alphabetically
		else
			table.sort(output, function(a, b)
				return a.name < b.name
			end)

			for _, entry in ipairs(output) do
				windower.add_to_chat(214, string.format("- %s", entry.name))
			end
		end
	end

	printFound("=== ZNM Pop Items ===", pop_items, pop, bags, true)
	printFound("=== ZNM Trophy Items ===", trophy_items, trophy, bags, true)
	printFound("=== ZNM Key Items ===", key_items, ki, bags, false)

end

function updateBox()

	findItems()

	local text = {}
	local cs
	local have_pop
	local have_trophy
	local have_ki
	local cs_tier = "\\cs(255,255,255)"
	local cs_unable = "\\cs("..formatRGB(colors.unavailable.r)..","..formatRGB(colors.unavailable.g)..","..formatRGB(colors.unavailable.b)..")"
	local cs_able = "\\cs("..formatRGB(colors.available.r)..","..formatRGB(colors.available.g)..","..formatRGB(colors.available.b)..")"
	local cr = "\\cr"
	local x = "\\cs(050,050,050)×\\cr"

	if display == "All" then
		table.insert(text, ("=== \\cs(000,191,255)ZNM Tracker\\cr =============================== \\cs(000,191,255)//znmt help\\cr ===\n"))
		table.insert(text, ("    "..icons.pop.." = Pop   "..icons.trophy.." = Trophy   "..icons.ki.." = KI   "..cs_able.."Available\\cr   "..cs_unable.."Unavailable\\cr\n"))
		table.insert(text, (cs_tier.."                            Tier 1"..cr.."\n"))
	else
		table.insert(text, ("==== \\cs(000,191,255)ZNM Tracker\\cr ====\n"))
		table.insert(text, (cs_tier.."       Tier 1"..cr.."\n"))
	end

	if display == "All" or display == "Tinnin" then
		cs = cs_able
		have_pop = pop[2580] and icons.pop or x
		have_trophy = trophy[2616] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Vulpangue        "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Sarameya" then
		cs = cs_able
		have_pop = pop[2590] and icons.pop or x
		have_trophy = trophy[2626] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Brass Borer      "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Tyger" then
		cs = cs_able
		have_pop = pop[2600] and icons.pop or x
		have_trophy = trophy[2636] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Velionis"..cr.."\n"))

	end

	if display == "All" or display == "Tinnin" then
		cs = cs_able
		have_pop = pop[2581] and icons.pop or x
		have_trophy = trophy[2617] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Chamrosh         "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Sarameya" then
		cs = cs_able
		have_pop = pop[2591] and icons.pop or x
		have_trophy = trophy[2627] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Claret           "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Tyger" then
		cs = cs_able
		have_pop = pop[2601] and icons.pop or x
		have_trophy = trophy[2637] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Lil' Apkallu"..cr.."\n"))

	end

	if display == "All" or display == "Tinnin" then
		cs = cs_able
		have_pop = pop[2582] and icons.pop or x
		have_trophy = trophy[2618] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Chs. H. Gigiroon "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Sarameya" then
		cs = cs_able
		have_pop = pop[2592] and icons.pop or x
		have_trophy = trophy[2628] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Ob               "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Tyger" then
		cs = cs_able
		have_pop = pop[2602] and icons.pop or x
		have_trophy = trophy[2638] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Chigre"..cr.."\n"))
	end

	if display == "All" or display == "Tinnin" then
		cs = ki[998] and "\\cs("..formatRGB(colors.maroon.r)..","..formatRGB(colors.maroon.g)..","..formatRGB(colors.maroon.b)..")" or ((trophy[2616] or trophy[2617] or trophy[2618]) and cs_able or cs_unable)
		have_trophy = (trophy[2616] or trophy[2617] or trophy[2618]) and icons.trophy or x
		have_ki = ki[998] and icons.ki or x
		table.insert(text, ("["..have_trophy..have_ki.."]"..cs.."Maroon Seal      "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Sarameya" then
		cs = ki[1004] and "\\cs("..formatRGB(colors.cerise.r)..","..formatRGB(colors.cerise.g)..","..formatRGB(colors.cerise.b)..")" or ((trophy[2590] or trophy[2627] or trophy[2628]) and cs_able or cs_unable)
		have_trophy = (trophy[2590] or trophy[2627] or trophy[2628]) and icons.trophy or x
		have_ki = ki[1004] and icons.ki or x
		table.insert(text, ("["..have_trophy..have_ki.."]"..cs.."Cerise Seal      "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Tyger" then
		cs = ki[1010] and "\\cs("..formatRGB(colors.pine_green.r)..","..formatRGB(colors.pine_green.g)..","..formatRGB(colors.pine_green.b)..")" or ((trophy[2600] or trophy[2637] or trophy[2638]) and cs_able or cs_unable)
		have_trophy = (trophy[2600] or trophy[2637] or trophy[2638]) and icons.trophy or x
		have_ki = ki[1010] and icons.ki or x
		table.insert(text, ("["..have_trophy..have_ki.."]"..cs.."Pine Green Seal"..cr.."\n"))
	end
	
	if display == "All" then
		table.insert(text, (cs_tier.."                            Tier 2"..cr.."\n"))
	else
		table.insert(text, (cs_tier.."       Tier 2"..cr.."\n"))
	end

	if display == "All" or display == "Tinnin" then
		cs = ki[998] and cs_able or cs_unable
		have_pop = pop[2577] and icons.pop or x
		have_trophy = trophy[2613] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Iriz Ima         "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Sarameya" then
		cs = ki[1004] and cs_able or cs_unable
		have_pop = pop[2587] and icons.pop or x
		have_trophy = trophy[2623] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Anantaboga       "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Tyger" then
		cs = ki[1010] and cs_able or cs_unable
		have_pop = pop[2598] and icons.pop or x
		have_trophy = trophy[2634] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Zareehkl the Jbl."..cr.."\n"))
	end

	if display == "All" or display == "Tinnin" then
		cs = ki[998] and cs_able or cs_unable
		have_pop = pop[2579] and icons.pop or x
		have_trophy = trophy[2615] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Iriri Samariri   "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Sarameya" then
		cs = ki[1004] and cs_able or cs_unable
		have_pop = pop[2588] and icons.pop or x
		have_trophy = trophy[2624] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Reacton          "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Tyger" then
		cs = ki[1010] and cs_able or cs_unable
		have_pop = pop[2599] and icons.pop or x
		have_trophy = trophy[2635] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Verdelet"..cr.."\n"))
	end

	if display == "All" or display == "Tinnin" then
		cs = ki[998] and cs_able or cs_unable
		have_pop = pop[2578] and icons.pop or x
		have_trophy = trophy[2614] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Livid. Amooshah  "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Sarameya" then
		cs = ki[1004] and cs_able or cs_unable
		have_pop = pop[2589] and icons.pop or x
		have_trophy = trophy[2625] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Dextrose         "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Tyger" then
		cs = ki[1010] and cs_able or cs_unable
		have_pop = pop[2597] and icons.pop or x
		have_trophy = trophy[2633] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Wulgaru"..cr.."\n"))
	end
	
	if display == "All" or display == "Tinnin" then
		cs = ki[999] and "\\cs("..formatRGB(colors.apple_green.r)..","..formatRGB(colors.apple_green.g)..","..formatRGB(colors.apple_green.b)..")" or ((trophy[2613] or trophy[2623] or trophy[2634]) and cs_able or cs_unable)
		have_trophy = (trophy[2613] or trophy[2623] or trophy[2634]) and icons.trophy or x
		have_ki = ki[999] and icons.ki or x
		table.insert(text, ("["..have_trophy..have_ki.."]"..cs.."Apple Green Seal "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Sarameya" then
		cs = ki[1005] and "\\cs("..formatRGB(colors.salmon.r)..","..formatRGB(colors.salmon.g)..","..formatRGB(colors.salmon.b)..")" or ((trophy[2615] or trophy[2624] or trophy[2635]) and cs_able or cs_unable)
		have_trophy = (trophy[2615] or trophy[2624] or trophy[2635]) and icons.trophy or x
		have_ki = ki[1005] and icons.ki or x
		table.insert(text, ("["..have_trophy..have_ki.."]"..cs.."Salmon Seal      "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Tyger" then
		cs = ki[1011] and "\\cs("..formatRGB(colors.amber.r)..","..formatRGB(colors.amber.g)..","..formatRGB(colors.amber.b)..")" or ((trophy[2614] or trophy[2625] or trophy[2633]) and cs_able or cs_unable)
		have_trophy = (trophy[2614] or trophy[2625] or trophy[2633]) and icons.trophy or x
		have_ki = ki[1011] and icons.ki or x
		table.insert(text, ("["..have_trophy..have_ki.."]"..cs.."Amber Seal"..cr.."\n"))
	end

	if display == "All" then
		table.insert(text, (cs_tier.."                            Tier 3"..cr.."\n"))
	else
		table.insert(text, (cs_tier.."       Tier 3"..cr.."\n"))
	end

	if display == "All" or display == "Tinnin" then
		cs = ki[999] and cs_able or cs_unable
		have_pop = pop[2574] and icons.pop or x
		have_trophy = trophy[2610] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Armed Gears      "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Sarameya" then
		cs = ki[1005] and cs_able or cs_unable
		have_pop = pop[2584] and icons.pop or x
		have_trophy = trophy[2620] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Nosferatu        "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Tyger" then
		cs = ki[1011] and cs_able or cs_unable
		have_pop = pop[2594] and icons.pop or x
		have_trophy = trophy[2630] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Mahjlaef the Pnt."..cr.."\n"))
	end

	if display == "All" or display == "Tinnin" then
		cs = ki[1000] and "\\cs("..formatRGB(colors.charcoal_grey.r)..","..formatRGB(colors.charcoal_grey.g)..","..formatRGB(colors.charcoal_grey.b)..")" or (trophy[2610] and cs_able or cs_unable)
		have_trophy = trophy[2610] and icons.trophy or x
		have_ki = ki[1000] and icons.ki or x
		table.insert(text, ("["..have_trophy..have_ki.."]"..cs.."Char. Grey Seal  "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Sarameya" then
		cs = ki[1006] and "\\cs("..formatRGB(colors.purplish_grey.r)..","..formatRGB(colors.purplish_grey.g)..","..formatRGB(colors.purplish_grey.b)..")" or (trophy[2620] and cs_able or cs_unable)
		have_trophy = trophy[2620] and icons.trophy or x
		have_ki = ki[1006] and icons.ki or x
		table.insert(text, ("["..have_trophy..have_ki.."]"..cs.."Purp. Grey Seal  "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Tyger" then
		cs = ki[1012] and "\\cs("..formatRGB(colors.fallow.r)..","..formatRGB(colors.fallow.g)..","..formatRGB(colors.fallow.b)..")" or (trophy[2630] and cs_able or cs_unable)
		have_trophy = trophy[2630] and icons.trophy or x
		have_ki = ki[1012] and icons.ki or x
		table.insert(text, ("["..have_trophy..have_ki.."]"..cs.."Fallow Seal"..cr.."\n"))
	end

	if display == "All" then
		table.insert(text, ("\\cs(175,175,175)          ---                  ---                  ---\\cr\n"))
	else
		table.insert(text, ("          ---\n"))
	end

	if display == "All" or display == "Tinnin" then
		cs = ki[999] and cs_able or cs_unable
		have_pop = pop[2575] and icons.pop or x
		have_trophy = trophy[2611] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Gotoh Z. the Rd. "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Sarameya" then
		cs = ki[1005] and cs_able or cs_unable
		have_pop = pop[2585] and icons.pop or x
		have_trophy = trophy[2621] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Khromasoul Bblr. "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Tyger" then
		cs = ki[1011] and cs_able or cs_unable
		have_pop = pop[2595] and icons.pop or x
		have_trophy = trophy[2631] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Experim. Lamia"..cr.."\n"))
	end

	if display == "All" or display == "Tinnin" then
		cs = ki[1001] and "\\cs("..formatRGB(colors.deep_purple.r)..","..formatRGB(colors.deep_purple.g)..","..formatRGB(colors.deep_purple.b)..")" or (trophy[2611] and cs_able or cs_unable)
		have_trophy = trophy[2611] and icons.trophy or x
		have_ki = ki[1001] and icons.ki or x
		table.insert(text, ("["..have_trophy..have_ki.."]"..cs.."Deep Purple Seal "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Sarameya" then
		cs = ki[1007] and "\\cs("..formatRGB(colors.gold.r)..","..formatRGB(colors.gold.g)..","..formatRGB(colors.gold.b)..")" or (trophy[2621] and cs_able or cs_unable)
		have_trophy = trophy[2621] and icons.trophy or x
		have_ki = ki[1007] and icons.ki or x
		table.insert(text, ("["..have_trophy..have_ki.."]"..cs.."Gold Seal        "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Tyger" then
		cs = ki[1013] and "\\cs("..formatRGB(colors.taupe.r)..","..formatRGB(colors.taupe.g)..","..formatRGB(colors.taupe.b)..")" or (trophy[2631] and cs_able or cs_unable)
		have_trophy = trophy[2631] and icons.trophy or x
		have_ki = ki[1013] and icons.ki or x
		table.insert(text, ("["..have_trophy..have_ki.."]"..cs.."Taupe Seal"..cr.."\n"))
	end

	if display == "All" then
		table.insert(text, ("\\cs(175,175,175)          ---                  ---                  ---\\cr\n"))
	else
		table.insert(text, ("          ---\n"))
	end

	if display == "All" or display == "Tinnin" then
		cs = ki[999] and cs_able or cs_unable
		have_pop = pop[2576] and icons.pop or x
		have_trophy = trophy[2612] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Dea              "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Sarameya" then
		cs = ki[1005] and cs_able or cs_unable
		have_pop = pop[2586] and icons.pop or x
		have_trophy = trophy[2622] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Achamoth         "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Tyger" then
		cs = ki[1011] and cs_able or cs_unable
		have_pop = pop[2596] and icons.pop or x
		have_trophy = trophy[2632] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Nuhn"..cr.."\n"))
	end

	if display == "All" or display == "Tinnin" then
		cs = ki[1002] and "\\cs("..formatRGB(colors.chestnut.r)..","..formatRGB(colors.chestnut.g)..","..formatRGB(colors.chestnut.b)..")" or (trophy[2612] and cs_able or cs_unable)
		have_trophy = trophy[2612] and icons.trophy or x
		have_ki = ki[1002] and icons.ki or x
		table.insert(text, ("["..have_trophy..have_ki.."]"..cs.."Chestnut Seal    "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Sarameya" then
		cs = ki[1008] and "\\cs("..formatRGB(colors.copper.r)..","..formatRGB(colors.copper.g)..","..formatRGB(colors.copper.b)..")" or (trophy[2622] and cs_able or cs_unable)
		have_trophy = trophy[2622] and icons.trophy or x
		have_ki = ki[1008] and icons.ki or x
		table.insert(text, ("["..have_trophy..have_ki.."]"..cs.."Copper Seal      "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Tyger" then
		cs = ki[1014] and "\\cs("..formatRGB(colors.sienna.r)..","..formatRGB(colors.sienna.g)..","..formatRGB(colors.sienna.b)..")" or (trophy[2632] and cs_able or cs_unable)
		have_trophy = trophy[2632] and icons.trophy or x
		have_ki = ki[1014] and icons.ki or x
		table.insert(text, ("["..have_trophy..have_ki.."]"..cs.."Sienna Seal"..cr.."\n"))
	end

	if display == "All" then
		table.insert(text, (cs_tier.."                            Tier 4"..cr.."\n"))
	else
		table.insert(text, (cs_tier.."       Tier 4"..cr.."\n"))
	end

	if display == "All" or display == "Tinnin" then
		cs = (ki[1000] and ki[1001] and ki[1002]) and cs_able or cs_unable
		have_pop = pop[2573] and icons.pop or x
		have_trophy = trophy[2609] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Tinnin           "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Sarameya" then
		cs = (ki[1006] and ki[1007] and ki[1008]) and cs_able or cs_unable
		have_pop = pop[2583] and icons.pop or x
		have_trophy = trophy[2619] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Sarameya         "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Tyger" then
		cs = (ki[1012] and ki[1013] and ki[1014]) and cs_able or cs_unable
		have_pop = pop[2593] and icons.pop or x
		have_trophy = trophy[2629] and icons.trophy or x
		table.insert(text, ("["..have_pop..have_trophy.."]"..cs.."Tyger"..cr.."\n"))
	end

	if display == "All" or display == "Tinnin" then
		cs = ki[1003] and "\\cs("..formatRGB(colors.lilac.r)..","..formatRGB(colors.lilac.g)..","..formatRGB(colors.lilac.b)..")" or (trophy[2609] and cs_able or cs_unable)
		have_trophy = trophy[2609] and icons.trophy or x
		have_ki = ki[1003] and icons.ki or x
		table.insert(text, ("["..have_trophy..have_ki.."]"..cs.."Lilac Seal       "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Sarameya" then
		cs = ki[1009] and "\\cs("..formatRGB(colors.bright_blue.r)..","..formatRGB(colors.bright_blue.g)..","..formatRGB(colors.bright_blue.b)..")" or (trophy[2619] and cs_able or cs_unable)
		have_trophy = trophy[2619] and icons.trophy or x
		have_ki = ki[1009] and icons.ki or x
		table.insert(text, ("["..have_trophy..have_ki.."]"..cs.."Bright Blue Seal "..cr..(display ~= "All" and "\n" or "")))
	end
	if display == "All" or display == "Tyger" then
		cs = ki[1015] and "\\cs("..formatRGB(colors.lavender.r)..","..formatRGB(colors.lavender.g)..","..formatRGB(colors.lavender.b)..")" or (trophy[2629] and cs_able or cs_unable)
		have_trophy = trophy[2629] and icons.trophy or x
		have_ki = ki[1015] and icons.ki or x
		table.insert(text, ("["..have_trophy..have_ki.."]"..cs.."Lavender Seal"..cr.."\n"))
	end

	if display == "All" then
		table.insert(text, (cs_tier.."                            Tier 5"..cr.."\n"))
		cs = (ki[1003] and ki[1009] and ki[1015]) and cs_able or cs_unable
		have_trophy = 
		have
		table.insert(text, ("                     ["..(pop[2572] and icons.pop or x).."]"..cs.."Pandemonium Warden"..cr))
	end

	local display_text = table.concat(text)
	box:text(display_text)

end

windower.register_event('add item', function()
	updateBox()
end)

windower.register_event('remove item', function()
	updateBox()
end)

windower.register_event('incoming chunk', function(id)
    if box:visible() and id == 0x055 then
        updateBox()
    end
end)

windower.register_event('addon command', function(cmd, ...)

	cmd = cmd and string.lower(cmd) or nil

	if not cmd and windower.ffxi.get_info().logged_in then
		if box:visible() then
			box:hide()
		else
			updateBox()
			box:show()
		end

	elseif cmd == "show" then
		updateBox()
		box:show()

	elseif cmd == "hide" then
		box:hide()

	elseif cmd == "check" or cmd == "list" then
		printItems()

	elseif cmd and cmd:find("tin") then
		display = "Tinnin"
		updateBox()
		box:show()

	elseif cmd and cmd:find("sar") then
		display = "Sarameya"
		updateBox()
		box:show()

	elseif cmd and cmd:find("tyg") then
		display = "Tyger"
		updateBox()
		box:show()

	elseif cmd and cmd:find("pan") or cmd == "all" or cmd == "pw" then
		display = "All"
		updateBox()
		box:show()

	elseif cmd == "help" then
		local prefix = "//znmtracker, //znmtrack, //znmt"
		windower.add_to_chat(8,('[ZNMTrcker] ':color(220))..('Version '):color(8)..(_addon.version):color(220)..(' by '):color(8)..(_addon.author):color(220)..(' ('):color(8)..(prefix):color(1)..(')'):color(8))
		windower.add_to_chat(8,' ')
		windower.add_to_chat(8,(' Command '):color(36)..(' - Description'):color(8))
		windower.add_to_chat(8,(' (no command) '):color(36)..(' - Show/hide tracker window.'):color(8))
		windower.add_to_chat(8,(' check/list '):color(36)..(' - List all pop, trophy, and key items this character has and their location.'):color(8))
		windower.add_to_chat(8,(' tinnin/tin '):color(36)..(' - Display only the path for Tinnin in the tracker window.'):color(8))
		windower.add_to_chat(8,(' sarameya/sar '):color(36)..(' - Display only the path for Sarameya in the tracker window.'):color(8))
		windower.add_to_chat(8,(' tyger/tyg '):color(36)..(' - Display only the path for Tyger in the tracker window.'):color(8))
		windower.add_to_chat(8,(' pan/pw/all '):color(36)..(' - Display all paths in the tracker window.'):color(8))

	end
end)
