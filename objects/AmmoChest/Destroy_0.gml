with instance_create(x, y, ChestOpen) {
	sprite_index = sprAmmoChestOpen
	
	if GameCont.race == 7 && GameCont.ultra == 2 {
		sprite_index = sprAmmoChestSteroidsOpen
	}
}

instance_create(x, y, FXChestOpen)