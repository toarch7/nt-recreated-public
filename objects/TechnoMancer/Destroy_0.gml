if hp exit

if instance_number(TechnoMancer) <= 1 {
    with MusCont
    alarm[1] = 1

    if instance_exists(Player) {
        scrAchievementUnlock(Achievement.BOSS_TECHNOMANCER)
		scrRaceUnlockSkin(Race.Steroids, 1)
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