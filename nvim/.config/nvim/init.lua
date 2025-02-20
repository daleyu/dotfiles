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
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#b09d99', bold=false })
    vim.api.nvim_set_hl(0, 'LineNr', { fg='#b09d99',bold=false })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#b09d99', bold=false })
end

-- don't show the mode
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

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
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "nvim-treesitter/nvim-treesitter" },
	{'folke/tokyonight.nvim'},
	{'neovim/nvim-lspconfig'},
	{ 'echasnovski/mini.nvim', version = false },
	{'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
	{ "nvim-treesitter/nvim-treesitter" },
	{ "nvim-treesitter/nvim-treesitter-context" },
	{ "ibhagwan/fzf-lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'hrsh7th/cmp-nvim-lsp'},
	{ "SmiteshP/nvim-navic", dependencies = {"neovim/nvim-lspconfig"} }, 
	{'hrsh7th/nvim-cmp'},
	{"sindrets/diffview.nvim"},
	{"nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{
		"NeogitOrg/neogit",
		dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "ibhagwan/fzf-lua" },
		config = true,
	},
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
    local opts = {buffer = event.buf}

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
	vim.keymap.set("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<cr>")
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})


----------------
-- LSPCONFIG --
----------------
local navic = require("nvim-navic")

require'lspconfig'.gopls.setup({
	on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end
})

require'lspconfig'.pyright.setup({})

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
    {name = 'nvim_lsp'},
  },
  mapping = cmp.mapping.preset.insert({
    -- Navigate between completion items
    ['<C-p>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<C-n>'] = cmp.mapping.select_next_item({behavior = 'select'}),

    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

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
})
require'treesitter-context'.setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  multiwindow = false, -- Enable multiwindow support.
  max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 1, -- Maximum number of lines to show for a single context
  trim_scope = 'inner', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 40, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

----------------
--- Diffview ---
----------------
local actions = require("diffview.actions")

require("diffview").setup({})


-- nvim-tree
require("nvim-tree").setup()
 
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
		set("n", "<leader><space>", "<cmd>lua MiniFiles.open(vim.fn.expand(\"%h\"))<CR>")

	end
end
----------------
-- MINI.FILES --
----------------

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


-- yank current file path
function insertFullPath()
  local filepath = vim.fn.expand('%')
  vim.fn.setreg('+', filepath) -- write to clippoard
end

vim.keymap.set('n', '<leader>lc', insertFullPath, { noremap = true, silent = true })

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")


------------------------
-- Global Keymappings---
------------------------
vim.keymap.set('n', '<leader>p', '<Cmd>FzfLua<CR>')
vim.keymap.set('n', '<leader>f', '<Cmd>FzfLua files<CR>')
vim.keymap.set('n', '<leader>b', '<Cmd>NvimTreeToggle<CR>')
vim.keymap.set("i", "{<cr>", "{<cr>}<esc>O")
vim.keymap.set("n", "x", "\"_x")
vim.keymap.set("n", "<leader><CR>", ":nohlsearch<CR>", { noremap = true })
vim.keymap.set("n", "<C-f>", "<C-f>zz", { noremap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "<C-b>", "<C-b>zz", { noremap = true })
vim.keymap.set('n', '<leader>/', '<Cmd>FzfLua grep<CR>')  -- Search in all files
vim.keymap.set('n', '<leader>*', '<Cmd>FzfLua grep_cword<CR>')  -- Search word under cursor
vim.keymap.set("n", "<leader>z", "<cmd>FzfLua zoxide<cr>")

vim.keymap.set("n", "<leader>ng", "<cmd>Neogit<cr>")
vim.keymap.set("n", "<leader>nd", "<cmd>Neogit diff<cr>")

vim.keymap.set("n", "<leader>df", "<cmd>DiffviewFileHistory<cr>")
vim.keymap.set("n", "<leader>do", "<cmd>DiffviewOpen<cr>")
vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<cr>")



-- Call Line Number color change function
LineNumberColors()
