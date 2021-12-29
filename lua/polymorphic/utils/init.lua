--
-- This file contains some useful functions for polymorphic config modules
--

local U = {}

U.io = require('polymorphic.utils.io')
U.logger = require('polymorphic.utils.logger')

function U.merge(...)
	return vim.tbl_deep_extend('force', ...)
end

function U.split(str, sep)
	if sep == nil then sep = '%s' end
	local result = {}
	for w in str:gmatch('([^' .. sep .. ']*)') do
		if w ~= '' then table.insert(result, w) end
	end
	return result
end

function U.unload(module_pattern, reload)
	reload = reload or false
	for module, _ in pairs(package.loaded) do
		if module:match(module_pattern) then
			package.loaded[module] = nil
			if reload then require(module) end
		end
	end
end

return U
