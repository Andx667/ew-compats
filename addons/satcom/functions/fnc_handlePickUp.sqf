#include "..\script_component.hpp"
/*
 * Author: Andx
 * A dish was picked up: stops the satcom, deletes the dish and gives its item to the unit. Done here and not on the
 * client, so a dish that two players finish picking up at the same time only gives one item.
 * SERVER ONLY.
 *
 * Arguments:
 * 0: Dish <OBJECT>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_dish, _unit] call ewc_satcom_fnc_handlePickUp
 *
 * Public: No
 */

params [["_dish", objNull, [objNull]], ["_unit", objNull, [objNull]]];

private _item = _dish getVariable [QGVAR(item), ""];

if (isNull _dish || {_item == ""}) exitWith {};

_dish setVariable [QGVAR(item), nil, true];
[_dish, false] call EFUNC(common,setSatcom);
deleteVehicle _dish;

[QGVAR(returnItem), [_unit, _item], _unit] call CBA_fnc_targetEvent;
