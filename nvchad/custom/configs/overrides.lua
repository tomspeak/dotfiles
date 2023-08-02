local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "markdown",
    "markdown_inline",
    "rust",
    "go",
    "toml",
    "yaml",
    "json",
  },
  indent = {
    enable = true,
  },
  rainbow = {
    enabled = true,
    extended_mode = false,
    max_file_lines = 1000,
    query = {
      "rainbow-parens",
      html = "rainbow-tags-react",
      javascript = "rainbow-tags-react",
      typescript = "rainbow-tags-react",
      tsx = "rainbow-tags-react",
    },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  autotag = {
    enable = true,
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "prettier",

    "rust-analyzer",
    "gopls",
  },
}

M.nvimtree = {
  view = {
    side = "left",
    signcolumn = "no",
  },

  git = {
    enable = true,
  },

  filters = {
    custom = { "node_modules" },
  },

  renderer = {
    group_empty = true,
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
  tab = {
    sync = {
      open = true,
      close = true,
    },
  },
}

M.telescope = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim", -- add this value
    },
    path_display = { "truncate" },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      previewer = false,
    },
    lsp_references = {
      previewer = true,
    },
    colorscheme = {
      previewer = false,
    },
  },
}

M.copilot = {}

M.cmp = {
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "vim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "emoji" },
  },
}

return M
