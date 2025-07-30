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

local implementation = (vim.env.IS_WORK == nil) and 'prefer_rust' or 'lua'

return {
  'saghen/blink.cmp',
  cond = false,
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
  build = 'cargo build --release',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'default',
      ['<CR>'] = { 'select_and_accept', 'fallback' },

      ['<C-n>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'snippet_backward', 'fallback' },
    },
    appearance = {
      nerd_font_variant = 'normal',
    },
    completion = {
      trigger = {
        show_on_backspace_after_accept = true,
        show_on_insert = true,
        show_on_trigger_character = true,
      },
      keyword = {
        range = 'full',
      },
      list = {
        selection = { preselect = true, auto_insert = false },
      },
      documentation = {
        window = {
          border = 'solid',
          min_width = 40,
          max_width = 70,
        },
        auto_show = true,
        auto_show_delay_ms = 500,
      },
      menu = {
        min_width = 34,
        max_height = 10,
        draw = {
          align_to = 'cursor',

          padding = 1,
          gap = 3,
          columns = {
            { 'kind_icon', gap = 1, 'label' },
            { 'label_description' },
          },
          components = {
            kind_icon = {
              text = function(ctx)
                return '[' .. kind_map[ctx.kind] .. ']'
              end,
            },
            label = {
              width = {
                fill = true,
                max = 60,
              },
            },
          },
        },
      },
    },
    snippets = { preset = 'luasnip' },
    sources = {
      default = { 'lsp', 'path', 'snippets' },
    },
    fuzzy = { implementation = implementation },
    signature = { enabled = true },
  },
  opts_extend = { 'sources.default' },
}
