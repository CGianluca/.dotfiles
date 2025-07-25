vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)

    vim.o.updatetime = 250
    vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

    local opts = {buffer = event.buf}
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
--    vim.keymap.set('n', 'gk', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    -- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    --vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = 'Telescope find references' })
    --vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'Telescope find references' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = 'Telescope string grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F6>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F7>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F8>', function() require('dap').step_out() end)
vim.keymap.set('n', '<F11>', function() require('dap').restart() end)
vim.keymap.set('n', '<F12>', function()
    vim.g.state = "normal"
    require('dapui').close()
    require('dap').terminate()
end)
vim.keymap.set('n', '<Leader>bb', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>bl', function() require('dap').list_breakpoints() end)
vim.keymap.set('n', '<Leader>bc', function() require('dap').clear_breakpoints() end)
vim.keymap.set('n', '<Leader>sf', function() require('dap').focus_frame() end)
vim.keymap.set('n', '<Leader>sn', function() require('dap').up() end)
vim.keymap.set('n', '<Leader>sp', function() require('dap').down() end)
-- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end) toggle omnicompletition 
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)
