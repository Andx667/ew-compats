#include "..\script_component.hpp"
/*
 * Author: Andx
 * Returns the router every AE3 network device is connected to, by net ID, for fnc_getNetworkRoot. AE3 keeps this in
 * the private variable AE3_network_parent, so it is rebuilt from the public getRouters and getClients.
 * Any machine.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Router of every connected device, net ID of the device -> router <HASHMAP>
 *
 * Example:
 * call ewc_jammer_control_fnc_getNetworkParents
 *
 * Public: No
 */

private _parents = createHashMap;

{
    private _router = _x;
    {
        _parents set [netId _x, _router];
    } forEach ([_router, true] call AE3_network_fnc_getClients);
} forEach (call AE3_network_fnc_getRouters);

_parents
