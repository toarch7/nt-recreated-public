if UberCont.opt_prtcls {
    alarm[0] = 30
    exit
}

alarm[0] = 5 + random(60)

if instance_exists(Player) area = GameCont.area

if area == 5 or UberCont.xmas {
    instance_create(view_xview + random(view_width * 2) - view_width / 2, view_yview + random(view_height * 2) - view_height / 2, SnowFlake)
    alarm[0] = 5

    exit
}

if area == 0 {
    with instance_nearest(view_xview + random(view_width), view_yview + random(view_height), Floor) {
        if place_meeting(x - 32, y, Floor) and place_meeting(x + 32, y, Floor) and place_meeting(x, y - 32, Floor) and place_meeting(x, y + 32, Floor)
        instance_create(x + random(32), y + random(32), WindNight)
    }
}

if area == 1 {
    with instance_nearest(view_xview + random(view_width), view_yview + random(view_height), Floor) {
        if place_meeting(x - 32, y, Floor) and place_meeting(x + 32, y, Floor) and place_meeting(x, y - 32, Floor) and place_meeting(x, y + 32, Floor)
        instance_create(x + random(32), y + random(32), Wind)
    }
}

if area == 2 {
    alarm[0] = 1 + random(120)

    with instance_nearest(view_xview + random(view_width), view_yview + random(view_height), Floor) {
        instance_create(x + random(24) + 8, y + random(24) + 8, Drip)
    }
}

if area == 3 {
    alarm[0] = 1

    repeat 3 {
        instance_create(view_xview + random(view_width * 2) - view_width / 2, view_yview + random(view_height * 2) - view_height / 2, RainDrop)
    }
}

if area == 4 or area == 103 {
    with instance_nearest(view_xview + random(view_width), view_yview + random(view_height), Floor)
    instance_create(x + random(24) + 8, y + random(24) + 8, CaveSparkle)
}

if area == 102 {
    alarm[0] = 1 + random(120)

    with instance_nearest(view_xview + random(view_width), view_yview + random(view_height), Floor) {
        with instance_create(x + random(24) + 8, y + random(24) + 8, Drip) {
            sprite_index = sprCheeseDrip
        }
    }
}