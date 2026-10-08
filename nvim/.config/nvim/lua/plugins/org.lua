return {
        "xheisenbugx/org.nvim",
        main = "org",
        lazy = false,
        opts = {
                org_directory = "~/notes",
                agenda_files = { "~/notes/**/*.org" },
                default_notes_file = "~/notes/refile.org",
        },
}
