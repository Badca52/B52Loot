#define DEF_LOOT_PROBABILITY 15
#define DEF_SHOW_LOOT false
#define DEF_BATCH_SIZE 10

if (!isServer) exitWith {};

params [
    ["_logic", objNull],
    "",
    ["_activated", true]
];

if (!_activated) exitWith {};

// Load default loot tables (respects any mission-level overrides)
call B52_Loot_Module_fnc_defineLootTables;

private _probability = _logic getVariable ["lootProbability", DEF_LOOT_PROBABILITY];
private _showLoot    = _logic getVariable ["showMarkers", DEF_SHOW_LOOT];

// Buildings to exclude from loot spawning
private _exclusionList = ["Land_Pier_F", "Land_Pier_small_F", "Land_NavigLight", "Land_LampHarbour_F"];

// Map-agnostic center and search radius
private _mapSize = worldSize;
private _center  = [_mapSize / 2, _mapSize / 2];
private _radius  = _mapSize * 0.7;

private _houseList = _center nearObjects ["House", _radius];
private _totalBuildings = count _houseList;

diag_log format ["[B52 Loot] Starting loot spawn: %1 buildings found on map (worldSize=%2)", _totalBuildings, _mapSize];

private _buildingsProcessed = 0;

{
    private _house = _x;

    if !(typeOf _house in _exclusionList) then {
        private _buildingType = typeOf _house;

        // Classify building by classname keywords
        private _isMilitary = false;
        {
            if (_buildingType find _x >= 0) exitWith { _isMilitary = true; };
        } forEach B52_MilitaryKeywords;

        if (!_isMilitary) then {
            {
                if (_buildingType find _x >= 0) exitWith { _isMilitary = true; };
            } forEach B52_IndustrialKeywords;
        };

        // Iterate building positions (max 50 per building)
        for "_n" from 0 to 50 do {
            private _buildingPos = _house buildingPos _n;
            if (_buildingPos isEqualTo [0,0,0]) exitWith {};

            if (_probability > random 100) then {
                if (_isMilitary) then {
                    [_buildingPos, _showLoot] call B52_Loot_Module_fnc_spawnLootMilitary;
                } else {
                    [_buildingPos, _showLoot] call B52_Loot_Module_fnc_spawnLootGeneral;
                };
            };
        };
    };

    _buildingsProcessed = _buildingsProcessed + 1;

    // Yield every batch to prevent "too many virtual blocks" crash
    // Smaller batch size = more yields = safer on large maps like Altis (30k+ buildings)
    if (_buildingsProcessed % DEF_BATCH_SIZE == 0) then {
        sleep 0.05;
    };

    // Progress logging every 1000 buildings
    if (_buildingsProcessed % 1000 == 0) then {
        diag_log format ["[B52 Loot] Progress: %1/%2 buildings processed (%3%%)", _buildingsProcessed, _totalBuildings, round (_buildingsProcessed / _totalBuildings * 100)];
    };
} forEach _houseList;

diag_log format ["[B52 Loot] Complete: %1 buildings processed", _totalBuildings];
