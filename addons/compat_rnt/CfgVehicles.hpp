// The two rear roof hatches of the Fuchs open when a passenger turns out (FFV seats "Linke Luke" and "Rechte Luke").
// The Hummel keeps them closed, the antennas stand next to them. The turret order decides the turret paths, so all
// four turrets are listed in the order of Redd'n'Tank
#define HUMMEL_TURRETS \
    class Turrets: Turrets { \
        class MainTurret: MainTurret { \
            class Turrets: Turrets { \
                class commander_hatch: commander_hatch {}; \
                class ffv_hatch_R: ffv_hatch_R { \
                    forceHideGunner = 1; \
                }; \
                class ffv_hatch_L: ffv_hatch_L { \
                    forceHideGunner = 1; \
                }; \
                class fake_gunner_turret: fake_gunner_turret {}; \
            }; \
        }; \
        class Fuchs_Bino_Turret_Com: Fuchs_Bino_Turret_Com {}; \
    }

class CfgVehicles {
    // The Fuchs 1A4 of Redd'n'Tank has no EloKa variant and no jammer antenna, so the Hummel is its Jaeger with a new
    // name. It has the model, the textures and the crew of the Jaeger and carries the marker that makes it a jammer
    // in the registry of ewc_common (CfgEWC >> Jammers >> RNT_HUMMEL)
    // The turret declarations mirror those of Redd'n'Tank with the same base classes on every level, otherwise the
    // engine changes the base classes of the Jaeger's turrets ("Updating base class" in the RPT)
    class Car_F;
    class Wheeled_APC_F: Car_F {
        class Turrets {
            class MainTurret;
        };
    };
    class Redd_Tank_Fuchs_1A4_Base: Wheeled_APC_F {
        class Turrets: Turrets {
            class MainTurret: MainTurret {
                class Turrets;
            };
        };
    };
    class Redd_Tank_Fuchs_1A4_Jg_Flecktarn: Redd_Tank_Fuchs_1A4_Base {
        class Turrets: Turrets {
            class MainTurret: MainTurret {
                class Turrets: Turrets {
                    class commander_hatch;
                    class ffv_hatch_R;
                    class ffv_hatch_L;
                    class fake_gunner_turret;
                };
            };
            class Fuchs_Bino_Turret_Com;
        };
    };
    // Both inherit their turrets from the Flecktarn one
    class Redd_Tank_Fuchs_1A4_Jg_Tropentarn: Redd_Tank_Fuchs_1A4_Jg_Flecktarn {};
    class Redd_Tank_Fuchs_1A4_Jg_Wintertarn: Redd_Tank_Fuchs_1A4_Jg_Flecktarn {};

    class EWC_RnT_Fuchs_1A4_Hummel_Flecktarn: Redd_Tank_Fuchs_1A4_Jg_Flecktarn {
        displayName = CSTRING(hummel_flecktarn);
        author = AUTHOR;
        editorPreview = QPATHTOF(data\ui\hummel_preview.jpg);
        GVAR(jammer) = 1;
        HUMMEL_TURRETS;
    };

    class EWC_RnT_Fuchs_1A4_Hummel_Tropentarn: Redd_Tank_Fuchs_1A4_Jg_Tropentarn {
        displayName = CSTRING(hummel_tropentarn);
        author = AUTHOR;
        editorPreview = QPATHTOF(data\ui\hummel_preview.jpg);
        GVAR(jammer) = 1;
        HUMMEL_TURRETS;
    };

    class EWC_RnT_Fuchs_1A4_Hummel_Wintertarn: Redd_Tank_Fuchs_1A4_Jg_Wintertarn {
        displayName = CSTRING(hummel_wintertarn);
        author = AUTHOR;
        editorPreview = QPATHTOF(data\ui\hummel_preview.jpg);
        GVAR(jammer) = 1;
        HUMMEL_TURRETS;
    };
};
