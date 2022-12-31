if instance_exists(enemy) && instance_exists(Player) {
    if speed > 0 && skill_get(21) {
        dir = instance_nearest(x, y, enemy)

        if point_distance(x, y, dir.x, dir.y) < 24 {
            x = dir.x - hspeed
            y = dir.y - vspeed
        }
    }
}