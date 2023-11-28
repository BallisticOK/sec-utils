-- Define zones with named labels and a set of Vector3 coordinates.
local zones = {
    ["LegenParking"] = {
        vector3(200.05841064454, -805.7308959961, 0.0),
        vector3(229.74333190918, -724.52795410156, 0.0),
        vector3(275.59378051758, -739.05236816406, 0.0),
        vector3(258.3971862793, -786.82550048828, 0.0),
        vector3(252.8595123291, -784.58447265625, 0.0),
        vector3(239.35632324218, -820.29229736328, 0.0)
    },
    -- You can add more named zones with sets of Vector3 coordinates here as needed
}

-- Create a thread to continuously check for vehicles in the specified zones.
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50) -- Check every 50 milliseconds

        -- Get the player's ped (character) and current position.
        local playerPed = GetPlayerPed(-1)
        local pos = GetEntityCoords(playerPed)

        -- Loop through the defined zones and check if the player is within them.
        for zoneName, zoneVectors in pairs(zones) do
            for _, zoneVector in ipairs(zoneVectors) do
                -- Define the radius for zone detection.
                local areaRadius = 50.0 -- You can adjust this radius as needed.

                -- Check if the player is within the specified zone.
                if Vdist(pos.x, pos.y, pos.z, zoneVector.x, zoneVector.y, zoneVector.z) <= areaRadius then
                    -- If the player is in the zone, reduce parked vehicle density and remove vehicles.
                    SetParkedVehicleDensityMultiplierThisFrame(0.0)
                    RemoveVehiclesFromGeneratorsInArea(zoneVector.x - areaRadius, zoneVector.y - areaRadius, zoneVector.z - areaRadius, zoneVector.x + areaRadius, zoneVector.y + areaRadius, zoneVector.z + areaRadius)
                end
            end
        end
    end
end)
