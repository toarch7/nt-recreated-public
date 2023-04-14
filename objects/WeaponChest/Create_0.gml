if GameCont.area == 0 {
    instance_destroy(id, 0);
    exit
}

event_inherited()

if !(GameCont.area == 7 && GameCont.subarea == 3) && GameCont.nochest {
    if instance_exists(Player) && instance_exists(GenCont) {
        if object_index != BigWeaponChest && !rng_random(6, 3 - GameCont.nochest) && !(GameCont.area == 7 && GameCont.subarea == 3) && GameCont.area != 104 {
            instance_create(x, y, BigWeaponChest)
            instance_destroy(id, 0)
            exit
        }
    }
} else speed = 0

curse = 0

if GameCont.crown > 1 && instance_exists(GenCont) {
    if rng_random(6, 7) <= 1 or(GameCont.crown == 11 && rng_random(6, 7) <= 4) {
        curse = 1
    }
	else curse = 0
}

if curse {
    sprite_index = sprCursedChest
}
else if GameCont.area == 101 {
    sprite_index = sprClamChest
}

if GameCont.race == 7 && GameCont.ultra == 2 {
	sprite_index = curse ? sprCursedChestSteroidsUltra : sprWeaponChestSteroidsUltra
}