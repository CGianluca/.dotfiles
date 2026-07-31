return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require "dap"
            local dapui = require "dapui"

            require("dapui").setup(
                {
                    controls = {
                        element = "repl",
                        enabled = true,
                        icons = {
                            disconnect = "",
                            pause = "",
                            play = "",
                            run_last = "",
                            step_back = "",
                            step_into = "",
                            step_out = "",
                            step_over = "",
                            terminate = ""
                        }
                    },
                    element_mappings = {},
                    expand_lines = true,
                    floating = {
                        border = "single",
                        mappings = {
                            close = { "q", "<Esc>" }
                        }
                    },
                    force_buffers = true,
                    wrap = true,
                    icons = {
                        collapsed = "",
                        current_frame = "",
                        expanded = ""
                    },
                    layouts = { {
                        elements = { {
                            id = "stacks",
                            size = 0.5
                        }, {
                            id = "watches",
                            size = 0.25
                        }, {
                            id = "console",
                            size = 0.25
                        } },
                        position = "left",
                        size = 40
                    }, {
                        elements = { {
                            id = "scopes",
                            size = 1.0
                        }
                    },
                        position = "bottom",
                        size = 10
                    } },
                    mappings = {
                        edit = "e",
                        expand = { "<CR>", "<2-LeftMouse>" },
                        open = "o",
                        remove = "d",
                        repl = "r",
                        toggle = "t"
                    },
                    render = {
                        indent = 1,
                        max_value_lines = 100
                    }
                }
            )

            dap.listeners.before.attach.dapui_config = function()

                dapui.open()
                vim.g.state = "dap"
            end

            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
                vim.g.state = "dap"
            end

            dap.listeners.after.event_stopped["dapui_config"] = function()
                vim.defer_fn( function ()
                    local stack_buffer_id = dapui.elements.stacks:buffer()
                    local lines_number = vim.api.nvim_buf_line_count(stack_buffer_id);
                    local ns_id = vim.api.nvim_create_namespace("DAP_custom");

                    local base_line = 0;
                    local set_extmark = false;
                    for i = 0, lines_number do

                        local line = vim.api.nvim_buf_get_lines(stack_buffer_id, i, i + 1, false)[1];
                        if line == "" then
                            set_extmark = false;
                        end

                        if set_extmark then
                            local group = '';
                            if ((i - base_line)%2 == 0) then
                                group = 'even_line';
                            else
                                group = 'odd_line';
                            end

                            vim.api.nvim_buf_set_extmark(
                                stack_buffer_id,
                                ns_id,
                                i,
                                0,
                                {
                                    line_hl_group = group,
                                }
                            )
                        end

                        local inspect_table = vim.inspect_pos(stack_buffer_id, i, 0, {
                            semantic_tokens = true,
                            syntax = true,
                            treesitter = true,
                            extmarks = "all"
                        }).extmarks;

                        if (inspect_table[1] ~= nil) then
                            if ( (inspect_table[1].opts.hl_group == 'DapUIStoppedThread') or (inspect_table[1].opts.hl_group == 'DapUIThread')) then
                                vim.api.nvim_buf_set_extmark(
                                    stack_buffer_id,
                                    ns_id,
                                    i,
                                    0,
                                    {
                                        line_hl_group = 'thread_title',
                                    }
                                )
                                base_line = i;
                                set_extmark = true;
                            end
                        end
                    end
                end,
                    500
                )
            end

            dap.listeners.before.event_terminated.dapui_config = function()
                --dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                -- dapui.close()
            end

            dap.adapters.python = {
                type = 'executable';
                command = 'python3';
                args = { '-m', 'debugpy.adapter' };
            }

            dap.configurations.python = {
                {
                    type = 'python';
                    request = 'launch';
                    name = "Default";
                    program = "${file}";
                    pythonPath = function()
                        return '/usr/bin/python3'
                    end;
                },
            }

            dap.adapters.gdb_executable_root = {
                id = 'gdb_executable_root';
                type = 'executable';
                command = 'sudo';
                args = { 'gdb', '--quiet', '--interpreter=dap'};
            }

            dap.adapters.gdb_executable = {
                id = 'gdb_executable';
                type = 'executable';
                command = 'gdb';
                args = { '--quiet', '--interpreter=dap'};
            }
        end
    },

    {
        'theHamsta/nvim-dap-virtual-text',
        requires = {
            'nvim-treesitter/nvim-treesitter',
            'mfussenegger/nvim-dap',
        },
        enabled = false,
        config = function()
            require('nvim-dap-virtual-text').setup {
            }
        end
    },
}
