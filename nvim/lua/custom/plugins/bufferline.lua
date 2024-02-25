return {
  'akinsho/bufferline.nvim',
  tag = 'v4.5.0',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    options = {
      mode = 'buffers',
      diagnostics = 'nvim_lsp',
      always_show_bufferline = true,
      modified_icon = '*',
      close_icon = '',
      show_buffer_close_icons = false,

      offsets = {
        { filetype = 'NvimTree', text = '', highlight = 'Directory', separator = true },
      },
    },
  },
}
