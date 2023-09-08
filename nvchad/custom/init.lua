local opt = vim.opt
local cmd = vim.api.nvim_command
local api = vim.api

-- Enable spell checking for certain file types
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.txt", "*.md", "*.tex" },
	callback = function()
		vim.opt.spell = true
		vim.opt.spelllang = "en"
	end,
})

-- resize neovim split when terminal is resized
cmd("autocmd VimResized * wincmd =")

opt.title = true
opt.titlestring = "%t%( %M%)" -- title, modified
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.updatetime = 250
opt.timeout = true
opt.timeoutlen = 300
opt.wildignore:append("*/node_modules/*")
opt.inccommand = "nosplit"
opt.ignorecase = true
opt.incsearch = true
opt.hlsearch = true
opt.cursorline = true
opt.lazyredraw = true -- Do not redraw during macros, good performance increase
opt.undolevels = 200
opt.scrolloff = 999
opt.clipboard = "unnamed,unnamedplus" -- make vim use system clipboard
opt.backspace = "indent,eol,start" -- make backspace work as expected
opt.swapfile = false -- disable the .swp files vim creates
opt.splitright = true -- open horizontal splits to the right
opt.splitbelow = true -- open vertical splits below
opt.signcolumn = "yes"

-- https://sw.kovidgoyal.net/kitty/faq/#using-a-color-theme-with-a-background-color-does-not-work-well-in-vim
vim.g.t_ut = ""
vim.g.t_AU = "\27[58:5:%dm"
vim.g.t_8u = "\27[58:2:%lu:%lu:%lum"
vim.g.t_Us = "\27[4:2m"
vim.g.t_Cs = "\27[4:3m"
vim.g.t_ds = "\27[4:4m"
vim.g.t_Ds = "\27[4:5m"
vim.g.t_Ce = "\27[4:0m"

-- Strikethrough
vim.g.t_Ts = "\27[9m"
vim.g.t_Te = "\27[29m"

-- Truecolor support
vim.g.t_8f = "\27[38:2:%lu:%lu:%lum"
vim.g.t_8b = "\27[48:2:%lu:%lu:%lum"
vim.g.t_RF = "\27]10;?\7"
vim.g.t_RB = "\27]11;?\7"

-- Bracketed paste
vim.g.t_BE = "\27[?2004h"
vim.g.t_BD = "\27[?2004l"

-- Cursor control
vim.g.t_RC = "\27[?12$p"
vim.g.t_SH = "\27[%d q"
vim.g.t_RS = "\27P$q q\7"
vim.g.t_SI = "\27[5 q"
vim.g.t_SR = "\27[3 q"
vim.g.t_EI = "\27[1 q"
vim.g.t_VS = "\27[?12l"

-- Focus tracking
vim.g.t_fe = "\27[?1004h"
vim.g.t_fd = "\27[?1004l"

-- Window title
vim.g.t_ST = "\27[22;2t"
vim.g.t_RT = "\27[23;2t"
