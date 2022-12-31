scrTarget()
alarm[1] = 10 + random(30)
if target > 0 {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 {
        direction = target_direction + rng_spread(11, 10)
        speed = 0.4
        walk = 40 + random(10)
        alarm[1] = walk
    } else if random(5) < 1 {
        motion_add(random(360), 0.4)
        walk = 10 + random(15)
        alarm[1] = walk + 10 + random(30)
    }

} else if random(10) < 1 {
    motion_add(random(360), 0.4)
    walk = 10 + random(15)
    alarm[1] = walk + 10 + random(30)
}