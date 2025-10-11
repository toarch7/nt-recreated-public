> [!NOTE]
> This is a temporary solution for tracking the list of tasks list. Ideally this should be fixed to use GitHub issues & milestones...

# Main priority
- [ ] Replace `inframes` mechanism with `nexthurt` akin to base NT
- [ ] A proper state serialization system for saving/loading
- [ ] Implement automatic game testing via player bot
- [ ] Implement freezeframes (for real this time)
- [ ] Input system refactoring
    - [ ] Introduce abstractions for checking `KeyCont` key states
    - [ ] Proper gamepad controls for loadout menu
    - [ ] Implement input mocking
    - [ ] *TBD*
- [ ] Support for NT(T) localization format
    - [ ] Implement `.ini` localization file support
    - [ ] Introduce localization tokens to simplify localization
- [ ] Loadout menu refactoring
    - [x] Campfire menu refactoring
    - [x] Untangle the loadout menu logic
    - [x] Implement loadout rendering for multiple players
    - [ ] Fully implement random starting crowns
- [ ] Content systems refactoring
    - [ ] Weapons, Crowns & Mutations
        - [ ] Refactor weapon IDs to use enums rather than macros
        - [ ] *TBD*
    - [ ] Races
        - [x] Support for unlimited amount of playable characters
        - [x] Partial support for unlimited mutant skins
        - [ ] Complete support for unlimited mutant skins
        - [ ] Ability system refactoring
        - [ ] *TDB*
    - [ ] Ultra Mutations
        - [ ] Implement per-character multiplayer ultras
        - [ ] Refactor any leftover checks for ultras (`ultra_check`, direct variable comparisons)
        - [ ] Implement multiple ultras rendering in HUD
    - [x] Ammo, Ammo Pickups & Health Pickups system refactoring

# Medium priority
- [ ] Console refactoring (currently considering to use GameMaker's ImGui debug overlay)
- [ ] Full support of the base NT savefile format
    - [ ] Implement automatic conversion of NTM -> NT savefiles
    - [ ] Make NTM savefiles 100% interchangible with base NT

# CI (low priority)
- [ ] Nightly/Bleeding Edge builds
- [ ] iOS version via MacOS remote workers

# Resource extractor ideas (low priority)
- [ ] Figure out how to extract `data.win` from the u99r1 executable
- [ ] Add asset stubs so it could be possible to compile project without providing any real game assets
- [ ] Implement resource extraction in runtime for easier redistribution of prebuilt game binaries by third party

# Experimental ideas for potential improvements (super low priority)
- [ ] Custom collision system via grids, tilesets & co.
- [ ] Implement content registery system for weapons, skills, races, crowns, ultras, etc.

# Complete
Nothing here yet.