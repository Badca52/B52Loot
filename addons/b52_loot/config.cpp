class CfgPatches
{
    class B52_Loot
    {
        name      = "Badca52's Loot System";
        author    = "Badca52";
        authorUrl = "https://github.com/Badca52";

        version         = "0.30";
        requiredVersion = 1.60;
        requiredAddons[] = {"cba_main"};
        units[]   = {};
        weapons[] = {};
    };
};

class CfgFunctions
{
    #include "CfgFunctions.hpp"
};

class CfgFactionClasses
{
    class NO_CATEGORY;
    class B52: NO_CATEGORY
    {
        displayName = "B52";
    };
};

#include "CfgVehicles.hpp"