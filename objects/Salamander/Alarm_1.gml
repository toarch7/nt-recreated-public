alarm[1] = (10 + random(10))
walk = 0
scrTarget()
if (target > Player) {
    if ((collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0) && (random(2) < 1)) {
        ammo = 45
        alarm[2] = 5
        snd_play_hit_big(sndSalamanderCharge, 0.2)
        gunangle = ((target_direction + random(40)) - 20)
    } else if (random(20) < 1) {
        ammo = 45
        alarm[2] = 5
        snd_play_hit_big(sndSalamanderCharge, 0.2)
        gunangle = random_angle
    } else {
        direction = ((target_direction + random(100)) - 50)
        speed = 0.4
        walk = (40 + random(10))
        alarm[1] += 40
    }
    if (target.x < x) right = -1
    else if (target.x > x) right = 1
} else if (random(10) < 1) {
    motion_add(random_angle, 0.4)
    walk = (10 + random(10))
    alarm[1] = ((walk + 10) + random(30))
    if (hspeed > 0) right = 1
    else if (hspeed < 0) right = -1
}