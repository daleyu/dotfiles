-- set space as leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.termguicolors = true

-- nerd font
vim.g.have_nerd_font = true

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.wo.number = true
vim.o.statuscolumn = "%s %l %r "

-- scroll off
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 10

-- Sets colors to line numbers Above, Current and Below  in this order
function LineNumberColors()
	vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#b09d99', bold = false })
	vim.api.nvim_set_hl(0, 'LineNr', { fg = '#b09d99', bold = false })
	vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#b09d99', bold = false })
end

-- don't show the mode
vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true

-- Search Settings
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- tab stops and shift
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.laststatus = 3

-- width
-- vim.opt.colorcolumn = "80"
vim.opt.textwidth = 80
vim.opt.wrapmargin = 10


-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Auto-install lazy.nvim if not present
if not vim.uv.fs_stat(lazypath) then
	print('Installing lazy.nvim....')
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
	print('Done.')
end

---------------------------
---lazynvim downloads -----
---------------------------

vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
	{ "catppuccin/nvim",      name = "catppuccin", priority = 1000 },
	{ 'folke/tokyonight.nvim' },
	{ 'mbbill/undotree' },
	{
		'neovim/nvim-lspconfig',
	},
	{ "mfussenegger/nvim-lint" },
	{ "stevearc/conform.nvim",     opts = {}, },
	{ 'echasnovski/mini.nvim',     version = false },
	{ 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "nvim-treesitter/nvim-treesitter" },
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{ "nvim-treesitter/nvim-treesitter-context" },
	{ "ibhagwan/fzf-lua",                           dependencies = { "nvim-tree/nvim-web-devicons" } },
	{ 'williamboman/mason.nvim' },
	{ 'williamboman/mason-lspconfig.nvim' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/nvim-cmp' },
	{ "mistricky/codesnap.nvim",                    build = "make" },
	{ "sindrets/diffview.nvim" },
	{ "nvim-tree/nvim-tree.lua",                    dependencies = { "nvim-tree/nvim-web-devicons" } },
	{
		"NeogitOrg/neogit",
		dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "ibhagwan/fzf-lua" },
		config = true,
	},
	{ "lewis6991/gitsigns.nvim", opts = {} },
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		init = function()
			vim.g.vimtex_view_method = "zathura"
		end
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		}
	},
	{ 'vim-test/vim-test' },
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{ "MagicDuck/grug-far.nvim", opts = { windowCreationCommand = "e" } },
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", 'gomod' },
		build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
	},
	{ "folke/zen-mode.nvim", },
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	{ "norcalli/nvim-colorizer.lua", opts = {} },
	{
		"karb94/neoscroll.nvim",
		opts = {},
	},
	{
		"jake-stewart/multicursor.nvim",
		branch = "1.0",
		config = function()
			local mc = require("multicursor-nvim")
			mc.setup()

			local set = vim.keymap.set

			-- Add or skip cursor above/below the main cursor.
			set({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end)
			set({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end)
			set({ "n", "x" }, "<leader><up>", function() mc.lineSkipCursor(-1) end)
			set({ "n", "x" }, "<leader><down>", function() mc.lineSkipCursor(1) end)

			-- Add or skip adding a new cursor by matching word/selection
			set({ "n", "x" }, "<leader>n", function() mc.matchAddCursor(1) end)
			set({ "n", "x" }, "<leader>s", function() mc.matchSkipCursor(1) end)
			set({ "n", "x" }, "<leader>N", function() mc.matchAddCursor(-1) end)
			set({ "n", "x" }, "<leader>S", function() mc.matchSkipCursor(-1) end)

			-- Add and remove cursors with control + left click.
			set("n", "<c-leftmouse>", mc.handleMouse)
			set("n", "<c-leftdrag>", mc.handleMouseDrag)
			set("n", "<c-leftrelease>", mc.handleMouseRelease)

			-- Disable and enable cursors.
			set({ "n", "x" }, "<c-q>", mc.toggleCursor)

			-- Mappings defined in a keymap layer only apply when there are
			-- multiple cursors. This lets you have overlapping mappings.
			mc.addKeymapLayer(function(layerSet)
				-- Select a different cursor as the main one.
				layerSet({ "n", "x" }, "<left>", mc.prevCursor)
				layerSet({ "n", "x" }, "<right>", mc.nextCursor)

				-- Delete the main cursor.
				layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

				-- Enable and clear cursors using escape.
				layerSet("n", "<esc>", function()
					if not mc.cursorsEnabled() then
						mc.enableCursors()
					else
						mc.clearCursors()
					end
				end)
			end)

			-- Customize how cursors look.
			local hl = vim.api.nvim_set_hl
			hl(0, "MultiCursorCursor", { link = "Cursor" })
			hl(0, "MultiCursorVisual", { link = "Visual" })
			hl(0, "MultiCursorSign", { link = "SignColumn" })
			hl(0, "MultiCursorMatchPreview", { link = "Search" })
			hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
			hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
			hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
		end
	},
})


