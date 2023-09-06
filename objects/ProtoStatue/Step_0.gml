if lockstep_stop
	exit

if rad > 24 && !charged {
    hp /= 2
    charged = 1

    snd_play(sndStatueCharge)

    repeat 2 {
        instance_create(x, y, IDPDSpawn)
    }
}

if charged {
    canim += 0.4
}

if hp < max_hp * 0.7 && hp > 0 {
    if spr_idle == sprPStat1Idle {
        repeat 2 {
            instance_create(x, y, IDPDSpawn)
        }
    }

    spr_idle = sprPStat2Idle
    spr_hurt = sprPStat2Hurt

    if anim < round(rad / 2) * 3 + 3 && anim < 40 {
        anim += 0.4
    }
}