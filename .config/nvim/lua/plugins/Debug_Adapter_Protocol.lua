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

            require("dapui").setup()

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
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
        end
    },

    {
        'theHamsta/nvim-dap-virtual-text',
        requires = {
            'nvim-treesitter/nvim-treesitter',
            'mfussenegger/nvim-dap',
        },
        config = function()
            require('nvim-dap-virtual-text').setup {
            }
        end
    },
}
