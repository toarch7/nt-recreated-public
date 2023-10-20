scrTarget()
alarm[1] = (15 + random(5))
if (target > Player) {
    if (collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0) {
        walk = 20
        motion_add(((target_direction + random(90)) - 45), 5)
        if ((point_distance(x, y, target.x, target.y) < 160) && ((point_distance(x, y, target.x, target.y) > 64) && (random(3) < 2))) {
            gunangle = ((target_direction + random(90)) - 45)
            alarm[1] += 30
            alarm[2] = 15
            walk = 6
            ammo = 8
        }
    } else {
        if (random(4) < 1) walk = 20
        motion_add(random_angle, 3)
    }
} else {
    if (random(4) < 1) walk = 20
    motion_add(random_angle, 3)
}
walkdir = direction