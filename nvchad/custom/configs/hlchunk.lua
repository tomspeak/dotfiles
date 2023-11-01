local present, hlchunk = pcall(require, "hlchunk")

if not present then
	return
end

hlchunk.setup({
	chunk = {
		enable = true,
	},

	indent = {
		enable = false,
		use_treesitter = false,
		chars = {
			"│",
		},
		style = {
			vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
		},
		exclude_filetype = {
			git = true,
			nvdash = true,
			nvcheatsheet = true,
			terminal = true,
			dashboard = true,
			help = true,
			lspinfo = true,
			packer = true,
			checkhealth = true,
			man = true,
			mason = true,
			NvimTree = true,
			plugin = true,
		},
	},

	line_num = {
		enable = true,
		support_filetypes = {
			"...",
		},
	},

	blank = {
		enable = false,
		chars = {
			"",
		},
		style = {
			vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
		},
		exclude_filetype = "...",
	},
})
