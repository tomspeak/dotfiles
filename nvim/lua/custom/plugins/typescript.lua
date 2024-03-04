return {
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    ft = { 'typescript', 'typescriptreact' },
    opts = {},
  },

  {
    'dmmulroy/ts-error-translator.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    ft = { 'typescript', 'typescriptreact' },
  },
}
