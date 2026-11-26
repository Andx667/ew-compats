waitUntil {!isNull player};

// Radios for the test, one dish of each colour
{
    if (isClass (configFile >> "CfgWeapons" >> _x)) then { player addItem _x };
} forEach ["ACRE_PRC152", "ACRE_PRC343"];

if (backpack player == "") then { player addBackpack "B_AssaultPack_rgr" };
{ player addItemToBackpack _x } forEach ["ewc_satcom_dish_black", "ewc_satcom_dish_olive", "ewc_satcom_dish_sand"];

player setPos [-20 + (random 2), 10, 0];

// Labels over the jammer and the signs, and the satcom radius of a dish (ewc_common_satcomRadius)
addMissionEventHandler ["Draw3D", {
    private _eye = positionCameraToWorld [0, 0, 0];

    {
        _x params ["_pos", "_text"];
        if (_eye distance _pos < 250) then {
            drawIcon3D ["", [1, 1, 1, 1], _pos vectorAdd [0, 0, 2.5], 0, 0, 0, _text, 2, 0.035, "PuristaMedium", "center"];
        };
    } forEach (missionNamespace getVariable ["ewc_test_labels", []]);

    {
        private _radius = _x getVariable ["ewc_common_satcomRadius", -1];
        private _text = ["dish, no satcom", format ["SATCOM %1 m, you are %2 m away", _radius, round (player distance _x)]] select (_radius > 0);
        drawIcon3D ["", [0.4, 0.7, 1, 1], (getPosATL _x) vectorAdd [0, 0, 2], 0, 0, 0, _text, 2, 0.035, "PuristaMedium", "center"];
    } forEach (nearestObjects [player, ["SatelliteAntenna_01_Small_Black_F", "SatelliteAntenna_01_Small_Olive_F", "SatelliteAntenna_01_Small_Sand_F"], 250]);

    // What Crow's applies to the local player: above 0 jammed, below 0 boosted by a satcom
    drawIcon3D ["", [1, 1, 0.4, 1], (getPosATL player) vectorAdd [0, 0, 2.2], 0, 0, 0, format ["acre_receive_interference: %1", player getVariable ["acre_receive_interference", "nil"]], 2, 0.03, "PuristaMedium", "center"];
}];

[{
    hint parseText "<t size='1.2'>EWC Test: Satcom</t><br/>A radio jammer stands 150 m north (full 60 m, falloff to 120 m). Your backpack has three satcom dishes.<br/><br/>1. Second player with ACRE stands next to the jammer: radio is jammed.<br/>2. ACE self-interaction, Equipment, Deploy satcom dish: place it next to the jammed player.<br/>3. Within 20 m of the dish the radio works again, the label over your head shows a negative interference (-50).<br/>4. Leave the dish radius inside the jammer: jamming returns within about 1 s.<br/>5. Pick up the dish: the item returns, jamming returns.<br/>6. Crow's EW needs multiplayer: host this on LAN or a dedicated server.";
}, [], 1] call CBA_fnc_waitAndExecute;
