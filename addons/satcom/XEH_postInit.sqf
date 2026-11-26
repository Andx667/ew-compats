#include "script_component.hpp"

if (isServer) then {
    [QGVAR(deployed), LINKFUNC(handleDeployed)] call CBA_fnc_addEventHandler;
    [QGVAR(pickUp), LINKFUNC(handlePickUp)] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    // The server hands the item of a picked up dish back to the player who picked it up
    [QGVAR(returnItem), {
        params ["_unit", "_item"];
        [_unit, _item] call ace_common_fnc_addToInventory;
    }] call CBA_fnc_addEventHandler;

    call FUNC(addActions);
};
