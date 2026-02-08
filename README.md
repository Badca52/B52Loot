# B52 Loot

An Arma 3 mod that spawns loot (weapons, equipment, clothing, magazines, attachments, and crates) inside buildings across the map. Designed for survival, sandbox, and Battle Royale-style missions.

## Features

- Spawns loot at building positions across the entire map
- Military buildings get specialized loot (assault rifles, machine guns, sniper rifles)
- Weapons spawn with compatible magazines
- Configurable spawn probability via Eden editor module
- Debug markers to visualize spawn locations
- Fully customizable loot tables via mission-level overrides
- Ravage mod compatible

## Requirements

- Arma 3 v1.60+
- [CBA_A3](https://steamcommunity.com/workshop/filedetails/?id=450814997) (Community Base Addons)

## Installation

### Steam Workshop

Subscribe to the mod on [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=898629562) and enable it in the Arma 3 launcher.

### Manual Install

1. Download or clone this repository
2. Copy the `@B52Loot` folder to your Arma 3 directory (or use a mod symlink)
3. Add `@B52Loot` to your Arma 3 launch parameters: `-mod=@CBA_A3;@B52Loot`

## Setup

### Eden Editor (Recommended)

1. Open your mission in the Eden Editor
2. Go to **Modules** (F7) and find **B52 > B52 Loot System**
3. Place the module anywhere on the map
4. Configure the module attributes:
   - **Loot Probability** (0-100): Chance that loot spawns at each building position. Default: `15`
   - **Show Markers**: Enable debug markers at spawn locations. Default: `Disabled`
5. Save and play the mission

### Script-Based (Advanced)

If you prefer not to place an editor module, you can initialize the system via script. Add this to your mission's `initServer.sqf`:

```sqf
// Optional: override loot tables before init
// B52_AssaultRifles = ["my_custom_rifle_1", "my_custom_rifle_2"];

call B52_Loot_Module_fnc_defineLootTables;

// Create a temporary logic object with settings
private _logic = "Logic" createVehicleLocal [0,0,0];
_logic setVariable ["lootProbability", 15];
_logic setVariable ["showMarkers", false];
[_logic, "", true] call B52_Loot_Module_fnc_init;
```

## Customizing Loot Tables

All loot arrays can be overridden by defining them in your mission's `init.sqf` **before** the module activates. The mod uses `isNil` checks, so any pre-defined array takes priority.

### Available Arrays

| Array | Description |
|-------|-------------|
| `B52_MilitaryKeywords` | Building classname keywords for military detection |
| `B52_IndustrialKeywords` | Building classname keywords for industrial detection |
| `B52_WeaponTypes` | Weighted weapon type selection (duplicate entries = higher chance) |
| `B52_AssaultRifles` | Assault rifle classnames |
| `B52_AssaultRiflesGL` | Grenade launcher rifle classnames |
| `B52_Handguns` | Pistol classnames |
| `B52_MachineGuns` | LMG/SAW classnames |
| `B52_SniperRifles` | Sniper/DMR classnames |
| `B52_SubmachineGuns` | SMG classnames |
| `B52_RocketLaunchers` | Rocket launcher classnames |
| `B52_MissileLaunchers` | Guided missile launcher classnames |
| `B52_Vests` | Vest/plate carrier classnames |
| `B52_Backpacks` | Backpack classnames |
| `B52_Clothes` | Uniform classnames |
| `B52_Magazines` | Standalone magazine classnames |
| `B52_Attachments` | Optic/suppressor/bipod classnames |
| `B52_Items` | General items (maps, GPS, NVG, medical) |
| `B52_Food` | Food items (empty by default, for use with survival mods) |
| `B52_HeroesEnabled` | Set to `true` to enable food spawning (requires `B52_Food` to be populated) |

### Example: CUP Weapons Only

In your mission's `init.sqf`:

```sqf
B52_AssaultRifles = [
    "CUP_arifle_M4A1", "CUP_arifle_M16A4",
    "CUP_arifle_AK74", "CUP_arifle_AKM"
];
B52_Handguns = [
    "CUP_hgun_M9", "CUP_hgun_Glock17",
    "CUP_hgun_Makarov"
];
B52_SniperRifles = [
    "CUP_srifle_M24_SOS", "CUP_srifle_SVD"
];
// Override other arrays as needed...
```

### Example: Weapon Category Weighting

Control the relative probability of each weapon type by adjusting duplicate entries:

```sqf
// Heavy on assault rifles, rare snipers and launchers
B52_WeaponTypes = [
    "AssaultRifle", "AssaultRifle", "AssaultRifle", "AssaultRifle", "AssaultRifle",
    "Handgun", "Handgun",
    "SubmachineGun", "SubmachineGun", "SubmachineGun",
    "MachineGun",
    "SniperRifle",
    "RocketLauncher"
];
```

## Mod Compatibility

### Ravage

B52 Loot is compatible with Ravage. Loot holders are flagged with `rvg_intLoot` to prevent Ravage's garbage collector from cleaning them up.

### CUP / RHS / Other Weapon Mods

The mod spawns vanilla Arma 3 gear by default. To use weapons from CUP, RHS, or other mods, override the relevant `B52_*` arrays in your mission's `init.sqf` (see examples above).

You can auto-detect loaded mods and extend arrays:

```sqf
if (isClass (configFile >> "CfgPatches" >> "CUP_Weapons")) then {
    B52_AssaultRifles = B52_AssaultRifles + ["CUP_arifle_M4A1", "CUP_arifle_AK74"];
};
```

### ACE3

ACE3 is compatible with B52 Loot. Weapons spawn with magazines as normal. ACE medical and interaction systems do not conflict with cargo operations.

### Heros Survive

Set `B52_HeroesEnabled = true` and populate `B52_Food` with your survival mod's food classnames in `init.sqf`.

## Dedicated Server Setup

1. Install the mod on your server as you would any Arma 3 mod
2. Copy the `.bikey` file from the `keys/` folder to your server's `Keys/` directory
3. Add the mod to your server's `-mod=` launch parameter
4. The loot system runs server-side only (`isServer` guard)

## Building from Source

Requires [Arma 3 Tools](https://store.steampowered.com/app/233800/Arma_3_Tools/) from Steam.

1. Clone this repository
2. Open **Addon Builder** from Arma 3 Tools
3. Set source directory to `addons/b52_loot`
4. Build the PBO to `addons/b52_loot.pbo`
5. To generate a server key:
   - Use **DSCreateKey** to create a keypair
   - Use **DSSignFile** to sign the PBO with your private key
   - Distribute the `.bikey` (public key) in the `keys/` folder

## License

This project is open source. See the repository for details.

## Credits

- **Badca52** - Original author
- Community contributors and bug reporters from the Steam Workshop
