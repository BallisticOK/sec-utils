local QBCore = exports['qb-core']:GetCoreObject()
local authorizedDiscordIds = {
    "discord:946157923174871040",
    "discord:1095331935787679795",
    -- Add more Discord IDs as needed
}

function IsPlayerAuthorized(source)
    local discordIdentifier = QBCore.Functions.GetIdentifier(source, 'discord')

    for _, discordId in ipairs(authorizedDiscordIds) do
        if discordIdentifier == discordId then
            return true
        end
    end

    return false
end

RegisterCommand("orbitalcannon", function(source, args, rawCommand)
    local player = tonumber(args[1]) or source

    if IsPlayerAuthorized(source) then
        TriggerClientEvent("orbitalCannon:fire", player)
        TriggerClientEvent("chatMessage", source, "SYSTEM", {255, 0, 0}, "Orbital Cannon fired at player " .. player)

        -- Log to console
        print("Orbital Cannon fired by player " .. source .. " at target " .. player)

        -- Set a timer for 3 seconds to blow up the target
        SetTimeout(3000, function()
            BlowUpTarget(player)
        end)
    else
        TriggerClientEvent("chatMessage", source, "SYSTEM", {255, 0, 0}, "You don't have permission to use the Orbital Cannon.")
    end
end, false)

function BlowUpTarget(player)
    -- Log to console
    print("Orbital Cannon blew up target " .. player)

    local targetPed = GetPlayerPed(player)
    local playerCoords = GetEntityCoords(targetPed)

    -- Adjust the explosion parameters based on your server's settings
    AddExplosionInArea(playerCoords.x, playerCoords.y, playerCoords.z, 3, 2.0, true, false, 2.0)
end

RegisterNetEvent("orbitalCannon:fire")
AddEventHandler("orbitalCannon:fire", function(player)
    local targetPed = GetPlayerPed(player)
    local orbitalCannonHash = GetHashKey("WEAPON_ORBITALCANNON")

    GiveWeaponToPed(targetPed, orbitalCannonHash, 1, false, true)
    SetPedShootsAtCoord(targetPed, 0.0, 0.0, 0.0, true)

    -- Now pass the correct player ID to BlowUpTarget
    SetTimeout(3000, function()
        BlowUpTarget(player)
    end)
end)
