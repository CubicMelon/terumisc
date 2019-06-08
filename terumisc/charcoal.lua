
local cc_id = terumisc.id('charcoal')
local ccblock_id = terumisc.id('block_charcoal')

minetest.register_craftitem(cc_id, {
	description = 'Charcoal Pellet',
	inventory_image = terumisc.tex('charcoal'),
	groups = {coal = 1, flammable = 1}
})

minetest.register_node(ccblock_id, {
	description = 'Charcoal Block',
	tiles = {terumisc.tex('block_charcoal')},
	is_ground_content = false,
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft{
    type = 'cooking',
    output = cc_id .. ' 2',
	recipe = 'group:tree',
	cooktime = 30,
}

minetest.register_craft{
	type = 'fuel',
	recipe = cc_id,
	burntime = 40,
}

minetest.register_craft{
	type = 'fuel',
	recipe = ccblock_id,
	burntime = 370,
}

minetest.register_craft{
	output = ccblock_id,
	recipe = terumisc.recipe_3x3(cc_id)
}

minetest.register_craft{
    output = cc_id .. ' 9',
    type = 'shapeless',
    recipe = {ccblock_id}
}

minetest.register_craft{
	output = 'default:torch 4',
	recipe = {
		{cc_id},
		{'group:stick'},
	}
}