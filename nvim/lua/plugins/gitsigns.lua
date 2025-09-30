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
      untracked    = { text = '?' },
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

      -- Toggles
      map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
      map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })
    end,
  },
}
