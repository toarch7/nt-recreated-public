repeat(2)
scrDrop(200, 0)

event_inherited()

if !instance_exists(WantBoss) {
    if instance_number(BanditBoss) <= 1 with MusCont alarm[1] = 1
}

if !GameCont.loops {
	with Player {
		if race == 10 {
			snd_play(sndMutant10KillBigBandit)
		}
	}
}

if instance_exists(CanOasis) {
    instance_create(x, y, Portal)

    with enemy
    hp = 0

    GameCont.area = 101
    GameCont.subarea = 0
}

scrAchievement(30)