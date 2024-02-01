local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

local f = null_ls.builtins.formatting
local d = null_ls.builtins.diagnostics

local sources = {
	d.shellcheck,
	d.buf,
	d.golangci_lint,
	d.jsonlint,
	d.phpstan,
}
