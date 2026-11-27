#include "..\script_component.hpp"
/*
 * Author: Andx
 * Prepares a Hummel: the switch actions of ewc_common and the roof antennas on every machine with an interface, and the event handlers that
 * switch the jammer off when the engine stops or the vehicle is destroyed. The jammer itself is registered by the
 * registry (CfgEWC >> Jammers >> RNT_HUMMEL).
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Class name of the registry entry of the vehicle <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle, "RNT_HUMMEL"] call ewc_compat_rnt_fnc_initVehicle
 *
 * Public: No
 */

params [["_vehicle", objNull, [objNull]], ["_entry", "", [""]]];

if (_entry isNotEqualTo "RNT_HUMMEL") exitWith {};

if (hasInterface) then {
    [_vehicle, SYSTEM_ID] call EFUNC(common,addSwitchActions);

    // Local simple objects: only seen, so every client makes its own and nothing goes over the network. They stay
    // on the wreck and go with the vehicle
    private _antennas = ANTENNAS apply {
        _x params ["_model", "_offset"];

        private _antenna = createSimpleObject [_model, [0, 0, 0], true];
        _antenna attachTo [_vehicle, _offset];
        _antenna
    };

    _vehicle setVariable [QGVAR(antennas), _antennas];

    _vehicle addEventHandler ["Deleted", {
        params ["_vehicle"];

        {deleteVehicle _x} forEach (_vehicle getVariable [QGVAR(antennas), []]);
    }];
};

// Both events only fire where the vehicle is local, so the handlers have to exist on every machine
_vehicle addEventHandler ["Engine", {
    params ["_vehicle", "_engineOn"];

    if (!_engineOn) then {
        [QGVAR(syncJammer), [_vehicle]] call CBA_fnc_serverEvent;
    };
}];

_vehicle addEventHandler ["Killed", {
    params ["_vehicle"];

    [QGVAR(syncJammer), [_vehicle]] call CBA_fnc_serverEvent;
}];
