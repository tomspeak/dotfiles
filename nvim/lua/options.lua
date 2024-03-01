vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.termguicolors = true

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.title = true
vim.o.titlestring = '%t%( %M%)' -- title, modified

-- vim.o.t_Co = 256
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
-- vim.o.wildignore:append("*/node_modules/*")
vim.o.inccommand = 'split'
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.cursorline = true
vim.o.lazyredraw = true -- Do not redraw during macros, good performance increase
vim.o.undolevels = 200
vim.o.scrolloff = 999
vim.o.clipboard = 'unnamed,unnamedplus' -- make vim use system clipboard
vim.o.backspace = 'indent,eol,start' -- make backspace work as expected
vim.o.swapfile = false -- disable the .swp files vim creates
vim.o.splitright = true -- open horizontal splits to the right
vim.o.splitbelow = true -- open vertical splits below
vim.opt.fillchars = {
  vert = '│',
  fold = '⠀',
  eob = ' ', -- suppress ~ at EndOfBuffer
  diff = '⣿',
  msgsep = '‾',
  foldopen = '▾',
  foldsep = '│',
  foldclose = '▸',
}

-- Set tabs to 2 spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.cmdheight = 1

-- Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
vim.opt.breakindent = true

-- disable nvim intro
vim.opt.shortmess:append 'sI'

-- Disable plugins shipped with neovim
vim.g.loaded_2html_plugin = 0
vim.g.loaded_gzip = 0
vim.g.loaded_matchit = 0
vim.g.loaded_tar = 0
vim.g.loaded_tarPlugin = 0
vim.g.loaded_tutor_mode_plugin = 0
vim.g.loaded_zip = 0
vim.g.loaded_zipPlugin = 0
