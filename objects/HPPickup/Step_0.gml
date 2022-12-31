if image_index < 1 image_index += random(0.04)
else image_index += 0.4

var player = instance_nearest(x, y, Player)

if instance_exists(player) {
    if point_distance(x, y, player.x, player.y) < 32 + (skill_get(3) * 64) or instance_exists(Portal) {
        if place_free(x + lengthdir_x(6, point_direction(x, y, player.x, player.y)), y) x += lengthdir_x(6, point_direction(x, y, player.x, player.y))
        if place_free(x, y + lengthdir_y(6, point_direction(x, y, player.x, player.y))) y += lengthdir_y(6, point_direction(x, y, player.x, player.y))
    }
}

if instance_exists(player) && place_meeting(x, y, Portal) {
    num = 2
    if skill_get(9) num = 4

    instance_create(x, y, HealFX)

    //RUSH CROWN
    if GameCont.crown = 4 num += 1

    instance_destroy()
    player.hp += num
    if player.hp > player.max_hp player.hp = player.max_hp


    dir = instance_create(x, y, PopupText)
    dir.mytext = "+" + string(num) + " HP"
    if player.hp = player.max_hp dir.mytext = "MAX HP"

    instance_create(x, y, SmallChestPickup)
    snd_play(sndHPPickup)
}