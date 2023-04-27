local map = vim.api.nvim_set_keymap

-- Disable SPACE so we can use it as leader.
map("n", "<SPACE>", "<Nop>", { noremap = true })
map("v", "<SPACE>", "<Nop>", { noremap = true })

-- Set LEADER to SPACE
vim.g.mapleader = " "

-- Ctrl+W to save, Ctrl-Q to quit, Ctrl-x to quit+save
map("n", "<C-w>", ":w<CR>", { noremap = true })
map("n", "<C-q>", ":q<CR>", { noremap = true })
map("n", "<C-x>", ":x<CR>", { noremap = true })

-- Resize windows with arrows keys
map("n", "<Left>", ":3wincmd <<CR>", { noremap = true })
map("n", "<Right>", ":3wincmd ><CR>", { noremap = true })
map("n", "<Up>", ":3wincmd +<CR>", { noremap = true })
map("n", "<Down>", ":3wincmd -<CR>", { noremap = true })

-- Close quickfix window
map("n", "<leader>q", ":ccl<CR>", { noremap = true })

-- Allows us to, in visual mode, press 'r' and delete without putting into register. e.g. overwrite.
map("v", "r", '"_dP', {})

-- Yank to EOL
map("", "Y", "y$", {})

-- Telescope
map("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true })
map("n", "<C-f>", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { noremap = true })
map("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", { noremap = true })
map("n", "<leader>ds", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", { noremap = true })
map("n", "<leader>ws", "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>", { noremap = true })
map("n", "<leader>sf", "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true })
map("n", "<leader>sh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", { noremap = true })
map("n", "<leader>sw", "<cmd>lua require('telescope.builtin').grep_string()<cr>", { noremap = true })
map("n", "<leader>sd", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", { noremap = true })

-- NeovimTree
map("n", "-", [[<Cmd>NvimTreeToggle<CR>]], { noremap = true })
map("n", "_", [[<Cmd>NvimTreeFindFile<CR>]], { noremap = true })

-- Navigator
-- Move between windows with CTRL-HJKL
map("n", "<C-h>", [[<CMD>NavigatorLeft<CR>]], { noremap = true })
map("n", "<C-l>", [[<CMD>NavigatorRight<CR>]], { noremap = true })
map("n", "<C-k>", [[<CMD>NavigatorUp<CR>]], { noremap = true })
map("n", "<C-j>", [[<CMD>NavigatorDown<CR>]], { noremap = true })

-- Copilot
vim.cmd([[imap <silent><script><expr> <C-e> copilot#Accept("\<CR>")]])
vim.g.copilot_no_tab_map = true
vim.g.copilot_filetypes = { xml = false, markdown = false }
