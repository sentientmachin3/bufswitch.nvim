local ui = require("bufswitch.ui")
local utils = require("bufswitch.utils")
local M = {}

Bufswitch_win = nil

function M.toggle_quick_menu()
	if Bufswitch_win ~= nil and vim.api.nvim_win_is_valid(Bufswitch_win) then
		vim.api.nvim_win_close(Bufswitch_win, true)
		Bufswitch_win = nil
		return
	end

	local buffers = utils.get_buffers()
	local win_id = ui.create_window(buffers)
	Bufswitch_win = win_id
	vim.api.nvim_win_set_option(Bufswitch_win, "number", true)
end

function M.setup()
	vim.api.nvim_set_keymap("n", "<A-a>", "<Cmd>lua require('bufswitch').toggle_quick_menu()<CR>", { silent = true })
	vim.api.nvim_create_user_command("BufswitchToggle", M.toggle_quick_menu, {})
end

return M
