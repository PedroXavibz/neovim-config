local status_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')

if not status_ok then
	return
end

nvim_treesitter.setup({
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = {
		'c',
		'cpp',
		'go',
		'rust',
		'python',
		'javascript',
		'java',
		'c_sharp',
		'lua',
		'dart',
		'bash',
		'vim',
		'scss',
		'css',
		'html',
		'sql',
		'toml',
		'tsx',
		'typescript',
		'yaml',
		'graphql',
		'json',
		'regex',
		'passwd',
		'ninja',
		'llvm',
		'markdown_inline',
		'make',
		'cmake',
		'dockerfile',
		'comment',
		'jsdoc',
		'luadoc',
		'vimdoc',
		'query',
		'regex',
		'dot',
		'elm',
		'diff',
		'gitignore',
		'git_config',
		'git_rebase',
		'gitcommit',
		'gitattributes',
    'ebnf'
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = true,

	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	-- ignore_install = { "javascript" },

	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
	indent = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
	incremental_selection = { enable = true },
	textobjects = { enable = true },
	highlight = {
		enable = true,
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		additional_vim_regex_highlighting = false,
	},
})

vim.filetype.add { extension = { ebnf = 'ebnf' } }
