local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities
local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "bufls", "bashls", "jsonls", "phpactor", "zls", "taplo", "terraformls" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		flags = { debounce_text_changes = 150 },
	})
end

lspconfig.eslint.setup({
	settings = {
		packageManager = "yarn",
	},
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
		on_attach(client, bufnr)
	end,
})

lspconfig.tsserver.setup({
	on_attach = function(client, bufnr)
		if client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint(bufnr, true)
		end
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
		on_attach(client, bufnr)
	end,
	capabilities = capabilities,
	flags = { debounce_text_changes = 150 },
	root_dir = util.root_pattern(".git", "package.json"),
	settings = {
		preferences = {
			importModuleSpecifierPreference = "non-relative",
			upddateImportsOnFileMove = "always",
		},
	},
})

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = { debounce_text_changes = 150 },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "use", "vim" },
			},
			hint = {
				enable = true,
				setType = true,
			},
			telemetry = {
				enable = false,
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					[vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types"] = true,
					[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
})

lspconfig.gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = { debounce_text_changes = 150 },
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		completeUnimported = true,
		vulncheck = "Imports",
		analyses = {
			nilness = true,
			shadow = true,
			unusedparams = true,
			unusewrites = true,
		},
		staticcheck = true,
		codelenses = {
			references = true,
			test = true,
			tidy = true,
			upgrade_dependency = false,
			generate = true,
		},
		gofumpt = true,
	},
})

lspconfig.zls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = { debounce_text_changes = 150 },
	filetypes = { "zig" },
})
