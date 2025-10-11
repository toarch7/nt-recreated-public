//UberCont.race_skin[race] = UberCont.cskingot[race]

fromcrib = false
gonna_oasis = 0
want_oasis = 0
spawn_vans = 0
vans = 0

if area < 100 {
    lastarea = area
    lastsubarea = subarea
}
else if subarea == 1 {
    if area == 107 {
        area = hqarea
        subarea = hqsubarea
        fromcrib = true
    }

    if area == 105 {
        area = 5
        subarea = 2
    }

    if area == 104 {
        area = 5
        subarea = 0
    }

    if area == 103 {
        area = 3
        subarea = 2
    }

    if area == 102 {
        area = 3
        subarea = 0
    }

    if area == 101 {
        area = 3
        subarea = 2
    }
}

if gocrib {
    gocrib = 0
    area = 107
    subarea = 1

    waypnt[waypoints] = area
    waysub[waypoints] = subarea
    waylps[waypoints] = loops
    waypoints++
}

if subarea < 3 && !(area == 0 or area == 2 or area == 4 or area == 6) {
    subarea += 1
} else if area < 100 {
    if area < 7 {
        area += 1
		
        if instance_exists(Player) {
			var _proto = 0
			
			with Player {
				if _proto {
					break
				}
				
	            if (!irandom(20) or hp <= 1) && crownvisits < 3 {
	                _proto = 1
					
	                if !GameCont.loops && (GameCont.area == 1 or GameCont.area == 7) {
	                    _proto = 0
	                }
	            }
				else _proto = 0
			}
			
			proto = _proto
			
            if area == 4 {
                with Player {
	                if curse or bcurse {
	                    GameCont.area = 104
	                }
				}
            }
        }
    }
	else if area != 107 {
        UberCont.ctot_loop[race] += 1
        loops += 1

        scrAchievementUnlock(Achievement.GAME_LOOPED)
		
		// TODO: crown unlock functions
        if crown > 1 && scrCrownUnlock(race, crown) {
			scrAchievementUnlock(Achievement.CROWN_LIFE)
			scrSave()
		}

        if loops > UberCont.cbst_loop[race] {
			UberCont.cbst_loop[race] = loops
		}
		
        area = 0
    }

    subarea = 1
}

hard++

if global.hardmode {
    hard++
}

waypnt[waypoints] = area
waysub[waypoints] = subarea
waylps[waypoints] = loops
waypoints++

if hard > UberCont.cbst_diff[race] UberCont.cbst_diff[race] = hard

if (instance_exists(WeaponChest) or instance_exists(BigWeaponChest)) and !(area == 1 && subarea == 1) {
    nochest++
}

if instance_exists(Player) && !(area == 1 && subarea == 1) {
	if instance_exists(RadChest) or instance_exists(RadChestBig) or instance_exists(RadMaggotChest) {
		noradch ++
	}
	else noradch = 0
}

if global.hardmode && race == Race.Chicken && area == area_sewers {
    scrRaceUnlockSkin(Race.Chicken, 1)
}

if !UberCont.hardgot && loops >= 2 {
    save_set_value("etc", "hard", 1)
    scrShowUnlockPopup("@wHARDMODE UNLOCKED@s#FOR REACHING LOOP 2")
    scrAchievementUnlock(Achievement.GO_HARD)
    UberCont.hardgot = true
}

snd_stop(sndSalamanderFire)
snd_stop(sndLightningCannonLoop)

if !instance_exists(CoopController) && !UberCont.opt_console {
    var _is_paused = scrGameIsPaused()
	
    if _is_paused {
		instance_activate_object(Player)
	}
	
    if is_level_ended {
		global.recontinues --
		
        is_level_ended = false
        scrGameSave()
    }

    if instance_exists(Player) {
		scrGameSaveInfo()
	}
	
    if _is_paused {
		instance_deactivate_object(Player)
	}
}

is_level_ended = 0