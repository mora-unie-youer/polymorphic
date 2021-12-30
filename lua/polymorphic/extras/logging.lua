---[[---------------------------------------------------------------------]]---
--                     __                                 __    _            --
--        ____  ____  / /_  ______ ___  ____  _________  / /_  (_)____       --
--       / __ \/ __ \/ / / / / __ `__ \/ __ \/ ___/ __ \/ __ \/ / ___/       --
--      / /_/ / /_/ / / /_/ / / / / / / /_/ / /  / /_/ / / / / / /__         --
--     / .___/\____/_/\__, /_/ /_/ /_/\____/_/  / .___/_/ /_/_/\___/         --
--    /_/            /____/                    /_/                           --
--       NeoVim configuration which can make your dreams come true.          --
---[[---------------------------------------------------------------------]]---
--                      polymorphic.extras.logging                           --
--                      Polymorphic logging module                           --
---[[---------------------------------------------------------------------]]---
--        Author: Mora Unie Youer <mora_unie_youer@riseup.net>               --
--          URLs: https://github.com/mora-unie-youer/polymorphic             --
--                https://gitlab.com/mora-unie-youer/polymorphic             --
--                https://notabug.org/mora-unie-youer/polymorphic            --
--       License: MIT                                                        --
---[[---------------------------------------------------------------------]]---

local system = require('polymorphic.core.system')

local logging_level = 'info'

local config_path = system.polymorphic_config_root .. '/polymorphic_config.lua'
local ok, ret = xpcall(dofile, debug.traceback, config_path)
if ok then
	logging_level = ret.config.polymorphic.logging
end

local default_config = {
	-- Name of the module where logging. Prepended to log messages
	module = 'polymorphic',

	-- Print logs to console
	use_console = true,

	-- Use highlighting in console
	highlights = true,

	-- Write logs to file
	use_file = true,

	-- Logs above this level will be logged
	level = logging_level,

	-- Level configuration
	modes = {
		{ name = 'trace', hl = 'Comment' },
		{ name = 'debug', hl = 'Comment' },
		{ name = 'info',  hl = 'None' },
		{ name = 'warn',  hl = 'WarningMsg' },
		{ name = 'error', hl = 'ErrorMsg' },
		{ name = 'fatal', hl = 'ErrorMsg' }
	}
}

local L = {}

function L.new(config, standalone)
	local file = ('%s/%s.log'):format(vim.fn.stdpath('data'), 'polymorphic')

	local obj
	if standalone then
		obj = L
	else
		obj = {}
	end

	local levels = {}
	for i, v in ipairs(config.modes) do
		levels[v.name] = i
	end

	local function make_string(...)
		local t = {}
		for i = 1, select('#', ...) do
			local x = select(i, ...)

			if type(x) == 'table' then
				x = vim.inspect(x)
			else
				x = tostring(x)
			end

			table.insert(t, x)
		end
		return table.concat(t, ' ')
	end

	local console = vim.schedule_wrap(function(level, info, name, msg)
		local line = string.format(
			'%s:%s',
			vim.fn.fnamemodify(info.short_src, ':t'),
			info.currentline
		)

		local msg_string = string.format(
			'[%-6s%s] %s: %s',
			name,
			os.date('%H:%M:%S'),
			line,
			msg
		)

		if config.highlights and level.hl then
			vim.api.nvim_command(string.format(
				'echohl %s',
				level.hl
			))
		end

		local split = vim.split(msg_string, '\n')
		for _, v in ipairs(split) do
			vim.api.nvim_command(string.format(
				[[echom "[%s] %s"]],
				config.module,
				vim.fn.escape(v, '"')
			))
		end

		if config.highlights and level.hl then
			vim.api.nvim_command('echohl None')
		end
	end)

	local function log_at_level(level, level_info, message_builder, ...)
		-- If we're below the level in config, returning
		if level < levels[config.level] then return end
		local name = level_info.name:upper()

		local msg = message_builder(...)
		local info = debug.getinfo(2, 'Sl')
		local line = info.short_src .. ':' .. info.currentline

		if config.use_console then
			console(level_info, info, name, msg)
		end

		if config.use_file then
			local fp = io.open(file, 'a')
			local str = string.format(
				'[%-6s%s] %s: %s\n',
				name,
				os.date(),
				line,
				msg
			)
			fp:write(str)
			fp:close()
		end
	end

	for i, x in ipairs(config.modes) do
		obj[x.name] = function(...)
			return log_at_level(i, x, make_string, ...)
		end

		obj[('fmt_%s'):format(x.name)] = function(...)
			return log_at_level(i, x, function(...)
				local passed = { ... }
				local fmt = table.remove(passed, 1)
				local inspected = {}
				for _, v in ipairs(passed) do
					if type(v) ~= 'string' then v = vim.inspect(v) end
					table.insert(inspected, v)
				end

				local unpack = unpack or table.unpack
				return string.format(fmt, unpack(inspected))
			end, ...)
		end
	end
end

L.new(default_config, true)

return L
