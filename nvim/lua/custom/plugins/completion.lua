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

    -- If you want to add a bunch of pre-configured snippets,
    --    you can use this plugin to help you. It even has snippets
    --    for various frameworks/libraries/etc. but you will have to
    --    set up the ones that are useful for you.
    -- 'rafamadriz/friendly-snippets',
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
    require('luasnip.loaders.from_lua').load { paths = '~/.config/nvim/lua/snippets/' }

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
        max_view_entries = 10,
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
          scrollbar = false,
          winhighlight = 'Normal:CmpPmenu,Search:None',
          side_padding = 1,
          border = border 'CmpDocBorder',
        },
      },
      experimental = {
        ghost_text = true,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },

      -- For an understanding of why these mappings were
      -- chosen, you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      mapping = cmp.mapping.preset.insert {
        -- Select the [n]ext item
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Select the [p]revious item
        ['<C-p>'] = cmp.mapping.select_prev_item(),

        -- Accept ([y]es) the completion.
        --  This will auto-import if your LSP supports it.
        --  This will expand snippets if the LSP sent a snippet.
        ['<cr>'] = cmp.mapping.confirm { select = true },

        -- Manually trigger a completion from nvim-cmp.
        --  Generally you don't need this, because nvim-cmp will display
        --  completions whenever it has completion options available.
        ['<C-Space>'] = cmp.mapping.complete {},

        -- Think of <c-l> as moving to the right of your snippet expansion.
        --  So if you have a snippet that's like:
        --  function $name($args)
        --    $body
        --  end
        --
        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
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
      -- mapping = cmp.mapping.preset.insert {
      --   ['<C-n>'] = cmp.mapping.select_next_item(),
      --   ['<C-p>'] = cmp.mapping.select_prev_item(),
      --   ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      --   ['<C-f>'] = cmp.mapping.scroll_docs(4),
      --   ['<C-Space>'] = cmp.mapping.complete {},
      --   ['<CR>'] = cmp.mapping.confirm {
      --     behavior = cmp.ConfirmBehavior.Replace,
      --     select = true,
      --   },
      --   ['<Tab>'] = cmp.mapping(function(fallback)
      --     if cmp.visible() then
      --       cmp.select_next_item()
      --     elseif luasnip.expand_or_locally_jumpable() then
      --       luasnip.expand_or_jump()
      --     else
      --       fallback()
      --     end
      --   end, { 'i', 's' }),
      --   ['<S-Tab>'] = cmp.mapping(function(fallback)
      --     if cmp.visible() then
      --       cmp.select_prev_item()
      --     elseif luasnip.locally_jumpable(-1) then
      --       luasnip.jump(-1)
      --     else
      --       fallback()
      --     end
      --   end, { 'i', 's' }),
      -- },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip', max_item_count = 2 },
        { name = 'path', max_item_count = 2 },
      },
    }
  end,
}
