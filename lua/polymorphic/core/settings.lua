---[[---------------------------------------------------------------------]]---
--                     __                                 __    _            --
--        ____  ____  / /_  ______ ___  ____  _________  / /_  (_)____       --
--       / __ \/ __ \/ / / / / __ `__ \/ __ \/ ___/ __ \/ __ \/ / ___/       --
--      / /_/ / /_/ / / /_/ / / / / / / /_/ / /  / /_/ / / / / / /__         --
--     / .___/\____/_/\__, /_/ /_/ /_/\____/_/  / .___/_/ /_/_/\___/         --
--    /_/            /____/                    /_/                           --
--       NeoVim configuration which can make your dreams come true.          --
---[[---------------------------------------------------------------------]]---
--                         polymorphic.core.settings                         --
--                        User's heart of polymorphic                        --
---[[---------------------------------------------------------------------]]---
--        Author: Mora Unie Youer <mora_unie_youer@riseup.net>               --
--          URLs: https://github.com/mora-unie-youer/polymorphic             --
--                https://gitlab.com/mora-unie-youer/polymorphic             --
--                https://notabug.org/mora-unie-youer/polymorphic            --
--       License: MIT                                                        --
---[[---------------------------------------------------------------------]]---

local log = require('polymorphic.extras.logging')
local config = require('polymorphic.core.config').config

local font = config.polymorphic.guifont..':h'..config.polymorphic.guifont_size
vim.opt.guifont = font
-- opt.guifont can to not work, if you use nerd font
-- Force loading, using rpcnotify
vim.fn.rpcnotify(0, 'Gui', 'Font', font, true)

if vim.fn.exists('+guicolors') == 1 then
	vim.opt.guicolors = true
end
vim.opt.termguicolors = true

vim.opt.swapfile = config.polymorphic.swap_files

vim.opt.number = config.polymorphic.line_number
vim.opt.relativenumber = config.polymorphic.relative_line_number

vim.opt.mouse = config.polymorphic.mouse and 'a'
vim.opt.showmode = config.polymorphic.show_mode

vim.opt.hidden = true
vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 100

vim.opt.colorcolumn = tostring(config.polymorphic.max_length)
vim.opt.copyindent = true
vim.opt.preserveindent = true
vim.opt.shiftwidth = config.polymorphic.indent
vim.opt.smartindent = true
vim.opt.softtabstop = config.polymorphic.indent
vim.opt.tabstop = config.polymorphic.indent
