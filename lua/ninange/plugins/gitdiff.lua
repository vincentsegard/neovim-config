return {
 'sindrets/diffview.nvim',
  config = function()
    local diffview = require('diffview')
    diffview.setup({
      vim.api.nvim_create_autocmd("VimLeavePre", {
        group = vim.api.nvim_create_augroup("diffview", { clear = true }),
        callback = function()
          vim.cmd('DiffviewClose')
        end
      }),
    })
    vim.keymap.set('n', '<leader>f', '<CMD>DiffviewFileHistory %<CR>', { desc = 'Git history [F]ile' })
    vim.keymap.set('n', '<leader>g', '<CMD>DiffviewFileHistory<CR>', { desc = '[G]it history all' })
    vim.keymap.set('n', '<leader>o', '<CMD>DiffviewOpen<CR>', { desc = '[O]pen git diff' })
  end
}
