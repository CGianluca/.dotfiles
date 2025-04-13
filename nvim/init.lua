require("config.lazy")
require("remap")
require("terminal")

vim.cmd [[
    highlight Normal guibg=none
    highlight NonText guibg=none
    highlight Normal ctermbg=none
    highlight NonText ctermbg=none
]]

vim.opt.signcolumn = 'yes'

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = true
vim.opt.linebreak = true

--require('mason').setup({})
--require('mason-lspconfig').setup({
    --ensure_installed = { 'lua_ls'},
    --handlers = {
     --   function(server_name)
      --      require('lspconfig')[server_name].setup({})
       -- end,
--    }
--})

