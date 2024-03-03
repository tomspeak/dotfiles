return {
  'akinsho/toggleterm.nvim',
  version = 'v2.*',
  keys = { '`' },
  opts = {
    open_mapping = [[`]],
    direction = 'float',
    hide_numbers = true,
    close_on_exit = true,
    shade_terminals = true,
    shading_factor = 2,
    persist_size = true,
    float_opts = {
      border = 'single',
      width = vim.o.columns - 100,
      height = vim.o.lines - 30,
      winblend = 0,
      highlights = {
        border = 'FloatBorder',
        background = 'NormalFloat',
      },
    },
  },
}
