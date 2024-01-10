local ensure_installed = {
	'lua_ls',
	'rust_analyzer',
	'bashls',
	'clangd',
	-- 'csharp_ls',
	-- 'cmake',
	'cssls',
	'dockerls',
	'docker_compose_language_service',
	'dotls',
	'efm',
	'eslint',
	'emmet_ls',
	'gopls',
	'graphql',
	'gradle_ls',
	'html',
  'tailwindcss',
	'jsonls',
	'jdtls',
	'tsserver',
	'marksman',
	'pyright',
	'sqlls',
	'svelte',
	'taplo',
	'yamlls',
}

-- Mason config
require('koeila.plugins.lsp.mason-config').setup(ensure_installed)

-- Lsp config
require('koeila.plugins.lsp.lspconfig').setup(ensure_installed)

-- Lsp signature
-- require('koeila.plugins.lsp.lsp-signature')
