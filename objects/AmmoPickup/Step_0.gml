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
    if player.ammo[player.wep_type[player.wep]] = player.typ_amax[player.wep_type[player.wep]] or player.ammo[player.wep_type[player.bwep]] = player.typ_amax[player.wep_type[player.bwep]]
    type = choose(1, 2, 3, 4, 5)
    else if player.bwep != 0 type = choose(player.wep_type[player.wep], player.wep_type[player.bwep])
    else type = player.wep_type[player.wep]

    if type = 0 type = choose(1, 2, 3, 4, 5)

    extra = 0
    //RUSH CROWN
    if GameCont.crown = 4 extra = 1

    player.ammo[type] += player.typ_ammo[type] + extra

    if player.ammo[type] > player.typ_amax[type] player.ammo[type] = player.typ_amax[type]


    dir = instance_create(x, y, PopupText)
    dir.mytext = "+" + string(player.typ_ammo[type] + extra) + " " + string(loc(player.typ_name[type]))
    if player.ammo[type] = player.typ_amax[type] dir.mytext = loc_sfmt("MAX %", loc(player.typ_name[type]))


    snd_play(sndAmmoPickup)
    instance_destroy()

    instance_create(x, y, SmallChestPickup)
}