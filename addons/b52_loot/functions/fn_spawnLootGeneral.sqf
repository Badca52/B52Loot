if (!isServer) exitWith {};

params ["_pos", "_showLoot"];

private _holder = createVehicle ["GroundWeaponHolder", [_pos select 0, _pos select 1, (_pos select 2) + 0.2], [], 0, "CAN_COLLIDE"];
[_holder, _pos] call B52_Loot_Module_fnc_lootPosInHouse;

// Uniform random loot type selection
private _lootTypes = ["vest", "item", "clothing", "backpack", "magazine", "weapon", "crate"];
private _type = selectRandom _lootTypes;

switch (_type) do {
    case "item": {
        private _subTypes = ["gear", "clothing", "magazine", "attachment"];
        if (B52_HeroesEnabled && {count B52_Food > 0}) then {
            _subTypes pushBack "food";
        };

        private _subType = selectRandom _subTypes;

        switch (_subType) do {
            case "gear": {
                _type = "item - gear";
                private _item = selectRandom B52_Items;
                _holder addItemCargoGlobal [_item, 1];
            };
            case "clothing": {
                _type = "item - clothing";
                private _clothing = selectRandom B52_Clothes;
                _holder addItemCargoGlobal [_clothing, 1];
            };
            case "magazine": {
                _type = "item - magazine";
                private _magazine = selectRandom B52_Magazines;
                _holder addMagazineCargoGlobal [_magazine, 1];
            };
            case "attachment": {
                _type = "item - attachment";
                private _attachment = selectRandom B52_Attachments;
                _holder addItemCargoGlobal [_attachment, 1];
            };
            case "food": {
                _type = "item - food";
                private _food = selectRandom B52_Food;
                _holder addItemCargoGlobal [_food, 1];
            };
        };
    };

    case "vest": {
        private _vest = selectRandom B52_Vests;
        _holder addItemCargoGlobal [_vest, 1];
    };

    case "clothing": {
        private _clothing = selectRandom B52_Clothes;
        _holder addItemCargoGlobal [_clothing, 1];
    };

    case "backpack": {
        private _backpack = selectRandom B52_Backpacks;
        _holder addBackpackCargoGlobal [_backpack, 1];
    };

    case "magazine": {
        private _magazine = selectRandom B52_Magazines;
        _holder addMagazineCargoGlobal [_magazine, 1];
    };

    case "weapon": {
        private _weaponType = selectRandom B52_WeaponTypes;
        private _weapon = [_weaponType] call B52_Loot_Module_fnc_selectWeapon;

        _holder addWeaponCargoGlobal [_weapon, 1];

        // Add compatible magazine
        private _magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
        if (count _magazines > 0) then {
            private _magazineClass = _magazines select 0;
            private _magCount = 1 + floor random 2;
            _holder addMagazineCargoGlobal [_magazineClass, _magCount];
        };
    };

    case "crate": {
        private _localPos = getPosATL _holder;
        deleteVehicle _holder;
        _holder = createVehicle ["Box_IND_Ammo_F", _localPos, [], 0, "CAN_COLLIDE"];

        clearItemCargoGlobal _holder;
        clearWeaponCargoGlobal _holder;
        clearMagazineCargoGlobal _holder;
        clearBackpackCargoGlobal _holder;

        private _crateType = selectRandom ["general", "military"];

        if (_crateType == "general") then {
            for "_i" from 1 to 3 do {
                private _clothing = selectRandom B52_Clothes;
                _holder addItemCargoGlobal [_clothing, 1];

                if (B52_HeroesEnabled && {count B52_Food > 0}) then {
                    private _food = selectRandom B52_Food;
                    _holder addItemCargoGlobal [_food, 1];
                };

                private _vest = selectRandom B52_Vests;
                _holder addItemCargoGlobal [_vest, 1];

                private _backpack = selectRandom B52_Backpacks;
                _holder addBackpackCargoGlobal [_backpack, 1];
            };
        } else {
            for "_i" from 1 to 4 do {
                private _weaponType = selectRandom B52_WeaponTypes;
                private _weapon = [_weaponType] call B52_Loot_Module_fnc_selectWeapon;

                _holder addWeaponCargoGlobal [_weapon, 1];

                private _magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
                if (count _magazines > 0) then {
                    private _magazineClass = _magazines select 0;
                    private _magCount = 1 + floor random 2;
                    _holder addMagazineCargoGlobal [_magazineClass, _magCount];
                };
            };
        };
    };
};

// Debug marker
if (_showLoot) then {
    private _id = format ["%1", _pos];
    private _debug = createMarker [_id, getPos _holder];
    _debug setMarkerShape "ICON";
    _debug setMarkerType "hd_dot";
    _debug setMarkerColor "ColorGreen";
    _debug setMarkerText _type;
};
