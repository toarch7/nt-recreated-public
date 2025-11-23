var _area = GameCont.area,
	_subarea = GameCont.subarea,
	_loops = GameCont.loops,
	_actual_loops = global.hardmode ? (_loops - 1) : _loops,
	_is_throne_arena = (_area == Area.Palace && _subarea == 3)

scrCreateMobileControls()

with MusCont alarm[11] = 2
with SubTopCont alarm[0] = 1

random_set_seed(GameCont.levseed)

if instance_exists(Player) {
    with Player {
		if is_me {
			with MobileUI player = other.id
		}
		
		if race == Race.Fish {
			var _gunwarrant = scrUltraCheck(race, UltraSkill.GunWarrant)
			if _gunwarrant infammo = 7 * _gunwarrant * 30
		}
		
        if race == Race.Rebel {
			var _personal_guard = scrUltraCheck(race, UltraSkill.PersonalGuard)
			
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

        if skill_get(Mut.HammerHead) {
            hammerhead_charges = 25

            if race == Race.BigDog {
                hammerhead_charges = 100
            }
        }
		
		if race == Race.Rogue && is_me {
			if scr_player_pref(my_player, "rogue") && !save_get_value("etc", "rogue_tutorial", false)
				instance_create(x, y, SwipeBombingTutorial)
		}
		
		if _area == Area.Palace && _subarea != 3 && random(2) < 1 {
	        repeat (4) instance_create(x, y, IDPDSpawn)
	    }
		
        if !instance_exists(Cinematic) {
			scr_camera_set_position(x, y, fa_center, fa_middle)
        }
    }
	
	if UberCont.xmas && _area == 5 && _actual_loops == 0 {
		with instance_nearest(10016, 10016, enemy) {
			if distance_to_point(10016, 10016) < 160 && !irandom(100) {
				instance_create(x, y, Yeti)
				instance_destroy(id, 0)
			}
		}
	}
}

if _area == 5 && _subarea == 1 && skill_get(Mut.last_wish) {
    if instance_exists(prop) {
        with instance_furthest(10016, 10016, prop) {
            instance_change(IceFlower, 1)
        }
    }
	else {
		with instance_random(enemy) {
	        instance_create(x, y, IceFlower)
	        instance_destroy(id, 0)
	    }
	}
}

if (_area == Area.Palace && _subarea == 3) || _area == Area.Campfire || _area == Area.YVCrib {
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

    if _area == Area.Palace && _subarea == 3 {
		with UberCont {
			if daily_run && !weekly_run {
		        scrAchievementUnlock(Achievement.NOT_BAD)
		    }
		}
		
        instance_create(10016, 8592, Carpet)
        instance_create(10016 - 32, 9984, WeaponChest)
        instance_create(10016 + 32, 9984, AmmoChest)
		
        if skill_get(Mut.OpenMind) {
			repeat GameCont.openminds {
	            instance_create(10016, 10016 - 32, choose(WeaponChest, RadChest, AmmoChest))
	        }
		}
		
		with (chestprop) speed = 0
    }
}

if _area == Area.Campfire && instance_exists(Player) && _actual_loops == 1 {
    repeat scrPlayerCountRace(Race.Fish) {
		scrWeaponPickupCreate(10016, 10016, Wep.Guitar)
    }
}

if _area == Area.Desert && _actual_loops > 0 && GameCont.give_blacksword {
	repeat GameCont.give_blacksword {
		scrWeaponPickupCreate(10016, 10016, Wep.BlackSword)
	}
	
	GameCont.give_blacksword = 0
}

with WepPickup {
    x = 10016
    y = 10016
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

if _area == Area.HQ && _subarea != 3 {
	with Wall {
	    if place_meeting(x, y, Floor) {
	        instance_destroy()
	    }
	}
}

if _area == Area.Campfire && GameCont.loops > 0 {
	scrCampfireMenuCreate(true)
}

if UberCont.halloween && _subarea == Area.Desert && instance_exists(Bandit) {
    snd_play_hit_big(sndHalloweenWolf, 0.2)
}

if UberCont.weekly_run {
	instance_destroy(ProtoStatue)
}

// Destroy clingy props
with prop {
	if distance_to_point(10016, 10016) <= 96 && object_index != IceFlower {
		instance_destroy(id, 0)
	}
}