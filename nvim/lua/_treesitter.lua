local treesitter = require("nvim-treesitter.configs")

local options = {
	ensure_installed = {
		'lua',
		'vim',
		'go',
		'toml',
		'yaml',
		'css',
		'tsx',
		'typescript',
		'html',
		'json',
		'zig',
		'rust',
		'markdown'
	},
	highlight = {
		enable = true,
	},
	autotag = {
		enable = true,
		filetypes = { 'html', 'tsx', 'xml', 'markdown' }
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
		config = {
			typescriptreact = {
				__default = "// %s",
				jsx_element = "{/* %s */}",
				jsx_fragment = "{/* %s */}",
				jsx_attribute = "// %s",
				comment = "// %s",
			},
		},
	},
}

treesitter.setup(options)
require('nvim-ts-autotag').setup()
