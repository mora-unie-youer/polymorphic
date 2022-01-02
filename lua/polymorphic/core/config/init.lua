---[[---------------------------------------------------------------------]]---
--                     __                                 __    _            --
--        ____  ____  / /_  ______ ___  ____  _________  / /_  (_)____       --
--       / __ \/ __ \/ / / / / __ `__ \/ __ \/ ___/ __ \/ __ \/ / ___/       --
--      / /_/ / /_/ / / /_/ / / / / / / /_/ / /  / /_/ / / / / / /__         --
--     / .___/\____/_/\__, /_/ /_/ /_/\____/_/  / .___/_/ /_/_/\___/         --
--    /_/            /____/                    /_/                           --
--       NeoVim configuration which can make your dreams come true.          --
---[[---------------------------------------------------------------------]]---
--                        polymorphic.core.config                            --
--                    The heart of polymorphic config                        --
---[[---------------------------------------------------------------------]]---
--        Author: Mora Unie Youer <mora_unie_youer@riseup.net>               --
--          URLs: https://github.com/mora-unie-youer/polymorphic             --
--                https://gitlab.com/mora-unie-youer/polymorphic             --
--                https://notabug.org/mora-unie-youer/polymorphic            --
--       License: MIT                                                        --
---[[---------------------------------------------------------------------]]---

local log = require('polymorphic.extras.logging')
local system = require('polymorphic.core.system')

-- Polymorphic config table
local config = {
	config = {},
	source = nil,
}

-- Paths:
-- 1. ~/.config/polymorphic/polymorphic_config.lua (user config)
-- 2. stdpath('config')/polymorphic_config.lua (default config)
-- 3. stdpath('config')/polymorphic_config_fallback.lua (fallback config)
local config_file = '/polymorphic_config.lua'
local fallback_config = '/polymorphic_config_fallback.lua'
local user_config_path = system.polymorphic_config_root .. config_file
local default_config_path = system.polymorphic_root .. config_file
local fallback_config_path = system.polymorphic_root .. fallback_config
local ok, ret = xpcall(dofile, debug.traceback, user_config_path)
if ok then
	config.config = ret.config
	config.source = ret.source
else
	log.warn("Couldn't load user configuration")
	log.fmt_trace('Traceback:\n%s', ret)

	ok, ret = xpcall(dofile, debug.traceback, default_config_path)
	if ok then
		config.config = ret.config
		config.source = ret.source
	else
		log.error("Couldn't load default configuration")
		log.fmt_trace('Traceback:\n%s', ret)

		ok, ret = xpcall(dofile, debug.traceback, fallback_config_path)
		if ok then
			config.config = ret.config
			config.source = ret.source
		else
			log.fatal("Couldn't load fallback configuration")
			log.fmt_trace('Traceback:\n%s', ret)
		end
	end
end
log.fmt_debug('Using configuration: %s', config.source)

return config
