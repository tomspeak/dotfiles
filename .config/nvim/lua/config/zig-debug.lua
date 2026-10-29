local function executable(path)
  local stat = vim.uv.fs_stat(path)
  return stat and stat.type == 'file' and vim.fn.executable(path) == 1
end

local function program(root)
  local dap = require 'dap'
  if not root then
    vim.notify('Cannot debug Zig: no build.zig found for the buffer or working directory', vim.log.levels.ERROR)
    return dap.ABORT
  end

  -- nvim-dap resumes this suspended thread with its own configuration coroutine.
  return coroutine.create(function(dap_co)
    local function finish(value)
      local ok, err = coroutine.resume(dap_co, value)
      if not ok then
        vim.notify('Zig debug launch failed: ' .. tostring(err), vim.log.levels.ERROR)
      end
    end
    local function abort(message)
      vim.notify(message, vim.log.levels.ERROR)
      finish(dap.ABORT)
    end

    local ok, err = pcall(
      vim.system,
      { 'zig', 'build' },
      { cwd = root, text = true },
      vim.schedule_wrap(function(result)
        if result.code ~= 0 then
          local message = vim.trim(result.stderr or '')
          if message == '' then
            message = vim.trim(result.stdout or '')
          end
          abort(message ~= '' and message or ('zig build failed (exit ' .. result.code .. ')'))
          return
        end

        local bin = vim.fs.joinpath(root, 'zig-out', 'bin')
        local default = vim.fs.joinpath(bin, vim.fs.basename(root))
        if executable(default) then
          finish(default)
          return
        end

        vim.ui.input({ prompt = 'Path to Zig executable: ', default = bin .. '/', completion = 'file' }, function(input)
          if not input or vim.trim(input) == '' then
            finish(dap.ABORT)
            return
          end
          local path = vim.fs.normalize(vim.fs.abspath(input, { cwd = root }))
          if not executable(path) then
            abort('Not an executable file: ' .. path)
            return
          end
          finish(path)
        end)
      end)
    )
    if not ok then
      abort('Could not start zig build: ' .. tostring(err))
    end
  end)
end

return setmetatable({
  name = '[Zig] LLDB: Basic',
  type = 'codelldb',
  request = 'launch',
  stopOnEntry = false,
  args = {},
  console = 'integratedTerminal',
}, {
  __call = function(base)
    -- Resolve once per launch so the build, executable prompt, and debugger agree.
    local root = vim.fs.root(0, 'build.zig') or vim.fs.root(vim.fn.getcwd(), 'build.zig')
    local config = vim.tbl_extend('force', {}, base)
    config.cwd = root
    config.program = function()
      return program(root)
    end
    return config
  end,
})
