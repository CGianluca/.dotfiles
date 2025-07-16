return {
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate", -- tells lazy that when update this plugin calls TSUpdate command (to rebuild all the new parsers)
      opts = {
        highlight = { -- Higlight variable informations
            enable = true,
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            additional_vim_regex_highlighting = true -- required for some leanguages like Ruby
        },
        indent = { enable = true },
        ensure_installed = {
          "bash",
          "c",
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
      },
--      ---@param opts TSConfig
--      config = function(_, opts)
--        if type(opts.ensure_installed) == "table" then
--          opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
--        end
--        require("nvim-treesitter.configs").setup(opts)
--      end,
    }
}
