local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")
local spaces = {}

-- Create workspace spaces
for i = 1, 8, 1 do
	local space = sbar.add("space", "space." .. i, {
		space = i,
		icon = {
			font = { family = settings.font.numbers },
			string = i,
			padding_left = 15,
			padding_right = 8,
			color = colors.white,
			highlight_color = colors.green,
		},
		label = {
			padding_right = 20,
			color = colors.grey,
			highlight_color = colors.white,
			font = "sketchybar-app-font:Regular:16.0",
			y_offset = -1,
		},
		padding_right = 1,
		padding_left = 1,
		background = {
			color = colors.bg1,
			border_width = 1,
			height = 26,
		},
		popup = { background = { border_width = 5, border_color = colors.black } },
	})
	spaces[i] = space

	-- Single item bracket for space items to achieve double border on highlight
	local space_bracket = sbar.add("bracket", { space.name }, {
		background = {
			color = colors.bg1,
			height = 28,
		},
	})

	-- Padding space
	sbar.add("space", "space.padding." .. i, {
		space = i,
		script = "",
		width = settings.group_paddings,
	})

	-- Space popup for additional info
	local space_popup = sbar.add("item", {
		position = "popup." .. space.name,
		padding_left = 5,
		padding_right = 0,
		background = {
			drawing = true,
			image = {
				corner_radius = 9,
				scale = 0.2,
			},
		},
	})

	-- Listen for AeroSpace workspace changes
	space:subscribe("aerospace_workspace_change", function(env)
		local focused_workspace = tonumber(env.FOCUSED_WORKSPACE)
		local selected = focused_workspace == i
		local color = selected and colors.green or colors.bg2

		space:set({
			icon = { highlight = selected },
			label = { highlight = selected },
			background = { border_color = color },
		})

		space_bracket:set({
			background = { border_color = color },
		})
	end)

	-- Handle standard space changes as well
	space:subscribe("space_change", function(env)
		local selected = env.SELECTED == "true"
		local color = selected and colors.green or colors.bg2

		space:set({
			icon = { highlight = selected },
			label = { highlight = selected },
			background = { border_color = color },
		})

		space_bracket:set({
			background = { border_color = color },
		})
	end)

	-- Workspace switching on click
	space:subscribe("mouse.clicked", function(env)
		-- Use AeroSpace's keyboard shortcuts to switch workspaces
		sbar.exec("aerospace workspace " .. i)
	end)

	space:subscribe("mouse.exited", function(_)
		space:set({ popup = { drawing = false } })
	end)
end

-- Add space window observer to track app icons
local space_window_observer = sbar.add("item", {
	drawing = false,
	updates = true,
})

-- Create spaces indicator item
local spaces_indicator = sbar.add("item", {
	padding_left = -3,
	padding_right = 0,
	icon = {
		padding_left = 8,
		padding_right = 9,
		color = colors.green,
		string = icons.switch.on,
	},
	label = {
		width = 0,
		padding_left = 0,
		padding_right = 8,
		string = "Spaces",
		color = colors.bg1,
	},
	background = {
		color = colors.with_alpha(colors.green, 0.0),
		border_color = colors.with_alpha(colors.green, 0.0),
	},
})

-- Update workspace indicators when windows change
space_window_observer:subscribe("space_windows_change", function(env)
	local space_num = env.INFO.space
	local icon_line = ""
	local no_app = true

	for app, count in pairs(env.INFO.apps) do
		no_app = false
		local lookup = app_icons[app]
		local icon = ((lookup == nil) and app_icons["default"] or lookup)
		icon_line = icon_line .. " " .. icon
	end

	if no_app then
		icon_line = " —"
	end

	sbar.animate("tanh", 10, function()
		spaces[space_num]:set({ label = icon_line })
	end)
end)

-- Listen for custom aerospace workspace changes
space_window_observer:subscribe("aerospace_workspace_change", function(env)
	-- This will be triggered by our update_workspace_icons.sh script
	local focused_workspace = tonumber(env.FOCUSED_WORKSPACE) or 1
	local prev_workspace = tonumber(env.PREV_WORKSPACE) or 1

	-- Run our custom update script (redundant but keeps it in sync)
	sbar.exec("~/.config/sketchybar/plugins/update_workspace_icons.sh")
end)

-- Handle spaces indicator UI
spaces_indicator:subscribe("swap_menus_and_spaces", function(env)
	local currently_on = spaces_indicator:query().icon.value == icons.switch.on
	spaces_indicator:set({
		icon = currently_on and icons.switch.off or icons.switch.on,
	})
end)

spaces_indicator:subscribe("mouse.entered", function(env)
	sbar.animate("tanh", 30, function()
		spaces_indicator:set({
			background = {
				color = { alpha = 1.0 },
				border_color = { alpha = 1.0 },
			},
			icon = { color = colors.bg1 },
			label = { width = "dynamic" },
		})
	end)
end)

spaces_indicator:subscribe("mouse.exited", function(env)
	sbar.animate("tanh", 30, function()
		spaces_indicator:set({
			background = {
				color = { alpha = 0.0 },
				border_color = { alpha = 0.0 },
			},
			icon = { color = colors.grey },
			label = { width = 0 },
		})
	end)
end)

spaces_indicator:subscribe("mouse.clicked", function(env)
	sbar.trigger("swap_menus_and_spaces")
end)

