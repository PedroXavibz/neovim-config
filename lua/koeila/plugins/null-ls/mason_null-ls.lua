local status_ok, mason_null = pcall(require, 'mason-null-ls')

if not status_ok then
	return
end

return {
	setup = function(ensure_installed)
		mason_null.setup({
			ensure_installed = ensure_installed,
			automatic_installation = false,
		})
	end,
}
