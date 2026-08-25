return {
        {
                "lewis6991/gitsigns.nvim",
                opts = {},
                config = function()
                        require("gitsigns").setup({})
                        local gitsigns = require("gitsigns")
                        vim.keymap.set("n", "<leader>hb", "<cmd>Gitsigns blame<cr>")
                        vim.keymap.set("n", "<leader>hl", "<cmd>Gitsigns toggle_current_line_blame<cr>")
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
        {
                "pwntester/octo.nvim",
                cmd = "Octo",
                opts = {
                        picker = "snacks",
                        enable_builtin = true,
                        github_hostname = "git.corp.stripe.com",
                        mappings = {
                                submit_win = {
                                        approve_review = { lhs = "<C-y>", desc = "approve review", mode = { "n" } },
                                        comment_review = { lhs = "<C-m>", desc = "comment review", mode = { "n" } },
                                        request_changes = {
                                                lhs = "<C-r>",
                                                desc = "request changes review",
                                                mode = { "n" },
                                        },
                                        close_review_tab = { lhs = "<C-c>", desc = "close review tab", mode = { "n" } },
                                },
                                review_diff = {
                                        submit_review = { lhs = "<localleader>or", desc = "submit review" },
                                        discard_review = { lhs = "<localleader>oq", desc = "discard review" },
                                        add_review_comment = {
                                                lhs = "<localleader>ca",
                                                desc = "add a new review comment",
                                                mode = { "n", "x" },
                                        },
                                        focus_files = {
                                                lhs = "<localleader>e",
                                                desc = "move focus to changed file panel",
                                        },
                                        toggle_files = {
                                                lhs = "<localleader>b",
                                                desc = "hide/show changed files panel",
                                        },
                                        next_thread = { lhs = "]t", desc = "move to next thread" },
                                        prev_thread = { lhs = "[t", desc = "move to previous thread" },
                                        select_next_entry = { lhs = "]f", desc = "move to next changed file" },
                                        select_prev_entry = { lhs = "[f", desc = "move to previous changed file" },
                                        select_first_entry = { lhs = "[F", desc = "move to first changed file" },
                                        select_last_entry = { lhs = "]F", desc = "move to last changed file" },
                                        select_next_unviewed_entry = { lhs = "]u", desc = "move to next unviewed file" },
                                        select_prev_unviewed_entry = {
                                                lhs = "[u",
                                                desc = "move to previous unviewed file",
                                        },
                                        close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
                                        toggle_viewed = {
                                                lhs = "<localleader><space>",
                                                desc = "toggle viewer viewed state",
                                        },
                                        goto_file = { lhs = "gf", desc = "go to file" },
                                        copy_sha = { lhs = "<C-e>", desc = "copy commit SHA to system clipboard" },
                                        review_commits = { lhs = "<localleader>C", desc = "review PR commits" },
                                },
                        },
                },
                keys = {
                        {
                                "<leader>oa",
                                "<CMD>Octo actions<CR>",
                                desc = "Octo Actions",
                        },
                        {
                                "<leader>op",
                                function()
                                        local clipboard = vim.fn.getreg("+")
                                        local pr = vim.trim(clipboard):gsub("^#", "")
                                        if pr ~= "" then
                                                vim.cmd("Octo pr edit " .. pr)
                                        else
                                                Snacks.notify.warn("Clipboard register (+) is empty")
                                        end
                                end,
                                desc = "Octo PR from Clipboard",
                        },
                },
                dependencies = {
                        "nvim-lua/plenary.nvim",
                        "folke/snacks.nvim",
                        "nvim-tree/nvim-web-devicons",
                },
        },
}
