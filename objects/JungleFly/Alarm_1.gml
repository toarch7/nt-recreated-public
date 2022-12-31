scrTarget()

alarm[1] = 15 + random(5)

if target {
    if !collision_line(x, y, target.x, target.y, Wall, 0, 0) && random(5) > 1 {
        if random(6) < 1 && ammo > 0 && point_distance(x, y, target.x, target.y) > 96 {
            ammo -= 1
            fire = 6
            alarm[2] = 5
            alarm[1] = 30
            rage = 0

            gunangle = target_direction + random(6) - 3
        } else {
            if !rage {
                rage = 1
            }

            direction = target_direction + random(60) - 30
        }
    } else {
        rage = 0
        motion_add(random(360), 1)
    }
} else {
    rage = 0
    motion_add(random(360), 1)
}