#include "..\script_component.hpp"
/*
 * Author: Andx
 * Progress bar for picking up a deployed dish. The dish is marked as in use meanwhile, so nobody else picks it up.
 *
 * Arguments:
 * 0: Dish <OBJECT>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, player] call ewc_satcom_fnc_startPickUp
 *
 * Public: No
 */

params [["_dish", objNull, [objNull]], ["_unit", objNull, [objNull]]];

_dish setVariable [QGVAR(inUse), true, true];
[_unit, WORK_ANIMATION] call ace_common_fnc_doAnimation;

[
    PICKUP_TIME,
    [_dish, _unit],
    {
        (_this select 0) params ["_dish", "_unit"];
        [_unit, "", 2] call ace_common_fnc_doAnimation;
        [QGVAR(pickUp), [_dish, _unit]] call CBA_fnc_serverEvent;
    },
    {
        (_this select 0) params ["_dish", "_unit"];
        [_unit, "", 2] call ace_common_fnc_doAnimation;
        _dish setVariable [QGVAR(inUse), false, true];
    },
    LLSTRING(progress_pickUp),
    {
        alive ((_this select 0) select 0)
    }
] call ace_common_fnc_progressBar;
