return {
    'mbbill/undotree',
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "Undo tree" }),
    init = function()
        -- Hack to auto quit Undotree before session.lua register current session
        vim.api.nvim_create_autocmd("VimLeavePre", {
            group = vim.api.nvim_create_augroup("undotree", { clear = true }),
            callback = function()
                vim.cmd('UndotreeHide')
            end
        })
    end
}
