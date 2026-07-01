return {
        {
                "chomosuke/typst-preview.nvim",
                ft = "typst",
                version = "1.*",
                cmd = {
                        "TypstPreview",
                        "TypstPreviewStop",
                        "TypstPreviewToggle",
                        "TypstPreviewUpdate",
                },
                keys = {
                        { "<leader>tp", "<cmd>TypstPreviewToggle<cr>", desc = "Toggle Typst preview" },
                },
                opts = {
                        dependencies_bin = {
                                ["tinymist"] = "tinymist",
                        },
                },
        },
}
