private _category = [LELSTRING(main,displayName), LLSTRING(category)];

[
    QGVAR(enableCG13),
    "CHECKBOX",
    [LLSTRING(setting_enableCG13), LLSTRING(setting_enableCG13_tooltip)],
    _category,
    true,
    true,
    LINKFUNC(onSettingChanged)
] call CBA_fnc_addSetting;

// Checked by fnc_satcomLoop, so switching it off takes the satcom of every Dingo down within a second
[
    QGVAR(enableSatcom),
    "CHECKBOX",
    [LLSTRING(setting_enableSatcom), LLSTRING(setting_enableSatcom_tooltip)],
    _category,
    true,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(satcomRadius),
    "SLIDER",
    [LLSTRING(setting_satcomRadius), LLSTRING(setting_satcomRadius_tooltip)],
    _category,
    [1, 50, SATCOM_DEFAULT_RADIUS, 0],
    true
] call CBA_fnc_addSetting;
