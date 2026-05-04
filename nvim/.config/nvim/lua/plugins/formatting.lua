return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					luau = { "stylua" },
					go = { "gofmt", "goimports" },
					python = { "black" },
					typescript = { 'prettierd', "prettier", stop_after_first = true },
					typescriptreact = { 'prettierd', "prettier", stop_after_first = true },
					javascript = { 'prettierd', "prettier", stop_after_first = true },
					javascriptreact = { 'prettierd', "prettier", stop_after_first = true },
					json = { 'prettierd', "prettier", stop_after_first = true },
					html = { 'prettierd', "prettier", stop_after_first = true },
					css = { 'prettierd', "prettier", stop_after_first = true },
				},
				format_after_save = function(_bufnr)
					if vim.bo.filetype == "proto" then
						return
					end
					return {
						lsp_format = "fallback",
						async = true,
					}
				end,
				format = {
					stop_after_first = true,
				}
			})
		end,
	},
}
