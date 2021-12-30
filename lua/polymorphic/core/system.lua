---[[---------------------------------------------------------------------]]---
--                     __                                 __    _            --
--        ____  ____  / /_  ______ ___  ____  _________  / /_  (_)____       --
--       / __ \/ __ \/ / / / / __ `__ \/ __ \/ ___/ __ \/ __ \/ / ___/       --
--      / /_/ / /_/ / / /_/ / / / / / / /_/ / /  / /_/ / / / / / /__         --
--     / .___/\____/_/\__, /_/ /_/ /_/\____/_/  / .___/_/ /_/_/\___/         --
--    /_/            /____/                    /_/                           --
--       NeoVim configuration which can make your dreams come true.          --
---[[---------------------------------------------------------------------]]---
--                       polymorphic.core.system                             --
--                   Polymorphic system integration                          --
---[[---------------------------------------------------------------------]]---
--        Author: Mora Unie Youer <mora_unie_youer@riseup.net>               --
--          URLs: https://github.com/mora-unie-youer/polymorphic             --
--                https://gitlab.com/mora-unie-youer/polymorphic             --
--                https://notabug.org/mora-unie-youer/polymorphic            --
--       License: MIT                                                        --
---[[---------------------------------------------------------------------]]---

local S = {}
local stdpath = vim.fn.stdpath

local config = stdpath('config'):match('.*[/\\]'):sub(1, -2)

-- Separator symbol used in your operating system.
S.separator = package.config:sub(1, 1)

-- Works as fallback in case polymorphic_config_root directory doesn't exist.
S.polymorphic_root = stdpath('config')

-- The polymorphic configuration root directory
S.polymorphic_config_root = table.concat({ config, 'polymorphic' }, S.separator)

-- Checking if configuration directory doesn't exist.
if vim.fn.isdirectory(S.polymorphic_config_root) == 0 then
	S.polymorphic_config_root = stdpath('config')
end

-- Polymorphic logs file path
S.polymorphic_logs = table.concat({ stdpath('data'), 'polymorphic.log' }, S.separator)

return S
