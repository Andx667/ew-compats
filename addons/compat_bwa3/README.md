# Compat BWA3

The Dingo 2 CG13 also jams ACRE radios, in addition to the IED jammer. Both are controlled with the same switch.

Every Dingo 2 without a CG13 gets a SATCOM switch: while it is on, the engine runs and the vehicle stands still, it is a SATCOM of Crow's Electronic Warfare with a radius of 5 m.

## How it works

- BWA3 switches the CG13 only through the variable `BWA3_Dingo2_ECM_on` (user actions `TurnOnCG13` / `TurnOffCG13`) and offers no event or callback. The `statement` entries of both user actions are therefore overridden in `CfgVehicles.hpp`: they still set the variable and additionally send the event `ewc_compat_bwa3_ecmToggled` to the server.
- BWA3 switches the CG13 off when the engine stops (its `POWER_FAILURE` transition) without any event. An `Engine` event handler (`fnc_initVehicle`) therefore sends the same event with `false` when the engine stops. It has to be registered on every client, because `Engine` only fires where the vehicle is local. When the engine stops without a driver (he got out) while the CG13 is on, the handler starts it again, because getting out stops the engine and an eject does not.
- Every vehicle with `BWA3_hasECM = 1` is a jammer of the registry in `ewc_common` (`CfgEWC >> Jammers >> BWA3_CG13`). `ewc_common_fnc_setJammer` registers it on the server as a radio jammer in Crow's Electronic Warfare when the CG13 is first switched on, see the common addon.
- `fnc_handleToggle` switches the jammer with `ewc_common_fnc_setJammer`. The jamming itself (ACRE interference, Spectrum Device signal, cleanup on destruction) is done by Crow's Electronic Warfare.
- Crow's Electronic Warfare adds its own (de)activate actions to every jammer. They would change its state without the CG13 switch. `ewc_common` removes them from the Dingos, see the common addon.

## SATCOM

- A Dingo 2 without a CG13 is `BWA3_Dingo2_base` without `BWA3_hasECM = 1` (`HAS_SATCOM`). Those have no entry in the jammer registry, so they get no `ewc_common_vehicleInit`: an `InitPost` class event handler on `BWA3_Dingo2_base` (`fnc_initSatcom`) adds the scroll wheel actions. The switch is registered with `ewc_common_fnc_registerSwitch` (id `bwa3_satcom`, state in the public variable `ewc_compat_bwa3_satcomOn`), the ACE actions are added once for all land vehicles.
- `fnc_handleSatcomToggle` (server, event `ewc_compat_bwa3_satcomToggle`) switches it with `ewc_common_fnc_setSatcom` and the hint of `ewc_common_fnc_notifyState`. It refuses to switch on while `fnc_getSatcomBlockReason` gives a reason: setting off, destroyed, engine off, or faster than 1 km/h.
- BWA3 has no engine event for a Dingo without a CG13, and there is none for moving. `isEngineOn` and `speed` are synced, so `fnc_satcomLoop` checks every Dingo with the SATCOM on, on the server every second, and switches it off with the reason. It only runs while at least one SATCOM is on.

## Functions

| Function | Runs on | Purpose |
|---|---|---|
| `fnc_initVehicle` | every machine | Class event handler for vehicles with `BWA3_hasECM`: watches the `Engine` event |
| `fnc_initSatcom` | every machine | Class event handler of the Dingo 2: scroll wheel actions of the SATCOM for Dingos without a CG13 |
| `fnc_getSatcomBlockReason` | every machine | Why the SATCOM cannot be on (`disabled`, `dead`, `engine`, `moving`) |
| `fnc_handleSatcomToggle` | server | Switches the SATCOM (`ewc_compat_bwa3_satcomToggle`) and starts or ends the check |
| `fnc_satcomLoop` | server | Every second while a SATCOM is on: switches it off when it is blocked |
| `fnc_handleToggle` | server | Switches that jammer with the CG13 (`ewc_compat_bwa3_ecmToggled`, with the reason when the engine switched it off) and shows the hint of `ewc_common_fnc_notifyState` |

## Settings

| Setting | Default | |
|---|---|---|
| Enable BWA3 CG13 jamming | on | If off, the Dingos do not jam radios. Set by the server |
| Enable Dingo SATCOM | on | If off, the Dingos without a CG13 have no SATCOM. Set by the server |
| Dingo SATCOM radius (m) | 5 | 1 to 50 m, applied the next time it is switched on. Set by the server |

## Limitations

- Everybody in range is jammed, including the own crew and allies. Crow's Electronic Warfare has no immunity apart from Zeus.
- The full jamming radius is the radius of the IED jammer (40 m, hardcoded in BWA3, so `ECM_EFFECTIVE_RADIUS` has to be adjusted if BWA3 changes it). The falloff radius is 1.5 times that.
- A triggered IED explodes when it leaves the jamming range. This is BWA3's own behaviour.
- IEDs of CUP (`CUP_IED_V1_Ammo` to `V4`) are not jammed: BWA3 only jams `PipeBombBase`, and CUP's IEDs derive from `MineBase`. This is BWA3's own behaviour.
- Crow's Electronic Warfare only works in multiplayer.

## Dependencies

- [BWmod](https://steamcommunity.com/sharedfiles/filedetails/?id=1200127537) (`bwa3_dingo2`)
- [Crow's Electronic Warfare](https://steamcommunity.com/sharedfiles/filedetails/?id=2515887728) (`crowsEW_main`). The SATCOM uses `crowsEW_main_addSatcom` / `removeSatcom` through `ewc_common_fnc_setSatcom`

## Maintainer

- Andx
