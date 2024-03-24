local icons = require 'utils.icons'

return {
  'lewis6991/gitsigns.nvim',
  event = 'BufReadPost',
  opts = {
    preview_config = {
      border = 'solid',
      style = 'minimal',
    },
    signs = {
      add = { text = icons.ui.GitSignAdd },
      untracked = { text = icons.ui.GitSignUntracked },
      change = { text = icons.ui.GitSignChange },
      delete = { text = icons.ui.GitSignDelete },
      topdelete = { text = icons.ui.GitSignTopdelete },
      changedelete = { text = icons.ui.GitSignChangedelete },
    },
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
      delay = 100,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map({ 'n', 'v' }, ']c', function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, desc = 'Jump to next hunk' })

      map({ 'n', 'v' }, '[c', function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, desc = 'Jump to previous hunk' })

      -- Actions
      -- normal mode
      map('n', '<leader>gb', function()
        gs.blame_line { full = false }
      end, { desc = 'git blame line' })
      map('n', '<leader>gB', function()
        gs.blame_line { full = true }
      end, { desc = 'git blame line full' })

      -- Toggles
      map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
      map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })
    end,
  },
}
