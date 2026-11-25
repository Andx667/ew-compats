#include "..\script_component.hpp"
/*
 * Author: Andx
 * Per frame handler on the server while the satcom of a Dingo is on: switches it off when the engine stops, the
 * vehicle moves, it is destroyed or the setting is turned off. BWA3 has no event for the engine of a Dingo without
 * a CG13 and there is none for moving, and isEngineOn and speed are synced to the server, so one check here covers
 * all of them. Removes itself when no satcom is on.
 * SERVER ONLY.
 *
 * Arguments:
 * 0: Arguments of the handler (unused) <ARRAY>
 * 1: Handle of the handler <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ewc_compat_bwa3_fnc_satcomLoop, 1] call CBA_fnc_addPerFrameHandler
 *
 * Public: No
 */

params ["", "_handle"];

// A deleted vehicle is gone from Crows as well, only our list has to forget it
GVAR(satcomVehicles) = GVAR(satcomVehicles) - [objNull];

{
    private _reason = [_x] call FUNC(getSatcomBlockReason);

    if (_reason isNotEqualTo "") then {
        [_x, false, _reason] call FUNC(handleSatcomToggle);
    };
} forEach +GVAR(satcomVehicles);

if (GVAR(satcomVehicles) isEqualTo []) then {
    [_handle] call CBA_fnc_removePerFrameHandler;
    GVAR(satcomLoop) = -1;
};
