--
-- This file contains some useful functions for polymorphic config modules
--

local U = {}

U.io = require('polymorphic.utils.io')
U.logger = require('polymorphic.utils.logger')

function U.merge(...)
	return vim.tbl_deep_extend('force', ...)
end

return U
