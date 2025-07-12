return {
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',
  keys = {
    { '<leader>sr', '<cmd>FzfLua resume<cr>', desc = 'Resume' },
    { '<leader>sg', '<cmd>FzfLua live_grep_native<cr>', desc = 'Grep' },
    { '<leader>sw', '<cmd>FzfLua grep_cword<cr>', desc = 'Grep word under cursor' },
    { '<leader>sf', '<cmd>FzfLua files<cr>', desc = 'Find files' },
    { '<leader><leader>', '<cmd>FzfLua buffers<cr>', desc = 'Find buffers' },
    { 'z=', '<cmd>FzfLua spell_suggest<cr>', desc = 'Spell suggest' },
    { '<leader>km', '<cmd>FzfLua keymaps<cr>', desc = 'View keymaps' },
    { '<leader>th', '<cmd>FzfLua colorschemes<cr>', desc = 'Colorschemes' },
    { '<leader>sh', '<cmd>FzfLua help_tags<cr>', desc = 'Help tags' },
    { '<leader>hg', '<cmd>FzfLua highlights<cr>', desc = 'Highlights' },
    { '<leader>ss', '<cmd>FzfLua lsp_document_symbols<cr>', desc = 'LSP document symbols' },
    { '<leader>sS', '<cmd>FzfLua lsp_workspace_symbols<cr>', desc = 'LSP workspace symbols' },
    { '<leader>ca', '<cmd>FzfLua lsp_code_actions<cr>', desc = 'LSP code actions' },
  },
  opts = {
    files = {
      previewer = false,
      winopts = {
        height = 0.40,
        width = 0.45,
        row = 0.5,
        col = 0.5,
      },
    },
    buffers = {
      previewer = false,
      color_icons = false,
      file_icons = false,
      winopts = {
        height = 0.40,
        width = 0.45,
        row = 0.5,
        col = 0.5,
      },
    },
    grep = {
      file_icons = false,
      color_icons = false,
      -- actions = {
      --   ['ctrl-r'] = { actions.toggle_ignore },
      -- },
    },
  },
}
