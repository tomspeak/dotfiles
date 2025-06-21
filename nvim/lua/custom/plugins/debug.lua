return {
  'mfussenegger/nvim-dap',
  dependencies = {
    { 'igorlfs/nvim-dap-view', opts = { winbar = { controls = { enabled = true } } } },
    'theHamsta/nvim-dap-virtual-text',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  keys = {
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
  },
  config = function()
    local dap = require 'dap'

    require('mason-nvim-dap').setup {
      automatic_setup = true,
      handlers = {},
      ensure_installed = {},
    }

    require('nvim-dap-virtual-text').setup()

    dap.adapters.lldb = {
      type = 'executable',
      command = '/Applications/Xcode.app/Contents/Developer/usr/bin/lldb-dap',
      name = 'lldb',
    }

    dap.configurations.zig = {
      {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = '${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}',
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
    }
  end,
}
