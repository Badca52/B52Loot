#define def_LOOT_PROBABILITY 15
#define def_SHOW_LOOT false

params [
    ["_logic", objNull],
    "",
    ["_activated", true]
];

_probability = _logic getVariable ["lootProbability", def_LOOT_PROBABILITY];
_showLoot    = _logic getVariable ["showMarkers", def_SHOW_LOOT];

// Exclude buildings from loot spawn. Use 'TYPEOF' to find building name
_exclusionList= ["Land_Pier_F","Land_Pier_small_F","Land_NavigLight","Land_LampHarbour_F"];

private ["_distance","_houseList"];
_mkr = createMarker ["loot_spawn",[7800,8500]];
_mkr setMarkerShape "ICON";
_mkr setMarkerType "EMPTY";
_mkr setMarkerSize [35000, 35000];
_pos = markerpos _mkr;
_mkrY = getmarkerSize _mkr select 0;
_mkrX = getmarkerSize _mkr select 1;

_distance = _mkrX;
if (_mkrY > _mkrX) 
then {
    _distance = _mkrY;
};

_houseList = _pos nearObjects ["House", _distance];

{
    _house = _X;
    
    if (!(typeOf _house in _exclusionList)) 
    then {
        _buildingType     = typeOf _house;
        _vehicleClassName = getText(configfile >> "CfgVehicles" >> _buildingType >> "vehicleClass");
        
        for "_n" from 0 to 50 do {
            _buildingPos = _house buildingpos _n;
            if (str _buildingPos == "[0,0,0]")
            exitwith {};
            
            if (_probability > random 100) 
            then {
                // Spawn Residential Loot
                if (_vehicleClassName in B52_BuildingIndustrial || _vehicleClassName in B52_BuildingMilitary)
                then 
                {
                    null = [_buildingPos, _showLoot] execVM "\b52_loot\functions\fn_spawnLootMilitary.sqf";
                }
                else {
                    null = [_buildingPos, _showLoot] execVM "\b52_loot\functions\fn_spawnLootGeneral.sqf";
                };
            };
        };
    };              
}foreach _houseList;