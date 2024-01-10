-- Symbols debug
vim.api.nvim_set_hl(0, 'dapbreakpoint', { ctermbg = 0, fg = '#fb0101', bg = '#1e1e1e' })
vim.api.nvim_set_hl(0, 'daplogpoint', { ctermbg = 0, fg = '#18a2fe', bg = '#1e1e1e' })
vim.api.nvim_set_hl(0, 'dapstopped', { ctermbg = 0, fg = '#6a9955', bg = '#1e1e1e' })

vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'dapbreakpoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = 'ﳁ', texthl = 'dapbreakpoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected',{ text = '', texthl = 'dapbreakpoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'daplogpoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'dapstopped', linehl = '', numhl = '' })

return {
	setup = function(dap, dapui)
		dapui.setup({
			controls = {
				element = 'repl',
				enabled = true,
				icons = {
					disconnect = '',
					pause = '',
					play = '',
					run_last = '',
					step_back = '',
					step_into = '',
					step_out = '',
					step_over = '',
					terminate = '',
				},
			},
			element_mappings = {},
			expand_lines = true,
			floating = {
				border = 'single',
				mappings = {
					close = { 'q', '<esc>' },
				},
			},
			force_buffers = true,
			icons = {
				collapsed = '',
				current_frame = '',
				expanded = '',
			},
			layouts = {
				{
					elements = {
						{
							id = 'scopes',
							size = 0.25,
						},
						{
							id = 'breakpoints',
							size = 0.25,
						},
						{
							id = 'stacks',
							size = 0.25,
						},
						{
							id = 'watches',
							size = 0.25,
						},
					},
					position = 'left',
					size = 40,
				},
				{
					elements = {
						{
							id = 'repl',
							size = 0.5,
						},
						{
							id = 'console',
							size = 0.5,
						},
					},
					position = 'bottom',
					size = 10,
				},
			},
			mappings = {
				edit = 'e',
				expand = { '<cr>', '<2-leftmouse>' },
				open = 'o',
				remove = 'd',
				repl = 'r',
				toggle = 't',
			},
			render = {
				indent = 1,
				max_value_lines = 100,
			},
		})

		dap.listeners.after.event_initialized['dapui_config'] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated['dapui_config'] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited['dapui_config'] = function()
			dapui.close()
		end
	end,
}
