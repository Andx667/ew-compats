#define COMPONENT jammer_control
#define COMPONENT_BEAUTIFIED Jammer Control

#include "\z\ewc\addons\main\script_mod.hpp"
#include "\z\ewc\addons\main\script_macros.hpp"

// Crows: the sound of a jammer (server event) and the class of its data terminal, both as in its own (de)activate action
#define CROWS_EVENT_SET_SOUND "crowsEW_sounds_setSoundEnable"
#define CROWS_DATATERMINAL "Crows_dataterminal"

// Zeus modules sit with the other jammer modules
#define ZEUS_CATEGORY "Crows Electronic Warfare"
#define ZEUS_ICON "\a3\ui_f\data\igui\cfg\simpletasks\types\intel_ca.paa"

// Seconds the terminal waits for the answer of the server to a switch
#define SWITCH_TIMEOUT 5

// Depth limit when following the routers of a network up to its top, like AE3
#define MAX_NETWORK_DEPTH 32
