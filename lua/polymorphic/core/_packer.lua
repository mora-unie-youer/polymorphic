local config = require('polymorphic.core.config')
pcall(require, config.path.compiled)

local present, packer = pcall(require, 'packer')
local first_run = false

if not present then
	local utils = require('polymorphic.utils')
	local path = config.path.data .. '/site/pack/packer/start/packer.nvim'
	first_run = true

	utils.logger:info('Cloning packer.nvim...')
	vim.fn.delete(packer_path, 'rf')
	vim.fn.system({ 'git', 'clone', '--depth=1',
		'https://github.com/wbthomason/packer.nvim', path })

	-- We need to unload the module, to load it again successfully
	utils.unload('packer')
	vim.api.nvim_command('packadd packer.nvim')
	present, packer = pcall(require, 'packer')

	if present then
		utils.logger:info('packer.nvim installed successfully!')
		first_run = true
	else
		error(("Couldn't install packer.nvim!\nPacker path: %s\n")
			:format(packer_path, packer))
	end
end

local packer_config = config.plugins.config['wbthomason/packer.nvim']
packer.init(packer_config)

return {
	packer = packer,
	first_run = first_run
}
