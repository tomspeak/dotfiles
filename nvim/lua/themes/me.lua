-- this line for types, by hovering and autocompletion (lsp required)
-- will help you understanding properties, fields, and what highlightings the color used for
---@type Base46Table
local M = {}
-- UI
M.base_30 = {
  deep_black = '#263238',
  white = '#37474F',
  darker_black = '#999999',
  black = '#FFFFFF', --  nvim bg
  black2 = '#E5E5E5',
  one_bg = '#999999', -- real bg of onedark
  one_bg2 = '#999999',
  one_bg3 = '#999999',
  grey = '#E1E2E3',
  grey_fg = '#E1E2E4',
  grey_fg2 = '#E1E2E5',
  light_grey = '#848484',
  faded_grey = '#8497a0',
  red = '#EF5350',
  tintred = '#BF616A',
  baby_pink = '#b55dc4',
  pink = '#AB47BC',
  line = '#e0e0e0', -- for lines like vertsplit
  green = '#66BB6A',
  vibrant_green = '#75c279',
  nord_blue = '#42A5F5',
  blue = '#42A5F5',
  yellow = '#d0b22b',
  sun = '#E2C12F',
  purple = '#673AB7',
  dark_purple = '#673AB7',
  teal = '#008080',
  orange = '#FF6F00',
  cream = '#e09680',
  clay = '#D08770',
  cyan = '#26C6DA',
  statusline_bg = '#ECEFF1',
  lightbg = '#e0e0e0',
  pmenu_bg = '#673AB7',
  folder_bg = '#4C566A',
}

-- check https://github.com/chriskempson/base16/blob/master/styling.md for more info
M.base_16 = {
  base00 = '#ffffff',
  base01 = '#e6e6e6',
  base02 = '#cccccc',
  base03 = '#b3b3b3',
  base04 = '#999999',
  base05 = '#808080',
  base06 = '#666666',
  base07 = '#4c4c4c',
  base08 = '#393D3F',
  base09 = '#000000',
  base0A = '#000000',
  base0B = '#000000',
  base0C = '#000000',
  base0D = '#000000',
  base0E = '#000000',
  base0F = '#000000',
}

-- OPTIONAL
-- overriding or adding highlights for this specific theme only
-- defaults/treesitter is the filename i.e integration there,

M.polish_hl = {}

-- set the theme type whether is dark or light
M.type = 'dark' -- "or light"

return M
