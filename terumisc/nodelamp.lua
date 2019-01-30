local lamp_tex = terumisc.tex('ov_lamp')
local craft_edge = 'xpanes:pane_flat'
local craft_center = 'default:mese_crystal'

function register_nodelamp(basenode, suffix)
    local base_def = minetest.registered_nodes[basenode]
    if not base_def then error('basenode '..basenode..' is not defined') end
    local lamp_def = terumisc.clone_table(base_def)
    lamp_def.light_source = default.LIGHT_MAX
    lamp_def.description = lamp_def.description .. ' Lamp'
    --lamp_def.overlay_tiles = {}
    for n,tex in ipairs(lamp_def.tiles) do
        lamp_def.tiles[n] = tex .. '^' .. lamp_tex
    end
    local lamp_id = terumisc.id('lamp_'..suffix)
    minetest.register_node(lamp_id, lamp_def)
    minetest.register_craft{ output=lamp_id .. ' 4', recipe={
        {basenode, craft_edge, basenode},
        {craft_edge, craft_center, craft_edge},
        {basenode, craft_edge, basenode}
    }}
end

register_nodelamp('default:ice', 'ice')
register_nodelamp('default:stone', 'stone')
register_nodelamp('default:cobble', 'cobble')
register_nodelamp('default:mossycobble', 'mossycobble')
register_nodelamp('default:brick', 'brick')
register_nodelamp('default:stonebrick', 'stonebrick')
register_nodelamp('default:sandstonebrick', 'sandstone_brick')
register_nodelamp('default:desert_sandstone_brick', 'desert_sandstone_brick')
register_nodelamp('default:silver_sandstone_brick', 'silver_sandstone_brick')
register_nodelamp('terumisc:ice_brick_block', 'ice_brick_block')
register_nodelamp('terumisc:ice_cube', 'ice_cube')