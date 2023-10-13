if lockstep_stop
	exit

if instance_exists(creator) {
    if sprite_index != spr_disappear {
        with creator {
            if ultra != 2 {
                x = other.x
                y = other.y
                speed = 0
                depth = -4
            }
			else {
                if speed > maxspeed / 2 {
                    speed = maxspeed / 2
                }

                other.x = x
                other.y = y
            }
        }
    }
} else {
    if sprite_index == spr_idle {
        sprite_index = spr_disappear
        image_speed = 0.6
        image_index = 0
    }

    exit
}

time++

if skill_get(5) {
    time++
}

hold = KeyCont.hold_spec[creator.index]

if time >= 60 && sprite_index == spr_idle {
    sprite_index = spr_disappear

    if image_speed < 0
		image_index = 0

    image_speed = 0.6

    if skill_get(5) {
        snd_play(sndCrystalTB)
    }
}
else if !hold && !skill_get(5) {
    sprite_index = spr_disappear

    if image_speed < 0 {
        image_index = 0
    }

    image_speed = 0.6
}