event_inherited()
if (charge == 1) {
    instance_create(((x + random(8)) - 4), ((y + 4) + random(4)), Dust)
    motion_add(gunangle, 6)
    speed = 14
} else {
    if (walk > 0) {
        walk -= 1
        motion_add(direction, 2)
        motion_add(gunangle, 1)
    }
    if (speed > 3) speed = 3
}
if ((hp < (max_hp / 2)) && (sndhalfhp == 0)) {
    snd_play(sndLastHalfHP)
    sndhalfhp = 1
}
if ((!instance_exists(Player)) && (sndtaunt == 0)) {
    tauntdelay += 1
    if (tauntdelay > 50) {
        snd_play(sndLastTaunt)
        sndtaunt = 1
    }
}