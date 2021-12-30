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

local L = {}

function L.new()
	local file = ('%s/%s.log'):format(vim.fn.stdpath('data'), 'polymorphic')

	local obj = L

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

	local function log(message_builder, ...)
		local msg = message_builder(...)
		local info = debug.getinfo(2, 'Sl')
		local line = info.short_src .. ':' .. info.currentline

		local fp = io.open(file, 'w')
		local str = string.format('[%s] %s: %s\n', os.date(), line, msg)
		fp:write(str)
		fp:close()
	end

	function obj.info(...)
		return log(make_string, ...)
	end
end

L.new()

return L
