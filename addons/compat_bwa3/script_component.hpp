#define COMPONENT compat_bwa3
#define COMPONENT_BEAUTIFIED Compat BWA3

#include "\z\ewc\addons\main\script_mod.hpp"
#include "\z\ewc\addons\main\script_macros.hpp"


// BWA3 hardcodes the mine jammer range (JAMMER_RANGE) in its own script_component.h, keep in sync
#define ECM_EFFECTIVE_RADIUS 40
#define ECM_FALLOFF_FACTOR 1.5

// Shown in the hint when it is switched
#define SYSTEM_NAME "CG13"

// Satcom of the Dingos: id of the switch in ewc_common, name in the hint, default radius in m, seconds
// between two checks while one is on, and the speed in km/h above which the vehicle counts as moving
#define SATCOM_ID "bwa3_satcom"
#define SATCOM_NAME "SATCOM"
#define SATCOM_DEFAULT_RADIUS 5
#define SATCOM_INTERVAL 1
#define SATCOM_MAX_SPEED 1

// Every Dingo 2 model carries the satcom antenna, with or without a CG13
#define HAS_SATCOM(vehicle) (vehicle isKindOf "BWA3_Dingo2_base")
