local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
        print("Installing lazy.nvim....")
        vim.fn.system({
                "git",
                "clone",
                "--filter=blob:none",
                "https://github.com/folke/lazy.nvim.git",
                "--branch=stable",
                lazypath,
        })
        print("Done.")
end

vim.opt.rtp:prepend(lazypath)

local spec = {
        { import = "plugins" },
}

-- conditionally load stripe plugins if the directory exists
local stripe_plugins_path = vim.fn.stdpath("config") .. "/lua/plugins-stripe"
if vim.uv.fs_stat(stripe_plugins_path) then
        table.insert(spec, { import = "plugins-stripe" })
end

require("lazy").setup({
        spec = spec,
        -- Plugins marked `dev = true` load from the first local checkout found in these
        -- directories, falling back to git (and lazy-lock.json) without one.
        dev = {
                path = function(plugin)
                        for _, root in ipairs({ "~/stripe", "~/Development" }) do
                                local dir = vim.fs.normalize(root .. "/" .. plugin.name)
                                if vim.uv.fs_stat(dir) then
                                        return dir
                                end
                        end
                        return vim.fs.normalize("~/Development/" .. plugin.name)
                end,
                fallback = true,
        },
        performance = {
                rtp = {
                        reset = false,
                },
        },
})
