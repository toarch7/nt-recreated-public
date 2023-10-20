alarm[1] = (10 + random(10))
scrTarget()
if target {
    if !collision_line(x, y, target.x, target.y, Wall, 0, 0) && random(2) < 1 {
        ammo = 8
        alarm[2] = 2
        gunangle = target_direction + random(40) - 20
        alarm[1] = 10 + random(5)
    } else if point_distance(x, y, target.x, target.y) < 120 && random(4) < 3 {
        walk = 50
        gunangle = target_direction + random(20) - 10
        alarm[1] = 50 + random(10)
    } else {
        direction = target_direction + random(160) - 80
        gunangle = direction
        speed = 0.4
        walk = 10 + random(10)
    }

    if target.x < x {
        right = -1
    } else if target.x > x {
        right = 1
    }
} else if random(10) < 1 {
    motion_add(random_angle, 0.4)

    gunangle = direction
    walk = 20 + random(10)
    alarm[1] = walk + 10 + random(30)

    if hspeed > 0 {
        right = 1
    } else if hspeed < 0 {
        right = -1
    }
}