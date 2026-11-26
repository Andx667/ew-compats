# Satcom

Portable satcom dishes. A player carries a **Satcom Dish** in the inventory and deploys it: black, olive or sand as one of the small satellite dishes of the base game, or **Starlink** as a Starlink terminal on its stand. While the dish stands, every player within its radius has a boosted radio signal and cannot be jammed, the SATCOM of Crow's Electronic Warfare. Picking it up stops the satcom and puts the item back in the inventory.

## Using it

1. Have a Satcom Dish in the inventory (Arsenal, *Misc. items*).
2. ACE self-interaction, **Equipment > Deploy satcom dish**, then the dish.
3. A preview of the dish follows your view. Turn it with the mouse wheel, place it with the left mouse button, cancel with the right one. It cannot be placed in water.
4. After a progress bar of 6 seconds the dish stands and works.
5. To take it down, interact with the dish, **Pick up satcom dish** (9 seconds). Anybody can pick up a dish, the enemy too. If the inventory is full, the item lands on the ground.

Only dishes deployed from the item are satcoms and can be picked up. The same dishes placed in the editor stay props: use Crow's Zeus module *Set SATCOM* for those.

## Settings

The setting is global (CBA addon options, `ewc_satcom_*`), so the server decides.

| Setting | Default | Purpose |
|---|---|---|
| Satcom radius | 20 m | Players within this distance of a deployed dish are boosted, 1 to 50 m. Applied to dishes deployed afterwards. |

## What a satcom does

The effect is Crow's Electronic Warfare's own SATCOM: about four times the radio range, and no jamming inside the radius, even within the full radius of a jammer. Zeus sees the radius as a blue circle. A destroyed or deleted dish stops working.

!!! warning "ACRE in multiplayer"
    With ACRE, the SATCOM of Crow's Electronic Warfare only boosts players on a dedicated server, or anybody but the host, with [Crow's PR #196](https://github.com/Crowdedlight/Crows-Electronic-Warfare/pull/196). TFAR is not affected.

## For mission makers and mod authors

`ewc_common_fnc_setSatcom` makes any object a satcom from a script, see [Common](common.md#ewc_common_fnc_setsatcom).

Another mod can add a dish with an item that names the object it deploys as:

``` cpp
class CfgWeapons {
    class ewc_satcom_dish_base;
    class my_satcom_dish: ewc_satcom_dish_base {
        scope = 2;
        displayName = "My Satcom Dish";
        ewc_satcom_object = "SatelliteAntenna_01_Black_F";
    };
};
```

## Credits

The Starlink terminal is based on [Starlink Satellite Dish](https://sketchfab.com/3d-models/starlink-satellite-dish-84476761b87546d2b23fecfaaf849326) by Malacodart, licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). It was scaled, converted for Arma 3 and given collision and shadow models.

## Dependencies

- [Crow's Electronic Warfare](https://steamcommunity.com/sharedfiles/filedetails/?id=2515887728)
- [ACE3](https://steamcommunity.com/sharedfiles/filedetails/?id=463939057)
