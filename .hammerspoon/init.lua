-- For more info on configuration: https://www.hammerspoon.org/docs/index.html
hs.autoLaunch(true)
hs.automaticallyCheckForUpdates(true)

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
spoon.ClipboardTool.show_copied_alert = false
spoon.ClipboardTool.paste_on_select = true
spoon.ClipboardTool.deduplicate = true
spoon.ClipboardTool.frequency = 1.0 -- in seconds
spoon.ClipboardTool.show_in_menubar = false
spoon.ClipboardTool:bindHotkeys({
	show_clipboard = { { "cmd", "shift" }, "v" },
})
spoon.ClipboardTool:start()

----------------
-- CUSTOM
----------------
-- Tile management(ish) and quick window switching/focusing
require("window")
