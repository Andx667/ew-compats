#define COMPONENT satcom
#define COMPONENT_BEAUTIFIED Satcom

#include "\z\ewc\addons\main\script_mod.hpp"
#include "\z\ewc\addons\main\script_macros.hpp"

// State of the placement of the ghost dish (fnc_place)
#define PLACE_WAITING -1
#define PLACE_CANCEL 0
#define PLACE_APPROVE 1

// Degrees the ghost turns per step of the mouse wheel
#define PLACE_ROTATE_STEP 15

// Seconds of the progress bars. Picking up takes 1.5 times as long as deploying
#define DEPLOY_TIME 6
#define PICKUP_TIME (DEPLOY_TIME * 1.5)

// Animation while deploying or picking up a dish
#define WORK_ANIMATION "Acts_carFixingWheel"
