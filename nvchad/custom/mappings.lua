---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["-"] = { "<cmd> NvimTreeToggle <CR>", "NvimTree Toggle" },
    ["_"] = { "<cmd> NvimTreeFindFile <CR>", "NvimTree Toggle" },
  },
}

M.lspconfig = {
  n = {
    ["<leader>ca"] = {
      "<cmd>Lspsaga code_action<CR>",
      "Lspsaga code action",
    },
  },
}

-- more keybinds!

return M
