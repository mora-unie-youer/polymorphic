---[[---------------------------------------------------------------------]]---
--                     __                                 __    _            --
--        ____  ____  / /_  ______ ___  ____  _________  / /_  (_)____       --
--       / __ \/ __ \/ / / / / __ `__ \/ __ \/ ___/ __ \/ __ \/ / ___/       --
--      / /_/ / /_/ / / /_/ / / / / / / /_/ / /  / /_/ / / / / / /__         --
--     / .___/\____/_/\__, /_/ /_/ /_/\____/_/  / .___/_/ /_/_/\___/         --
--    /_/            /____/                    /_/                           --
--       NeoVim configuration which can make your dreams come true.          --
---[[---------------------------------------------------------------------]]---
--                    polymorphic.modules.built-in.pundle                    --
--                        Polymorphic plugins manager                        --
---[[---------------------------------------------------------------------]]---
--        Author: Mora Unie Youer <mora_unie_youer@riseup.net>               --
--          URLs: https://github.com/mora-unie-youer/polymorphic             --
--                https://gitlab.com/mora-unie-youer/polymorphic             --
--                https://notabug.org/mora-unie-youer/polymorphic            --
--       License: MIT                                                        --
---[[---------------------------------------------------------------------]]---

local log = require('polymorphic.extras.logging').new({ module = 'pundle' })
local async = require('polymorphic.modules.built-in.async')

local cmd = vim.api.nvim_command

local P = {
	plugins = {},
	path = vim.fn.stdpath('data') .. '/site/pack/pundle/',
}

local module = 'polymorphic.modules.built-in.pundle'
cmd("command! PundleClean   lua require('" .. module .. "').clean()()")
cmd("command! PundleCompile lua require('" .. module .. "').compile()()")
cmd("command! PundleInstall lua require('" .. module .. "').install()()")
cmd("command! PundleStatus  lua require('" .. module .. "').status()()")
cmd("command! PundleSync    lua require('" .. module .. "').sync()()")
cmd("command! PundleUpdate  lua require('" .. module .. "').update()()")

local function require_and_configure(name)
	local full_module_name = string.format('%s.%s', module, name)
	-- Checking if module was loaded before
	local module_utils = require('polymorphic.utils.modules')
	-- Loading module
	local mod = require(full_module_name)
	-- If wasn't loaded before, configuring, if possible
	if not module_utils.module_loaded(full_module_name) and mod.config then
		mod.config(P)
	end
	return mod
end

function P.clean()
	return async(function()
	end)
end

function P.compile()
	return async(function()
	end)
end

function P.install()
	log.debug('Installing plugins...')

	return async(function()
		local utils = require_and_configure('utils')

		local plugins = utils.get_plugins():await()
		local missing = plugins.missing

		if #missing == 0 then
			log.info('All plugins are installed')
		end

		async():await()
		-- Doing installation
	end)
end

function P.status()
	return async(function()
	end)
end

function P.sync()
	return async(function()
	end)
end

function P.update()
	return async(function()
	end)
end

function P.register(plugins)
	local types = require_and_configure('types')
	local utils = require_and_configure('utils')

	if not plugins then
		log.error('Provided nil instead of plugin list.')
		plugins = {}
	end

	for _, plugin in ipairs(plugins) do
		if type(plugin) == 'string' then
			plugin = { plugin }
		end

		if type(plugin) ~= 'table' then
			log.fmt_error(
				'Invalid plugin declaration (neither string nor table): %s',
				plugin
			)
		end

		if type(plugin[1]) ~= 'string' then
			log.error('First field in plugin definition must be a string.')
		end

		-- Getting plugin type
		utils.guess_plugin_type(plugin)
		-- Loading installer for this type
		types[plugin.type].setup(plugin)

		-- Adding plugin to configuration (and removing plugin name from table)
		P.plugins[table.remove(plugin, 1)] = plugin
	end
end

return P
