return {
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"f-person/auto-dark-mode.nvim",
		config = {
			update_interval = 1000,
			set_dark_mode = function()
				vim.api.nvim_set_option("background", "dark")
			end,
			set_light_mode = function()
				vim.api.nvim_set_option("background", "light")
			end,
		},
	},
	{ 'folke/tokyonight.nvim' },
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			local latte = require("catppuccin.palettes").get_palette "latte"
			local frappe = require("catppuccin.palettes").get_palette "frappe"
			local macchiato = require("catppuccin.palettes").get_palette "macchiato"
			local mocha = require("catppuccin.palettes").get_palette "mocha"
			require("catppuccin").setup({
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					snacks = true,
					grug_far = false,
					fzf = false,
					harpoon = false,
					treesitter = true,
					notify = true,
					neogit = true,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
				},
				flavour = "mocha",
				background = {
					light = "latte",
					dark = "mocha",
				},
				transparent_background = true,
			})
			vim.cmd.colorscheme("catppuccin")

			require('lualine').setup {
				options = {
					theme = "catppuccin-nvim"
				}
			}
		end,
	},
}
