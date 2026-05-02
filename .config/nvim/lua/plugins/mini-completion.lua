return {
  'nvim-mini/mini.completion',
  version = false,
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {},
  config = function(_, opts)
    require('mini.completion').setup(opts)
  end,
}
