local CONCRETE_COLORS = {
    '#FFF',--white
    '#AAA',--grey
    '#666',--dark grey
    '#333',--black
    '#722ed4',--violet
    '#2e56d4',--blue
    '#2ec2d4',--cyan
    '#135918',--dark green
    '#3ad42e',--green
    '#d4c12e',--yellow
    '#592e13',--brown
    '#d4652e',--orange
    '#d42e2e',--red
    '#d80481',--magenta
    '#ff7272',--pink
}
local conpow_baseid = terumisc.id('con_pow')
local conblock_baseid = terumisc.id('con_block')

local FMT = string.format
local function powder_id(dye_index)
    return FMT("%s_%s", conpow_baseid, dye.dyes[dye_index][1])
end
local function powder_name(dye_index)
    return FMT("%s Concrete Mix", dye.dyes[dye_index][2])
end
function terumisc.concrete_block_id(dye_index)
    return FMT("%s_%s", conblock_baseid, dye.dyes[dye_index][1])
end
local function block_name(dye_index)
    return FMT("%s Concrete Block", dye.dyes[dye_index][2])
end
local function powder_texture(dye_index)
    return FMT("%s^[multiply:%s", terumisc.tex('con_pow'), CONCRETE_COLORS[dye_index])
end
local function block_texture(dye_index)
    return FMT("%s^[multiply:%s", terumisc.tex('con_block'), CONCRETE_COLORS[dye_index])
end

local HARDEN_LIST = {}
local POWDER_LIST = {}

for index,dye_info in ipairs(dye.dyes) do
    minetest.register_node(powder_id(index), {
        description = powder_name(index),
        tiles = {powder_texture(index)},
        is_ground_content = false,
        groups = {crumbly=2, falling_node=1},
        sounds = default.node_sound_sand_defaults(),
    })

    minetest.register_node(terumisc.concrete_block_id(index), {
        description = block_name(index),
        tiles = {block_texture(index)},
        is_ground_content = false,
        groups = {cracky = 2, level = 1},
        sounds = default.node_sound_stone_defaults(),
    })

    if index ~= 1 then
        local dye_id = "group:dye,color_"..dye_info[1]
        local basic_powder = powder_id(1)
        minetest.register_craft({
            output = powder_id(index)..' 8',
            recipe = {
                {basic_powder, basic_powder, basic_powder},
                {basic_powder, dye_id, basic_powder},
                {basic_powder, basic_powder, basic_powder}
            }
        })
    end

    HARDEN_LIST[powder_id(index)] = terumisc.concrete_block_id(index)
    terumisc.push(POWDER_LIST, powder_id(index))
end

minetest.register_abm{
    label = 'Concrete mix hardening',
    nodenames = POWDER_LIST,
    neighbors = {'default:water_source', 'default:water_flowing'},
    interval = 3.0, -- Run every 3 seconds
    chance = 1, -- always
    action = function(pos, node, active_object_count, active_object_count_wider)
        local harden_id = HARDEN_LIST[node.name]
        if harden_id then
            minetest.set_node(pos, {name = harden_id})
        end
    end
}

local gravel_id = 'default:gravel'
local any_sand = 'group:sand'

minetest.register_craft{
    output = powder_id(1)..' 8',
    recipe = {
        {any_sand, gravel_id, any_sand},
        {gravel_id, '', gravel_id},
        {any_sand, gravel_id, any_sand}
    }
}