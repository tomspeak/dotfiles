return {
  'folke/zen-mode.nvim',
  cmd = 'ZenMode',
  keys = {
    { '<leader>z', '<cmd>ZenMode<cr>', desc = 'Zen mode' },
  },
  opts = {
    window = {
      backdrop = 1,
      width = 80,
      height = 0.9,
      options = {
        signcolumn = 'no',
        number = false,
        relativenumber = false,
        cursorline = false,
        cursorcolumn = false,
        foldcolumn = '0',
        list = false,
      },
    },
    plugins = {
      options = {
        laststatus = 0,
        showcmd = false,
        ruler = false,
      },
      twilight = { enabled = false },
      gitsigns = { enabled = false },
      tmux = { enabled = true },
    },
    on_open = function()
      vim.opt_local.wrap = true
      vim.opt_local.linebreak = true
      vim.opt_local.spell = true
      vim.opt_local.conceallevel = 2
    end,
  },
}
