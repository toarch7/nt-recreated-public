alarm[1] = (30 + random(10))
scrTarget()
if (instance_exists(target)) {
    if ((collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0) && (point_distance(x, y, target.x, target.y) < 160)) {
        if (point_distance(x, y, target.x, target.y) > 64) {
            ammo = 4
            alarm[2] = 30
            snd_play_hit_big(sndLaserCrystalCharge, 0.2)
            gunangle = target_direction
            sprite_index = spr_fire
            alarm[1] = (90 + random(10))
        } else if (random(3) < 1) direction = target_direction
        else direction = choose(direction, ((target_direction + 90) + random(180)))
    } else if (random(3) < 1) direction = random(360)
} else if (random(10) < 1) {
    motion_add(random(360), 0.4)
    alarm[1] = (10 + random(30))
}