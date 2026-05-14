return {
	{ "tpope/vim-sleuth" },
	{
		-- brew install pngpaste on mac
		"HakonHarnes/img-clip.nvim",
		opts = {
			default = {
				insert_mode_after_paste = false,
				prompt_for_file_name = false,
			},
		},
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
}
