-- set space as leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- nerd font
vim.g.have_nerd_font = false

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

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "nvim-treesitter/nvim-treesitter" },
	{'folke/tokyonight.nvim'},
	{'neovim/nvim-lspconfig'},
	{ 'echasnovski/mini.nvim', version = false },
	{'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
	{ "nvim-treesitter/nvim-treesitter" },
	{ "ibhagwan/fzf-lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'hrsh7th/cmp-nvim-lsp'},
	{ "SmiteshP/nvim-navic", dependencies = {"neovim/nvim-lspconfig"} }, 
	{'hrsh7th/nvim-cmp'},
	{"sindrets/diffview.nvim"},
	{"nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
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
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
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

-- Treesitter configs
require("nvim-treesitter.configs").setup({
	ensure_installed = { "cpp", "typescript", "tsx", "python", "luau", "javascript", "rust", "json", "lua", "go", "html" },
	highlight = {
		enable = true,
	},
	indent = {
		enable = true
	},
})

----------------
--- Diffview ---
----------------
local actions = require("diffview.actions")

require("diffview").setup({
  diff_binaries = false,    -- Show diffs for binaries
  enhanced_diff_hl = false, -- See |diffview-config-enhanced_diff_hl|
  git_cmd = { "git" },      -- The git executable followed by default args.
  hg_cmd = { "hg" },        -- The hg executable followed by default args.
  use_icons = true,         -- Requires nvim-web-devicons
  show_help_hints = true,   -- Show hints for how to open the help panel
  watch_index = true,       -- Update views and index buffers when the git index changes.
  icons = {                 -- Only applies when use_icons is true.
    folder_closed = "",
    folder_open = "",
  },
  signs = {
    fold_closed = "",
    fold_open = "",
    done = "✓",
  },
  view = {
    -- Configure the layout and behavior of different types of views.
    -- Available layouts:
    --  'diff1_plain'
    --    |'diff2_horizontal'
    --    |'diff2_vertical'
    --    |'diff3_horizontal'
    --    |'diff3_vertical'
    --    |'diff3_mixed'
    --    |'diff4_mixed'
    -- For more info, see |diffview-config-view.x.layout|.
    default = {
      -- Config for changed files, and staged files in diff views.
      layout = "diff2_horizontal",
      disable_diagnostics = false,  -- Temporarily disable diagnostics for diff buffers while in the view.
      winbar_info = false,          -- See |diffview-config-view.x.winbar_info|
    },
    merge_tool = {
      -- Config for conflicted files in diff views during a merge or rebase.
      layout = "diff3_horizontal",
      disable_diagnostics = true,   -- Temporarily disable diagnostics for diff buffers while in the view.
      winbar_info = true,           -- See |diffview-config-view.x.winbar_info|
    },
    file_history = {
      -- Config for changed files in file history views.
      layout = "diff2_horizontal",
      disable_diagnostics = false,  -- Temporarily disable diagnostics for diff buffers while in the view.
      winbar_info = false,          -- See |diffview-config-view.x.winbar_info|
    },
  },
  file_panel = {
    listing_style = "tree",             -- One of 'list' or 'tree'
    tree_options = {                    -- Only applies when listing_style is 'tree'
      flatten_dirs = true,              -- Flatten dirs that only contain one single dir
      folder_statuses = "only_folded",  -- One of 'never', 'only_folded' or 'always'.
    },
    win_config = {                      -- See |diffview-config-win_config|
      position = "left",
      width = 35,
      win_opts = {},
    },
  },
  file_history_panel = {
    log_options = {   -- See |diffview-config-log_options|
      git = {
        single_file = {
          diff_merges = "combined",
        },
        multi_file = {
          diff_merges = "first-parent",
        },
      },
      hg = {
        single_file = {},
        multi_file = {},
      },
    },
    win_config = {    -- See |diffview-config-win_config|
      position = "bottom",
      height = 16,
      win_opts = {},
    },
  },
  commit_log_panel = {
    win_config = {},  -- See |diffview-config-win_config|
  },
  default_args = {    -- Default args prepended to the arg-list for the listed commands
    DiffviewOpen = {},
    DiffviewFileHistory = {},
  },
  hooks = {},         -- See |diffview-config-hooks|
  keymaps = {
    disable_defaults = false, -- Disable the default keymaps
    view = {
      -- The `view` bindings are active in the diff buffers, only when the current
      -- tabpage is a Diffview.
      { "n", "<tab>",       actions.select_next_entry,              { desc = "Open the diff for the next file" } },
      { "n", "<s-tab>",     actions.select_prev_entry,              { desc = "Open the diff for the previous file" } },
      { "n", "[F",          actions.select_first_entry,             { desc = "Open the diff for the first file" } },
      { "n", "]F",          actions.select_last_entry,              { desc = "Open the diff for the last file" } },
      { "n", "gf",          actions.goto_file_edit,                 { desc = "Open the file in the previous tabpage" } },
      { "n", "<C-w><C-f>",  actions.goto_file_split,                { desc = "Open the file in a new split" } },
      { "n", "<C-w>gf",     actions.goto_file_tab,                  { desc = "Open the file in a new tabpage" } },
      { "n", "<leader>e",   actions.focus_files,                    { desc = "Bring focus to the file panel" } },
      { "n", "<leader>b",   actions.toggle_files,                   { desc = "Toggle the file panel." } },
      { "n", "g<C-x>",      actions.cycle_layout,                   { desc = "Cycle through available layouts." } },
      { "n", "[x",          actions.prev_conflict,                  { desc = "In the merge-tool: jump to the previous conflict" } },
      { "n", "]x",          actions.next_conflict,                  { desc = "In the merge-tool: jump to the next conflict" } },
      { "n", "<leader>co",  actions.conflict_choose("ours"),        { desc = "Choose the OURS version of a conflict" } },
      { "n", "<leader>ct",  actions.conflict_choose("theirs"),      { desc = "Choose the THEIRS version of a conflict" } },
      { "n", "<leader>cb",  actions.conflict_choose("base"),        { desc = "Choose the BASE version of a conflict" } },
      { "n", "<leader>ca",  actions.conflict_choose("all"),         { desc = "Choose all the versions of a conflict" } },
      { "n", "dx",          actions.conflict_choose("none"),        { desc = "Delete the conflict region" } },
      { "n", "<leader>cO",  actions.conflict_choose_all("ours"),    { desc = "Choose the OURS version of a conflict for the whole file" } },
      { "n", "<leader>cT",  actions.conflict_choose_all("theirs"),  { desc = "Choose the THEIRS version of a conflict for the whole file" } },
      { "n", "<leader>cB",  actions.conflict_choose_all("base"),    { desc = "Choose the BASE version of a conflict for the whole file" } },
      { "n", "<leader>cA",  actions.conflict_choose_all("all"),     { desc = "Choose all the versions of a conflict for the whole file" } },
      { "n", "dX",          actions.conflict_choose_all("none"),    { desc = "Delete the conflict region for the whole file" } },
    },
    diff1 = {
      -- Mappings in single window diff layouts
      { "n", "g?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
    },
    diff2 = {
      -- Mappings in 2-way diff layouts
      { "n", "g?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
    },
    diff3 = {
      -- Mappings in 3-way diff layouts
      { { "n", "x" }, "2do",  actions.diffget("ours"),            { desc = "Obtain the diff hunk from the OURS version of the file" } },
      { { "n", "x" }, "3do",  actions.diffget("theirs"),          { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
      { "n",          "g?",   actions.help({ "view", "diff3" }),  { desc = "Open the help panel" } },
    },
    diff4 = {
      -- Mappings in 4-way diff layouts
      { { "n", "x" }, "1do",  actions.diffget("base"),            { desc = "Obtain the diff hunk from the BASE version of the file" } },
      { { "n", "x" }, "2do",  actions.diffget("ours"),            { desc = "Obtain the diff hunk from the OURS version of the file" } },
      { { "n", "x" }, "3do",  actions.diffget("theirs"),          { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
      { "n",          "g?",   actions.help({ "view", "diff4" }),  { desc = "Open the help panel" } },
    },
    file_panel = {
      { "n", "j",              actions.next_entry,                     { desc = "Bring the cursor to the next file entry" } },
      { "n", "<down>",         actions.next_entry,                     { desc = "Bring the cursor to the next file entry" } },
      { "n", "k",              actions.prev_entry,                     { desc = "Bring the cursor to the previous file entry" } },
      { "n", "<up>",           actions.prev_entry,                     { desc = "Bring the cursor to the previous file entry" } },
      { "n", "<cr>",           actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
      { "n", "o",              actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
      { "n", "l",              actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
      { "n", "<2-LeftMouse>",  actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
      { "n", "-",              actions.toggle_stage_entry,             { desc = "Stage / unstage the selected entry" } },
      { "n", "s",              actions.toggle_stage_entry,             { desc = "Stage / unstage the selected entry" } },
      { "n", "S",              actions.stage_all,                      { desc = "Stage all entries" } },
      { "n", "U",              actions.unstage_all,                    { desc = "Unstage all entries" } },
      { "n", "X",              actions.restore_entry,                  { desc = "Restore entry to the state on the left side" } },
      { "n", "L",              actions.open_commit_log,                { desc = "Open the commit log panel" } },
      { "n", "zo",             actions.open_fold,                      { desc = "Expand fold" } },
      { "n", "h",              actions.close_fold,                     { desc = "Collapse fold" } },
      { "n", "zc",             actions.close_fold,                     { desc = "Collapse fold" } },
      { "n", "za",             actions.toggle_fold,                    { desc = "Toggle fold" } },
      { "n", "zR",             actions.open_all_folds,                 { desc = "Expand all folds" } },
      { "n", "zM",             actions.close_all_folds,                { desc = "Collapse all folds" } },
      { "n", "<c-b>",          actions.scroll_view(-0.25),             { desc = "Scroll the view up" } },
      { "n", "<c-f>",          actions.scroll_view(0.25),              { desc = "Scroll the view down" } },
      { "n", "<tab>",          actions.select_next_entry,              { desc = "Open the diff for the next file" } },
      { "n", "<s-tab>",        actions.select_prev_entry,              { desc = "Open the diff for the previous file" } },
      { "n", "[F",             actions.select_first_entry,             { desc = "Open the diff for the first file" } },
      { "n", "]F",             actions.select_last_entry,              { desc = "Open the diff for the last file" } },
      { "n", "gf",             actions.goto_file_edit,                 { desc = "Open the file in the previous tabpage" } },
      { "n", "<C-w><C-f>",     actions.goto_file_split,                { desc = "Open the file in a new split" } },
      { "n", "<C-w>gf",        actions.goto_file_tab,                  { desc = "Open the file in a new tabpage" } },
      { "n", "i",              actions.listing_style,                  { desc = "Toggle between 'list' and 'tree' views" } },
      { "n", "f",              actions.toggle_flatten_dirs,            { desc = "Flatten empty subdirectories in tree listing style" } },
      { "n", "R",              actions.refresh_files,                  { desc = "Update stats and entries in the file list" } },
      { "n", "<leader>e",      actions.focus_files,                    { desc = "Bring focus to the file panel" } },
      { "n", "<leader>b",      actions.toggle_files,                   { desc = "Toggle the file panel" } },
      { "n", "g<C-x>",         actions.cycle_layout,                   { desc = "Cycle available layouts" } },
      { "n", "[x",             actions.prev_conflict,                  { desc = "Go to the previous conflict" } },
      { "n", "]x",             actions.next_conflict,                  { desc = "Go to the next conflict" } },
      { "n", "g?",             actions.help("file_panel"),             { desc = "Open the help panel" } },
      { "n", "<leader>cO",     actions.conflict_choose_all("ours"),    { desc = "Choose the OURS version of a conflict for the whole file" } },
      { "n", "<leader>cT",     actions.conflict_choose_all("theirs"),  { desc = "Choose the THEIRS version of a conflict for the whole file" } },
      { "n", "<leader>cB",     actions.conflict_choose_all("base"),    { desc = "Choose the BASE version of a conflict for the whole file" } },
      { "n", "<leader>cA",     actions.conflict_choose_all("all"),     { desc = "Choose all the versions of a conflict for the whole file" } },
      { "n", "dX",             actions.conflict_choose_all("none"),    { desc = "Delete the conflict region for the whole file" } },
    },
    file_history_panel = {
      { "n", "g!",            actions.options,                     { desc = "Open the option panel" } },
      { "n", "<C-A-d>",       actions.open_in_diffview,            { desc = "Open the entry under the cursor in a diffview" } },
      { "n", "y",             actions.copy_hash,                   { desc = "Copy the commit hash of the entry under the cursor" } },
      { "n", "L",             actions.open_commit_log,             { desc = "Show commit details" } },
      { "n", "X",             actions.restore_entry,               { desc = "Restore file to the state from the selected entry" } },
      { "n", "zo",            actions.open_fold,                   { desc = "Expand fold" } },
      { "n", "zc",            actions.close_fold,                  { desc = "Collapse fold" } },
      { "n", "h",             actions.close_fold,                  { desc = "Collapse fold" } },
      { "n", "za",            actions.toggle_fold,                 { desc = "Toggle fold" } },
      { "n", "zR",            actions.open_all_folds,              { desc = "Expand all folds" } },
      { "n", "zM",            actions.close_all_folds,             { desc = "Collapse all folds" } },
      { "n", "j",             actions.next_entry,                  { desc = "Bring the cursor to the next file entry" } },
      { "n", "<down>",        actions.next_entry,                  { desc = "Bring the cursor to the next file entry" } },
      { "n", "k",             actions.prev_entry,                  { desc = "Bring the cursor to the previous file entry" } },
      { "n", "<up>",          actions.prev_entry,                  { desc = "Bring the cursor to the previous file entry" } },
      { "n", "<cr>",          actions.select_entry,                { desc = "Open the diff for the selected entry" } },
      { "n", "o",             actions.select_entry,                { desc = "Open the diff for the selected entry" } },
      { "n", "l",             actions.select_entry,                { desc = "Open the diff for the selected entry" } },
      { "n", "<2-LeftMouse>", actions.select_entry,                { desc = "Open the diff for the selected entry" } },
      { "n", "<c-b>",         actions.scroll_view(-0.25),          { desc = "Scroll the view up" } },
      { "n", "<c-f>",         actions.scroll_view(0.25),           { desc = "Scroll the view down" } },
      { "n", "<tab>",         actions.select_next_entry,           { desc = "Open the diff for the next file" } },
      { "n", "<s-tab>",       actions.select_prev_entry,           { desc = "Open the diff for the previous file" } },
      { "n", "[F",            actions.select_first_entry,          { desc = "Open the diff for the first file" } },
      { "n", "]F",            actions.select_last_entry,           { desc = "Open the diff for the last file" } },
      { "n", "gf",            actions.goto_file_edit,              { desc = "Open the file in the previous tabpage" } },
      { "n", "<C-w><C-f>",    actions.goto_file_split,             { desc = "Open the file in a new split" } },
      { "n", "<C-w>gf",       actions.goto_file_tab,               { desc = "Open the file in a new tabpage" } },
      { "n", "<leader>e",     actions.focus_files,                 { desc = "Bring focus to the file panel" } },
      { "n", "<leader>b",     actions.toggle_files,                { desc = "Toggle the file panel" } },
      { "n", "g<C-x>",        actions.cycle_layout,                { desc = "Cycle available layouts" } },
      { "n", "g?",            actions.help("file_history_panel"),  { desc = "Open the help panel" } },
    },
    option_panel = {
      { "n", "<tab>", actions.select_entry,          { desc = "Change the current option" } },
      { "n", "q",     actions.close,                 { desc = "Close the panel" } },
      { "n", "g?",    actions.help("option_panel"),  { desc = "Open the help panel" } },
    },
    help_panel = {
      { "n", "q",     actions.close,  { desc = "Close help menu" } },
      { "n", "<esc>", actions.close,  { desc = "Close help menu" } },
    },
  },
})


-- nvim-tree
require("nvim-tree").setup()
 
local KEYMAP_SETTINGS = {}
do
	local set = vim.keymap.set

	KEYMAP_SETTINGS.mini_files = function(mini_files)
		mini_files.config.mappings.close = "<esc>"
		set("n", "<leader><space>", mini_files.open)
		set("n", "<leader>s", function() -- set working dir to current buffer
			local state = mini_files.get_explorer_state()
			local dir = state and state.branch[state.depth_focus] or "%:h"
			vim.cmd("cd " .. dir)
			vim.cmd("pwd")
		end)
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





-- Call Line Number color change function
LineNumberColors()
