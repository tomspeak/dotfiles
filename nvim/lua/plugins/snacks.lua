return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    keys = {
      {
        '<leader>sf',
        function()
          Snacks.picker.files({
            finder = "files",
            format = "file",
            show_empty = true,
            supports_live = true,
            layout = "vscode",
          })
        end,
        desc = 'Find Files',
      },
      {
        '<leader><leader>',
        function()
          Snacks.picker.buffers({
            layout = "vscode",
            on_show = function()
              vim.cmd.stopinsert()
            end,
            finder = "buffers",
            format = "buffer",
            hidden = false,
            unloaded = true,
            current = true,
            sort_lastused = true,
            win = {
              input = {
                keys = {
                  ["d"] = "bufdelete",
                },
              },
              list = { keys = { ["d"] = "bufdelete" } },
            },
            -- In case you want to override the layout for this keymap
            -- layout = "ivy",
          })
        end,
        desc = 'Buffers',
      },
      -- find
      {
        '<leader>fc',
        function()
          Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
        end,
        desc = 'Find Config File',
      },
      {
        '<leader>sB',
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = 'Grep Open Buffers',
      },
      {
        '<leader>sg',
        function()
          Snacks.picker.grep()
        end,
        desc = 'Grep',
      },
      {
        '<leader>sw',
        function()
          Snacks.picker.grep_word()
        end,
        desc = 'Visual selection or word',
        mode = { 'n', 'x' },
      },
      -- search
      {
        '<leader>sh',
        function()
          Snacks.picker.help()
        end,
        desc = 'Help Pages',
      },
      {
        '<leader>hg',
        function()
          Snacks.picker.highlights()
        end,
        desc = 'Help Pages',
      },
      {
        '<leader>sk',
        function()
          Snacks.picker.keymaps()
        end,
        desc = 'Keymaps',
      },
      {
        '<leader>sr',
        function()
          Snacks.picker.resume()
        end,
        desc = 'Resume',
      },
      {
        '<leader>th',
        function()
          Snacks.picker.colorschemes()
        end,
        desc = 'Colorschemes',
      },
      -- LSP
      {
        "<leader>gl",
        function()
          Snacks.picker.git_log({
            finder = "git_log",
            format = "git_log",
            preview = "git_show",
            confirm = "git_checkout",
            layout = "vertical",
          })
        end,
        desc = "Git Log",
      },
      {
        "<M-b>",
        function()
          Snacks.picker.git_branches({
            layout = "select",
          })
        end,
        desc = "Branches",
      },
    },
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      explorer = { enabled = true },
      indent = { enabled = false },
      input = { enabled = false },
      notifier = { enabled = false },
      quickfile = { enabled = false },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = false },

      picker = {
        enabled = true,
        layout = {
          preset = "ivy",
          cycle = false,
        },
      },

      matcher = {
        frecency = true,
      },

      icons = {
        files = {
          enabled = false,
        },
      },

      formatters = {
        file = {
          filename_first = true, -- display filename before the file path
          truncate = 80,
        },
      },
    },
  },
}
