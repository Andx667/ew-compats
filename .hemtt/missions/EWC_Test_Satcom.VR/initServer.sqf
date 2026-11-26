// EWC Test - Satcom
// A radio jammer 150 m north of the start, with distance signs west of it. Deploy a dish inside its range and compare.

#define JAMMER_POS [0, 150, 0]
#define JAMMER_RADIUS 60
#define JAMMER_FALLOFF 60
#define SIGN_DISTANCES [20, 40, 60, 90, 120]

private _jammer = createVehicle ["Land_DataTerminal_01_F", JAMMER_POS, [], 0, "CAN_COLLIDE"];
_jammer allowDamage false;

// Crow's registers its server event handlers in postInit
[{CBA_missionTime > 0}, {
    ["crowsEW_main_addJammer", [_this, JAMMER_FALLOFF, JAMMER_RADIUS, true, ["VoiceCommsJammer"]]] call CBA_fnc_localEvent;
}, _jammer] call CBA_fnc_waitUntilAndExecute;

private _labels = [[JAMMER_POS, format ["RADIO JAMMER: full %1 m, falloff to %2 m", JAMMER_RADIUS, JAMMER_RADIUS + JAMMER_FALLOFF]]];
{
    private _pos = JAMMER_POS vectorAdd [-_x, 0, 0];
    private _sign = createVehicle ["Sign_Sphere100cm_F", _pos, [], 0, "CAN_COLLIDE"];
    _sign allowDamage false;
    _labels pushBack [_pos, format ["%1 m", _x]];
} forEach SIGN_DISTANCES;

missionNamespace setVariable ["ewc_test_labels", _labels, true];
