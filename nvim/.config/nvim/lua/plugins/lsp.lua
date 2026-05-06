return {
	{
		'neovim/nvim-lspconfig',
		lazy = false,
		dependencies = { "saghen/blink.cmp" },
		config = function()
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			local servers = {
				"lua_ls", "rust_analyzer", "bashls",
				"jsonls", "ts_ls", "zls", "eslint", "thriftls",
				"buf_ls"
			}

			for _, server in ipairs(servers) do
				vim.lsp.enable(server)
			end

			vim.diagnostic.config({
				float = {
					border = "rounded",
					source = true,
				},
			})
		end,
	},
	{ 'williamboman/mason.nvim' },
	{
		'williamboman/mason-lspconfig.nvim',
		config = function()
			require('mason').setup({})
			require('mason-lspconfig').setup({
				handlers = {
					function(server_name)
						vim.lsp.enable(server_name)
					end,
					pyright = function()
						vim.lsp.config('pyright', {
							settings = {
								pyright = {
									disableOrganizeImports = true,
								},
								python = {
									analysis = {
										ignore = { "*" },
									},
								},
							},
						})
						vim.lsp.enable('pyright')
					end
				},
				ensure_installed = {
					"lua_ls", "rust_analyzer", "bashls",
					"jsonls", "ts_ls", "zls", "eslint", "thriftls",
					"buf_ls", "marksman"
				},
			})
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = { notification = { window = { winblend = 0 } } },
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
