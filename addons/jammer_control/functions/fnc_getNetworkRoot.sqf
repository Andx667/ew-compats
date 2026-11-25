#include "..\script_component.hpp"
/*
 * Author: Andx
 * Returns the top router of the AE3 network a device is in, or the device itself when it is in none. Two devices
 * are in the same network when they have the same top router, as in AE3_network_fnc_sameNetwork, which is not public.
 * Any machine.
 *
 * Arguments:
 * 0: Device (laptop or router) <OBJECT>
 * 1: Router of every device, from fnc_getNetworkParents <HASHMAP>
 *
 * Return Value:
 * Top router of the network, or the device <OBJECT>
 *
 * Example:
 * [_laptop, call ewc_jammer_control_fnc_getNetworkParents] call ewc_jammer_control_fnc_getNetworkRoot
 *
 * Public: No
 */

params [["_device", objNull, [objNull]], ["_parents", createHashMap, [createHashMap]]];

private _depth = 0;
while {_depth < MAX_NETWORK_DEPTH} do {
    private _parent = _parents getOrDefault [netId _device, objNull];
    if (isNull _parent) exitWith {};
    _device = _parent;
    _depth = _depth + 1;
};

_device
