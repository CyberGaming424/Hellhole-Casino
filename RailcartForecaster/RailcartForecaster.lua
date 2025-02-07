-- Import Basalt
local basalt = require("basalt")

-- Connect monitor


-- Initialize GUI
local mainFrame = basalt.createFrame()
local countdownLabel = mainFrame:addLabel()
    :setPosition(1, 1)
    :setText("Calibrating...")

-- Function to update display
local function updateCountdownLabel(timeLeft)
    countdownLabel:setText("Next cart in: " .. timeLeft .. " seconds")
    basalt.autoUpdate()
end

-- Assume 'side' is the side where the detector rail is connected
local side = "back" -- Change to the appropriate side

-- Function to wait for a redstone signal
local function waitForRedstoneSignal()
    while not rs.getInput(side) do
        os.sleep(0) -- Yield to prevent long loop issues
    end
end

-- Calibration function using rs.getInput
local function calibrate()
    countdownLabel:setText("Calibrating...")
    --basalt.autoUpdate()

    while true do
        print("Waiting for first cart...")
        waitForRedstoneSignal()

        local startTime = os.clock()
        print("First cart detected. Waiting for next cart...")
        sleep(5)
        waitForRedstoneSignal()
        local endTime = os.clock()

        return endTime - startTime
    end
end

local interval = calibrate()
print("Calibration complete. Interval: " .. interval .. " seconds")

-- Main loop
while true do
    for i = interval, 0, -1 do
        updateCountdownLabel(i)
        os.sleep(0) -- Yield to avoid long loop issues
    end

    -- Wait for cart detection to reset the countdown
    --waitForRedstoneSignal()
end
