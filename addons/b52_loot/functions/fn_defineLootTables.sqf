// B52 Loot Tables - Default vanilla Arma 3 item definitions
// Override any array in your mission init.sqf (before module activation) for custom loot.
// Each array is only set if not already defined, so mission-level overrides are preserved.

if (!isServer) exitWith {};

// === Building Classification ===
// Keywords matched against building classnames to identify military/industrial structures
if (isNil "B52_MilitaryKeywords") then {
    B52_MilitaryKeywords = ["_Mil_", "_Barrack", "_Cargo_HQ", "_Cargo_Patrol", "_Cargo_Tower"];
};
if (isNil "B52_IndustrialKeywords") then {
    B52_IndustrialKeywords = ["_Factory_", "_Ind_", "_PowerStation", "_Workshop", "_FuelStation", "_dp_"];
};

// === Feature Flags ===
// Set B52_HeroesEnabled = true in mission init.sqf if using a mod that provides food items
if (isNil "B52_HeroesEnabled") then {
    B52_HeroesEnabled = false;
};

// === Weapon Types (weighted by frequency) ===
if (isNil "B52_WeaponTypes") then {
    B52_WeaponTypes = [
        "AssaultRifle", "AssaultRifle", "AssaultRifle",
        "Handgun", "Handgun",
        "MachineGun",
        "Rifle",
        "SubmachineGun", "SubmachineGun",
        "SniperRifle",
        "RocketLauncher"
    ];
};

// === Weapons ===
if (isNil "B52_AssaultRifles") then {
    B52_AssaultRifles = [
        "arifle_MX_F", "arifle_MX_Black_F",
        "arifle_MXC_F", "arifle_MXC_Black_F",
        "arifle_Katiba_F", "arifle_Katiba_C_F",
        "arifle_TRG21_F", "arifle_TRG20_F",
        "arifle_Mk20_F", "arifle_Mk20C_F",
        "arifle_SDAR_F"
    ];
};

if (isNil "B52_AssaultRiflesGL") then {
    B52_AssaultRiflesGL = [
        "arifle_MX_GL_F", "arifle_MX_GL_Black_F",
        "arifle_Katiba_GL_F",
        "arifle_Mk20_GL_F"
    ];
};

if (isNil "B52_Handguns") then {
    B52_Handguns = [
        "hgun_P07_F", "hgun_Rook40_F", "hgun_ACPC2_F",
        "hgun_Pistol_heavy_01_F", "hgun_Pistol_heavy_02_F"
    ];
};

if (isNil "B52_MachineGuns") then {
    B52_MachineGuns = [
        "LMG_Mk200_F", "LMG_Zafir_F",
        "arifle_MX_SW_F", "arifle_MX_SW_Black_F"
    ];
};

if (isNil "B52_SniperRifles") then {
    B52_SniperRifles = [
        "srifle_EBR_F", "srifle_GM6_F", "srifle_LRR_F",
        "srifle_DMR_01_F"
    ];
};

if (isNil "B52_SubmachineGuns") then {
    B52_SubmachineGuns = [
        "SMG_01_F", "SMG_02_F", "hgun_PDW2000_F"
    ];
};

if (isNil "B52_RocketLaunchers") then {
    B52_RocketLaunchers = [
        "launch_RPG32_F", "launch_NLAW_F"
    ];
};

if (isNil "B52_MissileLaunchers") then {
    B52_MissileLaunchers = [
        "launch_Titan_F", "launch_Titan_short_F",
        "launch_B_Titan_F", "launch_O_Titan_F", "launch_I_Titan_F",
        "launch_B_Titan_short_F", "launch_O_Titan_short_F", "launch_I_Titan_short_F"
    ];
};

// === Equipment ===
if (isNil "B52_Vests") then {
    B52_Vests = [
        "V_PlateCarrier1_rgr", "V_PlateCarrier2_rgr", "V_PlateCarrierGL_rgr",
        "V_TacVest_khk", "V_TacVest_oli", "V_TacVest_brn",
        "V_Chestrig_khk", "V_Chestrig_rgr",
        "V_BandollierB_khk", "V_BandollierB_rgr",
        "V_HarnessO_brn", "V_HarnessOGL_brn"
    ];
};

if (isNil "B52_Backpacks") then {
    B52_Backpacks = [
        "B_AssaultPack_khk", "B_AssaultPack_dgtl", "B_AssaultPack_rgr",
        "B_AssaultPack_sgg", "B_AssaultPack_cbr",
        "B_Kitbag_mcamo", "B_Kitbag_sgg", "B_Kitbag_cbr",
        "B_Bergen_sgg", "B_Bergen_mcamo",
        "B_TacticalPack_oli", "B_TacticalPack_rgr",
        "B_FieldPack_khk", "B_FieldPack_ocamo", "B_FieldPack_cbr",
        "B_Carryall_khk", "B_Carryall_ocamo", "B_Carryall_mcamo"
    ];
};

if (isNil "B52_Clothes") then {
    B52_Clothes = [
        "U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_vest",
        "U_O_CombatUniform_ocamo", "U_O_CombatUniform_oucamo",
        "U_I_CombatUniform", "U_I_CombatUniform_shortsleeve",
        "U_BG_Guerilla1_1", "U_BG_Guerilla2_1", "U_BG_Guerilla3_1",
        "U_C_Poloshirt_blue", "U_C_Poloshirt_burgundy", "U_C_Poloshirt_salmon",
        "U_C_Poor_1", "U_C_Poor_2",
        "U_C_HunterBody_grn", "U_Rangemaster"
    ];
};

// === Consumables ===
if (isNil "B52_Magazines") then {
    B52_Magazines = [
        "30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag_Tracer",
        "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag_Tracer_Red",
        "30Rnd_45ACP_Mag_SMG_01", "30Rnd_9x21_Mag",
        "16Rnd_9x21_Mag", "11Rnd_45ACP_Mag", "9Rnd_45ACP_Mag",
        "200Rnd_65x39_cased_Box", "200Rnd_65x39_cased_Box_Tracer",
        "150Rnd_762x54_Box", "150Rnd_762x54_Box_Tracer",
        "20Rnd_762x51_Mag", "7Rnd_408_Mag", "5Rnd_127x108_Mag",
        "10Rnd_762x54_Mag"
    ];
};

if (isNil "B52_Attachments") then {
    B52_Attachments = [
        "optic_Aco", "optic_ACO_grn",
        "optic_Hamr", "optic_Holosight", "optic_Holosight_smg",
        "optic_MRCO", "optic_Arco",
        "optic_SOS", "optic_LRPS", "optic_DMS", "optic_NVS",
        "acc_flashlight", "acc_pointer_IR",
        "muzzle_snds_H", "muzzle_snds_L", "muzzle_snds_B", "muzzle_snds_acp",
        "bipod_01_F_blk", "bipod_01_F_snd", "bipod_02_F_blk", "bipod_03_F_blk"
    ];
};

if (isNil "B52_Items") then {
    B52_Items = [
        "ItemMap", "ItemCompass", "ItemWatch", "ItemGPS", "ItemRadio",
        "NVGoggles", "NVGoggles_OPFOR", "NVGoggles_INDEP",
        "Binocular", "Rangefinder",
        "FirstAidKit", "Medikit", "ToolKit", "MineDetector"
    ];
};

// Food items require a companion mod (e.g., Heroes Survive, Ravage, Exile)
// Override B52_Food in your mission init.sqf with your mod's food classnames
if (isNil "B52_Food") then {
    B52_Food = [];
};
