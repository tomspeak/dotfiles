-- Keep nightly-only UI experiments isolated and make failures visible.
local ok, err = pcall(function()
  require('vim._core.ui2').enable {}
end)

if not ok then
  vim.schedule(function()
    vim.notify('Could not enable experimental UI2: ' .. tostring(err), vim.log.levels.WARN)
  end)
end
