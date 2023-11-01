---@class ChadrcConfig
local M = {}

M.options = {
	nvchad_branch = "v3.0",
}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
	theme = "nano-light",
	theme_toggle = { "nano-light", "nano-light" },
	transparency = false,

	telescope = { style = "bordered" },

	extended_integrations = {
		"dap",
		"hop",
		"rainbowdelimiters",
		"codeactionmenu",
		"todo",
		"trouble",
		"notify",
	},

	hl_override = highlights.override,
	hl_add = highlights.add,

	statusline = {
		theme = "minimal",
		separator_style = "block",
		overriden_modules = function(modules)
			modules[1] = (function()
				return ""
			end)()
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
			modules[1] = (function()
				return ""
			end)()
			modules[4] = (function()
				return ""
			end)()
		end,
	},

	cmp = {
		icons = true,
		selected_item_bg = "simple",
		lspkind_text = true,
		style = "flat_light", -- default/flat_light/flat_dark/atom/atom_colored
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

	cheatsheet = { theme = "grid" },
}

M.settings = {
	cc_size = "130",
	so_size = 10,

	-- Blacklisted files where cc and so must be disabled
	blacklist = {
		"NvimTree",
		"nvdash",
		"nvcheatsheet",
		"terminal",
		"Trouble",
		"help",
	},
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require("custom.mappings")

return M
