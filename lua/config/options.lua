M = {}

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Cursor
vim.opt.guicursor= "n-v-c-sm:block,i-ci:ver30-iCursor-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20"

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
-- full gutters with absolute & relative:
-- vim.opt.nu = true
-- vim.opt.relativenumber = true
-- vim.o.statuscolumn = "%s %l %r "
-- gutter with relative (absolute just current line)
vim.wo.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
-- Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
-- May need to install xclip or wl-copy (and ssh maybe lemonade)
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Set default tab at 2 and use space as characters, can be override by plugins
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2

-- Display at least X lines before/after cursolr
vim.opt.scrolloff = 8
return M
