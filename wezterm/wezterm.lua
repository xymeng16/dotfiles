local wezterm = require("wezterm")
local act = wezterm.action

-- functions
local function enable_wayland()
	local wayland = os.getenv("XDG_SESSION_TYPE")
	if wayland == "wayland" then
		return true
	end
	return false
end

local config = {
	front_end = "WebGpu",

	font_size = 12,
	font = wezterm.font("Agave Nerd Font", { weight = "Regular" }),

	color_scheme = "Catppuccin Mocha",

	keys = {
		-- Create a new tab in the same domain as the current pane
		{
			key = "t",
			mods = "ALT",
			action = act.SpawnTab("CurrentPaneDomain"),
		},
		-- Close current tab
		{
			key = "q",
			mods = "ALT",
			action = wezterm.action.CloseCurrentTab({ confirm = true }),
		},
		-- Scroll by pre-defined metrics
		{
			key = "UpArrow",
			mods = "SHIFT",
			action = act.ScrollByLine(-1),
		},
		{
			key = "DownArrow",
			mods = "SHIFT",
			action = act.ScrollByLine(1),
		},
		{
			key = "PageUp",
			mods = "SHIFT",
			action = act.ScrollByPage(-0.5),
		},
		{
			key = "PageDown",
			mods = "SHIFT",
			action = act.ScrollByPage(0.5),
		},
		{
			key = '"',
			mods = "ALT",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
	},

	-- enable_wayland = false,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	window_background_opacity = 0.9,
	text_background_opacity = 0.9,
}

for i = 1, 8 do
	-- F1-F8 to activate the corresponding tab
	table.insert(config.keys, {
		key = "F" .. tostring(i),
		action = act.ActivateTab(i - 1),
	})
end

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	-- config.default_domain = "WSL:arch"
	config.default_prog = { "pwsh.exe", "-NoLogo" }
end

return config
