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
		"php",
		"zig",
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

		-- web dev
		"prettierd",
		"eslint-lsp",
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"tailwindcss-language-server",

		-- rust
		"rust-analyzer",
		"codelldb",

		-- go
		"gopls",
		"gofumpt",
		"goimports",
		"golines",
		"gomodifytags",
		"impl",
		"iferr",
		"delve",
		"staticcheck",

		"zls",

		-- shell/config files
		"shellcheck",
		"shfmt",
		"yamlfmt",
		"yaml-language-server",
		"jsonlint",
		"json-lsp",
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
	-- don't disable netwr, we need it for :GBrowse (rhubarb/fugitive)
	disable_netrw = false,
	hijack_netrw = false,

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
				"build",
				"dist",
				"node_modules",
				".docker",
				".git",
				"yarn.lock",
				"package-lock.json",
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

M.cmp = {
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		--	{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
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

	enabled = function()
		-- disable completion in comments
		local context = require("cmp.config.context")
		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,
}

M.gitsigns = {
	signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		follow_files = true,
	},
	update_debounce = 500,
}

return M
