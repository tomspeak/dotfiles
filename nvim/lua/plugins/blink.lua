local implementation = (vim.env.IS_WORK == nil) and 'prefer_rust' or 'lua'

return {
  'saghen/blink.cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      opts = {},
    },
  },
  -- Requires: cargo (rustup)
  build = 'cargo build --release',

  opts = {
    keymap = {
      preset = 'super-tab',
    },
    completion = {
      trigger = {
        show_on_backspace_after_accept = true,
        show_on_insert = true,
        show_on_trigger_character = true,
        show_in_snippet = false -- use when using super-tab preset
      },
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
    },
    snippets = { preset = 'luasnip' },
    sources = {
      default = { 'lsp', 'path', 'snippets' },
    },
    fuzzy = {
      implementation = implementation,
      sorts = {
        'exact',
        'score',
        'sort_text',
      },
    },
    signature = {
      enabled = true,
      window = {
        show_documentation = false,
      }
    },
  },
  opts_extend = { 'sources.default' },
}
