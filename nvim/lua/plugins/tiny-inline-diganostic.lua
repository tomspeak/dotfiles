return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = false,
  priority = 1000,
  config = function()
    vim.diagnostic.config({
      update_in_insert = false,
      virtual_text = false,
      severity_sort = false,
      signs = false,
      severity = { vim.diagnostic.severity.ERROR },
      underline = {
        severity = { min = vim.diagnostic.severity.ERROR },
      },
    })

    require("tiny-inline-diagnostic").setup({
      preset = "classic",
      options = {
        add_messages = false,
        multilines = true,

        show_source = {
          enabled = false,
          if_many = true,
        },

        set_arrow_to_diag_color = true,
        throttle = 0,
        softwrap = 30,

        -- Display all diagnostic messages on the cursor line, not just those under cursor
        show_all_diags_on_cursorline = true,

        -- Manage how diagnostic messages handle overflow
        overflow = {
          mode = "wrap",
          padding = 2,
        },

        severity = {
          vim.diagnostic.severity.ERROR,
        },
      },
    })

    vim.diagnostic.open_float = require("tiny-inline-diagnostic.override").open_float
  end
}
