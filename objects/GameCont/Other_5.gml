var _race = Race.Random,
	_went_crib = false

with (Player) {
	if (scr_player_is_local(index)) _race = race
}

snd_stop(sndSalamanderFire)
snd_stop(sndSalamanderFireLoop)
snd_stop(sndLightningCannonLoop)
snd_stop(sndEyesLoop)
snd_stop(sndEyesLoopUpg)
snd_stop(sndHorrorLoop)
snd_stop(sndHorrorLoopTB)

fromcrib = false
gonna_oasis = 0
want_oasis = 0
spawn_vans = 0
vans = 0

if (gocrib) {
    gocrib = false
	if (area != area_crib) {
		lastarea = area
		lastsubarea = subarea
	}
    area = area_crib
    subarea = 1
    waypnt[waypoints] = area
    waysub[waypoints] = subarea
    waylps[waypoints] = loops
    waypoints++
	scrRaceUnlock(Race.Cuz)
	_went_crib = true
}

maxsubarea = scrAreaGetMaxSubareas(area)
finalsubarea = (subarea == maxsubarea)

if (!can_advance_stage) {
	can_advance_stage = true
	exit
}

var _is_secret = (area >= 100)

if (_is_secret && !_went_crib) {
	if (subarea == 1) {
	    if area == area_crib {
	        area = lastarea
	        subarea = lastsubarea
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
else if (!_went_crib && area != area_crib) {
    lastarea = area
    lastsubarea = subarea
}

var _max_subareas = scrAreaGetMaxSubareas(area)
if (subarea >= _max_subareas) {
	if (!_is_secret) {
		if (area < area_palace) {
			#region B-theme
			var _proto = 0
			
			if (crownvisits < 3) with (Player) {
				if (random(1) < 0.05 || hp <= 1) {
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
		    UberCont.ctot_loop[_race] ++
			area = area_campfire
			
			scrUnlocksWinOrLoop()
			
		    scrAchievementUnlock(Achievement.GAME_LOOPED)
			
		    if (loops > UberCont.cbst_loop[_race]) {
				UberCont.cbst_loop[_race] = loops
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

if (GameCont.hard > UberCont.cbst_diff[_race])
	UberCont.cbst_diff[_race] = GameCont.hard

if instance_exists(Player) {
	if (instance_exists(WeaponChest) || instance_exists(BigWeaponChest)) && !(area == 1 && subarea == 1) {
	    nochest++
	}
	
	if instance_exists(RadChest) || instance_exists(RadChestBig) || instance_exists(RadMaggotChest) {
		noradch ++
	}
	else noradch = 0
}

if scrGameIsHardmode() && _race == Race.Chicken && area == area_sewers {
    scrRaceUnlockSkin(Race.Chicken, SkinLetter.B)
}

if loops >= 2 && !UberCont.hardgot {
    save_set_value("etc", "hard", true)
    scrShowUnlockPopup("@wHARDMODE UNLOCKED@s#FOR REACHING LOOP 2")
    scrAchievementUnlock(Achievement.GO_HARD)
    UberCont.hardgot = true
}

maxsubarea = scrAreaGetMaxSubareas(area)
