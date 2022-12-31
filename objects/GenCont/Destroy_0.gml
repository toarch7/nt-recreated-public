if !instance_exists(ButtonSwap) instance_create(0, 0, ButtonSwap)
if !instance_exists(ButtonActive) instance_create(0, 0, ButtonActive)
if !instance_exists(ButtonAct) instance_create(0, 0, ButtonAct)

if !instance_exists(JoystickAttack) instance_create(0, 0, JoystickAttack)
if !instance_exists(JoystickMove) instance_create(0, 0, JoystickMove)

random_set_seed(global.seed)

with SubTopCont {
    alarm[0] = 1
}

with Player
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

if instance_exists(Player) {
    with Player {
        if race == 1 && ultra_get(2) { //GUN WARRANT
            infammo = 210
        }

        if race == 10 && ultra_get(1) { // PERSONAL GUARD
            repeat 2 {
                with instance_create(10016, 10016, Ally) {
                    creator = other.id
                }
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

with RadChest {
    var p = instance_random(Player)

    if instance_exists(p) {
        if p.race == 12 {
            instance_create(x, y, RogueChest)
            instance_destroy(id, 0)
            exit
        }

        if GameCont.noradch > 1 {
            if !GameCont.horror {
                instance_create(x, y, HostileHorror)
                snd_play(sndEXPChest)
                GameCont.horror = 1
            }

            instance_destroy(id, 0)
        } else if GameCont.noradch instance_change(RadChestBig, 1)

        if GameCont.horror {
            instance_change(RadChestBig, 1)
        }

        if p.hp < p.max_hp / 2 and rng_random(6, 2) < 1 {
            instance_create(x, y, HealthChest)
            instance_destroy(id, 0)
        }

        if instance_nearest(x - 16, y - 16, Floor).styleb = 1 and GameCont.area = 1 and rng_random(6, 3) < 1 instance_change(RadMaggotChest, true)
    }
}

while instance_number(HealthChest) > 1 {
    with instance_nearest(10016, 10016, HealthChest) {
        instance_destroy()
    }
}

if GameCont.area == 104 {
    with WeaponChest {
        instance_create(x, y, CursedBigChest)
        instance_create(x, y, PortalClear)
        instance_destroy(id, 0)
    }

    with BigWeaponChest {
        instance_create(x, y, CursedBigChest)
        instance_create(x, y, PortalClear)
        instance_destroy(id, 0)
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
            scrWeapons()
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
            scrWeapons()
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
    with instance_nearest(10016 + random_spread(480), 10016 + random_spread(480), IDPDSpawn) {
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

if GameCont.crown == 3 {
    with RadChest {
        instance_create(x, y, HealthChest)
        instance_destroy(id, 0)
    }
}

if UberCont.halloween && GameCont.subarea == 1 && instance_exists(Bandit) {
    snd_play_hit_big(sndHalloweenWolf, 0.2)
}

with BigWeaponChest {
    instance_create(x, y, PortalClear)
}

if GameCont.crown == 9 {
    with chestprop
    if object_index != ProtoChest {
        instance_create(x, y, AmmoChest)
        instance_destroy(id, 0)
    }

    with RadChest {
        instance_create(x, y, AmmoChest)
        instance_destroy(id, 0)
    }

    with WeaponChest {
        instance_create(x, y, AmmoChest)
        instance_destroy(id, 0)
    }
}

if global.hardmode && ((GameCont.loops - global.hardmode) <= 0 && GameCont.area == 1 && GameCont.subarea == 1) {
    with Player {
        instance_create(x, y, BigWeaponChest)
    }
}

with ProtoStatue {
    if UberCont.weekly_run instance_destroy()
}

if GameCont.area == 7 && GameCont.subarea == 3 {
    if UberCont.daily_run && !UberCont.weekly_run {
        scrAchievement(40)
    }
}