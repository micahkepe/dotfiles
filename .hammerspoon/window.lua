-- Define the desired screen grid layout
local grid = {
    {x = 0, y = 0, w = 0.5, h = 1},  -- Left half
    {x = 0.5, y = 0, w = 0.5, h = 1}, -- Right half
    {x = 0, y = 0, w = 1, h = 0.5},   -- Top half
    {x = 0, y = 0.5, w = 1, h = 0.5},  -- Bottom half
}

-- Function to move the current window to a specific screen grid location
local function moveWindowToGrid(location)
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    local frame = screen:frame()

    local newFrame = {
        x = frame.x + (grid[location].x * frame.w),
        y = frame.y + (grid[location].y * frame.h),
        w = grid[location].w * frame.w,
        h = grid[location].h * frame.h
    }

    win:setFrame(newFrame)
end

-- Bind Option+Command+Arrow keys to move windows
hs.hotkey.bind({"cmd", "alt"}, "left", function() moveWindowToGrid(1) end)   -- Move window to left half
hs.hotkey.bind({"cmd", "alt"}, "right", function() moveWindowToGrid(2) end)  -- Move window to right half
hs.hotkey.bind({"cmd", "alt"}, "up", function() moveWindowToGrid(3) end)     -- Move window to top half
hs.hotkey.bind({"cmd", "alt"}, "down", function() moveWindowToGrid(4) end)   -- Move window to bottom half

-- quarter of screen
hs.hotkey.bind({'shift', 'alt', 'cmd'}, 'left', function() hs.window.focusedWindow():moveToUnit({0, 0, 0.5, 0.5}) end)
hs.hotkey.bind({'shift', 'alt', 'cmd'}, 'right', function() hs.window.focusedWindow():moveToUnit({0.5, 0.5, 0.5, 0.5}) end)
hs.hotkey.bind({'shift', 'alt', 'cmd'}, 'up', function() hs.window.focusedWindow():moveToUnit({0.5, 0, 0.5, 0.5}) end)
hs.hotkey.bind({'shift', 'alt', 'cmd'}, 'down', function() hs.window.focusedWindow():moveToUnit({0, 0.5, 0.5, 0.5}) end)

-- full screen
hs.hotkey.bind({'alt', 'cmd'}, 'f', function() hs.window.focusedWindow():moveToUnit({0, 0, 1, 1}) end)
