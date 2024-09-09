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
    opts = {
      -- open Neotree
      vim.keymap.set('n', '<leader>n', '<Cmd>Neotree toggle<CR>', { desc = "Neotree" })
    },
    init = function()
      require('neo-tree').setup({
        -- Hack to auto quit Neotree before session.lua register current session
        vim.api.nvim_create_autocmd("VimLeavePre", {
          group = vim.api.nvim_create_augroup("neotree", { clear = true }),
          callback = function()
            vim.cmd('Neotree close')
          end
        }),
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
          follow_current_file = true,
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
