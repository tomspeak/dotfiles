-- Shared by Zig and Rust; setup installs this private adapter without a PATH shim.
return {
  type = 'server',
  port = '${port}',
  executable = {
    command = vim.fn.expand '~/.local/share/codelldb/extension/adapter/codelldb',
    args = { '--port', '${port}' },
  },
}
