return {
 'nvim-pack/nvim-spectre',
  config = function()
    local spectre = require('spectre')
    spectre.setup({})
    vim.keymap.set('n', '<leader>r', '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre" })
  end
}
