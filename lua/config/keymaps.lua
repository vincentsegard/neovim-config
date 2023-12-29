M = {}
-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- PageUp / PageDown
-- vim.keymap.set('n', '<PageUp>', '<C-u>')
-- vim.keymap.set('n', '<PageDown>', '<C-d>')

-- Increment / Decrement
vim.keymap.set('n', '+', '<C-a>')
vim.keymap.set('n', '-', '<C-x>')

-- Select all
vim.keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Select all
vim.keymap.set('n', 'ss', ':split<Return>')
vim.keymap.set('n', 'sv', ':vsplit<Return>')

-- set :w! as :SudaWrite
vim.keymap.set('c', 'w!', 'SudaWrite')

-- unbinding ZZ & ZQ
vim.keymap.set('n', 'ZZ', '')
vim.keymap.set('n', 'ZQ', '')

-- Window
vim.keymap.set('n', '<A-a>', '<C-w>w')
vim.keymap.set('n', '<A-left>', '<C-w>h')
vim.keymap.set('n', '<A-down>', '<C-w>j')
vim.keymap.set('n', '<A-up>', '<C-w>k')
vim.keymap.set('n', '<A-right>', '<C-w>l')
vim.keymap.set('n', '<A-h>', '<C-w>h')
vim.keymap.set('n', '<A-j>', '<C-w>j')
vim.keymap.set('n', '<A-k>', '<C-w>k')
vim.keymap.set('n', '<A-l>', '<C-w>l')
vim.keymap.set('n', '<C-down>', '1<C-w>-')
vim.keymap.set('n', '<C-up>', '1<C-w>+')
vim.keymap.set('n', '<C-=>', '<C-w>=')

-- Tab
vim.keymap.set('n', '<A-PageUp>', 'gt')
vim.keymap.set('n', '<A-PageDown>', 'gT')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'jb', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics list (x is better)' })

-- Escaping research & notifications with Escape
vim.keymap.set('',  '<Esc>', '<ESC>:noh<CR>:lua require("notify").dismiss()<CR>', {silent = true})

-- Hyperlink open with CTRL + Left Click
local openUrl = function()
    return function()
        local file = vim.fn.expand("<cWORD>")
        -- open(macos) || xdg-open(linux)
        local result = ":!open " .. file
        if
            string.match(file, "https") == "https"
            or string.match(file, "http") == "http"
        then
            vim.cmd(result)
        else
            return print("URL non détectée (placer curseur dessus)")
        end
    end
end
local open = openUrl()
vim.keymap.set("n", "<C-LeftMouse>", open, { desc = "OpenUrl Undercurword" })

-- open Neotree
vim.keymap.set('n', '<leader>n', '<Cmd>Neotree toggle<CR>', { desc = "Neotree"})

-- Toggle "trouble" tool for diagnostics
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end, { desc = "Open diagnostic" })
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, { desc = "workspace diagnostics" })
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end, { desc = "document diagnostics" })
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end, { desc = "quickfix" })
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end, { desc = "loclist" })
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end, { desc = "lsp_references" })

-- alternate file bc azerty
vim.keymap.set('n', '<A-f>', '<C-^>')

return M
