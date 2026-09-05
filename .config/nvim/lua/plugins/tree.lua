return {
  'nvim-tree/nvim-tree.lua',
  cmd = { 'NvimTreeToggle', 'NvimTreeOpen', 'NvimTreeFocus', 'NvimTreeFindFile', 'NvimTreeFindFileToggle' },
  opts = {
    -- Keep netrw available for :GBrowse (rhubarb/fugitive).
    hijack_netrw = false,

    view = {
      width = 50,
      side = 'right',
      signcolumn = 'no',
    },

    filters = {
      git_ignored = false,
      custom = { '^node_modules$', '^[.]DS_Store$', '*.o', '*.d' },
    },

    renderer = {
      root_folder_label = false,
      group_empty = true,
      highlight_git = 'name',
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
