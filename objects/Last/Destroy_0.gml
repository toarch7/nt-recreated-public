with(MusCont)
alarm[1] = 1

if GameCont.race == 12
	UberCont.ctot_uniq[12] ++

if instance_exists(Player) {
    if GameCont.race == 12 && !UberCont.cskingot[12] {
        show_unlock_popup("@wROGUE B-SKIN UNLOCKED@s#FOR DEFEATING THE CAPTAIN")
        with instance_create(0, 0, UnlockScreen) {
            race = 12;
            skin = 1
        }
		
        UberCont.cskingot[12] = 1
        
		scrAchievement(AchievID.ROGUE_BSKIN)
    }
}

scrAchievement(AchievID.BOSS_CAPTAIN)

with(instance_create(x, y, LastDie)) {
    hit_id = other.hit_id
    team = other.team
}

event_inherited()