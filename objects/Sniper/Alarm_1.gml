alarm[1] = 20 + random(10)
scrTarget()
if gonnafire = 0 {
    if instance_exists(target) {
        if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 {
            if point_distance(target.x, target.y, x, y) > 96 {
                if random(3) < 2 {
                    snd_play(sndSniperTarget)
                    walk = 0
                    alarm[1] = 40
                    alarm[2] = 30
                    gonnafire = 1
                } else {
                    direction = target_direction + random(160) - 80
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
            motion_add(random_angle, 0.4)
            walk = 20 + random(10)
            alarm[1] = walk + 2 + random(5)
            gunangle = direction
            if hspeed > 0 right = 1
            else if hspeed < 0 right = -1
        }
    } else if random(10) < 1 {
        motion_add(random_angle, 0.4)
        walk = 20 + random(10)
        alarm[1] = walk + 10 + random(30)
        gunangle = direction
        if hspeed > 0 right = 1
        else if hspeed < 0 right = -1
    }
}