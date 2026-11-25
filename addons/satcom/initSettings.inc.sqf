private _category = [LELSTRING(main,displayName), LLSTRING(category)];

// All the settings are global: the server decides, so everybody gets the same rules
[
    QGVAR(radius),
    "SLIDER",
    [LLSTRING(setting_radius), LLSTRING(setting_radius_tooltip)],
    _category,
    [1, 50, 20, 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(deployTime),
    "SLIDER",
    [LLSTRING(setting_deployTime), LLSTRING(setting_deployTime_tooltip)],
    _category,
    [1, 60, 6, 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(pickUpTime),
    "SLIDER",
    [LLSTRING(setting_pickUpTime), LLSTRING(setting_pickUpTime_tooltip)],
    _category,
    [1, 60, 5, 0],
    true
] call CBA_fnc_addSetting;
