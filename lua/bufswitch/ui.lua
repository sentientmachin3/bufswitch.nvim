local popup = require("plenary.popup")
local path = require("plenary.path")

local M = {}
function M.create_window(buffers)
	local width = 60
	local height = 10
	local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
	local buf_names = {}
	for _, b in ipairs(buffers) do
        local full_path = vim.api.nvim_buf_get_name(b)
        local cwd = vim.fn.getcwd()
		table.insert(buf_names, path:new(full_path):make_relative(cwd))
	end

	local win_id = popup.create(buf_names, {
		title = "Bufswitch",
		highlight = "Bufswitch",
		line = math.floor(((vim.o.lines - height) / 2) - 1),
		col = math.floor((vim.o.columns - width) / 2),
		minwidth = width,
		minheight = height,
		borderchars = borderchars,
	})
	vim.api.nvim_win_set_option(win_id, "winhl", "Normal:BufswitchBorder")
	return win_id
end

return M
