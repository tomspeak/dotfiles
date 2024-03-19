return {
  'NvChad/base46',
  lazy = true,
  branch = 'v2.5',
  build = function()
    require('base46').load_all_highlights()
  end,
}
