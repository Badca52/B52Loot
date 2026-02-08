if (!isServer) exitWith {};

params ["_pos", "_showLoot"];

private _holder = createVehicle ["GroundWeaponHolder", [_pos select 0, _pos select 1, (_pos select 2) + 0.2], [], 0, "CAN_COLLIDE"];
[_holder, _pos] call B52_Loot_Module_fnc_lootPosInHouse;

// Protect from Ravage garbage collection
_holder setVariable ["rvg_intLoot", true];

private _type = selectRandom ["weapon", "magazine", "vest"];

switch (_type) do {
    case "weapon": {
        // Military buildings get broader weapon variety
        private _weaponType = selectRandom ["AssaultRifle", "AssaultRifle", "MachineGun", "SniperRifle", "Rifle"];
        private _weapon = [_weaponType] call B52_Loot_Module_fnc_selectWeapon;

        _holder addWeaponCargoGlobal [_weapon, 1];

        private _magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
        if (count _magazines > 0) then {
            private _magazineClass = _magazines select 0;
            _holder addMagazineCargoGlobal [_magazineClass, 2];
        };
    };

    case "magazine": {
        // Pick magazines compatible with a random military weapon type
        private _weaponType = selectRandom ["AssaultRifle", "MachineGun", "SniperRifle"];
        private _weapon = [_weaponType] call B52_Loot_Module_fnc_selectWeapon;

        private _magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
        if (count _magazines > 0) then {
            private _magazineClass = _magazines select 0;
            _holder addMagazineCargoGlobal [_magazineClass, 2];
        };
    };

    case "vest": {
        private _vest = selectRandom B52_Vests;
        _holder addItemCargoGlobal [_vest, 1];
    };
};

// Debug marker
if (_showLoot) then {
    private _id = format ["%1", _pos];
    private _debug = createMarker [_id, getPos _holder];
    _debug setMarkerShape "ICON";
    _debug setMarkerType "hd_dot";
    _debug setMarkerColor "ColorRed";
    _debug setMarkerText _type;
};
