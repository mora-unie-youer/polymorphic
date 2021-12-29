--
-- This file contains default polymorphic configuration
--

local utils = require('polymorphic.utils')

local default_config = {
	editor = {},
	keymappings = {},
	plugins = {
		add = {},
		config = {},
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
