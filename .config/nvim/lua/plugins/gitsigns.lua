return {
  'lewis6991/gitsigns.nvim',
  event = 'BufReadPost',
  opts = {
    attach_to_untracked     = false,
    preview_config          = {
      border = 'solid',
      style = 'minimal',
      row = 1,
      col = 1,
    },
    signs                   = {
      add          = { text = '+' },
      change       = { text = '~' },
      delete       = { text = '-' },
      topdelete    = { text = '‾' },
      changedelete = { text = '≈' },
    },
    signcolumn              = true,
    numhl                   = false,
    linehl                  = false,
    word_diff               = false,
    update_debounce         = 500,
    current_line_blame      = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
      delay = 100,
    },
    on_attach               = function(bufnr)
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

      -- Stage/Reset hunks
      map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage hunk' })
      map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset hunk' })
      map('v', '<leader>hs', function()
        gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
      end, { desc = 'Stage selection' })
      map('v', '<leader>hr', function()
        gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
      end, { desc = 'Reset selection' })
      map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage buffer' })
      map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset buffer' })
      map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
      map('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview hunk' })

      -- Toggles
      map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
      map('n', '<leader>tD', gs.toggle_deleted, { desc = 'toggle git show deleted' })
    end,
  },
}
