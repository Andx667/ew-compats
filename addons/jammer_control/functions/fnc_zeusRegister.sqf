#include "..\script_component.hpp"
/*
 * Author: Andx
 * Registers the Zeus module that links a jammer to a router (Zeus Enhanced).
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call ewc_jammer_control_fnc_zeusRegister
 *
 * Public: No
 */

[ZEUS_CATEGORY, LLSTRING(module_displayName), {_this call FUNC(linkJammerZeus)}, ZEUS_ICON] call zen_custom_modules_fnc_register;
