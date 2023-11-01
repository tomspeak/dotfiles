local present, go = pcall(require, "go")

if not present then
	return
end

go.setup({
	lsp_cfg = false,
	lsp_document_formatting = false,
	lsp_keymaps = false,
	max_line_len = 300,
	lsp_inlay_hints = {
		enable = true,
		only_current_line = true,
		other_hints_prefix = "• ",
	},
	trouble = true,
	icons = { breakpoint = "", currentpos = "" },
	lsp_diag_virtual_text = false,
	gocoverage_sign = "│",
})
