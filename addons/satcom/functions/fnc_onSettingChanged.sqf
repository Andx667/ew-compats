#include "..\script_component.hpp"
/*
 * Author: Andx
 * Switches the satcom of every deployed dish on or off when the setting enable changes in the game. Disabled dishes
 * stay standing as props, so players can still pick them up and get their items back.
 * Called by the setting. Nothing to do at the start, no dish is deployed yet.
 * SERVER ONLY.
 *
 * Arguments:
 * 0: Enabled <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [false] call ewc_satcom_fnc_onSettingChanged
 *
 * Public: No
 */

params [["_enabled", true, [true]]];

if (!isServer || {CBA_missionTime <= 0}) exitWith {};

// Crow's removes the satcom of a destroyed or deleted dish itself, those must not get it back
GVAR(deployedDishes) = GVAR(deployedDishes) select {alive _x};

{
    [_x, _enabled, GVAR(radius)] call EFUNC(common,setSatcom);
} forEach GVAR(deployedDishes);
