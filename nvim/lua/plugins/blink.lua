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
  build = 'cargo build --release',

  opts = {
    keymap = {
      preset = 'default',
      ['<CR>'] = { 'select_and_accept', 'fallback' },

      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },

      ['<C-n>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'snippet_backward', 'fallback' },

      ["<S-k>"] = { "scroll_documentation_up", "fallback" },
      ["<S-j>"] = { "scroll_documentation_down", "fallback" },

      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },
    -- appearance = {
    --   nerd_font_variant = 'normal',
    -- },
    -- cmdline = {
    --   enabled = true,
    --   keymap = { preset = "cmdline" },
    --   completion = {
    --     list = { selection = { preselect = false } },
    --     menu = {
    --       auto_show = function()
    --         return vim.fn.getcmdtype() == ":"
    --       end,
    --     },
    --     ghost_text = { enabled = true },
    --   },
    -- },
    completion = {
      trigger = {
        show_on_backspace_after_accept = true,
        show_on_insert = true,
        show_on_trigger_character = true,
      },
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
    },
    --   keyword = {
    --     range = 'prefix',
    --   },
    --   list = {
    --     selection = { preselect = true, auto_insert = false },
    --     max_items = 5,
    --   },
    -- documentation = {
    --   window = {
    --     min_width = 40,
    --     max_width = 70,
    --   },
    --   auto_show = true,
    --   auto_show_delay_ms = 500,
    -- },
    --   menu = {
    --     min_width = 34,
    --     max_height = 10,
    --     draw = {
    --       treesitter = { "lsp" },
    --       align_to = 'cursor',
    --
    --       padding = 0,
    --       gap = 0,
    --       columns = {
    --         { 'kind_icon',        gap = 1, 'label' },
    --         { 'label_description' },
    --       },
    --       components = {
    --         kind_icon = {
    --           text = function(ctx)
    --             return '[' .. kind_map[ctx.kind] .. ']'
    --           end,
    --         },
    --         label = {
    --           width = {
    --             fill = true,
    --             max = 60,
    --           },
    --         },
    --       },
    --     },
    --   },
    -- },
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
