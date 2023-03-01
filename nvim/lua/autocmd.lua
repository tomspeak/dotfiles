-- Strip whitespace from end of file
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- Start/Stop LSP on node_modules change.
-- vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
-- 	pattern = "*/node_modules/*",
-- 	command = ":LspStop",
-- })
-- vim.api.nvim_create_autocmd({ "BufLeave" }, {
-- 	pattern = "*/node_modules/*",
-- 	command = ":LspStart",
-- })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = "plugins.lua",
	command = ":PackerCompile",
})
