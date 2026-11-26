#include "..\script_component.hpp"
/*
 * Author: Andx
 * Condition of the pick up action: the dish was deployed from an item, is intact and nobody is picking it up.
 *
 * Arguments:
 * 0: Dish <OBJECT>
 *
 * Return Value:
 * Can be picked up <BOOL>
 *
 * Example:
 * [cursorObject] call ewc_satcom_fnc_canPickUp
 *
 * Public: No
 */

params [["_dish", objNull, [objNull]]];

alive _dish && {(_dish getVariable [QGVAR(item), ""]) != ""} && {!(_dish getVariable [QGVAR(inUse), false])}
