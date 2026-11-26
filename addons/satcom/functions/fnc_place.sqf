#include "..\script_component.hpp"
/*
 * Author: Andx, ACE Team
 * Shows a local ghost of the dish in front of the player that follows the view and turns with the mouse wheel. The
 * left mouse button places it (fnc_startDeploy), the right one cancels. Ported from the deployable tarps of Tactical
 * Tarps, which follow the placement of ACE. The confirm action is a plain addAction on DefaultAction (what ACE does
 * inside its non-public addActionEventHandler), so the click does not fire the weapon.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Dish item <STRING>
 * 2: Object the dish deploys as <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "ewc_satcom_dish_olive", "SatelliteAntenna_01_Small_Olive_F"] call ewc_satcom_fnc_place
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]], ["_item", "", [""]], ["_object", "", [""]]];

if (isNull _unit || {GVAR(placeState) == PLACE_WAITING}) exitWith {};

private _ghost = _object createVehicleLocal [0, 0, 0];
_ghost enableSimulation false;
_ghost allowDamage false;
_ghost disableCollisionWith _unit;

(boundingBoxReal _ghost) params ["_bbMin", "_bbMax"];
private _distance = (((_bbMax select 0) - (_bbMin select 0)) max ((_bbMax select 1) - (_bbMin select 1))) / 2 + 1.5;

private _updateGhost = {
    private _posASL = (eyePos _unit) vectorAdd ((getCameraViewDirection _unit) vectorMultiply _distance);
    _posASL set [2, getTerrainHeightASL _posASL];

    _ghost setPosASL _posASL;
    _ghost setDir (GVAR(placeRotation) + getDir _unit);
    _ghost setVectorUp (surfaceNormal _posASL);
};

GVAR(placeState) = PLACE_WAITING;
GVAR(placeRotation) = 0;
call _updateGhost;

hintSilent parseText format ["%1<br/>%2<br/>%3", LLSTRING(place_confirm), LLSTRING(place_cancel), LLSTRING(place_rotate)];

// Only the key itself confirms, like ACE, not choosing the empty entry in the scroll menu
private _confirmId = _unit addAction ["", {
    if (inputAction "DefaultAction" > 0) then {GVAR(placeState) = PLACE_APPROVE};
}, nil, -1, false, true, "DefaultAction", QUOTE(GVAR(placeState) == PLACE_WAITING)];

private _display = findDisplay 46;
private _rotateId = _display displayAddEventHandler ["MouseZChanged", {
    params ["", "_delta"];
    GVAR(placeRotation) = GVAR(placeRotation) + _delta * PLACE_ROTATE_STEP;
    true
}];

// Consumed here, so the right mouse button cancels instead of raising the weapon
private _cancelId = _display displayAddEventHandler ["MouseButtonDown", {
    params ["", "_button"];
    if (_button == 1) then {GVAR(placeState) = PLACE_CANCEL};
    _button == 1
}];

[{
    params ["_args", "_handle"];
    _args params ["_unit", "_item", "_ghost", "_confirmId", "_display", "_rotateId", "_cancelId", "_updateGhost", "_distance"];

    if (_unit != ACE_player || {!alive _unit} || {isNull _ghost} || {!(_item in (items _unit))}) then {
        GVAR(placeState) = PLACE_CANCEL;
    };

    // Reject the spot but keep placing, so the player can try another one
    if (GVAR(placeState) == PLACE_APPROVE && {surfaceIsWater getPosASL _ghost}) then {
        [LLSTRING(error_water), true] call ace_common_fnc_displayText;
        GVAR(placeState) = PLACE_WAITING;
    };

    if (GVAR(placeState) != PLACE_WAITING) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;

        hintSilent "";
        _unit removeAction _confirmId;
        _display displayRemoveEventHandler ["MouseZChanged", _rotateId];
        _display displayRemoveEventHandler ["MouseButtonDown", _cancelId];

        if (GVAR(placeState) == PLACE_APPROVE) then {
            [_unit, _item, typeOf _ghost, getPosASL _ghost, [vectorDir _ghost, vectorUp _ghost]] call FUNC(startDeploy);
        };

        deleteVehicle _ghost;
    };

    call _updateGhost;
}, 0, [_unit, _item, _ghost, _confirmId, _display, _rotateId, _cancelId, _updateGhost, _distance]] call CBA_fnc_addPerFrameHandler;
