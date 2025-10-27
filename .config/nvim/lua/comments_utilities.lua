local M = {}

M.comment_table = {
    lua = {
        oneline='-- ',
        start_block=[[--[[]],
        end_block=']]--',
    },
    cpp = {
        oneline='// ',
        start_block=' /* ',
        end_block=' */ '
    },
    c = {
        oneline='// ',
        start_block=' /* ',
        end_block=' */ '
    },
    h = {
        oneline='// ',
        start_block=' /* ',
        end_block=' */ '
    },
}


function M.Insert_comment (args)

    local cursor_position = vim.fn.getpos('.')
    local starting_column = cursor_position[3]
    local l = vim.fn.getbufoneline(vim.fn.bufname(), cursor_position[2])
    local s_l = l:find('[^ ]')
    cursor_position[3] = s_l
    vim.fn.setpos('.', cursor_position)

    local hl_groups = vim.treesitter.get_captures_at_cursor(0)
    local is_comment = false

    for _, group in pairs(hl_groups) do
        if(group == 'comment') then
            is_comment = true;
            break
        end
    end

    if is_comment then
        local line = vim.fn.getbufoneline(vim.fn.bufname(), cursor_position[2])
        local idx = vim.fn.strridx(line, args.oneline, s_l+1)

        if (idx > -1) then
            print(idx, idx+string.len(args.oneline))
            vim.api.nvim_buf_set_text(0, cursor_position[2]-1, idx, cursor_position[2]-1, idx+string.len(args.oneline), {''})
            -- Check if the character next to -- is a space
        else
            -- search for the block comment
            local i = cursor_position[2]
            idx = -1
            while(i>-1 and idx<0) do
                line = vim.fn.getbufoneline(vim.fn.bufname(), i)
                idx = vim.fn.strridx(line, args.start_block)
                i = i-1
            end
            if (idx > -1) then
                vim.api.nvim_buf_set_text(0, i, idx, i, idx+string.len(args.start_block), {''})
            end

            local max_line = vim.api.nvim_buf_line_count(0)
            i = cursor_position[2]
            idx = -1
            while(i <= max_line and idx<0) do
                line = vim.fn.getbufoneline(vim.fn.bufname(), i)
                idx = vim.fn.strridx(line, args.end_block)
                i = i+1
            end
            if (idx > -1) then
                vim.api.nvim_buf_set_text(0, i-2, idx, i-2, idx+string.len(args.end_block), {''})
            end
        end

    elseif (vim.api.nvim_get_mode().mode == 'n') then
        local line = vim.fn.getbufoneline(vim.fn.bufname(), cursor_position[2])
        if (not is_comment) then
            local idx = line:find('[^ ]')
            if(idx ~= nil and args.oneline ~= nil) then

                vim.api.nvim_buf_set_text(0, cursor_position[2]-1, idx-1, cursor_position[2]-1, idx-1, {args.oneline})
            end
        end

    elseif (vim.api.nvim_get_mode().mode == 'v') then
        if(not is_comment and args.start_block ~= nil and args.end_block ~= nil) then

            local start_position = vim.fn.getpos("v")
            local end_position = vim.fn.getpos(".")

            vim.api.nvim_buf_set_text(0, start_position[2]-1, start_position[3]-1, start_position[2]-1, start_position[3]-1, {args.start_block})
            vim.api.nvim_buf_set_text(0, end_position[2]-1, end_position[3]-1, end_position[2]-1, end_position[3]-1, {args.end_block})
        end
    end

    cursor_position[3] = starting_column
    vim.fn.setpos('.', cursor_position)

    -- vim.api.nvim_feedkeys("I-- <Esc>", 'n', false)
    -- vim.treesitter.get_captures_at_cursor(0)))
    -- vim.api.nvim_but_set_text(0, 75, 0, 75, 0, {'ciao'})
    -- vim.api.nvim_win_get_cursor(0)
    -- vim.fn.getpos("'<")
    -- ivm.fn.getpos(">'")
    -- vim.fn.getbufoneline(vim.fn.bufname(),  linenm) return a line as string
    -- nvim_get_hl_id_by_name({name})                      *nvim_get_hl_id_by_name()*
    --
    -- vim.fn.execute('ls') just to execute a command on linux
    -- echo stridx("An Example", "Example")     " 3
    -- print(tostring(vim.api.nvim_get_current_line()))
    -- strridx({haystack}, {needle} [, {start}])
end

return M
