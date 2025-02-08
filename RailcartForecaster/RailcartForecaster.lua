function ProcessCart()
    monitor.write("THERE WAS A CART")

    -- Get current timestamp
    local CurrentTimeStamp = os.epoch("ingame") / 72000
    local TravelTime = CurrentTimeStamp - LastCartTravelTimestamp

    -- Ignore unrealistically short times
    if TravelTime < 1 then  -- Adjust this threshold as needed
        return
    end

    table.insert(CartTravelTimes, TravelTime)

    -- Add raw time to last cart time
    LastCartTravelTimestamp = CurrentTimeStamp

    -- If the array is bigger than 3 than remove the first element
    if #CartTravelTimes > 3 then
        table.remove(CartTravelTimes, 1)
    end

    -- calculate average
    local TotalTime = 0
    for i, v in ipairs(CartTravelTimes) do
        TotalTime = TotalTime + v
    end
    AverageTimeForCompleteCycle = TotalTime / #CartTravelTimes
end

function UpdateScreenInfo()

    local TimeSinceLastCart = (os.epoch("ingame") / 72000) - LastCartTravelTimestamp
    local TimeTillNextCart = math.max(AverageTimeForCompleteCycle - TimeSinceLastCart, 0)

    monitor.clear()

    monitor.setCursorPos(1, 1)
    monitor.write("UNDER DEVELOPMENT")

    monitor.setCursorPos(1,3)
    monitor.write(string.format("Time till next cart: %.2f", TimeTillNextCart))

    --monitor.setCursorPos(1,4)
    --monitor.write(string.format("DEBUG: TIME ARRAY [%i], AVERGAGE: %.2f", #CartTravelTimes, AverageTimeForCompleteCycle))
end


-- ###################
-- MAIN FUNCTION BELOW
-- ###################

-- Initialize the monitor
monitor = peripheral.wrap("top")
railtrackSensor = redstone.getInput("back")

-- Cart Vars
AverageTimeForCompleteCycle = 27
CartTravelTimes = {}
LastCartTravelTimestamp = os.epoch("ingame") / 72000

-- Set up the monitor
monitor.clear()
monitor.setTextScale(1)  -- Adjust text size
monitor.setBackgroundColor(colors.black)
monitor.setTextColor(colors.red)
monitor.clear()

while true do
    if redstone.getInput("back") then
        ProcessCart()
    end
    UpdateScreenInfo()
    sleep(0.05)
end
