local buf = vim.api.nvim_get_current_buf()

vim.opt_local.makeprg = 'zig build'
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2

vim.b.minisnippets_config = {
  snippets = {
    {
      prefix = 'main',
      body = [[const std = @import("std");

pub fn main() !void {
  $0
}]],
      desc = 'Zig main function',
    },
    {
      prefix = 'test',
      body = [[test "$1" {
  $0
}]],
      desc = 'Zig test block',
    },
    {
      prefix = 'print',
      body = 'std.debug.print("$1\\\\n", .{$0});',
      desc = 'std.debug.print call',
    },
  },
}

vim.keymap.set('i', '<C-j>', function()
  require('mini.snippets').expand()
end, { buffer = buf, desc = 'Expand Zig snippet' })

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
