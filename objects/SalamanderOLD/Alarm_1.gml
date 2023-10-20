alarm[1] = 30 + random(10)
scrTarget()
if instance_exists(target) {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 && distance_to_object(target) <= 96 and random(2) < 1 {
        ammo = 10
        alarm[2] = 1
        gunangle = target_direction - 30
        alarm[1] = 30 + random(5)
    }
    direction = point_direction(target.x, target.y, x, y) + random(30) - 15
    speed = 0.4
    walk = 10 + random(10)

    if target.x < x right = -1
    else if target.x > x right = 1
} else if random(10) < 1 {
    motion_add(random_angle, 0.4)
    walk = 10 + random(10)
    alarm[1] = walk + 10 + random(30)
    if hspeed > 0 right = 1
    else if hspeed < 0 right = -1
}