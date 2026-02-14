return {
  -- LSP Configuration & Plugins
  { 'williamboman/mason.nvim', config = true },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig' },
  { 'j-hui/fidget.nvim', opts = {} },
  { 'folke/neodev.nvim' },

  -- LSP Server Configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      servers = function()
        local util = require('lspconfig.util') -- Charger lspconfig.util

        return {
          cssls = {},
          tailwindcss = {
            root_dir = util.root_pattern(".git"),
          },
          tsserver = {
            root_dir = util.root_pattern(".git"),
            single_file_support = false,
            settings = {
              typescript = {
                inlayHints = {
                  includeInlayParameterNameHints = "literal",
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
              javascript = {
                inlayHints = {
                  includeInlayParameterNameHints = "all",
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
            },
          },
          html = {},
          yamlls = {
            settings = {
              yaml = { keyOrdering = false },
            },
          },
          lua_ls = {
            single_file_support = true,
            settings = {
              Lua = {
                workspace = { checkThirdParty = false },
                completion = { workspaceWord = true, callSnippet = "Both" },
                hint = { enable = true, paramType = true },
                diagnostics = {
                  disable = { "incomplete-signature-doc", "trailing-space" },
                  groupSeverity = { strong = "Warning", strict = "Warning" },
                  groupFileStatus = { ["type-check"] = "Opened" },
                  unusedLocalExclude = { "_*" },
                },
                format = {
                  enable = false,
                  defaultConfig = {
                    indent_style = "space",
                    indent_size = "2",
                    continuation_indent_size = "2",
                  },
                },
              },
            },
          },
          gopls = {
            cmd = { "gopls", "serve" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            root_dir = require('lspconfig.util').root_pattern("go.work", "go.mod", ".git"),
            settings = {
              gopls = {
                -- Analyses à activer (pour diagnostics et linting)
                analyses = {
                  unusedparams = true,
                  shadow = true,
                  nilness = true,
                  unusedwrite = true,
                  useany = true,
                },
                -- Vérifie le code pendant la saisie
                staticcheck = true,
                -- Paramètres de complétion
                completeUnimported = true,
                usePlaceholders = true,
                -- Formatage
                gofumpt = true,    -- Utilisation de gofumpt pour un style de code strict
                -- Paramètres spécifiques aux utilisateurs
                codelenses = {
                  generate = true,    -- Génération de code (e.g., tests, stubs)
                  gc_details = true,    -- Affiche les détails de garbage collection
                  test = true,        -- Lenses pour l'exécution de tests
                  tidy = true,        -- Lenses pour 'go mod tidy'
                  vendor = true,        -- Lenses pour 'go mod vendor'
                },
                hints = {
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  compositeLiteralTypes = true,
                  constantValues = true,
                  functionTypeParameters = true,
                  parameterNames = true,
                  rangeVariableTypes = true,
                },
              },
            },
            -- Comportement lors de l'attachement à un buffer
            on_attach = function(_, bufnr)
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
              local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
              local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

              buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

              -- Raccourcis clavier LSP pour Go
              local opts = { noremap = true, silent = true }
              buf_set_keymap('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
              buf_set_keymap('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
              buf_set_keymap('n', '<leader>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)
            end,
          }
        }
      end,
    },
    init = function()
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>c', vim.lsp.buf.code_action, '[C]ode Action')
        nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        nmap('<leader>d', require('telescope.builtin').lsp_document_symbols, '[D]ocument Symbols')
        nmap('<leader>w', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace Symbols')
        nmap('M', vim.lsp.buf.hover, '[M]anual Hover Documentation')
        nmap('<C-s>', vim.lsp.buf.signature_help, 'Signature Documentation')
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
        nmap('<leader>F', '<CMD>Format<CR>', '[F]ormat code')
      end

      local servers = {
        gopls = { filetypes = { "go", "gomod", "gowork", "gotmpl" } },
        lua_ls = { Lua = { workspace = { checkThirdParty = false }, telemetry = { enable = false } } },
      }

      require('neodev').setup()
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup { ensure_installed = vim.tbl_keys(servers) }

      for server_name, server_opts in pairs(servers) do
        vim.lsp.config(server_name, {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = server_opts,
          filetypes = server_opts.filetypes,
        })
      end

      vim.lsp.enable(vim.tbl_keys(servers))
    end
  },
}

