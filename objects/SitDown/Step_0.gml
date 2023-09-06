if lockstep_stop
	exit

if distance_to_object(Player) <= 2 {
    with Player {
        inframes = 30
        bcan_shoot = 0
        can_shoot = 0
        x = other.x
        y = other.y

        if race == 9 && bleed {
            bleed = 0
        }

        angle = 0
        roll = 0
        view_xview = x - view_width / 2
        view_yview = y - view_height / 2
        scrUnlock()
    }

    do_thing = 1
}

if do_thing {
    if !sit {
        if UberCont.daily_run {
            scrSendDailyData()
        }

        GameCont.win = 1

        sit = 1

        with Player {
            visible = 0
            canwalk = 0

            if is_me {
                other.spr_gosit = spr_gosit
                other.spr_sit = spr_sit

                other.weapon = wep_sprt[wep]
                other.bweapon = wep_sprt[bwep]

                if GameCont.tottimer < UberCont.cbst_fast[GameCont.race] {
                    UberCont.cbst_fast[GameCont.race] = GameCont.tottimer
                }
            }
        }

        sprite_index = spr_gosit
        image_speed = 0.4

        alarm[0] = 345
        alarm[1] = 120
        alarm[2] = 10

        if debug {
            alarm[0] = 2
            alarm[1] = 1
            alarm[2] = 1
        }
    }

    with TopCont {
        drawcontrols = 0
    }
}

if force_sit {
    with Player {
        motion_add(point_direction(x, y, other.x, other.y), maxspeed)

        speed = maxspeed
    }
}