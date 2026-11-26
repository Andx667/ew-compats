private _category = [LELSTRING(main,displayName), LLSTRING(category)];

// All the settings are global: the server decides, so everybody gets the same rules
[
    QGVAR(enable),
    "CHECKBOX",
    [LLSTRING(setting_enable), LLSTRING(setting_enable_tooltip)],
    _category,
    true,
    true,
    LINKFUNC(onSettingChanged)
] call CBA_fnc_addSetting;

[
    QGVAR(radius),
    "SLIDER",
    [LLSTRING(setting_radius), LLSTRING(setting_radius_tooltip)],
    _category,
    [1, 50, 20, 0],
    true
] call CBA_fnc_addSetting;
