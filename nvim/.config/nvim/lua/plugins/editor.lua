return {
        {
                "mbbill/undotree",
                keys = {
                        { "<leader>u", vim.cmd.UndotreeToggle },
                },
        },
        {
                "echasnovski/mini.nvim",
                version = false,
                config = function()
                        local mini_files = require("mini.files")
                        mini_files.setup({
                                options = { use_as_default_explorer = false },
                                windows = {
                                        preview = true,
                                        width_preview = 40,
                                        width_nofocus = 30,
                                        width_focus = 30,
                                },
                        })
                        mini_files.config.mappings.close = "<esc>"

                        vim.keymap.set("n", "<leader>o", mini_files.open)
                        vim.keymap.set("n", "<leader>s", function()
                                local state = mini_files.get_explorer_state()
                                local dir = state and state.branch[state.depth_focus] or "%:h"
                                vim.cmd("cd " .. dir)
                                vim.cmd("pwd")
                        end)
                        vim.keymap.set("n", "<leader><space>", function()
                                if not mini_files.close() then
                                        local current_file = vim.fn.expand("%:p")
                                        mini_files.open(current_file)
                                end
                        end)
                end,
        },
        {
                "ThePrimeagen/harpoon",
                branch = "harpoon2",
                dependencies = { "nvim-lua/plenary.nvim" },
                config = function()
                        local harpoon = require("harpoon")
                        harpoon:setup()

                        vim.keymap.set("n", "<leader>a", function()
                                harpoon:list():add()
                        end)
                        vim.keymap.set("n", "<C-e>", function()
                                harpoon.ui:toggle_quick_menu(harpoon:list())
                        end)
                        vim.keymap.set("n", "<C-t>", function()
                                harpoon:list():select(1)
                        end)
                        vim.keymap.set("n", "<C-n>", function()
                                harpoon:list():select(2)
                        end)
                        vim.keymap.set("n", "<C-s>", function()
                                harpoon:list():select(3)
                        end)
                        vim.keymap.set("n", "<C-S-P>", function()
                                harpoon:list():prev()
                        end)
                        vim.keymap.set("n", "<C-S-N>", function()
                                harpoon:list():next()
                        end)
                end,
        },
        {
                "karb94/neoscroll.nvim",
                config = function()
                        require("neoscroll").setup({
                                mappings = {
                                        "<C-u>",
                                        "<C-d>",
                                        "zt",
                                        "zz",
                                        "zb",
                                },
                                hide_cursor = true,
                                stop_eof = true,
                                respect_scrolloff = false,
                                cursor_scrolls_alone = true,
                                duration_multiplier = 0.3,
                                easing = "linear",
                                pre_hook = nil,
                                post_hook = nil,
                                performance_mode = false,
                                ignored_events = {
                                        "WinScrolled",
                                        "CursorMoved",
                                },
                        })
                end,
        },
        {
                "jake-stewart/multicursor.nvim",
                branch = "1.0",
                config = function()
                        local mc = require("multicursor-nvim")
                        mc.setup()

                        local set = vim.keymap.set

                        set({ "n", "x" }, "<up>", function()
                                mc.lineAddCursor(-1)
                        end)
                        set({ "n", "x" }, "<down>", function()
                                mc.lineAddCursor(1)
                        end)
                        set({ "n", "x" }, "<leader><up>", function()
                                mc.lineSkipCursor(-1)
                        end)
                        set({ "n", "x" }, "<leader><down>", function()
                                mc.lineSkipCursor(1)
                        end)

                        set({ "n", "x" }, "<leader>n", function()
                                mc.matchAddCursor(1)
                        end)
                        set({ "n", "x" }, "<leader>N", function()
                                mc.matchAddCursor(-1)
                        end)

                        set("n", "<c-leftmouse>", mc.handleMouse)
                        set("n", "<c-leftdrag>", mc.handleMouseDrag)
                        set("n", "<c-leftrelease>", mc.handleMouseRelease)

                        set({ "n", "x" }, "<c-q>", mc.toggleCursor)

                        mc.addKeymapLayer(function(layerSet)
                                layerSet({ "n", "x" }, "<left>", mc.prevCursor)
                                layerSet({ "n", "x" }, "<right>", mc.nextCursor)
                                layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)
                                layerSet("n", "<esc>", function()
                                        if not mc.cursorsEnabled() then
                                                mc.enableCursors()
                                        else
                                                mc.clearCursors()
                                        end
                                end)
                        end)

                        local hl = vim.api.nvim_set_hl
                        hl(0, "MultiCursorCursor", { link = "Cursor" })
                        hl(0, "MultiCursorVisual", { link = "Visual" })
                        hl(0, "MultiCursorSign", { link = "SignColumn" })
                        hl(0, "MultiCursorMatchPreview", { link = "Search" })
                        hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
                        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
                        hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
                end,
        },
        {
                "luukvbaal/statuscol.nvim",
                config = function()
                        local function lnum_both(args)
                                return string.format("%3d %2d", args.lnum, args.relnum)
                        end
                        require("statuscol").setup({
                                setopt = true,
                                segments = {
                                        {
                                                sign = {
                                                        namespace = { "gitsigns.*" },
                                                        name = { "gitsigns.*" },
                                                },
                                        },
                                        {
                                                sign = {
                                                        namespace = { ".*" },
                                                        name = { ".*" },
                                                        auto = true,
                                                },
                                        },
                                        {
                                                text = { lnum_both, " " },
                                                condition = { true },
                                                click = "v:lua.ScLa",
                                        },
                                },
                        })
                end,
        },
        {
                "MagicDuck/grug-far.nvim",
                opts = { windowCreationCommand = "e" },
                keys = {
                        { "<leader>r", "<cmd>GrugFar<cr>" },
                },
        },
        {
                "bassamsdata/namu.nvim",
                opts = {
                        global = {},
                        namu_symbols = { -- Specific Module options
                                options = {},
                        },
                },
                -- === Suggested Keymaps: ===
                vim.keymap.set("n", "<leader>ns", ":Namu symbols<cr>", {
                        desc = "Jump to LSP symbol",
                        silent = true,
                }),
                vim.keymap.set("n", "<leader>nw", ":Namu workspace<cr>", {
                        desc = "LSP Symbols - Workspace",
                        silent = true,
                }),
        },
}
