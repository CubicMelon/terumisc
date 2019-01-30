local default_ice = 'default:ice'
local brick_id = terumisc.id('icebrick')

local ice_groups = {cracky=3, cools_lava=1, slippery=3}
local ice_sounds = {
    footstep={name='terumisc_ice_step', gain=0.5},
    dig={name='terumisc_ice_dig', gain=0.9, pitch=2.0},
    dug={name='terumisc_ice_dig', gain=0.9, pitch=2.5},
    place={name='terumisc_ice_place', gain=0.7, pitch=2.0},
}

minetest.registered_nodes[default_ice].sounds = ice_sounds

-- ================================================================================================

local cube_id = terumisc.id('ice_cube')
minetest.register_node(cube_id, {
	description = 'Ice Cube',
	tiles = {terumisc.tex('ice_cube')},
    is_ground_content = false,
    paramtype = 'light',
	groups = ice_groups,
	sounds = ice_sounds,
})

minetest.register_craft{
    output = cube_id .. ' 8',
    recipe = {
        {default_ice, default_ice, default_ice},
        {default_ice, '', default_ice},
        {default_ice, default_ice, default_ice},
    }
}

-- ================================================================================================

minetest.register_craftitem(brick_id, {
	description = 'Ice Brick',
	inventory_image = terumisc.tex('icebrick'),
})

minetest.register_craft{
	output = brick_id..' 12',
	recipe = {
		{'', default_ice, ''},
        {'', default_ice, ''},
        {'', default_ice, ''}
	}
}

walls.register(terumisc.id('wall_ice_brick'), 'Ice Brick Wall',
    'terumisc_ice_bricksides.png', brick_id, ice_sounds)

-- ================================================================================================

if minetest.global_exists('doors') then
    doors.register(terumisc.id('door_ice'), {
        tiles = {{name = terumisc.tex('door_ice'), backface_culling = true}},
        description = 'Ice Door',
        inventory_image = terumisc.tex('dinv_ice'),
        protected = true,
        groups = {cracky = 1, level = 1},
        sounds = ice_sounds,
        sound_open = 'doors_steel_door_open',
        sound_close = 'doors_steel_door_close',
        recipe = {
            {brick_id, brick_id},
            {brick_id, brick_id},
            {brick_id, brick_id},
        }
    })
end
-- ================================================================================================

local brickblock_id = terumisc.id('ice_brick_block')

minetest.register_node(brickblock_id, {
	description = 'Ice Brick Block',
	tiles = {terumisc.tex('ice_bricktb'), terumisc.tex('ice_bricktb'), terumisc.tex('ice_bricksides')},
    is_ground_content = false,
    paramtype = 'light',
	groups = ice_groups,
	sounds = ice_sounds,
})

minetest.register_craft{
    output = brickblock_id,
    recipe = {
        {brick_id, brick_id},
        {brick_id, brick_id}
    }
}