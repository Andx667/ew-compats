#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

// Last id given to a linked jammer, so every jammer keeps one short id for the terminal. Server only
GVAR(lastId) = 0;

// Answer of the server to the last switch from this client, see fnc_osJammer
GVAR(switchResult) = nil;

ADDON = true;
