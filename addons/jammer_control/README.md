# Jammer Control

Players switch Crow's Electronic Warfare jammers from an Advanced Equipment (AE3) laptop with the terminal command `jammer`. A laptop only controls the jammers linked to its own AE3 network. So an active Wi-Fi jammer (`wifi_jamming`) can cut a team off from its own jammer controls, and an enemy who gets onto the network (router password, SSH) can switch them.

First version: terminal only. A desktop app is planned for later.

## How it works

- **Link.** `fnc_linkJammer [jammer, router, name]` (public, runs on the server) stores the router in the public variable `ewc_jammer_control_router` of the jammer and gives the jammer a short id for the terminal (`ewc_jammer_control_id`, counted up on the server, kept for the mission). The editor module links the jammers synced to it to the one synced router. It waits for `CBA_missionTime > 0` and tells the router from the jammers with `AE3_network_fnc_getRouters`, because AE3 sets up its routers during init. The Zeus module is placed on a jammer and offers the routers nearest first, or none to unlink.
- **Same network.** Two devices are in the same network when they have the same top router, like `AE3_network_fnc_sameNetwork`. That function is not public and the parent links (`AE3_network_parent`) are private, so `fnc_getNetworkParents` rebuilds them from the public `AE3_network_fnc_getRouters` and `getClients` (with cascaded routers) and `fnc_getNetworkRoot` follows them up. A router on the way that is destroyed or switched off cuts the device off (`objNull`), as AE3's own `AE3_network_fnc_resolve` and `ping` treat a router that is down. This matters for cascaded routers: AE3 only disconnects the laptops of a router that is switched off, child routers stay attached.
- **Command.** `CfgOsFunctions >> jammer` inherits from `OsFunction`. `AE3_armaos_fnc_device_initComplete` runs `link_init` over all of `CfgOsFunctions`, so the command is installed on every laptop and also works over SSH (there the laptop is the remote one). AE3 runs it scheduled on the client of the typing player. `fnc_osJammer` parses with `AE3_armaos_fnc_shell_getOpts` (three syntax variants: no argument, `list`, `on|off ID`) and prints with `shell_stdout`.
- **Listing** needs no request: `fnc_getJammers` reads the jammer map of Crow's (`crowsEW_main_jamMap`, on every machine) and keeps the jammers linked to a router of the laptop's network. Vehicle jammers of the compat addons (`ewc_common_isJammer`) are left out, they have crew switches with their own conditions.
- **Switching** is one CBA server event. `fnc_handleSwitch` checks the request again on the server: the unit must be the one AE3 gave the laptop to (`AE3_computer_mutex`, which `AE3_armaos_fnc_os_ssh` also sets on the remote laptop; not public, there is no getter), the laptop must be switched on (`AE3_power_fnc_isPoweredOn`) and that the jammer is still in `fnc_getJammers` of that laptop, then does what Crow's own (de)activate action does: the sound (`crowsEW_sounds_setSoundEnable`), the animation of a `Crows_dataterminal` and `crowsEW_main_toggleJammer`. The Spectrum signals of the Wi-Fi and BFT jammers re-sync on `crowsEW_main_updateJammers` by themselves. The server answers the unit with the id of the request, and the command waits up to 5 s for the answer to that id, so the result is printed before the next prompt and a late answer to a switch that timed out is dropped.

## Functions

| Function | Runs on | Purpose |
|---|---|---|
| `fnc_linkJammer` | any, links on the server | Public: links a jammer to a router or unlinks it |
| `fnc_moduleLinkJammer` | server | Editor module |
| `fnc_linkJammerZeus` | Zeus client | Zeus module: router and name of a jammer |
| `fnc_zeusRegister` | clients | Registers the Zeus module (ZEN) |
| `fnc_getNetworkParents` | any | Router of every network device, from the public AE3 getters |
| `fnc_getNetworkRoot` | any | Top router of the network of a device |
| `fnc_getJammers` | any | Jammers a laptop may switch |
| `fnc_osJammer` | client of the terminal | The terminal command |
| `fnc_handleSwitch` | server | Checks and switches, answers the terminal |

## Not in this version

- Vehicle jammers (DUKE, CG13, Hummel, R-142N, `ewc_common_isJammer`). They have crew and engine conditions. If they are wanted later, route them through the server event of their `ewc_common_fnc_registerSwitch` entry, not through Crow's directly.
- Changing radii. Crow's can only remove a jammer and add it again.
- The desktop app. The ready-made `deviceList` app kind of AE3 sends the shared commands `dev_request` and `dev_action`, which one mod per name can handle, so it would clash with other mods. A `script` app with our own commands is the way, see issue #91.

## Coupling to other mods

- AE3: `AE3_network_fnc_getRouters`, `getClients`, `AE3_power_fnc_isPoweredOn`, `AE3_armaos_fnc_shell_getOpts`, `shell_stdout` (all public), `CfgOsFunctions` / `OsFunction` (config interface of AE3's own commands). Read only, not public: the variables `AE3_cap_isRouter` and `AE3_computer_mutex`, which have no getter
- Crow's: `crowsEW_main_jamMap`, `crowsEW_main_toggleJammer`, `crowsEW_sounds_setSoundEnable`, the class `Crows_dataterminal`. Not marked public, the jammer modules of Crow's use them the same way
- ZEN: `zen_custom_modules_fnc_register`, `zen_dialog_fnc_create`, `zen_common_fnc_showMessage`

## Dependencies

- [Advanced Equipment](https://steamcommunity.com/workshop/filedetails/?id=2888888564) (`ae3_main`, `ae3_network`, `ae3_armaos`, `ae3_power`), 2.1.0.5 or later for the public network and power getters
- [Crow's Electronic Warfare](https://github.com/Crowdedlight/Crows-Electronic-Warfare) (`crowsEW_main`, `crowsEW_editormodules`)
- [Zeus Enhanced](https://steamcommunity.com/sharedfiles/filedetails/?id=1779063631) (`zen_custom_modules`, `zen_dialog`)

## Maintainer

- Andx
