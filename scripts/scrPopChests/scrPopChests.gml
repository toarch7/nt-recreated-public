function scrPopChests() {
    var roll = rng_next_float(6)
    random_set_seed(global.rng_state[6])

    var dir = 0
    var gol = 1
    var wgol = 0
    var agol = 0
    var rgol = 0

    if instance_exists(Player) {
        if skill_get(28) {
            dir = choose(1, 2, 3)
            if dir == 1 wgol = GameCont.openminds
            if dir == 2 agol = GameCont.openminds
            if dir == 3 rgol = GameCont.openminds
        }
    }

    if GameCont.area == 100 {
        if instance_exists(Crown) {
            with instance_furthest(10016, 10016, WeaponChest) {
                instance_create(x, y, ProtoChest)
                instance_destroy(id, 0)
            }
        }

        gol = 0
        wgol = 0
        agol = 0
        rgol = 0
    }

    if (GameCont.area == 0) or((GameCont.area == 107) or(GameCont.area == 106) && GameCont.subarea == 3) {
        gol = 0
        wgol = 0
        agol = 0
        rgol = 0
    }

    if (GameCont.area == 106 or GameCont.area == 7) && GameCont.subarea == 3 {
        rgol = 0
    }

    if instance_exists(WeaponChest) && GameCont.area != 107 {
        do {
            with instance_nearest(10016 + random_spread(250), 10016 + random_spread(250), WeaponChest)
            instance_destroy()
        } until instance_number(WeaponChest) <= gol + wgol

    }

    if instance_exists(RadChest) {
        do {
            with instance_nearest(10016 + random_spread(250), 10016 + random_spread(250), RadChest)
            instance_destroy()
        } until instance_number(RadChest) <= gol + rgol

    } else if instance_number(RadChest) <= rgol && !(GameCont.area == 7 && GameCont.subarea == 3) && GameCont.area < 100 {
        with instance_furthest(10016, 10016, prop) {
            instance_create(x, y, RadChest)
            instance_change(Wind, 0)
        }
    }

    if instance_exists(AmmoChest) {
        do {
            with instance_nearest(10016 + random_spread(250), 10016 + random_spread(250), AmmoChest)
            instance_destroy()
        } until instance_number(AmmoChest) <= gol + agol
    }

    if instance_exists(HealthChest) {
        do {
            with instance_nearest(10016 + random_spread(250), 10016 + random_spread(250), HealthChest)
            instance_destroy()
        } until instance_number(HealthChest) <= gol + rgol

        with RadChest {
            instance_destroy()
        }
    }

    with ChestOpen instance_destroy()
    with FXChestOpen instance_destroy()

    if instance_exists(Player) {
        with AmmoChest {
            if random(11) < 1 && (GameCont.area >= 2 or GameCont.loops) && GameCont.area != 107 {
                instance_create(x, y, Mimic)
                image_speed = 0.4
                instance_change(Wind, Player)
            }
        }

        with WeaponChest {
            if random(4) < GameCont.nochest && GameCont.area != 107 {
                curse = 0
                instance_change(BigWeaponChest, Player)
                event_perform(0, 0)
                exit
            }
        }

        with HealthChest {
            if random(51) < 1 && (GameCont.area >= 2 or GameCont.loops >= 1) {
                instance_create(x, y, SuperMimic)
                image_speed = 0.4
                instance_change(Wind, Player)
            }
        }
		
		with Player {
	        if race != 12
				continue
			
	        with RadChest {
	            instance_destroy(id, 0)
	            instance_create(x, y, RogueChest)
	        }
			
			break
        }
    }
}