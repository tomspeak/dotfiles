-- Run from the repository root: nvim --clean --headless -l tests/nvim/zig-debug.lua
vim.opt.rtp:prepend(vim.fn.getcwd() .. '/.config/nvim')
package.loaded.dap = { ABORT = {} }
local abort = require('dap').ABORT
local config = require 'config.zig-debug'
local original = { system = vim.system, input = vim.ui.input, notify = vim.notify, cwd = vim.fn.getcwd() }
local temp = vim.fn.tempname()
local root = temp .. '/project with spaces'
local notices = {}
vim.fn.mkdir(root .. '/src/nested', 'p')
vim.fn.mkdir(root .. '/zig-out/bin', 'p')
temp = assert(vim.uv.fs_realpath(temp))
root = assert(vim.uv.fs_realpath(root))
vim.fn.writefile({}, root .. '/build.zig')
vim.api.nvim_buf_set_name(0, root .. '/src/nested/main.zig')
vim.cmd.cd(temp)
vim.notify = function(message)
  notices[#notices + 1] = message
end

local function resolve(result, input, spawn_error)
  local resolved = config()
  assert(resolved.cwd == root, 'Project root must come from the buffer, not cwd')
  local callback
  vim.system = function(cmd, opts, cb)
    assert(vim.deep_equal(cmd, { 'zig', 'build' }))
    assert(opts.cwd == root and opts.text)
    if spawn_error then
      error 'zig not found'
    end
    callback = cb
    return {}
  end
  vim.ui.input = function(opts, cb)
    assert(opts.default == root .. '/zig-out/bin/')
    cb(input)
  end

  local value, done
  local receiver = coroutine.create(function()
    value = coroutine.yield()
    done = true
  end)
  assert(coroutine.resume(receiver))
  local worker = resolved.program()
  assert(type(worker) == 'thread' and coroutine.status(worker) == 'suspended')
  assert(coroutine.resume(worker, receiver))
  if not spawn_error then
    assert(callback and not done, 'Build must yield rather than block or resolve early')
    callback(result)
  end
  assert(
    vim.wait(1000, function()
      return done
    end),
    'DAP coroutine was not resumed'
  )
  return value
end

local ok, err = xpcall(function()
  local binary = root .. '/zig-out/bin/project with spaces'
  vim.fn.writefile({ '#!/bin/sh', 'exit 0' }, binary)
  assert(vim.uv.fs_chmod(binary, 493))
  assert(resolve { code = 0 } == binary)
  assert(vim.uv.fs_unlink(binary))

  local custom = root .. '/zig-out/bin/custom'
  vim.fn.writefile({ '#!/bin/sh', 'exit 0' }, custom)
  assert(vim.uv.fs_chmod(custom, 493))
  assert(resolve({ code = 0 }, 'zig-out/bin/custom') == custom, 'Relative input must use project root')
  assert(resolve({ code = 0 }, nil) == abort)
  assert(resolve({ code = 0 }, '') == abort)
  assert(resolve({ code = 0 }, 'missing') == abort)
  assert(resolve { code = 1, stderr = 'compiler error' } == abort)
  assert(notices[#notices] == 'compiler error')
  assert(resolve { code = 1, stderr = '', stdout = 'build error' } == abort)
  assert(notices[#notices] == 'build error')
  assert(resolve(nil, nil, true) == abort)

  vim.api.nvim_buf_set_name(0, temp .. '/outside.zig')
  vim.cmd.cd(root .. '/src')
  assert(config().cwd == root, 'Working directory root fallback failed')
  vim.cmd.cd(temp)
  assert(config().program() == abort, 'Missing project should abort')
end, debug.traceback)

vim.system, vim.ui.input, vim.notify = original.system, original.input, original.notify
vim.cmd.cd(original.cwd)
vim.fn.delete(temp, 'rf')
if not ok then
  error(err)
end
print 'Zig debug: root resolution, async completion, prompt, cancellation, and failures passed'
