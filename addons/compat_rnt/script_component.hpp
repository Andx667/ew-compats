#define COMPONENT compat_rnt
#define COMPONENT_BEAUTIFIED Compat RnT Vehicles

#include "\z\ewc\addons\main\script_mod.hpp"
#include "\z\ewc\addons\main\script_macros.hpp"

// The Hummel is no vehicle of Redd'n'Tank, so range and falloff are our own figures. The radius is a setting, this is its default
#define JAMMER_DEFAULT_RADIUS 500
#define JAMMER_FALLOFF_FACTOR 1.5

// Id of the switch in ewc_common, and shown in the hint when it is switched
#define SYSTEM_ID "hummel"
#define SYSTEM_NAME "Hummel"

// Antennas on the roof of the Hummel: model and offset from the model centre of the Fuchs, which has no memory points
// for them. Like the real one, a row of whips along each roof edge, short ones in front, long ones behind
// The models have their foot at the model centre (autocenter = 0), so the offset is where the foot stands
#define ANTENNA_SHORT QPATHTOF(data\antenna_short.p3d)
#define ANTENNA_LONG QPATHTOF(data\antenna_long.p3d)
// Measured on the Fire Geometry: the roof is flat at z 0.10 from x -1.0 to 1.0 and from y 1.5 to -3.0, beyond that
// it slopes down. The rows stand just inside its edges, behind the turret: further out the feet hang over the edge,
// further in (0.9) over the opening of the rear roof hatch
#define ANTENNA_X 0.95
#define ANTENNA_Z 0.1
#define ANTENNAS [\
    [ANTENNA_SHORT, [ANTENNA_X, 1.0, ANTENNA_Z]], [ANTENNA_SHORT, [-ANTENNA_X, 1.0, ANTENNA_Z]],\
    [ANTENNA_SHORT, [ANTENNA_X, 0.2, ANTENNA_Z]], [ANTENNA_SHORT, [-ANTENNA_X, 0.2, ANTENNA_Z]],\
    [ANTENNA_LONG, [ANTENNA_X, -0.6, ANTENNA_Z]], [ANTENNA_LONG, [-ANTENNA_X, -0.6, ANTENNA_Z]],\
    [ANTENNA_LONG, [ANTENNA_X, -1.4, ANTENNA_Z]], [ANTENNA_LONG, [-ANTENNA_X, -1.4, ANTENNA_Z]],\
    [ANTENNA_LONG, [ANTENNA_X, -2.2, ANTENNA_Z]], [ANTENNA_LONG, [-ANTENNA_X, -2.2, ANTENNA_Z]],\
    [ANTENNA_LONG, [ANTENNA_X, -3.0, ANTENNA_Z]], [ANTENNA_LONG, [-ANTENNA_X, -3.0, ANTENNA_Z]]\
]
