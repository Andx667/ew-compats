#include "..\script_component.hpp"
/*
 * Author: Andx
 * Editor module: links the jammers synced to it to the AE3 router synced to it. Which synced object is the router is
 * only known once AE3 has set up its routers, so it waits for the mission to start. fnc_linkJammer refuses every
 * other synced object that is not a jammer of Crows, with a warning in the RPT.
 * SERVER ONLY (isGlobal = 0).
 *
 * Arguments:
 * 0: Module <OBJECT>
 * 1: Synced objects <ARRAY>
 * 2: Activated <BOOL>
 *
 * Return Value:
 * Done <BOOL>
 *
 * Example:
 * [_logic, [_jammer, _router], true] call ewc_jammer_control_fnc_moduleLinkJammer
 *
 * Public: No
 */

params [["_logic", objNull, [objNull]], ["_units", [], [[]]], ["_activated", true, [true]]];

if (!_activated) exitWith {true};

[{CBA_missionTime > 0}, {
    private _routers = call AE3_network_fnc_getRouters;
    private _synced = _this select {_x in _routers};

    if (count _synced != 1) exitWith {
        WARNING_1("Link jammer module needs exactly one synced AE3 router, got %1",count _synced);
    };

    private _router = _synced select 0;
    {
        [_x, _router] call FUNC(linkJammer);
    } forEach (_this - [_router]);
}, _units] call CBA_fnc_waitUntilAndExecute;

true
