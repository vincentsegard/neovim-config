M = {}

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Open file at the last position it was edited earlier
-- local misc_augroup = vim.api.nvim_create_augroup('Misc', { clear = true })
--   vim.api.nvim_create_autocmd('BufReadPost', {
--   desc = 'Open file at the last position it was edited earlier',
--   group = misc_augroup,
--   pattern = '*',
--   command = 'silent! normal! g`"zv'
-- })

-- autoformat on save
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function(args)
--     require("conform").format({ bufnr = args.buf })
--   end,
-- })

-- When vim launched, capslock = escape, trying dat way before making a rule in linux
local capslockstuff_group = vim.api.nvim_create_augroup('capslockstuff', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
  group = capslockstuff_group,
  callback = function()
    vim.cmd 'silent! !setxkbmap -option caps:escape'
  end,
})

-- -- When vim quitted, capslock = capslock
-- vim.api.nvim_create_autocmd('VimLeave', {
--   group = capslockstuff_group,
--   callback = function()
--     vim.cmd 'silent! !setxkbmap -option'
--   end,
-- })

-- hack to make sure Vim leave correctly with previous auto_cmd
vim.api.nvim_create_autocmd({ 'VimLeave' }, {
  callback = function()
    vim.cmd 'sleep 50m'
  end,
})

-- copy relative path to clipboard
vim.api.nvim_create_user_command("Cppath", function()
    local path = vim.fn.expand("%")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
return M
