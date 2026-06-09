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
}
