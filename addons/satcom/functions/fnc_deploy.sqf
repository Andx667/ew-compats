#include "..\script_component.hpp"
/*
 * Author: Andx
 * Takes the dish item from the unit and creates the dish. The server makes it a satcom (fnc_handleDeployed).
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Dish item <STRING>
 * 2: Object the dish deploys as <STRING>
 * 3: Position ASL <ARRAY>
 * 4: Vector dir and up <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "ewc_satcom_dish_olive", "SatelliteAntenna_01_Small_Olive_F", getPosASL player, [vectorDir player, vectorUp player]] call ewc_satcom_fnc_deploy
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]], ["_item", "", [""]], ["_object", "", [""]], ["_posASL", [0, 0, 0], [[]], 3], ["_vectorDirAndUp", [[0, 1, 0], [0, 0, 1]], [[]], 2]];

[_unit, "", 2] call ace_common_fnc_doAnimation;

if !(_item in (items _unit)) exitWith {};

_unit removeItem _item;

private _dish = createVehicle [_object, [0, 0, 0], [], 0, "CAN_COLLIDE"];
_dish setPosASL _posASL;
_dish setVectorDirAndUp _vectorDirAndUp;

[QGVAR(deployed), [_dish, _item]] call CBA_fnc_serverEvent;
