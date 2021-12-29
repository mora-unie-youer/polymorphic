--                   __                                 __    _     
--      ____  ____  / /_  ______ ___  ____  _________  / /_  (_)____
--     / __ \/ __ \/ / / / / __ `__ \/ __ \/ ___/ __ \/ __ \/ / ___/
--    / /_/ / /_/ / / /_/ / / / / / / /_/ / /  / /_/ / / / / / /__  
--   / .___/\____/_/\__, /_/ /_/ /_/\____/_/  / .___/_/ /_/_/\___/  
--  /_/            /____/                    /_/                    
--     NeoVim configuration which can make your dreams come true.
--
--        Author: Mora Unie Youer <mora_unie_youer@riseup.net>
--          URLs: https://github.com/mora-unie-youer/polymorphic
--                https://gitlab.com/mora-unie-youer/polymorphic
--                https://notabug.org/mora-unie-youer/polymorphic
--       License: MIT

if vim.fn.has('nvim-0.6') == 0 then
	error('Need NeoVim 0.6 to run polymorphic configuration!')
end

do
	local ok, _ = pcall(require, 'impatient')

	if not ok then
		vim.notify('impatient.nvim is not installed', vim.log.levels.WARN)
	end
end

local ok, err = pcall(require, 'polymorphic.core')
if not ok then
	error(('Core loading failed...\n\n%s'):format(err))
end
