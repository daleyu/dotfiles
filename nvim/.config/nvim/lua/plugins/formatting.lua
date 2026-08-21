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
                                        typescript = {
                                                "prettierd",
                                                "prettier",
                                                stop_after_first = true,
                                        },
                                        typescriptreact = {
                                                "prettierd",
                                                "prettier",
                                                stop_after_first = true,
                                        },
                                        javascript = {
                                                "prettierd",
                                                "prettier",
                                                stop_after_first = true,
                                        },
                                        javascriptreact = {
                                                "prettierd",
                                                "prettier",
                                                stop_after_first = true,
                                        },
                                        json = { "prettierd", "prettier", stop_after_first = true },
                                        html = { "prettierd", "prettier", stop_after_first = true },
                                        css = { "prettierd", "prettier", stop_after_first = true },
                                        yaml = { "yamlfmt" },
                                },
                                -- blocked on: https://github.com/google/yamlfmt/issues/290
                                formatters = {
                                        yamlfmt = {
                                                args = {
                                                        "-formatter",
                                                        "force_quote_style=single,retain_line_breaks=true",
                                                        "-in",
                                                },
                                        },
                                },
                                format_after_save = function(_bufnr)
                                        if vim.bo.filetype == "proto" then
                                                return
                                        end
                                        if vim.bo.filetype == "yaml" then
                                                return
                                        end
                                        return {
                                                lsp_format = "fallback",
                                                async = true,
                                        }
                                end,
                                format = {
                                        stop_after_first = true,
                                },
                        })
                end,
        },
}
