local servers = {
        lua_ls = {
                settings = {
                        Lua = {
                                diagnostics = { globals = { "vim" } },
                                hover = { enumsLimit = 100, previewFields = 100 },
                        },
                },
        },
        pyright = {
                settings = {
                        pyright = {
                                disableOrganizeImports = true,
                        },
                        python = {
                                analysis = {
                                        ignore = { "*" },
                                },
                        },
                },
        },
        vtsls = {},
        jsonls = {},
        rust_analyzer = { settings = { ["rust-analyzer"] = { check = { command = "clippy" } } } },
        gopls = {},
        ts_ls = {},
        thriftls = {},
        buf_ls = {},
        bashls = {},
        tinymist = {},
        eslint = {},
        marksman = {},
        zls = {},
        yamlls = {
                settings = {
                        yaml = {
                                format = {
                                        enable = false,
                                },
                        },
                },
        },
}

return {
        {
                "neovim/nvim-lspconfig",
                lazy = false,
                dependencies = { "saghen/blink.cmp" },
                config = function()
                        vim.lsp.config("*", {
                                capabilities = require("blink.cmp").get_lsp_capabilities(),
                        })

                        for server, server_config in pairs(servers) do
                                vim.lsp.config(server, server_config)
                                vim.lsp.enable(server)
                        end

                        vim.diagnostic.config({
                                float = {
                                        border = "rounded",
                                        source = true,
                                },
                        })
                end,
        },
        { "williamboman/mason.nvim" },
        {
                "williamboman/mason-lspconfig.nvim",
                config = function()
                        require("mason").setup({})
                        vim.lsp.config("lua_ls", {
                                settings = {
                                        Lua = {
                                                runtime = {
                                                        version = "LuaJIT",
                                                },
                                                diagnostics = {
                                                        globals = { "vim" },
                                                },
                                                workspace = {
                                                        checkThirdParty = false,
                                                        library = vim.api.nvim_get_runtime_file(
                                                                "lua",
                                                                true
                                                        ),
                                                },
                                        },
                                },
                        })
                        vim.lsp.config("pyright", {
                                settings = {
                                        pyright = {
                                                disableOrganizeImports = true,
                                        },
                                        python = {
                                                analysis = {
                                                        ignore = { "*" },
                                                },
                                        },
                                },
                        })
                        require("mason-lspconfig").setup({
                                ensure_installed = {
                                        "lua_ls",
                                        "rust_analyzer",
                                        "bashls",
                                        "jsonls",
                                        "ts_ls",
                                        "zls",
                                        "eslint",
                                        "thriftls",
                                        "buf_ls",
                                        "marksman",
                                        "yamlls",
                                        "tinymist",
                                },
                        })
                end,
        },
        {
                "j-hui/fidget.nvim",
                opts = { notification = { window = { winblend = 0 } } },
        },
        {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                        library = {
                                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                        },
                },
        },
}
