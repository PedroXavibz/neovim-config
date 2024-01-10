local cmp_status, cmp = pcall(require, 'cmp')
local luasnip_status, luasnip = pcall(require, 'luasnip')
local cpm_under_status, cmp_under = pcall(require, 'cmp-under-comparator')

if not cmp_status or not luasnip_status or not cpm_under_status then
	return
end

require('luasnip/loaders/from_vscode').lazy_load()

local check_backspace = function()
	local col = vim.fn.col '.' - 1
	return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
end

--   פּ ﯟ   some other good icons
local kind_icons = {
	Text = '',
	Method = 'm',
	Function = '',
	Constructor = '',
	Field = '',
	Variable = '',
	Class = '',
	Interface = '',
	Module = '',
	Property = '',
	Unit = '',
	Value = '',
	Enum = '',
	Keyword = '',
	Snippet = '',
	Color = '',
	File = '',
	Reference = '',
	Folder = '',
	EnumMember = '',
	Constant = '',
	Struct = '',
	Event = '',
	Operator = '',
	TypeParameter = '',
}

local function selectDown(fallback)
	if cmp.visible() then
		cmp.select_next_item()
	elseif luasnip.expandable() then
		luasnip.expand()
	elseif luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	elseif check_backspace() then
		fallback()
	else
		fallback()
	end
end

local function selectUp(fallback)
	if cmp.visible() then
		cmp.select_prev_item()
	elseif luasnip.jumpable(-1) then
		luasnip.jump(-1)
	else
		fallback()
	end
end

-- find more here: https://www.nerdfonts.com/cheat-sheet
cmp.setup({
	-- REQUIRED - you must specify a snippet engine
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		['<Tab>'] = cmp.mapping(selectDown, { 'i', 's' }),
		['<S-tab>'] = cmp.mapping(selectUp, { 'i', 's' }),
		['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		['<C-e>'] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<C-j>'] = cmp.mapping(selectDown, { 'i', 's' }),
		['<C-k>'] = cmp.mapping(selectUp, { 'i', 's' }),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'nvim_lua' },
		{ name = 'buffer' },
		{ name = 'path' },
	},
	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp_under.under,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},

	view = {
		entries = 'custom', -- can be "custom", "wildmenu" or "native"
	},
	formatting = {
		fields = { 'kind', 'abbr', 'menu' },
		format = function(entry, vim_item)
			-- Kin kind_icons
			vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
			-- Source
			vim_item.menu = ({
				nvim_lsp = '[LSP]',
				nvim_lua = '[NVIM_LUA]',
				luasnip = '[Snippet]',
				buffer = '[Buffer]',
				path = '[Path]',
			})[entry.source.name]
			return vim_item
		end,
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		documentation = {
			border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
		},
		completion = {
			border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
		},
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
})
