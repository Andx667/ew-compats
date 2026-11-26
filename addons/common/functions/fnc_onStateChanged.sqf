#include "..\script_component.hpp"
/*
 * Author: Andx
 * Shows the notification of fnc_notifyState to the occupants of the vehicle. A CBA notification instead of a hint,
 * because players can move it in the layout editor apart from the hints, which by default cover the vehicle's
 * weapon info.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Name of the system <STRING>
 * 2: System is on <BOOL>
 * 3: Reason, "" or without a text of its own for none <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle, "DUKE", false, "engine"] call ewc_common_fnc_onStateChanged
 *
 * Public: No
 */

params [["_vehicle", objNull, [objNull]], ["_name", "", [""]], ["_on", false, [false]], ["_reason", "", [""]]];

if (isNull player || {vehicle player != _vehicle}) exitWith {};

private _reasonKey = format ["STR_ewc_common_reason_%1", _reason];

(if (_on) then {
    format [LLSTRING(state_on), _name]
} else {
    if (isLocalized _reasonKey) then {
        format [LLSTRING(state_offReason), _name, localize _reasonKey]
    } else {
        format [LLSTRING(state_off), _name]
    }
}) call CBA_fnc_notify;
