return {
    {
        'folke/lazydev.nvim', -- confgures Lua LSP for neovim config, runtime and plugins
        ft = 'lua',
        opts = {
            library = {
        -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
              -- Automatically install LSPs and related tools to stdpath for Neovim
              -- Mason must be loaded before its dependents so we need to set it up here.
              -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
              { 'mason-org/mason.nvim', opts = {} },
              'mason-org/mason-lspconfig.nvim',
              'WhoIsSethDaniel/mason-tool-installer.nvim',

              -- Useful status updates for LSP.
--              { 'j-hui/fidget.nvim', opts = {} },

              -- Allows extra capabilities provided by blink.cmp
              'saghen/blink.cmp',
        },
        config = function()

            local servers = {
                "lua_ls",
                "pylsp",
                "stylua",
                "clangd",
            }

            local conf_py = {
                settings = {
                    pylsp = {
                        configurationSources = { 'flake8' },
                        plugins = {
                            flake8 = {
                                enabled = "true",
                                ignore = {'E501', 'E231', 'E265', 'D213'},
                                maxLineLength = 120,
                            },
                            pycodestyle = {
                                enaled = "true",
                                ignore = {'W391', 'E501', 'E231', 'E265', 'D213'},
                                maxLineLength = 120,
                            },
                            pylint = {
                                enabled = "true",
                                args = {'--ignore=E501,E231,E265,D213', '-'},
                            },
                            pyflakes = { enabled = "true" },
                            mccabe = {enabled = "true" },
                            pydocstyle = {
                                enabled = "true",
                                ignore = {'E265', 'D213'},
                            },
                            autopep8 = { enaled = "true" },
                        }
                    },
                },
            }

            conf_py.capabilities = require('blink.cmp').get_lsp_capabilities()

            -- Creating the list of the things mason is required to install
            -- local ensure_installed = vim.tbl_keys(servers or {})
            -- vim.list_extend(servers, {
            --   'stylua', -- Used to format Lua code
            -- })

            vim.lsp.config('pylsp', conf_py) -- Set the configuration for the lsp server

            require('mason-tool-installer').setup { ensure_installed = servers }

            require('mason-lspconfig').setup {
                ensure_installed = {}, -- populated with mason-tool-installer
                automatic_installation = true,
                automatic_enable = true,
            }

        end,
    },
    { -- Autocompletion
        'saghen/blink.cmp',
        -- event = 'VimEnter',
        version = '1.*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'default' },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = {
                documentation = {
                    auto_show = false,
                },
            },
            -- Shows a signature help window while you type arguments for a function

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

--            snippets = {preset = 'luasnip'},

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = {
                implementation = "prefer_rust",
                sorts = {"sort_text"},
            },
        },
        -- opts_extend = { "sources.default" }
    }
}

