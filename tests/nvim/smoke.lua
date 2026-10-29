-- Run with the real config and installed plugins:
-- nvim --headless -i NONE -c "lua dofile('tests/nvim/smoke.lua')"
local temp = vim.fn.tempname()
local original_cwd = vim.fn.getcwd()
-- Never change the operator's real tmux session during headless checks.
vim.env.TMUX, vim.env.TMUX_PANE = nil, nil
local picker
local original_notify = vim.notify
local errors = {}
vim.notify = function(message, level, opts)
  if level == vim.log.levels.ERROR then
    errors[#errors + 1] = message
  end
  original_notify(message, level, opts)
end

local function check()
  assert(vim.v.errmsg == '', vim.v.errmsg)
  for _, path in ipairs(vim.fn.globpath(vim.fn.stdpath 'config', '**/*.lua', false, true)) do
    assert(loadfile(path))
  end
  -- Headless sessions do not naturally emit UIEnter.
  vim.api.nvim_exec_autocmds('UIEnter', {})
  vim.cmd.enew()
  vim.bo.filetype = 'lua'
  require('lazy').load { plugins = { 'mini.ai', 'mini.completion', 'nvim-lspconfig', 'gitsigns.nvim' } }

  local plugins = require('lazy.core.config').plugins
  for _, name in ipairs { 'nvim-tree.lua', 'zen-mode.nvim', 'mini.indentscope' } do
    assert(not plugins[name], name .. ' still configured')
  end
  assert(plugins['mini.completion'] and plugins['mini.snippets'])
  assert(vim.o.autocomplete == false, 'Completion engine changed')
  for _, mode in ipairs { 'n', 'x' } do
    assert(vim.fn.maparg('Q', mode) == '')
  end
  for _, mode in ipairs { 'x', 'o' } do
    for _, key in ipairs { 'al', 'il' } do
      assert(vim.fn.maparg(key, mode) == '')
    end
    assert(vim.fn.maparg('ii', mode) ~= '')
    assert(vim.fn.maparg('ai', mode) ~= '')
  end
  assert(vim.fn.maparg('[i', 'n') ~= '' and vim.fn.maparg(']i', 'n') ~= '')

  -- Mini's automatic-completion exclusions and prose settings remain intact.
  vim.bo.filetype = 'snacks_picker_input'
  assert(vim.b.minicompletion_disable)
  vim.bo.filetype = 'markdown'
  assert(vim.b.minicompletion_disable == false)
  assert(vim.b.minicompletion_config.delay.completion == 10 ^ 7)
  vim.bo.filetype = 'lua'
  assert(vim.b.minicompletion_config == nil)

  assert(vim.lsp.config.clangd.cmd[2] == '-j=6')
  assert(vim.lsp.config.lua_ls.settings.Lua.workspace.checkThirdParty == false)
  assert(vim.lsp.config.zls.settings.zls.enable_build_on_save)
  assert(vim.lsp.config.lua_ls.capabilities.textDocument.completion.completionItem.snippetSupport)
  assert(#vim.api.nvim_get_autocmds { group = 'user-lsp-attach' } == 1)
  assert(vim.filetype.match { filename = 'example.ztml' } ~= 'ztml')

  assert(vim.fn.exists ':GBrowse' == 2)
  -- Check the lazy trigger and real command without opening a browser or changing the clipboard.
  require('lazy').load { plugins = { 'vim-fugitive' } }
  assert(plugins['vim-fugitive']._.loaded)
  assert(vim.api.nvim_get_commands({}).GBrowse.definition:find('fugitive#BrowseCommand', 1, true))

  dofile(vim.fn.stdpath 'config' .. '/lua/plugins/gitsigns.lua').opts.on_attach(vim.api.nvim_get_current_buf())
  assert(vim.fn.maparg(' hu', 'n') == '' and vim.fn.maparg(' tD', 'n') == '')
  assert(vim.fn.maparg(' hs', 'n', false, true).desc == 'Stage/unstage hunk')
  assert(vim.fn.maparg(' hp', 'n') ~= '')

  -- Exercise the actual explorer finder and its filters in a disposable tree.
  vim.fn.mkdir(temp .. '/node_modules', 'p')
  temp = assert(vim.uv.fs_realpath(temp))
  for _, name in ipairs { 'keep.txt', '.hidden', '.DS_Store', 'skip.o', 'skip.d', 'node_modules/package.json' } do
    vim.fn.writefile({}, temp .. '/' .. name)
  end
  picker = Snacks.explorer { cwd = temp }
  assert(
    vim.wait(3000, function()
      return picker.list.win:valid() and not picker:is_active()
    end),
    'Explorer did not finish loading'
  )
  local names = {}
  for _, item in ipairs(picker:items()) do
    if item.file then
      names[vim.fs.basename(item.file)] = true
    end
  end
  assert(names['keep.txt'] and names['.hidden'], vim.inspect(names))
  assert(not names.node_modules and not names['.DS_Store'] and not names['skip.o'] and not names['skip.d'], vim.inspect(names))
  assert(picker.opts.ignored and picker.opts.hidden)
  assert(picker.opts.layout.layout.position == 'right' and picker.opts.layout.layout.width == 50)
  picker:close()
  picker = nil

  -- Exercise the user-facing toggle and reveal mappings.
  vim.cmd.edit(temp .. '/keep.txt')
  vim.cmd.lcd(temp)
  vim.fn.maparg('-', 'n', false, true).callback()
  assert(vim.wait(3000, function()
    return #Snacks.picker.get { source = 'explorer' } == 1
  end))
  assert(vim.wait(3000, function()
    local p = Snacks.picker.get({ source = 'explorer' })[1]
    return p and not p:is_active()
  end))
  vim.fn.maparg('-', 'n', false, true).callback()
  assert(#Snacks.picker.get { source = 'explorer' } == 0)
  vim.fn.maparg('_', 'n', false, true).callback()
  assert(vim.wait(3000, function()
    return #Snacks.picker.get { source = 'explorer' } == 1
  end))
  picker = Snacks.picker.get({ source = 'explorer' })[1]
  assert(picker)
  assert(vim.wait(3000, function()
    return not picker:is_active()
  end))
  picker:close()
  picker = nil

  local parent = vim.api.nvim_get_current_win()
  local before = { number = vim.wo.number, spell = vim.wo.spell, wrap = vim.wo.wrap }
  vim.cmd.ZenMode()
  assert(Snacks.zen.win:valid() and vim.o.laststatus == 0)
  assert(vim.wo.spell and vim.wo.wrap and not vim.wo.number)
  vim.cmd.ZenMode()
  vim.wait(100)
  assert(vim.o.laststatus == 2)
  for option, value in pairs(before) do
    assert(vim.wo[parent][option] == value, option .. ' was not restored')
  end
  assert(#errors == 0, table.concat(errors, '\n'))
  assert(vim.v.errmsg == '', vim.v.errmsg)
end

local ok, err = xpcall(check, debug.traceback)
if picker then
  picker:close()
end
vim.notify = original_notify
vim.cmd.lcd(original_cwd)
vim.fn.delete(temp, 'rf')
if not ok then
  print(err)
  vim.cmd 'cquit 1'
else
  print 'Neovim smoke checks passed'
  vim.cmd 'qa!'
end
