---@type vim.lsp.Config
return {
  cmd = { "rust-analyzer" },
  root_markers = {
    "rust-project.json",
    "Cargo.toml",
  },
  filetypes = {
    "rust",
  },
  capabilities = {
    experimental = {
      serverStatusNotification = true,
    },
  },
  settings = {
    ['rust-analyzer'] = {
      completion = {
        postfix = {
          enable = false,
        },
      },
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        runBuildScripts = true,
      },
      checkOnSave = {
        command = 'clippy',
      },
    }
  }
}
