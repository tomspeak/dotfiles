local buf = vim.api.nvim_get_current_buf()

vim.opt_local.makeprg = 'zig build'
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2

vim.api.nvim_buf_create_user_command(buf, 'ZigRun', function()
  vim.cmd 'make run'
end, { desc = 'zig build run' })

vim.api.nvim_buf_create_user_command(buf, 'ZigTest', function(opts)
  local args = opts.args ~= '' and ' ' .. opts.args or ''
  vim.cmd('make test' .. args)
end, { desc = 'zig build test', nargs = '*' })

vim.api.nvim_buf_create_user_command(buf, 'ZigTestFile', function()
  local file = vim.fn.expand '%:p'
  vim.cmd('terminal zig test ' .. vim.fn.shellescape(file))
end, { desc = 'zig test current file' })
