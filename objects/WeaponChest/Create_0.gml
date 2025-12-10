event_inherited()

curse = false

if object_index == WeaponChest {
	if (GameCont.crown > 1 && instance_exists(GenCont)) {
		if rng_float(RNGStates.Chest, 7) <= (scrCrownCheck(Crown.Curses) ? 4 : 1) {
			curse = true
	    }
	}
	
	if (GameCont.underwater) sprite_index = sprClamChest
	else if (curse) sprite_index = sprCursedChest
}

