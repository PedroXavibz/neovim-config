local keymap = require 'koeila.utils.keymap'
vim.g.mapleader = ' '
vim.g.maploalleader = ' '

local keymaps = {
	-- [[ Normal ]]
	n = {
		-- File stuffs [Save, exit]
		['<leader>Q'] = { '<cmd>q<cr>', 'Exit neovim' },
		['<leader>q'] = { '<cmd>bd<cr>', 'Close current buffer' },
		['<C-s>'] = { '<cmd>w<cr>', 'Save file' },

    -- Buffer navigation
		['<Tab>'] = { '<cmd>bnext<cr>', 'Next buffer' },
		['<S-Tab>'] = { '<cmd>bprevious<cr>', 'Previous buffer' },

		-- Window navigation
		['<C-l>'] = { '<C-w>l', 'Focus right window' },
		['<C-h>'] = { '<C-w>h', 'Focus left window' },
		['<C-j>'] = { '<C-w>j', 'Focus bottom window' },
		['<C-k>'] = { '<C-w>k', 'Focus up window' },

    -- Window Resize
		['<C-Right>'] = { '<cmd>vertical resize +5<cr>', 'Resize +5 rigth window' },
		['<C-Left>'] = { '<cmd>vertical resize -5<cr>', 'Resize -5 left window' },
		['<C-Up>'] = { '<cmd>horizontal resize +5<cr>', 'Resize +5 up window' },
		['<C-Down>'] = { '<cmd>horizontal resize -5<cr>', 'Resize -5 bottom window' },

		-- Indent
		['>'] = { '>>', 'Indent ->' },
		['<'] = { '<<', 'Indent <-' },

		-- Stuffs
		['dr'] = { '<C-.>', 'Do last action' },

    ['n'] = {'nzzzv', ''},
    ['N'] = {'Nzzzv', ''},

    ['J'] = { 'mzJ`z', ''},

		['<A-l>'] = { 'g_', 'End line' },
		['<A-h>'] = { '^', 'Begginer line' },

    ['<C-d>'] = { '<C-d>zz', 'Down on middle of screen' },
    ['<C-u>'] = { '<C-u>zz', 'Up on middle of screen' },

		['<Esc>'] = { ':noh <CR>', 'Clear highlights' },

		['<F1>'] = { '<cmd>so %<CR>', 'Source nvim' },

		['<F5>'] = { '<cmd>Mason<CR>', 'Open mason' },

		['<leader>l'] = { '<cmd>wincmd w<CR>', 'Docs: Focus floating window' },

		-- line numbers
		['<leader>n'] = { '<cmd> set nu! <CR>', 'Toggle line number' },
		['<leader>nr'] = { '<cmd> set rnu! <CR>', 'Toggle relative number' },

		-- Copy | Paste | Cut
		['<leader>x'] = { '"+x', 'Clipboard: Cut' },
		['<leader>y'] = { '"+y', 'Clipboard: Copy' },
		['<leader>p'] = { '"+p', 'Clipboard: Paste' },
		['<leader>P'] = { '"+P', 'Clipboard: Paste' },
	},

	-- [[ Insert ]]
	i = {},

	-- [[ Visual ]]
	v = {
		-- Copy | Paste | Cut
		['<leader>x'] = { '"+x', 'Clipboard: Cut' },
		['<leader>y'] = { '"+y', 'Clipboard: Copy' },
		['<leader>p'] = { '"+p', 'Clipboard: Paste' },
		['<leader>P'] = { '"+P', 'Clipboard: Paste' },

    -- Stuffs
    ['<A-l>'] = { 'g_', 'End line' },
    ['<A-h>'] = { '^', 'Begginer line' },

    ['K'] = { "<cmd>m '<-2<CR>gv=gv", 'Move text up' },
    ['J'] = { "<cmd>m '>+1<CR>gv=gv", 'Move text down' },

    -- Stay indent mode
    ['<'] = { '<gv', 'Visual mode: Indent ->' },
		['>'] = { '>gv', 'Visual mode: Indent ->' },
	},
}

keymap.set(keymaps)

-- Reload init.lua when saving
vim.api.nvim_exec(
	[[
augroup reload_config
  autocmd!
  autocmd BufWritePost $NVIM_DIR/lua/koeila/keymaps/init.lua luafile $NVIM_DIR/lua/koeila/keymaps/init.lua
augroup END
]],
	false
)
