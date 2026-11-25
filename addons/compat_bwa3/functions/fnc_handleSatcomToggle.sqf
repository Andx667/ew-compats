#include "..\script_component.hpp"
/*
 * Author: Andx
 * Switches the satcom of a Dingo without a CG13, from the crew's switch or from fnc_satcomLoop when it is blocked.
 * While it is on, fnc_satcomLoop watches the engine and the speed.
 * SERVER ONLY.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Switch on <BOOL>
 * 2: Why it switched itself off, shown in the hint <STRING> (default: "")
 *
 * Return Value:
 * None
 *
 * Example:
 * [_dingo, true] call ewc_compat_bwa3_fnc_handleSatcomToggle
 *
 * Public: No
 */

params [["_vehicle", objNull, [objNull]], ["_turnOn", false, [false]], ["_reason", "", [""]]];

if (isNull _vehicle || {!HAS_SATCOM(_vehicle)}) exitWith {};

if (_turnOn isEqualTo (_vehicle getVariable [QGVAR(satcomOn), false])) exitWith {};

if (_turnOn && {([_vehicle] call FUNC(getSatcomBlockReason)) isNotEqualTo ""}) exitWith {};

_vehicle setVariable [QGVAR(satcomOn), _turnOn, true];

// A destroyed vehicle has nobody to tell
if (alive _vehicle) then {
    [_vehicle, SATCOM_NAME, _turnOn, _reason] call EFUNC(common,notifyState);
};

[_vehicle, _turnOn, GVAR(satcomRadius)] call EFUNC(common,setSatcom);

if (_turnOn) then {
    GVAR(satcomVehicles) pushBackUnique _vehicle;

    if (GVAR(satcomLoop) == -1) then {
        GVAR(satcomLoop) = [LINKFUNC(satcomLoop), SATCOM_INTERVAL] call CBA_fnc_addPerFrameHandler;
    };
} else {
    GVAR(satcomVehicles) deleteAt (GVAR(satcomVehicles) find _vehicle);
};
