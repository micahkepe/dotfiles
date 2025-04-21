-- Show macOS native color picker (color wheel mode) and print selected color
hs.dialog.color.showsAlpha(true) -- enable opacity slider
hs.dialog.color.mode("wheel") -- set to color wheel mode
hs.dialog.color.continuous(true) -- emit callback on drag

-- Set up a callback to handle color selection
hs.dialog.color.callback(function(colorTable, panelClosed)
	if colorTable then
		local r = string.format("%.3f", colorTable.red or 0)
		local g = string.format("%.3f", colorTable.green or 0)
		local b = string.format("%.3f", colorTable.blue or 0)
		local a = string.format("%.3f", colorTable.alpha or 1)
		local hex = string.format(
			"#%02x%02x%02x",
			math.floor(colorTable.red * 255),
			math.floor(colorTable.green * 255),
			math.floor(colorTable.blue * 255)
		)

		-- copy to clipboard
		hs.pasteboard.setContents(hex)

		if panelClosed then
			print("[Color Picker Closed]")
		end

		print(string.format("[Color Selected] RGB: (%.3f, %.3f, %.3f) | Alpha: %.3f | Hex: %s", r, g, b, a, hex))
	end
end)

hs.hotkey.bind({ "alt", "shift" }, "c", function()
	hs.dialog.color.show()
end)
