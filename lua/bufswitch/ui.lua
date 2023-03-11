local popup = require("plenary.popup")
local path = require("plenary.path")
local utils = require("bufswitch.utils")

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
    local buf_nr = vim.fn.winbufnr(win_id)
	vim.api.nvim_buf_set_option(buf_nr, "modifiable", false)
	vim.api.nvim_win_set_option(win_id, "cursorline", true)
	vim.api.nvim_win_set_option(win_id, "winhl", "Normal:BufswitchBorder")
	vim.api.nvim_buf_set_keymap(buf_nr, "n", "<CR>", "<Cmd>lua require('bufswitch.utils').on_buffer_selected()<CR>", { noremap = true })
	return win_id
end

return M
