---[[---------------------------------------------------------------------]]---
--                     __                                 __    _            --
--        ____  ____  / /_  ______ ___  ____  _________  / /_  (_)____       --
--       / __ \/ __ \/ / / / / __ `__ \/ __ \/ ___/ __ \/ __ \/ / ___/       --
--      / /_/ / /_/ / / /_/ / / / / / / /_/ / /  / /_/ / / / / / /__         --
--     / .___/\____/_/\__, /_/ /_/ /_/\____/_/  / .___/_/ /_/_/\___/         --
--    /_/            /____/                    /_/                           --
--       NeoVim configuration which can make your dreams come true.          --
---[[---------------------------------------------------------------------]]---
--                           polymorphic.modules                             --
--                    The extendable heart of polymorphic                    --
---[[---------------------------------------------------------------------]]---
--        Author: Mora Unie Youer <mora_unie_youer@riseup.net>               --
--          URLs: https://github.com/mora-unie-youer/polymorphic             --
--                https://gitlab.com/mora-unie-youer/polymorphic             --
--                https://notabug.org/mora-unie-youer/polymorphic            --
--       License: MIT                                                        --
---[[---------------------------------------------------------------------]]---

local log = require('polymorphic.extras.logging')

-- packer.nvim path
local path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
local first_install = false
if vim.fn.empty(vim.fn.glob(path)) > 0 then
	log.info('Bootstrapping packer.nvim...')
	vim.fn.system({
		'git', 'clone', '--depth=1',
		'https://github.com/wbthomason/packer.nvim', path
	})
	first_install = true
end

log.debug('Loading packer.nvim')
vim.cmd([[packadd packer.nvim]])
local packer = require('packer')

-- Initializing packer.nvim
packer.init({
	git = {
		clone_timeout = 300,
		subcommands = {
			install = 'clone --depth=%i --progress',
		},
	},
	profile = {
		enable = true,
	},
})

packer.startup(function(use)
	--- Essentials
	-- Plugin manager
	use { 'wbthomason/packer.nvim', opt = true }
	-- Speed up startups
	use { 'lewis6991/impatient.nvim', 'nathom/filetype.nvim' }
	-- Useful library, used by many plugins
	use { 'nvim-lua/plenary.nvim' }

	-- Sync if it's first install
	if first_install then
		log.info('Syncing the plugins at the fresh install...')
		packer.sync()
	end
end)
