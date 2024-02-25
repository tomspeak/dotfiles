return {
  'pmizio/typescript-tools.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  ft = { 'typescript', 'typescriptreact' },
  opts = {
    on_attach = function(client, bufnr)
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint(bufnr, true)
      end
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
    settings = {
      tsserver_file_preferences = {
        includeInlayParameterNameHints = 'all',
        includeCompletionsForModuleExports = true,
      },
    },
  },
}
