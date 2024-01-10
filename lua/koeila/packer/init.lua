local fn = vim.fn
local INSTALL_PATH = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

local is_present, packer = pcall(require, 'packer')
if not is_present and fn.empty(fn.glob(INSTALL_PATH)) > 0 then
	-- Install packer.nvim
	PACKER_BOOTSTRAP = fn.system({
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		INSTALL_PATH,
	})

	-- Check for installation
	vim.cmd [[packadd packer.nvim]]

	is_present, packer = pcall(require, 'packer')
	if is_present then
		vim.notify('packer.nvim installation successful.', vim.log.levels.INFO)
	else
		vim.notify('packer.nvim installation failed.', vim.log.levels.ERROR)
		return
	end
end

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost */lua/koeila/packer/init.lua source <afile> | PackerCompile
  augroup end
]]

packer.init({
	max_jobs = 8,
	compile_path = fn.stdpath 'config' .. '/plugin/packer_compiled.lua', -- for impatient caching
	display = {
		open_fn = function()
			return require('packer.util').float({ border = 'rounded' })
		end,
	},
	auto_clean = true,
	compile_on_sync = true,
	autoremove = true,
})

vim.loader.enable()

return packer.startup(function(use)
	-- NOTE: [[ PACKER STUFFS 📦 ]]
	-- Have packer manage itself
	use({
		'wbthomason/packer.nvim',
		commit = 'ea0cc3c59f67c440c5ff0bbe4fb9420f4350b9a3',
	})

	-- An implementation of the Popup API from vim in Neovim
	use({
		'nvim-lua/popup.nvim',
		commit = 'b7404d35d5d3548a82149238289fa71f7f6de4ac',
	})

	-- Useful lua functions used ny lots of plugins
	use({
		'nvim-lua/plenary.nvim',
		commit = '9ce85b0f7dcfe5358c0be937ad23e456907d410b',
	})

	-- SQLite LuaJIT binding with a very simple api.
	use({
		'kkharji/sqlite.lua',
		commit = 'b7e28c8463254c46a8e61c52d27d6a2040492fc3',
	})
	-- ▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋

	-- NOTE: [[ COLORSCHEMES 🎨 ]]
	use({
		'Mofiqul/vscode.nvim',
		'ellisonleao/gruvbox.nvim',
	})
	-- ▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋

	-- NOTE: [[ UI 💡]]
	-- This plugin provides the same icons as well as colors for each icon.
	use({
		'nvim-tree/nvim-web-devicons',
		commit = '973ab742f143a796a779af4d786ec409116a0d87',
	})

	--  A neovim plugin to display lsp hover documentation in a side panel.
	use({
		'amrbashir/nvim-docs-view',
		commit = 'a7ba30f8d545ab0fd181e0f4fb84544ef9f236ac',
		opt = true,
		cmd = { 'DocsViewToggle' },
		config = function()
			require 'koeila.plugins.docs'
		end,
	})

	-- A tree like view for symbols in Neovim
	use({
		'simrat39/symbols-outline.nvim',
		commit = '512791925d57a61c545bc303356e8a8f7869763c',
		config = function()
			require 'koeila.plugins.symbols'
		end,
	})

	-- Component Library for Neovim.
	use({
		'MunifTanjim/nui.nvim',
		commit = 'c8de23342caf8d50b15d6b28368d36a56a69d76f',
	})

	-- -- Neovim statusline
	use({
		'nvim-lualine/lualine.nvim',
		commit = '45e27ca739c7be6c49e5496d14fcf45a303c3a63',
		config = function()
			require 'koeila.plugins.statusline'
		end,
	})

	-- A Neovim plugin hiding your colorcolumn when unneeded.
	use({
		'm4xshen/smartcolumn.nvim',
		commit = 'c6abf3917fcec487c7475e208ae37f5788af5b04',
		config = function()
			require 'koeila.plugins.smartcolumn'
		end,
	})

	--  Highlight colors for neovim
	use({
		'brenoprata10/nvim-highlight-colors',
		commit = '231547093a788b925b8fc36351ad422701c3a8c8',
		config = function()
			require 'koeila.plugins.highlight'
		end,
	})

	-- ▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋

	-- NOTE: [[ TERMINAL 💻 ]]
	-- A neovim lua plugin to help easily manage multiple terminal windows
	use({
		'akinsho/toggleterm.nvim',
		commit = '0427b908ebefcb3701c7f2cfbdafa37d11afe71a',
		config = function()
			require 'koeila.plugins.terminal'
		end,
	})

	-- ▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋

	-- NOTE: [[ FUZZY FINDER 🔭 | FILE EXPLORE 🌲 ]]
	-- Plugin to manage the file system and other tree like structures.
	use({
		'nvim-neo-tree/neo-tree.nvim',
		branch = 'v3.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
			'MunifTanjim/nui.nvim',
		},
		commit = '54fe2a5f6f698094b34461a11370fcc29b8a4393',
		config = function()
			require 'koeila.plugins.neotree'
		end,
	})

	-- find, filter, preview, pick. all lua, all the time.
	use({
		'nvim-telescope/telescope-fzf-native.nvim',
		commit = '6c921ca12321edaa773e324ef64ea301a1d0da62',
	})
	use({
		'nvim-telescope/telescope-frecency.nvim',
		commit = 'eaaabc90ed082b84a2e9b0ce4ab8c6753b7c50f9',
	})
	use({
		'nvim-telescope/telescope-fzf-writer.nvim',
		commit = '00a1ab1b0aeaa4ad9da238861325ea1ee6d90a44',
	})
	use({
		'nvim-telescope/telescope-ui-select.nvim',
		commit = '62ea5e58c7bbe191297b983a9e7e89420f581369',
	})
	use({
		'nvim-telescope/telescope.nvim',
		commit = 'b543aaa2c9cf8123ed2fe7dbb6c211a9cd415124',
		config = function()
			require 'koeila.plugins.telescopefd'
		end,
	})
	-- ▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋

	-- NOTE: [[ LSP | CMP | SNIPPETS | DEBUG | LINTER | FORMATTER 🚬 ]]
	-- Lsp
	use({
		'neovim/nvim-lspconfig',
		commit = 'cc388d3f6b9c7c943ae2b2dcd46ad470fd257f91',
	})
	use({
		'williamboman/mason-lspconfig.nvim',
		commit = 'f014db32437aa61c86fc0ef1067cd2bc6a37205c',
	})
	use({
		'ray-x/lsp_signature.nvim',
		commit = '51784ba4ce87b362c139b8c2db6583c0aec20536',
	})

	-- Snippets
	use({
		'L3MON4D3/LuaSnip',
		commit = '3657c3f3cb2214a681fc7e95b6ffb509d076ebfb',
	})
	use({
		'saadparwaiz1/cmp_luasnip',
		commit = '18095520391186d634a0045dacaa346291096566',
	})

	-- JSON Schemas
	use({
		'b0o/schemastore.nvim',
		commit = '2a6a5d3e2bc8a5727b6d083d2920d12a392ed05b',
	})

	-- Debug
	use({
		'mfussenegger/nvim-dap',
		commit = 'b3d4408e29d924fe130c9397a7c3b3630b3ea671',
	})
  use({
    'rcarriga/nvim-dap-ui',
    commit = '34160a7ce6072ef332f350ae1d4a6a501daf0159'
  })
	use({
		'jay-babu/mason-nvim-dap.nvim',
		commit = '6148b51db945b55b3b725da39eaea6441e59dff8',
	})

	-- Linter / formatter
	use({
		'jay-babu/mason-null-ls.nvim',
		commit = 'ae0c5fa57468ac65617f1bf821ba0c3a1e251f0c',
	})
	use({
		'jose-elias-alvarez/null-ls.nvim',
		commit = '0010ea927ab7c09ef0ce9bf28c2b573fc302f5a7',
	})

	-- CMP
	use({
		'hrsh7th/cmp-nvim-lsp',
		commit = '60e1e16308c862f678ea02b8430befa20c8fda6c',
	})
	use({
		'hrsh7th/nvim-cmp',
		commit = '5dce1b778b85c717f6614e3f4da45e9f19f54435',
		requires = {
			{
				'hrsh7th/cmp-buffer',
				commit = '3022dbc9166796b644a841a02de8dd1cc1d311fa',
			},
			{
				'hrsh7th/cmp-path',
				commit = '91ff86cd9c29299a64f968ebb45846c485725f23',
			},
			{
				'hrsh7th/cmp-cmdline',
				commit = '8ee981b4a91f536f52add291594e89fb6645e451',
			},
			{
				'lukas-reineke/cmp-under-comparator',
				commit = '6857f10272c3cfe930cece2afa2406e1385bfef8',
			},
		},
		config = function()
			require 'koeila.plugins.cmp'
		end,
	})

  use 'mfussenegger/nvim-jdtls'

	-- Easily manage external editor tooling such as LSP servers, DAP servers, linters, and formatters
	use({
		'williamboman/mason.nvim',
		commit = 'd66c60e17dd6fd8165194b1d14d21f7eb2c1697a',
		config = function()
			require 'koeila.plugins.mason'
			require 'koeila.plugins.lsp'
			require 'koeila.plugins.null-ls'
			require 'koeila.plugins.debug'
		end,
	})
	-- ▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋

	-- NOTE: [[ LANGUAGE STUFFS 🧩 ]]
	-- Treesitter
	use({
		'nvim-treesitter/nvim-treesitter',
		commit = 'eb0f975bf29dd6bbb58011ed0e694874a50ae79e',
		config = function()
			require 'koeila.plugins.treesitter'
		end,
	})

	-- Coments
	use({
		'numToStr/Comment.nvim', -- Smart and powerful comment plugin for neovim.
		commit = '0236521ea582747b58869cb72f70ccfa967d2e89',
		config = function()
			require 'koeila.plugins.comments'
		end,
	})

	-- ReactJS commment
	use({
		'JoosepAlviste/nvim-ts-context-commentstring',
		commit = '95e9ba9de4289d221666b66fd930d157c7ca08c6',
	})

	-- Todo comment highlight
	use({
		'folke/todo-comments.nvim',
		commit = '3094ead8edfa9040de2421deddec55d3762f64d1',
		config = function()
			require 'koeila.plugins.comments.todo'
		end,
	})

	-- Auto close and auto rename html tag
	use({
		'windwp/nvim-ts-autotag',
		commit = '6be1192965df35f94b8ea6d323354f7dc7a557e4',
	})

	-- Indent
	use({
		'shellRaining/hlchunk.nvim',
		commit = '130da2983519ed83beb513de64d16f22228b764a',
		config = function()
			require 'koeila.plugins.indent'
		end,
	})

	-- Peek lines just when you intend
	use({
		'nacro90/numb.nvim',
		commit = '3f7d4a74bd456e747a1278ea1672b26116e0824d',
		config = function()
			require 'koeila.plugins.numb'
		end,
	})

	-- NOTE: [[ GIT | GITHUB 🐙]]
	use({
		'lewis6991/gitsigns.nvim',
		commit = 'bce4576a9047085a528c479a7fe1e2f6b787b6c1',
		config = function()
			require 'koeila.plugins.git'
		end,
	})
	-- ▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋▋
	-- Automatically set up your configuration after cloning packer.nvim
	if PACKER_BOOTSTRAP then
		require('packer').sync()
	end
end)
