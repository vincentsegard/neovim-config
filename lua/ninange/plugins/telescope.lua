return {
  'nvim-telescope/telescope.nvim', tag = '0.1.5',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  },
  config = function()
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')
    local custom_actions = {}

    function custom_actions.clean_empty_buffers()
        -- Get all buffer numbers
        local buffers = vim.api.nvim_list_bufs()

        -- Filter out buffers that are not listed, are empty, and are not modified
        local buffers_to_delete = {}
        for _, buf in ipairs(buffers) do
            if vim.api.nvim_buf_is_loaded(buf) and
               vim.fn.buflisted(buf) == 1 and
               vim.api.nvim_buf_get_name(buf) == '' and
               vim.api.nvim_buf_get_option(buf, 'modified') == false then
                table.insert(buffers_to_delete, buf)
            end
        end

        -- Delete the buffers if any are found
        if #buffers_to_delete > 0 then
            for _, buf in ipairs(buffers_to_delete) do
                vim.api.nvim_buf_delete(buf, {force = true})
            end
        end
    end

    -- Handle how to open multiples files viewed and tabed through telescope
    function custom_actions._multiopen(prompt_bufnr, open_cmd)
      local picker = action_state.get_current_picker(prompt_bufnr)
      -- local selected_entry = action_state.get_selected_entry()
      local num_selections = #picker:get_multi_selection()
      if num_selections == 1 then
        actions.add_selection(prompt_bufnr)
      end
      if num_selections >= 1 then
        actions.send_selected_to_qflist(prompt_bufnr)
        vim.cmd('cfdo ' .. open_cmd)
        -- close empty buffers
        custom_actions.clean_empty_buffers()
        -- disable insert mode after opening file
        vim.cmd('stopinsert')
      else
        actions.file_edit(prompt_bufnr)
      end

      -- open the quickfix list if there is more than one opened with enter key
      if open_cmd == 'edit' and num_selections > 1 then
        vim.cmd('copen')
      end
    end

    function custom_actions.multi_selection_open_vsplit(prompt_bufnr)
      custom_actions._multiopen(prompt_bufnr, 'vsplit')
    end

    function custom_actions.multi_selection_open_split(prompt_bufnr)
      custom_actions._multiopen(prompt_bufnr, 'split')
    end

    function custom_actions.multi_selection_open_tab(prompt_bufnr)
      custom_actions._multiopen(prompt_bufnr, 'tabe')
    end

    function custom_actions.multi_selection_open(prompt_bufnr)
      custom_actions._multiopen(prompt_bufnr, 'edit')
    end

    -- Telescope setup 
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<ESC>'] = actions.close,
            ['<C-J>'] = actions.move_selection_next,
            ['<C-K>'] = actions.move_selection_previous,
            ['<TAB>'] = actions.toggle_selection + actions.move_selection_next,
            -- switch both functions bc I open tab more often in my workflow
            ['<CR>'] = custom_actions.multi_selection_open,
            ['<C-CR>'] = custom_actions.multi_selection_open_vsplit,
            -- ['<C-S>'] = custom_actions.multi_selection_open_split,
            ['<C-A-CR>'] = custom_actions.multi_selection_open_tab,
            -- ['<C-DOWN>'] = require('telescope.actions').cycle_history_next,
            -- ['<C-UP>'] = require('telescope.actions').cycle_history_prev
          },
        },
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--hidden',
          '--smart-case'
        },
        layout_config = {
          vertical = {
            width = 0.95
          },
          horizontal = {
            width = 0.95
          },
        },
        path_display = function(_, path)
          local tail = require('telescope.utils').path_tail(path)
          return string.format('%s (%s)', tail, path)
        end,
        selection_strategy = 'reset',
        sorting_strategy = 'ascending',
        file_ignore_patterns = {
          'dist/.*',
          '%.git/.*',
          '%.vim/.*',
          'node_modules/.*',
          '%.idea/.*',
          '%.vscode/.*',
          '%.history/.*',
          '%.themes/.*'
        },
      },
    }

    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')

    -- Telescope live_grep in git root
    -- Function to find the git root directory based on the current buffer's path
    local function find_git_root()
      -- Use the current buffer's path as the starting point for the git search
      local current_file = vim.api.nvim_buf_get_name(0)
      local current_dir
      local cwd = vim.fn.getcwd()
      -- If the buffer is not associated with a file, return nil
      if current_file == '' then
        current_dir = cwd
      else
        -- Extract the directory from the current file's path
        current_dir = vim.fn.fnamemodify(current_file, ':h')
      end

      -- Find the Git root directory from the current file's path
      local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
      if vim.v.shell_error ~= 0 then
        print 'Not a git repository. Searching on current working directory'
        return cwd
      end
      return git_root
    end

    -- Custom live_grep function to search in git root
    local function live_grep_git_root()
      local git_root = find_git_root()
      if git_root then
        require('telescope.builtin').live_grep {
          search_dirs = { git_root },
        }
      end
    end

    vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

    -- See `:help telescope.builtin`
    vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    local function telescope_live_grep_open_files()
      require('telescope.builtin').live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end
    vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
    vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
    vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
    vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
  end
}