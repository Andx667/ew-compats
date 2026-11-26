#include "..\script_component.hpp"
/*
 * Author: Andx
 * A dish was deployed: remembers its item for the pick up and makes it a satcom with the radius of the setting.
 * SERVER ONLY.
 *
 * Arguments:
 * 0: Dish <OBJECT>
 * 1: Dish item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_dish, "ewc_satcom_dish_olive"] call ewc_satcom_fnc_handleDeployed
 *
 * Public: No
 */

params [["_dish", objNull, [objNull]], ["_item", "", [""]]];

if (isNull _dish || {_item == ""}) exitWith {};

// Public: it marks a deployed dish, only those can be picked up (fnc_canPickUp)
_dish setVariable [QGVAR(item), _item, true];

[_dish, true, GVAR(radius)] call EFUNC(common,setSatcom);
