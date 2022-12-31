alarm[1] = 30 + random(20)
scrTarget()
if target > 0 {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 direction = target_direction + random(20) - 10
    else motion_add(random(360), 0.5)
} else motion_add(random(360), 0.5)