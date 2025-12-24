/// @description Generation end

var _area = GameCont.area,
	_subarea = GameCont.subarea,
	_loops = GameCont.loops,
	_max_subareas = scrAreaGetMaxSubareas(_area),
	_actual_loops = _loops - scrGameIsHardmode(),
	_is_throne_arena = (_area == area_palace && _subarea == _max_subareas)

scrCreateMobileControls()

with (MusCont) alarm[11] = 2
with (SubTopCont) alarm[0] = 1

random_set_seed(GameCont.levseed)

if instance_exists(Player) {
    with Player {
		if (instance_exists(Cinematic)) break
		
		if (is_me) {
			with (MobileUI) player = other.id
		}
		
		if race == Race.Fish {
			var _gunwarrant = scr_ultra_get(race, UltraSkill.GunWarrant)
			if (_gunwarrant) infammo = 7 * _gunwarrant * 30
		}
		
        if race == Race.Rebel {
			var _personal_guard = scr_ultra_get(race, UltraSkill.PersonalGuard)
			
			if _personal_guard {
				var _index = 0
				
	            repeat (2 * _personal_guard) {
	                with instance_create(x, y, Ally) {
						motion_add(random_angle, 1)
						creator = other.id
					
						if _index < 2 {
							alarm[5 + _index] = 10 + _index * 15
						}
	                }
				
					_index ++
	            }
			}
        }
		
		if (race == Race.Venuz) {
            scr_screenshake(5)
            snd_play(sndVenuz)
        }
		
        if (race == Race.BigDog) {
            with instance_create(x, y, PortalClear) {
                image_xscale = 3
                image_yscale = 3
            }
        }
		else {
			instance_create(x, y, PortalClear)
		}
		
        if scr_skill_get(mut_hammerhead) {
            hammerhead = 25

            if (race == Race.BigDog) {
                hammerhead = 100
            }
        }
		
		if race == Race.Rogue && is_touch(index) && scr_player_is_local(index) {
			if scr_player_pref(my_player, "rogue") && !save_get_value("etc", "rogue_tutorial", false) {
				instance_create(x, y, SwipeBombingTutorial)
			}
		}
		
		if _area == area_palace && _subarea != 3 && random(2) < 1 {
	        repeat (4) instance_create(x, y, IDPDSpawn)
	    }
		
        scr_camera_set_position(x, y, fa_center, fa_middle)
		repeat (4) scrFX(x, y, PortalL, random_angle, 2)
    }
	
	snd_play(sndPortalOpen)
	
	if UberCont.xmas && _area == area_city && _actual_loops == 0 {
		with instance_nearest(10016, 10016, enemy) {
			if distance_to_point(10016, 10016) < 160 && !irandom(100) {
				instance_create(x, y, Yeti)
				instance_destroy(id, false)
			}
		}
	}
}

with (PortalClear) {
	var _instance = instance_nearest(x, y, TopPot)
	if (instance_exists(_instance) && distance_to_point(_instance.x, _instance.y) <= 20) {
		instance_destroy(_instance, false)
	}
}

if _area == area_city && _subarea == 1 && scr_skill_get(mut_last_wish) {
    if (instance_exists(prop)) {
        with (instance_furthest(10016, 10016, prop)) {
            instance_change(IceFlower, 1)
        }
    }
	else {
		with (instance_random(enemy)) {
	        instance_create(x, y, IceFlower)
	        instance_destroy(id, 0)
	    }
	}
}

if (_area == area_palace && _subarea == 3) || _area == area_campfire || _area == area_crib {
    with Wall {
        if (place_meeting(x, y, Floor)) instance_destroy()
    }

    with chestprop {
        if object_index != GiantWeaponChest && object_index != GiantAmmoChest {
            instance_destroy(id, false)
        }
    }

    instance_destroy(RadChest, false)
    instance_destroy(RadChestBig, false)
    instance_destroy(enemy, false)

    if _area == area_palace && _subarea == 3 {
		with (UberCont) {
			if (scrGameIsDailyRun()) scrAchievementUnlock(Achievement.NOT_BAD)
		}
		
        instance_create(10016, 8586, Carpet)
		
		var _num = 0
		repeat (1 + scr_skill_get(mut_open_mind)) {
			if (_num > 0) {
				var _offset = 32 * _num + 1
				instance_create(10016 - 32, 10016 - _offset, choose(WeaponChest, RadChest, AmmoChest))
				instance_create(10016 + 32, 10016 - _offset, choose(WeaponChest, RadChest, AmmoChest))
			}
			else {
		        instance_create(10016 - 32, 9984, WeaponChest)
		        instance_create(10016 + 32, 9984, AmmoChest)
		    }
			_num ++
		}
		
		with (chestprop) speed = 0
    }
}

if _area == area_campfire && _actual_loops == 1 {
	with (Player) {
		if (race == Race.Fish) {
			scrWeaponPickupCreate(10016, 10016,
				(bskin == SkinLetter.C) ? wep_electric_guitar : wep_guitar)
		}
	}
}

if _area == area_desert && _actual_loops > 0 && GameCont.blackswords {
	repeat (GameCont.blackswords) {
		scrWeaponPickupCreate(10016, 10016, wep_black_sword)
	}
	
	GameCont.blackswords = 0
}

instance_destroy(ChestOpen)
instance_destroy(SpiralCont)

while instance_number(IDPDSpawn) > 5 + GameCont.loops {
    with instance_nearest(10016 + orandom(480), 10016 + orandom(480), IDPDSpawn) {
        instance_destroy()
    }
}

// Unstuck enemies, I guess
with enemy {
	if place_meeting(x, y, Floor) continue
	
	var _floor = instance_nearest(bbox_center_x, bbox_center_y, Floor)
		
	if instance_exists(_floor) {
		with _floor {
			other.x = bbox_center_x
			other.y = bbox_center_y
		}
	}
	else if instance_number(enemy) > 1 {
		instance_destroy(id, false)
	}
}

with GameCont {
    enemies = instance_number(enemy)
}

if _area == area_hq && _subarea != 3 {
	with Wall {
	    if place_meeting(x, y, Floor) {
	        instance_destroy()
	    }
	}
}

if _area == area_campfire && GameCont.loops > 0 {
	scrCampfireMenuCreate(true)
}

if UberCont.halloween && _subarea == area_desert && instance_exists(Bandit) {
    snd_play_hit_big(sndHalloweenWolf, 0.2)
}

if UberCont.weekly_run {
	instance_destroy(ProtoStatue)
}
