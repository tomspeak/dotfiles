return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = { 'NvimTreeToggle', 'NvimTreeOpen', 'NvimTreeFocus', 'NvimTreeFindFile', 'NvimTreeFindFileToggle' },
  opts = {
    -- don't disable netwr, we need it for :GBrowse (rhubarb/fugitive)
    disable_netrw = false,
    hijack_netrw = false,

    view = {
      width = 50,
      side = 'right',
      signcolumn = 'no',
    },

    git = {
      enable = true,
      ignore = false,
    },

    filters = {
      dotfiles = false,
      custom = { 'node_modules', '.DS_STORE' },
    },

    renderer = {
      root_folder_label = false,
      highlight_opened_files = 'none',
      group_empty = true,
      highlight_git = true,
      icons = {
        show = {
          git = false,
          file = false,
          folder = false,
        },
      },
    },

    tab = {
      sync = {
        open = true,
        close = true,
      },
    },
  },
}
