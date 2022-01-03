---[[---------------------------------------------------------------------]]---
--                     __                                 __    _            --
--        ____  ____  / /_  ______ ___  ____  _________  / /_  (_)____       --
--       / __ \/ __ \/ / / / / __ `__ \/ __ \/ ___/ __ \/ __ \/ / ___/       --
--      / /_/ / /_/ / / /_/ / / / / / / /_/ / /  / /_/ / / / / / /__         --
--     / .___/\____/_/\__, /_/ /_/ /_/\____/_/  / .___/_/ /_/_/\___/         --
--    /_/            /____/                    /_/                           --
--       NeoVim configuration which can make your dreams come true.          --
---[[---------------------------------------------------------------------]]---
--                     polymorphic.modules.built-in.async                    --
--                Attempt to provide some async to polymorphic               --
---[[---------------------------------------------------------------------]]---
--        Author: Mora Unie Youer <mora_unie_youer@riseup.net>               --
--          URLs: https://github.com/mora-unie-youer/polymorphic             --
--                https://gitlab.com/mora-unie-youer/polymorphic             --
--                https://notabug.org/mora-unie-youer/polymorphic            --
--       License: MIT                                                        --
---[[---------------------------------------------------------------------]]---

local log = require('polymorphic.extras.logging').new({ module = 'async' })

local yield = coroutine.yield
local resume = coroutine.resume
local create = coroutine.create

local A = {}

local function NOP() end
local function step(func, callback)
	local thread = create(func)

	local function tick(...)
		local ok, res = resume(thread, ...)
		if ok then
			if type(res) == 'function' then
				res(tick)
			else
				(callback or NOP)(res)
			end
		else
			log.fmt_error('Error in coroutine: %s', res);
			(callback or NOP)(nil)
		end
	end

	tick()
end

function A.wrap(func)
	return function(...)
		local params = { ... }
		return function(tick)
			table.insert(params, tick)
			return func(unpack(params))
		end
	end
end
A.sync = A.wrap(step)
A.wait = yield

return A
