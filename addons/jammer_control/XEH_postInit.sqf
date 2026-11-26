#include "script_component.hpp"

if (isServer) then {
    [QGVAR(link), LINKFUNC(linkJammer)] call CBA_fnc_addEventHandler;
    [QGVAR(switch), LINKFUNC(handleSwitch)] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    // The terminal of fnc_osJammer waits for this. A late answer to a switch that timed out belongs to an older
    // request and is dropped
    [QGVAR(switchResult), {
        params [["_result", "", [""]], ["_requestId", -1, [0]]];

        if (_requestId == GVAR(requestId)) then {
            GVAR(switchResult) = _result;
        };
    }] call CBA_fnc_addEventHandler;

    call FUNC(zeusRegister);
};
