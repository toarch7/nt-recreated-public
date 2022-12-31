alarm[1] = 10 + random(5)

scrTarget()
if target > 0 {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 {
        if point_distance(target.x, target.y, x, y) > 48 {
            if random(2) < 1 && distance_to_object(target) <= 96 {
                snd_play(sndEnemyFire)
                wkick = 4
                gunangle = target_direction
                ammo = 6
                alarm[2] = 1
                alarm[1] = 20 + random(5)
            } else {
                direction = target_direction + random(180) - 90
                speed = 0.4
                walk = 10 + random(10)
                gunangle = target_direction
            }

        } else {
            direction = point_direction(target.x, target.y, x, y) + random(20) - 10
            speed = 0.4
            walk = 40 + random(10)
            gunangle = target_direction
        }

        if target.x < x right = -1
        else if target.x > x right = 1
    } else if random(4) < 1 {
        motion_add(random(360), 0.4)
        walk = 20 + random(10)
        alarm[1] = walk + 10 + random(30)
        gunangle = direction
        if hspeed > 0 right = 1
        else if hspeed < 0 right = -1
    }
} else if random(10) < 1 {
    motion_add(random(360), 0.4)
    walk = 20 + random(10)
    alarm[1] = walk + 10 + random(30)
    gunangle = direction
    if hspeed > 0 right = 1
    else if hspeed < 0 right = -1
}