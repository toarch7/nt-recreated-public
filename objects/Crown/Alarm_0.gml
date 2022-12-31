alarm[0] = 20 + random(20)

if point_distance(x, y, targetx, targety) > 24 + random(48) && random(5) < 4 {
    motion_add(point_direction(x, y, targetx, targety) + random(90) - 45, 2)
    alarm[0] /= 2

    walk = 10 + random(20)
} else if point_distance(x, y, targetx, targety) < 24 && random(5) < 4 {
    motion_add(point_direction(x, y, targetx, targety) + 180 + random(90) - 45, 2)
    walk = 5 + random(20)
} else if random(2) < 1 {
    motion_add(random(360), 2)
    walk = 5 + random(10)
}

if speed > 0 {
    if distance_to_object(enemy) < 48 {
        var dir = instance_nearest(x, y, enemy)

        if instance_exists(dir) {
            motion_add(point_direction(dir.x, dir.y, x, y), 2)
        }
    }

    if instance_exists(Player) {
        var p = instance_nearest(x, y, Player)

        if p {
            motion_add(p.direction, 1)
        }
    }
}