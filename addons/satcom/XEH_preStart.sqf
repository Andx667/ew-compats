#include "script_component.hpp"

#include "XEH_PREP.hpp"

// Items that deploy as a dish, [item, object], read once per game start instead of once per mission
private _dishes = ("true" configClasses (configFile >> "CfgWeapons")) select {
    isText (_x >> QGVAR(object)) && {getNumber (_x >> "scope") == 2}
} apply {
    [configName _x, getText (_x >> QGVAR(object))]
};

uiNamespace setVariable [QGVAR(dishes), compileFinal str _dishes];
