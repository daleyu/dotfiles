local function configure_python(_, config)
        config.settings.python.pythonPath = require("config.python").resolve(config.root_dir)
end

local servers = {
        lua_ls = {
                settings = {
                        Lua = {
                                runtime = { version = "LuaJIT" },
                                diagnostics = { globals = { "vim" } },
                                hover = { enumsLimit = 100, previewFields = 100 },
                                workspace = {
                                        checkThirdParty = false,
                                        library = vim.api.nvim_get_runtime_file("lua", true),
                                },
                        },
                },
        },
        pyright = {
                before_init = configure_python,
                settings = {
                        pyright = { disableOrganizeImports = true },
                        python = { analysis = { ignore = {} } },
                },
        },
        rust_analyzer = { settings = { ["rust-analyzer"] = { check = { command = "clippy" } } } },
        yamlls = { settings = { yaml = { format = { enable = false } } } },
        vtsls = {},
        jsonls = {},
        gopls = {},
        ts_ls = {},
        sqls = {},
        thriftls = {},
        buf_ls = {},
        bashls = {},
        tinymist = {},
        eslint = {},
        marksman = {},
        zls = {},
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
                                float = { border = "rounded", source = true },
                        })
                end,
        },
        { "williamboman/mason.nvim" },
        {
                "williamboman/mason-lspconfig.nvim",
                config = function()
                        require("mason").setup({})
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
