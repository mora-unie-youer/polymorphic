--
-- This file contains logger module, which can be used for info, warnings, etc.
--

local Logger = {}
Logger.__index = Logger

function Logger:trace(msg, opts)
	opts = opts or {}
	vim.notify(msg, vim.log.levels.TRACE, opts)
end

function Logger:debug(msg, opts)
	opts = opts or {}
	vim.notify(msg, vim.log.levels.DEBUG, opts)
end

function Logger:info(msg, opts)
	opts = opts or {}
	vim.notify(msg, vim.log.levels.INFO, opts)
end

function Logger:warn(msg, opts)
	opts = opts or {}
	vim.notify(msg, vim.log.levels.WARN, opts)
end

function Logger:error(msg, opts)
	opts = opts or {}
	vim.notify(msg, vim.log.levels.ERROR, opts)
end

return Logger
