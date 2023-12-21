function Map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

return {
   	dir = "/home/ninange/.config/nvim/lua/custom/plugins/mykeymaps",
   	lazy = false,
	config = function()
		vim.g.mapleader = ' '
        	Map('n', '<C-down>', '1<C-w>+')
        	Map('n', '<C-up>', '1<C-w>-')
	end
}
