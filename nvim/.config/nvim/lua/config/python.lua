local M = {}

function M.resolve(cwd)
        local mise = vim.fn.exepath("mise")
        if mise ~= "" then
                local ok, result = pcall(function()
                        return vim.system({ mise, "which", "python3" }, {
                                cwd = cwd,
                                text = true,
                        }):wait(1500)
                end)
                if ok and result.code == 0 then
                        local path = vim.trim(result.stdout or "")
                        if path ~= "" and not path:match("/shims/") and vim.fn.executable(path) == 1 then
                                return path
                        end
                end
        end

        for _, path in ipairs({ "/opt/homebrew/bin/python3", "/usr/local/bin/python3", "/usr/bin/python3" }) do
                if vim.fn.executable(path) == 1 then
                        return path
                end
        end
end

return M
