class CfgVehicles {

    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Units;
            class ModuleDescription;
        };

        class ModuleDescription {
        };
    };

    class GVAR(moduleLinkJammer): Module_F {
        scope = 2;
        displayName = CSTRING(module_displayName);
        icon = ZEUS_ICON;
        vehicleClass = "Modules";
        category = "crowsEW_modules";
        function = QFUNC(moduleLinkJammer);
        functionPriority = 1;
        isGlobal = 0;
        isTriggerActivated = 1;
        isDisposable = 1;
        is3DEN = 0;

        class Attributes: AttributesBase {
            class Units: Units {};
            class ModuleDescription: ModuleDescription {};
        };

        class ModuleDescription: ModuleDescription {
            description = CSTRING(module_description);
            sync[] = {"AnyStaticObject"};
        };
    };
};
