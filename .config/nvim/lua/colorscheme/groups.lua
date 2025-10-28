local M = {}

local colors = require("colorscheme.palette")

M.setup = function()

    vim.api.nvim_set_hl(0, '@lsp.type.class.cpp', {})

  return {

    -- Standard
    -- Comment = { fg = colors.comment, italic = true },
    
    -- use :Inspect

    
    --Treesitter
    ["@keyword"] = { fg = colors.keyword },
    ["@string"] = { fg = colors.string },
    ["@function"] = { fg = colors.Function },
    ["@constant"] = { fg = colors.constant },
    ["@type"] = { fg = colors.type },
    ["@module"] = { fg = colors.Function, bold=true, underline=true},
    -- type = { fg = colors.type },
    ["@number"] = { fg = colors.number },
    ["@boolean"] = { fg = colors.boolean },
    ["@operator"] = { fg = colors.operator },
    ["@variable"] = { fg = colors.variable },
    ["@comment"] = { fg = colors.comment }


  }
end

return M
