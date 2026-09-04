return {
  'mfussenegger/nvim-dap',
  cmd = 'DapContinue',
  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    },
    'theHamsta/nvim-dap-virtual-text',
  },
  keys = {
    {
      '<leader>db',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
    {
      '<leader>dc',
      function()
        require('dap').run_to_cursor()
      end,
      desc = 'Debug: Run to Cursor',
    },
  },
  config = function()
    local dap, dapui, dapvt = require 'dap', require 'dapui', require 'nvim-dap-virtual-text'
    local function zig_build_and_resolve_program()
      local function is_executable(path)
        local stat = vim.uv.fs_stat(path)
        return stat and stat.type == 'file' and vim.fn.executable(path) == 1
      end

      local cwd = vim.fn.getcwd()
      local result = vim.system({ 'zig', 'build' }, { cwd = cwd, text = true }):wait()

      if result.code ~= 0 then
        error(result.stderr ~= '' and result.stderr or 'zig build failed')
      end

      local program = cwd .. '/zig-out/bin/' .. vim.fn.fnamemodify(cwd, ':t')
      if is_executable(program) then
        return program
      end

      local ok, selected = pcall(vim.fn.input, 'Path to Zig executable: ', cwd .. '/zig-out/bin/', 'file')
      if not ok or selected == '' then
        return dap.ABORT
      end

      program = vim.fn.fnamemodify(vim.fn.expand(selected), ':p')
      if not is_executable(program) then
        vim.notify('Not an executable file: ' .. program, vim.log.levels.ERROR)
        return dap.ABORT
      end
      return program
    end

    dapui.setup {
      layouts = {
        {
          elements = {
            {
              id = 'scopes',
              size = 0.50,
            },
            {
              id = 'stacks',
              size = 0.25,
            },
            {
              id = 'watches',
              size = 0.25,
            },
          },
          position = 'right',
          size = 120,
        },
        {
          elements = {
            {
              id = 'repl',
              size = 0.5,
            },
            {
              id = 'console',
              size = 0.5,
            },
          },
          position = 'bottom',
          size = 20,
        },
      },
    }
    dapvt.setup {}

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    dap.adapters.codelldb = require 'core.codelldb'

    dap.configurations.zig = {
      {
        name = '[Zig] LLDB: Basic',
        type = 'codelldb',
        request = 'launch',
        program = zig_build_and_resolve_program,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        console = 'integratedTerminal',
      },
    }
  end,
}
