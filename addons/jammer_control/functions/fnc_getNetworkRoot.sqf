#include "..\script_component.hpp"
/*
 * Author: Andx
 * Returns the top router of the AE3 network a device is in, or the device itself when it is in none. Two devices
 * are in the same network when they have the same top router, as in AE3_network_fnc_sameNetwork, which is not public.
 * A router on the way that is destroyed or switched off carries no traffic, as in AE3_network_fnc_resolve and
 * AE3_network_fnc_ping, so the device is cut off and the result is objNull. AE3 only disconnects the laptops of a
 * router that is switched off, cascaded routers stay attached to it.
 * Any machine.
 *
 * Arguments:
 * 0: Device (laptop or router) <OBJECT>
 * 1: Router of every device, from fnc_getNetworkParents <HASHMAP>
 *
 * Return Value:
 * Top router of the network, the device, or objNull when cut off <OBJECT>
 *
 * Example:
 * [_laptop, call ewc_jammer_control_fnc_getNetworkParents] call ewc_jammer_control_fnc_getNetworkRoot
 *
 * Public: No
 */

params [["_device", objNull, [objNull]], ["_parents", createHashMap, [createHashMap]]];

private _depth = 0;
while {_depth < MAX_NETWORK_DEPTH} do {
    if (_device getVariable ["AE3_cap_isRouter", false] && {!alive _device || {!([_device] call AE3_power_fnc_isPoweredOn)}}) exitWith {
        _device = objNull;
    };

    private _parent = _parents getOrDefault [netId _device, objNull];
    if (isNull _parent) exitWith {};
    _device = _parent;
    _depth = _depth + 1;
};

_device
