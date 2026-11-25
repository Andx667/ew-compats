#include "..\script_component.hpp"
/*
 * Author: Andx
 * Links a Crows jammer to an AE3 router, or unlinks it. Every laptop in the network of that router can then list
 * and switch the jammer with the terminal command "jammer", also over SSH. The jammer keeps a short id for the
 * terminal for the rest of the mission, also when it is linked again.
 * Any machine, the link is made on the server.
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
