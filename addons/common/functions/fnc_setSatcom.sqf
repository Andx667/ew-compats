#include "..\script_component.hpp"
/*
 * Author: Andx
 * Makes an object a satcom of Crows Electronic Warfare or stops it. Players within the radius get a boosted radio
 * signal and cannot be jammed. Crows keeps one entry per object, so enabling an object again only changes its
 * radius. Crows removes the satcom of a destroyed or deleted object by itself.
 * SERVER ONLY.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Satcom enabled <BOOL> (default: false)
 * 2: Radius in m <NUMBER> (default: 20)
 *
 * Return Value:
 * None
 *
 * The radius of an active satcom is in the public variable ewc_common_satcomRadius of the object (nil while off).
 *
 * Example:
 * [_dish, true, 20] call ewc_common_fnc_setSatcom
 *
 * Public: Yes
 */

params [["_object", objNull, [objNull]], ["_enabled", false, [false]], ["_radius", 20, [0]]];

if (isNull _object || {!isServer}) exitWith {};

// Editor-placed objects are set before Crows has registered its server event handlers
if (CBA_missionTime <= 0) exitWith {
    [{CBA_missionTime > 0}, {_this call FUNC(setSatcom)}, [_object, _enabled, _radius]] call CBA_fnc_waitUntilAndExecute;
};

if (!_enabled) exitWith {
    if (isNil {_object getVariable QGVAR(satcomRadius)}) exitWith {};

    _object setVariable [QGVAR(satcomRadius), nil, true];
    [CROWS_EVENT_REMOVE_SATCOM, [[netId _object]]] call CBA_fnc_localEvent;
};

if (_radius <= 0) exitWith {
    WARNING_1("Satcom radius must be positive, got %1",_radius);
};

_object setVariable [QGVAR(satcomRadius), _radius, true];
[CROWS_EVENT_ADD_SATCOM, [_object, _radius]] call CBA_fnc_localEvent;
