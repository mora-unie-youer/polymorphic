---[[---------------------------------------------------------------------]]---
--                     __                                 __    _            --
--        ____  ____  / /_  ______ ___  ____  _________  / /_  (_)____       --
--       / __ \/ __ \/ / / / / __ `__ \/ __ \/ ___/ __ \/ __ \/ / ___/       --
--      / /_/ / /_/ / / /_/ / / / / / / /_/ / /  / /_/ / / / / / /__         --
--     / .___/\____/_/\__, /_/ /_/ /_/\____/_/  / .___/_/ /_/_/\___/         --
--    /_/            /____/                    /_/                           --
--       NeoVim configuration which can make your dreams come true.          --
---[[---------------------------------------------------------------------]]---
--                   polymorphic.modules.built-in.pundle                     --
--                       Polymorphic plugins manager                         --
---[[---------------------------------------------------------------------]]---
--        Author: Mora Unie Youer <mora_unie_youer@riseup.net>               --
--          URLs: https://github.com/mora-unie-youer/polymorphic             --
--                https://gitlab.com/mora-unie-youer/polymorphic             --
--                https://notabug.org/mora-unie-youer/polymorphic            --
--       License: MIT                                                        --
---[[---------------------------------------------------------------------]]---

local log = require('polymorphic.extras.logging').new({ module = 'pundle' })

local cmd = vim.api.nvim_command

local P = {
	plugins = {},
	path = vim.fn.stdpath('data') .. '/site/pack/pundle',
}

local module = 'polymorphic.modules.built-in.pundle'
cmd("command! PundleClean   lua require('" .. module .. "').clean()")
cmd("command! PundleInstall lua require('" .. module .. "').install()")
cmd("command! PundleList    lua require('" .. module .. "').list()")
cmd("command! PundleSync    lua require('" .. module .. "').sync()")
cmd("command! PundleUpdate  lua require('" .. module .. "').update()")

function P.clean()
end

function P.install()
end

function P.list()
end

function P.sync()
end

function P.update()
end

function P.register(plugins)
	if not plugins then
		log.error('Provided nil instead of plugin list.')
		plugins = {}
	end

	for _, plugin in ipairs(plugins) do
		if type(plugin) == 'string' then
			plugin = { plugin }
		end

		if type(plugin) ~= 'table' then
			log.error(
				'Invalid plugin declaration (neither string nor table):\n%s',
				plugin
			)
		end

		local path = P.path .. (plugin.opt and '/opt/' or '/start/') .. plugin[1]
		P.plugins[plugin[1]] = {
			branch = plugin.branch,
			path = path,
			installed = vim.fn.isdirectory(dir) ~= 0,
			run = plugin.run,
			url = plugin.url or 'https://github.com/%s.git',
		}
	end
end

return P
