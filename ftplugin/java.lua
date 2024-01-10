local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '/path/to/workspace-root/' .. project_name

local config = {
	cmd = {
		'java',

		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xmx1g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens',
		'java.base/java.util=ALL-UNNAMED',
		'--add-opens',
		'java.base/java.lang=ALL-UNNAMED',

		'-jar',
		'/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.600.v20231012-1237.jar',

		'-configuration',
		'/usr/share/java/jdtls/config_linux/config.ini',

		'-data',
		workspace_dir,
	},

	root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),

	settings = {
		java = {},
	},
	init_options = {
		bundles = {},
	},
}

require('jdtls').start_or_attach(config)
