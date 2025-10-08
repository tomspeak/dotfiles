return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000,
  config = function()
    vim.diagnostic.config({
      update_in_insert = false,
      virtual_text = false,
      severity_sort = true,
      severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN }
    })

    require("tiny-inline-diagnostic").setup({
      preset = "classic",
      options = {
        show_source = {
          enabled = false,
          -- Show source only when multiple sources exist for the same diagnostic
          if_many = true,
        },
        set_arrow_to_diag_color = true,
        throttle = 0,
        softwrap = 30,


        -- Display all diagnostic messages on the cursor line, not just those under cursor
        show_all_diags_on_cursorline = true,

        -- Manage how diagnostic messages handle overflow
        overflow = {
          -- Overflow handling mode:
          -- "wrap" - Split long messages into multiple lines
          -- "none" - Do not truncate messages
          -- "oneline" - Keep the message on a single line, even if it's long
          mode = "none",

          -- Trigger wrapping this many characters earlier when mode == "wrap"
          -- Increase if the last few characters of wrapped diagnostics are obscured
          padding = 0,
        },

        severity = {
          vim.diagnostic.severity.ERROR,
        },
      },
    })
  end
}
