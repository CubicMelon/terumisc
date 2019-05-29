
for index,dye_info in ipairs(dye.dyes) do
    terumet.register_convertible_block(terumisc.concrete_block_id(index), 'concrete_'..dye_info[1])
end

terumet.register_convertible_block('default:ice', 'ice')
terumet.register_convertible_block(terumisc.id('ice_brick_block'), 'ice_brick_block')
terumet.register_convertible_block(terumisc.id('ice_cube'), 'ice_cube')