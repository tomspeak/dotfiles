vim.filetype.add {
  extension = {
    ztml = 'html',
  },
}

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.ztml',
  callback = function()
    vim.bo.filetype = 'ztml'
    vim.treesitter.language.register('html', 'ztml')
  end,
})
