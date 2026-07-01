return {
        {
                "lewis6991/gitsigns.nvim",
                opts = {},
                config = function()
                        require("gitsigns").setup({})
                        local gitsigns = require("gitsigns")
                        vim.keymap.set("n", "<leader>hb", "<cmd>Gitsigns blame<cr>")
                        vim.keymap.set(
                                "n",
                                "<leader>hl",
                                "<cmd>Gitsigns toggle_current_line_blame<cr>"
                        )
                        vim.keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk_inline<cr>")
                        vim.keymap.set("n", "<leader>hu", "<cmd>Gitsigns reset_hunk<cr>")
                        vim.keymap.set("n", "]h", function()
                                if vim.wo.diff then
                                        vim.cmd.normal({ "]h", bang = true })
                                else
                                        gitsigns.nav_hunk("next")
                                end
                        end)
                        vim.keymap.set("n", "[h", function()
                                if vim.wo.diff then
                                        vim.cmd.normal({ "[h", bang = true })
                                else
                                        gitsigns.nav_hunk("prev")
                                end
                        end)
                end,
        },
        {
                "NeogitOrg/neogit",
                dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
                config = function()
                        require("neogit").setup({
                                status = {
                                        recent_commit_include_author_info = true,
                                },
                        })
                        vim.keymap.set("n", "<leader>ng", "<cmd>Neogit<cr>")
                        vim.keymap.set("n", "<leader>nd", "<cmd>Neogit diff<cr>")
                end,
        },
        {
                "sindrets/diffview.nvim",
                config = function()
                        require("diffview").setup({})
                        vim.keymap.set("n", "<leader>df", "<cmd>DiffviewFileHistory<cr>")
                        vim.keymap.set("n", "<leader>do", "<cmd>DiffviewOpen<cr>")
                        vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<cr>")
                end,
        },
        { "akinsho/git-conflict.nvim", version = "*", config = true },
}
