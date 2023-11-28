local staparlando = false

RegisterNetEvent("rog:userTalking")
AddEventHandler("rog:userTalking", function(lastTalkingStatus)
    staparlando = lastTalkingStatus
end)

Citizen.CreateThread(function()
    local facialsDicts = {
        'facials@gen_male@variations@normal',
        'mp_facial'
    }
    
    for _, dict in ipairs(facialsDicts) do
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end
    end

    while true do
        Citizen.Wait(0)  -- Reduce the delay for more responsive facial animations
        local playerPed = PlayerId()
        
        if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) then
            if staparlando then
                SetFacialIdleAnimOverride(playerPed, "mood_talking_1", 0)
            else
                ClearFacialIdleAnimOverride(playerPed)
            end
        end
    end
end)
