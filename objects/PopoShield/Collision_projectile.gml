if lockstep_stop
	exit

if image_speed > 0 {
    exit
}

with other {
    if !isset("team") {
        team = 2
    }
}

if team != other.team {
    if other.typ == 1 {
        other.team = team
        other.direction = point_direction(x, y, other.x, other.y)
        other.image_angle = other.direction

        with instance_create(other.x, other.y, Deflect) {
            image_angle = other.direction
        }

        hit_id = sprShielderIdle
    }

    if other.typ = 2 {
        with other {
            instance_destroy()
        }
    }

    snd_play(sndCrystalDeflect)
}