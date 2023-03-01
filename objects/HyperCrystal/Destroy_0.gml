scrDrop(0, 5)
with(MusCont)
alarm[1] = 1

event_inherited()

if instance_exists(Player) {
    if GameCont.race == 11 {
        if !UberCont.cskingot[11] {
            show_unlock_popup("@wHORROR B-SKIN UNLOCKED#@sFOR DEFEATING HYPER CRYSTAL")
			
            with instance_create(0, 0, UnlockScreen) {
                race = 11
                skin = 1
			}
			
            UberCont.cskingot[11] = 1
			
			scrAchievement(AchievID.HORROR_BSKIN)
        }
		
		scrAchievement(AchievID.BOSS_CRYSTAL)
    }
}

scrAchievement(36)

repeat(3)
scrDrop(100, 0)