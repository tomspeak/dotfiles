local has_query = function(lang, query_group)
  local ok, files = pcall(vim.treesitter.query.get_files, lang, query_group)
  return ok and files and #files > 0
end

return {
  {
    'neovim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    cmd = { 'TSInstall', 'TSUninstall', 'TSUpdate', 'TSRegistryUpdate', 'TSStatus', 'TSLog' },
    dependencies = {
      'neovim-treesitter/treesitter-parser-registry',
    },
    config = function()
      local ts = require 'nvim-treesitter'

      ts.setup {
        install_dir = vim.fn.stdpath 'data' .. '/site',
      }

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('user-treesitter-enable', { clear = true }),
        pattern = '*',
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
          if not lang then
            return
          end

          local started = pcall(vim.treesitter.start, ev.buf, lang)
          if not started then
            return
          end

          if has_query(lang, 'folds') then
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          end

          if has_query(lang, 'indents') then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    lazy = false,
    init = function()
      vim.g.no_plugin_maps = true
    end,
    config = function()
      local select = require 'nvim-treesitter-textobjects.select'
      local move = require 'nvim-treesitter-textobjects.move'

      require('nvim-treesitter-textobjects').setup {
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      }

      local select_map = function(lhs, query)
        vim.keymap.set({ 'x', 'o' }, lhs, function()
          select.select_textobject(query, 'textobjects')
        end, { desc = 'Treesitter textobject ' .. query })
      end

      local move_map = function(lhs, fn, query)
        vim.keymap.set({ 'n', 'x', 'o' }, lhs, function()
          fn(query, 'textobjects')
        end, { desc = 'Treesitter move ' .. query })
      end

      select_map('af', '@function.outer')
      select_map('if', '@function.inner')
      select_map('ac', '@class.outer')
      select_map('ic', '@class.inner')
      select_map('aa', '@parameter.outer')
      select_map('ia', '@parameter.inner')
      select_map('al', '@loop.outer')
      select_map('il', '@loop.inner')
      select_map('aI', '@conditional.outer')
      select_map('iI', '@conditional.inner')

      move_map(']f', move.goto_next_start, '@function.outer')
      move_map(']a', move.goto_next_start, '@parameter.outer')
      move_map(']c', move.goto_next_start, '@class.outer')
      move_map('[f', move.goto_previous_start, '@function.outer')
      move_map('[a', move.goto_previous_start, '@parameter.outer')
      move_map('[c', move.goto_previous_start, '@class.outer')
      move_map(']F', move.goto_next_end, '@function.outer')
      move_map(']C', move.goto_next_end, '@class.outer')
      move_map('[F', move.goto_previous_end, '@function.outer')
      move_map('[C', move.goto_previous_end, '@class.outer')
    end,
  },
}
