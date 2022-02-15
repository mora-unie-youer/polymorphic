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

local function finish(step, thread, callback, ...)
	local ok = select(1, ...)
	if not ok then
		local msg = select(2, ...)
		log.fmt_error('The coroutine failed with message: %s', msg)
	end

	if coroutine.status(thread) == 'dead' then
		(callback or function() end)(select(2, ...))
	else
		assert(select('#', select(2, ...)) == 1, 'Expected a single return value')
		local async = select(2, ...)
		assert(type(async) == 'function', 'Expected function, got ' .. type(async))
		async(step)
	end
end

local function execute(async, callback, ...)
	assert(type(async) == 'function', 'Expected function, got ' .. type(async))

	local thread = coroutine.create(async)
	
	local step = function(...)
		finish(step, thread, callback, coroutine.resume(thread, ...))
	end

	step(...)
end

function A.wrap(func, argc)
	assert(type(func) == 'function', 'Expected function, got ' .. type(func))
	assert(type(argc) == 'number',   'Expected number, got ' .. type(func))

	return function(...)
		local params = { ... }

		local function future(step)
			if step then
				assert(argc == #params or argc == -1, 'Incorrect number of arguments')
				-- Inserting step function at the end
				table.insert(params, step)
				-- Calling function
				return func(unpack(params))
			else
				return coroutine.yield(future)
			end
		end

		return future
	end
end

function A.run(async, callback)
	assert(type(async) == 'function', 'Expected function, got ' .. type(async))
	async(callback or function() end)
end

function A.await(async)
	assert(type(async) == 'function', 'Expected function, got ' .. type(async))
	async(nil)
end

return A
