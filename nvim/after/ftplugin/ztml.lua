vim.filetype.add {
  extension = {
    ztml = 'ztml',
  },
}

vim.treesitter.language.register('html', 'ztml')
