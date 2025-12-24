> [!NOTE]
> This is a temporary solution for tracking the list of tasks list. Ideally this should be fixed to use GitHub issues & milestones...

# Main priority
- [ ] Implement freezeframes
    - [x] Implement `sleep`
    - [ ] Go over all cases where `Sleep()` is called in the base game and introduce these calls in this project.
- [ ] Drop Input library support, as it was only used because of its handy-dandy gamepad mappings
- [ ] Proper gamepad controls in the loadout menu
- [ ] Damage & projectile system refactoring
    - [x] Refactor object-based damage dealing
    - [x] Clean up projectile collision damage code
    - [x] Introduce `HitId`s
    - [x] Make the "Killed By" in the Game Over use hitid to display information
    - [ ] Assign all enemies & damage sourcers their proper `hitid`s 
- [ ] Implement full support of NTT and u100 localization formats
    - [ ] Implement `.ini` localization file support
    - [ ] Implement `lang.csv` localization support (directly related to the previous paragraph)
    - [ ] Introduce localization tokens to simplify localization
- [ ] Revisit the enemy/prop animation logic 
- [x] Implement automated testing
    - [x] `scrFire` test
    - [x] `damagesource` test
    - [x] Random run test
- [x] Replace `inframes` mechanism with `nexthurt` akin to base NT
- [x] Loadout menu refactoring
    - [x] Campfire menu refactoring
    - [x] Untangle the loadout menu logic
    - [x] Implement loadout rendering for multiple players
    - [x] Fully implement random starting crown
- [x] Content systems refactoring
    - [x] Races
        - [x] Support for unlimited amount of playable characters
        - [x] Partial support for unlimited mutant skins
        - [x] Complete support for unlimited mutant skins
        - [x] Ability system refactoring
    - [x] Ultra Mutations
        - [x] Implement per-character multiplayer ultras
        - [x] Refactor any leftover checks for ultras (`ultra_check`, direct variable comparisons)
        - [x] Implement multiple ultras rendering in HUD
        - [x] Impliment multiplayer ultra selections per player (race)
        - [x] Implement co-op ultra and race ultra selection in first ultra level pick (aka `/ultras all` from NTT)
    - [x] Ammo, Ammo Pickups & Health Pickups system refactoring
    - [ ] *TBD*

# Medium priority
- [ ] 60+ FPS and timescale support
    - [ ] Figure out a replacement system for alarms that introduces minimal overhead
    - [ ] Refactor all object logic to not use alarms
    - [ ] Implement custom 2D physics that allows seamless transition from the current GameMaker physics engine
- [ ] Console refactoring (currently considering to use GameMaker's ImGui debug overlay)
- [ ] Full support of the base NT savefile format
    - [ ] Implement automatic conversion of the current NTM save file structure
    - [ ] Make NTM savefiles 100% interchangible with base NT

# CI (low priority)
- [ ] Nightly/Bleeding Edge builds
- [ ] iOS version via MacOS remote workers

# Resource extractor ideas (low priority)
- [ ] Add asset stubs so it could be possible to compile project without providing any real game assets
- [ ] Implement resource extraction in runtime for easier redistribution of prebuilt game binaries

# Experimental ideas for potential improvements (debatable, lowest priority)
- [ ] Custom collision system via grids, tilesets & co.
- [ ] Implement content registery system for weapons, skills, races, crowns, ultras, etc.

# Complete
Nothing here yet.