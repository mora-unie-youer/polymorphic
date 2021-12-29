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

return U
