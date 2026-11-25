// EWC Test - AE3 Jammer Control
// A router with two laptops next to the start, a jammer linked to the router and one that is not.

private _router = createVehicle ["Land_Router_01_black_F_AE3", [-14, 14, 0], [], 0, "CAN_COLLIDE"];
private _laptopA = createVehicle ["Land_Laptop_03_black_F_AE3", [-16, 14, 0], [], 0, "CAN_COLLIDE"];
private _laptopB = createVehicle ["Land_Laptop_03_olive_F_AE3", [-12, 14, 0], [], 0, "CAN_COLLIDE"];

private _linked = createVehicle ["Crows_dataterminal", [0, 150, 0], [], 0, "CAN_COLLIDE"];
private _unlinked = createVehicle ["Crows_dataterminal", [60, 150, 0], [], 0, "CAN_COLLIDE"];
{ _x allowDamage false } forEach [_router, _laptopA, _laptopB, _linked, _unlinked];

missionNamespace setVariable ["ewc_test_labels", [
    [getPosATL _router, "ROUTER"],
    [getPosATL _laptopA, "LAPTOP A"],
    [getPosATL _laptopB, "LAPTOP B"],
    [getPosATL _linked, "JAMMER linked to the router"],
    [getPosATL _unlinked, "JAMMER not linked"]
], true];

// Crow's registers its server event handlers in postInit, AE3 its routers during init
[{CBA_missionTime > 0}, {
    params ["_router", "_linked", "_unlinked"];

    {
        ["crowsEW_main_addJammer", [_x, 100, 100, false, ["VoiceCommsJammer"]]] call CBA_fnc_localEvent;
    } forEach [_linked, _unlinked];

    [_linked, _router, "Test jammer north"] call ewc_jammer_control_fnc_linkJammer;
}, [_router, _linked, _unlinked]] call CBA_fnc_waitUntilAndExecute;
