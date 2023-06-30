local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

local f = null_ls.builtins.formatting
local l = null_ls.builtins.diagnostics

local sources = {
	f.prettierd,
	f.stylua,
	f.gofumpt,
	f.goimports,
	f.buf,
	f.eslint_d,

	l.shellcheck,
	l.buf,
	l.yamllint,
	l.eslint_d,
	l.golangci_lint,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = true,
	sources = sources,
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ async = false, bufnr = bufnr })
				end,
			})
		end
	end,
})