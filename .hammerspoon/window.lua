-- This file is collection of window management functions and keybinds
-- for tiling and moving windows around the screen, as well as switching and
-- focusing application windows.

-- Window grid layout
local grid = {
	{ x = 0, y = 0, w = 0.5, h = 1 }, -- Left half
	{ x = 0.5, y = 0, w = 0.5, h = 1 }, -- Right half
	{ x = 0, y = 0, w = 1, h = 0.5 }, -- Top half
	{ x = 0, y = 0.5, w = 1, h = 0.5 }, -- Bottom half
}

-- Function to move the current window to a specific screen grid location
local function moveWindowToGrid(location)
	local win = hs.window.focusedWindow()
	if not win then
		return
	end
	local screen = win:screen()
	local frame = screen:frame()

	local newFrame = {
		x = frame.x + (grid[location].x * frame.w),
		y = frame.y + (grid[location].y * frame.h),
		w = grid[location].w * frame.w,
		h = grid[location].h * frame.h,
	}

	win:setFrame(newFrame)
end

-- Window movement keybinds
-- NOTE: "alt" is the Option key on mac
hs.hotkey.bind({ "cmd", "alt" }, "left", function()
	moveWindowToGrid(1)
end) -- Move window to left half
hs.hotkey.bind({ "cmd", "alt" }, "right", function()
	moveWindowToGrid(2)
end) -- Move window to right half
hs.hotkey.bind({ "cmd", "alt" }, "up", function()
	moveWindowToGrid(3)
end) -- Move window to top half
hs.hotkey.bind({ "cmd", "alt" }, "down", function()
	moveWindowToGrid(4)
end) -- Move window to bottom half

-- quarter of screen
hs.hotkey.bind({ "shift", "alt", "cmd" }, "left", function()
	hs.window.focusedWindow():moveToUnit({ 0, 0, 0.5, 0.5 })
end)
hs.hotkey.bind({ "shift", "alt", "cmd" }, "right", function()
	hs.window.focusedWindow():moveToUnit({ 0.5, 0.5, 0.5, 0.5 })
end)
hs.hotkey.bind({ "shift", "alt", "cmd" }, "up", function()
	hs.window.focusedWindow():moveToUnit({ 0.5, 0, 0.5, 0.5 })
end)
hs.hotkey.bind({ "shift", "alt", "cmd" }, "down", function()
	hs.window.focusedWindow():moveToUnit({ 0, 0.5, 0.5, 0.5 })
end)

-- full screen
hs.hotkey.bind({ "alt", "cmd" }, "f", function()
	hs.window.focusedWindow():moveToUnit({ 0, 0, 1, 1 })
end)

-- vim-like bindings (also for split keyboard)
-- NOTE: "alt" is the Option key on mac
hs.hotkey.bind({ "cmd", "alt" }, "h", function()
	moveWindowToGrid(1)
end) -- Move window to left half
hs.hotkey.bind({ "cmd", "alt" }, "l", function()
	moveWindowToGrid(2)
end) -- Move window to right half
hs.hotkey.bind({ "cmd", "alt" }, "k", function()
	moveWindowToGrid(3)
end) -- Move window to top half
hs.hotkey.bind({ "cmd", "alt" }, "j", function()
	moveWindowToGrid(4)
end) -- Move window to bottom half

-- quarter of screen
hs.hotkey.bind({ "shift", "alt", "cmd" }, "h", function()
	hs.window.focusedWindow():moveToUnit({ 0, 0, 0.5, 0.5 })
end)
hs.hotkey.bind({ "shift", "alt", "cmd" }, "l", function()
	hs.window.focusedWindow():moveToUnit({ 0.5, 0.5, 0.5, 0.5 })
end)
hs.hotkey.bind({ "shift", "alt", "cmd" }, "k", function()
	hs.window.focusedWindow():moveToUnit({ 0.5, 0, 0.5, 0.5 })
end)
hs.hotkey.bind({ "shift", "alt", "cmd" }, "j", function()
	hs.window.focusedWindow():moveToUnit({ 0, 0.5, 0.5, 0.5 })
end)

-- Window switching
-- better than cmd + tab:
--  * preview of the window
--  * can switch between minimized windows
-- adapted from: https://www.hammerspoon.org/docs/hs.window.switcher.html
-- set up windowfilter
-- include minimized/hidden windows, current Space only
switcher_space = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter({}))
-- Other example options:
-- -- default windowfilter: only visible windows, all Spaces
-- switcher = hs.window.switcher.new()
--
-- specialized switcher for your dozens of browser windows
-- switcher_browsers = hs.window.switcher.new({ "Brave", "Safari", "Google Chrome" })

-- Adjust default window switcher UI
hs.window.switcher.ui.showTitles = false -- no titles on preview panes

-- bind to hotkeys; WARNING: at least one modifier key is required!
hs.hotkey.bind("alt", "tab", function()
	switcher_space:next()
end)
hs.hotkey.bind("alt-shift", "tab", function()
	switcher_space:previous()
end)

-- Application focus or launch
-- CMD-ALT + <shortcut> to open application, or focus it if it already is open
local appShortcuts = {
	g = "Ghostty",
	b = "Brave Browser",
	z = "zoom.us",
	p = "sioyek", -- for PDF
}

for shortcut, app in pairs(appShortcuts) do
	hs.hotkey.bind({ "cmd", "alt" }, shortcut, function()
		hs.application.launchOrFocus(app)
	end)
end
