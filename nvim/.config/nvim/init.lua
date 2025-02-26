-- set space as leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- nerd font
vim.g.have_nerd_font = true

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.wo.number = true
vim.o.statuscolumn = "%s %l %r "

-- scroll off
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

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
	{ "catppuccin/nvim",                name = "catppuccin",                             priority = 1000 },
	{ "nvim-treesitter/nvim-treesitter" },
	{ 'folke/tokyonight.nvim' },
	{ 'mbbill/undotree' },
	{ 'neovim/nvim-lspconfig' },
	{ "mfussenegger/nvim-lint" },
	{ "stevearc/conform.nvim" },
	{ 'echasnovski/mini.nvim',          version = false },
	{ 'nvim-lualine/lualine.nvim',      dependencies = { 'nvim-tree/nvim-web-devicons' } },
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
	{ "nvim-treesitter/nvim-treesitter-context" },
	{ "ibhagwan/fzf-lua",                       dependencies = { "nvim-tree/nvim-web-devicons" } },
	{ 'williamboman/mason.nvim' },
	{ 'williamboman/mason-lspconfig.nvim' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ "SmiteshP/nvim-navic",                    dependencies = { "neovim/nvim-lspconfig" } },
	{ 'hrsh7th/nvim-cmp' },
	{ "mistricky/codesnap.nvim",                build = "make" },
	{ "sindrets/diffview.nvim" },
	{ "nvim-tree/nvim-tree.lua",                dependencies = { "nvim-tree/nvim-web-devicons" } },
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
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		}
	}
})

vim.opt.termguicolors = true

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

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
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
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
local navic = require("nvim-navic")

require 'lspconfig'.gopls.setup({
	on_attach = function(client, bufnr)
		navic.attach(client, bufnr)
	end
})

require 'lspconfig'.pyright.setup({})

require 'lspconfig'.lua_ls.setup({})

require('mason').setup({})
require('mason-lspconfig').setup({
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	},
})

-- autocomplete --
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
require('lualine').setup {
	options = {
		theme = "catppuccin"
	}
}
require("catppuccin").setup({
	flavour = "macchiato",
	background = { -- :h background
		light = "latte",
		dark = "macchiato",
	},
	transparent_background = true,
})

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
	ensure_installed = { "cpp", "typescript", "tsx", "python", "luau", "javascript", "rust", "json", "lua", "go", "html" },
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

require('mini.surround').setup()



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

vim.keymap.set("n", "<leader>hb", "<cmd>Gitsigns blame<cr>")
vim.keymap.set("n", "<leader>hl", "<cmd>Gitsigns toggle_current_line_blame<cr>")

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

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")

-- require("noice").setup({
-- 	lsp = {
-- 		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
-- 		override = {
-- 			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
-- 			["vim.lsp.util.stylize_markdown"] = true,
-- 			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
-- 		},
-- 	},
-- 	presets = {
-- 		bottom_search = true,     -- use a classic bottom cmdline for search
-- 		command_palette = true,   -- position the cmdline and popupmenu together
-- 		long_message_to_split = true, -- long messages will be sent to a split
-- 		inc_rename = false,       -- enables an input dialog for inc-rename.nvim
-- 		lsp_doc_border = false,   -- add a border to hover docs and signature help
-- 	},
-- })


------------------------
-- Global Keymappings---
------------------------

--- utility keymappings
vim.keymap.set("i", "{<cr>", "{<cr>}<esc>O")
vim.keymap.set("n", "x", "\"_x")
vim.keymap.set("n", "<leader><CR>", ":nohlsearch<CR>", { noremap = true })
vim.keymap.set("n", "<leader>aa", "ggvvG")
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

-- separate clipboards
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+y")

-- navigation
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
vim.keymap.set("n", "<leader>z", "<cmd>FzfLua zoxide<cr>")
vim.keymap.set("n", "<leader>,", "<cmd>FzfLua buffers<cr>")
vim.keymap.set("n", "<leader>t", "<cmd>FzfLua treesitter<cr>")

vim.keymap.set("n", "<leader>ng", "<cmd>Neogit<cr>")
vim.keymap.set("n", "<leader>nd", "<cmd>Neogit diff<cr>")

vim.keymap.set("n", "<leader>df", "<cmd>DiffviewFileHistory<cr>")
vim.keymap.set("n", "<leader>do", "<cmd>DiffviewOpen<cr>")
vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<cr>")

vim.keymap.set("n", "<leader>q", function()
	local pdf_file = vim.fn.expand('%:r') .. '.pdf'
	vim.cmd('silent !zathura ' .. pdf_file .. ' &')
end)

-- Call Line Number color change function
LineNumberColors()
