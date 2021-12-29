--
-- This file sets all options declared in default + user configurations.
--

local utils = require('polymorphic.utils')
local config = require('polymorphic.core.config')

for k, v in pairs(config.editor) do
	local ks = utils.split(k, ':')
	if #ks == 1 then
		vim.opt[k] = v
	elseif #ks == 2 then
		vim[ks[1]][ks[2]] = v
	else
		utils.logger:error(('Incorrect editor variable name: %s'):format(k))
	end
end

