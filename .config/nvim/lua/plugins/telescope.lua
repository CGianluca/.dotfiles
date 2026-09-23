return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            defaults = {
                layout_strategy = 'vertical',
                layout_config = {
                    prompt_position = 'bottom',
                    height = 0.90,
                    preview_height = 0.70,
                    scroll_speed = 1,
                },
                mappings = {
                    i = {
                       ["<M-v>"] = "select_vertical",
                       ["<M-s>"] = "select_horizontal",
                       ["<M-k>"] = "preview_scrolling_up",
                       ["<M-j>"] = "preview_scrolling_down",
                    },
                    n = {
                       ["<M-v>"] = "select_vertical",
                       ["<M-s>"] = "select_horizontal",
                       ["<M-k>"] = "preview_scrolling_up",
                       ["<M-j>"] = "preview_scrolling_down",
                       ["<C-p>"] = "move_selection_previous",
                       ["<C-n>"] = "move_selection_next",
                    },
                }
            },
        },
        config = function(_, opts)

            require('telescope').setup(opts)

        end,
    }
}
