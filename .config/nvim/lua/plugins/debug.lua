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
    {
      '<leader>de',
      function()
        local mode = vim.fn.mode()
        local expression
        if mode == 'v' or mode == 'V' or mode == '\22' then
          expression = table.concat(vim.fn.getregion(vim.fn.getpos 'v', vim.fn.getpos '.', { type = mode, exclusive = vim.o.selection == 'exclusive' }), '\n')
        end
        require('dapui').eval(expression)
      end,
      mode = { 'n', 'x' },
      desc = 'Debug: Evaluate Expression',
    },
    {
      '<leader>dl',
      function()
        require('dap').run_last()
      end,
      desc = 'Debug: Run Last',
    },
    {
      '<leader>dL',
      function()
        local ok, message = pcall(vim.fn.input, 'Logpoint message: ')
        if ok and message and vim.trim(message) ~= '' then
          require('dap').set_breakpoint(nil, nil, message)
        end
      end,
      desc = 'Debug: Set Logpoint',
    },
  },
  config = function()
    local dap, dapui, dapvt = require 'dap', require 'dapui', require 'nvim-dap-virtual-text'
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

    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    dap.adapters.codelldb = require 'core.codelldb'

    dap.configurations.zig = { require 'config.zig-debug' }
  end,
}
