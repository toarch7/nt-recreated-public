with instance_create(x, y, ChestOpen) {
    if other.sprite_index == sprCursedChest {
        sprite_index = sprCursedChestOpen
    }
	else if other.sprite_index == sprClamChest {
        sprite_index = sprClamChestOpen
    }
	else {
		sprite_index = sprWeaponChestOpen
	}
}

instance_create(x, y, FXChestOpen)
