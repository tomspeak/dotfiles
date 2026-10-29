return {
  cmd = {
    'clangd',
    '-j=6',
    '--all-scopes-completion',
    '--background-index', -- should include a compile_commands.json or .txt
    '--clang-tidy',
    '--completion-style=detailed',
    '--fallback-style=llvm',
    '--function-arg-placeholders',
    '--header-insertion-decorators',
    '--header-insertion=never',
    '--limit-results=10',
    '--pch-storage=memory',
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
  },
}
