return {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          'lua',
          'nvim-test',
        },
      },
      diagnostics = {
        globals = { 'use', 'vim' },
        unusedLocalExclude = { '_*' },
        disable = {
          'missing-fields',
          'duplicate-set-field',
          'undefined-field',
          'inject-field',
        },
      },
      telemetry = {
        enable = false,
      },
      hint = {
        enable = true,
        setType = true,
      },
    },
  },
}
