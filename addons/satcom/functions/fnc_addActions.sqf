#include "..\script_component.hpp"
/*
 * Author: Andx
 * Adds the ACE actions of the dishes: a self-action under Equipment with one child per dish item the player carries,
 * and the pick up action on every class a dish deploys as. Run once on every machine with an interface.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call ewc_satcom_fnc_addActions
 *
 * Public: No
 */

private _deploy = [
    QGVAR(deploy),
    LLSTRING(action_deploy),
    "\a3\ui_f\data\igui\cfg\simpletasks\types\radio_ca.paa",
    {},
    {
        private _items = items _player;
        GVAR(enable) && {GVAR(placeState) != PLACE_WAITING} && {GVAR(dishes) findIf {(_x select 0) in _items} != -1}
    }
] call ace_interact_menu_fnc_createAction;

["CAManBase", 1, ["ACE_SelfActions", "ACE_Equipment"], _deploy, true] call ace_interact_menu_fnc_addActionToClass;

{
    _x params ["_item"];
    private _config = configFile >> "CfgWeapons" >> _item;

    private _action = [
        format ["%1_%2", QGVAR(deploy), _item],
        getText (_config >> "displayName"),
        getText (_config >> "picture"),
        {[_player, (_this select 2) select 0, (_this select 2) select 1] call FUNC(place)},
        {((_this select 2) select 0) in (items _player)},
        {},
        _x
    ] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(deploy)], _action, true] call ace_interact_menu_fnc_addActionToClass;
} forEach GVAR(dishes);

private _pickUp = [
    QGVAR(pickUp),
    LLSTRING(action_pickUp),
    "\a3\ui_f\data\igui\cfg\actions\take_ca.paa",
    {[_target, _player] call FUNC(startPickUp)},
    {[_target] call FUNC(canPickUp)}
] call ace_interact_menu_fnc_createAction;

{
    [_x, 0, ["ACE_MainActions"], _pickUp] call ace_interact_menu_fnc_addActionToClass;
} forEach ((GVAR(dishes) apply {_x select 1}) arrayIntersect (GVAR(dishes) apply {_x select 1}));
