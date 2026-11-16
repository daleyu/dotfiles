return {
        "xheisenbugx/org.nvim",
        main = "org",
        lazy = false,
        opts = {
                org_directory = "~/notes",
                agenda_files = {
                        "~/notes/**/*.org",
                        "~/org-notes/**/*.org",
                },
                default_notes_file = "~/notes/refile.org",
                -- file:/id: links open in the current window, not another split.
                links = { frame_setup = { file = "current" } },
        },
}
