---@type vim.lsp.Config
return {
  cmd = {
    'clangd',
    '-j=6',
    '--all-scopes-completion',
    '--background-index', -- should include a compile_commands.json or .txt
    '--clang-tidy',
    '--cross-file-rename',
    '--completion-style=detailed',
    '--fallback-style=llvm',
    '--function-arg-placeholders',
    '--header-insertion-decorators',
    '--header-insertion=never',
    '--limit-results=10',
    '--pch-storage=memory',
    '--query-driver=/usr/include/*',
    '--suggest-missing-includes',
  },
  root_markers = { '.clangd', 'compile_commands.json',   'compile_flags.txt' },
  filetypes = { "c", "cpp" },
  settings = {
  },
}
