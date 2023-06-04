require("nvim-tree").setup({
	git = {
		enable = false,
	},
	-- renderer = {
	-- 	icons = {
	-- 		show = {
	-- 			file = false,
	-- 			folder = false,
	-- 			folder_arrow = true,
	-- 			git = false,
	-- 		},
	-- 	},
	-- },
	diagnostics = {
		enable = true,
		show_on_dirs = false,
		icons = {
			hint = "",
			info = "i",
			warning = "w",
			error = "e",
		},
	},
})
