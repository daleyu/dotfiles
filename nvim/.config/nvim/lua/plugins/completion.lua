return {
	{
		'saghen/blink.cmp',
		lazy = false,
		dependencies = {
			'saghen/blink.lib',
			'rafamadriz/friendly-snippets',
		},
		build = function()
			require('blink.cmp').build():wait(60000)
		end,

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = 'default',
				['<CR>'] = { 'accept', 'fallback' },
			},
			completion = { documentation = { auto_show = true } },
			sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
			fuzzy = { implementation = "rust" },
		},
	},
}
