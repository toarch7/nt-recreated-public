function scrPopulate() {
    global.rng_state[0] = global.seed + GameCont.area + GameCont.subarea + GameCont.loops
    random_set_seed(global.rng_state[0])

    //setting area && spawning some enemies
    with Floor {
        spawnarea = GameCont.area
        if rng_rnd(1, 0, 10 + GameCont.hard) < GameCont.hard && point_distance(x, y, 10016, 10016) > 120 && !place_meeting(x, y, RadChest) && !place_meeting(x, y, AmmoChest) && !place_meeting(x, y, WeaponChest) {
            scrPopEnemies()
        }

        if random(6) < 1 {
            instance_create(x + random(32), y + random(32), Detail)
        }
    }

    //COOL BONES

    with Floor {
        if spawnarea = 1 {
            if !place_free(x - 32, y) && !place_free(x + 32, y) && place_free(x, y) {
                instance_create(x, y, Bones)
                instance_create(x, y + 16, Bones)
                with instance_create(x + 32, y, Bones)
                image_xscale = -1
                with instance_create(x + 32, y + 16, Bones)
                image_xscale = -1
            }
        }
        if spawnarea = 3 {
            if !place_free(x - 32, y) && !place_free(x + 32, y) && place_free(x, y) {
                if random(7) < 1 instance_create(x, y, Bones) if random(7) < 1 instance_create(x, y + 16, Bones) if random(7) < 1 {
                    with instance_create(x + 32, y, Bones)
                    image_xscale = -1
                }
                if random(7) < 1 {
                    with instance_create(x + 32, y + 16, Bones)
                    image_xscale = -1
                }
            }
            with Bones
            sprite_index = sprScrapDecal
        }
        if spawnarea = 5 {
            if !place_free(x - 32, y) && !place_free(x + 32, y) && place_free(x, y) {
                if random(7) < 1 instance_create(x, y, Bones) if random(7) < 1 instance_create(x, y + 16, Bones) if random(7) < 1 {
                    with instance_create(x + 32, y, Bones)
                    image_xscale = -1
                }
                if random(7) < 1 {
                    with instance_create(x + 32, y + 16, Bones)
                    image_xscale = -1
                }
            }
            with Bones
            sprite_index = sprIceDecal
        }
        if spawnarea = 4 {
            if !place_free(x - 32, y) && !place_free(x + 32, y) && place_free(x, y) {
                if rng_random(2, 9) < 1 instance_create(x, y, Bones) if rng_random(2, 9) < 1 instance_create(x, y + 16, Bones) if rng_random(2, 9) < 1 {
                    with instance_create(x + 32, y, Bones)
                    image_xscale = -1
                }
                if random(9) < 1 {
                    with instance_create(x + 32, y + 16, Bones)
                    image_xscale = -1
                }
            }
            with Bones
            sprite_index = sprCaveDecal
        }
        if spawnarea = 2 {
            if !place_free(x - 32, y) && !place_free(x + 32, y) && place_free(x, y) && rng_random(2, 10) < 1 {
                instance_create(x, y + 16, Bones)
                with instance_create(x + 32, y + 16, Bones)
                image_xscale = -1
            }
            with Bones
            sprite_index = sprSewerDecal
        }
    }


    //making sure there are enough enemies && spawning props/lil walls

    with Floor {
        spawnarea = GameCont.area
        var canspawn = point_distance(x, y, 10016, 10016) > 110 && !place_meeting(x, y, prop) && !place_meeting(x, y, chestprop)

        if canspawn {
            if instance_number(enemy) < (3 + GameCont.hard / 1.5) {
                scrPopEnemies()
            }

            //CROWN OF BLOOD
            if GameCont.crown == 7 && rng_random(1, 10 + GameCont.hard) < GameCont.hard {
                scrPopEnemies()
            }
        }

        scrPopProps()
    }

    if GameCont.area == 104 {
        with LaserCrystal {
            instance_create(x, y, InvLaserCrystal)
            instance_destroy(id, 0)
        }

        with Spider {
            instance_create(x, y, InvSpider)
            instance_destroy(id, 0)
        }
    }

    if GameCont.loops > 0 {
        random_set_seed(global.rng_state[1])

        with enemy {
            if random(60) < GameCont.loops {
                repeat 3 + GameCont.loops {
                    instance_create(x + random(8) - 4, y + random(8) - 4, object_index)
                }

                instance_create(x, y, PortalClear)
            }
        }
    }

    with NOWALLSHEREPLEASE
    instance_destroy()

    //spawning chests
    if GameCont.area != 0 scrPopChests()

    //spawn desert boss
    if GameCont.area == 1 instance_create(x, y, WantBoss)

    //venuz car
    if GameCont.area == 3 && GameCont.subarea == 1 {
        with instance_furthest(10016, 10016, Car) {
            instance_create(x, y, CarVenus)
            instance_change(Wind, false)
        }

        if !instance_exists(CarVenus) {
            flor = instance_furthest(10016, 10016, Floor)
            if instance_exists(flor) {
                with flor {
                    instance_create(x + 16, y + 16, CarVenus)
                }
            }
        }
    }

    if GameCont.area != 0 && (GameCont.area < 5 or GameCont.area >= 100) && GameCont.area != 106 && GameCont.area != 107 {
        with WeaponChest
        instance_create(x, y, Bandit)
        with RadChest
        instance_create(x, y, Bandit)
        with AmmoChest
        instance_create(x, y, Bandit)
    }

    //populate pizza sewers
    if GameCont.area = 102 {

        with enemy {
            instance_create(x, y, Corpse)
            instance_destroy(id, 0)
        }

        with instance_furthest(10016, 10016, Corpse) {
            repeat(4)
            instance_create(x + random(4) - 2, y + random(4) - 2, Turtle)
            instance_create(x, y, Rat)
        }
        with Rad
        instance_destroy()
        with AmmoPickup
        instance_destroy()
        with HPPickup
        instance_destroy()
        with Corpse
        instance_destroy()
    }

    //PIZZA SEWER ENTRANCE
    {
        if GameCont.area = 2 {
            with Floor {
                if sprite_index = sprFloor2 && image_index = 1 or image_index = 5 instance_create(x, y, PizzaEntrance)
            }
            do {
                with instance_nearest(10016 + rng_random(0, 240) - 120, 10016 + rng_random(0, 240) - 120, PizzaEntrance) instance_destroy()
            }
            until instance_number(PizzaEntrance) <= 1
        }
    }

    if instance_exists(Player) {
        if GameCont.area != 100 && GameCont.area != 107 && !(GameCont.area == 106 && GameCont.subarea == 3) && !(GameCont.area == 7 && GameCont.subarea == 3) {
            with Player {
                if race == 12 {
                    instance_create(10016, 10016, WantPopo)
                }
            }

            repeat GameCont.loops
            instance_create(10016, 10016, WantPopo)

            if GameCont.area == 0 {
                repeat GameCont.loops
                instance_create(10016, 10016, IDPDSpawn)
            }

            if GameCont.area != 0 && !GameCont.novans {
                repeat GameCont.loops - global.hardmode {
                    instance_create(10016, 10016, WantVan)
                }
            }
        }
    }

    if GameCont.loops && GameCont.area == 6 {
        with enemy {
            if distance_to_object(TechnoMancer) > 120 && point_distance(x, y, 10016, 10016) > 160 {
                instance_create(x, y, TechnoMancer)
            }
        }

        do {
            with instance_nearest(10016, 10016, TechnoMancer) {
                instance_destroy()
            }
        } until instance_number(TechnoMancer) <= 2 + GameCont.loops
    }

    with TechnoMancer {
        repeat(6) {
            instance_create(x + orandom(60), y + orandom(60), PortalClear)
        }
    }
}