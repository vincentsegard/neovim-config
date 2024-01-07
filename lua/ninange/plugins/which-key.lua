return  {
  -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  config = function(_, opts)
    require('which-key').setup(opts)
    local present, wk = pcall(require, 'which-key')
    if not present then
      return
    end
    wk.register({
      -- add group
      ['<leader>'] = {
        s = { name = '+search...' },
        h = { name = '+gitsign' },
        t = { name = '+blame' },
        x = { name = '+diagnostic' },
      },
    })
  end,
  setup = function()
    require('core.utils').load_mappings('whichkey')
  end,
}
