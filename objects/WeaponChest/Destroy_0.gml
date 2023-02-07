with instance_create(x, y, ChestOpen) {
	if GameCont.race == 7 && GameCont.ultra == 2 {
		sprite_index = curse ? sprCursedChestSteroidsUltraOpen : sprWeaponChestSteroidsUltraOpen
		
		break
	}
	
    if other.curse {
        sprite_index = sprCursedChestOpen

        if GameCont.area == 101 {
            sprite_index = sprCursedClamChestOpen
        }
    }
	else if GameCont.area == 101 {
        sprite_index = sprClamChestOpen
    }
	else sprite_index = sprWeaponChestOpen
}

if GameCont.area == 101 {
    repeat 12 + random(8) {
        with instance_create(x, y, Bubble) {
            motion_add(random(360), random(2) + 2)
        }
    }
}

instance_create(x, y, FXChestOpen)