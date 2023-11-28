local QBCore = exports['qb-core']:GetCoreObject()
-- Enable PVP
AddEventHandler("playerSpawned", function(spawn)
	local ped = PlayerPedId()
	SetCanAttackFriendly(ped, true, true)
	NetworkSetFriendlyFireOption(true)
end)

-- Anti Vehicle Rewards
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)
            id = PlayerId()
            DisablePlayerVehicleRewards(id)
        end
    end
)


---- Disable certain controls when not using firearms
--Citizen.CreateThread(function()
--    while true do
--        Citizen.Wait(0) -- Reduce the delay to improve responsiveness
--
--        local playerPed = PlayerId()
--        if not IsPedArmed(playerPed, 7) and GetSelectedPedWeapon(playerPed) ~= GetHashKey("WEAPON_UNARMED") then
--            DisableControlAction(0, 24, true) -- Disable Attack
--            DisableControlAction(0, 140, true) -- Disable Melee Attack 1
--            DisableControlAction(0, 141, true) -- Disable Melee Attack 2
--            DisableControlAction(0, 142, true) -- Disable Melee Attack 3
--        end
--    end
--end)


-- No Combat Walk

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            local ped = GetPlayerPed(-1)
            if not GetPedConfigFlag(ped, 78, 1) then
                SetPedUsingActionMode(GetPlayerPed(-1), false, -1, 0)
            end
        end
    end
)


-- FUCK OFF AMBIENT SOUNDS 

Citizen.CreateThread(
    function()
        StartAudioScene("DLC_MPHEIST_TRANSITION_TO_APT_FADE_IN_RADIO_SCENE")
        SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_01_STAGE", false)
        SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM", false)
        SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM", false)
        SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Disabled_Zones", false, true)
        SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Zones", true, true)
        --SetScenarioTypeEnabled("WORLD_VEHICLE_STREETRACE", false)
        --SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON_DIRT_BIKE", false)
        --SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON", false)
        --SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_NEXT_TO_CAR", false)
        --SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_CAR", false)
        --SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_BIKE", false)
        --SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_SMALL", false)
        --SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_BIG", false)
        --SetScenarioTypeEnabled("WORLD_VEHICLE_MECHANIC", false)
        --SetScenarioTypeEnabled("WORLD_VEHICLE_EMPTY", false)
        --SetScenarioTypeEnabled("WORLD_VEHICLE_BUSINESSMEN", false)
        --SetScenarioTypeEnabled("WORLD_VEHICLE_BIKE_OFF_ROAD_RACE", false)
        StartAudioScene("FBI_HEIST_H5_MUTE_AMBIENCE_SCENE")
        StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
        SetAudioFlag("PoliceScannerDisabled", true)
        SetAudioFlag("DisableFlightMusic", true)
        SetPlayerCanUseCover(PlayerId(), false)
        SetRandomEventFlag(false)
        SetDeepOceanScaler(0.0)
    end
)

-- Toggle IDs

local showPlayerBlips = false
local ignorePlayerNameDistance = false
local playerNamesDist = 15
local displayIDHeight = 1.2 --Height of ID above players head(starts at center body mass)
--Set Default Values for Colors
local red = 255
local green = 255
local blue = 255

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        World3dToScreen2d(x, y, z, 0) --Added Here
        DrawText(_x, _y)
    end
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if IsControlPressed(1, 11) then
                x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                DrawText3D(x1, y1, z1 + displayIDHeight, GetPlayerServerId(PlayerId()))
                for i = 0, 99 do
                    N_0x31698aa80e0223f8(i)
                end
                for id = 0, 255 do
                    if ((NetworkIsPlayerActive(id)) and GetPlayerPed(id) ~= GetPlayerPed(-1)) then
                        ped = GetPlayerPed(id)
                        blip = GetBlipFromEntity(ped)

                        x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
                        distance = math.floor(GetDistanceBetweenCoords(x1, y1, z1, x2, y2, z2, true))

                        if (ignorePlayerNameDistance) then
                            if NetworkIsPlayerTalking(id) then
                                red = 0
                                green = 0
                                blue = 255
                                DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
                            else
                                red = 255
                                green = 255
                                blue = 255
                                DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
                            end
                        end

                        if (distance < playerNamesDist) then
                            if not (ignorePlayerNameDistance) then
                                if NetworkIsPlayerTalking(id) then
                                    red = 0
                                    green = 0
                                    blue = 255
                                    DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
                                else
                                    red = 255
                                    green = 255
                                    blue = 255
                                    DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
                                end
                            end
                        end
                    end
                end
            elseif not IsControlPressed(1, 11) then
                DrawText3D(0, 0, 0, "")
            end
        end
    end
)

-- Handsup

-- The controls to disable when the gesture is active
--local disabledControls = {
--    25, -- aim
--    24, -- attack
--    257, -- attack 2
--    263, -- melee attack 1
--    264, -- melee attack 2
--    257, -- melee attack 3
--    140, -- melee attack 4
--    141, -- melee attack 5
--    142, -- melee attack 6
--    143 -- melee attack 7
--}
--
--Citizen.CreateThread(
--    function()
--        local dict = "missminuteman_1ig_2"
--        local lastGestureTime = 0
--
--        RequestAnimDict(dict)
--        while not HasAnimDictLoaded(dict) do
--            Citizen.Wait(100)
--        end
--
--        local handsup = false
--        while true do
--            Citizen.Wait(0)
--
--            if not IsPedInAnyVehicle(GetPlayerPed(-1)) then -- Only allow gesture if not in a vehicle
--                if IsControlJustPressed(1, 323) and GetGameTimer() - lastGestureTime >= 1000 then
--                    -- Start holding button
--                    if not handsup then
--                        TaskPlayAnim(
--                            GetPlayerPed(-1),
--                            dict,
--                            "handsup_enter",
--                            8.0,
--                            8.0,
--                            -1,
--                            50,
--                            0,
--                            false,
--                            false,
--                            false
--                        )
--                        handsup = true
--
--                        -- Disable controls
--                        for _, control in ipairs(disabledControls) do
--                            DisableControlAction(0, control, true)
--                        end
--                    else
--                        handsup = false
--                        ClearPedTasks(GetPlayerPed(-1))
--
--                        -- Enable controls
--                        for _, control in ipairs(disabledControls) do
--                            EnableControlAction(0, control, true)
--                        end
--                    end
--                    lastGestureTime = GetGameTimer()
--                end
--
--                -- Only disable controls when hands are up
--                if handsup then
--                    for _, control in ipairs(disabledControls) do
--                        DisableControlAction(0, control, true)
--                    end
--                end
--            else
--                if handsup then -- Clear gesture if entering a vehicle
--                    handsup = false
--                    ClearPedTasks(GetPlayerPed(-1))
--
--                    -- Enable controls
--                    for _, control in ipairs(disabledControls) do
--                        EnableControlAction(0, control, true)
--                    end
--                end
--            end
--        end
--    end
--)

-- Working Trams/Trins
SwitchTrainTrack(0, true) -- Setting the Main train track(s) around LS and towards Sandy Shores active
SwitchTrainTrack(3, true) -- Setting the Metro tracks active
SetTrainTrackSpawnFrequency(0, 120000) -- The Train spawn frequency set for the game engine
SetTrainTrackSpawnFrequency(3, 120000) -- The Metro spawn frequency set for the game engine
SetRandomTrains(true) -- Telling the game we want to use randomly spawned trains