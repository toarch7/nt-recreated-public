event_inherited()

if hp < (max_hp * .7) && !sndhalfhp {
    snd_hurt = sndNothingHurtMid
    snd_play(sndNothingMidHP)
    sndhalfhp = 1
}

if hp < (max_hp * 0.4) && sndhalfhp == 1 {
    snd_hurt = sndNothingHurtLow
    snd_play(sndNothingLowHP)
    sndhalfhp = 2
}

with enemy {
    if id != other.id && object_index != Guardian {
        instance_destroy()
    }
}

with Portal {
    instance_destroy()
}

if walk && instance_exists(Player) {
    if BackCont.shake < 3 {
        BackCont.shake = 3
    }

    if !(sprite_index == spr_hurt && image_index < 1) {
        y += 1
    }

    motion_add(walkdir, 2)

    if speed > 4 {
        speed = 4
    }

    walk--
} else if speed > 1 speed = 1

dmg++

if sprite_index == spr_hurt {
    dmg = 0
}

if !instance_exists(Player) && !sndtaunt {
    tauntdelay += 1

    if tauntdelay > 150 {
        snd_play(sndNothingTaunt)
        sndtaunt = 1
    }
}