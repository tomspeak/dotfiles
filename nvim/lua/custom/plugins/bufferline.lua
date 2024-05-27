return {
  'akinsho/bufferline.nvim',
  tag = 'v4.6.1',
  branch = 'main',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    local bufferline = require 'bufferline'

    bufferline.setup {
      options = {
        mode = 'buffers',
        style_preset = {
          bufferline.style_preset.no_italics,
          bufferline.style_preset.no_bold,
          bufferline.style_preset.minimal,
        },
        separator_style = 'thin',
        indicator = {
          style = 'none',
        },
        sort_by = 'insert_after_current',
        themable = true,
        diagnostics = 'nvim_lsp',
        always_show_bufferline = true,
        modified_icon = '*',
        show_close_icon = false,
        close_icon = '',
        show_buffer_close_icons = false,
        offsets = {
          { filetype = 'NvimTree', text = '', highlight = 'Directory', separator = true },
        },
      },
    }
  end,
}
