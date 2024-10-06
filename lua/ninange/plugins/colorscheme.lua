return {
  -- {
  --   'navarasu/onedark.nvim',
  --   priority = 1000,
  --   config = function()
  --     require('onedark').setup {
  --       style = 'darker'
  --     }
  --     -- vim.cmd.colorscheme 'onedark'
  --   end,
  -- },

  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
  },

  {
    'craftzdog/solarized-osaka.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require('solarized-osaka').setup {
        transparent = true,
      }
      vim.cmd.colorscheme 'solarized-osaka'
    end,

  },
}
