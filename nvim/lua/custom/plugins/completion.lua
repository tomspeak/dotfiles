local function border(hl_name)
  return {
    { '┌', hl_name },
    { '─', hl_name },
    { '┐', hl_name },
    { '│', hl_name },
    { '┘', hl_name },
    { '─', hl_name },
    { '└', hl_name },
    { '│', hl_name },
  }
end

return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        -- Build Step is needed for regex support in snippets
        -- This step is not supported in many windows environments
        -- Remove the below condition to re-enable on windows
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
    },
    'saadparwaiz1/cmp_luasnip',

    -- Adds other completion capabilities.
    --  nvim-cmp does not ship with all sources by default. They are split
    --  into multiple repos for maintenance purposes.
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
  },
  config = function()
    -- See `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    luasnip.config.setup {
      history = true, --keep around last snippet local to jump back
      enable_autosnippets = true,
      updateevents = 'TextChanged,TextChangedI', --update changes as you type
    }
    require('luasnip.loaders.from_lua').load { paths = '~/.config/nvim/lua/luasnippets/' }

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      enabled = function()
        -- disable completion in telescope
        local context = require 'cmp.config.context'
        local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
        if buftype == 'prompt' then
          return false
        end
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == 'c' then
          return true
        else
          return not context.in_treesitter_capture 'comment' and not context.in_syntax_group 'Comment'
        end
      end,
      performance = {
        max_view_entries = 30,
        debounce = 100,
      },
      matching = {
        disallow_fuzzy_matching = true,
        disallow_fullfuzzy_matching = true,
        disallow_partial_fuzzy_matching = true,
        disallow_partial_matching = false,
        disallow_prefix_unmatching = true,
      },
      window = {
        completion = cmp.config.window.bordered {
          scrollbar = false,
          winhighlight = 'Normal:CmpPmenu,Search:None',
          side_padding = 1,
          border = border 'CmpMenuBorder',
        },
        documentation = cmp.config.window.bordered {
          scrollbar = true,
          winhighlight = 'Normal:CmpPmenu,Search:None',
          side_padding = 1,
          border = border 'CmpDocBorder',
        },
      },
      experimental = {
        ghost_text = true,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),

        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        ['<cr>'] = cmp.mapping.confirm { select = true },

        ['<C-Space>'] = cmp.mapping.complete {},

        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip', max_item_count = 4 },
        { name = 'path', max_item_count = 1, keyword_length = 3 },
      },
    }

    vim.api.nvim_create_user_command('LuaSnipEdit', function(_)
      require('luasnip.loaders').edit_snippet_files()
    end, {})
  end,
}
