local present, go = pcall(require, "go")

if not present then
	return
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

go.setup({
	lsp_cfg = {
		capabilities = capabilities,
		-- other setups
	},
	lsp_document_formatting = true,
	-- null_ls_document_formatting_disable = true,
	max_line_len = 300,
	lsp_inlay_hints = {
		enable = true,
		only_current_line = true,
		other_hints_prefix = "• ",
	},
	trouble = true,
	lsp_keymaps = false,
	icons = { breakpoint = "", currentpos = "" },
	lsp_diag_virtual_text = false,
	gocoverage_sign = "│",
	dap_debug_gui = {
		icons = { expanded = "▾", collapsed = "▸" },
		mappings = {
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
			toggle = "t",
		},
		expand_lines = false,
		layouts = {
			{
				elements = {
					{ id = "scopes", size = 0.40 },
					{ id = "breakpoints", size = 0.20 },
					{ id = "stacks", size = 0.20 },
					{ id = "watches", size = 0.20 },
				},
				size = 40, -- 40 columns
				position = "left",
			},
			{
				elements = {
					{
						id = "repl",
						size = 0.5,
					},
					{
						id = "console",
						size = 0.5,
					},
				},
				size = 10, -- 25% of total lines
				position = "bottom",
			},
		},
		floating = {
			max_height = nil,
			max_width = nil,
			border = "rounded", -- Border style. Can be "single", "double" or "rounded"
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
		windows = { indent = 1 },
		render = {
			max_type_length = nil,
		},
	},
})
