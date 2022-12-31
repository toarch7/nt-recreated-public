image_index = image_number - 1
image_speed = 0

if !scr_check_enemies() {
    with Corpse
    alarm[0] = -1

    alarm[0] = 30
}

if position_empty(x, y) {
    var flor = instance_nearest(x, y, Floor)
    x = flor.x + flor.sprite_width / 2
    y = flor.y + flor.sprite_height / 2
}