-- Initialize the monitor
local monitor = peripheral.wrap("top")

-- Set up the monitor
monitor.setTextScale(2)  -- Adjust text size
monitor.setBackgroundColor(colors.black)
monitor.setTextColor(colors.red)
monitor.clear()

monitor.setCursorPos(1, 1)
monitor.write("UNDER DEVELOPMENT")
