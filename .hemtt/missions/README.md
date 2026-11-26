# Test missions

Multiplayer missions on the VR map to test the compats by hand. Crow's Electronic Warfare does not work in singleplayer, so host them on LAN (or from the editor with *Play in Multiplayer*).

| Mission | Mods besides CBA, Crow's, ACRE | Tests |
|---|---|---|
| `EWC_Test_BWA3.VR` | BWmod | Dingo 2 CG13, Dingo 2 SATCOM |
| `EWC_Test_RHS_USAF.VR` | RHS USAF | DUKE, Boomerang |
| `EWC_Test_RHS_AFRF.VR` | RHS AFRF | GAZ-66 (R-142N) |
| `EWC_Test_CUP.VR` | CUP Vehicles | DUKE, Boomerang |
| `EWC_Test_BFT.VR` | cTab | BFT Jamming (Blackout, Drift, Mixed, Spoof) |
| `EWC_Test_AE3.VR` | Advanced Equipment | Jammer Control (terminal command `jammer`) |
| `EWC_Test_Satcom.VR` | none | Satcom dishes against a radio jammer |

Each mission spawns a few vehicles of the covered class family (found in the loaded configs) at `[0,0]`: the BWA3 and RHS AFRF missions one vehicle, the CUP and RHS USAF missions one vehicle per category (the editor subcategory: cars, MRAPs, APCs, tanks...) and system, preferring a vehicle with both a DUKE and a Boomerang, a **jam lane** 150 m north with IEDs 20 to 130 m east of the parking spot and radio signs 20 to 130 m west of it. Each mission forces the setting `ewc_common_debug` on (`cba_settings.sqf`), so the debug overlay shows the state of each system and whether IEDs, units and drones in range are jammed. The mission labels only add the IED distances, the lane signs and the drone distances. The RHS AFRF mission has no IEDs, as the R-142N does not jam them: it has radio signs and drones up to 1250 m from the lane spot. The CUP and RHS USAF missions also have a **Boomerang range** with a hostile and a friendly shooter.

The **BFT mission** has no mod-specific vehicles, it needs cTab and uses vanilla units. Real units with cTab devices (infantry groups, an MRAP, a truck, an APC, a tank, a helicopter and a patrolling MRAP) stand around the parking spot in the center of the map (4096, 4096), a few more near the **Spoof** station. One jammer station of each type (Spoof 1 km north, Blackout 1.2 km west, Drift 1.2 km east, Mixed 1.2 km south, effective radius 200 m, falloff to 600 m) is switched on at the start, with scroll wheel actions to switch each one and to teleport. The mission forces `ctab_core_bft_mode` to `2`, which Drift needs. Ghosts of Spoof are copies of the real units: stand within 200 m of the Spoof terminal and compare the tablet with the blue *REAL* labels: a ghost has the callsign of some existing unit but no label. The second player is in another group, so the first one sees them as a group that can have a ghost too.

The **AE3 mission** has two AE3 routers and two laptops next to the start and three Crow's data terminal jammers 150 m north, all off. The middle one is linked to the first router (id 1), the left one to router B (id 2), which the tester cascades under the first one and then switches off or destroys to see the jammer cut off. The right one is not linked, so the Zeus module can be tried on it. The two linked ones get Crow's loop sound like jammers of Crow's modules, the right one has none like a jammer added by script. The mission also makes two wrong `linkJammer` calls (a laptop as jammer, a laptop as router), which must each log a `Not linked` warning in the RPT. The laptops only have the root account of AE3, the mission allows logging in with it: `root` / `toor`. Switch on and connect the devices with the AE3 actions, then use `jammer` in the terminal.

The **Satcom mission** has a Crow's radio jammer 150 m north of the start (full radius 60 m, falloff to 120 m) with distance signs west of it. Each player has the three satcom dishes in the backpack. A label over every dish shows its satcom radius and the distance, and one over the player the ACRE interference Crow's applies (above 0 jammed, below 0 boosted).

`hemtt launch ae3`, `hemtt launch satcom`, `hemtt launch bft`, `hemtt launch bwa3`, `hemtt launch rhs_usaf`, `hemtt launch rhs_afrf` and `hemtt launch cup` open the matching mission in the editor. Use *Play in Multiplayer* there. The folders can also be copied to `Documents\Arma 3 - Other Profiles\<profile>\mpmissions`.