-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
	'force',
	lspconfig_defaults.capabilities,
	require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
		vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
		vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
		vim.keymap.set("n", "<leader>gd", "<cmd>FzfLua lsp_definitions<cr>")
		--set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<cr>")
		--set("n", "go", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "go", "<cmd>FzfLua lsp_type_defs<cr>")
		--set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references<cr>")
		vim.keymap.set("n", "<leader>ge", "<cmd>FzfLua diagnostics_document<cr>")
		vim.keymap.set("n", "<leader>gw", "<cmd>FzfLua diagnostics_document<cr>")

		vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
		vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
		vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
		vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
	end,
})

vim.diagnostic.config({
	float = {
		border = "rounded",
		source = true,
	},
})


----------------
-- FORMATTING --
----------------

local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		luau = { "stylua" },
		go = { "gofmt", "goimports" },
		python = { "black" },
		typescript = { 'prettierd', "prettier", stop_after_first = true },
		typescriptreact = { 'prettierd', "prettier", stop_after_first = true },
		javascript = { 'prettierd', "prettier", stop_after_first = true },
		javascriptreact = { 'prettierd', "prettier", stop_after_first = true },
		json = { 'prettierd', "prettier", stop_after_first = true },
		html = { 'prettierd', "prettier", stop_after_first = true },
		css = { 'prettierd', "prettier", stop_after_first = true },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	format = {
		stop_after_first = true,
	}
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

---------------
--- LINTING ---
---------------
local lint = require("lint")
lint.linters_by_ft = {
	lua = { "selene" },
	luau = { "selene" },
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		lint.try_lint()
	end,
})

----------------
-- LSPCONFIG --
----------------
local servers = {
	"gopls",
	"lua_ls",
	"rust_analyzer",
	"pyright",
	"bashls",
	"jsonls",
	"ts_ls",
	"eslint",
	"jdtls",
}

local lspconfig = require('lspconfig')
for _, server in ipairs(servers) do
	lspconfig[server].setup({})
end

require('mason').setup({})
require('mason-lspconfig').setup({
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	},
	ensure_installed = servers,
})


local dartExcludedFolders = {
	vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
	vim.fn.expand("$HOME/.pub-cache"),
	vim.fn.expand("/opt/homebrew/"),
	vim.fn.expand("$HOME/tools/flutter/"),
}

require("lspconfig").dartls.setup({
	cmd = { "dart", "language-server", "--protocol=lsp" },
	filetypes = { "dart" },
	init_options = {
		onlyAnalyzeProjectsWithOpenFiles = false,
		suggestFromUnimportedLibraries = true,
		closingLabels = true,
		outline = false,
		flutterOutline = false,
	},
	settings = {
		dart = {
			analysisExcludedFolders = dartExcludedFolders,
			updateImportsOnRename = true,
			completeFunctionCalls = true,
			showTodos = true,
		},
	},
})

------------------
-- autocomplete --
------------------

local cmp = require('cmp')

cmp.setup({
	sources = {
		{ name = 'nvim_lsp' },
	},
	mapping = cmp.mapping.preset.insert({
		-- Navigate between completion items
		['<C-p>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
		['<C-n>'] = cmp.mapping.select_next_item({ behavior = 'select' }),

		-- `Enter` key to confirm completion
		['<CR>'] = cmp.mapping.confirm({ select = false }),

		-- Ctrl+Space to trigger completion menu
		['<C-Space>'] = cmp.mapping.complete(),

		-- Scroll up and down in the completion documentation
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
	}),
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
})

----------------
---- THEME -----
----------------

local latte = require("catppuccin.palettes").get_palette "latte"
local frappe = require("catppuccin.palettes").get_palette "frappe"
local macchiato = require("catppuccin.palettes").get_palette "macchiato"
local mocha = require("catppuccin.palettes").get_palette "mocha"
require("catppuccin").setup({
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		fzf = true,
		grug_far = false,
		harpoon = false,
		treesitter = true,
		notify = false,
		neogit = true,
		mini = {
			enabled = true,
			indentscope_color = "",
		},
	},
	flavour = "macchiato",
	background = { -- :h background
		light = "latte",
		dark = "macchiato",
	},
	transparent_background = true,
})
require('lualine').setup {
	options = {
		theme = "catppuccin"
	}
}

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")

