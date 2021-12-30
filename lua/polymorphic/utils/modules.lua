---[[---------------------------------------------------------------------]]---
--                     __                                 __    _            --
--        ____  ____  / /_  ______ ___  ____  _________  / /_  (_)____       --
--       / __ \/ __ \/ / / / / __ `__ \/ __ \/ ___/ __ \/ __ \/ / ___/       --
--      / /_/ / /_/ / / /_/ / / / / / / /_/ / /  / /_/ / / / / / /__         --
--     / .___/\____/_/\__, /_/ /_/ /_/\____/_/  / .___/_/ /_/_/\___/         --
--    /_/            /____/                    /_/                           --
--       NeoVim configuration which can make your dreams come true.          --
---[[---------------------------------------------------------------------]]---
--                      polymorphic.utils.modules                            --
--                 Module to manage polymorphic modules                      --
---[[---------------------------------------------------------------------]]---
--        Author: Mora Unie Youer <mora_unie_youer@riseup.net>               --
--          URLs: https://github.com/mora-unie-youer/polymorphic             --
--                https://gitlab.com/mora-unie-youer/polymorphic             --
--                https://notabug.org/mora-unie-youer/polymorphic            --
--       License: MIT                                                        --
---[[---------------------------------------------------------------------]]---

local log = require('polymorphic.extras.logging')

local M = {}

function M.load_modules(module_path, modules)
	for _, module in ipairs(modules) do
		local mod = string.format('%s.%s', module_path, module)
		local ok, err = xpcall(require, debug.traceback, mod)

		if not ok then
			log.fmt_error(
				'There was an error loading the module `%s`. Traceback:\n%s',
				mod,
				err
			)
		else
			log.fmt_debug('Successfully loaded `%s` module', mod)
		end
	end
end

return M
