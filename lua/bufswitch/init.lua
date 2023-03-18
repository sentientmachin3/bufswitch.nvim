local ui = require("bufswitch.ui")
local utils = require("bufswitch.utils")
local M = {}

function M.toggle_menu()
	local buffers = utils.get_buffers()
	ui.create_window(buffers)
end

function M.setup()
	vim.api.nvim_set_keymap("n", "<A-a>", "<Cmd>lua require('bufswitch').toggle_menu()<CR>", { silent = true })
	vim.api.nvim_create_user_command("BufswitchToggle", M.toggle_menu, {})
end

return M
