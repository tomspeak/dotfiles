local cmp = require("cmp")

cmp.sources = {
	sources = {
		{ name = "copilot", keyword_length = 0 },
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "buffer" },
		{ name = "path" },
	},
}
