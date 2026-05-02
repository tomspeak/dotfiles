vim.api.nvim_create_user_command('Make', function(opts)
  local cmd = opts.bang and 'make!' or 'make'
  if opts.args ~= '' then
    cmd = cmd .. ' ' .. opts.args
  end
  vim.cmd(cmd)
end, {
  bang = true,
  nargs = '*',
  desc = 'Run makeprg via built-in :make',
})
