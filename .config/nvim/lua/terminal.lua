vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
local state = {
    win = -1,
    buf = -1,
    main_buf = -1
}

local function create_terminal_floating_window(opts)
    opts = opts or {}

    local width = math.floor(vim.o.columns * 0.7)  -- 50% of the screen width
    local height = math.floor(vim.o.lines * 0.8)  -- 80% of the screen height

    local row = math.floor((vim.o.lines - height) / 2)  -- Center the window vertically
    local col = math.floor((vim.o.columns - width) / 2)  -- Center the window horizontally

    local buf = nil

    if vim.g.state == "dap" then
        buf = require("dapui").elements.repl.buffer()
    else
        if not vim.api.nvim_buf_is_valid(opts.main_buf) then
            buf = vim.api.nvim_create_buf(true, false)
            opts.main_buf = buf
        else
            buf = opts.main_buf
        end
    end


    local win = vim.api.nvim_open_win(
    buf,
    true, -- Floating window
    {
        relative = 'editor',
        width = width, -- Width of the window (adjust as needed)
        height = height,
        row = row, -- Vertical position (top)
        col = col, -- Horizontal position (left)
        border = "rounded",
        style = "minimal",
    }
    )

    return {win = win, buf = buf, main_buf=opts.main_buf}
end

local function toggle_terminal()
    if vim.api.nvim_win_is_valid(state.win) then
        vim.api.nvim_win_hide(state.win)
    else
        state = create_terminal_floating_window{buf = state.buf, main_buf = state.main_buf}
        if vim.g.state == "normal" and vim.bo[state.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
            vim.cmd.startinsert()
        end
    end
end
-- Call the function to create the floating terminal window

vim.api.nvim_create_user_command("Fterm", function()
    toggle_terminal()
end
, {})

vim.keymap.set({'n', 't'}, "<space>tt", toggle_terminal)








