vim.opt_local.makeprg = 'zig build run'
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2

local esc = vim.api.nvim_replace_termcodes('<Esc>', true, true, true)
local cr = vim.api.nvim_replace_termcodes('<CR>', true, true, true)
-- yanks and shoves into print statement when @l is pressed, for a poor mans snippet
vim.fn.setreg('l', 'yostd.debug.print("{s}\\n", .{' .. esc .. 'pA;' .. esc .. ':w' .. cr)
