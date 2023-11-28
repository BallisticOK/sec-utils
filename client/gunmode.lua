-- Configuration
CodeStudio = {
    Modes = {
        SemiAutoMode = true,
        SafetyMode = true,
        -- BurstMode = true, -- Remove BurstMode option
    },
    KeyBinds = {
        Command = 'wep_mode',
        Key = 'K',
        Info_Text = 'Change Weapon Mode'
    },
    Language = {
        AutoMode = 'Auto Mode',
        SemiAuto = 'Semi-Auto Mode',
        SafetyMode = 'Safety Mode',
        -- BurstMode = 'Burst Mode' -- Remove BurstMode option
    }
}

-- Main Code
local shootingEnabled = true
local shootingButtonHeld = false
local Mode = 'auto' -- 'auto', 'semi_auto', 'safety', 'burst'
local ammoCount = 0

local function setSafety(ped, weapon)
    ammoCount = GetAmmoInPedWeapon(ped, weapon)
    SetPedAmmo(ped, weapon, 0)
    Mode = 'safety'
end

local function restoreAmmo(ped, weapon)
    SetPedAmmo(ped, weapon, ammoCount)
    Mode = 'auto'
end

local function toggleShootingEnabled(enable)
    shootingEnabled = enable
    DisablePlayerFiring(PlayerId(), not enable)
end

local function semiAuto()
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    if Mode == 'safety' then
        restoreAmmo(ped, weapon)
    end

    while Mode == 'semi_auto' do
        Wait(0)
        if shootingButtonHeld then
            toggleShootingEnabled(false)
        end

        if IsDisabledControlJustReleased(0, 24) and shootingButtonHeld then
            toggleShootingEnabled(true)
            shootingButtonHeld = false
        end

        if shootingEnabled and IsControlPressed(0, 24) and IsPedShooting(PlayerPedId()) then
            shootingButtonHeld = true
        end
    end
end

local function automaticMode()
    toggleShootingEnabled(true)
    Mode = 'auto'
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    if Mode == 'safety' then
        restoreAmmo(ped, weapon)
    end
end

local function safetyMode()
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    setSafety(ped, weapon)
end

local function Notify(msg)
    QBCore.Functions.Notify("Weapon Mode", msg)
end

RegisterCommand(CodeStudio.KeyBinds.Command, function()
    if not CodeStudio.Modes.SemiAutoMode and not CodeStudio.Modes.SafetyMode then
        return
    end

    local modes = {semiAuto, safetyMode, automaticMode}
    local modeNames = {
        CodeStudio.Language.SemiAuto,
        CodeStudio.Language.SafetyMode,
        CodeStudio.Language.AutoMode
    }

    Mode = 'auto'
    local modeIndex = 1 + (click % #modes)
    local selectedMode = modes[modeIndex]
    local modeName = modeNames[modeIndex]
    click = click + 1

    if selectedMode then
        Notify(modeName)
        selectedMode()
    end
end)

RegisterKeyMapping(CodeStudio.KeyBinds.Command, CodeStudio.KeyBinds.Info_Text, 'keyboard', CodeStudio.KeyBinds.Key)
