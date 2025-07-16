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
              { 'j-hui/fidget.nvim', opts = {} },

              -- Allows extra capabilities provided by blink.cmp
              'saghen/blink.cmp',
        },
        config = function()

            local servers = {
                "lua_ls",
                "pylsp",
                "stylua",
            }

            local conf = {
                settings = {
                    pylsp = {
                        configurationSources = { 'flake8' },
                        plugins = {
                            flake8 = {
                                enabled = "true",
                                ignore = {'E501', 'E231'},
                                extendIgnore = {'E501', 'E231'},
                                maxLineLength = 120,
                            },
                            pycodestyle = {
                                enaled = "true",
                                ignore = {'W391', 'E501', 'E231'},
                                maxLineLength = 120,
                            },
                            pylint = { 
                                enabled = "true",
                                args = {'--ignore=E501,E231', '-'},
                            },
                            pyflakes = { enabled = "true" },
                            mccabe = {enabled = "true" },
                            pydocstyle = { enabled = "true" },
                            autopep8 = { enaled = "true" },
                        }
                    },
                    Lua = {
                        completition = {
                            callSnippet = 'Replace',
                        },
                    },
                },
            }

            conf.capabilities = require('blink.cmp').get_lsp_capabilities()
            vim.lsp.config('pylsp', conf) -- Set the configuration for the lsp server
            -- Creating the list of the things mason is required to install
            -- local ensure_installed = vim.tbl_keys(servers or {})
            -- vim.list_extend(servers, {
            --   'stylua', -- Used to format Lua code
            -- })

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
        event = 'VimEnter',
        version = '1.*',
        dependencies = {
            {
                'L3MON4D3/LuaSnip',
                version = '2.*',
                build = (function()
              -- Build Step is needed for regex support in snippets.
              -- This step is not supported in many windows environments.
              -- Remove the below condition to re-enable on windows.
                    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
                dependencies = {
              -- `friendly-snippets` contains a variety of premade snippets.
              --    See the README about individual language/framework/plugin snippets:
              --    https://github.com/rafamadriz/friendly-snippets
              -- {
              --   'rafamadriz/friendly-snippets',
              --   config = function()
              --     require('luasnip.loaders.from_vscode').lazy_load()
              --   end,
              -- },
                },
                opts = {},
            },
            'folke/lazydev.nvim',
        },
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
                    auto_show = true,
                    auto_show_delay_ms = 500,
                    window = { border = 'single' },
                },
                menu = { border = 'single' }
            },
            -- Shows a signature help window while you type arguments for a function
            signature = {
                enabled = true,
                window = { border = 'single' }
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
                },
            },

            snippets = {preset = 'luasnip'},

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

