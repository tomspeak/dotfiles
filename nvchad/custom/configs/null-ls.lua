local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

local f = null_ls.builtins.formatting
local d = null_ls.builtins.diagnostics

local sources = {
	-- f.prettierd.with({
	-- 	condition = function(utils)
	-- 		return utils.has_file({
	-- 			".prettierrc",
	-- 			".prettierrc.json",
	-- 			".prettierrc.yml",
	-- 			".prettierrc.yaml",
	-- 			".prettierrc.json5",
	-- 			".prettierrc.js",
	-- 			".prettierrc.cjs",
	-- 			".prettierrc.toml",
	-- 			"prettier.config.js",
	-- 			"prettier.config.cjs",
	-- 		})
	-- 	end,
	-- }),
	f.stylua,
	f.gofumpt,
	f.goimports,
	f.buf,
	f.yamlfmt,
	f.shfmt,
	f.pint,
	f.taplo,

	d.shellcheck,
	d.buf,
	d.yamllint,
	d.golangci_lint,
	d.jsonlint,
	d.phpstan,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = true,
	sources = sources,
	temp_dir = "/tmp/null-ls/",
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
