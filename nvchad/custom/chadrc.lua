---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
	theme = "aquarium",
	theme_toggle = { "aquarium", "aquarium" },
	transparency = false,

	hl_override = highlights.override,
	hl_add = highlights.add,

	statusline = {
		theme = "minimal",
		separator_style = "block",
		overriden_modules = function(modules)
			modules[5] = (function()
				return ""
			end)()
			modules[6] = (function()
				return ""
			end)()
			modules[7] = (function()
				return ""
			end)()
			modules[9] = (function()
				return ""
			end)()
			modules[10] = (function()
				return ""
			end)()
			modules[11] = (function()
				return ""
			end)()
		end,
	},

	tabufline = {
		overriden_modules = function(modules)
			modules[4] = (function()
				return ""
			end)()
		end,
	},

	cmp = {
		icons = true,
		selected_item_bg = "simple",
		lspkind_text = true,
		style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
	},

	nvdash = {
		load_on_startup = true,

		header = {
			"“And when he came to,                                         ",
			"  he was flat on his back on the beach in the freezing sand,  ",
			"  and it was raining out of a low sky,                        ",
			"  and the tide was way out.”                                  ",
		},
		buttons = {},
	},

	cheatsheet = { theme = "grid" }, -- simple/grid
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require("custom.mappings")

return M
