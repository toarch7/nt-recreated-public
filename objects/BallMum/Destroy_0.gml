repeat 2 {
    scrDrop(200, 0)
}

scrAchievement(35)

with Player {
    if string_copy(wep_name[wep], 0, 4) == "GOLD"
    or string_copy(wep_name[bwep], 0, 4) == "GOLD" {
        with instance_create(other.x, other.y, WepPickup) {
            ammo = 0
            wep = 120
            curse = 0
            name = wep_name[wep]
            type = wep_type[wep]
            sprite_index = wep_sprt[wep]
            image_angle = random(360)
        }
    }
}

event_inherited()

with instance_create(x, y, BallMumDeath) {
    image_xscale = other.right
}

if instance_exists(Player) {
    if GameCont.race == 10 {
        if !UberCont.cskingot[10] {
            show_unlock_popup("@wREBEL B-SKIN UNLOCKED#@sFOR DEFEATING BALL MUM")
            
			with instance_create(0, 0, UnlockScreen) {
                race = 10;
                skin = 1
            }
		
	        scrAchievement(AchievID.REBEL_BSKIN)
			
            UberCont.cskingot[10] = 1
        }
		
		scrAchievement(AchievID.BOSS_FROG)
    }
}

with MusCont {
    alarm[1] = 1
}