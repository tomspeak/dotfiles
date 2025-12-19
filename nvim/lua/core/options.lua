vim.o.termguicolors = true

vim.o.showmode = false
-- hide file progress / col/line crap in cmd line
vim.cmd [[set noruler]]
-- hide key presses showing up in cmd line (e.g. Leader = <20>, etc.
vim.cmd [[set noshowcmd]]

-- Disable all folding
vim.cmd [[set nofoldenable]]

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

vim.o.fileignorecase = true
vim.o.colorcolumn = '+0'
vim.opt.listchars = {
  nbsp = '␣',
  tab = '  ',
  trail = '·',
}

vim.o.pumheight = 15
vim.o.winborder = 'single'

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
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect,noinsert,popup,fuzzy'

vim.o.title = true
vim.o.titlestring = '%t%( %M%)' -- title, modified
-- vim.o.wildignore:append("*/node_modules/*")
vim.o.inccommand = 'split'
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.cursorline = true
-- NOTE: lazyredraw disabled because it conflicts with inccommand live preview
-- vim.o.lazyredraw = true
vim.o.undolevels = 200
vim.o.scrolloff = 999
vim.o.clipboard = 'unnamed,unnamedplus' -- make vim use system clipboard
vim.o.backspace = 'indent,eol,start'    -- make backspace work as expected
vim.o.swapfile = false                  -- disable the .swp files vim creates
vim.o.splitright = true                 -- open horizontal splits to the right
vim.o.splitbelow = true                 -- open vertical splits below
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
vim.opt.diffopt = {
  'filler',
  'indent-heuristic',
  'linematch:60',
  'vertical',
}

-- Set tabs to 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.cmdheight = 1

vim.opt.autoindent = true
vim.opt.copyindent = true
-- Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
vim.opt.breakindent = true

-- disable nvim intro
vim.opt.shortmess:append 'sI'
