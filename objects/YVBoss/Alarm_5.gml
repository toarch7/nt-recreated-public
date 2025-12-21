/// @description Boss intro

if (!intro) {
    intro = true
    snd_play(sndGunGodIntro)
	scrBossIntro(10)
}

if (!snd_is_playing(musBoss1) && instance_exists(Player)) {
    with (MusCont) alarm[2] = 1
}