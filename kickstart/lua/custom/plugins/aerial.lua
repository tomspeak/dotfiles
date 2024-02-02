return {
  'stevearc/aerial.nvim',
  cmd = { 'AerialOpen', 'AerialToggle' },
  opts = {
    keymaps = {
      ['j'] = 'actions.down_and_scroll',
      ['k'] = 'actions.up_and_scroll',
    },
    autojump = true,
    backends = {
      ['_'] = { 'treesitter', 'lsp', 'markdown', 'man' },
      python = { 'treesitter' },
      rust = { 'lsp' },
    },
  },
}
