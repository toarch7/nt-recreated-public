snd_stop(sndSalamanderFire)
snd_stop(sndLightningCannonLoop)

fromcrib = false
gonna_oasis = 0
want_oasis = 0
spawn_vans = 0
vans = 0

if gocrib {
    gocrib = false
    area = area_crib
    subarea = 1

    waypnt[waypoints] = area
    waysub[waypoints] = subarea
    waylps[waypoints] = loops
    waypoints++
}

if (!can_advance_stage) {
	can_advance_stage = true
	exit
}

var _is_secret = (area >= 100)

if _is_secret {
	if (subarea == 1) {
	    if area == area_crib {
	        area = hqarea
	        subarea = hqsubarea
	        fromcrib = true
	    }
		
	    if area == area_jungle {
	        area = area_city
	        subarea = 2
	    }
		
	    if area == area_cursed_caves {
	        area = area_city
	        subarea = 0
	    }
		
	    if area == area_mansion || area == area_oasis {
	        area = area_scrapyards
	        subarea = 2
	    }
		
	    if area == area_pizza_sewers {
	        area = area_scrapyards
	        subarea = 0
	    }
	}
}
else {
    lastarea = area
    lastsubarea = subarea
}

var _max_subareas = scrAreaGetMaxSubareas(area)
if (subarea >= _max_subareas || _max_subareas <= 1) {
	if (!_is_secret) {
		if (area < area_palace) {
			#region B-theme
			var _proto = 0
			
			with Player {
				if ((random(1) < 0.05 || hp <= 1) && crownvisits < 3) {
			        _proto = true
				}
			}
			
			if (!loops && (area == area_desert || area == area_palace)) _proto = false
			
			proto = _proto
			#endregion
			
		    area ++
			
		    if area == area_caves && scrPlayerCountCursed(all) {
		        area = area_cursed_caves
		    }
		}
		else {
		    loops ++
		    UberCont.ctot_loop[race] ++
			area = area_campfire
			
		    scrAchievementUnlock(Achievement.GAME_LOOPED)
		
		    if (crown > 1 && scrCrownUnlock(race, crown)) {
				scrAchievementUnlock(Achievement.CROWN_LIFE)
				scrSave()
			}

		    if (loops > UberCont.cbst_loop[race]) {
				UberCont.cbst_loop[race] = loops
			}
		}

		subarea = 1
	}
}
else subarea ++

hard += scrGameIsHardmode() ? 2 : 1

waypnt[waypoints] = area
waysub[waypoints] = subarea
waylps[waypoints] = loops
waypoints ++

if (hard > UberCont.cbst_diff[race]) UberCont.cbst_diff[race] = hard

if instance_exists(Player) {
	if (instance_exists(WeaponChest) || instance_exists(BigWeaponChest)) && !(area == 1 && subarea == 1) {
	    nochest++
	}
	
	if instance_exists(RadChest) || instance_exists(RadChestBig) || instance_exists(RadMaggotChest) {
		noradch ++
	}
	else noradch = 0
}

if scrGameIsHardmode() && race == Race.Chicken && area == area_sewers {
    scrRaceUnlockSkin(Race.Chicken, SkinLetter.B)
}

if loops >= 2 && !UberCont.hardgot {
    save_set_value("etc", "hard", 1)
    scrShowUnlockPopup("@wHARDMODE UNLOCKED@s#FOR REACHING LOOP 2")
    scrAchievementUnlock(Achievement.GO_HARD)
    UberCont.hardgot = true
}

if !instance_exists(CoopController) && !UberCont.opt_console {
    var _is_paused = scrGameIsPaused()
	
    if (_is_paused) instance_activate_object(Player)
	
    if is_level_ended {
		global.recontinues --
        is_level_ended = false
        scrGameSave()
    }
	
    if (instance_exists(Player)) scrGameSaveInfo()
    if (_is_paused) instance_deactivate_object(Player)
}

is_level_ended = false