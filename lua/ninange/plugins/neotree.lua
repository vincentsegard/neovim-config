return {
  {
    -- Tree navigation/search for files & folders 
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('neo-tree').setup({

        close_if_last_window = true,
        window = {
          width = 35,
        },
        buffers = {
          follow_current_file = {
            enabled = true,
          },
        show_unloaded = true,
        },
        filesystem = {
          use_libuv_file_watcher = true,
          follow_current_file = {
            enabled = true,
          },
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
              'node_modules'
            },
            never_show = {
              '.DS_Store',
              'thumbs.db'
            },
          },
        },
      })
    end
  },
}
