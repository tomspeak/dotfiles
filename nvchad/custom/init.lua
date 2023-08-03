local opt = vim.opt
local cmd = vim.api.nvim_command
-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--

opt.title = true
opt.titlestring = "%t%( %M%)" -- title, modified
opt.termguicolors = true
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
