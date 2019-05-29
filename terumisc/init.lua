-- Terumisc v1.0

-- Mod for open-source voxel game Minetest (https://www.minetest.net/)
-- Written for Minetest version 5.0.0, also supports Minetest 0.4.17

-- By Terumoc [https://github.com/Terumoc]

--[[ Copyright (C) 2019 Terumoc (Scott Horvath)
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>. ]]

terumisc = {}
terumisc.version = {major=1, minor=0, patch=0}
local ver = terumisc.version
terumisc.version_text = ver.major .. '.' .. ver.minor .. '.' .. ver.patch
terumisc.mod_name = "terumisc"

-- this isn't the suggested way to check for game version but... it works for my purposes
terumisc.legacy = minetest.get_version().string:find('0.4')

if terumisc.legacy then
    minetest.log('[terumisc] MTv0.4.* detected - in legacy mode!')
end

-- terumisc.RAND = PcgRandom(os.time())

--[[ function terumet.chance(pct)
    if pct <= 0 then return false end
    if pct >= 100 then return true end
    return terumet.RAND:next(1,100) <= pct
end ]]

terumisc.NO_FUNCTION = function() end
terumisc.EMPTY = {}
terumisc.ZERO_XYZ = {x=0,y=0,z=0}

function terumisc.do_lua_file(name)
    dofile(minetest.get_modpath(terumisc.mod_name) .. '/' .. name .. '.lua')
end

function terumisc.id(id, number)
    if number then
        return string.format('%s:%s %d', terumisc.mod_name, id, number)
    else
        return string.format('%s:%s', terumisc.mod_name, id)
    end
end

function terumisc.push(tbl, item)
    tbl[#tbl+1]=item
end

function terumisc.tex(id)
    -- accepts both base ids (assuming this mod) and full mod ids
    if id:match(':') then
        return string.format('%s.png', id:gsub(':', '_'))
    else
        return string.format('%s_%s.png', terumisc.mod_name, id)
    end
end

function terumisc.recipe_3x3(i)
    return {
        {i, i, i}, {i, i, i}, {i, i, i}
    }
end

function terumisc.clone_table(t)
    local c_t = {}
    for i,v in ipairs(t) do
        if type(v) == 'table' then
            c_t[i] = terumisc.clone_table(v)
        else
            c_t[i] = v
        end
    end
    for k,v in pairs(t) do
        if type(v) == 'table' then
            c_t[k] = terumisc.clone_table(v)
        else
            c_t[k] = v
        end
    end
    return c_t
end

terumisc.DYE_COLORS = {}
terumisc.do_lua_file('charcoal')

terumisc.do_lua_file('dyes')

terumisc.do_lua_file('ice')

terumisc.do_lua_file('walls')

terumisc.do_lua_file('nodelamp')

terumisc.do_lua_file('concrete')

local OPTIONAL = {'trunks', 'terumet'}
for _,mod in ipairs(OPTIONAL) do
    if minetest.get_modpath(mod) then
        terumisc.do_lua_file(mod)
    end
end
