return {
  'stevearc/aerial.nvim',
  cmd = { 'AerialOpen', 'AerialToggle' },
  keys = {
    {
      '<leader>ss',
      function()
        -- Keep LSP results asynchronous and complete, including on the first invocation.
        if vim.bo.filetype ~= 'python' and #vim.lsp.get_clients { bufnr = 0, method = 'textDocument/documentSymbol' } > 0 then
          Snacks.picker.lsp_symbols { filter = { default = require 'core.symbols' } }
        else
          require('aerial').snacks_picker()
        end
      end,
      desc = 'Goto Symbols',
    },
  },
  opts = {
    autojump = true,
    show_guides = true,
    attach_mode = 'global',
    filter_kind = require 'core.symbols',
    guides = {
      mid_item = '├╴',
      last_item = '└╴',
      nested_top = '│ ',
      whitespace = '  ',
    },
    backends = {
      ['_'] = { 'lsp', 'treesitter', 'markdown', 'man' },
      python = { 'treesitter' },
      rust = { 'lsp' },
    },
  },
}
