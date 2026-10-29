local lsp = vim.lsp
local autocmd = vim.api.nvim_create_autocmd
local autogrp = vim.api.nvim_create_augroup
local highlight_group = autogrp('user-lsp-highlight', { clear = true })

vim.diagnostic.config {
  severity_sort = true,
  signs = { severity = vim.diagnostic.severity.ERROR },
  underline = { severity = vim.diagnostic.severity.ERROR },
  jump = {
    on_jump = function(_, buf)
      vim.diagnostic.open_float { bufnr = buf, scope = 'cursor', focus = false }
    end,
  },
}

local keybinds = function(buf)
  local map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buf = buf, desc = 'LSP: ' .. desc })
  end

  map('<leader>ca', function()
    if vim.bo[buf].filetype == 'rust' then
      vim.cmd.RustLsp 'codeAction'
    else
      vim.lsp.buf.code_action()
    end
  end, '[C]ode [A]ction')
  map('gd', Snacks.picker.lsp_definitions, '[G]oto [D]efinition')
  map('gV', '<cmd>vsplit | lua Snacks.picker.lsp_definitions()<cr>', '[G]oto [V]ertical [D]efinition')
  map('grr', Snacks.picker.lsp_references, '[G]oto [R]eferences')
  map('<leader>ci', Snacks.picker.lsp_incoming_calls, '[C]alls [I]ncoming')
  map('<leader>cO', Snacks.picker.lsp_outgoing_calls, '[C]alls [O]utgoing')
  map('gI', Snacks.picker.lsp_implementations, '[G]oto [I]mplementation')
  map('gy', Snacks.picker.lsp_type_definitions, '[G]oto T[y]pe Definitions')
  map('<leader>sS', function()
    Snacks.picker.lsp_workspace_symbols {
      filter = { default = require 'core.symbols' },
    }
  end, 'Goto Work[s]pace [S]ymbols')
  map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  map('K', function()
    if vim.bo[buf].filetype == 'rust' then
      vim.cmd.RustLsp { 'hover', 'actions' }
      return
    end
    vim.lsp.buf.hover {
      max_height = 20,
      max_width = 130,
      close_events = { 'CursorMoved', 'LspDetach' },
      focusable = true,
    }
  end, 'Hover Documentation')
  map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  map('<leader>ti', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = buf }, { bufnr = buf })
  end, 'Toggle Inlay Hints')
end

autocmd('LspAttach', {
  group = autogrp('user-lsp-attach', { clear = true }),
  callback = function(ev)
    local client = lsp.get_client_by_id(ev.data.client_id)
    local buf = ev.buf
    if not client then
      return
    end

    if client:supports_method('textDocument/documentHighlight', buf) then
      -- These callbacks fan out to every supporting client, so own them once per buffer.
      vim.api.nvim_clear_autocmds { group = highlight_group, buf = buf }
      autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buf = buf,
        group = highlight_group,
        callback = vim.lsp.buf.document_highlight,
      })
      autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buf = buf,
        group = highlight_group,
        callback = vim.lsp.buf.clear_references,
      })
    end

    keybinds(buf)

    if client:supports_method 'textDocument/linkedEditingRange' then
      vim.lsp.linked_editing_range.enable(true, { bufnr = buf })
    end
  end,
})

autocmd('LspDetach', {
  group = autogrp('user-lsp-detach', { clear = true }),
  callback = function(ev)
    for _, client in ipairs(lsp.get_clients { bufnr = ev.buf, method = 'textDocument/documentHighlight' }) do
      -- LspDetach fires before the departing client is removed from the buffer.
      if client.id ~= ev.data.client_id then
        return
      end
    end
    vim.api.nvim_clear_autocmds { group = highlight_group, buf = ev.buf }
    vim.api.nvim_buf_call(ev.buf, lsp.buf.clear_references)
  end,
})
