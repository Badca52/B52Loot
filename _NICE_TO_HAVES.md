# B52 Loot - Nice to Haves

Feature requests and improvements from the community that would enhance the mod but are not required for a functional release. Ordered roughly by community demand.

---

## 1. Custom loot tables via mission config

**Requested by:** Eliquis, Genuinbill, Die Screaming, Bingo, S. Jorgensen (5 users)

Allow mission makers to fully control what spawns by overriding loot arrays.

**Current state:** Already partially implemented. `fn_defineLootTables.sqf` uses `isNil` guards on all 19 `B52_*` arrays, so mission makers can pre-define any array in `init.sqf` before the module activates. This just needs documentation and examples.

**Remaining work:**
- Document the override mechanism in README
- Provide example `init.sqf` snippets for common scenarios (CUP-only, RHS-only, WW2, etc.)

---

## 2. CUP / RHS / third-party mod weapon support

**Requested by:** Lindsey, S. Jorgensen, Eliquis

Users want CUP, RHS, and other mod weapons in loot pools instead of (or alongside) vanilla gear. S. Jorgensen specifically wanted to prevent vanilla weapons in WW2 scenarios.

**Current state:** Loot tables are vanilla-only by default. The `isNil` override system allows mission makers to replace arrays, but there are no pre-built configs for popular mods.

**Possible approach:**
- Create optional config templates: `examples/loot_tables_cup.sqf`, `examples/loot_tables_rhs.sqf`
- Users copy the relevant file into their mission and `execVM` it before module init
- Or detect loaded mods at runtime via `isClass (configFile >> "CfgPatches" >> "CUP_Weapons")` and auto-extend arrays

---

## 3. Per-type loot probability control

**Requested by:** Eliquis, Tactical Druid

Different spawn percentages for each loot category. E.g., weapons 5%, clothing 30%, magazines 20%.

**Current state:** `fn_spawnLootGeneral.sqf:9` uses uniform `selectRandom` across all 7 types. There is a single global probability slider in the editor module but no per-type control.

**Possible approach:**
- Add a `B52_LootWeights` array (overridable via `isNil`) mapping type names to relative weights
- Use weighted selection instead of flat `selectRandom`
- Or add per-type probability sliders to the editor module attributes

---

## 4. Weapon category weighting

**Requested by:** Tactical Druid

Control the relative chance of spawning assault rifles vs snipers vs launchers vs handguns.

**Current state:** `B52_WeaponTypes` array in `fn_defineLootTables.sqf:23-33` already implements this via duplicate entries (AssaultRifle appears 3x, Handgun 2x, etc.). This is overridable via `isNil`.

**Remaining work:** Document that users can override `B52_WeaponTypes` with custom weight distributions.

---

## 5. ACE mod compatibility testing

**Reported by:** CRI6X (broken), genpiusz (works but no magazines)

Conflicting community reports. genpiusz confirmed it works with ACE but weapons spawn without magazines.

**Current state:** Weapons now spawn with compatible magazines in v0.30. ACE uses its own medical and interaction systems but shouldn't conflict with cargo operations. Needs testing.

**Remaining work:** Test with ACE3 loaded to verify no conflicts with weapon/magazine spawning.

---

## 6. Auto-enable without editor module placement

**Requested by:** Dave_Sherk, El Berl

Users want the mod to activate automatically on mission/server start without manually placing the editor module.

**Current state:** Requires placing the B52 Loot Module in the Eden editor.

**Possible approach:**
- Add a CBA setting or addon option for auto-init
- Or provide a script snippet for `initServer.sqf`:
  ```sqf
  [] call B52_Loot_Module_fnc_defineLootTables;
  [[15, false]] call B52_Loot_Module_fnc_init; // probability, showMarkers
  ```
- Would need `fn_init.sqf` to accept direct parameters as an alternative to the logic object

---

## 7. Loot respawn system

**Requested by:** Sgt Smash

Loot regenerates over time after being picked up or after a configurable interval.

**Current state:** Loot spawns once at mission start and never respawns.

**Possible approach:**
- Track spawned holders in a global array
- Periodic check (e.g. every 5-10 minutes) to respawn loot at positions where holders are empty or deleted
- Add a module attribute for respawn interval (0 = disabled)

---

## 8. Heros Survive food integration

**Reported by:** MaxioTech, Smokkerino

Food items from Heros Survive don't work properly when spawned (double-click doesn't trigger consumption).

**Current state:** `B52_HeroesEnabled` flag exists and `B52_Food` array is empty by default, requiring mission-level override. The consumption issue is likely a Heros Survive interaction model problem, not a B52 Loot issue.

**Remaining work:** Test with Heros Survive to determine if spawned food items need specific variable initialization to be consumable. May need to set item variables that Heros Survive checks.

---

## 9. Vehicle loot system

**Requested by:** DRobdaDocTNC (Mar 2025)

Spawn loot inside vehicles found on the map, similar to Antistasi's garage system.

**Current state:** Not implemented. The mod only spawns loot at building positions.

**Possible approach:**
- Iterate `nearObjects ["Car", _radius]` and `nearObjects ["Air", _radius]` in addition to houses
- Add items to vehicle inventory using `addWeaponCargoGlobal` etc.
- Would need its own probability setting and loot table

---

## 10. CUP Chernarus building classification

**Reported by:** FallenTurtle

CUP Chernarus military bases not correctly identified as military.

**Current state:** `fn_init.sqf` uses keyword matching against `B52_MilitaryKeywords` and `B52_IndustrialKeywords`. CUP buildings may use different classname conventions than vanilla Arma 3.

**Remaining work:**
- Research CUP building classnames for military structures
- Add CUP-specific keywords to `B52_MilitaryKeywords` (e.g., `"_Mil_"` may not match CUP's `"Land_Barracks_"` pattern)
- Since the keyword arrays are overridable via `isNil`, mission makers can extend them now
