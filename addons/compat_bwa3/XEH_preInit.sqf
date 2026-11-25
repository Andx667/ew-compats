#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

// Dingos whose satcom is on, watched by fnc_satcomLoop on the server while there are any
GVAR(satcomVehicles) = [];
GVAR(satcomLoop) = -1;

// The crew switches the satcom of a Dingo without a CG13 with the actions of ewc_common
[
    SATCOM_ID,
    QGVAR(satcomToggle),
    QGVAR(satcomOn),
    {([_this select 0] call FUNC(getSatcomBlockReason)) isEqualTo ""},
    QUOTE(STR_ewc_compat_bwa3_satcom_activate),
    QUOTE(STR_ewc_compat_bwa3_satcom_deactivate),
    {HAS_SATCOM(_this select 0)}
] call EFUNC(common,registerSwitch);

#include "initSettings.inc.sqf"

// Before the vehicles initialise, so editor-placed ones are not missed
[QEGVAR(common,vehicleInit), LINKFUNC(initVehicle)] call CBA_fnc_addEventHandler;

ADDON = true;
