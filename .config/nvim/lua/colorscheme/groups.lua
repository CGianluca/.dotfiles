local M = {}

local colors = require("colorscheme.palette")

M.setup = function()

    vim.api.nvim_set_hl(0, '@lsp.type.class.cpp', {})
    vim.api.nvim_set_hl(0, '@lsp.type.property.cpp', {})
    vim.api.nvim_set_hl(0, '@lsp.type.macro.cpp', {link="@keyword"})

  return {

    -- Standard
    -- Comment = { fg = colors.comment, italic = true },

    -- use :Inspect


    --Treesitter
    ["@keyword"] = { fg = colors.keyword },
    ["@string"] = { fg = colors.string },
    ["@function"] = { fg = colors.Function },
    ["Special"] = { fg = colors.Function },
    ["@constant"] = { fg = colors.variable },
    ["@type"] = { fg = colors.type },
    -- ["@module"] = { fg = colors.Function, bold=true, underline=true},
    ["@module"] = { fg = colors.module, bold=true, underline=false},
    -- type = { fg = colors.type },
    ["@number"] = { fg = colors.number },
    ["@boolean"] = { fg = colors.boolean },
    ["@operator"] = { fg = colors.operator },
    ["@variable"] = { fg = colors.variable },
    ["@comment"] = { fg = colors.comment }


  }
end

return M
