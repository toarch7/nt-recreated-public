if hp exit

if instance_number(TechnoMancer) <= 1 {
    with MusCont
    alarm[1] = 1

    if instance_exists(Player) {
        if GameCont.race == 7 && !UberCont.cskingot[7] {
            show_unlock_popup("@wSTEROIDS B-SKIN UNLOCKED@s#FOR DEFEATING THE TECHNOMANCER")
			
            with instance_create(0, 0, UnlockScreen) {
                race = 7
                skin = 1
            }
			
			scrAchievement(AchievID.STEROIDS_BSKIN)
			
            UberCont.cskingot[7] = 1
        }

        scrAchievement(AchievID.BOSS_TECHNOMANCER)
    }

    spr_dead = sprTechnoMancerDead
    snd_dead = sndTechnomancerDestroy
} else spr_dead = sprTechnoMancerDead

with TechnoMancer
alarm[4] = 1

event_inherited()

repeat 2 {
    scrDrop(100, 0)
}