return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('tiny-inline-diagnostic').setup({
      preset = "classic",
    })
    vim.diagnostic.config({ virtual_text = false })
  end
}
