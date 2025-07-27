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

local highlights_dark = {
  StatusLine = {
    fg = 'White',
    bg = 'NvimDarkGrey2',
  },
}

local highlights_light = {
  StatusLine = {
    fg = 'Black',
    bg = 'NvimLightGrey2',
  },
}

local function extend_default_colorscheme()
  local highlights = vim.o.background == 'dark' and highlights_dark or highlights_light

  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

extend_default_colorscheme()

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'default-extended',
  callback = extend_default_colorscheme,
})
