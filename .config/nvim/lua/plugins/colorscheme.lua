return {
  {
    'f-person/auto-dark-mode.nvim',
    priority = 10000,
    lazy = false,
    dependencies = { 'nickkadutskyi/jb.nvim' },
    config = function(_, opts)
      vim.cmd.colorscheme 'jb'
      require('auto-dark-mode').setup(opts)
    end,
    opts = {
      update_interval = 30000,
    },
  },
  {
    'RostislavArts/naysayer.nvim',
    priority = 1000,
    lazy = false,
  },
  {
    'Yazeed1s/oh-lucy.nvim',
    priority = 1000,
    lazy = false,
  },
  {
    'nyoom-engineering/oxocarbon.nvim',
    priority = 1000,
    lazy = false,
  },
  {
    'Mofiqul/vscode.nvim',
    priority = 1000,
    lazy = false,
  },
  {
    'vague2k/vague.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'olimorris/onedarkpro.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'thesimonho/kanagawa-paper.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    opts = {
      styles = {
        italic = false,
      },
    },
  },
  {
    'datsfilipe/vesper.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      italics = {
        comments = false,
        keywords = false,
        functions = false,
        strings = false,
        variables = false,
      },
    },
  },
  {
    'oskarnurm/koda.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      colors = {
        dark = { bg = '#090909', line = '#1a1a1a' },
        moss = { bg = '#090d0e', line = '#151d1e' },
      },
    },
  },
  {
    'blazkowolf/gruber-darker.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      bold = false,
      italic = {
        strings = false,
      },
    },
  },
  {
    'nickkadutskyi/jb.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      integrations = {
        -- Match Ghostty's background to the statusbar while Neovim is open
        ghostty = true,
      },
    },
  },
}
