local npairs = require("nvim-autopairs")

npairs.setup({
	check_ts = true,
	ts_config = {
		javascript = { "template_string" },
	},
	disable_filetype = { "TelescopePrompt", "vim" },
	fast_wrap = {},
})
