if image_index < 1 image_index += random(0.04)
else image_index += 0.4

if !irandom(3) {
    with instance_create(x, y, Curse) {
        hspeed = random_spread(1)
    }
}

if instance_exists(Player) {
    if instance_exists(Portal) {
        if place_free(x + lengthdir_x(6, point_direction(x, y, Player.x, Player.y)), y) x += lengthdir_x(6, point_direction(x, y, Player.x, Player.y))
        if place_free(x, y + lengthdir_y(6, point_direction(x, y, Player.x, Player.y))) y += lengthdir_y(6, point_direction(x, y, Player.x, Player.y))
    }
}