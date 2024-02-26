return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = {
    extensions = {
      'fugitive',
      'lazy',
      'trouble',
    },
    options = {
      icons_enabled = false,
      theme = 'auto',
      component_separators = '|',
      section_separators = { left = '█', right = '█' },
      disabled_filetypes = { 'NvimTree' },
      globalstatus = true,
    },
    sections = {
      lualine_a = {},
      lualine_b = { 'branch', 'diff', 'fugitive' },
      lualine_c = {
        {
          'filename',
          path = 1, -- Relative path
        },
      },
      lualine_x = { 'lazy' },
      lualine_y = {},
      lualine_z = { 'diagnostics', 'trouble' },
    },
  },
}
