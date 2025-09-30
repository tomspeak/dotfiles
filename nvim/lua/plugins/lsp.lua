return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'folke/snacks.nvim', 'saghen/blink.cmp' },
  config = function()
    local lsp = vim.lsp
    local diag = vim.diagnostic
    local autocmd = vim.api.nvim_create_autocmd
    local autogrp = vim.api.nvim_create_augroup

    local document_color = function(client, buf)
      if client:supports_method 'textDocument/documentColor' then
        vim.lsp.document_color.enable(true, buf)
      end
    end

    local keybinds = function(buf)
      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = buf, desc = 'LSP: ' .. desc })
      end

      map('<leader>ca', vim.lsp.buf.code_action, 'LSP [C]ode [A]ction')
      map('gd', Snacks.picker.lsp_definitions, '[G]oto [D]efinition')
      map('gV', '<cmd>vsplit | lua Snacks.picker.lsp_definitions()<cr>', '[G]oto [V]ertical [D]efinition')
      map('gr', Snacks.picker.lsp_references, '[G]oto [R]eferences')
      map('gI', Snacks.picker.lsp_implementations, '[G]oto [I]mplementation')
      map('gy', Snacks.picker.lsp_type_definitions, '[G]oto T[y]pe Definitions')
      map('<leader>ss', Snacks.picker.lsp_symbols, 'Goto [S]ymbols')
      map('<leader>sS', Snacks.picker.lsp_workspace_symbols, 'Goto Work[s]pace [S]ymbols')
      map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      map('K', function()
        vim.lsp.buf.hover {
          border = "single",
          max_height = 20,
          max_width = 130,
          close_events = { "CursorMoved", "BufLeave", "WinLeave", "LSPDetach" },
        }
      end, 'Hover Documentation')
      map('H', vim.lsp.buf.document_highlight, 'Hover Word')
      map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      map('<leader>fm', vim.lsp.buf.format, '[F]ormat')
    end

    autocmd('LspAttach', {
      group = autogrp('user-lsp-attach', { clear = true }),
      callback = function(ev)
        local client = lsp.get_client_by_id(ev.data.client_id)
        local buf = ev.buf

        vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })

        if client:supports_method 'textDocument/documentHighlight' then
          local highlight_augroup = autogrp('user-lsp-highlight', { clear = false })
          autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = ev.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })
          autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = ev.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })
        end

        keybinds(buf)
        document_color(client, buf)
      end,
    })

    autocmd('LspDetach', {
      group = autogrp('user-lsp-detach', { clear = true }),
      callback = function(ev)
        lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = 'user-lsp-highlight', buffer = ev.buf }
      end,
    })

    local function restart_lsp(bufnr)
      bufnr = bufnr or vim.api.nvim_get_current_buf()
      local clients = vim.lsp.get_clients { bufnr = bufnr }

      for _, client in ipairs(clients) do
        vim.lsp.stop_client(client.id)
      end

      vim.defer_fn(function()
        vim.cmd 'edit'
      end, 100)
    end

    vim.api.nvim_create_user_command('LspRestart', function()
      restart_lsp()
    end, {})

    ---@type vim.diagnostic.Opts
    diag.config {
      vim.diagnostic.config {
        virtual_text = false,
        virtual_lines = {
          severity = { min = vim.diagnostic.severity.ERROR },
          current_line = true,
          format = function(dg)
            return string.format("%s", dg.message)
          end,
        },
        signs = {
          severity = { min = vim.diagnostic.severity.WARN },
        },
        underline = false,
        severity_sort = false,
        update_in_insert = false,
      }
    }

    local servers = {
      clangd = {
        cmd = {
          'clangd',
          '-j=6',
          '--all-scopes-completion',
          '--background-index', -- should include a compile_commands.json or .txt
          '--clang-tidy',
          '--cross-file-rename',
          '--completion-style=detailed',
          '--fallback-style=llvm',
          '--function-arg-placeholders',
          '--header-insertion-decorators',
          '--header-insertion=never',
          '--limit-results=10',
          '--pch-storage=memory',
          '--query-driver=/usr/include/*',
          '--suggest-missing-includes',
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      },
      cssls = {},
      html = {},
      yamlls = {},
      jsonls = {},
      bashls = {},
      lua_ls = {
        flags = { debounce_text_changes = 150 },
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
              path = vim.list_extend(vim.split(package.path, ';'), { 'lua/?.lua', 'lua/?/init.lua' }),
            },
            workspace = {
              checkThirdParty = false,
              library = vim.list_extend({}, {
                vim.env.VIMRUNTIME,
                'lua',
                'nvim-test',
              }),
            },
            diagnostics = {
              globals = { 'use', 'vim' },
              unusedLocalExclude = { '_*' },
              disable = {
                'missing-fields',
                'duplicate-set-field',
                'undefined-field',
                'inject-field',
              },
            },
            telemetry = {
              enable = false,
            },
            hint = {
              enable = true,
              setType = true,
            },
          },
        },
      },
      taplo = {},
      zls = {
        enable_build_on_save = true,
        semantic_tokens = 'partial',
      },
    }

    for server_name, cfg in pairs(servers) do
      cfg.capabilities = require('blink.cmp').get_lsp_capabilities(cfg.capabilities)
      vim.lsp.config(server_name, cfg)
      vim.lsp.enable(server_name)
    end
  end,
}
