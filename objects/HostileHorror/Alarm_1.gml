alarm[1] = (10 + random(10))
scrTarget()
if instance_exists(target) {
    if !collision_line(x, y, target.x, target.y, Wall, 0, 0) || random(6) < 1 {
        if point_distance(target.x, target.y, x, y) > 48 || (random(8) < 1 && raddrop > 0) {
            if random(2 + point_distance(x, y, target.x, target.y) / 100) < 1 {
                if ammo {
                    instance_create(x, y, PortalClear)
                }

                ammo = 30
                gunangle = target_direction
                gunoffset = random(20) - 10
            } else if random(4) < 3 {
                direction = target_direction + (40 + random(60)) * choose(1, - 1)
                speed = 0.4
                walk = 20 + random(10)
                gunangle = target_direction
            }
        } else {
            direction = target_direction
            speed = 0.4
            walk = 20 + random(10)
            gunangle = target_direction
        }
        if target.x < x {
            right = -1
        } else if target.x > x {
            right = 1
        }
    } else if random(4) < 1 {
        motion_add(random_angle, 0.4)
        walk = 20 + random(10)
        if hspeed > 0 {
            right = 1
        } else if hspeed < 0 {
            right = -1
        }
    }
} else if random(10) < 1 {
    motion_add(random_angle, 0.4)
    walk = 20 + random(10)
    alarm[1] = walk + 10 + random(30)
    gunangle = direction
    if hspeed > 0 {
        right = 1
    } else if hspeed < 0 {
        right = -1
    }
}