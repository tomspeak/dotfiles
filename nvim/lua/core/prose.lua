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
    vim.keymap.set("i", p, p .. "<C-g>u", { buffer = true })
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
end

api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "rst" },
  callback = function()
    enable_soft()
    setup_commands()
  end,
})
