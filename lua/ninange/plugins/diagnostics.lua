return {
    "folke/trouble.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        -- Toggle "trouble" tool for diagnostics
        vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Open diagnostic" }),
        vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Open diagnostic" }),
        vim.keymap.set("n", "<leader>xw", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "workspace diagnostics" }),
        vim.keymap.set("n", "<leader>xd", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "document diagnostics" }),
        vim.keymap.set("n", "<leader>xq", "<cmd>Trouble loclist toggle<cr>", { desc = "quickfix" }),
        vim.keymap.set("n", "<leader>xl", "<cmd>Trouble qflist toggle<cr>", { desc = "loclist" }),
        vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end, { desc = "lsp_references" }),
    },
    init = function()
        vim.api.nvim_create_autocmd("VimLeavePre", {
            group = vim.api.nvim_create_augroup("trouble", { clear = true }),
            callback = function()
                vim.cmd("Trouble close")
            end
        })
    end

}
