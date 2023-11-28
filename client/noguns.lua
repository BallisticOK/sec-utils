-- client.lua

local disabledGuns = {
    ["patriot3"] = true,
    -- Add more vehicles as needed
}

function disableGuns(vehicle)
    local playerPed = GetPlayerPed(-1)
    
    if DoesEntityExist(vehicle) and GetEntityModel(vehicle) then
        local vehicleName = GetEntityModel(vehicle)

        if disabledGuns[GetDisplayNameFromVehicleModel(vehicleName)] then
            -- Disable the mounted guns
            local weaponIndex = 1  -- Change this index based on the weapon slot you want to disable

            if HasVehicleGotProjectileWeapon(vehicle, weaponIndex) then
                DisableVehicleWeapon(true, vehicle, weaponIndex, GetHashKey("VEHICLE_WEAPON_PLAYER_BUZZARD"))  -- Change the weapon hash based on your needs
            end
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        local playerPed = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        disableGuns(vehicle)
    end
end)
