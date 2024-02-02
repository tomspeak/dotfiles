return {
  'stevearc/aerial.nvim',
  cmd = { 'AerialOpen', 'AerialToggle' },
  opts = {
    keymaps = {
      ['j'] = 'actions.down_and_scroll',
      ['k'] = 'actions.up_and_scroll',
    },
    autojump = true,
    show_guides = true,
    attach_mode = 'global',
    guides = {
      mid_item = '├╴',
      last_item = '└╴',
      nested_top = '│ ',
      whitespace = '  ',
    },
    backends = {
      ['_'] = { 'treesitter', 'lsp', 'markdown', 'man' },
      python = { 'treesitter' },
      rust = { 'lsp' },
    },
  },
}
