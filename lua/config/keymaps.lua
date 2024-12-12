M = {}
-- mapleader defined in init.lua

-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()

-- -- disabling Ctrl+Z to avoid interrupt by mistake
vim.keymap.set('n', '<C-z>', '<Nop>')

-- Scroll keep cursor center
vim.keymap.set('n', '<PageUp>', '<PageUp>zz')
vim.keymap.set('n', '<PageDown>', '<PageDown>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<A-d>', '<C-d>zz')
vim.keymap.set('n', '<A-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Increment / Decrement
vim.keymap.set('n', '+', '<C-a>')
vim.keymap.set('n', '-', '<C-x>')

-- Select all
vim.keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Paste on highlighted without yank new highlight keeping old yank
vim.keymap.set('x', '<leader>p', '"_dp')

-- Replace highlighted text with whatever i type
vim.keymap.set('n', '<leader>S', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', { desc = '[S]ubstitute current highlighted' })

-- Move selected UP/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })

-- Cursor don't move when J
vim.keymap.set('n', 'J', 'mzJ`z')

-- Split
vim.keymap.set('n', 'ss', ':split<Return>')
vim.keymap.set('n', 'sv', ':vsplit<Return>')

-- set :w! as :SudaWrite
vim.keymap.set('c', 'W!', 'SudaWrite')

-- unbinding Arrows & ZZ & ZQ
-- vim.keymap.set({ 'n', 'v', 'i' }, '<Up>', '<nop>')
-- vim.keymap.set({ 'n', 'v', 'i' }, '<Down>', '<nop>')
-- vim.keymap.set({ 'n', 'v', 'i' }, '<Left>', '<nop>')
-- vim.keymap.set({ 'n', 'v', 'i' }, '<Right>', '<nop>')
vim.keymap.set('n', 'ZZ', '<nop>')
vim.keymap.set('n', 'ZQ', '<nop>')
vim.keymap.set('n', 'Q', '<nop>')

-- Window
vim.keymap.set('n', '<A-a>', '<C-w>w')
vim.keymap.set('n', '<A-q>', '<C-w>o')
vim.keymap.set('n', '<C-down>', '1<C-w>-')
vim.keymap.set('n', '<C-up>', '1<C-w>+')
vim.keymap.set('n', '<C-=>', '<C-w>=')

-- Tab
vim.keymap.set('n', '<A-PageUp>', 'gt')
vim.keymap.set('n', '<A-PageDown>', 'gT')
vim.keymap.set('n', '<A-w>', '<CMD>tabclose<CR>')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
-- vim.keymap.set('n', '!d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '!D', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', '!dd', function() require('trouble').toggle('document_diagnostics') end, { desc = 'document diagnostics' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics list (x is better)' })

-- Escaping research & notifications with Escape
vim.keymap.set('', '<Esc>', '<ESC>:noh<CR>:lua require("notify").dismiss()<CR>', { silent = true })

-- Hyperlink open with CTRL + Left Click
local openUrl = function()
  return function()
    local file = vim.fn.expand '<cWORD>'
    -- xdg-open(linux)
    local result = ':!open ' .. file
    if string.match(file, 'https') == 'https' or string.match(file, 'http') == 'http' then
      vim.cmd(result)
    else
      return print 'URL non détectée (placer curseur dessus)'
    end
  end
end
vim.keymap.set('n', '<C-LeftMouse>', openUrl(), { desc = 'OpenUrl Undercurword' })

-- alternate file bc azerty
vim.keymap.set('n', '<A-z>', '<C-^>')

-- quit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-N>')

-- current path to clipboard
vim.keymap.set('n', '<leader>p', [[:let @+ = expand('%') | lua print(vim.fn.expand('%'))<CR>]], { noremap = true, silent = true, desc = 'desc copy current [P]ath' })

-- tmux conf
-- vim.keymap.set('n', '<C-h>', '<cmd> TmuxNavigateLeft<CR>')
-- vim.keymap.set('n', '<C-j>', '<cmd> TmuxNavigateDown<CR>')
-- vim.keymap.set('n', '<C-k>', '<cmd> TmuxNavigateUp<CR>')
-- vim.keymap.set('n', '<C-l>', '<cmd> TmuxNavigateRight<CR>')

-- rebind ; to be as . because azerty
vim.api.nvim_set_keymap('n', ';', '.', { noremap = true, silent = true })

-- jump next first error lsp
vim.api.nvim_set_keymap('n', '<leader>r', ':lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>', { noremap = true, silent = true, desc = 'jump next ERROR' })


return M
