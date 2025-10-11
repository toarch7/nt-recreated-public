repeat (2) {
    scrDrop(200, 0)
}

with Player {
    if scr_weapon_is_golden(wep) || scr_weapon_is_golden(bwep) {
        with instance_create(other.x, other.y, WepPickup) {
            ammo = 0
            curse = 0
            wep = wep_frog_pistol
            name = wep_name[wep]
            type = wep_type[wep]
            sprite_index = wep_sprt[wep]
            image_angle = random_angle
        }
    }
}

event_inherited()

with instance_create(x, y, FrogQueenDeath) {
    image_xscale = other.right
}

if instance_exists(Player) {
	scrAchievementUnlock(Achievement.BOSS_MOM)
	
	if scrPlayerCountRace(Race.Rebel, true) {
		scrRaceUnlockSkin(Race.Rebel, 1)
	}
}

with MusCont {
    alarm[1] = 1
}