---@type vim.lsp.ClientConfig
return {
  name = "lua-ls",
  cmd = { "lua-language-server" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
  },
  filetypes = { "lua" },
  single_file_support = true,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.list_extend(
          vim.split(package.path, ";"),
          { "lua/?.lua", "lua/?/init.lua" }
        ),
      },
      workspace = {
        checkThirdParty = false,
        library = vim.list_extend(
          {}, -- <- this is the "dst" list
          {
            vim.env.VIMRUNTIME,
            "lua",
            "nvim-test",
          }
        ),
      },
      diagnostics = {
        globals = { "use", "vim" },
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
