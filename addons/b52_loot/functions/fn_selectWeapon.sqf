// Selects a random weapon classname based on the given weapon type string.
// Returns: weapon classname (String)
params ["_weaponType"];

private _weapon = "";

switch (_weaponType) do {
    case "AssaultRifle":    { _weapon = selectRandom B52_AssaultRifles; };
    case "Handgun":         { _weapon = selectRandom B52_Handguns; };
    case "MachineGun":      { _weapon = selectRandom B52_MachineGuns; };
    case "MissileLauncher": { _weapon = selectRandom B52_MissileLaunchers; };
    case "RocketLauncher":  { _weapon = selectRandom B52_RocketLaunchers; };
    case "Rifle":           { _weapon = selectRandom B52_AssaultRiflesGL; };
    case "SubmachineGun":   { _weapon = selectRandom B52_SubmachineGuns; };
    case "SniperRifle":     { _weapon = selectRandom B52_SniperRifles; };
    default                 { _weapon = selectRandom B52_AssaultRifles; };
};

_weapon
