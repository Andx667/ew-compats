#include "..\script_component.hpp"
/*
 * Author: Andx
 * Progress bar for deploying a dish on the spot chosen with fnc_place. Fails when the item is no longer in the
 * inventory.
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
 * [player, "ewc_satcom_dish_olive", "SatelliteAntenna_01_Small_Olive_F", getPosASL player, [vectorDir player, vectorUp player]] call ewc_satcom_fnc_startDeploy
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]], ["_item", "", [""]], ["_object", "", [""]], ["_posASL", [0, 0, 0], [[]], 3], ["_vectorDirAndUp", [[0, 1, 0], [0, 0, 1]], [[]], 2]];

[_unit, WORK_ANIMATION] call ace_common_fnc_doAnimation;

[
    DEPLOY_TIME,
    [_unit, _item, _object, _posASL, _vectorDirAndUp],
    {
        (_this select 0) call FUNC(deploy);
    },
    {
        [(_this select 0) select 0, "", 2] call ace_common_fnc_doAnimation;
    },
    LLSTRING(progress_deploy),
    {
        (_this select 0) params ["_unit", "_item"];
        _item in (items _unit)
    }
] call ace_common_fnc_progressBar;
