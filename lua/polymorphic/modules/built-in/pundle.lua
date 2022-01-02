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

local log = require('polymorphic.extras.logging')

local cmd = vim.api.nvim_command

local P = {}

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

return P
