# Compat BWA3

The Dingo 2 **CG13** also jams ACRE radios, in addition to the IED jammer. Both are controlled with the same switch.

Every Dingo 2, with or without a CG13, has a **SATCOM**: switched on while the engine runs and the vehicle stands still, the crew and anybody at an open door have a boosted radio signal and cannot be jammed, the SATCOM of Crow's Electronic Warfare.

!!! note "Gameplay values"
    The real CG13 is reported to offer reactive, active and combined jamming. This addon mimics the **active** mode: the jammer is either on or off and, while on, jams continuously in its whole radius.

## Controls

Switch the CG13 with its own actions, `TurnOnCG13` / `TurnOffCG13`. The radio jammer follows it.

Every change of state shows a silent hint to everybody in the vehicle, for example *CG13 on* or *CG13 off: engine stopped*. The reason is only given when the engine stopped.

## SATCOM

The driver, commander or gunner switches it with *Turn on SATCOM* / *Turn off SATCOM* (scroll wheel or ACE self-interaction, see the setting `ewc_common_actionMode` on [Common](common.md)). It can only be switched on while the engine runs and the Dingo stands still, and it goes off by itself within a second when the engine stops or the Dingo starts moving, with a hint like *SATCOM off: vehicle moving*. Switch it on again once the vehicle stands.

- Radius: **5 m** from the centre of the Dingo (setting), enough for the crew and somebody standing at an open door.
- Inside the radius nobody is jammed, also within the full radius of a jammer. Outside it the SATCOM does nothing.
- The antenna is the Explorer 27 SATCOM antenna that the Dingo model already carries, nothing is added to it.
- The driver getting out stops the engine, so the SATCOM goes off with it. On a Dingo with the CG13 on, the engine keeps running and so does the SATCOM.
- On a Dingo with a CG13, the CG13 and the SATCOM are independent switches. With both on, the crew and anybody within the SATCOM radius are not jammed by their own CG13, everybody else in its range is.

!!! warning "ACRE in multiplayer"
    With ACRE, the SATCOM of Crow's Electronic Warfare only boosts players on a dedicated server, or anybody but the host, with [Crow's PR #196](https://github.com/Crowdedlight/Crows-Electronic-Warfare/pull/196). TFAR is not affected.

## Range

| | Radius |
|---|---|
| Full jamming (effective) | **40 m** |
| Falloff band beyond that | **60 m** |
| Outer edge | **100 m** |

The 40 m is the IED jammer radius hardcoded in BWA3. The falloff band is 1.5 times that.

## Settings

### `ewc_compat_bwa3_enableCG13`

- Name: Enable BWA3 CG13 jamming
- Type: `CHECKBOX`
- Default: `true`
- Set by: the server
- Purpose: if off, the Dingos do not jam radios. The CG13 and its IED jamming of BWA3 are not affected.

### `ewc_compat_bwa3_enableSatcom`

- Name: Enable Dingo SATCOM
- Type: `CHECKBOX`
- Default: `true`
- Set by: the server
- Purpose: if off, the Dingos have no SATCOM. Turning it off takes every running SATCOM down within a second.

### `ewc_compat_bwa3_satcomRadius`

- Name: Dingo SATCOM radius (m)
- Type: `SLIDER`, 1 to 50
- Default: `5`
- Set by: the server
- Purpose: distance from the centre of the Dingo within which the SATCOM works. Applied the next time it is switched on.

### Complete example

``` cpp
// cba_settings.sqf
force ewc_compat_bwa3_enableCG13 = false; // default: true
force ewc_compat_bwa3_enableSatcom = true; // default: true
force ewc_compat_bwa3_satcomRadius = 5; // default: 5
```

## Quirks

- **The driver getting out does not stop a running CG13.** Arma stops the engine when the driver gets out, which would switch the CG13 off, but not when he ejects. The addon starts the engine again when it stops without a driver while the CG13 is on, so both ways of leaving behave the same. The engine keeps running until somebody stops it.
- **Engine off means jammer off.** BWA3 switches the CG13 off when the engine stops, without any event. The addon watches the `Engine` event and switches the radio jammer off as well. It has to be registered on every client, because the event only fires where the vehicle is local.
- **A triggered IED explodes when it leaves the jamming range.** The jammer does not defuse an IED, it only holds it back. If an IED is triggered while it is inside the 40 m, it stays inert, but it explodes as soon as the jammer is out of range, for example when the Dingo drives on or the engine is stopped. This is BWA3's own behaviour, this addon does not change it. Keep the distance until the IED is cleared.
- **IEDs of CUP are not jammed.** BWA3 only jams `PipeBombBase` IEDs, which are the vanilla and ACE IEDs. The IEDs of CUP (`CUP_IED_V1_Ammo` to `V4`) derive from `MineBase` and explode as normal, also with CUP and BWmod loaded together. This is BWA3's own behaviour, this addon does not change it. The CUP DUKE of [Compat CUP DUKE](compat-cup-duke.md) does jam them.
- **IEDD is not jammed.** The IEDs of [IEDD](https://github.com/prisonerMO/iedd) are ordinary objects triggered by IEDD's own scripts, so neither the Dingo CG13 nor this addon can stop them. They do not conflict with the radio jamming.
- **Everybody in range is jammed**, including the own crew and allies. Crow's Electronic Warfare has no immunity apart from Zeus.
- **Multiplayer only.** Crow's Electronic Warfare does not work in singleplayer.

## How it works

BWA3 switches the CG13 only through the variable `BWA3_Dingo2_ECM_on` and offers no event. The `statement` of both user actions is overridden: they still set the variable and additionally send `ewc_compat_bwa3_ecmToggled` to the server. The server registers a vehicle with `BWA3_hasECM = 1` as a radio jammer (`VoiceCommsJammer`) when its CG13 is first switched on (once `CBA_missionTime > 0`) and switches it with `ewc_common_fnc_setJammer`. The jamming itself (ACRE interference, Spectrum Device signal, cleanup on destruction) is done by Crow's Electronic Warfare.

The SATCOM uses the switch actions of `ewc_common` and, on the server, `ewc_common_fnc_setSatcom`. While a SATCOM is on, a check on the server every second switches it off when the engine stops, the Dingo moves (above 1 km/h), it is destroyed or the setting is turned off. The check stops when no SATCOM is on.

## Dependencies

- [BWmod](https://steamcommunity.com/sharedfiles/filedetails/?id=1200127537)
- [Crow's Electronic Warfare](https://steamcommunity.com/sharedfiles/filedetails/?id=2515887728)
