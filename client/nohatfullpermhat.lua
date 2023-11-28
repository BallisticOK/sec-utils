-- Function to prevent the player from losing accessories on damage
Citizen.CreateThread(function()
    local lastped = 0

    while true do
        local ped = PlayerPedId()

        if ped ~= lastped then
            lastped = ped
            SetPedCanLosePropsOnDamage(ped, false, 0)
        end

        Wait(100)
    end
end)

-- Function to manage helmet when in a vehicle
Citizen.CreateThread(function()
    local inVehicle = false
    local helmet = -1
    local helmetTexture = -1
    local checkInterval = 1000

    while true do
        local ped = PlayerPedId()

        if GetVehiclePedIsUsing(ped) ~= 0 then
            -- Check if the player is not performing a task and the helmet is not already equipped
            if not GetIsTaskActive(ped, 160) and not inVehicle then
                inVehicle = true

                if helmet ~= -1 then
                    ClearPedProp(ped, 0)
                    SetPedPropIndex(ped, 0, helmet, helmetTexture, true)
                end
            end
        else
            if inVehicle then
                inVehicle = false
            end

            helmet = GetPedPropIndex(ped, 0)
            helmetTexture = GetPedPropTextureIndex(ped, 0)
        end

        Citizen.Wait(checkInterval)
    end
end)
