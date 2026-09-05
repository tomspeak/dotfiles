return {
  'nvim-mini/mini.completion',
  version = false,
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    window = {
      info = { height = 8, width = 60 },
    },
  },
  config = function(_, opts)
    require('mini.completion').setup(opts)
  end,
}
