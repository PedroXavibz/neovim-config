local status_ok, telescope = pcall(require, 'telescope')

if not status_ok then
	return
end

local actions = require 'telescope.actions'
local action_layout = require 'telescope.actions.layout'
local my_actions = require 'koeila.utils.actions'

-- set keymaps
require('koeila.keymaps.plugins').set_telescope()

telescope.setup({
	extensions = {
		['ui-select'] = {
			require('telescope.themes').get_dropdown({}),
		},
	},

	defaults = {
		vimgrep_arguments = {
			'rg',
			'-L',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case',
		},
		prompt_prefix = '   ',
		selection_caret = '  ',
		entry_prefix = '  ',
		initial_mode = 'insert',
		selection_strategy = 'reset',
		sorting_strategy = 'ascending',
		layout_strategy = 'horizontal',
		layout_config = {
			horizontal = {
				prompt_position = 'top',
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		file_sorter = require('telescope.sorters').get_fuzzy_file,
		file_ignore_patterns = {
			'*.o',
			'node_modules',
			'__pycache__',
			'env',
			'venv',
		},
		generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
		path_display = { 'truncate' },
		winblend = 0,
		border = {},
		borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
		color_devicons = true,
		set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
		file_previewer = require('telescope.previewers').vim_buffer_cat.new,
		grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
		qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
		buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
		mappings = {
			n = {
				['<M-p>'] = action_layout.toggle_preview,
				['<C-e>'] = actions.preview_scrolling_down,
				['<C-y>'] = actions.preview_scrolling_up,
				['<M-e>'] = actions.preview_scrolling_left,
				['<M-y>'] = actions.preview_scrolling_right,

				['<C-q>'] = actions.close,
			},
			i = {
				['<C-j>'] = actions.move_selection_next,
				['<C-k>'] = actions.move_selection_previous,

				['<M-p>'] = action_layout.toggle_preview,
				['<C-e>'] = actions.preview_scrolling_down,
				['<C-y>'] = actions.preview_scrolling_up,
				['<M-e>'] = actions.preview_scrolling_left,
				['<M-y>'] = actions.preview_scrolling_right,

				['<C-q>'] = actions.close,
				['<C-d>'] = actions.delete_buffer + actions.move_to_top,
				['<C-c>'] = false, -- Exit to insert mode
				['<C-u>'] = false, -- Delete prompt test

        ['<C-s>'] = my_actions.save_colorscheme
			},
		},
	},

	extensions_list = { 'themes', 'terms' },
})

telescope.load_extension 'ui-select'
