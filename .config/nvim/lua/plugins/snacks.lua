local history = {
  confirm = function(picker, item)
    if not item then
      return
    end
    picker:close()
    require('lazy').load { plugins = { 'vim-fugitive' } }
    local git_dir = vim.fn.FugitiveExtractGitDir(item.cwd)
    if git_dir == '' then
      vim.notify('Cannot locate the selected commit\'s repository', vim.log.levels.WARN)
      return
    end
    -- The commit view also works for file history before a rename or deletion.
    vim.cmd.edit { vim.fn.FugitiveFind(item.commit, git_dir) }
  end,
  actions = {
    history_checkout = {
      desc = 'Checkout commit / restore file and index',
      action = function(picker, item)
        if not item then
          return
        end
        picker:close()
        local action = item.file and 'Restore file and index' or 'Checkout commit'
        local target = item.file and (item.file .. ' from ' .. item.commit) or item.commit
        vim.ui.select({ 'Cancel', action }, { prompt = action .. ': ' .. target .. '?' }, function(choice)
          if choice == action then
            require('snacks.picker.actions').git_checkout(picker, item)
          end
        end)
      end,
    },
  },
  win = {
    input = { keys = { ['<c-x>'] = { 'history_checkout', mode = { 'n', 'i' } } } },
    list = { keys = { ['<c-x>'] = 'history_checkout' } },
  },
}

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
            layout = "vscode"
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
            current = false,
            sort_lastused = true,
            win = {
              input = {
                keys = {
                  ["<c-x>"] = { "bufdelete", mode = { "n", "i" } },
                },
              },
              list = { keys = { ["d"] = "bufdelete" } },
            },
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
      {
        '<leader>sd',
        function()
          Snacks.picker.diagnostics()
        end,
        desc = 'Diagnostics',
      },
      -- LSP
      {
        "<leader>gl",
        function()
          Snacks.picker.git_log({
            finder = "git_log",
            format = "git_log",
            preview = "git_show",
            layout = "vertical",
          })
        end,
        desc = "Git Log",
      },
      {
        "<leader>gd",
        function()
          Snacks.picker.git_diff({
            finder = "git_diff",
            preview = "diff",
          })
        end,
        desc = "Git Diff",
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
      {
        "<leader>gc",
        function()
          Snacks.picker.git_log_file()
        end,
        desc = "Git Commit History (current file)",
      },
      {
        "<leader>gS",
        function()
          vim.cmd "Git stash"
        end,
        desc = "Stash changes",
      },
      {
        "<leader>gP",
        function()
          vim.ui.input(
            { prompt = "Stash index to pop (or leave blank for latest): " },
            function(input)
              if input == nil then
                return
              end
              input = vim.trim(input)
              if input ~= '' and not input:match '^%d+$' then
                vim.notify('Stash index must be a non-negative integer', vim.log.levels.WARN)
                return
              end
              vim.cmd('Git stash pop' .. (input == '' and '' or ' stash@{' .. input .. '}'))
            end
          )
        end,
        desc = "Unstash changes",
      },
    },
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      explorer = { enabled = false },
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
        sources = {
          git_log = history,
          git_log_file = history,
        },
        layout = {
          preset = "ivy",
          cycle = false,
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
            filename_first = true,
          },
        },
      },
    },
  },
}
