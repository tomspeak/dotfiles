local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		-- javascript = { "prettier" },
		-- javascriptreact = { "prettier" },
		-- typescript = { "prettier" },
		-- typescriptreact = { "prettier" },
		-- css = { "prettier" },
		-- html = { "prettier" },
		-- json = { "prettier" },
		sh = { "shfmt" },
		go = { "gofumpt", "goimports" },
		proto = { "buf" },
		php = { "pint" },
		toml = { "taplo" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
}

require("conform").setup(options)
