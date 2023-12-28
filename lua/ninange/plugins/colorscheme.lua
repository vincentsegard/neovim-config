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
  {
    'craftzdog/solarized-osaka.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require('solarized-osaka').setup {
        transparent = false,
      }
      vim.cmd.colorscheme 'solarized-osaka'
    end,

  },
}
