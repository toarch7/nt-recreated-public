UberCont.race_skin[race] = UberCont.cskingot[race]

fromcrib = 0
gonna_oasis = 0
want_oasis = 0
spawn_vans = 0
vans = 0
alarm[10] = -1

if area < 100 {
    lastarea = area
    lastsubarea = subarea
}
else if subarea == 1 {
    if area == 107 {
        fromcrib = 1
        area = hqarea
        subarea = hqsubarea
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
    } else if area != 107 {
        UberCont.ctot_loop[race] += 1
        loops += 1

        scrAchievement(41)

        if !UberCont.crowngot[race, crown] && crown > 1 && race != 13 && race != 14 && race != 15 {
            UberCont.crowngot[race, crown] = 1
            UberCont.race_crown[race, crown] = 1
            show_unlock_popup("@w" + crown_name[crown] + "@sUNLOCKED#FOR @w" + race_name[race])
            scrAchievement(22)
        }

        if loops > UberCont.cbst_loop[race] UberCont.cbst_loop[race] = loops

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

if instance_exists(Player) && (instance_exists(RadChest) or instance_exists(RadChestBig)) && !(area == 1 && subarea == 1) {
    noradch++
}

if global.hardmode && race == 9 && area == 2 && !UberCont.cskingot[9] {
    UberCont.cskingot[9] = 1
    
	show_unlock_popup("@wCHICKEN B-SKIN UNLOCKED@s#FOR REACHING 2-1 IN HARDMODE")
    
	with instance_create(0, 0, UnlockScreen) {
        race = 9;
        skin = 1
    }
	
    scrAchievement(18)
}

if area == 1 && subarea < 3 alarm[0] = 10

if loops && area > 0 && area != 100 alarm[10] = 30

if !UberCont.hardgot && loops >= 2 {
    save_set_val("etc", "hard", 1)
    UberCont.hardgot = 1
    scrAchievement(39)
    show_unlock_popup("@wHARDMODE UNLOCKED@s#FOR REACHING LOOP 2")
}

snd_stop(sndSalamanderFire)

rng_reset()

if !instance_exists(CoopController) && !UberCont.opt_console {
    var p = UberCont.paused
	
    if p {
		instance_activate_object(Player)
	}
	
    if level_end {
		with Player {
			recontuations --
			
			if is_me
				global.recontuations = recontuations
		}
		
        level_end = 0
        scrGameSave()
    }

    if instance_exists(Player) {
		scrGameSaveInfo()
	}
	
    if p {
		instance_deactivate_object(Player)
	}
}

level_end = 0