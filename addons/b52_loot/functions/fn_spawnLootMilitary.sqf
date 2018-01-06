private ["_type"];
if (isServer) 
    then {
        _pos      = (_this select 0);
        _showLoot = (_this select 1);
        
        _holder = createVehicle ["GroundWeaponHolder", [_pos select 0, _pos select 1, (_pos select 2) + 0.2], [], 0, "can_Collide"];
        [_holder, _pos] call B52_Loot_Module_fnc_lootPosInHouse;
        
        _type = floor (random 3);
        
        if (_showLoot)
        then {
            _id    = format ["%1", _pos];
            _debug = createMarker [_id, GETPOS _holder];
            _debug setMarkerShape "ICON";
            _debug setMarkerType "hd_dot";
            _debug setMarkerColor "ColorRed";
            _txt = format ["%1", _type];
            
            // Spawn Weapon
            if (_type == 0)
            then {
                _debug setMarkerText "Weapon";
            };
            
            // Spawn Magazines
            if (_type == 1)
            then {
                _debug setMarkerText "Magazine";
            };
            
            // Spawn Vests
            if (_type == 2)
            then {
                _debug setMarkerText "Vest";
            };
        };
        
        // Spawn Weapon
        if (_type == 0)
        then {
            _weapon = B52_AssaultRifles call bis_fnc_selectRandom;

            _magazines     = getArray (configFile / "CfgWeapons" / _weapon / "magazines");
            _magazineClass = _magazines call bis_fnc_selectRandom;
            
            _holder addWeaponCargoGlobal [_weapon, 1];
            _magCount = count _magazines;
            for "_i" from 1 to _magCount do 
            {
                _magazineClass = _magazines call bis_fnc_selectRandom;
                
                if (getnumber (configFile >> "CfgWeapons" >> _weapon >> "magazines" >> _magazineClass >> "scope") == 2) 
                exitWith {
                    _holder addMagazineCargoGlobal [_magazineClass, 2];
                };
            };
        };
        
        // Spawn Magazines
        if (_type == 1)
        then {
            _weapon        = B52_AssaultRifles call bis_fnc_selectRandom;
            _magazines     = getArray (configFile / "CfgWeapons" / _weapon / "magazines");
            _magazineClass = _magazines call bis_fnc_selectRandom;

            _holder addMagazineCargoGlobal [_magazineClass, 2];
        };
        
        // Spawn Vests
        if (_type == 2)
        then {
            _vest = B52_Vests call bis_fnc_selectRandom;
            _holder addItemCargoGlobal [_vest, 1];
        };
        
    };  // IsServer