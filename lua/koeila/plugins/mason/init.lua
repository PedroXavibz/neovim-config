local status_ok, mason = pcall(require, 'mason')

if not status_ok then
	return
end

mason.setup({
	install_root_dir = vim.fn.stdpath 'data' .. '/mason',

	PATH = 'prepend',

	log_level = vim.log.levels.INFO,

	max_concurrent_installers = 4,

	registries = {
		'github:mason-org/mason-registry',
	},

	providers = {
		'mason.providers.registry-api',
		'mason.providers.client',
	},

	github = {
		download_url_template = 'https://github.com/%s/releases/download/%s/%s',
	},

	pip = {
		upgrade_pip = false,
		install_args = {},
	},

	ui = {
		check_outdated_packages_on_open = true,

		border = 'none',

		width = 0.8,
		height = 0.9,

		icons = {
			package_installed = '󰏗',
			package_pending = '󱧕',
			package_uninstalled = '󱧖',
		},

		keymaps = {
			-- Keymap to expand a package
			toggle_package_expand = '<CR>',
			-- Keymap to install the package under the current cursor position
			install_package = 'i',
			-- Keymap to reinstall/update the package under the current cursor position
			update_package = 'u',
			-- Keymap to check for new version for the package under the current cursor position
			check_package_version = 'c',
			-- Keymap to update all installed packages
			update_all_packages = 'U',
			-- Keymap to check which installed packages are outdated
			check_outdated_packages = 'C',
			-- Keymap to uninstall a package
			uninstall_package = 'X',
			-- Keymap to cancel a package installation
			cancel_installation = '<C-c>',
			-- Keymap to apply language filter
			apply_language_filter = '<C-f>',
		},
	},
})
