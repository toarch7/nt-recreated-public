scrTarget()
alarm[1] = 5
if instance_exists(target) {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 {
        direction = target_direction + random(20) - 10
        speed = 0.4
        walk = 40 + random(10)
        alarm[1] = walk
    } else if random(5) < 1 {
        motion_add(random_angle, 0.4)
        walk = 10 + random(15)
        alarm[1] = walk + 10 + random(30)
    }

} else if random(10) < 1 {
    motion_add(random_angle, 0.4)
    walk = 10 + random(15)
    alarm[1] = walk + 10 + random(30)
}