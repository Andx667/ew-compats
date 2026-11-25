waitUntil {!isNull player};

player setPos [-20 + (random 2), 10, 0];

addMissionEventHandler ["Draw3D", {
    private _eye = positionCameraToWorld [0, 0, 0];
    {
        _x params ["_pos", "_text"];
        if (_eye distance _pos < 250) then {
            drawIcon3D ["", [1, 1, 1, 1], _pos vectorAdd [0, 0, 1.5], 0, 0, 0, _text, 2, 0.035, "PuristaMedium", "center"];
        };
    } forEach (missionNamespace getVariable ["ewc_test_labels", []]);
}];

[{
    hint parseText "<t size='1.2'>EWC Test: AE3 Jammer Control</t><br/>A router and two laptops stand next to you, two jammers 150 m north (both off, the left one is linked to the router).<br/><br/>1. Switch on the router and laptop A, connect the laptop to the router, open the terminal.<br/>2. <t color='#ffd966'>jammer</t>: only the linked jammer is listed, id 1.<br/>3. <t color='#ffd966'>jammer on 1</t>: the data terminal opens, the debug overlay shows it on. <t color='#ffd966'>jammer off 1</t> closes it.<br/>4. Disconnect the laptop: the list is empty, a switch is refused.<br/>5. Connect laptop B too and use <t color='#ffd966'>ssh</t> from laptop A into B: the command works there as well.<br/>6. Zeus: module Link Jammer to Router on the right jammer, then it is listed as id 2.<br/>7. Crow's EW needs multiplayer: host this on LAN or a dedicated server.";
}, [], 1] call CBA_fnc_waitAndExecute;
