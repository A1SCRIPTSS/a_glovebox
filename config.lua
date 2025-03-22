Config = {}

Config.Debug = false
Config.Cooldown = 0

Config.Stash = {
    slots = 10,
    maxWeight = 0,
    labelPrefix = 'Vehicle Stash - ',
}

Config.ItemSpawnChances = {
    { 
        name = 'water', 
        chance = 100, 
        metadata = { label = 'Mineral Water' } 
    },
    { 
        name = 'WEAPON_PISTOL', 
        chance = 100 
    },
    { 
        name = 'WEAPON_PISTOL', 
        chance = 20, 
        vehicleClass = 6 
    },
    { 
        name = 'ammo-9', 
        chance = 30, 
        count = 50, 
        vehicleClass = 6 
    },
    { 
        name = 'bandage', 
        chance = 40 
    },
    { 
        name = 'toolkit', 
        chance = 80, 
        vehicleClass = 10 
    },
    { 
        name = 'luxury_watch', 
        chance = 50, 
        vehicleClass = 7 
    },
}

Config.VehicleClasses = {
    [0] = true,  -- Compacts
    [1] = true,  -- Sedans
    [2] = true,  -- SUVs
    [3] = true,  -- Coupes
    [4] = true,  -- Muscle
    [5] = true,  -- Sports Classics
    [6] = true,  -- Sports
    [7] = true,  -- Super
    [8] = true,  -- Motorcycles
    [9] = true,  -- Off-road
    [10] = false, -- Industrial
    [11] = false, -- Utility
    [12] = false, -- Vans
    [13] = false, -- Cycles (Bicycles)
    [14] = false, -- Boats
    [15] = false, -- Helicopters
    [16] = false, -- Planes
    [17] = false, -- Service
    [18] = false, -- Emergency
    [19] = false, -- Military
    [20] = false, -- Commercial
    [21] = false, -- Trains
}