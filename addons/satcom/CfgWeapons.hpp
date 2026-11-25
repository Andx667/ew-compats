class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    // An item with the entry ewc_satcom_object deploys as that object (fnc_addActions finds them by it), so another
    // mod can add a dish with one class
    class GVAR(dish_base): ACE_ItemCore {
        scope = 1;
        author = AUTHOR;
        descriptionShort = CSTRING(dish_description);
        // Placeholder until the dishes get their own icons
        picture = "\a3\ui_f\data\igui\cfg\simpletasks\types\radio_ca.paa";

        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 150;
        };
    };

    class GVAR(dish_black): GVAR(dish_base) {
        scope = 2;
        displayName = CSTRING(dish_black);
        GVAR(object) = "SatelliteAntenna_01_Small_Black_F";
    };

    class GVAR(dish_olive): GVAR(dish_base) {
        scope = 2;
        displayName = CSTRING(dish_olive);
        GVAR(object) = "SatelliteAntenna_01_Small_Olive_F";
    };

    class GVAR(dish_sand): GVAR(dish_base) {
        scope = 2;
        displayName = CSTRING(dish_sand);
        GVAR(object) = "SatelliteAntenna_01_Small_Sand_F";
    };
};
