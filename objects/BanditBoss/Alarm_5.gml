spr_idle = sprBanditBossIdle
spr_walk = sprBanditBossWalk
spr_hurt = sprBanditBossHurt
spr_dead = sprBanditBossDead
spr_fire = sprBanditBossFire
charge = 0

alarm[1] = 45 + random(30)

if !snd_is_playing(musBoss1) && instance_exists(Player) {
    with MusCont alarm[2] = 1
}

if !intro {
    intro = 1

    if !GameCont.loops {
        scrBossIntro(0)
    }

    snd_play(sndBigBanditIntro)
}