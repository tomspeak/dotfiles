local diagnostics = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  sections = { 'error', 'warn', 'info', 'hint' },
  colored = false,
  update_in_insert = false,
  always_visible = false,
}

return {
  'nvim-lualine/lualine.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    extensions = {
      'fugitive',
      'lazy',
      'trouble',
      'aerial',
      'quickfix',
      'nvim-dap-ui',
    },
    options = {
      icons_enabled = false,
      theme = 'gruvbox-material',
      component_separators = '|',
      section_separators = { left = '█', right = '█' },
      disabled_filetypes = { 'NvimTree' },
      globalstatus = true,
    },
    sections = {
      lualine_a = {},
      lualine_b = { 'branch', 'diff' },
      lualine_c = {
        {
          'filename',
          path = 1, -- Relative path
        },
      },
      lualine_x = { 'lazy' },
      lualine_y = {},
      lualine_z = { diagnostics },
    },
  },
}
