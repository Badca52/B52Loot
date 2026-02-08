# B52 Loot - Must Fix

Issues that were resolved before republishing to Steam Workshop.
All 8 items have been fixed and the mod has been republished (v0.30).

---

## 1. CfgPatches missing `units[]` and `weapons[]` arrays - FIXED

**The single most reported bug across the entire community.**

`config.cpp:1-13` was missing required CfgPatches arrays. Arma 3 expects `units[]`, `weapons[]`, and an explicit `requiredAddons[]` even if empty. The missing `units[]` entry generated a persistent RPT error on every mission load:

```
No entry 'bin/config.bin/CfgPatches/B52_Loot.units'
```

**Reported by:** KITARO, Dentist, lolcats, DrumstickBandit, Lindsey, Wolf, WHERE IS THE LAMB SAUCE, 宅柠檬 (8 separate reports spanning 2018-2020)

**Fix applied:** Added empty `units[] = {};` and `weapons[] = {};` to `config.cpp` CfgPatches class.

---

## 2. Missing server key (bikey) for dedicated servers - FIXED

Users cannot run this mod on dedicated servers because there is no bikey file included. Arma 3 dedicated servers require signature verification and reject unsigned addons by default.

**Reported by:** Zeus, JarasonPC

**Fix applied:** Generated keypair and signed PBO using HEMTT build tool. The `.bikey` (public key) is included in the Workshop release under `keys/`. The `.bisign` signature file is alongside the PBO in `addons/`. Server admins copy the `.bikey` to their server's `Keys/` directory.

---

## 3. Stale PBO in repository - FIXED

`addons/b52_loot.pbo` was from the original 2017 build and did not reflect any v0.30 changes.

**Fix applied:** Removed the stale PBO from git tracking (`git rm --cached`). Set up HEMTT (cross-platform Arma 3 build tool) for Linux-native PBO building. The PBO is now built fresh from source with `hemtt release`, which rapifies the config, compiles SQF to bytecode, and signs the output. The `.gitignore` excludes `*.pbo` and build artifacts from future commits.

---

## 4. Workshop listing removed/flagged - FIXED

The Steam Workshop page showed a removal notice stating the mod violates Steam Community & Content Guidelines and was flagged as incompatible with Arma 3.

**Reported by:** Multiple users noted the listing issues; =[US]=Grant (Jan 2024) declared the mod abandoned.

**Fix applied:** Republished the mod to Steam Workshop (ID 898629562) via steamcmd with the fully rebuilt v0.30 release including all bug fixes, signed PBO, server key, and updated metadata.

---

## 5. Ravage mod compatibility - loot cleanup conflict - FIXED

Ravage's garbage collection system deletes B52-spawned loot holders when players move away. This is the root cause of the "loot only in first town" reports that were misattributed to the spawn radius (which has been separately fixed).

**Reported by:** ArteyFlow, Sgt Smash, Jackrabbit, CY3ER MISFIT, Regular jackoff

**Fix applied:** All loot holders (`GroundWeaponHolder` and `Box_IND_Ammo_F` crates) now have the Ravage protection variable set:
```sqf
_holder setVariable ["rvg_intLoot", true];
```
Applied in both `fn_spawnLootGeneral.sqf` (ground holders + crates) and `fn_spawnLootMilitary.sqf`.

---

## 6. No `.gitignore` file - FIXED

The repository had no `.gitignore`. This led to the `firebase-debug.log` being committed previously, and risked future leaks of build artifacts, IDE configs, or system files.

**Fix applied:** Created `.gitignore` excluding PBOs, bisign files, private keys, logs, IDE configs, and OS files.

---

## 7. No documentation / README - FIXED

Multiple users asked basic questions: "How do you use this mod?" (Blood_Mad), "Is there a way of changing the loot type?" (Genuinbill), "Does loot depend on activated weapon mods?" (Die Screaming).

**Fix applied:** Created comprehensive `README.md` covering:
- What the mod does
- Requirements (Arma 3 1.60+, CBA_A3)
- Installation (Workshop + manual)
- Eden editor module setup with attribute descriptions
- Script-based initialization (advanced)
- Full loot table customization guide with all 19 overridable arrays
- Examples: CUP weapons only, weapon category weighting, runtime mod detection
- Mod compatibility notes (Ravage, CUP/RHS, ACE3, Heros Survive)
- Dedicated server setup
- Building from source (PBO + bikey)

---

## 8. Performance crash on large maps - FIXED

"Too many virtual blocks requested" crash reported on maps with many buildings. The previous yield mechanism (`sleep 0.01` every 25 buildings) was insufficient for very large maps like Altis or Tanoa.

**Reported by:** Tactical Druid, FriendlyCanadian, ROGERJAGER

**Fix applied:** Improved yield mechanism in `fn_init.sqf`:
- Reduced batch size from 25 to 10 buildings per yield cycle
- Increased sleep from 0.01s to 0.05s per batch (5x more breathing room)
- Added progress logging every 1000 buildings to RPT for diagnostics
- Added start/completion log messages with building count and map size
