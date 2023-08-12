event_inherited()

curse = 0

if GameCont.crown > 1 && instance_exists(GenCont) {
    if rng_random(6, 7) <= 1 or (GameCont.crown == 11 && rng_random(6,7) <= 4) {
        curse = 1
    }
	else curse = 0
}

if GameCont.underwater {
    sprite_index = sprClamChest
}

if curse {
	sprite_index = sprCursedChest
}

