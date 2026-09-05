return {
  'stevearc/aerial.nvim',
  cmd = { 'AerialOpen', 'AerialToggle' },
  opts = {
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
