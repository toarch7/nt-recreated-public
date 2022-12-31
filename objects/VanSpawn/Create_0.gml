var player = instance_random(Player)

if GameCont.area == 100 || (GameCont.area == 7 && GameCont.subarea == 3) instance_destroy()

if instance_exists(player) {
    dir = 0

    do {
        dir += 1
        x = player.x
        y = player.y
        flip = choose(1, - 1)
        x = (player.x + ((120 + random(96)) * flip))
        y = ((player.y + random(120)) - 60)
        dir = instance_nearest(x, y, Floor)
        x = (dir.x + 16)
        y = (dir.y + 16)
    } until ((point_distance(x, y, player.x, player.y) > 96) || ((dir > 250) && (place_free(x, y) && ((!place_meeting(x, y, Portal)) && (place_meeting(x, y, Floor) && ((!place_meeting(x, y, Van)) && (collision_point(x, y, VanSpawn, 0, 1) < 0)))))));
}

instance_create(x, y, PortalClear)
image_speed = 0.4
alarm[0] = 40 + instance_number(VanSpawn) * 10

if GameCont.area == 101 snd_play(sndOasisPopo)
else snd_play(sndVanWarning)