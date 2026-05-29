return {
	{
		'saghen/blink.cmp',
		version = '*',
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
				["<C-n>"] = { "show", "select_next", "fallback" },
				["<C-p>"] = { "show", "select_prev", "fallback" },
			},
			cmdline = {
				completion = {
					menu = {
						auto_show = true,
						draw = {
							columns = {
								{ "kind_icon" },
								{ "label",      "label_description", gap = 1 },
								{ "source_name" },
							},
						},
					},
					list = {
						selection = {
							preselect = false,
							auto_insert = true,
						},
					},
				},
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 100,
				},
				menu = {
					auto_show = true,
					draw = {
						columns = {
							{ "kind_icon", "label",     "label_description", gap = 1 },
							{ "kind",      "source_id", gap = 1 },
						},
					},
				},
				list = {
					selection = {
						preselect = false,
						auto_insert = false,
					},
				},
				ghost_text = { enabled = false },
				accept = { auto_brackets = { enabled = false } },
			},
			signature = {
				enabled = true,
			},
			sources = {
				default = {
					"lazydev",
					"lsp",
					"path",
					"snippets",
					"buffer",
					"markdown",
				},
				providers = {
					lsp = { score_offset = 90 },
					lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 91 },
					markdown = {
						name = "RenderMarkdown",
						module = "render-markdown.integ.blink",
						score_offset = 91,
						fallbacks = { "lsp" },
					},
				},
			},
			fuzzy = { implementation = "prefer_rust" },
		},
	},
}
