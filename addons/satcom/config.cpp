#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {QGVAR(dish_black), QGVAR(dish_olive), QGVAR(dish_sand)};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ewc_main", "ewc_common", "crowsEW_main", "ace_common", "ace_interact_menu", "ace_interaction","A3_Props_F_Enoch_Military_Equipment"};
        author = AUTHOR;
        authors[] = {"Andx"};
        url = "https://github.com/Andx667/EW-Compats";
        VERSION_CONFIG;

        skipWhenMissingDependencies = 1;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgWeapons.hpp"
