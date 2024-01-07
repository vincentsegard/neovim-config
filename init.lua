--[[
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
--]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

if vim.loader then
  vim.loader.enable()
end

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
require('lazy').setup({
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
	icons_enabled = true,
	theme = 'solarized-osaka',
	component_separators = '|',
	section_separators = '',
      },
      sections = {
	lualine_a = {
	  'buffers',
	},
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      indent = {
	char = "│",
	tab_char = "│",
      },
      scope = { enabled = true },
      exclude = {
	filetypes = {
	  "help",
	  "alpha",
	  "dashboard",
	  "neo-tree",
	  "Trouble",
	  "trouble",
	  "lazy",
	  "mason",
	  "notify",
	  "toggleterm",
	  "lazyterm",
	},
      },
    },
    main = "ibl",
  },

  {
    -- ZenMode 
    "folke/zen-mode.nvim",
    opts = {}
  },

  {
    -- Twilight
    "folke/twilight.nvim",
    opts = {}
  },

  -- 'gc' to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  { import = 'ninange.plugins' },
  { import = 'kickstart.plugins' },
  { import = 'config' },

}, {})

vim.notify = require("notify")
