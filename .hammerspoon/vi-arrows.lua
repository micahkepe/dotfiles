--- Vi-style arrow remaps

--- Press function to pass to remap
---@param mods table | string | nil A table or a string containing (as elements,
--- or as substrings with any separator) the keyboard modifiers required, which
--- should be zero or more of the following:
--- * "cmd", "command" or "⌘"
--- * "ctrl", "control" or "⌃"
--- * "alt", "option" or "⌥"
--- * "shift" or "⇧"
---@param key any The key to press
---@param delay number | nil The delay in microseconds to wait before pressing
---the key, defaults to 100 microseconds
local function pressFn(mods, key, delay)
	if key == nil then
		key = mods
		mods = {}
	end
	delay = delay or 100
	return function()
		hs.eventtap.keyStroke(mods, key, delay)
	end
end

--- Utility function to remap a key with repeat support
---@param mods table | string | nil Modifiers keys for the source binding
---@param key any The key to remap
---@param pressedfn any The function to call when the key is pressed
local function remap(mods, key, pressedfn)
	hs.hotkey.bind(mods, key, pressedfn, nil, pressedfn)
end

remap({ "ctrl", "alt" }, "h", pressFn("left"))
remap({ "ctrl", "alt" }, "j", pressFn("down"))
remap({ "ctrl", "alt" }, "k", pressFn("up"))
remap({ "ctrl", "alt" }, "l", pressFn("right"))
