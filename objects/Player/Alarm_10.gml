alarm[10] = 10

try {

    /* if !instance_exists(Cinematic) {
		scrDisableWallTop()
	} */

    if race == 11 && ultra == 2 {
        var _enemy_hp = 0

        with enemy
        if object_index != Van {
            _enemy_hp += hp
        }

        if _enemy_hp <= 150 {
            with enemy hp = 0
        }
    }

    with enemy {
        if !position_meeting(round(x), round(y), Floor) && object_index != Nothing2 && object_index != Nothing && object_index != LilHunter && max_hp < 50 {
            hp = 0
        }
    }

    if UberCont.opt_walls {
        var _l = global.lisUpdateWalls

        for (var i = 0; i < ds_list_size(_l); i++) {
            with _l[| i] {
                visible = place_meeting(x, y + 16, Floor)

                if place_free(x - 16, y) l = 0
                else l = 4

                if place_free(x + 16, y) w = 24 - l
                else w = 20 - l

                if place_free(x, y - 16) r = 0
                else r = 4

                if place_free(x, y + 16) h = 24 - r
                else h = 20 - r

                if !position_meeting(x, y - 16, TopSmall) instance_create(x, y - 16, TopSmall)
                if !position_meeting(x, y + 16, TopSmall) instance_create(x, y + 16, TopSmall)
                if !position_meeting(x - 16, y, TopSmall) instance_create(x - 16, y, TopSmall)
                if !position_meeting(x + 16, y, TopSmall) instance_create(x + 16, y, TopSmall)

                if !position_meeting(x - 16, y - 16, TopSmall) instance_create(x - 16, y - 16, TopSmall)
                if !position_meeting(x + 16, y + 16, TopSmall) instance_create(x + 16, y + 16, TopSmall)
                if !position_meeting(x - 16, y + 16, TopSmall) instance_create(x - 16, y + 16, TopSmall)
                if !position_meeting(x + 16, y - 16, TopSmall) instance_create(x + 16, y - 16, TopSmall)
            }
        }
    }
} catch (e) {
    print(e.message)
}

if string_count("GOLD", wep_name[wep]) && !irandom(2) {
    with instance_create(x + random_spread(10), y + random_spread(10), CaveSparkle) {
        if irandom(1) depth = other.depth - 1
    }
}