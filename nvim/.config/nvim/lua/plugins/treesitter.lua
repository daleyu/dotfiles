return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		branch = "main",
		build = ':TSUpdate',
		opts = {
			indent = { enable = true },
		},
		config = function(_, opts)
			require('nvim-treesitter').install { "cpp", "typescript", "tsx", "python", "luau", "javascript", "rust", "json", "lua", "go", "html", "ruby", "javascript", "zig", "java", "proto" }

			vim.api.nvim_create_autocmd('FileType', {
				pattern = { "java", "tsx", "rb", "proto", "json", "go" },
				callback = function() vim.treesitter.start() end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		init = function()
			vim.g.no_plugin_maps = true
		end,
		config = function()
			require("nvim-treesitter-textobjects").setup {
				select = {
					lookahead = true,
					selection_modes = {
						['@parameter.outer'] = 'v',
						['@function.outer'] = 'V',
					},
					include_surrounding_whitespace = false,
				},
				move = {
					set_jumps = true
				},
			}

			-- node increment
			vim.keymap.set({ "x", "o" }, "v", function()
				if vim.treesitter.get_parser(nil, nil, { error = false }) then
					require "vim.treesitter._select".select_parent(vim.v.count1)
				else
					vim.lsp.buf.selection_range(vim.v.count1)
				end
			end, { desc = "Select parent (outer) node" })

			vim.keymap.set({ "x", "o" }, "V", function()
				if vim.treesitter.get_parser(nil, nil, { error = false }) then
					require "vim.treesitter._select".select_child(vim.v.count1)
				else
					vim.lsp.buf.selection_range(-vim.v.count1)
				end
			end, { desc = "Select child (inner) node" })

			-- textobject selections
			vim.keymap.set({ "x", "o" }, "af", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "if", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ac", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ic", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "as", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
			end)

			-- move keymaps
			vim.keymap.set({ "n", "x", "o" }, "]m", function()
				require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]]", function()
				require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]o", function()
				require("nvim-treesitter-textobjects.move").goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]s", function()
				require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]z", function()
				require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]Z", function()
				require("nvim-treesitter-textobjects.move").goto_next_end("@fold", "folds")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[Z", function()
				require("nvim-treesitter-textobjects.move").goto_previous_end("@fold", "folds")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[z", function()
				require("nvim-treesitter-textobjects.move").goto_previous_start("@fold", "folds")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[s", function()
				require("nvim-treesitter-textobjects.move").goto_previous_start("@local.scope", "locals")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]M", function()
				require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "][", function()
				require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[m", function()
				require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[[", function()
				require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[M", function()
				require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[]", function()
				require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]d", function()
				require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[d", function()
				require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")
			end)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require 'treesitter-context'.setup {
				enable = true,
				multiwindow = false,
				max_lines = 2,
				min_window_height = 0,
				line_numbers = true,
				multiline_threshold = 1,
				trim_scope = 'inner',
				mode = 'cursor',
				separator = nil,
				zindex = 40,
				on_attach = nil,
			}
		end,
	},
}
