class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    // An item with the entry ewc_satcom_object deploys as that object (fnc_addActions finds them by it), so another
    // mod can add a dish with one class
    class GVAR(dish_base): ACE_ItemCore {
        scope = 1;
        author = AUTHOR;
        descriptionShort = CSTRING(dish_description);
        // For dishes of other mods. The dishes here have their own icon, made from the editor preview of the object
        // they deploy as (data\ui)
        picture = "\a3\ui_f\data\igui\cfg\simpletasks\types\radio_ca.paa";
        // A dropped dish is a small plastic case (Land_PlasticCase_01_small_F), the colours below retexture it like
        // the Contact variants of the case do. It lies on its side when dropped, because the ground holder tips every
        // model over and this prop is modelled standing; a proxy model would fix that but drops the retextures
        model = "\A3\Structures_F_Heli\Items\Luggage\PlasticCase_01_small_F.p3d";

        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 120;
        };
    };

    class GVAR(dish_black): GVAR(dish_base) {
        scope = 2;
        displayName = CSTRING(dish_black);
        picture = QPATHTOF(data\ui\dish_black_ca.paa);
        GVAR(object) = "SatelliteAntenna_01_Small_Black_F";
        hiddenSelections[] = {"Camo", "Camo2"};
        hiddenSelectionsTextures[] = {"\a3\Props_F_Enoch\Military\Supplies\Data\PlasticCase_01_black_CO.paa"};
    };

    class GVAR(dish_olive): GVAR(dish_base) {
        scope = 2;
        displayName = CSTRING(dish_olive);
        picture = QPATHTOF(data\ui\dish_olive_ca.paa);
        GVAR(object) = "SatelliteAntenna_01_Small_Olive_F";
        hiddenSelections[] = {"Camo", "Camo2"};
        hiddenSelectionsTextures[] = {"\a3\Props_F_Enoch\Military\Supplies\Data\PlasticCase_01_olive_CO.paa"};
    };

    class GVAR(dish_sand): GVAR(dish_base) {
        scope = 2;
        displayName = CSTRING(dish_sand);
        picture = QPATHTOF(data\ui\dish_sand_ca.paa);
        GVAR(object) = "SatelliteAntenna_01_Small_Sand_F";
    };

    class GVAR(dish_starlink): GVAR(dish_base) {
        scope = 2;
        displayName = CSTRING(dish_starlink);
        picture = QPATHTOF(data\ui\dish_starlink_ca.paa);
        GVAR(object) = QGVAR(starlink);
        hiddenSelections[] = {"Camo", "Camo2"};
        hiddenSelectionsTextures[] = {"\a3\Props_F_Enoch\Military\Supplies\Data\PlasticCase_01_black_CO.paa"};
    };
};
