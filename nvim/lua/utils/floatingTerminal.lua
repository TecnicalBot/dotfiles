vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { noremap = true, silent = true })

local state = {
	floating = {
		buf = nil,
		win = nil,
	},
}

local function create_floating_window(opts)
	opts = opts or {}
	local width = opts.width or math.floor(vim.o.columns * 0.8)
	local height = opts.height or math.floor(vim.o.lines * 0.8)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	local buf = state.floating.buf
	if not (buf and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal") then
		buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_option(buf, "bufhidden", "hide")
	end

	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	}

	local win = vim.api.nvim_open_win(buf, true, win_config)

	if vim.api.nvim_buf_line_count(buf) == 1 and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == "" then
		vim.fn.termopen(vim.o.shell or "bash")
		vim.cmd("startinsert")
	end

	state.floating.buf = buf
	state.floating.win = win
end

local function toggle_terminal()
	if state.floating.win and vim.api.nvim_win_is_valid(state.floating.win) then
		vim.api.nvim_win_hide(state.floating.win)
		state.floating.win = nil
	else
		create_floating_window()
	end
end

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})

vim.keymap.set("n", "<leader>t", toggle_terminal, { noremap = true, silent = true })
vim.keymap.set("t", "<leader>t", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
	vim.schedule(toggle_terminal)
end, { noremap = true, silent = true })