vim.api.nvim_create_autocmd({ "BufEnter", "VimEnter" }, {
	callback = function()
		vim.opt.nu = true
		vim.opt.rnu = true
		vim.cmd("hi cursorline guibg=NONE")
		vim.opt.signcolumn = "yes"
		vim.cmd("ColorizerAttachToBuffer")
	end,
})
------------------
----- FZFLUA -----
------------------

require("fzf-lua").setup({
	keymap = {
		fzf = {
			-- use cltr-q to select all items and convert to quickfix list
			["ctrl-q"] = "select-all+accept",
		},
	},
	grep = {
		rg_opts = "--color=always --hidden --line-number --smart-case --no-heading --column",
	},
	files = {
		fd_opts = "--color=never --type f --hidden --follow --exclude .git",
		rg_opts = "--color=never --files --hidden --follow -g '!.git'",
	},
})
-- use `fzf-lua` for replace vim.ui.select
require("fzf-lua").register_ui_select()

-----------------
--- UNDO-TREE ---
-----------------
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)


-------------------------
--- Treesitter configs---
-------------------------
require("nvim-treesitter.configs").setup({
	ensure_installed = { "cpp", "typescript", "tsx", "python", "luau", "javascript", "rust", "json", "lua", "go", "html", "dart", "ruby", "latex", "javascript" },
	highlight = {
		enable = true,
	},
	indent = {
		enable = true
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			node_incremental = "v",
			node_decremental = "V",
		},
	},
	textobjects = {
		select = {
			enable = true,
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				-- You can optionally set descriptions to the mappings (used in the desc parameter of
				-- nvim_buf_set_keymap) which plugins like which-key display
				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
				-- You can also use captures from other query groups like `locals.scm`
				["al"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>cpi"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>cpI"] = "@parameter.inner",
			},
		},
	},
})
require 'treesitter-context'.setup {
	enable = true,        -- Enable this plugin (Can be enabled/disabled later via commands)
	multiwindow = false,  -- Enable multiwindow support.
	max_lines = 1,        -- How many lines the window should span. Values <= 0 mean no limit.
	min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
	line_numbers = true,
	multiline_threshold = 1, -- Maximum number of lines to show for a single context
	trim_scope = 'inner', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
	mode = 'cursor',      -- Line used to calculate context. Choices: 'cursor', 'topline'
	-- Separator between context and content. Should be a single character string, like '-'.
	-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
	separator = nil,
	zindex = 40,  -- The Z-index of the context window
	on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

--------------------
----- HARPOON ------
--------------------

local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-t>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(3) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

----------------
--- Diffview ---
----------------
local actions = require("diffview.actions")

require("diffview").setup({})


-- nvim-tree
require("nvim-tree").setup()

----------------
-- MINI.FILES --
----------------

local KEYMAP_SETTINGS = {}
do
	local set = vim.keymap.set

	KEYMAP_SETTINGS.mini_files = function(mini_files)
		mini_files.config.mappings.close = "<esc>"
		set("n", "<leader>o", mini_files.open)
		set("n", "<leader>s", function() -- set working dir to current buffer
			local state = mini_files.get_explorer_state()
			local dir = state and state.branch[state.depth_focus] or "%:h"
			vim.cmd("cd " .. dir)
			vim.cmd("pwd")
		end)
		set("n", "<leader><space>", function()
			mini_files.open(vim.fn.expand("%:p:h"), false)
		end)
	end
end

local mini_files = require("mini.files")
mini_files.setup({
	windows = {
		preview = true,
		width_preview = 40,
		width_nofocus = 30,
		width_focus = 30,
	},
})


KEYMAP_SETTINGS.mini_files(mini_files)

----------------
---- neogit-----
----------------
require("neogit").setup({
	status = {
		recent_commit_include_author_info = true
	}
})


--------------
---GITSIGNS---
--------------
require('gitsigns').setup({})

local gitsigns = require('gitsigns')
vim.keymap.set("n", "<leader>hb", "<cmd>Gitsigns blame<cr>")
vim.keymap.set("n", "<leader>hl", "<cmd>Gitsigns toggle_current_line_blame<cr>")
vim.keymap.set('n', ']h', function()
	if vim.wo.diff then
		vim.cmd.normal({ ']h', bang = true })
	else
		gitsigns.nav_hunk('next')
	end
end)

vim.keymap.set('n', '[h', function()
	if vim.wo.diff then
		vim.cmd.normal({ '[h', bang = true })
	else
		gitsigns.nav_hunk('prev')
	end
end)

--------------
---CODESNAP---
--------------

require("codesnap").setup({
	has_breadcrumbs = true,
	show_workspace = true,
	has_line_number = true,
	bg_padding = 0,
	save_path = os.getenv("XDG_PICTURES_DIR") or (os.getenv("HOME") .. "/Pictures"),
	mac_window_bar = false,

})

vim.keymap.set("v", "<leader>cs", "<cmd>CodeSnap<cr>")
-- vim.keymap.set("v", "<leader>cw", "<cmd>CodeSnapSave<cr>")
vim.keymap.set("v", "<leader>ca", "<cmd>CodeSnapASCII<cr>")


require("noice").setup({
	cmdline = {},
	messages = {},
	popupmenu = {},
	redirect = {},
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
	},
})

