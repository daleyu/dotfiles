return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			picker = {
				layout = {
					layout = {
						width = 0.90,
						height = 0.90,
					}
				},
				enabled = true,
				ui_select = true,
				sources = {
					files = {
						hidden = true,
					},
					grep = {
						hidden = true,
						exclude = { ".git" }
					},
					grep_word = {
						hidden = true,
					},
					explorer = {
						hidden = true,
					},
				},
				previewers = {
					diff = {
						builtin = false,
						cmd = { "delta", "--paging=never" },
					},
				},
			},
			explorer = { enabled = false },
			image = { enabled = true },
			input = { enabled = true },
			notifier = {
				enabled = true,
				top_down = false,
				timeout = 3000,
			},
			dashboard = { enabled = true },
			quickfile = { enable = true },
			indent = { enabled = true },
			zen = {
				enabled = true,
				toggles = {
					dim = false,
					git_signs = true,
					diagnostics = true,
					inlay_hints = true
				},
				show = {
					statusline = true,
					tabline = true,
				},
				zoom = {
					toggles = { dim = false },
					center = true,
					show = { statusline = true, tabline = true },
					win = {
						backdrop = true,
						width = .6,
					},
				},
				win = { backdrop = { transparent = false, blend = 99 } },
			},
			statuscolumn = { enabled = false },
			styles = {
				zen = { width = .6 }
			}
		},
		keys = {
			{ '<leader>b',  function() Snacks.explorer() end },
			{ '<leader>p',  function() Snacks.picker() end },
			{ '<leader>f',  function() Snacks.picker.files() end },
			{ '<leader>/',  function() Snacks.picker.grep() end },
			{ '<leader>l/', function() Snacks.picker.grep() end },
			{ '<leader>*',  function() Snacks.picker.grep_word() end },
			{ "<leader>gs", function() Snacks.picker.spelling() end },
			{ "<leader>,",  function() Snacks.picker.buffers() end },
			{ "<leader>gl", function() Snacks.picker.resume() end },
			{ "<leader>zz", function() Snacks.picker.zoxide() end },
			{ "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
			{ "<leader>zm", function() Snacks.zen.zen() end },
		},
	},
}
