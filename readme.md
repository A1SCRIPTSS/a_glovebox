# Vehicle Glovebox Search System

This repository contains a script for managing vehicle gloveboxes in a FiveM server using the QBox framework. The system allows players to interact with the glovebox of their vehicle, store items, and retrieve them. The glovebox can be "hacked" to gain access, and there is a cooldown mechanism to prevent abuse.

## Features

- **Vehicle Glovebox Access:** Players can access the glovebox of their vehicle by pressing a keybind (M by default).
- **Hacking Mechanism:** If the glovebox hasn't been hacked before, players must complete a mini-game to gain access.
- **Item Spawning:** The glovebox can spawn random items based on the vehicle class and configured item spawn chances.
- **Cooldown System:** A cooldown period is enforced after accessing the glovebox to prevent spamming.
- **Debug Mode:** Debug prints can be enabled to help with development and troubleshooting.

## Installation

1. **Download the Script:** Clone or download this repository into your resources folder.
2. **Add to `server.cfg`:** Add the following line to your `server.cfg` file:

```plaintext
ensure a_glovebox
```

3. **Configure:** Modify the `config.lua` file to suit your server's needs.
4. **Restart the Server:** Restart your FiveM server to apply the changes.

## Configuration

The `config.lua` file contains several configuration options:

- **Debug Mode:** Enable or disable debug prints.
- **Cooldown:** Set the cooldown period (in seconds) between glovebox accesses.
- **Stash Configuration:** Define the number of slots, maximum weight, and label prefix for the glovebox stash.
- **Item Spawn Chances:** Configure the items that can spawn in the glovebox, along with their spawn chances and vehicle class restrictions.
- **Allowed Vehicle Classes:** Specify which vehicle classes can have a glovebox.

### Example Configuration:

```lua
Config = {
    Debug = false,
    Cooldown = 0,
    Stash = {
        slots = 10,
        maxWeight = 0,
        labelPrefix = 'Vehicle Stash - ',
    },
    ItemSpawnChances = {
        { name = 'water', chance = 100, metadata = { label = 'Mineral Water' } },
        { name = 'WEAPON_PISTOL', chance = 100 },
        { name = 'WEAPON_PISTOL', chance = 20, vehicleClass = 6 },
        { name = 'ammo-9', chance = 30, count = 50, vehicleClass = 6 },
        { name = 'bandage', chance = 40 },
        { name = 'toolkit', chance = 80, vehicleClass = 10 },
        { name = 'luxury_watch', chance = 50, vehicleClass = 7 },
    },
    VehicleClasses = {
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
}
```

## Usage

1. **Enter a Vehicle:** Get into a vehicle that is allowed to have a glovebox.
2. **Access the Glovebox:** Press the configured keybind (M by default) to access the glovebox.
3. **Hack the Glovebox:** If the glovebox hasn't been hacked before, complete the mini-game to gain access.
4. **Store/Retrieve Items:** Use the inventory interface to store or retrieve items from the glovebox.

## Dependencies

- **[QBox Framework](https://github.com/Qbox-project)**
- **ox_inventory** (or any other inventory system that supports stashes)
- **InteractSound** (for sound effects)

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License. See the [LICENSE](https://github.com/A1SCRIPTSS/a_glovebox/blob/main/LICENSE) file for details.

## Support

If you encounter any issues or have questions, please open an issue on the GitHub repository.

**Note:** This script is designed for use with the QBox framework and may require modifications to work with other frameworks or inventory systems.