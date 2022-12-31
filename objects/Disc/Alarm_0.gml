if instance_exists(Player) {
    if point_distance(x, y, Player.x, Player.y) > 24 team = -1
    else alarm[0] = 1
} else team = -1