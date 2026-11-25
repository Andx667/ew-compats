#include "..\script_component.hpp"
/*
 * Author: Andx
 * A laptop asks to switch a jammer. The client is not trusted: the server checks again that the laptop is switched
 * on and that the jammer is linked to its network (fnc_getJammers), then switches it like the (de)activate action
 * of Crows does (sound, animation of the data terminal, crowsEW_main_toggleJammer). The Spectrum signals of the
 * jammers of this mod follow on crowsEW_main_updateJammers by themselves. Answers the unit with the result.
 * SERVER ONLY.
 *
 * Arguments:
 * 0: Laptop <OBJECT>
 * 1: Jammer <OBJECT>
 * 2: Switch on <BOOL>
 * 3: Unit at the terminal, gets the answer <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_laptop, _jammer, true, player] call ewc_jammer_control_fnc_handleSwitch
 *
 * Public: No
 */

params [["_laptop", objNull, [objNull]], ["_jammer", objNull, [objNull]], ["_enabled", false, [false]], ["_unit", objNull, [objNull]]];

private _result = call {
    if !([_laptop] call AE3_power_fnc_isPoweredOn) exitWith {"laptopOff"};
    if !(_jammer in ([_laptop] call FUNC(getJammers))) exitWith {"notAllowed"};

    private _netId = netId _jammer;
    private _entry = (missionNamespace getVariable [CROWS_VAR_JAM_MAP, createHashMap]) getOrDefault [_netId, []];

    if ((_entry select 3) isEqualTo _enabled) exitWith {["alreadyOff", "alreadyOn"] select _enabled};

    if (typeOf _jammer == CROWS_DATATERMINAL) then {
        [_jammer, [0, 3] select _enabled] call BIS_fnc_dataTerminalAnimate;
    };

    [CROWS_EVENT_SET_SOUND, [_jammer, _enabled]] call CBA_fnc_localEvent;
    [CROWS_EVENT_TOGGLE_JAMMER, [_netId, _enabled]] call CBA_fnc_localEvent;

    ["switchedOff", "switchedOn"] select _enabled
};

if (!isNull _unit) then {
    [QGVAR(switchResult), [_result], _unit] call CBA_fnc_targetEvent;
};
