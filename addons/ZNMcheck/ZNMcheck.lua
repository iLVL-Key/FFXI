--Copyright (c) 2026, Key
--All rights reserved.

--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:

--    * Redistributions of source code must retain the above copyright
--      notice, this list of conditions and the following disclaimer.
--    * Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in the
--      documentation and/or other materials provided with the distribution.
--    * Neither the name of ZNMcheck nor the
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

_addon.name = 'ZNMcheck'
_addon.author = 'Key (Keylesta@Valefor)'
_addon.version = '1.0'
_addon.commands = {'znmcheck', 'znmchecker', 'znmc'}

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

function findItems()

	local pop_items_found = {}
	local trophy_items_found = {}
	local key_items_found = {}

	--Check through your bags for pop/trophy items
	for bag_id, bag_name in pairs(bags) do
		local bag_items = windower.ffxi.get_items(bag_id)
		if bag_items then
			for slot = 1, bag_items.max do
				local item = bag_items[slot]
				if item and item.id then
					if pop_items[item.id] then
						pop_items_found[item.id] = bag_id
					elseif trophy_items[item.id] then
						trophy_items_found[item.id] = bag_id
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
				key_items_found[ki_id] = true
			end
		end
	end

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

	printFound("=== ZNM Pop Items ===", pop_items, pop_items_found, bags, true)
	printFound("=== ZNM Trophy Items ===", trophy_items, trophy_items_found, bags, true)
	printFound("=== ZNM Key Items ===", key_items, key_items_found, bags, false)

end

windower.register_event('addon command', function(cmd, ...)
	findItems()
end)