#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

// Items that deploy as a dish, [item, object], see XEH_preStart
GVAR(dishes) = call (uiNamespace getVariable [QGVAR(dishes), {[]}]);

// Placement of the ghost dish on this client, see fnc_place
GVAR(placeState) = PLACE_CANCEL;
GVAR(placeRotation) = 0;

// Deployed dishes on the server, so switching the addon on or off reaches the ones already standing
if (isServer) then {
    GVAR(deployedDishes) = [];
};

#include "initSettings.inc.sqf"

ADDON = true;
