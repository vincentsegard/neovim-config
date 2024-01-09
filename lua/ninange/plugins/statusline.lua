-- statusline
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",

  config = function()
    require('lualine').setup({
      sections = {
        lualine_b = { { 'branch' } },
        lualine_c = { { 'filename', path = 1 } }
      },
      options = {
        theme = "solarized_dark",
      },
    })
  end
}