require("notify").setup({
	background_colour = "#bb9af7",
})



------------------------
-- LANGUAGE SPECIFIC ---
------------------------

-------------
-- GOLANG ---
-------------
require('go').setup()


------------------------
-- Global Keymappings---
------------------------

--- utility keymappings
vim.keymap.set("i", "{<cr>", "{<cr>}<esc>O")
vim.keymap.set("n", "x", "\"_x")
vim.keymap.set("n", "<leader><CR>", ":nohlsearch<CR>", { noremap = true })
vim.keymap.set("n", "<leader>vv", "ggVG\"+y")
vim.keymap.set("n", "Y", "y$")
vim.keymap.set("n", "V", "v$")
vim.keymap.set("n", "vv", "V")

-- goated binds
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>v", [["_dP]])

vim.keymap.set("n", "<leader>dd", "\"_d")
vim.keymap.set("v", "<leader>dd", "\"_d")

vim.keymap.set("n", "ge", vim.diagnostic.open_float)

vim.keymap.set("n", "<leader>cc", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>gfs", '<Cmd>! git diff origin/master --name-only<CR>')
vim.keymap.set("n", "<leader>gfi", '<Cmd>! git diff origin/main --name-only<CR>')

-- separate clipboards
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+y")

-- navigation
require('neoscroll').setup({ mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>' } })
vim.keymap.set("n", "<C-f>", "<C-f>zz", { noremap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "<C-b>", "<C-b>zz", { noremap = true })
vim.keymap.set({ "n", "v", "x" }, "<c-j>", "7<c-e>")
vim.keymap.set({ "n", "v", "x" }, "<c-k>", "7<c-y>")
vim.keymap.set("n", "<c-h>", "<c-w>W")
vim.keymap.set("n", "<c-l>", "<c-w>w")
vim.keymap.set("n", "gb", "<cmd>b#<cr>")
vim.keymap.set("n", "]b", "<cmd>bn<cr>")
vim.keymap.set("n", "[b", "<cmd>bp<cr>")
vim.keymap.set("n", "g[", "gT")
vim.keymap.set("n", "g]", "gt")

-- yank current file path
function InsertFullPath()
	local filepath = vim.fn.expand('%')
	vim.fn.setreg('+', filepath) -- write to clippoard
	print("Copied file path to system clipboard")
end

vim.keymap.set('n', '<leader>lc', InsertFullPath, { noremap = true, silent = true })

-- plugin binds
vim.keymap.set('n', '<leader>b', '<Cmd>NvimTreeToggle<CR>')

vim.keymap.set('n', '<leader>p', '<Cmd>FzfLua<CR>')
vim.keymap.set('n', '<leader>f', '<Cmd>FzfLua files<CR>')
vim.keymap.set('n', '<leader>/', '<Cmd>FzfLua grep<CR>')
vim.keymap.set('n', '<leader>l/', '<Cmd>FzfLua live_grep<CR>')
vim.keymap.set('n', '<leader>*', '<Cmd>FzfLua grep_cword <CR>')
vim.keymap.set("n", "<leader>zz", "<cmd>FzfLua zoxide<cr>")
vim.keymap.set("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>")
vim.keymap.set("n", "<leader>,", "<cmd>FzfLua buffers<cr>")
vim.keymap.set("n", "<leader>t", "<cmd>FzfLua treesitter<cr>")

vim.keymap.set("n", "<leader>T", "<cmd>TestFile<CR>")

vim.keymap.set("n", "<leader>ng", "<cmd>Neogit<cr>")
vim.keymap.set("n", "<leader>nd", "<cmd>Neogit diff<cr>")

vim.keymap.set("n", "<leader>df", "<cmd>DiffviewFileHistory<cr>")
vim.keymap.set("n", "<leader>do", "<cmd>DiffviewOpen<cr>")
vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<cr>")

vim.keymap.set("n", "<leader>r", "<cmd>GrugFar<cr>")
vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>")

vim.keymap.set("n", "<leader>zm", "<cmd>ZenMode<cr>")


vim.keymap.set("n", "<leader>q", function()
	local pdf_file = vim.fn.expand('%:r') .. '.pdf'
	vim.cmd('silent !zathura ' .. pdf_file .. ' &')
end)

-- Call Line Number color change function
LineNumberColors()
