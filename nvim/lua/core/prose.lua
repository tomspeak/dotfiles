local api = vim.api
local opt_local = vim.opt_local

local function enable_soft()
  opt_local.spell = true
  opt_local.wrap = true
  opt_local.linebreak = true
  opt_local.conceallevel = 2
  opt_local.textwidth = 80

  local punctuations = { ",", ".", "?", "!" }
  for _, p in ipairs(punctuations) do
    vim.keymap.set("i", p, p .. "<C-g>u", { buffer = true, desc = "Add break after " .. p })
  end
end

local function enable_hard()
  opt_local.wrap = false
  opt_local.linebreak = false
end

local function setup_commands()
  api.nvim_buf_create_user_command(0, "PencilHard", function()
    enable_hard()
  end, { desc = "Switch to hard-wrap mode" })

  api.nvim_buf_create_user_command(0, "PencilSoft", function()
    enable_soft()
  end, { desc = "Switch to soft-wrap mode" })

  -- Word count command for prose
  api.nvim_buf_create_user_command(0, "WordCount", function()
    local words = vim.fn.wordcount().words
    local chars = vim.fn.wordcount().chars
    print(string.format("Words: %d | Characters: %d", words, chars))
  end, { desc = "Show word and character count" })
end

api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "rst", "txt", "tex", "mdx", "gitcommit" },
  callback = function()
    enable_soft()
    setup_commands()
  end,
})
