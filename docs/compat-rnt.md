# Compat RnT Vehicles

The **Fuchs 1A4 Hummel** of this addon is a jammer vehicle for the [Redd'n'Tank Vehicles](https://steamcommunity.com/sharedfiles/filedetails/?id=1128145626). While it is switched on it jams ACRE radios around the vehicle. It is modelled on the Störpanzer Hummel of the Bundeswehr, a Fuchs variant that jams communications in VHF and UHF, so it jams radios only and no drones.

!!! note "A Jäger with antennas"
    Redd'n'Tank has no EloKa variant of its Fuchs. The Hummel is the Jäger variant with a new name, in Flecktarn, Tropentarn and Wintertarn, and with twelve whip antennas along the roof edges like the real one, so you can tell it apart. The antennas are an artistic interpretation that tries to come as close as possible to the original Hummel, not a 1:1 model of it. You find it in the editor in the Redd'n'Tank category next to the other Fuchs.

!!! note "Gameplay values"
    The Bundeswehr gives no jamming range for the Hummel. The radius is a gameplay value, 500 m by default.

## Controls

*Activate Hummel* / *Deactivate Hummel* with the scroll wheel or the ACE self-interaction, see [Common](common.md#settings). Only the **driver, commander and gunners** get the switch. It needs the **engine running**. The Hummel switches off when the engine stops, the vehicle is destroyed or the setting turns it off, and stays off when the engine starts again.

Every change of state shows a CBA notification to everybody in the vehicle, for example *Hummel on* or *Hummel off: engine stopped*.

## Range

| Radio effective | Radio falloff band | Radio outer edge |
|---|---|---|
| **500 m** | 750 m | **1250 m** |

The radius is a setting, the values above use the default. The falloff band is 1.5 times the effective radius.

## Settings

### `ewc_compat_rnt_enable`

- Name: Enable Hummel jamming
- Type: `CHECKBOX`
- Default: `true`
- Set by: the server
- Purpose: if off, the Hummel does not jam. A running Hummel switches off the next time the engine stops or it is switched.

### `ewc_compat_rnt_radius`

- Name: Hummel jamming radius
- Type: `SLIDER`
- Range: `100` to `2000` m
- Default: `500`
- Set by: the server
- Purpose: radius with full jamming strength. Applied the next time the Hummel is switched on or off.

### Complete example

``` cpp
// cba_settings.sqf
force ewc_compat_rnt_enable = false; // default: true
force ewc_compat_rnt_radius = 800; // default: 500
```

## Quirks

- **Everybody in range is jammed**, including the own crew and allies.
- **A changed radius is applied at the next switch**, not while the Hummel is on.
- **Multiplayer only.** Crow's Electronic Warfare does not work in singleplayer.
- **The rear roof hatches stay closed.** The two rear passengers (*Linke Luke*, *Rechte Luke*) cannot turn out and fire from the hatches like in the Jäger, they keep their seats inside.
- **The antennas are only for show.** They do not move with the turret or the hatches, cannot be shot off, and stay on the wreck. They stand up whether the Hummel is on or off.

## How it works

The Hummel classes carry a marker in their config, so `ewc_common` registers a Hummel as a radio jammer in Crow's Electronic Warfare when it is first switched on. The switch is the one of the DUKE and the Boomerang (`ewc_common`), and the server brings the jammer in line with it, the engine and the settings. The jamming itself (ACRE interference, Spectrum Device signal, cleanup on destruction) is done by Crow's Electronic Warfare.

Every player's game puts the antennas on the Hummel by itself, so they cost no network traffic.

## Credits

The antennas are based on the radio antennas of [Military Landvehicle Kit 1.2](https://sketchfab.com/3d-models/military-landvehicle-kit-12-cc0-91f495435f624d8b97a768f692aa6ce9) by britdawgmasterfunk. The author releases the kit as CC0; Sketchfab lists it under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). They were taken out of the kit, given plain colours and converted for Arma 3.

## Dependencies

- [Redd'n'Tank Vehicles](https://steamcommunity.com/sharedfiles/filedetails/?id=1128145626)
- [Crow's Electronic Warfare](https://steamcommunity.com/sharedfiles/filedetails/?id=2515887728)
