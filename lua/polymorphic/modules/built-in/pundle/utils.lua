---[[---------------------------------------------------------------------]]---
--                     __                                 __    _            --
--        ____  ____  / /_  ______ ___  ____  _________  / /_  (_)____       --
--       / __ \/ __ \/ / / / / __ `__ \/ __ \/ ___/ __ \/ __ \/ / ___/       --
--      / /_/ / /_/ / / /_/ / / / / / / /_/ / /  / /_/ / / / / / /__         --
--     / .___/\____/_/\__, /_/ /_/ /_/\____/_/  / .___/_/ /_/_/\___/         --
--    /_/            /____/                    /_/                           --
--       NeoVim configuration which can make your dreams come true.          --
---[[---------------------------------------------------------------------]]---
--                 polymorphic.modules.built-in.pundle.utils                 --
--                      Useful functions used in pundle                      --
---[[---------------------------------------------------------------------]]---
--        Author: Mora Unie Youer <mora_unie_youer@riseup.net>               --
--          URLs: https://github.com/mora-unie-youer/polymorphic             --
--                https://gitlab.com/mora-unie-youer/polymorphic             --
--                https://notabug.org/mora-unie-youer/polymorphic            --
--       License: MIT                                                        --
---[[---------------------------------------------------------------------]]---

local log = require('polymorphic.extras.logging').new({ module = 'pundle' })
local async = require('polymorphic.modules.built-in.async')

local U = {}
local config = nil

function U.config(_config)
	config = _config
end

-- Function to set plugin's type ('local' or 'git' for now)
function U.guess_plugin_type(plugin)
	-- Checking if plugin name is directory
	if vim.fn.isdirectory(plugin[1]) ~= 0 then
		-- If directory found - we think it's local plugin
		plugin.type = 'local'
		plugin.url = plugin[1]
	else
		-- Otherwise we are using git plugin
		plugin.type = 'git'
		-- Using GitHub by default
		local git_url = plugin.git_url or 'https://github.com/%s.git'
		plugin.url = git_url:format(plugin[1])
	end
end

-- Returns plugin list according to file system
function U.installed_plugins()
	local function look_dir(path)
		local plugins = {}

		local handle = vim.loop.fs_opendir(path, nil, 50)
		if handle then
			local items = {}
			repeat
				items = vim.loop.fs_readdir(handle)
				for _, item in ipairs(items or {}) do
					table.insert(plugins, ('%s/%s'):format(path, item.name))
				end
			until not items
		end
		return plugins
	end

	return look_dir(config.path .. 'opt'), look_dir(config.path .. 'start')
end

-- Return missing plugin list ((opt + start) - installed)
function U.missing_plugins()
	return async(function(opt, start)
		local missing = {}
		for plugin_full_name, plugin in pairs(config.plugins) do
			local plugin_orig_name = plugin_full_name:match('/([%w-_.]+)$')
			local plugin_name = (plugin.as or plugin_orig_name)
			local plugin_opt = (plugin.opt and 'opt/' or 'start/')
			local plugin_path = config.path .. plugin_opt .. plugin_name
			local plugin_installed = vim.tbl_contains(
				plugin.opt and opt or start,
				plugin_path
			)

			if not plugin_installed then
				-- Checking if alias is used
				if plugin.as then
					local plugin_alt_path = config.path .. plugin_opt .. plugin_orig_name
					-- If plugin is installed with original name
					if vim.fn.isdirectory(plugin_alt_path) ~= 0 then
						log.fmt_debug(
							'Renaming installed plugin `%s` to its alias `%s`',
							plugin_orig_name,
							plugin.as
						)
						vim.loop.fs_rename(plugin_alt_path, plugin_path)
						async():await()
					end
				else
					table.insert(missing, plugin_full_name)
				end
			end
		end

		return missing
	end)
end

-- Return all plugins list (opt, start and missing)
function U.get_plugins()
	return async(function()
		local opt, start = U.installed_plugins()
		local missing = U.missing_plugins():await(opt, start)
		return { missing = missing, start = start, opt = opt }
	end)
end

return U
