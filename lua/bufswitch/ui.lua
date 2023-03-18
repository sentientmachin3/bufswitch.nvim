local Menu = require("nui.menu")
local path = require("plenary.path")

local M = {}
function M.create_window(buffer_ids)
	local buf_names = {}
	for _, b in ipairs(buffer_ids) do
		local full_path = vim.api.nvim_buf_get_name(b)
		local cwd = vim.fn.getcwd()
		table.insert(buf_names, Menu.item(path:new(full_path):make_relative(cwd), { id = b }))
	end

	local menu = Menu({
		position = "50%",
		size = {
			width = 45,
			height = 5,
		},
		border = {
			style = "single",
			text = {
				top = "[Bufswitch]",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},
	}, {
		lines = buf_names,
		max_width = 20,
		keymap = {
			focus_next = { "j", "<Down>", "<Tab>" },
			focus_prev = { "k", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "<C-c>", "<A-a>"},
			submit = { "<CR>", "<Space>" },
		},
		on_submit = function(item)
           vim.api.nvim_set_current_buf(item.id)
		end,
	})
	-- mount the component
	menu:mount()
end

return M
