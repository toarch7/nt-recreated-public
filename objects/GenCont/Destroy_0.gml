scrCreateMobileControls()

random_set_seed(global.seed)

with SubTopCont {
    alarm[0] = 1
}

with Player {
	if is_me {
	    with MobileUI {
	        player = other.id
	    }
		
	    if GameCont.area == 7 && GameCont.subarea != 3 {
	        repeat 4 {
	            instance_create(x, y, IDPDSpawn)
	        }
	    }
	}
}

if instance_exists(Player) {
    with Player {
        if race == 1 && ultra_get(2) { //GUN WARRANT
            infammo = 210
        }

        if race == 10 && ultra_get(1) { // PERSONAL GUARD
			var i = 0
			
            repeat 2 {
                with instance_create(10016, 10016, Ally) {
					alarm[5 + i] = 5 + i * 15
                    creator = other.id
                }
				
				i ++
            }
        }

        if skill_get(26) {
            hammerheads = 25

            if race == 13 {
                hammerheads = 100
            }
        }

        if !instance_exists(Cinematic) {
            view_xview = x - view_width / 2
            view_yview = y - view_height / 2
        }
    }
}

if GameCont.area == 5 && GameCont.subarea == 1 && skill_get(18) {
    if instance_exists(prop) {
        with instance_furthest(10016, 10016, prop) {
            instance_change(JungleFlower, 1)
        }
    } else with instance_random(enemy) {
        instance_create(x, y, JungleFlower)
        instance_destroy(id, 0)
    }
}


if (GameCont.area == 7 && GameCont.subarea == 3) or GameCont.area == 0 or GameCont.area == 107 {
    with Wall {
        if place_meeting(x, y, Floor) {
            instance_destroy()
        }
    }

    with chestprop {
        if object_index != GiantWeaponChest && object_index != GiantAmmoChest {
            instance_destroy(id, 0)
        }
    }

    with RadChest instance_destroy(id, 0)
    with RadChestBig instance_destroy(id, 0)

    if GameCont.area == 7 && GameCont.subarea == 3 {
        instance_create(10016, 8592, Carpet)
        instance_create(10016 - 32, 9984, WeaponChest)
        instance_create(10016 + 32, 9984, AmmoChest)

        if skill_get(28) {
            instance_create(10016, 10016 - 32, choose(WeaponChest, RadChest, AmmoChest))
        }

        /*
        instance_create(10016, 8592, NothingInactive)
        instance_create(9856, 8912, BigGeneratorInactive)
        instance_create(9856, 9072, BigGeneratorInactive)
        instance_create(10176, 8912, BigGeneratorInactive)
        instance_create(10176, 9072, BigGeneratorInactive)
        
        
        for(yy = 9648; yy >= 9008; yy -= 160) {
            instance_create(10112, yy, ThroneStatue)
            instance_create(9920, yy, ThroneStatue)
        }
        */
    }

    with enemy
    instance_destroy(id, 0)
}

if GameCont.area == 0 && instance_exists(Player) && (GameCont.loops - global.hardmode) == 1 {
    var isfish = 0

    with Player {
        if race == 1 {
            isfish = 1
        }
    }

    if isfish {
        with instance_create(10016, 10016, WepPickup) {
            ammo = 0
            wep = 115
            curse = 0
            name = wep_name[wep]
            type = wep_type[wep]
            sprite_index = wep_sprt[wep]
            image_angle = random(360)
        }
    }
}

if GameCont.area == 1 && (GameCont.loops - global.hardmode) > 0 {
    if GameCont.blacksword {
        with instance_create(10016, 10016, WepPickup) {
            ammo = 0
            wep = 121
            curse = 0
            name = wep_name[wep]
            type = wep_type[wep]
            sprite_index = wep_sprt[wep]
            image_angle = random(360)
        }

        GameCont.blacksword = 0
    }
}

with WepPickup {
    x = 10016
    y = 10016
}

with ChestOpen
instance_destroy()

with SpiralCont {
    instance_destroy()
}

while instance_number(IDPDSpawn) > 5 + GameCont.loops {
    with instance_nearest(10016 + orandom(480), 10016 + orandom(480), IDPDSpawn) {
        instance_destroy()
    }
}

with GameCont {
    enemies = instance_number(enemy)
}

with Wall {
    if GameCont.area == 106 && GameCont.subarea != 3 {
        if place_meeting(x, y, Floor) {
            instance_destroy()
        }
    }
}

if GameCont.area == 0 && GameCont.loops {
    with instance_create(10016, 10016, CampfireOff) {
        if GameCont.race != 1 with instance_create(x, y - 36, Corpse) {
            sprite_index = sprMutant1Dead
            image_index = 5
        }

        if GameCont.race != 2 with instance_create(x, y + 36, Corpse) {
            sprite_index = sprMutant2Dead
            image_index = 5
        }

        if GameCont.race != 3 && UberCont.cgot[3] {
            with instance_create(x + 42, y, Corpse) {
                sprite_index = sprMutant3Dead
                image_index = 5
            }
        }

        if GameCont.race != 4 && UberCont.cgot[4] {
            with instance_create(x - 42, y, Corpse) {
                sprite_index = sprMutant4Dead
                image_index = 5
            }
        }

        for (var i = 5; i <= UberCont.racemax; i++) {
            if !UberCont.cgot[i] or i == 6 or i == GameCont.race
            continue

            direction = random(360)

            with instance_create(x, y, Corpse) {
                sprite_index = asset_get_index("sprMutant" + string(i) + "Dead")
                image_index = 5

                move_contact_solid(other.direction, 48 + random(72))
            }
        }
    }
}

if UberCont.halloween && GameCont.subarea == 1 && instance_exists(Bandit) {
    snd_play_hit_big(sndHalloweenWolf, 0.2)
}

with ProtoStatue {
    if UberCont.weekly_run instance_destroy()
}

if GameCont.area == 7 && GameCont.subarea == 3 {
    if UberCont.daily_run && !UberCont.weekly_run {
        scrAchievement(40)
    }
}