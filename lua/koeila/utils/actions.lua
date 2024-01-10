local action_state = require 'telescope.actions.state'
local actions = {}

local colorscheme_file = vim.fn.stdpath 'config' .. '/lua/koeila/utils/colorscheme.lua'

actions.save_colorscheme = function(prompt_bufnr)
	local entry = action_state.get_selected_entry(prompt_bufnr)

	vim.loop.fs_open(colorscheme_file, 'w', 432, function(_, fd)
		vim.loop.fs_write(fd, 'vim.cmd ' .. "'colorscheme " .. entry.value .. "'\n", nil, function()
			vim.loop.fs_close(fd)
		end)

		vim.loop.fs_write(
			fd,
			'\nvim.cmd[[hi Normal guibg=NONE ctermbg=NONE]]\nvim.cmd[[hi NonText guibg=NONE ctermbg=NONE]]\nvim.cmd[[hi SignColumn guibg=NONE ctermbg=NONE]]\nvim.cmd[[hi VertSplit guibg=NONE ctermbg=NONE]]\nvim.cmd[[hi FoldColumn guibg=NONE ctermbg=NONE]]\nvim.cmd[[hi StatusLine guibg=NONE ctermbg=NONE]]\nvim.cmd[[hi StatusLineNC guibg=NONE ctermbg=NONE]]',
			nil,
			function()
				vim.loop.fs_close(fd)
			end
		)
end)
end


return actions
