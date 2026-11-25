#include "..\script_component.hpp"
/*
 * Author: Andx
 * Returns the jammers a laptop may switch: Crows jammers linked to a router of the network the laptop is in. The
 * vehicle jammers of the compat addons (ewc_common_isJammer) are left out, they have a crew switch of their own.
 * Any machine, every machine has a copy of the jammer map of Crows.
 *
 * Arguments:
 * 0: Laptop <OBJECT>
 *
 * Return Value:
 * Jammers, sorted by their id <ARRAY> of <OBJECT>
 *
 * Example:
 * [_laptop] call ewc_jammer_control_fnc_getJammers
 *
 * Public: No
 */

params [["_laptop", objNull, [objNull]]];

private _parents = call FUNC(getNetworkParents);
private _root = [_laptop, _parents] call FUNC(getNetworkRoot);

// A laptop in no network controls nothing
if (_root isEqualTo _laptop) exitWith {[]};

private _jammers = (values (missionNamespace getVariable [CROWS_VAR_JAM_MAP, createHashMap])) apply {_x select 0} select {
    private _router = _x getVariable [QGVAR(router), objNull];

    !isNull _x
    && {!isNull _router}
    && {!(_x getVariable [QEGVAR(common,isJammer), false])}
    && {([_router, _parents] call FUNC(getNetworkRoot)) isEqualTo _root}
};

[_jammers, [], {_x getVariable [QGVAR(id), 0]}] call BIS_fnc_sortBy
