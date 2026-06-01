return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("fzf-lua").setup({
				keymap = {
					fzf = {
						["ctrl-q"] = "select-all+accept",
					},
				},
				grep = {
					rg_opts =
					"--color=always --hidden --line-number --smart-case --no-heading --column",
				},
				files = {
					fd_opts = "--color=never --type f --hidden --follow --exclude .git",
					rg_opts = "--color=never --files --hidden --follow -g '!.git'",
				},
			})
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		opts = {
			render_modes = { "n", "c", "t", "R", "i" },
			heading = { width = "block" },
			file_types = { "markdown", "codecompanion" },
			html = {
				comment = { conceal = false },
			},
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
		keys = {
			{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>" },
		},
	},
	{ "norcalli/nvim-colorizer.lua", opts = {} },
	{
		"lervag/vimtex",
		lazy = false,
		init = function()
			vim.g.vimtex_view_method = "zathura"
		end
	},
	-- {
	-- 	"3rd/diagram.nvim",
	-- 	dependencies = {
	-- 		{ "3rd/image.nvim", opts = {} }, -- you'd probably want to configure image.nvim manually instead of doing this
	-- 	},
	-- 	opts = {            -- you can just pass {}, defaults below
	-- 		events = {
	-- 			render_buffer = { "InsertLeave", "BufWinEnter", "TextChanged" },
	-- 			clear_buffer = { "BufLeave" },
	-- 		},
	-- 		renderer_options = {
	-- 			mermaid = {
	-- 				background = nil, -- nil | "transparent" | "white" | "#hex"
	-- 				theme = nil, -- nil | "default" | "dark" | "forest" | "neutral"
	-- 				scale = 6, -- nil | 1 (default) | 2  | 3 | ...
	-- 				width = 1000, -- nil | 800 | 400 | ...
	-- 				height = 700, -- nil | 600 | 300 | ...
	-- 				cli_args = nil, -- nil | { "--no-sandbox" } | { "-p", "/path/to/puppeteer" } | ...
	-- 			},
	-- 			plantuml = {
	-- 				charset = nil,
	-- 				cli_args = nil, -- nil | { "-Djava.awt.headless=true" } | ...
	-- 			},
	-- 			d2 = {
	-- 				theme_id = nil,
	-- 				dark_theme_id = nil,
	-- 				scale = nil,
	-- 				layout = nil,
	-- 				sketch = nil,
	-- 				cli_args = nil, -- nil | { "--pad", "0" } | ...
	-- 			},
	-- 			gnuplot = {
	-- 				size = nil, -- nil | "800,600" | ...
	-- 				font = nil, -- nil | "Arial,12" | ...
	-- 				theme = nil, -- nil | "light" | "dark" | custom theme string
	-- 				cli_args = nil, -- nil | { "-p" } | { "-c", "config.plt" } | ...
	-- 			},
	-- 		}
	-- 	},
	-- },
}
