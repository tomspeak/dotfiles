return {
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',
  config = function()
    -- calling `setup` is optional for customization
    require('fzf-lua').setup {}
  end,
}
