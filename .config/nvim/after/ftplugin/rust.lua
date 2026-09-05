-- Rust uses apostrophes heavily for lifetimes and labels. Keep quote pairing in
-- other filetypes, but make `'` literal in Rust buffers.
vim.keymap.set('i', "'", "'", { buf = 0 })

local undo = [[execute "silent! iunmap <buffer> '"]]
vim.b.undo_ftplugin = (vim.b.undo_ftplugin and vim.b.undo_ftplugin .. ' | ' or '') .. undo
