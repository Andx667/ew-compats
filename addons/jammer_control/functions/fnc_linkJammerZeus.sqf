#include "..\script_component.hpp"
/*
 * Author: Andx
 * Zeus module, placed on a jammer: a dialog to pick the AE3 router it is linked to (nearest first, or none to
 * unlink) and the name shown in the terminal.
 *
 * Arguments:
 * 0: Position ASL <ARRAY>
 * 1: Object the module was placed on <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_pos, _jammer] call ewc_jammer_control_fnc_linkJammerZeus
 *
 * Public: No
 */

params [["_pos", [0, 0, 0], [[]], 3], ["_jammer", objNull, [objNull]]];

if (isNull _jammer || {!(netId _jammer in (missionNamespace getVariable [CROWS_VAR_JAM_MAP, createHashMap]))}) exitWith {
    [LLSTRING(zeus_noJammer)] call zen_common_fnc_showMessage;
};

// The vehicle jammers of the compat addons keep their crew switch, fnc_getJammers leaves them out
if (_jammer getVariable [QEGVAR(common,isJammer), false]) exitWith {
    [LLSTRING(zeus_vehicleJammer)] call zen_common_fnc_showMessage;
};

private _routers = [call AE3_network_fnc_getRouters, [], {_x distance _jammer}] call BIS_fnc_sortBy;

if (_routers isEqualTo []) exitWith {
    [LLSTRING(zeus_noRouter)] call zen_common_fnc_showMessage;
};

private _current = _jammer getVariable [QGVAR(router), objNull];
private _values = [-1];
private _labels = [LLSTRING(zeus_unlink)];
{
    _values pushBack _forEachIndex;
    _labels pushBack format [LLSTRING(zeus_routerLabel), getText (configOf _x >> "displayName"), mapGridPosition _x, round (_x distance _jammer)];
} forEach _routers;
// The current router, or None for an unlinked jammer, so OK without a choice changes nothing
private _selected = (_routers find _current) + 1;

[
    LLSTRING(module_displayName),
    [
        ["COMBO", [LLSTRING(zeus_router), LLSTRING(zeus_router_tooltip)], [_values, _labels, _selected]],
        ["EDIT", [LLSTRING(zeus_name), LLSTRING(zeus_name_tooltip)], [_jammer getVariable [QGVAR(name), ""]]]
    ],
    {
        params ["_dialogResult", "_args"];
        _dialogResult params ["_index", "_name"];
        _args params ["_jammer", "_routers"];

        [_jammer, [objNull, _routers select _index] select (_index >= 0), _name] call FUNC(linkJammer);
    },
    {},
    [_jammer, _routers]
] call zen_dialog_fnc_create;
