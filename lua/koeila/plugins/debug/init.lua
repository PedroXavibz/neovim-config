local status_dapui, dapui = pcall(require, 'dapui')
local status_dap, dap = pcall(require, 'dap')

if not status_dapui or not status_dap then
	return
end

-- Install debuggers
require 'koeila.plugins.debug.mason-dap'

-- UI
require('koeila.plugins.debug.dapui-config').setup(dap, dapui)

-- Keymaps
require('koeila.keymaps.plugins').set_dap()

local mason_packages = vim.fn.stdpath 'data' .. '/mason/packages/'

-- [ Python ]
local debugpy_adpter = mason_packages .. 'debugpy/debugpy-adapter'
dap.adapters.python = function(cb, config)
	if config.request == 'attach' then
		---@diagnostic disable-next-line: undefined-field
		local port = (config.connect or config).port
		---@diagnostic disable-next-line: undefined-field
		local host = (config.connect or config).host or '127.0.0.1'
		cb({
			type = 'server',
			port = assert(port, '`connect.port` is required for a python `attach` configuration'),
			host = host,
			options = {
				source_filetype = 'python',
			},
		})
	else
		cb({
			type = 'executable',
			command = debugpy_adpter,
			options = {
				source_filetype = 'python',
			},
		})
	end
end

dap.configurations.python = {
	{
		type = 'python',
		request = 'launch',
		name = 'Launch file',
		program = '${file}',
		pythonPath = function()
			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
				return cwd .. '/venv/bin/python'
			elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
				return cwd .. '/.venv/bin/python'
			else
				return '/usr/bin/python'
			end
		end,
	},
}

-- [ C ]
local cppdbg_adpter = mason_packages .. 'cpptools/extension/debugAdapters/bin/OpenDebugAD7'
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = cppdbg_adpter,
}

dap.configurations.c = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}

