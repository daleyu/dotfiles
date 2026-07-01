function LineNumberColors()
        vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#b09d99", bold = false })
        vim.api.nvim_set_hl(0, "LineNr", { fg = "#b09d99", bold = false })
        vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#b09d99", bold = false })
end

vim.api.nvim_create_autocmd({ "BufEnter", "VimEnter" }, {
        callback = function()
                vim.opt.nu = true
                vim.opt.rnu = true
                vim.cmd("hi cursorline guibg=NONE")
                vim.opt.signcolumn = "yes"
                vim.cmd("ColorizerAttachToBuffer")
        end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "markdown" },
        callback = function()
                vim.opt_local.spell = true
        end,
})

LineNumberColors()

vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_attach_keymaps", { clear = true }),
        desc = "LSP actions",
        callback = function(event)
                local opts = { buffer = event.buf }

                vim.keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                vim.keymap.set("n", "<leader>gd", function()
                        Snacks.picker.lsp_definitions()
                end, opts)
                vim.keymap.set("n", "gi", function()
                        Snacks.picker.lsp_implementations()
                end, opts)
                vim.keymap.set("n", "go", function()
                        Snacks.picker.lsp_type_definitions()
                end, opts)
                vim.keymap.set("n", "gr", function()
                        Snacks.picker.lsp_references()
                end, opts)
                vim.keymap.set("n", "<leader>ge", function()
                        Snacks.picker.diagnostics_buffer()
                end, opts)
                vim.keymap.set("n", "<leader>gw", function()
                        Snacks.picker.diagnostics()
                end, opts)
                vim.keymap.set("n", "<leader>gl", function()
                        Snacks.picker.resume()
                end, opts)

                vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                vim.keymap.set(
                        { "n", "x" },
                        "<F3>",
                        "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
                        opts
                )
                vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

                local stripe_plugins_path = vim.fn.stdpath("config") .. "/lua/plugins-stripe"
                local has_stripe = vim.uv.fs_stat(stripe_plugins_path) ~= nil
                local ft = vim.bo[event.buf].filetype

                vim.keymap.set("n", "<leader>ca", function()
                        if has_stripe or ft == "java" then
                                require("fzf-lua").lsp_code_actions()
                        else
                                Snacks.picker.lsp_code_actions()
                        end
                end, opts)

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client == nil then
                        return
                end
                if client.name == "ruff" then
                        client.server_capabilities.hoverProvider = false
                end
        end,
})
