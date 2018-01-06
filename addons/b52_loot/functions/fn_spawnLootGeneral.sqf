private ["_type","_lootTypes","_pos","_showLoot","_holder","_lootTypeCount","_weaponType","_weapon","_rndMagazineNum","_rndCrateTypes","_crateType","_localPos","_magazineClass"];
if (isServer) 
    then {
        _pos      = (_this select 0);
        _showLoot = (_this select 1);
        
        _rndCrateTypes = ["general", "military"];
        
        _holder = createVehicle ["GroundWeaponHolder", [_pos select 0, _pos select 1, (_pos select 2) + 0.2], [], 0, "can_Collide"];
        [_holder, _pos] call B52_Loot_Module_fnc_lootPosInHouse;
        
        _lootTypes = [
            "vest",
            "item",
            "clothing",
            "backpack",
            "magazine",
            "weapon",
            "crate",
            "item", // Used for increasing liklihood of crate spawn
            "item"// Used for increasing liklihood of crate spawn
        ];
        
        _lootTypeCount = count _lootTypes;
        _rndNum        = floor random [0, 2, _lootTypeCount];
        _type          = _lootTypes select _rndNum;
        
        if (_type == "item")
        then {
            
            if (B52_Heros_Enabled)
            then {
                _rndNum = floor random 5;
            }
            else {
                _rndNum = floor random 4;
            };
            
            if (_rndNum == 0)
            then {
                _item = B52_Items call bis_fnc_selectRandom;
                _holder addItemCargoGlobal [_item, 1];
            };
            
            if (_rndNum == 1)
            then {
                _type     = "item - clothing";
                _clothing = B52_Clothes call bis_fnc_selectRandom;
                _holder addItemCargoGlobal [_clothing, 1];
            };
            
            if (_rndNum == 2)
            then {
                _type          = "item - magazine";
                _magazineClass = B52_Magazines call bis_fnc_selectRandom;
                _holder addMagazineCargoGlobal [_magazineClass, 1];
            };
            
            if (_rndNum == 3)
            then {
                _type          = "item - attachment";
                _item = B52_Attatchments call bis_fnc_selectRandom;
                _holder addItemCargoGlobal [_item, 1];
            };
            
            if (_rndNum == 4)
            then {
                _type = "item - food";
                _food = B52_Food call bis_fnc_selectRandom;
                _holder addItemCargoGlobal [_food, 1];
            };
            
        };
        
        if (_type == "vest")
        then {
            _vest = B52_Vests call bis_fnc_selectRandom;
            _holder addItemCargoGlobal [_vest, 1];
        };
        
        if (_type == "backpack")
        then {
            _backpack = B52_Backpacks call bis_fnc_selectRandom;
            _holder addBackpackCargoGlobal [_backpack, 1];
        };
        
        if (_type == "weapon")
        then {
            
            _weaponType = B52_WeaponTypes call bis_fnc_selectRandom;
            _weapon = B52_AssaultRifles call bis_fnc_selectRandom;
            
            switch (_weaponType) do {
                case "AssaultRifle": { 
                    _weapon = B52_AssaultRifles call bis_fnc_selectRandom;
                };
                case "Handgun": { 
                    _weapon = B52_Handguns call bis_fnc_selectRandom;
                };
                case "MachineGun": { 
                    _weapon = B52_MachineGuns call bis_fnc_selectRandom;
                };
                case "MissileLauncher": { 
                    _weapon = B52_MissleLaunchers call bis_fnc_selectRandom;
                };
                case "RocketLauncher": { 
                    _weapon = B52_RocketLaunchers call bis_fnc_selectRandom;
                };
                case "Rifle": { 
                    _weapon = B52_AssaultRiflesG call bis_fnc_selectRandom;
                };
                case "SubmachineGun": { 
                    _weapon = B52_SubmachineGuns call bis_fnc_selectRandom;
                };
                case "SniperRifle": { 
                    _weapon = B52_SniperRifles call bis_fnc_selectRandom;
                };
                default { 
                    _weapon = B52_AssaultRifles call bis_fnc_selectRandom;
                };
            };
            
            _magazines     = getArray (configFile / "CfgWeapons" / _weapon / "magazines");
            _magazineClass = _magazines call bis_fnc_selectRandom;
            
            _rndMagazineNum = ceil (random 2);
            _holder addWeaponCargoGlobal [_weapon, 1];
                    
            _magCount = count _magazines;
            for "_i" from 1 to _magCount do 
            {
                _magazineClass = _magazines call bis_fnc_selectRandom;
                
                if (getnumber (configFile >> "CfgWeapons" >> _weapon >> "magazines" >> _magazineClass >> "scope") == 2) 
                exitWith {
                    _holder addMagazineCargoGlobal [_magazineClass, _rndMagazineNum];
                };
            };
        };
        
        if (_type == "crate")
        then {
            _localPos = getPosATL _holder;
            deleteVehicle _holder; // Remove groundweaponholder
            _holder = createVehicle ["Box_IND_Ammo_F", _localPos, [], 0, "can_Collide"];
            
            // Clear container before using
            clearItemCargoGlobal _holder;
            clearWeaponCargoGlobal _holder;
            clearMagazineCargoGlobal _holder;
            clearBackpackCargoGlobal _holder;
            
            _crateType = _rndCrateTypes call bis_fnc_selectRandom;
            
            if (_crateType == "general")
            then {
                for "_i" from 1 to 3 do {
                    _clothing = B52_Clothes call bis_fnc_selectRandom;
                    _holder addItemCargoGlobal [_clothing, 1];
                    
                    if (B52_Heros_Enabled)
                    then {
                        _food = B52_Food call bis_fnc_selectRandom;
                        _holder addItemCargoGlobal [_food, 1];
                    };
                    _vest = B52_Vests call bis_fnc_selectRandom;
                    _holder addItemCargoGlobal [_vest, 1];
                    
                    _backpack = B52_Backpacks call bis_fnc_selectRandom;
                    _holder addBackpackCargoGlobal [_backpack, 1];
                };
            }
            else {
                for "_i" from 1 to 4 do {
                    _weaponType = B52_WeaponTypes call bis_fnc_selectRandom;
                    _weapon = B52_AssaultRifles call bis_fnc_selectRandom;
                    
                    switch (_weaponType) do {
                        case "AssaultRifle": { 
                            _weapon = B52_AssaultRifles call bis_fnc_selectRandom;
                        };
                        case "Handgun": { 
                            _weapon = B52_Handguns call bis_fnc_selectRandom;
                        };
                        case "MachineGun": { 
                            _weapon = B52_MachineGuns call bis_fnc_selectRandom;
                        };
                        case "MissileLauncher": { 
                            _weapon = B52_MissleLaunchers call bis_fnc_selectRandom;
                        };
                        case "RocketLauncher": { 
                            _weapon = B52_RocketLaunchers call bis_fnc_selectRandom;
                        };
                        case "Rifle": { 
                            _weapon = B52_AssaultRiflesG call bis_fnc_selectRandom;
                        };
                        case "SubmachineGun": { 
                            _weapon = B52_SubmachineGuns call bis_fnc_selectRandom;
                        };
                        case "SniperRifle": { 
                            _weapon = B52_SniperRifles call bis_fnc_selectRandom;
                        };
                        default { 
                            _weapon = B52_AssaultRifles call bis_fnc_selectRandom;
                        };
                    };
                    
                    _magazines     = getArray (configFile / "CfgWeapons" / _weapon / "magazines");
                    _magazineClass = _magazines call bis_fnc_selectRandom;
                    
                    _rndMagazineNum = ceil (random 2);
                    _holder addWeaponCargoGlobal [_weapon, 1];
                    
                    _magCount = count _magazines;
                    for "_i" from 1 to _magCount do 
                    {
                        _magazineClass = _magazines call bis_fnc_selectRandom;
                        
                        if (getnumber (configFile >> "CfgWeapons" >> _weapon >> "magazines" >> _magazineClass >> "scope") == 2) 
                        exitWith {
                            _holder addMagazineCargoGlobal [_magazineClass, _rndMagazineNum];
                        };
                    };
                    
                    if (_type == "magazine")
                    then {
                        _magazine = B52_Magazines call bis_fnc_selectRandom;
                        _holder addMagazineCargoGlobal [_magazine, _rndMagazineNum];
                    };
                };
            };
            
        };
        
        // Marker if enabled
        if (_showLoot)
        then {
            _id    = format ["%1", _pos];
            _debug = createMarker [_id, GETPOS _holder];
            _debug setMarkerShape "ICON";
            _debug setMarkerType "hd_dot";
            _debug setMarkerColor "ColorGreen";
            _debug setMarkerText _type;
        };
        
    };  // IsServer