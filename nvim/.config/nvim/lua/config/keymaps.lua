vim.keymap.set("i", "{<cr>", "{<cr>}<esc>O")
vim.keymap.set("n", "x", "\"_x")
vim.keymap.set("n", "<leader>dd", "\"_dd")
vim.keymap.set("v", "<leader>dd", "\"_dd")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<BS>", "hx")
vim.keymap.set("n", "<leader><BS>", ":bd<CR>")
vim.keymap.set("n", "<leader><CR>", ":nohlsearch<CR>", { noremap = true })
vim.keymap.set("n", "<leader>vv", "ggVG\"+y")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>v", [["_dP]])

vim.keymap.set("x", ">", ">gv")
vim.keymap.set("x", "<", "<gv")

vim.keymap.set("n", "ge", vim.diagnostic.open_float)
vim.keymap.set("n", "g/", [[/\u<enter>]])

vim.keymap.set("n", "<leader>cc", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

local antonyms = {
	"true", "false",
	"after", "before",
	"start", "end",
	"left", "right",
	"first", "last",
	"True", "False",
	"After", "Before",
	"Start", "End",
	"Left", "Right",
	"First", "Last",
}

local function get_antonym(word)
	for i = 1, #antonyms, 2 do
		if antonyms[i] == word then
			return antonyms[i + 1]
		elseif antonyms[i + 1] == word then
			return antonyms[i]
		end
	end
	return nil
end

local function invert(calledFromVisual)
	local api = vim.api
	local bufnr = api.nvim_get_current_buf()

	if calledFromVisual then
		local start_line = vim.fn.line("'<")
		local end_line = vim.fn.line("'>")
		local lines = api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)

		for i, line in ipairs(lines) do
			local new_line = line:gsub("[%w_]+", function(w)
				return get_antonym(w) or w
			end)
			if new_line ~= line then
				api.nvim_buf_set_lines(bufnr, start_line - 1 + (i - 1), start_line + (i - 1), false,
					{ new_line })
			end
		end
	else
		local row, col = unpack(api.nvim_win_get_cursor(0))
		row = row - 1
		local line = api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1]

		local left = col
		local right = col
		while left > 0 and line:sub(left, left):match("[%w_]") do left = left - 1 end
		if not line:sub(left, left):match("[%w_]") then left = left + 1 end
		while right <= #line and line:sub(right, right):match("[%w_]") do right = right + 1 end
		local to_col = right - 1
		local from_col = left

		local word = line:sub(from_col, to_col)
		local antonym = get_antonym(word)

		if antonym then
			api.nvim_buf_set_text(bufnr, row, from_col - 1, row, to_col, { antonym })
			api.nvim_win_set_cursor(0, { row + 1, from_col - 1 + #antonym })
		end
	end
end

vim.keymap.set("n", "<leader>i", function() invert(false) end, { noremap = true, silent = true })
vim.keymap.set("v", "<leader>i", function() invert(true) end, { noremap = true, silent = true })

-- Get the current file path (Override by Work specific override if provided)
vim.keymap.set('n', '<leader>lc', function()
	local filepath = vim.fn.expand('%')
	vim.fn.setreg('+', filepath)
	require("snacks").notify.notify("Copied file path to system clipboard")
end, { noremap = true, silent = true, desc = "Copy file path" })

vim.keymap.set("n", "<leader>qf", '<Cmd>copen<CR>')
vim.keymap.set("n", "]f", '<Cmd>cnext<CR>')
vim.keymap.set("n", "[f", '<Cmd>cprev<CR>')

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+y")

vim.keymap.set({ "n", "v", "x" }, "<c-j>", "7<c-e>")
vim.keymap.set({ "n", "v", "x" }, "<c-k>", "7<c-y>")
vim.keymap.set("n", "<c-h>", "<c-w>W")
vim.keymap.set("n", "<c-l>", "<c-w>w")
vim.keymap.set("n", "gb", "<cmd>b#<cr>")
vim.keymap.set("n", "]b", "<cmd>bn<cr>")
vim.keymap.set("n", "[b", "<cmd>bp<cr>")
vim.keymap.set("n", "[g", "gT")
vim.keymap.set("n", "]g", "gt")

vim.keymap.set("n", "[x", "<cmd>/>>>>>>><cr>")
vim.keymap.set("n", "]x", "<cmd>?<<<<<<<<cr>")

vim.keymap.set('n', '<leader>PP', ':echo getpid()<CR>', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>q", function()
	local pdf_file = vim.fn.expand('%:r') .. '.pdf'
	vim.cmd('silent !zathura ' .. pdf_file .. ' &')
end)

vim.keymap.set("n", "<leader>mn", function()
	vim.api.nvim_input("dd/##\r" .. "p")
end, { desc = "Move current line below next ##" })

vim.keymap.set("v", "<leader>mn", function()
	vim.api.nvim_input("dd/##\r" .. "p")
end, { desc = "Move current line below next ##" })

vim.keymap.set('n', '<leader>tcc', function()
	if vim.wo.colorcolumn == "" then
		vim.wo.colorcolumn = "80"
		require("snacks").notify.notify("Colorcolumn ON")
	else
		vim.wo.colorcolumn = ""
		require("snacks").notify.notify("Colorcolumn OFF")
	end
end, { desc = "Toggle colorcolumn", noremap = true, silent = true })

local function toggle_case()
	local word = vim.fn.expand('<cword>')
	if word == "" then return end
	local new_word
	if word:find("_") then
		new_word = word:gsub("_(%w)", string.upper)
	else
		new_word = word:gsub("(%l)(%u)", "%1_%2"):lower()
	end
	vim.cmd('normal! ciw' .. new_word .. '\27')
end

vim.keymap.set('n', '<leader>vcc', toggle_case, { desc = "Toggle between camelCase/PascalCase and snake_case" })
