event_inherited()

if hspeed > 0 {
    right = 1
} else if hspeed < 0 {
    right = -1
}

if speed > 1.5 + GameCont.loops / 2 {
    speed = 1.5 + GameCont.loops / 2
}

if walk {
    if sprite_index != spr_hurt {
        motion_add(direction, 0.6)
    }

    walk--
}

if hp < max_hp / 2 && !sndhalfhp {
    snd_play(sndBallMamaHalfHP)
    sndhalfhp = 1
}

if hp < max_hp / 4 && sndlowhp {
    snd_play(sndBallMamaLowHP)
    sndlowhp = 1
}

if !instance_exists(Player) && !sndtaunt {
    if tauntdelay > 50 {
        snd_play(sndBallMamaTaunt)
        sndtaunt = 1
    }

    tauntdelay++
}