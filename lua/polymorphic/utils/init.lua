--
-- This file contains some useful functions for polymorphic config modules
--

local U = {}

function U.merge(...)
	return vim.tbl_deep_extend('force', ...)
end

return U
