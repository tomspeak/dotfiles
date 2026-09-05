return {
  'nvim-mini/mini.completion',
  version = false,
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    -- Mini's documented opt-out for automatic signatures; use native <C-s>.
    delay = { signature = 10 ^ 7 },
    window = {
      info = { height = 8, width = 60 },
    },
  },
  config = function(_, opts)
    require('mini.completion').setup(opts)
  end,
}
