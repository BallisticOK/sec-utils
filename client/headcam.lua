local isHeadCamActive = false
local headCamEntity = nil

RegisterCommand("headcam", function()
    isHeadCamActive = not isHeadCamActive

    local playerPed = PlayerId()

    if isHeadCamActive then
        local boneIndex = GetPedBoneIndex(playerPed, 31086) -- 31086 is the SKEL_Head bone
        local camOffset = vector3(0.0, -0.1, 0.1) -- Adjust the offset as needed

        headCamEntity = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        RenderScriptCams(true, false, 0, true, true)

        Citizen.CreateThread(function()
            while isHeadCamActive do
                AttachEntityToEntity(headCamEntity, playerPed, boneIndex, camOffset.x, camOffset.y, camOffset.z, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                Wait(0)
            end
        end)
    else
        DetachEntity(headCamEntity, true, true)
        DestroyCam(headCamEntity, true)
        RenderScriptCams(false, false, 0, true, true)
    end
end, false)
