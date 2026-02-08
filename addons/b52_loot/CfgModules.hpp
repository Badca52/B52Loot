#define true 1
#define false 0

class Logic;

class Module_F : Logic
{
    class AttributesBase
    {
        class Default;
        class Edit; // Default edit box (i.e., text input field)
        class Combo; // Default combo box (i.e., drop-down menu)
    };
};

class B52_Loot_Module : Module_F
{
    scope              = 2;
    author             = "Badca52";
    displayName        = "B52 Loot System";
    category           = "B52";
    function           = "B52_Loot_Module_fnc_init";
    icon               = "\b52_loot\52.paa";
    functionPriority   = 2;
    isGlobal           = 0;
    isTriggerActivated = 0;

    class Attributes : AttributesBase
    {
        class lootProbability : Edit
        {
            property     = "LootProbability";
            displayName  = "Loot Probability";
            description  = "Probability that loot will spawn at each building position (0-100)";
            typeName     = "NUMBER";
            defaultValue = "15";
        };

        class showMarkers : Combo
        {
            property     = "ShowLootMarkers";
            displayName  = "Show Markers";
            description  = "Show debug markers at loot spawn locations";
            typeName     = "BOOL";
            defaultValue = "false";

            class Values
            {
                class Enable
                {
                    name  = "Enabled";
                    value = true;
                };
                class Disable
                {
                    name = "Disabled";
                    value = false;
                };
            };
        };
    };
};
