return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"haydenmeade/neotest-jest",
			"nvim-neotest/nvim-nio",
			{ url = "git@git.corp.stripe.com:stevearc/neotest-pay-test.git" },
			"nvim-lua/plenary.nvim",
			"stevearc/overseer.nvim",
		},
		config = function()
			local neotest_jest = require("neotest-jest")
			local neotest = require("neotest")
			neotest.setup({
				adapters = {
					neotest_jest({
						cwd = neotest_jest.root,
					}),
					require("neotest-pay-test")(),
				},
				discovery = {
					enabled = false,
				},
				consumers = {
					overseer = require("neotest.consumers.overseer"),
				},
				icons = {
					passed = " ",
					running = " ",
					failed = " ",
					unknown = " ",
					running_animated = vim.tbl_map(function(s)
						return s .. " "
					end, { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }),
				},
				output = {
					open_on_run = false,
				},
			})
			vim.keymap.set("n", "<leader>tf", function()
				neotest.run.run({ vim.api.nvim_buf_get_name(0) })
			end, { desc = "[T]est [F]ile" })
			vim.keymap.set("n", "<leader>tn", function()
				neotest.run.run({})
			end, { desc = "[T]est [N]earest" })
			vim.keymap.set("n", "<leader>tl", neotest.run.run_last, { desc = "[T]est [L]ast" })
			vim.keymap.set("n", "<leader>ts", neotest.summary.toggle, { desc = "[T]est toggle [S]ummary" })
			vim.keymap.set("n", "<leader>to", function()
				neotest.output.open({ short = true })
			end, { desc = "[T]est [O]utput" })
		end,
	},
	{
		'stevearc/overseer.nvim',
		opts = {},
		keys = {
			{ "<leader>gen", "<cmd>OverseerRun<cr>" },
		},
	},
}
