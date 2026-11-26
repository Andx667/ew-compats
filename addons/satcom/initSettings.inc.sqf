private _category = [LELSTRING(main,displayName), LLSTRING(category)];

// The setting is global: the server decides, so everybody gets the same rules
[
    QGVAR(radius),
    "SLIDER",
    [LLSTRING(setting_radius), LLSTRING(setting_radius_tooltip)],
    _category,
    [1, 50, 20, 0],
    true
] call CBA_fnc_addSetting;
