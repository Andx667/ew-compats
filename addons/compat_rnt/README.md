# Compat RnT Vehicles

Adds the **Fuchs 1A4 Hummel** to the Redd'n'Tank Vehicles: a jammer vehicle that jams ACRE radios while it is switched on. It is modelled on the Störpanzer Hummel of the Bundeswehr, a Fuchs variant that jams communications in VHF and UHF. It jams radios only, no drones.

## How it works

- Redd'n'Tank has no EloKa variant of its Fuchs 1A4 and no jammer antenna, so the Hummel is the Jäger variant with a new name (`CfgVehicles.hpp`): `EWC_RnT_Fuchs_1A4_Hummel_Flecktarn`, `_Tropentarn` and `_Wintertarn`. They have the model, textures and crew of the Jäger. They carry `ewc_compat_rnt_jammer = 1` and so are jammers of the registry in `ewc_common` (`CfgEWC >> Jammers >> RNT_HUMMEL`, radio only), which registers them once on the server as disabled jammers in Crow's Electronic Warfare.
- What sets it apart are 12 whip antennas along the roof edges, short ones in front and long ones behind, like on the photos of the real Hummel. We cannot change the Redd'n'Tank model and it has no memory points for them, so `fnc_initVehicle` attaches them with `attachTo` at fixed offsets from the model centre (`ANTENNAS` in `script_component.hpp`). They are local simple objects (`createSimpleObject [..., true]`) that every machine with an interface creates for itself, JIP included, because the init runs everywhere: no network traffic and nothing on a dedicated server. They are stored in `ewc_compat_rnt_antennas` on the vehicle, stay on the wreck and are deleted with the vehicle by a `Deleted` event handler.
- The two rear roof hatches are the FFV seats `ffv_hatch_L` and `ffv_hatch_R` (turrets [0,1] and [0,2]), which the engine opens when the passenger turns out. The antenna feet stand right next to their opening, so the Hummel keeps them closed with `forceHideGunner = 1` on both (`HUMMEL_TURRETS` in `CfgVehicles.hpp`). The turret order decides the turret paths, which the user actions of Redd'n'Tank use, so all turrets are listed again in the order of the Jäger.
- The crew switches the Hummel with the switch actions of `ewc_common` (scroll wheel or ACE self-interaction, driver, commander and gunners), see `ewc_common_actionMode`. The addon registers its switch with `ewc_common_fnc_registerSwitch` (id `hummel`).
- `fnc_handleToggle` (server) checks the request (`fnc_canActivate`: enabled in the settings, vehicle alive, engine running) and stores the state in the public variable `ewc_compat_rnt_on`. `fnc_syncJammer` (server) then brings the Crow's Electronic Warfare jammer in line with it through `ewc_common_fnc_setJammer`, with the radius of the settings, and tells the crew with the hint of `ewc_common_fnc_notifyState`.
- The Hummel switches itself off when the engine stops, the vehicle is destroyed or the setting turns it off. A switch that was blocked stays off when the engine starts again. The `Engine` and `Killed` event handlers (`fnc_initVehicle`, on every machine because they fire where the vehicle is local) raise the sync on the server.
- Crow's Electronic Warfare adds its own (de)activate actions to every jammer. They would change its state without the switch. `ewc_common` removes them from the vehicles of the registry.

## Functions

| Function | Runs on | Purpose |
|---|---|---|
| `fnc_initVehicle` | every machine | Class event handler for the Hummel: switch actions, antennas and the `Engine` and `Killed` handlers |
| `fnc_canActivate` | any | Can the Hummel be switched on |
| `fnc_getBlockReason` | any | Why it cannot be on (disabled, destroyed, engine stopped), or an empty text |
| `fnc_handleToggle` | server | Checks a switch request and stores the state |
| `fnc_syncJammer` | server | Matches the jammer to the switch and the vehicle: state, radius and hint |

## Settings

| Setting | Default | |
|---|---|---|
| Enable Hummel jamming | on | If off, the Hummel does not jam. Set by the server. A running Hummel switches off the next time the engine stops or it is switched |
| Hummel jamming radius (m) | 500 | Radius with full jamming strength, 100 to 2000 m. The falloff band beyond it is 1.5 times the radius. Set by the server, applied the next time the Hummel is switched on or off |

How the crew switches it is the setting `ewc_common_actionMode`.

## Limitations

- The antennas are only for show and fixed to the hull: they do not follow the turret or the hatches and cannot be damaged. The offsets come from rays cast down on the Fire Geometry of the Fuchs, so they need checking again if Redd'n'Tank changes its model.
- The range is a gameplay value. The data sheet of the Bundeswehr gives none.
- Everybody in range is jammed, including the own crew and allies. Crow's Electronic Warfare has no immunity apart from Zeus.
- Redd'n'Tank says its vehicles are made for co-op play and that some functions may not work with AI.
- Crow's Electronic Warfare only works in multiplayer.

## Antenna models

`data/antenna_short.p3d` (1.9 m, spring base) and `data/antenna_long.p3d` (2.4 m) are the two radio antennas of [Military Landvehicle Kit 1.2](https://sketchfab.com/3d-models/military-landvehicle-kit-12-cc0-91f495435f624d8b97a768f692aa6ce9) by britdawgmasterfunk. The author says CC0, Sketchfab lists CC BY 4.0, so they are credited as CC BY 4.0 (see `data/LICENSE`). Kit 1.0 has the same two antennas at another scale.

- Made in Blender with [Arma 3 Object Builder](https://github.com/MrClock8163/Arma3ObjectBuilder): upright, foot at the origin
- LODs: Resolution 0 (the kit mesh, 1004 and 1780 faces), Resolution 1 and 2 (decimated, 301/80 and 534/267 faces), Geometry (a box in the foot, 1 kg, only for the named property `autocenter = 0`, so the model centre is the foot and the offsets in `ANTENNAS` are where the foot stands). Simple objects have no physics, so the Geometry cannot push the vehicle
- No View Geometry and no Shadow Volume: a rod of about 1 cm hides nothing and casts almost no shadow
- Plain procedural colours (`#(argb,8,8,3)color(...)`), olive foot and near-black rod, one for all three camouflages. No PAA or rvmat
- The P3Ds are unbinarized (MLOD) when built without Arma 3 Tools. The source `.blend` is not in the repository
- `data/ui/hummel_<camouflage>_preview.jpg` are the editor previews, made with `hemtt photoshoot rnt` (the profile that loads Redd'n'Tank; without it the addon is skipped and photoshoot crashes on the missing screenshots). Photoshoot creates the next vehicle in the frame it deletes the last one, and the antennas, attached one frame later in InitPost, sometimes end up beside a vehicle. Check the pictures, delete a wrong one and run it again: photoshoot only renders missing previews

## Dependencies

- [Redd'n'Tank Vehicles](https://steamcommunity.com/sharedfiles/filedetails/?id=1128145626) (`Redd_Tank_Fuchs_1A4`)
- [Crow's Electronic Warfare](https://steamcommunity.com/sharedfiles/filedetails/?id=2515887728) (`crowsEW_main`)

## Maintainer

- Andx
