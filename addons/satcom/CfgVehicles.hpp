class CfgVehicles {
    class SatelliteAntenna_01_Small_Sand_F;

    // Starlink terminal, a satcom dish of its own model. Built on the small vanilla dish, so it behaves like the
    // other dishes (simulation, damage, editor category). Model by Malacodart (CC BY 4.0), see data/LICENSE
    class GVAR(starlink): SatelliteAntenna_01_Small_Sand_F {
        author = "Malacodart, Andx";
        displayName = CSTRING(starlink);
        model = QPATHTOF(data\starlink.p3d);
        hiddenSelections[] = {};
        hiddenSelectionsTextures[] = {};
    };
};
