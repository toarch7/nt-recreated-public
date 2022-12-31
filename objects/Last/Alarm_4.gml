if (charge == 0) {
    charge = 1
    alarm[4] = 10
    snd_play_hit_big(sndLastMelee, 0)
    snd_play(sndExplosion)
    with(instance_create(x, y, PopoExplosion)) {
        team = other.team
        hit_id = other.spr_idle
    }
    scrTarget()
    if (target) {
        if (target.x < x) right = -1
        else right = 1
        drawspr = sprLastDashStart
        gunangle = ((target_direction + random(30)) - 15)
        motion_add(gunangle, 10)
    }
} else if (charge == 1) {
    drawspr = sprLastDashEnd
    drawimg = 0
    charge = -1
    alarm[5] = 12
}