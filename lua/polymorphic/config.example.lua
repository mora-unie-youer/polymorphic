--
--  This is example of your polymorphic configuration.
--  It can be used for changing NeoVim settings, adding new plugins to
-- polymorphic without changing the core, or for creating your own key mappings
-- (or disabling default mappings for plugins). Also you can configure some
-- plugins using 'config' table.
--

-- This is your 'config' table.
local config = {
	-- This is table where you can set NeoVim settings
	-- (or some plugins, which use g: variables)
	editor = {
		-- There are some examples how you can do this:
		--
		-- termguicolors = true,
		-- cmdheight = 2,
		-- ['g:some_cool_variable'] = some_value
	},

	-- This is table where you can add/replace NeoVim mappings
	keymappings = {
		-- There are some examples how you can do this:
		--
		-- ['n|<C-Up>'] = ':resize -2<CR>',
		-- ['inv|<C-Down>'] = ':resize +2<CR>',
		-- ['n|<C-s>'] = function()
		-- 	print('Hello, world!')
		-- end
	},

	-- This is table where you can add, configure or disable some plugins
	plugins = {
		-- This is table, where you can list plugins you want to add.
		add = {
			-- There are some examples how you can do this:
			-- (You can also check packer.nvim documentation)
			--
			-- 'some-github-user/repository1',
			-- {
			-- 	'some-github-user/repository2',
			-- 	event = 'BufRead',
			-- 	branch = 'develop',
			-- 	ft = 'go'
			-- 	-- config field is not needed - it will be
			-- 	-- loaded from config.plugins.config
			-- }
		},

		--  This is table, where you can write own configuration
		-- table/function/string for plugin. If it's function/string,
		-- is will be runned by packer.nvim, if it's table, it will be
		-- used by <plugin>.setup (but you have to specify lua module,
		-- if it differs from name of plugin)
		config = {
			-- There are some examples how you can do this:
			--
			-- (Default polymorphic plugins support only tables)
			-- ['mhartington/formatter.nvim'] = {
			-- 	...
			-- }
			--
			-- (Your own additional plugins)
			-- ['some-github/repository1'] = 'vim.cmd[[SomeCmd]]',
			-- ['some-github/repository2'] = function()
			-- 	print('Hello, world!')
			-- end,
			-- ['some-github/repository3'] = {
			-- 	some_config_field = 1,
			-- 	some_another_field = 2
			-- },
			-- ['some-github/repository4-fork'] = {
			-- 	'repository4',
			-- 	{
			-- 		some_config_field = 1,
			-- 		some_another_field = 2
			-- 	}
			-- }
		},

		--  This is table, where you can disable some default
		-- polymorphic plugins
		disable = {
			-- There is example how you can do this:
			--
			-- 'mhartington/formatter.nvim'
		},
	},

	-- This is the field, which can control your NeoVim colorscheme
	-- For now you can choose from these colorschemes:
	--   neovim         Default theme, as if there was no config at all
	--   neovim:<theme> Built-in neovim theme
	theme = 'neovim',
}

-- Making this file usable by polymorphic core
return config
