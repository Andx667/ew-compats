# Jammer Control

Switch the jammers of Crow's Electronic Warfare from an [Advanced Equipment](https://steamcommunity.com/workshop/filedetails/?id=2888888564) (AE3) laptop. A jammer is linked to an AE3 router, and every laptop in the network of that router can list and switch it with the terminal command `jammer`, also over SSH.

That makes the network part of the fight:

- A [Wi-Fi jammer](wifi-jamming.md) that cuts the laptops off from their router also cuts the team off from its own jammer controls.
- An enemy who gets onto the network (router password, SSH into a laptop) can switch the jammers.

## Setting up

- **Editor:** place the module **Link Jammer to Router** (Crow's Electronic Warfare modules) and sync it to one AE3 router and to the jammers. The jammers are any objects registered as a jammer of Crow's Electronic Warfare, for example with its own jammer module or the [Wi-Fi](wifi-jamming.md) and [BFT](bft-jamming.md) jammers of this mod.
- **Zeus:** place the module **Link Jammer to Router** on a jammer. Pick the router (nearest first, or *None* to unlink) and, if you like, the name the terminal shows.
- **Script:** `ewc_jammer_control_fnc_linkJammer`, see below.

Vehicle jammers of this mod (DUKE, CG13, Hummel, R-142N) cannot be linked, they keep their crew switch.

## In the terminal

``` text
jammer              lists the jammers linked to this network
jammer list         the same
jammer on 2         switches jammer 2 on
jammer off 2        switches jammer 2 off
jammer -h           help
```

The list shows the id, the state, the name and the range of every jammer:

``` text
ID  STATE  JAMMER (RANGE)
1  ON  Relay north (600 m)
2  OFF  Data Terminal (300 m)
```

The id stays the same for the whole mission, also when a jammer is linked again. The laptop has to be switched on and connected to the network: the server checks both before it switches anything. Every router between the laptop and the jammer has to be up: destroying or switching off the router a jammer is linked to, or one above it, cuts the jammer off from the laptops.

## Public function

### `ewc_jammer_control_fnc_linkJammer`

Links a jammer to a router, or unlinks it.

- Runs on: any machine, the link is made on the server
- Arguments: `[jammer, router, name]`
    - `jammer`: an object registered as a jammer in Crow's Electronic Warfare
    - `router`: an AE3 router, `objNull` to unlink. Default `objNull`
    - `name`: shown in the terminal, `""` for the display name of the object. Default `""`
- Returns: nothing

``` cpp
// initServer.sqf, once the jammer is registered in Crow's
[myJammer, myRouter, "Relay north"] call ewc_jammer_control_fnc_linkJammer;
```

## Not yet

- A desktop app for the AE3 desktop. It is planned.
- Vehicle jammers and changing the radius of a jammer.

## Dependencies

- [Advanced Equipment](https://steamcommunity.com/workshop/filedetails/?id=2888888564) 2.1.0.5 or later
- [Crow's Electronic Warfare](https://steamcommunity.com/sharedfiles/filedetails/?id=2515887728)
- [Zeus Enhanced](https://steamcommunity.com/sharedfiles/filedetails/?id=1779063631)
