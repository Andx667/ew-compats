#include "script_component.hpp"

if (isServer) then {
    [QGVAR(ecmToggled), LINKFUNC(handleToggle)] call CBA_fnc_addEventHandler;
    [QGVAR(satcomToggle), LINKFUNC(handleSatcomToggle)] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    [SATCOM_ID] call EFUNC(common,addAceSwitchActions);
};
