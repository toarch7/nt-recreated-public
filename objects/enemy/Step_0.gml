if lockstep_stop
	exit

if wkick > 0 {
    wkick -= 1
}
else if wkick < 0 {
    wkick += 1
}

if hp <= 0 {
    instance_destroy()
}


if spr_chrg != -1 {
    if sprite_index != spr_hurt && sprite_index != spr_chrg {
        sprite_index = spr_idle
    }

    if sprite_index == spr_hurt or sprite_index == spr_chrg {
        if image_index > 2 {
            sprite_index = spr_idle
        }
    }
} else {
    if spr_fire != -1 {
        if speed <= 0 {
            if sprite_index != spr_hurt && sprite_index != spr_fire {
                sprite_index = spr_idle
            }
        }
		else {
            if sprite_index != spr_hurt && sprite_index != spr_fire {
                sprite_index = spr_walk
            }
        }

        if sprite_index == spr_hurt {
            if image_index > 2 {
                sprite_index = spr_idle
            }
        }
    } else {
        if speed <= 0 {
            if sprite_index != spr_hurt {
                sprite_index = spr_idle
            }
        } else {
            if sprite_index != spr_hurt {
                sprite_index = spr_walk
            }
        }
        if sprite_index == spr_hurt {
            if image_index > 2 {
                sprite_index = spr_idle
            }
        }
    }
}

if inframes
	inframes --

scrTarget()

event_user(0)