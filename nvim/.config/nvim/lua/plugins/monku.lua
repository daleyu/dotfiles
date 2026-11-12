return {
        {
                -- Loaded from ~/Development/monku.nvim when that checkout exists, otherwise from GitHub.
                "daleyu/monku.nvim",
                dev = true,
                lazy = false,
                opts = {
                        colors = {
                                sign = "#7287b8", -- gutter sign on commented lines
                                border = "#7287b8", -- bar beside an inline comment
                                text = "#8c9bc4", -- inline comment text
                        },
                },
                keys = {
                        {
                                "<leader>ma",
                                function()
                                        require("monku").add()
                                end,
                                mode = { "n", "x" },
                                desc = "Review: add comment",
                        },
                        { "<leader>mg", "<cmd>Monku general<cr>", desc = "Review: add general comment" },
                        { "<leader>mm", "<cmd>Monku<cr>", mode = { "n", "x" }, desc = "Review: pick an action" },
                        { "]r", "<cmd>Monku next<cr>", desc = "Review: next comment" },
                        { "[r", "<cmd>Monku prev<cr>", desc = "Review: previous comment" },
                        { "<leader>me", "<cmd>Monku edit<cr>", desc = "Review: edit comment" },
                        { "<leader>md", "<cmd>Monku delete<cr>", desc = "Review: delete comment" },
                        { "<leader>mD", "<cmd>Monku clear<cr>", desc = "Review: delete all comments" },
                        { "<leader>ml", "<cmd>Monku list<cr>", desc = "Review: list comments" },
                        { "<leader>mt", "<cmd>Monku toggle<cr>", desc = "Review: show/hide all comments" },
                        { "<leader>my", "<cmd>Monku copy<cr>", desc = "Review: copy all to clipboard" },
                        { "<leader>ms", "<cmd>Monku submit<cr>", desc = "Review: send to agent" },
                },
        },
}
