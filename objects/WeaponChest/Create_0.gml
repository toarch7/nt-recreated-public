event_inherited()

curse = false
spr_dead = sprWeaponChestOpen

if object_index == WeaponChest {
	if (GameCont.crown > 1 && instance_exists(GenCont)) {
		if random(7) <= (scrCrownCheck(Crown.Curses) ? 4 : 1) {
			curse = true
	    }
	}
	if (GameCont.underwater) {
		sprite_index = sprClamChest
		spr_dead = sprClamChestOpen
	}
	else if (curse) {
		sprite_index = sprCursedChest
		spr_dead = sprCursedChestOpen
	}
	else if (scr_ultra_get(Race.Steroids, UltraSkill.Ambidextrous)) {
		sprite_index = sprWeaponChestSteroidsUltra
		spr_dead = sprWeaponChestSteroidsUltraOpen
	}
}

