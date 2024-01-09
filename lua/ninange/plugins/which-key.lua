return  {
  -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',

  opts = {
    window = {
      border = "single", -- none, single, double, shadow
    },
  },
  config = function(_, opts)
    require('which-key').setup(opts)
    local _, wk = pcall(require, 'which-key')
    wk.register({
      -- add group
      ['<leader>'] = {
        f = { name = '+search...' },
        s = { name = '+search...' },
        h = { name = '+gitsign' },
        t = { name = '+blame' },
        x = { name = '+diagnostic' },
      },
    })
  end,
  setup = function()
    require('core.utils').load_mappings('whichkey')
  end
}
