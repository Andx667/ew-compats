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
    hint parseText "<t size='1.2'>EWC Test: AE3 Jammer Control</t><br/>Two routers and two laptops stand next to you, three jammers 150 m north (all off). The middle one is linked to ROUTER (id 1), the left one to ROUTER B (id 2), the right one to none.<br/><br/>1. Switch on the router and laptop A, connect the laptop to the router, open the terminal.<br/>2. <t color='#ffd966'>jammer</t>: only jammer 1 is listed. <t color='#ffd966'>jammer on</t> without an id prints the usage.<br/>3. <t color='#ffd966'>jammer on 1</t>: the data terminal opens, the debug overlay shows it on. <t color='#ffd966'>jammer off 1</t> closes it.<br/>4. Switch on ROUTER B and connect it to ROUTER with its ACE interaction (AE3 lists the routers within 10 m). <t color='#ffd966'>jammer</t> on laptop A now lists jammer 2 as well. Switch ROUTER B off (or destroy it): jammer 2 is gone from the list, <t color='#ffd966'>jammer on 2</t> is refused.<br/>5. Disconnect the laptop: the list is empty, a switch is refused.<br/>6. Connect laptop B too and use <t color='#ffd966'>ssh</t> from laptop A into B: the command works there as well.<br/>7. Zeus: module Link Jammer to Router on the right jammer (preselected: None), then it is listed as id 3.<br/>8. RPT: two warnings <t color='#ffd966'>Not linked</t> from the mission's wrong link calls.<br/>9. Crow's EW needs multiplayer: host this on LAN or a dedicated server.";
}, [], 1] call CBA_fnc_waitAndExecute;
