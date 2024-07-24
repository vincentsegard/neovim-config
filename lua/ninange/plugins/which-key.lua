return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        win = {
            border = "single", -- none, single, double, shadow
        },
    },
    keys = {
        { "<leader>f", group = "search..." },
        { "<leader>h", group = "gitsign" },
        { "<leader>s", group = "search..." },
        { "<leader>t", group = "blame" },
        { "<leader>x", group = "diagnostic" },

        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
