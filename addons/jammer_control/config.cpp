#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            QGVAR(moduleLinkJammer)
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ewc_main", "A3_Modules_F", "crowsEW_main", "crowsEW_editormodules", "zen_custom_modules", "zen_dialog", "ae3_main", "ae3_network", "ae3_armaos", "ae3_power"};
        author = AUTHOR;
        authors[] = {"Andx"};
        url = "https://github.com/Andx667/EW-Compats";
        VERSION_CONFIG;

        skipWhenMissingDependencies = 1;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgOsFunctions.hpp"
#include "CfgVehicles.hpp"
