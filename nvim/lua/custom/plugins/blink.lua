local kind_map = {
  Text = 'Txt',
  Method = 'Meth',
  Function = 'Fn',
  Constructor = 'Ctor',
  Field = 'Fld',
  Variable = 'Var',
  Class = 'Cls',
  Interface = 'Iface',
  Module = 'Mod',
  Property = 'Prop',
  Unit = 'Unit',
  Value = 'Val',
  Enum = 'Enum',
  Keyword = 'Kw',
  Snippet = 'Snip',
  Color = 'Col',
  File = 'File',
  Reference = 'Ref',
  Folder = 'Dir',
  EnumMember = 'EnumM',
  Constant = 'Const',
  Struct = 'Struct',
  Event = 'Evt',
  Operator = 'Op',
  TypeParameter = 'Type',
}

return {
  'saghen/blink.cmp',
  event = 'VimEnter',
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
    'folke/lazydev.nvim',
  },
  build = 'cargo build --release',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'default',

      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },
      ['<cr>'] = { 'select_and_accept', 'fallback' },
      ['<C-n>'] = { 'snippet_forward', 'fallback' },
      ['<C-p>'] = { 'snippet_backward', 'fallback' },
    },
    appearance = {
      nerd_font_variant = 'normal',
    },
    completion = {
      documentation = { auto_show = false },
      menu = {
        draw = {
          padding = { 0, 1 }, -- padding only on right side
          components = {
            kind_icon = {
              text = function(ctx)
                return '[' .. kind_map[ctx.kind] .. ']'
              end,
            },
          },
        },
      },
    },
    snippets = { preset = 'luasnip' },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
    signature = { enabled = true },
  },
  opts_extend = { 'sources.default' },
}
