-- Set the maximum speed in meters per second (100 km/h converted to m/s)
local maxSpeed = 111.76

-- Function to limit the speed of a vehicle
function limitVehicleSpeed()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local playerPed = GetPlayerPed(-1)
            if IsPedInAnyVehicle(playerPed, false) then
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                local currentSpeed = GetEntitySpeed(vehicle)
                if currentSpeed > maxSpeed then
                    SetEntityMaxSpeed(vehicle, maxSpeed)
                end
            end
        end
    end)
end

-- Start limiting the speed when the resource is started
Citizen.CreateThread(function()
    limitVehicleSpeed()
end)
