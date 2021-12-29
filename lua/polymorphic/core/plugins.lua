local present, polymorphic_packer = pcall(require, 'polymorphic.core._packer')

if not present then
	print(polymorphic_packer)
	return false
end

local packer = polymorphic_packer.packer
local use = packer.use

local config = require('polymorphic.core.config')
return require('packer').startup(function()
	use { 'wbthomason/packer.nvim', 'lewis6991/impatient.nvim' }

	if polymorphic_packer.first_run then
		packer.sync()
	end
end)
