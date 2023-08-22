with instance_create(x, y, ChestOpen) {
    if other.curse {
        sprite_index = sprCursedChestOpen
    }
	else if GameCont.underwater {
        sprite_index = sprClamChestOpen
    }
	else sprite_index = sprWeaponChestOpen
}

if GameCont.underwater {
    repeat 12 + random(8) {
        with instance_create(x, y, Bubble) {
            motion_add(random(360), random(2) + 2)
        }
    }
}

instance_create(x, y, FXChestOpen)
