scrTarget()
if ((target) && instance_exists(target)) {
    if (target.x < x) right = -1
    else right = 1
    if ((introcharge == 0) || ((random(3) < 1) && ((collision_line(x, y, target.x, target.y, Wall, 0, 0) > 0) || (instance_exists(CrystalShield) || ((point_distance(x, y, target.x, target.y) > 90) && (random(2) < 1)))))) {
        snd_play_hit_big(sndLastMeleeCharge, 0)
        introcharge = 1
        drawspr = sprLastDashStart
        alarm[4] = 10
        alarm[6] = 16
    } else if (((point_distance(x, y, target.x, target.y) > 120) && (random(2) < 1)) || (random(4) < 1)) {
        drawspr = sprLastWarpOut
        drawimg = 0
        alarm[3] = 17
    } else {
        attacktype = choose(0, 1)
        if (attacktype == 0) snd_play_hit_big(sndLastPattern1, 0)
        else snd_play_hit_big(sndLastPattern2, 0)
        gunangle = (target_direction + (choose(1, - 1) * (10 + random(15))))
        drawspr = sprLastSpin
        drawimg = 0
        alarm[5] = 47
        ammo = 30
        alarm[2] = 8
    }
} else if (random(5) < 1) {
    motion_add(random(360), 0.4)
    walk = (10 + random(10))
    alarm[1] = ((walk + 10) + random(30))
    if (hspeed > 0) right = 1
    else if (hspeed < 0) right = -1
}