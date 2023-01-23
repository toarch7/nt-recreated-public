alarm[1] = (50 + random(10))
scrTarget()
if (instance_exists(target)) {
    if ((collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0) && ((random(4) < 3) && (point_distance(x, y, target.x, target.y) < 160))) {
        ammo = 10
        alarm[2] = 10
        offset = (random(10) - 5)
        gunangle = (target_direction + offset)
    }
}