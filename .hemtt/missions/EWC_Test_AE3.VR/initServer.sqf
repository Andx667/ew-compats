// EWC Test - AE3 Jammer Control
// A router with two laptops next to the start, a jammer linked to the router and one that is not. A second router
// (B) for cascading under the first one, with a jammer of its own, to test that a router that is down cuts it off.

private _router = createVehicle ["Land_Router_01_black_F_AE3", [-14, 14, 0], [], 0, "CAN_COLLIDE"];
private _laptopA = createVehicle ["Land_Laptop_03_black_F_AE3", [-16, 14, 0], [], 0, "CAN_COLLIDE"];
private _laptopB = createVehicle ["Land_Laptop_03_olive_F_AE3", [-12, 14, 0], [], 0, "CAN_COLLIDE"];

private _linked = createVehicle ["Crows_dataterminal", [0, 150, 0], [], 0, "CAN_COLLIDE"];
private _unlinked = createVehicle ["Crows_dataterminal", [60, 150, 0], [], 0, "CAN_COLLIDE"];
{ _x allowDamage false } forEach [_router, _laptopA, _laptopB, _linked, _unlinked];

// Router B can be destroyed, to test a dead router as well as one that is switched off
private _routerB = createVehicle ["Land_Router_01_black_F_AE3", [-8, 14, 0], [], 0, "CAN_COLLIDE"];
private _behindB = createVehicle ["Crows_dataterminal", [-60, 150, 0], [], 0, "CAN_COLLIDE"];
_behindB allowDamage false;

missionNamespace setVariable ["ewc_test_labels", [
    [getPosATL _router, "ROUTER"],
    [getPosATL _laptopA, "LAPTOP A"],
    [getPosATL _laptopB, "LAPTOP B"],
    [getPosATL _linked, "JAMMER linked to the router"],
    [getPosATL _unlinked, "JAMMER not linked"],
    [getPosATL _routerB, "ROUTER B (cascade under ROUTER)"],
    [getPosATL _behindB, "JAMMER linked to router B"]
], true];

// Crow's registers its server event handlers in postInit, AE3 its routers during init
[{CBA_missionTime > 0}, {
    params ["_router", "_linked", "_unlinked", "_routerB", "_behindB", "_laptopA"];

    {
        ["crowsEW_main_addJammer", [_x, 100, 100, false, ["VoiceCommsJammer"]]] call CBA_fnc_localEvent;
    } forEach [_linked, _unlinked, _behindB];

    // The loop sound, as the jammer modules of Crows add it. The unlinked jammer gets none, like a jammer added by
    // script, so switching it from the terminal tests that a jammer without a sound works too
    {
        ["crowsEW_sounds_addSound", [_x, 0.5, 50, true, true, "crowsEW_jam_loop", 3, 3]] call CBA_fnc_localEvent;
        ["crowsEW_sounds_setSoundEnable", [_x, false]] call CBA_fnc_localEvent;
    } forEach [_linked, _behindB];

    [_linked, _router, "Test jammer north"] call ewc_jammer_control_fnc_linkJammer;
    [_behindB, _routerB, "Test jammer west (router B)"] call ewc_jammer_control_fnc_linkJammer;

    // Both must be refused with a warning in the RPT ("Not linked, ..."), and give no terminal id
    [_laptopA, _router] call ewc_jammer_control_fnc_linkJammer;
    [_unlinked, _laptopA] call ewc_jammer_control_fnc_linkJammer;
}, [_router, _linked, _unlinked, _routerB, _behindB, _laptopA]] call CBA_fnc_waitUntilAndExecute;
