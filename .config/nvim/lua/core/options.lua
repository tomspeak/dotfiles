vim.o.showmode = false
vim.o.ruler = false
vim.o.showcmd = false
vim.o.foldenable = false

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

vim.o.colorcolumn = '+0'
vim.opt.listchars = {
  nbsp = '␣',
  tab = '  ',
  trail = '·',
}

vim.o.pumheight = 15
vim.o.pumblend = 0
vim.o.pumborder = 'single'
vim.o.winborder = 'single'

-- Enable mouse mode
vim.o.mouse = 'a'

-- Save undo history
vim.o.undofile = true

-- Keep zg additions in the versioned personal dictionary.
vim.opt.spellfile = { vim.fn.stdpath 'config' .. '/spell/en.utf-8.add' }

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.title = true
vim.o.titlestring = '%t%( %M%)' -- title, modified
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 999
vim.o.scrolloffpad = 1
vim.o.clipboard = 'unnamed,unnamedplus' -- make vim use system clipboard
vim.o.swapfile = false -- disable the .swp files vim creates
vim.o.splitright = true -- open horizontal splits to the right
vim.o.splitbelow = true -- open vertical splits below
vim.opt.fillchars = {
  vert = '│',
  fold = '⠀',
  eob = ' ', -- suppress ~ at EndOfBuffer
  diff = '⣿',
  msgsep = ' ',
  foldopen = '▾',
  foldsep = '│',
  foldclose = '▸',
}
vim.opt.diffopt:append { vertical = true, linematch = 60 }

-- Set tabs to 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.copyindent = true
-- Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
vim.opt.breakindent = true

-- disable nvim intro
vim.opt.shortmess:append 'sI'
vim.opt.shortmess:append 'c'
