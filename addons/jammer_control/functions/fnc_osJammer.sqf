#include "..\script_component.hpp"
/*
 * Author: Andx
 * The terminal command "jammer" of AE3 laptops: "jammer list" (also without arguments) lists the jammers linked to
 * the network of the laptop, "jammer on <id>" and "jammer off <id>" switch one. Runs scheduled on the client of the
 * player at the terminal, like every AE3 command. Over SSH the laptop is the remote one. A switch is checked again on
 * the server (fnc_handleSwitch), the command waits for its answer so the result is printed before the next prompt.
 *
 * Arguments:
 * 0: Laptop <OBJECT>
 * 1: Arguments of the command <ARRAY>
 * 2: Name of the command <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_laptop, ["on", "2"], "jammer"] call ewc_jammer_control_fnc_osJammer
 *
 * Public: No
 */

params [["_laptop", objNull, [objNull]], ["_options", [], [[]]], ["_commandName", "", [""]]];

private _commandSyntax = [
    [
        ["command", _commandName, true, false]
    ],
    [
        ["command", _commandName, true, false],
        ["path", "list", true, false]
    ],
    [
        ["command", _commandName, true, false],
        ["path", "on|off", true, false],
        ["path", "ID", true, false]
    ]
];

private _ae3OptsSuccess = false;
private _ae3OptsThings = [];
[] params ([_laptop, _options, [_commandName, [], _commandSyntax]] call AE3_armaos_fnc_shell_getOpts);

if (!_ae3OptsSuccess) exitWith {};

_ae3OptsThings params [["_action", "list"], ["_id", ""]];
_action = toLower _action;

private _jammers = [_laptop] call FUNC(getJammers);
private _jamMap = missionNamespace getVariable [CROWS_VAR_JAM_MAP, createHashMap];

if (_action == "list") exitWith {
    if (_jammers isEqualTo []) exitWith {
        [_laptop, LLSTRING(os_noJammers)] call AE3_armaos_fnc_shell_stdout;
    };

    private _lines = [LLSTRING(os_listHeader)];
    {
        private _entry = _jamMap getOrDefault [netId _x, []];
        _entry params ["", ["_falloff", 0], ["_effective", 0], ["_enabled", false]];

        _lines pushBack format [
            LLSTRING(os_listLine),
            _x getVariable [QGVAR(id), 0],
            [LLSTRING(os_off), LLSTRING(os_on)] select _enabled,
            _x getVariable [QGVAR(name), getText (configOf _x >> "displayName")],
            round (_falloff + _effective)
        ];
    } forEach _jammers;

    [_laptop, _lines] call AE3_armaos_fnc_shell_stdout;
};

if (!(_action in ["on", "off"]) || {_id isEqualTo ""}) exitWith {
    [_laptop, format [LLSTRING(os_usage), _commandName]] call AE3_armaos_fnc_shell_stdout;
};

private _index = _jammers findIf {str (_x getVariable [QGVAR(id), 0]) == _id};
if (_index == -1) exitWith {
    [_laptop, format [LLSTRING(os_unknownId), _id]] call AE3_armaos_fnc_shell_stdout;
};

GVAR(requestId) = GVAR(requestId) + 1;
GVAR(switchResult) = nil;
[QGVAR(switch), [_laptop, _jammers select _index, _action == "on", player, GVAR(requestId)]] call CBA_fnc_serverEvent;

// AE3 runs every command scheduled and prints the next prompt when it returns, so the command blocks here for the
// answer instead of printing it from the event handler after the prompt
private _timeout = diag_tickTime + SWITCH_TIMEOUT;
waitUntil {!isNil QGVAR(switchResult) || {diag_tickTime > _timeout}};

private _result = missionNamespace getVariable [QGVAR(switchResult), "timeout"];
[_laptop, format [localize format ["STR_ewc_jammer_control_result_%1", _result], _id]] call AE3_armaos_fnc_shell_stdout;
