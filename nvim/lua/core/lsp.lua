local lsp = vim.lsp
local diag = vim.diagnostic
local autocmd = vim.api.nvim_create_autocmd
local autogrp = vim.api.nvim_create_augroup

local document_color = function(client, buf)
  if client:supports_method("textDocument/documentColor") then
    vim.lsp.document_color.enable(true, buf)
  end
end

local keybinds = function(buf)
  local map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = buf, desc = 'LSP: ' .. desc })
  end

  map('gd', require('fzf-lua').lsp_definitions, '[G]oto [D]efinition')
  map('gV', '<cmd>vsplit | lua vim.lsp.buf.definition()<cr>', '[G]oto [V]ertical [D]efinition')
  map('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')
  map('gI', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')
  map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  map('K', vim.lsp.buf.hover, 'Hover Documentation')
  map('H', vim.lsp.buf.document_highlight, 'Hover Word')
  map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  map('<leader>fm', vim.lsp.buf.format, '[F]ormat')
end

autocmd("LspAttach", {
  group = autogrp("user-lsp-attach", { clear = true }),
  callback = function(ev)
    local client = lsp.get_client_by_id(ev.data.client_id)
    local buf = ev.buf

    vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })

    if client:supports_method('textDocument/completion') then
      lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

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

---@type vim.diagnostic.Opts
diag.config({
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, source = "if_many", prefix = "~" },
  severity_sort = true,
})

lsp.enable({ 'bashls', 'clangd', 'html', 'jsonls', 'lua-ls', 'rust_analyzer', 'yamlls', 'zls' })
