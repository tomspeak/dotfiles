return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'BufReadPost',
  main = 'ibl',
  opts = {
    scope = {
      show_start = false,
    },
  },
}
