-- Xmas Weather
Citizen.CreateThread(function()
    while true do
        local currentTime = os.date("*t")
        if (currentTime.month == 12 and currentTime.day >= 1 and currentTime.day <= 25) then
            -- Enable Xmas weather
            local success = exports["qb-weathersync"]:setWeather("xmas")
        end
        Citizen.Wait(2000) -- Adjust this value to control the frequency of weather updates
    end
end)

-- Halloween Weather
Citizen.CreateThread(function()
    while true do
        local currentTime = os.date("*t")
        if (currentTime.month == 10 and currentTime.day >= 1 and currentTime.day <= 31) then
            -- Enable Halloween weather
            local success = exports["qb-weathersync"]:setWeather("halloween")
        end
        Citizen.Wait(2000) -- Adjust this value to control the frequency of weather updates
    end
end)
