local status_ok, mason_lsp = pcall(require, 'mason-lspconfig')

if not status_ok then
	return
end

return {
	setup = function(ensure_installed)
		mason_lsp.setup({
			ensure_installed = ensure_installed,
		})
	end,
}
