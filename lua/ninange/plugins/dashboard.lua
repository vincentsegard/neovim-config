return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      --   opts = function(_, opts) 
      --    local logo = [[
      --     ███╗   ██╗██╗███╗   ██╗ █████╗ ███╗   ██╗ ██████╗ ███████╗
      --     ████╗  ██║██║████╗  ██║██╔══██╗████╗  ██║██╔════╝ ██╔════╝
      --     ██╔██╗ ██║██║██╔██╗ ██║███████║██╔██╗ ██║██║  ███╗█████╗  
      --     ██║╚██╗██║██║██║╚██╗██║██╔══██║██║╚██╗██║██║   ██║██╔══╝  
      --     ██║ ╚████║██║██║ ╚████║██║  ██║██║ ╚████║╚██████╔╝███████╗
      --     ╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝
      --   ]]
      --   logo = string.rep("\n", 8) .. logo .. "\n\n"
      --   opts.config.header = vim.split(logo, "\n")
      -- end,
    }
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
