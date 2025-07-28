return {
  'preservim/vim-pencil',
  ft = { 'markdown', 'org', 'tex', 'rst', 'text' },
  cmd = { 'Pencil', 'PencilHard', 'PencilSoft', 'PencilToggle' },
  init = function()
    vim.g['pencil#wrapModeDefault'] = 'soft'
    vim.g['pencil#textwidth'] = 80
    vim.g['pencil#autoformat'] = 0
  end,
}
