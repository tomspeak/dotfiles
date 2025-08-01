--   Dark: NvimDarkBlue, NvimDarkCyan, NvimDarkGreen, NvimDarkGrey1-4,
--         NvimDarkMagenta, NvimDarkRed, NvimDarkYellow
--   Light: NvimLightBlue, NvimLightCyan, NvimLightGreen, NvimLightGrey1-4,
--          NvimLightMagenta, NvimLightRed, NvimLightYellow
--  :Inspect, :InspectTree

vim.cmd 'colorscheme default'

local set_hl = vim.api.nvim_set_hl

-- Highlight spec: each entry can be:
--   "GroupName" → link to another group (same for dark/light)
--   { fg = ..., bg = ... } → color settings for both
--   { dark = "LinkName", light = "LinkName" }
--   { dark = { fg = ..., bg = ... }, light = { fg = ..., bg = ... } }
local highlights_spec = {
  StatusLine            = {
    dark  = { fg = 'White', bg = 'NvimDarkGrey2' },
    light = { fg = 'Black', bg = 'NvimLightGrey2' },
  },
  StatusLineNC          = "StatusLine",

  ["@comment"]          = "Comment",
  ["@string"]           = "String",
  ["@number"]           = "Number",
  ["@boolean"]          = "Boolean",
  ["@constant"]         = "Constant",
  ["@function"]         = "Function",
  ["@function.builtin"] = "Function",
  ["@variable"]         = "Identifier",
  ["@type"]             = "Type",
  ["@keyword"]          = "Keyword",
  ["@keyword.function"] = "Keyword",
  ["@field"]            = "Identifier",
  ["@property"]         = "Identifier",
  ["@parameter"]        = "Identifier",
}

local function apply_highlights()
  local background = vim.o.background

  for group, spec in pairs(highlights_spec) do
    if type(spec) == "string" then
      set_hl(0, group, { link = spec })
    elseif type(spec) == "table" then
      if spec.dark or spec.light then
        local theme_spec = spec[background] or spec.dark or spec.light
        if type(theme_spec) == "string" then
          set_hl(0, group, { link = theme_spec })
        elseif type(theme_spec) == "table" then
          set_hl(0, group, theme_spec)
        end
      else
        set_hl(0, group, spec)
      end
    end
  end
end

apply_highlights()

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'default-extended',
  callback = apply_highlights,
})
