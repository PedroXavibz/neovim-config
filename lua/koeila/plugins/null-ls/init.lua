local status_ok, null_ls = pcall(require, 'null-ls')

if not status_ok then
	return
end

local ensure_installed = {
	formatting = {
		'eslint_d',
		'fixjson',
		'yamlfmt',
		'golines',
		'goimports',
		'rustfmt',
		'dart_format',
		'autopep8',
		'reorder_python_imports',
		'clang_format',
		'elm_format',
		'stylua',
		'shfmt',
		'google_java_format',
	},
	diagnostics = {
		-- 'pylint',
		-- 'mypy',
		-- 'pydocstyle',
		'eslint_d',
		'shellcheck',
	},
}

local sources = {}
local _install = {}

local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

for builtin_type, builtins in pairs(ensure_installed) do
	for _, builtin in ipairs(builtins) do
		table.insert(_install, builtin)
		if builtin_type == 'diagnostics' then
			table.insert(sources, diagnostics[builtin])
		elseif builtin_type == 'formatting' then
			table.insert(sources, formatting[builtin])
		end
	end
end

-- TODO: make safeaty require
require('koeila.plugins.null-ls.mason_null-ls').setup(_install)

null_ls.setup({
	debug = false,
	sources = sources,
})
