local opts = { noremap = true, silent = true, desc = '' }

return {
	set = function(new_keymaps)
		local keymap = vim.api.nvim_set_keymap
		for map_mode, map_table in pairs(new_keymaps) do
			for map, command in pairs(map_table) do
				opts['desc'] = command[2]
				keymap(map_mode, map, command[1], opts)
			end
		end
	end,

	set_buffer = function(bufnr, new_keymaps)
		local keymap = vim.api.nvim_buf_set_keymap
		for map_mode, map_table in pairs(new_keymaps) do
			for map, command in pairs(map_table) do
				opts['desc'] = command[2]
				keymap(bufnr, map_mode, map, command[1], opts)
			end
		end
	end,
}
