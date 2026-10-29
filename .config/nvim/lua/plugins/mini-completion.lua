return {
  'nvim-mini/mini.completion',
  version = false,
  event = { 'BufReadPre', 'BufNewFile' },
  init = function()
    local completion_group = vim.api.nvim_create_augroup('user-completion-ui', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType' }, {
      group = completion_group,
      callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype
        local disabled = vim.bo[buf].buftype == 'prompt' or ft == 'snacks_picker_input' or ft == 'snacks_input'
        vim.b[buf].minicompletion_disable = disabled
      end,
    })
  end,
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
