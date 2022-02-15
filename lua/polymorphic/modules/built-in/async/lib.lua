---[[---------------------------------------------------------------------]]---
--                     __                                 __    _            --
--        ____  ____  / /_  ______ ___  ____  _________  / /_  (_)____       --
--       / __ \/ __ \/ / / / / __ `__ \/ __ \/ ___/ __ \/ __ \/ / ___/       --
--      / /_/ / /_/ / / /_/ / / / / / / /_/ / /  / /_/ / / / / / /__         --
--     / .___/\____/_/\__, /_/ /_/ /_/\____/_/  / .___/_/ /_/_/\___/         --
--    /_/            /____/                    /_/                           --
--       NeoVim configuration which can make your dreams come true.          --
---[[---------------------------------------------------------------------]]---
--                  polymorphic.modules.built-in.async.lib                   --
--                          'Low level' async API                            --
---[[---------------------------------------------------------------------]]---
--        Author: Mora Unie Youer <mora_unie_youer@riseup.net>               --
--          URLs: https://github.com/mora-unie-youer/polymorphic             --
--                https://gitlab.com/mora-unie-youer/polymorphic             --
--                https://notabug.org/mora-unie-youer/polymorphic            --
--       License: MIT                                                        --
---[[---------------------------------------------------------------------]]---

local log = require('polymorphic.extras.logging').new({ module = 'async' })
local unpack = unpack or table.unpack

local A = {}

function A.wrap(func, argc)
	assert(type(func) == 'function', 'Expected function, got ' .. type(func))
	assert(type(argc) == 'number',   'Expected number, got ' .. type(func))

	return function(...)
		local params = { count = select('#', ...), ... }

		local function future(step)
			if step then
				-- If count of arguments is variadic
				if argc == -1 then
					table.insert(params, step)
					params.count = params.count + 1
				else
					params[argc] = step
					params.count = argc
				end
				-- Calling function
				return func(unpack(params))
			else
				return coroutine.yield(future)
			end
		end

		return future
	end
end

return A
