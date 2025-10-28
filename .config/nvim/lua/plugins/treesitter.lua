return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate", -- tells lazy that when update this plugin calls TSUpdate command (to rebuild all the new parsers)

        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "diff",
                    "html",
                    "javascript",
                    "jsdoc",
                    "json",
                    "jsonc",
                    "lua",
                    "luadoc",
                    "luap",
                    "markdown",
                    "markdown_inline",
                    "printf",
                    "python",
                    "ruby",
                    "query",
                    "regex",
                    "toml",
                    "tsx",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "xml",
                    "yaml",
                    "cmake",
                },
                sync_install = true,
                auto_install = true,
                ignore_install = {},
                highlight={
                    enable = true,
                    additional_vim_regex_highlighting=false,
                },
                indent = {
                    enable=true,
                },
                modules = {},
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = false,
                        node_decremental = "<bs>",
                    },
                },
                textobjects = {
                    move = {
                        enable = true,
                        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
                        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
                        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
                        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
                    },
                },
            })
        end,
    }
}
            --      ---@param opts TSConfig
            --      config = function(_, opts)
                --        if type(opts.ensure_installed) == "table" then
                --          opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
                --        end
                --        require("nvim-treesitter.configs").setup(opts)
                --      end,
