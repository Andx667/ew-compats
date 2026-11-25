#include "..\script_component.hpp"
/*
 * Author: Andx
 * Class event handler of the Dingo 2: gives a Dingo without a CG13 the scroll wheel actions of its satcom switch.
 * The ACE actions are added once for all land vehicles (XEH_postInit). Dingos without a CG13 have no entry in the
 * jammer registry, so they get no ewc_common_vehicleInit and need their own handler.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_dingo] call ewc_compat_bwa3_fnc_initSatcom
 *
 * Public: No
 */

params [["_vehicle", objNull, [objNull]]];

if (!hasInterface || {!HAS_SATCOM(_vehicle)}) exitWith {};

[_vehicle, SATCOM_ID] call EFUNC(common,addSwitchActions);
