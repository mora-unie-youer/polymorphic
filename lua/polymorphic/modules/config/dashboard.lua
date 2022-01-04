---[[---------------------------------------------------------------------]]---
--                     __                                 __    _            --
--        ____  ____  / /_  ______ ___  ____  _________  / /_  (_)____       --
--       / __ \/ __ \/ / / / / __ `__ \/ __ \/ ___/ __ \/ __ \/ / ___/       --
--      / /_/ / /_/ / / /_/ / / / / / / /_/ / /  / /_/ / / / / / /__         --
--     / .___/\____/_/\__, /_/ /_/ /_/\____/_/  / .___/_/ /_/_/\___/         --
--    /_/            /____/                    /_/                           --
--       NeoVim configuration which can make your dreams come true.          --
---[[---------------------------------------------------------------------]]---
--                   polymorphic.modules.config.dashboard                    --
--                        Start screen configuration                         --
---[[---------------------------------------------------------------------]]---
--        Author: Mora Unie Youer <mora_unie_youer@riseup.net>               --
--          URLs: https://github.com/mora-unie-youer/polymorphic             --
--                https://gitlab.com/mora-unie-youer/polymorphic             --
--                https://notabug.org/mora-unie-youer/polymorphic            --
--       License: MIT                                                        --
---[[---------------------------------------------------------------------]]---

return function()
	vim.g.dashboard_custom_footer = {
		string.format(
			'polymorphic loaded in %.3f seconds.',
			vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time))
		),
	}

	vim.g.dashboard_custom_header = {
		[[                 __                                 __    _     ]],
		[[    ____  ____  / /_  ______ ___  ____  _________  / /_  (_)____]],
		[[   / __ \/ __ \/ / / / / __ `__ \/ __ \/ ___/ __ \/ __ \/ / ___/]],
		[[  / /_/ / /_/ / / /_/ / / / / / / /_/ / /  / /_/ / / / / / /__  ]],
		[[ / .___/\____/_/\__, /_/ /_/ /_/\____/_/  / .___/_/ /_/_/\___/  ]],
		[[/_/            /____/                    /_/                    ]],
	}
end
