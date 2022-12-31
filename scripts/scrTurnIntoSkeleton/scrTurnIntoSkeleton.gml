function scrTurnIntoSkeleton() {
    race = 14

    with GameCont {
        level = 1
        rad = 0
        race = 14
        ultra = 0
        ultrapoints = 0
        patient = -10
        ds_list_clear(skills)
    }

    maxspeed = 3
    accuracy = 1.5
    max_hp = 4

    spr_idle = sprMutant14Idle
    spr_walk = sprMutant14Walk
    spr_hurt = sprMutant14Hurt
    spr_dead = sprMutant14Dead
    spr_gosit = sprMutant14GoSit
    spr_sit = sprMutant14Sit

    snd_hurt = sndMutant14Hurt
    snd_dead = sndMutant14Dead
    snd_chst = sndMutant14Chst
    snd_valt = sndMutant14Valt
    snd_wrld = sndMutant14Wrld
    snd_crwn = sndMutant14Crwn
    snd_lowa = sndMutant14LowA
    snd_lowh = sndMutant14LowH

    if GameCont.crown == 2 {
        max_hp--hp = min(max_hp, hp)
        lsthealth = hp
    }

    playerinstance_get(index).race = 14

    ultra = 0
    inframes = 10
    snd_play_hit_big(sndMutant14Turn, 0.2)
    scrWeapons()
}