return {
	{
		'vim-test/vim-test',
		keys = {
			{ "<leader>T", "<cmd>TestFile<CR>" },
		},
	},
	{
		'stevearc/overseer.nvim',
		opts = {},
		keys = {
			{ "<leader>gen", "<cmd>OverseerRun<cr>" },
		},
	},
}
