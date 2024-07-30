-- statusline
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",

  config = function()
    require('lualine').setup({
      sections = {
        lualine_a = { 'mode',
          function()
              local reg = vim.fn.reg_recording()
              if reg == '' then return '' end -- not recording
              return 'recording to ' .. reg
          end
        }
      },
      lualine_b = { 'branch' },
      lualine_c = { 'filename', path = 1 },
      options = {
        theme = "solarized_dark",
      },
    })
  end
}
