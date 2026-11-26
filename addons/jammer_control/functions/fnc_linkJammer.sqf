#include "..\script_component.hpp"
/*
 * Author: Andx
 * Links a Crows jammer to an AE3 router, or unlinks it. Every laptop in the network of that router can then list
 * and switch the jammer with the terminal command "jammer", also over SSH. The jammer keeps a short id for the
 * terminal for the rest of the mission, also when it is linked again.
 * Any machine, the link is made on the server. A jammer that is not in the jammer map of Crows, a vehicle jammer of
 * the compat addons (ewc_common_isJammer) or a router that is not an AE3 router is refused with a warning in the RPT.
 *
 * Arguments:
 * 0: Jammer, an object registered as jammer in Crows <OBJECT>
 * 1: Router, objNull to unlink <OBJECT> (default: objNull)
 * 2: Name shown in the terminal, "" for the display name of the object <STRING> (default: "")
 *
 * Return Value:
 * None
 *
 * Example:
 * [myJammer, myRouter, "Relay north"] call ewc_jammer_control_fnc_linkJammer
 *
 * Public: Yes
 */

params [["_jammer", objNull, [objNull]], ["_router", objNull, [objNull]], ["_name", "", [""]]];

if (!isServer) exitWith {
    [QGVAR(link), [_jammer, _router, _name]] call CBA_fnc_serverEvent;
};

if (isNull _jammer) exitWith {};

if (isNull _router) exitWith {
    _jammer setVariable [QGVAR(router), nil, true];
};

// The same objects as the Zeus module accepts, so a wrong sync or call does not fail silently
if !(netId _jammer in (missionNamespace getVariable [CROWS_VAR_JAM_MAP, createHashMap])) exitWith {
    WARNING_1("Not linked, %1 is not a jammer of Crows",_jammer);
};

if (_jammer getVariable [QEGVAR(common,isJammer), false]) exitWith {
    WARNING_1("Not linked, %1 is a vehicle jammer with a crew switch",_jammer);
};

if !(_router in (call AE3_network_fnc_getRouters)) exitWith {
    WARNING_2("Not linked, %1 is not an AE3 router (jammer %2)",_router,_jammer);
};

_jammer setVariable [QGVAR(router), _router, true];

if (isNil {_jammer getVariable QGVAR(id)}) then {
    GVAR(lastId) = GVAR(lastId) + 1;
    _jammer setVariable [QGVAR(id), GVAR(lastId), true];
};

if (_name isEqualTo "") then {
    _jammer setVariable [QGVAR(name), nil, true];
} else {
    _jammer setVariable [QGVAR(name), _name, true];
};
