--
-- This file contains default polymorphic configuration
--

local utils = require('polymorphic.utils')

local default_config = {
	editor = {
		['g:mapleader'] = ',',
		['g:maplocalleader'] = '.',

		backspace = { 'eol', 'start', 'indent' },
		clipboard = 'unnamedplus',
		encoding = 'utf-8',
		fileformats = { 'unix', 'mac', 'dos' },
		matchpairs = { '(:)', '{:}', '[:]', '<:>' },
		syntax = 'enable',

		autoindent = true,
		expandtab = false,
		shiftround = true,
		shiftwidth = 2,
		smartindent = true,
		softtabstop = 2,
		tabstop = 2,

		hlsearch = true,
		ignorecase = true,
		incsearch = true,
		smartcase = true,
		wildignore = { '*/.git/*', '*/node_modules/*' },
		wildmenu = true,
		wrapscan = true,

		cursorline = true,
		laststatus = 2,
		lazyredraw = true,
		list = true,
		listchars = {
			tab = '|-',
			trail = '·',
			lead = '·',
			extends = '»',
			precedes = '«',
			nbsp = '×'
		},
		mouse = 'a',
		number = true,
		relativenumber = false,
		scrolloff = 18,
		showmode = false,
		sidescrolloff = 3,
		signcolumn = 'yes',
		splitbelow = true,
		splitright = true,
		wrap = false,

		backup = false,
		swapfile = false,
		writebackup = false,

		redrawtime = 1500,
		timeout = true,
		timeoutlen = 250,
		ttimeout = true,
		ttimeoutlen = 10,
		updatetime = 100,

		colorcolumn = '80',
		errorbells = true,
		termguicolors = true,
		visualbell = true
	},
	keymappings = {},

	plugins = {
		add = {},
		config = {
			['wbthomason/packer.nvim'] = {
				git = {
					clone_timeout = 600,
				},
				auto_clean = true,
				compile_on_sync = true,
			}
		},
		disable = {},
	},
	theme = 'neovim',

	-- Global variables
	path = {},
}

function default_config:load_global_variables()
	self.path.config = vim.fn.stdpath('config')
	self.path.data = vim.fn.stdpath('data')

	self.path.polymorphic = self.path.config .. '/lua/polymorphic'
	self.path.user_config = self.path.polymorphic .. '/config.lua'

	self.path.home = os.getenv('HOME')
	self.path.cache = self.path.home .. '/.cache/nvim'

	self.path.compiled = self.path.polymorphic .. '/_compiled.lua'
	self.path.packer = self.path.data .. '/site/pack/packer/start/packer.nvim'
	self.plugins.config['wbthomason/packer.nvim'].compile_path = self.path.compiled
end
default_config:load_global_variables()

-- Checking if user configuration is available
if vim.fn.filereadable(default_config.path.user_config) == 0 then
	utils.logger:warn('User config was not created. Copying it from example...')

	local user_config_example = default_config.path.polymorphic .. '/config.example.lua'
	local ok = utils.io.copy(user_config_example, default_config.path.user_config)
	if not ok then
		utils.logger:error("Couldn't create user configuration.")
	end
end

local user_config = require('polymorphic.config')
local config = utils.merge(default_config, user_config)

return config
