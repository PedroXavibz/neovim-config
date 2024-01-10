local status_ok, term = pcall(require, 'toggleterm')

if not status_ok then
	return
end

term.setup({
	size = function(term)
		if term.direction == 'horizontal' then
			return 12
		end
		return 20
	end,
	open_mapping = [[<A-i>]],
	hide_numbers = true,
	shading_factor = 2,
	shade_terminals = true,
	start_in_insert = true,
	insert_mappings = true,
	shade_filetypes = {},
	persist_size = true,
	persist_mode = true,
	direction = 'float', -- 'float' | 'vertical' | 'horizontal' | 'tab'
	close_on_exit = true,
	shell = vim.o.shell,
	auto_scroll = true,
	autochdir = false,
	float_opts = {
		border = 'curved',
		winblend = 0,
		highlights = {
			border = 'Normal',
			background = 'Normal',
		},
	},
})

function _G.set_terminal_keymaps()
	-- set keymaps
	require('koeila.keymaps.plugins').set_terminal.buffer(0)
end

vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

-- set keymaps
require('koeila.keymaps.plugins').set_terminal.handlers()
