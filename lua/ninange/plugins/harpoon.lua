return {
  'ThePrimeagen/harpoon', branch = 'harpoon2',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim'
  },
  config = function()
    local harpoon = require('harpoon')
    harpoon:setup({})
    opts = { ui_nav_wrap = true }
    -- basic telescope configuration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
      end

      require('telescope.pickers').new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table({
              results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
      }):find()
    end

    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    vim.keymap.set('n', '<A-e>', function() toggle_telescope(harpoon:list()) end, { desc = 'Open harpoon window' })
    vim.keymap.set('n', '<leader>a', function() harpoon:list():append() end, { desc = 'Harpoon the file' })

    vim.keymap.set('n', '<A-j>', function() harpoon:list():select(1) end)
    vim.keymap.set('n', '<A-k>', function() harpoon:list():select(2) end)
    vim.keymap.set('n', '<A-l>', function() harpoon:list():select(3) end)
    vim.keymap.set('n', '<A-m>', function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<A-d>', function() harpoon:list():prev(opts) end)
    vim.keymap.set('n', '<A-f>', function() harpoon:list():next(opts) end)
  end
}
