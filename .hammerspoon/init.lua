-- For more info on configuration: https://www.hammerspoon.org/docs/index.html
hs.autoLaunch(true)
hs.automaticallyCheckForUpdates(true)
hs.ipc.cliInstall()

-- Reloading config keybind
hs.hotkey.bind({ "ctrl", "shift" }, "r", function()
	hs.reload()
end)

----------------
-- SPOONS
----------------
-- EmmyLua
-- https://www.hammerspoon.org/Spoons/EmmyLua.html
hs.loadSpoon("EmmyLua")

-- ClipboardTool
-- https://www.hammerspoon.org/Spoons/ClipboardTool.html
hs.loadSpoon("ClipboardTool")
spoon.ClipboardTool.max_size = false
spoon.ClipboardTool.hist_size = 250
spoon.ClipboardTool.show_copied_alert = false
spoon.ClipboardTool.paste_on_select = true
spoon.ClipboardTool.deduplicate = true
spoon.ClipboardTool.frequency = 1.0 -- in seconds
spoon.ClipboardTool.show_in_menubar = false
spoon.ClipboardTool:bindHotkeys({
	show_clipboard = { { "cmd", "shift" }, "v" },
})
hs.hotkey.bind({ "ctrl", "shift" }, "x", function()
	spoon.ClipboardTool:clearAll()
	hs.alert.show("Clipboard history cleared")
end)

spoon.ClipboardTool:start()

----------------
-- CUSTOM
----------------
-- Tile management(ish) and quick window switching/focusing
require("window")
