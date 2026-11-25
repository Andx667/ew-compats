#include "..\script_component.hpp"
/*
 * Author: Andx
 * Why the satcom of a Dingo cannot be on: it needs a running engine and a vehicle that stands still. The reason is
 * shown in the hint (STR_ewc_common_reason_<reason>).
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Reason, "" if it can be on <STRING>
 *
 * Example:
 * [_dingo] call ewc_compat_bwa3_fnc_getSatcomBlockReason
 *
 * Public: No
 */

params [["_vehicle", objNull, [objNull]]];

if (!GVAR(enableSatcom)) exitWith {"disabled"};
if (!alive _vehicle) exitWith {"dead"};
if (!isEngineOn _vehicle) exitWith {"engine"};
if (abs speed _vehicle > SATCOM_MAX_SPEED) exitWith {"moving"};

""
