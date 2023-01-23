scrTarget()
alarm[1] = 6 + random(5)
if instance_exists(target) {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 {
        walk = 20
        motion_add(target_direction + random(180) - 90, 1.5)
    } else motion_add(random(360), 0.5)
} else motion_add(random(360), 0.5)