
for _,dye_info in ipairs(dye.dyes) do
    local con_id = 'con_'..dye_info[1]
    local block_id = 'terumet:block_'..con_id
    terumisc.register_nodelamp(block_id, con_id)
end

terumet.register_convertible_block('default:ice', 'ice')
terumet.register_convertible_block(terumisc.id('ice_brick_block'), 'ice_brick_block')
terumet.register_convertible_block(terumisc.id('ice_cube'), 'ice_cube')
