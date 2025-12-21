repeat (2) scrDrop(200, 0)

scrOnBanditKill()

if !instance_exists(WantBoss) && instance_number(BanditBoss) <= 1 {
	with (MusCont) alarm[1] = 1
}

if (!GameCont.loops && scrPlayerCountRace(Race.Rebel)) {
	snd_play(sndMutant10KillBigBandit)
}

if instance_exists(CanOasis) {
    instance_create(x, y, Portal)

    with (enemy) hp = 0

    with GameCont {
		area = area_oasis
		subarea = 0
	}
}

event_inherited()