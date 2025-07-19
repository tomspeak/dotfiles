local borders = require 'utils.borders'

local function border(hl_name)
  return vim.tbl_map(function(char)
    return { char, hl_name }
  end, borders.single)
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    {
      'j-hui/fidget.nvim',
      opts = {
        notification = {
          window = {
            winblend = 0, -- Background color opacity in the notification window
          },
        },
      },
    },
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp',
  },
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- To instead override globally
        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
          opts = opts or {}
          opts.border = opts.border or border 'FloatBorder'
          return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-T>.
        map('gd', require('fzf-lua').lsp_definitions, '[G]oto [D]efinition')
        map('gV', '<cmd>vsplit | lua vim.lsp.buf.definition()<cr>', '[G]oto [V]ertical [D]efinition')
        map('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')
        map('gI', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')
        --map('<leader>ds', require('fzf-lua').lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        --map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('H', vim.lsp.buf.document_highlight, 'Hover Word')
        -- map('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('<leader>fm', vim.lsp.buf.format, '[F]ormat')

        vim.lsp.inlay_hint.enable(false, { bufnr = event.buf })

        local function client_supports_method(client, method, bufnr)
          if vim.fn.has 'nvim-0.11' == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, { bufnr = bufnr })
          end
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end
      end,
    })

    local servers = {
      rust_analyzer = {
        ['rust-analyzer'] = {
          completion = {
            postfix = {
              enable = false,
            },
          },
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            runBuildScripts = true,
          },
          checkOnSave = {
            command = 'clippy',
          },
          procMacro = {
            enable = true,
            ignored = {
              ['async-trait'] = { 'async_trait' },
            },
          },
        },
      },
      clangd = {
        cmd = {
          'clangd',
          '--background-index',
          '--background-index-priority=normal',
          '--clang-tidy',
          '--header-insertion=iwyu',
          '--completion-style=detailed',
          '--function-arg-placeholders',
          '--fallback-style=llvm',
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      },
      cssls = {},
      html = {},
      tailwindcss = {},
      gopls = {},
      yamlls = {},
      jsonls = {},
      bashls = {},
      terraformls = {},
      eslint = {
        settings = {
          packageManager = 'yarn',
        },
      },
      lua_ls = {
        flags = { debounce_text_changes = 150 },
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = {
                '${3rd}/luv/library',
                unpack(vim.api.nvim_get_runtime_file('', true)),
              },
            },
            diagnostics = {
              globals = { 'use', 'vim' },
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
      zls = {
        enable_build_on_save = true,
        semantic_tokens = 'partial',
      },
    }

    require('mason').setup {
      ui = {
        border = 'rounded',
      },
    }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          local capabilities = require('blink.cmp').get_lsp_capabilities()
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }

    require('mason-tool-installer').setup {}
  end,
}
