local path = require("plenary.path")

local M = {}
function M.get_buffers()
	local result = {}
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_get_option(bufnr, "buflisted") then
			table.insert(result, bufnr)
		end
	end

	return result
end

function M.get_buffer_names(buffer_ids)
	local buf_names_mapping = {}
	local buf_names = {}
	for i, b in ipairs(buffer_ids) do
		local full_path = vim.api.nvim_buf_get_name(b)
		local cwd = vim.fn.getcwd()
		local buf_name = path:new(full_path):make_relative(cwd)
		buf_names_mapping[buf_name] = b
		buf_names[i] = buf_name
	end
	return buf_names, buf_names_mapping
end

function M.on_buffer_selected()
	print("selected")
end

return M
