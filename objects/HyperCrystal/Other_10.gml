event_inherited()
if (sprite_index != spr_fire) motion_add(direction, 0.5)
if (speed > 1.5) speed = 1.5
if (dist < wantdist) dist += 5
if (dist > wantdist) dist -= 5
if (nospin > 0) {
    x = xprevious
    y = yprevious
    speed = 0
    nospin -= 1
} else {
    angle += 1
    if (fastspin > 0) {
        angle += 20
        fastspin -= 1
    }
}
if (crystals == 1) {
    dir = 0
    repeat cnumber {
        if instance_exists(crystal[dir]) {
            with(crystal[dir]) {
                if (hp > (max_hp / 3)) {
                    x = other.x
                    y = other.y
                    move_contact_solid(other.angle, other.dist)
                }
            }
        }
        dir += 1
        angle += (360 / cnumber)
    }
}
if ((hp < (max_hp / 2)) && (sndhalfhp == 0)) {
    snd_play(sndHyperCrystalHalfHP)
    sndhalfhp = 1
}
if ((hp < (max_hp / 4)) && (sndlowhp == 0)) {
    snd_play(sndHyperCrystalLowHP)
    sndlowhp = 1
}
if ((!instance_exists(Player)) && (sndtaunt == 0)) {
    tauntdelay += 1
    if (tauntdelay > 50) {
        snd_play(sndHyperCrystalTaunt)
        sndtaunt = 1
    }
}