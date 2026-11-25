#include "script_component.hpp"

if (isServer) then {
    [QGVAR(link), LINKFUNC(linkJammer)] call CBA_fnc_addEventHandler;
    [QGVAR(switch), LINKFUNC(handleSwitch)] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    // The terminal of fnc_osJammer waits for this
    [QGVAR(switchResult), {
        params ["_result"];
        GVAR(switchResult) = _result;
    }] call CBA_fnc_addEventHandler;

    call FUNC(zeusRegister);
};
