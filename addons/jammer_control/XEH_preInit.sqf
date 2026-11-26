#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

// Last id given to a linked jammer, so every jammer keeps one short id for the terminal. Server only
GVAR(lastId) = 0;

// Id of the last switch from this client and the answer of the server to it, see fnc_osJammer
GVAR(requestId) = 0;
GVAR(switchResult) = nil;

ADDON = true;
