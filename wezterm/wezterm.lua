local wezterm = require("wezterm")
local act = wezterm.action

-- functions
-- local function enable_wayland()
-- 	local wayland = os.getenv("XDG_SESSION_TYPE")
-- 	if wayland == "wayland" then
-- 		return true
-- 	end
-- 	return false
-- end

-- key-direction map
local directional_keys = {
	["h"] = "Left",
	["j"] = "Down",
	["k"] = "Up",
	["l"] = "Right",
}

local mods = {
	["c"] = "CTRL",
	["sh"] = "SHIFT",
	["a"] = "ALT",
	["s"] = "SUPER",
	["cs"] = "CTRL|SUPER",
	["csh"] = "CTRL|SHIFT",
	["csha"] = "CTRL|SHIFT|ALT",
}

local font_sizes = {
	["x86_64-pc-windows-msvc"] = 10,
	["aarch64-apple-darwin"] = 14,
	["x86_64-apple-darwin"] = 12,
	["x86_64-unknown-linux-gnu"] = 10,
}

local font_options = {
	weight = "Regular",
}

local fonts = {
	["agave"] = wezterm.font("Agave Nerd Font", font_options),
	["blex"] = wezterm.font("BlexMono Nerd Font", font_options),
}

local config = {
	front_end = "WebGpu",

	font = fonts["blex"],

	font_size = font_sizes[wezterm.target_triple],

	-- color_scheme = "Catppuccin Mocha",
	color_scheme = "carbonfox",

	keys = {
		-- Create a new tab in the same domain as the current pane
		{
			key = "Enter",
			mods = mods["c"],
			action = act.SpawnTab("CurrentPaneDomain"),
		},
		-- Close current tab
		{
			key = "q",
			mods = mods["csh"],
			action = wezterm.action.CloseCurrentTab({ confirm = true }),
		},
		-- Scroll by pre-defined metrics
		{
			key = "UpArrow",
			mods = mods["sh"],
			action = act.ScrollByLine(-1),
		},
		{
			key = "DownArrow",
			mods = mods["sh"],
			action = act.ScrollByLine(1),
		},
		{
			key = "PageUp",
			mods = mods["sh"],
			action = act.ScrollByPage(-0.5),
		},
		{
			key = "PageDown",
			mods = mods["sh"],
			action = act.ScrollByPage(0.5),
		},
		{
			key = '"',
			mods = mods["csh"],
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = ":",
			mods = mods["csh"],
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "Q",
			mods = mods["csh"],
			action = wezterm.action.CloseCurrentPane({ confirm = true }),
		},
		{
			key = "t",
			mods = mods["cs"],
			action = wezterm.action.SpawnCommandInNewTab({
				args = { "htop" },
			}),
		},
	},

	enable_wayland = true,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	-- window_background_opacity = 0.9,
	-- text_background_opacity = 0.9,
}

for i = 1, 8 do
	-- F1-F8 to activate the corresponding tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL",
		action = act.ActivateTab(i - 1),
	})
end

for key, direction in pairs(directional_keys) do
	table.insert(config.keys, {
		key = key,
		mods = mods["csh"],
		action = act.ActivatePaneDirection(direction),
	})
end

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "pwsh.exe", "-NoLogo" }
end

return config
