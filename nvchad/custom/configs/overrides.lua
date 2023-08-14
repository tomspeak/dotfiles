local M = {}

M.treesitter = {
	ensure_installed = {
		"bash",
		"regex",
		"dockerfile",
		"json5",
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
		"gomod",
		"gowork",
		"gosum",
		"toml",
		"yaml",
		"json",
		"proto",
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

		"prettierd",
		"eslint_d",

		-- web dev stuff
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"eslint-lsp",
		"jsonlint",
		"json-lsp",
		"yaml-language-server",
		"tailwindcss-language-server",

		"rust-analyzer",

		-- go
		"gopls",
		"gofumpt",
		"goimports",
		"golines",
		"gomodifytags",
		"impl",
		"iferr",
		"staticcheck",

		"shellcheck",
		"shfmt",
		"yamlfmt",
	},

	ui = {
		icons = {
			package_pending = " ",
			package_installed = "󰄳 ",
			package_uninstalled = "󰇚 ",
		},
	},
}

M.nvimtree = {
	view = {
		side = "left",
		signcolumn = "no",
	},

	git = {
		enable = true,
		ignore = false,
	},

	filters = {
		dotfiles = false,
		custom = { "node_modules" },
	},

	renderer = {
		group_empty = true,
		highlight_git = true,
		icons = {
			show = {
				git = false,
				file = false,
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
		defaults = {
			file_ignore_patterns = {
				"node_modules",
				".docker",
				".git",
				"yarn.lock",
				"go.sum",
				"go.mod",
				"tags",
				"mocks",
			},
		},
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

	experimental = {
		ghost_text = {
			hl_group = "Comment",
		},
	},

	matching = {
		disallow_fuzzy_matching = true,
		disallow_fullfuzzy_matching = true,
		disallow_partial_fuzzy_matching = true,
		disallow_partial_matching = false,
		disallow_prefix_unmatching = true,
	},
}

return M
