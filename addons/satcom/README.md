# Satcom

Portable satcom dishes: an inventory item that a player deploys as one of the small vanilla satellite dishes (Contact platform props, `SatelliteAntenna_01_Small_{Black,Olive,Sand}_F`) or as the Starlink terminal `ewc_satcom_starlink`, a model of its own. A deployed dish is a satcom of Crow's Electronic Warfare: players within its radius get a boosted radio signal and cannot be jammed. Picking the dish up stops the satcom and gives the item back.

## How it works

- `XEH_preStart` collects the items with the config entry `ewc_satcom_object` (the class they deploy as) and caches them in `uiNamespace`. Another mod adds a dish with one item class that has the entry, no code.
- `fnc_addActions` (clients, postInit) adds an ACE self-action *Equipment > Deploy satcom dish* with one child per dish item the player carries, and *Pick up satcom dish* on the main actions of every class a dish deploys as.
- **Deploy**: `fnc_place` shows a local ghost of the dish in front of the player. It follows the view, the mouse wheel turns it, the left mouse button places it, the right one cancels. It is ported from the deployable tarps of Tactical Tarps, which follow ACE's own placement. Two helpers that ACE does not mark as public are replaced: the confirm is a plain `addAction` on `DefaultAction` (what `ace_common_fnc_addActionEventHandler` does inside, so the click does not fire the weapon), the mouse hint a `hintSilent`. `fnc_startDeploy` runs the progress bar (`DEPLOY_TIME`, 6 s, in `script_component.hpp`), `fnc_deploy` takes the item and creates the dish on the client, and the server (`fnc_handleDeployed`) stores the item on the dish (public variable `ewc_satcom_item`, it marks a deployed dish) and calls `ewc_common_fnc_setSatcom` with the radius of the setting.
- **Pick up**: only dishes with `ewc_satcom_item` offer it, so dishes placed in the editor stay props. `fnc_startPickUp` marks the dish as in use (`ewc_satcom_inUse`) and runs the progress bar (`PICKUP_TIME`, 1.5 times `DEPLOY_TIME`). The server (`fnc_handlePickUp`) stops the satcom, deletes the dish and sends the item back to the player, who adds it with `ace_common_fnc_addToInventory` (on the ground if the inventory is full). Doing it on the server means two players who finish at the same time cannot get two items.
- Everything else is the satcom handling of Crow's: it removes the satcom of a destroyed or deleted dish, measures the radius from where the dish is now and shows it to Zeus.

## Functions

| Function | Runs on | Purpose |
|---|---|---|
| `fnc_addActions` | clients | The deploy and pick up actions |
| `fnc_place` | client | Ghost placement of the dish |
| `fnc_startDeploy` | client | Progress bar of the deploy |
| `fnc_deploy` | client | Takes the item and creates the dish |
| `fnc_handleDeployed` | server | Marks the dish as deployed and makes it a satcom |
| `fnc_canPickUp` | clients | Condition of the pick up action |
| `fnc_startPickUp` | client | Progress bar of the pick up |
| `fnc_handlePickUp` | server | Stops the satcom, deletes the dish, returns the item |

## Settings

Global (`ewc_satcom_*`), the server decides.

| Setting | Default | Purpose |
|---|---|---|
| `radius` | 20 m | Radius of a deployed dish, 1 to 50 m (the range of Crow's Zeus module). Applied to dishes deployed afterwards |

## Coupling to other mods

- `crowsEW_main_addSatcom`, `crowsEW_main_removeSatcom` (through `ewc_common_fnc_setSatcom`). Crow's Zeus modules raise them too, they are not marked as public. With ACRE the boost only works in multiplayer with [Crow's PR #196](https://github.com/Crowdedlight/Crows-Electronic-Warfare/pull/196)
- ACE: `ace_interact_menu_fnc_createAction`, `addActionToClass`, `ace_common_fnc_progressBar`, `doAnimation`, `displayText`, `addToInventory`, the item base `ACE_ItemCore`

## Starlink model

`ewc_satcom_starlink` inherits from `SatelliteAntenna_01_Small_Sand_F` and only swaps the model, so it behaves like the vanilla dishes. `data/` holds the model, its textures and rvmat, licensed CC BY 4.0 (see `data/LICENSE`): based on [Starlink Satellite Dish](https://sketchfab.com/3d-models/starlink-satellite-dish-84476761b87546d2b23fecfaaf849326) by Malacodart.

- Made in Blender with [Arma 3 Object Builder](https://github.com/MrClock8163/Arma3ObjectBuilder): scaled to a Starlink Standard terminal (0.59 m plate, 0.8 m high), turned so the dish faces +Y
- LODs: Resolution 0 (the Sketchfab mesh, 344 faces), Geometry (six convex components: plate, mast and four legs, 3 kg), Fire Geometry and Shadow Volume (the same components)
- Textures 1024² converted with `hemtt utils paa convert`: `_co`, `_nohq` (green channel inverted from the OpenGL normal map), `_smdi` (gloss from the roughness map, flat specular). Super shader rvmat
- The P3D is unbinarized (MLOD) when built without Arma 3 Tools. HEMTT binarizes it on a machine that has them
- The source `.blend` and PNGs are not in the repository

## Dependencies

- [Crow's Electronic Warfare](https://github.com/Crowdedlight/Crows-Electronic-Warfare) (`crowsEW_main`)
- [ACE3](https://github.com/acemod/ACE3) (`ace_common`, `ace_interact_menu`, `ace_interaction`)
- Arma 3 Contact platform props (`A3_Props_F_Enoch_Military_Camps`), free for everybody

## Maintainer

- Andx
