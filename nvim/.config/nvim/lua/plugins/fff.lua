return {
        {
                "dmtrKovalenko/fff",
                build = function()
                        require("fff.download").download_or_build_binary()
                end,
                lazy = false,
                opts = {
                        layout = {
                                prompt_position = "top",
                        },
                },
                keys = {
                        {
                                "<leader>gf",
                                function()
                                        require("fff").find_files({ query = "git:modified " })
                                end,
                                desc = "Git modified files",
                        },
                },
        },
}
