local QBCore = exports['qb-core']:GetCoreObject()
local inVehicle = false
local vehiclePlate = nil
local lastStashAccess = 0
local cooldown = false

local function DebugPrint(message)
    if Config.Debug then
        print(message)
    end
end

local function IsVehicleClassAllowed(vehicle)
    return Config.VehicleClasses[GetVehicleClass(vehicle)] or false
end

local function PlaySound(soundName, volume)
    TriggerServerEvent('InteractSound_SV:PlayOnSource', soundName, volume)
end

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local currentPlate = vehicle and GetVehicleNumberPlateText(vehicle)

        if DoesEntityExist(vehicle) and not inVehicle then
            inVehicle = true
            vehiclePlate = currentPlate
            if vehiclePlate and IsVehicleClassAllowed(vehicle) then
                DebugPrint('[DEBUG] Entered vehicle with plate: ' .. vehiclePlate)
                TriggerServerEvent('a_glovebox:enteredVehicle', vehiclePlate)
            else
                DebugPrint('[DEBUG] Vehicle not allowed or failed to retrieve vehicle plate')
            end
        elseif not DoesEntityExist(vehicle) and inVehicle then
            inVehicle = false
            vehiclePlate = nil
            DebugPrint('[DEBUG] Exited vehicle')
        end
        Wait(1000)
    end
end)

local stashKeybind = lib.addKeybind({
    name = 'open_glovebox',
    description = '[Vehicle] Search Glovebox',
    defaultKey = 'M',
    disabled = false,
    onPressed = function(self)
        if inVehicle and not cooldown then
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if not IsVehicleClassAllowed(vehicle) then
                DebugPrint('[DEBUG] Vehicle class not allowed')
                return
            end

            DebugPrint('[DEBUG] "M" key pressed in vehicle')

            cooldown = true
            SetTimeout(Config.Cooldown * 1000, function() cooldown = false end)

            QBCore.Functions.TriggerCallback('a_glovebox:checkHackedStatus', function(alreadyHacked)
                DebugPrint('[DEBUG] Callback response - alreadyHacked: ' .. tostring(alreadyHacked))
                if alreadyHacked then
                    TriggerServerEvent('a_glovebox:openStash')
                    PlaySound('stash_open', 0.5)
                else
                    if lib.progressBar({
                        duration = 3000,
                        label = 'Opening Stash...',
                        useWhileDead = false,
                        canCancel = true,
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                            mouse = false,
                        },
                    }) then
                        local success = exports['bl_ui']:NumberSlide(1, 50, 1)

                        if success then
                            DebugPrint("Success")
                            local vehicleClass = GetVehicleClass(vehicle)
                            TriggerServerEvent('a_glovebox:setHackedStatus', vehiclePlate, vehicleClass)
                            TriggerServerEvent('a_glovebox:openStash')
                            PlaySound('stash_open', 0.5)
                            lastStashAccess = GetGameTimer()
                        else
                            DebugPrint("Fail")
                        end
                    else
                        DebugPrint("Stash opening canceled")
                    end
                end
            end, vehiclePlate)
        end
    end,
    onReleased = function(self)
        DebugPrint('[DEBUG] "M" key released')
    end
})