local status_ok, dap = pcall(require, 'mason-nvim-dap')

if not status_ok then
	return
end

dap.setup({
	ensure_installed = {
		'python',
		'cppdbg',
		'node2',
		'firefox',
		'js',
		'bash',
		'javadbg',
		'javatest',
	},
})
