local popup = require("plenary.popup")

local M = {}

function M.create_window(buf_names, buffer_mappings)
	local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

	local bufnr = vim.api.nvim_create_buf(false, false)
	local width = 60
	local height = 10
	local win_id, _ = popup.create(bufnr, {
		title = "Bufswitch",
		line = math.floor(((vim.o.lines - height) / 2) - 1),
		col = math.floor((vim.o.columns - width) / 2),
		minwidth = width,
		minheight = height,
		borderchars = borderchars,
	})
	vim.api.nvim_win_set_option(win_id, "cursorline", true)
	vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, buf_names)
	vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
end

return M
