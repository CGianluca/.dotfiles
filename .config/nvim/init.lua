require("remap")
require("config.lazy")
require("terminal")

vim.cmd [[
    highlight Normal guibg=none
    highlight NonText guibg=none
    highlight Normal ctermbg=none
    highlight NonText ctermbg=none
]]

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
