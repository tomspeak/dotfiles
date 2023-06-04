local opt = vim.opt
local cmd = vim.api.nvim_command

vim.cmd([[syntax enable]])

-- require("catppuccin").setup({
-- 	background = { -- :h background
-- 		light = "latte",
-- 		dark = "frappe",
-- 	},
-- })
-- vim.cmd("colorscheme catppuccin")
-- opt.background = "light"

require('github-theme').setup()
vim.cmd("colorscheme github_light_tritanopia")

opt.termguicolors = true
opt.tabstop = 2
opt.softtabstop = 2
-- spaces per tab (when shifting)
opt.shiftwidth = 2
-- always use spaces instead of tabs
opt.expandtab = true
opt.showmode = false

opt.completeopt = "menu,menuone,noselect"
opt.number = true
opt.relativenumber = true
opt.showmatch = true
opt.updatetime = 250
opt.timeout = true
opt.timeoutlen = 300

opt.wildignore:append("*/node_modules/*")

cmd("noswapfile")
opt.laststatus = 2

-- search
opt.inccommand = "nosplit"
opt.ignorecase = true
opt.incsearch = true
opt.hlsearch = true
-- indentation
vim.bo.autoindent = true
opt.autoindent = true
vim.bo.expandtab = true
opt.expandtab = true
vim.bo.shiftwidth = 2
opt.shiftwidth = 2
vim.bo.tabstop = 2
opt.tabstop = 2

opt.cursorline = true
-- Change default position of new splits
opt.splitbelow = true
opt.splitright = true

opt.signcolumn = "number"
opt.autoindent = true
opt.hidden = true
opt.autoread = true
opt.lazyredraw = true -- Do not redraw during macros, good performance increase
opt.diffopt = "vertical"
opt.mouse = "a"
opt.fillchars = ""
opt.wrap = true
opt.numberwidth = 2
opt.linespace = 4
opt.cursorline = true
opt.smartindent = true
opt.smarttab = true
opt.clipboard = "unnamedplus"
opt.scrolloff = 999
opt.title = true
opt.undolevels = 200
opt.visualbell = false
opt.errorbells = false
opt.ruler = true
opt.fillchars = {
	diff = "⣿", -- BOX DRAWINGS
	vert = "┃", -- HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
	fold = "─",
	msgsep = "‾",
	eob = " ", -- Hide end of buffer ~
	foldopen = "▾",
	foldsep = "│",
	foldclose = "▸",
}
