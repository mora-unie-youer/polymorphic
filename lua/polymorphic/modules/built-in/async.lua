---[[---------------------------------------------------------------------]]---
--                     __                                 __    _            --
--        ____  ____  / /_  ______ ___  ____  _________  / /_  (_)____       --
--       / __ \/ __ \/ / / / / __ `__ \/ __ \/ ___/ __ \/ __ \/ / ___/       --
--      / /_/ / /_/ / / /_/ / / / / / / /_/ / /  / /_/ / / / / / /__         --
--     / .___/\____/_/\__, /_/ /_/ /_/\____/_/  / .___/_/ /_/_/\___/         --
--    /_/            /____/                    /_/                           --
--       NeoVim configuration which can make your dreams come true.          --
---[[---------------------------------------------------------------------]]---
--                    polymorphic.modules.built-in.async                     --
--               Attempt to provide some async to polymorphic                --
---[[---------------------------------------------------------------------]]---
--        Author: Mora Unie Youer <mora_unie_youer@riseup.net>               --
--          URLs: https://github.com/mora-unie-youer/polymorphic             --
--                https://gitlab.com/mora-unie-youer/polymorphic             --
--                https://notabug.org/mora-unie-youer/polymorphic            --
--       License: MIT                                                        --
---[[---------------------------------------------------------------------]]---

local log = require('polymorphic.extras.logging').new({ module = 'async' })

local async = {}
function async:new(func)
	-- Default asynchronous function wrapper
	local function step(func, cb, args)
		-- Creating new thread
		local thread = coroutine.create(func)

		local function tick(...)
			-- No operation
			local function NOP() end
			-- Executing thread
			local ok, res = coroutine.resume(thread, ...)
			if ok then
				if type(res) == 'function' then
					res(tick)
				else
					(cb or NOP)(res)
				end
			else
				log.fmt_error('Error in coroutine: %s', res);
				(cb or NOP)(nil)
			end
		end

		-- Running thread with arguments
		local unpack = unpack or table.unpack
		tick(unpack(args))
	end

	-- Asynchronous function object
	local obj = {}
	obj._args = nil
	obj._func = func
	obj._wrapper = step

	-- If 'func' is 'nil', then we want to vim.schedule()
	if not func then
		obj._thread = function(f) vim.schedule(f) end
	else
		obj._thread = function(tick)
			return obj._wrapper(obj._func, tick, obj._args)
		end
	end

	-- Set asynchronous function wrapper
	function obj:wrap(wrapper)
		obj._wrapper = wrapper
		return obj
	end

	-- Await for process
	function obj:await(...)
		obj._args = { ... }		
		return coroutine.yield(self._thread)
	end

	-- Run without awaiting
	function obj:run()
		return obj._thread()
	end

	-- Attaching metatable
	setmetatable(obj, self)
	self.__index = self

	-- Action when calling this table (running function)
	function self:__call(...)
		self._args = { ... }
		return self.run()
	end

	return obj
end

return setmetatable(async, {
	__call = function(_, func) return async:new(func) end
})
