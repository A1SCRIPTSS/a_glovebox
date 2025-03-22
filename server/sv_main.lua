local QBCore = exports['qb-core']:GetCoreObject()
local stashes = {}
local hackedVehicles = {}

local function DebugPrint(message)
    if Config.Debug then
        print(message)
    end
end

local function GenerateStashItems(vehicleClass)
    local items = {}
    for _, item in pairs(Config.ItemSpawnChances) do
        if math.random(1, 100) <= item.chance then
            if not item.vehicleClass or item.vehicleClass == vehicleClass then
                table.insert(items, { item.name, item.count or 1, item.metadata or {} })
            end
        end
    end
    return items
end

RegisterNetEvent('a_glovebox:enteredVehicle', function(vehiclePlate)
    local playerId = source
    local player = QBCore.Functions.GetPlayer(playerId)

    if player and vehiclePlate then
        player.Functions.SetMetaData('vehiclePlate', vehiclePlate)
        DebugPrint('[DEBUG] Vehicle plate stored in metadata: ' .. vehiclePlate)
    else
        DebugPrint('[DEBUG] Player not found or vehicle plate is nil')
    end
end)

QBCore.Functions.CreateCallback('a_glovebox:checkHackedStatus', function(source, cb, vehiclePlate)
    DebugPrint('[DEBUG] Callback triggered with vehiclePlate: ' .. vehiclePlate)
    local playerId = source
    local player = QBCore.Functions.GetPlayer(playerId)
    if not player then
        DebugPrint('[DEBUG] Player not found')
        return cb(false)
    end

    if hackedVehicles[vehiclePlate] then
        DebugPrint('[DEBUG] Vehicle already hacked: ' .. vehiclePlate)
        cb(true)
    else
        DebugPrint('[DEBUG] Vehicle not hacked yet: ' .. vehiclePlate)
        cb(false)
    end
end)

RegisterNetEvent('a_glovebox:setHackedStatus', function(vehiclePlate, vehicleClass)
    local playerId = source
    local player = QBCore.Functions.GetPlayer(playerId)
    if not player or not vehiclePlate then return end

    hackedVehicles[vehiclePlate] = {
        hacked = true,
        class = vehicleClass
    }
    DebugPrint('[DEBUG] Vehicle marked as hacked: ' .. vehiclePlate .. ', Class: ' .. vehicleClass)
end)

RegisterNetEvent('a_glovebox:openStash', function()
    local playerId = source
    local player = QBCore.Functions.GetPlayer(playerId)
    if not player then return DebugPrint('[DEBUG] Player not found') end

    local vehiclePlate = player.PlayerData.metadata['vehiclePlate']
    if not vehiclePlate then return DebugPrint('[DEBUG] Vehicle plate not found in metadata') end

    local vehicleData = hackedVehicles[vehiclePlate]
    if not vehicleData then return DebugPrint('[DEBUG] Vehicle data not found for plate: ' .. vehiclePlate) end

    local vehicleClass = vehicleData.class

    if stashes[vehiclePlate] then
        DebugPrint('[DEBUG] Reusing existing stash for vehicle plate: ' .. vehiclePlate)
        TriggerClientEvent('ox_inventory:openInventory', playerId, 'stash', stashes[vehiclePlate])
        return
    end

    DebugPrint('[DEBUG] Creating new stash for vehicle plate: ' .. vehiclePlate)
    local stash = exports.ox_inventory:CreateTemporaryStash({
        label = Config.Stash.labelPrefix .. vehiclePlate,
        slots = Config.Stash.slots,
        maxWeight = Config.Stash.maxWeight,
        owner = vehiclePlate,
        items = GenerateStashItems(vehicleClass)
    })

    if stash then
        stashes[vehiclePlate] = stash
        DebugPrint('[DEBUG] Stash created with ID: ' .. stash)
        TriggerClientEvent('ox_inventory:openInventory', playerId, 'stash', stash)
    else
        DebugPrint('[DEBUG] Failed to create stash')
    end
end)