local group = vim.api.nvim_create_augroup('user-ui-highlights', { clear = true })

local apply = function()
  vim.api.nvim_set_hl(0, 'MsgArea', { link = 'Normal' })
  vim.api.nvim_set_hl(0, 'MsgSeparator', { link = 'Normal' })
  vim.api.nvim_set_hl(0, 'ModeMsg', { link = 'Comment' })
  vim.api.nvim_set_hl(0, 'MoreMsg', { link = 'Comment' })
  vim.api.nvim_set_hl(0, 'Question', { link = 'Comment' })
end

apply()

vim.api.nvim_create_autocmd('ColorScheme', {
  group = group,
  callback = apply,
})
