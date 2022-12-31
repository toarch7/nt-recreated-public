event_inherited();

if walk > 0 {
    walk--motion_add(direction, 0.8)
}

if speed > 3.5 speed = 3.5

if instance_exists(Player) {
    if Player.speed > 0 || hp < max_hp freeze++
    if Player.can_shoot freeze += 3
}

if control {
    with projectile {
        if team == other.team || object_index == EnemyLaser
        continue

        var dir = point_direction(other.x, other.y, x, y)

        if place_free(x + lengthdir_x(2, dir), y) x += lengthdir_x(2, dir)
        if place_free(x, y + lengthdir_y(2, dir)) y += lengthdir_y(2, dir)
    }

    with Player {
        if point_distance(x, y, other.x, other.y) < 160 {
            var dir = point_direction(x, y, other.x, other.y)
            if place_free(x + lengthdir_x(2, dir), y) x += lengthdir_x(2, dir)
            if place_free(x, y + lengthdir_y(2, dir)) y += lengthdir_y(2, dir)
        }
    }

    with Ally {
        if point_distance(x, y, other.x, other.y) < 160 {
            var dir = point_direction(x, y, other.x, other.y)
            if place_free(x + lengthdir_x(2, dir), y) x += lengthdir_x(2, dir)
            if place_free(x, y + lengthdir_y(2, dir)) y += lengthdir_y(2, dir)
        }
    }
}