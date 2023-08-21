---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		["-"] = { "<cmd> NvimTreeToggle <CR>", "NvimTree Toggle" },
		["_"] = { "<cmd> NvimTreeFindFile <CR>", "NvimTree Toggle" },
		["<leader>q"] = { ":q<CR>", "Close window" },
	},
}

M.lspconfig = {
	n = {
		["<leader>ca"] = {
			"<cmd>Lspsaga code_action<CR>",
			"Lspsaga code action",
		},
	},
}

M.test = {
	n = {
		["<leader>nt"] = {
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			"󰤑 Run neotest",
		},
	},
}

-- more keybinds!

return M
