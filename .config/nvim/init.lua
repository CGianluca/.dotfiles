vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.state = "normal"

if vim.g.vscode then

    vim.o.modeline = false

    vim.keymap.set("n", "<leader>pv", function ()
        local vscode = require('vscode')
        vscode.action('workbench.view.explorer', {})
        -- vscode.action('workbench.action.focusSideBar', {})
        -- vscode.action('workbench.action.toggleSidebarVisibility', {})

    end)
    vim.keymap.set("n", "<leader>pc", function ()
        local vscode = require('vscode')
        -- vscode.action('workbench.view.explorer', {})
        -- vscode.action('workbench.action.focusSideBar', {})
        vscode.action('workbench.action.closeSidebar', {})

    end)

    vim.keymap.set("n", "<leader>tt", function ()
        require('vscode').action('workbench.action.togglePanel', {})
    end)

    vim.keymap.set("n", "<leader>ff", function ()
        require('vscode').action('workbench.action.quickOpen',{})
    end)

    vim.keymap.set("n", "<leader>fg", function ()
        require('vscode').action('workbench.action.findInFiles', {})
    end)

    vim.keymap.set("n", "gr", function ()
        require('vscode').action('editor.action.referenceSearch.trigger', {})
    end)
    --vim.api.nvim_create_autocmd({"BufEnter", "WinEnter"}, {
      --callback = function()
        -- Only act on normal files (skip explorer, terminals, etc.)
        -- if vim.bo.buftype == "" then
        --vim.fn.VSCodeNotify("workbench.action.closeSidebar")
        -- end
      --end,
    --})

else
    require("config.lazy")
    require("remap")
    require("terminal")

    vim.cmd [[
        highlight Normal guibg=none
        highlight NonText guibg=none
        highlight Normal ctermbg=none
        highlight NonText ctermbg=none
    ]]

    -- ASK pass used from the dap in case sudo is reuired
    -- Works, but not for the DAP
    -- vim.env.SUDO_ASKPASS = "/home/cgianluca/.dotfiles/.config/nvim/sudo-askpass.sh"

    vim.lsp.semantic_tokens.config = {
        enabled = true,
        priority = 50
    }

    vim.cmd 'colorscheme colorscheme'
    vim.g.have_nerd_font = true

    vim.opt.signcolumn = 'yes'
    vim.schedule(function()
        vim.opt.clipboard = "unnamedplus"
    end)

    vim.o.breakindent = true
    vim.o.undofile = true
    vim.o.ignorecase = true

    vim.o.signcolumn  = 'yes'

    vim.o.inccommand = 'split'
    vim.o.confirm = true

    vim.keymap.set('n', '<ESC>', '<cmd>nohlsearch<CR>')

    -- Configure how new splits should be opened
    vim.o.splitright = true
    vim.o.splitbelow = true

    vim.opt.nu = true
    vim.opt.relativenumber = true

    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true

    vim.opt.wrap = true
    vim.opt.linebreak = true

    vim.api.nvim_create_autocmd('TextYankPost', {
      desc = 'Highlight when yanking (copying) text',
      group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
      callback = function()
        vim.hl.on_yank()
      end,
    })

    vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''}) -- Those are whats app symbles.
    vim.fn.sign_define('DapStopped', {text='⚪', texthl='', linehl='', numhl=''})


    -----------
    -- TESTS --
    -----------
    --[[
    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
            -- print(vim.inspect(vim.lsp.get_client_by_id(args.data.client_id)))
            print(vim.lsp.get_client_by_id(args.data.client_id).name)
        end
    })
    --]]

end
