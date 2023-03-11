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

function M.on_buffer_selected()
    print("selected")
end

return M
