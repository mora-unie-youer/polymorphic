---[[---------------------------------------------------------------------]]---
--                     __                                 __    _            --
--        ____  ____  / /_  ______ ___  ____  _________  / /_  (_)____       --
--       / __ \/ __ \/ / / / / __ `__ \/ __ \/ ___/ __ \/ __ \/ / ___/       --
--      / /_/ / /_/ / / /_/ / / / / / / /_/ / /  / /_/ / / / / / /__         --
--     / .___/\____/_/\__, /_/ /_/ /_/\____/_/  / .___/_/ /_/_/\___/         --
--    /_/            /____/                    /_/                           --
--       NeoVim configuration which can make your dreams come true.          --
---[[---------------------------------------------------------------------]]---
--                          polymorphic_config.lua                           --
--                    Polymorphic user configuration file                    --
---[[---------------------------------------------------------------------]]---
--        Author: Mora Unie Youer <mora_unie_youer@riseup.net>               --
--          URLs: https://github.com/mora-unie-youer/polymorphic             --
--                https://gitlab.com/mora-unie-youer/polymorphic             --
--                https://notabug.org/mora-unie-youer/polymorphic            --
--       License: MIT                                                        --
---[[---------------------------------------------------------------------]]---

local C = {}

C.source = debug.getinfo(1, 'S').source:sub(2)

C.config = {
	--  This table defines all the configurations that you can tweak to
	-- your needs.
	polymorphic = {
		-- Enable swap files
		-- @false: swap files are disabled
		-- @true: swap files are enabled
		-- @default = false
		swap_files = false,

		-- Undo
		-- backup enables undo settings (undofile, undodir)
		-- @false: disable undo features
		-- @true: enable undo file/dirs
		-- @default = false
		backup = false,

		-- Enable line wrapping
		-- @false: disable line wrapping
		-- @true: enable line wrapping
		-- @default = false
		line_wrap = false,

		-- Enable line numbering
		-- @false: disable line numbers
		-- @true: enable line numbers
		-- @default = true
		line_number = true,

		-- Set numering style
		-- @false: show absolute line numbers
		-- @true: show relative line numbers
		-- @default = false
		relative_line_number = false,

		-- Enable mouse
		-- @false: disable mouse
		-- @true: enable mouse
		mouse = true,

		-- Enable showing current mode
		-- @false: disable show mode
		-- @true: enable show mode
		-- @default = true
		show_mode = true,

		-- Indent size
		-- @default = 2
		indent = 2,

		-- Line length maximum
		-- Define the column to show a vertical marker
		-- @default = 80
		max_length = 80,

		--- Logging
		-- Set polymorphic logging level
		-- Available options: trace, debug, info, warn, error, fatal
		-- @default = info
		logging = 'info',

		--- GUI
		-- Set gui font here
		-- @default = 'FiraCode Nerd Font Mono', @default = 7
		guifont = 'FiraCode Nerd Font Mono',
		guifont_size = 7,
	},

	--  This table defines all custom configurations that you want to use
	-- in NeoVim, e.g. global variables.
	neovim = {},
}

return C
