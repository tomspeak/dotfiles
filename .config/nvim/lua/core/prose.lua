local api = vim.api
local opt_local = vim.opt_local
local punctuations = { ',', '.', '?', '!' }

local function enable_soft()
  opt_local.spell = true
  opt_local.wrap = true
  opt_local.linebreak = true
  opt_local.conceallevel = 2
  opt_local.textwidth = 0
  opt_local.wrapmargin = 0

  for _, p in ipairs(punctuations) do
    vim.keymap.set('i', p, p .. '<C-g>u', { buf = 0, desc = 'Add break after ' .. p })
  end
end

local function enable_hard()
  opt_local.wrap = false
  opt_local.linebreak = false
  opt_local.textwidth = 80
  opt_local.formatoptions:append 't'
end

local function setup_commands()
  api.nvim_buf_create_user_command(0, 'PencilHard', function()
    enable_hard()
  end, { desc = 'Switch to hard-wrap mode' })

  api.nvim_buf_create_user_command(0, 'PencilSoft', function()
    enable_soft()
  end, { desc = 'Switch to soft-wrap mode' })
end

api.nvim_create_autocmd('FileType', {
  group = api.nvim_create_augroup('user-prose', { clear = true }),
  pattern = { 'markdown', 'text', 'rst', 'txt', 'tex', 'mdx', 'gitcommit' },
  callback = function()
    enable_soft()
    setup_commands()

    local undo = { 'setlocal spell< wrap< linebreak< conceallevel< textwidth< wrapmargin< formatoptions<' }
    for _, punctuation in ipairs(punctuations) do
      undo[#undo + 1] = "execute 'silent! iunmap <buffer> " .. punctuation .. "'"
    end
    for _, command in ipairs { 'PencilHard', 'PencilSoft' } do
      undo[#undo + 1] = 'silent! delcommand -buffer ' .. command
    end
    vim.b.undo_ftplugin = (vim.b.undo_ftplugin and vim.b.undo_ftplugin .. ' | ' or '') .. table.concat(undo, ' | ')
  end,
})
