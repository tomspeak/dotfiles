--   Dark: NvimDarkBlue, NvimDarkCyan, NvimDarkGreen, NvimDarkGrey1-4,
--         NvimDarkMagenta, NvimDarkRed, NvimDarkYellow
--   Light: NvimLightBlue, NvimLightCyan, NvimLightGreen, NvimLightGrey1-4,
--          NvimLightMagenta, NvimLightRed, NvimLightYellow
--  :Inspect

vim.cmd 'colorscheme default'

-- Utility to get existing highlight groups
local function get_hl(group)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group })
  return ok and hl or {}
end

local highlights = {
  StatusLine = {
    fg = 'White',
    bg = 'NvimDarkGrey2',
  },
}

local function extend_default_colorscheme()
  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

extend_default_colorscheme()

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'default-extended',
  callback = extend_default_colorscheme,
})
